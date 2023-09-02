Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22215CA0FFC
	for <ltp@archiver.kernel.org>; Sat,  2 Sep 2023 05:05:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F059C3CBC5F
	for <ltp@archiver.kernel.org>; Sat,  2 Sep 2023 07:05:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 880B13CBA0D
 for <ltp@lists.linux.it>; Sat,  2 Sep 2023 07:05:40 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8C3326009FB
 for <ltp@lists.linux.it>; Sat,  2 Sep 2023 07:05:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7ufb4ghwibI8mrRR6oW/+VEC6Euf3D0PBgO1FCHaY6FisaHTZSdsRkxVtf27p6bbKp5edAw22cDvYP+oaungco3p7mSBhV+3LWEiIW04GK5n0xO1ip6WR/G/zyAy6YxVFW6jHbgAkkHXN7zwpZ1xhy0XZifCeJLIpksh7uwWBtuXGMtpz17VLpI6ugtBIZBl+yNcXt98ZoEGrdShkRTTMR775XrRHCr7hQTAbKxnXG3rRvuuQpAScTtLab0WZvvZH0T5jh0nISWtYu3YUV9MkJXuVgjfNqNtTUTMWqK0U3v6wGE9hGRnFr1dvL4FTuEduNn+XrWUPO4P3zfxCaOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+UcdHA4QDW0i0l7H1vYCdnbOkk4D8mvZQVV8NbEnME=;
 b=fTPw2cuGEDzIWpc5FhX8M48fPEbpsLpbOzSHD7KgT+yPlPQDv7EIbjzDpRjkh3hDed5+GnPwNCK69m3sdnPwdsnlSIEmLgvEbCV4kudYdXErduEKrEuKI9wRT4ZsQGUhcTM9Cng86aO+ajAYclPHCn0oA+wZWVrTk0YNIbjxHB/+xvPnTPgLiyk7cnTac+prRQaKbya7F58gN/ee/wKTyisBNF9H4UK+UWPHryqBew30GSN+6NQ8pe+s62A9o/IK+/RJ8f1ZijLFU/UMSwIswaHxceiUm5+okZoQ8bB9ECXK100XRxveMGGZlLmtSCM0BNv1kNG+z426xTzjdbozmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+UcdHA4QDW0i0l7H1vYCdnbOkk4D8mvZQVV8NbEnME=;
 b=1M2hVYnfkNgzxfSTBa3ex+oRZbWgy/NOq458RgDwBpJ/yLj6It8+fQ7gF7KSuacspeFjbPEJSfUza/HemjZh5nJZyN/ZihTmbTibz9rdLzfVua3E7Dw83pys0iex1/h8UFYqnKJOVCV3oElwZfU0XVltbpOIAf9H/seR2KnsxFzRmg/cTfq9eRnchA1+RyiDPsSbkSvX4ZiSoLC+Qb7dvmQg+PXQs+EFuO84RrPulkOdsizKl09ZF2aHg+mxSELTBTq6If7obVSZ2TmkDPiYxtsc/S7DPUbwprRi7366hGDytfjzFW9VelY7BsWVqjCQXdWFMPjf3ZV2LCzf5Zcp5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AS8PR04MB8564.eurprd04.prod.outlook.com (2603:10a6:20b:423::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27; Sat, 2 Sep
 2023 05:05:37 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f%4]) with mapi id 15.20.6745.026; Sat, 2 Sep 2023
 05:05:37 +0000
Date: Sat, 2 Sep 2023 01:05:31 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZPLCmx3ndZP4JcT3@wegao>
References: <20230829231845.25866-1-wegao@suse.com>
 <20230831064727.5790-1-wegao@suse.com> <87wmxbh8kh.fsf@suse.de>
 <20230901101954.GA323151@pevik>
Content-Disposition: inline
In-Reply-To: <20230901101954.GA323151@pevik>
X-ClientProxiedBy: FR2P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::6) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AS8PR04MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0e706b-0acd-48c8-65a5-08dbab723ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UM3eOlyDFrRz0VSKTAPGqFgJ/ttlEVLaCA7HKVQ+hQ6yZfMbYImTwIGIxYVwQXguC55IrijWDEGIQFn9sPxvRFMwjT/NQ5HrhMXn7QGO9Pc1ocDUbiToc3119LHNSgX8eqQ7fo+6xkJITyVAlg2P5yfj/tSnOaiGjqADSXfEE2rpBqbdJsdpqBdrtsSy/02TGXP+1LlWxNye+fZKZ8OwJAS55G05jHQCiKo/s2Fefn9PlOGtGIbbK+rsEZLBNZihPyQ+2elms5nk/DrcSJ8HVSOGx+8X3waBkkVGxVhrmDEJwl8n1dBbmGc/ap0QkibjpIk9LLuOfHI6XMn3fmhDqoFG+JQrtKGicsQvd6RoMpUt3UjBVR7lKKZ9vmAYMkjHHIY3yfIIRQl+F2yGyWNBqeF25U/K2qgPUrjNc88MAuEP0KIV6xXdAAEn1OJTFGODma5WfeMq+gLWCo7x+UUXgWjxLpfCVrCIUnEE+pXcgZtIEQuMXgMKYMP2pf5jvQvRrgPsL00r14r7qQfVzLBrJpP364hMIrBh8paJ4RK6hGgoPpBytaExTK3R52PBZrRJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(396003)(136003)(39860400002)(376002)(346002)(366004)(186009)(1800799009)(451199024)(41300700001)(83380400001)(316002)(6916009)(66476007)(66556008)(66946007)(6506007)(2906002)(6486002)(33716001)(6666004)(478600001)(6512007)(9686003)(38100700002)(86362001)(26005)(5660300002)(8936002)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+erSe+pTymh8qiZGVfOLyQ/YPPpv0hVABRqBZRYa8pjdBHCo15buVrgiD2C5?=
 =?us-ascii?Q?9mGV04wKCs/kkiGyrZYtI6v+jOxumIVjwT0YQh+HELOJHlyXLQOPJPMqOyI8?=
 =?us-ascii?Q?lxFWdOPDsMkg2Kt3VLtW8lQups2wLA21C9gksw8rs/W3KXXR21v2tcpPAsG/?=
 =?us-ascii?Q?uILJwLNDaAn4ipZ1UzKwGfWYbItWx1gIwbDdHUEbQT69kXWmarK/9Z9I9tEl?=
 =?us-ascii?Q?WEcAMZLobCcoPcz6Gwtz3TE3r3GOeGTkNxpcwzwNRRf6Fwv5HafrnPy/uP/M?=
 =?us-ascii?Q?01sB0E2hQ7Km7ARSZCnihEHkEO51aYqS0CVXR+GRNFYoS99ooStctJ2d/UVt?=
 =?us-ascii?Q?LFJ7sRmwZXze+qaEasUAp9jK2Eka1PYrhacNMY1RHTiBSpuIJTkbvee29hwM?=
 =?us-ascii?Q?HvizhOFZYSJWCoOOv0FWz21lZLfLMwZ9j9HPaso5G22t396tgpSEsuBPEA1h?=
 =?us-ascii?Q?3o1mXf7VulPlollVukgvSah/BLRkR4AfQz1GEeyZBbbsKnSsPCKlh/6WAqsk?=
 =?us-ascii?Q?oo5l6wt1hrIb1MoE58nf/encqzITFJIl3N1wOU/60UXjfBc95nj/8KpU3pOG?=
 =?us-ascii?Q?06pPKEA6eZpnXZ6NPHPScf4PKqanrsqNSgot7TmjOinHU9KB03yPH1lTQFWR?=
 =?us-ascii?Q?gUz25oUT9TbOVbdomJRyrHWlBEGsFibomf+DQSpb4NaMXblqQd2xwVcTJIA7?=
 =?us-ascii?Q?V8Z2NNPOAtD7SIT1jQxwPXZXjcBbG+NddZ8H1JFiRB7vVM3/BM6S9nCNhN7m?=
 =?us-ascii?Q?fyu2AVIgPsui8oQos/FONMwXjSzoj3a7viUe7uPyf+qL64N62gHl3J7/dKjx?=
 =?us-ascii?Q?wLZxmRUDSTFlORhmEJvms+BIDKBfO34oYHsdt7Mw0e8PjdzK2Q14k2kCYzJF?=
 =?us-ascii?Q?2iHrACVQXnfw01DLyPCtY0wr2jVqB6EvZg9aphxeSckBFfDKAQi1EtxdAfM8?=
 =?us-ascii?Q?pitrx3Soo3djO2JiT06+fPPyfJi15QUXLy3AAUAnDBAZBCEBT3Lukm1/uWQT?=
 =?us-ascii?Q?hFQvhs6l+DgXWpbZV2UKlZhX2rEK6MR7U7GF4eLRMCRPxAXsdngAXsrwd727?=
 =?us-ascii?Q?k+rVUrukMXN1UM/2iAtFCUqb26lbHWEIXW6P/Lld7YJaDh0RAQHhbSwzWHqW?=
 =?us-ascii?Q?Yv8hznXfLMJgNIYnQJwFBYY2L8RYsUZfgUeLG26O7c4g21135QITJzIbFpF3?=
 =?us-ascii?Q?JqNjATs1Y0XMxzWsM3RF3pDES9sL7hj5Qk2w3peYtD5m1ocPYrZnZU+cobkR?=
 =?us-ascii?Q?BEby4Yt4TL0RBWf7fxSiih1uveIcP2oPOQ3KnKyfVEqOQ/qiDdKwVyiqMEbx?=
 =?us-ascii?Q?PUEC+RIf6FNI1VaTLO2cxQgfgHiIpzcYEKGBDgD6PjerWeKU0aIwCtHIPXDy?=
 =?us-ascii?Q?4f3o1xuUM8h8maLdpBin71KUVXxWKi8gXazv9zhO6ludeVhh6ehWzN0+BNpa?=
 =?us-ascii?Q?//Va9V/+JmOCKPQB8GJIljBpW1ZiC6FVtFnRn4dkaPUF9zTT3um8gW9WN1X5?=
 =?us-ascii?Q?DrEFx9zuPGDBd/XDzNU8BL6bnuwwZfDnwgtW8xkGtyT+ljBjrRXslGpyoAq+?=
 =?us-ascii?Q?aMNmry9ZNnCYRoi/M5E=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0e706b-0acd-48c8-65a5-08dbab723ecc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2023 05:05:37.2849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBPUz3DdJ9MtFJ+6QUXxsO4b6HKvqIsLY1Ojlg8cFOHKVG0LJrEcyRmpMcY/HDjm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8564
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] clone3: Add clone3's clone_args cgroup
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

On Fri, Sep 01, 2023 at 12:19:54PM +0200, Petr Vorel wrote:
> Hi Wei, Richie,
> 
> > Hello,
> 
> > Wei Gao via ltp <ltp@lists.linux.it> writes:
> 
> > > +
> > > +static struct tst_test test = {
> > > +	.test_all = run,
> > > +	.setup = setup,
> > > +	.cleanup = cleanup,
> > > +	.forks_child = 1,
> > > +	.max_runtime = 20,
> 
> > I removed this and merged!
> 
> This change, merged as 45f6916ba ("clone3: Add clone3's clone_args cgroup")
> caused failing clone302:
> 
> tst_buffers.c:56: TINFO: Test is using guarded buffers
> tst_test.c:1559: TINFO: Timeout per run is 0h 00m 30s
> clone302.c:101: TPASS: invalid args: clone3() failed as expected: EFAULT (14)
> clone302.c:101: TPASS: zero size: clone3() failed as expected: EINVAL (22)
> clone302.c:91: TFAIL: short size: clone3() passed unexpectedly
> clone302.c:101: TPASS: extra size: clone3() failed as expected: EFAULT (14)
> clone302.c:101: TPASS: sighand-no-VM: clone3() failed as expected: EINVAL (22)
> clone302.c:101: TPASS: thread-no-sighand: clone3() failed as expected: EINVAL (22)
> clone302.c:101: TPASS: fs-newns: clone3() failed as expected: EINVAL (22)
> clone302.c:101: TPASS: invalid pidfd: clone3() failed as expected: EFAULT (14)
> clone302.c:101: TPASS: invalid signal: clone3() failed as expected: EINVAL (22)
> clone302.c:101: TPASS: zero-stack-size: clone3() failed as expected: EINVAL (22)
> clone302.c:101: TPASS: invalid-stack: clone3() failed as expected: EINVAL (22)
> 
> Summary:
> passed   10
> failed   1
> broken   0
> skipped  0
> warnings 0
> ### TEST clone302 COMPLETE >>> 1.
> 
> Could you please have look and fix it?
No problem, i will check this.
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
