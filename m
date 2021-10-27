Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25E7C433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 02:59:05 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26EA96103B
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 02:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 26EA96103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49CB23C6867
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 04:59:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 272973C644A
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 04:58:52 +0200 (CEST)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 322D46009F0
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 04:58:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1635303529; x=1666839529;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=t0TMNbzqQ6hmOAuvco/BZH4SCnrIcTTaqIUjxQbw76U=;
 b=xvO1cXzkygKyaarbsmtWKqCbnhuk7yzKx1hB7ym9JiE4QpfTF00/7TB/
 yHtoAK01Km+J5qtmUHymNHq/C4iq1pMSq1/7rL/jF8EZOFvw8XuvBIZ4u
 R0G2PzK7U5H5uXh1MooJnGvSHC2H4qmErjek3o+FqX4eaSY3Z58Wq9sl5
 daerKKMpoY24MfyzuWwgwpGdsUiEY1IcdWgPEBuTfW9xeIdjhrbkF55qp
 hDcjodXx3NmYUZfj8Xas5jgHkc17Hrfw5y0jL3BvUXdbNc+Nh8FdjHwkY
 /7ETjWxKOzlRgb8Gcb/DKgTI/rlLPNX+Ugdzrm8rSS4OjfkOqOcftwHu/ g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="41956241"
X-IronPort-AV: E=Sophos;i="5.87,184,1631545200"; d="scan'208";a="41956241"
Received: from mail-ty1jpn01lp2055.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.55])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2021 11:58:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ow3l4UwIjg3ilndkPzgnKuYfefKZGRZpuaje5Ty9HovVWO+i8v9t6AyI9xruA5Wy/Kq+pEYtQkvrFWICgPtjhQHtGq3eSGpwNYOftWQXEbDAGB+CiSngTIDoMuoe9nTwMQRnpos6fkqsvrumkrYsmRV/Am8FQsHRe+YNHfHaro4JxA5FySvoR4CjnHR7x0U89b+9vfC+ISdwRV0eOqo32kjLqPrci1jobUfoHA+vYe7Hd8SHnA7hSvSZlds05873Iswsk39pT+sdAKQeGvLgv/MEMsUgJtNSpJuszDSZ+RZ5SKCm8sAcNVUJAVHeIFJ4CiuqGmoxYOUy0BU4feeISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0TMNbzqQ6hmOAuvco/BZH4SCnrIcTTaqIUjxQbw76U=;
 b=VW3H9gy64XTSTpcvWrrHtZfeG6BBG8e10j6i9nzHhU+UY+ryqmssoGoLcRjHnVR9ZU1vwRHnnRkDI0KQluYHU13dD4NooUZFnP5ZbHjmoUQZq2S9vFNuNbG0DP4khwPp0yH4c0MSaciIdEbkSL/yDuvEZssqBlcpVpQ/Pr2+0OPf2xOVQEYxvcTPkHRZEEh63GZO0dmtp3TtVw7XTle26pOyWWP9MVnGfEFrLwH0pk/t5liFC+4si3N7e60WRCK7szugNOQ9CpXHzTneLD3+TtVksEuU/cz6IBNb8S0R0HoSfYkBTDmfoXdWBSsMc8wPDcbIBzIit1y+4xbKh4p2/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0TMNbzqQ6hmOAuvco/BZH4SCnrIcTTaqIUjxQbw76U=;
 b=g80LgFU45ChA/Co9kyqcxRI0QtS1q/2fBXM1833OpTMYf+ThvJgXuo+rCqmsU0BGAtCqUJhcanMOVQJnv1r1g+FKA9sKnQl0KKpAzKsONime9rdO+4E4Gcz8surcC/+nX9GamGMFHNQyFC5FH0iBS95Q4RtqoDaDz+Sl7EXKzRI=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB2682.jpnprd01.prod.outlook.com (2603:1096:404:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 02:58:43 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9%7]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 02:58:43 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v1 06/11] lapi/quotactl.h: Add fallback for
 quotactl_fd
Thread-Index: AQHXxCIugzcg2lbM/EWg89x6g0S6x6vlXyEAgADVuYA=
Date: Wed, 27 Oct 2021 02:58:43 +0000
Message-ID: <6178C067.2080208@fujitsu.com>
References: <1634562888-5987-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YXgNHp6K/7CqyumH@yuki>
In-Reply-To: <YXgNHp6K/7CqyumH@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd51aafb-fff4-4dce-978d-08d998f5b01d
x-ms-traffictypediagnostic: TY2PR01MB2682:
x-microsoft-antispam-prvs: <TY2PR01MB2682CC91801F4B99310E42FCFD859@TY2PR01MB2682.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3AtyEGB7670sLVWRAqMAoz3He7P67zL1vDQ/YNjIAC4z9Ib4bVV20Vo9QSCqY/TaLhHIzHwg7lQLhG0G7xZm2ggN9VozWN19wdyjpwZ7ws5P9C6cAmg5Dz1OPZTNbh34C7ds/UprW13qu4NE1hJQPAvN6BuNOr+lCg/iNddvLftgUVXJGPxOxkusyBe0ZTRfzC83tnZF/BkpBzRUziNqiztqTpW+x5VE5KaWyrLwOumHSPoSKkXSRSuxoALHNi0mA9fM7x/J5NXMDDXAdbfPe4nixj6jAtsyUYZDlCAY5NVbhwhA6+qnFzwc7JuoGqKc7CK3K49pUQbUuKYbTsuH2GXIM5+M6Bh1sWtATGJjGXUCKzL4TwztrLfI1kgIgrPD+JNNJeWa2DqcwACVXYmzMWArHxpvVMDM1RdBoP7RhscXDStKCsmYfuGKLxJo00y+dsFHgkE/Zx2jubxSJ5OSP3pnoFEUihGhLsd0kzH7PW1jJSOMam8Raz5O4An7f7a4YziO3ys0YCGyDp4MLz4Xg/4gikZnU5w2JAdP9Trro3SPcOAgyct3KZM5cIVs8kDHfa7yZ3C/KrI4QfVBhrV6qSZcldS2K7AsPKThWxVwsjQ1um/T91EeowqHCeMv1aiuVY0XOGQ/Lmfpy3rrfJ87r8t0F5PT2BPzmwyhPIsUtfBbkh0Ff79ez49p1RHDiNKPSk3twqYYGN7lwcbUo6vAsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(71200400001)(6486002)(316002)(508600001)(6506007)(85182001)(6512007)(8676002)(66556008)(91956017)(26005)(2616005)(66946007)(66446008)(2906002)(15650500001)(76116006)(87266011)(33656002)(4326008)(5660300002)(66476007)(86362001)(64756008)(122000001)(82960400001)(83380400001)(38100700002)(36756003)(186003)(38070700005)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bDdRMExQNUFxd3pRbGVpbWxOaTArRFFsODM4ZUMrTTVENTRNd0Q0SXlySHd0?=
 =?gb2312?B?Z3hKY0Q1b09TREZGYVk3dmlESGNobTdLNkpFVkdUYVg3TjZrY1kvb0dBNUI3?=
 =?gb2312?B?bHcvS2NUK2dCVjlBcUlzbWFhcFYxVENUWmlGSUhxbHFIMFZsMXpCVVlxTHM4?=
 =?gb2312?B?ZUd6VnBzc0JvblBCOVNtRVhWQmVWMnVKLysyU1ZmM1YxNHVaaFJRYzhhUThT?=
 =?gb2312?B?MjhkNkdjMmFnWFBVZ2FmT2RkcENUbnIxc1YwTVloVGtySnFRNzdiMzBoaERt?=
 =?gb2312?B?S1AzdFhQdnJBOTZNODYyZnpyc25JQk5lMzlGYXJqN1oyN2RQSFhML0hTUHNU?=
 =?gb2312?B?RzdhUVVGTGVMdU9aWHRKNnpiVXFQc3lOd210UFMvbVpjVkNDUDZOVU04Smsz?=
 =?gb2312?B?K29vUU9BTnRsUHpYVXRVbDJlRDYyYThxNm1pTHg1a25XS21uOTVUay9GbEUv?=
 =?gb2312?B?YmRGblR5WlcxSHhmWnlITEY1VUlVTC9OR2lEVEtaN0tRMVppZG9PcHRsSVoy?=
 =?gb2312?B?WXR4bHZtZkI2VVhSdW5QaExXR2IrNUc2MWZNbkZlaDA1ZnluYk5rTzNEaFdH?=
 =?gb2312?B?NExLL2g2M0t6amo0VVJvSzM3dkFIMDUza3NUS0l1NDUzeVJjTEJXYXFET2dX?=
 =?gb2312?B?M0lnYWxzQWtkN2F5TTdIMkRPSG02Z1dHV3V2TDJ4Z3hxOVVzUDUzVk5ZUTUz?=
 =?gb2312?B?VHZTU2VCMjhndHhaZlFubTlhN3JBOHIrMXB0anQzVmRtZkRiSEY3MHRxenRo?=
 =?gb2312?B?djJnUGE4NkRMWnNEamdyeGg2bk4vNUt2N0lINWNmaExVRkt4a2Jka05XUnNQ?=
 =?gb2312?B?WTFHM0dPL25zdFRZZkpIWStoNFFrcXNGcFlWbnNZOHR2SDZEdU5ISkdEeFpy?=
 =?gb2312?B?VFNQU3ZBUWtUTEFkb0JiYmpSTGhsTTRmenRsVUpXRzJmWjhrcVZWRk15VkQ0?=
 =?gb2312?B?clhqbjI5a1JBNkV2bWN1NUxsZlp5aFpQNHNEQjM1WklNWHhnek84UjRhV3FO?=
 =?gb2312?B?Z2JmVlJhRTVtR3pRQjQ0bDN6OGcyc3NxSUpqdFhMMjk4aHY5eE9WNUdSL21C?=
 =?gb2312?B?K1ZCd3BpakpLaGluRjk5SXozVno5dFFtWmNmSnplam9qUFlkQ2VtMTFjNmxQ?=
 =?gb2312?B?c2JJV29KYW5tc0lvUEN0Q2hYUDZVTHBPb2JOajY1ZEwxYzEvWCtUc2xaTU1p?=
 =?gb2312?B?ZGZCWjNaOWwrWEI0RXNmMnBFS2dqYWxkRGlGZmFVTlE2RS9ESTc0MXhoc2Ez?=
 =?gb2312?B?Y1F1dWQrSFdQQ2ErbWFrSU5TNWx2d0ZqZVR6WVlsSnNoM0owWWkyQjdmZWRi?=
 =?gb2312?B?SDFnb1BrS2o5ZkVWcmFWRFMwZXdFeWVLZGhUamJPQmdTSDZHYlBQTjJZY3k4?=
 =?gb2312?B?cXNaa3c0cGhHcmxzTi9GZGFycVlLWkpWajNadDVnTTFkbXd0NFRUV2p5enZt?=
 =?gb2312?B?aVAxVElLTzhpa1JXWEdwM1ZVK1BocThaL3kwSXlGOHVtdnhEUS96SHBPcFhh?=
 =?gb2312?B?dHVrRVpieTI0Z3U2YUNzVTY1aUs2UUtOM01rYXNxN0ZCa216R043dDJUK0hM?=
 =?gb2312?B?TzkrRnhKUVZ4cGVGeHhLc2ROVHpFcysxSXNGSVJ5TVJ5b1JnY3ZGdEtnajlP?=
 =?gb2312?B?M0hHc2V6bWhraHlmNnJOaWMzMUJwNmF4YXkzUGZrWk1HU01jKytMU3JTVDRz?=
 =?gb2312?B?eTBFaUY4RGNtV1JxQVZKOWIraWxhZzZMbitWNzJ4YVhpMzd1RjQ1T3Eyb0I2?=
 =?gb2312?B?UGxMRkEzaGFGNjc5U1d1TUNJYTBiMW9tRVlvVC9JNjFqM0NHdnpPR1BRYVEx?=
 =?gb2312?B?U2pHOFVQRVl2dWcxYmpMN050VUkxelVvNXg2VDJnRUt2QjZqWkJsKzJjd29s?=
 =?gb2312?B?ZlBVU0lySXU4bmVWcEVLMlVmUGNYZWJtQ3puWDBHcTgwVitMWHpuUkUwVkZW?=
 =?gb2312?B?QkZyUkd1WFZNY1hqdnJPblh3NDNrRGUxbXdjSm8yR3ZUOTEzbkdLeGdxMG42?=
 =?gb2312?B?cnZ1dTlsK0pkT0hEcDBwUjhpM3ZVTUpJZGJsa3E4VmZIckRJa1BnMnVDZTRo?=
 =?gb2312?B?bmlNcFBLKy9oemtqMVRBWk1VQUFqdnVzbGdHNzRIbHFWQjNQeGN0azBtcmZX?=
 =?gb2312?B?TFAyZ0gxY2VSampnaUN4Ymc2REd4ZlkvdFVaVlRyVmpnbFkxR0dRc3JzQXRZ?=
 =?gb2312?B?WDI2OHNRc1hBUU5EdTlnamdKMTc2RGRJdURidUVpblFnK0xERVlkODZWbzN0?=
 =?gb2312?Q?eRjbqMO05lNj8gMQN5mdzJMJIHwjQSzHxBpsnYvqPs=3D?=
Content-ID: <A5282E82E996644098D5C714D4110233@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd51aafb-fff4-4dce-978d-08d998f5b01d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 02:58:43.7968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3HmJ7I+kWRW2qV8z/i3TKtBTqmGFARSw1zE3iUDYgxOGT4INPz+kGQ0WYB8Adkmf2fwNf6cfJRXPtoj5dDTbMWt047AbjhjL2eifbwOTZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2682
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 06/11] lapi/quotactl.h: Add fallback for
 quotactl_fd
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

Hi Cyril
> Hi!
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>> ---
>>   configure.ac                                    |  1 +
>>   include/lapi/quotactl.h                         | 16 +++++++++++++++-
>>   testcases/kernel/syscalls/quotactl/quotactl01.c |  2 +-
>>   testcases/kernel/syscalls/quotactl/quotactl04.c |  2 +-
>>   testcases/kernel/syscalls/quotactl/quotactl07.c |  2 +-
>>   5 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 5bf3c52ec..859aa9857 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -122,6 +122,7 @@ AC_CHECK_FUNCS_ONCE([ \
>>       profil \
>>       pwritev \
>>       pwritev2 \
>> +    quotactl_fd \
>>       rand_r \
>>       readlinkat \
>>       recvmmsg \
>> diff --git a/include/lapi/quotactl.h b/include/lapi/quotactl.h
>> index 348b70b58..e265a6708 100644
>> --- a/include/lapi/quotactl.h
>> +++ b/include/lapi/quotactl.h
>> @@ -1,6 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>> - * Copyright (c) 2017-2019 Fujitsu Ltd.
>> + * Copyright (c) 2017-2021 FUJITSU LIMITED. All rights reserved
>>    * Author: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>    * Author: Yang Xu<xuyang2018.jy@cn.jujitsu.com>
>>    */
>> @@ -9,6 +9,20 @@
>>   #define LAPI_QUOTACTL_H__
>>
>>   #include<sys/quota.h>
>> +#include "lapi/syscalls.h"
>> +
>> +static inline void quotactl_fd_supported(void)
>> +{
>> +	/* allow the tests to fail early */
>> +	tst_syscall(__NR_quotactl_fd);
>> +}
>> +
>> +#ifndef HAVE_QUOTACTL_FD
>> +static inline int quotactl_fd(int fd, int cmd, int id, caddr_t addr)
>> +{
>> +	return tst_syscall(__NR_quotactl_fd, fd, cmd, id, addr);
>> +}
>> +#endif
>>
>>   #ifdef HAVE_STRUCT_IF_NEXTDQBLK
>>   # include<linux/quota.h>
>> diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
>> index 4b791a03a..469c47437 100644
>> --- a/testcases/kernel/syscalls/quotactl/quotactl01.c
>> +++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
>> @@ -63,8 +63,8 @@
>>   #include<string.h>
>>   #include<unistd.h>
>>   #include<stdio.h>
>> -#include "lapi/quotactl.h"
>>   #include "tst_test.h"
>> +#include "lapi/quotactl.h"
>>
>>   #define USRPATH MNTPOINT "/aquota.user"
>>   #define GRPPATH MNTPOINT "/aquota.group"
>> diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
>> index ca6a94263..e01657de5 100644
>> --- a/testcases/kernel/syscalls/quotactl/quotactl04.c
>> +++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
>> @@ -41,9 +41,9 @@
>>   #include<sys/stat.h>
>>   #include<sys/mount.h>
>>   #include "config.h"
>> +#include "tst_test.h"
>>   #include "lapi/quotactl.h"
>>   #include "tst_safe_stdio.h"
>> -#include "tst_test.h"
>>
>>   #define FMTID QFMT_VFS_V1
>>   #define MNTPOINT	"mntpoint"
>> diff --git a/testcases/kernel/syscalls/quotactl/quotactl07.c b/testcases/kernel/syscalls/quotactl/quotactl07.c
>> index a55416f0e..f745e9b1c 100644
>> --- a/testcases/kernel/syscalls/quotactl/quotactl07.c
>> +++ b/testcases/kernel/syscalls/quotactl/quotactl07.c
>> @@ -16,8 +16,8 @@
>>   #include<unistd.h>
>>   #include<stdio.h>
>>   #include<sys/quota.h>
>> -#include "lapi/quotactl.h"
>>   #include "tst_test.h"
>> +#include "lapi/quotactl.h"
>>
>>   #ifdef HAVE_XFS_XQM_H
>>   # include<xfs/xqm.h>
>
> Unless it breaks compilation the part that shuffles the headers should
> go in a separate patch. Or at least it should have been described in the
> patch commit message...
Will add it in commit message.

Best Regards
Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
