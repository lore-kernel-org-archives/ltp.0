Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hong.gyu.kim@lge.com>) id 1VYzCw-0005dF-RA
	for ltp-list@lists.sourceforge.net; Wed, 23 Oct 2013 14:14:46 +0000
Received: from lgeamrelo01.lge.com ([156.147.1.125])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VYzCv-0007hP-19
	for ltp-list@lists.sourceforge.net; Wed, 23 Oct 2013 14:14:46 +0000
From: "Honggyu Kim" <hong.gyu.kim@lge.com>
Date: Wed, 23 Oct 2013 23:14:37 +0900
Message-ID: <000001cecffa$34dbd980$9e938c80$@gyu.kim@lge.com>
MIME-Version: 1.0
Content-Language: ko
Subject: [LTP] [PATCH v4] getcontext01: check getcontext function in libc
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

getcontext function is implemented depends on libc version and arch.
Some libc version for specific arch does not implement getcontext yet.
In that case, getcontext just sets errno to ENOSYS and returns -1.
For example, getcontext is not implemented before libc-2.17 in ARM.
Current test goes to TFAIL when lower version of libc is used in ARM.

This patch sets the test as TCONF if libc does not implement getcontext.
If ENOSYS is not set and -1 is returned, it goes to TFAIL as it was.

Change-Id: I93cab9805e5bc9cd05f9f473b466e0dc2bc4fa8f
Signed-off-by: Honggyu Kim <hong.gyu.kim@lge.com>
---
 .../kernel/syscalls/getcontext/getcontext01.c      |   24 +++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/getcontext/getcontext01.c b/testcases/kernel/syscalls/getcontext/getcontext01.c
index 03b2df9..7919fb5 100644
--- a/testcases/kernel/syscalls/getcontext/getcontext01.c
+++ b/testcases/kernel/syscalls/getcontext/getcontext01.c
@@ -54,12 +54,26 @@ int TST_TOTAL = 1;
 
 int exp_enos[] = { 0 };		/* must be a 0 terminated list */
 
+static void test_getcontext(void)
+{
+	ucontext_t ptr;
+
+	TEST(getcontext(&ptr));
+
+	if (TEST_RETURN == -1) {
+		if (errno == ENOSYS)
+			tst_resm(TCONF, "getcontext is not implemented in libc");
+		else
+			tst_resm(TFAIL | TTERRNO, "getcontext failed");
+	} else if (TEST_RETURN >= 0)
+		tst_resm(TPASS, "getcontext passed");
+}
+
 int main(int ac, char **av)
 {
 	int lc;
 	char *msg;
 
-	ucontext_t ptr;
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
@@ -71,13 +85,7 @@ int main(int ac, char **av)
 
 		tst_count = 0;
 
-		TEST(getcontext(&ptr));
-
-		if (TEST_RETURN == -1)
-			tst_resm(TFAIL | TTERRNO, "getcontext failed");
-		else if (TEST_RETURN >= 0)
-			tst_resm(TPASS, "getcontext passed");
-
+		test_getcontext();
 	}
 
 	cleanup();
-- 
1.7.9.5



------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
