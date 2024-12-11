Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6D7E77182
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 12:21:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C602A3E7D06
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 13:21:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EE143E88F3
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 13:20:28 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8636F101D8DF
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 13:20:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CAC7C1F46E
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733919626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sQD0F71QcruvpNzVJCZfHC8qI8kHuJbwzZ3XWYI5d+Q=;
 b=riIhYCwU09sB/TUbZLt4OBAPtqX6EFQKlV90Je0bR9v5voOpbGFwsQiQyClMGtXXEvj5ou
 JwvzfNJ8BnjRgW4pQME9opXpDcdjGoDYlkJRLhRb79dGZXH+KE6kB9zcTc5HTMpWrgjsA0
 v2r0S4ZUm4Fd8+f7rjNzWUP4+emarpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733919626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sQD0F71QcruvpNzVJCZfHC8qI8kHuJbwzZ3XWYI5d+Q=;
 b=7DVgBc3OM5F/6O/eJKwv5bvBcFKbd0Y7MzhsbMw0836YleTfB7Df5iMmftd+G1KDNgDd77
 MeJ1nL66eVMIxPAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733919626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sQD0F71QcruvpNzVJCZfHC8qI8kHuJbwzZ3XWYI5d+Q=;
 b=riIhYCwU09sB/TUbZLt4OBAPtqX6EFQKlV90Je0bR9v5voOpbGFwsQiQyClMGtXXEvj5ou
 JwvzfNJ8BnjRgW4pQME9opXpDcdjGoDYlkJRLhRb79dGZXH+KE6kB9zcTc5HTMpWrgjsA0
 v2r0S4ZUm4Fd8+f7rjNzWUP4+emarpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733919626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sQD0F71QcruvpNzVJCZfHC8qI8kHuJbwzZ3XWYI5d+Q=;
 b=7DVgBc3OM5F/6O/eJKwv5bvBcFKbd0Y7MzhsbMw0836YleTfB7Df5iMmftd+G1KDNgDd77
 MeJ1nL66eVMIxPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF30313A6F
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 12:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uC9dLoqDWWdNAwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 12:20:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 11 Dec 2024 13:20:26 +0100
MIME-Version: 1.0
Message-Id: <20241211-fix_setsid_tests-v1-3-e103f36c6462@suse.com>
References: <20241211-fix_setsid_tests-v1-0-e103f36c6462@suse.com>
In-Reply-To: <20241211-fix_setsid_tests-v1-0-e103f36c6462@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733919626; l=3445;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=nDIsbzah5lslsc18r6hrN18KbzYZvOBz14ZDMhoeFEQ=;
 b=Tiv/NPy51HphCi8ttmpu1HKcMGISsFPN4eWmAI27Pa12jQTKN3Uto5QLgrUAA1aqVSWtJyi4O
 jSLRrRujdIpCRLj8KdYgvQcX5YaiXFu2Dzt6gEsE2NPQdf1UKifWHH2
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 03/10] Add ptem02 test
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

Verify that it's possible to open a pseudo-terminal via /dev/ptmx,
obtain a slave device and set/get window size.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/pty                     |  1 +
 testcases/kernel/pty/.gitignore |  1 +
 testcases/kernel/pty/ptem02.c   | 78 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/runtest/pty b/runtest/pty
index df2074153c2ac01038a0ef0ce5ad8938960ae53d..3ce7160e2776e58973def5893fc269ed035376c0 100644
--- a/runtest/pty
+++ b/runtest/pty
@@ -7,5 +7,6 @@ pty05 pty05
 pty06 pty06
 pty07 pty07
 ptem01 ptem01
+ptem02 ptem02
 hangup01 hangup01
 
diff --git a/testcases/kernel/pty/.gitignore b/testcases/kernel/pty/.gitignore
index acca3db9a1786f243b31f1fc4a8833d6ed8751a6..e638413a127fad65ed2f58c24dc1ae718219e518 100644
--- a/testcases/kernel/pty/.gitignore
+++ b/testcases/kernel/pty/.gitignore
@@ -1,5 +1,6 @@
 /hangup01
 /ptem01
+/ptem02
 /pty01
 /pty02
 /pty03
diff --git a/testcases/kernel/pty/ptem02.c b/testcases/kernel/pty/ptem02.c
new file mode 100644
index 0000000000000000000000000000000000000000..78ed40d2ca9cb4d1d9a1f3879f1fdcf9198ee493
--- /dev/null
+++ b/testcases/kernel/pty/ptem02.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines  Corp., 2002
+ * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that it's possible to open a pseudo-terminal via /dev/ptmx, obtain a
+ * slave device and set/get window size.
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+
+#define MASTERCLONE "/dev/ptmx"
+
+static void run(void)
+{
+	int masterfd, slavefd;
+	char *slavename;
+	struct winsize wsz;
+	struct winsize wsz1 = { 24, 80, 5, 10 };
+	struct winsize wsz2 = { 60, 100, 11, 777 };
+
+	masterfd = SAFE_OPEN(MASTERCLONE, O_RDWR);
+
+	slavename = ptsname(masterfd);
+	if (slavename == NULL)
+		tst_res(TFAIL, "Can't get slave device location");
+	else
+		tst_res(TPASS, "pts device location is %s", slavename);
+
+	TST_EXP_PASS(grantpt(masterfd));
+	TST_EXP_PASS(unlockpt(masterfd));
+
+	slavefd = SAFE_OPEN(slavename, O_RDWR);
+
+	TST_EXP_POSITIVE(ioctl(masterfd, TIOCSWINSZ, &wsz1));
+	TST_EXP_POSITIVE(ioctl(slavefd, TIOCGWINSZ, &wsz));
+
+	TST_EXP_EQ_LI(wsz.ws_row, wsz1.ws_row);
+	TST_EXP_EQ_LI(wsz.ws_col, wsz1.ws_col);
+	TST_EXP_EQ_LI(wsz.ws_xpixel, wsz1.ws_xpixel);
+	TST_EXP_EQ_LI(wsz.ws_ypixel, wsz1.ws_ypixel);
+
+	TST_EXP_POSITIVE(ioctl(masterfd, TIOCGWINSZ, &wsz));
+
+	TST_EXP_EQ_LI(wsz.ws_row, wsz1.ws_row);
+	TST_EXP_EQ_LI(wsz.ws_col, wsz1.ws_col);
+	TST_EXP_EQ_LI(wsz.ws_xpixel, wsz1.ws_xpixel);
+	TST_EXP_EQ_LI(wsz.ws_ypixel, wsz1.ws_ypixel);
+
+	TST_EXP_POSITIVE(ioctl(slavefd, TIOCSWINSZ, &wsz2));
+	TST_EXP_POSITIVE(ioctl(slavefd, TIOCGWINSZ, &wsz));
+
+	TST_EXP_EQ_LI(wsz.ws_row, wsz2.ws_row);
+	TST_EXP_EQ_LI(wsz.ws_col, wsz2.ws_col);
+	TST_EXP_EQ_LI(wsz.ws_xpixel, wsz2.ws_xpixel);
+	TST_EXP_EQ_LI(wsz.ws_ypixel, wsz2.ws_ypixel);
+
+	SAFE_CLOSE(slavefd);
+	SAFE_CLOSE(masterfd);
+}
+
+static void setup(void)
+{
+	if (access(MASTERCLONE, F_OK))
+		tst_brk(TBROK, "%s device doesn't exist", MASTERCLONE);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
