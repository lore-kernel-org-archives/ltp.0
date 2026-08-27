Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9B4C61DC6
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:29:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68A433D7D61
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:29:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92E783D7C3B
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B5418100094D
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A6302195D
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DABl6StapICY+KGLlpdrANQjg1o2D6mpQg4elXcQZEE=;
 b=qi0BLBffss3lhDbWZrkFkaN4Nvl2QDKyKvz7yu8SIq0Mw+BstUiNgHOI96n4783XjtVBis
 bRZNJ9aAsqoH7kuNfnO46LgYGkByiZlkimK7OTJnLfVFCI4Re9JdaW/P3TZMQfAGni6WcS
 TZ95v6Odk3d52YBfpCRLrjrHDD/YVd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829758;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DABl6StapICY+KGLlpdrANQjg1o2D6mpQg4elXcQZEE=;
 b=NFVTsHk8ScnsQzOb22gxqTl6l5eazIiwhS7M0/0r+40BOPY2RADKX+0KypoyU6Ga1hcK46
 U79mca/Uu4J8dqAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xmrBsYyH;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YhkgbvJS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DABl6StapICY+KGLlpdrANQjg1o2D6mpQg4elXcQZEE=;
 b=xmrBsYyHvEMGTlU4/tYiF0aVmwE97a4jl2KqT89vGiyoDg01ewcGsH1aAE4EQdXAxU9LcB
 p3nuAKPjYUtqqznNuNd+ikxez7iGFRA2Crr1Qsb+T1t6jUSV0lTm0YGDu2WwfQOSsDHJVR
 n+5wNo2jZ4Vo6Qx7hM1FpB+cgpJjV5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DABl6StapICY+KGLlpdrANQjg1o2D6mpQg4elXcQZEE=;
 b=YhkgbvJSS4VKOfonxb7qb+tTW6bgr4cOJk3nXVlROxthjsFV61p8gIPI4JTPnTtipJFa0v
 iDJ7lbJngndioBBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B8BC13533
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VqC1JPkdkGquawAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:33 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Aug 2026 13:21:55 +0200
Message-ID: <20260827112157.1748734-30-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827112157.1748734-1-chrubis@suse.cz>
References: <20260827112157.1748734-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 1A6302195D
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.cz:mid];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 29/31] testcases: sysfs: Add sys_ksm01
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

A test for /sys/kernel/mm/ksm/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |  1 +
 .../kernel/sysfs/kernel/mm/ksm/.gitignore     |  1 +
 testcases/kernel/sysfs/kernel/mm/ksm/Makefile |  7 +++
 .../kernel/sysfs/kernel/mm/ksm/sys_ksm01.c    | 63 +++++++++++++++++++
 4 files changed, 72 insertions(+)
 create mode 100644 testcases/kernel/sysfs/kernel/mm/ksm/.gitignore
 create mode 100644 testcases/kernel/sysfs/kernel/mm/ksm/Makefile
 create mode 100644 testcases/kernel/sysfs/kernel/mm/ksm/sys_ksm01.c

diff --git a/runtest/sysfs b/runtest/sysfs
index ec38d8b44..08358ebc6 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -24,3 +24,4 @@ sys_block_queue01 sys_block_queue01
 sys_block_size01 sys_block_size01
 sys_hugepages01 sys_hugepages01
 sys_hugepages02 sys_hugepages02
+sys_ksm01 sys_ksm01
diff --git a/testcases/kernel/sysfs/kernel/mm/ksm/.gitignore b/testcases/kernel/sysfs/kernel/mm/ksm/.gitignore
new file mode 100644
index 000000000..92fa7e2c1
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/ksm/.gitignore
@@ -0,0 +1 @@
+/sys_ksm01
diff --git a/testcases/kernel/sysfs/kernel/mm/ksm/Makefile b/testcases/kernel/sysfs/kernel/mm/ksm/Makefile
new file mode 100644
index 000000000..781865569
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/ksm/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sysfs/kernel/mm/ksm/sys_ksm01.c b/testcases/kernel/sysfs/kernel/mm/ksm/sys_ksm01.c
new file mode 100644
index 000000000..c53ff551a
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/ksm/sys_ksm01.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the Kernel Samepage Merging (KSM) attributes exported
+ * under /sys/kernel/mm/ksm/.
+ *
+ * The test verifies that:
+ *
+ * - run is one of 0 (stop), 1 (run) or 2 (unmerge)
+ * - merge_across_nodes and use_zero_pages are booleans
+ * - max_page_sharing is greater than 2 and less than INT_MAX
+ * - pages_to_scan and sleep_millisecs are non-negative
+ * - the page accounting counters (pages_shared, pages_sharing, pages_unshared,
+ *   pages_volatile, stable_node_chains, stable_node_dups) are non-negative
+ *
+ * All checks skip gracefully with TCONF when a particular attribute is not
+ * present, since the set of KSM tunables differs between kernel versions.
+ */
+
+#include <limits.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+#include "tst_path_defs.h"
+
+static const char *const nonneg_counters[] = {
+	"pages_shared",
+	"pages_sharing",
+	"pages_unshared",
+	"pages_volatile",
+	"stable_node_chains",
+	"stable_node_dups",
+	"pages_to_scan",
+	"sleep_millisecs",
+};
+
+static void do_test(void)
+{
+	unsigned int i;
+
+	/* 0 = stop, 1 = merge, 2 = unmerge */
+	TST_SYSFS_ASSERT_RANGELL(0, 2, PATH_MM_KSM "/run");
+
+	TST_SYSFS_ASSERT_BOOL(PATH_MM_KSM "/merge_across_nodes");
+	TST_SYSFS_ASSERT_BOOL(PATH_MM_KSM "/use_zero_pages");
+
+	TST_SYSFS_ASSERT_RANGELL(2, INT_MAX, PATH_MM_KSM "/max_page_sharing");
+
+	for (i = 0; i < ARRAY_SIZE(nonneg_counters); i++) {
+		TST_SYSFS_ASSERT_RANGEUU(0, ULONG_MAX, PATH_MM_KSM "/%s",
+					 nonneg_counters[i]);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_KSM=y",
+		NULL
+	},
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
