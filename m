Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA32DCD342F
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 09:50:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AABD33E617D
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 11:50:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 079633D0517
 for <ltp@lists.linux.it>; Tue,  5 May 2026 11:50:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 55B30140098C
 for <ltp@lists.linux.it>; Tue,  5 May 2026 11:50:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777974610; x=1809510610;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OlJUzn4p5qbMT46466BcqMUDYgybKGsfvGFxui1HN7k=;
 b=a+/zRYCHP0/2Fk4yrEic+++59TbfYwsDZDz96yKNp8lTkjV8KtlZ+YC1
 NcoAuQLLOrhh3C629FqO9eODrvfcQ7224F4UzPifyJSVOpW9pcWVTH1ku
 7T3bNWUTRkt3A8pHzGCUPIwFxvqxUm8E0DHjjPsgsUQoGhnJeT0hw3i/3
 zlx1RR0i2h5Ti329kSI0uyi+eNKKOTvKb9i4Ue/H4xOYfz+7e+H4wpbth
 6ZvjF04Pa4cVeaKJWLAcplOL8mF1RPqBCusxb6pqY1C6Nvrab1RKe5O9f
 CsQ073VXiJ4v4TECiSTn1qoWvXfU4FEcW3glm5moS7RLm5Gp7wWuFubDh A==;
X-CSE-ConnectionGUID: 6mNhffEaRqWVykq7fLSzfg==
X-CSE-MsgGUID: 471IxR5aSiyZ90RpLZr0uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="96409489"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="96409489"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 02:50:04 -0700
X-CSE-ConnectionGUID: MWlgZsFmQGOK37Mw6Xqq9w==
X-CSE-MsgGUID: c++SnJq3TFy3Yd8O6wLU4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="240066159"
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.217.160.221])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 02:50:02 -0700
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Tue,  5 May 2026 11:48:54 +0200
Message-ID: <20260505094853.25383-2-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] cpufreq.c: add new test for cpufreq sysfs
 interface validation
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

Runs various sanity checks for intel_pstate cpufreq sysfs interface.

Checks whether intel_pstate driver is used, whether it is possible
to switch scaling_governor to powersave and performance,
whether it is possible to disable turbo frequency and
whether it is possible to change scaling_min_freq and scaling_max_freq
to its minimal valid and maximal valid values.

Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
---
Fix issue pointed by review:
scaling_governor is modified for every online CPU (in both the active-mode
and passive-mode loops) but is never saved in setup() nor restored in
cleanup(). After the test exits each CPU is left with scaling_governor set
to "schedutil". Please save the original value per CPU in setup() alongside
previous_scaling_max_freq and restore it in cleanup().

Additionally, properly restore intel_pstate/status.
 runtest/power_management_tests               |   1 +
 testcases/kernel/power_management/.gitignore |   1 +
 testcases/kernel/power_management/cpufreq.c  | 386 +++++++++++++++++++
 3 files changed, 388 insertions(+)
 create mode 100644 testcases/kernel/power_management/.gitignore
 create mode 100644 testcases/kernel/power_management/cpufreq.c

diff --git a/runtest/power_management_tests b/runtest/power_management_tests
index b670da6ec..0bc7dd0c8 100644
--- a/runtest/power_management_tests
+++ b/runtest/power_management_tests
@@ -1,4 +1,5 @@
 #POWER_MANAGEMENT
+cpufreq cpufreq
 runpwtests03 runpwtests03.sh
 runpwtests04 runpwtests04.sh
 runpwtests06 runpwtests06.sh
diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
new file mode 100644
index 000000000..7f34e4c2f
--- /dev/null
+++ b/testcases/kernel/power_management/.gitignore
@@ -0,0 +1 @@
+cpufreq
diff --git a/testcases/kernel/power_management/cpufreq.c b/testcases/kernel/power_management/cpufreq.c
new file mode 100644
index 000000000..c45c3fd4f
--- /dev/null
+++ b/testcases/kernel/power_management/cpufreq.c
@@ -0,0 +1,386 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Piotr Kubaj <piotr.kubaj@intel.com>
+ */
+
+/*\
+ * Runs various sanity checks for intel_pstate cpufreq sysfs interface.
+ *
+ * Checks whether intel_pstate driver is used, whether it is possible to switch
+ * scaling_governor to powersave and performance, whether it is possible
+ * to disable turbo frequency and whether it is possible to change
+ * scaling_min_freq and scaling_max_freq to its minimal valid and maximal valid
+ * values.
+ */
+
+#include "tst_test.h"
+
+static bool *online;
+static bool setup_done;
+static char path[PATH_MAX], intel_pstate_status[16];
+static char (*previous_scaling_governor)[16];
+static int no_turbo, nproc;
+static long *previous_scaling_max_freq, *previous_scaling_min_freq;
+
+static void cleanup(void)
+{
+	if (!setup_done) {
+		free(online);
+		free(previous_scaling_max_freq);
+		free(previous_scaling_min_freq);
+		free(previous_scaling_governor);
+		return;
+	}
+
+	SAFE_FILE_PRINTF("/sys/devices/system/cpu/intel_pstate/status", "%s", intel_pstate_status);
+	SAFE_FILE_PRINTF("/sys/devices/system/cpu/intel_pstate/no_turbo", "%d", no_turbo);
+
+	for (int i = 0; i < nproc; i++) {
+		if (!online[i])
+			continue;
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_governor", i);
+		SAFE_FILE_PRINTF(path, "%s", previous_scaling_governor[i]);
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_max_freq", i);
+		SAFE_FILE_PRINTF(path, "%ld", previous_scaling_max_freq[i]);
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_min_freq", i);
+		SAFE_FILE_PRINTF(path, "%ld", previous_scaling_min_freq[i]);
+	}
+
+	free(online);
+	free(previous_scaling_max_freq);
+	free(previous_scaling_min_freq);
+	free(previous_scaling_governor);
+}
+
+static void setup(void)
+{
+	SAFE_FILE_SCANF("/sys/devices/system/cpu/intel_pstate/no_turbo", "%d", &no_turbo);
+	SAFE_FILE_SCANF("/sys/devices/system/cpu/intel_pstate/status", "%15s", intel_pstate_status);
+
+	nproc = tst_ncpus_conf();
+	online = SAFE_CALLOC(nproc, sizeof(*online));
+	previous_scaling_max_freq = SAFE_CALLOC(nproc, sizeof(*previous_scaling_max_freq));
+	previous_scaling_min_freq = SAFE_CALLOC(nproc, sizeof(*previous_scaling_min_freq));
+	previous_scaling_governor = SAFE_CALLOC(nproc, sizeof(*previous_scaling_governor));
+	online[0] = true;
+	for (int i = 1; i < nproc; i++) {
+		int tmp;
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/online", i);
+		SAFE_FILE_SCANF(path, "%d", &tmp);
+		online[i] = (bool)tmp;
+	}
+	for (int i = 0; i < nproc; i++) {
+		if (!online[i])
+			continue;
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_governor", i);
+		SAFE_FILE_SCANF(path, "%15s", previous_scaling_governor[i]);
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_max_freq", i);
+		SAFE_FILE_SCANF(path, "%ld", &previous_scaling_max_freq[i]);
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_min_freq", i);
+		SAFE_FILE_SCANF(path, "%ld", &previous_scaling_min_freq[i]);
+	}
+
+	SAFE_FILE_PRINTF("/sys/devices/system/cpu/intel_pstate/status", "active");
+
+	setup_done = true;
+}
+
+static void run(void)
+{
+	const char * const cpufreq_nodes[] = {
+		"affected_cpus",
+		"cpuinfo_max_freq",
+		"cpuinfo_min_freq",
+		"cpuinfo_transition_latency",
+		"related_cpus",
+		"scaling_available_governors",
+		"scaling_cur_freq",
+		"scaling_driver",
+		"scaling_governor",
+		"scaling_max_freq",
+		"scaling_min_freq",
+		"scaling_setspeed",
+		NULL
+	};
+	char contents[256] = {0}, path_cpuinfo_min_freq[PATH_MAX];
+	int fd, no_turbo_val;
+	long cpuinfo_max_freq = 0, cpuinfo_min_freq = 0, scaling_max_freq, scaling_min_freq;
+
+	for (int i = 0; i < nproc; i++) {
+		if (!online[i])
+			continue;
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_driver", i);
+
+		SAFE_FILE_SCANF(path, "%255s", contents);
+		tst_res(TDEBUG, "Checking whether %s is \"intel_pstate\"", path);
+		if (strstr(contents, "intel_pstate")) {
+			tst_res(TPASS, "%s is intel_pstate", path);
+		} else {
+			tst_res(TINFO, "%s contains: %s", path, contents);
+			tst_res(TFAIL, "%s is not intel_pstate", path);
+		}
+
+		for (int j = 0; cpufreq_nodes[j]; j++) {
+			struct stat stats;
+
+			snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/%s", i, cpufreq_nodes[j]);
+			tst_res(TDEBUG, "Checking whether %s is a regular file", path);
+			SAFE_STAT(path, &stats);
+			if (!S_ISREG(stats.st_mode)) {
+				tst_res(TINFO, "%s mode: %o", path, stats.st_mode);
+				tst_res(TFAIL, "%s is not a regular file", path);
+			} else {
+				tst_res(TPASS, "%s is a regular file", path);
+			}
+		}
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_available_governors", i);
+		memset(contents, 0, sizeof(contents));
+		fd = SAFE_OPEN(path, O_RDONLY);
+		SAFE_READ(0, fd, contents, sizeof(contents));
+		SAFE_CLOSE(fd);
+
+		tst_res(TDEBUG, "Checking whether %s contains \"performance\" and \"powersave\"", path);
+		if (strstr(contents, "performance") && strstr(contents, "powersave")) {
+			tst_res(TPASS, "%s contains: %s", path, contents);
+		} else {
+			tst_res(TINFO, "%s contains: %s", path, contents);
+			tst_res(TFAIL, "%s is not \"performance powersave\"", path);
+		}
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_governor", i);
+		tst_res(TDEBUG, "Checking %s", path);
+		memset(contents, 0, sizeof(contents));
+		SAFE_FILE_SCANF(path, "%255s", contents);
+		if (strstr(contents, "performance")) {
+			tst_res(TDEBUG, "%s is \"performance\"", path);
+			tst_res(TDEBUG, "Checking whether %s can be switched to \"powersave\"", path);
+			SAFE_FILE_PRINTF(path, "powersave");
+			memset(contents, 0, sizeof(contents));
+			SAFE_FILE_SCANF(path, "%255s", contents);
+			if (strstr(contents, "powersave"))
+				tst_res(TPASS, "Changing scaling_governor from performance to powersave succeeded");
+			else
+				tst_res(TFAIL, "%s: failed to change scaling_governor from performance to powersave, current scaling_governor: %s", path, contents);
+
+		} else if (strstr(contents, "powersave")) {
+			tst_res(TDEBUG, "%s is \"powersave\"", path);
+			tst_res(TDEBUG, "Checking whether %s can be switched to \"performance\"", path);
+			SAFE_FILE_PRINTF(path, "performance");
+			memset(contents, 0, sizeof(contents));
+			SAFE_FILE_SCANF(path, "%255s", contents);
+			if (strstr(contents, "performance"))
+				tst_res(TPASS, "Changing scaling_governor from powersave to performance succeeded");
+			else
+				tst_res(TFAIL, "%s: failed to change scaling_governor from powersave to performance, current scaling_governor: %s", path, contents);
+
+		} else {
+			tst_brk(TBROK, "Unknown scaling_governor: %s", contents);
+		}
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/cpuinfo_max_freq", i);
+		snprintf(path_cpuinfo_min_freq, sizeof(path_cpuinfo_min_freq), "/sys/devices/system/cpu/cpu%d/cpufreq/cpuinfo_min_freq", i);
+		tst_res(TDEBUG, "Checking whether %s is bigger than cpuinfo_min_freq", path);
+		SAFE_FILE_SCANF(path, "%ld", &cpuinfo_max_freq);
+
+		SAFE_FILE_SCANF(path_cpuinfo_min_freq, "%ld", &cpuinfo_min_freq);
+
+		if (cpuinfo_min_freq > cpuinfo_max_freq)
+			tst_res(TFAIL, "Value in %s: %ld, should be bigger than cpuinfo_min_freq: %ld", path, cpuinfo_max_freq, cpuinfo_min_freq);
+		else
+			tst_res(TPASS, "Value in %s: %ld, is bigger than cpuinfo_min_freq: %ld", path, cpuinfo_max_freq, cpuinfo_min_freq);
+	}
+
+	snprintf(path, sizeof(path), "/sys/devices/system/cpu/intel_pstate/status");
+	tst_res(TDEBUG, "Checking whether %s contains \"active\"", path);
+	memset(contents, 0, sizeof(contents));
+	SAFE_FILE_SCANF(path, "%255s", contents);
+
+	if (strstr(contents, "active"))
+		tst_res(TPASS, "%s is \"active\"", path);
+	else
+		tst_res(TFAIL, "%s is not \"active\", but %s", path, contents);
+
+	tst_res(TDEBUG, "Checking whether %s can be switched to \"passive\"", path);
+	SAFE_FILE_PRINTF(path, "passive");
+	memset(contents, 0, sizeof(contents));
+	SAFE_FILE_SCANF(path, "%255s", contents);
+
+	if (strstr(contents, "passive"))
+		tst_res(TPASS, "%s is \"passive\"", path);
+	else
+		tst_res(TFAIL, "%s is not \"passive\", but %s", path, contents);
+
+	tst_res(TDEBUG, "Checking whether %s can be switched back to \"active\"", path);
+	SAFE_FILE_PRINTF(path, "active");
+	memset(contents, 0, sizeof(contents));
+	SAFE_FILE_SCANF(path, "%255s", contents);
+
+	if (strstr(contents, "active"))
+		tst_res(TPASS, "%s is \"active\"", path);
+	else
+		tst_res(TFAIL, "%s is not \"active\", but %s", path, contents);
+
+	snprintf(path, sizeof(path), "/sys/devices/system/cpu/intel_pstate/no_turbo");
+	tst_res(TDEBUG, "Checking whether %s can be switched to 1", path);
+	SAFE_FILE_PRINTF(path, "1");
+	SAFE_FILE_SCANF(path, "%d", &no_turbo_val);
+
+	if (no_turbo_val == 1)
+		tst_res(TPASS, "%s is \"1\"", path);
+	else
+		tst_res(TFAIL, "%s is not \"1\", but %d", path, no_turbo_val);
+
+	tst_res(TDEBUG, "Checking whether %s can be switched back to 0", path);
+	SAFE_FILE_PRINTF(path, "0");
+	SAFE_FILE_SCANF(path, "%d", &no_turbo_val);
+
+	if (no_turbo_val == 0)
+		tst_res(TPASS, "%s is \"0\"", path);
+	else
+		tst_res(TFAIL, "%s is not \"0\", but %d", path, no_turbo_val);
+
+	tst_res(TDEBUG, "Checking whether scaling_available_governors contains \"performance\" and \"schedutil\" after switching /sys/devices/system/cpu/intel_pstate/status to \"passive\"");
+	snprintf(path, sizeof(path), "/sys/devices/system/cpu/intel_pstate/status");
+	SAFE_FILE_PRINTF(path, "passive");
+
+	for (int i = 0; i < nproc; i++) {
+		if (!online[i])
+			continue;
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_available_governors", i);
+		memset(contents, 0, sizeof(contents));
+		fd = SAFE_OPEN(path, O_RDONLY);
+		SAFE_READ(0, fd, contents, sizeof(contents));
+		SAFE_CLOSE(fd);
+
+		tst_res(TDEBUG, "Checking whether %s contains \"performance\" and \"schedutil\"", path);
+		if (strstr(contents, "performance") && strstr(contents, "schedutil")) {
+			tst_res(TPASS, "%s contains: %s", path, contents);
+		} else {
+			tst_res(TINFO, "%s contains: %s", path, contents);
+			tst_res(TFAIL, "%s does not contain \"performance\" and \"schedutil\"", path);
+		}
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_governor", i);
+		tst_res(TDEBUG, "Checking whether %s can be changed to performance", path);
+		SAFE_FILE_PRINTF(path, "performance");
+		memset(contents, 0, sizeof(contents));
+		SAFE_FILE_SCANF(path, "%255s", contents);
+
+		if (strstr(contents, "performance"))
+			tst_res(TPASS, "%s is \"performance\"", path);
+		else
+			tst_res(TFAIL, "%s is not \"performance\", but %s", path, contents);
+
+		tst_res(TDEBUG, "Checking whether %s can be changed to schedutil", path);
+		SAFE_FILE_PRINTF(path, "schedutil");
+		memset(contents, 0, sizeof(contents));
+		SAFE_FILE_SCANF(path, "%255s", contents);
+
+		if (strstr(contents, "schedutil"))
+			tst_res(TPASS, "%s is \"schedutil\"", path);
+		else
+			tst_res(TFAIL, "%s is not \"schedutil\", but %s", path, contents);
+	}
+
+	for (int i = 0; i < nproc; i++) {
+		if (!online[i])
+			continue;
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/cpuinfo_max_freq", i);
+		tst_res(TDEBUG, "Checking whether %s can be assigned to scaling_max_freq and scaling_min_freq", path);
+		SAFE_FILE_SCANF(path, "%ld", &cpuinfo_max_freq);
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/cpuinfo_min_freq", i);
+		SAFE_FILE_SCANF(path, "%ld", &cpuinfo_min_freq);
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_max_freq", i);
+		SAFE_FILE_PRINTF(path, "%ld", cpuinfo_max_freq);
+		SAFE_FILE_SCANF(path, "%ld", &scaling_max_freq);
+
+		if (cpuinfo_max_freq < scaling_max_freq) {
+			tst_res(TINFO, "cpuinfo_max_freq: %ld", cpuinfo_max_freq);
+			tst_res(TINFO, "scaling_max_freq: %ld", scaling_max_freq);
+			tst_res(TFAIL, "Failure setting %s", path);
+		} else {
+			tst_res(TPASS, "Successfully set up %s", path);
+		}
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_min_freq", i);
+		SAFE_FILE_PRINTF(path, "%ld", cpuinfo_max_freq);
+		SAFE_FILE_SCANF(path, "%ld", &scaling_min_freq);
+
+		if (cpuinfo_max_freq < scaling_min_freq) {
+			tst_res(TINFO, "cpuinfo_max_freq: %ld", cpuinfo_max_freq);
+			tst_res(TINFO, "scaling_min_freq: %ld", scaling_min_freq);
+			tst_res(TFAIL, "Failure setting %s", path);
+		} else {
+			tst_res(TPASS, "Successfully set up %s", path);
+		}
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_min_freq", i);
+		SAFE_FILE_PRINTF(path, "%ld", previous_scaling_min_freq[i]);
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_max_freq", i);
+		SAFE_FILE_PRINTF(path, "%ld", previous_scaling_max_freq[i]);
+	}
+
+	for (int i = 0; i < nproc; i++) {
+		if (!online[i])
+			continue;
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/cpuinfo_max_freq", i);
+		tst_res(TDEBUG, "Checking whether %s can be assigned to scaling_max_freq and scaling_min_freq", path);
+		SAFE_FILE_SCANF(path, "%ld", &cpuinfo_max_freq);
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/cpuinfo_min_freq", i);
+		SAFE_FILE_SCANF(path, "%ld", &cpuinfo_min_freq);
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_min_freq", i);
+		SAFE_FILE_PRINTF(path, "%ld", cpuinfo_min_freq);
+		SAFE_FILE_SCANF(path, "%ld", &scaling_min_freq);
+
+		if (cpuinfo_min_freq > scaling_min_freq) {
+			tst_res(TINFO, "cpuinfo_min_freq: %ld", cpuinfo_min_freq);
+			tst_res(TINFO, "scaling_min_freq: %ld", scaling_min_freq);
+			tst_res(TFAIL, "Failure setting %s", path);
+		} else {
+			tst_res(TPASS, "Successfully set up %s", path);
+		}
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_max_freq", i);
+		SAFE_FILE_PRINTF(path, "%ld", cpuinfo_min_freq);
+		SAFE_FILE_SCANF(path, "%ld", &scaling_max_freq);
+
+		if (cpuinfo_min_freq > scaling_max_freq) {
+			tst_res(TINFO, "cpuinfo_min_freq: %ld", cpuinfo_min_freq);
+			tst_res(TINFO, "scaling_max_freq: %ld", scaling_max_freq);
+			tst_res(TFAIL, "Failure setting %s", path);
+		} else {
+			tst_res(TPASS, "Successfully set up %s", path);
+		}
+	}
+}
+
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_X86_INTEL_PSTATE",
+		NULL
+	},
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
