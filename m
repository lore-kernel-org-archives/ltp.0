Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D09C8303D
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 11:33:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C984D3C9EB8
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 13:33:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81D643C9EF8
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 13:31:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E98E46002BB
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 13:31:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 45C3D1F74A;
 Fri,  4 Jul 2025 11:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751628649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LjuKM4xaT3q3GRVCZ3HhJLR3vcK7RJJ3WJF0rcchYRk=;
 b=SoxKSKStDcyxakSUyt+UMLTTNRbhvGQISTQ9TsyG5abuTM4Xzcr2IQ/NhZ3lenyGR3DI2V
 N24m7OZtmQhuaeCjqDUgQzRCqDc1kKNvDEjzrUibuLHDZyPjymprH08oTAo0UcwREIz9Hh
 cCRpvgjQquKqfNv7oLnLXutDPbz3IiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751628649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LjuKM4xaT3q3GRVCZ3HhJLR3vcK7RJJ3WJF0rcchYRk=;
 b=iaijto5rMB5ObuF2uBSe25skG7GZd+67aLg7VTlQiiLn+DFPsqKdzbc6XDWQXByh3/dhzc
 pbpt7sqWsSo1YRDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SoxKSKSt;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iaijto5r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751628649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LjuKM4xaT3q3GRVCZ3HhJLR3vcK7RJJ3WJF0rcchYRk=;
 b=SoxKSKStDcyxakSUyt+UMLTTNRbhvGQISTQ9TsyG5abuTM4Xzcr2IQ/NhZ3lenyGR3DI2V
 N24m7OZtmQhuaeCjqDUgQzRCqDc1kKNvDEjzrUibuLHDZyPjymprH08oTAo0UcwREIz9Hh
 cCRpvgjQquKqfNv7oLnLXutDPbz3IiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751628649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LjuKM4xaT3q3GRVCZ3HhJLR3vcK7RJJ3WJF0rcchYRk=;
 b=iaijto5rMB5ObuF2uBSe25skG7GZd+67aLg7VTlQiiLn+DFPsqKdzbc6XDWQXByh3/dhzc
 pbpt7sqWsSo1YRDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96F0B13757;
 Fri,  4 Jul 2025 11:30:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QH0fFGi7Z2iTRQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Jul 2025 11:30:48 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Jul 2025 13:30:43 +0200
MIME-Version: 1.0
Message-Id: <20250704-ioctl_pidfd_suite-v2-5-88a6466d9f62@suse.com>
References: <20250704-ioctl_pidfd_suite-v2-0-88a6466d9f62@suse.com>
In-Reply-To: <20250704-ioctl_pidfd_suite-v2-0-88a6466d9f62@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751628642; l=3065;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Ki4BE6Ptzym4bAqezzoWecOWhdzy5a13BLK63GKZpJo=;
 b=7vP5gjpN7BHDaTDwUoUYlw39/uG+6rv2ks+9K5/mqqYqsu5JKvAunY5/tTmw6XWhwZM5Xp1lc
 T4qzvte4ES3BsG7OEzP0ktHSZ3R5ux0fOJxmsoI2fuaBxQLV0Jf0thh
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 45C3D1F74A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/8] Add ioctl_pidfd03 test
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

Verify that ioctl() returns ESRCH when a process attempts to access
the exit status of an isolated child using `PIDFD_GET_INFO` and
`PIDFD_INFO_EXIT` is not defined in `struct pidfd_info`.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |  1 +
 testcases/kernel/syscalls/ioctl/.gitignore      |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c | 57 +++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 23f335846663d62a39e6de3a8f6948c1b0acf8a5..8eec613a941a83b1fed25f96cdce617da0b0ef34 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -614,6 +614,7 @@ ioctl_fiemap01 ioctl_fiemap01
 
 ioctl_pidfd01 ioctl_pidfd01
 ioctl_pidfd02 ioctl_pidfd02
+ioctl_pidfd03 ioctl_pidfd03
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 1c81c2bed8db952af0c93fb1ce5bfbad82794b60..08387dc8f2bc43f8f3a75264841da4beee28bfac 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -31,3 +31,4 @@
 /ioctl_fiemap01
 /ioctl_pidfd01
 /ioctl_pidfd02
+/ioctl_pidfd03
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c
new file mode 100644
index 0000000000000000000000000000000000000000..17cc9eb1bf60024a78e2be9bf15ae186a987b358
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that ioctl() returns ESRCH when a process attempts to access the
+ * exit status of an isolated child using `PIDFD_GET_INFO` and
+ * `PIDFD_INFO_EXIT` is not defined in `struct pidfd_info`.
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
+	if (!pid_child)
+		exit(100);
+
+	info->mask = 0;
+
+	/* child is not reaped, so ioctl() will pass */
+	SAFE_IOCTL(pidfd, PIDFD_GET_INFO, info);
+	TST_EXP_EQ_LI(info->mask & PIDFD_INFO_EXIT, 0);
+
+	SAFE_WAITPID(pid_child, &status, 0);
+
+	/* child is now reaped, so we get ESRCH */
+	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, info), ESRCH);
+	TST_EXP_EQ_LI(info->mask & PIDFD_INFO_EXIT, 0);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
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
