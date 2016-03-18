From: Li Wang <liwang@redhat.com>
Date: Fri, 18 Mar 2016 14:31:02 +0800
Subject: [LTP] [PATCH] madvice: new case for madvise(WILLNEED)
Message-ID: <1458282662-21666-1-git-send-email-liwang@redhat.com>
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
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/.gitignore          |   1 +
 testcases/kernel/syscalls/madvise/madvise06.c | 229 ++++++++++++++++++++++++++
 3 files changed, 231 insertions(+)
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
index 0000000..d4b1d7f
--- /dev/null
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -0,0 +1,229 @@
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
+int TST_TOTAL = 1;
+
+#if __x86_64__
+
+#define GB_SZ  (1024*1024*1024)
+#define PG_SZ  (4*1024)
+
+#define INV_PTR ((char *)-1)
+
+static int id_src_1gb;
+static char *src_1gb;
+
+static int *id_dst;
+static char **dst;
+static long dst_num;
+
+static struct sysinfo *sys_buf;
+static long mem_total;
+
+static int page_fault_num1;
+static int page_fault_num2;
+
+static void setup(void);
+static void cleanup(void);
+static void free_shm(void);
+static int  get_page_fault_num(void);
+static void test_advice_willneed(void);
+
+int main(int argc, char *argv[])
+{
+	int lc;
+
+	tst_parse_opts(argc, argv, NULL, NULL);
+
+	sys_buf = malloc(sizeof(struct sysinfo));
+	sysinfo(sys_buf);
+	mem_total = sys_buf->totalram;
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		test_advice_willneed();
+
+		if (page_fault_num1 != page_fault_num2)
+			tst_resm(TFAIL, "Bug has been reproduced!");
+		else
+			tst_resm(TPASS, "Regression test pass!");
+
+		free_shm();
+	}
+
+	free(sys_buf);
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	if (tst_kvercmp(3, 9, 0) < 0)
+		tst_brkm(TCONF, NULL, "madvise(MADV_WILLNEED) swap file"
+			"prefetch available only since 3.9");
+
+	if (mem_total < 2L * GB_SZ) {
+		tst_resm(TCONF, "Test requires more than 2GB of RAM");
+		tst_exit();
+	} else if (mem_total > 100L * GB_SZ) {
+		tst_resm(TCONF, "System RAM is too large, skip this test.");
+		tst_exit();
+	}
+
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	free_shm();
+}
+
+static void free_shm(void)
+{
+	int i;
+
+	if (id_src_1gb != -1) {
+		if (shmctl(id_src_1gb, IPC_RMID, NULL) == -1)
+			tst_brkm(TBROK | TERRNO, NULL, "shmctl(id_src_1gb)");
+	}
+
+	for (i = 0; i < dst_num; ++i) {
+		if (id_dst[i] != -1) {
+			if (shmctl(id_dst[i], IPC_RMID, NULL) == -1)
+				tst_brkm(TBROK | TERRNO, NULL, "shmctl(id_dst[i])");
+		}
+	}
+}
+
+static int get_page_fault_num(void)
+{
+	FILE *fp;
+	char s[11][256];
+	int pg, ret;
+
+	fp = fopen("/proc/self/stat", "r");
+	if (fp == NULL)
+		tst_brkm(TBROK | TERRNO, cleanup, "Failed to open /proc/self/stat.");
+
+	ret = fscanf(fp, "%s %s %s %s %s %s %s %s %s %s %s %d",
+			s[0], s[1], s[2], s[3], s[4], s[5], s[6], s[7], s[8], s[9], s[10], &pg);
+	if (ret != 12) {
+		tst_resm(TFAIL, "Failed to get page fault num.");
+		pg = -1;
+	}
+
+	fclose(fp);
+	return pg;
+}
+
+static void test_advice_willneed(void)
+{
+	int i;
+
+	dst_num = mem_total / GB_SZ;
+	tst_resm(TINFO, "dst_num =  %ld", dst_num);
+
+	if ((id_dst = malloc(dst_num * sizeof(int))) == NULL)
+		tst_brkm(TBROK | TERRNO, NULL, "malloc failed.");
+
+	if ((dst = malloc(dst_num * sizeof(char *))) == NULL)
+		tst_brkm(TBROK | TERRNO, NULL, "malloc failed.");
+
+	id_src_1gb = -1;
+	src_1gb = INV_PTR;
+	for (i = 0; i < dst_num; ++i) {
+		id_dst[i] = -1;
+		dst[i] = INV_PTR;
+	}
+
+	/* allocate source memory (1GB only) */
+	id_src_1gb = shmget(IPC_PRIVATE, 1 * GB_SZ, IPC_CREAT);
+	if (id_src_1gb == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "shmget failed");
+	src_1gb = shmat(id_src_1gb, 0, 0);
+	if (src_1gb == INV_PTR)
+		tst_brkm(TBROK | TERRNO, cleanup, "shmat failed");
+
+	/* allocate destination memory (array) */
+	for (i = 0; i < dst_num; ++i) {
+		id_dst[i] = shmget(IPC_PRIVATE, 1 * GB_SZ, IPC_CREAT);
+		if (id_dst[i] == -1)
+			tst_brkm(TBROK | TERRNO, cleanup, "shmget failed");
+
+		dst[i] = shmat(id_dst[i], 0, 0);
+		if (dst[i] == INV_PTR)
+			tst_brkm(TBROK | TERRNO, cleanup, "shmat failed");
+	}
+
+	/* memmove  source to each destination memories (for SWAP-OUT) */
+	for (i = 0; i < dst_num; ++i) {
+		memmove(dst[i], src_1gb, 1 * GB_SZ);
+		fflush(stdout);
+	}
+
+	/* Do madvice() to dst[0] */
+	tst_resm(TINFO, "PageFault(before madvice): %d", get_page_fault_num());
+
+	TEST(madvise(dst[0], PG_SZ, MADV_WILLNEED));
+	if (TEST_RETURN == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "madvise failed");
+	sleep(3);  /* wait for read from SWAP */
+
+	/* Read dst[0] data */
+	page_fault_num1 = get_page_fault_num();
+	tst_resm(TINFO, "PageFault(after madvice / before Mem Access): %d", page_fault_num1);
+
+	*dst[0] = 10;
+	page_fault_num2 = get_page_fault_num();
+	tst_resm(TINFO, "PageFault(after madvice / after Mem Access): %d", page_fault_num2);
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

