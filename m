From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 21 Feb 2018 10:12:29 +0100
Subject: [LTP] [RFC] [PATCH] shell: ROD_SILENT: Print std{out,
	err} on failure
In-Reply-To: <20180212150302.23347-1-chrubis@suse.cz>
References: <20180212150302.23347-1-chrubis@suse.cz>
Message-ID: <87efle670i.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis writes:

> Recently we had a problem when openQA (test automation framework) passed
> wrong device path as LTP_BIG_DEV. It has been much more complicated to
> debug because the error message from mkfs was not shown at all, since
> the tst_mkfs uses ROD_SILENT to execute the mkfs command.
>
> The best solution for ROD_SILENT is to store the command output into a
> variable and print it only on failure which is done by this patch.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/lib/test.sh     | 3 ++-
>  testcases/lib/tst_test.sh | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
> index 341c1f0f4..bce9893a9 100644
> --- a/testcases/lib/test.sh
> +++ b/testcases/lib/test.sh
> @@ -225,8 +225,9 @@ tst_timeout()
>  
>  ROD_SILENT()
>  {
> -	$@ > /dev/null 2>&1
> +	local tst_out=$($@ 2>&1)
>  	if [ $? -ne 0 ]; then
> +		echo "$tst_out"
>  		tst_brkm TBROK "$@ failed"
>  	fi
>  }
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index d6b638549..48afb9cc4 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -118,8 +118,9 @@ tst_brk()
>  
>  ROD_SILENT()
>  {
> -	tst_rod $@ > /dev/null 2>&1
> +	local tst_out=$(tst_rod $@ 2>&1)
>  	if [ $? -ne 0 ]; then
> +		echo "$tst_out"
>  		tst_brk TBROK "$@ failed"
>  	fi
>  }
> -- 
> 2.13.6

LGTM except that you could maybe use ${ } instead of $( ) as a small
optimisation.

-- 
Thank you,
Richard.
