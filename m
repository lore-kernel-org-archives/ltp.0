Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2815FC79F83
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:12:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A45763E30CD
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:12:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CF083E939B
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E5DB11401234
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AEB0E1FCF2;
 Fri,  4 Sep 2026 12:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GRvSBLo722ZOaj3GjU4OIQmt3AEldREeRCQr9wDOKzE=;
 b=0YApljZ4DeKqdy81v01Vq1QEEdyvZpSvskW7bwnO1dyWohHBGfSyAmAlGys9pEWB1zVdlx
 i57gOAn4SUtC5AgHSupPoBNWgzdnaxBudq1Vmkt6Soz9WRVYpLliiELciuDyHIAwH7eXPC
 /zWTT7i/XnXgzAV3Xh7QaOH+8WJVdfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GRvSBLo722ZOaj3GjU4OIQmt3AEldREeRCQr9wDOKzE=;
 b=saS5y6XCHC6nCdAhrnY+s1NGf6XugBD+hO0wkRhEYt6D2rSrtyXHp/Ht21K+ZreCjS4Vv2
 RXMPWtP8nfZBz/BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1dGC6Cvk;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HuuAMOc0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GRvSBLo722ZOaj3GjU4OIQmt3AEldREeRCQr9wDOKzE=;
 b=1dGC6CvkpcJszMa5jscnFhHE/n5DGpuQ+b0hvvg+RnpKdtCOAJtPEufknD8TO51ywYyKB+
 95soFFVOE2rGgM2LjgbVMlUSlWgVX6UbDSz6KiW9GEZMOlYKl6bIprcoUjGd7hyRvaWFLG
 aNP/YsQeaF8qXSkyNCmomuLr5v7ZihI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GRvSBLo722ZOaj3GjU4OIQmt3AEldREeRCQr9wDOKzE=;
 b=HuuAMOc065cEVkb9OtL5HYrT/G+PFKlP0TBV1ZgbW5ff1C36bbZll/t5bgNu2NDLp+hejl
 0KvDanLmdOWtS1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06F0A139A8;
 Fri,  4 Sep 2026 12:08:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +NykOta0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:09:03 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-14-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=2933;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=bHauuKXtfTVOaxRoYFByI7b/1gnMt7XyD+ekFKUwCIs=;
 b=Utc86dQBwvLGOAXic7Ng4EgtHrMLmH1XqxqKqZRlywIb+VbPMN7QzWE9VmYMxfLfMnVfL5KpP
 MVE7YQaFfMJDpvyrngkPE4gifhkD6UON/OCrNW5sOZOcSMLIvSldCpy
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AEB0E1FCF2
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 14/33] keyctl22: Test KEYCTL_RESTRICT_KEYRING
 reject-all
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

Test KEYCTL_RESTRICT_KEYRING reject-all restriction: verify that
restricting a keyring with NULL type and NULL restriction succeeds,
and subsequent link and add_key attempts fail with EPERM.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl22.c | 54 +++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index b95264564..262ef967d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -739,6 +739,7 @@ keyctl18 keyctl18
 keyctl19 keyctl19
 keyctl20 keyctl20
 keyctl21 keyctl21
+keyctl22 keyctl22
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index e8c71e79e..82a74e4a3 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -19,3 +19,4 @@
 /keyctl19
 /keyctl20
 /keyctl21
+/keyctl22
diff --git a/testcases/kernel/syscalls/keyctl/keyctl22.c b/testcases/kernel/syscalls/keyctl/keyctl22.c
new file mode 100644
index 000000000..c4410e3dc
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl22.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_RESTRICT_KEYRING`` reject-all of :manpage:`keyctl(2)`,
+ * added in Linux 4.12.
+ *
+ * [Algorithm]
+ *
+ * - restrict a keyring with ``NULL`` type and ``NULL`` restriction (reject all links),
+ *   verify subsequent links and add_key fail with ``EPERM``
+ */
+
+#include "keyctl_common.h"
+
+#define PAYLOAD		"payload"
+
+static key_serial_t ring_reject;
+static key_serial_t user_key;
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	ring_reject = new_ring("ltpkeyctl22_reject");
+	user_key = new_user_key("k", PAYLOAD, sizeof(PAYLOAD),
+				KEY_SPEC_PROCESS_KEYRING);
+}
+
+static void run(void)
+{
+	TEST(keyctl(KEYCTL_RESTRICT_KEYRING, ring_reject, 0, 0, 0));
+	if (TST_RET == 0)
+		tst_res(TPASS, "KEYCTL_RESTRICT_KEYRING with NULL type and restriction passed");
+	else if (TST_RET == -1 && TST_ERR == EEXIST)
+		tst_res(TPASS, "KEYCTL_RESTRICT_KEYRING reject-all already active");
+	else
+		tst_res(TFAIL | TTERRNO, "KEYCTL_RESTRICT_KEYRING reject-all failed");
+
+	TST_EXP_FAIL(keyctl(KEYCTL_LINK, user_key, ring_reject, 0, 0), EPERM,
+		     "KEYCTL_LINK on reject-all restricted keyring");
+
+	TST_EXP_FAIL2(add_key("user", "k_rej", PAYLOAD, sizeof(PAYLOAD),
+			      ring_reject), EPERM,
+		      "add_key on reject-all restricted keyring");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.min_kver = "4.12",
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
