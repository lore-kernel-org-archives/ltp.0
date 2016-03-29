From: Li Wang <liwang@redhat.com>
Date: Tue, 29 Mar 2016 17:55:44 +0800
Subject: [LTP] [PATCH V2] madvice: new case for madvise(WILLNEED)
Message-ID: <1459245344-5983-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Page fault occurs in spite that madvise(WILLNEED) system call is called
to prefetch the page. This issue is reproduced by running a program
which sequentially accesses to a shared memory and calls madvise(WILLNEED)
to the next page on a page fault.

Fixed by commit:
	55231e5c898 mm: madvise: fix MADV_WILLNEED on shmem swapouts

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    V1 --> V2
    * set the TST_TOTAL = 3, run with '-i 100' can work
    * declare the addr array as char *dst[100]
    * create sysinfo struct sys_buf on the stack in setup()
    * use mmap() with 'MAP_SHARED | MAP_ANONYMOUS' instead shmat()
    * take use of the assigment-supression operator '*' of fscanf
    * remove fflush(stdout), free_shm(), cleanup()

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/.gitignore          |   1 +
 testcases/kernel/syscalls/madvise/madvise06.c | 172 ++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100644 testcases/kernel/syscalls/madvise/madvise06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b41c927..732c2ca 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -743,6 +743,7 @@ madvise02 madvise02
 madvise03 madvise03
 madvise04 madvise04
 madvise05 madvise05
+madvise06 madvise06
 
 newuname01 newuname01
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 0540928..ffa5db1 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -504,6 +504,7 @@
 /madvise/madvise03
 /madvise/madvise04
 /madvise/madvise05
+/madvise/madvise06
 /mallopt/mallopt01
 /mbind/mbind01
 /memcmp/memcmp01
diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
new file mode 100644
index 0000000..bf15a3c
--- /dev/null
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -0,0 +1,172 @@
+/*
+ * Copyright (c) 2016 Red Hat, Inc.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 3 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * DESCRIPTION
+ *
+ *   Page fault occurs in spite that madvise(WILLNEED) system call is called
+ *   to prefetch the page. This issue is reproduced by running a program
+ *   which sequentially accesses to a shared memory and calls madvise(WILLNEED)
+ *   to the next page on a page fault.
+ *
+ *   This bug is present in all RHEL7 versions. It looks like this was fixed in
+ *   mainline kernel > v3.15 by the following patch:
+ *
+ *   commit 55231e5c898c5c03c14194001e349f40f59bd300
+ *   Author: Johannes Weiner <hannes@cmpxchg.org>
+ *   Date:   Thu May 22 11:54:17 2014 -0700
+ *
+ *       mm: madvise: fix MADV_WILLNEED on shmem swapouts
+ */
+
+#include <stdio.h>
+#include <sys/shm.h>
+#include <errno.h>
+#include <sys/sysinfo.h>
+
+#include "test.h"
+#include "safe_macros.h"
+
+char *TCID = "madvise06";
+int TST_TOTAL = 3;
+
+#ifdef __x86_64__
+
+#define GB_SZ  (1024*1024*1024)
+#define PG_SZ  (4*1024)
+
+static long dst_num;
+
+static void setup(void);
+static int  get_page_fault_num(void);
+static void test_advice_willneed(void);
+
+int main(int argc, char *argv[])
+{
+	int i, lc;
+
+	tst_parse_opts(argc, argv, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for(i = 0; i < TST_TOTAL; i++)
+			test_advice_willneed();
+	}
+
+	tst_exit();
+}
+
+static void setup(void)
+{
+	struct sysinfo sys_buf;
+
+	sysinfo(&sys_buf);
+
+	dst_num = sys_buf.totalram / GB_SZ;
+	tst_resm(TINFO, "dst_num =  %ld", dst_num);
+
+	tst_sig(NOFORK, DEF_HANDLER, NULL);
+	if (tst_kvercmp(3, 9, 0) < 0)
+		tst_brkm(TCONF, NULL, "madvise(MADV_WILLNEED) swap file"
+			"prefetch available only since 3.9");
+
+	if (sys_buf.totalram < 2L * GB_SZ)
+		tst_brkm(TCONF, NULL, "Test requires more than 2GB of RAM.");
+	if (sys_buf.totalram > 100L * GB_SZ)
+		tst_brkm(TCONF, NULL, "System RAM is too large, skip this test.");
+
+	TEST_PAUSE;
+}
+
+static int get_page_fault_num(void)
+{
+	int pg;
+
+	SAFE_FILE_SCANF(NULL, "/proc/self/stat",
+			"%*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %d",
+			&pg);
+
+	return pg;
+}
+
+static void test_advice_willneed(void)
+{
+	int i;
+	char *src_1gb;
+	char *dst[100];
+	int page_fault_num1;
+	int page_fault_num2;
+
+	/* allocate source memory (1GB only) */
+	src_1gb = mmap(NULL, 1 * GB_SZ, PROT_READ | PROT_WRITE,
+			MAP_SHARED | MAP_ANONYMOUS,
+			-1, 0);
+	if (src_1gb == MAP_FAILED)
+		tst_brkm(TFAIL | TERRNO, NULL, "mmap failed");
+
+	/* allocate destination memory (array) */
+	for (i = 0; i < dst_num; ++i) {
+		dst[i] = mmap(NULL, 1 * GB_SZ, PROT_READ | PROT_WRITE,
+				MAP_SHARED | MAP_ANONYMOUS,
+				-1, 0);
+		if (dst[i] == MAP_FAILED)
+			tst_brkm(TFAIL | TERRNO, NULL, "mmap failed");
+	}
+
+	/* memmove  source to each destination memories (for SWAP-OUT) */
+	for (i = 0; i < dst_num; ++i)
+		memmove(dst[i], src_1gb, 1 * GB_SZ);
+
+	tst_resm(TINFO, "PageFault(before madvice): %d", get_page_fault_num());
+
+	/* Do madvice() to dst[0] */
+	TEST(madvise(dst[0], PG_SZ, MADV_WILLNEED));
+	if (TEST_RETURN == -1)
+		tst_brkm(TBROK | TERRNO, NULL, "madvise failed");
+	usleep(1000);  /* wait for read from SWAP */
+
+	page_fault_num1 = get_page_fault_num();
+	tst_resm(TINFO, "PageFault(after madvice / before Mem Access): %d", page_fault_num1);
+
+	*dst[0] = 'a';
+	page_fault_num2 = get_page_fault_num();
+	tst_resm(TINFO, "PageFault(after madvice / after Mem Access): %d", page_fault_num2);
+
+	if (page_fault_num1 != page_fault_num2)
+		tst_resm(TFAIL, "Bug has been reproduced!");
+	else
+		tst_resm(TPASS, "Regression test pass!");
+
+	if (munmap(src_1gb, 1 * GB_SZ) == -1)
+		tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
+
+	for (i = 0; i < dst_num; ++i) {
+		if (munmap(dst[i], 1 * GB_SZ) == -1)
+			tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
+	}
+}
+
+
+#else
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "Only test on x86_64.");
+}
+#endif
-- 
1.8.3.1

