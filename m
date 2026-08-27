Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3908DC61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:30:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7C053D56E0
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:30:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 425F93D8BAE
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F06A01A001D3
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 893141F8A3
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3D4cHqarX0FdIaOYUjTyHNhXLI31NX9c5i3DIVi7dPs=;
 b=s4nBb+U8TVRvlrEOr6HOPkjFgyBVD7mZ0Vd98hU1mErzV8hLloSqnKwYwe/23J6ydtYAKw
 tnJTgNW2lmweK4Z4GhWKMoTIU+irjV1C4b498Fh4P7BKyZN71DuWr9NkQIa27ozLlWk+VH
 4FhzQ2xLI8QZKgwmDsXdZPZasftgPP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829758;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3D4cHqarX0FdIaOYUjTyHNhXLI31NX9c5i3DIVi7dPs=;
 b=Izuwf8ocuLRZ0vGkJU+eCWb/5CHaK1XZRMboOLg3vuKuj3Mnp0VCvJV999Hu9LymFw+5Yc
 X0VEkPeHBY+gYUAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IIBCe85f;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SeBlpH5q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3D4cHqarX0FdIaOYUjTyHNhXLI31NX9c5i3DIVi7dPs=;
 b=IIBCe85fojVQC382JorY4r3MtlnteQj3PZEQXJsbNJioFH5rsWrtcpkEBRFkdq68W6qCuK
 Qq5wsXGlVXSKuPvwLDYhvXu0fYJ70680J+F7V7zISArRYeWPVWDr/piaCaIzFmDWAFPak9
 J5COKW0w3KhuZlIHrh9ICCR5HLty4AI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3D4cHqarX0FdIaOYUjTyHNhXLI31NX9c5i3DIVi7dPs=;
 b=SeBlpH5qYCdTEAAjtx35MKc/4fSaE+ylaxCeIAxsLo7RaeBcmOnWpT2Bsh7rubmZbKwKK1
 SnAFTuuAlGuM4BAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77FA41361C
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EpY6HPodkGqyawAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:34 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Aug 2026 13:21:57 +0200
Message-ID: <20260827112157.1748734-32-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827112157.1748734-1-chrubis@suse.cz>
References: <20260827112157.1748734-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 893141F8A3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 31/31] testcases: sysfs: Add sys_thp01
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
 .../mm/transparent_hugepage/sys_thp01.c       | 85 +++++++++++++++++++
 4 files changed, 94 insertions(+)
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
index 000000000..d243f8502
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/transparent_hugepage/sys_thp01.c
@@ -0,0 +1,85 @@
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
+#include "tst_path_defs.h"
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
+	if (access(PATH_MM_THP "/hpage_pmd_size", F_OK)) {
+		tst_res(TCONF, PATH_MM_THP "/hpage_pmd_size does not exist");
+		return;
+	}
+
+	TST_SYSFS_ASSERT_POW2(PATH_MM_THP "/hpage_pmd_size");
+
+	size = TST_SYSFS_READ_LI(PATH_MM_THP "/hpage_pmd_size");
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
+				PATH_MM_THP "/enabled");
+	TST_SYSFS_ASSERT_CHOICE(defrag_allowed, sel, sizeof(sel),
+				PATH_MM_THP "/defrag");
+	TST_SYSFS_ASSERT_CHOICE(shmem_allowed, sel, sizeof(sel),
+				PATH_MM_THP "/shmem_enabled");
+
+	TST_SYSFS_ASSERT_BOOL(PATH_MM_THP "/use_zero_page");
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
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
