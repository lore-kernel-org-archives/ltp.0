Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C39C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:10:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74E363E4B98
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:10:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5D133E9791
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4FF18201119
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 96BCF1FDD4;
 Fri,  4 Sep 2026 12:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ej8XBX4kVST2p/BM1NaDBjCZBuYDIWiJ7hur/dC2nWc=;
 b=1wgvDsR/98KkhzL2ttTH8fczQY1i8aEUI3RHLV5ht+4Dc8dFQGJbr7i3C1lK6/uilQdN0g
 Zvu+Jbf5gWO+BXDLIWWR2OM4Fc7HjejGMee+HV5ltjlRAImG9/UiaiKrY9nSpi7qoKNagw
 R2soIneqdSyafTI7/leilV55vG/vxfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ej8XBX4kVST2p/BM1NaDBjCZBuYDIWiJ7hur/dC2nWc=;
 b=LFRZW9VEcsASXr4+L/s0X/o/83hzPUnzxBB1xtbhbWwEW96WS4bhwqMYT2c0auzjwFNzIZ
 2FBX6BEEs7OeyOCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ej8XBX4kVST2p/BM1NaDBjCZBuYDIWiJ7hur/dC2nWc=;
 b=RXsJGZyo5mLWiD9UAWxLK37oKJuauCymv2yCkRzykJ0GeiBkpf0AN9PfhqdEy5vcTc4IKK
 jBZ06HuNTq9knvbFgoli49uNYsnnREPr/7+rPH0kuUMcHLxAFN/Z6xSu7uSW0nT8w/T0ul
 Ma0KHUMOOyksPNiGKhAjgKvyYpwer9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ej8XBX4kVST2p/BM1NaDBjCZBuYDIWiJ7hur/dC2nWc=;
 b=fFXXSxTi+C8gEdguA++bY/cAH1FmUL6wrmPi7PaTA+8ZqH1u/4kXgrPefIc9U9zKgazJf2
 CthG8euNNCL6bJCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5D061397A;
 Fri,  4 Sep 2026 12:08:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4CV5NdS0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:08:54 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-5-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=2401;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=kyq2j/U17pzSP+hfoaDCe3Y8St1sDF8BQPDKgMDVMOA=;
 b=tpFgYsCwZyJFOD5AwNJbObcK3txQOASI+qoQK+mmKMJSgKbiwKikAvBevY6WfI8CGIy+VK0Bp
 xd5DZlSAUFSBDXJ657Z3khPENyeHWNIQDwbf9StDZ28li6O0bNKaneq
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 05/33] keyctl13: Test KEYCTL_DESCRIBE size query
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

Test KEYCTL_DESCRIBE when called with a NULL buffer and buflen 0:
verify the call succeeds and returns the full description length
without writing to userspace memory.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl13.c | 46 +++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index d8e846e65..25367084d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -730,6 +730,7 @@ keyctl09 keyctl09
 keyctl10 keyctl10
 keyctl11 keyctl11
 keyctl12 keyctl12
+keyctl13 keyctl13
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 9ce6e2250..d4ce61a6e 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -10,3 +10,4 @@
 /keyctl10
 /keyctl11
 /keyctl12
+/keyctl13
diff --git a/testcases/kernel/syscalls/keyctl/keyctl13.c b/testcases/kernel/syscalls/keyctl/keyctl13.c
new file mode 100644
index 000000000..ebdb3cf32
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl13.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_DESCRIBE`` of :manpage:`keyctl(2)` with NULL buffer and buflen 0.
+ *
+ * [Algorithm]
+ *
+ * - describe a key with NULL buffer and ``buflen = 0``, verify the full length
+ *   is returned without writing
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+
+#include "keyctl_common.h"
+
+static key_serial_t key;
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	key = new_user_key("k", "payload", 7, KEY_SPEC_PROCESS_KEYRING);
+	SAFE_KEYCTL(KEYCTL_SETPERM, key, KEY_PERM_SET, 0, 0);
+}
+
+static void run(void)
+{
+	char expected[64];
+	long expected_len;
+
+	expected_len = snprintf(expected, sizeof(expected),
+				"user;%u;%u;%08x;k",
+				getuid(), getgid(), KEY_PERM_SET) + 1;
+
+	TST_EXP_VAL(keyctl(KEYCTL_DESCRIBE, key, (unsigned long)NULL, 0, 0),
+		    expected_len);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
