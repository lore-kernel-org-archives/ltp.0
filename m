Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D75AC71130
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 17:07:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D695B3CA083
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 19:07:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BD553CA14E
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 19:05:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B0CC0600CF3
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 19:05:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0721021164;
 Mon,  7 Jul 2025 17:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751907953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5JMmik8j0PrgYSuG1UYZpegho1j80MRyeBMqNsuYnVM=;
 b=AdYzFwVISz+RZw7dAOMKUNQKtuZLlE5KoTdn0Rto2TtyaVBFIfMBAJeE8SINJYyr0JPqJ9
 wD3M99w1pWdbmbhhLgtBn5023/BksHn1OYVCelehmKL4qZd5051LmXhtBZy0QZ3E6ot200
 fhIYWMsNrvAqJ4rVQGCXMrrXRIVP6T8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751907953;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5JMmik8j0PrgYSuG1UYZpegho1j80MRyeBMqNsuYnVM=;
 b=X66ikpwTN9Yf82TgIiw8sJcdASEJ28O/36qma1C8juSleuzE3QbFQxGRwJF408IW5hkYko
 ULXJA+3B+4kZfCCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751907953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5JMmik8j0PrgYSuG1UYZpegho1j80MRyeBMqNsuYnVM=;
 b=AdYzFwVISz+RZw7dAOMKUNQKtuZLlE5KoTdn0Rto2TtyaVBFIfMBAJeE8SINJYyr0JPqJ9
 wD3M99w1pWdbmbhhLgtBn5023/BksHn1OYVCelehmKL4qZd5051LmXhtBZy0QZ3E6ot200
 fhIYWMsNrvAqJ4rVQGCXMrrXRIVP6T8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751907953;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5JMmik8j0PrgYSuG1UYZpegho1j80MRyeBMqNsuYnVM=;
 b=X66ikpwTN9Yf82TgIiw8sJcdASEJ28O/36qma1C8juSleuzE3QbFQxGRwJF408IW5hkYko
 ULXJA+3B+4kZfCCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BD3B13A5E;
 Mon,  7 Jul 2025 17:05:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ALfeCnD+a2g/YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 07 Jul 2025 17:05:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 07 Jul 2025 19:05:44 +0200
MIME-Version: 1.0
Message-Id: <20250707-ioctl_pidfd_suite-v3-3-22ba4d15ee02@suse.com>
References: <20250707-ioctl_pidfd_suite-v3-0-22ba4d15ee02@suse.com>
In-Reply-To: <20250707-ioctl_pidfd_suite-v3-0-22ba4d15ee02@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751907947; l=3947;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=1qJ8NE41y+yPPpTWzpmWKcVIuK8AMF5PsQCeTv4fYvw=;
 b=G2P2ow479ZtPP/0rxvsvzFlj/mFXpno6h/fNCzejYji3fgzXZe+HuFh9OTH5RAFFikOosVdla
 4BLxfrQJlEhD7+4OJsdlsusbx+ytlQcL8eo2Nlg1pip9/qxCJd0OMoD
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/8] Add ioctl_pidfd01 test
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
 testcases/kernel/syscalls/ioctl/ioctl_pidfd.h   | 38 ++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c | 58 +++++++++++++++++++++++++
 4 files changed, 99 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 582422ac9ca8ccae598c626a11cf6ee7c30f0e3a..7f6312ce5fa241a778d8dda7f8ee9edd0a8800e6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -612,6 +612,8 @@ ioctl_ficlonerange01 ioctl_ficlonerange01
 ioctl_ficlonerange02 ioctl_ficlonerange02
 ioctl_fiemap01 ioctl_fiemap01
 
+ioctl_pidfd01 ioctl_pidfd01
+
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
 
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 53a82bb5770ba196811965150fd262ec5d4a6e01..aa952c1a7bae0ae2dbb04de0595f10d508b6759a 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -29,3 +29,4 @@
 /ioctl_ficlonerange01
 /ioctl_ficlonerange02
 /ioctl_fiemap01
+/ioctl_pidfd01
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h b/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
new file mode 100644
index 0000000000000000000000000000000000000000..1a87d90982c353d8ca75140e405b42a24be4408d
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
@@ -0,0 +1,38 @@
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
+static inline int ioctl_pidfd_supported(void)
+{
+	int ret = 0;
+	pid_t pid;
+	int pidfd;
+	struct pidfd_info info;
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
index 0000000000000000000000000000000000000000..d9231e79b15c0866bd4c965634f6b01c157da1ce
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
+	if (!ioctl_pidfd_supported())
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
2.50.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
