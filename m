Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7376CECE57B
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 10:02:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0832F3C178C
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 12:02:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3F143C1777
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 12:00:34 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EB88210000F6
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 12:00:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6CD3621BD9
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 10:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725876033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PgLPhWg3YOTE4t9lP3fcwAPDNNRD4bDXebCCbBcTeSo=;
 b=pjzjXyq6pCGWdSFb5Maas8K129RASFqcb3dWHDgWMXY61bmr22e2UPfwNIDGTIQ1JH+wir
 CyOCICMHbgFtexZ+p990mkBsWMM2UonmSdJY2YuLCTk5riqFVjX4U9gwfqa/3lJPLCpsYE
 /jUZPBWEB+4AwaQ02klrRAxqLh8X6IY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725876033;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PgLPhWg3YOTE4t9lP3fcwAPDNNRD4bDXebCCbBcTeSo=;
 b=R/7q5q6oxrBvRYvyMkBfTGgCEgGEe2j1Key2vnolItycadSeM7HZ9U85VE577dZkKldgd8
 lrGavTsor0sy0IAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pjzjXyq6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="R/7q5q6o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725876033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PgLPhWg3YOTE4t9lP3fcwAPDNNRD4bDXebCCbBcTeSo=;
 b=pjzjXyq6pCGWdSFb5Maas8K129RASFqcb3dWHDgWMXY61bmr22e2UPfwNIDGTIQ1JH+wir
 CyOCICMHbgFtexZ+p990mkBsWMM2UonmSdJY2YuLCTk5riqFVjX4U9gwfqa/3lJPLCpsYE
 /jUZPBWEB+4AwaQ02klrRAxqLh8X6IY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725876033;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PgLPhWg3YOTE4t9lP3fcwAPDNNRD4bDXebCCbBcTeSo=;
 b=R/7q5q6oxrBvRYvyMkBfTGgCEgGEe2j1Key2vnolItycadSeM7HZ9U85VE577dZkKldgd8
 lrGavTsor0sy0IAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5EF113312
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 10:00:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aCzeKEDH3mb+DgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 09 Sep 2024 10:00:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 09 Sep 2024 12:00:28 +0200
MIME-Version: 1.0
Message-Id: <20240909-listmount_statmount-v4-6-39558204ddf0@suse.com>
References: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
In-Reply-To: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725876026; l=4847;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=toNkuAVpC8QchTnA+RLh4AoWtBRXQavSwaBQ5PvQ95c=;
 b=F1v3oT0xb52YVlSpRGb8+X7h8NGXqVwwvWSZP5cLUeyVXwJJpxOrYoQKZZFy4DppQ6U79j1zX
 VaVa864dnfzACo0E2jGYtMf1CIcNxafBLJ2rsUSE+zt1ZPIunJA6DGJ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 6CD3621BD9
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 06/13] Add statmount01 test
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  2 +
 testcases/kernel/syscalls/statmount/.gitignore    |  1 +
 testcases/kernel/syscalls/statmount/Makefile      |  7 ++
 testcases/kernel/syscalls/statmount/statmount.h   | 26 +++++++
 testcases/kernel/syscalls/statmount/statmount01.c | 82 +++++++++++++++++++++++
 5 files changed, 118 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 13b6a28b9..ebe0de2a0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1568,6 +1568,8 @@ stat03_64 stat03_64
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
index 000000000..95dac5c92
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount01.c
@@ -0,0 +1,82 @@
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
+static uint64_t root_id;
+static struct statmount *st_mount;
+
+static void run(void)
+{
+	memset(st_mount, 0, sizeof(struct statmount));
+
+	TST_EXP_PASS(statmount(root_id, 0, st_mount, sizeof(struct statmount), 0));
+
+	if (TST_RET == -1)
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
+	root_id = sx.data.stx_mnt_id;
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
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
