Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10439C02193
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 22:09:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A1483C8F80
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 23:09:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 196EE3C6508
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 23:09:13 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0707F65DBA4
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 23:09:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738620551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vY363RwpArNZ36u9JC4/CnnlrnoVywk25B8J9DBwXEA=;
 b=K4J+CcdrUgFOIlyAY6CZm2n26FaB0Gp1n1brXHaaXm56hV04+RnVqBJsr9e5EyvzX60sB7
 0mA9+fZOd2uc+I/YJ8SjLdcmqAHaOIbnVRtgbew5/J0wgvGKFpBPyO7pbluOYT+7xUYp8D
 oSYzQDI8Fm2nGNDakpa7pKboTsj+luM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-r9RJwsEVOfyRiRn11uZsEQ-1; Mon,
 03 Feb 2025 17:09:10 -0500
X-MC-Unique: r9RJwsEVOfyRiRn11uZsEQ-1
X-Mimecast-MFC-AGG-ID: r9RJwsEVOfyRiRn11uZsEQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4806519560B9
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 22:09:09 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.65.155])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 184B619560AD; Mon,  3 Feb 2025 22:09:08 +0000 (UTC)
Received: by segfault.usersys.redhat.com (Postfix, from userid 3734)
 id 74A1B24EA205; Mon,  3 Feb 2025 17:09:06 -0500 (EST)
From: Jeff Moyer <jmoyer@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  3 Feb 2025 17:05:58 -0500
Message-ID: <20250203220903.399544-2-jmoyer@redhat.com>
In-Reply-To: <20250203220903.399544-1-jmoyer@redhat.com>
References: <20250203220903.399544-1-jmoyer@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AfELkHKWcdkaRds2SZyEnYi2U62jhJf2t3vRVb5m5a4_1738620549
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] lib/tst_device.c: factor out btrfs-specific logic
 from tst_find_backing_dev
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
Cc: Jeff Moyer <jmoyer@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

In preparation for handling overlayfs (which also has a major device
number of 0), factor out the btrfs logic.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
---
 lib/tst_device.c | 104 +++++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 49 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 723f6ca06..70234a83c 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -520,20 +520,68 @@ unsigned long tst_dev_bytes_written(const char *dev)
 	return dev_bytes_written;
 }
 
+static void btrfs_get_uevent_path(char *tmp_path, char *uevent_path)
+{
+	int fd;
+	struct btrfs_ioctl_fs_info_args args = {0};
+	char btrfs_uuid_str[UUID_STR_SZ];
+	struct dirent *d;
+	char bdev_path[PATH_MAX];
+	DIR *dir;
+
+	tst_resm(TINFO, "Use BTRFS specific strategy");
+
+	fd = SAFE_OPEN(NULL, tmp_path, O_DIRECTORY);
+	if (!ioctl(fd, BTRFS_IOC_FS_INFO, &args)) {
+		sprintf(btrfs_uuid_str,
+			UUID_FMT,
+			args.fsid[0], args.fsid[1],
+			args.fsid[2], args.fsid[3],
+			args.fsid[4], args.fsid[5],
+			args.fsid[6], args.fsid[7],
+			args.fsid[8], args.fsid[9],
+			args.fsid[10], args.fsid[11],
+			args.fsid[12], args.fsid[13],
+			args.fsid[14], args.fsid[15]);
+		sprintf(bdev_path,
+			"/sys/fs/btrfs/%s/devices", btrfs_uuid_str);
+	} else {
+		if (errno == ENOTTY)
+			tst_brkm(TBROK | TERRNO, NULL, "BTRFS ioctl failed. Is %s on a tmpfs?", tmp_path);
+
+		tst_brkm(TBROK | TERRNO, NULL, "BTRFS ioctl on %s failed.", tmp_path);
+	}
+	SAFE_CLOSE(NULL, fd);
+
+	dir = SAFE_OPENDIR(NULL, bdev_path);
+	while ((d = SAFE_READDIR(NULL, dir))) {
+		if (d->d_name[0] != '.')
+			break;
+	}
+
+	uevent_path[0] = '\0';
+
+	if (d) {
+		sprintf(uevent_path, "%s/%s/uevent",
+			bdev_path, d->d_name);
+	} else {
+		tst_brkm(TBROK | TERRNO, NULL, "No backing device found while looking in %s.", bdev_path);
+	}
+
+	if (SAFE_READDIR(NULL, dir))
+		tst_resm(TINFO, "Warning: used first of multiple backing device.");
+
+	SAFE_CLOSEDIR(NULL, dir);
+}
+
 __attribute__((nonnull))
 void tst_find_backing_dev(const char *path, char *dev, size_t dev_size)
 {
 	struct stat buf;
-	struct btrfs_ioctl_fs_info_args args = {0};
-	struct dirent *d;
 	char uevent_path[PATH_MAX+PATH_MAX+10]; //10 is for the static uevent path
 	char dev_name[NAME_MAX];
-	char bdev_path[PATH_MAX];
 	char tmp_path[PATH_MAX];
-	char btrfs_uuid_str[UUID_STR_SZ];
-	DIR *dir;
 	unsigned int dev_major, dev_minor;
-	int fd;
 
 	if (stat(path, &buf) < 0)
 		tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
@@ -548,49 +596,7 @@ void tst_find_backing_dev(const char *path, char *dev, size_t dev_size)
 	*dev = '\0';
 
 	if (dev_major == 0) {
-		tst_resm(TINFO, "Use BTRFS specific strategy");
-
-		fd = SAFE_OPEN(NULL, tmp_path, O_DIRECTORY);
-		if (!ioctl(fd, BTRFS_IOC_FS_INFO, &args)) {
-			sprintf(btrfs_uuid_str,
-				UUID_FMT,
-				args.fsid[0], args.fsid[1],
-				args.fsid[2], args.fsid[3],
-				args.fsid[4], args.fsid[5],
-				args.fsid[6], args.fsid[7],
-				args.fsid[8], args.fsid[9],
-				args.fsid[10], args.fsid[11],
-				args.fsid[12], args.fsid[13],
-				args.fsid[14], args.fsid[15]);
-			sprintf(bdev_path,
-				"/sys/fs/btrfs/%s/devices", btrfs_uuid_str);
-		} else {
-			if (errno == ENOTTY)
-				tst_brkm(TBROK | TERRNO, NULL, "BTRFS ioctl failed. Is %s on a tmpfs?", path);
-
-			tst_brkm(TBROK | TERRNO, NULL, "BTRFS ioctl on %s failed.", tmp_path);
-		}
-		SAFE_CLOSE(NULL, fd);
-
-		dir = SAFE_OPENDIR(NULL, bdev_path);
-		while ((d = SAFE_READDIR(NULL, dir))) {
-			if (d->d_name[0] != '.')
-				break;
-		}
-
-		uevent_path[0] = '\0';
-
-		if (d) {
-			sprintf(uevent_path, "%s/%s/uevent",
-				bdev_path, d->d_name);
-		} else {
-			tst_brkm(TBROK | TERRNO, NULL, "No backing device found while looking in %s.", bdev_path);
-		}
-
-		if (SAFE_READDIR(NULL, dir))
-			tst_resm(TINFO, "Warning: used first of multiple backing device.");
-
-		SAFE_CLOSEDIR(NULL, dir);
+		btrfs_get_uevent_path(tmp_path, uevent_path);
 	} else {
 		tst_resm(TINFO, "Use uevent strategy");
 		sprintf(uevent_path,
-- 
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
