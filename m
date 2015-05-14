Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YsubB-0001fU-3E
	for ltp-list@lists.sourceforge.net; Thu, 14 May 2015 14:58:57 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ysub8-0003U5-Nh
	for ltp-list@lists.sourceforge.net; Thu, 14 May 2015 14:58:57 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t4EEwmqW026759
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 14 May 2015 10:58:48 -0400
Received: from dustball.brq.redhat.com (dhcp-2-181.brq.redhat.com
	[10.34.2.181])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t4EEwkaf017001
	for <ltp-list@lists.sourceforge.net>; Thu, 14 May 2015 10:58:47 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 14 May 2015 16:58:44 +0200
Message-Id: <56cb7d597d907a2e7168d912f3abf4fafce2fea1.1431615152.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] sigtimedwait: use gtod instead of time
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Quoting https://lkml.org/lkml/2015/2/19/384
  "The idea that time() would be ok as being HZ granular, and its
  been this way since 2.6.23.  Thus you have a < HZ sized window
  where gettimeofday() will return the next second before time()
  gets updated by the tick."

Use gettimeofday() rather than time() and also relax the error margin,
since man page says, that there may be small overrun.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../conformance/interfaces/sigtimedwait/1-1.c      | 24 ++++++++++++++--------
 .../conformance/interfaces/sigtimedwait/2-1.c      | 19 +++++++++++------
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/1-1.c
index 15f32a8..189644c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/1-1.c
@@ -35,13 +35,14 @@
 #define SIGTOTEST SIGUSR2
 #define TIMERSEC 2
 #define SIGTIMEDWAITSEC 1
-#define ERRORMARGIN 0.01
+#define ERRORMARGIN 0.1
 
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
 #include <unistd.h>
+#include <sys/time.h>
 #include <sys/wait.h>
 #include "posixtest.h"
 
@@ -57,7 +58,7 @@ int main(void)
 {
 	struct sigaction act;
 
-	time_t time1, time2;
+	struct timeval time1, time2;
 	double time_elapsed;
 
 	sigset_t selectset;
@@ -96,21 +97,28 @@ int main(void)
                 return PTS_UNRESOLVED;
         }
 */
-	time1 = time(NULL);
+	if (gettimeofday(&time1, NULL) == -1) {
+		perror("gettimeofday()");
+		return PTS_UNRESOLVED;
+	}
 	if (sigtimedwait(&selectset, NULL, &ts) != -1) {
 		perror
 		    ("sigtimedwait() did not return -1 even though signal was not pending\n");
 		return PTS_UNRESOLVED;
 	}
+	if (gettimeofday(&time2, NULL) == -1) {
+		perror("gettimeofday()");
+		return PTS_UNRESOLVED;
+	}
 
-	time2 = time(NULL);
-
-	time_elapsed = difftime(time2, time1);
+	time_elapsed = (time2.tv_sec - time1.tv_sec
+		+ (time2.tv_usec - time1.tv_usec) / 1000000.0);
 
 	if ((time_elapsed > SIGTIMEDWAITSEC + ERRORMARGIN)
 	    || (time_elapsed < SIGTIMEDWAITSEC - ERRORMARGIN)) {
-		printf
-		    ("Test FAILED: sigtimedwait() did not return in the required time\n");
+		printf("Test FAILED: sigtimedwait() did not return in "
+			"the required time\n");
+		printf("time_elapsed: %lf\n", time_elapsed);
 		return PTS_FAIL;
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/2-1.c
index a0fcaca..c5ac7db 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/2-1.c
@@ -36,13 +36,14 @@
 #define SIGTOTEST SIGUSR2
 #define TIMERSEC 2
 #define SIGTIMEDWAITSEC 0
-#define ERRORMARGIN 0.01
+#define ERRORMARGIN 0.1
 
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
 #include <unistd.h>
+#include <sys/time.h>
 #include <sys/wait.h>
 #include "posixtest.h"
 
@@ -58,7 +59,7 @@ int main(void)
 {
 	struct sigaction act;
 
-	time_t time1, time2;
+	struct timeval time1, time2;
 	double time_elapsed;
 
 	sigset_t selectset;
@@ -97,16 +98,22 @@ int main(void)
                 return PTS_UNRESOLVED;
         }
 */
-	time1 = time(NULL);
+	if (gettimeofday(&time1, NULL) == -1) {
+		perror("gettimeofday()");
+		return PTS_UNRESOLVED;
+	}
 	if (sigtimedwait(&selectset, NULL, &ts) != -1) {
 		printf
 		    ("Test FAILED: sigtimedwait() did not return with an error\n");
 		return PTS_FAIL;
 	}
+	if (gettimeofday(&time2, NULL) == -1) {
+		perror("gettimeofday()");
+		return PTS_UNRESOLVED;
+	}
 
-	time2 = time(NULL);
-
-	time_elapsed = difftime(time2, time1);
+	time_elapsed = (time2.tv_sec - time1.tv_sec
+		+ (time2.tv_usec - time1.tv_usec) / 1000000.0);
 
 	if ((time_elapsed > SIGTIMEDWAITSEC + ERRORMARGIN)
 	    || (time_elapsed < SIGTIMEDWAITSEC - ERRORMARGIN)) {
-- 
1.8.3.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
