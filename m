Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92851E7717D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 12:23:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 836343E8917
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 13:23:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE2B83E88FC
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 13:20:29 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2B1FD638603
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 13:20:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E9D6121168
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733919627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ymu/N4W1+bVQXsZPxCgqD9AMtak69iDlryQdVxfUunM=;
 b=BtX8kF41f4P1DKPLWzZfoM9F7jnB9mbOpfQNCMx7l1sm07kWrjAbP3v4rZBCs6NWXtdtPt
 +hHVxzwbHL3At7xVM3kLNyZsrke5Kwp7H6nNJYQhw4TwdMfxrZczX+KoeSu4AGt5TBibn0
 3pn5xXVM6fnh/xZ/B1ypG7S9yPM5JZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733919627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ymu/N4W1+bVQXsZPxCgqD9AMtak69iDlryQdVxfUunM=;
 b=o6PEdu2ssLugA4aj5IYdan4R6vLwIOvBXeQOuO1xP69Ydo5pNdC/36DWPslrDi+aw3i2iu
 2FyHRgnq7y9x1lAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0OkVkNk8;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CsPwgB2G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733919626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ymu/N4W1+bVQXsZPxCgqD9AMtak69iDlryQdVxfUunM=;
 b=0OkVkNk8oNbrrngrGqQuSjJI58nkum2FVel1RN+2bxxbAAoBcnEBVCCZz/V/02Qjqwe7F3
 bZIT4VqOCnnlFloqRU6NXOOBlNCBE5Qr7l/FMBJRBT5hisDlQ6apg0uQgyaY/ZVuLwR0DI
 weUEP3WUqn7/FWW9ntNZWSdZ2xNI5U0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733919626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ymu/N4W1+bVQXsZPxCgqD9AMtak69iDlryQdVxfUunM=;
 b=CsPwgB2GvzL/MZYhpXB7szjiydC1pHFAdJ9lXmGQWcv97iEKBk3NrMmIa1RzNydIHiqNo1
 KDycax8RLYycinAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC5701344A
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 12:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ANl9NYqDWWdNAwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 12:20:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 11 Dec 2024 13:20:30 +0100
MIME-Version: 1.0
Message-Id: <20241211-fix_setsid_tests-v1-7-e103f36c6462@suse.com>
References: <20241211-fix_setsid_tests-v1-0-e103f36c6462@suse.com>
In-Reply-To: <20241211-fix_setsid_tests-v1-0-e103f36c6462@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733919626; l=2772;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=rOesXg7SZTJ/Kb0wF3PAMZolAZ6Tb3xY34xuyGcll64=;
 b=ZFrOg0oJLxlPEtM5DoON06+44amLt5VW7RIGO2gktF2+c326Pp1NAMwOmWD7GILjd3+E9Vywb
 abCTp/eX2+8C8H0MMbIrc5VotOZN0+96nmk+HrXtIcK+JI9Te4TY+aJ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: E9D6121168
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
 RCPT_COUNT_ONE(0.00)[1]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 07/10] Add ptem06 test
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
to obtain a slave device and to set baudrate to B0 (which means hang
up).

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/pty                     |  1 +
 testcases/kernel/pty/.gitignore |  1 +
 testcases/kernel/pty/ptem06.c   | 59 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/runtest/pty b/runtest/pty
index deb04c3f5725647a32f457eaed638eb7071ab4db..6343da391ba17627abaf09aa5a23509e4f745556 100644
--- a/runtest/pty
+++ b/runtest/pty
@@ -11,5 +11,6 @@ ptem02 ptem02
 ptem03 ptem03
 ptem04 ptem04
 ptem05 ptem05
+ptem06 ptem06
 hangup01 hangup01
 
diff --git a/testcases/kernel/pty/.gitignore b/testcases/kernel/pty/.gitignore
index ef5751907cad087f5e33132b52a374b52ee7905a..630d7fcf7b0e0adfbc21b793fa456d6c5f5e4ad9 100644
--- a/testcases/kernel/pty/.gitignore
+++ b/testcases/kernel/pty/.gitignore
@@ -4,6 +4,7 @@
 /ptem03
 /ptem04
 /ptem05
+/ptem06
 /pty01
 /pty02
 /pty03
diff --git a/testcases/kernel/pty/ptem06.c b/testcases/kernel/pty/ptem06.c
new file mode 100644
index 0000000000000000000000000000000000000000..be34000e63de48560fa7ae03f72c986e26f7851d
--- /dev/null
+++ b/testcases/kernel/pty/ptem06.c
@@ -0,0 +1,59 @@
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
+ * Verify that it's possible to open a pseudo-terminal via /dev/ptmx, to obtain
+ * a slave device and to set baudrate to B0 (which means hang up).
+ */
+
+#define _GNU_SOURCE
+
+#include <termios.h>
+#include "tst_test.h"
+
+#define MASTERCLONE "/dev/ptmx"
+
+static void run(void)
+{
+	int masterfd, slavefd;
+	struct termios termios;
+	char *slavename;
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
+	TST_EXP_PASS(ioctl(slavefd, TCGETS, &termios));
+	termios.c_cflag &= ~CBAUD;
+	termios.c_cflag |= B0 & CBAUD;
+	TST_EXP_PASS(ioctl(slavefd, TCSETS, &termios));
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
