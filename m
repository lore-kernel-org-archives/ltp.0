Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8AAC5475B
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 04:53:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 456223D1D93
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 05:53:27 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D74A3D1868
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 05:52:42 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D7C976012A8
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 05:52:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709873560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YO4g/X078Rgx0yR8fIjPrKlrZsdBctydie1yQ8x30DA=;
 b=CDUviz6MhK8M40F6V7eIhFsQ5pY0vEIbA0wXOMtBFzeCp9bdTiy+2iF7lhq2DhBaGMTAR8
 YNa2Fk40JchFh9gwE9SSGOeBf/D5O7OCeq5MrX9UKJ4km6Z06xDSVO9ipORQ6yajoNJ0wc
 qRhntNCqbRAcww4WVxn/xFqES/NnSag=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-1CK13DKxMoqJIZBfX5O6Ww-1; Thu, 07 Mar 2024 23:52:38 -0500
X-MC-Unique: 1CK13DKxMoqJIZBfX5O6Ww-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6834851780
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 04:52:38 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFEF3492BDC
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 04:52:37 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri,  8 Mar 2024 12:52:30 +0800
Message-Id: <20240308045230.3106549-3-liwang@redhat.com>
In-Reply-To: <20240308045230.3106549-1-liwang@redhat.com>
References: <20240308045230.3106549-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] stack_clash: make use of tst_kcmdline_parse
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
 testcases/cve/stack_clash.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/testcases/cve/stack_clash.c b/testcases/cve/stack_clash.c
index 56b970a1b..ae70dd866 100644
--- a/testcases/cve/stack_clash.c
+++ b/testcases/cve/stack_clash.c
@@ -44,6 +44,7 @@
 #include <stdlib.h>
 
 #include "tst_test.h"
+#include "tst_kconfig.h"
 #include "tst_safe_stdio.h"
 #include "lapi/mmap.h"
 
@@ -272,19 +273,16 @@ void do_child(void)
 
 void setup(void)
 {
-	char buf[4096], *p;
+	char *p;
 
 	page_size = sysconf(_SC_PAGESIZE);
 	page_mask = ~(page_size - 1);
 
-	buf[4095] = '\0';
-	SAFE_FILE_SCANF("/proc/cmdline", "%4095[^\n]", buf);
+	struct tst_kcmdline_param params = TST_KCMDLINE_INIT("stack_guard_gap");
+	tst_kcmdline_parse(&params, 1);
 
-	if ((p = strstr(buf, "stack_guard_gap=")) != NULL) {
-		if (sscanf(p, "stack_guard_gap=%ld", &GAP_PAGES) != 1) {
-			tst_brk(TBROK | TERRNO, "sscanf");
-			return;
-		}
+	if (params.value[0] != '\0') {
+		GAP_PAGES= atol(params.value);
 		tst_res(TINFO, "stack_guard_gap = %ld", GAP_PAGES);
 	}
 
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
