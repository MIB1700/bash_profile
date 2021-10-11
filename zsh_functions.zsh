#   ------------------------------------------------------------
#							FUNCTIONS
#   ------------------------------------------------------------
reverseVideo() {

	STR="$1"
	EXT=${STR##*.}
	FNAME=${STR%.*}

	ffmpeg -i "$STR" -vf reverse "$FNAME"_reversed."$EXT"
}
#   ------------------------------------------------------------
reverseAudio() {

	STR="$1"
	EXT=${STR##*.}
	FNAME=${STR%.*}

	ffmpeg -i "$STR" -af areverse "$FNAME"_reversed."$EXT"
}
#   ------------------------------------------------------------
reverseVideoAudio() {

	STR="$1"
	EXT=${STR##*.}
	FNAME=${STR%.*}

	ffmpeg -i "$STR" -vf reverse -af areverse "$FNAME"_reversed."$EXT"
}
#   ------------------------------------------------------------
setupunity() {

    git init
    curl -o .gitignore https://raw.githubusercontent.com/github/gitignore/master/Unity.gitignore
    git add .
    git commit -m "Initial commit."
}
#   ------------------------------------------------------------
commitSize() {

	git rev-list --objects --all |
  	git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' |
	sed -n 's/^blob //p' |
	sort --numeric-sort --key=2 |
	cut -c 1-12,41- |
	$(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest

  #from https://stackoverflow.com/questions/10622179/how-to-find-identify-large-commits-in-git-history
}
#   ------------------------------------------------------------
# https://filipe.kiss.ink/zmv-zsh-rename/
# http://manpages.ubuntu.com/manpages/bionic/man1/zsh-lovers.1.html
rmSpace()
{
	zmv -v '(* *)' '${1// /_}'

	# For any file in the current directory with at least one space in the name,
	# replace every space by an underscore and display the commands executed.
}
#   ------------------------------------------------------------
numberfiles_()
{
	numberfiles;
}
#   ------------------------------------------------------------
# TODO: redo with zmv!!
numberfiles()
{	#e.g. all files in directory: numberfiles
	num=0;

	for file in *;
		do
		#echo "$(printf '%s_%04d' ${file%%.*} $num).${file#*.}";
		mv "$file" "$(printf '%s_%04d' "${file%%.*}" $num).${file#*.}"; ((num++)); done
}
#   ------------------------------------------------------------
_numberfiles()
{
	#e.g. all files in directory: numberfiles
	num=0;

	for file in *;
		do
		#echo "$(printf '%s_%04d' ${file%%.*} $num).${file#*.}";
		mv "$file" "$(printf '%04d_%s' $num "${file%%.*}").${file#*.}"; ((num++)); done
}
#   ------------------------------------------------------------
#pdftk hasn't been updated for the latest OS yet :(
# pdf2single()
# {
# 	pdftk "$1" burst

# 	ls
# }
#   ------------------------------------------------------------
pdf2kindle()
{
	#needs path to pdf... just drag it... then copies it into kindle folder at the end
	VAR="$1"
	echo "--------"
	DIR=$(dirname "${VAR}")
	FILENAME=$(basename "${VAR}")
	FILENAME="${FILENAME%.*}"

	k2pdfopt -dpi 300 -vb 2 -fc- -ui- -om 0.2 -x "${VAR}"

	NEWF="${DIR}"/"${FILENAME}"_k2opt.pdf

	echo "--------"

	mv "${NEWF}" /Users/martinritter/kindle/
	echo "--------"
	echo "--------"
}
#   ------------------------------------------------------------
# 	write name of all installed applications to a txt file
#   ------------------------------------------------------------
MRapplications()
{
	TODAY=$(date "+%Y-%m-%d")

	touch /Users/martinritter/MRcurrentApps.txt

	cd /Applications || exit

	echo 'Applications installed as of: ' "$TODAY"  > /Users/martinritter/MRcurrentApps.txt
	{
		echo''
		echo''
		ls
 	} >>/Users/martinritter/MRcurrentApps.txt

}
#	make directory and go there
#   ------------------------------------------------------------
mkd () {

    mkdir -pv "$1";
    cd "$1" || exit
}
#	remove directory and list remaining content
#   ------------------------------------------------------------
rmd () {

	numF=$(command ls -1 | wc -l);
	rm -rv "$1";
	newF=$(command ls -1 | wc -l);

	echo "count from => to: $numF => $newF"
}
#	change directory and list content
#   ------------------------------------------------------------
cdl () {

	cd "$1" || exit;
	ls
}
#	delete file and list content of folder
#   ------------------------------------------------------------
rml (){

	numF=$(command ls -1 | wc -l);
	rm -v "$1";
	newF=$(command ls -1 | wc -l);

	echo "count from => to: $numF => $newF"
}
#   ------------------------------------------------------------
mvl (){

	_path=$(dirname -- "$1")
	_target="${_path%/}/$2"

	mv -i "$1" "$2"
	cd "$_target" || exit
	lc
}
#   ------------------------------------------------------------
#   ------------------------------------------------------------
#move all files of type $1 to a folder in the same location named $1_repo
MRrepo () {

	if [ $# -eq 0 ]; then
   		{ echo 'No arguments provided' >"$2"; }

	else 	#one argument -> extension type
		if [ $# -eq 1 ]; then
			local _folder=repo_"$1"

			mkdir -pv "$_folder"
			mv ./*."$1" "$_folder"/
		fi
		#two arguments -> extension type and folder name
		if [ $# -eq 2 ]; then
			local _folder=repo_"$2"

			mkdir -pv "$_folder"

			mv ./*."$1" "$_folder"/
		fi

		cd "$_folder"/ || exit
		lc
	fi
}
#   ------------------------------------------------------------
#move all files of type $1 to a folder in the same location named $1_repo
_MRrepo () {

	if [ $# -eq 1 ]; then
		local _folder=repo_"$1"

		mkdir -pv ./REPO/"$_folder"

		mv ./*."$1" ./REPO/"$_folder"/
	fi

	if [ $# -eq 2 ]; then
		local _folder=repo_"$2"

		mkdir -pv ./REPO/"$_folder"

		mv ./*."$1" ./REPO/"$_folder"/
	fi
}
#   ------------------------------------------------------------
#move a number of different file types to their respective repo folders
MRclean()	{

	for file in *
	do
		if [[ -f $file ]]; then
			case $file in
			     #######################################
				*.zip)				_MRrepo zip;;
				*.tar.bz2)			_MRrepo tar.bz2 zip;;
				*.tar.gz) 			_MRrepo tar.gz zip;;
				*.bz2) 				_MRrepo bz2 zip;;
				*.rar) 				_MRrepo rar zip;;
				*.gz) 				_MRrepo gz zip;;
				*.tar) 				_MRrepo tar zip;;
				*.tbz2) 			_MRrepo tbz2 zip;;
				*.tgz) 				_MRrepo tgz zip;;
				*.Z) 				_MRrepo Z zip;;
				*.7z) 				_MRrepo 7z zip;;
				*.dmg) 				_MRrepo dmg zip;;
				*.iso)				_MRrepo iso zip;;
			     #######################################
				*.mp3)				_MRrepo mp3 sound;;
				*.aif)				_MRrepo aif sound;;
				*.aiff)				_MRrepo aiff sound;;
				*.wav)				_MRrepo wav sound;;
                *.WAV)				_MRrepo WAV sound;;
				*.m4a)				_MRrepo m4a sound;;
				*.aac)				_MRrepo aac sound;;
			     #######################################
				*.mp4)				_MRrepo mp4 movie;;
				*.MP4)				_MRrepo mp4 movie;;
				*.mov)				_MRrepo mov movie;;
				*.MOV)				_MRrepo MOV movie;;
				*.m4v)				_MRrepo m4v movie;;
				*.mkv)				_MRrepo mkv movie;;
			     #######################################
				*.jpg)				_MRrepo jpg pics;;
				*.jpeg)				_MRrepo jpeg pics;;
				*.JPG)				_MRrepo JPG pics;;
				*.png)				_MRrepo png pics;;
				*.PNG)				_MRrepo PNG pics;;
				*.tiff)				_MRrepo tiff pics;;
				*.tif)				_MRrepo tif pics;;
				*.bmp)				_MRrepo bmp pics;;
				*.svg)				_MRrepo svg pics;;
				*.pict)				_MRrepo pict pics;;
				*.pct)				_MRrepo pct pics;;
			     #######################################
				*.ppt)				_MRrepo ppt;;
				*.pptx)				_MRrepo pptx ppt;;
				*.key)				_MRrepo key ppt;;
			     #######################################
				*.m)				_MRrepo m code;;
				*.playground)		_MRrepo playground code;;
				*.c)				_MRrepo c code;;
				*.js)				_MRrepo js code;;
				*.h)				_MRrepo h code;;
				*.rb)				_MRrepo rb code;;
				*.sh)				_MRrepo sh code;;
				*.json)				_MRrepo json code;;
				*.ai)				_MRrepo ai code;;
				*.mat)				_MRrepo mat code;;
			     #######################################
				*.doc)				_MRrepo doc docx;;
				*.docx)				_MRrepo docx;;
				*.dot)				_MRrepo dot docx;;
				*.dotx)				_MRrepo dotx docx;;
			     #######################################
				*.txt)				_MRrepo txt;;
				*.rtf)				_MRrepo rtf txt;;
				*.csv)				_MRrepo	csv txt;;
			     #######################################
				*.maxpat)			_MRrepo maxpat max;;
			    *.maxhelp)			_MRrepo maxhelp max;;
				*.maxpresets)		_MRrepo maxpresets max;;
			     #######################################
				*.na)				_MRrepo na score;;
				*.mus)				_MRrepo mus score;;
				*.MUS)				_MRrepo MUS score;;
			     #######################################
				*.html)				_MRrepo html web;;
				*.eml)				_MRrepo eml web;;
				*.webloc)			_MRrepo webloc web;;
			     #######################################
				*.pdf) 				_MRrepo pdf;;
				*.PDF) 				_MRrepo PDF pdf;;
				*.eps)				_MRrepo eps pdf;;
				*.ps)				_MRrepo ps pdf;;
                *.mobi)				_MRrepo mobi pdf;;
				*.epub)				_MRrepo epub pdf;;
				*)  	echo "no match for $($file)";;
			esac
		fi
	done

	lc
}

#	extract:  Extract most know archives with one command
#   ------------------------------------------------------------
extract ()	{

	if [ -f "$1" ]; then
		case $1 in
			*.tar.bz2)	tar xvjf "$1";;
			*.tar.gz) 	tar xvzf "$1";;
			*.bz2) 		bunzip2 "$1";;
			*.rar) 		unrar x "$1";;
			*.gz) 		gunzip "$1";;
			*.tar) 		tar xvf "$1";;
			*.tbz2) 	tar xvjf "$1";;
			*.tgz) 		tar xvzf "$1";;
			*.zip) 		unzip "$1" -x "__MACOSX/*";;
			*.Z) 		uncompress "$1";;
			*.7z) 		7z x "$1";;
			*) echo "can’t extract ‘$1’…";;
		esac
	else
		{ echo "$1 is not a valid file!"; exit 1; }
	fi
}
#   ------------------------------------------------------------
MRavi2mv4()     {

   for f in *
   do
		if [[ $f == *.avi ]]
        then
      		ffmpeg -i "$f" "${f%.*}".m4v
		fi
   done
}
#   ------------------------------------------------------------
MRavi2mkv()     {

   for f in *
   do
		if [[ $f == *.avi ]]
    	then
			ffmpeg -i "$f" -q:v 0 "${f%.*}".mkv
		fi
   done
}
#   ------------------------------------------------------------
MRaudio2mp3()     {

   for f in *
   do
      ffmpeg -i "$f"  -c:a mp3 -ab 192k "${f%.*}".mp3
   done
}
#   ------------------------------------------------------------
MRpdf2pngBW()     {

   for f in *
   do
       if [[ $f == *.pdf ]]
       then
           pdf2pngBW "$f"
       fi
   done
}
#   ------------------------------------------------------------

Zeit_pdf_png() {

	nname="$1"
	convert -alpha remove -quality 100 -density 150 "$nname" "%03d_${nname%.pdf}".png

	pngAddShadow

	for f in *
   		do
	   #name of current file
	   name="${f%_logo.png}"

       if [[ "$f" == "${name}_logo.png" ]]
       then
			rm "$f"
		fi
	done
}

pngAddShadow()     {

   for f in *
   do
       if [[ $f == *.png ]]
       then
			#name of current file
			name="${f%.png}"

			convert "${f}" -bordercolor white -border 10 \
			 \( +clone -background black -shadow 75x25+10+10 \) \
			 +swap -background none -layers merge +repage \
			 "${name}"_shadow.png

       fi
   done
}
alias pngShadow="pngAddShadow"
#   ------------------------------------------------------------
# pdftk hasn't been updated for the latest OS yet :(
# MRpdfCollate()	{

# 	cd /Users/martinritter/pdfs/

# 	pdftk A="$1" B="$2" shuffle A Bend-1 output collated_pages.pdf

# }
#   ------------------------------------------------------------
pdfImages() {

    pdfimages -png "$1" extracted_image
}
#   ------------------------------------------------------------
error()
{
  echo "Error: $*" >&2
  exit 1
}
MRcToO(){

	 for f in *
   do
       if [[ $f == *.c ]]
       then

		  gcc -Wall -c "$f" -o ./oFiles/"${f%.*}".o
	   fi
	done

	#-Wno-implicit-function-declaration -Wimplicit-int -Wunused-variable -Wunused-label
}
MRtest()	{


	mdfind -onlyin . "kMDItemDisplayName == '*.mp4'wc" -0 | xargs -0 du -hm | sort -n -r >> TEST.txt
	# mdfind -onlyin . "(kMDItemDisplayName == '*.mp4'wc && kMDItemFSSize > 1000000) && kMDItemDisplayName != '*.icloud'" -0 | xargs -0 du -hm | sort -n -r >> TEST.txt

# TODAY=$(date "+%Y-%m-%d")

# {
# 	echo "-------------------------------
# -------------------------------
# $TODAY
# -------------------------------

# $(port installed)

# -------------------------------
# -------------------------------"
# } >> ~/Desktop/TEST.txt

# 	{
# 		echo "-------------------------------"
# 		echo "-------------------------------"
# 		echo "$TODAY"
# 		echo "-------------------------------"
# 		echo
# 		echo

# 		port installed

# 		echo
# 		echo
# 		echo "-------------------------------"
# 		echo "-------------------------------"
# 	} >> ~/Desktop/TEST.txt

	# find . \( \( -type f -a -name "*.mp4" \) -o \
    #       \( -name "*.aif*" \) -o \
    #       \( -name "*.wav" \) \
    #    \) -a -exec du -hm {} \; | sort -n -r

	#    -a -exec sh -c 'echo "$0"' {} \; \)

	# if ! which "$1" &>/dev/null; then
    # 	error "$1 command not found, you must install it first..."
	# fi

	echo " "

	# if [ -t 1 ] ; then
	# 	# stdout is a terminal
	# 	echo 'stdout is a terminal'
	# else
	# 	# stdout isn't a terminal
	# 	#don't forget to check the file for this text! it is redirected after all!!
	# 	echo 'stdout is NOT a terminal'
	# fi

	# :'
	# 	STR="/path/to/foo.cs"
	# 	echo ${STR%.cs}    # /path/to/foo
	# 	echo ${STR%.cs}.o  # /path/to/foo.o
	# 	echo ${STR%/*}      # /path/to

	# 	echo ${STR##*.}     # cs (extension)
	# 	echo ${STR##*/}     # foo.cs (basepath)

	# 	echo ${STR#*/}      # path/to/foo.cs
	# 	echo ${STR##*/}     # foo.cs

	# 	echo ${STR/foo/bar} # /path/to/bar.cs
	# '
}
#   ------------------------------------------------------------
MRsetTmux(){

    tmux new-session -s "mainSession"\; \
        send-keys 'c' C-m \; \
        split-window -v -p 30\; \
        send-keys 'c; portcheck' C-m \; \
        select-pane -t 1\;

    tmux attach
}
#   ------------------------------------------------------------
# create a shell template for new scripts...
vsShell () {

	if ! cp /Users/martinritter/Documents/Development/Scripts/bash/__DEFAULT\ SCRIPT/defaultScript.sh /Users/martinritter/Documents/Development/Scripts/bash/"$1"; then

		echo >&2 "ERROR: couldn't copy defaultScript.sh to $1"

		exit 1
	fi

	code /Users/martinritter/Documents/Development/Scripts/bash/"$1"
}

rcow()
{
	#pick a random cow file...
	rAppearance=$(command gshuf -n1 -e /opt/local/share/cowsay/cows/*)
	rAppearance2=$(command gshuf -n1 -e /Users/martinritter/Documents/Development/Scripts/bash/cows/*)

	#generate fortune
	fort=$(command fortune)

	#half the time use the default cow
	if [ "$((RANDOM % 100 + 1))" -gt 75 ]
		then
			cowsay "${fort}"
		else
		#the other half use a randomized "cow"
			if [ "$((RANDOM % 1 + 1))" -gt 2 ]
				then
					cowsay -f "${rAppearance}" "${fort}"
				else
					cowsay -f "${rAppearance2}" "${fort}"
			fi
	fi

	echo
	echo "------------------------------"
}

rcow

TEST() {

	clear
	port outdated
	sudo port upgrade outdated
	echo $?
}