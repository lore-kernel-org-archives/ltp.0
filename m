Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCDBC83F03
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 11:32:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 430793C9ECF
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 13:32:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 365AB3C9F6C
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 13:30:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AACA910008F2
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 13:30:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 50304211B8;
 Fri,  4 Jul 2025 11:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751628651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Bw8z60jD5KFOIx/UEtpj+jqcKpxVcuDUaF1q2rK0jU=;
 b=CqPCI7ER53GoyyVa4cz669OtRG3IXUuxzRaW84bvE7bxGpTOrM+A+CpZrD2UVQuDc1xFLf
 eEpd9lV6bUPwqQqdfUYU8aeTZLBUwQtEY0jNja+QPU6qTfgIG/TFyisaFhorIy1IPP2+x6
 7zwt+rpcya5kqHY2raEDQ5JyxMhPlH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751628651;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Bw8z60jD5KFOIx/UEtpj+jqcKpxVcuDUaF1q2rK0jU=;
 b=e+Pm0bjNpy/xkAfYLqFsIKYsIk7yhgAT6ZyZtrmoZnhmcV2SEAtrSA/7e51CInV23iQvbh
 pBFwSTXbxpE2gvDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CqPCI7ER;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=e+Pm0bjN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751628651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Bw8z60jD5KFOIx/UEtpj+jqcKpxVcuDUaF1q2rK0jU=;
 b=CqPCI7ER53GoyyVa4cz669OtRG3IXUuxzRaW84bvE7bxGpTOrM+A+CpZrD2UVQuDc1xFLf
 eEpd9lV6bUPwqQqdfUYU8aeTZLBUwQtEY0jNja+QPU6qTfgIG/TFyisaFhorIy1IPP2+x6
 7zwt+rpcya5kqHY2raEDQ5JyxMhPlH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751628651;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Bw8z60jD5KFOIx/UEtpj+jqcKpxVcuDUaF1q2rK0jU=;
 b=e+Pm0bjNpy/xkAfYLqFsIKYsIk7yhgAT6ZyZtrmoZnhmcV2SEAtrSA/7e51CInV23iQvbh
 pBFwSTXbxpE2gvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEE8113757;
 Fri,  4 Jul 2025 11:30:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GMdWLmq7Z2iTRQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Jul 2025 11:30:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Jul 2025 13:30:45 +0200
MIME-Version: 1.0
Message-Id: <20250704-ioctl_pidfd_suite-v2-7-88a6466d9f62@suse.com>
References: <20250704-ioctl_pidfd_suite-v2-0-88a6466d9f62@suse.com>
In-Reply-To: <20250704-ioctl_pidfd_suite-v2-0-88a6466d9f62@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751628642; l=3030;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=z4e1Aown7MRAX3cYhGFhxJe2z3Oa6fUZBUvQVC33huw=;
 b=0Dh9Xr6QIw7Isd5WNiRnH+vW56A2S+uJEaJivOHtwrDVe3qEK0KYZhM0WO8tnrT/K29l+75Pr
 oz9ZKr/DU0uAWWKrKFRA/VXE6wsrzitxJNxydHQOczaCbG5+gzqvnO+
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 50304211B8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 7/8] Add ioctl_pidfd05 test
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

Verify that ioctl() raises an EINVAL error when PIDFD_GET_INFO
is used. This happens when:

- info parameter is NULL
- info parameter is providing the wrong size

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |  1 +
 testcases/kernel/syscalls/ioctl/.gitignore      |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c | 58 +++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index a28f4857ffccc070665361f2741ddbaa480d1153..91908312df82f677e6fa711653b56de8e5ccf016 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -616,6 +616,7 @@ ioctl_pidfd01 ioctl_pidfd01
 ioctl_pidfd02 ioctl_pidfd02
 ioctl_pidfd03 ioctl_pidfd03
 ioctl_pidfd04 ioctl_pidfd04
+ioctl_pidfd05 ioctl_pidfd05
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index b6203828f324647ccf5d809e80e2ada515817006..4658173eac337a8e9cae1844340f9ecc0e55218f 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -33,3 +33,4 @@
 /ioctl_pidfd02
 /ioctl_pidfd03
 /ioctl_pidfd04
+/ioctl_pidfd05
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
new file mode 100644
index 0000000000000000000000000000000000000000..c5bec82f12a067283c7ea286f36b6f651c8f1ffd
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that ioctl() raises an EINVAL error when PIDFD_GET_INFO is used. This
+ * happens when:
+ *
+ * - info parameter is NULL
+ * - info parameter is providing the wrong size
+ */
+
+#include "tst_test.h"
+#include "lapi/pidfd.h"
+#include "lapi/sched.h"
+#include "lapi/ioctl.h"
+
+struct pidfd_info_invalid {
+	uint32_t dummy;
+};
+
+#define PIDFD_GET_INFO_SHORT _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info_invalid)
+
+static struct tst_clone_args *args;
+static struct pidfd_info_invalid *info_invalid;
+
+static void run(void)
+{
+	int pidfd = 0;
+	pid_t pid_child;
+
+	memset(args, 0, sizeof(struct tst_clone_args));
+
+	info_invalid->dummy = 1;
+
+	args->flags = CLONE_PIDFD | CLONE_NEWUSER | CLONE_NEWPID;
+	args->pidfd = (uint64_t)&pidfd;
+	args->exit_signal = SIGCHLD;
+
+	pid_child = SAFE_CLONE(args);
+	if (!pid_child)
+		exit(0);
+
+	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, NULL), EINVAL);
+	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid), EINVAL);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.min_kver = "6.15",
+	.bufs = (struct tst_buffers []) {
+		{&args, .size = sizeof(*args)},
+		{&info_invalid, .size = sizeof(*info_invalid)},
+		{}
+	}
+};

-- 
2.50.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
