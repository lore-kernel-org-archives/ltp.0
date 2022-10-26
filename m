Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8902DC38A2D
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 14:47:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 480C53C0294
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 16:47:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 217AB3C0294
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 16:47:28 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60089.outbound.protection.outlook.com [40.107.6.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 22630200B60
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 16:47:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZ5y12QjVXhWHHm6y//ji2PoJLJM6RfF3iKtJl0VzSBXoepLHAUI+2y0Vx3Vl4l7g7kOtRKfv0SNSRfp0NMCSUIIj6LNlGisoB+GnIv1EqqymZNr+6jG3mUcZyiz6TIyJcdlg0xvwIrh7jbLNDP0ixrciRtHV885HwOPPxl3pGuH3ZhXirghWqnLlX8B+zV+LSIBvYqkWbPrDoR/G6r0xNmXdjaUCL/sV2gg5g266srVJ4paohcSbE1WQj1iSw9m2SG6MgDYVB4iLOVfgVzpK+jc6im7s6KRMGafxF8dGdPf7hFOTvBeUKenkWjhv7MVZBY4LEiPmQoGUA43R9BznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vg+mkvTp4hYB2Nyu4BkcZCSb0gFxoRkRyqQx8OAC0C8=;
 b=npoVzjVt/ewQnLM3q+cPWJBAhH3mCVE2P8XSCvnI07E+qXsHgBlfthg5s17B7RECl84qsGI0tITFx3lADE80tdNN1mGN06IK8OQi02SN+InQnW/KCsNUb+/Ryhfd3I+AgUeGdFMr90Wu7IdwoBqc9oHFq0VCL3CCAyHF/UbXEJ56K5MCn50Cg/2QzO4urut+0W2wZwLt9Zwt9vKv8Cs6f1Znd9YU/Sc6IwJNglCBrNMCfVCZUlaqVLvyRAfuMjLCP7Ow+8vHIICL7MXjdtumw1dXBh71OtrfIMKHK9EIY9cErVMRutYiK87vXVYSSJ8HqsJ3YvBZMhGDVDPT5Lo8cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vg+mkvTp4hYB2Nyu4BkcZCSb0gFxoRkRyqQx8OAC0C8=;
 b=AgO4bsNdwJ43SJD3tAac60no/ykh0LjORGWtUKu4aToYGxyihu6Bwm5zb0bRUP/yhPh1I7Wx8/abw97su2CXT1ttD0knEM4lB80SYamB7xsth+RZDWusExI7SKhkcCIkt5TyOzKogKu6v/RUKlwxaQiOtro5GoEBu5XegNhwMC2SOj1wXK1Kvf3G/iyn60JejwvhceHJ61VLtlz6bSukQN0quqVNXzuxSFM/gHPIgvUXXVdEjQ5rJyll0afvDhk3rHMERBbgqHuuMT6yi0iWKNMxiYF0Fd2ZjYIax4Gk6qwBVFJ95rv3f/QL2pFon2UalEZnUDYPPxUriJHOKIDi7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PR3PR04MB7273.eurprd04.prod.outlook.com (2603:10a6:102:89::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 26 Oct
 2022 14:47:26 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::252e:5914:3caf:6257]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::252e:5914:3caf:6257%4]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 14:47:25 +0000
Message-ID: <e62c7918-5935-e359-37d0-b52fb4af9fda@suse.com>
Date: Wed, 26 Oct 2022 16:46:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20221024140753.11867-1-andrea.cervesato@suse.com>
 <Y1k6e+xzBxbcJ+Rh@yuki>
In-Reply-To: <Y1k6e+xzBxbcJ+Rh@yuki>
X-ClientProxiedBy: AM5PR0301CA0004.eurprd03.prod.outlook.com
 (2603:10a6:206:14::17) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PR3PR04MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e576e0-3340-4a25-3be3-08dab760ff5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrs2k9GUT6iuosbbTladjTEVHBfReFobkupTzWyuzd1KAZnG9edJQUIzb8u5SWKzP8qx98P1xjvWh2LD/HuVOIK8fUmIO9FusTPOV6+HAkwLw23k6qxVF2SW1b9KxSFE9DuyLkmR5DDXALLVierASNW3PVhtgA79mf5uGK6Tded7sQX8qK9uH8mVefLSa8RVxW+OhD1sIAIHxkS63qEJJztZMWr1e53Hb+PXROA4JYQeZPNOP7mu0Z74DZgN21Dk/iOU/Yt/yI04ynRC37q+e+7/i+Vx5ZhiiRxUPYZmI+UMOF1fwbKnmsJ+P24Eoidc3Ck+cRLSyI3oLDsOIqjcFpIBiyrQ+kITujxz4DODMUEZtyzRj0+9tjkW37gkdqY8zUQO/FQpJcWUJce+Pw9CVVHFW6sBuBAhu8JJgMj/1FUU/Ph2PUiud+i0EqOvdlqIlRuE35wRALUF2w7pptMXvsrvPbU+ZUpDGyOmFV/8NkrOcOF+Fudc1to+MsP9GIn7A/ZobJbF3EF6I6sNvf4WqzJl5O8KzDCC3rXT+T6+E/nLUpBE74DKvTPt2os9029zcw2k2TW0yxxbS4IHXAbdvUZlpCRglPk++U9rVPm4uo9fa3FKSgclz43elciTZoSirtyz7tYZgcR7xiBWzWEHbEee5Da7KJHoylEsrEB3mEwEsJOdKIxswpg9FcjFDdGqIHl5113j/eo9XgKIbW+L7sWBlVbae4gU5hqvA6Tg7NAzEHWHB4RO3Yu1C3HGejtEnMYyZIu4MqgxlHQNX0/ANmvhCi1EWFIrk5jQ9Ui2ZA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(86362001)(6506007)(36756003)(41300700001)(4326008)(53546011)(26005)(8676002)(6512007)(66476007)(2616005)(5660300002)(4744005)(66946007)(6486002)(44832011)(8936002)(6666004)(66556008)(478600001)(6916009)(316002)(31696002)(38100700002)(186003)(83380400001)(31686004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUM2LzNWZTdtQ00zd2tNeDFWVGJhZklLOVh5bDZyUHpacGJrUy96OG9LUGFy?=
 =?utf-8?B?WXZRVnN3YVAwZjhuYnMreEpQVkdvUFhxKzhTaHFTZjMyb2pkUW1Fem81dll2?=
 =?utf-8?B?dkFuczNqZ2prUHNZNzIxL3N4MnVxS0lpa0toWVpONEE0emtlWXhnOVdGcmhy?=
 =?utf-8?B?NmJaWER3SjJoM212am1OTXlKKzB5c25LTlh5a0FHYUpRSmxSZ0hZSXRYYUVG?=
 =?utf-8?B?WjZXMnRpSGQyeFBYQWZVcTNVaS8wcDYwcTB5S1hjSUFwMkFzQ3pMUi84Mmlm?=
 =?utf-8?B?V1hxeWE3cmNyZzNtV1FFYVVNa3VtSmIweEVWeEhTRHVTOXBoNTI4TDZTV1I2?=
 =?utf-8?B?OEZvaEZ6eDhqQnR5dkdjNldMbzQ2YnhSSXc3alZIYW1raUlpMXFiVno3R01m?=
 =?utf-8?B?VUYyZG9JdUhaL0tJRzdYZFNWbTBZWi82QjBqdG9kM2VkcXBqeVVwZ2JXMGx2?=
 =?utf-8?B?anROSDlCL2ROZTE3bDhGL3doYUZRc0VGMGxJd09XYVJLU0Q4czFhc0tPNmJr?=
 =?utf-8?B?Q3VFbkw3NmVxcGl5RHFBSENib2xjY1Q1NzQ2TnpjNTREdUJUVnZKR1JKaGh3?=
 =?utf-8?B?U2FHQ3RCMzZjNHJ1R0daK3grMDIwU3IwNmpXcFl5cW84WHlRZnBKa2EvZDha?=
 =?utf-8?B?Q2ViT0tGcWtJdndMaElFYlUrTEdjWUlqRFVRR0hQRW5uMnd5SVNlMGYvbklR?=
 =?utf-8?B?dG41T1ZoM1QrRXQ0WnRaUnV2VDRycHZ6SHZEQXZoY3g5YktEcnJyWHJCOFdq?=
 =?utf-8?B?ZUNrZjNLSVE2cWZsb01CR3hhK21oQVV1bktpMVhmVDZhc1hQYlVoYU55TTNW?=
 =?utf-8?B?eVZwdmV4RzdwTkozUDMrUVJZV2hrc3ZWQ2NGeEFxSk9pd2xYdlZESXhOM3N4?=
 =?utf-8?B?aFRJaERmZGxaTjdIWFhQL0g1VmUyVURtWHV4cGhEb0VjUTVlbnFseVN3S0ti?=
 =?utf-8?B?Y2ZzVVhoTTQvKzc1VDR2WlBzWVFCeVZ2SWhObVh6amVQRDV0cjNwYlBrSy9H?=
 =?utf-8?B?NzFkVXhWTjRYNjZlSXZaUnFxbk85a0JHMmxzTmQ2b2UxaEk5TWtmWjMySThX?=
 =?utf-8?B?ckp2cjRiYWJyQXE4YVhidmQ0cCt2K2l1L056WkZFOExHUm1LSzJycndiVXlM?=
 =?utf-8?B?VWcvbDYvMnNaWHBDdXd6SXJTTkFMdTdZL0tnaUIraHp2Uk5DdTViU2pnRUov?=
 =?utf-8?B?My9lYUttUCtPRWNnUFJhSTZWZUI1MFFMZDNHbHVGSGgwajNDcTdMWmxVcmcv?=
 =?utf-8?B?YSszcFFmZ2JRSXhmZXMraVRMblhibzZKVDNmdENQMVFMSEJLejNWalE0TmtN?=
 =?utf-8?B?UkdqZ01OczdxTCtPTnFSOVArQmk1VTd0ZEFXN0lEK204MDEzWDJmSy9wY0xX?=
 =?utf-8?B?R3I1SVZiWXFYRGFrZ2IrVVRlZFM2N3dqMDRDUnIyWmVnNjdrKzJ1L2FPNC9E?=
 =?utf-8?B?dUZlNDViSnAwVDQ3YWFiUCtFSHBReFpuQVFaWTBIT2FaUXljWGlyWThZOEcw?=
 =?utf-8?B?bVhRcmdLdk9vdmo0UFBrVGF0NDkwQVdGMGdVRjdXcWlFSGlwcXA0ZlIzdTZU?=
 =?utf-8?B?RmNJUjM1dHV4aHpTT1lNVzd3cnNQamVNcWt2MGZ6ejlKWmhZSGpmZFI2Q1U0?=
 =?utf-8?B?UmYrZUZNSDRZb0YrMU03d2xSMlk5Z0E3SkYxTTFid0xMb2Q1eFlpeHA4M1ln?=
 =?utf-8?B?VkJSSTJDTHJJdzNNSWpHZkljNDlXaXJyb2ZDeWF3SU5mbHpOYlhLdDBvOFNj?=
 =?utf-8?B?K0hma0NWb2h0eEE0eDZna1VnQmtaYkYvb3gzQm5kQ21GSXNxU1U5alk2c2k0?=
 =?utf-8?B?Yk1IYkpnd3I0QjhtdEloclVLSjRXdDBIRHlFUzlsSFpkMnFnWmdjMWxHRjl2?=
 =?utf-8?B?TzgrZ05laC93dzJvNThmZWI2cll1Q2ZpVUxEVkg0VUdqRWdwejBXaGlxbVBO?=
 =?utf-8?B?YjZISDV2dE92YzNTOW8rSVpiTzMrYUMvRUY4YXVKRXp6c0xwMk05NTUydXRT?=
 =?utf-8?B?ZHlMcVRrNVExSGczQys1Rnl2Q25sNVhtdkM4SzhybFJGN0hZdXdxRWVzS0R4?=
 =?utf-8?B?OHI5NlpsRGp6Z3lGTHNXQ3RZdis0a3BrelVKVkJOOE5EUGtBN3hNaExvSitN?=
 =?utf-8?B?TENwYnZZaHZTbkY5YWR6c1J3VzYwaFpuRHp1dWh4R29CYnh6UDEvOTZqWk43?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e576e0-3340-4a25-3be3-08dab760ff5b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 14:47:25.6990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBIYq2hzlTtRTNFCSnNfS0Exoi50FRRgzjt+2k6g5zbYsOVDxPoBAndRe8vDCsdy7x8p5Yc1PnZoyiCWfOiDs+lF1YuQZ8PGsBWY91DdQJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7273
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9] Refactor aiocp using new LTP API
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 10/26/22 15:47, Cyril Hrubis wrote:
> Hi!
>> Now test rounds filesize to the next multiple of AIO block size.
>> TCONF when AIO block size is not multiple of drive block size.
> With that we can do a small cleanup and just divide the filesize with
> the aio_blksize in the async_run().
>
> I can fix that before pushing if you agree, the rest looks good to me
> now.

Yes thanks :-)


Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
