Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9690DC77B7A
	for <ltp@archiver.kernel.org>; Tue, 30 May 2023 09:30:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5396C3CCD64
	for <ltp@archiver.kernel.org>; Tue, 30 May 2023 11:30:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8E333CBD8D
 for <ltp@lists.linux.it>; Tue, 30 May 2023 11:30:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B63F91A0098C
 for <ltp@lists.linux.it>; Tue, 30 May 2023 11:30:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685439021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mPMhq3jdLwiNVJnViT1PdReGwfV0HdGCv6wKpE6XwJo=;
 b=Y8rfHr1tf6yCn4VcG84UOFfX8WxFPvL8/uM+hxx5Hf4SmExettXgdXGs2RFtRbTpofffE6
 Y+XRxRql87q3vmL5DMoH1F+VqHAdOzpzxmE2k2qLAF3HvfGTaEIF4y93KvMNyfiZPEvzx3
 KEli7nrZVDEAXZ06KKGpT6VS74lI3o4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-nitjfSQfMbytuO6A0jrryg-1; Tue, 30 May 2023 05:30:16 -0400
X-MC-Unique: nitjfSQfMbytuO6A0jrryg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6086E8007D9;
 Tue, 30 May 2023 09:30:16 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30FA1492B0A;
 Tue, 30 May 2023 09:30:13 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 30 May 2023 17:30:12 +0800
Message-Id: <20230530093012.35470-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] shmget02: reduce the shmmax test value in compat mode
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
Cc: Linux Kernel Functional Testing <lkft@linaro.org>,
 Manfred Spraul <manfred@colorfullife.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

As Arnd Bergmann pointed out that SHMMAX being defined as
(ULONG_MAX - (1UL << 24)), so the kernel would likely use
a large 64-bit value, while the 32-bit user space uses a
much smaller limit.

It finally results in ENOMEM failure:
  shmget02.c:95: TFAIL: shmget(1644199826, 4278190080, 1536)
                 expected EINVAL: ENOMEM (12)

With suggest by Manfred Spraul we could reduce the value
of '/proc/sys/kernel/shmmax' in compat mode and only test
the overflow behavior with default+1.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Manfred Spraul <manfred@colorfullife.com>
---
 testcases/kernel/syscalls/ipc/shmget/shmget02.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
index 7989ef33e..faf633ad4 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
@@ -56,7 +56,11 @@ static struct tcase {
 	{&shmkey1, SHM_SIZE, IPC_EXCL, 0, 0, ENOENT},
 	{&shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL, 0, 0, EEXIST},
 	{&shmkey1, SHMMIN - 1, IPC_CREAT | IPC_EXCL, 0, 0, EINVAL},
+#ifdef TST_ABI32
+	{&shmkey1, 8192 + 1, IPC_CREAT | IPC_EXCL, 0, 0, EINVAL},
+#else
 	{&shmkey1, SHMMAX + 1, IPC_CREAT | IPC_EXCL, 0, 0, EINVAL},
+#endif
 	{&shmkey, SHM_SIZE * 2, IPC_EXCL, 0, 0, EINVAL},
 	{&shmkey, SHM_SIZE, SHM_RD, 1, 0, EACCES},
 	{&shmkey1, SHM_SIZE, IPC_CREAT | SHM_HUGETLB, 0, 1, EPERM},
@@ -149,4 +153,10 @@ static struct tst_test test = {
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(tcases),
 	.hugepages = {TST_NO_HUGEPAGES},
+#ifdef TST_ABI32
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/kernel/shmmax", "8192", TST_SR_TBROK},
+		{}
+	},
+#endif
 };
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
