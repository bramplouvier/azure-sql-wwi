#printenv

az login

curl -L -o "$databaseName.bacpac" $bacpacUrl > /dev/null

ACCOUNT_KEY=$(az storage account keys list \
    --resource-group $resourceGroup \
    --account-name $storageAccountName | jq '.[0].value')

az storage blob upload-batch \
    --source "database.bacpac" \
    --destination "bacpacs" \
    --overwrite

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
