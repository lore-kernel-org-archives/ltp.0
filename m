From: pravin <pravinraghul@zilogic.com>
Date: Tue, 30 Jun 2020 05:44:05 -0000
Subject: [LTP] [PATCH v1] Add a test case for mmap() MAP_GROWSDOWN flag
Message-ID: <20200630054405.6115-1-pravinraghul@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


We assign the memory region allocated using MAP_GROWSDOWN to a thread,
as a stack, to test the effect of MAP_GROWSDOWN. This is because the
kernel only grows the memory region when the stack pointer, is within
guard page, when the guard page is touched.

  1. Map an anyonymous memory region of size X, and unmap it.
  2. Split the unmapped memory region into two.
  3. The lower memory region is left unmapped.
  4. The higher memory region is mapped for use as stack, using MAP_FIXED | MAP_GROWSDOWN.
  5. The higher memory region is provided as stack to a thread, where
     a recursive function is invoked.
  6. The stack grows beyond the allocated region, into the lower memory area.
  7. If this results in the memory region being extended, into the
     unmapped region, the test is considered to have passed.

Resolves #300
Signed-off-by: Pravin Raghul S. <pravinraghul@zilogic.com>
Reviewed-by: Vijay Kumar B. <vijaykumar@zilogic.com>

---
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/mmap/.gitignore |   1 +
 testcases/kernel/syscalls/mmap/Makefile   |   7 ++
 testcases/kernel/syscalls/mmap/mmap18.c   | 146 ++++++++++++++++++++++
 4 files changed, 155 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mmap/mmap18.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b4d523319..d8c9dbe92 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -747,6 +747,7 @@ mmap14 mmap14
 mmap15 mmap15
 mmap16 mmap16
 mmap17 mmap17
+mmap18 mmap18
 
 modify_ldt01 modify_ldt01
 modify_ldt02 modify_ldt02
diff --git a/testcases/kernel/syscalls/mmap/.gitignore b/testcases/kernel/syscalls/mmap/.gitignore
index c5c083d4b..4fd90ab5f 100644
--- a/testcases/kernel/syscalls/mmap/.gitignore
+++ b/testcases/kernel/syscalls/mmap/.gitignore
@@ -16,3 +16,4 @@
 /mmap15
 /mmap16
 /mmap17
+/mmap18
diff --git a/testcases/kernel/syscalls/mmap/Makefile b/testcases/kernel/syscalls/mmap/Makefile
index 743ca36e7..bdc49e4be 100644
--- a/testcases/kernel/syscalls/mmap/Makefile
+++ b/testcases/kernel/syscalls/mmap/Makefile
@@ -8,3 +8,10 @@ include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
 LDLIBS 			+= -lpthread
+#
+# We use recursive calls to to grow the stack, to test the
+# MAP_GROSWDOWN flag. But tail call optimization by the compiler
+# can prevent the recusive call and stack growth. Disable tail
+# call optmization using -fno-optimize-sibling-calls
+#
+mmap18: CFLAGS          += -fno-optimize-sibling-calls
diff --git a/testcases/kernel/syscalls/mmap/mmap18.c b/testcases/kernel/syscalls/mmap/mmap18.c
new file mode 100644
index 000000000..01a456bfc
--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/mmap18.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2020
+ * Email: code@zilogic.com
+ */
+
+/*
+ * Test mmap() MAP_GROWSDOWN flag
+ *
+ * We assign the memory region allocated using MAP_GROWSDOWN to a thread,
+ * as a stack, to test the effect of MAP_GROWSDOWN. This is because the
+ * kernel only grows the memory region when the stack pointer, is within
+ * guard page, when the guard page is touched.
+ *
+ * 1. Map an anyonymous memory region of size X, and unmap it.
+ * 2. Split the unmapped memory region into two.
+ * 3. The lower memory region is left unmapped.
+ * 4. The higher memory region is mapped for use as stack, using 
+ *    MAP_FIXED | MAP_GROWSDOWN.
+ * 5. The higher memory region is provided as stack to a thread, where
+ *    a recursive function is invoked.
+ * 6. The stack grows beyond the allocated region, into the lower memory area.
+ * 7. If this results in the memory region being extended, into the
+ *    unmapped region, the test is considered to have passed.
+ */
+
+#include <unistd.h>
+#include <sys/wait.h>
+#include <pthread.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+
+#define UNITS(x) ((x) * PTHREAD_STACK_MIN)
+
+static void *stack = NULL;
+
+bool check_stackgrow_up(int *local_var_1)
+{
+	int local_var_2;
+
+	if (local_var_1 < &local_var_2)
+		return false;
+	else
+		return true;
+}
+
+void setup(void)
+{
+	int local_var_1;
+	bool stackgrow_up;
+
+	stackgrow_up = check_stackgrow_up(&local_var_1);
+	if (stackgrow_up)
+		tst_brk(TCONF, "Test can't be performed with stack grows up architecture");
+}
+
+void cleanup(void)
+{
+	if (stack != NULL)
+		SAFE_MUNMAP(stack, UNITS(8));
+}
+
+void *find_free_range(size_t size)
+{
+	void *mem;
+
+	mem = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	SAFE_MUNMAP(mem, size);
+
+	return mem;
+}
+
+void split_unmapped_plus_stack(void *start, size_t size, void **stack)
+{
+	/*
+         * +---------------------+----------------------+
+         * + unmapped            | stack                |
+         * +---------------------+----------------------+
+         */
+	*stack = SAFE_MMAP(start, size, PROT_READ | PROT_WRITE,
+			   MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS | MAP_GROWSDOWN,
+			   -1, 0);
+}
+
+static void *check_depth_recursive(void *limit)
+{
+	if ((off_t) &limit < (off_t) limit)
+		return NULL;
+
+	return check_depth_recursive(limit);
+}
+
+void grow_stack(void *stack, size_t size, void *limit)
+{
+	pthread_t test_thread;
+	pthread_attr_t attr;
+	int ret;
+
+	ret = pthread_attr_init(&attr);
+	if (ret != 0)
+		tst_brk(TBROK, "pthread_attr_init failed during setup");
+
+	ret = pthread_attr_setstack(&attr, stack, size);
+	if (ret != 0)
+		tst_brk(TBROK, "pthread_attr_setstack failed during setup");
+
+	SAFE_PTHREAD_CREATE(&test_thread, &attr, check_depth_recursive, limit);
+	SAFE_PTHREAD_JOIN(test_thread, NULL);
+
+	exit(0);
+}
+
+static void run_test(void)
+{
+	void *mem;
+	pid_t child_pid;
+	int wstatus;
+
+	mem = find_free_range(UNITS(16));
+	split_unmapped_plus_stack(mem, UNITS(16), &stack);
+
+	child_pid = SAFE_FORK();
+	if (child_pid == 0) {
+		grow_stack(stack, UNITS(8), mem + UNITS(1));
+	} else {
+		SAFE_WAIT(&wstatus);
+		if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) == 0)
+			tst_res(TPASS, "stack grows in unmapped region");
+		else
+			tst_res(TFAIL, "child exited with %d", wstatus);
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.forks_child = 1,
+};
-- 
2.25.1

