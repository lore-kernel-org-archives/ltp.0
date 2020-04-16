From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 16 Apr 2020 15:27:46 +0300
Subject: [LTP] [PATCH v4 2/2] net/route: Add netlink based route change
 gw/dest tests
In-Reply-To: <20200414152412.8278-3-pvorel@suse.cz>
References: <20200414152412.8278-1-pvorel@suse.cz>
 <20200414152412.8278-3-pvorel@suse.cz>
Message-ID: <b7673e46-60de-9039-5179-3d96c0b9a538@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 14.04.2020 18:24, Petr Vorel wrote:
> * use libmnl and new C API
> * reuse code in tst_net.h (added in previous commit)
> * add shell wrappers (set environment with tst_net.sh instead of using
>   deprecated helpers in testcases/network/stress/ns-tools/)
> 

Hi Petr,

> Travis:
> * add libmnl libraries to most of travis jobs
> 
> Cleanup:
> * cleanup test description
> * other cleanup
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  configure.ac                                  |   1 +
>  include/mk/config.mk.in                       |   2 +
>  m4/ltp-libmnl.m4                              |   8 +
>  runtest/net_stress.route                      |   4 +
>  testcases/network/stress/route/.gitignore     |   1 +
>  .../network/stress/route/00_Descriptions.txt  |  39 +-
>  testcases/network/stress/route/Makefile       |  30 +-
>  .../network/stress/route/route-change-dst.sh  |   1 +
>  .../network/stress/route/route-change-gw.sh   |  15 +-
>  .../network/stress/route/route-change-if.sh   |   1 +
>  .../stress/route/route-change-netlink-dst.sh  |  33 ++
>  .../stress/route/route-change-netlink-gw.sh   |  28 ++
>  .../stress/route/route-change-netlink.c       | 348 ++++++++++++++++++
>  testcases/network/stress/route/route-lib.sh   |  44 ++-
>  travis/debian.cross-compile.sh                |   1 +
>  travis/debian.sh                              |   1 +
>  travis/fedora.sh                              |   3 +
>  travis/tumbleweed.sh                          |   1 +
>  18 files changed, 500 insertions(+), 61 deletions(-)
>  create mode 100644 m4/ltp-libmnl.m4
>  create mode 100644 testcases/network/stress/route/.gitignore
>  create mode 100755 testcases/network/stress/route/route-change-netlink-dst.sh
>  create mode 100755 testcases/network/stress/route/route-change-netlink-gw.sh
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
> index 4eff6766a..0a8cfec39 100644
> --- a/runtest/net_stress.route
> +++ b/runtest/net_stress.route
> @@ -2,11 +2,15 @@
>  route4-change-dst route-change-dst.sh
>  route4-change-gw route-change-gw.sh
>  route4-change-if route-change-if.sh
> +route4-change-netlink-dst route-change-netlink-dst.sh
> +route4-change-netlink-gw route-change-netlink-gw.sh -g
>  route4-redirect route4-redirect
>  route4-rmmod route4-rmmod
>  
>  route6-change-dst route-change-dst.sh -6
>  route6-change-gw route-change-gw.sh -6
>  route6-change-if route-change-if.sh -6
> +route6-change-netlink-dst route-change-netlink-dst.sh
> +route6-change-netlink-gw route-change-netlink-gw.sh -g

"-6" option?

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
> index e0e2e42c6..bd9661880 100644
> --- a/testcases/network/stress/route/00_Descriptions.txt
> +++ b/testcases/network/stress/route/00_Descriptions.txt
> @@ -1,36 +1,23 @@
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
> +	Change IPv4/IPv6 route destination by libmnl API
>  
> -route4-rmmod01
> -	Verify the kernel is not crashed when IPv4 route is add by route command
> -	then it is deleted by the removing network driver
> +route{4,6}-change-netlink-gw
> +	Change IPv4/IPv6 route gateway by libmnl API
>  
> -route4-rmmod02
> -	Verify the kernel is not crashed when IPv4 route is add by ip command
> -	then it is deleted by the removing network driver
> +route{4,6}-redirect01
> +	Change IPv4/IPv6 route by ICMP Redirects frequently
>  
> +route{4,6}-rmmod01
> +	Add IPv4/IPv6 route by route command then delete it by the removing network driver
>  
> -route6-redirect01
> -	Verify the kernel is not crashed when the IPv6 route is modified by
> -	ICMP Redirects frequently
> -
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
> index fff79fa6e..9b683f9d6 100755
> --- a/testcases/network/stress/route/route-change-dst.sh
> +++ b/testcases/network/stress/route/route-change-dst.sh
> @@ -9,6 +9,7 @@
>  # lhost: 10.0.0.2, rhost: 10.23.x.1
>  
>  TST_TESTFUNC="test_dst"
> +TST_CNT=$NS_TIMES
>  . route-lib.sh
>  
>  setup()
> diff --git a/testcases/network/stress/route/route-change-gw.sh b/testcases/network/stress/route/route-change-gw.sh
> index fc88ee0f3..350cb45c9 100755
> --- a/testcases/network/stress/route/route-change-gw.sh
> +++ b/testcases/network/stress/route/route-change-gw.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
> -# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
> +# Copyright (c) 2019-2020 Petr Vorel <pvorel@suse.cz>
>  # Copyright (c) International Business Machines Corp., 2006
>  # Author: Mitsuru Chinen <mitch@jp.ibm.com>
>  # Rewrite into new shell API: Petr Vorel
> @@ -8,20 +8,11 @@
>  # Change route gateway
>  # lhost: 10.23.1.1, gw (on rhost): 10.23.1.x, rhost: 10.23.0.1
>  
> +TST_SETUP="setup_gw"
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
> index 77661a45e..40f45df41 100755
> --- a/testcases/network/stress/route/route-change-if.sh
> +++ b/testcases/network/stress/route/route-change-if.sh
> @@ -9,6 +9,7 @@
>  # lhost: 10.23.x.2, gw (on rhost): 10.23.x.1, rhost: 10.23.0.1, switching ifaces on lhost
>  
>  TST_TESTFUNC="test_if"
> +TST_CNT=$NS_TIMES
>  . route-lib.sh
>  TST_CLEANUP="cleanup"
>  
> diff --git a/testcases/network/stress/route/route-change-netlink-dst.sh b/testcases/network/stress/route/route-change-netlink-dst.sh
> new file mode 100755
> index 000000000..40e44bb98
> --- /dev/null
> +++ b/testcases/network/stress/route/route-change-netlink-dst.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> +#
> +# Change route destination via netlink
> +# lhost: 10.0.0.2, rhost: 10.23.x.1
> +
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
> +	while [ $cnt -lt $NS_TIMES -a $cnt -lt $MAX_IP ]; do
> +		rt="$(tst_ipaddr_un -p $cnt)"
> +		rhost="$(tst_ipaddr_un $cnt 1)"
> +		rhost_all="$rhost^$rhost_all"
> +
> +		tst_add_ipaddr -s -q -a $rhost rhost
> +		ROD ip route add $rt dev $(tst_iface)
> +		cnt=$((cnt+1))
> +	done
> +
> +	ROUTE_CHANGE_NETLINK_PARAMS="-l $(tst_ipaddr) -r '$rhost_all'"
> +}
> +
> +tst_run
> diff --git a/testcases/network/stress/route/route-change-netlink-gw.sh b/testcases/network/stress/route/route-change-netlink-gw.sh
> new file mode 100755
> index 000000000..374a3ad7b
> --- /dev/null
> +++ b/testcases/network/stress/route/route-change-netlink-gw.sh
> @@ -0,0 +1,28 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> +#
> +# Change route gateway via netlink
> +# lhost: 10.23.1.1, gw (on rhost): 10.23.1.x, rhost: 10.23.0.1
> +
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
> +	while [ $cnt -lt $NS_TIMES -a $cnt -lt $MAX_IP ]; do
> +		gw="$(tst_ipaddr_un -h 2,$max_ip_limit 1 $(($cnt + 1)))"
> +		gw_all="$gw^$gw_all"
> +		tst_add_ipaddr -s -q -a $gw rhost
> +		cnt=$((cnt+1))
> +	done
> +
> +	ROUTE_CHANGE_NETLINK_PARAMS="-g "$gw_all" -l $lhost -r $rhost"
> +}
> +
> +tst_run
> diff --git a/testcases/network/stress/route/route-change-netlink.c b/testcases/network/stress/route/route-change-netlink.c
> new file mode 100644
> index 000000000..c85e9224c
> --- /dev/null
> +++ b/testcases/network/stress/route/route-change-netlink.c
> @@ -0,0 +1,348 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> + */
> +
> +/*
> + * dst: lhost: 10.0.0.2, rhost: 10.23.x.1
> + * gw:  lhost: 10.23.1.1, gw (on rhost): 10.23.1.x, rhost: 10.23.0.1
> + * if:  lhost: 10.23.x.2, gw (on rhost): 10.23.x.1, rhost: 10.23.0.1, switching ifaces on lhost
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
> +#define IP_ADDR_DELIMITER '^'

Why not to use more obvious delimiter, comma?

> +#define STR(x) #x
> +#define CHR2STR(x) STR(x)
> +
> +static char *c_opt, *d_opt, *g_opt, *ipv6_opt, *l_opt, *p_opt, *r_opt;
> +
> +static int family = AF_INET;
> +static int fd, num_loops, port;
> +
> +static unsigned int is_ipv6, max, prefix;
> +
> +static struct mnl_socket *nl;
> +static struct addrinfo *lhost_addrinfo, *rhost_addrinfo;
> +
> +struct in_addr ip;
> +struct in6_addr ip6;
> +
> +union {
> +	in_addr_t ip;
> +	struct in6_addr ip6;
> +} dst;
> +
> +struct iface {
> +	char iface[IFNAMSIZ];
> +	unsigned int index;
> +	struct iface *next;
> +};
> +
> +struct ip_addr {
> +	char ip[INET6_ADDRSTRLEN];

What about adding 'struct addrinfo' here, and use it instead of ip
string manipulation during the test?

> +	struct ip_addr *next;
> +};
> +
> +static struct ip_addr *gw, *lhost, *rhost;
> +static struct iface *iface;
> +static unsigned int gw_len, iface_len, lhost_len, rhost_len;
> +
> +void save_iface_str(struct iface **list, const char *item)
> +{
> +	struct iface *n = SAFE_MALLOC(sizeof(*n));
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
> +void save_ip_str(struct ip_addr **list, const char *item)
> +{
> +	struct ip_addr *n = SAFE_MALLOC(sizeof(*n));
> +
> +	strncpy(n->ip, item, sizeof(n->ip));
> +	n->ip[sizeof(n->ip)-1] = '\0';
> +
> +	n->next = *list;
> +	*list = n;
> +}
> +
> +int save_iface(struct iface **list, char *item)
> +{
> +	int len = 0;
> +
> +	while ((item = strtok(item, CHR2STR(IP_ADDR_DELIMITER))) != NULL) {
> +		save_iface_str(list, item);
> +		item = NULL
> +		len++;
> +	}
> +
> +	return len;
> +}
> +
> +int save_ip(struct ip_addr **list, char *item)
> +{
> +	int len = 0;
> +
> +	while ((item = strtok(item, CHR2STR(IP_ADDR_DELIMITER))) != NULL) {
> +		save_ip_str(list, item);
> +		item = NULL;
> +		len++;
> +	}
> +
> +	return len;
> +}
> +

It would be better to pass a callback (save_ip_str or save_iface_str), these
two functions are almost identical.

> +static void setup(void)
> +{
> +	prefix = 24;
> +	if (ipv6_opt) {
> +		family = AF_INET6;
> +		is_ipv6 = 1;
> +		prefix = 64;
> +	}
> +	if (!c_opt)
> +		tst_brk(TBROK, "missing number of loops (-c num)");
> +
> +	if (!d_opt)
> +		tst_brk(TBROK, "Missing iface (-d iface)");
> +
> +	if (!l_opt)
> +		tst_brk(TBROK, "Missing lhost IP (-l IP)");
> +
> +	if (!p_opt)
> +		tst_brk(TBROK, "Missing rhost port (-p port)");
> +
> +	if (!r_opt)
> +		tst_brk(TBROK, "Missing rhost IP (-r IP)");
> +
> +	if (tst_parse_int(p_opt, &port, 1, 65535))
> +		tst_brk(TBROK, "invalid rhost port '%s'", p_opt);
> +
> +	if (tst_parse_int(c_opt, &num_loops, 1, 65535))
> +		tst_brk(TBROK, "invalid number of loops '%s'", c_opt);
> +
> +	iface_len = save_iface(&iface, d_opt);
> +	lhost_len = save_ip(&lhost, l_opt);
> +	rhost_len = save_ip(&rhost, r_opt);
> +
> +	max = MAX(lhost_len, rhost_len);
> +	if (lhost_len > 1 && rhost_len > 1 && lhost_len != rhost_len)
> +		tst_brk(TBROK, "-l and -r have more IP, they need to have the same count");
> +
> +	max = MAX(iface_len, max);
> +	if (iface_len > 1 && max > 1 && iface_len != max)
> +		tst_brk(TBROK, "-d has more NIC and %s has more IP, they need to have the same count",
> +				lhost_len > 1 ? "-l" : "-r");
> +
> +	if (g_opt) {
> +		gw_len = save_ip(&gw, g_opt);
> +		max = MAX(gw_len, max);
> +
> +		if (gw_len > 1 && max > 1 && gw_len != max) {
> +			if (iface_len == max)
> +				tst_brk(TBROK, "-d has more NIC and -g has more IP, they need to have the same count");
> +			else
> +				tst_brk(TBROK, "-g and %s have more IP, they need to have the same count",
> +						lhost_len > 1 ? "-l" : "-r");
> +		}
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd > 0)
> +		close(fd);
> +
> +	if (nl)
> +		mnl_socket_close(nl);
> +
> +	if (lhost_addrinfo)
> +		freeaddrinfo(lhost_addrinfo);
> +
> +	if (rhost_addrinfo)
> +		freeaddrinfo(rhost_addrinfo);
> +}
> +
> +static void rtnl_route(int iface, char *destination, uint32_t prefix, char
> +		       *gateway, int type)
> +{
> +	union {
> +		in_addr_t ip;
> +		struct in6_addr ip6;
> +	} dst;
> +	union {
> +		in_addr_t ip;
> +		struct in6_addr ip6;
> +	} gw;
> +
> +	struct mnl_socket *nl;
> +	char buf[MNL_SOCKET_BUFFER_SIZE];
> +	struct nlmsghdr *nlh;
> +	struct rtmsg *rtm;
> +	uint32_t seq, portid;
> +	int ret;
> +
> +	if (!inet_pton(family, destination, &dst))
> +		tst_brk(TBROK, "inet_pton failed ('%s', errno=%d): %s",
> +			destination, errno, strerror(errno));
> +
> +	if (gateway && !inet_pton(family, gateway, &gw))
> +		tst_brk(TBROK, "inet_pton failed ('%s', errno=%d): %s", gateway,
> +			errno, strerror(errno));
> +
> +	nlh = mnl_nlmsg_put_header(buf);
> +	nlh->nlmsg_type	= type;
> +	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_ACK;
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
> +	rtm->rtm_scope = (gateway) ? RT_SCOPE_UNIVERSE : RT_SCOPE_LINK;
> +	rtm->rtm_flags = 0;
> +
> +	if (is_ipv6)
> +		mnl_attr_put(nlh, RTA_DST, sizeof(struct in6_addr), &dst);
> +	else
> +		mnl_attr_put_u32(nlh, RTA_DST, dst.ip);
> +
> +	mnl_attr_put_u32(nlh, RTA_OIF, iface);
> +	if (gateway) {
> +		if (is_ipv6)
> +			mnl_attr_put(nlh, RTA_GATEWAY, sizeof(struct in6_addr),
> +					&gw.ip6);
> +		else
> +			mnl_attr_put_u32(nlh, RTA_GATEWAY, gw.ip);
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
> +static void send_udp(char *local, char *remote)
> +{
> +	fd = SAFE_SOCKET(family, SOCK_DGRAM, IPPROTO_UDP);
> +
> +	struct addrinfo hints;
> +	memset(&hints, 0, sizeof(struct addrinfo));
> +	hints.ai_family = family;
> +	hints.ai_socktype = SOCK_DGRAM;
> +	hints.ai_flags = 0;
> +	hints.ai_protocol = 0;
> +	hints.ai_addr = INADDR_ANY;

It seems this block can be moved to setup, socket() and hints.

> +
> +	tst_setup_addrinfo(local, NULL, &hints, &lhost_addrinfo);

lhost_addrinfo - is it used?

> +	tst_setup_addrinfo(remote, p_opt, &hints, &rhost_addrinfo);
> +
> +	SAFE_SENDTO(1, fd, remote, sizeof(remote), MSG_CONFIRM,
> +		rhost_addrinfo->ai_addr, rhost_addrinfo->ai_addrlen);
> +
> +	close(fd);
> +}
> +
> +static void run(void)
> +{
> +	int i;
> +
> +	tst_res(TINFO, "adding and deleting route with different destination %d times", num_loops);
> +
> +	struct ip_addr *p_gw = gw, *p_lhost = lhost, *p_rhost = rhost;
> +	struct iface *p_iface = iface;
> +	char dst[INET6_ADDRSTRLEN];
> +
> +	for (i = 0; i < num_loops; i++) {
> +		if (!strncpy(dst, rhost->ip, sizeof(dst)))
> +			tst_brk(TBROK, "failed copy IP '%s'", rhost->ip);
> +		dst[strlen(rhost->ip)-1] = '\0';
> +
> +		if (!strcat(dst, "0"))
> +			tst_brk(TBROK, "strcat failed: '%s'", dst);
> +
> +		rtnl_route(iface->index, dst, prefix, gw->ip, RTM_NEWROUTE);
> +		send_udp(lhost->ip, rhost->ip);
> +		rtnl_route(iface->index, dst, prefix, gw->ip, RTM_DELROUTE);
> +
> +		if (gw)
> +			gw = gw->next ?: p_gw;
> +		iface = iface->next ?: p_iface;
> +		lhost = lhost->next ?: p_lhost;
> +		rhost = rhost->next ?: p_rhost;
> +	}
> +
> +	tst_res(TPASS, "routes created and deleted");
> +}
> +
> +static struct tst_option options[] = {
> +	{"6", &ipv6_opt, "-6       Use IPv6 (default is IPv4)"},
> +	{"c:", &c_opt, "         num loops (mandatory)"},
> +	{"d:", &d_opt, "-d iface Interface to work on (mandatory)"},
> +	{"g:", &g_opt, "-g x     gateway IP"},
> +	{"l:", &l_opt, "-l x     lhost IP (mandatory)"},
> +	{"p:", &p_opt, "-p port  rhost port (mandatory)"},
> +	{"r:", &r_opt, "-r x     rhost IP (mandatory)\n\n-g, -l, -g IP paramter can contain more IP, separated by "
> +		CHR2STR(IP_ADDR_DELIMITER)},
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
> index 4afbe6323..dc77b60b7 100644
> --- a/testcases/network/stress/route/route-lib.sh
> +++ b/testcases/network/stress/route/route-lib.sh
> @@ -6,10 +6,52 @@ TST_NEEDS_ROOT=1
>  TST_SETUP="setup"
>  TST_CLEANUP="route_cleanup"
>  TST_NEEDS_CMDS="ip"
> -TST_CNT=$NS_TIMES
>  
>  . tst_net.sh
>  
> +ROUTE_RHOST_PORT=${ROUTE_RHOST_PORT:-65535}
> +
> +MAX_IP=${MAX_IP:-5}
> +
> +check_max_ip()
> +{
> +	local max_ip_limit=254
> +	[ "$TST_IPV6" ] && max_ip_limit=65534
> +
> +	tst_is_int $MAX_IP || tst_brk TBROK "\$MAX_IP not int ($MAX_IP)"
> +	[ "$MAX_IP" -gt $max_ip_limit ] && MAX_IP=$max_ip_limit
> +}
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
> +
> +test_netlink()
> +{
> +	local ret=0
> +	local ip_flag
> +	[ "$TST_IPV6" ] && ip_flag="-6"
> +
> +	route-change-netlink -c $NS_TIMES -d $(tst_iface) $ip_flag -p $ROUTE_RHOST_PORT $ROUTE_CHANGE_NETLINK_PARAMS || ret=$?
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
> +
>  route_cleanup()
>  {
>  	tst_restore_ipaddr
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

