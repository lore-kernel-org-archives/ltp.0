Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98266C35274
	for <ltp@archiver.kernel.org>; Tue, 19 Dec 2023 02:07:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60FE93CF33F
	for <ltp@archiver.kernel.org>; Tue, 19 Dec 2023 03:07:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47BA93C8191
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 03:07:23 +0100 (CET)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D61056000F5
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 03:07:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1702951642; x=1734487642;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=458w3iLV0StgYztuOzDUKxoPoLPCEV7rkpiMqbPtauA=;
 b=mRr0q2gHcuBM97XHI1nsQ2Ere9yetxklckEMb/1iJSyJlMwHyFjQ0UYN
 jcM45WwGio5PGb+v4CvvTnpdZa9DyH8lvU9NZMthSHsjOg7wAPMDx5G0B
 aoWh4DMsEphLrfcTxp3LCGoR81emSPgevFEuJrwv7LCIUJytbgLdiYmTj
 vUce/Ab40HT2jjjMx5d3TbEqJEhWL/TcyqlPD8Y1TyeDClUDLFhdAddxZ
 /IUMJlTIcGFx98cQYMKzDgXUoKEeCdT8irtjBVB6UFcF5L/L8ggfidau9
 b/iIwdZXJj1arePebYD2TRP2CfXGtgWXn51nT1dMy2sR9twevRg6kQtAA w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="106116273"
X-IronPort-AV: E=Sophos;i="6.04,287,1695654000"; d="scan'208";a="106116273"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2023 11:07:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLyjlTDJ9M8KWxxveTrQkq8LTjkTj9/gZXpdBaU04lRgtI7jC4HWZyTCFTqAj1kZBqehsDJXsB7jcWlqcO4OOzChJi+kslD7WXHTuCAmUowt6t21P7WAINvVaDezGk5iM4/RnA/in1JQCfwX0pd4nYzofv0WpDB2/Y69ggwRlRzoe9xvz7MzEkxXKUKoY2htv4YHF0uqvDmHZWWcJMTj12TdXI+bpSkDV1RXl2+T0f+nA8KuGhzBj24xn2IhJn2RiZDdyKsTXKnxqLjq/LlYbSsfNPhFSxio4cbyH5L3MfQcbQRXkcm+hDwXLOZ53qfH0h5Na3DxEK4DW5uDfs07vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=458w3iLV0StgYztuOzDUKxoPoLPCEV7rkpiMqbPtauA=;
 b=E+X0dXHkWg28dxJKeSuEerz6puONXNCfyW+604XUVXw6VGuy4WL6EynL2zPTB2zJpG4HoAed3OtUV/wEUSLJRIXmqn1ddyMR3oiNRjGO2+lgvi0mdHqJBeAt/8Vrix5n0DeVT/oBfU08yTSvUIaKxC0o0CXP+bhszIbCC+yIqGbci+vCpa0SYCikIGopzFg7UbCzn4XU8eC7729Z6hqCCh+E6M9gIFA21ebeUGUuHkrbSyf+3jgnfEpJqSK0wXbb/q2yA8na/NtfNlWiJSs9AQg6ec1Q0f1uLVqAEde2r5CqCt3swJXyGyDJUwrZtz1PGVTN5tHhdtL2A4ByMx/xwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by OSZPR01MB6213.jpnprd01.prod.outlook.com (2603:1096:604:eb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.15; Tue, 19 Dec
 2023 02:07:14 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::6f9:cd05:b0e5:6601]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::6f9:cd05:b0e5:6601%7]) with mapi id 15.20.7113.010; Tue, 19 Dec 2023
 02:07:14 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "pvorel@suse.cz" <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 2/2] gettimeofday02: Convert docs to docparse
Thread-Index: AQHaMYqAf+lNIshJT0WgyowctjYunbCu/SEAgADf84A=
Date: Tue, 19 Dec 2023 02:07:14 +0000
Message-ID: <fa93277c-050a-4cf3-8cb9-4513366ae782@fujitsu.com>
References: <20231218062129.130236-1-xuyang2018.jy@fujitsu.com>
 <20231218062129.130236-2-xuyang2018.jy@fujitsu.com>
 <20231218124540.GA197798@pevik>
In-Reply-To: <20231218124540.GA197798@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|OSZPR01MB6213:EE_
x-ms-office365-filtering-correlation-id: 5611260d-6a33-4bdf-a2c5-08dc0037381f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iRphcNIS1JShszhzado8qTSM1gxsrntqHSIQS4TUWZKfSTBGo2IBujDbyHNyAU5wcXOPD6flMub7niMm2TxKdNS2sCq7xiduPUN+w4+Dcytk/aemQX1nu8H02DhmBm3WzbKBjJ5bWh/alwEsnWA10ihbDWR4yK5QtCMSlWotYCKadqZVKSQ6kKRIIUE+RNdZ+hJw2glM3/jL8IcGxwXEAAA6x4z9o6vtXmM4IbVeASBe7at5Bw++rd59Lt5p6oMPKlisiyPy2WV1z+73S6eus4WX9FOfBOuLfeLJSMTbzFaObCtB/qb01pL2/Xf7WnRuGFfB+6Y6M/ldanpioc+W44q0IaqqhPoOIMk7+px0g18nJt9WkVaalHBCKM3X+RFKKuoWUcTAWT1pdrEboDYx8Bpch/xi1JYwVG9yv99SVuiyLUa4ACixFjHyMgreYH2wve3uEMCxKvoD+mK/WGC+YWgKUDILzMh8C2tihsymeuYpjQXjeQ2RiNrbquGPwHeNo7Rc8t7/FLI0W+VmvoA+B1K0TK229jRskSRcRBhDK3DVgUJkKA5xhmbMK3TjWxIFSbPe/f7VXhTM2RkNIlw4n0M1NxgDQdTGJ5/dLCUwyLkJsgi4HNW+39cESdNCDK8Mu1eAaOBGPcW/TDHPnsr/sVCWO/2w3TGCXre+EbYbG3fduxu/lzQTf8O6kRAiV0+S
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(39860400002)(376002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(1590799021)(186009)(1580799018)(36756003)(85182001)(38070700009)(316002)(6916009)(83380400001)(66946007)(66446008)(91956017)(64756008)(54906003)(66556008)(76116006)(66476007)(2906002)(122000001)(4326008)(8676002)(8936002)(71200400001)(6512007)(5660300002)(38100700002)(26005)(478600001)(2616005)(31686004)(6486002)(31696002)(86362001)(41300700001)(82960400001)(6506007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFpzbThmYVNJQ0ZUMlFQWUcxaVRTZTFjb1NoRXl6SG1PcmlqNGlBME1CcHUy?=
 =?utf-8?B?ZlovaUZsaHRLWkFqRExYR3RheFRPMnJjS1h0a1pEa1BNdDRnV2cxR1JVNzJo?=
 =?utf-8?B?QXZwTW5EbWFIY0ZtOUNSS2RnRXFlR0hCdUhlYjB0TjBIM1htdTRYK1NFZTRn?=
 =?utf-8?B?cktCMk5NZVVwWmZRM1N2a2J0SFZiZzJsekxwbThwZURJckxkZkIxVHFwdmU4?=
 =?utf-8?B?UlFtQWhTU2hXdzNLYlJOWXVvQ0g5RWRUbUYweWRud2w3SFFSalU0Y2tZWjRn?=
 =?utf-8?B?TFdoVmpDN2dQTk5pMWw1QkZjQXlua0ZFWng0SC9va2pGOS9HakpYQjEwSGN4?=
 =?utf-8?B?MERNTVdFQ2ttRk9JVEVJQ1J5TGVHQkF1QW9DMFFpbFlQbUpvdmJJOG9OMDNY?=
 =?utf-8?B?L2pWMXI4aUxqK245QTh2SUpzcFY5TTd0Q1kxQWhMaE5tT1k4OTdIQ0tjelhW?=
 =?utf-8?B?ejRPZkJyQnVyb2dBQjdQYXNZMGtCSmoyYnJ4K1NTZG1DdVVMMVlLSFprRGZT?=
 =?utf-8?B?VVFzeHduVnZ1T012cVAwaGdSS01yN0QvRHM0NzVaUFRKN0VMOHk4enN3Wkl6?=
 =?utf-8?B?K0ZsOWd3S2hBR2t0WmtjU01UcXMxVEdueXFBdHZMVUsrbzNmRDNUVkswZTZU?=
 =?utf-8?B?VkVuMTNOL3dodVE0Z0NhQ0FxVlZSOGh5RU5XUm5HbXU2MC9pMEpoL3cxT3Ev?=
 =?utf-8?B?ekFmdXYwMHNDR0RZWkhWaXdURlo3MHlBV3lCYU9ndUJqV0liN2lHWEwvUnMv?=
 =?utf-8?B?Y2Y0U2tsLzBLNW1FUWtQbWZ4OTlWN0F4TXNMeC94YXdVcC8yL053Z0xiZmdV?=
 =?utf-8?B?SlZoTTA1TG1wUDdKREhUWTFtOGFFQkFZZVY5RzV0QnBHbk9sNjBqWnRBMFpE?=
 =?utf-8?B?aG0rRWRaRFIrR05pbENWRzJhUUlCblJpRzlJdENRM25aYjhsRUFtejU4VkxH?=
 =?utf-8?B?NkVnV0IrKzVBejdYOFBQSkU1NTJ3dys2QjZUMUZMUjBtYThTTDh5TENvY28r?=
 =?utf-8?B?LzNaRm1qWGdvNWRpWnM5SzA3Q2JDL2NVU1ZtZ1pGMHl6UDl6UllBNGRFYmQy?=
 =?utf-8?B?eEhuUHJLVGozTjVWWXhkV3lzYzdLZ2VyLzc5b3dEQVZ5eDJzSjZQQWQ2RlNL?=
 =?utf-8?B?Y2NEaDhBUUhLSkx2bEdERS9WRTI0c2JsZGtZd1FBOFRBWmZoalFvTmtCTFlU?=
 =?utf-8?B?Wko0RmxiU0M2UzVob3dCS0ZCY1pTR3Fxa0wrcFpmZndHenlPZFFHQ09jS21s?=
 =?utf-8?B?ZzdvTlhRRU9JOE9jWmY0ZUcxek8zUTZCKzk1THcvTHlSUHA1YXIwblE4anpo?=
 =?utf-8?B?d3Npbzd5d1VVRnRwZ0pITmpnU0xNSnFRQVhiTjJtSythM2pJZVk5b3orM29o?=
 =?utf-8?B?dmY4bzcxbjc0ZEFSR2EwQmNrRVlmVUJ1VGNVUUZ1eEFOeGM0RXFqa01WSEVj?=
 =?utf-8?B?a2NSSjNVQm5LRDFPbThNc1hqSndneUM4V3hDMXdTQmtZcllkQnpYUFBSSlBE?=
 =?utf-8?B?anYxRHVVZjFPYisweEhuR0pEVkx3K1ZjaTlzaFNrRUZaRnk3SE1hRG5SMmt1?=
 =?utf-8?B?alZRby9VaSs5a1RmNEY3eDF2a2hFZ2ZoY1plM2FIZkVUKzVTMytlRFRnNkFh?=
 =?utf-8?B?Y1JJV3JoYVdQakNTb1RCaWpPWnZwSFlHVHp0Q3k0eFBwZXp1NUpITFFnTWRj?=
 =?utf-8?B?ZWREb2NSSFVEZ0pxN2c1ZXptYkpJM0VheC9PM0xBQWZ1bkdWaEtCMmZQaEhO?=
 =?utf-8?B?RDFiWWkwYjU4SWQwdGpYaEZjeldSMGpmOFdZZFg3RVlvdDFBcEJKT0QvOVFp?=
 =?utf-8?B?dlZISE9lRHVXQk40MGJRWFAxWDlUMC80UXFyMGlDQ2ltZStaTHhlN3N0LytZ?=
 =?utf-8?B?czFPOXpaNHFkU1dVZWtyMVdFTTFYcVpRV1ltMDJ3bEJOQ2ZtRUlDMmIzcERV?=
 =?utf-8?B?cXkzd25mRFFUenNkVEFWME05UDl3aHJYZjdpQmV5d2FpbHhHRlVFZjdaa0xT?=
 =?utf-8?B?a1E3L0o3Rmd3Y2VzRE55enYvVlZuZXhXaE1iZkFxdHMydnEvK0k1WWJmSnVx?=
 =?utf-8?B?NnErL1F3czRENCtjTnkyUWRTdUVhakZlUjdCdkxVME0xLzVBanhVaWxvSmpJ?=
 =?utf-8?B?UGNEZWphY2Z6VVQ3U0RBN29IdTdHWUZTQjc5enJjQ3RNdkg0QlNDSjZlZ3dy?=
 =?utf-8?B?V1E9PQ==?=
Content-ID: <D0B442566E85F44B87463ECBC700552F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +wKgzH4LIIQNhd6Eq3HGpSTICgF9GL6VI5C9F4EbCfS3+gb/ZNluBRDWwJsQk7w13w6GiteBBzxjPAlZLQtfjpa81zKms8loOSCbIqX7gKDOFWyQ0yrw6AuO8BR2pafsg1BbdzZm/cILYB4EO6kO1ZoyVc8rEF+iXcLy0rgWfCfXX1YMpJasJvgoecxAU78DYIhiyGYvEH58GDHKxmaR2CDbQ31FlcqDoWMjO8bWayWl2IQzpqV2RA7jYfkjJRhhm9w+wp7xeqJINJ6R+P+BfxvyxE/+B4XrzAuKBaWx3ZMNf3egL56iYpiQVR0ptD6AjpyvSaNXpBUUFF+UaRReunDOZ376n2rvWWlp8lSszaZZ5F1r7Gv+z684WY6QjaYuHQT2Rof2LmYSGuap52zs3HHZoTATMe9DAw9cnqwvHMLJxG7G5vf91/CkYvT6n2dIsN1Pr6wBj8qYNIfT5FqKed42Akhd/KB7uvozI2q+trUo2Wm9KnZDuC2z69fjjfdx6PeNst8cYKBI64fxuEd/x7DMhlNuQweVuMQme4ctQogoR5Akm/MnMfuwKgLL9lRiqyCaaJrCs0ZXUmfvMNl7iuzISiodGBS9Kiduf3kt/XkgfAmldiMFfbdxTIAD49y3
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5611260d-6a33-4bdf-a2c5-08dc0037381f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 02:07:14.4407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1FqwNNsllanhyXorTRxh3ZwGZ3bN3YNy1Q1EVv+8LFBnbt238xB5IeMQ5U9uo3ubTUKjDX2zA44qcNEHtjk08R7RfEfP2Fb9pNhrcRmlxHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6213
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] gettimeofday02: Convert docs to docparse
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   testcases/kernel/syscalls/gettimeofday/gettimeofday02.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
>> diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
>> index 7c462cc29..fcd027df5 100644
>> --- a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
>> +++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
>> @@ -4,13 +4,12 @@
>>    * Copyright (C) 2017 Cyril Hrubis <chrubis@suse.cz>
>>    */
> 
>> -/*
>> +/*\
>>    * DESCRIPTION
> FYI this needs to be [Description] to have unified formatting in generated docs
> (bold). I fixed it together with gettimeofday01.c.
> 

Thanks, I will pay attention next time.

Best Regards
Yang Xu

> Kind regards,
> Petr
> 
>> - *	Check if gettimeofday is monotonous
>> + * Check if gettimeofday is monotonous during 10s
>>    *
>> - * ALGORITHM
>> - *	Call gettimeofday() to get a t1 (fist value)
>> - *	call it again to get t2, see if t2 < t1, set t2 = t1, repeat for 10 sec
>> + * - Call gettimeofday() to get a t1 (fist value)
>> + * - Call it again to get t2, see if t2 < t1, set t2 = t1, repeat for 10 sec
>>    */
> 
>>   #include <stdint.h>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
