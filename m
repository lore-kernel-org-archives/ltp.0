Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030C4C88E5C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:06:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F04A23E8C4D
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:06:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CAEB3E7A02
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EF5621A00A43
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D31101FE1D;
 Wed, 16 Sep 2026 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rzc08V7xEgLUPcthLGzUzeP464RmCpWvh8nYuPjNkEo=;
 b=lhv8oPmEII+3VSeJ/3FGkjMskcQ66PQrk6L07Ym/1zghK8WYrANeYkgeSnOM3dVcbvU39i
 uXXdYAGd9uX3Rp3ISGlPG3+0zH8lmoArQcgDDl8YXBYDbR7brb9jr9i9nihVW1oWpGOuWi
 Lx/rfi8thtggr/Ncm6XWbUrpc9LFloI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567462;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rzc08V7xEgLUPcthLGzUzeP464RmCpWvh8nYuPjNkEo=;
 b=OaiZc1rq0NMalzyYoRVJN2/cXBU6DWRGXbqWYpJ6nu6zOq11YfNVM0/Q0X7xYKjgvQq85y
 i9hwFvoXxPIzqyAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rzc08V7xEgLUPcthLGzUzeP464RmCpWvh8nYuPjNkEo=;
 b=HdynroFWRFJy2t9T9IPGoGARa8wBdPGj4aiyrmSBr3Zt+HU+M4cDVqpxFPymIA0ahZyvgC
 7kga5G2t1HfnJuDBY49hIOvs7WTzPtfaT80DwdODFq++3zVDsCmoQOPE0Or3WJBKmRLy0d
 C4VKPo12Chx1y07BXjX7XC41yDLxZUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567458;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rzc08V7xEgLUPcthLGzUzeP464RmCpWvh8nYuPjNkEo=;
 b=cxtT7eiDpYURt9FnOSfXhs0218NIL7U2z/rPv/lYweCj2n3XF6duhOrMcvGS8ou3KqpGC3
 6LpnQnDg+8T7BsCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD2FB1398D;
 Wed, 16 Sep 2026 14:04:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T8
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:11 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:33 +0200
Message-ID: <20260916140402.1797325-8-pvorel@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 07/36] keyctl13: Test KEYCTL_DESCRIBE size query
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

Test KEYCTL_DESCRIBE when called with a NULL buffer and buflen 0:
verify the call succeeds and returns the full description length
without writing to userspace memory.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: use SAFE_NEW_USER_KEY() ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl13.c | 46 +++++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index ef6a2ba536..1199277da0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -730,6 +730,7 @@ keyctl09 keyctl09
 keyctl10 keyctl10
 keyctl11 keyctl11
 keyctl12 keyctl12
+keyctl13 keyctl13
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 9ce6e2250b..d4ce61a6ee 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -10,3 +10,4 @@
 /keyctl10
 /keyctl11
 /keyctl12
+/keyctl13
diff --git a/testcases/kernel/syscalls/keyctl/keyctl13.c b/testcases/kernel/syscalls/keyctl/keyctl13.c
new file mode 100644
index 0000000000..70f3f5b846
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl13.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_DESCRIBE`` of :manpage:`keyctl(2)` with NULL buffer and buflen 0.
+ *
+ * [Algorithm]
+ *
+ * - describe a key with NULL buffer and ``buflen = 0``, verify the full length
+ *   is returned without writing
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+
+#include "keyctl_common.h"
+
+static key_serial_t key;
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	key = SAFE_NEW_USER_KEY("k", "payload", 7, KEY_SPEC_PROCESS_KEYRING);
+	SAFE_KEYCTL(KEYCTL_SETPERM, key, KEY_PERM_SET, 0, 0);
+}
+
+static void run(void)
+{
+	char expected[64];
+	long expected_len;
+
+	expected_len = snprintf(expected, sizeof(expected),
+				"user;%u;%u;%08x;k",
+				getuid(), getgid(), KEY_PERM_SET) + 1;
+
+	TST_EXP_VAL(keyctl(KEYCTL_DESCRIBE, key, (unsigned long)NULL, 0, 0),
+		    expected_len);
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
