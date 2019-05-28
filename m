From: Murphy Zhou <xzhou@redhat.com>
Date: Tue, 28 May 2019 12:39:27 +0800
Subject: [LTP] [PATCH v5 2/4] swapon/libswapon: add helper is_swap_supported
In-Reply-To: <20190528043929.19671-1-xzhou@redhat.com>
References: <20190523135518.GF30616@rei.lan>
 <20190528043929.19671-1-xzhou@redhat.com>
Message-ID: <20190528043929.19671-2-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To check if the filesystem we are testing on supports swapon/swapoff
operations. Keep NFS and TMPFS on the white list. Don't report fail
if BTRFS fails with EINVAL.

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 testcases/kernel/syscalls/swapon/libswapon.c | 56 ++++++++++++++++++++
 testcases/kernel/syscalls/swapon/libswapon.h |  6 +++
 2 files changed, 62 insertions(+)

diff --git a/testcases/kernel/syscalls/swapon/libswapon.c b/testcases/kernel/syscalls/swapon/libswapon.c
index cf6a98891..e02fdd4ad 100644
--- a/testcases/kernel/syscalls/swapon/libswapon.c
+++ b/testcases/kernel/syscalls/swapon/libswapon.c
@@ -19,6 +19,8 @@
  *
  */
 
+#include <errno.h>
+#include "lapi/syscalls.h"
 #include "test.h"
 #include "libswapon.h"
 
@@ -47,3 +49,57 @@ void make_swapfile(void (cleanup)(void), const char *swapfile)
 
 	tst_run_cmd(cleanup, argv, "/dev/null", "/dev/null", 0);
 }
+
+/*
+ * Check swapon/swapoff support status of filesystems or files
+ * we are testing on.
+ */
+void is_swap_supported(void (cleanup)(void), const char *ops,
+				const char *filename)
+{
+	int fibmap = tst_fibmap(filename);
+	long fs_type = tst_fs_type(cleanup, filename);
+	const char *fstype = tst_fs_type_name(fs_type);
+
+	/* whitelist legacy fs */
+	switch (fs_type) {
+	case TST_NFS_MAGIC:
+	case TST_TMPFS_MAGIC:
+		tst_brkm(TCONF, cleanup,
+			 "Cannot do %s on a file on %s filesystem",
+			 ops, fstype);
+	break;
+	}
+
+	make_swapfile(NULL, filename);
+
+	TEST(ltp_syscall(__NR_swapon, filename, 0));
+
+	if (TEST_RETURN == -1) {
+		if (fs_type == TST_BTRFS_MAGIC && errno == EINVAL) {
+			tst_brkm(TCONF, cleanup,
+				"Swapfile on BTRFS not implemented");
+		} else {
+			if (fibmap == 0) {
+				tst_brkm(TFAIL | TERRNO, cleanup,
+					 "swapon on %s failed", fstype);
+			} else {
+				tst_brkm(TCONF, cleanup,
+					 "swapon on %s is not supported",
+						fstype);
+			}
+		}
+	}
+
+	TEST(ltp_syscall(__NR_swapoff, filename, 0));
+
+	if (TEST_RETURN == -1) {
+		if (fibmap == 0) {
+			tst_brkm(TFAIL | TERRNO, cleanup,
+				"swapoff on %s failed", fstype);
+		} else {
+			tst_brkm(TCONF, cleanup,
+				 "swapoff on %s is not supported", fstype);
+		}
+	}
+}
diff --git a/testcases/kernel/syscalls/swapon/libswapon.h b/testcases/kernel/syscalls/swapon/libswapon.h
index 7f7211eb4..4f2c83614 100644
--- a/testcases/kernel/syscalls/swapon/libswapon.h
+++ b/testcases/kernel/syscalls/swapon/libswapon.h
@@ -31,4 +31,10 @@
  */
 void make_swapfile(void (cleanup)(void), const char *swapfile);
 
+/*
+ * Check swapon/swapoff support status of filesystems or files
+ * we are testing on.
+ */
+void is_swap_supported(void (cleanup)(void), const char *ops,
+				const char *filename);
 #endif /* __LIBSWAPON_H__ */
-- 
2.21.0

