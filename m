Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37715F99344
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 10:00:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFD883E5391
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 12:00:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 672F83E5397
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 11:58:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D4CF5600057
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 11:58:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4BD365BD11
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 09:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776938301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJW+Eiwub+PdlQZSR9BD/f7jTWul0IlWkLwsRBGoSzU=;
 b=jeLFO+IpCkVoP7RxDPVJW/Zir0wGIH1zmQM5VKAee9IOe8D8PvLixrD4dCcrZ95Y8i3Fwv
 MlrpG6s5+HSD8xd3NQ9ki/bc5G+vyxNf1JNLceWHPmXkc+YZ52K0QBwZ6X+bHx8Ji1qXnC
 tyrQn02YThx3b4wZ2pKwQJnmb5jKslE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776938301;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJW+Eiwub+PdlQZSR9BD/f7jTWul0IlWkLwsRBGoSzU=;
 b=UnVBP4OIEy+zJ1Am09+z64OEBEwWQAqMmBkKFavjullI4aLV6CsjChO33M14TVFopKNbbk
 52vwabh+AHIm0UAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jeLFO+Ip;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UnVBP4OI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776938301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJW+Eiwub+PdlQZSR9BD/f7jTWul0IlWkLwsRBGoSzU=;
 b=jeLFO+IpCkVoP7RxDPVJW/Zir0wGIH1zmQM5VKAee9IOe8D8PvLixrD4dCcrZ95Y8i3Fwv
 MlrpG6s5+HSD8xd3NQ9ki/bc5G+vyxNf1JNLceWHPmXkc+YZ52K0QBwZ6X+bHx8Ji1qXnC
 tyrQn02YThx3b4wZ2pKwQJnmb5jKslE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776938301;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJW+Eiwub+PdlQZSR9BD/f7jTWul0IlWkLwsRBGoSzU=;
 b=UnVBP4OIEy+zJ1Am09+z64OEBEwWQAqMmBkKFavjullI4aLV6CsjChO33M14TVFopKNbbk
 52vwabh+AHIm0UAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38E92593A3
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 09:58:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fu38DD3t6Wl4UAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 09:58:21 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 23 Apr 2026 11:58:33 +0200
Message-ID: <20260423095834.11932-8-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423095834.11932-1-chrubis@suse.cz>
References: <20260423095834.11932-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:mid, suse.cz:dkim, suse.cz:email,
 ev.events:url]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4BD365BD11
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 7/8] syscalls: Add epoll_wait12
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

A test for EPOLLERR when we are waiting to write into a pipe and the
read end is closed.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/epoll_wait/.gitignore     |   1 +
 .../kernel/syscalls/epoll_wait/epoll_wait12.c | 112 ++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait12.c

diff --git a/runtest/syscalls b/runtest/syscalls
index d286ab7ff..0200a9e13 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -199,6 +199,7 @@ epoll_wait07 epoll_wait07
 epoll_wait09 epoll_wait09
 epoll_wait10 epoll_wait10
 epoll_wait11 epoll_wait11
+epoll_wait12 epoll_wait12
 
 epoll_pwait01 epoll_pwait01
 epoll_pwait02 epoll_pwait02
diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
index 57bdf0806..ad890d077 100644
--- a/testcases/kernel/syscalls/epoll_wait/.gitignore
+++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
@@ -9,3 +9,4 @@ epoll_wait08
 epoll_wait09
 epoll_wait10
 epoll_wait11
+epoll_wait12
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait12.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait12.c
new file mode 100644
index 000000000..facbf60c2
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait12.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2026
+ */
+
+/*\
+ * Verify that epoll_wait reports EPOLLERR when the read end of a pipe is
+ * closed while a child process is blocked in epoll_wait on the write end.
+ *
+ * [Algorithm]
+ *
+ * - Create a pipe and fill it completely so the write end is not writable.
+ * - Register the write end with an epoll instance for EPOLLOUT.
+ * - Fork a child that closes its copy of the read end and blocks in
+ *   epoll_wait waiting for the pipe to become writable.
+ * - Parent waits for the child to enter sleep state, then closes the read
+ *   end.
+ * - The child's epoll_wait should return with EPOLLERR set.
+ */
+
+#include <sys/epoll.h>
+#include <poll.h>
+
+#include "tst_test.h"
+#include "tst_epoll.h"
+
+static int efd = -1, fds[2] = {-1, -1};
+
+static void fill_pipe(int fd)
+{
+	char buf[4096];
+	struct pollfd pfd = {.fd = fd, .events = POLLOUT};
+	int nfd;
+
+	memset(buf, 'a', sizeof(buf));
+
+	do {
+		SAFE_WRITE(SAFE_WRITE_ANY, fd, buf, sizeof(buf));
+		nfd = poll(&pfd, 1, 0);
+		if (nfd == -1)
+			tst_brk(TBROK | TERRNO, "poll()");
+	} while (nfd > 0);
+}
+
+static void run(void)
+{
+	pid_t pid;
+
+	SAFE_PIPE(fds);
+	fill_pipe(fds[1]);
+
+	efd = SAFE_EPOLL_CREATE1(0);
+
+	struct epoll_event ev = {
+		.events = EPOLLOUT,
+		.data.fd = fds[1],
+	};
+
+	SAFE_EPOLL_CTL(efd, EPOLL_CTL_ADD, fds[1], &ev);
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		SAFE_CLOSE(fds[0]);
+
+		TEST(epoll_wait(efd, &ev, 1, 5000));
+		if (TST_RET != 1) {
+			tst_res(TFAIL | TTERRNO,
+				"epoll_wait() returned %li, expected 1",
+				TST_RET);
+			exit(0);
+		}
+
+		if (ev.data.fd != fds[1]) {
+			tst_res(TFAIL, "epoll.data.fd %d, expected %d",
+				ev.data.fd, fds[1]);
+			exit(0);
+		}
+
+		if (!(ev.events & EPOLLERR)) {
+			tst_res(TFAIL, "events %x, EPOLLERR not set",
+				ev.events);
+			exit(0);
+		}
+
+		tst_res(TPASS,
+			"epoll_wait() reported EPOLLERR on broken pipe");
+		exit(0);
+	}
+
+	TST_PROCESS_STATE_WAIT(pid, 'S', 0);
+	SAFE_CLOSE(fds[0]);
+	SAFE_CLOSE(fds[1]);
+	SAFE_CLOSE(efd);
+}
+
+static void cleanup(void)
+{
+	if (fds[1] > 0)
+		SAFE_CLOSE(fds[1]);
+
+	if (fds[0] > 0)
+		SAFE_CLOSE(fds[0]);
+
+	if (efd > 0)
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
