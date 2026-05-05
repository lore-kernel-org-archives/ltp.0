Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5D8CD342F
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 09:56:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A8F53E617B
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 11:56:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3796B3E289B
 for <ltp@lists.linux.it>; Tue,  5 May 2026 11:55:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 28D5C1A007F6
 for <ltp@lists.linux.it>; Tue,  5 May 2026 11:55:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777974943; x=1809510943;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6gBIuQStNmRsgSdA67RsTCTra8rLeF2lpW1TqNdYOmE=;
 b=gzk6UKmDKFBApZEbWi2PU9nOZsFH2sjbsSlGeaaO1BnvWme0U/EGJDCd
 VXStVk0KOnZ3ykICuFzfFojZumeXTz70sBmk5oWYf+ZxzWBbcUbOnvn1c
 QrWONUxHKgRg317WtDauRKhaTL4yGaHBNfhCgl3Qldcfd0mOJ8BWSwHNJ
 lYi8W0ddOoMO8WGZnMEQ5ILhKc4W/t7KgbKMOgTbyWHNX2y5oa/K131R7
 A7jiWqNbfIUSVEoVWZtRwl/ZpDlp5vqJvfUf7+ilWjq4cp69WcC7XW0gh
 9kq/17X4Av9VrdNKBpTKF2YoFivKotXAj0kUgDqZQo3EepHV4FHIFqAZR A==;
X-CSE-ConnectionGUID: zquWoMe9R/e3eGeI6s4NkQ==
X-CSE-MsgGUID: 8uphmJ+vSXOTRg0eAyT3pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89944940"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="89944940"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 02:55:39 -0700
X-CSE-ConnectionGUID: mcL5nLXSSFune9kIIfuIDA==
X-CSE-MsgGUID: YqnMy4HGTteZaJA48sOhOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="231397069"
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.217.160.221])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 02:55:36 -0700
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Tue,  5 May 2026 11:54:52 +0200
Message-ID: <20260505095451.26212-2-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10] high_freq_hwp_cap_cppc.c: new test
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

Verify for all online logical CPUs that their highest performance value are
the same for HWP Capability MSR 0x771 and CPPC sysfs file.

On HWP-capable x86 platforms the acpi_cppc/highest_perf sysfs attribute is
expected to reflect the same highest-performance value that firmware
programs into the HWP Capabilities MSR (0x771, bits 7:0). A mismatch
between the two interfaces indicates a kernel regression in how CPPC
values are exposed to userspace, and would break tools (e.g. cpupower,
intel_pstate tuning scripts) that rely on the sysfs interface to make
frequency-scaling decisions.

Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
---
Addressed both points raised in a review:
1. motivation for the test.
2. fd leak.
 runtest/power_management_tests                |   1 +
 testcases/kernel/power_management/.gitignore  |   1 +
 .../power_management/high_freq_hwp_cap_cppc.c | 105 ++++++++++++++++++
 3 files changed, 107 insertions(+)
 create mode 100644 testcases/kernel/power_management/.gitignore
 create mode 100644 testcases/kernel/power_management/high_freq_hwp_cap_cppc.c

diff --git a/runtest/power_management_tests b/runtest/power_management_tests
index b670da6ec..4da57ee72 100644
--- a/runtest/power_management_tests
+++ b/runtest/power_management_tests
@@ -1,4 +1,5 @@
 #POWER_MANAGEMENT
+high_freq_hwp_cap_cppc high_freq_hwp_cap_cppc
 runpwtests03 runpwtests03.sh
 runpwtests04 runpwtests04.sh
 runpwtests06 runpwtests06.sh
diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
new file mode 100644
index 000000000..03f0c83e4
--- /dev/null
+++ b/testcases/kernel/power_management/.gitignore
@@ -0,0 +1 @@
+high_freq_hwp_cap_cppc
diff --git a/testcases/kernel/power_management/high_freq_hwp_cap_cppc.c b/testcases/kernel/power_management/high_freq_hwp_cap_cppc.c
new file mode 100644
index 000000000..d3c697875
--- /dev/null
+++ b/testcases/kernel/power_management/high_freq_hwp_cap_cppc.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Piotr Kubaj <piotr.kubaj@intel.com>
+ */
+
+/*\
+ * Verify for all online logical CPUs that their highest performance value are
+ * the same for HWP Capability MSR 0x771 and CPPC sysfs file.
+ *
+ * On HWP-capable x86 platforms the acpi_cppc/highest_perf sysfs attribute is
+ * expected to reflect the same highest-performance value that firmware
+ * programs into the HWP Capabilities MSR (0x771, bits 7:0). A mismatch
+ * between the two interfaces indicates a kernel regression in how CPPC
+ * values are exposed to userspace, and would break tools (e.g. cpupower,
+ * intel_pstate tuning scripts) that rely on the sysfs interface to make
+ * frequency-scaling decisions.
+ */
+
+#include "tst_test.h"
+#include "tst_safe_prw.h"
+
+#define MSR_HWP_CAPABILITIES	0x771
+#define HIGHEST_PERF_MASK	0xFF
+
+static int nproc;
+static int fd = -1;
+
+static void setup(void)
+{
+	if (access("/dev/cpu/0/msr", F_OK) == -1)
+		tst_brk(TCONF | TERRNO, "msr driver not loaded");
+
+	if (access("/sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf", F_OK) == -1)
+		tst_brk(TCONF | TERRNO, "CPPC sysfs not available");
+
+	nproc = tst_ncpus_conf();
+}
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+}
+
+static void run(void)
+{
+	bool status = true;
+	char path[PATH_MAX];
+
+	for (int i = 0; i < nproc; i++) {
+		int online = 1;
+		unsigned long long msr_highest_perf = 0, sysfs_highest_perf = 0;
+
+		if (i) {
+			snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/online", i);
+			SAFE_FILE_SCANF(path, "%d", &online);
+		}
+
+		if (!online) {
+			tst_res(TINFO, "CPU%d offline, skipping", i);
+			continue;
+		}
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/acpi_cppc/highest_perf", i);
+		SAFE_FILE_SCANF(path, "%llu", &sysfs_highest_perf);
+		tst_res(TDEBUG, "%s: %llu", path, sysfs_highest_perf);
+
+		snprintf(path, sizeof(path), "/dev/cpu/%d/msr", i);
+		fd = SAFE_OPEN(path, O_RDONLY);
+
+		SAFE_PREAD(1, fd, &msr_highest_perf, sizeof(msr_highest_perf), MSR_HWP_CAPABILITIES);
+		SAFE_CLOSE(fd);
+		fd = -1;
+		msr_highest_perf &= HIGHEST_PERF_MASK;
+		tst_res(TDEBUG, "%s: %llu", path, msr_highest_perf);
+
+		if (msr_highest_perf != sysfs_highest_perf) {
+			tst_res(TINFO, "cpu%d: sysfs=%llu MSR=%llu",
+				i, sysfs_highest_perf, msr_highest_perf);
+			status = false;
+		}
+	}
+
+	if (status)
+		tst_res(TPASS, "Sysfs and MSR values are equal");
+	else
+		tst_res(TFAIL, "Highest performance values differ between sysfs and MSR");
+}
+
+static struct tst_test test = {
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_ACPI_CPPC_LIB",
+		"CONFIG_X86_MSR",
+		NULL
+	},
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
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
