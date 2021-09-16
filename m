Return-Path: <SRS0=QfDu=OG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828F1C433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 07:10:46 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9171161029
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 07:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9171161029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0F7D3C6EC3
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 09:10:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C31E3C1D69
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 09:10:34 +0200 (CEST)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F185C601E7E
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 09:10:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1631776233; x=1663312233;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Yh67aA04sca3NucDhwMuZetQxnt7z2Cb9c2YOW6FcE8=;
 b=ntNNpyCUPpevTsV4HKe/S/3teP9gGZOcWtQ7cDr1r7WXqIQiIMvekbMF
 FK2DKZHFbFFBHPktw0N8tDiveKtjQX9nTHjKlKBm1dWQEoDrcsKIombft
 Ersr2dMF42UrMgKATtp04WtJvvu5ousvlUX2MBsVCz8rtceXoHdDHMkVU
 JiHju6/qGulitly/iUi+DXyv0IBaQ1U4XOCjFg148CEQ137/23Al4fdL9
 gn7/54E9w4OiEQ81rmssxibxXwR9Ku0yFEdqUW7KMU6fK2y9utFCWXFO3
 iEZMEtwgYpH6yRwYkFhQgIzaS4BcjTTdu0EdRuGh24S/wDSnfspAxuB8z g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="39234799"
X-IronPort-AV: E=Sophos;i="5.85,297,1624287600"; d="scan'208";a="39234799"
Received: from mail-os2jpn01lp2059.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.59])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2021 16:10:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUNut4owT3eo3ekEmHoKQ1DheE4m5cXeHQj2vkWgOfMSVdsAyoBFwfKmohYHIq394SidH7IAgk9A4W70c/qdxvekMzc5C+Jg53fwZQOnMzDFecTXWvOEMEixqgbl8xd/ShT0us4FQdtazogjNAJpPy/YgjFBJoV1Cep+NUSbnlbtvyS+M1YIviYd/E+68M6/d9RZlmJbyB17fOJ9O5chaWsPhpCIotNDAI+2d1tyMBHtZI+rbJa4R2atCwdaF809V62JFfeeoVrz6hDLzmhVSzMFnmQzMCymR/3cCF5u8XroAmpMjz6wVGG2xdzJgPXnOb0etMQBpL3wURDyPcXX3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Yh67aA04sca3NucDhwMuZetQxnt7z2Cb9c2YOW6FcE8=;
 b=HipT3efzb/8Ap2OL3ydToCeKSpRcKpSbhh3OhufN344rX66nOn7TATpY3JTuN0MJaDHqVA0mPnAoZWsxY20FN/fkEbL0veDtQsdXkEjdwtQtGHEFMjVoq7x37n9HTeiIP3f+pHeWGgZHZeI4zK0IhXleScli5CE6uepYAsR9s/vZqNgZgo7eC/hr2hWi33vYsgB+sZN+Bgc+TFAuiPaypRb/U202sGBCyhzBMq65JKtmIOAzUVTzvVTgEfuXU3/z74/Ci+7hyiZMzZrBWMiZG4YTFCGnWsTR4iJoPbYnuFFhP0NVytrsX+BbWa4PUnUytpXf1jy3wcZeDztzMeWzug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yh67aA04sca3NucDhwMuZetQxnt7z2Cb9c2YOW6FcE8=;
 b=E1P3PH3dOb+3CFsfkBK3JKa6SB94L82oZeAIOSoEwZtSJaizkzYxtnMKrKozIFxNcyp14pykuzHXYiBvqEVtua86ve22dZ3SxLujpEwritTrLQKUzGUqysGaWcAlm4iRgtatmRCu9nXXdx17cjCfu9ZV+5BuxjuL+lDGJbhIWWw=
Received: from TYCPR01MB6461.jpnprd01.prod.outlook.com (2603:1096:400:7b::10)
 by TYAPR01MB3951.jpnprd01.prod.outlook.com (2603:1096:404:c9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Thu, 16 Sep
 2021 07:10:26 +0000
Received: from TYCPR01MB6461.jpnprd01.prod.outlook.com
 ([fe80::a91d:f519:509:56f8]) by TYCPR01MB6461.jpnprd01.prod.outlook.com
 ([fe80::a91d:f519:509:56f8%9]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 07:10:26 +0000
From: "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>, QI Fuli
 <fukuri.sai@gmail.com>
Thread-Topic: [LTP] [PATCH v2 1/4] syscalls/dup2/dup201: Convert to new API
Thread-Index: AQHXqkmsaAm6IOM110iDGrCoGT/7DqumNBuAgAAJodA=
Date: Thu, 16 Sep 2021 07:10:25 +0000
Message-ID: <TYCPR01MB64610FBF86B8DE1DB47DA887F7DC9@TYCPR01MB6461.jpnprd01.prod.outlook.com>
References: <20210915155152.8515-1-qi.fuli@fujitsu.com>
 <20210915155152.8515-2-qi.fuli@fujitsu.com> <6142E499.8020302@fujitsu.com>
In-Reply-To: <6142E499.8020302@fujitsu.com>
Accept-Language: en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjEtMDktMTZUMDc6MDU6?=
 =?utf-8?B?MDBaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD0zMzAzY2RlYS03NDNmLTQyYjAt?=
 =?utf-8?B?YjI5OC00NjRlMmE4MGYxNWM7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4aa2bc1e-c754-45e2-99ce-08d978e10ecb
x-ms-traffictypediagnostic: TYAPR01MB3951:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB395136D9DF25C6CBEFA37849F7DC9@TYAPR01MB3951.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y6fCnlxQahjIcPL1qehjH7rGolLlWfVq+HBNITyap+CBc8C+0+MUETOUlTVdGfnIFmO4cBYnY8ytsHM/mJ6GgsoAHjvW7kvXy8VxWXzmRKnLRh0AHADLg6lMauTnDwuz/hyHbDZR1w6JAbZbC+B3x8E/Mg3sGbXhUolR91mk8QDxwLMUuGbIUOQtZmCyjeAKHCFbnwo4CUx+7POSP8uN1TbeYwZJorlzz2yZwXWSstVDnty+YPSPhUP3E4WmiEe+BOwh5g5u1Ynfsp5b0CwEqbPlLEN17aCAK7nN23TjtoLeUjSLW7CylbACQOZ0bE/8zCCTMFz0Xlk4HPkmazhtqV+qSEsx+z0mqFKhcYd5mgge4UAorA2zAvJ8mzUZY3w5pN6pipxdInfvKpcESKXeAEC4Kf/XvXKHZEevQ65pRrX3Ig7aNWQ6dVj3mBUPERd7gSTMznjv2q83R0Ns/MjlKML0qVdHgAk5hSae9GCjd2XpMkZCYnPFzFEFYOxIFJCORrEIl3KmNFiQnptawJIre7T/QzUPE2/BmTOMutPhONTpCnePdqquAoTcFGnKyn5zgNZXX0vaDKGoJl3n2xrdo+O+bBn7H9TIO9XEnfy8GvYcgnJKJyYbKH2jnavyghnNw8CmoRWNl6f5xhfdJ+dWe91X8b7WJz8nSf8nIn+wWfHbmIJuCCDPauXbwWyv/BsCDyjKqb5wSnYiUjabDfNnoN7aisFwcZySZGS4d3in9LE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6461.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(66476007)(66556008)(478600001)(316002)(66946007)(66446008)(64756008)(2906002)(71200400001)(8676002)(186003)(38070700005)(86362001)(8936002)(26005)(76116006)(83380400001)(85182001)(55016002)(7696005)(9686003)(38100700002)(110136005)(4326008)(5660300002)(33656002)(6506007)(122000001)(52536014)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjlBSFU2THdiYWR4cysya2RkZ0VvQk4wMDRoQ0ZtTkpBWWcraU5KM3JrUTRF?=
 =?utf-8?B?NXFhV3pJZUlxNERkTi9xQzFMRkZZN0hxZDlmTE1yTXg4YUJ4MDB4QnlCYW1K?=
 =?utf-8?B?ajhhaFF1MDhxWFNrV28zK1duengwVHhUZmZUSU00N0Z4WFRJTUpsTFZpeXRP?=
 =?utf-8?B?cmlvZmpyMVNJYy9UZVJNWGJDVXR1dXNwV3hINlVLcHlSbmNEZVRFWUNRcVZ5?=
 =?utf-8?B?dEVRTThGK3loTHlPdE10aTFnRlhRZjlZd1lqenZnc0trV2luanJvV1Znc0tF?=
 =?utf-8?B?OVNKRzAybzNwTDFIdXFBYjUrVCs3K1N6Z0NTQUU0K3BnQ2U0czhoR2ZUN21w?=
 =?utf-8?B?aitnb3E2RS85V1pqUCtLMFNCazlVNFZRSnh4dUhJSTIxZld1cTMyK3lnYUxm?=
 =?utf-8?B?WElnY2lFbkRWUG5hbmFaMVljM2hoTkVLZ0Nwc1BJUmdaU2loRTJtNmpEV05t?=
 =?utf-8?B?ellFWjQ2UkVsaXhEdWQwenlxU0ExYU9yOWo4SXhTWkM4RTZQYytvY1lxdWhs?=
 =?utf-8?B?bUlvWUZnLzF0OU93SlphVGVtOXk4b2dyejcwZmVPdFRkRzNtcnNtMFRIMFZj?=
 =?utf-8?B?azRHSGFuVWovanUrZ1lkNTJZUFU1ZVpjVWl4MHR5UlhuVjluRVhDQTRjVVp5?=
 =?utf-8?B?bDRLK1h0cFVsSDV1ZTRoN0RBWkJzYnJja0c4TDdNblJVaWoycUFxZnJ1YXhG?=
 =?utf-8?B?U2pBd3BZajFzY3l0UklDcTVuVUkrUFhPdTMxVXJJdHJ2SSs3MVNZRVR0YUtI?=
 =?utf-8?B?cjNQK3l0a1dCQzQyNmJFdmFjSEtzTUkrNUtNQW51WjdtTkthK2FHYmdnU2t3?=
 =?utf-8?B?R3o1Yi90SkRoT2d3cTRHOU1vWWIwQmhmV053aWo2TE5mTWJaUFNVM0tjWmdY?=
 =?utf-8?B?aEJYNDFuc09rVzU2WWwzWjFrdW9ZVW1Ha05NODh1ZGpHUEdxNmJXQzlxYWxq?=
 =?utf-8?B?blN4SmVZckh0UVY1c2VOaUpEQjg4QVVwWVIzdFgrTkRZdmNpQ0hPUGRaeGFw?=
 =?utf-8?B?VFZxNXZUdS92L08xbjlXa1drdGtBWWJaRDdxK1VIYi9vUmZ5SFVFeW9FeTZN?=
 =?utf-8?B?S0pwYVI1V2pjNjRNQ1Fwem11VEVqZ0owaitFUEZTcGF3dVoyOTN5bWFDS2J2?=
 =?utf-8?B?SERqeEdqRkU2R0RlQnBySEtObHVuakhMU3ZMMDQxUHhrNHpYM2tZcGNpZHdl?=
 =?utf-8?B?ZFZXdEdTZlpOSTRCNk8rcDE0THBORjZHR3F4UE50eWYzdi9RcmZoUUlzdzlt?=
 =?utf-8?B?UDNUNXhBR0IwZDh5NWR2Y0RWZElPb1paR0x3REd6YzJGUnpOaFRCNEVOQVRp?=
 =?utf-8?B?SFMydnpBZnlMWTN1aGxtc200MEFOT3djWmNQbDV3bTJXR1hJNmhQR2NuaEM3?=
 =?utf-8?B?aGMxc2cyOHNpQU9CcmlGc1pCNWRUeWJSYjZlTHloMVJGTjlNaUJTcklnL0s0?=
 =?utf-8?B?aDg2a1F0VXJpWHZnOVFpN2x3YTZTTHEzRHA4ZUpXbmw1bEx0b3I3RXdlWTI0?=
 =?utf-8?B?N0hrYmozU1ZQTjR6UUkxbUhLT3lFR3VVZ0gweEVLZktBKzRrTUlLNkVBbXE3?=
 =?utf-8?B?QjMwdytLTmlpUHg1cG5tZkROMHE1N3JURUM0VzZQNU5VVHBET09HckFDOGdK?=
 =?utf-8?B?ejMxR2hVVWFvRXZ5SlYxWFdUemxTd3VoR1ZtbTljeGxrYlo3RkVtZzZmZlJX?=
 =?utf-8?B?cnp2eTlFc3BZYUZpVVJBR3E0V1ViRTR6Unhob2lvRXUvTGR6WjZCWkRiT3RY?=
 =?utf-8?Q?HyZUGchklkjGXDhxu7IQQZ5w9bWUEFdVCoChJA+?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6461.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa2bc1e-c754-45e2-99ce-08d978e10ecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 07:10:26.0107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wq0pQOScsfnODAwBAvY6TKRSAf8t6jlXKUg8+klkreTx6betQHbjisqtULmPHgopWbPpiXfwJMi0JZf2H+1Ybg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3951
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/4] syscalls/dup2/dup201: Convert to new API
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
Message-ID: <20210916071025.47DquD5hlax-q6SSz7XpwJZ651ICKucpdweyTEpo3vM@z>

> 
> Hi Qi
> 
> > From: QI Fuli<qi.fuli@fujitsu.com>
> >
> > Signed-off-by: QI Fuli<qi.fuli@fujitsu.com>
> > ---
> >   testcases/kernel/syscalls/dup2/dup201.c | 174 +++++-------------------
> >   1 file changed, 33 insertions(+), 141 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/dup2/dup201.c
> > b/testcases/kernel/syscalls/dup2/dup201.c
> > index 4fa34466a..8e47a2244 100644
> > --- a/testcases/kernel/syscalls/dup2/dup201.c
> > +++ b/testcases/kernel/syscalls/dup2/dup201.c
> > @@ -1,163 +1,55 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> Remove this empty line.
> >   /*
> > - *
> > - *   Copyright (c) International Business Machines  Corp., 2001
> > - *
> > - *   This program is free software;  you can redistribute it and/or modify
> > - *   it under the terms of the GNU General Public License as published by
> > - *   the Free Software Foundation; either version 2 of the License, or
> > - *   (at your option) any later version.
> > - *
> > - *   This program is distributed in the hope that it will be useful,
> > - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> > - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> > - *   the GNU General Public License for more details.
> > - *
> > - *   You should have received a copy of the GNU General Public License
> > - *   along with this program;  if not, write to the Free Software
> > - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301
> USA
> > + * Copyright (c) International Business Machines  Corp., 2001
> >    */
> >
> > -/*
> > - * NAME
> > - *	dup201.c
> > - *
> > - * DESCRIPTION
> > - *	Negative tests for dup2() with bad fd (EBADF)
> > - *
> > - * ALGORITHM
> > - * 	Setup:
> > - *	a.	Setup signal handling.
> > - *	b.	Pause for SIGUSR1 if option specified.
> > - *
> > - * 	Test:
> > - *	a.	Loop if the proper options are given.
> > - *	b.	Loop through the test cases
> > - * 	c.	Execute dup2() system call
> > - *	d.	Check return code, if system call failed (return=-1), test
> > - *		for EBADF.
> > - *
> > - * 	Cleanup:
> > - * 	a.	Print errno log and/or timing stats if options given
> > +/*\
> > + * [Description]
> >    *
> > - * USAGE:<for command-line>
> > - *  dup201 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> > - *     where,  -c n : Run n copies concurrently.
> > - *             -e   : Turn on errno logging.
> > - *             -i n : Execute test n times.
> > - *             -I x : Execute test for x seconds.
> > - *             -P x : Pause for x seconds between iterations.
> > - *             -t   : Turn on syscall timing.
> > + * Negative tests for dup2() with bad fd (EBADF)
> > + * First fd argument is less than 0
> > + * First fd argument is getdtablesize()
> > + * Second fd argument is less than 0
> > + * Second fd argument is getdtablesize()
> >    *
> > - * HISTORY
> > - *	07/2001 Ported by Wayne Boyer
> > - *	01/2002 Removed EMFILE test - Paul Larson
> I think we should keep this history info.
> > - *
> > - * RESTRICTIONS
> > - * 	NONE
> >    */
> >
> > -#include<sys/types.h>
> > -#include<fcntl.h>
> >   #include<errno.h>
> > -#include<sys/time.h>
> > -#include<sys/resource.h>
> >   #include<unistd.h>
> > -#include<signal.h>
> > -#include "test.h"
> > -
> > -void setup(void);
> > -void cleanup(void);
> > -
> > -char *TCID = "dup201";
> > -int TST_TOTAL = 4;
> > +#include "tst_test.h"
> >
> > -int maxfd;
> > -int goodfd = 5;
> > -int badfd = -1;
> > -int mystdout = 0;
> > +static int maxfd;
> > +static int goodfd = 5;
> > +static int badfd = -1;
> > +static int mystdout = 0;
> "static int mystdout" is enough and don't need to assign.
> static int maxfd,mystdout;
> >
> > -struct test_case_t {
> > +static struct tcase {
> >   	int *ofd;
> >   	int *nfd;
> > -	int error;
> > -	void (*setupfunc) ();
> > -} TC[] = {
> > -	/* First fd argument is less than 0 - EBADF */
> > -	{&badfd,&goodfd, EBADF, NULL},
> > -	    /* First fd argument is getdtablesize() - EBADF */
> > -	{&maxfd,&goodfd, EBADF, NULL},
> > -	    /* Second fd argument is less than 0 - EBADF */
> > -	{&mystdout,&badfd, EBADF, NULL},
> > -	    /* Second fd argument is getdtablesize() - EBADF */
> > -	{&mystdout,&maxfd, EBADF, NULL},
> > +} tcases[] = {
> > +	{&badfd,&goodfd},
> > +	{&maxfd,&goodfd},
> > +	{&mystdout,&badfd},
> > +	{&mystdout,&maxfd},
> >   };
> >
> > -int main(int ac, char **av)
> > -{
> > -	int lc;
> > -	int i;
> > -
> > -	tst_parse_opts(ac, av, NULL, NULL);
> > -
> > -	setup();
> > -
> > -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> > -
> > -		tst_count = 0;
> > -
> > -		/* loop through the test cases */
> > -
> > -		for (i = 0; i<  TST_TOTAL; i++) {
> > -
> > -			/* call the test case setup routine if necessary */
> > -			if (TC[i].setupfunc != NULL)
> > -				(*TC[i].setupfunc) ();
> > -
> > -			TEST(dup2(*TC[i].ofd, *TC[i].nfd));
> > -
> > -			if (TEST_RETURN != -1) {
> > -				tst_resm(TFAIL, "call succeeded
> unexpectedly");
> > -				continue;
> > -			}
> > -
> > -			if (TEST_ERRNO == TC[i].error) {
> > -				tst_resm(TPASS,
> > -					 "failed as expected - errno
> = %d : %s",
> > -					 TEST_ERRNO,
> strerror(TEST_ERRNO));
> > -			} else {
> > -				tst_resm(TFAIL | TTERRNO,
> > -					 "failed unexpectedly; "
> > -					 "expected %d: %s", TC[i].error,
> > -					 strerror(TC[i].error));
> > -			}
> > -		}
> > -	}
> > -	cleanup();
> > -
> > -	tst_exit();
> > -}
> > -
> > -/*
> > - * setup() - performs all ONE TIME setup for this test.
> > - */
> > -void setup(void)
> > +static void setup(void)
> >   {
> > -
> > -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> > -
> > -	TEST_PAUSE;
> > -
> > -	tst_tmpdir();
> > -
> >   	/* get some test specific values */
> >   	maxfd = getdtablesize();
> >   }
> >
> > -/*
> > - * cleanup() - performs all ONE TIME cleanup for this test at
> > - *	       completion or premature exit.
> > - */
> > -void cleanup(void)
> > +static void run(unsigned int i)
> >   {
> > -	tst_rmdir();
> > +	struct tcase *tc = tcases + i;
> > +
> > +	TST_EXP_FAIL2(dup2(*tc->ofd, *tc->nfd), EBADF,
> > +			"failed as expected - %s", strerror(EBADF));
> Since TST_EXP_FAIL2 macro will print errno number and string automaully.
> We don't need to print the duplicated info.
> your info:
> dup201.c:47: TPASS: failed as expected - Bad file descriptor : EBADF (9)
> dup201.c:47: TPASS: failed as expected - Bad file descriptor : EBADF (9)
> dup201.c:47: TPASS: failed as expected - Bad file descriptor : EBADF (9)
> dup201.c:47: TPASS: failed as expected - Bad file descriptor : EBADF (9)
> 
> use    TST_EXP_FAIL2(dup2(*tc->ofd, *tc->nfd), EBADF,
>                         "dup2(%d, %d)", *tc->ofd, *tc->nfd); info as below:
> dup201.c:47: TPASS: dup2(-1, 5) : EBADF (9)
> dup201.c:47: TPASS: dup2(1024, 5) : EBADF (9)
> dup201.c:47: TPASS: dup2(0, -1) : EBADF (9)
> dup201.c:47: TPASS: dup2(0, 1024) : EBADF (9)
> 
> other than these nits, this patch looks good to me
> Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> 
> Best Regards
> Yang Xu

Hi Xu,

Thank you for the comments.
I will fix them and send a v3 patch.

Best,
QI

> 
> 
> >   }
> > +
> > +static struct tst_test test = {
> > +	.tcnt = ARRAY_SIZE(tcases),
> > +	.test = run,
> > +	.setup = setup,
> > +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
