Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803A2C61DC6
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:30:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1AB93D8761
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:30:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F141E3D7DDF
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B57306008DB
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A1C621942
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f6WiTM4tVdiQ5g8EdrEEXRTzrrbpKBaRlowE1NmTOEM=;
 b=yDsiui6+3+B693bE+xQfrl7oCu79peB/Pbx5AU3HnGwt8aOm7Q2rHrPcsuXxsWUgoYaHcW
 EMiLShfzg36W2r5TQyL2Rxte7jwu0ilPGvazxuoM4WqD1Kaf5QD2TJ/FMs1pZ/2I1yRce1
 xVZhEAkv6Ylfr2bg/4Gcj2VqFP98POM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829758;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f6WiTM4tVdiQ5g8EdrEEXRTzrrbpKBaRlowE1NmTOEM=;
 b=UtODGmjvvNwsq7lwQoVUeSz/Nx0zn9c6f8DhR5N0XhCsTAPfRPd1PgbwDosPJxQJD7k5Kt
 BP557wvtRQYNdaCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f6WiTM4tVdiQ5g8EdrEEXRTzrrbpKBaRlowE1NmTOEM=;
 b=sPSJMFMhZcQE7ZGDze8VUY4HzoEUjrQ+yJzw1L988sN3ebS2GyxJHdNO2tiUC2czTfBdmj
 Ondrp6QKBHusWUgO34qen6t5cx8spJPSdAAN/SloKRzKpLHBY+y0OoAggP5Oo/VQ/nogA4
 +nEqRzSk/YkAf84qSP8jmcud2xzcjhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f6WiTM4tVdiQ5g8EdrEEXRTzrrbpKBaRlowE1NmTOEM=;
 b=qKKeZ8ndHkM3KJ4XVGFIlhj+yg7LYWz0u/wU8JN0BTunBDME6evZDy1Q1sLYWe/0d7xmnp
 BugPE6CCXka8e4Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 387091352D
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a8DcDPkdkGqsawAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:33 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Aug 2026 13:21:54 +0200
Message-ID: <20260827112157.1748734-29-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827112157.1748734-1-chrubis@suse.cz>
References: <20260827112157.1748734-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.996];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 28/31] testcases: sysfs: Add sys_hugepages02
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

A test for /sys/kernel/mm/hugepages/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |  1 +
 .../sysfs/kernel/mm/hugepages/.gitignore      |  1 +
 .../kernel/mm/hugepages/sys_hugepages02.c     | 86 +++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 testcases/kernel/sysfs/kernel/mm/hugepages/sys_hugepages02.c

diff --git a/runtest/sysfs b/runtest/sysfs
index a81fbc12e..ec38d8b44 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -23,3 +23,4 @@ sys_block_loop01 sys_block_loop01
 sys_block_queue01 sys_block_queue01
 sys_block_size01 sys_block_size01
 sys_hugepages01 sys_hugepages01
+sys_hugepages02 sys_hugepages02
diff --git a/testcases/kernel/sysfs/kernel/mm/hugepages/.gitignore b/testcases/kernel/sysfs/kernel/mm/hugepages/.gitignore
index 1c66028fb..1bebeb2c0 100644
--- a/testcases/kernel/sysfs/kernel/mm/hugepages/.gitignore
+++ b/testcases/kernel/sysfs/kernel/mm/hugepages/.gitignore
@@ -1 +1,2 @@
 /sys_hugepages01
+/sys_hugepages02
diff --git a/testcases/kernel/sysfs/kernel/mm/hugepages/sys_hugepages02.c b/testcases/kernel/sysfs/kernel/mm/hugepages/sys_hugepages02.c
new file mode 100644
index 000000000..c30b357e1
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/hugepages/sys_hugepages02.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Cross-checks the default hugepage pool in sysfs against /proc/meminfo.
+ *
+ * /proc/meminfo describes the default hugepage size pool, which corresponds to
+ * one of the hugepages-<size>kB directories under /sys/kernel/mm/hugepages/.
+ * The test verifies that for the default pool:
+ *
+ * - Hugepagesize in /proc/meminfo matches the default pool directory size
+ * - HugePages_Total matches nr_hugepages
+ * - HugePages_Free matches free_hugepages
+ * - HugePages_Rsvd matches resv_hugepages
+ * - HugePages_Surp matches surplus_hugepages
+ *
+ * The test skips with TCONF when hugepages are not available.
+ */
+
+#include <stdio.h>
+#include <limits.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+#include "tst_path_defs.h"
+
+static void compare(const char *what, const char *meminfo_key, const char *attr,
+		    long hugepagesize)
+{
+	char path[PATH_MAX];
+	long meminfo_val, sysfs_val;
+
+	SAFE_FILE_LINES_SCANF("/proc/meminfo", meminfo_key, &meminfo_val);
+
+	snprintf(path, sizeof(path), PATH_MM_HUGEPAGES "/hugepages-%ldkB/%s",
+		 hugepagesize, attr);
+	SAFE_FILE_SCANF(path, "%ld", &sysfs_val);
+
+	if (meminfo_val == sysfs_val) {
+		tst_res(TPASS, "%s: /proc/meminfo (%ld) == %s (%ld)",
+			what, meminfo_val, attr, sysfs_val);
+	} else {
+		tst_res(TFAIL, "%s: /proc/meminfo (%ld) != %s (%ld)",
+			what, meminfo_val, attr, sysfs_val);
+	}
+}
+
+static void do_test(void)
+{
+	long hugepagesize;
+
+	if (FILE_LINES_SCANF("/proc/meminfo", MEMINFO_HPAGE_SIZE " %ld",
+			     &hugepagesize)) {
+		tst_res(TCONF, "No Hugepagesize in /proc/meminfo");
+		return;
+	}
+
+	if (!tst_sysfs_exists(PATH_MM_HUGEPAGES "/hugepages-%ldkB", hugepagesize)) {
+		tst_res(TCONF,
+			"Default hugepage pool hugepages-%ldkB not found in sysfs",
+			hugepagesize);
+		return;
+	}
+
+	tst_res(TPASS,
+		"/proc/meminfo Hugepagesize (%ld kB) has a matching sysfs pool",
+		hugepagesize);
+
+	compare("HugePages_Total", MEMINFO_HPAGE_TOTAL " %ld",
+		"nr_hugepages", hugepagesize);
+	compare("HugePages_Free", MEMINFO_HPAGE_FREE " %ld",
+		"free_hugepages", hugepagesize);
+	compare("HugePages_Rsvd", MEMINFO_HPAGE_RSVD " %ld",
+		"resv_hugepages", hugepagesize);
+	compare("HugePages_Surp", MEMINFO_HPAGE_SURP " %ld",
+		"surplus_hugepages", hugepagesize);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_HUGETLBFS=y",
+		NULL
+	},
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
