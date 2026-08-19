Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D541DC5DF81
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 16:20:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66CF73C5868
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 18:20:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85C0E3CD674
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:17:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 02AF01A008AD
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:17:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5BF8E3ED4
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7j1lTWikv4eNJfTn4sTbOIjQZTZiKoOmajYWzxyhuRA=;
 b=f/GGxYrDtGTAcS09LL0Uh1jh2KCZInzciPHW/EyBrb3CImJeq9UBctdvBo3+EHkdA0HnJG
 XUxI4Myk07RJ/aEyDBi6KMj/VwzyYc9QM0dFrpmMobEFDmEVo93wUwpRV/xa83XZGvotAl
 lQXFzwitc2AFABewde5qSdW+Mm1I3Xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156215;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7j1lTWikv4eNJfTn4sTbOIjQZTZiKoOmajYWzxyhuRA=;
 b=79Tq42o0zslsBV9A2EafjwyEMP8No3hhS9YVi7y9i+3HKxhiBAnM6IzGvj9D0hPyJTllr9
 w3LFJAwPpLnZeMAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FBNXEjyP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZlErmOpc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7j1lTWikv4eNJfTn4sTbOIjQZTZiKoOmajYWzxyhuRA=;
 b=FBNXEjyPMehsCxVQ1lijuSex/YkHw9o0pWOhRCsSdYl3ix4s1/upMNF/VSZNyBye8vHWiR
 psA8ttIo4qFeB0O850jMizTScHqPtOllZuq7i70060+SnTHPqQYqQXlCiJnfja7IIYIJ6e
 JtuAtadTYG6wwXXnKB4nJTgLVImZevE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7j1lTWikv4eNJfTn4sTbOIjQZTZiKoOmajYWzxyhuRA=;
 b=ZlErmOpc/XeZFaCB+5W3ds5ky+/tPZnt4Ot++7SG6PkJDraayOwsfMjxpefbgWUnbzm1WF
 8hw1C0/jnEDOBaDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45795367A
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X7uGD/PWhWqMcwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:51 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Aug 2026 18:16:16 +0200
Message-ID: <20260819161634.1341577-14-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819161634.1341577-1-chrubis@suse.cz>
References: <20260819161634.1341577-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5BF8E3ED4
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_ONE(0.00)[1];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 13/31] testcases: sysfs: Add sys_bdi01
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
 runtest/sysfs                                |  1 +
 testcases/kernel/sysfs/class/bdi/.gitignore  |  1 +
 testcases/kernel/sysfs/class/bdi/Makefile    |  7 ++
 testcases/kernel/sysfs/class/bdi/sys_bdi01.c | 88 ++++++++++++++++++++
 4 files changed, 97 insertions(+)
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
index 000000000..85e7a65c4
--- /dev/null
+++ b/testcases/kernel/sysfs/class/bdi/sys_bdi01.c
@@ -0,0 +1,88 @@
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
+ * - min_bytes <= max_bytes, when max_bytes is set (0 means "no limit")
+ * - stable_pages_required and strict_limit are booleans
+ * - read_ahead_kb is non-negative
+ *
+ * The test skips with TCONF when no BDI is present.
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
+	max_bytes = TST_SYSFS_READ_LLI(BDI_CLASS "/%s/max_bytes", id);
+
+	if (max_bytes > 0) {
+		TST_SYSFS_ASSERT_LE_SUFFIX("min_bytes", "max_bytes",
+					   BDI_CLASS "/%s/", id);
+	}
+
+	TST_SYSFS_ASSERT_BOOL(BDI_CLASS "/%s/stable_pages_required", id);
+	TST_SYSFS_ASSERT_BOOL(BDI_CLASS "/%s/strict_limit", id);
+
+	TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX, BDI_CLASS "/%s/read_ahead_kb", id);
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
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
