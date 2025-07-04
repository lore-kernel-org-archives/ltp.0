Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4872C8303D
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 11:33:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D1523C9F2C
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 13:33:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A7C93C9EBC
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 13:31:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CE04D10007AE
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 13:31:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AB09C211BF;
 Fri,  4 Jul 2025 11:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751628652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+09WnyfFU5g0CM0Qd2ZYoRKtkkCiRfqPS07Y4yvyHGI=;
 b=1DILVMroc0gUBbRcOBwU9zpokDlzA3KTjQOa9YueiPGP5l1ySzDXgJEUuKT0Loqk34ODla
 hlNdY6aJSZ4sg4hhPYcAkm2wIv3UHxr93e9McfH5Q3o+5tm8quh7y/wLN12EgaYl9xzViV
 p5visZIFGU/htykSLUJfpXOZREsTVro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751628652;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+09WnyfFU5g0CM0Qd2ZYoRKtkkCiRfqPS07Y4yvyHGI=;
 b=o5yFBI+rb7JyLuTzyoj9l2ToG03G/62o1k4Qrj2ePOXI7pDhH8IGADNhqIrZgiOS6pWcwg
 +kS5GSy9tLuxa3DA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1DILVMro;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=o5yFBI+r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751628652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+09WnyfFU5g0CM0Qd2ZYoRKtkkCiRfqPS07Y4yvyHGI=;
 b=1DILVMroc0gUBbRcOBwU9zpokDlzA3KTjQOa9YueiPGP5l1ySzDXgJEUuKT0Loqk34ODla
 hlNdY6aJSZ4sg4hhPYcAkm2wIv3UHxr93e9McfH5Q3o+5tm8quh7y/wLN12EgaYl9xzViV
 p5visZIFGU/htykSLUJfpXOZREsTVro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751628652;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+09WnyfFU5g0CM0Qd2ZYoRKtkkCiRfqPS07Y4yvyHGI=;
 b=o5yFBI+rb7JyLuTzyoj9l2ToG03G/62o1k4Qrj2ePOXI7pDhH8IGADNhqIrZgiOS6pWcwg
 +kS5GSy9tLuxa3DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABFA813757;
 Fri,  4 Jul 2025 11:30:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aNubFmu7Z2iTRQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Jul 2025 11:30:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Jul 2025 13:30:46 +0200
MIME-Version: 1.0
Message-Id: <20250704-ioctl_pidfd_suite-v2-8-88a6466d9f62@suse.com>
References: <20250704-ioctl_pidfd_suite-v2-0-88a6466d9f62@suse.com>
In-Reply-To: <20250704-ioctl_pidfd_suite-v2-0-88a6466d9f62@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751628642; l=3055;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=5ryTzOu3XQAXCbc+rnS4mzpo6OcAS5VwNd8T5bCnbIQ=;
 b=nv9GV4SsjFP6OuS7A/nvLQJWA1a/tFSPIm/TnVNjW/jFXQmXOrSTapwgp5RYO5Bf9QJFNEa5j
 +6gKIxdZXRSASfodpyg5Sbj3LmtSryDCpPDbNOc0UEDLR2fd8xDTfhQ
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: AB09C211BF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 8/8] Add ioctl_pidfd06 test
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
 testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c | 59 +++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

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
index 0000000000000000000000000000000000000000..6d77982eced49929caecc8280d7091a18aa8ac02
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
@@ -0,0 +1,59 @@
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
+#include "tst_test.h"
+#include "lapi/pidfd.h"
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
