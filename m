Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9054C76195
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 16:12:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B048F3CCD74
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 18:12:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D8F83CCD74
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 18:11:58 +0200 (CEST)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ACECF1A00A28
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 18:11:57 +0200 (CEST)
Received: by mail-pl1-x649.google.com with SMTP id
 z16-20020a170902d55000b001a06f9b5e31so6170708plf.21
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 09:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1679933516;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Dq+u+hLzvFu1QO/mkJ3o+R8rp2fj58CwJfA8LZJICuM=;
 b=MdxsCktD0HiiAeXyCJQ9FymCm+Y6DdSCx8zFRybJk3HkuYh64jQ1xEWlEjwu202YeH
 zwbdCJvyZOLDlMJ0XeRILzfx/vG6idwK8KpygBY9dxdXK4mfFQqbKYLFuyHq1mPe/hH9
 l7Qg8g0Y9Y/NuVlsJUPWDpPLONwot27UHIKTcq06F8nFnKXhdNyXr9bwGa4vIEuMORIR
 79HcHCxwG+JDWFAz+nwP7LyQjUqvEv6CtKgy0FGxHOyAVZSj6skJ0PtJqG692P7jQmS/
 cM8Pe4Mi361Jn8hKm20LZgXf7kEk8HIlWXd6S5AZdWhem+OBQV0ydbdPKPF7peQDWMew
 EQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679933516;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dq+u+hLzvFu1QO/mkJ3o+R8rp2fj58CwJfA8LZJICuM=;
 b=m+jAtGBk6JJo5hztC3eNycczEnON6xhN09mxHhYShPQ+ab4NcphAFpgbb4TLJEgJLo
 y5kpbh9sOwtMx/popqLuvd0nMaX7T3Ftw6rHw61PdgvwKxDZLxbimO9TKL0Vy2yH2SKX
 dBl6B7zQC2wNBabPWWneecJjwf8B5o6xDHxnUfhR4zDJ+0E95yuVGQH7bbABVSlg86+0
 mluP9l9UbpfOD5rMXIuhhCuX+55RHfk62ehsei+k22vktPMfhuG3R3LWpKql8wiOFVAv
 YCR5q7ZwPxIZ4+yNdIETQE0BIBZIwkpIf1jJxcyrb1YBqpVFsmlV1UzRTU+0lVXBLFL1
 bhFg==
X-Gm-Message-State: AAQBX9drhI8979R9Ql/M0dHTdHreTCFkoVuKNCSyiJujpdqFR9cHXSp1
 +WLwL6QvBYRjcYR0GO+5oLPHWYMLLpz6gqCB3EOf1+/CDPazzjSj8WF8BOhyXXLU71N/OJ1tSAb
 R5KE4a6HmRY4OFHADM5xEaKownPro1vNWxncqMv6j+Zuz7Cts/n7YnNK9
X-Google-Smtp-Source: AKy350Z6f2hCMlD3MNTL24/KShixYKPrdnr0mMs3RPXNUOPdJ5c2q6q94YtI6yqKyJrwy1WR+aQdETIK9WQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:1881:b0:625:d7e6:51a0 with SMTP id
 x1-20020a056a00188100b00625d7e651a0mr6784863pfh.1.1679933515951; Mon, 27 Mar
 2023 09:11:55 -0700 (PDT)
Date: Mon, 27 Mar 2023 16:11:45 +0000
In-Reply-To: <20230327161145.1702680-1-edliaw@google.com>
Mime-Version: 1.0
References: <20230327161145.1702680-1-edliaw@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230327161145.1702680-5-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/4] tst_find_backing_dev: Also check /dev/block/
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/c-test-api.txt                            |  2 +-
 include/tst_device.h                          |  7 ++--
 lib/newlib_tests/tst_device.c                 |  2 +-
 lib/tst_device.c                              | 37 +++++++++++++------
 .../kernel/syscalls/ioctl/ioctl_loop05.c      |  2 +-
 5 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index a7dd59dac..11f87def2 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -1087,7 +1087,7 @@ is created for that intention.
 -------------------------------------------------------------------------------
 #include "tst_test.h"
 
-void tst_find_backing_dev(const char *path, char *dev);
+void tst_find_backing_dev(const char *path, char *dev, size_t dev_size);
 -------------------------------------------------------------------------------
 
 This function finds the block dev that this path belongs to, using uevent in sysfs.
diff --git a/include/tst_device.h b/include/tst_device.h
index 977427f1c..39545fab0 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -108,10 +108,11 @@ void tst_purge_dir(const char *path);
 
 /*
  * Find the file or path belongs to which block dev
- * @path  Path to find the backing dev
- * @dev   The block dev
+ * @path       Path to find the backing dev
+ * @dev        The buffer to store the block dev in
+ * @dev_size   The length of the block dev buffer
  */
-void tst_find_backing_dev(const char *path, char *dev);
+void tst_find_backing_dev(const char *path, char *dev, size_t dev_size);
 
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
index 2b4b6fb95..892e0b2e6 100644
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
@@ -512,7 +532,7 @@ unsigned long tst_dev_bytes_written(const char *dev)
 }
 
 __attribute__((nonnull))
-void tst_find_backing_dev(const char *path, char *dev)
+void tst_find_backing_dev(const char *path, char *dev, size_t dev_size)
 {
 	struct stat buf;
 	struct btrfs_ioctl_fs_info_args args = {0};
@@ -575,7 +595,7 @@ void tst_find_backing_dev(const char *path, char *dev)
 			sprintf(uevent_path, "%s/%s/uevent",
 				bdev_path, d->d_name);
 		} else {
-			tst_brkm(TBROK | TERRNO, NULL, "No backining device found while looking in %s.", bdev_path);
+			tst_brkm(TBROK | TERRNO, NULL, "No backing device found while looking in %s.", bdev_path);
 		}
 
 		if (SAFE_READDIR(NULL, dir))
@@ -591,17 +611,12 @@ void tst_find_backing_dev(const char *path, char *dev)
 	if (!access(uevent_path, R_OK)) {
 		FILE_LINES_SCANF(NULL, uevent_path, "DEVNAME=%s", dev_name);
 
-		if (dev_name[0])
-			sprintf(dev, "/dev/%s", dev_name);
+		if (!dev_name[0] || set_dev_path(dev_name, dev, dev_size))
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
@@ -644,7 +659,7 @@ int tst_dev_block_size(const char *path)
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
