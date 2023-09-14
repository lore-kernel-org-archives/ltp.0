Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8ACEDE9AD
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 11:59:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E5DC3CE723
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 13:59:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 683483CB23E
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 13:59:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D48281400E64
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 13:59:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B94782184E
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 11:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694692779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Y2w3JkhZzFI8huP/6xaDjQ793h4AzoFS7f5YVj0MdN0=;
 b=K1AcTsuNG7jVIxi7x1/GTgzkDl8vGIv0qBemxwLKcX1JapZMcx7tFHC04K8eAbPQEtZwDb
 ve2Bbpj2zlb0WOe/mV4W6zf51kcu2wO07zV/rz8uXek+EuE7xwp0fr6QaTUf4W6IBTOVhz
 ACE0ao5ZK/yyD7K/XLIji0k6bdecNhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694692779;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Y2w3JkhZzFI8huP/6xaDjQ793h4AzoFS7f5YVj0MdN0=;
 b=LXkTlLfYBlI8CNEnSmoHuTTpB72guSy3fT+7erNwoiIG+Y5ij5KlmS15VfjmRWd5m/0VHV
 PldX8K7AighW37Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2820139DB
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 11:59:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1ASjJ6v1AmXkIAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 11:59:39 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 14 Sep 2023 14:00:25 +0200
Message-ID: <20230914120025.22402-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED] [PATCH] testcases/containers: clone_args switch
 to named initializers
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

After the addition of cgroup into the clone_args we got a bunch of
warnings, this commit fixes all of them.

The code was fixed with following coccinelle spatch:

@@
expression f;
identifier var;
@@
-const struct tst_clone_args var = { f, SIGCHLD };
+const struct tst_clone_args var = {
+	.flags = f,
+	.exit_signal = SIGCHLD,
+};

Fixes: 45f6916bae4c ("clone3: Add clone3's clone_args cgroup")
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/containers/mountns/mountns01.c |  5 ++++-
 testcases/kernel/containers/mountns/mountns02.c |  5 ++++-
 testcases/kernel/containers/mountns/mountns03.c |  5 ++++-
 testcases/kernel/containers/mqns/mqns_01.c      |  5 ++++-
 testcases/kernel/containers/mqns/mqns_02.c      |  5 ++++-
 testcases/kernel/containers/pidns/pidns01.c     |  5 ++++-
 testcases/kernel/containers/pidns/pidns02.c     |  5 ++++-
 testcases/kernel/containers/pidns/pidns03.c     |  5 ++++-
 testcases/kernel/containers/pidns/pidns04.c     |  5 ++++-
 testcases/kernel/containers/pidns/pidns06.c     |  5 ++++-
 testcases/kernel/containers/pidns/pidns10.c     |  5 ++++-
 testcases/kernel/containers/pidns/pidns12.c     |  5 ++++-
 testcases/kernel/containers/pidns/pidns13.c     |  5 ++++-
 testcases/kernel/containers/pidns/pidns16.c     |  5 ++++-
 testcases/kernel/containers/pidns/pidns17.c     |  5 ++++-
 testcases/kernel/containers/pidns/pidns20.c     |  5 ++++-
 testcases/kernel/containers/pidns/pidns30.c     |  5 ++++-
 testcases/kernel/containers/pidns/pidns31.c     |  5 ++++-
 testcases/kernel/containers/pidns/pidns32.c     |  5 ++++-
 testcases/kernel/containers/sysvipc/common.h    |  5 ++++-
 testcases/kernel/containers/userns/userns01.c   |  5 ++++-
 testcases/kernel/containers/userns/userns02.c   |  5 ++++-
 testcases/kernel/containers/userns/userns03.c   |  5 ++++-
 testcases/kernel/containers/userns/userns04.c   |  5 ++++-
 testcases/kernel/containers/userns/userns05.c   |  5 ++++-
 testcases/kernel/containers/userns/userns06.c   |  5 ++++-
 testcases/kernel/containers/userns/userns07.c   | 10 ++++++++--
 testcases/kernel/containers/userns/userns08.c   |  4 ++--
 testcases/kernel/containers/utsname/utsname03.c |  5 ++++-
 testcases/kernel/containers/utsname/utsname04.c |  5 ++++-
 30 files changed, 122 insertions(+), 32 deletions(-)

diff --git a/testcases/kernel/containers/mountns/mountns01.c b/testcases/kernel/containers/mountns/mountns01.c
index 41c2956ea..8d821ea45 100644
--- a/testcases/kernel/containers/mountns/mountns01.c
+++ b/testcases/kernel/containers/mountns/mountns01.c
@@ -56,7 +56,10 @@ static void child_func(void)
 
 static void run(void)
 {
-	const struct tst_clone_args args = { CLONE_NEWNS, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWNS,
+		.exit_signal = SIGCHLD,
+	};
 
 	SAFE_UNSHARE(CLONE_NEWNS);
 
diff --git a/testcases/kernel/containers/mountns/mountns02.c b/testcases/kernel/containers/mountns/mountns02.c
index 7ca01a438..e7a80cbbf 100644
--- a/testcases/kernel/containers/mountns/mountns02.c
+++ b/testcases/kernel/containers/mountns/mountns02.c
@@ -56,7 +56,10 @@ static void child_func(void)
 
 static void run(void)
 {
-	const struct tst_clone_args args = { CLONE_NEWNS, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWNS,
+		.exit_signal = SIGCHLD,
+	};
 
 	SAFE_UNSHARE(CLONE_NEWNS);
 
diff --git a/testcases/kernel/containers/mountns/mountns03.c b/testcases/kernel/containers/mountns/mountns03.c
index 3b4936b06..6066d1c54 100644
--- a/testcases/kernel/containers/mountns/mountns03.c
+++ b/testcases/kernel/containers/mountns/mountns03.c
@@ -64,7 +64,10 @@ static void child_func(void)
 
 static void run(void)
 {
-	const struct tst_clone_args args = { CLONE_NEWNS, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWNS,
+		.exit_signal = SIGCHLD,
+	};
 
 	SAFE_UNSHARE(CLONE_NEWNS);
 
diff --git a/testcases/kernel/containers/mqns/mqns_01.c b/testcases/kernel/containers/mqns/mqns_01.c
index 80e248503..d9f6e6c18 100644
--- a/testcases/kernel/containers/mqns/mqns_01.c
+++ b/testcases/kernel/containers/mqns/mqns_01.c
@@ -24,7 +24,10 @@ static char *str_op;
 
 static void run(void)
 {
-	const struct tst_clone_args clone_args = { CLONE_NEWIPC, SIGCHLD };
+	const struct tst_clone_args clone_args = {
+		.flags = CLONE_NEWIPC,
+		.exit_signal = SIGCHLD,
+	};
 
 	tst_res(TINFO, "Checking namespaces isolation from parent to child");
 
diff --git a/testcases/kernel/containers/mqns/mqns_02.c b/testcases/kernel/containers/mqns/mqns_02.c
index 9291787be..4348be7fc 100644
--- a/testcases/kernel/containers/mqns/mqns_02.c
+++ b/testcases/kernel/containers/mqns/mqns_02.c
@@ -52,7 +52,10 @@ static void isolated_child(void)
 
 static void run(void)
 {
-	const struct tst_clone_args clone_args = { CLONE_NEWIPC, SIGCHLD };
+	const struct tst_clone_args clone_args = {
+		.flags = CLONE_NEWIPC,
+		.exit_signal = SIGCHLD,
+	};
 
 	tst_res(TINFO, "Checking namespaces isolation from parent to child");
 
diff --git a/testcases/kernel/containers/pidns/pidns01.c b/testcases/kernel/containers/pidns/pidns01.c
index 107519971..8b856ec90 100644
--- a/testcases/kernel/containers/pidns/pidns01.c
+++ b/testcases/kernel/containers/pidns/pidns01.c
@@ -30,7 +30,10 @@ static void child_func(void)
 
 static void run(void)
 {
-	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWPID,
+		.exit_signal = SIGCHLD,
+	};
 
 	if (!SAFE_CLONE(&args)) {
 		child_func();
diff --git a/testcases/kernel/containers/pidns/pidns02.c b/testcases/kernel/containers/pidns/pidns02.c
index 07eda0c3a..f23178cb6 100644
--- a/testcases/kernel/containers/pidns/pidns02.c
+++ b/testcases/kernel/containers/pidns/pidns02.c
@@ -30,7 +30,10 @@ static void child_func(void)
 
 static void run(void)
 {
-	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWPID,
+		.exit_signal = SIGCHLD,
+	};
 
 	if (!SAFE_CLONE(&args)) {
 		child_func();
diff --git a/testcases/kernel/containers/pidns/pidns03.c b/testcases/kernel/containers/pidns/pidns03.c
index d0d26c8a5..d662ca9d5 100644
--- a/testcases/kernel/containers/pidns/pidns03.c
+++ b/testcases/kernel/containers/pidns/pidns03.c
@@ -43,7 +43,10 @@ static void cleanup(void)
 
 static void run(void)
 {
-	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWPID,
+		.exit_signal = SIGCHLD,
+	};
 
 	if (!SAFE_CLONE(&args)) {
 		child_func();
diff --git a/testcases/kernel/containers/pidns/pidns04.c b/testcases/kernel/containers/pidns/pidns04.c
index 8df32899a..bed75a082 100644
--- a/testcases/kernel/containers/pidns/pidns04.c
+++ b/testcases/kernel/containers/pidns/pidns04.c
@@ -32,7 +32,10 @@ static void child_func(void)
 
 static void run(void)
 {
-	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWPID,
+		.exit_signal = SIGCHLD,
+	};
 	pid_t pid;
 
 	pid = SAFE_CLONE(&args);
diff --git a/testcases/kernel/containers/pidns/pidns06.c b/testcases/kernel/containers/pidns/pidns06.c
index 8ded0a6b1..c85a875e4 100644
--- a/testcases/kernel/containers/pidns/pidns06.c
+++ b/testcases/kernel/containers/pidns/pidns06.c
@@ -29,7 +29,10 @@ static void child_func(int pid)
 
 static void run(void)
 {
-	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWPID,
+		.exit_signal = SIGCHLD,
+	};
 	pid_t pid = getpid();
 
 	if (!SAFE_CLONE(&args)) {
diff --git a/testcases/kernel/containers/pidns/pidns10.c b/testcases/kernel/containers/pidns/pidns10.c
index f65b5887b..c2a9094b6 100644
--- a/testcases/kernel/containers/pidns/pidns10.c
+++ b/testcases/kernel/containers/pidns/pidns10.c
@@ -29,7 +29,10 @@ static void child_func(void)
 
 static void run(void)
 {
-	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWPID,
+		.exit_signal = SIGCHLD,
+	};
 
 	if (!SAFE_CLONE(&args)) {
 		child_func();
diff --git a/testcases/kernel/containers/pidns/pidns12.c b/testcases/kernel/containers/pidns/pidns12.c
index b527dbba9..1811dbc36 100644
--- a/testcases/kernel/containers/pidns/pidns12.c
+++ b/testcases/kernel/containers/pidns/pidns12.c
@@ -45,7 +45,10 @@ static void child_func(void)
 
 static void run(void)
 {
-	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWPID,
+		.exit_signal = SIGCHLD,
+	};
 	int pid;
 
 	pid = SAFE_CLONE(&args);
diff --git a/testcases/kernel/containers/pidns/pidns13.c b/testcases/kernel/containers/pidns/pidns13.c
index 64038310d..65fcc4443 100644
--- a/testcases/kernel/containers/pidns/pidns13.c
+++ b/testcases/kernel/containers/pidns/pidns13.c
@@ -104,7 +104,10 @@ static void child_fn(unsigned int cinit_no)
 
 static void run(void)
 {
-	const struct tst_clone_args cargs = { CLONE_NEWPID, SIGCHLD };
+	const struct tst_clone_args cargs = {
+		.flags = CLONE_NEWPID,
+		.exit_signal = SIGCHLD,
+	};
 
 	SAFE_PIPE(pipe_fd);
 
diff --git a/testcases/kernel/containers/pidns/pidns16.c b/testcases/kernel/containers/pidns/pidns16.c
index 22da53213..313b0a097 100644
--- a/testcases/kernel/containers/pidns/pidns16.c
+++ b/testcases/kernel/containers/pidns/pidns16.c
@@ -56,7 +56,10 @@ static void child_func(void)
 
 static void run(void)
 {
-	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWPID,
+		.exit_signal = SIGCHLD,
+	};
 	pid_t pid;
 
 	signal_pid = -1;
diff --git a/testcases/kernel/containers/pidns/pidns17.c b/testcases/kernel/containers/pidns/pidns17.c
index 823cb90fc..4633ec14b 100644
--- a/testcases/kernel/containers/pidns/pidns17.c
+++ b/testcases/kernel/containers/pidns/pidns17.c
@@ -54,7 +54,10 @@ static void child_func(void)
 
 static void run(void)
 {
-	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWPID,
+		.exit_signal = SIGCHLD,
+	};
 
 	if (!SAFE_CLONE(&args)) {
 		child_func();
diff --git a/testcases/kernel/containers/pidns/pidns20.c b/testcases/kernel/containers/pidns/pidns20.c
index 4d87a8303..914820865 100644
--- a/testcases/kernel/containers/pidns/pidns20.c
+++ b/testcases/kernel/containers/pidns/pidns20.c
@@ -69,7 +69,10 @@ static void child_func(void)
 
 static void run(void)
 {
-	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWPID,
+		.exit_signal = SIGCHLD,
+	};
 	int pid;
 
 	pid = SAFE_CLONE(&args);
diff --git a/testcases/kernel/containers/pidns/pidns30.c b/testcases/kernel/containers/pidns/pidns30.c
index 8e95e7963..4a8bc5e2b 100644
--- a/testcases/kernel/containers/pidns/pidns30.c
+++ b/testcases/kernel/containers/pidns/pidns30.c
@@ -88,7 +88,10 @@ static void cleanup(void)
 
 static void run(void)
 {
-	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWPID,
+		.exit_signal = SIGCHLD,
+	};
 
 	remove_mqueue(mqd);
 	received = 0;
diff --git a/testcases/kernel/containers/pidns/pidns31.c b/testcases/kernel/containers/pidns/pidns31.c
index 91f8cf1d6..7312f8bdc 100644
--- a/testcases/kernel/containers/pidns/pidns31.c
+++ b/testcases/kernel/containers/pidns/pidns31.c
@@ -71,7 +71,10 @@ static void run(void)
 	pid_t cpid;
 	struct sigaction sa;
 	struct sigevent notif;
-	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWPID,
+		.exit_signal = SIGCHLD,
+	};
 
 	remove_mqueue(mqd);
 	received = 0;
diff --git a/testcases/kernel/containers/pidns/pidns32.c b/testcases/kernel/containers/pidns/pidns32.c
index a6326e252..0738369b1 100644
--- a/testcases/kernel/containers/pidns/pidns32.c
+++ b/testcases/kernel/containers/pidns/pidns32.c
@@ -19,7 +19,10 @@
 
 #define MAXNEST 32
 
-static const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
+static const struct tst_clone_args args = {
+	.flags = CLONE_NEWPID,
+	.exit_signal = SIGCHLD,
+};
 static int *level;
 
 static pid_t child_func(void)
diff --git a/testcases/kernel/containers/sysvipc/common.h b/testcases/kernel/containers/sysvipc/common.h
index c43d947d5..180cf9bd7 100644
--- a/testcases/kernel/containers/sysvipc/common.h
+++ b/testcases/kernel/containers/sysvipc/common.h
@@ -39,7 +39,10 @@ static inline int get_clone_unshare_enum(const char *str_op)
 
 static void clone_test(unsigned long clone_flags, void (*fn1)())
 {
-	const struct tst_clone_args clone_args = { clone_flags, SIGCHLD };
+	const struct tst_clone_args clone_args = {
+		.flags = clone_flags,
+		.exit_signal = SIGCHLD,
+	};
 	int pid;
 
 	pid = SAFE_CLONE(&clone_args);
diff --git a/testcases/kernel/containers/userns/userns01.c b/testcases/kernel/containers/userns/userns01.c
index cbe0da245..6fe0cd637 100644
--- a/testcases/kernel/containers/userns/userns01.c
+++ b/testcases/kernel/containers/userns/userns01.c
@@ -73,7 +73,10 @@ static void setup(void)
 
 static void run(void)
 {
-	const struct tst_clone_args args = { CLONE_NEWUSER, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWUSER,
+		.exit_signal = SIGCHLD,
+	};
 
 	if (!SAFE_CLONE(&args)) {
 		child_fn1();
diff --git a/testcases/kernel/containers/userns/userns02.c b/testcases/kernel/containers/userns/userns02.c
index 9d445d986..3c8ce2133 100644
--- a/testcases/kernel/containers/userns/userns02.c
+++ b/testcases/kernel/containers/userns/userns02.c
@@ -32,7 +32,10 @@ static void child_fn1(void)
 
 static void run(void)
 {
-	const struct tst_clone_args args = { CLONE_NEWUSER, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWUSER,
+		.exit_signal = SIGCHLD,
+	};
 	int childpid;
 	int parentuid;
 	int parentgid;
diff --git a/testcases/kernel/containers/userns/userns03.c b/testcases/kernel/containers/userns/userns03.c
index a7f12e3d9..fca858702 100644
--- a/testcases/kernel/containers/userns/userns03.c
+++ b/testcases/kernel/containers/userns/userns03.c
@@ -117,7 +117,10 @@ static void child_fn2(int cpid1, int parentuid, int parentgid)
 
 static void run(void)
 {
-	const struct tst_clone_args args = { CLONE_NEWUSER, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWUSER,
+		.exit_signal = SIGCHLD,
+	};
 	pid_t cpid1, cpid2;
 	uid_t parentuid;
 	gid_t parentgid;
diff --git a/testcases/kernel/containers/userns/userns04.c b/testcases/kernel/containers/userns/userns04.c
index 58ae7c302..d20041f06 100644
--- a/testcases/kernel/containers/userns/userns04.c
+++ b/testcases/kernel/containers/userns/userns04.c
@@ -31,7 +31,10 @@ static void child_fn2(int fd)
 
 static void run(void)
 {
-	const struct tst_clone_args args = { CLONE_NEWUSER, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWUSER,
+		.exit_signal = SIGCHLD,
+	};
 	pid_t cpid1, cpid2, cpid3;
 	char path[BUFSIZ];
 	int fd;
diff --git a/testcases/kernel/containers/userns/userns05.c b/testcases/kernel/containers/userns/userns05.c
index 36f48fda5..e7a00af18 100644
--- a/testcases/kernel/containers/userns/userns05.c
+++ b/testcases/kernel/containers/userns/userns05.c
@@ -45,7 +45,10 @@ static unsigned int getusernsidbypid(int pid)
 static void run(void)
 {
 	const struct tst_clone_args args1 = { .exit_signal = SIGCHLD };
-	const struct tst_clone_args args2 = { CLONE_NEWUSER, SIGCHLD };
+	const struct tst_clone_args args2 = {
+		.flags = CLONE_NEWUSER,
+		.exit_signal = SIGCHLD,
+	};
 	int cpid1, cpid2, cpid3;
 	unsigned int parentuserns, cpid1userns, cpid2userns, newparentuserns;
 
diff --git a/testcases/kernel/containers/userns/userns06.c b/testcases/kernel/containers/userns/userns06.c
index a2c51f725..a270dafdc 100644
--- a/testcases/kernel/containers/userns/userns06.c
+++ b/testcases/kernel/containers/userns/userns06.c
@@ -62,7 +62,10 @@ static void child_fn2(void)
 
 static void run(void)
 {
-	const struct tst_clone_args args = { CLONE_NEWUSER, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWUSER,
+		.exit_signal = SIGCHLD,
+	};
 	pid_t cpid1;
 	pid_t cpid2;
 	int parentuid;
diff --git a/testcases/kernel/containers/userns/userns07.c b/testcases/kernel/containers/userns/userns07.c
index 2c946a659..2217a5ed0 100644
--- a/testcases/kernel/containers/userns/userns07.c
+++ b/testcases/kernel/containers/userns/userns07.c
@@ -22,7 +22,10 @@
 
 static void child_fn1(const int level)
 {
-	const struct tst_clone_args args = { CLONE_NEWUSER, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWUSER,
+		.exit_signal = SIGCHLD,
+	};
 	pid_t cpid;
 	int parentuid;
 	int parentgid;
@@ -53,7 +56,10 @@ static void child_fn1(const int level)
 
 static void run(void)
 {
-	const struct tst_clone_args args = { CLONE_NEWUSER, SIGCHLD };
+	const struct tst_clone_args args = {
+		.flags = CLONE_NEWUSER,
+		.exit_signal = SIGCHLD,
+	};
 	pid_t cpid;
 	int parentuid;
 	int parentgid;
diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kernel/containers/userns/userns08.c
index 84f0ce9a9..72d7f8d12 100644
--- a/testcases/kernel/containers/userns/userns08.c
+++ b/testcases/kernel/containers/userns/userns08.c
@@ -31,8 +31,8 @@
 static pid_t clone_newuser(void)
 {
 	const struct tst_clone_args cargs = {
-		CLONE_NEWUSER,
-		SIGCHLD
+		.flags = CLONE_NEWUSER,
+		.exit_signal = SIGCHLD,
 	};
 
 	return SAFE_CLONE(&cargs);
diff --git a/testcases/kernel/containers/utsname/utsname03.c b/testcases/kernel/containers/utsname/utsname03.c
index 6b94b452e..e5a4a56dc 100644
--- a/testcases/kernel/containers/utsname/utsname03.c
+++ b/testcases/kernel/containers/utsname/utsname03.c
@@ -45,7 +45,10 @@ static void child2_run(void)
 
 static void run(void)
 {
-	const struct tst_clone_args cargs = { CLONE_NEWUTS, SIGCHLD };
+	const struct tst_clone_args cargs = {
+		.flags = CLONE_NEWUTS,
+		.exit_signal = SIGCHLD,
+	};
 
 	memset(hostname1, 0, HOST_NAME_MAX);
 	memset(hostname2, 0, HOST_NAME_MAX);
diff --git a/testcases/kernel/containers/utsname/utsname04.c b/testcases/kernel/containers/utsname/utsname04.c
index 61a3e819c..bf97880ba 100644
--- a/testcases/kernel/containers/utsname/utsname04.c
+++ b/testcases/kernel/containers/utsname/utsname04.c
@@ -20,7 +20,10 @@ static char *str_op;
 
 static void run(void)
 {
-	const struct tst_clone_args cargs = { CLONE_NEWUTS, SIGCHLD };
+	const struct tst_clone_args cargs = {
+		.flags = CLONE_NEWUTS,
+		.exit_signal = SIGCHLD,
+	};
 	struct passwd *pw;
 
 	tst_res(TINFO, "Dropping root privileges");
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
