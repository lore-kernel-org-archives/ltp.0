Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09275CDB465
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 18:45:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AC1F3CFD6E
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 20:44:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B37C3C894B
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 20:44:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B729E201178
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 20:44:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AC4AA1FECB;
 Mon, 16 Oct 2023 18:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697481870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gvKP9wDWPC16Xcqkcxsw2HqK+8yKbp+tQ9hAjhq+rYA=;
 b=OFiigSZqbQuphiy5SPMJHGStuXqZF1J4m9+fg3toBVRxb4Z5eWnGglNvBN7Mi0P+j4FlJW
 1uMQ0zKRWlwze+UQCEcR4GREX41R1o6cO0MpXFaQQtn9YqTm6RpWSSA/YoAtqd0UfwabaT
 2d6DDLuUZGC2KExTyzuLdDrq9w6kqNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697481870;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gvKP9wDWPC16Xcqkcxsw2HqK+8yKbp+tQ9hAjhq+rYA=;
 b=Vrs19f6UTADs/EJNTXQnawHg0JKm+KGKbWsI9jjJeD8ndAE9eLVcpVAVNDEJQAMLtzbZj+
 QPhkjtv+Nq7eBJAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B1E7138EF;
 Mon, 16 Oct 2023 18:44:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MJJdCI6ELWXAZgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 16 Oct 2023 18:44:30 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 16 Oct 2023 20:44:03 +0200
Message-ID: <20231016184408.879977-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016184408.879977-1-pvorel@suse.cz>
References: <20231016184408.879977-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.09 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-2.99)[-0.998];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 2/7] fs: Remove scsi/ltpfs testsuite
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This testsuite, which contained kernel module, user space code and
custom runner, was written for kernel 2.5.

It did not use LTP API. Kernel modules didn't use current kernel UAPI
and even don't even built due missing headers (<linux/genhd.h> was moved
into <linux/blkdev.h> v5.18, <linux/blk.h> is not in kernel git history).

It's probably not worth of fixing it or rewriting into kselftest/KUnit,
thus removed.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/fs/scsi/ltpfs/Ltpfs.h     |  71 ---
 testcases/kernel/fs/scsi/ltpfs/LtpfsCmds.c | 315 ----------
 testcases/kernel/fs/scsi/ltpfs/Makefile    |  30 -
 testcases/kernel/fs/scsi/ltpfs/ltpfs.part1 |   4 -
 testcases/kernel/fs/scsi/ltpfs/ltpfs.part2 |   3 -
 testcases/kernel/fs/scsi/ltpfs/ltpfs.part3 |   3 -
 testcases/kernel/fs/scsi/ltpfs/ltpfs.part4 |   3 -
 testcases/kernel/fs/scsi/ltpfs/ltpfs.part5 |   3 -
 testcases/kernel/fs/scsi/ltpfs/ltpfs.part6 |   3 -
 testcases/kernel/fs/scsi/ltpfs/ltpfs.part7 |   3 -
 testcases/kernel/fs/scsi/ltpfs/ltpfsio.sh  | 154 -----
 testcases/kernel/fs/scsi/ltpfs/main.c      | 647 ---------------------
 12 files changed, 1239 deletions(-)
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/Ltpfs.h
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/LtpfsCmds.c
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/Makefile
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part1
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part2
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part3
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part4
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part5
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part6
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part7
 delete mode 100755 testcases/kernel/fs/scsi/ltpfs/ltpfsio.sh
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/main.c

diff --git a/testcases/kernel/fs/scsi/ltpfs/Ltpfs.h b/testcases/kernel/fs/scsi/ltpfs/Ltpfs.h
deleted file mode 100644
index 24a85c95c..000000000
--- a/testcases/kernel/fs/scsi/ltpfs/Ltpfs.h
+++ /dev/null
@@ -1,71 +0,0 @@
-
-#define FS_LTP_TEST_COMPONENT	        	0x00020999
-#define FS_LTP_TEST_CLASS		        	"ltp_test"
-#define FS_LTP_TEST_HID 		        	"FS0999"
-#define FS_LTP_TEST_DRIVER_NAME		    "FS LTP Test Driver"
-#define FS_LTP_TEST_DEVICE_NAME	    	"LTP Test"
-#define FS_LTP_TEST_FILE_STATE    		"state"
-#define FS_LTP_TEST_NOTIFY_STATUS		    0x80
-#define FS_LTP_TEST_STATUS_OFFLINE		0x00
-#define FS_LTP_TEST_STATUS_ONLINE	    	0x01
-#define FS_LTP_TEST_STATUS_UNKNOWN		0xFF
-#define _COMPONENT		FS_LTP_TEST_COMPONENT
-#define FS_TLP_TEST_MODULE_NAME		("fs_ltp_test")
-#define FS_NS_SYSTEM_BUS          "_SB_"
-#define FS_BATTERY_FORMAT_BIF	"NNNNNNNNNSSSS"
-#define FS_BATTERY_FORMAT_BST	"NNNN"
-
-
-#define FS_TYPE_ANY                   0x00
-#define FS_TYPE_INTEGER               0x01  /* Byte/Word/Dword/Zero/One/Ones */
-#define FS_TYPE_STRING                0x02
-#define FS_TYPE_BUFFER                0x03
-#define FS_TYPE_PACKAGE               0x04  /* byte_const, multiple data_term/Constant/super_name */
-#define FS_TYPE_FIELD_UNIT            0x05
-#define FS_TYPE_DEVICE                0x06  /* Name, multiple Node */
-#define FS_TYPE_EVENT                 0x07
-#define FS_TYPE_METHOD                0x08  /* Name, byte_const, multiple Code */
-#define FS_TYPE_MUTEX                 0x09
-#define FS_TYPE_REGION                0x0A
-#define FS_TYPE_POWER                 0x0B  /* Name,byte_const,word_const,multi Node */
-#define FS_TYPE_PROCESSOR             0x0C  /* Name,byte_const,Dword_const,byte_const,multi nm_o */
-#define FS_TYPE_THERMAL               0x0D  /* Name, multiple Node */
-#define FS_TYPE_BUFFER_FIELD          0x0E
-#define FS_TYPE_DDB_HANDLE            0x0F
-#define FS_TYPE_DEBUG_OBJECT          0x10
-
-#define FS_TYPE_EXTERNAL_MAX          0x10
-#define LTPMAJOR                       256
-
-/* Use 'k' as magic number */
-#define LTPFS_IOC_MAGIC  'k'
-#define TOMINOR(x) ((x & 3) | ((x & 4) << 5))
-
-
-#define DEV_PATH                            "/dev"
-#define LTP_FS_DIR_NAME                   ""
-#define LTP_FS_DEV_NAME                   "LTPFS"
-#define LTP_FS_DEV_NODE_PATH              DEV_PATH "/"
-#define LTP_FS_DEVICE_NAME                DEV_PATH "/"  LTP_FS_DEV_NAME
-#define MINOR_SHIFT_BITS 3
-#define MAX_PARTITIONS 8                    /* partition 0 + 7 more possible due to 3 bit partition number field */
-#define	MAX_NUM_DISKS 3                   /* number of real devices */
-
-#define MPDEV_FLAG_CLEAR 0
-#define MPDEV_FLAG_SET   1
-
-typedef struct _ltpdev_cmd {
-    u_int32_t     cmd;           // input - 0==recover, 1==fail
-    u_int32_t     status;        // ouput - 0==success
-} ltpdev_cmd_t;
-
-typedef enum ltpdev_ioctl_cmds_s {
-	/* version commands */
-	LTP_AIO_IOCTL_NUMBER = 0x5500,
-	LTP_BIO_IOCTL_NUMBER = 0x5501
-} ltpdev_ioctl_cmds_t;
-
-// define the ioctl cmds
-#define LTPAIODEV_CMD       _IOR( LTPMAJOR, LTP_AIO_IOCTL_NUMBER, ltpdev_cmd_t **)
-#define LTPBIODEV_CMD       _IOR( LTPMAJOR, LTP_BIO_IOCTL_NUMBER, ltpdev_cmd_t **)
-
diff --git a/testcases/kernel/fs/scsi/ltpfs/LtpfsCmds.c b/testcases/kernel/fs/scsi/ltpfs/LtpfsCmds.c
deleted file mode 100644
index 0b561702e..000000000
--- a/testcases/kernel/fs/scsi/ltpfs/LtpfsCmds.c
+++ /dev/null
@@ -1,315 +0,0 @@
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/fs.h>
-#include <linux/ioctl.h>
-#include <linux/pm.h>
-#include <linux/genhd.h>
-#include <linux/bio.h>
-#include <linux/mm.h>
-#include <linux/swap.h>
-#include <linux/bio.h>
-#include <linux/blk.h>
-#include <linux/slab.h>
-#include <linux/mempool.h>
-#include <linux/workqueue.h>
-#include <linux/namei.h>
-#include <linux/mount.h>
-#include <linux/quotaops.h>
-#include <linux/pagemap.h>
-#include <linux/dnotify.h>
-#include <linux/smp_lock.h>
-#include <linux/personality.h>
-#include <linux/security.h>
-#include <linux/buffer_head.h>
-#include <asm/namei.h>
-#include <asm/uaccess.h>
-
-#define ACC_MODE(x) ("\000\004\002\006"[(x)&O_ACCMODE])
-#define IS_POSIX(fl)	(fl->fl_flags & FL_POSIX)
-#define TEST_MEM_SIZE  4096
-#define FALSE          0
-#include "Ltpfs.h"
-
-static int ltpdev_open(struct inode *inode, struct file *pfile);
-static int ltpdev_release(struct inode *inode, struct file *pfile);
-static int ltpdev_ioctl(struct inode *pinode, struct file *pfile,
-			unsigned int cmd, unsigned long arg);
-static int do_buffer_c_tests(void);
-
-static struct block_device_operations blkops = {
-open:	ltpdev_open,
-release:ltpdev_release,
-ioctl:	ltpdev_ioctl,
-};
-
-int ltp_fs_major = LTPMAJOR;
-int test_iteration = 0;
-
-static char genhd_flags = 0;
-static struct gendisk *gd_ptr;
-static spinlock_t bdev_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
-
-MODULE_AUTHOR("Martin Ridgeway <mridge@us.ibm.com>");
-MODULE_DESCRIPTION(FS_LTP_TEST_DRIVER_NAME);
-MODULE_LICENSE("GPL");
-
-/*
- * Device operations for the virtual FS devices
- */
-
-static struct pm_dev *ltp_pm_dev = NULL;
-struct block_device *ltplookup_bdev(const char *path);
-int path_lookup(const char *name, unsigned int flags, struct nameidata *nd);
-//static int __emul_lookup_dentry(const char *name, struct nameidata *nd);
-void path_release(struct nameidata *nd);
-
-static int ltpdev_open(struct inode *pinode, struct file *pfile)
-{
-	printk(KERN_ALERT "ltpdev_open \n");
-	return 0;
-}
-
-static int ltpdev_release(struct inode *pinode, struct file *pfile)
-{
-
-	printk(KERN_ALERT "ltpdev_release \n");
-	return 0;
-}
-
-static int ltpdev_ioctl(struct inode *pinode, struct file *pfile,
-			unsigned int cmd, unsigned long arg)
-{
-
-	struct bio *my_bio = NULL;
-	struct bio *my_bio_copy = NULL;
-	request_queue_t *q = NULL;
-	struct block_device *bdev = NULL;
-	unsigned long uaddr;
-
-	unsigned int bytes_done = 100;
-
-	int error = 0;
-	int rc = 0;
-
-    /*****************************************************************************/
-
-	printk(KERN_ALERT "ltpdev_ioctl fs tests\n");
-
-	switch (cmd) {
-
-	case LTPAIODEV_CMD:
-		printk(KERN_ALERT "Running AIO FS tests \n");
-		printk(KERN_ALERT "AIO FS tests complete\n");
-		break;
-
-	case LTPBIODEV_CMD:
-
-		printk(KERN_ALERT "Running BIO FS tests \n");
-
-		my_bio = bio_alloc(GFP_KERNEL, 0);
-		if (!my_bio) {
-			printk(KERN_ALERT
-			       "Error getting kernel slab memory !!\n");
-		} else {
-			printk(KERN_ALERT "kernel slab memory alloc OK\n");
-		}
-
-		bio_endio(my_bio, bytes_done, error);
-
-		printk(KERN_ALERT "Return from bio_endio = %d \n", error);
-
-		my_bio_copy = bio_clone(my_bio, GFP_ATOMIC);
-
-		if (!my_bio_copy) {
-			printk(KERN_ALERT
-			       "Error getting kernel bio clone !!\n");
-		} else {
-			printk(KERN_ALERT "kernel bio clone OK\n");
-		}
-
-		my_bio_copy = bio_clone(my_bio, GFP_NOIO);
-
-		if (!my_bio_copy) {
-			printk(KERN_ALERT
-			       "Error getting kernel bio clone !!\n");
-		} else {
-			printk(KERN_ALERT "kernel bio clone OK\n");
-		}
-
-//        q = bdev_get_queue(my_bio->bi_bdev);
-
-//        rc = bio_phys_segments(q, my_bio);
-
-//        rc = bio_hw_segments(q, my_bio);
-
-		bdev = lookup_bdev(LTP_FS_DEVICE_NAME);
-
-		printk(KERN_ALERT "return from bdev size %d\n",
-		       bdev->bd_block_size);
-
-		printk(KERN_ALERT "Return from phys_segments = %d \n", rc);
-
-//        Don't use this API, causes system to hang and corrupts FS
-//        bio_put(my_bio);
-
-		(char *)uaddr = kmalloc(TEST_MEM_SIZE, GFP_KERNEL);
-
-		my_bio_copy = bio_map_user(bdev, uaddr, TEST_MEM_SIZE, FALSE);
-
-		printk(KERN_ALERT "Return from bio_map_user %p\n", my_bio_copy);
-
-		do_buffer_c_tests();
-
-		printk(KERN_ALERT "BIO FS tests complete\n");
-
-		break;
-	}
-
-	return 0;
-}
-
-static int ltp_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
-{
-	return 0;
-}
-
-int init_module(void)
-{
-	int result;
-
-	printk(KERN_ALERT "ltpdev_init_module \n");
-
-	ltp_pm_dev = pm_register(PM_UNKNOWN_DEV, 0, ltp_pm_callback);
-
-	result = register_blkdev(ltp_fs_major, LTP_FS_DEV_NAME);
-
-	printk(KERN_ALERT "LTP FS: register_blkdev result=%d major %d\n",
-	       result, ltp_fs_major);
-
-	if (result < 0) {
-		printk(KERN_ALERT "LTP FS: can't get major %d\n", ltp_fs_major);
-		return result;
-	}
-
-	gd_ptr = kmalloc(sizeof(struct gendisk *), GFP_KERNEL);
-
-	if (!gd_ptr) {
-		printk(KERN_ALERT "ERROR getting memory !!!\n");
-		return 0;
-	}
-
-	gd_ptr = alloc_disk(1);
-
-	printk(KERN_ALERT "gd_ptr after alloc = %p \n", gd_ptr);
-
-	gd_ptr->major = ltp_fs_major;
-	gd_ptr->first_minor = 0;
-	gd_ptr->fops = &blkops;
-	gd_ptr->driverfs_dev = NULL;
-	gd_ptr->capacity = MAX_NUM_DISKS;
-	gd_ptr->flags = genhd_flags;
-
-	sprintf(gd_ptr->disk_name, LTP_FS_DEV_NAME);
-
-	add_disk(gd_ptr);
-
-	return 0;
-}
-
-void cleanup_module(void)
-{
-
-	printk(KERN_ALERT "Exiting module and cleaning up \n");
-
-	pm_unregister(ltp_pm_dev);
-
-	put_disk(gd_ptr);
-
-	del_gendisk(gd_ptr);
-
-	unregister_blkdev(ltp_fs_major, LTP_FS_DEV_NAME);
-
-}
-
-static int do_buffer_c_tests()
-{
-	int line_no = 0;
-
-	printk(KERN_ALERT "Starting buffer.c coverage tests... \n");
-
-	__buffer_error("Test file", line_no);
-
-	printk(KERN_ALERT "buffer.c coverage tests complete...\n");
-
-	return 0;
-}
-
-/**
- * lookup_bdev  - lookup a struct block_device by name
- *
- * @path:	special file representing the block device
- *
- * Get a reference to the blockdevice at @path in the current
- * namespace if possible and return it.  Return ERR_PTR(error)
- * otherwise.
- */
-struct block_device *lookup_bdev(const char *path)
-{
-	struct block_device *bdev;
-	struct inode *inode;
-	struct nameidata nd;
-	int error;
-
-	if (!path || !*path)
-		return ERR_PTR(-EINVAL);
-
-	error = path_lookup(path, LOOKUP_FOLLOW, &nd);
-	if (error)
-		return ERR_PTR(error);
-
-	inode = nd.dentry->d_inode;
-	error = -ENOTBLK;
-	if (!S_ISBLK(inode->i_mode))
-		goto fail;
-	error = -EACCES;
-	if (nd.mnt->mnt_flags & MNT_NODEV)
-		goto fail;
-	error = bd_acquire(inode);
-	if (error)
-		goto fail;
-	bdev = inode->i_bdev;
-
-out:
-	path_release(&nd);
-	return bdev;
-fail:
-	bdev = ERR_PTR(error);
-	goto out;
-}
-
-int bd_acquire(struct inode *inode)
-{
-	struct block_device *bdev;
-	spin_lock(&bdev_lock);
-	if (inode->i_bdev) {
-		atomic_inc(&inode->i_bdev->bd_count);
-		spin_unlock(&bdev_lock);
-		return 0;
-	}
-	spin_unlock(&bdev_lock);
-	bdev = bdget(kdev_t_to_nr(inode->i_rdev));
-	if (!bdev)
-		return -ENOMEM;
-	spin_lock(&bdev_lock);
-	if (!inode->i_bdev) {
-		inode->i_bdev = bdev;
-		inode->i_mapping = bdev->bd_inode->i_mapping;
-		list_add(&inode->i_devices, &bdev->bd_inodes);
-	} else if (inode->i_bdev != bdev)
-		BUG();
-	spin_unlock(&bdev_lock);
-	return 0;
-}
diff --git a/testcases/kernel/fs/scsi/ltpfs/Makefile b/testcases/kernel/fs/scsi/ltpfs/Makefile
deleted file mode 100644
index 5f4030661..000000000
--- a/testcases/kernel/fs/scsi/ltpfs/Makefile
+++ /dev/null
@@ -1,30 +0,0 @@
-#
-# Makefile for GCOV profiling kernel module
-#
-
-#KERNELDIR := ../linux-2.5.73
-CFLAGS := $(CFLAGS) -Wall -g
-
-ifneq ($(KERNELRELEASE),)
-
-obj-m	:= LtpfsCmds.o
-obj-p   := ltpfstest
-else
-KDIR	:= /lib/modules/$(shell uname -r)/build
-PWD	:= $(shell pwd)
-
-default:
-	$(MAKE) -C $(KDIR) M=$(PWD) modules
-	${CC}  $(CFLAGS) -o ltpfstest -lm  main.c
-#	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules
-endif
-
-clean:
-	rm -f LtpfsCmds.o
-	rm -f LtpfsCmds.ko
-	rm -f LtpfsCmds.bb
-	rm -f LtpfsCmds.bbg
-	rm -f LtpfsCmds.mod.c
-	rm -f LtpfsCmds.mod.o
-	rm -f .*.mod*
-	rm -f .*.cmd
diff --git a/testcases/kernel/fs/scsi/ltpfs/ltpfs.part1 b/testcases/kernel/fs/scsi/ltpfs/ltpfs.part1
deleted file mode 100644
index 65086d536..000000000
--- a/testcases/kernel/fs/scsi/ltpfs/ltpfs.part1
+++ /dev/null
@@ -1,4 +0,0 @@
-#DESCRIPTION:filesystem tests
-# Check the EXT2 & NFS filesystems
-bfs101 ltpfstest /test/growfiles/ext2
-bfs102 ltpfstest /test/growfiles/nfs
diff --git a/testcases/kernel/fs/scsi/ltpfs/ltpfs.part2 b/testcases/kernel/fs/scsi/ltpfs/ltpfs.part2
deleted file mode 100644
index 86514908e..000000000
--- a/testcases/kernel/fs/scsi/ltpfs/ltpfs.part2
+++ /dev/null
@@ -1,3 +0,0 @@
-#DESCRIPTION:filesystem tests
-# Check the XFS filesystems
-bfs201 ltpfstest /test/growfiles/xfs
diff --git a/testcases/kernel/fs/scsi/ltpfs/ltpfs.part3 b/testcases/kernel/fs/scsi/ltpfs/ltpfs.part3
deleted file mode 100644
index 4f2ee5f21..000000000
--- a/testcases/kernel/fs/scsi/ltpfs/ltpfs.part3
+++ /dev/null
@@ -1,3 +0,0 @@
-#DESCRIPTION:filesystem tests
-# Check the MSDOS filesystems
-bfs101 ltpfstest /test/growfiles/msdos
diff --git a/testcases/kernel/fs/scsi/ltpfs/ltpfs.part4 b/testcases/kernel/fs/scsi/ltpfs/ltpfs.part4
deleted file mode 100644
index 84519512c..000000000
--- a/testcases/kernel/fs/scsi/ltpfs/ltpfs.part4
+++ /dev/null
@@ -1,3 +0,0 @@
-#DESCRIPTION:filesystem tests
-# Check the Reiser filesystems
-bfs401 ltpfstest /test/growfiles/reiser
diff --git a/testcases/kernel/fs/scsi/ltpfs/ltpfs.part5 b/testcases/kernel/fs/scsi/ltpfs/ltpfs.part5
deleted file mode 100644
index c3fa4d7aa..000000000
--- a/testcases/kernel/fs/scsi/ltpfs/ltpfs.part5
+++ /dev/null
@@ -1,3 +0,0 @@
-#DESCRIPTION:filesystem tests
-# Check the Minix filesystems
-bfs501 ltpfstest /test/growfiles/minix
diff --git a/testcases/kernel/fs/scsi/ltpfs/ltpfs.part6 b/testcases/kernel/fs/scsi/ltpfs/ltpfs.part6
deleted file mode 100644
index 0d600fe8e..000000000
--- a/testcases/kernel/fs/scsi/ltpfs/ltpfs.part6
+++ /dev/null
@@ -1,3 +0,0 @@
-#DESCRIPTION:filesystem tests
-# Check the EXT3 filesystems
-bfs601 ltpfstest /test/growfiles/ext3
diff --git a/testcases/kernel/fs/scsi/ltpfs/ltpfs.part7 b/testcases/kernel/fs/scsi/ltpfs/ltpfs.part7
deleted file mode 100644
index c9904d6be..000000000
--- a/testcases/kernel/fs/scsi/ltpfs/ltpfs.part7
+++ /dev/null
@@ -1,3 +0,0 @@
-#DESCRIPTION:filesystem tests
-# Check the JFS filesystems
-bfs701 ltpfstest /test/growfiles/jfs
diff --git a/testcases/kernel/fs/scsi/ltpfs/ltpfsio.sh b/testcases/kernel/fs/scsi/ltpfs/ltpfsio.sh
deleted file mode 100755
index ed3d8e2ab..000000000
--- a/testcases/kernel/fs/scsi/ltpfs/ltpfsio.sh
+++ /dev/null
@@ -1,154 +0,0 @@
--#!/bin/sh
-# This script should be run prior to running executing the filesystem tests.
-# valid devices need to be passed for the test to work correctly
-# 10/06/03 mridge@us.ibm.com added instance and time command line options
-#
-#
-
-cd `dirname $0`
-export LTPROOT=${PWD}
-echo $LTPROOT | grep testscripts > /dev/null 2>&1
-if [ $? -eq 0 ]; then
- cd ..
- export LTPROOT=${PWD}
-fi
-
-export TMPBASE="/tmp"
-
-
-usage()
-{
-	cat <<-END >&2
-	usage: ${0##*/} [ -a part1 ] [ -n nfsmount ]
-	defaults:
-	part1=$part1
-        nfsmount=$nfsmount
-	ltproot=$TPROOT
-	tmpdir=$TMPBASE
-
-	example: ${0##*/} -a hdc1 -b hdc2 -c hdc3 -d hdc4 -n mytesthost:/testmountdir
-
-        - This test will ONLY run on a 2.5.66 or higher kernel system.
-
-        - These operations are destructive so do NOT point the tests to partitions where the data shouldn't be overwritten.
-        Once these tests are started all data in the partitions you point to will be destroyed.
-
-	END
-exit
-}
-
-while getopts :a:n:v: arg
-do      case $arg in
-		a)	part1=$OPTARG;;
-                n)      nfsmount=$OPTARG;;
-                v)      verb=$OPTARG;;
-
-                \?)     echo "************** Help Info: ********************"
-                        usage;;
-        esac
-done
-
-if [ ! -n "$part1"  ]; then
-  echo "Missing 1st partition. You must pass 4 partitions for testing"
-  usage;
-  exit
-fi
-
-if [ ! -n "$nfsmount" ]; then
-  echo "Missing NFS partition. You must pass an NFS mount point for testing"
-  usage;
-  exit
-fi
-
-export PATH="${PATH}:${LTPROOT}/testcases/bin"
-
-
-mkdir /test                   >/dev/null 2>&1
-mkdir /test/growfiles         >/dev/null 2>&1
-mkdir /test/growfiles/ext2    >/dev/null 2>&1
-mkdir /test/growfiles/msdos   >/dev/null 2>&1
-mkdir /test/growfiles/reiser  >/dev/null 2>&1
-mkdir /test/growfiles/minix   >/dev/null 2>&1
-mkdir /test/growfiles/xfs     >/dev/null 2>&1
-mkdir /test/growfiles/nfs     >/dev/null 2>&1
-mkdir /test/growfiles/jfs     >/dev/null 2>&1
-mkdir /test/growfiles/ext3 >/dev/null 2>&1
-
-
-mkfs -V -t ext2     /dev/$part1
-
-
-mount -v -t nfs $nfsmount               /test/growfiles/nfs
-mount -v /dev/$part1 /test/growfiles/ext2
-
-
-echo "************ Running tests "
-sort -R ${LTPROOT}/runtest/ltpfs.part1 -o ${TMPBASE}/ltpfs.part1
-
-${LTPROOT}/pan/pan -e -S -a ltpfspart1 -n ltpfspart1 -l lvmlogfile -f ${TMPBASE}/ltpfs.part1 &
-
-wait $!
-
-umount -v -t nfs $nfsmount
-umount -v /dev/$part1
-mkfs.xfs -f   /dev/$part1
-mount -v /dev/$part1 /test/growfiles/xfs
-
-
-sort -R ${LTPROOT}/runtest/ltpfs.part2 -o ${TMPBASE}/ltpfs.part2
-
-${LTPROOT}/pan/pan -e -S -a ltpfspart2 -n ltpfspart2 -l lvmlogfile -f ${TMPBASE}/ltpfs.part2 &
-
-wait $!
-
-mkfs -V -t msdos    /dev/$part1
-umount -v /dev/$part1
-mount -v /dev/$part1 /test/growfiles/msdos
-
-sort -R ${LTPROOT}/runtest/ltpfs.part3 -o ${TMPBASE}/ltpfs.part3
-
-${LTPROOT}/pan/pan -e -S -a ltpfspart3 -n ltpfspart3 -l lvmlogfile -f ${TMPBASE}/ltpfs.part3 &
-
-wait $!
-
-umount -v /dev/$part1
-mkreiserfs          /dev/$part1 <yesenter.txt
-mount -v /dev/$part1 /test/growfiles/reiser
-
-sort -R ${LTPROOT}/runtest/ltpfs.part4 -o ${TMPBASE}/ltpfs.part4
-
-${LTPROOT}/pan/pan -e -S -a ltpfspart4 -n ltpfspart4 -l lvmlogfile -f ${TMPBASE}/ltpfs.part4 &
-
-wait $!
-
-umount -v /dev/$part1
-mkfs -V -t minix    /dev/$part1
-mount -v /dev/$part1 /test/growfiles/minix
-
-sort -R ${LTPROOT}/runtest/ltpfs.part5 -o ${TMPBASE}/ltpfs.part5
-
-${LTPROOT}/pan/pan -e -S -a ltpfspart5 -n ltpfspart5 -l lvmlogfile -f ${TMPBASE}/ltpfs.part5 &
-
-wait $!
-
-umount -v /dev/$part1
-mkfs -V -t ext3     /dev/$part1
-mount -v /dev/$part1 /test/growfiles/ext3
-
-sort -R ${LTPROOT}/runtest/ltpfs.part6 -o ${TMPBASE}/ltpfs.part6
-
-${LTPROOT}/pan/pan -e -S -a ltpfspart6 -n ltpfspart6 -l lvmlogfile -f ${TMPBASE}/ltpfs.part6 &
-
-wait $!
-
-umount -v /dev/$part1
-mkfs -V -t jfs /dev/$part1  <yesenter.txt
-mount -v -t jfs    /dev/$part1           /test/growfiles/jfs
-
-sort -R ${LTPROOT}/runtest/ltpfs.part7 -o ${TMPBASE}/ltpfs.part7
-
-${LTPROOT}/pan/pan -e -S -a ltpfspart7 -n ltpfspart7 -l lvmlogfile -f ${TMPBASE}/ltpfs.part7 &
-
-wait $!
-
-
diff --git a/testcases/kernel/fs/scsi/ltpfs/main.c b/testcases/kernel/fs/scsi/ltpfs/main.c
deleted file mode 100644
index 90a5531ac..000000000
--- a/testcases/kernel/fs/scsi/ltpfs/main.c
+++ /dev/null
@@ -1,647 +0,0 @@
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <ctype.h>
-#include <errno.h>
-#include <math.h>
-#include <time.h>
-#include <ftw.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <sys/ioctl.h>
-#include <linux/kd.h>
-#include <linux/errno.h>
-
-#include "Ltpfs.h"
-
-#define M_2PI (M_PI*2)
-#define MAXN 4096
-#define MAXFSIZE 1024 * 192
-#define FILE_CREATE_COUNT 256
-#define FAIL 0
-#define SUCCESS 1
-#define MAXNUM   5000
-#define BUFFSIZE 8192
-#define AVEFSIZE (MAXFSIZE/2)
-#define POOLDISKSPACE (AVEFSIZE*128)
-#define MAXERROR  1024
-#define FILES_ONLY 0x01
-#define ALL        0x00
-
-// Globals
-
-char wbuf[MAXFSIZE];
-int startc = 0;
-int showchar[] = { 124, 47, 45, 92, 124, 47, 45, 92 };
-
-int nullFileHandle;
-static int openlog[2] = { 0, 0 };
-
-int cFileCount, dFileCount, errorCount;
-static int disk_space_pool = 0;
-char rootPath[BUFFSIZE];
-
-int LTP_fs_open_block_device(void);
-int do_fs_thump_tests(char *path);
-int do_create_file_test(char *path);
-int makedir(char *dir1);
-int changedir(char *dir);
-int do_random_access_test(int maxNum);
-int do_random_create_delete(int maxNum);
-int create_file(char *filename);
-int delete_file(char *filename);
-int gen_random_file_size(int min, int max);
-int open_read_close(char *fname);
-int create_or_delete(char *fname);
-int do_tree_cleanup(char *path, int flag);
-int cleanup_files(char *file, struct stat *statBuff, int flag);
-int cleanup_dirs(char *file, struct stat *statBuff, int flag);
-
-int ltp_block_dev_handle = 0;	/* handle to LTP Test block device */
-int ltp_fileHandle = 0;
-char *fileBuf;
-
-int main(int argc, char **argv)
-{
-
-	ltpdev_cmd_t cmd = { 0, 0 };
-	int rc, i, tmpHandle;
-	struct stat statBuf;
-
-	printf("[%s] - Running test program\n", argv[0]);
-
-	rc = LTP_fs_open_block_device();
-
-	if (!rc) {
-
-		ltp_block_dev_handle = open(LTP_FS_DEVICE_NAME, O_RDWR);
-
-		if (ltp_block_dev_handle < 0) {
-			printf
-			    ("ERROR: Open of device %s failed %d errno = %d\n",
-			     LTP_FS_DEVICE_NAME, ltp_block_dev_handle, errno);
-		} else {
-			rc = ioctl(ltp_block_dev_handle, LTPAIODEV_CMD, &cmd);
-
-			printf("return from AIO ioctl %d \n", rc);
-
-			rc = ioctl(ltp_block_dev_handle, LTPBIODEV_CMD, &cmd);
-
-			printf("return from BIO ioctl %d \n", rc);
-		}
-
-	} else {
-		printf("ERROR: Create/open block device failed\n");
-	}
-
-	ltp_fileHandle =
-	    open("/tmp/testfile", O_CREAT | O_RDWR | O_SYNC | FASYNC,
-		 S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	if (ltp_fileHandle > 0) {
-
-		tmpHandle = open("/usr/include/ctype.h", O_RDONLY);
-
-		if (tmpHandle > 0) {
-
-			rc = fstat(tmpHandle, &statBuf);
-
-			if (!rc) {
-				fileBuf = malloc(statBuf.st_size);
-
-				if (fileBuf) {
-
-					read(tmpHandle, fileBuf,
-					     statBuf.st_size);
-					close(tmpHandle);
-					write(ltp_fileHandle, fileBuf,
-					      statBuf.st_size);
-
-					for (i = 0; i < 100; i++) {
-						read(ltp_fileHandle, fileBuf,
-						     statBuf.st_size * i);
-						write(ltp_fileHandle, fileBuf,
-						      statBuf.st_size * i);
-					}
-				}
-
-			}
-
-		} else {
-			printf("ERROR: Create/open file failed\n");
-		}
-	}
-
-	printf("*** Starting FileSystem thump tests....****\n");
-	printf("*** Please be patient, this may take a little while... ***\n");
-
-	for (i = 1; i < argc; i++) {
-		printf("Running test %d of %d on FileSystem %s \n", i, argc - 1,
-		       argv[i]);
-		if (strcmp(argv[i], "|") != 0) {
-			strcpy(rootPath, argv[i]);
-			rc = do_fs_thump_tests(argv[i]);
-			if (rc != 0 && rc != ENOSPC) {
-				printf
-				    ("ERROR: Failed on FileSystem %s with errno %d \n",
-				     argv[i], rc);
-			}
-		} else {
-			printf("Test Program complete..\n");
-			break;
-		}
-
-	}
-
-	printf("Test Program complete..\n");
-
-	return 0;
-}
-
-int do_fs_thump_tests(char *path)
-{
-	int rc = 0;
-
-	printf("Changing to directory %s \n", path);
-
-	changedir(path);
-
-	cFileCount = 0;
-	dFileCount = 0;
-
-	rc |= do_create_file_test(path);
-	rc |= do_random_access_test(MAXNUM);
-	rc |= do_tree_cleanup(path, FILES_ONLY);
-	rc |= do_random_create_delete(MAXNUM);
-	rc |= do_tree_cleanup(path, ALL);
-
-	return rc;
-
-}
-
-int do_tree_cleanup(char *path, int flag)
-{
-
-	if (flag == FILES_ONLY) {
-		printf("Cleaning up test files...\n");
-		ftw(path, (void *)cleanup_files, MAXNUM);
-	} else {
-		printf("Cleaning up everything in the test directory...\n");
-		ftw(path, (void *)cleanup_files, MAXNUM);
-		ftw(path, (void *)cleanup_dirs, MAXNUM);
-	}
-
-	return 0;
-}
-
-int cleanup_files(char *file, struct stat *statBuff, int flag)
-{
-	int rc = 0;
-
-	if (flag == FTW_F) {
-		if (unlink(file)) {
-			printf("ERROR:%d removing file %s\n", errno, file);
-		}
-	}
-
-	return rc;
-}
-
-int cleanup_dirs(char *file, struct stat *statBuff, int flag)
-{
-	int rc = 0;
-
-	//printf("%s:Cleaning up directory %s \n", __FUNCTION__, file);
-
-	if (strcmp(rootPath, file) == 0) {
-		return 0;
-	}
-
-	if (flag == FTW_F) {
-		if (unlink(file)) {
-			printf("ERROR:%d removing file %s\n", errno, file);
-		}
-	} else if (flag == FTW_D) {
-		changedir(file);
-		ftw(file, (void *)cleanup_dirs, MAXNUM);
-		rmdir(file);
-
-	} else {
-		printf("No idea what we found here\n");
-	}
-
-	return rc;
-}
-
-int do_create_file_test(char *path)
-{
-	int i = 0;
-	int j = 0;
-	int k = 0;
-	int l = 0;
-	int rc = 0;
-
-	char dir1[MAXN];
-	char dir2[MAXN];
-	char dir3[MAXN];
-	char filename[MAXN];
-
-	time_t t;
-
-	int maxfiles = 0xFFFFFF;
-
-	time(&t);
-
-	srandom((unsigned int)getpid() ^
-		(((unsigned int)t << 16) | (unsigned int)t >> 16));
-
-	printf("Creating files...\n");
-
-	for (i = 0; i < FILE_CREATE_COUNT; i++) {
-
-		sprintf(dir1, "%2.2x", i);
-
-		makedir(dir1);
-
-		changedir(dir1);
-
-		for (j = 0; j < FILE_CREATE_COUNT; j++) {
-
-			sprintf(dir2, "%2.2x", j);
-
-			makedir(dir2);
-
-			changedir(dir2);
-
-			for (k = 0; k < FILE_CREATE_COUNT; k++) {
-
-				sprintf(dir3, "%2.2x", k);
-				makedir(dir3);
-				changedir(dir3);
-
-				for (l = 0; l < FILE_CREATE_COUNT; l++) {
-					sprintf(filename, "%s%s%s%2.2x", dir1,
-						dir2, dir3, l);
-					rc = create_file(filename);
-					if (rc != 0 || maxfiles < dFileCount++) {
-						if (rc != ENOSPC) {
-							printf
-							    ("ERROR: failed error:%d creating all the test files ! \n",
-							     errno);
-							printf
-							    ("ERROR2: rc:%d -- dFileCount:%d \n",
-							     rc, dFileCount);
-						}
-						goto end;
-					}
-				}
-				changedir("../");
-			}
-			changedir("../");
-		}
-		changedir("../");
-	}
-end:
-	fprintf(stderr, "\nTotal create files: %d\n", cFileCount);
-	printf("Done\n");
-	return rc;
-}
-
-int makedir(char *dir1)
-{
-	if (mkdir(dir1, S_IRWXU) < 0) {
-		perror(dir1);
-		return (errno);
-	}
-	return 0;
-}
-
-int changedir(char *dir)
-{
-	if (chdir(dir) < 0) {
-		perror(dir);
-		return (errno);
-	}
-
-	return 0;
-}
-
-int create_file(char *filename)
-{
-	int fileHandle;
-	int randomsize;
-
-	if ((fileHandle = creat(filename, S_IRWXU)) < 0) {
-
-		fprintf(stderr, "\nERROR line %d: Total create files: %d\n",
-			__LINE__, cFileCount);
-		perror(filename);
-		return (errno);
-	}
-
-	if ((randomsize = gen_random_file_size(0, MAXFSIZE)) < 0) {
-		randomsize = MAXFSIZE;
-	}
-	if (write(fileHandle, wbuf, randomsize) < 0) {
-
-		fprintf(stderr, "\nERROR:%d line%d: Total create files: %d\n",
-			errno, __LINE__, cFileCount);
-		close(fileHandle);
-
-		perror(filename);
-		return (errno);
-	}
-
-	cFileCount++;
-	close(fileHandle);
-	return 0;
-}
-
-int delete_file(char *filename)
-{
-	struct stat buf;
-	int st;
-
-	st = stat(filename, &buf);
-
-	if (st < 0) {
-		errorCount++;
-		printf("ERROR line %d: Getting file stats %s \n", __LINE__,
-		       filename);
-		return (-1);
-	}
-
-	disk_space_pool += buf.st_size;
-
-	if (unlink(filename) < 0) {
-		errorCount++;
-		printf("ERROR line %d: Removing file %s \n", __LINE__,
-		       filename);
-		return (-1);
-	}
-
-	dFileCount++;
-	return 0;
-}
-
-int LTP_fs_open_block_device()
-{
-	dev_t devt;
-	struct stat statbuf;
-	int rc = 0;
-
-	if (ltp_block_dev_handle == 0) {
-
-		/* check for the /dev/LTPFSTest subdir, and create if it does not exist.
-		 *
-		 * If devfs is running and mounted on /dev, these checks will all pass,
-		 * so a new node will not be created.
-		 */
-		devt = makedev(LTPMAJOR, 0);
-
-		rc = stat(LTP_FS_DEV_NODE_PATH, &statbuf);
-
-		if (rc) {
-			if (errno == ENOENT) {
-				/* dev node does not exist. */
-				rc = mkdir(LTP_FS_DEV_NODE_PATH,
-					   (S_IFDIR | S_IRWXU | S_IRGRP |
-					    S_IXGRP | S_IROTH | S_IXOTH));
-			} else {
-				printf
-				    ("ERROR: Problem with LTP FS dev directory.  Error code from stat() is %d\n\n",
-				     errno);
-			}
-
-		} else {
-			if (!(statbuf.st_mode & S_IFDIR)) {
-				rc = unlink(LTP_FS_DEV_NODE_PATH);
-				if (!rc) {
-					rc = mkdir(LTP_FS_DEV_NODE_PATH,
-						   (S_IFDIR | S_IRWXU | S_IRGRP
-						    | S_IXGRP | S_IROTH |
-						    S_IXOTH));
-				}
-			}
-		}
-
-		/*
-		 * Check for the /dev/ltp-fs/block_device node, and create if it does not
-		 * exist.
-		 */
-		rc = stat(LTP_FS_DEVICE_NAME, &statbuf);
-		if (rc) {
-			if (errno == ENOENT) {
-				/* dev node does not exist */
-				rc = mknod(LTP_FS_DEVICE_NAME,
-					   (S_IFBLK | S_IRUSR | S_IWUSR |
-					    S_IRGRP | S_IWGRP), devt);
-			} else {
-				printf
-				    ("ERROR:Problem with LTP FS block device node directory.  Error code form stat() is %d\n\n",
-				     errno);
-			}
-
-		} else {
-			/*
-			 * /dev/ltp-fs/block_device exists.  Check to make sure it is for a
-			 * block device and that it has the right major and minor.
-			 */
-			if ((!(statbuf.st_mode & S_IFBLK)) ||
-			    (statbuf.st_rdev != devt)) {
-
-				/* Recreate the dev node. */
-				rc = unlink(LTP_FS_DEVICE_NAME);
-				if (!rc) {
-					rc = mknod(LTP_FS_DEVICE_NAME,
-						   (S_IFBLK | S_IRUSR | S_IWUSR
-						    | S_IRGRP | S_IWGRP), devt);
-				}
-			}
-		}
-
-	}
-
-	return rc;
-}
-
-int gen_random_file_size(int min, int max)
-{
-	double u1, u2, z;
-	int i;
-	int ave;
-	int range;
-	int ZZ;
-	if (min >= max) {
-		return (-1);
-	}
-	range = max - min;
-	ave = range / 2;
-	for (i = 0; i < 10; i++) {
-		u1 = ((double)(random() % 1000000)) / 1000000;
-		u2 = ((double)(random() % 1000000)) / 1000000;
-		z = sqrt(-2.0 * log(u1)) * cos(M_2PI * u2);
-		ZZ = min + (ave + (z * (ave / 4)));
-		if (ZZ >= min && ZZ < max) {
-			return (ZZ);
-		}
-	}
-	return (-1);
-}
-
-int do_random_access_test(int maxNum)
-{
-	int r;
-	char fname[1024];
-	time_t t;
-	int i;
-
-	printf("Running random access test...\n");
-	changedir(rootPath);
-
-	if (maxNum < 1 || maxNum > MAXNUM) {
-		printf("out of size %d\n", maxNum);
-		return 1;
-	}
-
-	time(&t);
-	srandom((unsigned int)getpid() ^
-		(((unsigned int)t << 16) | (unsigned int)t >> 16));
-
-	if ((nullFileHandle = open("/dev/null", O_WRONLY)) < 0) {
-		perror("/dev/null");
-		return (errno);
-	}
-
-	/* 00/00/00/00 */
-	for (i = 0; i < maxNum; i++) {
-
-		r = random() % maxNum;
-
-		sprintf(fname, "00/%2.2x/%2.2x/00%2.2x%2.2x%2.2x",
-			((r >> 16) & 0xFF),
-			((r >> 8) & 0xFF),
-			((r >> 16) & 0xFF), ((r >> 8) & 0xFF), (r & 0xFF));
-
-		open_read_close(fname);
-	}
-	close(nullFileHandle);
-	printf("Success:\t%d\nFail:\t%d\n", openlog[SUCCESS], openlog[FAIL]);
-	return 0;
-}
-
-int open_read_close(char *fname)
-{
-	int fileHandle, fileHandle2;
-	char buffer[BUFFSIZE];
-	int c;
-
-	if ((fileHandle = open(fname, O_RDONLY | O_SYNC | O_ASYNC)) < 0) {
-		openlog[FAIL]++;
-		printf("ERROR:opening file %s failed %d \n", fname, errno);
-		return (errno);
-	}
-
-	if ((fileHandle2 = open(fname, O_RDONLY | O_SYNC | O_ASYNC)) < 0) {
-		openlog[FAIL]++;
-		printf("ERROR:2nd opening file %s failed %d \n", fname, errno);
-		return (errno);
-	}
-
-	openlog[SUCCESS]++;
-
-	while ((c = read(fileHandle, buffer, BUFFSIZE)) > 0) {
-		if (write(nullFileHandle, buffer, c) < 0) {
-			perror("/dev/null");
-			printf("Opened\t %d\nUnopend:\t%d\n", openlog[SUCCESS],
-			       openlog[FAIL]);
-			close(fileHandle2);
-			close(fileHandle);
-			return (errno);
-		}
-		if ((c = read(fileHandle2, buffer, BUFFSIZE)) > 0) {
-			if (write(nullFileHandle, buffer, c) < 0) {
-				perror("/dev/null");
-				printf("Opened\t %d\nUnopend:\t%d\n",
-				       openlog[SUCCESS], openlog[FAIL]);
-				close(fileHandle2);
-				close(fileHandle);
-				return (errno);
-			}
-		}
-	}
-
-	if (c < 0) {
-		perror(fname);
-		printf("Opened\t %d\nUnopend:\t%d\n", openlog[SUCCESS],
-		       openlog[FAIL]);
-		return (errno);
-	}
-
-	close(fileHandle2);
-	close(fileHandle);
-	return 0;
-}
-
-int create_or_delete(char *fname)
-{
-	int r, rc;
-
-	r = (random() & 1);
-
-	/* create */
-	if ((create_file(fname) == 0)) {
-		rc = delete_file(fname);
-	} else {
-		printf("Error: %d creating random file \n", errno);
-	}
-
-	if ((errorCount > dFileCount || errorCount > cFileCount)
-	    && (errorCount > MAXERROR)) {
-		fprintf(stderr, "Too many errors -- Aborting test\n");
-		fprintf(stderr, "Total create files: %d\n", cFileCount);
-		fprintf(stderr, "Total delete files: %d\n", dFileCount);
-		fprintf(stderr, "Total error       : %d\n", errorCount);
-		return (MAXERROR);
-	}
-
-	return 0;
-}
-
-int do_random_create_delete(int maxNum)
-{
-	int r, rc = 0;
-	char fname[1024];
-	time_t t;
-	int i;
-
-	printf("Running random create/delete test...\n");
-
-	if (maxNum < 1 || maxNum > MAXNUM) {
-		printf("MAX out of size %d\n", maxNum);
-		return (maxNum);
-	}
-
-	time(&t);
-	srandom((unsigned int)getpid() ^
-		(((unsigned int)t << 16) | (unsigned int)t >> 16));
-
-	/* 00/00/00/00 */
-	for (i = 0; i < maxNum && rc != MAXERROR; i++) {
-		r = random() % maxNum;
-		sprintf(fname, "00/%2.2x/%2.2x/00%2.2x%2.2x%2.2x",
-			((r >> 16) & 0xFF),
-			((r >> 8) & 0xFF),
-			((r >> 16) & 0xFF), ((r >> 8) & 0xFF), (r & 0xFF));
-
-		rc = create_or_delete(fname);
-	}
-
-	fprintf(stderr, "Total create files: %d\n", cFileCount);
-	fprintf(stderr, "Total delete files: %d\n", dFileCount);
-	fprintf(stderr, "Total error       : %d\n", errorCount);
-	return (rc);
-}
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
