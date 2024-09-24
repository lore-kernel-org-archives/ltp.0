Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E985CF9C6B
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 12:54:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 442463C4C92
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 14:54:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CC053C4BD9
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 14:54:06 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 432C51A00CAE
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 14:54:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5E22C1FBDE;
 Tue, 24 Sep 2024 12:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727182444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qrR0KVvuGXg6VRW9YZuZuEl4g0tOP9Q9mpbZjni2pKs=;
 b=osnVVHShnVUnN97WXzXENbs8v/qIYh6AE+uRVoFwuxeAD5MX1D7JE2ICKp3obL2/Pp/ATI
 0bulBsGd9+MlUmrhYfLvbz4BnFwl3GtR+sUTuJx4nhPHBkqec67Aqx++9qRLGfYXzQlqSy
 MuwFciDLbttkDuVkeKTIHrPtjzBVXXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727182444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qrR0KVvuGXg6VRW9YZuZuEl4g0tOP9Q9mpbZjni2pKs=;
 b=qedbuydjdRM0/w4Jfsw2YaoDaOnN/0wTWjBCYP94LN/ZKiRD63oFjaIZHx9H6Q4GJChkIA
 ldPVpvE7IyQtSYDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=osnVVHSh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qedbuydj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727182444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qrR0KVvuGXg6VRW9YZuZuEl4g0tOP9Q9mpbZjni2pKs=;
 b=osnVVHShnVUnN97WXzXENbs8v/qIYh6AE+uRVoFwuxeAD5MX1D7JE2ICKp3obL2/Pp/ATI
 0bulBsGd9+MlUmrhYfLvbz4BnFwl3GtR+sUTuJx4nhPHBkqec67Aqx++9qRLGfYXzQlqSy
 MuwFciDLbttkDuVkeKTIHrPtjzBVXXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727182444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qrR0KVvuGXg6VRW9YZuZuEl4g0tOP9Q9mpbZjni2pKs=;
 b=qedbuydjdRM0/w4Jfsw2YaoDaOnN/0wTWjBCYP94LN/ZKiRD63oFjaIZHx9H6Q4GJChkIA
 ldPVpvE7IyQtSYDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 431B51386E;
 Tue, 24 Sep 2024 12:54:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 67mqDmy28mZqSwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 24 Sep 2024 12:54:04 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 24 Sep 2024 14:53:50 +0200
MIME-Version: 1.0
Message-Id: <20240924-ioctl_ficlone01_fix-v1-1-7741e2e13cc2@suse.com>
X-B4-Tracking: v=1; b=H4sIAF228mYC/x2MUQqAIBAFrxL7naCmZF0lIsLWWggNjQiiu7f0N
 zPw3gMFM2GBvnog40WFUmRRdQV+m+OKghZ20FIb2WkjKPlznwL5PUWUiukWzs2qxWCdNQ3w8sj
 I+X8dxvf9AEbq9jZlAAAA
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727182444; l=4413;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=tPSujKVegeyjiIeyWz+KoxCntulSTdn7KmWm2VpzFwE=;
 b=DOBdYDjQzJfgnPHkddZhbx4cZwPN5xSB64eDfdRHz5nosG2iN5lGIq3kI+6FBnRAKTeb3pAEe
 iYGcf6UlIPcAhg9ERGM6IrvsawGLS9VkeqWhMvneDupyo/JgcTujtM3
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 5E22C1FBDE
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Fix ioctl_ficlone on XFS without reflink support
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

reflink has been introduced in XFS by kernel 4.9 and mkfs.xfs enabled
by default in 5.1.0. Check the mkfs.xfs version in order to make sure
that mkfs.xfs supports reflink and verify kernel is at least 4.9 when
we run the ioctl_ficlone tests on XFS.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
ioctl_ficlone tests are failing in certain circumstances. In particular,
when kernel version is lower than 4.9 and mkfs.xfs is not 5.1.0
---
 testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c      | 9 ++++++++-
 testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c      | 5 ++++-
 testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c | 5 ++++-
 testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c | 5 ++++-
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
index f5407f789..d0faf3327 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
@@ -95,6 +95,12 @@ static void run(void)
 	SAFE_UNLINK(DSTPATH);
 }
 
+static void setup(void)
+{
+	if (!strcmp(tst_device->fs_type, "xfs") && tst_kvercmp(4, 9, 0) < 0)
+		tst_brk(TCONF, "XFS doesn't support reflink");
+}
+
 static void cleanup(void)
 {
 	if (src_fd != -1)
@@ -106,6 +112,7 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.test_all = run,
+	.setup = setup,
 	.cleanup = cleanup,
 	.min_kver = "4.5",
 	.needs_root = 1,
@@ -115,7 +122,7 @@ static struct tst_test test = {
 		{.type = "bcachefs"},
 		{.type = "btrfs"},
 		{
-			.type = "xfs",
+			.type = "xfs >= 5.1.0",
 			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
 		},
 		{}
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
index 3cc386c59..8e32ba039 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
@@ -62,6 +62,9 @@ static void setup(void)
 	int attr;
 	struct stat sb;
 
+	if (!strcmp(tst_device->fs_type, "xfs") && tst_kvercmp(4, 9, 0) < 0)
+		tst_brk(TCONF, "XFS doesn't support reflink");
+
 	rw_file = SAFE_OPEN("ok_only", O_CREAT | O_RDWR, 0640);
 	ro_file = SAFE_OPEN("rd_only", O_CREAT | O_RDONLY, 0640);
 	wo_file = SAFE_OPEN("rw_only", O_CREAT | O_WRONLY, 0640);
@@ -113,7 +116,7 @@ static struct tst_test test = {
 		{.type = "bcachefs"},
 		{.type = "btrfs"},
 		{
-			.type = "xfs",
+			.type = "xfs >= 5.1.0",
 			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
 		},
 		{}
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
index e352c513b..4128285b1 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
@@ -108,6 +108,9 @@ static void setup(void)
 {
 	struct stat sb;
 
+	if (!strcmp(tst_device->fs_type, "xfs") && tst_kvercmp(4, 9, 0) < 0)
+		tst_brk(TCONF, "XFS doesn't support reflink");
+
 	SAFE_STAT(MNTPOINT, &sb);
 
 	filesize = sb.st_blksize * CHUNKS;
@@ -148,7 +151,7 @@ static struct tst_test test = {
 		{.type = "bcachefs"},
 		{.type = "btrfs"},
 		{
-			.type = "xfs",
+			.type = "xfs >= 5.1.0",
 			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
 		},
 		{}
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c
index ad36df162..d1f8d60c0 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c
@@ -60,6 +60,9 @@ static void setup(void)
 {
 	struct stat sb;
 
+	if (!strcmp(tst_device->fs_type, "xfs") && tst_kvercmp(4, 9, 0) < 0)
+		tst_brk(TCONF, "XFS doesn't support reflink");
+
 	SAFE_STAT(MNTPOINT, &sb);
 
 	alignment = sb.st_blksize;
@@ -85,7 +88,7 @@ static struct tst_test test = {
 		{.type = "bcachefs"},
 		{.type = "btrfs"},
 		{
-			.type = "xfs",
+			.type = "xfs >= 5.1.0",
 			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
 		},
 		{}

---
base-commit: 968e6245d93bc91723e72086a71e6bc50f495d0b
change-id: 20240924-ioctl_ficlone01_fix-88a17ef58543

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
