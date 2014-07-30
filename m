Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1XCLE2-000052-W7
	for ltp-list@lists.sourceforge.net; Wed, 30 Jul 2014 04:10:51 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XCLE1-0008VV-V8
	for ltp-list@lists.sourceforge.net; Wed, 30 Jul 2014 04:10:50 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s6U4Alsh014376
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Jul 2014 12:10:47 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 30 Jul 2014 12:09:40 +0800
Message-ID: <1406693380-30287-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1406693380-30287-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <53D8631F.1000105@cn.fujitsu.com>
	<1406693380-30287-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 2/2] lib/tst_tmpdir.c: force environment variable
	TMPDIR using an absolute pathname
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

In lib/tst_tmpdir.c, when TESTDIR is not an absolute patchname beginning with '/',
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
because we can change to any directory in test case, which TESTDIR may no be
child directory of current_dir, we should fix this.

Now we decide to use absolute pathname for TMPDIR, this will greatly simplify
the code in tst_rmdir().

If we still want to use relative path in TMPDIR, we may change the code in tst_rmdir()
to chdir(test_start_work_dir) first, but this chdir() operation still will fail sometimes,
this is because some components' search permission in test_start_work_dir may be denied(
some test cases are run by root, but then may call setuid(), see access05.c). So I think
we should obey the rule 'fail fast', just using absolute pathname instead.

Though this may be not friendly to to usrs, users rarely export a different
TMPDIR other than /tmp, so it's OK.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 lib/tst_tmpdir.c | 65 +++++++++++++++++++-------------------------------------
 1 file changed, 22 insertions(+), 43 deletions(-)

diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 8cbd89c..ede8f89 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -120,17 +120,30 @@ void tst_tmpdir(void)
 {
 	char template[PATH_MAX];
 	char *env_tmpdir;	/* temporary storage for TMPDIR env var */
-	char *errmsg;
+	char *errmsg, *c;
 
 	/*
 	 * Create a template for the temporary directory.  Use the
 	 * environment variable TMPDIR if it is available, otherwise
 	 * use our default TEMPDIR.
 	 */
-	if ((env_tmpdir = getenv("TMPDIR")))
+	env_tmpdir = getenv("TMPDIR");
+	if (env_tmpdir) {
+		c = strchr(env_tmpdir, '/');
+		/*
+		 * Now we force environment variable TMPDIR to be an absolute
+		 * pathname, which dose not make much sense, but it will
+		 * greatly simplify code in tst_rmdir().
+		 */
+		if (c != env_tmpdir) {
+			tst_brkm(TBROK, tmpdir_cleanup, "You must specify "
+				 "an absolute pathname for environment "
+				 "variable TMPDIR");
+		}
 		snprintf(template, PATH_MAX, "%s/%.3sXXXXXX", env_tmpdir, TCID);
-	else
+	} else {
 		snprintf(template, PATH_MAX, "%s/%.3sXXXXXX", TEMPDIR, TCID);
+	}
 
 	/* Make the temporary directory in one shot using mkdtemp. */
 	if (mkdtemp(template) == NULL)
@@ -159,23 +172,21 @@ void tst_tmpdir(void)
 	 * fails, also issue a TWARN message.
 	 */
 	if (chdir(TESTDIR) == -1) {
-		tst_brkm(TBROK | TERRNO, NULL, "%s: chdir(%s) failed",
-			 __func__, TESTDIR);
+		tst_resm(TERRNO, "%s: chdir(%s) failed", __func__, TESTDIR);
 
 		/* Try to remove the directory */
-		if (rmobj(TESTDIR, &errmsg) == -1)
+		if (rmobj(TESTDIR, &errmsg) == -1) {
 			tst_resm(TWARN, "%s: rmobj(%s) failed: %s",
 				 __func__, TESTDIR, errmsg);
+		}
 
-		tmpdir_cleanup();
+		tst_exit();
 	}
 }
 
 void tst_rmdir(void)
 {
-	char current_dir[PATH_MAX];
 	char *errmsg;
-	char *parent_dir;
 
 	/*
 	 * Check that TESTDIR is not NULL.
@@ -187,45 +198,13 @@ void tst_rmdir(void)
 		return;
 	}
 
-	if ((parent_dir = malloc(PATH_MAX)) == NULL) {
-		/* Make sure that we exit quickly and noisily. */
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "%s: malloc(%d) failed", __func__, PATH_MAX);
-	}
-
-	/*
-	 * Get the directory name of TESTDIR.  If TESTDIR is a relative path,
-	 * get full path.
-	 */
-	if (TESTDIR[0] != '/') {
-		if (getcwd(current_dir, PATH_MAX) == NULL)
-			strncpy(parent_dir, TESTDIR, PATH_MAX);
-		else
-			sprintf(parent_dir, "%s/%s", current_dir, TESTDIR);
-	} else {
-		strcpy(parent_dir, TESTDIR);
-	}
-
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
-	}
-
 	/*
 	 * Attempt to remove the "TESTDIR" directory, using rmobj().
 	 */
-	if (rmobj(TESTDIR, &errmsg) == -1)
+	if (rmobj(TESTDIR, &errmsg) == -1) {
 		tst_resm(TWARN, "%s: rmobj(%s) failed: %s",
 			 __func__, TESTDIR, errmsg);
+	}
 }
 
 /*
-- 
1.8.2.1


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
