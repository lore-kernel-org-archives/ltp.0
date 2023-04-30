Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA56C77B60
	for <ltp@archiver.kernel.org>; Sun, 30 Apr 2023 07:16:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E6EE3CB967
	for <ltp@archiver.kernel.org>; Sun, 30 Apr 2023 09:16:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 832D73CB29A
 for <ltp@lists.linux.it>; Sun, 30 Apr 2023 09:16:10 +0200 (CEST)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ED8F01A00145
 for <ltp@lists.linux.it>; Sun, 30 Apr 2023 09:16:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6UIr5pjQs4Slp55tNAPoNlb+b20XkNGUo44bY44U4bl+Rccr3UsiULWcftiUOjnL0g0wlhWdAQ0rupVv7k1XBqjghcJwNKiXN/FdO3dokxY7pSX0Rrv9fm2E2h6xQmIWz7yyCP/80P6GiVzY7RNpzqtrr866blejw7C2RfPdlk7PZz97BSrMYe/DqM3jL9l/kQJIShAwcd7OoZUyOzOpoBnVHjaFcsTxuczMVkkucxDyUAUpcZkhW6pIK0lw/jyHP7wsb/pxq3qndRuhm07JEHic7YooMosoCk/QM4PlYlRCKyDk4AZrk1FdfkvRwsNR4z22UZrBzhU78ooCopnlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13mJF0N5cTEupo5335tPT9409AHcz+1oB6z1H1P2dcs=;
 b=hDvFwgcimLzAnCKLUWTA1S5G/wNslVh6zHqCk0ENYNNIvQ6YP4pgbsA9KL5fikfG8PMhk5Iiu+ZnoImC/XFPv74GjZvtHzZny3Shm2+Cvuo6sEYlt6lFQA+7Ta9pGkHwNZRCi12R3Oq5tXyVF6CwcbNLzn5MZDWPma5QdqbWuCYnsd5OGMxl3uMcpfy7oLdA68rEAlsLuWPDyMgkUkJ/4dYNFCmM+PaxeGSxzsNno+op7o350L2m90QKKWDBmX3ECocyVUmAEm197UyuixTXA3c+WIlAKauR9wVNctjE19w0XskEL1uSsy4J/UE79CTPBJVUhBFSRkiIghVXDfLy1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13mJF0N5cTEupo5335tPT9409AHcz+1oB6z1H1P2dcs=;
 b=GcMLEfBi1fOhWP1kc2KI3xfNSz6MTa1XROrKkOGPK1GCT4EcyZJLMIVNtpHxUrK+mQoY2zToaS3FhGVsP5LAUlQHpsz99fuZ02JWmg8SGvXvpDVGLkXe8AJoA3kJwbtbFV3YTsIGARO1d+woJo+foP25e2O/OCT7lrxhU+dmtWjl3N6bmd/mNPo7yoLnpuDbON9jithpxei6lTsYl7vXC77tP00jMC/L12z/kuv/e0SvJT1OhnCkvLYLSV1aVkBhls3V9IJYDgqnb2m1x0EWHbTt1C55wBGUNes9hUCYswrnedgfJGHNTMq7tvI8fHkHHnD1TjpQ+Ocdg5+DxVcuGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PAXPR04MB9060.eurprd04.prod.outlook.com (2603:10a6:102:223::9)
 by DB9PR04MB9913.eurprd04.prod.outlook.com (2603:10a6:10:4c4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.25; Sun, 30 Apr
 2023 07:16:08 +0000
Received: from PAXPR04MB9060.eurprd04.prod.outlook.com
 ([fe80::a656:3be6:2b0d:cf80]) by PAXPR04MB9060.eurprd04.prod.outlook.com
 ([fe80::a656:3be6:2b0d:cf80%7]) with mapi id 15.20.6340.028; Sun, 30 Apr 2023
 07:16:08 +0000
Date: Sun, 30 Apr 2023 03:15:53 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZE4VqQYBEtqywtgp@localhost>
References: <20230329133828.24835-1-wegao@suse.com>
 <20230424103056.6017-1-wegao@suse.com>
 <20230428124648.GA3209331@pevik>
Content-Disposition: inline
In-Reply-To: <20230428124648.GA3209331@pevik>
X-ClientProxiedBy: FR0P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::19) To PAXPR04MB9060.eurprd04.prod.outlook.com
 (2603:10a6:102:223::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9060:EE_|DB9PR04MB9913:EE_
X-MS-Office365-Filtering-Correlation-Id: 2826ebdf-d19c-47ac-e3e5-08db494ac4a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iS7rzYNg78rOw7SsnAwkssbB1gkBMm1yruFosyzrIs8CJrA20xuxhUwS0UlY70niqS3XJ7WT7/CsFc0tVCGgXzDpAr/TPjpIe+7wHVQjQDdXJo5/DMtJ0z3de/6APf9hyVGwnqYXeFQN2koiS12lyqnu4x3YezvVFS906yZ/TbvFcb/+YWuhX8Icl0t2NvNOzzRa4/IMzIFhGSEk0Mhze0FgJDrsF67Tcvau5gI3XkipyK3M/xyjfkPHoU89rT0qflCe4X5/kdz/iU5N/VrDA18sUQhMt8+yMmLeeiDVJwr+xg66IkkYbLDYVNWSJo5OIMLG9SvqeFQrHBkGmq9VTGCJpsga5CQ8Y3RxT3wYRfjLaZuV7kpIYA61KL/enX5tvINLkdc2S42Oi425X6m72W36Cd3BqFkW3wGzuSE6kkq7JxfVx3+lxHifhvZALqwAFczhBS60B45Sj+MYWcG07PzUwDkl9h8IFV8zLzYgDkRhv4tZ+OMcXL830MwcV9Xi3n/jy6VHeSIgT+i7aMVV9Cp07uAtT7PpK6AjsdECQ9+pfh9oeHH89/duV1x2N1+V
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9060.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(136003)(376002)(346002)(396003)(366004)(39850400004)(451199021)(2906002)(38100700002)(8936002)(5660300002)(8676002)(33716001)(86362001)(478600001)(26005)(83380400001)(6486002)(6666004)(4326008)(6916009)(66556008)(66476007)(66946007)(41300700001)(186003)(316002)(9686003)(6506007)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t2+h0ghMte6RfDsYpuio5+NcFHku81Pbmztwlq9aDguYgKagyRlab0q/JETN?=
 =?us-ascii?Q?dQCfRRyi/Oxse6B9e7XvrvTv7cQ3kPfIEdvvYVoIiCnrRjlpYH/cWcH7Umt7?=
 =?us-ascii?Q?pZXxUEr8zk95HAHtidtCq464mdLLlBP9DbIl+1u5SX9XHvoUFULWTG3amA9+?=
 =?us-ascii?Q?ErqMma7t1lF9thtMnuTND1ho91eogZ6xKZzUesLl4CmFbkDQGuGadkF9GUyh?=
 =?us-ascii?Q?Jj5QVrrv/aet+tcpadL5v9laTTl1kbJMJ3CAQLy57TtUZnBclofuedsLksCQ?=
 =?us-ascii?Q?x1FBGbL8LHQfe9XFGdxi5s0sdPzWPqt2sYNr8uBvG5mU1GRJihVogIXRy35i?=
 =?us-ascii?Q?738Qbu3BnNcq1rUVIeMuWpAMOlXj22Su966+yJ2y63QYdANKU+W1iM/a9QZV?=
 =?us-ascii?Q?kcJbkgJuDn/5VWsXnU/ZteNq2Q7ItuM0VjbYrbkWIpP4I0+XQ3d/6AhByzGR?=
 =?us-ascii?Q?40ksRTLBMNBvw/66YUVNlPjoAf0XPIGP9w6ESjHRChlNW+9fdQZrvcAOCfPI?=
 =?us-ascii?Q?bkweNjSs/urSfxNyfgU+zTRQqlmDgjupa9Wd/6P7gY0rsV/VwbwcdU4IB7y8?=
 =?us-ascii?Q?g3iBxzAZh7cdJhO8b+55uXWvOFseJ6JdGbc3sUWNAVNL9ZLYIA0rdfdDSpbT?=
 =?us-ascii?Q?bQFjvKNTwN201Q4/qCZOTOkLKaC8l617/cRAhYNOO+lCpryIY7xAXJPScuXX?=
 =?us-ascii?Q?XOmpA0MAe0cThekh9wf/jozTeCLereoI1a3iKXtnDD9SLiFlaKtfqPQHgCo5?=
 =?us-ascii?Q?yLIhE/Ef8zDz/k/TwnYarTqmmliObMRH4zX4HUEkQV6rKoZjEdequYhy3IVe?=
 =?us-ascii?Q?KIKNYfLlu9JqL0ETGeTL0n+mFWl7Er3vb41GP8d90CrKM54Ws8yDBqD/1PZh?=
 =?us-ascii?Q?cAp3/lq1robAuVWUQdp3IFQ1ZK0KjUHlRI5J3EiwbLH5gKVf3tpgmZ8iOGxW?=
 =?us-ascii?Q?K5nGeppvkzfsZs47HFpcxFiUlnI5OCFhIMw8+l6B9TJxMzdfeBUEIh54/80A?=
 =?us-ascii?Q?8FZJQCiCWqxGpB2rcsI2MamQ8FQU/VOZVKVSN+m6UH5YvLdAGx/IE0+THHut?=
 =?us-ascii?Q?+1IEijnoI1VQ6ys10enwFAaZmDtUTvzjykpELjwvoy6yQsWSRQ9vUYyprfGB?=
 =?us-ascii?Q?2WwRpwdZ9hhLdwGbVyn9R68wsUQytekDTqAGW93sYaWEyp0Y23P6Qsj89s8G?=
 =?us-ascii?Q?eUP9yZuqU6GRm40YKySj/h9LdoTsBIMBUOTCR7MkfCnZ6CLo/Mu01YprLd08?=
 =?us-ascii?Q?ITui948cPRN6qL7om0Qct2uXHyW7rQT1kVHsTfD3hWrXsnadXFMcYfqt/5G8?=
 =?us-ascii?Q?l/lK8kE2xxPmfMGyi8w1/dFQiZLZV4rcCfgFfBFDPoiKlIFXP0p05C37PWPf?=
 =?us-ascii?Q?y03LTZLgulmIzhOkM1bWgGCS8GhEDuJrUlqCkdk3cHECoAet8p/IzaAIa1cA?=
 =?us-ascii?Q?Om4cHskNZ7U/q9aup92piOl4C2+TUz3Q48U1ByOeZy7N+SdfuVemyzh5FUJt?=
 =?us-ascii?Q?ijO8Gn4BO5AAnfaFCJwRhbDRHUi+HoY0SWZFr+gx3uPtEiEWUfQP6Lx7bzqd?=
 =?us-ascii?Q?HKHeHdDf47AdpM08gQs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2826ebdf-d19c-47ac-e3e5-08db494ac4a6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9060.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2023 07:16:08.0233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtNY9A1QJqTY+Wdt5iXN+/ymhJ9MhnoU9joALpUTriNQORR5nGCztApnIrpHk++b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9913
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] recvmsg01: Refactor using new LTP API
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

On Fri, Apr 28, 2023 at 02:46:48PM +0200, Petr Vorel wrote:
> Hi Wei,
> 
> First, for some reason, with higher number of run "bad file descriptor" will
> fail, returning 0 instead of -1.
> It starts to fail from 200th:
> $ ./recvmsg01 -i 200
> 
> ...
> recvmsg01.c:283: TPASS: invalid iovec count successful
> recvmsg01.c:283: TPASS: rights reception successful
> recvmsg01.c:283: TPASS: invalid MSG_OOB flag set successful
> recvmsg01.c:283: TPASS: invalid MSG_ERRQUEUE flag set successful
> recvmsg01.c:283: TPASS: large cmesg length successful
> recvmsg01.c:276: TFAIL: bad file descriptor ; returned 0 (expected -1), errno 0 (expected 9): SUCCESS (0)
> 
> Summary:
> passed   1999
> failed   1
> broken   0
> skipped  0
> warnings 0
> 
> I also did some review, but I didn't have time to check properly whether subject
> of testing is valid (quite complex test).
> 
Thanks for your careful test.
I spent lot of time to investigat why this happen, finally i found it caused by wrong 
cleanup of the sock fd.
I also put this fix in v3 patch.

> > +static void setup_large_msg_control(int n)
> >  {
> > -	setup2();
> > -	controllen = sizeof(struct cmsghdr) - 1;
> > +	setup_valid_msg_control(n);
> > +	controllen = 128 * BUF_SIZE;
> Any idea why 128? What is this number for?
> >  }
I think this is random select number when this case first introduced.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
