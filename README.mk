# IDX Index

idx is an extensible indexing and search engine for pdf and other static 
documents written in BASH

#Installation

to /usr/local:
'$ make install'

to your $HOME: 
`$ PREFIX=~ EXTDIR=.idx-extensions install`


#Usage

An idx call typically has the form `idx COMMAND` 

idx make use of unix pipes, so an idx command usually returns either a list of 
sha256sums (used as document IDs) or a list of filenames on stdout, that can be 
processed by other idx tools. As you might have expectet, error messages will 
go to STDERR. 


Some Examples: 

to put some files in the index:

`ls *.pdf | idx add | idx tag inbox unread`


to get all pdf files tagged unread to a directory newdocs: 

`idx lsall | idx filter tag unread |  idx filter -e mimetype "*pdf*" | idx get -t newdocs`


to get all files tagged unread with the text Invoice in it: 

`idx lsall | idx filter tag unread |  idx greptext -i Invoice | idx get`


- idx add
- idx lsall
- idx filter
- idx get
- idx set
- idx tag
- idx unset
- idx untag
- idx file2id
- idx savetext
- idx greptext

#Storage

Data files are stored in $HOME/.idx-data if nothing else is known. 


#Extensions

You can easily write your own workflows using shellscripts. 

idx is looking for idx-COMMAND scripts in ~/.idx-extensions /etc/idx-extensions
and /usr/local/share/idx a new feature just means placing a script in the right
place. These scripts earn some features from the main script like finding the
right storage location, as well as logging tools. 


