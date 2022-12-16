Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D46C4332F
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 09:12:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E70503CBC30
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 10:12:00 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D0833CBC08
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 10:11:51 +0100 (CET)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 35B021A00FB5
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 10:11:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1671181910; x=1702717910;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ofTHTrEixbSoegqzJrULKpvFbIPtJy537h9NlYmzyMQ=;
 b=W3A5JwC/l553CCpzYJtW5RYuaTAUWaqXKgoHv4BeugBH/gYK1DW92kag
 W0rakOl1QBvPClRWKJ3/NLYFOOJmA2WljUUZK7XzTi+MsYkuLnjF93iTu
 ZbmgXjG38istTcgj3hP5M70kqpgqVudVyg7ofzFhvsb7hxZTKyrt6bCzn
 E7ny4oEFWEHhiE/Hq53fTYIIBBz7myN8pIaQCCjqLR/ksAqqucHTCDyLL
 Yd8GxDp/aPnyJZvQC/gXx2JcWGcRJy1KuuNtGUOLcmOKPhc6JuPzVDSi3
 glTPY0poW5koC+Xmz8uhJHHhmYZmO5Wf8lFnsFB2BGxY5AlipagYq1VmD w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="72827935"
X-IronPort-AV: E=Sophos;i="5.96,249,1665414000"; d="scan'208";a="72827935"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2022 18:11:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6z8tqAe3CA2mCOW/OVILaqPUb9pFv5kXZ6RpBwHJIya00FFg5Bjq2YNnmQQXzX3WoLOR4rKb9ISkb1mRJiXUlKqvK2BFT+Dv+6P8zHR92V75VnKUobriC1OhA1I3qku05pt0Boo7Ru5ron0aSdQDJsLEuu6OdqzviG5DQxB+esvZ45w1u5kBti83SJ3X7/Iw4GbuZ3jpsK819521NlkR0n0JKbg6DXf8FNpHf+zGO5FXcykAdJa7Ob2ZhbfUOilIzZPzD9VySqCFTJVTl6OZj/V3S9qZbUPSzgEd1g57bUmx5htcbuDOUDugqQeNi+okGVNkGR3tkCYwQ6tItAE3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofTHTrEixbSoegqzJrULKpvFbIPtJy537h9NlYmzyMQ=;
 b=MJhp2FLL6d/Q+2E4FgUtRIUdwiVtdGFs42GVXItY3wKeoH3YW9Yvo5hrFjXfT3jeBfCrmAofNvnJabfRJxBEaAUvQ4CxzaL5Rc2eIUYtNjuWJ9LQLYFuBPK2prSw3OgCbJKU93qLIcM+KLkSwKW8NUk/vRPo64AD8upoYUUmQlaHaKJE6vXEwQ9GjyLYk7UwrJ+dAyTTHbHefHAe6lcJbNapCBfDD9YN8cHEb6/aHVYwcEtWDvxvOVmk9CFCjZZq4gWHPUzIejxGh7GeyvtnVFzkow4OYBXi7dFIBmIDcZOQtv2c1uOMfDy7B6ZHjJiOG8w67KqkJ64xNmz3EOLb/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OSYPR01MB5494.jpnprd01.prod.outlook.com (2603:1096:604:8a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Fri, 16 Dec
 2022 09:11:44 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%6]) with mapi id 15.20.5924.015; Fri, 16 Dec 2022
 09:11:44 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v3 3/7] cgroup_regression_test.sh: Remove obselte
 test_6
Thread-Index: AQHZEQMTgmW37f4+t02m2lZ1N0iMv65wOB4AgAAT0oA=
Date: Fri, 16 Dec 2022 09:11:44 +0000
Message-ID: <ac355bae-ae8f-811d-ff18-24534cf94031@fujitsu.com>
References: <1671166923-2173-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1671166923-2173-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <Y5w0DtP9yETeJl2T@pevik>
In-Reply-To: <Y5w0DtP9yETeJl2T@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OSYPR01MB5494:EE_
x-ms-office365-filtering-correlation-id: 145c267b-a81e-4a64-c2dc-08dadf458d99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TWn+EJIYUPPGE68IuuNDOm71qdUf6X3UWvZkA5pOe4fZtF/j924xUQYzsCwIGJqxu+USbcrOU7zNe/VqDU/SsjM+EGexlFti4yUJ72hDKWluM3nETFLZGBVxrUjP89d0/CdKfW4LyL/3gd7qeKyDk4oUmAFrPW5H4xM8beix076WsvhR/KRpe5eDTy6tLnaat3gJN0aqLNzj93I2K6Hnvn/tRnL/EjgHValp1DM2yToGk4A/J7x/Jb17RSvpabe6o2aPm3//l5cs/s3h79cRTTsrPioIqznpcu0IULWdj4vgo3fAB9pcfdaWO+tEcBKjd19bzSqrvyOty+4nlhnOa6N+77w81ewoFDENorf3jyukaVTjgkwDjiY5s1o4tS+2cnWDyQdBocdC/NBu/Qsn7g1BekM3x7RcVjxuqCHZ7rdBMZXp7H1bRiREOJFzzTkEmL2uRSCsf4bCziUmcEjFPqcsxw+SC6rhxoYrliWdJsr+Rsd4HFWw7QLxwjbb3w1dfZGemWoSc4/EofqzURl8qw924Xsz1bZUY9jeH0ht8ioB0lAbsluw9r61La5E3c96IWRtK3mi2R5PzTBDKp9Ol+Fb/X+jefMfV5PiZ1QVMlLPrTfqUWhnsBfvy6IA7IIBs02hvt5UUNPG0OjKaA53OZOABUmgQAvr3OpKMUUygDBNES1ILZiHtUsIUAGotlotoY0KSr7sTPajQ3fbivFt5ZWLhKbKPvJsCD8ps8g4WPokLX2xcgEQGWuOPTE9fQwxRMBg5UY6GouSthNNLjpd4GjDng5wln58G7foY/p7ROM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(1590799012)(451199015)(316002)(38070700005)(2906002)(66446008)(6486002)(478600001)(82960400001)(6916009)(122000001)(41300700001)(1580799009)(86362001)(31696002)(38100700002)(66946007)(66476007)(66556008)(6506007)(76116006)(5660300002)(186003)(26005)(64756008)(6512007)(71200400001)(8936002)(31686004)(36756003)(83380400001)(85182001)(4326008)(2616005)(8676002)(91956017)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1Q3WFlaNExDdVRLNXdDb2J6c3IrVXZiUWJtYzBpQjZKYTRrVzZOcmwxTkhF?=
 =?utf-8?B?Ym9aYWt6MmxWT2ZwOE8yOUlYZDVMRC90NVh5RG40MUsxYmoxbkM0N0pBMDFl?=
 =?utf-8?B?MGFVUkJIRDdrR2pBanNoejdzOGZwbTArODJCWlNrVUhIL1A2UkpzSVp3L214?=
 =?utf-8?B?MkZoODh2RHV0Qkl6MXpnRVp4T1pDMzhmSFVIMFNKb3VOam5HNDRDelh6TXEr?=
 =?utf-8?B?aUlyK091TTNOTDZLSTd4cExSaW0wTnNGRFEwSWtoa3ZITUNiRVE3NWVsRmhG?=
 =?utf-8?B?VGczQkc1VURUM3MzSkJieC91WHFWZFBDSFA3VWE0enFhZE5zTTdwcVJqcEIw?=
 =?utf-8?B?MW9TRHRHQ3JSamdJZ0lzbzQ5Y09BVmgzMUVwMGdGTitmRzlHTEtWQktBenhF?=
 =?utf-8?B?TStkS0FGckNFcE1mRmZuZkFtamdwTzE5STg1VGYrenpYT3ArMHUwUkFkdWN1?=
 =?utf-8?B?cGEyVkdLeGhHb3RDcURlcGtzdXhGRlYwSy9oU3dVZ1E5amIrdks1Z0xtMUti?=
 =?utf-8?B?cU5GMnMxT1lHNzREZitWOG5OaGZJR1h0ZUw3R2NDLy9RNjIyZ3o4eEZJTWQ1?=
 =?utf-8?B?eUl4S01FTHQ5TzBKSGk5UjhwdFpOZEpwOG9TQWdBQk01QkgvQlo3ZU5qQkFR?=
 =?utf-8?B?dHdWc1JvVEVjT2JVV1ZLbENTRUM5aXBBRytSeGVhbmt3V2FYNHM4NHlPeDVu?=
 =?utf-8?B?ZzZPK3VWQmFXTUJqSWNYRFQ2QmFZWnVDU3ZPRGk0Q05peVVzZ0JsYkZxYTBF?=
 =?utf-8?B?NnRxdlRjQUlNRDlrSnFGdi9vWVorQ0hZWTZuY2JWemtCOVZDMm9raEFETExa?=
 =?utf-8?B?NFI4b0dHK0xkcm5rZGFjZDhjNXI1Kzd2ZEdVNGxPOXJzSVVaTWMyWGI2eXlz?=
 =?utf-8?B?ZUNGNVluSUZIZzlGZXhLZ0xBMngwUlFyK1RYc1o2d1dZOWVXdUJUdTNNbWFM?=
 =?utf-8?B?NUxuSlBveWtwc2NLZVdpNjMwUE9LQ1VOQXZBTmQwc1pNazRtd3drK0Z2ajdE?=
 =?utf-8?B?dEZFL1hkKy9URmhMMmZ4cUFwa0d2QjRsTVRVYmJaRlR6NUpHa2RWai94Q0ZB?=
 =?utf-8?B?dGN3M3RVNXEwTDFoMHE3UWhrM1lka2tIWGM1cGdWVG0wRW84bG5VbFBvUmV0?=
 =?utf-8?B?empvME5oWGZ3bndYZGI3SVV0NWJ2Y3NUeHNpMmZNTkFkRzVLVFBta3JaRFlF?=
 =?utf-8?B?Y1VINjhQQzQ2Z3UvTDBDS3F4bW81UGNlYk1Ha2d2WWlPUjlLRnVONUhPbGhE?=
 =?utf-8?B?dkFScllzdXlmeFJxNVJTMGp0c3NndHBiUmtEVDZ0ZHIvMFN5MElENk5vQVhX?=
 =?utf-8?B?N2ZSWnBLU3VneW8xcWhkUUxqM2xJM05meW82SzNqRjQveVQ0SExMUjI3OGVq?=
 =?utf-8?B?ck12ZEtOYWs1YnRIS1UxT2tINk04VkNRdTNobVVYVFZSckExZXpYeEVZK0h6?=
 =?utf-8?B?QTFvK3dDWVBzVldlcFk5dXozN2IwcHNzdEN2Q29EMVp1VmxhT0VXbUFpKzNK?=
 =?utf-8?B?R00xR2htV0ZVQWdVM1p4VWRNRkNFRkM1RXB5T3lXcnkxR20xT1ZJT21LNmV6?=
 =?utf-8?B?TjdzUUlxQWNYdFJqYkxYOUNoYkdGekxGVTB4dUMrT2ROUWZtcDN4alZnaXZu?=
 =?utf-8?B?N2dKN3I2azl4RytreThjQWd6YUNBMjMyQzlrNGtudjZ2cG1tb1hRV2xrckJE?=
 =?utf-8?B?bm5uY0Nnd2xBcTJ2cmVYUk5BOG1hWGgwbVZsKytaVTRQYWoxNnZ4MW1XZ3BV?=
 =?utf-8?B?YjkwaW5IRTduZWoxcWxTOUF0VFV1VDMrQ1NYVUI1VjEvK3ZOQzJHeWlqZ1NZ?=
 =?utf-8?B?dU5jdURQUkVRTHBoSG5ieU9BNGcrMndyRS9lS3BsTU9reTBBL3BXU3c0NW5M?=
 =?utf-8?B?U0FpUGdGWUY4Wmk1UFBqeWVXSFNVSThKU3dnVjNZcitrM21XVDZpdzdwamRx?=
 =?utf-8?B?OXZhOEJmLzJCdWxscS9LNWlhejBlMng1TzhiWkJpVmE3dmZoY0U4Vis0QUVZ?=
 =?utf-8?B?VHVjZVp4a3lObCtOTWdpSkxKNC9NZGZxeG11MnN6WjkrTWIreFcybm9CdDRX?=
 =?utf-8?B?U0Y3OE96TzN3clIxRFFFQ2s3MU5sdzNNNXEvblhSRXJmb1R1ZEtXQ0VwMGdr?=
 =?utf-8?B?UUtIbDFjVXNIc2NnRU5hQVdIUWN5dkRSMXFkOGVrSUw2ODhudjlwWndQaG1a?=
 =?utf-8?B?WUE9PQ==?=
Content-ID: <C2AD72914EDABC489E9FF9555617EA01@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145c267b-a81e-4a64-c2dc-08dadf458d99
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 09:11:44.7435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dtaGH1kwrOR9tuPWz2RNgzLqPPQpegoVVZRD5ARlQdgWkh3tzjns6+kgN91UkOYmAo5au03xRshD61EG0CJk6BSg4HshdV9Z1aSDepfFDv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5494
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/7] cgroup_regression_test.sh: Remove obselte
 test_6
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

>> test_6 is a test case when kernel version is less than 3.0.
>> Since the oldest supported kernel version is 3.0, so the case
>> is useless. Remove it.
> 
> Acked-by: Petr Vorel <pvorel@suse.cz>
> 
>> Also rename test9 to test6. modify TST_CNT.
> I wonder if rename is a good thing to do, because it complicates git history.
> I'd keep old names.
> Also in the past we didn't rename, e.g. in 1c44244849 ("getuid, getgid, setuid,
> setgid: fixed 16-bit versions")
> testcases/kernel/syscalls/getuid/getuid02.c was renamed to
> testcases/kernel/syscalls/geteuid/geteuid02.c to match the new test coverage,
> but testcases/kernel/syscalls/getuid/getuid03.c stayed the same (not renamed to
> testcases/kernel/syscalls/getuid/getuid02.c, which was then free).
> 
> Or maybe better example: testcases/kernel/syscalls/kill/kill01.c got deleted
> in eafdc5dd83 ("syscalls/kill01: Remove it"), but test names did not shift.

I can understand,  but I used the same renamed way because we did this 
case for test_5 in 2019[1].

[1]https://github.com/linux-test-project/ltp/commit/9b8f841ced26cd0d19dc9a007d0efd941929abde

Best Regards
Yang Xu
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
