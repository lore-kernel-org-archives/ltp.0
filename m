Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C524C25B74
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 12:31:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F174D3CF9E6
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 14:31:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3BCC3CF95E
 for <ltp@lists.linux.it>; Thu, 16 May 2024 14:29:37 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 019DC100113F
 for <ltp@lists.linux.it>; Thu, 16 May 2024 14:29:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 600BA5C353
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715862575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMwE4poR0pgzvbcHjU3aU2mILrMHdbiDYK0XgfA1AeU=;
 b=bhEP0LnVyVA+bZGVHpiWD/8IJ9EX/Lb2fW0RT4fMy1re7IH/omO/vIl/u3dCxBdj6aItjC
 3adS9fIL/yRlxjeGEKwVxLVM/y7FmmF34IfKZ4tf/VuBme+YV6YxH154qUz/8pC8PC4hRi
 K7kbP+6ClEgnzBAM48ruQjZULafB0/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715862575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMwE4poR0pgzvbcHjU3aU2mILrMHdbiDYK0XgfA1AeU=;
 b=29gX4zukrtjmTjQ2cHnlHtRSUH3DOFdcFqDM1u9xr6opSAt9f74ma6WbHDO8fUdoPACxnr
 fajwGHihV/A1TfBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bhEP0LnV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=29gX4zuk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715862575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMwE4poR0pgzvbcHjU3aU2mILrMHdbiDYK0XgfA1AeU=;
 b=bhEP0LnVyVA+bZGVHpiWD/8IJ9EX/Lb2fW0RT4fMy1re7IH/omO/vIl/u3dCxBdj6aItjC
 3adS9fIL/yRlxjeGEKwVxLVM/y7FmmF34IfKZ4tf/VuBme+YV6YxH154qUz/8pC8PC4hRi
 K7kbP+6ClEgnzBAM48ruQjZULafB0/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715862575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMwE4poR0pgzvbcHjU3aU2mILrMHdbiDYK0XgfA1AeU=;
 b=29gX4zukrtjmTjQ2cHnlHtRSUH3DOFdcFqDM1u9xr6opSAt9f74ma6WbHDO8fUdoPACxnr
 fajwGHihV/A1TfBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 508BD13A69
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QN9uEi/8RWbOfwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 May 2024 14:29:14 +0200
MIME-Version: 1.0
Message-Id: <20240516-listmount_statmount-v3-6-2ff4ba29bba7@suse.com>
References: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
In-Reply-To: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4101;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=Qx8T74AfQ8h9rHqYZ8E6v+EO8V0TTdhkia11iJd7rYM=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmRfwuzWmyf1BrxbhVt5JaMNECyODqd/MUJvO/K
 4IsqgQp+QqJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZkX8LgAKCRDLzBqyILPm
 RtW6DACyFmJGon1x4lDDyj78YB+l5Ri5tXrYG3YoDsotrFKRKdUeivk9uUAhzajqdU/FZZdO3Ti
 aG6h8FX4gcYDGOU8T50JSCy6w4OsUSapAjfbrFO7dVkHZ0r0HmXXqMpbPoVjJhkB83uh7r27+DN
 Qk7zB55I9UXSydGGoBMvFsBCxK3yjKtxzx8PxiHeeUutmlfNa5Tgl6m5Yfsjz1HKOpaiPr7nFdJ
 YReCI+8pOKB/0QZ+xtzPydFgdS35X6lUIxDlwm4COvuSXq0LMJXRP4JsLivQp7pZ/XkPSP4Ngd0
 J9rc86x3p5b09e/6/uOUUos2UBZCOniczYUHbpaGHLKGAh4CrioFk4bbG0YV+UEahjrkTBGOKBX
 b7/54bKpsKTGv311zmiN0+dyHOO6FA+XEHHncTBW/P9J3ttCy14UcoRX9rs53srs2F8SC6ZAqFm
 GDpBjbRjHTeugDLp/oqPIzXvUqAlpmY7kfXg23+cOkUEHYBVYl387d5b1ND4tSoUz9Atk=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 600BA5C353
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCPT_COUNT_ONE(0.00)[1];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 06/11] Add stamount01 test
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

This test verifies that statmount() is working with no mask flags.
---
 runtest/syscalls                                  |  2 +
 testcases/kernel/syscalls/statmount/.gitignore    |  1 +
 testcases/kernel/syscalls/statmount/Makefile      |  7 +++
 testcases/kernel/syscalls/statmount/statmount.h   | 26 +++++++++
 testcases/kernel/syscalls/statmount/statmount01.c | 69 +++++++++++++++++++++++
 5 files changed, 105 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 8831c0aec..d36aebfd5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1538,6 +1538,8 @@ stat03_64 stat03_64
 stat04 symlink01 -T stat04
 stat04_64 symlink01 -T stat04_64
 
+statmount01 statmount01
+
 statfs01 statfs01
 statfs01_64 statfs01_64
 statfs02 statfs02
diff --git a/testcases/kernel/syscalls/statmount/.gitignore b/testcases/kernel/syscalls/statmount/.gitignore
new file mode 100644
index 000000000..f1529eb29
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/.gitignore
@@ -0,0 +1 @@
+statmount01
diff --git a/testcases/kernel/syscalls/statmount/Makefile b/testcases/kernel/syscalls/statmount/Makefile
new file mode 100644
index 000000000..8cf1b9024
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/statmount/statmount.h b/testcases/kernel/syscalls/statmount/statmount.h
new file mode 100644
index 000000000..e807c8288
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef STATMOUNT_H
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "lapi/mount.h"
+#include "lapi/syscalls.h"
+
+static inline int statmount(uint64_t mnt_id, uint64_t mask, struct statmount *buf,
+		     size_t bufsize, unsigned int flags)
+{
+	struct mnt_id_req req = {
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.mnt_id = mnt_id,
+		.param = mask,
+	};
+
+	return tst_syscall(__NR_statmount, &req, buf, bufsize, flags);
+}
+
+#endif
diff --git a/testcases/kernel/syscalls/statmount/statmount01.c b/testcases/kernel/syscalls/statmount/statmount01.c
new file mode 100644
index 000000000..ad2d8f727
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount01.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that statmount() is working with no mask flags.
+ *
+ * [Algorithm]
+ *
+ * * create a mount point
+ * * run statmount() on the mount point without giving any mask
+ * * read results and check that mask and size are correct
+ */
+
+#include "statmount.h"
+#include "lapi/stat.h"
+#include "lapi/sched.h"
+
+#define MNTPOINT "mntpoint"
+
+static uint64_t root_id;
+static struct statmount *st_mount;
+
+static void run(void)
+{
+	memset(st_mount, 0, sizeof(struct statmount));
+
+	TST_EXP_PASS(statmount(
+		root_id,
+		0,
+		st_mount,
+		sizeof(struct statmount),
+		0));
+
+	if (TST_RET == -1)
+		return;
+
+	TST_EXP_EQ_LI(st_mount->mask, 0);
+	TST_EXP_EQ_LI(st_mount->size, sizeof(struct statmount));
+}
+
+static void setup(void)
+{
+	struct statx sx;
+
+	SAFE_STATX(AT_FDCWD, MNTPOINT, 0, STATX_MNT_ID_UNIQUE, &sx);
+
+	root_id = sx.stx_mnt_id;
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.min_kver = "6.8",
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []) {
+		"fuse",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&st_mount, .size = sizeof(struct statmount)},
+		{}
+	}
+};

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
