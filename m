Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2700C43217
	for <ltp@archiver.kernel.org>; Wed,  9 Nov 2022 19:43:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D90B3CD758
	for <ltp@archiver.kernel.org>; Wed,  9 Nov 2022 20:43:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6DDE3CD771
 for <ltp@lists.linux.it>; Wed,  9 Nov 2022 20:43:37 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0E8D01A008A2
 for <ltp@lists.linux.it>; Wed,  9 Nov 2022 20:43:37 +0100 (CET)
Received: by mail-ej1-x635.google.com with SMTP id t25so49687132ejb.8
 for <ltp@lists.linux.it>; Wed, 09 Nov 2022 11:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DVm2ynpDzvHjFkuG8irez/ShDuNznVp6p8FWMb048X8=;
 b=GqKC/ONy8WT0761kDD0FcslrxRD+rNQJqo6B0zVg+upbcKI33Vi6IriYCMiIJXnOPq
 lBMrHALW8SWjj66va+3zoLzHKC0oPOXR2Jr0zOxQBjMt8wKs2PWLvFO2xZY75hnJ6Tiz
 N7TBJ7xZJEJleVswY2DUAgOUJInE7lywh7B/+TxTbQgFD7Vk+VFpMPozQBDr18pD5K4X
 /X/5Fj1th2hsF7w1AGz93dlAhbGaGwVrQZw8hcsReZdERySdgQYl0C8o9eqVOjYhQtXX
 CYk8naUdU77EKf/Oz6P0KElI8hSAgHvLFcYBEdt7W1Zbc/eOesYi2mwFi0+f4s8VcgC8
 XxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DVm2ynpDzvHjFkuG8irez/ShDuNznVp6p8FWMb048X8=;
 b=0tjHcpfFSMkzNsZWRmxkl1SVH8N8J+ndl+DLcNByq/bi+iTEd7rWBiu48qrTCFY3Js
 DFkd8UaJVDqLUgoNzHE2EXPbNQyVM4mq/98SAK53oNTAq8ywO3r9VdfCJOx6jvOyxReM
 Ujvde3iF9RUzXc+lYnfKx41nFokgDCKS1xEpjpmUYHvq6o6d22zD4JAiZP/exUS8IM24
 rupquZqc5tAfFTRobWPtRI0YKJF8L1urXVkd6YpZiSoemWksVMTD65r/zBV15US1P1G2
 E34odxV/554bx2xkcAXIlvH/4NkAkIA7jssq1WUvQDyRk/4FOs9vlDoiLxokOOl5mbmV
 ySCA==
X-Gm-Message-State: ACrzQf1rd/CP/hZnt5yOH0fUrhbE5PCmM1TZKFwXsbh8BCGyQYNeM2jm
 MrO281hybtWe4e82DdyZM2Pm3qDqRsW/AQ==
X-Google-Smtp-Source: AMsMyM4kslcoQOpFQIoJwc9TYnmDqbUYvFMoAcUFOhq3sP22jTr6P8CqNh5G+ZDhafTXbdYkm7G1jg==
X-Received: by 2002:a17:906:a246:b0:78d:ee08:1867 with SMTP id
 bi6-20020a170906a24600b0078dee081867mr1739568ejb.123.1668023016142; 
 Wed, 09 Nov 2022 11:43:36 -0800 (PST)
Received: from lab.hqhome163.com ([194.183.10.152])
 by smtp.googlemail.com with ESMTPSA id
 z23-20020a170906075700b00780b1979adesm6170126ejb.218.2022.11.09.11.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Nov 2022 11:43:35 -0800 (PST)
From: Alessandro Carminati <alessandro.carminati@gmail.com>
To: ltp@lists.linux.it
Date: Wed,  9 Nov 2022 19:38:18 +0000
Message-Id: <20221109193819.875478-2-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109193819.875478-1-alessandro.carminati@gmail.com>
References: <877d05wxwe.fsf@suse.de>
 <20221109193819.875478-1-alessandro.carminati@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/2] tst_find_backing_dev: Get dev name from
 /sys/dev/block/*/uevent
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
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>, rpalethorpe@suse.com,
 acarmina@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

In some minimal Linux, the /dev/root can be missing. The consequence of
this is that mountinfo doesn't contain the correct information. btrfs
file systems are yet another point of trouble for this function.

The unevent file in sysfs is another method to retrieve device info
using the sysfs.

btrfs file systems are special from the device name retrieval, and in
place of use of the minor/major they are approached by using the uuid.
In the end, btrfs strategy is a slightly modified version of the same
unevent strategy.

Non btrfs look in "/sys/dev/block/%d:%d/uevent" major, minor
btrfs look in /sys/fs/btrfs/%s/devices/%s/uevent, uuid, devname

The btrfs handling requires BTRFS specific ioctl for finding the
file system uuid, and for this reason, btrfs/ioctl.h is needed.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
---
 lib/tst_device.c | 95 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 66 insertions(+), 29 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 8419b80c3..85acdc4f2 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -33,6 +33,8 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/sysmacros.h>
+#include <linux/btrfs.h>
+#include <linux/limits.h>
 #include "lapi/syscalls.h"
 #include "test.h"
 #include "safe_macros.h"
@@ -45,6 +47,8 @@
 
 #define DEV_FILE "test_dev.img"
 #define DEV_SIZE_MB 300u
+#define UUID_STR_SZ 37
+#define UUID_FMT "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x"
 
 static char dev_path[1024];
 static int device_acquired;
@@ -519,48 +523,81 @@ static int count_match_len(const char *first, const char *second)
 void tst_find_backing_dev(const char *path, char *dev)
 {
 	struct stat buf;
-	FILE *file;
-	char line[PATH_MAX];
-	char *pre = NULL;
-	char *next = NULL;
-	unsigned int dev_major, dev_minor, line_mjr, line_mnr;
-	unsigned int len, best_match_len = 1;
-	char mnt_point[PATH_MAX];
+	struct btrfs_ioctl_fs_info_args args = {0};
+	struct dirent *d;
+	char uevent_path[PATH_MAX+PATH_MAX+10]; //10 is for the static uevent path
+	char dev_name[NAME_MAX];
+	char bdev_path[PATH_MAX];
+	char tmp_path[PATH_MAX];
+	char btrfs_uuid_str[UUID_STR_SZ];
+	DIR *dir;
+	unsigned int dev_major, dev_minor;
+	int fd;
 
 	if (stat(path, &buf) < 0)
 		tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
+	strncpy(tmp_path, path, PATH_MAX-1);
+	tmp_path[PATH_MAX-1] = '\0';
+	if (S_ISREG(buf.st_mode))
+		dirname(tmp_path);
 
 	dev_major = major(buf.st_dev);
 	dev_minor = minor(buf.st_dev);
-	file = SAFE_FOPEN(NULL, "/proc/self/mountinfo", "r");
 	*dev = '\0';
 
-	while (fgets(line, sizeof(line), file)) {
-		if (sscanf(line, "%*d %*d %d:%d %*s %s",
-			&line_mjr, &line_mnr, mnt_point) != 3)
-			continue;
-
-		pre = strstr(line, " - ");
-		pre = strtok_r(pre, " ", &next);
-		pre = strtok_r(NULL, " ", &next);
-		pre = strtok_r(NULL, " ", &next);
-
-		if (line_mjr == dev_major && line_mnr == dev_minor) {
-			strcpy(dev, pre);
-			break;
+	if (dev_major == 0) {
+		tst_resm(TINFO, "Use BTRFS specific strategy");
+
+		fd = SAFE_OPEN(NULL, tmp_path, O_DIRECTORY);
+		if (!ioctl(fd, BTRFS_IOC_FS_INFO, &args)) {
+			sprintf(btrfs_uuid_str,
+				UUID_FMT,
+				args.fsid[0], args.fsid[1],
+				args.fsid[2], args.fsid[3],
+				args.fsid[4], args.fsid[5],
+				args.fsid[6], args.fsid[7],
+				args.fsid[8], args.fsid[9],
+				args.fsid[10], args.fsid[11],
+				args.fsid[12], args.fsid[13],
+				args.fsid[14], args.fsid[15]);
+			sprintf(bdev_path,
+				"/sys/fs/btrfs/%s/devices", btrfs_uuid_str);
+		} else {
+			if (errno == ENOTTY)
+				tst_brkm(TBROK | TERRNO, NULL, "BTRFS ioctl failed. Is %s on a tmpfs?", path);
+			tst_brkm(TBROK | TERRNO, NULL, "BTRFS ioctl failed with %d.", errno);
 		}
-
-		len = count_match_len(path, mnt_point);
-		if (len > best_match_len) {
-			strcpy(dev, pre);
-			best_match_len = len;
+		SAFE_CLOSE(NULL, fd);
+		dir = SAFE_OPENDIR(NULL, bdev_path);
+		while ((d = SAFE_READDIR(NULL, dir))) {
+			if (d->d_name[0] != '.')
+				break;
 		}
+		uevent_path[0] = '\0';
+		if (d) {
+			sprintf(uevent_path, "%s/%s/uevent",
+				bdev_path, d->d_name);
+		} else {
+			tst_brkm(TBROK | TERRNO, NULL, "No backining device found while looking in %s.", bdev_path);
+		}
+		if (SAFE_READDIR(NULL, dir))
+			tst_resm(TINFO, "Warning: used first of multiple backing device.");
+		SAFE_CLOSEDIR(NULL, dir);
+	} else {
+
+		tst_resm(TINFO, "Use uevent strategy");
+		sprintf(uevent_path,
+			"/sys/dev/block/%d:%d/uevent", dev_major, dev_minor);
 	}
 
-	SAFE_FCLOSE(NULL, file);
+	if (!access(uevent_path, R_OK)) {
+		FILE_LINES_SCANF(NULL, uevent_path, "DEVNAME=%s", dev_name);
 
-	if (!*dev)
-		tst_brkm(TBROK, NULL, "Cannot find block device for %s", path);
+		if (dev_name[0])
+			sprintf(dev, "/dev/%s", dev_name);
+	} else {
+		tst_brkm(TBROK, NULL, "uevent file (%s) access failed", uevent_path);
+	}
 
 	if (stat(dev, &buf) < 0)
 		tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
