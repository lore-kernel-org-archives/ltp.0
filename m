Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2F2EB64DC
	for <ltp@archiver.kernel.org>; Sun, 25 Jun 2023 14:47:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D890C3CD855
	for <ltp@archiver.kernel.org>; Sun, 25 Jun 2023 16:47:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CDA73C99C8
 for <ltp@lists.linux.it>; Sun, 25 Jun 2023 16:47:18 +0200 (CEST)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1DD5D6001FD
 for <ltp@lists.linux.it>; Sun, 25 Jun 2023 16:47:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1687704436; x=1719240436;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=beTuJk3134NCsJl4ymfoljgojOjq1UZhHwEhqPZEQao=;
 b=ejInIhtDh2M56/AmPslv9DI/zmKLV6RBnDy6MQH3+BhMIYFvJpnUKDe1
 GTilIr5s/EgV8NUXjdoSd+LHsmXoXS7Ze8OYrnwYVZ1Y44k5lgrgiRXt3
 ZPkxJ46HZcXwm84XdR/PVPVJ52W2/K9XTn+ypQFGEpioqlE021xIg93Lv
 o2TltjsI9ox2YfwlvdYHHQYHZ8IqftpGqNW3mjymjdLXm2/oGGj1JrIwj
 /ygOcfeWRgKK80VeWwBAWUftY9efHjk8UsvBjiuXdu1oOp8cQdBEsR8Gs
 +Dy1YO5y6YL6eQStL6qOAE09bmEG6wmgsMWPdScyx0g6Hdji9UaJCIRH7 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="88300501"
X-IronPort-AV: E=Sophos;i="6.01,157,1684767600"; d="scan'208";a="88300501"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2023 23:47:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rd59uT5CVPw4ffZFaEiFGYc2SZRkBJPTxFcd2vsMkQLBaYNgS8/BFWUE8T+8zcfQupTzxBCrlJLUHnBenjyfFfVeM/sr+Kxj9ccf5QTGA/6yLWDUHQyn1nb/mXrgxr3k/9LkZBzKCTT6xmdgtGyehQLHZYccJFhp/lpkaUj6r6a47vBO/i1qZRpIeq4e5XOwUdE5uVWA3OrZA7n6HcdtBquqVk7X/c/iDGSXv/xJ33CTEH611tu+TZD2tBPL1KkNqCTCi5OalnkLHO07gOrqOf7xPoHT0HfZeTIqGzmo7BQkSuBQPyv9ykVkFHNdRW+8Ad8+GCROmlwIHnlku8Cm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beTuJk3134NCsJl4ymfoljgojOjq1UZhHwEhqPZEQao=;
 b=JBVOI4Gay7vBW8VfJplrtxBBPYnujOkZ3GM4Gbt2zTGKyoaG1pGrAcNuT7xA7goSCQbgOPhyfOfuCAoxWdQk0OOSiIc+XEVbKSW8Alg7580qDfynYFeanUKx34mUDSFOCd79fOAKTDSA6FgGr9N+N10ZdqJt8XIHBuc7H0upwWAvwoqtEW2Ia/C0xRfEzeL75L7sVZcZqs0Boj/msePC0+2SlS7AqJIFAtwqVdbdmoUnD+aGCyodgAgAxNa2fTa1sNlrJWYYFBKU1Up2Ff/P7QfZBv3UAIyWsUkHzJVmV0txCt3wpTaIYRwdVXBsWp4JhY63hqLHf7lVp/wKPNE5HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYYPR01MB7784.jpnprd01.prod.outlook.com (2603:1096:400:115::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 14:47:08 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::9379:1cbd:8240:1716]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::9379:1cbd:8240:1716%6]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 14:47:08 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls/statx12: Add basic test for
 STATX_ATTR_MOUNT_ROOT flag
Thread-Index: AQHZjJIV6twYozJWYEO5v0CAkhASs69xkw8AgCo7nwA=
Date: Sun, 25 Jun 2023 14:47:07 +0000
Message-ID: <129fc021-4f2a-f437-63df-c4035e9b7377@fujitsu.com>
References: <1684748642-6373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230529175048.GA2021@pevik>
In-Reply-To: <20230529175048.GA2021@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYYPR01MB7784:EE_
x-ms-office365-filtering-correlation-id: e4281bbc-8b37-43c4-c82f-08db758b0ce1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CdlxQBc9e9je3z5zzChsqeJchbPeLcDrHxA45lnwcGi77H2l2iZigk7thMwX5NpdYauzirdmpwQM46MCCNx0bvkcjizNb/jJ7V0O7w1INxrOq5YJuliKKimauEtrdeEePfeFJzwnoQd9tcYGlaKAclPckPLF0h3uW1VSy6eaClFR15ASAXmUEv/Z2GBqTEz/dq6+xPlS7r9ZOWlibmxC/MvngNd6qWU2dMKH4JIFS6jI301rSQEPSSY3RhB/uivvklM9nIoIiLJIVNdLxLttwt5Bjm5B5GY5GVqcB7BRijS1NDR2HQEoxfwn4Jeda055TvjzqUne9quavrgJC0UHAa7C/pLoEI64HVmyCDMI6QMLLnvpDqZ8JUogcCFKipIFDu0chlKCQwV//A+Gc+aXheYbAemCDoJAYTjw7vIXOeZPY1UGKf12BBE/iZcGGH3WtPvWn+XXqHob6kIu5ezJReHWn4wvlh3k9d+U4H7ld5xsxcAa1Ih20HYSzRVsDTayixCOuHP48uQ6KJ/mPXQE7KZG1Qn70RjTb/AkfENo2vEJLMXvfIQjCXYdjoyv/sHOStDDxifCu0OBn2ynjOODU1bX+D/J8z4yPuiKdRy+aHwCvPwE+EsfuLhVkJoSAmv8uCFMsD9SgrUs61HqFe3s9Jp2sn5p1JBA2gUgm/Yx1l8MDuk8aOYyFi9qT5+HzasX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(1590799018)(2906002)(6486002)(71200400001)(38100700002)(2616005)(82960400001)(83380400001)(122000001)(6512007)(6506007)(26005)(186003)(41300700001)(31696002)(86362001)(38070700005)(478600001)(85182001)(316002)(36756003)(91956017)(66556008)(4326008)(76116006)(66446008)(64756008)(66946007)(6916009)(66476007)(31686004)(5660300002)(8676002)(8936002)(1580799015)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVlMUk8vZEZHWC9kTTRpRXVneUljV3k5NUFMMmltU0RPMGdRYUV5Qy90MFkv?=
 =?utf-8?B?aElFdHJCa1hCbFV6K3U3YUZVUVlVQjZhc0V4MlNNK1J5MnBkMkJ2Z3Z6Tlhm?=
 =?utf-8?B?WVhYYTRsQVZySi9IVXpNVW5xOVJoUy9kaUNUNEhiSys0cWdGaDhZaHlIVDB1?=
 =?utf-8?B?MVZjY3hyeDh1SEhmNG5pa0NqWUZOeVRQSDRiWEVkckpmYTNMRkNaTzBwVXpS?=
 =?utf-8?B?WTdNMDlnR2U3UEk1RE9NM3Q3Mk5vNXYxd3dhNklTK05KczVBTWtUOUtGeGNK?=
 =?utf-8?B?S2VTMnFWRS9BRHEyN28wckltSHBLazlVSXBRNkVhVGRCTThxVldTZCtrdURa?=
 =?utf-8?B?TGdIbHN5b0NxbWdvb0JwV2lJOEVnUEVzL1owRTNQUk8zZ2Jpelc3YWFaRklE?=
 =?utf-8?B?RnlGVWd3UjdmWG9BdE9PS3QvT1dGSDFraDd1VDlDc0pFWlNBWVUzWkJzZFRW?=
 =?utf-8?B?VGp2Zi94QVQvZVNhMzJ2S1dkOWI1SjcxZURPRWxvMlRVYlpCUDlmLzNpdy9Z?=
 =?utf-8?B?bFlLTC9pVnZIek4vdFhCN0szMlR5YzZmZ1VuT2pjZU9GQUd2VHBwNnRzU25z?=
 =?utf-8?B?V2RrWExIQkh6Ni9XMEJOcjFYeWlVMzJtRGwza2dGTWJJZm1MVWJkN3FSVzRF?=
 =?utf-8?B?ZWN4OHBHRWF2dVpxOVNzdkpMVkl6bjM1N0laRzhXWW96L3UxK1liQUNIVVZT?=
 =?utf-8?B?MFltTjJLR0JERnMveEd5ekZLUXRxeVFoU1FGUDJCaWtEK2VJbE5lNUlEKzlx?=
 =?utf-8?B?aC81azBQZjdmb2l6S3V0N0dERHZRMEVEWlIyWFJZYkF2RTR2RXIrNzVtRlVZ?=
 =?utf-8?B?V0kvQ3IyVHR3UzdTa3E5QjhENHFIa2NNRy9YTXMyRU9mYmRPalI2WFhwUURC?=
 =?utf-8?B?YzBtY1RiWjVBSnhMT3RyKzF3L1o1dTBOSjNla2Z1eWloa0VRd2VmNWxCQ280?=
 =?utf-8?B?N0I3aHNObGh5OVhlTy9FUk4wSFo3Sy82QTlUT3lERUx0YVFPWmlSa1M2aGky?=
 =?utf-8?B?MWdLQ2tickhpSnpXZnkyOFA4blYyS1Z3aHdNRWQ4allPRXliMzJ0WlorN2pB?=
 =?utf-8?B?WnNtS1p0RUw0eVQyWVpGNGRnT08vS1YvTVBsUWU4UlI2SkNaTzJtbEtPbXZv?=
 =?utf-8?B?UFpJRFNyK3ZlTDFSY2RUaHBiVitCQ3c2SU80Wi9MNmh6UVRlT1QxcUNYdlFx?=
 =?utf-8?B?K005ZVB5WW9WMjVndWg5QmxlbkJhYWh0RENnMm9WSnV4OHFobTNKUllZcXdy?=
 =?utf-8?B?akdkYVdDZWlkdk9MK1dDN0hURGorSUlhS3hVQnppd28veUhmT0xMd1BlSVRq?=
 =?utf-8?B?MDZmZys2emZRK1pEWkFWU3pLbVdULzlBMkwrdnNUOVlYQmdEWmdtTDgyVzZj?=
 =?utf-8?B?RDBnOWJtb0s4elZDc1BjRk1KMmpTaDdRRm9uSFRiZndMVkVHUkk2MUFvNjRM?=
 =?utf-8?B?bEdaK2krUk9UQk9vVHF6K2FocUw2a2dPSzFMbHVIVFgrK09ObWlIbDhhTks3?=
 =?utf-8?B?bmtzQThoNXNkdm5CUGVqRmsrZC9ZR21vTlR3VXQ4QmlXNWl6bnFrSTh5VG5J?=
 =?utf-8?B?WWw4ZUl2Z2YydWxvdmpMZEpVeFEyTjhKYzFOOFY4YjJ5cFJYaGkrd1RDaDF6?=
 =?utf-8?B?djN0dzVVQjBLZVJ5c1U2U2lRN1RXU3lFN3hxdEJqV3YzR2dTNUpPSG02blNi?=
 =?utf-8?B?elFWeGNuTVpYK2JGdzRyeXVjL1gxN0lRNHd5QjNjTWRTbnNzQnl1R2dQTGZj?=
 =?utf-8?B?OUgzaCtadEZ3eTdjQTFpVlR3UWZyNUREZUVvYXJhcWcyNk1mV1liNytOS1hw?=
 =?utf-8?B?L2xxVW9PVlZHOGZ2UFRaUnZmL0hhYmpieUhIa3A3cDQrS1NiTGNOdXgxdE56?=
 =?utf-8?B?WGh0cjVmNVpnUytyUXpIeHZkdWRSRXBtb0hjWXlzRFdHeUlZT3pIN3BmdGJa?=
 =?utf-8?B?Zll4dXZmWG5wblhUVGtNNzBML1Q3eUl3RlBFMk1zbStEUVhkWGxQWVNDYVFu?=
 =?utf-8?B?V0VVOXZ2aVFIV1pBcEhoMHV5c1ovY3g2SXphK1hHWUJhKzN1czdYa0Q2TWgx?=
 =?utf-8?B?YXpDTTVBdW0xMGZFam16bElDcjBrU3FBUFM0UlBtZmR1bUFlMnNpc1BTdEVt?=
 =?utf-8?B?Unp2ZGtuSThqRmkvQ2g5S0U2S1NteU1kWkIzQU9lUDVaeHVQZld2N2tvaWND?=
 =?utf-8?B?b1E9PQ==?=
Content-ID: <810232AB2AC07C48A4FC330691B22457@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gnLdJEy7BpI7DtmmvNEFkHVepIMzNpfvHvmzSKCxy7UBA2J5EtGQPxz35t4uNxCUIQRboDeYPyCHplY0zZVxt9iwIk2JBVqEP+Yd9DiXeqZq1PicJW4uukgb+0HdIgjuPLql46fnl3eDwsnYE5yebS7N6wFlu236FmX428t/5rgfIayu7AHbPzcUsYiLLRsP43smVg14mGEa88Zt0Hl/jo3lQILw6XIhNrTTa79xq1Y3SKWqCTh+zYiUK4xPjZcSb6/sRGgLikEllfYIhKqkWw2P7lSlhN6R660alyK5Cawuqi1XLQ/GGP6vedS3ZfPfp5/1AyGMzSoFangumB1GvFC9Cq/c69758ovUOynNlUQuM+7cxlIOszxPOoNosYeiAxDTso4xyAF0fGlUPmlcXOIBJ+m9HRT4aYZN/k4oIOjTuTbL0yfoBXJ8Rja89ov63EXKVO7PXTVlmGW8rLon3F1pWqPgXtw2+PYg3yTvoyiXTvLvyuDCSIeSUcU41VH7ZqhVTCECzf0vlDYa20um+hBlzFpd4JNwhogKrxYJkV/8FpM1SnuAYTv1Wklrbkvxe+eyXoE91tvrCWvYJSV2670AMUxXXHegZGez2Rebcvd90JZMprWo2OaXk93mxPGuaNQTkBQV/VOHU4l8YtSjD+fjW1r74yzQdNph4CKtxQpCoLDY+IjknLcFxpcn0Jxsz1IYHWaJYDInNzTdWv49YmTdxa5CYoXFAQ34MVi0FLmQ9DIPfyKSdPXUbOW9YIMMStzmAaHarzBEd1yOT5dgeObtHXNSQHq/ogqsJtE5fTk=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4281bbc-8b37-43c4-c82f-08db758b0ce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2023 14:47:07.9843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yXSGzqCpXn3cQsc5+KaK6NT4EeEZn2SQT6eYYY0oxUTv7NG7aa5q7/MAvIUSoujsU+H1ZVstIXp0O//+iC9tBVIR92v3mk3QY3AGXxettj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7784
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statx12: Add basic test for
 STATX_ATTR_MOUNT_ROOT flag
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

Hi  Petr


Thanks for you review, merged with your suggestion.

Best Regards
Yang Xu
> Hi Xu,
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Tested-by: Petr Vorel <pvorel@suse.cz>
> 
> I tested it on recent kernel 6.3.1 and very old kernel 3.16.0.
> Works as expected.
> 
> 
>> This flag was introduced since kernel 5.10 and was used to indicates
> 
> 80340fe3605c ("statx: add mount_root") was released in v5.8. Unless you refer to
> something different, please update it here.
> 
>> whether the path or fd refers to the root of a mount or not.
> 
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   include/lapi/stat.h                        |   4 +
>>   runtest/syscalls                           |   1 +
>>   testcases/kernel/syscalls/statx/.gitignore |   1 +
>>   testcases/kernel/syscalls/statx/statx12.c  | 101 +++++++++++++++++++++
>>   4 files changed, 107 insertions(+)
>>   create mode 100644 testcases/kernel/syscalls/statx/statx12.c
> 
>> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
>> index c7e6fdac0..3606c9eb0 100644
>> --- a/include/lapi/stat.h
>> +++ b/include/lapi/stat.h
>> @@ -221,6 +221,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
>>   # define STATX_ATTR_AUTOMOUNT	0x00001000
>>   #endif
> 
>> +#ifndef STATX_ATTR_MOUNT_ROOT
>> +# define STATX_ATTR_MOUNT_ROOT	0x00002000
>> +#endif
>> +
>>   #ifndef STATX_ATTR_VERITY
>>   # define STATX_ATTR_VERITY	0x00100000
>>   #endif
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index e5ad2c2f9..0c1993421 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -1767,6 +1767,7 @@ statx08 statx08
>>   statx09 statx09
>>   statx10 statx10
>>   statx11 statx11
>> +statx12 statx12
> 
>>   membarrier01 membarrier01
> 
>> diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
>> index 48ac4078b..f6a423eed 100644
>> --- a/testcases/kernel/syscalls/statx/.gitignore
>> +++ b/testcases/kernel/syscalls/statx/.gitignore
>> @@ -9,3 +9,4 @@
>>   /statx09
>>   /statx10
>>   /statx11
>> +/statx12
>> diff --git a/testcases/kernel/syscalls/statx/statx12.c b/testcases/kernel/syscalls/statx/statx12.c
>> new file mode 100644
>> index 000000000..ae6bbb1e2
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/statx/statx12.c
>> @@ -0,0 +1,101 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * It is a basic test for STATX_ATTR_MOUNT_ROOT flag.
>> + *
>> + * This flag indicates whether the path or fd refers to the root of a mount
>> + * or not.
>> + *
>> + * Minimum Linux version required is v5.10.
> And here as well.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include <sys/types.h>
>> +#include <sys/mount.h>
> Do we need these two for anything?
> 
>> +#include <unistd.h>
>> +#include <stdlib.h>
>> +#include <stdbool.h>
>> +#include <stdio.h>
>> +#include "tst_test.h"
>> +#include "lapi/stat.h"
>> +
>> +#define MNTPOINT "mntpoint"
>> +#define TESTFILE MNTPOINT"/testfile"
>> +
>> +static int dir_fd = -1, file_fd = -1;
>> +
>> +static struct tcase {
>> +	const char *path;
>> +	int mnt_root;
>> +	int flag;
> Since you're already using <stdbool.h>, mnt_root and flag could be bool.
>> +	int *fd;
>> +} tcases[] = {
>> +	{MNTPOINT, 1, 1, &dir_fd},
>> +	{MNTPOINT, 1, 0, &dir_fd},
>> +	{TESTFILE, 0, 1, &file_fd},
>> +	{TESTFILE, 0, 0, &file_fd}
> I'd even consider replacing int flag in struct with counted from n:
> 
> static struct tcase {
> 	const char *path;
> 	bool mnt_root;
> 	int *fd;
> } tcases[] = {
> 	{MNTPOINT, 1, &dir_fd},
> 	{TESTFILE, 0, &file_fd}
> };
> 
> static void verify_statx(unsigned int n)
> {
> 	struct tcase *tc = &tcases[n/2];
> 	struct statx buf;
> 	bool flag = n % 2;
> 
> 	if (flag) {
> 		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by fd",
> 				tc->path);
> 		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf));
> 	} else {
> 		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by path",
> 				tc->path);
> 
> 		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf));
> 	}
> 	...
> 
> static struct tst_test test = {
> 	...
> 	.tcnt = 2* ARRAY_SIZE(tcases)
> 
> 
>> +};
>> +
>> +static void verify_statx(unsigned int n)
>> +{
>> +	struct tcase *tc = &tcases[n];
>> +	struct statx buf;
>> +
>> +	if (tc->flag) {
>> +		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by path",
>> +				tc->path);
>> +
>> +		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf),
>> +			"statx(AT_FDCWD, %s, 0, 0, &buf)", tc->path);
> nit: I wonder if we need to duplicate the call in string, just to get tc->path,
> which we have printed in TINFO above. Wouldn't be enough just:
> 		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf));
> 
>> +	} else {
>> +		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by fd",
>> +				tc->path);
>> +		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf),
>> +			"statx(%d, "", 0, 0, &buf)", *tc->fd);
> Well, here you probably meant
> 		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf),
> 			"statx(%d, \"\", 0, 0, &buf)", *tc->fd);
> checkpatch.pl (via make check-statx12) warns about it (slightly cryptic):
> statx12.c:60: WARNING: Consecutive strings are generally better as a single string
> TODO: this is the second thing which should be fixed before merge.
> 
> But again, I'd go just for:
> 		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf));
>> +	}
>> +
>> +	if (!(buf.stx_attributes_mask & STATX_ATTR_MOUNT_ROOT)) {
>> +		tst_res(TCONF, "Filesystem does not support STATX_ATTR_MOUNT_ROOT");
>> +		return;
>> +	}
>> +
>> +	if (buf.stx_attributes & STATX_ATTR_MOUNT_ROOT) {
>> +		tst_res(tc->mnt_root ? TPASS : TFAIL,
>> +			"STATX_ATTR_MOUNT_ROOT flag is set");
>> +	} else {
>> +		tst_res(tc->mnt_root ? TFAIL : TPASS,
>> +			"STATX_ATTR_MOUNT_ROOT flag is not set");
>> +	}
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	SAFE_CREAT(TESTFILE, 0755);
>> +	dir_fd = SAFE_OPEN(MNTPOINT, O_DIRECTORY);
>> +	file_fd = SAFE_OPEN(TESTFILE, O_RDWR);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (dir_fd > -1)
>> +		SAFE_CLOSE(dir_fd);
> nit: Here could be empty line (readability).
>> +	if (file_fd > -1)
>> +		SAFE_CLOSE(file_fd);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test = verify_statx,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.mntpoint = MNTPOINT,
>> +	.mount_device = 1,
>> +	.all_filesystems = 1,
>> +	.needs_root = 1,
>> +	.tcnt = ARRAY_SIZE(tcases)
>> +};
> 
> All my suggestion (ok to ignore).
> 
> Kind regards,
> Petr
> 
> diff --git testcases/kernel/syscalls/statx/statx12.c testcases/kernel/syscalls/statx/statx12.c
> index 40367c8b1..6b76b6e49 100644
> --- testcases/kernel/syscalls/statx/statx12.c
> +++ testcases/kernel/syscalls/statx/statx12.c
> @@ -12,12 +12,10 @@
>    * This flag indicates whether the path or fd refers to the root of a mount
>    * or not.
>    *
> - * Minimum Linux version required is v5.10.
> + * Minimum Linux version required is v5.8.
>    */
>   
>   #define _GNU_SOURCE
> -#include <sys/types.h>
> -#include <sys/mount.h>
>   #include <unistd.h>
>   #include <stdlib.h>
>   #include <stdbool.h>
> @@ -32,32 +30,27 @@ static int dir_fd = -1, file_fd = -1;
>   
>   static struct tcase {
>   	const char *path;
> -	int mnt_root;
> -	int flag;
> +	bool mnt_root;
>   	int *fd;
>   } tcases[] = {
> -	{MNTPOINT, 1, 1, &dir_fd},
> -	{MNTPOINT, 1, 0, &dir_fd},
> -	{TESTFILE, 0, 1, &file_fd},
> -	{TESTFILE, 0, 0, &file_fd}
> +	{MNTPOINT, 1, &dir_fd},
> +	{TESTFILE, 0, &file_fd}
>   };
>   
>   static void verify_statx(unsigned int n)
>   {
> -	struct tcase *tc = &tcases[n];
> +	struct tcase *tc = &tcases[n/2];
>   	struct statx buf;
> +	bool flag = n % 2;
>   
> -	if (tc->flag) {
> -		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by path",
> +	if (flag) {
> +		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by fd",
>   				tc->path);
> -
> -		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf),
> -			"statx(AT_FDCWD, %s, 0, 0, &buf)", tc->path);
> +		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf));
>   	} else {
> -		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by fd",
> +		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by path",
>   				tc->path);
> -		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf),
> -			"statx(%d, "", 0, 0, &buf)", *tc->fd);
> +		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf));
>   	}
>   
>   	if (!(buf.stx_attributes_mask & STATX_ATTR_MOUNT_ROOT)) {
> @@ -85,6 +78,7 @@ static void cleanup(void)
>   {
>   	if (dir_fd > -1)
>   		SAFE_CLOSE(dir_fd);
> +
>   	if (file_fd > -1)
>   		SAFE_CLOSE(file_fd);
>   }
> @@ -97,5 +91,5 @@ static struct tst_test test = {
>   	.mount_device = 1,
>   	.all_filesystems = 1,
>   	.needs_root = 1,
> -	.tcnt = ARRAY_SIZE(tcases)
> +	.tcnt = 2* ARRAY_SIZE(tcases)
>   };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
