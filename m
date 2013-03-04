Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UCS26-00034L-8n
	for ltp-list@lists.sourceforge.net; Mon, 04 Mar 2013 09:50:10 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UCS24-0006v8-Ci
	for ltp-list@lists.sourceforge.net; Mon, 04 Mar 2013 09:50:10 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r249EoH0020434
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Mar 2013 17:14:50 +0800
Message-ID: <51346595.80103@cn.fujitsu.com>
Date: Mon, 04 Mar 2013 17:12:53 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH]pthread_once/1-1.c : cleanup & add error checks
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


1.Make log style keep consistent with other cases in the same directory.
2.Add error checks to strengthen the robustness of this case.

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 .../conformance/interfaces/pthread_once/1-1.c      | 70 +++++++++++++++++++---
 1 file changed, 61 insertions(+), 9 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/1-1.c
b/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/1-1.c
index 3a7c861..03b2875 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/1-1.c
@@ -21,9 +21,53 @@
  *   passed to it.  If it does, the test fails.
  */

+/* We are testing conformance to IEEE Std 1003.1, 2003 Edition */
+#define _POSIX_C_SOURCE 200112L
+
+/******************************************************************************/
+/****************************** standard includes *****************************/
+/******************************************************************************/
 #include <pthread.h>
 #include <stdio.h>
-#include "posixtest.h"
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+/******************************************************************************/
+/******************************   Test framework   ****************************/
+/******************************************************************************/
+#include "../testfrmw/testfrmw.h"
+#include "../testfrmw/testfrmw.c"
+/* This header is responsible for defining the following macros:
+ * UNRESOLVED(ret, descr);
+ *    where descr is a description of the error and ret is an int
+ *    (error code for example)
+ * FAILED(descr);
+ *    where descr is a short text saying why the test has failed.
+ * PASSED();
+ *    No parameter.
+ *
+ * Both three macros shall terminate the calling process.
+ * The testcase shall not terminate in any other maneer.
+ *
+ * The other file defines the functions
+ * void output_init()
+ * void output(char * string, ...)
+ *
+ * Those may be used to output information.
+ */
+
+/******************************************************************************/
+/******************************** Configuration *******************************/
+/******************************************************************************/
+#ifndef VERBOSE
+#define VERBOSE 1
+#endif
+
+/******************************************************************************/
+/*******************************    Test case   *******************************/
+/******************************************************************************/
+

 /* Keeps track of how many times the init function has been called. */
 int init_flag;
@@ -37,23 +81,31 @@ void *an_init_func()

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
+#if VERBOSE > 0
+	output("TEST PASSED\n");
+#endif

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
