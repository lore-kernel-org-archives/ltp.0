Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B171C44507
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 09:43:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B28F3E5699
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 11:42:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B877B3E78DD
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 11:41:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C49051400BF1
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 11:41:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3D29C78320
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784108508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=39Rp8nYUwwr7gvlJUjUH+r+5b+hhc2VEQzhOD4AtN54=;
 b=VW2w+tyc/M7ROxugnjUDTO+9TZb43K6dyEi2P5IbZWqkdaAredZ97YsyJMlngYiSzhGubk
 x+mSlRh1nSt+4edyHuWgIg33ThMh6+P78zKjTscw7hckcAvx2MnVxGwie0KNh0+vkSw5rD
 ijwZkHKgb1PeH3VWYYlJZIQK2kmA++I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784108508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=39Rp8nYUwwr7gvlJUjUH+r+5b+hhc2VEQzhOD4AtN54=;
 b=8Frdgo+wI8YSQepzGhEbuSvExwsCEczGjUQtEsYvZl/RdSRDrojB2POmiPy2in2ewQadX3
 aXyi8SSi/0uoM2Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784108508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=39Rp8nYUwwr7gvlJUjUH+r+5b+hhc2VEQzhOD4AtN54=;
 b=VW2w+tyc/M7ROxugnjUDTO+9TZb43K6dyEi2P5IbZWqkdaAredZ97YsyJMlngYiSzhGubk
 x+mSlRh1nSt+4edyHuWgIg33ThMh6+P78zKjTscw7hckcAvx2MnVxGwie0KNh0+vkSw5rD
 ijwZkHKgb1PeH3VWYYlJZIQK2kmA++I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784108508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=39Rp8nYUwwr7gvlJUjUH+r+5b+hhc2VEQzhOD4AtN54=;
 b=8Frdgo+wI8YSQepzGhEbuSvExwsCEczGjUQtEsYvZl/RdSRDrojB2POmiPy2in2ewQadX3
 aXyi8SSi/0uoM2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C33F779AD
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:41:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cKsICdxVV2pOKQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:41:48 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 15 Jul 2026 11:41:35 +0200
Message-ID: <20260715094138.1679456-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715094138.1679456-1-chrubis@suse.cz>
References: <20260715094138.1679456-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.76 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.16)[-0.789];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] syscalls: Add epoll_wait13
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

That checks that subsequent calls to epoll() return all events if there
were more events than than the size of the events array passed to epoll.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/epoll_wait/.gitignore     |   1 +
 .../kernel/syscalls/epoll_wait/epoll_wait13.c | 143 ++++++++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 9f46e28de..1cbc13c82 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -202,6 +202,7 @@ epoll_wait09 epoll_wait09
 epoll_wait10 epoll_wait10
 epoll_wait11 epoll_wait11
 epoll_wait12 epoll_wait12
+epoll_wait13 epoll_wait13
 
 epoll_pwait01 epoll_pwait01
 epoll_pwait02 epoll_pwait02
diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
index ad890d077..145e7a0bd 100644
--- a/testcases/kernel/syscalls/epoll_wait/.gitignore
+++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
@@ -10,3 +10,4 @@ epoll_wait09
 epoll_wait10
 epoll_wait11
 epoll_wait12
+epoll_wait13
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait13.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait13.c
new file mode 100644
index 000000000..8a8446baa
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait13.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Verify that :manpage:`epoll_wait(2)` caps the number of reported events at
+ * ``maxevents`` and eventually reports every ready file descriptor while
+ * ignoring the registered descriptors that are not ready.
+ *
+ * When more file descriptors are ready than the ``maxevents`` limit passed to
+ * :manpage:`epoll_wait(2)`, a single call must return at most ``maxevents``
+ * events. The remaining ready descriptors have to be reported by subsequent
+ * calls. Descriptors that are registered but have no data ready must never be
+ * reported, so the test also registers a set of quiet descriptors and checks
+ * that none of them show up in the results.
+ */
+
+#include <sys/epoll.h>
+
+#include "tst_test.h"
+#include "tst_epoll.h"
+#include "tst_minmax.h"
+
+/* NREADY is deliberately not a multiple of MAXEVENTS. */
+#define NREADY 13
+#define NQUIET 5
+#define MAXEVENTS 3
+
+/*
+ * Ready fds are registered with data.u64 in the range [0, NREADY), quiet fds
+ * with data.u64 >= NREADY, so any reported quiet fd is trivially detected.
+ */
+#define QUIET_TAG NREADY
+
+static int epfd = -1;
+static int ready_fds[NREADY][2];
+static int quiet_fds[NQUIET][2];
+static struct epoll_event *events;
+
+static void register_fds(int fds[][2], int n, uint64_t tag)
+{
+	struct epoll_event ev = {.events = EPOLLIN};
+	int i;
+
+	for (i = 0; i < n; i++) {
+		SAFE_PIPE(fds[i]);
+
+		ev.data.u64 = tag + i;
+		SAFE_EPOLL_CTL(epfd, EPOLL_CTL_ADD, fds[i][0], &ev);
+	}
+}
+
+static void close_fds(int fds[][2], int n)
+{
+	int i;
+
+	for (i = 0; i < n; i++) {
+		if (fds[i][0] > 0) {
+			SAFE_CLOSE(fds[i][0]);
+			SAFE_CLOSE(fds[i][1]);
+		}
+	}
+}
+
+static void setup(void)
+{
+	epfd = SAFE_EPOLL_CREATE1(0);
+
+	register_fds(ready_fds, NREADY, 0);
+	register_fds(quiet_fds, NQUIET, QUIET_TAG);
+}
+
+static void cleanup(void)
+{
+	if (epfd != -1)
+		SAFE_CLOSE(epfd);
+
+	close_fds(ready_fds, NREADY);
+	close_fds(quiet_fds, NQUIET);
+}
+
+static void run(void)
+{
+	int seen[NREADY] = {};
+	int total = 0, calls = 0;
+	int i, ret, remaining, exp_events;
+	char c;
+
+	for (i = 0; i < NREADY; i++)
+		SAFE_WRITE(SAFE_WRITE_ALL, ready_fds[i][1], "x", 1);
+
+	while (total < NREADY) {
+		ret = SAFE_EPOLL_WAIT(epfd, events, MAXEVENTS, 0);
+		calls++;
+
+		remaining = NREADY - total;
+		exp_events = MIN(remaining, MAXEVENTS);
+
+		if (ret != exp_events) {
+			tst_res(TFAIL,
+				"epoll_wait() returned %d events, expected %d",
+				ret, exp_events);
+			return;
+		}
+
+		for (i = 0; i < ret; i++) {
+			uint64_t idx = events[i].data.u64;
+
+			if (idx >= NREADY) {
+				tst_res(TFAIL,
+					"epoll_wait() reported quiet fd (tag %llu)",
+					(unsigned long long)idx);
+				return;
+			}
+
+			if (seen[idx]) {
+				tst_res(TFAIL,
+					"epoll_wait() reported ready fd %llu twice",
+					(unsigned long long)idx);
+				return;
+			}
+
+			seen[idx] = 1;
+			total++;
+
+			SAFE_READ(1, ready_fds[idx][0], &c, 1);
+		}
+	}
+
+	tst_res(TPASS, "epoll_wait() reported all %d ready fds in %d calls",
+		NREADY, calls);
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
