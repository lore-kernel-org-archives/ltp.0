Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF23E98E0F
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 10:02:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF01F3D0EB3
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 11:02:11 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BC2D3D0E9C
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 11:01:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 781EA1A00649
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 11:01:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771840909; x=1803376909;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tME6ZBD2Q1piq11ZcAv7GCYA5O0aVMgZj9JOrFJdhMs=;
 b=HWyZfOLfa1lWBj5S2fLUUH5cPM8aC01vBoDN6yO4mAaJCyIX5tp2Bv71
 J2evGRyRCZb2NkE4VgC1UYdtmqZIU189nu51w9QBQZ/6doARDNQM1ClS3
 Z18pvs2vvVwSw8IWwMk8EDenC9+bbRgTzQEWzcln9tNnXQRpAP0vh5AHe
 AmTXKpDXxIt6kv55th+V+HHe5S7YqS328wopcvNBls4K1suRdlT1LhZdX
 Vnclg7povemcPqvhCwi3wCzsvcATGKOmz2QctmVpRqgD847Sra4oyntrW
 nySAUo6hbfaTR6LHuFJVMVz30LpfGZfpa+hWl2X0qCypvX/VsHER0oOs/ A==;
X-CSE-ConnectionGUID: uq+qxpgGQRSBPah0YU24XA==
X-CSE-MsgGUID: x6i7TBSvSsKa7PkJvqLtBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="76662469"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; d="scan'208";a="76662469"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 02:01:42 -0800
X-CSE-ConnectionGUID: et9JgmXwRz6sg95n6xdoKQ==
X-CSE-MsgGUID: 7Ip0HEPJSCGW2sseNNcxXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; d="scan'208";a="215534735"
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.217.160.221])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 02:01:41 -0800
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Mon, 23 Feb 2026 11:00:16 +0100
Message-ID: <20260223100015.14834-2-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8] thermal: add new test group
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
Patch version 8
 runtest/thermal                               |   3 +
 scenario_groups/default                       |   1 +
 testcases/kernel/Makefile                     |   1 +
 testcases/kernel/thermal/.gitignore           |   1 +
 testcases/kernel/thermal/Makefile             |   9 +
 .../kernel/thermal/thermal_interrupt_events.c | 212 ++++++++++++++++++
 6 files changed, 227 insertions(+)
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
diff --git a/scenario_groups/default b/scenario_groups/default
index 0e76b2bee..ffdd7ff25 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -26,3 +26,4 @@ crypto
 kernel_misc
 uevent
 watchqueue
+thermal
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
index 000000000..7a241cb51
--- /dev/null
+++ b/testcases/kernel/thermal/thermal_interrupt_events.c
@@ -0,0 +1,212 @@
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
+#include "tst_safe_stdio.h"
+#include "tst_test.h"
+
+#define	RUNTIME		30
+#define	SLEEP		10
+#define	TEMP_INCREMENT	10
+
+static bool x86_pkg_temp_tz_found, *x86_pkg_temp_tz;
+static char temp_path[NAME_MAX], trip_path[NAME_MAX];
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
+			char *token = strtok(line, " ");
+
+			token = strtok(NULL, " ");
+			int i = 0;
+
+			while (!!strncmp(token, "Thermal", 7)) {
+				interrupts[i++] = atoll(token);
+				token = strtok(NULL, " ");
+				tst_res(TDEBUG, "interrupts[%d]: %ld", i - 1, interrupts[i - 1]);
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
+		if ((strncmp(entry->d_name, "thermal_zone", sizeof("thermal_zone"))) > 0)
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
+		char path[NAME_MAX];
+
+		snprintf(path, NAME_MAX, "/sys/class/thermal/thermal_zone%d/type", i);
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
+	time_t start_time = time(NULL);
+	int num = 2;
+
+	while (difftime(time(NULL), start_time) < run_time) {
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
+	char path[NAME_MAX] = {0};
+	int sleep_time = SLEEP;
+	double run_time = RUNTIME;
+
+	snprintf(path, NAME_MAX, "/sys/class/thermal/thermal_zone%d/", i);
+	strncpy(temp_path, path, NAME_MAX);
+	strncat(temp_path, "temp", 4);
+	tst_res(TINFO, "Testing %s", temp_path);
+	SAFE_FILE_SCANF(temp_path, "%d", &temp);
+	if (temp < 0)
+		tst_brk(TBROK, "Unexpected zone temperature value %d", temp);
+
+	tst_res(TDEBUG, "Current temperature for %s: %d", path, temp);
+
+	temp_high = temp + TEMP_INCREMENT;
+
+	strncpy(trip_path, path, NAME_MAX);
+	strncat(trip_path, "trip_point_1_temp", 17);
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
+		tst_res(TDEBUG, "Temperature for %s after a test: %d", path, temp);
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
