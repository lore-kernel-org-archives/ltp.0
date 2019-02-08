From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 8 Feb 2019 11:37:55 +0800
Subject: [LTP] [PATCH v2] block/ltp_block_dev.c: Update tests for the newer
	kernel
In-Reply-To: <20190206070648.GA1720@x230>
References: <20190206070648.GA1720@x230>
Message-ID: <1549597075-7589-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The maximum major number is set to 511 since kernel commit 133d55c,
so register_blkdev() with a major number grater than the maximum(511)
will get failure instead of pass as expected.

1) Update tests for the newer behavior of register_blkdev().
2) Add more major numbers(i.e. 511 and 512) to test.

Note:
It is possible that specified major numbers have been used
by system, so we skip them if register_blkdev() returns EBUSY.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 .../block/block_dev_kernel/ltp_block_dev.c         | 64 +++++++++++-----------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
index d573085..b0f6ce5 100644
--- a/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
+++ b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  * Only those functions are tested here which are declared in <linux/fs.h>
  *
  * Changes:
@@ -52,7 +39,8 @@ MODULE_LICENSE("GPL");
  *             |--------------------------+---------+-------------
  *             | [1..255]                 | valid   | tc03
  *             |--------------------------+---------+-------------
- *             | [256..UINT_MAX]          | valid   | tc04, tc05
+ *             | [256..511]               | valid   | tc04
+ *             | [512..UINT_MAX]          | invalid | tc05
  *  -----------+--------------------------+---------+-------------
  *  name       | [valid pointer to a zero |         |
  *             |  terminated string]      | valid   | tc01, tc02
@@ -205,17 +193,25 @@ static int tc03(void)
 static int tc04(void)
 {
 	int major, pass = 8;
+	unsigned int i, test_major[2] = {256, 511};
 
-	prk_info("Test Case 4: register_blkdev() with major=256\n");
+	prk_info("Test Case 4: register_blkdev() with major=%u/%u\n",
+		 test_major[0], test_major[1]);
 
-	major = register_blkdev(256, BLK_DEV_NAME);
-	prk_debug("major = %i\n", major);
+	for (i = 0; i < sizeof(test_major) / sizeof(unsigned int); i++) {
+		major = register_blkdev(test_major[i], BLK_DEV_NAME);
+		prk_debug("major = %i\n", major);
 
-	if (major == 0) {
-		unregister_blkdev(256, BLK_DEV_NAME);
-	} else {
-		pass = 0;
-		prk_debug("register_blkdev() failed with error %i\n", major);
+		if (major == 0) {
+			unregister_blkdev(test_major[i], BLK_DEV_NAME);
+		} else if (major == -EBUSY) {
+			prk_debug("device was busy, register_blkdev() with major %u skipped\n",
+				  test_major[i]);
+		} else {
+			pass = 0;
+			prk_debug("register_blkdev() with major %u got error %i\n",
+				  test_major[i], major);
+		}
 	}
 
 	prk_info("Test Case Result: %s\n", result_str(pass));
@@ -225,18 +221,22 @@ static int tc04(void)
 static int tc05(void)
 {
 	int major, pass = 16;
+	unsigned int i, test_major[2] = {512, UINT_MAX};
 
-	prk_info("Test Case 5: register_blkdev() with major=%u\n", UINT_MAX);
+	prk_info("Test Case 5: register_blkdev() with major=%u/%u\n",
+		 test_major[0], test_major[1]);
 
-	major = register_blkdev(UINT_MAX, BLK_DEV_NAME);
-	prk_debug("major = %i\n", major);
+	for (i = 0; i < sizeof(test_major) / sizeof(unsigned int); i++) {
+		major = register_blkdev(test_major[i], BLK_DEV_NAME);
+		prk_debug("major = %i\n", major);
 
-	if (major == 0) {
-		unregister_blkdev(UINT_MAX, BLK_DEV_NAME);
-	} else {
-		prk_debug("reg blkdev with major %d failed with error %i\n",
-			UINT_MAX, major);
-		pass = 0;
+		if (major == 0) {
+			unregister_blkdev(test_major[i], BLK_DEV_NAME);
+			pass = 0;
+		} else {
+			prk_debug("register_blkdev() with major %u got error %i\n",
+				  test_major[i], major);
+		}
 	}
 
 	prk_info("Test Case Result: %s\n", result_str(pass));
-- 
1.8.3.1



