Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42173CD98DA
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 11:43:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C26A43E59A0
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 13:43:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4E1C3C2B0D
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 13:43:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1C64F601B1F
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 13:43:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781610201; x=1813146201;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sltLbtbann/LSnpxT6n3nzclZIIffFTBoXFZQ20imws=;
 b=DOnE9yAo9hdkZJ9FkFUWQ6y2el1+p7lsnyqEt0cJTPPDHwqaxcaZt1E4
 TpGkAfKmLjL2GNt2TqmYQQqljuxO++cjj3m8CKHspBaryN6mgbG6DAi3j
 xsB7BOqrRGBLcRkuNqqU75Ud/gDHD3PWxODnZTWm2VUzjpWJkMlNfZsPI
 TmPzqn4fbp34IJ4GF98augbcz5HmAkntOfb9xgQBO3BQWvGH1IlQA2dRL
 mBjMn+GExArIX7uSQNEJKDeElmaWRFdURbDXPgKMxAN3CCLKMXwJjtPYq
 4eG6Di92JzI4kmZTlMp/ZhHwu4L6iDJroQqXlwFERDH0Xi2xOJj2O96RB A==;
X-CSE-ConnectionGUID: NLEhBYQ1S36T0yu54/TZnw==
X-CSE-MsgGUID: OxKJcM8VSTCd4P6WjKBniQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="92689046"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; d="scan'208";a="92689046"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 04:43:17 -0700
X-CSE-ConnectionGUID: gKSZHD6cQAqSIygeO2giOg==
X-CSE-MsgGUID: Ct/viQz1SiWZj5cB5+8krA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; d="scan'208";a="246864610"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO intel.com)
 ([10.245.246.171])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 04:43:15 -0700
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Tue, 16 Jun 2026 13:42:05 +0200
Message-ID: <20260616114204.5636-2-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] rfim: add new test for verifying RFIM sysfs interface
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

Validate presence and permissions of RFIM attributes.
The test checks first validity of general RFIM attributes,
and then checks either DLVR or FIVR, depending on hardware.

The test works only on Intel platforms with RFIM.

Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
---
 runtest/power_management_tests               |   1 +
 testcases/kernel/power_management/.gitignore |   1 +
 testcases/kernel/power_management/rfim.c     | 165 +++++++++++++++++++
 3 files changed, 167 insertions(+)
 create mode 100644 testcases/kernel/power_management/rfim.c

diff --git a/runtest/power_management_tests b/runtest/power_management_tests
index 4da57ee72..8ebbcff84 100644
--- a/runtest/power_management_tests
+++ b/runtest/power_management_tests
@@ -1,5 +1,6 @@
 #POWER_MANAGEMENT
 high_freq_hwp_cap_cppc high_freq_hwp_cap_cppc
+rfim rfim
 runpwtests03 runpwtests03.sh
 runpwtests04 runpwtests04.sh
 runpwtests06 runpwtests06.sh
diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
index 03f0c83e4..ecc2931fa 100644
--- a/testcases/kernel/power_management/.gitignore
+++ b/testcases/kernel/power_management/.gitignore
@@ -1 +1,2 @@
 high_freq_hwp_cap_cppc
+rfim
diff --git a/testcases/kernel/power_management/rfim.c b/testcases/kernel/power_management/rfim.c
new file mode 100644
index 000000000..06bc144a2
--- /dev/null
+++ b/testcases/kernel/power_management/rfim.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Piotr Kubaj <piotr.kubaj@intel.com>
+ */
+
+/*\
+ * Validate presence and permissions of RFIM attributes.
+ * The test checks first validity of general RFIM attributes,
+ * and then checks either DLVR or FIVR, depending on hardware.
+ */
+
+#include "tst_test.h"
+
+#define RFIM_ROOT "/sys/bus/pci/devices/0000:00:04.0"
+
+enum rfim_variant {
+	RFIM_FIVR,
+	RFIM_DLVR,
+};
+
+static enum rfim_variant variant;
+
+static void setup(void)
+{
+	struct stat stats;
+
+	if (!stat(RFIM_ROOT"/dlvr", &stats)) {
+		if (S_ISDIR(stats.st_mode))
+			variant = RFIM_DLVR;
+		else
+			tst_brk(TBROK, "%s exists but is not a directory", RFIM_ROOT"/dlvr");
+	} else if (!stat(RFIM_ROOT"/fivr", &stats)) {
+		if (S_ISDIR(stats.st_mode))
+			variant = RFIM_FIVR;
+		else
+			tst_brk(TBROK, "%s exists but is not a directory", RFIM_ROOT"/fivr");
+	} else
+		tst_brk(TCONF, "Neither %s nor %s exists", RFIM_ROOT"/dlvr", RFIM_ROOT"/fivr");
+}
+
+static void check_read_only(const char *path)
+{
+	tst_res(TDEBUG, "Checking whether %s is read-only", path);
+
+	if (access(path, F_OK)) {
+		tst_res(TFAIL | TERRNO, "%s does not exist", path);
+		return;
+	}
+
+	int fd = open(path, O_RDONLY);
+
+	if (fd == -1) {
+		tst_res(TFAIL | TERRNO, "%s can't be read", path);
+		return;
+	}
+	close(fd);
+
+	fd = open(path, O_WRONLY);
+	if (fd != -1) {
+		close(fd);
+		tst_res(TFAIL, "%s is writable", path);
+		return;
+	}
+
+	tst_res(TPASS, "%s is read-only", path);
+}
+
+static void check_read_write(const char *path)
+{
+	tst_res(TDEBUG, "Checking whether %s is read-write", path);
+
+	if (access(path, F_OK)) {
+		tst_res(TFAIL | TERRNO, "%s does not exist", path);
+		return;
+	}
+
+	int fd = open(path, O_RDWR);
+
+	if (fd != -1) {
+		close(fd);
+		tst_res(TPASS, "%s is read-write", path);
+	} else
+		tst_res(TFAIL | TERRNO, "%s is not read-write", path);
+}
+
+static void run(void)
+{
+	const char * const fivr_nodes[] = {
+		RFIM_ROOT"/fivr/vco_ref_code_lo",
+		RFIM_ROOT"/fivr/vco_ref_code_hi",
+		RFIM_ROOT"/fivr/spread_spectrum_pct",
+		RFIM_ROOT"/fivr/spread_spectrum_clk_enable",
+		RFIM_ROOT"/fivr/rfi_vco_ref_code",
+		RFIM_ROOT"/fivr/fivr_fffc_rev",
+		NULL
+	};
+
+	const char * const ro_general_nodes[] = {
+		RFIM_ROOT"/dvfs/ddr_data_rate_point_0",
+		RFIM_ROOT"/dvfs/ddr_data_rate_point_1",
+		RFIM_ROOT"/dvfs/ddr_data_rate_point_2",
+		RFIM_ROOT"/dvfs/ddr_data_rate_point_3",
+		NULL
+	};
+
+	const char * const ro_dlvr_nodes[] = {
+		RFIM_ROOT"/dlvr/dlvr_hardware_rev",
+		RFIM_ROOT"/dlvr/dlvr_freq_mhz",
+		RFIM_ROOT"/dlvr/dlvr_pll_busy",
+		NULL
+	};
+
+	const char * const rw_dlvr_nodes[] = {
+		RFIM_ROOT"/dlvr/dlvr_freq_select",
+		RFIM_ROOT"/dlvr/dlvr_rfim_enable",
+		RFIM_ROOT"/dlvr/dlvr_spread_spectrum_pct",
+		RFIM_ROOT"/dlvr/dlvr_control_mode",
+		RFIM_ROOT"/dlvr/dlvr_control_lock",
+		NULL
+	};
+
+	const char * const rw_general_nodes[] = {
+		RFIM_ROOT"/dvfs/rfi_restriction_run_busy",
+		RFIM_ROOT"/dvfs/rfi_restriction_err_code",
+		RFIM_ROOT"/dvfs/rfi_restriction_data_rate_base",
+		RFIM_ROOT"/dvfs/rfi_restriction_data_rate",
+		NULL
+	};
+
+	for (int i = 0; ro_general_nodes[i]; i++)
+		check_read_only(ro_general_nodes[i]);
+
+	for (int i = 0; rw_general_nodes[i]; i++)
+		check_read_write(rw_general_nodes[i]);
+
+	if (variant == RFIM_DLVR) {
+		tst_res(TINFO, "Checking DLVR");
+		for (int i = 0; ro_dlvr_nodes[i]; i++)
+			check_read_only(ro_dlvr_nodes[i]);
+
+		for (int i = 0; rw_dlvr_nodes[i]; i++)
+			check_read_write(rw_dlvr_nodes[i]);
+	} else {
+		tst_res(TINFO, "Checking FIVR");
+		for (int i = 0; fivr_nodes[i]; i++)
+			check_read_write(fivr_nodes[i]);
+	}
+}
+
+static struct tst_test test = {
+	.min_kver = "6.4",
+	.needs_cpu_vendor = "GenuineIntel",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_INT340X_THERMAL",
+		NULL
+	},
+	.needs_root = 1,
+	.supported_archs = (const char *const []) {
+		"x86",
+		"x86_64",
+		NULL
+	},
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
