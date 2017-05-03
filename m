From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  3 May 2017 18:07:50 +0200
Subject: [LTP] [RFC PATCH v5 2/3] network: Add tool for setup IP variables
In-Reply-To: <20170503160751.1634-1-pvorel@suse.cz>
References: <20170503160751.1634-1-pvorel@suse.cz>
Message-ID: <20170503160751.1634-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These environment variables are exported by setup_network_variables:
IPV4_LHOST: IPv4 address of the local host
IPV4_RHOST: IPv4 address of the local host
IPV4_NETWORK: IPv4 common part of IPV4_LHOST and IPV4_RHOST
LHOST_IPV4_HOST IPv4 unique part of IPV4_LHOST
RHOST_IPV4_HOST IPv4 unique part of IPV4_RHOST
IPV4_NET16_UNUSED: IPv4 16 bit unused subnet
IPV4_PREFIX: IPv4 prefix
IPV6_LHOST: IPv6 address of local host
IPV6_RHOST: IPv6 address of the remote host
IPV6_NETWORK: IPv6 common part of IPV6_LHOST and IPV6_RHOST
LHOST_IPV6_HOST: IPv6 unique part of IPV6_LHOST
RHOST_IPV6_HOST: IPv6 unique part of IPV6_RHOST
IPV6_NET32_UNUSED: IPv6 32 bit unused subnet
IPV6_PREFIX: IPv6 prefix

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/.gitignore     |   1 +
 testcases/lib/Makefile       |   2 +-
 testcases/lib/tst_net_vars.c | 760 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 762 insertions(+), 1 deletion(-)
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
index 1127a59fe..49ef2ec01 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -27,6 +27,6 @@ include $(top_srcdir)/include/mk/testcases.mk
 INSTALL_TARGETS		:= *.sh
 
 MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
-			   tst_device
+			   tst_device tst_net_vars
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_net_vars.c b/testcases/lib/tst_net_vars.c
new file mode 100644
index 000000000..a57f84f31
--- /dev/null
+++ b/testcases/lib/tst_net_vars.c
@@ -0,0 +1,760 @@
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
+#include <linux/rtnetlink.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <stdarg.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+#define FLAG_GET_NETWORK 1
+#define FLAG_GET_HOST 2
+
+#define DEFAULT_IPV4_PREFIX 24
+#define DEFAULT_IPV6_PREFIX 64
+
+#define BASE_IPV4_PREFIX 8
+#define BASE_IPV6_PREFIX 16
+
+#define DEFAULT_IPV4_UNUSED_PART1 10
+#define DEFAULT_IPV6_UNUSED_PART1 0xfd
+
+#define DEFAULT_IPV4_UNUSED_PART2 23
+#define DEFAULT_IPV6_UNUSED_PART2 0x23
+
+#define PROGRAM_NAME "tst_net_vars"
+
+typedef struct ltp_net_variables {
+	char *ipv4_lhost;
+	char *ipv4_rhost;
+	char *ipv4_network;
+	char *lhost_ipv4_host;
+	char *rhost_ipv4_host;
+	char *ipv6_lhost;
+	char *ipv6_rhost;
+	char *ipv6_network;
+	char *lhost_ipv6_host;
+	char *rhost_ipv6_host;
+	char *ipv4_net16_unused;
+	char *ipv6_net32_unused;
+	int ipv4_prefix;
+	int ipv6_prefix;
+} ltp_net_variables;
+
+static ltp_net_variables vars;
+
+static void usage(void)
+{
+	fprintf(stderr, "USAGE:\n"
+		"%s IPv4/PREFIX IPv4/PREFIX\n"
+		"%s IPv6/PREFIX IPv6/PREFIX\n\n"
+		"%s IPv4 IPv4\n"
+		"%s IPv6 IPv6\n\n"
+		"IP addresses must be different, within the same subnet.\n"
+		"Prefixes must be the same.\n"
+		"IPv4 prefixes must be in range <8, 31>.\n"
+		"IPv6 prefixes must be <16, 127>.\n"
+		"Default IPv4 prefix: %d.\n"
+		"Default IPv6 prefix: %d.\n\n"
+		"Exported variables:\n"
+		"IPV4_LHOST: IPv4 address of the local host\n"
+		"IPV4_RHOST: IPv4 address of the local host\n"
+		"IPV4_NETWORK: IPv4 common part of IPV4_LHOST and IPV4_RHOST\n"
+		"LHOST_IPV4_HOST IPv4 unique part of IPV4_LHOST\n"
+		"RHOST_IPV4_HOST IPv4 unique part of IPV4_RHOST\n"
+		"IPV4_NET16_UNUSED: IPv4 16 bit unused subnet\n"
+		"IPV4_PREFIX: IPv4 prefix\n"
+		"IPV6_LHOST: IPv6 address of local host\n"
+		"IPV6_RHOST: IPv6 address of the remote host\n"
+		"IPV6_NETWORK: IPv6 common part of IPV6_LHOST and IPV6_RHOST\n"
+		"LHOST_IPV6_HOST: IPv6 unique part of IPV6_LHOST\n"
+		"RHOST_IPV6_HOST: IPv6 unique part of IPV6_RHOST\n"
+		"IPV6_NET32_UNUSED: IPv6 32 bit unused subnet\n"
+		"IPV6_PREFIX: IPv6 prefix\n",
+		PROGRAM_NAME, PROGRAM_NAME, PROGRAM_NAME, PROGRAM_NAME,
+		DEFAULT_IPV4_PREFIX, DEFAULT_IPV6_PREFIX);
+}
+
+static int get_in_addr(const char *ip_str, struct in_addr *ip)
+{
+	if (inet_pton(AF_INET, ip_str, ip) <= 0) {
+		fprintf(stderr, "Bad IPv4 address: '%s'\n", ip_str);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int get_in6_addr(const char *ip_str, struct in6_addr *ip6)
+{
+	if (inet_pton(AF_INET6, ip_str, ip6) <= 0) {
+		fprintf(stderr, "bad IPv6 address: '%s'\n", ip_str);
+		return -1;
+	}
+	return 0;
+}
+
+/*
+ * Function prefix2mask is from ipcalc project, ipcalc.c.
+ */
+struct in_addr prefix2mask(int prefix)
+{
+	struct in_addr mask;
+
+	memset(&mask, 0, sizeof(mask));
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
+	struct in_addr network;
+
+	memset(&network, 0, sizeof(network));
+	network.s_addr = ip->s_addr & mask->s_addr;
+
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
+
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
+	if (get_in_addr(buf, &network))
+		return NULL;
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
+	if (get_in_addr(buf, &network))
+		return NULL;
+
+	if (!is_in_subnet_ipv4(ip, &mask, &network))
+		return strdup(net_unused);
+
+	/* try to randomize first group */
+	sprintf(net_unused, "%d.%d", (rand() % 128) + (((ip->s_addr) & 0xff)
+			< 128 ? 128 : 0), DEFAULT_IPV4_UNUSED_PART2);
+	sprintf(buf, "%s.0.0", net_unused);
+
+	if (get_in_addr(buf, &network))
+		return NULL;
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
+	if (prefix > 128)
+		return NULL;
+
+	memset(&mask, 0x0, sizeof(mask));
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
+	if (get_in6_addr(buf, &network))
+		return NULL;
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
+	if (get_in6_addr(buf, &network))
+		return NULL;
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
+	if (get_in6_addr(buf, &network))
+		return NULL;
+
+	if (!is_in_subnet_ipv6(ip6, &mask, &network))
+		return strdup(net_unused);
+
+	return NULL;
+}
+
+/*
+ * Function inet_ntop6_impl is based on musl libc project,
+ * inet_ntop/inet_ntop.c.
+ */
+static char *inet_ntop6_impl(const unsigned char *a0, unsigned int prefix,
+	int flags)
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
+	int is_net = flags & FLAG_GET_NETWORK;
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
+			border += sprintf(p_tmp, "%x", 256 * a[2 * i] + a[2 * i + 1]);
+			if (i > 0)
+				border++;
+		}
+
+		if (is_net && i >= prefix >> 4)
+			break;
+
+		if (!is_net && i < prefix >> 4)
+			continue;
+
+		/* ':' only if no leading in host or ending in net */
+		if ((is_net && i > 0)
+			 || (!is_net && i > prefix >> 4))
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
+	if (max > 2 && ((is_net && best < border) ||
+					(!is_net && best_end + 2 > border))) {
+		p_ret = ret;
+		/* Replace longest /(^0|:)[:0]{2,}/ with "::" */
+		if (is_net) {
+			if (best == 0 && best_end >= border) {
+				/* zeros in whole net part or continue to host */
+				ret[0] = ':';
+				ret[1] = '\0';
+			} else if (best == 0 && best_end < border) {
+				/* zeros on beginning, not whole part */
+				ret[0] = ':';
+				memmove(p_ret + 1, p_ret + best_end, border - best_end + 1);
+			} else if (best > 0 && best_end >= border) {
+				/* zeros not from beginning to border or continue to host */
+				ret[best] = ':';
+				ret[best + 1] = '\0';
+			} else {
+				/* zeros somewhere in the middle */
+				ret[best] = ':';
+				memmove(p_ret + best + 1, p_ret + best_end,
+						border - best + 1);
+			}
+		} else {
+			if (best <= border + 1 && best_end >= length + border) {
+				/* zeros in whole host part or continue to net */
+				ret[0] = '0';
+				ret[1] = '\0';
+			} else if (best <= border + 1 && best_end < length + border) {
+				if (best == border) {
+					/* zeros start in host, ends before end */
+					p_ret[0] = ':';
+					memmove(p_ret + 1, p_ret + best_end - border, length +
+						border - best_end + 2);
+				} else
+					/* zeros start in net, ends before end */
+					memmove(p_ret, p_ret + best_end - border, length +
+						border - best_end + 1);
+			} else if (best > border && best_end == border + length) {
+				/* zeros at the end */
+				ret[best - border] = ':';
+				ret[best - border + 1] = '\0';
+			} else {
+				/* zeros somewhere in the middle */
+				ret[best - border] = ':';
+				memmove(p_ret + best - border + 1, p_ret + best_end - border,
+					length + border - best_end + 1);
+			}
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
+static int read_prefix(const char *ip_str, int is_ipv6)
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
+				inet_ntop(family, RTA_DATA(retrta), pradd, sizeof(pradd));
+				if (!strcmp(pradd, ip_str))
+					return retaddr->ifa_prefixlen;
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
+static int validate_prefix(int prefix, int is_ipv6)
+{
+	int base_prefix = is_ipv6 ? BASE_IPV6_PREFIX : BASE_IPV4_PREFIX;
+
+	return (prefix < base_prefix || (is_ipv6 && prefix == 128)) ||
+		(!is_ipv6 && prefix == 32) ? -1 : 0;
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
+			tst_brk(TBROK, "Conversion error");
+	}
+
+	if (prefix < 0 || ((is_ipv6 && prefix > 128) ||
+		(!is_ipv6 && prefix > 32)))
+		tst_brk(TBROK, "Bad %s prefix: %s", is_ipv6 ? "IPv6" : "IPv4",
+			prefix_str);
+
+	return prefix;
+}
+
+static char *get_ipv4_host(int ip, int prefix)
+{
+	char buf[INET_ADDRSTRLEN + 1];
+	char *p_buf = buf;
+	unsigned char byte;
+	int i;
+
+	if (prefix < 0 || prefix > 32)
+		return NULL;
+
+	prefix &= 0x18;
+
+	for (i = 0; i < 32; i += 8) {
+		if (i < prefix)
+			continue;
+
+		if (i > prefix) {
+			sprintf(p_buf, ".");
+			p_buf++;
+		}
+
+		if (i == 0)
+			byte = ip & 0xff;
+		else
+			byte = (ip >> i) & 0xff;
+
+		sprintf(p_buf, "%d", byte);
+		p_buf += strlen(p_buf);
+	}
+
+	return strdup(buf);
+}
+
+static char *get_ipv4_network(int ip, int prefix)
+{
+	char buf[INET_ADDRSTRLEN + 1];
+	char *p_buf = buf;
+	unsigned char byte;
+	int i;
+
+	if (prefix < 0 || prefix > 32)
+		return NULL;
+
+	prefix &= 0x18;
+
+	for (i = 0; i < 32 && i < prefix; i += 8) {
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
+static void get_ipv4_info(struct in_addr *lip, struct in_addr *rip, int prefix)
+{
+	vars.ipv4_network = get_ipv4_network(lip->s_addr, prefix);
+	if (strcmp(vars.ipv4_network, get_ipv4_network(rip->s_addr, prefix)))
+		tst_brk(TBROK, "Please use the same network for both IP addresses");
+
+	vars.lhost_ipv4_host = get_ipv4_host(lip->s_addr, prefix);
+	vars.rhost_ipv4_host = get_ipv4_host(rip->s_addr, prefix);
+	vars.ipv4_net16_unused = get_ipv4_net16_unused(lip, prefix);
+
+}
+
+static void get_ipv6_info(struct in6_addr *lip, struct in6_addr *rip,
+	int prefix)
+{
+	vars.ipv6_network = inet_ntop6_impl(lip->s6_addr, prefix, FLAG_GET_NETWORK);
+	if (strcmp(vars.ipv6_network,
+		inet_ntop6_impl(rip->s6_addr, prefix, FLAG_GET_NETWORK)))
+		tst_brk(TBROK, "Please use the same network for both IP addresses");
+
+	vars.lhost_ipv6_host = inet_ntop6_impl(lip->s6_addr, prefix, FLAG_GET_HOST);
+	vars.rhost_ipv6_host = inet_ntop6_impl(rip->s6_addr, prefix, FLAG_GET_HOST);
+	vars.ipv6_net32_unused = get_ipv6_net32_unused(lip, prefix);
+}
+
+static void print_svar(const char *name, const char *val)
+{
+	if (name && val)
+		printf("export %s='%s'\n", name, val);
+}
+static void print_ivar(const char *name, const int val)
+{
+	if (name)
+		printf("export %s=%d\n", name, val);
+}
+
+static void print_vars(int is_ipv6)
+{
+	if (is_ipv6) {
+		print_svar("IPV6_LHOST", vars.ipv6_lhost);
+		print_svar("IPV6_RHOST", vars.ipv6_rhost);
+		print_svar("IPV6_NETWORK", vars.ipv6_network);
+		print_svar("LHOST_IPV6_HOST", vars.lhost_ipv6_host);
+		print_svar("RHOST_IPV6_HOST", vars.rhost_ipv6_host);
+		print_svar("IPV6_NET32_UNUSED", vars.ipv6_net32_unused);
+		print_ivar("IPV6_PREFIX", vars.ipv6_prefix);
+	} else {
+		print_svar("IPV4_LHOST", vars.ipv4_lhost);
+		print_svar("IPV4_RHOST", vars.ipv4_rhost);
+		print_svar("IPV4_NETWORK", vars.ipv4_network);
+		print_svar("LHOST_IPV4_HOST", vars.lhost_ipv4_host);
+		print_svar("RHOST_IPV4_HOST", vars.rhost_ipv4_host);
+		print_svar("IPV4_NET16_UNUSED", vars.ipv4_net16_unused);
+		print_ivar("IPV4_PREFIX", vars.ipv4_prefix);
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	char *lip_str = NULL, *rip_str = NULL;
+	struct in_addr lip, rip;
+	struct in6_addr lip6, rip6;
+	int is_ipv6, lprefix, rprefix, prefix, base_prefix, is_read_prefix = 0;
+
+	int is_usage = argc > 1 && (!strcmp(argv[1], "-h") ||
+		!strcmp(argv[1], "--help"));
+	if (argc < 3 || is_usage) {
+		usage();
+		exit(is_usage ? 0 : 1);
+	}
+
+	lip_str = argv[1];
+	rip_str = argv[2];
+
+	is_ipv6 = !!strchr(lip_str, ':');
+	if (is_ipv6 != !(strchr(rip_str, ':') == NULL))
+		tst_brk(TBROK, "Mixed IPv4 and IPv6 addresses");
+
+	lprefix = get_prefix(lip_str, is_ipv6);
+	rprefix = get_prefix(rip_str, is_ipv6);
+
+	if (lprefix < 0 && rprefix < 0) {
+		is_read_prefix = 1;
+		lprefix = read_prefix(lip_str, is_ipv6);
+		if (lprefix < 0)
+			lprefix = read_prefix(rip_str, is_ipv6);
+		if (lprefix < 0) {
+			lprefix = is_ipv6 ? DEFAULT_IPV6_PREFIX : DEFAULT_IPV4_PREFIX;
+			fprintf(stderr, "Missing prefix, using default: %d\n", lprefix);
+		}
+		rprefix = lprefix;
+	} else {
+		if (lprefix < 0 && rprefix > 0)
+			lprefix = rprefix;
+		else if (rprefix < 0 && lprefix > 0)
+			rprefix = lprefix;
+	}
+
+	if (validate_prefix(lprefix, is_ipv6))
+		tst_brk(TBROK, is_read_prefix ?
+					 "Please don't use interface with prefix: %d for %s" :
+					 "Please don't use prefix: %d for %s",
+				 lprefix, is_ipv6 ?
+				 "IPv6" : "IPv4");
+
+	if (lprefix != rprefix)
+		tst_brk(TBROK, "Prefixes must be the same");
+
+	if (is_ipv6) {
+		get_in6_addr(lip_str, &lip6);
+		get_in6_addr(rip_str, &rip6);
+		vars.ipv6_lhost = strdup(lip_str);
+		vars.ipv6_rhost = strdup(rip_str);
+		vars.ipv6_prefix = lprefix;
+	} else {
+		get_in_addr(lip_str, &lip);
+		get_in_addr(rip_str, &rip);
+		vars.ipv4_lhost = strdup(lip_str);
+		vars.ipv4_rhost = strdup(rip_str);
+		vars.ipv4_prefix = lprefix;
+	}
+
+	if (!strcmp(lip_str, rip_str))
+		tst_brk(TBROK, "IP addresses cannot be the same");
+
+	/* Round down prefix */
+	base_prefix = is_ipv6 ? BASE_IPV6_PREFIX : BASE_IPV4_PREFIX;
+	prefix = lprefix / base_prefix * base_prefix;
+
+	if (is_ipv6)
+		get_ipv6_info(&lip6, &rip6, prefix);
+	else
+		get_ipv4_info(&lip, &rip, prefix);
+
+	print_vars(is_ipv6);
+
+	exit(0);
+}
-- 
2.12.2

