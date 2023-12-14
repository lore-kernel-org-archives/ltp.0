Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4936C4332F
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 15:20:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 809A43CE5AE
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 16:20:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D5F33CB4B6
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 16:20:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1502E600A8C
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 16:20:01 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6598921F6F;
 Thu, 14 Dec 2023 15:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702567200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Z2oTG7SNbISPLOMbTDwAJg+d85rhfCkxnTPj47uDd0=;
 b=ff/IZG1MfeotbrG8BjHzxEyTJVbUsz+HNQ47x37p8lJbXcnCXn0m7KhAMCljaAy9onEQa2
 Qw2QtWil9G0AHlB4J1bKiByzcjTKLuxMd5b5J9TB5fbqTdZ+6zU4dZGHDGltYbQTQ8uG6H
 G3Uhy75Pc8sO3OeCWooNOq5seL9YO0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702567200;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Z2oTG7SNbISPLOMbTDwAJg+d85rhfCkxnTPj47uDd0=;
 b=xBnMHEY1K/wjFCJB5mUK5PfR50d24a55JwsSHDg27tiHkTaEpwDqgMtJw6rkDxQ7pKlrm3
 1rF36S5NjZT3i3CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702567200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Z2oTG7SNbISPLOMbTDwAJg+d85rhfCkxnTPj47uDd0=;
 b=ff/IZG1MfeotbrG8BjHzxEyTJVbUsz+HNQ47x37p8lJbXcnCXn0m7KhAMCljaAy9onEQa2
 Qw2QtWil9G0AHlB4J1bKiByzcjTKLuxMd5b5J9TB5fbqTdZ+6zU4dZGHDGltYbQTQ8uG6H
 G3Uhy75Pc8sO3OeCWooNOq5seL9YO0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702567200;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Z2oTG7SNbISPLOMbTDwAJg+d85rhfCkxnTPj47uDd0=;
 b=xBnMHEY1K/wjFCJB5mUK5PfR50d24a55JwsSHDg27tiHkTaEpwDqgMtJw6rkDxQ7pKlrm3
 1rF36S5NjZT3i3CA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C37213AB3;
 Thu, 14 Dec 2023 15:19:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id UKvgBR8de2WpJwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 14 Dec 2023 15:19:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 14 Dec 2023 16:19:45 +0100
Message-ID: <20231214151954.840244-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214151954.840244-1-pvorel@suse.cz>
References: <20231214151954.840244-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[6]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.978]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 01/10] lib/tests: Add test for testing tst_res()
 flags
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
 lib/newlib_tests/shell/tst_res_flags.sh | 24 +++++++++++++++
 lib/newlib_tests/tst_res_flags.c        | 41 +++++++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100755 lib/newlib_tests/shell/tst_res_flags.sh
 create mode 100644 lib/newlib_tests/tst_res_flags.c

diff --git a/lib/newlib_tests/shell/tst_res_flags.sh b/lib/newlib_tests/shell/tst_res_flags.sh
new file mode 100755
index 000000000..bca3d26c0
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_res_flags.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2023 Petr Vorel <pvorel@suse.cz>
+
+TST_TESTFUNC=test
+TST_CLEANUP=cleanup
+
+test()
+{
+	tst_res TPASS "TPASS message"
+	tst_res TFAIL "TFAIL message"
+	tst_res TBROK "TBROK message"
+	tst_res TCONF "TCONF message"
+	tst_res TWARN "TWARN message"
+	tst_res TINFO "TINFO message"
+}
+
+cleanup()
+{
+	tst_brk TBROK "TBROK message should be TWARN in cleanup"
+}
+
+. tst_test.sh
+tst_run
diff --git a/lib/newlib_tests/tst_res_flags.c b/lib/newlib_tests/tst_res_flags.c
new file mode 100644
index 000000000..85eee09a6
--- /dev/null
+++ b/lib/newlib_tests/tst_res_flags.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Petr Vorel <pvorel@suse.cz>
+ */
+
+/*
+ * Test tst_res() flags.
+ */
+
+#include "tst_test.h"
+
+#define FLAG(x) .flag = x, .str = #x
+static struct tcase {
+	int flag;
+	const char *str;
+} tcases[] = {
+	{FLAG(TPASS)},
+	{FLAG(TFAIL)},
+	{FLAG(TBROK)},
+	{FLAG(TCONF)},
+	{FLAG(TWARN)},
+	{FLAG(TINFO)},
+};
+
+static void do_cleanup(void)
+{
+	tst_brk(TBROK, "TBROK message should be TWARN in cleanup");
+}
+
+static void do_test(void)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(tcases); i++)
+		tst_res(tcases[i].flag, "%s message", tcases[i].str);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.cleanup = do_cleanup,
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
