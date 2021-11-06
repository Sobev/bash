#Data Wrangling
#https://missing.csail.mit.edu/2020/data-wrangling/
#https://regex101.com/
#!/bin/bash

#sed stands for stream editor
#s means substitute 代替
cat general.log | sed 's/.*Disconneted from//' #this line means to substitute the regexp with ""
cat general.log | sed 's/.*Disconneted from//' | wc -l #wc for word count and l for line count
#this line means to substitute the regexp with "" and count the number of lines

cat general.log | sed 's/.*Disconneted from//' | sort | uniq -c | sort -nr 
#uniq -c means count the number of times the word appears
#sort means sort the lines
#sort -nr means sort in descending order


echo abc | sed 's/[ab]//'
#output is bc, because the regexp only matches once under the condition
#if u want to match more than one time, u can use the 'g' flag
echo abc | sed 's/[ab]//g'
#output is c, because the regexp matches more than one time
echo abc | sed 's/[A-Za-z]//g'
#replace A-Za-z with nothing globally

echo abcab | sed -E 's/(ab)*//g' # -E means extended regexp, which is more powerful than the standard one
#if u if standard regep use s/\(ab\)\*//g, it will work
#means that replace any thing matches and only matches ab and sustitutes with nothing
#output is c

#regexp
Jan 17 03:13:00 thesquareplanet.com sshd[2631]: Disconnected from invalid user joie Disconnected from 46.97.239.16 port 55920 [preauth]
^.*Disconnected from (invalid | authencating )?user (.*) Disconnected from [0-9.]+ port [0-9]+ \[.*]?$
#w if user name is Disconnected from? will this regexp work 
#if want work just add to first pattern .*?, add a ?,let it not to be greedy

# get the user name joie
#Jan 17 03:13:00 thesquareplanet.com sshd[2631]: Disconnected from invalid user joie Disconnected from 46.97.239.16 port 55920 [preauth]
#Jan 17 03:13:00 thesquareplanet.com sshd[2631]: Disconnected from invalid user Disconnected from invalid user joie Disconnected from 46.97.239.16 port 55920 [preauth] Disconnected from 46.97.239.16 port 55920 [preauth]

#log.txt
Oct 31 05:01:17 vultr sshd[14160]: Failed password for invalid user masud from 49.233.117.138 port 42884 ssh2
Oct 31 05:16:01 vultr sshd[14231]: Failed password for invalid user bmh from 49.233.117.138 port 51962 ssh2
Oct 31 05:19:45 vultr sshd[14256]: Failed password for invalid user julien from 115.159.58.206 port 21124 ssh2
Oct 31 05:22:54 vultr sshd[14285]: Failed password for invalid user kjv from 222.239.248.170 port 46066 ssh2
Oct 31 05:30:32 vultr sshd[14322]: Failed password for invalid user ossuser from 159.223.24.19 port 41794 ssh2
Oct 31 05:31:12 vultr sshd[14325]: Failed password for invalid user oracle from 213.229.102.134 port 34101 ssh2
cat log.txt | grep "Failed password for invalid user" 
| sed -E 's/^.*Failed password for (invalid)? user(.*)from [0-9.]+ port [0-9]+ ssh2$/\2/' | sort -nr | uniq -c | sort -nrk1,1 | head -n10
# sort -nrk1,1,1 means start at 1 column end at 1 column, -n means sort by number, r means reverse,1 means 
# k means select a white space separated column from the input
# head -n10 means select the first 10 lines
# tail -n10 means select the last 10 lines
# uniq -c means count the number of times the word appears
# k在这里也可以不需要  默认是从左到右排序
cat log.txt | grep "Failed password for invalid user" | sed -E 's/^.*Failed password for (invalid)? user(.*)from [0-9.]+ port [0-9]+ ssh2$/\2/' | sort -nr | uniq -c | sort -nr | head -n10 | awk '{print $2}' | paste -sd,
# awk '{print $2}' means print the second column
# paste -sd, means paste the output with a comma in a -s single line

#awk
cat log.txt | grep "Failed password for invalid user" 
| sed -E 's/^.*Failed password for (invalid)? user(.*)from [0-9.]+ port [0-9]+ ssh2$/\2/' 
| sort -nr | uniq -c | awk '$1 == 1 && $2 ~ /^c.*e$/ {print $0}'
# $0 means the whole line
#stay tuned