Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBADC433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 12:40:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 211A03C8C94
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 13:40:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0E343C0CEA
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 13:40:01 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 76AF3201008
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 13:40:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AC9141F381;
 Fri, 11 Mar 2022 12:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647002400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=h80EO7vs9xwIwGrCCDxTAkeFL0MkNv6jrlSCAsnjeTA=;
 b=rjgyyCS2SfZ+HNpdOSqCPl21WkTTwYBlMya82NSdky3BAghbKV/zRsKM4SBjcRg9R1H5ro
 IVuu8qOqoyHnrBc9ZGUFT0kvQKFSd52pnCWNZ0GpWhXSJxDjuJpci6J0vNc5yzgwNh4IfG
 LsEHjZlxYT6HxrOCO3f/fhVVlHsJ6ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647002400;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=h80EO7vs9xwIwGrCCDxTAkeFL0MkNv6jrlSCAsnjeTA=;
 b=puHg3J3t1xm3vG0SRmw41aTxdfhPOwEfHGEujVSfbyLvCnJtW3kq3eXz7UGVYzMvpjzkh2
 FdbgKSdrvVyyJdBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71B2C13A85;
 Fri, 11 Mar 2022 12:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id n10uGSBDK2LSOgAAMHmgww
 (envelope-from <blezhepekov@suse.de>); Fri, 11 Mar 2022 12:40:00 +0000
From: Bogdan Lezhepekov <blezhepekov@suse.de>
To: ltp@lists.linux.it
Date: Fri, 11 Mar 2022 14:39:57 +0200
Message-Id: <20220311123957.30998-1-blezhepekov@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] kernel/pty06: Skip test when TTY not available
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

Since TTYs under test are hardcoded, they
might not be available in some systems.

Signed-off-by: Bogdan Lezhepekov <blezhepekov@suse.de>
---
 testcases/kernel/pty/pty06.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/pty/pty06.c b/testcases/kernel/pty/pty06.c
index b621f584f..250c38f6b 100644
--- a/testcases/kernel/pty/pty06.c
+++ b/testcases/kernel/pty/pty06.c
@@ -45,8 +45,6 @@ static struct tst_fzsync_pair fzp;
 
 static void *open_close(void *unused)
 {
-	sprintf(tty_path_b, "/dev/tty%d", test_tty_port);
-
 	while (tst_fzsync_run_b(&fzp)) {
 		tst_fzsync_start_race_b(&fzp);
 		int fd = SAFE_OPEN(tty_path_b, O_RDWR);
@@ -60,7 +58,6 @@ static void *open_close(void *unused)
 
 static void do_test(void)
 {
-	sprintf(tty_path_a, "/dev/tty%d", test_tty_port + 1);
 	int fd = SAFE_OPEN(tty_path_a, O_RDWR);
 
 	tst_fzsync_pair_reset(&fzp, open_close);
@@ -80,6 +77,12 @@ static void do_test(void)
 
 static void setup(void)
 {
+	sprintf(tty_path_a, "/dev/tty%d", test_tty_port + 1);
+	sprintf(tty_path_b, "/dev/tty%d", test_tty_port);
+
+	if (access(tty_path_a, F_OK) != 0 || access(tty_path_b, F_OK) != 0)
+		tst_brk(TCONF, "TTY(s) under test not available in system");
+
 	tst_fzsync_pair_init(&fzp);
 }
 
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
