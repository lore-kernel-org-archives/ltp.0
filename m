Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374FAC4332F
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 20:40:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E0CA3CAD48
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 21:40:06 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C21C73CA8A4
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 21:39:55 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1622A600852
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 21:39:55 +0100 (CET)
Received: by mail-wr1-x42a.google.com with SMTP id bk15so26166070wrb.13
 for <ltp@lists.linux.it>; Wed, 02 Nov 2022 13:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4YRod5FSpRjg0rnhtR3i6UoyYJ+1U3mTnkv80tUU5c=;
 b=gFwU8ekRL9f5tJWzYB/bobjYQ4Q7c24iXS1mhFYzlqyBw/wu7O7NdCXM0UGZp/EJFR
 OprhihsEYrHEz3MRMtMAQIn4IE0T7k6v32fLrdEaOX4SxH4A0/ntXVjV/y3yfvX84bsK
 DB8oO9g78RMsRh+giuG5j+qLesJfqt4bu6tmoNoPWkZ9741TuekpWTnbcl/r2g7Q1ovu
 XAXQt487+Lc+KIKc7l0Zy9KQeFXHtVVLWwCSQpYB4mtB0rlhSrEB3nEyDwW49jS5w3u4
 8Lcz9nlNoXVOrEb6amI7myhZUXmZEqRNKs2JsIgsAm4Sdf/l9d7M4DO6TgaJkRwI4dy6
 S9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4YRod5FSpRjg0rnhtR3i6UoyYJ+1U3mTnkv80tUU5c=;
 b=Q4Ju/2Opr4N9rpwClMIj5yA4cohfIbWWrLKYwIpF4lqQ9a1HVfT6rdcdTfTJSfex0v
 yWwg8LiKditvZbos89xom23+QfpTT9iv2nCQ9UTUKgi1zJTyH8/XucsPKJE0EsU1Zk+A
 04LPfMPj7ooSAc+E8nVKzTqc7aQqsdqhinmq2lYpMc3Yq7gLKi0MKxUS0cVDzH24SIM4
 Np0Aw2lNbTQxlqVtD/L2OQ7NfQrpBPfBlb0pQC37ZlsK3d8DjUxy++shPiXoKFolc3SO
 rVDxJkU9fO59rtYXXv/X1/iUwFQuWyALv7vzSTzxwnYPe5hw/OQNWbPGulFwNrKb9Sxh
 ErZw==
X-Gm-Message-State: ACrzQf1X4eGnyR+5qObiM4MtCYIWoLelDu5DwhEcGrwIIMljc/NBsNfK
 9jVPAEt99n7IaDhWs+tKau51NSIiMO2y0g==
X-Google-Smtp-Source: AMsMyM7SAHC3wZbphDW+TTDyRoEk9hTU4l3lUlpvIAircTY6Rty/zuNhqUvpeoV3o4mUMvQzsk5FcA==
X-Received: by 2002:a5d:5551:0:b0:236:c715:59bf with SMTP id
 g17-20020a5d5551000000b00236c71559bfmr12407194wrw.124.1667421594237; 
 Wed, 02 Nov 2022 13:39:54 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
 by smtp.googlemail.com with ESMTPSA id
 j19-20020a05600c1c1300b003a8434530bbsm3460435wms.13.2022.11.02.13.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Nov 2022 13:39:53 -0700 (PDT)
From: Alessandro Carminati <alessandro.carminati@gmail.com>
To: ltp@lists.linux.it
Date: Wed,  2 Nov 2022 20:34:12 +0000
Message-Id: <20221102203413.547089-2-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102203413.547089-1-alessandro.carminati@gmail.com>
References: <87pme79f3d.fsf@suse.de>
 <20221102203413.547089-1-alessandro.carminati@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tst_find_backing_dev: Get dev name from
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
 lib/tst_device.c | 86 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 29 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 8419b80c3..4c2bde846 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -33,6 +33,8 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/sysmacros.h>
+#include <btrfs/ioctl.h>
+#include <dirent.h>
 #include "lapi/syscalls.h"
 #include "test.h"
 #include "safe_macros.h"
@@ -45,6 +47,7 @@
 
 #define DEV_FILE "test_dev.img"
 #define DEV_SIZE_MB 300u
+#define UUID_STR_SZ 37
 
 static char dev_path[1024];
 static int device_acquired;
@@ -519,48 +522,73 @@ static int count_match_len(const char *first, const char *second)
 void tst_find_backing_dev(const char *path, char *dev)
 {
 	struct stat buf;
+	struct btrfs_ioctl_fs_info_args args = {0};
+	struct dirent *d;
 	FILE *file;
-	char line[PATH_MAX];
-	char *pre = NULL;
-	char *next = NULL;
-	unsigned int dev_major, dev_minor, line_mjr, line_mnr;
-	unsigned int len, best_match_len = 1;
-	char mnt_point[PATH_MAX];
+	char uevent_path[PATH_MAX];
+	char dev_name[NAME_MAX];
+	char bdev_path[PATH_MAX];
+	char btrfs_uuid_str[UUID_STR_SZ];
+	DIR *dir;
+	unsigned int dev_major, dev_minor;
+	int fd;
 
 	if (stat(path, &buf) < 0)
 		tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
 
+	*dev = '\0';
 	dev_major = major(buf.st_dev);
 	dev_minor = minor(buf.st_dev);
-	file = SAFE_FOPEN(NULL, "/proc/self/mountinfo", "r");
-	*dev = '\0';
-
-	while (fgets(line, sizeof(line), file)) {
-		if (sscanf(line, "%*d %*d %d:%d %*s %s",
-			&line_mjr, &line_mnr, mnt_point) != 3)
-			continue;
-
-		pre = strstr(line, " - ");
-		pre = strtok_r(pre, " ", &next);
-		pre = strtok_r(NULL, " ", &next);
-		pre = strtok_r(NULL, " ", &next);
 
-		if (line_mjr == dev_major && line_mnr == dev_minor) {
-			strcpy(dev, pre);
-			break;
+	if (dev_major == 0) {
+		tst_resm(TINFO, "Use BTRFS specific strategy");
+		dir = opendir("/");
+		fd = dirfd(dir);
+		if (!ioctl(fd, BTRFS_IOC_FS_INFO, &args)) {
+			sprintf(btrfs_uuid_str,
+				"%02x%02x%02x%02x-%02x%02x-"
+				"%02x%02x-%02x%02x-"
+				"%02x%02x%02x%02x%02x%02x",
+				args.fsid[0],args.fsid[1],
+				args.fsid[2],args.fsid[3],
+				args.fsid[4],args.fsid[5],
+				args.fsid[6],args.fsid[7],
+				args.fsid[8],args.fsid[9],
+				args.fsid[10],args.fsid[11],
+				args.fsid[12],args.fsid[13],
+				args.fsid[14],args.fsid[15]);
+			sprintf(bdev_path,
+				"/sys/fs/btrfs/%s/devices", btrfs_uuid_str);
 		}
-
-		len = count_match_len(path, mnt_point);
-		if (len > best_match_len) {
-			strcpy(dev, pre);
-			best_match_len = len;
+		closedir(dir);
+		dir = opendir(bdev_path);
+		if (!dir){
+			tst_brkm(TWARN | TERRNO, NULL,
+				"can't opendir %d", dir);
+		}
+		while (d = readdir(dir)){
+			if (d->d_name[0]!='.')
+				break;
+		}
+		uevent_path[0]='\0';
+		closedir(dir);
+		if (d!=NULL) {
+			sprintf(uevent_path, "%s/%s/uevent",
+				bdev_path, d->d_name);
 		}
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
+	}
 
 	if (stat(dev, &buf) < 0)
 		tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
