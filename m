Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDEFCA5531
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 09:53:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60B4B3CB2EE
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 11:53:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 477D33CB2AF
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 11:53:08 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9CA511A00141
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 11:53:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ay9YAMDinA4w8VL2BR7xMqa2Qka/r1d/zjLbKvzEi2xdt0zOMJ014mwLG+Fx3jQUmhiPs2eIfQnuHPdkjbjky/45sYwzBojRRrUCgKdKXZw/4PC+Of13TY4v39C+I1Hd7HmvNDXDbMpsg83/1HVZqLVQzJuxWQxQkZTkDiAyyor2kMJq0uvP0VgZi4THXXuKxQ1XmNi7Uy8Ql4hXjOXZgyJYoMzImiuVhyU7Z4QQdE4a1wnVo+YZFKzpIC8nM4srhnQmtrm6j1W1VOkmLbOMsKO3e4N1APVmkr7f0Bw52ECGVXVviD72FKTl2isOzhDa7Nv5NkNe8s+cuKKuQ+MqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU7IPKSH7f+yTQQ7Gddu82DiBpbhog0NZ6HgmijE+bM=;
 b=D9avcmWZUPWPz4XV5uFbWy8DtkDTKdlyCyjg5AEQIovKnP4u7RmT2rZSso7Hijns6uHOPvhD4aVOkdTaWnVlreu0CPHSVAv5bqlKkoqGG0J3cwi8fWTtyH6aStFkKvDhvqfHNuKgF/xLBD8iq10QuxC13O1Id+h5XDwp+x+kpsjR0ZRu7F99M7TIED4Y6sv2USszndtYwwK9gfXyHY40xgw5FHclxoLWP0BFrg0OZxWbJdmvi9+gJuAvgYv6IgiwzhyKOHplynvwglgP5OfpDt+CVK+3gmTkT0Xy8I+IjrI3LwW74FWjufhFrbcD/21fbcApaZ1z+pWXRuMwYLxKFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU7IPKSH7f+yTQQ7Gddu82DiBpbhog0NZ6HgmijE+bM=;
 b=Rnai7klWolzemEHZSkBBuL0ge3wtxnSOtzyXAEUMGUgaCHyzfcxTrISuWx12OCZa+aZMiMrgWu1SJ0cNRdJ5xeT/l/cNqORZjfOs6jORRbYVGaIsNF/lJZTKyhIdGLRYs0FCOfEVGAuYkOTjAmz4tqjf1Mv9mTnrNQ10vvEk2t9rSusOr84BN/lfUSoaH8bgtxCfxnCG76RX0oyCTWksTRUrkP4+BakRqDOAjXhRTWoTx+WFJ3qEM79p/VAORbFd9pGJldJo9HAqS/8Ol4cCHQacxsRsVaDzfZJQkNHXfZfQqACgCOh1AF1Ekq7WzwNCK4lvl3ZkDmESVd736nT2BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by GV1PR04MB9053.eurprd04.prod.outlook.com (2603:10a6:150:1c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 09:53:04 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 09:53:04 +0000
Message-ID: <a483870d-f54e-4fb3-8427-003c369a96c1@suse.com>
Date: Wed, 13 Sep 2023 11:53:02 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <ZQF5J0UJ25_QLwcQ@yuki>
In-Reply-To: <ZQF5J0UJ25_QLwcQ@yuki>
X-ClientProxiedBy: FR0P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::11) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|GV1PR04MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: bfeb4c08-2986-4224-ac68-08dbb43f392b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRSNsoBoA50S8Z340d/OrUNIzDpgbl7axgOIxT/Tmjnie0omI2017iuhFErjHDMdRRCmeDAvI9p7eWG/TgUJB1xj5u2wEjjHZBvmUtbF+GFeaWcK4Fd2UCgTvcJDO4c55oKYjowQx4tAYjuXDXOm3AxxFevIa5QlCYwYrlFGBqW/iVUgY2aawMU1I9UmyxcUrEDV6kG+Kc7Vui5yjDo4G5568oNaD4K26P8lj0KVFiKkDHbfWQhQcqK60z+k6ru4XlZqa/R3LPMWutDs7x7Nv7XyWe2RXzL2Up+g/CYwAziKhWbeZr8/HJ7+24mK3JbbseGp4cpcZIIj3y81KC3N42jBhy1Ahw3b7wd5Cy4OoxZckiv53ljMv9hPjSBKzLUt2j6xlJOApk8c6hIAeeJNrKmCPMzPSYOTXpG+E/SDpAXioX4C+QRJ7Q1Uci4AW4BTAVfdztFSTv9uMWGt2I1mb95dIElaeyTvV8TyW7DKvViYK1UmwulnjUdZHJxSIJGqQ8UTn4pQ97KJEvXK2SBtVfzGCe0LDl16naVRr8DLMY4o4+vL6kpphRkuR4vGODIs5arzw9fZHd7ptQjlxNlyMvP6amEYaDb+jLG9PfBWOO09nLBup5Y1w0tcf7ayYXPIbY4PPgFA9ZVVla9ZZeag5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(1800799009)(186009)(451199024)(26005)(2616005)(44832011)(5660300002)(8936002)(8676002)(6486002)(6512007)(53546011)(6506007)(31686004)(83380400001)(478600001)(6916009)(316002)(31696002)(41300700001)(66946007)(66556008)(66476007)(36756003)(86362001)(4744005)(2906002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmNrdXg3MG1IVVp0Kzc3WGdnbWY0MkdFOHhHZ2F3QlBSdEh0SnBobWkwT2d4?=
 =?utf-8?B?Y2VQT3RsTUhvQ0YwN3RFT0pnOElIRVFLYldLUGpQb255TEdZMFlnK2IxdUta?=
 =?utf-8?B?U2hjSTkybmg2SGU2VDFHVWR5dnlKdUtkd0JnMXlKeHRZK0YxZHFERXNCZklC?=
 =?utf-8?B?OUlmcFhUclA1VlBzc1JxUDNpMWRrM01wZ3lsdUVaYlFqNmVkVUx2S3lVZ3VE?=
 =?utf-8?B?MWFydEpoKzIwQ1BlZHlNWHdlSUlwSWJINmxBMzYxSXRscGhDc1lUSU1Kb1VY?=
 =?utf-8?B?NDAxZWdSTExIRGFTS1A0VnJVZmgxSkY1VlNHbzk4Ly9jcXFvMGRGRnl3eTN0?=
 =?utf-8?B?bExOVGlESEhYc1I5MUY3czRUcmVGTmJFY2V2SWFyejFSd0hRc1Y2eGxkVkdT?=
 =?utf-8?B?cGtjZlJHeXo4RVhuMWt5V3dwdTFTTGE2VEtzeVBhQUVMTS9zT1BEVlRkUjQ4?=
 =?utf-8?B?Qld0TzgwY0tlYXV1djYzRGRTaVVwUnlGUVBIbkZlMFQvZTltZFpOMlUrOVEy?=
 =?utf-8?B?c296cVFXSjFnU3RzcEh2eGRNUldtTHZoRXk4U3NERHlOcGt3ZWRxcFVEVEMz?=
 =?utf-8?B?Nzh4dm1aOE12eW1tVCtyZzBBZ0loSmh1d3VmUUVOM28wWGpKMWZHVXNDZkRB?=
 =?utf-8?B?SFhtRmpYQ21LMHZIOHRWR2hOa0ZuY3M2aHQ3SS9remhpM2NKd29BWitwb3Nl?=
 =?utf-8?B?S1MwV2ZMRWpSdW4vTHQwMmFtVVRObnBqNlJmM2p5aVJEN0NXWnVySjE5d2ZT?=
 =?utf-8?B?SWI0Z1phRFJ6TzhXbnJRWVlvZG8yYTh4L2RiNlFvRGs2ZzZOQkhMREozc0ZL?=
 =?utf-8?B?c25uZUEybUZCWXFMRXpFN3hHY2lEQi9JM3dYVnNUcmJHNzI0L3AyTEZLZUxs?=
 =?utf-8?B?MVhzSGJRd1JlVVZrY0xRS1pSTXFYZjdXY0t1T1BpS0xrYlJucTh0NmI5YVBh?=
 =?utf-8?B?aU5NL1dqSmNkOWJuOWRwTk9Tcjk5TDMrVXQvZktSUDViVWZBcmpxVlJwOVFq?=
 =?utf-8?B?RFJSMDIyWTlROHpWWndhM1IzUXFBWmlMZnlDd3hsb0JzaVhTRUMzQmxEMldH?=
 =?utf-8?B?YVFqNnlIVmcyMFNHNXZINnVJM2pVSUVvUHJzNnRCRXBZMnI3SmFWTys5ZTNG?=
 =?utf-8?B?ajRwL1IvNzFWTk44SE13c2d5YVZSM1Y0REpRUll0RG9lcUtjeE5kcmE4V2Qz?=
 =?utf-8?B?MFVTeGRlWTNCOTJOejEyQ0U0NDhRbU5tbE5ZRVRhUHB6V3RuMG1scUorUkVo?=
 =?utf-8?B?WlJMZmZraE5wNCtISWVMRzB4c0U0VnlYOEdISTZSS2lUalFHOHJJaHl4Q2l6?=
 =?utf-8?B?Z29sZk1wckFaUjRXNys2c2lXK1liTTFEczRpaWc5U05mWVdMSFlLWWdIYWpE?=
 =?utf-8?B?Nyt0czJ5dGU4c29VU2dWbFZBTU80SUMxVGNKaEZJMFYvNmFROFlOSWNUZEND?=
 =?utf-8?B?bENISElxek9OcDB3Wnl3ZzNINVNoUUprdUdySFJvWUgrTzE4ckpBZVM5WU55?=
 =?utf-8?B?K1dMSXZhUHh3VWRGazZQWVVYYWNJTzRiR1BPZks2aTZDZzRqNi9HTVVBdWVy?=
 =?utf-8?B?aGMweXY0SXlCWkFsU0IxQTc3SnBzNE1NSUt5djE1TDJyRjl1Yjk5RUxjMzZI?=
 =?utf-8?B?dE5hbm9ta2hrTFZrNWlTdVQxVGI5d1dFSjdwcHlaZkF0ZEdKemlVOWd0NjJF?=
 =?utf-8?B?U29ZQzgzamRoYzRHUlJTMDBkUjRqVTBZNFZvZG1iV1RGVFlWRlAvTzcwclJ6?=
 =?utf-8?B?SmI4WW5SeGtMNWczcFF2R0pwN2h1YXkvQkkxdmxwNmlkcEkzak5GMTY3N3RL?=
 =?utf-8?B?cThUSTB6MFkrZVZxQ3o0RmtxcC9ZZXM4VERvWHVxSXhRTkE5dUlxay9lODJF?=
 =?utf-8?B?cjlhUkRSaFhhYmVRbmVnT1FuSmZ3UjZ1Z003c1lEeEhQRXBtRStkeGx6L3h1?=
 =?utf-8?B?R3VRem9ZdUJtVmxLOWN6SnNVckdnUEdiYzluMXZrQUpYVWRER3hyLzF6SEJN?=
 =?utf-8?B?Y1Q0dTRsSnl5OUF6VWd2NWFnSklmZm1GeEdHdGRnWEJ4clU4V2Zra0Ixd0dP?=
 =?utf-8?B?RVhIK1E1V0FvV1FUYUFqaUFFVUdxanJRVW40bzkybGt4YlQxVkMxSlVqSzND?=
 =?utf-8?B?R1ZlME9sUFcxT2FER0pZQklWVy9Hb1huVEIvMDAya1YwZGxvWTNPcWJLY1VE?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfeb4c08-2986-4224-ac68-08dbb43f392b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 09:53:04.0079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbx+j9QdTCsYsV7X6EyiMuOgfwVFcdHRYiD5DZqWG5v0+sGs4kA8c5FNPOVeVv2SYGW9NQddHyQ5H31kUw9cS9g2CE99Ysz3NrmPi8qDH3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9053
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 9/13/23 10:56, Cyril Hrubis wrote:
> Hi!
> As usuall we are supposed the release LTP at the end of the month. In
> order to get at least two weeks of pre-release testing I would like to
> freeze the git starting next week. I will try to review and merge as
> much as possible till the end of this week. If there is anything that
> you think should go into the release let me know so that I can have a
> look.
>
It would be nice to push mqns_03/mqns_04 since they have been already 
reviewed by Petr Vorel.
In this way we can finally remove libclone library from LTP containers 
testing suite.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
