Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180F5C61DBD
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 11:40:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 888BB3C5816
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 13:40:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 854163C8B79
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:36:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B380760070F
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:36:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7059E1F7D8
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xr6UX65JVRhZ+JqK7+DxGMbn3SV37CfwP+/rECPlSmI=;
 b=0MxseDSShdX3R8PkrfAvzEhT+kgSHtGmKf4+6irzgn2mTRJ2oZLpIdzozSWMtSYlIoFCOe
 nk6bA+MwKa0xyc7Rt15dxZpzmU2SWfIpR42xa1mZQrAwh11lnlrRs/JjHFB7v0zNZq87pm
 osFhq168rFSyT94HgIUrqMbwQBFJDOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xr6UX65JVRhZ+JqK7+DxGMbn3SV37CfwP+/rECPlSmI=;
 b=ywE+mNg/Agu6EaQ7RYAP/C0M8DzAxNNwkT29mQzPscCEkfJApxwNCzXLMnuGneOtzTGO8j
 Raeq/5KXDgvChmDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xr6UX65JVRhZ+JqK7+DxGMbn3SV37CfwP+/rECPlSmI=;
 b=GLvlvxTFCloPBZm3l6Xau06+ZFmt3z2JDqliMcyRVXWHU51/ptdYMt818xJ9jOjGdJ2zRz
 iFgeLTlbdyFfWigwF2opouRbRL0Lr8+EsnXahDyH18bLjVg27b1oXDSjjdFMOFW+popUVx
 7Fa5MZi+fswFMZoIaCq9Ar6/S0I9K8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657793;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xr6UX65JVRhZ+JqK7+DxGMbn3SV37CfwP+/rECPlSmI=;
 b=tlCzmAb0BwOl6oYzbqD9ECd8C9Kwn5ibPdZZPN9NObM0qvR88iozh1e/wzd11I9kRS+bW3
 iu4elWE0uPdjZpBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5680113335
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8MonFDx+jWpBSAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:28 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 25 Aug 2026 13:36:07 +0200
Message-ID: <20260825113625.1624134-14-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825113625.1624134-1-chrubis@suse.cz>
References: <20260825113625.1624134-1-chrubis@suse.cz>
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 13/31] testcases: sysfs: Add sys_bdi01
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

A test for /sys/class/bdi/*/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                |   1 +
 testcases/kernel/sysfs/class/bdi/.gitignore  |   1 +
 testcases/kernel/sysfs/class/bdi/Makefile    |   7 ++
 testcases/kernel/sysfs/class/bdi/sys_bdi01.c | 102 +++++++++++++++++++
 4 files changed, 111 insertions(+)
 create mode 100644 testcases/kernel/sysfs/class/bdi/.gitignore
 create mode 100644 testcases/kernel/sysfs/class/bdi/Makefile
 create mode 100644 testcases/kernel/sysfs/class/bdi/sys_bdi01.c

diff --git a/runtest/sysfs b/runtest/sysfs
index b5e644237..c0983a5be 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -9,3 +9,4 @@ sys_cpu_smt01 sys_cpu_smt01
 sys_cpu_cache01 sys_cpu_cache01
 sys_clockevents01 sys_clockevents01
 sys_ata01 sys_ata01
+sys_bdi01 sys_bdi01
diff --git a/testcases/kernel/sysfs/class/bdi/.gitignore b/testcases/kernel/sysfs/class/bdi/.gitignore
new file mode 100644
index 000000000..93ce63f2c
--- /dev/null
+++ b/testcases/kernel/sysfs/class/bdi/.gitignore
@@ -0,0 +1 @@
+/sys_bdi01
diff --git a/testcases/kernel/sysfs/class/bdi/Makefile b/testcases/kernel/sysfs/class/bdi/Makefile
new file mode 100644
index 000000000..034038061
--- /dev/null
+++ b/testcases/kernel/sysfs/class/bdi/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sysfs/class/bdi/sys_bdi01.c b/testcases/kernel/sysfs/class/bdi/sys_bdi01.c
new file mode 100644
index 000000000..7d6cf9bf3
--- /dev/null
+++ b/testcases/kernel/sysfs/class/bdi/sys_bdi01.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the backing device info (BDI) attributes exported under
+ * /sys/class/bdi/<id>/.
+ *
+ * For every BDI the test verifies that:
+ *
+ * - min_ratio <= max_ratio (both are percentages)
+ * - min_ratio_fine <= max_ratio_fine (both are in parts-per-million, i.e.
+ *   100% == 1000000)
+ * - min_bytes <= max_bytes on kernel 6.2 or later, when max_bytes is set
+ *   (0 means "no limit")
+ * - stable_pages_required and strict_limit are booleans
+ * - read_ahead_kb is non-negative
+ *
+ * The test skips with TCONF when no BDI is present.
+ *
+ * min_bytes/max_bytes were added by commit 1bf27e98d26d ("mm: add
+ * bdi_set_max_bytes() function"), targeting the Linux 6.2 merge window.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <limits.h>
+#include <dirent.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+#define BDI_CLASS "/sys/class/bdi"
+
+static int has_max_bytes;
+
+static void check_bdi(const char *id)
+{
+	long long max_bytes;
+
+	tst_res(TINFO, "Checking bdi '%s'", id);
+
+	TST_SYSFS_ASSERT_RANGELL(0, 100, BDI_CLASS "/%s/min_ratio", id);
+	TST_SYSFS_ASSERT_RANGELL(0, 100, BDI_CLASS "/%s/max_ratio", id);
+	TST_SYSFS_ASSERT_LE_SUFFIX("min_ratio", "max_ratio",
+				   BDI_CLASS "/%s/", id);
+
+	TST_SYSFS_ASSERT_RANGELL(0, 1000000, BDI_CLASS "/%s/min_ratio_fine", id);
+	TST_SYSFS_ASSERT_RANGELL(0, 1000000, BDI_CLASS "/%s/max_ratio_fine", id);
+	TST_SYSFS_ASSERT_LE_SUFFIX("min_ratio_fine", "max_ratio_fine",
+				   BDI_CLASS "/%s/", id);
+
+	if (has_max_bytes) {
+		max_bytes = TST_SYSFS_READ_LLI(BDI_CLASS "/%s/max_bytes", id);
+
+		if (max_bytes > 0) {
+			TST_SYSFS_ASSERT_LE_SUFFIX("min_bytes", "max_bytes",
+						   BDI_CLASS "/%s/", id);
+		}
+	}
+
+	TST_SYSFS_ASSERT_BOOL(BDI_CLASS "/%s/stable_pages_required", id);
+	TST_SYSFS_ASSERT_BOOL(BDI_CLASS "/%s/strict_limit", id);
+
+	TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX, BDI_CLASS "/%s/read_ahead_kb", id);
+}
+
+static void setup(void)
+{
+	has_max_bytes = tst_kvercmp(6, 2, 0) >= 0;
+}
+
+static void do_test(void)
+{
+	DIR *d;
+	struct dirent *ent;
+	int found = 0;
+
+	if (!tst_sysfs_exists(BDI_CLASS))
+		tst_brk(TCONF, BDI_CLASS ": not present");
+
+	d = SAFE_OPENDIR(BDI_CLASS);
+
+	while ((ent = SAFE_READDIR(d))) {
+		if (ent->d_name[0] == '.')
+			continue;
+
+		found = 1;
+		check_bdi(ent->d_name);
+	}
+
+	SAFE_CLOSEDIR(d);
+
+	if (!found)
+		tst_res(TCONF, "No BDI found");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.setup = setup,
+};
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
