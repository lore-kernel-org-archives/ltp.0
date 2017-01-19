From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Jan 2017 18:50:49 +0100
Subject: [LTP] [PATCH 3/3] test_net.sh: netns as default in tst_rhost_run
In-Reply-To: <20161221230422.26696-3-pvorel@suse.cz>
References: <20161221230422.26696-1-pvorel@suse.cz>
 <20161221230422.26696-3-pvorel@suse.cz>
Message-ID: <20170119175049.de6ocki7ebyxnbpa@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> netns can be set by test_net.sh when RHOST is unset, but user wants to
> use ssh, so it should be first tested.

> Tested with:
> TST_USE_SSH=1 ./testscripts/network.sh -6

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Even it's configuration error, we should handle it as before netns was user
> warned about config error.
> ---
>  testcases/lib/test_net.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index 535a2abb3..8fc14c588 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -88,12 +88,12 @@ tst_rhost_run()

>  	local output=
>  	local ret=0
> -	if [ -n "$TST_USE_SSH" ]; then
> -		output=`ssh -n -q $user@$RHOST "sh -c \
> -			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
> -	elif [ -n "$TST_USE_NETNS" ]; then
> +	if [ -n "$TST_USE_NETNS" ]; then
>  		output=`$LTP_NETNS sh -c \
>  			"$pre_cmd $cmd $post_cmd" $out 2>&1 || echo 'RTERR'`
> +	elif [ -n "$TST_USE_SSH" ]; then
> +		output=`ssh -n -q $user@$RHOST "sh -c \
> +			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
>  	else
>  		output=`rsh -n -l $user $RHOST "sh -c \
>  			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`

How about this patch? (just this one, please ignore 1st and 2nd) NACK?


Kind regards,
Petr
