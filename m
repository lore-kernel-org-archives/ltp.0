From: Martin Doucha <mdoucha@suse.cz>
Date: Wed,  1 Jul 2020 17:14:56 +0200
Subject: [LTP] [PATCH v2 2/2] Add test for CVE 2017-1000405
In-Reply-To: <20200701151456.851-1-mdoucha@suse.cz>
References: <20200701151456.851-1-mdoucha@suse.cz>
Message-ID: <20200701151456.851-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes #316

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- include lapi/mmap.h
- TCONF if madvise(MADV_HUGEPAGE) fails with EINVAL

 runtest/cve                       |   1 +
 runtest/mm                        |   1 +
 testcases/kernel/mem/.gitignore   |   1 +
 testcases/kernel/mem/thp/Makefile |   1 +
 testcases/kernel/mem/thp/thp04.c  | 160 ++++++++++++++++++++++++++++++
 5 files changed, 164 insertions(+)
 create mode 100644 testcases/kernel/mem/thp/thp04.c

diff --git a/runtest/cve b/runtest/cve
index a3a25dbe1..fdb455af1 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -43,6 +43,7 @@ cve-2017-18075 pcrypt_aead01
 cve-2017-1000111 setsockopt07
 cve-2017-1000112 setsockopt05
 cve-2017-1000380 snd_timer01
+cve-2017-1000405 thp04
 cve-2018-5803 sctp_big_chunk
 cve-2018-7566 snd_seq01
 cve-2018-8897 ptrace09
diff --git a/runtest/mm b/runtest/mm
index 612a4d066..4701a14bd 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -86,6 +86,7 @@ swapping01 swapping01 -i 5
 thp01 thp01 -I 120
 thp02 thp02
 thp03 thp03
+thp04 thp04
 
 vma01 vma01
 vma02 vma02
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index ce21ca70f..b95ada109 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -65,6 +65,7 @@
 /thp/thp01
 /thp/thp02
 /thp/thp03
+/thp/thp04
 /tunable/max_map_count
 /tunable/min_free_kbytes
 /tunable/overcommit_memory
diff --git a/testcases/kernel/mem/thp/Makefile b/testcases/kernel/mem/thp/Makefile
index 867dcf089..89abdc7cd 100644
--- a/testcases/kernel/mem/thp/Makefile
+++ b/testcases/kernel/mem/thp/Makefile
@@ -18,6 +18,7 @@
 #
 
 top_srcdir		?= ../../../..
+thp04:			LDLIBS += -lrt
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
diff --git a/testcases/kernel/mem/thp/thp04.c b/testcases/kernel/mem/thp/thp04.c
new file mode 100644
index 000000000..a8d806c42
--- /dev/null
+++ b/testcases/kernel/mem/thp/thp04.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 SUSE LLC <mdoucha@suse.cz>
+ */
+
+/*
+ * CVE-2017-1000405
+ *
+ * Check for the Huge Dirty Cow vulnerability which allows a userspace process
+ * to overwrite the huge zero page. Race fixed in:
+ *
+ *  commit a8f97366452ed491d13cf1e44241bc0b5740b1f0
+ *  Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
+ *  Date:   Mon Nov 27 06:21:25 2017 +0300
+ *
+ *   mm, thp: Do not make page table dirty unconditionally in touch_p[mu]d()
+ */
+
+#include <sys/mman.h>
+
+#include "tst_test.h"
+#include "lapi/mmap.h"
+#include "tst_fuzzy_sync.h"
+
+static char *write_thp, *read_thp;
+static int *write_ptr, *read_ptr;
+static size_t thp_size;
+static int writefd = -1, readfd = -1;
+static struct tst_fzsync_pair fzsync_pair;
+
+static void *alloc_zero_page(void *baseaddr)
+{
+	int i;
+	void *ret;
+
+	/* Find aligned chunk of address space. MAP_HUGETLB doesn't work. */
+	for (i = 0; i < 16; i++, baseaddr += thp_size) {
+		ret = mmap(baseaddr, thp_size, PROT_READ,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+		if (ret == baseaddr) {
+			TEST(madvise(ret, thp_size, MADV_HUGEPAGE));
+
+			if (TST_RET == -1 && TST_ERR == EINVAL) {
+				tst_brk(TCONF | TTERRNO,
+					"madvise(MADV_HUGEPAGE) not supported");
+			}
+
+			if (TST_RET) {
+				tst_brk(TBROK | TTERRNO,
+					"madvise(MADV_HUGEPAGE) failed");
+			}
+
+			return ret;
+		}
+
+		if (ret != MAP_FAILED)
+			SAFE_MUNMAP(ret, thp_size);
+	}
+
+	tst_brk(TBROK, "Cannot map huge zero page near the specified address");
+	return NULL;	/* Silence compiler warning */
+}
+
+static void setup(void)
+{
+	size_t i;
+
+	thp_size = tst_get_hugepage_size();
+
+	if (!thp_size)
+		tst_brk(TCONF, "Kernel does not support huge pages");
+
+	write_thp = alloc_zero_page((void*)thp_size);
+
+	for (i = 0; i < thp_size; i++) {
+		if (write_thp[i]) {
+			tst_brk(TCONF, "Huge zero page is pre-polluted");
+		}
+	}
+
+	/* leave a hole between read and write THP to prevent merge */
+	read_thp = alloc_zero_page(write_thp + 2 * thp_size);
+	write_ptr = (int*)(write_thp + thp_size - sizeof(int));
+	read_ptr = (int*)(read_thp + thp_size - sizeof(int));
+	writefd = SAFE_OPEN("/proc/self/mem", O_RDWR);
+	readfd = SAFE_OPEN("/proc/self/mem", O_RDWR);
+
+	fzsync_pair.exec_loops = 100000;
+	tst_fzsync_pair_init(&fzsync_pair);
+}
+
+static void *thread_run(void *arg)
+{
+	int c;
+
+	while (tst_fzsync_run_b(&fzsync_pair)) {
+		tst_fzsync_start_race_b(&fzsync_pair);
+		madvise(write_thp, thp_size, MADV_DONTNEED);
+		memcpy(&c, write_ptr, sizeof(c));
+		SAFE_LSEEK(readfd, (off_t)write_ptr, SEEK_SET);
+		SAFE_READ(1, readfd, &c, sizeof(int));
+		tst_fzsync_end_race_b(&fzsync_pair);
+		/* Wait for dirty page handling before next madvise() */
+		usleep(10);
+	}
+
+	return arg;
+}
+
+static void run(void)
+{
+	int c = 0xdeadbeef;
+
+	tst_fzsync_pair_reset(&fzsync_pair, thread_run);
+
+	while (tst_fzsync_run_a(&fzsync_pair)) {
+		/* Write into the main huge page */
+		tst_fzsync_start_race_a(&fzsync_pair);
+		SAFE_LSEEK(writefd, (off_t)write_ptr, SEEK_SET);
+		madvise(write_thp, thp_size, MADV_DONTNEED);
+		SAFE_WRITE(1, writefd, &c, sizeof(int));
+		tst_fzsync_end_race_a(&fzsync_pair);
+
+		/* Check the other huge zero page for pollution */
+		madvise(read_thp, thp_size, MADV_DONTNEED);
+
+		if (*read_ptr != 0) {
+			tst_res(TFAIL, "Huge zero page was polluted");
+			return;
+		}
+	}
+
+	tst_res(TPASS, "Huge zero page is still clean");
+}
+
+static void cleanup(void)
+{
+	tst_fzsync_pair_cleanup(&fzsync_pair);
+
+	if (readfd >= 0)
+		SAFE_CLOSE(readfd);
+
+	if (writefd >= 0)
+		SAFE_CLOSE(writefd);
+
+	SAFE_MUNMAP(read_thp, thp_size);
+	SAFE_MUNMAP(write_thp, thp_size);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "a8f97366452e"},
+		{"CVE", "2017-1000405"},
+		{}
+	}
+};
-- 
2.26.2

