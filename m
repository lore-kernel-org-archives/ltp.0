Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49EAC44507
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 09:42:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FC553E9336
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 11:42:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56A5D3E568E
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 11:41:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CB97D1A009A7
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 11:41:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E32583DFA
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784108508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6bwr5fAJGDt5bFdOki2DcqcANV/dlLGbsyUQ9YeHQiQ=;
 b=nydnQsNOKafxHP4v2g3NZliWMx9mBytK1zcLJHW1fARF0z5Ih2hy6h8h/1PRL+NQ0V7Lff
 dUL93Ppo4p53jlIZ/fFFdOIqg+tkaQrk4kw2GHUhoZ4L+Ol2HET7A1qWh0aDUGEwDmgNew
 c/Wx9N9G24CP6z5pF8yor5xceZ6rYNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784108508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6bwr5fAJGDt5bFdOki2DcqcANV/dlLGbsyUQ9YeHQiQ=;
 b=mNsz8C3czsqofr9260SEVmzBzCj9pBcLEEeKTdDoGuPQshMR0odNSDGeEaHuSyO3FeW9lu
 cQfULY4AwLYQqLDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nydnQsNO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mNsz8C3c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784108508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6bwr5fAJGDt5bFdOki2DcqcANV/dlLGbsyUQ9YeHQiQ=;
 b=nydnQsNOKafxHP4v2g3NZliWMx9mBytK1zcLJHW1fARF0z5Ih2hy6h8h/1PRL+NQ0V7Lff
 dUL93Ppo4p53jlIZ/fFFdOIqg+tkaQrk4kw2GHUhoZ4L+Ol2HET7A1qWh0aDUGEwDmgNew
 c/Wx9N9G24CP6z5pF8yor5xceZ6rYNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784108508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6bwr5fAJGDt5bFdOki2DcqcANV/dlLGbsyUQ9YeHQiQ=;
 b=mNsz8C3czsqofr9260SEVmzBzCj9pBcLEEeKTdDoGuPQshMR0odNSDGeEaHuSyO3FeW9lu
 cQfULY4AwLYQqLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6BE3779AD
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:41:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MQ5OK9xVV2pRKQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:41:48 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 15 Jul 2026 11:41:36 +0200
Message-ID: <20260715094138.1679456-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715094138.1679456-1-chrubis@suse.cz>
References: <20260715094138.1679456-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E32583DFA
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:dkim, suse.cz:email, suse.cz:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] syscalls: Add epoll_wait14
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

This is another test for maxevents cap, but in this case we do not drain
the fds so they are newer removed from the ready set. We loop over the
epoll_wait() and make sure that the fds are reported round robin i.e. no
fd is starved.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/epoll_wait/.gitignore     |   1 +
 .../kernel/syscalls/epoll_wait/epoll_wait14.c | 114 ++++++++++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait14.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 1cbc13c82..7c7e4b6f6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -203,6 +203,7 @@ epoll_wait10 epoll_wait10
 epoll_wait11 epoll_wait11
 epoll_wait12 epoll_wait12
 epoll_wait13 epoll_wait13
+epoll_wait14 epoll_wait14
 
 epoll_pwait01 epoll_pwait01
 epoll_pwait02 epoll_pwait02
diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
index 145e7a0bd..fadaf4faa 100644
--- a/testcases/kernel/syscalls/epoll_wait/.gitignore
+++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
@@ -11,3 +11,4 @@ epoll_wait10
 epoll_wait11
 epoll_wait12
 epoll_wait13
+epoll_wait14
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait14.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait14.c
new file mode 100644
index 000000000..192db87b5
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait14.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Verify that :manpage:`epoll_wait(2)` rotates its ready list fairly.
+ *
+ * When more file descriptors are ready than the ``maxevents`` limit and the
+ * descriptors are kept ready (never drained), the kernel has to rotate the
+ * ready list so that all of them are reported in a round-robin fashion. Over
+ * several full rotations every descriptor must therefore be reported the same
+ * number of times, none may be starved and none may be favoured.
+ */
+
+#include <sys/epoll.h>
+
+#include "tst_test.h"
+#include "tst_epoll.h"
+
+/* NREADY is deliberately not a multiple of MAXEVENTS. */
+#define NREADY 13
+#define MAXEVENTS 3
+#define ROUNDS 4
+
+static int epfd = -1;
+static int ready_fds[NREADY][2];
+static struct epoll_event *events;
+
+static void setup(void)
+{
+	struct epoll_event ev = {.events = EPOLLIN};
+	int i;
+
+	epfd = SAFE_EPOLL_CREATE1(0);
+
+	for (i = 0; i < NREADY; i++) {
+		SAFE_PIPE(ready_fds[i]);
+		SAFE_WRITE(SAFE_WRITE_ALL, ready_fds[i][1], "x", 1);
+
+		ev.data.u64 = i;
+		SAFE_EPOLL_CTL(epfd, EPOLL_CTL_ADD, ready_fds[i][0], &ev);
+	}
+}
+
+static void cleanup(void)
+{
+	int i;
+
+	if (epfd != -1)
+		SAFE_CLOSE(epfd);
+
+	for (i = 0; i < NREADY; i++) {
+		if (ready_fds[i][0] > 0) {
+			SAFE_CLOSE(ready_fds[i][0]);
+			SAFE_CLOSE(ready_fds[i][1]);
+		}
+	}
+}
+
+static void run(void)
+{
+	int count[NREADY] = {};
+	int collected = 0, target = ROUNDS * NREADY;
+	int i, ret;
+
+	while (collected < target) {
+		ret = SAFE_EPOLL_WAIT(epfd, events, MAXEVENTS, 0);
+
+		if (ret != MAXEVENTS) {
+			tst_res(TFAIL,
+				"epoll_wait() returned %d events, expected %d",
+				ret, MAXEVENTS);
+			return;
+		}
+
+		for (i = 0; i < ret && collected < target; i++) {
+			uint64_t idx = events[i].data.u64;
+
+			if (idx >= NREADY) {
+				tst_res(TFAIL,
+					"epoll_wait() returned bogus index %llu",
+					(unsigned long long)idx);
+				return;
+			}
+
+			count[idx]++;
+			collected++;
+		}
+	}
+
+	for (i = 0; i < NREADY; i++) {
+		if (count[i] != ROUNDS) {
+			tst_res(TFAIL,
+				"fd %d reported %d times, expected %d",
+				i, count[i], ROUNDS);
+			return;
+		}
+	}
+
+	tst_res(TPASS,
+		"epoll_wait() reported each of %d fds exactly %d times",
+		NREADY, ROUNDS);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.bufs = (struct tst_buffers []) {
+		{&events, .size = MAXEVENTS * sizeof(struct epoll_event)},
+		{},
+	},
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
