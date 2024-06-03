Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32884C25B75
	for <ltp@archiver.kernel.org>; Mon,  3 Jun 2024 12:35:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAA8D3D08D5
	for <ltp@archiver.kernel.org>; Mon,  3 Jun 2024 14:35:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 485753D08E1
 for <ltp@lists.linux.it>; Mon,  3 Jun 2024 14:35:07 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8B21D201729
 for <ltp@lists.linux.it>; Mon,  3 Jun 2024 14:35:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A369920039;
 Mon,  3 Jun 2024 12:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717418104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HpytHXMkhoo0trPzoihjhqHKpMAgCOXU16UkqSXUCQU=;
 b=zy29xv/vBVqZHt2DyOVObQwQtcIn/n35SeSt4I9ruRTB8B44bPz2nncIZCq0u5CBrlpF2l
 4+HTx0FGyWPQD3KERK3XIaskxd4t5GYfKSg45Vv5hVJWONt6QJc/VhLwjIpggew5RjYKKW
 VviCxUkN4PaRDrV8s6EvZwIVU2XmUXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717418104;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HpytHXMkhoo0trPzoihjhqHKpMAgCOXU16UkqSXUCQU=;
 b=DcxWwPGWviOFSV1IoEfGHoU+Ah8qcgUOWaXwkJ97d2zypRXgSPBv53YHaP1OtJJ2wlfnyL
 7s4P7moXrkXDr9Dg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="zy29xv/v";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DcxWwPGW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717418104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HpytHXMkhoo0trPzoihjhqHKpMAgCOXU16UkqSXUCQU=;
 b=zy29xv/vBVqZHt2DyOVObQwQtcIn/n35SeSt4I9ruRTB8B44bPz2nncIZCq0u5CBrlpF2l
 4+HTx0FGyWPQD3KERK3XIaskxd4t5GYfKSg45Vv5hVJWONt6QJc/VhLwjIpggew5RjYKKW
 VviCxUkN4PaRDrV8s6EvZwIVU2XmUXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717418104;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HpytHXMkhoo0trPzoihjhqHKpMAgCOXU16UkqSXUCQU=;
 b=DcxWwPGWviOFSV1IoEfGHoU+Ah8qcgUOWaXwkJ97d2zypRXgSPBv53YHaP1OtJJ2wlfnyL
 7s4P7moXrkXDr9Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 909D413AB5;
 Mon,  3 Jun 2024 12:35:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /8JsIni4XWZdPgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 03 Jun 2024 12:35:04 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  3 Jun 2024 14:34:55 +0200
Message-ID: <20240603123455.7968-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240603123455.7968-1-chrubis@suse.cz>
References: <20240603123455.7968-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A369920039
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls: quotactl: Move mkfs opts into tst_test
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/quotactl/quotactl04.c | 15 ++++++---------
 testcases/kernel/syscalls/quotactl/quotactl08.c | 15 +++++----------
 2 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index 8bc3efdd0..d1416c0a4 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -32,7 +32,7 @@
 #define FMTID QFMT_VFS_V1
 
 static int32_t fmt_id = FMTID;
-static int test_id, mount_flag;
+static int test_id;
 static struct dqblk set_dq = {
 	.dqb_bsoftlimit = 100,
 	.dqb_valid = QIF_BLIMITS
@@ -98,12 +98,8 @@ static struct tcase {
 
 static void setup(void)
 {
-	const char *const fs_opts[] = {"-I 256", "-O quota,project", NULL};
-
 	quotactl_info();
-	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
-	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
-	mount_flag = 1;
+
 	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
 
 	TEST(do_quotactl(fd, QCMD(Q_GETNEXTQUOTA, PRJQUOTA), tst_device->dev,
@@ -116,8 +112,6 @@ static void cleanup(void)
 {
 	if (fd > -1)
 		SAFE_CLOSE(fd);
-	if (mount_flag && tst_umount(MNTPOINT))
-		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
 }
 
 static void verify_quota(unsigned int n)
@@ -161,8 +155,11 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.cleanup = cleanup,
-	.needs_device = 1,
+	.mount_device = 1,
 	.fs = {
+		.mkfs_opts = (const char *const[]){
+			"-I 256", "-O quota,project", NULL
+		},
 		.type = "ext4"
 	},
 	.mntpoint = MNTPOINT,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
index 67638c226..9ae5fb9e2 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl08.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
@@ -44,7 +44,7 @@
 #define MNTPOINT	"mntpoint"
 
 static int32_t fmt_id = QFMT_VFS_V1;
-static int test_id, mount_flag;
+static int test_id;
 static struct dqblk set_dq = {
 	.dqb_bsoftlimit = 100,
 	.dqb_valid = QIF_BLIMITS
@@ -153,14 +153,8 @@ static struct tcase {
 
 static void setup(void)
 {
-	const char *const fs_opts[] = { "-O quota", NULL};
-
 	quotactl_info();
 
-	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
-	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
-	mount_flag = 1;
-
 	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
 	TEST(do_quotactl(fd, QCMD(Q_GETNEXTQUOTA, USRQUOTA), tst_device->dev,
 		0, (void *) &res_ndq));
@@ -172,8 +166,6 @@ static void cleanup(void)
 {
 	if (fd > -1)
 		SAFE_CLOSE(fd);
-	if (mount_flag && tst_umount(MNTPOINT))
-		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
 }
 
 static void verify_quota(unsigned int n)
@@ -217,9 +209,12 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.mntpoint = MNTPOINT,
 	.fs = {
+		.mkfs_opts = (const char *const[]){
+			"-O quota", NULL
+		},
 		.type = "ext4",
 	},
-	.needs_device = 1,
+	.mount_device = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
-- 
2.44.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
