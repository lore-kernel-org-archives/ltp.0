Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1DAC83F17
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 14:18:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C9213CCD81
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 16:18:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 266AE3CCDAA
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 16:16:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 90C39600852
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 16:16:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D1F79218A9;
 Wed, 23 Jul 2025 14:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753280165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KVyl2igqF+KWzM9kH1DIp4X51rTl8xzHMG6PC1cPVlQ=;
 b=1A9wS6An6eMj44/SrukrpruMm7RCLYwfmrCTdyKJtjZCzLVX0T3pBzYhLHGA3JNy0FjNBw
 lft/6l2GvGzhMIxsjClIvRW/JUnxI25qJGtEP6Mx/jibif1543EcwzMUiX2X3GmrrTZkRg
 AsBNokN/RztiqjIBlWkEYcoSna/7nJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753280165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KVyl2igqF+KWzM9kH1DIp4X51rTl8xzHMG6PC1cPVlQ=;
 b=pJtpUVQHTqEfSGGDLyf77U30Ij+8dpI+vk1ymbUYe75fOsW3DJ1cxPiZhfz49ND1b43JfJ
 aNKdKfsouUe/N8CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1A9wS6An;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pJtpUVQH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753280165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KVyl2igqF+KWzM9kH1DIp4X51rTl8xzHMG6PC1cPVlQ=;
 b=1A9wS6An6eMj44/SrukrpruMm7RCLYwfmrCTdyKJtjZCzLVX0T3pBzYhLHGA3JNy0FjNBw
 lft/6l2GvGzhMIxsjClIvRW/JUnxI25qJGtEP6Mx/jibif1543EcwzMUiX2X3GmrrTZkRg
 AsBNokN/RztiqjIBlWkEYcoSna/7nJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753280165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KVyl2igqF+KWzM9kH1DIp4X51rTl8xzHMG6PC1cPVlQ=;
 b=pJtpUVQHTqEfSGGDLyf77U30Ij+8dpI+vk1ymbUYe75fOsW3DJ1cxPiZhfz49ND1b43JfJ
 aNKdKfsouUe/N8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4E9713AFB;
 Wed, 23 Jul 2025 14:16:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kOiSJqXugGj2LwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 23 Jul 2025 14:16:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 23 Jul 2025 16:15:22 +0200
MIME-Version: 1.0
Message-Id: <20250723-ioctl_pidfd_suite-v4-8-9309eacb1d8c@suse.com>
References: <20250723-ioctl_pidfd_suite-v4-0-9309eacb1d8c@suse.com>
In-Reply-To: <20250723-ioctl_pidfd_suite-v4-0-9309eacb1d8c@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753280164; l=3245;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=LlipjUKuxWKMGfhkhSvFL+wy8ipNc3ZhmNW5LGcci3k=;
 b=5U7Q5dKHdIkjAk5FmcUqn0tSVNbDLO7qfhxnn6fH7vxw5o6P2gPulGiJpgt03Z/E7gbdr7QEO
 9jDYS3NwCcrDyyA+4nPuWVf3sxSoe16RwpZM0QeRXpKGGM2Mpj+fIiG
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: D1F79218A9
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 8/8] Add ioctl_pidfd06 test
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

Verify that ioctl() doesn't allow to obtain the exit status of an
isolated process via PIDFD_INFO_EXIT in within an another isolated
process, which doesn't have any parent connection.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |  1 +
 testcases/kernel/syscalls/ioctl/.gitignore      |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c | 66 +++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 118a863ba8d86e1d8a7d3cff3e7fa09d0e137413..4ef3ed04a208dcc4dcffa8d597ccf0f7db6887e1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -618,6 +618,7 @@ ioctl_pidfd02 ioctl_pidfd02
 ioctl_pidfd03 ioctl_pidfd03
 ioctl_pidfd04 ioctl_pidfd04
 ioctl_pidfd05 ioctl_pidfd05
+ioctl_pidfd06 ioctl_pidfd06
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 09963c3896fb124ef1149bbd743537dd691400ee..dac4583fa7c05a4cdd937e86bd8f935dd15aebc8 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -35,3 +35,4 @@
 /ioctl_pidfd03
 /ioctl_pidfd04
 /ioctl_pidfd05
+/ioctl_pidfd06
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
new file mode 100644
index 0000000000000000000000000000000000000000..998f642e806b17a4d4770b2b2a3263560dd22644
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that ioctl() doesn't allow to obtain the exit status of an isolated
+ * process via PIDFD_INFO_EXIT in within an another isolated process, which
+ * doesn't have any parent connection.
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
+	int pidfd;
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
+	if (!pid_child)
+		exit(100);
+
+	SAFE_WAITPID(pid_child, NULL, 0);
+
+	memset(args, 0, sizeof(struct tst_clone_args));
+
+	args->flags = CLONE_NEWUSER | CLONE_NEWPID;
+	args->exit_signal = SIGCHLD;
+
+	if (!SAFE_CLONE(args)) {
+		TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, info), ESRCH);
+		exit(0);
+	}
+
+	SAFE_CLOSE(pidfd);
+}
+
+static void setup(void)
+{
+	if (!ioctl_pidfd_info_exit_supported())
+		tst_brk(TCONF, "PIDFD_INFO_EXIT is not supported by ioctl()");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.forks_child = 1,
+	.bufs = (struct tst_buffers []) {
+		{&args, .size = sizeof(*args)},
+		{&info, .size = sizeof(*info)},
+		{}
+	}
+};

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
