Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D35CDB465
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 11:40:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A99683CEEE8
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 13:40:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 287B33CD075
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 13:40:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 60659603126
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 13:40:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697715640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/UDgFp66XpEBJD6Uo/FOu0fP0dcQb+zjdS2aZTXAZ0c=;
 b=ejTNy0LTxsIIgnEgNLhnE9LEwzWhncJtBs3nWMeH0fhKXR0g3A181siz550SCg5iy/jUZX
 /q0IpDoOaKCFx9z+Z7IwlbQ7E93VlUSd53dR1XuQrsV3nGum71njxghOQFnGXHHrhpc2c5
 XjGFl8fjwMeCd7ZYjzC4J+EvAJUsSTc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-INsqaWABMGG4wZPMVN9qWg-1; Thu, 19 Oct 2023 07:40:19 -0400
X-MC-Unique: INsqaWABMGG4wZPMVN9qWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBDE488D025
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 11:40:18 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83D572166B26
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 11:40:18 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 19 Oct 2023 13:35:33 +0200
Message-Id: <345e84821f2319d24ce8b9b84f5e038d53a2c9d5.1697715265.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/gettid02: fix s390x and couple races
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

s390x is big endian where sizeof(int) == 4 and sizeof(void *) == 8.
This test currently fails on s390x because in pthread_join, "&tids[i]"
is treated as "void**" and due to different type size it writes over
2 entries of tids[] array. So for small tid values test reports:
	gettid02.c:29: TPASS: Expect: parent ID (14048) differs from thread[0] ID (14049)
	gettid02.c:29: TPASS: Expect: parent ID (14048) differs from thread[1] ID (14050)
	gettid02.c:29: TPASS: Expect: parent ID (14048) differs from thread[2] ID (14051)
	gettid02.c:29: TPASS: Expect: parent ID (14048) differs from thread[3] ID (14052)
	gettid02.c:29: TPASS: Expect: parent ID (14048) differs from thread[4] ID (14053)
	gettid02.c:29: TPASS: Expect: parent ID (14048) differs from thread[5] ID (14054)
	gettid02.c:29: TPASS: Expect: parent ID (14048) differs from thread[6] ID (14055)
	gettid02.c:29: TPASS: Expect: parent ID (14048) differs from thread[7] ID (14056)
	gettid02.c:29: TPASS: Expect: parent ID (14048) differs from thread[8] ID (14057)
	gettid02.c:29: TPASS: Expect: parent ID (14048) differs from thread[9] ID (14058)
	gettid02.c:49: TINFO: thread[0] and thread[1] have the same ID
	gettid02.c:49: TINFO: thread[0] and thread[2] have the same ID
	gettid02.c:49: TINFO: thread[0] and thread[3] have the same ID
        ...
which is clearly wrong, since each thread above printed different ID.

This construct is race-y on slower s390x systems:
	for (int i = 0; i < THREADS_NUM; i++)
		SAFE_PTHREAD_CREATE(&thread, NULL, threaded, &i);
because by the time thread starts and looks at "&i", the loop can
already move on and increment "i".

Also, potentially starting and waiting for each thread could be an issue, since kernel is
free to re-use tid for already finished threads.

Instead of passing tid via pthread_join, just use already available global array "tids".
Make sure the argument to pthread_create doesn't change, by creating an args array.
Start all threads before we join any.
And also print the value of TID in cases where test detects two threads use same one.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/gettid/gettid02.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/gettid/gettid02.c b/testcases/kernel/syscalls/gettid/gettid02.c
index 61f115fc9e7c..ef44761c41de 100644
--- a/testcases/kernel/syscalls/gettid/gettid02.c
+++ b/testcases/kernel/syscalls/gettid/gettid02.c
@@ -16,7 +16,7 @@
 
 #define THREADS_NUM 10
 
-static pid_t tids[THREADS_NUM];
+static volatile pid_t tids[THREADS_NUM];
 
 static void *threaded(void *arg)
 {
@@ -29,24 +29,27 @@ static void *threaded(void *arg)
 	TST_EXP_EXPR(pid != tid,
 		"parent ID (%d) differs from thread[%d] ID (%d)",
 		pid, i, tid);
-
-	return (void *)tst_syscall(__NR_gettid);
+	tids[i] = tid;
+	return NULL;
 }
 
 static void run(void)
 {
-	pthread_t thread;
+	pthread_t thread[THREADS_NUM];
+	int args[THREADS_NUM];
 	int error = 0;
 
 	for (int i = 0; i < THREADS_NUM; i++) {
-		SAFE_PTHREAD_CREATE(&thread, NULL, threaded, &i);
-		SAFE_PTHREAD_JOIN(thread, (void **)&tids[i]);
+		args[i] = i;
+		SAFE_PTHREAD_CREATE(&thread[i], NULL, threaded, &args[i]);
 	}
+	for (int i = 0; i < THREADS_NUM; i++)
+		SAFE_PTHREAD_JOIN(thread[i], NULL);
 
 	for (int i = 0; i < THREADS_NUM; i++) {
 		for (int j = i + 1; j < THREADS_NUM; j++) {
 			if (tids[i] == tids[j]) {
-				tst_res(TINFO, "thread[%d] and thread[%d] have the same ID", i, j);
+				tst_res(TINFO, "thread[%d] and thread[%d] have the same ID %d", i, j, tids[i]);
 				error = 1;
 			}
 		}
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
