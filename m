From: Murphy Zhou <xzhou@redhat.com>
Date: Tue, 11 Jun 2019 15:47:38 +0800
Subject: [LTP] [PATCH v7 1/4] lib/tst_ioctl.c: add helper tst_fibmap
In-Reply-To: <CAEemH2e5b4q+bOeE3v8FG-piSUteCinPMVmxpnkVcYCmrUc4Uw@mail.gmail.com>
References: <CAEemH2e5b4q+bOeE3v8FG-piSUteCinPMVmxpnkVcYCmrUc4Uw@mail.gmail.com>
Message-ID: <20190611074741.31903-1-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To check if FIBMAP ioctl is supported by the filesystem we are
testing on. It also can check the support status of specific
files, but that may not needed for now.

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
v7:
  Make tst_fibmap return value more accurate
  Print errno if fibmap ioctl does not succeed
  Make swapoff02 use new helper
  Mute some build warnnings
  cc linux-fsdevel list
  Overall diff stat:

 include/tst_fs.h                               |  5 +++++
 lib/tst_ioctl.c                                | 37 +++++++++++++++++++++++++++++++++++++
 testcases/kernel/syscalls/swapoff/Makefile     |  3 ++-
 testcases/kernel/syscalls/swapoff/Makefile.inc |  6 ++++++
 testcases/kernel/syscalls/swapoff/swapoff01.c  | 10 ++--------
 testcases/kernel/syscalls/swapoff/swapoff02.c  | 11 ++---------
 testcases/kernel/syscalls/swapon/libswapon.c   | 45 +++++++++++++++++++++++++++++++++++++++++++--
 testcases/kernel/syscalls/swapon/libswapon.h   |  7 ++++++-
 testcases/kernel/syscalls/swapon/swapon01.c    | 11 ++---------
 testcases/kernel/syscalls/swapon/swapon02.c    | 13 +++----------
 testcases/kernel/syscalls/swapon/swapon03.c    | 15 ++++-----------
 11 files changed, 112 insertions(+), 51 deletions(-)

v6:
  Modify make_swapfile() to check mkswap support status safely
  Remove whitelist
  Remove BTRFS EINVAL check
  Check mkswap status before testing swapon in helper
  If swapon pass, following swapoff failure will fail the whole test and break
  Also modify swapoff02 to remove whitelist completely
v5:
  Split to 4 patches
  Only take one filename parameter in tst_fibmap
  Add helper is_swap_supported to check swap operation support status
  Test fibmap/swapon and swapoff operation in the helper
  Keep NFS/TMPFS whitelist
  Keep BTRFS EINVAL handling logic, except above 2 situation:
    if swapon fails and fibmap is not supported, tst_brk with TCONF
    if swapon fails and fibmap is supported, tst_brk with TFAIL
  If swapon test pass in the helper, test swapoff similarly
  Put is_swap_supported helper in libswapon, link swapoff binaries to it
  Mute a sprintf filaname wanrning by the way
v4:
  Fail softly if FIBMAP nit supported, instead of skip entire testcase
v3:
  Fix fs_type undeclared in swapoff01.c
v2:
  Test FIBMAP instead of fstype whitelist

 include/tst_fs.h |  5 +++++
 lib/tst_ioctl.c  | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 lib/tst_ioctl.c

diff --git a/include/tst_fs.h b/include/tst_fs.h
index ebca065c6..6d03371ec 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -178,6 +178,11 @@ const char **tst_get_supported_fs_types(void);
  */
 void tst_fill_fs(const char *path, int verbose);
 
+/*
+ * test if FIBMAP ioctl is supported
+ */
+int tst_fibmap(const char *filename);
+
 #ifdef TST_TEST_H__
 static inline long tst_fs_type(const char *path)
 {
diff --git a/lib/tst_ioctl.c b/lib/tst_ioctl.c
new file mode 100644
index 000000000..364220bcd
--- /dev/null
+++ b/lib/tst_ioctl.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <linux/fs.h>
+
+#define TST_NO_DEFAULT_MAIN
+
+#include "tst_test.h"
+
+int tst_fibmap(const char *filename)
+{
+	/* test if FIBMAP ioctl is supported */
+	int fd, block = 0;
+
+	fd = open(filename, O_RDWR | O_CREAT, 0666);
+	if (fd < 0) {
+		tst_res(TWARN | TERRNO,
+			 "open(%s, O_RDWR | O_CREAT, 0666) failed", filename);
+		return -1;
+	}
+
+	if (ioctl(fd, FIBMAP, &block)) {
+		tst_res(TINFO | TERRNO, "FIBMAP ioctl is NOT supported");
+		close(fd);
+		return 1;
+	}
+	tst_res(TINFO, "FIBMAP ioctl is supported");
+
+	if (close(fd)) {
+		tst_res(TWARN | TERRNO, "close(fd) failed");
+		return -1;
+	}
+	return 0;
+}
-- 
2.21.0

