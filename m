From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 21 May 2020 16:17:35 +0530
Subject: [LTP] [PATCH 4/5] syscalls: shmctl: Add new test to verify the
 _time_high fields
In-Reply-To: <cover.1590057824.git.viresh.kumar@linaro.org>
References: <cover.1590057824.git.viresh.kumar@linaro.org>
Message-ID: <55a85e8ef90f9f45ffa5ef77e922eb9b510cf24e.1590057824.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The _time_high fields must be reset by the kernel, add a test to verify
that.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 configure.ac                                  |   1 +
 include/shmbuf.h                              | 273 ++++++++++++++++++
 runtest/syscalls                              |   1 +
 runtest/syscalls-ipc                          |   1 +
 .../kernel/syscalls/ipc/shmctl/.gitignore     |   1 +
 testcases/kernel/syscalls/ipc/shmctl/Makefile |   7 +-
 .../kernel/syscalls/ipc/shmctl/shmctl06.c     |  51 ++++
 7 files changed, 333 insertions(+), 2 deletions(-)
 create mode 100644 include/shmbuf.h
 create mode 100644 testcases/kernel/syscalls/ipc/shmctl/shmctl06.c

diff --git a/configure.ac b/configure.ac
index c513fdf440c2..f1ee98b23cbe 100644
--- a/configure.ac
+++ b/configure.ac
@@ -152,6 +152,7 @@ AC_CHECK_TYPES([struct if_nextdqblk],,,[#include <linux/quota.h>])
 AC_CHECK_TYPES([struct iovec],,,[#include <sys/uio.h>])
 AC_CHECK_TYPES([struct ipc64_perm],,,[#include <sys/ipcbuf.h>])
 AC_CHECK_TYPES([struct semid64_ds],,,[#include <sys/sem.h>])
+AC_CHECK_TYPES([struct shmid64_ds],,,[#include <sys/shmbuf.h>])
 
 AC_CHECK_TYPES([struct mmsghdr],,,[
 #define _GNU_SOURCE
diff --git a/include/shmbuf.h b/include/shmbuf.h
new file mode 100644
index 000000000000..f8c1294c60d6
--- /dev/null
+++ b/include/shmbuf.h
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Linaro Limited. All rights reserved.
+ * Author: Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#ifndef IPC_SHMBUF_H
+#define IPC_SHMBUF_H
+
+#include <linux/posix_types.h>
+#include <sys/sem.h>
+#include "tst_timer.h"
+#include "ipcbuf.h"
+
+#ifndef HAVE_SHMID64_DS
+
+#if defined(__mips__)
+#define HAVE_SHMID64_DS
+/*
+ * The shmid64_ds structure for the MIPS architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * As MIPS was lacking proper padding after shm_?time, we use 48 bits
+ * of the padding at the end to store a few additional bits of the time.
+ * libc implementations need to take care to convert this into a proper
+ * data structure when moving to 64-bit time_t.
+ */
+
+#if defined(__arch64__)
+struct shmid64_ds {
+	struct ipc64_perm	shm_perm;	/* operation perms */
+	size_t			shm_segsz;	/* size of segment (bytes) */
+	long			shm_atime;	/* last attach time */
+	long			shm_dtime;	/* last detach time */
+	long			shm_ctime;	/* last change time */
+	__kernel_pid_t		shm_cpid;	/* pid of creator */
+	__kernel_pid_t		shm_lpid;	/* pid of last operator */
+	unsigned long		shm_nattch;	/* no. of current attaches */
+	unsigned long		__unused1;
+	unsigned long		__unused2;
+};
+#else
+#define HAVE_SHMID64_DS_TIME_HIGH
+struct shmid64_ds {
+	struct ipc64_perm	shm_perm;	/* operation perms */
+	size_t			shm_segsz;	/* size of segment (bytes) */
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_ctime;	/* last change time */
+	__kernel_pid_t		shm_cpid;	/* pid of creator */
+	__kernel_pid_t		shm_lpid;	/* pid of last operator */
+	unsigned long		shm_nattch;	/* no. of current attaches */
+	unsigned short		shm_atime_high;
+	unsigned short		shm_dtime_high;
+	unsigned short		shm_ctime_high;
+	unsigned short		__unused1;
+};
+#endif
+
+#endif /* __mips__ */
+
+#if defined(__hppa__)
+#define HAVE_SHMID64_DS
+/*
+ * The shmid64_ds structure for parisc architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct shmid64_ds {
+	struct ipc64_perm	shm_perm;	/* operation perms */
+#if __BITS_PER_LONG == 64
+	long			shm_atime;	/* last attach time */
+	long			shm_dtime;	/* last detach time */
+	long			shm_ctime;	/* last change time */
+#else
+#define HAVE_SHMID64_DS_TIME_HIGH
+	unsigned long		shm_atime_high;
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_ctime_high;
+	unsigned long		shm_ctime;	/* last change time */
+	unsigned int		__pad4;
+#endif
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
+	__kernel_pid_t		shm_cpid;	/* pid of creator */
+	__kernel_pid_t		shm_lpid;	/* pid of last operator */
+	unsigned long		shm_nattch;	/* no. of current attaches */
+	unsigned long		__unused1;
+	unsigned long		__unused2;
+};
+#endif /* __hppa__ */
+
+#if defined(__powerpc__) || defined(__powerpc64__)
+#define HAVE_SHMID64_DS
+/*
+ * The shmid64_ds structure for PPC architecture.
+ *
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct shmid64_ds {
+	struct ipc64_perm	shm_perm;	/* operation perms */
+#ifdef __powerpc64__
+	long		shm_atime;	/* last attach time */
+	long		shm_dtime;	/* last detach time */
+	long		shm_ctime;	/* last change time */
+#else
+#define HAVE_SHMID64_DS_TIME_HIGH
+	unsigned long		shm_atime_high;
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_ctime_high;
+	unsigned long		shm_ctime;	/* last change time */
+	unsigned long		__unused4;
+#endif
+	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_pid_t		shm_cpid;	/* pid of creator */
+	__kernel_pid_t		shm_lpid;	/* pid of last operator */
+	unsigned long		shm_nattch;	/* no. of current attaches */
+	unsigned long		__unused5;
+	unsigned long		__unused6;
+};
+
+#endif /* defined(__powerpc__) || defined(__powerpc64__) */
+
+#if defined(__sparc__)
+#define HAVE_SHMID64_DS
+/*
+ * The shmid64_ds structure for sparc architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct shmid64_ds {
+	struct ipc64_perm	shm_perm;	/* operation perms */
+#if defined(__arch64__)
+	long			shm_atime;	/* last attach time */
+	long			shm_dtime;	/* last detach time */
+	long			shm_ctime;	/* last change time */
+#else
+#define HAVE_SHMID64_DS_TIME_HIGH
+	unsigned long		shm_atime_high;
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_ctime_high;
+	unsigned long		shm_ctime;	/* last change time */
+#endif
+	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_pid_t		shm_cpid;	/* pid of creator */
+	__kernel_pid_t		shm_lpid;	/* pid of last operator */
+	unsigned long		shm_nattch;	/* no. of current attaches */
+	unsigned long		__unused1;
+	unsigned long		__unused2;
+};
+
+#endif /* __sparc__ */
+
+#if defined(__x86_64__) && defined(__ILP32__)
+#define HAVE_SHMID64_DS
+/*
+ * The shmid64_ds structure for x86 architecture with x32 ABI.
+ *
+ * On x86-32 and x86-64 we can just use the generic definition, but
+ * x32 uses the same binary layout as x86_64, which is differnet
+ * from other 32-bit architectures.
+ */
+
+struct shmid64_ds {
+	struct ipc64_perm	shm_perm;	/* operation perms */
+	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_long_t		shm_atime;	/* last attach time */
+	__kernel_long_t		shm_dtime;	/* last detach time */
+	__kernel_long_t		shm_ctime;	/* last change time */
+	__kernel_pid_t		shm_cpid;	/* pid of creator */
+	__kernel_pid_t		shm_lpid;	/* pid of last operator */
+	__kernel_ulong_t	shm_nattch;	/* no. of current attaches */
+	__kernel_ulong_t	__unused4;
+	__kernel_ulong_t	__unused5;
+};
+#endif /* defined(__x86_64__) && defined(__ILP32__) */
+
+#if defined(__xtensa__)
+#define HAVE_SHMID64_DS
+#define HAVE_SHMID64_DS_TIME_HIGH
+/*
+ * The shmid64_ds structure for Xtensa architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space, but the padding is on the wrong
+ * side for big-endian xtensa, for historic reasons.
+ *
+ * Pad space is left for:
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct shmid64_ds {
+	struct ipc64_perm	shm_perm;	/* operation perms */
+	size_t			shm_segsz;	/* size of segment (bytes) */
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_atime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_ctime;	/* last change time */
+	unsigned long		shm_ctime_high;
+	__kernel_pid_t		shm_cpid;	/* pid of creator */
+	__kernel_pid_t		shm_lpid;	/* pid of last operator */
+	unsigned long		shm_nattch;	/* no. of current attaches */
+	unsigned long		__unused4;
+	unsigned long		__unused5;
+};
+
+#endif /* __xtensa__ */
+
+#ifndef HAVE_SHMID64_DS
+/*
+ * The shmid64_ds structure for most architectures (though it came
+ * from x86_32 originally). Note extra padding because this structure
+ * is passed back and forth between kernel and user space.
+ *
+ * shmid64_ds was originally meant to be architecture specific, but
+ * everyone just ended up making identical copies without specific
+ * optimizations, so we may just as well all use the same one.
+ *
+ * 64 bit architectures use a 64-bit long time field here, while
+ * 32 bit architectures have a pair of unsigned long values.
+ * On big-endian systems, the lower half is in the wrong place.
+ *
+ *
+ * Pad space is left for:
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct shmid64_ds {
+	struct ipc64_perm	shm_perm;	/* operation perms */
+	size_t			shm_segsz;	/* size of segment (bytes) */
+#if __BITS_PER_LONG == 64
+	long			shm_atime;	/* last attach time */
+	long			shm_dtime;	/* last detach time */
+	long			shm_ctime;	/* last change time */
+#else
+#define HAVE_SHMID64_DS_TIME_HIGH
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_atime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_ctime;	/* last change time */
+	unsigned long		shm_ctime_high;
+#endif
+	__kernel_pid_t		shm_cpid;	/* pid of creator */
+	__kernel_pid_t		shm_lpid;	/* pid of last operator */
+	unsigned long		shm_nattch;	/* no. of current attaches */
+	unsigned long		__unused4;
+	unsigned long		__unused5;
+};
+#endif /* shmid64_ds */
+
+#endif /* HAVE_SHMID64_DS */
+
+#endif /* IPC_SHMBUF_H */
diff --git a/runtest/syscalls b/runtest/syscalls
index db14ba4baf9e..297b225448b8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1352,6 +1352,7 @@ shmctl02 shmctl02
 shmctl03 shmctl03
 shmctl04 shmctl04
 shmctl05 shmctl05
+shmctl06 shmctl06
 
 shmdt01 shmdt01
 shmdt02 shmdt02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index f912cb067f74..5ba3b1449a6c 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -55,6 +55,7 @@ shmctl02 shmctl02
 shmctl03 shmctl03
 shmctl04 shmctl04
 shmctl05 shmctl05
+shmctl06 shmctl06
 
 shmdt01 shmdt01
 shmdt02 shmdt02
diff --git a/testcases/kernel/syscalls/ipc/shmctl/.gitignore b/testcases/kernel/syscalls/ipc/shmctl/.gitignore
index d6777e3b8f1b..46b107344cf4 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/.gitignore
+++ b/testcases/kernel/syscalls/ipc/shmctl/.gitignore
@@ -3,3 +3,4 @@
 /shmctl03
 /shmctl04
 /shmctl05
+/shmctl06
diff --git a/testcases/kernel/syscalls/ipc/shmctl/Makefile b/testcases/kernel/syscalls/ipc/shmctl/Makefile
index dda6d636f755..44e38d8fa760 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmctl/Makefile
@@ -3,12 +3,15 @@
 
 top_srcdir              ?= ../../../../..
 
+include $(top_srcdir)/include/mk/testcases.mk
+
 shmctl05: CFLAGS += -pthread
 shmctl05: LDLIBS += -lrt
 
-include $(top_srcdir)/include/mk/testcases.mk
+shmctl01 shmctl02 shmctl03 shmctl04 shmctl05: LDLIBS += -lltpipc
+shmctl06: LDLIBS += -lltpnewipc
 
-LDLIBS  += -lltpipc
 LDFLAGS += -L$(top_builddir)/libs/libltpipc
+LDFLAGS += -L$(top_builddir)/libs/libltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
new file mode 100644
index 000000000000..342c5ee3504c
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Description:
+ * Cross verify the _high fields being set to 0 by the kernel.
+ */
+#include <sys/shm.h>
+#include "libnewipc.h"
+#include "shmbuf.h"
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+
+#ifdef HAVE_SHMID64_DS_TIME_HIGH
+
+static void run(void)
+{
+	struct shmid64_ds buf_ds = {
+		.shm_atime_high = 0x0A0A,
+		.shm_dtime_high = 0x0A0A,
+		.shm_ctime_high = 0x0A0A,
+	};
+	int shmid;
+	key_t key;
+
+	/* get an IPC resource key */
+	key = GETIPCKEY();
+
+	shmid = shmget(key, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW);
+	if (shmid == -1)
+		tst_brk(TBROK | TERRNO, "couldn't create shared memory segment");
+
+	TEST(shmctl(shmid, IPC_STAT, (struct shmid_ds *)&buf_ds));
+	if (TST_RET == -1)
+		tst_brk(TFAIL | TTERRNO, "shmctl() failed");
+
+	if (buf_ds.shm_atime_high || buf_ds.shm_dtime_high || buf_ds.shm_ctime_high)
+		tst_res(TFAIL, "time_high fields aren't cleared by the kernel");
+	else
+		tst_res(TPASS, "time_high fields cleared by the kernel");
+
+	SAFE_SHMCTL(shmid, IPC_RMID, NULL);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_tmpdir = 1,
+};
+#else
+TST_TEST_TCONF("test requires struct shmid64_ds to have the time_high fields");
+#endif
-- 
2.25.0.rc1.19.g042ed3e048af

