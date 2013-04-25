Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UVCYq-0003wF-6Y
	for ltp-list@lists.sourceforge.net; Thu, 25 Apr 2013 03:09:28 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UVCYh-0007Wf-Am
	for ltp-list@lists.sourceforge.net; Thu, 25 Apr 2013 03:09:28 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r3P39ILi022723
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Apr 2013 11:09:18 +0800
Message-ID: <51789DD9.7040506@cn.fujitsu.com>
Date: Thu, 25 Apr 2013 11:07:05 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <51789D50.1080301@cn.fujitsu.com>
In-Reply-To: <51789D50.1080301@cn.fujitsu.com>
Subject: [LTP] [PATCH v3 2/2] syscalls/getitimer01.c: Test for getting
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


Additional tests of getting ITIMER_VIRTUAL and ITIMER_PROF.

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 testcases/kernel/syscalls/getitimer/getitimer01.c | 44 ++++++++++++++---------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/getitimer/getitimer01.c b/testcases/kernel/syscalls/getitimer/getitimer01.c
index 03edf2f..5569a49 100644
--- a/testcases/kernel/syscalls/getitimer/getitimer01.c
+++ b/testcases/kernel/syscalls/getitimer/getitimer01.c
@@ -34,11 +34,18 @@ static void cleanup(void);
 static void setup(void);

 char *TCID = "getitimer01";
-int TST_TOTAL = 1;
+int TST_TOTAL = 3;
+
+static int itimer_name[] = {
+	ITIMER_REAL,
+	ITIMER_VIRTUAL,
+	ITIMER_PROF,
+};

 int main(int ac, char **av)
 {
 	int lc;
+	int i;
 	char *msg;
 	struct itimerval value;

@@ -51,27 +58,30 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;

-		TEST(getitimer(ITIMER_REAL, &value));
+		for (i = 0; i < 3; i++) {
+
+			TEST(getitimer(itimer_name[i], &value));

-		if (TEST_RETURN != 0)
-			tst_resm(TFAIL, "call failed - errno = %d - %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
+			if (TEST_RETURN != 0)
+				tst_resm(TFAIL, "call failed - errno = %d - %s",
+					 TEST_ERRNO, strerror(TEST_ERRNO));

-		if (STD_FUNCTIONAL_TEST) {
+			if (STD_FUNCTIONAL_TEST) {

-			/*
-			 * Since ITIMER_REAL is effectively disabled (we did
-			 * not set it before the getitimer call), the elements
-			 * in it_value should be zero.
-			 */
-			if ((value.it_value.tv_sec == 0) &&
-			    (value.it_value.tv_usec == 0)) {
-				tst_resm(TPASS, "functional test passed");
+				/*
+				 * Since ITIMER is effectively disabled (we did
+				 * not set it before the getitimer call), the
+				 * elements in it_value should be zero.
+				 */
+				if ((value.it_value.tv_sec == 0) &&
+					(value.it_value.tv_usec == 0)) {
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
