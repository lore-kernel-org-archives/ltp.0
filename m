Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4531C47073
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 01:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1704936448; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=hYa5f4uf41L/DdENjqEn/6ypg1XnD5Z9gT5iz2AA2tk=;
 b=VXHVUsyc1N51giiZcoFYu23/HQIYH9MGplXJnscZwe5PM53Bi6FhDq47TCofhuFZWVVHh
 Ya9DOhOb6vcfNvKsu8m8F9v1UECABbHsX2qyMa9VM4RNHbK9LoaG/aWyyLgoAne8n6CSDG3
 n9O+kLQI6RXnJLkKIOGURqtHY88ivJk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8C293CB22F
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 02:27:28 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E40213C2674
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 02:27:07 +0100 (CET)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 686CF2002A5
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 02:27:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgdJd3iQk3LghXlvgLgWNmPVybu2xc5rvzqoJe6oedRqK9HHBxQaqtLzt4ntuG4xH9TlXwC3FiK5Q8NcFDeWen3XSUisMKv2h4XnfprpxJHu5FjQDjjy9ckig3b7qsD2wgbs9UGQoSET9Y3yoh/1xk8Vo5Gt8+9F0mSXmgk8zpxU8mXiK7AUIsO6eyimmfclbiuyAWkzqlLEWfVb3fKgy+efoYiw9bJGYbt5cpXhPN13KPTuEKSZwLz7VABY3wAvzGR05qxk4xC7/v9ZQ5rgc13kvvOZxEDeZD5Lhc3KQeY3xaUbDaDTm0j8EGFMCH+ImSNzfeLkV1Y34PzKmIBFhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJzBDiNqdmzPcki7ErbeX/DYcuH+s9ZcijJ2JeYSqwM=;
 b=e3h4agm9nNb7aDGRl3uMfxYuHgRLYPLwq0XGzGpfGJ4dB1GXy0nHDArO7QzUUqBaMtwk6nL2robOFUFnVbrULYmCP/RUyfZfkKVqnrTte7T70rx7EwLp/S/w7qM/hPOciiTHYtNsTiy96Ule+U/yXVDJytgSXrdKto8uDc94ZQEiPzrD7K4YQGyUS2fnINX+4cHoRV5m02b58E1zCG03deRRyN3nMfa0hBpmm410d+Xb0l5VgMU6rI0tKb8zozBim4fTB6noaY8+zNA/G1sOx81UKliHZyjgWiDYqjgZRFujN1O31xmnUW+T5/GCqyhXcB4Gm9t5KMhb2dWn+j7DqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJzBDiNqdmzPcki7ErbeX/DYcuH+s9ZcijJ2JeYSqwM=;
 b=FCAdBjPsfN6/L8X8UuwyCNiZ3zUq8SYV+Z26W0ZFaMUss6MK1Z+ZYxBZuwSLmnxOt70sfVWbJjfUYxG/+KWRPp9tVatojP+nYhr1sEaXsv9cMKhR03Pm43yTgPFquKmivtSWg++nYgmPkZn/W9/qZyX/6GpoYoNSEjkvmgjHz3iYzoEcNGJyd6WcPLJkE2tA2sDg3lwHRfIEtxLOovKq52iC9ahOPvhU7+nA/hyIFdBfs1XuIVSrovwmwcVs4AeQf1ERL1mG82v27MJcgLZiIT8IQpJzrFiR4tgTCGck4MjVdKqw1xiPOzyr1mGjmTY+HkSvyT4vPkPC9qt7KoFJLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AS8PR04MB8803.eurprd04.prod.outlook.com (2603:10a6:20b:42e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 01:27:04 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::c9bf:bb1e:181d:a2f4]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::c9bf:bb1e:181d:a2f4%4]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 01:27:04 +0000
To: ltp@lists.linux.it
Date: Wed, 10 Jan 2024 20:26:50 -0500
Message-Id: <20240111012650.9731-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
X-ClientProxiedBy: TYAPR01CA0175.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::19) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AS8PR04MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e6409a4-0027-4adf-3246-08dc12446a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZW41ho2FGhDhe3qvLde+1mbslKHyP64FEck70GYAeqffjWjNEPb2UG9mLmfCbgpMQl9Pbs7ANv4vTu3FFinPNrHmAiUgkQLjOKfJZQlQB+PITYsHHuHVDCkSdlCKtJbBVm2ciVqFsKRSG9eVZAqsGqjJwBFPd9SbBIEeR2QYzAQSi/9IaujHr+5LnSbZdqwnakkzNn5a0SufRIfFE/w3YXMwXV5zRZRpALNbKCq6clUEuh/tifygTj0D07AnBshDS63v9lIOh7oq8SAGV9wdNMRtnoHLiaZOTtIGI7z1TCEqbB0h5ZqS4EIPrh1jcNzjVlZ8jTAxpdb+17VRHVNWe4+d8QF1V3/LkkCzUikuBOoQrDkkCx70YP89gd+xODevDZCNKwYdP1WqVKqg6JbvmPo1ma64mwNXfWeKVK/7DQ4RDlt1WDraPJXfxpztQAnngDu0OzvcfVFu3FOfrJgNPwPwRYDdKQRnY0HYgiPGrV1ZqioqmfRDMUPIYDGMhKirYfiMBe8VXumffSqmMcxRmkCOeyNw1IQw8Nj6uvytpxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(136003)(39850400004)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(966005)(6666004)(1076003)(478600001)(6506007)(6512007)(2616005)(107886003)(26005)(86362001)(38100700002)(36756003)(41300700001)(5660300002)(2906002)(6486002)(66946007)(4326008)(8936002)(8676002)(66476007)(66556008)(316002)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3byyuAAF/y9bWPFA5VQz+7RUgjAO52Tz0ZMM0GUIvvH2efjO/ot5eqd68UA6?=
 =?us-ascii?Q?kBX5MlE5zKl/Du1z8rwDUvyI21SCjoiLCFlZwnjIMsBQME+4iJNFlNRXXp0B?=
 =?us-ascii?Q?Bw/yX1f7bdEmKVPBHR+8z4GtT71BTDLnConu/o6Giqt2zmlVZq4e1M0JIyaQ?=
 =?us-ascii?Q?g4DpfNsHJgkqJbbTkrBbSaprs0gNw5P9k01PBOZUHhOPAc4x7CTgeVnmPYzh?=
 =?us-ascii?Q?i1cdU4+WphWwsUDq8+c2emsdcg0UjdGcHxQy0gesqfuSTWruxMACGuLwZrQb?=
 =?us-ascii?Q?cBh+xRuE85X0W+P+ShZEuY+WOYFYZjLqaZ6+oq+QpUHal6MJGbim5R9jojPL?=
 =?us-ascii?Q?QHxJ1pGwexd8YfGfF9VC6RuCdI9YF21S68blAbFnk+2BUD9E/Oiw4zpnJVeO?=
 =?us-ascii?Q?YD94i0/nZZfXzQOZOiFp6qUEnZk/J44trSLhiO4/U9OVcYBlcud/4y2dCtWy?=
 =?us-ascii?Q?+qmHlJ2UVtjhr63GYzHEvWNyLk070XepPjhOdTF4xe97PGVnClWjUKVMRY3D?=
 =?us-ascii?Q?/XjM1NKc4X5eR0xwNzQtMd6mFw06S0MfkSe80hbSJm83kqruf5TSd99E9fvW?=
 =?us-ascii?Q?WV1Oy5jXN5Rz8b5hD+Zbukxx2W4x9f9Bo0Lolxtb2vZFY8tKKxaj6yKCRqTK?=
 =?us-ascii?Q?XH24FiVLMPH6TnDHCtyEKUVHpLjIsT3ib5j33wfdxQ6xzslBU6TYnH1vldCo?=
 =?us-ascii?Q?SkbQKbX8Y3EIGyNi/MgtYTrVPKHLQhPNDmi5IuRSnUxP91N9Txcw1Q3n/iTy?=
 =?us-ascii?Q?t4xFjEgDkxgkH8liQwPMUOSM6HZrcLR45Z/iiAQys3CFPDEP37QnX+jlVnAf?=
 =?us-ascii?Q?zY4adtGMpUwAyKZ+UFxRZmcLJyvnRlmFjQCQqe3Em3a6LWttp0nEhjiP/rpe?=
 =?us-ascii?Q?ng+heHOTnKPOZztbmBfRhxwY9XshSgEQ46FuCkAB+4e00ftfq/UMf/eXLVzl?=
 =?us-ascii?Q?ADsnkkTh8SSoW/UBwYsld3egyYZXt2mHmmPGi+MovzTjjSxbRlPnnupQUwHX?=
 =?us-ascii?Q?1DGcFOJu3diNfjv6s08RsSxxV2jNsVb6ue+M0btFRPqq1cJmr6xXturobPgy?=
 =?us-ascii?Q?L/Cu0okw0ZVqs8A7Xfu4EeCZeVJI2ILNkVbmdUvO0rzBX3iPq1rtMa6jQ/76?=
 =?us-ascii?Q?J8ywUPfmio4sMn0HzSodkVQ41rYivO5xcwMkRvfwry/PMs9vVdBuoN6VtB1x?=
 =?us-ascii?Q?DDYjgWWx+b3LQ0VoYMg/DmG+sCCBkU02a1hp4/SFP7vpFeE0OG7mnEvOP0Lg?=
 =?us-ascii?Q?mjIzaywcRgKA4NP63conAnaJH3gLuml8XxdD8MeSd2DGXXdqkYbBkv+r3IgR?=
 =?us-ascii?Q?nxDPncVCOehAD3q/lUv91UbrAd8qCLljLg0VoARLWdkytlAauv++6rxaOfLT?=
 =?us-ascii?Q?W4Gg49JfQ/fTNC2LJ+1PBCecRTVHlNMesipTkRU85yyf7l4lgGEGnRy5uIyg?=
 =?us-ascii?Q?7wKGZaDb6lHHnRZFR9cVFDnC1UorS8kdFTuSpzjgzGTeMOl3lvIVfeaXNk+c?=
 =?us-ascii?Q?cckAHdWPd86VUjO1WD42WTo91wWqQNNj45AmAnZ+iW6GRUrhHxU2yIZeEhh5?=
 =?us-ascii?Q?3qOx+gW4r3Bd9/0qM7Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6409a4-0027-4adf-3246-08dc12446a6c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 01:27:04.0951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCbz0zsCNHMayvdVBzB/Lt3q9IKkMmbG050wr6I+ITg3AjDDel1inR+wQU/JbOZF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8803
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add TST_EXP_FAIL_PTR
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
 include/tst_test_macros.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

This is draft patch and should rebase after following patch merge.
https://patchwork.ozlabs.org/project/ltp/patch/20240103115700.14585-1-chrubis@suse.cz/

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 3f4f9f11d..6e45e0b27 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -212,6 +212,26 @@ extern void *TST_RET_PTR;
 		}                                                              \
 	} while (0)
 
+#define TST_EXP_FAIL_SILENT_PTR_(SCALL, SSCALL, ERRNO, ...)             \
+	do {                                                                   \
+		TESTPTR(SCALL);                                                   \
+		                                                               \
+		TST_PASS = 0;                                                  \
+		                                                               \
+		if (TST_RET_PTR) {                                               \
+			TST_MSG_(TFAIL, " succeeded", SSCALL, ##__VA_ARGS__);  \
+		        break;                                                 \
+		}                                                              \
+		                                                               \
+		if (TST_ERR == (ERRNO)) {                                      \
+			TST_PASS = 1;                                          \
+		} else {                                                       \
+			TST_MSGP_(TFAIL | TTERRNO, " expected %s",             \
+				  tst_strerrno(ERRNO),                         \
+				  SSCALL, ##__VA_ARGS__);                      \
+		}                                                              \
+	} while (0)
+
 #define TST_EXP_FAIL(SCALL, ERRNO, ...)                                        \
 	do {                                                                   \
 		TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, #SCALL,              \
@@ -228,6 +248,14 @@ extern void *TST_RET_PTR;
 			TST_MSG_(TPASS | TTERRNO, " ", #SCALL, ##__VA_ARGS__); \
 	} while (0)
 
+#define TST_EXP_FAIL_PTR(SCALL, ERRNO, ...)                                        \
+	do {                                                                   \
+		TST_EXP_FAIL_SILENT_PTR_(SCALL, #SCALL,              \
+			ERRNO, ##__VA_ARGS__);                                 \
+		if (TST_PASS)                                                  \
+			TST_MSG_(TPASS | TTERRNO, " ", #SCALL, ##__VA_ARGS__); \
+	} while (0)
+
 #define TST_EXP_FAIL_SILENT(SCALL, ERRNO, ...) \
 	TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
