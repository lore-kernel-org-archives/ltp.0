Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B43C5AD49
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 15:23:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BD5B3CA000
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 17:23:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04C6B3CA062
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 17:23:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 86855204724
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 17:23:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0FD6921BB7
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 15:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748964176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=znDXza+GQeUyawD6+3NpLf/1teecJ7f1c+bn7xVPBps=;
 b=AmHSdDpz+5pLNPCc4nf7hroGsjjtr7XVOi68Qwn0o5RZqpoLfAFXrDW+qyEDVtPLkzgzlF
 vrQKrBKXm0VpzsH2maujwZOyK5NkxJqXH6y9dvS8tRuuInGRL0B8tBZD10LH04DpGP7onC
 7rFYdjZNN14djXAQwhr7hWKM4p8k+XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748964176;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=znDXza+GQeUyawD6+3NpLf/1teecJ7f1c+bn7xVPBps=;
 b=1Ja9NPM5tovXkBXpxyFTAyjAPBe5ceO9y+oS6mvZbk8pR6xPyxgloWt6RTwt10yKJPNlwM
 Bl56O5ap3T+wT2DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748964176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=znDXza+GQeUyawD6+3NpLf/1teecJ7f1c+bn7xVPBps=;
 b=AmHSdDpz+5pLNPCc4nf7hroGsjjtr7XVOi68Qwn0o5RZqpoLfAFXrDW+qyEDVtPLkzgzlF
 vrQKrBKXm0VpzsH2maujwZOyK5NkxJqXH6y9dvS8tRuuInGRL0B8tBZD10LH04DpGP7onC
 7rFYdjZNN14djXAQwhr7hWKM4p8k+XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748964176;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=znDXza+GQeUyawD6+3NpLf/1teecJ7f1c+bn7xVPBps=;
 b=1Ja9NPM5tovXkBXpxyFTAyjAPBe5ceO9y+oS6mvZbk8pR6xPyxgloWt6RTwt10yKJPNlwM
 Bl56O5ap3T+wT2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04DD313AB2
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 15:22:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +NwGAVATP2iENQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 03 Jun 2025 15:22:56 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Jun 2025 17:22:42 +0200
Message-ID: <20250603152253.214656-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603152253.214656-1-mdoucha@suse.cz>
References: <20250603152253.214656-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] Add regression test for epoll_pwait2() timeout
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Added kernel fix reference
- Use SAFE_EPOLL_*() functions

 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_pwait/.gitignore    |  1 +
 .../syscalls/epoll_pwait/epoll_pwait06.c      | 87 +++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index e7bc7b27b..2a968099a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -192,6 +192,7 @@ epoll_pwait02 epoll_pwait02
 epoll_pwait03 epoll_pwait03
 epoll_pwait04 epoll_pwait04
 epoll_pwait05 epoll_pwait05
+epoll_pwait06 epoll_pwait06
 
 eventfd01 eventfd01
 eventfd02 eventfd02
diff --git a/testcases/kernel/syscalls/epoll_pwait/.gitignore b/testcases/kernel/syscalls/epoll_pwait/.gitignore
index fafb2d782..81e77b8d0 100644
--- a/testcases/kernel/syscalls/epoll_pwait/.gitignore
+++ b/testcases/kernel/syscalls/epoll_pwait/.gitignore
@@ -3,3 +3,4 @@ epoll_pwait02
 epoll_pwait03
 epoll_pwait04
 epoll_pwait05
+epoll_pwait06
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c
new file mode 100644
index 000000000..3bedc2cf5
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 SUSE LLC <mdoucha@suse.cz>
+ */
+
+/*\
+ * Verify that various timeout values don't get misinterpreted as infinity
+ * by epoll_pwait() and epoll_pwait2(). Regression fixed in:
+ *
+ * commit d9ec73301099ec5975505e1c3effbe768bab9490
+ * Author: Max Kellermann <max.kellermann@ionos.com>
+ * Date:   Tue Apr 29 20:58:27 2025 +0200
+ *
+ * fs/eventpoll: fix endless busy loop after timeout has expired
+ */
+
+#include "tst_test.h"
+#include "tst_timer.h"
+#include "tst_epoll.h"
+#include "epoll_pwait_var.h"
+
+static int efd = -1;
+
+static void run(void)
+{
+	struct timespec timeout = {};
+	struct epoll_event e = {};
+
+	e.events = EPOLLIN;
+
+	TST_FD_FOREACH(fd_in) {
+		/* File descriptor types not supported by epoll */
+		switch (fd_in.type) {
+		case TST_FD_FILE:
+		case TST_FD_PATH:
+		case TST_FD_DIR:
+		case TST_FD_DEV_ZERO:
+		case TST_FD_PROC_MAPS:
+		case TST_FD_FSOPEN:
+		case TST_FD_FSPICK:
+		case TST_FD_OPEN_TREE:
+		case TST_FD_MEMFD:
+		case TST_FD_MEMFD_SECRET:
+			continue;
+		default:
+			break;
+		}
+
+		tst_res(TINFO, "Testing %s", tst_fd_desc(&fd_in));
+		timeout.tv_nsec = 1000000000;
+		SAFE_EPOLL_CTL(efd, EPOLL_CTL_ADD, fd_in.fd, &e);
+
+		do {
+			alarm(1);
+			timeout.tv_nsec /= 10;
+			do_epoll_pwait(efd, &e, 1, &timeout, NULL);
+			alarm(0);
+		} while (timeout.tv_nsec);
+
+		SAFE_EPOLL_CTL(efd, EPOLL_CTL_DEL, fd_in.fd, &e);
+	}
+
+	tst_res(TPASS, "Timeout works correctly");
+}
+
+static void setup(void)
+{
+	epoll_pwait_init();
+	efd = SAFE_EPOLL_CREATE1(0);
+}
+
+static void cleanup(void)
+{
+	if (efd >= 0)
+		SAFE_CLOSE(efd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_variants = TEST_VARIANTS,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "d9ec73301099"},
+		{}
+	}
+};
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
