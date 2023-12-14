Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEC4C4332F
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 07:14:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 408CE3CB54C
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 08:13:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 190913CB54C
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 08:13:43 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7F2AB600CFA
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 08:13:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8qZ5vjCqiufjHAndILWwAIV8UEDnRzEd+k87qQCQa4d0Ki3iZvpPYLXPAHv6mf7iNlrfdcQib0NevUkt6Cs5/qJcStE3udfrTcOznK+Cm7GhIXK+bliZYODzj5qtJYLl6QhbrKYs5LtRkU/YpWi4LweoZmoWYyqkfOX+0ya5517fkPJSQNXNMHwXwbUOYXyKc5/FuCTOV66d4C0HwawTXixa3aLrlV7Gp6LbPCci4Zz6KmgjMT1d6Pa5BNouxJr3Qh4jmMNWwmxVav0mQV5gIQ/r03s+Eb0TureSiQG8Jszp85GLtJylNU5Dbt3moK/53l4wUzo5yLcw4Ezd5UuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snKjEWB3rAXba6/Q2YTE/ghSxyKOxj8Ey7N+0soEZQU=;
 b=RJqNC8BhVjEVi/+DVbipUXqJkJr+4J7uBryf//5LG0/4DQm31cvmDjRQ82hjpcIVWvCnBFVvYupZHvQTGaOND6AfJQ3QMR5m+RlHwPpAYCZWmTrnhSQaDkdNh3kntFgGlgADAB6IdsVm3hyMQ9JNRuml2Xy4vIg6Lnos2GYxGlpEfcbybs1O6PFMiMgABmqzn46yfjoIiC6b7eQW3U6BRijUm+sAvJrtxF/0Ztz9Pl3L09I5KxV/VfTPpawjib4uqJbEH57aE8q76XokKWVBgdM0J38fHyTmH2y2fAm0+LilK5NOKJKJmk2qz675VHxb9YtOShpnVWnkIvRDssVjDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snKjEWB3rAXba6/Q2YTE/ghSxyKOxj8Ey7N+0soEZQU=;
 b=Ay5gRVAkBjmKxMHYsVhd6HVOtOuLRGMtMs5xFQCcUG1GHuNJtFTELtuhp5rkjDWSgsvEXS0f+hViODeOpHzSPCC3GpFv0BzVv3v0SB3+FeaGhYo3qKtOFQ+mJLpPiF68UeLKEoTUW+FzPNzeuWh+Ifrl+r0WWwrvkKrW7+XbnCBXbwC91s5PmLN89tSB2l61nhvBSeC+ohwEOKBQcQ7gqXmwFSCS2VW/v3GA3elUVZ4C1VJxHWfyUiyP284jMpqIoLeWABVVVto5z9nmBWA70dwAs+fYewTjLGYReS/Lnh97vhF8pSDovtwL811JxOGQpNCJDvugTxEnRPZIRo0v3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by PAXPR04MB9153.eurprd04.prod.outlook.com (2603:10a6:102:22b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 07:13:41 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 07:13:41 +0000
To: ltp@lists.linux.it
Date: Thu, 14 Dec 2023 02:13:20 -0500
Message-Id: <20231214071321.9863-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231214071321.9863-1-wegao@suse.com>
References: <20231214063311.2325-1-wegao@suse.com>
 <20231214071321.9863-1-wegao@suse.com>
X-ClientProxiedBy: TYWP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::6) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|PAXPR04MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: ae58a1f5-8160-4560-e120-08dbfc74335b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11g4LS56eDxRWElLeIUyWOhJZQnER4xuEuPcwI/MfRB1pBnLPTGRwWfZFT6crau0RNa12rSEQdyHBWN0zRlfRs2/dZT9VAwy3LQoCkImey3dCrUDupVjcJxg8ut4dEvbNMijzkUNqWFhQIsSq2WB2dcjmPC/MROEshABUNBljajtTlsnEUWoWycNJ+yFPGHR2GTGNHBZ1n1DJzswkcU+6UUnl/5yAE1GeH5YayhU3wENjW+7oABb8BcGfOx4RPcJHva7BWm8HCraENIlkXLAnHV5Lf/G+/UrYg10UHcbwhKKRl0vBJEYOgFpK1wOOW78ri3+EYp+1LkPa8NPeOqriLsbZiLg0EPNg7LrlIZVKyec2nFK/jrBTczgS0WXnfVrfDoB3LPBBTH8kDSH9xIYG46s28AGJg53XQrg3CBMkj+qshkei6c0JLg0YCf04ecMnQuiG5qARg7TuUKIcQI46w00YpxxPd9UaAVwhr4B7Ur70J2X/0NcbNc4Txzp5xhLry7o3hrXpxDU3stdQrpBHiqZy9i30a0AcTW+BEThpGUpF/9k1wgsfxXCsnOw5Nto
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66946007)(6916009)(6666004)(6486002)(66476007)(478600001)(66556008)(86362001)(5660300002)(316002)(8676002)(8936002)(4326008)(83380400001)(6512007)(6506007)(2616005)(1076003)(26005)(107886003)(36756003)(41300700001)(2906002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+JVm7z1+3RSV0dffDfIGAPNv2YL921uQ8EP1tVIJzHLluAwBPnTUXeH0cFMN?=
 =?us-ascii?Q?bPyHIC/xFuiICfYWFDMdqNQIssx3BiPF0qCWVrpZoHDrurYtXu7kam+Xd8sh?=
 =?us-ascii?Q?Y0SSeTWa82HNXvy+2RM+ik0MVxkMBt5CLPGsEJawIU/wPmlUFniDuNcUBjam?=
 =?us-ascii?Q?vehbFxtDB8vTYmvPauy255gtbItF4DWy4wHUSFnU4Yk4hRyjQMBsctWeq74/?=
 =?us-ascii?Q?fCH9MS2A9UDBWO89TJpg6+LddA0qRCeTzcZWofQ3z4N55nfrwSuSLAhi2Jeq?=
 =?us-ascii?Q?IWeE3GBX8SfHsY6n1HCzqBwxYkR9Hjid+l+D1LT2Fojq5sgAqcKf+rYyVw2/?=
 =?us-ascii?Q?mKf+i2tcfmu2plRr39/8Z6GSsEwX+JPU/vkV+Fj1rEr148b04eNnFUhBpAu8?=
 =?us-ascii?Q?X9cLjjlue+N4V68E0NxCrMQu2fhMJkvBnfbCr8CnvtnfCgtPB3XdDlbQxDL3?=
 =?us-ascii?Q?ZX27Y66ovXdjRf0zH4qoRDE/X26+0c6X9AgljngxTN9U3RBo/zF2M1JKB3pC?=
 =?us-ascii?Q?RTTqoHUg3jfqzlTtoNIy9tL4fnU7eb0LtmEL0y/dxKyRHfXVNAlhGvUQEbOZ?=
 =?us-ascii?Q?bin1xV6DJ5pKelMYAT/lsCRuj0T+fRGZT3TXZQQzp1dVH5m/1lQp6VRP+8W7?=
 =?us-ascii?Q?3VikBpfaXvs3WXKFqKBZvwwx0QnXdPgUx0ePVUFjdGvRN8PshGfnM5UBjKsv?=
 =?us-ascii?Q?pvHNRPhBjEpl/wa+HMWs0M1NESvZmlnZ9Pc7+XcXFXcmKBEE7WEAqbk1D/cG?=
 =?us-ascii?Q?SU5BsmdrzRK6GpxhyqTuWuW3WNFYFAa1lOpmkpXLftw+bce1ZcBei0cFgEt7?=
 =?us-ascii?Q?E5zVc1wjKAzxsqykHBTuFiF/TbCTyPBWgXSYlS+7tHBPQdR6lLrZf3BJ5kZM?=
 =?us-ascii?Q?lD9XQymvTfhDjlUEDBekyPeRwSwo3DrsDP3/KACp2qr4lu93cW/s+dU6+wJN?=
 =?us-ascii?Q?oVGS6torADaAeKeVHckjBJq/QqPm7z++wNRcTZoz4/WvGVp1QLUwmd4IorVH?=
 =?us-ascii?Q?fgimS7ieyXIfGwA5VLxlXVxILPVbrSAHkt2jynrwcnHnFN17RzhuSZaDIVJg?=
 =?us-ascii?Q?nxPgCMdWDf9a34Xhm7WCA1zFRyGw8IYR6SO+YQ6T2ZdySUiYJGBXICBzBQmW?=
 =?us-ascii?Q?3t50Oal1cfc2pZ1kbXA65UR91fa6YsVg/f7gNY81/TuhxuH/FnxurR2y4TmF?=
 =?us-ascii?Q?vt1dGftLGZki7DFtzDDy52DHi/AKradKMJrULNLL8b8xO1rwhYJfg/oQ/zxr?=
 =?us-ascii?Q?BHmEHf7bkorc17Q9pENW4dXqk3V0W8nurkOzFeQWWGNCGPDXL62IOdP13zz0?=
 =?us-ascii?Q?sjlnPm3FIuZK3Us8xxALA7ou190cT1Syia7s8nltumNZ874Q62QAjlYa/lJ0?=
 =?us-ascii?Q?5N0as+ZM1SENI824gWl/B4QkPZ9d7raWEu5AAo3DTdQlVkGlE93hxZqzUzmy?=
 =?us-ascii?Q?TJNcDrSyhNpjLgU+O/DAP7KrFPCwCYPTrPTAGb8z9IqWiH/8TWHDDDzQvK1K?=
 =?us-ascii?Q?O3nNu5qtbAedaC7Eej7MUL/9lzu4bnlY6tbbhkp7QhpBytL2rS1QdkIOSfLp?=
 =?us-ascii?Q?sonitlklN6CkkrSfKeo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae58a1f5-8160-4560-e120-08dbfc74335b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 07:13:41.2840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPYweIPHO/2OY5CwOG2QxfvOj4ta6l9Fy0JZZjWqNoTY57VvYQj9/yH071LvrKnh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9153
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] tst_memutils.c: Add tst_print_meminfo function
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
 include/tst_memutils.h    |  6 ++++++
 include/tst_safe_macros.h |  2 ++
 lib/safe_macros.c         | 16 ++++++++++++++++
 lib/tst_memutils.c        |  5 +++++
 4 files changed, 29 insertions(+)

diff --git a/include/tst_memutils.h b/include/tst_memutils.h
index 19b593430..439b2485a 100644
--- a/include/tst_memutils.h
+++ b/include/tst_memutils.h
@@ -58,4 +58,10 @@ void tst_enable_oom_protection(pid_t pid);
  */
 void tst_disable_oom_protection(pid_t pid);
 
+void tst_print_meminfo(void);
+
+void tst_print_meminfo_(const char *file, const int lineno);
+
+#define tst_print_meminfo() tst_print_meminfo_(__FILE__, __LINE__)
+
 #endif /* TST_MEMUTILS_H__ */
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index c899c4f2c..520a173dd 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -671,4 +671,6 @@ int safe_sysinfo(const char *file, const int lineno, struct sysinfo *info);
 #define SAFE_SYSINFO(info) \
 	safe_sysinfo(__FILE__, __LINE__, (info))
 
+int safe_print_file(const char *file, const int lineno, char *path);
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 951e1b064..bb67467b7 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -1352,3 +1352,19 @@ int safe_sysinfo(const char *file, const int lineno, struct sysinfo *info)
 
 	return ret;
 }
+
+int safe_print_file(const char *file, const int lineno, char *path)
+{
+	int ret;
+	FILE *pfile;
+	char line[PATH_MAX];
+
+	pfile = safe_fopen(file, lineno, NULL, path, "r");
+
+	while (fgets(line, sizeof(line), pfile))
+		tst_resm_(file, lineno, TINFO, "%s", line);
+
+	ret = safe_fclose(file, lineno, NULL, pfile);
+
+	return ret;
+}
diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index c5382ff10..6c1e7c29e 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -182,3 +182,8 @@ void tst_disable_oom_protection(pid_t pid)
 {
 	set_oom_score_adj(pid, 0);
 }
+
+void tst_print_meminfo_(const char *file, const int lineno)
+{
+	safe_print_file(file, lineno, "/proc/meminfo");
+}
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
