Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B124C5DF74
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:16:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA2433CC912
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 16:16:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 075A73CCB1A
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:13:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 68A1760076C
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:13:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E8C5E3E78
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ksYnShI2LfylWsUOeF6byG1JrC+Wt53hLmAtm7omTFw=;
 b=Ms+21gQWKR8P6qG0uLgW/YQkukYOGcn089/tZtFIK1VWkEoIsnc18ZfWBA8qahE8H5bjh3
 P44dQB1KTECwfQmadWCHKFWeID95Bhm7zKtbQjDo890LnobMJVdcnfu9hSk47xowlwMOzq
 2k9NsQd/aSLHs7mgWwMd/oV2DxnnHCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062402;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ksYnShI2LfylWsUOeF6byG1JrC+Wt53hLmAtm7omTFw=;
 b=YfNWRALl626k/LGA5CpcTOOw1na1tPGrcHnENKiuB9/DqbnQsRH7VHcbrT2fgI8P1Hj/Rx
 c3BrGMHfgkwgr9Bg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cAUyCsZl;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uYe4YIAg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ksYnShI2LfylWsUOeF6byG1JrC+Wt53hLmAtm7omTFw=;
 b=cAUyCsZlIzKb27eyHs367JFeBNDNUheKXr9sngS9+z2DcOv6E7PMczfo3J5tANtadUMqjF
 VTXXf/cS/aceKKmSrTzXKJc89GvNA8J7jezu5Bfi+J1nbJST6QUWxBu40J1yQ8k9i+ew+U
 2rIu4cBJqk+cWLm8egESeDrgzjJ8bT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ksYnShI2LfylWsUOeF6byG1JrC+Wt53hLmAtm7omTFw=;
 b=uYe4YIAgkxjQOUoZwUEhfqrDIWVz9QKmhCgJDxwQ5OScdoWIEDWJaedw7KfSmffyu+1yVg
 gVMc3Fv+DgWVgXBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9B60364F
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xeVcMH1ohGrqcAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:17 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Aug 2026 16:12:54 +0200
Message-ID: <20260818141311.1265557-15-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818141311.1265557-1-chrubis@suse.cz>
References: <20260818141311.1265557-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E8C5E3E78
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 14/31] testcases: sysfs: sys_hwmon01
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

Add test for /sys/class/hwmon/*/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |   1 +
 testcases/kernel/sysfs/class/hwmon/.gitignore |   1 +
 testcases/kernel/sysfs/class/hwmon/Makefile   |   7 +
 .../kernel/sysfs/class/hwmon/sys_hwmon01.c    | 196 ++++++++++++++++++
 4 files changed, 205 insertions(+)
 create mode 100644 testcases/kernel/sysfs/class/hwmon/.gitignore
 create mode 100644 testcases/kernel/sysfs/class/hwmon/Makefile
 create mode 100644 testcases/kernel/sysfs/class/hwmon/sys_hwmon01.c

diff --git a/runtest/sysfs b/runtest/sysfs
index c0983a5be..23c7adc7a 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -10,3 +10,4 @@ sys_cpu_cache01 sys_cpu_cache01
 sys_clockevents01 sys_clockevents01
 sys_ata01 sys_ata01
 sys_bdi01 sys_bdi01
+sys_hwmon01 sys_hwmon01
diff --git a/testcases/kernel/sysfs/class/hwmon/.gitignore b/testcases/kernel/sysfs/class/hwmon/.gitignore
new file mode 100644
index 000000000..f619181d7
--- /dev/null
+++ b/testcases/kernel/sysfs/class/hwmon/.gitignore
@@ -0,0 +1 @@
+/sys_hwmon01
diff --git a/testcases/kernel/sysfs/class/hwmon/Makefile b/testcases/kernel/sysfs/class/hwmon/Makefile
new file mode 100644
index 000000000..034038061
--- /dev/null
+++ b/testcases/kernel/sysfs/class/hwmon/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sysfs/class/hwmon/sys_hwmon01.c b/testcases/kernel/sysfs/class/hwmon/sys_hwmon01.c
new file mode 100644
index 000000000..fb0077126
--- /dev/null
+++ b/testcases/kernel/sysfs/class/hwmon/sys_hwmon01.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Walks all hardware monitoring devices under /sys/class/hwmon/ and performs
+ * sanity and cross-checks on the sensor channels exported per the stable
+ * hwmon sysfs ABI (Documentation/hwmon/sysfs-interface.rst).
+ *
+ * For every discovered channel it verifies that:
+ *
+ * - tempN_input is within a plausible range (-55000 to 200000 millidegree
+ *   Celsius, i.e. within the extended-industrial silicon sensor rating floor
+ *   and below a generously high bound)
+ * - tempN_min <= tempN_max <= tempN_crit and tempN_lcrit <= tempN_min, when
+ *   the respective pair of attributes is present
+ * - tempN_alarm, tempN_crit_alarm, tempN_min_alarm, tempN_max_alarm and
+ *   tempN_fault are booleans, when present
+ * - fanN_input is within a plausible range (0 to 100000 RPM, comfortably
+ *   above even exotic small high-speed blower fans)
+ * - fanN_min <= fanN_max, when present
+ * - fanN_alarm, fanN_fault, fanN_min_alarm and fanN_max_alarm are booleans,
+ *   when present
+ * - inN_input is within a plausible range (-100000 to 100000 millivolt,
+ *   allowing for negative supply rails, not just positive ones)
+ * - inN_min <= inN_max <= inN_crit and inN_lcrit <= inN_min, when present
+ *   (inN channels are numbered from 0, unlike the other channel types which
+ *   start at 1)
+ * - inN_alarm and related alarm attributes are booleans, when present
+ * - currN_input is within a plausible range (-500000 to 500000 milliampere,
+ *   allowing for negative values on bidirectional/battery charge-discharge
+ *   current sensors)
+ * - currN_min <= currN_max, when present
+ * - powerN_input is within a plausible range (0 to 2000000000 microwatt,
+ *   i.e. 2 kW, chosen to stay within LONG_MAX on 32bit architectures as well)
+ * - pwmN is in the documented range [0, 255]
+ * - update_interval, when present, is within a plausible range (1 to
+ *   3600000 millisecond, i.e. up to an hour)
+ *
+ * All checks skip silently when a particular channel or attribute is not
+ * present, since the set of exposed sensors varies wildly between chips and
+ * platforms and up to MAX_CHANNELS indices are probed for every channel type
+ * regardless of how many are actually implemented by a given chip.
+ *
+ * Note: the ordering assumptions between minimum/maximum/critical thresholds
+ * reflect typical sensor configuration conventions, they are not enforced by
+ * the kernel itself, so in principle a chip could be configured in an
+ * unusual way that still is not actually a bug.
+ */
+
+#include <string.h>
+#include <dirent.h>
+
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+#define HWMON "/sys/class/hwmon"
+#define MAX_CHANNELS 32
+
+static void check_temp_channel(const char *hwmon, int idx)
+{
+	TST_SYSFS_ASSERT_RANGELL_SILENT(-55000, 200000,
+				      HWMON "/%s/temp%d_input", hwmon, idx);
+
+	TST_SYSFS_ASSERT_LE_SUFFIX_SILENT("lcrit", "min",
+					  HWMON "/%s/temp%d_", hwmon, idx);
+	TST_SYSFS_ASSERT_LE_SUFFIX_SILENT("min", "max",
+					  HWMON "/%s/temp%d_", hwmon, idx);
+	TST_SYSFS_ASSERT_LE_SUFFIX_SILENT("max", "crit",
+					  HWMON "/%s/temp%d_", hwmon, idx);
+
+	TST_SYSFS_ASSERT_BOOL_SILENT(HWMON "/%s/temp%d_alarm", hwmon, idx);
+	TST_SYSFS_ASSERT_BOOL_SILENT(HWMON "/%s/temp%d_crit_alarm", hwmon, idx);
+	TST_SYSFS_ASSERT_BOOL_SILENT(HWMON "/%s/temp%d_min_alarm", hwmon, idx);
+	TST_SYSFS_ASSERT_BOOL_SILENT(HWMON "/%s/temp%d_max_alarm", hwmon, idx);
+	TST_SYSFS_ASSERT_BOOL_SILENT(HWMON "/%s/temp%d_fault", hwmon, idx);
+}
+
+static void check_fan_channel(const char *hwmon, int idx)
+{
+	TST_SYSFS_ASSERT_RANGELL_SILENT(0, 100000,
+				      HWMON "/%s/fan%d_input", hwmon, idx);
+
+	TST_SYSFS_ASSERT_LE_SUFFIX_SILENT("min", "max",
+					  HWMON "/%s/fan%d_", hwmon, idx);
+
+	TST_SYSFS_ASSERT_BOOL_SILENT(HWMON "/%s/fan%d_alarm", hwmon, idx);
+	TST_SYSFS_ASSERT_BOOL_SILENT(HWMON "/%s/fan%d_min_alarm", hwmon, idx);
+	TST_SYSFS_ASSERT_BOOL_SILENT(HWMON "/%s/fan%d_max_alarm", hwmon, idx);
+	TST_SYSFS_ASSERT_BOOL_SILENT(HWMON "/%s/fan%d_fault", hwmon, idx);
+}
+
+static void check_in_channel(const char *hwmon, int idx)
+{
+	TST_SYSFS_ASSERT_RANGELL_SILENT(-100000, 100000,
+				      HWMON "/%s/in%d_input", hwmon, idx);
+
+	TST_SYSFS_ASSERT_LE_SUFFIX_SILENT("lcrit", "min",
+					  HWMON "/%s/in%d_", hwmon, idx);
+	TST_SYSFS_ASSERT_LE_SUFFIX_SILENT("min", "max",
+					  HWMON "/%s/in%d_", hwmon, idx);
+	TST_SYSFS_ASSERT_LE_SUFFIX_SILENT("max", "crit",
+					  HWMON "/%s/in%d_", hwmon, idx);
+
+	TST_SYSFS_ASSERT_BOOL_SILENT(HWMON "/%s/in%d_alarm", hwmon, idx);
+	TST_SYSFS_ASSERT_BOOL_SILENT(HWMON "/%s/in%d_min_alarm", hwmon, idx);
+	TST_SYSFS_ASSERT_BOOL_SILENT(HWMON "/%s/in%d_max_alarm", hwmon, idx);
+	TST_SYSFS_ASSERT_BOOL_SILENT(HWMON "/%s/in%d_crit_alarm", hwmon, idx);
+	TST_SYSFS_ASSERT_BOOL_SILENT(HWMON "/%s/in%d_lcrit_alarm", hwmon, idx);
+}
+
+static void check_curr_channel(const char *hwmon, int idx)
+{
+	/*
+	 * Unlike fan/power, current can be negative on bidirectional sensors,
+	 * e.g. a battery charge/discharge current monitor.
+	 */
+	TST_SYSFS_ASSERT_RANGELL_SILENT(-500000, 500000,
+				      HWMON "/%s/curr%d_input", hwmon, idx);
+
+	TST_SYSFS_ASSERT_LE_SUFFIX_SILENT("lcrit", "min",
+					  HWMON "/%s/curr%d_", hwmon, idx);
+	TST_SYSFS_ASSERT_LE_SUFFIX_SILENT("min", "max",
+					  HWMON "/%s/curr%d_", hwmon, idx);
+	TST_SYSFS_ASSERT_LE_SUFFIX_SILENT("max", "crit",
+					  HWMON "/%s/curr%d_", hwmon, idx);
+
+	TST_SYSFS_ASSERT_BOOL_SILENT(HWMON "/%s/curr%d_alarm", hwmon, idx);
+}
+
+static void check_power_channel(const char *hwmon, int idx)
+{
+	/*
+	 * 2000000000 uW (2 kW) comfortably covers any single-component power
+	 * sensor (CPU, GPU, PSU rail, ...) while still fitting within
+	 * LONG_MAX on 32bit architectures.
+	 */
+	TST_SYSFS_ASSERT_RANGELL_SILENT(0, 2000000000,
+				      HWMON "/%s/power%d_input", hwmon, idx);
+}
+
+static void check_pwm_channel(const char *hwmon, int idx)
+{
+	TST_SYSFS_ASSERT_RANGELL_SILENT(0, 255, HWMON "/%s/pwm%d", hwmon, idx);
+}
+
+static void check_hwmon_device(const char *hwmon)
+{
+	char name[64];
+	int i;
+
+	if (TST_SYSFS_READ_STR(name, sizeof(name), HWMON "/%s/name", hwmon))
+		tst_res(TINFO, "%s: name = '%s'", hwmon, name);
+
+	TST_SYSFS_ASSERT_RANGELL_SILENT(1, 3600000,
+				      HWMON "/%s/update_interval", hwmon);
+
+	/* inN channels are numbered from 0, per the hwmon ABI */
+	for (i = 0; i <= MAX_CHANNELS; i++)
+		check_in_channel(hwmon, i);
+
+	for (i = 1; i <= MAX_CHANNELS; i++) {
+		check_temp_channel(hwmon, i);
+		check_fan_channel(hwmon, i);
+		check_curr_channel(hwmon, i);
+		check_power_channel(hwmon, i);
+		check_pwm_channel(hwmon, i);
+	}
+}
+
+static void do_test(void)
+{
+	DIR *d;
+	struct dirent *ent;
+	int found = 0;
+
+	d = SAFE_OPENDIR(HWMON);
+
+	while ((ent = SAFE_READDIR(d))) {
+		if (strncmp(ent->d_name, "hwmon", 5))
+			continue;
+
+		found = 1;
+		check_hwmon_device(ent->d_name);
+	}
+
+	SAFE_CLOSEDIR(d);
+
+	if (!found)
+		tst_res(TCONF, "No hwmon device found");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
