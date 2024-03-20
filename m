Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305B9C54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 10:00:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95B733CFBF2
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 11:00:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A06F43C92E2
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 11:00:27 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6BE99208F83
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 11:00:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A74F134145
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 10:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710928826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZVc0Xbvv/HfRXgGNwuPFMEsqIclYylVyce19I0qQPo=;
 b=CoR3LEss21Wn5zlAKvcmZasRe2RjT/ZJZ+D+z84rScpwcsEENtHN8NFJAUNxq0NQDm2+MM
 VFTZ5ogzevxltjdMipnQe9EWy8YangtDdHs19hmHb66Z3Ghcc1uD/EZTwq0DocCbExBp64
 OKB9Kt6trZsq9NH1duwxEeL8cggjsfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710928826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZVc0Xbvv/HfRXgGNwuPFMEsqIclYylVyce19I0qQPo=;
 b=sCOMNKRST8QeXhydD4s694tqqjXRcAP2TYgVypFido4oixhZm/53tPsIrQM5x8037EOI/u
 w+ISZB2PHdzDRdBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710928826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZVc0Xbvv/HfRXgGNwuPFMEsqIclYylVyce19I0qQPo=;
 b=CoR3LEss21Wn5zlAKvcmZasRe2RjT/ZJZ+D+z84rScpwcsEENtHN8NFJAUNxq0NQDm2+MM
 VFTZ5ogzevxltjdMipnQe9EWy8YangtDdHs19hmHb66Z3Ghcc1uD/EZTwq0DocCbExBp64
 OKB9Kt6trZsq9NH1duwxEeL8cggjsfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710928826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZVc0Xbvv/HfRXgGNwuPFMEsqIclYylVyce19I0qQPo=;
 b=sCOMNKRST8QeXhydD4s694tqqjXRcAP2TYgVypFido4oixhZm/53tPsIrQM5x8037EOI/u
 w+ISZB2PHdzDRdBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 968A1136D6
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 10:00:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aJTdI7qz+mXGYAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 10:00:26 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 20 Mar 2024 10:59:27 +0100
Message-ID: <20240320095927.19973-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240320095927.19973-1-chrubis@suse.cz>
References: <20240320095927.19973-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [3.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[23.67%]
Authentication-Results: smtp-out1.suse.de;
	none
Subject: [LTP] [PATCH 2/2] syscalls: Add test for splicing to /dev/zero and
 /dev/null
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

Both of these devices discard written data.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/splice/.gitignore |  1 +
 testcases/kernel/syscalls/splice/splice09.c | 55 +++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 testcases/kernel/syscalls/splice/splice09.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 0889f58a1..50bc350f0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1518,6 +1518,7 @@ splice05 splice05
 splice06 splice06
 splice07 splice07
 splice08 splice08
+splice09 splice09
 
 tee01 tee01
 tee02 tee02
diff --git a/testcases/kernel/syscalls/splice/.gitignore b/testcases/kernel/syscalls/splice/.gitignore
index 9453cf93a..96b1727a1 100644
--- a/testcases/kernel/syscalls/splice/.gitignore
+++ b/testcases/kernel/syscalls/splice/.gitignore
@@ -6,3 +6,4 @@
 /splice06
 /splice07
 /splice08
+/splice09
diff --git a/testcases/kernel/syscalls/splice/splice09.c b/testcases/kernel/syscalls/splice/splice09.c
new file mode 100644
index 000000000..46f755b01
--- /dev/null
+++ b/testcases/kernel/syscalls/splice/splice09.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test for splicing to /dev/zero and /dev/null these two devices discard all
+ * data written to them.
+ *
+ * The support for splicing to /dev/zero was added in:
+ * 1b057bd800c3 ("drivers/char/mem: implement splice() for /dev/zero, /dev/full")
+ */
+
+#define _GNU_SOURCE
+#include "tst_test.h"
+
+static const char *test_devices[] = {
+	"/dev/null",
+	"/dev/zero",
+};
+
+static void verify_splice(unsigned int n)
+{
+	char buf[1024];
+	char dev_fd;
+	int pipefd[2];
+
+	memset(buf, 0xff, sizeof(buf));
+
+	tst_res(TINFO, "Testing %s", test_devices[n]);
+
+	dev_fd = SAFE_OPEN(test_devices[n], O_WRONLY);
+
+	SAFE_PIPE(pipefd);
+	SAFE_WRITE(1, pipefd[1], buf, sizeof(buf));
+
+	TST_EXP_POSITIVE(splice(pipefd[0], NULL, dev_fd, NULL, sizeof(buf), 0));
+
+	if (TST_PASS && TST_RET != sizeof(buf))
+		tst_res(TFAIL, "Wrote only part of the pipe buffer");
+	else
+		tst_res(TPASS, "Wrote whole pipe buffer");
+
+	SAFE_CLOSE(pipefd[0]);
+	SAFE_CLOSE(pipefd[1]);
+	SAFE_CLOSE(dev_fd);
+}
+
+static struct tst_test test = {
+	.test = verify_splice,
+	.tcnt = ARRAY_SIZE(test_devices),
+	.min_kver = "6.7",
+};
-- 
2.43.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
