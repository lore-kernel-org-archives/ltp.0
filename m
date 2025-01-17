Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C38C02185
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 07:18:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CB973C7C2D
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 08:18:26 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38CE13C796A
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 08:18:10 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8CA5F63F2A7
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 08:18:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737098287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/VkMziVQWF2DCZj6MDlnwCM3FUhnTP5sAZK1C7GSOoo=;
 b=DycFPG9f2J1ezrt+s6PUsBaXhky40P1K0fDMAN3rUNAqoTLnN8FoXSWZ5Um3YkqJbOSLLq
 GNSdG6TiWiUmlFVDWmd1gkNl40uxa/87STjri9YNSvYEld2TFqfKEbubaQcKWNOKypjdmX
 aC69YxH+wDrF2g/ORbZpHx4upTUse9s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-EZfrIQ9MPbSYlIxyoqo4Cg-1; Fri,
 17 Jan 2025 02:18:06 -0500
X-MC-Unique: EZfrIQ9MPbSYlIxyoqo4Cg-1
X-Mimecast-MFC-AGG-ID: EZfrIQ9MPbSYlIxyoqo4Cg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 436661956048; Fri, 17 Jan 2025 07:18:05 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B93130001BE; Fri, 17 Jan 2025 07:18:02 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 17 Jan 2025 15:17:58 +0800
Message-ID: <20250117071758.120366-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S2cpnMKGC0mkagRgY46P5NLy_iqWA94m2HApwr1-8Tg_1737098285
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: add TST_NO_SLOW_KCONFIG_CHECK macro for testcase
 tools
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

The macro TST_NO_SLOW_KCONFIG_CHECK is added to control whether
the tst_has_slow_kconfig() function (which presumably checks for
slow kernel configurations) should be executed.

This allows test cases and tools to opt out of this additional
check, enabling more flexible and faster test execution in
certain scenarios.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/tst_test.c                    | 2 ++
 testcases/lib/tst_device.c        | 1 +
 testcases/lib/tst_get_free_pids.c | 1 +
 testcases/lib/tst_ns_create.c     | 1 +
 testcases/lib/tst_ns_exec.c       | 1 +
 testcases/lib/tst_run_shell.c     | 1 +
 6 files changed, 7 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index b204ad975..00d34b6f0 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1702,8 +1702,10 @@ unsigned int tst_multiply_timeout(unsigned int timeout)
 	if (timeout < 1)
 		tst_brk(TBROK, "timeout must to be >= 1! (%d)", timeout);
 
+#ifndef TST_NO_SLOW_KCONFIG_CHECK
 	if (tst_has_slow_kconfig())
 		timeout *= 4;
+#endif
 
 	return timeout * timeout_mul;
 }
diff --git a/testcases/lib/tst_device.c b/testcases/lib/tst_device.c
index 45f77a38b..386636610 100644
--- a/testcases/lib/tst_device.c
+++ b/testcases/lib/tst_device.c
@@ -8,6 +8,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #define TST_NO_DEFAULT_MAIN
+#define TST_NO_SLOW_KCONFIG_CHECK
 #include "tst_test.h"
 #include "old/old_device.h"
 
diff --git a/testcases/lib/tst_get_free_pids.c b/testcases/lib/tst_get_free_pids.c
index 370ec3e26..c6436687a 100644
--- a/testcases/lib/tst_get_free_pids.c
+++ b/testcases/lib/tst_get_free_pids.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #define TST_NO_DEFAULT_MAIN
+#define TST_NO_SLOW_KCONFIG_CHECK
 #include <stdio.h>
 #include "tst_test.h"
 
diff --git a/testcases/lib/tst_ns_create.c b/testcases/lib/tst_ns_create.c
index ce3707a60..8c22ad449 100644
--- a/testcases/lib/tst_ns_create.c
+++ b/testcases/lib/tst_ns_create.c
@@ -17,6 +17,7 @@
  */
 
 #define TST_NO_DEFAULT_MAIN
+#define TST_NO_SLOW_KCONFIG_CHECK
 
 #include <stdio.h>
 #include <string.h>
diff --git a/testcases/lib/tst_ns_exec.c b/testcases/lib/tst_ns_exec.c
index 6a8e39339..ca5b717da 100644
--- a/testcases/lib/tst_ns_exec.c
+++ b/testcases/lib/tst_ns_exec.c
@@ -14,6 +14,7 @@
  */
 
 #define TST_NO_DEFAULT_MAIN
+#define TST_NO_SLOW_KCONFIG_CHECK
 
 #include <stdio.h>
 #include <sys/wait.h>
diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
index 7a446e004..b12a1e9f6 100644
--- a/testcases/lib/tst_run_shell.c
+++ b/testcases/lib/tst_run_shell.c
@@ -5,6 +5,7 @@
 #include <sys/mount.h>
 
 #define TST_NO_DEFAULT_MAIN
+#define TST_NO_SLOW_KCONFIG_CHECK
 #include "tst_test.h"
 #include "tst_safe_stdio.h"
 #include "ujson.h"
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
