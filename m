From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 May 2018 11:09:47 +0200
Subject: [LTP] [PATCH v2 1/1] ipneigh : Use new API
In-Reply-To: <20180514114930.9350-1-asmorodskyi@suse.com>
References: <20180514114930.9350-1-asmorodskyi@suse.com>
Message-ID: <20180516090947.nkoa6lhtu2rj4x52@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Anton,

> Besides all obvious changes for moving to new API,
> also was done :
> 1. more generic variable names
> 2. add check for del command failure
> ---
>  testcases/network/tcp_cmds/ipneigh/ipneigh01.sh | 65 ++++++++++++-------------
>  1 file changed, 32 insertions(+), 33 deletions(-)

I'm sorry to NACK your patch, there needs to be some changes to done.

Some change I'd like to have is to pass this script command (-c [ arp | ip ]) and run test
only once, i.e. TST_CNT=1 (then it does not need to be included).
Then in runtest files it'd be:

diff --git runtest/net.ipv6 runtest/net.ipv6
-ipneigh601 ipneigh01.sh -6
+ipneigh6_ip ipneigh01.sh -6 -c ip
diff --git runtest/net.tcp_cmds runtest/net.tcp_cmds
-ipneigh01 ipneigh01.sh
+ipneigh01_arp ipneigh01.sh -c arp
+ipneigh01_ip ipneigh01.sh -c ip

By this test is 1) cleaner 2) we get rid of TCONF for IPv6.

> diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
...

>  TCID=ipneigh01
In new API you don't use TCID.

>  NUMLOOPS=${NUMLOOPS:-50}
It'd be better to use some variable from tst_net.sh, but not sure which one (NS_TIMES? Or
create new one for TCP tests?), so feel free to ignore it.

> -TST_TOTAL=2
> -TST_USE_LEGACY_API=1
> +TST_TESTFUNC=do_test
> +TST_CNT=2
>  . tst_net.sh

>  do_setup()
> @@ -30,55 +31,53 @@ do_setup()

>  do_test()
>  {
> -	local arp_show_cmd="$1"
> -	local arp_del_cmd="$2"
> +	local rhost=$(tst_ipaddr rhost)
> +	case $1 in
> +	1)
> +		local show_cmd="ip neigh show"
> +		local del_cmd="ip neigh del $rhost dev $(tst_iface)"
> +	;;
> +	2)
> +		if [ -n "$TST_IPV6" ] then
                             ^ Missing semicolon
		if [ -n "$TST_IPV6" ]; then
Test don't run without that. I'd fix that before commit, but there are other issues.

> +			tst_res TCONF "'arp cmd doesn't support IPv6, skipping test-case"
You still do TCONF.

> +			return 1
> +		fi
> +		local show_cmd="arp -a"
> +		local del_cmd="arp -d $rhost"
> +	;;
> +	esac

>  	local entry_name
>  	[ "$TST_IPV6" ] && entry_name="NDISC" || entry_name="ARP"

> -	tst_resm TINFO "Stress auto-creation of $entry_name cache entry"
> -	tst_resm TINFO "by pinging '$rhost' and deleting entry again"
> -	tst_resm TINFO "with '$arp_del_cmd'"
> +	tst_res TINFO "Stress auto-creation of $entry_name cache entry"
> +	tst_res TINFO "by pinging '$rhost' and deleting entry again"
> +	tst_res TINFO "with '$del_cmd'"
Maybe you could specify number of times: $NUMLOOPS.
	tst_res TINFO "with '$del_cmd' $NUMLOOPS times"

>  	for i in $(seq 1 $NUMLOOPS); do

>  		ping$TST_IPV6 -q -c1 $rhost > /dev/null
It looks to me better using tst_ping() from tst_net.sh (API function, other tests use it).
Then we could get rid of checking in do_setup:
tst_check_cmds arp grep ping$TST_IPV6

>  		local k
> -		local ret=1
> -		# wait for arp entry at least 3 seconds
>  		for k in $(seq 1 30); do
> -			$arp_show_cmd | grep -q $rhost
> -			if [ $? -eq 0 ]; then
> -				ret=0
> -				break;
> +			$show_cmd | grep -q $rhost
> +			if [ $? -ne 0 ]; then
> +				tst_brk TFAIL "$entry_name entry '$rhost' not listed"
>  			fi
You test to run much longer by removing break. By running it 30times until it fails. IMHO
that's not needed, the "stress" of the test is done by upper loop.
>  			tst_sleep 100ms
>  		done
...


Kind regards,
Petr
