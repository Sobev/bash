# vim_basic.md
# Lecture 3 https://www.youtube.com/watch?v=a6Q8Na575qc
yum install vim

:help :w 帮助文档

`注意ctrl+v 也可用^V <c-v> 表示`
vim分为normal mode，insert mode，visual(line, block) mode，command mode，和operator mode
通常字符以英文意思为主  例如: i 和 a 分别表示插入和添加 w-write, b beginning of a word , e end of a word
大小写的意思也不同 L Lowest line shown on the screen, M middle...,H ... 

## 1.分屏 sp: OR vsp: 垂直分屏
切换分屏 ^ww ^wj ^wk ^wh ^wl ^wo
:q 退出当前屏幕 :qa 退出所有屏幕

## 2.hjkl 切换光标 left down up right
4j do j 4 times

:set number 显示行号 :set nonumber 取消行号
:set ruler 显示列号

0 begin of the line, 
$ end of the line, 
^ first non-blank character

^-u 光标向上移动
^-d 光标向下移动

G 光标移动到最后一行
gg 光标移动到第一行

## find
press fo --- find the first occurrence of the char 'o' 向右
press Fo --- find the first occurrence of the char 'o' 向左
      fw --- find the first occurrence of the char 'w' 向右
      Fw --- find the first occurrence of the char 'w' 向左

press tr --- find the r and cursor to its left
press Tr --- find the r on the left side and cursor to its right

## insert
o opens new line below the current line
O opens new line above the current line

## delete
d delete, needs to combines with another command
dd delete the line
dw delete word
de delete end of the word, aei_ou ou will be deleted
7dw delete 7 words

c change, similar to d, but it will delete and go to insert mode
cc change the line and put u into insert mode
ce change end of the word

x delete a character
r replace a character ra replace a character with 'a'

## undo and redo
u undo
ctrl+R redo


## visual using hjkl move cursor and select word
press v OR (Caps大写)V(select whole line a time) AND ctrl+v visual block mode(选择一块方形区域)
after enter visual mode, press 3 times e, select 3 words
y for yank(copy) 
p for paste

## modifier commands

% jump between [ and ]
ci[ change inside [], delete word in [hello there]
ci(
da( delete include ()

. repeat last command





