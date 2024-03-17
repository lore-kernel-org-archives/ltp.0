Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D099C54E60
	for <ltp@archiver.kernel.org>; Sun, 17 Mar 2024 09:40:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93C5E3CFC54
	for <ltp@archiver.kernel.org>; Sun, 17 Mar 2024 10:39:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55FBE3CE6ED
 for <ltp@lists.linux.it>; Sun, 17 Mar 2024 10:39:15 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4F04460025C
 for <ltp@lists.linux.it>; Sun, 17 Mar 2024 10:39:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710668353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B3Y+P1jgaQw1PUP+XesSR447m5HcnX+TSVhypWpl+TE=;
 b=LJcfsTLYpxJZaGX1x0/iQ6iwKFleROriBo79MWdQy29B9TxyOwkHbL2WkqrrJ6l4ydoWFz
 QnTfPFDbehTdrCmSCZe2otK25VeWiIoZ3mK8TeSguaHnkUMyNVH7RzPdR6n8wNe1Z6ymFo
 QySJ9PCAwAMh+Yx8db59LF5nZQPzHQU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-VyFqfeXVPRCkefeafVMVjg-1; Sun, 17 Mar 2024 05:39:12 -0400
X-MC-Unique: VyFqfeXVPRCkefeafVMVjg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5F1E85A58C;
 Sun, 17 Mar 2024 09:39:11 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8705D202451F;
 Sun, 17 Mar 2024 09:39:10 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sun, 17 Mar 2024 17:39:01 +0800
Message-Id: <20240317093901.3212684-4-liwang@redhat.com>
In-Reply-To: <20240317093901.3212684-1-liwang@redhat.com>
References: <20240317093901.3212684-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/3] stack_clash: make use of tst_kcmdline_parse
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/cve/stack_clash.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/testcases/cve/stack_clash.c b/testcases/cve/stack_clash.c
index 56b970a1b..8cc2c20b5 100644
--- a/testcases/cve/stack_clash.c
+++ b/testcases/cve/stack_clash.c
@@ -44,6 +44,7 @@
 #include <stdlib.h>
 
 #include "tst_test.h"
+#include "tst_kconfig.h"
 #include "tst_safe_stdio.h"
 #include "lapi/mmap.h"
 
@@ -272,19 +273,14 @@ void do_child(void)
 
 void setup(void)
 {
-	char buf[4096], *p;
-
 	page_size = sysconf(_SC_PAGESIZE);
 	page_mask = ~(page_size - 1);
 
-	buf[4095] = '\0';
-	SAFE_FILE_SCANF("/proc/cmdline", "%4095[^\n]", buf);
+	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("stack_guard_gap");
+	tst_kcmdline_parse(&params, 1);
 
-	if ((p = strstr(buf, "stack_guard_gap=")) != NULL) {
-		if (sscanf(p, "stack_guard_gap=%ld", &GAP_PAGES) != 1) {
-			tst_brk(TBROK | TERRNO, "sscanf");
-			return;
-		}
+	if (params.found) {
+		GAP_PAGES= atol(params.value);
 		tst_res(TINFO, "stack_guard_gap = %ld", GAP_PAGES);
 	}
 
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
