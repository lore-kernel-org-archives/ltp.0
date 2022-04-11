Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3413FC433F5
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 09:41:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7181C3CA51B
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 11:41:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DE703CA52C
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 11:40:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4DFE1100065F
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 11:40:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649670053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JV15oEOS1c2o9AhY8Am6KkVk7gZDqpagyVGgO7LtX4o=;
 b=TNkVxN43dTnFflDuUVOaul1ThqNxk0ecjVy9FCQF4ZwYTrrdL4RQLq2pxNSnGog0qxXiYz
 O1SVKO2qGhbtqZJh0xqITnix7L1xYxXlfDYgVorEeFnoQFrTo1GGHlsHalmoebV0KJt363
 5yKxakZLolQNeCMzlOIkqAabz33CCi8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-364-dFayDiXWOI2xNhdqkvF32A-1; Mon, 11 Apr 2022 05:40:52 -0400
X-MC-Unique: dFayDiXWOI2xNhdqkvF32A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12D80800882
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 09:40:52 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 280CBC28106
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 09:40:50 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 11 Apr 2022 17:40:48 +0800
Message-Id: <20220411094048.1143292-2-liwang@redhat.com>
In-Reply-To: <20220411094048.1143292-1-liwang@redhat.com>
References: <20220411094048.1143292-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] pkey: correct the PKEY_DISABLE_ACCESS definitions
 on PowerPC
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

Reference: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e9506394a159

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/pkeys/pkey.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testcases/kernel/syscalls/pkeys/pkey.h b/testcases/kernel/syscalls/pkeys/pkey.h
index 6e32326b6..6cda88ff1 100644
--- a/testcases/kernel/syscalls/pkeys/pkey.h
+++ b/testcases/kernel/syscalls/pkeys/pkey.h
@@ -11,6 +11,13 @@
 #include "lapi/syscalls.h"
 #include "lapi/mmap.h"
 
+#if defined(__powerpc__) || defined(__ppc__)
+# undef PKEY_DISABLE_ACCESS
+# define PKEY_DISABLE_ACCESS 0x3
+# undef PKEY_DISABLE_WRITE
+# define PKEY_DISABLE_WRITE  0x2
+#endif
+
 #ifndef PKEY_DISABLE_ACCESS
 # define PKEY_DISABLE_ACCESS 0x1
 # define PKEY_DISABLE_WRITE  0x2
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
