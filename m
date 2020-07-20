From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 20 Jul 2020 16:49:18 +0800
Subject: [LTP] [PATCH v2 5/7] tst_net.sh: Drop 'sh -c' use from ssh in
 tst_rhost_run
In-Reply-To: <20200710172044.21592-6-pvorel@suse.cz>
References: <20200710172044.21592-1-pvorel@suse.cz>
 <20200710172044.21592-6-pvorel@suse.cz>
Message-ID: <5F155A8E.2000807@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/7/11 1:20, Petr Vorel wrote:
> This simplifies the command and allows to use double quotes in command
> parameter for ssh, as it removes single nested quotes of command
> parameter (thus fixes like c1a2d53f6 "network/nfs_lib.sh: Use double
> quotes for grep pattern" are not needed any more).
>
> NOTE: 'sh -c' is still required for netns based testing, but does not
> use nested quotes. Now both variants use only double quotes.
Hi Petr,

Acked-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Thanks,
Xiao Yang

> Suggested-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> Acked-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_net.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index 0a8b2a8ca..f6ac4c087 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -167,12 +167,12 @@ tst_rhost_run()
>  	fi
>  
>  	if [ -n "${TST_USE_NETNS:-}" ]; then
> -		output=`$LTP_NETNS sh -c \
> -			"$pre_cmd $cmd $post_cmd" $out 2>&1 || echo 'RTERR'`
> +		output=$($LTP_NETNS sh -c \
> +			"$pre_cmd $cmd $post_cmd" $out 2>&1 || echo 'RTERR')
>  	else
>  		tst_require_cmds ssh
> -		output=`ssh -nq $user@$RHOST "sh -c \
> -			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
> +		output=$(ssh -nq $user@$RHOST \
> +			"$pre_cmd $cmd $post_cmd" $out 2>&1 || echo 'RTERR')
>  	fi
>  	echo "$output" | grep -q 'RTERR$' && ret=1
>  	if [ $ret -eq 1 ]; then



