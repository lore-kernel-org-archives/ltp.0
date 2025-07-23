Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C690C83F17
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 14:16:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A19093CCD5A
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 16:16:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58F9E3CCCCC
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 16:16:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4F723600820
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 16:16:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 198EE21849;
 Wed, 23 Jul 2025 14:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753280165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMeOcxLtVAPKcj0P8F/u/cf9wq51/UdfVchhVLrMq/Q=;
 b=YfYHTJgL7ZlnY0be5aJKss6ICr5bqMcpJpIQeMoxFqVsXUvvZgtIrmcJXQZIlCn+89mblg
 n5xvpR7Fn9tVN807ewDngACVqjxCa0i2mtfbLDACLrc7pSwQURheGIIPUCaHIwWWR8jPEN
 rHL0CgLbEu2shZvFDn4dSDPJ8CAaElk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753280165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMeOcxLtVAPKcj0P8F/u/cf9wq51/UdfVchhVLrMq/Q=;
 b=yVV2AU1g+x4FMmmXR8d0e4V5yWlGydu1vCFLZCMkUM8jjbaDun52rN/pt8GBv9pyTJnK1i
 iq8v84BotpcmiiBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753280165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMeOcxLtVAPKcj0P8F/u/cf9wq51/UdfVchhVLrMq/Q=;
 b=YfYHTJgL7ZlnY0be5aJKss6ICr5bqMcpJpIQeMoxFqVsXUvvZgtIrmcJXQZIlCn+89mblg
 n5xvpR7Fn9tVN807ewDngACVqjxCa0i2mtfbLDACLrc7pSwQURheGIIPUCaHIwWWR8jPEN
 rHL0CgLbEu2shZvFDn4dSDPJ8CAaElk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753280165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMeOcxLtVAPKcj0P8F/u/cf9wq51/UdfVchhVLrMq/Q=;
 b=yVV2AU1g+x4FMmmXR8d0e4V5yWlGydu1vCFLZCMkUM8jjbaDun52rN/pt8GBv9pyTJnK1i
 iq8v84BotpcmiiBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E975413AFB;
 Wed, 23 Jul 2025 14:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sAtJN6TugGj2LwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 23 Jul 2025 14:16:04 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 23 Jul 2025 16:15:18 +0200
MIME-Version: 1.0
Message-Id: <20250723-ioctl_pidfd_suite-v4-4-9309eacb1d8c@suse.com>
References: <20250723-ioctl_pidfd_suite-v4-0-9309eacb1d8c@suse.com>
In-Reply-To: <20250723-ioctl_pidfd_suite-v4-0-9309eacb1d8c@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753280164; l=3834;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=xcqoQXOcDalDDR+NWd2SY+Kg2xJ7Ckaebqsf+P+QEBU=;
 b=3Krl5SX7llQQ2LW8yISfvK3wbYA8cCxTFLCI/VQLLR4g8OrquNcz+PGjeXNgLU1eovprPaUA7
 FG8XyJuSG9FDbTh5NW9GjUX/wNYD1rqeT5hTglHITnd5IOIqFl95xyB
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/8] Add ioctl_pidfd02 test
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |  1 +
 testcases/kernel/syscalls/ioctl/.gitignore      |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c | 85 +++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 2075c5d908c04bf31fcf57bba5cdf7af3e432237..fbb38b1a52ed9d7f6634336d83c226b5cce522e8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -614,6 +614,7 @@ ioctl_ficlonerange02 ioctl_ficlonerange02
 ioctl_fiemap01 ioctl_fiemap01
 
 ioctl_pidfd01 ioctl_pidfd01
+ioctl_pidfd02 ioctl_pidfd02
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 72d6a309ee0dcbd185a0248b9ffc79fc83b7f04f..a984744a67173b70872446823a6fdeb6a44fe2c8 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -31,3 +31,4 @@
 /ioctl_ficlonerange02
 /ioctl_fiemap01
 /ioctl_pidfd01
+/ioctl_pidfd02
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
new file mode 100644
index 0000000000000000000000000000000000000000..858ec461af373667c1fea1a16f7cb5e4f516b758
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
@@ -0,0 +1,85 @@
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
+	SAFE_CLOSE(pidfd);
+
+	TST_EXP_EQ_LI(info1->mask & PIDFD_INFO_EXIT, PIDFD_INFO_EXIT);
+	TST_EXP_EQ_LI(info1->exit_code, status);
+
+	TST_EXP_EQ_LI(WEXITSTATUS(info1->exit_code), 100);
+}
+
+static void setup(void)
+{
+	if (!ioctl_pidfd_info_exit_supported())
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
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
