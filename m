Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90817C88E5C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:12:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F2723E8C51
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:12:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74FE93E8C4C
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 282CE6008D6
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D7C571FEE8;
 Wed, 16 Sep 2026 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXv5ut7F50HvDxhDjtKLrWhMurUppac5aFntf248+sc=;
 b=l5d2Vpzb+EtM956mqYU83gDtG6uwvLmexvsk6fbgNSqWsyxiYBIr0eWDx/yWpU1yYOYXEN
 4TV3egpl/c0yJZ0QEWqxXiKpugM4pNPct9P+GRik9xdOi0r9OlIN/JV0gh7r7x1mUot0hu
 0E8slHndiOuqgbRjNgwjqDdf8C9x12A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567473;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXv5ut7F50HvDxhDjtKLrWhMurUppac5aFntf248+sc=;
 b=nsBELKX7nY8uQ+JOpa21ZD2VqG5m2IehlR3HKm8sAmBYp+Va3/G9aOO10S4/MQs4nb1ivT
 aFw5Cpsp8KjUT9CA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=O5PNCFdS;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CK0QssVH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXv5ut7F50HvDxhDjtKLrWhMurUppac5aFntf248+sc=;
 b=O5PNCFdSix0GuynSTACB4xX1y/mHSbgtGsHL9NGT50/XUa+kI4VV9dtzJPI3cbTg6/yze8
 EaSns5H1Jf1A/21+KmIuzcCiGYurQh0SXNQkVn/EQpCOWzGnD7Ph/pfuJHH4vFnwaYxjYj
 a0163S1Pd5DO+yXzPhjwIHqSXSaWumM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567468;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXv5ut7F50HvDxhDjtKLrWhMurUppac5aFntf248+sc=;
 b=CK0QssVHgEo1NhMNdhtsqf5FpaBPWUPLEf/7NTd9Rz34tXCFlIGMIUe509r3/bCMFbNBDU
 fmEDIvRe+f3WeMDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75762139C3;
 Wed, 16 Sep 2026 14:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T32
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:23 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:57 +0200
Message-ID: <20260916140402.1797325-32-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: D7C571FEE8
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RL47ebk195wksjxkdm8ez9hex8)];
 TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 31/36] keyctl34: Test KEYCTL_CAPABILITIES flag
 retrieval
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

Test keyrings subsystem capabilities retrieval with KEYCTL_CAPABILITIES
and verify standard capability bits (CAPABILITIES, INVALIDATE,
RESTRICT_KEYRING, MOVE, NS_KEYRING_NAME, NS_KEY_TAG).

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: use SAFE_KEYCTL() ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl34.c | 61 +++++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl34.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 8b6dc16250..e5450ff173 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -751,6 +751,7 @@ keyctl30 keyctl30
 keyctl31 keyctl31
 keyctl32 keyctl32
 keyctl33 keyctl33
+keyctl34 keyctl34
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 0f209d7e07..f2ce330d77 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -31,3 +31,4 @@
 /keyctl31
 /keyctl32
 /keyctl33
+/keyctl34
diff --git a/testcases/kernel/syscalls/keyctl/keyctl34.c b/testcases/kernel/syscalls/keyctl/keyctl34.c
new file mode 100644
index 0000000000..3285aa467f
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl34.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_CAPABILITIES`` of :manpage:`keyctl(2)`, added in Linux 5.3.
+ *
+ * ``KEYCTL_CAPABILITIES`` retrieves the bitmask of features and capabilities
+ * supported by the keyrings subsystem in the running kernel.
+ *
+ * [Algorithm]
+ *
+ * - retrieve keyrings subsystem capabilities into a buffer
+ * - verify return value is at least 2 bytes
+ * - verify standard capability bits ``KEYCTL_CAPS0_CAPABILITIES``,
+ *   ``KEYCTL_CAPS0_INVALIDATE``, ``KEYCTL_CAPS0_RESTRICT_KEYRING``,
+ *   ``KEYCTL_CAPS0_MOVE``, ``KEYCTL_CAPS1_NS_KEYRING_NAME``, and
+ *   ``KEYCTL_CAPS1_NS_KEY_TAG`` are set
+ */
+
+#include "keyctl_common.h"
+
+static unsigned char caps[8];
+
+static void run(void)
+{
+	int rc;
+
+	memset(caps, 0, sizeof(caps));
+
+	rc = SAFE_KEYCTL(KEYCTL_CAPABILITIES, (unsigned long)caps, sizeof(caps), 0, 0);
+
+	if (rc < 2) {
+		tst_res(TFAIL, "KEYCTL_CAPABILITIES returned %d, expected at least 2", rc);
+		return;
+	}
+
+	TST_EXP_EXPR(caps[0] & KEYCTL_CAPS0_CAPABILITIES,
+		     "KEYCTL_CAPS0_CAPABILITIES is set");
+	TST_EXP_EXPR(caps[0] & KEYCTL_CAPS0_INVALIDATE,
+		     "KEYCTL_CAPS0_INVALIDATE is set");
+	TST_EXP_EXPR(caps[0] & KEYCTL_CAPS0_RESTRICT_KEYRING,
+		     "KEYCTL_CAPS0_RESTRICT_KEYRING is set");
+	TST_EXP_EXPR(caps[0] & KEYCTL_CAPS0_MOVE,
+		     "KEYCTL_CAPS0_MOVE is set");
+
+	TST_EXP_EXPR(caps[1] & KEYCTL_CAPS1_NS_KEYRING_NAME,
+		     "KEYCTL_CAPS1_NS_KEYRING_NAME is set");
+	TST_EXP_EXPR(caps[1] & KEYCTL_CAPS1_NS_KEY_TAG,
+		     "KEYCTL_CAPS1_NS_KEY_TAG is set");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "5.3",
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_KEYS=y",
+		NULL
+	},
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
