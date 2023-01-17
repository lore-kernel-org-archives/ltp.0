Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B39C3DA78
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 04:08:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD2D43CC93A
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 05:08:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EF863CBBAF
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 05:08:00 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2087.outbound.protection.outlook.com [40.107.104.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 39A801A0066B
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 05:07:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jViWPTRckc8hsMvn+B1M5hXarY48BqBmbERKQ8U7L4Bn79ynWTmUKG18cetnqFj7/to7Z9oq3CNNJhBr9g3vGmq0FMJ1MJYFTvqQcmqHlQf0Vqy8DZfg8YBQdn8QITrY1euwN9lPOlMQQZtQocVIAtXWaWPDy2ZUMgD4lPtAUGGeLEmZ6NcRv99uWYF23/C34xNbIqRWQIHT6XwcdvS5jqBbq07P7794SihyefE55E+IcOFXN/0WCOt1vdPqvzJvltXgXC1WCWRbBXBmY8uRAZ7gmBb+/W5Xi2B3FPZLA6vK1t3IlTdjtFzs6HwvGlDTJYxHJnwlkcF7E41Et3iXfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gVUDt9IZwdNKSf7tpirZmDTs56HOrKWo8kZixyCENg=;
 b=InF238JgmElNMP40YCi+e849ohB02Ec9I+gU4g/L86kqnIx1j5m+TJ0tptLCl1LptHgk/Sw+3w+Hy8csVtXsR4bkpLnbyfwiX7qjYB7fny5P+LH6rQrkWCJ9CAzBIk2YXLOyj8XIShUkbVIAqKFk+PqijFljkgPyr+9I4MuXwneXlGOYOgKPWFKwyM496MyebCt7Es45ROzwExiaur96rX7gGuV7/E3BTuj3xhDWz3dHEsbHK+YnGgDdZctFYOYWakVwI8oZrougSwiM4PcRK8DdHZMCHz5rf70f5dW8/lk1hsu874C6KLQ434+mqz8vdxrRVBEdfu3hha6a/6KxBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gVUDt9IZwdNKSf7tpirZmDTs56HOrKWo8kZixyCENg=;
 b=sqqBIbmlo7hF3Kn+45kRvQsq5bEHTnwBwvz4Pcx2GHrcW78X/kPNGpVXWtBJ4vQd/Ijzo0XwA4yh9+JA0PSRjgPscFvcfThRf/2tLCBVcfyS5RY65uAMVV46vJh/NAnDF7suzGsSpzFkJODf9WMix+Sq7cGdxrnOTLESa550HBGwA/TjK4Ay3OG1fdxQWiovIhqHY7m6MvUhl6prJPcirLo/pWMyo7wcCng+SaGTWuMltjTi8BiJqyKWmwc05KlfaahT1if4xEQEoLImpySp4M9M9LSN33cxko9yv7DjeXLnWZv3EscjoKfvTTkDUjYX0sYdU+BWFSTXszfcIN3z9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS4PR04MB9433.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::14)
 by AS8PR04MB7879.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 04:07:56 +0000
Received: from AS4PR04MB9433.eurprd04.prod.outlook.com
 ([fe80::7f5d:f7d9:47b1:cc2e]) by AS4PR04MB9433.eurprd04.prod.outlook.com
 ([fe80::7f5d:f7d9:47b1:cc2e%4]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 04:07:56 +0000
Date: Mon, 16 Jan 2023 23:07:42 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y8YfDqFtZ+tDY/Uk@aa>
References: <Y8VRpdW7LUh4uFm9@yuki> <87bkmywlb7.fsf@suse.de>
 <Y8V7+U1p/Zk1LWye@pevik>
Content-Disposition: inline
In-Reply-To: <Y8V7+U1p/Zk1LWye@pevik>
X-ClientProxiedBy: TY2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:404:56::23) To AS4PR04MB9433.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9433:EE_|AS8PR04MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: e19a557d-b8fa-4265-2ccd-08daf84069f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: erAjVXRrWIXCppP05v23WVhp9rCZ2l2DtGduoFETjz8La6ZePQiCW5KxFCXTEcnbtEy4Hakxpk6a/IVZZBLhGbL+psi30CmMKCCXz7q2R4RhXkYglngdyvjGhsoZfGVrLHP2IDE51wucdToLTWJk6dO5Vj9Ukg53xyS8BxAl5kDGFUswWaFAEubdnDUsm+itF3VcPVhe9a54TNDE5InJi59AqzrAbXAaJuJKUC4y2AbHPlYAK6egSi3QmwyJSEiT/TxMLHYqRg1McvGR4d6AIcB2A5eevSOJgg6WmOIskC1HRVAt2xZqD2LC3JWQU7stF44rCmgY4BaMy0dTTeKbQ7EUD3MlXNOTaeIlXo2tpWVyouD3kvG8sMDG0PQ8a87JTdgxiNLcjTln1gO14ZDViSY7tQO9giZRMfyYPR50H72KUom/teIjS21nIX7PxhJtrgJhh6U2GQGODdSPAVQNovr4gWWyeqN0vLImLBhKKQgNfjJMdIM23zsPu5ZeU7oaLSGYqrmZ+Shpl5BY49ZBAYO8CGjx4I4rN6RT5DEfyIIxEOEojHjLskeWq2stLxcsjuDcKK+t7yPYJnnUKKz8IZcB/lKFJ6hVgip+9++daToacXc1MIS5Xvd5Us6DbWIjwnmOQWUpGGTXKLcXfoeJso/NvBS1uLREM9r6z44Wnf9TeR9KYV89GskjH/xzjF1WNa/04cgTcsHWfl7LoNlPBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9433.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(7916004)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199015)(33716001)(66476007)(66946007)(66556008)(9686003)(41300700001)(6512007)(26005)(8676002)(186003)(6916009)(4326008)(86362001)(83380400001)(5660300002)(8936002)(38100700002)(6666004)(54906003)(478600001)(6506007)(316002)(2906002)(6486002)(966005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fYcH/LlXqPUfqVIFtY97LdKulftC9xpotoPvgmA3sjaO697MLU17AqmZJhyn?=
 =?us-ascii?Q?kiiPsFMYq+u720ZCOr/AKluHs+jaz26AxTvvpelDV2XWbqona096GLY/1jzU?=
 =?us-ascii?Q?vnBDVx+wI7vSsChDO5kRPvfyaXoPMN6PKN6xL0NNNztcb/8A5Jq1Ky18VjNc?=
 =?us-ascii?Q?iHIb8KtNx2VBW15bHuMTvHe3b22DVZPnGBCzYsA1PCP7c+cqqwsseNnJp4ZN?=
 =?us-ascii?Q?43qPR//b4S8kxSm8Pa3SSCdwAytylvpt5/JfVx5ZDVr0gtVvzYdcEf3Gzfx4?=
 =?us-ascii?Q?n47V35Tg4lmHbUwuV6FPmwrPLVg6T8Ud4Y/CYYHqrrJE+C/G7zEXpCIY8xsA?=
 =?us-ascii?Q?b7Mzo9YQymstBdhyT71C1DpmheyxC2lkPcW/PmFEycXbpFA0m1xgGkTrclYi?=
 =?us-ascii?Q?yiafRsFoNt5YYvZHR7PZP2S+mFxRWXEQ+2arblgHSoXP+ornYCjPLuU81jzp?=
 =?us-ascii?Q?PXOfqocqPkugxf+auh/3B1NtimPEu3hCUOwZED/Alsb6kmU1cY+r2Zn6vv2q?=
 =?us-ascii?Q?t332yYomxugz86WSK7CyD/YjLKG+ukwM169CD4zyDuDP4qPJpb+qwhXESllv?=
 =?us-ascii?Q?27ekIJeEFj0/fkeB+AKOlnCt9+E9KLDOB6XaGzbU4nf48Jekf53imFGoMf/A?=
 =?us-ascii?Q?qerauHV5FHBIakxzzx/Ag0gsNYPCiNdvekxs6IfXNmyoLm3zcsG19oLDEXhN?=
 =?us-ascii?Q?T73y/GgzSJD2zaHVcfW9vwe1RcmZcGy7f99vZ9TQ4p+2496U0IM0bLhQycBD?=
 =?us-ascii?Q?uOVI54nL4aJ7viJs9baaUE7JIcPxxeER4wXgAwXxzsj83Bucyn595alrJ2pa?=
 =?us-ascii?Q?J3TGkeg1U4JaLM8A9Q0feBi9ArtAoxhXAg6A+JT9B3p9XqSG0O2TVT8kwO9g?=
 =?us-ascii?Q?Zur5R3B+QPKRSCb6pnJ7pyQEA1fGeI0tUrpRk+G6YIN3q0AVDWlS7L7yWqi0?=
 =?us-ascii?Q?GblsgFdggjyJjJUnITtXB2HqmaxZE7D8fLMEqm3wf6Ps5snuckP+zStgh1vO?=
 =?us-ascii?Q?3I88mxfh3cXx4GfbSIcZvt4hHv9hstFhhg1R8USvgbHLhPb2IudXwEKaccte?=
 =?us-ascii?Q?H2k7R5XWfsuwKcbPqDS8jL5lu7bK2FW1xBuQUGydGVMcVE8QbFh4rMmJoiCA?=
 =?us-ascii?Q?Fl+R7zVt/SDVtjIn0flrNOewW9tcQ0pdxS8rZNPOA+hLSV9iZ3p4kOoP5dfQ?=
 =?us-ascii?Q?MtHoBBZFldm5tBtUVRAtDXfCrcvt15iWv/UKcnGCN5SFww0ZGEC+RdPdpgt/?=
 =?us-ascii?Q?R4uc6sQXEvbHNlBwvs3eEGvqS41Au3bVSY46HHBUshHxd8FigY5eMRKgp6RJ?=
 =?us-ascii?Q?e/y5achtgXjmIfNJ5CxY6SMcooROEuB0oaJLdg+qjZgNa59rqf8rhM3uImoH?=
 =?us-ascii?Q?zZxJ7uCtYsmyriBoKxPl3EvIVABdj3uljhBKsfY1MVLcYE4/z/JB1962mBH2?=
 =?us-ascii?Q?r8zGUnaClC9Ahz9dD0sEceax8CghxQykk8UzypWp9GlNM5YzgU5lgZfX3TQy?=
 =?us-ascii?Q?iLQu5TcmudNII+5cu7mStYFxMU3PiV3xye14hHB/rXZ5EIkFe+HvdukCHVS6?=
 =?us-ascii?Q?t4LDxOP7BEAw3LesFLw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19a557d-b8fa-4265-2ccd-08daf84069f4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9433.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 04:07:56.7270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UGBGfME+cNlKVRChL4aauTFJpoI5ykOxdCD/KfSLBdON2OCKBxUhUIques1HkQ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7879
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Jan 16, 2023 at 05:31:53PM +0100, Petr Vorel wrote:
> Hi Cyril, Richie, Wei,
> 
> > Hello,
> 
> > Cyril Hrubis <chrubis@suse.cz> writes:
> 
> > > Hi!
> > > It's about the time to start preparing for the LTP January release. Well
> > > we should have started at least a week ago, but my family was sick and
> > > nobody else seemd to start to work on that...
> 
> Thanks for remembering. Time flies + obviously nobody set any calendar event to
> remember the release months.
> 
> > > Anyways let's start with listing patches that should be considered for
> > > the release, looking at patchwork the queueu is nice and short so I
> > > suppose there will not be many and that we can start with pre-release
> > > testing now and do a git freeze at the start of the next week. Does that
> > > sound reasonable?
> 
> +1
> 
> > > Also are there any volunteers for picking up various release tasks?
> 
> > > -- 
> > > Cyril Hrubis
> > > chrubis@suse.cz
> 
> > My fix for fcntl36/34 doesn't seem to fully work for fcntl36 on 32bit
> > compat. Hopefully I can fix that before next week.
> 
> +1, thanks for working on it.
> 
> I'd like to fix tst_rhost_run.sh failing.
> @Wei do you plan to fix it or shell I have look into it?

@Petr

I create following new patch today help fix tst_rhost_run.sh fail
https://patchwork.ozlabs.org/project/ltp/patch/20230117040132.5245-1-wegao@suse.com/

Also i suggest also merge old PATH patch together then at least we can run single test case currently.
https://patchwork.ozlabs.org/project/ltp/patch/20230111195231.23596-1-wegao@suse.com/

Info me if any further action i need take, thanks : )

> 
> BTW the move of testcases/kernel/containers/share/ content to testcases/lib
> which I suggested and we got Cyril's ack [1] is trivial, but as it's just a make
> dependency fix, it can wait after the release. The test failure is what matters
> more.
> 
> Kind regards,
> Petr
> 
> [1] https://lore.kernel.org/ltp/Y8UubJZcN89y77AA@yuki/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
