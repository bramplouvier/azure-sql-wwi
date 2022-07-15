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
