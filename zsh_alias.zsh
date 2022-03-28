#   ------------------------------------------------------------
# 							Aliases
#   ------------------------------------------------------------
#https://explainshell.com/


alias x="exit"
alias c="clear"

alias fcpxreset='rm ~/Library/Application\ Support/.ffuserdata'

alias restartcoreaudio='sudo launchctl kickstart -kp system/com.apple.audio.coreaudiod'

alias cd-="cd -" #jump to previous directory
#alias -="cd-"
alias ..="cd .. && ls"
	alias ...="cd ../.. && ls"

alias topS="top -o cpu"
	alias tops="topS"

alias dus="du -sh"

alias wget="wget -c"
	# wget specific types
	alias getpdf="wget -r -A.pdf "
	alias getallpdf="wget -r -l1 -H -A.pdf "
	alias getjpeg="wget -r -A.jpg "
	# alias getmp3="wget -r -l1 -H -A mp3 " #-H follows links; careful!
	alias getmp3="wget -r -H -A.mp3 "
	alias getzip="wget -r -A.zip "

alias mv="mv -v "
	alias tcn='mv --force -t ~/.Trash '
	alias trash='tcn'
	alias del='tcn'

alias ditto="ditto -V "

alias ls="c && ls -pG "
		#--color=auto "
	# alias lm="ls | more"
	# #alias lss="ls |rev|sort|rev|more"	#sort by filetype
	# alias lss="dus ."
	# alias lsz="ls -lrS"
	# alias la="ls -ad .*" #--color=auto
	# alias ll="ls -lh"
	# alias lc="ls; echo ''; command ls -1 | wc -l; echo '     items'"
	# alias lcount="command ls -1 | wc -l"
	# #sort by recently modified (newest to oldest)
	# alias lt="ls -t"

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

alias openbash="openT ~/.zshrc"
	alias ob="openbash"
alias obs="openT ~/.config/starship.toml"

# remove all aliases... re-load the .bash_profile
alias rb="unalias -a; clear; source ~/.zshrc;"

alias opensim="open -n /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"

alias Max="open -n /Applications/Max.app"
	alias max="Max"

alias MRmax="cd /Users/martinritter/Documents/__MR/Music/Max/Max8; o."

alias Unity="open -n /Applications/Unity\ Hub.app"
	alias unity="Unity"

alias NaPro="open -n /Applications/NoteAbilityPro.app"
	alias napro="NaPro"
	alias naPro="NaPro"

alias monitor="open -a 'Activity Monitor'"

# alias matlab="/Applications/MATLAB_R2018a.app/bin/matlab -nodesktop"

alias MRscript="cdl /Users/martinritter/Documents/__MR/Development/Scripts/bash/"
	alias MRscripto="MRscript; o."

alias MRdev="cd /Users/martinritter/Documents/__MR/Development/"
	alias MRdevo="MRdev; o."

# alias ambipath="cdl /Users/martinritter/Documents/MATLAB/ambiResearch/matlabCode/ambisonic/Eigenmike"

# alias MRthesis="cd /Users/martinritter/Documents/School/CMD/thesis; o."
# 	alias MRthesisMat="cd /Users/martinritter/Documents/MATLAB/ambiResearch/matlabCode; o."
# 	alias MRthesisLatex="cd /Users/martinritter/Documents/School/CMD/thesis/Thesis_LATEX; o."

alias MRscores="cd /Users/martinritter/Documents/__MR/Music/MRscores/; o."

alias AA="ssh -p 22 alyssaaska@Alyssas-MacBook-Pro.local."
alias MRssh="ssh martinri@martin-ritter.com"

alias vsCode="code ."
	alias vscode="vsCode"
	alias vsc="vscode"

alias vsF="code -a ."
alias vsFolder=vsF
alias vsf=vsF

#   bib things
#   ------------------------------------------------------------
alias bibItalics="sed -i -e ‘s;{\\textless}i{\\textgreater};\\textit{;g’ -e ‘s;{\\textless}/i{\\textgreater};};g’ "
alias cpbib="cp -Rv /Users/martinritter/Documents/latex/MASTERbibFiles/*.bib ."

#	misc.
#   ------------------------------------------------------------
alias startServer="http-server --port 9000" #needs index.html inside of ./public

alias timer="utimer -s"
alias rtimer="utimer -c "

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
alias getipe='curl -w "\n" ipinfo.io/ip'

alias portuninstall="sudo port uninstall --follow-dependencies "

alias findempty="find . -type d -empty -mindepth 1 -print"
	alias delempty="find . -type d -empty -mindepth 1 -delete"

# find . -type f -atime +5 -exec ls {} \; #test the exec command before using it
# find . -type f -atime +365 -exec rm -rf {} \;
# find . -type f -size +10M -size -1G
# find . -type f -ctime +5 -ctime -10
# find path_A -maxdepth 1 -name "*AAA*" -exec mv {} path_B \;
# find . -type f -newermt 2017-09-24 ! -newermt 2017-09-25

# There is an option to find, -newermt, which allows direct date comparisons.
#It is documented under the “-newerXY” option, where X and Y represent sub-options,
#which in this example are X=m for modified date, and Y=t for literal time.
#So for example, “find . -newermt “Sep 1 2006” -and \! -newermt “Sep 10 2006” will
#match all files modified between Sep 1 2006 and Sep 10 2006.

#! The letters X and Y can be any of the following letters:
#  a – The access time of the file reference
#  B – The birth time of the file reference
#  c – The inode status change time of reference
#  m – The modification time of the file reference
#  t – reference is interpreted directly as a time



alias cow="c; fortune | cowsay; echo; echo \"------------------------------\""

alias num="numberfiles"
	alias _num="_numberfiles"
	alias num_="num"

#check zsh_functions.zsh for functionality
alias rms="rmSpace"
alias rmspace="rmSpace"

#see zsh_functions.zsh for functionality
alias newShell="vsShell"
alias newshell="newShell"

alias pingpi="ping raspberrypi"
alias piIp="dig +short raspberrypi" #"arp -na | grep -i 'b8:27:eb'"
alias piip="piIp"
alias piIP="piIp"
alias PIIP="piip"