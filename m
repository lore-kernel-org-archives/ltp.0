Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C818C282C1
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 17:26:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5F4F3C9E88
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 18:26:43 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 944113C9E92
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 18:25:06 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2DAE7142F208
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 18:25:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4D4C91F460;
 Fri, 28 Feb 2025 17:24:45 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B860413AAB;
 Fri, 28 Feb 2025 17:24:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WNmXJ1zxwWeQcQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Feb 2025 17:24:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 28 Feb 2025 18:24:38 +0100
Message-ID: <20250228172439.3276777-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250228172439.3276777-1-pvorel@suse.cz>
References: <20250228172439.3276777-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 4D4C91F460
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 5/5] shell: Add shell_loader_setup_cleanup.sh test
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/run_tests.sh                    |  1 +
 .../lib/tests/shell_loader_setup_cleanup.sh   | 29 +++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100755 testcases/lib/tests/shell_loader_setup_cleanup.sh

diff --git a/testcases/lib/run_tests.sh b/testcases/lib/run_tests.sh
index 128cee3377..5c309bbeb5 100755
--- a/testcases/lib/run_tests.sh
+++ b/testcases/lib/run_tests.sh
@@ -10,6 +10,7 @@ shell_loader_kconfigs.sh
 shell_loader_supported_archs.sh
 shell_loader_tcnt.sh
 shell_loader_cleanup.sh
+shell_loader_setup_cleanup.sh
 shell_test01
 shell_test02
 shell_test03
diff --git a/testcases/lib/tests/shell_loader_setup_cleanup.sh b/testcases/lib/tests/shell_loader_setup_cleanup.sh
new file mode 100755
index 0000000000..6a065922b0
--- /dev/null
+++ b/testcases/lib/tests/shell_loader_setup_cleanup.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2025 Petr Vorel <pvorel@suse.cz>
+#
+# ---
+# env
+# {
+# }
+# ---
+
+TST_SETUP=setup
+TST_CLEANUP=cleanup
+
+setup()
+{
+	tst_res TINFO "setup executed"
+}
+
+cleanup()
+{
+	tst_res TINFO "Cleanup executed"
+}
+
+tst_test()
+{
+	tst_res TPASS "Test is executed"
+}
+
+. tst_loader.sh
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
