Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67654CA5FCE
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 13:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791206367; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=GPbRRIlXu2oKf1ElXkx1J4+DVfw8bNbhAlyJCrGcrsk=;
 b=kCqQ+VNMK5zP+GDVYV4uT3U+EsKOMfmxZpLbfRUhjzWBMBTVWGzrmyWujmTadjUl9XAGw
 Bxw2cr5rPE2cX3Aq9rHDIBZEdAsvpnp/otupOIh9chiNIT5POr3DUhr4HO+OW19mbUX6Evt
 98Vy/uXClSZtuQFaqwLR0Kqt4Wqx4I4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB8813E52B7
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:19:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7072A3E4E11
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:18:55 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 79BBA200270
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:18:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3Upca5aWCoe4/n1rlG9Hs2T3AEQ1vGbhvuIefIuhhzpx3XUp3FT1a0pZ2LC46NE7ejK12AdX7Wtrfuso+9OKNcK2GfdDuyy9hvysUD+f1r5zXk2NUf84Kj9McWWetU2DAL9zfZtzbr8srzN6Ktqdg4RY1CP70rERJAAHNSQimkVrGOUwxhINSDu2GOzfzwQRwgt0qbeuPq60trQooDOF+R8pG5s+AwF1tVmnvGHT3cdkvR2aDnZqZ8f1zWR7lwzb8Bc+PuAqATOVGkPRlvdTsQYi+++T1fl8lZOdOFAbCiOyhNxEDS+nqNVy2lmYzk3R+ee+Ka68lfJO6KZjIxEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATaIXrir0jCHcBTfiujCaboDPV7g25t5kNxAkO3ulJU=;
 b=KjIk3dRsV4/1vCYSaQR94IQeECVuTrBGVgGoXj1ewIWmvc74WQEulH1iMPYS2LtsZZLE1P6fq9HkRwJq2tgWkafZPpxktGT/RkN5tjgOvSEoVZxU9p9IY9BztDMSTPP6inhIpVH7Pi1eOr6sDm+B3bdyCsYZ+NS8+Fl1t++IEd6+nxa2Df9DUr73LQDsjfIKeLI1o3Ilm6Tz3QKtsSwP5E5nfp9fY44HdI7fdGnvtVktZTufvAU8vQ97DxnvN1PsjZXsB89fzt5e8PjagzNwRsLyIW017w0QB8fFP5eQesu38PTqRR7T0916ONGizgiKDWyA5HyF4iGoQWcY5+KriA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.it smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATaIXrir0jCHcBTfiujCaboDPV7g25t5kNxAkO3ulJU=;
 b=uBDP74X+jtgK9jgaYsbIiAhuQUNiH7I7xMp+zRWheJqMUptZNCue5kEE5x3wxQhzdJHZKWSzlp4gUeFIxB28KlN57RE6Gu58aALdBdF4LBtncNzIGUhj7PgdWMMabxMtNVAwo6U9oM188cHNUFBMDFQGACyIPI0y1uBtqfhzdq4g4H23Ne8sUK968yd+B9ZUQXTNRvzeV/oUX3oAG3tgRvcwzQawRpXY3noixeZm2Sai/rOqsx1YsfbBIHJTKdjgdv0Lmt3cHiu7JkCyFWiDSwPGzaZe83llJ43T0Q1jVjbGRWkw0XysftMxF7xd9vUtq+vZ9ymP/9VVva25nQKUow==
Received: from BN1PR13CA0012.namprd13.prod.outlook.com (2603:10b6:408:e2::17)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 5 Oct
 2026 13:18:48 +0000
Received: from BN1PEPF0001854A.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::d) by BN1PR13CA0012.outlook.office365.com
 (2603:10b6:408:e2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 5
 Oct 2026 13:18:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0001854A.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 13:18:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 06:18:21 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 06:18:21 -0700
To: <ltp@lists.linux.it>
Date: Mon, 5 Oct 2026 06:18:06 -0700
Message-ID: <20261005131807.904833-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854A:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f29bc2a-11ae-4b4a-e223-08df22e330e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|11063799006|260925021911599003|56012099006|10067099003|260925022911599003|260925021311599003|18002099003;
X-Microsoft-Antispam-Message-Info: XGMuPFmfPkJBbzmNSbkK0/qiQHW4bNWo/trLbGiRt2LJ8eLPMswon5I2GeogCLLV6e9smFqVheUvkF5FB849aanuzlWibryB1riuwDdDa1KG7gwRgqn5zS70ncwkIWGB9aGN/ZDVykJT/p/YzkIb2ItOHYxgVvLmnmhc95qP7MKriv/b7nQV73p9vEMOwEU6CO8CzYcxBuGB4nLxi648R5KElah1onPYiEJhhQnAFkTo/yd/UShAJqsdA+DhCxwaqKvWlsSrquJZ1KwgdF9mtD2MvFMVMLs/8EFwlgyZH/yYtcp2nfW0U8CUPzptlxo67J49QoAfisqIFTNJNs+QQaWLdhNSkl9zEaTyjR562HSE8/2vegrhOHzXgs23qpckjTaNqDVPkb453qpWhXdv22MFO0PLBVN5lG0c67HIARnNBbCXTl2T0wDTajb1HH3W9OvrXwG2CvL/WgRlwcbo+h/BR2rBkn5YT7WlCgfe/HYuuw2Cd87dkgLsSOyjNJouybzKHCH08hflnuis/ZZ8NPkHyvmu3kzrgfAkSt8g64SDg+LNNxWi89wuVq5yPLMGcheeUx69tYR93jTpKrwXjNxCRPZqlnFu+5yoeMKaC605sNAUNDojvVD9UD7dSbhN7uOGxYtMA31FWxg8OBYAKm4F4psn7NBX8hnQqz6woa4PSyBWLv0kJMSA2a2vehjH8ZaziuJVP7lQGVBEDvMQiA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(11063799006)(260925021911599003)(56012099006)(10067099003)(260925022911599003)(260925021311599003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nbNx5p71f9M/gqQ/H4rMZFa75unGwtrqcwyG0F0C8FgjeNMKCRYLk98sCcDv+Lg1n4/FFi/lTX9rtNHBh3gjipWwUbP7fyWxc3AlRjyxYeLXb89QfKyr2UYAsmgQOVxV6aM1ube78s+dfxp+kHIUpIT2opsyE7keBoRAtcparVh5GShr+Jri3tGRB8+hpBR41jzaqp2WeD2ve0xwe3CZGsbHBHwP5wDJEqIokUxMK5LbSv76BrK62B04Kj6FLioCX8EVbClErZ40hNpOIPoocd5+g19VEHTqjHuolvsTHJ6ViVqSvdXzASz7mCxzf9sXsO1ZdPxS7ykFnb8lc18CXd43a3v+LAvXFsSW6ffmaWX5mksGMjd0EC/mfriZZWu3NE2CL2mPMLGAim778TsNzSEH5BtUrqz5rJlG/HQoBjFp69EKAnsEPa1+k55Po3sL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 13:18:48.1426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f29bc2a-11ae-4b4a-e223-08df22e330e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] lib: Add tst_ncpus_global()
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
From: Nirmoy Das via ltp <ltp@lists.linux.it>
Reply-To: Nirmoy Das <nirmoyd@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Some CPU-count interfaces follow the calling thread's affinity, which makes
them unsuitable for calculating kernel thresholds that depend on all online
CPUs.

Add tst_ncpus_global(), which counts CPUs in /proc/stat independently of
affinity. Cover it with a self-test that checks the result before and after
pinning to one allowed CPU.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
 include/tst_cpu.h                   |  8 +++
 lib/newlib_tests/runtest.sh         |  1 +
 lib/newlib_tests/tst_ncpus_global.c | 86 +++++++++++++++++++++++++++++
 lib/tst_cpu.c                       | 24 ++++++++
 4 files changed, 119 insertions(+)
 create mode 100644 lib/newlib_tests/tst_ncpus_global.c

diff --git a/include/tst_cpu.h b/include/tst_cpu.h
index dfb155c58..340d0f3c7 100644
--- a/include/tst_cpu.h
+++ b/include/tst_cpu.h
@@ -10,6 +10,14 @@ long tst_ncpus_conf(void);
 long tst_ncpus_max(void);
 long tst_ncpus_available(void);
 
+/**
+ * tst_ncpus_global() - Returns the global online CPU count.
+ *
+ * Return: The global online CPU count reported by /proc/stat, independent of
+ * the calling thread's affinity.
+ */
+long tst_ncpus_global(void);
+
 /**
  * tst_cpu_vendor() - Returns CPU vendor.
  *
diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index 71808ef8b..f53a4fbfc 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -27,6 +27,7 @@ tst_expiration_timer
 tst_filesystems01
 tst_fuzzy_sync0[1-3]
 tst_needs_cmds0[1-36-8]
+tst_ncpus_global
 tst_res_hexd
 tst_safe_sscanf
 tst_strstatus}"
diff --git a/lib/newlib_tests/tst_ncpus_global.c b/lib/newlib_tests/tst_ncpus_global.c
new file mode 100644
index 000000000..d27c7c7d4
--- /dev/null
+++ b/lib/newlib_tests/tst_ncpus_global.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 NVIDIA Corporation
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "tst_cpu.h"
+#include "tst_sysfs_assert.h"
+#include "lapi/cpuset.h"
+
+static cpu_set_t *saved_mask, *single_mask;
+static size_t mask_size;
+static int saved_mask_valid;
+
+static void cleanup(void)
+{
+	if (saved_mask_valid && sched_setaffinity(0, mask_size, saved_mask))
+		tst_res(TWARN | TERRNO, "sched_setaffinity() restore failed");
+
+	if (saved_mask)
+		CPU_FREE(saved_mask);
+
+	if (single_mask)
+		CPU_FREE(single_mask);
+}
+
+static void setup(void)
+{
+	long ncpus = tst_ncpus_max();
+	long cpu;
+
+	saved_mask = CPU_ALLOC(ncpus);
+	single_mask = CPU_ALLOC(ncpus);
+	if (!saved_mask || !single_mask)
+		tst_brk(TBROK | TERRNO, "CPU_ALLOC() failed");
+
+	mask_size = CPU_ALLOC_SIZE(ncpus);
+	if (sched_getaffinity(0, mask_size, saved_mask))
+		tst_brk(TBROK | TERRNO, "sched_getaffinity() failed");
+	saved_mask_valid = 1;
+
+	for (cpu = 0; cpu < ncpus; cpu++) {
+		if (CPU_ISSET_S(cpu, mask_size, saved_mask))
+			break;
+	}
+
+	if (cpu == ncpus)
+		tst_brk(TBROK, "Affinity mask contains no CPUs");
+
+	CPU_ZERO_S(mask_size, single_mask);
+	CPU_SET_S(cpu, mask_size, single_mask);
+}
+
+static void run(void)
+{
+	long before, after;
+	int expected;
+
+	if (TST_SYSFS_ASSERT_PARSE_LIST(&expected, NULL,
+					 "/sys/devices/system/cpu/online"))
+		return;
+
+	if (!expected)
+		tst_brk(TBROK, "No online CPUs found in sysfs");
+
+	if (sched_setaffinity(0, mask_size, saved_mask))
+		tst_brk(TBROK | TERRNO, "sched_setaffinity() restore failed");
+
+	before = tst_ncpus_global();
+
+	if (sched_setaffinity(0, mask_size, single_mask))
+		tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");
+
+	after = tst_ncpus_global();
+
+	TST_EXP_EQ_LI(before, expected);
+	TST_EXP_EQ_LI(after, expected);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};
diff --git a/lib/tst_cpu.c b/lib/tst_cpu.c
index 776801291..241bd3347 100644
--- a/lib/tst_cpu.c
+++ b/lib/tst_cpu.c
@@ -24,6 +24,7 @@
 #include "test.h"
 #include "tso_safe_macros.h"
 #include "tso_safe_file_ops.h"
+#include "tso_safe_stdio.h"
 
 long tst_ncpus(void)
 {
@@ -99,6 +100,29 @@ long tst_ncpus_available(void)
 #endif
 }
 
+long tst_ncpus_global(void)
+{
+	FILE *fp = SAFE_FOPEN(NULL, "/proc/stat", "r");
+	char line[BUFSIZ];
+	long count = 0;
+
+	while (fgets(line, sizeof(line), fp)) {
+		if (line[0] == 'c' && line[1] == 'p' && line[2] == 'u' &&
+		    line[3] >= '0' && line[3] <= '9')
+			count++;
+	}
+
+	if (ferror(fp))
+		tst_brkm(TBROK | TERRNO, NULL, "fgets(/proc/stat)");
+
+	SAFE_FCLOSE(NULL, fp);
+
+	if (!count)
+		tst_brkm(TBROK, NULL, "No online CPUs found in /proc/stat");
+
+	return count;
+}
+
 const char *tst_cpu_vendor(void)
 {
 	static char cpu_vendor[16];

base-commit: dca9f0d272b2923256852fc37abd222b533d91e0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
