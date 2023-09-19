Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07143CD54AF
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 10:25:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D2513CE464
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 12:25:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F1123CA6BC
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 12:24:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9C92E600080
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 12:24:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3028F2296E;
 Tue, 19 Sep 2023 10:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695119088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+Bpanftg3RE9/FvrtZ86i4V2On0MtoPwsD9/2uZ3jg=;
 b=IuxX5KtgOWPeCusRlgO0ukNE/JdJVzYI1uupCGLRGCJ7jKAq1xbDk81/otKbeKCa8cHB0Y
 1gWK6VjfvNN6ldDjteDsWeG3ReLRBAdnffVS6rCuC+cF8v0vYqK8PdEGgJLzEQAMeDgxqx
 28AoHlvjJxaHq+ybTwlWvxP1hH032Ys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695119088;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+Bpanftg3RE9/FvrtZ86i4V2On0MtoPwsD9/2uZ3jg=;
 b=rYGi7YDT70LIyuMdyyo2jqGNmPmei6fDkoVDduuctoYYN7L45QDmwdvoaU1OgUJDFbB9ZV
 Py4x5LV/uuLkzADQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A82A13A49;
 Tue, 19 Sep 2023 10:24:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4OBrBfB2CWXOSAAAMHmgww
 (envelope-from <mkittler@suse.de>); Tue, 19 Sep 2023 10:24:48 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Tue, 19 Sep 2023 12:24:44 +0200
Message-ID: <20230919102445.23934-4-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919102445.23934-1-mkittler@suse.de>
References: <20230919102445.23934-1-mkittler@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/4] Remove disabled code in ioctl02.c
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
index b7548b4b3..b4db6ba86 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -148,20 +148,6 @@ static int chk_tty_parms(void)
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
