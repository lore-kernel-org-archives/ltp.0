Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59436C5DF85
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 16:17:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6E733C57A0
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 18:17:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 585AB3C57A0
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:16:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8C1D41400994
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:16:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D407584C11
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MGhNOLgDG7ND0GuiIKtkmm+ao08x0muoZxwFDQ0/wUA=;
 b=TaWFcQ+LIj14QWu0wfVil/PXm6XaAk8JMPH2ICB0j1rYqld9/jK3WbwfKF5mXEb9Di0AUH
 X0ImiPJdKZn5bpRRLP+h5zmUPbWkVqMkPlsfxBlUSaozEc7b5dSZqdMhT7iA1Cyy6O9zUO
 NZaBQ/r1J1mUN3SjLQZXTr0mnGqT9A4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156202;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MGhNOLgDG7ND0GuiIKtkmm+ao08x0muoZxwFDQ0/wUA=;
 b=1Kt6NH5x/kbySLJIaF5Wt7RewwVASpA8UpLOlLISZHZpsErukbSO3W/wyIPs8wi4Ff97Ja
 kuAxeaL/iV1TuIDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MGhNOLgDG7ND0GuiIKtkmm+ao08x0muoZxwFDQ0/wUA=;
 b=C3dxBzdW2YqTMsYCmgsLoR3B9Ig5g7EYFgGS1t+IGciaW709Q6Cbpk6srhU/QBfFUi1SL1
 EOYE1Gw+k/wrkUNvLMkTZuRH+KBFzeMPSYUEK1F3WGpUh3VD95LCsat43/GPrO8+CyYXda
 1w1U8f0yzB5i/ZWghfZe6We4bbHDQXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156198;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MGhNOLgDG7ND0GuiIKtkmm+ao08x0muoZxwFDQ0/wUA=;
 b=Os4JXrTbMZziPQAC4xSwJjgz6u581gy1tJ9mNSUE/1InzTSC3C3U7Y1SkZzHbd6JXdpoDJ
 J0MflMMfK6hldiAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF332364F
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id us20LebWhWrpcgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:38 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Aug 2026 18:16:05 +0200
Message-ID: <20260819161634.1341577-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819161634.1341577-1-chrubis@suse.cz>
References: <20260819161634.1341577-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.19)[-0.953];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 02/31] testcases: sysfs: Add sys_power01
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

A test for sysfs/power/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                              |  1 +
 testcases/kernel/Makefile                  |  1 +
 testcases/kernel/sysfs/Makefile            |  7 +++
 testcases/kernel/sysfs/power/.gitignore    |  1 +
 testcases/kernel/sysfs/power/Makefile      |  7 +++
 testcases/kernel/sysfs/power/sys_power01.c | 66 ++++++++++++++++++++++
 6 files changed, 83 insertions(+)
 create mode 100644 runtest/sysfs
 create mode 100644 testcases/kernel/sysfs/Makefile
 create mode 100644 testcases/kernel/sysfs/power/.gitignore
 create mode 100644 testcases/kernel/sysfs/power/Makefile
 create mode 100644 testcases/kernel/sysfs/power/sys_power01.c

diff --git a/runtest/sysfs b/runtest/sysfs
new file mode 100644
index 000000000..e679cacb1
--- /dev/null
+++ b/runtest/sysfs
@@ -0,0 +1 @@
+sys_power01 sys_power01
diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index ac816e4e8..6b8367fe0 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -36,6 +36,7 @@ SUBDIRS			+= connectors \
 			   sched \
 			   security \
 			   sound \
+			   sysfs \
 			   thermal \
 			   tracing \
 			   uevents \
diff --git a/testcases/kernel/sysfs/Makefile b/testcases/kernel/sysfs/Makefile
new file mode 100644
index 000000000..654cda49e
--- /dev/null
+++ b/testcases/kernel/sysfs/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/sysfs/power/.gitignore b/testcases/kernel/sysfs/power/.gitignore
new file mode 100644
index 000000000..835842cd0
--- /dev/null
+++ b/testcases/kernel/sysfs/power/.gitignore
@@ -0,0 +1 @@
+/sys_power01
diff --git a/testcases/kernel/sysfs/power/Makefile b/testcases/kernel/sysfs/power/Makefile
new file mode 100644
index 000000000..66e633f40
--- /dev/null
+++ b/testcases/kernel/sysfs/power/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sysfs/power/sys_power01.c b/testcases/kernel/sysfs/power/sys_power01.c
new file mode 100644
index 000000000..3c78719e5
--- /dev/null
+++ b/testcases/kernel/sysfs/power/sys_power01.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the power management attributes exported under
+ * /sys/power/.
+ *
+ * The test verifies that:
+ *
+ * - pm_async, pm_debug_messages, pm_print_times and sync_on_suspend are
+ *   booleans
+ * - pm_freeze_timeout and wakeup_count are non-negative
+ * - disk is a bracketed-choice file selecting one of platform, shutdown,
+ *   reboot, suspend, test_resume or firmware
+ * - mem_sleep is a bracketed-choice file selecting one of s2idle, shallow or
+ *   deep
+ * - state lists only known sleep states (freeze, standby, mem, disk, on)
+ *
+ * Unlike disk and mem_sleep, state never marks a "current" value with
+ * brackets, it merely enumerates the sleep states the kernel supports, so it
+ * is validated as a plain token set rather than a bracketed choice.
+ *
+ * All checks skip gracefully with TCONF when a particular attribute is not
+ * present.
+ */
+
+#include <limits.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+#define POWER "/sys/power"
+
+static const char *const disk_allowed[] = {
+	"platform", "shutdown", "reboot", "suspend", "test_resume",
+	"firmware", NULL
+};
+
+static const char *const mem_sleep_allowed[] = {
+	"s2idle", "shallow", "deep", NULL
+};
+
+static const char *const state_allowed[] = {
+	"freeze", "standby", "mem", "disk", "on", NULL
+};
+
+static void do_test(void)
+{
+	TST_SYSFS_ASSERT_BOOL(POWER "/pm_async");
+	TST_SYSFS_ASSERT_BOOL(POWER "/pm_debug_messages");
+	TST_SYSFS_ASSERT_BOOL(POWER "/pm_print_times");
+	TST_SYSFS_ASSERT_BOOL(POWER "/sync_on_suspend");
+
+	TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX, POWER "/pm_freeze_timeout");
+	TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX, POWER "/wakeup_count");
+
+	TST_SYSFS_ASSERT_CHOICE(disk_allowed, NULL, 0, POWER "/disk");
+	TST_SYSFS_ASSERT_CHOICE(mem_sleep_allowed, NULL, 0, POWER "/mem_sleep");
+
+	TST_SYSFS_ASSERT_TOKENS(state_allowed, NULL, POWER "/state");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
