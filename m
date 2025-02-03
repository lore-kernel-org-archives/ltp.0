Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32F3C02193
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 22:09:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C5CB3C8F7C
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 23:09:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5AEFF3C6508
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 23:09:13 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8F0E6200BB9
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 23:09:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738620551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9p3UvFbUpjzvIq4NXGsQBK/uBL2sQZusn3Mm4ESCHzw=;
 b=T11lvXQMFBMLwcL5SqpqLsZFFcR0H8Iu2RszM4afNV2BW9R7PQZwDHPv0DN6VKjtAau5qD
 w/6SRFHlrhrWQxP9h0hG00sN5g45MS/ChGExwrjvup4wXwW72eJCpwhCXQXd6IpzhVKqwe
 kuQlZ+WBJdBLyliqVVKTVZs8Ys5h2F4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-vXWUiXTMPUWzcmHjxF0THg-1; Mon,
 03 Feb 2025 17:09:09 -0500
X-MC-Unique: vXWUiXTMPUWzcmHjxF0THg-1
X-Mimecast-MFC-AGG-ID: vXWUiXTMPUWzcmHjxF0THg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA3401800269
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 22:09:08 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.65.155])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F06B195E3E3; Mon,  3 Feb 2025 22:09:08 +0000 (UTC)
Received: by segfault.usersys.redhat.com (Postfix, from userid 3734)
 id 76A2A24EA206; Mon,  3 Feb 2025 17:09:06 -0500 (EST)
From: Jeff Moyer <jmoyer@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  3 Feb 2025 17:05:59 -0500
Message-ID: <20250203220903.399544-3-jmoyer@redhat.com>
In-Reply-To: <20250203220903.399544-1-jmoyer@redhat.com>
References: <20250203220903.399544-1-jmoyer@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o_mp627Iov8gjs6SYgu9FwCCA27tn1mEXiNUDQtsZ3M_1738620548
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] lib/tst_device.c: check for BTRFS_SUPER_MAGIC
 instead of device major of 0
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

stat() may return a major number of 0 in st_dev for any number of
pseudo file systems.  Check for the exact file system instead.  There
should be no change in behavior with this patch.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
---
 lib/tst_device.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 70234a83c..744e08a68 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -17,6 +17,8 @@
 #include <sys/sysmacros.h>
 #include <linux/btrfs.h>
 #include <linux/limits.h>
+#include <sys/vfs.h>
+#include <linux/magic.h>
 #include "lapi/syscalls.h"
 #include "test.h"
 #include "safe_macros.h"
@@ -546,9 +548,6 @@ static void btrfs_get_uevent_path(char *tmp_path, char *uevent_path)
 		sprintf(bdev_path,
 			"/sys/fs/btrfs/%s/devices", btrfs_uuid_str);
 	} else {
-		if (errno == ENOTTY)
-			tst_brkm(TBROK | TERRNO, NULL, "BTRFS ioctl failed. Is %s on a tmpfs?", tmp_path);
-
 		tst_brkm(TBROK | TERRNO, NULL, "BTRFS ioctl on %s failed.", tmp_path);
 	}
 	SAFE_CLOSE(NULL, fd);
@@ -578,6 +577,7 @@ __attribute__((nonnull))
 void tst_find_backing_dev(const char *path, char *dev, size_t dev_size)
 {
 	struct stat buf;
+	struct statfs fsbuf;
 	char uevent_path[PATH_MAX+PATH_MAX+10]; //10 is for the static uevent path
 	char dev_name[NAME_MAX];
 	char tmp_path[PATH_MAX];
@@ -595,8 +595,13 @@ void tst_find_backing_dev(const char *path, char *dev, size_t dev_size)
 	dev_minor = minor(buf.st_dev);
 	*dev = '\0';
 
-	if (dev_major == 0) {
+	if (statfs(path, &fsbuf) < 0)
+		tst_brkm(TWARN | TERRNO, NULL, "statfs() failed");
+
+	if (fsbuf.f_type == BTRFS_SUPER_MAGIC) {
 		btrfs_get_uevent_path(tmp_path, uevent_path);
+	} else if (dev_major == 0) {
+		tst_brkm(TBROK, NULL, "%s resides on an unsupported pseudo-file system.", path);
 	} else {
 		tst_resm(TINFO, "Use uevent strategy");
 		sprintf(uevent_path,
-- 
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
