Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1YEaj0-0000A7-1B
	for ltp-list@lists.sourceforge.net; Fri, 23 Jan 2015 09:40:22 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YEaiw-0004ve-B4
	for ltp-list@lists.sourceforge.net; Fri, 23 Jan 2015 09:40:20 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t0N9dW3C006598
	for <ltp-list@lists.sourceforge.net>; Fri, 23 Jan 2015 17:39:32 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 23 Jan 2015 17:36:11 +0800
Message-ID: <1422005772-19099-6-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1422005772-19099-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1422005772-19099-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 6/7] lib6/in6_02.c: cleanup
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
 testcases/network/lib6/in6_02.c | 180 ++++++++++++++++++----------------------
 1 file changed, 81 insertions(+), 99 deletions(-)

diff --git a/testcases/network/lib6/in6_02.c b/testcases/network/lib6/in6_02.c
index 664c74f..0988c37 100644
--- a/testcases/network/lib6/in6_02.c
+++ b/testcases/network/lib6/in6_02.c
@@ -1,6 +1,7 @@
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2001
+ *   Author: David L Stevens
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -13,73 +14,54 @@
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
- * Test Name: in6_02
- *
- * Test Description:
- *  Tests for name to index and index to name functions in IPv6
- *
- * Usage:  <for command-line>
- *  in6_02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	05/2004 written by David L Stevens
- *
- * RESTRICTIONS:
- *  None.
- *
+ *   Description:
+ *     Tests for name to index and index to name functions in IPv6
  */
 
 #include <unistd.h>
 #include <errno.h>
-
 #include <sys/socket.h>
-
 #include <net/if.h>
 
 #include "test.h"
 #include "usctest.h"
 
-char *TCID = "in6_02";		/* Test program identifier.    */
-int testno;
-
-void setup(void), cleanup(void);
-
-struct {
+static struct {
 	char *name;
 	int nonzero;
 } n2i[] = {
-	{
-	"lo", 1}, {
-	"eth0", 1}, {
-	"hoser75", 0}, {
-"6", 0},};
+	{ "lo", 1 },
+	{ "eth0", 1 },
+	{ "hoser75", 0 },
+	{ "6", 0 },
+};
 
 #define N2I_COUNT (sizeof(n2i)/sizeof(n2i[0]))
-
 #define I2N_RNDCOUNT	10	/* random ints */
 #define I2N_LOWCOUNT	10	/* sequential from 0 */
 
-int TST_TOTAL = N2I_COUNT;
+static void setup(void);
+static void cleanup(void);
+static void n2itest(void);
+static void i2ntest(void);
+static void initest(void);
+
+static void (*testfunc[])(void) = { n2itest,
+	i2ntest, initest };
 
-void n2itest(void), i2ntest(void), initest(void);
+char *TCID = "in6_02";
+int TST_TOTAL = ARRAY_SIZE(testfunc);
 
 int main(int argc, char *argv[])
 {
 	int lc;
+	int i;
 	const char *msg;
 
-	/* Parse standard options given to run the test. */
 	msg = parse_opts(argc, argv, NULL, NULL);
 	if (msg != NULL) {
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
@@ -88,53 +70,48 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		n2itest();
-		i2ntest();
-		initest();
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+			(*testfunc[i])();
 	}
-	cleanup();
 
-	return (0);
+	cleanup();
+	tst_exit();
 }
 
 /* if_nametoindex tests */
-
-void n2itest()
+void n2itest(void)
 {
-	int i;
+	unsigned int i;
+	char ifname[IF_NAMESIZE], *pifn;
 
 	for (i = 0; i < N2I_COUNT; ++i) {
-		char ifname[IF_NAMESIZE], *pifn;
-		int fail;
-
 		TEST(if_nametoindex(n2i[i].name));
-		fail = !TEST_RETURN != !n2i[i].nonzero;
-		if (fail) {
+		if (!TEST_RETURN != !n2i[i].nonzero) {
 			tst_resm(TFAIL, "if_nametoindex(\"%s\") %ld "
-				 "[should be %szero]", n2i[i].name,
-				 TEST_RETURN, n2i[i].nonzero ? "non" : "");
-			continue;
+				"[should be %szero]", n2i[i].name, TEST_RETURN,
+				n2i[i].nonzero ? "non" : "");
+			return;
 		}
-		if (!TEST_RETURN) {
-			tst_resm(TPASS, "if_nametoindex(\"%s\") %ld",
-				 n2i[i].name, TEST_RETURN);
-			continue;
+		if (TEST_RETURN) {
+			pifn = if_indextoname(TEST_RETURN, ifname);
+			if (!pifn || strcmp(n2i[i].name, pifn)) {
+				tst_resm(TFAIL, "if_nametoindex(\"%s\") %ld "
+					"doesn't match if_indextoname(%ld) "
+					"\"%s\"", n2i[i].name, TEST_RETURN,
+					TEST_RETURN, pifn ? pifn : "");
+				return;
+			}
 		}
-
-		pifn = if_indextoname(TEST_RETURN, ifname);
-		if (!pifn || strcmp(n2i[i].name, pifn)) {
-			tst_resm(TFAIL, "if_nametoindex(\"%s\") %ld doesn't "
-				 "match if_indextoname(%ld) \"%s\"",
-				 n2i[i].name, TEST_RETURN, TEST_RETURN,
-				 pifn ? pifn : "");
-			continue;
-		}
-		tst_resm(TPASS, "if_nametoindex(\"%s\") %ld", n2i[i].name,
-			 TEST_RETURN);
+		tst_resm(TINFO, "if_nametoindex(\"%s\") %ld",
+			n2i[i].name, TEST_RETURN);
 	}
+
+	tst_resm(TPASS, "if_nametoindex() tests succeed");
 }
 
-int i2ntest1(unsigned int if_index)
+int sub_i2ntest(unsigned int if_index)
 {
 	char ifname[IF_NAMESIZE];
 	unsigned int idx;
@@ -147,7 +124,7 @@ int i2ntest1(unsigned int if_index)
 				 TEST_ERRNO);
 			return 0;
 		}
-		tst_resm(TPASS, "if_indextoname(%d) returns NULL", if_index);
+		tst_resm(TINFO, "if_indextoname(%d) returns NULL", if_index);
 		return 1;
 	}
 	/* else, a valid interface-- double check name */
@@ -158,29 +135,32 @@ int i2ntest1(unsigned int if_index)
 			 if_index, ifname, ifname, idx);
 		return 0;
 	}
-	tst_resm(TPASS, "if_indextoname(%d) returns \"%s\"", if_index, ifname);
+	tst_resm(TINFO, "if_indextoname(%d) returns \"%s\"", if_index, ifname);
 	return 1;
 }
 
+/* if_indextoname tests */
 void i2ntest(void)
 {
 	unsigned int i;
 
 	/* some low-numbered indexes-- likely to get valid interfaces here */
 	for (i = 0; i < I2N_LOWCOUNT; ++i)
-		if (!i2ntest1(i))
+		if (!sub_i2ntest(i))
 			return;	/* skip the rest, if broken */
 	/* some random ints; should mostly fail */
 	for (i = 0; i < I2N_RNDCOUNT; ++i)
-		if (!i2ntest1(rand()))
+		if (!sub_i2ntest(rand()))
 			return;	/* skip the rest, if broken */
+
+	tst_resm(TPASS, "if_indextoname() tests succeed");
 }
 
 /*
  * This is an ugly, linux-only solution. getrusage() doesn't support the
  * current data segment size, so we get it out of /proc
  */
-static int getdatasize(void)
+int getdatasize(void)
 {
 	char line[128], *p;
 	int dsize = -1;
@@ -203,29 +183,30 @@ static int getdatasize(void)
 	return dsize;
 }
 
+/* if_nameindex tests */
 void initest(void)
 {
-	int freenicount;
 	struct if_nameindex *pini;
-	int i, dsize_before, dsize_after;
+	int i;
+	char buf[IF_NAMESIZE], *p;
+	unsigned int idx;
+	int freenicount;
+	int dsize_before, dsize_after;
 
 	pini = if_nameindex();
-	if (pini == 0) {
+	if (pini == NULL) {
 		tst_resm(TFAIL, "if_nameindex() returns NULL, errno %d (%s)",
 			 TEST_ERRNO, strerror(TEST_ERRNO));
 		return;
 	}
 	for (i = 0; pini[i].if_index; ++i) {
-		char buf[IF_NAMESIZE], *p;
-		int idx;
-
 		p = if_indextoname(pini[i].if_index, buf);
 		if (!p || strcmp(p, pini[i].if_name)) {
 			tst_resm(TFAIL, "if_nameindex idx %d name \"%s\" but "
 				 "if_indextoname(%d) is \"%s\"",
 				 pini[i].if_index, pini[i].if_name,
 				 pini[i].if_index, p ? p : "");
-			continue;
+			return;
 		}
 		idx = if_nametoindex(pini[i].if_name);
 		if (idx != pini[i].if_index) {
@@ -233,9 +214,9 @@ void initest(void)
 				 "if_indextoname(\"%s\") is %d",
 				 pini[i].if_index, pini[i].if_name,
 				 pini[i].if_name, idx);
-			continue;
+			return;
 		}
-		tst_resm(TPASS, "if_nameindex idx %d name \"%s\"",
+		tst_resm(TINFO, "if_nameindex idx %d name \"%s\"",
 			 pini[i].if_index, pini[i].if_name);
 	}
 	if_freenameindex(pini);
@@ -245,9 +226,8 @@ void initest(void)
 	 */
 	dsize_before = getdatasize();
 	if (dsize_before < 0) {
-		tst_resm(TBROK, "getdatasize failed: errno %d (%s)", errno,
-			 strerror(errno));
-		return;
+		tst_brkm(TBROK, cleanup, "getdatasize failed: errno %d (%s)",
+			errno, strerror(errno));
 	}
 	/* we need to leak at least a page to detect a leak; 1 byte per call
 	 * will be detected with getpagesize() calls.
@@ -255,8 +235,8 @@ void initest(void)
 	freenicount = getpagesize();
 	for (i = 0; i < freenicount; ++i) {
 		pini = if_nameindex();
-		if (!pini) {
-			tst_resm(TFAIL, "if_freenameindex test failed "
+		if (pini == NULL) {
+			tst_resm(TINFO, "if_freenameindex test failed "
 				 "if_nameindex() iteration %d", i);
 			break;
 		}
@@ -264,25 +244,27 @@ void initest(void)
 	}
 	dsize_after = getdatasize();
 	if (dsize_after < 0) {
-		tst_resm(TBROK, "getdatasize failed: errno %d (%s)", errno,
-			 strerror(errno));
-		return;
+		tst_brkm(TBROK, cleanup, "getdatasize failed: errno %d (%s)",
+			errno, strerror(errno));
 	}
-	if (dsize_after > dsize_before + getpagesize())
+	if (dsize_after > dsize_before + getpagesize()) {
 		tst_resm(TFAIL, "if_freenameindex leaking memory "
 			 "(%d iterations) dsize before %d dsize after %d", i,
 			 dsize_before, dsize_after);
-	else
-		tst_resm(TPASS, "if_freenameindex passed %d iterations", i);
+		return;
+	} else {
+		tst_resm(TINFO, "if_freenameindex passed %d iterations", i);
+	}
+
+	tst_resm(TPASS, "if_nameindex() tests succeed");
 }
 
 void setup(void)
 {
-	TEST_PAUSE;		/* if -P option specified */
+	TEST_PAUSE;
 }
 
 void cleanup(void)
 {
 	TEST_CLEANUP;
-
 }
-- 
1.9.3


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
