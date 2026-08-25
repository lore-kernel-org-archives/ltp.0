Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A257BC61DBD
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 11:45:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 218863C62EA
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 13:45:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D494A3C6FE1
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:36:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 098AA10009B5
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:36:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A82731F7BC
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7LAqjHy24M0I/4MU8Cwtr+UlqrxMVO5dhMWTI++KOQ=;
 b=b8wFPMHfLdlnHR65Wk8j4KERoJG/tcMo+bgnMY48W+GagXYl8LHKjiOLbvDH8q+r+1HWF0
 4pZmXzPMemtAHsjubwDUWW3RPN7yxUCYFT56bZuVtqRxirm3hW/io3GtBuou+FclfGGkfb
 cBm6Qd2BUBWGsDOD4iTHBfL5d6QjqVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657811;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7LAqjHy24M0I/4MU8Cwtr+UlqrxMVO5dhMWTI++KOQ=;
 b=y3xghtNnQU0iUAfiAX52dfuZQo52KSGe+hZyT0DIKiZRy1fk/4UM2LdzIiGsEXC0EfePVm
 OgYWARLB8FOElfCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7LAqjHy24M0I/4MU8Cwtr+UlqrxMVO5dhMWTI++KOQ=;
 b=b4JtQBM1N5mt6EVzHBuky55gv4lpT4UiVQjKGlPpxGPJgfJQ+6C/9J9aKuXNrRfWpvRPnZ
 Z6q0NflShTPTENZgeINZ77qM38hN/ZqrlZR5/oJ9S+vJvPEZ6QJnFXZ/yggHVSdChONnxw
 oC3uJKBgAfiUCxT/CEr1b8bkJMIc1r0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657807;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7LAqjHy24M0I/4MU8Cwtr+UlqrxMVO5dhMWTI++KOQ=;
 b=OEXYuFRi34AV45nJ69zbs+UYXrJnsR4fian6O5cToSSb9Fp7dDGtuoQA4iLTv6ITbgWSeb
 sD4kWFSmCUYkuoDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99CBC1342F
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0yOuJE9+jWp2SQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:47 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 25 Aug 2026 13:36:24 +0200
Message-ID: <20260825113625.1624134-31-chrubis@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 30/31] testcases: sysfs: Add sys_swap01
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

A test for /sys/kernel/mm/swap/vma_ra_enabled file.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |  1 +
 .../kernel/sysfs/kernel/mm/swap/.gitignore    |  1 +
 .../kernel/sysfs/kernel/mm/swap/Makefile      |  7 ++++
 .../sysfs/kernel/mm/swap/sys_mm_swap01.c      | 32 +++++++++++++++++++
 4 files changed, 41 insertions(+)
 create mode 100644 testcases/kernel/sysfs/kernel/mm/swap/.gitignore
 create mode 100644 testcases/kernel/sysfs/kernel/mm/swap/Makefile
 create mode 100644 testcases/kernel/sysfs/kernel/mm/swap/sys_mm_swap01.c

diff --git a/runtest/sysfs b/runtest/sysfs
index 08358ebc6..7d59ae701 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -25,3 +25,4 @@ sys_block_size01 sys_block_size01
 sys_hugepages01 sys_hugepages01
 sys_hugepages02 sys_hugepages02
 sys_ksm01 sys_ksm01
+sys_mm_swap01 sys_mm_swap01
diff --git a/testcases/kernel/sysfs/kernel/mm/swap/.gitignore b/testcases/kernel/sysfs/kernel/mm/swap/.gitignore
new file mode 100644
index 000000000..38895046b
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/swap/.gitignore
@@ -0,0 +1 @@
+/sys_mm_swap01
diff --git a/testcases/kernel/sysfs/kernel/mm/swap/Makefile b/testcases/kernel/sysfs/kernel/mm/swap/Makefile
new file mode 100644
index 000000000..781865569
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/swap/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sysfs/kernel/mm/swap/sys_mm_swap01.c b/testcases/kernel/sysfs/kernel/mm/swap/sys_mm_swap01.c
new file mode 100644
index 000000000..1b5a622f5
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/swap/sys_mm_swap01.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity check for /sys/kernel/mm/swap/vma_ra_enabled.
+ *
+ * Unlike most other boolean sysfs tunables which use 0/1, this one is
+ * formatted as the strings "true" or "false", so it needs its own check
+ * rather than TST_SYSFS_ASSERT_BOOL().
+ *
+ * The test skips with TCONF when the attribute is not present.
+ */
+
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+#define VMA_RA "/sys/kernel/mm/swap/vma_ra_enabled"
+
+static const char *const bool_str_allowed[] = {
+	"true", "false", NULL
+};
+
+static void do_test(void)
+{
+	TST_SYSFS_ASSERT_ONEOF(bool_str_allowed, VMA_RA);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
