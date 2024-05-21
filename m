Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FACC25B74
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 06:16:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 556C33CFF64
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 08:16:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67B593CFF20
 for <ltp@lists.linux.it>; Tue, 21 May 2024 08:16:34 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 95E3760084B
 for <ltp@lists.linux.it>; Tue, 21 May 2024 08:16:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 466815BEEA;
 Tue, 21 May 2024 06:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716272193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iM71CJX864CMdNCRcKIlBRIgU7fTV1wqZjJF2Q1KZGc=;
 b=JXaqMgav8x4+Jiw7J6j0mgVvbq5HqMKS8AgfJQz/x5b75J6CvZps/9BbQs9HXDno4m3ASO
 u3l6AEbFOWPPSeSGVGFRUvtSOGX0PAuOk3LGBVbNTr/TL+WWrzsbCKrhE3umn0GPBk2bVq
 Gy31XruX0CXEd5TaxOK2cEWWnhs1wfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716272193;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iM71CJX864CMdNCRcKIlBRIgU7fTV1wqZjJF2Q1KZGc=;
 b=5sbdK6gVfvtK8JYIwO7fPJF+a01jid9fmOXuwA7jko/YUDnxY+35B6wcW1Q6tt0mdDO9KC
 zPDXBXqUzFwAQFDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716272193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iM71CJX864CMdNCRcKIlBRIgU7fTV1wqZjJF2Q1KZGc=;
 b=JXaqMgav8x4+Jiw7J6j0mgVvbq5HqMKS8AgfJQz/x5b75J6CvZps/9BbQs9HXDno4m3ASO
 u3l6AEbFOWPPSeSGVGFRUvtSOGX0PAuOk3LGBVbNTr/TL+WWrzsbCKrhE3umn0GPBk2bVq
 Gy31XruX0CXEd5TaxOK2cEWWnhs1wfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716272193;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iM71CJX864CMdNCRcKIlBRIgU7fTV1wqZjJF2Q1KZGc=;
 b=5sbdK6gVfvtK8JYIwO7fPJF+a01jid9fmOXuwA7jko/YUDnxY+35B6wcW1Q6tt0mdDO9KC
 zPDXBXqUzFwAQFDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D0C413A75;
 Tue, 21 May 2024 06:16:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +M01BEE8TGZmMQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 21 May 2024 06:16:33 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 21 May 2024 08:15:29 +0200
MIME-Version: 1.0
Message-Id: <20240521-fchmodat2-v1-3-191b4a986202@suse.com>
References: <20240521-fchmodat2-v1-0-191b4a986202@suse.com>
In-Reply-To: <20240521-fchmodat2-v1-0-191b4a986202@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4062;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=4Yq59O73IRFORMS9lkSgqcJF1LJ9BMcQsgwAuywRGII=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmTDxA3WP0ewREsVC+Y120aNKPqX5A/jMGkkqLg
 kAYOnYQDNyJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZkw8QAAKCRDLzBqyILPm
 RrYIC/9uwBU0KNtwsyFTo9XTmhYkg1C55v+nXVtqpQyrgIRtoW9pxxfGLi25d4ekMvDI099yJ6w
 63ttmtPaXBYAHAMOnMeMKHo6spfplRU14WzczeZP2OWWdaA/cU6sZ0xHT6QQQ10Wxr2pox1p9D3
 qrD7DAXYzn2i0ja2Azhl0exYOYLdmwNp5J4CIhpv9JV9vwk74IvdLF589qMXNBlc/N2BbWZV1Md
 zBSCBwQ1t1yrewAG0Ng82x+SuzJO2W6FWt6maeuQlB7FoJyuegTZWZ6VX9pvyHu+YoUTeR7pEdb
 nyE60wKSuLXxy9e7hjv3TWZvWzlQke+HUkR0hq5DGQ7T52IawKjI8FB5T6r6YoMw9l7FDwL9VcQ
 EuAuzhBLgg9cYDSskjAbZwgk6unXGWE6ENISKXaqes1ho86SRenM0MMowj1Ygk2uDsRn823HfRr
 SR+RZN3FFu6ayj2WB0SkA3WghDNIo6QmkDWhzCgjzocCP7x3SKEyS81IaDhVaXs3Zv0Uw=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.993]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] Add fchmodat2_01 test
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

This test verifies that fchmodat2() syscall is properly working with
AT_SYMLINK_NOFOLLOW on regular files.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  2 +
 testcases/kernel/syscalls/fchmodat2/.gitignore     |  1 +
 testcases/kernel/syscalls/fchmodat2/Makefile       |  7 +++
 testcases/kernel/syscalls/fchmodat2/fchmodat2.h    | 32 +++++++++++++
 testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c | 54 ++++++++++++++++++++++
 5 files changed, 96 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index cf06ee563..0a28530ed 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -264,6 +264,8 @@ fchmod06 fchmod06
 fchmodat01 fchmodat01
 fchmodat02 fchmodat02
 
+fchmodat2_01 fchmodat2_01
+
 fchown01 fchown01
 fchown01_16 fchown01_16
 fchown02 fchown02
diff --git a/testcases/kernel/syscalls/fchmodat2/.gitignore b/testcases/kernel/syscalls/fchmodat2/.gitignore
new file mode 100644
index 000000000..47d5e2427
--- /dev/null
+++ b/testcases/kernel/syscalls/fchmodat2/.gitignore
@@ -0,0 +1 @@
+fchmodat2_01
diff --git a/testcases/kernel/syscalls/fchmodat2/Makefile b/testcases/kernel/syscalls/fchmodat2/Makefile
new file mode 100644
index 000000000..8cf1b9024
--- /dev/null
+++ b/testcases/kernel/syscalls/fchmodat2/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/fchmodat2/fchmodat2.h b/testcases/kernel/syscalls/fchmodat2/fchmodat2.h
new file mode 100644
index 000000000..676d491cf
--- /dev/null
+++ b/testcases/kernel/syscalls/fchmodat2/fchmodat2.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef FCHMODAT2_H
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "tst_safe_file_at.h"
+
+static inline int fchmodat2(int dfd, const char *filename, mode_t mode, int flags)
+{
+	int ret;
+
+	ret = tst_syscall(__NR_fchmodat2, dfd, filename, mode, flags);
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "%s(%d,%s,%d,%d) error",
+			__func__, dfd, filename, mode, flags);
+
+	return ret;
+}
+
+static inline void verify_mode(int dirfd, const char *path, mode_t mode)
+{
+	struct stat st;
+
+	SAFE_FSTATAT(dirfd, path, &st, AT_SYMLINK_NOFOLLOW);
+	TST_EXP_EQ_LI(st.st_mode, mode);
+}
+
+#endif
diff --git a/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c b/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
new file mode 100644
index 000000000..9f4960a0c
--- /dev/null
+++ b/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that fchmodat2() syscall is properly working with
+ * AT_SYMLINK_NOFOLLOW on regular files.
+ */
+
+#include "fchmodat2.h"
+#include "lapi/fcntl.h"
+
+#define MNTPOINT "mntpoint"
+#define FNAME "myfile"
+
+static int fd_dir = -1;
+
+static void run(void)
+{
+	SAFE_CHMOD(MNTPOINT"/"FNAME, 0640);
+
+	TST_EXP_PASS(fchmodat2(fd_dir, FNAME, 0700, AT_SYMLINK_NOFOLLOW));
+	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
+}
+
+static void setup(void)
+{
+	fd_dir = SAFE_OPEN(MNTPOINT, O_PATH | O_DIRECTORY, 0640);
+
+	SAFE_TOUCH(MNTPOINT"/"FNAME, 0640, NULL);
+}
+
+static void cleanup(void)
+{
+	if (fd_dir != -1)
+		SAFE_CLOSE(fd_dir);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "6.6",
+	.mntpoint = MNTPOINT,
+	.format_device = 1,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []) {
+		"fuse",
+		NULL
+	},
+};

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
