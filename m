Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD640C433EF
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:48:05 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9068361B1E
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9068361B1E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jv-coder.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 376B73C89B4
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 08:48:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0FDE3C7A4A
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:46:18 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5BF1C1001127
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:46:18 +0100 (CET)
Received: from ubuntu.localdomain (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 9776A9FD8F;
 Fri, 19 Nov 2021 07:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1637307977; bh=XSI3HVZi7KPyevHoKGRBVPiMA/25HPUbnvs1Qt5SJtk=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=eXV5NYAwR+8oPKQBc9zp7f64ttLYhEujbbRC55ngWRwUo7wRN7FY0KH8uPhkd3Tcv
 NbhxHwcIfmP0IJt3N5WHvMD+ILAnSK5l5JDA2ayfIXhfkYTQfJdLTJEfN7U7GwBlFm
 ZQ6i9GJARB7uRmHH4vAEmXJiKaVf1AB0BWPUzvgU=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it
Date: Fri, 19 Nov 2021 08:46:00 +0100
Message-Id: <20211119074602.857595-11-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119074602.857595-1-lkml@jv-coder.de>
References: <20211119074602.857595-1-lkml@jv-coder.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 10/12] posix/conformance/interfaces: Fix all
 sign-compare warnings
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../conformance/interfaces/pthread_exit/1-2.c                  | 2 +-
 .../conformance/interfaces/pthread_exit/2-2.c                  | 3 ++-
 .../conformance/interfaces/pthread_exit/3-2.c                  | 3 ++-
 .../conformance/interfaces/pthread_exit/4-1.c                  | 2 +-
 .../conformance/interfaces/pthread_exit/5-1.c                  | 3 ++-
 .../conformance/interfaces/pthread_mutex_trylock/1-2.c         | 2 +-
 .../conformance/interfaces/pthread_mutex_trylock/2-1.c         | 2 +-
 .../conformance/interfaces/pthread_sigmask/18-1.c              | 2 +-
 .../conformance/interfaces/pthread_sigmask/7-1.c               | 3 ++-
 9 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/1-2.c
index 82be6f982..c9931e295 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/1-2.c
@@ -105,7 +105,7 @@ int main(void)
 	int ret = 0;
 	void *rval;
 	pthread_t child;
-	int i;
+	unsigned int i;
 
 	output_init();
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/2-2.c
index 16c658f73..7098e2e5d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/2-2.c
@@ -123,7 +123,8 @@ int main(void)
 	int ret = 0;
 	void *rval;
 	pthread_t child;
-	int i, j;
+	unsigned int i;
+	int j;
 
 	output_init();
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/3-2.c
index 4437ffc77..0a8583fad 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/3-2.c
@@ -149,7 +149,8 @@ int main(void)
 	int ret = 0;
 	void *rval;
 	pthread_t child;
-	int i, j;
+	unsigned int i;
+	int j;
 
 	output_init();
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/4-1.c
index 810df0c34..33e5562ca 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/4-1.c
@@ -122,7 +122,7 @@ int main(void)
 	int ret = 0;
 	void *rval;
 	pthread_t child;
-	int i;
+	unsigned int i;
 
 	output_init();
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/5-1.c
index 69d5c6a97..e35dbef99 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/5-1.c
@@ -141,7 +141,8 @@ int main(void)
 	int ctl = 0;
 	void *rval;
 	pthread_t child;
-	int i, j;
+	unsigned int i;
+	int j;
 
 	output_init();
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/1-2.c
index 7901115f0..a3d8c4864 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/1-2.c
@@ -149,7 +149,7 @@ static void *tf(void *arg)
 int main(void)
 {
 	int ret;
-	int sc;
+	unsigned int sc;
 	pthread_mutexattr_t ma;
 
 	testdata_t *td;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/2-1.c
index 203d03cb5..038cf94f0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/2-1.c
@@ -126,7 +126,7 @@ static void *tf(void *arg)
 int main(void)
 {
 	int ret;
-	int sc;
+	unsigned int sc;
 	pthread_mutexattr_t ma;
 
 	testdata_t *td;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/18-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/18-1.c
index 5801e0e60..f303e9854 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/18-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/18-1.c
@@ -158,7 +158,7 @@ static void *test(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 	sigset_t set;
-	int i, j = 0;
+	unsigned int i, j = 0;
 	int signals[] = { SIGBUS, SIGKILL, SIGABRT, SIGCHLD, SIGHUP };
 #define NSIG (sizeof(signals)/sizeof(int))
 	int operation[] = { SIG_SETMASK, SIG_BLOCK, SIG_UNBLOCK };
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/7-1.c
index aa9c6b96e..79cdefd99 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/7-1.c
@@ -24,7 +24,8 @@ returned by the pthread_sigmask functions.
 static void *a_thread_func()
 {
 	sigset_t oactl, tempset;
-	int i, j, test_failed = 0;
+	unsigned int i, j;
+	int test_failed = 0;
 
 	int siglist[] = { SIGABRT, SIGALRM, SIGBUS, SIGCHLD,
 		SIGCONT, SIGFPE, SIGHUP, SIGILL, SIGINT,
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
