From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 20 Mar 2020 11:25:09 +0100
Subject: [LTP] [PATCH v5 1/3] Create separate .c file for include/tst_net.h
Message-ID: <20200320102511.20568-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- new patch

Changes since v2:
- Also separate print_svar*()
- Added tst_ prefix to functions separated into tst_net.c

Changes since v3:
- Split off tst_private.h from tst_net.h
- Make some helper functions in tst_net.c static

Changes since v4:
- Licence and #include cleanup

 include/tst_net.h                    | 139 +--------------------------
 include/tst_private.h                |  31 ++++++
 lib/tst_net.c                        | 135 ++++++++++++++++++++++++++
 testcases/lib/tst_net_iface_prefix.c |  10 +-
 testcases/lib/tst_net_ip_prefix.c    |  11 ++-
 testcases/lib/tst_net_vars.c         |  65 +++++++------
 6 files changed, 213 insertions(+), 178 deletions(-)
 create mode 100644 include/tst_private.h
 create mode 100644 lib/tst_net.c

diff --git a/include/tst_net.h b/include/tst_net.h
index e1edc7200..e2100f641 100644
--- a/include/tst_net.h
+++ b/include/tst_net.h
@@ -4,141 +4,6 @@
  */
 
 #include <arpa/inet.h>
-#include <errno.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
 
-#define MAX_IPV4_PREFIX 32
-#define MAX_IPV6_PREFIX 128
-
-#define tst_res_comment(...) { \
-	fprintf(stderr, "# "); \
-	tst_res(__VA_ARGS__); } \
-
-
-#define tst_brk_comment(...) { \
-	fprintf(stderr, "# "); \
-	tst_brk(TCONF, __VA_ARGS__); } \
-
-static inline void print_svar(const char *name, const char *val)
-{
-	if (name && val)
-		printf("export %s=\"%s\"\n", name, val);
-}
-
-static inline void print_svar_change(const char *name, const char *val)
-{
-	if (name && val)
-		printf("export %s=\"${%s:-%s}\"\n", name, name, val);
-}
-
-/*
- * Function bit_count is from ipcalc project, ipcalc.c.
- */
-static inline int bit_count(uint32_t i)
-{
-	int c = 0;
-	unsigned int seen_one = 0;
-
-	while (i > 0) {
-		if (i & 1) {
-			seen_one = 1;
-			c++;
-		} else {
-			if (seen_one)
-				return -1;
-		}
-		i >>= 1;
-	}
-
-	return c;
-}
-
-/*
- * Function mask2prefix is from ipcalc project, ipcalc.c.
- */
-static inline int mask2prefix(struct in_addr mask)
-{
-	return bit_count(ntohl(mask.s_addr));
-}
-
-/*
- * Function ipv4_mask_to_int is from ipcalc project, ipcalc.c.
- */
-static inline int ipv4_mask_to_int(const char *prefix)
-{
-	int ret;
-	struct in_addr in;
-
-	ret = inet_pton(AF_INET, prefix, &in);
-	if (ret == 0)
-		return -1;
-
-	return mask2prefix(in);
-}
-
-/*
- * Function safe_atoi is from ipcalc project, ipcalc.c.
- */
-static inline int safe_atoi(const char *s, int *ret_i)
-{
-	char *x = NULL;
-	long l;
-
-	errno = 0;
-	l = strtol(s, &x, 0);
-
-	if (!x || x == s || *x || errno)
-		return errno > 0 ? -errno : -EINVAL;
-
-	if ((long)(int)l != l)
-		return -ERANGE;
-
-	*ret_i = (int)l;
-
-	return 0;
-}
-
-/*
- * Function get_prefix use code from ipcalc project, str_to_prefix/ipcalc.c.
- */
-static inline int get_prefix(const char *ip_str, int is_ipv6)
-{
-	char *prefix_str = NULL;
-	int prefix = -1, r;
-
-	prefix_str = strchr(ip_str, '/');
-	if (!prefix_str)
-		return -1;
-
-	*(prefix_str++) = '\0';
-
-	if (!is_ipv6 && strchr(prefix_str, '.'))
-		prefix = ipv4_mask_to_int(prefix_str);
-	else {
-		r = safe_atoi(prefix_str, &prefix);
-		if (r != 0)
-			tst_brk_comment("conversion error: '%s' is not integer",
-					prefix_str);
-	}
-
-	if (prefix < 0 || ((is_ipv6 && prefix > MAX_IPV6_PREFIX) ||
-		(!is_ipv6 && prefix > MAX_IPV4_PREFIX)))
-		tst_brk_comment("bad %s prefix: %s", is_ipv6 ?  "IPv6" : "IPv4",
-				prefix_str);
-
-	return prefix;
-}
-
-static inline void get_in_addr(const char *ip_str, struct in_addr *ip)
-{
-	if (inet_pton(AF_INET, ip_str, ip) <= 0)
-		tst_brk_comment("bad IPv4 address: '%s'", ip_str);
-}
-
-static inline void get_in6_addr(const char *ip_str, struct in6_addr *ip6)
-{
-	if (inet_pton(AF_INET6, ip_str, ip6) <= 0)
-		tst_brk_comment("bad IPv6 address: '%s'", ip_str);
-}
+void tst_get_in_addr(const char *ip_str, struct in_addr *ip);
+void tst_get_in6_addr(const char *ip_str, struct in6_addr *ip6);
diff --git a/include/tst_private.h b/include/tst_private.h
new file mode 100644
index 000000000..00cd17fce
--- /dev/null
+++ b/include/tst_private.h
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2017-2019 Petr Vorel <pvorel@suse.cz>
+ *
+ * Internal helper functions for the shell library. Do not use directly
+ * in test programs.
+ */
+
+#ifndef TST_PRIVATE_H_
+#define TST_PRIVATE_H_
+
+#include <stdio.h>
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
+void tst_print_svar(const char *name, const char *val);
+void tst_print_svar_change(const char *name, const char *val);
+
+int tst_get_prefix(const char *ip_str, int is_ipv6);
+
+#endif
diff --git a/lib/tst_net.c b/lib/tst_net.c
new file mode 100644
index 000000000..6913c7b40
--- /dev/null
+++ b/lib/tst_net.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2017-2019 Petr Vorel <pvorel@suse.cz>
+ */
+
+#include <errno.h>
+#include <string.h>
+#include <stdlib.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_net.h"
+#include "tst_private.h"
+
+void tst_print_svar(const char *name, const char *val)
+{
+	if (name && val)
+		printf("export %s=\"%s\"\n", name, val);
+}
+
+void tst_print_svar_change(const char *name, const char *val)
+{
+	if (name && val)
+		printf("export %s=\"${%s:-%s}\"\n", name, name, val);
+}
+
+/*
+ * Function bit_count is from ipcalc project, ipcalc.c.
+ */
+static int tst_bit_count(uint32_t i)
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
+static int tst_mask2prefix(struct in_addr mask)
+{
+	return tst_bit_count(ntohl(mask.s_addr));
+}
+
+/*
+ * Function ipv4_mask_to_int is from ipcalc project, ipcalc.c.
+ */
+static int tst_ipv4_mask_to_int(const char *prefix)
+{
+	int ret;
+	struct in_addr in;
+
+	ret = inet_pton(AF_INET, prefix, &in);
+	if (ret == 0)
+		return -1;
+
+	return tst_mask2prefix(in);
+}
+
+/*
+ * Function safe_atoi is from ipcalc project, ipcalc.c.
+ */
+static int tst_safe_atoi(const char *s, int *ret_i)
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
+int tst_get_prefix(const char *ip_str, int is_ipv6)
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
+		prefix = tst_ipv4_mask_to_int(prefix_str);
+	else {
+		r = tst_safe_atoi(prefix_str, &prefix);
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
+void tst_get_in_addr(const char *ip_str, struct in_addr *ip)
+{
+	if (inet_pton(AF_INET, ip_str, ip) <= 0)
+		tst_brk_comment("bad IPv4 address: '%s'", ip_str);
+}
+
+void tst_get_in6_addr(const char *ip_str, struct in6_addr *ip6)
+{
+	if (inet_pton(AF_INET6, ip_str, ip6) <= 0)
+		tst_brk_comment("bad IPv6 address: '%s'", ip_str);
+}
diff --git a/testcases/lib/tst_net_iface_prefix.c b/testcases/lib/tst_net_iface_prefix.c
index a40a8edc2..4b024872d 100644
--- a/testcases/lib/tst_net_iface_prefix.c
+++ b/testcases/lib/tst_net_iface_prefix.c
@@ -13,6 +13,7 @@
 #include "tst_test.h"
 
 #include "tst_net.h"
+#include "tst_private.h"
 
 static char *iface;
 static int prefix;
@@ -124,7 +125,7 @@ int main(int argc, char *argv[])
 
 	prefix_str = strchr(ip_str, '/');
 	if (prefix_str) {
-		prefix = get_prefix(ip_str, is_ipv6);
+		prefix = tst_get_prefix(ip_str, is_ipv6);
 		tst_res_comment(TINFO,
 			"IP address '%s' contains prefix %d, using it and don't search for iface.\n",
 			ip_str, prefix);
@@ -136,11 +137,12 @@ int main(int argc, char *argv[])
 
 	/* checks for validity of IP string */
 	if (is_ipv6)
-		get_in6_addr(ip_str, &ip6);
+		tst_get_in6_addr(ip_str, &ip6);
 	else
-		get_in_addr(ip_str, &ip);
+		tst_get_in_addr(ip_str, &ip);
 
-	print_svar_change(is_rhost ? "RHOST_IFACES" : "LHOST_IFACES", iface);
+	tst_print_svar_change(is_rhost ? "RHOST_IFACES" : "LHOST_IFACES",
+		iface);
 	if (is_ipv6)
 		print_ivar(is_rhost ? "IPV6_RPREFIX" : "IPV6_LPREFIX", prefix);
 	else
diff --git a/testcases/lib/tst_net_ip_prefix.c b/testcases/lib/tst_net_ip_prefix.c
index 2ac06e724..59c70ba7d 100644
--- a/testcases/lib/tst_net_ip_prefix.c
+++ b/testcases/lib/tst_net_ip_prefix.c
@@ -10,6 +10,7 @@
 #include "tst_test.h"
 
 #include "tst_net.h"
+#include "tst_private.h"
 
 #define DEFAULT_IPV4_PREFIX 24
 #define DEFAULT_IPV6_PREFIX 64
@@ -67,22 +68,22 @@ int main(int argc, char *argv[])
 	prefix_str = strchr(ip_str, '/');
 
 	if (prefix_str)
-		prefix = get_prefix(ip_str, is_ipv6);
+		prefix = tst_get_prefix(ip_str, is_ipv6);
 	else
 		prefix = is_ipv6 ? DEFAULT_IPV6_PREFIX : DEFAULT_IPV4_PREFIX;
 
 	/* checks for validity of IP string */
 	if (is_ipv6)
-		get_in6_addr(ip_str, &ip6);
+		tst_get_in6_addr(ip_str, &ip6);
 	else
-		get_in_addr(ip_str, &ip);
+		tst_get_in_addr(ip_str, &ip);
 
 	if (is_ipv6) {
 		print_ivar(is_rhost ? "IPV6_RPREFIX" : "IPV6_LPREFIX", prefix);
-		print_svar(is_rhost ? "IPV6_RHOST" : "IPV6_LHOST", ip_str);
+		tst_print_svar(is_rhost ? "IPV6_RHOST" : "IPV6_LHOST", ip_str);
 	} else {
 		print_ivar(is_rhost ? "IPV4_RPREFIX" : "IPV4_LPREFIX", prefix);
-		print_svar(is_rhost ? "IPV4_RHOST" : "IPV4_LHOST", ip_str);
+		tst_print_svar(is_rhost ? "IPV4_RHOST" : "IPV4_LHOST", ip_str);
 	}
 
 	exit(EXIT_SUCCESS);
diff --git a/testcases/lib/tst_net_vars.c b/testcases/lib/tst_net_vars.c
index 7c5507ed7..e7bf0e56a 100644
--- a/testcases/lib/tst_net_vars.c
+++ b/testcases/lib/tst_net_vars.c
@@ -22,6 +22,7 @@
 #include "tst_test.h"
 
 #include "tst_net.h"
+#include "tst_private.h"
 
 #define BASE_IPV4_PREFIX 8
 #define BASE_IPV6_PREFIX 16
@@ -217,7 +218,7 @@ static char *get_ipv4_net16_unused(const struct in_addr *ip,
 			DEFAULT_IPV4_UNUSED_PART2);
 	sprintf(buf, "%s.0.0", net_unused);
 
-	get_in_addr(buf, &network);
+	tst_get_in_addr(buf, &network);
 
 	if (!is_in_subnet_ipv4(ip, &mask, &network))
 		return strdup(net_unused);
@@ -229,7 +230,7 @@ static char *get_ipv4_net16_unused(const struct in_addr *ip,
 		(rand() % 128) + (((ip->s_addr >> 8) & 0xff) < 128 ? 128 : 0));
 	sprintf(buf, "%s.0.0", net_unused);
 
-	get_in_addr(buf, &network);
+	tst_get_in_addr(buf, &network);
 
 	if (!is_in_subnet_ipv4(ip, &mask, &network))
 		return strdup(net_unused);
@@ -239,7 +240,7 @@ static char *get_ipv4_net16_unused(const struct in_addr *ip,
 			< 128 ? 128 : 0), DEFAULT_IPV4_UNUSED_PART2);
 	sprintf(buf, "%s.0.0", net_unused);
 
-	get_in_addr(buf, &network);
+	tst_get_in_addr(buf, &network);
 
 	if (!is_in_subnet_ipv4(ip, &mask, &network))
 		return strdup(net_unused);
@@ -281,7 +282,7 @@ static char *get_ipv6_net32_unused(const struct in6_addr *ip6,
 			DEFAULT_IPV6_UNUSED_PART2);
 	sprintf(buf, "%s::", net_unused);
 
-	get_in6_addr(buf, &network);
+	tst_get_in6_addr(buf, &network);
 
 	if (!is_in_subnet_ipv6(ip6, &mask, &network))
 		return strdup(net_unused);
@@ -294,7 +295,7 @@ static char *get_ipv6_net32_unused(const struct in6_addr *ip6,
 			DEFAULT_IPV6_UNUSED_PART2);
 	sprintf(buf, "%s::", net_unused);
 
-	get_in6_addr(buf, &network);
+	tst_get_in6_addr(buf, &network);
 
 	if (!is_in_subnet_ipv6(ip6, &mask, &network))
 		return strdup(net_unused);
@@ -305,7 +306,7 @@ static char *get_ipv6_net32_unused(const struct in6_addr *ip6,
 			128 : 0), DEFAULT_IPV6_UNUSED_PART2);
 	sprintf(buf, "%s::", net_unused);
 
-	get_in6_addr(buf, &network);
+	tst_get_in6_addr(buf, &network);
 
 	if (!is_in_subnet_ipv6(ip6, &mask, &network))
 		return strdup(net_unused);
@@ -503,8 +504,8 @@ static void get_ipv4_info(const char *lip_str, const char *rip_str, int lprefix,
 	lprefix_round = round_down_prefix(lprefix, 0);
 	rprefix_round = round_down_prefix(rprefix, 0);
 
-	get_in_addr(lip_str, &lip);
-	get_in_addr(rip_str, &rip);
+	tst_get_in_addr(lip_str, &lip);
+	tst_get_in_addr(rip_str, &rip);
 
 	vars.ipv4_lbroadcast = get_ipv4_broadcast(lip, lprefix);
 	vars.ipv4_rbroadcast = get_ipv4_broadcast(rip, rprefix);
@@ -530,8 +531,8 @@ static void get_ipv6_info(const char *lip_str, const char *rip_str,
 	lprefix_round = round_down_prefix(lprefix, 1);
 	rprefix_round = round_down_prefix(rprefix, 1);
 
-	get_in6_addr(lip_str, &lip);
-	get_in6_addr(rip_str, &rip);
+	tst_get_in6_addr(lip_str, &lip);
+	tst_get_in6_addr(rip_str, &rip);
 
 	vars.ipv6_lnetmask = get_ipv6_netmask(lprefix);
 	vars.ipv6_rnetmask = get_ipv6_netmask(rprefix);
@@ -548,23 +549,23 @@ static void get_ipv6_info(const char *lip_str, const char *rip_str,
 static void print_vars(int is_ipv6)
 {
 	if (is_ipv6) {
-		print_svar("IPV6_LNETMASK", vars.ipv6_lnetmask);
-		print_svar_change("IPV6_RNETMASK", vars.ipv6_rnetmask);
-		print_svar("IPV6_LNETWORK", vars.ipv6_lnetwork);
-		print_svar("IPV6_RNETWORK", vars.ipv6_rnetwork);
-		print_svar("LHOST_IPV6_HOST", vars.lhost_ipv6_host);
-		print_svar("RHOST_IPV6_HOST", vars.rhost_ipv6_host);
-		print_svar("IPV6_NET32_UNUSED", vars.ipv6_net32_unused);
+		tst_print_svar("IPV6_LNETMASK", vars.ipv6_lnetmask);
+		tst_print_svar_change("IPV6_RNETMASK", vars.ipv6_rnetmask);
+		tst_print_svar("IPV6_LNETWORK", vars.ipv6_lnetwork);
+		tst_print_svar("IPV6_RNETWORK", vars.ipv6_rnetwork);
+		tst_print_svar("LHOST_IPV6_HOST", vars.lhost_ipv6_host);
+		tst_print_svar("RHOST_IPV6_HOST", vars.rhost_ipv6_host);
+		tst_print_svar("IPV6_NET32_UNUSED", vars.ipv6_net32_unused);
 	} else {
-		print_svar("IPV4_LBROADCAST", vars.ipv4_lbroadcast);
-		print_svar_change("IPV4_RBROADCAST", vars.ipv4_rbroadcast);
-		print_svar("IPV4_LNETMASK", vars.ipv4_lnetmask);
-		print_svar_change("IPV4_RNETMASK", vars.ipv4_rnetmask);
-		print_svar("IPV4_LNETWORK", vars.ipv4_lnetwork);
-		print_svar("IPV4_RNETWORK", vars.ipv4_rnetwork);
-		print_svar("LHOST_IPV4_HOST", vars.lhost_ipv4_host);
-		print_svar("RHOST_IPV4_HOST", vars.rhost_ipv4_host);
-		print_svar("IPV4_NET16_UNUSED", vars.ipv4_net16_unused);
+		tst_print_svar("IPV4_LBROADCAST", vars.ipv4_lbroadcast);
+		tst_print_svar_change("IPV4_RBROADCAST", vars.ipv4_rbroadcast);
+		tst_print_svar("IPV4_LNETMASK", vars.ipv4_lnetmask);
+		tst_print_svar_change("IPV4_RNETMASK", vars.ipv4_rnetmask);
+		tst_print_svar("IPV4_LNETWORK", vars.ipv4_lnetwork);
+		tst_print_svar("IPV4_RNETWORK", vars.ipv4_rnetwork);
+		tst_print_svar("LHOST_IPV4_HOST", vars.lhost_ipv4_host);
+		tst_print_svar("RHOST_IPV4_HOST", vars.rhost_ipv4_host);
+		tst_print_svar("IPV4_NET16_UNUSED", vars.ipv4_net16_unused);
 	}
 }
 
@@ -586,19 +587,19 @@ int main(int argc, char *argv[])
 	rip_str = argv[2];
 
 	is_ipv6 = !!strchr(lip_str, ':');
-	lprefix = get_prefix(lip_str, is_ipv6);
-	rprefix = get_prefix(rip_str, is_ipv6);
+	lprefix = tst_get_prefix(lip_str, is_ipv6);
+	rprefix = tst_get_prefix(rip_str, is_ipv6);
 
 	if (is_ipv6)
-		get_in6_addr(lip_str, &ip6);
+		tst_get_in6_addr(lip_str, &ip6);
 	else
-		get_in_addr(lip_str, &ip);
+		tst_get_in_addr(lip_str, &ip);
 
 	tmp = !!strchr(rip_str, ':');
 	if (tmp)
-		get_in6_addr(rip_str, &ip6);
+		tst_get_in6_addr(rip_str, &ip6);
 	else
-		get_in_addr(rip_str, &ip);
+		tst_get_in_addr(rip_str, &ip);
 
 	if (is_ipv6 != tmp)
 		tst_brk_comment("mixed IPv4 and IPv6 addresses ('%s', '%s')",
-- 
2.25.1

