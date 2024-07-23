Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33244C3DA63
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 07:17:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6C463D1C4E
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 09:17:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 924E33CC2E7
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 09:15:34 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F40E5201DA5
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 09:15:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F2DE81F8BD;
 Tue, 23 Jul 2024 07:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721718933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hh/dJ2f1BL+kc8udVWGZU0tzFi/R8QKyhyKIfkPSHMs=;
 b=jC3FT6S+1NK3wDYIEzlSM67LI5COn/JMja4IELqRlLEqFv6HFDNbrzy3smX8j8X2PSwqYY
 GKoSLXi9Rcuo3VuBXhgTAiMJVpY7M1wabTXQahqOqauq6wNZX0cYy+umn7wwH8f3GNQOFa
 1xeqg9D2TqN0ZTGO4bodipDE8bDrrpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721718933;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hh/dJ2f1BL+kc8udVWGZU0tzFi/R8QKyhyKIfkPSHMs=;
 b=XttJudhnywO6E/3J0BN5KbUbXH8UkpduEhaYMwvkZRyvZN5XrQRedt3GMAqitCrKjRH6jx
 paU/3dzfxtPpRvDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721718932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hh/dJ2f1BL+kc8udVWGZU0tzFi/R8QKyhyKIfkPSHMs=;
 b=koizE1ymD0QR95W+OQl60AgkzTEsLzXvix7Bx+tG3mrfvhA4b+oEsN4sPJvbLYRuZSI9r6
 p0XZqIvfwOGxW2HhR6XojcqfJ/wtQCCaU7+gekbhjGgdp7mWweu22hCwA5FRKnjckSpdkV
 mzpIXQLjo6n1NIqfQNOPPp8qzDigo4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721718932;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hh/dJ2f1BL+kc8udVWGZU0tzFi/R8QKyhyKIfkPSHMs=;
 b=fFB394ynhhM8AVnKhRoLxPSZogujKDoF/ZC86L+PkNPHq0QTSrNN9kj9+W+1vH4J+CQvAw
 7vSX7LcvTXDp5WAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D65D21393E;
 Tue, 23 Jul 2024 07:15:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ODZ4MpRYn2bKUQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Jul 2024 07:15:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 23 Jul 2024 09:15:07 +0200
MIME-Version: 1.0
Message-Id: <20240723-ioctl_ficlone-v2-7-33075bbc117f@suse.com>
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
In-Reply-To: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3302;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=KpkpQupmNbIiatHAaqliQTbObRxX5k9ZTFBuxWCjw6c=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmn1h+H5USHsjkyQcDqp86G0bBJoXXXyBKckll3
 w5f/M5d37qJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp9YfgAKCRDLzBqyILPm
 RvxDC/0f6ZS+YecWlDTCIFXw9hbuVBga9BIe1GESTE2p+U0lxaziV7Fw3T4SIyZ2vmPOxPyWeGs
 zOp2apUXithk0+t9lsKynMoF/MJlckQq4bgJoD2GLC7e0oWiIZjvx0ujJlYc0mpceVQlgySNmH2
 Xy8T/2ADRXrMw7/l2xPLVBG5fWmcnLwgKX0BcnHv3a0slRXoemDE3qAEN08freYQWqCFF1hxg4M
 wiguIn10HMw9qtv8VGlGveLMo8ZbrWiplz+nMNLXAz/SYwvqfQ/EPxUzW/wG5h7ahFh4pa0Xrzz
 YAHQL41Yq6N2+v039KjgwXr2P8Dq0aP6sgZ91uMtazfAYK0VDF6NEDmAJU7w+YcyJ6nM1invv97
 2Ynou7e3LqpAKWEpixSKvFPQIG4JWoEnCQ74OhlZWvrEiGrefLRkCFeIldi73T6qlTre2JWwuia
 FrowdHDnmRYfDsuq2UKFgR4KygHVxmALngjD45RHyqmKM/fcwg/pgcYnUp5GAlg47qIFw=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-1.10 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 7/7] Add ioctl_ficlone04 test
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

This test verifies that ioctl() FICLONE/FICLONERANGE feature raises
the right error according with bad file descriptors.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/ioctl/.gitignore        |   1 +
 testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c | 108 ++++++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 9f995b1ad..1f099ff95 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -25,5 +25,6 @@
 /ioctl_ficlone01
 /ioctl_ficlone02
 /ioctl_ficlone03
+/ioctl_ficlone04
 /ioctl_ficlonerange01
 /ioctl_ficlonerange02
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c
new file mode 100644
index 000000000..6be0b8d41
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that ioctl() FICLONE/FICLONERANGE feature raises the right
+ * error according with bad file descriptors.
+ */
+
+#include "tst_test.h"
+#include "lapi/fs.h"
+
+static void test_bad_fd(struct tst_fd *fd_src, struct tst_fd *fd_dst)
+{
+	if (fd_src->type == TST_FD_FILE && fd_src->type == fd_dst->type) {
+		tst_res(TCONF, "Skipping file: SUCCESS");
+		return;
+	}
+
+	switch (fd_src->type) {
+	case TST_FD_DEV_ZERO:
+	case TST_FD_PROC_MAPS:
+	case TST_FD_PIPE_READ:
+	case TST_FD_PIPE_WRITE:
+	case TST_FD_UNIX_SOCK:
+	case TST_FD_INET_SOCK:
+	case TST_FD_EPOLL:
+	case TST_FD_EVENTFD:
+	case TST_FD_SIGNALFD:
+	case TST_FD_TIMERFD:
+	case TST_FD_PIDFD:
+	case TST_FD_FANOTIFY:
+	case TST_FD_INOTIFY:
+	case TST_FD_USERFAULTFD:
+	case TST_FD_PERF_EVENT:
+	case TST_FD_IO_URING:
+	case TST_FD_BPF_MAP:
+	case TST_FD_FSOPEN:
+	case TST_FD_FSPICK:
+	case TST_FD_OPEN_TREE:
+	case TST_FD_MEMFD:
+	case TST_FD_MEMFD_SECRET:
+		return;
+	default:
+		break;
+	}
+
+	int exp_errnos[2];
+
+	switch (fd_src->type) {
+	case TST_FD_FILE:
+		exp_errnos[0] = 0;
+		break;
+	case TST_FD_DIR:
+		exp_errnos[0] = EISDIR;
+		break;
+	case TST_FD_PATH:
+	case TST_FD_OPEN_TREE:
+		exp_errnos[0] = EBADF;
+		break;
+	case TST_FD_DEV_ZERO:
+		exp_errnos[0] = EXDEV;
+		break;
+	default:
+		exp_errnos[0] = EINVAL;
+		break;
+	}
+
+	switch (fd_dst->type) {
+	case TST_FD_FILE:
+		exp_errnos[1] = 0;
+		break;
+	case TST_FD_DIR:
+		exp_errnos[1] = EISDIR;
+		break;
+	case TST_FD_PATH:
+	case TST_FD_OPEN_TREE:
+		exp_errnos[1] = EBADF;
+		break;
+	default:
+		exp_errnos[1] = EXDEV;
+		break;
+	}
+
+	TST_EXP_FAIL2_ARR(ioctl(fd_dst->fd, FICLONE, fd_src->fd),
+		exp_errnos, ARRAY_SIZE(exp_errnos),
+		"ioctl(%s, FICLONE, %s)",
+		tst_fd_desc(fd_src),
+		tst_fd_desc(fd_dst));
+}
+
+static void run(void)
+{
+	TST_FD_FOREACH(fd_src) {
+		TST_FD_FOREACH(fd_dst)
+			test_bad_fd(&fd_src, &fd_dst);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "4.5",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
