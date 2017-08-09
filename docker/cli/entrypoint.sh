#!/bin/sh
export DOCKER_USER="neoauto"
export ORIG_PASSWD=$(cat /etc/passwd | grep $DOCKER_USER)
export ORIG_UID=$(echo $ORIG_PASSWD | cut -f3 -d:)
export ORIG_GID=$(echo $ORIG_PASSWD | cut -f4 -d:)

export DEV_UID=${DEV_UID:=$ORIG_UID}
export DEV_GID=${DEV_GID:=$ORIG_GID}
export BASE_DIR=/apps

export COMPOSER_HOME=/composer
export PATH=/composer/vendor/bin:$PATH

ORIG_HOME=$(echo $ORIG_PASSWD | cut -f6 -d:)
sed -i -e "s/:$ORIG_UID:$ORIG_GID:/:$DEV_UID:$DEV_GID:/" /etc/passwd
sed -i -e "s/$DOCKER_USER:x:$ORIG_GID:/$DOCKER_USER:x:$DEV_GID:/" /etc/group

cp -r /bin/ $BASE_DIR/bin/
cp  /php-git-hooks.yml $BASE_DIR/php-git-hooks.yml

chown $DOCKER_USER:$DOCKER_USER $ORIG_HOME
chown $DOCKER_USER:$DOCKER_USER $BASE_DIR


su - $DOCKER_USER -c "
    cd $BASE_DIR && $*
"
