Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D749C88E77
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:08:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BFAF3E7D4A
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:08:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E2623E8C43
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3B62660093B
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D837E1FEF9;
 Wed, 16 Sep 2026 14:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVzioii/HhBG0ZgnpfrGovJr5LCYnbFXahHz//5wA/8=;
 b=ug14h6npqBUOjtQa8YbBo1EVMIWdVoGNPdBztkSkt06o764xJja4YZ3n/NzP+mEy5dVVka
 a5sNmrtTaX+Qm8SDx+/qlbPczGe7YKrm8g7IqW2W4uKBpzbZMJ+auXGIbmtoikkCXOzvVy
 B/qNZHQ8MS3nCBY0YunEDOF04DxgUgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVzioii/HhBG0ZgnpfrGovJr5LCYnbFXahHz//5wA/8=;
 b=2HxhBqpNg0gBEcVf+V6FLW82sEpddmqZj3JslfdrSTjg6ppPe9dTIcwRNZ6Fbc+HautbdC
 PjJavxsQh4TnOHCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVzioii/HhBG0ZgnpfrGovJr5LCYnbFXahHz//5wA/8=;
 b=QazyHF5yyjdhITmzZQeuAhK/y3UQafeBZAHAxSEEKZsT/FzmUFVRB6zQcZfkPf8HOEVnIN
 Fab5dnen/kdY5eV2k6/mWoDxK0BcSebbrP69VFpWNxWIZjlzHNnRt59wZOr4CBYHn6ZNiJ
 w64TphGBrRX1dM3YeYABruuJmjx6dPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567459;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVzioii/HhBG0ZgnpfrGovJr5LCYnbFXahHz//5wA/8=;
 b=mV6KCSP1AwkgJDa3QvPzWobGGnX17TnHN/DE1/tbR4ZLw1KtKlbSZoBgYmRmmkWAz+G5nQ
 A3BU7DaJbnefASAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA196139A2;
 Wed, 16 Sep 2026 14:04:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T12
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:12 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:37 +0200
Message-ID: <20260916140402.1797325-12-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 11/36] keyctl17: Negative tests for
 KEYCTL_GET_SECURITY
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

Test error conditions of KEYCTL_GET_SECURITY using a parameterized
tcase table: verify ENOKEY on a bogus key id and ENOKEY when View
permission is missing (due to the kernel request-key auth token
fallback path).

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: use SAFE_NEW_USER_KEY() ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl17.c | 55 +++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl17.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 210552fec1..aba31b2c27 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -734,6 +734,7 @@ keyctl13 keyctl13
 keyctl14 keyctl14
 keyctl15 keyctl15
 keyctl16 keyctl16
+keyctl17 keyctl17
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index c351716d07..dddb45f856 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -14,3 +14,4 @@
 /keyctl14
 /keyctl15
 /keyctl16
+/keyctl17
diff --git a/testcases/kernel/syscalls/keyctl/keyctl17.c b/testcases/kernel/syscalls/keyctl/keyctl17.c
new file mode 100644
index 0000000000..77e8fd6abe
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl17.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Negative test cases for ``KEYCTL_GET_SECURITY`` of :manpage:`keyctl(2)`.
+ *
+ * [Algorithm]
+ *
+ * - get_security with bogus key id fails with ``ENOKEY``
+ * - get_security without View permission fails with ``ENOKEY`` (the kernel
+ *   falls back to looking for an auth token and returns its ``ENOKEY``)
+ */
+
+#include "keyctl_common.h"
+
+#define BUF_SIZE	128
+
+static key_serial_t key_no_view;
+static key_serial_t bogus_id = INT32_MAX;
+static char buf[BUF_SIZE];
+
+static struct tcase {
+	key_serial_t *keyid;
+	int exp_errno;
+	const char *desc;
+} tcases[] = {
+	{ &bogus_id, ENOKEY, "bogus key id" },
+	{ &key_no_view, ENOKEY, "key without View permission" },
+};
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	key_no_view = SAFE_NEW_USER_KEY("k_no_view", "payload", 7, KEY_SPEC_PROCESS_KEYRING);
+	SAFE_KEYCTL(KEYCTL_SETPERM, key_no_view, KEY_PERM_NO_VIEW, 0, 0);
+}
+
+static void verify_negative(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TST_EXP_FAIL2(keyctl(KEYCTL_GET_SECURITY, (unsigned long)*tc->keyid,
+			     (unsigned long)buf, sizeof(buf), 0),
+		      tc->exp_errno,
+		      "KEYCTL_GET_SECURITY with %s", tc->desc);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = verify_negative,
+	.tcnt = ARRAY_SIZE(tcases),
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
