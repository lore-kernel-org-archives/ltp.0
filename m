Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337A5C4167B
	for <ltp@archiver.kernel.org>; Sun,  3 Dec 2023 23:51:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA50A3CD994
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 00:51:37 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54B8E3CC395
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 00:51:26 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D11CC1A003D9
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 00:51:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzCsO2G7vtH8FOYhVZFwG+LJrPIrPMCSxV8LwHrnSWaowG944Li++oQhhjC/xBVhNnLUp61WVoGpa/qYjgFnfpLMHRUWCRRFpx9FmO8h3SKRlHYlqBxZ79iJYXUAh8VVhtw6EUduP1P0QmnNB8NIBujHo0dGZgQl+5qhVN6BCF8mQsHZWEEXw/7UvwCs/wxtz3SOljM++bO/hYVuVFdwu4iROxFstcSP5KcMppzPBlEXWsoxoGMCmIL4lMsFRIs43KHg5ASXx1bh/DNM/XIB+BYhb6FjIxvv6itXn8pDZ6k39CnV6ZsFwAgz/tU2KI3Gk/9WHXU2Wt0mSt55VgAZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvOfn4bv2nPQ5J1VKjU4R3T94wFz1saq6C2tQFgfDYE=;
 b=Fdxj3+srXN7iDCly1ihMlUimQj2J6ZUT6asdzEpnbRjQAcSisSr22uT1Tkwc9/ZVyIwx/DCl7f+OIgkSf+Ymwgt5FV5qUOK+h7fDPZbvdvzReldpQ7JNgFPl7oZ8tiZCUlO5VJ5ZVgLQ6HAW8xbXMPx6SbjkdNlbBJLVsjDrijZrJYhWdc9pye9I2tmtHCdant3tR5agDP05pKPUays/Oy3FMp0ZyVMOHQPMsxKrGTiAQ7aD7nHOgRgKZ24jBBnXlMCb5tJtETbTiQkINqF8XetAlXGMpPmeuupWdmR2LeIcr9HPnMmItj8xneQzxVt6pV511Sm0i9TwYm4U89hcyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvOfn4bv2nPQ5J1VKjU4R3T94wFz1saq6C2tQFgfDYE=;
 b=Ewe1gq2RHopPoWRvIPWefz6ajsCAIK2+69tK2vfnxUdKVLEs15Di7cycy0cO3Q0nF1nvFEl+ugrpIKvzJxmryl5DkB0AOD+EuL+NRR3nTIv7HffIQ5WemayzKnOjn8NSNtt5VW/FyRPvaDLSAIJF9TsDRSNKGL4CIC/ZpkWsIxy4Glnj62pj9noQ2UMn3ofLiilwK1C610zTfcSCG/3hxWXAgZ2Cmrfqj/7ntTc35q+YXFLdKCekCfImhsjsVzBwG/2da8j2G0LscfvaKRPdTEuwogbZ+139gF0XM/5aRamBbMylSiANSmda/XSH+81Roibq/WgkMajP7L/2zu96aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Sun, 3 Dec
 2023 23:51:23 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7068.021; Sun, 3 Dec 2023
 23:51:23 +0000
To: ltp@lists.linux.it
Date: Sun,  3 Dec 2023 18:51:17 -0500
Message-Id: <20231203235117.29677-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
X-ClientProxiedBy: VI1PR09CA0156.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::40) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|PAXPR04MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 09bc8398-20f5-4ecf-b7bb-08dbf45ac17b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vHTE+VHdTMHL4Ps5dK8hipkHwCbVIX8FSjKQQt8hU8lalBISeCGKBNLVDF/3zTOdYcmRhRZVRpHQMUwOuLZ2CFDrIXhWfvVAGuVlye0mXTadlivTuMDGt/NRMMxLs6qtMLFfDhwbLWUyEeRw1a+92fs2GeJsA3TzEXD4SuNHGFMo611ffEqv5OwaGygJSLau3O1XU0GAs45NL7it8674I0VqT/5uGgU2gj4Znjp/j7gv8HWAS0LjG6GPS1aAtx5s9cjJpr5TqQDjShcqBKPEH/4hCoc8FjKrMvv1+tJwJgaiA67X+RJ53bwS4AXzflaPAR7PfJxtNwUp55zggXirZi9i2RVsZ1xE1PESQ4ECngrgmBwKLxehmq3q8Pd2XST4LRJNNUNNqr0U6CUjbBO7AW1CIlBt9TfnTsTVWcvVzZT4B1MXYANWu8RDPjFtaRzWIslfIHMEZTRQ5nNQsY88kkQf+iQ5kqdYblFiSw75GvMn7vLBwgc7iCtVS2a7/Z5ngGPmy1wsIRnIyHddTF3tVTDYTZ3pQ89o3XcT94MoPHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(66556008)(66476007)(316002)(6916009)(966005)(6486002)(38100700002)(2906002)(5660300002)(41300700001)(86362001)(36756003)(4326008)(8936002)(8676002)(6512007)(6506007)(83380400001)(26005)(2616005)(1076003)(107886003)(6666004)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0WI8BWYcfT+RCQvdIKiQ4ISzjA5ggNps0ba9NbXa9Lvfsx3PjPWhw/DDQqaW?=
 =?us-ascii?Q?4eajAYUpxe3J20vDiq2EozM1XrLOS5iiRAj7oPaWpTMWKFkAY3Jvmz1+dDiD?=
 =?us-ascii?Q?UFWP8+go5EmUqgPZ08ad+v3oBuAR4Jz6H/Ym4idNrnD5ZA/YYUaozhzKIfVx?=
 =?us-ascii?Q?diSP5aZFPD59xJ1MfaXQd356LtyVFihF/YFlz+HSbnJb94ttBMRgtbEFnFu+?=
 =?us-ascii?Q?+RCIooE35+bDEiDuk75l02NJWYcNTNY/NbdMwxXUQ5XfFnUBS7zQiXVijvr5?=
 =?us-ascii?Q?9IqWYn4/liqvSEOpcoZBLjw25wGmFwFJVMgJJM80pqtmWIpKlDZPDB/wcKoi?=
 =?us-ascii?Q?RI0DE7qPJ/E/WglkSg+QKaemJnUbgtSh1CNVMahmZtBVAYWrwlns/x2b2f3u?=
 =?us-ascii?Q?0mrUsKuQYtL9Z17LRJk2uQlnkJ/KyWaKsciPriqVzNuyTJou9amtQkr0ntYV?=
 =?us-ascii?Q?RwDcYqjcpN0MztdKPJwgyBtZ3mLWgfxgxjSxN6PNR0GuRkfB9k8MzfFUgflq?=
 =?us-ascii?Q?tu8MRXDwLXDq7Ygah1/YHD9Vc6puGCflPben0bw2lbK7H3GneXEwMLF1NK9D?=
 =?us-ascii?Q?bnuw+p/zRq17G/yqGliyNASaWjrf4ntSNaWAmlX23DJxxOx3P5c5HsjLEIVo?=
 =?us-ascii?Q?L9i2khENJKjoJJTkwcAfmyfXFYJiEsXF6X2VWvjXTVv5/1nOMQ2gAgj64W1m?=
 =?us-ascii?Q?mpn9WElQks+VlMpkb/vyzN+uvMakdby/t98T/DSa+mwmpNrx+owOWQvQQM8w?=
 =?us-ascii?Q?qKEmRwFLHfRf5L04d9LGxOjsQX72TnrRI+DSa1gkNd+Fkhh82VjOcnJdb3Dr?=
 =?us-ascii?Q?wEy8l7eG+Jlxi/715b2JXMXvlZLSCOiUt4lhH+Xc5xUuBY9otLayAR44RIsw?=
 =?us-ascii?Q?NJF9Tc8cWLeOKe5erRlrX9JjqznMKzPxnjVyDMK0cQCCTPssMakSI0YKK2vy?=
 =?us-ascii?Q?FyMRaFZLD7q3mX0yertMCKC0yTn5PlVHoFPdSwILCzBHcwPyaxlr9OTTbd70?=
 =?us-ascii?Q?p8VrmhhHQIs2LyqAgHiKZfX+CZXJw42huP13ZmdSg+/+Wsfyi/fEs3j6lmxb?=
 =?us-ascii?Q?ACSWE9Wd9FVvXIgp1l5IwCa7jpC0gdvYaZgSNgxou/PN486zjw9iVe7Kqc2q?=
 =?us-ascii?Q?22maL9POeUCgU81appoYngt3rDojRMODVcQCVrOHCT7HNBtn1hYO2Xz+B3eX?=
 =?us-ascii?Q?OcX+bcdx6zMSlqOx56MMadWryTQTFYYbVFIYX80swH0RzSos4u1kFy6KaXO6?=
 =?us-ascii?Q?k7Ad0vYIE4QSDzFtPyjulfAMDZFO97RAd4y2Beh1sLUyAYqI4qmKlIJNtyTl?=
 =?us-ascii?Q?5MK4Z6enHmtYrYGXIvTWf6JTyuO1m4U0qS6oAzmUyFTeEzaW+XZcqNRz9YT8?=
 =?us-ascii?Q?6mHoU6fcGE1kIsC76EuyNH4gFQqCYiJmFqBvz9BacJ8sZHDAzvD53K9dcUu9?=
 =?us-ascii?Q?NzCCc9Ab6ImBP3iReY+9nPC24owtFW9ly94iFbpNTJHiLJiygvfaNaACV2ZJ?=
 =?us-ascii?Q?P35tVwB4p6jlyZeGsz5yzslngjCNU7irtxAz8cZbFbYto2fGS5y/pzcye38A?=
 =?us-ascii?Q?nZ0pwuu3JZxobeS0dXY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bc8398-20f5-4ecf-b7bb-08dbf45ac17b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 23:51:23.4621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2J2kWsGFCQVBMWDNyML6u7T2mMWXyxYxO2088+yTMcaDgiLf6ZZ99nlHyLbcfmiS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8096
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Futex_waitv: Convert 32bit timespec struct to
 64bit version for 32bit compatibility mode
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

Futex_waitv can not accept old_timespec32 struct, so userspace should
convert it from 32bit to 64bit before syscall in 32bit compatible mode.

Detail info you can refer following email thread:
https://lkml.org/lkml/2023/11/23/13

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/futex/futex2test.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/testcases/kernel/syscalls/futex/futex2test.h b/testcases/kernel/syscalls/futex/futex2test.h
index ce97f47c1..f9a031e11 100644
--- a/testcases/kernel/syscalls/futex/futex2test.h
+++ b/testcases/kernel/syscalls/futex/futex2test.h
@@ -13,6 +13,13 @@
 #include "lapi/syscalls.h"
 #include "futextest.h"
 
+#if !defined(__LP64__)
+struct timespec64 {
+	int64_t tv_sec;
+	int64_t tv_nsec;
+};
+#endif
+
 /**
  * futex_waitv - Wait at multiple futexes, wake on any
  * @waiters:    Array of waiters
@@ -24,7 +31,16 @@ static inline int futex_waitv(volatile struct futex_waitv *waiters,
 			      unsigned long nr_waiters, unsigned long flags,
 			      struct timespec *timo, clockid_t clockid)
 {
+#if !defined(__LP64__)
+	struct timespec64 timo64 = {0};
+
+	timo64.tv_sec = timo->tv_sec;
+	timo64.tv_nsec = timo->tv_nsec;
+	return tst_syscall(__NR_futex_waitv, waiters, nr_waiters, flags, &timo64, clockid);
+#else
 	return tst_syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
+
+#endif
 }
 
 #endif /* _FUTEX2TEST_H */
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
