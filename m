Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EF0E7717D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 12:22:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 440363E7D06
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 13:22:37 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A63EE3E88F4
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 13:20:29 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 33D601BBFB52
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 13:20:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 096521F74C
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 12:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733919627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nyWzl95r8eK8KWtbW2uWhhrkKLW+CVzugpLWWL1OjM=;
 b=lOSEOSPDM6mq7WKtyQHA/wvuW3aLlpN+RePNSZvpEDxW6nJwxBtkE0RlfgGz6I8ht+3nI5
 yaKxshXbQqLhGKeJOfq9bARMV+KXu1VO9UO5ngW06eqChOewnq+P0YOseBWYVtQ5+Js+qY
 5b3LdFeZuCl7BYEM70V+i001YUi0rSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733919627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nyWzl95r8eK8KWtbW2uWhhrkKLW+CVzugpLWWL1OjM=;
 b=fSBgCrf90u7ugyLP6EAwNdZkz2QhaB9g9zkis1ywfHCIDUnRMg4OEKcuShQmjbOuSo4z2J
 iO3fPeW17r9NNMDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733919627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nyWzl95r8eK8KWtbW2uWhhrkKLW+CVzugpLWWL1OjM=;
 b=lOSEOSPDM6mq7WKtyQHA/wvuW3aLlpN+RePNSZvpEDxW6nJwxBtkE0RlfgGz6I8ht+3nI5
 yaKxshXbQqLhGKeJOfq9bARMV+KXu1VO9UO5ngW06eqChOewnq+P0YOseBWYVtQ5+Js+qY
 5b3LdFeZuCl7BYEM70V+i001YUi0rSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733919627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nyWzl95r8eK8KWtbW2uWhhrkKLW+CVzugpLWWL1OjM=;
 b=fSBgCrf90u7ugyLP6EAwNdZkz2QhaB9g9zkis1ywfHCIDUnRMg4OEKcuShQmjbOuSo4z2J
 iO3fPeW17r9NNMDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9D9913A69
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 12:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mFzIOIqDWWdNAwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 12:20:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 11 Dec 2024 13:20:32 +0100
MIME-Version: 1.0
Message-Id: <20241211-fix_setsid_tests-v1-9-e103f36c6462@suse.com>
References: <20241211-fix_setsid_tests-v1-0-e103f36c6462@suse.com>
In-Reply-To: <20241211-fix_setsid_tests-v1-0-e103f36c6462@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733919626; l=2607;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=/0lRl6aQr62MJhGCBCIA48fYEX9Rp2M6Bvi4mduG72k=;
 b=pL9+E8T5/1I/eCNF6dZdfhk+R6MAzIAOvDDVrm7/ZNJLsCadF2SVX4N5Ey8hPmJ1SmPPUhMl6
 nmsOXmZlS4FDdTsX5MVf5Lk4K5MmItDv6o5GIwrTLmTm3lGNfbjAO7S
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 09/10] Add pty08 test
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

Verify that slave pseudo-terminal fails reading/writing if master has
been closed.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/pty                     |  1 +
 testcases/kernel/pty/.gitignore |  1 +
 testcases/kernel/pty/pty08.c    | 60 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/runtest/pty b/runtest/pty
index 6343da391ba17627abaf09aa5a23509e4f745556..365a46ee9730aa36b22dbbdbfba82ac0d491ac94 100644
--- a/runtest/pty
+++ b/runtest/pty
@@ -6,6 +6,7 @@ pty04 pty04
 pty05 pty05
 pty06 pty06
 pty07 pty07
+pty08 pty08
 ptem01 ptem01
 ptem02 ptem02
 ptem03 ptem03
diff --git a/testcases/kernel/pty/.gitignore b/testcases/kernel/pty/.gitignore
index 630d7fcf7b0e0adfbc21b793fa456d6c5f5e4ad9..7d8d4dceda84f2e2695a8bee39abfe894288b8b6 100644
--- a/testcases/kernel/pty/.gitignore
+++ b/testcases/kernel/pty/.gitignore
@@ -12,3 +12,4 @@
 /pty05
 /pty06
 /pty07
+/pty08
diff --git a/testcases/kernel/pty/pty08.c b/testcases/kernel/pty/pty08.c
new file mode 100644
index 0000000000000000000000000000000000000000..1e3eb191b2e2a88258319da90e29ed582cdfa7b7
--- /dev/null
+++ b/testcases/kernel/pty/pty08.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines  Corp., 2002
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that slave pseudo-terminal fails reading/writing if master has been
+ * closed.
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
+	char buf;
+
+	masterfd = SAFE_OPEN(MASTERCLONE, O_RDWR);
+
+	slavename = ptsname(masterfd);
+	if (slavename == NULL)
+		tst_brk(TBROK | TERRNO, "ptsname() error");
+
+	tst_res(TINFO, "pts device location is %s", slavename);
+
+	if (grantpt(masterfd) == -1)
+		tst_brk(TBROK | TERRNO, "grantpt() error");
+
+	if (unlockpt(masterfd) == -1)
+		tst_brk(TBROK | TERRNO, "unlockpt() error");
+
+	slavefd = SAFE_OPEN(slavename, O_RDWR);
+
+	tst_res(TINFO, "Closing master communication");
+	SAFE_CLOSE(masterfd);
+
+	TST_EXP_FAIL(read(slavefd, &buf, 1), EIO);
+	TST_EXP_FAIL(write(slavefd, &buf, 1), EIO);
+
+	SAFE_CLOSE(slavefd);
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
