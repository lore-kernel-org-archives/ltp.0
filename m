Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21901C43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 08:56:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D4D43E2915
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 10:56:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E33D53E5C65
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 10:54:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E42D4600798
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 10:54:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F03F275DCF;
 Thu,  9 Jul 2026 08:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783587255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xuQb9mwFOsNBTwJzrdMXaYKlgoBLxGcmk9FGohe5pYs=;
 b=hIPfFF8dywvmrGtoa0k1A3FlcxCmG6sf8GiviRoBybH8u/6Y1eakk6s4SsYpN69+yCyLvC
 T3xAqlXBCPiiR1RpT1AJOIHy3WkUnv4dYz7W48Z3YWVn6OJSKlvcQ4Pe+NdNlHc4TSlG0I
 B0kkS/yOzO1rfrnIgV/hHJGGCCCA+gA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783587255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xuQb9mwFOsNBTwJzrdMXaYKlgoBLxGcmk9FGohe5pYs=;
 b=JEnnfaZvJJrmb0S9ym/E+Kq2yTahhKlUw1I7JNL36ARYXfVafME6CXSmC2lnnrpRZlZltf
 v7er6fY3pcsX2FCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783587254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xuQb9mwFOsNBTwJzrdMXaYKlgoBLxGcmk9FGohe5pYs=;
 b=iVcMs8nqRvwGStBKQ94luFK/88SyBnVJoO4fNMijqKJA9HkL54ylL0YqGXHnymSYmVzDtR
 2Trg9QMqNf2a3KYoVZypBlsyNpHoypT8gJw2MmlIMWwg1jVeOMhsCkV8jNaYJ32Kq7UMEB
 kxj28qOUjOdMWB1qxJxTdzm2WyNguTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783587254;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xuQb9mwFOsNBTwJzrdMXaYKlgoBLxGcmk9FGohe5pYs=;
 b=IurYSu98bojPCmQBCLm5Q4QNJ01iYJ8AWsfQN0kT41xMdanQw+j1+xeZ4e4bHA/UiBJNpv
 hHoEjami6bd0QECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC8B5779AA;
 Thu,  9 Jul 2026 08:54:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7/2vNLZhT2ogHgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 09 Jul 2026 08:54:14 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Jul 2026 10:53:50 +0200
Message-ID: <20260709085353.345957-7-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709085353.345957-1-chrubis@suse.cz>
References: <20260709085353.345957-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 6/9] syscalls: Add epoll_wait11
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
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_wait/.gitignore     |  1 +
 .../kernel/syscalls/epoll_wait/epoll_wait11.c | 93 +++++++++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait11.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 08b31c9f5..269fc162a 100644
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
index 000000000..12e158b22
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait11.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Verify that :manpage:epoll_wait() reports EPOLLHUP when the write end of a
+ * pipe is closed while a child process is blocked in epoll_wait.
+ *
+ * [Algorithm]
+ *
+ * - Create a pipe and register the read end with an epoll instance for
+ *   EPOLLIN.
+ * - Fork a child that blocks in epoll_wait on the pipe read end.
+ * - Parent waits for the child to enter sleep state, then closes the write
+ *   end.
+ * - The child's :manpage:epoll_wait() should return with EPOLLHUP.
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
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
