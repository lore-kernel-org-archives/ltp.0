Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E178C71130
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 17:08:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C7DC3CA182
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 19:08:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE9943CA12A
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 19:06:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 249FF2009E8
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 19:06:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A4B30211A2;
 Mon,  7 Jul 2025 17:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751907953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cBulxmYjvy9c39mKsNCRp9Imwem7T6dF+3n3ZZlWtKg=;
 b=XHvx6mQZ3w5HzZtt8auyiKzgqVNmixgVVG6ntIKzB7SyZsPPkv2rJTtdObwkKVWIXy1QVS
 P6yIBK7MYv/hPvFJYOvcVaZXBALVOOdZJuNdxukS/uZbgbw+z5qowAZR3Ttj09Ozv2gtn+
 0PDcwmd+usre9tU0jYFWJM0UfR9mn/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751907953;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cBulxmYjvy9c39mKsNCRp9Imwem7T6dF+3n3ZZlWtKg=;
 b=O4OScvI2cENUl+nJT02T87500iijeKbo3PRKj+jmUsB+achSLlayf6nEOQ+vF4pkpkGUle
 Q6jJse6sR/2ulPCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XHvx6mQZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=O4OScvI2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751907953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cBulxmYjvy9c39mKsNCRp9Imwem7T6dF+3n3ZZlWtKg=;
 b=XHvx6mQZ3w5HzZtt8auyiKzgqVNmixgVVG6ntIKzB7SyZsPPkv2rJTtdObwkKVWIXy1QVS
 P6yIBK7MYv/hPvFJYOvcVaZXBALVOOdZJuNdxukS/uZbgbw+z5qowAZR3Ttj09Ozv2gtn+
 0PDcwmd+usre9tU0jYFWJM0UfR9mn/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751907953;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cBulxmYjvy9c39mKsNCRp9Imwem7T6dF+3n3ZZlWtKg=;
 b=O4OScvI2cENUl+nJT02T87500iijeKbo3PRKj+jmUsB+achSLlayf6nEOQ+vF4pkpkGUle
 Q6jJse6sR/2ulPCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4833913A5E;
 Mon,  7 Jul 2025 17:05:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WKj3B3H+a2g/YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 07 Jul 2025 17:05:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 07 Jul 2025 19:05:45 +0200
MIME-Version: 1.0
Message-Id: <20250707-ioctl_pidfd_suite-v3-4-22ba4d15ee02@suse.com>
References: <20250707-ioctl_pidfd_suite-v3-0-22ba4d15ee02@suse.com>
In-Reply-To: <20250707-ioctl_pidfd_suite-v3-0-22ba4d15ee02@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751907947; l=3757;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=eRF9sFhe89e9FzVzMZqlzqsfbdI59xyiNjm166U7rlk=;
 b=34eGgR/glfDCFLP+v5iC9q9YKdmuuem0osbPtFR1ZjTT7AYpAi9tadMO1XcdGXd1nM17XIQNY
 R79rJzunUGrAb9yvysNzVFnMr4ZKVXXsG5O1Ng3wD3X8buZ3jmP6UNx
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: A4B30211A2
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/8] Add ioctl_pidfd02 test
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
using PIDFD_INFO_EXIT from a process that can be isolated or not from
the child.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |  1 +
 testcases/kernel/syscalls/ioctl/.gitignore      |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c | 84 +++++++++++++++++++++++++
 3 files changed, 86 insertions(+)

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
index 0000000000000000000000000000000000000000..9279f59046e46f4291ef6eb5e89b1cfcf2d18b6c
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Check if the ioctl() function allows retrieval of a child's exit code
+ * using PIDFD_INFO_EXIT from a process that can be isolated or not from the
+ * child.
+ */
+
+#include "ioctl_pidfd.h"
+#include "lapi/sched.h"
+
+static struct tst_clone_args *args;
+static struct pidfd_info *info0, *info1;
+
+static void run(unsigned int isolate)
+{
+	int status;
+	int pidfd = 0;
+	pid_t pid_child;
+
+	memset(args, 0, sizeof(struct tst_clone_args));
+	memset(info0, 0, sizeof(struct pidfd_info));
+	memset(info1, 0, sizeof(struct pidfd_info));
+
+	if (isolate) {
+		args->flags = CLONE_PIDFD | CLONE_NEWUSER | CLONE_NEWPID;
+		args->pidfd = (uint64_t)&pidfd;
+		args->exit_signal = SIGCHLD;
+
+		pid_child = SAFE_CLONE(args);
+	} else {
+		pid_child = SAFE_FORK();
+	}
+
+	if (!pid_child) {
+		TST_CHECKPOINT_WAIT(0);
+		exit(100);
+	}
+
+	if (!isolate)
+		pidfd = SAFE_PIDFD_OPEN(pid_child, 0);
+
+	/* child is not reaped and ioctl() won't provide any exit status info */
+	info0->mask = PIDFD_INFO_EXIT;
+	SAFE_IOCTL(pidfd, PIDFD_GET_INFO, info0);
+	TST_EXP_EQ_LI(info0->mask & PIDFD_INFO_EXIT, 0);
+	TST_EXP_EQ_LI(info0->exit_code, 0);
+
+	TST_CHECKPOINT_WAKE(0);
+
+	SAFE_WAITPID(pid_child, &status, 0);
+
+	/* child is now reaped and ioctl() will provide the exit status */
+	info1->mask = PIDFD_INFO_EXIT;
+	SAFE_IOCTL(pidfd, PIDFD_GET_INFO, info1);
+
+	TST_EXP_EQ_LI(info1->mask & PIDFD_INFO_EXIT, PIDFD_INFO_EXIT);
+	TST_EXP_EQ_LI(info1->exit_code, status);
+
+	TST_EXP_EQ_LI(WEXITSTATUS(info1->exit_code), 100);
+}
+
+static void setup(void)
+{
+	if (!ioctl_pidfd_supported())
+		tst_brk(TCONF, "PIDFD_INFO_EXIT is not supported by ioctl()");
+}
+
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
+	.tcnt = 2,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.bufs = (struct tst_buffers []) {
+		{&args, .size = sizeof(*args)},
+		{&info0, .size = sizeof(*info0)},
+		{&info1, .size = sizeof(*info1)},
+		{}
+	}
+};

-- 
2.50.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
