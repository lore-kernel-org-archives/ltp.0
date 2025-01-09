Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3AAE77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 14:13:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A3CA3C2619
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 15:13:01 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C530E3C25BA
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 15:11:19 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3ACA21BD758F
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 15:11:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2739D1F452
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736431878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlEv6w8A7eSAvMVQB1iEHaAP1MrSfpvxkoNeb247EAU=;
 b=rPHWBvyBirFA7mVO71afYbtaI0/1YK89+ppEQJd8BJLyumBm+Q3Fk0Q/pGWS/h5MrPfwbH
 OuFGQ9cXGKmxjZo+X/dFOzo9Ia7YN5tI4mCLhT4H67iv1jre0mkzRI9cn5ADRum7mMKQRf
 qwec8r/ScKuPXbcocQv2SS/EWs9Z900=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736431878;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlEv6w8A7eSAvMVQB1iEHaAP1MrSfpvxkoNeb247EAU=;
 b=96uN0Xq0UQbOFbolx0zqIEeutO+QG2HP/KeL3qRjKoN6dK2XpeZw4WdxF2urJH8IDqqxdh
 ov3RqWKmYYsNNYAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736431878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlEv6w8A7eSAvMVQB1iEHaAP1MrSfpvxkoNeb247EAU=;
 b=rPHWBvyBirFA7mVO71afYbtaI0/1YK89+ppEQJd8BJLyumBm+Q3Fk0Q/pGWS/h5MrPfwbH
 OuFGQ9cXGKmxjZo+X/dFOzo9Ia7YN5tI4mCLhT4H67iv1jre0mkzRI9cn5ADRum7mMKQRf
 qwec8r/ScKuPXbcocQv2SS/EWs9Z900=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736431878;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlEv6w8A7eSAvMVQB1iEHaAP1MrSfpvxkoNeb247EAU=;
 b=96uN0Xq0UQbOFbolx0zqIEeutO+QG2HP/KeL3qRjKoN6dK2XpeZw4WdxF2urJH8IDqqxdh
 ov3RqWKmYYsNNYAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 091D813A8B
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 14:11:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cF+GOwXZf2eVWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 09 Jan 2025 14:11:17 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 09 Jan 2025 15:11:07 +0100
MIME-Version: 1.0
Message-Id: <20250109-fix_setsid_tests-v3-4-2ce60c904019@suse.com>
References: <20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com>
In-Reply-To: <20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736431876; l=3089;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=2HA7nyt41D5v8m+lFngxg8AamZ8hWHNN2fZDh6Zxuxc=;
 b=4rSGJeevIqdktrLqEdqqlJKWXE/sZokoMy75uu+0046nHm86R8GmGGtKChLpYdLHPvlEZaMxt
 FbDiR9rLKcJDNSZm8VtdJVk48ys00+a9WJ1O/fHgCoetNuS6AJeGf8v
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 suse.com:email, suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 04/12] Add ptem02 test
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
 testcases/kernel/pty/ptem02.c   | 71 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

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
index 0000000000000000000000000000000000000000..0fc69aa1d8d487fba9c6022d77254660b678c6e0
--- /dev/null
+++ b/testcases/kernel/pty/ptem02.c
@@ -0,0 +1,71 @@
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
+#include "common.h"
+
+static int masterfd = -1;
+
+static void run(void)
+{
+	int slavefd;
+	struct winsize wsz;
+	struct winsize wsz1 = { 24, 80, 5, 10 };
+	struct winsize wsz2 = { 60, 100, 11, 777 };
+
+	slavefd = open_slave(masterfd);
+
+	TST_EXP_PASS(ioctl(masterfd, TIOCSWINSZ, &wsz1));
+	TST_EXP_PASS(ioctl(slavefd, TIOCGWINSZ, &wsz));
+
+	TST_EXP_EQ_LI(wsz.ws_row, wsz1.ws_row);
+	TST_EXP_EQ_LI(wsz.ws_col, wsz1.ws_col);
+	TST_EXP_EQ_LI(wsz.ws_xpixel, wsz1.ws_xpixel);
+	TST_EXP_EQ_LI(wsz.ws_ypixel, wsz1.ws_ypixel);
+
+	TST_EXP_PASS(ioctl(masterfd, TIOCGWINSZ, &wsz));
+
+	TST_EXP_EQ_LI(wsz.ws_row, wsz1.ws_row);
+	TST_EXP_EQ_LI(wsz.ws_col, wsz1.ws_col);
+	TST_EXP_EQ_LI(wsz.ws_xpixel, wsz1.ws_xpixel);
+	TST_EXP_EQ_LI(wsz.ws_ypixel, wsz1.ws_ypixel);
+
+	TST_EXP_PASS(ioctl(slavefd, TIOCSWINSZ, &wsz2));
+	TST_EXP_PASS(ioctl(slavefd, TIOCGWINSZ, &wsz));
+
+	TST_EXP_EQ_LI(wsz.ws_row, wsz2.ws_row);
+	TST_EXP_EQ_LI(wsz.ws_col, wsz2.ws_col);
+	TST_EXP_EQ_LI(wsz.ws_xpixel, wsz2.ws_xpixel);
+	TST_EXP_EQ_LI(wsz.ws_ypixel, wsz2.ws_ypixel);
+
+	SAFE_CLOSE(slavefd);
+}
+
+static void setup(void)
+{
+	masterfd = open_master();
+}
+
+static void cleanup(void)
+{
+	if (masterfd != -1)
+		SAFE_CLOSE(masterfd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
