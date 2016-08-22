From: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Date: Mon, 22 Aug 2016 16:38:39 +0300
Subject: [LTP] [PATCH 1/2] syscalls/getrusage03: Use constants instead of
	magic numbers
Message-ID: <1471873120-4272-1-git-send-email-yuriy.kolerov@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
---
 testcases/kernel/syscalls/getrusage/getrusage03.c  | 53 +++++++++++-----------
 testcases/kernel/syscalls/getrusage/getrusage03.h  | 36 +++++++++++++++
 .../kernel/syscalls/getrusage/getrusage03_child.c  |  7 ++-
 3 files changed, 66 insertions(+), 30 deletions(-)
 create mode 100644 testcases/kernel/syscalls/getrusage/getrusage03.h

diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index 54cdc83..5214d36 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -41,12 +41,11 @@
 
 #include "test.h"
 #include "safe_macros.h"
+#include "getrusage03.h"
 
 char *TCID = "getrusage03";
 int TST_TOTAL = 1;
 
-#define DELTA_MAX	10240
-
 static struct rusage ru;
 static long maxrss_init;
 static int retval, status;
@@ -76,8 +75,8 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		tst_resm(TINFO, "allocate 100MB");
-		consume(100);
+		tst_resm(TINFO, "allocate %dMB", CONSUME_INITIAL_MB);
+		consume(CONSUME_INITIAL_MB);
 
 		inherit_fork();
 		inherit_fork2();
@@ -126,10 +125,10 @@ static void inherit_fork2(void)
 
 	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
 	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
-	if (is_in_delta(ru.ru_maxrss - 102400))
-		tst_resm(TPASS, "initial.children ~= 100MB");
+	if (is_in_delta(ru.ru_maxrss - CONSUME_INITIAL_MB * 1024))
+		tst_resm(TPASS, "initial.children ~= %dMB", CONSUME_INITIAL_MB);
 	else
-		tst_resm(TFAIL, "initial.children !~= 100MB");
+		tst_resm(TFAIL, "initial.children !~= %dMB", CONSUME_INITIAL_MB);
 
 	switch (pid = fork()) {
 	case -1:
@@ -162,19 +161,23 @@ static void fork_malloc(void)
 		tst_brkm(TBROK | TERRNO, cleanup, "fork #3");
 	case 0:
 		maxrss_init = ru.ru_maxrss;
-		tst_resm(TINFO, "child allocate +50MB");
-		consume(50);
+		tst_resm(TINFO, "child allocate +%dMB", CONSUME_FORK_MALLOC_MB);
+		consume(CONSUME_FORK_MALLOC_MB);
 		SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
 		tst_resm(TINFO, "child.self = %ld", ru.ru_maxrss);
-		exit(is_in_delta(maxrss_init + 51200 - ru.ru_maxrss));
+		exit(is_in_delta(maxrss_init + CONSUME_FORK_MALLOC_MB * 1024 -
+				 ru.ru_maxrss));
 	default:
 		break;
 	}
 
 	if (waitpid(pid, &status, WUNTRACED | WCONTINUED) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
-	check_return(WEXITSTATUS(status), "initial.self + 50MB ~= child.self",
-		     "initial.self + 50MB !~= child.self");
+	check_return(WEXITSTATUS(status),
+		     "initial.self + " N_TO_STR(CONSUME_FORK_MALLOC_MB)
+		     "MB ~= child.self",
+		     "initial.self + " N_TO_STR(CONSUME_FORK_MALLOC_MB)
+		     "MB !~= child.self");
 }
 
 /* Testcase #04: grandchild maxrss
@@ -190,7 +193,8 @@ static void grandchild_maxrss(void)
 	case -1:
 		tst_brkm(TBROK | TERRNO, cleanup, "fork #4");
 	case 0:
-		retval = system("getrusage03_child -g 300");
+		retval = system("getrusage03_child -g "
+				N_TO_STR(CONSUME_GRANDCHILD_MB));
 		if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
 			tst_brkm(TBROK | TERRNO, cleanup, "system");
 		exit(0);
@@ -205,10 +209,10 @@ static void grandchild_maxrss(void)
 
 	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
 	tst_resm(TINFO, "post_wait.children = %ld", ru.ru_maxrss);
-	if (is_in_delta(ru.ru_maxrss - 307200))
-		tst_resm(TPASS, "child.children ~= 300MB");
+	if (is_in_delta(ru.ru_maxrss - CONSUME_GRANDCHILD_MB * 1024))
+		tst_resm(TPASS, "child.children ~= %dMB", CONSUME_GRANDCHILD_MB);
 	else
-		tst_resm(TFAIL, "child.children !~= 300MB");
+		tst_resm(TFAIL, "child.children !~= %dMB", CONSUME_GRANDCHILD_MB);
 }
 
 /* Testcase #05: zombie
@@ -225,7 +229,8 @@ static void zombie(void)
 	case -1:
 		tst_brkm(TBROK, cleanup, "fork #5");
 	case 0:
-		retval = system("getrusage03_child -n 400");
+		retval = system("getrusage03_child -n "
+				N_TO_STR(CONSUME_ZOMBIE_MB));
 		if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
 			tst_brkm(TBROK | TERRNO, cleanup, "system");
 		exit(0);
@@ -248,10 +253,10 @@ static void zombie(void)
 
 	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
 	tst_resm(TINFO, "post_wait.children = %ld", ru.ru_maxrss);
-	if (is_in_delta(ru.ru_maxrss - 409600))
-		tst_resm(TPASS, "post_wait.children ~= 400MB");
+	if (is_in_delta(ru.ru_maxrss - CONSUME_ZOMBIE_MB * 1024))
+		tst_resm(TPASS, "post_wait.children ~= %dMB", CONSUME_ZOMBIE_MB);
 	else
-		tst_resm(TFAIL, "post_wait.children !~= 400MB");
+		tst_resm(TFAIL, "post_wait.children !~= %dMB", CONSUME_ZOMBIE_MB);
 }
 
 /* Testcase #06: SIG_IGN
@@ -269,7 +274,8 @@ static void sig_ign(void)
 	case -1:
 		tst_brkm(TBROK, cleanup, "fork #6");
 	case 0:
-		retval = system("getrusage03_child -n 500");
+		retval = system("getrusage03_child -n "
+				N_TO_STR(CONSUME_SIG_IGN_MB));
 		if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
 			tst_brkm(TBROK | TERRNO, cleanup, "system");
 		exit(0);
@@ -310,11 +316,6 @@ static void exec_without_fork(void)
 		tst_brkm(TBROK | TERRNO, cleanup, "execlp");
 }
 
-static int is_in_delta(long value)
-{
-	return (value >= -DELTA_MAX && value <= DELTA_MAX);
-}
-
 static void check_return(int status, char *pass_msg, char *fail_msg)
 {
 	switch (status) {
diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.h b/testcases/kernel/syscalls/getrusage/getrusage03.h
new file mode 100644
index 0000000..7dc6d0a
--- /dev/null
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright (c) 2016 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef GETRUSAGE03_H
+#define GETRUSAGE03_H
+
+#define DELTA_MAX_KB		102400
+#define CONSUME_INITIAL_MB	100
+#define CONSUME_FORK_MALLOC_MB	50
+#define CONSUME_GRANDCHILD_MB	300
+#define CONSUME_ZOMBIE_MB	400
+#define CONSUME_SIG_IGN_MB	500
+
+#define N_TO_STR(s) _N_TO_STR(s)
+#define _N_TO_STR(s) #s
+
+static int is_in_delta(long value)
+{
+	return (value >= -DELTA_MAX_KB && value <= DELTA_MAX_KB);
+}
+
+#endif
diff --git a/testcases/kernel/syscalls/getrusage/getrusage03_child.c b/testcases/kernel/syscalls/getrusage/getrusage03_child.c
index 24a6f33..6eeae75 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03_child.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03_child.c
@@ -34,12 +34,11 @@
 
 #include "test.h"
 #include "safe_macros.h"
+#include "getrusage03.h"
 
 char *TCID = "getrusage03_child";
 int TST_TOTAL = 1;
 
-#define DELTA_MAX	10240
-
 static int opt_consume, opt_grand, opt_show, opt_self, opt_child;
 static char *consume_str, *grand_consume_str, *self_str, *child_str;
 
@@ -111,7 +110,7 @@ int main(int argc, char *argv[])
 				self_nr = SAFE_STRTOL(cleanup,
 						      self_str, 0, LONG_MAX);
 				delta = maxrss_self - self_nr;
-				if (delta >= -DELTA_MAX && delta <= DELTA_MAX)
+				if (is_in_delta(delta))
 					tst_resm(TPASS,
 						 "initial.self ~= exec.self");
 				else
@@ -122,7 +121,7 @@ int main(int argc, char *argv[])
 				child_nr = SAFE_STRTOL(cleanup,
 						       child_str, 0, LONG_MAX);
 				delta = maxrss_children - child_nr;
-				if (delta >= -DELTA_MAX && delta <= DELTA_MAX)
+				if (is_in_delta(delta))
 					tst_resm(TPASS,
 						 "initial.children ~= exec.children");
 				else
-- 
2.7.4


