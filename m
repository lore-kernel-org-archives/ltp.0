Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C04C7EE25
	for <ltp@archiver.kernel.org>; Thu,  8 Jun 2023 15:00:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 272A03CC29F
	for <ltp@archiver.kernel.org>; Thu,  8 Jun 2023 17:00:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2E2C3CAB0D
 for <ltp@lists.linux.it>; Thu,  8 Jun 2023 17:00:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 08BA91A01079
 for <ltp@lists.linux.it>; Thu,  8 Jun 2023 17:00:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 27B1F1FDD5
 for <ltp@lists.linux.it>; Thu,  8 Jun 2023 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1686236414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2f6LBackAIJTYz3cYIKdohcTttbYk9JWTyo2xbiTXYg=;
 b=wgCYuAuR6NMP4APmti44ThSjho7hAHSYjMlGysljgWckS0VOPBhoHJtmciw+/ywEqe9sxw
 SXbHY0bTqvXX9smEzX8cjqweG/CETck8Sh/6/gQTbXXtNcq7HtbIansX1TA+elVecOZlQ5
 yP5JMAHLjVcVvsHa4yzq3OQw2N8Glcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1686236414;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2f6LBackAIJTYz3cYIKdohcTttbYk9JWTyo2xbiTXYg=;
 b=MSocgykGfpCwA/VB4yBMvOrIBQVqUp4BWmE4lGQxJQ0DKVlcXojyitJ96icUIkToAm780H
 qNyX3Jle9v6mp+AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C485E13480
 for <ltp@lists.linux.it>; Thu,  8 Jun 2023 15:00:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9v+MJv3sgWQUDAAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 08 Jun 2023 15:00:13 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu,  8 Jun 2023 20:30:11 +0530
Message-Id: <20230608150011.9539-1-akumar@suse.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] execve01|06: Correct names in the error message
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/execve/execve01.c | 2 +-
 testcases/kernel/syscalls/execve/execve06.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/execve/execve01.c b/testcases/kernel/syscalls/execve/execve01.c
index 2b12c7666..53f0475e3 100644
--- a/testcases/kernel/syscalls/execve/execve01.c
+++ b/testcases/kernel/syscalls/execve/execve01.c
@@ -34,7 +34,7 @@ static void verify_execve(void)
 	pid = SAFE_FORK();
 	if (pid == 0) {
 		execve(path, args, envp);
-		tst_brk(TFAIL | TERRNO, "Failed to execute execl01_child");
+		tst_brk(TFAIL | TERRNO, "Failed to execute execve01_child");
 	}
 }
 
diff --git a/testcases/kernel/syscalls/execve/execve06.c b/testcases/kernel/syscalls/execve/execve06.c
index afbfcfa9e..a00089265 100644
--- a/testcases/kernel/syscalls/execve/execve06.c
+++ b/testcases/kernel/syscalls/execve/execve06.c
@@ -35,7 +35,7 @@ static void verify_execve(void)
 	pid = SAFE_FORK();
 	if (pid == 0) {
 		execve(path, argv, envp);
-		tst_brk(TFAIL | TERRNO, "Failed to execute execl01_child");
+		tst_brk(TFAIL | TERRNO, "Failed to execute execve06_child");
 	}
 }
 
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
