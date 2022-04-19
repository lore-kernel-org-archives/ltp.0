Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3701EC433F5
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 10:44:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 542603CA686
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 12:44:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EEAC3C8BA5
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 12:44:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D08EA6002E8
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 12:44:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650365055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w+WDgfWVh5yl06Ihl68oj9L0jX8E3VsaDDk5kxslYdQ=;
 b=OOCuN4hnoqz6wIPyZDZZqCPRPOgTeFVJrIehneqxeCPA0eP/IsYhryqYyfM2wbROem4itG
 PnC7NvBqd/phu3y35LNwDNw0x/mkNLsVxyeFJjScSEUhvRL23L7VHJ5fJNEN3aav/rXK0y
 p+uj+JmZAURcOmcH0M0xfL07sCMBkro=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-rmfgImMJOziORAU9zt3IoA-1; Tue, 19 Apr 2022 06:44:14 -0400
X-MC-Unique: rmfgImMJOziORAU9zt3IoA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A02380352D
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 10:44:14 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.193.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B470440FF716
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 10:44:13 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 19 Apr 2022 12:44:10 +0200
Message-Id: <2539516b566aca2a2f419131c7ad28fcdd7a8fcd.1650365029.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] open_posix_testsuite/lio_listio/2-1: remove check for
 individual completion
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

lio_listio() operations are executed in an unspecified order and
checking if any specific one from list already completed appears
meaningless. Remove it.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../conformance/interfaces/lio_listio/2-1.c   | 28 -------------------
 1 file changed, 28 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/2-1.c
index 72a1113e06a3..efcd5b3fcb39 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/2-1.c
@@ -37,16 +37,8 @@
 #define NUM_AIOCBS	256
 #define BUF_SIZE	1024
 
-static volatile int received_selected;
 static volatile int received_all;
 
-static void sigrt1_handler(int signum PTS_ATTRIBUTE_UNUSED,
-	siginfo_t *info,
-	void *context PTS_ATTRIBUTE_UNUSED)
-{
-	received_selected = info->si_value.sival_int;
-}
-
 static void sigrt2_handler(int signum PTS_ATTRIBUTE_UNUSED,
 	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
 	void *context PTS_ATTRIBUTE_UNUSED)
@@ -102,11 +94,6 @@ int main(void)
 		aiocbs[i]->aio_buf = &bufs[i * BUF_SIZE];
 		aiocbs[i]->aio_nbytes = BUF_SIZE;
 		aiocbs[i]->aio_lio_opcode = LIO_WRITE;
-
-		/* Use SIRTMIN+1 for individual completions */
-		aiocbs[i]->aio_sigevent.sigev_notify = SIGEV_SIGNAL;
-		aiocbs[i]->aio_sigevent.sigev_signo = SIGRTMIN + 1;
-		aiocbs[i]->aio_sigevent.sigev_value.sival_int = i;
 	}
 
 	/* Use SIGRTMIN+2 for list completion */
@@ -114,12 +101,6 @@ int main(void)
 	event.sigev_signo = SIGRTMIN + 2;
 	event.sigev_value.sival_ptr = NULL;
 
-	/* Setup handler for individual operation completion */
-	action.sa_sigaction = sigrt1_handler;
-	sigemptyset(&action.sa_mask);
-	action.sa_flags = SA_SIGINFO | SA_RESTART;
-	sigaction(SIGRTMIN + 1, &action, NULL);
-
 	/* Setup handler for list completion */
 	action.sa_sigaction = sigrt2_handler;
 	sigemptyset(&action.sa_mask);
@@ -139,15 +120,6 @@ int main(void)
 		exit(PTS_FAIL);
 	}
 
-	if (received_selected == NUM_AIOCBS - 1) {
-		printf(TNAME " lio_listio() waited\n");
-		for (i = 0; i < NUM_AIOCBS; i++)
-			free(aiocbs[i]);
-		free(bufs);
-		close(fd);
-		exit(PTS_FAIL);
-	}
-
 	if (received_all != 0) {
 		printf(TNAME
 		       " Error lio_listio() waited for list completion\n");
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
