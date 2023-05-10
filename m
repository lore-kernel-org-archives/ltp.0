Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F78C77B7D
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 12:39:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E00B73CD6C7
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 14:39:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4B203CB4E4
 for <ltp@lists.linux.it>; Wed, 10 May 2023 14:38:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A08FC600805
 for <ltp@lists.linux.it>; Wed, 10 May 2023 14:38:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9C5451F749
 for <ltp@lists.linux.it>; Wed, 10 May 2023 12:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683722331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rAIc9c+qezgPw1gPG85voPzid473Vx/1N/zm171om4w=;
 b=wlEWjWVutXLYY7nV8Kh6aQSaZLg4LOf2WGDOitzr4EU9O06lIEwhXo1AO0DL+kGIZuGEU2
 1br5FxHkQIH0iHqGNFGdohAmTJSWV0pblh0g0FD7o8U6vgRvpIcPT8QYJnVB0Q9MLwCFe5
 T1EAqqrGwNLxqVNud4d79+Lt8AUEPrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683722331;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rAIc9c+qezgPw1gPG85voPzid473Vx/1N/zm171om4w=;
 b=LejI6+dTKX745F7bPcrOjM6cu0rgDFQwFT4NOijWNog4xrikEFxuqzos8jipQ/LZWvi/jP
 MZtUQih4DF7zzxAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8640113519
 for <ltp@lists.linux.it>; Wed, 10 May 2023 12:38:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MC60H1uQW2QddgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 10 May 2023 12:38:51 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 10 May 2023 14:38:50 +0200
Message-Id: <20230510123850.26997-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230510123850.26997-1-mdoucha@suse.cz>
References: <20230510123850.26997-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] containers/pidns*: Fix PID checks
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

Some glibc versions cache the return value of getpid() which can result
in getpid() calls returning parent PID when the process was created
using direct clone() syscall. Use tst_getpid() to get the correct
child PID.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/containers/pidns/pidns01.c | 2 +-
 testcases/kernel/containers/pidns/pidns04.c | 2 +-
 testcases/kernel/containers/pidns/pidns06.c | 2 +-
 testcases/kernel/containers/pidns/pidns10.c | 2 +-
 testcases/kernel/containers/pidns/pidns12.c | 2 +-
 testcases/kernel/containers/pidns/pidns13.c | 4 ++--
 testcases/kernel/containers/pidns/pidns16.c | 2 +-
 testcases/kernel/containers/pidns/pidns17.c | 2 +-
 testcases/kernel/containers/pidns/pidns20.c | 2 +-
 testcases/kernel/containers/pidns/pidns30.c | 2 +-
 testcases/kernel/containers/pidns/pidns31.c | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns01.c b/testcases/kernel/containers/pidns/pidns01.c
index 6b5ec48ac..107519971 100644
--- a/testcases/kernel/containers/pidns/pidns01.c
+++ b/testcases/kernel/containers/pidns/pidns01.c
@@ -21,7 +21,7 @@ static void child_func(void)
 {
 	pid_t cpid, ppid;
 
-	cpid = getpid();
+	cpid = tst_getpid();
 	ppid = getppid();
 
 	TST_EXP_EQ_LI(cpid, 1);
diff --git a/testcases/kernel/containers/pidns/pidns04.c b/testcases/kernel/containers/pidns/pidns04.c
index d337e1fe4..8df32899a 100644
--- a/testcases/kernel/containers/pidns/pidns04.c
+++ b/testcases/kernel/containers/pidns/pidns04.c
@@ -17,7 +17,7 @@
 
 static void child_func(void)
 {
-	pid_t cpid = getpid();
+	pid_t cpid = tst_getpid();
 	pid_t ppid = getppid();
 
 	TST_EXP_EQ_LI(cpid, 1);
diff --git a/testcases/kernel/containers/pidns/pidns06.c b/testcases/kernel/containers/pidns/pidns06.c
index ed440f043..8ded0a6b1 100644
--- a/testcases/kernel/containers/pidns/pidns06.c
+++ b/testcases/kernel/containers/pidns/pidns06.c
@@ -16,7 +16,7 @@
 
 static void child_func(int pid)
 {
-	pid_t cpid = getpid();
+	pid_t cpid = tst_getpid();
 	pid_t ppid = getppid();
 
 	TST_EXP_EQ_LI(cpid, 1);
diff --git a/testcases/kernel/containers/pidns/pidns10.c b/testcases/kernel/containers/pidns/pidns10.c
index a35c73f5d..f65b5887b 100644
--- a/testcases/kernel/containers/pidns/pidns10.c
+++ b/testcases/kernel/containers/pidns/pidns10.c
@@ -16,7 +16,7 @@
 
 static void child_func(void)
 {
-	pid_t cpid = getpid();
+	pid_t cpid = tst_getpid();
 	pid_t ppid = getppid();
 
 	TST_EXP_EQ_LI(cpid, 1);
diff --git a/testcases/kernel/containers/pidns/pidns12.c b/testcases/kernel/containers/pidns/pidns12.c
index ab035f33d..b527dbba9 100644
--- a/testcases/kernel/containers/pidns/pidns12.c
+++ b/testcases/kernel/containers/pidns/pidns12.c
@@ -29,7 +29,7 @@ static void child_func(void)
 {
 	struct sigaction sa;
 
-	TST_EXP_EQ_LI(getpid(), 1);
+	TST_EXP_EQ_LI(tst_getpid(), 1);
 	TST_EXP_EQ_LI(getppid(), 0);
 
 	sa.sa_flags = SA_SIGINFO;
diff --git a/testcases/kernel/containers/pidns/pidns13.c b/testcases/kernel/containers/pidns/pidns13.c
index 6a155027c..64038310d 100644
--- a/testcases/kernel/containers/pidns/pidns13.c
+++ b/testcases/kernel/containers/pidns/pidns13.c
@@ -42,7 +42,7 @@ static void child_signal_handler(int sig, siginfo_t *si,
 				 void *unused LTP_ATTRIBUTE_UNUSED)
 {
 	tst_res(TWARN, "cinit(pid %d): Caught signal! sig=%d, si_fd=%d, si_code=%d",
-		getpid(), sig, si->si_fd, si->si_code);
+		tst_getpid(), sig, si->si_fd, si->si_code);
 }
 
 static void child_fn(unsigned int cinit_no)
@@ -54,7 +54,7 @@ static void child_fn(unsigned int cinit_no)
 	pid_t pid, ppid;
 	int flags;
 
-	pid = tst_syscall(__NR_getpid);
+	pid = tst_getpid();
 	ppid = getppid();
 	if (pid != CHILD_PID || ppid != PARENT_PID)
 		tst_brk(TBROK, "cinit%u: pidns not created.", cinit_no);
diff --git a/testcases/kernel/containers/pidns/pidns16.c b/testcases/kernel/containers/pidns/pidns16.c
index 43a221bb4..22da53213 100644
--- a/testcases/kernel/containers/pidns/pidns16.c
+++ b/testcases/kernel/containers/pidns/pidns16.c
@@ -30,7 +30,7 @@ static void child_func(void)
 	struct sigaction sa;
 	pid_t cpid, ppid;
 
-	cpid = getpid();
+	cpid = tst_getpid();
 	ppid = getppid();
 
 	TST_EXP_EQ_LI(cpid, 1);
diff --git a/testcases/kernel/containers/pidns/pidns17.c b/testcases/kernel/containers/pidns/pidns17.c
index c517fa124..823cb90fc 100644
--- a/testcases/kernel/containers/pidns/pidns17.c
+++ b/testcases/kernel/containers/pidns/pidns17.c
@@ -24,7 +24,7 @@ static void child_func(void)
 	unsigned int i;
 	pid_t cpid, ppid;
 
-	cpid = getpid();
+	cpid = tst_getpid();
 	ppid = getppid();
 
 	TST_EXP_EQ_LI(cpid, 1);
diff --git a/testcases/kernel/containers/pidns/pidns20.c b/testcases/kernel/containers/pidns/pidns20.c
index 4d0924c4e..4d87a8303 100644
--- a/testcases/kernel/containers/pidns/pidns20.c
+++ b/testcases/kernel/containers/pidns/pidns20.c
@@ -32,7 +32,7 @@ static void child_func(void)
 	sigset_t newset;
 	pid_t cpid, ppid;
 
-	cpid = getpid();
+	cpid = tst_getpid();
 	ppid = getppid();
 
 	if (cpid != 1 || ppid != 0) {
diff --git a/testcases/kernel/containers/pidns/pidns30.c b/testcases/kernel/containers/pidns/pidns30.c
index c408484dd..8e95e7963 100644
--- a/testcases/kernel/containers/pidns/pidns30.c
+++ b/testcases/kernel/containers/pidns/pidns30.c
@@ -47,7 +47,7 @@ static void child_func(void)
 	struct sigevent notif;
 	mqd_t mqd_child;
 
-	cpid = getpid();
+	cpid = tst_getpid();
 	ppid = getppid();
 
 	TST_EXP_EQ_LI(cpid, 1);
diff --git a/testcases/kernel/containers/pidns/pidns31.c b/testcases/kernel/containers/pidns/pidns31.c
index ad843cb6c..91f8cf1d6 100644
--- a/testcases/kernel/containers/pidns/pidns31.c
+++ b/testcases/kernel/containers/pidns/pidns31.c
@@ -45,7 +45,7 @@ static void child_func(void)
 	pid_t cpid, ppid;
 	mqd_t mqd_child;
 
-	cpid = getpid();
+	cpid = tst_getpid();
 	ppid = getppid();
 
 	TST_EXP_EQ_LI(cpid, 1);
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
