Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF99FC27C78
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 02:58:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEB0C3D0BA9
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 04:57:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE9E83C006F
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 04:57:43 +0200 (CEST)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sgaapc01olkn20819.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feab::819])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7D569600C2B
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 04:57:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+oyn6uBS7iZSAYXZiN9lmx6YLDnes4ERKPBvaP19cKpP1PAKVUD5YPiJZsoRJgbE72gfVPWUdN7PcfsSJf65NqolN66LKxa4nvUK3PIuz/zP45p97eLocwesan1ok+aQrEJJ2NMJdoHgfR/F8BmxIHwoYWK92UZjl0K/xSFk3xNWt3/TyeOD48igrstwE/vNAVpAIlgdvLs5vA0/+J93NU9d2rXk0m0wl3sia2c22hnvdRQMa23huVeBme3v3x0qK25CfNOYAwqD0pOtvdggX8MFJnlFGWeV5qVYK+P8P4rR1qbqUH31U6L4fKpJ8CP/Wxo0XHxcxzpCOwl093l4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8ZHlB7s5e90HXmr/1qtNvHKvzZTSvLHmwn3mi6hFfA=;
 b=Ubo76vd+0aKGvKv0whkQJa8Ko/ZPBm5/fDADuNRx2PH0+qcghxT2rmyxTHY3cDudjHIHXn/HdHCbA5XH4iU5vbkx6p3j5UediRMQbFvJX9R/8ooWR5TaQipxk6rEadObaAqQz6N3PMGQkdTPwbpThZJyeYq7pevv5NwdFGy3XbKrR52dXZGeHN3SHvZlrKSIctClIX4a8GsEAUN+S1Q8zlW+bCR550A7ngIcWMIkqBlRDyLdNwwiF4PY7gdZdbjkVlpQcxfJBU7O4VUlJ323iCfdcdeZlZKyBZFSxc4BLFwaF5L2WvhtqB4Z11xS3qPkeZfZWaozQGvv7OHUROhYLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8ZHlB7s5e90HXmr/1qtNvHKvzZTSvLHmwn3mi6hFfA=;
 b=UWDWzFbyqkow73NjaCXjuzqCIxq0gt642gr7ETzBUdhk3R5qBhq2MwnWi1Bvj7R9PGB5ZGXL6NeqSqI+RF3qcWWolBDmMRRJn0S0ObGGjYGAll326NH3li0qMoMkP6SwXTX7TRXsLINlZc8CxHnZnoXcreIWrtF80CQGlgIaylN72mFH0yiaYAklxrvix7FGKA/Pw9/snvztweHJQPc6fMbzdTTfA7fMqlcqfxNjK/PqlOvRsjszDCHairnvHkHiPXEqHPtPwioT4G/F/6kzD8qH60Zmx6phNzu5Vkf95GGMOfUqA6AM9DP1/1TWRoN7TBX7Ao+KvVvPjnYs/0LX5Q==
Received: from SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 (2603:1096:101:76::5) by SEZPR01MB5715.apcprd01.prod.exchangelabs.com
 (2603:1096:101:196::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 02:57:33 +0000
Received: from SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 ([fe80::653b:3492:9140:d2bf]) by SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 ([fe80::653b:3492:9140:d2bf%2]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 02:57:37 +0000
From: Jiwei Sun <sunjw10@outlook.com>
To: ltp@lists.linux.it
Date: Wed, 12 Jun 2024 10:57:24 +0800
Message-ID: <SEZPR01MB4527D71946F457A41C66C8ABA8C02@SEZPR01MB4527.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.34.1
X-TMN: [W9SsJzYkhZSXYhjvRWrYVlRAqr8IrwRu]
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 (2603:1096:101:76::5)
X-Microsoft-Original-Message-ID: <20240612025724.68239-1-sunjw10@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB4527:EE_|SEZPR01MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: e175149e-5881-4976-bde8-08dc8a8b6a94
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199020|3412199017|3430499026|3420499026|440099020; 
X-Microsoft-Antispam-Message-Info: lDCSU7/4Bu+BuACxjhh1Y4vC8b5rqy0kEbrXTR1fdtv3erjotiZdcIVxnUxZxiapJzgO0CSIGv9se3tlj3p5xLXeGF0Uj56afy2BsxqdlYxON6oQG8yOcI+W/m6aykDPzJCycGh94b2JabvTcdQnDnoFNLZon1boSMrWIBDC5/RqZh53ugxK0DKITdu6DIJiNtLXh99SMjHQawelpEY8VhvOLp+xEvLbNfJ3oY24fSh8K15MHQHaZT97MDHninJvgphebihrTF9hHrjf9+hYuPM7nBcIWRM1WM/l6tDWsQs56+XoP1zqPVJERgeqpH6Lfqi73R57AecWoKC7+g8SmIwrauUtqIMkMwomAGIu2+rrwblv7tMk6ax3CZdp4Vgjc5+BX6k2sJZ+V9wGHt8aoFo1D1/CpNRDMQaliKW4uhst2opkuXCwfruH9twTtzpkFiaY+NW7x7bKXvkehHuymnBsc4SSChgjPJGko4urE0ul29jSKK2Z9XpJl4kIwvpD20Rlliy62IB09Wc4FqsqhZHjElQk9LGEA8XqbmBbpsOZpOQKtXjDNl7M/ftQhulJ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KOdnolmJ7dYZo1auiEwiFHUSdZi6mvrmwrhpGAJlK+fbjtHGaA90ZuuoAQbw?=
 =?us-ascii?Q?GYZ3Jh0t1ZETX0SKEvLodmyqiTmC6YRhvSLan9DBDsekebUaIiN/4Y/eZAe4?=
 =?us-ascii?Q?rvj7HjL+Ev3ZaHmpVJDTaCnc1ZXNufEqdC2K8jVx/kdmL6Ab/Mp8Nx96T1p6?=
 =?us-ascii?Q?lsPahfkiViG71rdaPLkYpPvw7mNrJViMknQgaq5pE+zXHxHV2AFhla0K0355?=
 =?us-ascii?Q?8Cn+dRqyRht2iICjqENg5ONolL0Uwxjv4Bme4Bhym95HqU2J4Vg0MvIM6P1e?=
 =?us-ascii?Q?rAtLojW3MhQDutAOi7JQ1fLMlT/RHkV2k5Sgo61+x+UIaH4dNWbHk9zqx0l3?=
 =?us-ascii?Q?UJ3uYra24Rh7+hYWQTuqyl0vx/Cu/CpK75v9Ow41ijFMcoSN8qHTMhxM7Xks?=
 =?us-ascii?Q?Ywye/xCd1lBNSlO5FvRl2wHusCoK/UEUVIqucf0B6Swwp5yaOQZvDUnXucqc?=
 =?us-ascii?Q?z+sVjcp3C4QB123bIKdn/5f6nydAuzy/7dRli3eE92DSZ0M3kkXYUkC+XSDN?=
 =?us-ascii?Q?sa+mthJlvgmTgTXNCNPEHbaxeTSeQPP8xAy63gG0xcovha3PjdTPZ4rvPfoA?=
 =?us-ascii?Q?R5555s3D/UXR6Y8YfDJjuu55MDKxRS18C/afZ8EYFjUY7XsK7QR49gTaR1MU?=
 =?us-ascii?Q?LnHbkLuck2W287Goifg6IcVruAPTIfIAMJXqdlc9g7j2sICgONFCzihwtUIt?=
 =?us-ascii?Q?2ubLketNf3nrjF1nqxsB4DooRHC3KBhQ42ZohypGcs8P/lvh5rIUjb4tS8Wt?=
 =?us-ascii?Q?xUwyeC9uY5yvsuJ/YRQ942Ar2vdLZY+T9+VaktxI4pU6sg3PCW9CSgxJM2sd?=
 =?us-ascii?Q?6FCWCw1CxYYmWVRGi+o+e3XAv0rsSf+lIQdIOfT3CuSY3S+I6Qe6Vmt6tLl6?=
 =?us-ascii?Q?07K7qBldpYqYzIudAt/84eccAvPWewUeDG+q0LKuZItVX8LJg25xKRdXzFM0?=
 =?us-ascii?Q?rhsy/VwpcJfRKYEhlZ+WsXW5rHQ6foAR+t9bEnqGfcwiWExs0xX41wp6fxvV?=
 =?us-ascii?Q?Gsk1Yn3b5pJRvvTsGt+fZ02B/AigETrkBHhxKTKA7KLi54rGNcInMWS+BJoR?=
 =?us-ascii?Q?6Z0xRsBvKRpTKGZfL0TOyozMUD0D7iliry6fb09d6vEN8zYyOjld4eoPvR3p?=
 =?us-ascii?Q?9f+3u9i9fodDa7EThh/J24wWha5KaxG77HqcfcoXLs6dWeB5IaI47pmPB5So?=
 =?us-ascii?Q?75V7cS7WN0HGz2sRdHtfmeJI7FuknWprHS3Jtg4HS8H87aXJePlpqJQBVIg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e175149e-5881-4976-bde8-08dc8a8b6a94
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4527.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 02:57:37.6653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5715
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] genload: fix memory corruption in hogvm()
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

When running memory stress test with the following commands,

  # ./genload -v --vm 10 --vm-chunks 4 --vm-bytes 1073741824

or

  # ./genload -v --vm 10 --vm-chunks 0 --vm-bytes 1073741824

The following error log will be shown,

  malloc(): corrupted top size

The root cause of the issue is that allocated memory for ptr is less
than what is actually needed.

Reviewed-by: Adrian Huang <ahuang12@lenovo.com>
Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
---
v2 changes:
 - Delete excess "* 2" when allocate memory for ptr
 - Adjust "chunks" from 0 to 1

 tools/genload/genload.c | 15 ++++++++++-----
 tools/genload/stress.c  | 15 ++++++++++-----
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/genload/genload.c b/tools/genload/genload.c
index 7f56d5272..a19d519fd 100644
--- a/tools/genload/genload.c
+++ b/tools/genload/genload.c
@@ -641,9 +641,16 @@ int hogvm(long long forks, long long chunks, long long bytes)
 			/* Use a backoff sleep to ensure we get good fork throughput.  */
 			usleep(backoff);
 
+			/* If chunks is 0, ptr will allocate 0 bytes's
+			 * memory, it will cause the process to crash
+			 * during runtime, so adjust to 1 */
+			if (chunks == 0)
+				chunks = 1;
+
 			while (1) {
-				ptr = (char **)malloc(chunks * 2);
-				for (j = 0; chunks == 0 || j < chunks; j++) {
+				ptr = (char **)malloc(chunks *
+						sizeof(char *));
+				for (j = 0; j < chunks; j++) {
 					if ((ptr[j] =
 					     (char *)malloc(bytes *
 							    sizeof(char)))) {
@@ -674,10 +681,8 @@ int hogvm(long long forks, long long chunks, long long bytes)
 				if (retval == 0) {
 					dbg(stdout,
 					    "hogvm worker freeing memory and starting over\n");
-					for (j = 0; chunks == 0 || j < chunks;
-					     j++) {
+					for (j = 0; j < chunks; j++)
 						free(ptr[j]);
-					}
 					free(ptr);
 					continue;
 				}
diff --git a/tools/genload/stress.c b/tools/genload/stress.c
index 7f56d5272..a19d519fd 100644
--- a/tools/genload/stress.c
+++ b/tools/genload/stress.c
@@ -641,9 +641,16 @@ int hogvm(long long forks, long long chunks, long long bytes)
 			/* Use a backoff sleep to ensure we get good fork throughput.  */
 			usleep(backoff);
 
+			/* If chunks is 0, ptr will allocate 0 bytes's
+			 * memory, it will cause the process to crash
+			 * during runtime, so adjust to 1 */
+			if (chunks == 0)
+				chunks = 1;
+
 			while (1) {
-				ptr = (char **)malloc(chunks * 2);
-				for (j = 0; chunks == 0 || j < chunks; j++) {
+				ptr = (char **)malloc(chunks *
+						sizeof(char *));
+				for (j = 0; j < chunks; j++) {
 					if ((ptr[j] =
 					     (char *)malloc(bytes *
 							    sizeof(char)))) {
@@ -674,10 +681,8 @@ int hogvm(long long forks, long long chunks, long long bytes)
 				if (retval == 0) {
 					dbg(stdout,
 					    "hogvm worker freeing memory and starting over\n");
-					for (j = 0; chunks == 0 || j < chunks;
-					     j++) {
+					for (j = 0; j < chunks; j++)
 						free(ptr[j]);
-					}
 					free(ptr);
 					continue;
 				}
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
