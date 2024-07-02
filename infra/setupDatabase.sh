#printenv

# Install sqlpackage tool
SQLPACKAGE_DIR=./sqlpackage
mkdir $SQLPACKAGE_DIR
wget https://aka.ms/sqlpackage-linux -O /tmp/sqlpackage.zip
unzip /tmp/sqlpackage.zip -d $SQLPACKAGE_DIR
chmod +x $SQLPACKAGE_DIR/sqlpackage

DOWNLOAD_RESPONSE=$(curl -s -o "$databaseName.bacpac" -w "%{response_code}" $bacpacUrl)
if [ "$DOWNLOAD_RESPONSE" != "200" ]; then
    echo "Download failed with code $DOWNLOAD_RESPONSE"
    echo "URL: $bacpacUrl"
else
    ACCOUNT_KEY=$(az storage account keys list \
        --resource-group $resourceGroup \
        --account-name $storageAccountName | jq --raw-output '.[0].value')

    az storage blob upload \
        --account-name $storageAccountName \
        --container-name bacpacs \
        --name "${databaseName}.bacpac" \
        --file "${databaseName}.bacpac" \
        --auth-mode login

    az sql db import \
            --admin-password $administratorLoginPassword \
            --admin-user $administratorLogin \
            --storage-key $ACCOUNT_KEY \
            --storage-key-type StorageAccessKey \
            --storage-uri "https://$storageAccountName.blob.core.windows.net/bacpacs/$databaseName.bacpac" \
            --name $databaseName \
            --auth-type SQL \
            --resource-group $resourceGroup \
            --server $sqlServerName
fi

