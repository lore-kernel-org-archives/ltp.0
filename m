Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27C2C5DF81
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 16:20:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 511C03CD699
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 18:20:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7D863C57A0
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:17:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5216C200932
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:17:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E93FB84C17
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CcP727/aYgMdTSZjxCS9wTFjkRsJndb1B3gy6kImxYs=;
 b=BENy20/ypMnN9G0/5Dj7ZIet6/l7qqelsMkHuY4OEyexs6KQJim71S54keB8/cGHKeIdNb
 hYbCxUfEOxmmK1WGZbFUXnig5vO89McDhsZAOXZ4ggyOoRvQWTx+9PtEoF4xo2Py079uO3
 9W1j1KGlHVAoIU3xo3V+WPXK9fyfw3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156215;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CcP727/aYgMdTSZjxCS9wTFjkRsJndb1B3gy6kImxYs=;
 b=PtH0AAC590p+CD6eEcsO/xXLQu6ExTBKlZ8WD0MYlK2chm4fK6xNyCcrP/APp8C0EIX4A6
 Awxi/MrMFXjdz8AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CcP727/aYgMdTSZjxCS9wTFjkRsJndb1B3gy6kImxYs=;
 b=iTozg5a32Yf3gAwTf+UvlnL8CSRPO06XheZColr/vaac4t50VhBpcYQX7NFpPIcAc9x3nQ
 +fMu1vokOQC/Hcwv2GHhoDarX3ZWpJnV+vK3RAXUVvOUtSNL5N6lVq0/lybZA5Eu4bofX5
 UdUkVbPkPvZO4eKPjLgDVZCzCfc58dc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CcP727/aYgMdTSZjxCS9wTFjkRsJndb1B3gy6kImxYs=;
 b=ho9ETbbce7RX9iBVKiDJv8xhykPGflX7BmUFS53Y9xdoE2cfbsjS58T2p01HRCHXdkCKLs
 FXhF7cJBY1ZXNnBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA9DC364F
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LaR7NPLWhWqJcwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:50 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Aug 2026 18:16:15 +0200
Message-ID: <20260819161634.1341577-13-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819161634.1341577-1-chrubis@suse.cz>
References: <20260819161634.1341577-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.19)[-0.952];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 12/31] testcases: sysfs: Add sys_ata01
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
 .../kernel/sysfs/class/ata_device/sys_ata01.c | 96 +++++++++++++++++++
 5 files changed, 112 insertions(+)
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
index 000000000..22e02a2c0
--- /dev/null
+++ b/testcases/kernel/sysfs/class/ata_device/sys_ata01.c
@@ -0,0 +1,96 @@
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
+	if (!tst_sysfs_exists(ATA_DEVICE))
+		tst_brk(TCONF, ATA_DEVICE ": not present");
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
