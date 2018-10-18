From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 18 Oct 2018 14:40:57 +0300
Subject: [LTP] [PATCH 1/1] net: Introduce $TST_PING
In-Reply-To: <20181008115849.30826-1-pvorel@suse.cz>
References: <20181008115849.30826-1-pvorel@suse.cz>
Message-ID: <40613a15-b157-df57-1ec9-1eccb0cc1f0d@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 10/08/2018 02:58 PM, Petr Vorel wrote:
> and use it in ipneigh01.sh and tst_ping().
> 
> iputils commit ebad35f ("ping: merge `ping6` command into `ping`"),
> released in s20150815 stopped providing ping6 and left it on
> distributions.
> 
> Unfortunately we cannot use 'ping -${TST_IPVER}' as ping got '-6' switch
> (as a part of support for IPv6) was in commit 25aaaf4 ("Allow ping to
> use IPv6 addresses"), released in s20150815 (previous versions supported
> only ping6).
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_net.sh                        | 16 ++++++++++++----
>  testcases/network/tcp_cmds/ipneigh/ipneigh01.sh |  4 ++--
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index a4467da7c..278bf4c15 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -18,11 +18,12 @@ TST_SETUP="tst_net_setup"
>  # Blank for an IPV4 test; 6 for an IPV6 test.
>  TST_IPV6=${TST_IPV6:-}
>  TST_IPVER=${TST_IPV6:-4}
> +TST_PING="ping$TST_IPV6"
>  
>  tst_net_parse_args()
>  {
>  	case $1 in
> -	6) TST_IPV6=6 TST_IPVER=6;;
> +	6) TST_IPV6=6 TST_IPVER=6 TST_PING="ping6"; tst_net_fix_ping_cmd;;
>  	*) $TST_PARSE_ARGS_CALLER "$1" "$2";;
>  	esac
>  }
> @@ -61,7 +62,15 @@ tst_net_setup()
>  	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
>  }
>  
> +tst_net_fix_ping_cmd()
> +{
> +	if [ -n "$TST_IPV6" ]; then
> +		tst_cmd_available $TST_PING || TST_PING="ping -${TST_IPVER}"
> +	fi
> +}
> +
>  [ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
> +tst_net_fix_ping_cmd

It is called twice, i.e. also in tst_net_parse_args(), though it should be
enough to have it only here?

>  
>  if [ "$TST_PARSE_ARGS_CALLER" = "$TST_PARSE_ARGS" ]; then
>  	tst_res TWARN "TST_PARSE_ARGS_CALLER same as TST_PARSE_ARGS, unset it ($TST_PARSE_ARGS)"
> @@ -570,14 +579,13 @@ tst_ping()
>  	local dst_addr="${2:-$(tst_ipaddr rhost)}"; shift $(( $# >= 2 ? 2 : 0 ))
>  	local msg_sizes="$*"
>  	local msg="tst_ping IPv${TST_IPV6:-4} iface $src_iface, msg_size"
> -	local cmd="ping$TST_IPV6"
>  	local ret=0
>  
> -	tst_test_cmds $cmd
> +	tst_test_cmds $TST_PING
>

For IPv4 tests we would eventually need tst_ping() with IPv6, so that TST_IPV6
is empty, for example for some tunnels that are working for both protocols over
IPv4, checking dst address to decide which command to use. I've not posted the
patch yet, I guess I will do it after this one.

So I think we shouldn't use TST_PING variable...  it could be the new variable
for the ping6 only, or some general wrapper for the both commands?

Or may be something like this:

ping6()
{
    ping -6 $@
}

if which ping6 >/dev/null 2>&1; then
    unset ping6
fi

  
>  	# ping cmd use 56 as default message size
>  	for size in ${msg_sizes:-"56"}; do
> -		$cmd -I $src_iface -c $PING_MAX $dst_addr \
> +		$TST_PING -I $src_iface -c $PING_MAX $dst_addr \
>  			-s $size -i 0 > /dev/null 2>&1
>  		ret=$?
>  		if [ $ret -eq 0 ]; then
> diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> index e22e17aae..558057d9c 100755
> --- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> +++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> @@ -45,7 +45,7 @@ do_setup()
>  		;;
>  	esac
>  
> -	tst_test_cmds $CMD ping$TST_IPV6
> +	tst_test_cmds $CMD $TST_PING

Are you sure it will work with the "ping -6" command as expected?


>  }
>  
>  usage()
> @@ -69,7 +69,7 @@ do_test()
>  
>  	for i in $(seq 1 $NUMLOOPS); do
>  
> -		ping$TST_IPV6 -q -c1 $(tst_ipaddr rhost) > /dev/null || \
> +		$TST_PING -q -c1 $(tst_ipaddr rhost) > /dev/null || \
>  			tst_brk TFAIL "cannot ping $(tst_ipaddr rhost)"
>  
>  		local k
> 

