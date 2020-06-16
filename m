From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 16 Jun 2020 15:50:21 +0530
Subject: [LTP] [PATCH V2 3/6] include: Add declaration of struct shmid64_ds
In-Reply-To: <cover.1592302358.git.viresh.kumar@linaro.org>
References: <cover.1592302358.git.viresh.kumar@linaro.org>
Message-ID: <a9675d9914eac01d27c96bae5a0160282f8c0b63.1592302358.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds declaration of struct shmid64_ds, which will be used by
following patches.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 configure.ac          |   1 +
 include/lapi/shmbuf.h | 273 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 274 insertions(+)
 create mode 100644 include/lapi/shmbuf.h

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
diff --git a/include/lapi/shmbuf.h b/include/lapi/shmbuf.h
new file mode 100644
index 000000000000..f8c1294c60d6
--- /dev/null
+++ b/include/lapi/shmbuf.h
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
-- 
2.25.0.rc1.19.g042ed3e048af

