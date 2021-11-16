Return-Path: <SRS0=zuCx=QD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88136C433F5
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 08:05:20 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF69361A03
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 08:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF69361A03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AB843C5509
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 09:05:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64A2C3C093B
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 09:05:07 +0100 (CET)
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com
 [68.232.152.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 216BB200FE3
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 09:05:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1637049906; x=1668585906;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=p80a2kS+M6XS0fFA4TpynmHEO7u0CkYohgQbgTD/6Cw=;
 b=uDvNK9ujcalg1QEzxTUg9Hi5bvRedwBaJ5/Q2TDBruh8GNzynlRfD7Pw
 ZZcU5D52OWI48m3RnZPachgef9MA77qITbH8FnSxeO9KWE89auWiR4OPj
 1aWSoliwGDelbZGcuNeqTUKf9Gt7yNw0hiLClVmxDyJ50/JPjDdKSwALX
 DwcmfWpcNSXGzxqoPqZAsZtj60gbvB9Ml3+4K4MzCYWLbqEF0zAvR/jNT
 lS2veuVucSXws9kDfBaLn35sCB32zzY+g+mkjNx07gV4I+QvHCNMCbAgO
 yg9Ww0b3MKA5R28PCGm9wMSLoi8uFlsMcqXOr4Ak5rRwH/BGcUk0jK3hX w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="51886620"
X-IronPort-AV: E=Sophos;i="5.87,238,1631545200"; d="scan'208";a="51886620"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2021 17:05:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5BdGlu/+nmi+hjVUMYwB8G71+2mGeSMTYC26164EGGaqKAxAG5JSjDO79ki4eHBAJYaGIFGanbFUPYmjX0i1beozkXN9Xn17vUU5E137E6EWIcxVkgFGWeRI/JaCbGWt+vBC7+lAuN2a9XWlPyTdt5RHrTWzM90n9NuW0o1jAvdrugmTvLmKQKNZUgLR4V8uFhSKnfbYzeXEc5W2FtPEzQxeG5s1HCQ6iPEtsQVonQtlXzIGKMkKB/RsJbFCh3qqIYjY+uOieYRzOx3kVPXHnTlgorfnIj+JzTsVLWrzmGDh161I8a+lhLeU7IEEO/ZL0FQFueZ+Fy4Ip7o8BQSSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p80a2kS+M6XS0fFA4TpynmHEO7u0CkYohgQbgTD/6Cw=;
 b=m9IebHX2SNy5MjKdXV1wgAh9cpOetoU4CS59TPKdkr152BBaNrEZm6GX5/AbPyz52DvPZq+miAtG0nhgoExIsHTrSb78UOykJNV6snpn4l+BuDrsGsGjUawzFK2dtDortE3tI3+N7rjk6R3KTT8wjv0qpp5vnzH/t68sWCyzmAXwtsko4Qpg1tzLu52ayHqZOi7MXg3HlV0V5RoHwnwmlBBoRYN+AsyG1VcP74kH4KneetWfnuC9UVbXBbF5HvMmGfPg/PXxwz903w+LKMXwrRY7KHnBopobpoMTOrV+d3hfMg9qN1crE+4hvt4PdHAdLRWnyDz6yeRciX81dhpUxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p80a2kS+M6XS0fFA4TpynmHEO7u0CkYohgQbgTD/6Cw=;
 b=bWxC0qmSh1XoC/bxnYacs0TXwoodlDoi/iKOzZl7LNnvG9Pbeh/GrxnaZU99B4dltfzChg89GhaXXHxJaiQ+UWjRBrju2s2FHvccD+ifDs3sI9YtknQhsKSv/csH2/o1y7igPUrOp/75mXHV2qDdFxz1rFLdxbjfzUC8Z2CLqHk=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB5196.jpnprd01.prod.outlook.com (2603:1096:404:10f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Tue, 16 Nov
 2021 08:05:00 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 08:05:00 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v5 2/3] syscalls/statx04: remove btrfs kernel version and
 add linux tags
Thread-Index: AQHX2r9bHpoQSjK6R0OPcO1YR8WzM6wFy96A
Date: Tue, 16 Nov 2021 08:05:00 +0000
Message-ID: <61936639.2080801@fujitsu.com>
References: <1637049352-25731-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1637049352-25731-2-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1637049352-25731-2-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8232ad87-98db-4da2-18e4-08d9a8d7c9bf
x-ms-traffictypediagnostic: TY2PR01MB5196:
x-microsoft-antispam-prvs: <TY2PR01MB51962EEDC1B787AF82F4A218FD999@TY2PR01MB5196.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iGQwMUgPZ+TtqZkALDDgOVDmpj6f7bTLNc0w7cmmse4Z4eE12WfIdvPY91E1dqvg0yWsttZSJur3U9PIKU4eKjE0RVOL2WKbgn5AvVHbhgNn0yhT906MzDXgjoyO16piTacT/OcJe9pvMv8MFWQ2gpEtp6RC8+Ei9YAsU3PAAvdEvEyvylBMLRKyP+dCXG6+R1WmjnYBVnYrLW/+gppaY/mjRnYtU7aM1cXxcFxdvMJxhm7kaKeSMHt+yynghOww+GZhJHSH9kuD+6zR6dpaDuPACfdmf9b1Z7DzNpLWL3Mg5X9xog/3Xt6ZdI5DQ1l73QzF1QURiZUCPL1R8tTaVsnC60VKYGd7Dx/kXAozH2yzEvxX4FcTxGcvkwOp9/8sHFl9Y3jxnVMbYTINX3l9nWprp6RdCrk+q5Yyq1FqrgWmV+Cmt01hyeb6+GFTEWlzoWGU5RBw6HJMOCoXHWdIVYHpPYopxOmyge4/n0k6Uy1VSD+AgGjkZLm5/XLZOMCNEVMqVYFJpITP4HxhAgA9MewVyYdNKX1if0pJYeZR5XGgNvr1qOM4fXnWJLKtoSQKlod0xcjnUH6tEqePzSIRGIpKWuuCRrS2hPboxDNbRxzj8XS3cLTDQ+nzLUl85Rwdvf2nLTomnrTAM9+cMrnZ8KwrJfsnwzwJO1z3EJWNo7CSLsOWEen5cIEn7rbcUjQNi2DZAPuGQn8OTdrIWhYYIyTO6XLLzCeUsWQ0u8t7w6E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(36756003)(6512007)(122000001)(316002)(82960400001)(2616005)(38100700002)(38070700005)(6506007)(86362001)(87266011)(83380400001)(2906002)(6486002)(508600001)(186003)(26005)(8936002)(8676002)(5660300002)(6916009)(91956017)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(85182001)(62816006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eWFIZGNSb0NmMUVBMmRsdjdUdlNsb29BRVBXSi95VTBhcDNFTkxHSkxGd3FO?=
 =?gb2312?B?V3dDZUkrTjF5QnRIVnB5d3Q5VVBqaFpHNlZVYWhlNHE5eHFFZ1NCcWVySUJE?=
 =?gb2312?B?bjJEeURaZk5XWUExU3lhZTBCNTBQeUNoMXE0ZWpTc3NzbjFCT2Y3QTNaNWlt?=
 =?gb2312?B?Tmtwenp0UUJFNGhodWd2eHRrSklHN3JUU3FuUnlmTWVYUGdjMUNMTXpVQ3BN?=
 =?gb2312?B?cFQ2Y1BVT3JEa0pkMFE4OUI1dmVLRldxcTd2Z1FXRjlyQ1JXc0h0SEh2L1hv?=
 =?gb2312?B?NkR2R2M1b2Z2amtacThoVVZxL3laSllDczE2R0pCdlcvMTljTkJ2eEdpdHM3?=
 =?gb2312?B?Um93c3RSYXE2UllIcVlGZFNodW0yaW1rTExuZzU3RzRsODNoTGRJcElWT0dL?=
 =?gb2312?B?dW1kajYzTVFabmJwNGtMdDNCSFNqdytWNjYyWEprQmRvWllSKzJoVndvZ1BD?=
 =?gb2312?B?RnI0UHNDQUNiMnZFRnFSZVErWFNjMUxWTUYyanFQZ0VBSCtNQ2JwV0JSNEdC?=
 =?gb2312?B?ajl6S0hIenJ2TlMzalkxRTZMQnA2amU2S1Z5SVVTaUY0R0JxUTZTelpUbGwr?=
 =?gb2312?B?NXZsRkVQNUJ4cWxzRXk1N2JFUHp6bGZtdHBueWpvYTFXMTJzK0Q5a21nN2Vu?=
 =?gb2312?B?dHZYc2lkRXppeFRHN24ydTEvclV0VWVKM0NCcUVyQmlGRHoxdDNwcmc3emkv?=
 =?gb2312?B?MW5uL0VJY2xPZzU1eXBqZ24zOE1JbDVud001WUtmQ3Jwc3lnUDNiTE52eVJh?=
 =?gb2312?B?bC93ZGhGRUN1YTFTOVBMdm1LR3hETjJKenFobTllUys4dXRoSFlnT2hnTmhi?=
 =?gb2312?B?UVV5bHYwV0gxM2VOSnAxSFNYZUkyMHpMdWRYOEp1NmlkSjZ1TCtodmwremFJ?=
 =?gb2312?B?YUlxV0VZbm5nd1htcTdsSFZIMEhmMTh0S3c0SEd6a09JRUUyMktmS1pkbVgy?=
 =?gb2312?B?Tmx3L05tRkxxNEhEVGZmRGVGK04ydFp4ZkkwczBsQUNKVXg3OGxYOHIyMkk1?=
 =?gb2312?B?a0I1dnhUUzFNdXFMTThXclNIbmZVcGc5UW1lWWtmMGpIN3ZLa3dJZlFWanRB?=
 =?gb2312?B?STdhRzlOMFJ1dSthT2p1OFB4N3lJdWJOejFCQm5mR3BUUjR5dWVsSllzQXRn?=
 =?gb2312?B?VmE4VU1LSUJUejhMb3Jta1JtSWd2cEZZU3BOQm1QU1VlUEVaVndPWHlkZEtI?=
 =?gb2312?B?WnFmbndKSFE1bFNoVm52UXdGQ3VtQ0Z5WXlCMTh1R0I1RkpVRGdnYWVUQW5n?=
 =?gb2312?B?UEprWVpoYkJSZmhzRGoxeC9BcDlJTVhObU1iWkZQOUc5dFBUVElQb1Ztdytj?=
 =?gb2312?B?ayt1TzNTN0ptcFBwQ1N0Q0VFRXRqUVUvRytFcHpVdDNhWUhPWWRwcUZHUDl5?=
 =?gb2312?B?VjNOWFhaYnBjRWFRMWlGdFZFTzRNVEU0d2xMdUR3RTVGZnU0cU1TQ25ldlFa?=
 =?gb2312?B?L094dzVxTThPWWpuTWZ6KzZGRnhnc05mMUlYRHVjbkdKUnZaY2xSbjR2OFk3?=
 =?gb2312?B?ZlZPVmNTMGZNald5bUp0QmlydDM1OWlFWnpHMEZqMTkxb2JQOERVSmdISmNx?=
 =?gb2312?B?MG1lRTBvM3VyR1RETkJPWVFEU1c3dms2SG5ITnk3d0xxNTdqam5Ndm5wd2hx?=
 =?gb2312?B?ZWVYT3pmTi9FYlc4OFM1WVhhcDREcFc5SUFkaG1SM2gvRGdoTTdQYnJiQSt4?=
 =?gb2312?B?Q3g5S0wzODRHamlKR21rdTVidUhtN3FCMlFZR2JaWmx2Y1gvWU9DblR1ZVY5?=
 =?gb2312?B?Tkx0NjBQSzJSRzJUZFZyQjFFbllubXREMEcyaCs4emJGcGxKQzF1MW11VUla?=
 =?gb2312?B?ZTRqcWg4ckhwQlNzSk93Yk5MNE1hbFZmVUsxT05RUCs1b092MFFqd0NaeDdQ?=
 =?gb2312?B?OFQ1RUZEZTNXampMdlA0ZkFVV2hmbHRrWjJKK3pPVVh3ZGh4VjFiWWJFOXlV?=
 =?gb2312?B?eHVYNFhPWjM1b3JCeGN0bUl1TzVGUWtod2duSnk0bEh1SlhFeFV5aHhpVWtC?=
 =?gb2312?B?MGRzNGhNN3o2NEo0enpBUkd4R1ZPc2kwSzA3TEdzaUYySmZlN3BTVXdYMVd3?=
 =?gb2312?B?NFA1V2hWRUNsTlg5b1VicmJXMzBGY1NLOGF3Sm1ENCtMcVAxaVVMU3haOW8x?=
 =?gb2312?B?anlHbHllZTdLS0tySmxiZ3ErSnh3L0s3MHl4WWFzcEtkQVkvRnNQZTMzNTZn?=
 =?gb2312?B?Z0NKU2EyVmFXL1hIWGxpQmRrdWJFZXFzSGNsQUJjRFdPMHhQYzJjT0dXVm5Q?=
 =?gb2312?Q?ceQosEGlWR8gBaHqaJttvqwJIGxtblCkwTeX/RCSYY=3D?=
Content-ID: <CEF4321E983341479737BDB0EE638BCB@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8232ad87-98db-4da2-18e4-08d9a8d7c9bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 08:05:00.4849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gpj2jkNAj/vaOPJTUcVp9r5bhPrB2DbYFjoZ7WNoTz0Izro8Jied+zLQpvFKl6dgPBt5a/G4GkOWfj4Ip68maZVUaeCFpy64ASGIz1pBu5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5196
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/3] syscalls/statx04: remove btrfs kernel
 version and add linux tags
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All
> Also add docparse formatting.
> 
> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> ---
>   testcases/kernel/syscalls/statx/statx04.c | 54 +++++++++++++++++------
>   1 file changed, 41 insertions(+), 13 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
> index 6881ce261..a51891311 100644
> --- a/testcases/kernel/syscalls/statx/statx04.c
> +++ b/testcases/kernel/syscalls/statx/statx04.c
> @@ -4,25 +4,50 @@
>    * Email: code@zilogic.com
>    */
> 
> -/*
> - * Test statx
> +/*\
> + * [Description]
>    *
>    * This code tests if the attributes field of statx received expected value.
>    * File set with following flags by using SAFE_IOCTL:
> - * 1) STATX_ATTR_COMPRESSED - The file is compressed by the filesystem.
> - * 2) STATX_ATTR_IMMUTABLE - The file cannot be modified.
> - * 3) STATX_ATTR_APPEND - The file can only be opened in append mode for
> - *                        writing.
> - * 4) STATX_ATTR_NODUMP - File is not a candidate for backup when a backup
> + *
> + * - STATX_ATTR_COMPRESSED: The file is compressed by the filesystem.
> + * - STATX_ATTR_IMMUTABLE: The file cannot be modified.
> + * - STATX_ATTR_APPEND: The file can only be opened in append mode for writing.
> + * - STATX_ATTR_NODUMP: File is not a candidate for backup when a backup
>    *                        program such as dump(8) is run.
>    *
>    * Two directories are tested.
> - * First directory has all flags set.
> - * Second directory has no flags set.
> + * First directory has all flags set. Second directory has no flags set.
>    *
> - * xfs filesystem doesn't support STATX_ATTR_COMPRESSED flags, so we only test
> + * xfs filesystem doesn't support STATX_ATTR_COMPRESSED flag, so we only test
>    * three other flags.
>    *
> + * ext2, ext4, btrfs and xfs support statx syscall since the following commit
> + *
> + *  commit 93bc420ed41df63a18ae794101f7cbf45226a6ef
> + *  Author: yangerkun<yangerkun@huawei.com>
> + *  Date:   Mon Feb 18 09:07:02 2019 +0800
> + *
> + *  ext2: support statx syscall
> + *
> + *  commit 99652ea56a4186bc5bf8a3721c5353f41b35ebcb
> + *  Author: David Howells<dhowells@redhat.com>
> + *  Date:   Fri Mar 31 18:31:56 2017 +0100
> + *
> + *  ext4: Add statx support
> + *
> + *  commit 04a87e3472828f769a93655d7c64a27573bdbc2c
> + *  Author: Yonghong Song<yhs@fb.com>
> + *  Date:   Fri May 12 15:07:43 2017 -0700
> + *
> + *  Btrfs: add statx support
> + *
> + *  commit 5f955f26f3d42d04aba65590a32eb70eedb7f37d
> + *  Author: Darrick J. Wong<darrick.wong@oracle.com>
> + *  Date:   Fri Mar 31 18:32:03 2017 +0100
> + *
> + *  xfs: report crtime and attribute flags to statx
> + *
>    * Minimum kernel version required is 4.11.
>    */
> 
> @@ -160,9 +185,6 @@ static void setup(void)
>   	SAFE_MKDIR(TESTDIR_FLAGGED, 0777);
>   	SAFE_MKDIR(TESTDIR_UNFLAGGED, 0777);
> 
> -	if (!strcmp(tst_device->fs_type, "btrfs")&&  tst_kvercmp(4, 13, 0)<  0)
> -		tst_brk(TCONF, "Btrfs statx() supported since 4.13");
> -
>   	caid_flags_setup();
>   }
> 
> @@ -190,4 +212,10 @@ static struct tst_test test = {
>   	.mount_device = 1,
>   	.mntpoint = MOUNT_POINT,
>   	.min_kver = "4.11",
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "93bc420ed41d"},
> +		{"linux-git", "99652ea56a41"},
> +		{"linux-git", "04a87e347282"},
> +		{"linux-git", "5f955f26f3d4"},
Sorry, here missed {NULL, NULL} terminated array of tags.
> +	},
>   };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
