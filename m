Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094E8C43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 08:55:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80D993E2E13
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 10:55:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A99273E292B
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 10:54:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8B39A2002B2
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 10:54:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9FDCE7607B;
 Thu,  9 Jul 2026 08:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783587250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4i0zruegXUpqiQW9q52UzRuPgleZ4jZSj0RGUz/oqig=;
 b=CAxngcGbM5Hkp+1y0nhAyI5WMHfDdvifzmzcTf0/TxHAaFpHRorC8bZVI8pLSMk7A4omq2
 UD6OX5x0q1KCquDvdApf4xFGa5RDZF7rgU0xbR4b52u9UylkRnqiOXv0mw6txAcORBXIpw
 tX60fRBb4MVKRVDjU3nLQwRQb9aS+AA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783587250;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4i0zruegXUpqiQW9q52UzRuPgleZ4jZSj0RGUz/oqig=;
 b=WWs7RgInWdICodwIQ1bscUFhMN4sLRZaTvZdFN+4BFAM5nf48cQZGVVEGxK4pNJJw2F/fm
 s6cw7UhQ967GfmAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783587249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4i0zruegXUpqiQW9q52UzRuPgleZ4jZSj0RGUz/oqig=;
 b=ZEakACSffUg9H1/+vyDMxlkgIRU78WTfVQzvutRdpe7Pypvwgrf6sZ8w0hUEnt9fx4twF2
 vyMLT5RQVveCooW6aiZtiI/R02X6UI7DO5wN3qDgpKdbBWoFN0lDlfbVsMiabblksvHgdr
 Fu4fnqYg0J3RMyFYKHzwdKosg4k1lzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783587249;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4i0zruegXUpqiQW9q52UzRuPgleZ4jZSj0RGUz/oqig=;
 b=An7VOgb0nbbfTjpvcAdz0lCOB9sJMHAlHlmh4TVsa0TQD3rlhCyvP/Og5P1txBxHh9cxbO
 3lIf8dY+C9XQ88AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B350779B4;
 Thu,  9 Jul 2026 08:54:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ri/KILFhT2oSHgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 09 Jul 2026 08:54:09 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Jul 2026 10:53:47 +0200
Message-ID: <20260709085353.345957-4-chrubis@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/9] syscalls: Add epoll_wait09
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

Test checks that events from recursive epoll are propagated correctly.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/epoll_wait/.gitignore     |   1 +
 .../kernel/syscalls/epoll_wait/epoll_wait09.c | 132 ++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait09.c

diff --git a/runtest/syscalls b/runtest/syscalls
index debe64ff9..727156950 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -196,6 +196,7 @@ epoll_wait05 epoll_wait05
 epoll_wait06 epoll_wait06
 epoll_wait07 epoll_wait07
 epoll_wait08 epoll_wait08
+epoll_wait09 epoll_wait09
 
 epoll_pwait01 epoll_pwait01
 epoll_pwait02 epoll_pwait02
diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
index f3b208950..f32ec535b 100644
--- a/testcases/kernel/syscalls/epoll_wait/.gitignore
+++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
@@ -6,3 +6,4 @@ epoll_wait05
 epoll_wait06
 epoll_wait07
 epoll_wait08
+epoll_wait09
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait09.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait09.c
new file mode 100644
index 000000000..b39fa46e6
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait09.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Verify that :manpage:epoll_wait() works with nested epoll instances up to
+ * the maximum nesting depth of 5 allowed by the kernel (EP_MAX_NESTS).
+ *
+ * [Algorithm]
+ *
+ * - Create a pipe.
+ * - Build a chain of epoll instances of the given depth where the innermost
+ *   monitors the pipe read end and each subsequent one monitors the previous.
+ * - Write data to the pipe.
+ * - Call :manpage:epoll_wait() on the outermost epoll instance and verify it
+ *   reports EPOLLIN.
+ * - Walk the chain inward calling epoll_wait on each level and verify that
+ *   every level reports EPOLLIN on the expected fd.
+ * - Read the data from the pipe to drain it.
+ */
+
+#include <sys/epoll.h>
+
+#include "tst_epoll.h"
+#include "tst_test.h"
+
+#define MAX_DEPTH 5
+
+static int epfds[MAX_DEPTH];
+static int fds[2] = {-1, -1};
+
+static struct tcase {
+	int depth;
+} tcases[] = {
+	{2},
+	{3},
+	{4},
+	{5},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	struct epoll_event ev;
+	int prev_fd, i;
+	char buf;
+
+	prev_fd = fds[0];
+
+	for (i = 0; i < tc->depth; i++) {
+		epfds[i] = SAFE_EPOLL_CREATE1(0);
+
+		ev.events = EPOLLIN;
+		ev.data.fd = prev_fd;
+
+		SAFE_EPOLL_CTL(epfds[i], EPOLL_CTL_ADD, prev_fd, &ev);
+
+		prev_fd = epfds[i];
+	}
+
+	SAFE_WRITE(SAFE_WRITE_ALL, fds[1], "x", 1);
+
+	/* Walk from outermost to innermost verifying each level */
+	for (i = tc->depth - 1; i >= 0; i--) {
+		int expected_fd = (i > 0) ? epfds[i - 1] : fds[0];
+
+		TEST(epoll_wait(epfds[i], &ev, 1, 1000));
+		if (TST_RET != 1) {
+			tst_res(TFAIL | TTERRNO,
+				"depth %d/%d: epoll_wait() returned %li, expected 1",
+				tc->depth - i, tc->depth, TST_RET);
+			goto end;
+		}
+
+		if (ev.data.fd != expected_fd) {
+			tst_res(TFAIL,
+				"depth %d/%d: data.fd %d, expected %d",
+				tc->depth - i, tc->depth,
+				ev.data.fd, expected_fd);
+			goto end;
+		}
+
+		if (!(ev.events & EPOLLIN)) {
+			tst_res(TFAIL,
+				"depth %d/%d: events %x, expected EPOLLIN",
+				tc->depth - i, tc->depth, ev.events);
+			goto end;
+		}
+	}
+
+	tst_res(TPASS, "epoll_wait() with %d nested levels", tc->depth);
+
+end:
+	SAFE_READ(1, fds[0], &buf, 1);
+
+	for (i = tc->depth - 1; i >= 0; i--) {
+		if (epfds[i] != -1)
+			SAFE_CLOSE(epfds[i]);
+	}
+
+}
+
+static void setup(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_DEPTH; i++)
+		epfds[i] = -1;
+
+	SAFE_PIPE(fds);
+}
+
+static void cleanup(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_DEPTH; i++) {
+		if (epfds[i] != -1)
+			SAFE_CLOSE(epfds[i]);
+	}
+
+	SAFE_CLOSE(fds[0]);
+	SAFE_CLOSE(fds[1]);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+};
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
