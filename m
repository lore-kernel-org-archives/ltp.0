Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81342C5DF81
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 16:21:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D9C03C57A0
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 18:21:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C07B3CD674
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:17:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B373F1A008A3
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:17:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B12063EDF
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKFBICCfG4il9nSHAa8MCrkg5nsmndj6ZM+ryA+vYgE=;
 b=TrNKpuejKcmTo5vEKh3T/0yLk6Rs7f0DiWWaO3WlsuLnXF5MMYvwrE9Zojn0/hAX36THEx
 4ly04gdiQ/qVMCl9tEzU4pjoVc0bIV15yffLpfVk88q5nAJCaszYsuw9i8+izP+QSk9p4F
 O7o+BZjTWJYqWzXOdQ9CY+DKtVoH2GU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKFBICCfG4il9nSHAa8MCrkg5nsmndj6ZM+ryA+vYgE=;
 b=O46Wauaoa8n+QBnacfHMyFo7Q5beJ8c5AoeadHcqYWMsKZdlUGe/HlZswpHEVemyAvFugE
 gSxiQrlAjAkpraCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKFBICCfG4il9nSHAa8MCrkg5nsmndj6ZM+ryA+vYgE=;
 b=zL/nmgHS/RtvV6CHYdropwWLLE7G4eSnaPvIJIY7qoKx2+wBQQkMX3OEGwWfIyvINNk+ZN
 YkHHDA48JE/ucNhLd0u9VzjkLNjyBCt/GcL0H0xDHt+EI9ZvCGL8vEft8nvwa9SagGkUYw
 M6WWcPgEUCDzKYNmrSVSOb1Lbc/+0eM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156214;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKFBICCfG4il9nSHAa8MCrkg5nsmndj6ZM+ryA+vYgE=;
 b=je1okO71+HNzRdYB0e2iPy39+IU3QGOT/JbkppmjkS/Llf4Sdy1WL1AWUCc8PV686MfmU1
 SLXhQpeFb9inCEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D56203684
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id y5H0MvTWhWqWcwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:52 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Aug 2026 18:16:20 +0200
Message-ID: <20260819161634.1341577-18-chrubis@suse.cz>
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 17/31] testcases: sysfs: Add sys_rtc01
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

A test for /sys/class/rtc/*/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                |   1 +
 testcases/kernel/sysfs/class/rtc/.gitignore  |   1 +
 testcases/kernel/sysfs/class/rtc/Makefile    |   7 +
 testcases/kernel/sysfs/class/rtc/sys_rtc01.c | 234 +++++++++++++++++++
 4 files changed, 243 insertions(+)
 create mode 100644 testcases/kernel/sysfs/class/rtc/.gitignore
 create mode 100644 testcases/kernel/sysfs/class/rtc/Makefile
 create mode 100644 testcases/kernel/sysfs/class/rtc/sys_rtc01.c

diff --git a/runtest/sysfs b/runtest/sysfs
index b8d003228..de58499be 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -13,3 +13,4 @@ sys_bdi01 sys_bdi01
 sys_hwmon01 sys_hwmon01
 sys_leds01 sys_leds01
 sys_wakeup01 sys_wakeup01
+sys_rtc01 sys_rtc01
diff --git a/testcases/kernel/sysfs/class/rtc/.gitignore b/testcases/kernel/sysfs/class/rtc/.gitignore
new file mode 100644
index 000000000..0ce416b43
--- /dev/null
+++ b/testcases/kernel/sysfs/class/rtc/.gitignore
@@ -0,0 +1 @@
+/sys_rtc01
diff --git a/testcases/kernel/sysfs/class/rtc/Makefile b/testcases/kernel/sysfs/class/rtc/Makefile
new file mode 100644
index 000000000..034038061
--- /dev/null
+++ b/testcases/kernel/sysfs/class/rtc/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sysfs/class/rtc/sys_rtc01.c b/testcases/kernel/sysfs/class/rtc/sys_rtc01.c
new file mode 100644
index 000000000..83c0ecdb3
--- /dev/null
+++ b/testcases/kernel/sysfs/class/rtc/sys_rtc01.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the RTC attributes exported under
+ * /sys/class/rtc/rtcN/.
+ *
+ * date and time report the RTC clock in UTC, while since_epoch reports the
+ * same value pre-converted to a Unix timestamp. For every RTC device the
+ * test verifies that:
+ *
+ * - hctosys is a boolean
+ * - max_user_freq is greater than zero
+ * - since_epoch matches date and time converted to a Unix timestamp
+ * - for the RTC device with hctosys == 1, i.e. the one that was actually
+ *   used by the kernel's own CONFIG_RTC_HCTOSYS code to set the system clock
+ *   at boot, since_epoch is additionally close to the current system time(2)
+ *   value. On a system with multiple RTC devices the other ones are not
+ *   guaranteed to be in sync with the system clock at all (e.g. a
+ *   peripheral's battery-backed RTC used only for its own wakeup alarm), so
+ *   this second check is skipped for them.
+ *
+ * The hctosys only reflects whether the kernel itself performed the sync; many
+ * setups runs "hwclock --hctosys" from a userspace init script instead to sync
+ * the system clock from the RTC without the kernel ever knowing about it,
+ * leaving hctosys == 0 on every device despite the clock legitimately being in
+ * sync. To still get coverage on such systems, if no RTC has hctosys == 1 at
+ * all, rtc0 is treated as the presumed primary RTC and gets the system time
+ * check anyway.
+ *
+ * The date/time vs since_epoch cross-check allows a few seconds of slack since
+ * they are read from separate files and the wall clock keeps ticking in
+ * between reads. The code also checks for midnight rollover and re-reads the
+ * values if that happens.
+ *
+ * The since_epoch vs system time(2) cross-check allows extra slack that
+ * grows with system uptime: the RTC is a free-running hardware crystal
+ * oscillator that (absent some periodic resync mechanism, which is not
+ * guaranteed to be running) drifts independently of the system clock the
+ * whole time the system is up, not just across the couple of reads this
+ * test performs, so on a long-running system a purely fixed slack would
+ * eventually produce false failures even on perfectly healthy hardware.
+ *
+ * The check may still fail if the system was booted with RTC that is fairly
+ * off the current time and the system was later synced with NTP. This is out
+ * of scope of this test.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <dirent.h>
+#include <limits.h>
+#include <time.h>
+#include <sys/sysinfo.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+#define RTC_CLASS "/sys/class/rtc"
+#define SLACK_SEC 10
+
+/*
+ * Generously high assumed worst-case RTC crystal drift, in parts per
+ * million, used to scale the system time slack with uptime. 200 ppm covers
+ * even fairly poor/uncompensated RTC crystals across a wide temperature
+ * range; a decent RTC typically drifts far less than this.
+ */
+#define MAX_RTC_DRIFT_PPM 200
+
+static long sys_time_slack_sec(void)
+{
+	struct sysinfo info;
+
+	SAFE_SYSINFO(&info);
+
+	return SLACK_SEC + (long)info.uptime * MAX_RTC_DRIFT_PPM / 1000000;
+}
+
+static long read_hctosys(const char *name)
+{
+	return TST_SYSFS_READ_LI(RTC_CLASS "/%s/hctosys", name);
+}
+
+static void read_rtc_snapshot(const char *name, char *date, size_t date_size,
+			      char *rtc_time, size_t time_size,
+			      time_t *since_epoch)
+{
+	char date2[32];
+	int i;
+
+	/*
+	 * Retry if the date changed between the reads -> midnight rollover
+	 * happened.
+	 */
+	for (i = 0; i < 2; i++) {
+		TST_SYSFS_READ_STR(date, date_size, RTC_CLASS "/%s/date", name);
+		TST_SYSFS_READ_STR(rtc_time, time_size, RTC_CLASS "/%s/time",
+				   name);
+
+		*since_epoch = TST_SYSFS_READ_LI(RTC_CLASS "/%s/since_epoch", name);
+
+		TST_SYSFS_READ_STR(date2, sizeof(date2), RTC_CLASS "/%s/date",
+				   name);
+
+		if (!strcmp(date, date2))
+			return;
+
+		tst_res(TINFO,
+			"%s: date rolled over mid-read (%s -> %s), retrying",
+			name, date, date2);
+	}
+
+	tst_res(TWARN, "%s: date kept rolling over across the retry", name);
+}
+
+static void check_rtc(const char *name, int any_hctosys)
+{
+	char date[32] = "", rtc_time[32] = "";
+	struct tm tm = { 0 };
+	time_t rtc_epoch, sys_epoch;
+	long hctosys, slack;
+	time_t since_epoch;
+	int is_primary;
+
+	TST_SYSFS_ASSERT_BOOL(RTC_CLASS "/%s/hctosys", name);
+	TST_SYSFS_ASSERT_RANGELL(1, LONG_MAX, RTC_CLASS "/%s/max_user_freq", name);
+
+	hctosys = read_hctosys(name);
+
+	/*
+	 * If no RTC has hctosys == 1 anywhere (see the top comment), fall
+	 * back to treating rtc0 as the presumed primary RTC.
+	 */
+	is_primary = hctosys || (!any_hctosys && !strcmp(name, "rtc0"));
+
+	read_rtc_snapshot(name, date, sizeof(date), rtc_time, sizeof(rtc_time),
+			  &since_epoch);
+
+	sys_epoch = time(NULL);
+
+	if (sscanf(date, "%d-%d-%d", &tm.tm_year, &tm.tm_mon, &tm.tm_mday) != 3 ||
+	    sscanf(rtc_time, "%d:%d:%d", &tm.tm_hour, &tm.tm_min, &tm.tm_sec) != 3) {
+		tst_res(TFAIL, "%s: failed to parse date '%s' / time '%s'",
+			name, date, rtc_time);
+		return;
+	}
+
+	tm.tm_year -= 1900;
+	tm.tm_mon -= 1;
+	rtc_epoch = timegm(&tm);
+
+	if (llabs((long long)(rtc_epoch - since_epoch)) <= SLACK_SEC) {
+		tst_res(TPASS,
+			"%s: since_epoch (%lld) matches date '%s' time '%s' (%lld)",
+			name, (long long)since_epoch, date, rtc_time,
+			(long long)rtc_epoch);
+	} else {
+		tst_res(TFAIL,
+			"%s: since_epoch (%lld) does not match date '%s' time '%s' (%lld)",
+			name, (long long)since_epoch, date, rtc_time,
+			(long long)rtc_epoch);
+	}
+
+	if (!is_primary) {
+		tst_res(TINFO,
+			"%s: not the (assumed) primary RTC, not checking since_epoch against system time",
+			name);
+		return;
+	}
+
+	slack = sys_time_slack_sec();
+	long long diff = llabs((long long)(since_epoch - sys_epoch));
+
+	if (diff <= slack) {
+		tst_res(TPASS,
+			"%s: since_epoch (%lld), system time (%lld), diff %llds <= slack %lds",
+			name, (long long)since_epoch, (long long)sys_epoch,
+			diff, slack);
+	} else {
+		tst_res(TFAIL,
+			"%s: since_epoch (%lld), system time (%lld), diff %llds > slack %lds",
+			name, (long long)since_epoch, (long long)sys_epoch,
+			diff, slack);
+	}
+}
+
+static void do_test(void)
+{
+	DIR *d;
+	struct dirent *ent;
+	int found = 0;
+	int any_hctosys = 0;
+
+	if (!tst_sysfs_exists(RTC_CLASS))
+		tst_brk(TCONF, RTC_CLASS ": not present");
+
+	d = SAFE_OPENDIR(RTC_CLASS);
+
+	/* First pass: find out whether any RTC has hctosys == 1 already. */
+	while ((ent = SAFE_READDIR(d))) {
+		if (strncmp(ent->d_name, "rtc", 3))
+			continue;
+
+		found = 1;
+
+		if (read_hctosys(ent->d_name))
+			any_hctosys = 1;
+	}
+
+	if (!found) {
+		tst_res(TCONF, "No RTC device found");
+		SAFE_CLOSEDIR(d);
+		return;
+	}
+
+	rewinddir(d);
+
+	/* Second pass: run the actual checks. */
+	while ((ent = SAFE_READDIR(d))) {
+		if (strncmp(ent->d_name, "rtc", 3))
+			continue;
+
+		tst_res(TINFO, "Checking %s", ent->d_name);
+		check_rtc(ent->d_name, any_hctosys);
+	}
+
+	SAFE_CLOSEDIR(d);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
