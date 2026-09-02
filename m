Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5ADC61DD6
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:08:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 002BD3E6162
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:08:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFCC23E93AE
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2CEDE1000A56
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CBEA21F8C4;
 Wed,  2 Sep 2026 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GRvSBLo722ZOaj3GjU4OIQmt3AEldREeRCQr9wDOKzE=;
 b=BMEvTTqhLgiS90dQpqi+re+3u6Ae5Rf4N3untmjFX0FgqYQivQ+ClInXLtXrImQOtfLh+L
 DyJeCyeGg3C9xOSvPmg8M6r1QN+98Oxk/o57/8qK0zgVSzTEUiNUv/Aq64R4aLJ7Sd6WEX
 OJcx+gH9M5/W2jIDhh9NPpnZSEXMJTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GRvSBLo722ZOaj3GjU4OIQmt3AEldREeRCQr9wDOKzE=;
 b=2+lwd+yYr0yxbzpNTdwT0RjctjKw9np4ANvLz+xAH8J7vmrv0vmOMpxh9myP79Dj4QBRuc
 2CWhSVqPnb3kCcDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pzj8df93;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wBK4DUk2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GRvSBLo722ZOaj3GjU4OIQmt3AEldREeRCQr9wDOKzE=;
 b=pzj8df93nqVi6Z1LL66lx1lEJVFqDsLh2PCKVMcEbsMSgIldye7TwPVRl2MZoul5WM+EXy
 Ed2yLBzxsKYp3mlmgwvfTt5lZFY2oWNgv2b0R5MaZadGYkifp9IbxmLgAsohT0bXFUmTw2
 KY2JOrY0GHFRTAgk49VXW6qEBG1un88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GRvSBLo722ZOaj3GjU4OIQmt3AEldREeRCQr9wDOKzE=;
 b=wBK4DUk2p02kP9ioMlSbp+Kargv/2IEVAgxOD6+3ACMvK4pVZb8ivASLU96wG4heA9WBPG
 rxIk0k79tDVPQ6CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66BBD13985;
 Wed,  2 Sep 2026 11:04:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OPFpF7gCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:24 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:29 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-14-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=2933;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=bHauuKXtfTVOaxRoYFByI7b/1gnMt7XyD+ekFKUwCIs=;
 b=UcKUIQKFywonP3jUvhpKmBaUChzXVeU7WCovM8rVEBDGzuo0UX+HXq+KapvTO3t6rnDvNV2Hd
 zwVYcSwZWNnBAsLz1GJknS63Y617+LxGMPsq61voPvmSVXqCqfymxNu
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CBEA21F8C4
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 14/33] keyctl22: Test KEYCTL_RESTRICT_KEYRING
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
