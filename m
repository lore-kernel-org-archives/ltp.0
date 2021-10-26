Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AB2C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 18:45:07 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91669600CD
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 18:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 91669600CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A0893C6934
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 20:45:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F4A43C6ACE
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 20:44:18 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DBA961001588
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 20:44:17 +0200 (CEST)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: krisman)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id BB0151F40D7C;
 Tue, 26 Oct 2021 19:44:16 +0100 (BST)
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: ltp@lists.linux.it,
	jack@suse.com,
	amir73il@gmail.com
Date: Tue, 26 Oct 2021 15:42:38 -0300
Message-Id: <20211026184239.151156-10-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211026184239.151156-1-krisman@collabora.com>
References: <20211026184239.151156-1-krisman@collabora.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 09/10] syscalls/fanotify20: Test file event with
 broken inode
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
Cc: linux-ext4@vger.kernel.org, kernel@collabora.com,
 Gabriel Krisman Bertazi <krisman@collabora.com>, khazhy@google.com,
 repnop@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This test corrupts an inode entry with an invalid mode through debugfs
and then tries to access it.  This should result in a ext4 error, which
we monitor through the fanotify group.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 .../kernel/syscalls/fanotify/fanotify20.c     | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index 5c5ee3c6fb74..7bcddcaa98cb 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -38,6 +38,10 @@
 #define	FILEID_INVALID		0xff
 #endif
 
+#ifndef EFSCORRUPTED
+#define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
+#endif
+
 #define BUF_SIZE 256
 static char event_buf[BUF_SIZE];
 int fd_notify;
@@ -63,6 +67,17 @@ static void trigger_fs_abort(void)
 		   MS_REMOUNT|MS_RDONLY, "abort");
 }
 
+static void tcase2_trigger_lookup(void)
+{
+	int ret;
+
+	/* SAFE_OPEN cannot be used here because we expect it to fail. */
+	ret = open(MOUNT_PATH"/"BAD_DIR, O_RDONLY, 0);
+	if (ret != -1 && errno != EUCLEAN)
+		tst_res(TFAIL, "Unexpected lookup result(%d) of %s (%d!=%d)",
+			ret, BAD_DIR, errno, EUCLEAN);
+}
+
 static struct test_case {
 	char *name;
 	int error;
@@ -77,6 +92,13 @@ static struct test_case {
 		.error = ESHUTDOWN,
 		.fid = &null_fid,
 	},
+	{
+		.name = "Lookup of inode with invalid mode",
+		.trigger_error = &tcase2_trigger_lookup,
+		.error_count = 1,
+		.error = EFSCORRUPTED,
+		.fid = &bad_file_fid,
+	},
 };
 
 int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
