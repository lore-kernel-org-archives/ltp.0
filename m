Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84718C4332F
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 03:05:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 012243CBB53
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 04:05:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9951B3C8C27
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 04:04:47 +0100 (CET)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7EEBE1400267
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 04:04:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1671419087; x=1702955087;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=cqFg6Sn5bGccslPROEHBdrk2zBW3+ObaI0Fv60na4+c=;
 b=P0FC1jooC4TQ7FE0mPyzNC9uW8htkdtuhDbP/bEhFRud6eG/xlPYl/N8
 UMC+d+KtIHmRlqosBIG9AJmSwxv0eZOmqaflcwTelFwNMZ0pw3CBhfeUP
 ku8bAxI60W3ZfPsCbnhv0J04xIf1cXRhLpN2APqwZ7/glHAN2nL40B3tw
 1TxfovNnvQWA47WOW7hO2TTtz+5vUnox6KnfGpePirV16WNY/Q8kj8S4y
 znu0taKcTHeNr15G/+y2AkPeJ76F4ztHmuvqTfKGvlTBrpkQpsvnFi+kA
 1DJMx87I0/xRHRVZca9P6ktiOIZ//6Li1WCmwEoKbLZBQh0pFeePoZzbw A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="74731591"
X-IronPort-AV: E=Sophos;i="5.96,254,1665414000"; d="scan'208";a="74731591"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2022 12:04:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPioIqCNAuyoQGI+m9ymNBGZFvui30au1fT9gcITEt6YEKMD6Sa6JDZolyjvI5MKUF27jAQBUpXuw7fnm+KYI1SCQ0/ZInepvJFVl0aPBM2zySWT+LknRwtMk2BZRrjq2UzfMK/A+E7eMoG+UUxAqV9w+gAQX9mf8Ai8/s27V67hUlp5fVOWyb7nR9gp07WRcPMKgDvfwYtPNlcoblkMABsOvNydSuNpHAFN9NuL6uOJkpS4Larpj2mbVlHEHaNdvtdlVDUem7moyNNOsW0vnms7xfy199pJcwV/jObQ/IAsxQXdeVLyKg/Lo7ICLtUjbV0IYt8Lg9241KCw++xtlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqFg6Sn5bGccslPROEHBdrk2zBW3+ObaI0Fv60na4+c=;
 b=bGsrwd4Q06ONX+ap4nCT7jABJjdky434ipFoLnvKy9o16LgtdaUz/8tUNaifItWMmSPBIQAAOCbl2MgaeeY4Mil6g8alroHs6kdn0wPARWpeHCchqIb9CuSysmfPctmYEK/+vUnJ5IVtAy+P6hnRz9bDXhRh71y8QquYTBBBkosetWXOWZOch2TzYNL8BpMBTLN2JmyVrE02tCWS0SIjVd6I6vDW/7MCAdss2vXMRbdJXYN13lDqVlZUg9nMJIkPPo7O9Cm/Z9PCvieRqNxhZDjYjbIWpy1MYpDOLnj8y6Q6QJqv/HxylnoaPG2VSoq0Natw8D5iTw0jZulDZZMHQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TYCPR01MB10085.jpnprd01.prod.outlook.com (2603:1096:400:1ea::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 03:04:39 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%8]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 03:04:39 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [RFC PATCH 2/2] doc: Document used C standard
Thread-Index: AQHZETNAGOFgabfDVEW0gYucrvVYJq50nAYA
Date: Mon, 19 Dec 2022 03:04:38 +0000
Message-ID: <25c87018-67d6-df2a-fe88-8cecb33547f9@fujitsu.com>
References: <20221216094611.2924-1-pvorel@suse.cz>
 <20221216094611.2924-3-pvorel@suse.cz>
In-Reply-To: <20221216094611.2924-3-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TYCPR01MB10085:EE_
x-ms-office365-filtering-correlation-id: 69dab459-8665-4004-b6c4-08dae16dc479
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: icdKOvI1Syvh67wO5K18i5zaSyhQ+sClR2UV/utLZALzUvyu2gwsswfWNSFCuMfJBLeRJJC9VE1sfsODOKcAB3mfuQb+z/gGKzSXKFx9cqhmZfpcBLEdin2E74I8Y+PkFb0ivJkt7QAuQIIzt8sd2LdKCgWBtZvMcJRlYnkhT+8T17sOjGOLPGfdii4ifPLTHQ1tLnK1IQeSnSOs8mmsd2d2BdHqYav4aaysOl3k9gLWkE+SXCKH5UGjc/J/S4+v+dEHzuxcnVoVKzzUl8FkUTp7fU4ZDC/MVO3n+rNZOsMYiQwOY55Jwe1xQ1wkDO5c2/JjvJL0nrmJmIAzSlsTHKiQ+F/PNMshnQjsVQYm5Q+FgP8dtY9hpICj1ihg58cJsD+kjlpDuvwL/0WFhf1JSq/v7hKhSjH2/SUA/4VErtmdfZnt9pageuu6Egm8xz3jnjKTQzJWRSplGKCeENy/zazME4uOahvPqSXmuoDmCXiWKt4jwJEbzMN/Vit2wM60fEGAuiAS2GSSZhfw3p2m01HieCSCZYy0ENZjRr0/5uYM0KKAhiWYN+38dg+FCBzi+zuf/7g8YEuE3MI/YIQyJWdNYSSpn2cMta+E2d1UD7P9yYl0Ete51Lq9ZzhRyEvqS5uz82BsUKuEFd69yZLtij/R2Fcdplfi1pVke/E7tlxkM8z85Nzhedqbwrdsc0AISR7x14qL41aI4zA3AY8vxDmqaAHnL68B/zTS7UXsyS/T0VZvIf2Y6HwaJ1q2P9qBwoBR+lT0iMWkWWxvXtZm9BTyLpAYy+5Fgx22sYvOwbo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199015)(1590799012)(8936002)(41300700001)(186003)(6512007)(54906003)(110136005)(316002)(2616005)(91956017)(76116006)(85182001)(36756003)(66946007)(8676002)(4326008)(64756008)(66446008)(86362001)(31696002)(38070700005)(38100700002)(82960400001)(122000001)(83380400001)(4744005)(7416002)(66476007)(5660300002)(66556008)(2906002)(966005)(6486002)(478600001)(71200400001)(6506007)(31686004)(1580799009)(26005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjBmSTdyQ1ZWWFMvdFF3NGhJaUI3Z2ppWmlWS0k3dXlEc1Fwd2ZSakJRTitu?=
 =?utf-8?B?MXJ6OUE4UkNKYlU2UHB2YzRmQkJYSTJ0N0Y4UFFZdXRILzRZYUNWTFQ0MlI3?=
 =?utf-8?B?QWQ1SFl4ZjFKNlh2N21IWVV2aVVxYzZSV0IxSWhuTjV0MWpYT2g3bmZBOGtN?=
 =?utf-8?B?eG00R0RUazhHRWpHYUZ1VE5MQmlORi9iYytWNFlKRlFIWUNDbkwvYnpyWkVP?=
 =?utf-8?B?cFMwbktvaUxDWW9pSzZ4S0hiK3hWOHNheEpreHdUbFlOWFJpaUxEQVErcWxX?=
 =?utf-8?B?aTlTVDYxc2xNQW1QZmRPNTcwRS9TUGRvazArWGNaQStOMjhQRW1qbGFDQUZz?=
 =?utf-8?B?M1lKOWlNMmVOM28zMkF3V3BZRmdPSmgvM2V3cTE1dTZ5L1RNTGZoeGNJdDZE?=
 =?utf-8?B?UG5CbzFwcTlwWWJUemV6TWVOMjQyUzVIaFFTNmNnTTdkWmJhTGpmaDhPQlRK?=
 =?utf-8?B?WGF5TnFpcm1kNnhlclprdFBXeW5pbGRPOGZCMFRuSk9VMkdCU0dmU0xkNFUw?=
 =?utf-8?B?V2ExdjZuaXdQeGhrcEhTZEZvN2haMlZMM3NSdmFGc2M4bVY2NnI1eE5LeElZ?=
 =?utf-8?B?ZUVYUUJrN1g3WmpDNmpzT2RhZjZ4V0lSTkNLK1ZGUmx2dURTSng2NnFSOGpM?=
 =?utf-8?B?NTU4TVg2U0FFdHJrdHMwandmNkhuWGNoVTFFNEozaHNXUCtFWGdzMmtEWEtU?=
 =?utf-8?B?UWdCTzdOdmY5dlRSL1EyV1Mvek1BY0hiNmhHNzRoVTV0UDNzY3YxZ20vWGhP?=
 =?utf-8?B?cURnQVQyaHlEUk5kWXB3cWZHRmY1OEYycW83bFE3MWZZQ3FURTRjYWFQdWoz?=
 =?utf-8?B?Qkl3MitOUHE5cVczc0RhMS82R0d6WnVVZ2JBZU1PdnJ2RXRKMVk1UmxoYjd0?=
 =?utf-8?B?eGpPeUxwMk1OalR3RFRoSEJOc2d0YzBSNHJCOW5iTXNPU0UzRFZqWDdhOTJL?=
 =?utf-8?B?NVV1NU9xMHV1ak1jMXpxRkZiNkNtY0pIZmljMUg2bmxwWUJrcnUvMkRkdTIr?=
 =?utf-8?B?WCt5UFQ5cS9iNkpsN0NSejUzVWZmS0xTUUFHdk1xNG9yK1h1d3N6VHorZTFt?=
 =?utf-8?B?WXZ3RGVOTXl3azM4YXJxUktnQ3JUU2ZVVXJTNm1nMGMyWmVUSGZkVTRla2ls?=
 =?utf-8?B?WWVQN1VkN3Y1MGJyM0JobFA4WFQyTEt3Vmtjc0wvb2RKT29Ca20zZy90a1Zx?=
 =?utf-8?B?b3pPZ3UrSW5OWWhIY25ubVZadWtLOExHS3hCZCt1YkZMZFBmaTFiS1lNY3RR?=
 =?utf-8?B?dTlNNUVFRXBUaEI3UWxxUFA1aTE2am5qL2pVeko1RHdQVWtJNDAvRUxiVVFl?=
 =?utf-8?B?TEJ6WEppNnNvcUFldDZpaERJT05vZCtUVG85akNCY1k1c1ZuQ0wwaGMxMVFj?=
 =?utf-8?B?clBYOXJLYm1wVVRjUzNjeXFhckpLMENZTWRna3Y1c3BZamh6cTE5UVRzMlNO?=
 =?utf-8?B?WE9RMVdmZDJYM3RyQlhlWS96TW5qL2pFSkNPVHRlYzhkR090L1JCTTNKL3Bq?=
 =?utf-8?B?LzFORGhiMW9RKzYvUXd5Zjg0YlZBZXpwRFNxc1c3ZEhGcXo1OEl5enczeCtD?=
 =?utf-8?B?WGhrNVI3c1U1YlpGdGZnT2pkMWZWS1FMRnVZcUNaS05WOWY4VEgrMDhuZS94?=
 =?utf-8?B?em9FM3VmeGV4bUtNdlRBVmF1blhOZGM4Vzl1SUhuS2ZQVHo1VWxsVFI3Njhq?=
 =?utf-8?B?cXFxTS9zK24xK3NIanFCMWJZYnhYenNKV2RqUWxEOHMvV3pxWEtsQkJUa0M2?=
 =?utf-8?B?R0dkTnNmU1A0bCtWQXlYNVpVTWNqOWk3L1ZZU1kzZXFudEZxNU1ZczFOTWZK?=
 =?utf-8?B?bC8yb0hwcUNpTjA5YUJZUWFkaWZlNVFMb0Q0VWlZNHo3WTV4WGROTmVSdUhy?=
 =?utf-8?B?dGJiSU56ajZpVnJBNGF2S3J5TXNmazZTUjFzdFcrY2NrckJQYjh6T0V1MWNs?=
 =?utf-8?B?MjRvQzNlTjdXOUlxSGQvOHZ3UkE3QVRVNFNnc1hjRGNGWUNMMnBWVWprckdS?=
 =?utf-8?B?bFA3ZHVGYlNuMkdSNDYvUitZY3NET1h4bGI5eHlRZ1RZL0NzRzdLbDEwcnJW?=
 =?utf-8?B?QnlqeWYwSHRjVDhUMjBmdzUyd1Q4cG43dk00UjR3RUE4ZFZHMkJrTzFweThl?=
 =?utf-8?B?eGJOa0cxY1hOTS9YajBGZDN6U1Q0M2F0V2NQZE1QMVVyQ3VXbVBrK2hEekdr?=
 =?utf-8?B?R1E9PQ==?=
Content-ID: <37DDA82D6E07DD4DA0540A819B4F9D9B@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69dab459-8665-4004-b6c4-08dae16dc479
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 03:04:38.9716 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ueAHGYMLwMYdFVJu+xWLCSdhjA8efCz+oLF3P0LClMQx3WIxRFZHigctxdHjJ2Y6DUiW7rNFvGgsGaFgdjfzyDoL+36FJU5K2d+W0SsJdqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10085
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/2] doc: Document used C standard
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 =?utf-8?B?SmFuIEzDvGJiZQ==?= <jlu@pengutronix.de>,
 Khem Raj <raj.khem@gmail.com>, Richard Palethorpe <rpalethorpe@suse.com>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

> which was added in dc7be30e25 ("config: Explicitly set gnu99")
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> BTW I guess after CentOS 7 EOL we should raise std.
> 
>   doc/supported-kernel-libc-versions.txt | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/doc/supported-kernel-libc-versions.txt b/doc/supported-kernel-libc-versions.txt
> index f89c4882fb..b5f12962b2 100644
> --- a/doc/supported-kernel-libc-versions.txt
> +++ b/doc/supported-kernel-libc-versions.txt
> @@ -70,3 +70,8 @@ Minimal supported (although untested) kernel version is 3.0.
>                                    for list of files which need to be deleted in order to compile under musl).
>   | binder (Android) | Please use https://android.googlesource.com/platform/external/ltp/[AOSP fork].
>   |==================================
> +
> +1.5 Used C standard
> +~~~~~~~~~~~~~~~~~~~
> +
> +LTP now compiles with '-std=gnu99'.

For this patchset, You can add
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
