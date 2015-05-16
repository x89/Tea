#!/bin/sh

# ISO 3103 defines a 6 minute standard tea brewing time.
teatime=360

red="\E[31m" #  Red
der="\E[0m" #  Clear

if [ -r "tea.flac" ]; then
    tea_file="tea.flac"
elif [ -r "tea.mp3" ]; then
    tea_file="tea.mp3"
else
     echo -e "${red}EMERGENCY!!! YOU WILL GET NO TEA WARNING.${der}"
fi

PrintUsage(){
echo "Defaults:"
echo "Brew 5 minutes with milk"
echo ""
echo "Options:"
echo "-t ISO 3103 tea"
echo "-s short brewing tea (i.e. green tea)"
echo "-l long brewing tea (i.e. herbal tea)"
echo "-m without milk"
echo "-c custom brewing time in seconds"
echo "-h or --help prints this"
exit 1
}

PrintDone(){ # JUST SOME ASCII FLUFF
echo ""
echo "   {  {     "
echo "    }  }    "
echo "  ,{--{-.   "
echo " (  }    )  "
echo " |\`-----´|_ "
echo " |       | \\ "
echo " |  Tea  | |"
echo " |       |_/"
echo " \\       /  "
echo "  \`-----´   "
}

commandpicker() {
    # Thanks to @moopie - github for this function
    if which mpv >&/dev/null; then
       player="mpv"
    elif which mplayer >&/dev/null; then
       player="mplayer -nogui"
    elif which vlc >&/dev/null; then
       player="vlc -I dummy --play-and-exit"
    else
        echo "We couldn't find a way to output sound when your tea is ready!"
    fi
}

commandpicker

while test $# -gt 0
do
case "$1" in
    -h)
        teahelp=1
    ;;

    --help)
        teahelp=1
    ;;

    -t)
        teatime="3m"
    ;;

    -l)
        teatime="4m"
    ;;

    -s)
        teatime="2m"
    ;;

    -m)
        milk=1;
    ;;

    -c)
        if [ $2 -gt 0 ] 2>/dev/null ; then
            teatime=$2
            echo "You are using a custom wait time: $2"
        else
            PrintUsage
        fi
    ;;

    -*)
        echo "this option does not exist: $1"
        teahelp=1
    ;;

    *)
    ;;
esac
shift
done

if [ ! -z ${teahelp} ]; then
    if [ ${teahelp} -eq 1 ]; then
        PrintUsage
        exit 1
    fi
fi

echo "You are using ${tea_file}."
echo "Have no fear! None! You will be warned when your tea is ready."

# Let's hae a wee counter, thanks @dunkyp
tyme=${teatime}
while [ ${tyme} -gt 0 ]
do
  awk "BEGIN{max=10 - ((${tyme} / ${teatime}) * 10); printf(\"[%.2f%%] \", max * 10, \"#\"); for(i=0;i<max;i++)printf(\"#\")}"
  printf '\r'
  sleep 1
  tyme=`expr ${tyme} - 1`
done
printf "[100%%] ##########\n"

if [ -z $milk ]; then
    PrintDone
    echo "YOUR TEA IS NOW READY, PUT THE MILK IN NOW!!!!"
elif [ ! -z $milk ]; then
    PrintDone
    echo "YOUR TEA IS NOW READY!"
fi

$player $tea_file &>/dev/null || \
echo "We couldn't play your tea file." &>/dev/null

