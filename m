Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1X9qNu-0000Mr-Lf
	for ltp-list@lists.sourceforge.net; Wed, 23 Jul 2014 06:50:42 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X9qNs-0001W3-P6
	for ltp-list@lists.sourceforge.net; Wed, 23 Jul 2014 06:50:42 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s6N6oT7w000376
	for <ltp-list@lists.sourceforge.net>; Wed, 23 Jul 2014 14:50:29 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 23 Jul 2014 14:49:49 +0800
Message-ID: <1406098189-26377-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <53CF585E.5010602@cn.fujitsu.com>
References: <53CF585E.5010602@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] lib/tst_tmpdir.c: fix bug when TESTDIR is not a
	absolute pathname
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

In lib/tst_tmpdir.c, when TESTDIR is not a absolute patchname beginning with '/',
The corresponding code logic would be below:
if (TESTDIR[0] != '/') {
	if (getcwd(current_dir, PATH_MAX) == NULL)
		strncpy(parent_dir, TESTDIR, PATH_MAX);
	else
		sprintf(parent_dir, "%s/%s", current_dir, TESTDIR);
} else {
	...
}

The statement "sprintf(parent_dir, "%s/%s", current_dir, TESTDIR);" is wrong,
because we can change to any directory, which TESTDIR may no be child directory
of current_dir, fix this.

Steps to reproduce this bug:
This will output the below errors:
fallocate01    1  TPASS  :  fallocate(3, 0, 49152, 4096) returned 0
fallocate01    2  TPASS  :  write operation on fallocated(3, 0, 49152, 4096) returned 1
fallocate01    3  TPASS  :  fallocate(4, 1, 49152, 4096) returned 0
fallocate01    4  TPASS  :  write operation on fallocated(4, 1, 49152, 4096) returned 1
fallocate01    0  TWARN  :  tst_rmdir: chdir(/home/lege/extern_stroage/ltp-dev/testcases/kernel/syscalls/fallocate/testdir/falkmsya7/testdir) failed
Attempting to remove temp dir anyway: errno=ENOENT(2): No such file or directory
fallocate01    0  TWARN  :  tst_rmdir: rmobj(testdir/falkmsya7) failed: lstat(testdir/falkmsya7) failed; errno=2: No such file or directory

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 lib/tst_tmpdir.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 600d178..cd4b39a 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -148,8 +148,8 @@ void tst_tmpdir(void)
 			 "chmod(%s, %#o) failed", TESTDIR, DIR_MODE);
 
 	if (getcwd(test_start_work_dir, sizeof(test_start_work_dir)) == NULL) {
-		tst_resm(TINFO, "Failed to record test working dir");
-		test_start_work_dir[0] = '\0';
+		tst_brkm(TBROK | TERRNO, tmpdir_cleanup,
+			 "Failed to record test working dir");
 	}
 
 	/*
@@ -173,7 +173,6 @@ void tst_tmpdir(void)
 
 void tst_rmdir(void)
 {
-	char current_dir[PATH_MAX];
 	char *errmsg;
 	char *parent_dir;
 
@@ -198,26 +197,29 @@ void tst_rmdir(void)
 	 * get full path.
 	 */
 	if (TESTDIR[0] != '/') {
-		if (getcwd(current_dir, PATH_MAX) == NULL)
-			strncpy(parent_dir, TESTDIR, PATH_MAX);
-		else
-			sprintf(parent_dir, "%s/%s", current_dir, TESTDIR);
+		if (chdir(test_start_work_dir) != 0) {
+			tst_resm(TWARN | TERRNO, "%s: chdir(%s) failed\n"
+				 "Attempting to remove temp dir anyway",
+				 __func__, test_start_work_dir);
+		}
 	} else {
 		strcpy(parent_dir, TESTDIR);
-	}
 
-	if ((parent_dir = dirname(parent_dir)) == NULL) {
-		tst_resm(TWARN | TERRNO, "%s: dirname failed", __func__);
-		return;
-	}
-
-	/*
-	 * Change directory to parent_dir (The dir above TESTDIR).
-	 */
-	if (chdir(parent_dir) != 0) {
-		tst_resm(TWARN | TERRNO,
-			 "%s: chdir(%s) failed\nAttempting to remove temp dir "
-			 "anyway", __func__, parent_dir);
+		parent_dir = dirname(parent_dir);
+		if (parent_dir == NULL) {
+			tst_resm(TWARN | TERRNO,
+				 "%s: dirname failed", __func__);
+			return;
+		}
+
+		/*
+		 * Change directory to parent_dir (The dir above TESTDIR).
+		 */
+		if (chdir(parent_dir) != 0) {
+			tst_resm(TWARN | TERRNO, "%s: chdir(%s) failed\n"
+				 "Attempting to remove temp dir anyway",
+				 __func__, parent_dir);
+		}
 	}
 
 	/*
-- 
1.8.2.1


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
