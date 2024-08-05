Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C36C3DA4A
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 06:53:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A9043D1FC0
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 08:53:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38DE93D1BC0
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 08:53:01 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A187A1000B54
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 08:53:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722840779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TtKhtdhSkp0QBuAI++79TpOcS4rwx3ozmDnlcRGytE4=;
 b=K7gdaL/7IFJDrkWnDDqqtrqksCzFp/E5DbffHqgXLOwu6d2tj4lUU3lbTWzPRgKKi13ZNo
 HVUwXgQ7BbjqFl16mFJb/lyBnWLDGxdEa9gupWtrjkjSnPGBd54da1/seJ5+Dk/9cR2FIv
 F8eSt4o7GMyX3sFODsTY7/Ly8d+/1kA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-oiXTShZXOTKd1ek5nMHPww-1; Mon,
 05 Aug 2024 02:52:57 -0400
X-MC-Unique: oiXTShZXOTKd1ek5nMHPww-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05C7319560B0
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 06:52:57 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8973A1955F40
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 06:52:54 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  5 Aug 2024 14:52:47 +0800
Message-ID: <20240805065247.13791-2-liwang@redhat.com>
In-Reply-To: <20240805065247.13791-1-liwang@redhat.com>
References: <20240805065247.13791-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] mseal01: handle more possible errnos when
 pkey_alloc gets fail
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
 testcases/kernel/syscalls/mseal/mseal01.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/mseal/mseal01.c b/testcases/kernel/syscalls/mseal/mseal01.c
index eb2f4d588..1de9fb723 100644
--- a/testcases/kernel/syscalls/mseal/mseal01.c
+++ b/testcases/kernel/syscalls/mseal/mseal01.c
@@ -25,6 +25,7 @@
 
 #include "tst_test.h"
 #include "lapi/syscalls.h"
+#include "lapi/pkey.h"
 
 #define MEMPAGES 8
 #define MEMSEAL 2
@@ -46,25 +47,21 @@ static void test_mprotect(void)
 
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
+	pkey = ltp_pkey_alloc(0, 0);
+	if (pkey == -1)
+		tst_brk(TBROK | TERRNO, "pkey_alloc failed");
 
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
 
@@ -150,7 +147,6 @@ static struct tst_test test = {
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
