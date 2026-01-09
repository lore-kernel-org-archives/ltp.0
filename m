Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89DED16812
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 11:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767956956; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=7DgvCUjGYAYec0FjDslC0eh/AvdlT70ToE2xoxFLHgY=;
 b=mkT2gEK6cagsqIkX0FeVt+IU2FnhQkhJGZIqKrVgT35UkMw1g1JB9FlhLQUjT4D9wVP6x
 33UK4d45beOQYKnT4Xmi8Et1GRk3ThrvI6QoAruRTed5f0FJVBZZSvIWIYtRvQMDxdKhLJB
 SF2Q+QXteIkG3CycS3tZqz11H6NqMeE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F34EF3C76F0
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 12:09:15 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4E193C6AA3
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 12:08:51 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4E703600158
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 12:08:50 +0100 (CET)
Received: from localhost.localdomain (2.general.phlin.uk.vpn [10.172.194.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4B27D403C7; 
 Fri,  9 Jan 2026 11:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767956930;
 bh=3rWzqABDFvdqhAlArSmGlaI/0Aze2wBlTtKRb4NqeYE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=TRosPXcl0kWaTzPmXrCqCfwCl0rtae70phQghINcGlzP7SEJzU7sFk3AS6xFQ7elv
 zT7mXzaBH21hNheGlH5ZdNla8DN7Cl+ZsiFKo9Y5tdZKRzf7ZdKbr5aTunc97OCC1I
 FSGHMT9oTaPvClLGkoBHvN9wUZnNDSMIvoy4r1tOyuvVRblXCycZr6fQod83rNfeIs
 LNp0gHmAh7HkPTKkwH93VMafoAY/RxoIaSuKPfuP0FkveD8bQEQDkd1avqgsxJfvZa
 9y5KVj9B68Fj+UNpiJxpA0od3hukBQ6Bzk5zE2zJiAiA07IT4kHx9o7htqciekVhHJ
 cLEIozVjvBRlCjIxoy81BL9wJMlKfqJpV0A37E7tYZvoVjsGgHa41hFQjCk/xGLla4
 UZ9DmOvbKoDHuIzJQJw8PBixYKw7HAXvmhBdE9jQVLmhKamMGYh7kNdlMyLikpnC7C
 rDYLlUuxdlv30dHVtx0QtUoqAeBZ1afpmjjnSLnxMqYG7/hbbVxSvsBtaXGMcekqCK
 z6jkjzoF51hJlaI4vwwihmkRG64+hGmo+zjeeVFQZulMIHessN61JuveFbYDrx68CG
 BFzMb7G0hek5iSfaAa2LcUp1ybLETLkQt6h0BlWrDdJYuljhmwUzDQHjY7ecU+FYea
 hczd0VYenc6EiulpKynHV2I0=
To: ltp@lists.linux.it
Date: Fri,  9 Jan 2026 19:08:15 +0800
Message-ID: <20260109110815.198224-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] block_dev.c: Skip on Lockdown/Secure Boot
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
From: Po-Hsu Lin via ltp <ltp@lists.linux.it>
Reply-To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc: po-hsu.lin@canonical.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Following the commit ca9460deef ("fw_load: Skip on Lockdown/Secure Boot")
to take care of:

tst_module.c:139: TINFO: module signature enforcement: off
insmod: ERROR: could not insert module ltp_block_dev.ko: Key was rejected by service
tst_cmd.c:112: TBROK: 'insmod' exited with a non-zero code 1 at tst_cmd.c:112

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 .../device-drivers/block/block_dev_user/block_dev.c       | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c b/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
index cd900d807..631e6da4e 100644
--- a/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
+++ b/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
@@ -17,6 +17,7 @@
 
 #include "tst_test.h"
 #include "tst_module.h"
+#include "tst_security.h"
 
 #define MODULE_NAME "ltp_block_dev"
 #define MODULE_NAME_KO	MODULE_NAME ".ko"
@@ -31,6 +32,12 @@ static struct tst_option options[] = {
 	{}
 };
 
+static void setup(void)
+{
+	if (tst_lockdown_enabled() > 0 || tst_secureboot_enabled() > 0)
+		tst_brk(TCONF, "Cannot load unsigned modules in Lockdown/Secure Boot");
+}
+
 static void cleanup(void)
 {
 	if (module_loaded)
@@ -39,6 +46,7 @@ static void cleanup(void)
 
 static void run(unsigned int n)
 {
+	setup();
 	tst_requires_module_signature_disabled();
 
 	/*
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
