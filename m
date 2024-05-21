Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1DBC25B74
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 10:54:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24C603D009D
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 12:54:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D01473C0562
 for <ltp@lists.linux.it>; Tue, 21 May 2024 12:53:53 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 46333200C0F
 for <ltp@lists.linux.it>; Tue, 21 May 2024 12:53:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E6E995C07F;
 Tue, 21 May 2024 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716288832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a5wMYWucAqkYnhVtwB4Gn2jZRJ40yZxM2mJSTFH1FXc=;
 b=w52p3mUkdcfl8KnnBk+zLv4oE1fdctdHMdXNO4hMKqX/nrwRvmCs9VRQAcUBcZy6g8zW3y
 PDtlPeyz8BtDz+OYr6TesQuTgELNYjpAV5b9sketJD7iCuR4ld69qffUwmFpmhQNfMF7la
 f0ODwuOxth5we45Eqsaze+DgLQGfiKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716288832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a5wMYWucAqkYnhVtwB4Gn2jZRJ40yZxM2mJSTFH1FXc=;
 b=zxZdz+gKYFTYXr7Y6Bkejrgkb9RfnzB1VKhwToef4x89wZgMzXaM0oTGi48l2swRzkkxd4
 P39KwfbQbAP4L9AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=u74046D4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MyefTHR2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716288831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a5wMYWucAqkYnhVtwB4Gn2jZRJ40yZxM2mJSTFH1FXc=;
 b=u74046D4CStiJiWcVV849/AHwv06ByzctR0/LLmmoUk7hA/iv91v8X3xxG0fK8279kps/9
 NxaueBOxbmJMy0NMdjb7CqSzI1ARGT0IAtGaQuNCFzrA2L8rr3KzPU45xV4MY/YzT5RU7s
 X+hbJcpjDomw6oroRc/Y2mOegzDOhl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716288831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a5wMYWucAqkYnhVtwB4Gn2jZRJ40yZxM2mJSTFH1FXc=;
 b=MyefTHR27H6ATZduiaq7xmD1+CPbLKkdk6z3+o3bV4HIO9H6qNARvxIBjTIisu794Lz/3G
 o6Uc7+GhRHhWYxCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1D1613A7B;
 Tue, 21 May 2024 10:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KFhvLj99TGYMPwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 21 May 2024 10:53:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 May 2024 12:53:47 +0200
Message-ID: <20240521105348.126316-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521105348.126316-1-pvorel@suse.cz>
References: <20240521105348.126316-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E6E995C07F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/5] sbrk03: Convert to detect support with flags
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

.needs_abi_bits and .supported_archs are doc friendly.
Also, it does tst_brk() (in case of more run with -i).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2

 testcases/kernel/syscalls/sbrk/sbrk03.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/sbrk/sbrk03.c b/testcases/kernel/syscalls/sbrk/sbrk03.c
index 80d2020ff..875815629 100644
--- a/testcases/kernel/syscalls/sbrk/sbrk03.c
+++ b/testcases/kernel/syscalls/sbrk/sbrk03.c
@@ -39,7 +39,6 @@
 
 static void sbrk_test(void)
 {
-#if defined(__s390__) && defined(TST_ABI32)
 	void *ret1, *ret2;
 
 	/* set bkr to 0x10000000 */
@@ -59,13 +58,15 @@ static void sbrk_test(void)
 	}
 
 	tst_res(TPASS, "sbrk verify: %p", ret2);
-#else
-	tst_res(TCONF, "Only works in 32bit on s390 series system");
-#endif
 }
 
 static struct tst_test test = {
 	.test_all = sbrk_test,
+	.supported_archs = (const char *const []) {
+		"s390",
+		NULL
+	},
+	.needs_abi_bits = 32,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "473a06572fcd"},
 		{}
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
