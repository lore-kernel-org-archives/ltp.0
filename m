Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A39BC44536
	for <ltp@archiver.kernel.org>; Wed, 21 Jan 2026 13:43:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23A6F3CB287
	for <ltp@archiver.kernel.org>; Wed, 21 Jan 2026 14:43:30 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D0133C1455
 for <ltp@lists.linux.it>; Wed, 21 Jan 2026 14:43:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 119E460093D
 for <ltp@lists.linux.it>; Wed, 21 Jan 2026 14:43:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769002986; x=1800538986;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ptGGeeHqLOtHabZg2ktZS9a7i5Ykp29AhnxyS1KSuCQ=;
 b=Ar3WKERnyHV4dtGbmng+awxRU9LDobwJ7bwgmKovfUErRgr0hxu+axuZ
 tEEnNjehK1mDxvwKF3dqg/+oB0W79eQJ7LIu048IzmEqF40oOvszswZN4
 v5xHLh3h2ldIUvWu7D2Ln1mU7Y2hbhHiA+6/JGT4xX3vlw/1xX2nthqyh
 /xITONZzPKT46ansckZuskVbKcKxpcelZEBVUuhYIYmuna2oqtIOowX2j
 0xlGRETGcCO9p+rb2y9HSZBZ9XaKwpcDIXEIPwcv7jXrZ6uP9OprO8b9X
 NwKVdY5NQkWeQnWD3rl3l7EHU0AxNxrL1twcAmASHwIVMw8YEwWWRaIMk g==;
X-CSE-ConnectionGUID: GUWQ3ZTlTy6ZiVMY3d1BPw==
X-CSE-MsgGUID: zodDIbHURRuNFkNRIDcCqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81605925"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="81605925"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 05:43:02 -0800
X-CSE-ConnectionGUID: WCFCCV7SRt2F70F9L9hsUg==
X-CSE-MsgGUID: b2PnVxuDRLiHZP3h1cIsgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="244020625"
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.217.160.221])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 05:43:01 -0800
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Wed, 21 Jan 2026 14:41:47 +0100
Message-ID: <20260121134146.259161-2-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] thermal: add new test group
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
Addresses some review points from Petr.

Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
---
 runtest/thermal                               |   3 +
 scenario_groups/default                       |   1 +
 testcases/kernel/Makefile                     |   1 +
 testcases/kernel/thermal/Makefile             |  11 ++
 .../kernel/thermal/thermal_interrupt_events.c | 187 ++++++++++++++++++
 5 files changed, 203 insertions(+)
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
index 000000000..04a4360d0
--- /dev/null
+++ b/testcases/kernel/thermal/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2025, Intel Corporation. All rights reserved.
+# Author:Piotr Kubaj <piotr.kubaj@intel.com>
+
+top_srcdir             ?= ../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+thermal_interrupt_events: LDLIBS    += -lpthread
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/thermal/thermal_interrupt_events.c b/testcases/kernel/thermal/thermal_interrupt_events.c
new file mode 100644
index 000000000..037919f59
--- /dev/null
+++ b/testcases/kernel/thermal/thermal_interrupt_events.c
@@ -0,0 +1,187 @@
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
+#include <ctype.h>
+#include <pthread.h>
+#define	PATH_LEN	69
+#define	STRING_LEN	23
+
+static void *cpu_workload(void *arg)
+{
+	time_t start_time = time(NULL);
+	int num = 2;
+
+	while (difftime(time(NULL), start_time) < *(double *)arg) {
+		for (int i = 2; i * i <= num; i++) {
+			if (num % i == 0)
+				break;
+		}
+		num++;
+	}
+	return NULL;
+}
+
+static void read_interrupts(uint64_t *interrupt_array, const uint16_t nproc)
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
+	int nproc = tst_ncpus();
+	uint64_t interrupt_init[nproc], interrupt_later[nproc];
+
+	tst_res(TDEBUG, "Number of logical cores: %d", nproc);
+	read_interrupts(interrupt_init, nproc);
+
+	DIR *dir = SAFE_OPENDIR("/sys/class/thermal/");
+	struct dirent *entry;
+	uint8_t tz_counter = 0;
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
+	for (uint8_t i = 0; i < tz_counter; i++) {
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
+	for (uint8_t i = 0; i < tz_counter; i++) {
+		if (x86_pkg_temp_tz[i]) {
+			char path[PATH_LEN], temp_path[PATH_LEN], trip_path[PATH_LEN], temp_high[12], trip[12];
+			double run_time = 30;
+			uint8_t sleep_time = 10;
+			int temp;
+
+			snprintf(path, PATH_LEN, "/sys/class/thermal/thermal_zone%d/", i);
+			strncpy(temp_path, path, PATH_LEN);
+			strncat(temp_path, "temp", 4);
+			tst_res(TDEBUG, "Testing %s", temp_path);
+			SAFE_FILE_SCANF(temp_path, "%d", &temp);
+			if (temp < 0) {
+				tst_brk(TBROK, "Unexpected zone temperature value %d", temp);
+				status = 0;
+			}
+			tst_res(TDEBUG, "Current temperature for %s: %d", path, temp);
+
+			snprintf(temp_high, sizeof(temp_high), "%d", temp + 10);
+
+			strncpy(trip_path, path, PATH_LEN);
+			strncat(trip_path, "trip_point_1_temp", 17);
+
+			tst_res(TDEBUG, "Setting new trip_point_1_temp value: %s", temp_high);
+			SAFE_FILE_SCANF(trip_path, "%s", trip);
+			SAFE_FILE_PRINTF(trip_path, "%s", temp_high);
+
+			while (sleep_time > 0) {
+				tst_res(TDEBUG, "Running for %f seconds, then sleeping for %d seconds", run_time, sleep_time);
+				pthread_t threads[nproc];
+
+				for (uint16_t j = 0; j < nproc; j++)
+					pthread_create(&threads[j], NULL, cpu_workload, &run_time);
+				for (uint16_t j = 0; j < nproc; j++)
+					pthread_join(threads[j], NULL);
+
+				SAFE_FILE_SCANF(temp_path, "%d", &temp);
+				tst_res(TDEBUG, "Temperature for %s after a test: %d", path, temp);
+
+				if (temp > atol(temp_high))
+					break;
+				sleep(sleep_time--);
+				run_time -= 3;
+			}
+			if (temp <= atol(temp_high)) {
+				tst_res(TINFO, "Zone temperature is not rising as expected");
+				status = 0;
+			}
+
+			tst_res(TDEBUG, "Restoring original trip_point_1_temp value: %s", trip);
+			SAFE_FILE_PRINTF(trip_path, "%s", trip);
+		}
+	}
+	read_interrupts(interrupt_later, nproc);
+
+	for (uint16_t i = 0; i < nproc; i++) {
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
+	.min_runtime = 180,
+	.needs_root = true,
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
