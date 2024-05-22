Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE98FC25B78
	for <ltp@archiver.kernel.org>; Wed, 22 May 2024 14:34:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C901E3D0133
	for <ltp@archiver.kernel.org>; Wed, 22 May 2024 16:34:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92F9D3D00F0
 for <ltp@lists.linux.it>; Wed, 22 May 2024 16:33:45 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5E03C10028A0
 for <ltp@lists.linux.it>; Wed, 22 May 2024 16:33:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 96CE422C61;
 Wed, 22 May 2024 14:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716388423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PaRMMJ4mn1Doa/ltcnkHOFghXliPYLg2Cf14jF+rDgg=;
 b=cU+nkqOg6Uczmbd2mtsL4ouIW+qExMKODSbmrEk+4hZ68b0uEZToI1V8Hdk2vvXs8sGc8f
 TNgwBUL25QlYDNhhQe766hInNAGUBkQ6Sn4d6sFtDBrfuXE0mrRt6ijrUt0TeaBmbaXBOg
 SvXsAAQoqXMMc4P6vBVS04g0Ot0C2SQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716388423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PaRMMJ4mn1Doa/ltcnkHOFghXliPYLg2Cf14jF+rDgg=;
 b=1CBjmrRuOfjNr8KVbLPkgKmKQ7f/NLMXIQlOeKXbDiAioxvkGFKT1Q2MIy5LbWV2w8vKx3
 GB3M6G9h5N8k3PCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cU+nkqOg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1CBjmrRu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716388423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PaRMMJ4mn1Doa/ltcnkHOFghXliPYLg2Cf14jF+rDgg=;
 b=cU+nkqOg6Uczmbd2mtsL4ouIW+qExMKODSbmrEk+4hZ68b0uEZToI1V8Hdk2vvXs8sGc8f
 TNgwBUL25QlYDNhhQe766hInNAGUBkQ6Sn4d6sFtDBrfuXE0mrRt6ijrUt0TeaBmbaXBOg
 SvXsAAQoqXMMc4P6vBVS04g0Ot0C2SQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716388423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PaRMMJ4mn1Doa/ltcnkHOFghXliPYLg2Cf14jF+rDgg=;
 b=1CBjmrRuOfjNr8KVbLPkgKmKQ7f/NLMXIQlOeKXbDiAioxvkGFKT1Q2MIy5LbWV2w8vKx3
 GB3M6G9h5N8k3PCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DD6413A7A;
 Wed, 22 May 2024 14:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UAE3GEcCTmaJOwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 22 May 2024 14:33:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 22 May 2024 16:33:07 +0200
MIME-Version: 1.0
Message-Id: <20240522-process_mrelease-v1-3-41fe2fa44194@suse.com>
References: <20240522-process_mrelease-v1-0-41fe2fa44194@suse.com>
In-Reply-To: <20240522-process_mrelease-v1-0-41fe2fa44194@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3028;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=psyKdZf26O66aAVJMNsw/GnyuKmVkjMQWEbfqxFVqho=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmTgJGQQiL70agU1QCF9wDdmim5KX6QVdphgtJ6
 ndXVvbB/qGJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZk4CRgAKCRDLzBqyILPm
 RhvfDACPbZ3P8+VW2x2duPcuk5HccQYShRaf/tR91edlxQNe8aANDqW/+f9nEtlRzwZJykR2Rg3
 WLA1f32AH8OfCfLKhrrN5EA0NUCWgxkRKZSMNWM8Bhyfe8rGdslWe4w/gF1/XGJQqNuRb0F6umR
 wYxrnyWpbc5Sr/rr8ruoz6KRfn6woCh61CoaR3s+sJy0h83DpYoyeDwUATJUmgjyF0/EuVJxr98
 TLkgkI6n15A4/nyMTmuYMmhx07tWrSo/vgomcOcwimwN8P9TTfG7l+qZbjGYk+XdoPBWQQRJG5O
 CKPfdEUXuVctcRegwOEKgUjObxNEHKPol1MJXtlBaUwkzDkK6OqjBvY+BmRJVdvYAsmk0PMcuFB
 XQ1nI1nwLpjauM/tqKi0SIXF/HH+roATKW+1FPtkY+XQrObJMgd9GMpPYdaKi68TwChdysfRGij
 txkHrZN90xUIHEXdjOL7fl4Kd5RdSaGKY4UCcns1MWF885l2xusmj4I2DXGlOsQkKE1XM=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 96CE422C61
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] Add process_mrelease02 test
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

This test verifies that process_mrelease() syscall correctly raises
the errors.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  1 +
 .../kernel/syscalls/process_mrelease/.gitignore    |  1 +
 .../syscalls/process_mrelease/process_mrelease02.c | 75 ++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 46a85fd31..c2fe919f0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1051,6 +1051,7 @@ preadv203_64 preadv203_64
 profil01 profil01
 
 process_mrelease01 process_mrelease01
+process_mrelease02 process_mrelease02
 
 process_vm_readv01 process_vm01 -r
 process_vm_readv02 process_vm_readv02
diff --git a/testcases/kernel/syscalls/process_mrelease/.gitignore b/testcases/kernel/syscalls/process_mrelease/.gitignore
index 673983858..f1e7a8fea 100644
--- a/testcases/kernel/syscalls/process_mrelease/.gitignore
+++ b/testcases/kernel/syscalls/process_mrelease/.gitignore
@@ -1 +1,2 @@
 /process_mrelease01
+/process_mrelease02
diff --git a/testcases/kernel/syscalls/process_mrelease/process_mrelease02.c b/testcases/kernel/syscalls/process_mrelease/process_mrelease02.c
new file mode 100644
index 000000000..ac13317ee
--- /dev/null
+++ b/testcases/kernel/syscalls/process_mrelease/process_mrelease02.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that process_mrelease() syscall is raising errors:
+ * * EBADF when a bad file descriptor is given
+ * * EINVAL when flags is not zero
+ * * EINVAL when memory of a task cannot be released because it's still running
+ */
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+static int badfd = -1;
+static int pidfd;
+
+static struct tcase {
+	int needs_child;
+	int *fd;
+	int flags;
+	int exp_errno;
+	char *msg;
+} tcases[] = {
+	{0, &badfd,  0, EBADF,  "bad file descriptor"},
+	{1, &pidfd, -1, EINVAL, "flags is not 0"},
+	{1, &pidfd,  0, EINVAL,  "memory of running task cannot be released"},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	if (tc->needs_child) {
+		pid_t pid;
+
+		pid = SAFE_FORK();
+		if (!pid) {
+			tst_res(TINFO, "Keep child alive");
+
+			TST_CHECKPOINT_WAKE_AND_WAIT(0);
+			exit(0);
+		}
+
+		TST_CHECKPOINT_WAIT(0);
+
+		pidfd = SAFE_PIDFD_OPEN(pid, 0);
+	}
+
+	TST_EXP_FAIL(tst_syscall(__NR_process_mrelease, *tc->fd, tc->flags),
+		tc->exp_errno,
+		"%s", tc->msg);
+
+	if (tc->needs_child) {
+		SAFE_CLOSE(pidfd);
+
+		TST_CHECKPOINT_WAKE(0);
+	}
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.forks_child = 1,
+	.min_kver = "5.15",
+	.needs_checkpoints = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_MMU=y",
+		NULL,
+	},
+};

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
