Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BACEC624D3
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:12:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11B3F3E0E5B
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:12:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B1B53E975D
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 97BAF1A011D3
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 554CE1FEDF;
 Fri,  4 Sep 2026 12:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n263ojVll9TfTWZ1BC1allEu8W3vtCyWo7SHBFp225M=;
 b=X2+WeOp8EZGujNo4YILvbjekWtsayy66QhmjuS+zTJvpjqqVmufQY/A5JcqRoYscObvmgC
 7fixfAQCJGhmRdy6yWlxdgaFNnfAmZaLCWF2FQwDOEKePwVTEHSZIgWCRzmXi0Ny4uM7+1
 OY4k6TgeAS7G1/henZFTRi3a7777AZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n263ojVll9TfTWZ1BC1allEu8W3vtCyWo7SHBFp225M=;
 b=BWHUDx4U9vs80cAAR+S8Sj0gk3NNqMK1uZGs0yzyTx76eAzWz9Gb6bj/tVaZFZYr+mob3X
 smiHURse0FTRvcBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n263ojVll9TfTWZ1BC1allEu8W3vtCyWo7SHBFp225M=;
 b=JK11zfkAfxpuTokwHdEFk0XdaXAOiu1fUZ8iFQMXKnp6DNMwqMceGrhumK7kHUn44jMJug
 oag0B0Oo/G5Nc2KI0IUgbPXyTIKqlpZ1Y6WX4CzOW1IbUe2nOHxVhc4xXAfuhhTP0HvLX7
 1b3PgejFG1/TZ94kHejnZUFsPMY2haE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n263ojVll9TfTWZ1BC1allEu8W3vtCyWo7SHBFp225M=;
 b=FD9FED9H6BO9gKzSPyq8LSw9XvXsnqQq4uwZaLimm+YcuEilCK6eE4sjm1ckvRxBTeVVNC
 rZ8Is9Wr8lYhIzBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89AEC1399C;
 Fri,  4 Sep 2026 12:08:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AFjeHta0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:09:01 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-12-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=2997;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=+G5DJhUbYX+ZZat+e4b63OcKKJMem/rds9knmtoopWQ=;
 b=oTzPdWB0taf6JP0n2HQo06WkKIqTxhFHPh66s8+O8TUbNQ4+kOKqCLXxQTOqyx1PV4c8A7XDB
 yH7XlG7bFByBqsPSEckJ7hUiuyUa2YUOjrB6dJMQ3KVpPSbsO5ElyMq
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo]; 
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 12/33] keyctl20: Test KEYCTL_MOVE displacement
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

Test KEYCTL_MOVE displacement behavior: verify moving a key without
KEYCTL_MOVE_EXCL into a destination holding a matching key displaces
the existing key.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl20.c | 62 +++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 1935bee31..bfe4090a0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -737,6 +737,7 @@ keyctl16 keyctl16
 keyctl17 keyctl17
 keyctl18 keyctl18
 keyctl19 keyctl19
+keyctl20 keyctl20
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index f32107923..acddfa79e 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -17,3 +17,4 @@
 /keyctl17
 /keyctl18
 /keyctl19
+/keyctl20
diff --git a/testcases/kernel/syscalls/keyctl/keyctl20.c b/testcases/kernel/syscalls/keyctl/keyctl20.c
new file mode 100644
index 000000000..6da36fe32
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl20.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_MOVE`` displacement of :manpage:`keyctl(2)`.
+ *
+ * [Algorithm]
+ *
+ * - move a key without ``KEYCTL_MOVE_EXCL`` into a destination keyring that
+ *   already contains a matching key, verify it displaces the existing key
+ */
+
+#include "keyctl_common.h"
+
+#define RING_A_DESC	"ltpkeyctl20_a"
+#define RING_B_DESC	"ltpkeyctl20_b"
+#define KEY_DESC	"k"
+#define PAYLOAD		"payload"
+
+static key_serial_t ring_a, ring_b;
+static key_serial_t key_a, key_excl;
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	ring_a = new_ring(RING_A_DESC);
+	ring_b = new_ring(RING_B_DESC);
+
+	key_a = new_user_key(KEY_DESC, PAYLOAD, sizeof(PAYLOAD), ring_a);
+	key_excl = new_user_key(KEY_DESC, PAYLOAD, sizeof(PAYLOAD), ring_b);
+
+	/* Keep key_excl in session keyring so displacement does not destroy it */
+	SAFE_KEYCTL(KEYCTL_LINK, key_excl, KEY_SPEC_SESSION_KEYRING, 0, 0);
+}
+
+static void reset_state(void)
+{
+	SAFE_KEYCTL(KEYCTL_LINK, key_a, ring_a, 0, 0);
+	TEST(keyctl(KEYCTL_UNLINK, key_a, ring_b, 0, 0));
+	if (TST_RET == -1 && TST_ERR != ENOENT)
+		tst_brk(TBROK | TTERRNO, "failed to unlink key_a from ring_b");
+
+	SAFE_KEYCTL(KEYCTL_LINK, key_excl, ring_b, 0, 0);
+}
+
+static void run(void)
+{
+	reset_state();
+
+	TST_EXP_PASS(keyctl(KEYCTL_MOVE, key_a, ring_a, ring_b, 0));
+
+	TST_EXP_EQ_LI(search_ring(ring_b, "user", KEY_DESC), key_a);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.min_kver = "5.3",
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
