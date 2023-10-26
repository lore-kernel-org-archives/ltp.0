Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0209C25B6B
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 11:48:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F8DF3CEC0D
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 13:48:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54E963CD0DD
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 13:47:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 340341001159
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 13:47:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 513B71F86B;
 Thu, 26 Oct 2023 11:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698320839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KEfv+3iCfWemisYGwrx2LPZrKfrNEXgtJ++9HHc6pl4=;
 b=TYMcctBZntRE4dKexrlqgkjx1Mjqknzt0BHXlxKhzAwc1lEaWYM/gfnEw/yFLJiUuGq6er
 NtmHmmPGQwjG1nANj9MRBTHliFpf+NZgQxf94bEKEfehwWPa8D5x02S/4sXneJVzfze+A7
 5pyc/4Wq0ffsvZ8LQvWM9tP1YvXPp9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698320839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KEfv+3iCfWemisYGwrx2LPZrKfrNEXgtJ++9HHc6pl4=;
 b=ZtGwBSS9i8UzH0qIhma68hd/L1ZWzxJ5KybX7MN+SbZD/u8Y295P6/Zmn8QXrAecw7posP
 Pg07fhp+XwrOVlBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AFE813A9B;
 Thu, 26 Oct 2023 11:47:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QJ9tDcdROmW/fAAAMHmgww
 (envelope-from <mkittler@suse.de>); Thu, 26 Oct 2023 11:47:19 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Thu, 26 Oct 2023 13:47:14 +0200
Message-ID: <20231026114716.17545-4-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231026114716.17545-1-mkittler@suse.de>
References: <20231026114716.17545-1-mkittler@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 3/4] Remove disabled code in ioctl02.c
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
index 4a502a724..8c6924386 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -122,20 +122,6 @@ static void chk_tty_parms(void)
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
-		tst_res(TFAIL, "cflag has incorrect value. %o",
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
