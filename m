From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 11 Jun 2020 18:35:13 +0800
Subject: [LTP] [PATCH v1 1/4] lapi: Add fallback for LOOP_CONFIGURE ioctl
 and struct loop_config
In-Reply-To: <1591871716-21250-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1591871716-21250-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1591871716-21250-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 configure.ac        |  1 +
 include/lapi/loop.h | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/configure.ac b/configure.ac
index 1d3ea58d0..7d2be1df7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -150,6 +150,7 @@ AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])
 AC_CHECK_TYPES([struct fs_quota_statv],,,[#include <xfs/xqm.h>])
 AC_CHECK_TYPES([struct if_nextdqblk],,,[#include <linux/quota.h>])
 AC_CHECK_TYPES([struct iovec],,,[#include <sys/uio.h>])
+AC_CHECK_TYPES([struct loop_config],,,[#include <linux/loop.h>])
 
 AC_CHECK_TYPES([struct mmsghdr],,,[
 #define _GNU_SOURCE
diff --git a/include/lapi/loop.h b/include/lapi/loop.h
index c69328613..87a902317 100644
--- a/include/lapi/loop.h
+++ b/include/lapi/loop.h
@@ -6,6 +6,7 @@
 #ifndef LAPI_LOOP_H
 #define LAPI_LOOP_H
 
+#include "config.h"
 #include <linux/types.h>
 #include <linux/loop.h>
 
@@ -29,4 +30,26 @@
 # define LOOP_SET_BLOCK_SIZE 0x4C09
 #endif
 
+#ifndef LOOP_CONFIGURE
+# define LOOP_CONFIGURE 0x4C0A
+#endif
+
+#ifndef HAVE_STRUCT_LOOP_CONFIG
+/*
+ * struct loop_config - Complete configuration for a loop device.
+ * @fd: fd of the file to be used as a backing file for the loop device.
+ * @block_size: block size to use; ignored if 0.
+ * @info: struct loop_info64 to configure the loop device with.
+ *
+ * This structure is used with the LOOP_CONFIGURE ioctl, and can be used to
+ * atomically setup and configure all loop device parameters at once.
+ */
+struct loop_config {
+	__u32			fd;
+	__u32                   block_size;
+	struct loop_info64	info;
+	__u64			__reserved[8];
+};
+#endif
+
 #endif
-- 
2.23.0



