Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA8BE77199
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 14:14:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FAE23C262C
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 15:14:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67F243C2573
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 15:11:20 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 820BD140AF9C
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 15:11:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6EA9F21170
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736431878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GtulQDJMJQa2TDT3IKOxJN+BAOHESsvWjigq3C69sY8=;
 b=tsJHOuI0+Ng3dpAHpn/SIWO0se3607S0FqSuHg7B0b24wHjOgE2pHvcE4paoGlbOxGlEjb
 VGYwBh1M52TXAKqRUNz42RL3cAirFbh1F0lHWXeqBEVJlcw9q6PfUGWxObz5YFKbxdlQhH
 /hFd19DuBZyzrQ0XBH2D9bjUAgS2eiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736431878;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GtulQDJMJQa2TDT3IKOxJN+BAOHESsvWjigq3C69sY8=;
 b=Y7fvZEFVTH1Bx5iJ+mMAETABT2Dkqsv1xIJsD74QZ7mz9Pz4ljwqMreaL5Vp8NiPO6yX6A
 YP0yzvg/4JC+HdCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736431878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GtulQDJMJQa2TDT3IKOxJN+BAOHESsvWjigq3C69sY8=;
 b=tsJHOuI0+Ng3dpAHpn/SIWO0se3607S0FqSuHg7B0b24wHjOgE2pHvcE4paoGlbOxGlEjb
 VGYwBh1M52TXAKqRUNz42RL3cAirFbh1F0lHWXeqBEVJlcw9q6PfUGWxObz5YFKbxdlQhH
 /hFd19DuBZyzrQ0XBH2D9bjUAgS2eiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736431878;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GtulQDJMJQa2TDT3IKOxJN+BAOHESsvWjigq3C69sY8=;
 b=Y7fvZEFVTH1Bx5iJ+mMAETABT2Dkqsv1xIJsD74QZ7mz9Pz4ljwqMreaL5Vp8NiPO6yX6A
 YP0yzvg/4JC+HdCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CF3513876
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 14:11:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WF+DCwbZf2eVWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 09 Jan 2025 14:11:18 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 09 Jan 2025 15:11:08 +0100
MIME-Version: 1.0
Message-Id: <20250109-fix_setsid_tests-v3-5-2ce60c904019@suse.com>
References: <20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com>
In-Reply-To: <20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736431876; l=2313;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=d7gD1tistQXVOsqQWXXk7DwIt3wNy1R53qL2AEVF9uU=;
 b=VryBl/pVs6xkqnAtS+HecNkrBETAuubuWsXNjSrOqgqm9FAEJKgaeesWxl9noF+XOoy+df9yK
 d2kvbFkiq5eBUJZgEigmSrWVfClHyqvehbAMmqsb6/j31JcmN37xa7v
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 05/12] Add ptem03 test
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
 testcases/kernel/pty/ptem03.c   | 49 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

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
index 0000000000000000000000000000000000000000..fb0fdf6612d94a35728bed773fd7dd363922f454
--- /dev/null
+++ b/testcases/kernel/pty/ptem03.c
@@ -0,0 +1,49 @@
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
+#include "common.h"
+
+static int masterfd = -1;
+
+static void run(void)
+{
+	int slavefd;
+
+	slavefd = open_slave(masterfd);
+
+	TST_EXP_PASS(tcsendbreak(masterfd, 10));
+	TST_EXP_PASS(tcsendbreak(slavefd, 10));
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
