Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C242C35274
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 12:23:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8FE53CA6C2
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 13:23:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB4D03CD836
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 13:23:03 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 200AD601B17
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 13:23:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyK13l1FlviGqdhurcd79R6kEK+cBvemInjSq95ZJocvBKDiq1uOEaBfq7plJjv3A+Fs1hwtE+eOe7Ehsb1+K/M5ValB7RENxkFeS8Ngkj1QAOoYq2kC5sbRxF48FekFI7ch0NOWQ1DAXOyuMQvmO85jQcO95ghVnT2Y2Eg4r4vbnI+DWmDNGSr39I69Pn6edqY1NbNcHw83yIXuiof4cypz6Asf1DweIM2+Mq3FZqcXr2tE45pmJE2GyeltBvKLp1EJk6hlwiH44r+g7AJjUAcbo1kirfw5F5Jz9Hga0QrUBeIiOwOdecZpLqRSE0FIc9/Yb9u8cMErkKpZ01x2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqEjssHW5XiOMv/r/Hzb1jTTywlCRVEbmzhZ4BDEGK0=;
 b=Lke3K3HMfF/QrdQud9CynXkqmQqOTCYike62uGR7qqlEgcT0kUP35USgVnbzvN7egBM1CUnPzXhdXDu7pSXcXxBnFSB6wBU5oPRWMzFTcRhf34avtIKcMW1OB/O/H+8D3pbywYclGOCKUAKISjPpISPTcvM7m9ahDTsvPRLU+0y89nmEQDw7tp7p3LHfJjny87S20I1UOHGYriYXXABuveR0Pmhtq8RM3z5ZvbwF/Dut6NhbcvGNw0q0j+sCRhoNP7UQc048AqhGllTlFkeZsK6El87LeGzj0fXFeMmWqFkaEaTNM54ZjMRXjuLMJjgCWf+l6YzQpyH6MVQ2RRzIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqEjssHW5XiOMv/r/Hzb1jTTywlCRVEbmzhZ4BDEGK0=;
 b=L5x8Qf9Y1hF7zIHP983WOY34pU+tkNjxZYs/ta9LM2+UJcjDKQm7zMN8q+vCAHzA7M4/QKZqntzbY6R+jKM9Y1eQwu3rqfe69/mP6vBqrzEC52QFmCH7vT3IcqW72Cvb/l9BM/CWrC+bRr5Nr4fdHrm0CrqB9+d6fNTGrzqNBc+mxpKcq8YDTkCb9jJIPIT8oBzAWuXRG71SBC6Axm61ZofChNxA00lRf5PdAmAR+UyvaLXGQvomT8fjpN5LmfB7wMYen0trCKQN8ZvyQnP1/QA3nc1tP0BZDyb/mGk6nwjQF8sA8Fq1wCzv85gUsWqZdSgeDRd5Wv/QtGzUjS94BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DU2PR04MB8968.eurprd04.prod.outlook.com (2603:10a6:10:2e3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 12:23:01 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 12:23:01 +0000
To: ltp@lists.linux.it
Date: Mon, 18 Dec 2023 07:22:36 -0500
Message-Id: <20231218122236.24917-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231218122236.24917-1-wegao@suse.com>
References: <20231214071321.9863-1-wegao@suse.com>
 <20231218122236.24917-1-wegao@suse.com>
X-ClientProxiedBy: TYCPR01CA0155.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::17) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DU2PR04MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: c168af50-7bcd-49c1-4933-08dbffc413e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x4C58R+ZPGpXIKEfPW22UG/lXCiKSSMSBLCi+QEdOU/3L8aGCgKR92H9DQGqJwJIJr7Mg6PfB2AbhbCeZWESub7RYiy7/NdnNpMCoui46tLWRA77vxNvdqLSSHj2OOcnzD3k4mdzXmNvX5mn9eYeyM9N4DHvijHnseBd3JAfquXHgv7slLMsKyITI+19ajlVoLT9yNcE8XDGV/ZW/G7JpvUutf8RjPTOT+ZQssThkfAw0U6+mOFXNH++TZP9b0nLFuR65Je31gAjZOqte01BkR67De7AQ517ImdS2jRmxVg6cKPwjcxBzYaQwF9d5eLaCe7B/JaNkSFy9UrdJTbAGePle3+higBZC2NbhYnXhQbnGIO6T8aiZU38qMGTFCXA/0P4gtsuLDp2WSoz85Xjw6iPyEmSk+7J+N7hsJORtgd/ZKJVPcdtudlz7f+tbq8ocV/hApe3ditfb7fO3+aL8ikUDL9aQJku+OsONZT7zOiLIe7Eg9dfK6D1oGyca4aELA2XUZ5PjDbEswktL0QEsWJ0iSLh6piL5ti7wkjAGEGxOuObkkdaNUTOqF0grmHhVaTEzka/hG2dscdzc1r1D9bBDEUZXnPd/JOhXoeOvv4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39840400004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(86362001)(36756003)(38100700002)(83380400001)(107886003)(26005)(1076003)(2616005)(478600001)(6486002)(2906002)(66556008)(66476007)(6916009)(6666004)(6512007)(6506007)(66946007)(5660300002)(4326008)(41300700001)(8936002)(8676002)(316002)(358055004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?01gffyBaIa7L/Whiia9sWHOlkF3dZKxtp53iuWAIET6wecieLQFF8pz1e/lU?=
 =?us-ascii?Q?3ygiAc5J1DmIADR8nwd7L/HCUN80Qec7rvkvNUdIVXH0ZjSEuBOiZd7ekkO2?=
 =?us-ascii?Q?jOFW39519geY/cgnsZxmfGvOQp/qBSjHK3thDM6jSjTMa95fZrAJgjvrEyCo?=
 =?us-ascii?Q?IyOq3zmVydlrycmC9OovLwNmPffgL5pOX7+dqpCETGXS1AGlhtIbELSXUTLF?=
 =?us-ascii?Q?hZ/RgMZQUWhjrnpOIVy4yofvPfSx/hkVlR81TfpTBMvXWvrSWYvc9xLysy/Y?=
 =?us-ascii?Q?Y2ms7Dcsp1ZeWRPKWl25ouJafFatsir938mLnLZFZvCO5C8AnbJ9wcnLOJ2W?=
 =?us-ascii?Q?F+w6CAdq6MrZ8zarbvXIgcagxkFIDYTfDfw6geHvqeMOMk1vLJUNFGEmXYqL?=
 =?us-ascii?Q?tDR5bd5YnGMW+rYWNKUvvHU+kCTd0etJdKcz4Yt/Adr3eeSZ5UnMMBeaL+LT?=
 =?us-ascii?Q?0mtuy0ShnUc4wjeoNkwvRekuDGi+nwRSixPOUT/fwptqTtYcmY9iiWiTSHiO?=
 =?us-ascii?Q?gyRXtsCdBrml52OZP8zUZ1OGEUD8ePKFJMeigzW51i5bqHRy3rE8HZG59KTQ?=
 =?us-ascii?Q?G2Le+HARwmFDDcXSsHzYFIflj7781W4M/ROjVMiDP8SDnXUXEn+Fz4e2gYvM?=
 =?us-ascii?Q?o13AidfAmhpQRtF6PoF2vXZgqcKcIyuw/0SSOw+a7LxhU8VNuzuCxgBtq0g6?=
 =?us-ascii?Q?Q4HiYnP5XZdkxDrFO8gIkLfKrfMMhRPs5DeFG2dlnK66IIQ7LT0W9QSwMLT/?=
 =?us-ascii?Q?3yQeSwuvJdx95UOWQCQdW/QwE7qF1FXW3ID5Vz18MHm9LD3XgOuPeZSXMphM?=
 =?us-ascii?Q?6yS/3Jbd9Y+mLe469cwOePKBx+OMcZB7NzWudiW6SQYqon35k5ADCcyDI9bh?=
 =?us-ascii?Q?OqguUPE5414S5+/62aORXg8wzpnyyLdhKEXNcCCBT7w/1WSNoMosxGIwUq3m?=
 =?us-ascii?Q?jVFRar39sGOGQ4TS3osx7KxmNpj7556CzSCfQsYCCiwl26d4AARiLUid+1bB?=
 =?us-ascii?Q?qqfKeoZ5mjEM7ZqZWuswvuqZBW6+10e9Gs9DnDxbM8ZkcwwlRfVD5As4MoAK?=
 =?us-ascii?Q?c+2CSOrmJE5E2jvsg2yWgUsgWy7V3YKPbSM4VwRWMmL6dNkL+eS1aoeeh5jl?=
 =?us-ascii?Q?/mst7/fBttemyzcaxmMrGGfyZTr7oR7+eTv7ojpKEBchv5ijxUfujnrW62fh?=
 =?us-ascii?Q?oNnLp905XBCcQIEuUzp8clKG133ZqmaWlIdPW8zoZgmjaLAGyxmEtxc8bIJ/?=
 =?us-ascii?Q?GAcqh9zsXq9FcRy1IE9FnAzkQTT9Fg81EZhgZ5m0SCNCf7thiXRi6CinfDpe?=
 =?us-ascii?Q?+CeY9W5h/JkadMwmXiAvj9ew6MoDjSsSvXxoSJFoBEUoM4qMC6zY7ITLmhjh?=
 =?us-ascii?Q?/0MlnaJmmooXJk76Z9HRVkx+FcoKcxRdHScsRRrh+BlxOvFaikXUFgW0WLJ/?=
 =?us-ascii?Q?vUmbnNpo0QldYXclY8V5/0Z7Yr2673hQaDgZ3AgPowZpEyzuIdvidqx5Zjmj?=
 =?us-ascii?Q?lB3aen1y87AGIJtchGbGuk8/RAP9OZZYsn87tYPL0PywUJ6/3r5hCd5OaQDJ?=
 =?us-ascii?Q?7E4v/UzC56eDVBhfBgI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c168af50-7bcd-49c1-4933-08dbffc413e0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 12:23:01.6131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihoD61u4eprYgb+aGK6DvjFOnbB++uviGIHgcHEpk0lIce4TvjOLdhUu9GftPo0r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8968
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] swapping01.c: Reporting /proc/meminfo during
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
 testcases/kernel/mem/swapping/swapping01.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index fc225e4a6..025f44363 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -83,7 +83,9 @@ static void test_swapping(void)
 
 	switch (pid = SAFE_FORK()) {
 	case 0:
+		TST_PRINT_MEMINFO();
 		do_alloc(0);
+		TST_PRINT_MEMINFO();
 		do_alloc(1);
 		exit(0);
 	default:
@@ -138,6 +140,7 @@ static void check_swapping(void)
 		swap_free_now = SAFE_READ_MEMINFO("SwapFree:");
 		sleep(1);
 		long diff = labs(swap_free_now - SAFE_READ_MEMINFO("SwapFree:"));
+
 		if (diff < 10)
 			break;
 
@@ -146,6 +149,7 @@ static void check_swapping(void)
 
 	swapped = SAFE_READ_PROC_STATUS(pid, "VmSwap:");
 	if (swapped > mem_over_max) {
+		TST_PRINT_MEMINFO();
 		kill(pid, SIGCONT);
 		tst_brk(TFAIL, "heavy swapping detected: "
 				"%ld MB swapped.", swapped / 1024);
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
