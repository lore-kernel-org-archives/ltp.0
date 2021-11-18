Return-Path: <SRS0=Poid=QF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A7AC433F5
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 23:59:13 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7184F6113D
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 23:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7184F6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E582E3C89AD
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 00:59:10 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37F933C3349
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 00:58:16 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7A4DE1400768
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 00:58:15 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id 599B41F47098
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1637279894; bh=mwgQRcAPY0UhabSUmUkf3+MRuf8WSxV9z4jkotD/HZw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UqdoJgHiyJ7s4GJhgdAHy6SB0/sIJA9kEwf6LF2DTA3nWRmeztPUtyFRk1sEx88TP
 DPX1Vn7wBXrhHfyTjQQtGEMAndFRxbZ3lpRjWV9FxS6HiQu1jM+PmWMDo8pTinHOl9
 lvyzb1RJuswTdG/4Cvs2tdjAYPuWzIBHkpExJQ1QT21nK2QBWIWL5n2pVIBvVVcvHk
 xB5xsgBf0IlGsZFb9OWRTo3SRbmykOdQCLBfePZ9rNcLTqrRTlM5EFmTk4inU9dyyi
 Cn7Oprmo4CgdnkYt2LeSBgdTnLFzkOLFYUNSCIZstUUY0KWFjJhr5rnblcBIvntXDh
 0vVfHx6wgWGPA==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: pvorel@suse.cz,
	jack@suse.com,
	amir73il@gmail.com,
	repnop@google.com
Date: Thu, 18 Nov 2021 18:57:41 -0500
Message-Id: <20211118235744.802584-7-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211118235744.802584-1-krisman@collabora.com>
References: <20211118235744.802584-1-krisman@collabora.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 6/9] syscalls/fanotify22: Support submission of
 debugfs commands
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
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>, linux-ext4@vger.kernel.org,
 kernel@collabora.com, ltp@lists.linux.it, khazhy@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

In order to test FAN_FS_ERROR, we want to corrupt the filesystem.  The
easiest way to do it is by using debugfs.  Add a small helper to issue
debugfs requests.  Since most likely this will be the only testcase to
need this, don't bother making it a proper helper for now.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
changes since v1:
  - Add .needs_cmds to require debugfs
---
 testcases/kernel/syscalls/fanotify/fanotify22.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index eeee582f1268..bb44ed55e96e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
@@ -49,6 +49,13 @@ static void trigger_fs_abort(void)
 		   MS_REMOUNT|MS_RDONLY, "abort");
 }
 
+static void do_debugfs_request(const char *dev, char *request)
+{
+	const char *cmd[] = {"debugfs", "-w", dev, "-R", request, NULL};
+
+	SAFE_CMD(cmd, NULL, NULL);
+}
+
 static struct test_case {
 	char *name;
 	int error;
@@ -227,7 +234,11 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
 	.needs_root = 1,
-	.dev_fs_type = "ext4"
+	.dev_fs_type = "ext4",
+	.needs_cmds = (const char *[]) {
+		"debugfs",
+		NULL
+	}
 };
 
 #else
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
