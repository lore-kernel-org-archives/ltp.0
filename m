Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F80CC54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 10:01:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE9713CE649
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 11:01:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BAC593CFBEE
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 11:00:31 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 60564600648
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 11:00:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 466B020C3C
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 10:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710928826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QzDqX51KQycQatL16079fa5Sjr5mgjb4pppzF/1o15Q=;
 b=LBFZb4jXF68AI0bzLpZUOq6OUrTYM5pOwFsz0ZmEW8Xd67gnI9nV1tSBVefvGiFIq/lgpc
 cSjbkHCSN5dJAmfMumjSQoEhkyyB74d6E5cLp3S+tUb7fdfymaZQjTbOqlsXOA6Pizc383
 I3K0QYRYgEMRLUk4SL1k7OPyzncvh/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710928826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QzDqX51KQycQatL16079fa5Sjr5mgjb4pppzF/1o15Q=;
 b=/cb7O8Tipw8a3pYL2jwG1a3jVXeiueBxArH0SNLLtqhgja9zxPyc/SDdFNFv1kGzrRRb41
 Er3JHlksOLe5u9DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710928826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QzDqX51KQycQatL16079fa5Sjr5mgjb4pppzF/1o15Q=;
 b=LBFZb4jXF68AI0bzLpZUOq6OUrTYM5pOwFsz0ZmEW8Xd67gnI9nV1tSBVefvGiFIq/lgpc
 cSjbkHCSN5dJAmfMumjSQoEhkyyB74d6E5cLp3S+tUb7fdfymaZQjTbOqlsXOA6Pizc383
 I3K0QYRYgEMRLUk4SL1k7OPyzncvh/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710928826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QzDqX51KQycQatL16079fa5Sjr5mgjb4pppzF/1o15Q=;
 b=/cb7O8Tipw8a3pYL2jwG1a3jVXeiueBxArH0SNLLtqhgja9zxPyc/SDdFNFv1kGzrRRb41
 Er3JHlksOLe5u9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3441B136D6
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 10:00:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ed/NC7qz+mXDYAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 10:00:26 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 20 Mar 2024 10:59:26 +0100
Message-ID: <20240320095927.19973-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240320095927.19973-1-chrubis@suse.cz>
References: <20240320095927.19973-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LBFZb4jX;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/cb7O8Ti"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 466B020C3C
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls: Add test for splicing from /dev/zero
 and /dev/full
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

Both of these devices produce zeroes when read.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/splice/.gitignore |  1 +
 testcases/kernel/syscalls/splice/splice08.c | 88 +++++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 testcases/kernel/syscalls/splice/splice08.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 4ed2b5602..0889f58a1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1517,6 +1517,7 @@ splice04 splice04
 splice05 splice05
 splice06 splice06
 splice07 splice07
+splice08 splice08
 
 tee01 tee01
 tee02 tee02
diff --git a/testcases/kernel/syscalls/splice/.gitignore b/testcases/kernel/syscalls/splice/.gitignore
index 88a8dff78..9453cf93a 100644
--- a/testcases/kernel/syscalls/splice/.gitignore
+++ b/testcases/kernel/syscalls/splice/.gitignore
@@ -5,3 +5,4 @@
 /splice05
 /splice06
 /splice07
+/splice08
diff --git a/testcases/kernel/syscalls/splice/splice08.c b/testcases/kernel/syscalls/splice/splice08.c
new file mode 100644
index 000000000..cdd51b66c
--- /dev/null
+++ b/testcases/kernel/syscalls/splice/splice08.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test for splicing from /dev/zero and /dev/full.
+ *
+ * The support for splicing from /dev/zero and /dev/full was removed in:
+ * c6585011bc1d ("splice: Remove generic_file_splice_read()")
+ *
+ * And added back in:
+ * 1b057bd800c3 ("drivers/char/mem: implement splice() for /dev/zero, /dev/full")
+ */
+
+#define _GNU_SOURCE
+#include "tst_test.h"
+
+static int fd_zero;
+static int fd_full;
+
+static void test_splice(unsigned int bytes, int dev_fd)
+{
+	int pipefd[2];
+	char buf[bytes];
+	size_t i;
+	int fail = 0;
+
+	memset(buf, 0xff, sizeof(buf));
+
+	SAFE_PIPE(pipefd);
+
+	TST_EXP_POSITIVE(splice(dev_fd, NULL, pipefd[1], NULL, sizeof(buf), 0));
+
+	if (!TST_PASS)
+		goto ret;
+
+	SAFE_READ(1, pipefd[0], buf, sizeof(buf));
+
+	for (i = 0; i < sizeof(buf); i++) {
+		if (buf[i])
+			fail++;
+	}
+
+	if (fail)
+		tst_res(TFAIL, "Non-zero bytes spliced from /dev/zero");
+	else
+		tst_res(TPASS, "All bytes spliced from /dev/zero are zeroed");
+
+ret:
+	SAFE_CLOSE(pipefd[0]);
+	SAFE_CLOSE(pipefd[1]);
+}
+
+static void verify_splice(unsigned int n)
+{
+	unsigned int bytes = 1009 * n;
+
+	tst_res(TINFO, "Splicing %u bytes from /dev/zero", bytes);
+	test_splice(bytes, fd_zero);
+	tst_res(TINFO, "Splicing %u bytes from /dev/full", bytes);
+	test_splice(bytes, fd_full);
+}
+
+static void setup(void)
+{
+	fd_zero = SAFE_OPEN("/dev/zero", O_RDONLY);
+	fd_full = SAFE_OPEN("/dev/full", O_RDONLY);
+}
+
+static void cleanup(void)
+{
+	if (fd_zero > 0)
+		SAFE_CLOSE(fd_zero);
+
+	if (fd_full > 0)
+		SAFE_CLOSE(fd_full);
+}
+
+static struct tst_test test = {
+	.test = verify_splice,
+	.tcnt = 9,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "6.7",
+};
-- 
2.43.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
