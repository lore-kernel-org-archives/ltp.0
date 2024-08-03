Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78459C3DA4A
	for <ltp@archiver.kernel.org>; Sat,  3 Aug 2024 12:23:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F69A3D1D10
	for <ltp@archiver.kernel.org>; Sat,  3 Aug 2024 14:23:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 512533D1D10
 for <ltp@lists.linux.it>; Sat,  3 Aug 2024 14:23:11 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1C45E1000758
 for <ltp@lists.linux.it>; Sat,  3 Aug 2024 14:23:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722687788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0ZLfbj4JWwWsxmyRgCHaIDn/WtCrsg4wcbHeRf+9nw=;
 b=LXZQn/BE+kOdSBaWUg8axlK1C9sI2Vk9BkY7R2R2/wqHUhyyRAXU0cgCOi1El67H26eRVi
 qf1goZfKxyc7KPGJR18lEkvQFAgucxqoHnZX5Dgmqmce0Gv6bkNtb2/U/+YE+yRklffzEe
 ZggdhN0u7xU2KVDJJvz8nEGM2ZKr8WQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-rmrCn2CkPvavKUTzzwChVQ-1; Sat,
 03 Aug 2024 08:23:06 -0400
X-MC-Unique: rmrCn2CkPvavKUTzzwChVQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2405195609F
 for <ltp@lists.linux.it>; Sat,  3 Aug 2024 12:23:05 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62C43300018D
 for <ltp@lists.linux.it>; Sat,  3 Aug 2024 12:23:03 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sat,  3 Aug 2024 20:22:58 +0800
Message-ID: <20240803122258.5479-1-liwang@redhat.com>
In-Reply-To: <CAEemH2c5uqD=x0OiPcH5aKJHCJ8vtQ0GdMoWZnZxXT4rLfCcYg@mail.gmail.com>
References: <CAEemH2c5uqD=x0OiPcH5aKJHCJ8vtQ0GdMoWZnZxXT4rLfCcYg@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mseal01: handle more possible errnos when pkey_alloc
 gets fail
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

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/mseal/mseal01.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/mseal/mseal01.c b/testcases/kernel/syscalls/mseal/mseal01.c
index eb2f4d588..2ff6ed119 100644
--- a/testcases/kernel/syscalls/mseal/mseal01.c
+++ b/testcases/kernel/syscalls/mseal/mseal01.c
@@ -25,6 +25,7 @@
 
 #include "tst_test.h"
 #include "lapi/syscalls.h"
+#include "../pkeys/pkey.h"
 
 #define MEMPAGES 8
 #define MEMSEAL 2
@@ -46,25 +47,19 @@ static void test_mprotect(void)
 
 static void test_pkey_mprotect(void)
 {
-	int ret;
 	int pkey;
 
-	pkey = tst_syscall(__NR_pkey_alloc, 0, 0);
-	if (pkey == -1) {
-		if (errno == EINVAL)
-			tst_brk(TCONF, "pku is not supported on this CPU");
+	check_pkey_support();
 
-		tst_brk(TBROK | TERRNO, "pkey_alloc() error");
-	}
+	pkey = ltp_pkey_alloc( 0, 0);
 
-	TST_EXP_FAIL(tst_syscall(__NR_pkey_mprotect,
+	TST_EXP_FAIL(ltp_pkey_mprotect(
 		mem_addr, mem_size,
 		PROT_NONE,
 		pkey),
 		EPERM);
 
-	ret = tst_syscall(__NR_pkey_free, pkey);
-	if (ret == -1)
+	if (ltp_pkey_free(pkey) == -1)
 		tst_brk(TBROK | TERRNO, "pkey_free() error");
 }
 
@@ -150,7 +145,6 @@ static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
-	.min_kver = "6.10",
 	.forks_child = 1,
 };
 
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
