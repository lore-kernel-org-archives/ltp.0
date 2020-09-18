From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 18 Sep 2020 19:17:10 +0200
Subject: [LTP] [PATCH v6] Add a test case for mmap MAP_GROWSDOWN flag
Message-ID: <20200918171710.19227-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: pravin <pravinraghul@zilogic.com>

This test implements two cases.

First one uses MAP_GROWSDOWN mapping as a thread stack and expects that
the thread will grow the stack successfully.

The second one will have a 'break' page allocated into the space the
mapping is supposed to grow and expects that the thread will be killed
with SIGSEGV.

Resolves #300
Signed-off-by: Pravin Raghul S. <pravinraghul@zilogic.com>
Reviewed-by: Vijay Kumar B. <vijaykumar@zilogic.com>
Signed-off-by: Li Wang <liwang@redhat.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/mmap/.gitignore |   1 +
 testcases/kernel/syscalls/mmap/mmap18.c   | 215 ++++++++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mmap/mmap18.c

diff --git a/runtest/syscalls b/runtest/syscalls
index ef1a1ba0b..a165ffed5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -750,6 +750,7 @@ mmap14 mmap14
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
diff --git a/testcases/kernel/syscalls/mmap/mmap18.c b/testcases/kernel/syscalls/mmap/mmap18.c
new file mode 100644
index 000000000..966bf673e
--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/mmap18.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2020
+ * Email: code@zilogic.com
+ */
+
+/*
+ * Test mmap() MAP_GROWSDOWN flag
+ *
+ * # Test1:
+ *
+ *   We assign the memory region partially allocated with MAP_GROWSDOWN flag to
+ *   a thread as a stack and expect the mapping to grow when we touch the
+ *   guard page by calling a recusive function in the thread that uses the
+ *   growable mapping as a stack.
+ *
+ *   The kernel only grows the memory region when the stack pointer is within
+ *   guard page when the guard page is touched so simply faulting the guard
+ *   page will not cause the mapping to grow.
+ *
+ *   Newer kernels does not allow a MAP_GROWSDOWN mapping to grow closer than
+ *   'stack_guard_gap' pages to an existing mapping. So when we map the stack we
+ *   make sure there is enough of free address space before the lowest stack
+ *   address.
+ *
+ *   Kernel default 'stack_guard_gap' size is '256 * getpagesize()'.
+ *
+ *   The stack memory map would look like:
+ *
+ *   |  -  -  -   reserved  size   -  -  -  |
+ *
+ *   +-- - - - --+------------+-------------+
+ *   | 256 pages |  unmapped  |   mapped    |
+ *   +-- - - - --+------------+-------------+
+ *                            | mapped size |
+ *   ^           |  -  -  stack size  -  -  |
+ *   start
+ *               ^                          ^
+ *               stack bottom       stack top
+ *
+ * # Test2:
+ *
+ *   We allocate stack as we do in the first test but we mmap a page in the
+ *   space the stack is supposed to grow into and we expect the thread to
+ *   segfault when the guard page is faulted.
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
+static long page_size;
+
+static bool __attribute__((noinline)) check_stackgrow_up(void)
+{
+	char local_var;
+	static char *addr;
+
+       if (!addr) {
+               addr = &local_var;
+               return check_stackgrow_up();
+       }
+
+       return (addr < &local_var);
+}
+
+static void setup(void)
+{
+	if (check_stackgrow_up())
+		tst_brk(TCONF, "Test can't be performed with stack grows up architecture");
+
+	page_size = getpagesize();
+}
+
+/*
+ * Returns stack lowest address. Note that the address is not mapped and will
+ * be mapped on page fault when we grow the stack to the lowest address possible.
+ */
+static void *allocate_stack(size_t stack_size, size_t mapped_size)
+{
+	void *start, *stack_top, *stack_bottom;
+
+	long reserved_size = 256 * page_size + stack_size;
+
+	start = SAFE_MMAP(NULL, reserved_size, PROT_READ | PROT_WRITE,
+	                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	SAFE_MUNMAP(start, reserved_size);
+
+	SAFE_MMAP((start + reserved_size - mapped_size), mapped_size, PROT_READ | PROT_WRITE,
+		  MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS | MAP_GROWSDOWN,
+		  -1, 0);
+
+	stack_top = start + reserved_size;
+	stack_bottom = start + reserved_size - stack_size;
+
+	tst_res(TINFO, "start = %p, stack_top = %p, stack bottom = %p",
+		start, stack_top, stack_bottom);
+	tst_res(TINFO, "mapped pages %zu, stack pages %zu",
+	        mapped_size/page_size, stack_size/page_size);
+
+	return stack_bottom;
+}
+
+static __attribute__((noinline)) void *check_depth_recursive(void *limit)
+{
+	if ((off_t) &limit < (off_t) limit) {
+		tst_res(TINFO, "&limit = %p, limit = %p", &limit, limit);
+		return NULL;
+	}
+
+	return check_depth_recursive(limit);
+}
+
+/*
+ * We set the limit one page above the stack bottom to make sure that the stack
+ * frame will not overflow to the next page, which would potentially cause
+ * segfault if we are unlucky and there is a mapping right after the guard gap.
+ *
+ * Generally the stack frame would be much smaller than page_size so moving the
+ * pointer by a few bytes would probably be enough, but we do not want to take
+ * any chances.
+ */
+static void grow_stack(void *stack, size_t size)
+{
+	pthread_t test_thread;
+	pthread_attr_t attr;
+	int ret;
+	void *limit = stack + page_size;
+
+	ret = pthread_attr_init(&attr);
+	if (ret)
+		tst_brk(TBROK, "pthread_attr_init failed during setup");
+
+	ret = pthread_attr_setstack(&attr, stack, size);
+	if (ret)
+		tst_brk(TBROK, "pthread_attr_setstack failed during setup");
+
+	SAFE_PTHREAD_CREATE(&test_thread, &attr, check_depth_recursive, limit);
+	SAFE_PTHREAD_JOIN(test_thread, NULL);
+
+	exit(0);
+}
+
+static void grow_stack_success(size_t stack_size, size_t mapped_size)
+{
+	pid_t child_pid;
+	int wstatus;
+	void *stack;
+
+	child_pid = SAFE_FORK();
+	if (!child_pid) {
+		stack = allocate_stack(stack_size, mapped_size);
+		grow_stack(stack, stack_size);
+	}
+
+	SAFE_WAIT(&wstatus);
+	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) == 0)
+		tst_res(TPASS, "Stack grows in unmapped region");
+	else
+		tst_res(TFAIL, "Child: %s", tst_strstatus(wstatus));
+
+}
+
+/*
+ * We map a page at the bottom of the stack which will cause the thread to be
+ * killed with SIGSEGV on faulting the guard page.
+ */
+static void grow_stack_fail(size_t stack_size, size_t mapped_size)
+{
+	pid_t child_pid;
+	int wstatus;
+	void *stack;
+
+	child_pid = SAFE_FORK();
+	if (!child_pid) {
+		tst_no_corefile(0);
+		stack = allocate_stack(stack_size, mapped_size);
+
+		SAFE_MMAP(stack, page_size, PROT_READ | PROT_WRITE,
+			  MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+		tst_res(TINFO, "mapped page@%p", stack);
+
+		grow_stack(stack, stack_size);
+	}
+
+	SAFE_WAIT(&wstatus);
+        if (WIFSIGNALED(wstatus) && WTERMSIG(wstatus) == SIGSEGV)
+		tst_res(TPASS, "Child killed by %s as expected", tst_strsig(SIGSEGV));
+        else
+                tst_res(TFAIL, "Child: %s", tst_strstatus(wstatus));
+}
+
+static void run_test(void)
+{
+	size_t stack_size = 8 * PTHREAD_STACK_MIN;
+
+	grow_stack_success(stack_size, page_size);
+	grow_stack_success(stack_size, stack_size/2);
+	grow_stack_fail(stack_size, page_size);
+	grow_stack_fail(stack_size, stack_size/2);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run_test,
+	.forks_child = 1,
+};
-- 
2.26.2

