Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1VX6Xc-0006V6-4Q
	for ltp-list@lists.sourceforge.net; Fri, 18 Oct 2013 09:40:20 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VX6XZ-00076k-BU
	for ltp-list@lists.sourceforge.net; Fri, 18 Oct 2013 09:40:20 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r9I9eAjY024343
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Oct 2013 09:40:11 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9I9eAZS014606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Oct 2013 09:40:10 GMT
Received: from abhmt102.oracle.com (abhmt102.oracle.com [141.146.116.54])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9I9e9ZI014589
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Oct 2013 09:40:09 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 18 Oct 2013 13:39:44 +0400
Message-Id: <1382089184-21140-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1382089184-21140-1-git-send-email-alexey.kodanev@oracle.com>
References: <1382089184-21140-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/2] device-drivers: tbio: fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

Obsolete code updated to the actual kernel BIO API.
User-space program rewritten to use LTP lib.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/device-drivers/tbio/Makefile      |   20 +
 .../device-drivers/tbio/tbio_kernel/.gitignore     |    7 +
 .../device-drivers/tbio/tbio_kernel/Makefile       |   37 +-
 .../device-drivers/tbio/tbio_kernel/ltp_tbio.c     |  499 +++++++++----------
 .../kernel/device-drivers/tbio/tbio_kernel/tbio.h  |   65 +--
 .../device-drivers/tbio/tbio_user/.gitignore       |    1 +
 .../kernel/device-drivers/tbio/tbio_user/Makefile  |   25 +-
 .../kernel/device-drivers/tbio/tbio_user/tbio.c    |  258 +++++------
 8 files changed, 448 insertions(+), 464 deletions(-)
 create mode 100644 testcases/kernel/device-drivers/tbio/Makefile
 create mode 100644 testcases/kernel/device-drivers/tbio/tbio_kernel/.gitignore
 create mode 100644 testcases/kernel/device-drivers/tbio/tbio_user/.gitignore

diff --git a/testcases/kernel/device-drivers/tbio/Makefile b/testcases/kernel/device-drivers/tbio/Makefile
new file mode 100644
index 0000000..b3bb5aa
--- /dev/null
+++ b/testcases/kernel/device-drivers/tbio/Makefile
@@ -0,0 +1,20 @@
+# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+top_srcdir	?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/device-drivers/tbio/tbio_kernel/.gitignore b/testcases/kernel/device-drivers/tbio/tbio_kernel/.gitignore
new file mode 100644
index 0000000..7ce5765
--- /dev/null
+++ b/testcases/kernel/device-drivers/tbio/tbio_kernel/.gitignore
@@ -0,0 +1,7 @@
+/ltp_tbio.ko
+/*.mod.c
+/modules.order
+/.tmp_versions
+/.*.ko
+/.*.cmd
+/Module.symvers
diff --git a/testcases/kernel/device-drivers/tbio/tbio_kernel/Makefile b/testcases/kernel/device-drivers/tbio/tbio_kernel/Makefile
index 2bbd1f5..6c6ba92 100644
--- a/testcases/kernel/device-drivers/tbio/tbio_kernel/Makefile
+++ b/testcases/kernel/device-drivers/tbio/tbio_kernel/Makefile
@@ -1,22 +1,33 @@
+# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
 #
-# Makefile for GCOV profiling kernel module
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-
-#KERNELDIR := /usr/src/linux-2.5.64-gcov
-EXTRA_CFLAGS := -Wall
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 
 ifneq ($(KERNELRELEASE),)
 
-obj-m	:= tbio.o
+obj-m := ltp_tbio.o
+
 else
-KDIR	:= /lib/modules/$(shell uname -r)/build
-PWD	:= $(shell pwd)
 
-default:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
-#	$(MAKE) -C $(KERNELDIR) SUBDIRS=$(PWD) modules
-endif
+top_srcdir	?= ../../../../..
+include $(top_srcdir)/include/mk/env_pre.mk
+
+REQ_VERSION_MAJOR	:= 2
+REQ_VERSION_PATCH	:= 6
+MAKE_TARGETS		:= ltp_tbio.ko
 
-clean:
-	rm -f *.o rm -f .*.cmd rm -f *.bb* rm -f *.ko rm -f *.mod.* 2>/dev/null || true
+include $(top_srcdir)/include/mk/module.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
+endif
diff --git a/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c b/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c
index 447d223..3c76a8a 100644
--- a/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c
+++ b/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c
@@ -1,39 +1,24 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
-
  * This module will test block io layer.
  *
  * module: tbio
- *  Copyright (c) International Business Machines  Corp., 2003
- *
- *  This program is free software;  you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *  the GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program;
  *
  *  FILE        : tbio.c
  *  USAGE       : kernel_space:./load_tbio.sh
@@ -50,12 +35,7 @@
  *
  */
 
-#ifndef __KERNEL__
-#define __KERNEL__
-#endif
-
 #include <linux/module.h>
-//#include <linux/moduleparam.h>
 #include <linux/init.h>
 
 #include <linux/kernel.h>
@@ -66,22 +46,24 @@
 #include <linux/genhd.h>
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
+
 #include "tbio.h"
 
-#define BLK_DEFAULT_TIMEOUT	(60 * HZ)
 MODULE_AUTHOR("Kai Zhao <ltcd3@cn.ibm.com>");
+MODULE_AUTHOR("Alexey Kodanev <alexey.kodanev@oracle.com>");
 MODULE_DESCRIPTION(TMOD_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
-//module_param(major_num , int , 0);
-static int hardsect_size = 1024;
-//module_param(hardsect_size , int , 0);
-static int nsectors = 1024;
-//module_param(nsectors , int , 0);
+#define prk_err(fmt, ...) \
+	pr_err(TBIO_DEVICE_NAME ": " fmt "\n", ##__VA_ARGS__)
+#define prk_info(fmt, ...) \
+	pr_info(TBIO_DEVICE_NAME ": " fmt "\n", ##__VA_ARGS__)
+
+static int nsectors = 4096;
+module_param(nsectors, int, 0444);
+MODULE_PARM_DESC(nsectors, "The number of sectors");
 
-static struct bio *tbiop = NULL, *tbiop_dup = NULL;
-//static struct bio_pair *bio_pairp = NULL;
-static struct request_queue Queue;
+static struct bio *tbiop, *tbiop_dup;
 
 static struct tbio_device {
 	unsigned long size;
@@ -89,83 +71,61 @@ static struct tbio_device {
 	u8 *data;
 	struct gendisk *gd;
 	struct block_device *bdev;
-} Device;
+	struct request_queue *q;
+} tbio_dev;
 
-static int send_request(request_queue_t * q, struct bio *bio,
-			struct block_device *bdev, struct tbio_interface *inter,
-			int writing)
+static int send_request(struct request_queue *q, struct bio *bio,
+	struct block_device *bdev, struct tbio_interface *inter,
+	int writing)
 {
 	struct request *rq;
-	void *buffer = NULL;
-	unsigned long start_time;
-	int err;
+	rq = blk_make_request(q, bio, GFP_KERNEL);
+	if (!rq) {
+		prk_err("failed to make request");
+		return -EFAULT;
+	}
 
-	rq = blk_get_request(q, writing ? WRITE : READ, __GFP_WAIT);
 	rq->cmd_len = inter->cmd_len;
-	//printk("inter.cmd %s\n" , inter->cmd);
+
 	if (copy_from_user(rq->cmd, inter->cmd, inter->cmd_len))
 		goto out_request;
-	//printk("tbio: rq->cmd : %s\n",rq->cmd);
-	if (sizeof(rq->cmd) != inter->cmd_len)
-		memset(rq->cmd + inter->cmd_len, 0,
-		       sizeof(rq->cmd) - inter->cmd_len);
-
-	rq->bio = rq->biotail = NULL;
-
-	blk_rq_bio_prep(q, rq, bio);
-
-	rq->data = buffer;
-	rq->data_len = inter->data_len;
 
-	rq->timeout = 0;
-	if (!rq->timeout)
-		rq->timeout = q->sg_timeout;
-	if (!rq->timeout)
-		rq->timeout = BLK_DEFAULT_TIMEOUT;
-
-	start_time = jiffies;
-
-	DECLARE_COMPLETION(wait);
+	if (sizeof(rq->cmd) != inter->cmd_len) {
+		memset(rq->cmd + inter->cmd_len, 0,
+			sizeof(rq->cmd) - inter->cmd_len);
+	}
 
-	rq->rq_disk = bdev->bd_disk;
+	rq->__sector = bio->bi_sector;
 
-	rq->waiting = &wait;
-	elv_add_request(q, rq, 1, 1);
-	generic_unplug_device(q);
-	wait_for_completion(&wait);
-	//printk("tbio: completion\n");
-	if (rq->errors) {
-		err = -EIO;
-		printk("tbio: rq->errors\n");
-		return err;
-	}
+	if (blk_execute_rq(q, bdev->bd_disk, rq, 0))
+		goto out_request;
 
 	blk_put_request(rq);
 
 	return 0;
+
 out_request:
+
 	blk_put_request(rq);
 	return -EFAULT;
-
 }
 
 static int tbio_io(struct block_device *bdev, struct tbio_interface *uptr)
 {
+	int ret;
 	tbio_interface_t inter;
 	struct bio *bio = NULL;
 	int reading = 0, writing = 0;
-	void *buffer = NULL;
-	//struct request *rq;
-	request_queue_t *q;
-	q = bdev_get_queue(Device.bdev);
+	void *buf = NULL;
+	struct request_queue *q = bdev_get_queue(bdev);
 
 	if (copy_from_user(&inter, uptr, sizeof(tbio_interface_t))) {
-		printk("tbio: copy_from_user\n");
+		prk_err("copy_from_user");
 		return -EFAULT;
 	}
 
-	if (inter.data_len > (q->max_sectors << 9)) {
-		printk("tbio: inter.in_len > q->max_sectors << 9\n");
+	if (inter.data_len > (q->limits.max_sectors << 9)) {
+		prk_err("inter.in_len > q->max_sectors << 9");
 		return -EIO;
 	}
 
@@ -182,19 +142,22 @@ static int tbio_io(struct block_device *bdev, struct tbio_interface *uptr)
 			break;
 		}
 
-		bio = bio_map_user(bdev, (unsigned long)inter.data,
-				   inter.data_len, reading);
+		bio = bio_map_user(q, bdev, (unsigned long)inter.data,
+			inter.data_len, reading, GFP_KERNEL);
 
 		if (!bio) {
-			printk("tbio : bio_map_user failed\n");
-			buffer =
-			    kmalloc(inter.data_len, q->bounce_gfp | GFP_USER);
-			if (!buffer) {
-				printk("tbio: buffer no memory\n");
+			prk_err("bio_map_user failed");
+			buf = kmalloc(inter.data_len, q->bounce_gfp | GFP_USER);
+			if (!buf) {
+				prk_err("buffer no memory");
 				return -1;
 			}
-			copy_from_user(buffer, inter.data, inter.data_len);
-			printk("tbio: buffer %s\n", (char *)buffer);
+			ret = copy_from_user(buf, inter.data, inter.data_len);
+			if (ret)
+				prk_err("copy_from_user() failed");
+
+			prk_info("buffer %s\n, copy_from_user returns '%d'",
+				(char *)buf, ret);
 		}
 
 	}
@@ -202,13 +165,12 @@ static int tbio_io(struct block_device *bdev, struct tbio_interface *uptr)
 	send_request(q, bio, bdev, &inter, writing);
 
 	if (bio)
-		bio_unmap_user(bio, reading);
+		bio_unmap_user(bio);
 	return 0;
 }
 
 static int test_bio_put(struct bio *biop)
 {
-
 	if (biop)
 		bio_put(biop);
 
@@ -219,7 +181,7 @@ static int test_bio_clone(void)
 {
 	tbiop_dup = bio_clone(tbiop, GFP_NOIO);
 	if (tbiop_dup == NULL) {
-		printk("tbio: bio_clone failed\n");
+		prk_err("bio_clone failed");
 		return -1;
 	}
 
@@ -230,7 +192,7 @@ static int test_bio_clone(void)
 
 static int test_bio_add_page(void)
 {
-	int res = 0, i = 0, offset = 0;
+	int ret = 0, i = 0, offset = 0;
 	unsigned long addr = 0;
 	struct page *ppage = NULL;
 
@@ -239,33 +201,34 @@ static int test_bio_add_page(void)
 		addr = get_zeroed_page(GFP_KERNEL);
 
 		if (addr == 0) {
-			printk("tbio: get free page failed %ld\n", addr);
-			return -1;
+			prk_err("get free page failed %ld", addr);
+			ret = -1;
+			break;
 		}
 
 		ppage = virt_to_page(addr);
 		if (ppage == NULL) {
-			printk
-			    ("tbio: covert virture page to page struct failed\n");
-			return -1;
+			prk_err("covert virture page to page struct failed");
+			ret = -1;
+			break;
 		}
 
-		res = bio_add_page(tbiop, ppage, PAGE_SIZE, offset);
-		if (res < 0) {
-			printk("bio_add_page :res %d\n", res);
-			return -1;
+		ret = bio_add_page(tbiop, ppage, PAGE_SIZE, offset);
+		if (ret < 0) {
+			prk_err("bio_add_page failed");
+			break;
 		}
-		offset += res;
-		//      printk ("tbio: bio_add_page : %d\n", res);
+		offset += ret;
 	}
-	return 0;
+
+	return ret;
 }
 
 static int test_do_bio_alloc(int num)
 {
 	tbiop = bio_alloc(GFP_KERNEL, num);
 	if (tbiop == NULL) {
-		printk("tbio: bio_alloc failed\n");
+		prk_err("bio_alloc failed");
 		return -1;
 	}
 	bio_put(tbiop);
@@ -275,64 +238,71 @@ static int test_do_bio_alloc(int num)
 
 static int test_bio_alloc(void)
 {
-	int res = 0;
-	res = test_do_bio_alloc(2);
-	if (res < 0) {
-		printk("can not alloc bio for %d\n", 2);
+	if (test_do_bio_alloc(2) < 0) {
+		prk_err("can not alloc bio for %d", 2);
 		return -1;
 	}
 
-	res = test_do_bio_alloc(8);
-	if (res < 0) {
-		printk("can not alloc bio for %d\n", 8);
+	if (test_do_bio_alloc(8) < 0) {
+		prk_err("can not alloc bio for %d", 8);
 		return -1;
 	}
-	res = test_do_bio_alloc(32);
-	if (res < 0) {
-		printk("can not alloc bio for %d\n", 32);
+
+	if (test_do_bio_alloc(32) < 0) {
+		prk_err("can not alloc bio for %d", 32);
 		return -1;
 	}
-	res = test_do_bio_alloc(96);
-	if (res < 0) {
-		printk("can not alloc bio for %d\n", 96);
+
+	if (test_do_bio_alloc(96) < 0) {
+		prk_err("can not alloc bio for %d", 96);
 		return -1;
 	}
-	res = test_do_bio_alloc(BIO_MAX_PAGES);
-	if (res < 0) {
-		printk("can not alloc bio for %d\n", BIO_MAX_PAGES);
+
+	if (test_do_bio_alloc(BIO_MAX_PAGES) < 0) {
+		prk_err("can not alloc bio for %d", BIO_MAX_PAGES);
 		return -1;
 	}
 
 	tbiop = bio_alloc(GFP_KERNEL, BIO_MAX_PAGES);
 	if (tbiop == NULL) {
-		printk("tbio: bio_alloc failed\n");
+		prk_err("bio_alloc failed");
 		return -1;
 	}
 
+	tbiop->bi_bdev = tbio_dev.bdev;
+	tbiop->bi_sector = 0;
+
 	return 0;
 }
 
 static int test_bio_split(struct block_device *bdev,
 			  struct tbio_interface *uptr)
 {
+	int ret;
 	tbio_interface_t inter;
 	struct bio *bio = NULL;
 	struct bio_pair *bio_pairp = NULL;
 	int reading = 0, writing = 0;
-	void *buffer = NULL;
-	request_queue_t *q;
-	q = bdev_get_queue(Device.bdev);
+	void *buf = NULL;
+	struct request_queue *q = bdev_get_queue(bdev);
+	if (!q) {
+		prk_err("bdev_get_queue() failed");
+		return -EFAULT;
+	}
+
+	prk_info("test_bio_split");
 
 	if (copy_from_user(&inter, uptr, sizeof(tbio_interface_t))) {
-		printk("tbio: copy_from_user\n");
+		prk_err("copy_from_user");
 		return -EFAULT;
 	}
 
-	if (inter.data_len > (q->max_sectors << 9)) {
-		printk("tbio: inter.in_len > q->max_sectors << 9\n");
+	if (inter.data_len > (q->limits.max_sectors << 9)) {
+		prk_err("inter.in_len > q->limits.max_sectors << 9");
 		return -EIO;
 	}
 
+	prk_info("inter.data_len is %d", inter.data_len);
 	if (inter.data_len) {
 
 		switch (inter.direction) {
@@ -346,27 +316,27 @@ static int test_bio_split(struct block_device *bdev,
 			break;
 		}
 
-		bio = bio_map_user(bdev, (unsigned long)inter.data,
-				   inter.data_len, reading);
+		bio = bio_map_user(q, bdev, (unsigned long)inter.data,
+			inter.data_len, reading, GFP_KERNEL);
 
 		if (!bio) {
-			printk("tbio : bio_map_user failed\n");
-			buffer =
-			    kmalloc(inter.data_len, q->bounce_gfp | GFP_USER);
-			if (!buffer) {
-				printk("tbio: buffer no memory\n");
+			prk_err("bio_map_user failed");
+			buf = kmalloc(inter.data_len, q->bounce_gfp | GFP_USER);
+			if (!buf) {
+				prk_err("buffer no memory");
 				return -1;
 			}
-			copy_from_user(buffer, inter.data, inter.data_len);
-			printk("tbio: buffer %s\n", (char *)buffer);
+			ret = copy_from_user(buf, inter.data, inter.data_len);
+			if (ret)
+				prk_err("copy_from_user() failed");
+
+			prk_info("buffer %s", (char *)buf);
 		} else {
-			//              printk("tbio: bio sectors %d\n", bio_sectors(bio));
-			//              printk("tbio: split now\n");
-			bio_pairp = bio_split(bio, bio_split_pool, 2);
+			bio_pairp = bio_split(bio, 2);
 
 			if (bio_pairp == NULL) {
-				printk("tbio: bio_split failed\n");
-				bio_unmap_user(bio, reading);
+				prk_err("bio_split failed");
+				bio_unmap_user(bio);
 				return -1;
 			}
 		}
@@ -374,139 +344,141 @@ static int test_bio_split(struct block_device *bdev,
 	}
 
 	send_request(q, &(bio_pairp->bio1), bdev, &inter, writing);
-	q = bdev_get_queue(Device.bdev);
+	q = bdev_get_queue(bdev);
 	send_request(q, &(bio_pairp->bio2), bdev, &inter, writing);
 
-	if (bio_pairp) {
+	if (bio_pairp)
 		bio_pair_release(bio_pairp);
-		return 0;
-	}
 
 	if (bio)
-		bio_unmap_user(bio, reading);
+		bio_unmap_user(bio);
 
 	return 0;
-
 }
 
 static int test_bio_get_nr_vecs(void)
 {
 	int number = 0;
 
-	if (!tbiop) {
-		printk("tbio: tbiop is NULL\n");
-		return -1;
-	}
-
-	number = bio_get_nr_vecs(tbiop->bi_bdev);
+	number = bio_get_nr_vecs(tbio_dev.bdev);
 
 	if (number < 0) {
-		printk("tbio: bio_get_nr_vec failed\n");
+		prk_err("bio_get_nr_vec failed");
 		return -1;
 	}
-	//printk("bio_get_nr_vecs: %d\n",number);
+
+	prk_info("bio_get_nr_vecs: %d", number);
 	return 0;
 }
 
-static int tbio_ioctl(struct inode *ino, struct file *file,
-		      unsigned int cmd, unsigned long arg)
+static int tbio_ioctl(struct block_device *blk, fmode_t mode,
+	unsigned cmd, unsigned long arg)
 {
-	int err;
-//      request_queue_t *q;
-
-	//q = bdev_get_queue(Device.bdev);
+	int err = 0;
 
-	printk("ttbio: ioctl 0x%x 0x%lx\n", cmd, arg);
+	tbio_dev.bdev = blkdev_get_by_path(
+		DEVICE_NAME, FMODE_READ | FMODE_WRITE, NULL);
 
 	switch (cmd) {
 	case LTP_TBIO_DO_IO:
-		{
-			err = bd_claim(Device.bdev, current);
-			if (err) {
-				printk("tbio:bd_claim\n");
-				break;
-			}
-
-			err =
-			    tbio_io(Device.bdev, (struct tbio_interface *)arg);
-			bd_release(Device.bdev);
-		}
-		break;
-
+		prk_info("TEST-CASE: LTP_TBIO_DO_IO:");
+		err = tbio_io(tbio_dev.bdev, (struct tbio_interface *)arg);
+	break;
 	case LTP_TBIO_CLONE:
+		prk_info("TEST-CASE: LTP_TBIO_CLONE:");
 		err = test_bio_clone();
 		break;
 	case LTP_TBIO_ADD_PAGE:
+		prk_info("TEST-CASE: LTP_TBIO_ADD_PAGE:");
 		err = test_bio_add_page();
 		break;
 	case LTP_TBIO_ALLOC:
+		prk_info("TEST-CASE: LTP_TBIO_ALLOC:");
 		err = test_bio_alloc();
 		break;
 	case LTP_TBIO_GET_NR_VECS:
+		prk_info("TEST-CASE: LTP_TBIO_GET_NR_VECS:");
 		err = test_bio_get_nr_vecs();
 		break;
 	case LTP_TBIO_PUT:
+		prk_info("TEST-CASE: LTP_TBIO_PUT:");
 		err = test_bio_put(tbiop);
 		break;
 	case LTP_TBIO_SPLIT:
-		{
-			err = bd_claim(Device.bdev, current);
-			if (err) {
-				printk("tbio:bd_claim\n");
-				break;
-			}
-
-			err =
-			    test_bio_split(Device.bdev,
-					   (struct tbio_interface *)arg);
-			bd_release(Device.bdev);
-
-		}
-		break;
-		//case LTP_TBIO_PAIR_RELEASE:     err = test_bio_pair_release();break;
-
+		prk_info("TEST-CASE: LTP_TBIO_SPLIT:");
+		err = test_bio_split(tbio_dev.bdev,
+			(struct tbio_interface *)arg);
+	break;
 	}
-	return 0;
+
+	prk_info("TEST-CASE DONE");
+	blkdev_put(tbio_dev.bdev, FMODE_READ | FMODE_WRITE);
+	return err;
 }
 
-static void tbio_transfer(struct request *req, struct tbio_device *dev)
+static int tbio_transfer(struct request *req, struct tbio_device *dev)
 {
+	unsigned int i = 0, offset = 0;
+	char *buf;
+	unsigned long flags;
+	size_t size;
+
+	struct bio_vec *bv;
+	struct req_iterator iter;
+
+	size = blk_rq_cur_bytes(req);
+	prk_info("bio req of size %zu:", size);
+	offset = blk_rq_pos(req) * 512;
+
+	rq_for_each_segment(bv, req, iter) {
+		size = bv->bv_len;
+		prk_info("%s bio(%u), segs(%u) sect(%u) pos(%lu) off(%u)",
+			(bio_data_dir(iter.bio) == READ) ? "READ" : "WRITE",
+			i, bio_segments(iter.bio), bio_sectors(iter.bio),
+			iter.bio->bi_sector, offset);
+
+		if (get_capacity(req->rq_disk) * 512 < offset) {
+			prk_info("Error, small capacity %zu, offset %u",
+				get_capacity(req->rq_disk) * 512,
+				offset);
+			continue;
+		}
 
-	struct bio *bio = req->bio;
-
-	//printk("tbio: bio_data(bio) %s\n" , (char *)bio_data(bio));
-	if (bio_data_dir(bio)) {
-		printk("tbio: write \"%s\" to dev\n", (char *)bio_data(bio));
-		memcpy(dev->data, bio_data(bio), bio->bi_size);
-	} else {
-		memcpy(bio_data(bio), dev->data, bio->bi_size);
-		printk("tbio: read \"%s\" from dev\n", (char *)bio_data(bio));
+		buf = bvec_kmap_irq(bv, &flags);
+		if (bio_data_dir(iter.bio) == WRITE)
+			memcpy(dev->data + offset, buf, size);
+		else
+			memcpy(buf, dev->data + offset, size);
+		offset += size;
+		flush_kernel_dcache_page(bv->bv_page);
+		bvec_kunmap_irq(buf, &flags);
+		++i;
 	}
 
+	return 0;
 }
 
-static void tbio_request(request_queue_t * q)
+static void tbio_request(struct request_queue *q)
 {
+	int ret = 0;
 	struct request *req;
 
-	while ((req = elv_next_request(q)) != NULL) {
+	while ((req = blk_fetch_request(q)) != NULL) {
+
+		ret = tbio_transfer(req, &tbio_dev);
 
-		tbio_transfer(req, &Device);
-		end_request(req, 1);
+		spin_unlock_irq(q->queue_lock);
+		blk_end_request_all(req, ret);
+		spin_lock_irq(q->queue_lock);
 	}
 }
 
-static int tbio_open(struct inode *inode, struct file *filep)
+static int tbio_open(struct block_device *blk, fmode_t mode)
 {
-	if (!Device.bdev) {
-		Device.bdev = inode->i_bdev;
-		//atomic_inc((atomic_t)&Device.bdev->bd_part_count);
-	}
-
 	return 0;
 }
 
-static int tbio_release(struct inode *inode, struct file *filep)
+static int tbio_release(struct gendisk *gd, fmode_t mode)
 {
 	return 0;
 }
@@ -521,7 +493,7 @@ int tbio_revalidate(struct gendisk *gd)
 	return 0;
 }
 
-static struct block_device_operations tbio_ops = {
+static const struct block_device_operations tbio_ops = {
 	.owner = THIS_MODULE,
 	.open = tbio_open,
 	.ioctl = tbio_ioctl,
@@ -532,58 +504,59 @@ static struct block_device_operations tbio_ops = {
 
 static int __init tbio_init(void)
 {
-	Device.size = nsectors * hardsect_size;
-	int result;
-	spin_lock_init(&Device.lock);
-	Device.data = vmalloc(Device.size);
-	if (Device.data == NULL)
-		return -ENOMEM;
-	Device.bdev = NULL;
+	tbio_dev.size = nsectors * 512;
 
-	result = register_blkdev(TBIO_MAJOR, DEVICE_NAME);	//, &tbio_ops);
-
-	printk(KERN_ALERT "LTP BIO: register_blkdev result=%d major %d\n",
-	       result, TBIO_MAJOR);
+	tbio_dev.data = vmalloc(tbio_dev.size);
+	if (tbio_dev.data == NULL)
+		return -ENOMEM;
+	strcpy(tbio_dev.data, "tbio data");
+	tbio_dev.bdev = NULL;
 
-	if (result <= 0) {
-		printk(KERN_WARNING "tbio:unable to get major number\n");
+	TBIO_MAJOR = register_blkdev(0, DEVICE_NAME);
+	if (TBIO_MAJOR <= 0) {
+		prk_err("unable to get major number");
 		goto out;
 	}
+	prk_info("register_blkdev major %d", TBIO_MAJOR);
 
-	Device.gd = alloc_disk(1);
-	if (!Device.gd)
+	spin_lock_init(&tbio_dev.lock);
+	tbio_dev.q = blk_init_queue(tbio_request, &tbio_dev.lock);
+	if (!tbio_dev.q) {
+		prk_err("failed to init queue");
 		goto out_unregister;
-	Device.gd->major = TBIO_MAJOR;
-	Device.gd->first_minor = 0;
-	Device.gd->fops = &tbio_ops;
-	Device.gd->private_data = &Device;
-	strcpy(Device.gd->disk_name, "tbio0");
-	set_capacity(Device.gd, nsectors);
-	blk_init_queue(tbio_request, &Device.lock);
-	Device.gd->queue = &Queue;
-	add_disk(Device.gd);
+	}
+
+	tbio_dev.gd = alloc_disk(1);
+	if (!tbio_dev.gd)
+		goto out_unregister;
+	tbio_dev.gd->major	= TBIO_MAJOR;
+	tbio_dev.gd->first_minor	= 0;
+	tbio_dev.gd->fops		= &tbio_ops;
+	tbio_dev.gd->private_data	= &tbio_dev;
+	tbio_dev.gd->queue	= tbio_dev.q;
+	strcpy(tbio_dev.gd->disk_name, "tbio");
+	set_capacity(tbio_dev.gd, nsectors);
+	tbio_dev.gd->queue->queuedata = tbio_dev.gd;
+
+	add_disk(tbio_dev.gd);
 
 	return 0;
 
 out_unregister:
-	unregister_chrdev(TBIO_MAJOR, "tbio");
+	unregister_blkdev(TBIO_MAJOR, DEVICE_NAME);
 out:
-	vfree(Device.data);
+	vfree(tbio_dev.data);
 	return -ENOMEM;
 }
+module_init(tbio_init);
 
 static void tbio_exit(void)
 {
-	if (Device.bdev) {
-		invalidate_bdev(Device.bdev, 1);
-		bdput(Device.bdev);
-	}
-
-	del_gendisk(Device.gd);
-	put_disk(Device.gd);
-	unregister_blkdev(TBIO_MAJOR, "tbio");
-	vfree(Device.data);
+	blk_cleanup_queue(tbio_dev.q);
+	del_gendisk(tbio_dev.gd);
+	put_disk(tbio_dev.gd);
+	unregister_blkdev(TBIO_MAJOR, DEVICE_NAME);
+	vfree(tbio_dev.data);
+	prk_info("exit");
 }
-
-module_init(tbio_init);
 module_exit(tbio_exit);
diff --git a/testcases/kernel/device-drivers/tbio/tbio_kernel/tbio.h b/testcases/kernel/device-drivers/tbio/tbio_kernel/tbio.h
index e650399..cf6df73 100644
--- a/testcases/kernel/device-drivers/tbio/tbio_kernel/tbio.h
+++ b/testcases/kernel/device-drivers/tbio/tbio_kernel/tbio.h
@@ -1,52 +1,27 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
-
  * In this header file keep all flags and other
  * structures that will be needed in both kernel
  * and user space. Specifically the ioctl flags
  * will go in here so that in user space a program
  * can specify flags for the ioctl call.
  *
- * module: tbio
- *  Copyright (c) International Business Machines  Corp., 2003
- *
- *  This program is free software;  you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *  the GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program;
- *
- *  FILE        : tbio.h
- *  USAGE       : kernel_space:./load_tbio.sh
- *                user_space  :./test_bio
- *
- *  DESCRIPTION : The module will test block i/o layer for kernel 2.5
- *  REQUIREMENTS:
- *                1) glibc 2.1.91 or above.
- *
  *  HISTORY     :
  *      11/19/2003 Kai Zhao (ltcd3@cn.ibm.com)
  *
@@ -55,9 +30,10 @@
  */
 
 #define TMOD_DRIVER_NAME	"ltp test block I/O layer module"
+#define TBIO_DEVICE_NAME	"ltp_tbio"
 #define DEVICE_NAME		"/dev/tbio"
 #define MAG_NUM			'k'
-#define TBIO_MAJOR      258
+int TBIO_MAJOR;
 
 #define TBIO_TO_DEV              1
 #define TBIO_FROM_DEV            2
@@ -86,11 +62,10 @@
  in_len, and in_data as the actual structure. */
 
 struct tbio_interface {
-	void  *data;         // input data
-	int     data_len;         // input data length
-	int     direction;      // read or write form DEV
-	unsigned char *cmd;     // read or write
-	int   cmd_len;          // length of cmd
+	void *data;	/* input data */
+	int data_len;	/* input data length */
+	int direction;	/* read or write form DEV */
+	char *cmd;	/* read or write */
+	int cmd_len;	/* length of cmd */
 };
 typedef struct tbio_interface tbio_interface_t;
-
diff --git a/testcases/kernel/device-drivers/tbio/tbio_user/.gitignore b/testcases/kernel/device-drivers/tbio/tbio_user/.gitignore
new file mode 100644
index 0000000..79076dc
--- /dev/null
+++ b/testcases/kernel/device-drivers/tbio/tbio_user/.gitignore
@@ -0,0 +1 @@
+/tbio
diff --git a/testcases/kernel/device-drivers/tbio/tbio_user/Makefile b/testcases/kernel/device-drivers/tbio/tbio_user/Makefile
index 9fe124e..6ba3465 100644
--- a/testcases/kernel/device-drivers/tbio/tbio_user/Makefile
+++ b/testcases/kernel/device-drivers/tbio/tbio_user/Makefile
@@ -1,9 +1,20 @@
+# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 
-CFLAGS += -O2 -Wall -W -g
-OBJS = tbio_ki.o user_tbio.o
+top_srcdir		?= ../../../../..
 
-test_bio: $(OBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@
-
-clean:
-	rm -f $(OBJS) test_bio
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c b/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
index d3e88d1..10479b7 100644
--- a/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
+++ b/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
@@ -1,21 +1,20 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
  * This is the main of your user space test program,
  * which will open the correct kernel bioule, find the
@@ -25,22 +24,6 @@
  * Use the ki_generic and other ki_testname functions
  * to abstract the calls from the main
  *
- * bioule: tbio
- *  Copyright (c) International Business Machines  Corp., 2003
- *
- *  This program is free software;  you can redistribute it and/or bioify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *  the GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program;
- *
  *  FILE        : user_tbio.c
  *  USAGE       : kernel_space:./load_tbio.sh
  *                user_space  :./test_bio
@@ -65,101 +48,104 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <linux/kernel.h>
+#include <unistd.h>
+#include <string.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "tst_module.h"
+
+#include "../tbio_kernel/tbio.h"
 
-#include "user_tbio.h"
-#include "../kernel_space/tbio.h"
+char *TCID = TBIO_DEVICE_NAME;
 
-static int tbio_fd = -1;	/* file descriptor */
+static const char module_name[]	= "ltp_tbio.ko";
+static int module_loaded;
+static int tbio_fd = -1;
 
-int tbioopen()
+void cleanup(void)
 {
 
-	dev_t devt;
-	struct stat st;
-	int rc = 0;
+	if (tbio_fd != -1) {
+		close(tbio_fd);
+		tbio_fd = -1;
+	}
 
-	devt = makedev(TBIO_MAJOR, 0);
+	if (module_loaded)
+		tst_module_unload(NULL, module_name);
 
-	if (rc) {
-		if (errno == ENOENT) {
-			/* dev node does not exist. */
-			rc = mkdir(DEVICE_NAME, (S_IFDIR | S_IRWXU |
-						 S_IRGRP | S_IXGRP |
-						 S_IROTH | S_IXOTH));
-		} else {
-			printf
-			    ("ERROR: Problem with Base dev directory.  Error code from stat() is %d\n\n",
-			     errno);
-		}
+	TEST_CLEANUP;
+}
 
-	} else {
-		if (!(st.st_mode & S_IFDIR)) {
-			rc = unlink(DEVICE_NAME);
-			if (!rc) {
-				rc = mkdir(DEVICE_NAME, (S_IFDIR | S_IRWXU |
-							 S_IRGRP | S_IXGRP |
-							 S_IROTH | S_IXOTH));
-			}
-		}
+
+void setup(void)
+{
+	tst_require_root(NULL);
+
+	if (tst_kvercmp(2, 6, 0) < 0) {
+		tst_brkm(TCONF, NULL,
+			"Test must be run with kernel 2.6 or newer");
 	}
 
+	tst_module_load(cleanup, module_name, NULL);
+	module_loaded = 1;
+
+	dev_t devt;
+	struct stat st;
+
+	SAFE_FILE_SCANF(cleanup, "/sys/class/block/tbio/dev",
+		"%d:0", &TBIO_MAJOR);
+
+	devt = makedev(TBIO_MAJOR, 0);
 	/*
 	 * Check for the /dev/tbase node, and create if it does not
 	 * exist.
 	 */
-	rc = stat(DEVICE_NAME, &st);
-	if (rc) {
+	errno = 0;
+	if (stat(DEVICE_NAME, &st)) {
 		if (errno == ENOENT) {
 			/* dev node does not exist */
-			rc = mknod(DEVICE_NAME,
-				   (S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP |
-				    S_IWGRP), devt);
+			if (mknod(DEVICE_NAME, S_IFCHR | S_IRUSR | S_IWUSR |
+				S_IRGRP | S_IWGRP, devt)) {
+				tst_brkm(TBROK | TERRNO, cleanup,
+					"mknod failed at %s:%d",
+					__FILE__, __LINE__);
+			}
 		} else {
-			printf
-			    ("ERROR:Problem with tbase device node directory.  Error code form stat() is %d\n\n",
-			     errno);
+			tst_brkm(TBROK | TERRNO, cleanup,
+				"problem with tbase device node directory");
 		}
-
 	} else {
 		/*
 		 * /dev/tbio CHR device exists.  Check to make sure it is for a
 		 * block device and that it has the right major and minor.
 		 */
 		if ((!(st.st_mode & S_IFCHR)) || (st.st_rdev != devt)) {
-
-			/* Recreate the dev node. */
-			rc = unlink(DEVICE_NAME);
-			if (!rc) {
-				rc = mknod(DEVICE_NAME,
-					   (S_IFCHR | S_IRUSR | S_IWUSR |
-					    S_IRGRP | S_IWGRP), devt);
+			/* Recreate the dev node */
+			if (!unlink(DEVICE_NAME)) {
+				if (mknod(DEVICE_NAME, S_IFCHR | S_IRUSR |
+					S_IWUSR | S_IRGRP | S_IWGRP, devt)) {
+					tst_brkm(TBROK | TERRNO, cleanup,
+						"mknod failed at %s:%d",
+						__FILE__, __LINE__);
+				}
+			} else {
+				tst_brkm(TBROK | TERRNO, cleanup,
+					"unlink failed");
 			}
 		}
 	}
 
 	tbio_fd = open(DEVICE_NAME, O_RDWR);
-
 	if (tbio_fd < 0) {
-		printf("ERROR: Open of device %s failed %d errno = %d\n",
-		       DEVICE_NAME, tbio_fd, errno);
-		return errno;
-	} else {
-		printf("Device opened successfully \n");
-		return 0;
+		tst_brkm(TBROK | TERRNO, cleanup, "open of %s failed",
+			DEVICE_NAME);
 	}
 
+	tst_resm(TINFO, "Device opened successfully ");
 }
 
-int tbioclose()
-{
-
-	if (tbio_fd != -1) {
-		close(tbio_fd);
-		tbio_fd = -1;
-	}
-
-	return 0;
-}
 
 int tbio_to_dev(int fd, int flag)
 {
@@ -169,16 +155,16 @@ int tbio_to_dev(int fd, int flag)
 	memset(&bif, 0, sizeof(tbio_interface_t));
 	rc = posix_memalign(&bif.data, 512, 1024);
 	if (rc) {
-		printf("posix_memalign failed\n");
+		tst_resm(TINFO, "posix_memalign failed");
 		return -1;
 	}
 
 	strcpy(bif.data, "User space data");
 	bif.data_len = 1024;
 	bif.direction = TBIO_TO_DEV;
-	bif.cmd = (char *)malloc(6);
+	bif.cmd = SAFE_MALLOC(cleanup, 6);
 	if (bif.cmd == NULL) {
-		printf("malloc cmd space failed\n");
+		tst_resm(TINFO, "malloc cmd space failed");
 		free(bif.data);
 		return -1;
 	}
@@ -189,7 +175,7 @@ int tbio_to_dev(int fd, int flag)
 	if (rc) {
 		free(bif.data);
 		free(bif.cmd);
-		printf("Ioctl error for TBIO_TO_DEV\n");
+		tst_resm(TINFO, "Ioctl error for TBIO_TO_DEV");
 		return rc;
 	}
 
@@ -208,7 +194,7 @@ int tbio_from_dev(int fd, int flag)
 	memset(&bif, 0, sizeof(tbio_interface_t));
 	rc = posix_memalign(&bif.data, 512, 1024);
 	if (rc) {
-		printf("posix_memalign failed\n");
+		tst_resm(TINFO, "posix_memalign failed");
 		return -1;
 	}
 
@@ -216,9 +202,9 @@ int tbio_from_dev(int fd, int flag)
 
 	bif.data_len = 1024;
 	bif.direction = TBIO_FROM_DEV;
-	bif.cmd = (char *)malloc(6);
+	bif.cmd = SAFE_MALLOC(cleanup, 6);
 	if (bif.cmd == NULL) {
-		printf("malloc cmd space failed\n");
+		tst_resm(TINFO, "malloc cmd space failed");
 		free(bif.data);
 		return -1;
 	}
@@ -229,12 +215,12 @@ int tbio_from_dev(int fd, int flag)
 	if (rc) {
 		free(bif.data);
 		free(bif.cmd);
-		printf("Ioctl error for TBIO_TO_DEV\n");
+		tst_resm(TINFO, "Ioctl error for TBIO_TO_DEV");
 		return rc;
 	}
-	//printf("read from dev %s\n",bif.data);
+
 	if (strcmp(bif.data, "User space data")) {
-		printf("TBIO_FROM_DEV failed\n");
+		tst_resm(TINFO, "TBIO_FROM_DEV failed");
 		free(bif.data);
 		free(bif.cmd);
 		return -1;
@@ -255,16 +241,16 @@ int tbio_split_to_dev(int fd, int flag)
 	memset(&bif, 0, sizeof(tbio_interface_t));
 	rc = posix_memalign(&bif.data, 512, 2048);
 	if (rc) {
-		printf("posix_memalign failed\n");
+		tst_resm(TINFO, "posix_memalign failed");
 		return -1;
 	}
 
 	strcpy(bif.data, "User space data");
 	bif.data_len = 2048;
 	bif.direction = TBIO_TO_DEV;
-	bif.cmd = (char *)malloc(6);
+	bif.cmd = SAFE_MALLOC(cleanup, 6);
 	if (bif.cmd == NULL) {
-		printf("malloc cmd space failed\n");
+		tst_resm(TINFO, "malloc cmd space failed");
 		free(bif.data);
 		return -1;
 	}
@@ -275,7 +261,7 @@ int tbio_split_to_dev(int fd, int flag)
 	if (rc) {
 		free(bif.data);
 		free(bif.cmd);
-		printf("Ioctl error for TBIO_TO_DEV\n");
+		tst_resm(TINFO, "Ioctl error for TBIO_TO_DEV");
 		return rc;
 	}
 
@@ -286,63 +272,63 @@ int tbio_split_to_dev(int fd, int flag)
 
 }
 
-int main()
+int ki_generic(int fd, int flag)
 {
-	int rc;
+	tbio_interface_t bif;
 
-	/* open the bioule */
-	rc = tbioopen();
-	if (rc) {
-		printf("Test bio Driver may not be loaded\n");
-		exit(1);
-	}
+	int rc = ioctl(fd, flag, &bif);
+	if (rc)
+		tst_resm(TINFO | TERRNO, "ioctl error");
+
+	return rc;
+}
+
+
+int main(void)
+{
+	setup();
 
 	if (ki_generic(tbio_fd, LTP_TBIO_ALLOC))
-		printf("Failed on LTP_TBIO_ALLOC test\n");
+		tst_resm(TFAIL, "failed on LTP_TBIO_ALLOC test");
 	else
-		printf("Success on LTP_TBIO_ALLOC test\n");
+		tst_resm(TPASS, "success on LTP_TBIO_ALLOC test");
 
 	if (ki_generic(tbio_fd, LTP_TBIO_CLONE))
-		printf("Failed on LTP_TBIO_CLONE test\n");
+		tst_resm(TFAIL, "failed on LTP_TBIO_CLONE test");
 	else
-		printf("Success on LTP_TBIO_CLONE test\n");
+		tst_resm(TPASS, "success on LTP_TBIO_CLONE test");
 
 	if (ki_generic(tbio_fd, LTP_TBIO_GET_NR_VECS))
-		printf("Failed on LTP_TBIO_GET_NR_VECS test\n");
+		tst_resm(TFAIL, "failed on LTP_TBIO_GET_NR_VECS test");
 	else
-		printf("Success on LTP_TBIO_GET_NR_VECS test\n");
+		tst_resm(TPASS, "success on LTP_TBIO_GET_NR_VECS test");
 
 	if (ki_generic(tbio_fd, LTP_TBIO_ADD_PAGE))
-		printf("Failed on LTP_TBIO_ADD_PAGE test\n");
+		tst_resm(TFAIL, "failed on LTP_TBIO_ADD_PAGE test");
 	else
-		printf("Success on LTP_TBIO_ADD_PAGE test\n");
+		tst_resm(TPASS, "success on LTP_TBIO_ADD_PAGE test");
 
 	if (tbio_split_to_dev(tbio_fd, LTP_TBIO_SPLIT))
-		printf("Failed on LTP_TBIO_SPLIT:write to dev\n");
+		tst_resm(TFAIL, "failed on LTP_TBIO_SPLIT:write to dev");
 	else
-		printf("Success on LTP_TBIO_SPLIT:write to dev\n");
+		tst_resm(TPASS, "success on LTP_TBIO_SPLIT:write to dev");
 
 	if (tbio_to_dev(tbio_fd, LTP_TBIO_DO_IO))
-		printf("Failed on LTP_TBIO_DO_IO:write to dev\n");
+		tst_resm(TFAIL, "failed on LTP_TBIO_DO_IO:write to dev");
 	else
-		printf("Success on LTP_TBIO_DO_IO:write to dev\n");
+		tst_resm(TPASS, "success on LTP_TBIO_DO_IO:write to dev");
 
 	if (tbio_from_dev(tbio_fd, LTP_TBIO_DO_IO))
-		printf("Failed on LTP_TBIO_DO_IO:read from dev\n");
+		tst_resm(TFAIL, "failed on LTP_TBIO_DO_IO:read from dev");
 	else
-		printf("Success on LTP_TBIO_DO_IO:read from dev\n");
+		tst_resm(TPASS, "success on LTP_TBIO_DO_IO:read from dev");
 
 	if (ki_generic(tbio_fd, LTP_TBIO_PUT))
-		printf("Failed on LTP_TBIO_PUT test\n");
+		tst_resm(TFAIL, "failed on LTP_TBIO_PUT test");
 	else
-		printf("Success on LTP_TBIO_PUT test\n");
+		tst_resm(TPASS, "success on LTP_TBIO_PUT test");
 
-	/* close the bioule */
-	rc = tbioclose();
-	if (rc) {
-		printf("Test bio Driver may not be closed\n");
-		exit(1);
-	}
+	cleanup();
 
-	return 0;
+	tst_exit();
 }
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
