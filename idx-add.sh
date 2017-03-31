#!/bin/bash
##############################################
# This one adds a pdf file to the repository #
alias errcho='>&2 echo'
while read file
do
	if [[ ! -f ${file} ]]
	then
		errcho "File ${file} does not exist skipping"
		continue
	fi
	id=$(sha256sum -b ${file})
	id=${id% *}
	loc=${HOME}/.idx_data/${id}
	if [[ -d ${loc} ]]
	then
		if [[ -f ${loc}/data ]]
		then
			errcho "File ${file} is already indexed updating record"
			rm -f ${file}
		else
			errcho "File ${file} is already indexed but data missing, readd data"
			mv ${file} ${loc}/data
		fi
	else
		mkdir -p ${loc}
		mv ${file} ${loc}/data
	fi
	ln -s ${loc}/data ${file}
	# do basename just in case
	file=${file##*/}
	# save name
	# TODO create a save file ADD here 
	echo ${file} >> ${loc}/name
	if [[ ! -f ${loc}/date_add ]]
	then
		date '+%Y-%m-%d %H:%M:%S' > ${loc}/date_add
	fi
	echo ${id}
done

