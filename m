Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D002108B913
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 12:33:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D5EA3E30B1
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 13:33:26 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED27B3C940A
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 13:33:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A42B820173B
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 13:33:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774009987; x=1805545987;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MZBdNcAGhLTuX7Nh04k9Ot+lUs7uwHkJv5/JwD2GOLo=;
 b=N3KDqQKKayDb7MwnQn5qYW0WntJWW3t21UjKQZFlgs6ckMyM+Nbkt1Ah
 JgHoFOTzWu6LPbnJmGTg1kFHh5Ey3hctj4VoWh3zx79yCLpGioc67gZl1
 P7ofZRR5r1fJ1Vcy4yAw31C58ACd8qzCqeL65MbkFfcBDhuY2d6agHJUj
 2w4x0U0Unp8kzrFV4gfuGJEDQtJFtvsSjTMjr+6vlKAIyxGVHCWcb6Vt0
 Wjs2w4s2zuCtBQgs5VhY7wjsrerYz0dqmfQx91hgTfr/Uo5378h/FFc16
 74ajawvjed43Ak0MeLouXvk9AuMPcjTOiJ8uTB1ps8eEPQOnQvencTMof g==;
X-CSE-ConnectionGUID: xuCBdelVQuGaA2bQBv9qqg==
X-CSE-MsgGUID: qFvdIDdqSIaFxnfGR1LK9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="85407974"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="85407974"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 05:33:05 -0700
X-CSE-ConnectionGUID: DT4loMXMRZOf5jZcSHFwMQ==
X-CSE-MsgGUID: pTKN7N7ERmi4jK/0R5+Rgw==
X-ExtLoop1: 1
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.217.160.221])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 05:33:02 -0700
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Fri, 20 Mar 2026 13:32:57 +0100
Message-ID: <20260320123257.124745-1-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] high_freq_hwp_cap_cppc.c: new test
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
Add the test to power_management_tests.
 runtest/power_management_tests                |  1 +
 testcases/kernel/power_management/.gitignore  |  1 +
 .../power_management/high_freq_hwp_cap_cppc.c | 66 +++++++++++++++++++
 3 files changed, 68 insertions(+)
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
index 000000000..e3008d38a
--- /dev/null
+++ b/testcases/kernel/power_management/high_freq_hwp_cap_cppc.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
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
+		char path[PATH_MAX];
+		unsigned long long msr_highest_perf = 0, sysfs_highest_perf = 0;
+
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/acpi_cppc/highest_perf", i);
+		SAFE_FILE_SCANF(path, "%llu", &sysfs_highest_perf);
+		tst_res(TDEBUG, "%s: %llu", path, sysfs_highest_perf);
+
+		snprintf(path, sizeof(path), "/dev/cpu/%d/msr", i);
+		int fd = SAFE_OPEN(path, O_RDONLY);
+
+		if (SAFE_PREAD(1, fd, &msr_highest_perf, sizeof(msr_highest_perf), 0x771) == -1)
+			tst_brk(TBROK | TERRNO, "MSR read error");
+		msr_highest_perf &= (1ULL << 8) - 1;
+		tst_res(TDEBUG, "%s: %llu", path, msr_highest_perf);
+
+		if (msr_highest_perf != sysfs_highest_perf)
+			status = false;
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
