Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D29BCD54AF
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 11:10:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49D1B3CE463
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 13:10:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4FB533CA6D1
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 13:09:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 07310208E10
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 13:09:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A68092296E;
 Tue, 19 Sep 2023 11:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695121793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zjj6qBK/6d9SDXdWBKclfpg/Oa1L9lcQB8DnOsf2e2I=;
 b=cGB/8xTScnhKLKzSoEvqL4jSt9J7YqSsrWRggKVD0XduS5/x9EW2AwrYeYoT3Dl+S/4HEf
 EyMdoNuYgThrpnUJwxVhiebtO9h1zI1uz8ryj1zhaBKulM+0wqCTTMusutHUCLoKMDSwom
 u49CHI1rb+Q7tvq0BFbhf7KDtu+pZEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695121793;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zjj6qBK/6d9SDXdWBKclfpg/Oa1L9lcQB8DnOsf2e2I=;
 b=pJBk72FyrfkWi4lnE9leCcJdLJ1bdkqIVpHuRcuk7hGKHq79/sduxyS5ALP7Q968n8iePa
 +T+2G1QB/2pnK5AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91894134F3;
 Tue, 19 Sep 2023 11:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mNF9IoGBCWVVYwAAMHmgww
 (envelope-from <mkittler@suse.de>); Tue, 19 Sep 2023 11:09:53 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Tue, 19 Sep 2023 13:09:50 +0200
Message-ID: <20230919110951.31500-4-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919110951.31500-1-mkittler@suse.de>
References: <20230919110951.31500-1-mkittler@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 3/4] Remove disabled code in ioctl02.c
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

Signed-off-by: Marius Kittler <mkittler@suse.de>
---
 testcases/kernel/syscalls/ioctl/ioctl02.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
index d2f46cd1a..f049d4e9c 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -149,20 +149,6 @@ static int chk_tty_parms(void)
 			 termio.c_line);
 		flag++;
 	}
-	/*
-	 * The following Code Sniffet is disabled to check the value of c_cflag
-	 * as it seems that due to some changes from 2.6.24 onwards, this
-	 * setting is not done properly for either of (B50|CS7|CREAD|PARENB|
-	 * PARODD|CLOCAL|(CREAD|HUPCL|CLOCAL).
-	 * However, it has been observed that other flags are properly set.
-	 */
-#if 0
-	if (termio.c_cflag != (B50 | CS7 | CREAD | PARENB | PARODD | CLOCAL)) {
-		tst_res(TINFO, "cflag has incorrect value. %o",
-			 termio.c_cflag);
-		flag++;
-	}
-#endif
 
 	for (i = 0; i < NCC; i++) {
 		if (i == VEOL2) {
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
