Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864EEEC01CC
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 11:40:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C0173E2368
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 12:40:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 335733E1D75
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 12:40:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C2D7B140032F
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 12:40:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774266024; x=1805802024;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2TpY+HiM5GUckkcGsWprm76OQVTi4W20k4meWiMlnuI=;
 b=L2dhLeqskdh9CQc4boXe2pkid/6TTzhf6CQSwYIGtPksdTgJr0u9Jse3
 u5krRjm7js5LStoeBtGX+H8Qe7GUXAMI/sauq3CiFfKG10XNFqL8iiVmc
 ycAQ2jec+56Kj7ptYs3/4sIEr4ue2IKkFs0MZ0YQTUXDL/nQKqaJBjBEF
 zUIDvjmfYiC2YsrBTbeFic0ddx7wS9z8LS3nFMAjPawGJ54/lJL7FbioX
 y8lK4OCbLWm6p10tZ3WMUkpcnA39M8LChtnEZtssOZtRXBfKyglqmMv8o
 iZo4WBsfOy0cxelg/Ixkspu4u5KXPIjeTdgoc5qjdIXtku+7w7pG4ER7e g==;
X-CSE-ConnectionGUID: MojPewX4SY6LgSJyeJwfEA==
X-CSE-MsgGUID: bRys8xDAT5SXmtlnaUvDYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="85571446"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="85571446"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 04:40:19 -0700
X-CSE-ConnectionGUID: G8Ln/8WtRdaZGDy96VuMDw==
X-CSE-MsgGUID: cj1W8KjjT6qa5yXzKZbd9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="228727266"
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.217.160.221])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 04:40:13 -0700
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Mon, 23 Mar 2026 12:39:41 +0100
Message-ID: <20260323113940.188663-2-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] high_freq_hwp_cap_cppc.c: new test
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

Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
---
Online check needs to be true by default for cpu0 to be checked.

 runtest/power_management_tests                |  1 +
 testcases/kernel/power_management/.gitignore  |  1 +
 .../power_management/high_freq_hwp_cap_cppc.c | 84 +++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 testcases/kernel/power_management/high_freq_hwp_cap_cppc.c

diff --git a/runtest/power_management_tests b/runtest/power_management_tests
index 884e615cd..6d87dfb7f 100644
--- a/runtest/power_management_tests
+++ b/runtest/power_management_tests
@@ -1,4 +1,5 @@
 #POWER_MANAGEMENT
+high_freq_hwp_cap_cppc high_freq_hwp_cap_cppc
 runpwtests01 runpwtests01.sh
 runpwtests02 runpwtests02.sh
 runpwtests03 runpwtests03.sh
diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
index 0c2a3ed4b..c13bca1c4 100644
--- a/testcases/kernel/power_management/.gitignore
+++ b/testcases/kernel/power_management/.gitignore
@@ -1 +1,2 @@
+high_freq_hwp_cap_cppc
 pm_get_sched_values
diff --git a/testcases/kernel/power_management/high_freq_hwp_cap_cppc.c b/testcases/kernel/power_management/high_freq_hwp_cap_cppc.c
new file mode 100644
index 000000000..7f604d253
--- /dev/null
+++ b/testcases/kernel/power_management/high_freq_hwp_cap_cppc.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Intel - http://www.intel.com/
+ */
+
+/*\
+ * Verify for all online logical CPUs that their highest performance value are
+ * the same for HWP Capability MSR 0x771 and CPPC sysfs file.
+ */
+
+#include "tst_test.h"
+#include "tst_safe_prw.h"
+
+static int nproc;
+
+static void setup(void)
+{
+	nproc = tst_ncpus();
+}
+
+static void run(void)
+{
+	bool status = true;
+
+	for (int i = 0; i < nproc; i++) {
+		bool online = true;
+		char path[PATH_MAX];
+		unsigned long long msr_highest_perf = 0, sysfs_highest_perf = 0;
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/online", i);
+		if (i)
+			SAFE_FILE_SCANF(path, "%d", &online);
+
+		if (!online) {
+			tst_res(TINFO, "CPU%d offline, skipping", i);
+			continue;
+		}
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/acpi_cppc/highest_perf", i);
+		if (access(path, F_OK) == -1) {
+			tst_res(TCONF | TERRNO, "CPPC sysfs not available, skipping");
+			return;
+		}
+
+		SAFE_FILE_SCANF(path, "%llu", &sysfs_highest_perf);
+		tst_res(TDEBUG, "%s: %llu", path, sysfs_highest_perf);
+
+		snprintf(path, sizeof(path), "/dev/cpu/%d/msr", i);
+		int fd = SAFE_OPEN(path, O_RDONLY);
+
+		SAFE_PREAD(1, fd, &msr_highest_perf, sizeof(msr_highest_perf), 0x771);
+		msr_highest_perf &= (1ULL << 8) - 1;
+		tst_res(TDEBUG, "%s: %llu", path, msr_highest_perf);
+
+		if (msr_highest_perf != sysfs_highest_perf) {
+			tst_res(TINFO, "cpu%d: sysfs=%llu MSR=%llu",
+				i, sysfs_highest_perf, msr_highest_perf);
+			status = false;
+		}
+
+		SAFE_CLOSE(fd);
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
