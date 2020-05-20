From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 20 May 2020 22:25:25 +0800
Subject: [LTP] [PATCH 1/2] tst_net.sh: Print output on unexpected
 PASS/FAIL
In-Reply-To: <20200518211514.20445-1-pvorel@suse.cz>
References: <20200518211514.20445-1-pvorel@suse.cz>
Message-ID: <5EC53DD5.9000506@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

I tested the patchset and it also looks good to me.
BTW: These outputs are useful to locate the issue.

Reviewed-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Best Regards,
Xiao Yang
On 2020/5/19 5:15, Petr Vorel wrote:
> This helps debugging.
>
> Use $TMPDIR and PID to guarantee writable directory and unique file
> without the need to require TST_NEEDS_TMPDIR=1.
>
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
>   testcases/lib/tst_net.sh | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index 011b62267..bfed4a44d 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -250,22 +250,32 @@ tst_net_run()
>
>   EXPECT_RHOST_PASS()
>   {
> -	tst_rhost_run -c "$*">  /dev/null
> +	local log="$TMPDIR/log.$$"
> +
> +	tst_rhost_run -c "$*">  $log
>   	if [ $? -eq 0 ]; then
>   		tst_res_ TPASS "$* passed as expected"
>   	else
>   		tst_res_ TFAIL "$* failed unexpectedly"
> +		cat $log
>   	fi
> +
> +	rm -f $log
>   }
>
>   EXPECT_RHOST_FAIL()
>   {
> -	tst_rhost_run -c "$* 2>  /dev/null"
> +	local log="$TMPDIR/log.$$"
> +
> +	tst_rhost_run -c "$*">  $log
>   	if [ $? -ne 0 ]; then
>   		tst_res_ TPASS "$* failed as expected"
>   	else
>   		tst_res_ TFAIL "$* passed unexpectedly"
> +		cat $log
>   	fi
> +
> +	rm -f $log
>   }
>
>   # Get test interface names for local/remote host.



