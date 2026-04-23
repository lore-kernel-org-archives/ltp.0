Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA81F99344
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 09:59:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D1273E5385
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 11:59:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01EC83E538E
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 11:58:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 78C892009EF
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 11:58:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 219535BCFF
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776938300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VHdOjJ8UMZCIdvtjpZC/4aKtLIwjGTbIp1Yzzq0CDrA=;
 b=3MFCp9yK415OELcQMAgdF/h0U3B7wEQAdDtvDOnP/ToLgMy8WAkcecc6vJPk8ABps26ysz
 bzxIVeb3PA2EhTr4KZIexo9o8bTSGGbWp+l/KVwdeCnVZTwrePZqMkUO+f7iR4zB+6DwpE
 RpG+u5h5/VeF7DVmjz8PljYTL+A2s60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776938300;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VHdOjJ8UMZCIdvtjpZC/4aKtLIwjGTbIp1Yzzq0CDrA=;
 b=HJM/PiU4JF3pL9ExuYuU68wDqMW6qKpUysoaxWi/TGT7re4jmB7kPytc7tJ8zJZEyfXXhD
 qJDpNpJX8EEGfpAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776938300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VHdOjJ8UMZCIdvtjpZC/4aKtLIwjGTbIp1Yzzq0CDrA=;
 b=3MFCp9yK415OELcQMAgdF/h0U3B7wEQAdDtvDOnP/ToLgMy8WAkcecc6vJPk8ABps26ysz
 bzxIVeb3PA2EhTr4KZIexo9o8bTSGGbWp+l/KVwdeCnVZTwrePZqMkUO+f7iR4zB+6DwpE
 RpG+u5h5/VeF7DVmjz8PljYTL+A2s60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776938300;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VHdOjJ8UMZCIdvtjpZC/4aKtLIwjGTbIp1Yzzq0CDrA=;
 b=HJM/PiU4JF3pL9ExuYuU68wDqMW6qKpUysoaxWi/TGT7re4jmB7kPytc7tJ8zJZEyfXXhD
 qJDpNpJX8EEGfpAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 124C8593B0
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 09:58:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sPKVAzzt6WlwUAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 09:58:20 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 23 Apr 2026 11:58:30 +0200
Message-ID: <20260423095834.11932-5-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423095834.11932-1-chrubis@suse.cz>
References: <20260423095834.11932-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/8] syscalls: Add epoll_ctl06
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

Test that iterates over different types of file descriptors, attempts to
add them to epoll and expects either success or a failure based on the
type of the file descriptor.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_ctl/.gitignore      |  1 +
 .../kernel/syscalls/epoll_ctl/epoll_ctl06.c   | 71 +++++++++++++++++++
 3 files changed, 73 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index cf4352d05..148a4dd0e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -187,6 +187,7 @@ epoll_ctl02 epoll_ctl02
 epoll_ctl03 epoll_ctl03
 epoll_ctl04 epoll_ctl04
 epoll_ctl05 epoll_ctl05
+epoll_ctl06 epoll_ctl06
 
 epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
diff --git a/testcases/kernel/syscalls/epoll_ctl/.gitignore b/testcases/kernel/syscalls/epoll_ctl/.gitignore
index 3e05f2e1f..9c555f41b 100644
--- a/testcases/kernel/syscalls/epoll_ctl/.gitignore
+++ b/testcases/kernel/syscalls/epoll_ctl/.gitignore
@@ -3,3 +3,4 @@ epoll_ctl02
 epoll_ctl03
 epoll_ctl04
 epoll_ctl05
+epoll_ctl06
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c
new file mode 100644
index 000000000..b2bfce252
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Verify epoll_ctl EPOLL_CTL_ADD behavior across all file descriptor types.
+ *
+ * The test iterates over all available fd types via TST_FD_FOREACH and
+ * attempts EPOLL_CTL_ADD on each. File descriptor types that implement the
+ * poll file operation are expected to succeed. The rest must fail with:
+ *
+ * - EPERM for fds that are valid but lack poll support (regular files,
+ *   directories, /dev/zero, /proc files, memfd).
+ * - EBADF for fds that are not usable for I/O (O_PATH, open_tree).
+ */
+
+#include <sys/epoll.h>
+
+#include "tst_test.h"
+#include "tst_epoll.h"
+#include "tst_fd.h"
+
+static int exp_errno(enum tst_fd_type type)
+{
+	switch (type) {
+	case TST_FD_FILE:
+	case TST_FD_DIR:
+	case TST_FD_DEV_ZERO:
+	case TST_FD_PROC_MAPS:
+	case TST_FD_MEMFD:
+	case TST_FD_MEMFD_SECRET:
+		return EPERM;
+	case TST_FD_PATH:
+	case TST_FD_OPEN_TREE:
+	case TST_FD_FSOPEN:
+	case TST_FD_FSPICK:
+		return EBADF;
+	default:
+		return 0;
+	}
+}
+
+static void run(void)
+{
+	int efd, err;
+	struct epoll_event ev = {.events = EPOLLIN};
+
+	TST_FD_FOREACH(fd) {
+		efd = SAFE_EPOLL_CREATE1(0);
+		ev.data.fd = fd.fd;
+		err = exp_errno(fd.type);
+
+		if (err) {
+			TST_EXP_FAIL(epoll_ctl(efd, EPOLL_CTL_ADD,
+				     fd.fd, &ev), err,
+				     "epoll_ctl() on %s", tst_fd_desc(&fd));
+		} else {
+			TST_EXP_PASS(epoll_ctl(efd, EPOLL_CTL_ADD,
+				     fd.fd, &ev),
+				     "epoll_ctl() on %s", tst_fd_desc(&fd));
+		}
+
+		SAFE_CLOSE(efd);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_tmpdir = 1,
+};
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
