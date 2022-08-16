Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5ABC25B0F
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 06:19:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60DA13C9A98
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 08:19:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C5F23C96E0
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 08:19:06 +0200 (CEST)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A4FF3600155
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 08:19:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660630745; x=1692166745;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=TTP8ZQazhJ9t9CrCHDT8q4yLfhzht+SHTKGZRdk+M88=;
 b=TViFUm1D+tS4ZAfwgORmEMMZRtLxLnSK76SdQqGMr0ILV29l8BXfKaKM
 z095uZg3zbQeQcZIugXhW4MPhVISVNSyMOENRp8G0WowfLuH1N+HRjXit
 qp5LysR56mxF4pqa8ayHrObdh5Nup19r8BKg2vm2RS70JFbiH86vHeRyd
 9cQo31rzIDIjkshSnzRaiKRbvnQ4oDverKlVWZE/zRGkDeZK9txbnsB1p
 i8Z14KEcu494kLsKOtjlWWEOw31G5tIo3rMlQrTMo6qyRboZmOLxaY0Vn
 rHWsFvNcKnB852v2FV6VOUJOn/tE+fMjCIPpyuAHxkTHVvneVF1tOKi7b Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="62922187"
X-IronPort-AV: E=Sophos;i="5.93,240,1654527600"; d="scan'208";a="62922187"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2022 15:19:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyNYTt15mTnazQDetxaXnNfL+E03JdT6IGUU1q3b3JKbtP2X0zbSBify+nt2A8Or2TwKM2HxV5aDcRtpBUIJrVGExfU5IWt7ZqDgEp7T0yizX5Kfonyl89WAT0tNRCCu3prVVSzHpKbUdm4QdA4O3z8FB6QxDVt8r5CSS04qYmPT1W9DmJSRSb6oBO8zZreTDvfhMKW/uhMDIpsY3jxCgte2fBD0axH3AI1AcwHbnmtPUVf3AKAoLP7i46GLq81b+p8SOy4ge4a7FlLJ6aOMyaBixxz9rN5nnxQcNPHz6u6L9bNbFs9z33HLR8laF13rwtHdWnnrSxtYdLKsiu/c9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTP8ZQazhJ9t9CrCHDT8q4yLfhzht+SHTKGZRdk+M88=;
 b=TAK/ZiFekXlpT8E/Nc3fuIsjQCD+haG+ivUHTB53+258S1Pgy8nt3WDcZ2X2tG9g/b1bCTyyQwxIeHU8Wr/5uloEbZ2Gjr7NuDPSPbNxeSUH+ez+JdKada4GO8PLh20FP7Qv1raD4nZR4wRjWhmcLM1MspBQnVXfECtjDLJ4U71i2XqbwNfHPZCkJTRZukJznxNKa3sItcAzy9sqAxV/2n4AebFqEuMbDgmEBocn7bECzjtsnbIb2rk/UBEVPtPmNl5JiU9lgGxyKRRb8SBr+Ilt9mts+mpAVj2v0DpGtJ4MGG8FaMKbBl/9CzB7+UPO0qQBoRXoM0b1DolxDswROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB9848.jpnprd01.prod.outlook.com (2603:1096:604:1eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 06:19:00 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 06:19:00 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [PATCH v1 2/3] tst_cgroup: Add safe_cg_open and safe_cg_fchown
 functions
Thread-Index: AQHYpxonL8L7qQ3YBUegaqa46E0RxK2einQAgBKoWYA=
Date: Tue, 16 Aug 2022 06:19:00 +0000
Message-ID: <031f32b2-70fd-8b6d-e2ec-f1d3d1bdcaa5@fujitsu.com>
References: <1659521981-2241-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1659521981-2241-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <87zggks3pe.fsf@suse.de>
In-Reply-To: <87zggks3pe.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 649dff09-911e-4be1-bcf1-08da7f4f3569
x-ms-traffictypediagnostic: OS3PR01MB9848:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ovi9OJd/IC4ht/PblNA66+nRKGQuszMzZZKzRYNnh8Ur1zQ4W3yn4ztWQF1Po4WTkPvAdzsM3cBvy9pb6PEIkHKYlGOQjBPGqvVJlHqURTQPAtmv4uza4ggbHtkXh5XZ9YIvYqRphi+YQN3tTvrJoJ1SiC2dZxlANfqq41CxITKf4M44kRP8GpC0x9wZQVsXeDBRwXExE6xXxOnGK/JxtWkpER5tMMZZG4F4BxlQrayHuMX8vC5T2z1J8ysVetFhEj6NH0X0jdBf67E/b5DVXJTll253i/GTs3joyBrLR8cp+0YtDQ0xOkZBnDpfDSoedVfdTwLg5uv/2CZ9KGWSBUS1zidKpQ1012tSZGG0p/CahnnAhR36B/ZGsLG8WWHTiXL0BC3y6jWh4nO/LhHbrIaxU/fiDC5U2Juqv3hyYzAbq0ieeJezlIB83epaFSuQvJ9J0LpqtdzDqTXgvYVPoWQfE/B0h4q9EZf1zWvYolzf4h3S9fStNwX7kjPZ6hkGIKxNse7Pp3zdDAAgn+xP+tch5s9y51GVzpNA3r9kiZRB8PnXxsCnNk0f1HaRa1j+7Xwr8aSm2mV8yvbZchx+3sRDXJQiiZsGJ5ZhUzDDOog4BiLFfTT+HygjwwsrPrfFVPAWqSQsQW4Wyd/akONCjQCio9RoLvwNZYxiihwOImsQFxsjpNIoVhP4pN1nuVOzld6fQIDdhbBZDsrQEgPP1Qk+TyHWMc7KrhYkcBww8itzsWPL9KRaUaUWdOtvNZGNUEY4RQJaCVBQUE7jnj+tcW87Ie6o/SdS3rvpuClDVyp4aC4x2rjSUrxPDyPyXSkoSwmBlU6gK82r5nt2OKcKtXpbMjLCUx76B+mmD1VVFQQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(186003)(38100700002)(36756003)(85182001)(26005)(122000001)(31686004)(82960400001)(86362001)(6506007)(31696002)(2616005)(38070700005)(6512007)(6916009)(41300700001)(478600001)(6486002)(54906003)(71200400001)(66446008)(5660300002)(91956017)(66946007)(316002)(1580799003)(2906002)(76116006)(66556008)(66476007)(8676002)(64756008)(8936002)(4326008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tmh1dFhQWGYvZnVZUkNjS1AwMjloWWxZeUd0Q29uaFJ2dHVzcUpzeHJ2aWhz?=
 =?utf-8?B?N3pkSW4va0FDTUt1MWJ6NDd0akdoRUs3TEk3MFAxYy9IWGZpNVgveWhPS1ow?=
 =?utf-8?B?Q2ZYd3Z2YzNWTUM0T3BUelc2cnU4RnRDR2xNTzVCUFFzbGlBOGpsbno3WUEy?=
 =?utf-8?B?Rm9BWmdtcVExMjhRYmRKRlBab2U3RFAxa1FXU1gxWmxodVVYQmtpMEY3bW9v?=
 =?utf-8?B?Q1lkWlNRNyt0K1dvWUgwM3FDSzArRDNMVXczRnZ0NndvOXZ2Zi82UXJtcm1o?=
 =?utf-8?B?VWFIelNmS3N4eEhma0Q4Qit4d21oSFlFSXVQRlZGN1I4MWV1Q1F4a21TTWU5?=
 =?utf-8?B?WXVpVG5XOG5XMlNQZ3Y4RVhxK2VvaUR4MWtnTGdUdUZqS2pRdXJ3emJGVXJv?=
 =?utf-8?B?cHRCaFJLZmY5SFdzZlo1c2tJYTF2L0dZd3ZPV0FEdEg0Ym1WV3J6anF1ZEtR?=
 =?utf-8?B?OWt0NENFUlNJNCtLcjFuellpaHZLVUI0WVJtdmphbGZEanEzLzRSenVJeUxr?=
 =?utf-8?B?OUVRMUNOMVRHOEhxT1BQY2VpNHF2VUlPb0Qwd3VnOUdwY1VjVkVFTFcwK2V6?=
 =?utf-8?B?QlptZjF1R1ZnTnNPZnJzMURya0V3b0ZnZi9Dc0ZWR2hhQkk4TmdrTkhoQWdM?=
 =?utf-8?B?Y1NGZGFUUUtrMHhVaXQzbEpGOGMzK2t2N2JvRlB2SEtZclNTdkc1RU1xVVJT?=
 =?utf-8?B?SDNjY3VZYUYxM0lPZFVib0hEcVl5YUxFbVR1ekppb0pBdlZyaWxLeVJBbmZl?=
 =?utf-8?B?eEcySS8zbUIrczI1MzNvdFd4MkRyb2JJbERyQi9BVE1lUXF2bWw3cnNEWHFB?=
 =?utf-8?B?SjI2SS9DVDFMei9qMTg1OVRTaXVwa2JkS09jaitMMGhBVnBoQlY0ckFraXd6?=
 =?utf-8?B?OUdRRXZXZ0pJQ25tOW5RSkJ2TEthODFVWjRvWUZsY1ZXZExUSkdjbFpFNitW?=
 =?utf-8?B?K3BNS0lUVFRzeDR6Yyt6WDlzbzlNbmFtSnNoem5TQ2dxVkQrU1EvVWhSK0Ux?=
 =?utf-8?B?eUYvOGluQzBzUjVuUzd5eGFaR05vYlZCLytxbXptZndmK3Bod05mc1JKbGNY?=
 =?utf-8?B?KzlPQnJBTDRNU1l3eEJnZENRN2pnU256RXZtanpobE0xaHlhc1NDRDF5cWVz?=
 =?utf-8?B?eVBKMEJhY1dTRWc2L0Ezd3BIZUY1ZjhWcWxRdWpMbmFpcGZqdU1sNWhjQVBy?=
 =?utf-8?B?V1FudHRJcGlZRCtIVzE4MG5PbHRKbHpGdTJPV1pKMU5MVXNqKzlqYVlNU2No?=
 =?utf-8?B?TmdyTForU2JpeElQa2xBRm43eU12Vno5cy8zZjBKQW4zcmQxYVJVeDBjMkQw?=
 =?utf-8?B?WVpueWNXVUxVYW9mKzAzK0N3NWRxbXZaeW5Ndm96N0srdDJnRTJ4cHB3S3pt?=
 =?utf-8?B?Ykk1UnNzWVphamRKMkNnRHNCVnFTZGhRYitiSmZWeGYyUUJKWkc3VXFOaWx0?=
 =?utf-8?B?Nzl2bS9WdTZvY3NmQUllNmhkY20zQlprMWtDdU1DektKUWFILzFRQW1lOVNj?=
 =?utf-8?B?WGtsWEppSzhjQXRDSXBkbUlvVmprMFhEN0JUSnJHR3VKeVZ5TmdhUTQ1N3Ay?=
 =?utf-8?B?cGI1Vkl5NHVWMVRFUUtmaDgwY2lBZWdsUWg0dndQMGx6dnBYeGJiVDNjdTNh?=
 =?utf-8?B?dk9uWDBTQmhEUFRSNUxBSjZGYjhQSlp2WjIyOW9mQU1PdFkyc3B4V1hGTkxr?=
 =?utf-8?B?MUV2Y29EcVJaZVJwdW5rQUw1QWhmMFU1V1ZzdHU5UTVFTVhVTC9nV1BmWGRk?=
 =?utf-8?B?dkR5K25Xc2Qxc0poMFJYTkdIMmFWTitaclhFY29lMEUxcStLdzEzcTNMQlQw?=
 =?utf-8?B?WWVZelUzK2dSQ0RtWHpraUpaOU9UQ29YTXVyc21MQ1d1SExrLzNjeWtHUmJ0?=
 =?utf-8?B?WFpZKzMrK0RlZ0paeWlzY2dCOHBMNU9sNDBHMjRZVDhmS044MVorSkpEOWRy?=
 =?utf-8?B?UTlEUjhkcVJaS29tajhQL2cxV2NuQUxoRjkweWxWdm05STlMVUtNU2dvcjMw?=
 =?utf-8?B?djBIVkRjQXZJWmJDR2Ryd09EQUtnTmpoZzU1dUI5VDhBYmdETzR1VVNicWUr?=
 =?utf-8?B?NVRzY3RyRVEreHB6NGhKV0x2R2RkdHZZL1dCUmdRZWlwWWZXSGZPUmJCbGlF?=
 =?utf-8?B?TXM2b05CUUVSdnpjT0orY2VpbGRML3NHSWFwRFZWa3RsUVBKWVlXNmFPU0Rr?=
 =?utf-8?B?K0E9PQ==?=
Content-ID: <EAC9667B0056814ABD898928ABAE9816@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wlT9xI0SPah/PoYPucK1YAXeBRk/wh+HHJxM7RUI6bjq8GWRMyWlHXFKjuH62MOT6J/CLs2XjerymxQdNeCJ4YGwtnyWtGiutBC+P/Tnh6e1ZudX2J96dOtYk+/yVXw2bZezoscRRuv9bEmzt/AghvK8lAYJqo0DtJmGdQz6jEVp7jdmJaKP9qUjaSdjZWVX724lN1Q/PbhGBIHPEYe/9wOvhhm2gLGr8jj0AYopZfxJ+lp4024Rs461p4kqKRVVzt6+nz8EQ2ITdttk+1B4146CbaDsoYbE7r1n6PUIhonqc42Z6nD04Gq/G64UL9OIttV/pCinoyEeTe6RboIJqvKcHrh6lxPLsPhkCal8wz3hesynQnvVO73o+aarWNrYSWYKiZJkbztRi0EQYp0p7bpK5+rCvFp/xpCIT7V4+qug3/w1rltmA0c5NyKO6l5TFMmBG5WSBvOhHhSmyc90D/L1czc4auDgZafLThA5CYYTEGJXv8j4itGID+Jr0wMnbqbJ2nkkiQxLkIJvAZXE+MNAghGJbOIqlgBkp8qMD/yM+h5/2fOW7FCLxe4XpXBL90Sz/QQ6iXSBZFk5w0HsGFA/J/X1ESuVc9w+ecrf9DPRjKvTPuKLSI4gRQL7QjI8X+QK1AKF6qpmYDyy86+YaPn9SWSkeAz4L29chsgfRvu3OZD7H3QKRUu9p2sfZtU7j4psGOCV/04b3xS+77SMVeTl7e3BmmRWlNnbhU765txgZVOPa8ViYzwA58gqUXo3wl1zZO9QmU9eNlczyO9OX3iE5PSlLvb/BhwH1k1RNU0SxCvh2XHiy3zl8fT44sA8
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 649dff09-911e-4be1-bcf1-08da7f4f3569
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 06:19:00.1143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ePmAvdAMto82xdueSnhrgIMhe12Uy0i9yB1Guj2PYj2UUKgwKC7KBOEsIm/UoCODXnh6uSp6LwD0o4ffz/wQl7zRsuNBR5CEgcHfkwzSjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9848
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/3] tst_cgroup: Add safe_cg_open and
 safe_cg_fchown functions
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

Hi Richard
> Hello,
> 
> Yang Xu <xuyang2018.jy@fujitsu.com> writes:
> 
>> safe_cg_open is used to open the sub control's file ie cgroup.procs
>> and returns the fd.
>>
>> safe_cg_fchown is used to use fchownat to change file's uid and gid.
>>
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   include/tst_cgroup.h | 15 +++++++++++++++
>>   lib/tst_cgroup.c     | 39 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 54 insertions(+)
>>
>> diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
>> index d06847cc6..292c9baa4 100644
>> --- a/include/tst_cgroup.h
>> +++ b/include/tst_cgroup.h
>> @@ -188,6 +188,21 @@ ssize_t safe_cg_read(const char *const file, const int lineno,
>>   			 char *const out, const size_t len)
>>   			 __attribute__ ((nonnull));
>>   
>> +#define SAFE_CG_OPEN(cg, file_name, flags)			\
>> +	safe_cg_open(__FILE__, __LINE__, (cg), (file_name), (flags))
>> +
>> +int safe_cg_open(const char *const file, const int lineno,
>> +		 const struct tst_cg_group *const cg,
>> +		 const char *const file_name, int flags);
>> +
>> +#define SAFE_CG_FCHOWN(cg, file_name, owner, group)		\
>> +	safe_cg_fchown(__FILE__, __LINE__,			\
>> +			   (cg), (file_name), (owner), (group))
>> +
>> +void safe_cg_fchown(const char *const file, const int lineno,
>> +		    const struct tst_cg_group *const cg,
>> +		    const char *const file_name, uid_t owner, gid_t group);
>> +
>>   #define SAFE_CG_PRINTF(cg, file_name, fmt, ...)			\
>>   	safe_cg_printf(__FILE__, __LINE__,				\
>>   			   (cg), (file_name), (fmt), __VA_ARGS__)
>> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
>> index 1cfd79243..dedc0f65b 100644
>> --- a/lib/tst_cgroup.c
>> +++ b/lib/tst_cgroup.c
>> @@ -1297,6 +1297,45 @@ ssize_t safe_cg_read(const char *const file, const int lineno,
>>   	return read_ret;
>>   }
>>   
>> +int safe_cg_open(const char *const file, const int lineno,
>> +			const struct tst_cg_group *cg,
>> +			const char *const file_name, int flags)
>> +{
>> +	const struct cgroup_file *const cfile =
>> +		cgroup_file_find(file, lineno, file_name);
>> +	struct cgroup_dir *const *dir;
>> +	const char *alias;
>> +	int fd;
>> +
>> +	for_each_dir(cg, cfile->ctrl_indx, dir) {
>> +		alias = cgroup_file_alias(cfile, *dir);
>> +		if (!alias)
>> +			continue;
>> +
>> +		fd = safe_openat(file, lineno, (*dir)->dir_fd, alias,
>> flags);
> 
> This will only return the last fd that gets opened. That's OK if the
> file only exists on a single V1 controller, but if it exists on multiple
> controllers (e.g. any cgroup.* file) then we will open multiple files
> and only return the fd for the last of them.

Sorry for the late reply. I just copy these code from safe_cg_printf.
So safe_cg_printf have the same situation that write value to muliple 
files under the created cgroup directory.

So what should we do? Add a fd arrat member in  cgroup_file  struct?

Best Regards
Yang Xu

> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
