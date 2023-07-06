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
videosToMp4()
{
	for f in *
	do
		STR="$f"
		EXT=${STR##*.}
		FNAME=${STR%.*}

		ffmpeg -i "$STR" "$FNAME".mp4
	done
}

stereoToMono()
{
	STR="$1"
	EXT=${STR##*.}
	FNAME=${STR%.*}

	ffmpeg -i "$STR" -map_channel 0.0.0 "$FNAME"_LEFT."$EXT" -map_channel 0.0.1 "$FNAME"_RIGHT."$EXT"
   #ffmpeg -i INPUT  -map_channel 0.0.0  OUTPUT_CH0          -map_channel 0.0.1   OUTPUT_CH1
}
audioCutEOF() {

	TRIM_EOF_DURATION=${1:-1.0} # Default is 1.0 second trimmed from EOF

	for f in *
	do
		# Trim EOF duration
		INPUT_DURATION=$(ffprobe -v error -select_streams a:0 -show_entries stream=duration -of default=noprint_wrappers=1:nokey=1 "${f}")
		OUTPUT_DURATION=$(bc <<< "$INPUT_DURATION"-"$TRIM_EOF_DURATION")
		ffmpeg -i "$f" -t "$OUTPUT_DURATION" -c:a mp3 -ab 192k "${f%.*}_trimEnd".mp3
	done
}
audioCutBeginning() {

	TRIM_DURATION=${1:-1.0} # Default is 1.0 second trimmed from EOF

	for f in *
	do
		ffmpeg -ss "${TRIM_DURATION}" -i "$f"  -c:a mp3 -ab 192k "${f%.*}_trimStart".mp3
	done
}
#TODO: combine audioCutEOF and audioCutBegining!! input: seconds to cut from beginning AND seconds to cut from end!!


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

pdfs2kindle()
{

	for file in *
	do
		if [[ -f $file ]]; then

				echo "--------"
			DIR=$(dirname "${file}")
			FILENAME=$(basename "${file}")
			FILENAME="${FILENAME%.*}"

			k2pdfopt -dpi 300 -vb 2 -fc- -ui- -om 0.2 -x "${file}"

			NEWF="${DIR}"/"${FILENAME}"_k2opt.pdf

			echo "--------"

			mv "${NEWF}" /Users/martinritter/kindle/
			echo "--------"
			echo "--------"

		fi
	done
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
		if [[ $f == *.aif || $f == *.wav ]]
		then
			ffmpeg -i "$f"  -c:a mp3 -ab 192k "${f%.*}".mp3
		fi
   done
}
MRaif2wav()     {

   for f in *
   do
		if [[ $f == *.aif ]]
		then
			ffmpeg -i "$f" "${f%.*}".wav
		fi
   done
}

MRwave2aif()     {

   for f in *
   do
		if [[ $f == *.wav ]]
		then
			ffmpeg -i "$f" "${f%.*}".aif
		fi
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

	# make sure to be in the directory with the pdf and only give the filename
	# DO NOT (!!) drag the file to the terminal... the script doesn't strip the path (yet)!

	#TODO: deal with the path (if given)

	nname="$1"
	# echo "${nname}"
	# echo "${nname%.pdf}_shadow"
	# echo "%03d_${nname%.pdf}".png

	mkdir "${nname%.pdf}_shadow"

	# return

	convert -alpha remove -quality 100 -density 150 "${nname}" "%03d_${nname%.pdf}".png


	pngAddShadow

	for f in *
   		do
	   #name of current file
	   name="${f%_logo.png}"

       if [[ "$f" == "${name}_logo.png" ]]
       then
			rm "$f"
			mv "${name}_logo_shadow.png" "${nname%.pdf}_shadow"
		fi
	done

	mv "${nname}" "${nname%.pdf}_shadow"


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

	if ! cp /Users/martinritter/Documents/__MR/Development/Scripts/bash/__DEFAULT\ SCRIPT/defaultScript.sh /Users/martinritter/Documents/Development/Scripts/bash/"$1"; then

		echo >&2 "ERROR: couldn't copy defaultScript.sh to $1"

		exit 1
	fi

	code /Users/martinritter/Documents/__MR/Development/Scripts/bash/"$1"
}

rcow()
{
	clear
	#pick a random cow file...
	rAppearance=$(command gshuf -n1 -e /opt/local/share/cowsay/cows/*)
	rAppearance2=$(command gshuf -n1 -e /Users/martinritter/Documents/__MR/Development/Scripts/bash/cows/*)

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

waveTrans() {
	# https://stackoverflow.com/questions/52179047/ffmpeg-normalization-waveform

	file_name="$1"
	color="$2"

	echo "$file_name"
	echo "$color"

	ffmpeg -i "$file_name" -filter_complex \
   "compand,[0:a]aformat=channel_layouts=mono,compand=gain=-2, \
    showwavespic=s=600x120:colors=white,negate[a]; \
    color="$color":600x120[c]; \
    [c][a]alphamerge"  -vframes 1 output.png

}

waveform() {

# https://trac.ffmpeg.org/wiki/Waveform
# https://ffmpeg.org/ffmpeg-filters.html#showspectrumpic
	# input:
	# $1 => filename
	# $2 => string colour name (for waveform)
	file_name="$1"
	colour=${2:-"black"}

	# compand=gain=0, \

	ffmpeg -i "$file_name" -filter_complex \
	"[0:a]aformat=channel_layouts=mono, \
	showwavespic=s=560x90:colors=$colour" \
	-frames:v 1 \
	"${file_name%.*}_waveform_$colour.png"

	#compand => normalize the waveform

	# valid colour names:
# 	‘AliceBlue’
	# 0xF0F8FF

	# ‘AntiqueWhite’
	# 0xFAEBD7

	# ‘Aqua’
	# 0x00FFFF

	# ‘Aquamarine’
	# 0x7FFFD4

	# ‘Azure’
	# 0xF0FFFF

	# ‘Beige’
	# 0xF5F5DC

	# ‘Bisque’
	# 0xFFE4C4

	# ‘Black’
	# 0x000000

	# ‘BlanchedAlmond’
	# 0xFFEBCD

	# ‘Blue’
	# 0x0000FF

	# ‘BlueViolet’
	# 0x8A2BE2

	# ‘Brown’
	# 0xA52A2A

	# ‘BurlyWood’
	# 0xDEB887

	# ‘CadetBlue’
	# 0x5F9EA0

	# ‘Chartreuse’
	# 0x7FFF00

	# ‘Chocolate’
	# 0xD2691E

	# ‘Coral’
	# 0xFF7F50

	# ‘CornflowerBlue’
	# 0x6495ED

	# ‘Cornsilk’
	# 0xFFF8DC

	# ‘Crimson’
	# 0xDC143C

	# ‘Cyan’
	# 0x00FFFF

	# ‘DarkBlue’
	# 0x00008B

	# ‘DarkCyan’
	# 0x008B8B

	# ‘DarkGoldenRod’
	# 0xB8860B

	# ‘DarkGray’
	# 0xA9A9A9

	# ‘DarkGreen’
	# 0x006400

	# ‘DarkKhaki’
	# 0xBDB76B

	# ‘DarkMagenta’
	# 0x8B008B

	# ‘DarkOliveGreen’
	# 0x556B2F

	# ‘Darkorange’
	# 0xFF8C00

	# ‘DarkOrchid’
	# 0x9932CC

	# ‘DarkRed’
	# 0x8B0000

	# ‘DarkSalmon’
	# 0xE9967A

	# ‘DarkSeaGreen’
	# 0x8FBC8F

	# ‘DarkSlateBlue’
	# 0x483D8B

	# ‘DarkSlateGray’
	# 0x2F4F4F

	# ‘DarkTurquoise’
	# 0x00CED1

	# ‘DarkViolet’
	# 0x9400D3

	# ‘DeepPink’
	# 0xFF1493

	# ‘DeepSkyBlue’
	# 0x00BFFF

	# ‘DimGray’
	# 0x696969

	# ‘DodgerBlue’
	# 0x1E90FF

	# ‘FireBrick’
	# 0xB22222

	# ‘FloralWhite’
	# 0xFFFAF0

	# ‘ForestGreen’
	# 0x228B22

	# ‘Fuchsia’
	# 0xFF00FF

	# ‘Gainsboro’
	# 0xDCDCDC

	# ‘GhostWhite’
	# 0xF8F8FF

	# ‘Gold’
	# 0xFFD700

	# ‘GoldenRod’
	# 0xDAA520

	# ‘Gray’
	# 0x808080

	# ‘Green’
	# 0x008000

	# ‘GreenYellow’
	# 0xADFF2F

	# ‘HoneyDew’
	# 0xF0FFF0

	# ‘HotPink’
	# 0xFF69B4

	# ‘IndianRed’
	# 0xCD5C5C

	# ‘Indigo’
	# 0x4B0082

	# ‘Ivory’
	# 0xFFFFF0

	# ‘Khaki’
	# 0xF0E68C

	# ‘Lavender’
	# 0xE6E6FA

	# ‘LavenderBlush’
	# 0xFFF0F5

	# ‘LawnGreen’
	# 0x7CFC00

	# ‘LemonChiffon’
	# 0xFFFACD

	# ‘LightBlue’
	# 0xADD8E6

	# ‘LightCoral’
	# 0xF08080

	# ‘LightCyan’
	# 0xE0FFFF

	# ‘LightGoldenRodYellow’
	# 0xFAFAD2

	# ‘LightGreen’
	# 0x90EE90

	# ‘LightGrey’
	# 0xD3D3D3

	# ‘LightPink’
	# 0xFFB6C1

	# ‘LightSalmon’
	# 0xFFA07A

	# ‘LightSeaGreen’
	# 0x20B2AA

	# ‘LightSkyBlue’
	# 0x87CEFA

	# ‘LightSlateGray’
	# 0x778899

	# ‘LightSteelBlue’
	# 0xB0C4DE

	# ‘LightYellow’
	# 0xFFFFE0

	# ‘Lime’
	# 0x00FF00

	# ‘LimeGreen’
	# 0x32CD32

	# ‘Linen’
	# 0xFAF0E6

	# ‘Magenta’
	# 0xFF00FF

	# ‘Maroon’
	# 0x800000

	# ‘MediumAquaMarine’
	# 0x66CDAA

	# ‘MediumBlue’
	# 0x0000CD

	# ‘MediumOrchid’
	# 0xBA55D3

	# ‘MediumPurple’
	# 0x9370D8

	# ‘MediumSeaGreen’
	# 0x3CB371

	# ‘MediumSlateBlue’
	# 0x7B68EE

	# ‘MediumSpringGreen’
	# 0x00FA9A

	# ‘MediumTurquoise’
	# 0x48D1CC

	# ‘MediumVioletRed’
	# 0xC71585

	# ‘MidnightBlue’
	# 0x191970

	# ‘MintCream’
	# 0xF5FFFA

	# ‘MistyRose’
	# 0xFFE4E1

	# ‘Moccasin’
	# 0xFFE4B5

	# ‘NavajoWhite’
	# 0xFFDEAD

	# ‘Navy’
	# 0x000080

	# ‘OldLace’
	# 0xFDF5E6

	# ‘Olive’
	# 0x808000

	# ‘OliveDrab’
	# 0x6B8E23

	# ‘Orange’
	# 0xFFA500

	# ‘OrangeRed’
	# 0xFF4500

	# ‘Orchid’
	# 0xDA70D6

	# ‘PaleGoldenRod’
	# 0xEEE8AA

	# ‘PaleGreen’
	# 0x98FB98

	# ‘PaleTurquoise’
	# 0xAFEEEE

	# ‘PaleVioletRed’
	# 0xD87093

	# ‘PapayaWhip’
	# 0xFFEFD5

	# ‘PeachPuff’
	# 0xFFDAB9

	# ‘Peru’
	# 0xCD853F

	# ‘Pink’
	# 0xFFC0CB

	# ‘Plum’
	# 0xDDA0DD

	# ‘PowderBlue’
	# 0xB0E0E6

	# ‘Purple’
	# 0x800080

	# ‘Red’
	# 0xFF0000

	# ‘RosyBrown’
	# 0xBC8F8F

	# ‘RoyalBlue’
	# 0x4169E1

	# ‘SaddleBrown’
	# 0x8B4513

	# ‘Salmon’
	# 0xFA8072

	# ‘SandyBrown’
	# 0xF4A460

	# ‘SeaGreen’
	# 0x2E8B57

	# ‘SeaShell’
	# 0xFFF5EE

	# ‘Sienna’
	# 0xA0522D

	# ‘Silver’
	# 0xC0C0C0

	# ‘SkyBlue’
	# 0x87CEEB

	# ‘SlateBlue’
	# 0x6A5ACD

	# ‘SlateGray’
	# 0x708090

	# ‘Snow’
	# 0xFFFAFA

	# ‘SpringGreen’
	# 0x00FF7F

	# ‘SteelBlue’
	# 0x4682B4

	# ‘Tan’
	# 0xD2B48C

	# ‘Teal’
	# 0x008080

	# ‘Thistle’
	# 0xD8BFD8

	# ‘Tomato’
	# 0xFF6347

	# ‘Turquoise’
	# 0x40E0D0

	# ‘Violet’
	# 0xEE82EE

	# ‘Wheat’
	# 0xF5DEB3

	# ‘White’
	# 0xFFFFFF

	# ‘WhiteSmoke’
	# 0xF5F5F5

	# ‘Yellow’
	# 0xFFFF00

	# ‘YellowGreen’
	# 0x9ACD32

}
waveformtrim() {

	# input:
	# $1 => filename
	# $2 => string colour name (for waveform)
	# $3 => start time (in seconds)
	# $4 => end time (in seconds)
	file_name="$1"
	colour="${2:-"black"}"
	start="${3:-0}"
	end="${4:-20}"


	ffmpeg -i "$file_name" -filter_complex \
	"aformat=channel_layouts=mono, \
	compand=gain=-6, \
	atrim=$start:$end, \
	showwavespic=s=560x90:colors=$colour" \
	-frames:v 1 \
	"${file_name%.*}_waveform_"$colour"_$start-$end.png"
}

to_seconds() {
    local epoch=$(date --utc -d @0 +%F)
    date --utc -d "$epoch $1" +%s.%09N
}

TEST() {

	# clear
	# ls

	# if [ $? -eq 0 ]; then
	#  echo "ls worked"
	#  else
	#  echo "ls didn't work"
	#  fi


	# tmpfile=$(mktemp /tmp/abc-script.XXXXXX)

	# rm "$tmpfile"

	# tmpfile=$(mktemp)

	# curl -o $tmpfile https://raw.githubusercontent.com/github/gitignore/master/Unity.gitignore

	# args=( "${(@f)$(< $tmpfile)}" )

	# for file in *
	# do
	# 	if [[ -d $file ]]; then

	# 		dirname=$(command basename "$file")
	# 		shortcuts run "Make PDF" -i "$file/"*.jpg -o /Users/martinritter/Downloads/Hellraiser/Output/"$dirname.pdf"

	# 	fi

	# done

	#   rsync ~/SourceDirectory/* username@192.168.56.100:~/Destination


	print "==================================="
	print "\n\n\t Checking IP for Pi:\n"
	print "===================================\n"

	hostname='raspberrypi'

	ip=$(command dig +short ${hostname})

	if [ -n "$ip" ]; then
		print "\nIP: ${ip}\n"

		w | grep "pi@"

		print "\nconnecting: pi@${ip}"

		rsync --exclude ".git/*" --exclude  "venv/*" --exclude "ProjectDescription_updated_7000Budget.pdf" . "pi@${ip}:/home/pi/Documents/Development/Frescobaldi"
	fi
}

Pi()
{
	#WHAT WOULD HAPPEN IF MULTIPLE PIs ARE PRESENT????

	print "==================================="
	print "\n\n\t Checking IP for Pi:\n"
	print "===================================\n"

	hostname='raspberrypi'

	# echo "trying to find $hostname"

	# ip=$(command dig +short ${hostname})

	# if [ -n "$ip" ]; then

	# 	print "\nIP: ${ip}\n"

		w | grep "pi@"

		if [ $? -eq 0 ]; then
			print '\n=================================================='
			print '============ already connected to pi! ============'
			print '==================================================\n'
		else

			print "\nShould we connect to pi via SSH? [y/n]"
			read connectionCheck

			if  [[ -z "$connectionCheck" || "$connectionCheck:u" = "N" || "$connectionCheck:u" = "NO" ]]; then

			# print ''
			print "nope? bye...\n"

			elif [[ "$connectionCheck:u" = "Y" || "$connectionCheck:u" = "YES" ]]; then
				print "\nconnecting: pi@${hostname}.local"
				ssh "pi@${hostname}.local"
			fi
		fi
	# else
	# 	echo "Could not resolve hostname. No Pi found"
	# fi
}

plex()
{
	#WHAT WOULD HAPPEN IF MULTIPLE PIs ARE PRESENT????

	print "==================================="
	print "\n\n\t Checking IP for Pi:\n"
	print "===================================\n"

	hostname='raspberrypiplex'

		w | grep "pi@"

		if [ $? -eq 0 ]; then
			print '\n=================================================='
			print '============ already connected to pi! ============'
			print '==================================================\n'
		else

			print "\nShould we connect to pi via SSH? [y/n]"
			read connectionCheck

			if  [[ -z "$connectionCheck" || "$connectionCheck:u" = "N" || "$connectionCheck:u" = "NO" ]]; then

			# print ''
			print "nope? bye...\n"

			elif [[ "$connectionCheck:u" = "Y" || "$connectionCheck:u" = "YES" ]]; then
				print "\nconnecting: pi@${hostname}.local"
				ssh "pi@${hostname}.local"
			fi
		fi
}

fresco2Pi()
{
# simple bash script that lets me sync the entire Frescobaldi folder to the pi over ssh...
# I do this because it's just toooooo painful to use github on the pi
# this is a sync (!!!) not a copy each time
#
# find if a RBP is on the network... get the IP... put the IP into the rsync command
# exclude the .git, venv, folders and pdf file...

print "==================================="
print "\n\n\t Checking IP for Pi:\n"
print "===================================\n"

hostname='raspberrypiplex'

ip=$(command dig +short ${hostname})

if [ -n "$ip" ]; then

    print "\nIP: ${ip}\n"

    # w | grep "pi@"

    print "\nconnecting: pi@${ip}"

    rsync -vazhPm --exclude ".git/*" --exclude  "venv/*" --exclude "ProjectDescription_updated_7000Budget.pdf" . "pi@${ip}:/home/pi/Documents/Development/Frescobaldi"
else
    print "\nDo you know the IP? [y/n]"
    read connectionCheck

    if  [[ -z "$connectionCheck" || "$connectionCheck:u" = "N" || "$connectionCheck:u" = "NO" ]]; then

    # print ''
    print "nope? bye...\n"

    elif [[ "$connectionCheck:u" = "Y" || "$connectionCheck:u" = "YES" ]]; then
        print "\nconnecting: pi@${ip}"
        rsync -vazhPm --exclude ".git/*" --exclude  "venv/*" --exclude "ProjectDescription_updated_7000Budget.pdf" . "pi@${ip}:/home/pi/Documents/Development/Frescobaldi"
    fi
fi

}

mv2pi()
{
	print "==================================="
	print "\n\n\t Checking IP for Pi:\n"
	print "===================================\n"

	hostname='raspberrypi'
	path2pi=$1

	echo "$path2pi"

	ip=$(command dig +short ${hostname})

	if [ -n "$ip" ]; then

		print "\nIP: ${ip}\n"

		# w | grep "pi@"

		print "\nconnecting: pi@${ip}"

		rsync -vazhPm --exclude ".git/*" --exclude  "venv/*" "$path2pi" "pi@${ip}:/home/pi/Downloads/"

#!obviously this won't work....
		# echo "now moving ${path2pi:t} to HD..."

		# print "\nMove to Movies? [y/n]"
		# read movies

		# if  [[ -z "$movies" || "$movies:u" = "N" || "$movies:u" = "NO" ]]; then

		# 	mv /home/pi/Downloads/${path2pi:t} /mnt/plex2/TV\ Shows/

		# elif [[ "$connectionCheck:u" = "Y" || "$connectionCheck:u" = "YES" ]]; then

		# 	mv "pi@${ip}:/home/pi/Downloads/"${path2pi:t} "pi@${ip}:/mnt/plex2/Movies/"
		# fi

	else

		print "\nDo you know the IP? [y/n]"
		read connectionCheck

		if  [[ -z "$connectionCheck" || "$connectionCheck:u" = "N" || "$connectionCheck:u" = "NO" ]]; then

		# print ''
		print "nope? bye...\n"


		elif [[ "$connectionCheck:u" = "Y" || "$connectionCheck:u" = "YES" ]]; then

			print "\nconnecting: pi@${ip}"
			rsync -vazhPm --exclude ".git/*" --exclude  "venv/*" "$path2pi" "pi@${ip}:/home/pi/Downloads/"

		fi
	fi
}

Pdf2pngS()
{
	size="${1:-1920}"
	for f in *
    do
       if [[ $f == *.pdf ]]
       then
           convert -density 288 "$f" -quality 100 -interpolative-resize "${size}x" -alpha remove -type TrueColor output.png
       fi
    done
}