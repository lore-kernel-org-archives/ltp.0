Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1YxBz8-0003Y8-He
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2015 10:21:22 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YxBz7-0000rs-M5
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2015 10:21:22 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t4QALFRk027321
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 26 May 2015 10:21:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t4QALFIm005071
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 26 May 2015 10:21:15 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t4QALFaN028372
	for <ltp-list@lists.sourceforge.net>; Tue, 26 May 2015 10:21:15 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 26 May 2015 13:21:10 +0300
Message-Id: <1432635670-25539-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20150526095837.GE2940@rei.suse.de>
References: <20150526095837.GE2940@rei.suse.de>
Subject: [LTP] [PATCH V2 2/2] Unmap the futexes backend file in tst_rmdir
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
Cc: vasily.isaenko@oracle.com

As of now, test cases utilizing tst_checkpoint framework fail on NFS
with similar errors:

creat07     0  TWARN  :  tst_tmpdir.c:206: tst_rmdir: rmobj(/tmpdir/ltp-0IVQPP0NK6/creigi0kV) failed: remove(/tmpdir/ltp-0IVQPP0NK6/creigi0kV) failed; errno=66: Directory not empty

This happens because we keep the futex page mapped while tst_rmdir() is running.

Let's unmap it before the actual delete procedure.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes since V1:
 * renamed 'futex_t *futexes' to 'futex_t *tst_futexes'


 lib/tst_checkpoint.c |   12 +++++++-----
 lib/tst_tmpdir.c     |   11 +++++++++++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index 0e2c402..a2c9563 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -33,7 +33,7 @@
 
 #define DEFAULT_MSEC_TIMEOUT 10000
 
-static futex_t *futexes;
+futex_t *tst_futexes;
 static int page_size;
 
 void tst_checkpoint_init(const char *file, const int lineno,
@@ -41,7 +41,7 @@ void tst_checkpoint_init(const char *file, const int lineno,
 {
 	int fd;
 
-	if (futexes) {
+	if (tst_futexes) {
 		tst_brkm(TBROK, cleanup_fn,
 		         "%s: %d checkopoints allready initialized",
 		         file, lineno);
@@ -71,7 +71,7 @@ void tst_checkpoint_init(const char *file, const int lineno,
 
 	SAFE_FTRUNCATE(cleanup_fn, fd, page_size);
 
-	futexes = SAFE_MMAP(cleanup_fn, NULL, page_size,
+	tst_futexes = SAFE_MMAP(cleanup_fn, NULL, page_size,
 	                    PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 
 	SAFE_CLOSE(cleanup_fn, fd);
@@ -89,7 +89,8 @@ int tst_checkpoint_wait(unsigned int id, unsigned int msec_timeout)
 	timeout.tv_sec = msec_timeout/1000;
 	timeout.tv_nsec = (msec_timeout%1000) * 1000000;
 
-	return syscall(SYS_futex, &futexes[id], FUTEX_WAIT, futexes[id], &timeout);
+	return syscall(SYS_futex, &tst_futexes[id], FUTEX_WAIT,
+		       tst_futexes[id], &timeout);
 }
 
 int tst_checkpoint_wake(unsigned int id, unsigned int nr_wake,
@@ -103,7 +104,8 @@ int tst_checkpoint_wake(unsigned int id, unsigned int nr_wake,
 	}
 
 	do {
-		waked += syscall(SYS_futex, &futexes[id], FUTEX_WAKE, INT_MAX, NULL);
+		waked += syscall(SYS_futex, &tst_futexes[id], FUTEX_WAKE,
+				 INT_MAX, NULL);
 		usleep(1000);
 		msecs++;
 
diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index dd82f35..f4f3b30 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -57,6 +57,7 @@
  *
  *********************************************************/
 
+#include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <assert.h>
@@ -70,6 +71,7 @@
 #include "test.h"
 #include "rmobj.h"
 #include "ltp_priv.h"
+#include "lapi/futex.h"
 
 /*
  * Define some useful macros.
@@ -97,6 +99,8 @@ static char *TESTDIR = NULL;	/* the directory created */
 
 static char test_start_work_dir[PATH_MAX];
 
+/* lib/tst_checkpoint.c */
+extern futex_t *tst_futexes;
 
 int tst_tmpdir_created(void)
 {
@@ -199,6 +203,13 @@ void tst_rmdir(void)
 	}
 
 	/*
+	 * Unmap the backend file.
+	 * This is needed to overcome the NFS "silly rename" feature.
+	 */
+	if (tst_futexes)
+		munmap((void *)tst_futexes, getpagesize());
+
+	/*
 	 * Attempt to remove the "TESTDIR" directory, using rmobj().
 	 */
 	if (rmobj(TESTDIR, &errmsg) == -1) {
-- 
1.7.1


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
