Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10F5C021A9
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 21:51:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 441C13C9C28
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 22:51:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C09B43C093B
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 22:50:53 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A293C141787C
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 22:50:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739829051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5PRxOyKMPWJtNPa8+cWD6dS91VDhKMwV85ZbRxgeLo8=;
 b=Y9bmtOG+K3UhnNK1JxsjhVKad9t4wbMAQGf86frMt6XqvxoaUmemqjZyYpA7H11hMYD4HA
 PiGOXV3lnRQAFN+NwsOPopyqBf2H6t9vpUMM1bGUP8ZUfemfVPcHg2f5vHolFQ1iFn2s3D
 Ok2bPraW5zfX8dspQOAun1MpjX/qFk8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-pN6bm1b9PNKQxx149aex1Q-1; Mon,
 17 Feb 2025 16:50:49 -0500
X-MC-Unique: pN6bm1b9PNKQxx149aex1Q-1
X-Mimecast-MFC-AGG-ID: pN6bm1b9PNKQxx149aex1Q_1739829048
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8473A180087C
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 21:50:48 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.64.50])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33A741956054
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 21:50:47 +0000 (UTC)
Received: by segfault.usersys.redhat.com (Postfix, from userid 3734)
 id 8FED422AF2CA; Mon, 17 Feb 2025 16:50:45 -0500 (EST)
From: Jeff Moyer <jmoyer@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 17 Feb 2025 16:46:29 -0500
Message-ID: <20250217215038.177250-4-jmoyer@redhat.com>
In-Reply-To: <20250217215038.177250-1-jmoyer@redhat.com>
References: <20250217215038.177250-1-jmoyer@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wrxZpAx9DRNiGMvgWORzaHB2exBbjetNL1ppLuv8s8E_1739829048
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/3] tst_find_backing_dev(): add support for
 overlayfs
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

Add checks for overlayfs in tst_find_backing_dev.  As with btrfs, only
a single device is checked (the upper one) and returned from
tst_find_backing_dev().

The implementation uses both /proc/self/mountinfo and /proc/self/mounts.
The former is used to map a device to a mountpoint, and the latter is
used to get the file system options for the mountpoint.  All of the
information is present in mountinfo, but the file format is more complex,
and there are no glibc helpers for parsing it.

The '#define _GNU_SOURCE' was added for the use of the strchrnul(3)
function.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

---
v3: Address review comments from Petr:
    - Don't split long strings across lines
    - use TST_OVERLAYFS_MAGIC instead of the kernel's definition
    Note that I did not use SAFE_SSCANF, as tst_device.c uses the old
    style safe macros, and that function is not covered.
v2: Don't use libmount.  Instead, map from device number to mount-point
    using /proc/self/mountinfo, and then use the mntent.h helpers to get
    the mount options for the mountpoint from /proc/self/mounts.
---
 lib/tst_device.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 76c3a3e1e..29dc6974f 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2014 Cyril Hrubis chrubis@suse.cz
  */
 
+#define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/ioctl.h>
@@ -572,6 +573,136 @@ static void btrfs_get_uevent_path(char *tmp_path, char *uevent_path)
 	SAFE_CLOSEDIR(NULL, dir);
 }
 
+static char *overlay_mount_from_dev(dev_t dev)
+{
+	unsigned dev_major, dev_minor, mnt_major, mnt_minor;
+	FILE *fp;
+	char line[PATH_MAX];
+	char *mountpoint;
+	int ret;
+
+	dev_major = major(dev);
+	dev_minor = minor(dev);
+
+	fp = SAFE_FOPEN(NULL, "/proc/self/mountinfo", "r");
+	while (fgets(line, sizeof(line), fp) != NULL) {
+		ret = sscanf(line, "%*d %*d %u:%u %*s %ms",
+			     &mnt_major, &mnt_minor, &mountpoint);
+		if (ret != 3)
+			tst_brkm(TBROK, NULL,
+				 "failed to parse mountinfo line: \"%s\"",
+				 line);
+		if (mnt_major == dev_major && mnt_minor == dev_minor)
+			break;
+		free(mountpoint);
+		mountpoint = NULL;
+	}
+	SAFE_FCLOSE(NULL, fp);
+	if (!mountpoint)
+		tst_brkm(TBROK, NULL,
+			 "Unable to find mount entry for device %u:%u\n",
+			 dev_major, dev_minor);
+
+	return mountpoint;
+}
+
+static char *overlay_get_upperdir(char *mountpoint)
+{
+	FILE *mntf;
+	struct mntent *mnt;
+	char *optstr, *optstart, *optend;
+	char *upperdir = NULL;
+
+	mntf = setmntent("/proc/self/mounts", "r");
+	if (!mntf)
+		tst_brkm(TBROK | TERRNO, NULL, "Can't open /proc/self/mounts");
+
+	while ((mnt = getmntent(mntf)) != NULL) {
+		if (strncmp(mnt->mnt_dir, mountpoint, strlen(mountpoint)))
+			continue;
+
+		if (strncmp(mnt->mnt_type, "overlay", strlen("overlay")))
+			tst_brkm(TBROK, NULL,
+				 "expected overlayfs on mount point \"%s\", but it is of type %s.",
+				 mountpoint, mnt->mnt_type);
+
+		optstr = hasmntopt(mnt, "upperdir");
+		if (optstr) {
+			optstart = strchr(optstr, '=');
+			optstart++;
+			optend = strchrnul(optstr, ',');
+			upperdir = calloc(optend - optstart + 1, 1);
+			memcpy(upperdir, optstart, optend - optstart);
+			break;
+		} else {
+			tst_brkm(TBROK, NULL,
+				 "mount point %s does not contain an upperdir",
+				 mountpoint);
+		}
+	}
+	endmntent(mntf);
+
+	if (!upperdir)
+		tst_brkm(TBROK, NULL,
+			 "Unable to find mount point \"%s\" in mount table",
+			 mountpoint);
+
+	return upperdir;
+}
+
+/*
+ * To get from a file or directory on an overlayfs to a device
+ * for an underlying mountpoint requires the following steps:
+ *
+ * 1. stat() the pathname and pick out st_dev.
+ * 2. use the st_dev to look up the mount point of the file
+ *    system in /proc/self/mountinfo
+ *
+ * Because 'mountinfo' is a much more complicated file format than
+ * 'mounts', we switch to looking up the mount point in /proc/mounts,
+ * and use the mntent.h helpers to parse the entries.
+ *
+ * 3. Using getmntent(), find the entry for the mount point identified
+ *    in step 2.
+ * 4. Call hasmntopt() to find the upperdir option, and parse that
+ *    option to get to the path name for the upper directory.
+ * 5. Call stat on the upper directory.  This should now contain
+ *    the major and minor number for the underlying device (assuming
+ *    that there aren't nested overlay file systems).
+ * 6. Populate the uevent path.
+ *
+ * Example /proc/self/mountinfo line for overlayfs:
+ *    471 69 0:48 / /tmp rw,relatime shared:242 - overlay overlay rw,seclabel,lowerdir=/tmp,upperdir=/mnt/upper/upper,workdir=/mnt/upper/work,uuid=null
+ *
+ * See section 3.5 of the kernel's Documentation/filesystems/proc.rst file
+ * for a detailed explanation of the mountinfo format.
+ */
+static void overlay_get_uevent_path(char *tmp_path, char *uevent_path)
+{
+	int ret;
+	struct stat st;
+	char *mountpoint, *upperdir;
+
+	tst_resm(TINFO, "Use OVERLAYFS specific strategy");
+
+	ret = stat(tmp_path, &st);
+	if (ret)
+		tst_brkm(TBROK | TERRNO, NULL, "stat failed");
+
+	mountpoint = overlay_mount_from_dev(st.st_dev);
+	upperdir = overlay_get_upperdir(mountpoint);
+	free(mountpoint);
+
+	ret = stat(upperdir, &st);
+	free(upperdir);
+	if (ret)
+		tst_brkm(TBROK | TERRNO, NULL, "stat failed");
+
+	tst_resm(TINFO, "Warning: used first of multiple backing devices.");
+	sprintf(uevent_path, "/sys/dev/block/%d:%d/uevent",
+		major(st.st_dev), minor(st.st_dev));
+}
+
 __attribute__((nonnull))
 void tst_find_backing_dev(const char *path, char *dev, size_t dev_size)
 {
@@ -599,6 +730,8 @@ void tst_find_backing_dev(const char *path, char *dev, size_t dev_size)
 
 	if (fsbuf.f_type == TST_BTRFS_MAGIC) {
 		btrfs_get_uevent_path(tmp_path, uevent_path);
+	} else if (fsbuf.f_type == TST_OVERLAYFS_MAGIC) {
+		overlay_get_uevent_path(tmp_path, uevent_path);
 	} else if (dev_major == 0) {
 		tst_brkm(TBROK, NULL, "%s resides on an unsupported pseudo-file system.", path);
 	} else {
-- 
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
