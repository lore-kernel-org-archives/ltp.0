Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9456DC433EF
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 10:44:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 952A23C9A7C
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 11:44:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DFE53C0E93
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 11:43:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7AC201A01980
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 11:43:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4222D212C0;
 Wed, 23 Feb 2022 10:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645613037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vf9FJ1wKMkmNVjlda3tI1lmp/Fbgz9cuS20hF7Dp7Nw=;
 b=ayus/NbnzyUDl3f/7vRbLD0TlpTMO8eocXVO1Ua4hSWz2jpKQdlHbD8rij96Qgh9jMmt/K
 eMZCMgpy/BSFwp4D3b5rsETJkGjgVYLqPHBVCdINXwnrqM5sdPl6d1+WvrN3jfYOWhlJwo
 8UySB7DwAX1X/eP9ruT1gdHbCp+VSgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645613037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vf9FJ1wKMkmNVjlda3tI1lmp/Fbgz9cuS20hF7Dp7Nw=;
 b=SnTWEsmi+qXMqsvQk00XqGsJmrN+h2cKNVYRv7DEo0NdKvo8Fu0J6497I0AMOm+fznEAuc
 NZco8sRn4jaMNZAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7B0513C8B;
 Wed, 23 Feb 2022 10:43:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TsvWK+wPFmIMUAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 23 Feb 2022 10:43:56 +0000
Date: Wed, 23 Feb 2022 11:46:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YhYQcqq2tKd2Xf81@yuki>
References: <20220223091349.30833-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220223091349.30833-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Split waitid01.c test into multiple tests
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Pushed with a few changes, thanks.

Apart from formatting changes there were two functional changes I did.

- with P_ALL the the id parameter is ignored so I've changed it to 0

- the CLD_DUMPED case is a bit more complicated, since have to make sure
  that core dumps are enabled, so I did add a setup fucntion that
  attempts to raise rlimit(RLIMIT_CORE) and if that fails we expect
  CLD_KILLED instead of CLD_DUMPED

Full diff:


diff --git a/testcases/kernel/syscalls/waitid/waitid01.c b/testcases/kernel/syscalls/waitid/waitid01.c
index 60ecf9022..136eec8a6 100644
--- a/testcases/kernel/syscalls/waitid/waitid01.c
+++ b/testcases/kernel/syscalls/waitid/waitid01.c
@@ -25,7 +25,7 @@ static void run(void)
 	if (!pidchild)
 		exit(123);
 
-	TST_EXP_PASS(waitid(P_ALL, getpid(), infop, WEXITED));
+	TST_EXP_PASS(waitid(P_ALL, 0, infop, WEXITED));
 	TST_EXP_EQ_LI(infop->si_pid, pidchild);
 	TST_EXP_EQ_LI(infop->si_status, 123);
 	TST_EXP_EQ_LI(infop->si_signo, SIGCHLD);
@@ -35,9 +35,8 @@ static void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.forks_child = 1,
-	.bufs =
-		(struct tst_buffers[]){
-			{ &infop, .size = sizeof(*infop) },
-			{},
-		},
+	.bufs = (struct tst_buffers[]) {
+		{&infop, .size = sizeof(*infop)},
+		{},
+	},
 };
diff --git a/testcases/kernel/syscalls/waitid/waitid10.c b/testcases/kernel/syscalls/waitid/waitid10.c
index 3b2b0fae9..869ef18bd 100644
--- a/testcases/kernel/syscalls/waitid/waitid10.c
+++ b/testcases/kernel/syscalls/waitid/waitid10.c
@@ -13,9 +13,11 @@
 
 #include <stdlib.h>
 #include <sys/wait.h>
+#include <sys/prctl.h>
 #include "tst_test.h"
 
 static siginfo_t *infop;
+static int core_dumps = 1;
 
 static void run(void)
 {
@@ -26,22 +28,47 @@ static void run(void)
 		volatile int a, zero = 0;
 
 		a = 1 / zero;
-		exit(0);
+		exit(a);
 	}
 
-	TST_EXP_PASS(waitid(P_ALL, pidchild, infop, WEXITED));
+	TST_EXP_PASS(waitid(P_ALL, 0, infop, WEXITED));
 	TST_EXP_EQ_LI(infop->si_pid, pidchild);
 	TST_EXP_EQ_LI(infop->si_status, SIGFPE);
 	TST_EXP_EQ_LI(infop->si_signo, SIGCHLD);
-	TST_EXP_EQ_LI(infop->si_code, CLD_DUMPED);
+
+	if (core_dumps)
+		TST_EXP_EQ_LI(infop->si_code, CLD_DUMPED);
+	else
+		TST_EXP_EQ_LI(infop->si_code, CLD_KILLED);
+}
+
+static void setup(void)
+{
+	struct rlimit rlim;
+
+	SAFE_GETRLIMIT(RLIMIT_CORE, &rlim);
+
+	if (rlim.rlim_cur)
+		return;
+
+	if (!rlim.rlim_max) {
+		core_dumps = 0;
+		return;
+	}
+
+	tst_res(TINFO, "Raising RLIMIT_CORE rlim_cur=%li -> %li",
+	        rlim.rlim_cur, rlim.rlim_max);
+
+	rlim.rlim_cur = rlim.rlim_max;
+	SAFE_SETRLIMIT(RLIMIT_CORE, &rlim);
 }
 
 static struct tst_test test = {
 	.test_all = run,
 	.forks_child = 1,
-	.bufs =
-		(struct tst_buffers[]){
-			{ &infop, .size = sizeof(*infop) },
-			{},
-		},
+	.setup = setup,
+	.bufs =	(struct tst_buffers[]) {
+		{&infop, .size = sizeof(*infop)},
+		{},
+	},
 };
diff --git a/testcases/kernel/syscalls/waitid/waitid11.c b/testcases/kernel/syscalls/waitid/waitid11.c
index 8f2b847ea..e3754bb1d 100644
--- a/testcases/kernel/syscalls/waitid/waitid11.c
+++ b/testcases/kernel/syscalls/waitid/waitid11.c
@@ -24,7 +24,7 @@ static void run(void)
 
 	pidchild = SAFE_FORK();
 	if (!pidchild) {
-		sleep(10);
+		pause();
 		return;
 	}
 
@@ -40,9 +40,8 @@ static void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.forks_child = 1,
-	.bufs =
-		(struct tst_buffers[]){
-			{ &infop, .size = sizeof(*infop) },
-			{},
-		},
+	.bufs =	(struct tst_buffers[]) {
+		{&infop, .size = sizeof(*infop)},
+		{},
+	},
 };

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
