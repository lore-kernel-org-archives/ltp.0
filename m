Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2986FCDB482
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 10:13:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F5FA3CD3C4
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 12:13:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAAFF3C8894
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 12:13:43 +0200 (CEST)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8783C600C82
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 12:13:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697192022; x=1728728022;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=diN6qnSx9HbNaS0MRH0kkadMztmSnQvB2S6R7MULQNM=;
 b=mg9tLxEcqu2TZxO/SwwLiywaQwllIoEiD3WiSXrfMKT0dAHcLAcsYi8K
 O2gATUkpJKp7EXhH+ssLzO9M3C1xFJKjme9csO+kXm4/N732zBOptxKQw
 Wtu4pmgsN7gXnHJ7kXIU2oO5sd3AsOS4+lUQbrN56fMpNAfwpMK2eHTEm
 e4AlqY2jLm6MAq/Y+K6+JI1jPFe9AqyyMjf/skMIatme+YgNB0nJtZJz0
 VxVLRdL+FHBN1V1UgvH/9zQM3H/K+Icn2uqs0ASvTORCL5+89TRMA6xbV
 74eViNzJRmN5Fo3URKsgRMcX10kvLLaQOJ1RBMcwtR4tkVHiz8Ya9FEbL w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="12125243"
X-IronPort-AV: E=Sophos;i="6.03,221,1694703600"; d="scan'208,217";a="12125243"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 19:13:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLhX1ja9hxGwkIuhc4Z1zMPm8q7Aj8ULVhrAGf7Xd0MZ3IlwOGB9TZQGarTeF6YWWk84qg/epUQmmvG+UqK5LGlKWbsXho+dgwStpLRhPDsDfbxZg4wMOufpMc+wL0TWoZ8YJljf8cPV9uA1qyV+Htc6nFMQfnHr2MvpLE46GkU5Uyqfbw7dQuc6qAtCjn4W4HXf4yEc1Rl3OyxQuUrjOAHM6PJ8B0q8xPchkrWWAaBZoKhTkzSSkM9qk3vK3IO8YWxLzot/JyeKyLpqZbFVOoGIpVQkk5u8vTN+AJIJkKqcvdwsiQRm93al9xP2Y1c3Tq7hMSU7FnHRDC8Uz0zL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diN6qnSx9HbNaS0MRH0kkadMztmSnQvB2S6R7MULQNM=;
 b=QKT4r2ojMitPdIlYZeWVAU1H7mh5iZDVAgyT/e+x/L0iurCXpKBfmhlBOLRBrZHEdV8egUAW2wOMNM1430ibxLg9hDxMKd4A3OxTxV6qpBX1e+dXo+FIPhGWZX/OM4P/aPt0jxMmj3GRhg8fN6krYpu7EYekE8wj8BFYWRLleX9Zw0lFvbIkhNtLgGRRJjgQduQdl/ZUm3iRzbWZMVdo6nU4dUfUAA1B3iDZrF9a1TQLQ/O72crBfGJ0Dzrcl1gWvkP5kqRsnnTogWkpGypT7VZ3qiSLsw/rA62w4WzE43q6Lq/CsqvH5WOXPVBaU2kpnvc+ljVpQt94SyH7xzI9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYCPR01MB6046.jpnprd01.prod.outlook.com (2603:1096:400:49::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 10:13:27 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::a5d2:bd3a:8420:bd3a]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::a5d2:bd3a:8420:bd3a%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 10:13:27 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v2] syscalls/renameat: Remove renameat fallback
 definition
Thread-Index: AQHZ57gmN9gSFG1DwkKasxuMqoh3P7Ak1KaAgAALdICAIsxDgA==
Date: Fri, 13 Oct 2023 10:13:27 +0000
Message-ID: <d81159b5-8c88-d07e-6c24-1ecebfbbc9ab@fujitsu.com>
References: <1694770587-9502-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230921060831.GA393601@pevik>
 <TY3PR01MB10221A2B558AC0198EAB701E2FDF8A@TY3PR01MB10221.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB10221A2B558AC0198EAB701E2FDF8A@TY3PR01MB10221.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYCPR01MB6046:EE_
x-ms-office365-filtering-correlation-id: d800e025-658c-439f-5a0c-08dbcbd50afd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fY5WM1KlU8SldzFE85nBM2G+Tawb7awiQc0fvjgSLjAE9OOu5czuHM9sQMRbcO9OnAngUkaha9iK8PReMxGZIaBqRpIhUoPVDvJy02/fl0i0Um5qSw8V7GhraQOrMF6nYZtVunySDyI6SG6DYs+YhrQqDRLgAhGjRwjwzPkpMWOy0UekYJKwSAa18FWGvbWfD2VTHO1cOnSrE6kHqTKjqmtX1qwbVfFBbMw5/6/NYnKmx4NKVDA944VpMUqvrlzr8GXmCXqhU/vaHcJiOXZK1lfqw413T+6xaC6OAzLHp0GPd4ZgKS70cUDNtQTFNQlgbkdW4CyVa/ugMmvxLiSj2KMZBsfW0PkFVryJBhFs61FLxtSJnWtryB7ioNQNJX4dmbNzzsDxfdcNeBVvlgKfzy+CfdklOlTSMUqWcPSLZsFbJuO4EQLwpTMiHgeqPpJMZUvEnTooGry1tmJ3AC7MxGbdJIlEaPOrWd+/0vaKG/JUFLKNX3iC3mOFUNGyqeaJKM4tFhgwXdrHc9CGxLwEtlff/ImDmB3R6b6kUj2Lud6sDMzQDMDkbGBMuQ5vMxuEZHfv4cYweS8+TRmanY2AmvoUT8KGPAb6FoYT0E0KM72ID91wII9FTD+JL6Kg7WmBrijD8JV3OJRybMxPfvO2LBxVVuQCppFgIa22SF15W5p3hYiIP5FdlwzhFITESbn4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(1590799021)(186009)(1800799009)(64100799003)(451199024)(316002)(6486002)(478600001)(76116006)(54906003)(66446008)(64756008)(66476007)(66556008)(66946007)(6916009)(2616005)(91956017)(71200400001)(26005)(6506007)(6512007)(8936002)(8676002)(5660300002)(4326008)(4744005)(41300700001)(2906002)(86362001)(31696002)(122000001)(38100700002)(82960400001)(38070700005)(85182001)(36756003)(1580799018)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXozZTEzY1lpL0s1dTRFaWdUbHRmeDd4ejgzQkE4a1dOSkZmTklqaWtUYTBL?=
 =?utf-8?B?NW44cmZrQy9tV2VDK29zN3pBNFRqSkxYRy94N1ZHUTF0ZG1RMWtlSEcrU29G?=
 =?utf-8?B?N2krOGJabDdZT2JFZ1lTVnI2L0lGaUFCUmd4TmtObzJwRE13QjBDQzZJYndq?=
 =?utf-8?B?Zk9sOVFUQlJiZk8rU1M1TnQ1YUhxQTg5OVNWQUIxK0sxcjJBRjBoOGJ2eDlq?=
 =?utf-8?B?U2MvZWJmbHZlbkJkeStTbHBHU0xjS1JDMHk3QkxXc1llOTlISk1HREhIWHJO?=
 =?utf-8?B?VDFiRko5dUZtSGw2Y3JNMmtYM09pRXFJR2h0blR4YUgwT244Y08wSStZbDhi?=
 =?utf-8?B?dlpxYnlPZGc0ekNRT1dzSFc3QmkvKzdGT21wNHdJSSs4R2RnZTZqa2NXenp6?=
 =?utf-8?B?bzRXZGhmSnlUcWZsK0VkS2lHTE4rSVVKL3NwWUgySGR6L1duUlpFTHl5Si9p?=
 =?utf-8?B?YmFDVllxcW9IdXdkWE9XcDhuS0UyRnZzcTVzeUJzZ0Vudll5RisrQTE1RFMw?=
 =?utf-8?B?ekJwVzJVNFIwYmxmOG9KRndWMUtNNU5LRml1TjVEVTJQV21IVXdvWFNFNG5z?=
 =?utf-8?B?bmkzZlJidklRUVY5Q0JxY1NtWGppNUZQdXNVVnhZU1NHRGNDV2FqY08vQ1lk?=
 =?utf-8?B?MUFGUUVVaDNBNUoyRGluQm9XK0xwZGloTC9ocExvQUx5b3dDVE50Y1I4UnNq?=
 =?utf-8?B?NW5FdXZzUWN6emtmeDFkUVZyZG55dDlFTFFSK3FBTWVGRFJ0NHpsSlk2MGMw?=
 =?utf-8?B?REZlTTFlSTJIWTJCK0E1WHRlQUJ3Uzc3Y3VGSmlIRmhvZXhIc3hJdW04WnUv?=
 =?utf-8?B?dzFjOXJKdHpIS2FTbzhmWm1iNG5XaEtKNXJEelpTb2tKdFVhc0Y2cUJ0a05k?=
 =?utf-8?B?YVZRTVYvWGlEOXBncHp0M21oNmRjMFFGSXZEYjNuNHZ5Q0VhRFNjOTIxYjk0?=
 =?utf-8?B?V2NyU0MrakdEbm9ScjZXRUlhMDhZWm1yVjl5WnU4MmMvU3R4TnRzbDd5WkNm?=
 =?utf-8?B?V25uaHppMStKZHlENTl0dTYvcXB0bnAxR0I1azhLc0FGVG5pQUlUYThTWFZQ?=
 =?utf-8?B?eUQzUi9xR0x2Rlo1VjRyRmZvV1dFYU9zVDBqSzBTMEdnK0JBQjM4dEJwcnpY?=
 =?utf-8?B?d2djOFcrblE4YW9NMVRadklwSGljQVcvWGxpeG5GdnV0YWZOdUhJb1NwRzh4?=
 =?utf-8?B?TW1SNlgrZU16MFl2emd0TW9YcVlqREhVZVplU0c4dGVhbTN0ZmtyS2pvWHVU?=
 =?utf-8?B?ajN5VURWcWF4ZkFyRlk1eTlwQk1TWnN2UW8wVCtBVDFWTjhnSTQxcEo3SmRu?=
 =?utf-8?B?c1cyeS9vUCtXcFJqNTY3OFpWUGdWdk1HVWVSckNhYzcrWUlFajVWa1ErdGNj?=
 =?utf-8?B?emh3L1QwZHY5NW1XSWVleUNCM1lPWUVrSDB2aVloaGlLSm8wb0hGU29HL2ov?=
 =?utf-8?B?d1l0U1lrL2d5ZHZwd1lLMkJwenJHaVdTVUpwZTRqTGVWWUhCTGtjbXhoT29v?=
 =?utf-8?B?Z1oyM0s3c0V1cEVLcTlTRHVnVS96UXVxaWxzRURIeXNTM0F5ZSszSCtUaWVY?=
 =?utf-8?B?a0ZSQUk3QzB1RE9nUVcxODNPQkhmeFlBMUdmYXF4Y1EvbGUwUUNwSktOdWF1?=
 =?utf-8?B?MG55Sy8yNlBCS3VsZVBpeExoMTY4TUR4czhCcUVKdEI1QktqelJPemJiOWNC?=
 =?utf-8?B?UnRsNG1RR002bkw4SHJBbCtvUmxVUkFMeSs5dkM0R2s1dk1WOU5Wd3huZWsv?=
 =?utf-8?B?cSt2NTZSbTZjVlpzcFRtU2pwZWN2RVVpR1FiZ05YNXJDSHRnUTFUZks0clZk?=
 =?utf-8?B?YTJFTXZBMVJTcG0vcHFqRnNOMFFBUWJXNEQzSUtrVCtPSE8yUENxNW1vb29s?=
 =?utf-8?B?TlY4OTFsTEVLdmJQU2J2WE5oTkd1QzkyTk5PZmtOa0w4UFRPU3V5Y3kwTFZk?=
 =?utf-8?B?TThEb2JIS0FidW9FSWRNUzlURnpyRkw3RUc5VkJ4emlqelJOZzV5aGlHQ2VZ?=
 =?utf-8?B?OHRKcFVVQWFyd2pnMCtDcWNaTGtVSGZWeUkvUDI3dzdzK1pobFRUSzRTSDhS?=
 =?utf-8?B?ZEFvR1BXV29SQWZaWEIra244YlhlaVFsanRkaVRZM0paT05IR0RFRVRTdTJh?=
 =?utf-8?B?U2tjRFR4QVpsbjFidlVjR05IREFRR3VaWGRCbGpsQXovckR5Ui9CMXVUWTRU?=
 =?utf-8?B?anc9PQ==?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O8vR2IUEuyNURrazS7mdbGRtvbkIFgh4vVUrI2VDUus7yV/eAIevOPdlBiyuB2WG4ATEUKjahn/+vp1Yrms4sbMBO9+W0NS6ob5f5KvxHLzie5otjMn+tnx8MteDdYwRKDKK7YWbxBNBQXi3b3zcvJiayDUUAZH5tDoe3aSvbMR/ggG8Ngv/1jvOssqJYcuIrPDR9rPngVxqb3Bks911KvYk8thFJygyKGKK8JEAtWz/EFkP9c6d1IRyVm1OkqoXkpy1veIQeeZ6LW4N2NtUYeQvLYCLGA7AsC8490M5F6UlH+11AlAD0itxlC/mCG+efZBaEPuF0sBDlqwnI4Vk9aIwz8xHEAHiaOfmjtqvz5aNnA721luPZoXaRmagQMJIhu0SOBzFCAwtcOgChOniK9lnCyPpHUQVeMT2GmljW6Y0KwJ1FmxtpsbNJFh/HnEvy+Z5bX8T4j/7ZOVdkKnA5zKueRxfIx7+4e2oKn5LLLLpW5NmaBWGI+Njs0A3nqg1QxaVadL9NPUA6HJowYQzbz1Zrkk5W3GT8tcHQEBd8E/I/+DkJJOGlf5mDHTebTTno6Jk10cJGkarrs9hzk9E6SOWS05a+30cJ19/DR5Oyf1zuo5zwe+JFsTCnbXBNsHzo3o6D+jdpVJWfFW0eUNjz8pvWzFTN/xMlbwOXExpUiQ+nlK+xmxB1zPHOk24plQEZYmqfs1jgOwSnThguzDaMjOJ73fZrhqJIaChU10hoXifonPBEUTm1oLoamYqitwHVPLKGwGk9dcOqtBzRrIv/fSsb+4n1SUTfmEBpLyJ1Swd4+x4EmoIUaJBUFPEbCDc
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d800e025-658c-439f-5a0c-08dbcbd50afd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 10:13:27.5815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zx4ywmAnD+H74vW+wFU6BmxUUB0xQfIpecHl2YgKXkiW62piW8zmeggGXBsBlTgssod1T5V8GOwiv2u6zvMNN4f23m2MKulFTe9oe5AtuSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6046
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] syscalls/renameat: Remove renameat fallback
 definition
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

HI



Ping.



Best Regards

Yang Xu


Hi Petr

Thanks for your review.



Yang asked [1] also for removing entry in include/lapi/syscalls/aarch64.in and others, but I think we should keep it there.



Of course, we should ensure user still can use different variants to test function ie use glibc call or syscall(syscall_number) when they have
special aims , so I only remove these old fallback and not remove syscall number in ltp lapi/syscalls/*.in file.

Especially, these syscalls/*in files should be consistent with these libc header in file as far as possible IMO.



I'd definitely keep this till the release, but then it should be safe to remove this old fallback.


This sounds great.

Best Regards
Yang Xu



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
