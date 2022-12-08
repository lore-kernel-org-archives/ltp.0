Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BBDC4332F
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 07:46:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 733513CC052
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 08:46:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94EC73CC03A
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 08:45:56 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ECBC91A0098C
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 08:45:55 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 30E6D22DF1
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 07:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670485555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ag5/OW3Pac40+m2OXYW3TlsJpEvkKdcUYlFsVFpdQs0=;
 b=cbR7ejhOwmAqmjYiPNte85giEi3mjKM6sHQf7JaubMHZCKh2YD/hM3ZNGPp3cULSTmP97E
 Un3aMVdk4BZIJ9Uwfu2mwv2x14NHU6TlnNyu2lJSplZ4eF+Kg95IxKLqVEE10RGBgBE4Zu
 N1FTCqr4A4eYw4FoBTK3ZbRZFU9IqCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670485555;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ag5/OW3Pac40+m2OXYW3TlsJpEvkKdcUYlFsVFpdQs0=;
 b=+s5FB8EBqb3VTk3rsLhFH1y/jcE08LaUhfOJbBSS+9J63wWhorc2QcjbY5geQ/8V6dYqO9
 GDUh+Vil8VkkzYDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4862138E0
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 07:45:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IMnUGTKWkWNiEgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 08 Dec 2022 07:45:54 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu,  8 Dec 2022 13:15:51 +0530
Message-Id: <20221208074551.22342-1-akumar@suse.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setresuid04.c: add tmpdir and leaving rgid,
 sgid unchanged
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
 testcases/kernel/syscalls/setresuid/setresuid04.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/setresuid/setresuid04.c b/testcases/kernel/syscalls/setresuid/setresuid04.c
index 886ecdd0b..833aee91d 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid04.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid04.c
@@ -52,7 +52,7 @@ static void run(void)
 	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
 		tst_res(TFAIL, "child process exited with status: %d", status);
 
-	SAFE_SETRESUID(0, 0, 0);
+	SAFE_SETRESUID(-1, 0, -1);
 	TST_EXP_FD(open(TEMP_FILE, O_RDWR));
 	SAFE_CLOSE(TST_RET);
 }
@@ -68,5 +68,6 @@ static struct tst_test test = {
 	.test_all = run,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	.needs_tmpdir = 1,
 	.forks_child = 1
 };
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
