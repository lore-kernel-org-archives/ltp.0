Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1C2C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 10:12:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D1643C8C4C
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 11:12:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1E7C3C093B
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 11:12:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 45B6D601286
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 11:12:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A4F721124;
 Mon, 13 Dec 2021 10:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1639390355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+uoFT2VzOGZp8dz7cwKV4n6B9iL5x5wmqwbtKNh7CDs=;
 b=AYlqqkwkwlDeXcHQ28w4mcVcZTq0W5CVYHa2Q/xa+keXLvImZTxV0/Y9tH4pCZEO4nLLa8
 x4PzP+M5t6vKp4FESP9reo8Zx+WibV9UocqKJ5NHmCUmvcF3U8DA+C27HoGIotGTIcrKed
 h6iAbpSFsuj3dYK86CxafEBSsCHmm74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1639390355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+uoFT2VzOGZp8dz7cwKV4n6B9iL5x5wmqwbtKNh7CDs=;
 b=gftlXKxDdeB29zvFKqaoFsZtNlk9fJ+KoBIuuudJkpQVN71VX/x8+KrdNHopu3P3PZw01Q
 GOu0bEHF9HrHClAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 561FA13CE5;
 Mon, 13 Dec 2021 10:12:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tGvVEpMct2HaNwAAMHmgww
 (envelope-from <fvogt@suse.de>); Mon, 13 Dec 2021 10:12:35 +0000
From: Fabian Vogt <fvogt@suse.de>
To: LTP List <ltp@lists.linux.it>
Date: Mon, 13 Dec 2021 11:12:34 +0100
Message-ID: <4712735.uizZLiLCHF@linux-e202.suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/fcntl15: Wait until child processes did its
 work
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

The child process might not have completed locking region two when the parent
expectes it to. Wait for it.

Fixes: 079de87f9522 ("syscalls/fcntl15: Convert to new API")
Signed-off-by: Fabian Vogt <fvogt@suse.de>
---
 testcases/kernel/syscalls/fcntl/fcntl15.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl15.c b/testcases/kernel/syscalls/fcntl/fcntl15.c
index 59328605ac2b..82dee4b21ee2 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl15.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl15.c
@@ -75,7 +75,7 @@ static void lock_region_two(int file_flag, int file_mode)
 
 	SAFE_FCNTL(fd, F_SETLK, &lock_two);
 
-	TST_CHECKPOINT_WAIT(1);
+	TST_CHECKPOINT_WAKE_AND_WAIT(1);
 
 	SAFE_CLOSE(fd);
 }
@@ -143,8 +143,11 @@ static int run_test(int file_flag, int file_mode, int dup_flag)
 
 	SAFE_FCNTL(fd[0], F_SETLK, &lock_one);
 
+	// Lock region two or wait until the child locked it
 	if (dup_flag != FORK_)
 		SAFE_FCNTL(fd[1], F_SETLK, &lock_two);
+	else
+		TST_CHECKPOINT_WAIT(1);
 
 	if (!SAFE_FORK()) {
 		do_test(file_flag, file_mode, dup_flag);
-- 
2.33.1





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
