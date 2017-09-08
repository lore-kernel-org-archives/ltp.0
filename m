From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 8 Sep 2017 10:32:06 +0300
Subject: [LTP] [RFC PATCH v9 7/7] network: Use tools to set up IPv4 and
 IPv6 related variables
In-Reply-To: <20170824234436.18145-8-pvorel@suse.cz>
References: <20170824234436.18145-1-pvorel@suse.cz>
 <20170824234436.18145-8-pvorel@suse.cz>
Message-ID: <ec1c3df8-1b3f-3412-f402-6bde02a6739d@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08/25/2017 02:44 AM, Petr Vorel wrote:
> Tools (tst_net_ip_prefix, tst_net_iface_prefix, tst_net_vars)
> simplify setup as it only needs to have passed 4 IP addresses
> (IPv4 lhost + rhost and IPv6 lhost + rhost).
>
> It's possible to define different network part for local
> and remote hosts.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/test_net.sh                          | 95 ++++++++++++++--------
>  testcases/network/stress/interface/if4-addr-change | 17 ++--
>  2 files changed, 74 insertions(+), 38 deletions(-)
>
> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index f72e4755f..654200c61 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -218,19 +218,10 @@ tst_read_opts $*
>  tst_ipaddr()
>  {
>  	local type="${1:-lhost}"
> -	local ipv="${TST_IPV6:-4}"
> -	local tst_host
> -
> -	if [ "$type" = "lhost" ]; then
> -		eval "tst_host=\$LHOST_IPV${ipv}_HOST"
> -	else
> -		eval "tst_host=\$RHOST_IPV${ipv}_HOST"
> -	fi
> -
>  	if [ "$TST_IPV6" ]; then
> -		echo "${IPV6_NETWORK}:${tst_host}"
> +		[ "$type" = "lhost" ] && echo "$IPV6_LHOST" || echo "$IPV6_RHOST"
>  	else
> -		echo "${IPV4_NETWORK}.${tst_host}"
> +		[ "$type" = "lhost" ] && echo "$IPV4_LHOST" || echo "$IPV4_RHOST"
>  	fi
>  }
>  
> @@ -333,9 +324,13 @@ tst_add_ipaddr()
>  {
>  	local type="${1:-lhost}"
>  	local link_num="${2:-0}"
> +	local mask
>  
> -	local mask=24
> -	[ "$TST_IPV6" ] && mask=64
> +	if [ "$TST_IPV6" ]; then
> +		[ "$type" = "lhost" ] && mask=$IPV6_LPREFIX || mask=$IPV6_RPREFIX
> +	else
> +		[ "$type" = "lhost" ] && mask=$IPV4_LPREFIX || mask=$IPV4_RPREFIX
> +	fi
>  
>  	local iface=$(tst_iface $type $link_num)
>  
> @@ -589,24 +584,57 @@ export PASSWD="${PASSWD:-}"
>  export LTP_RSH="${LTP_RSH:-rsh -n}"
>  
>  # Test Links
> -# Set first three octets of the network address, default is '10.0.0'
> -export IPV4_NETWORK="${IPV4_NETWORK:-10.0.0}"
> -# Set local host last octet, default is '2'
> -export LHOST_IPV4_HOST="${LHOST_IPV4_HOST:-2}"
> -# Set remote host last octet, default is '1'
> -export RHOST_IPV4_HOST="${RHOST_IPV4_HOST:-1}"
> -# Set the reverse of IPV4_NETWORK
> -export IPV4_NET_REV="${IPV4_NET_REV:-0.0.10}"
> -# Set first three octets of the network address, default is 'fd00:1:1:1'
> -export IPV6_NETWORK="${IPV6_NETWORK:-fd00:1:1:1}"
> -# Set local host last octet, default is '2'
> -export LHOST_IPV6_HOST="${LHOST_IPV6_HOST:-:2}"
> -# Set remote host last octet, default is '1'
> -export RHOST_IPV6_HOST="${RHOST_IPV6_HOST:-:1}"
> -
> -# Networks that aren't reachable through the test links
> -export IPV4_NET16_UNUSED="${IPV4_NET16_UNUSED:-10.23}"
> -export IPV6_NET32_UNUSED="${IPV6_NET32_UNUSED:-fd00:23}"
> +# IPV{4,6}_{L,R}HOST can be set with or without prefix (e.g. IP or IP/prefix),
> +# but if you use IP/prefix form, /prefix will be removed by tst_net_vars.
> +IPV4_LHOST="${IPV4_LHOST:-10.0.0.2/24}"
> +IPV4_RHOST="${IPV4_RHOST:-10.0.0.1/24}"
> +IPV6_LHOST="${IPV6_LHOST:-fd00:1:1:1::2/64}"
> +IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1/64}"
> +
> +# tst_net_ip_prefix
> +# Strip prefix from IP address and save both If no prefix found sets
> +# default prefix.
> +#
> +# tst_net_iface_prefix reads prefix and interface from rtnetlink.
> +# If nothing found sets default prefix value.
> +#
> +# tst_net_vars exports environment variables related to test links and
> +# networks that aren't reachable through the test links.
> +#
> +# For full list of exported environment variables see:
> +# tst_net_ip_prefix -h
> +# tst_net_iface_prefix -h
> +# tst_net_vars -h
> +if [ -z "$TST_PARSE_VARIABLES" ]; then
> +	tst_resm TINFO "Parsing IP and prefixes from IPv4 lhost: '$IPV4_LHOST'," \
> +		"rhost: '$IPV4_RHOST', IPv6 lhost: '$IPV6_LHOST', rhost: '$IPV6_RHOST'"
> +	eval $(tst_net_ip_prefix $IPV4_LHOST || echo "exit $?")
> +	eval $(tst_net_ip_prefix -r $IPV4_RHOST || echo "exit $?")
> +	eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")
> +	eval $(tst_net_ip_prefix -r $IPV6_RHOST || echo "exit $?")
> +fi
> +
> +[ -n "$TST_USE_NETNS" -a "$TST_INIT_NETNS" != "no" ] && init_ltp_netspace
> +
> +if [ -z "$TST_PARSE_VARIABLES" ]; then
> +	tst_resm TINFO "Parsing prefixes and ifaces from rtnetlink"
> +	eval $(tst_net_iface_prefix $IPV4_LHOST || echo "exit $?")
> +	eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV4_RHOST \
> +		|| echo "exit $?")
> +	eval $(tst_net_iface_prefix $IPV6_LHOST || echo "exit $?")
> +	eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV6_RHOST \
> +		|| echo "exit $?")
> +
> +	tst_resm TINFO "Parsing all remaining variables from IPv4 lhost:" \
> +		"'$IPV4_LHOST/$IPV4_LPREFIX', rhost: '$IPV4_RHOST/$IPV4_RPREFIX'," \
> +		"IPv6 lhost: '$IPV6_LHOST/$IPV6_LPREFIX', rhost: '$IPV6_RHOST/$IPV6_RPREFIX'"
> +	eval $(tst_net_vars $IPV4_LHOST/$IPV4_LPREFIX $IPV4_RHOST/$IPV4_RPREFIX \
> +		|| echo "exit $?")
> +	eval $(tst_net_vars $IPV6_LHOST/$IPV6_LPREFIX $IPV6_RHOST/$IPV6_RPREFIX \
> +		|| echo "exit $?")
> +

Changed tst_resm messages (+ printing interfaces) and applied, thank you!

  tst_resm TINFO "Network config (local -- remote):"
  tst_resm TINFO "$LHOST_IFACES -- $RHOST_IFACES"
  tst_resm TINFO "$IPV4_LHOST/$IPV4_LPREFIX -- $IPV4_RHOST/$IPV4_RPREFIX"
  tst_resm TINFO "$IPV6_LHOST/$IPV6_LPREFIX -- $IPV6_RHOST/$IPV6_RPREFIX"

Best regards,
Alexey

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170908/a9550689/attachment.html>
