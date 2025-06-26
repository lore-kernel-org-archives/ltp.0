Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38349C7EE30
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 12:36:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCDD63CCBB4
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 14:36:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B0EC3CCB93
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 14:35:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BE4151400B96
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 14:35:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7681F211A9;
 Thu, 26 Jun 2025 12:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750941289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uRfpD6QGyhrJmsCL7kIN4svZDYXYF5hDgmNPoDjzA3M=;
 b=kfW840VK9IYkvuNYyQQtEV8juBZ4Pw+8lHsIYnlKqPNONBHj2+Q2tQuFQqMw3Yn0VWU2p9
 RXuIAtxMxNY0BjGZWFaOsOgcrA2TFjdn38uetCUh26t1r513S4/cBFQ8S5zkPJoYRU6ah0
 Gun91dGcalDc4ABOFY0vv9rJ7wKC/3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750941289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uRfpD6QGyhrJmsCL7kIN4svZDYXYF5hDgmNPoDjzA3M=;
 b=kfnENS1ygPmgFyWoDG7szVG7AQbrc/a/OhC3pgWOHRhV6JwcPTsK0956vHSZbSoyln2XLi
 69v3pEpjej9t07BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kfW840VK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kfnENS1y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750941289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uRfpD6QGyhrJmsCL7kIN4svZDYXYF5hDgmNPoDjzA3M=;
 b=kfW840VK9IYkvuNYyQQtEV8juBZ4Pw+8lHsIYnlKqPNONBHj2+Q2tQuFQqMw3Yn0VWU2p9
 RXuIAtxMxNY0BjGZWFaOsOgcrA2TFjdn38uetCUh26t1r513S4/cBFQ8S5zkPJoYRU6ah0
 Gun91dGcalDc4ABOFY0vv9rJ7wKC/3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750941289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uRfpD6QGyhrJmsCL7kIN4svZDYXYF5hDgmNPoDjzA3M=;
 b=kfnENS1ygPmgFyWoDG7szVG7AQbrc/a/OhC3pgWOHRhV6JwcPTsK0956vHSZbSoyln2XLi
 69v3pEpjej9t07BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 528B613A24;
 Thu, 26 Jun 2025 12:34:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cEJyEmk+XWhJCQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 26 Jun 2025 12:34:49 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 26 Jun 2025 14:34:41 +0200
MIME-Version: 1.0
Message-Id: <20250626-ioctl_pidfd_suite-v1-4-165b9abf0296@suse.com>
References: <20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com>
In-Reply-To: <20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750941288; l=3203;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=1MA/SyFt4a9r7anb/pzrUzqRl3kbne7yI5fSsEzoakE=;
 b=Hv9eJEnAViDiE9S6x6WITVYpU6HK5ClKhVI3IWgNkRxgZuBQX1Fy6vXtUVihshVl1zGgvU0af
 rG3SQxYNJUsA3/ijkXgUOl+64EiqZ9jEVsEmWU3kC5mwTxIqABID9cS
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email,suse.com:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 7681F211A9
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/6] Add ioctl_pidfd02 test
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Check if the ioctl() function allows retrieval of a child's exit code
using PIDFD_INFO_EXIT from a process that is isolated from the child.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |  1 +
 testcases/kernel/syscalls/ioctl/.gitignore      |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c | 62 +++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 7f6312ce5fa241a778d8dda7f8ee9edd0a8800e6..23f335846663d62a39e6de3a8f6948c1b0acf8a5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -613,6 +613,7 @@ ioctl_ficlonerange02 ioctl_ficlonerange02
 ioctl_fiemap01 ioctl_fiemap01
 
 ioctl_pidfd01 ioctl_pidfd01
+ioctl_pidfd02 ioctl_pidfd02
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index aa952c1a7bae0ae2dbb04de0595f10d508b6759a..1c81c2bed8db952af0c93fb1ce5bfbad82794b60 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -30,3 +30,4 @@
 /ioctl_ficlonerange02
 /ioctl_fiemap01
 /ioctl_pidfd01
+/ioctl_pidfd02
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
new file mode 100644
index 0000000000000000000000000000000000000000..82dd8c359938cdc7bf69cc2fd6afc90ce2a95290
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Check if the ioctl() function allows retrieval of a child's exit code
+ * using PIDFD_INFO_EXIT from a process that is isolated from the child.
+ */
+
+#include "tst_test.h"
+#include "lapi/pidfd.h"
+#include "lapi/sched.h"
+
+static struct tst_clone_args *args;
+static struct pidfd_info *info;
+
+static void run(void)
+{
+	int status;
+	int pidfd = 0;
+	pid_t pid_child;
+
+	memset(args, 0, sizeof(struct tst_clone_args));
+
+	args->flags = CLONE_PIDFD | CLONE_NEWUSER | CLONE_NEWPID;
+	args->pidfd = (uint64_t)&pidfd;
+	args->exit_signal = SIGCHLD;
+
+	pid_child = SAFE_CLONE(args);
+	if (!pid_child) {
+		TST_CHECKPOINT_WAIT(0);
+		exit(100);
+	}
+
+	/* child is not reaped, so ioctl() will pass */
+	info->mask = 0;
+	SAFE_IOCTL(pidfd, PIDFD_GET_INFO, info);
+
+	TST_CHECKPOINT_WAKE(0);
+	SAFE_WAITPID(pid_child, &status, 0);
+
+	/* child is now reaped, so we can ask for the exit status */
+	info->mask = PIDFD_INFO_EXIT;
+	SAFE_IOCTL(pidfd, PIDFD_GET_INFO, info);
+
+	TST_EXP_EQ_LI(info->mask & PIDFD_INFO_EXIT, PIDFD_INFO_EXIT);
+	TST_EXP_EQ_LI(WIFEXITED(info->exit_code), WIFEXITED(status));
+	TST_EXP_EQ_LI(WEXITSTATUS(info->exit_code), WEXITSTATUS(status));
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.min_kver = "6.15",
+	.bufs = (struct tst_buffers []) {
+		{&args, .size = sizeof(*args)},
+		{&info, .size = sizeof(*info)},
+		{}
+	}
+};

-- 
2.50.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
