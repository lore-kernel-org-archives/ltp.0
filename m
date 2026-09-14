Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DACC88E6A
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 09:26:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FBDE3E239C
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 11:26:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88B503E239C
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 11:25:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2EA2F1400BE0
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 11:25:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789377937; x=1820913937;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ptBwcpIDMNHZklDu7fDeUGanqOnw8TZ2iBKNGYkzlpA=;
 b=Z6c8DzMmLROFmbRlDikyI4DfXSvMCek1zmJcshq4BCsnxoJC4vURIwg2
 WRxvVqQqrobU5QXJwChuInTIUP6nfPcj6ujoE4NXiZIMmjHcsNB/pFGzm
 lf5F4GmOnfapugPK2/wgJkUmV1qpPhb17isM04rQAjQYX2uDi/+rphYXO
 cQc87dGsCqsFzC5szXeTXU0GzzAMcMN9qoRMWGCRWz72xBXoUZn5AiTU7
 QgmYREfQCY37Lsv8Pf9Mwj1yWnuM8sv8A1lal+Rrx6Yd2fAvCzyUPAmEe
 qHbtcuqdCr572/pxcyABSnh/CBASkbKCm/gWkFlLGUF4X0bVNf/QQKyik w==;
X-CSE-ConnectionGUID: c7c3DXF/T2apO8xeLPW0Ew==
X-CSE-MsgGUID: YFNGhzxcRvaHToy289bY2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="89769803"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="89769803"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 02:25:35 -0700
X-CSE-ConnectionGUID: RfSfUTIjSe20Etiu+Sdagg==
X-CSE-MsgGUID: LR1Nt0vBS/K8tGwCr3s1dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="276750145"
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.237.142.111])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 02:25:33 -0700
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Mon, 14 Sep 2026 11:25:16 +0200
Message-ID: <20260914092517.879141-4-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914092517.879141-1-piotr.kubaj@intel.com>
References: <20260914092517.879141-1-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/3] pmc_core: add ltr_counter test
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

Add a test for the invariant behind the pkgc_ltr_blocker_show counters:
they only advance while a package C-state entry can be attempted, which
needs every CPU in the package to be idle. A counter that keeps advancing
with every CPU busy is not counting blocked package C-state entries,
which is what a telemetry region read at the wrong offset looks like.

The test first lets the system idle until it sees a counter advance, so
that a counter stuck at a constant value cannot pass the load phase for
free, and then pins a busy loop to every CPU it may run on and requires
the counters to hold still.

The counters are backed by a PMT telemetry region that the PMC refreshes
asynchronously and in bursts - roughly six seconds apart on Nova Lake -
so the load phase waits for the counters to go quiet rather than sampling
them after a fixed delay. Entries blocked before the load took hold
surface in a later refresh, while a counter that is not tracking blocked
entries never goes quiet at all and runs the window out.

Tested on Nova Lake running 7.3.0-rc1.

Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
---
 runtest/power_management_tests                |   1 +
 testcases/kernel/power_management/.gitignore  |   1 +
 .../kernel/power_management/ltr_counter.c     | 356 ++++++++++++++++++
 3 files changed, 358 insertions(+)
 create mode 100644 testcases/kernel/power_management/ltr_counter.c

diff --git a/runtest/power_management_tests b/runtest/power_management_tests
index 7708d3fd4..c4f661257 100644
--- a/runtest/power_management_tests
+++ b/runtest/power_management_tests
@@ -3,6 +3,7 @@ cpufreq_intel cpufreq_intel
 rfim01 rfim01
 high_freq_hwp_cap_cppc high_freq_hwp_cap_cppc
 pkgc_ltr_blocker_show pkgc_ltr_blocker_show
+ltr_counter ltr_counter
 runpwtests03 runpwtests03.sh
 runpwtests04 runpwtests04.sh
 runpwtests06 runpwtests06.sh
diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
index b96084eca..f54cec368 100644
--- a/testcases/kernel/power_management/.gitignore
+++ b/testcases/kernel/power_management/.gitignore
@@ -2,3 +2,4 @@ high_freq_hwp_cap_cppc
 cpufreq_intel
 rfim01
 pkgc_ltr_blocker_show
+ltr_counter
diff --git a/testcases/kernel/power_management/ltr_counter.c b/testcases/kernel/power_management/ltr_counter.c
new file mode 100644
index 000000000..010285374
--- /dev/null
+++ b/testcases/kernel/power_management/ltr_counter.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2026 Intel - http://www.intel.com/
+ */
+
+/*\
+ * Verify that the package C-state LTR blocker counters only advance while a
+ * package C-state entry can be attempted.
+ *
+ * The pkgc_ltr_blocker_show debugfs file reports, per source, how many times an
+ * LTR posted by that source blocked a package C-state entry. Such an entry is
+ * only attempted once every CPU in the package has gone idle, so a workload
+ * that keeps every CPU busy has to stop the counters. A counter that keeps
+ * advancing under full load is not counting blocked package C-state entries,
+ * which is what a telemetry region read at the wrong offset looks like.
+ *
+ * The test first lets the system idle until it sees a counter advance, so that
+ * a counter stuck at a constant value cannot pass the load phase for free. It
+ * then pins a busy loop to every CPU and requires the counters to hold still.
+ *
+ * The counters are backed by a PMT telemetry region that the PMC refreshes
+ * asynchronously and in bursts - roughly six seconds apart on Nova Lake - so
+ * the load phase waits for the counters to go quiet rather than sampling them
+ * after a fixed delay. Entries blocked before the load took hold surface in a
+ * later refresh, while a counter that is not tracking blocked entries never
+ * goes quiet at all and runs the window out.
+ *
+ * The test needs root because /sys/kernel/debug is mode 0700 and owned by
+ * root, so the counter file cannot be opened otherwise, and because the test
+ * library mounts debugfs if it is not mounted already.
+ */
+
+#define _GNU_SOURCE
+
+#include <time.h>
+#include "tst_clocks.h"
+#include "tst_safe_stdio.h"
+#include "tst_test.h"
+#include "tst_timer.h"
+
+#define PATH TST_DEBUGFS_PATH "/pmc_core/pkgc_ltr_blocker_show"
+
+/* Nova Lake reports 5 counters, leave room for future platforms */
+#define MAX_COUNTERS 64
+#define NAME_LEN 64
+
+#define POLL_MS 500
+
+/*
+ * Seconds to wait for a counter to advance while the system idles. The bursts
+ * are about six seconds apart on Nova Lake, so this leaves room for two of
+ * them before giving up on the platform blocking a package C-state entry at
+ * all.
+ */
+#define IDLE_WINDOW 15
+
+/*
+ * How long, in seconds, the counters have to hold still under load, and the cap
+ * on how long to wait for that. One burst period of silence is what tells a
+ * stopped counter from one that is merely between refreshes, and the cap has to
+ * be long enough on top of that for a burst counted before the load took hold
+ * to arrive and drain.
+ */
+#define QUIET_WINDOW 6
+#define LOAD_WINDOW 20
+
+static char names[MAX_COUNTERS][NAME_LEN];
+static int cnt;
+static pid_t *spinners;
+static int nr_spinners;
+static volatile unsigned long long burn;
+
+/*
+ * Read the counter values, checking that the counter set itself has not changed
+ * since setup(). Only the values are of interest here - the format of the file
+ * is what the pkgc_ltr_blocker_show test covers - so anything unexpected about
+ * the lines makes this test unable to run rather than failing it.
+ */
+static void read_counters(uint32_t *values)
+{
+	char line[256];
+	FILE *fp;
+	int n = 0;
+
+	fp = SAFE_FOPEN(PATH, "r");
+
+	while (fgets(line, sizeof(line), fp)) {
+		char name[NAME_LEN];
+		unsigned int value;
+
+		line[strcspn(line, "\n")] = '\0';
+
+		if (n == MAX_COUNTERS)
+			tst_brk(TBROK, "more than %d counters reported", MAX_COUNTERS);
+
+		if (sscanf(line, "%63s %u", name, &value) != 2)
+			tst_brk(TBROK, "unexpected line format: '%s'", line);
+
+		values[n] = value;
+
+		if (cnt && strcmp(name, names[n])) {
+			tst_brk(TBROK, "counter %d renamed during the test: %s -> %s",
+				n, names[n], name);
+		}
+
+		if (!cnt)
+			strcpy(names[n], name);
+
+		n++;
+	}
+
+	/*
+	 * A telemetry read that fails in the driver aborts the seq_file read
+	 * instead of ending it at EOF, so without this the counters lost to the
+	 * error would look like counters that stopped advancing.
+	 */
+	if (ferror(fp))
+		tst_brk(TBROK, "reading " PATH " failed after %d counters", n);
+
+	SAFE_FCLOSE(fp);
+
+	if (cnt && n != cnt)
+		tst_brk(TBROK, "counter count changed during the test: %d -> %d", cnt, n);
+
+	cnt = n;
+}
+
+static void spin(void)
+{
+	/* volatile so that the loop survives optimization */
+	for (;;)
+		burn++;
+}
+
+/*
+ * Keep every CPU the test may run on busy, so that the package cannot go idle
+ * and no package C-state entry can be attempted.
+ *
+ * The spinners are pinned one per CPU taken from the test's own affinity mask,
+ * rather than left to the load balancer, so that a CPU is not left idle by a
+ * scheduling decision. Offline CPUs and a restricted mask are handled by
+ * construction.
+ */
+static void start_load(void)
+{
+	cpu_set_t mask;
+	int cpu = 0;
+
+	if (sched_getaffinity(0, sizeof(mask), &mask))
+		tst_brk(TBROK | TERRNO, "sched_getaffinity() failed");
+
+	nr_spinners = CPU_COUNT(&mask);
+	spinners = SAFE_MALLOC(nr_spinners * sizeof(*spinners));
+
+	for (int i = 0; i < nr_spinners; i++) {
+		pid_t pid;
+
+		while (!CPU_ISSET(cpu, &mask))
+			cpu++;
+
+		pid = SAFE_FORK();
+
+		if (!pid) {
+			cpu_set_t one;
+
+			CPU_ZERO(&one);
+			CPU_SET(cpu, &one);
+
+			if (sched_setaffinity(0, sizeof(one), &one)) {
+				tst_brk(TBROK | TERRNO,
+					"sched_setaffinity(CPU %d) failed", cpu);
+			}
+
+			spin();
+		}
+
+		spinners[i] = pid;
+		cpu++;
+	}
+
+	tst_res(TINFO, "keeping %d CPUs busy", nr_spinners);
+}
+
+static void stop_load(void)
+{
+	if (!spinners)
+		return;
+
+	for (int i = 0; i < nr_spinners; i++) {
+		SAFE_KILL(spinners[i], SIGKILL);
+		SAFE_WAITPID(spinners[i], NULL, 0);
+	}
+
+	free(spinners);
+	spinners = NULL;
+}
+
+/*
+ * Wait for a counter to advance while the system idles, reporting how many did.
+ *
+ * This is what tells a counter that stops under load from one that never moves.
+ * On an idle system most counters read 0 permanently, because nothing posts an
+ * LTR that would block a package C-state entry, so a single counter advancing
+ * is enough.
+ */
+static int wait_for_advance(const uint32_t *baseline)
+{
+	uint32_t values[MAX_COUNTERS];
+	struct timespec start, now;
+	int advanced = 0;
+
+	tst_clock_gettime(CLOCK_MONOTONIC, &start);
+
+	for (;;) {
+		read_counters(values);
+
+		for (int i = 0; i < cnt; i++) {
+			if (values[i] == baseline[i])
+				continue;
+
+			tst_res(TINFO, "%s advanced by %u while idle", names[i],
+				values[i] - baseline[i]);
+			advanced++;
+		}
+
+		if (advanced)
+			return advanced;
+
+		tst_clock_gettime(CLOCK_MONOTONIC, &now);
+
+		if (tst_timespec_diff_ms(now, start) >= IDLE_WINDOW * 1000)
+			return 0;
+
+		usleep(POLL_MS * 1000);
+	}
+}
+
+/*
+ * Require the counters to hold still for QUIET_WINDOW seconds of full load.
+ */
+static void check_counters_stop(void)
+{
+	uint32_t first[MAX_COUNTERS], prev[MAX_COUNTERS], values[MAX_COUNTERS];
+	bool moved[MAX_COUNTERS] = {};
+	struct timespec start, last_change, now;
+
+	read_counters(first);
+	memcpy(prev, first, sizeof(prev));
+
+	tst_clock_gettime(CLOCK_MONOTONIC, &start);
+	last_change = start;
+
+	for (;;) {
+		usleep(POLL_MS * 1000);
+
+		read_counters(values);
+		tst_clock_gettime(CLOCK_MONOTONIC, &now);
+
+		for (int i = 0; i < cnt; i++) {
+			if (values[i] == prev[i])
+				continue;
+
+			moved[i] = true;
+			last_change = now;
+		}
+
+		memcpy(prev, values, sizeof(prev));
+
+		if (tst_timespec_diff_ms(now, last_change) >= QUIET_WINDOW * 1000) {
+			tst_res(TPASS,
+				"%d counters held still over %ds with every CPU busy",
+				cnt, QUIET_WINDOW);
+			return;
+		}
+
+		if (tst_timespec_diff_ms(now, start) < LOAD_WINDOW * 1000)
+			continue;
+
+		for (int i = 0; i < cnt; i++) {
+			if (!moved[i])
+				continue;
+
+			tst_res(TFAIL,
+				"%s kept advancing over %ds with every CPU busy: %u -> %u",
+				names[i], LOAD_WINDOW, first[i], values[i]);
+		}
+
+		return;
+	}
+}
+
+static void setup(void)
+{
+	uint32_t values[MAX_COUNTERS];
+
+	if (access(PATH, R_OK))
+		tst_brk(TCONF | TERRNO, "%s not available", PATH);
+
+	/* Learns the counter set the rest of the test compares against */
+	read_counters(values);
+
+	if (!cnt)
+		tst_brk(TBROK, "no LTR blocker counters reported");
+}
+
+static void cleanup(void)
+{
+	stop_load();
+}
+
+static void run(void)
+{
+	uint32_t baseline[MAX_COUNTERS];
+
+	read_counters(baseline);
+
+	/*
+	 * Without a counter that moves while idle there is nothing to stop
+	 * under load, a stuck counter would look exactly the same.
+	 */
+	if (!wait_for_advance(baseline)) {
+		tst_brk(TCONF,
+			"no LTR blocked a package C-state entry over %ds of idling",
+			IDLE_WINDOW);
+	}
+
+	start_load();
+	check_counters_stop();
+	stop_load();
+}
+
+static struct tst_test test = {
+	.min_kver = "7.2",
+	.timeout = 90,
+	.needs_root = 1,
+	.needs_debugfs = 1,
+	.forks_child = 1,
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
