Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A633C3DA42
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 18:05:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD1583D3818
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 20:04:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69AE83D385B
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:02:22 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5656D60281D
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:02:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 460A21F851;
 Wed, 10 Jul 2024 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Uus/tkiwpYRYw+MQKPc4v2pWTru1cuQ9ronz7ToJEQ=;
 b=V+K6AmdnjoJ7Gcra2uqnJn9SjgrcqYY4LGsrpKshESI5yOP8F9QUred/yjhZlmn9Oc6Dv/
 8pie1iEypniiGtv3HGVotvWab5wqSd1/wukTIygpMrJ7t/CJPD7MlpRlWV3frn5fZcUaV5
 tPt6A5hsj4wQD3SIhJf73DmBfyFA7m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634540;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Uus/tkiwpYRYw+MQKPc4v2pWTru1cuQ9ronz7ToJEQ=;
 b=PkiNR6FF12nT6xhHjdFcoWIbEWPW7tt6phzKmI9ULOKyRvVh4m22wSgihUwp08tGw2OyC6
 VOgux8xUkYiThQDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=V+K6Amdn;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PkiNR6FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Uus/tkiwpYRYw+MQKPc4v2pWTru1cuQ9ronz7ToJEQ=;
 b=V+K6AmdnjoJ7Gcra2uqnJn9SjgrcqYY4LGsrpKshESI5yOP8F9QUred/yjhZlmn9Oc6Dv/
 8pie1iEypniiGtv3HGVotvWab5wqSd1/wukTIygpMrJ7t/CJPD7MlpRlWV3frn5fZcUaV5
 tPt6A5hsj4wQD3SIhJf73DmBfyFA7m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634540;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Uus/tkiwpYRYw+MQKPc4v2pWTru1cuQ9ronz7ToJEQ=;
 b=PkiNR6FF12nT6xhHjdFcoWIbEWPW7tt6phzKmI9ULOKyRvVh4m22wSgihUwp08tGw2OyC6
 VOgux8xUkYiThQDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A3AF13942;
 Wed, 10 Jul 2024 18:02:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gAD+CKzMjmZJfAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jul 2024 18:02:20 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jul 2024 20:02:06 +0200
MIME-Version: 1.0
Message-Id: <20240710-landlock-v2-11-ff79db017d57@suse.com>
References: <20240710-landlock-v2-0-ff79db017d57@suse.com>
In-Reply-To: <20240710-landlock-v2-0-ff79db017d57@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4212;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=/DPbW9WJA9B7SM9pvBVukc8X4nU69D6R+pJqeZjdNOA=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjsyeTUxKDq2vqaMGQypCy2KMfoM75ccrRNNNe
 naGRPUer7eJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo7MngAKCRDLzBqyILPm
 Ros6C/9y7Z5LaWmtnhIsUbaxNbAeMvMWANxD2Phn38NcykdDtxHVrljsfXerchA35HonXqEPx05
 SJXY8Yv4gGOaM0x1uvwBkKyCb7veRIIuEEGSW55LaYT3rGKzoKYVG4+jdGKZfOB6cSkH/IfxiiK
 r6Oo692Kj/LAI7MKrTFtIFPd1UdaV7t8yeucEeZqM/Abt9deLUNhNZSgiqjbXFyBfsjXxWwLzwE
 sb0cvCoyy09Z/RuubTxbSCh0dof2SE5cXRmagQJfgId/HJ91ydOXUYViSWKJ+CgBYpY5lEiuOFQ
 evghOY6mIdPyE96UKsXvTwOsIrfP8aXZb8kbHpSnRUHN2eL0i+iMk+n/xhxuMAFLaNb/GlhFX/9
 OyPcHLqE1Yx7DYAfY8KcK9ScfxyKaiHDKve09t/KjJzKxDSBkIiBuIezlDmB5DPSYSqZa1CdbxJ
 UV6RjMPy2KmNBbdpjiEKbDtvabR6UmmzxUf3Tupeb5BPFDrtU9Rz80iFav1XGaEXyMgdI=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 460A21F851
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 11/11] Add landlock06 test
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
 testcases/kernel/syscalls/landlock/landlock06.c | 110 ++++++++++++++++++++++++
 3 files changed, 112 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index bb54538ed..e2d32895e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -689,6 +689,7 @@ landlock02 landlock02
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
index 000000000..3281c2d2d
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock06.c
@@ -0,0 +1,110 @@
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
+	if (!SAFE_FORK()) {
+		int flag;
+		size_t sz = 0;
+
+		TST_EXP_PASS(ioctl(file_fd, FIONREAD, &sz));
+
+		/* check unrestrictable commands */
+		TST_EXP_PASS(ioctl(dev_fd, FIOCLEX));
+		TST_EXP_PASS(ioctl(dev_fd, FIONCLEX));
+		TST_EXP_PASS(ioctl(dev_fd, FIONBIO, &flag));
+		TST_EXP_PASS(ioctl(dev_fd, FIOASYNC, &flag));
+
+		_exit(0);
+	}
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
+		NULL
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
