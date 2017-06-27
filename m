From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Jun 2017 16:53:33 +0200
Subject: [LTP] [PATCH 4/4] lib/test: run ROD_BASE() & tst_rod() with
 'timeout' cmd
In-Reply-To: <1495615230-29045-5-git-send-email-alexey.kodanev@oracle.com>
References: <1495615230-29045-1-git-send-email-alexey.kodanev@oracle.com>
 <1495615230-29045-5-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20170627145333.GA2625@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 087adda..c4fbe86 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -116,7 +116,7 @@ tst_brk()
>  
>  ROD_SILENT()
>  {
> -	tst_rod $@ > /dev/null 2>&1
> +	$TST_TIMECMD tst_rod $@ > /dev/null 2>&1

It would be a bit cleaner to add the timeout capability to the tst_rod
and pass timeout to tst_rod as a first parameter here. Which would fix
the second (below) that I have for this patch.

>  	if [ $? -ne 0 ]; then
>  		tst_brk TBROK "$@ failed"
>  	fi
> @@ -124,7 +124,7 @@ ROD_SILENT()
>  
>  ROD()
>  {
> -	tst_rod "$@"
> +	$TST_TIMECMD tst_rod "$@"
>  	if [ $? -ne 0 ]; then
>  		tst_brk TBROK "$@ failed"
>  	fi
> @@ -132,7 +132,7 @@ ROD()
>  
>  EXPECT_PASS()
>  {
> -	tst_rod "$@"
> +	$TST_TIMECMD tst_rod "$@"
>  	if [ $? -eq 0 ]; then
>  		tst_res TPASS "$@ passed as expected"
>  	else
> @@ -143,7 +143,7 @@ EXPECT_PASS()
>  EXPECT_FAIL()
>  {
>  	# redirect stderr since we expect the command to fail
> -	tst_rod "$@" 2> /dev/null
> +	$TST_TIMECMD tst_rod "$@" 2> /dev/null
>  	if [ $? -ne 0 ]; then
>  		tst_res TPASS "$@ failed as expected"
>  	else
> @@ -430,3 +430,6 @@ else
>  		tst_brk TBROK "Unexpected positional arguments '$@'"
>  	fi
>  fi
> +
> +command -v timeout > /dev/null 2>&1 && \
> +	TST_TIMECMD="timeout -s 9 $((300 * ${LTP_TIMEOUT_MUL:-1}))s"

I do not like that we silently disable the timeout if 'timeout' command
is not available. I would rather add tst_timeout.c helper to the lib/ as
we do for instance for tst_sleep to support sub-second sleep intervals.

-- 
Cyril Hrubis
chrubis@suse.cz
