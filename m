Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B050CA5FD4
	for <ltp@archiver.kernel.org>; Fri,  2 Oct 2026 13:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790947243; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=7VdUDaIq8HrpvHihDy0c9QViKXGWdbC8+Th3Ylt4OUY=;
 b=rqxa/agmvHwKJvu/YbSP+WC3OCpGegaA10BMPfp3CvnYKfZ3IDaZyQUrZVkZzfd78eim/
 9xwnpYWrIxXhqAndTQQIa2HsFSdxKUGhPqvV+vFfVlSuPaC5KZI2XZW4rSQ3kfC5J180DKj
 hcvPxI0ukHjvios3xj95Zyj4hzFLYYg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BFBE3E6B7D
	for <ltp@archiver.kernel.org>; Fri,  2 Oct 2026 15:20:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D4FE3C0224
 for <ltp@lists.linux.it>; Fri,  2 Oct 2026 15:20:24 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 37A622001A8
 for <ltp@lists.linux.it>; Fri,  2 Oct 2026 15:20:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXkB4Q7ZFQIafyu8DHTODUGjWX+gkFh5LG6KROKH/4eLR4c98TzOatpFaXi5A3Hw6OwQ0OHZKX/sNWHDb6vB6dDU43W49NrSgT4dqLdOKSkDk77PDg4y7ZzXgNLY6e3fovjVAxe7lJSmkZo6q2Ss0DOTj+KpqIlTi7JHNihXM4mxsjBsO/KfBx03xCok7yq0iRJJj1ycnXTXZQ6wMPuBcOXUew3yGl7EGTDPisCqUrU6eQaqn9wRBr1HYd6bTZpab9Bnu0XybIfCDvw9qMPXJDe3xkpem2/bVvPIWwIED4x5k3GdVezzRSB2HaTtasUPIC5efznxMbZdiz16ZoRiCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Uc4XxUb9gbd9H0A9WTirDOcKui4wdoAXgzfGji/g74=;
 b=oDM4+/lqGd1TwV4GB7yo2M0qMlpGGd2JT5qPkLLbrVCaHMqGRrjDlMLpS3slSXIC5t6G+HgjzSq7th2QjfAFOgKFi7FoQT4OIan0vOxIM96sT3UtRRqqKZbPRmnaREpoOonAkC/xLd7nvcyVURXt5YJUqDSIJyg0U8+6q0pbk1Qzaa8gF5R5Mkg+GKJQDN9ZVT+UiznOhwBEqVYnWrNcd/otVvWradD/NiqCynaZpntNU6MYbQBJs9/rIUjaBPA+Ujz+X6PQ6q7DSSdCCdG9Z1g8vR1wPVQVWeYTzFaU1OqmL+wDwtadyryDlslcoNn8yffXy1qyzw07U27mXq6O1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.it smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Uc4XxUb9gbd9H0A9WTirDOcKui4wdoAXgzfGji/g74=;
 b=VURYpBuvVM/QPac1DFAaO/BM38giEod+7PFOS8VX9U5adGJj02YaWH7VCtGIkK/VOVmrdXmQEz6nCVDc8idbRLt7f6sXNdJXBnlx+AQxNCk/9Aym444BCA+duGax3QiIzMouvLaq/HSvxfAMy2dcSkV5wN+H8aKNubmhdDTcS53/8ecAOiv0xc+c3z+FaR/u1Anyl5DhST/mQsgfZf9kdLiDWFMB/i7T4ydgNFftanbux/Bh/cOfB0zbpxdRaIw6iuUQbMo/LDeirVAOs4wkNDu0JJPHbBTb3ClncRzz/OUFCWCtofKR34Ofyb1HQ79gqCLuwghklKOIOS7furKExw==
Received: from SJ0PR03CA0228.namprd03.prod.outlook.com (2603:10b6:a03:39f::23)
 by SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Fri, 2 Oct
 2026 13:18:03 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::55) by SJ0PR03CA0228.outlook.office365.com
 (2603:10b6:a03:39f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 13:18:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 13:18:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 06:17:35 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 06:17:35 -0700
To: <ltp@lists.linux.it>
Date: Fri, 2 Oct 2026 06:17:17 -0700
Message-ID: <20261002131717.1118384-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: d506ba1c-ab49-4065-67d1-08df208796d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|260925022911599003|260925021311599003|11063799006|260925021911599003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: aONyI+QZmrUT54YbS1zvCO3koEaVRRR1xa4HtpcDqHBehenxpp4zaQ8yBE6E8+L7e0o4HumDdWyn7I2tBqB65VtDe4OYPqo1qIZpnxyrnJ81ViToFmqzzFVIO5L6yg/QT/LdXWe9U5UEOAFH773Oyt8kANt0wDi8tLiuYq7j2zVI0S3AFOHzDw5xnNMVLEyl8AE4tK+tYW8mfNaCybtd9OALRphCl2uMvp4N+ZoUAlAEfZkIgq1wWwTlYxCjMYvuyM+JLTIsRIIGDMjQ4+kQh4SSkiZF5glC6bLywFqM+lkBeJjfJ8mypOBP2eg5ihOX4p6+e8QnsQOA+//ApHJTZi81FECO68xreJnEj6VsGWL2xvOzzZ5PtE0Lx+K8X97adH9ILRvknYvFTskq37Yu+v6bF22br3bTa+WExd9QWIIs7iKhfIb9i6iKtm/mWp8zfmKfDHtU575vnr2ZarTefO/VGvth0cS1hhw7OdGk8C7I/wm8J2BcyD8v05Izj7ogBLfsFIt5gxApuFXoYZ02uXkBOTCRtJTHK53eVwLO3iqgmPbYyNj7T3xKlYC8pUJNY8Hk2Ar4L2bPUKc3TNpy8yHtZ1nV/IgVGWxHpeswxyifjmaRSkJy7offfb882hii+VynkSgjCF4jCVee1ryupIwLDkeDVUhjjsaax2t2ggm8XJuB864+1GBGj4mhC2JTCYV3PwlmiARD/bMZFRzDdQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(260925022911599003)(260925021311599003)(11063799006)(260925021911599003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: odPBv+XnQ3ENEmEXsQ0VbeZQCakwD/s3ry+AuIx8Hm3fGCaPLKPWRSdVDgxN5CduQ2NddloCM5wu4pQSVpjZlqFfpd/4RL8A24XjuYrdpFag7MHX6SDXlPnHczhOPTCzr3TbWCct/OL6pkRkvSCHgpb+uLQviXbcI9GnCKAJsAZqHKCfJxkbVme2hteIDLoYeNYE9ydlEa3+/IPVfy3ESXoiyqn1b3tLhAJGzShXm49404l7tIPSCuCOY2EP4bFE7gGZg9UQNur/BISVvaHK2BElHfaKNNeW9Xn1b2HpMTJXVcnGMG37aAYx/Swv145/XxNOe9H5Qim+yciYZD+ZdrKfwhcfqTFiPxMdObW2u9dSHMVnJms0I+ChcGzSaL+xofeVy4pKWgN97mskkEmBr4/56vVqVy9EIrBeD/8/5g4bn3d+sXCYq7OltBNwyTY8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:18:03.2492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d506ba1c-ab49-4065-67d1-08df208796d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] getrusage03: account for percpu RSS counter
 batching
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
Cc: Nirmoy Das <nirmoyd@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

After f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter"),
the fixed 20 MiB tolerance can be too small on large systems. Pinning
limits pending RSS updates to one CPU, but that CPU can still hold one
batch outside the fast RSS read.

Pin the test to its current CPU and allow one batch of lower-side slack
for the 100, 300 and 400 MiB allocation checks. Keep the existing upper
and inheritance tolerances, and skip if one batch is at least 100 MiB.

On 352 CPUs with 64 KiB pages, one batch is 44 MiB. Pinning alone
reported 270336 KiB for the 300 MiB check, outside the 20 MiB tolerance.
The updated test passed 10/10 runs on the 352-CPU Vera system.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Co-developed-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
Assisted-by: ClaudeCode:claude-opus-5-5
Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
Changes in v3:
- Use tst_ncpus() and pin to the current CPU (Cyril).
- Allocate the CPU mask dynamically and log the allowance.

v2: https://lore.kernel.org/ltp/20260902160113.1207205-1-nirmoyd@nvidia.com/

 .../kernel/syscalls/getrusage/getrusage03.c   | 87 +++++++++++++++----
 1 file changed, 71 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index a2cdd6158..6beae130d 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -13,22 +13,88 @@
  * this program.
  */
 
-#include <stdlib.h>
+#define _GNU_SOURCE
 #include <stdio.h>
+#include <stdlib.h>
 
 #include "tst_test.h"
+#include "lapi/cpuset.h"
+#include "lapi/sched.h"
 #include "getrusage03.h"
 
 #define TESTBIN "getrusage03_child"
 
 static struct rusage ru;
 static long maxrss_init;
+static long lower_allowance;
 
 static const char *const resource[] = {
 	TESTBIN,
 	NULL,
 };
 
+/*
+ * Pin the test to the CPU it runs on. Every forked or exec'd child inherits
+ * the affinity, so only that CPU can hold RSS counter updates outside the
+ * fast percpu_counter read.
+ */
+static void pin_to_current_cpu(void)
+{
+	unsigned int cpu;
+	cpu_set_t *set;
+	size_t size;
+
+	if (getcpu(&cpu, NULL))
+		tst_brk(TBROK | TERRNO, "getcpu() failed");
+
+	set = CPU_ALLOC(cpu + 1);
+	if (!set)
+		tst_brk(TBROK | TERRNO, "CPU_ALLOC() failed");
+
+	size = CPU_ALLOC_SIZE(cpu + 1);
+	CPU_ZERO_S(size, set);
+	CPU_SET_S(cpu, size, set);
+	if (sched_setaffinity(0, size, set))
+		tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");
+
+	CPU_FREE(set);
+	tst_res(TINFO, "Pinned to CPU %u", cpu);
+}
+
+/*
+ * The pinned CPU can still hold up to one percpu_counter batch,
+ * max(32, 2 * online CPUs) pages, outside the fast RSS read. Count CPUs
+ * before pinning because some libc implementations count only the affinity
+ * mask.
+ */
+static void setup(void)
+{
+	long online_cpus = tst_ncpus();
+	long batch = MAX(32L, online_cpus * 2);
+	long page_size = SAFE_SYSCONF(_SC_PAGESIZE);
+	long batch_kib = batch * page_size / 1024;
+
+	lower_allowance = MAX(20 * 1024L, batch_kib);
+	if (lower_allowance >= 102400L)
+		tst_brk(TCONF, "Per-CPU RSS allowance is too large: %li KiB",
+			lower_allowance);
+
+	tst_res(TINFO, "%li online CPUs, lower RSS allowance %li KiB",
+		online_cpus, lower_allowance);
+
+	pin_to_current_cpu();
+}
+
+static void check_maxrss(long actual, long expected, const char *name,
+			 const char *size)
+{
+	if (actual >= expected - lower_allowance &&
+	    actual <= expected + DELTA_MAX)
+		tst_res(TPASS, "%s ~= %s", name, size);
+	else
+		tst_res(TFAIL, "%s = %li, expected %li", name, actual, expected);
+}
+
 static void inherit_fork1(void)
 {
 	SAFE_GETRUSAGE(RUSAGE_SELF, &ru);
@@ -51,11 +117,7 @@ static void inherit_fork2(void)
 {
 	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
 
-	if (is_in_delta(ru.ru_maxrss - 102400))
-		tst_res(TPASS, "initial.children ~= 100MB");
-	else
-		tst_res(TFAIL, "initial.children = %li, expected %i",
-			ru.ru_maxrss, 102400);
+	check_maxrss(ru.ru_maxrss, 102400, "initial.children", "100MB");
 
 	if (!SAFE_FORK()) {
 		SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
@@ -78,11 +140,7 @@ static void grandchild_maxrss(void)
 	tst_reap_children();
 	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
 
-	if (is_in_delta(ru.ru_maxrss - 307200))
-		tst_res(TPASS, "child.children ~= 300MB");
-	else
-		tst_res(TFAIL, "child.children = %li, expected %i",
-			ru.ru_maxrss, 307200);
+	check_maxrss(ru.ru_maxrss, 307200, "child.children", "300MB");
 }
 
 static void zombie(void)
@@ -106,11 +164,7 @@ static void zombie(void)
 
 	tst_reap_children();
 	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
-	if (is_in_delta(ru.ru_maxrss - 409600))
-		tst_res(TPASS, "post_wait.children ~= 400MB");
-	else
-		tst_res(TFAIL, "post_wait.children = %li, expected %i",
-			ru.ru_maxrss, 409600);
+	check_maxrss(ru.ru_maxrss, 409600, "post_wait.children", "400MB");
 }
 
 static void sig_ign(void)
@@ -174,6 +228,7 @@ static void run(unsigned int i)
 static struct tst_test test = {
 	.forks_child = 1,
 	.child_needs_reinit = 1,
+	.setup = setup,
 	.resource_files = resource,
 	.min_mem_avail = 512,
 	.tags = (const struct tst_tag[]) {

base-commit: dca9f0d272b2923256852fc37abd222b533d91e0
-- 
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
