Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5E4C54F30
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 10:56:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 842DF3C5805
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 12:56:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0321F3C6520
 for <ltp@lists.linux.it>; Tue, 27 May 2025 12:55:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4540E600136
 for <ltp@lists.linux.it>; Tue, 27 May 2025 12:54:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C1B7E1FB4A;
 Tue, 27 May 2025 10:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748343289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NkLwnFWStH8Fw0RKj4yjekK+Bo5XMYmMI2Iarlbe0JM=;
 b=IT21cXCiOCIGD7R8DTllo8gD7QzZR6o94efxwgpN89JdlB8Q8uYNYdXLleiFEmJW9d2jd8
 zJRaPQV0/CZQnq/7nwO+d0i5GwmzQPfEk+OpI8Kiu0YL3YmGYy19Me1rC5wtlP6tPBvwaQ
 ioz/yiVTpxdtMxfEu04/qy61UnrRaBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748343289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NkLwnFWStH8Fw0RKj4yjekK+Bo5XMYmMI2Iarlbe0JM=;
 b=u9sx5iVom/vuR6MIyO3YGrWcIqNwitVJf5ig7vxyiUMKfjDCLNvzvib2zJygx0VaqfoVra
 YW7LLbaQKJworpBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748343289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NkLwnFWStH8Fw0RKj4yjekK+Bo5XMYmMI2Iarlbe0JM=;
 b=IT21cXCiOCIGD7R8DTllo8gD7QzZR6o94efxwgpN89JdlB8Q8uYNYdXLleiFEmJW9d2jd8
 zJRaPQV0/CZQnq/7nwO+d0i5GwmzQPfEk+OpI8Kiu0YL3YmGYy19Me1rC5wtlP6tPBvwaQ
 ioz/yiVTpxdtMxfEu04/qy61UnrRaBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748343289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NkLwnFWStH8Fw0RKj4yjekK+Bo5XMYmMI2Iarlbe0JM=;
 b=u9sx5iVom/vuR6MIyO3YGrWcIqNwitVJf5ig7vxyiUMKfjDCLNvzvib2zJygx0VaqfoVra
 YW7LLbaQKJworpBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 910261388B;
 Tue, 27 May 2025 10:54:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qK65IfmZNWihdQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 27 May 2025 10:54:49 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 27 May 2025 12:54:40 +0200
MIME-Version: 1.0
Message-Id: <20250527-landlock_unix_socket-v4-4-80d3d579094b@suse.com>
References: <20250527-landlock_unix_socket-v4-0-80d3d579094b@suse.com>
In-Reply-To: <20250527-landlock_unix_socket-v4-0-80d3d579094b@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748343288; l=4142;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=JcorkevfYm6ec1mAWswT3JA9R6wER753ZxJqNy2VVFQ=;
 b=mLAZN/eoNhB/tZ5m139yF5erZKXom3pR6cXO1Q67dhIymoWKANXUaX6VV3iRffATir8WrKZAR
 GGU+4M0wGf4ArLtDqjQncqN8/d9Q8qq2gcE5OuouOuXn+Eyo4KrRH5D
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:email, suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/4] landlock: add landlock10 test
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

Verify that landlock's LANDLOCK_SCOPE_SIGNAL rule rejects any
signal coming from a process on a different domain, but accept
signals from processes in the same domain.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/landlock/.gitignore   |   1 +
 testcases/kernel/syscalls/landlock/landlock10.c | 108 ++++++++++++++++++++++++
 3 files changed, 110 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index d37c43f20bf292b58b10a8531eeaff295f6c1ab1..12e09c2ca328afb0425be13179ee22f6d0d979ce 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -713,6 +713,7 @@ landlock06 landlock06
 landlock07 landlock07
 landlock08 landlock08
 landlock09 landlock09
+landlock10 landlock10
 
 lchown01 lchown01
 lchown01_16 lchown01_16
diff --git a/testcases/kernel/syscalls/landlock/.gitignore b/testcases/kernel/syscalls/landlock/.gitignore
index cda8d871e051ec88abba4634a2bcda4b10470d9f..8c88803df4580605da800c414ada62994b35d268 100644
--- a/testcases/kernel/syscalls/landlock/.gitignore
+++ b/testcases/kernel/syscalls/landlock/.gitignore
@@ -8,3 +8,4 @@ landlock06
 landlock07
 landlock08
 landlock09
+landlock10
diff --git a/testcases/kernel/syscalls/landlock/landlock10.c b/testcases/kernel/syscalls/landlock/landlock10.c
new file mode 100644
index 0000000000000000000000000000000000000000..a29e3bca82fe813e9e2dbec5f1f0f42db9ebf367
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock10.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that landlock's LANDLOCK_SCOPE_SIGNAL rule rejects any signal coming
+ * from a process on a different domain, but accept signals from processes in
+ * the same domain.
+ */
+
+#include "tst_test.h"
+#include "landlock_common.h"
+
+static struct tst_landlock_ruleset_attr_abi6 *ruleset_attr;
+
+enum {
+	DOMAIN_PAUSED = 0,
+	DOMAIN_KILLER,
+	DOMAIN_BOTH,
+};
+
+static void scoped_sandbox(const char *from)
+{
+	tst_res(TINFO, "Enforcing rule LANDLOCK_SCOPE_SIGNAL for %s process", from);
+
+	ruleset_attr->scoped = LANDLOCK_SCOPE_SIGNAL;
+	apply_landlock_scoped_layer(ruleset_attr, sizeof(*ruleset_attr));
+}
+
+static void run(void)
+{
+	/* isolate test inside a process so we won't stack too many
+	 * layers (-E2BIG) when there are multiple test's iterations
+	 */
+	if (SAFE_FORK())
+		return;
+
+	if (tst_variant == DOMAIN_BOTH)
+		scoped_sandbox("paused and killer");
+
+	pid_t paused_pid;
+	pid_t killer_pid;
+
+	paused_pid = SAFE_FORK();
+	if (!paused_pid) {
+		if (tst_variant == DOMAIN_PAUSED)
+			scoped_sandbox("paused");
+
+		TST_CHECKPOINT_WAKE(0);
+		pause();
+		exit(0);
+	}
+
+	TST_CHECKPOINT_WAIT(0);
+	TST_PROCESS_STATE_WAIT(paused_pid, 'S', 10000);
+
+	killer_pid = SAFE_FORK();
+	if (!killer_pid) {
+		if (tst_variant == DOMAIN_KILLER)
+			scoped_sandbox("killer");
+
+		TST_CHECKPOINT_WAKE(0);
+
+		if (tst_variant == DOMAIN_KILLER)
+			TST_EXP_FAIL(kill(paused_pid, SIGKILL), EPERM);
+		else
+			TST_EXP_PASS(kill(paused_pid, SIGKILL));
+
+		exit(0);
+	}
+
+	TST_CHECKPOINT_WAIT(0);
+	SAFE_WAITPID(killer_pid, NULL, 0);
+
+	if (kill(paused_pid, SIGKILL) == -1) {
+		if (errno != ESRCH)
+			tst_brk(TBROK | TERRNO, "kill(%u, SIGKILL) error", paused_pid);
+	}
+
+	SAFE_WAITPID(paused_pid, NULL, 0);
+}
+
+static void setup(void)
+{
+	int abi;
+
+	abi = verify_landlock_is_enabled();
+	if (abi < 6)
+		tst_brk(TCONF, "LANDLOCK_SCOPE_SIGNAL is unsupported on ABI < 6");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.test_variants = 3,
+	.bufs = (struct tst_buffers []) {
+		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr_abi6)},
+		{},
+	},
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_REQ, CAP_SYS_ADMIN),
+		{}
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
