Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C061BC4332F
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 16:45:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DAF33CDA43
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 17:45:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C4E83CDA41
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 17:45:26 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 347EB2003BA
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 17:45:26 +0100 (CET)
Received: by mail-ej1-x635.google.com with SMTP id t25so31698084ejb.8
 for <ltp@lists.linux.it>; Mon, 07 Nov 2022 08:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hd6oJtA8NxTyiYhVzh5s/8z7em/n0W3Qhp/Gtt4wNv4=;
 b=mZ3tB7aO2jCAlybdq06saskATBBmqGeNK5KEYw9R9CfqrotvfbmB9MYTvNl+9Qgf1X
 jPEbdns+KTNqCAKej9IBtFI7RjuR35i8tTh2EX27u970xIb+37FjQ1Kk+GU8AG4TUPGu
 NQUU/z9WuOT0dmAqXmk31ZBmaZ5wspOQeH08ZwKBtXv0t9RZiX/Li5dyhlUYSVnUOb8Z
 tS4ceM4Vx2+P7sPVXAc64JEuUsId8RCXGYN/wdWW8QydMmjWYivd3K7zxRThZEbv/loI
 0sF0lT+cjkfsiePDgD7R3JZsKm+ej0g2rb/WU5lU++zQcjgWVf4kQ6jnujQ6YVYE5UhO
 SQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hd6oJtA8NxTyiYhVzh5s/8z7em/n0W3Qhp/Gtt4wNv4=;
 b=J+vLMkgAWeAr1scndwcA0XbP5YUg7WTrcQSr6VQdLQXt4YLnGCLIGQBbs4CfuuVbkg
 AwzSZWHuNYP2Gz+vnrn+kpYkr8idM1kS6imWXEfs/GqqAe64ls0vIh8hv9YwdQNl0dGn
 U5ND1tQPwUK3MFGmstpsyDNM5r5tDKa1iTwAahjMErnTEiD/8PemiRuyBZg18/dbdv4f
 D4BaBxzybboe0VTNx+jItef6Mg5XaC1syuc8B7XgrEBL6eDB8x6VuIsxkyv7HHq9VJIM
 xeU1uZ0kRgIldQytDVeG7ewqZjPgEZ0KGty6sOr3rPtcBY0ds2ZIZ+JprLWnpcEt+qr2
 kK6w==
X-Gm-Message-State: ACrzQf3jKpvNeC4P5BgIhvciKP+NORA0yg5P51lhvAlp/5JG+WN4Qdyj
 3ETlQaKAPoXhX9wyypG5mrPn0rROjsOFbQ==
X-Google-Smtp-Source: AMsMyM7z+f1tNWCgv3y6Q3oK7IdAWW0mfkYrDmIo+tiI6m3J31wGW5S6Q7Aj9LC9TnXzEUEtVrzTFg==
X-Received: by 2002:a17:906:8a6f:b0:780:96b4:d19e with SMTP id
 hy15-20020a1709068a6f00b0078096b4d19emr48197846ejc.624.1667839525330; 
 Mon, 07 Nov 2022 08:45:25 -0800 (PST)
Received: from lab.hqhome163.com ([194.183.10.152])
 by smtp.googlemail.com with ESMTPSA id
 17-20020a170906219100b007add1c4dadbsm3645684eju.153.2022.11.07.08.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Nov 2022 08:45:24 -0800 (PST)
From: Alessandro Carminati <alessandro.carminati@gmail.com>
To: ltp@lists.linux.it
Date: Mon,  7 Nov 2022 16:39:56 +0000
Message-Id: <20221107163957.721315-2-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221107163957.721315-1-alessandro.carminati@gmail.com>
References: <87h6zbxgc9.fsf@suse.de>
 <20221107163957.721315-1-alessandro.carminati@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
 lib/tst_device.c | 91 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 61 insertions(+), 30 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 8419b80c3..054e39bcd 100644
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
@@ -519,48 +524,74 @@ static int count_match_len(const char *first, const char *second)
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
-		}
-
-		len = count_match_len(path, mnt_point);
-		if (len > best_match_len) {
-			strcpy(dev, pre);
-			best_match_len = len;
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
+		} else {
+			tst_brkm(TBROK, NULL, "BTRFS ioctl failed. Is %s on a tmpfs?", path);
+			}
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
