#printenv

export wwiUrl="https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Standard.bacpac"

mkdir -p "bacpacs"
wget -P "./bacpacs" $wwiUrl

ACCOUNT_KEY=$(az storage account keys list \
    --resource-group rg-azure-wwi-test \
    --account-name stordb2h35j3ll5 | jq '.[0].value')

az storage blob upload-batch \
    --source "bacpacs" \
    --destination "bacpacs" \
    --overwrite

az sql db import \
        --admin-password $administratorLoginPassword \
        --admin-user $administratorLogin \
        --storage-key $ACCOUNT_KEY \
        --storage-key-type StorageAccessKey \
        --storage-uri https://$storageAccountName.blob.core.windows.net/bacpacs/WideWorldImporters-Standard.bacpac \
        --name wwi \
        --auth-type SQL \
        --resource-group $resourceGroup \
        --server $sqlServerName
