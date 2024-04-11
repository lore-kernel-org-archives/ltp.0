Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE38C4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:35:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D7AA3CF82E
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:35:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 204943CF826
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:33 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 38E441408721
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C0085375A8;
 Thu, 11 Apr 2024 14:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2i1qKjdWB54MiFme3nRUKrLnribKYndwxD5QMPZURE=;
 b=Xup+UBFzAddYSPZJIPAdXSDenckOODU2DxN25PJqpjbzFb0KfXtFAJY129cOC29m0HYTiT
 vA337iAo9JjJ5S+NGK3Fa1LUy9mQKzyqgObtE+D1fkXfA8d4ACkbj78gLJdmnPQXp/hKvc
 BwVD5FcJrIz2zp2SltO5LWRO4eYQpys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2i1qKjdWB54MiFme3nRUKrLnribKYndwxD5QMPZURE=;
 b=v1gC6L8AUMwbe0abL7j6/ar3y6y3QJqna70qz3tgorczV+N0VY1TZbf8+ggGMxfD1ydle9
 sPLBjB9t1nEtOBAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2i1qKjdWB54MiFme3nRUKrLnribKYndwxD5QMPZURE=;
 b=Xup+UBFzAddYSPZJIPAdXSDenckOODU2DxN25PJqpjbzFb0KfXtFAJY129cOC29m0HYTiT
 vA337iAo9JjJ5S+NGK3Fa1LUy9mQKzyqgObtE+D1fkXfA8d4ACkbj78gLJdmnPQXp/hKvc
 BwVD5FcJrIz2zp2SltO5LWRO4eYQpys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2i1qKjdWB54MiFme3nRUKrLnribKYndwxD5QMPZURE=;
 b=v1gC6L8AUMwbe0abL7j6/ar3y6y3QJqna70qz3tgorczV+N0VY1TZbf8+ggGMxfD1ydle9
 sPLBjB9t1nEtOBAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A271E1386D;
 Thu, 11 Apr 2024 14:30:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AMHbJgj0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:32 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:30:14 +0200
Message-ID: <20240411143025.352507-21-pvorel@suse.cz>
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 20/31] recv*: Remove UCLINUX
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
 testcases/kernel/syscalls/recv/recv01.c         | 17 -----------------
 testcases/kernel/syscalls/recvfrom/recvfrom01.c | 15 ---------------
 2 files changed, 32 deletions(-)

diff --git a/testcases/kernel/syscalls/recv/recv01.c b/testcases/kernel/syscalls/recv/recv01.c
index 64658ae32..d71243c30 100644
--- a/testcases/kernel/syscalls/recv/recv01.c
+++ b/testcases/kernel/syscalls/recv/recv01.c
@@ -87,13 +87,10 @@ struct test_case_t {		/* test case structure */
 	0, 0, 0, buf, sizeof(buf), 0,
 		    -1, ENOTSOCK, setup0, cleanup0, "invalid socket"}
 	,
-#ifndef UCLINUX
-	    /* Skip since uClinux does not implement memory protection */
 	{
 	PF_INET, SOCK_STREAM, 0, (void *)-1, sizeof(buf), 0,
 		    -1, EFAULT, setup1, cleanup1, "invalid recv buffer"}
 	,
-#endif
 	{
 	PF_INET, SOCK_STREAM, 0, buf, sizeof(buf), MSG_OOB,
 		    -1, EINVAL, setup1, cleanup1, "invalid MSG_OOB flag set"}
@@ -105,19 +102,11 @@ struct test_case_t {		/* test case structure */
 
 int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
 
-#ifdef UCLINUX
-static char *argv0;
-#endif
-
 int main(int argc, char *argv[])
 {
 	int lc;
 
 	tst_parse_opts(argc, argv, NULL, NULL);
-#ifdef UCLINUX
-	argv0 = argv[0];
-	maybe_run_child(&do_child, "d", &sfd);
-#endif
 
 	setup();
 
@@ -242,13 +231,7 @@ pid_t start_server(struct sockaddr_in *sin0)
 
 	switch ((pid = tst_fork())) {
 	case 0:		/* child */
-#ifdef UCLINUX
-		if (self_exec(argv0, "d", sfd) < 0)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "server self_exec failed");
-#else
 		do_child();
-#endif
 		break;
 	case -1:
 		tst_brkm(TBROK | TERRNO, cleanup, "server fork failed");
diff --git a/testcases/kernel/syscalls/recvfrom/recvfrom01.c b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
index a05256003..f26f85688 100644
--- a/testcases/kernel/syscalls/recvfrom/recvfrom01.c
+++ b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
@@ -126,21 +126,12 @@ struct test_case_t {		/* test case structure */
 
 int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
 
-#ifdef UCLINUX
-static char *argv0;
-#endif
-
 int main(int argc, char *argv[])
 {
 	int lc;
 
 	tst_parse_opts(argc, argv, NULL, NULL);
 
-#ifdef UCLINUX
-	argv0 = argv[0];
-	maybe_run_child(&do_child, "d", &sfd);
-#endif
-
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
@@ -271,13 +262,7 @@ pid_t start_server(struct sockaddr_in *sin0)
 
 	switch ((pid = tst_fork())) {
 	case 0:		/* child */
-#ifdef UCLINUX
-		if (self_exec(argv0, "d", sfd) < 0) {
-			tst_brkm(TBROK, cleanup, "server self_exec failed");
-		}
-#else
 		do_child();
-#endif
 		break;
 	case -1:
 		tst_brkm(TBROK | TERRNO, cleanup, "server fork failed");
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
