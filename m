Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C814C7EE24
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 06:11:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BD8C3CB28E
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 08:11:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 759F63CB289
 for <ltp@lists.linux.it>; Thu, 18 May 2023 08:11:00 +0200 (CEST)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 82FE61400DC9
 for <ltp@lists.linux.it>; Thu, 18 May 2023 08:10:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1684390259; x=1715926259;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=+SWPAtX/72ujWVqHDEK8tcrFwKBSZkprE28n+Uck4Ic=;
 b=rXdn1nlBnjoeEF8lp87YwfQM1bBKx3DIyU0WhtCnqa79XWM07G7Fk2GS
 0ZdrmFDPYDU/W5aWZ9AuJMHGidcdjGxEsT3pyfIAO1K24kaU3drrqnind
 pDQ/H6v5LDWJox3AebMjbHjMwF6gTF5IRq1DvMAE1FjKxCZaagbLp0IJs
 YYLrgmI6mDdknCMCDiW56hGecJs75kCngDkCbcGCHemzBMZLQZeCZjDe7
 zvNSmF48S3zQBVCqa1ZwVtEyGi2RTnYkfk9zlknk35yoIx7phAwR4hf+k
 VjM6SuOz54VxksJAD55lAHSEc3H1l5IhBFjCtux1PnMCFSr0CMtJMDx0z Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="84855315"
X-IronPort-AV: E=Sophos;i="5.99,284,1677510000"; d="scan'208";a="84855315"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 15:10:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4Jr4lO29lYdWcBhrhmqs43i0fasVfUnYCGdXgBaeTL3VAw/nB3Q9qk4kdgsQSW6PKnY49YFPmV7oKFNCAcS1qwcBOFxq58Sg4qkKuUlanBtj2Rxl4SW24huhvDpv7f/uv3Kj+DWSlc6Xkzq4K1cDGUjS4nwTxQT5GM5RSVcxJ6rYjze2ikXqaMTJDbq/EmRlurkfaVbviNQ851Z2sJ/fT7ygDgxTk8h8KOIvXgBV7fx6b5MRzsZ6JKOe6aU65MC4wp5JMOp9O+8VnJzBM36otmm/ACodgBNXTXbxY6WkN1kxFIpn546/J3MG14ntv7ZLpv9POOqlJei/8+JsvZ6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SWPAtX/72ujWVqHDEK8tcrFwKBSZkprE28n+Uck4Ic=;
 b=Ssp4SJ4rmnKl6XUHmF6ZuLOpZk2aN7l/UOfWrxW4ZW9sGCY4OC1n+iOkYsXgGZcwUHrpfhP6YACIIyaRJ3bcSq0b0i0fw0KyH0I8yXFCL/DL83E1y3XfaaHayB2+YSz8R/oHWTTvNSXKVie3Q7RlIyx9aqa8O41NPMpgD+hB5N3Q5bmcAA03j6mcvngTWAEw+4xyU++h2annhYNebMA45SiBquWcJsWgdNJqSFl8jv5pwLNmeonsufJuOWRH33h70DeZ3KLDZrobsK6BrAt53zZXl6/l3M9hwnGLovGZRkqBUqwCg54g/eoa02nik7NmTrjSXiCPvIR5DRz/MLssBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSYPR01MB5400.jpnprd01.prod.outlook.com (2603:1096:604:8d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 06:10:54 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::a883:7aee:71d:b4a1]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::a883:7aee:71d:b4a1%3]) with mapi id 15.20.6387.030; Thu, 18 May 2023
 06:10:54 +0000
From: "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v6 2/6] lapi/stat.h: Add STATX_DIOALIGN related
 definition
Thread-Index: AQHZhvyNTXA4YakoCUuGFr9S9ScLKa9fkQeA
Date: Thu, 18 May 2023 06:10:54 +0000
Message-ID: <7ac7fa23-99f2-69ce-a0cb-25387682f046@fujitsu.com>
References: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1684134680-6190-2-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1684134680-6190-2-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|OSYPR01MB5400:EE_
x-ms-office365-filtering-correlation-id: 18a0422d-3e72-4753-971f-08db5766a392
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vn8hCf6zVaHtOMVlWnZU+AFmkOGmVOd3G7xcKQKObr1eFG6UBU8b8fA0lluGFpFg2pVm/fUZfMWXagEwafThLdyKy7lf1HM2Oz6JhmIWhypSWC4HgXn6bHvYtoTEP9upC6RbW+Q0x660Lq/GmJxxgNHaEUxWzN51tVXcuk6VukGAePX1n/iI/V2gK+ZxfVrBzJk2MesMyeoDq9MMgVTOviZBJwnyuxk2pvc6SZ9xk0Yq15PYI/SM5RWWbuGE7K4stpdq+VsYBSQWDXtMojH6zaiXkG6BxWbzVXdinKD8ijdQej/9j19bHGufMhV4bBEWpygyKAAzT0JTkuVBwl/H53A9VfqPaIxRWwSuEpYaP4EfvwmcBEGWG0V55wYm0EeVmfJ4x90XmvQDViBj39n11gjQcrZFy4RTC4/0+UbsEAf9rQZBrPkHgEnKZPW/yad+8LhNpxZJBVmxDixfMWpsTxmeB/DlC8G5nMgkGIUU16T1awQHRANLGwviJYWNZbknf1AJM5Nbu2cobh5SapTKRphtobgC0LyCD0SUkgIqwig8AyMXZ46Np9aOPHY3Y+RiZf36o5xU6QK7NsSNRhxm9IeqLQ1nI7mrn9zoTk4vNoMjYRRXZQjFG1+3qsfJt5dlkxbuJwRgf8X7lcFYBJF1v/IoP++u0c60SG8NGxWJNhHIjcvhGeqa7HxfOIvtS0Xl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB9499.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(1590799018)(110136005)(478600001)(38070700005)(31686004)(316002)(66946007)(76116006)(66556008)(66446008)(66476007)(64756008)(71200400001)(82960400001)(6486002)(91956017)(122000001)(1580799015)(6512007)(38100700002)(41300700001)(26005)(86362001)(31696002)(186003)(8676002)(8936002)(5660300002)(6506007)(36756003)(85182001)(53546011)(4744005)(2906002)(2616005)(83380400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clArYXB1MzdRMTMvcWIvd1NYT1VPK1J2TFVyR2xVVDZjRWN6eFNFUGh2Y0F0?=
 =?utf-8?B?MjNWN2xPU3MxTHNJRHpENUNPeTl5K1NRV3JrWTdnSlpyT0tQUldobmxNNkJn?=
 =?utf-8?B?aFpZbmU1QlRBQUtLcE11SWNteFhUYS93UU9SN1R6NEtZaTQ3a0RPbWE2YWZB?=
 =?utf-8?B?NGMvV1FpVlVnWElHY3JTMjlHdjhaMGloSm5nZGVPaU94VHo4aVp2ZFZsd2NJ?=
 =?utf-8?B?V3NDS0hnV3o1YWY1WEQrRTFieW5Wa1lwQjJ3Wm5ocGE4MEJ2VUw0Zk9IcDZ6?=
 =?utf-8?B?a1hPVGRUUFRZL1ZtY1hZcUxsUU1Uc0JmSEEzT0ZYemoxL3V1VTZiTTg4UTFn?=
 =?utf-8?B?ZlRlRVcvbG1UYUloWEhkQWk5OXJVYW9WcmZScGpLekhsMFVtQkRIN3JhdE9o?=
 =?utf-8?B?bDdJZWsyeDNkbjVuc3pyVDJ6UDZVdmcxMUowM01KQlJHdW5xaGtBbWc1K3hi?=
 =?utf-8?B?Y3hXd0IxUTl3UitOMmZkL1RNSUpxTGZFMExPZDdLdXJaM2c0bS9VY0h2TDNI?=
 =?utf-8?B?SFF0bjJ4V1Qrbk4wMzh4bVk0N2lYQnZzM0pBTjFsdE9qTEd5bDI1YjFVdlpm?=
 =?utf-8?B?MU1XKzQ5d2tFM2hRL0l5QkdJdHd0WXdPMEZhVGJxK3R2VkR6L2YwL0FETTJH?=
 =?utf-8?B?VUIrcEhuUzIxYjRnL3Buejh5M09MYk9WME15QnRxdzRvNzdVTmZheUtqOUt3?=
 =?utf-8?B?Q2JTcUhuMGMreFVNUlh4bDlyYzFiSmVEWW9tZG1zRHhXVmtyMmNxNGM1VUdX?=
 =?utf-8?B?VC8wSVpVWEdzYm5XNzNQUUp3cUR4LzI2WXhqZk9WL3E0TlpZYnI0Y2Q0Vk1N?=
 =?utf-8?B?bDJjNi9nWHVGamMxR215NklpNzNDUExjdGdUaTZRZ2NiNjNoUlo0aEpuM1VC?=
 =?utf-8?B?TUdyNUI0YTBBbzlIM3RuZlF5SlN2T1FLYXBlcVZmbkhZTnA2S3ltYmwrMHo5?=
 =?utf-8?B?Ym04K1VyRy9EVnd2QWVXNTFwcWN1TEdLbmk4aXdmZnNDWk1tNzZIcWlicE00?=
 =?utf-8?B?Um4vRHdZTTYwV2hFVTZteThuRXVROTc5ZWVaTDFsZFE4ZmtjY2FrNytUTUNp?=
 =?utf-8?B?QWgrMzR3OGplZVNWL1dMWnhBQ202SFd0TVQzSWhwZXFmOUFzdVp0M05BQVMr?=
 =?utf-8?B?ZTEwZHdxRmRvWkdRZk1Ia1dCZzNlSysxYUl3cVNaeHZuc0RrM1hveTAvbnRG?=
 =?utf-8?B?OG1hQ2ZOMmcveFREY0ozTFpqbS81V0h6aVN4eDRML2RvYXJhaG5KcUdVRFFL?=
 =?utf-8?B?cE1hNVR5QldSU0hXbEtyMlN1YTVxMGxjb1dVZzd5MkdMTFl2VTJlWlR4cE5Q?=
 =?utf-8?B?RmwrNU5OS09zcE0vTUpSbW44Umk0ZllvYitUTGtLSnlPUG1vcC9mYXk0Z1Yy?=
 =?utf-8?B?RlUwVDQ0NGxudDE5Qkc1TkVRZC9zOFFDREpKS3l5NUxrMUhJNys5TFFxQXVk?=
 =?utf-8?B?dWZWZUg4KzR2Q0hTblpBMGpJbVdEOTNyeU9QTHQzQ2hFMnhtUEZLVUdNZWw2?=
 =?utf-8?B?SS9YQnZjUjh1MkRRK0g1aytmaEY1ekRyYTh6blg4U2phVDg5MFhibXVZcndL?=
 =?utf-8?B?WHFHTEJ1ZVVDcXRhTnV2ajJCY2ZnRmh3TFhnZitSZWdpWExhL2VDL1E4aXFm?=
 =?utf-8?B?WG9POHFlK0F0a2RLcDdoVUs0UjlHRkVJZmZ4bmVHeHlOMDk2TWlHWC9wd0VY?=
 =?utf-8?B?cGpiSnVpTEV6M2tOUVRia1pHejZOS2JhQWlIRUU1VHJKK3hacjBHMGJwT0pi?=
 =?utf-8?B?azBlVDlVaC9TWXhoMmkycWpzUmEvZG5sdGZ1cmVCZDNaYVhVWVZKRjIzaS9N?=
 =?utf-8?B?OUdEOU1HbmxGSWFvaUJNTGNtcmxzb01pY295c3FhN0tJNTZoYTRTNnhkTk82?=
 =?utf-8?B?cVdzUmd2Z0l6NlVNc3VnS1JoR3RURVVWM2lIU3c1alRJUlRCb1pOVVk4VHZ0?=
 =?utf-8?B?U3RmN0M4ZHp2Qk5GbDlQeFNXYmVEMmtUWWxWRnNUQnVtbHdDVWRIR2dGQU5O?=
 =?utf-8?B?WUNldWVINHlkTzd6a2ZnUmprT0VDMUl6djBpYldUOHRzT2owQ0lmcXNacVVN?=
 =?utf-8?B?TVdCcUFYN3ZQL2RXQXozaUNjWVFyOEFTSXlPcCtsNXhyL3hkRDVBdWkzZmMw?=
 =?utf-8?B?WnJVQUxReG0rWWgwbFAyY3hGNHRUNitQKzh2bVNJNUtYTUdpZjU3NUx0L0VI?=
 =?utf-8?B?NFE9PQ==?=
Content-ID: <9EEA6AFE1B32D04DB0F9F432AD84D4B8@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BdXUEqqXGi28ZLB+M0MKKG6JyYLZi/iLiHmFddOvA5GTeQv9Bo+17oBY1Ab1RqXGYhzJFXGBDeNhiy09CJPp5jh1vr/M+Iiarlq4Gh9TP0ovmIOCa8/pxiCWDqCjMacgxXI0Bm6+LmBSdcCgnlY07htVqWsQFKl7kEjJMD1lDkUpgLreBkuRveQV549ol4rDkvevtd1iabJ+8NyeydQ2X0JAeTmBlIAGWynnIQRambuUhIPy1LxR9qpd6yCR2jxKuYgmhMXPQ8rmzh51ECj8vEaPEzk4GCyjgoue2VVt/op3/x6p9m3TRXmduJ/IEdxQ5pdPQlNjXFj/syFbTx6i98TBcGE8P660nZR1VCYGixJ0/23R/vjwo+T1zkmuIrNbsZHskKGmQPnEIRpWeBN8FbYc/cEGFWWe5CCY/mdxcKpTQgd7w8Tj7qi057tW54AV5jW9Kapxhd3OjEbDqsGenzr2+Kwt2hBx6BvvmbYSvotxv+MyBlt+3EJypN1md7Tb1mrVjSj+tbkSKX5WO6kGCTIL+0FnjB8GHyY6DC5J8xf1FVC6jZhZvKZmzTucdIQ+MbcE7dk6wU0E0qqIxCUO8hhL1epJHkJSec/p/VFfRru9Z1Fy+9GRsCVd+JST6aYUseJIBA76CZz3c7k3RH9myt4FccXBfeR7cDwhqkYbNmMlgLWwl7vuDybZAqkUaO4kbOyFZvLyuBQzDRlCtdE54W/Ei6j7sSMGl+hb1lIfuGR0H3Y6r2hRWgDkIaPoDx1Te53tFoHvo9s1IRIxuA2Qpg==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a0422d-3e72-4753-971f-08db5766a392
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 06:10:54.5572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hLRljQvjNlP06XdvO3KiDs/svczAttD99cOrPHJB3WjIBWuwFsfx6RKWN4voYeqZFqsKeJczG3F2O0TgM12llw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5400
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/6] lapi/stat.h: Add STATX_DIOALIGN related
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu

LGTM.
Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>

Best Regards,
Xiao Yang

On 2023/5/15 15:11, Yang Xu wrote:
> Also add missing stx_mnt_id.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   include/lapi/stat.h | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
> index 590ccd111..6ed4b6637 100644
> --- a/include/lapi/stat.h
> +++ b/include/lapi/stat.h
> @@ -97,7 +97,11 @@ struct statx {
>   	uint32_t	stx_dev_major;
>   	uint32_t	stx_dev_minor;
>   	/* 0x90 */
> -	uint64_t	__spare2[14];
> +	uint64_t	stx_mnt_id;
> +	uint32_t	stx_dio_mem_align;
> +	uint32_t	stx_dio_offset_align;
> +	/* 0xa0 */
> +	uint64_t	__spare3[12];
>   	/* 0x100 */
>   };
>   #endif
> @@ -180,6 +184,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
>   # define STATX_MNT_ID		0x00001000U
>   #endif
>   
> +#ifndef STATX_DIOALIGN
> +# define STATX_DIOALIGN		0x00002000U
> +#endif
> +
>   #ifndef STATX_ALL
>   # define STATX_ALL		0x00000fffU
>   #endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
