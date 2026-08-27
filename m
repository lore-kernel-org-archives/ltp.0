Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD12FC61DC6
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:23:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 679AE3D71F3
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:23:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 006163D7D61
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5330060084A
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AFFA22193C
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZhS2FuH+bxVM7yPD7ZhjkXUO0p6C9ncGmJgjfAuOmA=;
 b=QeFD7uSGkBaW7P/Eju/lT1zjnTMPOtMRVagCiIUPui//6GtyGEtIPWdWfi9MnB0lGwXztG
 SBZYFfcFZp4ig0N1r6uSQpJOdc6cttf3wjeAn+5WVmr1/SSRiK41FB+ROthGXfN4Rl/P81
 FuvBYuKU6ogKefoId5WBVVB03DEPxso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829725;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZhS2FuH+bxVM7yPD7ZhjkXUO0p6C9ncGmJgjfAuOmA=;
 b=d5RnDgTVWt4YaiW2mMEkVCnCD7g1GpqO3pUsh7+5UQNmWAwW4YtIXctDl99vjPV65fgWG4
 IVHmh9cR1RqIg0CA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZvBMaxsC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vS6FkXRZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZhS2FuH+bxVM7yPD7ZhjkXUO0p6C9ncGmJgjfAuOmA=;
 b=ZvBMaxsCdZCAhoyUNHSbjvok5GlotznAzUIdjiosIDnblPjDTJcjRIJ1EnmeuA6Z1JLf+j
 5Ltfhk3M5uQTgt6Lh+aqu9cijUOrTMe4o09v/LpVnZDYJY3ilNQqjRPk0Ivh4blYyezfDp
 sXMdq2NiFhMlcMc8/I6BVGSeH5e/iU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829721;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZhS2FuH+bxVM7yPD7ZhjkXUO0p6C9ncGmJgjfAuOmA=;
 b=vS6FkXRZ3TzcE3sHb9/nZCL2q3EjRoCJl2kdTEyIhfarkT0WeiRBuUVbK9XrJxukqauGO2
 6p77EGmWbMidy1Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BAF113682
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hbX9JNkdkGpMawAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:01 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Aug 2026 13:21:30 +0200
Message-ID: <20260827112157.1748734-5-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827112157.1748734-1-chrubis@suse.cz>
References: <20260827112157.1748734-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: AFFA22193C
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 04/31] testcases: sysfs: Add sys_clocksource01
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

A test for /sys/devices/system/clocksource/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_path_defs.h                       |  3 +
 runtest/sysfs                                 |  1 +
 testcases/kernel/sysfs/devices/Makefile       |  7 ++
 .../kernel/sysfs/devices/system/Makefile      |  7 ++
 .../devices/system/clocksource/.gitignore     |  1 +
 .../sysfs/devices/system/clocksource/Makefile |  7 ++
 .../system/clocksource/sys_clocksource01.c    | 66 +++++++++++++++++++
 7 files changed, 92 insertions(+)
 create mode 100644 testcases/kernel/sysfs/devices/Makefile
 create mode 100644 testcases/kernel/sysfs/devices/system/Makefile
 create mode 100644 testcases/kernel/sysfs/devices/system/clocksource/.gitignore
 create mode 100644 testcases/kernel/sysfs/devices/system/clocksource/Makefile
 create mode 100644 testcases/kernel/sysfs/devices/system/clocksource/sys_clocksource01.c

diff --git a/include/tst_path_defs.h b/include/tst_path_defs.h
index 8d0e1170a..434e31af3 100644
--- a/include/tst_path_defs.h
+++ b/include/tst_path_defs.h
@@ -92,6 +92,9 @@
 #define MEMINFO_HPAGE_SURP	"HugePages_Surp:"
 #define MEMINFO_HPAGE_SIZE	"Hugepagesize:"
 
+/* SYSFS DEVICES */
+#define PATH_SYS_CLOCKSOURCE			"/sys/devices/system/clocksource"
+
 /* SYSFS */
 #define PATH_SYS_KERNEL				"/sys/kernel"
 #define PATH_SYS_POWER				"/sys/power"
diff --git a/runtest/sysfs b/runtest/sysfs
index 142b4a290..7c014a57e 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -1,2 +1,3 @@
 sys_power01 sys_power01
 sys_kernel01 sys_kernel01
+sys_clocksource01 sys_clocksource01
diff --git a/testcases/kernel/sysfs/devices/Makefile b/testcases/kernel/sysfs/devices/Makefile
new file mode 100644
index 000000000..5c8e7a249
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/sysfs/devices/system/Makefile b/testcases/kernel/sysfs/devices/system/Makefile
new file mode 100644
index 000000000..9bc26552c
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/sysfs/devices/system/clocksource/.gitignore b/testcases/kernel/sysfs/devices/system/clocksource/.gitignore
new file mode 100644
index 000000000..a04f05977
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/clocksource/.gitignore
@@ -0,0 +1 @@
+/sys_clocksource01
diff --git a/testcases/kernel/sysfs/devices/system/clocksource/Makefile b/testcases/kernel/sysfs/devices/system/clocksource/Makefile
new file mode 100644
index 000000000..781865569
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/clocksource/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sysfs/devices/system/clocksource/sys_clocksource01.c b/testcases/kernel/sysfs/devices/system/clocksource/sys_clocksource01.c
new file mode 100644
index 000000000..4f1215e80
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/clocksource/sys_clocksource01.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the clocksource attributes exported under
+ * /sys/devices/system/clocksource/clocksourceN/.
+ *
+ * available_clocksource lists all clocksources the kernel can switch to,
+ * while current_clocksource names the one that is active. Unlike the
+ * bracketed-choice files elsewhere in sysfs, the currently selected
+ * clocksource is not marked inside available_clocksource, so the two files
+ * have to be cross-checked explicitly. For every clocksourceN directory the
+ * test verifies that:
+ *
+ * - current_clocksource is non-empty
+ * - current_clocksource is one of the tokens listed in available_clocksource
+ *
+ * The test skips with TCONF when no clocksource directory is present.
+ */
+
+#include <string.h>
+#include <dirent.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+#include "tst_path_defs.h"
+
+static void check_clocksource(const char *name)
+{
+	char current[64] = "";
+
+	tst_res(TINFO, "Checking %s", name);
+
+	TST_SYSFS_READ_STR(current, sizeof(current),
+			   PATH_SYS_CLOCKSOURCE "/%s/current_clocksource", name);
+
+	TST_SYSFS_ASSERT_TOKENS(NULL, current,
+				PATH_SYS_CLOCKSOURCE "/%s/available_clocksource", name);
+}
+
+static void do_test(void)
+{
+	DIR *d;
+	struct dirent *ent;
+	int found = 0;
+
+	d = TST_SYSFS_TRY_OPENDIR(PATH_SYS_CLOCKSOURCE);
+
+	while ((ent = SAFE_READDIR(d))) {
+		if (strncmp(ent->d_name, "clocksource", 11))
+			continue;
+
+		found = 1;
+		check_clocksource(ent->d_name);
+	}
+
+	SAFE_CLOSEDIR(d);
+
+	if (!found)
+		tst_res(TCONF, "No clocksource directory found");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
