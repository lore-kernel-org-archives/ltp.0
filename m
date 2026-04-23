Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA7EF9937D
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 12:04:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9C623DDAD6
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 14:04:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 949113E539B
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 14:03:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 08FCB2009EF
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 14:03:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5F1015BD76
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 12:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776945787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMcukR5qNnWXSiXNd+moiBK4NFsVEMxZOiEjAy6Xea0=;
 b=gF+Som3vQTb2DD+11Z2ZGXCqdNe00u87PWsWNaUzKHxEtJVWowe5Rm1yADKU3UnnO7pXdE
 OcydF7Ftrljfd0lkYgrObqV8wUwflFL9X2n+/f6usWzYj5+RscvGo0QEGGIXKHwpcOTQP/
 NIVjDURtdGCVXGTi17G4bFWTZnWzwDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776945787;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMcukR5qNnWXSiXNd+moiBK4NFsVEMxZOiEjAy6Xea0=;
 b=1XtNUs4bWFQEz2qD36ul3nC5qYe1xCnLTGGQrSLaQMUUQgn2aszPCrtP832uYyov9QWbMB
 XGTTWXpH7S8+JSAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776945787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMcukR5qNnWXSiXNd+moiBK4NFsVEMxZOiEjAy6Xea0=;
 b=gF+Som3vQTb2DD+11Z2ZGXCqdNe00u87PWsWNaUzKHxEtJVWowe5Rm1yADKU3UnnO7pXdE
 OcydF7Ftrljfd0lkYgrObqV8wUwflFL9X2n+/f6usWzYj5+RscvGo0QEGGIXKHwpcOTQP/
 NIVjDURtdGCVXGTi17G4bFWTZnWzwDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776945787;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMcukR5qNnWXSiXNd+moiBK4NFsVEMxZOiEjAy6Xea0=;
 b=1XtNUs4bWFQEz2qD36ul3nC5qYe1xCnLTGGQrSLaQMUUQgn2aszPCrtP832uYyov9QWbMB
 XGTTWXpH7S8+JSAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D445593B3
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 12:03:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id luLtEXsK6mnDUQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 12:03:07 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 23 Apr 2026 14:03:07 +0200
Message-ID: <20260423120309.18049-7-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423120309.18049-1-chrubis@suse.cz>
References: <20260423120309.18049-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ev.events:url,suse.cz:mid,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/8] syscalls: Add epoll_wait11
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

A test that checks that EPOLLHUP is generated properly when a pipe is
closed while epoll_wait() waits on the read end of a pipe.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_wait/.gitignore     |  1 +
 .../kernel/syscalls/epoll_wait/epoll_wait11.c | 94 +++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait11.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 3fd61b814..c16cf3554 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -199,6 +199,7 @@ epoll_wait07 epoll_wait07
 epoll_wait08 epoll_wait08
 epoll_wait09 epoll_wait09
 epoll_wait10 epoll_wait10
+epoll_wait11 epoll_wait11
 
 epoll_pwait01 epoll_pwait01
 epoll_pwait02 epoll_pwait02
diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
index 30139375d..57bdf0806 100644
--- a/testcases/kernel/syscalls/epoll_wait/.gitignore
+++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
@@ -8,3 +8,4 @@ epoll_wait07
 epoll_wait08
 epoll_wait09
 epoll_wait10
+epoll_wait11
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait11.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait11.c
new file mode 100644
index 000000000..764fe5f61
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait11.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Verify that epoll_wait reports EPOLLHUP when the write end of a pipe is
+ * closed while a child process is blocked in epoll_wait.
+ *
+ * [Algorithm]
+ *
+ * - Create a pipe and register the read end with an epoll instance for
+ *   EPOLLIN.
+ * - Fork a child that blocks in epoll_wait on the pipe read end.
+ * - Parent waits for the child to enter sleep state, then closes the write
+ *   end.
+ * - The child's epoll_wait should return with EPOLLHUP and the child reports
+ *   the result via its exit code.
+ */
+
+#include <sys/epoll.h>
+
+#include "tst_test.h"
+#include "tst_epoll.h"
+
+static int efd = -1, fds[2] = {-1, -1};
+
+static void run(void)
+{
+	pid_t pid;
+
+	SAFE_PIPE(fds);
+
+	efd = SAFE_EPOLL_CREATE1(0);
+
+	struct epoll_event ev = {
+		.events = EPOLLIN,
+		.data.fd = fds[0],
+	};
+
+	SAFE_EPOLL_CTL(efd, EPOLL_CTL_ADD, fds[0], &ev);
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		SAFE_CLOSE(fds[1]);
+
+		TEST(epoll_wait(efd, &ev, 1, 5000));
+		if (TST_RET != 1) {
+			tst_res(TFAIL | TTERRNO,
+				"epoll_wait() returned %li, expected 1",
+				TST_RET);
+			exit(0);
+		}
+
+		if (ev.data.fd != fds[0]) {
+			tst_res(TFAIL, "epoll.data.fd %d, expected %d",
+				ev.data.fd, fds[0]);
+			exit(0);
+		}
+
+		if (!(ev.events & EPOLLHUP)) {
+			tst_res(TFAIL, "events %x, EPOLLHUP not set",
+				ev.events);
+			exit(0);
+		}
+
+		tst_res(TPASS,
+			"epoll_wait() reported EPOLLHUP on pipe hangup");
+		exit(0);
+	}
+
+	TST_PROCESS_STATE_WAIT(pid, 'S', 0);
+	SAFE_CLOSE(fds[1]);
+	SAFE_CLOSE(fds[0]);
+	SAFE_CLOSE(efd);
+}
+
+static void cleanup(void)
+{
+	if (fds[1] != -1)
+		SAFE_CLOSE(fds[1]);
+
+	if (fds[0] != -1)
+		SAFE_CLOSE(fds[0]);
+
+	if (efd != -1)
+		SAFE_CLOSE(efd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.cleanup = cleanup,
+	.forks_child = 1,
+};
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
