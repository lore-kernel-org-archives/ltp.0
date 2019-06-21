From: Li Wang <liwang@redhat.com>
Date: Fri, 21 Jun 2019 18:26:27 +0800
Subject: [LTP] [PATCH v2 2/3] pkey: add test for memory protection keys
Message-ID: <20190621102628.4800-3-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Memory Protection Keys for Userspace (PKU aka PKEYs) is a Skylake-SP
server feature that provides a mechanism for enforcing page-based
protections, but without requiring modification of the page tables
when an application changes protection domains. It works by dedicating
4 previously ignored bits in each page table entry to a "protection key",
giving 16 possible keys.

Test for Memory Protection Keys:
1. test allocates a pkey(e.g. PKEY_DISABLE_ACCESS) via pkey_alloc()
2. pkey_mprotect() apply this pkey to a piece of shared memory(buffer)
3. check if the access right of buffer has been changed and take effect
4. remove the access right(pkey) from this buffer via pkey_mprotect()
5. check if buffer area can be read or write after removing pkey
6. pkey_free() releases the pkey after using it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 configure.ac                               |   1 +
 runtest/syscalls                           |   2 +
 testcases/kernel/syscalls/pkeys/.gitignore |   1 +
 testcases/kernel/syscalls/pkeys/Makefile   |   8 ++
 testcases/kernel/syscalls/pkeys/pkey.h     |  50 ++++++++
 testcases/kernel/syscalls/pkeys/pkey01.c   | 126 +++++++++++++++++++++
 6 files changed, 188 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pkeys/.gitignore
 create mode 100644 testcases/kernel/syscalls/pkeys/Makefile
 create mode 100644 testcases/kernel/syscalls/pkeys/pkey.h
 create mode 100644 testcases/kernel/syscalls/pkeys/pkey01.c

diff --git a/configure.ac b/configure.ac
index 65fc2a232..5a9b74b0a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -74,6 +74,7 @@ AC_CHECK_FUNCS([ \
     pidfd_send_signal \
     preadv \
     preadv2 \
+    pkey_mprotect \
     profil \
     pwritev \
     pwritev2 \
diff --git a/runtest/syscalls b/runtest/syscalls
index c6a064481..6ea991f12 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -721,6 +721,8 @@ mprotect02 mprotect02
 mprotect03 mprotect03
 mprotect04 mprotect04
 
+pkey01 pkey01
+
 mq_notify01 mq_notify01
 mq_notify02 mq_notify02
 mq_open01 mq_open01
diff --git a/testcases/kernel/syscalls/pkeys/.gitignore b/testcases/kernel/syscalls/pkeys/.gitignore
new file mode 100644
index 000000000..6fd5addb8
--- /dev/null
+++ b/testcases/kernel/syscalls/pkeys/.gitignore
@@ -0,0 +1 @@
+/pkey01
diff --git a/testcases/kernel/syscalls/pkeys/Makefile b/testcases/kernel/syscalls/pkeys/Makefile
new file mode 100644
index 000000000..9ee2c2ea5
--- /dev/null
+++ b/testcases/kernel/syscalls/pkeys/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Red Hat, Inc.
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/pkeys/pkey.h b/testcases/kernel/syscalls/pkeys/pkey.h
new file mode 100644
index 000000000..ccbb5ff3c
--- /dev/null
+++ b/testcases/kernel/syscalls/pkeys/pkey.h
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Red Hat, Inc.
+ */
+
+#ifndef PKEYS_H
+#define PKEYS_H
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+#ifndef PKEY_DISABLE_ACCESS
+# define PKEY_DISABLE_ACCESS 0x1
+# define PKEY_DISABLE_WRITE  0x2
+#endif
+
+#ifndef HAVE_PKEY_MPROTECT
+static inline int pkey_mprotect(void *addr, size_t len, int prot, int pkey)
+{
+	return tst_syscall(SYS_pkey_mprotect, addr, len, prot, pkey);
+}
+
+static inline int pkey_alloc(unsigned int flags, unsigned int access_rights)
+{
+	return tst_syscall(SYS_pkey_alloc, flags, access_rights);
+}
+
+static inline int pkey_free(int pkey)
+{
+	return tst_syscall(SYS_pkey_free, pkey);
+}
+#endif /* HAVE_PKEY_MPROTECT */
+
+static inline void check_pkey_support(void)
+{
+	int pkey = pkey_alloc(0, 0);
+
+	if (pkey == -1) {
+		if (errno == ENOSYS)
+			tst_brk(TCONF, "pkey_alloc is not implemented");
+		if (errno == EINVAL)
+			tst_brk(TCONF, "pku is not supported on this CPU");
+		if (errno == ENOSPC)
+			tst_brk(TCONF, "pkeys are not available for test");
+	}
+
+	pkey_free(pkey);
+}
+
+#endif /* PKEYS_H */
diff --git a/testcases/kernel/syscalls/pkeys/pkey01.c b/testcases/kernel/syscalls/pkeys/pkey01.c
new file mode 100644
index 000000000..dfcf92a6b
--- /dev/null
+++ b/testcases/kernel/syscalls/pkeys/pkey01.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Red Hat, Inc.
+ *
+ * Memory Protection Keys for Userspace (PKU aka PKEYs) is a Skylake-SP
+ * server feature that provides a mechanism for enforcing page-based
+ * protections, but without requiring modification of the page tables
+ * when an application changes protection domains. It works by dedicating
+ * 4 previously ignored bits in each page table entry to a "protection key",
+ * giving 16 possible keys.
+ *
+ * Test for Memory Protection Keys:
+ *    1. test allocates a pkey(e.g. PKEY_DISABLE_ACCESS) via pkey_alloc()
+ *    2. pkey_mprotect() apply this pkey to a piece of shared memory(buffer)
+ *    3. check if access right of the buffer has been changed and take effect
+ *    4. remove the access right(pkey) from this buffer via pkey_mprotect()
+ *    5. check if buffer area can be read or write after removing pkey
+ *    6. pkey_free() releases the pkey after using it
+ *
+ * Reference: https://lwn.net/Articles/689395/
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <sys/syscall.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+
+#include "pkey.h"
+
+static int psize;
+static char *buffer;
+
+static struct tcase {
+	unsigned long flags;
+	unsigned long access_rights;
+	char *name;
+} tcases[] = {
+	{0, PKEY_DISABLE_ACCESS, "PKEY_DISABLE_ACCESS"},
+	{0, PKEY_DISABLE_WRITE, "PKEY_DISABLE_WRITE"},
+};
+
+static void setup(void)
+{
+	check_pkey_support();
+
+	psize = getpagesize();
+	buffer = SAFE_MMAP(NULL, psize, PROT_READ | PROT_WRITE,
+			MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+	memset(buffer, 'a', psize);
+}
+
+static void verify_pkey(unsigned int i)
+{
+	int pkey, status;
+	pid_t pid;
+
+	struct tcase *tc = &tcases[i];
+
+	pkey = pkey_alloc(tc->flags, tc->access_rights);
+	if (pkey == -1)
+		tst_brk(TBROK, "pkey_alloc failed");
+
+	tst_res(TINFO, "Set %s on buffer", tc->name);
+	if (pkey_mprotect(buffer, psize, PROT_READ | PROT_WRITE, pkey) == -1)
+		tst_brk(TBROK, "pkey_mprotect failed");
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		/* Children crash are expected, avoid dumping corefile */
+		struct rlimit r;
+
+		r.rlim_cur = 1;
+		r.rlim_max = 1;
+		SAFE_SETRLIMIT(RLIMIT_CORE, &r);
+
+		switch (tc->access_rights) {
+		case PKEY_DISABLE_ACCESS:
+			tst_res(TFAIL, "Read buffer success, buffer[0] = %d", *buffer);
+		break;
+		case PKEY_DISABLE_WRITE:
+			*buffer = 'b';
+		break;
+		}
+		exit(0);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+	if (WIFSIGNALED(status)) {
+		if (WTERMSIG(status) == SIGSEGV) {
+			tst_res(TPASS, "Child ended by %s as expected",
+				tst_strsig(SIGSEGV));
+		} else {
+			tst_res(TFAIL, "Child ended by %s unexpected" ,
+				tst_strsig(WTERMSIG(status)));
+		}
+	} else {
+		tst_res(TFAIL, "Child unexpectedly ended");
+	}
+
+	tst_res(TINFO, "Remove %s from buffer", tc->name);
+	if (pkey_mprotect(buffer, psize, PROT_READ | PROT_WRITE, 0x0) == -1)
+		tst_brk(TBROK, "pkey_mprotect failed");
+	*buffer = i;
+	tst_res(TPASS, "Write buffer success, buffer[0] = %d", *buffer);
+
+	if (pkey_free(pkey) == -1)
+		tst_brk(TBROK, "pkey_free failed");
+}
+
+static void cleanup(void)
+{
+	if (buffer)
+		SAFE_MUNMAP(buffer, psize);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.forks_child = 1,
+	.test = verify_pkey,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.20.1

