From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 May 2019 20:31:32 +0200
Subject: [LTP] [RFC PATCH v2 6/6] net/route: Rewrite route{4, 6}-change-{dst,
	gw} into C
In-Reply-To: <20190510183132.31039-1-pvorel@suse.cz>
References: <20190510183132.31039-1-pvorel@suse.cz>
Message-ID: <20190510183132.31039-7-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Code:
* use libmnl and new C API
* reuse code in tst_net.h (added in previous commit)
* add shell wrapper (set environment with tst_net.sh instead of using
  deprecated helpers in testcases/network/stress/ns-tools/)
* Add tst_ipaddr_un() into C API, unlike shell API this implementation
  does not support -c tst_ipaddr_un [-cCOUNTER] [TYPE] syntax.

Travis:
* add libmnl libraries to most of travis jobs
* replace spaces with tabs some travis shell files

Cleanup:
* cleanup test description
* other cleanup

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac                                  |   1 +
 include/mk/config.mk.default                  |   2 +
 include/mk/config.mk.in                       |   2 +
 include/tst_net.h                             |  45 +++
 m4/ltp-libmnl.m4                              |   7 +
 runtest/net_stress.route                      |  10 +-
 testcases/network/stress/route/.gitignore     |   1 +
 .../network/stress/route/00_Descriptions.txt  |  48 +--
 testcases/network/stress/route/Makefile       |  30 +-
 testcases/network/stress/route/route-change.c | 243 +++++++++++++++
 .../network/stress/route/route-change.sh      |  52 ++++
 .../network/stress/route/route4-change-dst    | 276 -----------------
 .../network/stress/route/route4-change-gw     | 292 ------------------
 .../network/stress/route/route6-change-dst    | 272 ----------------
 .../network/stress/route/route6-change-gw     | 292 ------------------
 travis/debian.cross-compile.aarch64.sh        |   6 +-
 travis/debian.cross-compile.ppc64le.sh        |   8 +-
 travis/debian.i386.sh                         |   3 +-
 travis/debian.minimal.sh                      |  28 +-
 travis/debian.sh                              |  55 ++--
 travis/fedora.sh                              |   5 +-
 travis/tumbleweed.sh                          |   7 +-
 22 files changed, 443 insertions(+), 1242 deletions(-)
 create mode 100644 m4/ltp-libmnl.m4
 create mode 100644 testcases/network/stress/route/.gitignore
 create mode 100644 testcases/network/stress/route/route-change.c
 create mode 100755 testcases/network/stress/route/route-change.sh
 delete mode 100644 testcases/network/stress/route/route4-change-dst
 delete mode 100644 testcases/network/stress/route/route4-change-gw
 delete mode 100644 testcases/network/stress/route/route6-change-dst
 delete mode 100644 testcases/network/stress/route/route6-change-gw

diff --git a/configure.ac b/configure.ac
index fad8f8396..0ea6ed531 100644
--- a/configure.ac
+++ b/configure.ac
@@ -207,6 +207,7 @@ LTP_CHECK_IOVEC
 LTP_CHECK_KCMP_TYPE
 LTP_CHECK_KERNEL_DEVEL
 LTP_CHECK_KEYUTILS_SUPPORT
+LTP_CHECK_LIBMNL
 LTP_CHECK_LINUX_PTRACE
 LTP_CHECK_LINUXRANDOM
 LTP_CHECK_MADVISE
diff --git a/include/mk/config.mk.default b/include/mk/config.mk.default
index 0934d9453..d55ca888d 100644
--- a/include/mk/config.mk.default
+++ b/include/mk/config.mk.default
@@ -43,6 +43,8 @@ YACC			:= bison -y
 #SELINUX_LIBS		:= -lselinux
 #TIRPC_CPPFLAGS		:= -I/usr/include/tirpc
 #TIRPC_LIBS		:= -ltirpc
+#LIBMNL_LIBS		:= -lmnl
+#LIBMNL_CFLAGS		:= -I/usr/include/libmnl
 
 prefix			:= /opt/ltp
 
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index d55fe9602..ee442f718 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -47,6 +47,8 @@ TIRPC_CPPFLAGS		:= @TIRPC_CPPFLAGS@
 TIRPC_LIBS		:= @TIRPC_LIBS@
 KEYUTILS_LIBS		:= @KEYUTILS_LIBS@
 HAVE_FTS_H		:= @HAVE_FTS_H@
+LIBMNL_LIBS		:= @LIBMNL_LIBS@
+LIBMNL_CFLAGS		:= @LIBMNL_CFLAGS@
 
 prefix			:= @prefix@
 
diff --git a/include/tst_net.h b/include/tst_net.h
index ad067d8c6..404595241 100644
--- a/include/tst_net.h
+++ b/include/tst_net.h
@@ -7,10 +7,14 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include "tst_safe_stdio.h"
 
 #define MAX_IPV4_PREFIX 32
 #define MAX_IPV6_PREFIX 128
 
+#define MAX_IPV4_NET_ID 255
+#define MAX_IPV6_NET_ID 65535
+
 #define tst_res_comment(...) { \
 	fprintf(stderr, "# "); \
 	tst_res(__VA_ARGS__); } \
@@ -154,3 +158,44 @@ static inline void setup_addrinfo(const char *src_addr, const char *port,
 	if (!*addr_info)
 		tst_brk(TBROK, "failed to get the address");
 }
+
+/*
+ * NOTE: unlike shell implementation this support only:
+ * tst_ipaddr_un NET_ID HOST_ID
+ */
+static inline char *tst_ipaddr_un(int ai_family, unsigned int net, unsigned int host)
+{
+	char *env = "IPV4_NET16_UNUSED";
+	unsigned int max = MAX_IPV4_NET_ID;
+	char *addr, *unused;
+
+	if (ai_family != AF_INET && ai_family != AF_INET6)
+		tst_brk(TCONF, "ai_family must be AF_INET or AF_INET6 (%d)", ai_family);
+
+	if (ai_family == AF_INET6) {
+		env = "IPV6_NET32_UNUSED";
+		max = MAX_IPV6_NET_ID;
+	}
+
+	unused = getenv(env);
+	if (!unused)
+		tst_brk(TCONF, "%s not set (set it with tst_net.sh)", env);
+
+	net %= max;
+	host %= max;
+
+	if (ai_family == AF_INET6) {
+		if (host > 0 && net > 0)
+			SAFE_ASPRINTF(&addr, "%s:%x::%x", unused, net, host);
+		else if (host > 0 && net == 0)
+			SAFE_ASPRINTF(&addr, "%s::%x", unused, host);
+		else if (net > 0 && host == 0)
+			SAFE_ASPRINTF(&addr, "%s:%x::", unused, net);
+		else
+			SAFE_ASPRINTF(&addr, "%s::", unused);
+	} else {
+		SAFE_ASPRINTF(&addr, "%s.%d.%d", unused, net, host);
+	}
+
+	return strdup(addr);
+}
diff --git a/m4/ltp-libmnl.m4 b/m4/ltp-libmnl.m4
new file mode 100644
index 000000000..56adaba6e
--- /dev/null
+++ b/m4/ltp-libmnl.m4
@@ -0,0 +1,7 @@
+dnl Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+
+AC_DEFUN([LTP_CHECK_LIBMNL], [
+    PKG_CHECK_MODULES([LIBMNL], [libmnl], [
+        AC_DEFINE([HAVE_LIBMNL], [1], [Define to 1 if you have libmnl libraries and headers])
+	], [have_libmnl=no])
+])
diff --git a/runtest/net_stress.route b/runtest/net_stress.route
index c065c5cd1..0a72c4eee 100644
--- a/runtest/net_stress.route
+++ b/runtest/net_stress.route
@@ -1,13 +1,11 @@
-#
 # Stress test for routing table
-#
 
-route4-change-dst route4-change-dst
-route4-change-gw route4-change-gw
+route4-change-dst route-change.sh
+route4-change-gw route-change.sh -g
 route4-redirect route4-redirect
 route4-rmmod route4-rmmod
 
-route6-change-dst route6-change-dst
-route6-change-gw route6-change-gw
+route6-change-dst route-change.sh -6
+route6-change-gw route-change.sh -6 -g
 route6-redirect route6-redirect
 route6-rmmod route6-rmmod
diff --git a/testcases/network/stress/route/.gitignore b/testcases/network/stress/route/.gitignore
new file mode 100644
index 000000000..53d3c16d1
--- /dev/null
+++ b/testcases/network/stress/route/.gitignore
@@ -0,0 +1 @@
+/route-change
diff --git a/testcases/network/stress/route/00_Descriptions.txt b/testcases/network/stress/route/00_Descriptions.txt
index 91aa01120..e31f5918b 100644
--- a/testcases/network/stress/route/00_Descriptions.txt
+++ b/testcases/network/stress/route/00_Descriptions.txt
@@ -1,56 +1,32 @@
-route4-change-dst01
-	Verify the kernel is not crashed when the destination of an IPv4 route
-	is changed frequently by route command
+route4-change-dst
+	Change IPv4 route destination by libmnl API
 
-route4-change-dst02
-	Verify the kernel is not crashed when the destination of an IPv4 route
-	is changed frequently by ip command
-
-route4-change-gw01
-	Verify the kernel is not crashed when the gateway of an IPv4 route is
-	changed frequently by route command
-
-route4-change-gw02
-	Verify the kernel is not crashed when the gateway of an IPv4 route is
-	changed frequently by ip command
+route4-change-gw
+	Change IPv4 route gateway by libmnl API
 
 route4-redirect01
 	Verify the kernel is not crashed when the IPv4 route is modified by
 	ICMP Redirects frequently
 
 route4-rmmod01
-	Verify the kernel is not crashed when IPv4 route is add by route command
-	then it is deleted by the removing network driver
+	Add IPv4 route by route command then delete it by the removing network driver
 
 route4-rmmod02
-	Verify the kernel is not crashed when IPv4 route is add by ip command
-	then it is deleted by the removing network driver
-
-
-route6-change-dst01
-	Verify the kernel is not crashed when the destination of an IPv6 route
-	is changed frequently by route command
+	Add IPv4 route by ip command then delete it by the removing network driver
 
-route6-change-dst02
-	Verify the kernel is not crashed when the destination of an IPv6 route
-	is changed frequently by ip command
 
-route6-change-gw01
-	Verify the kernel is not crashed when the gateway of an IPv6 route is
-	changed frequently by route command
+route6-change-dst
+	Change IPv6 route destination by libmnl API
 
-route6-change-gw02
-	Verify the kernel is not crashed when the gateway of an IPv6 route is
-	changed frequently by ip command
+route6-change-gw
+	Change IPv6 route gateway by libmnl API
 
 route6-redirect01
 	Verify the kernel is not crashed when the IPv6 route is modified by
 	ICMP Redirects frequently
 
 route6-rmmod01
-	Verify the kernel is not crashed when IPv6 route is add by route command
-	then it is deleted by the removing network driver
+	Add IPv6 route by route command then delete it by the removing network driver
 
 route6-rmmod02
-	Verify the kernel is not crashed when IPv6 route is add by ip command
-	then it is deleted by the removing network driver
+	Add IPv6 route by ip command then delete it by the removing network driver
diff --git a/testcases/network/stress/route/Makefile b/testcases/network/stress/route/Makefile
index 2e5eaa2f2..49247e4d8 100644
--- a/testcases/network/stress/route/Makefile
+++ b/testcases/network/stress/route/Makefile
@@ -1,29 +1,15 @@
-#
-#    network/stress/route test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
+# Copyright (c) Linux Test Project, 2006-2019
 # Ngie Cooper, October 2009
-#
 
 top_srcdir		?= ../../../..
 
-include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/testcases.mk
 
-INSTALL_TARGETS		:= route*
+INSTALL_TARGETS		+= route[4-6]-* *.sh
+
+route-change: CFLAGS += $(LIBMNL_CFLAGS)
+route-change: LDLIBS += $(LIBMNL_LIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/stress/route/route-change.c b/testcases/network/stress/route/route-change.c
new file mode 100644
index 000000000..d694a0f65
--- /dev/null
+++ b/testcases/network/stress/route/route-change.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+ */
+
+#include "config.h"
+#include "tst_test.h"
+
+#ifdef HAVE_LIBMNL
+
+#include <string.h>
+
+#include <libmnl/libmnl.h>
+#include <linux/rtnetlink.h>
+#include <net/if.h>
+#include <netdb.h>
+
+#include "tst_net.h"
+#include "tst_safe_net.h"
+#include "tst_safe_stdio.h"
+
+#define NS_TIMES_MAX 255
+#define MAX_IP 255
+
+static char *c_opt, *d_opt, *g_opt, *ipv6_opt, *l_opt, *m_opt, *r_opt;
+static int family = AF_INET;
+static int num_loops = 10000;
+static int iface, is_ipv6, gwhost, lhost, max_ip = MAX_IP, rhost;
+static unsigned int prefix;
+static struct mnl_socket *nl;
+static struct addrinfo *local_addrinfo;
+static struct addrinfo *remote_addrinfo;
+static int fd;
+
+struct in_addr ip;
+struct in6_addr ip6;
+
+union {
+	in_addr_t ip;
+	struct in6_addr ip6;
+} dst;
+
+static void setup(void)
+{
+	prefix = 24;
+	if (ipv6_opt) {
+		family = AF_INET6;
+		is_ipv6 = 1;
+		prefix = 64;
+	}
+
+	if (tst_parse_int(c_opt, &num_loops, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid number of loops: '%s'", c_opt);
+
+	if (!d_opt)
+		tst_brk(TBROK, "Missing iface, specify it with -d");
+
+	iface = if_nametoindex(d_opt);
+	if (!iface)
+		tst_brk(TBROK, "if_nametoindex failed");
+
+	if (g_opt  && tst_parse_int(g_opt, &gwhost, 1, NS_TIMES_MAX))
+		tst_brk(TBROK, "Invalid gateway host id: '%s'", g_opt);
+
+	if (!l_opt)
+		tst_brk(TBROK, "Missing local host id, specify it with -l");
+
+	if (m_opt && tst_parse_int(m_opt, &max_ip, 1, MAX_IP))
+		tst_brk(TBROK, "Invalid max IP: '%s'", m_opt);
+
+	if (tst_parse_int(l_opt, &lhost, 1, NS_TIMES_MAX))
+		tst_brk(TBROK, "Invalid local host id: '%s'", l_opt);
+
+	if (!r_opt)
+		tst_brk(TBROK, "Missing remote host id, specify it with -r");
+
+	if (tst_parse_int(r_opt, &rhost, 1, NS_TIMES_MAX))
+		tst_brk(TBROK, "Invalid remote host id: '%s'", r_opt);
+
+	if (lhost == gwhost || lhost == rhost || rhost == gwhost)
+		tst_brk(TBROK, "-g, -l and -r params must be different: %d, %d, %d",
+				gwhost, rhost, lhost);
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		close(fd);
+
+	if (nl)
+		mnl_socket_close(nl);
+
+	if (remote_addrinfo)
+		freeaddrinfo(remote_addrinfo);
+}
+
+static void rtnl_route(int iface, char *destination, uint32_t prefix, char *gateway, int type)
+{
+	union {
+		in_addr_t ip;
+		struct in6_addr ip6;
+	} dst;
+	union {
+		in_addr_t ip;
+		struct in6_addr ip6;
+	} gw;
+
+	struct mnl_socket *nl;
+	char buf[MNL_SOCKET_BUFFER_SIZE];
+	struct nlmsghdr *nlh;
+	struct rtmsg *rtm;
+	uint32_t seq, portid;
+	int ret;
+
+	if (!inet_pton(family, destination, &dst))
+		tst_brk(TBROK, "inet_pton failed ('%s', errno=%d): %s", destination, errno, strerror(errno));
+
+	if (gateway && !inet_pton(family, gateway, &gw))
+		tst_brk(TBROK, "inet_pton failed ('%s', errno=%d): %s", gateway, errno, strerror(errno));
+
+	nlh = mnl_nlmsg_put_header(buf);
+	nlh->nlmsg_type	= type;
+	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_ACK;
+	nlh->nlmsg_seq = seq = time(NULL);
+
+	rtm = mnl_nlmsg_put_extra_header(nlh, sizeof(struct rtmsg));
+	rtm->rtm_family = family;
+	rtm->rtm_dst_len = prefix;
+	rtm->rtm_src_len = 0;
+	rtm->rtm_tos = 0;
+	rtm->rtm_protocol = RTPROT_STATIC;
+	rtm->rtm_table = RT_TABLE_MAIN;
+	rtm->rtm_type = RTN_UNICAST;
+	rtm->rtm_scope = (gateway) ? RT_SCOPE_UNIVERSE : RT_SCOPE_LINK;
+	rtm->rtm_flags = 0;
+
+	if (is_ipv6)
+		mnl_attr_put(nlh, RTA_DST, sizeof(struct in6_addr), &dst);
+	else
+		mnl_attr_put_u32(nlh, RTA_DST, dst.ip);
+
+	mnl_attr_put_u32(nlh, RTA_OIF, iface);
+	if (gateway) {
+		if (is_ipv6)
+			mnl_attr_put(nlh, RTA_GATEWAY, sizeof(struct in6_addr),
+					&gw.ip6);
+		else
+			mnl_attr_put_u32(nlh, RTA_GATEWAY, gw.ip);
+	}
+
+	nl = mnl_socket_open(NETLINK_ROUTE);
+	if (nl == NULL)
+		tst_brk(TBROK, "mnl_socket_open failed (errno=%d): %s", errno, strerror(errno));
+
+	if (mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID) < 0)
+		tst_brk(TBROK, "mnl_socket_bind failed (errno=%d): %s", errno, strerror(errno));
+
+	portid = mnl_socket_get_portid(nl);
+
+	if (mnl_socket_sendto(nl, nlh, nlh->nlmsg_len) < 0)
+		tst_brk(TBROK, "mnl_socket_sendto failed (errno=%d): %s", errno, strerror(errno));
+
+	ret = mnl_socket_recvfrom(nl, buf, sizeof(buf));
+	if (ret < 0)
+		tst_brk(TBROK, "mnl_socket_recvfrom failed (ret=%d, errno=%d): %s", ret, errno, strerror(errno));
+
+	ret = mnl_cb_run(buf, ret, seq, portid, NULL, NULL);
+	if (ret < 0)
+		tst_brk(TBROK, "mnl_cb_run failed (ret=%d, errno=%d): %s", ret, errno, strerror(errno));
+
+	mnl_socket_close(nl);
+}
+
+static void send_udp(char *local, char *remote)
+{
+	fd = SAFE_SOCKET(family, SOCK_DGRAM, IPPROTO_UDP);
+
+	struct addrinfo hints;
+	memset(&hints, 0, sizeof(struct addrinfo));
+	hints.ai_family = family;
+	hints.ai_socktype = SOCK_DGRAM;
+	hints.ai_flags = 0;
+	hints.ai_protocol = 0;
+	hints.ai_addr = INADDR_ANY;
+	setup_addrinfo(local, NULL, &hints, &local_addrinfo);
+	char *port;
+	int _port = TST_GET_UNUSED_PORT(family, SOCK_DGRAM);
+	SAFE_ASPRINTF(&port, "%d", _port);
+	setup_addrinfo(remote, port, &hints, &remote_addrinfo);
+
+	SAFE_BIND(fd, local_addrinfo->ai_addr, local_addrinfo->ai_addrlen);
+
+	SAFE_SENDTO(1, fd, remote, strlen(remote), MSG_CONFIRM,
+		remote_addrinfo->ai_addr, remote_addrinfo->ai_addrlen);
+
+	close(fd);
+}
+
+static void run(void)
+{
+	int i, j;
+	char *destination, *gateway = NULL, *local, *remote;
+
+	tst_res(TINFO, "Adding and deleting route with different destination %d times", num_loops);
+	for (i = 0; i < num_loops; i++) {
+		j = i % max_ip;
+		local = tst_ipaddr_un(family, j, lhost);
+		remote = tst_ipaddr_un(family, j, rhost);
+		if (g_opt) {
+			destination = tst_ipaddr_un(family, 0, 0);
+			gateway = tst_ipaddr_un(family, j, gwhost);
+		} else {
+			destination = tst_ipaddr_un(family, j, 0);
+		}
+
+		rtnl_route(iface, destination, prefix, gateway, RTM_NEWROUTE);
+		send_udp(local, remote);
+		rtnl_route(iface, destination, prefix, gateway, RTM_DELROUTE);
+	}
+
+	tst_res(TPASS, "Routes created and deleted");
+}
+
+static struct tst_option options[] = {
+	{"6", &ipv6_opt, "-6       Use IPv6 (default is IPv4)"},
+	{"c:", &c_opt, "-c x     Number of loops"},
+	{"d:", &d_opt, "-d IFACE Interface to work on"},
+	{"g:", &g_opt, "-g x     Change gateway instead of destination, x: Host id of gateway"},
+	{"l:", &l_opt, "-l x     Local host id"},
+	{"m:", &m_opt, "-m x     Max IP addresses, this modulos -c"},
+	{"r:", &r_opt, "-r x     Remote host id"},
+	{NULL, NULL, NULL}
+};
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.options = options,
+};
+#else
+	TST_TEST_TCONF("netlink libraries and headers are required");
+#endif /* HAVE_LIBNL_CLI3 */
diff --git a/testcases/network/stress/route/route-change.sh b/testcases/network/stress/route/route-change.sh
new file mode 100755
index 000000000..35b23a15f
--- /dev/null
+++ b/testcases/network/stress/route/route-change.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+
+TST_TESTFUNC="do_test"
+TST_OPTS="g"
+TST_PARSE_ARGS="route_change_parse_args"
+TST_SETUP="setup"
+TST_CLEANUP="cleanup"
+TST_NEEDS_TMPDIR=1
+. tst_net.sh
+
+GATEWAY=1
+LHOST=2
+RHOST=3
+
+MAX_IP=${MAX_IP:-255}
+NS_TIMES=${NS_TIMES:-10000}
+
+route_change_parse_args()
+{
+	case "$1" in
+	g) g_opt="-g $GATEWAY" ;;
+	esac
+}
+
+setup()
+{
+	local cnt=0
+
+	while [ $cnt -lt $NS_TIMES -a $cnt -lt $MAX_IP ]; do
+		tst_add_ipaddr -s -a $(tst_ipaddr_un $cnt $LHOST)
+		tst_add_ipaddr -s -a $(tst_ipaddr_un $cnt $RHOST) rhost
+		cnt=$((cnt+1))
+	done
+}
+
+cleanup()
+{
+	tst_restore_ipaddr
+	tst_restore_ipaddr rhost
+}
+
+do_test()
+{
+	local ip_flag port
+	[ "$TST_IPV6" ] && ip_flag="-6"
+
+	EXPECT_PASS route-change -d $(tst_iface) -c $NS_TIMES $ip_flag $g_opt -l $LHOST -m $MAX_IP -r $RHOST
+}
+
+tst_run
diff --git a/testcases/network/stress/route/route4-change-dst b/testcases/network/stress/route/route4-change-dst
deleted file mode 100644
index 8ec606152..000000000
--- a/testcases/network/stress/route/route4-change-dst
+++ /dev/null
@@ -1,276 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2006                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   route4-change-dst
-#
-# Description:
-#   Verify the kernel is not crashed when the destination of an IPv4 route is
-#   changed frequently
-#    test01 - by route command
-#    test02 - by ip command
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Mar 16 2006 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
-
-# Total number of the test case
-TST_TOTAL=2
-export TST_TOTAL
-
-# Default of the test case ID and the test case count
-TCID=route4-change-dst
-TST_COUNT=0
-export TCID
-export TST_COUNT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# The number of times where route is changed
-NS_TIMES=${NS_TIMES:-10000}
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# Network portion of the IPv4 address
-IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
-
-# Netmask of for the tested network
-IPV4_NETMASK="255.255.255.0"
-IPV4_NETMASK_NUM=24
-
-# Broadcast address of the tested network
-IPV4_BROADCAST=${IPV4_NETWORK}.255
-
-# Host portion of the IPv4 address
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}	# src
-RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}	# gateway
-
-# The destination network
-DST_NETWORK_PREFIX="10.10"	# destination network would be 10.10.n.0/24
-DST_HOST="5"
-DST_PORT="7"
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_setup
-#
-# DESCRIPTION:
-#   Make a IPv4 connectivity
-#
-# SET VALUES:
-#   rhost_ipv4addr	- IPv4 Address of the remote host
-#   lhost_ifname	- Interface name of the local host
-#   rhost_ifname	- Interface name of the remote host
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    TCID=route4-change-dst
-    TST_COUNT=0
-
-    # Initialize the interfaces of the remote host
-    initialize_if rhost ${LINK_NUM}
-
-    # Set IPv4 address to the interfaces
-    set_ipv4addr rhost ${LINK_NUM} ${IPV4_NETWORK} ${RHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add an IPv4 address the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # IPv4 address of the remote host (gateway)
-    rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
-
-    # Get the Interface name of local host
-    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    # Get the Interface name of remote host
-    rhost_ifname=`get_ifname rhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-}
-
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_cleanup
-#
-# DESCRIPTION:
-#   Recover the tested interfaces
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:
-#   test_body
-#
-# DESCRIPTION:
-#   main code of the test
-#
-# Arguments:
-#   $1: define the test type
-#       1 - route command case
-#       2 - ip command case
-#
-#-----------------------------------------------------------------------
-test_body()
-{
-    test_type=$1
-
-    TCID=route4-change-dst0${test_type}
-    TST_COUNT=$test_type
-
-    case $test_type in
-	1)
-	test_command="route"
-	;;
-	2)
-	test_command="ip"
-	;;
-	*)
-	tst_resm TBROK "unspecified case"
-	return 1
-	;;
-    esac
-
-    tst_resm TINFO "Verify the kernel is not crashed when the destination of an IPv4 route is changed frequently by $test_command command in $NS_TIMES times"
-
-    # Initialize the interface of the local host
-    initialize_if lhost ${LINK_NUM}
-
-    # Assign IPv4 address to the interface of the local host
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to assign an IPv4 address at the local host"
-	return 1
-    fi
-    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
-
-    # Check the connectivity to the gateway
-    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
-	return 1
-    fi
-
-    # Start the loop
-    cnt=0
-    while [ $cnt -lt $NS_TIMES ]; do
-	# Define the destination IP address
-	dst_network_postfix=`expr $cnt % 255`
-	dst_addr=${DST_NETWORK_PREFIX}.${dst_network_postfix}.${DST_HOST}
-	dst_network=${DST_NETWORK_PREFIX}.${dst_network_postfix}.0
-
-	# Add the route
-	case $test_type in
-	    1)
-	    route add -net $dst_network netmask 255.255.255.0 gw $rhost_ipv4addr dev $lhost_ifname
-	    ;;
-	    2)
-	    ip route add ${dst_network}/24 via $rhost_ipv4addr dev $lhost_ifname
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to add the route to ${dst_network}/24"
-	    return 1
-	fi
-
-	# Load the route with UDP datagram
-	ns-udpsender -f 4 -D $dst_addr -p $DST_PORT -o -s 1472
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to run a UDP datagram sender"
-	    return 1
-	fi
-
-	# Delete the route
-	case $test_type in
-	    1)
-	    route del -net $dst_network netmask 255.255.255.0 gw $rhost_ipv4addr dev $lhost_ifname
-	    ;;
-	    2)
-	    ip route del ${dst_network}/24 via $rhost_ipv4addr dev $lhost_ifname
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Cannot delete the route to ${ADDDEL_ROUTE}"
-	    return 1
-	fi
-
-	cnt=`expr $cnt + 1`
-    done
-
-    tst_resm TPASS "Test is finished correctly."
-    return 0
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
-
-RC=0
-do_setup
-test_body 1 || RC=`expr $RC + 1`      # Case of route command
-test_body 2 || RC=`expr $RC + 1`      # Case of ip command
-do_cleanup
-
-exit $RC
diff --git a/testcases/network/stress/route/route4-change-gw b/testcases/network/stress/route/route4-change-gw
deleted file mode 100644
index 791f98cc7..000000000
--- a/testcases/network/stress/route/route4-change-gw
+++ /dev/null
@@ -1,292 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2006                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   route4-change-gw
-#
-# Description:
-#   Verify the kernel is not crashed when the gateway of an IPv4 route is
-#   changed frequently
-#    test01 - by route command
-#    test02 - by ip command
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Mar 16 2006 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
-
-# Total number of the test case
-TST_TOTAL=2
-export TST_TOTAL
-
-# Default of the test case ID and the test case count
-TCID=route4-change-gw
-TST_COUNT=0
-export TCID
-export TST_COUNT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# The number of times where route is changed
-NS_TIMES=${NS_TIMES:-10000}
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# Network portion of the IPv4 address
-IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
-
-# Netmask of for the tested network
-IPV4_NETMASK_NUM=24
-
-# Broadcast address of the tested network
-IPV4_BROADCAST=${IPV4_NETWORK}.255
-
-# Host portion of the IPv4 address
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"1"}	# src
-RHOST_IPV4_HOST_TOP="10"	# gateway
-RHOST_IPV4_HOST_LAST=19
-
-# The destination network
-DST_NETWORK="10.10.0"	# destination network would be 10.10.0.0/24
-DST_HOST="5"
-DST_PORT="7"
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_setup
-#
-# DESCRIPTION:
-#   Make a IPv4 connectivity
-#
-# SET VALUES:
-#   rhost_ipv4addr	- IPv4 Address of the remote host
-#   lhost_ifname	- Interface name of the local host
-#   rhost_ifname	- Interface name of the remote host
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    TCID=route4-change-gw
-    TST_COUNT=0
-
-    # Get the Interface name of local host
-    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    # Get the Interface name of remote host
-    rhost_ifname=`get_ifname rhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # Initialize the interfaces of the remote host
-    initialize_if rhost ${LINK_NUM}
-
-    # Set IPv4 address to the interface of the remote host
-    rhost_part=$RHOST_IPV4_HOST_TOP
-    while [ $rhost_part -le $RHOST_IPV4_HOST_LAST ]; do
-	ret=`$LTP_RSH $RHOST '( PATH=/sbin:/usr/sbin:$PATH ; ip addr add '${IPV4_NETWORK}.${rhost_part}/${IPV4_NETMASK_NUM}' broadcast '${IPV4_NETWORK}'.255 dev '$rhost_ifname' ) > /dev/null ; echo $?'`
-	if [ $ret -ne 0 ]; then
-	    tst_resm TBROK "Failed to assign IP address to the interface at the remote host"
-	    exit $TST_TOTAL
-	fi
-	rhost_part=`expr $rhost_part + 1`
-    done
-}
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_cleanup
-#
-# DESCRIPTION:
-#   Recover the tested interfaces
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    killall -SIGHUP ns-udpsender >/dev/null 2>&1
-
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:
-#   test_body
-#
-# DESCRIPTION:
-#   main code of the test
-#
-# Arguments:
-#   $1: define the test type
-#       1 - route command case
-#       2 - ip command case
-#
-#-----------------------------------------------------------------------
-test_body()
-{
-    test_type=$1
-
-    TCID=route4-change-gw0${test_type}
-    TST_COUNT=$test_type
-
-    case $test_type in
-	1)
-	test_command="route"
-	;;
-	2)
-	test_command="ip"
-	;;
-	*)
-	tst_resm TBROK "unspecified case"
-	return 1
-	;;
-    esac
-
-    tst_resm TINFO "Verify the kernel is not crashed when the gateway of an IPv4 route is changed frequently by $test_command command in $NS_TIMES times"
-
-    # Initialize the interface of the local host
-    initialize_if lhost ${LINK_NUM}
-
-    # Assign IPv4 address to the interface of the local host
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to assign an IPv4 address at the local host"
-	return 1
-    fi
-
-    # Check the connectivity to the gateway
-    rhost_part=$RHOST_IPV4_HOST_TOP
-    check_icmpv4_connectivity $lhost_ifname ${IPV4_NETWORK}.${rhost_part}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
-	return 1
-    fi
-
-    # Set the variables regarding the destination host
-    dst_addr=${DST_NETWORK}.${DST_HOST}
-    dst_network=${DST_NETWORK}.0
-
-    # Set the first route
-    case $test_type in
-	1)
-	route add -net $dst_network netmask 255.255.255.0 gw ${IPV4_NETWORK}.${rhost_part} dev $lhost_ifname
-	;;
-	2)
-	ip route add ${dst_network}/24 via ${IPV4_NETWORK}.${rhost_part} dev $lhost_ifname
-	;;
-    esac
-
-    # Load the route with UDP traffic
-    ns-udpsender -f 4 -D $dst_addr -p $DST_PORT -b -s 1472
-    if [ $? -ne 0 ]; then
-	tst_resm TFAIL "Failed to run a UDP datagram sender"
-	return 1
-    fi
-
-    # Loop for changing the route
-    cnt=0
-    while [ $cnt -lt $NS_TIMES ]; do
-	pre_rhost_part=$rhost_part
-	rhost_part=`expr $rhost_part + 1`
-	if [ $rhost_part -gt $RHOST_IPV4_HOST_LAST ]; then
-	    rhost_part=$RHOST_IPV4_HOST_TOP
-	fi
-
-	case $test_type in
-	    1)
-	    route add -net $dst_network netmask 255.255.255.0 gw ${IPV4_NETWORK}.${rhost_part} dev $lhost_ifname
-	    route del -net $dst_network netmask 255.255.255.0 gw ${IPV4_NETWORK}.${pre_rhost_part} dev $lhost_ifname
-	    ;;
-	    2)
-	    ip route change ${dst_network}/24 via ${IPV4_NETWORK}.${rhost_part} dev $lhost_ifname
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to change the gateway to ${IPV4_NETWORK}.${rhost_part}"
-	    return 1
-	fi
-
-	# Rerun if udp datagram sender is dead
-	ps auxw | fgrep -v grep | grep ns-udpsender > /dev/null
-	if [ $? -ne 0 ]; then
-	    ns-udpsender -f 4 -D $dst_addr -p $DST_PORT -b -s 1472
-	    if [ $? -ne 0 ]; then
-		tst_resm TFAIL "Failed to run a UDP datagram sender"
-		return 1
-	    fi
-	fi
-
-	cnt=`expr $cnt + 1`
-    done
-
-    # Kill the udp datagram sender
-    killall -SIGHUP ns-udpsender >/dev/null 2>&1
-
-    tst_resm TPASS "Test is finished correctly."
-    return 0
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
-
-RC=0
-do_setup
-test_body 1 || RC=`expr $RC + 1`      # Case of route command
-test_body 2 || RC=`expr $RC + 1`      # Case of ip command
-do_cleanup
-
-exit $RC
diff --git a/testcases/network/stress/route/route6-change-dst b/testcases/network/stress/route/route6-change-dst
deleted file mode 100644
index 2aa953396..000000000
--- a/testcases/network/stress/route/route6-change-dst
+++ /dev/null
@@ -1,272 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2006                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   route6-change-dst
-#
-# Description:
-#   Verify the kernel is not crashed when the destination of an IPv6 route is
-#   changed frequently
-#    test01 - by route command
-#    test02 - by ip command
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Mar 16 2006 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
-
-# Total number of the test case
-TST_TOTAL=2
-export TST_TOTAL
-
-# Default of the test case ID and the test case count
-TCID=route6-change-dst
-TST_COUNT=0
-export TCID
-export TST_COUNT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# The number of times where route is changed
-NS_TIMES=${NS_TIMES:-10000}
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# Network portion of the IPv6 address
-IPV6_NETWORK="fec0:1:1:1"
-
-# Netmask of for the tested network
-IPV6_NETMASK_NUM=64
-
-# Host portion of the IPv6 address
-LHOST_IPV6_HOST=":2"	# src
-RHOST_IPV6_HOST=":3"	# gateway
-
-# The destination network
-DST_NETWORK_PREFIX="fd00:100:1"	# dest network would be fd00:100:1:n:::/64
-DST_HOST="5"
-DST_PORT="7"
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_setup
-#
-# DESCRIPTION:
-#   Make a IPv6 connectivity
-#
-# SET VALUES:
-#   rhost_ipv6addr	- IPv6 Address of the remote host
-#   lhost_ifname	- Interface name of the local host
-#   rhost_ifname	- Interface name of the remote host
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    TCID=route6-change-dst
-    TST_COUNT=0
-
-    # Initialize the interfaces of the remote host
-    initialize_if rhost ${LINK_NUM}
-
-    # Set IPv6 address to the interfaces
-    add_ipv6addr rhost ${LINK_NUM} ${IPV6_NETWORK} ${RHOST_IPV6_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add an IPv6 address the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # IPv6 address of the remote host (gateway)
-    rhost_ipv6addr="${IPV6_NETWORK}:${RHOST_IPV6_HOST}"
-
-    # Get the Interface name of local host
-    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    # Get the Interface name of remote host
-    rhost_ifname=`get_ifname rhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-}
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_cleanup
-#
-# DESCRIPTION:
-#   Recover the tested interfaces
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:
-#   test_body
-#
-# DESCRIPTION:
-#   main code of the test
-#
-# Arguments:
-#   $1: define the test type
-#       1 - route command case
-#       2 - ip command case
-#
-#-----------------------------------------------------------------------
-test_body()
-{
-    test_type=$1
-
-    TCID=route6-change-dst0${test_type}
-    TST_COUNT=$test_type
-
-    case $test_type in
-	1)
-	test_command="route"
-	;;
-	2)
-	test_command="ip"
-	;;
-	*)
-	tst_resm TBROK "unspecified case"
-	return 1
-	;;
-    esac
-
-    tst_resm TINFO "Verify the kernel is not crashed when the destination of an IPv6 route is changed frequently by $test_command command in $NS_TIMES times"
-
-    # Initialize the interface of the local host
-    initialize_if lhost ${LINK_NUM}
-
-    # Assign IPv6 address to the interface of the local host
-    add_ipv6addr lhost ${LINK_NUM} ${IPV6_NETWORK} ${LHOST_IPV6_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to assign an IPv6 address at the local host"
-	return 1
-    fi
-    lhost_ipv6addr="${IPV6_NETWORK}:${LHOST_IPV6_HOST}"
-
-    # Check the connectivity to the gateway
-    check_icmpv6_connectivity $lhost_ifname $rhost_ipv6addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Test Link $LINK_NUM is something wrong."
-	return 1
-    fi
-
-    # Start the loop
-    cnt=0
-    while [ $cnt -lt $NS_TIMES ]; do
-	# Define the destination IP address
-	tmp_postfix=`expr $cnt % 65535`
-	dst_network_postfix=`printf "%x" $tmp_postfix`
-	dst_addr=${DST_NETWORK_PREFIX}:${dst_network_postfix}::${DST_HOST}
-	dst_network=${DST_NETWORK_PREFIX}:${dst_network_postfix}::
-
-	# Add the route
-	case $test_type in
-	    1)
-	    route -A inet6 add ${dst_network}/64 gw $rhost_ipv6addr dev $lhost_ifname
-	    ;;
-	    2)
-	    ip -f inet6 route add ${dst_network}/64 via $rhost_ipv6addr dev $lhost_ifname
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to add the route to ${dst_network}/64"
-	    return 1
-	fi
-
-	# Load the route with UDP datagram
-	ns-udpsender -f 6 -D $dst_addr -p $DST_PORT -o -s 1452
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to run a UDP datagram sender"
-	    return 1
-	fi
-
-	# Delete the route
-	case $test_type in
-	    1)
-	    route -A inet6 del ${dst_network}/64 gw $rhost_ipv6addr dev $lhost_ifname
-	    ;;
-	    2)
-	    ip -f inet6 route del ${dst_network}/64 via $rhost_ipv6addr dev $lhost_ifname
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Cannot delete the route to ${ADDDEL_ROUTE}"
-	    return 1
-	fi
-
-	cnt=`expr $cnt + 1`
-    done
-
-    tst_resm TPASS "Test is finished correctly."
-    return 0
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
-
-RC=0
-do_setup
-test_body 1 || RC=`expr $RC + 1`      # Case of route command
-test_body 2 || RC=`expr $RC + 1`      # Case of ip command
-do_cleanup
-
-exit $RC
diff --git a/testcases/network/stress/route/route6-change-gw b/testcases/network/stress/route/route6-change-gw
deleted file mode 100644
index 05e45b907..000000000
--- a/testcases/network/stress/route/route6-change-gw
+++ /dev/null
@@ -1,292 +0,0 @@
-#!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2006                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   route6-change-gw
-#
-# Description:
-#   Verify the kernel is not crashed when the gateway of an IPv6 route is
-#   changed frequently
-#    test01 - by route command
-#    test02 - by ip command
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Mar 16 2006 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
-
-# Total number of the test case
-TST_TOTAL=2
-export TST_TOTAL
-
-# Default of the test case ID and the test case count
-TCID=route6-change-gw
-TST_COUNT=0
-export TCID
-export TST_COUNT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# The number of times where route is changed
-NS_TIMES=${NS_TIMES:-10000}
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# Network portion of the IPv6 address
-IPV6_NETWORK="fec0:1:1:1"
-
-# Netmask of for the tested network
-IPV6_NETMASK_NUM=64
-
-# Host portion of the IPv6 address
-LHOST_IPV6_HOST=":2"		# src
-RHOST_IPV6_HOST_TOP="10"	# gateway
-RHOST_IPV6_HOST_LAST="19"
-
-# The destination network
-DST_NETWORK="fd00:100:1:1"	# dest network would be fd00:100:1:1:::/64
-DST_HOST="5"
-DST_PORT="7"
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_setup
-#
-# DESCRIPTION:
-#   Make a IPv6 connectivity
-#
-# SET VALUES:
-#   rhost_ipv6addr	- IPv6 Address of the remote host
-#   lhost_ifname	- Interface name of the local host
-#   rhost_ifname	- Interface name of the remote host
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    TCID=route6-change-gw
-    TST_COUNT=0
-
-    # Get the Interface name of local host
-    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    # Get the Interface name of remote host
-    rhost_ifname=`get_ifname rhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # Initialize the interfaces of the remote host
-    initialize_if rhost ${LINK_NUM}
-
-    # Set IPv6 address to the interface of the remote host
-    rhost_part=$RHOST_IPV6_HOST_TOP
-    rhost_part_hex=`printf "%x" $rhost_part`
-    while [ $rhost_part -le $RHOST_IPV6_HOST_LAST ]; do
-	rhost_part_hex=":`printf "%x" $rhost_part`"
-	add_ipv6addr rhost ${LINK_NUM} ${IPV6_NETWORK} ${rhost_part_hex}
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to assign IP address to the interface at the remote host"
-	    exit $TST_TOTAL
-	fi
-	rhost_part=`expr $rhost_part + 1`
-    done
-}
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_cleanup
-#
-# DESCRIPTION:
-#   Recover the tested interfaces
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    killall -SIGHUP ns-udpsender >/dev/null 2>&1
-
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:
-#   test_body
-#
-# DESCRIPTION:
-#   main code of the test
-#
-# Arguments:
-#   $1: define the test type
-#       1 - route command case
-#       2 - ip command case
-#
-#-----------------------------------------------------------------------
-test_body()
-{
-    test_type=$1
-
-    TCID=route6-change-gw0${test_type}
-    TST_COUNT=$test_type
-
-    case $test_type in
-	1)
-	test_command="route"
-	;;
-	2)
-	test_command="ip"
-	;;
-	*)
-	tst_resm TBROK "unspecified case"
-	return 1
-	;;
-    esac
-
-    tst_resm TINFO "Verify the kernel is not crashed when the gateway of an IPv6 route is changed frequently by $test_command command in $NS_TIMES times"
-
-    # Initialize the interface of the local host
-    initialize_if lhost ${LINK_NUM}
-
-    # Assign IPv6 address to the interface of the local host
-    add_ipv6addr lhost ${LINK_NUM} ${IPV6_NETWORK} ${LHOST_IPV6_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to assign an IPv6 address at the local host"
-	return 1
-    fi
-
-    # Check the connectivity to the gateway
-    rhost_part=$RHOST_IPV6_HOST_TOP
-    rhost_part_hex=":`printf "%x" $rhost_part`"
-    check_icmpv6_connectivity $lhost_ifname ${IPV6_NETWORK}:${rhost_part_hex}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
-	return 1
-    fi
-
-    # Set the variables regarding the destination host
-    dst_addr=${DST_NETWORK}::${DST_HOST}
-    dst_network=${DST_NETWORK}::
-
-    # Set the first route
-    case $test_type in
-	1)
-	route -A inet6 add ${dst_network}/64 gw ${IPV6_NETWORK}:${rhost_part_hex} dev $lhost_ifname
-	;;
-	2)
-	ip -f inet6 route add ${dst_network}/64 via ${IPV6_NETWORK}:${rhost_part_hex} dev $lhost_ifname
-	;;
-    esac
-
-    # Load the route with UDP traffic
-    ns-udpsender -f 6 -D $dst_addr -p $DST_PORT -b -s 1452
-    if [ $? -ne 0 ]; then
-	tst_resm TFAIL "Failed to run a UDP datagram sender"
-	return 1
-    fi
-
-    # Loop for changing the route
-    cnt=0
-    while [ $cnt -lt $NS_TIMES ]; do
-	pre_rhost_part_hex=$rhost_part_hex
-	rhost_part=`expr $rhost_part + 1`
-	if [ $rhost_part -gt $RHOST_IPV6_HOST_LAST ]; then
-	    rhost_part=$RHOST_IPV6_HOST_TOP
-	fi
-	rhost_part_hex=":`printf "%x" $rhost_part`"
-
-	case $test_type in
-	    1)
-	    route -A inet6 add ${dst_network}/64 gw ${IPV6_NETWORK}:${rhost_part_hex} dev $lhost_ifname
-	    route -A inet6 del ${dst_network}/64 gw ${IPV6_NETWORK}:${pre_rhost_part_hex} dev $lhost_ifname
-	    ;;
-	    2)
-	    ip -f inet6 route change ${dst_network}/64 via ${IPV6_NETWORK}:${rhost_part_hex} dev $lhost_ifname
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to change the gateway to ${IPV6_NETWORK}.${rhost_part}"
-	    return 1
-	fi
-
-	# Rerun if udp datagram sender is dead
-	ps auxw | fgrep -v grep | grep ns-udpsender > /dev/null
-	if [ $? -ne 0 ]; then
-	    ns-udpsender -f 4 -D $dst_addr -p $DST_PORT -o -s 1472
-	    if [ $? -ne 0 ]; then
-		tst_resm TFAIL "Failed to run a UDP datagram sender"
-		return 1
-	    fi
-	fi
-
-	cnt=`expr $cnt + 1`
-    done
-
-    # Kill the udp datagram sender
-    killall -SIGHUP ns-udpsender >/dev/null 2>&1
-
-    tst_resm TPASS "Test is finished correctly."
-    return 0
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
-
-RC=0
-do_setup
-test_body 1 || RC=`expr $RC + 1`      # Case of route command
-test_body 2 || RC=`expr $RC + 1`      # Case of ip command
-do_cleanup
-
-exit $RC
diff --git a/travis/debian.cross-compile.aarch64.sh b/travis/debian.cross-compile.aarch64.sh
index 4b07f186f..be1e52ccf 100755
--- a/travis/debian.cross-compile.aarch64.sh
+++ b/travis/debian.cross-compile.aarch64.sh
@@ -2,6 +2,10 @@
 # Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 set -e
 
+dpkg --add-architecture arm64
+apt update
+
 apt install -y --no-install-recommends \
 	gcc-aarch64-linux-gnu \
-	libc6-dev-arm64-cross
+	libc6-dev-arm64-cross \
+	pkg-config:arm64
diff --git a/travis/debian.cross-compile.ppc64le.sh b/travis/debian.cross-compile.ppc64le.sh
index d8431bd52..340acf22d 100755
--- a/travis/debian.cross-compile.ppc64le.sh
+++ b/travis/debian.cross-compile.ppc64le.sh
@@ -2,6 +2,12 @@
 # Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 set -e
 
+dpkg --add-architecture ppc64el
+apt update
+
 apt install -y --no-install-recommends \
 	gcc-powerpc64le-linux-gnu \
-	libc6-dev-ppc64el-cross
+	libc6-dev-ppc64el-cross \
+	pkg-config:ppc64el \
+	libmnl0:ppc64el \
+	libmnl-dev:ppc64el \
diff --git a/travis/debian.i386.sh b/travis/debian.i386.sh
index 250d53b0d..c9ac3a9eb 100755
--- a/travis/debian.i386.sh
+++ b/travis/debian.i386.sh
@@ -16,4 +16,5 @@ apt install -y --no-install-recommends \
 	libkeyutils1:i386 \
 	libnuma1:i386 \
 	libssl-dev:i386 \
-	libtirpc1:i386
+	libtirpc1:i386 \
+	pkg-config:i386
diff --git a/travis/debian.minimal.sh b/travis/debian.minimal.sh
index 8e8bb6249..856b4002d 100755
--- a/travis/debian.minimal.sh
+++ b/travis/debian.minimal.sh
@@ -3,17 +3,17 @@
 set -e
 
 apt remove -y \
-    libacl1-dev \
-    libaio-dev \
-    libaio1 \
-    libcap-dev \
-    libcap2 \
-    libkeyutils-dev \
-    libkeyutils1 \
-    libmm-dev \
-    libnuma-dev \
-    libnuma1 \
-    libselinux1-dev \
-    libsepol1-dev \
-    libssl-dev \
-    libtirpc1
+	libacl1-dev \
+	libaio-dev \
+	libaio1 \
+	libcap-dev \
+	libcap2 \
+	libkeyutils-dev \
+	libkeyutils1 \
+	libmm-dev \
+	libnuma-dev \
+	libnuma1 \
+	libselinux1-dev \
+	libsepol1-dev \
+	libssl-dev \
+	libtirpc1
diff --git a/travis/debian.sh b/travis/debian.sh
index 56c8a08be..b8a345dbb 100755
--- a/travis/debian.sh
+++ b/travis/debian.sh
@@ -9,31 +9,34 @@ grep -v oldstable-updates /etc/apt/sources.list > /tmp/sources.list && mv /tmp/s
 apt update
 
 apt install -y --no-install-recommends \
-    acl-dev \
-    autoconf \
-    automake \
-    build-essential \
-    debhelper \
-    devscripts \
-    clang \
-    gcc \
-    libacl1 \
-    libacl1-dev \
-    libaio-dev \
-    libaio1 \
-    libcap-dev \
-    libcap2 \
-    libc6 \
-    libc6-dev \
-    libkeyutils-dev \
-    libkeyutils1 \
-    libmm-dev \
-    libnuma-dev \
-    libnuma1 \
-    libselinux1-dev \
-    libsepol1-dev \
-    libssl-dev \
-    linux-libc-dev \
-    lsb-release
+	acl-dev \
+	autoconf \
+	automake \
+	build-essential \
+	debhelper \
+	devscripts \
+	clang \
+	gcc \
+	libacl1 \
+	libacl1-dev \
+	libaio-dev \
+	libaio1 \
+	libcap-dev \
+	libcap2 \
+	libc6 \
+	libc6-dev \
+	libkeyutils-dev \
+	libkeyutils1 \
+	libmm-dev \
+	libmnl0 \
+	libmnl-dev \
+	libnuma-dev \
+	libnuma1 \
+	libselinux1-dev \
+	libsepol1-dev \
+	libssl-dev \
+	linux-libc-dev \
+	lsb-release \
+	pkg-config
 
 apt install libtirpc1 libtirpc3 || true
diff --git a/travis/fedora.sh b/travis/fedora.sh
index a4633333e..196336563 100755
--- a/travis/fedora.sh
+++ b/travis/fedora.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2019 Petr Vorel <pvorel@suse.cz>
 set -e
 
 yum -y install \
@@ -9,4 +9,7 @@ yum -y install \
 	clang \
 	gcc \
 	findutils \
+	libmnl \
+	libmnl-devel \
+	pkg-config \
 	redhat-lsb-core
diff --git a/travis/tumbleweed.sh b/travis/tumbleweed.sh
index c57257120..969767ca6 100755
--- a/travis/tumbleweed.sh
+++ b/travis/tumbleweed.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2019 Petr Vorel <pvorel@suse.cz>
 set -e
 
 zypper --non-interactive install --no-recommends \
@@ -14,9 +14,12 @@ zypper --non-interactive install --no-recommends \
 	libacl-devel \
 	libaio-devel \
 	libcap-devel \
+	libmnl0 \
+	libmnl-devel \
 	libnuma-devel \
 	libopenssl-devel \
 	libselinux-devel \
 	libtirpc-devel \
 	linux-glibc-devel \
-	lsb-release
+	lsb-release \
+	pkg-config
-- 
2.21.0

