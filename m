Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82BFC3DA63
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 07:17:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5597B3D1C4A
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 09:17:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30A913CC2E7
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 09:15:34 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5FED31A0117A
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 09:15:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA77021996;
 Tue, 23 Jul 2024 07:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721718932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nCt4k51NgHdw8W27r8ckmBUNOz+ftqrBMqgeWwNbXO8=;
 b=ZkG+CEuf4WfDSDM/GGbj/2dvTBU5zpbrslzZWaNlj5LF0VfYtkEFZ5zkqmlONQxCQmwhw2
 qz2JAf8poz+3YV4mG8NMiFpSuWSjuc8ZCFZd7ATwKIZA5/0EzdYqK0quyePbX3NhhD/0Nj
 R775KehuysrDmfCcWiGPFkkChpP411w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721718932;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nCt4k51NgHdw8W27r8ckmBUNOz+ftqrBMqgeWwNbXO8=;
 b=c46Urj6x6EYuY5PjuNjBrD1ZvqyqdmmHRs7hVRdFTYa4bf3H8Jka+0Au55oEXBb/w1ey9G
 PxtDpaRj3e2R4iBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZkG+CEuf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=c46Urj6x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721718932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nCt4k51NgHdw8W27r8ckmBUNOz+ftqrBMqgeWwNbXO8=;
 b=ZkG+CEuf4WfDSDM/GGbj/2dvTBU5zpbrslzZWaNlj5LF0VfYtkEFZ5zkqmlONQxCQmwhw2
 qz2JAf8poz+3YV4mG8NMiFpSuWSjuc8ZCFZd7ATwKIZA5/0EzdYqK0quyePbX3NhhD/0Nj
 R775KehuysrDmfCcWiGPFkkChpP411w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721718932;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nCt4k51NgHdw8W27r8ckmBUNOz+ftqrBMqgeWwNbXO8=;
 b=c46Urj6x6EYuY5PjuNjBrD1ZvqyqdmmHRs7hVRdFTYa4bf3H8Jka+0Au55oEXBb/w1ey9G
 PxtDpaRj3e2R4iBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEB5713874;
 Tue, 23 Jul 2024 07:15:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CHm/KJRYn2bKUQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Jul 2024 07:15:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 23 Jul 2024 09:15:06 +0200
MIME-Version: 1.0
Message-Id: <20240723-ioctl_ficlone-v2-6-33075bbc117f@suse.com>
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
In-Reply-To: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3833;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=nih3vRDA29JCH0mcQgEQH3KzIjKf8XCRKAFRvxlx11E=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmn1h+mqny9Fqvhg0B4JYZvpZ2fvl4EPyvOAnJT
 W1RCeV6E6OJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp9YfgAKCRDLzBqyILPm
 RltAC/0RZGzhN1dfriQL/Z4BHU91gdw6DdgTG33pepWykinP0wezx5F4w9AZ2CVsMqOwQbiYq5T
 oInCkF32DpAeumm8rKc3JfMxhoAB33ibe9FmSzLJNinSLTOC4BwuWxOySVAJzp81PzZuqnhnVD6
 UPLx1I56cKzdNSgYikKVuM7spo5LdPhyKuTYqMfNu+5c+YdP21OXOTyQx9cbt6fm56pUcK7bhBi
 lkPbSbPn9idkIX4oLM0NUg+qrHYhLfvcR5elACJZ+BCpOaE7Hp5vlmDclxGU4gPUOHfAXdhSKif
 Q/tfnECxvjAdRc44MkUtikPVkqlO4B6DP4T72AB1W2ldR1+UxJ1/+/FV/ubHZ+Nkj+XYcfFBHVj
 /ZUrMu9xe1QUIHCwnX85HsNr3MIY744QeGcjzt4rCAMttnjeF1OSg0f1IqhW0v/NCNfkjJ5DXp6
 swvNafGynYb0IWeA+BbjJFO1wCgQNgA6gd1/tU+ApPMKQjPs5GOlS45LUoDZaUHzp6PzU=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CA77021996
X-Spamd-Result: default: False [-6.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/7] Add ioctl_ficlonerange02 test
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

This test verifies that ioctl() FICLONERANGE feature correctly raises
EINVAL when:
- filesystem does not support overlapping reflink ranges in the same file
- filesystem does not support reflinking on bad blocks alignment

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/ioctl/.gitignore         |  1 +
 .../kernel/syscalls/ioctl/ioctl_ficlonerange02.c   | 97 ++++++++++++++++++++++
 3 files changed, 99 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 1f050c5f5..4a73852e8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -596,6 +596,7 @@ ioctl_ficlone01 ioctl_ficlone01
 ioctl_ficlone02 ioctl_ficlone02
 ioctl_ficlone03 ioctl_ficlone03
 ioctl_ficlonerange01 ioctl_ficlonerange01
+ioctl_ficlonerange02 ioctl_ficlonerange02
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 08c015928..9f995b1ad 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -26,3 +26,4 @@
 /ioctl_ficlone02
 /ioctl_ficlone03
 /ioctl_ficlonerange01
+/ioctl_ficlonerange02
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c
new file mode 100644
index 000000000..24666ebcc
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that ioctl() FICLONERANGE feature correctly raises
+ * EINVAL when:
+ * - filesystem does not support overlapping reflink ranges in the same file
+ * - filesystem does not support reflinking on bad blocks alignment
+ */
+
+#include "tst_test.h"
+#include "lapi/fs.h"
+
+#define MNTPOINT "mnt"
+#define SRCPATH MNTPOINT "/file0"
+#define DSTPATH MNTPOINT "/file1"
+#define CHUNKS 10
+
+static struct file_clone_range *clone_range;
+static int filesize;
+static int alignment;
+static char *data;
+
+static void run(void)
+{
+	int src_fd;
+	int dst_fd;
+
+	src_fd = SAFE_OPEN(SRCPATH, O_CREAT | O_RDWR, 0640);
+	SAFE_WRITE(SAFE_WRITE_ALL, src_fd, data, filesize);
+	SAFE_FSYNC(src_fd);
+
+	dst_fd = SAFE_OPEN(DSTPATH, O_CREAT | O_RDWR, 0640);
+
+	clone_range->src_fd = dst_fd;
+	clone_range->src_offset = 0;
+	clone_range->src_length = filesize;
+	clone_range->dest_offset = 0;
+
+	TST_EXP_FAIL(ioctl(dst_fd, FICLONERANGE, clone_range), EINVAL,
+		"overlapping reflink ranges in the same file");
+
+	clone_range->src_fd = src_fd;
+	clone_range->src_offset = 0;
+	clone_range->src_length = alignment - 1;
+	clone_range->dest_offset = 0;
+
+	TST_EXP_FAIL(ioctl(dst_fd, FICLONERANGE, clone_range), EINVAL,
+		"bad blocks alignment");
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
+	alignment = sb.st_blksize;
+	filesize = alignment * CHUNKS;
+
+	data = (char *)SAFE_MALLOC(filesize);
+}
+
+static void cleanup(void)
+{
+	if (data)
+		free(data);
+}
+
+static struct tst_test test = {
+	.test_all = run,
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
