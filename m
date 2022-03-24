Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9979C433F5
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 23:58:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 461153C2DA6
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 00:58:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDC993C06A9
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 00:58:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 808D9600476
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 00:58:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648166321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ik2EdHmwllIFZRdMxZBq6XUU+pB2GeoH+/4ZvDM2blw=;
 b=XWZadpI0+BZbZqIQKp2+fZqBT6cF38ecNRUuHpzYFNQAXWXFBzLiwKWctU+N0GuymWY8G/
 PMEAaTkq3WL0Q+RKWMhRzc8YxWszouZE5dUk1MvN+3dduqCjwIS1FippraSewJSbUBZQlk
 1RwLc9uMVmzzo5SBLWtdQToWFd5Nzk4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-1P7JxFXPMKKh3C9KfgAgHg-1; Thu, 24 Mar 2022 19:49:57 -0400
X-MC-Unique: 1P7JxFXPMKKh3C9KfgAgHg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46BDA1C05ADA
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 23:49:57 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-13-193.pek2.redhat.com
 [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B699D401E8B;
 Thu, 24 Mar 2022 23:49:55 +0000 (UTC)
From: Chunyu Hu <chuhu@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 25 Mar 2022 07:49:50 +0800
Message-Id: <20220324234950.2229888-1-chuhu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=chuhu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] futex_waitv03: cleanup shms
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

cleanup all the created shms, otherwise, it would be left in sys as
gubbage (ipcs show).

Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 testcases/kernel/syscalls/futex/futex_waitv03.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/futex/futex_waitv03.c b/testcases/kernel/syscalls/futex/futex_waitv03.c
index d8e39c76a..1f53addac 100644
--- a/testcases/kernel/syscalls/futex/futex_waitv03.c
+++ b/testcases/kernel/syscalls/futex/futex_waitv03.c
@@ -26,11 +26,11 @@ static char *str_numfutex;
 static int numfutex = 30;
 
 static struct futex_waitv *waitv;
+static int *shmids;
 
 static void setup(void)
 {
 	struct futex_test_variants tv = futex_variant();
-	int shm_id;
 	int i;
 
 	tst_res(TINFO, "Testing variant: %s", tv.desc);
@@ -41,10 +41,12 @@ static void setup(void)
 
 	waitv = tst_alloc(sizeof(struct futex_waitv) * numfutex);
 	memset(waitv, 0, sizeof(struct futex_waitv) * numfutex);
+	shmids = tst_alloc(sizeof(int*) * numfutex);
+	memset(shmids, 0, sizeof(int*) * numfutex);
 
 	for (i = 0; i < numfutex; i++) {
-		shm_id = SAFE_SHMGET(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
-		waitv[i].uaddr = (uintptr_t)SAFE_SHMAT(shm_id, NULL, 0);
+		shmids[i] = SAFE_SHMGET(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
+		waitv[i].uaddr = (uintptr_t)SAFE_SHMAT(shmids[i], NULL, 0);
 		waitv[i].flags = FUTEX_32;
 		waitv[i].val = 0;
 	}
@@ -59,6 +61,7 @@ static void cleanup(void)
 			continue;
 
 		SAFE_SHMDT((void *)(uintptr_t)waitv[i].uaddr);
+		SAFE_SHMCTL(shmids[i], IPC_RMID, NULL);
 	}
 }
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
