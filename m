Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C1BC61DD6
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:41:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3EDA83E4B68
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:41:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07C533E18A9
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:41:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5F0F510000C7
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:41:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788525661; x=1820061661;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eanUXYNSKMR0rTAlMXc/DaWphfipiU+m81FZFOSgFug=;
 b=bowOMNIRu37V8v5t9Cn5s3j/pickOZrYPOG+U9xeGdzknGSwGQVYpboX
 pcQE3bDTUndj0AUMY4O5egiNqAUfAym4yFBZWRAR7E9TtGjQhJwCZLRqA
 ClylGYFlmRAs8T22QKZAGKINKltWj10FkXkXouSdvO9TKP3TIlUomY0eS
 h5PWBkV7d0jgLGp3Nh+yLpvOmYXFAgQA739/QmD5moOWe+vcvPG69z2r1
 L7IZTZlI/QtP2c6IlzqgQR7ZixnPM4MjUhMGIgt72pxjLRSgsfiHw6QE/
 /6FOVxCX05Wz8S8Yzn5FhMfxQcj+vW+tJ2226zrfrF3gJPYXtUtNFUvLj w==;
X-CSE-ConnectionGUID: evdpxf7xTriQ40UDm+TOXA==
X-CSE-MsgGUID: pi0/yfT7TrGuX/wd1kv9Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="106544230"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="106544230"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 05:41:01 -0700
X-CSE-ConnectionGUID: 3euziGrdTUyiDmHiSgUFOQ==
X-CSE-MsgGUID: q6qZ7XEARMeJGbF++GydpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="266780777"
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.237.142.111])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 05:40:59 -0700
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Fri,  4 Sep 2026 14:40:41 +0200
Message-ID: <20260904124042.212065-3-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124042.212065-1-piotr.kubaj@intel.com>
References: <20260904124042.212065-1-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] pmc_core: add test for pkgc_ltr_blocker_show
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

Add coverage for the pkgc_ltr_blocker_show debugfs file added in kernel
commit 38c79dd63b72 ("platform/x86/intel/pmc: Enable PkgC LTR blocking
counter") and first released in v7.2. The counters report how many times
an LTR posted by each source blocked a package C-state entry, and so far
nothing checked that the driver exports them correctly.

The counter set is platform specific, so instead of a hardcoded list of
names the test samples the file twice and checks that it can be read in
full, that every line is a PKGC_PREVENT_LTR_<SOURCE> token followed by
exactly one value that fits in u32, that the counter set does not change
between the reads, and that no counter advances by more entries than the
package could have attempted over the interval.

The last check is the one that catches a telemetry region read at the
wrong offset. The values wrap, so the advance is evaluated modulo 2^32
and bounded by the time the counter had to advance over, widened by how
stale the first sample can be, because the PMC refreshes the telemetry
region behind the counters asynchronously. An arbitrary u32 read out of
the wrong offset overshoots that bound by orders of magnitude.

Tested on Nova Lake running 7.3.0-rc1.

Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
---
 runtest/power_management_tests                |   1 +
 testcases/kernel/power_management/.gitignore  |   1 +
 .../power_management/pkgc_ltr_blocker_show.c  | 294 ++++++++++++++++++
 3 files changed, 296 insertions(+)
 create mode 100644 testcases/kernel/power_management/pkgc_ltr_blocker_show.c

diff --git a/runtest/power_management_tests b/runtest/power_management_tests
index 884e615cd..93b5a5c10 100644
--- a/runtest/power_management_tests
+++ b/runtest/power_management_tests
@@ -1,4 +1,5 @@
 #POWER_MANAGEMENT
+pkgc_ltr_blocker_show pkgc_ltr_blocker_show
 runpwtests01 runpwtests01.sh
 runpwtests02 runpwtests02.sh
 runpwtests03 runpwtests03.sh
diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
index 0c2a3ed4b..0d7db221b 100644
--- a/testcases/kernel/power_management/.gitignore
+++ b/testcases/kernel/power_management/.gitignore
@@ -1 +1,2 @@
 pm_get_sched_values
+pkgc_ltr_blocker_show
diff --git a/testcases/kernel/power_management/pkgc_ltr_blocker_show.c b/testcases/kernel/power_management/pkgc_ltr_blocker_show.c
new file mode 100644
index 000000000..ef6b2110c
--- /dev/null
+++ b/testcases/kernel/power_management/pkgc_ltr_blocker_show.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2026 Piotr Kubaj <piotr.kubaj@intel.com>
+ */
+
+/*\
+ * Verify that pkgc_ltr_blocker_show reports well-formed package C-state LTR
+ * blocker counters that advance at a plausible rate.
+ *
+ * The intel_pmc_core driver prints one line per counter as "%-30s %-30u",
+ * where the name is a PKGC_PREVENT_LTR_<SOURCE> token and the value counts how
+ * many times an LTR posted by <SOURCE> blocked a package C-state entry.
+ *
+ * The counter set is platform specific, so instead of checking a hardcoded
+ * list the test samples the file twice and verifies that
+ *
+ * - the file can be read in full, so that a failing telemetry read in the
+ *   driver is not mistaken for a short counter list,
+ * - every line is a PKGC_PREVENT_LTR_<SOURCE> token followed by exactly one
+ *   unsigned value that fits in u32,
+ * - the set of counters does not change between the two reads,
+ * - no counter advances by more entries than the package could have attempted
+ *   over the interval.
+ *
+ * The last check is the one that catches a telemetry region read at the wrong
+ * offset. The values are u32 and wrap, so the advance has to be evaluated
+ * modulo 2^32, and a wrap is then indistinguishable from a bogus read unless
+ * the delta is bounded by the time the counter had to advance over. An
+ * arbitrary u32 read out of the wrong offset averages 2^31, orders of
+ * magnitude past what the bound allows.
+ *
+ * The debugfs file is only created for a PMC that exposes a package C-state
+ * telemetry endpoint (pc_guid in the driver's pmc_dev_info), so on platforms
+ * without one the test is not applicable.
+ *
+ * The test needs root because /sys/kernel/debug is mode 0700 and owned by
+ * root, so the counter file cannot be opened otherwise, and because the test
+ * library mounts debugfs if it is not mounted already.
+ */
+
+#include <time.h>
+#include "tst_clocks.h"
+#include "tst_safe_stdio.h"
+#include "tst_test.h"
+#include "tst_timer.h"
+
+#define PATH TST_DEBUGFS_PATH "/pmc_core/pkgc_ltr_blocker_show"
+#define PREFIX "PKGC_PREVENT_LTR_"
+
+/* Nova Lake reports 5 counters, leave room for future platforms */
+#define MAX_COUNTERS 64
+#define NAME_LEN 64
+
+/*
+ * Cap, in seconds, on how long to poll for a second sample that differs from
+ * the first one. On an idle Nova Lake the counters advance in bursts a few
+ * seconds apart, because a blocked entry needs the package to attempt a C-state
+ * entry in the first place, so a window of a few seconds is what it takes for
+ * the delta check to have anything to look at. TST_RETRY_FN_EXP_BACKOFF() ends
+ * up sleeping about twice the cap in total, hence the modest value here.
+ */
+#define MAX_SAMPLE_DELAY 4
+
+/*
+ * Allowance for how stale the first sample can be. The PMC refreshes the
+ * telemetry region behind these counters asynchronously, so the first read can
+ * land just before a refresh and return a snapshot that is almost a whole
+ * refresh period old. The retry then observes a period worth of blocked entries
+ * after only microseconds of measured time, which the measured interval on its
+ * own does not account for.
+ *
+ * The allowance is the same window the test is willing to poll a refresh out
+ * of, which on Nova Lake is several times the observed refresh period.
+ */
+#define REFRESH_AGE_US (MAX_SAMPLE_DELAY * 1000000ULL)
+
+/*
+ * Blocked entries per microsecond the bound allows. Each count stands for one
+ * package C-state entry that was blocked, and entries can only be attempted as
+ * fast as the package can cycle between idle and running, which takes
+ * microseconds. Ten per microsecond is therefore already past what the hardware
+ * can produce - the counters were observed advancing by about 6 per second on
+ * an idle Nova Lake - and the headroom costs the check nothing, because the
+ * bogus read it exists to catch overshoots it by orders of magnitude anyway.
+ */
+#define MAX_BLOCKS_PER_US 10
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
+ * Largest advance a counter can plausibly show over two samples taken
+ * @elapsed_us microseconds apart.
+ *
+ * The interval the counter had to advance over is the measured one widened by
+ * REFRESH_AGE_US, because the sampled values come from a telemetry snapshot
+ * that is already up to a refresh period old, not from the instants the file
+ * was read.
+ */
+static unsigned long long max_plausible_delta(unsigned long long elapsed_us)
+{
+	return (elapsed_us + REFRESH_AGE_US) * MAX_BLOCKS_PER_US;
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
+	/*
+	 * A telemetry read that fails in the driver aborts the seq_file read
+	 * instead of ending it at EOF, so without this the counters lost to the
+	 * error would look like a platform reporting fewer of them.
+	 */
+	if (ferror(fp))
+		tst_brk(TFAIL, "reading " PATH " failed after %d counters", snap->cnt);
+
+	SAFE_FCLOSE(fp);
+}
+
+static void setup(void)
+{
+	if (access(PATH, R_OK))
+		tst_brk(TCONF | TERRNO, "%s not available", PATH);
+}
+
+/*
+ * Take the second sample, reporting whether it differs from the first one.
+ *
+ * A blocked entry is a sporadic event and the counters are backed by a PMT
+ * telemetry region that the PMC refreshes asynchronously, so the second sample
+ * is retried until it observes a change instead of being taken after a fixed
+ * delay. A differing counter count also counts as a difference, so that the
+ * mismatch is reported rather than polled over.
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
+	unsigned long long elapsed_us, max_delta;
+	int differs, fails = 0;
+
+	tst_clock_gettime(CLOCK_MONOTONIC, &start);
+	read_snapshot(&first);
+
+	if (!first.cnt)
+		tst_brk(TFAIL, "no LTR blocker counters reported");
+
+	differs = TST_RETRY_FN_EXP_BACKOFF(second_sample_differs(),
+					   TST_RETVAL_NOTNULL, MAX_SAMPLE_DELAY);
+
+	tst_clock_gettime(CLOCK_MONOTONIC, &end);
+
+	elapsed_us = tst_timespec_diff_us(end, start);
+	max_delta = max_plausible_delta(elapsed_us);
+
+	if (!differs) {
+		tst_res(TINFO, "no counter changed over %lluus, no entry was blocked",
+			elapsed_us);
+	}
+
+	if (first.cnt != second.cnt) {
+		tst_brk(TFAIL, "counter count changed between reads: %d -> %d",
+			first.cnt, second.cnt);
+	}
+
+	for (int i = 0; i < first.cnt; i++) {
+		uint32_t delta;
+
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
+		/*
+		 * The values are u32 and wrap, so the advance has to be
+		 * computed with modular arithmetic rather than by comparing the
+		 * second value against the first one. A delta of 0 is normal:
+		 * it means no entry was blocked by that source over the
+		 * interval, and most counters on an idle system read 0
+		 * permanently.
+		 */
+		delta = second.values[i] - first.values[i];
+
+		if (delta > max_delta) {
+			tst_res(TFAIL,
+				"%s advanced by %u over %lluus, at most %llu plausible: %u -> %u",
+				first.names[i], delta, elapsed_us, max_delta,
+				first.values[i], second.values[i]);
+			fails++;
+		}
+	}
+
+	if (!fails) {
+		tst_res(TPASS, "%d LTR blocker counters well-formed, advancing plausibly",
+			first.cnt);
+	}
+}
+
+static struct tst_test test = {
+	.min_kver = "7.2",
+	.needs_root = 1,
+	.needs_debugfs = 1,
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
+		{"linux-git", "38c79dd63b72e36919ef097d4e5025ca0fa17f34"},
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
