Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CA0E77198
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 10:32:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 773513C3071
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 11:32:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF1E03C0E08
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 11:31:27 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2EDF9612DAE
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 11:31:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2F41021161
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 10:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736159486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFx3UHqXvxpZ+8i/0/5Kv1kBZYMUQqccrP0oESCOGz0=;
 b=sfh/V4agrapRyNrwyJ4xMPV9gg9LF286Zw/L3iUpKNAxhX5moxPomELi1oq8AFcG+STmW2
 wLWqxEe/f3rvvNHnpIxyFqF5fWzvzt2TiuXzrQP0++t9UFfvg+khZYkS6w7iqb7pI6Lexr
 SUm/r60UI89UjU5yHWiCdk74t+opjc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736159486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFx3UHqXvxpZ+8i/0/5Kv1kBZYMUQqccrP0oESCOGz0=;
 b=H01H/dco8sgwI6/AckUGSus86bWS5sRAxKclRQ388dXZhBGB7lXk9Dt+WszaCTEJhUqDfg
 dchv2NXJxC4MCdAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="sfh/V4ag";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="H01H/dco"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736159486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFx3UHqXvxpZ+8i/0/5Kv1kBZYMUQqccrP0oESCOGz0=;
 b=sfh/V4agrapRyNrwyJ4xMPV9gg9LF286Zw/L3iUpKNAxhX5moxPomELi1oq8AFcG+STmW2
 wLWqxEe/f3rvvNHnpIxyFqF5fWzvzt2TiuXzrQP0++t9UFfvg+khZYkS6w7iqb7pI6Lexr
 SUm/r60UI89UjU5yHWiCdk74t+opjc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736159486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFx3UHqXvxpZ+8i/0/5Kv1kBZYMUQqccrP0oESCOGz0=;
 b=H01H/dco8sgwI6/AckUGSus86bWS5sRAxKclRQ388dXZhBGB7lXk9Dt+WszaCTEJhUqDfg
 dchv2NXJxC4MCdAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10D1D137DA
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 10:31:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wKVlAv6we2fGfwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 06 Jan 2025 10:31:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 06 Jan 2025 11:31:26 +0100
MIME-Version: 1.0
Message-Id: <20250106-fix_setsid_tests-v2-4-c43f57a2bab6@suse.com>
References: <20250106-fix_setsid_tests-v2-0-c43f57a2bab6@suse.com>
In-Reply-To: <20250106-fix_setsid_tests-v2-0-c43f57a2bab6@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736159485; l=3298;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=WmaFDPi7EbvJ/YqvbO6MKRu1LhOJfpCOOhzQPDg7MXs=;
 b=yvdpQn3cS4cm3s+YiLZqNTm3bmrfA2ur/qh26+b3R3/RvpjAgPXCT8TdIKodpkVBpel4dooQe
 2lWYQ2JZcCBAvN2YTKxkFtDegX49ZQH40Y3h6qrweN6UVdgBqN1Dgmq
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 2F41021161
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 04/11] Add ptem02 test
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
 testcases/kernel/pty/ptem02.c   | 73 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

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
index 0000000000000000000000000000000000000000..683595ff10d20893926310b5901a2e98045fb6ce
--- /dev/null
+++ b/testcases/kernel/pty/ptem02.c
@@ -0,0 +1,73 @@
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
+	slavename = SAFE_PTSNAME(masterfd);
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
