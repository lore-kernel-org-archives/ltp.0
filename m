Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35920C54F51
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 09:18:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 602923E4B22
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 11:18:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BA343E4D26
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:17:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C456B14002A6
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:17:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2744C7C983;
 Wed, 29 Jul 2026 09:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785316658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mWbc/cKku0dApuD6mol+ds1AubKqbvdnu5Hy9v52MBo=;
 b=Kwn9finFqabMSKvN/Hyqgl6v2LmfD1HcXhzZoeXYWBAkdPf61kU8TSpgVZq0Yhd5d2nBa7
 zG6DfuXVfP9vwCnC/Y0bM3f6sHRJKUrK1VvUnG2e5gluY6jRGzniChzFeb9xcGSsC90p5w
 B051e0Jv+rKNbWxGP7OW3ykY1ZPV7tM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785316658;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mWbc/cKku0dApuD6mol+ds1AubKqbvdnu5Hy9v52MBo=;
 b=VLXQHRjMrMdxDDIMin1i7QD5znxoiTNhVDiaeY/P85eRXLcotn3DenMzirZWeWTJ6L9DkK
 5ERK6f+T4W+vlAAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ARMXnQZN;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="myTbP/Sv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785316654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mWbc/cKku0dApuD6mol+ds1AubKqbvdnu5Hy9v52MBo=;
 b=ARMXnQZNJsPL/vnOp/XEg3LoaJz2H5yGk7iFhBP9GfcsBsmeuIsVbVyexdIVhPWfZtlVWn
 GqPq487KpZMcfqPGYWI687CLxhxSlvxG/KMVqIzrxPw52R6Nr470IX4ZXjSm/RgBUlrT+0
 dFjZVfsMMGpawZHuXxIAkkpeUXwVuig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785316654;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mWbc/cKku0dApuD6mol+ds1AubKqbvdnu5Hy9v52MBo=;
 b=myTbP/SvorddDBGrVgyraHHRCZr0fMyrrGgKEAOPH5lY8CWgrFgPB356+dJwEz7iFiHmyU
 OET+AK3CnELiv7DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49143779BC;
 Wed, 29 Jul 2026 09:17:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0DArECnFaWpYfgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 29 Jul 2026 09:17:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 29 Jul 2026 11:17:16 +0200
Message-ID: <20260729091717.23042-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729091717.23042-1-pvorel@suse.cz>
References: <20260729091717.23042-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid,suse.cz:dkim];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 2744C7C983
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] creat07: Use .max_kver
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/creat/creat07.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
index c7b85ee694..07f7bb10db 100644
--- a/testcases/kernel/syscalls/creat/creat07.c
+++ b/testcases/kernel/syscalls/creat/creat07.c
@@ -6,6 +6,9 @@
 
 /*\
  * Check that :manpage:`creat(2)` sets ETXTBSY correctly.
+ *
+ * NOTE: write to executed file is allowed since 6.11-rc1:
+ * 2a010c412853 ("fs: don't block i_writecount during exec")
  */
 
 #include <sys/types.h>
@@ -47,19 +50,10 @@ static void verify_creat(void)
 	SAFE_WAITPID(pid, NULL, 0);
 }
 
-static void setup(void)
-{
-	if ((tst_kvercmp(6, 11, 0)) >= 0) {
-		tst_brk(TCONF, "Skipping test, write to executed file is "
-			"allowed since 6.11-rc1.\n"
-			"2a010c412853 (\"fs: don't block i_writecount during exec\")");
-	}
-}
-
 static struct tst_test test = {
-	.setup = setup,
 	.test_all = verify_creat,
 	.needs_checkpoints = 1,
+	.max_kver = "6.11",
 	.forks_child = 1,
 	.resource_files = (const char *const []) {
 		TEST_APP,
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
