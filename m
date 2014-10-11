Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xuw@redhat.com>) id 1XctPl-0001tn-II
	for ltp-list@lists.sourceforge.net; Sat, 11 Oct 2014 09:56:41 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XctPi-0002HW-M3
	for ltp-list@lists.sourceforge.net; Sat, 11 Oct 2014 09:56:41 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s9B9uWNo030529
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Sat, 11 Oct 2014 05:56:32 -0400
From: xuw@redhat.com
Date: Sat, 11 Oct 2014 17:56:29 +0800
Message-Id: <1413021389-17387-1-git-send-email-xuw@redhat.com>
Subject: [LTP] [PATCH] fs: Add support for numthreads/numfiles reach os
	rlimit.
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

From: George Wang <xuw@redhat.com>

Try to reset the RLIMIT_NPROC/RLIMIT_NOFILE to satify the test
option. If fail, just exit the test with warning. Also fix the bug for
subthreads opening files failed, the main will infinitely wait.

Signed-off-by: George Wang <xuw@redhat.com>
---
 testcases/kernel/fs/openfile/openfile.c | 50 +++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/fs/openfile/openfile.c b/testcases/kernel/fs/openfile/openfile.c
index 8657064..091fb39 100644
--- a/testcases/kernel/fs/openfile/openfile.c
+++ b/testcases/kernel/fs/openfile/openfile.c
@@ -34,6 +34,7 @@
 #include <stdlib.h>
 #include <stdint.h>
 #include <unistd.h>
+#include <sys/resource.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -49,11 +50,12 @@ struct cb {
 	pthread_mutex_t m;
 	pthread_cond_t init_cv;
 	pthread_cond_t thr_cv;
+	pthread_spinlock_t fail_lock;
 	int thr_sleeping;
 } c;
 
 /* Global Variables */
-int numthreads = 10, numfiles = 10;
+int numthreads = 10, numfiles = 10, failedthreads = 0;
 int debug = 0;
 char *filename = "FILETOOPEN";
 
@@ -68,6 +70,30 @@ void cleanup(void)
 
 }
 
+int adjust_system_limit(int limit_type, int value)
+{
+	struct rlimit limit;
+
+	if (getrlimit(limit_type, &limit)) {
+		/* get limit failed, just return 0 to make the test run */
+		return 0;
+	}
+
+	if (RLIM_INFINITY == limit.rlim_cur) {
+		/* unlimited for this resource */
+		return 0;
+	}
+	if (value <= (int)limit.rlim_cur) {
+		/* current limit can satify the value */
+ 		return 0;
+	} 
+
+
+	limit.rlim_cur = value < (int)limit.rlim_max ? (int)limit.rlim_max : value;
+
+	return setrlimit(limit_type, &limit);
+}
+
 /* Procedures */
 void *threads(void *thread_id);
 
@@ -125,6 +151,13 @@ int main(int argc, char *argv[])
 		numthreads = MAXTHREADS;
 	}
 
+	if (adjust_system_limit(RLIMIT_NPROC, numthreads) || 
+			adjust_system_limit(RLIMIT_NOFILE, numfiles)) {
+		tst_resm(TWARN, "can not run according to current system limition");
+		cleanup();
+		_exit(1);
+	}
+
 	/* Create files */
 	if ((fd = fopen(filename, "w")) == NULL) {
 		tst_resm(TFAIL, "Could not create file");
@@ -135,6 +168,7 @@ int main(int argc, char *argv[])
 	pthread_mutex_init(&c.m, NULL);
 	pthread_cond_init(&c.init_cv, NULL);
 	pthread_cond_init(&c.thr_cv, NULL);
+	pthread_spin_init(&c.fail_lock, PTHREAD_PROCESS_PRIVATE);
 	c.thr_sleeping = 0;
 
 	/* Grab mutex lock */
@@ -159,7 +193,7 @@ int main(int argc, char *argv[])
 		}
 
 	/* Sleep until all threads are created */
-	while (c.thr_sleeping != numthreads)
+	while (c.thr_sleeping != (numthreads - failedthreads))
 		if (pthread_cond_wait(&c.init_cv, &c.m)) {
 			tst_resm(TFAIL,
 				 "error while waiting for reading threads");
@@ -183,7 +217,12 @@ int main(int argc, char *argv[])
 		cleanup();
 	}
 
-	tst_resm(TPASS, "Threads are done reading");
+	if (failedthreads){
+		tst_resm(TFAIL, "Thread %d are done reading, %d failed",
+			numthreads - failedthreads, failedthreads);
+	} else {
+		tst_resm(TPASS, "Threads are done reading");
+	}
 
 	fclose(fd);
 	unlink(filename);
@@ -223,6 +262,11 @@ void *threads(void *thread_id_)
 				close_files(fd_list, i - 1);
 			}
 			unlink(filename);
+			/* Minus the total thread num recording*/
+			pthread_spin_lock(&c.fail_lock);
+			failedthreads++;
+			pthread_spin_unlock(&c.fail_lock);
+			pthread_cond_signal(&c.init_cv);
 			pthread_exit((void *)1);
 		}
 	}
-- 
1.9.3


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
