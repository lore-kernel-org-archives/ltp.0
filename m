Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009D1C433F5
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:47:16 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A04C61B1B
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A04C61B1B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jv-coder.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9C983C8994
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 08:47:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C9203C89AD
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:46:17 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 920AF6013F9
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:46:16 +0100 (CET)
Received: from ubuntu.localdomain (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id B0F749FD8F;
 Fri, 19 Nov 2021 07:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1637307975; bh=yAzCtyod/ehTgwPpHhmHbPU8mhf8NditqDPTnq0WiO8=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=XMBNkWV/JwJEnI5gS+78s3NSCvKwmH9ZnkNFouNGZuAeElTZcBDy+5eWv1SGyFyvv
 U9oDsPQnrfBvFBW8fLfebjUhXzvmtq5bh9PbsH2iuaIj3SWOVOgKHbv4AEcsCT5fF9
 jvUi1vVS9nmtkM1SlNTkM/PGdNHJQbZfnRGziTIw=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it
Date: Fri, 19 Nov 2021 08:45:56 +0100
Message-Id: <20211119074602.857595-7-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119074602.857595-1-lkml@jv-coder.de>
References: <20211119074602.857595-1-lkml@jv-coder.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 06/12] posix/conformance/interfaces: Fix all unused
 function warnings
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
 .../conformance/interfaces/pthread_attr_setstack/6-1.c   | 6 ------
 .../conformance/interfaces/pthread_attr_setstack/7-1.c   | 6 ------
 .../interfaces/pthread_attr_setstacksize/4-1.c           | 6 ------
 .../conformance/interfaces/pthread_exit/4-1.c            | 9 ++-------
 .../conformance/interfaces/pthread_exit/5-1.c            | 7 +------
 .../conformance/interfaces/pthread_kill/8-1.c            | 8 --------
 .../conformance/interfaces/pthread_mutex_lock/1-1.c      | 4 ++--
 .../conformance/interfaces/pthread_sigmask/18-1.c        | 8 --------
 8 files changed, 5 insertions(+), 49 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/6-1.c
index 5eac212f9..d298c30ec 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/6-1.c
@@ -31,12 +31,6 @@
 static void *stack_addr;
 static size_t stack_size;
 
-static void *thread_func()
-{
-	pthread_exit(0);
-	return NULL;
-}
-
 int main(void)
 {
 	pthread_attr_t attr;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/7-1.c
index bc7f4f415..932fa8200 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/7-1.c
@@ -32,12 +32,6 @@
 static void *stack_addr;
 static size_t stack_size;
 
-static void *thread_func()
-{
-	pthread_exit(0);
-	return NULL;
-}
-
 int main(void)
 {
 	pthread_attr_t attr;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/4-1.c
index b229d7052..800913a66 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/4-1.c
@@ -28,12 +28,6 @@
 
 #define STACKSIZE PTHREAD_STACK_MIN - sysconf(_SC_PAGE_SIZE)
 
-static void *thread_func()
-{
-	pthread_exit(0);
-	return NULL;
-}
-
 int main(void)
 {
 	pthread_attr_t attr;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/4-1.c
index 1252d5619..810df0c34 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/4-1.c
@@ -91,12 +91,7 @@
 
 static int global = 0;
 
-/* atexit() routines */
-static void at1(void)
-{
-	global +=1;
-}
-
+/* atexit() routine */
 static void at2(void)
 {
 	global +=2;
@@ -107,7 +102,7 @@ static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 
-	/* Note that this funtion will be registered once again for each scenario.
+	/* Note that this function will be registered once again for each scenario.
 	   POSIX requires the ability to register at least 32 functions so it should
 	   not be an issue in our case, as long as we don't get more than 32 scenarii
 	   (with joinable threads) */
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/5-1.c
index 730b751eb..69d5c6a97 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/5-1.c
@@ -91,12 +91,7 @@
 static int atctl = 0;
 static pthread_key_t tld[3];
 
-/* atexit() routines */
-static void at1(void)
-{
-	atctl += 1;
-}
-
+/* atexit() routine */
 static void at2(void)
 {
 	atctl += 2;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/8-1.c
index 086a0cf5c..b61a08173 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/8-1.c
@@ -153,14 +153,6 @@ static void sighdl2(int sig PTS_ATTRIBUTE_UNUSED)
 #endif
 }
 
-static int init_ctl;
-/* Init function */
-static void initializer(void)
-{
-	init_ctl++;
-	return;
-}
-
 /* Test function -- calls pthread_kill() and checks that EINTR is never returned. */
 static void *test(void *arg PTS_ATTRIBUTE_UNUSED)
 {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/1-1.c
index 913251914..4fccbfdf4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/1-1.c
@@ -36,7 +36,7 @@ static int value;			/* value protected by mutex */
 
 int main(void)
 {
-	int i, rc;
+	int i;
 	pthread_attr_t pta;
 	pthread_t threads[THREAD_NUM];
 	//pthread_t           self = pthread_self();
@@ -47,7 +47,7 @@ int main(void)
 	/* Create threads */
 	fprintf(stderr, "Creating %d threads\n", THREAD_NUM);
 	for (i = 0; i < THREAD_NUM; ++i)
-		rc = pthread_create(&threads[i], &pta, f1, NULL);
+		pthread_create(&threads[i], &pta, f1, NULL);
 
 	/* Wait to join all threads */
 	for (i = 0; i < THREAD_NUM; ++i)
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/18-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/18-1.c
index 81ba4ea9b..5801e0e60 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/18-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/18-1.c
@@ -153,14 +153,6 @@ static void sighdl2(int sig PTS_ATTRIBUTE_UNUSED)
 #endif
 }
 
-static int init_ctl;
-/* Init function */
-static void initializer(void)
-{
-	init_ctl++;
-	return;
-}
-
 /* Test function -- calls pthread_sigmask() and checks that EINTR is never returned. */
 static void *test(void *arg PTS_ATTRIBUTE_UNUSED)
 {
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
