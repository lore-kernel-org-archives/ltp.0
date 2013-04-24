Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UUu1k-0002Mv-FE
	for ltp-list@lists.sourceforge.net; Wed, 24 Apr 2013 07:22:04 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UUu1j-000256-98
	for ltp-list@lists.sourceforge.net; Wed, 24 Apr 2013 07:22:04 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r3O7LkmT012290
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Apr 2013 15:21:55 +0800
Message-ID: <51778786.8020900@cn.fujitsu.com>
Date: Wed, 24 Apr 2013 15:19:34 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <5177866B.8040606@cn.fujitsu.com>
In-Reply-To: <5177866B.8040606@cn.fujitsu.com>
Subject: [LTP] [PATCH 2/2] syscalls/getitimer01.c: Test for getting
 ITIMER_VIRTUAL and ITIMER_PROF
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
To: LTP list <ltp-list@lists.sourceforge.net>


Additional tests for getting ITIMER_VIRTUAL and ITIMER_PROF.

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 testcases/kernel/syscalls/getitimer/getitimer01.c | 59 ++++++++++++++---------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/syscalls/getitimer/getitimer01.c b/testcases/kernel/syscalls/getitimer/getitimer01.c
index 54aa5bb..1b3d6a5 100644
--- a/testcases/kernel/syscalls/getitimer/getitimer01.c
+++ b/testcases/kernel/syscalls/getitimer/getitimer01.c
@@ -19,6 +19,7 @@
 /*
   HISTORY
     03/2001 - Written by Wayne Boyer
+    04/2013 - ITIMER_VIRTUAL and ITIMER_PROF test added by DAN LI

   TEST ITEMS:
     Check that a correct call to getitimer() succeeds.
@@ -34,11 +35,17 @@ static void cleanup(void);
 static void setup(void);

 char *TCID = "getitimer01";
-int TST_TOTAL = 1;
+int TST_TOTAL = 3;
+
+static int itimer_name[] = {
+			ITIMER_REAL,
+			ITIMER_VIRTUAL,
+			ITIMER_PROF, };

 int main(int ac, char **av)
 {
 	int lc;
+	int idx;
 	char *msg;
 	struct itimerval *value;

@@ -50,33 +57,37 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;

-		/* allocate space for the itimerval structure */
-		value = (struct itimerval *)malloc(
+		for (idx = 0; idx < 3; idx++) {
+			/* allocate space for the itimerval structure */
+			value = (struct itimerval *)malloc(
 					(size_t)sizeof(struct itimerval));
-		if (value == NULL)
-			tst_brkm(TBROK, cleanup, "value malloc failed");
-
-		TEST(getitimer(ITIMER_REAL, value));
-
-		if (TEST_RETURN != 0)
-			tst_resm(TFAIL, "call failed - errno = %d - %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-
-		if (STD_FUNCTIONAL_TEST) {
+			if (value == NULL) {
+				tst_resm(TBROK, "value malloc failed");
+				continue;
+			}

-			/*
-			 * Since ITIMER_REAL is effectively disabled (we did
-			 * not set it before the getitimer call), the elements
-			 * in it_value should be zero.
-			 */
-			if ((value->it_value.tv_sec == 0) &&
-			    (value->it_value.tv_usec == 0)) {
-				tst_resm(TPASS, "functional test passed");
+			TEST(getitimer(itimer_name[idx], value));
+
+			if (TEST_RETURN != 0)
+				tst_resm(TFAIL, "call failed - errno = %d - %s",
+					 TEST_ERRNO, strerror(TEST_ERRNO));
+
+			if (STD_FUNCTIONAL_TEST) {
+
+				/*
+				* Since ITIMER is effectively disabled (we did
+				* not set it before the getitimer call), the
+				* elements in it_value should be zero.
+				*/
+				if ((value->it_value.tv_sec == 0) &&
+					(value->it_value.tv_usec == 0)) {
+					tst_resm(TPASS, "functionality is ok");
+				} else {
+					tst_resm(TFAIL, "timer are non zero");
+				}
 			} else {
-				tst_resm(TFAIL, "timer values are non zero");
+				tst_resm(TPASS, "call succeeded");
 			}
-		} else {
-			tst_resm(TPASS, "call succeeded");
 		}
 	}

-- 
1.8.1

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
