Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A17C5DF81
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 16:21:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 221513CD820
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 18:21:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84C5E3CD735
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:17:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DC2A460079B
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:17:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9983C84C04
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TkdICtLtA6JW8mnSjOgsoMdrmpGpOTO8a+J3PTLqYuo=;
 b=SaysRYAwj7GO19wJ6g+QlU/PPWh32pM0bvKLy9u8C5S3MInGs/WX4uaqnYm/6/Zq/4qLGv
 9n1RyzOWm9KWktziU/0hHYIoj431TqZGGRLLcm0T2/tacsphnCulJ8oeIqNfsh7s/di9Ou
 m9JLWUWP7NxM7axtY+YlVQPxio9Lpd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TkdICtLtA6JW8mnSjOgsoMdrmpGpOTO8a+J3PTLqYuo=;
 b=YLhBygQVlmKNT6QhzId7ouTE2ohXXZFfsolruuUBdzie9eZfH5f7ZIqN8sohDQHUPJaUoX
 kf5Vx9myeKuKpHBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c3pxqnSX;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wsCAhoI8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TkdICtLtA6JW8mnSjOgsoMdrmpGpOTO8a+J3PTLqYuo=;
 b=c3pxqnSX3pGCJAAxNZuC8sKr8YiCvgPHmeq9G0x1LvE+eO7I9Ees/LJVfKhc62xpkjVj56
 2SHyliHhZ11uiow2ckf9l+oCRUnAg/Sm1vl89fzTaeRjwBD3bJUr+zO4DCP+1/qiBMcjyb
 TRm5X6sQPx8OPVZ+MVRaI948Fk43ons=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156214;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TkdICtLtA6JW8mnSjOgsoMdrmpGpOTO8a+J3PTLqYuo=;
 b=wsCAhoI8YnRRS9dyCwZ/VFC296z7+RwPzJCq1221TsG1LZ6W0HF4Y2/ymZTZkN5ISeFlwJ
 uciA8AVLMg93jkAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 166CC3682
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id j41/BPTWhWqScwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:52 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Aug 2026 18:16:18 +0200
Message-ID: <20260819161634.1341577-16-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819161634.1341577-1-chrubis@suse.cz>
References: <20260819161634.1341577-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 9983C84C04
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 15/31] testcases: sysfs: sys_leds01
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

Add test for /sys/class/leds/*/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |  1 +
 testcases/kernel/sysfs/class/leds/.gitignore  |  1 +
 testcases/kernel/sysfs/class/leds/Makefile    |  7 ++
 .../kernel/sysfs/class/leds/sys_leds01.c      | 70 +++++++++++++++++++
 4 files changed, 79 insertions(+)
 create mode 100644 testcases/kernel/sysfs/class/leds/.gitignore
 create mode 100644 testcases/kernel/sysfs/class/leds/Makefile
 create mode 100644 testcases/kernel/sysfs/class/leds/sys_leds01.c

diff --git a/runtest/sysfs b/runtest/sysfs
index 23c7adc7a..f515c4c1e 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -11,3 +11,4 @@ sys_clockevents01 sys_clockevents01
 sys_ata01 sys_ata01
 sys_bdi01 sys_bdi01
 sys_hwmon01 sys_hwmon01
+sys_leds01 sys_leds01
diff --git a/testcases/kernel/sysfs/class/leds/.gitignore b/testcases/kernel/sysfs/class/leds/.gitignore
new file mode 100644
index 000000000..96e026b0d
--- /dev/null
+++ b/testcases/kernel/sysfs/class/leds/.gitignore
@@ -0,0 +1 @@
+/sys_leds01
diff --git a/testcases/kernel/sysfs/class/leds/Makefile b/testcases/kernel/sysfs/class/leds/Makefile
new file mode 100644
index 000000000..034038061
--- /dev/null
+++ b/testcases/kernel/sysfs/class/leds/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sysfs/class/leds/sys_leds01.c b/testcases/kernel/sysfs/class/leds/sys_leds01.c
new file mode 100644
index 000000000..710a6ed1e
--- /dev/null
+++ b/testcases/kernel/sysfs/class/leds/sys_leds01.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the LED class devices exported under
+ * /sys/class/leds/<led>/.
+ *
+ * For every LED the test verifies that:
+ *
+ * - max_brightness is greater than zero
+ * - brightness is in the range [0, max_brightness]
+ * - trigger is a bracketed-choice file listing the available triggers with
+ *   exactly one of them selected via [] (the set of triggers is not checked
+ *   as it is highly kernel- and hardware-dependent)
+ *
+ * The test skips with TCONF when no LED device is present.
+ */
+
+#include <limits.h>
+#include <dirent.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+#define LEDS "/sys/class/leds"
+
+static void check_led(const char *name)
+{
+	char trigger[64];
+
+	tst_res(TINFO, "Checking led '%s'", name);
+
+	TST_SYSFS_ASSERT_RANGELL(1, LONG_MAX, LEDS "/%s/max_brightness", name);
+
+	TST_SYSFS_ASSERT_RANGELF(0, "brightness", "max_brightness",
+				  LEDS "/%s/", name);
+
+	TST_SYSFS_ASSERT_CHOICE(NULL, trigger, sizeof(trigger),
+				LEDS "/%s/trigger", name);
+}
+
+static void do_test(void)
+{
+	DIR *d;
+	struct dirent *ent;
+	int found = 0;
+
+	if (!tst_sysfs_exists(LEDS))
+		tst_brk(TCONF, LEDS ": not present");
+
+	d = SAFE_OPENDIR(LEDS);
+
+	while ((ent = SAFE_READDIR(d))) {
+		if (ent->d_name[0] == '.')
+			continue;
+
+		found = 1;
+		check_led(ent->d_name);
+	}
+
+	SAFE_CLOSEDIR(d);
+
+	if (!found)
+		tst_res(TCONF, "No LED device found");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
