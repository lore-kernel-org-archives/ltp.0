From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 16 Nov 2018 20:37:47 +0100
Subject: [LTP] [PATCH v3 2/2] syscalls/lremovexattr: Add lremovexattr()
	test
In-Reply-To: <20181108183320.11262-2-rafael.tinoco@linaro.org>
References: <20181107153855.GA8153@rei>
 <20181108183320.11262-1-rafael.tinoco@linaro.org>
 <20181108183320.11262-2-rafael.tinoco@linaro.org>
Message-ID: <20181116193747.GA17471@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, see below, thanks.

diff --git a/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c b/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
index 2cf46ebdf..26194f114 100644
--- a/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
+++ b/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
@@ -18,7 +18,7 @@
  * Note:
  * According to attr(5), extended attributes are interpreted differently from
  * regular files, directories and symbolic links. User attributes are only
- * allowed for regular files and directories, thus the need of using security.*
+ * allowed for regular files and directories, thus the need of using trusted.*
  * attributes for this test.
  */
 
@@ -39,7 +39,7 @@
 
 #define ENOATTR ENODATA
 
-#define XATTR_KEY		"security.key1"
+#define XATTR_KEY		"trusted.key1"
 #define XATTR_VALUE		"file and link"
 #define XATTR_VALUE_SIZE	13
 
@@ -79,8 +79,8 @@ static void verify_lremovexattr(void)
 		return;
 	}
 
-	if (TST_RET < 0 && TST_ERR != ENOATTR) {
-		tst_brk(TBROK, "lgetxattr(2) failed unexpectedly");
+	if (TST_ERR != ENOATTR) {
+		tst_brk(TBROK | TTERRNO, "lgetxattr(2) failed unexpectedly");
 		return;
 	}
 
@@ -111,10 +111,8 @@ static void setup(void)
 {
 	SAFE_TOUCH(FILENAME, 0644, NULL);
 
-	if (symlink(FILENAME, SYMLINK) < 0) {
+	if (symlink(FILENAME, SYMLINK) < 0)
 		tst_brk(TCONF, "symlink() not supported");
-		return;
-	}
 }
 
 static struct tst_test test = {



I've found that the trusted attributes works as well and cannot be
disabled in kernel (at least for ext3 security attributes have their own
CONFIG switches).

The rest is just removed unreachable or always true code.

-- 
Cyril Hrubis
chrubis@suse.cz
