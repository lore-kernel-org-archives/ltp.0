Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0F5C4332F
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 07:13:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CCA83CDB3C
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 08:13:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F6B43CB3DA
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 08:13:36 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A3FA91BB8752
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 08:13:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJUZeHhRQVlbHhVB/y9Xgv7npoSvfubOH3HNZBFKi7YN0vt80tAjYjKgGfIlat9q1NI5mkqn4gxOxCqYwKPMbalpK3IAn/3ZH9YXTUngVI4KrM24nDcco3h2epHhOa3yrqrkrJBnrlro2G+ne1JesBzTZ1qTr1CsingGmDk52VzPq4J2M/uqzOrLnZm4h+G5M3JNEO2Ll1A7W01ezLf4AWvAEnoTR2Sz77hGfTuhWrHANhYndA8d5iFvFPRQay9DUQt8gyM97NnaZPc+goYX4SDoz4bzDSs4kQEmj9fQ9pqYEaS5VGix5RPGGmvGR6Yrn0OTEHA6+LazSBVuuX1wMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9+FgHlFHA/2EyvL8xE7EBRCtpFN8fskBnhMtUW2/3I=;
 b=io6FggBWVritfIrsjV3w6G6gYaP0VQc8YqSbeyh+YvZLxIu41rtOPvcdz5tIILHAPIU+Yh3IZh3f3vE3xeSJnXPPz3DgEZF6Gayely2VDsxwtM+YW9OCauAPsPVzpzsjwdRPdJdoAeYwUhiJ3C1PXeMctpLryZEuiEKR15MGIvxkRtv9A7bxPor5rt+CkApx8DWHNBDktF4p5gIrXLPPRFSegtpwHiihlMxeJAYUjLX/CokbQ3k8jAC+/z77yj/hyyIwEZieLF0xY0Gup8JW/OP+UxBdGr5E5I9WpT7zGSMOxRhI3uLbEcSlK0vmnsuxdMGgeRJyAcTv3fWUZdTOVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9+FgHlFHA/2EyvL8xE7EBRCtpFN8fskBnhMtUW2/3I=;
 b=T2JyB5QvkvjosXZAZky9fawRLqbCfDg0abv71jzzUTNuEkRWxyNN+X7/WdkfMcmBp8XEvjf0UxJ63tO/K8l/fZLFy59PAAscKoqQOdyScns+SUmVHm+7BC8T8LBglOpvCHiUC0NeJiTeo/c/TujXOgJBa01kcf/vlsmeZ3aqfkv8o1PsFbP1JmyI4RAXs4HaU67L2tmrpsHEZu9OaSteJOhdBx8+OS02yTwmE72Ql638Jl+vctGwk4vvBzrqW4z9Ibs2StrHfqb/XsS79+luiy+jwhRRyCuvHeOHhs4/G9w1vxwefZhlTwPSch5pVXtcKi7b5utI3wSPCHWVEMbwNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by PAXPR04MB9153.eurprd04.prod.outlook.com (2603:10a6:102:22b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 07:13:33 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 07:13:33 +0000
To: ltp@lists.linux.it
Date: Thu, 14 Dec 2023 02:13:19 -0500
Message-Id: <20231214071321.9863-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231214063311.2325-1-wegao@suse.com>
References: <20231214063311.2325-1-wegao@suse.com>
X-ClientProxiedBy: TYWP286CA0032.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::16) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|PAXPR04MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 955a668a-14dc-48f6-d8ee-08dbfc742ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +QaLECkkgAIduv5T+PoKWTzK5pQ1QPTE339UXvCS3O9X58LWTA8+m0aJBv4KXOI0gr12AeQqUTtR1wspTVVznlJtaS9a8En8wTISWnrzYEvOUxncQtUHzo8Mwn3IypVV1vz/nzCP7DTGhZgc1pNLLNipD9HILg5wpARlAd2FQbQg2IArYjSJVU3Lr4/rcYru+GsQYYVRNdGDYjQ9rt88QYItx1bH6MTvgW9gI059NbLVVcBw4QJM08pZ4aB/x/jcY0bbPCriijP0ez0Dj1q3YjZ9A25ApE9Yzz9WyP5P0BY6Y0FGYCpLEeVEMQoyrUaYQxxsi/SOJtPjB+RGGdwfjsk2L6duu6biuPpyRfmHp4R1hZCF4KpdplAo5QrH/k2MF8e/qKXw0p316V6WwssVHrJAIHs8nfVAkL7Zid1It8MEm66aXkIv8+Xl3Vl9qjCxzNhhjAAxHo4S0YK5b1DTrNCWqv+3D3avHJDkHVSpnP+itUSP37M/OpjEZdmNRXgs31RRrJYK9kEDNglcnntWJ/ZiD0fpsZiohdSaZO/WjtdsrFRYCQiUZCw37n0UGWMp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66946007)(6916009)(6666004)(6486002)(66476007)(478600001)(66556008)(86362001)(5660300002)(316002)(8676002)(8936002)(4326008)(6512007)(6506007)(2616005)(1076003)(26005)(107886003)(36756003)(41300700001)(4744005)(2906002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?028rAV0d3kiwXN+y+VoPAoedJ0Fc6KTLhqPB6P0/qoJRFIkOm2dgS8ZzdT3V?=
 =?us-ascii?Q?TTRIyi5eBkL/upY9vWZAUoTeZHsGfKmTlA0T+ypBmVVUZTV6cLg1QDUHM8UN?=
 =?us-ascii?Q?zMt4litGzW57B0ORyhYHDU+uo/8WKTfx5wzagv10btohOZBGoLq3+BcZ8byX?=
 =?us-ascii?Q?mQqFclkXmL6HYlDbhiigD2RUZv4jGPJ9taJs1ERgDLP8nZwEPnCYiwHuJ08p?=
 =?us-ascii?Q?gZPC9P1qLBexqMbz9Cewv7QFmNEhX38qCqQlXPqmBOpCPg8WUxwMpQ9rnQ7s?=
 =?us-ascii?Q?Z3fNm5r1xJRgY/AHbqbCebCI+OOrT269OoLImikOiOJLSaxLKQhqq0kTcntD?=
 =?us-ascii?Q?689/e1Ao26OGJ7U/iAKDnw/Hk3DxB63kWRa4AJ7sGIIP/hT38FwljsAdBYge?=
 =?us-ascii?Q?QbitjhlB+VEp7nrdGTsnmKX9h7UYkxZHKWWxM/RRPEqee9ANPwKS6GzYImWP?=
 =?us-ascii?Q?NYC5g3oflcbbzk4eV96bLuoY3CsiOq+TX2p9jeXG4rLKcGjDSfvJI1f0aQb/?=
 =?us-ascii?Q?4xaMuJsmYoCsQ8L2oLWP4r00ylFE3p3VwR49z5yEHdpWounnMF48PAEZr9mD?=
 =?us-ascii?Q?a0RaLaaIy5L4Ex6tD8Cu3etGjfkxAvvpYFy6QsEYNgqlOCj5EzXOneHOP0vB?=
 =?us-ascii?Q?gMz+lXXkGU6l7sQMMZRUlIMyJOG+lqiMtVv4Jot0Cv19opkpMu5bhTxSiuD4?=
 =?us-ascii?Q?NCt/qTjCDt2TWFVJ1d0rpP9wWiGhtyexjm/joETx5ME+n40dq+uNSbG/U+2K?=
 =?us-ascii?Q?IkgkCywVwj35WUhatOSO0Il+rFfkSBaCuzxJom1uD7k6CXmFzzeqruNkSB1T?=
 =?us-ascii?Q?i8tQTCwviao2kZbyj/UVbIOFOAw5Cwxd7TxoQorbBkQwz4AoNRFBXeRhiqG5?=
 =?us-ascii?Q?gFGfQTWZo9mQdvEhgpCpzmBGIIXqiPuK1TQqpPfKUC57/JXcZjYH2EiUOma5?=
 =?us-ascii?Q?iq650aglPuoYk6O0+fW+CPfZEDxJWwSz/hb33YHB0Y0kzgkWho5jINCyBB1v?=
 =?us-ascii?Q?OOezNIaa82Qevw43JgtLETEKglbWscPkVSQA0yVhVgb139g7TFDw+Rz99JEu?=
 =?us-ascii?Q?uJxPC1ZKwkrrkSC34bYsyT8A7pyFam51CSurMEWwBYHakH1oQq1FP35yWDij?=
 =?us-ascii?Q?CpfF2JBoAG+vFjHUjDS5d/DyDWXiRIe47wn2NKu6v+zdEIBnOkAThXsfk40x?=
 =?us-ascii?Q?DAdhuU/B4uApr46iK58zdYgBHna4WjpCcgQpUjCmuSSzm3zS0qkgIHQufiz1?=
 =?us-ascii?Q?7slUbgGO8YMZVfJsri0bcIluaLx7igW5mwEVtkmic0OWAFha2FEfxiZvSlZn?=
 =?us-ascii?Q?SHjVha52gFsHlZNY2rPGwPSAx9GCj44HrEN3urWwIC6jKbVq65P3TftvI4Jd?=
 =?us-ascii?Q?tBDT18MA9Wsu4oLelrtaDEeeZjv8szYx7Do18rat7twh/nqH3nQp8TxjXkpx?=
 =?us-ascii?Q?jQkk2ro3G74MyRNYCOuz756PkWWKKZlr3iiqd1CRVYvG5z3uZLOUqoG2gegI?=
 =?us-ascii?Q?Rh0NVJ7nmElUMjozOZ7xwkaZCyBwRcOIto27A21afR2x4scuCdK8Q7wVW5We?=
 =?us-ascii?Q?0ZZ8QKR45MVHhqxkc40=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955a668a-14dc-48f6-d8ee-08dbfc742ea7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 07:13:33.3191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ER7dOWDSJajFe21ANs09Ndz65Nw1ygEJdlNz926mjbOjE9vXmCqm16d3zSzVhFIU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9153
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Add tst_print_meminfo function into swapping01
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


Wei Gao (2):
  tst_memutils.c: Add tst_print_meminfo function
  swapping01.c: Reporting /proc/meminfo during test

 include/tst_memutils.h                     |  6 ++++++
 include/tst_safe_macros.h                  |  2 ++
 lib/safe_macros.c                          | 16 ++++++++++++++++
 lib/tst_memutils.c                         |  5 +++++
 testcases/kernel/mem/swapping/swapping01.c |  3 +++
 5 files changed, 32 insertions(+)

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
