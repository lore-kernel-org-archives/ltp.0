From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Aug 2021 16:28:38 +0200
Subject: [LTP] [PATCH] [4/4] syscalls/chroot04: Convert to new API
In-Reply-To: <20210806040046.18836-1-zhanglianjie@uniontech.com>
References: <20210806040046.18836-1-zhanglianjie@uniontech.com>
Message-ID: <YRE7luQRhPpa3TbT@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with similar changes as in chroot01.c, thanks.

Full diff:

diff --git a/testcases/kernel/syscalls/chroot/chroot04.c b/testcases/kernel/syscalls/chroot/chroot04.c
index b65b09d79..ed0f66323 100644
--- a/testcases/kernel/syscalls/chroot/chroot04.c
+++ b/testcases/kernel/syscalls/chroot/chroot04.c
@@ -7,9 +7,13 @@
   */
 
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
- *	Testcase to check that chroot sets errno to EACCES.
+ * Testcase to check that chroot sets errno to EACCES.
+ *
+ * As a non-root user attempt to perform chroot() to a directory that the user
+ * does not have a search permission for. The chroot() call should fail with
+ * EACESS.
  */
 
 #include <stdio.h>
@@ -17,21 +21,19 @@
 #include "tst_test.h"
 
 #define TEST_TMPDIR	"chroot04_tmpdir"
-static char nobody_uid[] = "nobody";
-static struct passwd *ltpuser;
 
 static void verify_chroot(void)
 {
-	TST_EXP_FAIL(chroot(TEST_TMPDIR), EACCES, "got EACCESS as expected");
+	TST_EXP_FAIL(chroot(TEST_TMPDIR), EACCES, "no search permission chroot()");
 }
 
 static void setup(void)
 {
-	/*
-	 * create a temporary directory
-	 */
+	struct passwd *ltpuser;
+
 	SAFE_MKDIR(TEST_TMPDIR, 0222);
-	ltpuser = SAFE_GETPWNAM(nobody_uid);
+
+	ltpuser = SAFE_GETPWNAM("nobody");
 	SAFE_SETEUID(ltpuser->pw_uid);
 }
 

-- 
Cyril Hrubis
chrubis@suse.cz
