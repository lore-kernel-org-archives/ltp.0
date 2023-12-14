Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDFFC4332F
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 06:34:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55B4D3CB55F
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 07:33:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 716463CF4B1
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 07:33:44 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2E488141062E
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 07:33:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1LeWl6U+VeBC9nJLyZq5NoSeC70Sbai3RgrD2a1aQ0OK4RDZZC2QqnX9jJWE5YqoQ0UJhebe7aHtkiCuo3xZgMqx57CzMbK+QQvKQYGiqVflujIIeqOx9IHeoTDfd5hZrtJE1MdT2QdI2eHrb/eXWkASQyPwT4euiHNgrl9NeqxSCR14IexrHurJQmwPQpxYrcZMjCuoCY0OvLgFUZmRX76prZYu412DLrVtbgDplhF4hA07VQk5fC6DSxNwUEXMzP0spSlYq6d77VGHs6EdFB1MBHpZQuetrUk0RTPDQCJdtPOFhHQxWMmVcQnAbOygIw/PvhlB53p+5MqOaI03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snKjEWB3rAXba6/Q2YTE/ghSxyKOxj8Ey7N+0soEZQU=;
 b=Fm5OZbYWU2MP5NUb1SJuGLG4vNQxlyj2A/loRy7hH/SD/kek7xuDFsQshJFJrCM9SKc4BqHqb4U8FQjcqmNzz2rWJOOOf17PhuLPgB0hZ/ngPh6AFhCgp9xUa2nHVUgjTB3KJ4pPgIFGyb3Jo6EzN/NLRsDTJkrgR1ChZ1+ihUV6STplgKb3yXGySvCIWuqgLMLdS/am3P8/luvWh8F/gA/MccMPv40eTU4iEWPN3XU6vOuB5xywuWZi0AZsy1OwXIZ5+fkyU79GYdXc0j7aBWU/rxYKJOvACSBoFVOIMNUFp8BarUcPWj/vr+N2UewcLrN8ATdsDtmStHZF0/SFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snKjEWB3rAXba6/Q2YTE/ghSxyKOxj8Ey7N+0soEZQU=;
 b=VR84lxNG8bYzkdrcY5bAPYAWdwF6TolVCRcc5C9raboq9GXcbN2EtfJcWijk2l12NxlsIWXVJW8HMgKVldmYsdnn9lHssYTHw3C2Zr3jlXmz9AqYBFfWFgRWT3DRw9U+8OW7DeZpkxFRyI8NDB14iWAXHcoLG+5dWzh05/+KA87EzFUVxQkMeK0SoQo8OEbuFS2GAu1MjNcP1i/0Bmi47kWM7cnZgKaJifEmiFZu3xsZvHuz+9pvU5VsveCBleiS+GJVX8ZpUfDVdIB6Nd4sn5I0PjQMKtWc63AA0IuIjRXyxzazJhVKpi95KVeRkh1i0dNJEoDQGVWPaOmvF7gDPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 06:33:41 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 06:33:41 +0000
To: ltp@lists.linux.it
Date: Thu, 14 Dec 2023 01:33:10 -0500
Message-Id: <20231214063311.2325-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231214063311.2325-1-wegao@suse.com>
References: <20231210094339.26971-1-wegao@suse.com>
 <20231214063311.2325-1-wegao@suse.com>
X-ClientProxiedBy: TY2PR0101CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::24) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DB9PR04MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 321bdf9c-6636-4983-854a-08dbfc6e9cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qWzoQbbMjLs9xdM52VJegwoTCf1IlEPFw9mS6IQd+dtivwtlMTyTHCkwS7Gnv65Bc2lY8wm1fwKnxL+XQdJXIcGJlKcPvWUtzRrMR0jq2xNHd3xXyoV5f/3lyhuquXB5Y8d3wF5d5GFJKDHNy+PL0v/ib+0DAvGJ5zKHa8dtGkrno1g8gB6jdEGTjcQDJfFQThPEqHnlphjX0MjYfm4Use4OtTaXhRWgIFPJT4gFY6L8RCAxxOiEaMnEeSFD9xoZql1kp8rSuyq0/8pWTbKzm+GF0/HtCBrFEwg95sZFvCVoQDgJPQ34G0Srf+lNX0DJmF4iYPejbv8CUXVH1dRW88uORh7mVolI7gel7prezTG1g6xauSaMh0y3cNxFQX/RCjVFPiRume+BAEfTQM3QopeLYOofsz2rRQxo4LcND1Us/Gj7gnZuWUTI5pfHlt0Li4e+xggygKbkVr4lw+tEOzJk230pn6vd+ElwdyWv5po+0fCmiJhsv+kOXXhYHedXvxirCFioczGXPWr9wSWco/++tV4MVWk16uGl/iF2tg5B+g9Nx8Q1obT2fg+j5vhk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39850400004)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8676002)(4326008)(8936002)(2906002)(5660300002)(6486002)(6506007)(478600001)(6512007)(6666004)(66476007)(66946007)(66556008)(316002)(6916009)(41300700001)(38100700002)(86362001)(36756003)(83380400001)(2616005)(1076003)(26005)(107886003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o5rpzGiOgbu0DGo0UhleqOVWXhVrvS8kTlWQBd/+fvtvBAiFv4pr0pDNHdML?=
 =?us-ascii?Q?HKFracJVmhi3Wb4LIRbQnrKakLPNSctbiJRt5epQdV/MXFoWjN63nlCnGv9X?=
 =?us-ascii?Q?7YD7+2jdSiwvVbDyHOhxfCnOZyd0Cic+ClXHOwe/OV0+A5z/Ix5+54G6yCmI?=
 =?us-ascii?Q?hgj6zuq6zjtOBETkiDiCteXVtWp/ngBq0TfBsUGsv9U3utB7qGXKDPo/6I3V?=
 =?us-ascii?Q?gYDcOZDGqCoGy8qIIpUfsHVJ7GWyBmcP/c2tgqgebVEkBUy4UKBBte8eQrtn?=
 =?us-ascii?Q?wTRoLYl7KpJCCr26DeIUCSOb8kJdKx8afdNuRJA8NFfVzQzQUIuk8s+GZNxP?=
 =?us-ascii?Q?MDuZckyy/Rq/d/GmO4T0IwAM0Im8K/O9SV1QX/gaP8KfWzsfQVC1Ky2aN2ww?=
 =?us-ascii?Q?Eqbo3fkmLC1tSTRkbhxWbtWUl1Hz5LiAfXt4ur3QCLWuYbzkkjTiudSO0uiD?=
 =?us-ascii?Q?zeKV3LfvBK31rL3IvBP/keIcm2EFB1CK3TrYodO+dL6cmzxCTQRpdYXYFmYn?=
 =?us-ascii?Q?5b5s1+NN6AY3HWDFwimaTVqe1bY14pm4dDGqqMcKXPx6Y4srlL4e1GUoS6CH?=
 =?us-ascii?Q?EVdbnFeHNBx3k9U2vGhiZgO2NUEAkDFzKpG6XGbcb1pxUsjlm9jwX1mSNUIE?=
 =?us-ascii?Q?wR7NLHLEipHTIP4RpEz4sAIvk5QZ0qaNNMm4ccn/eQhKHqeDqk5p1YnWDICY?=
 =?us-ascii?Q?qyGzBe5BkSX4z3r0wmPdSUmlTyLBLJHjZxp0TDk35Hy609oPX/04WzxMnAux?=
 =?us-ascii?Q?h3gE94aMGcUxN6mG87RZTeJ3uFStj4i2ZDEvtCgZrB+LDEHStj8n0o+qjna+?=
 =?us-ascii?Q?ePLj5oQN2s591zMRKjYnkboaSW0kY+x8E/JRDODvgN+Xt5KvI2D1R26gj0vA?=
 =?us-ascii?Q?m5JY902buQvqNdLjTeol9XP24YGgvnQ6v+5clNr4wFoJSmsbEv5YwEU1+9pU?=
 =?us-ascii?Q?KwJMK2G9MWp6Hyj5iPJqgQX7P+uqwY8zinPG7idB0cNiqEzGF2yDpBlknC6Z?=
 =?us-ascii?Q?asWmeqLcXYB6pS6HDN+nnypofo4ikIksvCirE81jxWIc6M+yBBP3/IPgzrS+?=
 =?us-ascii?Q?WtG1293vSGntapWjeLhdcCl+y3zFZ7eWDsvCgefbDy8cu15tBB/aZ3fVIiSL?=
 =?us-ascii?Q?d9h9hxKcoq/FMQsJ/v7TiRAusu2Sy9vvAiQpTNI85HMs52Y2AFW7lVDlhxlS?=
 =?us-ascii?Q?pNyEzF5gRUgrBr6hT0TdGQN8A9aYOJrhcOeOjPujzLl5PrRWksQQqoPNUr3D?=
 =?us-ascii?Q?AtOohdnelWCvF01KtZ9j8ah80DXnsjK5t5uuNLSDqd809H8DexL9Xm74XBa8?=
 =?us-ascii?Q?moExuf0F3TaynRuZmlIfhwjRUrpfewU8LmVE/8VwLTp7R2ZgjnZeKio9LGID?=
 =?us-ascii?Q?rip9aHTQspUsjjl2jIAgv3f+YWffJSH4YCaPvjCRKIoVWtwdlxWKNLPZNs0z?=
 =?us-ascii?Q?eTEvQqlAhv2MrkLHUG/GRAsRb4L023V9TmmQwIr7eq8N9utcV/M+VR7FkFGa?=
 =?us-ascii?Q?Ya6cgR7a7cmWJb94Tv/0/RW1SZ3XwGlPOpF01XQc0eeOzIftecelcnK5BuIu?=
 =?us-ascii?Q?WhOLgSPvBu3x67g6zvM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321bdf9c-6636-4983-854a-08dbfc6e9cea
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 06:33:41.5388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMPYsXUhCZ8BZ/Jc+T1Einzmqdn1WJ3mB1thB9U/3Js/pZUN4iauofq2oUJ7e/FR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8461
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] tst_memutils.c: Add tst_print_meminfo function
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
