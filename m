Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99353D68B2B
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 14:41:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3843A3D6F13
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 15:41:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9C093D6F13
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 15:40:37 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C12FD1BDB6EC
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 15:40:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 088251F445;
 Thu, 14 Nov 2024 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731595236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=50+zrXs3YwiLVFpiSaZuLMX5G4XoxY8SD9gZvzseY3c=;
 b=lkdnlWOVHTAnsyxLNfywwqwx2tw3ZzS17JdsVzXa90dLZRkk0o95SJqUR1IMD/RFTQaW+w
 Pya+xgmjR+pRW09pFDnGri3dw0fuD2tV/Y4ylP8aNVZhMtNtzFhnN/BehzqH/Qin9L3doJ
 YP49iTgL+bkwfvNNXlgSWa5ZTpd0YS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731595236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=50+zrXs3YwiLVFpiSaZuLMX5G4XoxY8SD9gZvzseY3c=;
 b=6DL+uFbLVWNqR+fxnY2GK1BokQbfNci/eAObGmND+3Gbgh3ZauQSqpHwPZxS5lDaYm6cVH
 vIpVrnJaP+8vyiCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lkdnlWOV;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6DL+uFbL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731595236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=50+zrXs3YwiLVFpiSaZuLMX5G4XoxY8SD9gZvzseY3c=;
 b=lkdnlWOVHTAnsyxLNfywwqwx2tw3ZzS17JdsVzXa90dLZRkk0o95SJqUR1IMD/RFTQaW+w
 Pya+xgmjR+pRW09pFDnGri3dw0fuD2tV/Y4ylP8aNVZhMtNtzFhnN/BehzqH/Qin9L3doJ
 YP49iTgL+bkwfvNNXlgSWa5ZTpd0YS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731595236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=50+zrXs3YwiLVFpiSaZuLMX5G4XoxY8SD9gZvzseY3c=;
 b=6DL+uFbLVWNqR+fxnY2GK1BokQbfNci/eAObGmND+3Gbgh3ZauQSqpHwPZxS5lDaYm6cVH
 vIpVrnJaP+8vyiCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE82213721;
 Thu, 14 Nov 2024 14:40:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oLpbNeMLNmeSdwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 14 Nov 2024 14:40:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 14 Nov 2024 15:40:29 +0100
Message-ID: <20241114144029.349559-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114144029.349559-1-pvorel@suse.cz>
References: <20241114144029.349559-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 088251F445
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] libs/sigwait: Use safe/test macros
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

Simplify code with SAFE_SIGPROCMASK(), TST_EXP_FAIL().

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 libs/sigwait/sigwait.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/libs/sigwait/sigwait.c b/libs/sigwait/sigwait.c
index cf3c445b4a..a9fd62d73c 100644
--- a/libs/sigwait/sigwait.c
+++ b/libs/sigwait/sigwait.c
@@ -286,9 +286,7 @@ void test_bad_address(swi_func sigwaitinfo, int signo,
 	/* let's not get interrupted by our dying child */
 	SAFE_SIGADDSET(&sigs, SIGCHLD);
 
-	TEST(sigprocmask(SIG_SETMASK, &sigs, &oldmask));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigprocmask() failed");
+	SAFE_SIGPROCMASK(SIG_SETMASK, &sigs, &oldmask);
 
 	/* don't wait on a SIGCHLD */
 	SAFE_SIGDELSET(&sigs, SIGCHLD);
@@ -296,19 +294,8 @@ void test_bad_address(swi_func sigwaitinfo, int signo,
 	/* Run a child that will wake us up */
 	child = create_sig_proc(signo, 1, 0);
 
-	TEST(sigwaitinfo(&sigs, (void *)1, NULL));
-	if (TST_RET == -1) {
-		if (TST_ERR == EFAULT)
-			tst_res(TPASS, "Fault occurred while accessing the buffers");
-		else
-			tst_res(TFAIL | TTERRNO, "Expected error number EFAULT, got");
-	} else {
-		tst_res(TFAIL, "Expected return value -1, got: %ld", TST_RET);
-	}
-
-	TEST(sigprocmask(SIG_SETMASK, &oldmask, NULL));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "restoring original signal mask failed");
+	TST_EXP_FAIL(sigwaitinfo(&sigs, (void *)1, NULL), EFAULT);
+	SAFE_SIGPROCMASK(SIG_SETMASK, &oldmask, NULL);
 
 	SAFE_KILL(child, SIGTERM);
 	SAFE_WAIT(NULL);
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
