From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 27 Aug 2018 08:05:55 +0800
Subject: [LTP] [PATCH v2] newlib_tests/test_exec.c: Fix compiler error
	before glibc v2.11
In-Reply-To: <20180824145656.GA5131@rei>
References: <20180824145656.GA5131@rei>
Message-ID: <1535328355-16759-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Before glibc v2.11, execvpe() was not introduced and resulted in
compiler error, so we replace execvpe() with execve() and update
test-writing-guidelines.txt.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 doc/test-writing-guidelines.txt | 8 ++++++--
 lib/newlib_tests/test_exec.c    | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index a169724..0b89cf9 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -697,14 +697,18 @@ a non zero exit code.
 -------------------------------------------------------------------------------
 /* test.c */
 #define _GNU_SOURCE
-#include <stdlib.h>
+#include <unistd.h>
 #include "tst_test.h"
 
 static void do_test(void)
 {
 	char *const argv[] = {"test_exec_child", NULL};
+	char path[4096];
 
-	execvpe(argv[0], argv, environ);
+	if (tst_get_path("test_exec_child", path, sizeof(path)))
+		tst_brk(TCONF, "Couldn't find test_exec_child in $PATH");
+
+	execve(path, argv, environ);
 
 	tst_res(TBROK | TERRNO, "EXEC!");
 }
diff --git a/lib/newlib_tests/test_exec.c b/lib/newlib_tests/test_exec.c
index 8aef621..2c86568 100644
--- a/lib/newlib_tests/test_exec.c
+++ b/lib/newlib_tests/test_exec.c
@@ -25,14 +25,18 @@
  */
 
 #define _GNU_SOURCE
-#include <stdlib.h>
+#include <unistd.h>
 #include "tst_test.h"
 
 static void do_test(void)
 {
 	char *const argv[] = {"test_exec_child", NULL};
+	char path[4096];
 
-	execvpe(argv[0], argv, environ);
+	if (tst_get_path("test_exec_child", path, sizeof(path)))
+		tst_brk(TCONF, "Couldn't find test_exec_child in $PATH");
+
+	execve(path, argv, environ);
 
 	tst_res(TBROK | TERRNO, "EXEC!");
 }
-- 
1.8.3.1



