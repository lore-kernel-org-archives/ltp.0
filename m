Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0786EC0032E
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 11:09:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F3373CF914
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 13:09:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 378803CCBF2
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 13:08:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3BDF71A05C8F
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 13:08:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7586C21858;
 Wed, 25 Oct 2023 11:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698232117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TuxDPFHg3ObbJzYKz2MIyXRMpf1Die2oKU9w/QCYGxM=;
 b=oWCuyD5T6pKZe7wEoUVzzVGZlTbSTFxdtnYpbVI+jxiOATnJCskTduHaS4RgQSEIfMfK+j
 HsN2+SJz7gKQpvFcdrc7tdCoCRWf0cigTJ4DN+QrCpiEl5YeOJXzuZCeGMcvRYIlwsPF7p
 7Xh/cdYusTVx8ydDuGlAMAixszo3xvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698232117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TuxDPFHg3ObbJzYKz2MIyXRMpf1Die2oKU9w/QCYGxM=;
 b=FMVPUoN/mCWgGbPmo8AIiG5IjmRxf34QEPWL60TnRcQwb9WW+rcBiyyrG++GIxtq/dlz+t
 xMBbCjW1NdJidvCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53E2F13A82;
 Wed, 25 Oct 2023 11:08:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QLVvEzX3OGUVUgAAMHmgww
 (envelope-from <mkittler@suse.de>); Wed, 25 Oct 2023 11:08:37 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Wed, 25 Oct 2023 13:08:34 +0200
Message-ID: <20231025110835.28832-4-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025110835.28832-1-mkittler@suse.de>
References: <20231025110835.28832-1-mkittler@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.01 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.91)[99.63%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 3/4] Remove disabled code in ioctl02.c
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
index cfc081e9c..d5d19e1b9 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -123,20 +123,6 @@ static void chk_tty_parms(void)
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
