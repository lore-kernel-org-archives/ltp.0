Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E290C54EE9
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 09:22:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BEA43CACFE
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 11:22:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CE433C93FF
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 11:21:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C676E1000A7B
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 11:21:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663665713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Yo1BKxlpcmPKxLeqss0F/+8bCDw5oCzoPeRCzdGuGs=;
 b=Gowd00gAOgKFJgRZw5OkOq7dbt/4MGQgvIHq//j0yWpJjtAm6OzonQQbu8paiDKPDUrUWB
 75qazo4b5ThWB1vRyo0qZLDDpziPlzii1qdLh3a1IWdyOuIW94Fc5RU8vlndR46zTTyzGA
 pZi8LZ0OiaeTIlV3QVGicyDmpQO6ehs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-Gq-KfWrbNjSiL6EXIf248w-1; Tue, 20 Sep 2022 05:21:44 -0400
X-MC-Unique: Gq-KfWrbNjSiL6EXIf248w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C72E29AA2EC
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 09:21:44 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.193.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2DD940C2064
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 09:21:43 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 20 Sep 2022 11:21:37 +0200
Message-Id: <6c5b161bc3bcf753cbda92954ca3f47cb268c68f.1663665637.git.jstancek@redhat.com>
In-Reply-To: <6bac7035adc2cfc8ab3800fe1d2d03223ec57ff5.1663662348.git.jstancek@redhat.com>
References: <6bac7035adc2cfc8ab3800fe1d2d03223ec57ff5.1663662348.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/futex_waitv0[23]: replace
 TST_THREAD_STATE_WAIT with repeated wake
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

TST_THREAD_STATE_WAIT isn't reliable to tell that it's safe to
call futex_wake(). futex_wake() can be called prematurely and
return 0, which leaves other thread timing out.

Replace it with repeated futex_wake() until it fails or wakes at least 1 waiter.
Also extend timeout to 5 seconds to avoid false positives from systems with
high steal time (e.g. overloaded s390x host).

For futex_waitv03 this replaces while loop with TST_RETRY_FUNC.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/syscalls/futex/futex_waitv02.c     | 21 ++++++-------------
 .../kernel/syscalls/futex/futex_waitv03.c     | 12 +++--------
 testcases/kernel/syscalls/futex/futextest.h   | 15 +++++++++++++
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/syscalls/futex/futex_waitv02.c b/testcases/kernel/syscalls/futex/futex_waitv02.c
index 0a0e2b62075c..ccea5eb5e745 100644
--- a/testcases/kernel/syscalls/futex/futex_waitv02.c
+++ b/testcases/kernel/syscalls/futex/futex_waitv02.c
@@ -50,19 +50,13 @@ static void setup(void)
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
-			1, FUTEX_PRIVATE_FLAG));
-	if (TST_RET < 0) {
-		tst_brk(TBROK | TTERRNO,
-			"futex_wake private returned: %ld", TST_RET);
-	}
+	TST_RETRY_FUNC(futex_wake(tv.fntype,
+		(void *)(uintptr_t)waitv[numfutex - 1].uaddr,
+		1, FUTEX_PRIVATE_FLAG), futex_waked_someone);
 
 	return NULL;
 }
@@ -70,16 +64,13 @@ static void *threaded(void *arg)
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
diff --git a/testcases/kernel/syscalls/futex/futex_waitv03.c b/testcases/kernel/syscalls/futex/futex_waitv03.c
index ee79728474ee..c674f52d8d4c 100644
--- a/testcases/kernel/syscalls/futex/futex_waitv03.c
+++ b/testcases/kernel/syscalls/futex/futex_waitv03.c
@@ -74,15 +74,9 @@ static void *threaded(LTP_ATTRIBUTE_UNUSED void *arg)
 {
 	struct futex_test_variants tv = futex_variant();
 
-	do {
-		TEST(futex_wake(tv.fntype, (void *)(uintptr_t)waitv[numfutex - 1].uaddr,
-			1, 0));
-		if (TST_RET < 0) {
-			tst_brk(TBROK | TTERRNO,
-				"futex_wake private returned: %ld", TST_RET);
-		}
-		usleep(1000);
-	} while (TST_RET < 1);
+	TST_RETRY_FUNC(futex_wake(tv.fntype,
+		(void *)(uintptr_t)waitv[numfutex - 1].uaddr,
+		1, 0), futex_waked_someone);
 
 	return NULL;
 }
diff --git a/testcases/kernel/syscalls/futex/futextest.h b/testcases/kernel/syscalls/futex/futextest.h
index fd10885f3205..515b5102d4fc 100644
--- a/testcases/kernel/syscalls/futex/futextest.h
+++ b/testcases/kernel/syscalls/futex/futextest.h
@@ -277,4 +277,19 @@ futex_set(futex_t *uaddr, u_int32_t newval)
 	return newval;
 }
 
+/**
+ * futex_waked_someone() - ECHCK func for TST_RETRY_FUNC
+ * @ret:	return value of futex_wake
+ *
+ * Return value drives TST_RETRY_FUNC macro.
+ */
+static inline int
+futex_waked_someone(int ret)
+{
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "futex_wake returned: %d", ret);
+
+	return ret;
+}
+
 #endif /* _FUTEXTEST_H */
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
