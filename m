From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Tue, 15 Nov 2016 13:19:34 +0100
Subject: [LTP]  [PATCH v5 2/5] llistxattr: moved to using safe macros
In-Reply-To: <1479212377-12830-1-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1479212377-12830-1-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <1479212377-12830-3-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Apply newly created SAFE_LSETXATTR() macro to all files
that test llistxattr().

Signed-off-by: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
---
 .../kernel/syscalls/llistxattr/llistxattr01.c      | 25 ++--------------------
 .../kernel/syscalls/llistxattr/llistxattr02.c      | 12 +----------
 .../kernel/syscalls/llistxattr/llistxattr03.c      | 12 +----------
 3 files changed, 4 insertions(+), 45 deletions(-)

diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr01.c b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
index 2e95faf..f352032 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr01.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
@@ -43,27 +43,6 @@
 #define VALUE_SIZE	4
 #define KEY_SIZE    17
 
-static void set_xattr(const char *path, const char *key)
-{
-	int n;
-
-	n = lsetxattr(path, key, VALUE, VALUE_SIZE, XATTR_CREATE);
-	if (n == -1) {
-		if (errno == ENOTSUP) {
-			tst_brk(TCONF,
-				 "no xattr support in fs or mounted "
-				 "without user_xattr option");
-		}
-
-		if (errno == EEXIST) {
-			tst_brk(TBROK, "exist attribute %s", key);
-		} else {
-			tst_brk(TBROK | TERRNO,
-				 "lsetxattr() failed");
-		}
-	}
-}
-
 static int has_attribute(const char *list, int llen, const char *attr)
 {
 	int i;
@@ -106,9 +85,9 @@ static void setup(void)
 
 	SAFE_SYMLINK("testfile", "symlink");
 
-	set_xattr("testfile", SECURITY_KEY1);
+	SAFE_LSETXATTR("testfile", SECURITY_KEY1, VALUE, VALUE_SIZE, XATTR_CREATE);
 
-	set_xattr("symlink", SECURITY_KEY2);
+	SAFE_LSETXATTR("symlink", SECURITY_KEY2, VALUE, VALUE_SIZE, XATTR_CREATE);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr02.c b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
index ec4ba6e..2812838 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr02.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
@@ -80,21 +80,11 @@ static void verify_llistxattr(unsigned int n)
 
 static void setup(void)
 {
-	int n;
-
 	SAFE_TOUCH("testfile", 0644, NULL);
 
 	SAFE_SYMLINK("testfile", "symlink");
 
-	n = lsetxattr("symlink", SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
-	if (n == -1) {
-		if (errno == ENOTSUP) {
-			tst_brk(TCONF, "no xattr support in fs or "
-				 "mounted without user_xattr option");
-		} else {
-			tst_brk(TBROK | TERRNO, "lsetxattr() failed");
-		}
-	}
+	SAFE_LSETXATTR("symlink", SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr03.c b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
index e6e4c68..475375e 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr03.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
@@ -71,21 +71,11 @@ static void verify_llistxattr(unsigned int n)
 
 static void setup(void)
 {
-	int ret;
-
 	SAFE_TOUCH(filename[0], 0644, NULL);
 
 	SAFE_TOUCH(filename[1], 0644, NULL);
 
-	ret = lsetxattr(filename[1], SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
-	if (ret == -1) {
-		if (errno == ENOTSUP) {
-			tst_brk(TCONF, "no xattr support in fs or "
-				 "mounted without user_xattr option");
-		} else {
-			tst_brk(TBROK | TERRNO, "lsetxattr() failed");
-		}
-	}
+	SAFE_LSETXATTR(filename[1], SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
 }
 
 static struct tst_test test = {
-- 
1.9.1

