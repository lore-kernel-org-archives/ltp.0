Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A9FC6FD1C
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 23:52:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68C363CABD0
	for <ltp@archiver.kernel.org>; Tue, 21 Mar 2023 00:52:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 172573C95FB
 for <ltp@lists.linux.it>; Tue, 21 Mar 2023 00:51:20 +0100 (CET)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4AF086006C9
 for <ltp@lists.linux.it>; Tue, 21 Mar 2023 00:51:20 +0100 (CET)
Received: by mail-pg1-x549.google.com with SMTP id
 t2-20020a632d02000000b005075b896422so3054130pgt.19
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 16:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1679356279;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=e4JVBtzlTGJG+ZmfbdHL4Z4c1/9QdQoljHtTpLViGog=;
 b=WIFytlMbPVEysZhNdjt/2ulqF4AKuF/Bitkx3TRmLGoVTDJtlHi90GX2GecfYJUIjF
 98ldk/fj6LpbEy/cJXeByRoOHzWeIurrkDzCQvbPL7hO4AaXRaMfkl8u9hHGb9HX3hPl
 Dww4ntyA7Hna9Oija245ugah1xNc4vHmvm+u4M0NWnowZcl9Ouem73iiZoiVl7Fc0CpT
 Ab3eKRklpodCJ+OFo4GmjsZMNubJNJfy4B9yJClHjdyHBdecDSZgZZqVmAcgaBz3agzh
 cjrI11TAujMEKhihKzWn2CcmDlf8ypdUNDTmTdX/ixOBjXG2Tvv+ixZkv646ZZnLhopo
 teHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679356279;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e4JVBtzlTGJG+ZmfbdHL4Z4c1/9QdQoljHtTpLViGog=;
 b=VfNuqYA2fukZw2kSfDQMb9ezQbd0FfX0i8TbtwfU9YCuE4+0iFPjqGg5YZB0X4P5xB
 AmwiTUunQn3mJHDz9AU2eaARTXgy3XtFrojAqoY2xDC4tQMasMfFoGmOYoKlRUzsibbS
 J46zm2S/q8eiGpwsFzHssc5v/wvgeuIQRCxpm81wBbC+wGzHbgrrXvmR3m8CKW94gGFu
 6y624MJXCa6BxouDClOGvDfHJoyrQIo/T1+380nt6iczJd6lcTMgBtF07RVqvqsJGRzD
 emTWvVIMCPgLkVzEPJ9MvI5nXesIBbUu79Mn5RqN2EVHwnZLpz1KqHlIPwjGBHvFf2zQ
 NJXg==
X-Gm-Message-State: AO0yUKVLx5u2hl5JEvyq6jnDGd4vZNoBQyAeWCfr2RCYXRMuJNsItuBW
 0sX8arWBamfi3Or0nwFYLja5zkXRxC3tanWKaQieq50Y2gGiiRXqJJ8KxcFYHe5pboSHTqwb7RW
 IdrAHl4a8D0qrXwca3JGd2ovIEZKXE6By/5GolEUIeY8TIjuc02pEnluG
X-Google-Smtp-Source: AK7set/azfWsAW0rROoQEBDVCCFJL7AzvHsSyf3D0echVxhy4icMKcdpexA2LWPFfQaDWWjRNLLBXik2EOM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:e748:b0:19f:2aa4:b1e5 with SMTP id
 p8-20020a170902e74800b0019f2aa4b1e5mr85736plf.2.1679356278646; Mon, 20 Mar
 2023 16:51:18 -0700 (PDT)
Date: Mon, 20 Mar 2023 23:51:08 +0000
In-Reply-To: <20230320235108.2058967-1-edliaw@google.com>
Mime-Version: 1.0
References: <20230320235108.2058967-1-edliaw@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230320235108.2058967-4-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] tst_find_backing_dev: Also check /dev/block/
 for backing device
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Android, the backing devices are created in /dev/block/ and will not
be found using the method added in e1b1ae66b240 ("tst_find_backing_dev:
Get dev name from /sys/dev/block/*/uevent").  Adds a check for
/dev/block/%s as well as /dev/%s.

Modified the function signature of tst_find_backing_dev to add the
length of the dev path string.  Updated the documentation and code that
references it.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 doc/c-test-api.txt                            |  2 +-
 include/tst_device.h                          |  3 +-
 lib/newlib_tests/tst_device.c                 |  2 +-
 lib/tst_device.c                              | 37 +++++++++++++------
 .../kernel/syscalls/ioctl/ioctl_loop05.c      |  2 +-
 5 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index a7dd59dac..eddb5c893 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -1087,7 +1087,7 @@ is created for that intention.
 -------------------------------------------------------------------------------
 #include "tst_test.h"
 
-void tst_find_backing_dev(const char *path, char *dev);
+void tst_find_backing_dev(const char *path, char *dev, size_t dev_len);
 -------------------------------------------------------------------------------
 
 This function finds the block dev that this path belongs to, using uevent in sysfs.
diff --git a/include/tst_device.h b/include/tst_device.h
index 977427f1c..f0aff4473 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -110,8 +110,9 @@ void tst_purge_dir(const char *path);
  * Find the file or path belongs to which block dev
  * @path  Path to find the backing dev
  * @dev   The block dev
+ * @dev_len   The length of the dev string
  */
-void tst_find_backing_dev(const char *path, char *dev);
+void tst_find_backing_dev(const char *path, char *dev, size_t dev_len);
 
 /*
  * Stat the device mounted on a given path.
diff --git a/lib/newlib_tests/tst_device.c b/lib/newlib_tests/tst_device.c
index 87cec3961..53099f9bc 100644
--- a/lib/newlib_tests/tst_device.c
+++ b/lib/newlib_tests/tst_device.c
@@ -71,7 +71,7 @@ static void test_tst_find_backing_dev(void)
 {
 	char block_dev[100];
 
-	tst_find_backing_dev(mntpoint, block_dev);
+	tst_find_backing_dev(mntpoint, block_dev, sizeof(block_dev));
 
 	if (!strcmp(tst_device->dev, block_dev))
 		tst_res(TPASS, "%s belongs to %s block dev", mntpoint,
diff --git a/lib/tst_device.c b/lib/tst_device.c
index ae665f7b6..dbeae4c03 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -60,6 +60,11 @@ static const char *dev_loop_variants[] = {
 	"/dev/block/loop%i"
 };
 
+static const char *dev_variants[] = {
+	"/dev/%s",
+	"/dev/block/%s"
+};
+
 static int set_dev_loop_path(int dev, char *path, size_t path_len)
 {
 	unsigned int i;
@@ -75,6 +80,21 @@ static int set_dev_loop_path(int dev, char *path, size_t path_len)
 	return 1;
 }
 
+static int set_dev_path(char *dev, char *path, size_t path_len)
+{
+	unsigned int i;
+	struct stat st;
+
+	for (i = 0; i < ARRAY_SIZE(dev_variants); i++) {
+		snprintf(path, path_len, dev_variants[i], dev);
+
+		if (stat(path, &st) == 0 && S_ISBLK(st.st_mode))
+			return 0;
+	}
+
+	return 1;
+}
+
 int tst_find_free_loopdev(char *path, size_t path_len)
 {
 	int ctl_fd, dev_fd, rc, i;
@@ -511,7 +531,7 @@ unsigned long tst_dev_bytes_written(const char *dev)
 }
 
 __attribute__((nonnull))
-void tst_find_backing_dev(const char *path, char *dev)
+void tst_find_backing_dev(const char *path, char *dev, size_t dev_len)
 {
 	struct stat buf;
 	struct btrfs_ioctl_fs_info_args args = {0};
@@ -574,7 +594,7 @@ void tst_find_backing_dev(const char *path, char *dev)
 			sprintf(uevent_path, "%s/%s/uevent",
 				bdev_path, d->d_name);
 		} else {
-			tst_brkm(TBROK | TERRNO, NULL, "No backining device found while looking in %s.", bdev_path);
+			tst_brkm(TBROK | TERRNO, NULL, "No backing device found while looking in %s.", bdev_path);
 		}
 
 		if (SAFE_READDIR(NULL, dir))
@@ -590,17 +610,12 @@ void tst_find_backing_dev(const char *path, char *dev)
 	if (!access(uevent_path, R_OK)) {
 		FILE_LINES_SCANF(NULL, uevent_path, "DEVNAME=%s", dev_name);
 
-		if (dev_name[0])
-			sprintf(dev, "/dev/%s", dev_name);
+		if (!dev_name[0] || set_dev_path(dev_name, dev, dev_len) != 0)
+			tst_brkm(TBROK, NULL, "Could not stat backing device %s", dev);
+
 	} else {
 		tst_brkm(TBROK, NULL, "uevent file (%s) access failed", uevent_path);
 	}
-
-	if (stat(dev, &buf) < 0)
-		tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
-
-	if (S_ISBLK(buf.st_mode) != 1)
-		tst_brkm(TCONF, NULL, "dev(%s) isn't a block dev", dev);
 }
 
 void tst_stat_mount_dev(const char *const mnt_path, struct stat *const st)
@@ -643,7 +658,7 @@ int tst_dev_block_size(const char *path)
 	int size;
 	char dev_name[PATH_MAX];
 
-	tst_find_backing_dev(path, dev_name);
+	tst_find_backing_dev(path, dev_name, sizeof(dev_name));
 
 	fd = SAFE_OPEN(NULL, dev_name, O_RDONLY);
 	SAFE_IOCTL(NULL, fd, BLKSSZGET, &size);
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
index b4427f331..3a5d5afef 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
@@ -125,7 +125,7 @@ static void setup(void)
 	 *   needn't transform transfer.
 	 */
 	sprintf(backing_file_path, "%s/test.img", tst_get_tmpdir());
-	tst_find_backing_dev(backing_file_path, bd_path);
+	tst_find_backing_dev(backing_file_path, bd_path, sizeof(bd_path));
 	block_devfd = SAFE_OPEN(bd_path, O_RDWR);
 	SAFE_IOCTL(block_devfd, BLKSSZGET, &logical_block_size);
 	tst_res(TINFO, "backing dev(%s) logical_block_size is %d", bd_path, logical_block_size);
-- 
2.40.0.rc1.284.g88254d51c5-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
