Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FF5C7EE32
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 12:35:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 945523CCBAA
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 14:35:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D871E3CCBAA
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 14:34:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5B79C1400BE8
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 14:34:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0CCB21F38D;
 Thu, 26 Jun 2025 12:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750941290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P0OfnlxIZ1g2kZjqYkHRY3o1JGzer0JzYGr7j68XlWw=;
 b=Qeo9/FAE+LiORqBWrtq43BVk12tuQojVeJpRaB0B1ecfmoRg2KpDgh0RrrY9HylbqzOcyN
 FcLxPSNSUNq88o4nxzM4yhDgCZpnYlKrbfy48HzQuG6ps3un8DuMve3OUu7M/mtb8kNAjg
 hUG2XFaieuDwxrFZInO2CaywHhd+Xds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750941290;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P0OfnlxIZ1g2kZjqYkHRY3o1JGzer0JzYGr7j68XlWw=;
 b=QxbRXvpCgP65mopHlUNuaCxpICmI5zQ9d/uBtwx6tq21mc/120TFL4S1u+VdGDdL5XYG4X
 Kktf5e7Elv1HsMBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750941290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P0OfnlxIZ1g2kZjqYkHRY3o1JGzer0JzYGr7j68XlWw=;
 b=Qeo9/FAE+LiORqBWrtq43BVk12tuQojVeJpRaB0B1ecfmoRg2KpDgh0RrrY9HylbqzOcyN
 FcLxPSNSUNq88o4nxzM4yhDgCZpnYlKrbfy48HzQuG6ps3un8DuMve3OUu7M/mtb8kNAjg
 hUG2XFaieuDwxrFZInO2CaywHhd+Xds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750941290;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P0OfnlxIZ1g2kZjqYkHRY3o1JGzer0JzYGr7j68XlWw=;
 b=QxbRXvpCgP65mopHlUNuaCxpICmI5zQ9d/uBtwx6tq21mc/120TFL4S1u+VdGDdL5XYG4X
 Kktf5e7Elv1HsMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFDF913A24;
 Thu, 26 Jun 2025 12:34:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8OPONGk+XWhJCQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 26 Jun 2025 12:34:49 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 26 Jun 2025 14:34:43 +0200
MIME-Version: 1.0
Message-Id: <20250626-ioctl_pidfd_suite-v1-6-165b9abf0296@suse.com>
References: <20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com>
In-Reply-To: <20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750941288; l=3263;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=MIAZzttZIpFqYM5nSHAOv5iaivh1LfpUX4uux2gmT9k=;
 b=UdGVkRTIE/qgcS/CcSunDtdFFNSSUIQrxeN3Itnd2eN9Glxnn9HL3RfKlXGhTl1JLwlAodxMu
 qHON2s+fB70CaaYBC3ZQDB6a0Nd0+27/6CHHC+tYFSU3xmLcQPEzvJf
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/6] Add ioctl_pidfd04 test
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
 testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c | 68 +++++++++++++++++++++++++
 3 files changed, 70 insertions(+)

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
index 0000000000000000000000000000000000000000..be2db01171c338e85d544c058b79fb567e781a63
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c
@@ -0,0 +1,68 @@
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
+	info->mask = PIDFD_INFO_EXIT;
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
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
