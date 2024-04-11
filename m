Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64D9C4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:38:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74E8F3CF860
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:38:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35EC13CF7D5
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:35 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 07A50140872D
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8A31E375AA;
 Thu, 11 Apr 2024 14:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNNPHZhaYu6+DDerBqwNcyRHUzGSDjY30xsfIP5ByBk=;
 b=FL+Rkj7DtbjkhyjYA22NFVc2OWoBiBXxn1flQZt8CEylHYFTLO36QJ+O0Tow8dx5aKTyBQ
 ERwPZWjr4J2gmWtDRgvXTq6zw8OaWn4ltlTLs/lPMOz8Efiopm5NKqnklEN70yhRUwQGct
 Vc+RdE282U2Psr2gPWQTXHuTryUDEoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845833;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNNPHZhaYu6+DDerBqwNcyRHUzGSDjY30xsfIP5ByBk=;
 b=i9TYSTEzk+jZq4mck49mg7h5kJOtbGiqm8ENE6dumkP39TvYkl6D2LlFO99wakMrLogu2X
 +N2iWoK3LZH74NCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FL+Rkj7D;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=i9TYSTEz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNNPHZhaYu6+DDerBqwNcyRHUzGSDjY30xsfIP5ByBk=;
 b=FL+Rkj7DtbjkhyjYA22NFVc2OWoBiBXxn1flQZt8CEylHYFTLO36QJ+O0Tow8dx5aKTyBQ
 ERwPZWjr4J2gmWtDRgvXTq6zw8OaWn4ltlTLs/lPMOz8Efiopm5NKqnklEN70yhRUwQGct
 Vc+RdE282U2Psr2gPWQTXHuTryUDEoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845833;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNNPHZhaYu6+DDerBqwNcyRHUzGSDjY30xsfIP5ByBk=;
 b=i9TYSTEzk+jZq4mck49mg7h5kJOtbGiqm8ENE6dumkP39TvYkl6D2LlFO99wakMrLogu2X
 +N2iWoK3LZH74NCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B5491386E;
 Thu, 11 Apr 2024 14:30:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OHwyGQn0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:33 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:30:19 +0200
Message-ID: <20240411143025.352507-26-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8A31E375AA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.64 / 50.00]; BAYES_HAM(-2.63)[98.35%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 25/31] setsid01: Remove UCLINUX
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
 testcases/kernel/syscalls/setsid/setsid01.c | 23 ---------------------
 1 file changed, 23 deletions(-)

diff --git a/testcases/kernel/syscalls/setsid/setsid01.c b/testcases/kernel/syscalls/setsid/setsid01.c
index 5df2c1ff4..197e865cb 100644
--- a/testcases/kernel/syscalls/setsid/setsid01.c
+++ b/testcases/kernel/syscalls/setsid/setsid01.c
@@ -49,10 +49,6 @@
 char *TCID = "setsid01";
 int TST_TOTAL = 1;
 
-#ifdef UCLINUX
-static char *argv0;
-#endif
-
 void do_child_1(void);
 void do_child_2(void);
 void setup(void);
@@ -68,12 +64,6 @@ int main(int ac, char **av)
 	int lc;
 
 	tst_parse_opts(ac, av, NULL, NULL);
-#ifdef UCLINUX
-	argv0 = av[0];
-
-	maybe_run_child(&do_child_1, "n", 1);
-	maybe_run_child(&do_child_2, "n", 2);
-#endif
 
 	/*
 	 * perform global setup for the test
@@ -98,14 +88,7 @@ int main(int ac, char **av)
 
 			}
 			if (pid == 0) {
-#ifdef UCLINUX
-				if (self_exec(argv0, "n", 1) < 0) {
-					tst_resm(TFAIL, "self_exec failed");
-
-				}
-#else
 				do_child_1();
-#endif
 			} else {
 				if (setpgid(0, 0) < 0) {
 					tst_resm(TFAIL,
@@ -165,13 +148,7 @@ void do_child_1(void)
 		tst_brkm(TFAIL, NULL, "Fork failed");
 	}
 	if (pid == 0) {
-#ifdef UCLINUX
-		if (self_exec(argv0, "n", 2) < 0) {
-			tst_brkm(TFAIL, NULL, "self_exec failed");
-		}
-#else
 		do_child_2();
-#endif
 	} else {
 		retval = setpgid(0, getppid());
 		if (retval < 0) {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
