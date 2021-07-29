From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 29 Jul 2021 08:13:48 +0100
Subject: [LTP] [PATCH v2] Add set_mempolicy05, CVE-2017-7616
In-Reply-To: <YQALVdEAGOVa+g4H@yuki>
References: <YQALVdEAGOVa+g4H@yuki>
Message-ID: <20210729071348.8911-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

V2:
* Explicitly include libs for tests except 05

 runtest/cve                                   |   1 +
 runtest/numa                                  |   1 +
 .../kernel/syscalls/set_mempolicy/.gitignore  |   1 +
 .../kernel/syscalls/set_mempolicy/Makefile    |   6 +-
 .../syscalls/set_mempolicy/set_mempolicy05.c  | 128 ++++++++++++++++++
 5 files changed, 135 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c

diff --git a/runtest/cve b/runtest/cve
index 226b5ea44..96cc98f20 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -22,6 +22,7 @@ cve-2017-2671 cve-2017-2671
 cve-2017-6951 request_key05
 cve-2017-7308 setsockopt02
 cve-2017-7472 keyctl04
+cve-2017-7616 set_mempolicy05
 cve-2017-10661 timerfd_settime02
 cve-2017-12192 keyctl07
 cve-2017-12193 add_key04
diff --git a/runtest/numa b/runtest/numa
index 7b9c2ae9d..3b9a9a7c5 100644
--- a/runtest/numa
+++ b/runtest/numa
@@ -20,3 +20,4 @@ set_mempolicy01 set_mempolicy01
 set_mempolicy02 set_mempolicy02
 set_mempolicy03 set_mempolicy03
 set_mempolicy04 set_mempolicy04
+set_mempolicy05 set_mempolicy05
diff --git a/testcases/kernel/syscalls/set_mempolicy/.gitignore b/testcases/kernel/syscalls/set_mempolicy/.gitignore
index 52ae73b52..4c121d2e0 100644
--- a/testcases/kernel/syscalls/set_mempolicy/.gitignore
+++ b/testcases/kernel/syscalls/set_mempolicy/.gitignore
@@ -2,3 +2,4 @@
 /set_mempolicy02
 /set_mempolicy03
 /set_mempolicy04
+/set_mempolicy05
diff --git a/testcases/kernel/syscalls/set_mempolicy/Makefile b/testcases/kernel/syscalls/set_mempolicy/Makefile
index e6e699808..100780dc3 100644
--- a/testcases/kernel/syscalls/set_mempolicy/Makefile
+++ b/testcases/kernel/syscalls/set_mempolicy/Makefile
@@ -5,7 +5,9 @@ LTPLIBS = ltpnuma
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDLIBS  += $(NUMA_LIBS)
-LTPLDLIBS = -lltpnuma
+NEEDS_LIBS = set_mempolicy01 set_mempolicy02 set_mempolicy03 set_mempolicy04
+
+$(NEEDS_LIBS): LDLIBS  += $(NUMA_LIBS)
+$(NEEDS_LIBS): LTPLDLIBS = -lltpnuma
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
new file mode 100644
index 000000000..86f6a95dc
--- /dev/null
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 SUSE LLC <rpalethorpe@suse.com>
+ */
+/*\
+ *
+ * [Description]
+ *
+ * This will reproduce an information leak in the set_mempolicy 32-bit
+ * compat syscall. The catch is that the 32-bit compat syscall is not
+ * used in x86_64 upstream. So at the time of writing, 32-bit programs
+ * on large x86_64 numa systems will be broken if they use
+ * set_mempolicy. OTOH they could not have been exploited either.
+ *
+ * On other architectures the compat syscall is connected. Including
+ * PowerPC which has also been included as well. It is possible some
+ * vendors connected the x86_64 compat call in their kernel branch.
+ *
+ * The kernel allocates memory from the user's stack as a temporary
+ * work area. Allowing it to copy the node array of 32-bit fields to
+ * 64-bit fields. It uses user memory so that it can share the
+ * non-compatability syscall functions which use copy_from_user()
+ * internally.
+ *
+ * Originally the compat call would copy a chunk of the
+ * uninitialized kernel stack to the user stack before checking the
+ * validation result. This meant when the user passed in an invalid
+ * node_mask_ptr. They would get kernel stack data somewhere below
+ * their stack pointer.
+ *
+ * So we allocate and set an array on the stack (larger than any
+ * redzone). Then move the stack pointer to the beginning of the
+ * array. Then move it back after the syscall. We can then check to
+ * see if the array has been modified.
+ */
+
+#include "config.h"
+#include "tst_test.h"
+
+#if defined(__i386__) || defined(__powerpc__)
+
+#include <string.h>
+
+static unsigned int i;
+static int sys_ret;
+#ifdef __i386__
+static const int sys_num = 276;
+static const int mode;
+static const int node_mask_ptr = UINT_MAX;
+static const int node_mask_sz = UINT_MAX;
+#endif
+static volatile char *stack_ptr;
+
+static void run(void)
+{
+#ifdef __powerpc__
+	register long sys_num __asm__("r0");
+	register long mode __asm__("r3");
+	register long node_mask_ptr __asm__("r4");
+	register long node_mask_sz __asm__("r5");
+#endif
+	char stack_pattern[0x400];
+
+	stack_ptr = stack_pattern;
+	memset(stack_pattern, 0xA5, sizeof(stack_pattern));
+	tst_res(TINFO, "stack pattern is in %p-%p", stack_ptr, stack_ptr + 0x400);
+
+#ifdef __powerpc__
+	sys_num = 261;
+	mode = 0;
+	node_mask_ptr = ~0UL;
+	node_mask_sz = ~0UL;
+	asm volatile (
+		"addi 1,1,1024\n\t"
+		"sc\n\t"
+		"addi 1,1,-1024\n\t" :
+		"+r"(sys_num), "+r"(mode), "+r"(node_mask_ptr), "+r"(node_mask_sz) :
+		:
+		"memory", "cr0", "r6", "r7", "r8", "r9", "r10", "r11", "r12");
+	sys_ret = mode;
+#else /* __i386__ */
+	asm volatile (
+		"add $0x400, %%esp\n\t"
+		"int $0x80\n\t"
+		"sub $0x400, %%esp\n\t" :
+		"=a"(sys_ret) :
+		"a"(sys_num), "b"(mode), "c"(node_mask_ptr), "d"(node_mask_sz) :
+		"memory");
+	sys_ret = -sys_ret;
+#endif
+
+	for (i = 0; i < sizeof(stack_pattern); i++) {
+		if (stack_ptr[i] != (char)0xA5) {
+			tst_brk(TFAIL,
+				"User stack was overwritten with something@%d", i);
+		}
+	}
+
+	switch (sys_ret) {
+	case EFAULT:
+		tst_res(TPASS,
+			"set_mempolicy returned EFAULT (compat assumed)");
+		break;
+	case EINVAL:
+		tst_res(TCONF,
+			"set_mempolicy returned EINVAL (non compat assumed)");
+		break;
+	default:
+		tst_res(TFAIL,
+			"set_mempolicy should fail with EFAULT or EINVAL, instead returned %ld",
+			(long)sys_ret);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "cf01fb9985e8"},
+		{"CVE", "CVE-2017-7616"},
+		{}
+	}
+};
+
+#else /* #if defined(__x86_64__) || defined(__powerpc__) */
+
+TST_TEST_TCONF("not i386 or powerpc");
+
+#endif /* #else #if defined(__x86_64__) || defined(__powerpc__) */
-- 
2.31.1

