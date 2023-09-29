## Create MariaDB Persistent database
##oc new-app --template=mariadb-persistent --param DATABASE_SERVICE_NAME=rsalbums --param MYSQL_USER=rsalbums --param MYSQL_PASSWORD=rsalbums --param MYSQL_DATABASE=rsalbums --param MYSQL_ROOT_PASSWORD=rsalbums

## Get name of pod into environment variable
export PODNAME=$(oc get pods -o custom-columns=POD:.metadata.name --no-headers | grep -v 'deploy$' | grep countries)
echo $PODNAME

## Upload file(s) to create and populate table(s)
Write-Output "Copying files to pod"
oc cp .\countries.csv $PODNAME:/tmp/countries.csv

#### Execute command(s) in pod to create table(s)
Write-Output "Creating tables"
oc cp .\create_table_countries.sql $PODNAME:/tmp/create_table_countries.sql
oc cp .\create_table_countries.sh $PODNAME:/tmp/create_table_countries.sh
oc exec $PODNAME -- /bin/bash /tmp/create_table_countries.sh

Write-Output "Populating tables"
oc cp .\populate_table_countries_POWERSHELL.sql $PODNAME:/tmp/populate_table_countries_POWERSHELL.sql
oc cp .\populate_table_countries_POWERSHELL.sh $PODNAME:/tmp/populate_table_countries_POWERSHELL.sh
oc exec $PODNAME -- /bin/bash /tmp/populate_table_countries_POWERSHELL.sh

# Prove it
Write-Output "Proof query"
oc cp .\proof_query.sql $PODNAME:/tmp/proof_query.sql
oc cp .\proof_query.sh $PODNAME:/tmp/proof_query.sh
oc exec $PODNAME -- /bin/bash /tmp/proof_query.sh
