Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA30E77188
	for <ltp@archiver.kernel.org>; Sun, 22 Dec 2024 07:23:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2F093E27F4
	for <ltp@archiver.kernel.org>; Sun, 22 Dec 2024 08:23:38 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 217DB3E2801
 for <ltp@lists.linux.it>; Sun, 22 Dec 2024 08:23:08 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D81C414225D6
 for <ltp@lists.linux.it>; Sun, 22 Dec 2024 08:23:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734852186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NyvFbkKIAQmM+miuWLolfe+AdstiKcQmzF38+Y2H4vc=;
 b=NRBAAA+BzXh0WtarblYdWZ+vBY5Xfa8zPyK6zOO11oIFy+/7qHrAcIK/MZ/x8OdUETYsPQ
 KXrCBZV54j+l1bQkWqA6HPQONaADxwMZ4L/MORACRS7fPWD04b9vxrg1kiCvY6VMtK64rO
 DTGDta9Nj5K3mdM0+oeYMikwUHPapXg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-O8y7JNNaOx28U3B-dm1dzg-1; Sun,
 22 Dec 2024 02:22:58 -0500
X-MC-Unique: O8y7JNNaOx28U3B-dm1dzg-1
X-Mimecast-MFC-AGG-ID: O8y7JNNaOx28U3B-dm1dzg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F13D1956089
 for <ltp@lists.linux.it>; Sun, 22 Dec 2024 07:22:58 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCDF019560A2
 for <ltp@lists.linux.it>; Sun, 22 Dec 2024 07:22:56 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sun, 22 Dec 2024 15:22:49 +0800
Message-ID: <20241222072251.13150-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iqX-9ZnrH6S5CejfhUhAu_DiE74jvP8_tYBo7CwsmyU_1734852178
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lib: multiply the timeout if detect slow kconfigs
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

This refines the handling of timeouts for tests running on
systems with slow kernel configurations (kconfigs).

Previously, the max_runtime was multiplied globally when
slow kconfigs were detected, which inadvertently prolonged
the runtime of all tests using max_runtime for control.

This patch corrects that behavior by applying the multiplication
specifically to timeouts, ensuring it only affects the intended
operations without impacting other tests.

Fixes: 2da30df24 ("lib: multiply the max_runtime if detect slow kconfigs")
Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/tst_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 205fc8326..feffc9f86 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -555,9 +555,6 @@ static int multiply_runtime(int max_runtime)
 
 	parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);
 
-	if (tst_has_slow_kconfig())
-		max_runtime *= 4;
-
 	return max_runtime * runtime_mul;
 }
 
@@ -1706,6 +1703,9 @@ unsigned int tst_multiply_timeout(unsigned int timeout)
 	if (timeout < 1)
 		tst_brk(TBROK, "timeout must to be >= 1! (%d)", timeout);
 
+	if (tst_has_slow_kconfig())
+		timeout *= 4;
+
 	return timeout * timeout_mul;
 }
 
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
