From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 8 May 2020 13:47:08 +0800
Subject: [LTP] [PATCH] syscalls/ioctl_loop01: Add linux git tag
Message-ID: <1588916828-4228-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_loop01.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
index faef22e47..2d9733f95 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -12,6 +12,9 @@
  * For LO_FLAGS_PARTSCAN flag, it is the same as LO_FLAGS_AUTOCLEAR flag.
  * But we also check whether we can scan partition table correctly ie check
  * whether /dev/loopnp1 and /sys/bloclk/loop0/loop0p1 existed.
+ *
+ * It is also a regression test for kernel
+ * commit 10c70d95c0f2 ("block: remove the bd_openers checks in blk_drop_partitions").
  */
 
 #include <stdio.h>
@@ -137,5 +140,9 @@ static struct tst_test test = {
 		"loop",
 		NULL
 	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "10c70d95c0f2"},
+		{}
+	},
 	.needs_tmpdir = 1,
 };
-- 
2.23.0



