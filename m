Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B907C61DBD
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 11:41:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38B593C5E2C
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 13:41:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 440CA3C57B4
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:36:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8364560004B
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:36:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 286971F7DB
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ukB2Y0qoiZV8MrQK1Csj1VJg1kyzhBaeoNkaefpD6Q=;
 b=H0j5rDs7U0x4OFv2WpKV1k4MlUeh/OX5jwicQOokKpYqeBUgQ6yegXSiBpEbFubP9sktvh
 iz//xb23RZAUPAnqlauRZRA3KdHHjztC1tfs39SVFSKa1oC7uBWOJ0haZuAC+trj2tZzvg
 +UeHW1q5ddu1CdcGTYsxkP3YqkTji54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657800;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ukB2Y0qoiZV8MrQK1Csj1VJg1kyzhBaeoNkaefpD6Q=;
 b=UuV1gcJZeh+OijR+/rlzUt1r58ROyuVfpbTtyE9EEFm6NjY5Lww6qotf9ycVbjOq0IKRoq
 BDXEPOuYLw0uelDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ukB2Y0qoiZV8MrQK1Csj1VJg1kyzhBaeoNkaefpD6Q=;
 b=q0eDgPhf4cmeOqDX7mP6lwVii9OXeQMB3/3xaqZxxDiUMsX2zV/8bSO/TWL2nPYhvBBtKC
 AgPRKW9/neflXNoiPECExUvzC1zeOt4gwtAMpnjV1sIG/Z4hC/nP2SqbujWQadiLjXv3Fm
 ce56otddWrr0GVT2DQOn/BXDwc/Z/X8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657796;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ukB2Y0qoiZV8MrQK1Csj1VJg1kyzhBaeoNkaefpD6Q=;
 b=G13Urt2yPFeB8ucOhWo60HY3SAWpFbScxKRo8l2eDwV2ZsvOD/4rYnrvtcteZ8Mvq4UDEW
 RuE6w/isZx5RIgBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E1C913479
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RF0rBj1+jWpGSAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:29 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 25 Aug 2026 13:36:09 +0200
Message-ID: <20260825113625.1624134-16-chrubis@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 15/31] testcases: sysfs: sys_leds01
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
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
