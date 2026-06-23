Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C347ECDB46F
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 11:35:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9D003D00A7
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 13:35:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84FD43D00A7
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 13:34:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BF2DA1400324
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 13:34:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782214497; x=1813750497;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6Jczvjhvuvitocv2V8P9nnzt9y78FRHXhQCLdWhRJZk=;
 b=Vz0irP/mzmVGaBYEnFXzZMuoXXpYGqbPN7Fqc6rgtGZRB7tEmQVFMhq+
 pn2dTcSTZAxREoE1z6i+cuH5/+Ek7uoT9Sm3HfQAw0HX6h7AZi/pF5qYi
 M3fyaN5925plD9jLo3zfukLHUUbUudDlp4RZ9Yn4HQdubb9mFQNvo+9iG
 hkGYurLgZgwW4XDC7kPtvdl3/ZRH7B9WJFz2CnkRGBsGRQ8OC/W2cHalr
 SYl3ynIosUzWEgNaq3rQ3tju2TW2N//phOVUJNc+l3HEGQ8YGOezsTLdC
 K1peGeCMpjNjumKUzl9XlDcSzBUidKjvLDon5y5D1uWEw23S6WqD3vu6D w==;
X-CSE-ConnectionGUID: rkwyewGzQQivi+QRtt2nQA==
X-CSE-MsgGUID: KMZcOYC3S5ulkU0gaP2FRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="94344996"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="94344996"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 04:34:52 -0700
X-CSE-ConnectionGUID: Gs9Z9g38RSqOTPL1xJp0Sw==
X-CSE-MsgGUID: IMbwduq8RqyzAZ70c7ndRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="253846401"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO intel.com)
 ([10.245.246.234])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 04:34:50 -0700
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Tue, 23 Jun 2026 13:34:23 +0200
Message-ID: <20260623113422.188364-2-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] rfim: add new test for verifying RFIM sysfs
 interface
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

Validate presence and permissions of the RFIM attributes exposed by the
Intel processor_thermal driver under the proc_thermal PCI device.

The kernel creates the dvfs, fivr and dlvr attribute groups
independently, each gated on its own per-device feature bit, so the test
detects which of the three groups the hardware presents and checks only
those. This covers platforms that expose both FIVR and DLVR (e.g. Meteor
Lake) as well as those with FIVR but no DVFS (e.g. Tiger Lake).

Read-only attributes (mode 0444) must accept O_RDONLY and reject a write
open with EACCES; read-write attributes (mode 0644) must accept O_RDWR.
The open() itself is what exercises access, since sysfs can refuse it in
kernfs even when the mode bits would allow it.

The test works only on Intel platforms with RFIM and needs root for the
read-write attributes, whose write bit is owner-only.

Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
---

Add rfi_disable, ddr_data_rate and rfi_restriction.

 runtest/power_management_tests               |   1 +
 testcases/kernel/power_management/.gitignore |   1 +
 testcases/kernel/power_management/rfim01.c   | 166 +++++++++++++++++++
 3 files changed, 168 insertions(+)
 create mode 100644 testcases/kernel/power_management/rfim01.c

diff --git a/runtest/power_management_tests b/runtest/power_management_tests
index 4da57ee72..d05c95608 100644
--- a/runtest/power_management_tests
+++ b/runtest/power_management_tests
@@ -1,5 +1,6 @@
 #POWER_MANAGEMENT
 high_freq_hwp_cap_cppc high_freq_hwp_cap_cppc
+rfim01 rfim01
 runpwtests03 runpwtests03.sh
 runpwtests04 runpwtests04.sh
 runpwtests06 runpwtests06.sh
diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
index 03f0c83e4..74f6df14f 100644
--- a/testcases/kernel/power_management/.gitignore
+++ b/testcases/kernel/power_management/.gitignore
@@ -1 +1,2 @@
 high_freq_hwp_cap_cppc
+rfim01
diff --git a/testcases/kernel/power_management/rfim01.c b/testcases/kernel/power_management/rfim01.c
new file mode 100644
index 000000000..8c393ce42
--- /dev/null
+++ b/testcases/kernel/power_management/rfim01.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Piotr Kubaj <piotr.kubaj@intel.com>
+ */
+
+/*\
+ * Validate presence and permissions of RFIM attributes.
+ * The kernel exposes the dvfs, fivr and dlvr attribute groups
+ * independently, gated on per-device feature bits, so the test checks
+ * whichever of the three groups the hardware presents.
+ *
+ * Permissions are verified by opening each node: read-only attributes
+ * must accept O_RDONLY and reject a write open, while read-write ones
+ * must accept O_RDWR. For sysfs nodes the mode bits alone are not
+ * authoritative - the kernel can still refuse the open in the file's
+ * own syscall handler - so open() is what actually exercises access.
+ *
+ * The test requires root because the read-write RFIM attributes are
+ * root-owned and created mode 0644, so only the owner holds the write
+ * bit. An unprivileged user could read them but would get EACCES when
+ * opening them O_RDWR, which check_read_write() would misreport as a
+ * failure rather than reflecting the actual access policy. The read-only
+ * attributes are mode 0444 and world-readable.
+ */
+
+#include "tst_test.h"
+
+#define RFIM_ROOT "/sys/bus/pci/devices/0000:00:04.0"
+
+static bool have_dvfs, have_fivr, have_dlvr;
+
+static const char * const fivr_nodes[] = {
+	RFIM_ROOT "/fivr/vco_ref_code_lo",
+	RFIM_ROOT "/fivr/vco_ref_code_hi",
+	RFIM_ROOT "/fivr/spread_spectrum_pct",
+	RFIM_ROOT "/fivr/spread_spectrum_clk_enable",
+	RFIM_ROOT "/fivr/rfi_vco_ref_code",
+	RFIM_ROOT "/fivr/fivr_fffc_rev",
+	NULL
+};
+
+static const char * const ro_dvfs_nodes[] = {
+	RFIM_ROOT "/dvfs/ddr_data_rate_point_0",
+	RFIM_ROOT "/dvfs/ddr_data_rate_point_1",
+	RFIM_ROOT "/dvfs/ddr_data_rate_point_2",
+	RFIM_ROOT "/dvfs/ddr_data_rate_point_3",
+	RFIM_ROOT "/dvfs/ddr_data_rate",
+	NULL
+};
+
+static const char * const ro_dlvr_nodes[] = {
+	RFIM_ROOT "/dlvr/dlvr_hardware_rev",
+	RFIM_ROOT "/dlvr/dlvr_freq_mhz",
+	RFIM_ROOT "/dlvr/dlvr_pll_busy",
+	NULL
+};
+
+static const char * const rw_dlvr_nodes[] = {
+	RFIM_ROOT "/dlvr/dlvr_freq_select",
+	RFIM_ROOT "/dlvr/dlvr_rfim_enable",
+	RFIM_ROOT "/dlvr/dlvr_spread_spectrum_pct",
+	RFIM_ROOT "/dlvr/dlvr_control_mode",
+	RFIM_ROOT "/dlvr/dlvr_control_lock",
+	NULL
+};
+
+static const char * const rw_dvfs_nodes[] = {
+	RFIM_ROOT "/dvfs/rfi_restriction_run_busy",
+	RFIM_ROOT "/dvfs/rfi_restriction_err_code",
+	RFIM_ROOT "/dvfs/rfi_restriction_data_rate_base",
+	RFIM_ROOT "/dvfs/rfi_restriction_data_rate",
+	RFIM_ROOT "/dvfs/rfi_restriction",
+	RFIM_ROOT "/dvfs/rfi_disable",
+	NULL
+};
+
+static bool has_group(const char *name)
+{
+	char path[PATH_MAX];
+	struct stat stats;
+
+	snprintf(path, sizeof(path), "%s/%s", RFIM_ROOT, name);
+
+	if (stat(path, &stats)) {
+		if (errno == ENOENT)
+			return false;
+		tst_brk(TBROK | TERRNO, "stat(%s)", path);
+	}
+
+	if (!S_ISDIR(stats.st_mode))
+		tst_brk(TBROK, "%s exists but is not a directory", path);
+
+	return true;
+}
+
+static void setup(void)
+{
+	have_dvfs = has_group("dvfs");
+	have_fivr = has_group("fivr");
+	have_dlvr = has_group("dlvr");
+
+	if (!have_dvfs && !have_fivr && !have_dlvr)
+		tst_brk(TCONF, "No RFIM attribute groups present under %s", RFIM_ROOT);
+}
+
+static void check_read_only(const char *path)
+{
+	int fd = TST_EXP_FD(open(path, O_RDONLY));
+
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+
+	TST_EXP_FAIL2(open(path, O_WRONLY), EACCES, "%s should reject writes", path);
+}
+
+static void check_read_write(const char *path)
+{
+	int fd = TST_EXP_FD(open(path, O_RDWR));
+
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+}
+
+static void run(void)
+{
+	if (have_dvfs) {
+		tst_res(TINFO, "Checking DVFS");
+		for (int i = 0; ro_dvfs_nodes[i]; i++)
+			check_read_only(ro_dvfs_nodes[i]);
+
+		for (int i = 0; rw_dvfs_nodes[i]; i++)
+			check_read_write(rw_dvfs_nodes[i]);
+	}
+
+	if (have_dlvr) {
+		tst_res(TINFO, "Checking DLVR");
+		for (int i = 0; ro_dlvr_nodes[i]; i++)
+			check_read_only(ro_dlvr_nodes[i]);
+
+		for (int i = 0; rw_dlvr_nodes[i]; i++)
+			check_read_write(rw_dlvr_nodes[i]);
+	}
+
+	if (have_fivr) {
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
