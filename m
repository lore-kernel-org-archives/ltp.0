Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B623C433EF
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 15:00:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88BF83C7099
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 16:00:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46F043C133E
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 16:00:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8ACF6600676
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 16:00:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 46D16218A4
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 15:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638975635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ed8UQAixwypYGExVs/vhldWqPYoRgWXuBk+xssuixek=;
 b=ru53k0skoG9/Umlptw078YuBV5PAO+ZhoDhZ5dy+FtQfhHhrBBPj9dWaGWrLYPWokJ9q9e
 jClKP3a0anNvmbH5YAV/7c8n6VP4DGQJsA9eJmmDg5lF4vHmCWVux6Gch7N+5e22B8X6RV
 ybP2UWi/0bEBbxyHA0bkY93m3t2w8wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638975635;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ed8UQAixwypYGExVs/vhldWqPYoRgWXuBk+xssuixek=;
 b=r17CV+SjVlA8WwOKn4ZFPeSZyQN/J5rm/iDfW0H6guXW9mFOwBMp+czCJC3Hjy5Uph5lM+
 5pIDJBCOiv/3pWBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3293C13B71
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 15:00:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /d8dC5PIsGFfRAAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 08 Dec 2021 15:00:35 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  8 Dec 2021 16:00:34 +0100
Message-Id: <20211208150034.16358-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] nfs05: Reduce the default number of dirs and files
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

The nfs05 test currently creates 1000 .c files per thread and then compiles
them using recursive Makefiles. It needs 6 minutes to finish on my machine
which is longer than the default test timeout. Running it on a local filesystem
(without NFS) still takes 2 minutes to finish so NFS performance is reasonable.
Reduce the default number of test files to 10x30 per thread to avoid timeouts.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs05.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs05.sh b/testcases/network/nfs/nfs_stress/nfs05.sh
index 2742a54e6..7ddf8239e 100755
--- a/testcases/network/nfs/nfs_stress/nfs05.sh
+++ b/testcases/network/nfs/nfs_stress/nfs05.sh
@@ -8,8 +8,8 @@
 #
 # Created by: Robbie Williamson (robbiew@us.ibm.com)
 
-DIR_NUM=${DIR_NUM:-"20"}
-FILE_NUM=${FILE_NUM:-"50"}
+DIR_NUM=${DIR_NUM:-"10"}
+FILE_NUM=${FILE_NUM:-"30"}
 THREAD_NUM=${THREAD_NUM:-"8"}
 TST_NEEDS_CMDS="make gcc"
 TST_TESTFUNC="do_test"
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
