Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D14C47258
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 11:50:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43E0C3CC791
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 12:50:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D372F3CE213
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 12:48:57 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 59091600FBA
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 12:48:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706010534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XJm7hR616bgL4oP2KvvsRKG/qxehq+IyMnQRzR8NOh4=;
 b=dkM3On2C3OZiW/ycc/GeCZlB6tbBdREkYUd0zSTnCQcvsmj/nINiVjvYy9JkWRA0GUFs3O
 pgdelAYxat+Jm3xTV3Irr5ouBKRqfb+4kxSuCvCDFy4YCuuQEm0dhoV0tklFka0p9nAjTs
 wSr5snrBLv5PRdJNLFNP+4+BaVWMcjA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-EnUiUgUqM7S5x0FAEn33ZA-1; Tue,
 23 Jan 2024 06:48:53 -0500
X-MC-Unique: EnUiUgUqM7S5x0FAEn33ZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32DD0282D3C4;
 Tue, 23 Jan 2024 11:48:53 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC36851D5;
 Tue, 23 Jan 2024 11:48:51 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 23 Jan 2024 19:48:39 +0800
Message-Id: <20240123114840.2610533-5-liwang@redhat.com>
In-Reply-To: <20240123114840.2610533-1-liwang@redhat.com>
References: <20240123114840.2610533-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH V3 4/5] libswap: add function to prealloc contiguous
 file
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

The improve makes several key updates to the swap file handling
in the libswap.c file:

  It incorporates support for the Btrfs filesystem, which is now
  recognized as a valid filesystem for swap files.

  A new function, set_nocow_attr, is added to apply the FS_NOCOW_FL
  flag to files on Btrfs filesystems.

  Introduces a new prealloc_contiguous_file function. This method
  preallocates a contiguous block of space for the swap file during
  its creation, rather than filling the file with data as was done
  previously.

  Modifications to the make_swapfile function are made to utilize
  prealloc_contiguous_file for creating the swap file, ensuring
  the file is created with contiguous space on the filesystem.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 libs/libltpswap/libswap.c | 48 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index 8c2ce6cd7..b253dbeec 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -4,6 +4,7 @@
  * Author: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
  */
 
+#include <linux/fs.h>
 #include <errno.h>
 
 #define TST_NO_DEFAULT_MAIN
@@ -13,6 +14,7 @@
 #include "lapi/syscalls.h"
 
 static const char *const swap_supported_fs[] = {
+	"btrfs",
 	"ext2",
 	"ext3",
 	"ext4",
@@ -23,6 +25,50 @@ static const char *const swap_supported_fs[] = {
 	NULL
 };
 
+static void set_nocow_attr(const char *filename)
+{
+	int fd;
+	int attrs;
+
+	tst_res(TINFO, "FS_NOCOW_FL attribute set on %s", filename);
+
+	fd = SAFE_OPEN(filename, O_RDONLY);
+
+	SAFE_IOCTL(fd, FS_IOC_GETFLAGS, &attrs);
+
+	attrs |= FS_NOCOW_FL;
+
+	SAFE_IOCTL(fd, FS_IOC_SETFLAGS, &attrs);
+
+	SAFE_CLOSE(fd);
+}
+
+static int prealloc_contiguous_file(const char *path, size_t bs, size_t bcount)
+{
+	int fd;
+
+	fd = open(path, O_CREAT|O_WRONLY|O_TRUNC, 0600);
+	if (fd < 0)
+		return -1;
+
+	/* Btrfs file need set 'nocow' attribute */
+	if (tst_fs_type(path) == TST_BTRFS_MAGIC)
+		set_nocow_attr(path);
+
+	if (tst_prealloc_size_fd(fd, bs, bcount)) {
+		close(fd);
+		unlink(path);
+		return -1;
+	}
+
+	if (close(fd) < 0) {
+		unlink(path);
+		return -1;
+	}
+
+	return 0;
+}
+
 /*
  * Make a swap file
  */
@@ -32,7 +78,7 @@ int make_swapfile(const char *swapfile, int safe)
 		tst_brk(TBROK, "Insufficient disk space to create swap file");
 
 	/* create file */
-	if (tst_fill_file(swapfile, 0, sysconf(_SC_PAGESIZE), 10) != 0)
+	if (prealloc_contiguous_file(swapfile, sysconf(_SC_PAGESIZE), 10) != 0)
 		tst_brk(TBROK, "Failed to create swapfile");
 
 	/* make the file swapfile */
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
