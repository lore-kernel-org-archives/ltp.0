Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0E3C433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 02:52:47 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B080610A1
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 02:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B080610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0F0B3C6873
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 04:52:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA6553C6730
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 04:52:34 +0200 (CEST)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DB17E140026F
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 04:52:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1635303155; x=1666839155;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=LJV7znzi9xdmWvGLbK7ATCOm2Vr5usDv6+fez1iWUwA=;
 b=mnvPAuFgzBwHxwD5iVoCbzuQFJIuzr0UF69hZhdIv6DL/4+b9qoKcI3N
 dAPipVobh+r7z3KSV+C9pGI2Gqu7nZdW2Xo78knA0aMD6s5iHJv0wfR8m
 3vCN5RipeMyzc878mmy0LSzD7H8sTBxv06SbM5XDPAzPrZdKCHKdTTW6x
 0GiIT9N0LVDzsM16e/QIcHn6hGzgxkZhXnmCYbSsGnMQgQzACKpjrKawt
 VMSFzUbB6jhJr0mOe0otKWDLph/hL9rmHGSh3Ltibelq8J7IyW/JdrBT6
 oapwaw4me+r9qmFOlX1We+KRgUaI4emiuW14/WcksOy6dpv0QSxfnyytQ Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="43025170"
X-IronPort-AV: E=Sophos;i="5.87,184,1631545200"; d="scan'208";a="43025170"
Received: from mail-ty1jpn01lp2052.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.52])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2021 11:52:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/6EQVr7QUYJCBAKXXBlwTk04nlQm+GMTscP+rZvVjnhvAVO98G3pFKC89Ug8su7Ue1FujD98Zf839+DSnvF656eCKPsbKEo3bcMp6gUCVY9woEtMTYC/vTrpd2Euzf8y8UyRrAHdteeFyJDCe40yhWvwW2I+zHuuAYavaFscZvhoyzvFtsAwopAAR6EEqPdhgtsBBTl9+Cz0zKSDb/m+XlYfP/9ruKzeUD57I2t8n0dt2/xpc0u270x8xW1DNMpcBItyBpVIWq1lTbak8v146f4IaUkwi1K7XL3bbm6gsLuTIsDY+OXlKel0as648f742WufLNrBWgLujrqm84ncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJV7znzi9xdmWvGLbK7ATCOm2Vr5usDv6+fez1iWUwA=;
 b=mbBy8SDHxACCdJXITGmJnktj6Iok5BrgEaWNpN+rN4r6/Ka/vQ56PA/DkNnLGxpc2Jo9i7OwIdum6WOQH3179l7WmNnd+wa8nfvv0JGJuIwpIfKFJZWNq6//8rVjXJ9+tbw8tw4k3qACzAFi4lbOhW9u+kufyoo0Dio6VUAPLFR7exBpE6LBjb+HGJz1gMwYiY0G8KZ0uH4zZtcOIqYoJhmGbcNCODQKXNMXLI/1fy7YYBdwCD1Vn/svvcb1vej4K6/H7B5DLMxf6YwGLCsmd8n/fskNKAgfMY7Lnc+gD+ihdQwZOOIF47wd6NO8W33ooo8tPh7Ijj6CE5VUWrOOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJV7znzi9xdmWvGLbK7ATCOm2Vr5usDv6+fez1iWUwA=;
 b=W1Q/vdvL4QY322xbzlW402mVXzezGoCFyB8V+n+i/sOLuFTUWRAuQOBfI2G7Op2CWofonEf9hOQHJrvsssRMf1VMXXpq9oeJ+BmFCmtaGyggLekjCdZogLVxe+SM0muOoZeD1iGhz1W9gNlz7J+R8k2fTr6DgI5Vlp8ELsfnYRI=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYCPR01MB6737.jpnprd01.prod.outlook.com (2603:1096:400:b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 02:52:29 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9%7]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 02:52:29 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v1 03/11] syscalls/quotactl04: Remove useless
 quotactl mount options
Thread-Index: AQHXxCGGe+SkXKK+2U2OEP6F+5/X2avlXCuAgADW84A=
Date: Wed, 27 Oct 2021 02:52:29 +0000
Message-ID: <6178BEF1.8060509@fujitsu.com>
References: <1634562591-5830-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1634562591-5830-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YXgKoQ72mqFN6uD3@yuki>
In-Reply-To: <YXgKoQ72mqFN6uD3@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cbe6237-7028-4c9b-5e19-08d998f4d0ce
x-ms-traffictypediagnostic: TYCPR01MB6737:
x-microsoft-antispam-prvs: <TYCPR01MB6737710B4C43324A83043614FD859@TYCPR01MB6737.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dWiVaeUM6YFnVd4XJGqnHUTd3T2qHoF7qM246a43UqPsDEVagZ4x4wGKdnoXtZZeWPkINWx/YMJIIy7WoOkwIF0rf4oEVGcro9VSuO1rRHDl+vqtl+x5VpeKX3BkBF+4IFK6/r4i+DKD8jI/SLQjfUfmL9GQOtsG3kvuPi32zUT5QMZLB/6wu3FLphUglnzB8tzL0BwXVaLbPPNRYv8zsXXojeAU4iv1nZoP1QWL3HJa65THi0YCcxxj2QW5SR8So2xNsPbR6DOUyRkbVbgIGq3EL7KTu27OPhgfGonIbdje7giBrWo8MSxl+NvZFZ6IgObr01hnxJIGkFMeqbNz2nCmYhkx9mHTYWvDOLd4OLMtfWsGU8GBhTQFvNGjEnr9KvwWj0IxUabSS/GNyXBMI8F32PZQL+9Up1jrBPs+K+dRGyrKa04CdhPB8UVXpIAevEp6+PdK6b84ek4tyOgsfZi5kRdvXvUIKQW5K3/iVIJehCxg3dM5VhPskbTE1R8Kx3ssY31USHRgQae5BURY21MhkatyCp082jFH0Gct/OVzBik0jPrqzHcOGwxNM2rNHO5O9gpDNSkzyF2Qlnb/vPjvktMwJlNY0bWSBATgkGtw5LN1gB+4akBgB3uyyJ8zWDogwtm/gzwjs2wT5LzS1eEA8iJCHJpBPlvFVi0RLTeOTSNUAyY0TD4ZZiADT4oXCdQyt6u7B9E+LC9rU1npxQ9OMJz2LdnbQSB1QrZjolwMDHqXWSJWAxPPpaMOKJgyr9cJxyE+SxDsJzkU7JkBjquXezjeMLb2R4+U2R/qs5GycTL+hwSKmgDbLj9QN488gb8mW3urN4cDHlaeC+TL/w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(36756003)(6916009)(2616005)(85182001)(15650500001)(186003)(6486002)(8676002)(38070700005)(33656002)(38100700002)(6512007)(71200400001)(8936002)(2906002)(4326008)(86362001)(83380400001)(82960400001)(87266011)(91956017)(76116006)(66946007)(66476007)(122000001)(6506007)(66556008)(66446008)(508600001)(966005)(5660300002)(64756008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eVBabU5wcjVrakJqNElaYlhDLzJxZUcrSG5paDlVWW5zN1h2ekVGUzQ3ZVNo?=
 =?gb2312?B?Vk0xbmdYR3dUMEVNYWl5NWNGb1YzWkRMbkcyZEhMTThmZWJjMzdYbWJZYkxI?=
 =?gb2312?B?bk80aDUvQWhTQmZ2aTVIQnNpMnRSRllZWVJBU2hMdEVwbDM0aDNUZFhGVCt2?=
 =?gb2312?B?aWU4cjdXeTQ2K3V6UXpaQlhSUkRyWnF3UDlwYTRQQmFwbVZlZGVPdmhycW9F?=
 =?gb2312?B?TkpMTFF5Z2oyVGhaTGRPa3pXNUVUZG9ZTG5IclhXRzVISkl3RDJXWExRbUpF?=
 =?gb2312?B?TStYUzVJUmorNW14TWZ6SE8xSnhNaUFnQUpCd09TSFZPTGhIbXJDTVR3eTk5?=
 =?gb2312?B?QkgxUnE2cjU0N3d0ZjVyWUFkMjJtOFI2dEV5ZmlSUzJnYXdVR2RIWk9kRmxE?=
 =?gb2312?B?Q3dkY0ErZHZSbEVWaHUyeXdlbEdNK1RRQmd3WDh0cDlzRDRiUGN5TGRhT2Fx?=
 =?gb2312?B?VzUvdHBwV1pmdUU0Wjg1WWZVaU5yK3EwMXZxRXd4dVhzWko1aCtwbmNRUGdQ?=
 =?gb2312?B?TFFKeitlRkFUQjlWWkNqaWgwSDFGb0xuR3owaGRIT3pmaXVjdnp6Y0txai9F?=
 =?gb2312?B?V0RVdSt5LzJzMUlMQkhMSVNuKytjV3dvN2V0Mk9UM3hvZnNBVFhHNFp0VDVI?=
 =?gb2312?B?MTFkWjE1M3dLMEdzRDQrbWFXeHJlUmpNVGNHczM4UTVDTHhMTVJIdmh0cnJ3?=
 =?gb2312?B?TU4xV2lmWjcwNHFLNGxveWdENmQza1pDSlN2ZDRtUFNHMVlUTWI5THZUWmkz?=
 =?gb2312?B?NmlyWVk0eW5uTVRBc2JsUzFiYkRjOWx5anlDQmFDTWo0enRDV3QvZlp0WFRm?=
 =?gb2312?B?Z00zRVkzY2srYTVBeVg2NWhaY0pTRmQ5aWJsalZSSDlNWHZVSlgxYWs1Wm9D?=
 =?gb2312?B?TEhKU2ZxNXBxWHVaT05lOFI1SVhtek1uTTRJZEIyTU8rTVVaUWVMMjFhK0Vn?=
 =?gb2312?B?SUVMQ0o1OUNkbEJHSWJ2enVhTWs5dVJQODJpZEc4S01icVhqcGZOWjA1ZWVw?=
 =?gb2312?B?QUVyV3IyMll1SW1acWYyYmpSZW91MnJCWXVpekdpams2WmdqOHZjQ01LcEFM?=
 =?gb2312?B?VkRwbXZmRWRWTUVsN3Y5NWZFVXkvR0pwT0N3V2tnOHcxTkJDR012T0FXR3pP?=
 =?gb2312?B?aFpPVWxNZ3krNlpxY3UvQkhFNDhrYnVteDg0KzFHUHdXNHd0a01CYjQwSXZS?=
 =?gb2312?B?c2FxbXdiTVlBS2pPbzl5OVlqaGRQY3dOTDJYZHJwVzJOMUdNQVpoSEpDcTZp?=
 =?gb2312?B?M3hwaHE3K2VaRVRHUEgvbGlXQlNjbGdsVEJpaFV2Y2Z5VFpjV2t0NkZHQnVx?=
 =?gb2312?B?c0M0Qng2TUxNUVJsM2RKc09WVG9aeVJJb0x1cHcwZVhPN2lEa3RqU0FjNTRz?=
 =?gb2312?B?Z1d4aDZPUTVXVzlxQXloMENSTFRGdWdvaFBiaUwzZEt5QVhoSWJQeHFXZEd0?=
 =?gb2312?B?OHB0VzVZNk5taTZLckdJYkREWGs1bXZ6S2FSd29NLzZBdnNhSFNwOHQxNmhX?=
 =?gb2312?B?RWlUcTNsQ2VTTWF5d2Y1YzlyWU05RHpvQlpuVkUrbFIyNXQ1aFNDMDJ0R3ky?=
 =?gb2312?B?U3pFeEhTUXg0dGJKUlYwNHl6Y3dBNUNiMFVSNDFjWTRQa2x1dVcxWkgvTlNJ?=
 =?gb2312?B?ZDJMc09zQzhrVyt0UWpmNmtvODc2WlVVdVZuQUdraGZlSFhNZnEyNlNzdEhZ?=
 =?gb2312?B?V0Z3aFhQblZJeEZSOEJuSGNqdkxCTGszMjZWR1ArZXhqTGpMd2FPSm9tbW94?=
 =?gb2312?B?V0xiZXdYVnVSbjZEc0VIZjQ5NXI5UkYvWkNIVW1sQ3FDbTRhanpEUlRDeUdu?=
 =?gb2312?B?NVRvcDJNbGVhTTUyY0VZbFc2UEJFZ09mQ1FOS2lwNFU0MlNTN2dqZFBLODJW?=
 =?gb2312?B?blRNMVBkd3NNLzdJVG1zb0tObEpYOUcvWmNxa3U4ZnBGSkR2LzU4Qjg3dStC?=
 =?gb2312?B?V3laNzNYalRrTzU1UmFjRkFyZU9YNTBDaXJvV1ppZzY3OCtjdG5BcmZCeDRJ?=
 =?gb2312?B?Rm9QeGc2aXpYNnQ3U0d5Tyt2UjNUOW9RWHhKVDFxVlAyYWN1RllCM0ZUS0dq?=
 =?gb2312?B?SUs0cGQvbFZiamptU0RKYkFlRFI4bDA4ZEh4TEp6M1JGM05ZWkhHNVkyV0x3?=
 =?gb2312?B?Umdoa0V6aXdISDJKMFNac29wSmZPbUc0eFNhL2x4d2NmSmd5L3JKdkl2VU1H?=
 =?gb2312?B?bUcxR1orQ3U0Qkk2Rms3emYrMnhsTWhFbjRyWHQxZmJScE1IU3hCOVJYVFNL?=
 =?gb2312?Q?29a9CaYKhVZit3lv6JutcGlGlX5Jj/ITdSLsUcL3Po=3D?=
Content-ID: <061CFDEED1AB6244BE33AB80F9061830@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbe6237-7028-4c9b-5e19-08d998f4d0ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 02:52:29.0979 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNuSkluI79N6o/uRL3uBSBT544JaA2Izh++B18ztAVl9qhZXrBlTggOqr5LubZdHSqgoFMBragRjZQnSt417nrKh+2IOFbvtkOTlrpBqSiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6737
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 03/11] syscalls/quotactl04: Remove useless
 quotactl mount options
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
>> When use -O quota options for mkfs.ext4, quota mount option
>> will be ignored[1]. So remove it.
>>
>> Also add docparse formatting.
>>
>> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7c319d3
>>
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>> ---
>>   testcases/kernel/syscalls/quotactl/quotactl04.c | 17 ++++++++++++-----
>>   1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
>> index fd3afc888..ca6a94263 100644
>> --- a/testcases/kernel/syscalls/quotactl/quotactl04.c
>> +++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
>> @@ -2,22 +2,33 @@
>>   /*
>>    * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
>>    * Author: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>>    *
>>    * This testcase checks the basic flag of quotactl(2) for project quota on
>>    * non-XFS filesystems.
>>    *
>>    * 1) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for project.
>> + *
>>    * 2) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
>>    *    for project.
>> + *
>>    * 3) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
>>    *    for project.
>> + *
>>    * 4) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
>>    *    flag for project.
>> + *
>>    * 5) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
>>    *    flag for project.
>> + *
>>    * 6) quotactl(2) succeeds to get quota format with Q_GETFMT flag for project.
>> + *
>>    * 7) quotactl(2) succeeds to get disk quota limit greater than or equal to
>>    *    ID with Q_GETNEXTQUOTA flag for project.
>> + *
>>    * 8) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for project.
>>    *
>>    * Minimum e2fsprogs version required is 1.43.
>
> Here as well, the list should be changed to render properly in
> asciidoc.
Ok.

Best Regards
Yang Xu
>
>> @@ -34,10 +45,6 @@
>>   #include "tst_safe_stdio.h"
>>   #include "tst_test.h"
>>
>> -#ifndef QFMT_VFS_V1
>> -# define QFMT_VFS_V1 4
>> -#endif
>> -
>>   #define FMTID QFMT_VFS_V1
>>   #define MNTPOINT	"mntpoint"
>>   static int32_t fmt_id = FMTID;
>> @@ -141,7 +148,7 @@ static void setup(void)
>>   		tst_brk(TCONF, "Test needs mkfs.ext4>= 1.43 for quota,project option, test skipped");
>>   	pclose(f);
>>   	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
>> -	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "quota");
>> +	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
>>   }
>>
>>   static void cleanup(void)
>> --
>> 2.23.0
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
