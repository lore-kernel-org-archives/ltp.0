Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA64C61DC6
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:22:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DEA53D5989
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:22:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 755CD3D20BA
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C6B3D1A008B9
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C47A621903
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1JvWGEMohEQagHf28OheZYae/M0LO1DwyngvRBUH9L8=;
 b=ZsZtLHGzzL5bB43q8zGp/h8MdSQ1QMJs4W1AfSFlNxDywN5YpQUa9+l7V4uaZcN1S1HSi1
 YQlndbdJRq+DAH1wIUsQQ1rz5mR2+rrNQ/xYhUEoPR39gbgMkd8DccDSDU5QqP+Anz6nEF
 OLiP1pY7O/4HfKf2gypDCZ0ntH/eEO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829720;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1JvWGEMohEQagHf28OheZYae/M0LO1DwyngvRBUH9L8=;
 b=31fVljcAVK8qnxVMWCHZVZkl8dG29R6TpluB+CyCMHvX68KzrINvvQ9h4fqQ65GdQx9zj/
 2Rt3LtzC2fQELbAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=u4yS9ABl;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5Eih3YSv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1JvWGEMohEQagHf28OheZYae/M0LO1DwyngvRBUH9L8=;
 b=u4yS9ABlqyKXrThbNOc1+gyPmqA0QuXswVSCVXa9oB8cfXvIogsupxHSci+K+cyKOZ3T4b
 X4KuwUaKLY51tW6H1/Rdg08Ued4Vx9zgvQw1PhVV5DQvHTz+sh2nBRtDzRz8BpT6FSMSdP
 TktJWL4cOYZGXx4CRbf+z6EyG8ooVqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829716;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1JvWGEMohEQagHf28OheZYae/M0LO1DwyngvRBUH9L8=;
 b=5Eih3YSvDZ7VAZqQr/daazw7um/wKQPWUqh6miBDSXR2WYNI6IDcBd1kO7jfPhqWQPzvCr
 nXyps2ODdtHee9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9A311361C
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:21:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DvrTJ9QdkGpCawAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:21:56 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Aug 2026 13:21:28 +0200
Message-ID: <20260827112157.1748734-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827112157.1748734-1-chrubis@suse.cz>
References: <20260827112157.1748734-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: C47A621903
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.cz:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 02/31] testcases: sysfs: Add sys_power01
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
 include/tst_path_defs.h                    |  3 +
 runtest/sysfs                              |  1 +
 testcases/kernel/Makefile                  |  1 +
 testcases/kernel/sysfs/Makefile            |  7 +++
 testcases/kernel/sysfs/power/.gitignore    |  1 +
 testcases/kernel/sysfs/power/Makefile      |  7 +++
 testcases/kernel/sysfs/power/sys_power01.c | 70 ++++++++++++++++++++++
 7 files changed, 90 insertions(+)
 create mode 100644 runtest/sysfs
 create mode 100644 testcases/kernel/sysfs/Makefile
 create mode 100644 testcases/kernel/sysfs/power/.gitignore
 create mode 100644 testcases/kernel/sysfs/power/Makefile
 create mode 100644 testcases/kernel/sysfs/power/sys_power01.c

diff --git a/include/tst_path_defs.h b/include/tst_path_defs.h
index 35fb24274..b13559af8 100644
--- a/include/tst_path_defs.h
+++ b/include/tst_path_defs.h
@@ -92,4 +92,7 @@
 #define MEMINFO_HPAGE_SURP	"HugePages_Surp:"
 #define MEMINFO_HPAGE_SIZE	"Hugepagesize:"
 
+/* SYSFS */
+#define PATH_SYS_POWER				"/sys/power"
+
 #endif /* TST_PATH_DEFS__ */
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
index 000000000..0c8430ca9
--- /dev/null
+++ b/testcases/kernel/sysfs/power/sys_power01.c
@@ -0,0 +1,70 @@
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
+ *   reboot, suspend, test_resume or disabled. disk_show() in
+ *   kernel/power/hibernate.c reports ``[disabled]`` as the sole token whenever
+ *   hibernation_available() is false, e.g. because of the ``nohibernate`` boot
+ *   parameter, kernel lockdown (common on Secure Boot enabled distributions)
+ *   restricting LOCKDOWN_HIBERNATION, secretmem being in use, or CXL memory
+ *   being active
+ * - mem_sleep is a bracketed-choice file selecting one of s2idle, shallow or
+ *   deep
+ * - state lists only known sleep states (freeze, standby, mem, disk)
+ *
+ * Unlike disk and mem_sleep, state never marks a ``current`` value with
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
+#include "tst_path_defs.h"
+
+static const char *const disk_allowed[] = {
+	"platform", "shutdown", "reboot", "suspend", "test_resume",
+	"disabled", NULL
+};
+
+static const char *const mem_sleep_allowed[] = {
+	"s2idle", "shallow", "deep", NULL
+};
+
+static const char *const state_allowed[] = {
+	"freeze", "standby", "mem", "disk", NULL
+};
+
+static void do_test(void)
+{
+	TST_SYSFS_ASSERT_BOOL(PATH_SYS_POWER "/pm_async");
+	TST_SYSFS_ASSERT_BOOL(PATH_SYS_POWER "/pm_debug_messages");
+	TST_SYSFS_ASSERT_BOOL(PATH_SYS_POWER "/pm_print_times");
+	TST_SYSFS_ASSERT_BOOL(PATH_SYS_POWER "/sync_on_suspend");
+
+	TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX, PATH_SYS_POWER "/pm_freeze_timeout");
+	TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX, PATH_SYS_POWER "/wakeup_count");
+
+	TST_SYSFS_ASSERT_CHOICE(disk_allowed, NULL, 0, PATH_SYS_POWER "/disk");
+	TST_SYSFS_ASSERT_CHOICE(mem_sleep_allowed, NULL, 0, PATH_SYS_POWER "/mem_sleep");
+
+	TST_SYSFS_ASSERT_TOKENS(state_allowed, NULL, PATH_SYS_POWER "/state");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
