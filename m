From: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Date: Mon, 22 Aug 2016 16:38:40 +0300
Subject: [LTP] [PATCH 2/2] syscalls/getrusage03: Reduce memory consumption
In-Reply-To: <1471873120-4272-1-git-send-email-yuriy.kolerov@synopsys.com>
References: <1471873120-4272-1-git-send-email-yuriy.kolerov@synopsys.com>
Message-ID: <1471873120-4272-2-git-send-email-yuriy.kolerov@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some development platforms may lack of large amounts of memory (~500MB).
It is possible to reduce memory consumption in this test without harm
to functionality.

Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
---
 testcases/kernel/syscalls/getrusage/getrusage03.c |  6 +++---
 testcases/kernel/syscalls/getrusage/getrusage03.h | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index 5214d36..9bc984d 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -118,7 +118,7 @@ static void inherit_fork(void)
 }
 
 /* Testcase #02: fork inherit (cont.)
- * expect: initial.children ~= 100MB, child.children = 0 */
+ * expect: initial.children ~= 50MB, child.children = 0 */
 static void inherit_fork2(void)
 {
 	tst_resm(TINFO, "Testcase #02: fork inherit(cont.)");
@@ -181,7 +181,7 @@ static void fork_malloc(void)
 }
 
 /* Testcase #04: grandchild maxrss
- * expect: post_wait.children ~= 300MB */
+ * expect: post_wait.children ~= 150MB */
 static void grandchild_maxrss(void)
 {
 	tst_resm(TINFO, "Testcase #04: grandchild maxrss");
@@ -216,7 +216,7 @@ static void grandchild_maxrss(void)
 }
 
 /* Testcase #05: zombie
- * expect: initial ~= pre_wait, post_wait ~= 400MB */
+ * expect: initial ~= pre_wait, post_wait ~= 150MB */
 static void zombie(void)
 {
 	tst_resm(TINFO, "Testcase #05: zombie");
diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.h b/testcases/kernel/syscalls/getrusage/getrusage03.h
index 7dc6d0a..c7bc0af 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.h
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.h
@@ -18,12 +18,12 @@
 #ifndef GETRUSAGE03_H
 #define GETRUSAGE03_H
 
-#define DELTA_MAX_KB		102400
-#define CONSUME_INITIAL_MB	100
+#define DELTA_MAX_KB		51200
+#define CONSUME_INITIAL_MB	50
 #define CONSUME_FORK_MALLOC_MB	50
-#define CONSUME_GRANDCHILD_MB	300
-#define CONSUME_ZOMBIE_MB	400
-#define CONSUME_SIG_IGN_MB	500
+#define CONSUME_GRANDCHILD_MB	150
+#define CONSUME_ZOMBIE_MB	200
+#define CONSUME_SIG_IGN_MB	250
 
 #define N_TO_STR(s) _N_TO_STR(s)
 #define _N_TO_STR(s) #s
-- 
2.7.4


