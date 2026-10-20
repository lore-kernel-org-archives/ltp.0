Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E993D606A319
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qBpvZI44
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48BEE3E616E
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 10:01:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF4743E27D5
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 10:00:48 +0200 (CEST)
Received: from mta0.migadu.com (out-32.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::20])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 629FE1000929
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 10:00:43 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=buKcNexPb0lvDQe5AmUulnHGCpy/u5coCSt+I4lr/yo=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792483243; v=1; x=1793088043;
 b=qBpvZI44PhnEc0Mu5Hj0kFXJi26Xa9ApKFYVVvFR8stVcL3/dqAwXHA3Myi4J+wM/Rlo6eA3
 lSfSYptPeJLb3VAohHY7DU3kEbtqlAJhiynMMrE/KNN5XqNSSUer7EcOfnMzd1dLlyc+elIWPKm
 +ulTdFk5mShDM5pwpnHt6SoI=
X-Envelope-To: ltp@lists.linux.it
Received: by mta12.migadu.com with ESMTPS id 94bf97b5cdf008f4;
 Tue, 20 Oct 2026 08:00:43 +0000
X-Mizu-Trace-ID: 94bf97b5cdf008f4
X-Migadu-Flow: FLOW_OUT
From: "Li Wang (Hieco)" <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Tue, 20 Oct 2026 16:00:33 +0800
Message-ID: <20261020080033.123660-1-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] sys_hwmon01: always report a result
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Xiaochen Shen <shenxiaochen@open-hieco.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

While at it, fix a preexisting off-by-one in the inN channel loop:
probe in0..in31 so that all channel types probe exactly MAX_CHANNELS
indices.

Signed-off-by: Li Wang (Hieco) <li.wang@linux.dev>
Reviewed-by: Xiaochen Shen <shenxiaochen@open-hieco.net>
---

Notes:
    v2:
    	- rename attr_exists() to sysfs_attr_exists() (Xiaochen)
    	- flatten the final if/else result reporting with an early return (Xiaochen)
    	- fix preexisting off-by-one in the inN channel loop, probe in0..in31
    	  so that all channel types probe exactly MAX_CHANNELS indices (Xiaochen)

 .../kernel/sysfs/class/hwmon/sys_hwmon01.c    | 111 ++++++++++++------
 1 file changed, 77 insertions(+), 34 deletions(-)

diff --git a/testcases/kernel/sysfs/class/hwmon/sys_hwmon01.c b/testcases/kernel/sysfs/class/hwmon/sys_hwmon01.c
index 1bb574c23..991852da7 100644
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
+static int sysfs_attr_exists(const char *fmt, ...)
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
+	if (sysfs_attr_exists(__VA_ARGS__)) { \
+		checked++; \
+		TST_SYSFS_ASSERT_RANGELL_SILENT(lo, hi, __VA_ARGS__); \
+	} \
+} while (0)
+
+#define CHECK_BOOL(...) do { \
+	if (sysfs_attr_exists(__VA_ARGS__)) { \
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
@@ -127,11 +157,11 @@ static void check_hwmon_device(const char *hwmon)
 	if (TST_SYSFS_READ_STR(name, sizeof(name), PATH_CLASS_HWMON "/%s/name", hwmon))
 		tst_res(TINFO, "%s: name = '%s'", hwmon, name);
 
-	TST_SYSFS_ASSERT_RANGELL_SILENT(1, 3600000,
-					PATH_CLASS_HWMON "/%s/update_interval", hwmon);
+	CHECK_RANGELL(1, 3600000,
+		      PATH_CLASS_HWMON "/%s/update_interval", hwmon);
 
 	/* inN channels are numbered from 0, per the hwmon ABI */
-	for (i = 0; i <= MAX_CHANNELS; i++)
+	for (i = 0; i < MAX_CHANNELS; i++)
 		check_in_channel(hwmon, i);
 
 	for (i = 1; i <= MAX_CHANNELS; i++) {
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
+	if (!checked) {
+		tst_res(TCONF, "%d hwmon devices present, but no checkable attributes",
+				devices);
+		return;
+	}
+
+	tst_res(TPASS, "Validated %u attributes on %d hwmon devices",
+			checked, devices);
 }
 
 static struct tst_test test = {
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
