From: Martin Doucha <mdoucha@suse.cz>
Date: Thu,  6 Aug 2020 18:23:56 +0200
Subject: [LTP] [PATCH] Drop the mem01 test
Message-ID: <20200806162356.16920-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The mem01 test often fails on PPC systems mainly because it doesn't take into
account page sizes larger than 4KB. Test scenario review revealed that it's
not particularly useful because it doesn't have any more specific goal than
filling large amount of memory and the hardcoded allocation limits are too
low for modern and future systems. The useful part of this test mostly
overlaps with coverage by existing OOM tests.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 runtest/crashme                  |   3 -
 runtest/mm                       |   1 -
 testcases/kernel/mem/.gitignore  |   1 -
 testcases/kernel/mem/mem/mem01.c | 249 -------------------------------
 4 files changed, 254 deletions(-)
 delete mode 100644 testcases/kernel/mem/mem/mem01.c

diff --git a/runtest/crashme b/runtest/crashme
index 14750749d..47f5f93b4 100644
--- a/runtest/crashme
+++ b/runtest/crashme
@@ -10,9 +10,6 @@ crash01 crash01
 crash02 crash02 -v 2
 # Generate random syscalls and execute them, less probability
 # to hose your system, but still.
-mem01 mem01 -r
-# Memory eater. Loves to be run in parallel with other programs.
-# May panic on buggy systems if the OOM killer was not fast enough :-)
 fork12 fork12
 # Fork as many children as possible.  On systems with lots of memory
 # and kernels prior to 2.4.19, this can hang the system by using up all pids
diff --git a/runtest/mm b/runtest/mm
index 4701a14bd..481d39691 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -20,7 +20,6 @@ mtest06_3 mmap3 -x 0.002 -p
 # Remains diabled till the infinite loop problem is solved
 #mtest-6_4 shmat1 -x 0.00005
 
-mem01 mem01
 mem02 mem02
 mem03 mem03
 
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index b95ada109..ff2910533 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -23,7 +23,6 @@
 /ksm/ksm04
 /ksm/ksm05
 /ksm/ksm06
-/mem/mem01
 /mem/mem02
 /mmapstress/mmap-corruption01
 /mmapstress/mmapstress01
diff --git a/testcases/kernel/mem/mem/mem01.c b/testcases/kernel/mem/mem/mem01.c
deleted file mode 100644
index b8fa5b7a0..000000000
--- a/testcases/kernel/mem/mem/mem01.c
+++ /dev/null
@@ -1,249 +0,0 @@
-/*
- * mem01.c - Basic memory and swapper stress test
- *
- * Copyright (C) 2001 Stephane Fillod <f4cfe@free.fr>
- * Original idea from Rene Cougnenc
- *
- * Copyright (C) 2012 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-
-#include <unistd.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/types.h>
-#include <sys/sysinfo.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/user.h>
-#include <time.h>
-#include <limits.h>
-
-#include "lapi/abisize.h"
-#include "test.h"
-
-/* in KB */
-#define PROGRESS_LEAP 100
-
-/*
- * TODO:
- *  - add option for growing direction, when doing linear touching
- *  - add option for touch running time (or infinite loop?)
- *  - make it multithreaded with random access to test r/w mm_sem
- */
-
-char *TCID = "mem01";
-int TST_TOTAL = 1;
-
-static int m_opt = 0;		/* memsize */
-static char *m_copt;
-
-static int r_opt = 0;		/* random access versus linear */
-static int v_opt = 0;		/* verbose progress indication */
-
-static void cleanup(void)
-{
-	tst_rmdir();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-}
-
-static void help(void)
-{
-	printf("  -m x    size of malloc in MB (default from /proc/meminfo)\n");
-	printf("  -r      random touching versus linear\n");
-	printf("  -v      verbose progress indication\n");
-}
-
-/*
- * return MemFree+SwapFree, from /proc/meminfo
- * returned value is in bytes.
- */
-size_t get_memsize(void)
-{
-	struct sysinfo info;
-	unsigned long long res;
-	unsigned long long freeswap;
-	unsigned long long freeram;
-	int ret;
-
-	ret = sysinfo(&info);
-	if (ret != 0) {
-		tst_resm(TFAIL,
-			 "Could not retrieve memory information using sysinfo()");
-		cleanup();
-	}
-
-	freeram =
-	    (unsigned long long)info.freeram *
-	    (unsigned long long)info.mem_unit;
-	tst_resm(TINFO, "Free Mem:\t%llu Mb", freeram / 1024 / 1024);
-	res = freeram;
-
-	freeswap =
-	    (unsigned long long)info.freeswap *
-	    (unsigned long long)info.mem_unit;
-	tst_resm(TINFO, "Free Swap:\t%llu Mb", freeswap / 1024 / 1024);
-	res = res + freeswap;
-
-	tst_resm(TINFO, "Total Free:\t%llu Mb", res / 1024 / 1024);
-#if defined(__s390__)
-	if (res > 1 * 1024 * 1024 * 1024)
-		res = 500 * 1024 * 1024;	/* s390's unique 31bit architecture needs smaller default */
-#elif defined(TST_ABI32)
-	if (res > 1 * 1024 * 1024 * 1024)
-		res = 1 * 1024 * 1024 * 1024;
-#elif defined(TST_ABI64)
-	if (res > (unsigned long long)3 * 1024 * 1024 * 1024)
-		res = (unsigned long long)3 *1024 * 1024 * 1024;
-#endif
-
-	/* Always reserve 16MB memory to avoid OOM Killer. */
-	res -= 16 * 1024 * 1024;
-	tst_resm(TINFO, "Total Tested:\t%llu Mb", res / 1024 / 1024);
-	return (size_t) res;
-}
-
-/*
- * add the -m option whose parameter is the
- * memory size (MB) to allocate.
- */
-option_t options[] = {
-	{"m:", &m_opt, &m_copt}
-	,
-	{"r", &r_opt, NULL}
-	,
-	{"v", &v_opt, NULL}
-	,
-	{NULL, NULL, NULL}
-};
-
-int main(int argc, char *argv[])
-{
-	size_t memsize = 0;	/* at first in MB, limited to 4Gb on 32 bits */
-	int pagesize;
-
-	int i;
-	int lc;
-	char *p, *bigmalloc;
-	int loop_count;		/* limited to 16Go on 32 bits systems */
-
-	pagesize = sysconf(_SC_PAGESIZE);
-
-	tst_parse_opts(argc, argv, options, help);
-
-	if (m_opt) {
-		memsize = (size_t) atoi(m_copt) * 1024 * 1024;
-
-		if (memsize < 1) {
-			tst_brkm(TBROK, cleanup, "Invalid arg for -m: %s",
-				 m_copt);
-		}
-	}
-
-	if (r_opt)
-		srand(time(NULL));
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		if (!m_opt) {
-			/* find out by ourselves! */
-			memsize = get_memsize();
-			if (memsize < 1) {
-				tst_brkm(TBROK, cleanup,
-					 "Unable to guess maxmemsize from /proc/meminfo");
-			}
-		}
-
-		/* Allocate (virtual) memory */
-		bigmalloc = p = malloc(memsize);
-
-		if (!p) {
-			tst_resm(TFAIL, "malloc - alloc of %zuMB failed",
-				 memsize / 1024 / 1024);
-			cleanup();
-		}
-
-		/*
-		 * Dirty all the pages, to force physical RAM allocation
-		 * and exercise eventually the swapper
-		 */
-		tst_resm(TINFO, "touching %zuMB of malloc'ed memory (%s)",
-			 memsize / 1024 / 1024, r_opt ? "random" : "linear");
-
-		loop_count = memsize / pagesize;
-
-		for (i = 0; i < loop_count; i++) {
-			if (v_opt
-			    && (i % (PROGRESS_LEAP * 1024 / pagesize) == 0)) {
-				printf(".");
-				fflush(stdout);
-			}
-			/*
-			 * Make the page dirty,
-			 * and make sure compiler won't optimize it away
-			 * Touching more than one word per page is useless
-			 * because of cache.
-			 */
-			*(int *)p = 0xdeadbeef ^ i;
-
-			if (r_opt) {
-				p = bigmalloc +
-				    (size_t) ((double)(memsize - sizeof(int)) *
-					      rand() / (RAND_MAX + 1.0));
-			} else {
-				p += pagesize;
-			}
-		}
-
-		if (v_opt)
-			printf("\n");
-
-		/* This is not mandatory (except in a loop), but it exercise mm again */
-		free(bigmalloc);
-
-		/*
-		 * seems that if the malloc'ed area was bad, we'd get SEGV (or kicked
-		 * somehow by the OOM killer?), hence we can indicate a PASS.
-		 */
-		tst_resm(TPASS, "malloc - alloc of %zuMB succeeded",
-			 memsize / 1024 / 1024);
-
-	}
-
-	cleanup();
-
-	return 0;
-}
-- 
2.27.0

