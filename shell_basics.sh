#!/bin/bash
#shell script basic learning
foo=bar
echo $foo #work well
foo = bar #not working error msg command not found : foo
#because shell think foo is a program and = is first argument and bar is second argument

echo "Hello World"
echo "Hello World $foo"
# Hello World bar
echo 'Hello World $foo'
# Hello World $foo

#function load into shell
mcd() {
    mkdir -p "$1" # The -p flag will create nested directories, but only if they don't exist already.
    cd "$1"
}
source xx.sh # execute this script in our shell and load it
# mcd function has been difeined into our shell
mcd test

# reserved commands
$0      #name of the script
$1 - $9 # args
$?      # get coed from the previous command if pre success 0 else 1
$_      # get the last arg of the pre command
$@      # all the args
$#      #passed in arsg numbers
$$      #pid
mkdir test
cd $_
#example
echo "Starting program at $(date)"
echo "Running program $0 with $# arguments with pid $$"
for file in "$@"; do
    grep foobar "$file" >/dev/null 2>/dev/null
    # when pattern has not found, grep has exit status 1
    # weredirect STDOUT and STDERR to a null register since we do not care about them

    if [[ "$?" -ne 0 ]]; then
        echo "File $file dose not have any foobar, adding one"
        echo "# foobar" >>"$file"
    fi
done
#elpmaxe

# !! bang bang
mkdir /mnt/new
# may alert Permission denied
sudo !! # replace with sudo mkdir /mnt/new

cd - # enter pre dir
ls *.sh

#stream 输入输出流
<file #rewire the input for this program to be contents of this file
#将该程序的输入重新连接为该文件的内容
>file #rewire the output of the proceeding  program into this file
#将正在进行的程序的输出重新连接到这个文件中
echo hello >hello.txt
cat hello.txt              # hello
cat <hello.txt             # hello
cat <hello.txt >hello2.txt # like cp
echo hello >>hello.txt     # append instead override
cat <(ls) <(ls ..)         #

# | pipe
# p1 | p2  take the output of the program to the left
# and make it the input of the program to the right
ls -l / | tail -n2 # get the last 2 line of the first program output
curl -L --head --silent baidu.com | grep -i content-length | cut --delimiter=' ' -f2

#tee
echo 1060 | sudo tee brightness
# tee    send to a file and see it yourself

#fancy staff if u got a email chekcer ,when u receive a email the scrolllocak lightsup
pwd
cd /sys/class/leds/input1::scrolllock
# change brightness of the scrolllock
echo 1 | sudo tee brightness # scrolllocl lightsup

#xdg-open
xdg-open xxx.html # open in a appropriate program

# || && ;
false || echo "will go through"
true || echo "won't go through"

false && echo "won't"
true && echo "will"

false
echo "always"

# getting the output of the program to a variable
foo=$(pwd)
echo $foo

convert image.png image.jpg
convert image.{png,jpg}
touch foo{,1,2} # touch foo foo1 foo2
touch project{1,2}/src/test/test{1,2,3}.py
touch{foo,bar}/{a..j} # touch foo/a touch foo/b ...
diff <(ls foo) <(ls bar)

#using python scripy in shell
#first specify where the interceptor is
#using
#!/usr/bin/env python
#instead
#!/usr/bin/python
#because different machines different dirs

shellcheck xx.sh

#fancy tools
yum install tldr
tldr wget # like man or --help
tldr tar

#find
find . -name src -type d # name is src and type is dir
#./nginx/src
#./nginx/objs/src
find . -path '**/test/*.py' -type f
find . -path '*.png' -type f
#./static/acfun_emo_0.png
#./static/acfun_emo_1.png
#./static/acfun_emo_10.png
find . -mtime -1 # modificatin time last day
find . -name "*.tmp" -exec rm {} \;
# better way use locate
locate *acfun.png
#this using index so u need to update index
updatedb

# grep
grep -R foobar . # recursive search
