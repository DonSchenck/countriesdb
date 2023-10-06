## Create MariaDB Persistent database
##oc new-app --template=mariadb-persistent --param DATABASE_SERVICE_NAME=rsalbums --param MYSQL_USER=rsalbums --param MYSQL_PASSWORD=rsalbums --param MYSQL_DATABASE=rsalbums --param MYSQL_ROOT_PASSWORD=rsalbums

echo 'Waiting for pod to be available...'
sleep 20


echo 'Get name of pod into environment variable...'
export PODNAME=$(oc get pods -o custom-columns=POD:.metadata.name --no-headers | grep -v 'deploy$' | grep countries)
echo $PODNAME

echo "Copying files to pod..."
oc cp countries.csv $PODNAME:/tmp/countries.csv

#### Execute command(s) in pod to create table(s)
echo "Creating tables..."
oc cp create_table_countries.sql $PODNAME:/tmp/create_table_countries.sql
oc cp create_table_countries.sh $PODNAME:/tmp/create_table_countries.sh
oc exec $PODNAME -- /bin/bash /tmp/create_table_countries.sh

echo "Populating tables..."
oc cp populate_table_countries_BASH.sql $PODNAME:/tmp/populate_table_countries_BASH.sql
oc cp populate_table_countries_BASH.sh $PODNAME:/tmp/populate_table_countries_BASH.sh
oc exec $PODNAME -- /bin/bash /tmp/populate_table_countries_BASH.sh

# Prove it
echo "Proof query..."
oc cp proof_query.sql $PODNAME:/tmp/proof_query.sql
oc cp proof_query.sh $PODNAME:/tmp/proof_query.sh
oc exec $PODNAME -- /bin/bash /tmp/proof_query.sh

echo 'FINISHED'
