Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F2DC25B74
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 14:49:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D52263D072C
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 16:49:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7783F3C031C
 for <ltp@lists.linux.it>; Thu, 30 May 2024 16:48:49 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DD07E2069EF
 for <ltp@lists.linux.it>; Thu, 30 May 2024 16:48:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2B99F21A7F;
 Thu, 30 May 2024 14:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717080528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnHVX0DxfyKf1EU4TfTTzXz1z9dBxQBEOWpfU4IzjwA=;
 b=cpTSu7T0lKVI4dMaw8zNqu0cRAuAAPMqlBalxapTvt9kDfi68lUzANz7hWaB8ZoiYZhgqe
 5NM4cXkdTMW5qdriqRR6Lj8B0rVJSYoCg/spFbuRO8+woa+voCrIpc4UxOHNL6gEC+AI8E
 YpyjoI5fyxim/lF+S9b/MVNCA2YznWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717080528;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnHVX0DxfyKf1EU4TfTTzXz1z9dBxQBEOWpfU4IzjwA=;
 b=/fWi1yrMZaaRStUY3JAhPyjRZ2rTUmhEw2dGKOkcSYLK+yF38hswTu0bJ8eTBlULbqmY7g
 IOB3va0DQKlQktDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717080527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnHVX0DxfyKf1EU4TfTTzXz1z9dBxQBEOWpfU4IzjwA=;
 b=wz7xWdIe0iS1E0ERyyJ+byJ4kTnwJO5a7gu9Xz+YeTPc8tSjjI4+FXQe6rOLvx5Nz5jrEO
 qSJ+4wptAz2N8xgVw03UpflRzDGCiVFWCeEHVbQW9mDMLjh1frnSIzecMBweC9TIy+k6Nq
 9bjR2/0kA4H0CPG+GypEkCYsK899I+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717080527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnHVX0DxfyKf1EU4TfTTzXz1z9dBxQBEOWpfU4IzjwA=;
 b=0iQ+9MNhGDsjrrjORktSjh5ABMUB6j410QEslloyoAGrRkdphaw9ZRBdl9HdJXdujF/vQe
 vyIWNOEJMBP0/4Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C0FE13A42;
 Thu, 30 May 2024 14:48:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +JiPBs+RWGZdbgAAD6G6ig
 (envelope-from <akumar@suse.de>); Thu, 30 May 2024 14:48:47 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 30 May 2024 16:48:45 +0200
Message-ID: <20240530144846.10915-1-akumar@suse.de>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530144406.7626-1-akumar@suse.de>
References: <20240530144406.7626-1-akumar@suse.de>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] flock: Add test for verifying EINTR errno
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/flock/.gitignore |  1 +
 testcases/kernel/syscalls/flock/flock07.c  | 70 ++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 testcases/kernel/syscalls/flock/flock07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index cf06ee563..091453fec 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -374,6 +374,7 @@ flock02 flock02
 flock03 flock03
 flock04 flock04
 flock06 flock06
+flock07 flock07
 
 fmtmsg01 fmtmsg01
 
diff --git a/testcases/kernel/syscalls/flock/.gitignore b/testcases/kernel/syscalls/flock/.gitignore
index c8cb0fc54..9bac582e1 100644
--- a/testcases/kernel/syscalls/flock/.gitignore
+++ b/testcases/kernel/syscalls/flock/.gitignore
@@ -3,3 +3,4 @@
 /flock03
 /flock04
 /flock06
+/flock07
diff --git a/testcases/kernel/syscalls/flock/flock07.c b/testcases/kernel/syscalls/flock/flock07.c
new file mode 100644
index 000000000..b2de84905
--- /dev/null
+++ b/testcases/kernel/syscalls/flock/flock07.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ * Copyright (c) 2024 Linux Test Project
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that flock(2) fails with errno EINTR when waiting to acquire a lock,
+ * and the call is interrupted by a signal.
+ */
+
+#include <sys/file.h>
+#include "tst_test.h"
+
+#define TEMPFILE "test_eintr"
+
+static void handler(int sig)
+{
+	tst_res(TINFO, "Received signal: %d", sig);
+}
+
+static void setup(void)
+{
+	SAFE_TOUCH(TEMPFILE, 0777, NULL);
+}
+
+static void child_do(int fd)
+{
+	struct sigaction sa;
+
+	sa.sa_handler = handler;
+	SAFE_SIGEMPTYSET(&sa.sa_mask);
+	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
+
+	tst_res(TINFO, "Trying to acquire exclusive lock from child");
+	TST_EXP_FAIL(flock(fd, LOCK_EX), EINTR);
+}
+
+static void verify_flock(void)
+{
+	pid_t pid;
+	int fd1 = SAFE_OPEN(TEMPFILE, O_RDWR);
+	int fd2 = SAFE_OPEN(TEMPFILE, O_RDWR);
+
+	TST_EXP_PASS(flock(fd1, LOCK_EX));
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		child_do(fd2);
+		exit(0);
+	} else {
+		sleep(1);
+		SAFE_KILL(pid, SIGUSR1);
+		SAFE_WAITPID(pid, NULL, 0);
+	}
+
+	SAFE_CLOSE(fd1);
+	SAFE_CLOSE(fd2);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = verify_flock,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+};
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
