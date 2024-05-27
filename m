Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164C9C25B79
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 06:36:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A34333D037E
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 08:36:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EE0B3D029D
 for <ltp@lists.linux.it>; Mon, 27 May 2024 08:33:58 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A4C2A1400F97
 for <ltp@lists.linux.it>; Mon, 27 May 2024 08:33:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AD3CB1FB64;
 Mon, 27 May 2024 06:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716791636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q2ijsRPfxS6T5KQIPV1FoH0er+J/K56HJ0Qf46ZDVHc=;
 b=jdpMHjFJ9lsYvzZI/C2rmiBYacYagGixz48IO3Vf00bdTlZDShxCP1HYLkFb6fEv5yVMAM
 sB8uS8+NsPTHLsfHNDSJ+akeyfcTWvza+gPOyn+JHkbai8JCPl25azfuVX5E9O2sEZpvgL
 OLPmb8CGNRtV53GZkCSgzldbVOPvYd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716791636;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q2ijsRPfxS6T5KQIPV1FoH0er+J/K56HJ0Qf46ZDVHc=;
 b=8NWRB0yKeEg8NFOUwdKsG4Ol6ogCpMpoA+sAvmV75FEXNS8k/4aaNAt+Z/kbpn5lnf0gHB
 ks9VhFuOdbJRrMAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jdpMHjFJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8NWRB0yK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716791636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q2ijsRPfxS6T5KQIPV1FoH0er+J/K56HJ0Qf46ZDVHc=;
 b=jdpMHjFJ9lsYvzZI/C2rmiBYacYagGixz48IO3Vf00bdTlZDShxCP1HYLkFb6fEv5yVMAM
 sB8uS8+NsPTHLsfHNDSJ+akeyfcTWvza+gPOyn+JHkbai8JCPl25azfuVX5E9O2sEZpvgL
 OLPmb8CGNRtV53GZkCSgzldbVOPvYd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716791636;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q2ijsRPfxS6T5KQIPV1FoH0er+J/K56HJ0Qf46ZDVHc=;
 b=8NWRB0yKeEg8NFOUwdKsG4Ol6ogCpMpoA+sAvmV75FEXNS8k/4aaNAt+Z/kbpn5lnf0gHB
 ks9VhFuOdbJRrMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 906AD13A6C;
 Mon, 27 May 2024 06:33:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YEdeIlQpVGZAFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 27 May 2024 06:33:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 27 May 2024 08:33:35 +0200
Message-ID: <20240527063346.289771-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527063346.289771-1-pvorel@suse.cz>
References: <20240527063346.289771-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AD3CB1FB64
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 04/15] sched_{g, setattr}: Remove kernel >= 3.14 check
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

Since 9e9654cf2 LTP supports kernel >= 4.4.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/sched_getattr/sched_getattr01.c | 3 ---
 testcases/kernel/syscalls/sched_getattr/sched_getattr02.c | 3 ---
 testcases/kernel/syscalls/sched_setattr/sched_setattr01.c | 3 ---
 3 files changed, 9 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
index c1715d8ac..2e06d1809 100644
--- a/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
+++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
@@ -96,9 +96,6 @@ int main(int argc, char **argv)
 
 	tst_require_root();
 
-	if ((tst_kvercmp(3, 14, 0)) < 0)
-		tst_brkm(TCONF, NULL, "EDF needs kernel 3.14 or higher");
-
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		pthread_create(&thread, NULL, run_deadline, NULL);
 		pthread_join(thread, NULL);
diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
index 9f4a09f88..5efec2ff5 100644
--- a/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
+++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
@@ -101,8 +101,5 @@ void setup(void)
 {
 	unused_pid = tst_get_unused_pid(setup);
 
-	if ((tst_kvercmp(3, 14, 0)) < 0)
-		tst_brkm(TCONF, NULL, "EDF needs kernel 3.14 or higher");
-
 	TEST_PAUSE;
 }
diff --git a/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c b/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
index d5178e016..13380d177 100644
--- a/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
+++ b/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
@@ -130,8 +130,5 @@ void setup(void)
 
 	tst_require_root();
 
-	if ((tst_kvercmp(3, 14, 0)) < 0)
-		tst_brkm(TCONF, NULL, "EDF needs kernel 3.14 or higher");
-
 	TEST_PAUSE;
 }
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
