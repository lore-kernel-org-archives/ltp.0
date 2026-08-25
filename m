Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EC3C61DB9
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 16:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787676142; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=mqKhdggiQVsfUAdRk4JwVOM8ZqevOzN65+mWqZ84nbo=;
 b=okrti2WrQvlU7WjiLmV+yu93pmgU2zwPCvnp/WM58NOiY/zBQqo/pVkfKZKHRCHnc5iLw
 On9V4np0VGH8szNJLEVhJmNqwUNhmQkdaoRgPVkSkTrj/GCBheYNdS/PV/t18Z6Y00j4HWO
 0KJAlzmzaIPu04urTQhjE/makZ334kk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 622CC3C6FE1
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 18:42:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D4893C0D0D
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 17:26:51 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 362741400C7D
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 17:26:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQ0dwz9Ien25F0wx0yaUUQEA5r1PeOtPSqRXdP5eTQeTF9xocPw28uVP0ebP1LugSmZAa89u7k/CAmHtK2jp4sYA0wq1316LoLnxYwEg2oFhGXxlMPDm3De8WyCOhThmdDxKEcffsq/wdsvrmZnXP6peagGbCvaea6yTfHSLDZK/rrSW7V4/GwJqGqujEIMAy5p0es9RjgTOu7+sLo1LFhMm+H/T2nasdww7Wi+WXPP+qQsm/ws9WMhmsEWHNK+am2aj7K5DVI1MDSmmjiIUiouczqkF3LzjyQfMFpaIW/nmQ1WcusavSAvm0DJI/1vpnHBJwP1ONko6s4x70P1NvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=401T/OpounW5uPF5j4gj1vMrNs8kAQ8OECHqoNerTds=;
 b=rB7H1UO2YprcTO0rw4ME8uq7iY+9eg8ttIeN77+xf6G8a8Im+WurDla9DU30oGVDHWUXqccjNOmsle1fD6ecS75yhxeZ4c/It5NBaTGDP99ZY1l+GwOl2WfSxOzGs6hXSA2ThnhDFEg+EaaK9tJirTfxV775hwdqJQeNKh2WnXWjvryBOjndKomhAlIrZOp2XNNalPovtk2B55VT95n03T2qmw98LZH7yFuS6ovztS47us8V68qAkxtFZcjMB9PHbM/w5yXNu0IebppTYn3ir3r7SKteoxXn2pSAYGNXFyM0407LDw3nLCvEs0kc3JXHWr5ZJ/7DBbv7XpVTHJK67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.it smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=401T/OpounW5uPF5j4gj1vMrNs8kAQ8OECHqoNerTds=;
 b=DNbzNDHyDlKvP1IMh9mNyzg2aFxQyjO5a2Z7sY0nR0+zCwBXf6NOj6O/FQLYkminCHamF9gs1bD6bqaSYqBvoOstY33hEUGTt89I1IUI7ogPpnXZsvEfWrJj9Jt6TR5bEtFeREzN/G+Nil2urh51QZbUnvM3mg9gixQaqGK5R5sw1ZGEH32NUvzJURN26fOnusL0y9hZ+PwU7xISKJqNc6/fY0hdOdVW3x3Jkw1WyhG/JtVO/ZTSC3FelNdtBwKMpIKuCKpen5BPpsciib9NDDOEPCvatABiTFVfBzXIr4RjUXWbr3d2VtbBg9HPq01k4JwSDMXQMmxvtbThm7+iRw==
Received: from CH0PR03CA0103.namprd03.prod.outlook.com (2603:10b6:610:cd::18)
 by SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 15:26:42 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::98) by CH0PR03CA0103.outlook.office365.com
 (2603:10b6:610:cd::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 15:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 15:26:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 25 Aug
 2026 08:26:09 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 25 Aug 2026 08:26:09 -0700
To: <ltp@lists.linux.it>
Date: Tue, 25 Aug 2026 08:25:44 -0700
Message-ID: <20260825152544.1675541-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|SJ0PR12MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a92721-b469-4034-dbfa-08df02bd4386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: njjTaiKLO9fcNzxR4RMpUs1HjnqrLNTYp/57h+U6rq6MyzDFt36SRvlziIhcOhCtM60rtmUUkljvSxyZAd/kd6UCwEfBy1M0pL+cOFcUg40dbHpOgQLZIsablnIJqlsrdgcTGKEzywUrNfr3WlVlpwNASCxVHZ2/M8pFKelC69knDAeQKeAvIrIKvWtra8Nq+h0BzwYtM+l3OtwpCztItMoirPW257QDPKDnWCKt4LvVvu++SLSt5tlNMpPdJrvrdQw/MLndMIbMf6gtMMbR74T3pHITqiSVgZn4UPTTGBGqIeWrKJ3EVxxkuo41KWxBVqaxeddisrgI3PqJ7XWVRm5yzXLJgpPDwiDJH+syl6uQ9FjAnwuwemSzPVNie9IR4vkXpaX0LShXcuZ3gQE1y9FblNLdhmR1FNltIktRsvSOLVGI2YnjrDm719opC2c0jIIuEUVX2u5YgKrpkUmgnzXCPKHwkpg5wkp8UUUxqjA+PW9UM934mqeoUYey5gSzSSPQVmLrrEwg3maj8PvfUQO/d18RFuuxSWLRPX6wpYnTm3Mi8wcyPSDxLkoPx1omfEVehyA5Rh5/RFTm3/JLC/f1ghQULNr9OHP01sySg7osu8gXzYGCAKNzm05dEWKJXDJe7Qkl3WcJM5aqgzQqAyYxRyvobyrY5tR1yBz24HBtDUsOmHsMmV1tM5TbMh7RNs4kHMi9hLeZAgylM63I1g==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3a20kMBN3DTsanwMFVrvXgGuvqRUiCuwuOHK35mbmHLcz2somgwukvT4qI/giRCV4xU0UtONLUbhZP7bCDey6kgr0HvRD4YPgSEZxwUZkTv6rFl9/P/qcIbbQMkGbnLI5LjnAafWRKcXEc8n0eWR4fiRxAIPfQB4bJxW9qSYC4B61KWLHNuyQhphdVwJJYl74196axGb3MkjygxV69upRctOR3+IsG4ep6g6yk71uWROYQ4xdXtWQjVhQpfWxgCcB0sgVD6hCbLIMng6D/jijtSNhFUBYnVhw0B64uHoFllMbnBTykcj+kHkYYkKEYsfpUpWzFrYmJ45p/v40pwBwxwOp/GsOiTx/eBPM2aMo940vQ8EMkzLyFZGwinO2g65+yjx2ihIIZmFrJ86AjwopKqcBzauw3Ypv31fFmgzFtVGdGJU9on6dwu6cNgabSoW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 15:26:41.3048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a92721-b469-4034-dbfa-08df02bd4386
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 25 Aug 2026 18:42:03 +0200
Subject: [LTP] [RFC PATCH] getrusage03: account for percpu RSS counter
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

getrusage03 allows ru_maxrss to differ from the expected value by a
fixed 20 MiB. That can be too small on large systems after Linux commit
f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter").

The fast RSS read may miss percpu counter batches, and the batch size
scales with the number of online CPUs. The test child is single threaded,
but it can migrate while faulting memory, so allow two batches worth of
slack based on the online CPU count and page size. Keep the existing
20 MiB floor for smaller systems.

This is sent as RFC because it makes the test tolerate Linux's current
percpu counter batching behavior instead of treating the smaller
ru_maxrss value as a kernel failure.

Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
 .../kernel/syscalls/getrusage/getrusage03.h     | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.h b/testcases/kernel/syscalls/getrusage/getrusage03.h
index 58a98b430..9a7d8e8fa 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.h
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.h
@@ -7,9 +7,20 @@
 #define LTP_GETRUSAGE03_H
 
 #include <sched.h>
+#include "tst_cpu.h"
 #include "tst_test.h"
 
-#define DELTA_MAX 20480
+#define DELTA_MAX 20480L
+#define MAXRSS_BATCHES 2L
+
+static long maxrss_delta(void)
+{
+	long batch = MAX(32L, tst_ncpus() * 2);
+	long delta = MAXRSS_BATCHES * batch * SAFE_SYSCONF(_SC_PAGESIZE) / 1024;
+
+	/* Linux RSS counters can miss percpu counter batches after migration. */
+	return MAX(DELTA_MAX, delta);
+}
 
 static void force_context_switches(int iterations)
 {
@@ -40,7 +51,9 @@ static void consume_mb(int consume_nr)
 
 static int is_in_delta(long value)
 {
-	return (value >= -DELTA_MAX && value <= DELTA_MAX);
+	long delta = maxrss_delta();
+
+	return (value >= -delta && value <= delta);
 }
 
 #endif //LTP_GETRUSAGE03_H
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
