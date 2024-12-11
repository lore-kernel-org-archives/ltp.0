Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E881E7717D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 12:20:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C728C3E88FC
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 13:20:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6AD8D3E7D06
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 13:20:28 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EBDB01BCC62A
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 13:20:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D4C0A1F6E6
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733919626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l8tPganWo9JIps/RyvipT0fZuBhvu32c99HoNwqO8mo=;
 b=NnqBXoWlPMPfBrSRpvru7Jup7KLfOPOSzFj1W51GsgvCuf83A+wkfOFTEZMEMEUd+/RGaQ
 sRr5FZxKITmE6NrgjLNIuOM4ulTxfBw/cKnYaqHVZ/dhX5BozQEC1FdvusCSlfP6rFoI4u
 V6oYK3r1pdXy4ZRiqphwBC5Q/XesMPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733919626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l8tPganWo9JIps/RyvipT0fZuBhvu32c99HoNwqO8mo=;
 b=0EuLdidhGcBbleg1wdDGgeX6dJIteayIst2Ip8ekrZ5NJLtYMOf4ZHFeCQZtBxjht5kikM
 ygrbXRYV9VTDtdCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733919626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l8tPganWo9JIps/RyvipT0fZuBhvu32c99HoNwqO8mo=;
 b=NnqBXoWlPMPfBrSRpvru7Jup7KLfOPOSzFj1W51GsgvCuf83A+wkfOFTEZMEMEUd+/RGaQ
 sRr5FZxKITmE6NrgjLNIuOM4ulTxfBw/cKnYaqHVZ/dhX5BozQEC1FdvusCSlfP6rFoI4u
 V6oYK3r1pdXy4ZRiqphwBC5Q/XesMPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733919626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l8tPganWo9JIps/RyvipT0fZuBhvu32c99HoNwqO8mo=;
 b=0EuLdidhGcBbleg1wdDGgeX6dJIteayIst2Ip8ekrZ5NJLtYMOf4ZHFeCQZtBxjht5kikM
 ygrbXRYV9VTDtdCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C67F713AD3
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 12:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +B3xL4qDWWdNAwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 12:20:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 11 Dec 2024 13:20:27 +0100
MIME-Version: 1.0
Message-Id: <20241211-fix_setsid_tests-v1-4-e103f36c6462@suse.com>
References: <20241211-fix_setsid_tests-v1-0-e103f36c6462@suse.com>
In-Reply-To: <20241211-fix_setsid_tests-v1-0-e103f36c6462@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733919626; l=2649;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=4jqt6mVmZh6o5Evr0obzjvwrsiuBLgKIr4j+QTDtT54=;
 b=ITwyppsVWvFlIbK1KTAcw6BgL2QeipqIgG91fmbA3OGeeQ3z0xTe7uw/rTYF1O4FHucVTpli+
 cmJlW103ZriByn/YyvxABoiUChcKOx5cBt4C0M9oefIzz3k8tvCnSX4
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 04/10] Add ptem03 test
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
obtain a slave device and to send a break to both master and slave.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/pty                     |  1 +
 testcases/kernel/pty/.gitignore |  1 +
 testcases/kernel/pty/ptem03.c   | 56 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/runtest/pty b/runtest/pty
index 3ce7160e2776e58973def5893fc269ed035376c0..329cc84cdc107ab8e814fea72a8088ea62d5ad25 100644
--- a/runtest/pty
+++ b/runtest/pty
@@ -8,5 +8,6 @@ pty06 pty06
 pty07 pty07
 ptem01 ptem01
 ptem02 ptem02
+ptem03 ptem03
 hangup01 hangup01
 
diff --git a/testcases/kernel/pty/.gitignore b/testcases/kernel/pty/.gitignore
index e638413a127fad65ed2f58c24dc1ae718219e518..61fec1ddae3ea39d20e97123e34888708050c25c 100644
--- a/testcases/kernel/pty/.gitignore
+++ b/testcases/kernel/pty/.gitignore
@@ -1,6 +1,7 @@
 /hangup01
 /ptem01
 /ptem02
+/ptem03
 /pty01
 /pty02
 /pty03
diff --git a/testcases/kernel/pty/ptem03.c b/testcases/kernel/pty/ptem03.c
new file mode 100644
index 0000000000000000000000000000000000000000..e12ebe27dfe952a2d085205bff1b25ea3709fbba
--- /dev/null
+++ b/testcases/kernel/pty/ptem03.c
@@ -0,0 +1,56 @@
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
+ * slave device and to send a break to both master and slave.
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
+	TST_EXP_PASS(tcsendbreak(masterfd, 10));
+	TST_EXP_PASS(tcsendbreak(slavefd, 10));
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
