From: dongshijiang <dongshijiang@inspur.com>
Date: Mon, 10 May 2021 05:56:09 -0400
Subject: [LTP] [PATCH] bugfix for block_dev_kernel/ltp_block_dev.c
Message-ID: <20210510095609.20128-1-dongshijiang@inspur.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add genhd.h and blkdev.h to ltp_block_dev.c.

Failed at compile time on kernel 5.12 due to change of register_blkdev function definition from linux/fs.h to linux/genhd.h and failure of test case tc05,The reason is that the BLKDEV_MAJOR_MAX definition was changed from fs.h to blkdev.h

Signed-off-by: dongshijiang <dongshijiang@inspur.com>
---
 .../device-drivers/block/block_dev_kernel/ltp_block_dev.c       | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
index c7c8683a2..17047c0d5 100644
--- a/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
+++ b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
@@ -12,6 +12,8 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/fs.h>
+#include <linux/genhd.h>
+#include <linux/blkdev.h>

 MODULE_AUTHOR("M?rton N?meth <nm127@freemail.hu>");
 MODULE_AUTHOR("Copyright (c) 2013 Oracle and/or its affiliates");
--
2.18.2

