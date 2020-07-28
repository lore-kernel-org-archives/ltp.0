From: Shwetha Subramanian <shwetha@zilogic.com>
Date: Tue, 28 Jul 2020 06:59:10 -0000
Subject: [LTP] [PATCH v2] Add mincore() test for pages cached by another
 process
Message-ID: <20200728065910.6942-1-shwetha@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


It tests the result of mincore when memory is mapped and cached by
another process. A file is mapped in both parent and child
process.Then the mapped memory is accessed in the child process. The
results of mincore are tested in the parent process.

Changes from v1
1. Added cleanup actions to child process
2. Fixed formatting issues
3. Expanded mem_sync() and file_setup() in setup function
4. Reformatted forked processes
5. Altered test result statements

References:#460

Signed-off-by: Shwetha Subramanian. <shwetha@zilogic.com> 
Reviewed-by:Vijay Kumar B. <vijaykumar@zilogic.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/mincore/.gitignore  |   1 +
 testcases/kernel/syscalls/mincore/mincore04.c | 115 ++++++++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mincore/mincore04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index c2bfc6df3..bd3a5145a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -881,6 +881,7 @@ open_tree02 open_tree02
 mincore01 mincore01
 mincore02 mincore02
 mincore03 mincore03
+mincore04 mincore04
 
 madvise01 madvise01
 madvise02 madvise02
diff --git a/testcases/kernel/syscalls/mincore/.gitignore b/testcases/kernel/syscalls/mincore/.gitignore
index 71c3e9864..25a5e8ab1 100644
--- a/testcases/kernel/syscalls/mincore/.gitignore
+++ b/testcases/kernel/syscalls/mincore/.gitignore
@@ -1,3 +1,4 @@
 /mincore01
 /mincore02
 /mincore03
+/mincore04
diff --git a/testcases/kernel/syscalls/mincore/mincore04.c b/testcases/kernel/syscalls/mincore/mincore04.c
new file mode 100644
index 000000000..284c284d5
--- /dev/null
+++ b/testcases/kernel/syscalls/mincore/mincore04.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2020
+ * Email: code@zilogic.com
+ */
+
+/*
+ * mincore04
+ * Test shows that pages mapped in one process(parent) and
+ * faulted in another(child) results in mincore(in parent) reporting
+ * that all mapped pages are resident.
+ */
+
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include "tst_test.h"
+
+#define NUM_PAGES 3
+
+static int fd;
+static int size;
+static void *ptr;
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+	if (ptr)
+		SAFE_MUNMAP(ptr, size);
+}
+
+static void setup(void)
+{
+	int page_size, ret;
+
+	page_size = getpagesize();
+	size = page_size * NUM_PAGES;
+	fd = SAFE_OPEN("FILE", O_CREAT | O_RDWR, 0600);
+	SAFE_FTRUNCATE(fd, size);
+
+	/* File pages from file creation are cleared from cache. */
+	SAFE_FSYNC(fd);
+	ret = posix_fadvise(fd, 0, size, POSIX_FADV_DONTNEED);
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "fadvise failed");
+}
+
+static void mmap_lock_file(void)
+{
+	ptr = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	SAFE_MLOCK(ptr, size);
+	TST_CHECKPOINT_WAKE(0);
+	TST_CHECKPOINT_WAIT(1);
+
+	SAFE_CLOSE(fd);
+	SAFE_MUNLOCK(ptr, size);
+	SAFE_MUNMAP(ptr, size);
+}
+
+static int count_pages_in_cache(void)
+{
+	int locked_pages = 0;
+	int count, ret;
+	unsigned char vec[NUM_PAGES];
+
+	TST_CHECKPOINT_WAIT(0);
+	ptr = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+
+	ret = mincore(ptr, size, vec);
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "mincore failed");
+	for (count = 0; count < NUM_PAGES; count++) {
+		if (vec[count] & 1)
+			locked_pages++;
+	}
+
+	TST_CHECKPOINT_WAKE(1);
+	return locked_pages;
+}
+
+static void test_mincore(void)
+{
+	int  locked_pages;
+
+	pid_t child_pid = SAFE_FORK();
+
+	if (child_pid == 0) {
+		mmap_lock_file();
+		exit(0);
+	}
+
+	locked_pages = count_pages_in_cache();
+	tst_reap_children();
+
+	if (locked_pages == NUM_PAGES)
+		tst_res(TPASS, "mincore reports all %d pages locked by child process "
+			"are resident", locked_pages);
+	else
+		tst_res(TFAIL, "mincore reports %d pages resident but %d pages "
+			"locked by child process", locked_pages, NUM_PAGES);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.test_all = test_mincore,
+	.needs_checkpoints = 1,
+};
-- 
2.20.1

