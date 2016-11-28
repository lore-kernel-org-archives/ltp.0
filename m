From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 28 Nov 2016 16:05:10 +0100
Subject: [LTP] [PATCH v2 4/4] shell: fix echo -e bashisms, simplify code
In-Reply-To: <20161125210125.7299-4-petr.vorel@gmail.com>
References: <20161125210125.7299-1-petr.vorel@gmail.com>
 <20161125210125.7299-4-petr.vorel@gmail.com>
Message-ID: <20161128150510.GC4935@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- a/testcases/kernel/fs/acl/tacl_xattr.sh
> +++ b/testcases/kernel/fs/acl/tacl_xattr.sh
> @@ -85,7 +85,7 @@ if [ $? != 0 ]
>  then
>  	echo ""
>  	echo "FAILED:  [ losetup ] Must have loop device support by kernel"
> -	echo -e "\t to execute this script"
> +	printf "\t to execute this script\n"

I guess that it's a bit cleaner to use printf for the whole block just
to be consistent.

> diff --git a/tools/strace_test/slay b/tools/strace_test/slay
> index a68e8c9..7c0fe07 100755
> --- a/tools/strace_test/slay
> +++ b/tools/strace_test/slay
> @@ -119,7 +119,7 @@ do
>      echo -e "\\n\\n\\nI'm kicking your butt.\\n\\n\\n" | write $1 2>/dev/null
         ^
	 Missed one?

>    else
>      echo "${ME}: Sending $SIGSHOW signal to $1's process(es)..."
> -    echo -e "\\n\\n\\nYour current session has been terminated.\\n\\n\\n" | \
> +    printf "\\n\\n\\nYour current session has been terminated.\\n\\n\\n\n" | \
>      	write $1 2>/dev/null
>    fi
>    if [ "$SIGNAL" = "-clean" ]

Apart from that the patchset is obviously correct.

-- 
Cyril Hrubis
chrubis@suse.cz
