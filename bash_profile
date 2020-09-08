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

export PATH="/Users/martinritter/Documents/Development/Scripts:$PATH"
export PATH="/Users/martinritter/Documents/MATLAB/ambiResearch/matlabCode/tracking:$PATH"
export PATH="/Applications:$PATH"
export PATH="/opt/local/libexec/gnubin:$PATH"

export MAGICK_HOME=/opt/local

#export EDITOR=nano
export EDITOR="/usr/local/bin/mate -w"

if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
         . /opt/local/etc/profile.d/bash_completion.sh
fi

#   ------------------------------------------------------------
# 							Aliases
#   ------------------------------------------------------------

# "improve" commands
#   ------------------------------------------------------------
alias x="exit"
alias c="clear"

alias ..="cd .. && ls"
	alias ...="cd ../.. && ls"

alias topS="top -o cpu"
	alias tops="topS"

alias dus="du -sh"

alias wget="wget -c"
	# wget specific types
	alias getpdf="wget -r -A.pdf "
	alias getjpeg="wget -r -A.jpg "
	alias getmp3="wget -r -A.mp3 "
	alias getzip="wget -r -A.zip "

alias mv="mv -v "

alias ditto="ditto -V "

alias ls="c && ls -pG --color=auto"
	alias lm="ls | more"
	#alias lss="ls |rev|sort|rev|more"	#sort by filetype
	alias lss="dus */"
	alias la="ls -ad .*" #--color=auto
	alias ll="ls -l"
	alias lc="ls; echo ''; command ls -1 | wc -l; echo '     items'"
	alias lcount="ls -l | wc -l"

alias sudo="sudo "

alias rm="rm -v"

alias cp="cp -iv"

alias rsync="rsync -vazhPm"
alias rssh="rsync -e ssh "

alias mount="mount |column -t "

# Conversions
#   ------------------------------------------------------------
alias pdf2png="convert -alpha off -quality 100 -density 300 -type TrueColor "
alias pdf2pngBW="convert -alpha off -quality 100 -density 300 "
alias pdf2pngAll="convert -alpha off -quality 100 -density 300 -type TrueColor *.pdf -set filename: "%t" %[filename:].png"
alias png2jpgAll="convert -alpha off -quality 100 -density 300 -type TrueColor *.png -set filename: "%t" %[filename:].jpg"
alias eps2pngAll="convert -alpha off -quality 100 -density 600 -type TrueColor *.eps -set filename: "%t" %[filename:].png"
alias pngAddBoarder="convert -border 10 -bordercolor black *.png -set filename: "%t_border" %[filename:].png"
alias tiff2png="convert *.tiff -set filename: "%t" %[filename:].png"

alias rotateAll="sips sips -r 180 *.png"
alias montage="montage -geometry '1x1+0+0<' -background white "
alias sortPics="exiftool -r -d %Y/%m/%d \"-directory<filemodifydate\" \"-directory<createdate\" \"-directory<datetimeoriginal\" ."

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

alias AA="ssh -p 22 alyssaaska@Alyssas-MacBook-Pro.local."
alias MRssh="ssh martinri@martin-ritter.com"

#   bib things
#   ------------------------------------------------------------
alias bibItalics="sed -i -e ‘s;{\\textless}i{\\textgreater};\\textit{;g’ -e ‘s;{\\textless}/i{\\textgreater};};g’ "
alias cpbib="cp -Rv /Users/martinritter/Documents/latex/MASTERbibFiles/*.bib ."

#	misc.
#   ------------------------------------------------------------
alias timer="utimer -s"

alias showLibrary=" chflags nohidden ~/Library "

alias showAll=" diskutil list "

alias code2rtf="pbpaste | highlight --syntax=js -O rtf | pbcopy"

alias formatRBP="sudo diskutil eraseDisk FAT32 RASPBIAN MBRFormat "

alias battery="pmset -g batt"

alias vol="osascript -e 'set volume output volume 70'"

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
#   ------------------------------------------------------------
#							FUNCTIONS
#   ------------------------------------------------------------
setupunity() {

    git init
    curl -o .gitignore https://raw.githubusercontent.com/github/gitignore/master/Unity.gitignore
    git add .
    git commit -m "Initial commit."
}
#   ------------------------------------------------------------
AAinstaBot()
{
    /Users/martinritter/Documents/Development/scripts/python/instapy-quickstart-master/quickstart_templates/AAinstaScript
}
#   ------------------------------------------------------------
MRinstaBot()
{
    tmux select-pane -t 1
    /Users/martinritter/Documents/Development/scripts/python/instapy-quickstart-master/quickstart_templates/MRinstaScript

  #  tmux detach
}
#   ------------------------------------------------------------
numberfiles()
{
	num=0;
	count=ls -l | wc -l
	chars=echo -n $num | wc -c

	for file in *;
		do
		mv "$file" "$(printf '%s_%04d' ${file%%.*} $chars $num).${file#*.}"; ((num++)); done
}
#   ------------------------------------------------------------
pdf2single()
{
	pdftk "$1" burst

	ls
}
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
mkcd()
{
	NAME="$1"

	mkdir -p "$NAME"
	cd "$NAME"
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

	cd /Applications

	echo 'Applications installed as of: ' $TODAY  > /Users/martinritter/MRcurrentApps.txt
	echo'' >>/Users/martinritter/MRcurrentApps.txt
	echo'' >>/Users/martinritter/MRcurrentApps.txt

	ls >> /Users/martinritter/MRcurrentApps.txt

	cd /Applications
}
#	make directory and go there
#   ------------------------------------------------------------
mkd () {

    mkdir -p "$1";
    cd "$1"
}
#	remove directory and list remaining content
#   ------------------------------------------------------------
rmd () {

	rm -rv "$1";
	lc
}
#	change directory and list content
#   ------------------------------------------------------------
cdl () {

	cd "$1";
	ls
}
#	delete file and list content of folder
#   ------------------------------------------------------------
rml (){

	echo "$1";
	rm -v "$1";
	lc
}
#   ------------------------------------------------------------
mvl (){

	_path=$(dirname -- "$1")
	_target="${_path%/}/$2"

	mv -i "$1" "$2"
	cd "$_target"
	lc
}
#   ------------------------------------------------------------
#   ------------------------------------------------------------
#move all files of type $1 to a folder in the same location named $1_repo
MRrepo () {

	if [ $# -eq 0 ]; then
   		{ echo 'No arguments provided' >$2; }

	else 	#one argument -> extension type
		if [ $# -eq 1 ]; then
			local _folder=repo_$1

			mkdir -pv $_folder
			mv *.$1 $_folder/
		fi
		#two arguments -> extension type and folder name
		if [ $# -eq 2 ]; then
			local _folder=repo_$2

			mkdir -pv $_folder

			mv *.$1 $_folder/
		fi

		cd $_folder/
		lc
	fi
}
#   ------------------------------------------------------------
#move all files of type $1 to a folder in the same location named $1_repo
_MRrepo () {

	if [ $# -eq 1 ]; then
		local _folder=repo_"$1"

		mkdir -pv ./REPO/$_folder

		mv *."$1" ./REPO/$_folder/
	fi

	if [ $# -eq 2 ]; then
		local _folder=repo_"$2"

		mkdir -pv ./REPO/$_folder

		mv *."$1" ./REPO/$_folder/
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
				*)  	echo "no match for `$file`";;
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
		{ echo "‘$1’ is not a valid file!"; exit 1; }
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
MRpdfCollate()	{

	cd /Users/martinritter/pdfs/

	pdftk A="$1" B="$2" shuffle A Bend-1 output collated_pages.pdf

}
#   ------------------------------------------------------------
pdfImages() {

    pdfimages -png "$1" extracted_image
}
MRtest()	{

	my_file=`basename "$1"` # get full file name as a script  parameter and strip the path
	my_extension="${my_file##*.}"
	my_file="${my_file%.*}" # will return base file name before the extension

	echo "$my_file"
	echo "$my_extension"

    test=*.jpg;
    echo $test;

#	ls -lha >&2


#	echo "//////echo "${1:-100}" largest file locations////////"
	#DATE=$(date "+%Y-%m-%d% %H:%M:%S");

#	for i in "$(df -Hl | sed -n 's/.*\///p')"
#		do
#	i="$(df -Hl | sed -n 's/.*\///p')"

#		printf '%s\n' "$i" | while IFS= read -r line
#		do
 # 		 echo "$line"
#		done

#		done

#	rsync -naic /Users/martinritter/Desktop/Post-Praeludium\ Per\ Donau /Users/martinritter/Desktop/untitled\ folder


#	echo "repair volume ${dir##*/}"
 #   diskutil repairVolume ${dir##*/}


#	echo 'testing'

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

echo '.bash_profile reloaded...'

#MRsetTmux

source /Users/martinritter/.config/broot/launcher/bash/br