Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE97ACCF2DA
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 08:46:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17BB53E61A6
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 10:46:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC1723C0646
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 10:45:52 +0200 (CEST)
Received: from mta1.migadu.com (out-111.mta1.migadu.com
 [IPv6:2001:41d0:203:375::6f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 33B12600074
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 10:45:51 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=gsagyy9jpRuKzUq2NfPf1P9V08TtcoM5/VFwv+QtMZ0=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792399550; v=1; x=1793004350;
 b=xFR42X1YBXzQwS+MM+OYS7xCO9T3nGT4sJPZaO7cfyyteGBUFUo7bmcElowaJkgt2j8CTxvC
 xhBKTN/Tn8710MH3IGpTPUg3TMGICkKB8X1GkFGPg/UqaZ7+ccVPV+khItkcvqrYf8ytC++GesO
 Efvdvo2s7D0BMiPGTPh7b4lc=
X-Envelope-To: ltp@lists.linux.it
Received: by mta11.migadu.com with ESMTPS id 76f2e0fef56cd6d5;
 Mon, 19 Oct 2026 08:45:50 +0000
X-Mizu-Trace-ID: 76f2e0fef56cd6d5
X-Migadu-Flow: FLOW_OUT
From: "Li Wang (Hieco)" <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Mon, 19 Oct 2026 16:45:33 +0800
Message-ID: <20261019084533.70801-1-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sys_hwmon01: always report a result
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

On machines where the only hwmon devices expose no checkable
attributes (e.g. a VM or laptop where hwmon0 is just 'ACAD' with
nothing but a name attribute), every *_SILENT assertion skips
silently and the test finishes without reporting a single result,
which the library turns into:

    tst_test.c:1730: TBROK: Test haven't reported results!

Fix this by counting the attributes that actually exist and get
validated, then report a TPASS summary at the end, or TCONF when
hwmon devices are present but expose nothing we can check.

Signed-off-by: Li Wang (Hieco) <li.wang@linux.dev>
---
 .../kernel/sysfs/class/hwmon/sys_hwmon01.c    | 109 ++++++++++++------
 1 file changed, 76 insertions(+), 33 deletions(-)

diff --git a/testcases/kernel/sysfs/class/hwmon/sys_hwmon01.c b/testcases/kernel/sysfs/class/hwmon/sys_hwmon01.c
index 1bb574c23..8ecbd47d1 100644
--- a/testcases/kernel/sysfs/class/hwmon/sys_hwmon01.c
+++ b/testcases/kernel/sysfs/class/hwmon/sys_hwmon01.c
@@ -49,6 +49,8 @@
 
 #include <string.h>
 #include <dirent.h>
+#include <stdarg.h>
+#include <limits.h>
 
 #include "tst_test.h"
 #include "tst_sysfs_assert.h"
@@ -56,39 +58,67 @@
 
 #define MAX_CHANNELS 32
 
+static unsigned int checked;
+
+static int attr_exists(const char *fmt, ...)
+{
+	char path[PATH_MAX];
+	va_list va;
+
+	va_start(va, fmt);
+	vsnprintf(path, sizeof(path), fmt, va);
+	va_end(va);
+
+	return tst_sysfs_exists(path);
+}
+
+#define CHECK_RANGELL(lo, hi, ...) do { \
+	if (attr_exists(__VA_ARGS__)) { \
+		checked++; \
+		TST_SYSFS_ASSERT_RANGELL_SILENT(lo, hi, __VA_ARGS__); \
+	} \
+} while (0)
+
+#define CHECK_BOOL(...) do { \
+	if (attr_exists(__VA_ARGS__)) { \
+		checked++; \
+		TST_SYSFS_ASSERT_BOOL_SILENT(__VA_ARGS__); \
+	} \
+} while (0)
+
 static void check_temp_channel(const char *hwmon, int idx)
 {
-	TST_SYSFS_ASSERT_RANGELL_SILENT(-55000, 200000,
-					PATH_CLASS_HWMON "/%s/temp%d_input", hwmon, idx);
-
-	TST_SYSFS_ASSERT_BOOL_SILENT(PATH_CLASS_HWMON "/%s/temp%d_alarm", hwmon, idx);
-	TST_SYSFS_ASSERT_BOOL_SILENT(PATH_CLASS_HWMON "/%s/temp%d_crit_alarm", hwmon, idx);
-	TST_SYSFS_ASSERT_BOOL_SILENT(PATH_CLASS_HWMON "/%s/temp%d_min_alarm", hwmon, idx);
-	TST_SYSFS_ASSERT_BOOL_SILENT(PATH_CLASS_HWMON "/%s/temp%d_max_alarm", hwmon, idx);
-	TST_SYSFS_ASSERT_BOOL_SILENT(PATH_CLASS_HWMON "/%s/temp%d_fault", hwmon, idx);
+	CHECK_RANGELL(-55000, 200000,
+		      PATH_CLASS_HWMON "/%s/temp%d_input", hwmon, idx);
+
+	CHECK_BOOL(PATH_CLASS_HWMON "/%s/temp%d_alarm", hwmon, idx);
+	CHECK_BOOL(PATH_CLASS_HWMON "/%s/temp%d_crit_alarm", hwmon, idx);
+	CHECK_BOOL(PATH_CLASS_HWMON "/%s/temp%d_min_alarm", hwmon, idx);
+	CHECK_BOOL(PATH_CLASS_HWMON "/%s/temp%d_max_alarm", hwmon, idx);
+	CHECK_BOOL(PATH_CLASS_HWMON "/%s/temp%d_fault", hwmon, idx);
 }
 
 static void check_fan_channel(const char *hwmon, int idx)
 {
-	TST_SYSFS_ASSERT_RANGELL_SILENT(0, 100000,
-					PATH_CLASS_HWMON "/%s/fan%d_input", hwmon, idx);
+	CHECK_RANGELL(0, 100000,
+		      PATH_CLASS_HWMON "/%s/fan%d_input", hwmon, idx);
 
-	TST_SYSFS_ASSERT_BOOL_SILENT(PATH_CLASS_HWMON "/%s/fan%d_alarm", hwmon, idx);
-	TST_SYSFS_ASSERT_BOOL_SILENT(PATH_CLASS_HWMON "/%s/fan%d_min_alarm", hwmon, idx);
-	TST_SYSFS_ASSERT_BOOL_SILENT(PATH_CLASS_HWMON "/%s/fan%d_max_alarm", hwmon, idx);
-	TST_SYSFS_ASSERT_BOOL_SILENT(PATH_CLASS_HWMON "/%s/fan%d_fault", hwmon, idx);
+	CHECK_BOOL(PATH_CLASS_HWMON "/%s/fan%d_alarm", hwmon, idx);
+	CHECK_BOOL(PATH_CLASS_HWMON "/%s/fan%d_min_alarm", hwmon, idx);
+	CHECK_BOOL(PATH_CLASS_HWMON "/%s/fan%d_max_alarm", hwmon, idx);
+	CHECK_BOOL(PATH_CLASS_HWMON "/%s/fan%d_fault", hwmon, idx);
 }
 
 static void check_in_channel(const char *hwmon, int idx)
 {
-	TST_SYSFS_ASSERT_RANGELL_SILENT(-100000, 100000,
-					PATH_CLASS_HWMON "/%s/in%d_input", hwmon, idx);
-
-	TST_SYSFS_ASSERT_BOOL_SILENT(PATH_CLASS_HWMON "/%s/in%d_alarm", hwmon, idx);
-	TST_SYSFS_ASSERT_BOOL_SILENT(PATH_CLASS_HWMON "/%s/in%d_min_alarm", hwmon, idx);
-	TST_SYSFS_ASSERT_BOOL_SILENT(PATH_CLASS_HWMON "/%s/in%d_max_alarm", hwmon, idx);
-	TST_SYSFS_ASSERT_BOOL_SILENT(PATH_CLASS_HWMON "/%s/in%d_crit_alarm", hwmon, idx);
-	TST_SYSFS_ASSERT_BOOL_SILENT(PATH_CLASS_HWMON "/%s/in%d_lcrit_alarm", hwmon, idx);
+	CHECK_RANGELL(-100000, 100000,
+		      PATH_CLASS_HWMON "/%s/in%d_input", hwmon, idx);
+
+	CHECK_BOOL(PATH_CLASS_HWMON "/%s/in%d_alarm", hwmon, idx);
+	CHECK_BOOL(PATH_CLASS_HWMON "/%s/in%d_min_alarm", hwmon, idx);
+	CHECK_BOOL(PATH_CLASS_HWMON "/%s/in%d_max_alarm", hwmon, idx);
+	CHECK_BOOL(PATH_CLASS_HWMON "/%s/in%d_crit_alarm", hwmon, idx);
+	CHECK_BOOL(PATH_CLASS_HWMON "/%s/in%d_lcrit_alarm", hwmon, idx);
 }
 
 static void check_curr_channel(const char *hwmon, int idx)
@@ -97,10 +127,10 @@ static void check_curr_channel(const char *hwmon, int idx)
 	 * Unlike fan/power, current can be negative on bidirectional sensors,
 	 * e.g. a battery charge/discharge current monitor.
 	 */
-	TST_SYSFS_ASSERT_RANGELL_SILENT(-500000, 500000,
-					PATH_CLASS_HWMON "/%s/curr%d_input", hwmon, idx);
+	CHECK_RANGELL(-500000, 500000,
+		      PATH_CLASS_HWMON "/%s/curr%d_input", hwmon, idx);
 
-	TST_SYSFS_ASSERT_BOOL_SILENT(PATH_CLASS_HWMON "/%s/curr%d_alarm", hwmon, idx);
+	CHECK_BOOL(PATH_CLASS_HWMON "/%s/curr%d_alarm", hwmon, idx);
 }
 
 static void check_power_channel(const char *hwmon, int idx)
@@ -110,13 +140,13 @@ static void check_power_channel(const char *hwmon, int idx)
 	 * sensor (CPU, GPU, PSU rail, ...) while still fitting within
 	 * LONG_MAX on 32bit architectures.
 	 */
-	TST_SYSFS_ASSERT_RANGELL_SILENT(0, 2000000000,
-					PATH_CLASS_HWMON "/%s/power%d_input", hwmon, idx);
+	CHECK_RANGELL(0, 2000000000,
+		      PATH_CLASS_HWMON "/%s/power%d_input", hwmon, idx);
 }
 
 static void check_pwm_channel(const char *hwmon, int idx)
 {
-	TST_SYSFS_ASSERT_RANGELL_SILENT(0, 255, PATH_CLASS_HWMON "/%s/pwm%d", hwmon, idx);
+	CHECK_RANGELL(0, 255, PATH_CLASS_HWMON "/%s/pwm%d", hwmon, idx);
 }
 
 static void check_hwmon_device(const char *hwmon)
@@ -127,8 +157,8 @@ static void check_hwmon_device(const char *hwmon)
 	if (TST_SYSFS_READ_STR(name, sizeof(name), PATH_CLASS_HWMON "/%s/name", hwmon))
 		tst_res(TINFO, "%s: name = '%s'", hwmon, name);
 
-	TST_SYSFS_ASSERT_RANGELL_SILENT(1, 3600000,
-					PATH_CLASS_HWMON "/%s/update_interval", hwmon);
+	CHECK_RANGELL(1, 3600000,
+		      PATH_CLASS_HWMON "/%s/update_interval", hwmon);
 
 	/* inN channels are numbered from 0, per the hwmon ABI */
 	for (i = 0; i <= MAX_CHANNELS; i++)
@@ -147,7 +177,9 @@ static void do_test(void)
 {
 	DIR *d;
 	struct dirent *ent;
-	int found = 0;
+	int devices = 0;
+
+	checked = 0;
 
 	if (!tst_sysfs_exists(PATH_CLASS_HWMON))
 		tst_brk(TCONF, PATH_CLASS_HWMON ": not present");
@@ -158,14 +190,25 @@ static void do_test(void)
 		if (strncmp(ent->d_name, "hwmon", 5))
 			continue;
 
-		found = 1;
+		devices++;
 		check_hwmon_device(ent->d_name);
 	}
 
 	SAFE_CLOSEDIR(d);
 
-	if (!found)
+	if (!devices) {
 		tst_res(TCONF, "No hwmon device found");
+		return;
+	}
+
+	if (checked) {
+		tst_res(TPASS, "Validated %u attributes on %d hwmon devices",
+			checked, devices);
+	} else {
+		tst_res(TCONF,
+			"%d hwmon devices present, but no checkable attributes",
+			devices);
+	}
 }
 
 static struct tst_test test = {
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
