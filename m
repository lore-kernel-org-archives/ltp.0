Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760F6C0219B
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 21:47:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6F063C9991
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 22:47:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 754E13C995D
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 22:46:37 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BE25D1BBEF36
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 22:46:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739310395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vY363RwpArNZ36u9JC4/CnnlrnoVywk25B8J9DBwXEA=;
 b=e3OJbSphlx6doGvQuHmHFslLWn038jrTFPFEBCVHKt83BgRS8QTwsTU7Q3WTpDoFDF8l46
 sEBElNfPwIzIdZlkoZY6L/fN89E/P/yFHl3q6eUf3RTNJ7q1lW5EQ3mbxNEFxLoQpsImOo
 nJ1MC0oJXKeMnTzCPpZaDjx7PG3d5gQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-8qdOaLzYNbGoCqFuDnPgaw-1; Tue,
 11 Feb 2025 16:46:33 -0500
X-MC-Unique: 8qdOaLzYNbGoCqFuDnPgaw-1
X-Mimecast-MFC-AGG-ID: 8qdOaLzYNbGoCqFuDnPgaw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A944F1800876
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 21:46:32 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.80.78])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80F1818004A7
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 21:46:32 +0000 (UTC)
Received: by segfault.usersys.redhat.com (Postfix, from userid 3734)
 id 52B072327EA9; Tue, 11 Feb 2025 16:46:30 -0500 (EST)
From: Jeff Moyer <jmoyer@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 11 Feb 2025 16:42:13 -0500
Message-ID: <20250211214627.152634-2-jmoyer@redhat.com>
In-Reply-To: <20250211214627.152634-1-jmoyer@redhat.com>
References: <20250211214627.152634-1-jmoyer@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qr5xDb7k9wmD_vu6RlH9KwBMhIpd9ebluIogCZFR9cA_1739310393
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] lib/tst_device.c: factor out btrfs-specific
 logic from tst_find_backing_dev
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
