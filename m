Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E65C433FE
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 12:10:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 671073CB32A
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 13:10:42 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A2983CB48E
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 13:06:14 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A2A4E1A00376
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 05:47:35 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 c3-20020a1c3503000000b003bd21e3dd7aso4691243wma.1
 for <ltp@lists.linux.it>; Thu, 03 Nov 2022 21:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teb564OfZHMl3AOcx6SV/HIXrc3xKFmVQ25cOM5tEew=;
 b=FH6VC84psmDeZGMrXKbJx7/TuJy5DCDXy/FnIucRelZ/WpQHrUoSiWxWkYVMp+Lf/Y
 tY/2vSfK5c5dx6rC4nCEj3H/DTQRoZTorunh9ll3ZYis+/Tjutd+S1/S7tNju72utFDQ
 2Qq0sGFKzUECfLml0JFFdAmGi34A3iaO0cd6BirXer8VYrWG/IxPR0ZNGBqz9lG4WTmC
 JFoemHnzehoqGDJludWQB+GD7jcquR2saqUKp0GzAsE0yQecsYaRcx7R9es1XMxgoRMN
 hA/WNyqOUVvWWrNBqco1n5ObxKvOUiDoqCWEwY8X747ffaqel1pjXXXrhro3xzt9Osq5
 xgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teb564OfZHMl3AOcx6SV/HIXrc3xKFmVQ25cOM5tEew=;
 b=zujkeRA2LAhhEpsO1yzghNbZqdk1TDsP53mKwmqDPc2pXSeeJKbluTPR7CZH32/qKU
 A9snPcPXCTTzKtfK60/xcqPm41XpIVqKeKrOjGsvDn3cFw9fjjPw/ZA/L545KKLkhAAE
 P9/106meFbv3y7fLJU0WDBgiOAjHEQn1xutnug48ohzyg+RUtq7qnnyj47j5oy9Aunnv
 lg3Tu6c63YvrLCueFtZtYZDdmF6nMx54QmbBdJNRV1PIohu/K5HOgFVvkOAWVBPeBSJ8
 o6NIOtUkhubPs62LtnrtlLNUGD4wvpsZF3b2Qv0R7Gd+TB0dV3PHi2Vv0CfI2SlmOPNA
 1TIA==
X-Gm-Message-State: ACrzQf2u1EGcBfDtmxw9/mAXkMI1GllvHgeSBTRYFK1CvAcq+lsx68f6
 noaYFGnLYDUXyxcniGihLTFhO7eTXWraxQ==
X-Google-Smtp-Source: AMsMyM66b2Vq9+/bqpwBGaLLTcWR8+uLTh2M5hquY79xhlppAW3D7X5pif9rrmi51uG3/bc+Y/Whzw==
X-Received: by 2002:a1c:7312:0:b0:3cf:6957:1639 with SMTP id
 d18-20020a1c7312000000b003cf69571639mr20177935wmb.108.1667537254715; 
 Thu, 03 Nov 2022 21:47:34 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
 by smtp.googlemail.com with ESMTPSA id
 h19-20020a05600c351300b003b4ff30e566sm9583599wmq.3.2022.11.03.21.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Nov 2022 21:47:34 -0700 (PDT)
From: Alessandro Carminati <alessandro.carminati@gmail.com>
To: ltp@lists.linux.it
Date: Fri,  4 Nov 2022 04:41:48 +0000
Message-Id: <20221104044149.655317-2-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104044149.655317-1-alessandro.carminati@gmail.com>
References: <8735b0jos5.fsf@suse.de>
 <20221104044149.655317-1-alessandro.carminati@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tst_find_backing_dev: Get dev name from
 /sys/*/uevent
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
 lib/tst_device.c | 87 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 29 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 8419b80c3..e9933955f 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -33,6 +33,9 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/sysmacros.h>
+#include <linux/btrfs.h>
+#include <linux/limits.h>
+#include <dirent.h>
 #include "lapi/syscalls.h"
 #include "test.h"
 #include "safe_macros.h"
@@ -45,6 +48,8 @@
 
 #define DEV_FILE "test_dev.img"
 #define DEV_SIZE_MB 300u
+#define UUID_STR_SZ 37
+#define UUID_FMT "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x"
 
 static char dev_path[1024];
 static int device_acquired;
@@ -519,48 +524,72 @@ static int count_match_len(const char *first, const char *second)
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
+	char uevent_path[PATH_MAX];
+	char dev_name[NAME_MAX];
+	char bdev_path[PATH_MAX];
+	char btrfs_uuid_str[UUID_STR_SZ];
+	DIR *dir;
+	unsigned int dev_major, dev_minor;
+	int fd;
 
 	if (stat(path, &buf) < 0)
 		tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
 
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
+		fd = SAFE_OPEN(NULL, dirname(path), O_DIRECTORY);
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
 		}
-
-		len = count_match_len(path, mnt_point);
-		if (len > best_match_len) {
-			strcpy(dev, pre);
-			best_match_len = len;
+		SAFE_CLOSE(NULL, fd);
+		dir = SAFE_OPENDIR(NULL, bdev_path);
+		while (d = SAFE_READDIR(NULL, dir)) {
+			if (d->d_name[0]!='.')
+				break;
 		}
+		uevent_path[0] = '\0';
+		if (d) {
+			sprintf(uevent_path, "%s/%s/uevent",
+				bdev_path, d->d_name);
+		} else {
+			tst_brkm(TBROK, NULL, "No backining device found");
+			}
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
+		}
 
 	if (stat(dev, &buf) < 0)
 		tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
