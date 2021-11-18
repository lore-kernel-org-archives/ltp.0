Return-Path: <SRS0=Poid=QF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A7EC433EF
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 23:59:22 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B3C6113D
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 23:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 87B3C6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4266E3C89AB
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 00:59:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EA8D3C89A0
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 00:58:19 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E32871A0119D
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 00:58:18 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id C77F51F47098
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1637279898; bh=AMEWurQydOhlrkam7tWoA2YxYk8g84h/9nWOOD1niKc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PQTOYubV3sJj0NfeB6mNscv4HVzgadJYwxrFWy6xVm30NO13cF85tMXbZDHUqET8q
 1qdN5knpN3mzINJ9EfnE82+uEg1ulJXE1PFWBY/e5qeApzyBUGv1G8ECQAWdy2u9P1
 ABsQeOeN7hYYLugT++og3jrz1y7G66h+nbhIieq1X89ln3raxuKzsTmFMo9SHz6sWV
 h3GgLotnj/LPOwQvmgOjkrP80pFH8kJRGL5thcAbk0z24RiRSrUYyS705+XKO8rINO
 UpFFuW/7CZHkq6kgWWmLkXpJ0GBp5Bjx0hadrZzLs4dR1P6mfzyJ7MJUS1+vMyYf7I
 pyWjWtysvQuqA==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: pvorel@suse.cz,
	jack@suse.com,
	amir73il@gmail.com,
	repnop@google.com
Date: Thu, 18 Nov 2021 18:57:42 -0500
Message-Id: <20211118235744.802584-8-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211118235744.802584-1-krisman@collabora.com>
References: <20211118235744.802584-1-krisman@collabora.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 7/9] syscalls/fanotify22: Create a corrupted file
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

Allocate a test directory and corrupt it with debugfs.  The corruption
is done by writing an invalid inode mode.  This file can be later
looked up to trigger a corruption error.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 testcases/kernel/syscalls/fanotify/fanotify22.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index bb44ed55e96e..5d8b4eec74bd 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
@@ -39,9 +39,12 @@ static char event_buf[BUF_SIZE];
 int fd_notify;
 
 #define MOUNT_PATH "test_mnt"
+#define BASE_DIR "internal_dir"
+#define BAD_DIR BASE_DIR"/bad_dir"
 
 /* These expected FIDs are common to multiple tests */
 static struct fanotify_fid_t null_fid;
+static struct fanotify_fid_t bad_file_fid;
 
 static void trigger_fs_abort(void)
 {
@@ -197,6 +200,18 @@ static void do_test(unsigned int i)
 	check_event(event_buf, read_len, tcase);
 }
 
+static void pre_corrupt_fs(void)
+{
+	SAFE_MKDIR(MOUNT_PATH"/"BASE_DIR, 0777);
+	SAFE_MKDIR(MOUNT_PATH"/"BAD_DIR, 0777);
+
+	fanotify_save_fid(MOUNT_PATH"/"BAD_DIR, &bad_file_fid);
+
+	SAFE_UMOUNT(MOUNT_PATH);
+	do_debugfs_request(tst_device->dev, "sif " BAD_DIR " mode 0xff");
+	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);
+}
+
 static void init_null_fid(void)
 {
 	/* Use fanotify_save_fid to fill the fsid and overwrite the
@@ -213,6 +228,7 @@ static void setup(void)
 	REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_CLASS_NOTIF|FAN_REPORT_FID,
 						FAN_MARK_FILESYSTEM,
 						FAN_FS_ERROR, ".");
+	pre_corrupt_fs();
 
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF|FAN_REPORT_FID,
 				       O_RDONLY);
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
