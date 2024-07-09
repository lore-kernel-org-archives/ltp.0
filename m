Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EF2C2BD09
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 10:34:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DC713D3936
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 12:34:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3108F3D0CD5
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 12:33:56 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A233C1400058
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 12:33:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BC3C31F7AF;
 Tue,  9 Jul 2024 10:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720521234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=49XnoDQ00DYL3IkmCeqFTru81KQhJkbsAEwwG8v+j6Q=;
 b=JlA1Aab3vkqGm61E0Q2ybJubsdLTATEI4NP0HxMqKSJ8p2ds2Re8SHCQOzMCPlCD1cBK+A
 WOZE4zj/PajCcpCVmia+X1ysxRLt/ymTZLYDxCJ5rwwx29OdCuUyMhCZ7qt0JWPFFRcgMl
 3cqQyzNv/TxHPPZTTvfRsLyd13fVMlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720521234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=49XnoDQ00DYL3IkmCeqFTru81KQhJkbsAEwwG8v+j6Q=;
 b=u6sYzR3GYkOznjTXWyfaWXB6KI4UcrGGM0+sJ9kn5xRjVrVpkJjQVQswG6exFJsmKh1Stt
 qdKk8X6pOBG13HDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720521234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=49XnoDQ00DYL3IkmCeqFTru81KQhJkbsAEwwG8v+j6Q=;
 b=JlA1Aab3vkqGm61E0Q2ybJubsdLTATEI4NP0HxMqKSJ8p2ds2Re8SHCQOzMCPlCD1cBK+A
 WOZE4zj/PajCcpCVmia+X1ysxRLt/ymTZLYDxCJ5rwwx29OdCuUyMhCZ7qt0JWPFFRcgMl
 3cqQyzNv/TxHPPZTTvfRsLyd13fVMlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720521234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=49XnoDQ00DYL3IkmCeqFTru81KQhJkbsAEwwG8v+j6Q=;
 b=u6sYzR3GYkOznjTXWyfaWXB6KI4UcrGGM0+sJ9kn5xRjVrVpkJjQVQswG6exFJsmKh1Stt
 qdKk8X6pOBG13HDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CE371369A;
 Tue,  9 Jul 2024 10:33:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UvxcNxESjWZmUAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 09 Jul 2024 10:33:53 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  9 Jul 2024 12:33:24 +0200
Message-ID: <20240709103324.183993-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[9];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_test: Fix tests using device without
 .filesystems
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

cce618891 introduced a regression for tests which use the test loop
device (e.g. .mount_device = 1 or .format_device = 1) without
.filesystems array (execveat03, ioctl04, inotify0[378], fanotify10,
mount02, umount0[1-3], umount2_02).

Call in that case prepare_device() with the default filesystem type.

Fixes: cce618891 ("lib: tst_test: Add per filesystem mkfs and mount opts")
Reported-by: Petr Cervinka <pcervinka@suse.com>
Suggested-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

is there a more elegant way to fix this?

Kind regards,
Petr

 lib/tst_test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index b49c248ae..6d258cd28 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1355,8 +1355,11 @@ static void do_setup(int argc, char *argv[])
 
 		tdev.fs_type = default_fs_type();
 
-		if (!tst_test->all_filesystems && count_fs_descs() == 1)
-			prepare_device(&tst_test->filesystems[0]);
+		if (!tst_test->all_filesystems && count_fs_descs() <= 1) {
+			prepare_device(tst_test->filesystems ?
+				       &tst_test->filesystems[0] :
+				       &(struct tst_fs){.type = tdev.fs_type});
+		}
 	}
 
 	if (tst_test->needs_overlay && !tst_test->mount_device)
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
