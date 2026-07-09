Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340C5C44509
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 08:54:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72A683E2A41
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 10:54:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 329E53C6F29
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 10:54:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 95AA61A006AB
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 10:54:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 406AE75DCA;
 Thu,  9 Jul 2026 08:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783587249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yYu1smLCTGmrh/8nHGpcT7Lb+iIEjPG+rNBurAjeN34=;
 b=kjh67SCyOMffS8tDtKKWTh3Xy8WNbugsKGZFVKFDSfHINWgO2ix/nYBHc4YbgEd0kI12A3
 cL4x9Oub8thpQ5QLAmz/pqDbGQoo21Lx75LxJYgGOFEhoKA/GCt+3+Zby797wDYqh/tANo
 J+MpgTSBgsSntpQ66jMkLU9P2UUrYvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783587249;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yYu1smLCTGmrh/8nHGpcT7Lb+iIEjPG+rNBurAjeN34=;
 b=ClV9iAyO856GXpE0+KV3cqRHxbicbJe9VOC+itZ8FAW2GV5v971Mlb4VI+IgwT/084Mc9a
 I+LYhjOyVKUyNdCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783587249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yYu1smLCTGmrh/8nHGpcT7Lb+iIEjPG+rNBurAjeN34=;
 b=kjh67SCyOMffS8tDtKKWTh3Xy8WNbugsKGZFVKFDSfHINWgO2ix/nYBHc4YbgEd0kI12A3
 cL4x9Oub8thpQ5QLAmz/pqDbGQoo21Lx75LxJYgGOFEhoKA/GCt+3+Zby797wDYqh/tANo
 J+MpgTSBgsSntpQ66jMkLU9P2UUrYvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783587249;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yYu1smLCTGmrh/8nHGpcT7Lb+iIEjPG+rNBurAjeN34=;
 b=ClV9iAyO856GXpE0+KV3cqRHxbicbJe9VOC+itZ8FAW2GV5v971Mlb4VI+IgwT/084Mc9a
 I+LYhjOyVKUyNdCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C15E779AD;
 Thu,  9 Jul 2026 08:54:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Fd+vCbFhT2oPHgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 09 Jul 2026 08:54:09 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Jul 2026 10:53:46 +0200
Message-ID: <20260709085353.345957-3-chrubis@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid,suse.com:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/9] syscalls: Add epoll_wait08
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

Tests that epoll_wait() can be interrupted by a signal and returns
EINTR.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |  3 +
 .../kernel/syscalls/epoll_wait/.gitignore     |  1 +
 .../kernel/syscalls/epoll_wait/epoll_wait08.c | 69 +++++++++++++++++++
 3 files changed, 73 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait08.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 65bac761b..debe64ff9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -187,6 +187,7 @@ epoll_ctl02 epoll_ctl02
 epoll_ctl03 epoll_ctl03
 epoll_ctl04 epoll_ctl04
 epoll_ctl05 epoll_ctl05
+
 epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
@@ -194,6 +195,8 @@ epoll_wait04 epoll_wait04
 epoll_wait05 epoll_wait05
 epoll_wait06 epoll_wait06
 epoll_wait07 epoll_wait07
+epoll_wait08 epoll_wait08
+
 epoll_pwait01 epoll_pwait01
 epoll_pwait02 epoll_pwait02
 epoll_pwait03 epoll_pwait03
diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
index 66ac18ae2..f3b208950 100644
--- a/testcases/kernel/syscalls/epoll_wait/.gitignore
+++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
@@ -5,3 +5,4 @@ epoll_wait04
 epoll_wait05
 epoll_wait06
 epoll_wait07
+epoll_wait08
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait08.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait08.c
new file mode 100644
index 000000000..9e9a88526
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait08.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Verify that :manpage:epoll_wait() fails with EINTR when a signal arrives
+ * while waiting for events.
+ *
+ * [Algorithm]
+ *
+ * - Create an epoll instance
+ * - Fork a child that waits in the :manpage:epoll_wait(), parents sends
+ *   SIGUSR1 to interrupt it.
+ * - Verify that :manpage:epoll_wait() returns -1 with errno set to EINTR.
+ */
+
+#include <stdlib.h>
+#include <sys/epoll.h>
+
+#include "tst_test.h"
+#include "tst_epoll.h"
+
+static int efd = -1;
+
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+}
+
+static void setup(void)
+{
+	static struct sigaction sa = {
+		.sa_handler = sighandler,
+	};
+
+	SAFE_SIGEMPTYSET(&sa.sa_mask);
+	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
+
+	efd = SAFE_EPOLL_CREATE1(0);
+}
+
+static void run(void)
+{
+	pid_t pid = SAFE_FORK();
+
+	if (!pid) {
+		struct epoll_event ev;
+
+		TST_EXP_FAIL(epoll_wait(efd, &ev, 1, -1), EINTR,
+			     "epoll_wait() interrupted by signal");
+		exit(0);
+	}
+
+	TST_PROCESS_STATE_WAIT(pid, 'S', 0);
+	SAFE_KILL(pid, SIGUSR1);
+}
+
+static void cleanup(void)
+{
+	if (efd != -1)
+		SAFE_CLOSE(efd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+};
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
