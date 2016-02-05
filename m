From: Li Wang <liwang@redhat.com>
Date: Fri,  5 Feb 2016 15:00:18 +0800
Subject: [LTP] [PATCH] mm: Remove thp05
Message-ID: <1454655618-31293-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This has been discussed in:

http://lists.linux.it/pipermail/ltp/2016-February/000949.html

Signed-off-by: Li Wang <liwang@redhat.com>
---
 runtest/mm                         |   3 -
 testcases/kernel/mem/include/mem.h |   7 --
 testcases/kernel/mem/lib/mem.c     | 191 -------------------------------------
 testcases/kernel/mem/thp/thp05.c   | 149 -----------------------------
 4 files changed, 350 deletions(-)
 delete mode 100644 testcases/kernel/mem/thp/thp05.c

diff --git a/runtest/mm b/runtest/mm
index c0176fe..d108d18 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -84,9 +84,6 @@ swapping01 swapping01 -i 5
 thp01 thp01 -I 120
 thp02 thp02
 thp03 thp03
-thp05_1 thp05
-thp05_2 thp05 -n 10 -N 20
-thp05_3 thp05 -n 1 -N 300
 
 vma01 vma01
 vma02 vma02
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 041c437..43988fe 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -51,13 +51,6 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages);
 #define PATH_THP		"/sys/kernel/mm/transparent_hugepage/"
 #define PATH_KHPD		PATH_THP "khugepaged/"
 
-int opt_nr_children, opt_nr_thps;
-char *opt_nr_children_str, *opt_nr_thps_str;
-void test_transparent_hugepage(int nr_children, int nr_thps,
-			       int hg_aligned, int mempolicy);
-void check_thp_options(int *nr_children, int *nr_thps);
-void thp_usage(void);
-
 /* HUGETLB */
 
 #define PATH_SHMMAX		"/proc/sys/kernel/shmmax"
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 56104cb..cedcf32 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -650,197 +650,6 @@ void ksm_usage(void)
 
 /* THP */
 
-static int alloc_transparent_hugepages(int nr_thps, int hg_aligned)
-{
-	unsigned long hugepagesize, size;
-	void *addr;
-	int ret;
-
-	hugepagesize = read_meminfo("Hugepagesize:") * KB;
-	size = nr_thps * hugepagesize;
-
-	if (hg_aligned) {
-		ret = posix_memalign(&addr, hugepagesize, size);
-		if (ret != 0) {
-			printf("posix_memalign failed\n");
-			return -1;
-		}
-	} else {
-		addr = mmap(NULL, size, PROT_READ|PROT_WRITE,
-			    MAP_PRIVATE|MAP_ANON, -1, 0);
-		if (addr == MAP_FAILED) {
-			perror("mmap");
-			return -1;
-		}
-	}
-
-	memset(addr, 10, size);
-
-	tst_resm(TINFO, "child[%d] stop here", getpid());
-	/*
-	 * stop here, until the father finish to calculate
-	 * all the transparent hugepages.
-	 */
-	if (raise(SIGSTOP) == -1) {
-		perror("kill");
-		return -1;
-	}
-
-	return 0;
-}
-
-static void khugepaged_scan_done(void)
-{
-	int changing = 1, count = 0, interval;
-	long old_pages_collapsed = 0, old_max_ptes_none = 0,
-		old_pages_to_scan = 0;
-	long pages_collapsed = 0, max_ptes_none = 0, pages_to_scan = 0;
-
-	/*
-	 * as 'khugepaged' run 100% during testing, so 5s is an
-	 * enough interval for us to recognize if 'khugepaged'
-	 * finish scanning proceses' anonymous hugepages or not.
-	 */
-	interval = 5;
-
-	while (changing) {
-		sleep(interval);
-		count++;
-
-		SAFE_FILE_SCANF(cleanup, PATH_KHPD "pages_collapsed",
-			       "%ld", &pages_collapsed);
-		SAFE_FILE_SCANF(cleanup, PATH_KHPD "max_ptes_none",
-			       "%ld", &max_ptes_none);
-		SAFE_FILE_SCANF(cleanup, PATH_KHPD "pages_to_scan",
-			       "%ld", &pages_to_scan);
-
-		if (pages_collapsed != old_pages_collapsed ||
-		    max_ptes_none != old_max_ptes_none ||
-		    pages_to_scan != old_pages_to_scan) {
-			old_pages_collapsed = pages_collapsed;
-			old_max_ptes_none = max_ptes_none;
-			old_pages_to_scan = pages_to_scan;
-		} else {
-			changing = 0;
-		}
-	}
-
-	tst_resm(TINFO, "khugepaged daemon takes %ds to scan all thp pages",
-		 count * interval);
-}
-
-static void verify_thp_size(int *children, int nr_children, int nr_thps)
-{
-	FILE *fp;
-	char path[BUFSIZ], buf[BUFSIZ], line[BUFSIZ];
-	int i, ret;
-	long expect_thps; /* the amount of per child's transparent hugepages */
-	long val, actual_thps;
-	long hugepagesize;
-
-	hugepagesize = read_meminfo("Hugepagesize:");
-	expect_thps = nr_thps * hugepagesize;
-
-	for (i = 0; i < nr_children; i++) {
-		actual_thps = 0;
-
-		snprintf(path, BUFSIZ, "/proc/%d/smaps", children[i]);
-		fp = fopen(path, "r");
-		while (fgets(line, BUFSIZ, fp) != NULL) {
-			ret = sscanf(line, "%64s %ld", buf, &val);
-			if (ret == 2 && val != 0) {
-				if (strcmp(buf, "AnonHugePages:") == 0)
-					actual_thps += val;
-			}
-		}
-
-		if (actual_thps != expect_thps)
-			tst_resm(TFAIL, "child[%d] got %ldKB thps - expect %ld"
-				"KB thps", getpid(), actual_thps, expect_thps);
-		fclose(fp);
-	}
-}
-
-void test_transparent_hugepage(int nr_children, int nr_thps,
-			       int hg_aligned, int mempolicy)
-{
-	unsigned long hugepagesize, memfree;
-	int i, *pids, ret, status;
-
-	if (mempolicy)
-		set_global_mempolicy(mempolicy);
-
-	memfree = read_meminfo("MemFree:");
-	tst_resm(TINFO, "The current MemFree is %luMB", memfree / KB);
-	if (memfree < MB)
-		tst_resm(TCONF, "Not enough memory for testing");
-
-	hugepagesize = read_meminfo("Hugepagesize:");
-	tst_resm(TINFO, "The current Hugepagesize is %luMB", hugepagesize / KB);
-
-	pids = malloc(nr_children * sizeof(int));
-	if (pids == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "malloc");
-
-	for (i = 0; i < nr_children; i++) {
-		switch (pids[i] = fork()) {
-		case -1:
-			tst_brkm(TBROK | TERRNO, cleanup, "fork");
-
-		case 0:
-			ret = alloc_transparent_hugepages(nr_thps, hg_aligned);
-			exit(ret);
-		}
-	}
-
-	tst_resm(TINFO, "Stop all children...");
-	for (i = 0; i < nr_children; i++) {
-		if (waitpid(pids[i], &status, WUNTRACED) == -1)
-			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
-		if (!WIFSTOPPED(status))
-			tst_brkm(TBROK, cleanup,
-				 "child[%d] was not stoppted", pids[i]);
-	}
-
-	tst_resm(TINFO, "Start to scan all transparent hugepages...");
-	khugepaged_scan_done();
-
-	tst_resm(TINFO, "Start to verify transparent hugepage size...");
-	verify_thp_size(pids, nr_children, nr_thps);
-
-	tst_resm(TINFO, "Wake up all children...");
-	for (i = 0; i < nr_children; i++) {
-		if (kill(pids[i], SIGCONT) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "signal continue child[%d]", pids[i]);
-	}
-
-	/* wait all children finish their task */
-	for (i = 0; i < nr_children; i++) {
-		if (waitpid(pids[i], &status, 0) == -1)
-			tst_brkm(TBROK|TERRNO, cleanup, "waitpid %d", pids[i]);
-
-		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-			tst_resm(TFAIL, "the child[%d] unexpectedly failed:"
-				 " %d", pids[i], status);
-	}
-}
-
-void check_thp_options(int *nr_children, int *nr_thps)
-{
-	if (opt_nr_children)
-		*nr_children = SAFE_STRTOL(NULL, opt_nr_children_str,
-					   0, LONG_MAX);
-	if (opt_nr_thps)
-		*nr_thps = SAFE_STRTOL(NULL, opt_nr_thps_str, 0, LONG_MAX);
-}
-
-void thp_usage(void)
-{
-	printf("  -n      Number of processes\n");
-	printf("  -N      Number of transparent hugepages\n");
-}
-
 /* cpuset/memcg */
 
 static void gather_node_cpus(char *cpus, long nd)
diff --git a/testcases/kernel/mem/thp/thp05.c b/testcases/kernel/mem/thp/thp05.c
deleted file mode 100644
index 688c895..0000000
--- a/testcases/kernel/mem/thp/thp05.c
+++ /dev/null
@@ -1,149 +0,0 @@
-/*
- * Copyright (C) 2013 Linux Test Project
- *
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
- */
-
-/*
- * The case is designed to test the functionality of transparent
- * hugepage - THP under mempolicy (NUMA)
- *
- * when one process allocate hugepage aligned anonymous pages,
- * kernel thread 'khugepaged' controlled by sysfs knobs
- * /sys/kernel/mm/transparent_hugepage/ will scan them, and make
- * them as transparent hugepage if they are suited, you can find out
- * how many transparent hugepages are there in one process from
- * /proc/<pid>/smaps, among the file contents, 'AnonHugePages' entry
- * stand for transparent hugepage.
- */
-
-#include <sys/types.h>
-#include <sys/mman.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include "numa_helper.h"
-#include "test.h"
-#include "mem.h"
-
-char *TCID = "thp05";
-int TST_TOTAL = 1;
-
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-		&& HAVE_MPOL_CONSTANTS
-
-option_t thp_options[] = {
-	{"n:", &opt_nr_children, &opt_nr_children_str},
-	{"N:", &opt_nr_thps, &opt_nr_thps_str},
-	{NULL, NULL, NULL}
-};
-
-static int pre_thp_scan_sleep_millisecs;
-static int pre_thp_alloc_sleep_millisecs;
-static char pre_thp_enabled[BUFSIZ];
-
-int main(int argc, char *argv[])
-{
-	int lc;
-	char *msg;
-	int nr_children = 2, nr_thps = 64;
-
-	tst_parse_opts(argc, argv, thp_options, thp_usage);
-
-	check_thp_options(&nr_children, &nr_thps);
-
-	setup();
-
-	tst_resm(TINFO, "Start to test transparent hugepage...");
-	tst_resm(TINFO, "There are %d children allocating %d "
-			"transparent hugepages", nr_children, nr_thps);
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		tst_resm(TINFO, "THP on MPOL_BIND mempolicy...");
-		test_transparent_hugepage(nr_children, nr_thps, 1, MPOL_BIND);
-
-		tst_resm(TINFO, "THP on MPOL_INTERLEAVE mempolicy...");
-		test_transparent_hugepage(nr_children, nr_thps, 1,
-					  MPOL_INTERLEAVE);
-
-		tst_resm(TINFO, "THP on MPOL_PREFERRED mempolicy...");
-		test_transparent_hugepage(nr_children, nr_thps, 1,
-					  MPOL_PREFERRED);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-void setup(void)
-{
-	tst_require_root();
-
-	if (access(PATH_THP, F_OK) == -1)
-		tst_brkm(TCONF, NULL, "THP not enabled in kernel?");
-
-	if (!is_numa(NULL))
-		tst_brkm(TCONF, NULL, "The case need a NUMA system.");
-
-	SAFE_FILE_SCANF(NULL, PATH_KHPD "scan_sleep_millisecs",
-			"%d", &pre_thp_scan_sleep_millisecs);
-	SAFE_FILE_PRINTF(NULL, PATH_KHPD "scan_sleep_millisecs", "0");
-
-	SAFE_FILE_SCANF(NULL, PATH_KHPD "alloc_sleep_millisecs",
-			"%d", &pre_thp_alloc_sleep_millisecs);
-	SAFE_FILE_PRINTF(NULL, PATH_KHPD "alloc_sleep_millisecs", "0");
-
-	SAFE_FILE_SCANF(NULL, PATH_THP "enabled", "%[^\n]", pre_thp_enabled);
-	SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "always");
-
-	tst_sig(FORK, DEF_HANDLER, NULL);
-	TEST_PAUSE;
-}
-
-void cleanup(void)
-{
-	FILE_PRINTF(PATH_KHPD "scan_sleep_millisecs",
-			 "%d", pre_thp_scan_sleep_millisecs);
-
-	FILE_PRINTF(PATH_KHPD "alloc_sleep_millisecs",
-			 "%d", pre_thp_alloc_sleep_millisecs);
-
-	if (strcmp(pre_thp_enabled, "[always] madvise never") == 0)
-		FILE_PRINTF(PATH_THP "enabled", "always");
-	else if (strcmp(pre_thp_enabled, "always [madvise] never") == 0)
-		FILE_PRINTF(PATH_THP "enabled", "madvise");
-	else
-		FILE_PRINTF(PATH_THP "enabled", "never");
-}
-
-#else /* no NUMA */
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
-}
-#endif
-- 
1.8.3.1

