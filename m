From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 1 Dec 2016 16:26:40 +0100
Subject: [LTP] [PATCH v3 4/4] shell: fix echo -e bashisms, simplify code
In-Reply-To: <20161129082240.16473-4-petr.vorel@gmail.com>
References: <20161129082240.16473-1-petr.vorel@gmail.com>
 <20161129082240.16473-4-petr.vorel@gmail.com>
Message-ID: <20161201152632.GA9941@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
> Changes v2->v3:
> * convert one more echo -e (slay)
> * use printf consistently (tacl_xattr.sh, slay)
> 
> There could have been more cleanup done in (tacl_xattr.sh: print errors into
> stderr, ...), but some script aren't called anywhere (tacl_xattr.sh,
> statslogging, mixed_load.sh, slay), I suppose I should have delete them instead
> of fixing.

The script slay seems to be called from go_go.sh, quite likely the whole
strace_test is not useful for anything these days when we have several
syscall fuzzers available. We should most likely get rid of the whole
strace_test directory.

The tacl_xattr.sh should be probably investigated and either fixed or
removed.

The statslogging script seems to be part of pounder21, there are some
tar archives that contain test screnarios with symlinks that may point
to the files in the test_scripts directory. So simple git grepping will
not help in this case.

The mixed_load.sh seems to be unused, probably leftover.

> diff --git a/tools/strace_test/slay b/tools/strace_test/slay
> index a68e8c9..d3571c0 100755
> --- a/tools/strace_test/slay
> +++ b/tools/strace_test/slay
> @@ -115,11 +115,11 @@ do
>    COOL="1"
>    if [ "$SLAY_BUTTHEAD" = "on" ]
>    then
> -    echo "${ME}: $SIGSHOW is kicking $1's butt!"
> -    echo -e "\\n\\n\\nI'm kicking your butt.\\n\\n\\n" | write $1 2>/dev/null
> +    printf "${ME}: $SIGSHOW is kicking $1's butt!\n"
> +    printf "\\n\\n\\nI'm kicking your butt.\\n\\n\\n\n" | write $1 2>/dev/null
>    else
> -    echo "${ME}: Sending $SIGSHOW signal to $1's process(es)..."
> -    echo -e "\\n\\n\\nYour current session has been terminated.\\n\\n\\n" | \
> +    printf "${ME}: Sending $SIGSHOW signal to $1's process(es)...\n"
> +    printf "\\n\\n\\nYour current session has been terminated.\\n\\n\\n\n" | \

I'm a bit puzzled by the double backslashes here. I guess that the
double backslash is reduced by shell to a single backslash and then
echo/printf command gets just plain old \n in ARGV[]. But as this code
will likely get removed anyway I've applied this patch as it is.


Whole series applied, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
