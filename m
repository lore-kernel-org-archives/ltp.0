Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEB0CA5FF0
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 13:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791206386; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=jeoI/vMSTfob3cBndG8l3gQZzp6mUMP8eElAnqV8llE=;
 b=WBQm1q9ArSGwwOEju4JwX/BgnhUqS/r0L+6zixth0jJDnE9adB6GWJhMISKG11QtWcFJb
 I45OcToQ0Q4Uq7kiglPizGI9Fiv02o48iP4mVNKULBc/TWo4EHBNzlVqLJnf0ypKlr3SfBv
 eXn7cT3VYq4cZ/aO8xBsDZnQWTdcpAA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F1E23E4E41
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:19:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3E2B3E4B88
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:19:02 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0887D6007AE
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:19:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9fDlF6T7LgNH04YZQmn3VTPWBrMigz5B8hM5USfb5BDqOkYgU+TKZmd/eWRyXKZwY7TqqAZkmxyLOE1Ji5rG2W86WaUKdX+RC1NkxwS8WNsjdL/qknnLjNy4QNzvG+EPT28x5V8cw0zUshBEPlqASOp97V/ZSaV/2pBHTFhLcDcJ7xflGEcL9wszekz24+SOTztIpsRpVyoyzTZ7r/14d6jp0wUCZF5VrlPhBjPDDoUPgOaOaQRES468L/TGVRKCvZZ1sowylt8IT4cvkC4cAxSXOEj/YOC+g3rt9wP5f5+LOd9GYxzEU5sa/mS3oqk7xv01jQabjSctaYZbdy1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQdVhoVAQGlh50WSqIWSxOyt5cm4/zCYSfeXOW21DT4=;
 b=nDrGzSSxHq27RkE4JLhWnNprEHMII6nDfhc4avWFs4aUKHqu/mQWwpgzw3xvwYamGx+QNhMnGtk3VItcQaNVmM2UUlBf3PQcncem052MGsAaaM97pXMbpkOslmxUC/+fk62cWCKEvS7a0BGi8rnA95CQrQsr8fQZ0/OrCMxmwVmC09Q9iHvWdtelZaa5wA9TtPvUJ3/pokuGdEYSiGTBsVdgZOV0w3PEX/2RpDeltZ0fQsr0hVeXettyWvQPf6iQRLXQLmI1anb1+Nfov5vnWnoHZZtHfZ/wLR27NYRfHDuhRjSc47ML9HAbKP5bTT9QruR7YyiE5+Nd488Yoyd6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.it smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQdVhoVAQGlh50WSqIWSxOyt5cm4/zCYSfeXOW21DT4=;
 b=ZICMqcQLxJavU0AD1L8+7FGeBE93bIExLN4YzN3692ciIpwW1gX13piPNqVMyrm6ieCpNrqgRknvJlExdBequ70rlVRjMrEI1gHK2fQCDwhcUXSfm7ma6WCUk0qpv5flfaELgsL3RFltVXQIy9tb+ln59yQYGtaadnN4WfJFziCkgT5napyJIlHrIpAIh93i7uWJkNVZnPb2JRogRS68eqmg4W+Jaw2TvCXl3NDTQu5LwPlNDZfo8wYWCd8tvFFgKtGApf3tHWpWZ2doySm7l/Rui6l/d0cTmlF8t00JcQ++4A43c5ME+4sN8bDnlKmSPY0lNSIRElFdqhDzlv/8Vg==
Received: from BN0PR02CA0029.namprd02.prod.outlook.com (2603:10b6:408:e4::34)
 by BN7PPFABD533732.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6df) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 13:18:52 +0000
Received: from LV8PEPF0000005C.namprd02.prod.outlook.com
 (2603:10b6:408:e4:cafe::98) by BN0PR02CA0029.outlook.office365.com
 (2603:10b6:408:e4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 13:18:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 LV8PEPF0000005C.mail.protection.outlook.com (10.167.245.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 13:18:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 06:18:22 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 06:18:21 -0700
To: <ltp@lists.linux.it>
Date: Mon, 5 Oct 2026 06:18:07 -0700
Message-ID: <20261005131807.904833-2-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005131807.904833-1-nirmoyd@nvidia.com>
References: <20261005131807.904833-1-nirmoyd@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005C:EE_|BN7PPFABD533732:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4499e7-260f-4620-6894-08df22e33298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YibzR2cqzc7yuKJfb6rUZyC5tN3+2P7SHaARbMcDmbJDYOnhiTlQ1UVnC47b2P5O2XAT9d496Slg+os6t8ReF/eXqkPRYreze1pGmy5HdTTOa2RCCpFR/wY5QTnAySEINJNDbO7GbbJ0Afq6ED4YYL23eNp7pOATNvsqXG3UvO7qlnqmjDzKiG2uiSItW/yd5gsBJg9pv7JEFWLGI+m6lLuAJuITVUMxKLV28wW5kF/SBRgc8DiqacBg6p7tBIRYTSfa002CDi7oEL+KK/LlL8YjQM+cqrSKikSk8oBF/HV9Vr148u+2n3ev0sMUOcsFUe8LQQDirWWccoA7LcJQ8+FaActNmqPrAeyEoq8HQ1eO8baywW93Yv5+NKMx2aqLP15w7R4ieikg1RJ7lGJET2eUPCQI28YclouRwL96FxO08B27ddfbGjA2v6rE5jCc7ta3Qg9eeYKfo2SW6X7of8RufaBcXqnzImMmtp15BsSSQAf9QWy/ZprGjPK2L0L+XDqsuJ5GNWQp2odOTNpGckqEzoc/hYeJ9op/bgnAiItTqAk1kfo2XZJl38RlzbSZNCwzKUX2kuxsYjq8a7J83ijA0s/qEesP47hVGN+1C4mO7/nL9bJYwotgX8lHVNH+o0AUg9N1Od7RxqGW7mKbag1PYH2rwLVxD3ql+ov+XYqe1gsiTTVGr7aJlqJWN3aDJnZMPJRVlcq+oFWXaZGkAw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XVdHTeirVjp5MwHV3yUGZ2LQGoqi0wwQlwFa+nAAR+Nfw3O/dFUnlzX7VhLdVqZE1+rULbgJVZgp4bQ2CCDCJQEO8VRZZMwtLP8Uzum1mPGmiWbzkwoQNT9IEG87aGwyaQsNk7GV55sML+m8W64g5uhsRjN/EvDQivx//X8+CBObPrAzLkQwZeNmC1CzU9vGrkZ5nbXl0rrWYuOqFgbMTYRHx4jeF6ZiuZE/X/wN6ftd7rXmTfSdTuuqRcOoRq17APx6JvHjqiEUSk3XPIVWP/xo5ESDJhg+DrdSjq2Osg6A+VyMHL1jRPJYUboyMqSgw4KTX0isFubGW52F9egQ7XMdd2CWbefOq/ZP7BNZwfEMecLYUIZeZn18G8NdbFrY//wy7t7urNWd5pGXwYoTykv4HCasbjcL8Mu6X+gSvG30pAF1DL6EiaK/L7DAu/cS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 13:18:50.9892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4499e7-260f-4620-6894-08df22e33298
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFABD533732
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] getrusage03: account for percpu RSS counter
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

After f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter"),
the fixed 20 MiB tolerance can be too small on large systems. Pinning
limits pending RSS updates to one CPU, but that CPU can still hold one
batch outside the fast RSS read.

Pin the test to its current CPU and allow one batch of lower-side slack
for the 100, 300 and 400 MiB allocation checks. Keep the existing upper
and inheritance tolerances, and skip if one batch is at least 100 MiB.

Use tst_ncpus_global() because the kernel batch size is independent of task
affinity, while some libc CPU-count interfaces follow it.

On a 352-CPU system with 64 KiB pages, one batch is 44 MiB. Pinning alone
reported 270336 KiB for the 300 MiB check, outside the 20 MiB tolerance.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Co-developed-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
 .../kernel/syscalls/getrusage/getrusage03.c   | 87 +++++++++++++++----
 1 file changed, 71 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index a2cdd6158..52540a919 100644
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
+ * max(32, 2 * online CPUs) pages, outside the fast RSS read. The kernel uses
+ * the global online CPU count regardless of task affinity, while musl's
+ * sysconf(_SC_NPROCESSORS_ONLN) follows the task affinity mask.
+ */
+static void setup(void)
+{
+	long online_cpus = tst_ncpus_global();
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

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
