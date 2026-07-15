Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75603C44508
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 12:38:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B36BA3E5686
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 14:37:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD8E03E9339
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 14:36:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 352A7600909
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 14:36:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EB81F3E2A
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 12:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784118982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ainTnMHY6cdirzjFxlrnWJV8l4SOGYcmYty1WsHesFc=;
 b=oAJjlXAhVHV1PWkJiF4FxbCXdcA96bd6q4rbtzfsr5vrWWhfwVilb0EPp/Ob4srToinSMA
 2TpQRNuJynGWAL1vL/RQr4M1qLPxgvT20im/biyICZrion0zsmCPxH8d5prUw446d03Uo7
 302K8X6mJvS8Fy64GmVTzl6iJ5+LCj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784118982;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ainTnMHY6cdirzjFxlrnWJV8l4SOGYcmYty1WsHesFc=;
 b=QNQKiKaRbYwuKIM3FUydMg7/F2lfpNBFSgHs8yzc8sXMq56ljWfPMP2zxi8NDCU3GMDA0m
 Q8VPU30QRavlehCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784118981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ainTnMHY6cdirzjFxlrnWJV8l4SOGYcmYty1WsHesFc=;
 b=cdNqkkjxReBW520AOG6lM6SSh72iJKR2AjHsgwmWwjrMlg4bBIgms1gfJena2nLzpX+nTA
 aK8KqTFcRE6VqIGXrSt24zJZKxcAe7q8h99O3fdB6n+Jpkm+m3/eRl3e8nxEIakA3O2Btd
 pj+kXu3gNhTRsTXNWNybzjUX5JMCKJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784118981;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ainTnMHY6cdirzjFxlrnWJV8l4SOGYcmYty1WsHesFc=;
 b=5YYnTR0DOEhmw1VIA+84tZSlISxu+667ZCQ2B95ZU/dbqyXNV5sto+AFwD9Lhk/lZJLRhX
 DhKi6xNt/I6jCgAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8B21779AD
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 12:36:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uIBOM8V+V2rpWwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 12:36:21 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 15 Jul 2026 14:36:10 +0200
Message-ID: <20260715123612.1684984-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715123612.1684984-1-chrubis@suse.cz>
References: <20260715123612.1684984-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/5] syscalls: Add epoll_wait14
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
the fds so they are never removed from the ready set. We loop over the
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
