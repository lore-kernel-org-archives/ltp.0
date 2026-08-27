Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B6CC61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:26:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0E9F3D3C07
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:26:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF4FF3D8567
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6604520014E
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 133B21F84B
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wpJY0w3q9MH5x65fAX25KhhW0LsQR44IsNRPYcxsLuE=;
 b=qqvbLQKuhoki848Hkl2KjrZ1mBZsgqGDLyj+VcyA0KP1RuhDhR0JMg1cAs0MLwSXu3hIBB
 dSpd3lcDv24ROHjwpd9LSrYrjivXMraHFSlcKUjmYwqytTkNPqboCRWZX2x/PZDXMtsnhv
 f8yQi4r/xK2uop6EM8G406+68WAQDb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wpJY0w3q9MH5x65fAX25KhhW0LsQR44IsNRPYcxsLuE=;
 b=kc7Po7qvuw3UBLW3RToYxSvjroEiIpkZ6hOFr2DW+Wnc1DsktMkHu/XJDLaeB6KEBeYq1H
 cH3BPgl4hQ9PLJCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=H9QqVzpE;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=z8zmWFaC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wpJY0w3q9MH5x65fAX25KhhW0LsQR44IsNRPYcxsLuE=;
 b=H9QqVzpEErwo6da8V0Yf6DXdibKbKfQkYTJr+t434j6khRdmfPNu2r7MsGodZZLdrGCwNG
 GumTdjgfGRJA+XotD0cyT6XR6911MVowoWH5Ls5IvYfNEOFAruh5h97OV8SgAWGiZXUz8J
 31ANRCxTdHCa891k56E1lUq9PE3uAxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829734;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wpJY0w3q9MH5x65fAX25KhhW0LsQR44IsNRPYcxsLuE=;
 b=z8zmWFaCHArAvDb1uXk9njtvnACrFGoaLQya0f3ZC3YXYfiHwStsfqE+hRPEcc5ChVDrAL
 0bR7R7A6m6DZOkCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB0F513354
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6aZJNeUdkGpuawAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:13 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Aug 2026 13:21:39 +0200
Message-ID: <20260827112157.1748734-14-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827112157.1748734-1-chrubis@suse.cz>
References: <20260827112157.1748734-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 133B21F84B
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:mid];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 13/31] testcases: sysfs: Add sys_bdi01
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
 include/tst_path_defs.h                      |   1 +
 runtest/sysfs                                |   1 +
 testcases/kernel/sysfs/class/bdi/.gitignore  |   1 +
 testcases/kernel/sysfs/class/bdi/Makefile    |   7 ++
 testcases/kernel/sysfs/class/bdi/sys_bdi01.c | 101 +++++++++++++++++++
 5 files changed, 111 insertions(+)
 create mode 100644 testcases/kernel/sysfs/class/bdi/.gitignore
 create mode 100644 testcases/kernel/sysfs/class/bdi/Makefile
 create mode 100644 testcases/kernel/sysfs/class/bdi/sys_bdi01.c

diff --git a/include/tst_path_defs.h b/include/tst_path_defs.h
index 94c4a65bc..f3fa3efd6 100644
--- a/include/tst_path_defs.h
+++ b/include/tst_path_defs.h
@@ -94,6 +94,7 @@
 
 /* SYSFS CLASS */
 #define PATH_CLASS_ATA_DEVICE			"/sys/class/ata_device"
+#define PATH_CLASS_BDI				"/sys/class/bdi"
 
 /* SYSFS DEVICES */
 #define PATH_SYS_CLOCKEVENTS			"/sys/devices/system/clockevents"
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
index 000000000..91b1e4762
--- /dev/null
+++ b/testcases/kernel/sysfs/class/bdi/sys_bdi01.c
@@ -0,0 +1,101 @@
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
+ *   (0 means ``no limit``)
+ * - stable_pages_required and strict_limit are booleans
+ * - read_ahead_kb is non-negative
+ *
+ * The test skips with TCONF when no BDI is present.
+ *
+ * min_bytes/max_bytes were added by commit 1bf27e98d26d (``mm: add
+ * bdi_set_max_bytes() function``), targeting the Linux 6.2 merge window.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <limits.h>
+#include <dirent.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+#include "tst_path_defs.h"
+
+static int has_max_bytes;
+
+static void check_bdi(const char *id)
+{
+	long long max_bytes;
+
+	tst_res(TINFO, "Checking bdi '%s'", id);
+
+	TST_SYSFS_ASSERT_RANGELL(0, 100, PATH_CLASS_BDI "/%s/min_ratio", id);
+	TST_SYSFS_ASSERT_RANGELL(0, 100, PATH_CLASS_BDI "/%s/max_ratio", id);
+	TST_SYSFS_ASSERT_LE_SUFFIX("min_ratio", "max_ratio",
+				   PATH_CLASS_BDI "/%s/", id);
+
+	TST_SYSFS_ASSERT_RANGELL(0, 1000000, PATH_CLASS_BDI "/%s/min_ratio_fine", id);
+	TST_SYSFS_ASSERT_RANGELL(0, 1000000, PATH_CLASS_BDI "/%s/max_ratio_fine", id);
+	TST_SYSFS_ASSERT_LE_SUFFIX("min_ratio_fine", "max_ratio_fine",
+				   PATH_CLASS_BDI "/%s/", id);
+
+	if (has_max_bytes) {
+		max_bytes = TST_SYSFS_READ_LLI(PATH_CLASS_BDI "/%s/max_bytes", id);
+
+		if (max_bytes > 0) {
+			TST_SYSFS_ASSERT_LE_SUFFIX("min_bytes", "max_bytes",
+						   PATH_CLASS_BDI "/%s/", id);
+		}
+	}
+
+	TST_SYSFS_ASSERT_BOOL(PATH_CLASS_BDI "/%s/stable_pages_required", id);
+	TST_SYSFS_ASSERT_BOOL(PATH_CLASS_BDI "/%s/strict_limit", id);
+
+	TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX, PATH_CLASS_BDI "/%s/read_ahead_kb", id);
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
+	if (!tst_sysfs_exists(PATH_CLASS_BDI))
+		tst_brk(TCONF, PATH_CLASS_BDI ": not present");
+
+	d = SAFE_OPENDIR(PATH_CLASS_BDI);
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
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
