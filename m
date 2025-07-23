Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CFBC83F1A
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 14:17:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B81883CCD94
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 16:17:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06B743CCD79
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 16:16:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6B219600849
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 16:16:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 706A51F790;
 Wed, 23 Jul 2025 14:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753280165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ps30rwAxlQ6lPI61rE3l8DYB297cbngi/vRYtaoMNu0=;
 b=mEo1RgwsGHKn+lyvSM6kEC4eBXwt1x5+ai1bFSqzTcdz3f9OhRxBogMr7JG4cL1vbbhMYm
 WaJ8adSEMH8YsYNLaNsStaHzJcVmBpDrIQItK2XHgxT8nNIr/GwV7ARpomLajkFy5B55Ec
 2glwvmppwThKbHYmv0qEEGywQNGc9PE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753280165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ps30rwAxlQ6lPI61rE3l8DYB297cbngi/vRYtaoMNu0=;
 b=ACQpB8H8ayNcgIWa+iYsCuhF4RiI25uuErdyR+y51sH6rDShTHGD0DCgaSDEpJXNkl691W
 N0CsD8MONZKFS8Aw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mEo1Rgws;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ACQpB8H8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753280165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ps30rwAxlQ6lPI61rE3l8DYB297cbngi/vRYtaoMNu0=;
 b=mEo1RgwsGHKn+lyvSM6kEC4eBXwt1x5+ai1bFSqzTcdz3f9OhRxBogMr7JG4cL1vbbhMYm
 WaJ8adSEMH8YsYNLaNsStaHzJcVmBpDrIQItK2XHgxT8nNIr/GwV7ARpomLajkFy5B55Ec
 2glwvmppwThKbHYmv0qEEGywQNGc9PE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753280165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ps30rwAxlQ6lPI61rE3l8DYB297cbngi/vRYtaoMNu0=;
 b=ACQpB8H8ayNcgIWa+iYsCuhF4RiI25uuErdyR+y51sH6rDShTHGD0DCgaSDEpJXNkl691W
 N0CsD8MONZKFS8Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4ECCA13AFA;
 Wed, 23 Jul 2025 14:16:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mE/VEKXugGj2LwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 23 Jul 2025 14:16:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 23 Jul 2025 16:15:20 +0200
MIME-Version: 1.0
Message-Id: <20250723-ioctl_pidfd_suite-v4-6-9309eacb1d8c@suse.com>
References: <20250723-ioctl_pidfd_suite-v4-0-9309eacb1d8c@suse.com>
In-Reply-To: <20250723-ioctl_pidfd_suite-v4-0-9309eacb1d8c@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753280164; l=3444;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Ybi++guYVqZNmF2kiMdFgwp3HuK4KjNPyO943ctY7s8=;
 b=BUcIbV5GV6M4ESVOq5Njz+cdxVdZcSLqDLfaVFOIoX++UmFW6MY/xFvSdh6UFzuivnRfneZuM
 5YDeXXvk6xFBYZ7V40RQ82YG95D/etms9t/XrGc0kIrqHnddsPTqnyV
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 706A51F790
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
Subject: [LTP] [PATCH v4 6/8] Add ioctl_pidfd04 test
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |  1 +
 testcases/kernel/syscalls/ioctl/.gitignore      |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c | 71 +++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 7e019675216a59919b137b84b023ebb2969efcdb..3d0789bee7d4723f6af549eace1e14e358e17220 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -616,6 +616,7 @@ ioctl_fiemap01 ioctl_fiemap01
 ioctl_pidfd01 ioctl_pidfd01
 ioctl_pidfd02 ioctl_pidfd02
 ioctl_pidfd03 ioctl_pidfd03
+ioctl_pidfd04 ioctl_pidfd04
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 393ec47fecaed101f413284f28646aeff76cc30b..b92cb5d33fe05652874c5ba4027c8521528f8ecc 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -33,3 +33,4 @@
 /ioctl_pidfd01
 /ioctl_pidfd02
 /ioctl_pidfd03
+/ioctl_pidfd04
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c
new file mode 100644
index 0000000000000000000000000000000000000000..e5f582414acce8158aaf487d38b74f137f8f3088
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c
@@ -0,0 +1,71 @@
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
+	SAFE_CLOSE(pidfd);
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
+	if (!ioctl_pidfd_info_exit_supported())
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
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
