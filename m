Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1647EC44507
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 09:43:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A35513E65C5
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 11:43:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95B653E568E
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 11:42:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 39A631A009AE
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 11:42:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E9AE878324
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784108509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FDLR+wC/FS7ozKZJzJqCFGL1xFr1htf/qB0qwouHIoI=;
 b=h5sL9WkT6PXbPgdcTnDe0ePlGtbXWu+r1QkXsKE0UIUoKdyA+E9CXwZU9xBRXsQGCx2OPr
 HEZkwwD02SkepmGYQxmjD8tYJclGYkyR49GpPSB2mM48L52YK+IvZWoRXZJ/J19no3uJDG
 6KfIZzLJ5v88ozL3R8StA+r0qehaT48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784108509;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FDLR+wC/FS7ozKZJzJqCFGL1xFr1htf/qB0qwouHIoI=;
 b=trEinmLSt9q3ruNPsnM03x4G3SBwmGMigThAVHRYHOyYiRpizDs7CZMzevupCsZmYvGiZI
 Ffz/+C7+wEDPf4Cg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=h5sL9WkT;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=trEinmLS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784108509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FDLR+wC/FS7ozKZJzJqCFGL1xFr1htf/qB0qwouHIoI=;
 b=h5sL9WkT6PXbPgdcTnDe0ePlGtbXWu+r1QkXsKE0UIUoKdyA+E9CXwZU9xBRXsQGCx2OPr
 HEZkwwD02SkepmGYQxmjD8tYJclGYkyR49GpPSB2mM48L52YK+IvZWoRXZJ/J19no3uJDG
 6KfIZzLJ5v88ozL3R8StA+r0qehaT48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784108509;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FDLR+wC/FS7ozKZJzJqCFGL1xFr1htf/qB0qwouHIoI=;
 b=trEinmLSt9q3ruNPsnM03x4G3SBwmGMigThAVHRYHOyYiRpizDs7CZMzevupCsZmYvGiZI
 Ffz/+C7+wEDPf4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA53C779AD
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:41:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kRJSMN1VV2pXKQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:41:49 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 15 Jul 2026 11:41:38 +0200
Message-ID: <20260715094138.1679456-6-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715094138.1679456-1-chrubis@suse.cz>
References: <20260715094138.1679456-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim, suse.cz:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E9AE878324
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] syscalls/epoll_wait15: Add EPOLLEXCLUSIVE test
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

Tests that with EPOLLEXCLUSIVE only single waiter is woken up.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/epoll_wait/.gitignore     |   1 +
 .../kernel/syscalls/epoll_wait/epoll_wait16.c | 115 ++++++++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait16.c

diff --git a/runtest/syscalls b/runtest/syscalls
index af04b430e..f50931f56 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -205,6 +205,7 @@ epoll_wait12 epoll_wait12
 epoll_wait13 epoll_wait13
 epoll_wait14 epoll_wait14
 epoll_wait15 epoll_wait15
+epoll_wait16 epoll_wait16
 
 epoll_pwait01 epoll_pwait01
 epoll_pwait02 epoll_pwait02
diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
index 5ba917bdb..1804efbce 100644
--- a/testcases/kernel/syscalls/epoll_wait/.gitignore
+++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
@@ -13,3 +13,4 @@ epoll_wait12
 epoll_wait13
 epoll_wait14
 epoll_wait15
+epoll_wait16
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait16.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait16.c
new file mode 100644
index 000000000..39d8ea259
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait16.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Verify the EPOLLEXCLUSIVE wakeup semantics of :manpage:`epoll_ctl(2)` and
+ * :manpage:`epoll_wait(2)`.
+ *
+ * When a single target file descriptor is added with EPOLLEXCLUSIVE into
+ * several epoll instances that each have a waiter blocked in
+ * :manpage:`epoll_wait(2)`, one event on the target must wake exactly one
+ * waiter. This is the thundering-herd avoidance introduced in Linux 4.5.
+ *
+ * The test writes into a pipe in a loop and checks that on each write exactly
+ * one child process waiting on the fd is woken up.
+ */
+
+#include <sys/epoll.h>
+#include <sys/mman.h>
+
+#include "tst_test.h"
+#include "tst_epoll.h"
+#include "tst_atomic.h"
+#include "lapi/epoll.h"
+
+#define NWAITERS 8
+
+static int fds[2] = {-1, -1};
+static pid_t pids[NWAITERS];
+static tst_atomic_t *woken;
+
+static void setup(void)
+{
+	woken = SAFE_MMAP(NULL, sizeof(*woken), PROT_READ | PROT_WRITE,
+			  MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
+{
+	if (fds[0] != -1) {
+		SAFE_CLOSE(fds[0]);
+		SAFE_CLOSE(fds[1]);
+	}
+
+	if (woken)
+		SAFE_MUNMAP(woken, sizeof(*woken));
+}
+
+static void child(void)
+{
+	int efd;
+	struct epoll_event ev = {.events = EPOLLIN | EPOLLET | EPOLLEXCLUSIVE};
+
+	efd = SAFE_EPOLL_CREATE1(0);
+	SAFE_EPOLL_CTL(efd, EPOLL_CTL_ADD, fds[0], &ev);
+
+	if (epoll_wait(efd, &ev, 1, 2000) == 1) {
+		tst_atomic_add_return(1, woken);
+		TST_CHECKPOINT_WAKE(0);
+	}
+
+	SAFE_CLOSE(efd);
+	exit(0);
+}
+
+static void run(void)
+{
+	int i, round, nwoken;
+	char c;
+
+	tst_atomic_store(0, woken);
+
+	SAFE_PIPE(fds);
+
+	for (i = 0; i < NWAITERS; i++) {
+		pids[i] = SAFE_FORK();
+		if (!pids[i])
+			child();
+	}
+
+	for (i = 0; i < NWAITERS; i++)
+		TST_PROCESS_STATE_WAIT(pids[i], 'S', 0);
+
+	for (round = 0; round < NWAITERS; round++) {
+		SAFE_WRITE(SAFE_WRITE_ALL, fds[1], "x", 1);
+
+		TST_CHECKPOINT_WAIT(0);
+
+		nwoken = tst_atomic_load(woken);
+		if (nwoken != round+1) {
+			tst_res(TFAIL,
+				"event %d woke %d waiters in total, expected %d",
+				round, nwoken, round);
+			break;
+		}
+
+		SAFE_READ(1, fds[0], &c, 1);
+	}
+
+	if (round == NWAITERS)
+		tst_res(TPASS, "each event woke exactly one waiter");
+
+	SAFE_CLOSE(fds[0]);
+	SAFE_CLOSE(fds[1]);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.min_kver = "4.5",
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
