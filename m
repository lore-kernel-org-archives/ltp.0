Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38527C5DF85
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 16:22:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D776A3CDC08
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 18:22:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E077F3CD6A0
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:17:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4640110009AD
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:17:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9FD6184C1A
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qmptflw0fvjjydijToadtD+aVNiq4pWxrwSEMawxPLM=;
 b=N68Oog989s93Id1qyXr8k76DOoh4Ga+vlwlDKMPzj+a3TDh5KlMYWq6YnxqYx5NjPzsMLB
 VXEwG8Ru/6Bvr5+DOpgfy3Q6ZTVRot4jQJS0qJ+hdxCjWxcZq24DEJgQDDGEBnVbAWM/Pv
 ZlhJRxxQOvk0nw1OJdy5H44CaI7mtXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qmptflw0fvjjydijToadtD+aVNiq4pWxrwSEMawxPLM=;
 b=bH6/ltGhGTAhdJlfcu00upIrdJyFAGbFGBcwGHHv89MZj9QKVCGLbSptUO0vgVfl7w2SgM
 Kw4QF0TgyxY2x+BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qmptflw0fvjjydijToadtD+aVNiq4pWxrwSEMawxPLM=;
 b=zicSUzdSz7zd9ZYXY0+z19mZrQOYoOEzHY8RAS/kQr5Sd984N97+UNEy4pSeIld7cVgnzV
 LHNRCfGWTjm8elxc+NnnE0o7aqzlSFcjdOq+9CYTLiwrz+EprD/ueAK9Y/illsV3iL9LkD
 bNWzgGTywFsAakeR2wuM3j9iD5nvW8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156214;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qmptflw0fvjjydijToadtD+aVNiq4pWxrwSEMawxPLM=;
 b=XtFqjsKLe8wQJeUlJO/mTHKsufvbhcFcamVjh9yphyHYAmsFnbQLl//cuNKi286RHNXIzR
 7ngiwMoJpWixCrAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76B9C3683
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rDIQHPTWhWqUcwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:52 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Aug 2026 18:16:19 +0200
Message-ID: <20260819161634.1341577-17-chrubis@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 16/31] testcases: sysfs: Add sys_wakeup01
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

A test for /sys/class/wakeup/*/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |   1 +
 .../kernel/sysfs/class/wakeup/.gitignore      |   1 +
 testcases/kernel/sysfs/class/wakeup/Makefile  |   7 ++
 .../kernel/sysfs/class/wakeup/sys_wakeup01.c  | 118 ++++++++++++++++++
 4 files changed, 127 insertions(+)
 create mode 100644 testcases/kernel/sysfs/class/wakeup/.gitignore
 create mode 100644 testcases/kernel/sysfs/class/wakeup/Makefile
 create mode 100644 testcases/kernel/sysfs/class/wakeup/sys_wakeup01.c

diff --git a/runtest/sysfs b/runtest/sysfs
index f515c4c1e..b8d003228 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -12,3 +12,4 @@ sys_ata01 sys_ata01
 sys_bdi01 sys_bdi01
 sys_hwmon01 sys_hwmon01
 sys_leds01 sys_leds01
+sys_wakeup01 sys_wakeup01
diff --git a/testcases/kernel/sysfs/class/wakeup/.gitignore b/testcases/kernel/sysfs/class/wakeup/.gitignore
new file mode 100644
index 000000000..16d0375cd
--- /dev/null
+++ b/testcases/kernel/sysfs/class/wakeup/.gitignore
@@ -0,0 +1 @@
+/sys_wakeup01
diff --git a/testcases/kernel/sysfs/class/wakeup/Makefile b/testcases/kernel/sysfs/class/wakeup/Makefile
new file mode 100644
index 000000000..034038061
--- /dev/null
+++ b/testcases/kernel/sysfs/class/wakeup/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sysfs/class/wakeup/sys_wakeup01.c b/testcases/kernel/sysfs/class/wakeup/sys_wakeup01.c
new file mode 100644
index 000000000..37e5ceafc
--- /dev/null
+++ b/testcases/kernel/sysfs/class/wakeup/sys_wakeup01.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the wakeup source statistics exported under
+ * /sys/class/wakeup/wakeupN/.
+ *
+ * For every wakeup source the test verifies that:
+ *
+ * - name is a non-empty string
+ * - active_count, active_time_ms, event_count, expire_count, last_change_ms,
+ *   max_time_ms, prevent_suspend_time_ms, total_time_ms and wakeup_count are
+ *   all non-negative
+ * - active_time_ms <= total_time_ms (currently active time is part of the
+ *   accumulated total)
+ * - max_time_ms <= total_time_ms (the longest single event cannot exceed the
+ *   accumulated total)
+ *
+ * The test skips with TCONF when no wakeup source is present.
+ */
+
+#include <string.h>
+#include <limits.h>
+#include <dirent.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+#define WAKEUP "/sys/class/wakeup"
+
+/*
+ * active_count/event_count/wakeup_count/expire_count are exported by the
+ * kernel as "unsigned long" (see drivers/base/power/wakeup_stats.c), hence
+ * the RANGEUU (unsigned long long bounds) variant is used for these: it
+ * lets us use the real ULONG_MAX.
+ */
+static const char *const count_attrs[] = {
+	"active_count",
+	"event_count",
+	"expire_count",
+	"wakeup_count",
+};
+
+/*
+ * active_time_ms/total_time_ms/max_time_ms/last_change_ms/
+ * prevent_suspend_time_ms are exported by the kernel as a signed 64bit
+ * ktime_t converted to milliseconds (see drivers/base/power/wakeup_stats.c),
+ * i.e. their real ceiling is LLONG_MAX regardless of the architecture. On a
+ * 32bit test build "long" is only 32bit (~24.8 days worth of ms), so plain
+ * LONG_MAX would be too tight and could false-fail on a long-uptime system.
+ */
+static const char *const time_ms_attrs[] = {
+	"active_time_ms",
+	"last_change_ms",
+	"max_time_ms",
+	"prevent_suspend_time_ms",
+	"total_time_ms",
+};
+
+static void check_wakeup(const char *dev)
+{
+	char name[128] = "";
+	unsigned int i;
+
+	tst_res(TINFO, "Checking %s", dev);
+
+	if (!TST_SYSFS_READ_STR(name, sizeof(name), WAKEUP "/%s/name", dev)) {
+		tst_res(TCONF, "%s vanished before it could be checked", dev);
+		return;
+	}
+
+	if (name[0] != '\0')
+		tst_res(TPASS, "%s: name = '%s'", dev, name);
+	else
+		tst_res(TFAIL, "%s: name is empty", dev);
+
+	for (i = 0; i < ARRAY_SIZE(count_attrs); i++) {
+		TST_SYSFS_ASSERT_RANGEUU(0, ULONG_MAX, WAKEUP "/%s/%s", dev,
+					 count_attrs[i]);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(time_ms_attrs); i++) {
+		TST_SYSFS_ASSERT_RANGELL(0, LLONG_MAX, WAKEUP "/%s/%s", dev,
+					 time_ms_attrs[i]);
+	}
+
+	TST_SYSFS_ASSERT_LE_SUFFIX("active_time_ms", "total_time_ms",
+				   WAKEUP "/%s/", dev);
+	TST_SYSFS_ASSERT_LE_SUFFIX("max_time_ms", "total_time_ms",
+				   WAKEUP "/%s/", dev);
+}
+
+static void do_test(void)
+{
+	DIR *d;
+	struct dirent *ent;
+	int found = 0;
+
+	d = SAFE_OPENDIR(WAKEUP);
+
+	while ((ent = SAFE_READDIR(d))) {
+		if (strncmp(ent->d_name, "wakeup", 6))
+			continue;
+
+		found = 1;
+		check_wakeup(ent->d_name);
+	}
+
+	SAFE_CLOSEDIR(d);
+
+	if (!found)
+		tst_res(TCONF, "No wakeup source found");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
