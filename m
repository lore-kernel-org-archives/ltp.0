Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4FAC5DF7D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:20:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B13B53CCBC4
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 16:20:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BBFA83CD537
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:14:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 33F331A00354
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:14:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 930803E47
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mckdxFJD0f2S9kVL5HnIg7FDSrBtU4BtXKhzZ7RRtNk=;
 b=dIPcHu2N1nQ9BKzg6VQClRXVlNYCKm4/yEUsnvuY14nZI9vZHVczp4Y18It3WwQgM031GI
 3cNZRDE2Ba2pMVDmhii2i+xEX5ja5AsIwE1ENSsLvYzsg5Eb0uvjin/AH9pya2c86srbYL
 QC7lg4jULPe72fmWTl/cZskzr283f5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062436;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mckdxFJD0f2S9kVL5HnIg7FDSrBtU4BtXKhzZ7RRtNk=;
 b=cT61o2N39iWGR37XWgSsUYVUPcuaVSUWRRD5APyzBQGzNZA+wK1SJ7uTEa7Fevx6Uk2LWM
 arGYX7HUZX++tUAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Qj15GZxA;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nCOSymZt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mckdxFJD0f2S9kVL5HnIg7FDSrBtU4BtXKhzZ7RRtNk=;
 b=Qj15GZxAYHgjatZLjuI0RRrMkhXC6NrFM+MfC1XtTl1jBzIe905/wJEOPzlTrzuj3BFN9/
 v8XjWBWIDxC/mrjEMK9odpRRQRaEr5mhN5B83eHGQAzo5HterDTE3HnmUahbxfMSfVyHFW
 IRu7FgMONiiWN1cdx4s6fYJ5Y/S6N7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062432;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mckdxFJD0f2S9kVL5HnIg7FDSrBtU4BtXKhzZ7RRtNk=;
 b=nCOSymZt1x8+TKpmWLBg4PC7/J1Yy03WCRvztYUWEH2pmWwGjmS28H8YrJyh061xNOgNoa
 YNA2WYgny8O7KFAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39569367E
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8CnvDJ9ohGrGcQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:51 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Aug 2026 16:13:09 +0200
Message-ID: <20260818141311.1265557-30-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818141311.1265557-1-chrubis@suse.cz>
References: <20260818141311.1265557-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 930803E47
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_ONE(0.00)[1];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:email,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 29/31] testcases: sysfs: Add sys_ksm01
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
 testcases/kernel/sysfs/kernel/mm/ksm/Makefile |  7 ++
 .../kernel/sysfs/kernel/mm/ksm/sys_ksm01.c    | 64 +++++++++++++++++++
 4 files changed, 73 insertions(+)
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
index 000000000..04eb8744e
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/ksm/sys_ksm01.c
@@ -0,0 +1,64 @@
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
+ * - max_page_sharing is greater than zero
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
+
+#define KSM "/sys/kernel/mm/ksm"
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
+	TST_SYSFS_ASSERT_RANGELL(0, 2, KSM "/run");
+
+	TST_SYSFS_ASSERT_BOOL(KSM "/merge_across_nodes");
+	TST_SYSFS_ASSERT_BOOL(KSM "/use_zero_pages");
+
+	TST_SYSFS_ASSERT_RANGELL(1, LONG_MAX, KSM "/max_page_sharing");
+
+	for (i = 0; i < ARRAY_SIZE(nonneg_counters); i++) {
+		TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX, KSM "/%s",
+				       nonneg_counters[i]);
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
