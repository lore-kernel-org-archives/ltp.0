From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Jan 2019 15:02:42 +0100
Subject: [LTP] [PATCH] change ip command of route6-change-gw
In-Reply-To: <20190115020846.625-1-yangj.fnst@cn.fujitsu.com>
References: <20190115020846.625-1-yangj.fnst@cn.fujitsu.com>
Message-ID: <20190115140241.GA16344@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jian,

> when useing old ip commond to test,it will get the following
>  error:

> RTNETLINK answers: File exists

> So I changed this case like the ip command of route4-change-gw
> Signed-off-by:jian yang <yangj.fnst@cn.fujitsu.com>
> ---
>  testcases/network/stress/route/route6-change-gw | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

> diff --git a/testcases/network/stress/route/route6-change-gw b/testcases/network/stress/route/route6-change-gw
> index 96fd7ee66..05e45b907 100644
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

Thanks for your patch, merged.

FYI these tests are in terrible state, needs complete rewrite, see [1].
I've already had several attempts in the past, last one [2] still wasn't good
enough. Currently I'm rewritting route*-change-* tests into C using rtnetlink.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/issues/440
[2] https://patchwork.ozlabs.org/project/ltp/list/?series=44924&state=*
