Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0984CC25B78
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 07:17:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71CE53D06C7
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 09:17:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2E7B3D0652
 for <ltp@lists.linux.it>; Thu, 30 May 2024 09:15:53 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 360131A0BC36
 for <ltp@lists.linux.it>; Thu, 30 May 2024 09:15:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E1D4C20720;
 Thu, 30 May 2024 07:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717053350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d3ytGN4cUpruL5jyz/5fgSh2tlW53GFSauIUX2VUcPQ=;
 b=D0S2RbkXph1E5pybhLNRfzSRV/irzuma8hSfm8ayn5iM0umDPGR9EK3YgWwAuHnSH1qNjc
 3CYh4GADuwHhLjV92Wr6+vBNIPW/7xnARbAwF0nldEB3Z2vWoklgjOaGFLS/zKPT52d4qs
 sTgjvU9Ldfv9e6CULJi3VdDY7kpJHkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717053350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d3ytGN4cUpruL5jyz/5fgSh2tlW53GFSauIUX2VUcPQ=;
 b=/NmlXtPEEpxINFhOWP48C3xPAB7nmIA3s0dYGwAfM5Qjk/ucjjk2pi+xRjMIaiEFYWlwYG
 fd13guVRErfcu0Cw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D0S2RbkX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/NmlXtPE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717053350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d3ytGN4cUpruL5jyz/5fgSh2tlW53GFSauIUX2VUcPQ=;
 b=D0S2RbkXph1E5pybhLNRfzSRV/irzuma8hSfm8ayn5iM0umDPGR9EK3YgWwAuHnSH1qNjc
 3CYh4GADuwHhLjV92Wr6+vBNIPW/7xnARbAwF0nldEB3Z2vWoklgjOaGFLS/zKPT52d4qs
 sTgjvU9Ldfv9e6CULJi3VdDY7kpJHkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717053350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d3ytGN4cUpruL5jyz/5fgSh2tlW53GFSauIUX2VUcPQ=;
 b=/NmlXtPEEpxINFhOWP48C3xPAB7nmIA3s0dYGwAfM5Qjk/ucjjk2pi+xRjMIaiEFYWlwYG
 fd13guVRErfcu0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C994B13A8E;
 Thu, 30 May 2024 07:15:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mObnL6YnWGYfdwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 30 May 2024 07:15:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 30 May 2024 09:15:21 +0200
MIME-Version: 1.0
Message-Id: <20240530-ioctl_ficlone-v1-2-fa96f07d0fca@suse.com>
References: <20240530-ioctl_ficlone-v1-0-fa96f07d0fca@suse.com>
In-Reply-To: <20240530-ioctl_ficlone-v1-0-fa96f07d0fca@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2508;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=lvn2nf/77X6jWoD7K400EAUjSSU8hYsSdycHIGpr7sw=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmWCemOkLn3/yoPk2OiUcQH17WLFtRFX693dA1o
 GI8ioT4M+eJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZlgnpgAKCRDLzBqyILPm
 RgYhC/9ul5QZzKNlg5dwLg9XaJriVGhZ3l3PydNqLviaFyhAbra2gY3CrNu502LznCPALeizaZE
 18VOU//+6ue6AYdbZnGfIt/7JL3OnLrPQ/jgrcLmS8g64eCBnWCIGYEZg/v5Nv25C8V2V3SaKQ8
 WhQtx53GhYGM4J5+g3qtZYjDZGXk7B8F61A9OP7TKTsv8vk3bC/e/cVy/OHQ6UiEiTKntW0Atxs
 zRALkPJ0y0RCV56kU2ZrcvZcTvrWkWKBdDIeXDlmJuPWfoz+ew8V1SzaU585GbFsS+RgqWOqvCJ
 wqfCTza6RjAgpFrOPVj9bkqoGhwoPzlzY/YiMbqMiWYQucfBQ8fqTWu5+5tr83KlsdihDh24W6i
 u9GlQslDwkjyvq55pAXxQ/uRbXRy3/5S8scgYyh46kimydZAj+h5UTNeOkDtVmltzAhxLkzJnoY
 r2vlcK56mfsgF/vErMX9e7AGzgcouRftPPmJKxdOq9S3dKwy1KdRtBujJBJbpmB8xDKxI=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E1D4C20720
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] Add ioctl_ficlone02 test
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

This test verifies that ioctl() FICLONE feature correctly raises
EOPNOTSUPP when unsupported filesystem is used. In particular,
filesystems which don't support copy-on-write.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/ioctl/.gitignore        |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c | 49 +++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 07e940f8c..b049530d3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -592,6 +592,7 @@ ioctl_ns07 ioctl_ns07
 ioctl_sg01 ioctl_sg01
 
 ioctl_ficlone01 ioctl_ficlone01
+ioctl_ficlone02 ioctl_ficlone02
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 5404aa93f..3d25fdfb2 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -23,3 +23,4 @@
 /ioctl_ns07
 /ioctl_sg01
 /ioctl_ficlone01
+/ioctl_ficlone02
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
new file mode 100644
index 000000000..950b1109b
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that ioctl() FICLONE feature correctly raises EOPNOTSUPP
+ * when an unsupported filesystem is used. In particular, filesystems which
+ * don't support copy-on-write.
+ */
+
+#include "tst_test.h"
+#include "lapi/fs.h"
+
+#define MNTPOINT "mnt"
+#define SRCPATH MNTPOINT "/file0"
+#define DSTPATH MNTPOINT "/file1"
+
+static void run(void)
+{
+	int src_fd;
+	int dst_fd;
+
+	src_fd = SAFE_OPEN(SRCPATH, O_CREAT | O_RDWR, 0640);
+	dst_fd = SAFE_OPEN(DSTPATH, O_CREAT | O_RDWR, 0640);
+
+	TST_EXP_FAIL(ioctl(dst_fd, FICLONE, src_fd), EOPNOTSUPP);
+
+	SAFE_CLOSE(src_fd);
+	SAFE_CLOSE(dst_fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "4.5",
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *[]) {
+		"btrfs",
+		"overlayfs",
+		"nfs",
+		"xfs",
+		NULL,
+	},
+};

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
