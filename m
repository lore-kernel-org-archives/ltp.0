From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 Jan 2019 17:17:35 +0100
Subject: [LTP] [RFC PATCH 2/2] net/route: Rewrite route{4,
	6}-change-dst into C
In-Reply-To: <20190124161735.19609-1-pvorel@suse.cz>
References: <20190124161735.19609-1-pvorel@suse.cz>
Message-ID: <20190124161735.19609-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

using new API, cleanup

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac                                  |   1 +
 include/mk/config.mk.default                  |   3 +
 include/mk/config.mk.in                       |   2 +
 m4/ltp-libnl.m4                               |   7 +
 runtest/net_stress.route                      |   4 +-
 testcases/network/stress/route/.gitignore     |   1 +
 testcases/network/stress/route/Makefile       |   7 +-
 .../network/stress/route/route-change-dst.c   | 129 ++++++++++++++++++
 .../network/stress/route/route-change-dst.sh  |  16 +++
 travis/debian.cross-compile.aarch64.sh        |   6 +-
 travis/debian.cross-compile.ppc64le.sh        |   9 +-
 travis/debian.i386.sh                         |   3 +-
 travis/debian.sh                              |   5 +-
 travis/fedora.sh                              |   1 +
 travis/tumbleweed.sh                          |   3 +
 15 files changed, 189 insertions(+), 8 deletions(-)
 create mode 100644 m4/ltp-libnl.m4
 create mode 100644 testcases/network/stress/route/.gitignore
 create mode 100644 testcases/network/stress/route/route-change-dst.c
 create mode 100755 testcases/network/stress/route/route-change-dst.sh

diff --git a/configure.ac b/configure.ac
index caea34462..0142203ab 100644
--- a/configure.ac
+++ b/configure.ac
@@ -231,6 +231,7 @@ LTP_CHECK_TPACKET_V3
 LTP_CHECK_RLIMIT64
 LTP_DETECT_HOST_CPU
 LTP_CHECK_PERF_EVENT
+LTP_CHECK_LIBNL
 
 if test "x$with_numa" = xyes; then
 	LTP_CHECK_SYSCALL_NUMA
diff --git a/include/mk/config.mk.default b/include/mk/config.mk.default
index 0934d9453..fd945860c 100644
--- a/include/mk/config.mk.default
+++ b/include/mk/config.mk.default
@@ -43,6 +43,9 @@ YACC			:= bison -y
 #SELINUX_LIBS		:= -lselinux
 #TIRPC_CPPFLAGS		:= -I/usr/include/tirpc
 #TIRPC_LIBS		:= -ltirpc
+#LIBNL_CLI3_CFLAGS		:= -I/usr/include/libnl3
+#LIBNL_CLI3_LIBS		:= -lnl-cli-3 -lnl-genl-3 -lnl-nf-3 -lnl-route-3 -lnl-3
+
 
 prefix			:= /opt/ltp
 
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index 01f178bff..0523fcf4c 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -46,6 +46,8 @@ SELINUX_LIBS		:= @SELINUX_LIBS@
 TIRPC_CPPFLAGS		:= @TIRPC_CPPFLAGS@
 TIRPC_LIBS		:= @TIRPC_LIBS@
 KEYUTILS_LIBS		:= @KEYUTILS_LIBS@
+LIBNL_CLI3_CFLAGS		:= @LIBNL_CLI3_CFLAGS@
+LIBNL_CLI3_LIBS		:= @LIBNL_CLI3_LIBS@
 
 prefix			:= @prefix@
 
diff --git a/m4/ltp-libnl.m4 b/m4/ltp-libnl.m4
new file mode 100644
index 000000000..c3075c5ef
--- /dev/null
+++ b/m4/ltp-libnl.m4
@@ -0,0 +1,7 @@
+dnl Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+
+AC_DEFUN([LTP_CHECK_LIBNL], [
+    PKG_CHECK_MODULES([LIBNL_CLI3], [libnl-cli-3.0], [
+        AC_DEFINE([HAVE_LIBNL_CLI3], [1], [Define to 1 if you have netlink libraries and headers])
+	], [have_libnl3=no])
+])
diff --git a/runtest/net_stress.route b/runtest/net_stress.route
index 266ef0383..4fc618071 100644
--- a/runtest/net_stress.route
+++ b/runtest/net_stress.route
@@ -2,13 +2,13 @@
 # Stress test for routing table
 #
 
-route4-change-dst route4-change-dst
+route4-change-dst route-change-dst.sh
 route4-change-gw route4-change-gw
 route4-change-if route4-change-if
 route4-redirect route4-redirect
 route4-rmmod route4-rmmod
 
-route6-change-dst route6-change-dst
+route6-change-dst route-change-dst.sh -6
 route6-change-gw route6-change-gw
 route6-change-if route6-change-if
 route6-redirect route6-redirect
diff --git a/testcases/network/stress/route/.gitignore b/testcases/network/stress/route/.gitignore
new file mode 100644
index 000000000..c85ab076c
--- /dev/null
+++ b/testcases/network/stress/route/.gitignore
@@ -0,0 +1 @@
+/route-change-dst
diff --git a/testcases/network/stress/route/Makefile b/testcases/network/stress/route/Makefile
index 2e5eaa2f2..bcee6106b 100644
--- a/testcases/network/stress/route/Makefile
+++ b/testcases/network/stress/route/Makefile
@@ -22,8 +22,11 @@
 
 top_srcdir		?= ../../../..
 
-include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/testcases.mk
 
-INSTALL_TARGETS		:= route*
+INSTALL_TARGETS		+= route[4-6]-*
+
+route-change-dst: CFLAGS +=  $(LIBNL_CLI3_CFLAGS)
+route-change-dst: LDLIBS += $(LIBNL_CLI3_LIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/stress/route/route-change-dst.c b/testcases/network/stress/route/route-change-dst.c
new file mode 100644
index 000000000..33052d973
--- /dev/null
+++ b/testcases/network/stress/route/route-change-dst.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+ */
+
+#include "config.h"
+#include "tst_test.h"
+
+#ifdef HAVE_LIBNL_CLI3
+
+#include <string.h>
+
+#include <netlink/cli/utils.h>
+#include <netlink/cli/route.h>
+#include <netlink/cli/link.h>
+#include <linux/rtnetlink.h>
+
+#include "tst_net.h"
+#include "tst_safe_stdio.h"
+
+static struct nl_sock *sock;
+static struct rtnl_route *route;
+static struct nl_cache *link_cache;
+
+static char *carg, *dst, *iface, *ipv6_arg, *nexthop;
+static int family = AF_INET;
+static int num_loops = 10000;
+
+static void setup(void)
+{
+	if (tst_parse_int(carg, &num_loops, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid number of loops '%s'", carg);
+
+	if (ipv6_arg)
+		family = AF_INET6;
+
+	if (!iface)
+		tst_brk(TBROK, "Missing iface, specify it with -d");
+
+	SAFE_ASPRINTF(&nexthop, "dev=%s", iface);
+	sock = nl_cli_alloc_socket();
+	nl_cli_connect(sock, NETLINK_ROUTE);
+	link_cache = nl_cli_link_alloc_cache(sock);
+	route = nl_cli_route_alloc();
+	nl_cli_route_parse_nexthop(route, nexthop, link_cache);
+}
+
+static char *tst_ipaddr_un(int ai_family, unsigned int net, unsigned int host)
+{
+	char *addr, *env, *unused;
+	unsigned int max, prefix;
+
+	if (ai_family != AF_INET && ai_family != AF_INET6)
+		tst_brk(TCONF, "ai_family must be AF_INET or AF_INET6 (%d)", ai_family);
+
+	if (ai_family == AF_INET) {
+		env = "IPV4_NET16_UNUSED";
+		max = 255;
+		prefix = 24;
+	} else {
+		env = "IPV6_NET32_UNUSED";
+		max = 65535;
+		prefix = 64;
+	}
+
+	unused = getenv(env);
+
+	if (!unused)
+		tst_brk(TCONF, "%s not set (set it with tst_net.sh)", env);
+
+	net %= max;
+	host %= max;
+
+	if (ai_family == AF_INET6) {
+		if (host > 0 && net > 0)
+			SAFE_ASPRINTF(&addr, "%s:%x::%x/%d", unused, net, host, prefix);
+		else if (host > 0 && net == 0)
+			SAFE_ASPRINTF(&addr, "%s::%x/%d", unused, host, prefix);
+		else if (net > 0 && host == 0)
+			SAFE_ASPRINTF(&addr, "%s:%x::/%d", unused, net, prefix);
+		else
+			SAFE_ASPRINTF(&addr, "%s::/%d", unused, prefix);
+	} else {
+		SAFE_ASPRINTF(&addr, "%s.%d.%d/%d", unused, net, host, prefix);
+	}
+
+	return strdup(addr);
+}
+
+static void run(void)
+{
+	int err, i;
+
+	tst_res(TINFO, "Adding and deleting route with different destination");
+	for (i = 0; i < num_loops; i++) {
+		dst = tst_ipaddr_un(family, i, 0);
+
+		nl_cli_route_parse_dst(route, dst);
+		if ((err = rtnl_route_add(sock, route, NLM_F_EXCL)) < 0) {
+			tst_res(TFAIL, "Unable to add route to %s via %s: %s",
+				dst, nexthop, nl_geterror(err));
+			return;
+		}
+
+		if ((err = rtnl_route_delete(sock, route, 0)) < 0) {
+			tst_res(TFAIL, "Unable to delete route to %s via %s: %s",
+				dst, nexthop, nl_geterror(err));
+			return;
+		}
+	}
+
+	tst_res(TPASS, "Routes added and deleted");
+}
+
+static struct tst_option options[] = {
+	{"6", &ipv6_arg, "-6       Use IPv6 (default is IPv4)"},
+	{"c:", &carg, "-c x     Number of loops"},
+	{"d:", &iface, "-d IFACE Interface to work on"},
+	{NULL, NULL, NULL}
+};
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+	.setup = setup,
+	.options = options,
+};
+#else
+	TST_TEST_TCONF("netlink libraries and headers are required");
+#endif /* HAVE_LIBNL_CLI3 */
diff --git a/testcases/network/stress/route/route-change-dst.sh b/testcases/network/stress/route/route-change-dst.sh
new file mode 100755
index 000000000..27901db74
--- /dev/null
+++ b/testcases/network/stress/route/route-change-dst.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+
+TST_TESTFUNC="do_test"
+. tst_net.sh
+
+do_test()
+{
+	local ip_flag
+
+	[ "$TST_IPV6" ] && ip_flag="-6"
+	EXPECT_PASS route-change-dst -d $(tst_iface) -c $NS_TIMES $ip_flag
+}
+
+tst_run
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
index d8431bd52..0584225a2 100755
--- a/travis/debian.cross-compile.ppc64le.sh
+++ b/travis/debian.cross-compile.ppc64le.sh
@@ -2,6 +2,13 @@
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
+	libnl-3-dev:ppc64el \
+	libnl-cli-3-dev:ppc64el \
+	libnl-cli-3-200:ppc64el \
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
diff --git a/travis/debian.sh b/travis/debian.sh
index 3918a915f..db27a9c35 100755
--- a/travis/debian.sh
+++ b/travis/debian.sh
@@ -24,12 +24,15 @@ apt install -y --no-install-recommends \
     libkeyutils-dev \
     libkeyutils1 \
     libmm-dev \
+    libnl-cli-3-dev \
+    libnl-cli-3-200 \
     libnuma-dev \
     libnuma1 \
     libselinux1-dev \
     libsepol1-dev \
     libssl-dev \
     linux-libc-dev \
-    lsb-release
+    lsb-release \
+    pkg-config
 
 apt install libtirpc1 libtirpc3 || true
diff --git a/travis/fedora.sh b/travis/fedora.sh
index a4633333e..7d84b02b6 100755
--- a/travis/fedora.sh
+++ b/travis/fedora.sh
@@ -6,6 +6,7 @@ yum -y install \
 	autoconf \
 	automake \
 	make \
+	pkg-config \
 	clang \
 	gcc \
 	findutils \
diff --git a/travis/tumbleweed.sh b/travis/tumbleweed.sh
index 7fe40d142..44626d278 100755
--- a/travis/tumbleweed.sh
+++ b/travis/tumbleweed.sh
@@ -8,11 +8,14 @@ zypper --non-interactive install --no-recommends \
 	clang \
 	gcc \
 	make \
+	pkg-config \
 	kernel-default-devel \
 	keyutils-devel \
 	libacl-devel \
 	libaio-devel \
 	libcap-devel \
+	libnl3-devel \
+	libnl3-200 \
 	libnuma-devel \
 	libopenssl-devel \
 	libselinux-devel \
-- 
2.19.2

