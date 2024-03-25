Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A19C54E64
	for <ltp@archiver.kernel.org>; Mon, 25 Mar 2024 11:51:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A19F83CFB9C
	for <ltp@archiver.kernel.org>; Mon, 25 Mar 2024 12:51:27 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7B763CFEC9
 for <ltp@lists.linux.it>; Mon, 25 Mar 2024 12:50:43 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 67E75200C61
 for <ltp@lists.linux.it>; Mon, 25 Mar 2024 12:50:43 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1327F350C0;
 Mon, 25 Mar 2024 11:50:41 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E598513A2E;
 Mon, 25 Mar 2024 11:50:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id IJ2ONhBlAWZSCQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 25 Mar 2024 11:50:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 25 Mar 2024 12:50:33 +0100
Message-ID: <20240325115034.643892-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325115034.643892-1-pvorel@suse.cz>
References: <20240325115034.643892-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Queue-Id: 1327F350C0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] lib: Add test for tst_tmpdir
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
 lib/newlib_tests/runtest.sh   |  2 +-
 lib/newlib_tests/tst_tmpdir.c | 49 +++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 lib/newlib_tests/tst_tmpdir.c

diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index 8f2a497b1..7bdc870bc 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -5,7 +5,7 @@ LTP_C_API_TESTS="${LTP_C_API_TESTS:-test05 test07 test09 test15 test_runtime01
 tst_needs_cmds01 tst_needs_cmds02 tst_needs_cmds03 tst_needs_cmds06
 tst_needs_cmds07 tst_bool_expr test_exec test_timer tst_res_hexd tst_strstatus
 tst_fuzzy_sync03 test_zero_hugepage.sh test_kconfig.sh test_kconfig03
-test_children_cleanup.sh}"
+test_children_cleanup.sh tst_tmpdir}"
 
 LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh
 shell/tst_check_kconfig0[1-5].sh shell/tst_errexit.sh shell/net/*.sh}"
diff --git a/lib/newlib_tests/tst_tmpdir.c b/lib/newlib_tests/tst_tmpdir.c
new file mode 100644
index 000000000..c34430fa6
--- /dev/null
+++ b/lib/newlib_tests/tst_tmpdir.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Petr Vorel <pvorel@suse.cz>
+ */
+
+/*
+ * Tests TMPDIR variable cleanup.
+ */
+
+#include <stdlib.h>
+#include "tst_defaults.h"
+#include "tst_test.h"
+
+static struct tcase {
+	const char *orig;
+	const char *fixed;
+	const char *desc;
+} tcases[] = {
+	{NULL, TEMPDIR, "default value"},
+	{"/tmp/", "/tmp", "removing trailing slash"},
+	{"/var//tmp", "/var/tmp", "removing duplicate slashes"},
+	{"//var///tmp///", "/var/tmp", "removing too many slashes"},
+};
+
+static void do_test(unsigned int nr)
+{
+	struct tcase *tc = &tcases[nr];
+	const char *env_tmpdir;
+
+	tst_res(TINFO, "Testing TMPDIR='%s' (%s)", tc->orig, tc->desc);
+
+	if (tc->orig)
+		SAFE_SETENV("TMPDIR", tc->orig, 1);
+
+	env_tmpdir = tst_get_tmpdir_root();
+
+	if (!env_tmpdir)
+		tst_brk(TBROK, "Failed to get TMPDIR");
+
+	if (!strcmp(tc->fixed, env_tmpdir))
+		tst_res(TPASS, "TMPDIR '%s' is '%s'", env_tmpdir, tc->fixed);
+	else
+		tst_res(TFAIL, "TMPDIR '%s' should be '%s'", env_tmpdir, tc->fixed);
+}
+
+static struct tst_test test = {
+	.test = do_test,
+	.tcnt = ARRAY_SIZE(tcases),
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
