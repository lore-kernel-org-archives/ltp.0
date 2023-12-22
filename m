Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14618C46CD2
	for <ltp@archiver.kernel.org>; Fri, 22 Dec 2023 01:39:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B384F3CF27C
	for <ltp@archiver.kernel.org>; Fri, 22 Dec 2023 02:39:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A6063C86E4
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 02:39:35 +0100 (CET)
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com
 [216.71.158.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DE4736008E5
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 02:39:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1703209174; x=1734745174;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Vk3WSI23bl8Dg9/seYXWv7eZL2cYt/rqC0R6mJHrEsc=;
 b=p5HMbgd9XhC2K0g19AVKN4N1dHAp2xvgR9bviEfLuJ2x9JGKztJNZNsR
 MK6iZURpCu5BuM2KoP1xwqzzqtgYqqYV1xxkMqbohcahx+qWEIAp5/4pd
 B3BaW4OtqWnNaIvTUJIA3bmgqBuGlCojPwV51rPAq8H2vPtBZAScD+BfQ
 s0e0jwKQyy3E9wo+kaLTvjm+IaXiRevXCzYSgYBMdCrqsnoq6VyJ0Nf3E
 sDLxZULD5/58Ye5iSfiqw+mYRxHAKU82d+LeFM6tZe5Hj8XTGbBGTuGHM
 cfRkt+hr8c/XWCC4NWEJQrKuCj7LGZqpN4h5srqq+GUZjju9HNAm3rAvc w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="106416504"
X-IronPort-AV: E=Sophos;i="6.03,238,1694703600"; d="scan'208";a="106416504"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2023 10:39:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqJmZfMeyJ+prcI2dpmssLvyAi+7SY7hnpAYtt4yrqXdBfo/bdK549LGm2enkmY+gDeaTeFsg1iFGcPNj7S79vJkTRMFimgWZ6eIHeJp+1R3vZLT9Ylu9N3r8TahSvslHkRRP+ZlJVmqgeW4Fchznn9Zz+1rpPPL6e9n+y1kqHi/L/Z5N97xzMJVEAK3ZsE7JF8WJaHQEAj7/EfYS/Y0zxMw4gSOwoWmZkFp9vBCCAaXDboC0dz8jDH6f2BNuHlTYFJUJCRtJ9fnHDs7Fpv7GX/wo0s/qBvhYo75NqLXNjCBU6/yt7kPbkGykzfx+btxCKvkkmWaLiwt2mXaO9Zuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk3WSI23bl8Dg9/seYXWv7eZL2cYt/rqC0R6mJHrEsc=;
 b=ZaNhQTIn16WNW2N2y4JW6i2n4mFgxxNbmbyPTU0vckUr7PUgzCWq1KrKn4yulIuJCDhxKOHtx+eUF/ZzwcS/ECaq2NWOUrpdC3OsqETz7iHXs1B6P9JHUlcEeDnyA10QVX8cRqMnEUb7pIDvHIsiKq4EWq5TOAuX8fDoLvFnu3L+Ad7J1nqGdK1ZBiyfT9QNXdOOgasFHlaXGNvZCZX2AlqjauCyGoIKijMJCGEi5BTGubPe4fO5S3FKHjiO2StqoyOjVCS+UJtsLfepjU7wKFu4iV7r9fOjSLP3Q0uGCEeDVmx1hucW0ewCeRiE/0Dos7VnbPJNMwJxvT6zp5gymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYWPR01MB10742.jpnprd01.prod.outlook.com (2603:1096:400:2a6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.10; Fri, 22 Dec
 2023 01:39:26 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::6f9:cd05:b0e5:6601]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::6f9:cd05:b0e5:6601%7]) with mapi id 15.20.7135.008; Fri, 22 Dec 2023
 01:39:26 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "pvorel@suse.cz" <pvorel@suse.cz>, "liwang@redhat.com" <liwang@redhat.com>
Thread-Topic: [PATCH 2/3] syscalls/swapon03: Use get_maxswapfiles() api
 instead of hard code
Thread-Index: AQHaJ0KjX0aTZGhpdEO+jAqERyc8v7C0oN6A
Date: Fri, 22 Dec 2023 01:39:26 +0000
Message-ID: <87a13bad-bb69-4706-87c6-62836dbf5701@fujitsu.com>
References: <20231205061639.68656-1-xuyang2018.jy@fujitsu.com>
 <20231205061639.68656-2-xuyang2018.jy@fujitsu.com>
In-Reply-To: <20231205061639.68656-2-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYWPR01MB10742:EE_
x-ms-office365-filtering-correlation-id: 2910dca9-8131-42f4-b49e-08dc028ed55c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: csjatiBjKYsn9nk6qlyuIEOEVigu7nI4ZZmmTh9NcA9RmMGTzty3kBeogG6Ql5+fbbn+24NPaLvjkF70SY3/EjWnDDT1rCr4T5ngoZ8UXawSJ8g0bwadto3aN89kmaiBISp3/hK3LGFM5/bJgJ7P61v5NU4kh199NNBLLiIuc+CR6aWogn9GsEFYOkTOffU7aMx01r3PogO9+KOjMBkNxBvwnLpRaCB95ga71U0hjyw3BrDjXMGFoYYbVAyHCXUOLwf+cRMRIQFq+TtbkL9vB6tG7SAEjwym5Sho/Fx7WV19WRJRXUE360VKSnCVtwegNslXwXWqDB27FDFTXg8An24DbSBjeA5E2sDqBVGI50apu2Q7HcEYG7G55eRHtCbE4TWwSTU5Z+b8dZR0MvPybbeJvNyV2cU2L+id6KNg0omRmdiZ+oY8IBimXBS6MkXPK0A2T/o0xO/AwJ6dK6o+o9CkAKG+YwJnVTvc1yatUtFACKQmV5QEA7EIP6GpUVMgYvzM94/GmNbtwz6cuG+oSdsgbq2FFMfPpjv8U2h8setnLLyU/bOsxyArNoLfNY7naSvvbqsFnCFQDrZnPwyBINTbU2salDj0ejz+JnArTjjZjrLiGGKTKKJAXELPijBAsTTJYdVRnOv3bPe8dMOZPGcoCZVExxCgBRT8lviB8KFa27PBp98SC7SYdpOecu54b3EWgUevHeqNyIhj/T8YfrOmGiYFFlkoZYW1Xo3Hopc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1590799021)(1800799012)(1580799018)(2906002)(71200400001)(6506007)(6512007)(86362001)(31696002)(36756003)(85182001)(478600001)(82960400001)(38070700009)(122000001)(83380400001)(26005)(38100700002)(2616005)(41300700001)(5660300002)(6486002)(110136005)(91956017)(66556008)(66946007)(76116006)(8936002)(8676002)(4326008)(66476007)(66446008)(64756008)(316002)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2NwNHVtK3I2Q20yTDhOcituRkZSdElBbkZWemtMVkhFUUhrclorNllDdE1j?=
 =?utf-8?B?dHdXQ3UxTThOL0VQRDhUYnF1dVJwTXhTNFY4VTRZa1laQUpyaXNVVDNYQlV2?=
 =?utf-8?B?RWpQNE1JaXErTkFNMlBrWkVhU01oUm5XcExjM2diOUFrWjF3cVBDR3RpcHRm?=
 =?utf-8?B?bVR6L2I5RWgzMGxQaWMrbTUrL0d3NDVKak9tRmlTVVNXdmV3NkFCQms3WnNQ?=
 =?utf-8?B?eG96SUdVd2g0NHpVNG0wWGt4c3VLbzJCWmNTTEhpSVFpdHRINVptT0pzUWtj?=
 =?utf-8?B?UGMydEUwUTNUa29UeHkyNlVuTXlqU2lhLzVvRnI1ZDJqT1JvSGtrWlZ2dzBq?=
 =?utf-8?B?blJLbGt4WWNoZ0poNVJXSkg0a2h5N1lxYU4zYkNSamxOcEQ1a1RGZTdhOTRs?=
 =?utf-8?B?UjYwbFpUeUZMVTZyUHQxWXpxK28yRit3djFoekxSenpOdDhGTXNPTExxKzVH?=
 =?utf-8?B?d1pDbFlQZ2lXOHhsd0dLVk5aYTFGOWVFR1hnL3VETGpyTU56bmhReGdqdDkw?=
 =?utf-8?B?QWRNdWtGSFY3S1Y2MWw3Nkl5Qm5ya0d3ZXlhRFcxVFJhNGVvQ3hhMEpZMzdC?=
 =?utf-8?B?SFBqNDdWV1hMemdOMmJhMjlUQzNpK3V1dFVjZm1DSGtGR2RKUjJOSldOYWo3?=
 =?utf-8?B?TEEyd045anhzVUJKcGlNWjVYK1lCdVJma1RDci9XOVhlV1l6ZU02OVA4S3Zl?=
 =?utf-8?B?aWNYVFg0dGlFZnVjeXpvdVVHZTRRZERVYUM0R0YyakY5ZXlrV1BaMFV3R3A3?=
 =?utf-8?B?Mmt0MTBVVDBxRDJCSWdNRHptZGNWejNWYzFLbUo1ZU0wTk9NRTM0Um5DQ2Ux?=
 =?utf-8?B?TzltYjl4UVhDbXRMb0JxNWoxa1JBN3l3eStDeUJHOFhYUUhJYURHVFplbXRj?=
 =?utf-8?B?NTAzQzlGVHdoaytqdHIzTHRWT2VFVEpJMW9id3dTMC9vK0Q0ZnNJM2NTRVFF?=
 =?utf-8?B?dXpYL3NXL2grdWFCUkFVejlwS3RoOGtaQTRXNVB2ZmlLTkhCTGlMWVJJOWlM?=
 =?utf-8?B?NzlNS0R5aFRwQk9wdFFGYnZGQjI5L0VseFNiUjFzNjBBcXlvby9INksrZ2VV?=
 =?utf-8?B?cVZsSjNEeldsbVUvSlFGcFMralV6U2UvRHJ0Uk5aajdFaVZxcGxZVldWazlO?=
 =?utf-8?B?TVlFRWFvWGZ4SVhxK29qbzV6OVJVVXRpZ2xuVzByWjFkdlhMMzFiTmVGMmR2?=
 =?utf-8?B?WERCSitoZEFSRFBZbm9iZUoxR0ttK0lBWGd4L3paUDdOUGFRck9TMjlycFQ5?=
 =?utf-8?B?UlBUbnUxcXhPZlRZQU1SMkhnVFo4TDJKRGp3YXd2MWNuRDZWLzhZNkFLR01v?=
 =?utf-8?B?eHFRZTN1Y09sN0xabFZIa25BY052bFZMY0FPS1A0RWdPUW5kUVJ5dHFrdGgy?=
 =?utf-8?B?ZDlmTXRocEoxblZuOGFSOHd1a3JBQnIwbk9iYk54aloxRlVrb3pyMUtuS0Ex?=
 =?utf-8?B?YWhCT3pGRzlOM0kwaUUxUVgwb09pZEJVeEdlMW9RSVJLd0d6bmx2NXI3ZGdl?=
 =?utf-8?B?QzBYaWZlT0x1dm5HVnpjWWNJajRoUTVxSmF0T2dWQWZWTmVQdU9iaGhFTFZM?=
 =?utf-8?B?Q0NLSk9IT1dFcVhNRU9KZmlacVlBYVp4dStLb2R3dVozY2F5YWk4d0dOMWNQ?=
 =?utf-8?B?MW41MTRDL1ZIQys3dVBjSXJTUlR5c2djbjBnQXU1S0Z0cVc5Y0tHWGRVY1Jm?=
 =?utf-8?B?UnRxNDNHQ3dCUGNjWkJieXZqcWdvQ2YyY1JHUFgrV2Q1WUpid3FpNGErWldK?=
 =?utf-8?B?bC92VDFKcVczeTNaZHZrTVRpcGdwT0R3bFk0cXpEQU94ZGlBTzVuVm5oblNq?=
 =?utf-8?B?Rk5kMnNkMGlvZkd4TzdMVzV1M0VCT25LalBEeWc1aVNrTTFXNHpiUXZIZ1ht?=
 =?utf-8?B?b1lXMjRsN3hOZmpQR3MzUDdVKzhCL0dkZG5JbWhyRVdRKzUzWGVQTVlEak5v?=
 =?utf-8?B?cExzVDFTVjdaUjZiWHY4REJUczJRM0piNnlwSm9OeVFIUkFiZkVCMURqWTlH?=
 =?utf-8?B?WXhjczR4NWZwMklxM3ZpdmptL0JrcXZzNy8vcmRvOTFVUGZkM2hWbGlUZDZL?=
 =?utf-8?B?WitYUlpYMzUzK2hPaHN3WFh1SkkrRUtNeUYzZVA5NFMyemdOQ1I5UC9XUjAx?=
 =?utf-8?B?K1pZZEpOTlRDaHIxd2dzd2pLMi9Zc1h0WVlpZGVxWmtQS1lMUGtsR2RYaHd3?=
 =?utf-8?B?a0E9PQ==?=
Content-ID: <3895E0FDBD9B83418E24707377401EF6@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VuxNikAoVPwjjivHdZsroNA1Lua0uIh2LIvZDXMDpwk/kSYQ6lMKvm3R5jYd3NX5XGZxuiWMPCtoNgGruFHlL+Tp/VkXuaxcFGGeeet9ZtUgv4pJq9Y5yfQ9vJqdBo213Zm565HIcmw9AM8OZhVEl8C3PYS8m3FDlMzrCHh0DBsySIfg2Tu3b0vyz0Z4goSoh07QFPo/CLriLQH/z0EQJI9yXSkAGVF5fWFSHw95jYKFfj8Lwr3OVOXYAfr2JAr/84snHZEIorvniZNr3dHgGcWAfK5wu9P5pai57BSYZmxIGl7gCxAxd5GuW/nXsUJZjaxlDfRcFNt/Y4thWSYY4lJMtao5pFFfStHKpAH7FGQnJMAcjWzO1GZEEcXgAi5gWtYCVjrudKKVgkF/MCTEayQJKXA9T4X227XxJQdQE4XmvsLKNMdnHTZOZM1La3lKFGIUmNFZ6Kf3vQ9GZgeRqg22UPYMCtL5qGCQ+Rnn1bDOIYoT+D532zsKM/3B389WcUzR2zVjAjo2qENZcQMGglRY1rl0NkGp9XCzgS1wkd+QIsrS00uQAQsaaLMguUEkx8GVaHYZd8iqirx2IH/nSSztieE89JUbndd1Ac/ccm20I0Acvsw7d5I2+nVRy3FD
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2910dca9-8131-42f4-b49e-08dc028ed55c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 01:39:26.7828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qU8CB7YaKH6u+ULt6c9KQ5EnwIUAu7Ocv3q9RnOKaVqLa0HPNUYxmBOjgIS12sLvbDRLbO3ahXJ+GTnub7+g0Z7vg6+hY9S7PHEaY1VOYgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10742
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] syscalls/swapon03: Use get_maxswapfiles() api
 instead of hard code
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

SGkgTGnvvIwgUGV0cg0KDQpJIGFtIHdyaXR0aW5nIHYyIHBhdGNoIHRoYXQgaW50cm9kdWNlIGFu
b3RoZXIgbGlibHRwc3dhcCBhcGkgbmFtZWQNCmFzIGdldF91c2VkX3N3YXBmaWxlcyBsaWtlIHdl
IGRpZCBpbiBpcGMgbGlicmFyeS4NCg0KQnV0IEkgZm91bmQgbGlibHRwc3dhcCBhbmQgc3dhcG9u
L3N3YXBvZmYgY2FzZXMgYWxsIHVzZSBzd2Fwb24vc3dhcGZmIA0Kc3lzY2FsbCBkaXJlY3RseSBp
bnN0ZWFkIG9mIGdsaWJjIHdyYXBwZXIuIElNTywgb24gb2xkIGdsaWJjL290aGVyIGxpYmMgDQpk
b2Vzbid0IHN1cHBvcnQgdGhpcyB3cmFwcGVyIHNvIGl0IHVzZSBzeXNjYWxsIGRpcmVjdGx5LiBD
YW4gSSByZXBsYWNlIA0KdGhlbSBieSBnbGliYyB3cmFwcGVyIGRpcmVjdGx5Pw0KDQpCZXN0IFJl
Z2FyZHMNCllhbmcgWHUNCg0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFh1IDx4dXlhbmcyMDE4Lmp5
QGZ1aml0c3UuY29tPg0KPiAtLS0NCj4gICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBv
bi9zd2Fwb24wMy5jIHwgNDcgKysrLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgNDEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDMuYyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvc3dhcG9uL3N3YXBvbjAzLmMNCj4gaW5kZXggZGM2MzNlYmM2Li43NDRm
Y2EzZDEgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9uL3N3
YXBvbjAzLmMNCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9u
MDMuYw0KPiBAQCAtMTksMTQgKzE5LDEyIEBADQo+ICAgDQo+ICAgI2luY2x1ZGUgInRzdF90ZXN0
LmgiDQo+ICAgI2luY2x1ZGUgImxhcGkvc3lzY2FsbHMuaCINCj4gLSNpbmNsdWRlICJzd2Fwb25v
ZmYuaCINCj4gICAjaW5jbHVkZSAibGlic3dhcC5oIg0KPiAgIA0KPiAgIHN0YXRpYyBpbnQgc2V0
dXBfc3dhcCh2b2lkKTsNCj4gICBzdGF0aWMgaW50IGNsZWFuX3N3YXAodm9pZCk7DQo+ICAgc3Rh
dGljIGludCBjaGVja19hbmRfc3dhcG9mZihjb25zdCBjaGFyICpmaWxlbmFtZSk7DQo+IC0NCj4g
LXN0YXRpYyBpbnQgc3dhcGZpbGVzOw0KPiArc3RhdGljIGludCBzd2FwZmlsZXMsIG1heF9zd2Fw
ZmlsZXM7DQo+ICAgDQo+ICAgaW50IHRlc3RmaWxlcyA9IDM7DQo+ICAgc3RhdGljIHN0cnVjdCBz
d2FwX3Rlc3RmaWxlX3Qgew0KPiBAQCAtNTcsNDcgKzU1LDEzIEBAIHN0YXRpYyB2b2lkIHZlcmlm
eV9zd2Fwb24odm9pZCkNCj4gICAJCQkiKCVkKS4gU3lzdGVtIHJlYm9vdCByZWNvbW1lbmRlZC4i
LA0KPiAgIAkJCWV4cGVjdGVkX2Vycm5vKTsNCj4gICAJfSBlbHNlIHsNCj4gLQkJLyogUHJvYmFi
bHkgdGhlIHN5c3RlbSBzdXBwb3J0cyBNQVhfU1dBUEZJTEVTID4gMzAsDQo+IC0JCSAqIGxldCdz
IHRyeSB3aXRoIE1BWF9TV0FQRklMRVMgPT0gMzIgKi8NCj4gLQ0KPiAtCQkvKiBDYWxsIHN3YXBv
biBzeXMgY2FsbCBvbmNlIGFnYWluIGZvciAzMg0KPiAtCQkgKiBub3cgd2UgY2FuJ3QgcmVjZWl2
ZSBhbiBlcnJvciAqLw0KPiAtCQlURVNUKHRzdF9zeXNjYWxsKF9fTlJfc3dhcG9uLCBzd2FwX3Rl
c3RmaWxlc1sxXS5maWxlbmFtZSwgMCkpOw0KPiAtDQo+IC0JCS8qIENoZWNrIHJldHVybiBjb2Rl
IChub3cgd2UncmUgZXhwZWN0aW5nIHN1Y2Nlc3MpICovDQo+IC0JCWlmIChUU1RfUkVUIDwgMCkg
ew0KPiAtCQkJdHN0X3JlcyhURkFJTCB8IFRURVJSTk8sDQo+IC0JCQkJInN3YXBvbigyKSBnb3Qg
YW4gdW5leHBlY3RlZCBmYWlsdXJlIik7DQo+IC0JCX0gZWxzZSB7DQo+IC0JCQkvKiBDYWxsIHN3
YXBvbiBzeXMgY2FsbCBvbmNlIGFnYWluIGZvciAzMw0KPiAtCQkJICogbm93IHdlIGhhdmUgdG8g
cmVjZWl2ZSBhbiBlcnJvciAqLw0KPiAtCQkJVEVTVCh0c3Rfc3lzY2FsbChfX05SX3N3YXBvbiwg
c3dhcF90ZXN0ZmlsZXNbMl0uZmlsZW5hbWUsIDApKTsNCj4gLQ0KPiAtCQkJLyogQ2hlY2sgcmV0
dXJuIGNvZGUgKHNob3VsZCBiZSBhbiBlcnJvcikgKi8NCj4gLQkJCWlmICgoVFNUX1JFVCA9PSAt
MSkgJiYgKFRTVF9FUlIgPT0gZXhwZWN0ZWRfZXJybm8pKSB7DQo+IC0JCQkJdHN0X3JlcyhUUEFT
UywNCj4gLQkJCQkJInN3YXBvbigyKSBnb3QgZXhwZWN0ZWQgZmFpbHVyZTsiDQo+IC0JCQkJCSIg
R290IGVycm5vID0gJWQsIHByb2JhYmx5IHlvdXIiDQo+IC0JCQkJCSIgTUFYX1NXQVBGSUxFUyBp
cyAzMiIsDQo+IC0JCQkJCWV4cGVjdGVkX2Vycm5vKTsNCj4gLQkJCX0gZWxzZSB7DQo+IC0JCQkJ
dHN0X3JlcyhURkFJTCwNCj4gLQkJCQkJInN3YXBvbigyKSBmYWlsZWQgdG8gcHJvZHVjZSINCj4g
LQkJCQkJIiBleHBlY3RlZCBlcnJvcjogJWQsIGdvdCAlcy4iDQo+IC0JCQkJCSIgU3lzdGVtIHJl
Ym9vdCBhZnRlciBleGVjdXRpb24gb2YgTFRQIg0KPiAtCQkJCQkiIHRlc3Qgc3VpdGUgaXMgcmVj
b21tZW5kZWQuIiwNCj4gLQkJCQkJZXhwZWN0ZWRfZXJybm8sIHN0cmVycm9yKFRTVF9FUlIpKTsN
Cj4gLQkJCX0NCj4gLQkJfQ0KPiArCQl0c3RfcmVzKFRGQUlMLCAic3dhcG9uKDIpIHN1Y2NlZWRl
ZCB1bmV4cGVjdGVkbHkiKTsNCj4gICAJfQ0KPiAgIA0KPiAgIAlpZiAoY2xlYW5fc3dhcCgpIDwg
MCkNCj4gICAJCXRzdF9icmsoVEJST0ssICJDbGVhbnVwIGZhaWxlZCwgcXVpdHRpbmcgdGhlIHRl
c3QiKTsNCj4gICB9DQo+ICAgDQo+IC0vKg0KPiAtICogQ3JlYXRlIDMzIGFuZCBhY3RpdmF0ZSAz
MCBzd2FwZmlsZXMuDQo+IC0gKi8NCj4gICBzdGF0aWMgaW50IHNldHVwX3N3YXAodm9pZCkNCj4g
ICB7DQo+ICAgCXBpZF90IHBpZDsNCj4gQEAgLTEzOSw5ICsxMDMsMTAgQEAgc3RhdGljIGludCBz
ZXR1cF9zd2FwKHZvaWQpDQo+ICAgCQl0c3RfYnJrKFRGQUlMLCAiRmFpbGVkIHRvIGZpbmQgZXhp
c3RpbmcgbnVtYmVyIG9mIHN3YXBmaWxlcyIpOw0KPiAgIA0KPiAgIAkvKiBEZXRlcm1pbmUgaG93
IG1hbnkgbW9yZSBmaWxlcyBhcmUgdG8gYmUgY3JlYXRlZCAqLw0KPiAtCXN3YXBmaWxlcyA9IE1B
WF9TV0FQRklMRVMgLSBzd2FwZmlsZXM7DQo+IC0JaWYgKHN3YXBmaWxlcyA+IE1BWF9TV0FQRklM
RVMpDQo+IC0JCXN3YXBmaWxlcyA9IE1BWF9TV0FQRklMRVM7DQo+ICsJbWF4X3N3YXBmaWxlcyA9
IChpbnQpZ2V0X21heHN3YXBmaWxlcygpOw0KPiArCXN3YXBmaWxlcyA9IG1heF9zd2FwZmlsZXMg
LSBzd2FwZmlsZXM7DQo+ICsJaWYgKHN3YXBmaWxlcyA+IG1heF9zd2FwZmlsZXMpDQo+ICsJCXN3
YXBmaWxlcyA9IG1heF9zd2FwZmlsZXM7DQo+ICAgCXBpZCA9IFNBRkVfRk9SSygpOw0KPiAgIAlp
ZiAocGlkID09IDApIHsNCj4gICAJCS8qY3JlYXRlIGFuZCB0dXJuIG9uIHJlbWFpbmluZyBzd2Fw
ZmlsZXMgKi8KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
