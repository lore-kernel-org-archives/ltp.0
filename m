Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07676C433F5
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 02:50:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 656433CA1B5
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 03:50:00 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 619233C97EB
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 03:49:47 +0100 (CET)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 331C11A00920
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 03:49:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1645498186; x=1677034186;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=HbEagDQ/swMoKhFIqCnBMf8MHp/UkRdLDnPDQbKdELY=;
 b=H7SaKMPL1vMJBIfdcAVb7jlcYFmdaIp4MqEqkFVECNfAkL8BFI0nPpJm
 +leoQBwOwLlsuLdyr7EaVVVVAyfIBJgDs1VX8jj8EbDFhbdMqC9eMbnx2
 igCs12ukmC1R7/o6YRGaeJHVz6UzeV07UzNjle3DqZVwI8eaNBIHuaazf
 FIFrYzYXrmHMdnV5JJeKayGZsgdIEAencGqCaE8enEGOwLDjDcqe2MoFe
 PzFyfEMc6tyLF/uzV2FYV6g+iZhfH0+g71T2OkEJRfkl5VChR3JOOdBmm
 L8Qkh0Lj7h85KCiiBO08E7vV3ftvvggo0HrSr1cCgLEBODq9ZnIizr8Z0 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="50219702"
X-IronPort-AV: E=Sophos;i="5.88,387,1635174000"; d="scan'208";a="50219702"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2022 11:49:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdRPwSMkLKVwpqYw5vKo2alOKK7SrNmbTZ5KuWLD0cpZZwO6hhAqNKA66yBRNXlBok3Q5I1bzYViJ+qrlrSOjwNsDlQZB9BfMZ1h7UqbqekigEHTpuYh5IhmuY4IDCmpcCe7EMss9i8Bk3w4f02w9ZW8K80yW7/R16fIaP5v+mMG7JOnk52bew1Sp4JYwLIG6XRDsI3m7rcH90/AJBCnGQOTVad5484I583TuKU1fSJ1sYqafoztvpJ1fz9cRsi/l8U9QgBSsMnkLSwYvphukmKG9Av4JoNYp/PiofeOMeEUXbgZwU1oCJ0+mOS/Lgvl/fKIoYNMsYTFaYR1Afbsgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbEagDQ/swMoKhFIqCnBMf8MHp/UkRdLDnPDQbKdELY=;
 b=bfGxX5kqfQcUFWuUf7HxujcKbc/suerP1gXTRb3deItQC6MRMSnLh2t6ahfFOmK49Lfb2+87X8XWRvXLQIvapeP7HtGeFyXkydlR3OvSRrdia/7RA5YJcl96z0ytU0+UUP4JuPuR1gla5GkFi66XnczkoFU59YC9X2/j/+gEg5P6PbphsJqgpujOhjLIPgIM2x7qJ2s2tn7LtCoe51gCSTQvLEfxfugNf7KknGVTCq0XsJ3ZEJJDgGtf5i3QK8EUhIcsAYnBj62Xvzh6mfgBcvEJCaOG8hnbiVd2L6GfUo66F3zRhD9T1GlGEbQsi4Yp5sjPjVfNgkgE3Bb3523y/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbEagDQ/swMoKhFIqCnBMf8MHp/UkRdLDnPDQbKdELY=;
 b=ecLTSot0vtuWUbuzmYq5vcqvjtXfWiDDA5LvjwTsZrBI1GOTZOhT7nilQthrwl6N5KRk/Wnr7lhq1RJr7zVxxUjEouzdcZB8z6r0FnPNDMKUR1XkHUIraB7kHDYyBYEg3jQEWoHjkR/vEfFao58N8dKtbSbgYA/vt1WDRVZh+Us=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSBPR01MB1637.jpnprd01.prod.outlook.com (2603:1096:603:2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 02:49:40 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::29ed:c2:4190:cf13]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::29ed:c2:4190:cf13%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 02:49:39 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 5/5] syscalls/pidfd_getfd02: add basic error test
Thread-Index: AQHYIxys4DH6OXgqL0KVaaU16gtws6yYKqMAgACEWACAAHfQAIAFwOEA
Date: Tue, 22 Feb 2022 02:49:39 +0000
Message-ID: <62144F74.50802@fujitsu.com>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645005868-2373-5-git-send-email-xuyang2018.jy@fujitsu.com>
 <Yg6oZLaYz6Dj1FY4@pevik> <620F1768.7060100@fujitsu.com>
 <Yg976lg4tvxLdyTm@pevik>
In-Reply-To: <Yg976lg4tvxLdyTm@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6960622-2e10-45b4-459d-08d9f5adf8a5
x-ms-traffictypediagnostic: OSBPR01MB1637:EE_
x-microsoft-antispam-prvs: <OSBPR01MB1637F8624A8B1D0A1D6D5C7AFD3B9@OSBPR01MB1637.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ItisyeveFt97kin3raTF6gjf86YneVB31h5uhoprg6MJ2GcPSIVPZacDfv9+QeT8+bAL3eBdwJcKcDRS+RbZhJNmi5sIv9WXiMBuAJRNePn11GANbMeiWcRqR+F/frUeDYhtSqZeUDmWrtkBxopxPv+zx7kGo/zWYw4FPaU6r/3fjxkESG1b/6JRlIXLb3ud5eMarQXimr3MpQxdHUsNXCm5guK/KNFsMl2DSLRH/cxbD6+QXL6QjbE/oh0JrOeBrcdBFvAfNdWUU648e51xxU2kk4cUPGVW+wTNaC7a1JnK4w2z8srWD2NuAa41L8iLgebTCYCdaqlOwFQ7sghbbbyngDqkOCJPVbp/eMMDcYNoe8P604TYBF6GoDoDj7vMaAMsiRpGRyGv6tBqy42iI47lXJ3JR3AbpO95Obv5pzLYMFmqt2HbG0gSn5k6BfKUgoSpDKrrhmEFxaTrcyPl7mj6gZ9sLDu8pMXJe71bus/UztJR89oeZnTAGyrMicMz2yEp0L5ePe9A7fkfTB8PE5B/H9NHYwbHtunaipFdorWAyXeMZyj+xkb3Q9MwEkZsNGk8to0qheC7Opa+zEUPD+aNP9e1KeAtNsKDCE6N4aUDeEdu191zpd2yRhU4AEQSj/zXeAZKNVw701cjsSCfpaJePNTDFoVXHkcJggz3U9+V6xSJA9IxjhzvxjpMd98GdUgUynZvurrx14W4eIBoQTPhOSNBTk87rYiBb0UaPckcKIyhs1xLvnh6NRA+41m1DxfiMbx7D1hvc+RnUCVruaokAvUDod5C1ozmDaxZ9/A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(38100700002)(82960400001)(86362001)(38070700005)(122000001)(6916009)(316002)(6512007)(6506007)(66946007)(66476007)(66446008)(64756008)(966005)(6486002)(36756003)(85182001)(508600001)(4326008)(5660300002)(66556008)(76116006)(2616005)(8676002)(8936002)(186003)(91956017)(71200400001)(33656002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Q2o1VzJiQ0tCdTA1eVBFRTlNdEtrUnQ5QmNxK1R2OEZHTnZWcXoxc25KRTh1?=
 =?gb2312?B?cGVWU3RNS3phSVZsRkdXellUNytGMDA5MHBRa1VKbDYza0FtOHdjL3B1cW1G?=
 =?gb2312?B?MjF1ekpGMEZkM3J2TjEvZEpYMmFJZXZUTW0rUkJsVXNwM2p2QnlVNzlMb3Bq?=
 =?gb2312?B?em10L1p6UGF2OXlTTXpVYUZRQUVMTlE3bVprejVBSGxpUVZqZEpYK1VFeEcw?=
 =?gb2312?B?TVBjMHFPaXk3REFXSVVrbzREQmVwTmJReGVqWWVKVHZWdWFOclFaMWNTdGVm?=
 =?gb2312?B?by9zS1AxTVNDOENuYU03Qy9BTExJL0FxVWg0eVZuK05YQlY4MThyenhDcFgz?=
 =?gb2312?B?Mmo5Zm1scVRmaDJrcmEvWDJlZERVb00zZVVZQmppZ3BOWml5ZVhraVpUdzli?=
 =?gb2312?B?L1RQNmNyUjBWbXd2NW9USHU2RGxiTGprNUFHRkFickpXYkpyZXJoTy9iN0g5?=
 =?gb2312?B?VjFLQjIveVZyYVcrbDhqUDlyS09Hd0dVK0ZNVTNhbnN6WkpTYUs4NXh6NURt?=
 =?gb2312?B?cDduckJSOFRDQ2gvSVpLNmlMWm9YVFAyR1ZwL0lYdS9Da2VZeXdKMDB0R09I?=
 =?gb2312?B?UElQSnVoeUxIZE1yQUwrazd1T08rakRtSS9Nc3lZUnlMN0ZqQk9IS3pEdW5S?=
 =?gb2312?B?L2I2MHJYNC9IejBKekJqaEpLaHRhUElueUZ3L3Fka0ZMRlpYZ2pwQWJRQWJ6?=
 =?gb2312?B?MnE2ditFallhUXlFTWhUeDR5ajFDR3BKWW1WUUw4TEE1UElKM3NSODJuNU1O?=
 =?gb2312?B?aWlOcjUwN1gxV1krMTkyUmFlVzB5L2M1cEZnWXZ0SERRTlp5cTlFZnBKWEw2?=
 =?gb2312?B?eUNjQ3BjVU5hQkV3K0hUMWt5c09BQjQ3aTBYN28wc3BYUVZZUW5GTkUyMk5I?=
 =?gb2312?B?NFNPSHRTWCtiNFVja1VseDdnVzVBcVFZWVNkV3NXTHJkdkZuRSt0K3R0OE9L?=
 =?gb2312?B?Q2JVSEZJRXoyOG1zdURXYUI3UXZjajZrelpmU1o4RlNtOTFZQktIQUNOd25J?=
 =?gb2312?B?WCtpTjhZUEdZZGZrenQwaXY3WWgyK0VjcXFEQTJpbm5PdVNndEhkam1IVkx5?=
 =?gb2312?B?L3h4U2RuTFJTOHJ6UVJGeXdLR0FmZDh4N1F0TVFFdUNBYjlteWVzMUhnZFlP?=
 =?gb2312?B?bUdQS2RtWDMyKzZyRFozVTVRd2txMU9VWTdwWDZsV0x2VktVZlZrYjkyVmEz?=
 =?gb2312?B?aldIWng4bXJuT3B6cDJuaU53anM2Tk1TN1JPS2x6KzdoRXNndWcvNDlLbURt?=
 =?gb2312?B?WkJYM05Vbnk3ZHpTcmU2bDFQYVN0cGxYRVIyVlUxOUsxdHZDbGN6OEg0M2tC?=
 =?gb2312?B?MDhsS1JSc0EvQmhSQjdsU1Rnd3gvd1psY0lHV2dobEdWWG9pdVRCRnpJZGwz?=
 =?gb2312?B?RkJHM0xEa2wrbzZHOXFQM3BIaGhMcjliS0IwTmFYZ2RJUEM4RGE0cjlUVnVJ?=
 =?gb2312?B?RG5Fa2ZoaHNPT2VhZGkvcUZoTzV0dFRoekQ2S3dEMDBFQ2VXZ08xcUVTZHgx?=
 =?gb2312?B?M2FHWWhPaXgvTDZDalNvalRWNkRTaGNscHAvOUtudjh0WDF0VWs1M21ydEF6?=
 =?gb2312?B?T1U0MDJrVGw3Znl4RDg0cHRJUGtUUmR5MmhoQkhSbXdYYXo0Uzl4OUJLMkR6?=
 =?gb2312?B?SWJDQi9mMnQzdWxYTFVGVWpIQldpSVVEZGxWSS9VbXJjRGdxTnpSb1FPT0Jm?=
 =?gb2312?B?Z2hDa2pyY2lwY0t3d295SGhBUjhkdjFCS1ljL01CRTBJMXBBcDFmVW5lRmhD?=
 =?gb2312?B?RzB5bk9jM1pjeGZKdlpsdFlKZGVlVTBzVnFxN3lSOWNMR09la2ZURENtUjlp?=
 =?gb2312?B?Y1hMRlhrQjJ2UGZIR05hQUJSajhzQXBpeWJBZVlWQWN6SEQ3ZzRNTUVQY0hE?=
 =?gb2312?B?QUx1KzRDT280YUdRVUZaZjhvZFhDeWpBSHdCMkxyR245R29STkRwaURmaWFC?=
 =?gb2312?B?c1RqRFQ0Q25hMHRuT1pUaTIyQlpIeEZDUEhPZVd5T0x0Tm9ObTFWcE5HaUIz?=
 =?gb2312?B?Ri9ZaVJUUGJ4bXAwYXpSMFJSSUV5d251QWMwWldtNEJzZGgvaHVOK0ZRQVR5?=
 =?gb2312?B?M204OFZneDhaZXhUbFFYMHFPdU9nZDRWYVR6N1dZdldlcHJSMmtjSit0TFhS?=
 =?gb2312?B?aGhBYXM0RnptVXd1cDA4b21RSEl1eHpXUGJIbHJtRVlRbmE2SVRBblhpUUZR?=
 =?gb2312?B?c1U4OTBleWRmSUg1UFVIWkxyTU8xMzNnVkJrcG9XLzN3T1V3aFJJWTAzMTRT?=
 =?gb2312?Q?wlXZICAmjOl/PYhrQe3Rn/oa/O7l+xmjGWRtlmQVYo=3D?=
Content-ID: <F5C96E12F4282149B49A5514B6C656DD@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6960622-2e10-45b4-459d-08d9f5adf8a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 02:49:39.8739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VFS7h0HRwnPOIl2G5HFMIrxRkW9t4Sup8dkAblC7Q9hz/r1THNlD4K2NyllmrJy4aaqKXq45U7xt+WUBVXeTxRLyl7NSdG8GfcAdLfZJ0AQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1637
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] syscalls/pidfd_getfd02: add basic error test
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
> Hi Xu,
>
> ...
>>>> +	TST_EXP_FD_SILENT(pidfd_open(getpid(), 0), "pidfd_open");
>>> If you wait for Cyril's patch adding auto stringification
>>> https://lore.kernel.org/ltp/20220217142730.19726-1-chrubis@suse.cz/
>
>>> you can use just:
>>> TST_EXP_FD_SILENT(pidfd_open(getpid(), 0));
>
>>> and get more info.
>> I will look Cyril's patch and wait.
>
> FYI Cyril is not planning to merge that patch, replaced by
> https://lore.kernel.org/ltp/20220218103413.18540-1-chrubis@suse.cz/
>
> But I'd still drop "pidfd_open", because
> pidfd_getfd02.c:55: TFAIL: pidfd_open(getpid(), -9) failed: EINVAL (22)
> is better than:
> pidfd_getfd02.c:55: TFAIL: pidfd_open failed: EINVAL (22)
>
> But as fanotify21.c also needs SAFE_PIDFD_OPEN() (and more tests will come in
> the future I'd vote for adding SAFE_PIDFD_OPEN() as you suggested.
I will add SAFE_PIDFD_OPEN into lapi/pidfd_open.h. But it seems kernel 
doesn't have pidfd_getfd.h/pidfd_send_signal.h/pidfd_open.h, I think we 
can merge them into lapi/pidfd.h. So in the future, we can introduce 
other pidfd macro and case wants to use these pidfd macro they just only 
include one header(lapi/pidfd.h). What do you think about this?

Best Regards
Yang Xu
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
