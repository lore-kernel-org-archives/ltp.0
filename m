Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CF7C61DBE
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 11:37:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36EA83C61C4
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 13:37:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29EF53C5E2C
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:36:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AED3D20016D
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:36:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 124EE1F7E1
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hYybV0U75pToS+tlKyZd1HoCc6gMtFGE1Aqy6SB+gJY=;
 b=zpY7VwteZ+EOy643L2rZ0XPJa5DoPa2hfUflHC7pdv8fOWl/LeqRqcf2spw7/lT9I9Ci4O
 HICHYUs7ISdtn4yPrT9yUG3vjXZdol/1eMCDc0+Ba5v3Yo0SEd5k2G9WG/l6g071lXKUbA
 NpRKVhyQAUmyhKT3OnFjQcRxmL41Gxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657789;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hYybV0U75pToS+tlKyZd1HoCc6gMtFGE1Aqy6SB+gJY=;
 b=QBAG5PS3BEBvm24Fl+ZscEW/FXXsO6AFHXJNdwniHn4bI9piJR8GQoxpJahpz6IS2O9B8l
 PZrBuj6wJjraMVDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hYybV0U75pToS+tlKyZd1HoCc6gMtFGE1Aqy6SB+gJY=;
 b=xOlQ9CAiD7eH56r6XcmVk0k3F67VktLc2IJ2I4UzreYLm2U8iaY2iQ8wLkCINkpfr41xZY
 2r9FnudVWcE9N/TY7mYNXvXoO9p2JXCoun16rhF0JNooPDfy40Y55Aw7Y855XjDhypA854
 mBMvdtBrxDCP8Hxmc0+3Co4SBHZB5Jg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657785;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hYybV0U75pToS+tlKyZd1HoCc6gMtFGE1Aqy6SB+gJY=;
 b=h5HupQ0GSuN/gRlO5s6J9nVLFzKTb7nhH3NBT9/IBjrLdi5qOKWS7/myOMIbTZjoOrj2n5
 T6a1DhnrbetsNZDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E58401339D
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8mseNzh+jWofSAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:24 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 25 Aug 2026 13:35:58 +0200
Message-ID: <20260825113625.1624134-5-chrubis@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 04/31] testcases: sysfs: Add sys_clocksource01
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
 runtest/sysfs                                 |  1 +
 testcases/kernel/sysfs/devices/Makefile       |  7 ++
 .../kernel/sysfs/devices/system/Makefile      |  7 ++
 .../devices/system/clocksource/.gitignore     |  1 +
 .../sysfs/devices/system/clocksource/Makefile |  7 ++
 .../system/clocksource/sys_clocksource01.c    | 67 +++++++++++++++++++
 6 files changed, 90 insertions(+)
 create mode 100644 testcases/kernel/sysfs/devices/Makefile
 create mode 100644 testcases/kernel/sysfs/devices/system/Makefile
 create mode 100644 testcases/kernel/sysfs/devices/system/clocksource/.gitignore
 create mode 100644 testcases/kernel/sysfs/devices/system/clocksource/Makefile
 create mode 100644 testcases/kernel/sysfs/devices/system/clocksource/sys_clocksource01.c

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
index 000000000..534caddd8
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/clocksource/sys_clocksource01.c
@@ -0,0 +1,67 @@
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
+
+#define CLOCKSOURCE "/sys/devices/system/clocksource"
+
+static void check_clocksource(const char *name)
+{
+	char current[64] = "";
+
+	tst_res(TINFO, "Checking %s", name);
+
+	TST_SYSFS_READ_STR(current, sizeof(current),
+			   CLOCKSOURCE "/%s/current_clocksource", name);
+
+	TST_SYSFS_ASSERT_TOKENS(NULL, current,
+				CLOCKSOURCE "/%s/available_clocksource", name);
+}
+
+static void do_test(void)
+{
+	DIR *d;
+	struct dirent *ent;
+	int found = 0;
+
+	d = SAFE_OPENDIR(CLOCKSOURCE);
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
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
