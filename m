Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F87C43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 14:40:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 257083E5CE6
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 16:40:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4FAF53E2972
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 16:40:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F29112001A7
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 16:40:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783521612; x=1815057612;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dT0VohnoXpmNt1BEcbWGswlZVMnKRkVYxrRoSumm/44=;
 b=LdGtpMCSmnLUt4QmjDyM4f7l4GV7CjN6y0I3Po6bHF6hmlHKAgDQsTFB
 2uxAxgOLDqc/HQ7P7/bNNDCVhhWbMjInmL1Iml0A1BYwHLXjzb9tNxo8p
 8+t1UBsbIgoeRGLgrcUTqWODo9hP6NkoMAHb8qebb9NKwPRGScy0xRiEe
 bs3bl2laHFh692oVDkxAdiyOydn93eA4wA5h24+Po5Ncyyz6StYcwB30Y
 fvlQ7W1dzPwSULK6SsIwkHHWFcq1X8XBpUO2BTcbBO7k7ClfXQDfQFW65
 7UcYLibTl6R3+1yTMIZg9cuu5MzuwKAclyUYj8I2CvqXz461K89ZCMa9H A==;
X-CSE-ConnectionGUID: bbiUQVB4SJ6SAjj63+2gWA==
X-CSE-MsgGUID: BX5QuxqQS7+8EnMsYCLOzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84375746"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84375746"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 07:40:10 -0700
X-CSE-ConnectionGUID: tvqAt6LYRHSsSog9yHsAyQ==
X-CSE-MsgGUID: qpVqbANtTXSEw56ErzI+tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="249864998"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO intel.com)
 ([10.245.246.134])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 07:40:08 -0700
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Wed,  8 Jul 2026 16:39:34 +0200
Message-ID: <20260708143934.118490-2-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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
Correct comment according to bot review.

 runtest/power_management_tests               |   1 +
 testcases/kernel/power_management/.gitignore |   1 +
 testcases/kernel/power_management/rfim01.c   | 151 +++++++++++++++++++
 3 files changed, 153 insertions(+)
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
index 000000000..9388dd2f6
--- /dev/null
+++ b/testcases/kernel/power_management/rfim01.c
@@ -0,0 +1,151 @@
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
+ * own syscall handler - so :manpage:`open(2)` is what actually
+ * exercises access.
+ *
+ * The test requires root because the read-write RFIM attributes are
+ * root-owned and created mode 0644, so only the owner holds the write
+ * bit. An unprivileged user could read them but would get EACCES when
+ * opening them O_RDWR, which the read-write check would misreport as a
+ * failure rather than reflecting the actual access policy. The read-only
+ * attributes are mode 0444 and world-readable.
+ */
+
+#include "tst_test.h"
+
+#define RFIM_ROOT "/sys/bus/pci/devices/0000:00:04.0"
+
+enum rfim_group {
+	GROUP_DVFS,
+	GROUP_FIVR,
+	GROUP_DLVR,
+};
+
+static const char * const group_name[] = {
+	[GROUP_DVFS] = "dvfs",
+	[GROUP_FIVR] = "fivr",
+	[GROUP_DLVR] = "dlvr",
+};
+
+static bool have_group[ARRAY_SIZE(group_name)];
+
+static struct tcase {
+	const char *path;
+	const bool write;
+	enum rfim_group group;
+} tcases[] = {
+	{ RFIM_ROOT "/fivr/vco_ref_code_lo", 1, GROUP_FIVR },
+	{ RFIM_ROOT "/fivr/vco_ref_code_hi", 1, GROUP_FIVR },
+	{ RFIM_ROOT "/fivr/spread_spectrum_pct", 1, GROUP_FIVR },
+	{ RFIM_ROOT "/fivr/spread_spectrum_clk_enable", 1, GROUP_FIVR },
+	{ RFIM_ROOT "/fivr/rfi_vco_ref_code", 1, GROUP_FIVR },
+	{ RFIM_ROOT "/fivr/fivr_fffc_rev", 1, GROUP_FIVR },
+
+	{ RFIM_ROOT "/dlvr/dlvr_freq_select", 1, GROUP_DLVR },
+	{ RFIM_ROOT "/dlvr/dlvr_rfim_enable", 1, GROUP_DLVR },
+	{ RFIM_ROOT "/dlvr/dlvr_spread_spectrum_pct", 1, GROUP_DLVR },
+	{ RFIM_ROOT "/dlvr/dlvr_control_mode", 1, GROUP_DLVR },
+	{ RFIM_ROOT "/dlvr/dlvr_control_lock", 1, GROUP_DLVR },
+	{ RFIM_ROOT "/dlvr/dlvr_hardware_rev", 0, GROUP_DLVR },
+	{ RFIM_ROOT "/dlvr/dlvr_freq_mhz", 0, GROUP_DLVR },
+	{ RFIM_ROOT "/dlvr/dlvr_pll_busy", 0, GROUP_DLVR },
+
+	{ RFIM_ROOT "/dvfs/rfi_restriction_run_busy", 1, GROUP_DVFS },
+	{ RFIM_ROOT "/dvfs/rfi_restriction_err_code", 1, GROUP_DVFS },
+	{ RFIM_ROOT "/dvfs/rfi_restriction_data_rate_base", 1, GROUP_DVFS },
+	{ RFIM_ROOT "/dvfs/rfi_restriction_data_rate", 1, GROUP_DVFS },
+	{ RFIM_ROOT "/dvfs/rfi_restriction", 1, GROUP_DVFS },
+	{ RFIM_ROOT "/dvfs/rfi_disable", 1, GROUP_DVFS },
+	{ RFIM_ROOT "/dvfs/ddr_data_rate_point_0", 0, GROUP_DVFS },
+	{ RFIM_ROOT "/dvfs/ddr_data_rate_point_1", 0, GROUP_DVFS },
+	{ RFIM_ROOT "/dvfs/ddr_data_rate_point_2", 0, GROUP_DVFS },
+	{ RFIM_ROOT "/dvfs/ddr_data_rate_point_3", 0, GROUP_DVFS },
+	{ RFIM_ROOT "/dvfs/ddr_data_rate", 0, GROUP_DVFS },
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
+	bool any = false;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(group_name); i++) {
+		have_group[i] = has_group(group_name[i]);
+		any |= have_group[i];
+	}
+
+	if (!any)
+		tst_brk(TCONF, "No RFIM attribute groups present under %s", RFIM_ROOT);
+}
+
+static void run(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	if (!have_group[tc->group]) {
+		tst_res(TCONF, "%s: %s group not present", tc->path,
+			group_name[tc->group]);
+		return;
+	}
+
+	if (tc->write) {
+		int fd = TST_EXP_FD(open(tc->path, O_RDWR));
+
+		if (fd != -1)
+			SAFE_CLOSE(fd);
+	} else {
+		int fd = TST_EXP_FD(open(tc->path, O_RDONLY));
+
+		if (fd != -1)
+			SAFE_CLOSE(fd);
+		TST_EXP_FAIL2(open(tc->path, O_WRONLY), EACCES, "%s should reject writes", tc->path);
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
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run
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
