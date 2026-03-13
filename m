Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335A4105F7A6
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 12:54:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C9523E48FF
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 13:54:46 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 085573CA98F
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 13:54:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E1B511000A09
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 13:54:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773406464; x=1804942464;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=a0i8Thka+oK8p7ua/3BMj2Qxs0Eb90V5uSzl0cZeiWs=;
 b=VSKsPEWYFufpAZmW1zvpibL/xKb8bjVaF3DB+d6/12wj1aRY+j4Ldu8a
 i8BoLxeUT36sZgHiHqqY/GyVlxVH94q3pPiXQPTn+tbqbr8qDlfIfV861
 nVySh3UtlUE1kgZylA/GRJHBC7Rv5Om29zm5DKY+0KYEmHXpfX2peOy/B
 0NdkKWo5zT9gAZncWBTcu6Zl/tAnC3ZdYeHsqFyDgHqZzQdnusnwZ9N92
 raVGP1Ul8mz6TgWFmyswPJHkFopUIrrhnDII4icVeGAGS/AMec5/RFd5Y
 jz+xN9owdFxAehhLIyUx2XkTDcsLV4y4kCo8um3jt6aUwF42HIZHPmU38 Q==;
X-CSE-ConnectionGUID: HCuy0Hr0TJ2OUrXaqI4dHQ==
X-CSE-MsgGUID: zTbSmYvqRuqlAx7GyILezQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74549061"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="74549061"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 05:54:21 -0700
X-CSE-ConnectionGUID: imdGzWlwSX+wj8UI/irGDA==
X-CSE-MsgGUID: j+T6MmtkRticXCtV6ixKEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="259049821"
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.217.160.221])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 05:54:19 -0700
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Fri, 13 Mar 2026 13:54:09 +0100
Message-ID: <20260313125408.480770-2-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] high_freq_hwp_cap_cppc.c: new test
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
---
 testcases/kernel/power_management/.gitignore  |  1 +
 .../power_management/high_freq_hwp_cap_cppc.c | 57 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 testcases/kernel/power_management/high_freq_hwp_cap_cppc.c

diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
index 0c2a3ed4b..c13bca1c4 100644
--- a/testcases/kernel/power_management/.gitignore
+++ b/testcases/kernel/power_management/.gitignore
@@ -1 +1,2 @@
+high_freq_hwp_cap_cppc
 pm_get_sched_values
diff --git a/testcases/kernel/power_management/high_freq_hwp_cap_cppc.c b/testcases/kernel/power_management/high_freq_hwp_cap_cppc.c
new file mode 100644
index 000000000..4cbb81f0b
--- /dev/null
+++ b/testcases/kernel/power_management/high_freq_hwp_cap_cppc.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2025-2026 Intel - http://www.intel.com/
+ */
+
+/*\
+ * Verify for all online logical CPUs  that their highest performance value are
+ * the same for HWP Capability MSR 0x771 and CPPC sysfs file.
+ */
+
+#include "tst_test.h"
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
+	for (int i = 0; i < nproc; i++) {
+		char path[PATH_MAX];
+		unsigned long long msr_highest_perf = 0, sysfs_highest_perf = 0;
+
+		snprintf(path, PATH_MAX, "/sys/devices/system/cpu/cpu%d/acpi_cppc/highest_perf", i);
+		SAFE_FILE_SCANF(path, "%llu", &sysfs_highest_perf);
+		tst_res(TDEBUG, "%s: %llu", path, sysfs_highest_perf);
+
+		snprintf(path, PATH_MAX, "/dev/cpu/%d/msr", i);
+		int fd = SAFE_OPEN(path, O_RDONLY);
+
+		if (pread(fd, &msr_highest_perf, sizeof(msr_highest_perf), 0x771) < 0) {
+			SAFE_CLOSE(fd);
+			tst_brk(TBROK | TERRNO, "MSR read error");
+		}
+		SAFE_CLOSE(fd);
+		msr_highest_perf &= (1ULL << 8) - 1;
+		tst_res(TDEBUG, "%s: %llu", path, msr_highest_perf);
+
+		if (msr_highest_perf != sysfs_highest_perf)
+			tst_brk(TFAIL, "CPU %d: highest performance values differ between sysfs and MSR", i);
+	}
+
+	tst_res(TPASS, "Test pass");
+}
+
+static struct tst_test test = {
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_X86_MSR",
+		NULL
+	},
+	.needs_root = 1,
+	.setup = setup,
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
