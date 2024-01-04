Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5194C47073
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 02:23:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEE533CE76F
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 03:23:57 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A5FC3C8ADE
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 03:23:48 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DEF3A1A02361
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 03:23:47 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMRW0RxqsxfGR06l0NE1xEl+Rq0umlId5BBoGGpWJ5DZ8I+J26Np+f3aPwxUFc1PAurD0qT789wiq138QRbXLhz84JF+YbNeh/ieX5tvER0vCXLG9P6HFa9y1GfBH5k3hFrsC9HPxFMZ0Bwo39PMCeOdM7mmdIK5J1s4L7UN4T2VqlyGMkG3PvMZ/uDR/xIHJtNeBiqie0Q0lGlCYJUy8DGx/N0Vpjvr+tR6wLDzjD0rcaEtdObTbS41dFjzkTaToI9ffX1+5qb/DosoL0YN8Kt43WmAZobmsSZsVdrdZUpDRLXrSJyuV9PGqaDfinIIzEXODS7UCBT8K01uDeEdlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxlgSOWk0pi8uLJKIDshftEz9/uE3TPGvmrPp48yaGk=;
 b=DO/8HLct2K5rV8uqOgqDdD7GX5/GC4uqydMn/xUOyZ12DwxjGoPl1i1KiJcsKYutJX3ECOHmvjMYv2QDxWGTHJ4Amsh6KOwP3bc8+6uWq5Mi4YFdSRf++OcZyYYBwuOshNkvGSGmpV7cfaqz7KKZRhAuD1QcVVrhV1hhmtyKgXT+xQ+BFGM3atLZd6/kMv64RE8jDkDFIIBHAavpzd3+ekc1ITX+smU1bECtnrUG7cJHLHkPH1AcHG45KhEZHhF4snqpyVykv7UtjYJI+ccIRN3jNIEHEx8vnFnwdTRmkdlqrXR5fYiqdsBSE97IVie2f8V1JP024yZ6nEB6a6QARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxlgSOWk0pi8uLJKIDshftEz9/uE3TPGvmrPp48yaGk=;
 b=eIiaB4ufs7UZIKbScB769NATC9e5Gp3JhKUgod0YF7VbwxNOy42bRDIih0Mp8bhTDNYCwX74NYnbGTlbZD+6UuFNow9pdU2DB0pFpelEPIs1FXQ68A1Wo7atRoROSgngUgc7wzvATkQM/bJR0lwjIbmYubT7T+cg+DQQtSxFJhW3UWa8H1yac8pTufsgTJIZ8salYU5St5xHyUxvXBk4ojA3ibPUFCx0uS8kg+bPtX0sjboyohh5DOSJdjL0ZDpE1UU4Y2Bul9rBL+aN3XoHx3lbu7Pvm2D9rdK66gKRPHo/beBEybZEcPXiBdX/qClKsDI1D1FY7F9xoDdg3tXOMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AS8PR04MB8579.eurprd04.prod.outlook.com (2603:10a6:20b:426::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 02:23:46 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 02:23:45 +0000
Date: Wed, 3 Jan 2024 21:23:38 -0500
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it, chrubis@suse.cz
Message-ID: <ZZYWqu3AQZ5h4vd9@wegao>
References: <20231206105318.11832-1-wegao@suse.com>
 <20231222100611.12661-1-wegao@suse.com>
 <20231227132144.GA740736@pevik> <20231227144839.GB757946@pevik>
 <ZZUZBfdTGaQ7huVg@rei> <20240103084425.GB1073466@pevik>
 <ZZUpyz+/h8V+qb7f@wegao>
Content-Disposition: inline
In-Reply-To: <ZZUpyz+/h8V+qb7f@wegao>
X-ClientProxiedBy: SG2PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:4:7c::35) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AS8PR04MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: 586a0466-01c2-4796-dc40-08dc0ccc2d6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPrQCkxtoZrnifI9uMuSaFfg0etUMCa7t56xltVVFBQlPPw7p+bqjSZVuvTRgagkwdYBQKuMtRR7T0DkkD9ada7ao6rv6gl670ISa1/ZjhXbjw7RlWE8GTYHntz20mZCIpylZPAUnd7sz8n/yhXAW7bxa81cCjYUJKwu0cfmhm2S/UQfuH2FZQFMUgi3+6WfyZsjXkmW6FLQx3cXdZhBHWunSVYrOtc5AMj1IRAZz9bjQ2gdWoI34tU+lxMOOWslAQWR1KolzDHH28g8rbTgLkWhhp25F8egeV2LI5lXtZ3zla9wLkzF5qyy31/AF2me2+uxvcI+hhOJa0e+HkUBfaLQuaNdRllcLGRq8mdKPgx7Yz7enSp9S4cRPo1lprnzN97FD0JompumWMhrLEBzuX4BwPjk0mWhujfZg4w4dt7OOH/tmHFc6AG+JtVO7ukGvQ0tmhV/38c64kmmnduZKjW1DcKq/KdoyG0V3/N92v44XKhR1t8DtB4ePKIB9XjtbtnShiNAZqUh0IFr8p1DY2xwO29vH3l+3+v4tqTcjVEBTvUpLkG4n1zd1Ch89OUN4Zn828NDVPOIj6OoGkdQBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(366004)(136003)(346002)(376002)(39850400004)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(26005)(33716001)(38100700002)(83380400001)(8936002)(8676002)(316002)(41300700001)(5660300002)(2906002)(966005)(6666004)(478600001)(66556008)(6486002)(6506007)(6512007)(9686003)(66946007)(66476007)(86362001)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pndqdCQmNukfXlV+OIiu/5laRwy1v4tM7fWsgL52tTYSsmv7edX7Xx+EX8aq?=
 =?us-ascii?Q?HyEKj6IloXELBAQzsIPxR8PmI8AnIwBcsUr+g5dtFQApXBK1vllsxkxDE48n?=
 =?us-ascii?Q?phUn8qp/O/t2Cb6QbpqwX+fv/yNdefPSXnYE4+IJ8ZCGkk6pDPRQRak1SCeQ?=
 =?us-ascii?Q?WYXqObS0aGXfuRKgOVG8SxLeyEcr42yBxlCKMUAawytgau4x6tGNpcTHKqe5?=
 =?us-ascii?Q?6q4cZ8r6ffFxfUjphzjb2WCAcrIFLsLn1+G/6kXEgDevQQLlpQbYBUyzYtr+?=
 =?us-ascii?Q?xw5oFiGhsrSAiQScVhq8GlgzBsmxq0tAicAd1OBESXXFeXy7zhaDY9Zuo28U?=
 =?us-ascii?Q?gozaDVYarKg4hNL/8MWzO7v/9TwTp4zv2gNnLeujgdXvwPjWYcfCpNSbshar?=
 =?us-ascii?Q?zN6b1iP8VcIaKGzAkvCBLzrEX9NeskID4iAqEmrd4ls5X2y79ln3h4CyPrtB?=
 =?us-ascii?Q?6T2W+oy0UjzZb46EI+ne44XmxGLd4xuNC2cSNNJexHCDS/pVDJ/ox/uFd3ke?=
 =?us-ascii?Q?lSLNJpbTaJ40j3GJqpn4O34/szgoFNIC5Z0yON5mAYFRnF3v4OwlWrOYW6qj?=
 =?us-ascii?Q?p/N8vdcEHsy38PYFl//kejto/haBrK55Z+8Wm/qFG/V7EEd268QYTXSfq5px?=
 =?us-ascii?Q?McOqXZnSLfSXtdlrFmycRrcAhR8HeKKo5j+lJS3BPGuMya3RSTGcPW8kFPYQ?=
 =?us-ascii?Q?+MSCR2ozGkPlD4zHQbPDqZwMWNeDFhNbZZzg8cf7bC6XXSMkzWzwQbF4Vivs?=
 =?us-ascii?Q?wT7s556l7uh33CTwj0BctM4Vbbg1vG0Xj0i3KZ3TSFeEZp7vIsafzGOuBlgU?=
 =?us-ascii?Q?zjAgzUN+vJDlPVe/eQZ5qhFw9QblL66V1/Vpf8HkXRbV97zd9w14cgD+fQbc?=
 =?us-ascii?Q?AOEHzNf0pxOtLqF7UpWzmlOL4wLUZsvA8hoPWjxM91aI8dgt0bQtNm1mEzi6?=
 =?us-ascii?Q?8KJLl8ToMlRXXgRmYVZe0xigDmwyfFC3atTxjmTEFo4wmq4exS187qyz6d5u?=
 =?us-ascii?Q?+vmth4Nq3p5ZMaTKbeZ4QvKiT0jul8w3GWLJhESgbiNMtUE7Q6gcyIJEg9Rx?=
 =?us-ascii?Q?gu0uUdElI2g5Q5v1sZNDtI75iCRae3YLxSKMjgrVZT0583rq/BQjBX2QjdBL?=
 =?us-ascii?Q?xoCAi5lGVCGHuaiYFiDXPzFspzUHrn2qZK5Ro6Xv49ByYdpQLu+8oeeTb3uJ?=
 =?us-ascii?Q?ZPZ9D5hhkCTrElwVzdbqnJTa8uf+B2XpHn356yrYue1s61QSFK8lAoMKr/R0?=
 =?us-ascii?Q?ga/jD7GvXiDjS/nDMh9e+IBD1iRwAkKLsZHkfW/x95FsUkDb8E8fNQfwEaS6?=
 =?us-ascii?Q?bJaN3qLssR9csxHQJ3uVhBr5vKYOuOY7u+OpAkOFO4JRMbNSsijpGtk5v5dQ?=
 =?us-ascii?Q?aK33N93r5UQvo5QZ1NTacp9WjF5ttLlLDRP5RH090P0deXuiPUbedR8VTXWM?=
 =?us-ascii?Q?HYH7TP6/4S1sp1ez46g6KgJL7aMsZsShldhODIR49lXdec7GqdcCY7WYyuM+?=
 =?us-ascii?Q?aBuIxRIYsGDuRJbT2x5EA45HUW5fvUjWUL9cXJ/p1bMb26sZ9ND54JHqcpK6?=
 =?us-ascii?Q?0/Cx8CoLUnVzQaMOgWk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 586a0466-01c2-4796-dc40-08dc0ccc2d6f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 02:23:45.7608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zly3Ju2Yd/8qBKQg9+mZO211CNSpukHvHKG9wNDyLskbsdE1WstRwd+9sHSKuOem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8579
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getcwd01: Implement .test_variants
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

On Wed, Jan 03, 2024 at 04:32:59AM -0500, Wei Gao via ltp wrote:
> On Wed, Jan 03, 2024 at 09:44:25AM +0100, Petr Vorel wrote:
> > Hi Cyril, all,
> > 
> > > Hi!
> > > > @Li @Cyril: are you ok to test libc getcwd() wrapper implementations on NULL
> > > > buffer in getcwd01.c? Or we just skip NULL buffer test on all libc?
> > > > I would be ok to test it, because change in the implementation can influence
> > > > lots of user space software, although glibc or any other libc can obviously
> > > > change it's behavior.
> > 
> > > I guess that the easiest solution is to run the test in a child and pass
> > > the test both on EFAULT and child being killed by SIGSEGV. Any special
> > > cases and ifdefs are assuming something that is not promised and will
> > > have to be changed sooner or later.
> > 
> > Good point. I guess something like testcases/kernel/syscalls/mmap/mmap05.c
> > approach right? Wei, could you try that?
> Sure! Will check mmap05.c firstly.
I have checked mmap05.c, got idea how to check SIGSEGV, but in current case NULL buffer
will not trigger any SIGSEGV in musl(I have tested on musl env today). 
Correct me if i have misunderstanding.

BTW:I will continue update patch base Petr's former comments.
> > 
> > Kind regards,
> > Petr
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
