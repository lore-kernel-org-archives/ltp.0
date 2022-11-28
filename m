Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BE9C433FE
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 11:19:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0B993CC677
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 12:19:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A81A23CC679
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 12:18:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 215781A000B1
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 12:18:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669634328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pr5HIMR0w6QdoiesNOI2D9bXykl6OmQdFpvycEZjmoA=;
 b=aevgQN4EsmS9ohVgiQtDncJGTgCUYBlYoHsBYZEk4unCYRaryuR0XAYMm3xHMr3QfMT0sA
 sSysg3Y/+Mi8Btmf+MsrKYSiCZ8mhRu5iepxRksraSF7SbihYfWy+Vx+V1IRjTm4ZvoFa3
 brtBB8xoH5XSsMcRMMV7l7uFCobPoe8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-40PWllMFOj-TYVP2CHoCIw-1; Mon, 28 Nov 2022 06:18:43 -0500
X-MC-Unique: 40PWllMFOj-TYVP2CHoCIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED7D31C0514A;
 Mon, 28 Nov 2022 11:18:42 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC553C15BA4;
 Mon, 28 Nov 2022 11:18:41 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 28 Nov 2022 12:18:33 +0100
Message-Id: <20221128111833.98937-4-david@redhat.com>
In-Reply-To: <20221128111833.98937-1-david@redhat.com>
References: <20221128111833.98937-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 3/3] syscalls/userfaultfd01: Remove compile-time
 TCONF handling
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
Cc: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Let's remove the conditional compile-time TCONF handling by including
include/lapi/userfaultfd.h .

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 testcases/kernel/syscalls/userfaultfd/userfaultfd01.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
index 2dae2ec78..c2c684d2b 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
@@ -12,13 +12,11 @@
 #include "config.h"
 #include "tst_test.h"
 
-#ifdef HAVE_LINUX_USERFAULTFD_H
-#include <linux/userfaultfd.h>
 #include <poll.h>
 
 #include "tst_safe_macros.h"
 #include "tst_safe_pthread.h"
-#include "lapi/syscalls.h"
+#include "lapi/userfaultfd.h"
 
 static int page_size;
 static char *page;
@@ -122,7 +120,3 @@ static struct tst_test test = {
 	.test_all = run,
 	.min_kver = "4.3",
 };
-
-#else
-	TST_TEST_TCONF("This system does not provide userfaultfd support");
-#endif
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
