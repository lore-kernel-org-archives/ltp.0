Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691E9C761AF
	for <ltp@archiver.kernel.org>; Thu, 30 Mar 2023 08:44:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 669493CC9A0
	for <ltp@archiver.kernel.org>; Thu, 30 Mar 2023 10:44:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A381E3CA2AB
 for <ltp@lists.linux.it>; Thu, 30 Mar 2023 07:24:04 +0200 (CEST)
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com
 (mail-centralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5E9CC1A00437
 for <ltp@lists.linux.it>; Thu, 30 Mar 2023 07:24:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSBGJqCOpOGSHY1l00CW0krjOcewKud7M+P0ipzX4d0VXMwjOf14OgRTf+2MV+HheCMNzKzK0bTM6FNtAaBeHl81RtIQLAWbpAGvJhNDlFemVPavjc9VHlYP0TrAg9DDmUkDy+z0zvx0X/5S+KWdbEDuvzTxmz1VGLfWyatTQ8whuix5C/OcCKxy/3GI2GYfU3X1I16l8BX/cUdoRuNJammQALpZc5JpW91l+DipXpUxQKdi6ORg8v/o4p+PaskYi8UWz4KQMyxVIYPBD+CoFSnpg0+CZ6khv/3HPpCZg98UtUAj4TaWqpynW8sDySj8VOMXOYJsHnan/vrvgbswgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZ+9MDeLwbOrGKyddRBUkaGg8lToaF4WjjNeSr6cRGA=;
 b=FsP/BOTzu5Q5XEZ3jNz0ZQY3Li3aphddnwsP/NKhRxZ7NdOs4mBYmQT2miTUsKpYacQ5EeO6P3kVKqS64bVduXfouSy8RpSW/G4gAx253cPbeOXFiYNeNnnCEtKofmWtLCbeF15Gh7BTfM//tHA3G6A2/vRJWweJZYeTy+bBCdG0KTgzcJxl7ofEmN0xH8vNFBlVCLeF2dp1SiYMdP8NdAubbQC4aXM1RoAbqXET/hV7Y2tHOmOckbBduM4VuvafiHojcV3S9wNWQkOcFMZhgAnHLzMgeZsrqGw4j1DmP3r05huv5ZnyscQKqkbC5bZn51ZQp4VbKqQ8bhc/jWdsYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZ+9MDeLwbOrGKyddRBUkaGg8lToaF4WjjNeSr6cRGA=;
 b=q8Sh7F647qb4LVavdaDYKDCOXOVjXxZ7GPFe27wrbhY6GsSDufKkepsGfou/14vcnRrgJp/g4dO+B9A8vBAI/znslXEZLnWd0AcY/C4EKlGHCp7fh/RDC5QATLu9xqjvWjEWfZypt1I87ubj2P0pt7k+3riWE6k7YPwtxbsQ6ao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BL0PR05MB5409.namprd05.prod.outlook.com (2603:10b6:208:6e::17)
 by MN2PR05MB7183.namprd05.prod.outlook.com (2603:10b6:208:196::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 05:23:58 +0000
Received: from BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::f634:136a:e2b9:a729]) by BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::f634:136a:e2b9:a729%3]) with mapi id 15.20.6222.028; Thu, 30 Mar 2023
 05:23:58 +0000
To: ltp@lists.linux.it,
	kashwindayan@vmware.com,
	akaher@vmware.com
Date: Thu, 30 Mar 2023 10:53:48 +0530
Message-Id: <1680153828-28376-1-git-send-email-kashwindayan@vmware.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: BY3PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::29) To BL0PR05MB5409.namprd05.prod.outlook.com
 (2603:10b6:208:6e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR05MB5409:EE_|MN2PR05MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: d0aa7300-c354-4101-ecd7-08db30def685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dg8QlnnAfSgegsaWQjPzUo++Nadz+jjLNepo/CAMKBVZLsSgyrp4a1jHDOnm9YBnCzSEktTRLCiC9wdGn/lkp5rhSE0olJpOuN07dmZAXaFYI5sVXItyxkL5IfRg/VMYaHboujUs9DMepl05iWfQkc3NDiXhmkBK7JWt5hiFlv7NmG24mTxL8lcrCVPP7Crvw1DTL+chCwg9VKY3SEfnB7vv+hU1t6tgIxcbSN1KEq6GsDhoo9V+N8O+Wsvj+LoADiH1W0D+CsH7J0yLkriq46KI4zopEsI3DPUTjvwSfuMfbLzyPhmGUX3AUUiX4jd9DI1AK9xtlH8uV8RO1cQFTzrOh6jvn57E6BQHjvV1+DBIARuR3Ay4hEqjfykVoDiaEL1KQd4WtbU0yzpQswuLwBQDCWcdFoQHOWc8O5PB+X76Z1aWaQPE/lZ9jmFpiP/AuSf+A9hn9IVcx5JVUuSsysZVBChrD6spjfo/vWklV8glpeACpDOY4PX2CdiL91ymC9hff4u2reMkntEkTvK96aaJK46dOOQ7dXmdBobcj85SNHp+40ShRAAxvy8ls97Pig8T1uoGowlBTENEbTxj3BgPWx1XJBIhQvPdxlkhWpyuqwHxedSM0tKw1G4Co7Is
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR05MB5409.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199021)(6512007)(26005)(41300700001)(6506007)(6666004)(186003)(6486002)(52116002)(83380400001)(2616005)(478600001)(6636002)(316002)(38350700002)(38100700002)(66476007)(66556008)(66946007)(8676002)(2906002)(4744005)(86362001)(36756003)(5660300002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1pH5HJSon2wzPBIGZbFEr9yeOPdpGwvFhwIh8sAMhJKDlog/dmuIHFSjDCgR?=
 =?us-ascii?Q?FlAicJzVrlbV30yIz670NoleTNodAC7FS0Xl031dNmjyTO/5p8Dc4HuSKvyG?=
 =?us-ascii?Q?eMebM89LuLGVnQN9gWH34hbLeWRwyUa9sKWUmpXaIB7yUiUobRMCcMAP9CQJ?=
 =?us-ascii?Q?kldsp6t8rloqpupHIK8fFaPEbEum0oAbL8K+xb9+Iej2XJl418jmQ1klogs1?=
 =?us-ascii?Q?T0BEVXauer9ZUD1Eufjeolxnj5MxUvXlNVaJii4Pr44t3uijP6sysBmMpCpR?=
 =?us-ascii?Q?QN0P5Y9UWQtzGSXE0DV5NAQlkNHx5Bi8rZ2Vtm6h/s1NUYsKXuScZ6JKrXYa?=
 =?us-ascii?Q?90tZ5K7R2a6aQT5akOI9Ojk51OzaW3K1mpf5S5xY4bm3B4MsBaPCS14PfPzG?=
 =?us-ascii?Q?vppQ7taofukNyl/YqdxpDCHBZhzBpj4w/C2eCp6wQ+PMus6BCV4FL4ATqnwa?=
 =?us-ascii?Q?M6YQEqc6SKNh4dh0um/QfxXVO2qrankVkXiQXDYrYqGFcmQK8r2qeeclhnHT?=
 =?us-ascii?Q?m1vqYT3gwlX+CvjoA1TCeknufXMT4VQZGgCDSYgvL1z2jQf6nqkYXqrLDpc+?=
 =?us-ascii?Q?tU+WmeOHwbro2vYFXXY5ZlhcVWexDkdA3w54f9GvMPt9VF488AZjLuWc1527?=
 =?us-ascii?Q?X5mmayjAOTpC5HPKtPPkNOd5gjTXD4nwNefOkSF9cKyCpcZH99MO0tduasCN?=
 =?us-ascii?Q?rnbbDlKkeji62UbcFma4vzr/XnkpLB0iifT2hOaUBta1DxV0veTnvi7h0T/r?=
 =?us-ascii?Q?ayIBrARqCJfcEmEfTc1fb12AvbR4zrqQgMSd/L8t4GoNW0Y9mIaHob11S2NO?=
 =?us-ascii?Q?V4Rgd1YC7b4joC4bR9TGmn1uU7nolPbZbnMOB+tH/ruHLkbvLzEkn5VJTVUk?=
 =?us-ascii?Q?eH/6hzAM3AUkdqSM4mmYSpKWqkq70qimtfCVXpwNIMxhdtGzbc7TSS6o551N?=
 =?us-ascii?Q?Js4jolksau64H+o6vn/HdYEX4A6z61ZLZ5l+dAWyenhIPv3u3Uwa5mjbfEno?=
 =?us-ascii?Q?x0qGdX8PVcCwSsmyjz8Ck+h21TLg9ChvK+PSPMF/64wqV+wbsBlVkd+tDZmE?=
 =?us-ascii?Q?H4f/d3OIWo/lN264pGRX9s0I01Jf1/VtcswWveJT+OUNNOyox5vdAIQfedfH?=
 =?us-ascii?Q?VzvvEpnBKmcuirGsHQrYFzp9fioUOjjK/gVjyg+A49lChBRWPLJHG1pLlJd7?=
 =?us-ascii?Q?sBWxrNz78maXFeD8rgavZa9qFNvOrh0Igidk4QkQhjd0VhQnMcERqyESUxf1?=
 =?us-ascii?Q?rFJzaEr8VqXcm75Xjl4c3qT6i2+UQ/VGpmKdBGdVtisSiNJuFdJPreCwxAs3?=
 =?us-ascii?Q?poVsVSZPXfZ6D+Dp0itIUbky1Hj77mQLmhzWqO3cI+Iozi/ecBombSf4W8Dc?=
 =?us-ascii?Q?unFBCYL81FMDBEgfPPB+gDY/y8Mv4DR8D5mmaiymsExFlXXCulCeU30sTu9Z?=
 =?us-ascii?Q?qIeJBPLeG6l5ZEpjrgLhJBmJQyFKk6rp7jnDqq6GitZhkO15K6aZKNjjZfxV?=
 =?us-ascii?Q?DVhD6QCN95ZuOgsfQ4tjFs7xBfudmAOEqLekE4qwSjKm0MXLVBY4VoeXOnEV?=
 =?us-ascii?Q?Gz9B+xNL3+6nX+JAGm/fugB4MeHI4U1WEL0VX5IC?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0aa7300-c354-4101-ecd7-08db30def685
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 05:23:58.2083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qPjt0XHIlfp2Wdx0l7O2n+le9P2Jcq/iU7jJGK7Rks5tn2xlRheZyyHEZtwbhiT95FoSukDDQ7RieBF2mhfFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB7183
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 30 Mar 2023 10:44:34 +0200
Subject: [LTP] [PATCH] io_control01: Initialise the io_stats start structure
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
From: Ashwin Dayanand Kamat via ltp <ltp@lists.linux.it>
Reply-To: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

struct io_stats start structure is a locally declared structure
which when not initialised can be filled with junk values in some platforms
like arm. These values are later compared and hence it leads to failure on
photon arm platform. Fix is to memset the structure.

Signed-off by: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
---
 testcases/kernel/controllers/io/io_control01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/controllers/io/io_control01.c b/testcases/kernel/controllers/io/io_control01.c
index c4e171af5..691196886 100644
--- a/testcases/kernel/controllers/io/io_control01.c
+++ b/testcases/kernel/controllers/io/io_control01.c
@@ -55,6 +55,7 @@ static void run(void)
 	char *buf = SAFE_MALLOC(MAX((size_t)BUFSIZ, pgsz));
 	struct io_stats start;
 
+	memset(&start, 0, sizeof(struct io_stats));
 	SAFE_CG_READ(tst_cg, "io.stat", buf, BUFSIZ - 1);
 	line = strtok_r(buf, "\n", &buf_ptr);
 	while (line) {
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
