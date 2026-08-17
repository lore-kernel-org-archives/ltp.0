Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4544C5B572
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 06:42:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 895DB3C9ED1
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 08:42:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8812B3C2808
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 08:41:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 57989140020E
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 08:41:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786948909; x=1818484909;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=SoiMBhx8qToqaWjEDZS3gdKMvwr5/0KV8B+FvwaBBG8=;
 b=Jk3/pTkxycIRHqzQF02HaG0mDrcyXrQ5sRCBFrUg6+pQXhlJXbi428/U
 CBbH6/ho8GNfVhbalQJbb3uQ8+ZcmRsq8cNPjrh4wnWDofjJuUSVXah81
 xFCHHgWkje43NZoxsgOaNHIprYmsqHego3jfkDjv0wFKBYkHqoGc/Py9Y
 yNVgVRnThER4ej/7XCqpowkwc/LHmb2/NPYmQoZf29lMpA40/AS0OFbxX
 S78NHC8Exl3mhZ3q9zu1hXsLCTS8xV/6r9hn5qPOpoZVOSeKDPlCBa8h5
 rknzbXJL09cRFNY31HyA1BAWH3loMWfSnaigjYo9Ti1Fz+dBDiP8+NeFq Q==;
X-CSE-ConnectionGUID: Fpf0ALyNTNO2nmpHoC68ow==
X-CSE-MsgGUID: AtV/1o3oR6KgJ/pplUDfpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87337606"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="87337606"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2026 23:41:44 -0700
X-CSE-ConnectionGUID: 4vKBZjXGT5aGGrcUzbIoNw==
X-CSE-MsgGUID: rKBHvQgYQaGdJWtWJPfY4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="263492209"
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.237.142.111])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2026 23:41:42 -0700
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Mon, 17 Aug 2026 08:40:53 +0200
Message-ID: <20260817064052.304786-2-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] pmc_core: add test for pkgc_blocker_residency_show
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

Add coverage for the pkgc_blocker_residency_show debugfs file added in
kernel commit d727eb1c3ede ("platform/x86/intel/pmc: Enable Pkgc blocking
residency counter") and first released in v7.2. The counters report which
sources kept the platform out of package C-states, and so far nothing
checked that the driver exports them correctly.

The counter set is platform specific, so instead of a hardcoded list of
names the test checks the format of every line and the rate at which the
counters advance.

The mount point exists whether or not debugfs is mounted on it, so the test
mounts debugfs when needed, and unmounts it again only if it did the mount.

Tested on Nova Lake running 7.2.0-rc7.

Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
---
1. Shortened commit message.
2. Added debugfs-related checks.
 include/tst_fs.h                              |   1 +
 runtest/power_management_tests                |   1 +
 testcases/kernel/power_management/.gitignore  |   1 +
 .../pkgc_blocker_residency_show.c             | 296 ++++++++++++++++++
 4 files changed, 299 insertions(+)
 create mode 100644 testcases/kernel/power_management/pkgc_blocker_residency_show.c

diff --git a/include/tst_fs.h b/include/tst_fs.h
index c55f8a646..be143a4ef 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -8,6 +8,7 @@
 
 /* man 2 statfs or kernel-source/include/uapi/linux/magic.h */
 #define TST_BTRFS_MAGIC    0x9123683E
+#define TST_DEBUGFS_MAGIC  0x64626720
 #define TST_NFS_MAGIC      0x6969
 #define TST_RAMFS_MAGIC    0x858458f6
 #define TST_TMPFS_MAGIC    0x01021994
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
index 000000000..d4cdb9a68
--- /dev/null
+++ b/testcases/kernel/power_management/pkgc_blocker_residency_show.c
@@ -0,0 +1,296 @@
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
+ * root, so the counter file cannot be opened otherwise, and because debugfs is
+ * mounted if it is not mounted already.
+ */
+
+#include <sys/mount.h>
+#include <time.h>
+#include "tst_clocks.h"
+#include "tst_fs.h"
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
+static bool mounted_debugfs;
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
+	struct statfs sfs;
+
+	/*
+	 * DEBUGFS exists as a sysfs mount point whenever CONFIG_DEBUG_FS is
+	 * set, whether or not debugfs is mounted on it, so the filesystem type
+	 * has to be checked rather than the directory being present. Otherwise
+	 * a platform that does export the counters looks unsupported.
+	 */
+	if (statfs(DEBUGFS, &sfs))
+		tst_brk(TCONF | TERRNO, "cannot statfs " DEBUGFS);
+
+	if (sfs.f_type != TST_DEBUGFS_MAGIC) {
+		if (mount("debugfs", DEBUGFS, "debugfs", 0, NULL))
+			tst_brk(TCONF | TERRNO, "cannot mount debugfs at " DEBUGFS);
+
+		tst_res(TINFO, "mounted debugfs at " DEBUGFS);
+		mounted_debugfs = true;
+	}
+
+	if (access(PATH, R_OK))
+		tst_brk(TCONF | TERRNO, "%s not available", PATH);
+}
+
+static void cleanup(void)
+{
+	if (mounted_debugfs)
+		SAFE_UMOUNT(DEBUGFS);
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
+	.cleanup = cleanup,
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
