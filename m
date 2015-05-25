Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1YwnSK-0002VW-VJ
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2015 08:09:52 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YwnSH-0001gG-7W
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2015 08:09:52 +0000
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t4P89gtY014380
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 25 May 2015 08:09:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t4P89gQO023770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 25 May 2015 08:09:42 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t4P89gN4017765
	for <ltp-list@lists.sourceforge.net>; Mon, 25 May 2015 08:09:42 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 25 May 2015 11:09:36 +0300
Message-Id: <1432541376-15153-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [RFC PATCH] tst_checkpoint_destroy
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

Hi.

As of now, if we run test cases which use the tst_checkpoint framework on NFS,
they will fail with errors like:

creat07     0  TWARN  :  tst_tmpdir.c:206: tst_rmdir: rmobj(/tmpdir/ltp-0IVQPP0NK6/creigi0kV) failed: remove(/tmpdir/ltp-0IVQPP0NK6/creigi0kV) failed; errno=66: Directory not empty

This happens because we keep the futex page mapped while tst_rmdir() is running.

So on we need to unmap the page before tst_rmdir().

What do you think about the proposed solution?

Thanks.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/tst_checkpoint.h                  |    9 +++++++++
 lib/tst_checkpoint.c                      |   19 ++++++++++++++++++-
 testcases/kernel/syscalls/creat/creat07.c |    2 ++
 3 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/include/tst_checkpoint.h b/include/tst_checkpoint.h
index e6b8100..95a82b4 100644
--- a/include/tst_checkpoint.h
+++ b/include/tst_checkpoint.h
@@ -48,7 +48,16 @@
 void tst_checkpoint_init(const char *file, const int lineno,
 			 void (*cleanup_fn)(void));
 
+/*
+ * Destroy the checkpoint.
+ *
+ * Call it once you are done with the syncronization.
+ */
+#define TST_CHECKPOINT_DESTROY(cleanup_fn) \
+	tst_checkpoint_destroy(__FILE__, __LINE__, cleanup_fn)
 
+void tst_checkpoint_destroy(const char *file, const int lineno,
+			    void (*cleanup_fn)(void));
 
 /*
  * Waits for wakeup.
diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index 79e49ac..2957f33 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -31,6 +31,7 @@
 #include "safe_macros.h"
 
 #define DEFAULT_MSEC_TIMEOUT 10000
+#define CHECKPOINT_BASE_FILE "checkpoint_futex_base_file"
 
 typedef volatile uint32_t futex_t;
 
@@ -67,7 +68,7 @@ void tst_checkpoint_init(const char *file, const int lineno,
 
 	page_size = getpagesize();
 
-	fd = SAFE_OPEN(cleanup_fn, "checkpoint_futex_base_file",
+	fd = SAFE_OPEN(cleanup_fn, CHECKPOINT_BASE_FILE,
 	               O_RDWR | O_CREAT, 0666);
 
 	SAFE_FTRUNCATE(cleanup_fn, fd, page_size);
@@ -78,6 +79,22 @@ void tst_checkpoint_init(const char *file, const int lineno,
 	SAFE_CLOSE(cleanup_fn, fd);
 }
 
+void tst_checkpoint_destroy(const char *file, const int lineno,
+			    void (*cleanup_fn)(void))
+{
+	if (!futexes || !page_size) {
+		tst_brkm(TBROK, cleanup_fn,
+			 "%s: %d checkpoints are not initialized",
+			 file, lineno);
+	}
+
+	SAFE_MUNMAP(cleanup_fn, (void *)futexes, page_size);
+
+	futexes = NULL;
+
+	SAFE_UNLINK(cleanup_fn, CHECKPOINT_BASE_FILE);
+}
+
 int tst_checkpoint_wait(unsigned int id, unsigned int msec_timeout)
 {
 	struct timespec timeout;
diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
index c3cbd37..7b67d73 100644
--- a/testcases/kernel/syscalls/creat/creat07.c
+++ b/testcases/kernel/syscalls/creat/creat07.c
@@ -106,5 +106,7 @@ static void setup(void)
 
 static void cleanup(void)
 {
+	TST_CHECKPOINT_DESTROY(NULL);
+
 	tst_rmdir();
 }
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
