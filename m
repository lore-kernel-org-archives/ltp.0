Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A31FC6FD1C
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 00:25:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E98D3CE30D
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 01:25:33 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2A833CE2F5
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 01:24:53 +0100 (CET)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com
 [IPv6:2607:f8b0:4864:20::449])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F12AF200389
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 01:24:52 +0100 (CET)
Received: by mail-pf1-x449.google.com with SMTP id
 x68-20020a628647000000b0062624c52117so191234pfd.14
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 17:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1679617491;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=dozakL9iauduyGN1pW1ynBMWErkfMph17QNZZsx5zek=;
 b=qqfCKttLy15gLeWMTift41owzAmvFRmoBX8x0SjrSnUEIYLtpi8yNPGoaDoWiRwd9h
 2J3a/UuBqQJjgpMzglHjTCEhRc+8+PolbccFsqP/DTzA/bIa9vJtLiSHLJ/k8YK9oCGJ
 t2xDWHAuePWDWiFO0XNe/nGySmmxzYOh9iLHL2Go3kp5GLjZzei/qze+qZ4nWY/QtVAX
 s5XT4kdmHCjmwxJqr54/l1IZfQVPeg2hUXMXClBcnMJDmKKmcUDe9hwF/FwT7ISib2iP
 ctk2HIXMRb7W+Nk1pMuZeLeUrSd7HhwhovQJf3Sv5XbtyMz4L/2xBL9E9j00lLQeMXWR
 g8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679617491;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dozakL9iauduyGN1pW1ynBMWErkfMph17QNZZsx5zek=;
 b=Srr7ojiGtslifGpq0T51sSkFKKMWAT1x40tpVVzm0l2Eeu1Q2PxpCFmVYe6f4E4gb+
 GbMCxMHuUNMHfMPf9/X2pYNqTPAQqFTJHCpc9mzaBHD0BMu9PquPwESBqjEwVHVdDm84
 NCl0wIGsZ+whJdZqHpdB173VR7au0woBYfIL373kHYeig3bQU7tuEItAd0SO2BDQb/2a
 NM09ZJ9a7y9xbI7mQypvShM9Akurj00kgEPSELg2lnScaSUtWrLV4wyOWxkbldWzQAPn
 Qynf1khstTYEXRPD2drEgdK73GXFdBFphzAWxIV3/hpjoTZU1y5Aaw+pUrt1QzGwSeXr
 Xk5g==
X-Gm-Message-State: AAQBX9cWXEmgzSYT2Fc5r9eeqyjUU03sR6cv6SLciwr9EcCI5NzMvuED
 Tvj6gUPBw7zDscQA8EZzGLwQ65Vb8vExEk1kA7B3Yl1afcqTtEdMp1LxTHB19QgvN5TPGFm0YQu
 XU1o7dTfYAJ8wjdnB1wAb68ejPMj7uXpywib5jMzZ1n8PTK/WftKvsLCk
X-Google-Smtp-Source: AKy350bNk+G3paa7qGNOanEG66dHOeDQUnk4I9UHPKyoGahITSgl3YyVya46kjg04Uvp6xxS1+j1+SRLpIM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:684:b0:1a1:ba37:d079 with SMTP id
 ki4-20020a170903068400b001a1ba37d079mr2868367plb.3.1679617491273; Thu, 23 Mar
 2023 17:24:51 -0700 (PDT)
Date: Fri, 24 Mar 2023 00:24:41 +0000
In-Reply-To: <20230324002441.987778-1-edliaw@google.com>
Mime-Version: 1.0
References: <20230324002441.987778-1-edliaw@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230324002441.987778-5-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/4] tst_find_backing_dev: Also check /dev/block/
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

Fixes: e1b1ae66b240 ("tst_find_backing_dev: Get dev name from /sys/dev/block/*/uevent")

On Android, the backing devices are created in /dev/block/ and will not
be found using the method added in e1b1ae66b240.  Adds a check for
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
index ba46b7613..74de307e7 100644
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
2.40.0.348.gf938b09366-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
