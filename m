Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628A7C88E5C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:08:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C00EF3E8C54
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:08:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56A993E7D54
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C12A26008E4
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE7F921A7E;
 Wed, 16 Sep 2026 14:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ga7VbbweRRHQXSDu3PXI1Ix4xWo1WJWrheg/0nA4TTI=;
 b=XOg/t+AHCztoR3E531DEWiU8I2OWLZpys7oDtsQQtuwbZ1XY8muGGDRbso7lemLJKLpDZL
 t/LKBJq1W6SUhAuUQkxA0U86QXCcXEO9+Km7oUN3MIbE1acuuxGUVTg8Fs7CQZRO3zL4AF
 q3pEv8tSAuidVcp75dkOq7oTGuq0Vuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567463;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ga7VbbweRRHQXSDu3PXI1Ix4xWo1WJWrheg/0nA4TTI=;
 b=w+1cSEcBUx5vPJeLae6RL9CZS92llVs4OXZSVISFt37ex2K/xEiVyG12O4oHbxitFAwJMf
 IIOi4wfoUJ2g6lDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="tJ7/vqZz";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=z6XXqUSO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ga7VbbweRRHQXSDu3PXI1Ix4xWo1WJWrheg/0nA4TTI=;
 b=tJ7/vqZzGBByW6CwkNCbZjdgGqUqax8W8eQjlQPAyUyfHtHlaYTYfgixhIZogLfag2ekFu
 dt6EK+K1uZ5wjyq+ooMH2z9kK6uZ63NmvskXYMFQD0Rmd7YmXcXUYKYAbihLCKj1RBSJch
 Qe5ngaJEk+bTldz6qIDwpMvSHssmis4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567459;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ga7VbbweRRHQXSDu3PXI1Ix4xWo1WJWrheg/0nA4TTI=;
 b=z6XXqUSOg6s6uuXZmf6x4jAmcDWLrcU9Df4ZB8QIfn11hArNGKqMFvcKnNkBmwP2K/Ixh0
 v/YQNCXQ5fwpdODg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7715F13996;
 Wed, 16 Sep 2026 14:04:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T10
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:12 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:35 +0200
Message-ID: <20260916140402.1797325-10-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AE7F921A7E
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:dkim, suse.cz:email, suse.cz:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 09/36] keyctl15: Test KEYCTL_GET_SECURITY label
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

Test KEYCTL_GET_SECURITY label retrieval: verify reading the security
label of a valid key into a large buffer returns a positive length
and an empty string when no LSM label is set.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel:
* Always check for label being NUL terminated (Cyril)
* Use SAFE_NEW_USER_KEY(), SAFE_KEYCTL()
]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl15.c | 64 +++++++++++++++++++++
 3 files changed, 66 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl15.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 244fea95f4..bdac6e09e1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -732,6 +732,7 @@ keyctl11 keyctl11
 keyctl12 keyctl12
 keyctl13 keyctl13
 keyctl14 keyctl14
+keyctl15 keyctl15
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 8120454d8c..852fee4eab 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -12,3 +12,4 @@
 /keyctl12
 /keyctl13
 /keyctl14
+/keyctl15
diff --git a/testcases/kernel/syscalls/keyctl/keyctl15.c b/testcases/kernel/syscalls/keyctl/keyctl15.c
new file mode 100644
index 0000000000..9af3dd3527
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl15.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_GET_SECURITY`` label retrieval of :manpage:`keyctl(2)`.
+ *
+ * ``KEYCTL_GET_SECURITY`` reads the LSM security label of a key.
+ * When no label is set (no LSM enabled or the LSM does not label keys)
+ * the operation returns 1 and an empty string.
+ *
+ * [Algorithm]
+ *
+ * - read the label of a valid key into a large buffer, verify the return
+ *   value is at least 1 and an empty string is returned when no label is set
+ */
+
+#include "keyctl_common.h"
+
+#define KEY_DESC	"ltpkeyctl15"
+#define PAYLOAD		"payload"
+#define BUF_SIZE	128
+
+static key_serial_t key;
+static char buf[BUF_SIZE];
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	key = SAFE_NEW_USER_KEY(KEY_DESC, PAYLOAD, sizeof(PAYLOAD),
+			   KEY_SPEC_PROCESS_KEYRING);
+	SAFE_KEYCTL(KEYCTL_SETPERM, key, KEY_PERM_SET, 0, 0);
+}
+
+static void run(void)
+{
+	int rc;
+
+	memset(buf, 0, sizeof(buf));
+
+	rc = SAFE_KEYCTL(KEYCTL_GET_SECURITY, key, (unsigned long)buf, sizeof(buf), 0);
+
+	if (buf[0] != '\0')
+		tst_res(TFAIL, "empty label is not NUL terminated");
+
+	if (rc < 1) {
+		tst_res(TFAIL, "returned %d, expected >= 1", rc);
+		return;
+	}
+
+	if (rc == 1) {
+		tst_res(TPASS, "no label set, empty string returned");
+		return;
+	}
+
+	tst_res(TPASS, "security label returned, full length %d", rc);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
