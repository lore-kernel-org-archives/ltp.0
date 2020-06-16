From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 16 Jun 2020 15:50:23 +0530
Subject: [LTP] [PATCH V2 5/6] include: Add declaration of struct msqid64_ds
In-Reply-To: <cover.1592302358.git.viresh.kumar@linaro.org>
References: <cover.1592302358.git.viresh.kumar@linaro.org>
Message-ID: <7616a6fa4f1502dde4417d33aa88836c8020419e.1592302358.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds declaration of struct msqid64_ds, which will be used by
following patches.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 configure.ac          |   1 +
 include/lapi/msgbuf.h | 306 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 307 insertions(+)
 create mode 100644 include/lapi/msgbuf.h

diff --git a/configure.ac b/configure.ac
index f1ee98b23cbe..05032d1cfd8f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -153,6 +153,7 @@ AC_CHECK_TYPES([struct iovec],,,[#include <sys/uio.h>])
 AC_CHECK_TYPES([struct ipc64_perm],,,[#include <sys/ipcbuf.h>])
 AC_CHECK_TYPES([struct semid64_ds],,,[#include <sys/sem.h>])
 AC_CHECK_TYPES([struct shmid64_ds],,,[#include <sys/shmbuf.h>])
+AC_CHECK_TYPES([struct msqid64_ds],,,[#include <sys/msgbuf.h>])
 
 AC_CHECK_TYPES([struct mmsghdr],,,[
 #define _GNU_SOURCE
diff --git a/include/lapi/msgbuf.h b/include/lapi/msgbuf.h
new file mode 100644
index 000000000000..779362c4f07a
--- /dev/null
+++ b/include/lapi/msgbuf.h
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Linaro Limited. All rights reserved.
+ * Author: Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#ifndef IPC_MSGBUF_H
+#define IPC_MSGBUF_H
+
+#include <linux/posix_types.h>
+#include <sys/sem.h>
+#include "tst_timer.h"
+#include "ipcbuf.h"
+
+#ifndef HAVE_MSQID64_DS
+
+#if defined(__mips__)
+#define HAVE_MSQID64_DS
+
+#if defined(__arch64__)
+/*
+ * The msqid64_ds structure for the MIPS architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 2 miscellaneous unsigned long values
+ */
+
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+	long msg_stime;			/* last msgsnd time */
+	long msg_rtime;			/* last msgrcv time */
+	long msg_ctime;			/* last change time */
+	unsigned long  msg_cbytes;	/* current number of bytes on queue */
+	unsigned long  msg_qnum;	/* number of messages in queue */
+	unsigned long  msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t msg_lrpid;	/* last receive pid */
+	unsigned long  __unused4;
+	unsigned long  __unused5;
+};
+#elif defined (__MIPSEB__)
+#define HAVE_MSQID64_DS_TIME_HIGH
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+	unsigned long  msg_stime_high;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_ctime_high;
+	unsigned long  msg_ctime;	/* last change time */
+	unsigned long  msg_cbytes;	/* current number of bytes on queue */
+	unsigned long  msg_qnum;	/* number of messages in queue */
+	unsigned long  msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t msg_lrpid;	/* last receive pid */
+	unsigned long  __unused4;
+	unsigned long  __unused5;
+};
+#elif defined (__MIPSEL__)
+#define HAVE_MSQID64_DS_TIME_HIGH
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_stime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_ctime;	/* last change time */
+	unsigned long  msg_ctime_high;
+	unsigned long  msg_cbytes;	/* current number of bytes on queue */
+	unsigned long  msg_qnum;	/* number of messages in queue */
+	unsigned long  msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t msg_lrpid;	/* last receive pid */
+	unsigned long  __unused4;
+	unsigned long  __unused5;
+};
+#endif
+
+#endif /* __mips__ */
+
+#if defined(__hppa__)
+#define HAVE_MSQID64_DS
+/* 
+ * The msqid64_ds structure for parisc architecture, copied from sparc.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+#if __BITS_PER_LONG == 64
+	long		 msg_stime;	/* last msgsnd time */
+	long		 msg_rtime;	/* last msgrcv time */
+	long		 msg_ctime;	/* last change time */
+#else
+#define HAVE_MSQID64_DS_TIME_HIGH
+	unsigned long	msg_stime_high;
+	unsigned long	msg_stime;	/* last msgsnd time */
+	unsigned long	msg_rtime_high;
+	unsigned long	msg_rtime;	/* last msgrcv time */
+	unsigned long	msg_ctime_high;
+	unsigned long	msg_ctime;	/* last change time */
+#endif
+	unsigned long	msg_cbytes;	/* current number of bytes on queue */
+	unsigned long	msg_qnum;	/* number of messages in queue */
+	unsigned long	msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t	msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t	msg_lrpid;	/* last receive pid */
+	unsigned long	__unused1;
+	unsigned long	__unused2;
+};
+
+#endif /* __hppa__ */
+
+#if defined(__powerpc__) || defined(__powerpc64__)
+#define HAVE_MSQID64_DS
+/*
+ * The msqid64_ds structure for the PowerPC architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ */
+
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+#ifdef __powerpc64__
+	long		 msg_stime;	/* last msgsnd time */
+	long		 msg_rtime;	/* last msgrcv time */
+	long		 msg_ctime;	/* last change time */
+#else
+#define HAVE_MSQID64_DS_TIME_HIGH
+	unsigned long  msg_stime_high;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_ctime_high;
+	unsigned long  msg_ctime;	/* last change time */
+#endif
+	unsigned long  msg_cbytes;	/* current number of bytes on queue */
+	unsigned long  msg_qnum;	/* number of messages in queue */
+	unsigned long  msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t msg_lrpid;	/* last receive pid */
+	unsigned long  __unused4;
+	unsigned long  __unused5;
+};
+
+#endif /* defined(__powerpc__) || defined(__powerpc64__) */
+
+#if defined(__sparc__)
+#define HAVE_MSQID64_DS
+/*
+ * The msqid64_ds structure for sparc64 architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 2 miscellaneous 32-bit values
+ */
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+#if defined(__arch64__)
+	long msg_stime;			/* last msgsnd time */
+	long msg_rtime;			/* last msgrcv time */
+	long msg_ctime;			/* last change time */
+#else
+#define HAVE_MSQID64_DS_TIME_HIGH
+	unsigned long msg_stime_high;
+	unsigned long msg_stime;	/* last msgsnd time */
+	unsigned long msg_rtime_high;
+	unsigned long msg_rtime;	/* last msgrcv time */
+	unsigned long msg_ctime_high;
+	unsigned long msg_ctime;	/* last change time */
+#endif
+	unsigned long  msg_cbytes;	/* current number of bytes on queue */
+	unsigned long  msg_qnum;	/* number of messages in queue */
+	unsigned long  msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t msg_lrpid;	/* last receive pid */
+	unsigned long  __unused1;
+	unsigned long  __unused2;
+};
+
+#endif /* __sparc__ */
+
+#if defined(__x86_64__) && defined(__ILP32__)
+#define HAVE_MSQID64_DS
+/*
+ * The msqid64_ds structure for x86 architecture with x32 ABI.
+ *
+ * On x86-32 and x86-64 we can just use the generic definition, but
+ * x32 uses the same binary layout as x86_64, which is differnet
+ * from other 32-bit architectures.
+ */
+
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+	__kernel_long_t msg_stime;	/* last msgsnd time */
+	__kernel_long_t msg_rtime;	/* last msgrcv time */
+	__kernel_long_t msg_ctime;	/* last change time */
+	__kernel_ulong_t msg_cbytes;	/* current number of bytes on queue */
+	__kernel_ulong_t msg_qnum;	/* number of messages in queue */
+	__kernel_ulong_t msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t msg_lrpid;	/* last receive pid */
+	__kernel_ulong_t __unused4;
+	__kernel_ulong_t __unused5;
+};
+
+#endif /* defined(__x86_64__) && defined(__ILP32__) */
+
+#if defined(__xtensa__)
+#define HAVE_MSQID64_DS
+/*
+ * The msqid64_ds structure for the Xtensa architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+#ifdef __XTENSA_EB__
+#define HAVE_MSQID64_DS_TIME_HIGH
+	unsigned long  msg_stime_high;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_ctime_high;
+	unsigned long  msg_ctime;	/* last change time */
+#elif defined(__XTENSA_EL__)
+#define HAVE_MSQID64_DS_TIME_HIGH
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_stime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_ctime;	/* last change time */
+	unsigned long  msg_ctime_high;
+#else
+# error processor byte order undefined!
+#endif
+	unsigned long  msg_cbytes;	/* current number of bytes on queue */
+	unsigned long  msg_qnum;	/* number of messages in queue */
+	unsigned long  msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t msg_lrpid;	/* last receive pid */
+	unsigned long  __unused4;
+	unsigned long  __unused5;
+};
+
+#endif /* __xtensa__ */
+
+#ifndef HAVE_MSQID64_DS
+/*
+ * generic msqid64_ds structure.
+ *
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * msqid64_ds was originally meant to be architecture specific, but
+ * everyone just ended up making identical copies without specific
+ * optimizations, so we may just as well all use the same one.
+ *
+ * 64 bit architectures use a 64-bit long time field here, while
+ * 32 bit architectures have a pair of unsigned long values.
+ * On big-endian systems, the lower half is in the wrong place.
+ *
+ * Pad space is left for:
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+#if __BITS_PER_LONG == 64
+	long		 msg_stime;	/* last msgsnd time */
+	long		 msg_rtime;	/* last msgrcv time */
+	long		 msg_ctime;	/* last change time */
+#else
+#define HAVE_MSQID64_DS_TIME_HIGH
+	unsigned long	msg_stime;	/* last msgsnd time */
+	unsigned long	msg_stime_high;
+	unsigned long	msg_rtime;	/* last msgrcv time */
+	unsigned long	msg_rtime_high;
+	unsigned long	msg_ctime;	/* last change time */
+	unsigned long	msg_ctime_high;
+#endif
+	unsigned long	msg_cbytes;	/* current number of bytes on queue */
+	unsigned long	msg_qnum;	/* number of messages in queue */
+	unsigned long	 msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t msg_lrpid;	/* last receive pid */
+	unsigned long	 __unused4;
+	unsigned long	 __unused5;
+};
+
+#endif /* msqid64_ds */
+
+#endif /* HAVE_MSQID64_DS */
+
+#endif /* IPC_MSGBUF_H */
-- 
2.25.0.rc1.19.g042ed3e048af

