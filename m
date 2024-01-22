Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78025C4725D
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 07:31:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11EF33CE229
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 08:31:05 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A16E43CE22C
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 08:30:01 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1963110005A2
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 08:30:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705908599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uloy3yWgLpRH0WR5Cft3HdrpQPfZgNWLzDtiVwb8VsQ=;
 b=c3j0XdPXsJVwozNu/ZRkPUboUGGbOzLq01tQuIvd/y4gFd+FR8vVlQigS0RTd+3yPIUfMi
 tRM/N07npsuZRabRmNJv96vRsGHEbVS/G8A9hcu3kmqxD+JVh/9iYoyzhS2awMtKqoWreb
 aSrq5r+cvEYugz/zuVw2ddQK0vyQB9Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-c7C081zJPEu2bQu7O8Z31A-1; Mon,
 22 Jan 2024 02:29:57 -0500
X-MC-Unique: c7C081zJPEu2bQu7O8Z31A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E6603C0EAC4
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 07:29:57 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 258B9492BC6
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 07:29:55 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 22 Jan 2024 15:29:48 +0800
Message-Id: <20240122072948.2568801-4-liwang@redhat.com>
In-Reply-To: <20240122072948.2568801-1-liwang@redhat.com>
References: <20240122072948.2568801-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] libswap: add Btrfs noCOW attribute setting for
 swap files
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

The patch aims to ensure swap files on Btrfs filesystems are created
with the appropriate FS_NOCOW_FL attribute, which is necessary to
disable CoW (Copy-on-Write) for swap files, perthe btrfs(5) manual page.
This change is gated behind a kernel version check to ensure compatibility
with the system's capabilities.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 libs/libltpswap/libswap.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index 623f2fb3c..0b1d9a227 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -4,6 +4,7 @@
  * Author: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
  */
 
+#include <linux/fs.h>
 #include <errno.h>
 
 #define TST_NO_DEFAULT_MAIN
@@ -23,11 +24,37 @@ static const char *const swap_supported_fs[] = {
 	NULL
 };
 
+static void set_nocow_attr(const char *filename)
+{
+	int fd;
+	int attrs;
+
+	fd = SAFE_OPEN(filename, O_RDONLY);
+
+	if (ioctl(fd, FS_IOC_GETFLAGS, &attrs) == -1) {
+		tst_res(TFAIL | TERRNO, "Error getting attributes");
+		close(fd);
+		return;
+	}
+
+	attrs |= FS_NOCOW_FL;
+
+	if (ioctl(fd, FS_IOC_SETFLAGS, &attrs) == -1)
+		tst_res(TFAIL | TERRNO, "Error setting FS_NOCOW_FL attribute");
+	else
+		tst_res(TINFO, "FS_NOCOW_FL attribute set on %s\n", filename);
+
+	close(fd);
+}
+
 /*
  * Make a swap file
  */
 int make_swapfile(const char *swapfile, int safe)
 {
+	long fs_type = tst_fs_type(swapfile);
+	const char *fstype = tst_fs_type_name(fs_type);
+
 	if (!tst_fs_has_free(".", sysconf(_SC_PAGESIZE) * 10, TST_BYTES))
 		tst_brk(TBROK, "Insufficient disk space to create swap file");
 
@@ -35,6 +62,14 @@ int make_swapfile(const char *swapfile, int safe)
 	if (tst_fill_file(swapfile, 0, sysconf(_SC_PAGESIZE), 10) != 0)
 		tst_brk(TBROK, "Failed to create swapfile");
 
+	/* Btrfs file need set 'nocow' attribute */
+	if (strcmp(fstype, "btrfs") == 0) {
+		if (tst_kvercmp(5, 0, 0) > 0)
+			set_nocow_attr(swapfile);
+		else
+			tst_brk(TCONF, "Swapfile on %s not implemented", fstype);
+	}
+
 	/* make the file swapfile */
 	const char *argv[2 + 1];
 	argv[0] = "mkswap";
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
