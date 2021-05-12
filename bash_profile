# shellcheck shell=bash
#   ------------------------------------------------------------
#	.bash_profile
#
# 	various aliases and functions I use
#
#	TODO: more organization and cleanup
#   ------------------------------------------------------------

#http://crontab.guru

#   ------------------------------------------------------------
# 							Path
#   ------------------------------------------------------------

# Add Visual Studio Code (code)
export PATH="${PATH}:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# MacPorts Installer addition on 2017-01-27_at_02:28:10: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

export PATH="/Users/martinritter/Documents/Development/Scripts/bash:$PATH"
export PATH="/Users/martinritter/Documents/Development/Scripts/bash/MRaudioChopperStitcher:$PATH"
export PATH="/Users/martinritter/Documents/Development/Scripts/python:$PATH"
export PATH="/Users/martinritter/Documents/MATLAB/ambiResearch/matlabCode/tracking:$PATH"
export PATH="/Applications:$PATH"
export PATH="/opt/local/libexec/gnubin:$PATH"

export MAGICK_HOME=/opt/local

#export EDITOR=nano
# export EDITOR="/usr/local/bin/mate -w"

if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
         . /opt/local/etc/profile.d/bash_completion.sh
fi

export HISTTIMEFORMAT="%F %T "

# eval "$(starship init bash)"

#   ------------------------------------------------------------
# 							Aliases
#   ------------------------------------------------------------

# "improve" commands
#   ------------------------------------------------------------
alias x="exit"
alias c="clear"

alias cd-="cd -" #jump to previous directory
alias ..="cd .. && ls"
	alias ...="cd ../.. && ls"

alias topS="top -o cpu"
	alias tops="topS"

alias dus="du -sh"

alias wget="wget -c"
	# wget specific types
	alias getpdf="wget -r -A.pdf "
	alias getjpeg="wget -r -A.jpg "
	alias getmp3="wget -r -l1 -H -A mp3 " #-H follows links; careful!
	alias getzip="wget -r -A.zip "

alias mv="mv -v "
	alias tcn='mv --force -t ~/.Trash '
	alias trash='tcn'
	alias del='tcn'

alias ditto="ditto -V "

alias ls="c && ls -pG --color=auto "
	alias lm="ls | more"
	#alias lss="ls |rev|sort|rev|more"	#sort by filetype
	alias lss="dus ."
	alias lsz="ls -lrS"
	alias la="ls -ad .*" #--color=auto
	alias ll="ls -lh"
	alias lc="ls; echo ''; command ls -1 | wc -l; echo '     items'"
	alias lcount="command ls -1 | wc -l"
	#sort by recently modified (newest to oldest)
	alias lt="ls -t"

alias sudo="sudo "

alias rm="rm -v"

alias cp="cp -iv"
	alias cpv="rsync -ah --info=progress2 " #use instead of copy... with progressbar!

alias rsync="rsync -vazhPm"
alias rssh="rsync -e ssh "

alias mount="mount |column -t "

alias gh='history|grep '

alias mkdir="mkdir -pv "

# Conversions
#   ------------------------------------------------------------
alias pdf2png="convert -alpha off -quality 100 -density 300 -type TrueColor "
alias pdf2pngBW="convert -alpha off -quality 100 -density 300 "
alias pdf2pngAll="convert -alpha off -quality 100 -density 300 -type TrueColor *.pdf -set filename: \"%t\" %[filename:].png"
alias png2jpgAll="convert -alpha off -quality 100 -density 300 -type TrueColor *.png -set filename: \"%t\" %[filename:].jpg"
alias eps2pngAll="convert -alpha off -quality 100 -density 600 -type TrueColor *.eps -set filename: \"%t\" %[filename:].png"
alias pngAddBoarder="convert -border 10 -bordercolor black *.png -set filename: \"%t_border\" %[filename:].png"
alias tiff2png="convert *.tiff -set filename: \"%t\" %[filename:].png"

alias rotateAll="sips sips -r 180 *.png"
alias montage="montage -geometry '1x1+0+0<' -background white "
alias sortPics="exiftool -r -d %Y/%m/%d \"-directory<filemodifydate\" \"-directory<createdate\" \"-directory<datetimeoriginal\" ."

alias youtube-dl='youtube-dl --geo-bypass '
alias yts="youtube-dl -f 140 "
alias ytmp3="youtube-dl --extract-audio --audio-format mp3 --ignore-errors --continue --no-overwrites --yes-playlist --output \"%(title)s.%(ext)s\" "
alias ytwav="youtube-dl --extract-audio --audio-format wav --ignore-errors --continue --no-overwrites --yes-playlist --output \"%(title)s.%(ext)s\" "

#alias openT="open -a TextWrangler "
#alias openT="open -a TextMate "
alias openT="open -a 'Visual Studio Code' "
	alias oT="openT "

# open/connect to things...
#   ------------------------------------------------------------
alias o="open "
	alias o.="o ."

alias openbash="openT ~/.bash_profile"
	alias ob="openbash"
alias obs="openT ~/.config/starship.toml"

# remove all aliases... re-load the .bash_profile
alias rb="unalias -a; c; source ~/.bash_profile;"

alias opensim="open -n /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"

alias Max="open -n /Applications/Max.app"
	alias max="Max"

alias MRmax="cd /Users/martinritter/Documents/Music/Max/Max8; o."

alias Unity="open -n /Applications/Unity\ Hub.app"
	alias unity="Unity"

alias NaPro="open -n /Applications/NoteAbilityPro.app"
	alias napro="NaPro"
	alias naPro="NaPro"

alias monitor="open -a 'Activity Monitor'"

alias matlab="/Applications/MATLAB_R2018a.app/bin/matlab -nodesktop"

alias MRscript="cdl /Users/martinritter/Documents/Development/Scripts/bash/"
	alias MRscripto="MRscript; o."

alias MRdev="cd /Users/martinritter/Documents/Development/"
	alias MRdevo="MRdev; o."

alias ambipath="cdl /Users/martinritter/Documents/MATLAB/ambiResearch/matlabCode/ambisonic/Eigenmike"

alias MRthesis="cd /Users/martinritter/Documents/School/CMD/thesis; o."
	alias MRthesisMat="cd /Users/martinritter/Documents/MATLAB/ambiResearch/matlabCode; o."
	alias MRthesisLatex="cd /Users/martinritter/Documents/School/CMD/thesis/Thesis_LATEX; o."

alias MRscores="cd /Users/martinritter/Documents/Music/MRscores/; o."

alias AA="ssh -p 22 alyssaaska@Alyssas-MacBook-Pro.local."
alias MRssh="ssh martinri@martin-ritter.com"

alias vsCode="code ."
	alias vscode="vsCode"
	alias vsc="vscode"

vsShell () {

	if ! cp /Users/martinritter/Documents/Development/Scripts/bash/__DEFAULT\ SCRIPT/defaultScript.sh /Users/martinritter/Documents/Development/Scripts/bash/"$1"; then

		echo >&2 "ERROR: couldn't copy defaultScript.sh to $1"

		exit 1
	fi

	code /Users/martinritter/Documents/Development/Scripts/bash/"$1"
}

#   bib things
#   ------------------------------------------------------------
alias bibItalics="sed -i -e ‘s;{\\textless}i{\\textgreater};\\textit{;g’ -e ‘s;{\\textless}/i{\\textgreater};};g’ "
alias cpbib="cp -Rv /Users/martinritter/Documents/latex/MASTERbibFiles/*.bib ."

#	misc.
#   ------------------------------------------------------------
alias startServer="http-server --port 9000" #needs index.html inside of ./public

alias timer="utimer -s"

alias showLibrary="chflags nohidden ~/Library "

alias showAll="diskutil list "

alias code2rtf="pbpaste | highlight --syntax=js -O rtf | pbcopy"

alias c#2rtf="pbpaste | highlight --syntax csharp -n --font-size 10 -O rtf |pbcopy"

alias formatRBP="sudo diskutil eraseDisk FAT32 RASPBIAN MBRFormat "

alias battery="pmset -g batt"

alias cronmail="open /var/mail/martinritter"
alias cronmaild="echo 'd *' | mail"

alias zipl="unzip -l "

alias portsize="du -sh /opt/local/var/macports/software/"

alias wifihist="defaults read /Library/Preferences/SystemConfiguration/com.apple.airport.preferences |grep LastConnected -A 7"

alias mktar="tar -jcvf "
alias untar="tar -jxvf "

alias countf="find . -type f | wc -l"

alias getip="ipconfig getifaddr en0"
	alias ip="getip"
	alias Ip="ip"

alias portuninstall="sudo port uninstall --follow-dependencies "

alias findempty="find . -type d -empty -mindepth 1 -print"
	alias delempty="find . -type d -empty -mindepth 1 -delete"


alias cow="c; fortune | cowsay; echo; echo \"------------------------------\""

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

alias num="numberfiles"
	alias _num="_numberfiles"
	alias num_="num"

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
numberfiles_()
{
	numberfiles;
}
#   ------------------------------------------------------------
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
code2rtf()
{
	highlight -i "$1" --syntax=js -O rtf | pbcopy;
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

   for f in *.avi
   do
      ffmpeg -i "$f" "${f%.*}".m4v
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

TODAY=$(date "+%Y-%m-%d")

{
	echo "-------------------------------
-------------------------------
$TODAY
-------------------------------

$(port installed)

-------------------------------
-------------------------------"
} >> ~/Desktop/TEST.txt

	{
		echo "-------------------------------"
		echo "-------------------------------"
		echo "$TODAY"
		echo "-------------------------------"
		echo
		echo

		port installed

		echo
		echo
		echo "-------------------------------"
		echo "-------------------------------"
	} >> ~/Desktop/TEST.txt

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

rcow
echo
echo '.bash_profile reloaded...'


#MRsetTmux

source /Users/martinritter/.config/broot/launcher/bash/br

# MacPorts Installer addition on 2020-12-25_at_12:49:58:
		#adding an appropriate DISPLAY variable for use with MacPorts.
export DISPLAY=:0
# Finished adapting your DISPLAY environment variable for use with MacPorts.

# MacPorts Installer addition on 2021-03-19_at_23:18:04: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2021-03-19_at_23:18:04: adding an appropriate DISPLAY variable for use with MacPorts.
export DISPLAY=:0
# Finished adapting your DISPLAY environment variable for use with MacPorts.

# opam configuration
test -r /Users/martinritter/.opam/opam-init/init.sh && . /Users/martinritter/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
