From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 18 Jan 2017 14:03:28 +0800
Subject: [LTP] [PATCH v2 3/3] syscalls/getcwd04.c: cleanup && convert to new
	API
In-Reply-To: <1484719408-28782-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20170117134335.GA28074@rei.lan>
 <1484719408-28782-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1484719408-28782-3-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/getcwd/getcwd04.c | 81 +++++++++++------------------
 1 file changed, 30 insertions(+), 51 deletions(-)

diff --git a/testcases/kernel/syscalls/getcwd/getcwd04.c b/testcases/kernel/syscalls/getcwd/getcwd04.c
index 1a5461c..7e2ca23 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd04.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd04.c
@@ -1,16 +1,16 @@
 /*
- *   Copyright (c) 2014 Fujitsu Ltd.
- *   Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  */
 
 /*
@@ -30,7 +30,6 @@
  *
  * This test is to check whether this bug exists in the running kernel,
  * or whether this bug has been fixed.
- *
  */
 
 #include <stdio.h>
@@ -38,77 +37,54 @@
 #include <fcntl.h>
 #include <sys/types.h>
 #include <unistd.h>
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
 #define TIMEOUT	5
 
-static void setup(void);
-static void cleanup(void);
 static void do_child(void);
 static void sigproc(int sig);
 static volatile sig_atomic_t end;
 static char init_cwd[PATH_MAX];
 
-char *TCID = "getcwd04";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static void verify_getcwd(void)
 {
 	int status;
 	char cur_cwd[PATH_MAX];
 	pid_t child;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	child = tst_fork();
-	if (child < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
-
+	child = SAFE_FORK();
 	if (child == 0)
 		do_child();
 
 	 while (1) {
-		SAFE_GETCWD(cleanup, cur_cwd, PATH_MAX);
+		SAFE_GETCWD(cur_cwd, PATH_MAX);
 		if (strncmp(init_cwd, cur_cwd, PATH_MAX)) {
-			tst_resm(TFAIL, "initial current work directory is "
+			tst_res(TFAIL, "initial current work directory is "
 				 "%s, now is %s. Bug is reproduced!",
 				 init_cwd, cur_cwd);
 			break;
 		}
 
 		if (end) {
-			tst_resm(TPASS, "Bug is not reproduced!");
+			tst_res(TPASS, "Bug is not reproduced!");
 			break;
 		}
 	}
 
-	SAFE_KILL(cleanup, child, SIGKILL);
-	SAFE_WAITPID(cleanup, child, &status, 0);
-
-	cleanup();
-	tst_exit();
+	SAFE_KILL(child, SIGKILL);
+	SAFE_WAITPID(child, &status, 0);
 }
 
 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
 	if (tst_ncpus() == 1)
-		tst_brkm(TCONF, NULL, "This test needs two cpus at least");
-
-	tst_tmpdir();
+		tst_brk(TCONF, "This test needs two cpus@least");
 
-	if (signal(SIGALRM, sigproc) == SIG_ERR)
-		tst_brkm(TBROK | TERRNO, cleanup, "signal(SIGALRM) failed");
+	SAFE_SIGNAL(SIGALRM, sigproc);
 
 	alarm(TIMEOUT);
 
-	SAFE_GETCWD(cleanup, init_cwd, PATH_MAX);
+	SAFE_GETCWD(init_cwd, PATH_MAX);
 }
 
 static void sigproc(int sig)
@@ -121,16 +97,19 @@ static void do_child(void)
 	unsigned int i = 0;
 	char c_name[PATH_MAX] = "testfile", n_name[PATH_MAX];
 
-	SAFE_TOUCH(NULL, c_name, 0644, NULL);
+	SAFE_TOUCH(c_name, 0644, NULL);
 
 	while (1) {
 		snprintf(n_name, PATH_MAX, "testfile%u", i++);
-		SAFE_RENAME(NULL, c_name, n_name);
+		SAFE_RENAME(c_name, n_name);
 		strncpy(c_name, n_name, PATH_MAX);
 	}
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.tid = "getcwd04",
+	.setup = setup,
+	.test_all = verify_getcwd,
+	.needs_tmpdir = 1,
+	.forks_child = 1
+};
-- 
1.8.3.1



