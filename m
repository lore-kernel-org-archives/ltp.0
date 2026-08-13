Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0798EC5CFDB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 09:46:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDC3B3E6BF6
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 11:46:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4D263DA1BE
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 11:46:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0436A6001EA
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 11:46:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786614369; x=1818150369;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=m3QWQruDb1ILjrP8aeOcEzXJy53SSgbE5Xb6Us1DmYI=;
 b=MlMshbrGZx+xP5uS78byDE1ERMWfzbGf1Y4n/oQtfAp6n3J27Ezcuxtz
 vOW/hzFjU1B93vVeKxfT/oExqUrFIgD4FAVXP5KOOQh0+mCeHNGU2G+a2
 jLQmO3mV/N9zv0TP1vQKTri0LZRHF8hda0ARDJ4JX5m5tFFuwNSw4BoOB
 YA1D+7EceBn2kqF/5yHmbUFQXhipKAqWZfgGlMgk+Anq1DeJ5Pqchz4Ak
 ZR91lOf9gYbKcXbUQTpjWPzAmq9D2wP9oBWL0umHbLtp9rUnQYu97L+7s
 MGAUHBX+D51h3EDNCXGEKbu7OSGXCpmCZ2iEUxkT/Sk4XtAvO/maSZbZU w==;
X-CSE-ConnectionGUID: N6ZsJDyuSDK2NR3N0CMMoQ==
X-CSE-MsgGUID: zLBRFTPrRQqDb4WwVlaBWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="97532120"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="97532120"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 02:46:06 -0700
X-CSE-ConnectionGUID: jaSN6JvZSwWQXbLvWRx3Uw==
X-CSE-MsgGUID: Ykluf0UWSjmVQqMXBdU4+A==
X-ExtLoop1: 1
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.237.142.111])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 02:46:04 -0700
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Thu, 13 Aug 2026 11:45:50 +0200
Message-ID: <20260813094549.196724-2-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] pmc_core: add test for pkgc_blocker_residency_show
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
Cc: helena.anna.dubel@intel.com, tomasz.ossowski@intel.com,
 rafael.j.wysocki@intel.com, daniel.niestepski@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add a test for the /sys/kernel/debug/pmc_core/pkgc_blocker_residency_show
interface added in kernel commit d727eb1c3ede ("platform/x86/intel/pmc:
Enable Pkgc blocking residency counter"), first released in v7.2.

The debugfs file reports per-source counters tracking which sources kept
the platform out of package C-states. The driver prints one line per
counter as "%-30s %-30u", where the name is a
PKGC_BLOCK_RESIDENCY_<SOURCE> token and the value counts the 10us
intervals during which that source blocked a package C-state entry.

The counter set is platform specific, so rather than checking a hardcoded
list the test samples the file twice and verifies that every line is a
PKGC_BLOCK_RESIDENCY_<SOURCE> token followed by exactly one unsigned value
that fits in u32, that the set of counters is stable across the two reads,
and that no counter advanced by more than the elapsed wall clock time
allows.

The last check is what catches real breakage. The values are u32 counting
10us intervals, so a busy source wraps in well under a day: on Nova Lake,
PKGC_BLOCK_RESIDENCY_PMC_LTR advances fast enough to wrap roughly every 15
hours. The delta is therefore computed modulo 2^32, which tolerates a
genuine wrap while turning a counter reset or backward jump into a large
advance that the elapsed-time bound rejects. A telemetry region read at
the wrong offset shows up the same way. Because the bound scales with the
measured interval, what it limits is the fraction of that interval a
source spent blocking, so it holds regardless of how long the sample took.

An unchanged counter is not a failure. Most sources are idle and read 0
permanently; on the test system 22 of 28 counters never moved. The
counters are backed by a PMT telemetry region that the PMC refreshes
asynchronously, at roughly 1s granularity on Nova Lake, so the second
sample is retried with an exponential backoff until it observes a refresh
rather than being taken after a fixed sleep. The retries are capped at 2s,
after which a sample that saw no change at all is reported as every source
being idle. In practice the test finishes in 0.1s to 1.1s. The
plausibility bound allows a factor of two over the theoretical maximum,
since a busy source can run close to it: PMC_LTR was observed at 76% of
the ceiling.

The debugfs file is only created for a PMC exposing a package C-state
telemetry endpoint (pc_guid in the driver's pmc_dev_info), which currently
means Nova Lake only. Other platforms report TCONF.

Requires CONFIG_INTEL_PMC_CORE and CONFIG_DEBUG_FS, needs root, and is
restricted to x86/x86_64 on GenuineIntel. Root is needed because
/sys/kernel/debug is mode 0700 and owned by root, so the counter file
cannot be opened otherwise. The vendor check is redundant with the kconfig
and debugfs checks, but it is evaluated first and so reports the actual
reason rather than a missing debugfs file.

Tested on Nova Lake running 7.2.0-rc7: 28 counters reported, TPASS over 30
runs, with the worst observed advance at 23% of the bound. Fault injection
against a stub file confirms the test detects a counter reset, an
out-of-range jump, a signed value, a trailing token, a bare prefix with no
source, a value too large for u32, a non-numeric value, a renamed counter,
a changed counter count and an empty file, while still accepting a genuine
u32 wrap.

Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
---
 runtest/power_management_tests                |   1 +
 testcases/kernel/power_management/.gitignore  |   1 +
 .../pkgc_blocker_residency_show.c             | 269 ++++++++++++++++++
 3 files changed, 271 insertions(+)
 create mode 100644 testcases/kernel/power_management/pkgc_blocker_residency_show.c

diff --git a/runtest/power_management_tests b/runtest/power_management_tests
index 5a22283d6..a3c7cab5e 100644
--- a/runtest/power_management_tests
+++ b/runtest/power_management_tests
@@ -2,6 +2,7 @@
 cpufreq_intel cpufreq_intel
 rfim01 rfim01
 high_freq_hwp_cap_cppc high_freq_hwp_cap_cppc
+pkgc_blocker_residency_show pkgc_blocker_residency_show
 runpwtests03 runpwtests03.sh
 runpwtests04 runpwtests04.sh
 runpwtests06 runpwtests06.sh
diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
index 766f07901..4dd1fc329 100644
--- a/testcases/kernel/power_management/.gitignore
+++ b/testcases/kernel/power_management/.gitignore
@@ -1,3 +1,4 @@
 high_freq_hwp_cap_cppc
 cpufreq_intel
+pkgc_blocker_residency_show
 rfim01
diff --git a/testcases/kernel/power_management/pkgc_blocker_residency_show.c b/testcases/kernel/power_management/pkgc_blocker_residency_show.c
new file mode 100644
index 000000000..15d92f8bc
--- /dev/null
+++ b/testcases/kernel/power_management/pkgc_blocker_residency_show.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2026 Piotr Kubaj <piotr.kubaj@intel.com>
+ */
+
+/*\
+ * Verify that pkgc_blocker_residency_show reports well-formed package C-state
+ * blocker residency counters that advance at a plausible rate.
+ *
+ * The intel_pmc_core driver prints one line per counter as "%-30s %-30u",
+ * where the name is a PKGC_BLOCK_RESIDENCY_<SOURCE> token and the value counts
+ * the 10us intervals during which <SOURCE> blocked a package C-state entry.
+ *
+ * The counter set is platform specific, so instead of checking a hardcoded
+ * list the test samples the file twice and verifies that
+ *
+ * - every line is a PKGC_BLOCK_RESIDENCY_<SOURCE> token followed by exactly
+ *   one unsigned value that fits in u32,
+ * - the set of counters does not change between the two reads,
+ * - no counter advances by more than the elapsed wall clock time allows.
+ *
+ * The last check is the one that catches real regressions. The values are u32
+ * counting 10us intervals, so a busy source wraps in well under a day and a
+ * wrap is indistinguishable from a bogus read unless the delta is evaluated
+ * modulo 2^32 and bounded by the elapsed time. A telemetry region read at the
+ * wrong offset then shows up as an implausible jump.
+ *
+ * The debugfs file is only created for a PMC that exposes a package C-state
+ * telemetry endpoint (pc_guid in the driver's pmc_dev_info), so on platforms
+ * without one the test is not applicable.
+ *
+ * The test needs root because /sys/kernel/debug is mode 0700 and owned by
+ * root, so the counter file cannot be opened otherwise.
+ */
+
+#include <time.h>
+#include "tst_clocks.h"
+#include "tst_safe_stdio.h"
+#include "tst_test.h"
+#include "tst_timer.h"
+
+#define DEBUGFS "/sys/kernel/debug"
+#define PATH DEBUGFS "/pmc_core/pkgc_blocker_residency_show"
+#define PREFIX "PKGC_BLOCK_RESIDENCY_"
+
+/* Nova Lake reports 28 counters, leave room for future platforms */
+#define MAX_COUNTERS 128
+#define NAME_LEN 64
+
+/* Each count stands for a 10us interval spent blocking package C-state entry */
+#define COUNTER_PERIOD_US 10
+
+/*
+ * Cap, in seconds, on how long to poll for the second sample. The PMT
+ * telemetry region behind these counters refreshes at roughly 1s granularity
+ * on Nova Lake, so the retries end within about a second. Two seconds is
+ * enough headroom that a sample which observed no refresh at all means "every
+ * source idle" rather than "polled too early".
+ */
+#define MAX_SAMPLE_DELAY 2
+
+/*
+ * Slack over the theoretical maximum advance. The bound scales with the
+ * measured interval, so what it really limits is the fraction of that interval
+ * a source spent blocking, and a busy source can legitimately run close to the
+ * ceiling: PKGC_BLOCK_RESIDENCY_PMC_LTR was observed at 76% of it on Nova Lake.
+ * A factor of two keeps that clear of the limit at any interval length, while
+ * still rejecting a bogus telemetry read, which overshoots by orders of
+ * magnitude.
+ */
+#define SLACK 2
+
+struct snapshot {
+	char names[MAX_COUNTERS][NAME_LEN];
+	uint32_t values[MAX_COUNTERS];
+	int cnt;
+};
+
+static struct snapshot first, second;
+
+/*
+ * Decide whether a counter that read @old and then @new, @elapsed_us
+ * microseconds apart, advanced plausibly.
+ *
+ * The values are u32 and wrap, so the advance has to be computed with modular
+ * arithmetic rather than by comparing @new against @old. Each count stands for
+ * COUNTER_PERIOD_US of blocked time, which bounds how far a counter can move
+ * over a given interval.
+ *
+ * An unchanged counter is normal: it means that source did not block a package
+ * C-state entry during the interval. Most counters on an idle system read 0
+ * permanently.
+ */
+static int delta_plausible(uint32_t old, uint32_t new,
+			   unsigned long long elapsed_us)
+{
+	uint32_t delta = new - old;
+	unsigned long long max = elapsed_us / COUNTER_PERIOD_US;
+
+	return delta <= max * SLACK;
+}
+
+static void read_snapshot(struct snapshot *snap)
+{
+	char line[256];
+	FILE *fp;
+
+	snap->cnt = 0;
+	fp = SAFE_FOPEN(PATH, "r");
+
+	while (fgets(line, sizeof(line), fp)) {
+		char name[NAME_LEN], value[NAME_LEN], extra;
+		unsigned long long parsed;
+
+		line[strcspn(line, "\n")] = '\0';
+
+		/*
+		 * The value is scanned as a string rather than with %u so that
+		 * a signed or out of range value is rejected instead of being
+		 * quietly converted. The trailing %c rejects a third token; the
+		 * space in front of it skips the padding the driver emits.
+		 */
+		if (sscanf(line, "%63s %63s %c", name, value, &extra) != 2) {
+			tst_res(TFAIL, "malformed counter line: '%s'", line);
+			continue;
+		}
+
+		if (strncmp(name, PREFIX, sizeof(PREFIX) - 1) ||
+		    !name[sizeof(PREFIX) - 1]) {
+			tst_res(TFAIL, "counter '%s' is not a " PREFIX "<SOURCE> token",
+				name);
+			continue;
+		}
+
+		if (value[strspn(value, "0123456789")]) {
+			tst_res(TFAIL, "counter '%s' has a non-numeric value '%s'",
+				name, value);
+			continue;
+		}
+
+		parsed = strtoull(value, NULL, 10);
+
+		if (parsed > UINT32_MAX) {
+			tst_res(TFAIL, "counter '%s' value '%s' does not fit in u32",
+				name, value);
+			continue;
+		}
+
+		if (snap->cnt == MAX_COUNTERS)
+			tst_brk(TBROK, "more than %d counters reported", MAX_COUNTERS);
+
+		strcpy(snap->names[snap->cnt], name);
+		snap->values[snap->cnt] = parsed;
+		snap->cnt++;
+	}
+
+	SAFE_FCLOSE(fp);
+}
+
+static void setup(void)
+{
+	if (access(DEBUGFS, F_OK))
+		tst_brk(TCONF | TERRNO, "debugfs not mounted at " DEBUGFS);
+
+	if (access(PATH, R_OK))
+		tst_brk(TCONF | TERRNO, "%s not available", PATH);
+}
+
+/*
+ * Take the second sample, reporting whether it differs from the first one.
+ *
+ * The counters are backed by a PMT telemetry region that the PMC refreshes
+ * asynchronously, so the second sample is retried until it observes a refresh
+ * instead of being taken after a fixed delay. A differing counter count also
+ * counts as a difference, so that the mismatch is reported rather than polled
+ * over.
+ */
+static int second_sample_differs(void)
+{
+	read_snapshot(&second);
+
+	if (first.cnt != second.cnt)
+		return 1;
+
+	for (int i = 0; i < first.cnt; i++) {
+		if (first.values[i] != second.values[i])
+			return 1;
+	}
+
+	return 0;
+}
+
+static void run(void)
+{
+	struct timespec start, end;
+	unsigned long long elapsed_us;
+	int differs, fails = 0;
+
+	tst_clock_gettime(CLOCK_MONOTONIC, &start);
+	read_snapshot(&first);
+
+	if (!first.cnt)
+		tst_brk(TFAIL, "no residency counters reported");
+
+	differs = TST_RETRY_FN_EXP_BACKOFF(second_sample_differs(),
+					   TST_RETVAL_NOTNULL, MAX_SAMPLE_DELAY);
+
+	tst_clock_gettime(CLOCK_MONOTONIC, &end);
+
+	elapsed_us = tst_timespec_diff_us(end, start);
+
+	if (!differs) {
+		tst_res(TINFO, "no counter changed over %lluus, all sources idle",
+			elapsed_us);
+	}
+
+	if (first.cnt != second.cnt) {
+		tst_brk(TFAIL, "counter count changed between reads: %d -> %d",
+			first.cnt, second.cnt);
+	}
+
+	for (int i = 0; i < first.cnt; i++) {
+		if (strcmp(first.names[i], second.names[i])) {
+			tst_res(TFAIL, "counter %d renamed between reads: %s -> %s",
+				i, first.names[i], second.names[i]);
+			fails++;
+			continue;
+		}
+
+		tst_res(TDEBUG, "%s: %u -> %u", first.names[i],
+			first.values[i], second.values[i]);
+
+		if (!delta_plausible(first.values[i], second.values[i], elapsed_us)) {
+			tst_res(TFAIL,
+				"%s advanced implausibly over %lluus: %u -> %u",
+				first.names[i], elapsed_us,
+				first.values[i], second.values[i]);
+			fails++;
+		}
+	}
+
+	if (!fails) {
+		tst_res(TPASS, "%d residency counters well-formed, advancing plausibly",
+			first.cnt);
+	}
+}
+
+static struct tst_test test = {
+	.min_kver = "7.2",
+	.needs_cpu_vendor = "GenuineIntel",
+	.needs_root = 1,
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_DEBUG_FS",
+		"CONFIG_INTEL_PMC_CORE",
+		NULL
+	},
+	.supported_archs = (const char *const []) {
+		"x86",
+		"x86_64",
+		NULL
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "d727eb1c3ede7c21f885ded1f1ad65b47434a9b9"},
+		{}
+	},
+	.setup = setup,
+	.test_all = run
+};
-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
