Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F9FCDB47E
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 05:44:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D46A3CD3A2
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 07:44:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE3113C8866
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 07:43:50 +0200 (CEST)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 447701A00FE8
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 07:43:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697175829; x=1728711829;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=/BB6fZkxf2Jl2KCzxpxMzrU9DNnSqHhsLUDfydtHi7I=;
 b=XN7Mc6ySb9c4drzFd59KYlbw0ouVP3aITXhFbFlDeKV6zJW7uuEBy095
 Qqz4FM7UH0/WnACtJf9AOb1SX/IfKOgbal59JwJqR4HbUKO2bm8ejZ5/2
 24Zu9KBsg8m0VQxNHvzw+GnthCBwbyvYW/nGrCNmyaJ9l3CivFQ//a5Oq
 D0n5Cif4kWXLjDZsc54cvRp4D8daOkU1tdXhPIriaM5zALoyDvfqLaTnj
 1dLsKlZSu/WZ/+obcwfLaAzTEkF/JAlyj0gJH6bf1s/1B6pUSMbixa8z8
 YGmCc361BDu5wKJQC8chQa5RVQeFl4k03+M53D2uQ+DpdMPbkrCdsz4qk Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="98602072"
X-IronPort-AV: E=Sophos;i="6.03,221,1694703600"; d="scan'208";a="98602072"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 14:43:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALF2spLAz0oXJNg/tLoCZ06ad7ej3XeShrTvtz/Aab+UE7TAYp1KcnNQRSHHSlC821/X0ovSXzsc6JDzvDpITPKzpOccN41dnCgnW52YA0Y5n2QtbV9wCHtCa8xgR9hRwercWNiVD8gJ5J8BHUO6ZgUdYTaHltUGQJNAM2Nk7KXOD+PYXRIXJLmhCP2DQorBZKjo/4TtZ7vkqa69iaPVE5ZykyhSQ8+pujBbuohDVSqe022aGVQFzdHJIPXAcrNnrg07xIm+m3Sw4qChsaD7m+ZyjgR+Hmjxue7vUYUnmvjn76RgG3EN7fi/rE9JTN+g3o39N1i+dHhHuGVKWqZRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BB6fZkxf2Jl2KCzxpxMzrU9DNnSqHhsLUDfydtHi7I=;
 b=YPT43IWJcXRg/RSTqZpFsAadIRTavzpbXdxpCsUAwnMxcZatMtHUtKXz/mDTXjBE/CJeVeVrmj3EkWfHpKH96nHROcZYlfXBvdc8zQjf74McmnkhmX99WiUH0KFTtF+yoxry9rh3FcWTa7lxRFN3Fyup0VHpcKcPnsPG/KqXtPAuI0PNixVc1ek9Q5bYkbzDqeGOLvgD4W5Kbrqen0r33pkyKbhh7TnBBATqGObnyOIbC04JGIfJKU8vwGfBqUUi5NGzn7pCC1eM+7vWeg/F47RWlRnrBWFHmyB7C9TcTNmdeI8/ueXlJ+2UznufQhCViDO12X7kROBUFui58qDXqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYWPR01MB10112.jpnprd01.prod.outlook.com (2603:1096:400:1e4::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 05:43:43 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::a5d2:bd3a:8420:bd3a]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::a5d2:bd3a:8420:bd3a%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 05:43:43 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 1/3] link03: Convert docs to docparse
Thread-Index: AQHZ/DFsia34Ut00pEuW5rgsKNEt+rBF7AKAgAFMDIA=
Date: Fri, 13 Oct 2023 05:43:43 +0000
Message-ID: <807b574c-35f6-c84d-91ef-229385e8009a@fujitsu.com>
References: <1697021709-22916-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20231012095515.GA618148@pevik>
In-Reply-To: <20231012095515.GA618148@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYWPR01MB10112:EE_
x-ms-office365-filtering-correlation-id: 4d44790f-dcee-4055-7329-08dbcbaf5c90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4MwqV5AqaHhiQbEqq278gdwr+mSMU4Eb3zUgm48PSxv/GBJ62vxoRQTVV03EmPmyVr5BOKg1iY5yjtoCY1W+BrMHbj88rh799YN+TtsRUqMAedl4MJtsax4DzP1hzsuFds0m3mOX0e4STC7Wy3EYMVLDPqiOJUT98DOg3Y8rIbiUK5VvZ0lTkWb2uwfqbHvLGrD5icBai7Bfgo75GMYJblqi8ewBRrjRbLSJMmBpliyN7dlpqE8IQNlaIVnMCYwMSdaK0J4JBhru5r4bo3DN/d8aWh3AbGaLeOsf1VF1+czTHXCGD3iBT4HUDcEknQODu2vzM6PFHqcZIZnAeBHmfCZR0/vp7bj4EvQvz9LwjIp6/2k62TnFXPAHRkG4dlyts8xNg7fy6ZqDfp85xxWRp4GgXdUq94AJGqnn1Xr1NPcvCHEjpNaJz/FJCTErdXisdiNI3pKQwFx3Hpj1rIZ+Kj7LH9AjEbji/kmdZkOCbyi61etgatgsEVg0SYwjvWgDGXgIVghyV2xQDihseMgHQxZYtaakA5JqjKPdE7uYI+7HuxPxlw6B6XKGjgUPtC9g2ukio2bisboyvIvgTCYaHh5B6LyqdefDJJNWARnMr81fhUQ2fzEfAhfBHGc+6u9WMhYLmyo7cAHZkzxfx8XfSNCLFmOMq3jaPFtGuMccW4dIT9c9MqDOdHWfbsrun4HK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1590799021)(1800799009)(186009)(76116006)(66946007)(91956017)(316002)(66476007)(66556008)(66446008)(64756008)(6916009)(54906003)(31696002)(2906002)(86362001)(5660300002)(41300700001)(4326008)(8936002)(8676002)(1580799018)(36756003)(85182001)(2616005)(82960400001)(26005)(122000001)(83380400001)(71200400001)(6512007)(38100700002)(38070700005)(6506007)(31686004)(478600001)(6486002)(966005)(2004002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWFGVnA4TU9yUi80KzNRMlhVLzhaNnJjV2dBc3hZZGttN3NJMTY5YzM3by8z?=
 =?utf-8?B?bHJIbGF4WDZ6c1c4QWZmdXNYT1h2c2I0bzlXTVp2NWRPSndUcnkyYzdtWHps?=
 =?utf-8?B?SE1mTjRRQkEzS3dRUUU4RlcwM1lzTHRNdEVaMSswbGxvaGYrdVpheTBUeDhT?=
 =?utf-8?B?eEt0TVVlMnZHWldnQjllQjRlVlpWWld3WVU1aHdheU9JTW1XQzFnVHpzRUN1?=
 =?utf-8?B?a2RUbWJSWkVERlVpNHNTV1VNVlNYN04wbEQvcm1rV1hqenpiN05oVkFKYTI5?=
 =?utf-8?B?dXFDNG5YaUNhd2JvdDBRU1Vpd2paL0FXVmhuUFlrSUMvdGV4SDhuQVVFbis5?=
 =?utf-8?B?L2lGaGhkUXFtZFplb2h2UUVlWkEvaU5UKzFYbVloaUZkQUVqTkMyL2Z3MVBP?=
 =?utf-8?B?NHZpd3V6QldZQ3V2TGhKUll5NGxxWHphakNyNkFmbTVVWEhDMVhlc0pGbHQz?=
 =?utf-8?B?Qlc0TGU3TzdjWDNBN2pqSFBzV0dPbkc2NHFHOUxFaUM1V1cxUDErMnZrRDNR?=
 =?utf-8?B?MHQyQWNJY0FLby9TOTExS1JDc0pJL1krSGJLSkNXZlV3L3ZsMWZqNTBqMmFE?=
 =?utf-8?B?Vkc1QzJuNmROZDZhQVYyNmVrRzdMWlVvOEl0MkI0QjhVT2ZROExiQi9rbnow?=
 =?utf-8?B?WjRmdnl3dldETWVURWpqbU9ha3dOQkFZL2dRdmlZamYxMUxEUjRxUGxmenhW?=
 =?utf-8?B?b1ZyTmtKNXZzZmdQT2h1cS9adEVUczl5TFRSRmRvOGMzZDgrT0pWUDZ5Z2xq?=
 =?utf-8?B?YTdNM3pWc3dCMkFCcjY3cmJ2VEp1ZytRaERnb2UvbHI2TW9nWjV6QURqd2k2?=
 =?utf-8?B?enlEYzRZMWRYdVBvanl4S0ZDWGcvcDQ4M2ZKSnJmQWVhVjZzMUxuekw5cm9v?=
 =?utf-8?B?cDMxd0NRYktOUldra3BSN3F4UlRjTVR2L0JzRGcyYW9yaHN0YTdBdFljLy92?=
 =?utf-8?B?c09aVnk3NkF0YzlHYm50M1dDbzN5d1dQYzl3YWwrWlhUQVVPbE5Ob1dPSUxD?=
 =?utf-8?B?ay90M2FORG02MTlKV0tTaEhWTG1LbWNsSEdNVkxlUWhIUnRqODJhNW9nVE9v?=
 =?utf-8?B?Zlg4RzgzdFVVVy92bHNOT1Y1ZTU0WFd4S2lwK2pZN2p1b1BpUTRNbGpGKzhC?=
 =?utf-8?B?WTg4ZExkdlhZUkVPajlFbnQxK3RVeFE0UkhLK0ZwK1h2dE9DMXZvaEJuL051?=
 =?utf-8?B?SVdRbWpHbGVpeXpyTFBqNFdxLy8vNEU1NEVmUGpnRVl0ZWtoNFpmZnpPYVR5?=
 =?utf-8?B?ZmpyMWJsZk96OGd5KzlPSHI1eUlYcHEzTHRCOXJEbnFCcC84Syt0Ujl4YzNY?=
 =?utf-8?B?cVh6UUxYWVpGZklWV09qcTFlVnhMNmZYS0Q1VGttTkZwOUdTUEZqVHpqQnI2?=
 =?utf-8?B?MktFUm5DcWVQVE9UUFZsK0t6bnIySXRaU3hFa2phazlYMThURnhtUVRnQ3Z2?=
 =?utf-8?B?YTRKa2VHdXlwUytQbm9vNmF4eWVkSEVIWklSRHFiOHBOMFJZY1YyZjdQTjJF?=
 =?utf-8?B?NVdKVWlmcHBOLzUxWktFMzFQeXVPQ1N6cjZEZXpyYXNZTEl4NXZldjQvV01v?=
 =?utf-8?B?ck1PZzljVVhkVWNyWG4xL1dBNHZBMDFOQUUra3VSRGpIQXpSbkJUb1dnNVJ3?=
 =?utf-8?B?cExSS3I5YmlodVBXaHYvcXh6Y2JiYjRlQksrUmRtNTZwc3gzME5XZEtBcHVY?=
 =?utf-8?B?cFlrZ0ltNG5ab0QxNVNhRndyZVF1MjNWRTcydTBqYXZiZzIxcnRQMnNxNHN2?=
 =?utf-8?B?RjRjeVhQaDBqVHNKY056aXl4K1NiMGVrVU56RGovZnpJbTN2cGFYM3pUMFFF?=
 =?utf-8?B?ZEt5SzlPelFxbHMzYmh6czByT1l2cjgwZmF2WXZVcFVkbVdsUlVtL3JMMWh4?=
 =?utf-8?B?dEpZaU1XMVhiMm1VWjRHM2JyNi9HdHU2eUFoU1c0Ri83bzMxdVloZm84aFBV?=
 =?utf-8?B?L1hGTGQvYTU2cE5lem0zK3NmY1ErK1BBMzNCbm9MNkdGS0RhYWR6R0thSmkx?=
 =?utf-8?B?VUJVd3EzZElYMnpUa3pPbnQ1TUtGb1pPYjB3ZUdHUUVHNGxWcjIwakFyV2FY?=
 =?utf-8?B?eklLV3JTRDVPSHlmRGZTcDNlcTZYdjJmam1KT1c1OW5MbDN6aHlqdThaa3U1?=
 =?utf-8?B?QlRaRm42SHFuZVFIRmtOSGJsRUhseGNPVCtoWTV6N3Ezem5ONXNyNGhuRDJx?=
 =?utf-8?B?b2c9PQ==?=
Content-ID: <325EC09CD500894CAE7FAFD19461D79D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BqalFXi/ovpQ+bM6Ri2Je8vRc4BAih3v/icsGjPbXVLwA6HPOch68wnw8778cLv2iK4WkKiI+SDW0hVj8c6BM4FZXIjqSBqaIJuwJJvjV4NlD1tjw+89TV0vLvXlEeIJcs8ZrFs2ByvCk3wrWtMVShvp7s9pyqGCQWdtvPMyCAIqYn1kHP/sLeBQ9Jiq+hGjjgixPIec5phPOLXjKoOaAVpO8u2fr1JWn8LKZsDTUACdmhdtdRT4CghgPZ6/0jYfxVDUQ4XY85by08CAlvi6xQbYlFCQf2vuWoGvwoCf1Xli+xD1nFZwOwa9tvA0PnZLHhpQROW6j93KINcVrk42nOsg62dLpGgPIt1JF+PKM0xqhpxRCyMhMWJtwsijGexYlatmaRIg6p7tQwIAC3/vtKnDlEqzTYUlTEJUR4aFj7TRYWWf42CEWAkzdYTI0NvXH4W9fIkzSRNQxyh1oLt4PZce9HBTQegLKuiwehhH6tRuFQxB56LnGqSOs2pRk/wLAkV26jmkkYyAF/CDxFyjFnQkJEO685sObaJ/f0G3srgKSB8OWHuplT+TY87C2qRdRBgbhJG+EqoJCCgqG24wDckOvgUUc9uhz5TirCLFUPdIbHBmvtsfNCpiJw+kNaBkn4rcCYUJVqmjRkCt62RsQGOah0FvGSplJkRltCqw6QSblFziV2HlHCGfqkgPh2yvXAolPA7B9Rmk9/hI1Dwc1VRMFs7XCuscBnAHlF1PMYLTPOyGCwnQn+SEe163mQY9nV5kebXBmc1tXCtvKMMTMbkWoEMsd7QYcWEHKwVpwiI=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d44790f-dcee-4055-7329-08dbcbaf5c90
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 05:43:43.5376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 367wdCsvBgAn4cqkf0WbWtzL9SAiZYu8eq/AXIGWFAues9TmEdzOI0ats2F1Q+7rJZ6g5sw8EyKKv0W6gXRFWya5tAojDKWryJgo9FiH4QE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10112
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] link03: Convert docs to docparse
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
> Hi Xu,
>
> first, so far we did these changes during rewrite to the new C API.
> Do we really put docparse on these old tests? I would postpone it.

I agree with you, I overlooked that this is an old test.

You can postpone it, maybe in the future I will rewrite to the new C API.

>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   testcases/kernel/syscalls/link/link03.c | 41 +++++--------------------
>>   1 file changed, 7 insertions(+), 34 deletions(-)
>> diff --git a/testcases/kernel/syscalls/link/link03.c b/testcases/kernel/syscalls/link/link03.c
>> index 1f45240ae..27f8a4efe 100644
>> --- a/testcases/kernel/syscalls/link/link03.c
>> +++ b/testcases/kernel/syscalls/link/link03.c
>> @@ -1,42 +1,15 @@
>>   /*
>>    * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>> - *  AUTHOR		: Richard Logan
>> - *  CO-PILOT		: William Roske
>> + * AUTHOR		: Richard Logan
>> + * CO-PILOT		: William Roske
> Although we probably should keep these names, we're not forced to have it in
> original ugly form. How about put it as:
> * Authors: Richard Logan, William Roske
>
ok.
>>    * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
> I would also put here:
> * Copyright (c) Linux Test Project, 2001-2023
ok.
>> - *
>> - * This program is free software; you can redistribute it and/or modify it
>> - * under the terms of version 2 of the GNU General Public License as
>> - * published by the Free Software Foundation.
>> - *
>> - * This program is distributed in the hope that it would be useful, but
>> - * WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> - *
>> - * Further, this software is distributed without any warranty that it is
>> - * free of the rightful claim of any third person regarding infringement
>> - * or the like.  Any license provided herein, whether implied or
>> - * otherwise, applies only to this software file.  Patent licenses, if
>> - * any, provided herein do not apply to combinations of this program with
>> - * other software, or any other product whatsoever.
>> - *
>> - * You should have received a copy of the GNU General Public License along
>> - * with this program; if not, write the Free Software Foundation, Inc.,
>> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> - *
>> - * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
>> - * Mountain View, CA  94043, or:
>> - *
>> - * http://www.sgi.com
>> - *
>> - * For further information regarding this notice, see:
>> - *
>> - * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
>> - *
>>    */
> You removed GPL, but haven't added SPDX on a first line:
> // SPDX-License-Identifier: GPL-2.0-only
Sorry for ignoring this.
>> - /*
>> -  * Tests that link(2) succeds with creating n links.
>> -  */
>> +/*\
>> + * [Description]
>> + *
>> + * Tests that link(2) succeds with creating n links.
> s/succeds/succeeds/g
>> + */
> Kind regards,
> Petr
>
>>   #include <sys/types.h>
>>   #include <fcntl.h>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
