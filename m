From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Aug 2021 15:41:19 +0200
Subject: [LTP] [PATCH] [v2,1/4] syscalls/chroot01: Convert to new API
In-Reply-To: <20210806035952.18150-1-zhanglianjie@uniontech.com>
References: <20210806035952.18150-1-zhanglianjie@uniontech.com>
Message-ID: <YREwf0nD/azWBuiy@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor changes.

Most important is that the description comment section should be called
[Description] not [DESCRIPTION].

Full diff:

diff --git a/testcases/kernel/syscalls/chroot/chroot01.c b/testcases/kernel/syscalls/chroot/chroot01.c
index bddbf0db5..581bd54ac 100644
--- a/testcases/kernel/syscalls/chroot/chroot01.c
+++ b/testcases/kernel/syscalls/chroot/chroot01.c
@@ -4,9 +4,10 @@
  */
 
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Testcase to check the whether chroot sets errno to EPERM.
+ *
  * As a non-root user attempt to perform chroot() to a directory. The
  * chroot() call should fail with EPERM
  */
@@ -16,18 +17,18 @@
 #include "tst_test.h"
 
 static char *path;
-static char nobody_uid[] = "nobody";
-static struct passwd *ltpuser;
 
 static void verify_chroot(void)
 {
-	TST_EXP_FAIL(chroot(path), EPERM, "chroot set errno to EPERM.");
+	TST_EXP_FAIL(chroot(path), EPERM, "unprivileged chroot()");
 }
 
 static void setup(void)
 {
+	struct passwd *ltpuser;
+
 	path = tst_get_tmpdir();
-	ltpuser = SAFE_GETPWNAM(nobody_uid);
+	ltpuser = SAFE_GETPWNAM("nobody");
 	SAFE_SETEUID(ltpuser->pw_uid);
 }
 

-- 
Cyril Hrubis
chrubis@suse.cz
