From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Jul 2017 16:23:11 +0800
Subject: [LTP] [PATCH v3 14/15] mem/swapping: convert to new API
In-Reply-To: <20170718082312.3946-1-liwang@redhat.com>
References: <20170718082312.3946-1-liwang@redhat.com>
Message-ID: <20170718082312.3946-15-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/swapping/swapping01.c | 105 ++++++++++-------------------
 1 file changed, 37 insertions(+), 68 deletions(-)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index 171edb3..8c8d628 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -1,24 +1,15 @@
 /*
- * Copyright (C) 2012  Red Hat, Inc.
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
+ * Copyright (C) 2012-2017  Red Hat, Inc.
  *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
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
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  */
 /*
  * swapping01 - first time swap use results in heavy swapping
@@ -53,12 +44,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include "test.h"
 #include "mem.h"
 
-char *TCID = "swapping01";
-int TST_TOTAL = 1;
-
 /* allow swapping 1 * phy_mem in maximum */
 #define COE_DELTA       1
 /* will try to alloc 1.3 * phy_mem */
@@ -74,54 +61,42 @@ static long mem_over;
 static long mem_over_max;
 static pid_t pid;
 
-int main(int argc, char *argv[])
+static void test_swapping(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
 #if __WORDSIZE == 32
-	tst_brkm(TCONF, NULL, "test is not designed for 32-bit system.");
+	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		init_meminfo();
+	init_meminfo();
 
-		switch (pid = fork()) {
+	switch (pid = fork()) {
 		case -1:
-			tst_brkm(TBROK | TERRNO, cleanup, "fork");
+			tst_brk(TBROK | TERRNO, "fork");
 		case 0:
 			do_alloc();
 			exit(0);
 		default:
 			check_swapping();
-		}
 	}
-	cleanup();
-	tst_exit();
 }
 
 static void init_meminfo(void)
 {
-	swap_free_init = read_meminfo("SwapFree:");
-	if (FILE_LINES_SCANF(cleanup, "/proc/meminfo", "MemAvailable: %ld",
+	swap_free_init = SAFE_READ_MEMINFO("SwapFree:");
+	if (FILE_LINES_SCANF("/proc/meminfo", "MemAvailable: %ld",
 		&mem_available_init)) {
-		mem_available_init = read_meminfo("MemFree:")
-			+ read_meminfo("Cached:");
+		mem_available_init = SAFE_READ_MEMINFO("MemFree:")
+			+ SAFE_READ_MEMINFO("Cached:");
 	}
 	mem_over = mem_available_init * COE_SLIGHT_OVER;
 	mem_over_max = mem_available_init * COE_DELTA;
 
 	/* at least 10MB available physical memory needed */
 	if (mem_available_init < 10240)
-		tst_brkm(TCONF, cleanup, "Not enough available mem to test.");
+		tst_brk(TCONF, "Not enough available mem to test.");
 
 	if (swap_free_init < mem_over_max)
-		tst_brkm(TCONF, cleanup, "Not enough swap space to test.");
+		tst_brk(TCONF, "Not enough swap space to test.");
 }
 
 static void do_alloc(void)
@@ -129,17 +104,17 @@ static void do_alloc(void)
 	long mem_count;
 	void *s;
 
-	tst_resm(TINFO, "available physical memory: %ld MB",
+	tst_res(TINFO, "available physical memory: %ld MB",
 		mem_available_init / 1024);
 	mem_count = mem_available_init + mem_over;
-	tst_resm(TINFO, "try to allocate: %ld MB", mem_count / 1024);
+	tst_res(TINFO, "try to allocate: %ld MB", mem_count / 1024);
 	s = malloc(mem_count * 1024);
 	if (s == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "malloc");
+		tst_brk(TBROK | TERRNO, "malloc");
 	memset(s, 1, mem_count * 1024);
-	tst_resm(TINFO, "memory allocated: %ld MB", mem_count / 1024);
+	tst_res(TINFO, "memory allocated: %ld MB", mem_count / 1024);
 	if (raise(SIGSTOP) == -1)
-		tst_brkm(TBROK | TERRNO, tst_exit, "kill");
+		tst_brk(TBROK | TERRNO, "kill");
 	free(s);
 }
 
@@ -150,44 +125,38 @@ static void check_swapping(void)
 
 	/* wait child stop */
 	if (waitpid(pid, &status, WUNTRACED) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+		tst_brk(TBROK | TERRNO, "waitpid");
 	if (!WIFSTOPPED(status))
-		tst_brkm(TBROK, cleanup, "child was not stopped.");
+		tst_brk(TBROK, "child was not stopped.");
 
 	/* Still occupying memory, loop for a while */
 	i = 0;
 	while (i < 10) {
-		swap_free_now = read_meminfo("SwapFree:");
+		swap_free_now = SAFE_READ_MEMINFO("SwapFree:");
 		sleep(1);
-		if (abs(swap_free_now - read_meminfo("SwapFree:")) < 512)
+		if (abs(swap_free_now - SAFE_READ_MEMINFO("SwapFree:")) < 512)
 			break;
 
 		i++;
 	}
 
-	swap_free_now = read_meminfo("SwapFree:");
+	swap_free_now = SAFE_READ_MEMINFO("SwapFree:");
 	swapped = swap_free_init - swap_free_now;
 	if (swapped > mem_over_max) {
 		kill(pid, SIGCONT);
-		tst_brkm(TFAIL, cleanup, "heavy swapping detected: "
+		tst_brk(TFAIL, "heavy swapping detected: "
 				"%ld MB swapped.", swapped / 1024);
 	}
 
-	tst_resm(TPASS, "no heavy swapping detected, %ld MB swapped.",
+	tst_res(TPASS, "no heavy swapping detected, %ld MB swapped.",
 		 swapped / 1024);
 	kill(pid, SIGCONT);
 	/* wait child exit */
 	if (waitpid(pid, &status, 0) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+		tst_brk(TBROK | TERRNO, "waitpid");
 }
 
-void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.needs_root = 1,
+	.test_all = test_swapping,
+};
-- 
2.9.3

