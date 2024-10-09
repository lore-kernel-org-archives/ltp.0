Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DD5CEDD88
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 12:07:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E31C3C2F17
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 14:07:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD6C33C2DD3
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 14:04:47 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2472960132B
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 14:04:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0ED981FB84;
 Wed,  9 Oct 2024 12:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728475486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xq32P8XHmnfy3waCNE90m7uhwyKLkjogAa6TJXydVdU=;
 b=mbIpwhPoOXxkFiHesINdceYoa14rv1fc7yL/0Umx/lmc26e7/x5I9MuD3xGyFdAarwRmB5
 F3xlZ6UQ7EsM+lzwUOCVicConMjnOttBhRXrGOT/EVeHPPD+0ELvG4+7M+3c6YuLK4uAwX
 16nXUIjyi0USCaLxb2SN11+4JuB8Oc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728475486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xq32P8XHmnfy3waCNE90m7uhwyKLkjogAa6TJXydVdU=;
 b=JX08cKIlX9OPx/p5mgRRsyfdogfsLGzKZdYUmnzpgzn8sdXBCVHAO8PbXNlxmSTQCer5kJ
 RJEo+3Z8V9YQp/Aw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mbIpwhPo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JX08cKIl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728475486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xq32P8XHmnfy3waCNE90m7uhwyKLkjogAa6TJXydVdU=;
 b=mbIpwhPoOXxkFiHesINdceYoa14rv1fc7yL/0Umx/lmc26e7/x5I9MuD3xGyFdAarwRmB5
 F3xlZ6UQ7EsM+lzwUOCVicConMjnOttBhRXrGOT/EVeHPPD+0ELvG4+7M+3c6YuLK4uAwX
 16nXUIjyi0USCaLxb2SN11+4JuB8Oc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728475486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xq32P8XHmnfy3waCNE90m7uhwyKLkjogAa6TJXydVdU=;
 b=JX08cKIlX9OPx/p5mgRRsyfdogfsLGzKZdYUmnzpgzn8sdXBCVHAO8PbXNlxmSTQCer5kJ
 RJEo+3Z8V9YQp/Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A65B513A58;
 Wed,  9 Oct 2024 12:04:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QEZmIl1xBmfLEwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Oct 2024 12:04:45 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 14:04:42 +0200
MIME-Version: 1.0
Message-Id: <20241009-listmount_statmount-v8-7-182cd6557223@suse.com>
References: <20241009-listmount_statmount-v8-0-182cd6557223@suse.com>
In-Reply-To: <20241009-listmount_statmount-v8-0-182cd6557223@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728475481; l=4824;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=F60xpzTSWR+XLBtCMxvd+5hp5c4onq4bvZWC+SFc+us=;
 b=oLaDM7g6tMaolFkNrsiFjXrwyuaYLoyvCHhqlTzj4POmI+PqZPfH003acp2cLG1M4FbDtu3HO
 nj953Ob7oxQC+Vn8tvDkFWLVDRkTHbHG0oQT15lHJBh/BF3Cz0p2iI4
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 0ED981FB84
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:mid,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 07/16] Add statmount01 test
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  2 +
 testcases/kernel/syscalls/statmount/.gitignore    |  1 +
 testcases/kernel/syscalls/statmount/Makefile      |  7 +++
 testcases/kernel/syscalls/statmount/statmount.h   | 27 ++++++++
 testcases/kernel/syscalls/statmount/statmount01.c | 77 +++++++++++++++++++++++
 5 files changed, 114 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 564066b2b..677d797f8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1574,6 +1574,8 @@ stat03_64 stat03_64
 stat04 stat04
 stat04_64 stat04_64
 
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
index 000000000..cb0fd1cca
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef STATMOUNT_H
+#define STATMOUNT_H
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
index 000000000..73b9a59b0
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount01.c
@@ -0,0 +1,77 @@
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
+ * - create a mount point
+ * - run statmount() on the mount point without giving any mask
+ * - read results and check that mask and size are correct
+ */
+
+#define _GNU_SOURCE
+
+#include "statmount.h"
+#include "lapi/stat.h"
+#include "lapi/sched.h"
+
+#define MNTPOINT "mntpoint"
+
+static uint64_t mntpoint_id;
+static struct statmount *st_mount;
+
+static void run(void)
+{
+	memset(st_mount, 0, sizeof(struct statmount));
+
+	TST_EXP_PASS(statmount(mntpoint_id, 0, st_mount, sizeof(struct statmount), 0));
+
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_EQ_LI(st_mount->size, sizeof(struct statmount));
+	TST_EXP_EQ_LI(st_mount->mask, 0);
+	TST_EXP_EQ_LI(st_mount->sb_dev_major, 0);
+	TST_EXP_EQ_LI(st_mount->sb_dev_minor, 0);
+	TST_EXP_EQ_LI(st_mount->sb_magic, 0);
+	TST_EXP_EQ_LI(st_mount->sb_flags, 0);
+	TST_EXP_EQ_LI(st_mount->fs_type, 0);
+	TST_EXP_EQ_LI(st_mount->mnt_id, 0);
+	TST_EXP_EQ_LI(st_mount->mnt_parent_id, 0);
+	TST_EXP_EQ_LI(st_mount->mnt_id_old, 0);
+	TST_EXP_EQ_LI(st_mount->mnt_parent_id_old, 0);
+	TST_EXP_EQ_LI(st_mount->mnt_attr, 0);
+	TST_EXP_EQ_LI(st_mount->mnt_propagation, 0);
+	TST_EXP_EQ_LI(st_mount->mnt_peer_group, 0);
+	TST_EXP_EQ_LI(st_mount->mnt_master, 0);
+	TST_EXP_EQ_LI(st_mount->propagate_from, 0);
+	TST_EXP_EQ_LI(st_mount->mnt_root, 0);
+	TST_EXP_EQ_LI(st_mount->mnt_point, 0);
+}
+
+static void setup(void)
+{
+	struct ltp_statx sx;
+
+	SAFE_STATX(AT_FDCWD, MNTPOINT, 0, STATX_MNT_ID_UNIQUE, &sx);
+
+	mntpoint_id = sx.data.stx_mnt_id;
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.min_kver = "6.8",
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.bufs = (struct tst_buffers []) {
+		{&st_mount, .size = sizeof(struct statmount)},
+		{}
+	}
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
