Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFE4C35274
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 09:31:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB38E3CF32E
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 10:31:22 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98F143C1C1B
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 10:31:11 +0100 (CET)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3702B601A35
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 10:31:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1702891870; x=1734427870;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=IULFfsyMggpTq4syJb5MPKk4nmHNaXfsjo9PmGrakls=;
 b=MwT7dhppryI2SNvw/py+3ZU/YX4P8H3x775/2AxmFC8EV9VXy2Z1+j+8
 IfABJB++1qp9GYPzAqf2LUiPstRJ74Bv9Z3XhOOYDua/ZChr2LgiSCYh+
 8sUUSPsC/lWoR+PTGwJpbSjC1n+GgM9lr86AKx+Vj+kZoXo7rN3G3HAR4
 LVHToVyvcSfRZOtavSYMqjSpYRaM1Opm8s1XmZ2xMVjHdDmmBq1s0wNXA
 Q+ntGU5Bh69XDg8UrPmVZ2eGEfCzYyUXGJ/CuQWjBbOoQg6HgNvBMIYok
 4tc/jvGFEDMzzdTjYxF9Lp84jOLZgR/JenP0Enw5Vwugn1l3cH8NCIbRv A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="19062750"
X-IronPort-AV: E=Sophos;i="6.04,285,1695654000"; d="scan'208";a="19062750"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2023 18:31:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFSr6Ez2i4cZVPUuEoaHl/471vgwLnYw36YMOTtVAoK7lYa2AW8QOMDx5Ki/Q+YGerpbQhkb+mxxG+awHfBW18L9rD/uD3vp1oJU2xcBQW6CMHzmKuq3No7R/sNofaWqItmChjPvFtlTkzuz9rPJRG+LUrGlNU14gF6pGTcDbFhxf7Dou+qQMJAbefH8WrTsMsgovT19w+B8yymDrenmVuHLZ/9p6bEDwCHbcI8xxYq4MWaAzkPHcAeGfMI69ZInBis1lU2bjhqUo2u9j5F3FzuBTWZICJByeU0wWPWUBiUOwOcFLZI70g3sD6QIBVWZhW5VdGpDEtA/YuA3ZG13cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IULFfsyMggpTq4syJb5MPKk4nmHNaXfsjo9PmGrakls=;
 b=i/Lwgu8UgIiEKNU6fi0cScB4/APeohrzXc9kKHlQEEPZVs2VR/PvU35pZQs65dbzZcbU2OdflfN+cpuk0IvswMBh/1eCs2qJF60EA/OIfotnr0g1gk7zLUg6LO/RYsq+cP7iaDAfYiZzkuXlwIvk/wNJrbab4ewx/wQ/6qQ9m6Lj0URjTJi/s59SNoD5ot/opraVIJnvEgpyJgL73ftMQT6pNRwEUwSI/q1k/F6f5ysQTVptznsLfW83k7c7xbe6I/WGngsGpWTetYvprhQq6dIxFUCU4iztm7gu4tea4OYxzazQeg46PIeSrmYC2lhFshEKSgVeiYHKyHA+i7DM3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYCPR01MB5711.jpnprd01.prod.outlook.com (2603:1096:400:41::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.16; Mon, 18 Dec
 2023 09:31:04 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::6f9:cd05:b0e5:6601]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::6f9:cd05:b0e5:6601%7]) with mapi id 15.20.7113.010; Mon, 18 Dec 2023
 09:31:04 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "liwang@redhat.com" <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH 1/2] gettimeofday01: Convert to new API
Thread-Index: AQHaMYp/tkFCRCqHgk+7ifr+MUrksrCuuqCAgAAMIAA=
Date: Mon, 18 Dec 2023 09:31:04 +0000
Message-ID: <4881a923-2857-444f-8f4c-ae000367bb71@fujitsu.com>
References: <20231218062129.130236-1-xuyang2018.jy@fujitsu.com>
 <CAEemH2e-QNst=HVf3C-mEmdRiNh-Rrq-WzAc8bAcOLEAW9jjOA@mail.gmail.com>
In-Reply-To: <CAEemH2e-QNst=HVf3C-mEmdRiNh-Rrq-WzAc8bAcOLEAW9jjOA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYCPR01MB5711:EE_
x-ms-office365-filtering-correlation-id: 9ada6ff9-dd0f-4144-1165-08dbffac0e73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2XByXP+YDrjkSsxsJgktcztw+frfaonkuhzUgmhrebUE9VRUypzIafIlBqxT6PDV2DB8phFd8HfxRaztVffQIwp5joSOVbCMwS2DFjbx2kEB8j9MZdfMbV9BNelMhy4Sr7fZbcDA9ZH8y4jhtVPJz3vtpNsBypPdmhZpZtdhlfqOCzYU9BF+8aLdpCbnmzxc8PnMIA8B4f0ySiisTVc+LU/yQ/X5TRa+bLLQpH49jvyrsfssKIe5KjaHEH6zq8ESZoC2pYVs1m5eUi5WBvNwyKCWJfLzqYuwRlnKK6djIpGb5jfejeHPiaKSKztVF3rzUv4ZdDCCxx7ylE6pDKLuKw1aECYH259gro8GwoMWiGA6z7nh5hRM8T2pMEdmM9ZZy/ZDD9FBfHdBL1Lz1oFBi5ZDoQWUHHzfOPny1NF8cLQquTTpSFZWU+CQI72hWE34YLfTMDoBxE/FFrzI5b3ecMDHtG0TcT8etWoM9kwovV6j17jVy/tmoqGyGM+u//TiUYzz/aLBojtfDbHBrRBZ5agKRRB7T59Uq3NjuYpUZwlftYe/T7xoMkE9HI5Hq16lkcoWI6q1Mls1tNvexVgrKnOKi9nTNKszAOJTPmus02rddSk2uYVMMnfkgpZJwy29z9OozukT2ie6jWa5ga6V4KrXJJW54UglMGQ0ijZARygwCM/ouypef9lVQjdTLIvb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(186009)(1590799021)(451199024)(1800799012)(1580799018)(2906002)(71200400001)(31696002)(86362001)(36756003)(85182001)(4744005)(6512007)(53546011)(6506007)(478600001)(6486002)(38070700009)(82960400001)(38100700002)(26005)(2616005)(41300700001)(122000001)(5660300002)(66476007)(66556008)(76116006)(8936002)(31686004)(66446008)(64756008)(66946007)(91956017)(8676002)(4326008)(316002)(6916009)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVRGMWN2ZXBnQjBIZ3hSQTJUTXhUWldrYWFEMlpQZEowZXVpZVNNMnYvT3l6?=
 =?utf-8?B?ankyNnpRNVZMRlRLdVNqeE9yYXJIR2JLNlV2VmlSb3dSNm10Y245OGxjbTho?=
 =?utf-8?B?SHFZakErWUpISUlIZFIxbHNZWldvSFJnMXE5cHhHZ3V5VitEditoS24wRXV1?=
 =?utf-8?B?TGFLTTMyTHBKcWV6dEJETzcycUxlTDZBb282YUJNVVdwTzA0YVhUWjc3SzU3?=
 =?utf-8?B?RWkwUDJFaG5QME8zTDN5QndzR01GT0s0TnpNeXI3Und0U251cWNQYmYvSmFU?=
 =?utf-8?B?OUpDcU1XSExoeVcxQ24wOGhkQ0RIcVN4cW1zUTJIbTUweUxsWEh5N1RWWTNI?=
 =?utf-8?B?UHpqWG55dzkwSjBoZVR2bVdIcG9zQXpMTDdZNmVxMlY0ZUxvOGQrWHhCemhm?=
 =?utf-8?B?REF3clRTQjVGVzdwYnpEK2VRd3JreTROLzRudHdXeWk2VTdYeVNsMXIzZHFT?=
 =?utf-8?B?Yys4Z3N6Q3hvbUkrcFZub2JDUnVSQjFaZ2sxeHZVNUxUb1VVUmRScUJyRlAw?=
 =?utf-8?B?cHpJZWdodUtaa1NGQ0pvaU9uL2RiLzNrNjUyK092ckhMNFpmSDRWd0E5Z21F?=
 =?utf-8?B?WGxWTEhlRUhWZjF1aXI3V0pIdG5vandIS2dLdkpVU3pkWTI3enhWWGkxMVZz?=
 =?utf-8?B?QlVYd3dtRjcvWTBTZ0x6dUxEa3RrSDZoZVNtakpZWFMvUi9vTHZaU3dnTW9O?=
 =?utf-8?B?dDFiUW0zVGxiQzdRdVdLcEdqZUhaWm9weDVCU3BJSFF5RHZObWJ4K1ZUUFBp?=
 =?utf-8?B?MzRrR0E5anR5S1hISis2Z2MrRXg3Z243QllrK1pYVzkrNnFobXlVS1JRenVS?=
 =?utf-8?B?dlVEUlZyVzR4cC9EL1owNnBEQy9SUTZYNmNRRGNNTjRoYmFIVkJxMnJVV3VK?=
 =?utf-8?B?cDlpVVZabzdwckEzbEdvRTZZVFhzVlFLUkdra3ZMRWxrYWRnUDJwbHMwKzRK?=
 =?utf-8?B?QkUwdEJkakswVVkrYmRkbXBlczJvZ0prakhzTGx0OGNwMS82QzQ5Q0tDLzNK?=
 =?utf-8?B?NHdEdUZoVnYvbHlDbm5WZ2tIZWVxaC9aSDhRemt2THZLaFE2TU5OMDVPY3F6?=
 =?utf-8?B?eTlPbHRoYlVhZWx3OCtzc0NxUkM0cVI5Z2RjYTFrUkZRNVg5NFJJVnFvSG9w?=
 =?utf-8?B?L3o0Ukt5cnRHWTdRV1gzMjBVU20veEt4M3kyL0VZeDkxSWNqamxUb2IzdGpB?=
 =?utf-8?B?MTJ3ZXZUL3l0TnYxRlFoWS9vUVdmdHJkOTYzWUJvZzdpMjJOK0NVZkx2eStR?=
 =?utf-8?B?dWhBMVo0bHAyZ3hsT3AzaWgzSWlVZDFRbFlCNWFhSTVXQ0FzWVFQVjNGOUJ5?=
 =?utf-8?B?MXcvbVRWeXZQcFNaSjZNb1BFVzNCdWpSbGVpRGZWbm8wS2ZiK01xK25Temsy?=
 =?utf-8?B?UWdvc0QrbmNlRVNEeDIrNm8vemp2Zld3TGxnaFlyUzlGM1g4QW1SdUFGaDY4?=
 =?utf-8?B?TjNkUDBBRTRCMHlFZDJTaGVCNDRpUGFQOGYrWlR5MXk2VUdBVi9FcW5INlRW?=
 =?utf-8?B?U0hPbzVLSDREUUl1OUwveVFiUUMyZlhmZE4yWXJ3NGpDRldPZy9ON1A4MWZk?=
 =?utf-8?B?QjQvaWpNamVRK0p3Mk5DU2hFUjZEZ1BkQVprVXZhK0hPRWFzU2luQlk2bzBP?=
 =?utf-8?B?NFhaa0FRV3Rvc3R2L0JnQXRIYTNoSXFlTTFlSEx0WnJSVkVzTTVIL2grOFlM?=
 =?utf-8?B?d2RzWEZYZVVnbDFJbjAwYUprQUpmRTMxVjhtYnBiR3VxSjJtOWJnMWhYL0lJ?=
 =?utf-8?B?Wm1ZZTNmMzNBVktSS1Q4MUN2M3R5bVB3SGNIYnZGZDhEWDBFSk4ydDc1aFFz?=
 =?utf-8?B?enJEZzNqdlZ3cSs0T3JLY2JXZms5a2dOb0p1T2VyM1I1WDlaR0Vla0JrWkJD?=
 =?utf-8?B?RDBsSEJ6NTFrZ3hLTkI3NUJFaHNuV0pJWkxETmhsZENnSUx4L0tuQlJxSG5n?=
 =?utf-8?B?Wi80aHNmSEVTcDUyTVBPRlZ0WU9EemNBczdIaHJEZEY5Ymx0bEk1b2JoZFgv?=
 =?utf-8?B?Y0J1TmhDWXlkNGZydy94dDNpUzdyV0FaTy9samFUZCtVRDVmbCthSWdkZ2VT?=
 =?utf-8?B?Zk9MdHB0ak5UNGVpeGZ3OVVzS2t3WnA5cktPOFYzVGpzanlTcGpKWWdXSDdl?=
 =?utf-8?B?MStTNDl0ZWtyNDNXaFl1TDl2d3J6bzR5NzY0RTRhSEwxbXhmSTZ5MjY2QTUr?=
 =?utf-8?B?S1E9PQ==?=
Content-ID: <74AD5D04B46EC44DAB2A488C57362F4C@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: l4JGWIKSQIGwnHEm4ND0CtkT1zJr71Joxc3yvsB3l2ZCjweguCAzHJIfDlQ5WYNNhR4SwjIktHvdE+iCeSKi3ao80ZDf7bWweS56AbZlJ0MZnWahrSf25ORRmWcbvtIPWWPbqXAAqOthS4fXbpYKdK/vYTy8H6VR9crk4Z8yp6fpCZ3xtNVfHnIDfqe7gjQlot9oiw1IR4VOt4nDD4lm2zsnStlf9ep45r630x6Xj3RHymCB91QAFdpiiwCZaCLn9U17kCnxeKu3GoqVkZgrYpsa1dKWK8CZAqcfiC0IEbJ4JyzEPPH2OO8vs2/idg0dUh7NtuYHZoNCRcM6zQ2yEsjQTc2RQTTua5oyc72aX6BvTRsDOR7tRi26bauuFTKVCqsyLPmcJWxGKfRNeVip5IDKitLqk4av/y4zqBew1osPR0gpzRflc16pcvVxw4HH+86Ib+njNxpfIepNtBMjp+1fDTOIGrsB2cFUdJ6IGTTHPG3xQlQJQoGKyDMYm/tv702X2Yu0ppIgvvMdtUKNhHPynzniV94OPdTm7zjYgDb1FUmOARb0kziWZKMmWK4LoPu3iVM4Hwb1nWBU/mNChJxPRXyMH4xd0uPjmxFjkxRFi5EugJYsqIUQRdYsn6d/
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ada6ff9-dd0f-4144-1165-08dbffac0e73
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 09:31:04.4824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gwYDK2UUEVChB8oCSJmhwZ4VVF3oKl00raXsm7YPINX0QGb/d6Vlco3D3pEZglAWtVLQNXhHDM8br8Qel5unjx4zh+6lH2SJA8i/eAyJAmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5711
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] gettimeofday01: Convert to new API
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGkNCg0KPiANCj4gDQo+IE9uIE1vbiwgRGVjIDE4LCAyMDIzIGF0IDQ6MTbigK9QTSBZYW5n
IFh1IDx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tIA0KPiA8bWFpbHRvOnh1eWFuZzIwMTguanlA
ZnVqaXRzdS5jb20+PiB3cm90ZToNCj4gDQo+ICAgICBTaWduZWQtb2ZmLWJ5OiBZYW5nIFh1IDx4
dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tDQo+ICAgICA8bWFpbHRvOnh1eWFuZzIwMTguanlAZnVq
aXRzdS5jb20+Pg0KPiANCj4gDQo+IFJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0
LmNvbSA8bWFpbHRvOmxpd2FuZ0ByZWRoYXQuY29tPj4NCj4gDQo+IEJ1dCBJIHdvdWxkIHN1Z2dl
c3QgYWRkaW5nIG1vcmUgY292ZXJhZ2Ugb24gRVJST1JTIGluIHRoaXMgdGVzdC4NCg0KVGhhbmtz
IGZvciB5b3VyIHJldmlldywgSSBoYXZlIG1lcmdlZCB0aGlzIHBhdGNoc2V0LiBBbHNvLCBJIHdp
bGwgDQppbmNyZWFzZSBnZXR0aW1lb2ZkYXkgZXJyb3IgY292ZXJhZ2UgZHVyaW5nIHRoaXMgd2Vl
ay4NCg0KQmVzdCBSZWdhcmQNCllhbmcgWHUNCj4gDQo+IC0tIA0KPiBSZWdhcmRzLA0KPiBMaSBX
YW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
