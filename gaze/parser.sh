#!/bin/sh

# ${1} directory of files to parse. e.g. /home/sergi/Desktop/MSc

mkdir ${1}/gaseDirectory

for i in `ls ${1}`
do
	if [ -d ${1}/$i ]
	then
    		echo "$i is a directory"
	else
		echo "Processing ${1}/$i file..."
		filename=$(basename "$i" .tsv)
		awk -F'\t' '{if(NR>1){if($48!="" && $49!=""){{print($26" "$48" "$49);}}}}' ${1}/$i >  ${1}/gaseDirectory/${filename}.txt
	fi
done
