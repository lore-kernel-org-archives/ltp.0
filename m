Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E6ACEDD88
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 12:08:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D9D43C2BC7
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 14:08:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D85A53C2DDF
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 14:04:49 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 68A0F1000F22
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 14:04:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E8FD11FB84;
 Wed,  9 Oct 2024 12:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728475488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0tg+hmQe0o/a/xtuMcoeFp2Gzih5GezvQ3Wxr7tG4ew=;
 b=AF1DGlUq9grbS9zIzfdhrj13AFMOY+0z9EL9cqyJV3V1IVLsVlYFefriL+pVARp8fmziia
 +5vmhiVRB++bbbUwQTsVWCc652IHCIU8z8AhPkZ1P650x/8pB+tHlIhW+Wh57+K2K5lwxI
 i3/AQQcXV2E2jc91YMOAO1kTMu+z6io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728475488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0tg+hmQe0o/a/xtuMcoeFp2Gzih5GezvQ3Wxr7tG4ew=;
 b=vUall73PN3q+n1eg7AkCAfca5OW5EeGTBtQQYIovuWbSQxd3pHQoqI3AMTpYyhBqmaPxYM
 qHTN3i4l0LcPSbDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728475487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0tg+hmQe0o/a/xtuMcoeFp2Gzih5GezvQ3Wxr7tG4ew=;
 b=N2wqB5f0Q7O7sw6POyAVB87x36imYkuj4jvJGT+rVGD+lC+1G4OhBDKQQBt2QAO3PPAAff
 Re+tQScVCjCtPyVbASjOE9wbDRxChYHZfWNpFBWwHCoC7zx+XBGhGx4XqoTqCD2S0ED3mm
 JgsBee4LLzzKNiS8mtNdQXQyLJ0SEwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728475487;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0tg+hmQe0o/a/xtuMcoeFp2Gzih5GezvQ3Wxr7tG4ew=;
 b=179NmfML1/Tae/coZYzaI0qvAMZYQOV9sxdjFGmSysTH+IcG8gNGd2h8npY1RwO41mhqYX
 JDDE0NUfkmtZguCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98D6E13A58;
 Wed,  9 Oct 2024 12:04:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AK4jH19xBmfLEwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Oct 2024 12:04:47 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 14:04:45 +0200
MIME-Version: 1.0
Message-Id: <20241009-listmount_statmount-v8-10-182cd6557223@suse.com>
References: <20241009-listmount_statmount-v8-0-182cd6557223@suse.com>
In-Reply-To: <20241009-listmount_statmount-v8-0-182cd6557223@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728475481; l=4199;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=XbelAVhH+v51dIWJ1KcmiFEctFwki3hohFW62zDCklg=;
 b=Nu7GAqBsrX2YaSs9MZnTGhkiQMyr0nwWBswFtLa8xjTNy+RPHT+zRx9R4B7jReqzl9JBOQXSU
 aSdKM1dT01dDigV4AJfI5yxpaVFHNI9k5uvSsO5pugoxYnSWFrJI+wM
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 10/16] Add statmount04 test
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

This test verifies that statmount() is correctly reading propagation
from what mount in current namespace using STATMOUNT_PROPAGATE_FROM.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |   1 +
 testcases/kernel/syscalls/statmount/.gitignore    |   1 +
 testcases/kernel/syscalls/statmount/statmount04.c | 105 ++++++++++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 47ca26213..452ac1ac9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1577,6 +1577,7 @@ stat04_64 stat04_64
 statmount01 statmount01
 statmount02 statmount02
 statmount03 statmount03
+statmount04 statmount04
 
 statfs01 statfs01
 statfs01_64 statfs01_64
diff --git a/testcases/kernel/syscalls/statmount/.gitignore b/testcases/kernel/syscalls/statmount/.gitignore
index 2a02bf721..e720050b5 100644
--- a/testcases/kernel/syscalls/statmount/.gitignore
+++ b/testcases/kernel/syscalls/statmount/.gitignore
@@ -1,3 +1,4 @@
 statmount01
 statmount02
 statmount03
+statmount04
diff --git a/testcases/kernel/syscalls/statmount/statmount04.c b/testcases/kernel/syscalls/statmount/statmount04.c
new file mode 100644
index 000000000..509fdf6a1
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount04.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that statmount() is correctly reading propagation from
+ * what mount in current namespace using STATMOUNT_PROPAGATE_FROM.
+ *
+ * [Algorithm]
+ *
+ * - create a mount point
+ * - propagate a mounted folder inside the mount point
+ * - run statmount() on the mount point using STATMOUNT_PROPAGATE_FROM
+ * - read results and check propagated_from parameter contains the propagated
+ *   folder ID
+ */
+
+#define _GNU_SOURCE
+
+#include "statmount.h"
+#include "lapi/stat.h"
+#include "lapi/sched.h"
+
+#define MNTPOINT "mntpoint"
+#define DIR_A MNTPOINT "/LTP_DIR_A"
+#define DIR_C_SUBFOLDER "/LTP_DIR_A/propagated"
+#define DIR_C (MNTPOINT DIR_C_SUBFOLDER)
+#define DIR_B MNTPOINT "/LTP_DIR_B"
+#define DIR_D MNTPOINT "/LTP_DIR_B/propagated"
+
+static uint64_t peer_group_id;
+static uint64_t dird_id;
+static struct statmount *st_mount;
+
+static void run(void)
+{
+	memset(st_mount, 0, sizeof(struct statmount));
+
+	TST_EXP_PASS(statmount(dird_id, STATMOUNT_PROPAGATE_FROM, st_mount,
+		sizeof(struct statmount), 0));
+
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_PROPAGATE_FROM);
+	TST_EXP_EQ_LI(st_mount->size, sizeof(struct statmount));
+	TST_EXP_EQ_LI(st_mount->propagate_from, peer_group_id);
+}
+
+static void setup(void)
+{
+	struct ltp_statx sx;
+
+	/* create DIR_A / DIR_C structure with DIR_C mounted */
+	SAFE_MKDIR(DIR_A, 0700);
+	SAFE_MOUNT(DIR_A, DIR_A, "none", MS_BIND, NULL);
+	SAFE_MOUNT("none", DIR_A, "none", MS_SHARED, NULL);
+
+	SAFE_MKDIR(DIR_C, 0700);
+	SAFE_MOUNT(DIR_C, DIR_C, "none", MS_BIND, NULL);
+	SAFE_MOUNT("none", DIR_C, "none", MS_SHARED, NULL);
+
+	/* DIR_A mounts into DIR_B. DIR_D is propagated */
+	SAFE_MKDIR(DIR_B, 0700);
+	SAFE_MOUNT(DIR_A, DIR_B, "none", MS_BIND, NULL);
+	SAFE_MOUNT("none", DIR_B, "none", MS_SLAVE, NULL);
+
+	SAFE_STATX(AT_FDCWD, DIR_D, 0, STATX_MNT_ID_UNIQUE, &sx);
+	dird_id = sx.data.stx_mnt_id;
+
+	peer_group_id = read_peer_group(DIR_A);
+}
+
+static void cleanup(void)
+{
+	if (tst_is_mounted(DIR_C))
+		SAFE_UMOUNT(DIR_C);
+
+	if (tst_is_mounted(DIR_B))
+		SAFE_UMOUNT(DIR_B);
+
+	if (tst_is_mounted(DIR_A))
+		SAFE_UMOUNT(DIR_A);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
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
