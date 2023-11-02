## Part of the Red Hat Developer learning path entitled "Using Red Hat OpenShift labels"


## Create MariaDB Persistent database

`oc new-app --template=mariadb-persistent --param DATABASE_SERVICE_NAME=countries --param MYSQL_USER=countries --param MYSQL_PASSWORD=countries --param MYSQL_DATABASE=countries --param MYSQL_ROOT_PASSWORD=countries`

## Get name of pod into environment variable
### PowerShell
`(kubectl get pods | select-string '^countries([^\s]+)-(?!deploy)') -match 'countries([^\s]+)'; $podname = $matches[0]`



## Upload file(s) to create and populate table(s)
### PowerShell
`oc cp .\create_table_countries.sql ${podname}:/tmp/create_table_countries.sql`  

`oc cp .\create_table_countriestracks.sql ${podname}:/tmp/create_table_countriestracks.sql`  

`oc cp .\create_table_countries.sh ${podname}:/tmp/create_table_countries.sh`  

`oc cp .\create_table_countriestracks.sh ${podname}:/tmp/create_tablecountries_tracks.sh`  

`oc cp .\countries.csv ${podname}:/tmp/countries.csv`

`oc cp .\countriestracks.csv ${podname}:/tmp/countriestracks.csv`

`oc cp .\populate_table_countries_POWERSHELL.sql ${podname}:/tmp/populate_table_countries_POWERSHELL.sql`

`oc cp .\populate_table_countries_POWERSHELL.sh ${podname}:/tmp/populate_table_countries_POWERSHELL.sh`

#### Execute command(s) in pod to create table(s)
`oc exec ${podname} -- /bin/bash /tmp/create_table_countries.sh`
`oc exec ${podname} -- /bin/bash /tmp/create_table_countriestracks.sh`

`oc exec ${podname} -- /bin/bash /tmp/populate_table_countries_POWERSHELL.sh`


`oc exec ${podname} -- /bin/bash /tmp/populate_table_countries_POWERSHELL.sh`

`oc cp .\populate_table_countriestracks_POWERSHELL.sql ${podname}:/tmp/populate_table_countriestracks_POWERSHELL.sql`

`oc cp .\populate_table_countriestracks_POWERSHELL.sh ${podname}:/tmp/populate_table_countriestracks_POWERSHELL.sh`

`oc exec ${podname} -- /bin/bash /tmp/populate_table_countriestracks_POWERSHELL.sh`

`oc cp .\proof_query.sql ${podname}:/tmp/proof_query.sql`

`oc cp .\proof_query.sh ${podname}:/tmp/proof_query.sh`

`oc exec ${podname} -- /bin/bash /tmp/proof_query.sh`




#### Upload JSON file (cotaining data) to pod

#### Import data into database tables

#### Run query to prove success