From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 May 2018 19:09:18 +0200
Subject: [LTP] [PATCH v3 1/1] ipneigh : Use new API
In-Reply-To: <20180517090711.10577-1-asmorodskyi@suse.com>
References: <20180517090711.10577-1-asmorodskyi@suse.com>
Message-ID: <20180517170918.qj2svkrqlbftmfjd@dell5510>
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
> 3. add input parameter "-c" which allows to control
> which command will be used
> ---
>  runtest/net.ipv6                                |  2 +-
>  runtest/net.tcp_cmds                            |  3 +-
>  testcases/network/tcp_cmds/ipneigh/ipneigh01.sh | 82 +++++++++++++++----------
>  3 files changed, 53 insertions(+), 34 deletions(-)

> diff --git a/runtest/net.ipv6 b/runtest/net.ipv6
> index d8f85cc31..261a7254c 100644
> --- a/runtest/net.ipv6
> +++ b/runtest/net.ipv6
> @@ -7,4 +7,4 @@ tracepath601 tracepath01.sh -6
>  traceroute601 traceroute01.sh -6
>  dhcpd6 dhcpd_tests.sh -6
>  dnsmasq6 dnsmasq_tests.sh -6
> -ipneigh601 ipneigh01.sh -6
> +ipneigh6_ip ipneigh01.sh -6 -c ip
> diff --git a/runtest/net.tcp_cmds b/runtest/net.tcp_cmds
...
> -TCID=ipneigh01
>  NUMLOOPS=${NUMLOOPS:-50}
> -TST_TOTAL=2
> -TST_USE_LEGACY_API=1

do_setup() function is not run, there is TST_SETUP variable to tell API it's the setup
function (it's called before testing):
TST_SETUP="do_setup"

> +TST_TESTFUNC=do_test
> +TST_OPTS=":c"
This is wrong, it supposed to be:
TST_OPTS="c:"
TST_OPTS definition working as normal option-string for getopts.
':' as very first character of the option-string silent error message and -c then does not
expect parameter, so tests TBROK:
ipneigh01 1 TBROK: Unexpected positional arguments 'ip'

> +TST_PARSE_ARGS="parse_args"
> +TST_USAGE="usage"
>  . tst_net.sh

> +usage()
> +{
> +	echo "-c  Test command (ip, $IF_CMD)"
if-lib.sh has slightly different behavior ($IF_CMD is specific to if-lib.sh), use
something like:
	echo "-c [ arp | ip ] Test command"
> +}
> +
> +parse_args()
> +{
> +	case $1 in
> +	c) IP_CMD="$2";;
It'd be better to use more generic variable, like $CMD.
> +	esac
> +}
> +
> +
>  do_setup()
>  {
>  	tst_require_root
This is wrong, I overlook it in v2.
New API uses TST_NEEDS_ROOT=1 variable (put before loading tst_net.sh)

> -	tst_check_cmds arp grep ping$TST_IPV6
> +	tst_check_cmds arp grep
grep is quite common, we don't check it 
And, Please, change arp to $CMD.
	tst_check_cmds arp

>  }

>  do_test()
>  {
> -	local arp_show_cmd="$1"
> -	local arp_del_cmd="$2"
> +	local rhost=$(tst_ipaddr rhost)

> +	case $IP_CMD in
> +	ip)
> +		local show_cmd="ip neigh show"
> +		local del_cmd="ip neigh del $rhost dev $(tst_iface)"
> +	;;
> +	arp)
> +		if [ -n "$TST_IPV6" ] then
                            ^ Again missing semicolon, breaks test.
							You can find these failures yourself if you run tests before posting patch.

You can provide your own file with tests cases you want, put that file in /opt/ltp/runtest/
$ cat /opt/ltp/runtest/test
ipneigh6_ip ipneigh01.sh -6 -c ip
ipneigh01_arp ipneigh01.sh -c arp
ipneigh01_ip ipneigh01.sh -c ip

$ PASSWD=your-root-password /opt/ltp/testscripts/network.sh -f test

> +			tst_res TCONF "'arp cmd doesn't support IPv6, skipping test-case"
> +			return 1
> +		fi
> +		local show_cmd="arp -a"
> +		local del_cmd="arp -d $rhost"
> +	;;
> +	esac

>  	local entry_name
>  	[ "$TST_IPV6" ] && entry_name="NDISC" || entry_name="ARP"
I prefer to use:
	local entry_name="ARP"
	[ "$TST_IPV6" ] && entry_name="NDISC"

> -	tst_resm TINFO "Stress auto-creation of $entry_name cache entry"
> -	tst_resm TINFO "by pinging '$rhost' and deleting entry again"
> -	tst_resm TINFO "with '$arp_del_cmd'"
> +	tst_res TINFO "Stress auto-creation of $entry_name cache entry"
> +	tst_res TINFO "by pinging '$rhost'"
> +	tst_res TINFO "and deleting entry again with '$del_cmd'"
> +	tst_res TINFO "in a loop with $NUMLOOPS iterations"
Probably this would be enough:
	tst_res TINFO "Stress auto-creation of $entry_name cache entry $NUMLOOPS times"

>  	for i in $(seq 1 $NUMLOOPS); do

> -		ping$TST_IPV6 -q -c1 $rhost > /dev/null
> +		tst_ping
tst_ping is noisy as it reports TPASS, which is not purpose of this test.
I'm sorry, can you put back the previous version, with TFAIL?
		ping$TST_IPV6 -q -c1 $rhost > /dev/null || \
			tst_brk TFAIL "cannot ping $rhost"

>  		local k
>  		local ret=1
> -		# wait for arp entry at least 3 seconds
>  		for k in $(seq 1 30); do
> -			$arp_show_cmd | grep -q $rhost
> +			$show_cmd | grep -q $rhost
>  			if [ $? -eq 0 ]; then
>  				ret=0
>  				break;
> @@ -57,28 +85,18 @@ do_test()
>  		done

>  		[ "$ret" -ne 0 ] && \
> -			tst_brkm TFAIL "$entry_name entry '$rhost' not listed"
> -
> -		$arp_del_cmd
> -
> -		$arp_show_cmd | grep -q "${rhost}.*$(tst_hwaddr rhost)" && \
> -			tst_brkm TFAIL "'$arp_del_cmd' failed, entry has " \
> +			tst_brk TFAIL "$entry_name entry '$rhost' not listed"
> +		$del_cmd
> +		if [ $? -ne 0 ]; then
> +			tst_brk TFAIL "fail to delete entry"
> +		fi
This can be shortened:
		$del_cmd ||	tst_brk TFAIL "fail to delete entry"

...

Kind regards,
Petr
