From: Li Wang <liwang@redhat.com>
Date: Mon, 10 Apr 2017 18:05:54 +0800
Subject: [LTP] [PATCH V2 12/14] mem/cpuset: convert to new API
In-Reply-To: <20170410100556.4465-1-liwang@redhat.com>
References: <20170410100556.4465-1-liwang@redhat.com>
Message-ID: <20170410100556.4465-13-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/cpuset/cpuset01.c | 155 ++++++++++++---------------------
 1 file changed, 58 insertions(+), 97 deletions(-)

diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index 558420f..80c2112 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -1,4 +1,16 @@
 /*
+ * Copyright (C) 2010-2017  Red Hat, Inc.
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
  * Out Of Memory when changing cpuset's mems on NUMA. There was a
  * problem reported upstream that the allocator may see an empty
  * nodemask when changing cpuset's mems.
@@ -6,55 +18,18 @@
  * http://lkml.org/lkml/2010/5/4/79
  * http://lkml.org/lkml/2010/5/4/80
  * This test is based on the reproducers for the above issue.
- *
- * Copyright (C) 2010  Red Hat, Inc.
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
  */
+
 #include "config.h"
-#include <sys/types.h>
-#include <sys/mman.h>
-#include <sys/mount.h>
-#include <sys/stat.h>
+#include <stdio.h>
 #include <sys/wait.h>
-#include <ctype.h>
-#include <err.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <math.h>
 #if HAVE_NUMAIF_H
 #include <numaif.h>
 #endif
-#include <signal.h>
-#include <stdarg.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
 
-#include "test.h"
 #include "mem.h"
 #include "numa_helper.h"
 
-char *TCID = "cpuset01";
-int TST_TOTAL = 1;
-
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 volatile int end;
@@ -62,32 +37,13 @@ static int *nodes;
 static int nnodes;
 static long ncpus;
 
-static void testcpuset(void);
 static void sighandler(int signo LTP_ATTRIBUTE_UNUSED);
 static int mem_hog(void);
 static int mem_hog_cpuset(int ntasks);
 static long count_cpu(void);
 
-int main(int argc, char *argv[])
-{
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	ncpus = count_cpu();
-	if (get_allowed_nodes_arr(NH_MEMS | NH_CPUS, &nnodes, &nodes) < 0)
-		tst_brkm(TBROK | TERRNO, NULL, "get_allowed_nodes_arr");
-	if (nnodes <= 1)
-		tst_brkm(TCONF, NULL, "requires a NUMA system.");
-
-	setup();
-	testcpuset();
-	cleanup();
-	tst_exit();
-}
-
-static void testcpuset(void)
+static void test_cpuset(void)
 {
-	int lc;
 	int child, i, status;
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
 	char mems[BUFSIZ], buf[BUFSIZ];
@@ -96,11 +52,11 @@ static void testcpuset(void)
 	write_cpuset_files(CPATH_NEW, "cpus", buf);
 	read_cpuset_files(CPATH, "mems", mems);
 	write_cpuset_files(CPATH_NEW, "mems", mems);
-	SAFE_FILE_PRINTF(cleanup, CPATH_NEW "/tasks", "%d", getpid());
+	SAFE_FILE_PRINTF(CPATH_NEW "/tasks", "%d", getpid());
 
 	switch (child = fork()) {
 	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
+		tst_brk(TBROK | TERRNO, "fork");
 	case 0:
 		for (i = 0; i < nnodes; i++) {
 			if (nodes[i] >= MAXNODES)
@@ -108,37 +64,36 @@ static void testcpuset(void)
 			set_node(nmask, nodes[i]);
 		}
 		if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "set_mempolicy");
+			tst_brk(TBROK | TERRNO, "set_mempolicy");
 		exit(mem_hog_cpuset(ncpus > 1 ? ncpus : 1));
 	}
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		snprintf(buf, BUFSIZ, "%d", nodes[0]);
-		write_cpuset_files(CPATH_NEW, "mems", buf);
-		snprintf(buf, BUFSIZ, "%d", nodes[1]);
-		write_cpuset_files(CPATH_NEW, "mems", buf);
-	}
+
+	snprintf(buf, BUFSIZ, "%d", nodes[0]);
+	write_cpuset_files(CPATH_NEW, "mems", buf);
+	snprintf(buf, BUFSIZ, "%d", nodes[1]);
+	write_cpuset_files(CPATH_NEW, "mems", buf);
 
 	if (waitpid(child, &status, WUNTRACED | WCONTINUED) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
-	if (WEXITSTATUS(status) != 0)
-		tst_resm(TFAIL, "child exit status is %d", WEXITSTATUS(status));
+		tst_brk(TBROK | TERRNO, "waitpid");
+	if (WEXITSTATUS(status) != 0) {
+		tst_res(TFAIL, "child exit status is %d", WEXITSTATUS(status));
+		return;
+	}
+
+	tst_res(TPASS, "cpuset test pass");
 }
 
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
-
-	if (tst_kvercmp(2, 6, 32) < 0)
-		tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required");
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-
 	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
+	ncpus = count_cpu();
+	if (get_allowed_nodes_arr(NH_MEMS | NH_CPUS, &nnodes, &nodes) < 0)
+		tst_brk(TBROK | TERRNO, "get_allowed_nodes_arr");
+	if (nnodes <= 1)
+		tst_brk(TCONF, "requires a NUMA system.");
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	umount_mem(CPATH, CPATH_NEW);
 }
@@ -160,7 +115,7 @@ static int mem_hog(void)
 			    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 		if (addr == MAP_FAILED) {
 			ret = 1;
-			tst_resm(TFAIL | TERRNO, "mmap");
+			tst_res(TFAIL | TERRNO, "mmap");
 			break;
 		}
 		memset(addr, 0xF7, pagesize * 10);
@@ -171,26 +126,26 @@ static int mem_hog(void)
 
 static int mem_hog_cpuset(int ntasks)
 {
-	int i, lc, status, ret = 0;
+	int i, status, ret = 0;
 	struct sigaction sa;
 	pid_t *pids;
 
 	if (ntasks <= 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "ntasks is small.");
+		tst_brk(TBROK | TERRNO, "ntasks is small.");
 	sa.sa_handler = sighandler;
 	if (sigemptyset(&sa.sa_mask) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "sigemptyset");
+		tst_brk(TBROK | TERRNO, "sigemptyset");
 	sa.sa_flags = 0;
 	if (sigaction(SIGUSR1, &sa, NULL) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "sigaction");
+		tst_brk(TBROK | TERRNO, "sigaction");
 
 	pids = malloc(sizeof(pid_t) * ntasks);
 	if (pids == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "malloc");
+		tst_brk(TBROK | TERRNO, "malloc");
 	for (i = 0; i < ntasks; i++) {
 		switch (pids[i] = fork()) {
 		case -1:
-			tst_resm(TFAIL | TERRNO, "fork %d", pids[i]);
+			tst_res(TFAIL | TERRNO, "fork %d", pids[i]);
 			ret = 1;
 			break;
 		case 0:
@@ -200,22 +155,22 @@ static int mem_hog_cpuset(int ntasks)
 			break;
 		}
 	}
-	for (lc = 0; TEST_LOOPING(lc); lc++) ;
+
 	while (i--) {
 		if (kill(pids[i], SIGUSR1) == -1) {
-			tst_resm(TFAIL | TERRNO, "kill %d", pids[i]);
+			tst_res(TFAIL | TERRNO, "kill %d", pids[i]);
 			ret = 1;
 		}
 	}
 	while (waitpid(-1, &status, WUNTRACED | WCONTINUED) > 0) {
 		if (WIFEXITED(status)) {
 			if (WEXITSTATUS(status) != 0) {
-				tst_resm(TFAIL, "child exit status is %d",
+				tst_res(TFAIL, "child exit status is %d",
 					 WEXITSTATUS(status));
 				ret = 1;
 			}
 		} else if (WIFSIGNALED(status)) {
-			tst_resm(TFAIL, "child caught signal %d",
+			tst_res(TFAIL, "child caught signal %d",
 				 WTERMSIG(status));
 			ret = 1;
 		}
@@ -233,9 +188,15 @@ static long count_cpu(void)
 	return ncpus;
 }
 
+static struct tst_test test = {
+	.tid = "cpuset01",
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_cpuset,
+	.min_kver = "2.6.32",
+};
+
 #else /* no NUMA */
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
-}
+	TST_TEST_TCONF("no NUMA development packages installed.");
 #endif
-- 
2.9.3

