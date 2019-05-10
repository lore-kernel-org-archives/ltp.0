From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 May 2019 20:31:31 +0200
Subject: [LTP] [RFC PATCH v2 5/6] net: Move setup_addrinfo() from
	netstress.c into tst_net.h
In-Reply-To: <20190510183132.31039-1-pvorel@suse.cz>
References: <20190510183132.31039-1-pvorel@suse.cz>
Message-ID: <20190510183132.31039-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This allows reusing it in next commit.

Add missing includes into tst_net.h, make functions inline.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Maybe tst_net.c would be better than inline functions.
tst_net.h requires tst_test.h be loaded first.

 include/tst_net.h                       | 45 +++++++++++++------------
 testcases/network/netstress/netstress.c | 14 +-------
 2 files changed, 25 insertions(+), 34 deletions(-)

diff --git a/include/tst_net.h b/include/tst_net.h
index cb97b7b61..ad067d8c6 100644
--- a/include/tst_net.h
+++ b/include/tst_net.h
@@ -1,22 +1,12 @@
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
 #include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
 
 #define MAX_IPV4_PREFIX 32
 #define MAX_IPV6_PREFIX 128
@@ -45,7 +35,7 @@ static inline void print_svar_change(const char *name, const char *val)
 /*
  * Function bit_count is from ipcalc project, ipcalc.c.
  */
-static int bit_count(uint32_t i)
+static inline int bit_count(uint32_t i)
 {
 	int c = 0;
 	unsigned int seen_one = 0;
@@ -67,7 +57,7 @@ static int bit_count(uint32_t i)
 /*
  * Function mask2prefix is from ipcalc project, ipcalc.c.
  */
-static int mask2prefix(struct in_addr mask)
+static inline int mask2prefix(struct in_addr mask)
 {
 	return bit_count(ntohl(mask.s_addr));
 }
@@ -75,7 +65,7 @@ static int mask2prefix(struct in_addr mask)
 /*
  * Function ipv4_mask_to_int is from ipcalc project, ipcalc.c.
  */
-static int ipv4_mask_to_int(const char *prefix)
+static inline int ipv4_mask_to_int(const char *prefix)
 {
 	int ret;
 	struct in_addr in;
@@ -90,7 +80,7 @@ static int ipv4_mask_to_int(const char *prefix)
 /*
  * Function safe_atoi is from ipcalc project, ipcalc.c.
  */
-static int safe_atoi(const char *s, int *ret_i)
+static inline int safe_atoi(const char *s, int *ret_i)
 {
 	char *x = NULL;
 	long l;
@@ -112,7 +102,7 @@ static int safe_atoi(const char *s, int *ret_i)
 /*
  * Function get_prefix use code from ipcalc project, str_to_prefix/ipcalc.c.
  */
-static int get_prefix(const char *ip_str, int is_ipv6)
+static inline int get_prefix(const char *ip_str, int is_ipv6)
 {
 	char *prefix_str = NULL;
 	int prefix = -1, r;
@@ -140,14 +130,27 @@ static int get_prefix(const char *ip_str, int is_ipv6)
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
 }
+
+static inline void setup_addrinfo(const char *src_addr, const char *port,
+			   const struct addrinfo *hints,
+			   struct addrinfo **addr_info)
+{
+	int err = getaddrinfo(src_addr, port, hints, addr_info);
+
+	if (err)
+		tst_brk(TBROK, "getaddrinfo failed, %s", gai_strerror(err));
+
+	if (!*addr_info)
+		tst_brk(TBROK, "failed to get the address");
+}
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 06882b1b3..5001f206a 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -43,6 +43,7 @@
 #include "tst_safe_stdio.h"
 #include "tst_safe_pthread.h"
 #include "tst_test.h"
+#include "tst_net.h"
 
 static const int max_msg_len = (1 << 16) - 1;
 static const int min_msg_len = 5;
@@ -455,19 +456,6 @@ static int parse_client_request(const char *msg)
 static struct timespec tv_client_start;
 static struct timespec tv_client_end;
 
-static void setup_addrinfo(const char *src_addr, const char *port,
-			   const struct addrinfo *hints,
-			   struct addrinfo **addr_info)
-{
-	int err = getaddrinfo(src_addr, port, hints, addr_info);
-
-	if (err)
-		tst_brk(TBROK, "getaddrinfo failed, %s", gai_strerror(err));
-
-	if (!*addr_info)
-		tst_brk(TBROK, "failed to get the address");
-}
-
 static void client_init(void)
 {
 	if (clients_num >= MAX_THREADS) {
-- 
2.21.0

