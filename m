Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96EDC5DF7D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:15:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 309C43CCBD5
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 16:15:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 637733CD547
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:13:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CDD3510007FD
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:13:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7DBCB3E47
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=40JfWLGFm8RCY8YQOe60hiS5oUswnmgR5Leh7HFlAr8=;
 b=S5LqsUl6LsKxKsGgxzRgfO6706rBfjnGVMOdg/MTvQnG5zCPjqNljQvb0OWBsyiYXg+Upk
 +f0HgweBK8nggMXIz4PqZPxk1EtSXCSPtubAsQmIzTLUwupaZk34HqafTstZ2T98BO05dj
 iFQYWLqgmJ4Y7ncXTDYTVre4eWnWwPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062401;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=40JfWLGFm8RCY8YQOe60hiS5oUswnmgR5Leh7HFlAr8=;
 b=/ahC3dQsqCR5D0lZ02+CPdBDw/aVQQiMlvD7tbTuIJ8I8Lpg7clWupSugqdbGgytlro8Nc
 LRVHLdQEU94CfSCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=40JfWLGFm8RCY8YQOe60hiS5oUswnmgR5Leh7HFlAr8=;
 b=zwjgoA/Gqi/yno9rkz+muiLlj57ko20ofb10yDnh97He/WHcuQV+e6f2TQsK8B5u6cM5Kt
 TMOY3ELx9c7AEoOaCSgY3MvGtTuvzr0hxIZxZaY4IjgpseaImGbgXO0YQKIYiBCbx5VWfN
 nadks033iDOKO8R5uPUUjzC6UhOSzeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=40JfWLGFm8RCY8YQOe60hiS5oUswnmgR5Leh7HFlAr8=;
 b=NMrMRqf8MADWAvlRJivv1jx8kKuEbmnQ70C6llYhSql7T8DxBjeVQ70t6tcz76BbFMF24m
 AiJlB9gy7JP0qyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 007A73681
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +DUuOnxohGrjcAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:16 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Aug 2026 16:12:52 +0200
Message-ID: <20260818141311.1265557-13-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818141311.1265557-1-chrubis@suse.cz>
References: <20260818141311.1265557-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 12/31] testcases: sysfs: Add sys_ata01
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

A test for /sys/class/ata_device/*/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |  1 +
 testcases/kernel/sysfs/class/Makefile         |  7 ++
 .../kernel/sysfs/class/ata_device/.gitignore  |  1 +
 .../kernel/sysfs/class/ata_device/Makefile    |  7 ++
 .../kernel/sysfs/class/ata_device/sys_ata01.c | 93 +++++++++++++++++++
 5 files changed, 109 insertions(+)
 create mode 100644 testcases/kernel/sysfs/class/Makefile
 create mode 100644 testcases/kernel/sysfs/class/ata_device/.gitignore
 create mode 100644 testcases/kernel/sysfs/class/ata_device/Makefile
 create mode 100644 testcases/kernel/sysfs/class/ata_device/sys_ata01.c

diff --git a/runtest/sysfs b/runtest/sysfs
index 3015c03f5..b5e644237 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -8,3 +8,4 @@ sys_cpu_vulnerabilities01 sys_cpu_vulnerabilities01
 sys_cpu_smt01 sys_cpu_smt01
 sys_cpu_cache01 sys_cpu_cache01
 sys_clockevents01 sys_clockevents01
+sys_ata01 sys_ata01
diff --git a/testcases/kernel/sysfs/class/Makefile b/testcases/kernel/sysfs/class/Makefile
new file mode 100644
index 000000000..5c8e7a249
--- /dev/null
+++ b/testcases/kernel/sysfs/class/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/sysfs/class/ata_device/.gitignore b/testcases/kernel/sysfs/class/ata_device/.gitignore
new file mode 100644
index 000000000..b5b1f8f4a
--- /dev/null
+++ b/testcases/kernel/sysfs/class/ata_device/.gitignore
@@ -0,0 +1 @@
+/sys_ata01
diff --git a/testcases/kernel/sysfs/class/ata_device/Makefile b/testcases/kernel/sysfs/class/ata_device/Makefile
new file mode 100644
index 000000000..034038061
--- /dev/null
+++ b/testcases/kernel/sysfs/class/ata_device/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sysfs/class/ata_device/sys_ata01.c b/testcases/kernel/sysfs/class/ata_device/sys_ata01.c
new file mode 100644
index 000000000..ab31c05e0
--- /dev/null
+++ b/testcases/kernel/sysfs/class/ata_device/sys_ata01.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the ATA device attributes exported under
+ * /sys/class/ata_device/<dev>/.
+ *
+ * For every ATA device the test verifies that:
+ *
+ * - class is one of the known libata device classes (ata, atapi, pmp, semb,
+ *   unknown)
+ * - dma_mode, pio_mode and xfer_mode, when non-empty, start with the "XFER_"
+ *   prefix used by all libata transfer mode names
+ * - spdn_cnt (speed-down count) is non-negative
+ *
+ * dma_mode is legitimately empty for devices that only support PIO, so it is
+ * only checked when present.
+ *
+ * The test skips with TCONF when no ATA device is present.
+ */
+
+#include <string.h>
+#include <dirent.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+#define ATA_DEVICE "/sys/class/ata_device"
+
+static const char *const class_allowed[] = {
+	"ata", "atapi", "pmp", "semb", "unknown", NULL
+};
+
+static void check_mode(const char *dev, const char *attr)
+{
+	char mode[32];
+
+	if (!TST_SYSFS_READ_STR(mode, sizeof(mode),
+				ATA_DEVICE "/%s/%s", dev, attr)) {
+		tst_res(TCONF, "%s/%s does not exist", dev, attr);
+		return;
+	}
+
+	if (mode[0] == '\0') {
+		tst_res(TCONF, "%s/%s is empty", dev, attr);
+		return;
+	}
+
+	if (!strncmp(mode, "XFER_", 5))
+		tst_res(TPASS, "%s/%s = '%s'", dev, attr, mode);
+	else
+		tst_res(TFAIL, "%s/%s = '%s' has no XFER_ prefix",
+			dev, attr, mode);
+}
+
+static void check_device(const char *dev)
+{
+	tst_res(TINFO, "Checking ata device '%s'", dev);
+
+	TST_SYSFS_ASSERT_ONEOF(class_allowed, ATA_DEVICE "/%s/class", dev);
+	check_mode(dev, "dma_mode");
+	check_mode(dev, "pio_mode");
+	check_mode(dev, "xfer_mode");
+
+	TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX, ATA_DEVICE "/%s/spdn_cnt", dev);
+}
+
+static void do_test(void)
+{
+	DIR *d;
+	struct dirent *ent;
+	int found = 0;
+
+	d = SAFE_OPENDIR(ATA_DEVICE);
+
+	while ((ent = SAFE_READDIR(d))) {
+		if (ent->d_name[0] == '.')
+			continue;
+
+		found = 1;
+		check_device(ent->d_name);
+	}
+
+	SAFE_CLOSEDIR(d);
+
+	if (!found)
+		tst_res(TCONF, "No ATA device found");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
