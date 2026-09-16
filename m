Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C1BC88E77
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:07:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2A3B3E79E5
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:07:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C0413E8C4E
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C24E12009E5
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A0CC61FEE5;
 Wed, 16 Sep 2026 14:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3kHDakLafB4xF5wN4KyoS2QiqhX1z0C8sN5mDSX2NFE=;
 b=UDGlI7KPnJatAQ5+U2+ck+BbHz8HJkGVsY/Q+Sup7VnJ6wJPWbkhNDabWXSImF4dp+F3Zw
 bd1WYGlTsaCeg2wFdBwEmJ1NwtPrk9DB/kW6N+kozpTZ8cUSAtDy49/Qph/v/wp3ddy9Wi
 9oWd8fKLOYrE+gdKOAYHVGIrnXPvDrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567463;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3kHDakLafB4xF5wN4KyoS2QiqhX1z0C8sN5mDSX2NFE=;
 b=pSL/o6ujBv7nahJdw9/nxBmKgybkuFjJpCj8oQl7qBO0++IhRVceHFFiEgH5Nol6GfNrUh
 OSI0SIlLnooa+8Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EGOZkqIN;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WTy29GGn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3kHDakLafB4xF5wN4KyoS2QiqhX1z0C8sN5mDSX2NFE=;
 b=EGOZkqINPjsDHdFDsaWNC1wdOfOhGQzVxA1JUPEcBuNzL3GsGRi2An9YhzqZa/JKduNXxH
 KaRjnDT6hDqvP1IXFElY8b9IR39IPxF4DiNefBnCUegSPrannafgi7MjvRM0WMYCntd9gy
 CqQQjhJ9QF7zt0vayq45Vm0NbtFBAjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567459;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3kHDakLafB4xF5wN4KyoS2QiqhX1z0C8sN5mDSX2NFE=;
 b=WTy29GGn8Quyv0dMd6omeV5kb28jVQMvjMXssmn5gQKKoSWjc34hIkJF8aPvGYZLr/qizk
 mi05KbVKqy2jBZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3887213991;
 Wed, 16 Sep 2026 14:04:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T9
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:12 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:34 +0200
Message-ID: <20260916140402.1797325-9-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: A0CC61FEE5
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 08/36] keyctl14: Negative tests for KEYCTL_DESCRIBE
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

Test error conditions of KEYCTL_DESCRIBE using a parameterized
tcase table: verify ENOKEY on a bogus key id and EACCES when View
permission is missing.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: use SAFE_NEW_USER_KEY() ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl14.c | 54 +++++++++++++++++++++
 3 files changed, 56 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl14.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 1199277da0..244fea95f4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -731,6 +731,7 @@ keyctl10 keyctl10
 keyctl11 keyctl11
 keyctl12 keyctl12
 keyctl13 keyctl13
+keyctl14 keyctl14
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index d4ce61a6ee..8120454d8c 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -11,3 +11,4 @@
 /keyctl11
 /keyctl12
 /keyctl13
+/keyctl14
diff --git a/testcases/kernel/syscalls/keyctl/keyctl14.c b/testcases/kernel/syscalls/keyctl/keyctl14.c
new file mode 100644
index 0000000000..0323865c54
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl14.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Negative test cases for ``KEYCTL_DESCRIBE`` of :manpage:`keyctl(2)`.
+ *
+ * [Algorithm]
+ *
+ * - describe with bogus key id fails with ``ENOKEY``
+ * - describe without View permission fails with ``EACCES``
+ */
+
+#include "keyctl_common.h"
+
+#define BUF_SIZE	64
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
+	{ &key_no_view, EACCES, "key without View permission" },
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
+	TST_EXP_FAIL2(keyctl(KEYCTL_DESCRIBE, (unsigned long)*tc->keyid,
+			     (unsigned long)buf, sizeof(buf), 0),
+		      tc->exp_errno,
+		      "KEYCTL_DESCRIBE with %s", tc->desc);
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
