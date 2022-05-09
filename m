Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75F6C433F5
	for <ltp@archiver.kernel.org>; Mon,  9 May 2022 11:38:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D7543CA942
	for <ltp@archiver.kernel.org>; Mon,  9 May 2022 13:38:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54A673CA334
 for <ltp@lists.linux.it>; Mon,  9 May 2022 13:38:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 48CB2600697
 for <ltp@lists.linux.it>; Mon,  9 May 2022 13:38:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 59C581F9CB;
 Mon,  9 May 2022 11:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652096285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DNm1fPSxTIYRA+7WPqe01m8Ff6/6x3VPhqZs4t+hg8s=;
 b=eOtHaxkFmg9cvn8BXTK7WMCdLz4Qt27y1YowsIf6kmsPhxNCD/AFKYDSIvk1kiNKLJNLRF
 7dnwZ1OwwV3DwcN6KbF8e5TYIVY/k3HBe9cunwkPyRNZkP73WT37/C3g1lfop1Uaf6sI9R
 jiUCrI0Mfh69zbLl0C9Hm9ymUJHWXRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652096285;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DNm1fPSxTIYRA+7WPqe01m8Ff6/6x3VPhqZs4t+hg8s=;
 b=7F3aje30KpIAbzujBl477ozz5idUBXwL91Tfc/9Owr4X686FE6xvRgnU4K1Y4xDcov62cp
 E2wh2NcvyV2OrPDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2741C13AA5;
 Mon,  9 May 2022 11:38:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yM/lBx39eGLGKQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 09 May 2022 11:38:05 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  9 May 2022 13:38:01 +0200
Message-Id: <20220509113801.10697-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED][PATCH 1/1] fs_bind_move01.sh: Fix function name
 (typo)
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fixes: d8ef18e24 ("fs_bind: Convert to ltp tests")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/fs/fs_bind/move/fs_bind_move01.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move01.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move01.sh
index ab897fd16..0e3e6080f 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move01.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move01.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-
 test()
 {
 	tst_res TINFO "move: shared child to shared parent"
@@ -23,12 +22,12 @@ test()
 	EXPECT_PASS mount --move dir parent2/child2
 
 	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent2/child2/grandchild
-	fs_bind_fs_bind_check parent2/child2/grandchild share1/grandchild share2/child2/grandchild
-	fs_bind_fs_bind_check -n dir/grandchild parent2/child2/grandchild
+	fs_bind_check parent2/child2/grandchild share1/grandchild share2/child2/grandchild
+	fs_bind_check -n dir/grandchild parent2/child2/grandchild
 
 	EXPECT_PASS mount --bind "$FS_BIND_DISK2" share1/grandchild/a
 
-	fs_bind_fs_bind_check parent2/child2/grandchild/a share1/grandchild/a share2/child2/grandchild/a
+	fs_bind_check parent2/child2/grandchild/a share1/grandchild/a share2/child2/grandchild/a
 
 	EXPECT_PASS umount share1/grandchild/a
 	EXPECT_PASS umount share1/grandchild/
-- 
2.36.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
