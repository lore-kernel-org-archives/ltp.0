Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048CFC43334
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 16:56:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F0B53CA31F
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 18:56:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0BDE3CA178
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 18:56:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DA7B31401145
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 18:56:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657212988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I14fU+bS/AWFWjYR6m+iZw1K0qT9FXXh9AohO3MfvzQ=;
 b=B1Zoe+akdWcJzjM/Ezv6tbZ/Bzitt+vO/cjWxgJDscBCxSV0D+3zNkGLTEXdm3nq31EHfa
 7dnLUC1ma3tS7J220BHBQ7F7smwAoMw70wcoWeDYJP1LXHR9Tyw/hx8FLL7d+143+XRJQP
 AqZkc9OjbyfPdmnlS4/sYCImeeLOvVE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-SNYVsjTGMYqDoLR8SB4fUw-1; Thu, 07 Jul 2022 12:56:24 -0400
X-MC-Unique: SNYVsjTGMYqDoLR8SB4fUw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA64C3C11E64
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 16:56:21 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.22.34.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79CD61121315
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 16:56:21 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  7 Jul 2022 18:56:18 +0200
Message-Id: <d9cddda87dd121a4c57baa7f2d0e221b7a99bc1c.1657212941.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/futex_waitv03: replace TST_THREAD_STATE_WAIT
 with repeated wake
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

TST_THREAD_STATE_WAIT isn't reliable to tell that it's safe to call futex_wake().
futex_wake() can be called prematurely and return 0, which leaves other thread
timing out on futex call:
  tst_test.c:1459: TINFO: Timeout per run is 0h 10m 00s
  futex_waitv03.c:37: TINFO: Testing variant: syscall with old kernel spec
  tst_buffers.c:55: TINFO: Test is using guarded buffers
  futex_waitv03.c:106: TBROK: futex_waitv returned: -1: ETIMEDOUT (110)

Replace it with repeated futex_wake() until it fails or wakes at least 1 waiter.
Also extend timeout to 5 seconds to avoid false positives from systems with
high steal time (e.g. overloaded s390x host).

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/syscalls/futex/futex_waitv03.c     | 25 ++++++++-----------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/futex/futex_waitv03.c b/testcases/kernel/syscalls/futex/futex_waitv03.c
index ffe5c66cde77..ee79728474ee 100644
--- a/testcases/kernel/syscalls/futex/futex_waitv03.c
+++ b/testcases/kernel/syscalls/futex/futex_waitv03.c
@@ -70,19 +70,19 @@ static void cleanup(void)
 	}
 }
 
-static void *threaded(void *arg)
+static void *threaded(LTP_ATTRIBUTE_UNUSED void *arg)
 {
 	struct futex_test_variants tv = futex_variant();
-	int tid = *(int *)arg;
 
-	TST_THREAD_STATE_WAIT(tid, 'S', 0);
-
-	TEST(futex_wake(tv.fntype, (void *)(uintptr_t)waitv[numfutex - 1].uaddr,
+	do {
+		TEST(futex_wake(tv.fntype, (void *)(uintptr_t)waitv[numfutex - 1].uaddr,
 			1, 0));
-	if (TST_RET < 0) {
-		tst_brk(TBROK | TTERRNO,
-			"futex_wake private returned: %ld", TST_RET);
-	}
+		if (TST_RET < 0) {
+			tst_brk(TBROK | TTERRNO,
+				"futex_wake private returned: %ld", TST_RET);
+		}
+		usleep(1000);
+	} while (TST_RET < 1);
 
 	return NULL;
 }
@@ -90,16 +90,13 @@ static void *threaded(void *arg)
 static void run(void)
 {
 	struct timespec to;
-	int tid;
 	pthread_t t;
 
-	tid = tst_syscall(__NR_gettid);
-
-	SAFE_PTHREAD_CREATE(&t, NULL, threaded, (void *)&tid);
+	SAFE_PTHREAD_CREATE(&t, NULL, threaded, NULL);
 
 	/* setting absolute timeout for futex2 */
 	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &to);
-	to.tv_sec++;
+	to.tv_sec += 5;
 
 	TEST(futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC));
 	if (TST_RET < 0) {
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
