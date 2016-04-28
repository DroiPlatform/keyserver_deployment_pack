#!/bin/bash

PATH_CONF=`pwd`/conf/key.conf
PATH_KLV=`pwd`/KLV
#PATH_KF_PREFIX=/home/nvme/key_db/bkey.4294967296.
PATH_KF_PREFIX=/ramfs/data/keydb/aes/bkey.65536.

#******
# get KLV
#******
get_klv(){
  KLV=$(cat $PATH_KLV)
}

update_klv(){
  NKLV=$(($KLV + 1))
  #echo "sed -i -e \"s/KL_VERSION = $KLV/KL_VERSION = $NKLV/g\" $PATH_CONF"
  sed -i -e "s/KL_VERSION = $KLV/KL_VERSION = $NKLV/g" $PATH_CONF
  echo $NKLV > $PATH_KLV
}

mv_kfile(){
  SKLV=$(($KLV - 1))
  SFILE=$PATH_KF_PREFIX$SKLV
  TKLV=$(($KLV + 1))
  TFILE=$PATH_KF_PREFIX$TKLV
  #echo $SFILE $TFILE
  mv $SFILE $TFILE
}


get_klv
update_klv
mv_kfile

