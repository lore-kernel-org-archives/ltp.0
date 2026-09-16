Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D419BC88E5C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:04:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D53C33E7D4A
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:04:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8E623E6948
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 809A2600952
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C745221D85;
 Wed, 16 Sep 2026 14:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTtB7XQ1nVXPXmn3dLy/wiWqq8lnsQ66pjhe1V7ETmo=;
 b=UlEXGBCkjV/uhnTBUMTgmKNTMv0KlW68/kWmGnj+JQ1kA7Bqn1dzHy3siqV9bAToVz89UT
 EPlv2wOKz61H1kRgqdcTocTwYH4vRBvx1gvgEud0O57MJ9sMlGzPu667cq9Ko+fDIQTF8M
 Ht1NTN6nZXfxCOVEV8/8Tedn56vi03A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567456;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTtB7XQ1nVXPXmn3dLy/wiWqq8lnsQ66pjhe1V7ETmo=;
 b=r6uESG+0wjjaup/jsDdYmw6yljXQnVRif7nRBtbijMIcieRZ+rpWWW/0d0QggZEi/RdLJ9
 xm/1BKdstalMt4Cg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WFMEr1La;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=brTLlTGE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTtB7XQ1nVXPXmn3dLy/wiWqq8lnsQ66pjhe1V7ETmo=;
 b=WFMEr1LaBcSKSoTc8rLlG1y1oeJNOpUvH7OGrEXQVataEqZYUq4B1yWEfip32wPIvM7NPR
 wx/Pzdhh3j4uMlXwTA8KrKBhbUzn0t5L4yRZGnB8mHLt3HNafAhc9fEZlJ/+SMkpkDI8Ui
 M5LUr5zCm/yg4/vR6Zdf/L7jkRtRZnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567451;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTtB7XQ1nVXPXmn3dLy/wiWqq8lnsQ66pjhe1V7ETmo=;
 b=brTLlTGEBH+pClCeo3YqpfFsG/+aVCz6mgCISus2KkILSgjwhE5+VIAKBPHW4iLJMUAAFH
 uZ9T00gupLpV+KAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B42713888;
 Wed, 16 Sep 2026 14:04:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T6
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:11 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:31 +0200
Message-ID: <20260916140402.1797325-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C745221D85
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 05/36] keyctl11: Test KEYCTL_DESCRIBE with exact
 buffer size
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

Test KEYCTL_DESCRIBE when called with a buffer sized exactly to the
full description length: verify the string is copied completely
including the terminating NUL byte.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: use SAFE_NEW_USER_KEY(), memset() to 0xff ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl11.c | 62 +++++++++++++++++++++
 3 files changed, 64 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl11.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 9840cf678b..a074af68dd 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -728,6 +728,7 @@ keyctl07 keyctl07
 keyctl08 keyctl08
 keyctl09 keyctl09
 keyctl10 keyctl10
+keyctl11 keyctl11
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 08b2d101db..4974fe48d5 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -8,3 +8,4 @@
 /keyctl08
 /keyctl09
 /keyctl10
+/keyctl11
diff --git a/testcases/kernel/syscalls/keyctl/keyctl11.c b/testcases/kernel/syscalls/keyctl/keyctl11.c
new file mode 100644
index 0000000000..83f4814df6
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl11.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_DESCRIBE`` of :manpage:`keyctl(2)` with exact buffer size.
+ *
+ * [Algorithm]
+ *
+ * Describe a key into a buffer sized exactly to the full string length,
+ * verify full string copy including terminating NUL byte.
+ */
+
+#include "keyctl_common.h"
+
+static key_serial_t key;
+static long desc_len;
+static char *buf;
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	key = SAFE_NEW_USER_KEY("k", "payload", 7, KEY_SPEC_PROCESS_KEYRING);
+	SAFE_KEYCTL(KEYCTL_SETPERM, key, KEY_PERM_SET, 0, 0);
+
+	TEST(keyctl(KEYCTL_DESCRIBE, key, (unsigned long)NULL, 0, 0));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "KEYCTL_DESCRIBE failed");
+
+	desc_len = TST_RET;
+	buf = SAFE_MALLOC(desc_len);
+}
+
+static void cleanup(void)
+{
+	free(buf);
+}
+
+static void run(void)
+{
+	memset(buf, 0xff, desc_len);
+	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_DESCRIBE, key, (unsigned long)buf,
+				    desc_len, 0), desc_len);
+	if (!TST_PASS)
+		return;
+
+	if (buf[desc_len - 1] != '\0') {
+		tst_res(TFAIL, "description is not NUL terminated");
+		return;
+	}
+
+	tst_res(TPASS, "full description including NUL fits exact %ld byte buffer",
+		desc_len);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
