Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD55C3DA5D
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 09:25:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1330C3C006F
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 11:25:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76CB63D1CA6
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 11:23:57 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8E2F61A01107
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 11:23:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3D5FB21BFC;
 Thu, 25 Jul 2024 09:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721899435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EpDZ4K/Aypl0sy0GNMY6Ky8m3zxuaBzldnvmV4SbtHQ=;
 b=L2NLeRMChO5iIFhCSTAOkCQjDnrYR/BmSqw5DCILQbDIyvk9L6Wh2B6fGVnYQzQDA8t+61
 Vv/VmVK3Kc05Oqch90PsBivjl5HPy38AFi8nHEUnKRz/WUxXjX6CF35CM1kLIXj5DyYLIk
 pOE5YWp624d8vAHAU9vV8FQw/j9pwuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721899435;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EpDZ4K/Aypl0sy0GNMY6Ky8m3zxuaBzldnvmV4SbtHQ=;
 b=6j5zvgiq59d1G//7edNUZf0aaISZuvq7ozSWVCbeu5zTmMOO6JlkrXoR6NDDFciVx1ICcA
 /E8vFxEMZ0jMJMCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=L2NLeRMC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6j5zvgiq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721899435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EpDZ4K/Aypl0sy0GNMY6Ky8m3zxuaBzldnvmV4SbtHQ=;
 b=L2NLeRMChO5iIFhCSTAOkCQjDnrYR/BmSqw5DCILQbDIyvk9L6Wh2B6fGVnYQzQDA8t+61
 Vv/VmVK3Kc05Oqch90PsBivjl5HPy38AFi8nHEUnKRz/WUxXjX6CF35CM1kLIXj5DyYLIk
 pOE5YWp624d8vAHAU9vV8FQw/j9pwuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721899435;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EpDZ4K/Aypl0sy0GNMY6Ky8m3zxuaBzldnvmV4SbtHQ=;
 b=6j5zvgiq59d1G//7edNUZf0aaISZuvq7ozSWVCbeu5zTmMOO6JlkrXoR6NDDFciVx1ICcA
 /E8vFxEMZ0jMJMCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9570713874;
 Thu, 25 Jul 2024 09:23:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wHeDIaoZombZNgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 25 Jul 2024 09:23:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 25 Jul 2024 11:23:15 +0200
MIME-Version: 1.0
Message-Id: <20240725-landlock-v4-5-66f5a1c0c693@suse.com>
References: <20240725-landlock-v4-0-66f5a1c0c693@suse.com>
In-Reply-To: <20240725-landlock-v4-0-66f5a1c0c693@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4223;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=6txYvA2yzOZhusk3xSULx/S5KGutnV2WIddXmGxIlQs=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmohmQhOONrdS6sfffSjDTWomEhDl2un7UCftIy
 jLJ6yCtnYSJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqIZkAAKCRDLzBqyILPm
 RiKfDACJQZDu+dPZwlXFcLNC27XActViBorRfzl4/W8GM6BJuYWN0sHWRJndGlDGiAodydb+kNY
 WrbQS59QDyFXKoT7YcV8pxer2b41L7mJ86OjhkHU6gMYPXXbdXC8gfbyBWYKQRKie7uDetLaK0P
 DHqF/djic/1b7/JjdDObyiBiiouv6qChwyQQ9Ag0IW1HoB/j05vz+6ug7XqCtNLNmofZ27402br
 vsHYm60YNwF+makJ2rSGZvbO4cY00xAz13DKtfEB2sxXCbtzJaus/wfIauq3VtBioKjzcLCIo+t
 1aCoqDMJzm58s9drwfMcLM7dKl7B9HqoEIyehTYsiHYMrv3Q8IOvVIoifsorAP2L7adGbp9TF/B
 zINlwYcVbd0Xzw06E6+Znd316jPTZwuNGv/OKzKLFK1mFwTd2qE1+U3WV6+iZd4NZox2LYKuTGa
 Micpysj9An5nclyrj2EgrKv2oz8MLbNbPXcrcMhdn1v/AdOiX+iKP2Fsh7ucGRNg0z0R0=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3D5FB21BFC
X-Spamd-Result: default: False [-4.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 5/5] Add landlock06 test
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
Cc: mic@digikod.net, gnoack@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

This test verifies LANDLOCK_ACCESS_FS_IOCTL_DEV access in the
landlock sandbox by creating a pipe and testing that ioctl() can
be executed on it. The test is also verifying that some of the I/O
operations can be always executed no matter the sandbox rules.
This feature is available since kernel 6.10.

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/landlock/.gitignore   |   1 +
 testcases/kernel/syscalls/landlock/landlock06.c | 112 ++++++++++++++++++++++++
 3 files changed, 114 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 6522f5bc7..7ebdb41d8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -701,6 +701,7 @@ landlock02 landlock02
 landlock03 landlock03
 landlock04 landlock04
 landlock05 landlock05
+landlock06 landlock06
 
 lchown01 lchown01
 lchown01_16 lchown01_16
diff --git a/testcases/kernel/syscalls/landlock/.gitignore b/testcases/kernel/syscalls/landlock/.gitignore
index a7ea6be2e..315ac1dca 100644
--- a/testcases/kernel/syscalls/landlock/.gitignore
+++ b/testcases/kernel/syscalls/landlock/.gitignore
@@ -4,3 +4,4 @@ landlock02
 landlock03
 landlock04
 landlock05
+landlock06
diff --git a/testcases/kernel/syscalls/landlock/landlock06.c b/testcases/kernel/syscalls/landlock/landlock06.c
new file mode 100644
index 000000000..647ebbe48
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock06.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies LANDLOCK_ACCESS_FS_IOCTL_DEV access in the
+ * landlock sandbox by creating a pipe and testing that ioctl() can be executed
+ * on it. The test is also verifying that some of the I/O operations can be
+ * always executed no matter the sandbox rules.
+ */
+
+#include "landlock_common.h"
+#include <sys/ioctl.h>
+
+#define MNTPOINT "sandbox"
+#define FILENAME MNTPOINT"/fifo"
+
+static struct landlock_ruleset_attr *ruleset_attr;
+static struct landlock_path_beneath_attr *path_beneath_attr;
+static int file_fd;
+static int dev_fd;
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	int flag;
+	size_t sz = 0;
+
+	TST_EXP_PASS(ioctl(file_fd, FIONREAD, &sz));
+
+	/* check unrestrictable commands */
+	TST_EXP_PASS(ioctl(dev_fd, FIOCLEX));
+	TST_EXP_PASS(ioctl(dev_fd, FIONCLEX));
+	TST_EXP_PASS(ioctl(dev_fd, FIONBIO, &flag));
+	TST_EXP_PASS(ioctl(dev_fd, FIOASYNC, &flag));
+
+	_exit(0);
+}
+
+static void setup(void)
+{
+	int ruleset_fd;
+
+	verify_landlock_is_enabled();
+
+	SAFE_MKFIFO(FILENAME, 0640);
+
+	file_fd = SAFE_OPEN(FILENAME, O_RDONLY | O_NONBLOCK, 0640);
+	dev_fd = SAFE_OPEN("/dev/zero", O_RDONLY | O_NONBLOCK, 0640);
+
+	tst_res(TINFO, "Applying LANDLOCK_ACCESS_FS_IOCTL_DEV");
+
+	ruleset_attr->handled_access_fs = LANDLOCK_ACCESS_FS_IOCTL_DEV;
+
+	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
+		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0);
+
+	apply_landlock_layer(
+		ruleset_attr,
+		path_beneath_attr,
+		MNTPOINT,
+		LANDLOCK_ACCESS_FS_IOCTL_DEV
+	);
+
+	SAFE_CLOSE(ruleset_fd);
+}
+
+static void cleanup(void)
+{
+	if (dev_fd != -1)
+		SAFE_CLOSE(dev_fd);
+
+	if (file_fd != -1)
+		SAFE_CLOSE(file_fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "6.10",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_SECURITY_LANDLOCK=y",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{&path_beneath_attr, .size = sizeof(struct landlock_path_beneath_attr)},
+		{},
+	},
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_REQ, CAP_SYS_ADMIN),
+		{}
+	},
+	.format_device = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *[]) {
+		"vfat",
+		"exfat",
+		NULL
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
