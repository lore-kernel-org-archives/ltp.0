Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4383CC83F17
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 14:16:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B99823CCD94
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 16:16:24 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 472923CCA3D
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 16:16:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D6B21600810
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 16:16:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E3AFE1F78F;
 Wed, 23 Jul 2025 14:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753280165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xqhPTv7AQS2NRPOkuyoJN7BwZYCxTdvP+NXmufooTGY=;
 b=zO0W96Z4Ag1PtTuHbBMawTjWt4cY6sMxgTf9lA/q8oISQVla5HO2JU8dtSNNwN/9GaJxXA
 FLHq+NWxEzVy9F1EhX14BsbBlbkllO1t7fn55S2ePpzApZuP/Y+I9TTVQ0yCQviPoUTvsH
 YzF3Gryqdqp8FiBoZ7w7myWKGSXSp74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753280165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xqhPTv7AQS2NRPOkuyoJN7BwZYCxTdvP+NXmufooTGY=;
 b=L1UF+FMvUWRBRK876IP0wldGKhnLiXr4BWCwGpZQdr1OP3lMQe9hJz6QZUZQzcBsidpElJ
 YosTvr02c0INQnAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753280164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xqhPTv7AQS2NRPOkuyoJN7BwZYCxTdvP+NXmufooTGY=;
 b=wPtKqxWFP9f/T7T8iMgwRTqCiIZN2BquX8bZ1Clbg24L0SZ0sFsw/RUJSoiKFggYE8RTWc
 f3TozQN0ZPUme2OC+4aj6Rb33xbwcP4y7zbCttqWxHg2L9hv0q5vpcJtqSlgxmbRkonnqr
 baxXbjfYL9YeCwwgVS1dX5MRxQlLpCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753280164;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xqhPTv7AQS2NRPOkuyoJN7BwZYCxTdvP+NXmufooTGY=;
 b=DJ2QbMTEiqd0iHInzq46YINFC2kPs5hnZMDFzvpgpgzLmP5m4MAUCq6/TBefrexug94Ynz
 c16iqQ9ZN4uf3xCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC90313AFA;
 Wed, 23 Jul 2025 14:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cNdPLKTugGj2LwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 23 Jul 2025 14:16:04 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 23 Jul 2025 16:15:17 +0200
MIME-Version: 1.0
Message-Id: <20250723-ioctl_pidfd_suite-v4-3-9309eacb1d8c@suse.com>
References: <20250723-ioctl_pidfd_suite-v4-0-9309eacb1d8c@suse.com>
In-Reply-To: <20250723-ioctl_pidfd_suite-v4-0-9309eacb1d8c@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753280164; l=4021;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=k2ARVvB5+WI4R55i+kZYRKS7BM39fnLB5Y1+rRaO9DU=;
 b=KxMLtbVfbfTDBnZxabO9NTms5c+jKbiKXFulHnMCwoyLgez1HI50ovrRvi5IvMynCmh7FU7L4
 HbIEYstY7z1B0kQUMI85ntz3LpxCmbglItveXDJWAX6dLwqc0iCJBRD
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/8] Add ioctl_pidfd01 test
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

Verify that ioctl() raises the right errors when an application provides
the wrong file descriptor.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |  2 +
 testcases/kernel/syscalls/ioctl/.gitignore      |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_pidfd.h   | 41 +++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c | 58 +++++++++++++++++++++++++
 4 files changed, 102 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 3531c2a3c730ac2d8e3118ea32275dc90e95c0b1..2075c5d908c04bf31fcf57bba5cdf7af3e432237 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -613,6 +613,8 @@ ioctl_ficlonerange01 ioctl_ficlonerange01
 ioctl_ficlonerange02 ioctl_ficlonerange02
 ioctl_fiemap01 ioctl_fiemap01
 
+ioctl_pidfd01 ioctl_pidfd01
+
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
 
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index d10bf0a24bbc21057f399d14aef95f814b54f58d..72d6a309ee0dcbd185a0248b9ffc79fc83b7f04f 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -30,3 +30,4 @@
 /ioctl_ficlonerange01
 /ioctl_ficlonerange02
 /ioctl_fiemap01
+/ioctl_pidfd01
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h b/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
new file mode 100644
index 0000000000000000000000000000000000000000..8249ac753cf7fb8a3b749d55c7f0c3b30482c114
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef IOCTL_PIDFD_H
+#define IOCTL_PIDFD_H
+
+#include "tst_test.h"
+#include "lapi/pidfd.h"
+
+static inline int ioctl_pidfd_info_exit_supported(void)
+{
+	int ret = 0;
+	pid_t pid;
+	int pidfd;
+	struct pidfd_info info;
+
+	if (tst_kvercmp(6, 15, 0) >= 0)
+		return 1;
+
+	memset(&info, 0, sizeof(struct pidfd_info));
+	info.mask = PIDFD_INFO_EXIT;
+
+	pid = SAFE_FORK();
+	if (!pid)
+		exit(100);
+
+	pidfd = SAFE_PIDFD_OPEN(pid, 0);
+	SAFE_WAITPID(pid, NULL, 0);
+
+	SAFE_IOCTL(pidfd, PIDFD_GET_INFO, &info);
+	SAFE_CLOSE(pidfd);
+
+	if (info.mask & PIDFD_INFO_EXIT)
+		ret = 1;
+
+	return ret;
+}
+
+#endif
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
new file mode 100644
index 0000000000000000000000000000000000000000..92c51c6c0d0dcbb2308c1a8d82b2a92650f3a6b3
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that ioctl() raises the right errors when an application provides
+ * the wrong file descriptor.
+ */
+
+#include "ioctl_pidfd.h"
+
+static int exp_errnos[] = {
+	EINVAL,
+	EBADF,
+	ENOTTY,
+};
+
+static struct pidfd_info *info;
+
+static void test_bad_pidfd(struct tst_fd *fd_in)
+{
+	if (fd_in->type == TST_FD_PIDFD) {
+		tst_res(TINFO, "Skipping pidfd: SUCCESS");
+		return;
+	}
+
+	TST_EXP_FAIL_ARR(ioctl(fd_in->fd, PIDFD_GET_INFO, info),
+		  exp_errnos, ARRAY_SIZE(exp_errnos),
+		  "ioctl(%s, PIDFD_GET_INFO, info)",
+		  tst_fd_desc(fd_in));
+}
+
+static void run(void)
+{
+	TST_FD_FOREACH(fd) {
+		tst_res(TINFO, "%s -> ...", tst_fd_desc(&fd));
+		test_bad_pidfd(&fd);
+	}
+}
+
+static void setup(void)
+{
+	if (!ioctl_pidfd_info_exit_supported())
+		tst_brk(TCONF, "PIDFD_INFO_EXIT is not supported by ioctl()");
+
+	info->mask = PIDFD_INFO_EXIT;
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.forks_child = 1,
+	.bufs = (struct tst_buffers []) {
+		{&info, .size = sizeof(*info)},
+		{}
+	}
+};

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
