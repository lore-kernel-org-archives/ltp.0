Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F94C32771
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 09:32:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA6223CA29C
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 11:32:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EA8E3C144C
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 11:32:38 +0200 (CEST)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2D87A1400DE3
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 11:32:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660901558; x=1692437558;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=2vGMXMDYvit3FeEvq9ccMCpgNFp5tRRMu5vq0r64Bs8=;
 b=zSEkZaJQz59ZdmHckXiiYFPfITc9CPOsX17Yt1G63c+Bn2usFFQQoybE
 vVF2Xtf6GyZBJh5SSG62N9pcD58zwzRZkiMhczd05Xf10g7fsgQFoaK3s
 H1/FbLUP2Azy/4cHMXS8eAXmRAT474TrYuSTE6Xyphjl9ONeHSzDNrP8s
 sAykoeb2IAFn32CbrakRdrzvxxzArFga8Ktl4ShidFXS11h3VgNig1jk3
 OgNY9q1AitaYwlM/McX+04EOf+U4YP1B2q5ONRDtRIIeM/lietWlw4Abi
 Fn5yd+uAvxNQDshWeBJo3r05chaXMn5eQfr0pAAY3FwN+bP94cS3u+FcW Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="62962915"
X-IronPort-AV: E=Sophos;i="5.93,247,1654527600"; d="scan'208";a="62962915"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2022 18:32:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOeyPkYfzqTCXm7M4hVhIuhNZUjfmn/eUaN6h5fH97Jfil/FTUuulJlkK0lsnRiRIOMMOGiY5sV+gQMjOwv94vjH42UK1k7/nETC+yG7TCjW52/rlZsX6I8zF+xhxXaWnIMP7MBH4dpBR5E+pZLWLufoiqyP+DYs1TltWvzpybHP4tdWF0IWjiCh+HmKTVN5h/ZQ770MDqfRIsunOgUaCFvqtfMdVuaZfK0+5oYoMQmhcJCJIV7PuzOt+IDUhdFc8BqtLfatX8iY7UyKP+WlBbUMJjKWh/GXBRewouGJPeLfmfc1kdJQHo8RmeNprNkst6y1d4RWXdR1UyfiG9hElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vGMXMDYvit3FeEvq9ccMCpgNFp5tRRMu5vq0r64Bs8=;
 b=fKXgV5lPyD6cZR9hbfZQXOimweMa9dUz0nJmfCROo42sd1qedQ2iazEgnNn1b+xsLbAiXGvg2EcoMuuu0CAYmSxOUtvfaZysxaAkVEW+6/gNLONPkINaGxoVD0mVN0JeHhUh483TpHOe8dd6ruKvNFxXYqmZKbN1poaxfFuJ9dymPnR+AmWxC01w/9Uy9z8IzjtELkcmp8+3hPSHqG5xowPUcQSRtgL3uSqeGgxloy4dhTqFxbsZGadAJj4PFmdk7IgMm4WBJl4MleX+lUiobECCDJFJfE468dG1qIPYfXK/Xp/sY3tLR9wcHYENm6Ocg84sUqcvNTFSHA5QzLzufQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB8400.jpnprd01.prod.outlook.com (2603:1096:604:193::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.17; Fri, 19 Aug
 2022 09:32:32 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.028; Fri, 19 Aug 2022
 09:32:32 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "liaohj.jy@fujitsu.com" <liaohj.jy@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v2] syscalls/openat01:Convert into new api
Thread-Index: AQHYshxjcP9OinIy7EGDXtYGl9tDKK22CgCA
Date: Fri, 19 Aug 2022 09:32:32 +0000
Message-ID: <3d8c98e8-8a0a-cbd5-2b13-9ebd33e61231@fujitsu.com>
References: <1862883.hHHqqg6b1x@localhost>
 <1660728765-4544-1-git-send-email-liaohj.jy@fujitsu.com>
In-Reply-To: <1660728765-4544-1-git-send-email-liaohj.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a86a43f-f37a-4366-fe3e-08da81c5be35
x-ms-traffictypediagnostic: OS3PR01MB8400:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: egBEBAxuZoE1kvbl924evANqbvngjRF6lchq2lmUmstH4Y6hULv1w6HqoLZjYQkU4Fhd5/SAhbH/YQ6Kk5Qnw8rSxgCCkX+i0fouISK78iB+HmOeP8nE4LyfOW0CrU97vp+i3hMwTIeQtIVfUOy0TyWLuvja7SdKxu2OmVVKukTMyDQcaXJxXjLBtB0JnWwmnxzNq57plXA5NxtaY+tC6oijGO4H72x5EGUueiyhNIFASWIybPo2XVYlrk+cWfiQA4W6ruygtnhlP/kD4VZMlySDMZL8VndnK+1KVNyFCwbi6anEfQ33CH/BMer7EdEixtmOw2yrn5cR2MGZYPkadzgmS39dVA/TP28W7L2oMGSdQhCGRdYqxqM1+1Nf5MEIcuuTDTqM870u1+e1gFQvsguatPtA/SD00jVd0N+eAiA9B/p3PCBG79lbYDZl4jVlGMNVgWIitn3D/y1+Ld7lnhZbpC/CIrxnMfwOUERoJFb03At9VLJXP6pRSO0LxPnR7emXBDmG9u8AU3x/R57IgslFsw1+pRRsTJ/ntaSMcqfHpGzqkRvjkrzSLn1m444/VKfvudBWjZ5kHx/Vxd76MgUP16C8n7DY7IwdLh6CWJJjUJ/gwhhZrj8TL6h/G8g8c5n5vEIICOV1ySGNYegzUFt9D0fZ6xFfFk13gRHtlIs4XW3SzW3ooiBlplP85xR6w6QcapDlsES8NlzNSs3YeUubMbOhnqUeaNxqSSwo4GiP9ZwU7RDBipBorpzH+e2D3sqRs0C6tbHbnLa5uKsO1I+Ma9p6kw1PpX1c8i+DyWV+m3i26gGGFTC7f7hWFJ8egTqv7d87a8hJFBMl7beVYzIaSerou9pjeEpburR2+ms=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(71200400001)(91956017)(316002)(6486002)(41300700001)(478600001)(110136005)(8676002)(5660300002)(64756008)(66446008)(66556008)(66476007)(76116006)(66946007)(122000001)(8936002)(2906002)(38100700002)(31686004)(36756003)(31696002)(86362001)(85182001)(38070700005)(82960400001)(2616005)(186003)(1580799003)(6506007)(26005)(6512007)(83380400001)(2004002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFBSWDc5Ym9RZHQyRkk1aGYyRy9nRkk5Y1Fsc0Z0YU1LU1pOV2MxWWFiZFV3?=
 =?utf-8?B?YldETDdsYVFldjB3NHlaRFVHdnU2bFlIQi82MXE3bHJGQ3FZOWxWSGV5RVpS?=
 =?utf-8?B?Q0xBQTBXc3B1NWFjYXRQaWdlSUZ3eXJjWjRIRTd6c084bzJDU0loZTVRVVRz?=
 =?utf-8?B?NWkwM1pTcTZkNnowSTl6aWJyYm4xekZ4K3ZyQnFyRVRyWE9COVljcjladUhw?=
 =?utf-8?B?Z2xZYU9GTzZvSStUQlFlaUpjYzByNEtyU0wzY1NsZGZMTlNBb1VBTjllOHZt?=
 =?utf-8?B?VEdlVEhrQWVuUDBUdXBLMm9wNnRQMXkxNktEa2NLcTNSb3ViM0VqYmc1UVZE?=
 =?utf-8?B?aHpxR2VtcXhsSFJic0lCSTdxd1hiWEc4TWZOK0VaMHprYWx5SWovajJzNXF1?=
 =?utf-8?B?cjNHRnpobFdSQmYzQysyQWRZR2JMOExyOWFpeml1TTcrb1EyeDlZOVZwYlRt?=
 =?utf-8?B?STVYTituWVkvWHpEUWRiWG1rYlRhei9yQjhEaExHL28wQzBaVHVXbDdCMUJs?=
 =?utf-8?B?QlI1bkFzSHdiSURnaGFqd1FHTUtZemFxbVh1bmI4OVFiMXkwWkMwa2pNQkpN?=
 =?utf-8?B?c3plcG8zMDIrZ3lobWN1VzBZVEwveDR0Wnd1WFFUWFI3ckNuS3V4T2tkbGlo?=
 =?utf-8?B?alJWYm00NkVyTXJDMTJNRGVodlJlRDh2STNvWDU3UGtjNERJM1NEZEtEZXNj?=
 =?utf-8?B?T0FwSEZNRDZKMVJGSElheTNLVHQvRjE0aTNlR1phSlZsdXh3enB6WVovNXRa?=
 =?utf-8?B?Q1ZxN3ozZjgrdWZUcU50c0pJbU5wZmNBTXd0MTBmbGcvZ0NUbUNtVlZPRmdw?=
 =?utf-8?B?WTZqOC9NTzM2dWV0YVdHVVk5TWpEUlIwU1l2K2FHTTlxajV4WkJ4ZUZEQjJW?=
 =?utf-8?B?cFdvdUtwOE9UblJGMUJWVGE5M2I0RWMzRjJER1pwbFhoc0c3TDZKeFBCdTVE?=
 =?utf-8?B?bERlMVVKNVplY2FjdmUvZC93aDRRU21qREorenYxMEdhRnJRL3JvUll4WU5J?=
 =?utf-8?B?NEFmZDNVL2VzNXJQcDUyVzRhNzF6Zk9UL0EwQVpGNXJPMnppMlNpSVVYN2x5?=
 =?utf-8?B?SmdzcmQ0V2tWM2NqUlB2dG02dUZOWDFwRUpRMEh3dEMwZ1dheWxSWlRydVIw?=
 =?utf-8?B?VDV5M3FYZm0ycCtwSTZMbE5YTFp4ZXFmbTAzbDd6OU1rUUVYMTUvLzcwS210?=
 =?utf-8?B?RGJJRFpCMHFvWFRocE9zV0lMZjR1aTdVZ3YxMHFsNFljMlBsblVxZXFZbWw4?=
 =?utf-8?B?R29qY0RCOXY4UmpRQjRRWjI1R2RRVzRqeFZ1M1RxRWZOd2VUajM0akhrS0tp?=
 =?utf-8?B?dDQ2dkVvcUFUeGgvdERRaGhEb1hPVUxsMmkxU3Zhd2pxM0dDRUJyd25ETFgz?=
 =?utf-8?B?TDdRN3R6aE9Na0NFdURvYzgyNXhPbWxuT0g5SzJSSmxtandlQng1S1ZEV2Rm?=
 =?utf-8?B?ekE1WFBFMHVLTDk5UjJvWVF6bHFGUkJBa2k4VmgvK0NYMXFQZ0pwSFMvK1FY?=
 =?utf-8?B?cDFrL2s2SVM3ZnR6a2JFNWdJQmNzWWRNZGd4SDltRmh5RkZVdFc3RmJxcG5l?=
 =?utf-8?B?dVZYSjhjWmhZbDk5ZWpRbE1xbDRzbFNtamlySnVrN01Jd2Rra0NSTnRRdW5W?=
 =?utf-8?B?TlVyWWphNVVmdGYrRFlhQTdVU2JkWEVJbkMyeVlNVmNiN3pDWWwrai9vQWRl?=
 =?utf-8?B?TTBnUE9ZOS9HcVZMd1h2RXkreVliKzVhdVFpNUphbzAzZ1VkT21PWmRxNmdl?=
 =?utf-8?B?MmlyYnhlUVJUd2RzbEliN0tkMGpRemRNZy9BTlU3dm9kalVTUWVMMEpFUkVF?=
 =?utf-8?B?ZnN2UFdGVzJDV0Q2ZUVJdjNqTTRjOUc3eENLeVhlaGtPWElJZWc2QnRtd0RS?=
 =?utf-8?B?WE43YWp6MDRxdUlFQi81VjNZeUZGSm10dVZKU2w2M0l4amliUythUFo1dXBI?=
 =?utf-8?B?Q0ZrdGxFYllaZzJvZUc1ZTV4cnEvc2JPM1doY3JmbEFvdGpFeXl3RVlnVEIy?=
 =?utf-8?B?Y2d1aXZxOFc3bFo3YmxaMms5ckpmNjhNR2RTdGtlMlV4ZVFOaktpYUFTalRC?=
 =?utf-8?B?bEFzOGZzOUdCZ0ViSHF2eXk5SkFiVzIxOFJ2M0Jnd1BjeVFQdGlVQmdDSkZJ?=
 =?utf-8?B?TkVsUHQ5QjZWSzViL2ExMm53MWJSSEovbWpRakNZZTlsMGl2RGtsb1pjdlpP?=
 =?utf-8?B?Nmc9PQ==?=
Content-ID: <3FE3C665417A0B48A092AE47A0651EA7@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Lv7lQeMVmGZtauGWb8wuhrN2XRPrQcX8wDROSIEMaKTU0u/MzFVLL5JfaKlIWCMu/s0k2gb2LI+VLpyOSB3sEeDwfVJCkAzMGqSEATzjSppUUMUtSC1cFguMeUkDjcyCaJkRMyWwqKO42UUPwz2qmiLyD1RtQJ8zZP/PRR9IP7dzg2f/exDjxhifbIiehjr3NFZRc2QkXlYFAGcCwG4oqJxrUIEXSqlHEy7YpYBbKP3gIALO8godaRNeWXIHWhBKdSTZbHK/qM7/IreQ2cDHdMOC+p5tA2/MQzpOxJy5KNY3VcULUnaeST90ecXpkSwCsZ/IrBErS3CGpclDAFZY5yKhElRleTkgAmnMKLG5/HPBOfLlt1R4pT6VG7zVBHQLlEX8qOvACMfrOWU9rJSbAdELpj5ZA0iX1xrUgAR18s91rcEuigzYAHxF22oYTv6OITsngIG7XGE7sodonsFQqed8/NFZLGeA9z5jeTCqwd6t1Sqd7/nqK1KdnyPV0RF5vXWGMcHOFyzCMcP3mADhBNR8ngVS9YyeF7elaGof51hAd96x4+UmtywguVa2xLil4u9DZI7AzjjH6tNrKMUEKlmxtZL5/AW1rsCNkqCkjCtCMMlMupWuI8yvpYpI7qmtzfBhgtohfkkQdq7C9JgKIkYD9VpmTlfEnvhZnkZ0dCrNTBNiXU3ehkH6Bd3mZQh7VW0aJH5x/vljzoua/F/mgQ==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a86a43f-f37a-4366-fe3e-08da81c5be35
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 09:32:32.5940 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynXk3dm0NzUNr2hmrZEJLszPMPmGVzFyNNAs/eJtRyaD7Gr4kxXNaDLCNj5Yzsl8HxkfCMDojY5z/6Bep32G7ZVofMdidd2K24c0Uj+ey7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8400
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/openat01:Convert into new api
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

Hi Liao

I added detailed test description and merged, Thanks!

Best Regards
Yang Xu
> From: Huangjie Liao <liaohj.jy@fujitsu.com>
> 
> Signed-off-by: Huangjie Liao <liaohj.jy@fujitsu.com>
> ---
>   testcases/kernel/syscalls/openat/openat01.c | 148 +++++++++-------------------
>   1 file changed, 47 insertions(+), 101 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/openat/openat01.c b/testcases/kernel/syscalls/openat/openat01.c
> index daed419..eb7f70c 100644
> --- a/testcases/kernel/syscalls/openat/openat01.c
> +++ b/testcases/kernel/syscalls/openat/openat01.c
> @@ -1,55 +1,31 @@
> -/******************************************************************************
> - *
> - * Copyright (c) International Business Machines  Corp., 2006
> - *  Author: Yi Yang <yyangcdl@cn.ibm.com>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Internstional Business Machines  Corp., 2006
> + * Author: Yi Yang <yyangcdl@cn.ibm.com>
>    * Copyright (c) Cyril Hrubis 2014 <chrubis@suse.cz>
> + */
> +
> +/*\
> + * [Description]
>    *
> - * This program is free software;  you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software Foundation,
> - * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - *
> - * DESCRIPTION
> - *  This test case will verify basic function of openat
> - *  added by kernel 2.6.16 or up.
> - *
> - *****************************************************************************/
> + * This test case will verify basic function of openat
> + */
>   
>   #define _GNU_SOURCE
> -
>   #include <sys/types.h>
>   #include <sys/stat.h>
>   #include <stdlib.h>
>   #include <errno.h>
>   #include <string.h>
> -#include <signal.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "lapi/fcntl.h"
> -#include "openat.h"
> -
> -static void setup(void);
> -static void cleanup(void);
> +#include <stdio.h>
> +#include "tst_test.h"
>   
> -char *TCID = "openat01";
> +#define TEST_FILE "test_file"
> +#define TEST_DIR "test_dir/"
>   
>   static int dir_fd, fd;
>   static int fd_invalid = 100;
>   static int fd_atcwd = AT_FDCWD;
> -
> -#define TEST_FILE "test_file"
> -#define TEST_DIR "test_dir/"
> -
>   static char glob_path[256];
>   
>   static struct test_case {
> @@ -65,80 +41,50 @@ static struct test_case {
>   	{&fd_atcwd, TEST_DIR TEST_FILE, 0, 0}
>   };
>   
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> -
> -static void verify_openat(struct test_case *test)
> -{
> -	TEST(openat(*test->dir_fd, test->pathname, O_RDWR, 0600));
> -
> -	if ((test->exp_ret == -1 && TEST_RETURN != -1) ||
> -	    (test->exp_ret == 0 && TEST_RETURN < 0)) {
> -		tst_resm(TFAIL | TTERRNO,
> -		         "openat() returned %ldl, expected %d",
> -			 TEST_RETURN, test->exp_ret);
> -		return;
> -	}
> -
> -	if (TEST_RETURN > 0)
> -		SAFE_CLOSE(cleanup, TEST_RETURN);
> -
> -	if (TEST_ERRNO != test->exp_errno) {
> -		tst_resm(TFAIL | TTERRNO,
> -		         "openat() returned wrong errno, expected %s(%d)",
> -			 tst_strerrno(test->exp_errno), test->exp_errno);
> -		return;
> -	}
> -
> -	tst_resm(TPASS | TTERRNO, "openat() returned %ld", TEST_RETURN);
> -}
> -
> -int main(int ac, char **av)
> +static void verify_openat(unsigned int n)
>   {
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		for (i = 0; i < TST_TOTAL; i++)
> -			verify_openat(test_cases + i);
> +	struct test_case *tc = &test_cases[n];
> +
> +	if (tc->exp_ret) {
> +		if (tc->exp_errno == ENOTDIR) {
> +			TST_EXP_FAIL2(openat(*tc->dir_fd, tc->pathname, O_RDWR, 0600),
> +				ENOTDIR, "openat with a filefd instead of dirfd");
> +		} else {
> +			TST_EXP_FAIL2(openat(*tc->dir_fd, tc->pathname, O_RDWR, 0600),
> +				EBADF, "openat with invalid fd");
> +		}
> +	} else {
> +		TST_EXP_FD(openat(*tc->dir_fd, tc->pathname, O_RDWR, 0600));
>   	}
>   
> -	cleanup();
> -	tst_exit();
> +	if (TST_RET > 0)
> +		SAFE_CLOSE(TST_RET);
>   }
>   
>   static void setup(void)
>   {
> -	char *tmpdir;
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	tst_tmpdir();
> -
> -	SAFE_MKDIR(cleanup, TEST_DIR, 0700);
> -	dir_fd = SAFE_OPEN(cleanup, TEST_DIR, O_DIRECTORY);
> -	fd = SAFE_OPEN(cleanup, TEST_DIR TEST_FILE, O_CREAT | O_RDWR, 0600);
> +	char buf[PATH_MAX];
>   
> -	tmpdir = tst_get_tmpdir();
> -	snprintf(glob_path, sizeof(glob_path), "%s/" TEST_DIR TEST_FILE,
> -	         tmpdir);
> -	free(tmpdir);
> +	SAFE_GETCWD(buf, PATH_MAX);
> +	SAFE_MKDIR(TEST_DIR, 0700);
> +	dir_fd = SAFE_OPEN(TEST_DIR, O_DIRECTORY);
> +	fd = SAFE_OPEN(TEST_DIR TEST_FILE, O_CREAT | O_RDWR, 0600);
>   
> -	TEST_PAUSE;
> +	snprintf(glob_path, sizeof(glob_path), "%s/" TEST_DIR TEST_FILE, buf);
>   }
>   
>   static void cleanup(void)
>   {
> -	if (fd > 0 && close(fd))
> -		tst_resm(TWARN | TERRNO, "close(fd) failed");
> -
> -	if (dir_fd > 0 && close(dir_fd))
> -		tst_resm(TWARN | TERRNO, "close(dir_fd) failed");
> -
> -	tst_rmdir();
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
> +	if (dir_fd > 0)
> +		SAFE_CLOSE(dir_fd);
>   }
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test = verify_openat,
> +	.tcnt = ARRAY_SIZE(test_cases),
> +	.needs_tmpdir = 1,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
