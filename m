Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5CBC433F5
	for <ltp@archiver.kernel.org>; Tue, 29 Mar 2022 07:45:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3EAA3C9B54
	for <ltp@archiver.kernel.org>; Tue, 29 Mar 2022 09:45:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E3293C98CE
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 09:44:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B1BFC600903
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 09:44:48 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id D805B212C2;
 Tue, 29 Mar 2022 07:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1648539887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MNI1DmZMRNznAzc/v0i8Egjhy7ZolMa4DCJL0y0poJ0=;
 b=R0HQrHnqNWxbyH3yQfurbun8iMpC8he/4eUYd1292EoK3xp0vOB1ZcdkVy605ScrzfTMmZ
 Zeigh8qy3bP2XhyccUVjYss5iuIJeNMihop0r7mRRt2jrtyVoJ4bVykrKLtI27XKBG0BNz
 fA9EBIJJUmFq2ljWrmtaRnDPYvTSfxs=
Received: from g78.suse.de (unknown [10.163.24.182])
 by relay2.suse.de (Postfix) with ESMTP id A61D6A3B83;
 Tue, 29 Mar 2022 07:44:47 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 29 Mar 2022 08:44:39 +0100
Message-Id: <20220329074440.26214-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329074440.26214-1-rpalethorpe@suse.com>
References: <20220329074440.26214-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] API/device: Add func to stat the actual dev
 mounted to a path
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

BTRFS appears to create "anonymous" block devices for each sub
partition. Stating an inode on this FS (and others) just returns the
anon dev number. Instead we have to find the mounted device in
/proc/self/mounts and stat its special file in /dev/.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_device.h |  6 ++++++
 lib/tst_device.c     | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/tst_device.h b/include/tst_device.h
index 95ccd453e..977427f1c 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -8,6 +8,7 @@
 
 #include <unistd.h>
 #include <stdint.h>
+#include <sys/stat.h>
 
 struct tst_device {
 	const char *dev;
@@ -112,6 +113,11 @@ void tst_purge_dir(const char *path);
  */
 void tst_find_backing_dev(const char *path, char *dev);
 
+/*
+ * Stat the device mounted on a given path.
+ */
+void tst_stat_mount_dev(const char *const mnt_path, struct stat *const st);
+
 /*
  * Returns the size of a physical device block size for the specific path
  * @path   Path to find the block size
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 1ef667fa0..d296f9118 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -25,6 +25,7 @@
 #include <sys/stat.h>
 #include <sys/ioctl.h>
 #include <sys/mount.h>
+#include <mntent.h>
 #include <errno.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -548,6 +549,40 @@ void tst_find_backing_dev(const char *path, char *dev)
 		tst_brkm(TCONF, NULL, "dev(%s) isn't a block dev", dev);
 }
 
+void tst_stat_mount_dev(const char *const mnt_path, struct stat *const st)
+{
+	struct mntent *mnt;
+	FILE *mntf = setmntent("/proc/self/mounts", "r");
+
+	if (!mntf) {
+		tst_brkm(TBROK | TERRNO, NULL, "Can't open /proc/self/mounts");
+		return;
+	}
+
+	mnt = getmntent(mntf);
+	if (!mnt) {
+		tst_brkm(TBROK | TERRNO, NULL, "Can't read mounts or no mounts?");
+		return;
+	}
+
+	do {
+		if (strcmp(mnt->mnt_dir, mnt_path)) {
+			mnt = getmntent(mntf);
+			continue;
+		}
+
+		if (stat(mnt->mnt_fsname, st)) {
+			tst_brkm(TBROK | TERRNO, NULL,
+				 "Can't stat '%s', mounted at '%s'",
+				 mnt->mnt_fsname, mnt_path);
+		}
+
+		return;
+	} while (mnt);
+
+	tst_brkm(TBROK, NULL, "Could not find mount device");
+}
+
 int tst_dev_block_size(const char *path)
 {
 	int fd;
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
