Return-Path: <SRS0=uWjX=OO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51374C433EF
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 07:08:41 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A94E8610C7
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 07:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A94E8610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BE5E3C8F1E
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 09:08:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE3D43C78C9
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 09:08:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0245960111B
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 09:08:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632467287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pqswdqExKu4Sw878o9hjKb2cwfKX9jBaS/HnpjxOG+I=;
 b=M9BO4kTANOf1uRmUFOPmzpzDbKcFvlc/98UFlmguSKKZFWTgJPM0BlOP2AmdSyGSR+ZNbQ
 eTaZGsV3ON632QC4t6YYIVgXb5HOhRvgsZUqshogLcLhta+gx9qeiIaoi91zxvpf2XWrpc
 nOztsL5H2FNes7Y8MmN4Hm39DhqFOEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-D8KMt1mLMDmoDoWbzsMo0A-1; Fri, 24 Sep 2021 03:08:04 -0400
X-MC-Unique: D8KMt1mLMDmoDoWbzsMo0A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D81F5802C80;
 Fri, 24 Sep 2021 07:08:03 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB94E19724;
 Fri, 24 Sep 2021 07:08:02 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 24 Sep 2021 15:07:55 +0800
Message-Id: <20210924070756.3916953-2-liwang@redhat.com>
In-Reply-To: <20210924070756.3916953-1-liwang@redhat.com>
References: <20210924070756.3916953-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] swapping01: make use of tst_available_mem
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
 testcases/kernel/mem/include/mem.h         | 1 +
 testcases/kernel/mem/swapping/swapping01.c | 6 +-----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 10712cf0c..f995f45b0 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -4,6 +4,7 @@
 #include "tst_test.h"
 #include "tst_cgroup.h"
 #include "ksm_helper.h"
+#include "tst_memutils.h"
 
 #if defined(__powerpc__) || defined(__powerpc64__)
 #define MAXNODES		256
diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index 66fc65cbe..392b79d65 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -83,11 +83,7 @@ static void test_swapping(void)
 static void init_meminfo(void)
 {
 	swap_free_init = SAFE_READ_MEMINFO("SwapFree:");
-	if (FILE_LINES_SCANF("/proc/meminfo", "MemAvailable: %ld",
-		&mem_available_init)) {
-		mem_available_init = SAFE_READ_MEMINFO("MemFree:")
-			+ SAFE_READ_MEMINFO("Cached:");
-	}
+	mem_available_init = tst_available_mem();
 	mem_over = mem_available_init * COE_SLIGHT_OVER;
 	mem_over_max = mem_available_init * COE_DELTA;
 
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
