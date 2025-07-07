Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53865C71130
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 17:07:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 617723CA14F
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 19:07:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 631793CA17F
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 19:06:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B06D2200C9E
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 19:05:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8FCE71F452;
 Mon,  7 Jul 2025 17:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751907954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7oF90/2UDWv3ASyAyCL6zu1E2bWEmrVkugh/Dyzb20c=;
 b=LPfXQv1pfGnG/Ng/MFVEppfAn/cXGGRtJw5polHjEVBUnyXcRNqS3QuUaMcmwNbrpooT4k
 wtLMRegRg25gfAxUjFitRfB6zLotWYsxHgcmp75OBhtLm5uB+OVJftxofe743yoLRaLpwv
 VOlDklVWn+r3FvQbcOhw/IWurxl7JOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751907954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7oF90/2UDWv3ASyAyCL6zu1E2bWEmrVkugh/Dyzb20c=;
 b=CTUt6Mry4xQFQrFSu7AqmTz0eQhFjy6+DFTncSTko51Lhtzce7QjBRObcEFxZAP6QcAuYO
 loxq2llelzUB7bAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LPfXQv1p;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CTUt6Mry
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751907954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7oF90/2UDWv3ASyAyCL6zu1E2bWEmrVkugh/Dyzb20c=;
 b=LPfXQv1pfGnG/Ng/MFVEppfAn/cXGGRtJw5polHjEVBUnyXcRNqS3QuUaMcmwNbrpooT4k
 wtLMRegRg25gfAxUjFitRfB6zLotWYsxHgcmp75OBhtLm5uB+OVJftxofe743yoLRaLpwv
 VOlDklVWn+r3FvQbcOhw/IWurxl7JOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751907954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7oF90/2UDWv3ASyAyCL6zu1E2bWEmrVkugh/Dyzb20c=;
 b=CTUt6Mry4xQFQrFSu7AqmTz0eQhFjy6+DFTncSTko51Lhtzce7QjBRObcEFxZAP6QcAuYO
 loxq2llelzUB7bAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 402AF13A5E;
 Mon,  7 Jul 2025 17:05:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id APQ8C3L+a2g/YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 07 Jul 2025 17:05:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 07 Jul 2025 19:05:47 +0200
MIME-Version: 1.0
Message-Id: <20250707-ioctl_pidfd_suite-v3-6-22ba4d15ee02@suse.com>
References: <20250707-ioctl_pidfd_suite-v3-0-22ba4d15ee02@suse.com>
In-Reply-To: <20250707-ioctl_pidfd_suite-v3-0-22ba4d15ee02@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751907947; l=3367;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=ZuS+n6tEJm5ebjI2xAG9y4w2LyfDADyBdIbn0R3tx9k=;
 b=bZ6DRuU14bL65PMitGcPLK9tecBqW8h7fL//kTfsJx1eWO4JID4+3rOqzE0zQnTGISZj/LIU/
 XQS4GaRuQInCuBA4zU5eAXtOLaxP0K/0CuDRuubVlZBgVU0YNa4+TBo
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 8FCE71F452
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 6/8] Add ioctl_pidfd04 test
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

Verify that ioctl() permits to obtain the exit code of an isolated
signaled child via PIDFD_INFO_EXIT from within a process.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |  1 +
 testcases/kernel/syscalls/ioctl/.gitignore      |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c | 70 +++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 8eec613a941a83b1fed25f96cdce617da0b0ef34..a28f4857ffccc070665361f2741ddbaa480d1153 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -615,6 +615,7 @@ ioctl_fiemap01 ioctl_fiemap01
 ioctl_pidfd01 ioctl_pidfd01
 ioctl_pidfd02 ioctl_pidfd02
 ioctl_pidfd03 ioctl_pidfd03
+ioctl_pidfd04 ioctl_pidfd04
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 08387dc8f2bc43f8f3a75264841da4beee28bfac..b6203828f324647ccf5d809e80e2ada515817006 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -32,3 +32,4 @@
 /ioctl_pidfd01
 /ioctl_pidfd02
 /ioctl_pidfd03
+/ioctl_pidfd04
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c
new file mode 100644
index 0000000000000000000000000000000000000000..c4e60e21fe4c9e510e07b2081617b128ffe5b6c7
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that ioctl() permits to obtain the exit code of an isolated signaled
+ * child via PIDFD_INFO_EXIT from within a process.
+ */
+
+#include "ioctl_pidfd.h"
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
+	memset(info, 0, sizeof(struct pidfd_info));
+
+	info->mask = PIDFD_INFO_EXIT;
+
+	args->flags = CLONE_PIDFD | CLONE_NEWUSER | CLONE_NEWPID;
+	args->pidfd = (uint64_t)&pidfd;
+	args->exit_signal = SIGCHLD;
+
+	pid_child = SAFE_CLONE(args);
+	if (!pid_child) {
+		TST_CHECKPOINT_WAKE_AND_WAIT(0);
+		exit(1);
+	}
+
+	TST_CHECKPOINT_WAIT(0);
+
+	SAFE_KILL(pid_child, SIGKILL);
+	SAFE_WAITPID(pid_child, &status, 0);
+
+	SAFE_IOCTL(pidfd, PIDFD_GET_INFO, info);
+
+	TST_EXP_EQ_LI(info->mask & PIDFD_INFO_EXIT, PIDFD_INFO_EXIT);
+	TST_EXP_EQ_LI(WIFSIGNALED(info->exit_code), WIFSIGNALED(status));
+	TST_EXP_EQ_LI(WEXITSTATUS(info->exit_code), WEXITSTATUS(status));
+	TST_EXP_EQ_LI(WTERMSIG(info->exit_code), WTERMSIG(status));
+
+	TST_EXP_EXPR(WIFSIGNALED(info->exit_code) &&
+	      WTERMSIG(info->exit_code) == SIGKILL);
+}
+
+static void setup(void)
+{
+	if (!ioctl_pidfd_supported())
+		tst_brk(TCONF, "PIDFD_INFO_EXIT is not supported by ioctl()");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
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
