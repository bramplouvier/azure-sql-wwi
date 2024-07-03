#printenv
#Install curl
echo "Installing curl"
apk add curl 

cd /tmp
# Install sqlpackage tool
SQLPACKAGE_DIR=/tmp/sqlpackage
mkdir $SQLPACKAGE_DIR
echo "Downloading SqlPackage from https://aka.ms/sqlpackage-linux"
curl -L -o /tmp/sqlpackage.zip https://aka.ms/sqlpackage-linux -q
echo "Unpacking SqlPackage"
unzip /tmp/sqlpackage.zip -q -d $SQLPACKAGE_DIR 
chmod +x $SQLPACKAGE_DIR/sqlpackage

echo "Downloading bacpacs from $bacpacUrl"
DOWNLOAD_RESPONSE1=$(curl -L -o "master.dacpac" -w "%{response_code}" $masterDacpacUrl)
DOWNLOAD_RESPONSE2=$(curl -L -o "$databaseName.dacpac" -w "%{response_code}" $dbDacpacUrl)
if [ "$DOWNLOAD_RESPONSE1" != "200" ] || [ "$DOWNLOAD_RESPONSE1" != "200" ]; then
    echo "Download failed"
    echo "URL: $masterDacpacUrl, Result: $DOWNLOAD_RESPONSE1"
    echo "URL: $dbDacpacUrl, Result: $DOWNLOAD_RESPONSE2"
else
    # example publish from Azure SQL Database using SQL authentication and a connection string
    $SQLPACKAGE_DIR/sqlpackage /Action:Publish /SourceFile:/tmp/$databaseName.dacpac \
      /TargetConnectionString:"Server=tcp:$sqlServerName.database.windows.net,1433;Initial Catalog=$databaseName;Persist Security Info=False;User ID=$administratorLogin;Password=$administratorLoginPassword;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
fi

