Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED256C02183
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 11:37:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 550C13C7C23
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 12:37:49 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CC493C7BD2
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 12:36:06 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BB0431BC18C5
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 12:36:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BFF9C1F79D
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 11:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737027364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8KI/vKgfjjcCsPCWXINf+nwhxBNMpaLLIpU0kScISA=;
 b=QzuuqLLgYB5f275IcgkQ8ShKXuWask9R4akPhUkbMBW97sReSaiwY4MphbEpTBuS7Vlkzd
 nL83h0uUmkq/umT759p61LSELKaaN0Kuwk8nLJYMSCcvyrEi70lxf37zgooEncmWTG4zf8
 gE6n+83966jad85A8mah1EPn6aFTEQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737027364;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8KI/vKgfjjcCsPCWXINf+nwhxBNMpaLLIpU0kScISA=;
 b=KA2hOwNTtMJjVWD8FGHUW369BexQqbbQpeQfDQGZ4atmORerVGmGDw3jLKFXbCemtuvvwy
 3UTBIF4fSEcKAtDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QzuuqLLg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KA2hOwNT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737027364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8KI/vKgfjjcCsPCWXINf+nwhxBNMpaLLIpU0kScISA=;
 b=QzuuqLLgYB5f275IcgkQ8ShKXuWask9R4akPhUkbMBW97sReSaiwY4MphbEpTBuS7Vlkzd
 nL83h0uUmkq/umT759p61LSELKaaN0Kuwk8nLJYMSCcvyrEi70lxf37zgooEncmWTG4zf8
 gE6n+83966jad85A8mah1EPn6aFTEQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737027364;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8KI/vKgfjjcCsPCWXINf+nwhxBNMpaLLIpU0kScISA=;
 b=KA2hOwNTtMJjVWD8FGHUW369BexQqbbQpeQfDQGZ4atmORerVGmGDw3jLKFXbCemtuvvwy
 3UTBIF4fSEcKAtDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A986613AEB
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 11:36:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oCrHJyTviGdrOgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 11:36:04 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 Jan 2025 12:36:06 +0100
MIME-Version: 1.0
Message-Id: <20250116-fix_setsid_tests-v4-7-910f062a7235@suse.com>
References: <20250116-fix_setsid_tests-v4-0-910f062a7235@suse.com>
In-Reply-To: <20250116-fix_setsid_tests-v4-0-910f062a7235@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737027362; l=2503;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=IXhOX8oqa0i3aLbJTgdC6/wzIaJUC+g5syhy98iI/V0=;
 b=MzfN+RUIJ0p2xxCspQqK/AY9z9C7p+3yyZlYRt+cgjaxVoYjQJXwTHs6q0uFA5SjTphPscxdp
 FPB7bG+JTHqD5NZW4ON+CodNZjFKwZtfEHG18FqpzEThy9jaWjD8s4R
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: BFF9C1F79D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.de:dkim];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 07/12] Add ptem05 test
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
