Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E451C61DBD
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 11:45:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75E2F3C5E52
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 13:45:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 777AB3C61C4
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:36:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D57451A00CA2
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:36:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0AFF81F7D7
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9uZ/pn349kOc8+Id9tejBfX/JkBXI4vS+i6lzmY4j18=;
 b=M6oW4RqU4zbFAoEoqFtnvO/i3GUOYrba8hft0lBn/U0erTvupJG9fRIQ6UeOSdnCmbJgw6
 H05JWzCjNdvoLVR5ye9wEzcMMPKHsrJnLpl2+pJ2u8HltP4nljEnXM8K7iJovT3t5s4fCS
 j7jE1dPsQ8i39tutjZkLi48wfT6VvVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657812;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9uZ/pn349kOc8+Id9tejBfX/JkBXI4vS+i6lzmY4j18=;
 b=f/w8wj0rJCambziXUYfm4BFXt1LodvyTMkoV/ypJIfRW4+fqDewDvQ2qfYUQ1Hv3WJ5R7k
 FCn3FlkKmSUuQEAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gWRASa4A;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="y0y/h+3G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9uZ/pn349kOc8+Id9tejBfX/JkBXI4vS+i6lzmY4j18=;
 b=gWRASa4A6/a2QCu7Z9HOR7z6gy+ecBNVELPIzDqs3dNunCJZ4stITy+m3hHWHL4YZWleB0
 f/K96fL8Ub8IIxwMaF/+I4UWEHuemEhyo9QR2VuwLjAL/ySDdZhBo6TQr4jU9QqyNorQ0C
 cPupuh6/eYlDpeng1KxXKuoZzqV9C+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657808;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9uZ/pn349kOc8+Id9tejBfX/JkBXI4vS+i6lzmY4j18=;
 b=y0y/h+3Gj5AZZ+ToLlngz5rNZuKa9kb7xhpTIRh7RwDO/hwIjXAMqHu5Tn2GBsNp5swS2W
 3DdbcSeQIp9UMAAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F144813432
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HqEHOk9+jWp5SQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:47 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 25 Aug 2026 13:36:25 +0200
Message-ID: <20260825113625.1624134-32-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825113625.1624134-1-chrubis@suse.cz>
References: <20260825113625.1624134-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0AFF81F7D7
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 31/31] testcases: sysfs: Add sys_thp01
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

A test for /sys/kernel/mm/transparent_hugepage/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |  1 +
 .../kernel/mm/transparent_hugepage/.gitignore |  1 +
 .../kernel/mm/transparent_hugepage/Makefile   |  7 ++
 .../mm/transparent_hugepage/sys_thp01.c       | 86 +++++++++++++++++++
 4 files changed, 95 insertions(+)
 create mode 100644 testcases/kernel/sysfs/kernel/mm/transparent_hugepage/.gitignore
 create mode 100644 testcases/kernel/sysfs/kernel/mm/transparent_hugepage/Makefile
 create mode 100644 testcases/kernel/sysfs/kernel/mm/transparent_hugepage/sys_thp01.c

diff --git a/runtest/sysfs b/runtest/sysfs
index 7d59ae701..5eb8f81f8 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -26,3 +26,4 @@ sys_hugepages01 sys_hugepages01
 sys_hugepages02 sys_hugepages02
 sys_ksm01 sys_ksm01
 sys_mm_swap01 sys_mm_swap01
+sys_thp01 sys_thp01
diff --git a/testcases/kernel/sysfs/kernel/mm/transparent_hugepage/.gitignore b/testcases/kernel/sysfs/kernel/mm/transparent_hugepage/.gitignore
new file mode 100644
index 000000000..bdb564dfe
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/transparent_hugepage/.gitignore
@@ -0,0 +1 @@
+/sys_thp01
diff --git a/testcases/kernel/sysfs/kernel/mm/transparent_hugepage/Makefile b/testcases/kernel/sysfs/kernel/mm/transparent_hugepage/Makefile
new file mode 100644
index 000000000..781865569
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/transparent_hugepage/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sysfs/kernel/mm/transparent_hugepage/sys_thp01.c b/testcases/kernel/sysfs/kernel/mm/transparent_hugepage/sys_thp01.c
new file mode 100644
index 000000000..88200afa0
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/transparent_hugepage/sys_thp01.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the Transparent HugePage (THP) attributes exported under
+ * /sys/kernel/mm/transparent_hugepage/.
+ *
+ * The test verifies that:
+ *
+ * - enabled is a bracketed-choice file selecting one of always/madvise/never
+ * - defrag selects one of always/defer/defer+madvise/madvise/never
+ * - shmem_enabled selects one of always/within_size/advise/never/deny/force
+ * - use_zero_page is a boolean
+ * - hpage_pmd_size is a power of two and larger than the base page size
+ *
+ * All checks skip gracefully with TCONF when a particular attribute is not
+ * present, since the set of THP tunables differs between kernel versions.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+#define THP "/sys/kernel/mm/transparent_hugepage"
+
+static const char *const enabled_allowed[] = {
+	"always", "madvise", "never", NULL
+};
+
+static const char *const defrag_allowed[] = {
+	"always", "defer", "defer+madvise", "madvise", "never", NULL
+};
+
+static const char *const shmem_allowed[] = {
+	"always", "within_size", "advise", "never", "deny", "force", NULL
+};
+
+static void check_hpage_pmd_size(void)
+{
+	long size, pagesize;
+
+	if (access(THP "/hpage_pmd_size", F_OK)) {
+		tst_res(TCONF, THP "/hpage_pmd_size does not exist");
+		return;
+	}
+
+	TST_SYSFS_ASSERT_POW2(THP "/hpage_pmd_size");
+
+	size = TST_SYSFS_READ_LI(THP "/hpage_pmd_size");
+	pagesize = getpagesize();
+
+	if (size > pagesize) {
+		tst_res(TPASS, "hpage_pmd_size (%ld) > page size (%ld)",
+			size, pagesize);
+	} else {
+		tst_res(TFAIL, "hpage_pmd_size (%ld) <= page size (%ld)",
+			size, pagesize);
+	}
+}
+
+static void run(void)
+{
+	char sel[32];
+
+	TST_SYSFS_ASSERT_CHOICE(enabled_allowed, sel, sizeof(sel),
+				THP "/enabled");
+	TST_SYSFS_ASSERT_CHOICE(defrag_allowed, sel, sizeof(sel),
+				THP "/defrag");
+	TST_SYSFS_ASSERT_CHOICE(shmem_allowed, sel, sizeof(sel),
+				THP "/shmem_enabled");
+
+	TST_SYSFS_ASSERT_BOOL(THP "/use_zero_page");
+
+	check_hpage_pmd_size();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_TRANSPARENT_HUGEPAGE=y",
+		NULL
+	},
+};
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
