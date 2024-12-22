Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECFBE7718D
	for <ltp@archiver.kernel.org>; Sun, 22 Dec 2024 07:23:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 163D23E2807
	for <ltp@archiver.kernel.org>; Sun, 22 Dec 2024 08:23:22 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A90303E27EE
 for <ltp@lists.linux.it>; Sun, 22 Dec 2024 08:23:06 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C6CA2101197B
 for <ltp@lists.linux.it>; Sun, 22 Dec 2024 08:23:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734852183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/8/v4qwvxAGk5vR/HyKi8NRPILiA8YgPlta9Y/YjJpE=;
 b=XsI4gFKjOopL/C7Vn1mulhoSNFGP64HoUV9l6YMUV27PPSf1GbwHcgUCJqFXqT94AfHVpI
 1c50N7vo9LKyI0GR3N4EH46TbYvX5DcmJ3KVYqdE2lw7vu/O5dQCjaFvucSez81Ba+zBch
 9hU9rbZAATZ7X+Mu5qbFQJz8UouEbOg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-jNZsqHElPvy5nLcb69TYIg-1; Sun,
 22 Dec 2024 02:23:01 -0500
X-MC-Unique: jNZsqHElPvy5nLcb69TYIg-1
X-Mimecast-MFC-AGG-ID: jNZsqHElPvy5nLcb69TYIg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7405F1956088
 for <ltp@lists.linux.it>; Sun, 22 Dec 2024 07:23:00 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D2E119560A2
 for <ltp@lists.linux.it>; Sun, 22 Dec 2024 07:22:58 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sun, 22 Dec 2024 15:22:50 +0800
Message-ID: <20241222072251.13150-2-liwang@redhat.com>
In-Reply-To: <20241222072251.13150-1-liwang@redhat.com>
References: <20241222072251.13150-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BGa7gnM9TbJG6F1C9e7K4Q1bwgtwIXiS-B86zCUcQWc_1734852180
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] starvation: skip test on slow kernel
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

Systems with slow kernel configurations may not meet
the performance requirements necessary for the starvation
test to produce valid results.

Skipping the test ensures that it runs only on systems
where its results are meaningful.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/sched/cfs-scheduler/starvation.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
index e707e0865..0fd53a0ca 100644
--- a/testcases/kernel/sched/cfs-scheduler/starvation.c
+++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
@@ -21,6 +21,7 @@
 #include <sched.h>
 
 #include "tst_test.h"
+#include "tst_kconfig.h"
 #include "tst_safe_clocks.h"
 #include "tst_timer.h"
 
@@ -108,6 +109,9 @@ static void setup(void)
 	else
 		timeout = callibrate() / 1000;
 
+	if (tst_has_slow_kconfig())
+		tst_brk(TCONF, "Skip test due to slow kernel configuration");
+
 	tst_set_max_runtime(timeout);
 }
 
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
