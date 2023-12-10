Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3ECC4167B
	for <ltp@archiver.kernel.org>; Sun, 10 Dec 2023 09:44:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6517A3CF88D
	for <ltp@archiver.kernel.org>; Sun, 10 Dec 2023 10:44:16 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE7B13CB7E4
 for <ltp@lists.linux.it>; Sun, 10 Dec 2023 10:43:59 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8DAD1140006D
 for <ltp@lists.linux.it>; Sun, 10 Dec 2023 10:43:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCupMiNN2zUHV5x5Cv442QTz6bs272YleDWt7S0/pE4WUcPVnDtOkGCdYKcj7zQL17lZ+f8b5o1hVH7bLrUsQ1xGAYJJWdFXI4Zh+pmNvx4Uly7dBrKAYLo0ap9A6QKwVGHTFIVdw7dI7/iMfW6x7Q+x9EQ0TFVlExxTgAAPEwI3HNrcjMTEWTVytGlTo9Kb2NwmCJh1j8YOipCpyhfv9XVC+PSwqSUf4BJJ7OlQkI3N1cBcnuF7WJCpkCb66OTwuSiipKrlqx7N4srm5PBGJFffQPiivEzT5fhZm8TdfRIlJ3hWV5fiWnchKsFv9rE7Ua4oR+50ZzJxlrZ38nCCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMhxBiinJtyEKtKBiPTfeJfOurPDCTosUQ5Qq2ovgDI=;
 b=mmeaOTcwkcRjaCgK+zW7k0sXoxCtNSadOMf+031Dzf50MtfjPM5nZx0+frxxOb+Wi+Ja92aEzmyEIkUMdXXsn/37HhQHh/R8PaNFBdAcyjRHvgjGRfOCAB5hhz5n9zt8XuGyvChdBjkF8nKeZhWUgFxnPEEIEIg6UdYpY6hWGEpPUMHQlZlzUgDS3+VOyrhZ3Vi93M2x4XqG0EA44KqzMDAgZECGBqGU745+E73CXgHICj1ryakjHqo4mRwjTxHXDNhm+g00ngcsTc4AeqkIdQJqr6AxDcCIAmXZ13MLz68JAASN9zyyD70U1vscFefIQtmouGV/Ey1v1HcAbHl83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMhxBiinJtyEKtKBiPTfeJfOurPDCTosUQ5Qq2ovgDI=;
 b=pxe7Q8Q/SFT2MdvXpu0uBQpty6slkQ1+T9Ep3saZW81AX62s/M6qpF0SOAoVsTlM47P82uWcdFulZ2UQ3D/0s78J4orS1HXYc842G9VXp/I76He91exTrtJumYZvJDLmTosPH/lkJmWvU/aoufWWEyTLWxN4fvIp+gzYUGUOm7WP/mYYEiWqG2Fdad52Qz7ZuIsvjpsKrJBGkJAlvEtccykhu1hGU3riVPEtF6Zw9urDPFj8fiVK3Lr/dUt96B0WhMGXusxvIYf7GOKGfssHI5olwAaAj9/mEhyhnfRzCiFf+aPAnxgtCc0rpJ563Wq9JzPxQORhK25c8PnUi7lSDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DBBPR04MB7867.eurprd04.prod.outlook.com (2603:10a6:10:1e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.31; Sun, 10 Dec
 2023 09:43:56 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7068.030; Sun, 10 Dec 2023
 09:43:56 +0000
To: ltp@lists.linux.it
Date: Sun, 10 Dec 2023 04:43:39 -0500
Message-Id: <20231210094339.26971-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
X-ClientProxiedBy: VI1PR09CA0129.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::13) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DBBPR04MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ca371d-99df-4cfd-0c3c-08dbf96486e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hAcDGbA7uts6+0SZQD/cHHOkWGa2boX0pzniVVmexBtuODrJiwtGvaRAlpekF5fVnCHB0W3AA17EDGAQKHY73SD/w2a2wdK2Fofr2hg/ECn68EN8yZ12Ylu3eoqVtORyFrEy66Rcv3aUsBthaqGL1EjLpHQg0FR+0CoIF6nhrZ16A8Jula4UpediK2VKj5PQsbH6gWtqcWkOehm+iu37+GG7MZQeip0L1t5ZxpVD/oKRylh6HeDqPgyNw4GgcSaMcSA+NUVirO8pcwrYykhUVIvcy8t2MECn+vf+ixxtZccSSA61QdAmJBXi8DckteUMQVg/kD4IYsbdJEh+oBSXzU0hrU2iQXxtlfRuZY0xmt886eLCsdOxfVlhWlZ7Bb+56n11qtpDDPP8Qy2C+gGb5LslE90zWchsDXqYPsCKPiBijCSo96CBpi/igbMvvVtl6HazJrz+Fgq+h1XRywxsGwoVs/oTCJcPJlXY4TveDgAP11WmtKACtdbDrLiAON8qQ8oduWvCE0ys2Jm1K5aUZh5cWiOV5ekHAHKkPLUeptuzxjbC277DBUVtQHtB+WID
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39840400004)(376002)(346002)(396003)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(26005)(1076003)(2616005)(107886003)(36756003)(38100700002)(86362001)(83380400001)(5660300002)(6512007)(6666004)(6506007)(8936002)(8676002)(66556008)(66946007)(6486002)(4326008)(316002)(66476007)(6916009)(41300700001)(2906002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C70InQKiqtE3FoWXwBNhUT++VlXKDlXDSta9tHEkofX0MGzaxR8lvQWtroxz?=
 =?us-ascii?Q?CmAs5mEUPeXKWIewujm48T0ynznNckMwF9qVzwgy09KqLsBNGYXbE00JmYix?=
 =?us-ascii?Q?FEbpsU/msrDz4wIUplskCwHvib0sY0s6H0k8xEmnbgCNkWTSLc+u6c1MfS3a?=
 =?us-ascii?Q?fc5iuvk/C94h2PLqwADJ+fusOKvHjLfVjh6w42UAeA/axK1dc95UkIvjGgrE?=
 =?us-ascii?Q?GrjTiU0//8JppioRTCzIWtHeZbyxVIkniKvQKDYb/e3QSe/SIvewyQQrEp6b?=
 =?us-ascii?Q?a/Zj4a9yFLQKzRU4J8q/pshBRdxoocNdPJVhhFJ3M4O2pw/2VYb8f+Wr8rhh?=
 =?us-ascii?Q?x/NEyVFevbcf162WnfVYVRE6vtP3L5brD/93YAXznIN7s4EGz4gZcPx+CD3x?=
 =?us-ascii?Q?RR+aMKDhczPf1oJPOTapNAuRfYTabhfS/icvPM48xp9koAnZiBPMN5wWUWej?=
 =?us-ascii?Q?4R/00IOG1nWR3ttghLBmvhIvbJauK2hvWLGc2Ozw7CNXZmH0IDcUowQnmYka?=
 =?us-ascii?Q?mhObSJ4RQYnpVAaiFZC1PvjGa5PFsQZfpgqsIDyCwmpsLvgDgFlq7GZNhbj0?=
 =?us-ascii?Q?6ezpKFKPwfZnIs5NxXvu+IjrfAJZAT6a/lmrK+KWP3JXUWWbyRn7E8LSWN+c?=
 =?us-ascii?Q?65JE5x+mTz7wSFqoKRJVoKou2hLVva1LzPT/iXY+wN9mMlDVeeOmn/7LdOOx?=
 =?us-ascii?Q?5PDyWcPL0PzcOdwfC2+YOpPdoDxC+3HiJMP+2x3zSVjelsDjy8n1NVU6Avgo?=
 =?us-ascii?Q?IyOgm+Va5anzEyHRA82ekHEN4bbYfCBxesvAQY2tThEnKqkfsZbIpPf87UaT?=
 =?us-ascii?Q?ezBhTdtxyiVfOvGrckQ+AMz2rC30hnRga8Vc+iBwYJZ21+MoOub8uWWkTO2F?=
 =?us-ascii?Q?ruIdn8iXmywPIf0a3ik0SREj8rlkJ1vukJ1mPDXiO9NYUYZevrpqSVbxPK8D?=
 =?us-ascii?Q?jq1P71AttcM6CFRyVkMgbI9BNaOuiAgLyJX8SoODZK4MlCN9/OcQMSo1+Ipz?=
 =?us-ascii?Q?tw07m8VPOxG/mYZNqe2vF0AyDB/ODAdzHjpdv34grqN+lrKA5nSlCTLsRUrE?=
 =?us-ascii?Q?wJ1XyS10Tn30PaA5ea5L6lcrILjNTxVmuyyRw8fhbTaSKz+ylru9ywDCB7nm?=
 =?us-ascii?Q?kv+B5vsZYA3sfqrrwIN07DtZYxysbMsqHKtTCYjM6ds5H9U0QdkjEjJaC2ef?=
 =?us-ascii?Q?BbowS3ub2XcNgAwFumdFJlu15uyG36bVA9wFyy84e+UhwTC6EQvFM90DHGDV?=
 =?us-ascii?Q?VE+yR9VX+aAXkoOVEcVd51uLxdKlkoyM0XhqQyoxACy310tekOLsn7M7IzJL?=
 =?us-ascii?Q?b4oEgnT+SCvfNMGCDK5zUh+j0ithtcdvKiKy5DYkWCUfFUdMjXMOTifJB+TN?=
 =?us-ascii?Q?vPHBfC6OkGBBIhLow8zP3B19rRkGiOZdec2DBYfwo0o2dRbWIs2St9dezatz?=
 =?us-ascii?Q?gmKC5JzJdAVQUED8si8qhm6THuQlsWeeMKy+yDkyix3z7W4UxoPA0jv3n1Yn?=
 =?us-ascii?Q?rHTObFN2zL9RsmoRlYThSUXfFpIG7LIDGdZkaTv8UpW5Ey3CcUz+za58iuEE?=
 =?us-ascii?Q?c/w7aAMRc5VVSMhIH+c=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ca371d-99df-4cfd-0c3c-08dbf96486e7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2023 09:43:56.2885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xzTNPm5ZDckYrSjO7E9GRj9x7epu2CBAojmd5BlICW5U7xnr069DP6AYyATUqaW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7867
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] swapping01.c: Reporting /proc/meminfo before test
 and at the moment of the failure
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/mem/swapping/swapping01.c | 24 +++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index fc225e4a6..07d89f44b 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -60,6 +60,17 @@ static long mem_over_max;
 static pid_t pid;
 static unsigned int start_runtime;
 
+static void print_meminfo(char *path)
+{
+	FILE *file;
+	char line[PATH_MAX];
+
+	file = SAFE_FOPEN(path, "r");
+	while (fgets(line, sizeof(line), file))
+		tst_res(TINFO, "%s", line);
+	SAFE_FCLOSE(file);
+}
+
 static void test_swapping(void)
 {
 #ifdef TST_ABI32
@@ -84,6 +95,8 @@ static void test_swapping(void)
 	switch (pid = SAFE_FORK()) {
 	case 0:
 		do_alloc(0);
+		tst_res(TINFO, "Meminfo before check:");
+		print_meminfo("/proc/meminfo");
 		do_alloc(1);
 		exit(0);
 	default:
@@ -108,9 +121,11 @@ static void do_alloc(int allow_raise)
 	long mem_count;
 	void *s;
 
-	if (allow_raise == 1)
+	if (allow_raise == 1) {
+		init_meminfo();
 		tst_res(TINFO, "available physical memory: %ld MB",
 				mem_available_init / 1024);
+	}
 	mem_count = mem_available_init + mem_over;
 	if (allow_raise == 1)
 		tst_res(TINFO, "try to allocate: %ld MB", mem_count / 1024);
@@ -127,6 +142,7 @@ static void check_swapping(void)
 {
 	int status;
 	long swap_free_now, swapped;
+	char proc_status_path[PATH_MAX];
 
 	/* wait child stop */
 	SAFE_WAITPID(pid, &status, WUNTRACED);
@@ -138,6 +154,7 @@ static void check_swapping(void)
 		swap_free_now = SAFE_READ_MEMINFO("SwapFree:");
 		sleep(1);
 		long diff = labs(swap_free_now - SAFE_READ_MEMINFO("SwapFree:"));
+
 		if (diff < 10)
 			break;
 
@@ -146,6 +163,11 @@ static void check_swapping(void)
 
 	swapped = SAFE_READ_PROC_STATUS(pid, "VmSwap:");
 	if (swapped > mem_over_max) {
+		tst_res(TINFO, "Heavy swapping detected, print meminfo:");
+		print_meminfo("/proc/meminfo");
+		tst_res(TINFO, "Heavy swapping detected, print proc status:");
+		sprintf(proc_status_path, "/proc/%d/status", pid);
+		print_meminfo(proc_status_path);
 		kill(pid, SIGCONT);
 		tst_brk(TFAIL, "heavy swapping detected: "
 				"%ld MB swapped.", swapped / 1024);
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
