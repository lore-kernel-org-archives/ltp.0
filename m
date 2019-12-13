From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Dec 2019 16:43:01 +0100
Subject: [LTP] [PATCH 1/1] net/tst_net.h: make functions inline
Message-ID: <20191213154301.9084-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ use SPDX.

This allows reusing header in next commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

this is the commit which is needed to be before Martin's rewrite
test_1_to_1_initmsg_connect.c
https://patchwork.ozlabs.org/patch/1200997/

I have it prepared for route C netlink tests, so adding it here.

Kind regards,
Petr

 include/tst_net.h | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/include/tst_net.h b/include/tst_net.h
index cb97b7b61..a5263414f 100644
--- a/include/tst_net.h
+++ b/include/tst_net.h
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (c) 2017-2019 Petr Vorel <pvorel@suse.cz>
  */
 
 #include <arpa/inet.h>
@@ -45,7 +33,7 @@ static inline void print_svar_change(const char *name, const char *val)
 /*
  * Function bit_count is from ipcalc project, ipcalc.c.
  */
-static int bit_count(uint32_t i)
+static inline int bit_count(uint32_t i)
 {
 	int c = 0;
 	unsigned int seen_one = 0;
@@ -67,7 +55,7 @@ static int bit_count(uint32_t i)
 /*
  * Function mask2prefix is from ipcalc project, ipcalc.c.
  */
-static int mask2prefix(struct in_addr mask)
+static inline int mask2prefix(struct in_addr mask)
 {
 	return bit_count(ntohl(mask.s_addr));
 }
@@ -75,7 +63,7 @@ static int mask2prefix(struct in_addr mask)
 /*
  * Function ipv4_mask_to_int is from ipcalc project, ipcalc.c.
  */
-static int ipv4_mask_to_int(const char *prefix)
+static inline int ipv4_mask_to_int(const char *prefix)
 {
 	int ret;
 	struct in_addr in;
@@ -90,7 +78,7 @@ static int ipv4_mask_to_int(const char *prefix)
 /*
  * Function safe_atoi is from ipcalc project, ipcalc.c.
  */
-static int safe_atoi(const char *s, int *ret_i)
+static inline int safe_atoi(const char *s, int *ret_i)
 {
 	char *x = NULL;
 	long l;
@@ -112,7 +100,7 @@ static int safe_atoi(const char *s, int *ret_i)
 /*
  * Function get_prefix use code from ipcalc project, str_to_prefix/ipcalc.c.
  */
-static int get_prefix(const char *ip_str, int is_ipv6)
+static inline int get_prefix(const char *ip_str, int is_ipv6)
 {
 	char *prefix_str = NULL;
 	int prefix = -1, r;
@@ -140,13 +128,13 @@ static int get_prefix(const char *ip_str, int is_ipv6)
 	return prefix;
 }
 
-static void get_in_addr(const char *ip_str, struct in_addr *ip)
+static inline void get_in_addr(const char *ip_str, struct in_addr *ip)
 {
 	if (inet_pton(AF_INET, ip_str, ip) <= 0)
 		tst_brk_comment("bad IPv4 address: '%s'", ip_str);
 }
 
-static void get_in6_addr(const char *ip_str, struct in6_addr *ip6)
+static inline void get_in6_addr(const char *ip_str, struct in6_addr *ip6)
 {
 	if (inet_pton(AF_INET6, ip_str, ip6) <= 0)
 		tst_brk_comment("bad IPv6 address: '%s'", ip_str);
-- 
2.24.0

