Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C596AC433EF
	for <ltp@archiver.kernel.org>; Sun, 30 Jan 2022 04:04:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 771683C7FEC
	for <ltp@archiver.kernel.org>; Sun, 30 Jan 2022 05:04:14 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A6F43C0F90
 for <ltp@lists.linux.it>; Sun, 30 Jan 2022 05:04:02 +0100 (CET)
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com
 [216.71.158.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C926614002DD
 for <ltp@lists.linux.it>; Sun, 30 Jan 2022 05:04:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1643515442; x=1675051442;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=jn7Ul9xije3EWgFqTxWa/5VXq0g2yDhc+rpk9qVJ2W0=;
 b=oTNHzCiGhb3rYpKXu5itlw4U5S+yIM0ZVwTDroDA71jQPH2inHdPCavW
 SQZJRXdg7YrOixurR0xM3NF1gCjWgCKX7XUDVUBf7GsB5KWpCX+Vz19/e
 hHrFs9UTmeAlfLLIinzTT14HvErruOS2pr4iwUT/xMyAXvj2Wy1nfrUhb
 NqsFyGmfgWZ06FVqgqgdo2fW9R33ii/bawmXGP8IeqGCXGA/Zx48n7sAn
 nc87sAPmgwWZoljIBh0LF9IKnTs0BrKAes7Wz5VlQMP8TBsN/famOgwZD
 0MkIoy2IGwleRfLqbsE3vECNqlmqikwDEKMtRdUP6rY3zU2zXfxVfODxr A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="48624531"
X-IronPort-AV: E=Sophos;i="5.88,327,1635174000"; d="scan'208";a="48624531"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2022 13:03:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+DXGj2DH+FrRvIVx2uMS7K6rJxT2Xrlt0osA0vkk6NwQHW46+cbiO//wXJnoOSaxMtAh2omopukmQxhCS4iwQ7vQooGc30rlNTafrM1do7HcyGqxXIf8XtD7HK9w1qJQXM1EUFw23HnukQYRGitL/dO382Zi45gxacq1c2Afcc/hCru6OREuQ9JzFIwdjU+erBAy+M+ctLW4/+ebdPn90qFwwRP7zUaZYmEEWFIrLH7LOuhYhKwTWIkCU3o6n9kpPX4QS6VOH/osxbYyIAiTRbjkT/cmkSdPqBr5HkMKcJ9Yp1H+6XKzuR1sVekq+uJH4zDVVviJWB4x7k9tdAntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jn7Ul9xije3EWgFqTxWa/5VXq0g2yDhc+rpk9qVJ2W0=;
 b=LLj+Tt4bQbtrvojZsSpXHZYN1UiIJ3htBcqMbn0bLvlF2Rh+o10x9VuiH/bKdPzYRDCfUNGVbESh7zjTD2CypNZC9TqiZCFepUBnudthwvn47WEezkkSt3yr5Eat9+cnURUDAKKOx08LhtFFk9bi3MXp8TevNAgFxYcjAeElqjtloufMc7prGij3bxCTAOegamwKjIZkgTZAGX4FS6hrsheq/HKDWHfxyQqOePjIHquO7U/0gP7C5zC/8apWK2k75t6LS3HSBUORRI9GE9Amh3T4dlvFGDmwEGvtCdp0vsD9F0udMg1IRiQGOQj9tdhg4lJldPWgsncoeehYkG9dMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jn7Ul9xije3EWgFqTxWa/5VXq0g2yDhc+rpk9qVJ2W0=;
 b=gNcwbZnFfQHbSz6gTBUgDh5XMl0VuVCeniAIikSvrHiQ6ZsQIBt2iAnqHuOPXNM0npMio5l147fj0b2u6lhOnhIOVKSbSYkB09mZ+djKRvoDZp3ylHXLvluOjFucoKpShSIEetXOL+HdyhXRY33Hq6aWM/dv4BbJClkKp59lq8Q=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB1650.jpnprd01.prod.outlook.com (2603:1096:603:2d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sun, 30 Jan
 2022 04:03:56 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4930.020; Sun, 30 Jan 2022
 04:03:56 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 0/2] shell API: print environment variables in .h
Thread-Index: AQHYEsRDDMW2rRw7lEy/MHQtwZ9Gyqx693sA
Date: Sun, 30 Jan 2022 04:03:56 +0000
Message-ID: <61F60E5A.8030307@fujitsu.com>
References: <20220126145141.13825-1-pvorel@suse.cz>
In-Reply-To: <20220126145141.13825-1-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5519a0f5-c396-4509-e202-08d9e3a589a9
x-ms-traffictypediagnostic: OSAPR01MB1650:EE_
x-microsoft-antispam-prvs: <OSAPR01MB1650DF58A4C741D3E24F78BCFD249@OSAPR01MB1650.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uy1DseTdGI68xM++frf4x3S4HZ/Rtti57kLR5YygAmI5vMEp0dbqd0uRTg2E+couG1Qx/QXd1F7cNsR1aLTuLae4Fse+NbAhIrfzKAw5QSUyIQ5/K0NBD6/nd4nDTxZqe+02Yvcz+uj+nuEfHlTBUB2nOuEhTuJB5wCi8DxNwPLyC0a9g3D1k/YsX2TQ2U+EqXTsNuAZCu8oBQw18HDZvhE+pJe6neBRiL9eDxwadC6RsWa49lxdMDImmzaoDvMSH+KMNyXhCHBRf83DRXu1YuS9+f0599w8tSBVQJIjUHX4WO22pPDRPKCojW5mFl+LUDlPFRML6Y7METitrS3nBU6Q2Zk+fkx+M6YrctFRBcQewM+bL5rDgzu4SK1CtKOehC1G5Vx/+RqT7E/8MWWdvBVchn5hF/SfDuRPjGhlIHrSYWVqZ/hFapQixw/3ObPpagDxxNdYLkdUz7a4ozZSwAKomjg2/mpyGsMi+OykkJFrKMqVUkXWJhTKNttPlKrBuW5J8aV8s11Axy825jOmB2M+WBMny3WjHcaVy/ciZQouZZHn+ld/ZNfHsecsDVRr79UGherwvVxmlpt+KWMGIlyeFdtSz0ExIlKnYqQNFWcJ6WNKWHisx+kaUax0fLiHSbbC1Pxu5W2v/4tGSKzlGi853HrM5I8Jr/FAzdfEvRdcPDlvMPzgM+nFOnKftZU7HvJfYbMhu1MX4QqOo+f1t44EZAqf9uJremhxgMz4mi0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(2616005)(186003)(83380400001)(66476007)(38070700005)(86362001)(5660300002)(2906002)(4326008)(66946007)(26005)(76116006)(4744005)(8936002)(8676002)(91956017)(122000001)(64756008)(66446008)(6506007)(33656002)(85182001)(6512007)(6486002)(38100700002)(71200400001)(508600001)(6916009)(87266011)(82960400001)(316002)(36756003)(142923001)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dUl0ZlVWTFRCVDZkR1pvMVlrQkFHUGJlRWkyWW1ObTVjRXVrSWRZczVDMytz?=
 =?gb2312?B?eVVaYktsZU1FaGgyNHA3U0lhV1JoWW1hbWlvVVJWa2hyZW9mNlhWYVk3UkdP?=
 =?gb2312?B?UU1OMzdkSFdXQzZ5WktwLzd0TDFYd212SXBFZnpYWElXOEUxYlVqbW52a0V5?=
 =?gb2312?B?S09rSWVaTGpsQXpONHFFeC9nZmJGWUdYREZudVBwZU5SNk8xS1RVUzZCeXFi?=
 =?gb2312?B?TGVRcktoYTl0cUVYd1YwcytyNWg5azVUTFh4Mmh0UDFWSXB3NlVQSklBN29s?=
 =?gb2312?B?RTVIRVhOZGtCeUIxRnVDY3VrVjR6ek1DajkwOEpTVTZxUFJDUGFLaTdCRGlZ?=
 =?gb2312?B?RDloUzJXZGxnaUVwYXdwVkR5cmZ2K2Zzek1DcGd0ZkF5MTRJcmJZeThmTEVk?=
 =?gb2312?B?V1VXREtuVDdJTlNJeVR3NHdSZzVvaEJxellSbGh6NURQcWwxRGRsZW9zck1U?=
 =?gb2312?B?alJqR0R6UHpsb2VQeHhaV1QzUkIva3hOWXVXOUFoVFBabU1za1dZUUpHU0xz?=
 =?gb2312?B?blpLdmJNelprejQ4MitKTlp5Nk5zR0I1ODZNNWIyRDlxdU9UNlVrUWtjZGs1?=
 =?gb2312?B?WHlBcE9mVkV1dEdFNDJweWswYXdUdlZ4NUo1b0JXNkZhajhDbHlqU0RqOUp2?=
 =?gb2312?B?TVFqQW53R3lzUmlrMEErcTdUV2lKSXJ4M054d0RWc3gzWkxQKzFiQ2tQVEEv?=
 =?gb2312?B?RXU5UmF3UTRvalBqalZURGE3bU5GTEZkVzFXS2VnRGZ6bk1HS282a2hUM2sw?=
 =?gb2312?B?UWw1cWQrbWlJaStoYXRTSTRnTWJDcUh3UnZsM0hxSUFUK0hjN0xLTmJDV0dM?=
 =?gb2312?B?WGFQMThJSDdvVG5OMjVKOG1STmtkU2FsTC8rSjZuZnNOcWNaalN3aTA4MzdO?=
 =?gb2312?B?bHdCUDhNK1hkV3RZVm9PZzAyVHhMV2Q2L2Z3QVUzMGh1cGJ5TXExNitReGp4?=
 =?gb2312?B?TDNiV0RIWEVCQ1h0NjdQK0ZFNGJ5SGZqSURXMnVYcjJsbnZyTEpVN2EyR2RH?=
 =?gb2312?B?WWc1b2k2TXlSYTZEVDF1anVtM2lrOWtueWk5dllUNGtrS0FFNStuNEorazNi?=
 =?gb2312?B?THJoM01UblBmandEOE90NUxWWGtzRGhrVE15VVJiMm5Ta3FDeXFjNVRrMUJm?=
 =?gb2312?B?bXMwY092OUJ6NUdYZXF4M2U3SzFoZGZmVGx2Z1pLclBXVkRGejNoR0ZlT0RX?=
 =?gb2312?B?U0k3THVxNm1YNXlKNDdVbURtWjZkSHV6UDdSc09CQ2ZQbFphQzd4WnJxdTVm?=
 =?gb2312?B?WVlwQ014NnRUUFdsdUV5NVNDZUpYZTJ5U3JMUURzVG1NVThibXA5cEJ6eGg5?=
 =?gb2312?B?dmkzVStLRUkrN21NRHFPTmlWUERMSUpMMDBsUUEyZGNTUk15ZnFEcWMzK3hn?=
 =?gb2312?B?ZVhMbkMzOElQbk02V1pLT0NXY3U5TTdEelRoVG1wSElHdEw1TlZaemdyeFNF?=
 =?gb2312?B?ajNVUjB3TWRlSm82VXVDOXorWksrUUtBOU1vMm1LeEZ2ckNrQ2xzK1Y3QUV6?=
 =?gb2312?B?TDNpZTBmcitlL2xKQTNWZ2NFT0dwQ01TMms0T1ZQSVQxbHhGMkRDZUhKZEFS?=
 =?gb2312?B?akVZeXR6dTI0UGIxcnlNRFVWYTd0T1ZzTXM5YThldlhrTStZeENVT2k3UGxt?=
 =?gb2312?B?aDFacEtJWlNDMjVBRS9mMHYxYm9lMkdaT2tVVWtlWDZ6Vll6WTh2d0JWMGZw?=
 =?gb2312?B?Nmtncko1Rys2eUxnMlRXN1A3eGhiOEM2NWxuWmF1am5CUlpqS0Q1am5FY1hR?=
 =?gb2312?B?TGdJakJMbXd2SzlqUzVQYlJ5VXlRa0g1MzliYnRMSGNUem5TaFBZdXMvVjZu?=
 =?gb2312?B?NDJqWU1zYzVNNTlZRnA0ZUlpNUk0K2phQzhvYllONFphR2lkdE81Y0FOeTFu?=
 =?gb2312?B?d21aakl1eGJHTFJpMFJDWk81RjVoVjNUOExiWmJpdllLSjBtWGRoZy9qR3pX?=
 =?gb2312?B?a1lqVmV4YTBQcDc3MWtySkdGVHVCSkdhaHJLWjhKKzZSYStDbHdvZXBVZkRT?=
 =?gb2312?B?emxEdWZtQzlkbnM1ekV2aU90MHkrQnBBQW5TWFlHT09ReUwyK2wvb1ZTNEZG?=
 =?gb2312?B?NS9TTkhiYWFaT2xoV3dIV2dDYVpsL0lOSmZPak9pZ2sxUVk3Z08xQ0JUUUFq?=
 =?gb2312?B?TnlGRE1wMDlOMVlYWVM1VU1JM0YwVHJCa2VrN0xHalpOR2ptNXAzYzAyVHVW?=
 =?gb2312?B?VnNyakFYQm0xNGMvcFNNY21Cd3d3TXduNFJJR041dlEyTE9PbHk5eVg1Ynpt?=
 =?gb2312?Q?yUl/5IxhmQ4JCfedWbKIdMvsGnVgWfCYzEUs4Y8wbI=3D?=
Content-ID: <79F7E346E9B7CE48B4FEAACB3B2F46A4@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5519a0f5-c396-4509-e202-08d9e3a589a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2022 04:03:56.8044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 57eOVAX0l0UHHyIgDIv6TV+f2eH978Qk0X7hEWJTfzzbdTpy+wV2esVp0nRZbnPbbFtNv7+wQ+oinCWFnyA0ZXW9ez6p94GegHy75ScAI/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1650
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] shell API: print environment variables in .h
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

Hi Petr

This patch series looks good to me,
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu
> Petr Vorel (2):
>    tst_test.sh: Print environment variables in help
>    doc: Mention places for environment variables
>
>   doc/library-api-writing-guidelines.txt |  4 ++++
>   testcases/lib/tst_test.sh              | 22 ++++++++++++++++++++--
>   2 files changed, 24 insertions(+), 2 deletions(-)
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
