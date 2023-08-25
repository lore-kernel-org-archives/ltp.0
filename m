Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8E4C3DA6F
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 12:28:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34F063CC3F8
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 14:28:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A56A3CC347
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 14:28:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 30CB41000668
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 14:28:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B144322482;
 Fri, 25 Aug 2023 12:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1692966483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MBETTRdM2PSUdzslqTeyZvX6o8ebzRKN3wgiPGoM1ao=;
 b=cdvVrxVB7Rk5GlVjoS6tuTGBpfddSDOjI566bp9uJMssemjDb7cZwOj9bfOxucHS3D18nL
 eHxPL/4Bo0WxSpiegq1VrePn7ZifodgyS9fRWX7kM6m7824w8Qclr15SrxD0KebN0nEEiS
 Gc2bGaRX3c8H96a9NbdTRhS23SbcdpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1692966483;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MBETTRdM2PSUdzslqTeyZvX6o8ebzRKN3wgiPGoM1ao=;
 b=XT+EfJ5PpIhJHRRdQxkAaRRU2Tb1qeyYhEu8UOBOn8ygMTqs+zXV8978UtmbgBNMHNKymF
 bNvJ7Wq1Y85FeSAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A49981340A;
 Fri, 25 Aug 2023 12:28:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5UkiKFOe6GTGWQAAMHmgww
 (envelope-from <jack@suse.cz>); Fri, 25 Aug 2023 12:28:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 343FFA0774; Fri, 25 Aug 2023 14:28:03 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 25 Aug 2023 14:27:53 +0200
Message-Id: <20230825122753.4721-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify22: Make tests not depend on behavior of
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

Signed-off-by: Jan Kara <jack@suse.cz>
---
 .../kernel/syscalls/fanotify/fanotify22.c     | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index 1105172bb269..475155b9f58a 100644
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
@@ -78,7 +80,13 @@ static void tcase2_trigger_lookup(void)
 
 static void tcase3_trigger(void)
 {
-	trigger_fs_abort();
+	int ret;
+
+	/* SAFE_OPEN cannot be used here because we expect it to fail. */
+	ret = open(MOUNT_PATH"/"BAD_LINK, O_RDONLY, 0);
+	if (ret != -1 && errno != EUCLEAN)
+		tst_res(TFAIL, "Unexpected open result(%d) of %s (%d!=%d)",
+			ret, BAD_LINK, errno, EUCLEAN);
 	tcase2_trigger_lookup();
 }
 
@@ -113,8 +121,8 @@ static struct test_case {
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
@@ -248,6 +256,9 @@ static void do_test(unsigned int i)
 			   FAN_FS_ERROR, AT_FDCWD, MOUNT_PATH);
 
 	check_event(event_buf, read_len, tcase);
+	/* Unmount and mount the filesystem to get it out of the error state */
+	SAFE_UMOUNT(MOUNT_PATH);
+	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);
 }
 
 static void pre_corrupt_fs(void)
@@ -256,9 +267,11 @@ static void pre_corrupt_fs(void)
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
