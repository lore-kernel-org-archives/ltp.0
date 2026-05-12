Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F8BCD4851
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 12:49:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 517383D0E5D
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 14:49:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D78E3CC50D
 for <ltp@lists.linux.it>; Tue, 12 May 2026 14:49:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 63F872005CA
 for <ltp@lists.linux.it>; Tue, 12 May 2026 14:49:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B1A1B75F30
 for <ltp@lists.linux.it>; Tue, 12 May 2026 12:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778590150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LSszxo0LBkXdvs+Xvg4e2kRHHHu+TxW+FOF6PLRxb+A=;
 b=D0NP9TBaOFZo1sjsg7E431ZKa7z+qk2S2GtHwXHrIbU22h8Yh4LwuETdxMLAjl+WahRtEU
 WxY+WDNJSI4Hxdu8Km37sadMZUiwUOURyNCRo75C1GeUY+jLSx5frAiN10WuFhcLulixug
 owIwzR6bE+ODdIIlX9dYmqh88EaOz1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778590150;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LSszxo0LBkXdvs+Xvg4e2kRHHHu+TxW+FOF6PLRxb+A=;
 b=T46j+6KDgC+k8pkWKJDgaJLH5AmqrJ2b9MVodIVeMwc5hVINlp5Swb1qNXEgqI/2wWgVbp
 LG5UXlENkvY7uyAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778590150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LSszxo0LBkXdvs+Xvg4e2kRHHHu+TxW+FOF6PLRxb+A=;
 b=D0NP9TBaOFZo1sjsg7E431ZKa7z+qk2S2GtHwXHrIbU22h8Yh4LwuETdxMLAjl+WahRtEU
 WxY+WDNJSI4Hxdu8Km37sadMZUiwUOURyNCRo75C1GeUY+jLSx5frAiN10WuFhcLulixug
 owIwzR6bE+ODdIIlX9dYmqh88EaOz1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778590150;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LSszxo0LBkXdvs+Xvg4e2kRHHHu+TxW+FOF6PLRxb+A=;
 b=T46j+6KDgC+k8pkWKJDgaJLH5AmqrJ2b9MVodIVeMwc5hVINlp5Swb1qNXEgqI/2wWgVbp
 LG5UXlENkvY7uyAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9358593A9
 for <ltp@lists.linux.it>; Tue, 12 May 2026 12:49:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id seoFKcYhA2qWLQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 12 May 2026 12:49:10 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 12 May 2026 14:49:06 +0200
Message-ID: <20260512124909.27094-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] af_alg08: Don't check recv() errno
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

Recent kernels return EBADMSG from recv() when the crypto operation
fails. However, older kernels return EINVAL instead. Remove check
for specific errno and only check that recv() failed.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/crypto/af_alg08.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/crypto/af_alg08.c b/testcases/kernel/crypto/af_alg08.c
index 5e04b579c..4cc3e5c4e 100644
--- a/testcases/kernel/crypto/af_alg08.c
+++ b/testcases/kernel/crypto/af_alg08.c
@@ -100,7 +100,14 @@ static void try_corrupt(void)
 	SAFE_SPLICE(pipefd[0], NULL, reqfd, NULL, OVERWRITE_SIZE, 0);
 
 	/* Expected to fail (invalid ciphertext); triggers the scratch write */
-	TST_EXP_FAIL_SILENT(recv(reqfd, recvbuf, sizeof(recvbuf), 0), EBADMSG);
+	TEST(recv(reqfd, recvbuf, sizeof(recvbuf), 0));
+
+	if (TST_RET >= 0) {
+		tst_res(TFAIL, "Decryption succeeded unexpectedly");
+	} else if (TST_RET != -1) {
+		tst_res(TFAIL | TTERRNO, "Invalid recv() return value %ld",
+			TST_RET);
+	}
 
 	SAFE_CLOSE(pipefd[0]);
 	SAFE_CLOSE(pipefd[1]);
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
