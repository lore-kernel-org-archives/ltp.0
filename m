Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E21C47258
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 08:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1705478719; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=uSm3/XRk/8WHwahlOJg5tGIg3XOhs9cmO5BufrmvMaw=;
 b=WNcPqcJgbQdb0p3YROfhIFTOdjPvCcvnsLQ9hb1QCjPge1zmjiwUyWm0DXfJn4l4/zjfF
 y9kJAK5PPCJuID4/LmPBQcZDnyMP4zP3U+W0i0avX38OXMBqP8waFZLcYGcKQX//4cTP7yU
 VnBfHFzciyxh9m93Q17Rw4hjjQ5YVjs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DEFD3CC96D
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 09:05:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C98A3CB542
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 09:04:58 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 90ED51036E54
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 09:04:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jiy+j87jf3HUEWtMnAO443VS8Cgm8dXImbTwCaKPFq5knmwvdDQ9ScvdhVthJK6JXeGyah2qMjlqG7uzQ5zn3hZu47dCT0FD32vdoAgogQ+sjhHlAxv67UcUsNV52xtORJqF0nZkEoEBaFN+uK6lsfxXHcqYh6khMyGIq3SBnwFG1kUfO8cgjyaxsOQJUCDOwbkTBCWJrxl5cUVvCwo2OlY/C2wCtynRU7OiLWFFphr+N2frVF8hH8wZ5NQdFgE9eltVI+4BY3gGH4fLCzmJWt/DNNnQiyaf+SomuY2FIbeV0QoPrhYH/Wx1+2W2/5dPTNRLOavvZEB4ZHLk/Hipzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+Qx16CDl6HZKmE+GCCFhAZOoK0Po4N5kUX4jR9pUyg=;
 b=ktmhtdcZobfI8b/pyEuPg2l2jIW26rbFDGTp0emmlctEY0r/5jpFLgE01QIQEYq5M/MpDkobRGsqrDgqmzas1SW65m6GQuyIS5ArbbITK3xBtA4HLS7oIG/IOTjaeI5fALANT3K5uyXqDbN/S2/scgHYzG2zmMeFgZt8HVc8Jtl2QD9a4uLJCzENFnE/sPpBsGvFf08YMJNtexQ1asU71xG853kyeZLA8IHFPtHmWi9L5D0QK6Xr84bjweDrOOhnT+W1+Gi7g1Ccds+Od10kiyG6j/MmwZT2d4k21DQ4BL/XBVoOozMDIlpSbI2Kk+oGVgo23Wtwtf6KdyXU6tVrpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+Qx16CDl6HZKmE+GCCFhAZOoK0Po4N5kUX4jR9pUyg=;
 b=rWzJKW9S+xogoCOcCgJ1PsF1ok4P9ZrwsIxVZTFXY5SCvn3uNKVIKaw59raMku5TvDRMiEsB4q3hpF1Z5UGL+x0Qkx8MWW3v0G3RRsMbDH2zpDi9w4FFRrfUZnKnUu2xsbSmsKmGF7zDusVUIpIAKpbqzGw+3kt06XXsFzdIiakR0dSlIPfKapVAvoxI7R0WwEiExOYHCEObwWnnhz/tCaTpVZoP5HkFmq9sSxge/Fcs297LvNfxtItHI2GLtEXdFSEhibVwDdnzsNGumxlwl4GgpEs4ZCJ0XGk1j4qU+MmrgVMAGm7tmdY7gJQ8BideZddddlk1jYQ6c7bj3p93ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DB9PR04MB9789.eurprd04.prod.outlook.com (2603:10a6:10:4ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Wed, 17 Jan
 2024 08:04:55 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 08:04:55 +0000
To: ltp@lists.linux.it
Date: Wed, 17 Jan 2024 03:04:46 -0500
Message-Id: <20240117080446.9663-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240111012650.9731-1-wegao@suse.com>
References: <20240111012650.9731-1-wegao@suse.com>
X-ClientProxiedBy: TYCP286CA0184.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::7) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DB9PR04MB9789:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff6ab6a-9056-4790-4c7d-08dc1732fd1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgxuu6YAbXVLNNCI1uZOOs5XYbgoBB3G6nLIG9Wm2xAx3stRXEE8NAyIRq35HNpEzEW5/ZAv/lm1bdYA8+54O3KqiSVABQF6VWcTXtkK98PBiaUVOyCCOkQ5JhFb6GlNP/ZvrWiwtqqpA+a7BEpXdNFn+8kxo/UHuMoHNh3fnb21JSBhH0gYNoHrm1uOv8cPCwCUSgwhSF2lC44w5s6AmcGqWg1fP56RIBjkn5bkl2ZKBVV/Az5sOgBKpgMWbvQWcuzx9Wi1/9VcTAHcJ95iMfGeUYvKlAY9ok0nHzfj7lVSDLjJBEwr8MoVVaFxjI2836q51AMGGHamPB4eUefLfaV7s6Q7A21l9EDy68wJtKDih1dskMCpkTzgYaMi6Vpq/Y7N+lRBfAjTgf+3V922extBw1FUU+5d46CefvC9n3/bHScICU7OKlEz+8P3pLJ332ev2GkkxhXRbqPRyfl7g+nT5eHVfxrMHMYi1sCnUPknJ52qOhNIBfEDiD/V5zrLByjT/UIutZ/QjZ/LVx9tR0357H4nlV4jxsN9SXA+THzZd9wcxENuEfwMfQmXgnUK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(39850400004)(136003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(4326008)(66946007)(316002)(6666004)(2906002)(6506007)(41300700001)(66476007)(66556008)(8676002)(6916009)(8936002)(6486002)(36756003)(86362001)(478600001)(1076003)(6512007)(26005)(2616005)(107886003)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uvMHe5wxTo0NR8XpggBxqLEwTODbqrYYM1nTrg7BqwxrJbblcySX5hLMJOKX?=
 =?us-ascii?Q?paFmbpi+w0c3aj3NJwjn7EOdTLXDde8hzal/kQQeTcEhFJfT/c10JII5GelR?=
 =?us-ascii?Q?urQkVtWBRCa1E+kTz/pejk5cJkwORcvBuISLG2tMewwvsMvT+HMwPJVwv9y9?=
 =?us-ascii?Q?rw0A1mv8Q1t7ELfhd1+6BDSL+YnZTboLV318lx9q8fpaZGTygWhJZ8hrfyh+?=
 =?us-ascii?Q?yYOXqkDuIZ3dO3vIDjqA9pUqIUL4BJ9He+MjrJvW+clLsobHjFD6Efp/Ui9s?=
 =?us-ascii?Q?argvuUak/G/uDf5vQatLoog4NQiHOWjQTwe2V0p8We53NefXwIXZ7LSvrcDp?=
 =?us-ascii?Q?gp+YZXgINS8W2G6ZStVSMrCHV91V0/aRoD2uSZ/xxfKcGWd6suJPMkxgHiRn?=
 =?us-ascii?Q?ak8JCAZBld7uCDJPfGIc2wsWcg6waPky6hKKiDo5jOIQ4JIaW1zIsiMn3zii?=
 =?us-ascii?Q?0E9edPIPZIAqyDa9HMMz2yqTrTgD4jfp/ccEggXoB5i/1uJNSY/7f5pOIm9s?=
 =?us-ascii?Q?WGdiCmZN+gKV6zT2MS2NWw+ilQ+fr5k5tmxRdOsMaykgGT9lRqav/tJlnPBE?=
 =?us-ascii?Q?B3YazhnhAleRp5OWfBq6CEHDpaX268scAzCNmmkv+LQbLrBE7UDEbKujrtMj?=
 =?us-ascii?Q?pTz/xYxbhwekNVJxaR+2D6Xo4dvz7jPa6SfnxwNpHnl7GvQ1iZvoz0hJtgn3?=
 =?us-ascii?Q?bmSfjOi4q9f/RGM6ZEJHzDwnYV7bvgbJ7fwTzJt4Rj8aanBtV5KI1j2kFpsW?=
 =?us-ascii?Q?NjXCylEWqe++TqtoWcm9IczS+hnqKvxMj4dwW2fzQp6l7x8ZAHlfMe3SVmEd?=
 =?us-ascii?Q?I5Ki2prz3l1nzGroIab5kAk/fwy48/Jjq8rpMmZF02jS0NHwYBQw4X+ZH6Np?=
 =?us-ascii?Q?TKJmmS2nJbwbbJ5I+ghRe9b3VEfeV+UsOw+DoG5t76fO9fICC61Iw2RsYQlq?=
 =?us-ascii?Q?hHFKSxuxoe8a/o8A6GDgTEuH33a+IiTx0obQQLjD3ViX8pq8enC9mfDW1iCE?=
 =?us-ascii?Q?dqcvonHpizNoKMjc2vmZCQ/tWNUGlF1I9zBxj41AOTYqll32otC3w3NR9ZoI?=
 =?us-ascii?Q?QcvT2z9Om/jRh7vpOV8tl6DB1a0ytYUMGON36sRvtEDxhuMITrEIUbfwXCLG?=
 =?us-ascii?Q?cmuvRgz3jlYjtP2kkZqECO/6fgRkvtIqvLRdriXOE/GkxzhAuL+kHiHnWg5p?=
 =?us-ascii?Q?8ei9JKaMH3LCaNfDMdn13qIOHnCSMHYoqua7tsEZwbsHwV/ClTDsO5RCU1m+?=
 =?us-ascii?Q?Nw8WlnHglXuwzjHPD9cmrwSUeAkFUA0yNuWk0RaPeHncsnooUED5MB1xvtzK?=
 =?us-ascii?Q?nphLGhMROF2ALiptWMNrphtLUukO3o8UwV3JDgOyFf8Rljhd98OmBg5YTt8q?=
 =?us-ascii?Q?e7DlwPDKUvloUWHfeRBwNM2kLVKThuWogJUpVEOSMcvMDLiuq0wjBodMToc+?=
 =?us-ascii?Q?Ou9uI/AbXO2pFOLFH1CAOK5ThB/p8W1gWvPNO6/YFnzzHJVD9QQQNuUWpOES?=
 =?us-ascii?Q?Hnt9x3rkSTC/ZlJ+QfcFZ8ConXgF1bxX2tDSqlWPFDb3Q+aHZh6+BQIz+BfG?=
 =?us-ascii?Q?rYzhOcnv+/Ls1zdz1yY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff6ab6a-9056-4790-4c7d-08dc1732fd1c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 08:04:55.1724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugYc9SDsxQuG0jH/zANAnppHzB32svNlGJFjo5VgiVR1oSuNx7NOyfL87YbfLXVM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9789
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add TST_EXP_FAIL_PTR
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
index 24fd324bf..409e6847c 100644
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
 #define TST_EXP_FAIL_ARR_(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)                  \
 	do {                                                                   \
 		TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, #SCALL,              \
@@ -258,6 +282,23 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 		TST_EXP_FAIL2_ARR_(SCALL, EXP_ERRS, ARRAY_SIZE(EXP_ERRS),      \
                                   ##__VA_ARGS__);                              \
 
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
