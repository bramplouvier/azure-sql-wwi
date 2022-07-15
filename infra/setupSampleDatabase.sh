printenv

#export WWI_URL="https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Standard.bacpac"

#mkdir -p "bacpacs"

#if [[ ! -f "bacpacs/$WWI_FILE" ]];
#then
#    curl -o "bacpacs/$WWI_FILE" -L $WWI_URL
#fi 

#az storage blob upload-batch \
#    --source "bacpacs" \
#    --destination "bacpacs" \
#    --account-key $STKEY \
#    --account-name $STACC \
#    --overwrite
