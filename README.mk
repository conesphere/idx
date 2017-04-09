IDX Index
---------

idx is a set of Bash scripts helping you to organize your documents


Usage
-----

idx make use of unix pipes, so an idx-* command either returns a list of 
sha256sums (used as document IDs) or a list of filenames on stdout. 


to put some files in the index:

`ls *.pdf | idx-add | idx-tag inbox unread`


to get all files tagged unread: 

`idx lsall | idx filter tag unread |  idx filter -e mimetype "*pdf*" | idx get`


to get all files tagged unread: 

`idx all | idx filter tag unread |  idx filter -e mimetype "*pdf*" | idx get`


- idx-add
- idx-all
- idx-filter
- idx-get
- idx-set
- idx-tag
- idx-unset
- idx-untag

So you can easily write your own workflows using shellscripts, and also lookup and 
archive all the static documents you have. 

