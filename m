Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68117C46CA1
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 12:11:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F59F3CE4C8
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 14:11:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87B933C0B8E
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 14:11:04 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DDA49200D12
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 14:11:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9BuZTt4V+mLJPbhXohuS0+2gVCa92fIjO3sgG4X43BXNdHOJ33z5RAqx0v+CN+vOJoDAma3DGL4/85xVfi2Yrz2IlML4gbW1yeoErGPQ+cqCU+m6s01z06RrYBhD7pwq+KK02Kqey0VyY9JngF5JHNjXaC7rnuS5zPdQPfPJqdST5tUbqOzeXtYh2rWD/8zRhoPKZuSNiTFv37VL/GEtx4h7Kf9STiSA0zJZ4MV7Smzc89Ky52VSPkjcS9vDvzf39p6FpRmZU9vETkYs9U9rnbx0AJGtmArg5LqLBtfg7KgCsruwRFyAI5yOeUj+L+0XIsWtjBDJd7wUn27l7umKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTKlI0XjhWmKY6m0iK8ksSSdt8Q1l1RYFscMy9FZW1A=;
 b=cRnPWU86MXvwoqA5uhhvsgwXfgGZq7Hbn72/hjRUwv6LBw1aLitrM5eQXUZAanr3s940jNu42CZXZwI8fGjSOo0FP2e/4xamq1AllRapn7NmgxmJ926ow+7hJLcVM5nYqRK5fw3+O06e6p6nz+Ut+YEhrertb9dEhvB8CZwit74wiWBTgFmZU+Oelg5wxTfrfn5pQfME4BeOI8RcTDXEaTaDGtztTVFFAZ0GT/mZaxS8JZ6JEOWA6Tx3C1tNLQbhC+iufRAc+W/WysgBMNEuv1pQXNIUcEvu+Vn2HUv8u8VGgdryui6uh/iYJ63OCicRP4xtCdcaMJ9NLq63bSiKcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTKlI0XjhWmKY6m0iK8ksSSdt8Q1l1RYFscMy9FZW1A=;
 b=Oaxs8GY6Wq6ncH3mUnGhHs9KTZmSy41yTMgpQhK4bJ6q2UPoXdIbFg6RWmVRRq7idM+XGOGU3irX83BJ443+E/WKz6YjMUuubh3z54fC2AgHMrIGCd6GOnGzxAdWys/FXBjSfMSJ95JT24fBUKxZ6RaIafii6/8cEPI3j5V2im0aBz+DFP49+u0aH4bXGIFUlhAIBtlaJ0W42XaRfmoccj3lVqrVdvJvYTm9dz2Q+RX8F6HS4liOVXNZodhdGJt464EtinDCVXCfdd71u9EXxfCKmisAckurQzRuTHVA+vunKp9YAKGeryjfaMCfDteTqXlaIX1uOE6ZinPqY7rPKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PAXPR04MB9138.eurprd04.prod.outlook.com (2603:10a6:102:22d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 12:10:59 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 12:10:59 +0000
Message-ID: <b7647ec0-d046-44d4-a951-893c0ecf02c1@suse.com>
Date: Mon, 18 Sep 2023 14:10:58 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20230918110737.1922-1-andrea.cervesato@suse.de>
 <20230918110737.1922-2-andrea.cervesato@suse.de>
 <20230918113947.GA4279@pevik>
In-Reply-To: <20230918113947.GA4279@pevik>
X-ClientProxiedBy: FR2P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::9) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PAXPR04MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a73fbd6-bf77-4de0-3517-08dbb84051d5
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FiNcT7YYyuFtzgZpBAtEAsQgPmULypmB12lBYzn0DgKYTJ6y901LejyPUYNW7stwmHFu8XUqrvRYXdWk5LJBWhZF3doaoSE1TLunGQZCNU4MHxU1bT/kYhSFpWWkofjF29CFVEC8bI4NtJcI+j7x24fjs8pG4Wbnd1fe/NCgX+6M8Q6cPGqNlCDMSLE/rzz8xzbJuACV/nMQ8n2Q7b0g7slcs/q3CJE/2AiLrXlNV3A4iuj2KX3mwjQb9Pd/TwNimwekuhdICgVRcaCq/vGlgwtNp0OKWdvJbRVB4sKuJmHCjcJIRYSfg64QGWIUHrkxt5lPZ/1gHWZ8cGP3kScS7ce/HN33Edw0Y3Mt7OqDK4/S3c5Qnl2wsVFRgu+mjWmLmVWqpJp+DC42JGAVqM78an4DJNnnrrPos1jFOsswUhNqew84IyMkAMVbZH5ugBsOPmkZCbNNAsZ9DYcXfn4dCXux4RpzLaJhexHVPhxqrAMIXCVINmn4CPJyTG2QOfK6A5Yv96F3Sb1cs9dgGNkXdlsIBIO61evgR8B6UHBEGIlLPIX6JeoRoYJl0uCyrl+YCaTK+uIbTq/F9i1YtULUlRBH3Fse818RTOX54K0+9s10w1B6vZUj/TCx2W18vEojmzLO4tVTIJc3HPr2ALc7og==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199024)(1800799009)(186009)(2906002)(5660300002)(44832011)(26005)(66556008)(41300700001)(316002)(54906003)(66476007)(66946007)(110136005)(4744005)(478600001)(8936002)(4326008)(8676002)(966005)(31686004)(6486002)(6506007)(53546011)(6512007)(2616005)(36756003)(38100700002)(31696002)(86362001)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0N4N0E3TWt4b0Z5VGF3RFpXSXBtY3dHZDBWeHJQaVRKNVdFY0toRXVhTzhh?=
 =?utf-8?B?SFZFSmJDM0VrMFREY282d3pGbStEWFo0Q3lqNzkySzJDT0NyNnJoOFhKTUUv?=
 =?utf-8?B?Um1PemVnaDhuUEIveGREa2FKd1dEbHRQT2pTeTFHbEhJeDk4WUFPNVRQeGJX?=
 =?utf-8?B?cmNreFpuWXNhcWp5aXB6VEZ1L210NlJXaEtiUEFvYURQdlJZRGhQdlZmejVN?=
 =?utf-8?B?MTdZQm5rTWN5R01ZeFVmTDFzTGd5VngrOUVtUmhSdzk1SjRIRlR3NFJsK0Ji?=
 =?utf-8?B?bkRnMWgrNXhuZGlIZG1RTEFodmNSbkFma2c1TFlXZm5uQ2ErdzhmZW9pemUy?=
 =?utf-8?B?dWUyVGkydktSYVBHell1VjhObWdwYXFBbTBCS2NqUnRvMEV6RXZJRit2QWtx?=
 =?utf-8?B?S0ozVWJYTU43a25CNTcyTVQ3RjBCbWdIT1FhN1FtbnlKUzVxZjByN1FZdTgv?=
 =?utf-8?B?QkxPWTJ2UU44QXM1U2V2Uy9PNjNKeStRbkdTVjJCK3FyNWt2dkZocVZwUEVz?=
 =?utf-8?B?SFh3Y3JyT0I3RitVVlBseVZ1c0tqL2NUaDVhcTN3Qm8wUHZlZm8xb2YyVHQr?=
 =?utf-8?B?UUVYZ2ZYZmhWOWVXczE3MlZuelE4UjhhQjFXeElwT1R3N2dxUlFWd0FPd00y?=
 =?utf-8?B?TEUvTHZMTjBlRWU2d1BMYWl4UDZwSTlvR2hmd2ZnakhiSW5IT2JvRnMxcUhj?=
 =?utf-8?B?d0dWb3V6TWluZEFPaTNKa0lVZ0NaSllNWnN1eXJUZ1pCQVNsdTJJN3BpZ3Vp?=
 =?utf-8?B?eEcvMll4NXNhWnpiYVdiZ1F1NnV4SVlqV0RvL1NaNU55SFc5RVdaNUNGKzE0?=
 =?utf-8?B?Q2t6RGMwT0FMNXZQLzZHZ1F4aVdwMlhIcXZDcnAzdWdQQkdNTUx6UW1PWTlj?=
 =?utf-8?B?VzJsUFA3NGVrWHlzQk9ibnRHeXhSaGtJelZJOUwvUS83dnlSV3ZjaFJpZVZG?=
 =?utf-8?B?d0NMRzBlTEFWd0tJL0ZnbWVPVFNPVVYyMFJ4MFhrVHRTK2UySkREWU5uR2VG?=
 =?utf-8?B?eXVuTURpWHF0ZEZhUHYzMk40cGxxM0VBSS9MVE9sa0JwQlhYUUZxSVg5bW9Y?=
 =?utf-8?B?Mlg5ZmFWdVRrZVo4WUlmK3pES3hjNE42aDZqNlpacmVkWUI5UktMNWNtdHBv?=
 =?utf-8?B?aGdJZ1dkUFlaMkdQVGxOb0tTMkcrOGdud1BodUs5bGIzMUl5bEl1RlF3eVEx?=
 =?utf-8?B?V3VBOVNaQUVWR282WkJUUzhyY2ZwNFlpbldnRnU2d05TMnlPTm1HZlY5cUt4?=
 =?utf-8?B?UzdhRGJKK25GejdtbW45cmt3ZG5DZlBSQ1Q2bmFyMkxBcldzTkxLZE43U1F6?=
 =?utf-8?B?b2lROGJwQldBTHpXYWJRc0lQNDRJRFc5c1l5Q3k1WU1zaTRORmpwWHdzUVZT?=
 =?utf-8?B?VXVtZERva1BIMTRJSEgvdEdtM0p6SGVMVHM2TkFrcS9MNFM2WkU3KzMwajM2?=
 =?utf-8?B?WnBvZy96b1BGcVpKK3ZhdDFDN2kzUmJPaWM3b29MaGdCaGkxZU0rZXM0MmJF?=
 =?utf-8?B?WitFKzhLMjVuYmN4RzhUdjRRVktvaFdJUHFvSE9EblBqc2JWc0J5andCMTQw?=
 =?utf-8?B?Z0w3enhSeFp3dmNpVS9jK3ExdUxnV2NOYmhPSGlGY09sRlYxVnZsaDRvcURl?=
 =?utf-8?B?UXZOUWc0a3h3TG9vNk9aOGwzWXR1U0M5SEFIMEt3aUJPUmJjZjJ2WHEwTzlZ?=
 =?utf-8?B?SUNTOTJrazZIanRzckZMSUdDVUVPSU5aSmhkYU5Ub01jZGtCMG0ra1pmVGJk?=
 =?utf-8?B?ZFBhSUdmNkwwWUFMdDhJR3pYRzZhTnA5dzRCWTlHVDdJSXdkUzdXcHpEMy9F?=
 =?utf-8?B?ZFBuMDI2MTFKMmZXSGJhY2Y2azh5THJuOENVTmxHNTlWVm9MWU1BVjc5NEU4?=
 =?utf-8?B?dnczK1JCWDBEY056dFJUTDVCWE42bnprTVlOVXBaSGp3bkRyVmZSVnF4UzZC?=
 =?utf-8?B?Z3RoK1Fuc0FNUlBqQ3VzaW5SNXU1MEF2SkwvZFBFSnFSeXJSeHdRQXQ3NEdX?=
 =?utf-8?B?NHdtdmt4dVFvWTIreEVKaE0vWWJLRWYvRHlTQjRPNTNLTmVaOEdDaUJQNzA3?=
 =?utf-8?B?MWF2c0VKNlNJNzl0OHljUGlrUUphb3B5RGQ4UGFjdHJHNnVSTzluRTJHb2NK?=
 =?utf-8?B?c3BjNHhzRWVORlVoL2pKZjcrNk0zVWVEOVh5TnBvdk9DMThuV2xoS3RSQktS?=
 =?utf-8?B?YXc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a73fbd6-bf77-4de0-3517-08dbb84051d5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 12:10:59.5136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oo75JRWFNGU+lr3U00sd/gXbBwEs/XzAj8felR3m8znKLIfhWVL31NXlbSDFow8o2fpfy4RxqbIUtvG4gc7DBnA7s6z+lyjZUqs1CGXNcnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9138
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/2] Replace runltp-ng with kirk framework
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
I fixed and sent v6.

Andrea

On 9/18/23 13:39, Petr Vorel wrote:
> Hi Andrea, Cyril,
>
> I dared to send yet another fix for kirk Makefile:
> https://patchwork.ozlabs.org/project/ltp/patch/20230918113524.17908-1-pvorel@suse.cz/
>
> kirk should remain as the original file, runltp-ng is the link name.
>
> If you agree with it, I'll merge the fix to kirk repo and update the git has in
> this patch.
>
> Kind regards,
> Petr



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
