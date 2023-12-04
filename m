Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11F5C07E97
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 00:26:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F23253CC982
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 01:26:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 972473CC7C8
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 01:26:32 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D5787600257
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 01:26:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPpdhgpjzwcc8xCHky3osyaN0hI0jFA1ogSJAZfDjihQZllYIzpx0d+0vJuRiPz2wtgc/Lf1WrYuAIZCjS1b2bdb9WD+RwwUpvHgR8Gxu8IsNf852qZQJ/Ljy8EMaCnEu6nHVTXE9cOqEi0rda2eUlhYEZg15xtQ5ES7ZmNS11QFNkJOAMST0krVNYyQqNctqT0LuZcO4rRf8qgl4yyeLxeCPGthhc69qC+podXLam1wt22u/a1Ebh8Oty+iyLkzwSFGqRdMuF5GqIqXtOCLkBQ0QTVcWAkkmN3mTkR8hxs/ySY6Wd/qFsHxL066M2p5uX7SEScU3jBENTtmt5A0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M23dDzx//DCIo8fsmAdF6WFXvaXe3sItu8A6iMUZrGE=;
 b=f9fEZEdTOZySH1QVjRhLzUvKNsSzs8XN+lb9gV/rhbB0feTjcvCt5ywHGwAlZ2WXIsJ+Dfh1LxymrVFONmdPDBLX3QYH0wXZFzzJwlhNS72BD6cMTsep0WmXRgBDNPYQAzdi3hdG2w+4/qlZYhd+sbzlxQLRsYuLtR/OfJVro89fJRepgd6LwCFtDsDJTrXMQ49LeclghfRrfTkg/wf1RGDnowxEUjZIO7I1qU0ZZibNQh7/Fh4bDuqpObV4f8nDvsBDOHBDNB+cNp7lRIwITIRAzCE4NoF9XOQY8qnZ5VZmPRcUGN5pur2FUgIVUoeN/ZCuJQswdOrRsB6bJEQMLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M23dDzx//DCIo8fsmAdF6WFXvaXe3sItu8A6iMUZrGE=;
 b=siBgyVhLU6u3qS14KkXVv68qqjFT0P51ibVwVW13jGsCVfgYjo7Z1Z+WP/4lOe4Lb3UArDFS4DJ1hPI0hFp2CzZ8zPWAthUx+Md+iOVnTdzK7nlwLOg8h4eEN0jqmuMMnC9z9LNfBIxcMsfJTlKkm77PIUR616VXDUsKOz18j2NGpfmHYlhWHPZD5OSRSNu+0z5gLuyVp3sUXK99jyEX2vQIYbyaP1pQmwE+bexJx3BUs8+jYo4VnsDVpb28JU9AuaCK6sFhlX5Btx6gtq4+d79zaIUlGXseHvq7qwuylPP2PkPZqwKKBcpdxqFYOqDRGk1ul0MTjNg2PvCUXh8XtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DU2PR04MB8808.eurprd04.prod.outlook.com (2603:10a6:10:2e3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 00:26:29 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7068.021; Mon, 4 Dec 2023
 00:26:29 +0000
To: ltp@lists.linux.it
Date: Sun,  3 Dec 2023 19:26:23 -0500
Message-Id: <20231204002623.17302-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
X-ClientProxiedBy: VI1PR0202CA0014.eurprd02.prod.outlook.com
 (2603:10a6:803:14::27) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DU2PR04MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d226e1-edf8-496b-a635-08dbf45fa8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rRbXbQJmIbaFWXMQfONgZ/ZKpnsUGDL+l26CYM8hz6+gSBdlIDSB+TdTuwWFWpe/jX7CrTAidfcG2H3P5n/PVQIuI8tgfW1WySJmnHS/p9P/luJyjICDaaidFAl5YCSVOQ9M8YCvkGrnX26J7VgmAg2wz3LiPPoTGa2c76s+VOJ6jgKpw7AlMUMl3cvS8dUvUKz8SNcRR5koJkELiJaCNRgu3a5MRRn8E3cwel2yRk3vSojAwIVnzuID3bQ7VOuD0WSzYM+TbrfE7MV13sMW4TylGHk9zQX9yYNYu1nTbBI92Rigl/54jjz01bYLUqPEoHr8GEHKV+UozIouPzXv40R3WZGa0aVofbuhBsOgRMOmQLvTMwgbq/RsFBzj4IaYeb7mBm3UqGLuk49uWgnEacVMqoYX0Nfl5RqvEBJVvQ9H4N2VZW7ORkv3ZmPPcbyZ+QYj1PFj85hPdcmH4tdqegarlK0UDMatFXjJY3WIk3+bktEkyEqWdunsF8dO6spI+EnW+eSYP29u+3T9tNdJmSNzYAvrs8ZYW+2zwwWrH1dLcdHeV4Ymu6t6mrOQxow1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(376002)(346002)(136003)(366004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(6506007)(6666004)(478600001)(4744005)(6486002)(4326008)(8676002)(8936002)(86362001)(5660300002)(66476007)(66556008)(316002)(6916009)(66946007)(83380400001)(26005)(36756003)(41300700001)(38100700002)(2616005)(6512007)(1076003)(107886003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u3yExKzojgjGwHHbKKFvQdYWLD+1Ul2S0nycPOFsCFj2+tpv31KFyj/a59r0?=
 =?us-ascii?Q?p/+U8iUP73rrMGgNvdUQbI3m4aV0RDtCPppfwdbVXOnqw5vsjaiEVlESTneZ?=
 =?us-ascii?Q?2dIHOHb5sENwehNL3My7lP4xSh5IMe5UmBoaSLyTHcnCkLq3NfdXVyMAjONt?=
 =?us-ascii?Q?dhDTWbp2sCHqSTO2tMPqlaaNN4Dni4on0YOdx3S0DjGKWpxdwiXDSRd7ayE0?=
 =?us-ascii?Q?ZNd07tWto+rZsdvxg7i8687V6/NJTXFLh2bwBCe7p0kh/vQZYQQYhbx/ixKJ?=
 =?us-ascii?Q?8r8kapqoldbJqJVLcmPsH0Fyl9N6h2eQZhzaFxfdD0cjYKKymMuN8ERCb7DR?=
 =?us-ascii?Q?9nRTzLG9EQLmg1/8ixIDnOb9L1KsbFdcPZtMi1OCwUbm4of8yfjvJ6oN8dA6?=
 =?us-ascii?Q?2J56hBKKkZz08vty8OpmhjHgTbGr5+uM7S24TgDCkFc8N1yaX1ciGqzCkafU?=
 =?us-ascii?Q?NRxgMHOzo94jyku63g1zF8U6ZY0UTYyQVKWJcvov7GAZNJ3h6s3XVXJVPiU7?=
 =?us-ascii?Q?iFdWoDIxutdZmI+X+UTk0m+lPXsGA33D2009twI2UbYY5nYQ7UuFSAdQjkiw?=
 =?us-ascii?Q?7Amgql3Zfyyd6Y7TYIMSG3jsUFKB4Z7SMCNLgiUZK37ER5IE8qrFGrgSVpAZ?=
 =?us-ascii?Q?pEsLsx57XLbebeCq/xSxYXxEnj6pRFtt3O6NPDn3XtK8g1EtqCpoRI/xQdI/?=
 =?us-ascii?Q?1VBrfj0gQG6YC9TBwr6Jl7Pb761y/xzfTapRnrdbnu/FHUZO+GE7BqTjQoWC?=
 =?us-ascii?Q?CtHPHADZ0sWq9/Kzqlue21dcZSmH4BGaL1S2ehvvFDxVdEzn51zb1s+7Hu32?=
 =?us-ascii?Q?HmKHCXlsAqNTcDFHFufiKcd4dLNDnWRbUb1lOPeuiitA2YpJYNTbu0IIB3Ph?=
 =?us-ascii?Q?Dlo/TXxYCykuiZmNlokUzWp9Xe/pdSYAU/aTZaJ6EpAZuwABRq75iZV41EdX?=
 =?us-ascii?Q?drE9bQMRcEoYmIo8NTQyYG+0MFrhXVR8i0O9MgPTe8vjS0HFnjfaJpkh7UAV?=
 =?us-ascii?Q?RbZ8d+nCwfQS3sbvG/leqdg0FDbi9c65KO67yHqFXEFEyDpMTSLVUtA7Wuiw?=
 =?us-ascii?Q?n6PlNYa4mP4/9SVDhcZL1gOlfUUdXzK/HZN1EZ7ImgyQ11mkzN8z8s/HUndw?=
 =?us-ascii?Q?/bQuuFP5WTVrizThNq16NzByxTkhH96xAa4zvAlDIgGVk4yWxXlLSxYpCPlN?=
 =?us-ascii?Q?qv/htOzRY8U+jWmMgK6om411Y7FKHk27DV+NDNW0iGigrSKeYGKtW71rPm6a?=
 =?us-ascii?Q?wCJlpMN4jk5qlal3aJWmWdfdfgA7W6QZf+RFVFB0dzgjhkpiGb6tebzFpVMm?=
 =?us-ascii?Q?hoolCTQmPOEpAeSHCtPHIRI45evXL1Ip2VbIXRjnApTjBCS7OPxB3V9ei6ME?=
 =?us-ascii?Q?SSUMfxhKvO43rS47Ol5YdYU0Y6hR1hLTh5Eixclvo08GNXg1YLhOAQpVJ0j4?=
 =?us-ascii?Q?DURAip8Zlq/4GgCg3O9GlhqXIjqsRZHuqE8rjl+Sdm0LDwHizaundpqgXg9M?=
 =?us-ascii?Q?jws3HLUsSv3thtloFMXM9FVNJdhuuKmgDsXvjtl41bxQ+peO/gh2tdfBSeq4?=
 =?us-ascii?Q?HqdgxYev8r9TOeLAD4o=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d226e1-edf8-496b-a635-08dbf45fa8ad
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 00:26:29.3293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIS35RGF2H8eiWc2P8v7uJWybX6OJ07orcpydJj4CUkWBTXvpGMkH7HQgW3WqfJT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8808
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] cgroup_core01.c: Set umask before create directory
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

Some specific build's default mask is 0077, this will trigger issue if
you create directory with A but switch B to access it. Such as following
failed message will popup in current case:
cgroup_core01.c:50: TBROK: openat(21</sys/fs/cgroup/memory/ltp/test-3519/child_b>, 'tasks', 2, 0): EACCES (13)

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/controllers/cgroup/cgroup_core01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_core01.c b/testcases/kernel/controllers/cgroup/cgroup_core01.c
index 2e695deed..0deff6209 100644
--- a/testcases/kernel/controllers/cgroup/cgroup_core01.c
+++ b/testcases/kernel/controllers/cgroup/cgroup_core01.c
@@ -38,6 +38,7 @@ static void test_lesser_euid_open(void)
 	int fds[TST_CG_ROOTS_MAX] = {-1};
 	int i, loops;
 
+	umask(0022);
 	cg_child_a = tst_cg_group_mk(tst_cg, "child_a");
 	cg_child_b = tst_cg_group_mk(tst_cg, "child_b");
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
