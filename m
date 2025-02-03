Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06811C02192
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 22:10:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC5DA3C6508
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 23:10:04 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4177E3C6508
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 23:09:14 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 74912600C84
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 23:09:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738620552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rp8XvtwzteaLfDRMh0cNxJdjYKssFfX8wyTZ+dvBEKI=;
 b=IzqEJf/+ucQrBaXIvOkfbo8t51cu9ottrIKnAU3U/3PkWKdhBYmZQgPpOMrI2FutEnP8iZ
 0P0BJfstyCHgzKGAIxgXel7NR3muKGYMEXKBToXgcTIUGWOhhzD06Ryz/c3FVBITTflCDS
 wC5ItWidyA5+anid5VPj7a23IJSPjWs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-UO5KCw5BPMuycjp6Va5fBw-1; Mon,
 03 Feb 2025 17:09:10 -0500
X-MC-Unique: UO5KCw5BPMuycjp6Va5fBw-1
X-Mimecast-MFC-AGG-ID: UO5KCw5BPMuycjp6Va5fBw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB38E1800370
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 22:09:09 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.65.155])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 567EE18008C0; Mon,  3 Feb 2025 22:09:09 +0000 (UTC)
Received: by segfault.usersys.redhat.com (Postfix, from userid 3734)
 id 78CBD24EA207; Mon,  3 Feb 2025 17:09:06 -0500 (EST)
From: Jeff Moyer <jmoyer@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  3 Feb 2025 17:06:00 -0500
Message-ID: <20250203220903.399544-4-jmoyer@redhat.com>
In-Reply-To: <20250203220903.399544-1-jmoyer@redhat.com>
References: <20250203220903.399544-1-jmoyer@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bjgkPn-UF7GrjkOX38mdDVsdcac1oiJIsrxRnqYUhEg_1738620549
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] lib/tst_device.c: add support for overlayfs
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

Add checks for overlayfs in tst_find_backing_dev.  As with btrfs, only
a single device is checked (the upper one) and returned from
tst_find_backing_dev().

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
---
 .gitignore       |  1 +
 INSTALL          |  6 ++---
 lib/Makefile     |  2 +-
 lib/libltp.a     |  1 +
 lib/tst_device.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 68 insertions(+), 4 deletions(-)
 create mode 100644 lib/libltp.a

diff --git a/.gitignore b/.gitignore
index 24f4a4ea8..38bf1fab9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -9,6 +9,7 @@ core
 .gdb_history
 .gdbinit
 lib*.a
+!libltp.a
 .cache.mk
 *.dwo
 *.mod
diff --git a/INSTALL b/INSTALL
index ad43514d4..557cf4abc 100644
--- a/INSTALL
+++ b/INSTALL
@@ -6,15 +6,15 @@ package in any Linux distribution (no specific version is required).
 
 Debian / Ubuntu
 
-	# apt install gcc git make pkgconf autoconf automake bison flex m4 linux-headers-$(uname -r) libc6-dev
+	# apt install gcc git make pkgconf autoconf automake bison flex m4 linux-headers-$(uname -r) libc6-dev libmount-dev
 
 openSUSE / SLES
 
-	# zypper install gcc git make pkg-config autoconf automake bison flex m4 linux-glibc-devel glibc-devel
+	# zypper install gcc git make pkg-config autoconf automake bison flex m4 linux-glibc-devel glibc-devel libmount-devel
 
 Fedora / CentOS / RHEL
 
-	# yum install gcc git make pkgconf autoconf automake bison flex m4 kernel-headers glibc-headers
+	# yum install gcc git make pkgconf autoconf automake bison flex m4 kernel-headers glibc-headers libmount-devel
 
 These are minimal build requirements for git compilation. Some tests require
 extra development files of some libraries, see ci/*.sh. There is also
diff --git a/lib/Makefile b/lib/Makefile
index 67169f149..2f180405e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -14,7 +14,7 @@ else
 FILTER_OUT_LIBSRCS	+= tlibio.c tst_safe_sysv_ipc.c
 endif
 
-INTERNAL_LIB		:= libltp.a
+INTERNAL_LIB		:= libltp_internal.a
 
 pc_file			:= $(DESTDIR)/$(datarootdir)/pkgconfig/ltp.pc
 
diff --git a/lib/libltp.a b/lib/libltp.a
new file mode 100644
index 000000000..006f3557e
--- /dev/null
+++ b/lib/libltp.a
@@ -0,0 +1 @@
+INPUT (libltp_internal.a -lmount)
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 744e08a68..d99da1c51 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -19,6 +19,7 @@
 #include <linux/limits.h>
 #include <sys/vfs.h>
 #include <linux/magic.h>
+#include <libmount/libmount.h>
 #include "lapi/syscalls.h"
 #include "test.h"
 #include "safe_macros.h"
@@ -573,6 +574,65 @@ static void btrfs_get_uevent_path(char *tmp_path, char *uevent_path)
 	SAFE_CLOSEDIR(NULL, dir);
 }
 
+static void overlay_get_dev(struct libmnt_fs *fs, const char *dir_opt,
+			    dev_t *dev)
+{
+	int ret;
+	char *value, *dir_name;
+	size_t val_size;
+	struct stat st;
+
+	ret = mnt_fs_get_option(fs, dir_opt, &value, &val_size);
+	if (ret)
+		tst_brkm(TBROK, NULL,
+			 "overlayfs: no %s in mount options", dir_opt);
+
+	dir_name = calloc(val_size + 1, 1);
+	if (!dir_name)
+		tst_brkm(TBROK | TERRNO, NULL, "calloc failed");
+
+	memcpy(dir_name, value, val_size);
+	if (stat(dir_name, &st) < 0)
+		tst_brkm(TBROK | TERRNO, NULL, "stat failed");
+
+	*dev = st.st_dev;
+	free(dir_name);
+}
+
+/*
+ * NOTE: this will not work for stacked overlay mounts.
+ */
+static void overlay_get_uevent_path(char *tmp_path, char *uevent_path)
+{
+	struct libmnt_table *mtab;
+	struct libmnt_fs *fs;
+	struct stat st;
+	dev_t upper_dev;
+
+	tst_resm(TINFO, "Use OVERLAYFS specific strategy");
+
+	mtab = mnt_new_table();
+	if (!mtab)
+		tst_brkm(TBROK | TERRNO, NULL, "mnt_new_table failed");
+
+	if (mnt_table_parse_file(mtab, "/proc/self/mountinfo") != 0)
+		tst_brkm(TBROK, NULL, "mnt_table_parse_file failed");
+
+	if (stat(tmp_path, &st) < 0)
+		tst_brkm(TBROK | TERRNO, NULL, "stat failed");
+
+	fs = mnt_table_find_devno(mtab, st.st_dev, MNT_ITER_FORWARD);
+	if (!fs)
+		tst_brkm(TBROK, NULL, "mnt_table_find_devno failed");
+
+	overlay_get_dev(fs, "upperdir", &upper_dev);
+	mnt_unref_table(mtab);
+
+	tst_resm(TINFO, "Warning: used first of multiple backing devices.");
+	sprintf(uevent_path, "/sys/dev/block/%d:%d/uevent",
+		major(upper_dev), minor(upper_dev));
+}
+
 __attribute__((nonnull))
 void tst_find_backing_dev(const char *path, char *dev, size_t dev_size)
 {
@@ -600,6 +660,8 @@ void tst_find_backing_dev(const char *path, char *dev, size_t dev_size)
 
 	if (fsbuf.f_type == BTRFS_SUPER_MAGIC) {
 		btrfs_get_uevent_path(tmp_path, uevent_path);
+	} else if (fsbuf.f_type == OVERLAYFS_SUPER_MAGIC) {
+		overlay_get_uevent_path(tmp_path, uevent_path);
 	} else if (dev_major == 0) {
 		tst_brkm(TBROK, NULL, "%s resides on an unsupported pseudo-file system.", path);
 	} else {
-- 
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
