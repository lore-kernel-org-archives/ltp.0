Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918ADC77B7D
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 07:35:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B34793CB2C4
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 09:35:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AD293CB282
 for <ltp@lists.linux.it>; Thu, 18 May 2023 09:35:00 +0200 (CEST)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A452B1000A22
 for <ltp@lists.linux.it>; Thu, 18 May 2023 09:34:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1684395300; x=1715931300;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=N5T024etTnGurRRVKyve/z6I2jmwE7ybswYGFyzIrXY=;
 b=PvF1c4ZeQpUQiktLfAOUpIS9SZqrmhHRAFSbiIrBqm/pvv1YnfvpQpiR
 Up47vi8Yo+9oTeTZKT+kZy/QG2yfywPpGLQ4Y81t1ewWhsMJsW9YkfJ/X
 Cq2MWwz78U0hHXutDcgTTV2LQzOpwwpyH1D1i8Yd8KKgovlT7NbPoe5xY
 rhgqtSc486yvNqKE5X43rLEp3qKK6W9hNmNUOLSjKs+EZqiMEfaPDleg+
 sROjylaIUryd6DJRRMmgZw7/rkPtWIlJbaC1JzuDxG3SKlng6zCkly80z
 YAD48sEnAqfUDpUuGNYCGlCehw1AA65wfAhfdTualoGMghIiln/tLrImR g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="84388383"
X-IronPort-AV: E=Sophos;i="5.99,284,1677510000"; d="scan'208";a="84388383"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 16:34:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHMtS4ejiNtmgp317tYhVcQj7Zw+2ra/6pXqKvwjngi5VIn0hTFrDExXDlHiwQuM8vOH1rasb7bqbXqqiClmWrcvFXwuGKORsPKkRwijcphhMVGJxCpvcZiu9+sWxfQDWtX1QZu4AASwoI4aM6FB0iMLIrCMjZZo0AlJM1oDlvsb5eSm2rBpCQ5Sq4A/bbrZ1CBkSnQYu1gR5V/9BCM/Q0iLcQcl+QOmK+q8Ii5+46u2KPx75p4FMk1gbgpRovWnY13cQmZr4f/3j3UUx5bhqIIRAtEtSQQ0c5a9Uoqp3jWxKdQJw5GS0DSuUwwseJNpRFmJQz1DWbnbOIQuExW+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5T024etTnGurRRVKyve/z6I2jmwE7ybswYGFyzIrXY=;
 b=IDqKfuwJdV4Phuxw0cDIwnMFLtUcHzU07+NY7FtaxCZTkZ5ih+VgUq3huNWp1D7Y7dq7y3wmllMGv2br6u3DzsuNGp0FjWUbX8gEyGk156uiy/h9jCpNLXK+suJ/P69sMyw6CWRXSAN/TTAs9gDanjszdP72MyHabqy2ck0ftT64wGHMUHC1gQTrDXsAuPjBIs0EwT59eXIORGi6l7Fn8+hLnxUDpSoKQNUfmyuQjwHW87L7cXDS51HT7//w54PkOXANK//FC5GmI0YRwJAc9nUV7CIILGinxvoFoiMfLuemlbgjPA/dVwU0vcpK9K1e9Ps5TKkiLaVoHSzmIYO2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OS0PR01MB5316.jpnprd01.prod.outlook.com (2603:1096:604:a3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 07:34:55 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::a883:7aee:71d:b4a1]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::a883:7aee:71d:b4a1%3]) with mapi id 15.20.6387.030; Thu, 18 May 2023
 07:34:55 +0000
From: "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v6 4/6] lapi/stat.h: Remove deprecated STATX_ALL
 macro
Thread-Index: AQHZhvye7WU7nofhxUWi+/g0s4qMN69fqH+A
Date: Thu, 18 May 2023 07:34:54 +0000
Message-ID: <c272eec3-16b8-34d0-f73a-1ad631a87b75@fujitsu.com>
References: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1684134680-6190-4-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1684134680-6190-4-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|OS0PR01MB5316:EE_
x-ms-office365-filtering-correlation-id: 8e0a227f-bc68-4291-8427-08db57725fec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K27YTspbT6G3/N5A8u1PQEKCV5OtybXJrsRbCS+I++1f9Vf3L1+W6mLRKo5TewHam4EkVwgPfiDnAbyU4KqQoOHnLK+orPMwFYT07Iw1qAp7ZxZaJ+MBbvUaBhs2Hl8bVSCzJGJIruuv5MHeDi/U7L083er+Rfp93rzxohnOH2pB7aAPR2BbKMoSWGmAOHYORIpqL3Gk7MM0rnbFFrR6I9CD43G0CHI7I8/bnzkEdcVsdveTpX6rOTox3RaB06vDKVUcNHTmx1m39SlwMlEz3MUa+n1P7H4qgpXbVML+vvepEL0XuJvKeRMLG5LoDKRWRDVndm2P+ncrgpUy1jCWtAisYjvOmM0JKrJOAdjeUBPDHQh4W81b1oG0hmkAOQdkCNZnuJFtYRtM3gyAUfWnhr9PD1cC3djoHevU8/Es+JCa2WzeW7s6bKkwKTNZzOvIO0BSgdgHTMJ0bhFOi8dKsgDSk20f7nTOgcJVG1wEZlhP9efQihCaSWPVvG12y1LgC9mZothjPwKPBBRSANjU08ca8ghBFqA1AtEAuaTgSX50KxsO4qaD5G4ER+JBXaMkspnwFhXNIo8oJ1vOI5YyfKh0Xa/LQ1JcLTGX9iO2xbPF+rcKjN2ANOsZqlD9o5mFFGZuSHMp49FQM1VRIYSXWK4OG5PaSUqJrHUldgM+setxyrxLFUulPLpkLyAZKtOM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB9499.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(1590799018)(31686004)(1580799015)(83380400001)(82960400001)(85182001)(2906002)(41300700001)(26005)(122000001)(38100700002)(316002)(36756003)(6486002)(53546011)(6512007)(6506007)(91956017)(66446008)(66476007)(64756008)(76116006)(478600001)(66946007)(66556008)(38070700005)(86362001)(8676002)(8936002)(5660300002)(2616005)(186003)(31696002)(110136005)(71200400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDZ4RVg0Ym0wbS9NdnBvdTBubVloTEJZTHlTbzF4OUpwNXE5SDNXZStHcUo5?=
 =?utf-8?B?UmdiTi9tV0ErMnlpMGwwYVF3d21WVW5DSVFETmk3eEZ4VTlLQWJZRFhyMWY3?=
 =?utf-8?B?WnVQT21tS0piNWREWXdBdFJYRW96bVZ1YnpDN052RUVhMXJOb2NLVWJobFRl?=
 =?utf-8?B?VW5XZVJiS0JiUituSXRUUG1VL210QjgvOXZCRTFPazR1eER3d1U0UDRxUm5o?=
 =?utf-8?B?V3pOUzlQSjEyWGFMS3YveDIzS0tRTFY1bWU5bUZkNi9PbnVIcUYwbDdZM01J?=
 =?utf-8?B?eVlVVTZoNytXWHlZWis5L2E2QWE3WmVlaFlaenVTa2tqSmhSZ21YL1JJSWFH?=
 =?utf-8?B?UWFSam9YeXI1Y1FuZGVlZjJtWlRhY1Z0eTgyNjRXb0dUeU8vRm9GUEFETHFS?=
 =?utf-8?B?WUZZNFdOdlhiU0ZvV2ZqeElHOTkxN1dFRUMrR3N3MytoRUNPTjRVMm95a1p1?=
 =?utf-8?B?THpaS25kSmFxNXdSV0R1OC9ReU02QW9xZWhZMTJrQ2NSRHB5UUpXTWZXbjZO?=
 =?utf-8?B?bENvaHRLaWtvVjdmN2lkdFJQYWtjaE02TGkxOTUzcHNqczB2cDd3TjVNMWlH?=
 =?utf-8?B?cEk1YkRsOHlpY1FIN3c0Q0xmbmJhR2lqVVo3Ykx4VTVidjZTQmVvWGhkOGk2?=
 =?utf-8?B?WVpMMTNPZVU5QW1VaDRYVTE2NmVNVTdWdlRJcnA3S2Vxc2xJd0VJWGE4ZGN3?=
 =?utf-8?B?aWZmUUpER01sZk5SVkZib0ZteE45VWJxcWhlSDI3NTllRUJRWDI3d09FRG1l?=
 =?utf-8?B?SGNOY1lGL3c0N2VRamQ4REYrVEF1T1Bld05DQ0JDdTF1R050SnRiNFBib0Q2?=
 =?utf-8?B?ZDhMd3NJd0FjT0tldHRZa2ltbWpvL3lGS0FNME9TcmtjNnNiWWpmUjBmZnlx?=
 =?utf-8?B?OTEvZlk1a0J6UUJkblhpRk9iTG55LzFPVDZhRFcyZU5BdGRqVFVIQ0t5c3JE?=
 =?utf-8?B?SmRadlVQOFFNcXlJZlU3Rm9mcUxJVmtjNmxIdXp3RTRWeEkrQjhpSUtTOFBN?=
 =?utf-8?B?OXRsQjR3bnVOaWRObmVCTm9uTmZBNHhRNlVzb3p3aWg3aWhuc205Q2s4bkVE?=
 =?utf-8?B?MVg1eFhtdHlaQlZHUm1lNWIzVTBidkNxYUEwckJ4dTRSUkRJOGJFS1RoRHRm?=
 =?utf-8?B?eFhTNXJlbDF0Qi9tNkxTY1paZ1ZOMjZzdG9POENSaHdNRjZ5ZDk2dzhCUG1B?=
 =?utf-8?B?cGd6U1phMWJUaFVSSXp2L1dkSnJXQ1c3V1IvZ1ZtSlhqdjV0VVU0a3pkcDRS?=
 =?utf-8?B?TC90MzlHMXV3MzVhb01uM3J3TG1oTVJZWXU5SEJTaFZ6TElnUE9KdEFvMURt?=
 =?utf-8?B?M1hFME13WTNqYjNKdmFtRnA2bTdRRXprSklXVVFQdWtoSjE2VWVLbjZSY29s?=
 =?utf-8?B?K1orKzJtQVFmaEloOEx2NEJweUgrSzRBR3F2QkIwaWdOdWVzOXc3UzRIOXJj?=
 =?utf-8?B?OWdIa29xWUVYcGo0cndESnFBd2MvUTBpMEdjWVkxbEFSdlgrR3dqTm1QY3lm?=
 =?utf-8?B?b1h6NjNOa09NeVRtdldFWCtOamZPTm5NbW41TWhtTzRwR3hVUnRCQXR1Rk9n?=
 =?utf-8?B?WDAzc1dUKzRmbkJQR3pYMHhRWExhTHE4a25seVVQNUdpbExMTGRmZmVMQWdS?=
 =?utf-8?B?TnJqSy8zRGRjTEd2M0M0UFN0UDBiTDY4dHVmMzhJbEFqWnc4amlSVGFtZGE4?=
 =?utf-8?B?NEZWQjk2cUVDNk56RTlnemVBUXZsWGdhWUhoSXVaK1hFZE1scXZOQ05OdVB0?=
 =?utf-8?B?WUFhOStyb1o0LzJmZ0dIQkFKZXJ4ZlhyODE1UFNLWDNoUlRDU01mYXJJcTlt?=
 =?utf-8?B?bTgxOEdHbHZBY2FWdFMxbDF6N2RxRTc3SXpxL2swOGVqOXkwaWc4bWZrWXBm?=
 =?utf-8?B?eUg3R1pTcEdIMlJHLzByVjljVVYxMmVIZFpxQUw2bTZEalZnSnorOWFuTXNs?=
 =?utf-8?B?YzVRSjA5UFB5TWhXMnYvMW10MEZFNnltNndxalc4V2JJbHFqaDN2VVI0WElE?=
 =?utf-8?B?MFlQMmZsZ0puL01KSWNPRWw4aEdkZkg2dWMyY2hoQmRkSVYzYW14WG1pamU2?=
 =?utf-8?B?ZFA0UmcrQkhvSFJxT2c3bHZsbzhtMk1KQVFIMy9FenRIWVdWM2pxQTJXNThm?=
 =?utf-8?B?TlZLblVidzVOMExuU1k5QkQ0d2lGVXc0UUZKK2tIZ21oZDZXQ1lzelhTcTI4?=
 =?utf-8?B?elE9PQ==?=
Content-ID: <A3F094BDAF7CF0489898249F773199CB@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Cv8wihhvRY08vJvw8LyFAEObIfrZVphT1jllMmsT1Bd1dbYGmXebey84U5EW9AxKkfVmuVLOwxjpOT75ly6SCR6NeHBObXMOwGxpoM7NwcuXbxLLF7pBDqXpbXVoP9L/4v8jg/GnX3S3qWJxBgQmqtC57t6UUu9B2ezc+4mLJp+WcGYBtbBQaMbl2hKXS4G9VxPMJusXPp5XOpSkjcjC2fqKCoFMdueuX90QxXLfR4InIY8Vttp2w0desRArwnqNj4tt8Nq8xNcWqp8a7X1Y94H627PSnacPRRxdHV/W+QI7AFbA+csNNBKEh+rif16QQaCbdNYYvKUDayi1sRJW8MwK9tezI6a6OpROzuC2hVmZZhpFC6a6jKFr1AkaddwOYcKiC3l5VjgwPclGuIJdvTg9ZTo1LYylDMQYasahjArc3oYDt3dydQzz2O8NuvZYyydbAlJ2GkwvwbxTXGGstHvVmfYC/s8MfkmW1AQDaIHnIIjHTks+sAz6wZRP4JzkFm38FrmTUBIqh8SzLhlbZsOQHIVEaKGB/TabSfFbPKmLhphxMntnzpKgDQeSdSycfZShnlLQPAUqGdc33BirA076GwN8F9zWETLNDs3exJXS6NPixI8iiPpRp1/bV9VvAhkDh3cDPmXhDcyu184orI3Iji6ew/bCEzrsMHyCGKsweBcej2fHtFAouo4NkeM/kVoBioqOmkabc7gYyCTNZ29jQe45w2S2vdAowymcCL8adEdvObsncZz7PoTvFz4rEsWfpn9A0U656qM3YeZ1pw==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0a227f-bc68-4291-8427-08db57725fec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 07:34:54.9871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5HY1E4ZOjmUS9nLWhpirqAqYvhs8aDk36WDyGcW4HR25GmlGzxrPLW9BV8tkL26nJSncP9NNy9d7VGM49CeVSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5316
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 4/6] lapi/stat.h: Remove deprecated STATX_ALL
 macro
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

On 2023/5/15 15:11, Yang Xu wrote:
> Since kernel 5.10-rc1 commit 581701b7efd6 ("uapi: deprecate STATX_ALL"),
> this flag has been mark as deprecated.
> 
> Kernel should keep this macro for compatibility, but ltp doesn't think
> about it. So remove it.
> 
Hi Xu,

> For statx06.c, we test btime, so we should STATX_BASIC_STATS | STATX_BTIME
> to replace. For statx07.c, we just use STATX_BASIC_STATS is enough.

One minor comment here:
statx06.c verifies various timestamps including stx_btime so we should 
call STATX_BASIC_STATS | STATX_BTIME.
statx07.c just needs to get stx_mode so STATX_BASIC_STATS is enough.

Other than that looks good to me.
Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>

Best Regards,
Xiao Yang
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   include/lapi/stat.h                       | 4 ----
>   testcases/kernel/syscalls/statx/statx06.c | 4 ++--
>   testcases/kernel/syscalls/statx/statx07.c | 6 +++---
>   3 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
> index e247c2159..891db33ad 100644
> --- a/include/lapi/stat.h
> +++ b/include/lapi/stat.h
> @@ -185,10 +185,6 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
>   # define STATX_DIOALIGN		0x00002000U
>   #endif
>   
> -#ifndef STATX_ALL
> -# define STATX_ALL		0x00000fffU
> -#endif
> -
>   #ifndef STATX__RESERVED
>   # define STATX__RESERVED	0x80000000U
>   #endif
> diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
> index ce82b905b..60e736c5a 100644
> --- a/testcases/kernel/syscalls/statx/statx06.c
> +++ b/testcases/kernel/syscalls/statx/statx06.c
> @@ -111,10 +111,10 @@ static void test_statx(unsigned int test_nr)
>   	clock_wait_tick();
>   	SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &after_time);
>   
> -	TEST(statx(AT_FDCWD, TEST_FILE, 0, STATX_ALL, &buff));
> +	TEST(statx(AT_FDCWD, TEST_FILE, 0, STATX_BASIC_STATS | STATX_BTIME, &buff));
>   	if (TST_RET != 0) {
>   		tst_brk(TFAIL | TTERRNO,
> -			"statx(AT_FDCWD, %s, 0, STATX_ALL, &buff)",
> +			"statx(AT_FDCWD, %s, 0, STATX_BASIC_STATS | STATX_BTIME, &buff)",
>   			TEST_FILE);
>   	}
>   
> diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
> index f688b1b0f..4dbf83e18 100644
> --- a/testcases/kernel/syscalls/statx/statx07.c
> +++ b/testcases/kernel/syscalls/statx/statx07.c
> @@ -63,15 +63,15 @@ static int get_mode(char *file_name, int flag_type, char *flag_name)
>   {
>   	struct statx buf;
>   
> -	TEST(statx(AT_FDCWD, file_name, flag_type, STATX_ALL, &buf));
> +	TEST(statx(AT_FDCWD, file_name, flag_type, STATX_BASIC_STATS, &buf));
>   
>   	if (TST_RET == -1) {
>   		tst_brk(TFAIL | TST_ERR,
> -			"statx(AT_FDCWD, %s, %s, STATX_ALL, &buf)",
> +			"statx(AT_FDCWD, %s, %s, STATX_BASIC_STATS, &buf)",
>   			file_name, flag_name);
>   	}
>   
> -	tst_res(TINFO, "statx(AT_FDCWD, %s, %s, STATX_ALL, &buf) = %o",
> +	tst_res(TINFO, "statx(AT_FDCWD, %s, %s, STATX_BASIC_STATS, &buf) = %o",
>   		file_name, flag_name, buf.stx_mode);
>   
>   	return buf.stx_mode;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
