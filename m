Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5437C3DA4A
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 11:21:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 938EA3CF754
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 13:21:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50A423CDE64
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:18:40 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BABFE1000A52
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:18:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4DD451F8C3;
 Thu, 11 Jul 2024 11:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720696719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n0acMllWiwLr6S1S/MHQcyeff1nvJAK73ZL2nwMY0go=;
 b=hQz2Q09/6P5Ce6mE2oD8J+R1sIkEx9OCjCzVTXUfl2ZN/pC4ymcQAvtsa7sr8BvAfrskNV
 VeG+OcQxMB+47GHBreur4ftItfKR2HJpPNw8/IbxPewsj+vYgmrZr3mBxi6qrOArYD+192
 j7SbnT1t56o5vkKz9nU6/0paC61A2ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720696719;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n0acMllWiwLr6S1S/MHQcyeff1nvJAK73ZL2nwMY0go=;
 b=wf3qGKFG9pB7nQcP8Y6BsT3Ohy3TMOT1h1pMNZUixAP7j0ub+w9x7D/VhcsZS/9eLpBkiq
 2UZRcOu9kWVHJ+BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720696719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n0acMllWiwLr6S1S/MHQcyeff1nvJAK73ZL2nwMY0go=;
 b=hQz2Q09/6P5Ce6mE2oD8J+R1sIkEx9OCjCzVTXUfl2ZN/pC4ymcQAvtsa7sr8BvAfrskNV
 VeG+OcQxMB+47GHBreur4ftItfKR2HJpPNw8/IbxPewsj+vYgmrZr3mBxi6qrOArYD+192
 j7SbnT1t56o5vkKz9nU6/0paC61A2ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720696719;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n0acMllWiwLr6S1S/MHQcyeff1nvJAK73ZL2nwMY0go=;
 b=wf3qGKFG9pB7nQcP8Y6BsT3Ohy3TMOT1h1pMNZUixAP7j0ub+w9x7D/VhcsZS/9eLpBkiq
 2UZRcOu9kWVHJ+BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28821139E0;
 Thu, 11 Jul 2024 11:18:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mP7ZB4+/j2bBVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 11 Jul 2024 11:18:39 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jul 2024 13:18:22 +0200
MIME-Version: 1.0
Message-Id: <20240711-landlock-v3-11-c7b0e9edf9b0@suse.com>
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
In-Reply-To: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4223;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=STre4AsQPfPdITbi0p14qsLPISxNynOyTLrkmZTC8IY=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmj79/ilVFvdgb2OEAEXsImygWktfWx8TZCyOvR
 3wQN3wB1cKJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo+/fwAKCRDLzBqyILPm
 RsBGDAC1XfX8dvJlQmyT+fw+9JvPvXQsZii4RPSwJ9kXSpikp1+QP55umZuQYICjs2Lmmn6Cphr
 jk1Q1nshFUTOJvcQaO0NVtA0Bwj2dFj9+MWQVVXnrqtt3XgIB4/uyOtvlyqUzpuLVyWshfFFSAf
 VpDSW55h0syYCmW3k0eQWxFXiVUSDkYHQC72jVrFAl7nDIfPwTg5M0/fWf64u1wqivrl5G0DGYU
 MDejOPZEqrCeM58QgGe1tu7nSU25zgsIJOoXA3YMVpX51FznYIFVuugbVydRkr+MLu1WFx+1Sxo
 /1B/9AGd1G+7DVMq/6fvW4SQV0jV8iXA8RXNM8kk0llxHLLwUpxd3MVkCH+ZOaFBIbVkWjmgixJ
 i2aCqSllbcMY6nXPIX97/h5M9RLtBW9qJ5Tobc88pOlIWCuxMp3M6iTIr73iDKGTMv4ORHdShVc
 ZoAYJ0TpsQKaCAjgv8BTdflwwswM58InlWEBhndYrBhgXl39D9Q/Xy1WwHKzKQeCl+xg8=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-0.30 / 50.00];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 11/11] Add landlock06 test
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
index a31ca3bc3..35d28679a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -690,6 +690,7 @@ landlock02 landlock02
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
