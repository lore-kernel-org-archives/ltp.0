Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E971FE7D240
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 07:12:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13E033CBAFF
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 09:12:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD22F3C9973
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 09:12:08 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AA699600C12
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 09:12:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5I1TE0gQFE4XxYvzkOd+mfkTKs9vCw06yEVmGEifhmn0Ug2Ukq5DwSuGLGf0HN6WRwCKFf7H2iPgfxLLI+4W6KmRZTVDfyuG7f+fvK0FRrxd992tcrbI/EWQgOgq2zB6kTBLVWU856yBTMMkRVgKbjFlEZiftvyaTIiQUekhm6UdkQ6DZWvZmJB2EIzASP2zEvQbUftsEK3ffMuruX7HVv/a1xOdQz040tYgJCN/QzVGDnfBlB2r6gdupLp8X4WHZhkJoBNz6FcylRu2ONcn2D6xSNgX6FCiQ4mWY88TZCKYvZIQAKUCGceXIycBknzb8+MMgns0ZEdfO88wHvoaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5MOAPzmVpr3mp6DroEKG1ok6M3bMeCts52MUs0GF4E=;
 b=WWKOoKrIeb0wGoxy1TKLjTDSz0zstKu0Is4KKNfpDqzGQOliNAhDmhwZ3/kaMWvtyaDKaaOPZV+sKUE54VCRjANHt+xUwL0gSOevR+1684qtwHvKTxesQHq6gCPehUFXnrL6v+28ky3spVvFLJYdPJ8sth6/9gizlFzkhjA6g04WZF5MdO7AU0inbFKwGXX9f0u9wDLcMf2ZedGeLYkmojzFNQv9DHBb1KnrdN8h8FrmzujEnJWri/+K+nIYaVm95/LQfQxPTyXoTW2dd8N36yURrRGUqHBy4iTea6L7c1N3I/i9eOUrZAT7fzgPGDVQUD8SQHLCtTQs40PDPh+dtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5MOAPzmVpr3mp6DroEKG1ok6M3bMeCts52MUs0GF4E=;
 b=X3Y3rfsYc8UdXVAcj2FaJc90DXxg01ZaSog7CTzwSGonRLm4zZh4uolasmNjjmy1RBHGNJp3KVR3FNebd24LxJxMyKxfpgbe150FmucBdyxGo3yivXf0kza8btiG5a0UFA/tkF1lTrn/+VMCXBsOIZ3pFU45/hcDSnzPC178FMC/5/6FnqrIGO6V2WN8sd8wl9Xi/KUC0yCR5zbcn57Opzx3GOBM4mNodeCmhoiMX1l55aL6LWLJowhfxYjb0uzcdBJVAMu1unPLLiMbYse2ps+FMkdsl2IyLTMVKx9pkR4p2ksgvLRpJwL9jJN8hhvxrhaXx2v2t23y5/dDE4+V/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 07:12:06 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 07:12:06 +0000
Date: Tue, 26 Sep 2023 03:12:00 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZRKEQKHgkpVURMFs@wegao>
References: <20230925144206.16895-1-mkittler@suse.de>
 <20230925151728.GE60471@pevik>
Content-Disposition: inline
In-Reply-To: <20230925151728.GE60471@pevik>
X-ClientProxiedBy: FR2P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::9) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AM9PR04MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: 2633d14f-b04f-470f-b7ca-08dbbe5fe423
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rwFg2j67lqU4r7ccMD5sojEExAE59R3dkNf/khBbdpDKZ7OFoje8OUQwCbwwh0m4g7l/oRJJNE5OMnVubOBNMA/rl56HvUxRYrzu5RwF4+8wAfyS2JH0CTXgpWSffox5ggzeEePvO3UsLxqd02CKWfXfqR913DJ5btTcW3HGEGjHr9tLroaf2Kg45aU9baw2QI8Oeg8MP8RgR8Zb5a0hawHKE8jBTplQ3ybvKyyKulb7pWu+3PSQTVM5ewGnMz6PYdeKiJo8KN4/rD72aPfNK6LfXow99L9QoOXDLYM36QQ7OA6fKnnf0b8PYzyn3ZC7pAH6kj9ZFAbAHZ56yv5gfaawds5YmhBUQJMGfapgio0w7zhNKxhnPSDBqYHpyJfVdCWdd+WYj2tHVXeJrzu7K/nsUsENOWdhIpEnmJnBP6iTNkZbWXMImOgi4guh7OncMUUjv4UNRTnykiBQG3nOJIrJkUpFroKmvgaL9EXHDTmpLCHdhtW/uDGGHfCkTYh06BP9Ckd0Vcr272RLV44q7QDimu1ecxrpFr5ce5baMztlSudLzJZeskCRnH3/ypiuDR08AhxOT8nqjo+NFQJLy/Ffut8r0FjdwZTXdw6lL2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(396003)(136003)(376002)(39860400002)(346002)(366004)(230922051799003)(186009)(1800799009)(451199024)(6512007)(9686003)(6486002)(6506007)(6666004)(86362001)(38100700002)(33716001)(26005)(2906002)(316002)(41300700001)(6916009)(8936002)(54906003)(66476007)(66946007)(966005)(4326008)(478600001)(8676002)(5660300002)(66556008)(81973001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UXCtkpOOuo7/XwQvw+XPur881q8eIdgipjXWCwIgoyeWfgiccxC3PQ68cGvT?=
 =?us-ascii?Q?fWYNAe1Gue3DBHDkCph/lMAi4Y7550KpJx9hoXKQ2ip1SQfxE/A4iQt4syLP?=
 =?us-ascii?Q?AXmrgdZleyAWSOJ8j2bo5ft/Xa9e6eB+6uXjh4xtsgjEIQlE1olRZj1zMz4p?=
 =?us-ascii?Q?2TwdaP9t7IpK3HZ7I9o4EWf1Zq+PksE3l8en+JA3//il4TiBNwju+J/E+S8W?=
 =?us-ascii?Q?g5moYx6vq23oS4145rBbh1zXp1WWHnIXGcdbvBZ6A2kuuCDQ8z2GWgD5jWPN?=
 =?us-ascii?Q?Dqqp/4ExtB6eM3GAN+6TbX09EIJyiSbIwbUYE6pIpOoORZNKdak7XyRKFKHi?=
 =?us-ascii?Q?AudVYmzJVMVGfJUNq9bw22TJ0/cpUi2U7vGCi1mz6cYBtWcYEBiSWUORIeOV?=
 =?us-ascii?Q?2If3WcRN2pk80PylPP18p/RWAV4DCBl4GB6/5uUTdyTCV5aj/7BqUsUTP/Lz?=
 =?us-ascii?Q?cKLMn2RyvkjnO3qgs6tR1XHSFNuQ9YA1BthBqBaMfRpWiOvE53yA98oxZ+iq?=
 =?us-ascii?Q?RzNa5Vui4Mng/PdsWG2NqwcFwK8oHJbxfKrEZYGTa6RG/ajJAVeoHRgWvMx1?=
 =?us-ascii?Q?WxT3ZfGXZm/lNQr3/WVvMseF3+5IysSkjpojLIvyUhQgUkUazfkCVjXOYTLk?=
 =?us-ascii?Q?gg6U75rXMk4RhwBi3k1AG+KG5tfU+2bSGpX/YRIhKp3nbZk2OML5jjZ7L+dv?=
 =?us-ascii?Q?jQy9w4K0jPi2XiLYE0HG4ueAkgDhS8CEs9/VCwhNuFEuv8iP6r/SKFPGMcMY?=
 =?us-ascii?Q?Y99Rl2LOpYpN5IqNIw0lht1hxrA8plqD4E9JpV0veEQmPFHteusOhsKV5KAo?=
 =?us-ascii?Q?ikqy6PTzzcwlIoX+HdVVqJNVEVxe303YOgmsrk9B1/3k6pIQt2hNc0UfLy7W?=
 =?us-ascii?Q?Rv2S+VLmD5WNP/CAryWtBUOvmMHzqDgo/UbTsr5xw6h6xVhCQ/Ev0+H1ttR1?=
 =?us-ascii?Q?kIHr+mBqqhRGabRpY1XyT8s//FKFFKS9By9ks7G5N2KyhOfnTivX8LnYs6nl?=
 =?us-ascii?Q?j/iVS0T7JgDoEC5uI0z0XtlBulzfNZPhGQTNDShdozEkBkRik38PGGGBdkho?=
 =?us-ascii?Q?TyCmcg46j7c/S9CCuhE7uBzN74lyJ7Dohx4tCUOBqVN+qIxC1bWAt5fk0TXU?=
 =?us-ascii?Q?JcDESbIxPcO2HeGA1lAioKoKeQp7ozSQ6Wq6B1FZ5Nn5uEJpi2TBBHsJywOb?=
 =?us-ascii?Q?+yB2TJxXQECwTJeGOlwCbdQUjTV91F9djjQwwxps4pw7GBIKb90ELr9Btg8S?=
 =?us-ascii?Q?2oBpWzJFo9L2nQe72CosqJtq+A4RiyKwAZXJvbKR4pcovAdyJo5weAK1o3ic?=
 =?us-ascii?Q?X9TQbXwHqzDgo3qvct7EosEMkuoTh3SyKZa45xinIM5l2n9bHYakUdHuBZNT?=
 =?us-ascii?Q?6J0SHajFy4YAWdRst6F5DEiFJwbtKulpSiZQqt/uVE0VoIT8dVUJe5vU3LkM?=
 =?us-ascii?Q?wdHnJHa2G9JiAEyhZ+7032knN8kM9xgCQFt6dGRGRmhV7aphk6MStoXWom5e?=
 =?us-ascii?Q?KgE98XM6/TgAFAAodW68dHDcigyxlTcsCxFEbpsFSTmJs69SLkXloZvjV358?=
 =?us-ascii?Q?E3UEdGuxCSoBPc3aRWK3UWql5oCzIlc6HqcssMum?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2633d14f-b04f-470f-b7ca-08dbbe5fe423
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 07:12:06.3027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cp23hFZGuedpdATTpIjLV9Mu6gmzASKoq0VwSIL1vXw5S3f5mYsvHTPzKY9zFuCf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8906
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Skip cgroup-related tests if `/sys/fs/cgroup`
 readonly
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Sep 25, 2023 at 05:17:28PM +0200, Petr Vorel wrote:
> Hi all,
> 
> > Otherwise clone303 fails with TBROK when `/sys/fs/cgroup` is mounted as
> > read-only which is normal in a container. The test result should better
> > be TCONF like it is already done in case of a permission error.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
  Tested-by: Wei Gao <wegao@suse.com>
> 
> IMHO another candidate for merging before release.
> 
> Kind regards,
> Petr
> 
> > Signed-off-by: Marius Kittler <mkittler@suse.de>
> > ---
> >  lib/tst_cgroup.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> > diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> > index fdeac6059..5240aadaa 100644
> > --- a/lib/tst_cgroup.c
> > +++ b/lib/tst_cgroup.c
> > @@ -383,6 +383,9 @@ static void cgroup_dir_mk(const struct cgroup_dir *const parent,
> >  		tst_brk(TCONF | TERRNO,
> >  			"Lack permission to make '%s/%s'; premake it or run as root",
> >  			dpath, dir_name);
> > +	} else if (errno == EROFS) {
> > +		tst_brk(TCONF | TERRNO, "'%s/%s' must not be read-only",
> > +			dpath, dir_name);
> >  	} else {
> >  		tst_brk(TBROK | TERRNO,
> >  			"mkdirat(%d<%s>, '%s', 0777)",
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
