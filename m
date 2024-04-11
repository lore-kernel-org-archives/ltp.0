Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08E8C4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:34:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62E553CF840
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:34:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0350F3CF822
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:34 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EEDD56230E8
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CC54F375AF;
 Thu, 11 Apr 2024 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lVX7+6EVkWvwbUhspH4efHC5uZ3H9/iH4TrZyCRMrKg=;
 b=pV0nM8k9Ro3cPrBgZL4dDCxOpNOtM3nUoSevaRKf5+lR3eXWshijEDMSlsl9t7bDLMH88G
 gcYMSKtDlI8tBDUZzfC8BuYzjgNqEnCGd6u9RrMPyuOBm7cnJDik5mshw7m2KTwq04/Q6V
 w11u0aZt1NlRAjg7YIOzGx7knbVxCbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lVX7+6EVkWvwbUhspH4efHC5uZ3H9/iH4TrZyCRMrKg=;
 b=5/iOFdr0zG+IquIKuOek65J/rpO54dgj2B69g1oWuKdAdeMRhlgSfE5zC5bMLBi64L/Zpe
 ENBKrGW05Rt7OxDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lVX7+6EVkWvwbUhspH4efHC5uZ3H9/iH4TrZyCRMrKg=;
 b=pV0nM8k9Ro3cPrBgZL4dDCxOpNOtM3nUoSevaRKf5+lR3eXWshijEDMSlsl9t7bDLMH88G
 gcYMSKtDlI8tBDUZzfC8BuYzjgNqEnCGd6u9RrMPyuOBm7cnJDik5mshw7m2KTwq04/Q6V
 w11u0aZt1NlRAjg7YIOzGx7knbVxCbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lVX7+6EVkWvwbUhspH4efHC5uZ3H9/iH4TrZyCRMrKg=;
 b=5/iOFdr0zG+IquIKuOek65J/rpO54dgj2B69g1oWuKdAdeMRhlgSfE5zC5bMLBi64L/Zpe
 ENBKrGW05Rt7OxDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF6E51386E;
 Thu, 11 Apr 2024 14:30:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MIWoKQf0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:31 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:30:07 +0200
Message-ID: <20240411143025.352507-14-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 13/31] kill: Remove UCLINUX
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
 testcases/kernel/syscalls/kill/kill02.c | 93 +------------------------
 testcases/kernel/syscalls/kill/kill07.c | 10 ---
 testcases/kernel/syscalls/kill/kill08.c | 11 ---
 testcases/kernel/syscalls/kill/kill09.c | 11 ---
 4 files changed, 1 insertion(+), 124 deletions(-)

diff --git a/testcases/kernel/syscalls/kill/kill02.c b/testcases/kernel/syscalls/kill/kill02.c
index 21aacffa1..776540b4e 100644
--- a/testcases/kernel/syscalls/kill/kill02.c
+++ b/testcases/kernel/syscalls/kill/kill02.c
@@ -203,28 +203,12 @@ void cleanup();
 char *TCID = "kill02";
 int TST_TOTAL = 2;
 
-#ifdef UCLINUX
-static char *argv0;
-void childA_rout_uclinux();
-void childB_rout_uclinux();
-#endif
-
 int main(int ac, char **av)
 {
 	int lc;
 
 	tst_parse_opts(ac, av, NULL, NULL);
 
-#ifdef UCLINUX
-	argv0 = av[0];
-
-	maybe_run_child(&childA_rout_uclinux, "nd", 1, &pipeA_fd[1]);
-	maybe_run_child(&childB_rout_uclinux, "nd", 2, &pipeB_fd[1]);
-	maybe_run_child(&child1_rout, "ndddddd", 3, &pipe1_fd[1], &pipe2_fd[1],
-			&pipeA_fd[0], &pipeA_fd[1], &pipeB_fd[0], &pipeB_fd[1]);
-	maybe_run_child(&child2_rout, "nd", 4, &pipe2_fd[1]);
-#endif
-
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -235,19 +219,7 @@ int main(int ac, char **av)
 			if ((pid2 = tst_fork()) > 0) {
 				(void)parent_rout();
 			} else if (pid2 == 0) {
-#ifdef UCLINUX
-				if (self_exec(argv0, "nd", 4, pipe2_fd[1]) < 0) {
-					if (kill(pid1, SIGKILL) == -1
-					    && errno != ESRCH) {
-						tst_resm(TWARN,
-							 "Child process may not have been killed.");
-					}
-					tst_brkm(TBROK | TERRNO, cleanup,
-						 "fork failed");
-				}
-#else
 				(void)child2_rout();
-#endif
 			} else {
 				/*
 				 *  The second fork failed kill the first child.
@@ -264,17 +236,7 @@ int main(int ac, char **av)
 			/*
 			 *  This is child 1.
 			 */
-#ifdef UCLINUX
-			if (self_exec
-			    (argv0, "ndddddd", 3, pipe1_fd[1], pipe2_fd[1],
-			     pipeA_fd[0], pipeA_fd[1], pipeB_fd[0],
-			     pipeB_fd[1]) < 0) {
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "self_exec() failed");
-			}
-#else
 			(void)child1_rout();
-#endif
 		} else {
 			/*
 			 * Fork failed.
@@ -456,18 +418,10 @@ void child1_rout(void)
 		/*
 		 *  This is the parent(child1), fork again to create child B.
 		 */
+
 		if ((pidB = tst_fork()) == 0) {
 			/* This is child B. */
-#ifdef UCLINUX
-			if (self_exec(argv0, "nd", 2, pipeB_fd[1]) < 0) {
-				tst_brkm(TBROK | TERRNO, NULL,
-					 "self_exec() failed");
-				(void)write(pipe1_fd[1], CHAR_SET_FAILED, 1);
-				exit(0);
-			}
-#else
 			(void)childB_rout();
-#endif
 		}
 
 		else if (pidB == -1) {
@@ -485,16 +439,7 @@ void child1_rout(void)
 
 	else if (pidA == 0) {
 		/* This is child A. */
-#ifdef UCLINUX
-		if (self_exec(argv0, "nd", 1, pipeA_fd[1]) < 0) {
-			tst_brkm(TBROK | TERRNO, NULL, "self_exec() failed");
-			(void)write(pipe1_fd[1], CHAR_SET_FAILED, 1);
-			exit(0);
-		}
-#else
 		(void)childA_rout();
-#endif
-
 	}
 
 	else if (pidA == -1) {
@@ -625,24 +570,6 @@ void childA_rout(void)
 	exit(0);
 }				/*End of childA_rout */
 
-#ifdef UCLINUX
-/*******************************************************************************
- *  This is the routine for child A after self_exec
- ******************************************************************************/
-void childA_rout_uclinux(void)
-{
-	/* Setup the signal handler again */
-	if (signal(SIGUSR1, usr1_rout) == SIG_ERR) {
-		tst_brkm(TBROK, NULL,
-			 "Could not set to catch the childrens signal.");
-		(void)write(pipeA_fd[1], CHAR_SET_FAILED, 1);
-		exit(0);
-	}
-
-	childA_rout();
-}
-#endif
-
 /*******************************************************************************
  *  This is the routine for child B, which should not receive the parents signal.
  ******************************************************************************/
@@ -667,24 +594,6 @@ void childB_rout(void)
 	exit(0);
 }
 
-#ifdef UCLINUX
-/*******************************************************************************
- *  This is the routine for child B after self_exec
- ******************************************************************************/
-void childB_rout_uclinux(void)
-{
-	/* Setup the signal handler again */
-	if (signal(SIGUSR1, usr1_rout) == SIG_ERR) {
-		tst_brkm(TBROK, NULL,
-			 "Could not set to catch the childrens signal.");
-		(void)write(pipeB_fd[1], CHAR_SET_FAILED, 1);
-		exit(0);
-	}
-
-	childB_rout();
-}
-#endif
-
 /*******************************************************************************
  *  This routine sets up the interprocess communication pipes, signal handling,
  *  and process group information.
diff --git a/testcases/kernel/syscalls/kill/kill07.c b/testcases/kernel/syscalls/kill/kill07.c
index 21dd7ff4f..ac4ebd941 100644
--- a/testcases/kernel/syscalls/kill/kill07.c
+++ b/testcases/kernel/syscalls/kill/kill07.c
@@ -91,9 +91,6 @@ int main(int ac, char **av)
 	struct sigaction my_act, old_act;
 
 	tst_parse_opts(ac, av, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "");
-#endif
 
 	setup();		/* global setup */
 
@@ -128,14 +125,7 @@ int main(int ac, char **av)
 		if (pid < 0) {
 			tst_brkm(TBROK, cleanup, "Fork of child failed");
 		} else if (pid == 0) {
-#ifdef UCLINUX
-			if (self_exec(av[0], "") < 0) {
-				tst_brkm(TBROK, cleanup,
-					 "self_exec of child failed");
-			}
-#else
 			do_child();
-#endif
 		} else {
 			/* sighandler should not catch this signal */
 			/* if it does flag will be set to 1 */
diff --git a/testcases/kernel/syscalls/kill/kill08.c b/testcases/kernel/syscalls/kill/kill08.c
index d75a4db46..9302f5470 100644
--- a/testcases/kernel/syscalls/kill/kill08.c
+++ b/testcases/kernel/syscalls/kill/kill08.c
@@ -78,9 +78,6 @@ int main(int ac, char **av)
 	int exno, status, nsig, i;
 
 	tst_parse_opts(ac, av, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "");
-#endif
 
 	setup();		/* global setup */
 
@@ -105,15 +102,7 @@ int main(int ac, char **av)
 				if (pid2 < 0) {
 					tst_brkm(TBROK, cleanup, "Fork failed");
 				} else if (pid2 == 0) {
-#ifdef UCLINUX
-					if (self_exec(av[0], "") < 0) {
-						tst_brkm(TBROK, cleanup,
-							 "self_exec of "
-							 "child failed");
-					}
-#else
 					do_child();
-#endif
 				}
 			}
 			/* Kill all processes in this process group */
diff --git a/testcases/kernel/syscalls/kill/kill09.c b/testcases/kernel/syscalls/kill/kill09.c
index ad93c5d81..c0b703119 100644
--- a/testcases/kernel/syscalls/kill/kill09.c
+++ b/testcases/kernel/syscalls/kill/kill09.c
@@ -135,10 +135,6 @@ int main(int ac, char **av)
 
 	tst_parse_opts(ac, av, NULL, NULL);
 
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "");
-#endif
-
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -149,14 +145,7 @@ int main(int ac, char **av)
 			tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
 
 		if (fork_pid == 0) {
-#ifdef UCLINUX
-			if (self_exec(av[0], "") < 0) {
-				tst_brkm(TBROK, cleanup,
-					 "self_exec of child failed");
-			}
-#else
 			do_child();
-#endif
 		}
 
 		TEST(kill(fork_pid, SIGKILL));
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
