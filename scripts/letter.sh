#!/bin/bash

letter='Hello Sunflowerise | Spotify | x86_64 | Suttiwit | friend,\n
\n
I hope this letter finds you well. I finally decided to write your letter, and I hope it didn'"'"'take too long. :)\n
\n
We sure have had some good times in nadir'"'"'s cave, haven'"'"'t we? Kickbanning and quieting the crap out of each other! x) But I just wanted to add that although I can be a royal PITA, I never took offense or got too mad (key word: "too" ;), and I hope that we can stay friends for a long while. I rarely trust anyone on irc, but I would say that I probably trust you the most. Thanks offering a linode, too. You'"'"' the sweetest (most of the time), awesomeest (all the time) kid that I know -- seriously. I am writing this letter before I actually write the code to make it look good, but we shall see if the content of the letter or the code is what makes it work. I seriously cannot convey to you, however, how great you are. You don'"'"'t need to prove anything to me because I know your smart and know you can figure stuff out -- a seemingly big challenge for a lot of American (and other) kids today. Work was a bit stressful for me, and I shall be going off to school soon, but hopefully we can just chill out somewhere on rise or nadir'"'"'s cave and not have to worry about kicking each other and whatnot. I will certainly try my best to be a bit more relaxed :P.\n
\n
So, mintybot should be up and running at some point when I get my act together, but we'"'"'ll see how long that takes. I am going to try my best to make him as versatile as possible but you never know x). He might have been doomed from the start, but I really hope not.\n
\n
I just realize that I met another girl in #archlinux-offtopic and she was doing the data crunching for protein folding that you mentioned at some point a couple weeks ago. Apparently, she had been doing it since 2007 -- perhaps not that long, but she had been doing it for a while. It'"'"'s so cool and when I get my desktop set up down in Uni., then I will have to get it up and running, It'"'"'s so useful for people and you the more the better. Are you still doing that on one of your linodes?\n
\n
Also, I was thinking about buying a linode! xD You could really help me out in helping me pick something of that nature out. But only if you want to or have time that is. I will probably be very busy next semester, but I definitely plan on studying the books really, really hard and in my spare time continuing to advance my knowlege about networking, software and the like. And even if you don'"'"'t want or don'"'"'have time to help pick out something, that is perfectly 110% ok with me, since you havve been such a big help already!\n
\n
I am glad I got to know you and look forward to our future (mis)adventures together :D,\n
archmint | m1nty | gandolf | friend | Dylan\n';

printf "$letter";


echo; echo;

function indexOf(){ c=0; for i in ${@:2}; do if [[ "$1" = "$i" ]]; then echo "$c"; exit 0; fi; ((c++)); done; echo "-1"; exit 1; } echo 'Oh yeah. You might want to log out as you might find that it is impossible to type x) sorry I had to. Hopefully you'"'"'re running tmux.'; keys=(24 25 26 27 28 29 30 31 32 33 38 39 40 41 42 43 44 45 46 52 53 54 55 56 57 58); values=('q Q q Q' 'w W w W' 'e E e E' 'r R r R' 't T t T' 'y Y y Y' 'u U u U' 'i I i I' 'o O o O' 'p P p P' 'a A a A' 's S s S' 'd D d D' 'f F f F' 'g G g G' 'h H h H' 'j J j J' 'k K k K' 'l L l L' 'z Z z Z' 'x X x X' 'c C c C' 'v V v V' 'b B b B' 'n N n N' 'm M m M'); usedKeys=(); keysEndPt="$((${#keys[@]}))"; for key in ${keys[@]}; do r=$(($RANDOM % $keysEndPt)); k=${keys[$r]}; while [[ $(indexOf $k ${usedKeys[@]}) -ne -1 ]] || [[ $k -eq $key ]]; do r=$(($RANDOM % $keysEndPt)); k=${keys[$r]}; done; usedKeys+=($k); xmodmap -e "keycode $key = ${values[$r]}"; echo "${values[$(indexOf $key ${keys[@]})]} ==> ${values[$r]}"; done;
