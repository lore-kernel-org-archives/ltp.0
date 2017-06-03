From: Petr Vorel <pvorel@suse.cz>
Date: Sat,  3 Jun 2017 14:00:21 +0200
Subject: [LTP] [RFC PATCH v6 10/11] network: Add tools for setup IP related
	environment variables
In-Reply-To: <20170603120022.13415-1-pvorel@suse.cz>
References: <20170603120022.13415-1-pvorel@suse.cz>
Message-ID: <20170603120022.13415-11-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_net_vars take input of local and remote address and setup most of
test link (IP related) environment variables.

For full list of environment variables which it setup run:
tst_net_vars -h

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/.gitignore     |   1 +
 testcases/lib/Makefile       |   4 +-
 testcases/lib/tst_net_vars.c | 802 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 805 insertions(+), 2 deletions(-)
 create mode 100644 testcases/lib/tst_net_vars.c

diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index 522889bed..e1274df64 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -4,3 +4,4 @@
 /tst_rod
 /tst_kvcmp
 /tst_device
+/tst_net_vars
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index 1127a59fe..40c64963e 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -26,7 +26,7 @@ include $(top_srcdir)/include/mk/testcases.mk
 
 INSTALL_TARGETS		:= *.sh
 
-MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
-			   tst_device
+MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp \
+			   tst_device tst_net_vars
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_net_vars.c b/testcases/lib/tst_net_vars.c
new file mode 100644
index 000000000..551bf4707
--- /dev/null
+++ b/testcases/lib/tst_net_vars.c
@@ -0,0 +1,802 @@
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
+#define DEFAULT_IPV4_PREFIX 24
+#define DEFAULT_IPV6_PREFIX 64
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
+	char *ipv4_lhost;
+	char *ipv4_rhost;
+	char *ipv4_lnetwork;
+	char *ipv4_rnetwork;
+	char *lhost_ipv4_host;
+	char *rhost_ipv4_host;
+	char *ipv6_lhost;
+	char *ipv6_rhost;
+	char *ipv6_lnetwork;
+	char *ipv6_rnetwork;
+	char *lhost_ipv6_host;
+	char *rhost_ipv6_host;
+	char *ipv4_net16_unused;
+	char *ipv6_net32_unused;
+	char *lhost_ifaces;
+	unsigned int ipv4_lprefix;
+	unsigned int ipv4_rprefix;
+	unsigned int ipv6_lprefix;
+	unsigned int ipv6_rprefix;
+} ltp_net_variables;
+
+
+static ltp_net_variables vars;
+
+static void usage(const char *cmd)
+{
+	fprintf(stderr, "USAGE:\n"
+		"%s IPv4/PREFIX IPv4/PREFIX\n"
+		"%s IPv6/PREFIX IPv6/PREFIX\n\n"
+		"%s IPv4 IPv4\n"
+		"%s IPv6 IPv6\n"
+		"%s -h\n\n"
+		"IP addresses must be different\n"
+		"Prefixes should be in range <8, 31> (IPv4) or <16, 127> (IPv6) otherwise it's not suitable for tests which need both host part and network part to be set.\n"
+		"If prefix is not provided, is tried to be detected from rtnetlink data for local IP address, which is used for remote prefix as well. If is not found use default values.\n"
+		"Default IPv4 prefix: %d.\n"
+		"Default IPv6 prefix: %d.\n\n"
+		"Exported variables:\n"
+		"IPV4_LHOST: IPv4 address of the local host (first parameter)\n"
+		"IPV4_RHOST: IPv4 address of the remote host (second parameter)\n"
+		"IPV4_LNETWORK: IPv4 network part of IPV4_LHOST\n"
+		"IPV4_RNETWORK: IPv4 network part of IPV4_RHOST\n"
+		"LHOST_IPV4_HOST IPv4 host part of IPV4_LHOST\n"
+		"RHOST_IPV4_HOST IPv4 host part of IPV4_RHOST\n"
+		"IPV4_NET16_UNUSED: IPv4 16 bit unused subnet\n"
+		"IPV4_LPREFIX: IPv4 prefix for IPV4_LNETWORK\n"
+		"IPV4_RPREFIX: IPv4 prefix for IPV4_RNETWORK (respect user settings)\n"
+		"IPV6_LHOST: IPv6 address of the local host (first parameter)\n"
+		"IPV6_RHOST: IPv6 address of the remote host (second parameter)\n"
+		"IPV6_LNETWORK: IPv6 network part of IPV6_LHOST\n"
+		"IPV6_RNETWORK: IPv6 network part of IPV6_LHOST\n"
+		"LHOST_IPV6_HOST: IPv6 unique part of IPV6_LHOST\n"
+		"RHOST_IPV6_HOST: IPv6 unique part of IPV6_RHOST\n"
+		"IPV6_NET32_UNUSED: IPv6 32 bit unused subnet\n"
+		"IPV6_LPREFIX: IPv6 prefix for IPV6_LNETWORK\n"
+		"IPV6_RPREFIX: IPv6 prefix for IPV6_RNETWORK (respect user settings)\n"
+		"LHOST_IFACES: iface name of the local host\n"
+		"We allow to respect user settings for:\n"
+		"Remote prefixes (IPV4_RPREFIX, IPV6_RPREFIX) as we cannot detect them on remote system.\n"
+		"Local iface (LHOST_IFACES) as user might want to use more ifaces.\n\n"
+		"PARAMS:\n"
+		"-h this help\n",
+		cmd, cmd, cmd, cmd, cmd, DEFAULT_IPV4_PREFIX,
+		DEFAULT_IPV6_PREFIX);
+}
+
+static void get_in_addr(const char *ip_str, struct in_addr *ip)
+{
+	if (inet_pton(AF_INET, ip_str, ip) <= 0)
+		tst_brk(TCONF, "bad IPv4 address: '%s'", ip_str);
+}
+
+static void get_in6_addr(const char *ip_str, struct in6_addr *ip6)
+{
+	if (inet_pton(AF_INET6, ip_str, ip6) <= 0)
+		tst_brk(TCONF, "bad IPv6 address: '%s'", ip_str);
+}
+
+/*
+ * Function prefix2mask is from ipcalc project, ipcalc.c.
+ */
+struct in_addr prefix2mask(unsigned int prefix)
+{
+	struct in_addr mask = {0};
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
+struct in_addr calc_network(const struct in_addr *ip, struct in_addr *mask)
+{
+	struct in_addr network = {0};
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
+int is_in_subnet_ipv6(const struct in6_addr *network,
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
+	struct in6_addr mask = {0}, network;
+	char buf[128], net_unused[128];
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
+			/* zeros not from beginning to border or continue to host */
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
+
+	/* prefix < 8 (IPv4) or 128 (IPv6) */
+	if (index == strlen(ip))
+		return strdup("\0");
+
+	/* prefix > 0 && prefix < 32 (IPv4) or 128 (IPv6) */
+	if (index > 0 && index < strlen(ip)) {
+		int len = strlen(ip) - index - 1;
+		assert(ip[index] == ':' || ip[index] == '.');
+		memmove(buf, buf + index + 1, len);
+		buf[len] = '\0';
+	}
+
+	return buf;
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
+static void check_prefix_range(unsigned int prefix, int is_ipv6, int is_lhost)
+{
+	unsigned int base_prefix = is_ipv6 ? BASE_IPV6_PREFIX :
+		BASE_IPV4_PREFIX;
+	unsigned int max_prefix = is_ipv6 ? MAX_IPV6_PREFIX : MAX_IPV4_PREFIX;
+
+	if (prefix < base_prefix || (is_ipv6 && prefix == 128) ||
+		(!is_ipv6 && prefix == 32))
+		tst_res(TWARN,
+			"prefix %d for %s will be unsuitable for some stress tests which needs %s variable."
+			" To avoid this use prefix >= %d and prefix < %d.",
+			prefix, is_ipv6 ?  "IPv6" : "IPv4",
+			is_ipv6 ? (is_lhost ? "IPV6_LNETWORK" : "IPV6_RNETWORK") :
+				(is_lhost ? "IPV4_LNETWORK" : "IPV4_RNETWORK"),
+			base_prefix, max_prefix);
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
+			tst_brk(TBROK, "conversion error");
+	}
+
+	if (prefix < 0 || ((is_ipv6 && prefix > MAX_IPV6_PREFIX) ||
+		(!is_ipv6 && prefix > MAX_IPV4_PREFIX)))
+		tst_brk(TBROK, "bad %s prefix: %s", is_ipv6 ? "IPv6" : "IPv4",
+			prefix_str);
+
+	return prefix;
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
+	for (i = 0; i < MAX_IPV4_PREFIX && (prefix == 0 || i < prefix); i += 8) {
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
+static int read_prefix_iface(const char *ip_str, int is_ipv6)
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
+	int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+
+	memset(&msg, 0, sizeof(msg));
+	msg.nlhdr.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifaddrmsg));
+	msg.nlhdr.nlmsg_flags = NLM_F_REQUEST | NLM_F_ROOT;
+	msg.nlhdr.nlmsg_type = RTM_GETADDR;
+	msg.addrmsg.ifa_family = family;
+
+	send(sock, &msg, msg.nlhdr.nlmsg_len, 0);
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
+					vars.lhost_ifaces = strdup(ifname);
+					if (is_ipv6) {
+						vars.ipv6_lprefix = retaddr->ifa_prefixlen;
+						vars.ipv6_rprefix = retaddr->ifa_prefixlen;
+					} else {
+						vars.ipv4_lprefix = retaddr->ifa_prefixlen;
+						vars.ipv4_rprefix = retaddr->ifa_prefixlen;
+					}
+					return 0;
+				}
+			}
+			retrta = RTA_NEXT(retrta, attlen);
+
+		}
+		retmsg = NLMSG_NEXT(retmsg, len);
+	}
+
+	return -1;
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
+	vars.ipv4_lhost = strdup(lip_str);
+	vars.ipv4_rhost = strdup(rip_str);
+
+	vars.ipv4_lprefix = lprefix;
+	vars.ipv4_rprefix = rprefix;
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
+	vars.ipv6_lhost = strdup(lip_str);
+	vars.ipv6_rhost = strdup(rip_str);
+
+	vars.ipv6_lprefix = lprefix;
+	vars.ipv6_rprefix = rprefix;
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
+static void print_svar(const char *name, const char *val)
+{
+	if (name && val)
+		printf("export %s=\"%s\"\n", name, val);
+}
+
+static void print_svar_change(const char *name, const char *val)
+{
+	if (name && val)
+		printf("export %s=\"${%s:-%s}\"\n", name, name, val);
+}
+
+static void print_ivar(const char *name, unsigned int val)
+{
+	if (name)
+		printf("export %s=%d\n", name, val);
+}
+static void print_ivar_change(const char *name, unsigned int val)
+{
+	if (name)
+		printf("export %s=${%s:-%d}\n", name, name, val);
+}
+
+static void print_vars(int is_ipv6)
+{
+	if (is_ipv6) {
+		print_svar("IPV6_LHOST", vars.ipv6_lhost);
+		print_svar("IPV6_RHOST", vars.ipv6_rhost);
+		print_svar("IPV6_LNETWORK", vars.ipv6_lnetwork);
+		print_svar("IPV6_RNETWORK", vars.ipv6_rnetwork);
+		print_svar("LHOST_IPV6_HOST", vars.lhost_ipv6_host);
+		print_svar("RHOST_IPV6_HOST", vars.rhost_ipv6_host);
+		print_svar("IPV6_NET32_UNUSED", vars.ipv6_net32_unused);
+		print_ivar("IPV6_LPREFIX", vars.ipv6_lprefix);
+		print_ivar_change("IPV6_RPREFIX", vars.ipv6_rprefix);
+	} else {
+		print_svar("IPV4_LHOST", vars.ipv4_lhost);
+		print_svar("IPV4_RHOST", vars.ipv4_rhost);
+		print_svar("IPV4_LNETWORK", vars.ipv4_lnetwork);
+		print_svar("IPV4_RNETWORK", vars.ipv4_rnetwork);
+		print_svar("LHOST_IPV4_HOST", vars.lhost_ipv4_host);
+		print_svar("RHOST_IPV4_HOST", vars.rhost_ipv4_host);
+		print_svar("IPV4_NET16_UNUSED", vars.ipv4_net16_unused);
+		print_ivar("IPV4_LPREFIX", vars.ipv4_lprefix);
+		print_ivar_change("IPV4_RPREFIX", vars.ipv4_rprefix);
+	}
+
+	print_svar_change("LHOST_IFACES", vars.lhost_ifaces);
+}
+
+int main(int argc, char *argv[])
+{
+	char *lip_str = NULL, *rip_str = NULL;
+	int is_ipv6, lprefix, rprefix;
+
+	int is_usage = argc > 1 && (!strcmp(argv[1], "-h") ||
+		!strcmp(argv[1], "--help"));
+	if (argc < 3 || is_usage) {
+		usage(argv[0]);
+		exit(is_usage ? 0 : 1);
+	}
+
+	lip_str = argv[1];
+	rip_str = argv[2];
+
+	is_ipv6 = !!strchr(lip_str, ':');
+	if (is_ipv6 != !(strchr(rip_str, ':') == NULL))
+		tst_brk(TBROK, "mixed IPv4 and IPv6 addresses");
+
+	vars.ipv4_lprefix = DEFAULT_IPV4_PREFIX;
+	vars.ipv4_rprefix = DEFAULT_IPV4_PREFIX;
+	vars.ipv6_lprefix = DEFAULT_IPV6_PREFIX;
+	vars.ipv6_rprefix = DEFAULT_IPV6_PREFIX;
+
+	/* read local prefix and iface from rtnetlink data into vars */
+	read_prefix_iface(lip_str, is_ipv6);
+
+	/*
+	 * parse prefix from user input, use it if successful, otherwise use data
+	 * from rtnetlink or default values
+	 */
+	lprefix = get_prefix(lip_str, is_ipv6);
+	rprefix = get_prefix(rip_str, is_ipv6);
+
+	if (lprefix < 0)
+		lprefix = is_ipv6 ? vars.ipv6_lprefix : vars.ipv4_lprefix;
+	else {
+		if (is_ipv6)
+			vars.ipv6_lprefix = lprefix;
+		else
+			vars.ipv4_lprefix = lprefix;
+	}
+
+	if (rprefix < 0)
+		rprefix = is_ipv6 ? vars.ipv6_rprefix : vars.ipv4_rprefix;
+	else {
+		if (is_ipv6)
+			vars.ipv6_rprefix = rprefix;
+		else
+			vars.ipv4_rprefix = rprefix;
+	}
+
+	check_prefix_range(lprefix, is_ipv6, 1);
+	if (rprefix != lprefix)
+		check_prefix_range(rprefix, is_ipv6, 0);
+
+	if (!strcmp(lip_str, rip_str))
+		tst_brk(TBROK, "IP addresses cannot be the same");
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
2.12.2

