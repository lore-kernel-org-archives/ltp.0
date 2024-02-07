Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C24EC4828D
	for <ltp@archiver.kernel.org>; Wed,  7 Feb 2024 16:07:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20DD13CF582
	for <ltp@archiver.kernel.org>; Wed,  7 Feb 2024 17:07:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 113253CC54A
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 17:06:36 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3EB521BBCF00
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 17:06:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 962B82230D;
 Wed,  7 Feb 2024 16:06:34 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B7C713931;
 Wed,  7 Feb 2024 16:06:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UFwlFYqqw2WRSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 Feb 2024 16:06:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  7 Feb 2024 17:06:26 +0100
Message-ID: <20240207160628.125908-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207160628.125908-1-pvorel@suse.cz>
References: <20240207160628.125908-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 962B82230D
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] lib: Add test for tst_tmpdir
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
 lib/newlib_tests/tst_tmpdir.c | 48 +++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 lib/newlib_tests/tst_tmpdir.c

diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index be707fe63..6c69e448d 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -5,7 +5,7 @@ LTP_C_API_TESTS="${LTP_C_API_TESTS:-test05 test07 test09 test15 test_runtime01
 tst_needs_cmds01 tst_needs_cmds02 tst_needs_cmds03 tst_needs_cmds06
 tst_needs_cmds07 tst_bool_expr test_exec test_timer tst_res_hexd tst_strstatus
 tst_fuzzy_sync03 test_zero_hugepage.sh test_kconfig.sh
-test_children_cleanup.sh}"
+test_children_cleanup.sh tst_tmpdir}"
 
 LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh
 shell/tst_check_kconfig0[1-5].sh shell/tst_errexit.sh shell/net/*.sh}"
diff --git a/lib/newlib_tests/tst_tmpdir.c b/lib/newlib_tests/tst_tmpdir.c
new file mode 100644
index 000000000..008542808
--- /dev/null
+++ b/lib/newlib_tests/tst_tmpdir.c
@@ -0,0 +1,48 @@
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
+	{"//var///tmp", "/var/tmp", "removing duplicate slashes"},
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
