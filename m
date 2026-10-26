Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EA8606A323
	for <ltp@archiver.kernel.org>; Mon, 26 Oct 2026 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=u1hBOcZP;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hskd9Joo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=u1hBOcZP;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hskd9Joo
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A24273E9A88
	for <ltp@archiver.kernel.org>; Mon, 26 Oct 2026 16:16:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C2D13E2108
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 16:16:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6F68D60020C
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 16:16:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 092351F7B0;
 Mon, 26 Oct 2026 15:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793027801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yA6774yZP47P50TIj0Ne/UHTuwqZaN4NrTfOVz/Uf6E=;
 b=u1hBOcZPlTkNAJjNnv+QyLC23Dw6GB9u8H2RQJt0sO3kRsygIKbM76e75/ooIcKrYpX+u2
 vVDz4iylpP1qT5UfxXotYAhpHus0B5L1fUzdqsoYOlAcgYt3mdugXr/jKrFufs12pVkjOg
 vQrG2fm8ji0yOHWD06ZJ0eC+2ldHn+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793027801;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yA6774yZP47P50TIj0Ne/UHTuwqZaN4NrTfOVz/Uf6E=;
 b=hskd9JooTEaCOB0BTqjaucjl4S/uTpjCvu7YW4OEUX5QBcIkFd5gnwzxGzgYwLY8aytAC2
 Nw6DCAR7jWZ5z+AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=u1hBOcZP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hskd9Joo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793027801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yA6774yZP47P50TIj0Ne/UHTuwqZaN4NrTfOVz/Uf6E=;
 b=u1hBOcZPlTkNAJjNnv+QyLC23Dw6GB9u8H2RQJt0sO3kRsygIKbM76e75/ooIcKrYpX+u2
 vVDz4iylpP1qT5UfxXotYAhpHus0B5L1fUzdqsoYOlAcgYt3mdugXr/jKrFufs12pVkjOg
 vQrG2fm8ji0yOHWD06ZJ0eC+2ldHn+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793027801;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yA6774yZP47P50TIj0Ne/UHTuwqZaN4NrTfOVz/Uf6E=;
 b=hskd9JooTEaCOB0BTqjaucjl4S/uTpjCvu7YW4OEUX5QBcIkFd5gnwzxGzgYwLY8aytAC2
 Nw6DCAR7jWZ5z+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B60AD13408;
 Mon, 26 Oct 2026 15:16:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id voMfIthu32qdaQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 26 Oct 2026 15:16:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 26 Oct 2026 16:16:38 +0100
Message-ID: <20261026151638.578859-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 092351F7B0
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] shmctl03: Fix shmall clamped to UINT32_MAX in
 32bit compat mode
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Unlike shmmax, the kernel's compat shmctl(IPC_INFO) path does not clamp
shmall but truncates the 64-bit value into the 32-bit compat shminfo
(see copy_compat_shminfo_to_user() in ipc/shm.c, originally changed by
af7c693f14606 ("Cap shmmax at INT_MAX in compat shminfo") in kernel
v2.6.22.

Parsing /proc/sys/kernel/shmall's full decimal value with "%lu" into a
32-bit unsigned long saturates to ULONG_MAX instead of truncating,
causing a mismatch. Read it into an unsigned long long and compare
against the low 32 bits in compat mode.

Because this is a test specific error, fix it in the test itself instead
adding support to the LTP library.

This fixes error:

    shmctl03.c:35: TFAIL: /proc/sys/kernel/shmall != 4294967040 got 4294967295

Reported-by: Wei Gao <wegao@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

yet another attempt to fix struct shminfo shmall.
I believe in the end this is better than a general approach I posted
previously based on Andrea's suggestion [1] or older Wei's approach [2][3]
based on Cyril's suggestion.

Kind regards,
Petr

[1] https://patchwork.kernel.org/project/ltp/patch/20260924112514.2375626-2-pvorel@suse.cz/
[2] https://patchwork.kernel.org/project/ltp/patch/20260903095255.4925-3-wegao@suse.com/
[3] https://patchwork.kernel.org/project/ltp/patch/20260903095255.4925-2-wegao@suse.com/

 testcases/kernel/syscalls/shmctl/shmctl03.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/shmctl/shmctl03.c b/testcases/kernel/syscalls/shmctl/shmctl03.c
index bccab5ba37..e5937fd023 100644
--- a/testcases/kernel/syscalls/shmctl/shmctl03.c
+++ b/testcases/kernel/syscalls/shmctl/shmctl03.c
@@ -18,6 +18,7 @@ static void verify_ipcinfo(void)
 {
 	struct shminfo info;
 	unsigned long shmmax;
+	unsigned long long shmall;
 
 	TST_EXP_POSITIVE(shmctl(0, IPC_INFO, (struct shmid_ds *)&info));
 	if (!TST_PASS)
@@ -32,7 +33,18 @@ static void verify_ipcinfo(void)
 		TST_EXP_EQ_LU(info.shmmax, shmmax);
 
 	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni);
-	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall);
+
+	/*
+	 * On 32-bit compat, the kernel truncates the (64-bit) shmall to the
+	 * 32-bit compat shminfo, instead of clamping it like shmmax. The
+	 * /proc file still holds the untruncated value, so compare against
+	 * its low 32 bits.
+	 */
+	SAFE_FILE_SCANF(PATH_KERN_SHMALL, "%llu", &shmall);
+	if (tst_is_compat_mode())
+		TST_EXP_EQ_LU(info.shmall, (uint32_t)shmall);
+	else
+		TST_EXP_EQ_LU(info.shmall, shmall);
 }
 
 static struct tst_test test = {
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
