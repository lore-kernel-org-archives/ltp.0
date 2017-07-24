From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 24 Jul 2017 18:54:01 +0300
Subject: [LTP] [RFC PATCH v7 02/11] network/stress: Add library
 test_net_stress.sh
In-Reply-To: <20170721040407.868-3-pvorel@suse.cz>
References: <20170721040407.868-1-pvorel@suse.cz>
 <20170721040407.868-3-pvorel@suse.cz>
Message-ID: <fddf6fa1-3a12-5035-482f-08fe83fcb47e@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 07/21/2017 07:03 AM, Petr Vorel wrote:
> + use it in interface stress tests
>
> test_net_stress.sh:
> * test_net_stress.sh library is intended to be used throughout all
>   stress tests reduce duplicity and use code from test_net.sh where
>   possible instead of legacy scripts in testcases/network/stress/ns-tools/.
> * TCID set automatically from basename.
> * Add "unused network" related variables. So far used only IPv4 ones.
> * Functions from if-lib.sh moved and (and some renamed) to
>   test_net_stress.sh as they are going to be reused in other tests (not
>   just interface stress tests).
>
> Interfaces tests:
> * Interfaces tests use test_net_stress.sh.
> * Remove restore_ipaddr from cleanup functions as these functions would
>   break netns testing with RTNETLINK errors. Use them just in setup during
>   if-mtu-change where are really needed.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> I'll port this library to be able to test also IPv6.
> ---
>  testcases/lib/test_net.sh                          |  21 ++-
>  testcases/network/stress/interface/if-addr-adddel  |  15 +-
>  .../network/stress/interface/if-addr-addlarge      |  16 +-
>  testcases/network/stress/interface/if-lib.sh       |  73 ---------
>  testcases/network/stress/interface/if-mtu-change   |  23 +--
>  testcases/network/stress/interface/if-route-adddel |  17 +-
>  .../network/stress/interface/if-route-addlarge     |  15 +-
>  testcases/network/stress/interface/if-updown       |   9 +-
>  testcases/network/stress/interface/if4-addr-change |   4 +-
>  testcases/network/stress/ns-tools/Makefile         |   2 +-
>  .../network/stress/ns-tools/test_net_stress.sh     | 171 +++++++++++++++++++++
>  11 files changed, 229 insertions(+), 137 deletions(-)
>  delete mode 100644 testcases/network/stress/interface/if-lib.sh
>  create mode 100644 testcases/network/stress/ns-tools/test_net_stress.sh
>
> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index 10cf6da3a..178df3527 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -428,6 +428,7 @@ tst_ping()
>  	local src_iface="${1:-$(tst_iface)}"
>  	local dst_addr="${2:-$(tst_ipaddr rhost)}"; shift $(( $# >= 2 ? 2 : 0 ))
>  	local msg_sizes="$*"
> +	local msg="tst_ping IPv${TST_IPV6:-4} iface $src_iface, msg_size"
>  	local ret=0
>  
>  	# ping cmd use 56 as default message size
> @@ -436,9 +437,9 @@ tst_ping()
>  			-s $size -i 0 > /dev/null 2>&1
>  		ret=$?
>  		if [ $ret -eq 0 ]; then
> -			tst_resm TINFO "tst_ping IPv${TST_IPV6:-4} msg_size $size pass"
> +			tst_resm TINFO "$msg $size: pass"
>  		else
> -			tst_resm TINFO "tst_ping IPv${TST_IPV6:-4} msg_size $size fail"
> +			tst_resm TINFO "$msg $size: fail"
>  			break
>  		fi
>  	done
> @@ -535,6 +536,22 @@ export RHOST_IPV6_HOST="${RHOST_IPV6_HOST:-:1}"
>  export IPV4_NET16_UNUSED="${IPV4_NET16_UNUSED:-10.23}"
>  export IPV6_NET32_UNUSED="${IPV6_NET32_UNUSED:-fd00:23}"
>  
> +export OCTET_3_IPV4_UNUSED=${OCTET_3_IPV4_UNUSED:-23} # x.x.N.x
> +export OCTET_4_LHOST_IPV4_HOST_UNUSED=${OCTET_4_LHOST_IPV4_HOST_UNUSED:-2} # x.x.x.N
> +export OCTET_4_RHOST_IPV4_HOST_UNUSED=${OCTET_4_RHOST_IPV4_HOST_UNUSED:-1} # x.x.x.N
> +export LHOST_IPV4_HOST_UNUSED="${OCTET_3_IPV4_UNUSED}.${OCTET_4_LHOST_IPV4_HOST_UNUSED}"
> +export RHOST_IPV4_HOST_UNUSED="${OCTET_3_IPV4_UNUSED}.${OCTET_4_RHOST_IPV4_HOST_UNUSED}"
> +export LHOST_IPV4_UNUSED="${IPV4_NET16_UNUSED}.$LHOST_IPV4_HOST_UNUSED"
> +export RHOST_IPV4_UNUSED="${IPV4_NET16_UNUSED}.$RHOST_IPV4_HOST_UNUSED"
> +
> +export OCTET_3_IPV6_UNUSED="${OCTET_3_IPV6_UNUSED:-:0}"
> +export OCTET_4_LHOST_IPV6_HOST_UNUSED=${OCTET_4_LHOST_IPV6_HOST_UNUSED:-2}
> +export OCTET_4_RHOST_IPV6_HOST_UNUSED=${OCTET_4_RHOST_IPV6_HOST_UNUSED:-1}
> +export LHOST_IPV6_HOST_UNUSED="${OCTET_3_IPV6_UNUSED}:${OCTET_4_LHOST_IPV6_HOST_UNUSED}"
> +export RHOST_IPV6_HOST_UNUSED="${OCTET_3_IPV6_UNUSED}:${OCTET_4_RHOST_IPV6_HOST_UNUSED}"
> +export LHOST_IPV6_UNUSED="${IPV6_NET32_UNUSED}:$LHOST_IPV6_HOST_UNUSED"
> +export RHOST_IPV6_UNUSED="${IPV6_NET32_UNUSED}:$RHOST_IPV6_HOST_UNUSED"
> +

Hmm, what is the purpose of adding these variables to the library?
Why someone would need to redefine any of them?

>  export HTTP_DOWNLOAD_DIR="${HTTP_DOWNLOAD_DIR:-/var/www/html}"
>  export FTP_DOWNLOAD_DIR="${FTP_DOWNLOAD_DIR:-/var/ftp}"
>  export FTP_UPLOAD_DIR="${FTP_UPLOAD_DIR:-/var/ftp/pub}"

...

> +
> +# check_connectivity_interval CNT [RESTORE] [SRC_IFACE] [DST_ADDR]
> +# CNT: loop step.
> +# RESTORE: whether restore ip addr.
> +# SRC_IFACE: source interface name.
> +# DST_ADDR: destination IPv4 or IPv6 address.
> +check_connectivity_interval()
> +{
> +	local cnt="$1"
> +	local restore="${2:-false}"
> +	local src_iface="${3:-$(tst_iface)}"
> +	local dst_addr="${4:-$(tst_ipaddr rhost)}"
> +
> +	[ $CHECK_INTERVAL -eq 0 ] && return
> +
> +	[ $(($cnt % $CHECK_INTERVAL)) -ne 0 ] && return
> +
> +	[ "$restore" != "false" ] && restore_ipaddr
> +
> +	check_connectivity $src_iface $dst_addr $cnt
> +	return $?
> +}

No need for 'return $?', the last command determines exit status for a
function.

> +
> +# Run netstress process on both lhost and rhost.
> +# make_background_tcp_traffic [IP]
> +# IP: server IP. Default value is $(tst_ipaddr)
> +make_background_tcp_traffic()
> +{
> +	local port=$(tst_get_unused_port ipv${ipver} stream)
> +	local ip="${1:-$(tst_ipaddr)}"
> +
> +	ROD netstress -R 3 -g $port > /dev/null 2>&1 &
> +	tst_rhost_run -s -b -c "netstress -l -H $ip -g $port"

There is no point in adding 'ROD' and '-s' option for tst_rhost_run() if
it's started in background.

Thanks,
Alexey
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170724/b6966ad0/attachment.html>
