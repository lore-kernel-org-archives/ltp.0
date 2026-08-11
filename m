Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE740C5B572
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 16:29:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B54F03D07EE
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 18:29:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1848F3CB92A
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 18:29:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CDC0B60012C
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 18:29:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786465769; x=1818001769;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=w3zKQBtrbTnxt1GKwTeDPG1TT/otcO/49gBaijYlqRA=;
 b=PAVPZVQ3pFJ/+xvmQEwN1440X3eCcBj6upYsHeeKXI3B0RhpucxHy09i
 hkIzefCqh9dTnS6rRsfFXgoipj6usfryjHuSWrdfLXOxtDB2+0rtWzJHa
 vf1NSAktukOxD/GOi1DPjXBSFx88gleSR7LrPmywJSI6jB7qLMCZn71bK
 hV7Hqixp7KEc4CTTf+2CiA/IksuMElEW75Oq0AKQcm2kTbPLrURMKCIOU
 fY+eB3mBKIR7cdZQ4UCGSKeu/ct61Zb7qbjeXGW6N8FWMznLjTMKohRGS
 E/g77vcr3UW7WnFtboCK4siQXeQQCmpd0497k1gISur4EUdSiWCG9flQr A==;
X-CSE-ConnectionGUID: uAWrKK+4R1WeXmlcfY5ZaA==
X-CSE-MsgGUID: tYeKhK3xT3qdgauTXm9ukg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="104533924"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="104533924"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 09:29:26 -0700
X-CSE-ConnectionGUID: OQFGNxD4Sju9ZuGgeUm0qQ==
X-CSE-MsgGUID: ay9WM6ShS1+/9nuAWuskPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="261627058"
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.237.142.111])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 09:29:25 -0700
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Tue, 11 Aug 2026 18:28:57 +0200
Message-ID: <20260811162856.67654-2-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pmc_core: add test for pkgc_blocker_residency_show
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
counter as "%-30s %-30u", where the name is a PKGC_BLOCK_RESIDENCY_<SOURCE>
token and the value counts the 10us intervals during which that source
blocked a package C-state entry.

The counter set is platform specific, so rather than checking a hardcoded
list the test samples the file twice and verifies that every line names a
PKGC_BLOCK_RESIDENCY_ source with a numeric value, that the set of counters
is stable across the two reads, and that no counter advanced by more than
the elapsed wall clock time allows.

The last check is what catches real breakage. The values are u32 counting
10us intervals, so a busy source wraps in well under a day: on Nova Lake,
PKGC_BLOCK_RESIDENCY_PMC_LTR advances fast enough to wrap roughly every 15
hours. The delta is therefore computed modulo 2^32, which tolerates a
genuine wrap while turning a counter reset or backward jump into a large
advance that the elapsed-time bound rejects. A telemetry region read at the
wrong offset shows up the same way. At the 2s sample interval the bound
admits about 0.01% of the u32 value space.

An unchanged counter is not a failure. Most sources are idle and read 0
permanently; on the test system 21 of 28 counters never moved. The sample
interval is 2s because the PMT telemetry region refreshes at roughly 1s
granularity - no counter moved over a 200ms or 500ms interval, so a shorter
sample would make every counter look static. The plausibility bound allows
a factor of two over the theoretical maximum, since a busy source can run
close to it: PMC_LTR was observed at 76% of the ceiling.

The debugfs file is only created for a PMC exposing a package C-state
telemetry endpoint (pc_guid in the driver's pmc_dev_info), which currently
means Nova Lake only. Other platforms report TCONF.

Requires CONFIG_INTEL_PMC_CORE and CONFIG_DEBUG_FS, needs root, and is
restricted to x86/x86_64 on GenuineIntel. The vendor check is redundant
with the kconfig and debugfs checks, but it is evaluated first and so
reports the actual reason rather than a missing debugfs file.

Tested on Nova Lake running 7.2.0-rc7: 28 counters reported, TPASS.
Fault injection against a stub file confirms the test detects a counter
reset, an out-of-range jump, a malformed line, an unexpected counter name
and an empty file, while still accepting a genuine u32 wrap.

Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
---
 runtest/power_management_tests                |   1 +
 testcases/kernel/power_management/.gitignore  |   1 +
 .../pkgc_blocker_residency_show.c             | 211 ++++++++++++++++++
 3 files changed, 213 insertions(+)
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
index 766f07901..a35ca3567 100644
--- a/testcases/kernel/power_management/.gitignore
+++ b/testcases/kernel/power_management/.gitignore
@@ -1,3 +1,4 @@
 high_freq_hwp_cap_cppc
 cpufreq_intel
 rfim01
+pkgc_blocker_residency_show
diff --git a/testcases/kernel/power_management/pkgc_blocker_residency_show.c b/testcases/kernel/power_management/pkgc_blocker_residency_show.c
new file mode 100644
index 000000000..37c752c9c
--- /dev/null
+++ b/testcases/kernel/power_management/pkgc_blocker_residency_show.c
@@ -0,0 +1,211 @@
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
+ * - every line names a PKGC_BLOCK_RESIDENCY_ source and carries a value,
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
+ * Interval between the two samples. The PMT telemetry region behind these
+ * counters refreshes at roughly 1s granularity: measured on Nova Lake, no
+ * counter moved over 200ms or 500ms, while 5 of 28 moved over 1s. Sample well
+ * past that so a static counter means "idle source", not "not refreshed yet".
+ */
+#define SAMPLE_DELAY_US 2000000
+
+/*
+ * Slack over the theoretical maximum advance. The two reads bracket the
+ * measured interval, and a busy source can legitimately run close to the
+ * ceiling: PKGC_BLOCK_RESIDENCY_PMC_LTR was observed at 76% of it on Nova Lake.
+ * A factor of two keeps that clear of the limit while still rejecting a bogus
+ * telemetry read, which overshoots by orders of magnitude.
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
+		char name[NAME_LEN];
+		unsigned int value;
+
+		line[strcspn(line, "\n")] = '\0';
+
+		if (sscanf(line, "%63s %u", name, &value) != 2) {
+			tst_res(TFAIL, "malformed counter line: '%s'", line);
+			continue;
+		}
+
+		if (strncmp(name, PREFIX, sizeof(PREFIX) - 1)) {
+			tst_res(TFAIL, "counter '%s' lacks the " PREFIX " prefix", name);
+			continue;
+		}
+
+		if (snap->cnt == MAX_COUNTERS)
+			tst_brk(TBROK, "more than %d counters reported", MAX_COUNTERS);
+
+		strcpy(snap->names[snap->cnt], name);
+		snap->values[snap->cnt] = value;
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
+static void run(void)
+{
+	struct timespec start, end;
+	unsigned long long elapsed_us;
+	int fails = 0;
+
+	tst_clock_gettime(CLOCK_MONOTONIC, &start);
+	read_snapshot(&first);
+
+	if (!first.cnt)
+		tst_brk(TFAIL, "no residency counters reported");
+
+	usleep(SAMPLE_DELAY_US);
+
+	read_snapshot(&second);
+	tst_clock_gettime(CLOCK_MONOTONIC, &end);
+
+	elapsed_us = tst_timespec_diff_us(end, start);
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
