Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F57BCDB465
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 12:33:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D54B3CF586
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 14:33:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 323F53CEF7A
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 14:32:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A37261400206
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 14:32:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E53601F74A;
 Mon, 16 Oct 2023 12:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697459565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kG6qEanlcZAFrWtqDvq2DOjtZ/PgnCIAShHsDI4JaDA=;
 b=G7bWTMK6OeJm3c9u7GcSGRGnss2Y3L3N+g+C/h5ivPSYTtv895D+FUD1KoM24C16dRwWYv
 FBapv77jxR/8bnLec8mYcMAV/9gm5qjgsl7PatELvGxpwHqqECc6puOTZ1T40rdqjoBgtT
 HVlyAGlYuAlbVxN9S6YHm6xXrk1hmpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697459565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kG6qEanlcZAFrWtqDvq2DOjtZ/PgnCIAShHsDI4JaDA=;
 b=iVYdcofEpNrDhRxzW6jwtJXIB3YHd/Iie27fgBeIdDuEmmm2DZMz7pW6kbPyARzVce0kF9
 CFcMv/1Ffg2FGfBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF930133B7;
 Mon, 16 Oct 2023 12:32:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xlShMW0tLWVWHwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 16 Oct 2023 12:32:45 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 16 Oct 2023 14:33:20 +0200
Message-ID: <20231016123320.9865-5-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016123320.9865-1-chrubis@suse.cz>
References: <20231016123320.9865-1-chrubis@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [6.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; BROKEN_CONTENT_TYPE(1.50)[];
 R_RATELIMIT(0.00)[from(RLwca6rbpw4iejis8bsi6)];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-0.998]; NEURAL_SPAM_LONG(3.00)[1.000];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_CC(0.00)[infradead.org, gmail.com, redhat.com, kernel.org,
 zeniv.linux.org.uk, suse.cz, vger.kernel.org]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] syscalls: splice07: New splice tst_fd iterator
 test
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

We loop over all possible combinations of file descriptors in the test
and filter out combinations that actually make sense and either block or
attempt to copy data.

The rest of invalid options produce either EINVAL or EBADF and there
does not seem to be any clear pattern to the choices of these two.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/splice/.gitignore |  1 +
 testcases/kernel/syscalls/splice/splice07.c | 85 +++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 testcases/kernel/syscalls/splice/splice07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 55396aad8..3af634c11 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1515,6 +1515,7 @@ splice03 splice03
 splice04 splice04
 splice05 splice05
 splice06 splice06
+splice07 splice07
 
 tee01 tee01
 tee02 tee02
diff --git a/testcases/kernel/syscalls/splice/.gitignore b/testcases/kernel/syscalls/splice/.gitignore
index 61e979ad6..88a8dff78 100644
--- a/testcases/kernel/syscalls/splice/.gitignore
+++ b/testcases/kernel/syscalls/splice/.gitignore
@@ -4,3 +4,4 @@
 /splice04
 /splice05
 /splice06
+/splice07
diff --git a/testcases/kernel/syscalls/splice/splice07.c b/testcases/kernel/syscalls/splice/splice07.c
new file mode 100644
index 000000000..74d3e9c7a
--- /dev/null
+++ b/testcases/kernel/syscalls/splice/splice07.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2023 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * [Description]
+ *
+ */
+#define _GNU_SOURCE
+
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+#include "tst_test.h"
+
+void check_splice(struct tst_fd *fd_in, struct tst_fd *fd_out)
+{
+	int exp_errno = EINVAL;
+
+	/* These combinations just hang */
+	if (fd_in->type == TST_FD_PIPE_READ) {
+		switch (fd_out->type) {
+		case TST_FD_FILE:
+		case TST_FD_PIPE_WRITE:
+		case TST_FD_UNIX_SOCK:
+		case TST_FD_INET_SOCK:
+		case TST_FD_MEMFD:
+			return;
+		default:
+		break;
+		}
+	}
+
+	if (fd_out->type == TST_FD_PIPE_WRITE) {
+		switch (fd_in->type) {
+		/* While these combinations succeeed */
+		case TST_FD_FILE:
+		case TST_FD_MEMFD:
+			return;
+		/* And this complains about socket not being connected */
+		case TST_FD_INET_SOCK:
+			return;
+		default:
+		break;
+		}
+	}
+
+	/* These produce EBADF instead of EINVAL */
+	switch (fd_out->type) {
+	case TST_FD_DIR:
+	case TST_FD_DEV_ZERO:
+	case TST_FD_PROC_MAPS:
+	case TST_FD_INOTIFY:
+	case TST_FD_PIPE_READ:
+		exp_errno = EBADF;
+	default:
+	break;
+	}
+
+	if (fd_in->type == TST_FD_PIPE_WRITE)
+		exp_errno = EBADF;
+
+	if (fd_in->type == TST_FD_OPEN_TREE || fd_out->type == TST_FD_OPEN_TREE ||
+	    fd_in->type == TST_FD_PATH || fd_out->type == TST_FD_PATH)
+		exp_errno = EBADF;
+
+	TST_EXP_FAIL2(splice(fd_in->fd, NULL, fd_out->fd, NULL, 1, 0),
+		exp_errno, "splice() on %s -> %s",
+		tst_fd_desc(fd_in), tst_fd_desc(fd_out));
+}
+
+static void verify_splice(void)
+{
+	TST_FD_FOREACH(fd_in) {
+		tst_res(TINFO, "%s -> ...", tst_fd_desc(&fd_in));
+		TST_FD_FOREACH(fd_out)
+			check_splice(&fd_in, &fd_out);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = verify_splice,
+};
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
