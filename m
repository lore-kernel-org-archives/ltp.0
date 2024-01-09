Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B6AC46CD2
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 07:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1704783613; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=eP7eVGeoXqnxvglKkoquxiPLAOxxICJxC0fkaP7yoIQ=;
 b=pX/Zdk/2ljIo7FLQzuzFe97U+Fc0pbcuBYZnzDao2Cxa3nRIxM4K9eT+z/27hD/13fse+
 7JxAjyveeq0MRxVUA2G/TakAPlTsqtmxEQQYkZLh+R2qGibbwTo2RJJKGJ77BS/b10LV5DS
 A8+WAY4sN0KZ9dq+EUCABhULz3u7iXM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED0AB3CD18C
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 08:00:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82BD83CD1BC
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 07:59:24 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4B34B140012D
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 07:59:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3FoGkez1U2nHlUO29xxxf/fHfyqAtHyAorORvO6hXHu2a1gXhdZjkc1ywq09dmEylJvN1/I2iQ3f1e3xONXBhLZUEMKFt9OxC/PfPBKZQCE7ExqKdmX+90yCzQg3A5qWKwZAYKPsnOvwshnZgLjYTgwr4iwdeGOKqrt4fQrD0DBPzsZ7mbuX8N0ELjQrotreMVcdFyA8vL6HEB/tUYp9kt3EgCqdv7pIs4lJWczdCBLJMHsjL2+k3+5ZBLF7FP808xPTsFkEUL2SeTt0qTuZY4/8iDk+hCPRJFsY61jSD3T5kDQLlSBUFtjggfvM7J6N4tF4ZhZzcpZcDUarxQysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEtrEI+7gKA3CxDWDBrR5nkkwlrnrYR9UzpXC67ZzQc=;
 b=STLM+5kkIrGv+xVSjAeaNgLhGw7ZRzR/NRzJxcm8xYpkV8pXt2X6MNewdgqsKgA0OaDxi7zHobvUbrZR+S/9jBbC6iNWZOy5O92Be0bv8rHLeAFrvYd3yFy+tWauzOGnqz9Ha0F2q5LZs6PzcjtqqeqPALKY9665fjbAH9LBrEl6yQBR8i29lhqoUUbsbtyacFjRC9UX9InwlwAFWy2nC5osCpKfn7+IZaW8uQyvIKiigiblMGhnMRpkvVe48ADRanlurswbZ+xmnFIznnZTe8KXwNct61af5McZMkSm6NUSeAPspLhpiayCRDkEHabMI7yWzNwaw3S2gVkDtFXBSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEtrEI+7gKA3CxDWDBrR5nkkwlrnrYR9UzpXC67ZzQc=;
 b=Pf9Oxr1wgaW3G6QfzqQCSk1lrTKKLhSedEhAxS/cY/USLLp1+ADGCtkBQlgHgc8WNIVgg3W2ZtJ7HKnff+HywIiqsorjVkIsyuVeuMpEa2gflCMaQBG4XGiwJ9YnvCCnM/9vRCPa1oJ1NHdO/S8aPK+VIWhma19nhtKCz8AWKsOBsiCm3azrc0LakNIelNEa7f24swD0lueQfInzDz60mxX4OK+WFI2k5BVXR8tLUX3FdBGX+VyXTntvNkUiwgNhzRU/CHoEUioC9IGaBhVa0tCjbj/dZ3KnSitjAdH9fnt7SfGsEPyPfBQrEnBmngyuH8eGr15Aqm66/s3kZMN8HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 06:59:21 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 06:59:20 +0000
To: ltp@lists.linux.it
Date: Tue,  9 Jan 2024 01:59:03 -0500
Message-Id: <20240109065904.18117-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240109065904.18117-1-wegao@suse.com>
References: <20231025083706.13767-1-wegao@suse.com>
 <20240109065904.18117-1-wegao@suse.com>
X-ClientProxiedBy: TYCP301CA0046.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::10) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|PAXPR04MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1f593c-0b14-4482-3767-08dc10e0813f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UizaCZgS2EHPZ29sbzrLGGjli9ROG0Gxdzj/oJ2Rg8O3TnUlgLc78SMwLcnOyxQp5ed5g55gi7mntFeVwoPyNMbvVVTZHIrDs6tfeRtW2S2cgyqWTopnhYsAWr4OC5VQmk5f4nveiJrBEjXZCFvccH6hvmzUJ/93aj21haCCgBP/49v8jRg97uUcVE+m24/qKma7RYEOJWSJST1wWzwuo1OeUw0Nq2ILqXOqwwXhRiVWB9Nhx3HeIxM7w+0Wj+F1oTAMt/e6DIEdtiTp2wC/AnzuTB+ThHhq+L6BxMt2873ON6D2Fh2vxELXddeihKDXn5Fvk8ShYn2/iPsbWwqIt/N4D61QvlYIIUjSyhCmHGLVFrfTCobFr/kYoZnlVYGw9odSEwtzufYChlbTfOKY/17L/Ab8LzJVPcwdvR9awY5qC2FuOhGcNCoZZNAxNTV0bJQ3X26Lbe7I5G7SepQKb3kg1KDz4rFqsY0NvHxE0x9xrjPwshrum78MTX5b7k/a5akeL5ijYD4Kb3wTGL9/nPTE08JOqnhQ6G/AyRQKtp09spvyHjp0vRV+kZ8wLmZTGUBx90r6vyDJopH0hOVfaIreOSO/oWtZBOE6zlER/ekiE8JFubKPYaG6QEySlkfZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(366004)(396003)(376002)(136003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(478600001)(6666004)(6486002)(107886003)(2616005)(86362001)(6506007)(6512007)(8676002)(8936002)(41300700001)(316002)(36756003)(66946007)(66556008)(66476007)(6916009)(38100700002)(83380400001)(1076003)(26005)(4326008)(2906002)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VMdZLjIkYhdy3nQupBgZFlTk9M1BQertQfLrZtpmNbEoKbsVZRjoAi68CgTH?=
 =?us-ascii?Q?FX0oSuBJHrrkR1yrBlnlI+9vxnhjUP0N/6oVXVq1JvW/flKyU52qUOYaUIp4?=
 =?us-ascii?Q?qm833nmQ21mR93m5TXC00qHbonnOqgUwGQIyZunN0ZikUhfnzo0oG/JJJJsk?=
 =?us-ascii?Q?YeBBXwqHpS8NIKxgLlAoZHThY5+ROMP0tGPiapM0i7YBJeoMvDWy7Zu1eo6E?=
 =?us-ascii?Q?9iw+81bS3yTSDMSrbTL7fw1pREw3yeuxNobfIrMM2ehAQxsJ4sHqxBr0wKgb?=
 =?us-ascii?Q?CakqNy5mPuSlTZamkvIm9mZi/sin2b61wVnCag7kcwqQen+zLkdhIGnODeal?=
 =?us-ascii?Q?JlheweKIuRF0mI2UIr5qI1BxKCerAZI1bCQ00aOXt6QIPqsqaHGPZYmHmotg?=
 =?us-ascii?Q?mLFx6xyVcdlMnjpCktgm/NZlClhAfZWsBWIvjb8VkTUHk/9bLS1H+dkHvvB/?=
 =?us-ascii?Q?v3AoIWT16C4UMoojI1GfLDHS+GPuQYhnAi7JkLOTWavC34B+eVXUO6xZUmUF?=
 =?us-ascii?Q?ByI1T1xKsa88V8atxUZr8O+SjyBSu16sAClcRRL95gZmdonL8YKqZOTYTwEi?=
 =?us-ascii?Q?hnYQ1qEyF6v3ekk3gZha94OgujuRgiGz99mU5M3FGF4/yfFn1ijhkNsAIeh6?=
 =?us-ascii?Q?UqyoYaQgf6Hizfk//PbdChzS+x/eJV3FHpCASag3XPpgmNQM+yckn1icRnhR?=
 =?us-ascii?Q?2JoQHXH6xBEaFNT+ho3LmuXmYIaAtFY5EobRy86xfVJYwF43oXRgiMtDLq1e?=
 =?us-ascii?Q?ts7HdQM2hK+seuvXs84/QG8Hf4OKc20UIse23s4F86FhS6YPxP3c+ia9psih?=
 =?us-ascii?Q?TxrkHA7/SIVI/WUgxta+hv3Yuc4mc0u9VISUp+Ret55FtQnTv+jl2ZV37iRW?=
 =?us-ascii?Q?v4ztWLFR7ACJ0nhFqE3ztPCq6b2hYK67OIkKAY+qr9ddE/YuLJ4mr0xI9bU0?=
 =?us-ascii?Q?Ft7I10fic4dM7Q+2xKpbVbh3QpgKimdKiUqVIc8dlr5HGeputOZk2xCY4zdO?=
 =?us-ascii?Q?qY/rYJ9IgV+yXD+fMaibnmCy8RcMexz1JeKAnYr7baZZWO56m/XBMqpwrtPB?=
 =?us-ascii?Q?006Lp+acPakr53y7O1k+mYPd68TAzDccSZUb/+0mGIBjxEWYLmUIpMnu1/ce?=
 =?us-ascii?Q?jU6/vuMEuEFiD047dTWLUDz8eVF6VoKJMQrQisKSwQQFG4WE3rZXpWW/vh+X?=
 =?us-ascii?Q?FnLm/pCgg/3wcEItHJ5JhFqu91Ny92UIcs7VzT81FAbWQJus5/LJ+BW8aY+a?=
 =?us-ascii?Q?IFSzL7eo3aO/Y1X1x0PDXwtvd1b7eHKfDN0JvDRknBCwdLxBSLps5/57w2KQ?=
 =?us-ascii?Q?T0qC+SogeN6N6dBvd81VJUqceCEjcYit8p5nfcBht0EWgPQp/GKs+Ayxvwhj?=
 =?us-ascii?Q?orYxevvZc4wcXO1elxE9vPjeMd72GWpiRDiVn7B3HEImbDNhM46yNQAH1Mti?=
 =?us-ascii?Q?M0weyjplDNH+WB2kpptrQawNVB7ievKGbAopEXTZ+V1AltqtnPNWyhPqlmFy?=
 =?us-ascii?Q?livNacGOcxlXWwLG3OoXV373fQSKc34zofW94vK+j0kuxcxVfa7YAeQnFebK?=
 =?us-ascii?Q?Mlc7ANVo4M/nh5nsd04=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1f593c-0b14-4482-3767-08dc10e0813f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 06:59:20.7745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCozOnPJnaaY9Yf4S1XN7xrWwBQl1VD+RYhdNXxDCy+tgp/YhYSjZ/W0jguUTszl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] lib: Add .ulimit
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
 include/tst_test.h      | 16 ++++++++++++++++
 lib/tst_test.c          | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/doc/C-Test-API.asciidoc b/doc/C-Test-API.asciidoc
index db16be36e..c42a9754c 100644
--- a/doc/C-Test-API.asciidoc
+++ b/doc/C-Test-API.asciidoc
@@ -2426,6 +2426,24 @@ Test can be skipped on various conditions: on enabled SecureBoot
 ('.skip_in_secureboot = 1'), lockdown ('.skip_in_lockdown = 1') or in 32-bit
 compat mode ('.skip_in_compat = 1').
 
+1.43 Set resource limits
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+'.ulimit' allows to set resource limits on particular resource. NOTE: It sets 'rlim_cur'
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
index 0c3171e5b..374a8615c 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -15,6 +15,7 @@
 #include <limits.h>
 #include <string.h>
 #include <errno.h>
+#include <sys/resource.h>
 
 #include "tst_common.h"
 #include "tst_res_flags.h"
@@ -149,6 +150,11 @@ extern unsigned int tst_variant;
 
 #define TST_UNLIMITED_RUNTIME (-1)
 
+struct tst_ulimit_val {
+	int resource;
+	rlim_t rlim_cur;
+};
+
 struct tst_test {
 	/* number of tests available in test() function */
 	unsigned int tcnt;
@@ -307,6 +313,11 @@ struct tst_test {
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
@@ -393,6 +404,11 @@ int tst_validate_children_(const char *file, const int lineno,
 #define tst_validate_children(child_count) \
 	tst_validate_children_(__FILE__, __LINE__, (child_count))
 
+/*
+ * Set system resource limits
+ */
+void tst_set_ulimit_(const char *file, const int lineno, const struct tst_ulimit_val *conf);
+
 #ifndef TST_NO_DEFAULT_MAIN
 
 static struct tst_test test;
diff --git a/lib/tst_test.c b/lib/tst_test.c
index bcf2c4555..f5037330a 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1147,6 +1147,29 @@ static void do_cgroup_requires(void)
 	tst_cg_init();
 }
 
+#define tst_set_ulimit(conf) \
+	tst_set_ulimit_(__FILE__, __LINE__, (conf))
+
+/*
+ * Set resource limits.
+ */
+void tst_set_ulimit_(const char *file, const int lineno, const struct tst_ulimit_val *conf)
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
