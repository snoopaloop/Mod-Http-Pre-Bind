#!/bin/sh
EJABBERD_DIR='./'
USAGE="USAGE: ./build.sh -i [ejabberd_dir] (ejabberd_dir is the ejabberd base path - compiled or source)"

if [ $# -lt 2 ]; then
	echo $USAGE
	exit 1
fi

while getopts i: option
	do
		case $option in
			i)
			EJABBERD_DIR=$OPTARG
			;;
			?)
			echo $USAGE ; exit 1
			;;
		esac
	done

if ! test -d $PWD/ebin; then
	mkdir $PWD/ebin
fi

BUILD_CMD="erlc -I $EJABBERD_DIR/lib \
-I $EJABBERD_DIR/lib/ejabberd/include \
-I $EJABBERD_DIR/lib/ejabberd/include/web \
-I $EJABBERD_DIR/src \
-I $EJABBERD_DIR/src/web \
-o $PWD/ebin $PWD/src/web/*.erl"

RES=`${BUILD_CMD}`

echo $RES
if `echo ${RES} | grep "Warning: behaviour gen_mod undefined" 1>/dev/null 2>&1`
then
  echo "\nCongrats!\n.beam files are now in the ebin directory. Please copy to the ejabberd/lib/ejabberd/ebin directory\n"
else
  echo "\nSome error has occurred: ${RES}\n"
fi



