From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 20 Jul 2020 15:37:40 +0800
Subject: [LTP] [PATCH v2 1/7] tst_net.sh: Remove rsh support
In-Reply-To: <20200710172044.21592-2-pvorel@suse.cz>
References: <20200710172044.21592-1-pvorel@suse.cz>
 <20200710172044.21592-2-pvorel@suse.cz>
Message-ID: <5F1549C4.9030609@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/7/11 1:20, Petr Vorel wrote:
> rsh is not used nowadays. When was the first network library version
> added in 18739ff06 (2014), it was a default + and ssh replacement was
> optional. Netns based single machine testing was added in 5f8ca6cf0
> (2016). After 6 years it's time to drop legacy rsh.
>
> ssh based testing setup requires only RHOST variable, TST_USE_SSH has
> been removed as unneeded. Also check for ssh in tst_rhost_run().
>
> We still keep $LTP_RSH for some of the network stress tests, which has
> not been ported to tst_net.sh yet.
Hi Petr,

Acked-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Thanks,
Xiao Yang
> Suggested-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_net.sh | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index 806b540cd..7ba267eda 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -136,7 +136,7 @@ init_ltp_netspace()
>  # -b run in background
>  # -c CMD specify command to run (this must be binary, not shell builtin/function)
>  # -s safe option, if something goes wrong, will exit with TBROK
> -# -u USER for ssh/rsh (default root)
> +# -u USER for ssh (default root)
>  # RETURN: 0 on success, 1 on failure
>  tst_rhost_run()
>  {
> @@ -166,14 +166,12 @@ tst_rhost_run()
>  		return 1
>  	fi
>  
> -	if [ -n "${TST_USE_SSH:-}" ]; then
> -		output=`ssh -n -q $user@$RHOST "sh -c \
> -			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
> -	elif [ -n "${TST_USE_NETNS:-}" ]; then
> +	if [ -n "${TST_USE_NETNS:-}" ]; then
>  		output=`$LTP_NETNS sh -c \
>  			"$pre_cmd $cmd $post_cmd" $out 2>&1 || echo 'RTERR'`
>  	else
> -		output=`rsh -n -l $user $RHOST "sh -c \
> +		tst_require_cmds ssh
> +		output=`ssh -nq $user@$RHOST "sh -c \
>  			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
>  	fi
>  	echo "$output" | grep -q 'RTERR$' && ret=1



