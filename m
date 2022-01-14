Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEF0C433EF
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 14:53:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 15CE43C9575
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 15:52:58 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57E3D3C9506
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 15:52:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A184C1A01473
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 15:52:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E37401F45E;
 Fri, 14 Jan 2022 14:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1642171966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hjNmw13QlVbj0BIVBF/KAQMhnk/IlFQCNMkJOGXXqzA=;
 b=1IpoeYIXed/68bgMwvrhx1wAP5s14TSB/VSOwtbwDpylECi+IUmwy2NhHbXcZomo4k719g
 SCzolXNuXrkZ6VbEUR7Nz5rvEAMrQzSvjD3iENWA8f0tW0yTXFaSDwG9he/3+hgbNmoqlZ
 NO8qfJu58qIg0Eku3Kr2XJMglw97t3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1642171966;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hjNmw13QlVbj0BIVBF/KAQMhnk/IlFQCNMkJOGXXqzA=;
 b=ILRlevGYBJ6Xti1TJhGBfWF7Vb7OU0H0QwfGvlS2iUC+gbnA6j/g2u0KY7iqqJqhlz5KIm
 RkpwR5Y8D57mPoCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AFF1513C27;
 Fri, 14 Jan 2022 14:52:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id r2U0KD6O4WHmPgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 14 Jan 2022 14:52:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 14 Jan 2022 15:52:27 +0100
Message-Id: <20220114145227.12707-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add tst_dev_block_size utility
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Added tst_dev_block_size function in tst_device.c and updated
c-test-api.txt documentation.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 doc/c-test-api.txt            | 11 ++++
 include/tst_device.h          |  7 +++
 lib/newlib_tests/tst_device.c | 96 +++++++++++++++++++++++++++--------
 lib/tst_device.c              | 15 ++++++
 4 files changed, 109 insertions(+), 20 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 123d3f1fc..0cb391a0a 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -1034,6 +1034,17 @@ uint64_t tst_get_device_size(const char *dev_path);
 This function gets size of the given block device, it checks the 'dev_path' is
 valid first, if yes, return the size in MB, otherwise return -1.
 
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
+int tst_dev_block_size(const char *path);
+-------------------------------------------------------------------------------
+
+This function returns the size of a single IO block for the specific `path`.
+It finds the device where `path` is located and then uses `ioctl` to get a
+single device block size.
+
 1.16 Formatting a device with a filesystem
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/include/tst_device.h b/include/tst_device.h
index 72c560c02..bf0fb5320 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -112,4 +112,11 @@ void tst_purge_dir(const char *path);
  */
 void tst_find_backing_dev(const char *path, char *dev);
 
+/*
+ * Returns the size of a single IO block for the specific path
+ * @path   Path to find the block size
+ * @return Size of the block size
+ */
+int tst_dev_block_size(const char *path);
+
 #endif	/* TST_DEVICE_H__ */
diff --git a/lib/newlib_tests/tst_device.c b/lib/newlib_tests/tst_device.c
index 0bee0a939..3f9a43576 100644
--- a/lib/newlib_tests/tst_device.c
+++ b/lib/newlib_tests/tst_device.c
@@ -1,47 +1,103 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Linux Test Project
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
+#define _GNU_SOURCE
 
 #include <stdlib.h>
 #include <sys/mount.h>
 #include <stdint.h>
+#include <stdio.h>
+#include <lapi/loop.h>
+#include <time.h>
 
 #include "tst_test.h"
 
-static void do_test(void)
+#define PAGESIZE 2048
+#define DEV_MIN_SIZE 300
+
+static char *mntpoint;
+static uint64_t ltp_dev_size;
+
+static void setup(void)
 {
 	int fd;
-	const char *dev;
-	char block_dev[100];
-	uint64_t ltp_dev_size;
+	int ret;
 
-	dev = tst_device->dev;
-	if (!dev)
-		tst_brk(TCONF, "Failed to acquire test device");
+	ret = asprintf(&mntpoint, "%s/mnt", tst_get_tmpdir());
+	if (ret < 0)
+		tst_brk(TBROK, "asprintf failure");
 
-	SAFE_MKFS(dev, "ext2", NULL, NULL);
+	while ((fd = SAFE_OPEN(tst_device->dev, O_RDONLY, 0666)) < 0)
+		usleep(100);
 
-	fd = SAFE_OPEN(dev, O_RDONLY);
 	SAFE_IOCTL(fd, BLKGETSIZE64, &ltp_dev_size);
+	SAFE_IOCTL(fd, LOOP_SET_BLOCK_SIZE, PAGESIZE);
 	SAFE_CLOSE(fd);
 
-	if (ltp_dev_size/1024/1024 == 300)
-		tst_res(TPASS, "Got expected device size");
+	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
+
+	SAFE_MKDIR(mntpoint, 0777);
+	SAFE_MOUNT(tst_device->dev, mntpoint, tst_device->fs_type, 0, 0);
+}
+
+static void cleanup(void)
+{
+	if (tst_is_mounted(mntpoint))
+		SAFE_UMOUNT(mntpoint);
+}
+
+static void test_dev_min_size(void)
+{
+	uint64_t size;
+
+	size = ltp_dev_size / 1024 / 1024;
+
+	if (size == DEV_MIN_SIZE)
+		tst_res(TPASS, "Got expected device size %lu", size);
+	else
+		tst_res(TFAIL, "Expected device size is %d but got %lu", DEV_MIN_SIZE, size);
+}
+
+static void test_tst_find_backing_dev(void)
+{
+	char block_dev[100];
+
+	tst_find_backing_dev(mntpoint, block_dev);
+
+	if (!strcmp(tst_device->dev, block_dev))
+		tst_res(TPASS, "%s belongs to %s block dev", mntpoint, block_dev);
 	else
-		tst_res(TFAIL, "Got unexpected device size");
-
-	tst_find_backing_dev("/boot", block_dev);
-	tst_res(TPASS, "/boot belongs to %s block dev", block_dev);
-	tst_find_backing_dev("/", block_dev);
-	tst_res(TPASS, "/ belongs to %s block dev", block_dev);
-	tst_find_backing_dev("/tmp", block_dev);
-	tst_find_backing_dev("/boot/xuyang", block_dev);
+		tst_res(TFAIL, "%s should belong to %s, but %s is returned", mntpoint, tst_device->dev, block_dev);
+}
+
+static void test_tst_dev_block_size(void)
+{
+	int block_size;
+
+	block_size = tst_dev_block_size(mntpoint);
+
+	if (block_size == PAGESIZE)
+		tst_res(TPASS, "%s has %d block size", mntpoint, block_size);
+	else
+		tst_res(TFAIL, "%s has %d block size, but expected is %i", mntpoint, block_size, PAGESIZE);
+}
+
+static void do_test(void)
+{
+	test_dev_min_size();
+	test_tst_find_backing_dev();
+	test_tst_dev_block_size();
 }
 
 static struct tst_test test = {
 	.needs_root = 1,
 	.needs_device = 1,
-	.dev_min_size = 300,
+	.needs_tmpdir = 1,
+	.dev_min_size = DEV_MIN_SIZE,
 	.test_all = do_test,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "4.14",
 };
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 73e70d26e..1ef667fa0 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -547,3 +547,18 @@ void tst_find_backing_dev(const char *path, char *dev)
 	if (S_ISBLK(buf.st_mode) != 1)
 		tst_brkm(TCONF, NULL, "dev(%s) isn't a block dev", dev);
 }
+
+int tst_dev_block_size(const char *path)
+{
+	int fd;
+	int size;
+	char dev_name[1024];
+
+	tst_find_backing_dev(path, dev_name);
+
+	fd = SAFE_OPEN(NULL, dev_name, O_RDONLY);
+	SAFE_IOCTL(NULL, fd, BLKSSZGET, &size);
+	SAFE_CLOSE(NULL, fd);
+
+	return size;
+}
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
