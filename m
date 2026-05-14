Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60999CD4F25
	for <ltp@archiver.kernel.org>; Thu, 14 May 2026 09:37:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD63F3E0DE7
	for <ltp@archiver.kernel.org>; Thu, 14 May 2026 11:37:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B58D93D56E0
 for <ltp@lists.linux.it>; Thu, 14 May 2026 11:37:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 89FCA100098B
 for <ltp@lists.linux.it>; Thu, 14 May 2026 11:37:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778751453; x=1810287453;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0cZ6hE7d/YJeH7/Zy5FWi6FaP2f6vsfgih3D/H9c2G8=;
 b=WzYhrZemsibAHNH51/bJ+MT4pn2ZEgjeva8QfegXgD/hsL0b24UbCoht
 6OqaFIBibywnyMO2PXyDtTcyCLrjsVIT8sVu6qGry/D+wE9kpT0BjrE/o
 Cox0c9UYvr0whnhOpvcU2zXHtMZeyd/P51kZPwM62efaHlLTRc6xMhtFO
 pKHXUR+X83sPZV81t2qn1nH2b5OjQNhvpPBWzmYPNXzQ2I/j9d5NjDKtX
 J0PQzVbch7857D9YiDGfC7a6RNwJ5DovSIPwf20t1NdYBUpG7PrTGkyxW
 sibJxgEzvSYqxxtAnF13G7nfn/71cvQdRRWizZ3PX+InocvLV7j0K6fFQ w==;
X-CSE-ConnectionGUID: dkjMQdc3RFqrNk68UbsexQ==
X-CSE-MsgGUID: DiNQ1MObQ1SCct0QbDKg2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79549483"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="79549483"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 02:37:30 -0700
X-CSE-ConnectionGUID: gdL4MjCdTleiuRftmkWDJg==
X-CSE-MsgGUID: uNZfoUycTbqlKB5kOY7FmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="243313242"
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.217.160.221])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 02:37:28 -0700
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Thu, 14 May 2026 11:36:50 +0200
Message-ID: <20260514093649.125287-2-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v20] thermal: add new test group
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

Currently consists of only one test for the CPU package thermal sensor
interface for Intel platforms.
It works by checking the initial count of thermal interrupts. Then it
decreases the threshold for sending a thermal interrupt to just above
the current temperature and runs a workload on the CPU. Finally, it
restores the original thermal threshold and checks whether the number
of thermal interrupts increased.

Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
---
Add 300s cooldown between runs to ensure -i $NUM runs pass.
 runtest/thermal                               |   3 +
 testcases/kernel/Makefile                     |   1 +
 testcases/kernel/thermal/.gitignore           |   1 +
 testcases/kernel/thermal/Makefile             |   9 +
 .../kernel/thermal/thermal_interrupt_events.c | 253 ++++++++++++++++++
 5 files changed, 267 insertions(+)
 create mode 100644 runtest/thermal
 create mode 100644 testcases/kernel/thermal/.gitignore
 create mode 100644 testcases/kernel/thermal/Makefile
 create mode 100644 testcases/kernel/thermal/thermal_interrupt_events.c

diff --git a/runtest/thermal b/runtest/thermal
new file mode 100644
index 000000000..57e3d29f8
--- /dev/null
+++ b/runtest/thermal
@@ -0,0 +1,3 @@
+# Thermal driver API
+# https://docs.kernel.org/driver-api/thermal/
+thermal_interrupt_events thermal_interrupt_events
diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index 98fd45a9d..ac816e4e8 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -36,6 +36,7 @@ SUBDIRS			+= connectors \
 			   sched \
 			   security \
 			   sound \
+			   thermal \
 			   tracing \
 			   uevents \
 			   watchqueue \
diff --git a/testcases/kernel/thermal/.gitignore b/testcases/kernel/thermal/.gitignore
new file mode 100644
index 000000000..1090bdad8
--- /dev/null
+++ b/testcases/kernel/thermal/.gitignore
@@ -0,0 +1 @@
+thermal_interrupt_events
diff --git a/testcases/kernel/thermal/Makefile b/testcases/kernel/thermal/Makefile
new file mode 100644
index 000000000..eda3a64f1
--- /dev/null
+++ b/testcases/kernel/thermal/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026, Intel Corporation. All rights reserved.
+# Author:Piotr Kubaj <piotr.kubaj@intel.com>
+
+top_srcdir             ?= ../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/thermal/thermal_interrupt_events.c b/testcases/kernel/thermal/thermal_interrupt_events.c
new file mode 100644
index 000000000..b28218031
--- /dev/null
+++ b/testcases/kernel/thermal/thermal_interrupt_events.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Intel - http://www.intel.com/
+ */
+
+/*\
+ * Tests the CPU package thermal sensor interface for Intel platforms.
+
+ * Works by checking the initial count of thermal interrupts. Then it
+ * decreases the threshold for sending a thermal interrupt to just above
+ * the current temperature and runs a workload on the CPU. Finally, it restores
+ * the original thermal threshold and checks whether the number of thermal
+ * interrupts increased.
+ */
+
+#include <ctype.h>
+#include <inttypes.h>
+#include "tst_safe_stdio.h"
+#include "tst_test.h"
+#include "tst_timer_test.h"
+
+#define	TEST_RUNTIME	((RUNTIME + SLEEPTIME) * (SLEEPTIME / 2) + COOLDOWN)
+#define	RUNTIME		30
+#define	SLEEPTIME	10
+#define	COOLDOWN	300
+#define	TEMP_INCREMENT	10
+
+static bool *x86_pkg_temp_tz;
+static char temp_path[PATH_MAX], trip_path[PATH_MAX];
+static int x86_pkg_temp_tz_found, nproc, temp_high, temp, *trip_orig, tz_counter;
+static uint64_t *interrupt_init, *interrupt_later;
+
+static void read_interrupts(uint64_t *interrupts)
+{
+	bool interrupts_found = false;
+	char line[8192];
+
+	memset(interrupts, 0, nproc * sizeof(*interrupts));
+	FILE *fp = SAFE_FOPEN("/proc/interrupts", "r");
+
+	while (fgets(line, sizeof(line), fp)) {
+		if (!strstr(line, "Thermal event interrupts"))
+			continue;
+
+		interrupts_found = true;
+		char *ptr = strchr(line, ':');
+
+		for (int i = 0; i < nproc; i++) {
+			char *endptr;
+
+			while (*ptr && !isdigit(*ptr))
+				ptr++;
+
+			errno = 0;
+
+			interrupts[i] = strtoull(ptr, &endptr, 10);
+
+			if (ptr == endptr)
+				tst_brk(TBROK, "CPU %d: interrupt not found", i);
+
+			if (errno == ERANGE)
+				tst_brk(TBROK, "CPU %d: interrupt out of range", i);
+
+			ptr = endptr;
+			tst_res(TDEBUG, "interrupts[%d]: %" PRIu64, i, interrupts[i]);
+		}
+		break;
+	}
+	SAFE_FCLOSE(fp);
+	if (!interrupts_found)
+		tst_brk(TCONF, "No Thermal event interrupts line in /proc/interrupts");
+}
+
+static void setup(void)
+{
+	char line[8192];
+
+	nproc = tst_ncpus();
+
+	tst_res(TDEBUG, "Number of logical cores: %d", nproc);
+	interrupt_init = SAFE_CALLOC(nproc, sizeof(uint64_t));
+	interrupt_later = SAFE_CALLOC(nproc, sizeof(uint64_t));
+
+	DIR *dir = SAFE_OPENDIR("/sys/class/thermal/");
+	struct dirent *entry;
+
+	while ((entry = SAFE_READDIR(dir))) {
+		if ((!strncmp(entry->d_name, "thermal_zone", sizeof("thermal_zone") - 1)))
+			tz_counter++;
+	}
+	SAFE_CLOSEDIR(dir);
+	tst_res(TDEBUG, "Found %d thermal zone(s)", tz_counter);
+
+	x86_pkg_temp_tz = SAFE_CALLOC(tz_counter, sizeof(bool));
+	trip_orig = SAFE_CALLOC(tz_counter, sizeof(int));
+
+	for (int i = 0; i < tz_counter; i++) {
+		char path[PATH_MAX];
+
+		snprintf(path, PATH_MAX, "/sys/class/thermal/thermal_zone%d/type", i);
+		tst_res(TDEBUG, "Checking whether %s is x86_pkg_temp", path);
+
+		SAFE_FILE_SCANF(path, "%8191s", line);
+		if (strstr(line, "x86_pkg_temp")) {
+			tst_res(TDEBUG, "Thermal zone %d uses x86_pkg_temp", i);
+			x86_pkg_temp_tz[i] = true;
+			x86_pkg_temp_tz_found++;
+			snprintf(trip_path, PATH_MAX, "/sys/class/thermal/thermal_zone%d/trip_point_1_temp", i);
+			SAFE_ACCESS(trip_path, R_OK | W_OK);
+			SAFE_FILE_SCANF(trip_path, "%d", &trip_orig[i]);
+		}
+	}
+
+	if (!x86_pkg_temp_tz_found)
+		tst_brk(TCONF, "No thermal zone uses x86_pkg_temp");
+
+	tst_set_runtime(x86_pkg_temp_tz_found * TEST_RUNTIME);
+}
+
+static void cpu_workload(double run_time)
+{
+	tst_timer_start(CLOCK_MONOTONIC);
+	int num = 2;
+
+	while (!tst_timer_expired_ms(run_time * 1000)) {
+		for (int i = 2; i * i <= num; i++) {
+			if (num % i == 0)
+				break;
+		}
+		num++;
+		SAFE_FILE_SCANF(temp_path, "%d", &temp);
+
+		if (temp > temp_high)
+			break;
+	}
+}
+
+static void test_zone(int i)
+{
+	int sleep_time = SLEEPTIME;
+	double run_time = RUNTIME;
+
+	snprintf(temp_path, PATH_MAX, "/sys/class/thermal/thermal_zone%d/temp", i);
+	tst_res(TINFO, "Testing %s", temp_path);
+	SAFE_FILE_SCANF(temp_path, "%d", &temp);
+	if (temp < 0)
+		tst_brk(TBROK, "Unexpected zone temperature value %d", temp);
+
+	tst_res(TDEBUG, "Current temperature for %s: %d", temp_path, temp);
+
+	temp_high = temp + TEMP_INCREMENT;
+
+	snprintf(trip_path, PATH_MAX, "/sys/class/thermal/thermal_zone%d/trip_point_1_temp", i);
+
+	tst_res(TDEBUG, "Setting new trip_point_1_temp value: %d", temp_high);
+	SAFE_FILE_PRINTF(trip_path, "%d", temp_high);
+
+	while (sleep_time > 0) {
+		tst_res(TDEBUG, "Running for %f seconds, then sleeping for %d seconds", run_time, sleep_time);
+
+		for (int j = 0; j < nproc; j++) {
+			if (!SAFE_FORK()) {
+				cpu_workload(run_time);
+				exit(0);
+			}
+		}
+
+		tst_reap_children();
+
+		SAFE_FILE_SCANF(temp_path, "%d", &temp);
+		tst_res(TDEBUG, "Temperature for %s after a test: %d", temp_path, temp);
+
+		if (temp > temp_high)
+			break;
+		sleep(sleep_time--);
+		run_time -= 3;
+	}
+}
+
+static void cleanup(void)
+{
+	if (x86_pkg_temp_tz_found) {
+		for (int i = 0; i < tz_counter; i++) {
+			if (x86_pkg_temp_tz[i]) {
+				snprintf(trip_path, PATH_MAX, "/sys/class/thermal/thermal_zone%d/trip_point_1_temp", i);
+				SAFE_FILE_PRINTF(trip_path, "%d", trip_orig[i]);
+			}
+		}
+	}
+
+	free(x86_pkg_temp_tz);
+	free(interrupt_init);
+	free(interrupt_later);
+	free(trip_orig);
+}
+
+static void run(void)
+{
+	static bool first_zone = true;
+
+	for (int i = 0; i < tz_counter; i++) {
+		if (x86_pkg_temp_tz[i]) {
+			if (!first_zone) {
+				tst_res(TINFO, "Cooling down for %d seconds", COOLDOWN);
+				sleep(COOLDOWN);
+			}
+			first_zone = false;
+
+			read_interrupts(interrupt_init);
+			test_zone(i);
+			read_interrupts(interrupt_later);
+
+			bool interrupt_increased = false;
+
+			for (int j = 0; j < nproc; j++) {
+				if (interrupt_later[j] > interrupt_init[j]) {
+					interrupt_increased = true;
+					tst_res(TINFO, "CPU %d interrupt counter: %" PRIu64 " (previous: %" PRIu64 ")",
+						j, interrupt_later[j], interrupt_init[j]);
+				}
+			}
+
+			if (!interrupt_increased)
+				tst_res(TFAIL, "No thermal interrupt increase detected");
+			else if (temp <= temp_high)
+				tst_res(TFAIL, "Thermal interrupts increased but temperature did not rise as expected");
+			else
+				tst_res(TPASS, "x86 package thermal interrupt triggered");
+		}
+	}
+}
+
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_X86_PKG_TEMP_THERMAL",
+		NULL
+	},
+	.min_runtime = 5,
+	.needs_root = 1,
+	.setup = setup,
+	.supported_archs = (const char *const []) {
+		"x86",
+		"x86_64",
+		NULL
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "9635c586a559ba0e45b2bfbff79c937ddbaf1a62"},
+		{}
+	},
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
