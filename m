From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Sep 2017 09:20:30 +0200
Subject: [LTP] [PATCH v3 2/2] lib6/in6_01: Add bind() while testing
	sockaddr_in6
In-Reply-To: <20170912072030.15667-1-pvorel@suse.cz>
References: <20170912072030.15667-1-pvorel@suse.cz>
Message-ID: <20170912072030.15667-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ rewrite to use new API

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/lib6/in6_01.c | 180 ++++++++++++++++++++--------------------
 1 file changed, 91 insertions(+), 89 deletions(-)

diff --git a/testcases/network/lib6/in6_01.c b/testcases/network/lib6/in6_01.c
index 70e771357..1878f0f4f 100644
--- a/testcases/network/lib6/in6_01.c
+++ b/testcases/network/lib6/in6_01.c
@@ -1,36 +1,34 @@
 /*
+   Copyright (c) International Business Machines Corp., 2001
+ * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
  *
- *   Copyright (c) International Business Machines  Corp., 2001
- *   Author: David L Stevens
+ * Author: David L Stevens
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software Foundation,
- *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
+
 /*
- *   Description:
- *     Verify that in6 and sockaddr fields are present. Most of these are
- *     "PASS" if they just compile.
+ * Description: Verify that in6 and sockaddr fields are present.
  */
 
-#include <stdio.h>
-#include <unistd.h>
 #include <errno.h>
-
-#include <netinet/in.h>
 #include <arpa/inet.h>
+#include <netinet/in.h>
+#include <sys/socket.h>
 
-#include "test.h"
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 
 static struct {
 	char *addr;
@@ -58,43 +56,33 @@ static struct {
 
 #define SSSIZE (sizeof(sstab)/sizeof(sstab[0]))
 
-static void setup(void);
 static void test_in6_addr(void);
 static void test_sockaddr_in6(void);
 static void test_global_in6_def(void);
 static void test_in6_is_addr_v4mapped(void);
 static void test_sockaddr_storage(void);
 
-static void (*testfunc[])(void) = { test_in6_addr,
-	test_sockaddr_in6, test_global_in6_def,
-	test_in6_is_addr_v4mapped, test_sockaddr_storage };
-
-char *TCID = "in6_01";
-int TST_TOTAL = ARRAY_SIZE(testfunc);
-
-int main(int argc, char *argv[])
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++)
-			(*testfunc[i])();
-	}
-
-	tst_exit();
-}
+struct test_case {
+	void (*test)(void);
+};
+static struct test_case tcase[] = {
+	{
+		.test = test_in6_addr,
+	},
+	{
+		.test = test_sockaddr_in6,
+	},
+	{
+		.test = test_global_in6_def,
+	},
+	{
+		.test = test_in6_is_addr_v4mapped,
+	},
+	{
+		.test = test_sockaddr_storage,
+	},
+};
 
-static void setup(void)
-{
-	TEST_PAUSE;
-}
 
 /* struct in6_addr tests */
 static void test_in6_addr(void)
@@ -103,11 +91,11 @@ static void test_in6_addr(void)
 	struct in6_addr in6;
 
 	in6.s6_addr[0] = ui8;
-	tst_resm(TINFO, "type of in6.s6_addr[0] is uint8_t");
+	tst_res(TINFO, "type of in6.s6_addr[0] is uint8_t");
 	if (sizeof(in6.s6_addr) != 16)
-		tst_resm(TFAIL, "sizeof(in6.s6_addr) != 16");
+		tst_res(TFAIL, "sizeof(in6.s6_addr) != 16");
 	else
-		tst_resm(TPASS, "sizeof(in6.s6_addr) == 16");
+		tst_res(TPASS, "sizeof(in6.s6_addr) == 16");
 }
 
 /* struct sockaddr_in6 tests */
@@ -125,7 +113,12 @@ static void test_sockaddr_in6(void)
 	sin6.sin6_flowinfo = ui32;
 	sin6.sin6_addr = in6;
 	sin6.sin6_scope_id = ui32;
-	tst_resm(TPASS, "all sockaddr_in6 fields present and correct");
+
+	int sd = SAFE_SOCKET(AF_INET6, SOCK_STREAM, 0);
+	bind(sd, (struct sockaddr *)&sin6, sizeof(sin6));
+	SAFE_CLOSE(sd);
+
+	tst_res(TPASS, "all sockaddr_in6 fields present and correct");
 }
 
 /* initializers and global in6 definitions tests */
@@ -134,31 +127,33 @@ static void test_global_in6_def(void)
 	struct in6_addr ina6 = IN6ADDR_ANY_INIT;
 	struct in6_addr inl6 = IN6ADDR_LOOPBACK_INIT;
 
-	tst_resm(TINFO, "IN6ADDR_ANY_INIT present");
-	if (memcmp(&ina6, &in6addr_any, sizeof(ina6)) == 0) {
-		tst_resm(TINFO, "in6addr_any present and correct");
-	} else {
-		tst_resm(TFAIL, "in6addr_any incorrect value");
+	tst_res(TINFO, "IN6ADDR_ANY_INIT present");
+	if (memcmp(&ina6, &in6addr_any, sizeof(ina6)) == 0)
+		tst_res(TINFO, "in6addr_any present and correct");
+	else {
+		tst_res(TFAIL, "in6addr_any incorrect value");
 		return;
 	}
 
-	tst_resm(TINFO, "IN6ADDR_LOOPBACK_INIT present");
-	if (memcmp(&inl6, &in6addr_loopback, sizeof(inl6)) == 0) {
-		tst_resm(TINFO, "in6addr_loopback present and correct");
-	} else {
-		tst_resm(TFAIL, "in6addr_loopback incorrect value");
+	tst_res(TINFO, "IN6ADDR_LOOPBACK_INIT present");
+	if (memcmp(&inl6, &in6addr_loopback, sizeof(inl6)) == 0)
+		tst_res(TINFO, "in6addr_loopback present and correct");
+	else {
+		tst_res(TFAIL, "in6addr_loopback incorrect value");
 		return;
 	}
+
 	if (inet_pton(AF_INET6, "::1", &inl6) <= 0)
-		tst_brkm(TBROK | TERRNO, NULL, "inet_pton(\"::1\")");
-	if (memcmp(&inl6, &in6addr_loopback, sizeof(inl6)) == 0) {
-		tst_resm(TINFO, "in6addr_loopback in network byte order");
-	} else {
-		tst_resm(TFAIL, "in6addr_loopback has wrong byte order");
+		tst_brk(TBROK | TERRNO, "inet_pton(\"::1\")");
+
+	if (memcmp(&inl6, &in6addr_loopback, sizeof(inl6)) == 0)
+		tst_res(TINFO, "in6addr_loopback in network byte order");
+	else {
+		tst_res(TFAIL, "in6addr_loopback has wrong byte order");
 		return;
 	}
 
-	tst_resm(TPASS, "global in6 definitions tests succeed");
+	tst_res(TPASS, "global in6 definitions tests succeed");
 }
 
 /* IN6_IS_ADDR_V4MAPPED tests */
@@ -168,23 +163,22 @@ static void test_in6_is_addr_v4mapped(void)
 	struct in6_addr in6;
 
 	for (i = 0; i < MAPSIZE; ++i) {
-		if (inet_pton(AF_INET6, maptab[i].addr, &in6) <= 0) {
-			tst_brkm(TBROK | TERRNO, NULL,
+		if (inet_pton(AF_INET6, maptab[i].addr, &in6) <= 0)
+			tst_brk(TBROK | TERRNO,
 				"\"%s\" is not a valid IPv6 address",
 				maptab[i].addr);
-		}
 		TEST(IN6_IS_ADDR_V4MAPPED(in6.s6_addr));
-		if (TEST_RETURN == maptab[i].ismap) {
-			tst_resm(TINFO, "IN6_IS_ADDR_V4MAPPED(\"%s\") %ld",
+		if (TEST_RETURN == maptab[i].ismap)
+			tst_res(TINFO, "IN6_IS_ADDR_V4MAPPED(\"%s\") %ld",
 				maptab[i].addr, TEST_RETURN);
-		} else {
-			tst_resm(TFAIL, "IN6_IS_ADDR_V4MAPPED(\"%s\") %ld",
+		else {
+			tst_res(TFAIL, "IN6_IS_ADDR_V4MAPPED(\"%s\") %ld",
 				maptab[i].addr, TEST_RETURN);
 			return;
 		}
 	}
 
-	tst_resm(TPASS, "IN6_IS_ADDR_V4MAPPED tests succeed");
+	tst_res(TPASS, "IN6_IS_ADDR_V4MAPPED tests succeed");
 }
 
 /* sockaddr_storage tests */
@@ -195,7 +189,7 @@ static void test_sockaddr_storage(void)
 
 	if (sizeof(ss) <= sizeof(struct sockaddr_in) ||
 		sizeof(ss) <= sizeof(struct sockaddr_in6))
-		tst_brkm(TBROK, NULL, "sockaddr_storage too small");
+		tst_brk(TBROK, "sockaddr_storage too small");
 
 	for (i = 0; i < SSSIZE; ++i) {
 		struct sockaddr_in *psin = (struct sockaddr_in *)&ss;
@@ -210,18 +204,26 @@ static void test_sockaddr_storage(void)
 			rv = inet_pton(AF_INET6, sstab[i].addr,
 				&psin6->sin6_addr);
 		}
-		if (rv <= 0) {
-			tst_brkm(TBROK, NULL,
+		if (rv <= 0)
+			tst_brk(TBROK,
 				"\"%s\" is not a valid address", sstab[i].addr);
-		}
-		if (ss.ss_family == af) {
-			tst_resm(TINFO, "\"%s\" is AF_INET%s",
+		if (ss.ss_family == af)
+			tst_res(TINFO, "\"%s\" is AF_INET%s",
 				sstab[i].addr, af == AF_INET ? "" : "6");
-		} else {
-			tst_resm(TFAIL, "\"%s\" ss_family (%d) != AF_INET%s",
+		else
+			tst_res(TFAIL, "\"%s\" ss_family (%d) != AF_INET%s",
 				sstab[i].addr, af, af == AF_INET ? "" : "6");
-		}
 	}
 
-	tst_resm(TPASS, "sockaddr_storage tests succeed");
+	tst_res(TPASS, "sockaddr_storage tests succeed");
 }
+
+static void do_test(unsigned int i)
+{
+	tcase[i].test();
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcase),
+	.test = do_test,
+};
-- 
2.14.1

