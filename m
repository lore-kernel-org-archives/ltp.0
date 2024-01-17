Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781B6C47258
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 12:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1705496006; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=kJdQ2pv9nImXDfYnjowOG97Cydv0yxoLicTnfT0dbY0=;
 b=O1S7sunSsiwDvopdDuF5WSXJoyQ0b/Dxb2JqdilrBVuUwaEptHjLlWfpdg3kWUkm9ccOt
 wZtKSh38Ljv/UZ77+1CQWrETs9FTKRyzkXVZDv6TMkAN3E3L4trrur7++nxVfWYvEMcKy0F
 HXAhnqDl/75ooiuxbGYHsrYvKZpMGzI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E357B3CC9BE
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 13:53:26 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76BB73CE2FB
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 13:52:49 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DA6F91A05C76
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 13:52:48 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIC46FODeVjF2Gogs/a2hEeCk+dNHZBUDu39iILNkUstwN/6i3o8lRZvs23V7ZKR7JPqwAhrYI27MFqGBRCXRiWivc2LNcyvNPPqEU9tttLgqwvYzILhJZCLgjvrDRR20dWxy+GPt6AZmZ+Go/g9PLtltqnoEMzmbnfLx6EEev9RNcuRhrC1SiPh3M/VI7GNiWA4aK1+8xMZRIO6stwVJbD2eSRO4iZR2iJqQI7LbVSPpnr0coElcVXhHNJ/rpK3kzd12psZOfZMabCMRcdcZlgkJJQXwRXpSUVbja/B/zg8ozO5twoo2NzzFUHNz5t6jh/6W1di50lBrxOd2RzwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QdtZGed/5l/kjvnA10AlWPBlowGhJMa+LcIXXpFCOw=;
 b=MZgrsr88TGJ71CDlap7n7dLqVI0UCw6KGUvOn9uGnNj4wzCtm8xrK2ghwHzDyO23+20xnnm1FqcvvihF+L1qlxm/bukiabuP0F0Do3D9l6uZRhGb7SNRn1DttmV+Bh7WvC0HUr0LmqZ4XEYHgOGd7BLXIyIup9tv42m1Ykl1DttiVJYm+wtQMpJJp0y34QbVfj/Fd7QFfAfyIAP3Y3ULDnmCpdvy/YExFAHCxlkVFD10G4xngxg+wNswNbQIIZJJY19sjsdD2I4QNE9adU0GoHMwKtkWY8dzO4WUWfBm0jlyfZnkBL5gxeIfHbc1rofijL096nku7R2ZsIlPccNwqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QdtZGed/5l/kjvnA10AlWPBlowGhJMa+LcIXXpFCOw=;
 b=YgWekj6/2/UnROYe+aekPu1nUJe6KmV8BEFmX+0/b10nD5S4GPXCZZaEbqEhgzokRfAicDishDGZft6zbMsp+2zPpm2K43HB94eQX7yCFFH2YflNAG10BUNoylyTviAY5Yt/miMUpw5hzLHLg4aTPWKKCv32qlVnZ1H4ORWcc8KgchbQN/IscnJQ576wiMA/8+RDVGuwYRViY2xeeQDkTbizKzu4mPTe3gbyRMEFHp/9mF6W/YBzK9I6W8pKIa7lqBnDsiBObxEVHZLqzJKoDuFkXHIpgFH+/nGLAWOZLtXQ3RQZsKGGAIyvU0DzgcSmmk04tQa3ASHRecRS2wxKuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Wed, 17 Jan
 2024 12:52:46 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 12:52:46 +0000
To: ltp@lists.linux.it
Date: Wed, 17 Jan 2024 07:52:26 -0500
Message-Id: <20240117125227.24700-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240117125227.24700-1-wegao@suse.com>
References: <20240117080446.9663-1-wegao@suse.com>
 <20240117125227.24700-1-wegao@suse.com>
X-ClientProxiedBy: TY2PR06CA0044.apcprd06.prod.outlook.com
 (2603:1096:404:2e::32) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c9fd30-4424-438a-c835-08dc175b345f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NHuRXIUmrIR4ZIPAExEx2ko4YHaKxZ/SjLNkthP6t6YAb70hNy/JPVtXv5PeMQ0d4ZOMATTuDKKyLQ3pqkxeADhd2wA1wwogRcvHA8L9RbzbYlmD0ZoTaAYJEJeN1B3OOTcpPIU9uNWzoE/03lVwjJwcP6WM53+vJzy5aDWQsUsNDSj5/3bpiNnFY/M6tPyhaMikSOcjkiA8oLDvOdGp8RWO/sXoZhlCmAPRDp3ptSOTwu8WC6CW5qy+o7DlCIlR3ylKJGTA/f4f6TeJFevDEZG3qMGypvOomiLeIdTmraHXXj4vychZ7p3YbeN2ByWYb8ych42I2563RkvQ7lKjcVE4FGVqjW9zoVfSc85Caouc0avHsgyP4vXXEUZWr1Q0lDdm1zdZvI/ZTdxQqA71VtFqgFDremTqAo38mVN1Ftv3uiIIZX2rTtRNVWXV1av9ZY4AnrmlPS/k0gvniT5Z2WXqLoZA/n9/BHNDZiNxYjYBGyLC8sm6g+3KdHWNadLlHvyYIIvzezenzcqBACG/0/ldVtuskgh15qgNbtRJWnwnfdSK+4tIp4bnSxtgYLKE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39850400004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(8936002)(4326008)(8676002)(5660300002)(2906002)(26005)(38100700002)(1076003)(107886003)(86362001)(2616005)(36756003)(6506007)(316002)(6666004)(6512007)(66946007)(66476007)(6916009)(66556008)(6486002)(41300700001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cuPasOtHi0ntBEcVjf7yusaA2xUieDtA+qa9M1OaQK37HQOLMi2I4NmcLSdi?=
 =?us-ascii?Q?7Nbl1ME3SZIiruyE5Ii+yzx9bY7gwFxY6+m39nk02aEJXMTZJ+/tj72y5+8j?=
 =?us-ascii?Q?MHuFx/ghga0JzNLpddHfH5O57ZAn+xFBaPF2wzwzlMf+VOJifhv/+0xud2ch?=
 =?us-ascii?Q?dyjYPlOZDa4RL5jY/gby6tl/xe9oORlvwyBP9GlXHjW5G4EBvYGXek0EApyc?=
 =?us-ascii?Q?wMR43GhvMIWDN91NKx8muKX9+9JjwvX4QTCIHHxcqV6G0BUm752xwOSM1rKv?=
 =?us-ascii?Q?fccAKZOaMk/h3KAFGB3acfev291WUjx+Z3zestKvGZfl0aJMtcOUTV+hmPlx?=
 =?us-ascii?Q?eHqaAUT6SRUAcgDUL41vSMEm4svkjEWMbH8nStS4vfp9+QylGAVCo/C97rEx?=
 =?us-ascii?Q?UIGGXdzEOVTtUsmmGh2PhdEcQLfrT5zpOSsYzlkVDaUT8ReZP23GNnxwA2cx?=
 =?us-ascii?Q?j86wRqCXuP3XWEiG0IvVUxZPFi6R1BRWrkILSrp5FlEOojT8CHXX13O3RPkn?=
 =?us-ascii?Q?jW8pFIiQgXxaoiRHW+d8PL1j1zEOF9yUVLTxAdLjcPjIHkC94gcHFBCTiXP8?=
 =?us-ascii?Q?EhsuH4MgcwZXQzUxpMprX2r2KX6N4y0LJWwdUcxk6IpKqDIozEP49nJvmu1P?=
 =?us-ascii?Q?w4EMxID0XeAi0jdiNDex2dpkw21vGuOjlydTtr9qqjEljw3LdBMajd+lneG2?=
 =?us-ascii?Q?ceiJfuRyk5py6O5plWqSQC5JIwKZzrd/8HqFsDRn9dgSmC6/0nDrRgjKR4bp?=
 =?us-ascii?Q?rZV4tzeBQBRMIumITDsH94JlwZ8hrQaB2D9Ez0B6WSFUTqghU2blEqWxR/rv?=
 =?us-ascii?Q?emKQ1BG2zt85JIYJs9j2GlbxF3o0SZH4mFmxNTxUhMXQQNetJdjbgnlChwVM?=
 =?us-ascii?Q?eJGD9EYttE1pJwDrmYC06zf3+KrSUZ/RdfQexlUEzIWiv1cMcHYziVqKiLS8?=
 =?us-ascii?Q?uUIPG9j6CKT4CQqrjZb91Ih+iRrnogG741QPVr0RIsps6Z/r+R2yCyHxhJ9/?=
 =?us-ascii?Q?7SnjOqByV05UfbxvXGZfMIuiNspbEosAxL4HeE0+3DXbTnJfULLJ8XWCkHLp?=
 =?us-ascii?Q?4htK8dgBc9XCjgIAP2ozjTsLy6yiURIlKKArSLBRZWz95pKAhj2x26fS3Dmi?=
 =?us-ascii?Q?q33h6ewpoCRQlyi0iYbpbDuFGxzlEr40cDkQ40NgHW/E3htm8AU6FL00J3up?=
 =?us-ascii?Q?V2uiBbtHLbwfpyYsVwcutiEHqBk16yGEr7oUho4IYsXN0VVNKW96zFGvU9V9?=
 =?us-ascii?Q?P97t5blX7/SUfBHoXWfsUFcS+XmFR9cDrOEk5WaR4hdU2TDje/ETaGIXEihk?=
 =?us-ascii?Q?JvfSLlQ+BqZxN1sb98UYI3Vbr47/P7tyK41j7rrkbHI77G7hev/ZXz9jRe0A?=
 =?us-ascii?Q?Odn4dU+odo+Gwbn7SJ6ms8cOGwaf3ffIMMSK3rSw3BRMvvgyE3RSMsFD4q1W?=
 =?us-ascii?Q?J32eWt6cUUbqEiixhufVcNkSRqxNdWvN4+jhGkjI6tw4v41IU5oq6bNI5wA0?=
 =?us-ascii?Q?ch9+4MEXQVJTFJZ+vR1CBD53A20/TwSKxBbslbcJySmqRJq68BeO8UvwnwnF?=
 =?us-ascii?Q?VSWhFUQyiVcbEi2Fkmk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c9fd30-4424-438a-c835-08dc175b345f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 12:52:46.8941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mdqz6dq7chOqvGwpqxsJUeFHYiglwGiKG2BLqw5HkjRRuoU78ZV9liB5AdA6s+P8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] lib: TST_EXP_FAIL_PTR
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
 include/tst_test_macros.h        | 41 +++++++++++++++++++++++++++++
 lib/newlib_tests/.gitignore      |  1 +
 lib/newlib_tests/test_macros07.c | 44 ++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 lib/newlib_tests/test_macros07.c

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index d2e50a219..5866d18b0 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -227,6 +227,30 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 		}                                                              \
 	} while (0)
 
+#define TST_EXP_FAIL_SILENT_PTR_(SCALL, SSCALL, ERRNOS, ERRNOS_CNT, ...)       \
+	do {                                                                   \
+		TESTPTR(SCALL);                                                \
+		                                                               \
+		TST_PASS = 0;                                                  \
+		                                                               \
+		if (TST_RET_PTR) {                                             \
+			TST_MSG_(TFAIL, " succeeded", SSCALL, ##__VA_ARGS__);  \
+		        break;                                                 \
+		}                                                              \
+		                                                               \
+		if (!tst_errno_in_set(TST_ERR, ERRNOS, ERRNOS_CNT)) {          \
+			char tst_str_buf__[ERRNOS_CNT * 20];                   \
+			TST_MSGP_(TFAIL | TTERRNO, " expected %s",             \
+				  tst_errno_names(tst_str_buf__,               \
+						  ERRNOS, ERRNOS_CNT),         \
+				  SSCALL, ##__VA_ARGS__);                      \
+			break;                                                 \
+		}                                                              \
+                                                                               \
+		TST_PASS = 1;                                                  \
+                                                                               \
+	} while (0)
+
 #define TST_EXP_FAIL_ARR_(SCALL, SSCALL, EXP_ERRS, EXP_ERRS_CNT, ...)          \
 	do {                                                                   \
 		TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, SSCALL,              \
@@ -258,6 +282,23 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 		TST_EXP_FAIL2_ARR_(SCALL, #SCALL, EXP_ERRS,                    \
 		                  ARRAY_SIZE(EXP_ERRS), ##__VA_ARGS__);
 
+#define TST_EXP_FAIL_PTR(SCALL, EXP_ERR, ...)                                  \
+	do {                                                                   \
+		int tst_exp_err__ = EXP_ERR;                                   \
+		TST_EXP_FAIL_SILENT_PTR_(SCALL, #SCALL,                        \
+			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
+		if (TST_PASS)                                                  \
+			TST_MSG_(TPASS | TTERRNO, " ", #SCALL, ##__VA_ARGS__); \
+	} while (0)
+
+#define TST_EXP_FAIL_PTR_ARR(SCALL, EXP_ERRS, ...)                             \
+	do {                                                                   \
+		TST_EXP_FAIL_SILENT_PTR_(SCALL, #SCALL,                        \
+			EXP_ERRS, ARRAY_SIZE(EXP_ERRS), ##__VA_ARGS__);        \
+		if (TST_PASS)                                                  \
+			TST_MSG_(TPASS | TTERRNO, " ", #SCALL, ##__VA_ARGS__); \
+	} while (0)
+
 #define TST_EXP_FAIL2(SCALL, EXP_ERR, ...)                                     \
 	do {                                                                   \
 		int tst_exp_err__ = EXP_ERR;                                   \
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index a69b29e24..4f43899e5 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -40,6 +40,7 @@ test_macros03
 test_macros04
 test_macros05
 test_macros06
+test_macros07
 tst_fuzzy_sync01
 tst_fuzzy_sync02
 tst_fuzzy_sync03
diff --git a/lib/newlib_tests/test_macros07.c b/lib/newlib_tests/test_macros07.c
new file mode 100644
index 000000000..45bba8409
--- /dev/null
+++ b/lib/newlib_tests/test_macros07.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Wei Gao <wegao@suse.com>
+ */
+
+/*
+ * Test TST_EXP_FAIL_PTR and TST_EXP_FAIL_PTR_ARR macro.
+ */
+
+#include "tst_test.h"
+
+static char *fail_fn(void)
+{
+	errno = EINVAL;
+	return NULL;
+}
+
+static char *pass_fn(void)
+{
+	return "pass";
+}
+
+static void do_test(void)
+{
+	const int exp_errs_pass[] = {ENOTTY, EINVAL};
+	const int exp_errs_fail[] = {ENOTTY, EISDIR};
+
+	tst_res(TINFO, "Testing TST_EXP_FAIL_PTR macro");
+	TST_EXP_FAIL_PTR(fail_fn(), EINVAL, "fail_fn()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL_PTR(fail_fn(), ENOTTY, "fail_fn()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL_PTR(pass_fn(), ENOTTY, "pass_fn()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL_PTR_ARR(fail_fn(), exp_errs_pass, "fail_fn()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL_PTR_ARR(fail_fn(), exp_errs_fail, "fail_fn()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
