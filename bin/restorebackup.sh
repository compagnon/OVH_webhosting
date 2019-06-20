#!/bin/bash
## Usage: restorebackup.sh
#
# @(#)$Id$
#
# utilitaire pour restaurer à partir du fichier backup placé à la racine(a declencher en cas de besoin)


echo "script version"
stat -c %y $0

echo "current path"
pwd
echo "restauration de l ensemble des fichiers sur le ~"
echo "$FILES_NB archives possibles en mode tournant: le plus vieux supprimé"

FILE_TO_RESTORE=""
DATE=`date +%Y-%m-%d-%H%M%S`

for fn in `find *_backup.tar.gz -maxdepth 1 -type f -printf "%T@ %p\n"  | sort --reverse |  sed -E 's/^[0-9]+\.[0-9]+ //g'` ; do
   FILE_TO_RESTORE=$fn
   break;
done;

if [ "$FILE_TO_RESTORE" != "" ]
then 
echo tar xpPfz $FILE_TO_RESTORE  .
tar xpPfz $FILE_TO_RESTORE  .

mkdir -p backup
mv $FILE_TO_RESTORE backup/${FILE_TO_RESTORE}_restored_${DATE}
fi

echo "fin pour date $DATE" 

