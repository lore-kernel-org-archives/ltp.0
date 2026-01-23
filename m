Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E0CD74EC1
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 12:51:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 167DE3CB886
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 13:51:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 664103C0E0A
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 13:50:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A23731000DAC
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 13:50:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769172651; x=1800708651;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xYDb52f+tO2n3Y0EOzvWzT+y/YGxsozM1umj3Gi8vwQ=;
 b=JQBzZlcQzUFsKX/+2hT44uxXUP4UCWIvUIIELR8vfpMWH1e6IuD5CEzx
 +1CSJOn9fPdbYfubCkdsqY19PGlP0C+0z6J2hAn0SyPJReUKlhjCBqTCZ
 0Y0wdgba4RohjOEQqOt6ypTfjkC7gvN9YWWDszgIXlnmyudjHtYEZOnXD
 oN4RkLZ5fQ50/JLSBn1jOHDKxXTOOVP9ato9ipjYowaj4gYcylUEpIzXN
 W6c0up7jNS/ukaAvp02wHscc4xCr7Shez5pkBUiHIwgVPyiVBVYzdFmFr
 MBAYSwEvoB8RENiYFNCclnIv2liMuDpbEKJjrII1JbbPSawaL0YLUN294 A==;
X-CSE-ConnectionGUID: o2d0t3zdTkmFzvz+lTrcSQ==
X-CSE-MsgGUID: awKb6JWsRbW6VPrHudq89w==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70514156"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="70514156"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 04:50:49 -0800
X-CSE-ConnectionGUID: Ng7P9aDOSoCzgqjAKHddSw==
X-CSE-MsgGUID: s4Lltn/rTPWOHbUZjiLfPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="211482228"
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.217.160.221])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 04:50:47 -0800
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Fri, 23 Jan 2026 13:49:52 +0100
Message-ID: <20260123124952.338065-2-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] thermal: add new test group
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

This is a new test for checking thermal interrupt events.
Corrects issues pointed out by Petr Vorel for v3.

Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
---
 runtest/thermal                               |   3 +
 scenario_groups/default                       |   1 +
 testcases/kernel/Makefile                     |   1 +
 testcases/kernel/thermal/Makefile             |   9 +
 .../kernel/thermal/thermal_interrupt_events.c | 204 ++++++++++++++++++
 5 files changed, 218 insertions(+)
 create mode 100644 runtest/thermal
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
index 000000000..010487c9c
--- /dev/null
+++ b/testcases/kernel/thermal/thermal_interrupt_events.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2025-2026 Intel - http://www.intel.com/
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
+#define	PATH_LEN	69
+#define RUNTIME		30
+#define SLEEP		10
+#define	STRING_LEN	23
+#define TEMP_INCREMENT	10
+
+static char trip_path[PATH_LEN];
+static int nproc, trip;
+
+static void setup(void)
+{
+	nproc = tst_ncpus();
+	tst_res(TDEBUG, "Number of logical cores: %d", nproc);
+}
+
+static void cleanup(void)
+{
+	tst_res(TDEBUG, "Restoring original trip_point_1_temp value: %d", trip);
+	SAFE_FILE_PRINTF(trip_path, "%d", trip);
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
+	}
+	return NULL;
+}
+
+static void read_interrupts(uint64_t *interrupt_array, const int nproc)
+{
+	bool interrupts_found = 0;
+	char line[8192];
+
+	memset(interrupt_array, 0, nproc * sizeof(*interrupt_array));
+	FILE *fp = SAFE_FOPEN("/proc/interrupts", "r");
+
+	while (fgets(line, sizeof(line), fp)) {
+		if (strstr(line, "Thermal event interrupts")) {
+			interrupts_found = 1;
+			char *token = strtok(line, " ");
+
+			token = strtok(NULL, " ");
+			int i = 0;
+
+			while (!!strncmp(token, "Thermal", 7)) {
+				interrupt_array[i++] = atoll(token);
+				token = strtok(NULL, " ");
+				tst_res(TDEBUG, "Current value of interrupt_array[%d]: %ld", i - 1, interrupt_array[i - 1]);
+			}
+		}
+	}
+	SAFE_FCLOSE(fp);
+	if (!interrupts_found)
+		tst_brk(TCONF, "No Thermal event interrupts line in /proc/interrupts");
+}
+
+static void run(void)
+{
+	bool status = 1;
+	char line[8192];
+	uint64_t interrupt_init[nproc], interrupt_later[nproc];
+
+	read_interrupts(interrupt_init, nproc);
+
+	DIR *dir = SAFE_OPENDIR("/sys/class/thermal/");
+	struct dirent *entry;
+	int tz_counter = 0;
+
+	while ((entry = SAFE_READDIR(dir))) {
+		if ((strncmp(entry->d_name, "thermal_zone", sizeof("thermal_zone"))) > 0)
+			tz_counter++;
+	}
+	SAFE_CLOSEDIR(dir);
+	tst_res(TDEBUG, "Found %d thermal zone(s)", tz_counter);
+
+	bool x86_pkg_temp_tz[tz_counter], x86_pkg_temp_tz_found = 0;
+
+	memset(x86_pkg_temp_tz, 0, sizeof(x86_pkg_temp_tz));
+
+	for (int i = 0; i < tz_counter; i++) {
+		char path[PATH_LEN];
+
+		snprintf(path, PATH_LEN, "/sys/class/thermal/thermal_zone%d/type", i);
+		tst_res(TDEBUG, "Checking whether %s is x86_pkg_temp", path);
+
+		SAFE_FILE_SCANF(path, "%s", line);
+		if (strstr(line, "x86_pkg_temp")) {
+			tst_res(TDEBUG, "Thermal zone %d uses x86_pkg_temp", i);
+			x86_pkg_temp_tz[i] = 1;
+			x86_pkg_temp_tz_found = 1;
+		}
+	}
+	if (!x86_pkg_temp_tz_found) {
+		tst_res(TINFO, "No thermal zone uses x86_pkg_temp");
+		status = 0;
+	}
+
+	for (int i = 0; i < tz_counter; i++) {
+		if (x86_pkg_temp_tz[i]) {
+			char path[PATH_LEN], temp_path[PATH_LEN];
+			int sleep_time = SLEEP, temp_high, temp;
+			double run_time = RUNTIME;
+
+			snprintf(path, PATH_LEN, "/sys/class/thermal/thermal_zone%d/", i);
+			strncpy(temp_path, path, PATH_LEN);
+			strncat(temp_path, "temp", 4);
+			tst_res(TINFO, "Testing %s", temp_path);
+			SAFE_FILE_SCANF(temp_path, "%d", &temp);
+			if (temp < 0) {
+				tst_brk(TINFO, "Unexpected zone temperature value %d", temp);
+				status = 0;
+			}
+			tst_res(TDEBUG, "Current temperature for %s: %d", path, temp);
+
+			temp_high = temp + TEMP_INCREMENT;
+
+			strncpy(trip_path, path, PATH_LEN);
+			strncat(trip_path, "trip_point_1_temp", 17);
+
+			tst_res(TDEBUG, "Setting new trip_point_1_temp value: %d", temp_high);
+			SAFE_FILE_SCANF(trip_path, "%d", &trip);
+			SAFE_FILE_PRINTF(trip_path, "%d", temp_high);
+
+			while (sleep_time > 0) {
+				tst_res(TDEBUG, "Running for %f seconds, then sleeping for %d seconds", run_time, sleep_time);
+
+				for (int j = 0; j < nproc; j++) {
+					if (!SAFE_FORK()) {
+						cpu_workload(run_time);
+						exit(0);
+					}
+				}
+
+				for (int j = 0; j < nproc; j++)
+					tst_reap_children();
+
+				SAFE_FILE_SCANF(temp_path, "%d", &temp);
+				tst_res(TDEBUG, "Temperature for %s after a test: %d", path, temp);
+
+				if (temp > temp_high)
+					break;
+				sleep(sleep_time--);
+				run_time -= 3;
+			}
+			if (temp <= temp_high) {
+				tst_res(TINFO, "Zone temperature is not rising as expected");
+				status = 0;
+			}
+		}
+	}
+	read_interrupts(interrupt_later, nproc);
+
+	for (int i = 0; i < nproc; i++) {
+		if (interrupt_later[i] < interrupt_init[i]) {
+			tst_res(TINFO, "For CPU %d interrupt counter is currently %ld, while it was %ld before the test", i, interrupt_later[i], interrupt_init[i]);
+			status = 0;
+		}
+	}
+
+	if (status)
+		tst_res(TPASS, "x86 package thermal interrupt triggered");
+	else
+		tst_res(TFAIL, "x86 package thermal interrupt did not trigger");
+}
+
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.forks_child = 1,
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
