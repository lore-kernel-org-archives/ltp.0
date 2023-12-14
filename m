Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC767C4167B
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 07:14:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB33F3CB4A1
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 08:14:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB6633CF4B0
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 08:13:52 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 875C1601473
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 08:13:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tfc7sDlWupDPzRAy51oPc7jxtz2N8V7eFTLFqnbp05NYH3hV7dKtJ38XH2DSoulSf2Lg5mYnif1ozO044QxP8w03prjtMEjlEL4iTDroFq8ETRKnl47HPeeP8EHPlO19EZRTCESG2GUe4AA0K+9b6GW2fSTGUESLt82coXjhqAN+hJFm+GOdo3jPO6CdpceWThEecQTY2To8uDWD9oorJsOCYEC56t4qet1z3iNx2qlU14MtzwXyGj1qz4FZLTNp7qj/xFJuj5CjIs10inSiEwzK9zCt8Kg3/6OSnHuKsFCNHuH3dfxB9VKxyBYWb+2EiOKEWByPoa0MHYD/wI/pGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZILbSmSiS8ypzP6DgrKSPTVrFjf9ydiGr4HH9n2tEE=;
 b=C4gmBNeZHjy4GJd7487IKEJzXBKLT44EpeE35B/LXt2Cb+UhDRDEkBhuZxg80xYytwWFYOscEXK6P/9+BJxjJFM1PFRp38exLi2EP6wEQK+qXg1P4hm07QuDSNn1VS1FUDhMl8rR2XQpwieo3RE+CfT4ZUdP5XtibBpd7qgJ1UHTSr0VqKDZ9LusDdALXtQ3ic1fLXpCCHJ1i9o+9zvRXmvDhuF0ofeuyMNTFlJ3TCJZr2XR466DMWF+hr4e7MQuiSWZwBkLKEQtETcDIIZTh0x5/uooBnzhIAAlFMKQidyimZk9XX0l3/iPEsSsoVY8My5FmpQWTVPYhKMzpMc5sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZILbSmSiS8ypzP6DgrKSPTVrFjf9ydiGr4HH9n2tEE=;
 b=OSt3aPk2CFvSwxF+2aaw7eYC/N46JBGQcE+E0VG5no/v+gi+ephOUemF9+OU/3FYYlIwatgB1jWPjKZXIm2gqkYV3zgDuwfMclNgj2rp682u+lrPAXU+0ya/sp95n/BB99X9oWHlNkLANrjujO8YakukutIG62AXYw6NEnLZ+5Rth3My4JURBMCsheCpa5KmuABKfJJIEXLySJelAQuOVed/kJWLygsveHGPHOAkiIKusV3/mJTJuwz2JnNsSlW68tp2OTRAA1d0I/x/r6yQiwRcIZe9MnKarfVEmRn1N2/Q6tcUu6mDcZ+2Nvn6j5ZnDDk6eTBbXUwHqcxCr1FvFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by PAXPR04MB9153.eurprd04.prod.outlook.com (2603:10a6:102:22b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 07:13:49 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 07:13:49 +0000
To: ltp@lists.linux.it
Date: Thu, 14 Dec 2023 02:13:21 -0500
Message-Id: <20231214071321.9863-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231214071321.9863-1-wegao@suse.com>
References: <20231214063311.2325-1-wegao@suse.com>
 <20231214071321.9863-1-wegao@suse.com>
X-ClientProxiedBy: TYWP286CA0028.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::14) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|PAXPR04MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 57633842-2045-4d20-5ea5-08dbfc743825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fOJE9Lo2oUuBDcszAXoFb1v9gVSTyMuCBDRRhwf1XNKO6yzYt7Z2jRpiF3yLbzKQi0q2Z20orsa6FvMRrnAlF/KgExWVgsSdJ93xSz6SGf+AjgUkparspSIxFe6UNlrTC/yxjVvskjRRx0yZ7qquknlNxV0ES2oE10/ti8w/g+nhGdUxt0oV4GERMc5Gu4uRCUL+0giZdhaOnZRGuOBUPzOTy+LfdlyCHjJmEtiRYvxmqEiWhRkJD/PHP7Fjrr96mcGQ50iCAPtQPJE43scukSeRcBetzZTBNiw55CZMkscsRg6O8yp4Zb14WRF3iK0MDkPAfTGiVTcMOzR5kLZ1cR1HNuQ4UhKCuNUr66y4corMclpTQl+IfkmIlpjB2+Fo5ORk0JnfedeXO0MuBpyNPOjMA391r9sVttgnLSy7ps6EL91ed7tsuRgIFlp8Nd0mA1/7I5RUqUtYIK8XkEcWNCWArZanBGjNwCLkHtWiz5FUfGjp6LBXzecBlcHgezBBCoNODsczqWQf3M8rweBz4n7W3S00C4ioscBx/U98tkJ1JbmcI9L6Svd6rHU8kg9zXnGuxIk9pS/q0okzsIxFLfYRsOgUYX5jk4sQsGgswRE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66946007)(6916009)(6666004)(6486002)(66476007)(478600001)(66556008)(86362001)(5660300002)(316002)(8676002)(8936002)(4326008)(83380400001)(6512007)(6506007)(2616005)(1076003)(26005)(107886003)(36756003)(41300700001)(4744005)(2906002)(38100700002)(358055004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LNoG/YXpZpZfGbro0O8oD9OMDnaeKh88wezSM2FGBhGLqGwdHGKPcwxmjx99?=
 =?us-ascii?Q?R4ZOLXiiN7WUFI6dO6+iXA7WB8E5DWhQH0r18TPVgtXCgdwsy4YpSnA+8KUX?=
 =?us-ascii?Q?vKUJVjLh3syPuGM/81ZGvwyBaRQvfHaPrkFDB1ljtCSLSMucG4D1jyr08sMR?=
 =?us-ascii?Q?KHudNBKOr+8O4HsV1XP1lm+uoAMLBaB3iwUMU23bIz7bXYk7FnoOkjsI2Osy?=
 =?us-ascii?Q?PW//6sgU7OTIKgh3lX3/KobBHM+MnpFgUeJB7M1wPD/PqPDx5Nn2bZ+3/pAL?=
 =?us-ascii?Q?9Sr7mFzS5RfeuMzq2GOrBIlT4KVo3N9NWlLUyd/Pv01rO7LXnxqS2alIsDHS?=
 =?us-ascii?Q?FFLrXsgBlkZDdA0jN4ZSOgCMeddUd03mmdxt2sAWoY4eLLcm41ZZs64tGsa+?=
 =?us-ascii?Q?OzMVyHVWVyq/XklSjGx2LEyVyDarq1W/eDCTx9hqUVsJhQ7uFIk6r8O4+Xvp?=
 =?us-ascii?Q?Y5fuMOKl9VgS4GWgfhgQLRux2A8MFzi+i3LAHvxRAcxQDIONet9xkWIfqJrg?=
 =?us-ascii?Q?mf3WpeSgncVct71Ai3lH4Nzaff+jTpdWyDXKXrySJaFxfdu9C/m/Gz0nla5r?=
 =?us-ascii?Q?Hh8RFbNsvoXsWPqQT69/wK2g47X9PKZxL/2peooZPMWd+wUYhoUtyABPhR12?=
 =?us-ascii?Q?7EyoRrQzqKG3lZSa8u0EBQ//caALPdmd+t/iw1WujZ1KuzzWrRYXi8tn4bix?=
 =?us-ascii?Q?qmegSYy1vQeWhboz/GLcEG+NxyfLjREzYq8l2LmjfF7ubYZ0zy0Y9+FBH9BI?=
 =?us-ascii?Q?McRNxNBC5IFHghUwNB8XTIz//B2fiTgk5AY01te0Je0H61bscFSPix0Zg7jY?=
 =?us-ascii?Q?rwqIEFH1tt9N/OJxoR66S/uMAHiyaxU9uh38tCb6S2R1eEDC3NIss6kBL/MS?=
 =?us-ascii?Q?deZgFDm17v+hkvHQZltlbvb/K+dPAZJ9gi+RUEB3/bfKBIMqEpjyjIG/dKAT?=
 =?us-ascii?Q?sazCcNBZANq1NmjiKUb3oCWDK1GyEFKqV7+59rCcBqqr8DRGhrEv41/p8UVB?=
 =?us-ascii?Q?btK+THJLDyUnlO97IKaf6uYrHxsu8hDnXh3Aw+Ak4b4Fv8bbGWkwCwRFohhd?=
 =?us-ascii?Q?YJVBhKsdaILZrV/PNK8Dmhp6ndw+Wcv535TPmBaiMK3To9OXgBSen+QuVALz?=
 =?us-ascii?Q?zhUAHN5H2HhasLY7RdIlYYoJxC7GqfuzQnUH2XSF6g0tP6NA+iWbbUs3acG1?=
 =?us-ascii?Q?6bVxThw/Nz6m414gg5WQmcOyhwwGyF8F30S3DeTo3DMzIJD/UaitYYBQxiJd?=
 =?us-ascii?Q?CVeNRvJPv0B1yHqcQyFZtAHb4pZkIbpjNMSdL+n9OwsM/L1knu/URqrT9wKQ?=
 =?us-ascii?Q?PmM+LAN2ZLcwz+yl7QpUAWApJ6I5XvkuwF2mPozUHS7ya3998s5JEMo70lY5?=
 =?us-ascii?Q?MR4h1vpbWSWGDmpja4rzntVWZqpAGMPpeFiOP/8aP0HlEO07hPI1pbD0Y3sy?=
 =?us-ascii?Q?8WJc3e3K8pDcssfUiOjWiLm33Vd5KwBVKQa8A5thwofDq/2OcE35k7xXhDWb?=
 =?us-ascii?Q?n+n62ZJajT0sN42aG1AKmU7/j8c0CPXmabCUMXOkflXqEBva3t/KdpWjJeLD?=
 =?us-ascii?Q?bdk39cxznmXyw7yonoQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57633842-2045-4d20-5ea5-08dbfc743825
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 07:13:49.2719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQ7nl4/gfR+o3VNlLf5PsNeZyxzxE14RD4wzCE5I7k10bFS7AQgKRXp3z1Gir8bE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9153
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] swapping01.c: Reporting /proc/meminfo during
 test
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

Get clear overview memory status during test is good for debug, such as
get report before the test and also at the moment of the failure.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/mem/swapping/swapping01.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index fc225e4a6..f7724e7e1 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -83,7 +83,9 @@ static void test_swapping(void)
 
 	switch (pid = SAFE_FORK()) {
 	case 0:
+		tst_print_meminfo();
 		do_alloc(0);
+		tst_print_meminfo();
 		do_alloc(1);
 		exit(0);
 	default:
@@ -146,6 +148,7 @@ static void check_swapping(void)
 
 	swapped = SAFE_READ_PROC_STATUS(pid, "VmSwap:");
 	if (swapped > mem_over_max) {
+		tst_print_meminfo();
 		kill(pid, SIGCONT);
 		tst_brk(TFAIL, "heavy swapping detected: "
 				"%ld MB swapped.", swapped / 1024);
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
