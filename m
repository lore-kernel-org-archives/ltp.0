From: pravin <pravinraghul@zilogic.com>
Date: Thu, 06 Aug 2020 05:49:29 -0000
Subject: [LTP] [PATCH v3] Add a test case for mmap MAP_GROWSDOWN flag
Message-ID: <20200806054929.13289-1-pravinraghul@zilogic.com>
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
Issue with s390x architecture:
 Writing on the unmapped pages results in page fault.

Changes from v2
1) Fixed check_stackgrows_up() function

Changes from v1
1) Fixed checkpatch and static missing error
2) Removed stack grows in mapped region testcase

 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/mmap/.gitignore |   1 +
 testcases/kernel/syscalls/mmap/Makefile   |   7 ++
 testcases/kernel/syscalls/mmap/mmap18.c   | 145 ++++++++++++++++++++++
 4 files changed, 154 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mmap/mmap18.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 70b3277d3..0e29babb3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -746,6 +746,7 @@ mmap14 mmap14
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
index 743ca36e7..2b6b2be1d 100644
--- a/testcases/kernel/syscalls/mmap/Makefile
+++ b/testcases/kernel/syscalls/mmap/Makefile
@@ -8,3 +8,10 @@ include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
 LDLIBS 			+= -lpthread
+#
+# We use recursive calls to grow the stack, to test the
+# MAP_GROSWDOWN flag. But tail call optimization by the compiler
+# can prevent the recursive call and stack growth. Disable tail
+# call optmization using -fno-optimize-sibling-calls
+#
+mmap18: CFLAGS          += -fno-optimize-sibling-calls
diff --git a/testcases/kernel/syscalls/mmap/mmap18.c b/testcases/kernel/syscalls/mmap/mmap18.c
new file mode 100644
index 000000000..86f2ab5ab
--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/mmap18.c
@@ -0,1 +1,151 @@
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
+#include <pthread.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <sys/types.h>
+#include <stdlib.h>
+#include <stdbool.h>
+
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+
+/*
+ * PTHREAD_STACK_SIZE is the minimum stack size required for setting the stack
+ * for a thread, using pthread_attr_setstack(). Allocating less than
+ * PTHREAD_STACK_SIZE will cause EINVAL error. Hence we allocate in
+ * multiples of PTHREAD_STACK_SIZE rather than multiples of page size.
+ */
+#define UNITS(x) ((x) * PTHREAD_STACK_MIN)
+
+static void *stack;
+
+static bool check_stackgrow_up(void)
+{
+	char local_var;
+	static char *addr;
+
+	if (!addr) {
+		addr = &local_var;
+		return check_stackgrow_up();
+	}
+
+	return (addr < &local_var);
+}
+
+static void setup(void)
+{
+	if (check_stackgrow_up())
+		tst_brk(TCONF, "Test can't be performed with stack grows up architecture");
+}
+
+static void cleanup(void)
+{
+	if (stack)
+		SAFE_MUNMAP(stack, UNITS(8));
+}
+
+static void *find_free_range(size_t size)
+{
+	void *mem;
+
+	mem = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	SAFE_MUNMAP(mem, size);
+
+	return mem;
+}
+
+static void split_unmapped_plus_stack(void *start, size_t size)
+{
+	/* start           start + size
+	 * +---------------------+----------------------+
+	 * + unmapped            | mapped               |
+	 * +---------------------+----------------------+
+	 *                       stack
+	 */
+	stack = SAFE_MMAP(start + size, size, PROT_READ | PROT_WRITE,
+			  MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS | MAP_GROWSDOWN,
+			  -1, 0);
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
+static void grow_stack(void *stack, size_t size, void *limit)
+{
+	pthread_t test_thread;
+	pthread_attr_t attr;
+	int ret;
+
+	ret = pthread_attr_init(&attr);
+	if (ret)
+		tst_brk(TBROK, "pthread_attr_init failed during setup");
+
+	ret = pthread_attr_setstack(&attr, stack, size);
+	if (ret)
+		tst_brk(TBROK, "pthread_attr_setstack failed during setup");
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
+	split_unmapped_plus_stack(mem, UNITS(8));
+
+	child_pid = SAFE_FORK();
+	if (!child_pid)
+		grow_stack(stack, UNITS(8), mem + UNITS(1));
+
+	SAFE_WAIT(&wstatus);
+	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) == 0)
+		tst_res(TPASS, "Stack grows in unmapped region");
+	else if (WIFSIGNALED(wstatus))
+		tst_res(TFAIL, "Child killed by %s", tst_strsig(WTERMSIG(wstatus)));
+	else
+		tst_res(TFAIL, "Child %s", tst_strstatus(wstatus));
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

