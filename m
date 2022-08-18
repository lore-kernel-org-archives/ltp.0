Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E218C00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 09:55:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5284F3CA179
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 11:55:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7943B3CA179
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 11:55:46 +0200 (CEST)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 955496002CE
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 11:55:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660816546; x=1692352546;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=+xUzo7FyX7YInjCnaeGUX5HXJxiFo6jGDILJVtbnttE=;
 b=J+RPxaWS9fVi0Yf+WVfDXfO3QwW0NXZbexEJ5mBVHaUaS1wogDfejwFV
 CQjDu+0S4Ww48ySE8xSazNXKXP/IxB6hO2Q00IduMVsOV/0g42O6Miqt7
 gmPhB4auWOl9LCmHkr/CPHY/9ORUMoq3J6IoXcpH5Id5ruVxSj8FfWa9R
 W2BwmpethIdBF2Y/GP9PE5Ks5EenJyMg58ke6VqTmpDz8VozzA0DKaiom
 mhxL+iEQxS1I56z/Ejkd+5iCPAax9ejxx9o+o/xo9oQ2WEnUuaNWO1iOY
 eeVBiuA5dPAEnTlxjYDclbYt/tkrO7z0bk0n/igvpxs08bNbzBA1DGqa7 g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="63095382"
X-IronPort-AV: E=Sophos;i="5.93,246,1654527600"; d="scan'208";a="63095382"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2022 18:55:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1RtMfhCTyxxvQWO6PzDY7yFLgttcVj/XNac8SLVXurr1vOcBsR5fw6vUmT5ZKTvcysonFcFgedXXRBrbWRMV3AF29pFh3cnB1WPPhrcrp03Yzd3HSv/EomoD4emPoquFxgM1EAyhLgiHoCtrnwSkvDinfrWGMfQiXTAwB04bPc5mSj7Gy6JzAK+rbjaeN5ZsG0uWJpALkUzcKRCsOvs25uXFjn9Slpth3OiEU3fBdrmOTyAawsq9xQR+CCfR6WyHwGrtCWdjSCKktqXcQBfUakcu2O2TrGenKd9Mg1OCINdoMDAWaMUnSzM8+lPza4AtmqkxIzMZzduVFjPiqcjXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xUzo7FyX7YInjCnaeGUX5HXJxiFo6jGDILJVtbnttE=;
 b=SYoqTIln3xzb8iHCQGlWaMnfAd/FyOVrRJPmoDqTPZHFOuYz/1My+NICO+75ilUjN0wo9CNg/Wk0wbIsHIm6agUwfp1V1mcBbm5ZmMNJJpI9wkHTrqCLQQGtOk2rm/67o3av0i1fD67xnW6pvsHsa3JtE5PyerlZxe0HUGw3Xdc8kAgQuk1tLAKzJa71UKbwjx7ect3hYYrclGaa8CbuORZgzWXp7+EloDoEhwv12rSQ/4zUR1TfOMtVUCrgbKu3z/P6NzmJq5ZSazOUAk0N1ojdpSai37c8yXDJknfeVZll3FGoQWVRnmGubAcVdDaP6sgXI7XdhFFd185475zwaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYWPR01MB9630.jpnprd01.prod.outlook.com (2603:1096:400:1a0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 18 Aug
 2022 09:55:40 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.028; Thu, 18 Aug 2022
 09:55:40 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] statx04: mask STATX_ATTR_COMPRESSED on tmpfs
Thread-Index: AQHYsugEsOPPQviSUUOa8dSXUayWhK20fIuA
Date: Thu, 18 Aug 2022 09:55:40 +0000
Message-ID: <da253a0e-d082-9329-3392-aacee81e6c8d@fujitsu.com>
References: <20220818095030.1964355-1-liwang@redhat.com>
In-Reply-To: <20220818095030.1964355-1-liwang@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 484dbb08-9ee8-4c27-41c3-08da80ffcef1
x-ms-traffictypediagnostic: TYWPR01MB9630:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S1kby6SM1EHKHzBZp77slUXp2jF/X9rPmQscmraSHghJ5+2Xs+M/TUAAd4rktDK1P3ULXnl6LIX69XP88wK/v0/5KB2WzEmeQYt2kvTvVDLp7dPIygRWivY92XbopKpiTYyTy3hhrQqhLAi4Bsncfxb2p8Rw1JWTjRSnsPSUiOzbs49077Ttz+N5H5+Bb5XAwI1uUHYFlOBpYkhPwfLTCRQ/f8VdPbU+69I6h/RP34mYCwRpjBpkOi4WYaCgewE2LPCR6rfvUzcXpejns9g8BwD/ez3/haZ1Bs+PHscKuZZ2yLgM5rNgFP4xeUCJXWIAB0MWhWQI2FFG3XkM2cdrHidcrAv0dj7qPmeHegSxLsE+tGzSjWKPTuCX1G+yQjzcYOPaFS5UyvFXD/SmGXDSYFfSs9H+pV5XML/UgPXFareLr6LE6fR290XloCxaa2MRRF4Dy6LP2b7cqv4OBvMGMwTvQ1e4R3SBa9H5Evn6RQqaJw1wgu8xmPKXPkQD7iOILqrW/pPpLqKpdp6/GT6CaMjbdr4PD6dtusR24ySEKuTOUptzqnAGgaxs8Ehb8oHxg5GeRGDtgmaylzY5fch7F0+Q8FEOVZxgxF4sy19MJWuaVXDlONexdSh9LYz+7vA/BmQC9xOk8enZfmvAaGnLIsEXuahgURR11r97wbOxlGQq35YCUaq/+id/tgGsEhnQDpgvXp82G+k9fIM5lKCtT7wyqUZ6Etx6rlBAvIJ9VULz+ZhXwa0lklweVps7OsCnIWlqfwbIer258jX1kn9O/VE9Lif73gpE16rYfJgZA6/T9E8RSHpbg/kurKfrwSRpq/XpvfZw6IlxZynIirjFhVk8lBZjY5GpjO5QkZYZvMc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(2906002)(64756008)(8676002)(91956017)(76116006)(316002)(110136005)(66556008)(66476007)(5660300002)(66446008)(38100700002)(122000001)(8936002)(82960400001)(66946007)(6506007)(1580799003)(31686004)(31696002)(85182001)(38070700005)(186003)(478600001)(6486002)(36756003)(71200400001)(83380400001)(86362001)(41300700001)(2616005)(26005)(6512007)(17423001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0xUeVhCK0tmVFY2QVNFVjlLYVJobDgzSWtjSWtJTmI3WG9aazE0TDlJSm40?=
 =?utf-8?B?K0lJN051Uk50VmFCdEhBdStsSzRPZXZMT2tNM01sL3Q3aEw4WUZnS0FOMEFM?=
 =?utf-8?B?OWFxTld5U21sRURQeVFwTDgvcEVVN2NKWVNGaS9GNVdnb21lZlByOXh4UStl?=
 =?utf-8?B?eUpURjR1UFF0OUtjTTlINTZYT0RDR3VpSVVnM2xWUnNqbllYYlhTV0gwaDdZ?=
 =?utf-8?B?THhlMCtTR3g2UTRvNWZSa3VjaFZldVYzalBEUHZRM3pMdDFwdUhwQXJZc3ZQ?=
 =?utf-8?B?U21QOXorc0sxZ08va0Ztc0JxRnBsck5xblNUek1UeG00cjJFb0oyMHVLNmdG?=
 =?utf-8?B?VjhDbzRlYnV2WHdRWDhucHN5ZmZhdTNBc3NrVGZtZ2R1OXV3MzZOSHU3TkdS?=
 =?utf-8?B?azJEZ1locXMxeEtQSzRsanpGZnlvR2NqM01EMllLeElrVWg4dzltN2FJRUJ4?=
 =?utf-8?B?Mjhuajg1djlPc3cvZHEwbFpUR1ZmS1Z3anpPaCtDQ09aZkFlem1FYmxRZ1do?=
 =?utf-8?B?VHlvaGFVbE5NWUxqU2tZSjV4L3lDaCsxN3kvVDRBaXBYaitKSjZHVHpGVTlC?=
 =?utf-8?B?L1Joa25Eb3Y3dEtmK1lWUWg0S0FSK09LQXB5Yy9yaGxMblNmRmdhai9lOEFh?=
 =?utf-8?B?K2RtMkpYN0ltL2l4L3llcjVkMDJsNTFHazNJOTVKK1ROVElIN1JDaHo3NVZz?=
 =?utf-8?B?YzVtTnNnUTRkSjVuRmZiMDNHUGVXN2IyQmZHak1GaTNiTlZyWkY0ZE5uWjZD?=
 =?utf-8?B?SmRTMVR3Vk4yZW9nR0cyWkVDR29mRklvWkluZVV3L25UamV1R0lQQnJGMjJv?=
 =?utf-8?B?Q3RCdUlVQytPK0xWTlJaZE9VcXNkb3FIS3hzWkE0TTQyZWVmTEMzcGttN1pU?=
 =?utf-8?B?SjZVbSthK1plZXpzb3RWbE15dEFZZ3JkR3pHNWJHdkphRDh0aHhINFZ5akkv?=
 =?utf-8?B?eXN5dWZlY1p4aU4wdFdRRGxGUGN6UlBxb3FCOUpOTExMa2hTRFlJMEJDb2hZ?=
 =?utf-8?B?ZzNNSGFTMFhkUldQMDN5YlYwRmtPbGsxb3MyM2htOC9Tdi93MHgyRkszdG1n?=
 =?utf-8?B?bEVROTNCa211REZId0pld0pLaTI2L1ZTSzVyN3YzNWljbnJwQzNScU1VTWpj?=
 =?utf-8?B?NUFoWXNEbDl3NjBMZ1RralVOR1pHSnVCV1NOTVJ3WFgzK1FNYjRIS3BYVEZ4?=
 =?utf-8?B?YXFGS2I2d0M2VXluMkpVQkdsSzhRZXNmWVE3b0RPWjRySWhQeTF0NE93Q294?=
 =?utf-8?B?UUp4a2N1Q1BtQnkrdi9aRTdNcHM4Ukl6dG5zNVRpZHZhRVlQRzErS3RrMUpu?=
 =?utf-8?B?MmlBRDN4Z2poeE1CT09YblYwMmF4UUhFbXlSNG1FVER1OTU2aWFJWlBNK1N6?=
 =?utf-8?B?SmpqdUJ2aFViTm95bVdrTlNTclRZNzVYMUxnWFFmay8zekNnNmQvYkdwVTZR?=
 =?utf-8?B?RXVoaEJFMXp2Y2xCTlNJSjdxUjI1aUIxT1RabXNlay9rT3UwbWFYOCtRL1B5?=
 =?utf-8?B?Y3BkMklUWjNvZWpQSFc3QVZBYkwzaWo2RCtLb1QwQXB0dHRrby9FVXc4eUFM?=
 =?utf-8?B?V2hDK1crZVV3akRpRU9pRUhKQlowZFZ6TERYWHhNMEZqelQvTGgxL2gwQU9V?=
 =?utf-8?B?TFE4ZW5tRStQaXQwMDlBeS94a3VrRWV1Tnc2QWJFZlV4R1AxVWhac3c2bkxm?=
 =?utf-8?B?SndXZTVMQ2ZhcmMvdDRrbEpnTk1wb2pUQ3Z4QkFaSStKeFVDUm1aUEkxbFc2?=
 =?utf-8?B?OEZ4VCtkOEc4d2FhOHlnSTVrQllDYzB4THhnak5DdmROM0MwTkhTeXRrYytx?=
 =?utf-8?B?V3lnOUJ3YzAxZlliaXJQL1lSYWcxbGhLblFuR0lmOWFIa1U5WFJvUnFpS2pU?=
 =?utf-8?B?RzNvbjFpSzBzZ0lObm9lVDhaVmpqSFhQRXMxb05CODhacjJvdFlSK1NEVjBW?=
 =?utf-8?B?eUVyTG82cXJlU2VNeExLT3YreGpWUkFhbUVnMkZYd2lQR3MyaWFiS3dJeW5s?=
 =?utf-8?B?OWgycHYzSjVvMjJiN21rdEZmSzFvU00wVllsWGpzaFlBZURFVU5Jai84TUMx?=
 =?utf-8?B?VTJ0aU9CY3JMQXpMZVJKajN0aWlpSmxSeGZLTHk5MnNSRUFKQ2plWTZZS0cy?=
 =?utf-8?B?SUlLbnNXaERZeEYvSFlDSUZ1cjc3WkdFZ1gyVzZBTjZqQnhCdklNU3QzUEVB?=
 =?utf-8?B?cmc9PQ==?=
Content-ID: <00A270F02EFC0F468AECF05D7E990477@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EghWupso6cE0wCoQ4/tHG/TQWVr4VXrUMrQDspPY/s/2PXaDC1j2LKgTBzxgYitC/XZOl+umMg58hIZNsutlTKZ8DclNXrpwvjinSV/NRd7v8xOdR90q88+EG/xmLJHiY0/89UIZw0lDRVm+xmNsvfvAttl9CSg9C7zoZGx0vAnGgxzFR3hOybRICLcjFI6QbU4Bz3jgRJP5x6Ur0hs1xWpCI077LGg9Vp/f/Lk4lrA5lgo1WSG2gcx5kQqRlWCkcyLCgLLQMPi8N0Z3KYyYY5NWDYvpxTiByGtK1s4NgU9DvLgwP18QAbsMwPk+gkD/XIXddI/aBDKiPU4qX0E1QtosuU73KGngoJl2DsiE6Q72D44LWwuWsT150AkTijZYq1lgkph8ewj3Uf9fPtDUJxFSwKanj/n0Irp+8gTtZASwny1AbPlBr3WTxYwrMOPrQynrNdVz/toaU5siR6H36PA+G+3Mx5pwVkPkDIlycbJjXGY/yIf7rv/7XjwZe0rODl7J7n+cB3v/eu03YoND4x6H3tZmaKoIwW4PCeALMoBCFkKA27P9qu3SMsUxw+4XQedw9CJKWHuB5KukxIoNR6nvM4WwoL3W/OCQQHIZqRdNUilfIJGU3exwDnv7KjRZx36wHp4bVrdTibRSIlnHSoRHMWNrbAClUAyFH7WIWCa0er4ZgloDFYCskYWj3o8T9ZXk70u5r9QJV5md1FMum/KaWmohUk05ih4iTiEKBNZAmVoqVKWt4QWCXdPJqnFn
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 484dbb08-9ee8-4c27-41c3-08da80ffcef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 09:55:40.2654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I/TuwGeWycnET5CeSaBeAaYjmpcT4QvLDRRpMYsVh2fApBr+yc1p4fV+mCgemLUSHNlmZKcjDLG2ENGnutD3hCuUdOsHaa6hxkmILedDteA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9630
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] statx04: mask STATX_ATTR_COMPRESSED on tmpfs
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li

> Recently a new kernel commit (e408e695f) introduces the inode attributes
> being supported in tmpfs, which is like other Linux file systems. But that
> caused statx04 to throw an unsupported error in STATX_ATTR_COMPRESSED.
> 
> This patch help masks it just like what we did for XFS.

Looks good to me,
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu

>
>      tst_test.c:1599: TINFO: Testing on tmpfs
>      tst_test.c:1064: TINFO: Skipping mkfs for TMPFS filesystem
>      tst_test.c:1045: TINFO: Limiting tmpfs size to 32MB
>      statx04.c:114: TFAIL: STATX_ATTR_COMPRESSED not supported
>      statx04.c:112: TPASS: STATX_ATTR_APPEND is supported
>      statx04.c:112: TPASS: STATX_ATTR_IMMUTABLE is supported
>      statx04.c:112: TPASS: STATX_ATTR_NODUMP is supported
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>   testcases/kernel/syscalls/statx/statx04.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
> index 083298310..03d909534 100644
> --- a/testcases/kernel/syscalls/statx/statx04.c
> +++ b/testcases/kernel/syscalls/statx/statx04.c
> @@ -17,7 +17,7 @@
>    * xfs filesystem doesn't support STATX_ATTR_COMPRESSED flag, so we only test
>    * three other flags.
>    *
> - * ext2, ext4, btrfs and xfs support statx syscall since the following commit
> + * ext2, ext4, btrfs, xfs and tmpfs support statx syscall since the following commit
>    *
>    *  commit 93bc420ed41df63a18ae794101f7cbf45226a6ef
>    *  Author: yangerkun <yangerkun@huawei.com>
> @@ -42,6 +42,13 @@
>    *  Date:   Fri Mar 31 18:32:03 2017 +0100
>    *
>    *  xfs: report crtime and attribute flags to statx
> + *
> + *  commit e408e695f5f1f60d784913afc45ff2c387a5aeb8
> + *  Author: Theodore Ts'o <tytso@mit.edu>
> + *  Date:   Thu Jul 14 21:59:12 2022 -0400
> + *
> + *  mm/shmem: support FS_IOC_[SG]ETFLAGS in tmpfs
> + *
>    */
>   
>   #define _GNU_SOURCE
> @@ -88,8 +95,8 @@ static void setup(void)
>   	for (i = 0, expected_mask = 0; i < ARRAY_SIZE(attr_list); i++)
>   		expected_mask |= attr_list[i].attr;
>   
> -	/* STATX_ATTR_COMPRESSED not supported on XFS */
> -	if (!strcmp(tst_device->fs_type, "xfs"))
> +	/* STATX_ATTR_COMPRESSED not supported on XFS, TMPFS */
> +	if (!strcmp(tst_device->fs_type, "xfs") || !strcmp(tst_device->fs_type, "tmpfs"))
>   		expected_mask &= ~STATX_ATTR_COMPRESSED;
>   
>   	/* Attribute support was added to Btrfs statx() in kernel v4.13 */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
