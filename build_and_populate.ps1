## Create MariaDB Persistent database
##oc new-app --template=mariadb-persistent --param DATABASE_SERVICE_NAME=countries --param MYSQL_USER=countries --param MYSQL_PASSWORD=countries --param MYSQL_DATABASE=countries --param MYSQL_ROOT_PASSWORD=countries

## Get name of pod into environment variable
### PowerShell
(kubectl get pods | select-string '^countries([^\s]+)-(?!deploy)') -match 'countries([^\s]+)'; $podname = $matches[0]

## Upload file(s) to create and populate table(s)
### PowerShell
Write-Output "Copying files to pod"
oc cp .\countries.csv ${podname}:/tmp/countries.csv

#### Execute command(s) in pod to create table(s)
Write-Output "Creating tables"
oc cp .\create_table_countries.sql ${podname}:/tmp/create_table_countries.sql
oc cp .\create_table_countries.sh ${podname}:/tmp/create_table_countries.sh
oc exec ${podname} -- /bin/bash /tmp/create_table_countries.sh

Write-Output "Populating tables"
oc cp .\populate_table_countries_POWERSHELL.sql ${podname}:/tmp/populate_table_countries_POWERSHELL.sql
oc cp .\populate_table_countries_POWERSHELL.sh ${podname}:/tmp/populate_table_countries_POWERSHELL.sh
oc exec ${podname} -- /bin/bash /tmp/populate_table_countries_POWERSHELL.sh

# Prove it
Write-Output "Proof query"
oc cp .\proof_query.sql ${podname}:/tmp/proof_query.sql
oc cp .\proof_query.sh ${podname}:/tmp/proof_query.sh
oc exec ${podname} -- /bin/bash /tmp/proof_query.sh
