Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758F2C4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:33:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A4603CF84C
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:33:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C3F13CF800
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:33 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8C4F06126EE
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 839A4375AD;
 Thu, 11 Apr 2024 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHeOqDREtbdJFWMmClejc06mAOTC9+z1Fl9QDH33crI=;
 b=ab6v1yqHci1hWXIgOXgxs3QDzAWdtXshl7xsqiARsIDy+ky6I/D4qt+RDQpDumbQXX+MR/
 5kELtIHBghij7dSB7pMl2BKifIEar0Ja58Y7t6fxXOo0M2ci3YcwTnyVxNFCPcko9p2HSP
 cHLCWGUPKI/lWIjxQVwW/KMkUsz0Gj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHeOqDREtbdJFWMmClejc06mAOTC9+z1Fl9QDH33crI=;
 b=EYswfls7NBUXighvD9+zFrX2Of8iz6ERTmzM3ScLXnvLRoshux8bBpi/jcaoAIFaLuTFjq
 dM0dKvwAtPDR8gCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHeOqDREtbdJFWMmClejc06mAOTC9+z1Fl9QDH33crI=;
 b=ab6v1yqHci1hWXIgOXgxs3QDzAWdtXshl7xsqiARsIDy+ky6I/D4qt+RDQpDumbQXX+MR/
 5kELtIHBghij7dSB7pMl2BKifIEar0Ja58Y7t6fxXOo0M2ci3YcwTnyVxNFCPcko9p2HSP
 cHLCWGUPKI/lWIjxQVwW/KMkUsz0Gj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHeOqDREtbdJFWMmClejc06mAOTC9+z1Fl9QDH33crI=;
 b=EYswfls7NBUXighvD9+zFrX2Of8iz6ERTmzM3ScLXnvLRoshux8bBpi/jcaoAIFaLuTFjq
 dM0dKvwAtPDR8gCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6007A1386E;
 Thu, 11 Apr 2024 14:30:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uDtuFgf0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:31 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:30:05 +0200
Message-ID: <20240411143025.352507-12-pvorel@suse.cz>
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 11/31] fcntl: Remove UCLINUX
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
 testcases/kernel/syscalls/fcntl/fcntl11.c | 16 +-----
 testcases/kernel/syscalls/fcntl/fcntl14.c | 50 ++-----------------
 testcases/kernel/syscalls/fcntl/fcntl16.c | 29 +----------
 testcases/kernel/syscalls/fcntl/fcntl17.c | 59 ++---------------------
 testcases/kernel/syscalls/fcntl/fcntl18.c | 10 ----
 testcases/kernel/syscalls/fcntl/fcntl19.c | 13 -----
 testcases/kernel/syscalls/fcntl/fcntl20.c | 16 +-----
 testcases/kernel/syscalls/fcntl/fcntl21.c | 18 +------
 8 files changed, 14 insertions(+), 197 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl11.c b/testcases/kernel/syscalls/fcntl/fcntl11.c
index 2ad3aee5e..4fd9fcca9 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl11.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl11.c
@@ -245,10 +245,6 @@ int main(int ac, char **av)
 	int lc;
 
 	tst_parse_opts(ac, av, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "ddddd", &parent_pipe[0],
-			&parent_pipe[1], &child_pipe[0], &child_pipe[1], &fd);
-#endif
 
 	setup();		/* global setup */
 
@@ -257,17 +253,9 @@ int main(int ac, char **av)
 		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		if ((child_pid = tst_fork()) == 0) {	/* parent */
-#ifdef UCLINUX
-			if (self_exec(av[0], "ddddd", parent_pipe[0],
-				      parent_pipe[1], child_pipe[0],
-				      child_pipe[1], fd) < 0)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "self_exec failed");
-#else
+		if ((child_pid = tst_fork()) == 0) /* parent */
 			do_child();
-#endif
-		} else if (child_pid == -1)
+		else if (child_pid == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
 
 		SAFE_CLOSE(cleanup, parent_pipe[0]);
diff --git a/testcases/kernel/syscalls/fcntl/fcntl14.c b/testcases/kernel/syscalls/fcntl/fcntl14.c
index 09f5f0954..d38220951 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl14.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl14.c
@@ -547,10 +547,6 @@ char *TCID = "fcntl14";
 int TST_TOTAL = 1;
 int NO_NFS = 1;
 
-#ifdef UCLINUX
-static char *argv0;
-#endif
-
 void cleanup(void)
 {
 	tst_rmdir();
@@ -745,14 +741,7 @@ void dochild(void)
 			fail = 1;
 			break;
 		case 0:
-#ifdef UCLINUX
-			if (self_exec(argv0, "nd", 1, parent) < 0) {
-				tst_resm(TFAIL, "self_exec failed");
-				break;
-			}
-#else
 			do_usleep_child();
-#endif
 			break;
 
 		default:
@@ -828,19 +817,9 @@ void run_test(int file_flag, int file_mode, int seek, int start, int end)
 		/* flush the stdout to avoid garbled output */
 		fflush(stdout);
 
-		if ((child = tst_fork()) == 0) {
-#ifdef UCLINUX
-			if (self_exec(argv0, "nddddddddd", 2, thiscase->c_type,
-				      thiscase->c_whence, thiscase->c_start,
-				      thiscase->c_len, thiscase->c_flag,
-				      thiscase->a_type, fd, test, parent) < 0) {
-				tst_resm(TFAIL, "self_exec failed");
-				cleanup();
-			}
-#else
+		if ((child = tst_fork()) == 0)
 			dochild();
-#endif
-		}
+
 		if (child < 0)
 			tst_brkm(TBROK|TERRNO, cleanup, "Fork failed");
 
@@ -943,17 +922,6 @@ int main(int ac, char **av)
 	int lc;
 
 	tst_parse_opts(ac, av, NULL, NULL);
-#ifdef UCLINUX
-	argv0 = av[0];
-
-	maybe_run_child(&do_usleep_child, "nd", 1, &parent);
-	thiscase = malloc(sizeof(testcase));
-
-	maybe_run_child(&dochild, "nddddddddd", 2, &thiscase->c_type,
-			&thiscase->c_whence, &thiscase->c_start,
-			&thiscase->c_len, &thiscase->c_flag, &thiscase->a_type,
-			&fd, &test, &parent);
-#endif
 
 	setup();
 
@@ -1079,19 +1047,9 @@ int main(int ac, char **av)
 		if (sighold(SIGUSR1) < 0)
 			tst_brkm(TBROK, cleanup, "sighold failed");
 
-		if ((child = tst_fork()) == 0) {
-#ifdef UCLINUX
-			if (self_exec(argv0, "nddddddddd", 2, thiscase->c_type,
-				      thiscase->c_whence, thiscase->c_start,
-				      thiscase->c_len, thiscase->c_flag,
-				      thiscase->a_type, fd, test, parent) < 0) {
-				tst_resm(TFAIL, "self_exec failed");
-				cleanup();
-			}
-#else
+		if ((child = tst_fork()) == 0)
 			dochild();
-#endif
-		}
+
 		if (child < 0)
 			tst_brkm(TBROK|TERRNO, cleanup, "Fork failed");
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl16.c b/testcases/kernel/syscalls/fcntl/fcntl16.c
index 2d895edd2..4ae9e6e7a 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl16.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl16.c
@@ -279,10 +279,6 @@ extern void catch_int(int sig);	/* signal catching subroutine */
 char *TCID = "fcntl16";
 int TST_TOTAL = 1;
 
-#ifdef UCLINUX
-static char *argv0;
-#endif
-
 /*
  * cleanup - performs all the ONE TIME cleanup for this test at completion or
  *	premature exit
@@ -339,15 +335,6 @@ void dochild(int kid)
 	exit(0);
 }				/* end of child process */
 
-#ifdef UCLINUX
-static int kid_uc;
-
-void dochild_uc(void)
-{
-	dochild(kid_uc);
-}
-#endif
-
 void catch_alarm(int sig)
 {
 	alarm_flag = 1;
@@ -497,17 +484,8 @@ int run_test(int file_flag, int file_mode, int start, int end)
 		/* spawn child processes */
 		for (i = 0; i < 2; i++) {
 			if (thislock->l_type != IGNORED) {
-				if ((child = tst_fork()) == 0) {
-#ifdef UCLINUX
-					if (self_exec(argv0, "ddddd", i, parent,
-						      test, thislock, fd) < 0) {
-						perror("self_exec failed");
-						return 1;
-					}
-#else
+				if ((child = tst_fork()) == 0)
 					dochild(i);
-#endif
-				}
 				if (child < 0) {
 					perror("Fork failed");
 					return 1;
@@ -654,11 +632,6 @@ int main(int ac, char **av)
 	int lc;
 
 	tst_parse_opts(ac, av, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(dochild_uc, "ddddd", &kid_uc, &parent, &test,
-			&thislock, &fd);
-	argv0 = av[0];
-#endif
 
 	setup();		/* global setup */
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl17.c b/testcases/kernel/syscalls/fcntl/fcntl17.c
index 35769579f..5a52f0af3 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl17.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl17.c
@@ -438,23 +438,6 @@ int main(int ac, char **av)
 	int fail = 0;
 
 	tst_parse_opts(ac, av, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(&do_child1, "nddddddddd", 1, &file_fd,
-			&parent_pipe[0], &parent_pipe[1],
-			&child_pipe1[0], &child_pipe1[1],
-			&child_pipe2[0], &child_pipe2[1],
-			&child_pipe3[0], &child_pipe3[1]);
-	maybe_run_child(&do_child2, "nddddddddd", 2, &file_fd,
-			&parent_pipe[0], &parent_pipe[1],
-			&child_pipe1[0], &child_pipe1[1],
-			&child_pipe2[0], &child_pipe2[1],
-			&child_pipe3[0], &child_pipe3[1]);
-	maybe_run_child(&do_child3, "nddddddddd", 3, &file_fd,
-			&parent_pipe[0], &parent_pipe[1],
-			&child_pipe1[0], &child_pipe1[1],
-			&child_pipe2[0], &child_pipe2[1],
-			&child_pipe3[0], &child_pipe3[1]);
-#endif
 
 	if (setup()) {		/* global testup */
 		tst_resm(TINFO, "setup failed");
@@ -467,56 +450,22 @@ int main(int ac, char **av)
 		tst_count = 0;
 
 		tst_resm(TINFO, "Enter preparation phase");
-		if ((child_pid1 = tst_fork()) == 0) {	/* first child */
-#ifdef UCLINUX
-			if (self_exec(av[0], "nddddddddd", 1, file_fd,
-				      parent_pipe[0], parent_pipe[1],
-				      child_pipe1[0], child_pipe1[1],
-				      child_pipe2[0], child_pipe2[1],
-				      child_pipe3[0], child_pipe3[1]) < 0) {
-				perror("self_exec failed, child 1");
-				cleanup();
-			}
-#else
+		if ((child_pid1 = tst_fork()) == 0)	/* first child */
 			do_child1();
-#endif
-		} else if (child_pid1 < 0)
+		else if (child_pid1 < 0)
 			tst_brkm(TBROK|TERRNO, cleanup, "Fork failed: child 1");
 
 		/* parent */
 
-		if ((child_pid2 = fork()) == 0) {	/* second child */
-#ifdef UCLINUX
-			if (self_exec(av[0], "nddddddddd", 2, file_fd,
-				      parent_pipe[0], parent_pipe[1],
-				      child_pipe1[0], child_pipe1[1],
-				      child_pipe2[0], child_pipe2[1],
-				      child_pipe3[0], child_pipe3[1]) < 0) {
-				perror("self_exec failed, child 2");
-				cleanup();
-			}
-#else
+		if ((child_pid2 = fork()) == 0)	/* second child */
 			do_child2();
-#endif
-		} else if (child_pid2 < 0) {
+		else if (child_pid2 < 0)
 			tst_brkm(TBROK|TERRNO, cleanup, "Fork failed: child 2");
-		}
 
 		/* parent */
 
 		if ((child_pid3 = fork()) == 0) {	/* third child */
-#ifdef UCLINUX
-			if (self_exec(av[0], "nddddddddd", 3, file_fd,
-				      parent_pipe[0], parent_pipe[1],
-				      child_pipe1[0], child_pipe1[1],
-				      child_pipe2[0], child_pipe2[1],
-				      child_pipe3[0], child_pipe3[1]) < 0) {
-				perror("self_exec failed, child 3");
-				cleanup();
-			}
-#else
 			do_child3();
-#endif
 			do_child3();
 		} else if (child_pid3 < 0) {
 			tst_brkm(TBROK|TERRNO, cleanup, "Fork failed: child 3");
diff --git a/testcases/kernel/syscalls/fcntl/fcntl18.c b/testcases/kernel/syscalls/fcntl/fcntl18.c
index 6bf39b981..7a26f65a2 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl18.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl18.c
@@ -70,8 +70,6 @@ int main(int ac, char **av)
 	setup();		/* global setup */
 
 /* //block1: */
-#ifndef UCLINUX
-	/* Skip since uClinux does not implement memory protection */
 	tst_resm(TINFO, "Enter block 1");
 	fail = 0;
 	if ((fd = open("temp.dat", O_CREAT | O_RDWR, 0777)) < 0) {	//mode must be specified when O_CREATE is in the flag
@@ -93,13 +91,8 @@ int main(int ac, char **av)
 		tst_resm(TINFO, "Block 1 PASSED");
 	}
 	tst_resm(TINFO, "Exit block 1");
-#else
-	tst_resm(TINFO, "Skip block 1 on uClinux");
-#endif
 
 /* //block2: */
-#ifndef UCLINUX
-	/* Skip since uClinux does not implement memory protection */
 	tst_resm(TINFO, "Enter block 2");
 	fail = 0;
 	/* Error condition if address is bad */
@@ -116,9 +109,6 @@ int main(int ac, char **av)
 		tst_resm(TINFO, "Block 2 PASSED");
 	}
 	tst_resm(TINFO, "Exit block 2");
-#else
-	tst_resm(TINFO, "Skip block 2 on uClinux");
-#endif
 
 /* //block3: */
 	tst_resm(TINFO, "Enter block 3");
diff --git a/testcases/kernel/syscalls/fcntl/fcntl19.c b/testcases/kernel/syscalls/fcntl/fcntl19.c
index 368629d25..a58e921c3 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl19.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl19.c
@@ -284,10 +284,6 @@ int main(int ac, char **av)
 	int lc;
 
 	tst_parse_opts(ac, av, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "ddddd", &parent_pipe[0], &parent_pipe[1],
-			&child_pipe[0], &child_pipe[1], &fd);
-#endif
 
 	setup();		/* global setup */
 
@@ -297,16 +293,7 @@ int main(int ac, char **av)
 		tst_count = 0;
 
 		if ((child_pid = tst_fork()) == 0) {	/* child */
-#ifdef UCLINUX
-			if (self_exec
-			    (av[0], "ddddd", parent_pipe[0], parent_pipe[1],
-			     child_pipe[0], child_pipe[1], fd) < 0) {
-				tst_resm(TFAIL, "self_exec failed");
-				cleanup();
-			}
-#else
 			do_child();
-#endif
 		} else if (child_pid < 0) {
 			tst_resm(TFAIL, "Fork failed");
 			cleanup();
diff --git a/testcases/kernel/syscalls/fcntl/fcntl20.c b/testcases/kernel/syscalls/fcntl/fcntl20.c
index 0865140de..f271eeb2d 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl20.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl20.c
@@ -283,10 +283,6 @@ int main(int ac, char **av)
 	int lc;
 
 	tst_parse_opts(ac, av, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "ddddd", &parent_pipe[0], &parent_pipe[1],
-			&child_pipe[0], &child_pipe[1], &fd);
-#endif
 
 	setup();		/* global setup */
 
@@ -295,18 +291,8 @@ int main(int ac, char **av)
 		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		if ((child_pid = tst_fork()) == 0) {	/* child */
-#ifdef UCLINUX
-			if (self_exec
-			    (av[0], "ddddd", parent_pipe[0], parent_pipe[1],
-			     child_pipe[0], child_pipe[1], fd) < 0) {
-				tst_resm(TFAIL, "self_exec failed");
-				cleanup();
-			}
-#else
+		if ((child_pid = tst_fork()) == 0)	/* child */
 			do_child();
-#endif
-		}
 
 		if (child_pid < 0) {
 			tst_resm(TFAIL, "Fork failed");
diff --git a/testcases/kernel/syscalls/fcntl/fcntl21.c b/testcases/kernel/syscalls/fcntl/fcntl21.c
index d191a6bbd..a262ae8dd 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl21.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl21.c
@@ -291,11 +291,6 @@ int main(int ac, char **av)
 	int lc;
 
 	tst_parse_opts(ac, av, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "ddddd", &parent_pipe[0], &parent_pipe[1],
-			&child_pipe[0], &child_pipe[1], &fd);
-#endif
-
 	setup();		/* global setup */
 
 	/* Check for looping state if -i option is given */
@@ -303,18 +298,9 @@ int main(int ac, char **av)
 		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		if ((child_pid = tst_fork()) == 0) {
-#ifdef UCLINUX
-			if (self_exec
-			    (av[0], "ddddd", parent_pipe[0], parent_pipe[1],
-			     child_pipe[0], child_pipe[1], fd) < 0) {
-				tst_resm(TFAIL, "self_exec failed");
-				cleanup();
-			}
-#else
+		if ((child_pid = tst_fork()) == 0)
 			do_child();
-#endif
-		}
+
 		if (child_pid < 0) {
 			tst_resm(TFAIL, "Fork failed");
 			cleanup();
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
