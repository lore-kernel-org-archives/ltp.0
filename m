Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD339C44508
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 12:37:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34CA73E9672
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 14:37:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 766083E1D74
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 14:36:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8A9C01A004B3
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 14:36:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 367F7764AC
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 12:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784118981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kpdm4v6wf7H7xAzWRALGzwx1+T8ki4C6+D8GDwLAuEE=;
 b=K2El2SCeP9lE2P3ApztJwVfuqwW6/I+X0ffjNQ3J8/j42rl03/YJSpkB6QR8AOhFevK2y1
 ukirV5nmkoyf0SFa4a1273wNvzGOMduyT6A81JIGkmkBqlGJ346SpZdBg0Zl1LPDEjHXnS
 q7rNq6+veueKD1a7mfNTtsiz1aAxJ4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784118981;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kpdm4v6wf7H7xAzWRALGzwx1+T8ki4C6+D8GDwLAuEE=;
 b=NDW69auphH3wLnz0vbWPrjdemmDeybREPuFMu3/7fZvClc1hDfj4f+KmcuiP27UN2oPJDl
 KnUzK+QOPyddFDDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784118981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kpdm4v6wf7H7xAzWRALGzwx1+T8ki4C6+D8GDwLAuEE=;
 b=K2El2SCeP9lE2P3ApztJwVfuqwW6/I+X0ffjNQ3J8/j42rl03/YJSpkB6QR8AOhFevK2y1
 ukirV5nmkoyf0SFa4a1273wNvzGOMduyT6A81JIGkmkBqlGJ346SpZdBg0Zl1LPDEjHXnS
 q7rNq6+veueKD1a7mfNTtsiz1aAxJ4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784118981;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kpdm4v6wf7H7xAzWRALGzwx1+T8ki4C6+D8GDwLAuEE=;
 b=NDW69auphH3wLnz0vbWPrjdemmDeybREPuFMu3/7fZvClc1hDfj4f+KmcuiP27UN2oPJDl
 KnUzK+QOPyddFDDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20DD3779AE
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 12:36:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QVUqB8V+V2rjWwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 12:36:21 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 15 Jul 2026 14:36:08 +0200
Message-ID: <20260715123612.1684984-2-chrubis@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/5] syscalls: Add epoll_ctl07
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

The epoll_ctl05 exercies the loop detector with a longer chain this
test does the same but only with two epoll fds.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_ctl/.gitignore      |  1 +
 .../kernel/syscalls/epoll_ctl/epoll_ctl07.c   | 60 +++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_ctl/epoll_ctl07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 789d1550d..9f46e28de 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -188,6 +188,7 @@ epoll_ctl03 epoll_ctl03
 epoll_ctl04 epoll_ctl04
 epoll_ctl05 epoll_ctl05
 epoll_ctl06 epoll_ctl06
+epoll_ctl07 epoll_ctl07
 
 epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
diff --git a/testcases/kernel/syscalls/epoll_ctl/.gitignore b/testcases/kernel/syscalls/epoll_ctl/.gitignore
index 9c555f41b..66da2dbfb 100644
--- a/testcases/kernel/syscalls/epoll_ctl/.gitignore
+++ b/testcases/kernel/syscalls/epoll_ctl/.gitignore
@@ -4,3 +4,4 @@ epoll_ctl03
 epoll_ctl04
 epoll_ctl05
 epoll_ctl06
+epoll_ctl07
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl07.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl07.c
new file mode 100644
index 000000000..6e9b3a1a2
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl07.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Verify that :manpage:`epoll_ctl(2)` fails with ELOOP when an
+ * ``EPOLL_CTL_ADD`` operation would create a minimal two-instance cycle of
+ * epoll instances monitoring one another.
+ *
+ * This is the shortest path through the kernel loop detector. The existing
+ * epoll_ctl05 test exercises a long chain closed into a loop.
+ *
+ * [Algorithm]
+ *
+ * - create two epoll instances ep_a and ep_b
+ * - add ep_b into ep_a with EPOLL_CTL_ADD (succeeds)
+ * - add ep_a into ep_b with EPOLL_CTL_ADD, which must fail with ELOOP
+ */
+
+#include <sys/epoll.h>
+
+#include "tst_test.h"
+#include "tst_epoll.h"
+
+static int ep_a = -1, ep_b = -1;
+
+static void setup(void)
+{
+	struct epoll_event ev = {.events = EPOLLIN};
+
+	ep_a = SAFE_EPOLL_CREATE1(0);
+	ep_b = SAFE_EPOLL_CREATE1(0);
+
+	ev.data.fd = ep_b;
+	SAFE_EPOLL_CTL(ep_a, EPOLL_CTL_ADD, ep_b, &ev);
+}
+
+static void cleanup(void)
+{
+	if (ep_a != -1)
+		SAFE_CLOSE(ep_a);
+
+	if (ep_b != -1)
+		SAFE_CLOSE(ep_b);
+}
+
+static void run(void)
+{
+	struct epoll_event ev = {.events = EPOLLIN, .data.fd = ep_a};
+
+	TST_EXP_FAIL(epoll_ctl(ep_b, EPOLL_CTL_ADD, ep_a, &ev), ELOOP,
+		     "epoll_ctl(EPOLL_CTL_ADD) closing a two-instance cycle");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
