From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Wed,  2 Nov 2016 11:59:48 +0100
Subject: [LTP]  [PATCH v3 2/5] llistxattr: moved to using safe macros
In-Reply-To: <1478084391-30192-1-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1478084391-30192-1-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <1478084391-30192-3-git-send-email-dejan.jovicevic@rt-rk.com>
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
 .../kernel/syscalls/llistxattr/llistxattr02.c      | 10 +--------
 .../kernel/syscalls/llistxattr/llistxattr03.c      | 10 +--------
 3 files changed, 4 insertions(+), 41 deletions(-)

diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr01.c b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
index 03d7f85..ef27991 100644
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
index ec4ba6e..7c09b5b 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr02.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
@@ -86,15 +86,7 @@ static void setup(void)
 
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
index 9b65de9..da16048 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr03.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
@@ -77,15 +77,7 @@ static void setup(void)
 
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

