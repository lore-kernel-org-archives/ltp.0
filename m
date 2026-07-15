Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C9AC44501
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 09:42:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 472E33E5692
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 11:42:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 296763E5686
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 11:41:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AD4892009C5
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 11:41:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CB6B07831D
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784108507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vlAPmvThHvACggtLoJAyo0xU2lcqs/cugVUjwElU4tg=;
 b=i9q9KhG7a4+JWvVxgfjf4uXGrTO6qcsLHLVWz6znPbz1HOOUlIm6VzC396zbQX53f7erGE
 yee09TFmfruAzeBWZOcJ8U7DEJd099swN5c2ZascAXkBN0BpHEPA1CxvtqPpoUObASmvYB
 Fgf9UL98AS4OKuodFWQSdhZrKyTOC2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784108507;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vlAPmvThHvACggtLoJAyo0xU2lcqs/cugVUjwElU4tg=;
 b=o6mhNgCj+Fa+JZ4X5M28psh4xP+uqXj8dTZ+KmsKS7luqEi7ybyZ8IWxQA6ndZ80kFpvBx
 86f1CQp/0tA1spBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i9q9KhG7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=o6mhNgCj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784108507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vlAPmvThHvACggtLoJAyo0xU2lcqs/cugVUjwElU4tg=;
 b=i9q9KhG7a4+JWvVxgfjf4uXGrTO6qcsLHLVWz6znPbz1HOOUlIm6VzC396zbQX53f7erGE
 yee09TFmfruAzeBWZOcJ8U7DEJd099swN5c2ZascAXkBN0BpHEPA1CxvtqPpoUObASmvYB
 Fgf9UL98AS4OKuodFWQSdhZrKyTOC2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784108507;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vlAPmvThHvACggtLoJAyo0xU2lcqs/cugVUjwElU4tg=;
 b=o6mhNgCj+Fa+JZ4X5M28psh4xP+uqXj8dTZ+KmsKS7luqEi7ybyZ8IWxQA6ndZ80kFpvBx
 86f1CQp/0tA1spBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2276779AD
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:41:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YtL7KdtVV2pMKQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:41:47 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 15 Jul 2026 11:41:34 +0200
Message-ID: <20260715094138.1679456-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715094138.1679456-1-chrubis@suse.cz>
References: <20260715094138.1679456-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CB6B07831D
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/5] syscalls: Add epoll_ctl07
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

The epoll_ctl05 excercies the loop detector with a longer chain this
tests does the same but only with two epoll fds.

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
