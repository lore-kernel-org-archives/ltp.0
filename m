Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CE2C88E5C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:06:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2218E3E8C55
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:06:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82A343E803E
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 253061400BD0
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7AEA61FF54;
 Wed, 16 Sep 2026 14:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=emYNbedeKaUiG48hU0MerHbs3stnisVvS8BRryq6Kdw=;
 b=kbj9Za/c6bVJkpGUsIgMb8yBkMO6A+LZAVCJWjxutD069/dZsS6PjoBDKD0tVVJnLbtd0i
 hjDu2enS+BMu3ArSG1TvWukYWDTZuNR0bhFFLreTEcq8Ifqh3DmNDHifQLFDYZ/7DM7u70
 zQpkyYiH7za4pxWAff3tEoX968MA61I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=emYNbedeKaUiG48hU0MerHbs3stnisVvS8BRryq6Kdw=;
 b=dKUPVGn9ZjTYcnTpHu2jny9VZ3li+Du7DA920W/b7CGUIKQuXBhkeXT9S5NmN06Gs1L7Ox
 S8r+w4vLfF+8uqAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=emYNbedeKaUiG48hU0MerHbs3stnisVvS8BRryq6Kdw=;
 b=PfpbictBOvd/5QTJmFEa8WAUuH74nsQSDVzY8Kckhey+UzLWQHjyFJrn20/rWO2z0NBwwv
 inmuOxwwGf+uM14EPhvzIozuP/ygMNAvhi77CQc66sXBh22ggTqsCYbl53VVWJZtKS6CHL
 gS+B6u1/oCiW7T+FM9XUghAdMdIAQ5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567460;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=emYNbedeKaUiG48hU0MerHbs3stnisVvS8BRryq6Kdw=;
 b=+WVGSFijYrDNmmEcsFRcXElWjaiG7Z/YbkgRF8ZrofpIXpdNtecOH1oxHreyieVbL89FxT
 jmpv8b9nKBgc5JCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72BB8139AD;
 Wed, 16 Sep 2026 14:04:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T17
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:14 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:42 +0200
Message-ID: <20260916140402.1797325-17-pvorel@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email,suse.com:email];
 ARC_NA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 16/36] keyctl22: Test KEYCTL_RESTRICT_KEYRING
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: use SAFE_NEW_RING(), SAFE_NEW_USER_KEY() ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl22.c | 54 +++++++++++++++++++++
 3 files changed, 56 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl22.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 460d43850e..d33b24167a 100644
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
index e8c71e79e6..82a74e4a38 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -19,3 +19,4 @@
 /keyctl19
 /keyctl20
 /keyctl21
+/keyctl22
diff --git a/testcases/kernel/syscalls/keyctl/keyctl22.c b/testcases/kernel/syscalls/keyctl/keyctl22.c
new file mode 100644
index 0000000000..79e9c3cd42
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
+	ring_reject = SAFE_NEW_RING("ltpkeyctl22_reject");
+	user_key = SAFE_NEW_USER_KEY("k", PAYLOAD, sizeof(PAYLOAD),
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
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
