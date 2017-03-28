From: Li Wang <liwang@redhat.com>
Date: Tue, 28 Mar 2017 11:22:32 +0800
Subject: [LTP] [RFC PATCH 06/13] mem/hugemmap: convert to new API
In-Reply-To: <20170328032239.11917-6-liwang@redhat.com>
References: <20170328032239.11917-1-liwang@redhat.com>
 <20170328032239.11917-2-liwang@redhat.com>
 <20170328032239.11917-3-liwang@redhat.com>
 <20170328032239.11917-4-liwang@redhat.com>
 <20170328032239.11917-5-liwang@redhat.com>
 <20170328032239.11917-6-liwang@redhat.com>
Message-ID: <20170328032239.11917-7-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c | 180 +++++--------
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c | 242 +++++++----------
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c | 190 +++++---------
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c | 291 ++++++++-------------
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c |  91 +++----
 testcases/kernel/mem/hugetlb/lib/hugetlb.h         |   2 +
 6 files changed, 364 insertions(+), 632 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index da8bdb1..38c0834 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -1,20 +1,16 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2004
+ * Copyright (c) Linux Test Project, 2004-2017
  *
- *   Copyright (c) International Business Machines  Corp., 2004
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  */
 
 /*
@@ -27,143 +23,86 @@
  *  mmap() should succeed returning the address of the hugetlb mapped region.
  *  The number of free huge pages should decrease.
  *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Pause for SIGUSR1 if option specified.
- *   Create temporary directory.
- *
  * Test:
  *  Loop if the proper options are given.
  *  Execute system call
  *  Check return code, if system call failed (return=-1)
  *  Log the errno and Issue a FAIL message.
- * Cleanup:
- *  Print timing stats if options given
- *  Delete the temporary directory created.
  *
  * HISTORY
  *  04/2004 Written by Robbie Williamson
  */
 
-#include <sys/types.h>
-#include <sys/mman.h>
-#include <sys/mount.h>
-#include <sys/stat.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <signal.h>
-#include <stdint.h>
 #include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-
-#include "test.h"
-#include "hugetlb.h"
-#include "safe_macros.h"
+#include <sys/mount.h>
 #include "mem.h"
+#include "hugetlb.h"
 
-static char TEMPFILE[MAXPATHLEN];
+static struct tst_option options[] = {
+	{"H:", &Hopt,   "-H   /..  Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
+	{NULL, NULL, NULL}
+};
 
-char *TCID = "hugemmap01";
-int TST_TOTAL = 1;
 static long *addr;
-static int fildes;
-static char *Hopt;
+static int  fildes;
 static long beforetest;
 static long aftertest;
 static long hugepagesmapped;
 static long hugepages = 128;
+static char TEMPFILE[MAXPATHLEN];
 
-static void help(void);
-
-int main(int ac, char **av)
+static void test_hugemmap(void)
 {
-	int lc;
-	int Hflag = 0;
 	long page_sz = 0;
-	int sflag = 0;
 
-	option_t options[] = {
-		{"H:", &Hflag, &Hopt},
-		{"s:", &sflag, &nr_opt},
-		{NULL, NULL, NULL}
-	};
+	/* Creat a temporary file used for mapping */
+	fildes = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
 
-	tst_parse_opts(ac, av, options, &help);
+	/* Note the number of free huge pages BEFORE testing */
+	beforetest = read_meminfo("HugePages_Free:");
 
-	if (!Hflag) {
-		tst_tmpdir();
-		Hopt = tst_get_tmpdir();
-	}
-	if (sflag)
-		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* Creat a temporary file used for mapping */
-		fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666);
-		if (fildes < 0)
-			tst_brkm(TFAIL | TERRNO, cleanup, "open %s failed",
-				 TEMPFILE);
-
-		tst_count = 0;
-
-		/* Note the number of free huge pages BEFORE testing */
-		beforetest = read_meminfo("HugePages_Free:");
-
-		/* Note the size of huge page size BEFORE testing */
-		page_sz = read_meminfo("Hugepagesize:") * 1024;
-
-		addr = mmap(NULL, page_sz, PROT_READ | PROT_WRITE,
-			    MAP_SHARED, fildes, 0);
-		if (addr == MAP_FAILED) {
-			tst_resm(TFAIL | TERRNO, "mmap() Failed on %s",
-				 TEMPFILE);
-			close(fildes);
-			continue;
-		} else {
-			close(fildes);
-			tst_resm(TPASS, "call succeeded");
-			/* force to allocate page and change HugePages_Free */
-			*(int *)addr = 0;
-		}
-
-		/*
-		 * Make sure the number of free huge pages
-		 * AFTER testing decreased
-		 */
+	/* Note the size of huge page size BEFORE testing */
+	page_sz = read_meminfo("Hugepagesize:") * 1024;
+
+	addr = mmap(NULL, page_sz, PROT_READ | PROT_WRITE,
+			MAP_SHARED, fildes, 0);
+
+	if (addr == MAP_FAILED) {
+		tst_res(TFAIL | TERRNO, "mmap() Failed on %s",
+				TEMPFILE);
+	} else {
+		tst_res(TPASS, "call succeeded");
+
+		/* force to allocate page and change HugePages_Free */
+		*(int *)addr = 0;
+		/* Make sure the number of free huge pages AFTER testing decreased */
 		aftertest = read_meminfo("HugePages_Free:");
 		hugepagesmapped = beforetest - aftertest;
 		if (hugepagesmapped < 1)
-			tst_resm(TWARN, "Number of HUGEPAGES_FREE stayed the"
-				 " same. Okay if multiple copies running due"
-				 " to test collision.");
-
-		/* Clean up things in case we are looping */
-		/* Unmap the mapped memory */
-		if (munmap(addr, page_sz) != 0)
-			tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
-
-		close(fildes);
+			tst_res(TWARN, "Number of HUGEPAGES_FREE stayed the"
+					" same. Okay if multiple copies running due"
+					" to test collision.");
+		munmap(addr, page_sz);
 	}
 
-	cleanup();
-	tst_exit();
+	close(fildes);
 }
 
 void setup(void)
 {
-	TEST_PAUSE;
-	tst_require_root();
 	check_hugepage();
+	orig_hugepages = get_sys_tune("nr_hugepages");
+
+	if (!Hopt)
+		Hopt = tst_get_tmpdir();
 	if (mount("none", Hopt, "hugetlbfs", 0, NULL) < 0)
-		tst_brkm(TBROK | TERRNO, NULL, "mount failed on %s", Hopt);
+		tst_brk(TBROK | TERRNO, "mount failed on %s", Hopt);
 
-	orig_hugepages = get_sys_tune("nr_hugepages");
+	if (nr_opt)
+		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 	set_sys_tune("nr_hugepages", hugepages, 1);
+
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
 }
 
@@ -173,11 +112,14 @@ void cleanup(void)
 	set_sys_tune("nr_hugepages", orig_hugepages, 0);
 
 	umount(Hopt);
-	tst_rmdir();
 }
 
-static void help(void)
-{
-	printf("    -H /..  Location of hugetlbfs, i.e. -H /var/hugetlbfs\n");
-	printf("    -s num  Set the number of the been allocated hugepages\n");
-}
+static struct tst_test test = {
+	.tid = "hugemmap01",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.options = options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_hugemmap,
+};
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index d31609d..1ed5446 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -1,20 +1,16 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2004
+ * Copyright (c) Linux Test Project, 2004-2017
  *
- *   Copyright (c) International Business Machines  Corp., 2004
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  */
 
 /*
@@ -39,181 +35,137 @@
  *  04/2004 Written by Robbie Williamson
  */
 
-#include <sys/types.h>
-#include <sys/mman.h>
-#include <sys/mount.h>
-#include <sys/stat.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <signal.h>
-#include <stdint.h>
 #include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-
-#include "test.h"
-#include "safe_macros.h"
+#include <sys/mount.h>
 #include "mem.h"
 #include "hugetlb.h"
 
 #define LOW_ADDR       0x80000000
 #define LOW_ADDR2      0x90000000
 
+static struct tst_option options[] = {
+	{"H:", &Hopt,   "-H   /..  Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
+	{NULL, NULL, NULL}
+};
+
 static char TEMPFILE[MAXPATHLEN];
 
-char *TCID = "hugemmap02";
-int TST_TOTAL = 1;
 static unsigned long *addr;
 static unsigned long *addr2;
 static unsigned long low_addr = LOW_ADDR;
 static unsigned long low_addr2 = LOW_ADDR2;
 static unsigned long *addrlist[5];
-static int i;
 static int fildes;
 static int nfildes;
-static char *Hopt;
 static long hugepages = 128;
 
-static void help(void);
-
-int main(int ac, char **av)
+static void test_hugemmap(void)
 {
-	int lc;
-	int Hflag = 0;
+	int i;
 	long page_sz, map_sz;
-	int sflag = 0;
 
-	option_t options[] = {
-		{"H:", &Hflag, &Hopt},
-		{"s:", &sflag, &nr_opt},
-		{NULL, NULL, NULL}
-	};
+	page_sz = getpagesize();
+	map_sz = read_meminfo("Hugepagesize:") * 1024 * 2;
 
-	tst_parse_opts(ac, av, options, &help);
+	/* Creat a temporary file used for huge mapping */
+	fildes = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
 
-	check_hugepage();
+	/* Creat a file used for normal mapping */
+	nfildes = SAFE_OPEN("/dev/zero", O_RDONLY, 0666);
 
-	if (!Hflag) {
-		tst_tmpdir();
-		Hopt = tst_get_tmpdir();
+	/* Call mmap on /dev/zero 5 times */
+	for (i = 0; i < 5; i++) {
+		addr = mmap(0, 256 * 1024 * 1024, PROT_READ,
+				MAP_SHARED, nfildes, 0);
+		addrlist[i] = addr;
 	}
-	if (sflag)
-		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
 
-	page_sz = getpagesize();
-	map_sz = read_meminfo("Hugepagesize:") * 1024 * 2;
+	while (range_is_mapped(low_addr, low_addr + map_sz) == 1) {
+		low_addr = low_addr + 0x10000000;
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* Creat a temporary file used for huge mapping */
-		fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666);
-		if (fildes < 0)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "opening %s failed", TEMPFILE);
-
-		/* Creat a file used for normal mapping */
-		nfildes = open("/dev/zero", O_RDONLY, 0666);
-		if (nfildes < 0)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "opening /dev/zero failed");
-
-		tst_count = 0;
-
-		/*
-		 * Call mmap on /dev/zero 5 times
-		 */
-		for (i = 0; i < 5; i++) {
-			addr = mmap(0, 256 * 1024 * 1024, PROT_READ,
-				    MAP_SHARED, nfildes, 0);
-			addrlist[i] = addr;
-		}
-
-		while (range_is_mapped(cleanup, low_addr, low_addr + map_sz) == 1) {
-			low_addr = low_addr + 0x10000000;
-
-			if (low_addr < LOW_ADDR)
-				tst_brkm(TBROK | TERRNO, cleanup,
-						"no empty region to use");
-		}
-		/* mmap using normal pages and a low memory address */
-		addr = mmap((void *)low_addr, page_sz, PROT_READ,
-			    MAP_SHARED | MAP_FIXED, nfildes, 0);
-		if (addr == MAP_FAILED)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "mmap failed on nfildes");
-
-		while (range_is_mapped(cleanup, low_addr2, low_addr2 + map_sz) == 1) {
-			low_addr2 = low_addr2 + 0x10000000;
-
-			if (low_addr2 < LOW_ADDR2)
-				tst_brkm(TBROK | TERRNO, cleanup,
-						"no empty region to use");
-		}
-		/* Attempt to mmap a huge page into a low memory address */
-		addr2 = mmap((void *)low_addr2, map_sz, PROT_READ | PROT_WRITE,
-			     MAP_SHARED, fildes, 0);
-#if __WORDSIZE == 64		/* 64-bit process */
-		if (addr2 == MAP_FAILED) {
-			tst_resm(TFAIL | TERRNO, "huge mmap failed unexpectedly"
-				 " with %s (64-bit)", TEMPFILE);
-		} else {
-			tst_resm(TPASS, "huge mmap succeeded (64-bit)");
-		}
-#else /* 32-bit process */
-		if (addr2 == MAP_FAILED)
-			tst_resm(TFAIL | TERRNO, "huge mmap failed unexpectedly"
-				 " with %s (32-bit)", TEMPFILE);
-		else if (addr2 > 0) {
-			tst_resm(TCONF,
-				 "huge mmap failed to test the scenario");
-		} else if (addr == 0)
-			tst_resm(TPASS, "huge mmap succeeded (32-bit)");
-#endif
+		if (low_addr < LOW_ADDR)
+			tst_brk(TBROK | TERRNO, "no empty region to use");
+	}
+	/* mmap using normal pages and a low memory address */
+	addr = mmap((void *)low_addr, page_sz, PROT_READ,
+			MAP_SHARED | MAP_FIXED, nfildes, 0);
+	if (addr == MAP_FAILED)
+		tst_brk(TBROK | TERRNO, "mmap failed on nfildes");
 
-		/* Clean up things in case we are looping */
-		for (i = 0; i < 5; i++) {
-			if (munmap(addrlist[i], 256 * 1024 * 1024) == -1)
-				tst_resm(TBROK | TERRNO,
-					 "munmap of addrlist[%d] failed", i);
-		}
+	while (range_is_mapped(low_addr2, low_addr2 + map_sz) == 1) {
+		low_addr2 = low_addr2 + 0x10000000;
 
-		if (munmap(addr2, map_sz) == -1)
-			tst_brkm(TFAIL | TERRNO, NULL, "huge munmap failed");
-		if (munmap(addr, page_sz) == -1)
-			tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
+		if (low_addr2 < LOW_ADDR2)
+			tst_brk(TBROK | TERRNO, "no empty region to use");
+	}
+	/* Attempt to mmap a huge page into a low memory address */
+	addr2 = mmap((void *)low_addr2, map_sz, PROT_READ | PROT_WRITE,
+			MAP_SHARED, fildes, 0);
+#if __WORDSIZE == 64 /* 64-bit process */
+	if (addr2 == MAP_FAILED) {
+		tst_res(TFAIL | TERRNO, "huge mmap failed unexpectedly"
+				" with %s (64-bit)", TEMPFILE);
+	} else {
+		tst_res(TPASS, "huge mmap succeeded (64-bit)");
+	}
+#else /* 32-bit process */
+	if (addr2 == MAP_FAILED)
+		tst_res(TFAIL | TERRNO, "huge mmap failed unexpectedly"
+				" with %s (32-bit)", TEMPFILE);
+	else if (addr2 > 0) {
+		tst_res(TCONF,
+				"huge mmap failed to test the scenario");
+	} else if (addr == 0)
+		tst_res(TPASS, "huge mmap succeeded (32-bit)");
+#endif
 
-		close(nfildes);
-		close(fildes);
+	for (i = 0; i < 5; i++) {
+		if (munmap(addrlist[i], 256 * 1024 * 1024) == -1)
+			tst_res(TFAIL | TERRNO,
+					"munmap of addrlist[%d] failed", i);
 	}
 
-	cleanup();
-	tst_exit();
+	if (munmap(addr2, map_sz) == -1)
+		tst_res(TFAIL | TERRNO, "huge munmap failed");
+	if (munmap(addr, page_sz) == -1)
+		tst_res(TFAIL | TERRNO, "munmap failed");
+
+	close(nfildes);
+	close(fildes);
 }
 
-void setup(void)
+static void setup(void)
 {
-	TEST_PAUSE;
-	tst_require_root();
-	if (mount("none", Hopt, "hugetlbfs", 0, NULL) < 0)
-		tst_brkm(TBROK | TERRNO, NULL, "mount failed on %s", Hopt);
+	check_hugepage();
 	orig_hugepages = get_sys_tune("nr_hugepages");
+
+	if (!Hopt)
+		Hopt = tst_get_tmpdir();
+	if (mount("none", Hopt, "hugetlbfs", 0, NULL) < 0)
+		tst_brk(TBROK | TERRNO, "mount failed on %s", Hopt);
+
+	if (nr_opt)
+		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 	set_sys_tune("nr_hugepages", hugepages, 1);
+
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	unlink(TEMPFILE);
 	set_sys_tune("nr_hugepages", orig_hugepages, 0);
 
 	umount(Hopt);
-	tst_rmdir();
 }
 
-static void help(void)
-{
-	printf("  -H /..  Location of hugetlbfs, i.e. -H /var/hugetlbfs\n");
-	printf("  -s num  Set the number of the been allocated hugepages\n");
-}
+static struct tst_test test = {
+	.tid = "hugemmap02",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.options = options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_hugemmap,
+};
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index e1f2986..3409bd1 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -1,20 +1,16 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2004
+ * Copyright (c) Linux Test Project, 2004-2017
  *
- *   Copyright (c) International Business Machines  Corp., 2004
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  */
 
 /*
@@ -28,47 +24,29 @@
  *  mmap() should succeed returning the address of the hugetlb mapped region.
  *  The number of free huge pages should decrease.
  *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Pause for SIGUSR1 if option specified.
- *   Create temporary directory.
- *
  * Test:
  *  Loop if the proper options are given.
  *  Execute system call
  *  Check return code, if system call failed (return=-1)
  *  Log the errno and Issue a FAIL message.
- * Cleanup:
- *  Print timing stats if options given
- *  Delete the temporary directory created.
  *
  * HISTORY
  *  04/2004 Written by Robbie Williamson
  */
 
-#include <sys/types.h>
-#include <sys/mman.h>
 #include <sys/mount.h>
-#include <sys/stat.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <signal.h>
-#include <stdint.h>
 #include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-
-#include "test.h"
-#include "safe_macros.h"
 #include "mem.h"
 #include "hugetlb.h"
 
+static struct tst_option options[] = {
+	{"H:", &Hopt,   "-H   /..  Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
+	{NULL, NULL, NULL}
+};
+
 static char TEMPFILE[MAXPATHLEN];
 
-char *TCID = "hugemmap04";
-int TST_TOTAL = 1;
 static long *addr;
 static long long mapsize;
 static int fildes;
@@ -77,108 +55,68 @@ static long beforetest;
 static long aftertest;
 static long hugepagesmapped;
 static long hugepages = 128;
-static char *Hopt;
-
-static void help(void);
 
-int main(int ac, char **av)
+static void test_hugemmap(void)
 {
-	int lc;
-	int Hflag = 0;
-	int sflag = 0;
 	int huge_pagesize = 0;
 
-	option_t options[] = {
-		{"H:", &Hflag, &Hopt},
-		{"s:", &sflag, &nr_opt},
-		{NULL, NULL, NULL}
-	};
-
-	tst_parse_opts(ac, av, options, &help);
-
-	if (!Hflag) {
-		tst_tmpdir();
-		Hopt = tst_get_tmpdir();
-	}
-	if (sflag)
-		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* Creat a temporary file used for huge mapping */
-		fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666);
-		if (fildes < 0)
-			tst_brkm(TFAIL | TERRNO, cleanup, "open %s failed",
-				 TEMPFILE);
+	/* Creat a temporary file used for huge mapping */
+	fildes = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
 
-		tst_count = 0;
+	freepages = read_meminfo("HugePages_Free:");
+	beforetest = freepages;
 
-		/* Note the number of free huge pages BEFORE testing */
-		freepages = read_meminfo("HugePages_Free:");
-		beforetest = freepages;
-
-		/* Note the size of huge page size BEFORE testing */
-		huge_pagesize = read_meminfo("Hugepagesize:");
-		tst_resm(TINFO, "Size of huge pages is %d KB", huge_pagesize);
+	huge_pagesize = read_meminfo("Hugepagesize:");
+	tst_res(TINFO, "Size of huge pages is %d KB", huge_pagesize);
 
 #if __WORDSIZE == 32
-		tst_resm(TINFO, "Total amount of free huge pages is %d",
-			 freepages);
-		tst_resm(TINFO, "Max number allowed for 1 mmap file in"
-			 " 32-bits is 128");
-		if (freepages > 128)
-			freepages = 128;
+	tst_res(TINFO, "Total amount of free huge pages is %d",
+			freepages);
+	tst_res(TINFO, "Max number allowed for 1 mmap file in"
+			" 32-bits is 128");
+	if (freepages > 128)
+		freepages = 128;
 #endif
-		mapsize = (long long)freepages *huge_pagesize * 1024;
-		addr = mmap(NULL, mapsize, PROT_READ | PROT_WRITE,
-			    MAP_SHARED, fildes, 0);
-		sleep(2);
-		if (addr == MAP_FAILED) {
-			tst_resm(TFAIL | TERRNO, "mmap() Failed on %s",
-				 TEMPFILE);
-			close(fildes);
-			continue;
-		} else {
-			tst_resm(TPASS,
-				 "Succeeded mapping file using %ld pages",
-				 freepages);
-			/* force to allocate page and change HugePages_Free */
-			*(int *)addr = 0;
-		}
-
-		/*
-		 * Make sure the number of free huge pages
-		 * AFTER testing decreased
-		 */
+	mapsize = (long long)freepages * huge_pagesize * 1024;
+	addr = mmap(NULL, mapsize, PROT_READ | PROT_WRITE,
+			MAP_SHARED, fildes, 0);
+	if (addr == MAP_FAILED) {
+		tst_res(TFAIL | TERRNO, "mmap() Failed on %s",
+				TEMPFILE);
+	} else {
+		tst_res(TPASS,
+				"Succeeded mapping file using %ld pages",
+				freepages);
+
+		/* force to allocate page and change HugePages_Free */
+		*(int *)addr = 0;
+		/* Make sure the number of free huge pages AFTER testing decreased */
 		aftertest = read_meminfo("HugePages_Free:");
 		hugepagesmapped = beforetest - aftertest;
 		if (hugepagesmapped < 1)
-			tst_resm(TWARN, "Number of HUGEPAGES_FREE stayed the"
-				 " same. Okay if multiple copies running due"
-				 " to test collision.");
-
-		/* Clean up things in case we are looping */
-		/* Unmap the mapped memory */
-		if (munmap(addr, mapsize) != 0)
-			tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
-
-		close(fildes);
+			tst_res(TWARN, "Number of HUGEPAGES_FREE stayed the"
+					" same. Okay if multiple copies running due"
+					" to test collision.");
 	}
 
-	cleanup();
-	tst_exit();
+	munmap(addr, mapsize);
+	close(fildes);
 }
 
 void setup(void)
 {
-	TEST_PAUSE;
-	tst_require_root();
 	check_hugepage();
-	if (mount("none", Hopt, "hugetlbfs", 0, NULL) < 0)
-		tst_brkm(TBROK | TERRNO, NULL, "mount failed on %s", Hopt);
 	orig_hugepages = get_sys_tune("nr_hugepages");
+
+	if (!Hopt)
+		Hopt = tst_get_tmpdir();
+	if (mount("none", Hopt, "hugetlbfs", 0, NULL) < 0)
+		tst_brk(TBROK | TERRNO, "mount failed on %s", Hopt);
+
+	if (nr_opt)
+		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 	set_sys_tune("nr_hugepages", hugepages, 1);
+
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
 }
 
@@ -188,10 +126,14 @@ void cleanup(void)
 	set_sys_tune("nr_hugepages", orig_hugepages, 0);
 
 	umount(Hopt);
-	tst_rmdir();
 }
 
-static void help(void)
-{
-	printf("  -H /..  Location of hugetlbfs, i.e. -H /var/hugetlbfs\n");
-}
+static struct tst_test test = {
+	.tid = "hugemmap04",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.options = options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_hugemmap,
+};
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index b127566..9c0fec0 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -1,6 +1,19 @@
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
  * overcommit hugetlbfs and check the statistics.
  *
+ * Description:
+ *
  * hugetlbfs allows to overcommit hugepages and there are tunables in
  * sysfs and procfs. The test here want to ensure it is possible to
  * overcommit by either mmap or shared memory. Also ensure those
@@ -11,44 +24,12 @@
  * Finally, it reads and writes every page. There are command options to
  * choose either to manage hugepages from sysfs or procfs, and reserve
  * them by mmap or shmget.
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
-#include <sys/mman.h>
-#include <sys/stat.h>
-#include <sys/types.h>
+
 #include <sys/mount.h>
-#include <sys/shm.h>
-#include <sys/ipc.h>
-#include <unistd.h>
-#include <errno.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <ctype.h>
-#include "test.h"
+#include "mem.h"
 #include "hugetlb.h"
+#include "tst_safe_stdio.h"
 
 #define PROTECTION		(PROT_READ | PROT_WRITE)
 #define PATH_MEMINFO		"/proc/meminfo"
@@ -80,66 +61,32 @@ char path_sys_sz_huge[BUFSIZ];
 #define SHM_HUGETLB 04000
 #endif
 
-char *TCID = "hugemmap05";
-int TST_TOTAL = 1, tst_count;
 static char nr_hugepages[BUFSIZ], nr_overcommit_hugepages[BUFSIZ];
 static char buf[BUFSIZ], line[BUFSIZ], path[BUFSIZ], pathover[BUFSIZ];
 static char shmmax[BUFSIZ];
-static char *opt_allocstr;
 static int hugepagesize;	/* in Bytes */
-static int opt_sysfs, opt_alloc;
 static int shmid = -1;
 static int restore_shmmax;
 static size_t size = 128, length = 384;
-static option_t options[] = {
-	{"s", &opt_sysfs, NULL},
-	{"m", &shmid, NULL},
-	{"a:", &opt_alloc, &opt_allocstr},
+
+char *opt_sysfs;
+char *opt_alloc;
+char *opt_shmid;
+static struct tst_option options[] = {
+	{"s",  &opt_sysfs, "-s        Setup hugepages from sysfs"},
+	{"m",  &opt_shmid, "-m        Reserve hugepages by shmget"},
+	{"a:", &opt_alloc, "-a        Number of overcommint hugepages"},
 	{NULL, NULL, NULL}
 };
 
-static void setup(void);
-static void cleanup(void);
-static void overcommit(void);
 static void write_bytes(void *addr);
 static void read_bytes(void *addr);
 static int lookup(char *line, char *pattern);
-static void usage(void);
 static int checkproc(FILE * fp, char *string, int value);
 static int checksys(char *path, char *pattern, int value);
-static void init_hugepagesize(void);
 static void init_sys_sz_paths(void);
 
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	init_hugepagesize();
-	init_sys_sz_paths();
-
-	tst_parse_opts(argc, argv, options, usage);
-	if (opt_sysfs) {
-		strncpy(path, path_sys_sz_huge, strlen(path_sys_sz_huge) + 1);
-		strncpy(pathover, path_sys_sz_over,
-			strlen(path_sys_sz_over) + 1);
-	} else {
-		strncpy(path, PATH_PROC_HUGE, strlen(PATH_PROC_HUGE) + 1);
-		strncpy(pathover, PATH_PROC_OVER, strlen(PATH_PROC_OVER) + 1);
-	}
-	if (opt_alloc) {
-		size = atoi(opt_allocstr);
-		length = (int)(size + size * 0.5) * 2;
-	}
-	setup();
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		overcommit();
-	}
-	cleanup();
-	tst_exit();
-}
-
-static void overcommit(void)
+static void test_overcommit(void)
 {
 	void *addr = NULL, *shmaddr = NULL;
 	int fd = -1, key = -1;
@@ -150,27 +97,25 @@ static void overcommit(void)
 		/* Use /proc/meminfo to generate an IPC key. */
 		key = ftok(PATH_MEMINFO, strlen(PATH_MEMINFO));
 		if (key == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "ftok");
+			tst_brk(TBROK | TERRNO, "ftok");
 		shmid = shmget(key, (long)(length / 2 * hugepagesize),
 			       SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W);
 		if (shmid == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "shmget");
+			tst_brk(TBROK | TERRNO, "shmget");
 	} else {
 		/* XXX (garrcoop): memory leak. */
 		snprintf(s, BUFSIZ, "%s/hugemmap05/file", tst_get_tmpdir());
-		fd = open(s, O_CREAT | O_RDWR, 0755);
-		if (fd == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "open");
+		fd = SAFE_OPEN(s, O_CREAT | O_RDWR, 0755);
 		addr = mmap(ADDR, (long)(length / 2 * hugepagesize), PROTECTION,
 			    FLAGS, fd, 0);
 		if (addr == MAP_FAILED) {
 			close(fd);
-			tst_brkm(TBROK | TERRNO, cleanup, "mmap");
+			tst_brk(TBROK | TERRNO, "mmap");
 		}
 	}
 
 	if (opt_sysfs) {
-		tst_resm(TINFO, "check sysfs before allocation.");
+		tst_res(TINFO, "check sysfs before allocation.");
 		if (checksys(path_sys_sz_huge, "HugePages_Total",
 			     length / 2) != 0)
 			return;
@@ -184,10 +129,8 @@ static void overcommit(void)
 			     length / 2) != 0)
 			return;
 	} else {
-		tst_resm(TINFO, "check /proc/meminfo before allocation.");
-		fp = fopen(PATH_MEMINFO, "r");
-		if (fp == NULL)
-			tst_brkm(TBROK | TERRNO, cleanup, "fopen");
+		tst_res(TINFO, "check /proc/meminfo before allocation.");
+		fp = SAFE_FOPEN(PATH_MEMINFO, "r");
 		if (checkproc(fp, "HugePages_Total", length / 2) != 0)
 			return;
 		if (checkproc(fp, "HugePages_Free", length / 2) != 0)
@@ -199,10 +142,10 @@ static void overcommit(void)
 		fclose(fp);
 	}
 	if (shmid != -1) {
-		tst_resm(TINFO, "shmid: 0x%x", shmid);
+		tst_res(TINFO, "shmid: 0x%x", shmid);
 		shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);
 		if (shmaddr == (void *)-1)
-			tst_brkm(TBROK | TERRNO, cleanup, "shmat");
+			tst_brk(TBROK | TERRNO, "shmat");
 		write_bytes(shmaddr);
 		read_bytes(shmaddr);
 	} else {
@@ -210,7 +153,7 @@ static void overcommit(void)
 		read_bytes(addr);
 	}
 	if (opt_sysfs) {
-		tst_resm(TINFO, "check sysfs.");
+		tst_res(TINFO, "check sysfs.");
 		if (checksys(path_sys_sz_huge, "HugePages_Total",
 			     length / 2) != 0)
 			return;
@@ -224,10 +167,8 @@ static void overcommit(void)
 		    != 0)
 			return;
 	} else {
-		tst_resm(TINFO, "check /proc/meminfo.");
-		fp = fopen(PATH_MEMINFO, "r");
-		if (fp == NULL)
-			tst_brkm(TBROK | TERRNO, cleanup, "fopen");
+		tst_res(TINFO, "check /proc/meminfo.");
+		fp = SAFE_FOPEN(PATH_MEMINFO, "r");
 		if (checkproc(fp, "HugePages_Total", length / 2) != 0)
 			return;
 		if (checkproc(fp, "HugePages_Free", 0) != 0)
@@ -240,12 +181,14 @@ static void overcommit(void)
 	}
 	if (shmid != -1) {
 		if (shmdt(shmaddr) != 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "shmdt");
+			tst_brk(TBROK | TERRNO, "shmdt");
 	} else {
 		munmap(addr, (long)(length / 2 * hugepagesize));
 		close(fd);
 		unlink(s);
 	}
+
+	tst_res(TPASS, "hugepages overcommit test pass");
 }
 
 static void cleanup(void)
@@ -255,39 +198,38 @@ static void cleanup(void)
 	if (restore_shmmax) {
 		fd = open(PATH_SHMMAX, O_WRONLY);
 		if (fd == -1)
-			tst_resm(TWARN | TERRNO, "open");
+			tst_res(TWARN | TERRNO, "open");
 		if (write(fd, shmmax, strlen(shmmax)) != (ssize_t)strlen(shmmax))
-			tst_resm(TWARN | TERRNO, "write");
+			tst_res(TWARN | TERRNO, "write");
 		close(fd);
 	}
 	fd = open(path, O_WRONLY);
 	if (fd == -1)
-		tst_resm(TWARN | TERRNO, "open");
-	tst_resm(TINFO, "restore nr_hugepages to %s.", nr_hugepages);
+		tst_res(TWARN | TERRNO, "open");
+	tst_res(TINFO, "restore nr_hugepages to %s.", nr_hugepages);
 	if (write(fd, nr_hugepages,
 		  strlen(nr_hugepages)) != (ssize_t)strlen(nr_hugepages))
-		tst_resm(TWARN | TERRNO, "write");
+		tst_res(TWARN | TERRNO, "write");
 	close(fd);
 
 	fd = open(pathover, O_WRONLY);
 	if (fd == -1)
-		tst_resm(TWARN | TERRNO, "open");
-	tst_resm(TINFO, "restore nr_overcommit_hugepages to %s.",
+		tst_res(TWARN | TERRNO, "open");
+	tst_res(TINFO, "restore nr_overcommit_hugepages to %s.",
 		 nr_overcommit_hugepages);
 	if (write(fd, nr_overcommit_hugepages, strlen(nr_overcommit_hugepages))
 	    != (ssize_t)strlen(nr_overcommit_hugepages))
-		tst_resm(TWARN | TERRNO, "write");
+		tst_res(TWARN | TERRNO, "write");
 	close(fd);
 
 	/* XXX (garrcoop): memory leak. */
 	snprintf(buf, BUFSIZ, "%s/hugemmap05", tst_get_tmpdir());
 	if (umount(buf) == -1)
-		tst_resm(TWARN | TERRNO, "umount");
+		tst_res(TWARN | TERRNO, "umount");
 	if (shmid != -1) {
-		tst_resm(TINFO, "shmdt cleaning");
+		tst_res(TINFO, "shmdt cleaning");
 		shmctl(shmid, IPC_RMID, NULL);
 	}
-	tst_rmdir();
 }
 
 static void setup(void)
@@ -296,93 +238,97 @@ static void setup(void)
 	int fd;
 	struct stat stat_buf;
 
-	tst_require_root();
+	hugepagesize = read_meminfo("Hugepagesize:") * 1024;
+	init_sys_sz_paths();
+
+	if (opt_shmid)
+		shmid = 0;
 
+	if (opt_sysfs) {
+		strncpy(path, path_sys_sz_huge, strlen(path_sys_sz_huge) + 1);
+		strncpy(pathover, path_sys_sz_over,
+			strlen(path_sys_sz_over) + 1);
+	} else {
+		strncpy(path, PATH_PROC_HUGE, strlen(PATH_PROC_HUGE) + 1);
+		strncpy(pathover, PATH_PROC_OVER, strlen(PATH_PROC_OVER) + 1);
+	}
+	if (opt_alloc) {
+		size = atoi(opt_alloc);
+		length = (int)(size + size * 0.5) * 2;
+	}
 	if (stat(pathover, &stat_buf) == -1) {
 		if (errno == ENOENT || errno == ENOTDIR)
-			tst_brkm(TCONF, NULL,
+			tst_brk(TCONF,
 				 "file %s does not exist in the system",
 				 pathover);
 	}
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-	tst_tmpdir();
-
 	if (shmid != -1) {
 		fp = fopen(PATH_SHMMAX, "r");
 		if (fp == NULL)
-			tst_brkm(TBROK | TERRNO, cleanup, "fopen");
+			tst_brk(TBROK | TERRNO, "fopen");
 		if (fgets(shmmax, BUFSIZ, fp) == NULL)
-			tst_brkm(TBROK | TERRNO, cleanup, "fgets");
+			tst_brk(TBROK | TERRNO, "fgets");
 		fclose(fp);
 
 		if (atol(shmmax) < (long)(length / 2 * hugepagesize)) {
 			restore_shmmax = 1;
 			fd = open(PATH_SHMMAX, O_RDWR);
 			if (fd == -1)
-				tst_brkm(TBROK | TERRNO, cleanup, "open");
+				tst_brk(TBROK | TERRNO, "open");
 			snprintf(buf, BUFSIZ, "%ld",
 				 (long)(length / 2 * hugepagesize));
 			if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))
-				tst_brkm(TBROK | TERRNO, cleanup,
+				tst_brk(TBROK | TERRNO,
 					 "failed to change shmmax.");
 		}
 	}
-	fp = fopen(path, "r+");
-	if (fp == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "fopen");
+	fp = SAFE_FOPEN(path, "r+");
 	if (fgets(nr_hugepages, BUFSIZ, fp) == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "fgets");
+		tst_brk(TBROK | TERRNO, "fgets");
 	fclose(fp);
 	/* Remove trailing newline. */
 	nr_hugepages[strlen(nr_hugepages) - 1] = '\0';
-	tst_resm(TINFO, "original nr_hugepages is %s", nr_hugepages);
+	tst_res(TINFO, "original nr_hugepages is %s", nr_hugepages);
 
-	fd = open(path, O_RDWR);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open");
+	fd = SAFE_OPEN(path, O_RDWR);
 	/* Reset. */
-	if (write(fd, "0", 1) != 1)
-		tst_brkm(TBROK | TERRNO, cleanup, "write");
-	if (lseek(fd, 0, SEEK_SET) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "lseek");
+	SAFE_WRITE(1, fd, "0", 1);
+	SAFE_LSEEK(fd, 0, SEEK_SET);
 	snprintf(buf, BUFSIZ, "%zd", size);
 	if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "failed to change nr_hugepages.");
+		tst_brk(TBROK | TERRNO,
+			"failed to change nr_hugepages.");
 	close(fd);
 
-	fp = fopen(pathover, "r+");
-	if (fp == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "fopen");
+	fp = SAFE_FOPEN(pathover, "r+");
 	if (fgets(nr_overcommit_hugepages, BUFSIZ, fp) == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "fgets");
+		tst_brk(TBROK | TERRNO, "fgets");
 	fclose(fp);
 	nr_overcommit_hugepages[strlen(nr_overcommit_hugepages) - 1] = '\0';
-	tst_resm(TINFO, "original nr_overcommit_hugepages is %s",
+	tst_res(TINFO, "original nr_overcommit_hugepages is %s",
 		 nr_overcommit_hugepages);
 
 	fd = open(pathover, O_RDWR);
 	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open");
+		tst_brk(TBROK | TERRNO, "open");
 	/* Reset. */
 	if (write(fd, "0", 1) != 1)
-		tst_brkm(TBROK | TERRNO, cleanup, "write");
+		tst_brk(TBROK | TERRNO, "write");
 	if (lseek(fd, 0, SEEK_SET) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "lseek");
+		tst_brk(TBROK | TERRNO, "lseek");
 	snprintf(buf, BUFSIZ, "%zd", size);
 	if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))
-		tst_brkm(TBROK | TERRNO, cleanup,
+		tst_brk(TBROK | TERRNO,
 			 "failed to change nr_hugepages.");
 	close(fd);
 
 	/* XXX (garrcoop): memory leak. */
 	snprintf(buf, BUFSIZ, "%s/hugemmap05", tst_get_tmpdir());
 	if (mkdir(buf, 0700) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "mkdir");
+		tst_brk(TBROK | TERRNO, "mkdir");
 	if (mount(NULL, buf, "hugetlbfs", 0, NULL) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "mount");
+		tst_brk(TBROK | TERRNO, "mount");
 }
 
 static void write_bytes(void *addr)
@@ -397,10 +343,10 @@ static void read_bytes(void *addr)
 {
 	long i;
 
-	tst_resm(TINFO, "First hex is %x", *((unsigned int *)addr));
+	tst_res(TINFO, "First hex is %x", *((unsigned int *)addr));
 	for (i = 0; i < (long)(length / 2 * hugepagesize); i++) {
 		if (((char *)addr)[i] != '\a') {
-			tst_resm(TFAIL, "mismatch at %ld", i);
+			tst_res(TFAIL, "mismatch@%ld", i);
 			break;
 		}
 	}
@@ -422,25 +368,16 @@ static int lookup(char *line, char *pattern)
 	return 1;
 }
 
-static void usage(void)
-{
-	printf("  -s      Setup hugepages from sysfs\n");
-	printf("  -m      Reserve hugepages by shmget\n");
-	printf("  -a      Number of overcommint hugepages\n");
-}
-
 static int checksys(char *path, char *string, int value)
 {
 	FILE *fp;
 
-	fp = fopen(path, "r");
-	if (fp == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "fopen");
+	fp = SAFE_FOPEN(path, "r");
 	if (fgets(buf, BUFSIZ, fp) == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "fgets");
-	tst_resm(TINFO, "%s is %d.", string, atoi(buf));
+		tst_brk(TBROK | TERRNO, "fgets");
+	tst_res(TINFO, "%s is %d.", string, atoi(buf));
 	if (atoi(buf) != value) {
-		tst_resm(TFAIL, "%s is not %d but %d.", string, value,
+		tst_res(TFAIL, "%s is not %d but %d.", string, value,
 			 atoi(buf));
 		fclose(fp);
 		return 1;
@@ -457,39 +394,15 @@ static int checkproc(FILE * fp, char *pattern, int value)
 		if (lookup(line, pattern))
 			break;
 
-	tst_resm(TINFO, "%s is %d.", pattern, atoi(buf));
+	tst_res(TINFO, "%s is %d.", pattern, atoi(buf));
 	if (atoi(buf) != value) {
-		tst_resm(TFAIL, "%s is not %d but %d.", pattern, value,
+		tst_res(TFAIL, "%s is not %d but %d.", pattern, value,
 			 atoi(buf));
 		return 1;
 	}
 	return 0;
 }
 
-static void init_hugepagesize(void)
-{
-	FILE *fp;
-
-	check_hugepage();
-	memset(buf, -1, BUFSIZ);
-	fp = fopen(PATH_MEMINFO, "r");
-	if (fp == NULL)
-		tst_brkm(TBROK, NULL, "can't open %s", PATH_MEMINFO);
-	while (fgets(line, BUFSIZ, fp) != NULL) {
-		if (lookup(line, "Hugepagesize")) {
-			tst_resm(TINFO, "Hugepagesize is %s kB", buf);
-			hugepagesize = atoi(buf) * 1024;
-			fclose(fp);
-			return;
-		}
-	}
-	tst_brkm(TBROK, NULL, "get Hugepagesize failed.");
-}
-
-/*
- * It's not easy to #define tunable file paths via sysfs,
- * use function init_hugepagesize and global variable instead.
- */
 static void init_sys_sz_paths(void)
 {
 	sprintf(path_sys_sz, "/sys/kernel/mm/hugepages/hugepages-%dkB",
@@ -500,3 +413,13 @@ static void init_sys_sz_paths(void)
 	sprintf(path_sys_sz_surp, "%s/surplus_hugepages", path_sys_sz);
 	sprintf(path_sys_sz_huge, "%s/nr_hugepages", path_sys_sz);
 }
+
+static struct tst_test test = {
+	.tid = "hugemmap05",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.options = options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_overcommit,
+};
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
index b061d5a..daaac3e 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
@@ -1,18 +1,15 @@
 /*
- *  Copyright (c) 2015 Red Hat, Inc.
+ * Copyright (c) 2015-2017 Red Hat, Inc.
  *
- * This program is free software: you can redistribute it and/or modify
+ * This program is free software;  you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 3 of the License, or
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  */
 
 /*
@@ -36,22 +33,12 @@
  */
 
 #define _GNU_SOURCE
-#include <errno.h>
 #include <pthread.h>
 #include <stdio.h>
-#include <stdlib.h>
-#include <sys/mman.h>
-#include <sys/types.h>
-#include <unistd.h>
-
-#include "test.h"
 #include "mem.h"
 #include "hugetlb.h"
 #include "lapi/mmap.h"
 
-char *TCID = "hugemmap06";
-int TST_TOTAL = 5;
-
 static long hpage_size;
 static long hugepages;
 
@@ -61,37 +48,29 @@ struct mp {
 };
 
 #define ARSZ 50
+#define LOOP 5
 
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
 	check_hugepage();
 
-	/* MAP_HUGETLB check */
-	if ((tst_kvercmp(2, 6, 32)) < 0) {
-		tst_brkm(TCONF, NULL, "This test can only run on kernels "
-			"that are 2.6.32 or higher");
-	}
-
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
 	orig_hugepages = get_sys_tune("nr_hugepages");
 
-	hugepages = (ARSZ + 1) * TST_TOTAL;
+	hugepages = (ARSZ + 1) * LOOP;
 
 	if (hugepages * read_meminfo("Hugepagesize:") > read_meminfo("MemTotal:"))
-		tst_brkm(TCONF, NULL, "System RAM is not enough to test.");
+		tst_brk(TCONF, "System RAM is not enough to test.");
 
 	set_sys_tune("nr_hugepages", hugepages, 1);
-
-	TEST_PAUSE;
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	set_sys_tune("nr_hugepages", orig_hugepages, 0);
 }
 
-void *thr(void *arg)
+static void *thr(void *arg)
 {
 	struct mp *mmap_sz = arg;
 	int i, lim, a, b, c;
@@ -108,7 +87,7 @@ void *thr(void *arg)
 	return NULL;
 }
 
-void do_mmap(void)
+static void do_mmap(unsigned int j LTP_ATTRIBUTE_UNUSED)
 {
 	int i, sz = ARSZ + 1;
 	void *addr, *new_addr;
@@ -122,11 +101,11 @@ void do_mmap(void)
 
 	if (addr == MAP_FAILED) {
 		if (errno == ENOMEM) {
-			tst_brkm(TCONF, cleanup,
+			tst_brk(TCONF,
 				"Cannot allocate hugepage, memory too fragmented?");
 		}
 
-		tst_brkm(TBROK | TERRNO, cleanup, "Cannot allocate hugepage");
+		tst_brk(TBROK | TERRNO, "Cannot allocate hugepage");
 	}
 
 	for (i = 0; i < ARSZ; ++i, --sz) {
@@ -135,7 +114,7 @@ void do_mmap(void)
 
 		TEST(pthread_create(&tid[i], NULL, thr, &mmap_sz[i]));
 		if (TEST_RETURN)
-			tst_brkm(TBROK | TRERRNO, cleanup,
+			tst_brk(TBROK | TRERRNO,
 					"pthread_create failed");
 
 		new_addr = mmap(addr, (sz - 1) * hpage_size,
@@ -144,7 +123,7 @@ void do_mmap(void)
 				-1, 0);
 
 		if (new_addr == MAP_FAILED)
-			tst_brkm(TFAIL | TERRNO, cleanup, "mmap failed");
+			tst_brk(TFAIL | TERRNO, "mmap failed");
 
 		addr = new_addr;
 	}
@@ -152,31 +131,23 @@ void do_mmap(void)
 	for (i = 0; i < ARSZ; ++i) {
 		TEST(pthread_join(tid[i], NULL));
 		if (TEST_RETURN)
-			tst_brkm(TBROK | TRERRNO, cleanup,
+			tst_brk(TBROK | TRERRNO,
 					"pthread_join failed");
 	}
 
 	if (munmap(addr, sz * hpage_size) == -1)
-		tst_brkm(TFAIL | TERRNO, cleanup, "huge munmap failed");
-}
-
-int main(int ac, char **av)
-{
-	int lc, i;
+		tst_brk(TFAIL | TERRNO, "huge munmap failed");
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++)
-			do_mmap();
-
-		tst_resm(TPASS, "No regression found.");
-	}
-
-	cleanup();
-	tst_exit();
+	tst_res(TPASS, "No regression found.");
 }
+
+static struct tst_test test = {
+	.tid = "hugemmap06",
+	.min_kver = "2.6.32",
+	.needs_root = 1,
+	.tcnt = LOOP,
+	.needs_tmpdir = 1,
+	.test = do_mmap,
+	.setup = setup,
+	.cleanup = cleanup,
+};
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index 1b5cc73..6f5cbb7 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -27,9 +27,11 @@
 #include <stdlib.h>
 #include <sys/ipc.h>
 #include <sys/shm.h>
+#include <sys/param.h>
 #include <errno.h>
 #include <sys/wait.h>
 #include "tst_test.h"
+#include "old_tmpdir.h"
 
 #define SHM_RD	0400
 #define SHM_WR	0200
-- 
2.9.3

