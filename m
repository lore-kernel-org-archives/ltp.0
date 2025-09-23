Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38F0CAC5AC
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 15:33:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C98C3CDEAB
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 17:33:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BD633CDD49
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 17:32:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EE3721000924
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 17:32:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 95ECF1F803;
 Tue, 23 Sep 2025 15:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758641566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7lFsmlQf8AKvpCYQRMGfSGTmoEN8GpjLZxdlNLqA/YQ=;
 b=xmXab6jaAdBh9DOkOJZqbm0doFq0v0FCgynnNZ0FH1/wDy+kM3Oet+jAFpcqdJ9rDpCX+w
 9mvm3EbtHRl7WzYUOYbHRblzxSxXrS58X5/8Gn3A0+HGeidvobfOn0IrKtIFOxs2b/PKLz
 Q45xfiDr0+kcEQwd6dxI8R9telDOgxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758641566;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7lFsmlQf8AKvpCYQRMGfSGTmoEN8GpjLZxdlNLqA/YQ=;
 b=bhHEQxA5axVYRzUzy5Ka6/WZEbWHyPPxf6ZE3zShZPl5YFQyFeUi3uE4977/eQXbGumZX6
 z4YgIB1CD5SpToBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xmXab6ja;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bhHEQxA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758641566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7lFsmlQf8AKvpCYQRMGfSGTmoEN8GpjLZxdlNLqA/YQ=;
 b=xmXab6jaAdBh9DOkOJZqbm0doFq0v0FCgynnNZ0FH1/wDy+kM3Oet+jAFpcqdJ9rDpCX+w
 9mvm3EbtHRl7WzYUOYbHRblzxSxXrS58X5/8Gn3A0+HGeidvobfOn0IrKtIFOxs2b/PKLz
 Q45xfiDr0+kcEQwd6dxI8R9telDOgxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758641566;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7lFsmlQf8AKvpCYQRMGfSGTmoEN8GpjLZxdlNLqA/YQ=;
 b=bhHEQxA5axVYRzUzy5Ka6/WZEbWHyPPxf6ZE3zShZPl5YFQyFeUi3uE4977/eQXbGumZX6
 z4YgIB1CD5SpToBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E2AB1388C;
 Tue, 23 Sep 2025 15:32:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2EyHIp690minWwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Tue, 23 Sep 2025 15:32:46 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: andrea.cervesato@suse.de,
	ltp@lists.linux.it
Date: Tue, 23 Sep 2025 17:32:24 +0200
Message-ID: <20250923153234.73227-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 95ECF1F803
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] file_attr02: Enable reflinks and fix blocksize
 detection
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

Copy on write XFS features require reflink support. Enable it in mkfs
options for older systems which don't enable it by default and mount
the filesystem explicitly with checks for feature support.

Also use the correct (filesystem) blocksize instead of block device
blocksize.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../kernel/syscalls/file_attr/file_attr02.c   | 30 ++++++++++++++-----
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/file_attr/file_attr02.c b/testcases/kernel/syscalls/file_attr/file_attr02.c
index 4e0d87f0f..d565a2687 100644
--- a/testcases/kernel/syscalls/file_attr/file_attr02.c
+++ b/testcases/kernel/syscalls/file_attr/file_attr02.c
@@ -41,9 +41,18 @@ static void run(void)
 
 static void setup(void)
 {
-	int block_size;
+	struct stat statbuf;
 
-	block_size = tst_dev_block_size(MNTPOINT);
+	SAFE_MKDIR(MNTPOINT, 0755);
+	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL));
+
+	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
+		tst_brk(TCONF, "Kernel does not support XFS reflinks");
+
+	if (TST_RET)
+		tst_brk(TBROK | TTERRNO, "Mount failed");
+
+	SAFE_STAT(MNTPOINT, &statbuf);
 
 	dfd = SAFE_OPEN(MNTPOINT, O_RDONLY);
 	fd = SAFE_CREAT(MNTPOINT "/" FILENAME, 0777);
@@ -52,8 +61,8 @@ static void setup(void)
 
 	xattr.fsx_xflags |= FS_XFLAG_EXTSIZE;
 	xattr.fsx_xflags |= FS_XFLAG_COWEXTSIZE;
-	xattr.fsx_extsize = BLOCKS * block_size;
-	xattr.fsx_cowextsize = BLOCKS * block_size;
+	xattr.fsx_extsize = BLOCKS * statbuf.st_blksize;
+	xattr.fsx_cowextsize = BLOCKS * statbuf.st_blksize;
 	xattr.fsx_projid = PROJID;
 
 	SAFE_IOCTL(fd, FS_IOC_FSSETXATTR, &xattr);
@@ -72,17 +81,24 @@ static void cleanup(void)
 
 	if (dfd != -1)
 		SAFE_CLOSE(dfd);
+
+	if (tst_is_mounted(MNTPOINT))
+		SAFE_UMOUNT(MNTPOINT);
 }
 
 static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.mntpoint = MNTPOINT,
 	.needs_root = 1,
-	.mount_device = 1,
+	.format_device = 1,
 	.filesystems = (struct tst_fs []) {
-		{.type = "xfs"},
+		{
+			.type = "xfs",
+			.mkfs_opts = (const char *const[]){
+				"-m", "reflink=1", NULL
+			},
+		},
 		{}
 	},
 	.bufs = (struct tst_buffers []) {
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
