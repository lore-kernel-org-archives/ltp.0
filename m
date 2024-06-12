Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1749C27C53
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 12:12:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48E503D0BEC
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 14:12:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 006683D0BD9
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 14:11:30 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7E5E6100609D
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 14:11:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A1719343F0
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 12:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718194288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lt2HLbvMfnzUJbgvylDJtcOqqi1b7jhTfLuJ5OL8O1k=;
 b=1hVPlbmTw8miiFIHZ5xD4IIxXppYlJcjEEc6QMm4lVh/nv9iGitqsCiRN56cl0uk9vsRfj
 JDC1K3eI8ix/zI/OO58Z2+i6qQrrBYuqooYl6CGORhE2JAmzO6A6L+oQykY5QueSdLNquD
 eOSFzgaKPfsnWKRf8mcVcIjNOXwpgL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718194288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lt2HLbvMfnzUJbgvylDJtcOqqi1b7jhTfLuJ5OL8O1k=;
 b=wgV2GbXgI9C+st06BMCNDAT+Pl5X6K3iO/1lN2ogr8vyObteeDBSY5KcnlADCA/bC6zZVa
 dcF6Am6IluqnqUAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718194288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lt2HLbvMfnzUJbgvylDJtcOqqi1b7jhTfLuJ5OL8O1k=;
 b=1hVPlbmTw8miiFIHZ5xD4IIxXppYlJcjEEc6QMm4lVh/nv9iGitqsCiRN56cl0uk9vsRfj
 JDC1K3eI8ix/zI/OO58Z2+i6qQrrBYuqooYl6CGORhE2JAmzO6A6L+oQykY5QueSdLNquD
 eOSFzgaKPfsnWKRf8mcVcIjNOXwpgL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718194288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lt2HLbvMfnzUJbgvylDJtcOqqi1b7jhTfLuJ5OL8O1k=;
 b=wgV2GbXgI9C+st06BMCNDAT+Pl5X6K3iO/1lN2ogr8vyObteeDBSY5KcnlADCA/bC6zZVa
 dcF6Am6IluqnqUAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90AE91372E
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 12:11:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EpxqInCQaWZIIQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 12:11:28 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 12 Jun 2024 14:11:06 +0200
Message-ID: <20240612121106.11127-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240612121106.11127-1-chrubis@suse.cz>
References: <20240612121106.11127-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] syscalls: quotactl: Move mkfs opts into
 tst_test
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
 .../kernel/syscalls/quotactl/quotactl04.c     | 19 +++++++++----------
 .../kernel/syscalls/quotactl/quotactl08.c     | 19 ++++++++-----------
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index 7fdff6502..91f15eb5d 100644
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
@@ -161,9 +155,14 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.cleanup = cleanup,
-	.needs_device = 1,
+	.mount_device = 1,
 	.filesystems = (struct tst_fs []) {
-		{.type = "ext4"},
+		{
+			.type = "ext4",
+			.mkfs_opts = (const char *const[]) {
+				"-I 256", "-O quota,project", NULL
+			},
+		},
 		{}
 	},
 	.mntpoint = MNTPOINT,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
index aafb1cd2b..85a2f4731 100644
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
@@ -217,10 +209,15 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.mntpoint = MNTPOINT,
 	.filesystems = (struct tst_fs []) {
-		{.type = "ext4"},
+		{
+			.type = "ext4",
+			.mkfs_opts = (const char *const[]){
+				"-O quota", NULL
+			},
+		},
 		{}
 	},
-	.needs_device = 1,
+	.mount_device = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
-- 
2.44.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
