From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Mon,  3 Oct 2016 13:16:31 +0200
Subject: [LTP]  [PATCH] Fix typos in assignments to the field tid
Message-ID: <1475493391-9643-1-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

llistxattr02 -> llistxattr03
sokcetpair01 -> socketpair01
madvice05 -> madvise05

---
 testcases/kernel/syscalls/llistxattr/llistxattr03.c | 14 ++++++++------
 testcases/kernel/syscalls/madvise/madvise05.c       |  2 +-
 testcases/kernel/syscalls/socketpair/socketpair01.c |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr03.c b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
index 5513019..779fa96 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr03.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
@@ -27,13 +27,15 @@
 #include <errno.h>
 #include <sys/types.h>
 
-#ifdef HAVE_ATTR_XATTR_H
-# include <attr/xattr.h>
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
+#elif HAVE_ATTR_XATTR_H
+#include <attr/xattr.h>
 #endif
 
 #include "tst_test.h"
 
-#ifdef HAVE_ATTR_XATTR_H
+#if defined(HAVE_SYS_XATTR_H) || defined(HAVE_ATTR_XATTR_H)
 
 #define SECURITY_KEY	"security.ltptest"
 #define VALUE	"test"
@@ -89,7 +91,7 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "llistxattr02",
+	.tid = "llistxattr03",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.test = verify_llistxattr,
@@ -97,6 +99,6 @@ static struct tst_test test = {
 	.setup = setup,
 };
 
-#else /* HAVE_ATTR_XATTR_H */
-	TST_TEST_TCONF("<attr/xattr.h> does not exist.");
+#else /* HAVE_SYS_XATTR_H or HAVE_ATTR_XATTR_H */
+	TST_TEST_TCONF("neither <sys/xattr.h> nor <attr/xattr.h> does not exist.");
 #endif
diff --git a/testcases/kernel/syscalls/madvise/madvise05.c b/testcases/kernel/syscalls/madvise/madvise05.c
index 612c967..4f8718f 100644
--- a/testcases/kernel/syscalls/madvise/madvise05.c
+++ b/testcases/kernel/syscalls/madvise/madvise05.c
@@ -55,7 +55,7 @@ static void verify_madvise(void)
 }
 
 static struct tst_test test = {
-	.tid = "madvice05",
+	.tid = "madvise05",
 	.min_kver = "3.9.0",
 	.test_all = verify_madvise,
 };
diff --git a/testcases/kernel/syscalls/socketpair/socketpair01.c b/testcases/kernel/syscalls/socketpair/socketpair01.c
index 63c2030..f7833a4 100644
--- a/testcases/kernel/syscalls/socketpair/socketpair01.c
+++ b/testcases/kernel/syscalls/socketpair/socketpair01.c
@@ -102,7 +102,7 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "sokcetpair01",
+	.tid = "socketpair01",
 	.tcnt = ARRAY_SIZE(tdat),
 	.setup = setup,
 	.test = verify_socketpair
-- 
1.9.1

