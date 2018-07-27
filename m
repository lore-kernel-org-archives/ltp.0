From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 27 Jul 2018 16:01:40 +0300
Subject: [LTP] [PATCH v2 1/1] network/route: Rewrite route-change-dst
 into new API
In-Reply-To: <20180723072332.22179-1-pvorel@suse.cz>
References: <20180723072332.22179-1-pvorel@suse.cz>
Message-ID: <25966119-9937-727a-9df0-c5a636d22582@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07/23/2018 10:23 AM, Petr Vorel wrote:
> Drop route command (use just ip command), simplify.
> 
> Use "unused" IP for routes (not affect real traffic).
> 
> Validate connection with UDP, sent over tst_netload.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> I wonder if this really stress the interface enough.  I still have in
> mind to rewrite route-change-{dst,gw,if} into C (use RTNETLINK), that
> would be more stressful.
> Another option is to have both implementations
> - shell based with tst_netload validation and
> - C based which just changes destination/gateway/interface without
>   validating route
> 
> Comments are welcome.
> 
> Kind regards,
> Petr
> ---
>  runtest/net_stress.route                      |   4 +-
>  .../network/stress/ns-tools/tst_net_stress.sh |   2 +-
>  .../network/stress/route/00_Descriptions.txt  |  17 +-
>  .../network/stress/route/route-change-dst     |  47 +++
>  .../network/stress/route/route4-change-dst    | 276 ------------------
>  .../network/stress/route/route6-change-dst    | 272 -----------------
>  6 files changed, 53 insertions(+), 565 deletions(-)
>  mode change 100644 => 100755 testcases/network/stress/ns-tools/tst_net_stress.sh
>  create mode 100755 testcases/network/stress/route/route-change-dst
>  delete mode 100644 testcases/network/stress/route/route4-change-dst
>  delete mode 100644 testcases/network/stress/route/route6-change-dst
> 
> diff --git a/runtest/net_stress.route b/runtest/net_stress.route
> index 266ef0383..b6ea11c2e 100644
> --- a/runtest/net_stress.route
> +++ b/runtest/net_stress.route
> @@ -2,13 +2,13 @@
>  # Stress test for routing table
>  #
>  
> -route4-change-dst route4-change-dst
> +route4-change-dst route-change-dst
>  route4-change-gw route4-change-gw
>  route4-change-if route4-change-if
>  route4-redirect route4-redirect
>  route4-rmmod route4-rmmod
>  
> -route6-change-dst route6-change-dst
> +route6-change-dst route-change-dst -6
>  route6-change-gw route6-change-gw
>  route6-change-if route6-change-if
>  route6-redirect route6-redirect
> diff --git a/testcases/network/stress/ns-tools/tst_net_stress.sh b/testcases/network/stress/ns-tools/tst_net_stress.sh
> old mode 100644
> new mode 100755
> index e5c2672a3..0e97e68a8
> --- a/testcases/network/stress/ns-tools/tst_net_stress.sh
> +++ b/testcases/network/stress/ns-tools/tst_net_stress.sh
> @@ -107,7 +107,7 @@ check_connectivity_interval()
>  	check_connectivity $src_iface $dst_addr $cnt
>  }
>  
> -# Run netstress process on both lhost and rhost.
> +# Run netstress TCP process on both lhost and rhost.
>  # make_background_tcp_traffic [IP]
>  # IP: server IP; Default value is $(tst_ipaddr).
>  make_background_tcp_traffic()
> diff --git a/testcases/network/stress/route/00_Descriptions.txt b/testcases/network/stress/route/00_Descriptions.txt
> index 2a871fdae..e9e4d7961 100644
> --- a/testcases/network/stress/route/00_Descriptions.txt
> +++ b/testcases/network/stress/route/00_Descriptions.txt
> @@ -1,10 +1,7 @@
> -route4-change-dst01
> -	Verify the kernel is not crashed when the destination of an IPv4 route
> -	is changed frequently by route command
> +route-change-dst
> +	Verify the IPv4/IPv6 is not broken when ip command changes route
> +	destination many times
>  
> -route4-change-dst02
> -	Verify the kernel is not crashed when the destination of an IPv4 route
> -	is changed frequently by ip command
>  
>  route4-change-gw01
>  	Verify the kernel is not crashed when the gateway of an IPv4 route is
> @@ -35,14 +32,6 @@ route4-rmmod02
>  	then it is deleted by the removing network driver
>  
>  
> -route6-change-dst01
> -	Verify the kernel is not crashed when the destination of an IPv6 route
> -	is changed frequently by route command
> -
> -route6-change-dst02
> -	Verify the kernel is not crashed when the destination of an IPv6 route
> -	is changed frequently by ip command
> -
>  route6-change-gw01
>  	Verify the kernel is not crashed when the gateway of an IPv6 route is
>  	changed frequently by route command
> diff --git a/testcases/network/stress/route/route-change-dst b/testcases/network/stress/route/route-change-dst
> new file mode 100755
> index 000000000..e793f1658
> --- /dev/null
> +++ b/testcases/network/stress/route/route-change-dst
> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
> +# Copyright (c) International Business Machines Corp., 2005
> +# Author: Mitsuru Chinen <mitch@jp.ibm.com>
> +
> +TST_TESTFUNC="do_test"
> +TST_SETUP="do_setup"
> +TST_CLEANUP="restore_ipaddr"
> +TST_NEEDS_CMDS="ip"
> +TST_CNT=$NS_TIMES
> +TST_NEEDS_TMPDIR=1
> +
> +. tst_net_stress.sh
> +
> +do_setup()
> +{
> +	mask=$IPV4_LPREFIX
> +	[ "$TST_IPV6" ] && mask=$IPV6_LPREFIX
> +	netstress_setup
> +	tst_res TINFO "change IPv$TST_IPVER route destination $NS_TIMES times"
> +}
> +
> +do_test()
> +{
> +	local iface=$(tst_iface)
> +	local addr new_rt
> +
> +	new_rt="$(tst_ipaddr_un $1)/$mask"
> +	addr="$(tst_ipaddr_un $1 1)"
> +
> +	tst_res TINFO "testing route '$new_rt'"
> +	tst_rhost_run -c "ip addr add $addr/$mask dev $(tst_iface rhost)"
> +
> +	ROD ip route add $new_rt dev $iface
> +	ROD ip neigh replace $addr lladdr $(tst_hwaddr rhost) nud permanent dev $iface
> +
> +	tst_netload -T udp -r 1 -a 1 -H $addr


Unfortunately, it won't work this way. tst_netload is using requests/response
model for UDP. You have to make sure the server can send responses.

Also, netstress UDP/DCCP client allows to pass 'max_etime_cnt' (12) failed
requests after which it will double receive timeout, starting from 100ms up to
3.2s. This is about 30 sec if there is no connection. With a single request or
below max_etime_cnt + 1 value it will always pass. I guess we need to set the
proper request parameter limit for UDP/DCCP protocol or check whether the
number of timeout errors is equal or greater than the number of requests.
