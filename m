Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949FEC624D4
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 16:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788364941; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Piepbhfuqx4hp2U9ddmY0yHAgI2pInjzfbc3OyLeSio=;
 b=FtzDWMslsenhHvGX/qWrPNkrZUHaegt5Fh+9+VCXTGiy0QTykoXGMnHgwW5TtZfD72+1a
 tKfrQMh/63bvJoqvcCJdvlPhqyzVY0oIF5b26bDWHfppkxBNhWGA0MGnxltNjnkjzm9r8f8
 CGYr7uddmU8Lm70u2DOtp66NNnf2W3Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D5B43E93BE
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 18:02:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 806853E23F2
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 18:01:59 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 60D231000910
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 18:01:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zn0axzSrkS51ddh6GVP+G3nkpob4BkNCBla3Ny9L/4Nzs6cDdg2ZTyB5yB2mb7TInWN3eztdhlA7orgWHef0hLoaLo/t+8iOfQfsU/YlnbcbZW8ROyBKW4M89cOYmwB34WK6ee2puOS2iUGex3x+MDZbYIZhSyFBXq7GeTxmm7PwGpBCXtr7AgHKOMm+osw/UVE2ZXxeMbA3bNLwJr3ERqIg0x5jBgZLSAw+6MsmzadlFdHsbtOiYK7h/tDT6iTNfu7dZg8aqksW7cmY0tzMDT6Ei+RfpLbexGpz5qJs1OVzQq+z9XkbIGJxEXrrK035ME/xVLooare+CGD/GjU+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEziUA8l8Vkm0qq9ybYadYLbnAGRGZ0Vq9XJ/yY19/M=;
 b=urhn5o8qU4pzeKoOoV/N2eIDgzsEC1WyqzaMOIovrYjJU0xdFffUhxDOdTYkmO785ynLTJdBTk2HFS1OflZjnbbB6RlLGoSxk79fs1YWhqPlTxGaCsSafbPQFf6iIOW1EqH8U054sGMoDyuit+lqEYXro8U3AsNpPVVqgOYVfvKhgTGiPxEKGmtQFO8sZQIDj7B060FgFE3+0k6VyH8sYIqDiik6jctb3N3393OPyzUnufG2j3ZIyDjj2irKkpZAxxhspX0iEvw+KqqpGaO41qRZR8RDp7DjRUjmQxMuUsH+Nfy9onu6S8VfkC/KuNxvUjOH7UVYDbiaAmOvocyFxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.it smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEziUA8l8Vkm0qq9ybYadYLbnAGRGZ0Vq9XJ/yY19/M=;
 b=S6Ro3jQQagmtNL6LYeo+zIIXFAz+TsUuTKqOBa4kuJcKtFBZ7v8LzmBEgJykyktz1lsreb4nlqRHMJC/zIdAkA7Vr4NfFBrFDEftklzJUNfaqviPmTdx49iGf4leutmHDRn3LS+eD+QRmUa6fLqQO16NvrZfmrjOAfIlHnxPX2/Ah9oKkm7PJDWacHBtYcxBRtnqbU0D07hEgAj44BiQQn1fh5kCfS21IlPnPnQKh1xNe9pIhpfhtn3/gGH9PHOuiNBzCEerjQHoAaDoD/qLVFJd4tjXbLlralUskbiv7Mgnh20movbw0/cq34XWVBOCCsFijd3+BbyDPsY1IODgJw==
Received: from CH5P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::20)
 by IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 2 Sep 2026
 16:01:44 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::9f) by CH5P222CA0019.outlook.office365.com
 (2603:10b6:610:1ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 16:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 16:01:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 09:01:14 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 09:01:13 -0700
Received: from 82875d6-lcedt.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 09:01:13 -0700
To: <ltp@lists.linux.it>
Date: Wed, 2 Sep 2026 09:01:13 -0700
Message-ID: <20260902160113.1207205-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <apgVur5s_potD6ND@yuki.lan>
References: <apgVur5s_potD6ND@yuki.lan>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|IA0PR12MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: db1bd55d-b4c9-4e22-415b-08df090b7ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wa8a7LoV1lOqAra+QotWfaOLk59K8M6+wYcFfI/mItuBjr1idGHIsKbwnk4ohAI5aDuxv8MUm+bKRdDmiGY1LaN9036anEnf16c0MVhXPKa3m3hG6J9CNZehhN8MRevAOXEoSMKwGVUQXUxcRaXkPiFXhYwkxgcGNUysy7g98e/Mde41wOblsGdJWQaAqhKAH9y/0iwgtLXCxy2Nu6eGBEA0FTIU1eM2mlHxEEqc4456KQ8jsqUNZAiFjBDeeX85jaVwnGptjvAcBjiFfmYlXuqavd1RBAHtQnKDDMyIRXTgDaGYnIzupbnThy4zq1aVowzGS+cAyBiJjx1F9reuc6NSAx4O+rbFQwvlv6uHU1Y69Pi9ADGMkjQKpwptXo4ZL355hc/uTZknf0W4ifak1xM4XaahQsGejKGjIYgVpOSZBjRmGuO1bPa1rWfKWzyOSwwj+x9v4bkI9V9IBbzP1LQhOs5BNPUpAxuS87m5jAaJm6VlWZlhV0TaxekriljXSrl0PnFQo9g6gJHBgfogotWzUGu/e5WzfYsunpETEGWx41aAMCTDCRXhB06gHM8yREMlafusC2cvsKDyhlq7/dY8guXqyGMXSQj6G6NNEBMdiiRXz2QKBKv9BynUOG+VDs9zEgHcIjmEtLf0yneA1or6pRDgAziRseZvKy9zd/UsLfRzct2Ml76qQ3YQhbsUV7L1DifONHGZBhgSmm8FvQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oS/cT//1JhWNUprCc7mw7uryvtL+fllYpGE0LTn1UFnW/cnKsqISdh0ilb7Ho0XAV6NgQ7xcxbTFI/q8J/gqdP2UT3cG0jD7Cn34tKPLF30oPMm2A3pBDLmJMMLT7qIZ/zRkE7nNrme6lZzpsE8OarTdJomNVXfHIEQUqzGoZfycLeshQcfzbJmG6263MP7zR8GacOikVTtIrOj9F+LXwo0hhzFFrcZIEwLQaAOAa5RxkxlMotvqY6lqfyUHU3YczlgfgapDoobTsPCsxF7UR+HZoXyw5YGHl8WZJbG/EaVumXUeqyc8rjBZ3DmFH7nM5wswqiDl0157cEvevwEFJNAPvhxDaV/ySjAgaNop0rM2nJJeuahcGLgwM3cGAWB/lxHp8Iup1+mQsg5v2j1IHHS5BKPWEalSPjUs81/r0E9E8p2izhhAdPlxLHVRycRy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 16:01:41.9792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db1bd55d-b4c9-4e22-415b-08df090b7ae9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8746
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] getrusage03: account for percpu RSS counter
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

getrusage03 allows ru_maxrss to differ from the expected value by a
fixed 20 MiB. That can be too small on large systems after Linux commit
f1a7941243c1, which converted mm RSS stats into percpu_counter.

Pin the whole test to one CPU during setup, before it forks or execs any
children. Every descendant inherits the affinity, which removes task
migration as a multiplier. One CPU can still retain almost one batch of
the deliberate anonymous allocation outside the fast RSS read.

Use one batch only as lower-side slack for the 100, 300, and 400 MiB
allocation checks. Preserve the fixed 20 MiB tolerance for their upper
side and for all inheritance comparisons. Count online CPUs from
/proc/stat because some libc implementations report only the calling
task affinity. Skip the suite if one batch is at least the smallest
100 MiB allocation and would make that signal non-discriminating.

On a 352-CPU arm64 system with 64 KiB pages, a batch is 704 pages
(44 MiB). With only the pin and fixed 20 MiB tolerance, the 300 MiB
case returned 270336 KiB instead of 307200 KiB and failed 10/10 runs.
The one-batch lower allowance passed 10/10 runs.

Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
Changes in v2:
- Pin the whole test once in setup so every fork and exec descendant
  inherits the singleton CPU affinity.
- Keep one batch only as lower-side slack for the deliberate allocation
  checks; pinning with the fixed 20 MiB tolerance failed 10/10 runs on
  the 352-CPU, 64 KiB-page system.
- Count kernel-wide online CPUs independently of task affinity and skip
  when one batch would make the smallest RSS signal non-discriminating.

 .../kernel/syscalls/getrusage/getrusage03.c   | 110 +++++++++++++++---
 1 file changed, 95 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index a2cdd6158..38a100576 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -13,9 +13,13 @@
  * this program.
  */
 
+#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
 
+#include "lapi/cpuset.h"
+#include "tst_safe_stdio.h"
+#include "tst_cpu.h"
 #include "tst_test.h"
 #include "getrusage03.h"
 
@@ -23,12 +27,99 @@
 
 static struct rusage ru;
 static long maxrss_init;
+static long lower_allowance;
 
 static const char *const resource[] = {
 	TESTBIN,
 	NULL,
 };
 
+static long count_online_cpus(void)
+{
+	FILE *fp = SAFE_FOPEN("/proc/stat", "r");
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
+		tst_brk(TBROK | TERRNO, "fgets(/proc/stat)");
+
+	SAFE_FCLOSE(fp);
+
+	if (!count)
+		tst_brk(TBROK, "No online CPUs found in /proc/stat");
+
+	return count;
+}
+
+static void pin_to_cpu(void)
+{
+	long ncpus = tst_ncpus_max();
+	size_t size = CPU_ALLOC_SIZE(ncpus);
+	cpu_set_t *mask = CPU_ALLOC(ncpus);
+	int cpu = -1;
+
+	if (!mask)
+		tst_brk(TBROK | TERRNO, "CPU_ALLOC()");
+
+	CPU_ZERO_S(size, mask);
+	if (sched_getaffinity(0, size, mask) < 0) {
+		CPU_FREE(mask);
+		tst_brk(TBROK | TERRNO, "sched_getaffinity()");
+	}
+
+	for (long i = 0; i < ncpus; i++) {
+		if (CPU_ISSET_S((int)i, size, mask)) {
+			cpu = (int)i;
+			break;
+		}
+	}
+
+	if (cpu < 0) {
+		CPU_FREE(mask);
+		tst_brk(TBROK, "sched_getaffinity() returned an empty CPU mask");
+	}
+
+	CPU_ZERO_S(size, mask);
+	CPU_SET_S(cpu, size, mask);
+	if (sched_setaffinity(0, size, mask) < 0) {
+		CPU_FREE(mask);
+		tst_brk(TBROK | TERRNO, "sched_setaffinity()");
+	}
+
+	CPU_FREE(mask);
+}
+
+static void setup(void)
+{
+	long online_cpus = count_online_cpus();
+	long batch = MAX(32L, online_cpus * 2);
+	long page_size = SAFE_SYSCONF(_SC_PAGESIZE);
+	long batch_kib = batch * page_size / 1024;
+
+	lower_allowance = MAX(20 * 1024L, batch_kib);
+	if (lower_allowance >= 102400L)
+		tst_brk(TCONF, "Per-CPU RSS allowance is too large: %li KiB",
+			lower_allowance);
+
+	pin_to_cpu();
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
@@ -51,11 +142,7 @@ static void inherit_fork2(void)
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
@@ -78,11 +165,7 @@ static void grandchild_maxrss(void)
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
@@ -106,11 +189,7 @@ static void zombie(void)
 
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
@@ -174,6 +253,7 @@ static void run(unsigned int i)
 static struct tst_test test = {
 	.forks_child = 1,
 	.child_needs_reinit = 1,
+	.setup = setup,
 	.resource_files = resource,
 	.min_mem_avail = 512,
 	.tags = (const struct tst_tag[]) {

base-commit: 12724413534a6d4160ff9694ba6f09daa4ccb6bd
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
