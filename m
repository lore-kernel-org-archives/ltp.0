From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 Jan 2019 17:17:34 +0100
Subject: [LTP] [RFC PATCH 1/2] tst_net: Add missing includes,
	make functions inline
In-Reply-To: <20190124161735.19609-1-pvorel@suse.cz>
References: <20190124161735.19609-1-pvorel@suse.cz>
Message-ID: <20190124161735.19609-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_net.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/tst_net.h b/include/tst_net.h
index cb97b7b61..c943fd4c2 100644
--- a/include/tst_net.h
+++ b/include/tst_net.h
@@ -17,6 +17,8 @@
 
 #include <arpa/inet.h>
 #include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
 
 #define MAX_IPV4_PREFIX 32
 #define MAX_IPV6_PREFIX 128
@@ -45,7 +47,7 @@ static inline void print_svar_change(const char *name, const char *val)
 /*
  * Function bit_count is from ipcalc project, ipcalc.c.
  */
-static int bit_count(uint32_t i)
+static inline int bit_count(uint32_t i)
 {
 	int c = 0;
 	unsigned int seen_one = 0;
@@ -67,7 +69,7 @@ static int bit_count(uint32_t i)
 /*
  * Function mask2prefix is from ipcalc project, ipcalc.c.
  */
-static int mask2prefix(struct in_addr mask)
+static inline int mask2prefix(struct in_addr mask)
 {
 	return bit_count(ntohl(mask.s_addr));
 }
@@ -75,7 +77,7 @@ static int mask2prefix(struct in_addr mask)
 /*
  * Function ipv4_mask_to_int is from ipcalc project, ipcalc.c.
  */
-static int ipv4_mask_to_int(const char *prefix)
+static inline int ipv4_mask_to_int(const char *prefix)
 {
 	int ret;
 	struct in_addr in;
@@ -90,7 +92,7 @@ static int ipv4_mask_to_int(const char *prefix)
 /*
  * Function safe_atoi is from ipcalc project, ipcalc.c.
  */
-static int safe_atoi(const char *s, int *ret_i)
+static inline int safe_atoi(const char *s, int *ret_i)
 {
 	char *x = NULL;
 	long l;
@@ -112,7 +114,7 @@ static int safe_atoi(const char *s, int *ret_i)
 /*
  * Function get_prefix use code from ipcalc project, str_to_prefix/ipcalc.c.
  */
-static int get_prefix(const char *ip_str, int is_ipv6)
+static inline int get_prefix(const char *ip_str, int is_ipv6)
 {
 	char *prefix_str = NULL;
 	int prefix = -1, r;
@@ -140,13 +142,13 @@ static int get_prefix(const char *ip_str, int is_ipv6)
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
2.19.2

