Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5234FCCF9E3
	for <ltp@archiver.kernel.org>; Thu, 30 Oct 2025 11:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761824172; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=SPLlDb3slLNMpNJvRzI1Ao+6rNSsyY0IARsBY+7F0t0=;
 b=dbHlsB5hqdY1AteksrPljL+c65hVNS9F4HAK+xrOiXXr+oGPeljRYMmZhf99z+/eFdfjV
 ZqnBkNbgAS38T+pThTray2gf6jih0Fr0OIRuWWFEcwEYCQ/eLEJnDTEy/dPKz4aiikxqbbE
 iwVa/2pf5MTZjvIg9pgP59a3ev6UDc0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C34203CBD5E
	for <ltp@archiver.kernel.org>; Thu, 30 Oct 2025 12:36:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE30A3CBB28
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 12:35:50 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E3E151A00A56
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 12:35:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761824148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4FrkizS6jAmDJM8fN9sLQsju55Q9SpC8VCt79OVFFbM=;
 b=Ob9pUf5aBJsic2gCdPSqwAVAzvhZGFYCzPU+yT5kA2jmzWy6nSgq39Uc7M7qy25vJ9qrHB
 KKonRVg0DhN0oefyA7QI6rCJmpz131lfFY9ukb9jUmc7VQEFtjhIbFV87V6VMCRseAuchn
 eR/JqwmQUnT+5uMc7NyeDQKwutsoq+8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-x7tE0ZJXPtS2IkvnnHIjeg-1; Thu,
 30 Oct 2025 07:35:46 -0400
X-MC-Unique: x7tE0ZJXPtS2IkvnnHIjeg-1
X-Mimecast-MFC-AGG-ID: x7tE0ZJXPtS2IkvnnHIjeg_1761824146
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA1E51805A0D
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 11:35:45 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.234])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1FF5B19560B6; Thu, 30 Oct 2025 11:35:42 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 30 Oct 2025 19:35:34 +0800
Message-ID: <20251030113534.67798-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h2hEYaQMyRnCGCptalXU8aVrI3gBjGdW4XAYvtKdtBo_1761824146
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugeshmctl02: set 2 huge pages as an enforced
 requirement
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: Luiz Capitulino <luizcap@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Set hugeshmctl02 to require exactly 2 HugeTLB pages and bail out
cleanly if unavailable. To prevent shmget EINVAL failures seen when
the environment cannot provide enough hugepages.

Stabilizes the test across constrained systems while keeping functional
intent intact.

  === error log ===
  cmdline="hugeshmctl02 -s 1 -i 5;"
  tst_hugepage.c:84: TINFO: 1 hugepage(s) reserved
  tst_test.c:1709: TINFO: LTP version: 20240129
  tst_test.c:1595: TINFO: Timeout per run is 0h 00m 30s
  hugeshmctl02.c:105: TINFO: Testing variant: libc shmctl()
  hugeshmctl02.c:119: TBROK: shmget #1: EINVAL (22)

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Luiz Capitulino <luizcap@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index d3f711129..82126f52c 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -143,5 +143,5 @@ static struct tst_test test = {
 	},
 	.setup = setup,
 	.cleanup = cleanup,
-	.hugepages = {128, TST_REQUEST},
+	.hugepages = {2, TST_NEEDS},
 };
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
