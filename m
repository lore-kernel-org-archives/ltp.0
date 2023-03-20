Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D447C6FD1C
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 22:38:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9C253CA93B
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 23:38:15 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5090B3CA941
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 23:37:39 +0100 (CET)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com
 [IPv6:2607:f8b0:4864:20::449])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E41DC6001EA
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 23:37:37 +0100 (CET)
Received: by mail-pf1-x449.google.com with SMTP id
 b8-20020aa78708000000b005eaa50faa35so7000976pfo.20
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 15:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1679351856;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=efKpFrdGt03RhHy7C8l15+e39IZMCMLFT+ooej12Gso=;
 b=tSpV3VwvbYIt+p84WPafr9B9au2UX9VBMbRl4o1Ug/+Op7XU6qUTookL/Ep+Gkb1Pb
 h6pdfUbuiblyiJCuiKbtL7DQ0tpOedPix/TTNpIDi6zd9rT8PqQ8FJtlLJQpIhHfqpJN
 ho2yzcbAeUazl1U23dYirS3snN9MddubRfQYF6e7UuR+0NEq2BXGRJ2HZNoFgD+k/2WI
 XR59x4CImE3M22V1BqrSqBNJJOC44oueFvYb21QukdcsME6HUItt8wzu5JKfP/DwLC/f
 n35nq9F73ait0Gzi98Vp0PDL5SxQLbg2vF1KkwyzDH6zbcQrWK0UrjZwwJ+Jfusn9vfC
 FFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679351856;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=efKpFrdGt03RhHy7C8l15+e39IZMCMLFT+ooej12Gso=;
 b=7HBHIZc6noyu1Zlxi3H3NACud29kS10WT1LD3+tjKzikviPsMLjOOQwFp61JUFVb9t
 eXZhvMXpZbNYEW8RJmFqWdgcABezEJWZVOSzk2SRzkIEjfygR3D4Q0PlJPQ1cj0J4gTP
 JN34YdZrPekEkgLI6ktgRbGzsSWfn2AvnwWVdTC461zoEMC6e5Y5iadUmeVv052Qbogj
 2fn+6XBj4LJMl5FzgsCOb/K3PSeQb8DSZxjwqvur+vooz2B5eM9ioo6wOg5x4ukwicCl
 CDIQGe2J5Gsp1N28nKT9AVWbUXhrK5muZ1CiIoArCPbnsfrfNGDypKRvzbwZWWR5z0vK
 PaHg==
X-Gm-Message-State: AO0yUKV6RDmppcA9jJxRBALWRnDwO5e6IiqSTX2JmYjF0MEW3lA/jyNZ
 llODIF43Q83l3fK48EeeII1pOqoDkrxXgxKg6iCL8D8sa/SSirmXSdFiSJZMCmnaxGQa6vvMtvS
 Bz9cPqGCHkQqTZb4ZRxDrDZDVP9cVx4K5IwZ+NrvnSRC8UXW68G9hLYHx
X-Google-Smtp-Source: AK7set8czHkaju4lMAHK1MzzPdmgFE0NZpZs+CD6w1Fnow+eJpNXWgy4jEgdxHsS9OLRjMTsTuP+OGu8naM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:2594:b0:1a0:53af:58f6 with SMTP id
 jb20-20020a170903259400b001a053af58f6mr21074plb.1.1679351855972; Mon, 20 Mar
 2023 15:37:35 -0700 (PDT)
Date: Mon, 20 Mar 2023 22:37:23 +0000
In-Reply-To: <20230320223723.2030960-1-edliaw@google.com>
Mime-Version: 1.0
References: <20230320223723.2030960-1-edliaw@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230320223723.2030960-4-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 3/3] tst_find_backing_dev: Also check /dev/block/
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

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 lib/tst_device.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index ae665f7b6..14c0dd7a3 100644
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
+void tst_find_backing_dev(const char *path, char *dev, size_t dev_size)
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
+		if (!dev_name[0] || set_dev_path(dev_name, dev, dev_size) != 0)
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
-- 
2.40.0.rc1.284.g88254d51c5-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
