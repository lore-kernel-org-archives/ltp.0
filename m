Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DE6C433F5
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:47:06 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E7561B1B
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 35E7561B1B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jv-coder.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 982823C89B0
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 08:47:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBBE73C7A4A
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:46:15 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A4E601A001C7
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:46:14 +0100 (CET)
Received: from ubuntu.localdomain (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id DFED59FE82;
 Fri, 19 Nov 2021 07:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1637307974; bh=+Unq/U7kt5t38ObWqFYluZzLSRV7a11RZGARUiUCUyo=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=IuGYtAfoVX6wbsT145QWxEkhCwr30TwxjXdk7Xj8PecpsarC7Zwbau0ogGlmmJ4rW
 sDlZOZt62sMmAFG+MEaCwPhzXWhaPcji8HQ7/1SchB+0yiWpFV6HQgqnJIby+5VvC8
 o6V37XGDzvVjpRlTf21U4mppMjKZm6Da8SHaoZws=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it
Date: Fri, 19 Nov 2021 08:45:53 +0100
Message-Id: <20211119074602.857595-4-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119074602.857595-1-lkml@jv-coder.de>
References: <20211119074602.857595-1-lkml@jv-coder.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 03/12] posix/pthread_create/*: Remove unused variable
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

While pad was supposed to speed up stack growth, the test
works without it and it was propably optimized out anyway.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../conformance/interfaces/pthread_create/1-5.c                | 3 ---
 .../conformance/interfaces/pthread_create/3-2.c                | 2 --
 2 files changed, 5 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/1-5.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/1-5.c
index c4756ab6f..33c5b5cb6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/1-5.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/1-5.c
@@ -100,12 +100,9 @@
 static void *overflow(void *arg)
 {
 	void *current;
-	void *pad[50];		/* We want to consume the stack quickly */
 	long stacksize = sysconf(_SC_THREAD_STACK_MIN);	/* make sure we touch the current stack memory */
 	int ret = 0;
 
-	pad[1] = NULL;		/* so compiler stops complaining about unused variables */
-
 	if (arg == NULL) {
 		/* first call */
 		current = overflow(&current);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/3-2.c
index a508fc45e..433ccd8fe 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/3-2.c
@@ -108,10 +108,8 @@ static sem_t semsync[2];		/* These semaphores will only be used in child process
 static void *overflow(void *arg)
 {
 	void *current;
-	void *pad[50];		/* We want to consume the stack quickly */
 	long stacksize = sysconf(_SC_THREAD_STACK_MIN);	/* make sure we touch the current stack memory */
 
-	pad[1] = NULL;		/* so compiler stops complaining about unused variables */
 	int ret = 0;
 
 	if (arg == NULL) {
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
