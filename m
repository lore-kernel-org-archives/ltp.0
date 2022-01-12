Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D805EC433F5
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 09:24:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9EB53C94D1
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 10:24:20 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 400653C8BBB
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 10:24:11 +0100 (CET)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4E6FB20021D
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 10:24:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641979450; x=1673515450;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=kPYG/+Vdwx4rJxyxlWFTuADZM0fbm3VAT1dw6IgH6KM=;
 b=PCBFxrk/h5pHAtTcR8gX5TFsUTQglY1aojdhWlPZgU66q3278RhmPyDR
 LA1NMdNz51T1/u2VO1IucJYANZAJFF4RQ+6xQUhqJF98GlFhIGwbOv+CU
 PNK4PPEKYLydw2vJUelr47jfgQ97Ui0x8s5Y67c1TIvlMkFDMSww8ufcC
 /FAMCv1Xq0sOylsZvuEMA8X6WNSakPVec+6qcSwJMFeuIfMiraJLGhcCb
 28bLRPgEFW/MylcFDxYZanP+37YpD/N/0eq+ph91ZeNvyNxCl77ZGMqu0
 9tfz/qwOKO7yYhVXgO5kTPr+7S3Odb+xH2ZqOKuAkU15/vIis0E2rnCd/ A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="55548211"
X-IronPort-AV: E=Sophos;i="5.88,282,1635174000"; d="scan'208";a="55548211"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2022 18:24:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpIYzkIq/jxgOHOFl5nwLwtdANyXPjhoCmrJkpkvVeIdMvs42Gs4L2Cnzq2RE2ofvQfPmpglVu+n6ktp8SPTdGQhMlCxwp3nigF40oNl025YM0gA7uyG6+BVU7Pxamj0NnbpSa4DtYMD6FB3dliyjNBN/IrgKi+RB9u/pnkNxiRHLZxPjl115hUM4L5G1PyfaKFikz3W4N9VJqa/RY4gyYUDP+SH+2REZU4PA5B7SntxFaegTHgbQWwi6BYZ0qJTebcalf4w2CQnPoJdMqGScmJj0VPIPI8HJzksDWDsSbJ29NhK4WuKPAMKiuRlKI2s0490auUJY5tMKXVYiR0GnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPYG/+Vdwx4rJxyxlWFTuADZM0fbm3VAT1dw6IgH6KM=;
 b=g3lmrlASAlT57Gt4GAM7gKim21QIwSxuNcTuAhEmJ6RlvowE00v30+J9NYOOhpnAdxt0SqNJil6iMF6+OU03/wxHeiHvjBuRZeM/p4w6F5RGT8uPBXGyYGhzq4/J5sPFDXL+wQWLTPcEOVakC6vDRvCf8RukYWt7lM3HfqmCDb9+RpUsC/gIYCyz+Un87agttvgDE82GEsXCqMkszWCVjzkBCYY+cg4pECsCdTIbGZQPakn2GeWWg6T9g1ZIDm9pWLMOk+b0XFXFPPnelnHVzkKsaebHecc3jiRwsPvY7YVhdQr1zXiPXNxIpIklOcU1o+7M4fy6m/vJ3FwUosuiYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPYG/+Vdwx4rJxyxlWFTuADZM0fbm3VAT1dw6IgH6KM=;
 b=hScJowU3F/ofQPUvx5jGXw8suRW1bQq7pIISR9TuPGf89y2RjNU0vLGxBnW2NCpn6cqgzDwEvUd+gmGp9hRSdV/dzRR5Zuctp4sJbmhjIYuKpFk+xoUf3uMNKkPj6oDCL1M9bg703iRPFER6WZcTVpJ/pDwnvoxImJmpHmO6P1k=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB4363.jpnprd01.prod.outlook.com (2603:1096:404:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 09:24:04 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 09:24:04 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v4 5/6] syscalls/quotactl09: Test error when quota
 info hidden in filesystem
Thread-Index: AQHX7/Lm7zfTqdcjzkiV0fTdw8fQBqxX3LqAgAQfnQCAAIVZAIABDg+AgABD9wCAAPrbgIAAbw2AgAAPA4A=
Date: Wed, 12 Jan 2022 09:24:04 +0000
Message-ID: <61DE9E69.1040509@fujitsu.com>
References: <YY0o7jAxgIHvmczq@yuki>
 <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639380414-24390-5-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdhhTeot7Z9861B0@yuki> <61DBD6D0.1000104@fujitsu.com>
 <YdxGrO40TwVJmeWG@yuki> <61DD2937.6060609@fujitsu.com>
 <Yd1iOp2I5LrJtJDz@yuki> <61DE34A9.8010000@fujitsu.com>
 <Yd6R0Th45Y1NLqTN@yuki>
In-Reply-To: <Yd6R0Th45Y1NLqTN@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a9458ff-4960-401b-11cc-08d9d5ad470a
x-ms-traffictypediagnostic: TY2PR01MB4363:EE_
x-microsoft-antispam-prvs: <TY2PR01MB43637452790107ED78FD25A4FD529@TY2PR01MB4363.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +wkgQeVkG7xIJmsx7JrXZTRAzB9DuBJrwfqFRO6icPJbv801zsWCTMLvjzMZTPD65Hf7Ssv2i8jV33YuB1hPttxdZdqsQvwHC5ZJAtnrH5AONBL9LYHzR08aJJ2Pqq4jrEwKr/7ODsmK58fnVeIh8eOTd16IRrX/I8Lr6BE8LDTHhiUJP7Ev5Jk1YSs3V8s/3fRv1zWc5qNM1+RXuyS3Ryu+ayIqfGz2SO5rvn50SY2vqRvPceJtjLWCvtNNirL6oVtXGCwvTPU7WLR4i10t/RLd1S8xnebGEnjFeQXHSZYqN00ZA/5VRvBi0d5FwuQfUmSwwoe5RZq8gzThpRnDVSro2wpXg1tgoz74G+5I9KcApGJRSWmR+AVRRkOnRWtV/vJOn66RaqH0UN+ayITfWv7rO8cnH0I4qfoeB1v6vyXKpGIpJMSUANzK2mPw/yTmItA9f8bY717Vc+Tho+BiFxzAYNhz62ffcuO1fA/M7TVPdD/sdcdEit2gRNFHU/M9kCCrSvFhcbsiTfOkUGd1cYeD/GtlQdsYu398pfw/i980aEdCvhNGbLVFUteYfyqJWmV2kyPk5zjBwlzufkdzwvXotxJtbiDkxSeM5RkpNE2xv2Fzim+zlCFXUkI7zTZIw7Z9w6zSyG8M5YZBlUO5YzKej+ipdZ3QN80d15kfuM8G99XZzJNLHA7brZKZCdbo0vSxXX54xTvzsE2lADaydA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(82960400001)(4744005)(87266011)(15650500001)(38070700005)(6512007)(85182001)(508600001)(6486002)(91956017)(66476007)(38100700002)(6916009)(33656002)(4326008)(186003)(76116006)(26005)(6506007)(316002)(86362001)(64756008)(83380400001)(66556008)(8676002)(8936002)(2906002)(66946007)(66446008)(71200400001)(122000001)(5660300002)(36756003)(2616005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?M2Z5UTdNZnRKNG9aNlpheWRaTTU4NURBZUw3bXJQd2RadU8zMnczTDkzWGVF?=
 =?gb2312?B?SUZva2xpdXJLTXcvZ282NWlrdFVJckxJRG5XSHdZOE9GdGMxWlZwU05wUGhi?=
 =?gb2312?B?KzFJeUtKdWJjQ3lxUWcvR3VYS1FPSUpkQllvNXF3N1pHaS9SS09wdVl0TGF5?=
 =?gb2312?B?eElTc21MaVdtdjE1a2NCb3lQaXY5Q1VoWVBrbHBaZ0haRVo5RVJuVVhOdW1z?=
 =?gb2312?B?cTlBc1haOHNrTGJ4cmFpQ3BGN1pZNW9WWnFNcFZTZU15UjJJNE1pWFlIY00r?=
 =?gb2312?B?bi9ISkNJRTlBd1NJUkczM0kxS1dIN092bE1LeElBL3B1V2FLOVZVVGdQdDRv?=
 =?gb2312?B?NUx4OGZyamcwMWMzNlRnNm5CZ09HZHJSZlBqSlU5NFhUcEphYTBkSGVxVFhH?=
 =?gb2312?B?Ty80Nzl4SjFPSlg5ZExIWkhuKzhiMUxLeGJtZUlMcXkzTHNkVXljV0l0TEMv?=
 =?gb2312?B?eU1CVStkc0tMS0ZZenkwRkI0UHNMVm1UMndhMnFvUFlJV2E0bEcyR1JSbGlC?=
 =?gb2312?B?eitHRXcxZXVwMU1vV1c3UE16Q213RXpvR2hnV3pHOHZ5MGJEL0VPNTljclpm?=
 =?gb2312?B?WVprc0RrM2pWc3RGYnF5VGRRNHZtb1liVHR1TlphWjBXcExiSlBBOW9kQkVG?=
 =?gb2312?B?K3RBQUdmN2JKWTBsQ2dwVXh0Ti9sY0FGUisxRmVWV0Q3RWtaSGtZOElCTjNa?=
 =?gb2312?B?NGhJQ3o0b3crdXphamZHamxvSWtHQjduaks0bVlDYzdQQzB5b1hSOGN0S0t4?=
 =?gb2312?B?Sm5vTGNYdWJGeVNEL0l4ZHQxdXcwbUlqWmtwN0VSNUprSVpnY2ZUdnRNL3hE?=
 =?gb2312?B?YmEzSFVRZGdmRXg0ZHNrYkcvSnFycjVVYzRLVEN3cmhiejlzOFZKMGZaUmVw?=
 =?gb2312?B?VmxVZGsvMStJQWJDdWRWakxQY01kM2s1dWJ6MUxtYytIU1RPTUtJZi92NjBq?=
 =?gb2312?B?ekdmZUNJRnB1S3BzbkJrYjgyZWVHTmlDYXh1c0lUbUhuOHpGSVdHK0laZXp3?=
 =?gb2312?B?eTZHemNEY1BYRWlQeDNJZTNhYTE3S0dKdXUvbkd5SDRYTHJ3dzFSQmZRNU9w?=
 =?gb2312?B?QzFRSEhnd0M3cDU0YmM5TS9nSVgrVEJVbnk1MVVpZjVKQ0RzTWQ0Rml6cDFS?=
 =?gb2312?B?OUp2ZTg1dWlOU1p0ZTBRaHN0YjdsbkV5bHpFOUJWUS9YNFdYMDRhOUZrSEp4?=
 =?gb2312?B?bktvZ01ld2k4N2c3UzdrVVhURW1ZQmJsN2dyOERLcHZyUFhDVGtvMVZtU3Vx?=
 =?gb2312?B?LzM3NmhNOHNySlZnMHVQN2d2T0cvTzRFVkFLUmFSWHh0dHNzeU1DRmRVOUY2?=
 =?gb2312?B?L1BGSGhnZTNPUU1oTEhvaVpWR3F3VXc0ckFqTWMxTnY4MnVRS2tpVWJUVkxm?=
 =?gb2312?B?bHNlSndIMDE4MFE0VEduRDZ4eSthU0xxWWxrMi9UNFk5MEM2UmxzUjJMTzJw?=
 =?gb2312?B?bFEyTzl1Y0JaRzhqSlZ5T3BXbHJtcmpueTNDaWp5UzNpUnRLT0pTbG5KT2JW?=
 =?gb2312?B?UUpud0E0WmFqMDhNSW84dTJqRVhueVZ2Uk90cmtUbE5IU1RDc2hHQzU2UFdM?=
 =?gb2312?B?Vkw4SmZFN281UlRHUGRmTDQwQVU0OXVKV3VDcVJBY0o2anZyNmtXOUlQRGxG?=
 =?gb2312?B?UUxnRGRTQlpaSHZUaWVISE5WSTNNYit6dlkwckxTdnBvY3VNWG5QTlpCbllO?=
 =?gb2312?B?b1BVK3BtZE80c1V4aHZrSHZoQWR4ZmNuMEc2dlZGa1pQdVhlZFhmNWZ4cWlJ?=
 =?gb2312?B?d2IvRFFySWJaY0Y0VWVpMXVSU3NYNURlUnZ3ekxNTStYWWtyS010TUxQeVdh?=
 =?gb2312?B?aStMZUZoR0RtY2RDVDBFeGc4bE9ZMGs4NXFqZ3FPa1VwREV6N29tNWFTNWFP?=
 =?gb2312?B?UDl6SkFWSWg0U09taVV4UnlVK2ZFd0Zmb0trdy9jTU4yb3M4dUtRMVk4Uzl6?=
 =?gb2312?B?TVJQU3VCMTV2SjZWS0RvdElCOVdqay9vY0hPdkliK1M2VWxreE55clZXb2VY?=
 =?gb2312?B?N3lJWVJuTDV2bnF6Umt3MmgveUFnQTNlNmNoWjJZV0RaSXc5VUVsUGFnODN0?=
 =?gb2312?B?azFMVko5K1cxbWw0SWl6N2VEY2RFdFVqemlWVGFURTZjQXMzSFNBQmYydG9m?=
 =?gb2312?B?ZGhOY1A5NnozSWNqU1NNeGdoRFpvWnNDSlQ0VEx3U0hYZzBBU2JwelkzMDRD?=
 =?gb2312?B?dkxUaEpPbU1HN2tNcC8yQnVHUzBaVXB4ZW1paEROOE9WTzFVTlM0QktmUHF2?=
 =?gb2312?Q?0Ea7w/50mBm5ew+gt50odb/5hwpSsSAZPo7LLP0Z1E=3D?=
Content-ID: <BCE139F4E6EFAD4D969FC13E74123EAD@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9458ff-4960-401b-11cc-08d9d5ad470a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 09:24:04.7224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cek5XTr5jquk9hOPrGIoqM2H9XqqSn8laumUP3ujF8RJ59/XfNNn/qpW4kLCYcp/1SNKrsGR7lSrehHnfliXO2cLoI9tPfTBPnia3NuFnVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4363
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 5/6] syscalls/quotactl09: Test error when quota
 info hidden in filesystem
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

Hi Cyril
> Hi!
>>> Ah, that's what I have missed. But still, what happen if we pass fd to a
>>> regular file to the quotactl_fd()? Shouldn't we test that case too?
>> Good suggestion.
>> Yes, AFAIK, the fd point to superblock, every subcmd will check quota
>> feature bit or whether enable but return different errno.
>>
>> I will test Q_QUOTAON with regular file fd because it is the most
>> meaningful.
>
> And we can always try to pass a fd pointing to a socket, that shouldn't
> be associated with any block device at all.
Yes, my old way use external fd deponds on tmp environmet(ie use 
xfs,ext4 with quota or with quota feature) and it make test unstable.

If using socket fd, it should report ENOSYS.

Best Regards
Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
