Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14483FCE095
	for <ltp@archiver.kernel.org>; Thu, 26 Feb 2026 14:32:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 737CE3CC043
	for <ltp@archiver.kernel.org>; Thu, 26 Feb 2026 15:32:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC32B3C5A13
 for <ltp@lists.linux.it>; Thu, 26 Feb 2026 15:32:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 03EE91400C6D
 for <ltp@lists.linux.it>; Thu, 26 Feb 2026 15:32:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772116355; x=1803652355;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6O0pcsZuvlvCSoD5kb3lN5LEwLhcq5g0/ivGByQxtok=;
 b=eMuxE12Rzi9jBNx/gKr+AjRpPj00l4vJ0vfVrxOjf4iNj3wPpmcEVjr9
 UcyFSDSA58wrGfEotEABksvtecjUD2SD89WWyk+ile1LkbWWfK/gBRLh0
 luhihSPlP0kuc3LFt5Dp1USbTfkPk5cpk0b1Hb8pskUyxHj5GYtai8jBK
 aIdmdSet7F0nYThU993xc2ER15cYMHG4uheT/kwlnE/xN/2NzjW1m7DwW
 nh+OyDkiUVVHlob5qeHDG3VNYB1W0AOQGDvUfulFQFbe9z4mX8tf3hfhg
 f3aoMWNSqZ93p5rJo2oZJJqJRSY+taDWh8m6YH40lY6LZbEMStMyrP+CA A==;
X-CSE-ConnectionGUID: 7P0Wl/8sSAuUV7KWwSh5gQ==
X-CSE-MsgGUID: zciyiogESdOQn/NHKlaa9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="75779442"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="75779442"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 06:32:27 -0800
X-CSE-ConnectionGUID: RnCNQ569SJi8h1dGD14UZw==
X-CSE-MsgGUID: //qe+etyS7i68q0gMK8E8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="214555380"
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.217.160.221])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 06:32:25 -0800
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Thu, 26 Feb 2026 15:31:36 +0100
Message-ID: <20260226143134.138506-3-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10] thermal: add new test group
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
Patch version 10 - addresses Cyril's feedback for v9.
 runtest/thermal                               |   3 +
 testcases/kernel/Makefile                     |   1 +
 testcases/kernel/thermal/.gitignore           |   1 +
 testcases/kernel/thermal/Makefile             |   9 +
 .../kernel/thermal/thermal_interrupt_events.c | 221 ++++++++++++++++++
 5 files changed, 235 insertions(+)
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
index 000000000..4657c3fb3
--- /dev/null
+++ b/testcases/kernel/thermal/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2025, Intel Corporation. All rights reserved.
+# Author:Piotr Kubaj <piotr.kubaj@intel.com>
+
+top_srcdir             ?= ../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/thermal/thermal_interrupt_events.c b/testcases/kernel/thermal/thermal_interrupt_events.c
new file mode 100644
index 000000000..2ac2168c3
--- /dev/null
+++ b/testcases/kernel/thermal/thermal_interrupt_events.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
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
+#include "tst_safe_stdio.h"
+#include "tst_test.h"
+#include "tst_timer_test.h"
+
+#define	RUNTIME		30
+#define	SLEEP		10
+#define	TEMP_INCREMENT	10
+
+static bool x86_pkg_temp_tz_found, *x86_pkg_temp_tz;
+static char temp_path[PATH_MAX], trip_path[PATH_MAX];
+static int nproc, temp_high, temp, trip, tz_counter;
+static uint64_t *interrupt_init, *interrupt_later;
+
+static void read_interrupts(uint64_t *interrupts, const int nproc)
+{
+	bool interrupts_found = false;
+	char line[8192];
+
+	memset(interrupts, 0, nproc * sizeof(*interrupts));
+	FILE *fp = SAFE_FOPEN("/proc/interrupts", "r");
+
+	while (fgets(line, sizeof(line), fp)) {
+		if (strstr(line, "Thermal event interrupts")) {
+			interrupts_found = true;
+			char *ptr = strchr(line, ':');
+
+			for (int i = 0; i < nproc; i++) {
+				char *endptr;
+
+				while (*ptr && !isdigit(*ptr))
+					ptr++;
+
+				errno = 0;
+
+				interrupts[i] = strtoull(ptr, &endptr, 10);
+
+				if (ptr == endptr)
+					tst_brk(TBROK, "interrupt not found");
+
+				if (errno == ERANGE)
+					tst_brk(TCONF, "interrupt out of range");
+
+				ptr = endptr;
+				tst_res(TDEBUG, "interrupts[%d]: %ld", i, interrupts[i]);
+			}
+			break;
+		}
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
+	tst_res(TDEBUG, "Number of logical cores: %d", nproc);
+	interrupt_init = calloc(nproc, sizeof(uint64_t));
+	interrupt_later = calloc(nproc, sizeof(uint64_t));
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
+	read_interrupts(interrupt_init, nproc);
+
+	x86_pkg_temp_tz = calloc(tz_counter, sizeof(bool));
+
+	for (int i = 0; i < tz_counter; i++) {
+		char path[PATH_MAX];
+
+		snprintf(path, PATH_MAX, "/sys/class/thermal/thermal_zone%d/type", i);
+		tst_res(TDEBUG, "Checking whether %s is x86_pkg_temp", path);
+
+		SAFE_FILE_SCANF(path, "%s", line);
+		if (strstr(line, "x86_pkg_temp")) {
+			tst_res(TDEBUG, "Thermal zone %d uses x86_pkg_temp", i);
+			x86_pkg_temp_tz[i] = 1;
+			x86_pkg_temp_tz_found = 1;
+		}
+	}
+
+	if (!x86_pkg_temp_tz_found)
+		tst_brk(TCONF, "No thermal zone uses x86_pkg_temp");
+}
+
+static void *cpu_workload(double run_time)
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
+	return NULL;
+}
+
+static void test_zone(int i)
+{
+	int sleep_time = SLEEP;
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
+	SAFE_FILE_SCANF(trip_path, "%d", &trip);
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
+
+}
+
+static void cleanup(void)
+{
+	if (x86_pkg_temp_tz_found)
+		SAFE_FILE_PRINTF(trip_path, "%d", trip);
+
+	free(x86_pkg_temp_tz);
+	free(interrupt_init);
+	free(interrupt_later);
+}
+
+static void run(void)
+{
+	for (int i = 0; i < tz_counter; i++) {
+		if (x86_pkg_temp_tz[i])
+			test_zone(i);
+	}
+	read_interrupts(interrupt_later, nproc);
+
+	for (int i = 0; i < nproc; i++) {
+		if (interrupt_later[i] < interrupt_init[i])
+			tst_res(TFAIL, "CPU %d interrupt counter: %ld (previous: %ld)",
+				i, interrupt_later[i], interrupt_init[i]);
+	}
+
+	if (temp <= temp_high)
+		tst_res(TFAIL, "Zone temperature is not rising as expected");
+	else
+		tst_res(TPASS, "x86 package thermal interrupt triggered");
+}
+
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.needs_drivers = (const char *const []) {
+		"x86_pkg_temp_thermal",
+		NULL
+	},
+	.min_runtime = 180,
+	.needs_root = 1,
+	.setup = setup,
+	.supported_archs = (const char *const []) {
+		"x86",
+		"x86_64",
+		NULL
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
