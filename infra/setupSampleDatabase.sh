#printenv

export wwiUrl="https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Standard.bacpac"

mkdir -p "bacpacs"
wget -P "./bacpacs" $wwiUrl

az storage blob upload-batch \
    --source "bacpacs" \
    --destination "bacpacs" \
    --account-key $storageAccountKey \
    --account-name $storageAccountName \
    --overwrite

# Use timeout to prevent deployment from waiting on import
timeout 10 az sql db import \
        --admin-password $administratorLoginPassword \
        --admin-user $administratorLogin \
        --storage-key $storageAccountKey \
        --storage-key-type StorageAccessKey \
        --storage-uri https://$storageAccountName.blob.core.windows.net/bacpacs/WideWorldImporters-Standard.bacpac \
        --name wwi \
        --auth-type SQL \
        --resource-group $resourceGroup \
        --server $sqlServerName

RC=$?
if [[ $RC -eq 124 ]]; then
  exit 0
else
  exit $RC
fi
