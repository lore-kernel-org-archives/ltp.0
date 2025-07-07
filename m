Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D40C8303C
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 17:08:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 971D43C9E0F
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 19:08:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D97A3CA111
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 19:06:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B20F91400F52
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 19:06:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A40CC2115F;
 Mon,  7 Jul 2025 17:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751907955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9f00wpk9r8/bSP9+xUj8FrqJIZzyrK52qAKj/Jcq8ZE=;
 b=opAPct3mQakPZMIFsjClFsaoxMcHNQf/gEY1C3Oi9WqEEdG/Zzg62b6Dryvcfp9V4+QP5T
 Ph5xZxXfcBfsG2wMC/XyOfphuhjiYP2NCK7KIpQXNxsUUjsmqW9sBufxNRdKHe+C+BnJs3
 0Hfb6wqtd233h+Eh9YL2AdZPGS2mvaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751907955;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9f00wpk9r8/bSP9+xUj8FrqJIZzyrK52qAKj/Jcq8ZE=;
 b=0sFNnakduUT/wFBNneEG43ZxnGbyB7516jXgYfP6R7O7uQ24bQAQieqjU4zcBLsxbdNLKC
 CQMaNd2xE60mbCCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=opAPct3m;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0sFNnakd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751907955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9f00wpk9r8/bSP9+xUj8FrqJIZzyrK52qAKj/Jcq8ZE=;
 b=opAPct3mQakPZMIFsjClFsaoxMcHNQf/gEY1C3Oi9WqEEdG/Zzg62b6Dryvcfp9V4+QP5T
 Ph5xZxXfcBfsG2wMC/XyOfphuhjiYP2NCK7KIpQXNxsUUjsmqW9sBufxNRdKHe+C+BnJs3
 0Hfb6wqtd233h+Eh9YL2AdZPGS2mvaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751907955;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9f00wpk9r8/bSP9+xUj8FrqJIZzyrK52qAKj/Jcq8ZE=;
 b=0sFNnakduUT/wFBNneEG43ZxnGbyB7516jXgYfP6R7O7uQ24bQAQieqjU4zcBLsxbdNLKC
 CQMaNd2xE60mbCCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E43B13A5E;
 Mon,  7 Jul 2025 17:05:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6JoxBXP+a2g/YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 07 Jul 2025 17:05:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 07 Jul 2025 19:05:49 +0200
MIME-Version: 1.0
Message-Id: <20250707-ioctl_pidfd_suite-v3-8-22ba4d15ee02@suse.com>
References: <20250707-ioctl_pidfd_suite-v3-0-22ba4d15ee02@suse.com>
In-Reply-To: <20250707-ioctl_pidfd_suite-v3-0-22ba4d15ee02@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751907947; l=3165;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=QBbjeynvYiFR0tBmJheO4aZc7/jqbkfZhOdvvoYlHbM=;
 b=RC6ZubVavS8yekRI44hrMMK9DFDxESfnfqZiqlByo64yXx+DGXvSNYSecg59y1OhhqcaFsdin
 S2H74og2mpeC3Um8YFGNfQXNpCofDadUn8RMMQZFY2zqKoTu9CQgOys
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: A40CC2115F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 8/8] Add ioctl_pidfd06 test
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |  1 +
 testcases/kernel/syscalls/ioctl/.gitignore      |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c | 64 +++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 91908312df82f677e6fa711653b56de8e5ccf016..dd4e92da286c1683807abdd35f271e37fa796bef 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -617,6 +617,7 @@ ioctl_pidfd02 ioctl_pidfd02
 ioctl_pidfd03 ioctl_pidfd03
 ioctl_pidfd04 ioctl_pidfd04
 ioctl_pidfd05 ioctl_pidfd05
+ioctl_pidfd06 ioctl_pidfd06
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 4658173eac337a8e9cae1844340f9ecc0e55218f..396fe62da37246e0d32f469a519dae98b4fab3d9 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -34,3 +34,4 @@
 /ioctl_pidfd03
 /ioctl_pidfd04
 /ioctl_pidfd05
+/ioctl_pidfd06
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
new file mode 100644
index 0000000000000000000000000000000000000000..7bc0b2c55d5d81e146b10decc2517754c64a9a78
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
@@ -0,0 +1,64 @@
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
