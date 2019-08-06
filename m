From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 6 Aug 2019 16:38:12 +0300
Subject: [LTP] [PATCH v3 4/5] network/route: Rewrite route-change-gw
 into new API
In-Reply-To: <20190725111027.18716-5-pvorel@suse.cz>
References: <20190725111027.18716-1-pvorel@suse.cz>
 <20190725111027.18716-5-pvorel@suse.cz>
Message-ID: <89188a02-2213-bea7-5273-d0077de5878e@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 7/25/19 2:10 PM, Petr Vorel wrote:
> * Drop route command (use just ip command), support both IPv4 and IPv6
> * Use unused network range to avoid clash with real network
> * Add verification with ping (previous version sent UDP datagram with
> ns-udpsender, but didn't verify receiving it on rhost and didn't setup
> rhost ip at all)
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  runtest/net_stress.route                      |   4 +-
>  .../network/stress/route/00_Descriptions.txt  |  18 +-
>  .../network/stress/route/route-change-gw      |  38 +++
>  .../network/stress/route/route4-change-gw     | 292 ------------------
>  .../network/stress/route/route6-change-gw     | 292 ------------------
>  5 files changed, 43 insertions(+), 601 deletions(-)
>  create mode 100755 testcases/network/stress/route/route-change-gw
>  delete mode 100644 testcases/network/stress/route/route4-change-gw
>  delete mode 100644 testcases/network/stress/route/route6-change-gw
> 
> ...
> +
> +# Change route gateway
> +# lhost: 10.23.x.2, gw (on rhost): 10.23.x.1, rhost: 10.23.0.1
> +
> +TST_TESTFUNC="test_gw"
> +. route-lib.sh
> +
> +setup()
> +{
> +	tst_res TINFO "change IPv$TST_IPVER route gateway $NS_TIMES times"
> +
> +	rt="$(tst_ipaddr_un -m 0 0)"
> +	lhost="$(tst_ipaddr_un 1 1)"
> +	rhost="$(tst_ipaddr_un 0 1)"
> +	tst_add_ipaddr -s -a $lhost
> +	tst_add_ipaddr -s -a $rhost rhost
> +}
> +
> +test_gw()
> +{
> +	local gw="$(tst_ipaddr_un 1 $(($1 + 1)))"

We should keep $(($1 + 1)) within the valid range except already added IP address
($lhost), i.e. for IPv4 the range is 2..254 for host id:

    local gw="$(tst_ipaddr_un 1 $(($1 % 253 + 2)))"

Either we could limit the value here or in the tst_ipaddr_un(). Looks like
route-change-if needs a similar fix for net id?


> +	local iface="$(tst_iface)"
> +
> +	tst_res TINFO "testing route over gateway '$gw'"
> +
> +	tst_add_ipaddr -s -a $gw rhost
> +	ROD ip route replace $rt dev $iface via $gw

May be it would be cleaner to use "add" instead of "replace" since we remove it
and it shouldn't exist before a test start.

> +	EXPECT_PASS ping$TST_IPV6 -c1 -I $lhost $rhost

It is better to redirect stdout to null:

EXPECT_PASS ping$TST_IPV6 -c1 -I $lhost $rhost \>/dev/null

The same for *-if and *-dst.

The rest in the patch-set looks good to me.

> +	ROD ip route del $rt dev $iface via $gw
> +	tst_del_ipaddr -s -a $gw rhost
> +}
> +
> +tst_run
