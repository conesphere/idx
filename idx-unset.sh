#!/bin/bash
########################################################
# This one sets an info to a file like a tag or a name #
alias errcho='>&2 echo'
name=${1}
shift
while read id
do
	loc=${HOME}/.idx_data/${id}
	#loc=dbg
	if [[ ! -d ${loc} ]]
	then
		errcho "ID ${id} is not indexed, skipping!"
		continue
	fi
	if [[ ! -f ${loc}/${name} ]]
	then 
		# we dont have to check if there are no tags yet 
		for value in $@
		do
			echo ${value} >> ${loc}/${name}
		done
	else
		( 
			declare -A temp
			
			output=()
			
			for s in "${@}"
			do
				((temp[${s}]++))
			done

			while read s
			do 
				if [[ -n ${temp[${s}]} ]]
				then
					output=("${output[@]}" "${s}")
				else
			done

			(
				for value in "${output[@]}" 
				do
					echo ${value}
				done
			) > ${loc}/${name}
		) < ${loc}/${name} 
	fi
	echo ${id}
done

