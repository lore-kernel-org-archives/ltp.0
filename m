From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Aug 2021 11:35:56 +0200
Subject: [LTP] [PATCH v3, 2/4] syscalls/chroot02: Convert to new API
In-Reply-To: <20210810015235.20965-1-zhanglianjie@uniontech.com>
References: <20210810015235.20965-1-zhanglianjie@uniontech.com>
Message-ID: <YRJIfC59VliHPOOs@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor changes, thanks.

Diff:

diff --git a/testcases/kernel/syscalls/chroot/chroot02.c b/testcases/kernel/syscalls/chroot/chroot02.c
index 141604406..ad33abdcc 100644
--- a/testcases/kernel/syscalls/chroot/chroot02.c
+++ b/testcases/kernel/syscalls/chroot/chroot02.c
@@ -9,20 +9,23 @@
 /*\
  * [Description]
  *
- * - Create a file in the temporary directory;
- * - Change the root to this temporary directory;
- * - Check whether this file can be accessed in the new root directory;
+ * Basic chroot() functionality test.
+ *
+ * - Create a file in the temporary directory
+ * - Change the root to this temporary directory
+ * - Check whether this file can be accessed in the new root directory
  */
 
 #include <stdlib.h>
 #include "tst_test.h"
 
 #define TMP_FILENAME	"chroot02_testfile"
-static struct stat buf;
 static char *path;
 
 static void verify_chroot(void)
 {
+	struct stat buf;
+
 	if (!SAFE_FORK()) {
 		TST_EXP_PASS(chroot(path), "chroot(%s)", path);
 		if (!TST_PASS)
@@ -36,7 +39,6 @@ static void setup(void)
 {
 	path = tst_get_tmpdir();
 	SAFE_TOUCH(TMP_FILENAME, 0666, NULL);
-	SAFE_STAT(TMP_FILENAME, &buf);
 }
 
 static void cleanup(void)

-- 
Cyril Hrubis
chrubis@suse.cz
