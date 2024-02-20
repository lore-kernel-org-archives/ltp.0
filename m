Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B19C48BC3
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 13:13:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D0A33CF1E3
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 14:13:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E0CA3CDA3B
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 14:13:25 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 671D120D393
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 14:13:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E40DB220DA;
 Tue, 20 Feb 2024 13:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708434803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0nLbEwsXYvXw62K5G/K/suoBx31Y5U+wDpOerpThLr8=;
 b=pXmRHV46vFos3zaTRdODGGXFeMxDxR5Mf5yy+G3o+X6hqcyTQoHE0hzFJe8VJv58QW1KYg
 oz9y9l/q07WpEUQTsMaytceCjcBI6mp6AlX49wBnxryTy2q+xO3jdkP69DQfZe3pVR39pp
 Xeu/LXC+W5ENNfq1wdA8KkbVJCZFqWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708434803;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0nLbEwsXYvXw62K5G/K/suoBx31Y5U+wDpOerpThLr8=;
 b=AT8LNd9g93s+J0Ohkgfs8mBlQIkBs9pXZ4SkZq4wWI/wTF2KjpS/EBN7sNXsxI+XWDExFH
 CZSBOyBOtaU6t0Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708434803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0nLbEwsXYvXw62K5G/K/suoBx31Y5U+wDpOerpThLr8=;
 b=pXmRHV46vFos3zaTRdODGGXFeMxDxR5Mf5yy+G3o+X6hqcyTQoHE0hzFJe8VJv58QW1KYg
 oz9y9l/q07WpEUQTsMaytceCjcBI6mp6AlX49wBnxryTy2q+xO3jdkP69DQfZe3pVR39pp
 Xeu/LXC+W5ENNfq1wdA8KkbVJCZFqWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708434803;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0nLbEwsXYvXw62K5G/K/suoBx31Y5U+wDpOerpThLr8=;
 b=AT8LNd9g93s+J0Ohkgfs8mBlQIkBs9pXZ4SkZq4wWI/wTF2KjpS/EBN7sNXsxI+XWDExFH
 CZSBOyBOtaU6t0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0C1B139D0;
 Tue, 20 Feb 2024 13:13:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OR1aKHOl1GXEIgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Feb 2024 13:13:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 20 Feb 2024 14:13:19 +0100
Message-Id: <20240220131319.11761-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.43 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.27)[73.95%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add chmod08 test
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

This test has been extracted from symlink01 and it verifies that
chmod() is working correctly on symlink() generated files.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/chmod/chmod08.c | 61 +++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 testcases/kernel/syscalls/chmod/chmod08.c

diff --git a/testcases/kernel/syscalls/chmod/chmod08.c b/testcases/kernel/syscalls/chmod/chmod08.c
new file mode 100644
index 000000000..f9ca4e45a
--- /dev/null
+++ b/testcases/kernel/syscalls/chmod/chmod08.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *    Author: David Fenner
+ *    Copilot: Jon Hendrickson
+ * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that chmod() is working correctly on symlink()
+ * generated files.
+ */
+
+#include "tst_test.h"
+
+#define PERMS 01777
+#define TESTFILE "myobject"
+
+static char testfile[PATH_MAX];
+
+static void run(void)
+{
+	char *symname = "my_symlink0";
+	struct stat oldsym_stat;
+	struct stat newsym_stat;
+
+	SAFE_TOUCH(testfile, 0644, NULL);
+	SAFE_SYMLINK(testfile, symname);
+	SAFE_STAT(symname, &oldsym_stat);
+
+	TST_EXP_PASS(chmod(symname, PERMS));
+	SAFE_STAT(symname, &newsym_stat);
+
+	TST_EXP_EQ_LI(newsym_stat.st_mode & PERMS, PERMS);
+	TST_EXP_EXPR(oldsym_stat.st_mode != newsym_stat.st_mode,
+		"file mode has changed");
+
+	SAFE_UNLINK(symname);
+	remove(testfile);
+}
+
+static void setup(void)
+{
+	int tmplen;
+	char *tmpdir;
+
+	tmpdir = tst_get_tmpdir();
+	tmplen = strlen(tmpdir);
+
+	testfile[tmplen] = '/';
+	memcpy(testfile, tmpdir, tmplen);
+	memcpy(testfile + tmplen + 1, TESTFILE, strlen(TESTFILE));
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_tmpdir = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
