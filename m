Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FCAC004C0
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 16:03:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0792E3CF4FA
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 18:03:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31BD63CECED
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 18:02:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 339B61000B78
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 18:02:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0F64221B08;
 Mon, 23 Oct 2023 16:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698076968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5ZXvHIyEpGl8cms+XRlQam4zqWm3Nj+n+CGSTvrggs=;
 b=MJ9gu3Y9QcZfVOBaG7zdlEVQF2SNV73D5uGZLnYCNeGCiz7sTE366qiDahdZ02Kjix5R7q
 WuZdQA/xGiICwXvZObjbxBpAaVxxii5VOupu73eioWTbnjvu0KNmMMYhed0VvkneVoT2mU
 Yv+E+LwTxsFZ657/fEx8MJM+BJ4/M/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698076968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5ZXvHIyEpGl8cms+XRlQam4zqWm3Nj+n+CGSTvrggs=;
 b=OeO197APvZ8m3tQWQ2/kdp6FMP2EeZqJV+oGLwu6+CQ+iq5g9KfoZmbyflNKOykP+kMtg6
 Ux9A5eDyOHOp2ZBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D759A13A94;
 Mon, 23 Oct 2023 16:02:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cKEuMyeZNmVhJAAAMHmgww
 (envelope-from <mkittler@suse.de>); Mon, 23 Oct 2023 16:02:47 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Mon, 23 Oct 2023 18:02:40 +0200
Message-ID: <20231023160242.3605-4-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023160242.3605-1-mkittler@suse.de>
References: <20231023160242.3605-1-mkittler@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.00 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.90)[99.59%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 3/5] Remove disabled code in ioctl02.c
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
index 25b83d358..c66473a8d 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -134,20 +134,6 @@ static void chk_tty_parms(void)
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
