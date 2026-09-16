Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F46C88E5C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:09:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6CBC3E8C47
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:09:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B39643E7FA7
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 28F10600064
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 804B61FE05;
 Wed, 16 Sep 2026 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ybUj69Lm7VAwy5jm0/P1ZR5rrceT3TqCF+dxiC5r9s=;
 b=lFzAF6C2wawMTMglHUp/KtfcpnGzilhH9R5aQJTH7uMPuaiVbdc/uohmrRlGq8iJj/oYj+
 RGIBkAImZyRLdQxY8Ku2AUd7x8/ficOWNxtXA17zTA7lcfHg7edn+dL/TJGxjZfHkA7C5L
 H01km9eVc6aipHRP6acFcPS47X7x/t0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ybUj69Lm7VAwy5jm0/P1ZR5rrceT3TqCF+dxiC5r9s=;
 b=AaowF4R5Kwd2i3+gDNJ6smIUZVlPgbLvDFdvAMGHNXVor6XII3uJkfIhVzgrszQ23rJpKV
 cJGT8dTh4SQm1FAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ybUj69Lm7VAwy5jm0/P1ZR5rrceT3TqCF+dxiC5r9s=;
 b=nCVQ7aVnmMvkEVhkHWDetKzS9She7ucQJTx/ybXrAtWFY9j8q48o/2wJcALnGxBl+/s40J
 vMBRUXDbQIdB7j9++pD+gjHoVMwaHm3SCyNG5LOc1fxdyNOLbP90da7xbwDf/Xmsg0iPJK
 r7fkG1Bnkx0rIeH4qeaHfjb2Bo5Ln5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567467;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ybUj69Lm7VAwy5jm0/P1ZR5rrceT3TqCF+dxiC5r9s=;
 b=TtOs0gvyiTqF2YPg/YrIQlGHsSuMD8zbcnhfXBPrSRTvAxThYYJCsNzbXIs6yyBJtbhbYd
 Z48ivnsOwDkqNsBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62D68139B7;
 Wed, 16 Sep 2026 14:04:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T22
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:17 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:47 +0200
Message-ID: <20260916140402.1797325-22-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLtzdurrd6usbijy4f5nozqpqy)];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 21/36] keyctl26: Test KEYCTL_DH_COMPUTE size query
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

Test KEYCTL_DH_COMPUTE buffer size query: verify that calling
with buflen 0 returns the required output buffer size (256)
without writing to userspace.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: use SAFE_NEW_USER_KEY() ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl26.c | 53 +++++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl26.c

diff --git a/runtest/syscalls b/runtest/syscalls
index dfe01c8e0e..7485996ec0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -743,6 +743,7 @@ keyctl22 keyctl22
 keyctl23 keyctl23
 keyctl24 keyctl24
 keyctl25 keyctl25
+keyctl26 keyctl26
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 4cf7725587..dd282b7ced 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -23,3 +23,4 @@
 /keyctl23
 /keyctl24
 /keyctl25
+/keyctl26
diff --git a/testcases/kernel/syscalls/keyctl/keyctl26.c b/testcases/kernel/syscalls/keyctl/keyctl26.c
new file mode 100644
index 0000000000..bdd852fb4c
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl26.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_DH_COMPUTE`` size query of :manpage:`keyctl(2)`.
+ *
+ * [Algorithm]
+ *
+ * - verify calling ``KEYCTL_DH_COMPUTE`` with ``buflen = 0`` returns required
+ *   buffer size (256) without writing
+ */
+
+#include "keyctl_common.h"
+#include "keyctl_dh_data.h"
+
+static struct keyctl_dh_params *dh_params;
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	dh_params->priv = SAFE_NEW_USER_KEY("dh_priv", dh_priv, sizeof(dh_priv),
+				       KEY_SPEC_PROCESS_KEYRING);
+	dh_params->prime = SAFE_NEW_USER_KEY("dh_prime", dh_prime, sizeof(dh_prime),
+					KEY_SPEC_PROCESS_KEYRING);
+	dh_params->base = SAFE_NEW_USER_KEY("dh_base", dh_base, sizeof(dh_base),
+				       KEY_SPEC_PROCESS_KEYRING);
+}
+
+static void run(void)
+{
+	TST_EXP_VAL(keyctl(KEYCTL_DH_COMPUTE, (unsigned long)dh_params,
+			   (unsigned long)NULL, 0, 0),
+		    (long)sizeof(dh_expected_secret));
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.min_kver = "4.7",
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_KEYS=y",
+		"CONFIG_KEY_DH_OPERATIONS=y",
+		"CONFIG_CRYPTO_DH",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&dh_params, .size = sizeof(*dh_params)},
+		{},
+	},
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
