Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Song.Li@windriver.com>) id 1RgWKB-0000hx-L9
	for ltp-list@lists.sourceforge.net; Fri, 30 Dec 2011 06:52:19 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RgWKA-00056y-3e
	for ltp-list@lists.sourceforge.net; Fri, 30 Dec 2011 06:52:19 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pBU6qCGu019248
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Thu, 29 Dec 2011 22:52:12 -0800 (PST)
From: <Song.Li@windriver.com>
Date: Fri, 30 Dec 2011 14:52:20 +0800
Message-ID: <1325227940-9971-1-git-send-email-Song.Li@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] sched_setparam/2-1.c and sched_setparam/2-2.c
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

From: LiSong <Song.Li@windriver.com>

There is no guarantee that the LOOP of the child proecess
can be certainly big enough on any device at any time.
So if set_affinity function is available,
use it to bind the test processes to a single CPU
rather than using the LOOP.

Signed-off-by: Song.Li <Song.Li@windriver.com>
---
 .../conformance/interfaces/sched_setparam/2-1.c    |   26 ++++++++++++++++----
 .../conformance/interfaces/sched_setparam/2-2.c    |   26 ++++++++++++++++----
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c
index c548dd4..2d20f9f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c
@@ -29,6 +29,7 @@
  *
  */
 
+#define _GNU_SOURCE
 #include <sched.h>
 #include <stdio.h>
 #include <signal.h>
@@ -48,6 +49,8 @@
 # include <sys/pstat.h>
 #endif
 
+#include <affinity.h>
+
 #define NB_LOOP         20000000
 #define NB_LOOP_CHILD  200000000 /* shall be much greater than NB_LOOP */
 
@@ -119,11 +122,24 @@ int main() {
 	int *child_pid;
 	float ratio;
 
-	nb_child = get_ncpu();
-	if (nb_child == -1) {
-		printf("Can not get the number of CPUs of your machine.\n");
-		return PTS_UNRESOLVED;
+	/* Only use a single CPU and one child process
+	when set_affinity is availaible.It's because
+	no matter what value of the counter is set to,
+	There is no guarantee that the LOOP of the child
+	can be certainly big enough on any device at any time.
+	*/
+	int rc = set_affinity(0);
+	if (rc) {
+		nb_child = get_ncpu();
+		if (nb_child == -1) {
+			printf("Can not get the number of"
+				"CPUs of your machine.\n");
+			return PTS_UNRESOLVED;
+		}
+	} else {
+		nb_child = 1;
 	}
+
 	child_pid = malloc(nb_child);
 
 	param.sched_priority = (sched_get_priority_min(SCHED_FIFO) +
@@ -208,4 +224,4 @@ int main() {
 		return PTS_UNRESOLVED;
 	}
 
-}
\ No newline at end of file
+}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c
index 2b71893..08cdc34 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c
@@ -29,6 +29,7 @@
  *
  */
 
+#define _GNU_SOURCE
 #include <sched.h>
 #include <stdio.h>
 #include <signal.h>
@@ -48,6 +49,8 @@
 # include <sys/pstat.h>
 #endif
 
+#include <affinity.h>
+
 #define NB_LOOP         20000000
 #define NB_LOOP_CHILD  200000000 /* shall be much greater than NB_LOOP */
 
@@ -119,11 +122,24 @@ int main() {
 	int *child_pid;
 	float ratio;
 
-	nb_child = get_ncpu();
-	if (nb_child == -1) {
-		printf("Can not get the number of CPUs of your machine.\n");
-		return PTS_UNRESOLVED;
+	/* Only use a single CPU and one child process
+	when set_affinity is availaible.It's because
+	no matter what value of the counter is set to,
+	There is no guarantee that the LOOP of the child
+	can be certainly big enough on any device at any time.
+	*/
+	int rc = set_affinity(0);
+	if (rc) {
+		nb_child = get_ncpu();
+		if (nb_child == -1) {
+			printf("Can not get the number of"
+				"CPUs of your machine.\n");
+			return PTS_UNRESOLVED;
+		}
+	} else {
+		nb_child = 1;
 	}
+
 	child_pid = malloc(nb_child);
 	if (child_pid == NULL) {
 		printf("malloc failed\n");
@@ -211,4 +227,4 @@ int main() {
 		return PTS_UNRESOLVED;
 	}
 
-}
\ No newline at end of file
+}
-- 
1.7.5.4


------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
