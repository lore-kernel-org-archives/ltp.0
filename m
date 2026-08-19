Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85798C5DF85
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 16:22:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2D773CD694
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 18:22:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFA123CD6B2
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:17:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 358BA60086D
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:17:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B803C84C1D
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lua5i2a+dQWpVRgOTA+xPbJs45KXiKG0xWzCxf5ZAto=;
 b=ZPkCmc688rmwpidwzJUqHmWsquQaRAes76zzo8TcoUWh7xWscIx5XOB/ryOMbB7SA9+CRv
 6o/e9J0ZOXs5Z0zY3/gmypC7OdDoDZ3KWmGI5o9SNUsqwVJ5rqNkWS9OmpMpgtNhDwU2o1
 xF0AOVbHjScChlXEwzVbVMLrdEGKmA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lua5i2a+dQWpVRgOTA+xPbJs45KXiKG0xWzCxf5ZAto=;
 b=7cTXhSeZU8sfm5DmyPc/LwqPlM1zGVcV3BB6jeXTmSNKGuRYJSpny9jw+Q1S4Ix9BrVlM3
 RZobbpzKi8DG4LBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lua5i2a+dQWpVRgOTA+xPbJs45KXiKG0xWzCxf5ZAto=;
 b=Alc1G/yJMJHd/7+IqlHz3/bhEFPnG8TzPpsQtuzlgpU54pMG/jRZtGIptBDxtk7RH9hQMh
 LcX44vDh3vIKRlsrSwn7kEp/7LEIjlt1vTMSwC2LxajXlUasLPZZbzaI1eHmbROFEmT6XO
 yDhn98LTjXQXBxLB1h5BVeWlJYoxj/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156214;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lua5i2a+dQWpVRgOTA+xPbJs45KXiKG0xWzCxf5ZAto=;
 b=k2qHfzLN2YiM0gv09/3a3RbrJpU5zIk4+wNCazifw1QUYuKp2JygYFLknC5mBt7ITxfdRm
 1Pdx2sSg5L1L1dCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41B1A3686
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id e9YdD/XWhWqYcwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:53 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Aug 2026 18:16:21 +0200
Message-ID: <20260819161634.1341577-19-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819161634.1341577-1-chrubis@suse.cz>
References: <20260819161634.1341577-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.19)[-0.952];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 18/31] testcases: sysfs: Add sys_thermal01
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

A test for /sys/class/thermal/cooling_device*/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |  1 +
 .../kernel/sysfs/class/thermal/.gitignore     |  1 +
 testcases/kernel/sysfs/class/thermal/Makefile |  7 ++
 .../sysfs/class/thermal/sys_thermal01.c       | 73 +++++++++++++++++++
 4 files changed, 82 insertions(+)
 create mode 100644 testcases/kernel/sysfs/class/thermal/.gitignore
 create mode 100644 testcases/kernel/sysfs/class/thermal/Makefile
 create mode 100644 testcases/kernel/sysfs/class/thermal/sys_thermal01.c

diff --git a/runtest/sysfs b/runtest/sysfs
index de58499be..454042ed0 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -14,3 +14,4 @@ sys_hwmon01 sys_hwmon01
 sys_leds01 sys_leds01
 sys_wakeup01 sys_wakeup01
 sys_rtc01 sys_rtc01
+sys_thermal01 sys_thermal01
diff --git a/testcases/kernel/sysfs/class/thermal/.gitignore b/testcases/kernel/sysfs/class/thermal/.gitignore
new file mode 100644
index 000000000..c551a2cde
--- /dev/null
+++ b/testcases/kernel/sysfs/class/thermal/.gitignore
@@ -0,0 +1 @@
+/sys_thermal01
diff --git a/testcases/kernel/sysfs/class/thermal/Makefile b/testcases/kernel/sysfs/class/thermal/Makefile
new file mode 100644
index 000000000..034038061
--- /dev/null
+++ b/testcases/kernel/sysfs/class/thermal/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sysfs/class/thermal/sys_thermal01.c b/testcases/kernel/sysfs/class/thermal/sys_thermal01.c
new file mode 100644
index 000000000..2ed1167ab
--- /dev/null
+++ b/testcases/kernel/sysfs/class/thermal/sys_thermal01.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the thermal cooling devices exported under
+ * /sys/class/thermal/cooling_deviceN/.
+ *
+ * For every cooling device the test verifies that:
+ *
+ * - type is a non-empty string
+ * - max_state is non-negative
+ * - cur_state is in the range [0, max_state]
+ *
+ * The test skips with TCONF when no cooling device is present.
+ */
+
+#include <string.h>
+#include <dirent.h>
+#include <limits.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+#define THERMAL "/sys/class/thermal"
+
+static void check_cooling_device(const char *name)
+{
+	char type[64] = "";
+
+	tst_res(TINFO, "Checking %s", name);
+
+	TST_SYSFS_READ_STR(type, sizeof(type), THERMAL "/%s/type", name);
+
+	if (type[0] != '\0')
+		tst_res(TPASS, "%s: type = '%s'", name, type);
+	else
+		tst_res(TFAIL, "%s: type is empty", name);
+
+	TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX, THERMAL "/%s/max_state", name);
+
+	TST_SYSFS_ASSERT_RANGELF(0, "cur_state", "max_state",
+				  THERMAL "/%s/", name);
+}
+
+static void do_test(void)
+{
+	DIR *d;
+	struct dirent *ent;
+	int found = 0;
+
+	if (!tst_sysfs_exists(THERMAL))
+		tst_brk(TCONF, THERMAL ": not present");
+
+	d = SAFE_OPENDIR(THERMAL);
+
+	while ((ent = SAFE_READDIR(d))) {
+		if (strncmp(ent->d_name, "cooling_device", 14))
+			continue;
+
+		found = 1;
+		check_cooling_device(ent->d_name);
+	}
+
+	SAFE_CLOSEDIR(d);
+
+	if (!found)
+		tst_res(TCONF, "No cooling device found");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
