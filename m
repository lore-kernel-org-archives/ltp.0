From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 23 Aug 2018 17:06:54 +0800
Subject: [LTP] [PATCH] newlib_tests/test_exec.c: Fix compiler error before
	glibc v2.11
Message-ID: <1535015214-4033-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: xiao yang <yangx.jy@cn.fujitsu.com>

Before glibc v2.11, execvpe() was not introduced and resulted in
compiler error, so we replace execvpe() with execve() and update
test-writing-guidelines.txt.

Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
---
 doc/test-writing-guidelines.txt | 11 ++++++++---
 lib/newlib_tests/test_exec.c    | 11 ++++++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index a169724..f62e16e 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -696,15 +696,20 @@ a non zero exit code.
 [source,c]
 -------------------------------------------------------------------------------
 /* test.c */
-#define _GNU_SOURCE
-#include <stdlib.h>
+#include <unistd.h>
 #include "tst_test.h"
 
+extern char **environ;
+
 static void do_test(void)
 {
 	char *const argv[] = {"test_exec_child", NULL};
+	char path[4096];
+
+	if (tst_get_path("test_exec_child", path, sizeof(path)))
+		tst_brk(TCONF, "Couldn't find test_exec_child in $PATH");
 
-	execvpe(argv[0], argv, environ);
+	execve(path, argv, environ);
 
 	tst_res(TBROK | TERRNO, "EXEC!");
 }
diff --git a/lib/newlib_tests/test_exec.c b/lib/newlib_tests/test_exec.c
index 8aef621..e70080e 100644
--- a/lib/newlib_tests/test_exec.c
+++ b/lib/newlib_tests/test_exec.c
@@ -24,15 +24,20 @@
  * $ PATH=$PATH:$PWD ./test_exec
  */
 
-#define _GNU_SOURCE
-#include <stdlib.h>
+#include <unistd.h>
 #include "tst_test.h"
 
+extern char **environ;
+
 static void do_test(void)
 {
 	char *const argv[] = {"test_exec_child", NULL};
+	char path[4096];
+
+	if (tst_get_path("test_exec_child", path, sizeof(path)))
+		tst_brk(TCONF, "Couldn't find test_exec_child in $PATH");
 
-	execvpe(argv[0], argv, environ);
+	execve(path, argv, environ);
 
 	tst_res(TBROK | TERRNO, "EXEC!");
 }
-- 
1.7.11.rc0



