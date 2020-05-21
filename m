From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 21 May 2020 16:17:33 +0530
Subject: [LTP] [PATCH 2/5] include: Add declaration of struct ipc64_perm
In-Reply-To: <cover.1590057824.git.viresh.kumar@linaro.org>
References: <cover.1590057824.git.viresh.kumar@linaro.org>
Message-ID: <5a10d33509ac73c26b233ab72c579f44386d0a55.1590057824.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds declaration of struct ipc64_perm, which will be used by
following patches.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 configure.ac     |  1 +
 include/ipcbuf.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
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
index 000000000000..85162296ab44
--- /dev/null
+++ b/include/ipcbuf.h
@@ -0,0 +1,45 @@
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
+#endif
+
+#endif /* IPCBUF_H */
-- 
2.25.0.rc1.19.g042ed3e048af

