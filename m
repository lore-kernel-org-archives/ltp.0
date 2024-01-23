Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097CFC46CD2
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 02:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1705976435; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=VFbyyvMFOEZZ94qOf4NWsl3LeVZ0grPDi2w91gyy/e8=;
 b=qPH6n0Yt7MK00pUKfu7n7pp0iJwIcZAgwMpiaXzjdlnEr2F0AcQ5SuyFTmWpSW9lDCc2x
 uEHjDLr+Xt4m22WeUtXlM2N8tcYVoJIzHcjc/z4UJFWqo1MA1DDjG1dlPXMFxXM9btSWdEL
 XybOasWRaQgny3CfChiJhDKr5P7d8/A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 236163CD12B
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 03:20:35 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C201D3CE2A6
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 03:19:50 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 915D9140099D
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 03:19:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z60hVn7+PUVe+0qfYiQDCwR8FdpWZnTrXK5rPTPTHOybf2Yp1HYvphDpZmDOj18trZsWtopc0IMip7ngVab8hnusGCvz1L6J/QseTQQyxu4vdA9MoGs0wl0XBulyCdeC8u7prCfUdEeSk5dH9lz6SVOCTfV05VVuaFMeNTu3LPy7bZV20k2wq2MD7VWkgYasNyuS016FzvZ9RGxvv0ytt7u79JYbRtYhQ6j8KW58mlwfylSNKSOkKBZKB8UZxKKDDEBC/QXuSymOx5p3W8PcdM++FwxWIbNfhRAtmao4aLhOPCZ+5bJdGZQinWUiZrmbO4nfOhCv7pO+X0ZqaUxi7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKxDfOYYzqv2Pezylop/wwza3Sxywoh3J6Hcw7g1g88=;
 b=TDE5/pJjQpw/5JyAtr9wriZ4bYn7oozC5xNh0hEwipfBU0SSTl7lIH8MaWXEezzxHTiIIpnLdqW4kA2SaNHxUL7hEaV/4ZpTENszh9begEqYIwWAD2vnGXNom4dqwFDFQSePx8gC57NYBWEw79ur6/jKFL46ePh3/mpjwPQAZV67UXrOhpQ4od7E7/qOugv3qqPyyxeZd8dYpp1CrKzRWbUkS6IAwqIHi5dhIoXgq4egoa9xseHWOgY4R73E+ZY1xkBbBhIsvO8M85Ju+d+kT7Dvv+cm6t9Z/Ox2YhqvFYMg6ak3cP8feMOKU4p/kHVJWEp8xI/6DAA0JghUPPXhpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKxDfOYYzqv2Pezylop/wwza3Sxywoh3J6Hcw7g1g88=;
 b=Bjp1OvL98AbAGJZpXevhIBrYwQsWFtSgeazbbK/skzJ9YMR/OXlCvbRNAxX2OmWDGIzsGHGGN0q5KGxF3kokyrq0TGfJogUwMjU2Gb+gk79T0ulwdUgox5MlQZFr2hMfl3nVeeTCPgsThgCZjf+fPi5G+f1/vlhos2XOeB2IcraH/4oWozABk5jmwbIGsrWCkM0SYYsUN1zXW7dDV9X+BDAgOewTEFqvWHOfh3ztHGxYLnYoxKaq6GgMYmMJ3K3jHq0RcxPsUsoXveOjCsikLOP3vdKJ5vSvDtbOTI+YxVcsV6jAfTaeEt88thjLX8nnzE/LB5PDI4uSUUDI/e9e2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DB9PR04MB8108.eurprd04.prod.outlook.com (2603:10a6:10:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 02:19:48 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74%4]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 02:19:47 +0000
To: ltp@lists.linux.it
Date: Mon, 22 Jan 2024 21:19:27 -0500
Message-Id: <20240123021928.9721-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240123021928.9721-1-wegao@suse.com>
References: <20240109065904.18117-1-wegao@suse.com>
 <20240123021928.9721-1-wegao@suse.com>
X-ClientProxiedBy: TYWPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::17) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DB9PR04MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 8701cc44-ea66-4468-2ed4-08dc1bb9c554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHcSlpz/nAmI/xi/5HY7rQ5eXjn2xZvpyuHZEQf/Sgnf7SQHNEcWErEWDmH0dCNzFy+RO3jhXBSCBPsG+rJ5iTJ+5L/jwXyBNCxoYqRejoWucgqLZU71+HwYpdun2MvEBS+/9Ev9VKkSexpqzkXFrzEBST/0RKrie1dATKxzoQYOtXTdoYGM6C3kdKNgf+oAST7WCgfrrN/1BM7gbiG6GalUEvWLfNEL040tNRF2hux22MizAaokCF85jyHfDSqSUgJ/cAetJPlxCNP2dpRD4ID15hVOugg/EwA3yE6ujf8jenXFOfGLQvGzbO53DFyVjCtZ96ziSj5ir/Xh+2NlAl0CWSa2dAt1slNdKfcqOE6uRgDSM0x2H4tXxflZNyXYgl8RtwEnMAjodNoczXqqyZGz7ux6+yUgULrcIZXkraTcERlfc3QCGfR1K+sgniWKQpFsSSe1Hhs1wmr4qKwya6Esnjkt6LegY4BKz3js9Yf+vSRM7tmfEbJ/E0V4oofXTzshZcjFH0bgnn6Z7TlQ0DO7vZ5ldd4wqEU6Syh65iynwlixL7ZBSp4BYQ5fYn/sL1jAafKsolvY7gCWmA/EOdcdwxJb7M2N5NoZGrTr4EqTTNO4z7W/138CEgDWngkIfl+iXh3LQWyVz20cCixOtJwu7zXLG9uQCGNu3NbOXCA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(39850400004)(346002)(376002)(230922051799003)(230173577357003)(230273577357003)(1800799012)(451199024)(186009)(64100799003)(4326008)(83380400001)(8936002)(8676002)(38100700002)(86362001)(41300700001)(36756003)(2906002)(5660300002)(6512007)(1076003)(2616005)(107886003)(6916009)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(6506007)(26005)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?btD0BBCCgAM4EbiBn42DKWYP+ynot9Z1ZhywH0pBqf+a1D4m1pTfh5hCFP7w?=
 =?us-ascii?Q?VGAAGh8azwznn6EI7Ol5sEP5NMDLu0BOO477xmdncEWo4pvfQaCzQEhT1Jvp?=
 =?us-ascii?Q?Epw4LJU37uSpdpNHOJYYlP4SrnfEd9WXOuEppvh3mJQEUQtLwUXVKaiGmJ+v?=
 =?us-ascii?Q?JYwdlDWUOs+aPOPrFN/gn/vOl4xXDGjERsnDc1TAUsQAvg+Yx0GQOUhzc3z8?=
 =?us-ascii?Q?2KBnsvSrNPHbwZ7SiMTWqnRlygaFbjpUY0w2VTuP11hXJTky+wu0b6ymZuJ/?=
 =?us-ascii?Q?NDOE8zP9kIZNAlGg0bdzZ8ODhR62Xs3Ar7tWy6dse4x/4yKA94bQoyjcSfCB?=
 =?us-ascii?Q?xm7agHzxAsNDOPhSO7IZetCPcx8yI2OO1hEZqO6J9wyyK4XZdNjSgknoThiJ?=
 =?us-ascii?Q?d0r514qQlFninJbgNiyb/o/b/jcOJ/hHwywfbpijTvBH4zTjgejlUvYM9+bq?=
 =?us-ascii?Q?drqoYaNYlw1kZ5je9eA3gTMCC7maSxMZ+JJ44MOQbONvgX5HfiYo6k0vHorz?=
 =?us-ascii?Q?jq5Xb8e801NCUFnK2SOSBMzXA7MqNJgv7Avf0JMINrR5qvQRlVM8/GqdGuxx?=
 =?us-ascii?Q?M9INxAH1rBmrpcd6ZGfdi4uv1ivHItLTklgmy3hKR1iQV6+Hof4kQ/PLBjO/?=
 =?us-ascii?Q?c9AAe42e7JZo0z1aSgsZ0R7oGDzKoq/Q3MX8nNRzTXHqEq5B76Zl+l2lMUBW?=
 =?us-ascii?Q?x5R2W/3NBS2OZ1l2G+KCIbQCb3fVLYYsJ3T4EJbR05Fw+l9FNcZGsYJPPDm9?=
 =?us-ascii?Q?nDfHfJEW/fniSdvTzmy9ib9odd//ZA3tlZMberVTkq7ue//ZKpxqe0RHnosF?=
 =?us-ascii?Q?9012Tb0rSUya44j3W+7zcvgev+TArFzxQtFWYtWIJ564FwYhg3MyL3ESrZDT?=
 =?us-ascii?Q?Csp1nUnTTOoXdgG+Qgqi4mbleaiA1Zpnne7Z0K3+3aBwXg9H49zqZNiyQHaA?=
 =?us-ascii?Q?R+HqZd0u4dLGDYn9upcSnlonFP1iy/AqN/jk6bHMHsrd//+VdXygsLuts+rq?=
 =?us-ascii?Q?a36u8Xd2+jg1IttbGhqk0DNUISUHhxaj88J9EWc0u1xNDlGqW9/JUguPAKPL?=
 =?us-ascii?Q?+6UW5K44J4JvCFEfoKdhQliYGHf+GOAO9B+tdeYIu5zh/LJh83etlgApQcmI?=
 =?us-ascii?Q?dKGrTxtfquhcykhMtAaqfjuEuuzV4uwSAtpb5D12E2zSDdrSkomV9EkWsGJE?=
 =?us-ascii?Q?DlCC6j5kCL7vWiEelsu79AdetULdyRQfzcT9Fpk57Z4IuZFg2UwEnglkZVKr?=
 =?us-ascii?Q?8Y/XzICmZqetcbXSQXR7roJRWokv21z+UClLVWZ4W1Wrvph2NRYOqHfUToHz?=
 =?us-ascii?Q?irpyNH4iCVdl+AthEzCbA3kYzKQ2YLOTEaDLRETP3gm9ediMnBGJ3hXan64x?=
 =?us-ascii?Q?0sHlweJXRUQN+tP4bQnTfs+KfK+sDvejwjtTYf0EdM1FEBcgGaLbbYRgK3gc?=
 =?us-ascii?Q?I5xI6O3XWcty29b90mqvPxhGKc4PQ59qthY4nxj/uIWAs1LjNKMurLQYqtSX?=
 =?us-ascii?Q?8+C5yoWvzDYBrCtgdMchiUOSqX7hirpWDH18ollf9Jw5ZVih33XuaImvWmks?=
 =?us-ascii?Q?jxf5bEytODOMX9fFgDQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8701cc44-ea66-4468-2ed4-08dc1bb9c554
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 02:19:47.4071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDnKS6uVfNrLS8RiuwMOvLn7zKTjxZEUSxXRY/5ADyxSpxewxzdxWdzUXF69obIe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8108
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] lib: Add .ulimit
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

Fixs: #530
Signed-off-by: Wei Gao <wegao@suse.com>
---
 doc/C-Test-API.asciidoc | 18 ++++++++++++++++++
 include/tst_test.h      | 11 +++++++++++
 lib/tst_test.c          | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

v4->v3:
To fix following warning when make check-tst_test, i rename tst_set_ulimit_ -> set_ulimit_ and add static key word.
tst_test.c:1156:13: warning: LTP-003: Symbol 'tst_set_ulimit_' has the LTP public library prefix, but is static (private).

diff --git a/doc/C-Test-API.asciidoc b/doc/C-Test-API.asciidoc
index db16be36e..e3891d5e8 100644
--- a/doc/C-Test-API.asciidoc
+++ b/doc/C-Test-API.asciidoc
@@ -2426,6 +2426,24 @@ Test can be skipped on various conditions: on enabled SecureBoot
 ('.skip_in_secureboot = 1'), lockdown ('.skip_in_lockdown = 1') or in 32-bit
 compat mode ('.skip_in_compat = 1').
 
+1.43 Set resource limits
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+'.ulimit' allows to set resource limits on particular resource. NOTE: It sets 'rlim_max'
+only if it's higher than 'rlim_cur'.
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
+static struct tst_test test = {
+	...
+	.ulimit = (const struct tst_ulimit_val[]) {
+		{RLIMIT_STACK, RLIM_INFINITY},
+		{}
+	},
+};
+
 2. Common problems
 ------------------
 
diff --git a/include/tst_test.h b/include/tst_test.h
index fda696eeb..47b5902f9 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -15,6 +15,7 @@
 #include <limits.h>
 #include <string.h>
 #include <errno.h>
+#include <sys/resource.h>
 
 #include "tst_common.h"
 #include "tst_res_flags.h"
@@ -150,6 +151,11 @@ extern unsigned int tst_variant;
 
 #define TST_UNLIMITED_RUNTIME (-1)
 
+struct tst_ulimit_val {
+	int resource;
+	rlim_t rlim_cur;
+};
+
 struct tst_test {
 	/* number of tests available in test() function */
 	unsigned int tcnt;
@@ -308,6 +314,11 @@ struct tst_test {
 	 */
 	const struct tst_path_val *save_restore;
 
+	/*
+	 * {} terminated array of ulimit resource type and value.
+	 */
+	const struct tst_ulimit_val *ulimit;
+
 	/*
 	 * NULL terminated array of kernel config options required for the
 	 * test.
diff --git a/lib/tst_test.c b/lib/tst_test.c
index bcf2c4555..f9a6f1ae0 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1147,6 +1147,29 @@ static void do_cgroup_requires(void)
 	tst_cg_init();
 }
 
+#define tst_set_ulimit(conf) \
+	set_ulimit_(__FILE__, __LINE__, (conf))
+
+/*
+ * Set resource limits.
+ */
+static void set_ulimit_(const char *file, const int lineno, const struct tst_ulimit_val *conf)
+{
+	struct rlimit rlim;
+
+	safe_getrlimit(file, lineno, conf->resource, &rlim);
+
+	rlim.rlim_cur = conf->rlim_cur;
+
+	if (conf->rlim_cur > rlim.rlim_max)
+		rlim.rlim_max = conf->rlim_cur;
+
+	tst_res_(file, lineno, TINFO, "Set ulimit resource: %d rlim_cur: %lu rlim_max: %lu",
+		conf->resource, rlim.rlim_cur, rlim.rlim_max);
+
+	safe_setrlimit(file, lineno, conf->resource, &rlim);
+}
+
 static void do_setup(int argc, char *argv[])
 {
 	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
@@ -1252,6 +1275,15 @@ static void do_setup(int argc, char *argv[])
 		}
 	}
 
+	if (tst_test->ulimit) {
+		const struct tst_ulimit_val *pvl = tst_test->ulimit;
+
+		while (pvl->resource) {
+			tst_set_ulimit(pvl);
+			pvl++;
+		}
+	}
+
 	if (tst_test->mntpoint)
 		SAFE_MKDIR(tst_test->mntpoint, 0777);
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
