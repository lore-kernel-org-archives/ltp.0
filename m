Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D75C433F5
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 08:14:57 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36A2611BF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 08:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C36A2611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72CB23C08F4
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 09:14:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C5A93C0752
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 09:14:44 +0100 (CET)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DA2A76023FE
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 09:14:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1636445683; x=1667981683;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=GCruI/ZaB7pBX6fEp9rdJK7n7RjpPaI0AKxd+6yYOTs=;
 b=Of/lmUoccXHHzjiNv1+YOTC0fyNC3YYOk8Mt9zeNV5nT4PXbXtVKpbHB
 kdbEnYzp3bWkTha8yW1n2BkodrSgXmVlbFQjYGlDYGQy+/blDf9w63p37
 BEO8dSzMPa583w6a5Uq6oUXffSsOXSR2Mrq5K5UFUFxgq52sNu6LLEEtg
 t/7ZIk1I/VIDEZOTfugBtUWzHrtsSovPG2wovLHlawrfMS7TSTfGdVnaT
 QyFmnCFFZjPRnOQbArXEoO5rwy3Z5R9NO1jxYuKfa/tMkcRBpArH2TdKh
 K57mV7NVvCMhLQtDpNA3o8nBiz2fz7iW8us8XCDJi/6c9lAMMP3ZkRWlb g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="43206671"
X-IronPort-AV: E=Sophos;i="5.87,219,1631545200"; d="scan'208";a="43206671"
Received: from mail-os2jpn01lp2051.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.51])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2021 17:14:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9rqC4nsnUImPg5r4S4XOM2dsA4widiwQieV/yyJn9Il1A6qsFHMSpBeELzaoPhmstWNI4o3FzucLP6GazmGlQjDQES51bbXxPs3R7sjNSrCpd1hCVaplcnFcODkZx5P40AMBaN1G7KhIL5+ZGcFNrKTAEgtjgkn5fkWAoNkiuV3uwj+1q7b3CumU1XL9bw9M13TZUrDuVKAPLaeXxAJFjh4PQuTANc+EN+ZmBr6aD8f+6VN79Of9N5iAHxmp6x/DUY1eyiuMv6vtd5Yp9RN4KzqTAqg5ElUrImJAEzlytqit9vbanCwkMEIalfs5RlTbh0E7RxsTR+ksTdFf66pNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCruI/ZaB7pBX6fEp9rdJK7n7RjpPaI0AKxd+6yYOTs=;
 b=GRL3rhkvRK2nyxVjhz8qnv60mAz4pISPNPiGxkr7nlZPquaS4ev5C5lRJjS7nOdjkFqlF8zBiLFj2U1zkfDVJ/reB3XCgANqFFUrbt50ANjaHKnvdFsbpUEw5NYLxgoyVkrSVjtszZXDM0siJe1qAAbPHmrF6ECf0R1y9KAWSHaUg1grNyLtnrMD+wZoJ6MUS0MhZfNWTcZy22V0CDEO7pwST4M6tJTbZoE46+/m+bSOP6AdpsVIDgptL5TYScBnSxwLPBvIrQPIj6cUD4V1fA+ENXWXU4eai6I4PZhByLFLxNUFQ1FHgnqIz8Y1yH3qjp2078ucfsk48sB+MQGYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCruI/ZaB7pBX6fEp9rdJK7n7RjpPaI0AKxd+6yYOTs=;
 b=pgBWqwlnNb/JGkTLsF9x7uHSspOASKuUtSc/7iK2gBLkz0DPd0k+ztspTS+xmfBh+3Hn3tRXu19ATKxcE8VZJhFEXifpRFYm4lSFUQj9KVms3euTDFCdomervDQ/NFu9pN/cepN3NL6Rnz2WK8zvA4ioS1HTAwFLgTPICASatAs=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB2187.jpnprd01.prod.outlook.com (2603:1096:404:d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Tue, 9 Nov
 2021 08:14:36 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9%8]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 08:14:36 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v2 03/13] syscalls/quotactl04: Remove useless mount
 option
Thread-Index: AQHXyy3e8LoMyH4WF0C7VmHL4Dsv0Kv5148AgAEVyQA=
Date: Tue, 9 Nov 2021 08:14:36 +0000
Message-ID: <618A2DF4.4040700@fujitsu.com>
References: <1635337569-4634-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1635337569-4634-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YYlE7jrR6nSeu0x1@yuki>
In-Reply-To: <YYlE7jrR6nSeu0x1@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9734fafb-a8c0-4a69-9a07-08d9a358f81f
x-ms-traffictypediagnostic: TY2PR01MB2187:
x-microsoft-antispam-prvs: <TY2PR01MB21876615FCEB49757A9E5798FD929@TY2PR01MB2187.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: InI9kxqvcl7HpBxHlkyt8ZBLOY4C8EsUe1KWGIuoo7A0Uhwxhudr5VIMR8ZTzBWB8ioAQdCDoSL87oY8EtOZb/65X8k6upLAehUROAV+ygubeernGNO46mE2Tf5hla89nTrj27sRvGeJIAe407bGA4ntkfqsh05aG3ml9vAvh2MiWIZNMoQtV2ptJ7L0SuHkIMZP43mlOo4XIQTahVw8NYfPoboI8fgHujQ0962MEHRFaq7ediwaBTQwT0Kmd/iBlQHkZLZ16o1Ef/JKdZeE0/UyxBHn0hLSt/JoBNgCuUSDi5tflPgDPckAevvgoD9e88bkyoJAIp2Vytj/zVpR891jR26WpHeqFn8hS8heOO3l3Mkhr0TMivk/JQ05T0HShxLKegX8HYoIjvBkfUMQ4WMjygC8urhfBEEV1iCDUnqUvFHRdo4YK40SvJaVDR6A9ZzlJH2i1HGOQTanahTVpLJUjOmpEwAzh3oUkGjhfTBLKFCL4ucqTKsP/V7c8x8JcHuifLnw8HC2KCNYzlfQXUOz+fpOKbPS/sLoMhAzGM0BZB17QU3xapwWsBGUSMhe8Y+eL62YmOglIY37Not+tSG2FqaOMRvzWDFDFB924cSFy3ZkB0imgYOvbMx9FZYh54m/KGjb6bk3OvcjM/HKr5Si63xalPL/05BdpO64ATfYuoTrdW2Yrg2kGGp7GWfAOK4Y3jd/Qxcu02WTq0A+gp58865aJSW7YXkDW8KGaiQrzu06o0U+mOOG24qXGiBKfA+q7ShNNfH9oS+x5odq2UZ6FSPtY/JHoqJpGthtxl7yTa8v/ifBenacR0KsR5Rqv1YAibuJZXci6Tl35EpO0w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(82960400001)(86362001)(316002)(6486002)(64756008)(87266011)(66556008)(6512007)(33656002)(6916009)(122000001)(966005)(38070700005)(66446008)(66946007)(91956017)(38100700002)(8676002)(8936002)(66476007)(508600001)(85182001)(2616005)(6506007)(83380400001)(71200400001)(2906002)(36756003)(15650500001)(4326008)(5660300002)(26005)(186003)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QmZwSTlpMlhvbUt1N1dJVmNyajBMbkxyWTN5UlpYTWI1czlOTnNxemRrVlo5?=
 =?gb2312?B?WndrbFVXU0xSTlIzRlNEZWt5bzdnc1ZhL3hZekhVa05ack8zcXFUbDJHVXd5?=
 =?gb2312?B?MnFHd3NvRXd6OUpPYzFGNDRXVFBIZmNPdmhDdlVLOE9VYlNjc3ZLNXBsSm9Q?=
 =?gb2312?B?WForOUVDUEZMNGY5RS80V2QrMHdFRzJKWkRKWU5CUGFVZCtVSGtBTDBkd21R?=
 =?gb2312?B?V0ZBa281RU96VHRDb1RMYUJ1dHcrR1hzSXRqYk8rTVRaS1ZOTjJMRCtMZkxy?=
 =?gb2312?B?ZW8vR0paMENtMkFyWG1YV3dXTmdwUWJsNUsxclN4NWNoTkNZMys3Zk5UbTFE?=
 =?gb2312?B?UStEd0dWOXZRYUlxSGJoSlhKZlEybDhSMHMydWZZck1lT3d6NnNCdjBRY0xw?=
 =?gb2312?B?OHNOL3ZDUlA0VDBIMTYvQmFSZFJ3ZWdoMEo2RGkwMG45UFZmNUFYY2tTVUYx?=
 =?gb2312?B?UnIrK01nYmZobkNNb0hrNXNCVzZ5cHdBMFFITU1ybkUvY09HUVViVnNFMWJo?=
 =?gb2312?B?VEowc3Q4RGQvNnVuaU9LcThjU3FuelBQVExCMEsxdXJkQW1tUW5ad0dxaFJB?=
 =?gb2312?B?UGZ5K1RtOWQxTHhsbUV2M1FpaUd5VkFIbTBuNkJtNEhZV2pweHpQY25WNTdE?=
 =?gb2312?B?Ylh4VXFnb3JWQ1NGTzhLMUU4ZGxUOVFUL2YvWnRDZHJnM3dPb1hjK0ErekZw?=
 =?gb2312?B?Sm9telNhZ2dQV0F2U0NEYUg5alZzT0E3Wnk5Y0p1MXR1aXpmWkttRTBSRGUv?=
 =?gb2312?B?clZzWVpUWTM2TjFobjRDZEF3SHYzTGFDaURUM1hHVjZMd2xXUEgvK1pNK0FJ?=
 =?gb2312?B?MWZYSmVENHp3M1RjanJVenRZeWJ4UWdLajY0cytXVXphbFNESXJGVXN6UU9i?=
 =?gb2312?B?NUk3LytKWW9QMzNManBFMk9HczZNN0gxZ2JWK0lwOFRjSVVCUEhGanQxV3BH?=
 =?gb2312?B?dTBVREpJR09PaExNYWxzZGJnRDgyeUwrUVg2VEtFOEJ0RHBuaUo1TXJXalQz?=
 =?gb2312?B?WnBGZG5WL1hyM01pK0RkSWtRWGNjM2NLMmhlMlhoN1kxTHZNMU1RcDVtZmpF?=
 =?gb2312?B?elRqWDJ3VDJoZTBoalBYQStzQlRnWVc5ZDNBRUdYMFp6SE5TT0VPRnpSRDdE?=
 =?gb2312?B?c0JBa2xWVld3c3RaQm1CeGJyVmE0YmVPT1pBRFRYUDNQRkdPL0I5bFlPMHBQ?=
 =?gb2312?B?cFhFUFMzT3U1WWNQbVIzSU9iR3Z5dUh4b25tampYcXhFOFVTN0hCN1p6djN0?=
 =?gb2312?B?Q0xzM2VONjZWZDRzN2RDWEFMdVR2L29MSFd0YktqcWVVYS9GblowVlNiWVZq?=
 =?gb2312?B?RUJOeHBMUEw4TGJGWnk5SnBrSEZBVk9XSTVhaUs2dHEwUlIyckJzZEtjbjlM?=
 =?gb2312?B?bVJIaWdBSUZNWUxmZENoaHNjbnVmNllRb3RyK3ZiOE5rMkxqOEZjSmdCZjFX?=
 =?gb2312?B?RC9sQlA5SFpWRHo0em5idENYUTdlbWpMN2tTRExDbEdNakpHZ2VhVHlJM2tm?=
 =?gb2312?B?TDFTbitDRXFsekN1N1UxNmpIMHgxOElKblh5WnpoOXQ3Skc3UWpHQnVtKzNl?=
 =?gb2312?B?WWgzWUw1UFB0SnpCMFhqY20zU0JNcFJrQ3JVNk56KzBTb3BybGVBV05BZHlB?=
 =?gb2312?B?OWFOL1RYaFF4YnJCbGlxWmJqbCtLMlpWZXRMUDV2VmxuRHlTbEFMU3QxRkdi?=
 =?gb2312?B?dmExN3dIdzRZNFdsWW5ISENQRkI4Wmw2R25HODhtaTNoSVJGSTdGdVFNYVhQ?=
 =?gb2312?B?cTBZdWJHY09SWndKaWl0RGFSOGp2M0JYdnBIQ1VCbXVrMU00ZDJTMGlETUww?=
 =?gb2312?B?aHpzTjdFdml5VmphNEpHSHdRNTZvQVdqazdNcm9IWnNGSmZ1RUR3QzkzdzV6?=
 =?gb2312?B?QklJZlp1bW84V1JkbjcvbXFaOWYrTU05bHlvZE94Z0NKSUIrU2hRNjV2dXNJ?=
 =?gb2312?B?VHkyTCtRaGpXeUNTQ2F1MEovelFYMzU5SGJDNkZjWldCTHM5OEFhdVFaYkk3?=
 =?gb2312?B?Y1JVaEIwUTExY2lqeGRCOXZ1WkoybXhsdmFzeUtUTFBZNjZSck8vdE1MdTdC?=
 =?gb2312?B?QUlYUVhIeENlSnAvdm5sUC9NVzc3YVp2ckZlOVZXT2N3OEZONTlQUjIxbWRF?=
 =?gb2312?B?d1ZRR3lhQnNmR2p4TkEveU9CazlyY1k4TFdPOXJ4SFlIMWhHdVpvdDVZOXJw?=
 =?gb2312?B?ZTlDM1NVT3BudkdCV0xRd1hpSTIxdlRndVRjQlJNNlBUVGEvWWMyUFkrQ09H?=
 =?gb2312?Q?rDU+41nKkQY+eTFB26HHJJQhmUqVX/v0enBm0iMJbA=3D?=
Content-ID: <40C1175E0A32B049A568A9A3C76C7400@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9734fafb-a8c0-4a69-9a07-08d9a358f81f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 08:14:36.4607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OoPMoMZmDL0jKTlTjiHkxNNrDxBqAuho3iboDIxvhiCj/P29hYo8SfA63zDflH2ratuRSmKaZkFtFHDzhMn6kbg7qwHG7+67latdkxVi/8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2187
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 03/13] syscalls/quotactl04: Remove useless
 mount option
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
>> Adjust header position.
>>
>> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7c319d3
>
> So this went in to Linux 3.5 looking at supported versions ofSLES and
>RHEL it looks that anything older went out of support, so it's likely
> that we do not care anymore.
>
> Or does anyone still needs to test quota on kernels older than 3.5?
 From my side, I don't test such old kernel.
I list this kernel commit, just want to said the quota mount option is 
no need.
>
>
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>> ---
>>   .../kernel/syscalls/quotactl/quotactl04.c     | 41 ++++++++-----------
>>   1 file changed, 17 insertions(+), 24 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
>> index fd3afc888..f34050716 100644
>> --- a/testcases/kernel/syscalls/quotactl/quotactl04.c
>> +++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
>> @@ -1,24 +1,22 @@
>>   // SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>> - * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
>> - * Author: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> + * Copyright (c) 2019-2021 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu<xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>>    *
>> - * This testcase checks the basic flag of quotactl(2) for project quota on
>> - * non-XFS filesystems.
>> + * This testcases checks that quotactl(2) on ext4 filesystem succeeds to:
>>    *
>> - * 1) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for project.
>> - * 2) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
>> - *    for project.
>> - * 3) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
>> - *    for project.
>> - * 4) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
>> - *    flag for project.
>> - * 5) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
>> - *    flag for project.
>> - * 6) quotactl(2) succeeds to get quota format with Q_GETFMT flag for project.
>> - * 7) quotactl(2) succeeds to get disk quota limit greater than or equal to
>> - *    ID with Q_GETNEXTQUOTA flag for project.
>> - * 8) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for project.
>> + * - turn on quota with Q_QUOTAON flag for project
>> + * - set disk quota limits with Q_SETQUOTA flag for project
>> + * - get disk quota limits with Q_GETQUOTA flag for project
>> + * - set information about quotafile with Q_SETINFO flag for project
>> + * - get information about quotafile with Q_GETINFO flag for project
>> + * - get quota format with Q_GETFMT flag for project
>> + * - get disk quota limit greater than or equal to ID with Q_GETNEXTQUOTA flag for project
>> + * - turn off quota with Q_QUOTAOFF flag for project
>>    *
>>    * Minimum e2fsprogs version required is 1.43.
>>    */
>
> It would be cleaner to separate the change to the description from the
> possibly functional change that removes the mount option. It would be
> much easier to revert the functional change in the very unlikely case
> that we ever need it.
Ok. I will move this change to the next patch.
>
>> @@ -29,14 +27,9 @@
>>   #include<stdio.h>
>>   #include<sys/stat.h>
>>   #include<sys/mount.h>
>> -#include "config.h"
>> -#include "lapi/quotactl.h"
>>   #include "tst_safe_stdio.h"
>>   #include "tst_test.h"
>> -
>> -#ifndef QFMT_VFS_V1
>> -# define QFMT_VFS_V1 4
>> -#endif
>> +#include "lapi/quotactl.h"
>>
>>   #define FMTID QFMT_VFS_V1
>>   #define MNTPOINT	"mntpoint"
>> @@ -141,7 +134,7 @@ static void setup(void)
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
