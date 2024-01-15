Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF14C3DA79
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 12:54:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 019533CE369
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 13:54:50 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C3943CCDE0
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 13:53:26 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 93EAD60084A
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 13:53:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 17D221FD36;
 Mon, 15 Jan 2024 12:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705323205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jMYGoEo+sMvfo1eg8aUY/kv/N44CSJBYuXa/vHZJSMA=;
 b=TWfMI0HtIVA9MIvfOg/JFV+XYy9HdzmO1mbe+dGRyYlkqv8J54JslTPYv9enCYnk/vwFrS
 YV4hIW4PMwGxlvHCkn+8kCEa13AksUvambT5nil6RQNIA25OSHL1YIEDseQnMjGAr7eGpd
 /uhWN6IxgzFUs+iUmHWq3yyt/dvoaAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705323205;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jMYGoEo+sMvfo1eg8aUY/kv/N44CSJBYuXa/vHZJSMA=;
 b=tWIjA+AGSN0sjwcPxOyBsZsqi9bs9Z+dxUeyum9vq51K5QAYdxF4RcB1RstFnFGmYGkFGe
 7xFSFJTOTt77UBAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705323205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jMYGoEo+sMvfo1eg8aUY/kv/N44CSJBYuXa/vHZJSMA=;
 b=TWfMI0HtIVA9MIvfOg/JFV+XYy9HdzmO1mbe+dGRyYlkqv8J54JslTPYv9enCYnk/vwFrS
 YV4hIW4PMwGxlvHCkn+8kCEa13AksUvambT5nil6RQNIA25OSHL1YIEDseQnMjGAr7eGpd
 /uhWN6IxgzFUs+iUmHWq3yyt/dvoaAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705323205;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jMYGoEo+sMvfo1eg8aUY/kv/N44CSJBYuXa/vHZJSMA=;
 b=tWIjA+AGSN0sjwcPxOyBsZsqi9bs9Z+dxUeyum9vq51K5QAYdxF4RcB1RstFnFGmYGkFGe
 7xFSFJTOTt77UBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0BCC13751;
 Mon, 15 Jan 2024 12:53:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i7nAOcQqpWWZVQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 15 Jan 2024 12:53:24 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 15 Jan 2024 13:53:51 +0100
Message-ID: <20240115125351.7266-5-chrubis@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115125351.7266-1-chrubis@suse.cz>
References: <20240115125351.7266-1-chrubis@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[infradead.org,gmail.com,redhat.com,kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,suse.com];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/4] syscalls: splice07: New splice tst_fd iterator
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
 linux-fsdevel@vger.kernel.org, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

We loop over all possible combinations of file descriptors in the test
and filter out combinations that actually make sense and either block or
attempt to copy data.

The rest of invalid options produce either EINVAL or EBADF.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/splice/.gitignore |  1 +
 testcases/kernel/syscalls/splice/splice07.c | 70 +++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 testcases/kernel/syscalls/splice/splice07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 5472c954b..6e2407879 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1516,6 +1516,7 @@ splice03 splice03
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
index 000000000..135c42e47
--- /dev/null
+++ b/testcases/kernel/syscalls/splice/splice07.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2023-2024 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * [Description]
+ *
+ * Iterate over all kinds of file descriptors and feed splice() with all possible
+ * combinations where at least one file descriptor is invalid. We do expect the
+ * syscall to fail either with EINVAL or EBADF.
+ */
+
+#define _GNU_SOURCE
+
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+#include "tst_test.h"
+
+static void check_splice(struct tst_fd *fd_in, struct tst_fd *fd_out)
+{
+	/* These combinations just hang since the pipe is empty */
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
+	const int exp_errnos[] = {EBADF, EINVAL};
+
+	TST_EXP_FAIL2_ARR(splice(fd_in->fd, NULL, fd_out->fd, NULL, 1, 0),
+		exp_errnos, "splice() on %s -> %s",
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
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
