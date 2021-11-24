Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66129C433F5
	for <ltp@archiver.kernel.org>; Wed, 24 Nov 2021 02:37:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4585B3C3189
	for <ltp@archiver.kernel.org>; Wed, 24 Nov 2021 03:37:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58BC53C0894
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 03:37:36 +0100 (CET)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3127C1400963
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 03:37:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1637721454; x=1669257454;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=UanedwuNNDfOxA7TnDBHSz0Ny3IDr8G2wmA4MyOl33w=;
 b=GKIOaPjb86jE2eR67TdpEDB+dHz1+5rEgXgqpl9H9irCuuQdFXlU2qtN
 3SjCBYxuqrPB/jkW3fF+BVj5WFFlP1RX+Asb9Q6NN3PF8J67v5+WUVyU7
 nXDH8b3vl+qz8mtkkb433SYtFF6V6RY6/IT5feWzvlehvyreoT73Hln4l
 sQPDgmjVbhJhGA6w80uLTwYjK+fLdzdny6FnDe2Jy1cgD3sut/KuZkviZ
 twyrV6ggvzyBT9y2ss6+gwkUXxexqQSneZwTnHPScbfCj6zgmW6RHErwd
 Ks+l99/HyTsaNYBLXrch+ZlylxNOO+4SWIuZPkVKarTzLPFHfQXhAPc7k Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="44686283"
X-IronPort-AV: E=Sophos;i="5.87,258,1631545200"; d="scan'208";a="44686283"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2021 11:37:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2sls/meEFqrVT1qIklqW64z5nmM8OrNE9H8KB0yr/UJRjwvwYGA3cilbIrA4i/QjDLe2H+FA6nBtj7Kg73CHZ4/USoXcS2f23kPzUtklN1pv7axIKnTF2YH0NUTJOW/EpvaG8PaUcnBdGROvWhn69JMJe+sMIoqE6ihIdqDrl4Mmjj3o7A9BQdnKFBeUrw2sS/yNUeib2NqAs/Ck73XHQ/4e9nhSRPDXNgX/GJYhY2iNillGdlG2GrtUcCFrS0sXDvbqj1WpyFEl0JZb82x4FCUIyupxYBZAVLYbGl1eDlstXwnizIqD164FXvgF18EJkc5VaPi02dUXpcz+A9sRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UanedwuNNDfOxA7TnDBHSz0Ny3IDr8G2wmA4MyOl33w=;
 b=JiY+EsOOSIKcZdZJMmiKM0uG/eLT/LjWRQHS/nhcQQ6Zg3vT8RiHZSUXA5l0RUtLYUPvP18iPpI4YRf9xTtR/qxiXigR96lBO/NVxh6+fiY77bSmHvva1+4G9uyD+d6AEE0SBDko9DrOa3Cv9rGDETNKTO9a0z3UsdNeMjOHwDu6znWYJIU4KsqwzCn4WZt6xo0JW1iERpNM8E6yBtUegXSeQYuDjV7OeTlbSQLvpUvdIbg9Nl03rj/+cu57hsZwwJ2+S4nZ6cWpqpmsic6r7VrvrlYDStN8jzMCp8wZ7IF4a+ZGpxHB+Brqr+BNIK3UJ9pSj2lxK+JsJgwBijlYLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UanedwuNNDfOxA7TnDBHSz0Ny3IDr8G2wmA4MyOl33w=;
 b=Qon8QBFh63DMebgZ3XDg+xFK1z/IhxGsAaMLTbPL8fcXYuhPN03n2Dps9iExja4ZlXSsO9DWxqtdYPF1JymgiydaA5iIwWUaR760RUJBo5UwwCLEvLDD0/7lLPY5IBG0tPNNgStekAvjCFdBn1baVw8wxcY2EnoArPuSQxkXsOQ=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB3467.jpnprd01.prod.outlook.com (2603:1096:404:db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Wed, 24 Nov
 2021 02:37:30 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4734.020; Wed, 24 Nov 2021
 02:37:30 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH 2/2] syscalls/stat*: Add nlink member check
Thread-Index: AQHX3R91mO0FjMSoykG1/+pPM3BrdawK0qOAgAcrmQA=
Date: Wed, 24 Nov 2021 02:37:29 +0000
Message-ID: <619DA570.9010303@fujitsu.com>
References: <1637310522-19620-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1637310522-19620-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YZehoX/FrtYjdcHM@yuki>
In-Reply-To: <YZehoX/FrtYjdcHM@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9efc657-1186-4150-a7e9-08d9aef35c65
x-ms-traffictypediagnostic: TY2PR01MB3467:
x-microsoft-antispam-prvs: <TY2PR01MB3467B4A010472303559F5998FD619@TY2PR01MB3467.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RJEpsglIFZBgnRYZoihvq9V9Ydazn7p8tm7gqulG8UG8UP2q/K7X4QW89Q8XH8JNM0qrkYei67AG+jIyi4jfLEHYlxkYLCshZmL8mdJjxsQnyWlqYC7xJyvaZ15hxF/7GhYMQv4roPgpWL4g7Otnv2I2fUfD03Vsy2i/FUOG24J6wjk0Bl5XKrBMzl0NisnRcO4ML/HqRASI2dmKQ7RZA4nVDiEOT8uevWrhmY9PoJltl9WXvTxWZtO1j2I+J1TUGpf00f0qZHVCR/MCY5QFvEeLHHBkblFXkPfJYHUIMlpEpL8ceflBXsS3Zs+ssTQkUeqMcRdnaD5bUViP432VN/PI5ruSt5Y2z8+6QB3sp1jjXw2gNUxBIA9+HVXVKjZ1hNheNukpOgFOWJKK/1LkyJI+2nXZjJj5WDKLSdWR78dik6umnDU0qK9YvkglxzPszpebYkncsPCvEZcyXsS8KhmNjQY03lJpmVmaezZLdF3pNyKL/N+8vsm89jwDTvCTSLf+j5BP+54c96iSN5nOnUIFJob+w26lYaVBztaDAqlor8OK4vDWKcTqaJxzoD19NQlGtD6XDWSTZtLHoqPiXT3Bf5sDcMyLYzxYeFPeDrxPYcGtOU0IJUYO7739GHQw3JBr2qVA44ZCyIaPzOAybXc1fBsn8bmG++OEJikyLowMumjPAxzJb08hlErBjKcZ2exEDmnkmdlwcTdGdKDeDQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(6506007)(26005)(6512007)(66446008)(87266011)(36756003)(82960400001)(2616005)(186003)(71200400001)(85182001)(64756008)(316002)(558084003)(91956017)(66556008)(66476007)(122000001)(66946007)(4326008)(6486002)(76116006)(5660300002)(38070700005)(6916009)(8676002)(86362001)(8936002)(508600001)(2906002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TWVuRHNHbm51bmNtZ3BrR2ZqR0orR3JqSnQ4UmZKUWlSNGFiL1RUUFdSY3J6?=
 =?gb2312?B?bHBqYjVmaDZKVEtHNG5vdVhuS2VyRENyZEhIKzNzWWNxWE1wWFZua1lOdnFN?=
 =?gb2312?B?djZkYTJXYVgxM1cvTzlCNzFMRFpxWUdkSHJEMlNkRnErOVNXRjRadU1VdHd1?=
 =?gb2312?B?WlhEUnEzQmZvNDBjN0RaMVVPRzNWWlFrdGc4Q2VSb0Z4QWR0S3BJWXJtVjR3?=
 =?gb2312?B?Z0srblplak84dVNmR0krZGJrYVlYUGlnZ1JwZjVBdE9TcmliZGpZWkxFM256?=
 =?gb2312?B?U09JOW1qRk9KQlhxT3VGRXV6Q2hZc1pyRUVaTVd3ODNEb2twVWZJOHlvSDhx?=
 =?gb2312?B?ZEhkd2RmVzRKNzZpcXcwc1p2djkrbHBGSzVMTmY2OVNLaWdic0hpRXBxaEJp?=
 =?gb2312?B?YmlqUU9FMGl6bDlEQSs5bzZqUjBUSGVQSXN1bHhCbW9Jd1lzYWJQLzRxMEFQ?=
 =?gb2312?B?aHlranF5RmZja0Vjd1loRjBkK1R4T0FEaTRRRldsVHB2Ky9hSlFnNEkyRktC?=
 =?gb2312?B?WHh4Ri9NbythL0NraXRaVmRlQWtOZWphU3VMMlBSang2OFJiU09yWXFNN04w?=
 =?gb2312?B?WFg0djVrS1JVanU1dUIzdlZWbkZuUVFaQzhnNmRKN2FlbmtkZldCMjFCbUdZ?=
 =?gb2312?B?MWpnWm9rSE55YmROck5PV1ovU1hCSTJZQmpiZ2VRbmEvOWJ4QmI4SG9NaG1x?=
 =?gb2312?B?TllrdWNNQ1A0ODJFUENFb1IzTlhoTGRac05RbmkyQTJiTHF6S2pRTEZpVzdl?=
 =?gb2312?B?NVNHRzhJQSttcWl2dU1uL2I4aExiekZrMGZTclZpOWFjR1pxQlorTFF0VWxw?=
 =?gb2312?B?czNyOGR1MkdabFUyV3Mzb3FFWW5IcmF0cmd4eEtVVGhHajBaNVJmamlhZmV4?=
 =?gb2312?B?UEF0d1FMR0pSbWR2Qm1hbG9mZGcveFl3QXpVTkZGVUNweWtPUDdrUy9yQ2N6?=
 =?gb2312?B?dllXdzNPNTZCeDVXUWtncjhvdHVzaVhhTUc1aWl1a2UzMmFvNDBzdTE1OFRn?=
 =?gb2312?B?V1Q1UFphUUZvNmFWc2pvQm5nQmZROGNzbjFjK2E4eUZIRUtIY016MXluU0RJ?=
 =?gb2312?B?a2p5SXBBNUZVd3NsV0VmQjYrTFlCMUwwUHJLNXlVbnQ2blhyNHdBa2d6LzdR?=
 =?gb2312?B?bGpFSGZoUmxiMEtDRzFBN1dzVlk3VmNtRXo4NEd0YWM0OGs4MG5hRWJXMmpD?=
 =?gb2312?B?L3RpK3BCWGVKaHBPSWkyWERQajgvdGFEM0RGalFSamhsQU9CVmQwWW1WTzdI?=
 =?gb2312?B?ZUZHdFl2anJqbEhtSHhVOUxvNjV1RC9ibUZITGFudkt4UXg4eUJGRWRFWTBH?=
 =?gb2312?B?OUtpUGdSYW1BelF6Sk9TS0ZnUFVCcFNETTlDNXhMS3ZOeEhHRmMvV2FIR3hW?=
 =?gb2312?B?b2dSK1dna2FJdTUrRCtyajRwNTFGR2tNNlNMWHF3WWpFUEcvOHVLOTI0ekhW?=
 =?gb2312?B?Z1VETkR2SXplbUNyWFAzQ3NzczdHaTdTTCt6ck94ZVVaZlpVMFZyYWFCdGsy?=
 =?gb2312?B?OHFoalFpWFZ2ZGxlZzR0QjBRVFRxYldaNVloclpQMnNxYmlvcEkxSFhNNFNi?=
 =?gb2312?B?Z1FRa28rVW9pclUwUGFSaDl6TWZjREErR284MnlBSnEwZE9HOHU2OE1ZcEl3?=
 =?gb2312?B?QVgvRGhocHQzeU5Ed1V1UnVPV1RyTUd2c3Y0c1p5UGJ3dXh1WFlKem15MW5j?=
 =?gb2312?B?dkdsVFdISnA2Z2hrcit6VmFoUEE5TzY1VTkwY291dkpsMDJZbXZhMG83Lzd4?=
 =?gb2312?B?N2FCWm4xV3dhcEdHSEwzYldPbUE1SWpFSHV1QlZOZVVvcnZmUnRxYXhSUDZS?=
 =?gb2312?B?VHFLUFBnNVJ2Rk1JUXhMdFFUaGFRM1ZLNmVhWWVWdlVHdUIxdnFSbEY2RXFD?=
 =?gb2312?B?Q3AzdFNkS1dESXFYNy96UGZSSktjZjhoUjZFOHg0QklVM09XakVWbTNNOE4z?=
 =?gb2312?B?aU9ydE5ZTjJINFlMUTRQd1pDSGM4dXZtWHBFaG96Ykc3L01Bak84MVFTSVU5?=
 =?gb2312?B?anJnMnlEekJSMncvWWlxWUVxRFJtemZWVVhjbjh4bmlFMlNrQTVWMGpMSWp3?=
 =?gb2312?B?Ui95VFZNeHNMT29kd0ZDaEUrSFROSHJOblpnOXY3UW13a2RDS0o1eFZoQk8y?=
 =?gb2312?B?RU5yM255aGh2RUY5cVg3SUMzTENQd242QWhveGd4Z0MzcTlDN0ZmbmlCR2ZH?=
 =?gb2312?B?cjNXQVU3QlVCSXg2L0wxdXpkVWQ5UGZhVEJlUjJUREVHcHF6M2h0UVUyR1J5?=
 =?gb2312?Q?nU8UEYbMz7rZy/czREC4RugK0gWfSnafvTK9I/Lowg=3D?=
Content-ID: <50F4D7A6B22B4444989575A98B5C21F9@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9efc657-1186-4150-a7e9-08d9aef35c65
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 02:37:29.8803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zbQ/IBcNC75xFpi+0EBBP5bnCl54qbQ2fFzbMCNC1L/i//Z8r9+7dYmJ3cPRXu+xVwh5rZ+j5bW+79y+HzW3jlBSin6jDGXpmLKWxXD8gzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3467
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/stat*: Add nlink member check
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
> Reviwed-by: Cyril Hrubis<chrubis@suse.cz>
Since the 1st patch seems unnecessary(I seen your patch), I only merged 
this nlink member check patch.

Best Regards
Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
