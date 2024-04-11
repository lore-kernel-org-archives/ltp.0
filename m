Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3026FC4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:35:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B8F33CF830
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:35:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24EB83CF820
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:34 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7DD2F1A0239C
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7FE5C5CD3C;
 Thu, 11 Apr 2024 14:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SD/C83GuKBHMap/12MvZryxnvjQBawwzB5+Hk87kut8=;
 b=Zy7/lCPsgHnIU7fsLYp1Y/0dlnyOZrolgGm8LjdgR2Nx6anNNCDQoFZdHb3XNfNcSZqbrN
 FuSAO0eXAAfDMwTyMFjQUWPn29kqZ3jKjWamEU2NUuhFxkSViK/thL6H9j/eTfOTe4uPmr
 ZfJvjwoILJpO1H19U0EXqPGjGlQk9ZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SD/C83GuKBHMap/12MvZryxnvjQBawwzB5+Hk87kut8=;
 b=aFBUBCgOkXsPyIzpOVsKXnQtlBWqB01xotXPqvGWL8T8+FXZZzHZwprfiBD78SLtceeoGG
 ExK+Xqu1q7oEaVCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SD/C83GuKBHMap/12MvZryxnvjQBawwzB5+Hk87kut8=;
 b=Zy7/lCPsgHnIU7fsLYp1Y/0dlnyOZrolgGm8LjdgR2Nx6anNNCDQoFZdHb3XNfNcSZqbrN
 FuSAO0eXAAfDMwTyMFjQUWPn29kqZ3jKjWamEU2NUuhFxkSViK/thL6H9j/eTfOTe4uPmr
 ZfJvjwoILJpO1H19U0EXqPGjGlQk9ZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SD/C83GuKBHMap/12MvZryxnvjQBawwzB5+Hk87kut8=;
 b=aFBUBCgOkXsPyIzpOVsKXnQtlBWqB01xotXPqvGWL8T8+FXZZzHZwprfiBD78SLtceeoGG
 ExK+Xqu1q7oEaVCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65AE41386D;
 Thu, 11 Apr 2024 14:30:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ENgOGAj0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:32 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:30:12 +0200
Message-ID: <20240411143025.352507-19-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 18/31] pipe: Remove UCLINUX
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
 testcases/kernel/syscalls/pipe/pipe02.c |  9 ---------
 testcases/kernel/syscalls/pipe/pipe04.c | 19 -------------------
 2 files changed, 28 deletions(-)

diff --git a/testcases/kernel/syscalls/pipe/pipe02.c b/testcases/kernel/syscalls/pipe/pipe02.c
index 2247037b1..d6cbff92d 100644
--- a/testcases/kernel/syscalls/pipe/pipe02.c
+++ b/testcases/kernel/syscalls/pipe/pipe02.c
@@ -41,10 +41,6 @@ static void verify_pipe(void)
 
 	memset(wrbuf, 'a', SIZE);
 
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "dd", &fd[0], &fd[1]);
-#endif
-
 	TEST(pipe(fd));
 	if (TST_RET == -1) {
 		tst_res(TFAIL|TTERRNO, "pipe() failed");
@@ -53,12 +49,7 @@ static void verify_pipe(void)
 
 	pid = SAFE_FORK();
 	if (pid == 0) {
-#ifdef UCLINUX
-		if (self_exec(av[0], "dd", fd[0], fd[1]) < 0)
-			tst_brk(TBROK, "self_exec failed");
-#else
 		do_child();
-#endif
 	}
 
 	memset(rdbuf, 0, SIZE);
diff --git a/testcases/kernel/syscalls/pipe/pipe04.c b/testcases/kernel/syscalls/pipe/pipe04.c
index 047fdb523..219daecd8 100644
--- a/testcases/kernel/syscalls/pipe/pipe04.c
+++ b/testcases/kernel/syscalls/pipe/pipe04.c
@@ -84,11 +84,6 @@ int main(int ac, char **av)
 	char rbuf[BUFSIZ];
 
 	tst_parse_opts(ac, av, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(&c1func, "ndd", 1, &fildes[0], &fildes[1]);
-	maybe_run_child(&c2func, "ndd", 2, &fildes[0], &fildes[1]);
-#endif
-
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -102,26 +97,12 @@ int main(int ac, char **av)
 			tst_brkm(TBROK, cleanup, "fork() failed - "
 				 "errno %d", errno);
 		if (c1pid == 0)
-#ifdef UCLINUX
-			if (self_exec(av[0], "ndd", 1, fildes[0], fildes[1]) <
-			    0) {
-				tst_brkm(TBROK, cleanup, "self_exec failed");
-			}
-#else
 			c1func();
-#endif
 		if ((c2pid = tst_fork()) == -1)
 			tst_brkm(TBROK, cleanup, "fork() failed - "
 				 "errno %d", errno);
 		if (c2pid == 0)
-#ifdef UCLINUX
-			if (self_exec(av[0], "ndd", 2, fildes[0], fildes[1]) <
-			    0) {
-				tst_brkm(TBROK, cleanup, "self_exec failed");
-			}
-#else
 			c2func();
-#endif
 
 		/* PARENT */
 		if (close(fildes[1]) == -1)
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
