Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E668FC7EE22
	for <ltp@archiver.kernel.org>; Mon, 15 May 2023 06:26:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EE843CDD63
	for <ltp@archiver.kernel.org>; Mon, 15 May 2023 08:26:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CABA43CA2E4
 for <ltp@lists.linux.it>; Mon, 15 May 2023 08:26:35 +0200 (CEST)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C50BF1000521
 for <ltp@lists.linux.it>; Mon, 15 May 2023 08:26:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1684131995; x=1715667995;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=hC9QLoQsv30Pxbg/p6JUeY0YMqP/3YdseZWMTbK5DGY=;
 b=c6SaGIx4akUBYhNSjnDXJf/AdB76Cz7PGevOmVuJTiSR0+sv0kpqOME9
 yo4hYy6XGvqIGt7u5OjhZigOtJG3T1UVr9boJ3bqcB8uUqvzdf7IVVtO3
 RogwBqXOvjLNu4SqnR90XwbDfzxkrppfcZX6R3daOxs05GHfa3sBg/ZJt
 pOHUjcMRQiVpScd22vjYUTFFK8Rjs+7RJmdKFvZlfD2nn7SQnXzltyT23
 kHn5sBQcNnPNjWP4d7zdkH0ycvrSbKqFSmQestRQA+F40kD1JzhTIJl+H
 OTCycbKsMmXW+mgNYCb2kUAwZ8ic1otHIlYUO8/Z2RKKvesSBZNXGKzhZ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="84412344"
X-IronPort-AV: E=Sophos;i="5.99,275,1677510000"; d="scan'208";a="84412344"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2023 15:26:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyVV1WbO+VHPNH+Dz4ALZfYTRZkQYDFTmuhbb//9bn+hbGFAtmTrRKPebWMNK3+2iTUEXluLjI/wcZ9Zp4bRAoglqsEj0oeX8Ru+/JNxmaOF2of0VWARl9w6jC5s5A8BGNL1B03Kk4+3NtsbMxaMBhVJ8vyFFMs4a9IeHE75c3IvpKA+GbifiD/I5LXxhmP1X1pNp1oI1YE05YwPI4HnICV8vz2avx1OIHJvMYScVnAsRedZgVFEUvCKsdfeFfJjR1075Pgw+ScF4W9tJvw5JnBiyOOQk2AMxBq2/zzSKnnHGMtKkKkWM6/pHUbYJPRkH/Z17ltf6iTxY7PlZvNJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hC9QLoQsv30Pxbg/p6JUeY0YMqP/3YdseZWMTbK5DGY=;
 b=D+E5246wghJ91cELaV0idc0pt6wpy2QUq4mhz7zXeqdi9Uwzyza2/vcsSubgjb1eVoVsktHo+FZwNHOWy60MKIfY3i0ShE2mstjwrg78kdgFdDjNi3sSySjx81hvnptlBLX2BTbBgFlp1NLCVeRAjFHXcKIpOCSsJZ989GvmIM1H4+fZh05LEFIbnUVGmo+ZFh1P9FBDgDFmpGITOnbINajj9jvPgkNQoZYVa6mneVy1eHt7C1ArI42JsauIBRTCOW0TXE4wd8BwbVIN5aqMso7IqVVpnzv2tJEcok7melA8Pmikq0Se+O+BtG8U1A72L+b1jginRIZUPFGT5jDZ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYWPR01MB9311.jpnprd01.prod.outlook.com (2603:1096:400:1a1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 06:26:29 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 06:26:29 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Eric Biggers <ebiggers@kernel.org>
Thread-Topic: [PATCH v5 4/7] syscalls/statx01: Relax mnt_id test condition
Thread-Index: AQHZglbd+ONUGB1aBk6ywBz/akLxiq9XXx0AgAOIigA=
Date: Mon, 15 May 2023 06:26:29 +0000
Message-ID: <646065d2-73a9-625a-1fef-a2e453c9d71c@fujitsu.com>
References: <1683623648-22778-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1683623648-22778-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230513002854.GA3033@quark.localdomain>
In-Reply-To: <20230513002854.GA3033@quark.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYWPR01MB9311:EE_
x-ms-office365-filtering-correlation-id: 5c01ef95-bd91-45cd-772b-08db550d5163
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oOSq4iHMStctL8N/yVR9UYFaN2KrH5oypY8FRXfmgh4iyvqwDT8NASOBxomfE8tohCM7579mkpjLPVWDBgUezivYKq9SzMWXeJl9OT1lEaJrK4el61B7KaQmhmny9lhTZL4gwPGhhfm7cvZaQ0Wa5QFzR29ZLXlDVXLNrIZo7MHmjvc1XrMYe0ahgkExTWwLaBr9vGGOuR+YtKfl+VDGcyFcGTuwCxU+aVp3S4ODNTScTad1X5Mj9qcIlVZVhsKiU5X0/hida4Mtw/apZw5mmgibn/jBSVdNUbueS5FkUw2MYotTRFrZ32hXr+w7BkatM0Zg3QEgUtvBMnILU57Zux1Ynz2Ckv5/56FKko91S+tHqkj7i1tCCiwyKiZbp6FqrUmlZMRzOSUezPm8tMbuz5AMps2/oHEniR71+SwL5YrH5+HBa8vzzszcpFlCkLirv+b7NrNiD4BRHmqNuGTrkKwu9aTYl22Md7tE9/X0ZGWe1ix2zyh1lxxxz6qrV7gmvmOX6LHZFOmAeXrc9Zyw65DhpJsfS4QJ4qZe+jXm4h5pztQF2+NsnojhQG/IzOaMh02UZ/Vk1oNICkp3jDC2lD6Wu5jjZ9Ts/VOl3I6JXm3RGOBXTI8T16S11CwIhLTCG2WMXaqney0iI0vkrwH+Cpgwma43noGazhXRL9MyuMM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(1590799018)(1580799015)(31686004)(66556008)(6916009)(4326008)(64756008)(66446008)(66476007)(478600001)(76116006)(91956017)(66946007)(6506007)(186003)(6512007)(38070700005)(38100700002)(85182001)(83380400001)(2616005)(36756003)(8936002)(8676002)(2906002)(71200400001)(6486002)(316002)(82960400001)(122000001)(31696002)(86362001)(5660300002)(41300700001)(26005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFk1ZVlGRlFmVmtMS0V6bjZzWFZmQkdaTWd0b2ZKRXFTRTB1V3pDa1FlWEg1?=
 =?utf-8?B?L2F0ajhUUGduMmkyNEVEVG83RkhkT3l1NFlWRTR6cElRZmNaeUEwSXQwbXYy?=
 =?utf-8?B?UGRkTnFFQUdLTnc3Mnd5anNBNUF6VGtFdzdPQjlDSnZoSFpuN1VMQmVxQUhT?=
 =?utf-8?B?dDVsQzJFM3B6R0JkcEQ2UUFJV0k5dzFSdmhtR2tqbVlKV21Bb2pseEd0T05h?=
 =?utf-8?B?RkowL3B5MjNCZWJXR1hUQUNKa2txMnBwdzBWSlp0NTlPdmcwa2VJMXhsdklT?=
 =?utf-8?B?SVVRR09DbXRnR2tmOTZCQWdEalJOdkp0aE9XVFE3T3VZZEZUU0EzbitwN1VM?=
 =?utf-8?B?V3dXNUNXc0dFaEhlSUFPa3l6NW5Ud2kxdFhVQy9iUlQrak0rOUZHenBtN1Yr?=
 =?utf-8?B?TFFKeWlWNmZ4OXJFdHYzU0FLdE1mZHdiT1dwenA5bWlicitucjNuRC80aHpW?=
 =?utf-8?B?ZTRQOFMvenJPcklscUJIYjJ5eEJoV0E1bDFYNWdCM2FTV0YvZWY3QjVJSVNN?=
 =?utf-8?B?anUrZ2hqTnVWR3c5RVp3S1RTbStJQVdZbW12cHVrNlV2M200WjRFQXVhMUZE?=
 =?utf-8?B?Z2JhekdYUGJYcTNrMXJGVXVTdDJkRzlBdnBLRXlHU0UwSWhnQjBUY0ZuMHdE?=
 =?utf-8?B?bHhCNmJhSTNqalo1ejRCNGR0T2g1Rk8zbUcrYmhldzdqY1dVaVpudzc1WFJx?=
 =?utf-8?B?TjNwK3A0cFRWSXZSM0pLd21KcDRwM1dGWnNiRWhaaCtvdFF0UDNTK3NzbE5x?=
 =?utf-8?B?TW5rRGhsaEtpcEs2aWJ1dmkzNDRHeS9odHlLUzYzZEZRL2ZLT0hiUTBiRXk1?=
 =?utf-8?B?dXBhMVo0MW9oUEZyQlU2Z0VQanJzaU9jay8rMkxSL1RyYVNQS25nN2M1NnA1?=
 =?utf-8?B?ZkVuWjI0NGh0cEpRbUZ6aWU5M2xBSkNoRzJBRWJGMFp3bmtVbVF3YS9xd0pO?=
 =?utf-8?B?RGFEVHJMdDdqeW94RjlRVDZYTWxMNjNpNjcrUFZDQk84NWlpcEsyckhyM0Vl?=
 =?utf-8?B?SHd2NnQyOTI2Q0N4c054UitJZGpnK3JpSG4vUCtRdFdvNTQzcUFSQzQrSS96?=
 =?utf-8?B?ZXgvR3NqV0l3YjkzcHliVkZaTmd0eXZhVGU5RSs5OHFxeW4zZ2ZMNHl3TUZM?=
 =?utf-8?B?Y3dBMUk3TE1aN0tJSFVlRHFOc3loSXFLMnF4TkE2NVc1TE16bjlodko3VHJR?=
 =?utf-8?B?dUIwanNUYTVFc3ZnZjNXMUt0TytVK20wNWpWbjlVTlJwZXdYOFZnczdRQkps?=
 =?utf-8?B?WlpTVXM4Yk9CMllMd1hiUTVnMFZlZlgwWWdxdUhIN0Q1bm83TzhpWS9kdDds?=
 =?utf-8?B?L2M3TndYTU9YMWRkRmxtL1RvN0tUYnJjSUF1Qk1ZQmJhQnh6bGhPSVBnNVRp?=
 =?utf-8?B?bHVJekRPZWVWV1ZiRmFGVHNhc2lUWktIQ1VMSjR4S2V2UkhmOUNqUE1XRFZy?=
 =?utf-8?B?UXhqK01VTWN5ZTJiYnhQeVZJTm1tWUdzazdpSTA0S2RNM0lwVkhoOHVQbzcy?=
 =?utf-8?B?L1lJMzFiWUJXSDBXcW0zM3RNdHVKVDVWZlRQLzlwK2JhVHVKT01hdzJLUG9E?=
 =?utf-8?B?SEtzU2RaVnZqblk0cHIzOEV0K1dNajA2OCtzL3IyRXlkdXVHd1VEUXRDeUl0?=
 =?utf-8?B?WnorMEREdmtkNmdDSVhrekp5cUVXVE4xTGJHNmIrSmJnSWFpYzdZcXZ4K0lG?=
 =?utf-8?B?UTN0RHhXWEptclQvdGM5akkzVHRMZ0Ftd0wwZm82Tk0zTEhWN1hldkMxUU83?=
 =?utf-8?B?bXZuaEUzZ3dNS2NRYjBkTWpmZk5FR0NodjR3U0lMN2dZL3dWN2RTYVdTRW1N?=
 =?utf-8?B?NUZrU3NQb003QjJmcHVZaGlPVjRxZ3N1Qm82SUJMN0tudmtYd3RqbktiNG4x?=
 =?utf-8?B?Vkh2d24rK2twMFkyYXhYcGNOR1U0aTVnMGphNXZBQTk4ZXQ0azBqeXZSdzJB?=
 =?utf-8?B?VTVFOFROUUV5aFhVL0JQWFRhOHZrSjVqMmllbVA4c09HYnlnb0ZtVE9QaVVy?=
 =?utf-8?B?MFJNd1dicG56Zlhtc0NpeVErMjRmd2VMVmNIRUJZdUdIUENRM214ZUVwcnA4?=
 =?utf-8?B?dDRIaE5xbEJpam5BRFZpa3k0VEthMXVUcnRxZmtlQ0I1dktNK2l3cUwrNUJv?=
 =?utf-8?B?K1dMblkvQVFKVHRyRlBMMUcvWWhhd2tKRnI4ZFV6U2RPei91SWFXM1haVVdH?=
 =?utf-8?B?cVE9PQ==?=
Content-ID: <5C5B7DC86C54B64DB062240568D27CB8@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nTdDm6m0pVcZyIUPksvJThlRt9b3Kg8UmQ24J5JlP1wEvItaDzCz7MYzmq72sFsj7jRkSxqikBAHPrhrVwvxDQgIvN3tXxbvvZtC7zjl3dYPs1vIHS0rC1LEgfQX3n1VTrS0lafiXVfK0DtwD9sifKZdeVLUMTWJLtnnb6OFc96lZFc2QhFTuzO0/opwdgNpIe50ZoMy3qi86CUWDEnGM8G/vGfrKy6vxRNS75RDGbV+B8GIGOaHeJ5jPvt7d3BpLshbWf2/ISLp0jU0O1TE+HLSnmE+U8RrlF2I4TfYVaQoSBEswRndbxNqHeN79w5xwVBTLITs2UJdilmJJmzvcb6FRAEvF7s0rHROWW8eRgWTp+KwZWlNPs4q4lXN3eDTLg/1ejEX4p7J5qMXsBhV+mTFOAZVrolxN+rLi2PouH5f3oUXvELDXYJHz/BOtNlob62yFKz+/C7uOMvtMV2CSI65auz36nzenW2aokgEs313FKdKK65Ztx0XXdvWB5T9G6FrI0kh3o9e34COR27lXBQaGCG8eGM86swGf05D6FFefl00WRXDqIHychN3V4JXiaeRxWv7y366IXJMQBY3vhocK2XFv6ySXAKQuRAoWbddHtz19V03yU/j6+K/w59IWmZXBTcrNIMD3FISOm0lJKk6sQuzTT1/hTMwQnGzwrWvKZW7BP50f3uAC2g4MlMHkuxckkBbmazQnJUK8eL4doQ/4hjwIbDD1dhWmqKjlr/5S0s/Ob3lTsbHaySK6YSGIfNebT7edUSs4AdJ+Nm/K91vsxlgW2lNDqlqG0IgL4s=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c01ef95-bd91-45cd-772b-08db550d5163
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 06:26:29.1306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HOH2V89hsT6x0g5MT3wxCrwmWAqKP8SdYtwxMoi4HtDp+X//Wph89A7ffyI7VKusm9rqZkImm4ErRt0IrpYjnowsILTQZ4Bf4r/k99vZiJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9311
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/7] syscalls/statx01: Relax mnt_id test
 condition
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

SGkgRXJpYw0KDQoNCj4gSGkgWWFuZywNCj4gDQo+IE9uIFR1ZSwgTWF5IDA5LCAyMDIzIGF0IDA1
OjE0OjA1UE0gKzA4MDAsIFlhbmcgWHUgd3JvdGU6DQo+PiBCZWZvcmUgdGhpcyBwYXRjaCwgd2Ug
dGVzdCBzdHhfbW50X2lkIG9ubHkgd2hlbiBnbGliYydzIHN0YXR4IHN0cnVjdCBoYXMNCj4+IHRo
aXMgbWVtYmVyLiBOb3csIGlmIGdsaWJjIG1pc3MgdGhpcyBmaWxlZCwgd2Ugd2lsbCB1c2UgX19z
cGFyZTJbMF0sIHNlZQ0KPj4gdXJsWzFdLiBJZiBnbGliYyBtaXNzIHN0YXR4IHN0cnVjdCwgd2Ug
d2lsbCB1c2UgbHRwIG93bmVyIGRlZmluaXRpb24uDQo+IA0KPiBJIGRvbid0IHRoaW5rIHRoaXMg
aXMgdGhlIHJpZ2h0IGFwcHJvYWNoIGVpdGhlci4gIEFjdHVhbGx5LCB0aGlzIG5ldyBwcm9wb3Nh
bCBpcw0KPiBhcmd1YWJseSB3b3JzZSB0aGFuIGxlYXZpbmcgdGhlIHByb2JsZW0gdW5zb2x2ZWQu
ICBUaGUgcHJvYmxlbSB3aXRoIHRoaXMgbmV3DQo+IHByb3Bvc2FsIGlzIHRoYXQgdGhlIGZpZWxk
cyBpbiBzdHJ1Y3Qgc3RhdHggd2hvc2UgbmFtZXMgYXJlIHByZWZpeGVkIHdpdGgNCj4gIl9fc3Bh
cmUiIHdlcmUgbmV2ZXIgaW50ZW5kZWQgdG8gYmUgdXNlZCBkaXJlY3RseS4gIFRoZWlyIG5hbWVz
IGNhbiBjaGFuZ2UgZnJvbQ0KPiBvbmUga2VybmVsIHZlcnNpb24gdG8gdGhlIG5leHQsIGFuZCB0
aGV5IGNhbiBjaGFuZ2UgdG8gYSBkaWZmZXJlbnQgb2Zmc2V0IGFuZC9vcg0KPiBzaXplIHdoaWxl
IGtlZXBpbmcgdGhlIHNhbWUgbmFtZS4gIFRoYXQgY2FuIHJlc3VsdCBpbiBicmVha2FnZXMgdGhh
dCBvbmx5DQo+IHJlcHJvZHVjZSBvbiB2ZXJ5IHNwZWNpZmljIHZlcnNpb25zIG9mIDxzeXMvc3Rh
dC5oPi4NCj4gDQoNCk9rLCB1bmRlcnN0b29kLg0KDQo+IEFzIEkndmUgc2FpZCBzZXZlcmFsIHRp
bWVzLCB0aGUgcHJvcGVyIHdheSB0byBlbnN1cmUgdGhhdCB0aGUgdGVzdHMgY2FuIGJlIGJ1aWx0
DQo+IGV2ZW4gd2hlbiB0aGUgc3lzdGVtIHN0cnVjdCBzdGF0eCBkb2Vzbid0IGNvbnRhaW4gYWxs
IHRoZSBuZWVkZWQgZmllbGRzIGlzIHRvDQo+IHVzZSB0aGUgTFRQIHN0cnVjdCBzdGF0eCB3aGVu
ZXZlciB0aGUgc3lzdGVtIG9uZSBkb2VzIG5vdCBmdWxseSBzdWZmaWNlLg0KPiANCj4gT25lIHdh
eSB0byBkbyB0aGF0IHdvdWxkIGJlIHRvIG1ha2UgdGhlIHRlc3RzIHVzZSB0aGUgc3RydWN0IHZp
YSBhIGRpZmZlcmVudA0KPiBuYW1lLCBzdWNoIGFzIHN0cnVjdCBsdHBfc3RhdHgsIGFuZCBkZWZp
bmUgdGhhdCB0byBlaXRoZXIgdGhlIHN5c3RlbSBzdGF0eCBvcg0KPiB0aGUgTFRQIHN0YXR4IGRl
cGVuZGluZyBvbiB3aGljaCBvbmUgaGFzIHRoZSByaWdodCBkZWZpbml0aW9uLg0KDQpZZXMsIHVz
ZSBsdHBfc3RhdHggc3RydWN0IGlzIGEgYmV0dGVyIHNsb3V0aW9uLg0KDQo+IA0KPiBJdCBtaWdo
dCBhbHNvIGJlIHBvc3NpYmxlIHRvICNkZWZpbmUgc3RhdHggdG8gYWNoaWV2ZSB0aGUgc2FtZSBl
ZmZlY3QgKHRob3VnaA0KPiBtYXliZSB0aGF0IHdvdWxkIGNhdXNlIGEgY29sbGlzaW9uIHdpdGgg
dGhlIGZ1bmN0aW9uIHN0YXR4KCkuLi4pDQoNCkluZGVlZCwgaXQgd2lsbCByZXBvcnQgd2Fybmlu
ZyBhcyBiZWxvdzoNCm5vdGU6IGV4cGVjdGVkIOKAmHN0cnVjdCBzdGF0eCAqIHJlc3RyaWN04oCZ
IGJ1dCBhcmd1bWVudCBpcyBvZiB0eXBlIOKAmHN0cnVjdCANCmx0cF9zdGF0eCAq4oCZXA0KDQpJ
IGNoYW5nZSBjb2RlIGFzIGJlbG93Og0KKyNpZiAhZGVmaW5lZChIQVZFX1NUUlVDVF9TVEFUWCkg
fHwgIFwNCisgICAgIWRlZmluZWQoSEFWRV9TVFJVQ1RfU1RBVFhfTU5UX0lEKSB8fCBcDQorICAg
ICFkZWZpbmVkKEhBVkVfU1RSVUNUX1NUQVRYX1NUWF9ESU9fTUVNX0FMSUdOKQ0KK3N0cnVjdCBs
dHBfc3RhdHggew0KICAgICAgICAgLyogMHgwMCAqLw0KICAgICAgICAgdWludDMyX3QgICAgICAg
IHN0eF9tYXNrOw0KICAgICAgICAgdWludDMyX3QgICAgICAgIHN0eF9ibGtzaXplOw0KQEAgLTEw
Miw2ICsxMDQsOCBAQCBzdHJ1Y3Qgc3RhdHggew0KICAgICAgICAgdWludDY0X3QgICAgICAgIF9f
c3BhcmUzWzEyXTsNCiAgICAgICAgIC8qIDB4MTAwICovDQogIH07DQorI2Vsc2UNCisjZGVmaW5l
IGx0cF9zdGF0eCBzdGF0eDsNCg0KDQoNCj4gDQo+IEFueXdheSwgSSBkb24ndCB3YW50IHRvIGRl
cmFpbCB0aGUgU1RBVFhfRElPQUxJR04gdGVzdCB0b28gbXVjaCwgc28gaWYgeW91J3JlDQo+IGhh
dmluZyBhIGxvdCBvZiB0cm91YmxlIHNvbHZpbmcgdGhpcyBwcm9ibGVtIHByb3Blcmx5LCBJJ20g
b2theSB3aXRoIGp1c3QNCj4gYWRkaW5nIHRoZSBTVEFUWF9ESU9BTElHTiB0ZXN0IHdpdGhvdXQg
aXQgc29sdmVkIGZvciBub3cuLi4NCg0KSW4gZmFjdCwgSSBqdXN0IHdhbnQgdG8gbGVhdmUgcnVu
IG9yIG5vdCBydW4gdGhpcyBjYXNlIG9uIGdsaWJjIGhlYWRlciANCmllICBJIGRvIGluIHRlc3Rp
bmcgbW50X2lkWzFdLiBJdCBpcyBzaW1wbGUgYW5kIGNsZWFuIGFsb3VnaCBpdCB3aWxsIA0KbWlz
cyBzb21lIG92ZXJhZ2UgaWYgdXNpbmcgYSBjdXN0b20gbmV3IGtlcm5lbCBhbmQgb2xkIGdsaWJj
LiBJbiBvdGhlciANCnNpdHVhdGlvbihpZSB2YXJpb3VzIG9mZmljYWwgbGludXggZGlzdHJpYnV0
aW9ucyksIGl0IHNob3VsZCB3b3JrIHdlbGwuDQoNCg0KU28gSSB3aWxsIHNlbmQgYSB2NiB0aGF0
IHNpbXBseSBqdXN0IHVzZSAjaWZuZGVmIA0KSEFWRV9TVFJVQ1RfU1RBVFhfU1RYX0RJT19NRU1f
QUxJR04uDQoNClsxXWh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2Nv
bW1pdC8wNTc4Y2ZiM2RjMTc1NDI2YWZmNTE2MDI1YjNjYTc2MTAzZTVmNTUxDQoNCkJlc3QgUmVn
YXJkcw0KWWFuZyBYdQ0KPiANCj4gLSBFcmljCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
