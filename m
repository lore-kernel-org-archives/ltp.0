Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CA3E77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 14:12:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE7BB3C25E9
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 15:12:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B58CA3C2598
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 15:11:19 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 169EB61E265
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 15:11:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B4CD32111F
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736431878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8KI/vKgfjjcCsPCWXINf+nwhxBNMpaLLIpU0kScISA=;
 b=r9vOR2FZmcEP5sCzjiu+9tFUayTYnrt30QSSMUMabnDauC3trQ21Nak1JQWizzNkfStMAi
 rerr7ylCH0MCR6q8+cjkV2X3dXkrwNmIy0v8Xg9KuHEQ7n+jbfOIg7dnriiSLeBvFiZbq9
 j0TYATBto5ex+5ViAOVm4WxeZqSFY/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736431878;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8KI/vKgfjjcCsPCWXINf+nwhxBNMpaLLIpU0kScISA=;
 b=piTA/Oz0/WPV3qs2wIJf6ZaoFWcTysV9qY6GOQCuRz4WbfqU1OKRmdFknOrEKlp8Qrf6jH
 MklJLxQKykjpogCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736431878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8KI/vKgfjjcCsPCWXINf+nwhxBNMpaLLIpU0kScISA=;
 b=r9vOR2FZmcEP5sCzjiu+9tFUayTYnrt30QSSMUMabnDauC3trQ21Nak1JQWizzNkfStMAi
 rerr7ylCH0MCR6q8+cjkV2X3dXkrwNmIy0v8Xg9KuHEQ7n+jbfOIg7dnriiSLeBvFiZbq9
 j0TYATBto5ex+5ViAOVm4WxeZqSFY/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736431878;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8KI/vKgfjjcCsPCWXINf+nwhxBNMpaLLIpU0kScISA=;
 b=piTA/Oz0/WPV3qs2wIJf6ZaoFWcTysV9qY6GOQCuRz4WbfqU1OKRmdFknOrEKlp8Qrf6jH
 MklJLxQKykjpogCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9ECEF13876
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 14:11:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6CICJQbZf2eVWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 09 Jan 2025 14:11:18 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 09 Jan 2025 15:11:10 +0100
MIME-Version: 1.0
Message-Id: <20250109-fix_setsid_tests-v3-7-2ce60c904019@suse.com>
References: <20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com>
In-Reply-To: <20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736431876; l=2503;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=IXhOX8oqa0i3aLbJTgdC6/wzIaJUC+g5syhy98iI/V0=;
 b=BxHW3rD+lCG5hbAf/hj8WsRMBJNOft3tiMmDYwE4BTAXa30k5rClMTFJriB3PftdDEIbxm5MC
 TTUD+anBM5FCmePoDXgAeiSoYRI0wggK2tMJcTCWQRVcgNaI9YPhmGx
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:email, suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 07/12] Add ptem05 test
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

Verify that it's possible to open a pseudo-terminal via /dev/ptmx, to
obtain a master + slave pair and to open them multiple times.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/pty                     |  1 +
 testcases/kernel/pty/.gitignore |  1 +
 testcases/kernel/pty/ptem05.c   | 55 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/runtest/pty b/runtest/pty
index 63d927eca07aa3dbd312d5c5cc6b6681dbf3627d..deb04c3f5725647a32f457eaed638eb7071ab4db 100644
--- a/runtest/pty
+++ b/runtest/pty
@@ -10,5 +10,6 @@ ptem01 ptem01
 ptem02 ptem02
 ptem03 ptem03
 ptem04 ptem04
+ptem05 ptem05
 hangup01 hangup01
 
diff --git a/testcases/kernel/pty/.gitignore b/testcases/kernel/pty/.gitignore
index c9bb33664f9de55038f4638406841f403f1a86c4..ef5751907cad087f5e33132b52a374b52ee7905a 100644
--- a/testcases/kernel/pty/.gitignore
+++ b/testcases/kernel/pty/.gitignore
@@ -3,6 +3,7 @@
 /ptem02
 /ptem03
 /ptem04
+/ptem05
 /pty01
 /pty02
 /pty03
diff --git a/testcases/kernel/pty/ptem05.c b/testcases/kernel/pty/ptem05.c
new file mode 100644
index 0000000000000000000000000000000000000000..9357c469ca8c35117a50e60b19bfbf830b1345cf
--- /dev/null
+++ b/testcases/kernel/pty/ptem05.c
@@ -0,0 +1,55 @@
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
+ * a master + slave pair and to open them multiple times.
+ */
+
+#define _GNU_SOURCE
+
+#include "common.h"
+
+#define NUM_OPENS 10
+
+static int masterfd[NUM_OPENS];
+
+static void run(void)
+{
+	int slavefd[NUM_OPENS];
+
+	for (int i = 0; i < NUM_OPENS; i++)
+		slavefd[i] = TST_EXP_FD(open_slave(masterfd[i]));
+
+	for (int i = 0; i < NUM_OPENS; i++)
+		SAFE_CLOSE(slavefd[i]);
+}
+
+static void setup(void)
+{
+	for (int i = 0; i < NUM_OPENS; i++)
+		masterfd[i] = -1;
+
+	for (int i = 0; i < NUM_OPENS; i++)
+		masterfd[i] = open_master();
+}
+
+static void cleanup(void)
+{
+	for (int i = 0; i < NUM_OPENS; i++) {
+		if (masterfd[i] != -1)
+			SAFE_CLOSE(masterfd[i]);
+	}
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
