From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 17 Nov 2020 17:30:06 +0300
Subject: [LTP] [PATCH 1/1] net/route: Rewrite route-rmmod to new API
In-Reply-To: <20201116220325.413764-1-pvorel@suse.cz>
References: <20201116220325.413764-1-pvorel@suse.cz>
Message-ID: <689bea29-9717-1b2a-a53f-4b3a7f9f4e9b@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 17.11.2020 01:03, Petr Vorel wrote:
> Use network namespaces and veth only, therefore no need to use ethtool for
> defining a driver.
> 
> Add reset_ltp_netspace() in tst_net.sh.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  runtest/net_stress.route                      |   2 +
>  testcases/lib/tst_net.sh                      |  12 +-
>  testcases/network/stress/route/route-rmmod.sh |  46 +++
>  testcases/network/stress/route/route4-rmmod   | 283 ------------------
>  testcases/network/stress/route/route6-rmmod   | 279 -----------------
>  5 files changed, 59 insertions(+), 563 deletions(-)
>  create mode 100644 testcases/network/stress/route/route-rmmod.sh
>  delete mode 100644 testcases/network/stress/route/route4-rmmod
>  delete mode 100644 testcases/network/stress/route/route6-rmmod
> 
> diff --git a/runtest/net_stress.route b/runtest/net_stress.route
> index b60e55bd6..9e1343e0f 100644
> --- a/runtest/net_stress.route
> +++ b/runtest/net_stress.route
> @@ -5,6 +5,7 @@ route4-change-if route-change-if.sh
>  route4-change-netlink-dst route-change-netlink-dst.sh
>  route4-change-netlink-gw route-change-netlink-gw.sh
>  route4-change-netlink-if route-change-netlink-if.sh
> +route4-rmmod route-rmmod.sh
>  
>  route6-change-dst route-change-dst.sh -6
>  route6-change-gw route-change-gw.sh -6
> @@ -12,3 +13,4 @@ route6-change-if route-change-if.sh -6
>  route6-change-netlink-dst route-change-netlink-dst.sh -6
>  route6-change-netlink-gw route-change-netlink-gw.sh -6
>  route6-change-netlink-if route-change-netlink-if.sh -6
> +route6-rmmod route-rmmod.sh -6
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index 46d3fb88e..30514ebaf 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
> -# Copyright (c) 2016-2019 Petr Vorel <pvorel@suse.cz>
> +# Copyright (c) 2016-2020 Petr Vorel <pvorel@suse.cz>
>  # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>  
>  [ -n "$TST_LIB_NET_LOADED" ] && return 0
> @@ -130,6 +130,16 @@ init_ltp_netspace()
>  	tst_restore_ipaddr rhost
>  }
>  
> +reset_ltp_netspace()
> +{
> +	tst_require_cmds pkill
> +
> +	rm -f /var/run/netns/ltp_ns
> +	pkill ns_create
> +	unset LTP_NETNS
> +	init_ltp_netspace
> +}
> +
>  # Run command on remote host.
>  # tst_rhost_run -c CMD [-b] [-s] [-u USER]
>  # Options:
> diff --git a/testcases/network/stress/route/route-rmmod.sh b/testcases/network/stress/route/route-rmmod.sh
> new file mode 100644
> index 000000000..8067d9094
> --- /dev/null
> +++ b/testcases/network/stress/route/route-rmmod.sh
> @@ -0,0 +1,46 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> +# Copyright (c) International Business Machines Corp., 2006
> +# Author: Mitsuru Chinen <mitch@jp.ibm.com>
> +# Rewrite into new shell API: Petr Vorel
> +
> +TST_SETUP="setup"
> +TST_CLEANUP="cleanup"
> +TST_TESTFUNC="do_test"
> +
> +module='veth'
> +TST_NEEDS_DRIVERS="$module"
> +
> +. route-lib.sh
> +TST_CNT=$ROUTE_CHANGE_IP
> +
> +setup()
> +{
> +	tst_res TINFO "adding IPv$TST_IPVER route destination and delete network driver $ROUTE_CHANGE_IP times"
> +}

It is probably unsafe to go straight to the do_test() and removing
the veth... it would be nice to check that it is indeed using default
ltp netns, and veth not used for other interfaces, TCONF otherwise...

Perhaps in init_ltp_netspace(), create a special symlink in the if block,
where the default ltp netns created:

if [ ! -f /var/run/netns/ltp_ns -a -z "$LTP_NETNS" ]; then
   ...
   ROD ln -s /var/run/netns/ltp_ns /var/run/netns/ltp_ns_default
   ...
}

then check via this function:

is_ltp_ns_default()
{
	test -f /var/run/netns/ltp_ns_default
}


BTW, why not using add_macvlan() in route_lib.sh (or gre, vxlan, etc.)
and remove that driver, so that this test can be run with custom setup, and
with remote host setup?


> +
> +cleanup()
> +{
> +	modprobe $module
> +	route_cleanup> +}
> +
> +do_test()
> +{
> +	local iface="$(tst_iface)"
> +	local rt="$(tst_ipaddr_un -p $1)"
> +	local rhost="$(tst_ipaddr_un $1 1)"
> +
> +	tst_res TINFO "testing route '$rt'"
> +
> +	tst_add_ipaddr -s -q -a $rhost rhost
> +	ROD ip route add $rt dev $iface
> +	EXPECT_PASS_BRK ping$TST_IPV6 -c1 -I $(tst_ipaddr) $rhost \>/dev/null
> +
> +	ROD rmmod $module

ROD modprobe -r $module

> +	ROD modprobe $module
> +	reset_ltp_netspace

should be in cleanup too, in case of test timeout or TBROK?

> +}
> +
> +tst_run
>
