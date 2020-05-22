From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 22 May 2020 12:46:04 +0530
Subject: [LTP] [PATCH V2 2/5] include: Add declaration of struct ipc64_perm
In-Reply-To: <5a10d33509ac73c26b233ab72c579f44386d0a55.1590057824.git.viresh.kumar@linaro.org>
References: <5a10d33509ac73c26b233ab72c579f44386d0a55.1590057824.git.viresh.kumar@linaro.org>
Message-ID: <dc4d34a42d4ca85d4d73b9e87974382368d02296.1590131635.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds declaration of struct ipc64_perm, which will be used by
following patches.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2: Include definitions for other architectures as well.

 configure.ac     |   1 +
 include/ipcbuf.h | 199 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 200 insertions(+)
 create mode 100644 include/ipcbuf.h

diff --git a/configure.ac b/configure.ac
index 1d3ea58d0082..eaf33dd60350 100644
--- a/configure.ac
+++ b/configure.ac
@@ -150,6 +150,7 @@ AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])
 AC_CHECK_TYPES([struct fs_quota_statv],,,[#include <xfs/xqm.h>])
 AC_CHECK_TYPES([struct if_nextdqblk],,,[#include <linux/quota.h>])
 AC_CHECK_TYPES([struct iovec],,,[#include <sys/uio.h>])
+AC_CHECK_TYPES([struct ipc64_perm],,,[#include <sys/ipcbuf.h>])
 
 AC_CHECK_TYPES([struct mmsghdr],,,[
 #define _GNU_SOURCE
diff --git a/include/ipcbuf.h b/include/ipcbuf.h
new file mode 100644
index 000000000000..caf1491df27f
--- /dev/null
+++ b/include/ipcbuf.h
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Linaro Limited. All rights reserved.
+ * Author: Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#ifndef IPCBUF_H
+#define IPCBUF_H
+
+#include <linux/posix_types.h>
+
+#ifndef HAVE_IPC64_PERM
+
+#if defined(__hppa__)
+#define HAVE_IPC64_PERM
+/*
+ * The ipc64_perm structure for PA-RISC is almost identical to
+ * kern_ipc_perm as we have always had 32-bit UIDs and GIDs in the kernel.
+ * 'seq' has been changed from long to int so that it's the same size
+ * on 64-bit kernels as on 32-bit ones.
+ */
+
+struct ipc64_perm
+{
+	__kernel_key_t		key;
+	__kernel_uid_t		uid;
+	__kernel_gid_t		gid;
+	__kernel_uid_t		cuid;
+	__kernel_gid_t		cgid;
+#if __BITS_PER_LONG != 64
+	unsigned short int	__pad1;
+#endif
+	__kernel_mode_t		mode;
+	unsigned short int	__pad2;
+	unsigned short int	seq;
+	unsigned int		__pad3;
+	unsigned long long int __unused1;
+	unsigned long long int __unused2;
+};
+#endif /* __hppa__ */
+
+#if defined(__powerpc__) || defined(__powerpc64__)
+#define HAVE_IPC64_PERM
+/*
+ * The ipc64_perm structure for the powerpc is identical to
+ * kern_ipc_perm as we have always had 32-bit UIDs and GIDs in the
+ * kernel.  Note extra padding because this structure is passed back
+ * and forth between kernel and user space.  Pad space is left for:
+ *	- 1 32-bit value to fill up for 8-byte alignment
+ *	- 2 miscellaneous 64-bit values
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+struct ipc64_perm
+{
+	__kernel_key_t	key;
+	__kernel_uid_t	uid;
+	__kernel_gid_t	gid;
+	__kernel_uid_t	cuid;
+	__kernel_gid_t	cgid;
+	__kernel_mode_t	mode;
+	unsigned int	seq;
+	unsigned int	__pad1;
+	unsigned long long __unused1;
+	unsigned long long __unused2;
+};
+
+#endif /* defined(__powerpc__) || defined(__powerpc64__) */
+
+#if defined(__s390__)
+#define HAVE_IPC64_PERM
+/*
+ * The user_ipc_perm structure for S/390 architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 32-bit mode_t and seq
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct ipc64_perm
+{
+	__kernel_key_t		key;
+	__kernel_uid32_t	uid;
+	__kernel_gid32_t	gid;
+	__kernel_uid32_t	cuid;
+	__kernel_gid32_t	cgid;
+	__kernel_mode_t		mode;
+	unsigned short		__pad1;
+	unsigned short		seq;
+#ifndef __s390x__
+	unsigned short		__pad2;
+#endif /* ! __s390x__ */
+	unsigned long		__unused1;
+	unsigned long		__unused2;
+};
+
+#endif /* defined(__powerpc__) || defined(__powerpc64__) */
+
+#if defined(__sparc__)
+#define HAVE_IPC64_PERM
+/*
+ * The ipc64_perm structure for sparc/sparc64 architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 32-bit seq
+ * - on sparc for 32 bit mode (it is 32 bit on sparc64)
+ * - 2 miscellaneous 64-bit values
+ */
+
+struct ipc64_perm
+{
+	__kernel_key_t		key;
+	__kernel_uid32_t	uid;
+	__kernel_gid32_t	gid;
+	__kernel_uid32_t	cuid;
+	__kernel_gid32_t	cgid;
+#ifndef __arch64__
+	unsigned short		__pad0;
+#endif
+	__kernel_mode_t		mode;
+	unsigned short		__pad1;
+	unsigned short		seq;
+	unsigned long long	__unused1;
+	unsigned long long	__unused2;
+};
+
+#endif /* __sparc__ */
+
+#if defined(__xtensa__)
+#define HAVE_IPC64_PERM
+/*
+ * Pad space is left for:
+ * - 32-bit mode_t and seq
+ * - 2 miscellaneous 32-bit values
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file "COPYING" in the main directory of
+ * this archive for more details.
+ */
+
+struct ipc64_perm
+{
+	__kernel_key_t		key;
+	__kernel_uid32_t	uid;
+	__kernel_gid32_t	gid;
+	__kernel_uid32_t	cuid;
+	__kernel_gid32_t	cgid;
+	__kernel_mode_t		mode;
+	unsigned long		seq;
+	unsigned long		__unused1;
+	unsigned long		__unused2;
+};
+
+#endif /* __xtensa__ */
+
+#ifndef HAVE_IPC64_PERM
+/*
+ * The generic ipc64_perm structure:
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * ipc64_perm was originally meant to be architecture specific, but
+ * everyone just ended up making identical copies without specific
+ * optimizations, so we may just as well all use the same one.
+ *
+ * Pad space is left for:
+ * - 32-bit mode_t on architectures that only had 16 bit
+ * - 32-bit seq
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct ipc64_perm {
+	__kernel_key_t		key;
+	__kernel_uid32_t	uid;
+	__kernel_gid32_t	gid;
+	__kernel_uid32_t	cuid;
+	__kernel_gid32_t	cgid;
+	__kernel_mode_t		mode;
+				/* pad if mode_t is u16: */
+	unsigned char		__pad1[4 - sizeof(__kernel_mode_t)];
+	unsigned short		seq;
+	unsigned short		__pad2;
+	__kernel_ulong_t	__unused1;
+	__kernel_ulong_t	__unused2;
+};
+
+#endif /* ipc64_perm */
+
+#endif /* HAVE_IPC64_PERM */
+
+#endif /* IPCBUF_H */
-- 
2.25.0.rc1.19.g042ed3e048af

