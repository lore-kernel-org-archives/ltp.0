Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A3DC4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:37:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 384703CF848
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:37:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AED7B3CF800
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:34 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1360C600D24
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E78445CD21;
 Thu, 11 Apr 2024 14:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ruO8ep+Ouoj4vYMpJHIrl4Xp7sbqJujLVfUVLgKwsSE=;
 b=ek4G3GY5y5fvpuuCLUTUrOM8Ev3LVePxwLQwqP38NvZm0xG9XI8/fhw/iru9d0MTqsBKNt
 ZPrKuBQBJ/fg9cIo6p60PVKbCQ05uTF3eGcWys98MvzNzoEx9KckJzX1dTmhkmCotrDDQj
 hGYcTXjIZvNDL0OPyLtZ+q0/5m5nz+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ruO8ep+Ouoj4vYMpJHIrl4Xp7sbqJujLVfUVLgKwsSE=;
 b=1O2pn1vQmj93o6eln5Gp7XvLZK6BY8h9HKPR1Er18wZ0hLXhE1xL01OIlcStY2qguYAh91
 k59q3xp/eS2iXCBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ruO8ep+Ouoj4vYMpJHIrl4Xp7sbqJujLVfUVLgKwsSE=;
 b=ek4G3GY5y5fvpuuCLUTUrOM8Ev3LVePxwLQwqP38NvZm0xG9XI8/fhw/iru9d0MTqsBKNt
 ZPrKuBQBJ/fg9cIo6p60PVKbCQ05uTF3eGcWys98MvzNzoEx9KckJzX1dTmhkmCotrDDQj
 hGYcTXjIZvNDL0OPyLtZ+q0/5m5nz+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ruO8ep+Ouoj4vYMpJHIrl4Xp7sbqJujLVfUVLgKwsSE=;
 b=1O2pn1vQmj93o6eln5Gp7XvLZK6BY8h9HKPR1Er18wZ0hLXhE1xL01OIlcStY2qguYAh91
 k59q3xp/eS2iXCBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6D3F1386E;
 Thu, 11 Apr 2024 14:30:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WHKNLwj0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:32 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:30:15 +0200
Message-ID: <20240411143025.352507-22-pvorel@suse.cz>
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
Subject: [LTP] [PATCH 21/31] send*: Remove UCLINUX
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
 testcases/kernel/syscalls/send/send01.c       | 21 -------------------
 testcases/kernel/syscalls/sendmsg/sendmsg01.c | 14 -------------
 testcases/kernel/syscalls/sendto/sendto01.c   | 21 -------------------
 3 files changed, 56 deletions(-)

diff --git a/testcases/kernel/syscalls/send/send01.c b/testcases/kernel/syscalls/send/send01.c
index 1f97daf5f..41859ff6f 100644
--- a/testcases/kernel/syscalls/send/send01.c
+++ b/testcases/kernel/syscalls/send/send01.c
@@ -100,8 +100,6 @@ static struct test_case_t tdat[] = {
 	 .cleanup = cleanup0,
 	 .desc = "invalid socket"}
 	,
-#ifndef UCLINUX
-	/* Skip since uClinux does not implement memory protection */
 	{.domain = PF_INET,
 	 .type = SOCK_STREAM,
 	 .proto = 0,
@@ -114,7 +112,6 @@ static struct test_case_t tdat[] = {
 	 .cleanup = cleanup1,
 	 .desc = "invalid send buffer"}
 	,
-#endif
 	{.domain = PF_INET,
 	 .type = SOCK_DGRAM,
 	 .proto = 0,
@@ -139,8 +136,6 @@ static struct test_case_t tdat[] = {
 	 .cleanup = cleanup1,
 	 .desc = "local endpoint shutdown"}
 	,
-#ifndef UCLINUX
-	/* Skip since uClinux does not implement memory protection */
 	{.domain = PF_INET,
 	 .type = SOCK_DGRAM,
 	 .proto = 0,
@@ -152,15 +147,10 @@ static struct test_case_t tdat[] = {
 	 .setup = setup1,
 	 .cleanup = cleanup1,
 	 .desc = "invalid flags set"}
-#endif
 };
 
 int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
 
-#ifdef UCLINUX
-static char *argv0;
-#endif
-
 static pid_t start_server(struct sockaddr_in *sin0)
 {
 	pid_t pid;
@@ -187,13 +177,7 @@ static pid_t start_server(struct sockaddr_in *sin0)
 
 	switch ((pid = tst_fork())) {
 	case 0:
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
@@ -253,11 +237,6 @@ int main(int ac, char *av[])
 
 	tst_parse_opts(ac, av, NULL, NULL);
 
-#ifdef UCLINUX
-	argv0 = av[0];
-	maybe_run_child(&do_child, "d", &sfd);
-#endif
-
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
index 62477e56b..38cd7182c 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
@@ -358,21 +358,12 @@ struct test_case_t tdat[] = {
 
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
-	maybe_run_child(&do_child, "dd", &sfd, &ufd);
-#endif
-
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
@@ -459,12 +450,7 @@ static pid_t start_server(struct sockaddr_in *sin0, struct sockaddr_un *sun0)
 
 	switch ((pid = tst_fork())) {
 	case 0:
-#ifdef UCLINUX
-		if (self_exec(argv0, "dd", sfd, ufd) < 0)
-			tst_brkm(TBROK, cleanup, "server self_exec failed");
-#else
 		do_child();
-#endif
 		break;
 	case -1:
 		tst_brkm(TBROK, cleanup, "server fork failed: %s",
diff --git a/testcases/kernel/syscalls/sendto/sendto01.c b/testcases/kernel/syscalls/sendto/sendto01.c
index 654e6057e..b3b7b6efd 100644
--- a/testcases/kernel/syscalls/sendto/sendto01.c
+++ b/testcases/kernel/syscalls/sendto/sendto01.c
@@ -106,8 +106,6 @@ struct test_case_t tdat[] = {
 	 .cleanup = cleanup0,
 	 .desc = "invalid socket"}
 	,
-#ifndef UCLINUX
-	/* Skip since uClinux does not implement memory protection */
 	{.domain = PF_INET,
 	 .type = SOCK_DGRAM,
 	 .proto = 0,
@@ -122,7 +120,6 @@ struct test_case_t tdat[] = {
 	 .cleanup = cleanup1,
 	 .desc = "invalid send buffer"}
 	,
-#endif
 	{.domain = PF_INET,
 	 .type = SOCK_STREAM,
 	 .proto = 0,
@@ -165,8 +162,6 @@ struct test_case_t tdat[] = {
 	 .cleanup = cleanup1,
 	 .desc = "invalid to buffer length"}
 	,
-#ifndef UCLINUX
-	/* Skip since uClinux does not implement memory protection */
 	{.domain = PF_INET,
 	 .type = SOCK_DGRAM,
 	 .proto = 0,
@@ -181,7 +176,6 @@ struct test_case_t tdat[] = {
 	 .cleanup = cleanup1,
 	 .desc = "invalid to buffer"}
 	,
-#endif
 	{.domain = PF_INET,
 	 .type = SOCK_DGRAM,
 	 .proto = 0,
@@ -227,10 +221,6 @@ struct test_case_t tdat[] = {
 
 int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
 
-#ifdef UCLINUX
-static char *argv0;
-#endif
-
 static pid_t start_server(struct sockaddr_in *sin0)
 {
 	pid_t pid;
@@ -257,13 +247,7 @@ static pid_t start_server(struct sockaddr_in *sin0)
 
 	switch ((pid = tst_fork())) {
 	case 0:
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
@@ -323,11 +307,6 @@ int main(int ac, char *av[])
 
 	tst_parse_opts(ac, av, NULL, NULL);
 
-#ifdef UCLINUX
-	argv0 = av[0];
-	maybe_run_child(&do_child, "d", &sfd);
-#endif
-
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
