From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  4 Jan 2019 13:13:39 +0100
Subject: [LTP] [PATCH 1/1] cgroup: Rewrite some C parts into new API
Message-ID: <20190104121339.32147-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../cgroup/cgroup_regression_6_2.c            | 29 +++++++++++++------
 .../cgroup/cgroup_regression_fork_processes.c | 28 +++++++++---------
 2 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_6_2.c b/testcases/kernel/controllers/cgroup/cgroup_regression_6_2.c
index b79b93730..226a12d61 100644
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_6_2.c
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_6_2.c
@@ -1,30 +1,31 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
  * Copyright (c) 2009 FUJITSU LIMITED
  * Author: Li Zefan <lizf@cn.fujitsu.com>
  */
 
 #define _GNU_SOURCE
 
+#define STR_HELPER(x) #x
+#define STR(x) STR_HELPER(x)
+
 #include <sched.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include "test.h"
+#include "tst_test.h"
 
 #define DEFAULT_USEC	30000
 
+static char *str_usec;
+
 int foo(void __attribute__ ((unused)) * arg)
 {
 	return 0;
 }
 
-int main(int argc, char **argv)
+static void do_test(void)
 {
 	int usec;
-
-	if (argc == 2)
-		usec = atoi(argv[1]);
-	else
+	if (tst_parse_int(str_usec, &usec, 1, INT_MAX))
 		usec = DEFAULT_USEC;
 
 	while (1) {
@@ -32,5 +33,15 @@ int main(int argc, char **argv)
 		ltp_clone_quick(CLONE_NEWNS, foo, NULL);
 	}
 
-	tst_exit();
+	tst_res(TINFO, "exit");
 }
+
+static struct tst_option options[] = {
+	{"u", &str_usec, "-u       usec (default " STR(DEFAULT_USEC) ")"},
+	{NULL, NULL, NULL}
+};
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.options = options,
+};
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_fork_processes.c b/testcases/kernel/controllers/cgroup/cgroup_regression_fork_processes.c
index 6f2498bb8..b31e79bcc 100644
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_fork_processes.c
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_fork_processes.c
@@ -1,34 +1,36 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
  * Copyright (c) 2009 FUJITSU LIMITED
- *
  * Author: Li Zefan <lizf@cn.fujitsu.com>
  */
 
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <stdlib.h>
-#include <unistd.h>
+#include "tst_test.h"
 
-int main(void)
+#define NUM_LOOPS 200
+
+static void do_test(void)
 {
 	int i;
-	pid_t pid;
 
 	while (1) {
-		for (i = 0; i < 200; i++) {
-			pid = fork();
-			if (pid == 0) {
+		for (i = 0; i < NUM_LOOPS; i++) {
+			if (!SAFE_FORK()) {
 				exit(0);
-			} else if (pid == -1) {
-				continue;
 			}
 		}
 
-		for (i = 0; i < 200; i++)
-			if (wait(NULL) < 0)
-				break;
+		for (i = 0; i < NUM_LOOPS; i++)
+			SAFE_WAIT(NULL);
 	}
 
-	return 0;
+	tst_res(TINFO, "exit");
 }
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.forks_child = 1,
+};
-- 
2.19.2

