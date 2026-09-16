Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18ECFC88E5C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:12:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22DEC3E7AD6
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:11:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 127623E8C4E
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BF9172009A2
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D6251FEF1;
 Wed, 16 Sep 2026 14:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lsR2TXq6ub6tlNhNbzrzX/67yvzBYg8yWDvgawMy8Kg=;
 b=MjtXUIu4+WQqPwvbSCHZcIR6xeKuAEF+qCHe3lVlRr6CQ3bFvqKP7HEvu+7OlqAcl2U7Le
 v5QxI59tUqqHt2e2oFOZMQWIh0YN2AZkwMoXOPwzPifzRW7ITF9/jotQ5nydJUb+E76S+f
 fBFswTBZYo8BIPvAwiH/tbRHESpRB/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567473;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lsR2TXq6ub6tlNhNbzrzX/67yvzBYg8yWDvgawMy8Kg=;
 b=WJ++90kIeMFthtRuPptjz56Hu/C1Ld8MXZ4XrJ7xMQ3XNBNtVAabJk/5fdO4EMY+pXHeBv
 VT4igJdQLGUVHeDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lsR2TXq6ub6tlNhNbzrzX/67yvzBYg8yWDvgawMy8Kg=;
 b=1GqWLGfpGR6qoo3RXLV9IOB4YLmleEU7IRyL7jeAUN0jZTkyvOuNlWpPwJwKUqNLzq7f+m
 yWDn07C9xve2hl61Wv1icBnLKpVaE6SQGTVUv9epqtlUol56YT3rmR9QgvNQ1yJ2DPKpw9
 798IUaaTeUp8WA7W3AQRF8WVTQSAWas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lsR2TXq6ub6tlNhNbzrzX/67yvzBYg8yWDvgawMy8Kg=;
 b=0dh9oQkNSTRuXadHFyPQevNhyKnaLI/u6R0AkJYqpx7GOEO5HJi8oS4+3IWRNxPa2Blmis
 XbGUI9ZVdxcplvAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02A88139D0;
 Wed, 16 Sep 2026 14:04:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T35
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:04:00 +0200
Message-ID: <20260916140402.1797325-35-pvorel@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:mid];
 ARC_NA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 34/36] keyctl37: Negative tests for
 KEYCTL_CAPABILITIES
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

Add negative test cases for KEYCTL_CAPABILITIES verifying that
passing a NULL buffer with a non-zero length or an invalid buffer
pointer fails with EFAULT.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl37.c | 63 +++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl37.c

diff --git a/runtest/syscalls b/runtest/syscalls
index f42303345e..e9a31a1947 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -754,6 +754,7 @@ keyctl33 keyctl33
 keyctl34 keyctl34
 keyctl35 keyctl35
 keyctl36 keyctl36
+keyctl37 keyctl37
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index a4da8ae805..7ee6b90989 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -34,3 +34,4 @@
 /keyctl34
 /keyctl35
 /keyctl36
+/keyctl37
diff --git a/testcases/kernel/syscalls/keyctl/keyctl37.c b/testcases/kernel/syscalls/keyctl/keyctl37.c
new file mode 100644
index 0000000000..08d1db03b8
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl37.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Negative test cases for ``KEYCTL_CAPABILITIES`` of :manpage:`keyctl(2)`.
+ *
+ * [Algorithm]
+ *
+ * - verify ``KEYCTL_CAPABILITIES`` with NULL buffer and ``buflen > 0`` fails with ``EFAULT``
+ * - verify ``KEYCTL_CAPABILITIES`` with invalid pointer fails with ``EFAULT``
+ */
+
+#include "keyctl_common.h"
+
+static void *bad_addr;
+
+static struct tcase {
+	void **buf;
+	size_t buflen;
+	int exp_errno;
+	const char *desc;
+} tcases[] = {
+	{
+		.buf = NULL,
+		.buflen = 1,
+		.exp_errno = EFAULT,
+		.desc = "NULL buffer with non-zero buflen",
+	},
+	{
+		.buf = &bad_addr,
+		.buflen = 1,
+		.exp_errno = EFAULT,
+		.desc = "invalid buffer pointer",
+	},
+};
+
+static void setup(void)
+{
+	bad_addr = tst_get_bad_addr(NULL);
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	void *p = tc->buf ? *tc->buf : NULL;
+
+	TST_EXP_FAIL2(keyctl(KEYCTL_CAPABILITIES, (unsigned long)p, tc->buflen, 0, 0),
+		      tc->exp_errno,
+		      "%s", tc->desc);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
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
