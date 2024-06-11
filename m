Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E055C27C5F
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 02:59:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C40A63D0AE6
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 04:59:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAE783C9430
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 04:59:13 +0200 (CEST)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sgaapc01olkn20810.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feab::810])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CAC032005D3
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 04:59:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbl1RcpO1AaTuaMsPKb6OEhkksnkC+LnotK9UwZ8jGldMYBkY7jqZKeodnEA0HILPtMlcniFU93xSFdnSY5cbTetZrndZ8EcQuZd2HFSus+i5wCoJFt5heGdHQxVGkxMDSEG5OIYYawTLd9od1zYMcswC9EMDT0QLwQabKJA2HI9b8VA++PqHsVY3KNQ2zLbZUT+r21gkNKLQfO54HnuoU/bXF4h+85SnayAFPc7T4LSwSiVEn9NVMckegdO2kWqnYqRSexKOsGVeYRqD6ZqFR3hqknCTU/PxbUHUhbhNH3OWDoWHqSHALlT84o3RY5IJHaAwu9Zxj3rh46b7ubGAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+z+YupvG3z76aV5xcuw30gT66Ld+Bu8kDQKU75NV47Y=;
 b=UL0fSq42qNjkaP5bsYBkTnEb6gqigR5MwK7v38Q1Py0FrnjLYzNUDzTJgIOfjfuyipgJSPNZV26BVGbQTaRMViikIcvbTPdwLmgrwk2bO54Cbl7XdmbBXIw0H9EeOMU6BPxiW1LSOxe5T7Kuy204FGtZ305moVBG2iZH1gclYtSpbVJ+h97UINo04SH3Q57IuCOvyV9n/VMWqtLWgASxtsxdFzNDBMEZmnk5aOEg4RJuvzcI5AX4thbXHtd6UTpuLV1qIx+uR56gmEhT893Y1TViJTUiDQiP3V8XHA68nAs1oonJMeGVDFGRPH4jobAAQ9pXiWk/A0ViFcqWUR69pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+z+YupvG3z76aV5xcuw30gT66Ld+Bu8kDQKU75NV47Y=;
 b=hZ1YXnhjcqw+GfZKgHcqvn37IFvUa3tbHq3oF4WYlE46RGpwemj96OA/2GkKVV7/rQQdv9/0g8fQqPqgG8UXs95ikxMSJhCyD5Y6eHy0VWNZs1Otapp7WocVGnDczA2GTrpsYSy7Q30HZB9Q7XVrbZ0TYIPjqkev6LrPrM5cM4ayy2bAP3cNgIA6qPi9zWoBuL+mHIz/YIwRn66/AG4xTfkuoW6+O3PWuLNkrTJw7lruQj7Us/F5j42FB2hNV0nRRtYNiM4hFq593cwWys6bLITo5qGTYUEi88rfiqrvppz7b4t3o8qATugMtS884W5kUj9PAnOGd7uLYrvLhF2dYg==
Received: from SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 (2603:1096:101:76::5) by KL1PR01MB4744.apcprd01.prod.exchangelabs.com
 (2603:1096:820:9c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 02:59:07 +0000
Received: from SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 ([fe80::653b:3492:9140:d2bf]) by SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 ([fe80::653b:3492:9140:d2bf%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 02:59:06 +0000
From: Jiwei Sun <sunjw10@outlook.com>
To: ltp@lists.linux.it
Date: Tue, 11 Jun 2024 10:58:56 +0800
Message-ID: <SEZPR01MB452774E4131F00D0D2C0CE60A8C72@SEZPR01MB4527.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.34.1
X-TMN: [ptEe5FLbveh8hWajUo89QIMapRlSueVv]
X-ClientProxiedBy: TY2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:404:a6::32) To SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 (2603:1096:101:76::5)
X-Microsoft-Original-Message-ID: <20240611025856.16854-1-sunjw10@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB4527:EE_|KL1PR01MB4744:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f6ea87-4394-4bb4-2f94-08dc89c2752e
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199019|3420499023|3430499023|3412199016|440099019|1710799017; 
X-Microsoft-Antispam-Message-Info: b9gXPjaSOFFpe3fIv93iKAo9roxDC4jbJpupCRYgr2U020dGfsYlUsgbqH/Ed3hN+vsxYrIAt8EYkdzs73qaRonNOCbf3hMZb/7dZtPgUAYoug2g9kbU1L3xz7ZNpIcw1ybafyuxbaJcV3EXMEhMf/6tyHXsgOK3lJTRp9qElV2iStYtDJ3uDhxiBjHbAVqAOXKBbp1bh4RZ/VesD2i46Xth6w2XNuDFdyMXSWh5+H/wNGmsvwv1VilVf1gefasv0lqtA/aueS5B65C9wy6GBsv4IBxReVt6kGIXlSKoSouADCMY6ulofsQkx/v1flzLUx5X2UTE1Rsc0yv6Pd3fG79oTD7UiBp1nWn3+E1u0cGQmNyKh7sVTdPIJ6teNaymNVoa4GKBIadg4vcSu3ZnanUfy8xA/ZemEq7oy8X5GExjQYG1SaN8dxjdRrK8lPw/HgqRRoGoH0mzA44gMD/gSVaOrJDq6mIS04+ih8J/IMiEOHNONeb3V9OY9Klalj72Mul+g+/jvggEyJeUq4bUjeC5hwwGwpM6bQYILI9xpallygXIoh27NpK2HcmCpShb4+PTzStN7QPkbyvSQAtgL8E7MeF6KBwHRMjkTvNazdp/e54Si6wFdyPuPz8F7q1j
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YVpqbKQ5vGZ6YKGxCMEhV75CwrXJ+V70+Lp9eu623Z8UZRSvXGKgkbb484sR?=
 =?us-ascii?Q?CSsMQGeg96OBwPn3y8IB7bMFXwvevxD/ZoXPC4WFcmwvz8+vMPM65b897eI/?=
 =?us-ascii?Q?12D4DpuCwqG11mkyckRrAUQ28EIEk7t7Yt/t/9Ov4WfHvaQa2GrsKuwTQAYq?=
 =?us-ascii?Q?qzJyw9YvNg0LgPtgdeRNAG2sUsS5poeyvf86LpJLh0m3s5S1dmALE40AjNVS?=
 =?us-ascii?Q?yaf29t45y7tr6n4/K755jrLkzOP4PHk8clOg370cXLFQ8idXChZty3ZqURyI?=
 =?us-ascii?Q?Ps/hc3W4ZQ8+JET4W8zgaabkCwYXZ985x3EJGcvGPe4D4Siyl2eAV9R0YAmu?=
 =?us-ascii?Q?93UqTbUhfCVmzuRmeTvwKstxHxi4GeebG6C9DDG5nBmmvS+UWq2Z6cvhc/9E?=
 =?us-ascii?Q?DEN09baGtCdTJ23/huH1qi0XHoDd8I2pKF6VSSxpZ41CRBX1g1WW4CPDe4jz?=
 =?us-ascii?Q?NkqJDy5c/5/yuHeAHsQl4VLUYyA+QSSW06RM7NvU0dxlMNo4Y7Up1sR5+xH6?=
 =?us-ascii?Q?tMC4oRuxc75cm+bIEw7lvqYjGvkg/vAzqeiy65DDsLLASTShd8Mup26zGyeb?=
 =?us-ascii?Q?wd7xf2wwbyXEKRLVwCTIUjSRZ3TWdbhXanc2D7WSQ3CcQdvQMekz2logu6GA?=
 =?us-ascii?Q?nisLaarIo2dNG0gLnvZThw+2EWpsqH3Ax6C9Qao8G3Q6oVlLBwy8tT2coRdH?=
 =?us-ascii?Q?sp4JMOwoyRU4dEiAH2coRbUp/nNzxEVzK8JK+5ZgYfRUn60NVBzjA4kvT4yR?=
 =?us-ascii?Q?BRe6vhBHDkxiDg5WOiabz7xPHQs4iuKh5OdrpJ83HiXx9ctLQX210EqJp54d?=
 =?us-ascii?Q?QVKa4et9VBlOZ81ogZ8ZokiFsdSh+uAyO2nZqmiXC2u9IFZ8TkzZ2SUrbHAq?=
 =?us-ascii?Q?NY5fQirMpirtAuZQ+zEY4fewcdPz3iY3yf4iRrzQtQtTWng/p3chOc0xArTJ?=
 =?us-ascii?Q?0EfMjTAj93yXzG5a8t4WpMYO+d3MpxNxCekzPDI6YBtVXcTOZri4Z52TtFZ4?=
 =?us-ascii?Q?Kp5/PGVqsSAK6yif6AyTMXc8n5mE4HMmHi2n4tMS4aU989JkaOnL6QPGZ9MT?=
 =?us-ascii?Q?2di+r46EkazefYEPJchlFoYeCv3Uy9wEFg6h85wijqmes4QkOaDUjHM4TeFg?=
 =?us-ascii?Q?1Vr4pGOhnqwSrmOKGxYDoVXKWhDLdWeppYTvAoMLWFvt48dLQHbpO3P76BRW?=
 =?us-ascii?Q?Tqo9qzbPFVCOHzdu0cV3I87M0W146BCHnFl3TtBJhXMfwDP0ZawJLoHIgXs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f6ea87-4394-4bb4-2f94-08dc89c2752e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4527.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 02:59:06.8203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB4744
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] genload: fix memory corruption in hogvm
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
Cc: ahuang12@lenovo.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Jiwei Sun <sunjw10@lenovo.com>

With the following command for doing memory stress test,

  ./genload -v --vm 10 --vm-chunks 4 --vm-bytes 1073741824

Some memory corruption issue was triggered,

  malloc(): corrupted top size

The root cause of the issue is that allocated memory for ptr is less
than what is actually needed.

Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
---
 tools/genload/genload.c | 2 +-
 tools/genload/stress.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/genload/genload.c b/tools/genload/genload.c
index 7f56d5272..9712e7828 100644
--- a/tools/genload/genload.c
+++ b/tools/genload/genload.c
@@ -642,7 +642,7 @@ int hogvm(long long forks, long long chunks, long long bytes)
 			usleep(backoff);
 
 			while (1) {
-				ptr = (char **)malloc(chunks * 2);
+				ptr = (char **)malloc(chunks * 2 * sizeof(char *));
 				for (j = 0; chunks == 0 || j < chunks; j++) {
 					if ((ptr[j] =
 					     (char *)malloc(bytes *
diff --git a/tools/genload/stress.c b/tools/genload/stress.c
index 7f56d5272..9712e7828 100644
--- a/tools/genload/stress.c
+++ b/tools/genload/stress.c
@@ -642,7 +642,7 @@ int hogvm(long long forks, long long chunks, long long bytes)
 			usleep(backoff);
 
 			while (1) {
-				ptr = (char **)malloc(chunks * 2);
+				ptr = (char **)malloc(chunks * 2 * sizeof(char *));
 				for (j = 0; chunks == 0 || j < chunks; j++) {
 					if ((ptr[j] =
 					     (char *)malloc(bytes *
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
