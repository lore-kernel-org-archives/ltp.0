Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1VX6XZ-0001rH-3z
	for ltp-list@lists.sourceforge.net; Fri, 18 Oct 2013 09:40:17 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VX6XV-00076W-3K
	for ltp-list@lists.sourceforge.net; Fri, 18 Oct 2013 09:40:17 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r9I9e6Wg000317
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Oct 2013 09:40:07 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9I9e61S005862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Oct 2013 09:40:06 GMT
Received: from abhmt102.oracle.com (abhmt102.oracle.com [141.146.116.54])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9I9e6vw005856
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Oct 2013 09:40:06 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 18 Oct 2013 13:39:43 +0400
Message-Id: <1382089184-21140-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 1/2] device-drivers: tbio: rearrange test files
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

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 .../device-drivers/tbio/kernel_space/Makefile      |   22 -
 .../device-drivers/tbio/kernel_space/load_tbio.sh  |    5 -
 .../device-drivers/tbio/kernel_space/str_tbio.h    |   39 --
 .../kernel/device-drivers/tbio/kernel_space/tbio.c |  589 --------------------
 .../kernel/device-drivers/tbio/kernel_space/tbio.h |   96 ----
 .../device-drivers/tbio/tbio_kernel/Makefile       |   22 +
 .../device-drivers/tbio/tbio_kernel/ltp_tbio.c     |  589 ++++++++++++++++++++
 .../device-drivers/tbio/tbio_kernel/str_tbio.h     |   39 ++
 .../kernel/device-drivers/tbio/tbio_kernel/tbio.h  |   96 ++++
 .../kernel/device-drivers/tbio/tbio_user/Makefile  |    9 +
 .../kernel/device-drivers/tbio/tbio_user/tbio.c    |  348 ++++++++++++
 .../kernel/device-drivers/tbio/user_space/Makefile |    9 -
 .../device-drivers/tbio/user_space/tbio_ki.c       |   86 ---
 .../device-drivers/tbio/user_space/user_tbio.c     |  348 ------------
 .../device-drivers/tbio/user_space/user_tbio.h     |   22 -
 15 files changed, 1103 insertions(+), 1216 deletions(-)
 delete mode 100644 testcases/kernel/device-drivers/tbio/kernel_space/Makefile
 delete mode 100755 testcases/kernel/device-drivers/tbio/kernel_space/load_tbio.sh
 delete mode 100644 testcases/kernel/device-drivers/tbio/kernel_space/str_tbio.h
 delete mode 100644 testcases/kernel/device-drivers/tbio/kernel_space/tbio.c
 delete mode 100644 testcases/kernel/device-drivers/tbio/kernel_space/tbio.h
 create mode 100644 testcases/kernel/device-drivers/tbio/tbio_kernel/Makefile
 create mode 100644 testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c
 create mode 100644 testcases/kernel/device-drivers/tbio/tbio_kernel/str_tbio.h
 create mode 100644 testcases/kernel/device-drivers/tbio/tbio_kernel/tbio.h
 create mode 100644 testcases/kernel/device-drivers/tbio/tbio_user/Makefile
 create mode 100644 testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
 delete mode 100644 testcases/kernel/device-drivers/tbio/user_space/Makefile
 delete mode 100644 testcases/kernel/device-drivers/tbio/user_space/tbio_ki.c
 delete mode 100644 testcases/kernel/device-drivers/tbio/user_space/user_tbio.c
 delete mode 100644 testcases/kernel/device-drivers/tbio/user_space/user_tbio.h

diff --git a/testcases/kernel/device-drivers/tbio/kernel_space/Makefile b/testcases/kernel/device-drivers/tbio/kernel_space/Makefile
deleted file mode 100644
index 2bbd1f5..0000000
--- a/testcases/kernel/device-drivers/tbio/kernel_space/Makefile
+++ /dev/null
@@ -1,22 +0,0 @@
-#
-# Makefile for GCOV profiling kernel module
-#
-
-#KERNELDIR := /usr/src/linux-2.5.64-gcov
-EXTRA_CFLAGS := -Wall
-
-ifneq ($(KERNELRELEASE),)
-
-obj-m	:= tbio.o
-else
-KDIR	:= /lib/modules/$(shell uname -r)/build
-PWD	:= $(shell pwd)
-
-default:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
-#	$(MAKE) -C $(KERNELDIR) SUBDIRS=$(PWD) modules
-endif
-
-clean:
-	rm -f *.o rm -f .*.cmd rm -f *.bb* rm -f *.ko rm -f *.mod.* 2>/dev/null || true
-
diff --git a/testcases/kernel/device-drivers/tbio/kernel_space/load_tbio.sh b/testcases/kernel/device-drivers/tbio/kernel_space/load_tbio.sh
deleted file mode 100755
index 724bd65..0000000
--- a/testcases/kernel/device-drivers/tbio/kernel_space/load_tbio.sh
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/sh
-insmod -f ./tbio.ko || insmod -f ./tbio.o || exit 1
-rm -f /dev/tbio0
-major=`awk '/tbio/{print \$1}' /proc/devices`
-mknod /dev/tbio0 b $major 0
diff --git a/testcases/kernel/device-drivers/tbio/kernel_space/str_tbio.h b/testcases/kernel/device-drivers/tbio/kernel_space/str_tbio.h
deleted file mode 100644
index dc74d6f..0000000
--- a/testcases/kernel/device-drivers/tbio/kernel_space/str_tbio.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
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
- *
-
- * Remember that you want to seperate your header
- * files between what is needed in kernel space
- * only, and what will also be needed by a user
- * space program that is using this module. For
- * that reason keep all structures that will need
- * kernel space pointers in a seperate header file
- * from where ioctl flags aer kept
- *
- * author: Sean Ruyle
- * date:   06/11/2003
- *
- */
-
-struct ltpmod_user {
-
-//put any pointers in here that might be needed by other ioctl calls
-
-};
-typedef struct ltpmod_user ltpmod_user_t;
-
diff --git a/testcases/kernel/device-drivers/tbio/kernel_space/tbio.c b/testcases/kernel/device-drivers/tbio/kernel_space/tbio.c
deleted file mode 100644
index 447d223..0000000
--- a/testcases/kernel/device-drivers/tbio/kernel_space/tbio.c
+++ /dev/null
@@ -1,589 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
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
- *
-
- * This module will test block io layer.
- *
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
- *  FILE        : tbio.c
- *  USAGE       : kernel_space:./load_tbio.sh
- *                user_space  :./test_bio
- *
- *  DESCRIPTION : The module will test block i/o layer for kernel 2.5
- *  REQUIREMENTS:
- *                1) glibc 2.1.91 or above.
- *
- *  HISTORY     :
- *      11/19/2003 Kai Zhao (ltcd3@cn.ibm.com)
- *
- *  CODE COVERAGE: 74.9% - fs/bio.c (Total Coverage)
- *
- */
-
-#ifndef __KERNEL__
-#define __KERNEL__
-#endif
-
-#include <linux/module.h>
-//#include <linux/moduleparam.h>
-#include <linux/init.h>
-
-#include <linux/kernel.h>
-#include <linux/fs.h>
-#include <linux/errno.h>
-#include <linux/types.h>
-#include <linux/vmalloc.h>
-#include <linux/genhd.h>
-#include <linux/blkdev.h>
-#include <linux/buffer_head.h>
-#include "tbio.h"
-
-#define BLK_DEFAULT_TIMEOUT	(60 * HZ)
-MODULE_AUTHOR("Kai Zhao <ltcd3@cn.ibm.com>");
-MODULE_DESCRIPTION(TMOD_DRIVER_NAME);
-MODULE_LICENSE("GPL");
-
-//module_param(major_num , int , 0);
-static int hardsect_size = 1024;
-//module_param(hardsect_size , int , 0);
-static int nsectors = 1024;
-//module_param(nsectors , int , 0);
-
-static struct bio *tbiop = NULL, *tbiop_dup = NULL;
-//static struct bio_pair *bio_pairp = NULL;
-static struct request_queue Queue;
-
-static struct tbio_device {
-	unsigned long size;
-	spinlock_t lock;
-	u8 *data;
-	struct gendisk *gd;
-	struct block_device *bdev;
-} Device;
-
-static int send_request(request_queue_t * q, struct bio *bio,
-			struct block_device *bdev, struct tbio_interface *inter,
-			int writing)
-{
-	struct request *rq;
-	void *buffer = NULL;
-	unsigned long start_time;
-	int err;
-
-	rq = blk_get_request(q, writing ? WRITE : READ, __GFP_WAIT);
-	rq->cmd_len = inter->cmd_len;
-	//printk("inter.cmd %s\n" , inter->cmd);
-	if (copy_from_user(rq->cmd, inter->cmd, inter->cmd_len))
-		goto out_request;
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
-
-	rq->timeout = 0;
-	if (!rq->timeout)
-		rq->timeout = q->sg_timeout;
-	if (!rq->timeout)
-		rq->timeout = BLK_DEFAULT_TIMEOUT;
-
-	start_time = jiffies;
-
-	DECLARE_COMPLETION(wait);
-
-	rq->rq_disk = bdev->bd_disk;
-
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
-
-	blk_put_request(rq);
-
-	return 0;
-out_request:
-	blk_put_request(rq);
-	return -EFAULT;
-
-}
-
-static int tbio_io(struct block_device *bdev, struct tbio_interface *uptr)
-{
-	tbio_interface_t inter;
-	struct bio *bio = NULL;
-	int reading = 0, writing = 0;
-	void *buffer = NULL;
-	//struct request *rq;
-	request_queue_t *q;
-	q = bdev_get_queue(Device.bdev);
-
-	if (copy_from_user(&inter, uptr, sizeof(tbio_interface_t))) {
-		printk("tbio: copy_from_user\n");
-		return -EFAULT;
-	}
-
-	if (inter.data_len > (q->max_sectors << 9)) {
-		printk("tbio: inter.in_len > q->max_sectors << 9\n");
-		return -EIO;
-	}
-
-	if (inter.data_len) {
-
-		switch (inter.direction) {
-		default:
-			return -EINVAL;
-		case TBIO_TO_DEV:
-			writing = 1;
-			break;
-		case TBIO_FROM_DEV:
-			reading = 1;
-			break;
-		}
-
-		bio = bio_map_user(bdev, (unsigned long)inter.data,
-				   inter.data_len, reading);
-
-		if (!bio) {
-			printk("tbio : bio_map_user failed\n");
-			buffer =
-			    kmalloc(inter.data_len, q->bounce_gfp | GFP_USER);
-			if (!buffer) {
-				printk("tbio: buffer no memory\n");
-				return -1;
-			}
-			copy_from_user(buffer, inter.data, inter.data_len);
-			printk("tbio: buffer %s\n", (char *)buffer);
-		}
-
-	}
-
-	send_request(q, bio, bdev, &inter, writing);
-
-	if (bio)
-		bio_unmap_user(bio, reading);
-	return 0;
-}
-
-static int test_bio_put(struct bio *biop)
-{
-
-	if (biop)
-		bio_put(biop);
-
-	return 0;
-}
-
-static int test_bio_clone(void)
-{
-	tbiop_dup = bio_clone(tbiop, GFP_NOIO);
-	if (tbiop_dup == NULL) {
-		printk("tbio: bio_clone failed\n");
-		return -1;
-	}
-
-	test_bio_put(tbiop_dup);
-
-	return 0;
-}
-
-static int test_bio_add_page(void)
-{
-	int res = 0, i = 0, offset = 0;
-	unsigned long addr = 0;
-	struct page *ppage = NULL;
-
-	for (i = 0; i < 128; i++) {
-
-		addr = get_zeroed_page(GFP_KERNEL);
-
-		if (addr == 0) {
-			printk("tbio: get free page failed %ld\n", addr);
-			return -1;
-		}
-
-		ppage = virt_to_page(addr);
-		if (ppage == NULL) {
-			printk
-			    ("tbio: covert virture page to page struct failed\n");
-			return -1;
-		}
-
-		res = bio_add_page(tbiop, ppage, PAGE_SIZE, offset);
-		if (res < 0) {
-			printk("bio_add_page :res %d\n", res);
-			return -1;
-		}
-		offset += res;
-		//      printk ("tbio: bio_add_page : %d\n", res);
-	}
-	return 0;
-}
-
-static int test_do_bio_alloc(int num)
-{
-	tbiop = bio_alloc(GFP_KERNEL, num);
-	if (tbiop == NULL) {
-		printk("tbio: bio_alloc failed\n");
-		return -1;
-	}
-	bio_put(tbiop);
-
-	return 0;
-}
-
-static int test_bio_alloc(void)
-{
-	int res = 0;
-	res = test_do_bio_alloc(2);
-	if (res < 0) {
-		printk("can not alloc bio for %d\n", 2);
-		return -1;
-	}
-
-	res = test_do_bio_alloc(8);
-	if (res < 0) {
-		printk("can not alloc bio for %d\n", 8);
-		return -1;
-	}
-	res = test_do_bio_alloc(32);
-	if (res < 0) {
-		printk("can not alloc bio for %d\n", 32);
-		return -1;
-	}
-	res = test_do_bio_alloc(96);
-	if (res < 0) {
-		printk("can not alloc bio for %d\n", 96);
-		return -1;
-	}
-	res = test_do_bio_alloc(BIO_MAX_PAGES);
-	if (res < 0) {
-		printk("can not alloc bio for %d\n", BIO_MAX_PAGES);
-		return -1;
-	}
-
-	tbiop = bio_alloc(GFP_KERNEL, BIO_MAX_PAGES);
-	if (tbiop == NULL) {
-		printk("tbio: bio_alloc failed\n");
-		return -1;
-	}
-
-	return 0;
-}
-
-static int test_bio_split(struct block_device *bdev,
-			  struct tbio_interface *uptr)
-{
-	tbio_interface_t inter;
-	struct bio *bio = NULL;
-	struct bio_pair *bio_pairp = NULL;
-	int reading = 0, writing = 0;
-	void *buffer = NULL;
-	request_queue_t *q;
-	q = bdev_get_queue(Device.bdev);
-
-	if (copy_from_user(&inter, uptr, sizeof(tbio_interface_t))) {
-		printk("tbio: copy_from_user\n");
-		return -EFAULT;
-	}
-
-	if (inter.data_len > (q->max_sectors << 9)) {
-		printk("tbio: inter.in_len > q->max_sectors << 9\n");
-		return -EIO;
-	}
-
-	if (inter.data_len) {
-
-		switch (inter.direction) {
-		default:
-			return -EINVAL;
-		case TBIO_TO_DEV:
-			writing = 1;
-			break;
-		case TBIO_FROM_DEV:
-			reading = 1;
-			break;
-		}
-
-		bio = bio_map_user(bdev, (unsigned long)inter.data,
-				   inter.data_len, reading);
-
-		if (!bio) {
-			printk("tbio : bio_map_user failed\n");
-			buffer =
-			    kmalloc(inter.data_len, q->bounce_gfp | GFP_USER);
-			if (!buffer) {
-				printk("tbio: buffer no memory\n");
-				return -1;
-			}
-			copy_from_user(buffer, inter.data, inter.data_len);
-			printk("tbio: buffer %s\n", (char *)buffer);
-		} else {
-			//              printk("tbio: bio sectors %d\n", bio_sectors(bio));
-			//              printk("tbio: split now\n");
-			bio_pairp = bio_split(bio, bio_split_pool, 2);
-
-			if (bio_pairp == NULL) {
-				printk("tbio: bio_split failed\n");
-				bio_unmap_user(bio, reading);
-				return -1;
-			}
-		}
-
-	}
-
-	send_request(q, &(bio_pairp->bio1), bdev, &inter, writing);
-	q = bdev_get_queue(Device.bdev);
-	send_request(q, &(bio_pairp->bio2), bdev, &inter, writing);
-
-	if (bio_pairp) {
-		bio_pair_release(bio_pairp);
-		return 0;
-	}
-
-	if (bio)
-		bio_unmap_user(bio, reading);
-
-	return 0;
-
-}
-
-static int test_bio_get_nr_vecs(void)
-{
-	int number = 0;
-
-	if (!tbiop) {
-		printk("tbio: tbiop is NULL\n");
-		return -1;
-	}
-
-	number = bio_get_nr_vecs(tbiop->bi_bdev);
-
-	if (number < 0) {
-		printk("tbio: bio_get_nr_vec failed\n");
-		return -1;
-	}
-	//printk("bio_get_nr_vecs: %d\n",number);
-	return 0;
-}
-
-static int tbio_ioctl(struct inode *ino, struct file *file,
-		      unsigned int cmd, unsigned long arg)
-{
-	int err;
-//      request_queue_t *q;
-
-	//q = bdev_get_queue(Device.bdev);
-
-	printk("ttbio: ioctl 0x%x 0x%lx\n", cmd, arg);
-
-	switch (cmd) {
-	case LTP_TBIO_DO_IO:
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
-	case LTP_TBIO_CLONE:
-		err = test_bio_clone();
-		break;
-	case LTP_TBIO_ADD_PAGE:
-		err = test_bio_add_page();
-		break;
-	case LTP_TBIO_ALLOC:
-		err = test_bio_alloc();
-		break;
-	case LTP_TBIO_GET_NR_VECS:
-		err = test_bio_get_nr_vecs();
-		break;
-	case LTP_TBIO_PUT:
-		err = test_bio_put(tbiop);
-		break;
-	case LTP_TBIO_SPLIT:
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
-	}
-	return 0;
-}
-
-static void tbio_transfer(struct request *req, struct tbio_device *dev)
-{
-
-	struct bio *bio = req->bio;
-
-	//printk("tbio: bio_data(bio) %s\n" , (char *)bio_data(bio));
-	if (bio_data_dir(bio)) {
-		printk("tbio: write \"%s\" to dev\n", (char *)bio_data(bio));
-		memcpy(dev->data, bio_data(bio), bio->bi_size);
-	} else {
-		memcpy(bio_data(bio), dev->data, bio->bi_size);
-		printk("tbio: read \"%s\" from dev\n", (char *)bio_data(bio));
-	}
-
-}
-
-static void tbio_request(request_queue_t * q)
-{
-	struct request *req;
-
-	while ((req = elv_next_request(q)) != NULL) {
-
-		tbio_transfer(req, &Device);
-		end_request(req, 1);
-	}
-}
-
-static int tbio_open(struct inode *inode, struct file *filep)
-{
-	if (!Device.bdev) {
-		Device.bdev = inode->i_bdev;
-		//atomic_inc((atomic_t)&Device.bdev->bd_part_count);
-	}
-
-	return 0;
-}
-
-static int tbio_release(struct inode *inode, struct file *filep)
-{
-	return 0;
-}
-
-int tbio_media_changed(struct gendisk *gd)
-{
-	return 0;
-}
-
-int tbio_revalidate(struct gendisk *gd)
-{
-	return 0;
-}
-
-static struct block_device_operations tbio_ops = {
-	.owner = THIS_MODULE,
-	.open = tbio_open,
-	.ioctl = tbio_ioctl,
-	.release = tbio_release,
-	.media_changed = tbio_media_changed,
-	.revalidate_disk = tbio_revalidate
-};
-
-static int __init tbio_init(void)
-{
-	Device.size = nsectors * hardsect_size;
-	int result;
-	spin_lock_init(&Device.lock);
-	Device.data = vmalloc(Device.size);
-	if (Device.data == NULL)
-		return -ENOMEM;
-	Device.bdev = NULL;
-
-	result = register_blkdev(TBIO_MAJOR, DEVICE_NAME);	//, &tbio_ops);
-
-	printk(KERN_ALERT "LTP BIO: register_blkdev result=%d major %d\n",
-	       result, TBIO_MAJOR);
-
-	if (result <= 0) {
-		printk(KERN_WARNING "tbio:unable to get major number\n");
-		goto out;
-	}
-
-	Device.gd = alloc_disk(1);
-	if (!Device.gd)
-		goto out_unregister;
-	Device.gd->major = TBIO_MAJOR;
-	Device.gd->first_minor = 0;
-	Device.gd->fops = &tbio_ops;
-	Device.gd->private_data = &Device;
-	strcpy(Device.gd->disk_name, "tbio0");
-	set_capacity(Device.gd, nsectors);
-	blk_init_queue(tbio_request, &Device.lock);
-	Device.gd->queue = &Queue;
-	add_disk(Device.gd);
-
-	return 0;
-
-out_unregister:
-	unregister_chrdev(TBIO_MAJOR, "tbio");
-out:
-	vfree(Device.data);
-	return -ENOMEM;
-}
-
-static void tbio_exit(void)
-{
-	if (Device.bdev) {
-		invalidate_bdev(Device.bdev, 1);
-		bdput(Device.bdev);
-	}
-
-	del_gendisk(Device.gd);
-	put_disk(Device.gd);
-	unregister_blkdev(TBIO_MAJOR, "tbio");
-	vfree(Device.data);
-}
-
-module_init(tbio_init);
-module_exit(tbio_exit);
diff --git a/testcases/kernel/device-drivers/tbio/kernel_space/tbio.h b/testcases/kernel/device-drivers/tbio/kernel_space/tbio.h
deleted file mode 100644
index e650399..0000000
--- a/testcases/kernel/device-drivers/tbio/kernel_space/tbio.h
+++ /dev/null
@@ -1,96 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
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
- *
-
- * In this header file keep all flags and other
- * structures that will be needed in both kernel
- * and user space. Specifically the ioctl flags
- * will go in here so that in user space a program
- * can specify flags for the ioctl call.
- *
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
- *  HISTORY     :
- *      11/19/2003 Kai Zhao (ltcd3@cn.ibm.com)
- *
- *  CODE COVERAGE: 74.9% - fs/bio.c (Total Coverage)
- *
- */
-
-#define TMOD_DRIVER_NAME	"ltp test block I/O layer module"
-#define DEVICE_NAME		"/dev/tbio"
-#define MAG_NUM			'k'
-#define TBIO_MAJOR      258
-
-#define TBIO_TO_DEV              1
-#define TBIO_FROM_DEV            2
-
-/* put ioctl flags here, use the _IO macro which is
- found in linux/ioctl.h, takes a letter, and an
- integer */
-
-#define LTP_TBIO_CLONE		_IO(MAG_NUM,1)
-#define LTP_TBIO_ALLOC		_IO(MAG_NUM,2)
-#define LTP_TBIO_GET_NR_VECS	_IO(MAG_NUM,3)
-#define LTP_TBIO_PUT		_IO(MAG_NUM,4)
-#define LTP_TBIO_SPLIT		_IO(MAG_NUM,5)
-#define LTP_TBIO_DO_IO		_IO(MAG_NUM,6)
-#define LTP_TBIO_ADD_PAGE	_IO(MAG_NUM,7)
-
-/* memory between the kernel and user space is
- seperated, so that if a structure is needed
- to be passed between kernel and user space
- a call must be made to copy_to_user or copy
- from user. Use this structure to streamline
- that process. For example: A function that
- writes to a disc takes in a ki_write_t
- pointer from userspace. In the user space
- program specify the length of the pointer as
- in_len, and in_data as the actual structure. */
-
-struct tbio_interface {
-	void  *data;         // input data
-	int     data_len;         // input data length
-	int     direction;      // read or write form DEV
-	unsigned char *cmd;     // read or write
-	int   cmd_len;          // length of cmd
-};
-typedef struct tbio_interface tbio_interface_t;
-
diff --git a/testcases/kernel/device-drivers/tbio/tbio_kernel/Makefile b/testcases/kernel/device-drivers/tbio/tbio_kernel/Makefile
new file mode 100644
index 0000000..2bbd1f5
--- /dev/null
+++ b/testcases/kernel/device-drivers/tbio/tbio_kernel/Makefile
@@ -0,0 +1,22 @@
+#
+# Makefile for GCOV profiling kernel module
+#
+
+#KERNELDIR := /usr/src/linux-2.5.64-gcov
+EXTRA_CFLAGS := -Wall
+
+ifneq ($(KERNELRELEASE),)
+
+obj-m	:= tbio.o
+else
+KDIR	:= /lib/modules/$(shell uname -r)/build
+PWD	:= $(shell pwd)
+
+default:
+	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
+#	$(MAKE) -C $(KERNELDIR) SUBDIRS=$(PWD) modules
+endif
+
+clean:
+	rm -f *.o rm -f .*.cmd rm -f *.bb* rm -f *.ko rm -f *.mod.* 2>/dev/null || true
+
diff --git a/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c b/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c
new file mode 100644
index 0000000..447d223
--- /dev/null
+++ b/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c
@@ -0,0 +1,589 @@
+/*
+ *
+ *   Copyright (c) International Business Machines  Corp., 2001
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+
+ * This module will test block io layer.
+ *
+ * module: tbio
+ *  Copyright (c) International Business Machines  Corp., 2003
+ *
+ *  This program is free software;  you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *  the GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program;
+ *
+ *  FILE        : tbio.c
+ *  USAGE       : kernel_space:./load_tbio.sh
+ *                user_space  :./test_bio
+ *
+ *  DESCRIPTION : The module will test block i/o layer for kernel 2.5
+ *  REQUIREMENTS:
+ *                1) glibc 2.1.91 or above.
+ *
+ *  HISTORY     :
+ *      11/19/2003 Kai Zhao (ltcd3@cn.ibm.com)
+ *
+ *  CODE COVERAGE: 74.9% - fs/bio.c (Total Coverage)
+ *
+ */
+
+#ifndef __KERNEL__
+#define __KERNEL__
+#endif
+
+#include <linux/module.h>
+//#include <linux/moduleparam.h>
+#include <linux/init.h>
+
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/vmalloc.h>
+#include <linux/genhd.h>
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include "tbio.h"
+
+#define BLK_DEFAULT_TIMEOUT	(60 * HZ)
+MODULE_AUTHOR("Kai Zhao <ltcd3@cn.ibm.com>");
+MODULE_DESCRIPTION(TMOD_DRIVER_NAME);
+MODULE_LICENSE("GPL");
+
+//module_param(major_num , int , 0);
+static int hardsect_size = 1024;
+//module_param(hardsect_size , int , 0);
+static int nsectors = 1024;
+//module_param(nsectors , int , 0);
+
+static struct bio *tbiop = NULL, *tbiop_dup = NULL;
+//static struct bio_pair *bio_pairp = NULL;
+static struct request_queue Queue;
+
+static struct tbio_device {
+	unsigned long size;
+	spinlock_t lock;
+	u8 *data;
+	struct gendisk *gd;
+	struct block_device *bdev;
+} Device;
+
+static int send_request(request_queue_t * q, struct bio *bio,
+			struct block_device *bdev, struct tbio_interface *inter,
+			int writing)
+{
+	struct request *rq;
+	void *buffer = NULL;
+	unsigned long start_time;
+	int err;
+
+	rq = blk_get_request(q, writing ? WRITE : READ, __GFP_WAIT);
+	rq->cmd_len = inter->cmd_len;
+	//printk("inter.cmd %s\n" , inter->cmd);
+	if (copy_from_user(rq->cmd, inter->cmd, inter->cmd_len))
+		goto out_request;
+	//printk("tbio: rq->cmd : %s\n",rq->cmd);
+	if (sizeof(rq->cmd) != inter->cmd_len)
+		memset(rq->cmd + inter->cmd_len, 0,
+		       sizeof(rq->cmd) - inter->cmd_len);
+
+	rq->bio = rq->biotail = NULL;
+
+	blk_rq_bio_prep(q, rq, bio);
+
+	rq->data = buffer;
+	rq->data_len = inter->data_len;
+
+	rq->timeout = 0;
+	if (!rq->timeout)
+		rq->timeout = q->sg_timeout;
+	if (!rq->timeout)
+		rq->timeout = BLK_DEFAULT_TIMEOUT;
+
+	start_time = jiffies;
+
+	DECLARE_COMPLETION(wait);
+
+	rq->rq_disk = bdev->bd_disk;
+
+	rq->waiting = &wait;
+	elv_add_request(q, rq, 1, 1);
+	generic_unplug_device(q);
+	wait_for_completion(&wait);
+	//printk("tbio: completion\n");
+	if (rq->errors) {
+		err = -EIO;
+		printk("tbio: rq->errors\n");
+		return err;
+	}
+
+	blk_put_request(rq);
+
+	return 0;
+out_request:
+	blk_put_request(rq);
+	return -EFAULT;
+
+}
+
+static int tbio_io(struct block_device *bdev, struct tbio_interface *uptr)
+{
+	tbio_interface_t inter;
+	struct bio *bio = NULL;
+	int reading = 0, writing = 0;
+	void *buffer = NULL;
+	//struct request *rq;
+	request_queue_t *q;
+	q = bdev_get_queue(Device.bdev);
+
+	if (copy_from_user(&inter, uptr, sizeof(tbio_interface_t))) {
+		printk("tbio: copy_from_user\n");
+		return -EFAULT;
+	}
+
+	if (inter.data_len > (q->max_sectors << 9)) {
+		printk("tbio: inter.in_len > q->max_sectors << 9\n");
+		return -EIO;
+	}
+
+	if (inter.data_len) {
+
+		switch (inter.direction) {
+		default:
+			return -EINVAL;
+		case TBIO_TO_DEV:
+			writing = 1;
+			break;
+		case TBIO_FROM_DEV:
+			reading = 1;
+			break;
+		}
+
+		bio = bio_map_user(bdev, (unsigned long)inter.data,
+				   inter.data_len, reading);
+
+		if (!bio) {
+			printk("tbio : bio_map_user failed\n");
+			buffer =
+			    kmalloc(inter.data_len, q->bounce_gfp | GFP_USER);
+			if (!buffer) {
+				printk("tbio: buffer no memory\n");
+				return -1;
+			}
+			copy_from_user(buffer, inter.data, inter.data_len);
+			printk("tbio: buffer %s\n", (char *)buffer);
+		}
+
+	}
+
+	send_request(q, bio, bdev, &inter, writing);
+
+	if (bio)
+		bio_unmap_user(bio, reading);
+	return 0;
+}
+
+static int test_bio_put(struct bio *biop)
+{
+
+	if (biop)
+		bio_put(biop);
+
+	return 0;
+}
+
+static int test_bio_clone(void)
+{
+	tbiop_dup = bio_clone(tbiop, GFP_NOIO);
+	if (tbiop_dup == NULL) {
+		printk("tbio: bio_clone failed\n");
+		return -1;
+	}
+
+	test_bio_put(tbiop_dup);
+
+	return 0;
+}
+
+static int test_bio_add_page(void)
+{
+	int res = 0, i = 0, offset = 0;
+	unsigned long addr = 0;
+	struct page *ppage = NULL;
+
+	for (i = 0; i < 128; i++) {
+
+		addr = get_zeroed_page(GFP_KERNEL);
+
+		if (addr == 0) {
+			printk("tbio: get free page failed %ld\n", addr);
+			return -1;
+		}
+
+		ppage = virt_to_page(addr);
+		if (ppage == NULL) {
+			printk
+			    ("tbio: covert virture page to page struct failed\n");
+			return -1;
+		}
+
+		res = bio_add_page(tbiop, ppage, PAGE_SIZE, offset);
+		if (res < 0) {
+			printk("bio_add_page :res %d\n", res);
+			return -1;
+		}
+		offset += res;
+		//      printk ("tbio: bio_add_page : %d\n", res);
+	}
+	return 0;
+}
+
+static int test_do_bio_alloc(int num)
+{
+	tbiop = bio_alloc(GFP_KERNEL, num);
+	if (tbiop == NULL) {
+		printk("tbio: bio_alloc failed\n");
+		return -1;
+	}
+	bio_put(tbiop);
+
+	return 0;
+}
+
+static int test_bio_alloc(void)
+{
+	int res = 0;
+	res = test_do_bio_alloc(2);
+	if (res < 0) {
+		printk("can not alloc bio for %d\n", 2);
+		return -1;
+	}
+
+	res = test_do_bio_alloc(8);
+	if (res < 0) {
+		printk("can not alloc bio for %d\n", 8);
+		return -1;
+	}
+	res = test_do_bio_alloc(32);
+	if (res < 0) {
+		printk("can not alloc bio for %d\n", 32);
+		return -1;
+	}
+	res = test_do_bio_alloc(96);
+	if (res < 0) {
+		printk("can not alloc bio for %d\n", 96);
+		return -1;
+	}
+	res = test_do_bio_alloc(BIO_MAX_PAGES);
+	if (res < 0) {
+		printk("can not alloc bio for %d\n", BIO_MAX_PAGES);
+		return -1;
+	}
+
+	tbiop = bio_alloc(GFP_KERNEL, BIO_MAX_PAGES);
+	if (tbiop == NULL) {
+		printk("tbio: bio_alloc failed\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int test_bio_split(struct block_device *bdev,
+			  struct tbio_interface *uptr)
+{
+	tbio_interface_t inter;
+	struct bio *bio = NULL;
+	struct bio_pair *bio_pairp = NULL;
+	int reading = 0, writing = 0;
+	void *buffer = NULL;
+	request_queue_t *q;
+	q = bdev_get_queue(Device.bdev);
+
+	if (copy_from_user(&inter, uptr, sizeof(tbio_interface_t))) {
+		printk("tbio: copy_from_user\n");
+		return -EFAULT;
+	}
+
+	if (inter.data_len > (q->max_sectors << 9)) {
+		printk("tbio: inter.in_len > q->max_sectors << 9\n");
+		return -EIO;
+	}
+
+	if (inter.data_len) {
+
+		switch (inter.direction) {
+		default:
+			return -EINVAL;
+		case TBIO_TO_DEV:
+			writing = 1;
+			break;
+		case TBIO_FROM_DEV:
+			reading = 1;
+			break;
+		}
+
+		bio = bio_map_user(bdev, (unsigned long)inter.data,
+				   inter.data_len, reading);
+
+		if (!bio) {
+			printk("tbio : bio_map_user failed\n");
+			buffer =
+			    kmalloc(inter.data_len, q->bounce_gfp | GFP_USER);
+			if (!buffer) {
+				printk("tbio: buffer no memory\n");
+				return -1;
+			}
+			copy_from_user(buffer, inter.data, inter.data_len);
+			printk("tbio: buffer %s\n", (char *)buffer);
+		} else {
+			//              printk("tbio: bio sectors %d\n", bio_sectors(bio));
+			//              printk("tbio: split now\n");
+			bio_pairp = bio_split(bio, bio_split_pool, 2);
+
+			if (bio_pairp == NULL) {
+				printk("tbio: bio_split failed\n");
+				bio_unmap_user(bio, reading);
+				return -1;
+			}
+		}
+
+	}
+
+	send_request(q, &(bio_pairp->bio1), bdev, &inter, writing);
+	q = bdev_get_queue(Device.bdev);
+	send_request(q, &(bio_pairp->bio2), bdev, &inter, writing);
+
+	if (bio_pairp) {
+		bio_pair_release(bio_pairp);
+		return 0;
+	}
+
+	if (bio)
+		bio_unmap_user(bio, reading);
+
+	return 0;
+
+}
+
+static int test_bio_get_nr_vecs(void)
+{
+	int number = 0;
+
+	if (!tbiop) {
+		printk("tbio: tbiop is NULL\n");
+		return -1;
+	}
+
+	number = bio_get_nr_vecs(tbiop->bi_bdev);
+
+	if (number < 0) {
+		printk("tbio: bio_get_nr_vec failed\n");
+		return -1;
+	}
+	//printk("bio_get_nr_vecs: %d\n",number);
+	return 0;
+}
+
+static int tbio_ioctl(struct inode *ino, struct file *file,
+		      unsigned int cmd, unsigned long arg)
+{
+	int err;
+//      request_queue_t *q;
+
+	//q = bdev_get_queue(Device.bdev);
+
+	printk("ttbio: ioctl 0x%x 0x%lx\n", cmd, arg);
+
+	switch (cmd) {
+	case LTP_TBIO_DO_IO:
+		{
+			err = bd_claim(Device.bdev, current);
+			if (err) {
+				printk("tbio:bd_claim\n");
+				break;
+			}
+
+			err =
+			    tbio_io(Device.bdev, (struct tbio_interface *)arg);
+			bd_release(Device.bdev);
+		}
+		break;
+
+	case LTP_TBIO_CLONE:
+		err = test_bio_clone();
+		break;
+	case LTP_TBIO_ADD_PAGE:
+		err = test_bio_add_page();
+		break;
+	case LTP_TBIO_ALLOC:
+		err = test_bio_alloc();
+		break;
+	case LTP_TBIO_GET_NR_VECS:
+		err = test_bio_get_nr_vecs();
+		break;
+	case LTP_TBIO_PUT:
+		err = test_bio_put(tbiop);
+		break;
+	case LTP_TBIO_SPLIT:
+		{
+			err = bd_claim(Device.bdev, current);
+			if (err) {
+				printk("tbio:bd_claim\n");
+				break;
+			}
+
+			err =
+			    test_bio_split(Device.bdev,
+					   (struct tbio_interface *)arg);
+			bd_release(Device.bdev);
+
+		}
+		break;
+		//case LTP_TBIO_PAIR_RELEASE:     err = test_bio_pair_release();break;
+
+	}
+	return 0;
+}
+
+static void tbio_transfer(struct request *req, struct tbio_device *dev)
+{
+
+	struct bio *bio = req->bio;
+
+	//printk("tbio: bio_data(bio) %s\n" , (char *)bio_data(bio));
+	if (bio_data_dir(bio)) {
+		printk("tbio: write \"%s\" to dev\n", (char *)bio_data(bio));
+		memcpy(dev->data, bio_data(bio), bio->bi_size);
+	} else {
+		memcpy(bio_data(bio), dev->data, bio->bi_size);
+		printk("tbio: read \"%s\" from dev\n", (char *)bio_data(bio));
+	}
+
+}
+
+static void tbio_request(request_queue_t * q)
+{
+	struct request *req;
+
+	while ((req = elv_next_request(q)) != NULL) {
+
+		tbio_transfer(req, &Device);
+		end_request(req, 1);
+	}
+}
+
+static int tbio_open(struct inode *inode, struct file *filep)
+{
+	if (!Device.bdev) {
+		Device.bdev = inode->i_bdev;
+		//atomic_inc((atomic_t)&Device.bdev->bd_part_count);
+	}
+
+	return 0;
+}
+
+static int tbio_release(struct inode *inode, struct file *filep)
+{
+	return 0;
+}
+
+int tbio_media_changed(struct gendisk *gd)
+{
+	return 0;
+}
+
+int tbio_revalidate(struct gendisk *gd)
+{
+	return 0;
+}
+
+static struct block_device_operations tbio_ops = {
+	.owner = THIS_MODULE,
+	.open = tbio_open,
+	.ioctl = tbio_ioctl,
+	.release = tbio_release,
+	.media_changed = tbio_media_changed,
+	.revalidate_disk = tbio_revalidate
+};
+
+static int __init tbio_init(void)
+{
+	Device.size = nsectors * hardsect_size;
+	int result;
+	spin_lock_init(&Device.lock);
+	Device.data = vmalloc(Device.size);
+	if (Device.data == NULL)
+		return -ENOMEM;
+	Device.bdev = NULL;
+
+	result = register_blkdev(TBIO_MAJOR, DEVICE_NAME);	//, &tbio_ops);
+
+	printk(KERN_ALERT "LTP BIO: register_blkdev result=%d major %d\n",
+	       result, TBIO_MAJOR);
+
+	if (result <= 0) {
+		printk(KERN_WARNING "tbio:unable to get major number\n");
+		goto out;
+	}
+
+	Device.gd = alloc_disk(1);
+	if (!Device.gd)
+		goto out_unregister;
+	Device.gd->major = TBIO_MAJOR;
+	Device.gd->first_minor = 0;
+	Device.gd->fops = &tbio_ops;
+	Device.gd->private_data = &Device;
+	strcpy(Device.gd->disk_name, "tbio0");
+	set_capacity(Device.gd, nsectors);
+	blk_init_queue(tbio_request, &Device.lock);
+	Device.gd->queue = &Queue;
+	add_disk(Device.gd);
+
+	return 0;
+
+out_unregister:
+	unregister_chrdev(TBIO_MAJOR, "tbio");
+out:
+	vfree(Device.data);
+	return -ENOMEM;
+}
+
+static void tbio_exit(void)
+{
+	if (Device.bdev) {
+		invalidate_bdev(Device.bdev, 1);
+		bdput(Device.bdev);
+	}
+
+	del_gendisk(Device.gd);
+	put_disk(Device.gd);
+	unregister_blkdev(TBIO_MAJOR, "tbio");
+	vfree(Device.data);
+}
+
+module_init(tbio_init);
+module_exit(tbio_exit);
diff --git a/testcases/kernel/device-drivers/tbio/tbio_kernel/str_tbio.h b/testcases/kernel/device-drivers/tbio/tbio_kernel/str_tbio.h
new file mode 100644
index 0000000..dc74d6f
--- /dev/null
+++ b/testcases/kernel/device-drivers/tbio/tbio_kernel/str_tbio.h
@@ -0,0 +1,39 @@
+/*
+ *
+ *   Copyright (c) International Business Machines  Corp., 2001
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+
+ * Remember that you want to seperate your header
+ * files between what is needed in kernel space
+ * only, and what will also be needed by a user
+ * space program that is using this module. For
+ * that reason keep all structures that will need
+ * kernel space pointers in a seperate header file
+ * from where ioctl flags aer kept
+ *
+ * author: Sean Ruyle
+ * date:   06/11/2003
+ *
+ */
+
+struct ltpmod_user {
+
+//put any pointers in here that might be needed by other ioctl calls
+
+};
+typedef struct ltpmod_user ltpmod_user_t;
+
diff --git a/testcases/kernel/device-drivers/tbio/tbio_kernel/tbio.h b/testcases/kernel/device-drivers/tbio/tbio_kernel/tbio.h
new file mode 100644
index 0000000..e650399
--- /dev/null
+++ b/testcases/kernel/device-drivers/tbio/tbio_kernel/tbio.h
@@ -0,0 +1,96 @@
+/*
+ *
+ *   Copyright (c) International Business Machines  Corp., 2001
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+
+ * In this header file keep all flags and other
+ * structures that will be needed in both kernel
+ * and user space. Specifically the ioctl flags
+ * will go in here so that in user space a program
+ * can specify flags for the ioctl call.
+ *
+ * module: tbio
+ *  Copyright (c) International Business Machines  Corp., 2003
+ *
+ *  This program is free software;  you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *  the GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program;
+ *
+ *  FILE        : tbio.h
+ *  USAGE       : kernel_space:./load_tbio.sh
+ *                user_space  :./test_bio
+ *
+ *  DESCRIPTION : The module will test block i/o layer for kernel 2.5
+ *  REQUIREMENTS:
+ *                1) glibc 2.1.91 or above.
+ *
+ *  HISTORY     :
+ *      11/19/2003 Kai Zhao (ltcd3@cn.ibm.com)
+ *
+ *  CODE COVERAGE: 74.9% - fs/bio.c (Total Coverage)
+ *
+ */
+
+#define TMOD_DRIVER_NAME	"ltp test block I/O layer module"
+#define DEVICE_NAME		"/dev/tbio"
+#define MAG_NUM			'k'
+#define TBIO_MAJOR      258
+
+#define TBIO_TO_DEV              1
+#define TBIO_FROM_DEV            2
+
+/* put ioctl flags here, use the _IO macro which is
+ found in linux/ioctl.h, takes a letter, and an
+ integer */
+
+#define LTP_TBIO_CLONE		_IO(MAG_NUM,1)
+#define LTP_TBIO_ALLOC		_IO(MAG_NUM,2)
+#define LTP_TBIO_GET_NR_VECS	_IO(MAG_NUM,3)
+#define LTP_TBIO_PUT		_IO(MAG_NUM,4)
+#define LTP_TBIO_SPLIT		_IO(MAG_NUM,5)
+#define LTP_TBIO_DO_IO		_IO(MAG_NUM,6)
+#define LTP_TBIO_ADD_PAGE	_IO(MAG_NUM,7)
+
+/* memory between the kernel and user space is
+ seperated, so that if a structure is needed
+ to be passed between kernel and user space
+ a call must be made to copy_to_user or copy
+ from user. Use this structure to streamline
+ that process. For example: A function that
+ writes to a disc takes in a ki_write_t
+ pointer from userspace. In the user space
+ program specify the length of the pointer as
+ in_len, and in_data as the actual structure. */
+
+struct tbio_interface {
+	void  *data;         // input data
+	int     data_len;         // input data length
+	int     direction;      // read or write form DEV
+	unsigned char *cmd;     // read or write
+	int   cmd_len;          // length of cmd
+};
+typedef struct tbio_interface tbio_interface_t;
+
diff --git a/testcases/kernel/device-drivers/tbio/tbio_user/Makefile b/testcases/kernel/device-drivers/tbio/tbio_user/Makefile
new file mode 100644
index 0000000..9fe124e
--- /dev/null
+++ b/testcases/kernel/device-drivers/tbio/tbio_user/Makefile
@@ -0,0 +1,9 @@
+
+CFLAGS += -O2 -Wall -W -g
+OBJS = tbio_ki.o user_tbio.o
+
+test_bio: $(OBJS)
+	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@
+
+clean:
+	rm -f $(OBJS) test_bio
diff --git a/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c b/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
new file mode 100644
index 0000000..d3e88d1
--- /dev/null
+++ b/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
@@ -0,0 +1,348 @@
+/*
+ *
+ *   Copyright (c) International Business Machines  Corp., 2001
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ *
+ * This is the main of your user space test program,
+ * which will open the correct kernel bioule, find the
+ * file descriptor value and use that value to make
+ * ioctl calls to the system
+ *
+ * Use the ki_generic and other ki_testname functions
+ * to abstract the calls from the main
+ *
+ * bioule: tbio
+ *  Copyright (c) International Business Machines  Corp., 2003
+ *
+ *  This program is free software;  you can redistribute it and/or bioify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *  the GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program;
+ *
+ *  FILE        : user_tbio.c
+ *  USAGE       : kernel_space:./load_tbio.sh
+ *                user_space  :./test_bio
+ *
+ *  DESCRIPTION : The bioule will test block i/o layer for kernel 2.5
+ *  REQUIREMENTS:
+ *                1) glibc 2.1.91 or above.
+ *
+ *  HISTORY     :
+ *      11/19/2003 Kai Zhao (ltcd3@cn.ibm.com)
+ *
+ *  CODE COVERAGE: 74.9% - fs/bio.c (Total Coverage)
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <linux/kernel.h>
+
+#include "user_tbio.h"
+#include "../kernel_space/tbio.h"
+
+static int tbio_fd = -1;	/* file descriptor */
+
+int tbioopen()
+{
+
+	dev_t devt;
+	struct stat st;
+	int rc = 0;
+
+	devt = makedev(TBIO_MAJOR, 0);
+
+	if (rc) {
+		if (errno == ENOENT) {
+			/* dev node does not exist. */
+			rc = mkdir(DEVICE_NAME, (S_IFDIR | S_IRWXU |
+						 S_IRGRP | S_IXGRP |
+						 S_IROTH | S_IXOTH));
+		} else {
+			printf
+			    ("ERROR: Problem with Base dev directory.  Error code from stat() is %d\n\n",
+			     errno);
+		}
+
+	} else {
+		if (!(st.st_mode & S_IFDIR)) {
+			rc = unlink(DEVICE_NAME);
+			if (!rc) {
+				rc = mkdir(DEVICE_NAME, (S_IFDIR | S_IRWXU |
+							 S_IRGRP | S_IXGRP |
+							 S_IROTH | S_IXOTH));
+			}
+		}
+	}
+
+	/*
+	 * Check for the /dev/tbase node, and create if it does not
+	 * exist.
+	 */
+	rc = stat(DEVICE_NAME, &st);
+	if (rc) {
+		if (errno == ENOENT) {
+			/* dev node does not exist */
+			rc = mknod(DEVICE_NAME,
+				   (S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP |
+				    S_IWGRP), devt);
+		} else {
+			printf
+			    ("ERROR:Problem with tbase device node directory.  Error code form stat() is %d\n\n",
+			     errno);
+		}
+
+	} else {
+		/*
+		 * /dev/tbio CHR device exists.  Check to make sure it is for a
+		 * block device and that it has the right major and minor.
+		 */
+		if ((!(st.st_mode & S_IFCHR)) || (st.st_rdev != devt)) {
+
+			/* Recreate the dev node. */
+			rc = unlink(DEVICE_NAME);
+			if (!rc) {
+				rc = mknod(DEVICE_NAME,
+					   (S_IFCHR | S_IRUSR | S_IWUSR |
+					    S_IRGRP | S_IWGRP), devt);
+			}
+		}
+	}
+
+	tbio_fd = open(DEVICE_NAME, O_RDWR);
+
+	if (tbio_fd < 0) {
+		printf("ERROR: Open of device %s failed %d errno = %d\n",
+		       DEVICE_NAME, tbio_fd, errno);
+		return errno;
+	} else {
+		printf("Device opened successfully \n");
+		return 0;
+	}
+
+}
+
+int tbioclose()
+{
+
+	if (tbio_fd != -1) {
+		close(tbio_fd);
+		tbio_fd = -1;
+	}
+
+	return 0;
+}
+
+int tbio_to_dev(int fd, int flag)
+{
+	int rc;
+	tbio_interface_t bif;
+
+	memset(&bif, 0, sizeof(tbio_interface_t));
+	rc = posix_memalign(&bif.data, 512, 1024);
+	if (rc) {
+		printf("posix_memalign failed\n");
+		return -1;
+	}
+
+	strcpy(bif.data, "User space data");
+	bif.data_len = 1024;
+	bif.direction = TBIO_TO_DEV;
+	bif.cmd = (char *)malloc(6);
+	if (bif.cmd == NULL) {
+		printf("malloc cmd space failed\n");
+		free(bif.data);
+		return -1;
+	}
+	strcpy(bif.cmd, "WRITE");
+	bif.cmd_len = 6;
+
+	rc = ioctl(fd, flag, &bif);
+	if (rc) {
+		free(bif.data);
+		free(bif.cmd);
+		printf("Ioctl error for TBIO_TO_DEV\n");
+		return rc;
+	}
+
+	free(bif.data);
+	free(bif.cmd);
+
+	return 0;
+
+}
+
+int tbio_from_dev(int fd, int flag)
+{
+	int rc;
+	tbio_interface_t bif;
+
+	memset(&bif, 0, sizeof(tbio_interface_t));
+	rc = posix_memalign(&bif.data, 512, 1024);
+	if (rc) {
+		printf("posix_memalign failed\n");
+		return -1;
+	}
+
+	memset(bif.data, 0, 1024);
+
+	bif.data_len = 1024;
+	bif.direction = TBIO_FROM_DEV;
+	bif.cmd = (char *)malloc(6);
+	if (bif.cmd == NULL) {
+		printf("malloc cmd space failed\n");
+		free(bif.data);
+		return -1;
+	}
+	strcpy(bif.cmd, "READ");
+	bif.cmd_len = 6;
+
+	rc = ioctl(fd, flag, &bif);
+	if (rc) {
+		free(bif.data);
+		free(bif.cmd);
+		printf("Ioctl error for TBIO_TO_DEV\n");
+		return rc;
+	}
+	//printf("read from dev %s\n",bif.data);
+	if (strcmp(bif.data, "User space data")) {
+		printf("TBIO_FROM_DEV failed\n");
+		free(bif.data);
+		free(bif.cmd);
+		return -1;
+	}
+
+	free(bif.data);
+	free(bif.cmd);
+
+	return 0;
+
+}
+
+int tbio_split_to_dev(int fd, int flag)
+{
+	int rc;
+	tbio_interface_t bif;
+
+	memset(&bif, 0, sizeof(tbio_interface_t));
+	rc = posix_memalign(&bif.data, 512, 2048);
+	if (rc) {
+		printf("posix_memalign failed\n");
+		return -1;
+	}
+
+	strcpy(bif.data, "User space data");
+	bif.data_len = 2048;
+	bif.direction = TBIO_TO_DEV;
+	bif.cmd = (char *)malloc(6);
+	if (bif.cmd == NULL) {
+		printf("malloc cmd space failed\n");
+		free(bif.data);
+		return -1;
+	}
+	strcpy(bif.cmd, "WRITE");
+	bif.cmd_len = 6;
+
+	rc = ioctl(fd, flag, &bif);
+	if (rc) {
+		free(bif.data);
+		free(bif.cmd);
+		printf("Ioctl error for TBIO_TO_DEV\n");
+		return rc;
+	}
+
+	free(bif.data);
+	free(bif.cmd);
+
+	return 0;
+
+}
+
+int main()
+{
+	int rc;
+
+	/* open the bioule */
+	rc = tbioopen();
+	if (rc) {
+		printf("Test bio Driver may not be loaded\n");
+		exit(1);
+	}
+
+	if (ki_generic(tbio_fd, LTP_TBIO_ALLOC))
+		printf("Failed on LTP_TBIO_ALLOC test\n");
+	else
+		printf("Success on LTP_TBIO_ALLOC test\n");
+
+	if (ki_generic(tbio_fd, LTP_TBIO_CLONE))
+		printf("Failed on LTP_TBIO_CLONE test\n");
+	else
+		printf("Success on LTP_TBIO_CLONE test\n");
+
+	if (ki_generic(tbio_fd, LTP_TBIO_GET_NR_VECS))
+		printf("Failed on LTP_TBIO_GET_NR_VECS test\n");
+	else
+		printf("Success on LTP_TBIO_GET_NR_VECS test\n");
+
+	if (ki_generic(tbio_fd, LTP_TBIO_ADD_PAGE))
+		printf("Failed on LTP_TBIO_ADD_PAGE test\n");
+	else
+		printf("Success on LTP_TBIO_ADD_PAGE test\n");
+
+	if (tbio_split_to_dev(tbio_fd, LTP_TBIO_SPLIT))
+		printf("Failed on LTP_TBIO_SPLIT:write to dev\n");
+	else
+		printf("Success on LTP_TBIO_SPLIT:write to dev\n");
+
+	if (tbio_to_dev(tbio_fd, LTP_TBIO_DO_IO))
+		printf("Failed on LTP_TBIO_DO_IO:write to dev\n");
+	else
+		printf("Success on LTP_TBIO_DO_IO:write to dev\n");
+
+	if (tbio_from_dev(tbio_fd, LTP_TBIO_DO_IO))
+		printf("Failed on LTP_TBIO_DO_IO:read from dev\n");
+	else
+		printf("Success on LTP_TBIO_DO_IO:read from dev\n");
+
+	if (ki_generic(tbio_fd, LTP_TBIO_PUT))
+		printf("Failed on LTP_TBIO_PUT test\n");
+	else
+		printf("Success on LTP_TBIO_PUT test\n");
+
+	/* close the bioule */
+	rc = tbioclose();
+	if (rc) {
+		printf("Test bio Driver may not be closed\n");
+		exit(1);
+	}
+
+	return 0;
+}
diff --git a/testcases/kernel/device-drivers/tbio/user_space/Makefile b/testcases/kernel/device-drivers/tbio/user_space/Makefile
deleted file mode 100644
index 9fe124e..0000000
--- a/testcases/kernel/device-drivers/tbio/user_space/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-
-CFLAGS += -O2 -Wall -W -g
-OBJS = tbio_ki.o user_tbio.o
-
-test_bio: $(OBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@
-
-clean:
-	rm -f $(OBJS) test_bio
diff --git a/testcases/kernel/device-drivers/tbio/user_space/tbio_ki.c b/testcases/kernel/device-drivers/tbio/user_space/tbio_ki.c
deleted file mode 100644
index b5d6d46..0000000
--- a/testcases/kernel/device-drivers/tbio/user_space/tbio_ki.c
+++ /dev/null
@@ -1,86 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
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
- *
- *
- * This file will include user space functions that will drive
- * the kernel module to test various functions and kernel
- * calls. Each function will need to setup the tif structure
- * so that the in parameters and out parameters are correctly
- * initialized
- *
- * use bif structure for passing params between user
- * space and kernel space, in some tests it is really not
- * needed, and if nothing is needed to pass in utilize
- * the ki_generic function below. the tif structure makes
- * it easy to maintain all the tests if they have the same
- * process in kernel space to read in params in the kernel
- * module no matter what the test is
- *
-  * module: tbio
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
- *  FILE        : tbio_ki.c
- *  USAGE       : kernel_space:./load_tbio.sh
- *                user_space  :./test_bio
- *
- *  DESCRIPTION : The module will test block i/o layer for kernel 2.5
- *  REQUIREMENTS:
- *                1) glibc 2.1.91 or above.
- *
- *  HISTORY     :
- *      11/19/2003 Kai Zhao (ltcd3@cn.ibm.com)
- *
- *  CODE COVERAGE: 74.9% - fs/bio.c (Total Coverage)
- *
- */
-
-#include <stdlib.h>
-#include <stdio.h>
-#include <sys/ioctl.h>
-#include "../kernel_space/tbio.h"
-
-int ki_generic(int fd, int flag)
-{
-	int rc;
-	tbio_interface_t bif;
-
-	rc = ioctl(fd, flag, &bif);
-	if (rc) {
-		printf("Ioctl error\n");
-		return rc;
-	}
-
-	return rc;
-}
-
-#if 0
-
-#endif
diff --git a/testcases/kernel/device-drivers/tbio/user_space/user_tbio.c b/testcases/kernel/device-drivers/tbio/user_space/user_tbio.c
deleted file mode 100644
index d3e88d1..0000000
--- a/testcases/kernel/device-drivers/tbio/user_space/user_tbio.c
+++ /dev/null
@@ -1,348 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
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
- *
- *
- * This is the main of your user space test program,
- * which will open the correct kernel bioule, find the
- * file descriptor value and use that value to make
- * ioctl calls to the system
- *
- * Use the ki_generic and other ki_testname functions
- * to abstract the calls from the main
- *
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
- *  FILE        : user_tbio.c
- *  USAGE       : kernel_space:./load_tbio.sh
- *                user_space  :./test_bio
- *
- *  DESCRIPTION : The bioule will test block i/o layer for kernel 2.5
- *  REQUIREMENTS:
- *                1) glibc 2.1.91 or above.
- *
- *  HISTORY     :
- *      11/19/2003 Kai Zhao (ltcd3@cn.ibm.com)
- *
- *  CODE COVERAGE: 74.9% - fs/bio.c (Total Coverage)
- *
- */
-
-#define _GNU_SOURCE
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/stat.h>
-#include <sys/ioctl.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <linux/kernel.h>
-
-#include "user_tbio.h"
-#include "../kernel_space/tbio.h"
-
-static int tbio_fd = -1;	/* file descriptor */
-
-int tbioopen()
-{
-
-	dev_t devt;
-	struct stat st;
-	int rc = 0;
-
-	devt = makedev(TBIO_MAJOR, 0);
-
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
-
-	} else {
-		if (!(st.st_mode & S_IFDIR)) {
-			rc = unlink(DEVICE_NAME);
-			if (!rc) {
-				rc = mkdir(DEVICE_NAME, (S_IFDIR | S_IRWXU |
-							 S_IRGRP | S_IXGRP |
-							 S_IROTH | S_IXOTH));
-			}
-		}
-	}
-
-	/*
-	 * Check for the /dev/tbase node, and create if it does not
-	 * exist.
-	 */
-	rc = stat(DEVICE_NAME, &st);
-	if (rc) {
-		if (errno == ENOENT) {
-			/* dev node does not exist */
-			rc = mknod(DEVICE_NAME,
-				   (S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP |
-				    S_IWGRP), devt);
-		} else {
-			printf
-			    ("ERROR:Problem with tbase device node directory.  Error code form stat() is %d\n\n",
-			     errno);
-		}
-
-	} else {
-		/*
-		 * /dev/tbio CHR device exists.  Check to make sure it is for a
-		 * block device and that it has the right major and minor.
-		 */
-		if ((!(st.st_mode & S_IFCHR)) || (st.st_rdev != devt)) {
-
-			/* Recreate the dev node. */
-			rc = unlink(DEVICE_NAME);
-			if (!rc) {
-				rc = mknod(DEVICE_NAME,
-					   (S_IFCHR | S_IRUSR | S_IWUSR |
-					    S_IRGRP | S_IWGRP), devt);
-			}
-		}
-	}
-
-	tbio_fd = open(DEVICE_NAME, O_RDWR);
-
-	if (tbio_fd < 0) {
-		printf("ERROR: Open of device %s failed %d errno = %d\n",
-		       DEVICE_NAME, tbio_fd, errno);
-		return errno;
-	} else {
-		printf("Device opened successfully \n");
-		return 0;
-	}
-
-}
-
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
-
-int tbio_to_dev(int fd, int flag)
-{
-	int rc;
-	tbio_interface_t bif;
-
-	memset(&bif, 0, sizeof(tbio_interface_t));
-	rc = posix_memalign(&bif.data, 512, 1024);
-	if (rc) {
-		printf("posix_memalign failed\n");
-		return -1;
-	}
-
-	strcpy(bif.data, "User space data");
-	bif.data_len = 1024;
-	bif.direction = TBIO_TO_DEV;
-	bif.cmd = (char *)malloc(6);
-	if (bif.cmd == NULL) {
-		printf("malloc cmd space failed\n");
-		free(bif.data);
-		return -1;
-	}
-	strcpy(bif.cmd, "WRITE");
-	bif.cmd_len = 6;
-
-	rc = ioctl(fd, flag, &bif);
-	if (rc) {
-		free(bif.data);
-		free(bif.cmd);
-		printf("Ioctl error for TBIO_TO_DEV\n");
-		return rc;
-	}
-
-	free(bif.data);
-	free(bif.cmd);
-
-	return 0;
-
-}
-
-int tbio_from_dev(int fd, int flag)
-{
-	int rc;
-	tbio_interface_t bif;
-
-	memset(&bif, 0, sizeof(tbio_interface_t));
-	rc = posix_memalign(&bif.data, 512, 1024);
-	if (rc) {
-		printf("posix_memalign failed\n");
-		return -1;
-	}
-
-	memset(bif.data, 0, 1024);
-
-	bif.data_len = 1024;
-	bif.direction = TBIO_FROM_DEV;
-	bif.cmd = (char *)malloc(6);
-	if (bif.cmd == NULL) {
-		printf("malloc cmd space failed\n");
-		free(bif.data);
-		return -1;
-	}
-	strcpy(bif.cmd, "READ");
-	bif.cmd_len = 6;
-
-	rc = ioctl(fd, flag, &bif);
-	if (rc) {
-		free(bif.data);
-		free(bif.cmd);
-		printf("Ioctl error for TBIO_TO_DEV\n");
-		return rc;
-	}
-	//printf("read from dev %s\n",bif.data);
-	if (strcmp(bif.data, "User space data")) {
-		printf("TBIO_FROM_DEV failed\n");
-		free(bif.data);
-		free(bif.cmd);
-		return -1;
-	}
-
-	free(bif.data);
-	free(bif.cmd);
-
-	return 0;
-
-}
-
-int tbio_split_to_dev(int fd, int flag)
-{
-	int rc;
-	tbio_interface_t bif;
-
-	memset(&bif, 0, sizeof(tbio_interface_t));
-	rc = posix_memalign(&bif.data, 512, 2048);
-	if (rc) {
-		printf("posix_memalign failed\n");
-		return -1;
-	}
-
-	strcpy(bif.data, "User space data");
-	bif.data_len = 2048;
-	bif.direction = TBIO_TO_DEV;
-	bif.cmd = (char *)malloc(6);
-	if (bif.cmd == NULL) {
-		printf("malloc cmd space failed\n");
-		free(bif.data);
-		return -1;
-	}
-	strcpy(bif.cmd, "WRITE");
-	bif.cmd_len = 6;
-
-	rc = ioctl(fd, flag, &bif);
-	if (rc) {
-		free(bif.data);
-		free(bif.cmd);
-		printf("Ioctl error for TBIO_TO_DEV\n");
-		return rc;
-	}
-
-	free(bif.data);
-	free(bif.cmd);
-
-	return 0;
-
-}
-
-int main()
-{
-	int rc;
-
-	/* open the bioule */
-	rc = tbioopen();
-	if (rc) {
-		printf("Test bio Driver may not be loaded\n");
-		exit(1);
-	}
-
-	if (ki_generic(tbio_fd, LTP_TBIO_ALLOC))
-		printf("Failed on LTP_TBIO_ALLOC test\n");
-	else
-		printf("Success on LTP_TBIO_ALLOC test\n");
-
-	if (ki_generic(tbio_fd, LTP_TBIO_CLONE))
-		printf("Failed on LTP_TBIO_CLONE test\n");
-	else
-		printf("Success on LTP_TBIO_CLONE test\n");
-
-	if (ki_generic(tbio_fd, LTP_TBIO_GET_NR_VECS))
-		printf("Failed on LTP_TBIO_GET_NR_VECS test\n");
-	else
-		printf("Success on LTP_TBIO_GET_NR_VECS test\n");
-
-	if (ki_generic(tbio_fd, LTP_TBIO_ADD_PAGE))
-		printf("Failed on LTP_TBIO_ADD_PAGE test\n");
-	else
-		printf("Success on LTP_TBIO_ADD_PAGE test\n");
-
-	if (tbio_split_to_dev(tbio_fd, LTP_TBIO_SPLIT))
-		printf("Failed on LTP_TBIO_SPLIT:write to dev\n");
-	else
-		printf("Success on LTP_TBIO_SPLIT:write to dev\n");
-
-	if (tbio_to_dev(tbio_fd, LTP_TBIO_DO_IO))
-		printf("Failed on LTP_TBIO_DO_IO:write to dev\n");
-	else
-		printf("Success on LTP_TBIO_DO_IO:write to dev\n");
-
-	if (tbio_from_dev(tbio_fd, LTP_TBIO_DO_IO))
-		printf("Failed on LTP_TBIO_DO_IO:read from dev\n");
-	else
-		printf("Success on LTP_TBIO_DO_IO:read from dev\n");
-
-	if (ki_generic(tbio_fd, LTP_TBIO_PUT))
-		printf("Failed on LTP_TBIO_PUT test\n");
-	else
-		printf("Success on LTP_TBIO_PUT test\n");
-
-	/* close the bioule */
-	rc = tbioclose();
-	if (rc) {
-		printf("Test bio Driver may not be closed\n");
-		exit(1);
-	}
-
-	return 0;
-}
diff --git a/testcases/kernel/device-drivers/tbio/user_space/user_tbio.h b/testcases/kernel/device-drivers/tbio/user_space/user_tbio.h
deleted file mode 100644
index 79ffa91..0000000
--- a/testcases/kernel/device-drivers/tbio/user_space/user_tbio.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
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
- *
-*/
-int ki_generic(int, int);
-
-
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
