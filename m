Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1F4C3DA49
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 07:16:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 890B43D1C34
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 09:16:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E4C53D0C66
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 09:15:33 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1D155600961
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 09:15:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 508D121BBC;
 Tue, 23 Jul 2024 07:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721718932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5qZxEWdoyi/q8LdHV6xjFPgjf92xzciFvJDwac6Ox3s=;
 b=yoFeaSl+uTVur5E8D9tI1y2X2ZnOphnq4/jXHa9UtuJmxruiSIVA42Uj0BEY7t406cBPZh
 6XVfwI+zoPY379E3tPv9XZUbozTM8obenvXvbAkrTk020a3K9vi5TxpMsrm9IcyE9mVG05
 R5rCL5HQwts9aN7f/SV7WKhpqw0YnVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721718932;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5qZxEWdoyi/q8LdHV6xjFPgjf92xzciFvJDwac6Ox3s=;
 b=ZofSLfOUd7r+le5RsaGifICA/24Zxe+fDpbOrEk645GVO3tt1IYAHU7uNKQsPe7T7tqhmA
 4Rg+JeZd7DQ4RLDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yoFeaSl+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZofSLfOU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721718932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5qZxEWdoyi/q8LdHV6xjFPgjf92xzciFvJDwac6Ox3s=;
 b=yoFeaSl+uTVur5E8D9tI1y2X2ZnOphnq4/jXHa9UtuJmxruiSIVA42Uj0BEY7t406cBPZh
 6XVfwI+zoPY379E3tPv9XZUbozTM8obenvXvbAkrTk020a3K9vi5TxpMsrm9IcyE9mVG05
 R5rCL5HQwts9aN7f/SV7WKhpqw0YnVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721718932;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5qZxEWdoyi/q8LdHV6xjFPgjf92xzciFvJDwac6Ox3s=;
 b=ZofSLfOUd7r+le5RsaGifICA/24Zxe+fDpbOrEk645GVO3tt1IYAHU7uNKQsPe7T7tqhmA
 4Rg+JeZd7DQ4RLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C5151396E;
 Tue, 23 Jul 2024 07:15:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MOXhCJRYn2bKUQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Jul 2024 07:15:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 23 Jul 2024 09:15:03 +0200
MIME-Version: 1.0
Message-Id: <20240723-ioctl_ficlone-v2-3-33075bbc117f@suse.com>
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
In-Reply-To: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3066;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=LDHxB61V9oNoZ8+2Qfxp6jEjF9u0nXNkOPouUR3gXNE=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmn1h+UKvupPlVf94OcNJ9BliqxKMqezMMKQGjl
 iGytijDlguJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp9YfgAKCRDLzBqyILPm
 Rn1HC/953lTgXw5N1MbFENEPfvi+o3fNtRTu2cAlaRmQUcy28t2UAw6pAty12w6QnQlivTCuXQS
 V1xDw4onpWOlWD+h37Kbv5s3wKT6LY7J8yePbv8rY2shEZP4ep/3xTlS+K7FZrMxYJS33LasXTl
 hziGWVeuMPBtz1XuZGC7mo3r+RdC0nkI9jjkfrpfhuKCRr3he5QnIaZh6/GoxxMAZ0/y0O9KPk6
 210aCZAOtLfzKWlLHvmaYjt0nyrdfcKD9RchWDgVxNCYctvh0sf/OKlHTvhl6P5pTwqXWIFUC1X
 NRLOpHWWsdgO1GuovL/Wxt5irv17aZPb9Tv+RcYh1zW4fJiycvMb+s1so3Y3FOaaJZ6JLveT2fA
 E4B6nOz/9LZ8hfOV2oW82DLH3cIbcBGcgKA7s40WoU4p4P0V8hJ7HV8Xyz5xGZUd8zWuk2ikXBh
 8gqt9o88Yr6bhJpFaCE9reUs/Mis8Pw4Qev8mnMnADvm7lptDbjarfGLj2xVQwhWvDyBs=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-3.31 / 50.00];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 508D121BBC
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/7] Add ioctl_ficlone02 test
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

This test verifies that ioctl() FICLONE/FICLONERANGE feature
correctly raises EOPNOTSUPP when unsupported filesystem is used.
In particular, filesystems which don't support copy-on-write.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/ioctl/.gitignore        |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c | 70 +++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index f05386ba2..48fe85c97 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -593,6 +593,7 @@ ioctl_ns07 ioctl_ns07
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
index 000000000..f6d492026
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that ioctl() FICLONE/FICLONERANGE feature correctly raises
+ * EOPNOTSUPP when an unsupported filesystem is used. In particular, filesystems
+ * which don't support copy-on-write.
+ */
+
+#include "tst_test.h"
+#include "lapi/fs.h"
+
+#define MNTPOINT "mnt"
+#define SRCPATH MNTPOINT "/file0"
+#define DSTPATH MNTPOINT "/file1"
+
+static struct file_clone_range *clone_range;
+
+static void run(void)
+{
+	int src_fd;
+	int dst_fd;
+
+	src_fd = SAFE_OPEN(SRCPATH, O_CREAT | O_RDWR, 0640);
+	dst_fd = SAFE_OPEN(DSTPATH, O_CREAT | O_RDWR, 0640);
+
+	clone_range->src_fd = src_fd;
+
+	TST_EXP_FAIL(ioctl(dst_fd, FICLONE, src_fd), EOPNOTSUPP);
+	TST_EXP_FAIL(ioctl(dst_fd, FICLONERANGE, clone_range), EOPNOTSUPP);
+
+	SAFE_CLOSE(src_fd);
+	SAFE_CLOSE(dst_fd);
+}
+
+static void setup(void)
+{
+	struct stat sb;
+
+	SAFE_STAT(MNTPOINT, &sb);
+
+	clone_range->src_offset = 0;
+	clone_range->src_length = sb.st_blksize;
+	clone_range->dest_offset = 0;
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
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
+	.bufs = (struct tst_buffers []) {
+		{&clone_range, .size = sizeof(struct file_clone_range)},
+		{},
+	}
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
