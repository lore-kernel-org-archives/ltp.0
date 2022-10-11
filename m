Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E032C433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 02:41:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE5423CAE8D
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 04:41:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 237CE3C1841
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 04:41:18 +0200 (CEST)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7E1E620033D
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 04:41:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1665456077; x=1696992077;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xe5vOXTNPur0WuHAWCrEBueaZCnukSqrXV5wpw0bkPg=;
 b=mxVOSZTd/KTsCaF/pcJlzxCC31jS5wz25+1vM38nIb/QmxRu2j1xEmaf
 KLy0Or6Pi2nlIyw7Opr5dYDTDc1W/aW2l31lwlxSFTLFU7gvohNOk2+CC
 uy1KUN8lnddk6BLjoqVj8Q31qBXarA6UenuJHE8JU1WCOem2+QMqIhXw9
 iCQVrwQgRtb4YIqduwbAn6r9tYRSMn5KanFEJIBZ0vWt9E/JBiuo65dJv
 J3jIXMEx5kwcnbP9XEdibJxr5aXdcjs+B5XrEkvP7N3lE66ftpDc2Zs6+
 edzc3ul1mkDhni4TlgdjT2GQb++xDxTmKHk0t/hLLDj4dRusuRQEGHG7D Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="67362661"
X-IronPort-AV: E=Sophos;i="5.95,175,1661785200"; d="scan'208";a="67362661"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2022 11:41:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/1Ky3P1mx4898WQ4fItKYq9rmL+p3QycytVn3eZjMKIsAbQgXsbNdTVNNeGQwSRIUW6v4+aPRo/Xw6/BPqkBjgGNbJCddmCyqaYZoJWtzffGOOCRTfW2LP71IQ3wDXJn3N28cbWKMR0T9h1xcm7c0m/u54Q3bbNZD7qb5YfjCZcQ1rbAjSVqd4xVbOCup/xy/fTEWXId9JF5xq6k4NTodovpxpvF2u1e4lCnzvVEIfZD1hY/EBixcUbqsuaeOzLGnqzw6aKLQrwW+9UXEXENsxrO2VJYMGLuzAWrA2js6YpA+11WCVOiperjOHgsNl35ZZoOnYKwu0vr6djexW+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xe5vOXTNPur0WuHAWCrEBueaZCnukSqrXV5wpw0bkPg=;
 b=TSKsQp853RQNLdCqwpnLJUYGpXcB+pgRDyHSc+hjhjBp4SUlmoF9gYEai6aeKf7fcxnG/SE5RSyVHzLJetBz5rVX3MOLf5NYqEzmHjagajf4fmbG0TgWjoNPHMFVtzKFc+/g5F+K/gSA714dIcqGwbl/mZOmA6Wwjdmkzt0srZOFWym/3/3lzNKJZy55Gy4k0o2hA9wS4wx9vwZ2d52OqSM42vNkvV3aVLlLqmX9KXD8649m7zK4kYZNNZJkryNSPLn1+H4MquUiN5fwOfpie0gWSd/9Ag8xeaG3ukI6ZWcF6yLKZBlS2PZw3ZAOO2j8eoTToYPeztp0J7UngIVJWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB8280.jpnprd01.prod.outlook.com (2603:1096:400:15c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 02:41:08 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 02:41:08 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH] syscalls/prctl10: Add basic test for PR_SET/GET_TSC
Thread-Index: AQHYkSFX6b5AG7zxKEubkxpqtADr562v8L4AgFgvzoCAAQP5AA==
Date: Tue, 11 Oct 2022 02:41:08 +0000
Message-ID: <719ebd30-3b2c-0b0a-0130-09a212c141a5@fujitsu.com>
References: <1657106160-2126-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <42ff1e30-71c9-ee71-2333-48c8cce74f0f@fujitsu.com> <87a663als4.fsf@suse.de>
In-Reply-To: <87a663als4.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|TYCPR01MB8280:EE_
x-ms-office365-filtering-correlation-id: 282899af-24bd-400a-8b45-08daab320d2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WZEWE0t8/u+oXFY56kRJ/TwterHwOw6GxoY70SuIdLbDwEcMD083Bobh0hrjTvpbStc6ztWs48Q70bomArGF7Mms6wrd3yi/iKDFFGsQ5Mlq0Zs43NZt01pIbpgVtALbjaqIyCQLDcgwrUshtylLWHHGM7oV3whESTPfGO6nuD9ttarTINGMcyfZ6LK+6xnFPhf4TYA5/7R1ydfpeRb6VxvHWKNLwO0rigLJf2pW0xIjT+qJilxdCpWuJjBUB7kuEqDEoSBELqyynnXL/iBCc30H39Vfuxw4KMWwHF7zWqWjCY1b8oVnPcFUQVQW0wzmqpyFgQAsHHggsoAVfFojAIJoIQdCstOfAYb08U93W3LJdL6HeYLNrzkTxm9TCrrNU0+gcZrfp8fKGHg8/6KreQEhNSvTcLXsKtEc1cmnDUKGcyT7o7AyxpbkQ/fRvw5sakzYRZL5efS3eMfclF9K9hfsHZRAp4VS+P4/hT5XDtANS7vmTsrNHUisJHFJwzO8IOXSM3gofn4iqMP7uda0XKAA8f95QogfSaeGDokJ8ocEY6am7tjRj4RA19Jf25X7mLJfFDv+TxHRLAFEJ5SQHzHE31PlgSd/e34JSy2tclBlJZ0vsSmRFTopO270PKGA1miRmibd441iI3d/RJ4Zv8bla+sHbU5P3HpzqhXlBTNlsXbWowtn22ZPYsJHk27P+dj9KfnvaStiJKEdcrN5JO8oVD60rAEUAXDXsnTneZl3KpwCWdXHKP+iFzWtz1Cse6bFIiFJEQH2B9MStnpbwx1g/sX/P4uU721f/40fRBNFrNhAwx/e3Xpb6kySeb+1oRvXYedZYoZ5lHjvMTywfg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(1590799012)(451199015)(91956017)(6486002)(31686004)(4326008)(8676002)(83380400001)(1580799009)(82960400001)(26005)(71200400001)(31696002)(36756003)(186003)(122000001)(6512007)(38100700002)(2906002)(41300700001)(85182001)(66476007)(64756008)(66446008)(66946007)(6916009)(2616005)(86362001)(6506007)(66556008)(5660300002)(76116006)(478600001)(8936002)(38070700005)(316002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3pJK0xDM0xEKzdYLzlsZDgxdWtVT25wazVyUzFpUGtFczdMMUt3QnM1SHJy?=
 =?utf-8?B?UkRnVHpoQUFFV2dlYTN3d0pOdk1lWTVMeloyRXZpWlR5anBrRldIY0xlZ2Mz?=
 =?utf-8?B?WkFEM1Z6bWpuU1QxR3FKYUZXMjZDMnNEa0dFa0JWV0thdW5yL2V3TDVlZ2ZK?=
 =?utf-8?B?S0xEaG5NQ1NiMnlyNnV5eGtDY2VTQkR4SW9Cdm5VM2N3ZFZtcHlSSytVVDhq?=
 =?utf-8?B?Wll6YU5kNW5MbEVwM240Q05SbnRqZnY2VnczR1VsSHRFVHJRaWM3THZ3YUlo?=
 =?utf-8?B?VlBxNVJBcjlHbjBSYVg5ZXFNZWt5d0JSeFVyWndtVGxFUGpoSFJ5UUZhMzQ3?=
 =?utf-8?B?K0prVUQ4bzgwVGJEU0w3aXN2K0dxZlZDUHJOblVKUmU0elQvNmI4dFFLNzlm?=
 =?utf-8?B?RWZpVVNnVVNLQy9MaHllaTd0U1JCZVNlTHNQbXMvNXhXSmR1dTlrZnVNOGVJ?=
 =?utf-8?B?V2pqdFpPUUM3OXV5Z2RSVTdvd25CRU5UMm5IVW5iM05ISFRGeHRLVUlsT0pK?=
 =?utf-8?B?eTBJYk9mZFRKODBCd0VibTU5R1FRNzNKMWdmWUlrZnRML3dRLzRZaExDZERZ?=
 =?utf-8?B?a0FwTWlIUWtaRVFsNVlDL1JsaU9NZkF2RG9FZmFhOXE5Sy9xVFlHVE9GMThG?=
 =?utf-8?B?a3A2MDVPQ0VXcmlLWWg5ZUxvenpGcys5aXRsaDNQN1VjWTJ2VXdyRkRKZ0JT?=
 =?utf-8?B?MjFSQXNCNnV6RHp2TmRGd1M2YzdjK2xKd0h5TDJXR1MyUEdYL0dzaitVTDZl?=
 =?utf-8?B?OTl0bzZ3b1NXbDMyRmZNenk3TncwRXBCakZwT29Tck5Qd2hUNC9BZ3RWSmcv?=
 =?utf-8?B?TVdhTGg3WitBSmo4WWw0NFhaY0FIZDQxT05GSGxRbTdCN0wwb3FqbWgxZTRM?=
 =?utf-8?B?VVdYYnBwK3IyV0p3TjBjMTZJN2JOUm1mQWQwajdzQnpMOExlVGpicnVNdWts?=
 =?utf-8?B?Q1BGMmN0V3JJblh1YWk2YzF5b1NLR081VXpTenFsRmhrNmwwcUF5ckpzQkFI?=
 =?utf-8?B?SWduWFBsZHYydGtjZ1VpeVFBVkk5Q3k1ZWM4N0hQdkUxNi8vdFlGMmlvaTZq?=
 =?utf-8?B?em0zVzFyR1J1emZpaGtyb29HTzcyeGxJWmhsSERmRExkVlNPek1ZdVVYdEpH?=
 =?utf-8?B?T1pCV1F4U012WHErSlRaWmZEOCtYWkR5RXEvYTF2MThzdklxL1Qxb0RTU1dX?=
 =?utf-8?B?N2REamFENy9jZGdRV1Z3eXhYTGRtNlVMOEhTRmNUd2Q4TDRUci9nTzBaZHBr?=
 =?utf-8?B?ZndjL0E2TjJvZTc0aW1tNmFZMHhiTFZKSVlqcytmNk9wODU4eE1wWmQ3SFhn?=
 =?utf-8?B?R0RXby83N1Ywa2ZZNWZkTTVzdjBGSmNNQkgwbjBMUWVmNTA1aXRLeFVobTV1?=
 =?utf-8?B?U093UTQxRGZNKzk5TmgyY2dUL2FkZ2dYdmhSMXpydTV1dlNlcXlKbUlLeGtw?=
 =?utf-8?B?ZnI4dzVReHlxQmVRRW5nQVRpMGl2RVJDdHFuRnlmNzY0SS9RT2VsdFhyOTlM?=
 =?utf-8?B?bmw3dmc0cUZrY3k1SmRuTjRTMzNyZkErOE83VSsvQytSc3NwSkw3K082M2J6?=
 =?utf-8?B?cGZQcmpoSFdCUmxDTm91U3hBOGNKcWZtZU5XYXJ2Zll4aE5KbTg0TG1NQVJJ?=
 =?utf-8?B?SFdUcGV5c2pSMXgxMTlDb0R2dm4zUjZBdUtSTDR0M0pQOUh4b285L2FWMUJE?=
 =?utf-8?B?VlpLWVN1SktOOXpqMjA2emtIZ05DS1Iva0dUblhYNVFKOExrVWpiSnRxRGdY?=
 =?utf-8?B?UFhNV0N2aldYL0ZZT3llNVJpK0p2aHJxcC9WdEJCY1BIMU8wTkhvM0RxK1Y3?=
 =?utf-8?B?cnJ5aHFlcjRLa3ptOUY0MmZpVW9STTAzTXVSYTFTQ2VZSjZVNTFHa3ZlVzhY?=
 =?utf-8?B?NkxjZDBVeitGTVFsVHlFZXR3ZDFpL21pNDA5UFBwRXhKMzZOKzB6N0g1bzJJ?=
 =?utf-8?B?RE1WRjhWRnZIbytwQVpxSlJaRzJiVzRCcXRWYjhIMy84eThSM3phRWZ6b09N?=
 =?utf-8?B?NnJFbmh0M1ErU3c0VDJPcTdWQlkzbzF2bEZmMVFsYTdpV09QRkJDQSs4TWZm?=
 =?utf-8?B?N2lIemlBZ2hudmZQcVB0aysvd2xJUTNUWEcrNjBNbXk5Wml3djBoMnJOdFZx?=
 =?utf-8?B?bHNKOEJYekcwWjFpck50UWNJZGJGemlpMVlrMUt4cnNndVg5ZWcwKzFLcHRF?=
 =?utf-8?B?VVE9PQ==?=
Content-ID: <73E2649E375A0546978846661E710719@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282899af-24bd-400a-8b45-08daab320d2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 02:41:08.3328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X092CXqQOYPGXZzyPg26E2Y9aelHUZG5lJwnGnbEphyFtkTya3zKvGu5TsrTR/PO4DYEfpx8S7g8lJp+P190pHXumkzcTnyRnU5xud8w/fM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8280
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/prctl10: Add basic test for
 PR_SET/GET_TSC
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

Hi Richard


I will accept these comment and send a v2.


Best Regards
Yang Xu
> Hello,
> 
> "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com> writes:
> 
>> Hi All
>>
>> Any comment?
> 
> Ah, yes, better late than never.
> 
>>
>> Best Regards
>> Yang Xu
>>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>>> ---
>>>    include/lapi/prctl.h                       |   7 ++
>>>    runtest/syscalls                           |   1 +
>>>    testcases/kernel/syscalls/prctl/.gitignore |   1 +
>>>    testcases/kernel/syscalls/prctl/prctl10.c  | 112 +++++++++++++++++++++
>>>    4 files changed, 121 insertions(+)
>>>    create mode 100644 testcases/kernel/syscalls/prctl/prctl10.c
>>>
>>> diff --git a/include/lapi/prctl.h b/include/lapi/prctl.h
>>> index fa5922231..8d3ef5c32 100644
>>> --- a/include/lapi/prctl.h
>>> +++ b/include/lapi/prctl.h
>>> @@ -19,6 +19,13 @@
>>>    # define PR_SET_SECCOMP  22
>>>    #endif
>>>    
>>> +#ifndef PR_SET_TSC
>>> +# define PR_GET_TSC 25
>>> +# define PR_SET_TSC 26
>>> +# define PR_TSC_ENABLE  1
>>> +# define PR_TSC_SIGSEGV 2
>>> +#endif
>>> +
>>>    #ifndef PR_SET_TIMERSLACK
>>>    # define PR_SET_TIMERSLACK 29
>>>    # define PR_GET_TIMERSLACK 30
>>> diff --git a/runtest/syscalls b/runtest/syscalls
>>> index 36fc50aeb..a0935821a 100644
>>> --- a/runtest/syscalls
>>> +++ b/runtest/syscalls
>>> @@ -1004,6 +1004,7 @@ prctl06 prctl06
>>>    prctl07 prctl07
>>>    prctl08 prctl08
>>>    prctl09 prctl09
>>> +prctl10 prctl10
>>>    
>>>    pread01 pread01
>>>    pread01_64 pread01_64
>>> diff --git a/testcases/kernel/syscalls/prctl/.gitignore b/testcases/kernel/syscalls/prctl/.gitignore
>>> index 0f2c9b194..50ee4bf60 100644
>>> --- a/testcases/kernel/syscalls/prctl/.gitignore
>>> +++ b/testcases/kernel/syscalls/prctl/.gitignore
>>> @@ -8,3 +8,4 @@
>>>    /prctl07
>>>    /prctl08
>>>    /prctl09
>>> +/prctl10
>>> diff --git a/testcases/kernel/syscalls/prctl/prctl10.c b/testcases/kernel/syscalls/prctl/prctl10.c
>>> new file mode 100644
>>> index 000000000..1b6791679
>>> --- /dev/null
>>> +++ b/testcases/kernel/syscalls/prctl/prctl10.c
>>> @@ -0,0 +1,112 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
>>> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
>>> + */
>>> +
>>> +/*\
>>> + * [Description]
>>> + *
>>> + * Basic test to test behaviour of PR_GET_TSC and PR_SET_TSC.
>>> + *
>>> + * Set the state of the flag determining whether the timestamp counter can
>>> + * be read by the process.
>>> + *
>>> + * - Pass PR_TSC_ENABLE to arg2 to allow it to be read.
>>> + * - Pass PR_TSC_SIGSEGV to arg2 to generate a SIGSEGV when reading TSC.
>>> + */
>>> +
>>> +#include <sys/prctl.h>
>>> +#include <string.h>
>>> +#include <stdio.h>
>>> +#include <setjmp.h>
>>> +#include "tst_test.h"
>>> +#include "lapi/prctl.h"
>>> +
>>> +#define TCASE_ENTRY(tsc_read_stat) { .name = #tsc_read_stat, .read_stat = tsc_read_stat}
>>> +
>>> +static int pass;
>>> +static sigjmp_buf env;
>>> +
>>> +static const char *tsc_read_stat_names[] = {
>>> +	[0] = "[not set]",
>>> +	[PR_TSC_ENABLE] = "PR_TSC_ENABLE",
>>> +	[PR_TSC_SIGSEGV] = "PR_TSC_SIGSEGV",
>>> +};
>>> +
>>> +static struct tcase {
>>> +	char *name;
>>> +	int read_stat;
>>> +} tcases[] = {
>>> +	TCASE_ENTRY(PR_TSC_ENABLE),
>>> +	TCASE_ENTRY(PR_TSC_SIGSEGV)
>>> +};
>>> +
>>> +static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
>>> +{
>>> +	pass = 1;
>>> +	TST_EXP_PASS_SILENT(prctl(PR_SET_TSC, PR_TSC_ENABLE));
>>> +	siglongjmp(env, 1);
>>> +}
>>> +
>>> +static uint64_t rdtsc(void)
>>> +{
>>> +	uint32_t lo, hi;
>>> +	/* We cannot use "=A", since this would use %rax on x86_64 */
>>> +	__asm__ __volatile__ ("rdtsc" : "=a" (lo), "=d" (hi));
>>> +	return (uint64_t)hi << 32 | lo;
>>> +}
>>> +
>>> +static void verify_prctl(unsigned int n)
>>> +{
>>> +	struct tcase *tc = &tcases[n];
>>> +	unsigned long long time1, time2;
>>> +	int tsc_val = 0;
>>> +
>>> +	TST_EXP_PASS_SILENT(prctl(PR_SET_TSC, tc->read_stat));
>>> +	TST_EXP_PASS_SILENT(prctl(PR_GET_TSC, &tsc_val));
>>> +	if (tsc_val == tc->read_stat)
>>> +		tst_res(TPASS, "current state is %s(%d)",
>>> +				tc->name, tc->read_stat);
>>> +	else
>>> +		tst_res(TFAIL, "current state is %s(%d), expect %s(%d)",
>>> +				tsc_read_stat_names[tsc_val], tsc_val, tc->name, tc->read_stat);
>>> +
>>> +	if (tc->read_stat == PR_TSC_SIGSEGV) {
>>> +		if (sigsetjmp(env, 1) == 0)
>>> +			rdtsc();
> 
> I think that because rdtsc is volatile, the load of 'pass' won't be
> moved before it by the compiler. OTOH pass itself is not marked volatile and we
> are relying on the compiler infering that it is volatile from the signal
> handler instead of assuming it is 0.
> 
> To be on the safe side we could mark pass as volatile or use the atomic
> functions. However see below.
> 
>>> +
>>> +		if (pass)
>>> +			tst_res(TPASS,
>>> +				"get SIGSEGV signal under PR_TSC_SIGSEGV situation");
>>> +		else
>>> +			tst_res(TFAIL,
>>> +				"don't get SIGSEGV signal under PR_TSC_SIGSEGV situation");
>>> +		pass = 0;
>>> +	}
>>> +
>>> +	time1 = rdtsc();
>>> +	time2 = rdtsc();
>>> +	if (time2 > time1)
>>> +		tst_res(TPASS, "rdtsc works correctly, %lld ->%lld",
>>> +			time1, time2);
>>> +	else
>>> +		tst_res(TFAIL, "rdtsc works incorrectly, %lld ->%lld",
>>> +			time1, time2);
>>> +}
>>> +
>>> +static void setup(void)
>>> +{
>>> +	SAFE_SIGNAL(SIGSEGV, sighandler);
> 
> So if we segfault for any other reason some wierd stuff could
> happen. Wouldn't it be easier to fork a child process and check if it is
> killed by SIGSEGV?
> 
> It would be easier for me to reason about at least.
> 
>>> +}
>>> +
>>> +static struct tst_test test = {
>>> +	.setup = setup,
>>> +	.test = verify_prctl,
>>> +	.tcnt = ARRAY_SIZE(tcases),
>>> +	.supported_archs = (const char *const []) {
>>> +		"x86",
>>> +		"x86_64",
>>> +		NULL
>>> +	},
>>> +};
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
