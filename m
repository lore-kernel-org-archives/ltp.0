Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E92C71153
	for <ltp@archiver.kernel.org>; Mon, 28 Aug 2023 10:03:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95C983CC151
	for <ltp@archiver.kernel.org>; Mon, 28 Aug 2023 12:02:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8622D3CB708
 for <ltp@lists.linux.it>; Mon, 28 Aug 2023 12:02:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6C2DC1400E1F
 for <ltp@lists.linux.it>; Mon, 28 Aug 2023 12:02:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A7DF1F38A;
 Mon, 28 Aug 2023 10:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693216964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=P/Y8HhvWEqAUMBBLYfFek7WiBWgJncLpvozW0PbQoes=;
 b=VrqAK6QthwA/7ACrdGzq/pldu1TvssZYiPEChgEV+aFyQgEvrwpy4SD5tVxOWi4tl7g76y
 emI/iG36g4kBf0IGQKIXeakhkISC2rrQaJiDzS/1qbDfvejPFEEJyGQDC2bPkvAU18ukXy
 9WIWtkvF6XUpyeT4x1lznX3mI8MMFPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693216964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=P/Y8HhvWEqAUMBBLYfFek7WiBWgJncLpvozW0PbQoes=;
 b=FKp3wrB6okaEJIh/u9IDKM/glkH+pJAofVlaQKLkGYQSPWRJ1AT2+atXcPgpYgGiCxonw2
 dapTI6J714PosdAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89A13139CC;
 Mon, 28 Aug 2023 10:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ou2HIcRw7GSLRgAAMHmgww
 (envelope-from <jack@suse.cz>); Mon, 28 Aug 2023 10:02:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 0BA0FA0774; Mon, 28 Aug 2023 12:02:44 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 28 Aug 2023 12:02:39 +0200
Message-Id: <20230828100239.13518-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] fanotify22: Make tests not depend on behavior of
 shutdown filesystem
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
Cc: Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The tests in fanotify22 implicitely depended on the fact that filesystem
shutdown with 'abort' mount option keeps reporting further errors and
further mounts with 'abort' option. This is however too strict (mostly a
bug in ext4 implementation) and in principle reporting errors after the
filesystem is shutdown is just a pointless noise. Ext4 recently modified
the behavior of 'abort' mount option to behave the same as filesystem
shutdown and thus also stop reporting further filesystem errors. Modify
the tests to unmount and mount the filesystem after each test to get it
out of the shutdown state for the following tests and also replace a
test testing behavior after mounting with 'abort' mount option with a
test testing two different filesystem corruption errors.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 .../kernel/syscalls/fanotify/fanotify22.c     | 33 +++++++++++++++----
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index 1105172bb269..f4b7987deda9 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
@@ -42,6 +42,7 @@
 #define MOUNT_PATH "test_mnt"
 #define BASE_DIR "internal_dir"
 #define BAD_DIR BASE_DIR"/bad_dir"
+#define BAD_LINK BASE_DIR"/bad_link"
 
 #ifdef HAVE_NAME_TO_HANDLE_AT
 
@@ -51,6 +52,7 @@ static int fd_notify;
 /* These expected FIDs are common to multiple tests */
 static struct fanotify_fid_t null_fid;
 static struct fanotify_fid_t bad_file_fid;
+static struct fanotify_fid_t bad_link_fid;
 
 static void trigger_fs_abort(void)
 {
@@ -65,7 +67,7 @@ static void do_debugfs_request(const char *dev, char *request)
 	SAFE_CMD(cmd, NULL, NULL);
 }
 
-static void tcase2_trigger_lookup(void)
+static void trigger_bad_file_lookup(void)
 {
 	int ret;
 
@@ -76,15 +78,27 @@ static void tcase2_trigger_lookup(void)
 			ret, BAD_DIR, errno, EUCLEAN);
 }
 
+static void trigger_bad_link_lookup(void)
+{
+	int ret;
+
+	/* SAFE_OPEN cannot be used here because we expect it to fail. */
+	ret = open(MOUNT_PATH"/"BAD_LINK, O_RDONLY, 0);
+	if (ret != -1 && errno != EUCLEAN)
+		tst_res(TFAIL, "Unexpected open result(%d) of %s (%d!=%d)",
+			ret, BAD_LINK, errno, EUCLEAN);
+}
+
+
 static void tcase3_trigger(void)
 {
-	trigger_fs_abort();
-	tcase2_trigger_lookup();
+	trigger_bad_link_lookup();
+	trigger_bad_file_lookup();
 }
 
 static void tcase4_trigger(void)
 {
-	tcase2_trigger_lookup();
+	trigger_bad_file_lookup();
 	trigger_fs_abort();
 }
 
@@ -104,7 +118,7 @@ static struct test_case {
 	},
 	{
 		.name = "Lookup of inode with invalid mode",
-		.trigger_error = &tcase2_trigger_lookup,
+		.trigger_error = &trigger_bad_file_lookup,
 		.error_count = 1,
 		.error = EFSCORRUPTED,
 		.fid = &bad_file_fid,
@@ -113,8 +127,8 @@ static struct test_case {
 		.name = "Multiple error submission",
 		.trigger_error = &tcase3_trigger,
 		.error_count = 2,
-		.error = ESHUTDOWN,
-		.fid = &null_fid,
+		.error = EFSCORRUPTED,
+		.fid = &bad_link_fid,
 	},
 	{
 		.name = "Multiple error submission 2",
@@ -248,6 +262,9 @@ static void do_test(unsigned int i)
 			   FAN_FS_ERROR, AT_FDCWD, MOUNT_PATH);
 
 	check_event(event_buf, read_len, tcase);
+	/* Unmount and mount the filesystem to get it out of the error state */
+	SAFE_UMOUNT(MOUNT_PATH);
+	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);
 }
 
 static void pre_corrupt_fs(void)
@@ -256,9 +273,11 @@ static void pre_corrupt_fs(void)
 	SAFE_MKDIR(MOUNT_PATH"/"BAD_DIR, 0777);
 
 	fanotify_save_fid(MOUNT_PATH"/"BAD_DIR, &bad_file_fid);
+	fanotify_save_fid(MOUNT_PATH"/"BASE_DIR, &bad_link_fid);
 
 	SAFE_UMOUNT(MOUNT_PATH);
 	do_debugfs_request(tst_device->dev, "sif " BAD_DIR " mode 0xff");
+	do_debugfs_request(tst_device->dev, "ln <1> " BAD_LINK);
 	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);
 }
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
