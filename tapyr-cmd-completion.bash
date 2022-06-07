#/usr/bin/env bash
#to use this script source it : source tapyr_completion.bash or copy it in /etc/bash_completion.d/

_comp_xls()
{
  local IFS=$'\n'

  COMP_WORD=$2

  if [ "$COMP_WORD" == "" ]; then
     COMPREPLY="/root/"
     return 
  fi 

  #if dirname is / we return root (is that possible we remove / before ? 
  if [ "$COMP_WORD" == "/" ]; then
    COMPREPLY="/root/"
    return 
  fi 

  #if there is a "/" at end of the directory we remove it
  #to get the dirname without /  
  if [ "${COMP_WORD: -1}" == "/" ]; then
    DIRNAME="${COMP_WORD::-1}"
  fi

  #must use full path to complete or it will not work as it compare full path node path 
  #we eval to remove quote and escape character for directory with path as we use "filenames" 
  #option that add escape character to completed value
  COMPLETION_LIST="$(./xls -f `eval echo $DIRNAME`)"
  #compgen write possible completion to the console
  COMPREPLY=($(compgen -o filenames -W '$COMPLETION_LIST' -- $COMP_WORD))
}

complete -o filenames -o nospace  -F _comp_xls xls
complete -o filenames -o nospace  -F _comp_xls xcat
complete -o filenames -o nospace  -F _comp_xls xattr
complete -o filenames -o nospace  -F _comp_xls xdownload
