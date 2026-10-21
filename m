Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CF3606A31E
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FYAQvQ3n
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 627C73C265A
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 11:00:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39EE83C8C85
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 10:59:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C5D3A1000953
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 10:59:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792573186; x=1824109186;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1xJf6L8wC8al/hxHAmSeW/6II6hfJ/NCwpWQ8h2axEs=;
 b=FYAQvQ3nu25UxpuNhEdD6DXiFZhLmpj8kvfuGA+m0tgDL5ZtEbZkO1h4
 H6117BzgaRKQxxyq7o+8ZMgIrpy+eQ5ql8kx3Co/yBmHpR2Xpa7EjzRMX
 XInDTxs8A80WL9ijG02aI0XvbfuD/e5w8IjWy5Slqa3fddr3SzDjywNeM
 8B2rk+Qd+TjFFVu/LuhTs9FQH1RjksY+U1/DzSSxhkZIzENp1/3L1Qxqq
 jfZYkpreg1W40JgoMyQMOHTmro2t2jrYyud2kOv3cn1L3Ygn7ElCr4piF
 fNgLegCrftccJ6AfZx+g1IaEnNTXFbd0cUdWlK7wube7otTCgR7GNQFau Q==;
X-CSE-ConnectionGUID: pXQZGdOaTgGOaQAWVxv7Ag==
X-CSE-MsgGUID: UeR/0bHESfCmt77EUUsXIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1167136"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1167136"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 01:59:44 -0700
X-CSE-ConnectionGUID: Q46ZbpgOR9qxpAZx47SWxg==
X-CSE-MsgGUID: SUrpdtswS8CCcYvOivByhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3033342"
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.237.142.111])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 01:59:42 -0700
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Wed, 21 Oct 2026 10:59:31 +0200
Message-ID: <20261021085932.20557-3-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021085932.20557-1-piotr.kubaj@intel.com>
References: <20261021085932.20557-1-piotr.kubaj@intel.com>
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
Subject: [LTP] [PATCH v5 2/3] pmc_core: add test for pkgc_ltr_blocker_show
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: helena.anna.dubel@intel.com, tomasz.ossowski@intel.com,
 rafael.j.wysocki@intel.com, daniel.niestepski@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Cover the pkgc_ltr_blocker_show debugfs file added in kernel commit
38c79dd63b72 ("platform/x86/intel/pmc: Enable PkgC LTR blocking
counter"), released in v7.2. It reports how many times an LTR posted by
each source blocked a package C-state entry.

The counter set is platform specific, so rather than matching a list of
names the test samples the file twice and checks that it reads to EOF,
that every line is a PKGC_PREVENT_LTR_<SOURCE> token followed by one u32
value, that the counter set is stable, and that no counter advances by
more entries than the package could have attempted over the interval.
The last check is what catches a telemetry region read at the wrong
offset: such a value overshoots the bound by orders of magnitude.

Tested on Nova Lake running 7.3.0-rc1.

Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
---
 runtest/power_management_tests                |   1 +
 testcases/kernel/power_management/.gitignore  |   1 +
 .../power_management/pkgc_ltr_blocker_show.c  | 311 ++++++++++++++++++
 3 files changed, 313 insertions(+)
 create mode 100644 testcases/kernel/power_management/pkgc_ltr_blocker_show.c

diff --git a/runtest/power_management_tests b/runtest/power_management_tests
index 5a22283d6..7708d3fd4 100644
--- a/runtest/power_management_tests
+++ b/runtest/power_management_tests
@@ -2,6 +2,7 @@
 cpufreq_intel cpufreq_intel
 rfim01 rfim01
 high_freq_hwp_cap_cppc high_freq_hwp_cap_cppc
+pkgc_ltr_blocker_show pkgc_ltr_blocker_show
 runpwtests03 runpwtests03.sh
 runpwtests04 runpwtests04.sh
 runpwtests06 runpwtests06.sh
diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
index 766f07901..b96084eca 100644
--- a/testcases/kernel/power_management/.gitignore
+++ b/testcases/kernel/power_management/.gitignore
@@ -1,3 +1,4 @@
 high_freq_hwp_cap_cppc
 cpufreq_intel
 rfim01
+pkgc_ltr_blocker_show
diff --git a/testcases/kernel/power_management/pkgc_ltr_blocker_show.c b/testcases/kernel/power_management/pkgc_ltr_blocker_show.c
new file mode 100644
index 000000000..49366b6bf
--- /dev/null
+++ b/testcases/kernel/power_management/pkgc_ltr_blocker_show.c
@@ -0,0 +1,311 @@
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
+ * the delta check to have anything to look at. TST_RETRY_FN_EXP_BACKOFF() can
+ * end up sleeping up to about twice the cap in total, hence the modest value
+ * here.
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
+static int fails;
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
+			fails++;
+			continue;
+		}
+
+		if (strncmp(name, PREFIX, sizeof(PREFIX) - 1) ||
+		    !name[sizeof(PREFIX) - 1]) {
+			tst_res(TFAIL, "counter '%s' is not a " PREFIX "<SOURCE> token",
+				name);
+			fails++;
+			continue;
+		}
+
+		if (value[strspn(value, "0123456789")]) {
+			tst_res(TFAIL, "counter '%s' has a non-numeric value '%s'",
+				name, value);
+			fails++;
+			continue;
+		}
+
+		parsed = strtoull(value, NULL, 10);
+
+		if (parsed > UINT32_MAX) {
+			tst_res(TFAIL, "counter '%s' value '%s' does not fit in u32",
+				name, value);
+			fails++;
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
+	int differs;
+
+	fails = 0;
+
+	tst_clock_gettime(CLOCK_MONOTONIC, &start);
+	read_snapshot(&first);
+
+	/*
+	 * The retry below re-reads the file until a counter moves, so a format
+	 * problem has to stop the test here rather than be reported again on
+	 * every retry, and the delta check has nothing to say about lines that
+	 * do not parse anyway.
+	 */
+	if (fails)
+		tst_brk(TFAIL, "%d malformed counter line(s), skipping the delta check",
+			fails);
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
