From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 28 Apr 2020 19:54:24 +0300
Subject: [LTP] [PATCH v5 2/2] net/route: Add netlink based route change
 tests
In-Reply-To: <20200423131632.20525-3-pvorel@suse.cz>
References: <20200423131632.20525-1-pvorel@suse.cz>
 <20200423131632.20525-3-pvorel@suse.cz>
Message-ID: <8b3ae56d-1c28-e43b-abea-963a32fff8f6@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 23.04.2020 16:16, Petr Vorel wrote:
> changing destination, gateway and interface. These tests are inspired by
> shell tests, but send UDP packets instead of ICMP and there is no
> receiver of the packets thus no verification. Tests are much faster that
> shell tests.
> 
> lhost address is not used, but NIC is set (required by interface tests).
> 
> * use libmnl and new C API, requires pkg-config (and pkg.m4 macro for
> aclocal) for detection (but that's already needed for TI-RPC tests)
> * add shell wrappers
> * move common code for changing iface to route-lib.sh
> * travis: add libmnl libraries to most of travis jobs
> * cleanup test description and Makefile
> 

Hi Petr,

Minor comments below.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  configure.ac                                  |   1 +
>  include/mk/config.mk.in                       |   2 +
>  m4/ltp-libmnl.m4                              |   8 +
>  runtest/net_stress.route                      |   6 +
>  testcases/network/stress/route/.gitignore     |   1 +
>  .../network/stress/route/00_Descriptions.txt  |  40 +--
>  testcases/network/stress/route/Makefile       |  30 +-
>  .../network/stress/route/route-change-dst.sh  |   5 +-
>  .../network/stress/route/route-change-gw.sh   |  18 +-
>  .../network/stress/route/route-change-if.sh   |  61 +---
>  .../stress/route/route-change-netlink-dst.sh  |  36 ++
>  .../stress/route/route-change-netlink-gw.sh   |  31 ++
>  .../stress/route/route-change-netlink-if.sh   |  38 +++
>  .../stress/route/route-change-netlink.c       | 320 ++++++++++++++++++
>  testcases/network/stress/route/route-lib.sh   | 104 +++++-
>  travis/debian.cross-compile.sh                |   1 +
>  travis/debian.sh                              |   1 +
>  travis/fedora.sh                              |   3 +
>  travis/tumbleweed.sh                          |   1 +
>  19 files changed, 586 insertions(+), 121 deletions(-)
>  create mode 100644 m4/ltp-libmnl.m4
>  create mode 100644 testcases/network/stress/route/.gitignore
>  create mode 100755 testcases/network/stress/route/route-change-netlink-dst.sh
>  create mode 100755 testcases/network/stress/route/route-change-netlink-gw.sh
>  create mode 100755 testcases/network/stress/route/route-change-netlink-if.sh
>  create mode 100644 testcases/network/stress/route/route-change-netlink.c
> 
> diff --git a/configure.ac b/configure.ac
> index e1069b57e..9ccf8c3ea 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -300,6 +300,7 @@ LTP_CHECK_CRYPTO
>  LTP_CHECK_FORTIFY_SOURCE
>  LTP_CHECK_KERNEL_DEVEL
>  LTP_CHECK_KEYUTILS_SUPPORT
> +LTP_CHECK_LIBMNL
>  LTP_CHECK_LINUX_PTRACE
>  LTP_CHECK_LINUXRANDOM
>  LTP_CHECK_MREMAP_FIXED
> diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
> index 5526cfea1..87b2c833d 100644
> --- a/include/mk/config.mk.in
> +++ b/include/mk/config.mk.in
> @@ -43,6 +43,8 @@ TIRPC_CFLAGS		:= @TIRPC_CFLAGS@
>  TIRPC_LIBS		:= @TIRPC_LIBS@
>  KEYUTILS_LIBS		:= @KEYUTILS_LIBS@
>  HAVE_FTS_H		:= @HAVE_FTS_H@
> +LIBMNL_LIBS		:= @LIBMNL_LIBS@
> +LIBMNL_CFLAGS		:= @LIBMNL_CFLAGS@
>  
>  prefix			:= @prefix@
>  
> diff --git a/m4/ltp-libmnl.m4 b/m4/ltp-libmnl.m4
> new file mode 100644
> index 000000000..be8ab4584
> --- /dev/null
> +++ b/m4/ltp-libmnl.m4
> @@ -0,0 +1,8 @@
> +dnl SPDX-License-Identifier: GPL-2.0-or-later
> +dnl Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
> +
> +AC_DEFUN([LTP_CHECK_LIBMNL], [
> +    PKG_CHECK_MODULES([LIBMNL], [libmnl], [
> +        AC_DEFINE([HAVE_LIBMNL], [1], [Define to 1 if you have libmnl library and headers])
> +	], [have_libmnl=no])
> +])
> diff --git a/runtest/net_stress.route b/runtest/net_stress.route
> index 4eff6766a..8755ef0be 100644
> --- a/runtest/net_stress.route
> +++ b/runtest/net_stress.route
> @@ -2,11 +2,17 @@
>  route4-change-dst route-change-dst.sh
>  route4-change-gw route-change-gw.sh
>  route4-change-if route-change-if.sh
> +route4-change-netlink-dst route-change-netlink-dst.sh
> +route4-change-netlink-gw route-change-netlink-gw.sh
> +route4-change-netlink-if route-change-netlink-if.sh
>  route4-redirect route4-redirect
>  route4-rmmod route4-rmmod
>  
>  route6-change-dst route-change-dst.sh -6
>  route6-change-gw route-change-gw.sh -6
>  route6-change-if route-change-if.sh -6
> +route6-change-netlink-dst route-change-netlink-dst.sh -6
> +route6-change-netlink-gw route-change-netlink-gw.sh -6
> +route6-change-netlink-if route-change-netlink-if.sh -6
>  route6-redirect route6-redirect
>  route6-rmmod route6-rmmod
> diff --git a/testcases/network/stress/route/.gitignore b/testcases/network/stress/route/.gitignore
> new file mode 100644
> index 000000000..4ed647a55
> --- /dev/null
> +++ b/testcases/network/stress/route/.gitignore
> @@ -0,0 +1 @@
> +/route-change-netlink
> diff --git a/testcases/network/stress/route/00_Descriptions.txt b/testcases/network/stress/route/00_Descriptions.txt
> index e0e2e42c6..d148d51d9 100644
> --- a/testcases/network/stress/route/00_Descriptions.txt
> +++ b/testcases/network/stress/route/00_Descriptions.txt
> @@ -1,36 +1,26 @@
>  route{4,6}-change-dst
> -	Verify the IPv4/IPv6 is not broken when ip command changes route
> -	destination many times
> +	Change IPv4/IPv6 route destination by ip command
>  
>  route{4,6}-change-gw
> -	Verify the IPv4/IPv6 is not broken when ip command changes route
> -	gateway many times
> +	Change IPv4/IPv6 route gateway by ip command
>  
>  route{4,6}-change-if
> -	Verify the IPv4/IPv6 is not broken when ip command changes route
> -	interface many times
> +	Change IPv4/IPv6 route interface by ip command
>  
> -route4-redirect01
> -	Verify the kernel is not crashed when the IPv4 route is modified by
> -	ICMP Redirects frequently
> +route{4,6}-change-netlink-dst
> +	Change IPv4/IPv6 route destination by Netlink API via libmnl
>  
> -route4-rmmod01
> -	Verify the kernel is not crashed when IPv4 route is add by route command
> -	then it is deleted by the removing network driver
> +route{4,6}-change-netlink-gw
> +	Change IPv4/IPv6 route gateway by Netlink API via libmnl
>  
> -route4-rmmod02
> -	Verify the kernel is not crashed when IPv4 route is add by ip command
> -	then it is deleted by the removing network driver
> +route{4,6}-change-netlink-if
> +	Change IPv4/IPv6 route interface by Netlink API via libmnl
>  
> +route{4,6}-redirect01
> +	Change IPv4/IPv6 route by ICMP Redirects frequently
>  
> -route6-redirect01
> -	Verify the kernel is not crashed when the IPv6 route is modified by
> -	ICMP Redirects frequently
> +route{4,6}-rmmod01
> +	Add IPv4/IPv6 route by route command then delete it by the removing network driver
>  
> -route6-rmmod01
> -	Verify the kernel is not crashed when IPv6 route is add by route command
> -	then it is deleted by the removing network driver
> -
> -route6-rmmod02
> -	Verify the kernel is not crashed when IPv6 route is add by ip command
> -	then it is deleted by the removing network driver
> +route{4,6}-rmmod02
> +	Add IPv4/IPv6 route by ip command then delete it by the removing network driver
> diff --git a/testcases/network/stress/route/Makefile b/testcases/network/stress/route/Makefile
> index 2e5eaa2f2..b4e6409be 100644
> --- a/testcases/network/stress/route/Makefile
> +++ b/testcases/network/stress/route/Makefile
> @@ -1,29 +1,15 @@
> -#
> -#    network/stress/route test suite Makefile.
> -#
> -#    Copyright (C) 2009, Cisco Systems Inc.
> -#
> -#    This program is free software; you can redistribute it and/or modify
> -#    it under the terms of the GNU General Public License as published by
> -#    the Free Software Foundation; either version 2 of the License, or
> -#    (at your option) any later version.
> -#
> -#    This program is distributed in the hope that it will be useful,
> -#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> -#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -#    GNU General Public License for more details.
> -#
> -#    You should have received a copy of the GNU General Public License along
> -#    with this program; if not, write to the Free Software Foundation, Inc.,
> -#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> -#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2009, Cisco Systems Inc.
> +# Copyright (c) Linux Test Project, 2006-2020
>  # Ngie Cooper, October 2009
> -#
>  
>  top_srcdir		?= ../../../..
>  
> -include $(top_srcdir)/include/mk/env_pre.mk
> +include $(top_srcdir)/include/mk/testcases.mk
>  
> -INSTALL_TARGETS		:= route*
> +INSTALL_TARGETS		+= route[4-6]-* *.sh
> +
> +route-change-netlink: CFLAGS += $(LIBMNL_CFLAGS)
> +route-change-netlink: LDLIBS += $(LIBMNL_LIBS)
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/network/stress/route/route-change-dst.sh b/testcases/network/stress/route/route-change-dst.sh
> index fff79fa6e..e883b7e24 100755
> --- a/testcases/network/stress/route/route-change-dst.sh
> +++ b/testcases/network/stress/route/route-change-dst.sh
> @@ -4,11 +4,14 @@
>  # Copyright (c) International Business Machines Corp., 2006
>  # Author: Mitsuru Chinen <mitch@jp.ibm.com>
>  # Rewrite into new shell API: Petr Vorel
> -#
> +
>  # Change route destination
>  # lhost: 10.0.0.2, rhost: 10.23.x.1
>  
> +TST_SETUP="setup"
> +TST_CLEANUP="route_cleanup"
>  TST_TESTFUNC="test_dst"
> +TST_CNT=$NS_TIMES
>  . route-lib.sh
>  
>  setup()
> diff --git a/testcases/network/stress/route/route-change-gw.sh b/testcases/network/stress/route/route-change-gw.sh
> index fc88ee0f3..f7a08cf91 100755
> --- a/testcases/network/stress/route/route-change-gw.sh
> +++ b/testcases/network/stress/route/route-change-gw.sh
> @@ -1,27 +1,19 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
> -# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
> +# Copyright (c) 2019-2020 Petr Vorel <pvorel@suse.cz>
>  # Copyright (c) International Business Machines Corp., 2006
>  # Author: Mitsuru Chinen <mitch@jp.ibm.com>
>  # Rewrite into new shell API: Petr Vorel
> -#
> +
>  # Change route gateway
>  # lhost: 10.23.1.1, gw (on rhost): 10.23.1.x, rhost: 10.23.0.1
>  
> +TST_SETUP="setup_gw"
> +TST_CLEANUP="route_cleanup"
>  TST_TESTFUNC="test_gw"
> +TST_CNT=$NS_TIMES
>  . route-lib.sh
>  
> -setup()
> -{
> -	tst_res TINFO "change IPv$TST_IPVER route gateway $NS_TIMES times"
> -
> -	rt="$(tst_ipaddr_un -p 0 0)"
> -	lhost="$(tst_ipaddr_un 1 1)"
> -	rhost="$(tst_ipaddr_un 0 1)"
> -	tst_add_ipaddr -s -q -a $lhost
> -	tst_add_ipaddr -s -q -a $rhost rhost
> -}
> -
>  test_gw()
>  {
>  	local gw="$(tst_ipaddr_un -h 2,254 1 $(($1 + 1)))"
> diff --git a/testcases/network/stress/route/route-change-if.sh b/testcases/network/stress/route/route-change-if.sh
> index 77661a45e..489d9be92 100755
> --- a/testcases/network/stress/route/route-change-if.sh
> +++ b/testcases/network/stress/route/route-change-if.sh
> @@ -4,61 +4,15 @@
>  # Copyright (c) International Business Machines Corp., 2006
>  # Author: Mitsuru Chinen <mitch@jp.ibm.com>
>  # Rewrite into new shell API: Petr Vorel
> -#
> +
>  # Change route interface
>  # lhost: 10.23.x.2, gw (on rhost): 10.23.x.1, rhost: 10.23.0.1, switching ifaces on lhost
>  
> +TST_SETUP="setup_if"
> +TST_CLEANUP="cleanup_if"
>  TST_TESTFUNC="test_if"
> +TST_CNT=$NS_TIMES
>  . route-lib.sh
> -TST_CLEANUP="cleanup"
> -
> -add_macvlan()
> -{
> -	local action="add"
> -	local OPTIND
> -	while getopts d opt; do
> -		case "$opt" in
> -		d) action="del";;
> -		esac
> -	done
> -	shift $((OPTIND - 1))
> -
> -	local iface="$1"
> -	local type="${2:-lhost}"
> -
> -	cmd="ip link $action $iface link $(tst_iface $type) type macvlan mode bridge"
> -	if [ $type = "lhost" ]; then
> -		ROD $cmd
> -		[ "$action" = "add" ] || return
> -		LHOST_IFACES="$LHOST_IFACES $iface"
> -	else
> -		tst_rhost_run -s -c "$cmd"
> -		[ "$action" = "add" ] || return
> -		RHOST_IFACES="$RHOST_IFACES $iface"
> -	fi
> -	tst_init_iface $type 1
> -}
> -
> -setup()
> -{
> -	tst_res TINFO "change IPv$TST_IPVER route interface $NS_TIMES times"
> -
> -	rt="$(tst_ipaddr_un -p 0)"
> -	rhost="$(tst_ipaddr_un 0 1)"
> -	tst_add_ipaddr -s -q -a $rhost rhost
> -
> -	if [ $(tst_get_ifaces_cnt) -lt 2 ]; then
> -		new_liface="ltp_mv2"
> -		tst_res TINFO "2 or more local ifaces required, adding $new_liface"
> -		add_macvlan $new_liface
> -	fi
> -
> -	if [ $(tst_get_ifaces_cnt rhost) -lt 2 ]; then
> -		new_riface="ltp_mv1"
> -		tst_res TINFO "2 or more remote ifaces required, adding $new_riface"
> -		add_macvlan $new_riface rhost
> -	fi
> -}
>  
>  test_if()
>  {
> @@ -78,11 +32,4 @@ test_if()
>  	tst_del_ipaddr -s -q -a $gw rhost $link_num
>  }
>  
> -cleanup()
> -{
> -	[ "$new_liface" ] && add_macvlan -d $new_liface
> -	[ "$new_riface" ] && add_macvlan -d $new_riface rhost
> -	route_cleanup
> -}
> -
>  tst_run
> diff --git a/testcases/network/stress/route/route-change-netlink-dst.sh b/testcases/network/stress/route/route-change-netlink-dst.sh
> new file mode 100755
> index 000000000..113bd0caa
> --- /dev/null
> +++ b/testcases/network/stress/route/route-change-netlink-dst.sh
> @@ -0,0 +1,36 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> +
> +# Change route destination via netlink
> +# rhost: 10.23.x.1
> +# lhost (iface set, but not specified in Netlink API): 10.0.0.2
> +
> +TST_SETUP="setup"
> +TST_CLEANUP="route_cleanup"
> +TST_TESTFUNC="test_netlink"
> +. route-lib.sh
> +
> +setup()
> +{
> +	tst_res TINFO "change IPv$TST_IPVER route destination $NS_TIMES times"
> +
> +	local cnt=0
> +	local gw rhost rhost_all rt
> +
> +	check_max_ip
> +
> +	while [ $cnt -lt $ROUTE_MAX_IP ]; do
> +		rt="$(tst_ipaddr_un -p $cnt)"
> +		rhost="$(tst_ipaddr_un $cnt 1)"
> +		rhost_all="$rhost$IP_ADDR_DELIM$rhost_all"
> +
> +		tst_add_ipaddr -s -q -a $rhost rhost
> +		ROD ip route add $rt dev $(tst_iface)
> +		cnt=$((cnt+1))
> +	done
> +
> +	ROUTE_CHANGE_NETLINK_PARAMS="-d $(tst_iface) -r '$rhost_all'"
> +}
> +
> +tst_run
> diff --git a/testcases/network/stress/route/route-change-netlink-gw.sh b/testcases/network/stress/route/route-change-netlink-gw.sh
> new file mode 100755
> index 000000000..fec09683c
> --- /dev/null
> +++ b/testcases/network/stress/route/route-change-netlink-gw.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> +
> +# Change route gateway via netlink
> +# gw (on rhost): 10.23.1.x, rhost: 10.23.0.1
> +# lhost (iface set, but not specified in Netlink API): 10.23.1.1
> +
> +TST_SETUP="setup"
> +TST_CLEANUP="route_cleanup"
> +TST_TESTFUNC="test_netlink"
> +. route-lib.sh
> +
> +setup()
> +{
> +	local cnt=0
> +
> +	check_max_ip
> +	setup_gw
> +
> +	while [ $cnt -lt $ROUTE_MAX_IP ]; do
> +		gw="$(tst_ipaddr_un -h 2,$max_ip_limit 1 $(($cnt + 1)))"
> +		gw_all="$gw$IP_ADDR_DELIM$gw_all"
> +		tst_add_ipaddr -s -q -a $gw rhost
> +		cnt=$((cnt+1))
> +	done
> +
> +	ROUTE_CHANGE_NETLINK_PARAMS="-d $(tst_iface) -g "$gw_all" -r $rhost"
> +}
> +
> +tst_run
> diff --git a/testcases/network/stress/route/route-change-netlink-if.sh b/testcases/network/stress/route/route-change-netlink-if.sh
> new file mode 100755
> index 000000000..3a095ff4b
> --- /dev/null
> +++ b/testcases/network/stress/route/route-change-netlink-if.sh
> @@ -0,0 +1,38 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> +
> +# Change route interface
> +# gw (on rhost): 10.23.x.1, rhost: 10.23.0.1, switching ifaces on lhost
> +# lhost (iface set, but not specified in Netlink API): 10.23.x.2
> +
> +TST_SETUP="setup"
> +TST_CLEANUP="cleanup_if"
> +TST_TESTFUNC="test_netlink"
> +. route-lib.sh
> +
> +setup()
> +{
> +	local gw gw_all iface iface_all
> +	local cnt=0
> +
> +	setup_if
> +
> +	while [ $cnt -lt $(tst_get_ifaces_cnt) ]; do
> +		gw="$(tst_ipaddr_un -n1 $cnt 1)"
> +		iface="$(tst_iface lhost $cnt)"
> +		lhost="$(tst_ipaddr_un -n1 $cnt 2)"
> +
> +		tst_add_ipaddr -s -q -a $lhost lhost $cnt
> +		tst_add_ipaddr -s -q -a $gw rhost $cnt
> +
> +		gw_all="$gw$IP_ADDR_DELIM$gw_all"
> +		iface_all="$iface$IP_ADDR_DELIM$iface_all"
> +
> +		cnt=$((cnt+1))
> +	done
> +
> +	ROUTE_CHANGE_NETLINK_PARAMS="-d '$iface_all' -g '$gw_all' -r $rhost"
> +}
> +
> +tst_run
> diff --git a/testcases/network/stress/route/route-change-netlink.c b/testcases/network/stress/route/route-change-netlink.c
> new file mode 100644
> index 000000000..57ae02a3c
> --- /dev/null
> +++ b/testcases/network/stress/route/route-change-netlink.c
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> + */
> +
> +#include "config.h"
> +#include "tst_test.h"
> +
> +#ifdef HAVE_LIBMNL
> +
> +#include <string.h>
> +
> +#include <libmnl/libmnl.h>
> +#include <linux/rtnetlink.h>
> +#include <net/if.h>
> +#include <netdb.h>
> +#include <netinet/in.h>
> +
> +#include "tst_net.h"
> +#include "tst_safe_net.h"
> +#include "tst_safe_stdio.h"
> +
> +#define NS_TIMES_MAX 65535
> +
> +#define IP_ADDR_DELIM ','
> +#define STR(x) #x
> +#define CHR2STR(x) STR(x)
> +
> +static char *c_opt, *d_opt, *g_opt, *ipv6_opt, *p_opt, *r_opt;
> +
> +static int family = AF_INET;
> +static int fd, num_loops, port;
> +
> +static unsigned int is_ipv6, max, prefix;
> +
> +static struct mnl_socket *nl;
> +static struct addrinfo hints;
> +
> +struct iface {
> +	unsigned int index;
> +	struct iface *next;
> +	char iface[IFNAMSIZ];
> +};
> +
> +struct ip_addr {
> +	struct addrinfo *ip;
> +	struct ip_addr *next;
> +	char ip_str[INET6_ADDRSTRLEN];
> +};
> +
> +static struct ip_addr *dst, *gw, *rhost;
> +static struct iface *iface;
> +static unsigned int gw_len, iface_len, rhost_len;
> +
> +void save_iface(void **data, const char *item)
> +{
> +	struct iface *n = SAFE_MALLOC(sizeof(*n));
> +	struct iface **list = (struct iface**)data;
> +
> +	strncpy(n->iface, item, sizeof(n->iface));
> +	n->iface[sizeof(n->iface)-1] = '\0';
> +
> +	n->index = if_nametoindex(item);
> +	if (!n->index)
> +		tst_brk(TBROK, "if_nametoindex failed, '%s' not found", item);
> +	n->next = *list;
> +	*list = n;
> +}
> +
> +void save_ip(void **data, const char *item)
> +{
> +	struct ip_addr *n = SAFE_MALLOC(sizeof(*n));
> +	struct ip_addr **list = (struct ip_addr**)data;
> +
> +	strncpy(n->ip_str, item, sizeof(n->ip_str));
> +	n->ip_str[sizeof(n->ip_str)-1] = '\0';
> +
> +	SAFE_GETADDRINFO(item, p_opt, &hints, &n->ip);
> +	n->next = *list;
> +	*list = n;
> +}
> +
> +int save_item(void **list, char *item, void (*callback)(void **, const char *))
> +{
> +	int len = 0;
> +
> +	while ((item = strtok(item, CHR2STR(IP_ADDR_DELIM))) != NULL) {
> +		callback(list, item);
> +		item = NULL;
> +		len++;
> +	}
> +
> +	return len;
> +}
> +
> +static void setup(void)
> +{
> +	prefix = 24;
> +	if (ipv6_opt) {
> +		family = AF_INET6;
> +		is_ipv6 = 1;
> +		prefix = 64;
> +	}
> +
> +	if (!c_opt)
> +		tst_brk(TBROK, "missing number of loops (-c num)");
> +
> +	if (!d_opt)
> +		tst_brk(TBROK, "missing iface (-d iface)");
> +
> +	if (!p_opt)
> +		tst_brk(TBROK, "missing rhost port (-p port)");
> +
> +	if (!r_opt)
> +		tst_brk(TBROK, "missing rhost IP (-r IP)");
> +
> +	if (tst_parse_int(p_opt, &port, 1, 65535))
> +		tst_brk(TBROK, "invalid rhost port '%s'", p_opt);
> +
> +	if (tst_parse_int(c_opt, &num_loops, 1, NS_TIMES_MAX)) {
> +		num_loops = NS_TIMES_MAX;
> +		tst_res(TWARN, "invalid number of loops (-c %s), using: %d",
> +			c_opt, num_loops);
> +	}
> +
> +	iface_len = save_item((void **)&iface, d_opt, save_iface);
> +	rhost_len = save_item((void **)&rhost, r_opt, save_ip);
> +
> +	max = MAX(iface_len, rhost_len);
> +	if (iface_len > 1 && rhost_len > 1 && iface_len != max)
> +		tst_brk(TBROK, "-d specifies more NICs and -r more IPs, they need to have the same count");
> +
> +	if (g_opt) {
> +		gw_len = save_item((void **)&gw, g_opt, save_ip);
> +		max = MAX(gw_len, max);
> +
> +		if (gw_len > 1 && max > 1 && gw_len != max) {
> +			if (iface_len == max)
> +				tst_brk(TBROK, "-d specifies more NICs and -r more IPs, they need to have the same count");
> +			else
> +				tst_brk(TBROK, "-g and -r specify more IP, they need to have the same count");
> +		}
> +	}
> +
> +	struct ip_addr *p_rhost = rhost;
> +
> +	while (p_rhost) {
> +		char dst_str[INET6_ADDRSTRLEN];
> +
> +		if (!strncpy(dst_str, p_rhost->ip_str, sizeof(dst_str)))
> +			tst_brk(TBROK, "failed copy IP '%s'", p_rhost->ip_str);
> +		dst_str[strlen(p_rhost->ip_str)-1] = '\0';
> +
> +		if (!strcat(dst_str, "0"))
> +			tst_brk(TBROK, "strcat failed: '%s'", dst_str);
> +
> +		save_ip((void **)&dst, dst_str);
> +		p_rhost = p_rhost->next;
> +	}
> +
> +	fd = SAFE_SOCKET(family, SOCK_DGRAM, IPPROTO_UDP);
> +
> +	memset(&hints, 0, sizeof(struct addrinfo));
> +	hints.ai_family = family;
> +	hints.ai_socktype = SOCK_DGRAM;
> +	hints.ai_flags = 0;
> +	hints.ai_protocol = 0;
> +	hints.ai_addr = INADDR_ANY;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd > 0)
> +		close(fd);
> +
> +	if (nl)
> +		mnl_socket_close(nl);
> +}
> +
> +static void rtnl_route(int iface, struct addrinfo *dst, struct addrinfo *gw, uint32_t prefix, int type)
> +{
> +	struct mnl_socket *nl;
> +	char buf[MNL_SOCKET_BUFFER_SIZE];
> +	struct nlmsghdr *nlh;
> +	struct rtmsg *rtm;
> +	uint32_t seq, portid;
> +	struct in6_addr dst_in6, gw_in6;
> +	in_addr_t dst_ip, gw_ip;
> +	int ret;
> +
> +	nlh = mnl_nlmsg_put_header(buf);
> +	nlh->nlmsg_type	= type;
> +
> +	nlh->nlmsg_flags = NLM_F_ACK;
> +	if (type == RTM_NEWROUTE)
> +		nlh->nlmsg_flags |= NLM_F_REQUEST | NLM_F_CREATE | NLM_F_REPLACE;
> +
> +	nlh->nlmsg_seq = seq = time(NULL);
> +
> +	rtm = mnl_nlmsg_put_extra_header(nlh, sizeof(struct rtmsg));
> +	rtm->rtm_family = family;
> +	rtm->rtm_dst_len = prefix;
> +	rtm->rtm_src_len = 0;
> +	rtm->rtm_tos = 0;
> +	rtm->rtm_protocol = RTPROT_STATIC;
> +	rtm->rtm_table = RT_TABLE_MAIN;
> +	rtm->rtm_type = RTN_UNICAST;
> +	rtm->rtm_scope = gw ? RT_SCOPE_UNIVERSE : RT_SCOPE_LINK;
> +	rtm->rtm_flags = 0;
> +
> +	if (is_ipv6) {
> +		dst_in6 = ((struct sockaddr_in6 *)dst->ai_addr)->sin6_addr;
> +		mnl_attr_put(nlh, RTA_DST, sizeof(struct in6_addr), &dst_in6);
> +	} else {
> +		dst_ip = ((struct sockaddr_in *)dst->ai_addr)->sin_addr.s_addr;
> +		mnl_attr_put_u32(nlh, RTA_DST, dst_ip);
> +	}
> +
> +	mnl_attr_put_u32(nlh, RTA_OIF, iface);
> +
> +	if (gw) {
> +		if (is_ipv6) {
> +			gw_in6 = ((struct sockaddr_in6 *)gw->ai_addr)->sin6_addr;
> +			mnl_attr_put(nlh, RTA_GATEWAY, sizeof(struct in6_addr), &gw_in6);
> +		} else {
> +			gw_ip = ((struct sockaddr_in *)gw->ai_addr)->sin_addr.s_addr;
> +			mnl_attr_put_u32(nlh, RTA_GATEWAY, gw_ip);
> +		}
> +	}
> +
> +	nl = mnl_socket_open(NETLINK_ROUTE);
> +	if (nl == NULL)
> +		tst_brk(TBROK, "mnl_socket_open failed (errno=%d): %s", errno,
> +			strerror(errno));
> +
> +	if (mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID) < 0)
> +		tst_brk(TBROK, "mnl_socket_bind failed (errno=%d): %s", errno,
> +			strerror(errno));
> +
> +	portid = mnl_socket_get_portid(nl);
> +
> +	if (mnl_socket_sendto(nl, nlh, nlh->nlmsg_len) < 0)
> +		tst_brk(TBROK, "mnl_socket_sendto failed (errno=%d): %s", errno,
> +			strerror(errno));
> +
> +	ret = mnl_socket_recvfrom(nl, buf, sizeof(buf));
> +	if (ret < 0)
> +		tst_brk(TBROK, "mnl_socket_recvfrom failed (ret=%d, errno=%d): %s",
> +			ret, errno, strerror(errno));
> +
> +	ret = mnl_cb_run(buf, ret, seq, portid, NULL, NULL);
> +	if (ret < 0)
> +		tst_brk(TBROK, "mnl_cb_run failed (ret=%d, errno=%d): %s", ret,
> +			errno, strerror(errno));
> +
> +	mnl_socket_close(nl);
> +}
> +
> +static void send_udp(struct addrinfo *rhost_addrinfo)
> +{
> +	const char *msg = "foo";
> +
> +	SAFE_SENDTO(1, fd, msg, sizeof(msg), MSG_CONFIRM,
> +		rhost_addrinfo->ai_addr, rhost_addrinfo->ai_addrlen);
> +}
> +
> +static void run(void)
> +{
> +	int i;
> +
> +	tst_res(TINFO, "adding and deleting route %d times", num_loops);
> +
> +	struct ip_addr *p_dst = dst, *p_gw = gw, *p_rhost = rhost;
> +	struct iface *p_iface = iface;
> +
> +	for (i = 0; i < num_loops; i++) {
> +		if (iface_len > 1)
> +			tst_res(TINFO, "testing gw: %s, iface: %s",
> +					p_gw->ip_str, p_iface->iface);
> +		else if (gw_len > 1)
> +			tst_res(TINFO, "testing gw: %s", p_gw->ip_str);
> +		else
> +			tst_res(TINFO, "testing dst: %s/%d", p_dst->ip_str, prefix);


It would be better to avoid printing it on every iteration, especially
with the large NS_TIMES.

> +
> +		rtnl_route(p_iface->index, p_dst->ip, gw ? p_gw->ip : NULL,
> +			   prefix, RTM_NEWROUTE);
> +		send_udp(p_rhost->ip);
> +		rtnl_route(p_iface->index, p_dst->ip, gw ? p_gw->ip : NULL,
> +			   prefix, RTM_DELROUTE);
> +
> +		if (gw)
> +			p_gw = p_gw->next ?: gw;
> +		p_dst = p_dst->next ?: dst;
> +		p_iface = p_iface->next ?: iface;
> +		p_rhost = p_rhost->next ?: rhost;
> +	}
> +
> +	tst_res(TPASS, "routes created and deleted");
> +}
> +
> +static struct tst_option options[] = {
> +	{"6", &ipv6_opt, "-6       Use IPv6 (default is IPv4)"},
> +	{"c:", &c_opt, "         Num loops (mandatory)"},

"-c x ...

> +	{"d:", &d_opt, "-d iface Interface to work on (mandatory)"},
> +	{"g:", &g_opt, "-g x     Gateway IP"},
> +	{"p:", &p_opt, "-p port  Rhost port (mandatory)"},
> +	{"r:", &r_opt, "-r x     Rhost IP (mandatory)\n\n-g, -r IP parameter can contain more IP, separated by "
> +		CHR2STR(IP_ADDR_DELIM)},
> +	{NULL, NULL, NULL}
> +};
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_root = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.options = options,
> +};
> +#else
> +	TST_TEST_TCONF("libmnl library and headers are required");
> +#endif /* HAVE_LIBMNL */
> diff --git a/testcases/network/stress/route/route-lib.sh b/testcases/network/stress/route/route-lib.sh
> index 4afbe6323..45fa7f3c9 100644
> --- a/testcases/network/stress/route/route-lib.sh
> +++ b/testcases/network/stress/route/route-lib.sh
> @@ -3,15 +3,113 @@
>  # Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
>  
>  TST_NEEDS_ROOT=1
> -TST_SETUP="setup"
> -TST_CLEANUP="route_cleanup"
>  TST_NEEDS_CMDS="ip"
> -TST_CNT=$NS_TIMES
>  
>  . tst_net.sh
>  
> +ROUTE_RHOST_PORT=${ROUTE_RHOST_PORT:-65535}
> +ROUTE_MAX_IP=${ROUTE_MAX_IP:-5}
> +
> +IP_ADDR_DELIM=','
> +
> +add_macvlan()
> +{
> +	local action="add"
> +	local OPTIND
> +	while getopts d opt; do
> +		case "$opt" in
> +		d) action="del";;
> +		esac
> +	done
> +	shift $((OPTIND - 1))
> +
> +	local iface="$1"
> +	local type="${2:-lhost}"
> +
> +	cmd="ip link $action $iface link $(tst_iface $type) type macvlan mode bridge"
> +	if [ $type = "lhost" ]; then
> +		ROD $cmd
> +		[ "$action" = "add" ] || return
> +		LHOST_IFACES="$LHOST_IFACES $iface"
> +	else
> +		tst_rhost_run -s -c "$cmd"
> +		[ "$action" = "add" ] || return
> +		RHOST_IFACES="$RHOST_IFACES $iface"
> +	fi
> +	tst_init_iface $type 1
> +}
> +
> +check_max_ip()
> +{
> +	local max_ip_limit=254
> +	[ "$TST_IPV6" ] && max_ip_limit=65534
> +
> +	tst_is_int "$ROUTE_MAX_IP" || tst_brk TBROK "\$ROUTE_MAX_IP not int ($ROUTE_MAX_IP)"
> +	[ $ROUTE_MAX_IP -gt $max_ip_limit ] && ROUTE_MAX_IP=$max_ip_limit
> +	[ $ROUTE_MAX_IP -gt $NS_TIMES ] && ROUTE_MAX_IP=$NS_TIMES
> +}
> +
> +cleanup_if()
> +{
> +	[ "$new_liface" ] && add_macvlan -d $new_liface
> +	[ "$new_riface" ] && add_macvlan -d $new_riface rhost
> +	route_cleanup
> +}
> +
>  route_cleanup()
>  {
>  	tst_restore_ipaddr
>  	tst_restore_ipaddr rhost
>  }
> +
> +setup_gw()
> +{
> +	tst_res TINFO "change IPv$TST_IPVER route gateway $NS_TIMES times"
> +
> +	rt="$(tst_ipaddr_un -p 0 0)"
> +	lhost="$(tst_ipaddr_un 1 1)"
> +	rhost="$(tst_ipaddr_un 0 1)"
> +	tst_add_ipaddr -s -q -a $lhost
> +	tst_add_ipaddr -s -q -a $rhost rhost
> +}
> +
> +setup_if()
> +{
> +	tst_res TINFO "change IPv$TST_IPVER route interface $NS_TIMES times"
> +
> +	rt="$(tst_ipaddr_un -p 0)"
> +	rhost="$(tst_ipaddr_un 0 1)"
> +	tst_add_ipaddr -s -q -a $rhost rhost
> +
> +	if [ $(tst_get_ifaces_cnt) -lt 2 ]; then
> +		new_liface="ltp_mv2"
> +		tst_res TINFO "2 or more local ifaces required, adding '$new_liface'"
> +		add_macvlan $new_liface
> +	fi
> +
> +	if [ $(tst_get_ifaces_cnt rhost) -lt 2 ]; then
> +		new_riface="ltp_mv1"
> +		tst_res TINFO "2 or more remote ifaces required, adding '$new_riface'"
> +		add_macvlan $new_riface rhost
> +	fi
> +}
> +
> +test_netlink()
> +{
> +	local ret=0
> +	local cmd ip_flag
> +	[ "$TST_IPV6" ] && ip_flag="-6"
> +
> +	cmd="route-change-netlink -c $NS_TIMES $ip_flag -p $ROUTE_RHOST_PORT $ROUTE_CHANGE_NETLINK_PARAMS"
> +	tst_res TINFO "running $cmd"
> +	$cmd || ret=$?
> +	if [ "$ret" -ne 0 ]; then
> +		[ $((ret & 3)) -ne 0 ] && \
> +			tst_brk TFAIL "route-change-netlink failed"
> +		[ $((ret & 32)) -ne 0 ] && \
> +			tst_brk TCONF "not supported configuration"
> +		[ $((ret & 4)) -ne 0 ] && \
> +			tst_res TWARN "route-change-netlink has warnings"
> +	fi
> +	tst_res TPASS "route-change-netlink passed"
> +}
> diff --git a/travis/debian.cross-compile.sh b/travis/debian.cross-compile.sh
> index 67307d1e1..08c3805aa 100755
> --- a/travis/debian.cross-compile.sh
> +++ b/travis/debian.cross-compile.sh
> @@ -20,4 +20,5 @@ apt update
>  apt install -y --no-install-recommends \
>  	gcc-${gcc_arch}-linux-gnu \
>  	libc6-dev-${ARCH}-cross \
> +	libmnl-dev:$ARCH \
>  	libtirpc-dev:$ARCH
> diff --git a/travis/debian.sh b/travis/debian.sh
> index 97fa91a0d..b759a9576 100755
> --- a/travis/debian.sh
> +++ b/travis/debian.sh
> @@ -28,6 +28,7 @@ apt install -y --no-install-recommends \
>  	libkeyutils-dev \
>  	libkeyutils1 \
>  	libmm-dev \
> +	libmnl-dev \
>  	libnuma-dev \
>  	libnuma1 \
>  	libselinux1-dev \
> diff --git a/travis/fedora.sh b/travis/fedora.sh
> index d68e7573e..990a84daf 100755
> --- a/travis/fedora.sh
> +++ b/travis/fedora.sh
> @@ -13,3 +13,6 @@ yum -y install \
>  	libtirpc-devel \
>  	pkg-config \
>  	redhat-lsb-core
> +
> +# CentOS 8 doesn't have libmnl-devel
> +yum -y install libmnl-devel || yum -y install libmnl
> diff --git a/travis/tumbleweed.sh b/travis/tumbleweed.sh
> index 4dd71fd13..8143fc885 100755
> --- a/travis/tumbleweed.sh
> +++ b/travis/tumbleweed.sh
> @@ -15,6 +15,7 @@ zypper --non-interactive install --no-recommends \
>  	libacl-devel \
>  	libaio-devel \
>  	libcap-devel \
> +	libmnl-devel \
>  	libnuma-devel \
>  	libopenssl-devel \
>  	libselinux-devel \
> 

Reviewed-by: Alexey Kodanev <alexey.kodanev@oracle.com>
