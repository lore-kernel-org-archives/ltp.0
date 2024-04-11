Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32275C4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:36:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B44693CF826
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:36:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 863263CF82C
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:34 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A36E0100118F
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9D058375B1;
 Thu, 11 Apr 2024 14:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NolSkLhHsH4HzO8RKR0jCTARfny2W50e1+RhmVv8D80=;
 b=JSmOd4aDJ4LkrxK2eXCoy1+D011JNRD3mrPwdAePDhRax5X+Ui4JmlqpdNuqS1moMcBKFS
 8wZAgJdqXAuYMp6cXOJJ7gvCWJ1AOH6T83EKRZZZI8by3smvCk/1+krplBDlBfz9BcEdqE
 /crQw5Vaefyx7Y2KLTs7oOBu7QnPDeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NolSkLhHsH4HzO8RKR0jCTARfny2W50e1+RhmVv8D80=;
 b=8YfrqGGxpj6UJHJKDPMGpBxd2Oks8OVNW32P12jATsZ67CHrmiyjE5EAmQ4SPO+86Q/2zE
 7S5IIrCLM26YvGAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JSmOd4aD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8YfrqGGx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NolSkLhHsH4HzO8RKR0jCTARfny2W50e1+RhmVv8D80=;
 b=JSmOd4aDJ4LkrxK2eXCoy1+D011JNRD3mrPwdAePDhRax5X+Ui4JmlqpdNuqS1moMcBKFS
 8wZAgJdqXAuYMp6cXOJJ7gvCWJ1AOH6T83EKRZZZI8by3smvCk/1+krplBDlBfz9BcEdqE
 /crQw5Vaefyx7Y2KLTs7oOBu7QnPDeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NolSkLhHsH4HzO8RKR0jCTARfny2W50e1+RhmVv8D80=;
 b=8YfrqGGxpj6UJHJKDPMGpBxd2Oks8OVNW32P12jATsZ67CHrmiyjE5EAmQ4SPO+86Q/2zE
 7S5IIrCLM26YvGAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8322C1386E;
 Thu, 11 Apr 2024 14:30:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wEcaHwj0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:32 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:30:13 +0200
Message-ID: <20240411143025.352507-20-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9D058375B1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.00 / 50.00]; BAYES_HAM(-2.99)[99.94%];
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 19/31] pause: Remove UCLINUX
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
 testcases/kernel/syscalls/pause/pause02.c |  9 ---------
 testcases/kernel/syscalls/pause/pause03.c | 11 +----------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/pause/pause02.c b/testcases/kernel/syscalls/pause/pause02.c
index 335bb3b35..0853232fd 100644
--- a/testcases/kernel/syscalls/pause/pause02.c
+++ b/testcases/kernel/syscalls/pause/pause02.c
@@ -45,10 +45,6 @@ int main(int ac, char **av)
 
 	tst_parse_opts(ac, av, NULL, NULL);
 
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "");
-#endif
-
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -60,12 +56,7 @@ int main(int ac, char **av)
 			tst_brkm(TBROK, cleanup, "fork() failed");
 		break;
 		case 0:
-#ifdef UCLINUX
-			if (self_exec(av[0], "") < 0)
-				tst_brkm(TBROK, cleanup, "self_exec failed");
-#else
 			do_child();
-#endif
 		break;
 		default:
 		break;
diff --git a/testcases/kernel/syscalls/pause/pause03.c b/testcases/kernel/syscalls/pause/pause03.c
index 4c30d9614..459222045 100644
--- a/testcases/kernel/syscalls/pause/pause03.c
+++ b/testcases/kernel/syscalls/pause/pause03.c
@@ -44,9 +44,6 @@ int main(int ac, char **av)
 	int status;
 
 	tst_parse_opts(ac, av, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "");
-#endif
 
 	setup();
 
@@ -56,14 +53,8 @@ int main(int ac, char **av)
 		if ((cpid = tst_fork()) == -1)
 			tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
 
-		if (cpid == 0) {
-#ifdef UCLINUX
-			if (self_exec(av[0], "") < 0)
-				tst_brkm(TBROK, cleanup, "self_exec failed");
-#else
+		if (cpid == 0)
 			do_child();
-#endif
-		}
 
 		TST_PROCESS_STATE_WAIT(cleanup, cpid, 'S');
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
