From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 Jun 2018 12:56:00 +0200
Subject: [LTP] [PATCH v2] route: fix double add the same route
In-Reply-To: <20180623021103.3846-1-sunlw.fnst@cn.fujitsu.com>
References: <20180623021103.3846-1-sunlw.fnst@cn.fujitsu.com>
Message-ID: <20180628105600.afnufrya4xn2rkx4@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Sun,

> "route -A inet6 add ${dst_network}/64 gw ${IPV6_NETWORK}:${rhost_part_hex} dev $lhost_ifname
> route -A inet6 del ${dst_network}/64 gw ${IPV6_NETWORK}:${pre_rhost_part_hex} dev $lhost_ifname"
> can't complete delete the have already added test route, This can result to add the same route
> when exec "ip -f inet6 route add ${dst_network}/64 via ${IPV6_NETWORK}:${rhost_part_hex} dev
> $lhost_ifname" and report error "RTNETLINK answers: File exists"

> Signed-off-by: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
> ---
>  testcases/network/stress/route/route6-change-gw | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

> diff --git a/testcases/network/stress/route/route6-change-gw b/testcases/network/stress/route/route6-change-gw
> index 96fd7ee66..be819f1c2 100644
> --- a/testcases/network/stress/route/route6-change-gw
> +++ b/testcases/network/stress/route/route6-change-gw
> @@ -245,8 +245,7 @@ test_body()
>  	    route -A inet6 del ${dst_network}/64 gw ${IPV6_NETWORK}:${pre_rhost_part_hex} dev $lhost_ifname
>  	    ;;
>  	    2)
> -	    ip -f inet6 route add ${dst_network}/64 via ${IPV6_NETWORK}:${rhost_part_hex} dev $lhost_ifname
> -	    ip -f inet6 route del ${dst_network}/64 via ${IPV6_NETWORK}:${pre_rhost_part_hex} dev $lhost_ifname
> +	    ip -f inet6 route change ${dst_network}/64 via ${IPV6_NETWORK}:${rhost_part_hex} dev $lhost_ifname
>  	    ;;
>  	esac
>  	if [ $? -ne 0 ]; then

Thank you for your patch, however I doubt that this solves all the problems. I would
rather completely rewrite all route stress tests. The problem is that they
depends on rsh. Anything which uses LTP_RSH (here via check_envval) just need to
be rewritten to use tst_net.sh first.

There is actually there is work-in-progress patch [1], [2].
I need to fix it some issues (the most important is to count the packets on the
receiver side), but even without this it works much reliable than previous
version.


Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2018-May/008153.html
[2] http://lists.linux.it/pipermail/ltp/2018-May/008152.html
