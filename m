From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  5 Apr 2017 22:44:17 +0200
Subject: [LTP] [RFC PATCH v4 2/3] network: Add tool for setup IP variables
In-Reply-To: <20170405204418.3240-1-pvorel@suse.cz>
References: <20170405204418.3240-1-pvorel@suse.cz>
Message-ID: <20170405204418.3240-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These environment variables are defined by setup_network_variables:
IPV4_NETWORK
LHOST_IPV4_HOST
RHOST_IPV4_HOST
IPV4_NET_REV
IPV6_NETWORK
LHOST_IPV6_HOST
RHOST_IPV6_HOST
IPV6_NET_REV
LHOST_IPV6_REV
RHOST_IPV6_REV
IPV4_NET16_UNUSED
IPV6_NET32_UNUSED

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/.gitignore     |   1 +
 testcases/lib/Makefile       |   2 +-
 testcases/lib/tst_net_vars.c | 616 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 618 insertions(+), 1 deletion(-)
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
index 000000000..d4c91224c
--- /dev/null
+++ b/testcases/lib/tst_net_vars.c
@@ -0,0 +1,616 @@
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
+#include <errno.h>
+#include <netdb.h>
+#include <netinet/in.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+
+#define FLAG_GET_NETWORK 1
+#define FLAG_GET_NETWORK_UNUSED 2
+#define FLAG_GET_HOST 4
+
+#define DEFAULT_IPV4_UNUSED_PART1 10
+#define DEFAULT_IPV6_UNUSED_PART1 0xfd
+
+#define DEFAULT_IPV4_UNUSED_PART2 23
+#define DEFAULT_IPV6_UNUSED_PART2 0x23
+
+typedef struct ltp_net_variables {
+	char *ipv4_network;
+	char *ipv4_net_rev;
+	char *lhost_ipv4_host;
+	char *rhost_ipv4_host;
+	char *ipv6_network;
+	char *ipv6_net_rev;
+	char *lhost_ipv6_host;
+	char *lhost_ipv6_rev;
+	char *rhost_ipv6_host;
+	char *rhost_ipv6_rev;
+	char *ipv4_net16_unused;
+	char *ipv6_net32_unused;
+} ltp_net_variables;
+
+static ltp_net_variables vars;
+
+/*
+ * Function inet_ntop6_impl is based on musl libc project,
+ * inet_ntop/inet_ntop.c.
+ */
+static char *inet_ntop6_impl(const unsigned char *a0, unsigned int prefix,
+	int flags)
+{
+	const unsigned char *a = a0;
+	unsigned int i, j, max, best, tmp2, border = 0;
+	char buf[100];
+	char ret[100];
+	char tmp[100];
+	char *p_ret = ret;
+	char *p_tmp = tmp;
+	size_t offset;
+
+	int isNet = !(flags & FLAG_GET_HOST);
+	int isUnused = flags & FLAG_GET_NETWORK_UNUSED;
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
+		if (isNet && i >= prefix >> 4)
+			break;
+
+		if (!isNet && i < prefix >> 4)
+			continue;
+
+		/* ':' only if no leading in host or ending in net */
+		if ((isNet && i > 0)
+			 || (!isNet && i > prefix >> 4))
+			*p_ret++ = ':';
+
+		tmp2 = 256 * a[2 * i] + a[2 * i + 1];
+
+		/*
+		 * For unused network we use
+		 * DEFAULT_IPV6_UNUSED_PART1:DEFAULT_IPV6_UNUSED_PART2 or
+		 * {DEFAULT_IPV6_UNUSED_PART1}XY:DEFAULT_IPV6_UNUSED_PART2, when there
+		 * is a collision with IP.
+		 */
+		if (isUnused) {
+			srand(time(NULL));
+			if (i == 0) {
+				tmp2 = 256*DEFAULT_IPV6_UNUSED_PART1;
+				if (a[0] == 0xfd && a[1] == 0)
+					tmp2 += (rand() % 128) + (a[1] < 128 ? 128 : 0);
+			} else
+				tmp2 = DEFAULT_IPV6_UNUSED_PART2;
+		}
+
+		offset = sprintf(p_ret, "%x", tmp2);
+		p_ret += offset;
+	}
+
+	*p_ret = '\0';
+
+	/* Find longest /(^0|:)[:0]{2,}/ */
+	for (i = best = 0, max = 2; buf[i]; i++) {
+		if (i && buf[i] != ':') continue;
+		j = strspn(buf + i, ":0");
+		if (j > max) best = i, max = j;
+	}
+
+	size_t length = strlen(ret);
+	size_t best_end = best + max - 1;
+
+	if (!isUnused && max > 2 && ((isNet && best < border) ||
+					(!isNet && best_end + 2 > border))) {
+		p_ret = ret;
+		/* Replace longest /(^0|:)[:0]{2,}/ with "::" */
+		if (isNet) {
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
+							border - best_end + 2);
+				} else
+					/* zeros start in net, ends before end */
+					memmove(p_ret, p_ret + best_end - border, length +
+							border - best_end + 1);
+			} else if (best > border && best_end == border + length) {
+				/* zeros at the end */
+				ret[best - border] = ':';
+				ret[best - border + 1] = '\0';
+			} else {
+				/* zeros somewhere in the middle */
+				ret[best - border] = ':';
+				memmove(p_ret + best - border + 1, p_ret + best_end - border,
+						length + border - best_end + 1);
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
+	return 0;
+}
+
+/*
+ * Function get_prefix use code from ipcalc project, str_to_prefix/ipcalc.c.
+ */
+static int get_prefix(const char *ipStr, int isIPv6)
+{
+	char *prefixStr = NULL;
+	int prefix, r;
+
+	prefixStr = strchr(ipStr, '/');
+	if (!prefixStr) {
+		fprintf(stderr, "Missing prefix, is that IP address? ipStr: '%s'\n",
+				ipStr);
+		exit(3);
+	}
+
+	*(prefixStr++) = '\0';
+
+	if (!isIPv6 && strchr(prefixStr, '.'))
+		prefix = ipv4_mask_to_int(prefixStr);
+	else {
+		r = safe_atoi(prefixStr, &prefix);
+		if (r != 0)
+			exit(3);
+	}
+
+	if (prefix < 0 || ((isIPv6 && prefix > 128) || (!isIPv6 && prefix > 32))) {
+		fprintf(stderr, "Bad %s prefix: %s\n", isIPv6 ? "IPv6" : "IPv4",
+				prefixStr);
+		exit(3);
+	}
+
+	if (prefix == 0 || (!isIPv6 && prefix == 32) || (isIPv6 && prefix == 128)) {
+		fprintf(stderr, "Please don't use prefix: %d for %s\n",
+				prefix, isIPv6 ? "IPv6" : "IPv4");
+		exit(3);
+	}
+
+	/* Round up prefix */
+	int basePrefix = isIPv6 ? 15 : 7;
+	prefix = (prefix + basePrefix) & ~basePrefix;
+
+	if (!isIPv6 && prefix == 32)
+		prefix = 24;
+	if (isIPv6 && prefix == 128)
+		prefix = 112;
+
+	return prefix;
+}
+
+static char *get_ipv4_host(int ip, int prefix)
+{
+	char buf[INET_ADDRSTRLEN + 1];
+	char *p_buf = buf;
+	unsigned char byte;
+
+	if (prefix < 0 || prefix > 32)
+		return NULL;
+
+	prefix &= 0x18;
+
+	for (int i = 0; i < 32; i+= 8) {
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
+static char *get_ipv4_net_rev(int ip, int prefix)
+{
+	char buf[INET_ADDRSTRLEN + 1];
+	char *p_buf = buf;
+    unsigned char byte;
+
+	if (prefix < 0 || prefix > 32)
+		return NULL;
+
+	prefix &= 0x18;
+
+	for (int i = prefix - 8; i >= 0; i-= 8) {
+
+		if (i < prefix - 8) {
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
+static char *get_ipv4_network(int ip, int prefix, int flags)
+{
+	char buf[INET_ADDRSTRLEN + 1];
+	char *p_buf = buf;
+    unsigned char byte;
+	int isUnused = flags & FLAG_GET_NETWORK_UNUSED;
+
+	if (prefix < 0 || prefix > 32)
+		return NULL;
+
+	prefix &= 0x18;
+
+	/*
+	 * For unused network we use
+	 * DEFAULT_IPV4_UNUSED_PART1:DEFAULT_IPV4_UNUSED_PART2 or
+	 * {DEFAULT_IPV4_UNUSED_PART1}.XY, when there is a collision with IP.
+	 */
+	for (int i = 0; i < 32 && i < prefix; i+= 8) {
+		if (i == 0) {
+			byte = ip & 0xff;
+			if (isUnused)
+				byte = DEFAULT_IPV4_UNUSED_PART1;
+			sprintf(p_buf, "%d", byte);
+		} else {
+			byte = (ip >> i) & 0xff;
+			if (isUnused && i > 0) {
+				if (byte == DEFAULT_IPV4_UNUSED_PART2 &&
+					((ip >> 0) & 0xff) == DEFAULT_IPV4_UNUSED_PART1) {
+					srand(time(NULL));
+					byte = (rand() % 128) + (byte < 128 ? 128 : 0);
+				} else
+					byte = DEFAULT_IPV4_UNUSED_PART2;
+			}
+			sprintf(p_buf, ".%d", byte);
+		}
+		p_buf += strlen(p_buf);
+	}
+
+	return strdup(buf);
+}
+
+/*
+ * Function bit_count is from ipcalc project, ipcalc-reverse.c.
+ */
+static char hexchar(unsigned int val)
+{
+	if (val < 10)
+		return '0' + val;
+	if (val < 16)
+		return 'a' + val - 10;
+	abort();
+}
+
+static char *get_ipv6_net_rev(struct in6_addr *ip, unsigned prefix)
+{
+	unsigned i, j = 0;
+	char str[256];
+	unsigned max = prefix/8;
+
+	if (prefix % 4 != 0)
+		return NULL;
+
+	if (prefix % 8 == 4) {
+		str[j++] = hexchar(ip->s6_addr[(prefix + 4)/8 - 1] >> 4);
+		str[j++] = '.';
+	}
+
+	for (i = 0; i < max; i++) {
+		str[j++] = hexchar(ip->s6_addr[max - 1 - i] & 0xf);
+		str[j++] = '.';
+
+		str[j++] = hexchar(ip->s6_addr[max - 1 - i] >> 4);
+		str[j++] = '.';
+	}
+	str[--j] = '\0';
+
+	return strdup(str);
+}
+
+static char *get_ipv6_host_rev(struct in6_addr *ip, unsigned prefix)
+{
+	unsigned i, j = 0;
+	char str[256];
+
+	if (prefix % 4 != 0)
+		return NULL;
+
+	for (i = 15; i >= (prefix >> 4) * 2; i--) {
+		str[j++] = hexchar(ip->s6_addr[i] & 0xf);
+		str[j++] = '.';
+
+		str[j++] = hexchar(ip->s6_addr[i] >> 4);
+		str[j++] = '.';
+	}
+	str[--j] = '\0';
+
+	return strdup(str);
+}
+
+static int get_in_addr(const char *ipStr, struct in_addr *ip)
+{
+	if (inet_pton(AF_INET, ipStr, ip) <= 0) {
+		fprintf(stderr, "Bad IPv4 address: '%s'\n", ipStr);
+		return -1;
+	}
+	return 0;
+}
+
+static int get_ipv4_info(struct in_addr *lIp, struct in_addr *rIp, int prefix)
+{
+	vars.ipv4_network = get_ipv4_network(lIp->s_addr, prefix,
+		FLAG_GET_NETWORK);
+	if (strcmp(vars.ipv4_network, get_ipv4_network(rIp->s_addr, prefix,
+			FLAG_GET_NETWORK))) {
+		fprintf(stderr, "Please use the same network for both IP addresses\n");
+		return -1;
+	}
+
+	vars.ipv4_net_rev = get_ipv4_net_rev(lIp->s_addr, prefix);
+	vars.lhost_ipv4_host = get_ipv4_host(lIp->s_addr, prefix);
+	vars.rhost_ipv4_host = get_ipv4_host(rIp->s_addr, prefix);
+	vars.ipv4_net16_unused = get_ipv4_network(lIp->s_addr, 16,
+		FLAG_GET_NETWORK_UNUSED);
+
+	return 0;
+}
+
+static int get_in6_addr(const char *ipStr, struct in6_addr *ip6)
+{
+	if (inet_pton(AF_INET6, ipStr, ip6) <= 0) {
+		fprintf(stderr, "bad IPv6 address: '%s'\n", ipStr);
+		return -1;
+	}
+	return 0;
+}
+
+static int get_ipv6_info(struct in6_addr *lIp, struct in6_addr *rIp, int prefix)
+{
+	vars.ipv6_network = inet_ntop6_impl(lIp->s6_addr, prefix, FLAG_GET_NETWORK);
+	if (strcmp(vars.ipv6_network,
+			   inet_ntop6_impl(rIp->s6_addr, prefix, FLAG_GET_NETWORK))) {
+		fprintf(stderr, "Please use the same network for both IP addresses\n");
+		return -1;
+	}
+
+	vars.ipv6_net_rev = get_ipv6_net_rev(lIp, prefix);
+	vars.lhost_ipv6_host = inet_ntop6_impl(lIp->s6_addr, prefix, FLAG_GET_HOST);
+	vars.lhost_ipv6_rev = get_ipv6_host_rev(lIp, prefix);
+	vars.rhost_ipv6_host = inet_ntop6_impl(rIp->s6_addr, prefix, FLAG_GET_HOST);
+	vars.rhost_ipv6_rev = get_ipv6_host_rev(rIp, prefix);
+	vars.ipv6_net32_unused = inet_ntop6_impl(lIp->s6_addr, 32,
+		FLAG_GET_NETWORK_UNUSED);
+
+	return 0;
+}
+
+static void print_var(const char *name, const char *val)
+{
+	if (name && val)
+		printf("export %s='%s'\n", name, val);
+}
+static void print_vars(int isIPv6)
+{
+	if (isIPv6) {
+		print_var("IPV6_NETWORK", vars.ipv6_network);
+		print_var("IPV6_NET_REV", vars.ipv6_net_rev);
+		print_var("LHOST_IPV6_HOST", vars.lhost_ipv6_host);
+		print_var("LHOST_IPV6_REV", vars.lhost_ipv6_rev);
+		print_var("RHOST_IPV6_HOST", vars.rhost_ipv6_host);
+		print_var("RHOST_IPV6_REV", vars.rhost_ipv6_rev);
+		print_var("IPV6_NET32_UNUSED", vars.ipv6_net32_unused);
+	} else {
+		print_var("IPV4_NETWORK", vars.ipv4_network);
+		print_var("IPV4_NET_REV", vars.ipv4_net_rev);
+		print_var("LHOST_IPV4_HOST", vars.lhost_ipv4_host);
+		print_var("RHOST_IPV4_HOST", vars.rhost_ipv4_host);
+		print_var("IPV4_NET16_UNUSED", vars.ipv4_net16_unused);
+	}
+}
+
+static void usage(char *name)
+{
+	fprintf(stderr, "USAGE:\n"
+		"%s IPv4/PREFIX IPv4/PREFIX\n"
+		"%s IPv6/PREFIX IPv6/PREFIX\n\n"
+		"IP addresses must be different, within the same subnet.\n"
+		"Prefixes must be the same.\n"
+		"IPv4 prefixes must be in range <1, 31>, prefix will be round up by 8.\n"
+		"IPv6 prefixes must be <1, 127>, prefix will be round up by 16.\n",
+		name, name);
+}
+
+int main(int argc, char *argv[])
+{
+	char *lIpStr = NULL, *rIpStr = NULL;
+	struct in_addr lIp, rIp;
+	struct in6_addr lIp6, rIp6;
+	int isIPv6, lprefix, rprefix;
+	int r = 0;
+
+	int isUsage = argc > 1 && (!strcmp(argv[1], "-h") ||
+		!strcmp(argv[1], "--help"));
+	if (argc < 3 || isUsage) {
+		usage(argv[0]);
+		exit(isUsage ? 0 : 1);
+	}
+
+	lIpStr = argv[1];
+	rIpStr = argv[2];
+
+	isIPv6 = !!strchr(lIpStr, ':');
+	if (isIPv6 != !(strchr(rIpStr, ':') == NULL)) {
+		fprintf(stderr, "Mixed IPv4 and IPv6 addresses");
+		exit(2);
+	}
+
+	lprefix = get_prefix(lIpStr, isIPv6);
+	rprefix = get_prefix(rIpStr, isIPv6);
+
+	if (isIPv6) {
+		if (get_in6_addr(lIpStr, &lIp6) < 0 || get_in6_addr(rIpStr, &rIp6) < 0)
+			exit(4);
+	} else {
+		if (get_in_addr(lIpStr, &lIp) < 0 || get_in_addr(rIpStr, &rIp) < 0)
+			exit(4);
+	}
+
+	if (!strcmp(lIpStr, rIpStr)) {
+		fprintf(stderr, "IP addresses cannot be the same\n");
+		exit(5);
+	}
+
+	if (lprefix != rprefix) {
+		fprintf(stderr, "Prefixes must be the same\n");
+		exit(6);
+	}
+
+	if (isIPv6)
+		r = get_ipv6_info(&lIp6, &rIp6, lprefix);
+	else
+		r = get_ipv4_info(&lIp, &rIp, lprefix);
+
+	if (r < 0)
+		exit(7);
+
+	print_vars(isIPv6);
+
+	exit(0);
+}
-- 
2.12.0

