Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1YUtB7-0006r6-0K
	for ltp-list@lists.sourceforge.net; Mon, 09 Mar 2015 08:36:45 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YUtAz-0002yz-0m
	for ltp-list@lists.sourceforge.net; Mon, 09 Mar 2015 08:36:38 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t298ZZQ4028274
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Mar 2015 16:35:35 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Mon, 9 Mar 2015 16:32:00 +0800
Message-ID: <1425889922-13650-5-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1425889922-13650-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1425889922-13650-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 5/7] lib6/in6_01.c: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

* Remove useless comments.

* Move the test body from main() to (*testfunc[])().

* In every test function, using TINFO instead of TPASS
  marks the success of each inner test.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/network/lib6/in6_01.c | 233 +++++++++++++++++++++++-----------------
 1 file changed, 134 insertions(+), 99 deletions(-)

diff --git a/testcases/network/lib6/in6_01.c b/testcases/network/lib6/in6_01.c
index d7a499b..027e287 100644
--- a/testcases/network/lib6/in6_01.c
+++ b/testcases/network/lib6/in6_01.c
@@ -1,6 +1,7 @@
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2001
+ *   Author: David L Stevens
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -13,26 +14,13 @@
  *   the GNU General Public License for more details.
  *
  *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *   along with this program;  if not, write to the Free Software Foundation,
+ *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
-
 /*
- * Test Name: in6_01
- *
- * Test Description:
- *  Verify that in6 and sockaddr fields are present. Most of these are
- *  "PASS" if they just compile.
- *
- * Usage:  <for command-line>
- *  in6_01
- *
- * HISTORY
- *	05/2004 written by David L Stevens
- *
- * RESTRICTIONS:
- *  None.
- *
+ *   Description:
+ *     Verify that in6 and sockaddr fields are present. Most of these are
+ *     "PASS" if they just compile.
  */
 
 #include <stdio.h>
@@ -44,52 +32,52 @@
 
 #include "test.h"
 
-char *TCID = "in6_01";		/* Test program identifier.    */
-
-void setup(void), cleanup(void);
-
-struct {
+static struct {
 	char *addr;
 	int ismap;
 } maptab[] = {
-	{
-	"2002::1", 0}, {
-	"::ffff:10.0.0.1", 1}, {
-	"::fffe:10.0.0.1", 0}, {
-	"::7fff:10.0.0.1", 0}, {
-	"0:0:0:0:0:0:ffff:0a001", 1}, {
-"0:0:1:0:0:0:ffff:0a001", 0},};
+	{ "2002::1", 0 },
+	{ "::ffff:10.0.0.1", 1 },
+	{ "::fffe:10.0.0.1", 0 },
+	{ "::7fff:10.0.0.1", 0 },
+	{ "0:0:0:0:0:0:ffff:0a001", 0 },
+	{ "0:0:1:0:0:0:ffff:0a001", 0 },
+};
 
 #define MAPSIZE (sizeof(maptab)/sizeof(maptab[0]))
 
-struct {
+static struct {
 	char *addr;
 } sstab[] = {
-	{
-	"2002::1"}, {
-	"10.0.0.1"}, {
-	"::ffff:10.0.0.1"}, {
-	"::1"}, {
-"::"},};
+	{ "2002::1" },
+	{ "10.0.0.1" },
+	{ "::ffff:10.0.0.1" },
+	{ "::1" },
+	{ "::" },
+};
 
 #define SSSIZE (sizeof(sstab)/sizeof(sstab[0]))
 
-int TST_TOTAL = 9 + MAPSIZE + SSSIZE;
+static void setup(void);
+static void test_in6_addr(void);
+static void test_sockaddr_in6(void);
+static void test_global_in6_def(void);
+static void test_in6_is_addr_v4mapped(void);
+static void test_sockaddr_storage(void);
+
+static void (*testfunc[])(void) = { test_in6_addr,
+	test_sockaddr_in6, test_global_in6_def,
+	test_in6_is_addr_v4mapped, test_sockaddr_storage };
+
+char *TCID = "in6_01";
+int TST_TOTAL = ARRAY_SIZE(testfunc);
 
 int main(int argc, char *argv[])
 {
-	uint8_t ui8 = 1;
-	uint32_t ui16 = 2;
-	uint32_t ui32 = 3;
-	struct in6_addr in6;
-	struct in6_addr ina6 = IN6ADDR_ANY_INIT;
-	struct in6_addr inl6 = IN6ADDR_LOOPBACK_INIT;
-	struct sockaddr_in6 sin6;
-	struct sockaddr_storage ss;
+	int lc;
 	int i;
 	const char *msg;
 
-	/* Parse standard options given to run the test. */
 	msg = parse_opts(argc, argv, NULL, NULL);
 	if (msg != NULL) {
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
@@ -97,62 +85,122 @@ int main(int argc, char *argv[])
 
 	setup();
 
-	/* struct in6_addr tests */
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+			(*testfunc[i])();
+	}
+
+	tst_exit();
+}
+
+static void setup(void)
+{
+	TEST_PAUSE;
+}
+
+/* struct in6_addr tests */
+static void test_in6_addr(void)
+{
+	uint8_t ui8 = 1;
+	struct in6_addr in6;
+
 	in6.s6_addr[0] = ui8;
-	tst_resm(TPASS, "type of in6.s6_addr[0] is uint8_t");
+	tst_resm(TINFO, "type of in6.s6_addr[0] is uint8_t");
 	if (sizeof(in6.s6_addr) != 16)
 		tst_resm(TFAIL, "sizeof(in6.s6_addr) != 16");
 	else
 		tst_resm(TPASS, "sizeof(in6.s6_addr) == 16");
+}
 
-	/* struct sockaddr_in6 tests */
+/* struct sockaddr_in6 tests */
+static void test_sockaddr_in6(void)
+{
+	uint8_t ui8 = 1;
+	uint32_t ui16 = 2;
+	uint32_t ui32 = 3;
+	struct in6_addr in6;
+	struct sockaddr_in6 sin6;
+
+	in6.s6_addr[0] = ui8;
 	sin6.sin6_family = AF_INET6;
 	sin6.sin6_port = ui16;
 	sin6.sin6_flowinfo = ui32;
 	sin6.sin6_addr = in6;
 	sin6.sin6_scope_id = ui32;
 	tst_resm(TPASS, "all sockaddr_in6 fields present and correct");
+}
 
-	/* initializers and global in6 definitions tests */
-	tst_resm(TPASS, "IN6ADDR_ANY_INIT present");
-	if (memcmp(&ina6, &in6addr_any, sizeof(ina6)) == 0)
-		tst_resm(TPASS, "in6addr_any present and correct");
-	else
+/* initializers and global in6 definitions tests */
+static void test_global_in6_def(void)
+{
+	struct in6_addr ina6 = IN6ADDR_ANY_INIT;
+	struct in6_addr inl6 = IN6ADDR_LOOPBACK_INIT;
+
+	tst_resm(TINFO, "IN6ADDR_ANY_INIT present");
+	if (memcmp(&ina6, &in6addr_any, sizeof(ina6)) == 0) {
+		tst_resm(TINFO, "in6addr_any present and correct");
+	} else {
 		tst_resm(TFAIL, "in6addr_any incorrect value");
-	tst_resm(TPASS, "IN6ADDR_LOOPBACK_INIT present");
-	if (memcmp(&inl6, &in6addr_loopback, sizeof(inl6)) == 0)
-		tst_resm(TPASS, "in6addr_loopback present and correct");
-	else
+		return;
+	}
+
+	tst_resm(TINFO, "IN6ADDR_LOOPBACK_INIT present");
+	if (memcmp(&inl6, &in6addr_loopback, sizeof(inl6)) == 0) {
+		tst_resm(TINFO, "in6addr_loopback present and correct");
+	} else {
 		tst_resm(TFAIL, "in6addr_loopback incorrect value");
+		return;
+	}
 	if (inet_pton(AF_INET6, "::1", &inl6) <= 0)
-		tst_resm(TBROK, "inet_pton(\"::1\")");
-	else if (memcmp(&inl6, &in6addr_loopback, sizeof(inl6)) == 0)
-		tst_resm(TPASS, "in6addr_loopback in network byte order");
-	else
+		tst_brkm(TBROK | TERRNO, NULL, "inet_pton(\"::1\")");
+	if (memcmp(&inl6, &in6addr_loopback, sizeof(inl6)) == 0) {
+		tst_resm(TINFO, "in6addr_loopback in network byte order");
+	} else {
 		tst_resm(TFAIL, "in6addr_loopback has wrong byte order");
+		return;
+	}
 
-	/* IN6_IS_ADDR_V4MAPPED tests */
+	tst_resm(TPASS, "global in6 definitions tests succeed");
+}
+
+/* IN6_IS_ADDR_V4MAPPED tests */
+static void test_in6_is_addr_v4mapped(void)
+{
+	unsigned int i;
+	struct in6_addr in6;
 
 	for (i = 0; i < MAPSIZE; ++i) {
 		if (inet_pton(AF_INET6, maptab[i].addr, &in6) <= 0) {
-			tst_resm(TBROK, "\"%s\" is not a valid IPv6 address",
-				 maptab[i].addr);
-			continue;
+			tst_brkm(TBROK | TERRNO, NULL,
+				"\"%s\" is not a valid IPv6 address",
+				maptab[i].addr);
 		}
 		TEST(IN6_IS_ADDR_V4MAPPED(in6.s6_addr));
-		if (TEST_RETURN == maptab[i].ismap)
-			tst_resm(TEST_RETURN == maptab[i].ismap ? TPASS : TFAIL,
-				 "IN6_IS_ADDR_V4MAPPED(\"%s\") %ld",
-				 maptab[i].addr, TEST_RETURN);
+		if (TEST_RETURN == maptab[i].ismap) {
+			tst_resm(TINFO, "IN6_IS_ADDR_V4MAPPED(\"%s\") %ld",
+				maptab[i].addr, TEST_RETURN);
+		} else {
+			tst_resm(TFAIL, "IN6_IS_ADDR_V4MAPPED(\"%s\") %ld",
+				maptab[i].addr, TEST_RETURN);
+			return;
+		}
 	}
 
-	/* sockaddr_storage tests */
+	tst_resm(TPASS, "IN6_IS_ADDR_V4MAPPED tests succeed");
+}
+
+/* sockaddr_storage tests */
+static void test_sockaddr_storage(void)
+{
+	unsigned int i;
+	struct sockaddr_storage ss;
 
 	if (sizeof(ss) <= sizeof(struct sockaddr_in) ||
-	    sizeof(ss) <= sizeof(struct sockaddr_in6))
-		tst_resm(TFAIL, "sockaddr_storage too small");
-	else
-		tst_resm(TPASS, "sockaddr_storage size ok");
+		sizeof(ss) <= sizeof(struct sockaddr_in6))
+		tst_brkm(TBROK, NULL, "sockaddr_storage too small");
+
 	for (i = 0; i < SSSIZE; ++i) {
 		struct sockaddr_in *psin = (struct sockaddr_in *)&ss;
 		struct sockaddr_in6 *psin6 = (struct sockaddr_in6 *)&ss;
@@ -164,33 +212,20 @@ int main(int argc, char *argv[])
 		if (rv == 0) {
 			af = psin6->sin6_family = AF_INET6;
 			rv = inet_pton(AF_INET6, sstab[i].addr,
-				       &psin6->sin6_addr);
+				&psin6->sin6_addr);
 		}
 		if (rv <= 0) {
-			tst_resm(TBROK, "\"%s\" is not a valid address",
-				 sstab[i].addr);
-			continue;
+			tst_brkm(TBROK, NULL,
+				"\"%s\" is not a valid address", sstab[i].addr);
 		}
-		if (ss.ss_family == af)
-			tst_resm(TPASS, "\"%s\" is AF_INET%s",
-				 sstab[i].addr, af == AF_INET ? "" : "6");
-		else
+		if (ss.ss_family == af) {
+			tst_resm(TINFO, "\"%s\" is AF_INET%s",
+				sstab[i].addr, af == AF_INET ? "" : "6");
+		} else {
 			tst_resm(TFAIL, "\"%s\" ss_family (%d) != AF_INET%s",
-				 sstab[i].addr, af, af == AF_INET ? "" : "6");
+				sstab[i].addr, af, af == AF_INET ? "" : "6");
+		}
 	}
 
-	cleanup();
-
-	return (0);
-}
-
-pid_t pid;
-
-void setup(void)
-{
-	TEST_PAUSE;		/* if -P option specified */
-}
-
-void cleanup(void)
-{
+	tst_resm(TPASS, "sockaddr_storage tests succeed");
 }
-- 
1.9.3


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
