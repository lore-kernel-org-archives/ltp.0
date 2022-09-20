Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8841EC54EE9
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 08:29:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A8B43CAD0D
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 10:29:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 859883CAAE5
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 10:29:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D49AC1000AF5
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 10:29:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663662543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IPKbxv9uvnot9JV1udTKWixORHHAO87DMkR+EKH/xBY=;
 b=R84DReSG06l0Kh2e/WWlEBqBrLhUggICB+UUuGDyAD+ThPYwS5tXqgFbDuSz8Y1R2GKhwW
 eMRRNF3eXM1A0ma/LKxw/L1V959xGoiRWXQm19NZKSd3lgfuYck3TMNqTwvDPwFz4LUsez
 TFcJIUk36XzlXmK29tqxLJ7BviB3Fq0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-hr4hdzzUOWqaQkcR8MYZRw-1; Tue, 20 Sep 2022 04:29:01 -0400
X-MC-Unique: hr4hdzzUOWqaQkcR8MYZRw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DCB185A5B6
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 08:29:01 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.193.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A0201121314
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 08:29:00 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 20 Sep 2022 10:28:57 +0200
Message-Id: <6bac7035adc2cfc8ab3800fe1d2d03223ec57ff5.1663662348.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/futex_waitv02: replace TST_THREAD_STATE_WAIT
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

Same patch as for futex_waitv03. TST_THREAD_STATE_WAIT isn't reliable to
tell that it's safe to call futex_wake(). futex_wake() can be called
prematurely and return 0, which leaves other thread timing out.

Replace it with repeated futex_wake() until it fails or wakes at least 1 waiter.
Also extend timeout to 5 seconds to avoid false positives from systems with
high steal time (e.g. overloaded s390x host).

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/syscalls/futex/futex_waitv02.c     | 26 +++++++++----------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/futex/futex_waitv02.c b/testcases/kernel/syscalls/futex/futex_waitv02.c
index 0a0e2b62075c..00cf0960808a 100644
--- a/testcases/kernel/syscalls/futex/futex_waitv02.c
+++ b/testcases/kernel/syscalls/futex/futex_waitv02.c
@@ -50,19 +50,20 @@ static void setup(void)
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
+		TEST(futex_wake(tv.fntype,
+			(void *)(uintptr_t)waitv[numfutex - 1].uaddr,
 			1, FUTEX_PRIVATE_FLAG));
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
@@ -70,16 +71,13 @@ static void *threaded(void *arg)
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
