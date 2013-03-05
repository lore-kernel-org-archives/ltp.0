Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UCpO3-0003ZF-CE
	for ltp-list@lists.sourceforge.net; Tue, 05 Mar 2013 10:46:23 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UCpNz-00082v-Dz
	for ltp-list@lists.sourceforge.net; Tue, 05 Mar 2013 10:46:22 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r25AkCaJ014238
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Mar 2013 18:46:12 +0800
Message-ID: <5135CC80.5060800@cn.fujitsu.com>
Date: Tue, 05 Mar 2013 18:44:16 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <51346595.80103@cn.fujitsu.com> <20130305095125.GA13876@rei.Home>
In-Reply-To: <20130305095125.GA13876@rei.Home>
Subject: [LTP] [PATCHv2]pthread_once/1-1.c : cleanup & error checks
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


1.Add error checks to:

  Make sure this case not slip into one situation that
  the first pthread_once fails, and the second successes,
  then the case passes with bypassing its assertion.

  Give more detailed and exact execute result.

2.Replace "posixtest.h" with "testfrmw.h" as the log frame
  to keep consistent with other cases in the same directory.


Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 .../conformance/interfaces/pthread_once/1-1.c      | 32 ++++++++++++++++------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/1-1.c
b/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/1-1.c
index 3a7c861..c7ae170 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/1-1.c
@@ -21,9 +21,17 @@
  *   passed to it.  If it does, the test fails.
  */

+/* We are testing conformance to IEEE Std 1003.1, 2003 Edition */
+#define _POSIX_C_SOURCE 200112L
+
 #include <pthread.h>
 #include <stdio.h>
-#include "posixtest.h"
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "../testfrmw/testfrmw.h"
+#include "../testfrmw/testfrmw.c"

 /* Keeps track of how many times the init function has been called. */
 int init_flag;
@@ -37,23 +45,29 @@ void *an_init_func()

 int main()
 {
+	int ret = 0;
+
 	pthread_once_t once_control = PTHREAD_ONCE_INIT;

 	init_flag = 0;

+	output_init();
+
 	/* Call pthread_once, passing it the once_control */
-	pthread_once(&once_control, (void *)an_init_func);
+	ret = pthread_once(&once_control, (void *)an_init_func);
+	if (ret != 0)
+		UNRESOLVED(ret, "pthread_once failed");

 	/* Call pthread_once again. The init function should not be
 	 * called. */
-	pthread_once(&once_control, (void *)an_init_func);
+	ret = pthread_once(&once_control, (void *)an_init_func);
+	if (ret != 0)
+		UNRESOLVED(ret, "pthread_once failed");

-	if (init_flag != 1) {
-		printf("Test FAILED\n");
-		return PTS_FAIL;
-	}
+	if (init_flag != 1)
+		FAILED("an_init_func runs two times\n");

-	printf("Test PASSED\n");
-	return PTS_PASS;
+	output("TEST PASSED\n");

+	PASSED;
 }
-- 
1.7.12


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
