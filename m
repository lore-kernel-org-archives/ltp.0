Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DACDC88E77
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:07:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E0953E818E
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:07:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03D703E7FA9
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5A6211A00A49
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1A6891FF28;
 Wed, 16 Sep 2026 14:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ID9ZicRsWB8JG9uNzkDqia78oyGpHC0v83fYT/3PgF4=;
 b=nemD8wmUbdcWF/4G7hxsCnitQa3Rr/rYvQHzR16tFpPm62uaxb2DfMoHyHWxPbrVNU8K10
 Urs7GKDAag2PIYz0+Jq4UJ9Q2hptcFSBWPhlcA5dCBZCt/4HRgX3YknL1LlHPoS2TfhTNB
 7OYCCCT393ihKNHop7GmhSL74yl5/v0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ID9ZicRsWB8JG9uNzkDqia78oyGpHC0v83fYT/3PgF4=;
 b=sYzq2ggWRnaJZnG2inUpS7w/yOoczCHgge+mWS72mpVpbA5iSu0zcTr1ynrt0FbLsXxqXX
 aCMitG4laEw2rMDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ba4siC7w;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZzwzPJaF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ID9ZicRsWB8JG9uNzkDqia78oyGpHC0v83fYT/3PgF4=;
 b=Ba4siC7wRjrrix4ULD+EqgANlus3L9DughtIUWriyR9AwnSLxbJE7ZvoxESYbMvQiCji0R
 9ztCjpPjo3lu2IayhVe4dlXA0s1fBNa33ojNQGSx7QVGrVsPjfCIX9C+1Hk8nIIF1W1I1F
 +vYl8NIkv/0WyVeAuYhs/0cEQxb9dgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567460;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ID9ZicRsWB8JG9uNzkDqia78oyGpHC0v83fYT/3PgF4=;
 b=ZzwzPJaFySca/dIAT2yn+ix9Y6wIEnFf7pUN9fZMR9fpx9wE4tjfPAiJTNz/pWbX24ki8L
 NyxMbuqJczB9oFDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68BDD139A8;
 Wed, 16 Sep 2026 14:04:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T14
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:39 +0200
Message-ID: <20260916140402.1797325-14-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1A6891FF28
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 R_RATELIMIT(0.00)[to_ip_from(RL47ebk195wksjxkdm8ez9hex8)];
 RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 13/36] keyctl19: Test KEYCTL_MOVE with same source
 and destination
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

Test KEYCTL_MOVE when the source keyring equals the destination
keyring: verify the operation succeeds as a no-op and the key
remains linked in the keyring.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: use SAFE_NEW_RING(), SAFE_NEW_USER_KEY(), keyctl() ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl19.c | 43 +++++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl19.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 12923a4df2..affa47e957 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -736,6 +736,7 @@ keyctl15 keyctl15
 keyctl16 keyctl16
 keyctl17 keyctl17
 keyctl18 keyctl18
+keyctl19 keyctl19
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 808cd2d231..f321079233 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -16,3 +16,4 @@
 /keyctl16
 /keyctl17
 /keyctl18
+/keyctl19
diff --git a/testcases/kernel/syscalls/keyctl/keyctl19.c b/testcases/kernel/syscalls/keyctl/keyctl19.c
new file mode 100644
index 0000000000..ba58ceede0
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl19.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_MOVE`` of :manpage:`keyctl(2)` with same source and destination.
+ *
+ * [Algorithm]
+ *
+ * - move a key where the source keyring equals the destination keyring,
+ *   verify it is a successful no-op
+ */
+
+#include "keyctl_common.h"
+
+#define RING_DESC	"ltpkeyctl19"
+#define KEY_DESC	"k"
+#define PAYLOAD		"payload"
+
+static key_serial_t ring;
+static key_serial_t key;
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	ring = SAFE_NEW_RING(RING_DESC);
+	key = SAFE_NEW_USER_KEY(KEY_DESC, PAYLOAD, sizeof(PAYLOAD), ring);
+}
+
+static void run(void)
+{
+	TST_EXP_PASS(keyctl(KEYCTL_MOVE, key, ring, ring, 0));
+
+	TST_EXP_EQ_LI(keyctl(KEYCTL_SEARCH, ring, "user", KEY_DESC), key);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.min_kver = "5.3",
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
