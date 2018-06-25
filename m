From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 Jun 2018 10:41:20 +0200
Subject: [LTP] [PATCH ltp] kernel/fs/doio/rwtest: fix shellcheck error
In-Reply-To: <20180525074447.26298-1-yixin.zhang@intel.com>
References: <20180525074447.26298-1-yixin.zhang@intel.com>
Message-ID: <20180625084120.r42fr73grqeyzaot@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yixin,

thanks for your patch, we appreciate your effort.
There are some comments bellow. Even if you fix them, patches like this one
doesn't help much. The script is really ugly, requires a rewrite which would:

1) Be posix compliant. I.e.: remove all bashisms (arrays, typeset, regex
in [[ ... ]], etc.). It's good to use checkbashism.pl script and run it in dash
to test it:
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#132-shell-coding-style
https://salsa.debian.org/debian/devscripts/raw/master/scripts/checkbashisms.pl

2) Use LTP new shell API
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#23-writing-a-testcase-in-shell

Rewriting the script would be a great improvement. If you decide to do so,
please do not hesitate to ask for help (if needed).

Kind regards,
Petr

> testcases/kernel/fs/doio/rwtest:199:12: error: > is for string comparisons. Use -gt instead. [SC2071]
> testcases/kernel/fs/doio/rwtest:320:10: error: Globs are ignored in [[ ]] except right of =/!=. Use a loop. [SC2203]
> testcases/kernel/fs/doio/rwtest:347:7: error: Couldn't parse this test expression. [SC1073]
> testcases/kernel/fs/doio/rwtest:347:25: error: Expected test to end here (don't wrap commands in []/[[]]).
>                                                Fix any mentioned problems and try again. [SC1072]

...
> +++ b/testcases/kernel/fs/doio/rwtest
> @@ -196,7 +196,7 @@ do	case $1 in
>  	-n | -Dn )
>  		dOpts="$dOpts $1 $2"
>  		# force file locking with > 1 process
> -		if [[ $2 > 1 ]]
> +		if [[ $2 -gt 1 ]]
Why not use posix compliant syntax? I.e. single square brackets:
if [ $2 -gt 1 ]; then

>  		then
>  			dOpts="$dOpts -k"
>  		fi
> @@ -317,7 +317,7 @@ do
>  		typeset -i n=0
>  		while (( n < ${#szcache[*]} ))
>  		do
> -			if [[ szcache[$n] = $dir ]]; then
> +			if [[ ${szcache[n]} = $dir ]]; then
Well, correct, but we'd like to drop arrays, as they're bashisms.
>  				break;
>  			fi
>  			n=n+1
> @@ -344,7 +344,7 @@ do

>  			# check if blks is a number, else set a default value for blks
>  			default_sz=1000000
> -			if [ $blks -eq $blks 2> /dev/null ]
> +			if [ $blks -eq $blks ] 2>/dev/null
The shellcheck warning was meant to be without square brackets:
if $blks -eq $blks 2>/dev/null; then

