Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D319CEF148
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 09:44:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB82E3C1815
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 11:44:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7812F3C101A
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 11:42:33 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ED65410089B0
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 11:42:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4EE6921A32
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 09:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728380552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vjwkTVM3smEMSjsrpsE0XuK+fPV14eGyGF8IxwX7y8s=;
 b=OWTn66ZfW69sZILqdi7KAbOcqyH8jM5OslUzsCtZaYzdhGp54KYjFIm8ylhJy/uah7ktvx
 20WFmQMLPwKejGbbrvcd0Mp+SjjKKlGqHxqCm4jRr6rfIpw8Ohr12StQvtGca3kqHreMGb
 n+G6US+aYYazCdSW+JR/HkAyHCMusj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728380552;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vjwkTVM3smEMSjsrpsE0XuK+fPV14eGyGF8IxwX7y8s=;
 b=+7JagG7pNQYVq2D9kDsUpgY/S5pH0ngddAMOHjzTLk5PZmTYJnwkCogxKYFiBHNVEsUde4
 7TnmYtL6VVthhNAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728380552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vjwkTVM3smEMSjsrpsE0XuK+fPV14eGyGF8IxwX7y8s=;
 b=OWTn66ZfW69sZILqdi7KAbOcqyH8jM5OslUzsCtZaYzdhGp54KYjFIm8ylhJy/uah7ktvx
 20WFmQMLPwKejGbbrvcd0Mp+SjjKKlGqHxqCm4jRr6rfIpw8Ohr12StQvtGca3kqHreMGb
 n+G6US+aYYazCdSW+JR/HkAyHCMusj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728380552;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vjwkTVM3smEMSjsrpsE0XuK+fPV14eGyGF8IxwX7y8s=;
 b=+7JagG7pNQYVq2D9kDsUpgY/S5pH0ngddAMOHjzTLk5PZmTYJnwkCogxKYFiBHNVEsUde4
 7TnmYtL6VVthhNAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 586CE1340C
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 09:42:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KPwmBYT+BGcZPAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 08 Oct 2024 09:42:28 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 08 Oct 2024 11:42:00 +0200
MIME-Version: 1.0
Message-Id: <20241008-listmount_statmount-v5-7-66f4e1a9e7db@suse.com>
References: <20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com>
In-Reply-To: <20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728380526; l=4870;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=MXLd7H94ogEa7/za4qG1GmPJTM7dKb4UaagZJiqDNio=;
 b=l05n8/aulu+yXQoUamPS+AhFrUSW5GnTbPTfKE2pQPjnp1ohSruo3l5HaMUXarFdqR8Uqo6Go
 bNzqiZZlPg0BXVoH+FTEUTCDTdz9Bb4uyuc8yKVlWhi82nwOEHYBrVx
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 07/16] Add statmount01 test
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
 testcases/kernel/syscalls/statmount/statmount.h   | 27 ++++++++
 testcases/kernel/syscalls/statmount/statmount01.c | 82 +++++++++++++++++++++++
 5 files changed, 119 insertions(+)

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
