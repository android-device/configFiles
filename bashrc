#
#  Define home, user
#
export HOME=/home/demodev
export USER=demodev
export PATH="/bin:/usr/bin:$PATH"
export COM="$HOME/wrk/sys/com"
export AKB="/mnt/demodev/akb/home/abiyani"

#
#  Now load bash general settings
#
if [ -f "$COM/bash-more" ]
then
    . "$COM/bash-more"
fi

#
#  Load project specific settings
#
if [ -f "$COM/bosch-aliases" ]
then
    . "$COM/bosch-aliases"
fi

#  Everything included & defined. Now define commands we will use
if [ -f "$COM/bosch-commands" ]
then
    . "$COM/bosch-commands"
fi

#
#  QNX settings that override.
#
if [ "$PROJ" == "qnx" ]
then
    source /c/akb/win/qnx660/qnx660-env.sh
fi

#  /usr/local/bin must be first.
PATH="/usr/local/bin:$PATH"

#  Define PROMPT.
export PS1="[\W\$:\!] "

#  Remove duplicates from PATH
PATH=$(perl -e 'print join ":", grep {!$h{$_}++} split ":", $ENV{PATH}')

func_save_context ()
{
    pushd . >> /dev/null
}

func_restore_context ()
{
    popd >> /dev/null
}

func_vbox_image_create ()
{
    func_save_context

    VBOX_EXE="/c/akb/win/vbox/VBoxManage.exe"
    VBOX_OPTS="convertfromraw --format VDI"

    IN_DIR="/c/akb/tmp"
    IN_FILE_NAME="ias-prj-fca-image-mentor-gr-mrb-64.hddimg"
    IN_FILE="$IN_DIR/$IN_FILE_NAME"

    OUT_DIR="/d/vbox/fcademo"
    OUT_FILE_NAME="fcademo.vdi"
    OUT_FILE="$OUT_DIR/$OUT_FILE_NAME"

    if [ ! -f "$IN_FILE" ]
    then
        echo "$FUNCNAME: Input file $IN_FILE not found. Aborting ..."
        return 1
    fi

    if [ ! -d "$OUT_DIR" ]
    then
        echo "$FUNCNAME: Output directory $OUT_DIR not found. Aborting ..."
        return 1
    fi

    cd $IN_DIR
    if [ -f "$OUT_FILE_NAME" ]
    then
        ask "$FUNCNAME: File $OUT_FILE_NAME exists. Remove?"
		if [ $? == "1" ]
		then
			echo "$FUNCNAME: aborting ..."
			return 1
		fi
		rm "$OUT_FILE_NAME"
    fi

    $VBOX_EXE $VBOX_OPTS $IN_FILE_NAME $OUT_FILE_NAME
    cp -v $OUT_FILE_NAME $OUT_FILE
    rm $OUT_FILE_NAME

    func_restore_context
}

sendtext () { curl http://textbelt.com/text -d number=2484625516 -d "message=$1";echo message sent; }

alias mountData='sudo mount -t vboxsf data ~/vbox'

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /home/demodev/Downloads/powerline/powerline/bindings/bash/powerline.sh
export LESS='-R'
export LESS='-N'
export LESSOPEN='|~/.lessfilter %s'

alias nano='vim'
alias emacs='vim'
alias gedit='vim'
alias kate='vim'
alias note='vim'
alias notepage='vim'
alias notepad='vim'
