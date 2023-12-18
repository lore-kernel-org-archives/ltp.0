Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAB7C35274
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 12:23:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1D813CACE7
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 13:23:08 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D663D3CF34D
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 13:22:55 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 09D3C140004F
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 13:22:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AY8jLaWQqKyHkyeU+hFk+sPIHB1Nn+JixKAQ8cfnDvtJkM8C4Cg7Pellhw69k55WriGZma5A7sV4S9INdSDIyqF4OPlf+SaCNqLoN1HVOQ3Jwla2XbwNtJLaJu1D22z5S30V7nnIdtp2mhiOMYpnpN8FVzmHKA7Z1uvTO+daFGV3shQXVmYzIYRUs3+QpcpRNJ9MLi4Wox/wU/2fesO2du9RPhOv2AvOMhQw4Z3I+i1hKrTV02UFw4QUfrY+058Mz5HIlci9lo3ZV2EvhWpf+r++0UOwzzzv4ambBtpjPRghbDXSVAmzelh4iadbx8uq45bhoDPXaTgBRy3hg65HuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeFp+ad7TXaoNnxoJ+/c2NXUQlO3HY9k91vMVpdvkVA=;
 b=gpRdj8XrAmJo+yxyEU8ogys4Zng1hBWeDtolnOhtvmguCfFTbJ0O7lw+KlEIZbulWeI9/CRRc6BuFwgJsrDKjba2sDaoHRdMAKt9dza53UgXDR9eEvtsA3hyWSUgzRAOnz3zWhkxI00J7ycmQK9HlA4Hpobxl93jfjqPFcQv41PfIUjNNyyNcxUxp6s5EmqlewrY47+Pa0u6Uiv0dGVrC1SSV3l+nwKbd6Bsw4ur7VUxpX1DRIQWkQ8D18C0KCc5IwEopnur7YTDl3u6+JREL7KwPIzSWIgAZJWUPNTikIssjmwsXLPLtbHfMhGCh7W0gfewJqAhBbsEmR9wrehxOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeFp+ad7TXaoNnxoJ+/c2NXUQlO3HY9k91vMVpdvkVA=;
 b=hiz/SwA2mIfcwHKhTtr36v9i61L578+AshP6uKry5VXShQs8vsONy9y6WYsPVtcUxAmLD2y9V+9Y/k4LY+k6a15i3JH1Iq6P9MJ2xHIvGqKZKFbbltmEUUFWTrN/LjPUvLyGa7eCQDkfcXJPtkmauxafqkh73OcAQ0vbSJVOZW6b8BT816RjAQNBePcCJdEOiPgGPjSxcxrKGXhBS5XFVbdeyBundshY1ZXYj3yBfYyheM+3gPCy0nJzJ8wKyp1jj5FxXX5Yi5KtmYgmld5qbiL1Xxo6r0BAaFOEbaR4rsGv4qaQLoHKV0QHcp9xtjDII8aMi3iCsNLnZxbQ8luTBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DU2PR04MB8968.eurprd04.prod.outlook.com (2603:10a6:10:2e3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 12:22:53 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 12:22:53 +0000
To: ltp@lists.linux.it
Date: Mon, 18 Dec 2023 07:22:35 -0500
Message-Id: <20231218122236.24917-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231218122236.24917-1-wegao@suse.com>
References: <20231214071321.9863-1-wegao@suse.com>
 <20231218122236.24917-1-wegao@suse.com>
X-ClientProxiedBy: TYCPR01CA0165.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::18) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DU2PR04MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: ef38d57c-24dc-4ee7-1a47-08dbffc40f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxwQ1XPLNPESrgNAAHjrZw+Am8BHv0vWoIh3+29QJanaO7cGS1GvGigxWM0MagmR55IuxFENfsj3rheXf0whbbfMiXdEENPiRe60BkpLyskryZY7OdwTESqT7Z8onl6zzLa6e2ufxs4iGCq7+FXjKKidsAca3U0SL3f2YiXvoj+iG30PVFX/zz/eU/DLjlZpfJTv6yv1ZsYIA+GkWL7eypXb3ioUClt78OrDUsy2PsVtLbOkQMPaR62nEN0TPsPn/49ZEQ4RWz3WL/WRSs9Cbh+h26eudSmR0vj5l9wIBL6W5sgxlQ1DDXO5Wtnjh6/gsUST3M7EPtRiMEjERltFgm2zN8yD40McytShZytKBqSdE25LymaI3Wuf1iv0ab17ibyVxgZTB8iAZ1Fk6UTXM3hNT884OWvROGFeMJvcFElcPByvKFzZl00tMnw9Mg4IDCrpQi6ChhtWdQe98zMcLA8nujXDWHXto3pLi7Bp2h3CFvLu9VEPw6RIucAJwRlKb5eWLlY9LNEL6agvMMlRtEYrWB3CcHe8XdbAjGv82QYlMUBWYjBkGeOu4eWNbHhl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39840400004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(86362001)(36756003)(38100700002)(83380400001)(107886003)(26005)(1076003)(2616005)(478600001)(6486002)(2906002)(66556008)(66476007)(6916009)(6666004)(6512007)(6506007)(66946007)(5660300002)(4326008)(41300700001)(8936002)(8676002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Juk2wyQ3Jr2AyDAhYnoPrTcKHqg6/ISvDC0lEADIAOtm84YqYntJR2z2MOPQ?=
 =?us-ascii?Q?zkbGQ7AH2R/WtFHBjN7zR7momCRSQxQF4EneEswnT/414sEOATr22VoElJKr?=
 =?us-ascii?Q?a7pCfOHfFob09Zpb9rr+Zk3shua1hf6z+T+0KfIxcoXeLxxHu0apSajPVkq+?=
 =?us-ascii?Q?Lg0AV/tWZIuAl+nikrJLpI7GrKJLPCfdvFgDZG/xAGNNmOwXCO11+QuqpEo9?=
 =?us-ascii?Q?owl017NupRbdVOzk8s6Qnpt3FuaqkC8+ia2ffOp8bphBd90o0nT25pyFgglA?=
 =?us-ascii?Q?3HDPBfGm/JaK6RZKhoXRbDbTmYPYi/RXHi/8ffShmIYP/BQcvssODDfUNKru?=
 =?us-ascii?Q?6L6Z8PLQ8ztGkSNP2jC4dujn3egxCsuO8//wPO1jPNGKW1VyxR160iCMVOLq?=
 =?us-ascii?Q?T9HfxMqI58+2MCEeB3Ahe9KPZSqD/RRTkHVOhz5OksnOX848hqEtn+ZHVE2r?=
 =?us-ascii?Q?5rkvSDAuKHBYAjENgAvZVPvD+otwtvqIA2fMzOXKBD+VMbWB1lRsriTG30PZ?=
 =?us-ascii?Q?Wfuz0qFgabf2RaQXudZL8vv4lRpCzs8K5eSDJ7/tbvNXL0e0+PDkFjV82iO1?=
 =?us-ascii?Q?QopR1U4jYu1B7fisa0S473ax5Xv5bSUPhCjo+1C47nlDhn+Pyiz5ohtktQIx?=
 =?us-ascii?Q?52VsLPDj1UBO935lWSTLKqtYrKVbx6TqsSJa3htZZvfcXdmsW/Nl/3kW+LUf?=
 =?us-ascii?Q?JLxjbxUUn5qbVJ1SGB4yLENSYFRNDoeLPD7e1XW6l3WD1KUEHYP5gR5naXVg?=
 =?us-ascii?Q?2aXjkxSsCAHCTuTux0X6ZPG7kfEzFPdqJiZwJAB4cv2+dxcHyWkcLSAsPFa/?=
 =?us-ascii?Q?Ur64h8ZhaT9HKfyPOGIov0h7btrNhLxUToim/TUIBp5tC4UNbd0se/ZBtccD?=
 =?us-ascii?Q?UeY7sNvRim6306HTXUN61yxBDoXRQPxbhzNY0KlhTeD4H6e6av/mpjCZud+I?=
 =?us-ascii?Q?p/Df7tXTTKUiIYhod6YYpzxl2bD3N2iwEK3PLnbf7LatP8DqU5+mfyIFjwF9?=
 =?us-ascii?Q?ECuFU78w1evIpMzUpajGlxwe6Lu04fS3DFkw2kCZil5PKo7OKS+2RoPopm1R?=
 =?us-ascii?Q?ouR89Fx+xQpctd2WBJBlRrvEhILTk3bLUJIRBAyXp3m3eDN1vTtr/HkLa3GA?=
 =?us-ascii?Q?2s2OIl5m6SAClU0rBZ+aI/1vpAtLVL8y+Ih0I5f2CTPR3XOCm3DqsQdCKhv+?=
 =?us-ascii?Q?bNVjyZ7pjkTGsWckrjh2CUEhDnzv37jt9MIuIc0D7QCUSK1PkpW+Bxnos8wF?=
 =?us-ascii?Q?mwtYOlrpbiXzYGkz2U519vibwTUCgmTcdNFOOIYMtTeDZMD2j3GYSjGOqXsP?=
 =?us-ascii?Q?BWp4Xwe7nu4xg9ti3meo7+7ZoVTvOCWXhYYNFklyUDT5uDTWRDYxMgUYFL09?=
 =?us-ascii?Q?a7cMBvFbXK1jIyk85rP3POQ1iwWgGsiRJ8glxp+mYb2SPYQTYDfPnzRwouNL?=
 =?us-ascii?Q?PtxjfJHkjG86/k+yWa7DUXAsxNfbnewF1loSd6vuUawhKQUqj9WNdqHIs+2p?=
 =?us-ascii?Q?Mq2Eq1/fu2Lv6Neau3rVNs+N/y18uhNmGo3K3X/LYOn1R1abC9BoMz1iFK6I?=
 =?us-ascii?Q?Z9wP9y8ulyXINbyC5aM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef38d57c-24dc-4ee7-1a47-08dbffc40f06
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 12:22:53.4936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIzr3w0qwY8lI1N800Gb20Fxh43NUZmXNOO+2rNsHrx/Edsc64SIeoa+DBQea/lD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8968
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] tst_memutils.c: Add tst_print_meminfo function
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
 include/tst_memutils.h    |  2 ++
 include/tst_safe_macros.h |  3 +++
 lib/tst_safe_macros.c     | 13 +++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/include/tst_memutils.h b/include/tst_memutils.h
index 19b593430..0dd941ced 100644
--- a/include/tst_memutils.h
+++ b/include/tst_memutils.h
@@ -58,4 +58,6 @@ void tst_enable_oom_protection(pid_t pid);
  */
 void tst_disable_oom_protection(pid_t pid);
 
+#define TST_PRINT_MEMINFO() safe_print_file(__FILE__, __LINE__, "/proc/meminfo")
+
 #endif /* TST_MEMUTILS_H__ */
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index c899c4f2c..f2ce8919b 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -21,6 +21,7 @@
 #include <dirent.h>
 #include <grp.h>
 
+#include "safe_stdio_fn.h"
 #include "safe_macros_fn.h"
 #include "tst_cmd.h"
 
@@ -671,4 +672,6 @@ int safe_sysinfo(const char *file, const int lineno, struct sysinfo *info);
 #define SAFE_SYSINFO(info) \
 	safe_sysinfo(__FILE__, __LINE__, (info))
 
+void safe_print_file(const char *file, const int lineno, char *path);
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index 7f28d43e5..024963bab 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -610,3 +610,16 @@ int safe_msync(const char *file, const int lineno, void *addr,
 
 	return rval;
 }
+
+void safe_print_file(const char *file, const int lineno, char *path)
+{
+	FILE *pfile;
+	char line[PATH_MAX];
+
+	pfile = safe_fopen(file, lineno, NULL, path, "r");
+
+	while (fgets(line, sizeof(line), pfile))
+		tst_resm_(file, lineno, TINFO, "%s", line);
+
+	safe_fclose(file, lineno, NULL, pfile);
+}
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
