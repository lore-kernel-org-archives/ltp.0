From: vkabatov@redhat.com <vkabatov@redhat.com>
Date: Mon, 24 Jul 2017 16:47:01 +0200
Subject: [LTP]  [PATCH v2] Add msync04: verify msync() writes back to file
Message-ID: <1500907621-2544-1-git-send-email-vkabatov@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Veronika Kabatova <vkabatov@redhat.com>

Creating a testcase for checking whether msync() succeeds in writing
dirty page back to allocated file. Pagemap interface is used to get
information about a successful write because of caching mechanisms.

Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
---
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/.gitignore      |   1 +
 testcases/kernel/syscalls/msync/msync04.c | 106 ++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)
 create mode 100644 testcases/kernel/syscalls/msync/msync04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2e79ab9..8e1f587 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -705,6 +705,7 @@ msgsnd06 msgsnd06
 msync01 msync01
 msync02 msync02
 msync03 msync03
+msync04 msync04
 
 munlock01 munlock01
 munlock02 munlock02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index fdb01f9..6e0af31 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -612,6 +612,7 @@
 /msync/msync01
 /msync/msync02
 /msync/msync03
+/msync/msync04
 /munlock/munlock01
 /munlock/munlock02
 /munlockall/munlockall01
diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
new file mode 100644
index 0000000..741bcfe
--- /dev/null
+++ b/testcases/kernel/syscalls/msync/msync04.c
@@ -0,0 +1,106 @@
+/*
+ * Copyright (C) 2017 Red Hat, Inc.
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Test description: Verify msync() after writing into mmap()-ed file works.
+ *
+ * Write to mapped region and sync the memory back with file. Check the page
+ * is no longer dirty after msync() call.
+ */
+
+#include <errno.h>
+#include "tst_test.h"
+
+static int test_fd;
+static char *mmaped_area;
+static long pagesize;
+
+#define STRING_TO_WRITE	"AAAAAAAAAA"
+
+uint64_t get_dirty_bit(void *data)
+{
+	int pagemap_fd, pageflags_fd;
+	unsigned long addr;
+	uint64_t pagemap_entry, pageflag_entry, pfn, index;
+
+	addr = (unsigned long)data;
+	index = (addr / pagesize) * sizeof(uint64_t);
+	pagemap_fd = SAFE_OPEN("/proc/self/pagemap", O_RDONLY);
+	SAFE_LSEEK(pagemap_fd, index, SEEK_SET);
+	SAFE_READ(1, pagemap_fd, &pagemap_entry, sizeof(pagemap_entry));
+	SAFE_CLOSE(pagemap_fd);
+	pfn = pagemap_entry & ((1ULL << 55) - 1);
+	if (!pfn)
+		return 0;
+	pageflags_fd = SAFE_OPEN("/proc/kpageflags", O_RDONLY);
+	index = pfn * sizeof(uint64_t);
+	SAFE_LSEEK(pageflags_fd, index, SEEK_SET);
+	SAFE_READ(1, pageflags_fd, &pageflag_entry, sizeof(pageflag_entry));
+	SAFE_CLOSE(pageflags_fd);
+	return pageflag_entry & (1ULL << 4);
+}
+
+static void test_msync(void)
+{
+	uint64_t dirty;
+
+	pagesize = (off_t)SAFE_SYSCONF(_SC_PAGESIZE);
+	test_fd = SAFE_OPEN("msync04/testfile", O_CREAT | O_TRUNC | O_RDWR);
+	SAFE_WRITE(0, test_fd, STRING_TO_WRITE, strlen(STRING_TO_WRITE));
+	mmaped_area = SAFE_MMAP(NULL, pagesize, PROT_READ | PROT_WRITE,
+			MAP_SHARED, test_fd, 0);
+	SAFE_CLOSE(test_fd);
+	mmaped_area[8] = 'B';
+	dirty = get_dirty_bit(mmaped_area);
+	if (!dirty) {
+		tst_res(TFAIL, "Expected dirty bit to be set after writing to"
+				" mmap()-ed area");
+		goto clean;
+	}
+	if (msync(mmaped_area, pagesize, MS_SYNC) < 0) {
+		tst_res(TFAIL | TERRNO, "msync() failed");
+		goto clean;
+	}
+	dirty = get_dirty_bit(mmaped_area);
+	if (dirty)
+		tst_res(TFAIL, "msync() failed to write dirty page despite"
+				" succeeding");
+	else
+		tst_res(TPASS, "msync() working correctly");
+
+clean:
+	SAFE_MUNMAP(mmaped_area, pagesize);
+}
+
+static void cleanup(void)
+{
+	SAFE_MUNMAP(mmaped_area, pagesize);
+	if (test_fd > 0)
+		SAFE_CLOSE(test_fd);
+}
+
+static struct tst_test test = {
+	.test_all = test_msync,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.format_device = 1,
+	.mntpoint = "msync04",
+	.mount_device = 1,
+	.min_kver = "2.6.25",
+};
-- 
2.7.4

