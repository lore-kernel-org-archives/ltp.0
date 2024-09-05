Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A92ACD5BC7
	for <ltp@archiver.kernel.org>; Thu,  5 Sep 2024 13:45:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BE1F3C24DE
	for <ltp@archiver.kernel.org>; Thu,  5 Sep 2024 15:45:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81EEC3C23CA
 for <ltp@lists.linux.it>; Thu,  5 Sep 2024 15:45:12 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 591546233C5
 for <ltp@lists.linux.it>; Thu,  5 Sep 2024 15:45:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B41CB2126C
 for <ltp@lists.linux.it>; Thu,  5 Sep 2024 13:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725543909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yz6o7tiX04ZrwJhbw8D+7qISACBB0O+0ZyNhfDF1SAw=;
 b=AkB2m4qDyjs7vUMbp1aa2T1P6M9pKwPJV8KFRJaDA/8M6Y0AOPtPXjZdWocxqd90tbf94Z
 two6ePQ+30ZFqoE986tFZvvAPSJkvQLh3ujT5KEzkpy9Rwl3uffhECkL4uZ7l3Up3YxL6i
 +6hPyOLeXGqZVJ7b5BUcDXge0L7N/Pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725543909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yz6o7tiX04ZrwJhbw8D+7qISACBB0O+0ZyNhfDF1SAw=;
 b=j0J9rdrr+Jtgwkk8PELmo9o2DzFukbj3ej3U86U8wH3xdjV3h/7kgrds0Y2f10cZUleGaq
 4Zrq7R8o/I1TZNDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AkB2m4qD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=j0J9rdrr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725543909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yz6o7tiX04ZrwJhbw8D+7qISACBB0O+0ZyNhfDF1SAw=;
 b=AkB2m4qDyjs7vUMbp1aa2T1P6M9pKwPJV8KFRJaDA/8M6Y0AOPtPXjZdWocxqd90tbf94Z
 two6ePQ+30ZFqoE986tFZvvAPSJkvQLh3ujT5KEzkpy9Rwl3uffhECkL4uZ7l3Up3YxL6i
 +6hPyOLeXGqZVJ7b5BUcDXge0L7N/Pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725543909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yz6o7tiX04ZrwJhbw8D+7qISACBB0O+0ZyNhfDF1SAw=;
 b=j0J9rdrr+Jtgwkk8PELmo9o2DzFukbj3ej3U86U8wH3xdjV3h/7kgrds0Y2f10cZUleGaq
 4Zrq7R8o/I1TZNDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB03313419
 for <ltp@lists.linux.it>; Thu,  5 Sep 2024 13:45:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gQKCKeW12Wb2CwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 05 Sep 2024 13:45:09 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  5 Sep 2024 15:44:59 +0200
Message-ID: <20240905134502.33759-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: B41CB2126C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:dkim, suse.cz:mid, suse.cz:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] fallocate05: Check that deallocated file range is
 marked as a hole
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

The new lseek(SEEK_HOLE/SEEK_DATA) checks will be useful for diagnosing
why the final write() check fails with ENOSPC. If the hole doesn't get
created at all, the lseek() checks will fail.

 .../kernel/syscalls/fallocate/fallocate05.c   | 34 ++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c b/testcases/kernel/syscalls/fallocate/fallocate05.c
index af6bf9e8c..979c70d6e 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate05.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
@@ -55,7 +55,7 @@ static void setup(void)
 static void run(void)
 {
 	int fd;
-	long extsize, tmp;
+	long extsize, holesize, tmp;
 
 	fd = SAFE_OPEN(MNTPOINT "/test_file", O_WRONLY | O_CREAT | O_TRUNC,
 		0644);
@@ -115,11 +115,12 @@ static void run(void)
 
 	/* Btrfs deallocates only complete extents, not individual blocks */
 	if (!strcmp(tst_device->fs_type, "btrfs"))
-		tmp = bufsize + extsize;
+		holesize = bufsize + extsize;
 	else
-		tmp = DEALLOCATE_BLOCKS * blocksize;
+		holesize = DEALLOCATE_BLOCKS * blocksize;
 
-	TEST(fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, tmp));
+	TEST(fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
+		holesize));
 
 	if (TST_RET == -1) {
 		if (TST_ERR == ENOTSUP)
@@ -135,6 +136,31 @@ static void run(void)
 	else
 		tst_res(TPASS, "write()");
 
+	/* Check that the deallocated file range is marked as a hole */
+	TEST(lseek(fd, 0, SEEK_HOLE));
+
+	if (TST_RET == 0) {
+		tst_res(TPASS, "Test file contains hole at offset 0");
+	} else if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "lseek(SEEK_HOLE) failed");
+	} else {
+		tst_res(TFAIL | TTERRNO,
+			"Unexpected lseek(SEEK_HOLE) return value %ld",
+			TST_RET);
+	}
+
+	TEST(lseek(fd, 0, SEEK_DATA));
+
+	if (TST_RET == holesize) {
+		tst_res(TPASS, "Test file data start at offset %ld", TST_RET);
+	} else if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "lseek(SEEK_DATA) failed");
+	} else {
+		tst_res(TFAIL | TTERRNO,
+			"Unexpected lseek(SEEK_DATA) return value %ld",
+			TST_RET);
+	}
+
 	SAFE_CLOSE(fd);
 	tst_purge_dir(MNTPOINT);
 }
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
