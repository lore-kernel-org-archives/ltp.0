Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469E7C433F5
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 18:46:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AB053CA09D
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 19:46:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE2BB3C964D
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 19:46:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4044E601411
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 19:45:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2EE2F219A2;
 Thu, 17 Feb 2022 18:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645123559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7flziYX4+JlxywzYLXSruSd65Mj1TM/ZHDtQBFNUWC8=;
 b=qachG4SB46sDroD0/cTHtYGK5lpHt2SM0hRoFXHwtKrHZGyHLxI7de1gehoLSmWPoCt2Tr
 cU6MW8YU+jxGL42HNRETKWN2wJVytB2vCUG0fX081qByqkzT9BD+68zdtAW8TFpCvH1IAQ
 jSyneIm56cU/lr1kc3mbsq75MAvfsa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645123559;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7flziYX4+JlxywzYLXSruSd65Mj1TM/ZHDtQBFNUWC8=;
 b=0BliVvGhTV1rOirEPfzHRdm3ayLcLxRhfH3dcJ9wLeDPY7wos3usAIgpNgryg6lFzc3OXM
 I1hm9u1HDV3BmnDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB77713C2E;
 Thu, 17 Feb 2022 18:45:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2gRkMuaXDmJzPAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 17 Feb 2022 18:45:58 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 17 Feb 2022 19:45:54 +0100
Message-Id: <20220217184554.26915-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] regen.sh: tst_syscall(): Print again syscall
 number as string
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

Before 4913b0b298 tst_syscall() printed:
TCONF: syscall(434) __NR_pidfd_open not supported

After 4913b0b298 tst_syscall() printed only numbers:
TCONF: syscall(434) 434 not supported on your arch

Constant was passed to TST_SYSCALL_BRK__() as a number thus
stringification didn't work as expected.

Fixes: 4913b0b298 ("lapi,kernel: Replace ltp_syscall with tst_syscall")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/syscalls/regen.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/lapi/syscalls/regen.sh b/include/lapi/syscalls/regen.sh
index 0b412ef6d9..3bf38fd034 100755
--- a/include/lapi/syscalls/regen.sh
+++ b/include/lapi/syscalls/regen.sh
@@ -36,14 +36,14 @@ cat << EOF > "${output_pid}"
 #include "cleanup.c"
 
 #ifdef TST_TEST_H__
-#define TST_SYSCALL_BRK__(NR) ({ \\
+#define TST_SYSCALL_BRK__(NR, SNR) ({ \\
 	tst_brk(TCONF, \\
-		"syscall(%d) " #NR " not supported on your arch", NR); \\
+		"syscall(%d) " SNR " not supported on your arch", NR); \\
 })
 #else
-#define TST_SYSCALL_BRK__(NR) ({ \\
+#define TST_SYSCALL_BRK__(NR, SNR) ({ \\
 	tst_brkm(TCONF, CLEANUP, \\
-		"syscall(%d) " #NR " not supported on your arch", NR); \\
+		"syscall(%d) " SNR " not supported on your arch", NR); \\
 })
 #endif
 
@@ -56,7 +56,7 @@ cat << EOF > "${output_pid}"
 		tst_ret = syscall(NR, ##__VA_ARGS__); \\
 	} \\
 	if (tst_ret == -1 && errno == ENOSYS) { \\
-		TST_SYSCALL_BRK__(NR); \\
+		TST_SYSCALL_BRK__(NR, #NR); \\
 	} \\
 	tst_ret; \\
 })
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
