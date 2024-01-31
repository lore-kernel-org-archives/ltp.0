Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBCCC47258
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 18:07:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BB6E3CF939
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 19:07:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6C013CE0D0
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 19:07:04 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2B31F600BD8
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 19:07:03 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 78AD11FB95;
 Wed, 31 Jan 2024 18:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706724423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GC39efYkcgqRzZB1rJUgIraVT/BF6xA9sB/B2aRdhBo=;
 b=1vkR+iTZUuVqD6LDHkfWMnl4Ta74AAmclYH8W5UqWqoTNl5bEe9UlrM57rYWFjf3xcxk0+
 m3CPUdD/gQIl1t2Wum8lrjeAy4z13f0XCzLx84vzCFJIngLW/CZh87r+RDICTtKuqVpZDh
 14y2PA8EJ8h96FJgGdTzXtSVb6xmUb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706724423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GC39efYkcgqRzZB1rJUgIraVT/BF6xA9sB/B2aRdhBo=;
 b=iLqcxE0GpSdmSp6SMqqckDS61NJi59l37Mf2ncriUcNIQQ9QZGWuac+hrSqMkLTTPL+yVe
 hZ8ZMOrJKRwnv4Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706724423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GC39efYkcgqRzZB1rJUgIraVT/BF6xA9sB/B2aRdhBo=;
 b=1vkR+iTZUuVqD6LDHkfWMnl4Ta74AAmclYH8W5UqWqoTNl5bEe9UlrM57rYWFjf3xcxk0+
 m3CPUdD/gQIl1t2Wum8lrjeAy4z13f0XCzLx84vzCFJIngLW/CZh87r+RDICTtKuqVpZDh
 14y2PA8EJ8h96FJgGdTzXtSVb6xmUb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706724423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GC39efYkcgqRzZB1rJUgIraVT/BF6xA9sB/B2aRdhBo=;
 b=iLqcxE0GpSdmSp6SMqqckDS61NJi59l37Mf2ncriUcNIQQ9QZGWuac+hrSqMkLTTPL+yVe
 hZ8ZMOrJKRwnv4Cg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D20D139FB;
 Wed, 31 Jan 2024 18:07:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 8MnUEUeMumUoIgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 31 Jan 2024 18:07:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 31 Jan 2024 19:06:58 +0100
Message-ID: <20240131180659.23587-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131180659.23587-1-pvorel@suse.cz>
References: <20240131180659.23587-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1vkR+iTZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iLqcxE0G
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 78AD11FB95
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] tree: Use MNTPOINT macro instead of string
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/creat/creat06.c     |  4 +--
 testcases/kernel/syscalls/fsync/fsync01.c     |  4 +--
 testcases/kernel/syscalls/inotify/inotify03.c | 25 ++++++++-----------
 testcases/kernel/syscalls/ioctl/ioctl04.c     | 10 ++++----
 4 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat06.c b/testcases/kernel/syscalls/creat/creat06.c
index 5c82e4757..eccd5e2dd 100644
--- a/testcases/kernel/syscalls/creat/creat06.c
+++ b/testcases/kernel/syscalls/creat/creat06.c
@@ -52,7 +52,7 @@
 #define	NOT_DIR		"file1/testdir"
 #define	TEST6_FILE	"dir6/file6"
 #define	TEST7_FILE	"file7"
-#define	TEST8_FILE	"mntpoint/tmp"
+#define	TEST8_FILE	MNTPOINT"/tmp"
 
 #define	MODE1		0444
 #define	MODE2		0666
@@ -153,6 +153,6 @@ static struct tst_test test = {
 	.test = verify_creat,
 	.needs_root = 1,
 	.needs_rofs = 1,
-	.mntpoint = "mntpoint",
+	.mntpoint = MNTPOINT,
 	.setup = setup,
 };
diff --git a/testcases/kernel/syscalls/fsync/fsync01.c b/testcases/kernel/syscalls/fsync/fsync01.c
index 072245fc8..cecfd6592 100644
--- a/testcases/kernel/syscalls/fsync/fsync01.c
+++ b/testcases/kernel/syscalls/fsync/fsync01.c
@@ -33,7 +33,7 @@ static void verify_fsync(void)
 
 static void setup(void)
 {
-	sprintf(fname, "mntpoint/tfile_%d", getpid());
+	sprintf(fname, "%s/tfile_%d", MNTPOINT, getpid());
 	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
 }
 
@@ -49,6 +49,6 @@ static struct tst_test test = {
 	.test_all = verify_fsync,
 	.needs_root = 1,
 	.mount_device = 1,
-	.mntpoint = "mntpoint",
+	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
 };
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index ff025b360..5440d573c 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -34,17 +34,13 @@
 #define EVENT_BUF_LEN		(EVENT_MAX * (EVENT_SIZE + 16))
 
 #define BUF_SIZE 1024
+#define DIR_MODE	(S_IRWXU | S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP)
+
 static char fname[BUF_SIZE];
 static int fd, fd_notify;
 static int wd;
-
 static unsigned int event_set[EVENT_MAX];
-
 static char event_buf[EVENT_BUF_LEN];
-
-#define DIR_MODE	(S_IRWXU | S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP)
-
-static char *mntpoint = "mntpoint";
 static int mount_flag;
 
 void verify_inotify(void)
@@ -54,7 +50,7 @@ void verify_inotify(void)
 
 	int test_cnt = 0;
 
-	SAFE_MOUNT(tst_device->dev, mntpoint, tst_device->fs_type, 0, NULL);
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
 	mount_flag = 1;
 
 	wd = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, fname, IN_ALL_EVENTS);
@@ -68,7 +64,7 @@ void verify_inotify(void)
 	test_cnt++;
 
 	tst_res(TINFO, "umount %s", tst_device->dev);
-	TEST(tst_umount(mntpoint));
+	TEST(tst_umount(MNTPOINT));
 	if (TST_RET != 0) {
 		tst_brk(TBROK, "umount(2) Failed "
 			"while unmounting errno = %d : %s",
@@ -129,12 +125,12 @@ static void setup(void)
 {
 	int ret;
 
-	SAFE_MKDIR(mntpoint, DIR_MODE);
+	SAFE_MKDIR(MNTPOINT, DIR_MODE);
 
-	SAFE_MOUNT(tst_device->dev, mntpoint, tst_device->fs_type, 0, NULL);
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
 	mount_flag = 1;
 
-	sprintf(fname, "%s/tfile_%d", mntpoint, getpid());
+	sprintf(fname, "%s/tfile_%d", MNTPOINT, getpid());
 	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
 
 	ret = write(fd, fname, 1);
@@ -148,7 +144,7 @@ static void setup(void)
 
 	fd_notify = SAFE_MYINOTIFY_INIT();
 
-	tst_umount(mntpoint);
+	tst_umount(MNTPOINT);
 	mount_flag = 0;
 }
 
@@ -158,10 +154,9 @@ static void cleanup(void)
 		SAFE_CLOSE(fd_notify);
 
 	if (mount_flag) {
-		TEST(tst_umount(mntpoint));
+		TEST(tst_umount(MNTPOINT));
 		if (TST_RET != 0)
-			tst_res(TWARN | TTERRNO, "umount(%s) failed",
-				mntpoint);
+			tst_res(TWARN | TTERRNO, "umount(%s) failed", MNTPOINT);
 	}
 }
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl04.c b/testcases/kernel/syscalls/ioctl/ioctl04.c
index 262c06e97..0eb433268 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl04.c
@@ -41,11 +41,11 @@ static void verify_ioctl(void)
 	else
 		tst_res(TPASS, "BLKROGET returned %i", ro);
 
-	TEST(mount(tst_device->dev, "mntpoint", tst_device->fs_type, 0, NULL));
+	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL));
 
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "Mounting RO device RW succeeded");
-		tst_umount("mntpoint");
+		tst_umount(MNTPOINT);
 		goto next;
 	}
 
@@ -58,11 +58,11 @@ static void verify_ioctl(void)
 		"Mounting RO device RW failed unexpectedly expected EACCES");
 
 next:
-	TEST(mount(tst_device->dev, "mntpoint", tst_device->fs_type, MS_RDONLY, NULL));
+	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type, MS_RDONLY, NULL));
 
 	if (TST_RET == 0) {
 		tst_res(TPASS, "Mounting RO device RO works");
-		tst_umount("mntpoint");
+		tst_umount(MNTPOINT);
 	} else {
 		tst_res(TFAIL | TTERRNO, "Mounting RO device RO failed");
 	}
@@ -73,7 +73,7 @@ next:
 
 static void setup(void)
 {
-	SAFE_MKDIR("mntpoint", 0777);
+	SAFE_MKDIR(MNTPOINT, 0777);
 	fd = SAFE_OPEN(tst_device->dev, O_RDONLY);
 }
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
