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
    
#sleep 5

#az sql db import \
#        --admin-password $administratorLoginPassword \
#        --admin-user $administratorLogin \
#        --storage-key $storageAccountKey \
#        --storage-key-type StorageAccessKey \
#        --storage-uri https://$storageAccountName.blob.core.windows.net/bacpacs/WideWorldImporters-Standard.bacpac \
#        --name wwi \
#        --auth-type SQL \
#        --resource-group $resourceGroup \
#        --server $sqlServerName

#echo "done"
#return 1
