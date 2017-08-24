From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 25 Aug 2017 01:44:35 +0200
Subject: [LTP] [RFC PATCH v9 6/7] network: Add tools for setup IP related
	environment variables
In-Reply-To: <20170824234436.18145-1-pvorel@suse.cz>
References: <20170824234436.18145-1-pvorel@suse.cz>
Message-ID: <20170824234436.18145-7-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

New tools:
* tst_net_ip_prefix
Strip prefix from IP address and save both
If no prefix found sets default prefix.

* tst_net_iface_prefix
tst_net_iface_prefix reads prefix and interface from rtnetlink.

* tst_net_vars takes input of local and remote address and setup most of
test link (IP related) environment variables.

NOTABLE CHANGES IN ENVIRONMENT VARIABLES:
Network variables are defined for both local and remote:
IPV4_NETWORK was replaced by IPV4_LNETWORK and IPV4_RNETWORK
IPV6_NETWORK was replaced by IPV6_LNETWORK and IPV6_RNETWORK

NEW VARIABLES:
IPV4_LHOST, IPV4_RHOST, IPV4_LNETMASK, IPV4_RNETMASK, IPV4_LPREFIX, IPV4_RPREFIX,
IPV6_LHOST, IPV6_RHOST, IPV6_LNETMASK, IPV6_RNETMASK, IPV6_LPREFIX, IPV6_RPREFIX,

For full list of environment variables which tools setup run:
tst_net_ip_prefix -h
tst_net_iface_prefix -h
tst_net_vars -h

Thanks a lot to Alexey Kodanev who reviewed many versions of this patch
and give feedback and pointed out errors, as well as to Cyril Hrubis who
reviewed orignal version of tst_net_vars.c.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_net.h                    | 153 +++++++++
 testcases/lib/.gitignore             |   3 +
 testcases/lib/Makefile               |   2 +-
 testcases/lib/tst_net_iface_prefix.c | 180 ++++++++++
 testcases/lib/tst_net_ip_prefix.c    | 123 +++++++
 testcases/lib/tst_net_vars.c         | 645 +++++++++++++++++++++++++++++++++++
 6 files changed, 1105 insertions(+), 1 deletion(-)
 create mode 100644 include/tst_net.h
 create mode 100644 testcases/lib/tst_net_iface_prefix.c
 create mode 100644 testcases/lib/tst_net_ip_prefix.c
 create mode 100644 testcases/lib/tst_net_vars.c

diff --git a/include/tst_net.h b/include/tst_net.h
new file mode 100644
index 000000000..cb97b7b61
--- /dev/null
+++ b/include/tst_net.h
@@ -0,0 +1,153 @@
+/*
+ * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <arpa/inet.h>
+#include <errno.h>
+
+#define MAX_IPV4_PREFIX 32
+#define MAX_IPV6_PREFIX 128
+
+#define tst_res_comment(...) { \
+	fprintf(stderr, "# "); \
+	tst_res(__VA_ARGS__); } \
+
+
+#define tst_brk_comment(...) { \
+	fprintf(stderr, "# "); \
+	tst_brk(TCONF, __VA_ARGS__); } \
+
+static inline void print_svar(const char *name, const char *val)
+{
+	if (name && val)
+		printf("export %s=\"%s\"\n", name, val);
+}
+
+static inline void print_svar_change(const char *name, const char *val)
+{
+	if (name && val)
+		printf("export %s=\"${%s:-%s}\"\n", name, name, val);
+}
+
+/*
+ * Function bit_count is from ipcalc project, ipcalc.c.
+ */
+static int bit_count(uint32_t i)
+{
+	int c = 0;
+	unsigned int seen_one = 0;
+
+	while (i > 0) {
+		if (i & 1) {
+			seen_one = 1;
+			c++;
+		} else {
+			if (seen_one)
+				return -1;
+		}
+		i >>= 1;
+	}
+
+	return c;
+}
+
+/*
+ * Function mask2prefix is from ipcalc project, ipcalc.c.
+ */
+static int mask2prefix(struct in_addr mask)
+{
+	return bit_count(ntohl(mask.s_addr));
+}
+
+/*
+ * Function ipv4_mask_to_int is from ipcalc project, ipcalc.c.
+ */
+static int ipv4_mask_to_int(const char *prefix)
+{
+	int ret;
+	struct in_addr in;
+
+	ret = inet_pton(AF_INET, prefix, &in);
+	if (ret == 0)
+		return -1;
+
+	return mask2prefix(in);
+}
+
+/*
+ * Function safe_atoi is from ipcalc project, ipcalc.c.
+ */
+static int safe_atoi(const char *s, int *ret_i)
+{
+	char *x = NULL;
+	long l;
+
+	errno = 0;
+	l = strtol(s, &x, 0);
+
+	if (!x || x == s || *x || errno)
+		return errno > 0 ? -errno : -EINVAL;
+
+	if ((long)(int)l != l)
+		return -ERANGE;
+
+	*ret_i = (int)l;
+
+	return 0;
+}
+
+/*
+ * Function get_prefix use code from ipcalc project, str_to_prefix/ipcalc.c.
+ */
+static int get_prefix(const char *ip_str, int is_ipv6)
+{
+	char *prefix_str = NULL;
+	int prefix = -1, r;
+
+	prefix_str = strchr(ip_str, '/');
+	if (!prefix_str)
+		return -1;
+
+	*(prefix_str++) = '\0';
+
+	if (!is_ipv6 && strchr(prefix_str, '.'))
+		prefix = ipv4_mask_to_int(prefix_str);
+	else {
+		r = safe_atoi(prefix_str, &prefix);
+		if (r != 0)
+			tst_brk_comment("conversion error: '%s' is not integer",
+					prefix_str);
+	}
+
+	if (prefix < 0 || ((is_ipv6 && prefix > MAX_IPV6_PREFIX) ||
+		(!is_ipv6 && prefix > MAX_IPV4_PREFIX)))
+		tst_brk_comment("bad %s prefix: %s", is_ipv6 ?  "IPv6" : "IPv4",
+				prefix_str);
+
+	return prefix;
+}
+
+static void get_in_addr(const char *ip_str, struct in_addr *ip)
+{
+	if (inet_pton(AF_INET, ip_str, ip) <= 0)
+		tst_brk_comment("bad IPv4 address: '%s'", ip_str);
+}
+
+static void get_in6_addr(const char *ip_str, struct in6_addr *ip6)
+{
+	if (inet_pton(AF_INET6, ip_str, ip6) <= 0)
+		tst_brk_comment("bad IPv6 address: '%s'", ip_str);
+}
diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index 522889bed..f36ed99fa 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -4,3 +4,6 @@
 /tst_rod
 /tst_kvcmp
 /tst_device
+/tst_net_iface_prefix
+/tst_net_ip_prefix
+/tst_net_vars
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index 1127a59fe..398150ae0 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -27,6 +27,6 @@ include $(top_srcdir)/include/mk/testcases.mk
 INSTALL_TARGETS		:= *.sh
 
 MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
-			   tst_device
+			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_net_iface_prefix.c b/testcases/lib/tst_net_iface_prefix.c
new file mode 100644
index 000000000..c5cc61a0b
--- /dev/null
+++ b/testcases/lib/tst_net_iface_prefix.c
@@ -0,0 +1,180 @@
+/*
+ * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/rtnetlink.h>
+#include <net/if.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+#include "tst_net.h"
+
+typedef struct data {
+	char *ifname;
+	int prefix;
+} data;
+
+static data vars;
+
+static void usage(const char *cmd)
+{
+	fprintf(stderr, "USAGE:\n"
+		"%s IPV4_LHOST/IPV4_LPREFIX\n"
+		"%s -r IPV4_RHOST/IPV4_RPREFIX\n"
+		"%s IPV6_LHOST/IPV6_LPREFIX\n"
+		"%s -r IPV6_RHOST/IPV6_RPREFIX\n\n"
+		"%s IPV4_LHOST\n"
+		"%s -r IPV4_RHOST\n\n"
+		"%s IPV6_LHOST\n"
+		"%s -r IPV6_RHOST\n\n"
+		"%s -h\n\n"
+		"Set prefix and interface name for given IP.\n"
+		"Tries to find prefix and interface from kernel exported info (rtnetlink).\n\n"
+		"If prefix is not provided, is tried to be detected from rtnetlink data for local IP address, which is used for remote prefix as well. If is not found use default values.\n"
+		"EXPORTED VARIABLES:\n"
+		"Export one of following variables:\n"
+		"Export one of following variables:\n"
+		"IPV4_LPREFIX: IPv4 prefix for IPV4_LNETWORK\n"
+		"IPV4_RPREFIX: IPv4 prefix for IPV4_RNETWORK\n"
+		"IPV6_LPREFIX: IPv6 prefix for IPV6_LNETWORK\n"
+		"IPV6_RPREFIX: IPv6 prefix for IPV6_RNETWORK\n"
+		"Export one of following variables (if found):\n"
+		"LHOST_IFACES: iface name of the local host (*)\n"
+		"RHOST_IFACES: iface name of the remote host (*)\n\n"
+		"(*): respect user settings\n"
+		"Iface (LHOST_IFACES, RHOST_IFACES) as user might want to use more ifaces.\n\n"
+		"PARAMS:\n"
+		"-h this help\n"
+		"-r export remote environment variables\n",
+		cmd, cmd, cmd, cmd, cmd, cmd, cmd, cmd, cmd);
+}
+
+static int read_iface_prefix(const char *ip_str, int is_ipv6)
+{
+	uint8_t family = is_ipv6 ? AF_INET6 : AF_INET;
+
+	char buf[16384];
+	int len;
+
+	struct {
+		struct nlmsghdr nlhdr;
+		struct ifaddrmsg addrmsg;
+	} msg;
+
+	struct nlmsghdr *retmsg;
+
+	int sock = SAFE_SOCKET(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+
+	memset(&msg, 0, sizeof(msg));
+	msg.nlhdr.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifaddrmsg));
+	msg.nlhdr.nlmsg_flags = NLM_F_REQUEST | NLM_F_ROOT;
+	msg.nlhdr.nlmsg_type = RTM_GETADDR;
+	msg.addrmsg.ifa_family = family;
+
+	SAFE_SEND(1, sock, &msg, msg.nlhdr.nlmsg_len, 0);
+	len = recv(sock, buf, sizeof(buf), 0);
+	retmsg = (struct nlmsghdr *)buf;
+
+	while NLMSG_OK(retmsg, len) {
+		char ifname[IFNAMSIZ];
+		struct ifaddrmsg *retaddr;
+		struct rtattr *retrta;
+		char pradd[128];
+		int attlen;
+
+		retaddr = (struct ifaddrmsg *)NLMSG_DATA(retmsg);
+		retrta = (struct rtattr *)IFA_RTA(retaddr);
+		attlen = IFA_PAYLOAD(retmsg);
+
+		while RTA_OK(retrta, attlen) {
+			if (retrta->rta_type == IFA_ADDRESS) {
+				inet_ntop(family, RTA_DATA(retrta), pradd,
+					  sizeof(pradd));
+
+				if_indextoname(retaddr->ifa_index, ifname);
+
+				if (!strcmp(pradd, ip_str)) {
+					vars.prefix = retaddr->ifa_prefixlen;
+					vars.ifname = strdup(ifname);
+					return 0;
+				}
+			}
+			retrta = RTA_NEXT(retrta, attlen);
+		}
+		retmsg = NLMSG_NEXT(retmsg, len);
+	}
+
+	return -1;
+}
+
+static void print_ivar(const char *name, unsigned int val)
+{
+	if (name)
+		printf("export %s=%d\n", name, val);
+}
+
+int main(int argc, char *argv[])
+{
+	char *ip_str = NULL, *prefix_str = NULL;
+	int is_ipv6, is_rhost = 0;
+	struct in_addr ip;
+	struct in6_addr ip6;
+
+	int is_usage = argc > 1 && (!strcmp(argv[1], "-h") ||
+		!strcmp(argv[1], "--help"));
+	if (argc < 2 || is_usage) {
+		usage(argv[0]);
+		exit(is_usage ? EXIT_SUCCESS : EXIT_FAILURE);
+	}
+	if (!strcmp(argv[1], "-r"))
+		is_rhost = 1;
+
+	ip_str = argv[is_rhost ? 2 : 1];
+	is_ipv6 = !!strchr(ip_str, ':');
+
+	prefix_str = strchr(ip_str, '/');
+	if (prefix_str) {
+		vars.prefix = get_prefix(ip_str, is_ipv6);
+		tst_res_comment(TINFO,
+			"IP address '%s' contains prefix %d, using it and don't search for iface.\n",
+			ip_str, vars.prefix);
+	} else if (read_iface_prefix(ip_str, is_ipv6)) {
+		tst_res_comment(TINFO,
+			"prefix and interface not found for '%s'.\n", ip_str);
+		exit(EXIT_SUCCESS);
+	}
+
+	/* checks for validity of IP string */
+	if (is_ipv6)
+		get_in6_addr(ip_str, &ip6);
+	else
+		get_in_addr(ip_str, &ip);
+
+	if (is_ipv6) {
+		print_svar_change("LHOST_IFACES", vars.ifname);
+		print_ivar(is_rhost ? "IPV6_RPREFIX" : "IPV6_LPREFIX",
+			vars.prefix);
+	} else {
+		print_svar_change("RHOST_IFACES", vars.ifname);
+		print_ivar(is_rhost ? "IPV4_RPREFIX" : "IPV4_LPREFIX",
+			vars.prefix);
+	}
+
+	exit(EXIT_SUCCESS);
+}
diff --git a/testcases/lib/tst_net_ip_prefix.c b/testcases/lib/tst_net_ip_prefix.c
new file mode 100644
index 000000000..6654f75a9
--- /dev/null
+++ b/testcases/lib/tst_net_ip_prefix.c
@@ -0,0 +1,123 @@
+/*
+ * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/rtnetlink.h>
+#include <net/if.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+#include "tst_net.h"
+
+#define DEFAULT_IPV4_PREFIX 24
+#define DEFAULT_IPV6_PREFIX 64
+
+typedef struct data {
+	int prefix;
+} data;
+
+static data vars;
+
+static void usage(const char *cmd)
+{
+	fprintf(stderr, "USAGE:\n"
+		"%s IPV4_LHOST/IPV4_LPREFIX\n"
+		"%s -r IPV4_RHOST/IPV4_RPREFIX\n"
+		"%s IPV6_LHOST/IPV6_LPREFIX\n"
+		"%s -r IPV6_RHOST/IPV6_RPREFIX\n\n"
+		"%s IPV4_LHOST\n"
+		"%s -r IPV4_RHOST\n\n"
+		"%s IPV6_LHOST\n"
+		"%s -r IPV6_RHOST\n\n"
+		"%s -h\n\n"
+		"Set IP without prefix and prefix for given IP.\n"
+		"If prefix is not provided, is tried to be detected from rtnetlink data for local IP address, which is used for remote prefix as well. If is not found use default values.\n"
+		"EXPORTED VARIABLES:\n"
+		"Export one of following variables:\n"
+		"IPV4_LHOST: IPv4 address of the local host (without /prefix)\n"
+		"IPV4_RHOST: IPv4 address of the remote host (without /prefix)\n"
+		"IPV6_LHOST: IPv6 address of the local host (without /prefix)\n"
+		"IPV6_RHOST: IPv6 address of the remote host (without /prefix)\n"
+		"Export one of following variables:\n"
+		"IPV4_LPREFIX: IPv4 prefix for IPV4_LNETWORK\n"
+		"IPV4_RPREFIX: IPv4 prefix for IPV4_RNETWORK\n"
+		"IPV6_LPREFIX: IPv6 prefix for IPV6_LNETWORK\n"
+		"IPV6_RPREFIX: IPv6 prefix for IPV6_RNETWORK\n"
+		"Export one of following variables (if found):\n"
+		"Default IPv4 prefix: %d.\n"
+		"Default IPv6 prefix: %d.\n\n"
+		"PARAMS:\n"
+		"-h this help\n"
+		"-r export remote environment variables\n",
+		cmd, cmd, cmd, cmd, cmd, cmd, cmd, cmd, cmd,
+		DEFAULT_IPV4_PREFIX, DEFAULT_IPV6_PREFIX);
+}
+
+static void print_ivar(const char *name, unsigned int val)
+{
+	if (name)
+		printf("export %s=%d\n", name, val);
+}
+
+int main(int argc, char *argv[])
+{
+	char *ip_str = NULL, *prefix_str = NULL;
+	int is_ipv6, is_rhost = 0;
+	struct in_addr ip;
+	struct in6_addr ip6;
+
+	int is_usage = argc > 1 && (!strcmp(argv[1], "-h") ||
+		!strcmp(argv[1], "--help"));
+	if (argc < 2 || is_usage) {
+		usage(argv[0]);
+		exit(is_usage ? EXIT_SUCCESS : EXIT_FAILURE);
+	}
+	if (!strcmp(argv[1], "-r"))
+		is_rhost = 1;
+
+	ip_str = argv[is_rhost ? 2 : 1];
+	is_ipv6 = !!strchr(ip_str, ':');
+
+	prefix_str = strchr(ip_str, '/');
+
+
+	if (prefix_str)
+		vars.prefix = get_prefix(ip_str, is_ipv6);
+	else
+		vars.prefix = is_ipv6 ? DEFAULT_IPV6_PREFIX :
+			DEFAULT_IPV4_PREFIX;
+
+	/* checks for validity of IP string */
+	if (is_ipv6)
+		get_in6_addr(ip_str, &ip6);
+	else
+		get_in_addr(ip_str, &ip);
+
+	if (is_ipv6) {
+		print_ivar(is_rhost ? "IPV6_RPREFIX" : "IPV6_LPREFIX",
+			vars.prefix);
+		print_svar(is_rhost ? "IPV6_RHOST" : "IPV6_LHOST", ip_str);
+	} else {
+		print_ivar(is_rhost ? "IPV4_RPREFIX" : "IPV4_LPREFIX",
+			vars.prefix);
+		print_svar(is_rhost ? "IPV4_RHOST" : "IPV4_LHOST", ip_str);
+	}
+
+	exit(EXIT_SUCCESS);
+}
diff --git a/testcases/lib/tst_net_vars.c b/testcases/lib/tst_net_vars.c
new file mode 100644
index 000000000..ddac295b1
--- /dev/null
+++ b/testcases/lib/tst_net_vars.c
@@ -0,0 +1,645 @@
+/*
+ * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+ * Copyright (c) 1997-2015 Red Hat, Inc. All rights reserved.
+ * Copyright (c) 2011-2013 Rich Felker, et al.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <arpa/inet.h>
+#include <arpa/nameser.h>
+#include <assert.h>
+#include <errno.h>
+#include <linux/rtnetlink.h>
+#include <net/if.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <stdarg.h>
+
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+#include "tst_net.h"
+
+#define BASE_IPV4_PREFIX 8
+#define BASE_IPV6_PREFIX 16
+
+#define MAX_IPV4_PREFIX 32
+#define MAX_IPV6_PREFIX 128
+
+#define DEFAULT_IPV4_UNUSED_PART1 10
+#define DEFAULT_IPV6_UNUSED_PART1 0xfd
+
+#define DEFAULT_IPV4_UNUSED_PART2 23
+#define DEFAULT_IPV6_UNUSED_PART2 0x23
+
+typedef struct ltp_net_variables {
+	char *ipv4_lbroadcast;
+	char *ipv4_rbroadcast;
+	char *ipv4_lnetmask;
+	char *ipv4_rnetmask;
+	char *ipv4_lnetwork;
+	char *ipv4_rnetwork;
+	char *lhost_ipv4_host;
+	char *rhost_ipv4_host;
+	char *ipv6_lnetmask;
+	char *ipv6_rnetmask;
+	char *ipv6_lnetwork;
+	char *ipv6_rnetwork;
+	char *lhost_ipv6_host;
+	char *rhost_ipv6_host;
+	char *ipv4_net16_unused;
+	char *ipv6_net32_unused;
+} ltp_net_variables;
+
+
+static ltp_net_variables vars;
+
+static void usage(const char *cmd)
+{
+	fprintf(stderr, "USAGE:\n"
+		"%s IPV4_LHOST/IPV4_LPREFIX IPV4_RHOST/IPV4_RPREFIX\n"
+		"%s IPV6_LHOST/IPV6_LPREFIX IPV6_RHOST/IPV6_RPREFIX\n\n"
+		"%s IPV4_LHOST IPV4_RHOST\n"
+		"%s IPV6_LHOST IPV6_RHOST\n"
+		"%s -h\n\n"
+		"IP addresses must be different\n"
+		"Exported variables:\n"
+		"IPV4_LBROADCAST: IPv4 broadcast of the local host\n"
+		"IPV4_RBROADCAST: IPv4 broadcast of the remote host\n"
+		"IPV4_LNETMASK: IPv4 netmask of the local host\n"
+		"IPV4_RNETMASK: IPv4 netmask of the remote host\n"
+		"IPV4_LNETWORK: IPv4 network part of IPV4_LHOST\n"
+		"IPV4_RNETWORK: IPv4 network part of IPV4_RHOST\n"
+		"LHOST_IPV4_HOST IPv4 host part of IPV4_LHOST\n"
+		"RHOST_IPV4_HOST IPv4 host part of IPV4_RHOST\n"
+		"IPV4_NET16_UNUSED: IPv4 16 bit unused subnet\n"
+		"IPV6_LNETMASK: IPv6 netmask of the local host\n"
+		"IPV6_RNETMASK: IPv6 netmask of the remote host (*)\n"
+		"IPV6_LNETWORK: IPv6 network part of IPV6_LHOST\n"
+		"IPV6_RNETWORK: IPv6 network part of IPV6_LHOST\n"
+		"LHOST_IPV6_HOST: IPv6 unique part of IPV6_LHOST\n"
+		"RHOST_IPV6_HOST: IPv6 unique part of IPV6_RHOST\n"
+		"IPV6_NET32_UNUSED: IPv6 32 bit unused subnet\n"
+		"(*): respect user settings:\n"
+		"NOTE: Prefixes, ifaces and lhosts are expected to be set by tst_net_iface_prefix.\n"
+		"OPTIONS:\n"
+		"-h this help\n",
+		cmd, cmd, cmd, cmd, cmd);
+}
+
+/*
+ * Function prefix2mask is from ipcalc project, ipcalc.c.
+ */
+static struct in_addr prefix2mask(unsigned int prefix)
+{
+	struct in_addr mask;
+
+	memset(&mask, 0x0, sizeof(mask));
+
+	if (prefix)
+		mask.s_addr = htonl(~((1 << (32 - prefix)) - 1));
+	else
+		mask.s_addr = htonl(0);
+
+	return mask;
+}
+
+/*
+ * Function calc_network is based on ipcalc project,
+ * calc_network/ipcalc.c.
+ */
+static struct in_addr calc_network(const struct in_addr *ip,
+	struct in_addr *mask)
+{
+	struct in_addr network;
+
+	memset(&network, 0, sizeof(network));
+
+	network.s_addr = ip->s_addr & mask->s_addr;
+	return network;
+}
+
+static int is_in_subnet_ipv4(const struct in_addr *network,
+	const struct in_addr *mask, const struct in_addr *ip)
+{
+	return (ip->s_addr & mask->s_addr) ==
+		(network->s_addr & mask->s_addr);
+}
+
+static int is_in_subnet_ipv6(const struct in6_addr *network,
+	const struct in6_addr *mask, const struct in6_addr *ip6)
+{
+	unsigned int i;
+
+	for (i = 0; i < sizeof(struct in6_addr) / sizeof(int); i++) {
+		if (((((int *) ip6)[i] & ((int *) mask)[i])) !=
+			(((int *) network)[i] & ((int *) mask)[i]))
+			return 0;
+	}
+	return 1;
+}
+
+/*
+ * Function get_ipv4_netmask uses code from calc_network, which is from
+ * ipcalc project, ipcalc.c.
+ */
+static char *get_ipv4_netmask(unsigned int prefix)
+{
+	char buf[INET_ADDRSTRLEN + 1];
+	struct in_addr mask = prefix2mask(prefix);
+
+	if (prefix > MAX_IPV4_PREFIX)
+		return NULL;
+
+	if (!inet_ntop(AF_INET, &mask, buf, sizeof(buf)))
+		tst_brk_comment("error calculating IPv4 address");
+
+	return strdup(buf);
+}
+
+/*
+ * Function get_ipv4_netmask uses code from ipv6_prefix_to_mask and
+ * ipv6_mask_to_str, which are from ipcalc project, ipcalc.c.
+ */
+static char *get_ipv6_netmask(unsigned int prefix)
+{
+	struct in6_addr in6;
+	char buf[128];
+	int i, j;
+
+	if (prefix > MAX_IPV6_PREFIX)
+		return NULL;
+
+	memset(&in6, 0x0, sizeof(in6));
+	for (i = prefix, j = 0; i > 0; i -= 8, j++) {
+		if (i >= 8)
+			in6.s6_addr[j] = 0xff;
+		else
+			in6.s6_addr[j] = (unsigned long)(0xffU << (8 - i));
+	}
+
+	if (!inet_ntop(AF_INET6, &in6, buf, sizeof(buf)))
+		tst_brk_comment("error calculating IPv6 address");
+
+	return strdup(buf);
+}
+
+/*
+ * Function get_ipv4_broadcast uses code from calc_broadcast, which is from
+ * ipcalc project, ipcalc.c.
+ */
+static char *get_ipv4_broadcast(struct in_addr ip, unsigned int prefix)
+{
+	struct in_addr mask = prefix2mask(prefix);
+	struct in_addr broadcast;
+	char buf[INET_ADDRSTRLEN + 1];
+
+	memset(&broadcast, 0, sizeof(broadcast));
+	broadcast.s_addr = (ip.s_addr & mask.s_addr) | ~mask.s_addr;
+
+	if (!inet_ntop(AF_INET, &broadcast, buf, sizeof(buf)))
+		tst_brk_comment("error calculating IPv4 address");
+
+	return strdup(buf);
+}
+
+/*
+ * For unused network we use
+ * DEFAULT_IPV4_UNUSED_PART1:DEFAULT_IPV4_UNUSED_PART2 or
+ * {DEFAULT_IPV4_UNUSED_PART1}.XY, when there is a collision with IP.
+ */
+static char *get_ipv4_net16_unused(const struct in_addr *ip,
+	unsigned int prefix)
+{
+	struct in_addr mask, network;
+	char buf[128], net_unused[128];
+
+	mask = prefix2mask(prefix);
+	network = calc_network(ip, &mask);
+
+	sprintf(net_unused, "%d.%d", DEFAULT_IPV4_UNUSED_PART1,
+			DEFAULT_IPV4_UNUSED_PART2);
+	sprintf(buf, "%s.0.0", net_unused);
+
+	get_in_addr(buf, &network);
+
+	if (!is_in_subnet_ipv4(ip, &mask, &network))
+		return strdup(net_unused);
+
+	srand(time(NULL));
+
+	/* try to randomize second group */
+	sprintf(net_unused, "%d.%d", DEFAULT_IPV4_UNUSED_PART1,
+		(rand() % 128) + (((ip->s_addr >> 8) & 0xff) < 128 ? 128 : 0));
+	sprintf(buf, "%s.0.0", net_unused);
+
+	get_in_addr(buf, &network);
+
+	if (!is_in_subnet_ipv4(ip, &mask, &network))
+		return strdup(net_unused);
+
+	/* try to randomize first group */
+	sprintf(net_unused, "%d.%d", (rand() % 128) + (((ip->s_addr) & 0xff)
+			< 128 ? 128 : 0), DEFAULT_IPV4_UNUSED_PART2);
+	sprintf(buf, "%s.0.0", net_unused);
+
+	get_in_addr(buf, &network);
+
+	if (!is_in_subnet_ipv4(ip, &mask, &network))
+		return strdup(net_unused);
+
+	return NULL;
+}
+
+/*
+ * Function get_ipv6_net32_unused is inspired by ipcalc project,
+ * get_ipv6_info/ipcalc.c.
+ *
+ * For unused network we use DEFAULT_IPV6_UNUSED_PART1:DEFAULT_IPV6_UNUSED_PART2
+ * if no collision with existing IP range.
+ * Otherwise we try to use
+ * {DEFAULT_IPV6_UNUSED_PART1}XY:DEFAULT_IPV6_UNUSED_PART2 or
+ * XY:DEFAULT_IPV6_UNUSED_PART2.
+ */
+static char *get_ipv6_net32_unused(const struct in6_addr *ip6,
+	unsigned int prefix)
+{
+	int i, j;
+	struct in6_addr mask, network;
+	char buf[128], net_unused[128];
+
+	memset(&mask, 0x0, sizeof(mask));
+
+	if (prefix > 128)
+		return NULL;
+
+
+	for (i = prefix, j = 0; i > 0; i -= 8, j++) {
+		if (i >= 8)
+			mask.s6_addr[j] = 0xff;
+		else
+			mask.s6_addr[j] = (unsigned long)(0xffU << (8 - i));
+	}
+
+	sprintf(net_unused, "%x:%x", 256 * DEFAULT_IPV6_UNUSED_PART1,
+			DEFAULT_IPV6_UNUSED_PART2);
+	sprintf(buf, "%s::", net_unused);
+
+	get_in6_addr(buf, &network);
+
+	if (!is_in_subnet_ipv6(ip6, &mask, &network))
+		return strdup(net_unused);
+
+	srand(time(NULL));
+
+	/* try to randomize second group */
+	sprintf(net_unused, "%x:%x", 256 * DEFAULT_IPV6_UNUSED_PART1 +
+			(rand() % 128) + (ip6->s6_addr[1] < 128 ? 128 : 0),
+			DEFAULT_IPV6_UNUSED_PART2);
+	sprintf(buf, "%s::", net_unused);
+
+	get_in6_addr(buf, &network);
+
+	if (!is_in_subnet_ipv6(ip6, &mask, &network))
+		return strdup(net_unused);
+
+	/* try to randomize first group */
+	sprintf(net_unused, "%x:%x",
+			256 * (rand() % 128) + (256 * ip6->s6_addr[0] < 128 ?
+			128 : 0), DEFAULT_IPV6_UNUSED_PART2);
+	sprintf(buf, "%s::", net_unused);
+
+	get_in6_addr(buf, &network);
+
+	if (!is_in_subnet_ipv6(ip6, &mask, &network))
+		return strdup(net_unused);
+
+	return NULL;
+}
+
+/*
+ * Function get_ipv6_network is based on musl libc project,
+ * inet_ntop/inet_ntop.c.
+ */
+static char *get_ipv6_network(const unsigned char *a0, unsigned int prefix)
+{
+	const unsigned char *a = a0;
+	unsigned int i, j, max, best, border = 0;
+	char buf[100];
+	char ret[100];
+	char tmp[100];
+	char *p_ret = ret;
+	char *p_tmp = tmp;
+	size_t offset;
+
+	if (prefix > MAX_IPV6_PREFIX)
+		return NULL;
+
+	if (prefix == MAX_IPV6_PREFIX)
+		return strdup("\0");
+
+	snprintf(buf, sizeof(buf),
+		"%x:%x:%x:%x:%x:%x:%x:%x",
+		256 * a[0] + a[1], 256 * a[2] + a[3],
+		256 * a[4] + a[5], 256 * a[6] + a[7],
+		256 * a[8] + a[9], 256 * a[10] + a[11],
+		256 * a[12] + a[13], 256 * a[14] + a[15]);
+
+	for (i = 0; i < 8; i++) {
+		if (i < prefix >> 4) {
+			border += sprintf(p_tmp, "%x", 256 * a[2 * i] +
+				a[2 * i + 1]);
+			if (i > 0)
+				border++;
+		}
+
+		if (i >= prefix >> 4)
+			break;
+
+		/* ':' only if no leading in host or ending in net */
+		if (i > 0)
+			*p_ret++ = ':';
+
+		offset = sprintf(p_ret, "%x", 256 * a[2 * i] + a[2 * i + 1]);
+		p_ret += offset;
+	}
+
+	*p_ret = '\0';
+
+	/* Find longest /(^0|:)[:0]{2,}/ */
+	for (i = best = 0, max = 2; buf[i]; i++) {
+		if (i && buf[i] != ':')
+			continue;
+		j = strspn(buf + i, ":0");
+
+		if (j > max)
+			best = i, max = j;
+	}
+
+	size_t length = strlen(ret);
+	size_t best_end = best + max - 1;
+
+	if (max > 2 && best < border) {
+		p_ret = ret;
+		/* Replace longest /(^0|:)[:0]{2,}/ with "::" */
+		if (best == 0 && best_end >= border) {
+			/* zeros in whole net part or continue to host */
+			ret[0] = ':';
+			ret[1] = '\0';
+		} else if (best == 0 && best_end < border) {
+			/* zeros on beginning, not whole part */
+			ret[0] = ':';
+			memmove(p_ret + 1, p_ret + best_end, border - best_end
+				+ 1);
+		} else if (best > 0 && best_end >= border) {
+			/*
+			 * zeros not from beginning to border or continue to
+			 * host
+			 */
+			ret[best] = ':';
+			ret[best + 1] = '\0';
+		} else {
+			/* zeros somewhere in the middle */
+			ret[best] = ':';
+			memmove(p_ret + best + 1, p_ret + best_end,
+					border - best + 1);
+		}
+	}
+
+	if (length < INET6_ADDRSTRLEN)
+		return strdup(ret);
+
+	return NULL;
+}
+
+/*
+ * Strip host part from ip address.
+ */
+static char *get_host_from_ip(const char *ip, const char *net)
+{
+	if (ip == NULL || net == NULL)
+		return NULL;
+
+	char *result = strstr(ip, net);
+
+	if (!result || result != ip)
+		return NULL;
+
+	char *buf = strdup(ip);
+	unsigned int index = strlen(net);
+	int len;
+
+	/* prefix < 8 (IPv4) or 128 (IPv6) */
+	if (index == strlen(ip))
+		return strdup("\0");
+
+	/* prefix > 0 && prefix < 32 (IPv4) or 128 (IPv6) */
+	if (index > 0 && index < strlen(ip)) {
+		len = strlen(ip) - index - 1;
+		assert(ip[index] == ':' || ip[index] == '.');
+		memmove(buf, buf + index + 1, len);
+		buf[len] = '\0';
+	}
+
+	return buf;
+}
+
+static void check_prefix_range(unsigned int prefix, int is_ipv6, int is_lhost)
+{
+	unsigned int base_prefix = is_ipv6 ? BASE_IPV6_PREFIX :
+		BASE_IPV4_PREFIX;
+	unsigned int max_prefix = is_ipv6 ? MAX_IPV6_PREFIX : MAX_IPV4_PREFIX;
+
+	if (prefix < base_prefix || (is_ipv6 && prefix == 128) ||
+		(!is_ipv6 && prefix == 32))
+		tst_res_comment(TWARN,
+			"prefix %d for %s will be unsuitable for some stress tests which need %s variable. To avoid this use prefix >= %d and prefix < %d.",
+			prefix, is_ipv6 ?  "IPv6" : "IPv4",
+			is_ipv6 ?
+				(is_lhost ? "IPV6_LNETWORK" : "IPV6_RNETWORK") :
+				(is_lhost ? "IPV4_LNETWORK" : "IPV4_RNETWORK"),
+			base_prefix, max_prefix);
+}
+
+static char *get_ipv4_network(int ip, unsigned int prefix)
+{
+	char buf[INET_ADDRSTRLEN + 1];
+	char *p_buf = buf;
+	unsigned char byte;
+	unsigned int i;
+
+	if (prefix > MAX_IPV4_PREFIX)
+		return NULL;
+
+	if (prefix == MAX_IPV4_PREFIX)
+		return strdup("\0");
+
+	prefix &= 0x18;
+
+	for (i = 0; i < MAX_IPV4_PREFIX && (prefix == 0 || i < prefix);
+	     i += 8) {
+		if (i == 0) {
+			byte = ip & 0xff;
+			sprintf(p_buf, "%d", byte);
+		} else {
+			byte = (ip >> i) & 0xff;
+			sprintf(p_buf, ".%d", byte);
+		}
+		p_buf += strlen(p_buf);
+	}
+
+	return strdup(buf);
+}
+
+/*
+ * Round down prefix.
+ */
+static int round_down_prefix(unsigned int prefix, int is_ipv6)
+{
+	unsigned int base_prefix = is_ipv6 ? BASE_IPV6_PREFIX :
+		BASE_IPV4_PREFIX;
+
+	return prefix / base_prefix * base_prefix;
+}
+
+static void get_ipv4_info(const char *lip_str, const char *rip_str, int lprefix,
+	int rprefix)
+{
+	struct in_addr lip, rip;
+	int lprefix_round, rprefix_round;
+
+	lprefix_round = round_down_prefix(lprefix, 0);
+	rprefix_round = round_down_prefix(rprefix, 0);
+
+	get_in_addr(lip_str, &lip);
+	get_in_addr(rip_str, &rip);
+
+	vars.ipv4_lbroadcast = get_ipv4_broadcast(lip, lprefix);
+	vars.ipv4_rbroadcast = get_ipv4_broadcast(rip, rprefix);
+
+	vars.ipv4_lnetmask = get_ipv4_netmask(lprefix);
+	vars.ipv4_rnetmask = get_ipv4_netmask(rprefix);
+
+	vars.ipv4_lnetwork = get_ipv4_network(lip.s_addr, lprefix_round);
+	vars.ipv4_rnetwork = get_ipv4_network(rip.s_addr, rprefix_round);
+
+	vars.lhost_ipv4_host = get_host_from_ip(lip_str, vars.ipv4_lnetwork);
+	vars.rhost_ipv4_host = get_host_from_ip(rip_str, vars.ipv4_rnetwork);
+
+	vars.ipv4_net16_unused = get_ipv4_net16_unused(&lip, lprefix_round);
+}
+
+static void get_ipv6_info(const char *lip_str, const char *rip_str,
+	int lprefix, int rprefix)
+{
+	struct in6_addr lip, rip;
+	int lprefix_round, rprefix_round;
+
+	lprefix_round = round_down_prefix(lprefix, 1);
+	rprefix_round = round_down_prefix(rprefix, 1);
+
+	get_in6_addr(lip_str, &lip);
+	get_in6_addr(rip_str, &rip);
+
+	vars.ipv6_lnetmask = get_ipv6_netmask(lprefix);
+	vars.ipv6_rnetmask = get_ipv6_netmask(rprefix);
+
+	vars.ipv6_lnetwork = get_ipv6_network(lip.s6_addr, lprefix_round);
+	vars.ipv6_rnetwork = get_ipv6_network(rip.s6_addr, rprefix_round);
+
+	vars.lhost_ipv6_host = get_host_from_ip(lip_str, vars.ipv6_lnetwork);
+	vars.rhost_ipv6_host = get_host_from_ip(rip_str, vars.ipv6_rnetwork);
+
+	vars.ipv6_net32_unused = get_ipv6_net32_unused(&lip, lprefix_round);
+}
+
+static void print_vars(int is_ipv6)
+{
+	if (is_ipv6) {
+		print_svar("IPV6_LNETMASK", vars.ipv6_lnetmask);
+		print_svar_change("IPV6_RNETMASK", vars.ipv6_rnetmask);
+		print_svar("IPV6_LNETWORK", vars.ipv6_lnetwork);
+		print_svar("IPV6_RNETWORK", vars.ipv6_rnetwork);
+		print_svar("LHOST_IPV6_HOST", vars.lhost_ipv6_host);
+		print_svar("RHOST_IPV6_HOST", vars.rhost_ipv6_host);
+		print_svar("IPV6_NET32_UNUSED", vars.ipv6_net32_unused);
+	} else {
+		print_svar("IPV4_LBROADCAST", vars.ipv4_lbroadcast);
+		print_svar_change("IPV4_RBROADCAST", vars.ipv4_rbroadcast);
+		print_svar("IPV4_LNETMASK", vars.ipv4_lnetmask);
+		print_svar_change("IPV4_RNETMASK", vars.ipv4_rnetmask);
+		print_svar("IPV4_LNETWORK", vars.ipv4_lnetwork);
+		print_svar("IPV4_RNETWORK", vars.ipv4_rnetwork);
+		print_svar("LHOST_IPV4_HOST", vars.lhost_ipv4_host);
+		print_svar("RHOST_IPV4_HOST", vars.rhost_ipv4_host);
+		print_svar("IPV4_NET16_UNUSED", vars.ipv4_net16_unused);
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	char *lip_str = NULL, *rip_str = NULL;
+	int is_ipv6, lprefix, rprefix, tmp;
+	struct in_addr ip;
+	struct in6_addr ip6;
+
+	int is_usage = argc > 1 && (!strcmp(argv[1], "-h") ||
+		!strcmp(argv[1], "--help"));
+	if (argc < 3 || is_usage) {
+		usage(argv[0]);
+		exit(is_usage ? EXIT_SUCCESS : EXIT_FAILURE);
+	}
+
+	lip_str = argv[1];
+	rip_str = argv[2];
+
+	is_ipv6 = !!strchr(lip_str, ':');
+	lprefix = get_prefix(lip_str, is_ipv6);
+	rprefix = get_prefix(rip_str, is_ipv6);
+
+	if (is_ipv6)
+		get_in6_addr(lip_str, &ip6);
+	else
+		get_in_addr(lip_str, &ip);
+
+	tmp = !!strchr(rip_str, ':');
+	if (tmp)
+		get_in6_addr(rip_str, &ip6);
+	else
+		get_in_addr(rip_str, &ip);
+
+	if (is_ipv6 != tmp)
+		tst_brk_comment("mixed IPv4 and IPv6 addresses ('%s', '%s')",
+				lip_str, rip_str);
+
+	check_prefix_range(lprefix, is_ipv6, 1);
+	check_prefix_range(rprefix, is_ipv6, 0);
+
+	if (!strcmp(lip_str, rip_str))
+		tst_brk_comment("IP addresses cannot be the same ('%s', '%s')",
+				lip_str, rip_str);
+
+	if (is_ipv6)
+		get_ipv6_info(lip_str, rip_str, lprefix, rprefix);
+	else
+		get_ipv4_info(lip_str, rip_str, lprefix, rprefix);
+
+	print_vars(is_ipv6);
+
+	exit(EXIT_SUCCESS);
+}
-- 
2.14.0

