Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4D2C3DA49
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 07:16:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 415113D0C66
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 09:16:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 509443CC2E7
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 09:15:34 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B11B91405141
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 09:15:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A52F1F807;
 Tue, 23 Jul 2024 07:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721718932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sto91udM28HY+m14d9S53g/gYPf/4FuEhrcXEX6dbt0=;
 b=uc3mPb/CaXp6k4gBGhhZ2gAbu8U85jGXB+m+iOoc2w7rK6daRcWHkY6FcmpnRKyjmfz2k3
 yVV0E873a2xUTezsDskB7RuzowBeDCra0vX9BfWybQDmM1LgB9AVNKOyIrTeswpEwcWx+w
 H5leyiByZpUezpDoB116VJTqaEGimk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721718932;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sto91udM28HY+m14d9S53g/gYPf/4FuEhrcXEX6dbt0=;
 b=SAoQDS5OoOhqZ9yL3/UHbBrkr61OBhPO0TnGHX/wK9VijCXL1qh7W9XWsmRwsGotteHFRX
 h/1sU4ysFdUtbKCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721718932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sto91udM28HY+m14d9S53g/gYPf/4FuEhrcXEX6dbt0=;
 b=uc3mPb/CaXp6k4gBGhhZ2gAbu8U85jGXB+m+iOoc2w7rK6daRcWHkY6FcmpnRKyjmfz2k3
 yVV0E873a2xUTezsDskB7RuzowBeDCra0vX9BfWybQDmM1LgB9AVNKOyIrTeswpEwcWx+w
 H5leyiByZpUezpDoB116VJTqaEGimk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721718932;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sto91udM28HY+m14d9S53g/gYPf/4FuEhrcXEX6dbt0=;
 b=SAoQDS5OoOhqZ9yL3/UHbBrkr61OBhPO0TnGHX/wK9VijCXL1qh7W9XWsmRwsGotteHFRX
 h/1sU4ysFdUtbKCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CDB913874;
 Tue, 23 Jul 2024 07:15:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aKWwFJRYn2bKUQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Jul 2024 07:15:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 23 Jul 2024 09:15:04 +0200
MIME-Version: 1.0
Message-Id: <20240723-ioctl_ficlone-v2-4-33075bbc117f@suse.com>
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
In-Reply-To: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4533;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=WUxOVIjCXPYVfWzBUOlajaotdBMyrDT6nKAb1/u07gc=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmn1h+R+XNa6zyNhfaYDOn4BdHFkFndwUFiyssR
 mZBE2FtD8yJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp9YfgAKCRDLzBqyILPm
 Ro+1C/9zKcTJV9CptA/fV7+WS81K0D8ok+nVF6BIgbEYiMuaYHOoKqrDtGEbKpiwiRJ1yZJKTWz
 ucBbMpryGa7EXjatepnhv5/bm8j6tnDBxMkBUjbnfsqX4raj9zawF5GddrINbdYqUMo1oiwjQmT
 Sa8WZc/mpDryd4SVr5vPjySdKfDnGM6gD1LNKprwFAVpcP+bos08K6Ia2SNLrEH1LNgXJndhwy2
 BaAkrtnLBiM32qnTF2SxFwkpO+T2JLFREVQ6g8+yEIlIMt5WaKe9pyh8IbPxypWo9+fdxVU7yCl
 j1nnLGUPgpCxk+iWOb5tbPP1DUbVgYdxmkfOLe9+kmEeL9EjdneoxkvmqpdTU+QNnT0ehQ2y+mc
 WhxWpeYMmm8wNsTg3HGCmAJzMkd+grHyoIs4ccICwUv94mHVKWmQriMAPFQXBujz20VvIfTrGqg
 hHSggzL9gMSXwfjigYU4+++spXTikH82aIMx4PU7vVMSyEWSLb/kSEFGDmRi/MuUaKiEw=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.10 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/7] Add ioctl_ficlone03 test
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

This test verifies that ioctl() FICLONE/FICLONERANGE feature correctly
raises exceptions when it's supposed to.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |   1 +
 testcases/kernel/syscalls/ioctl/.gitignore        |   1 +
 testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c | 124 ++++++++++++++++++++++
 3 files changed, 126 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 48fe85c97..5aef2b97e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -594,6 +594,7 @@ ioctl_sg01 ioctl_sg01
 
 ioctl_ficlone01 ioctl_ficlone01
 ioctl_ficlone02 ioctl_ficlone02
+ioctl_ficlone03 ioctl_ficlone03
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 3d25fdfb2..d0b470714 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -24,3 +24,4 @@
 /ioctl_sg01
 /ioctl_ficlone01
 /ioctl_ficlone02
+/ioctl_ficlone03
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
new file mode 100644
index 000000000..be069836a
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that ioctl() FICLONE/FICLONERANGE feature correctly raises
+ * exceptions when it's supposed to.
+ */
+
+#include "tst_test.h"
+#include "lapi/fs.h"
+
+#define MNTPOINT "mnt"
+
+static struct file_clone_range *clone_range;
+
+static int invalid_fd = -1;
+static int rw_file = -1;
+static int ro_file = -1;
+static int wo_file = -1;
+static int dir_fd = -1;
+static int immut_fd = -1;
+static int mnt_file = -1;
+
+static struct tcase {
+	int *src_fd;
+	int *dst_fd;
+	int errno_exp;
+	char *msg;
+} tcases[] = {
+	{&invalid_fd, &rw_file, EBADF, "invalid source"},
+	{&rw_file, &invalid_fd, EBADF, "invalid destination"},
+	{&rw_file, &ro_file, EBADF, "read-only destination"},
+	{&wo_file, &rw_file, EBADF, "write-only source"},
+	{&rw_file, &dir_fd, EISDIR, "source is a directory"},
+	{&dir_fd, &rw_file, EISDIR, "destination is a directory"},
+	{&rw_file, &immut_fd, EPERM, "destination is immutable"},
+	{&rw_file, &mnt_file, EXDEV, "destination is on a different mount"},
+	{&mnt_file, &rw_file, EXDEV, "source is on a different mount"},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TST_EXP_FAIL(ioctl(*tc->dst_fd, FICLONE, *tc->src_fd),
+		tc->errno_exp,
+		"%s", tc->msg);
+
+	clone_range->src_fd = *tc->src_fd;
+
+	TST_EXP_FAIL(ioctl(*tc->dst_fd, FICLONERANGE, clone_range),
+		tc->errno_exp,
+		"%s", tc->msg);
+}
+
+static void setup(void)
+{
+	int attr;
+	struct stat sb;
+
+	rw_file = SAFE_OPEN("ok_only", O_CREAT | O_RDWR, 0640);
+	ro_file = SAFE_OPEN("rd_only", O_CREAT | O_RDONLY, 0640);
+	wo_file = SAFE_OPEN("rw_only", O_CREAT | O_WRONLY, 0640);
+
+	if (access("mydir", F_OK) == -1)
+		SAFE_MKDIR("mydir", 0640);
+
+	dir_fd = SAFE_OPEN("mydir", O_DIRECTORY, 0640);
+
+	attr = FS_IMMUTABLE_FL;
+	immut_fd = SAFE_OPEN("immutable", O_CREAT | O_RDWR, 0640);
+	SAFE_IOCTL(immut_fd, FS_IOC_SETFLAGS, &attr);
+
+	mnt_file = SAFE_OPEN(MNTPOINT"/file", O_CREAT | O_RDWR, 0640);
+
+	SAFE_STAT(MNTPOINT, &sb);
+
+	clone_range->src_offset = 0;
+	clone_range->src_length = sb.st_blksize;
+	clone_range->dest_offset = 0;
+}
+
+static void cleanup(void)
+{
+	int attr;
+
+	SAFE_IOCTL(immut_fd, FS_IOC_GETFLAGS, &attr);
+	attr &= ~FS_IMMUTABLE_FL;
+	SAFE_IOCTL(immut_fd, FS_IOC_SETFLAGS, &attr);
+	SAFE_CLOSE(immut_fd);
+
+	SAFE_CLOSE(rw_file);
+	SAFE_CLOSE(ro_file);
+	SAFE_CLOSE(wo_file);
+	SAFE_CLOSE(dir_fd);
+	SAFE_CLOSE(mnt_file);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "4.5",
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.filesystems = (struct tst_fs []) {
+		{.type = "btrfs"},
+		{
+			.type = "xfs",
+			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
+		},
+		{}
+	},
+	.bufs = (struct tst_buffers []) {
+		{&clone_range, .size = sizeof(struct file_clone_range)},
+		{},
+	}
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
