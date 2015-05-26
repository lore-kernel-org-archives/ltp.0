Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1YxAyO-0000el-GE
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2015 09:16:32 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YxAyN-00050S-Nh
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2015 09:16:32 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t4Q9GPMw007646
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 26 May 2015 09:16:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t4Q9GPmH018090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 26 May 2015 09:16:25 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t4Q9GPRH018712
	for <ltp-list@lists.sourceforge.net>; Tue, 26 May 2015 09:16:25 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 26 May 2015 12:16:17 +0300
Message-Id: <1432631777-22549-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1432631777-22549-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <20150526084019.GA2940@rei.suse.de>
	<1432631777-22549-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 2/2] Unmap the futexes backend file in tst_rmdir
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
 lib/tst_checkpoint.c |    2 +-
 lib/tst_tmpdir.c     |   11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index 0e2c402..36eeff2 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -33,7 +33,7 @@
 
 #define DEFAULT_MSEC_TIMEOUT 10000
 
-static futex_t *futexes;
+futex_t *futexes;
 static int page_size;
 
 void tst_checkpoint_init(const char *file, const int lineno,
diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index dd82f35..6a6c0c0 100644
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
+extern futex_t *futexes;
 
 int tst_tmpdir_created(void)
 {
@@ -199,6 +203,13 @@ void tst_rmdir(void)
 	}
 
 	/*
+	 * Unmap the backend file.
+	 * This is needed to overcome the NFS "silly rename" feature.
+	 */
+	if (futexes)
+		munmap((void *)futexes, getpagesize());
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
