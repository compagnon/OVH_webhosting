#!/bin/bash
## Usage: fullbackup.sh [options]
## Options:
##   nb de fichiers tournants
##   -h, --help    Display this message.
##   -n            Dry-run; only show what would be done.
#
# @(#)$Id$
#
# utilitaire pour faire un backup tournant du site webhosting OVH (a mettre en cron)
DEFAULT_FILES_NB=10

usage() {
  [ "$*" ] && echo "$0: $*"
  sed -n '/^##/,/^$/s/^## \{0,1\}//p' "$0"
  exit 2
} 2>/dev/null

main() {
declare -i FILES_NB=$DEFAULT_FILES_NB
    case $1 in
    (-h|--help) usage 2>&1;;
    (-n) DRY_RUN=1;;
    (--) shift; break;;
    (-*) usage "$1: unknown option";;
    (*) FILES_NB=$1;;
    esac

if [ -z ${FILES_NB+x} ] || [ ${FILES_NB} -le 0 ];
then
 FILES_NB=$DEFAULT_FILES_NB;
fi

echo "script version"
stat -c %y $0

echo "current path"
pwd
echo "Archivage de l ensemble des fichiers sur le ~"
echo "$FILES_NB archives possibles en mode tournant: le plus vieux supprimé"

DATE=`date +%Y-%m-%d-%H%M%S`
declare -i count=0
for fn in `ls -Rt backup/*_backup.tar.gz` ; do
   count=$count+1
   if [ ${count} -ge ${FILES_NB} ];
   then
      echo Suppression du fichier le plus ancien: $fn
      rm -f $fn 
   fi
done;

mkdir -p backup
echo tar cpPfz backup/${DATE}_backup.tar.gz  --exclude "bin" --exclude "backup" .
tar cpPfz backup/${DATE}_backup.tar.gz  --exclude "bin" --exclude "backup" .
echo "fin pour date $DATE" 
}

main "$@"
