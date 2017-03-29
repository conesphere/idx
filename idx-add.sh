#!/bin/bash
##############################################
# This one adds a pdf file to the repository #
file=${1}
shift
if [[ ! -f ${file} ]]
then
	echo File ${file} does not exist
	exit 1
fi
id=$(sha256sum -b ${file})
id=${id% *}
echo document id is ${id}
loc=${HOME}/.idx_data/${id}
if [[ -d ${loc} ]]
then
	echo Document ${loc} already exist in repository 
	echo  use idx-upd to add this document 
fi
mkdir -p ${loc}
mv ${file} ${loc}/data
ln -s ${loc}/data ${file}
# do basename just in case
file=${file##*/}
# save name
echo ${file} >> ${loc}/name
# save document tags
for t in $@
do
	echo ${t} >> ${loc}/tag
done
date '+%Y-%m-%d %H:%M:%S' > ${loc}/date_add

