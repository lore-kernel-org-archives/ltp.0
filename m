Return-Path: <SRS0=//k7=OH=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2FDC433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 03:21:17 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5313060F8F
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 03:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5313060F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA7C43CA44C
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 05:21:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CF083C2BA3
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 05:20:59 +0200 (CEST)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CA5856008DD
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 05:20:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1631848858; x=1663384858;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=W5cENq3+IGKyQM4YQjzGMvZ0u/DpwXMbJJdgrOdMq4A=;
 b=G3VwPAuNG/HNq9lhcjDP6xgBphOHn9r1uxZzZ9sstmUl/AEYBGDueV3S
 quIjnXpL/DIKdGwaycDuIwsNiJrgv08+W51aBb7sen9Xp/ykKfCPubzTb
 v22btMumiMSM3KVnARzJJsF6Zo+x4RA2rKx1CzBGzZDtKIwC6ym6qj/ow
 y0cYkBZBy+GdAliqI5bOreQA+7yJ0z8gPDg9H85dmKARpG+fupyZEdtUF
 opZa1p7nxhDBODa4nVQ+vwd5zez7ttRR63zXSceSfjmItZMeirr+Pa0Ul
 LaiTZmnC6wVxukvveIs3SJQPzowRkJAE3j03OuXum3HMfWXWWXTqOMnYc w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="39422986"
X-IronPort-AV: E=Sophos;i="5.85,299,1624287600"; d="scan'208";a="39422986"
Received: from mail-ty1jpn01lp2056.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.56])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2021 12:20:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPx4nswsm74gs8OceC++rFwZM7bYZlnekYvt3LZSwdSAR389dibgGFVmezctouOrbEpTAaWlGJfCUVaOqyti7d0v1gY03lnVf2q5y7+zEE5AzvQ/JxfTVUWgnE+1OtZvUOtHkHS/0tXyt4dJ/0NXU4X//vF4G3k3HSiio25MXirr+lEqysCBiUa73z8vxQRou6xvUbNv7bXfHCHn7asvGt0RbaKMp8z0fmGvmhQrHl/emrWDkzQ1YD4pP1PlSLT8g5rK0b0lic8xeI18FfOIIRUng3YI14bEmF9NV025aDq6lMxmPPRrA1+4j8MZjj/QvPnisiie5gloBkWwXWKP3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=W5cENq3+IGKyQM4YQjzGMvZ0u/DpwXMbJJdgrOdMq4A=;
 b=EurEvdrFLMBDXclz5pfetP1p9iV4k9LhFl8TfBqqjaNmlHduGJae0iJlVJlFZGTcFZCHN8KPnv1Tb0G23oB0AIViNhVf8V4mjmZhdTtJQ4Mt5lPrNv5bfC62FECtkqZguLJuyRkPZMKEb0SrjsXbH1jcsUA56XgcvTUzohT4i48DbcyWDJM2VddJVZNB77+yY+i6PY9dz83v4ckMlyR6hO1ZB7PwjCR8LkelTnNDEuE4psYdaiCc/5qQVtv7aRJ9YMMxJOz5mXoTOj56hGGAHp/oxCr6oqVrmkrm9dEE+DqfOEQ15Aru9O3asAZw1efMk8cMW3IzCzlTcARZX5kRnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5cENq3+IGKyQM4YQjzGMvZ0u/DpwXMbJJdgrOdMq4A=;
 b=C1BQfSYpG2uAjJiN5KACqMxPT26np2+TEULOLbUQmvHoVHL/7xLm/ru+gRudtb/vbR088b3+Kuh6rh1ebG+MQKFE1tNg+EDbAJPVqDq+fX1Ohtz0iqL65VLViX0Ym0FNdnR9YuicoH2HmFWE1qb29HsKJ2GOrijqcV6uMGopBwo=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYCPR01MB6930.jpnprd01.prod.outlook.com (2603:1096:400:b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 03:20:52 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791%7]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 03:20:52 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: QI Fuli <fukuri.sai@gmail.com>
Thread-Topic: [LTP] [PATCH v3 5/5] syscalls/dup2: rename dup205 to dup204
Thread-Index: AQHXqui62i14Vi2amEGYaAvmYYppHqunkFIA
Date: Fri, 17 Sep 2021 03:20:52 +0000
Message-ID: <614409AA.6080809@fujitsu.com>
References: <20210916104933.33409-1-qi.fuli@fujitsu.com>
 <20210916104933.33409-6-qi.fuli@fujitsu.com>
In-Reply-To: <20210916104933.33409-6-qi.fuli@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06185f9e-7689-4eea-563f-08d9798a276b
x-ms-traffictypediagnostic: TYCPR01MB6930:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB6930146B9E70CF7B47246D0AFDDD9@TYCPR01MB6930.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:103;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r8LnsUYyH8ijwhWlP8vkIGSal3p8246NfKUmgdS28tT63KGCu9mdhrwXgX5AhB9/MW3DrQXPdeDs/P8J95rgIM+0B+FC+NlAENacmvnerMXNe7v4p5YvWtDSoarfSQn3Zd2F7l3lvnOKdd6qDrmt9dHyY/tCO97Wjp5FJcSAZDE1vR79d/OlbGH5Ku+WF4NzI6B5fL55O9T+HstIWD6n8QrBrPQ5xDt1WMtCe7Btira7nNY293KNGDO3s46f2rOQXvexHXFQ5BcArJDEJQ1l2NVSu7zIgzzyYU4cZhzlu5I7BBv2PerPJhIHfArFT0ZMIk4pgt/IWSvS4eaaV+w58uQ6eQ9ND0DwY9KwyKaH2R6JaIBN+0IOkEWT82CGOGbeQ5JPOQ/NDUsguQK2aX+oIGYp9/yApvBa782PrsPp7fGg5VbK2Dr4LEKB4Dp8Ag27okavugJ60cWf2RjQ5TadysULL8qwEhOONNtBTuqT8hBrrE/r2yC6movJIkVlbznMa4TxfMPem4pDLrKJaNyO45Vg2WmSaQ1jw7twE7z0rOtGNYI5MJsNj1RsZfKwjfLTSugwAvyoJmxcDYGNXlnpMvu9ci9Soea4tFN5cZUi5U29n9xIHmbJsbxIAdZW2UYJegB2pISP07pGIwLpkeN9wBClWy4qpPEmexi5QITablpK4hjSD6eUZ+hl3KKStDKQl5aQxAUuRp8NH1OHdMe0kw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4744005)(64756008)(91956017)(76116006)(186003)(508600001)(85182001)(86362001)(6486002)(87266011)(2906002)(83380400001)(107886003)(8936002)(6512007)(54906003)(38100700002)(8676002)(38070700005)(2616005)(26005)(6916009)(66446008)(66556008)(4326008)(66476007)(33656002)(5660300002)(66946007)(71200400001)(122000001)(6506007)(36756003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aVRTNHhqVkQ3S0czYkhEOGJlb3B0TDZQTEN5VUhldjlpcUJTeFJhT2ZEVXg1?=
 =?gb2312?B?NlhIeW4xQmdWZUJlR25hREVtZmxPOWk1MEEwKzd2YVJFVW1heTJDQlFIbndV?=
 =?gb2312?B?bHlXN1lWQWxOSGovTjEzakxxT0ExMUVPTGdvMkZVQUJrVUpIcFVRSmZDRlpG?=
 =?gb2312?B?TVhBWDhCejkzUzNnWW5mWVNoMDY5Wk9Hd2Q1bUxWTVVaOVlVUXU0VUF6SDd6?=
 =?gb2312?B?SGJDQlBkam1RR01CU200cUtRTkoxR3g1U3BxWTlDaDVlQmpUUE5KTTJwMElu?=
 =?gb2312?B?RXpCZjJsVGthMEZiQkRUdXZUbXN2UjZNamNmb0t5Smk2QTcwZVpDNWlZY3Vs?=
 =?gb2312?B?UnJ0ZjNFK0k0ZjhGb3RhUE9XQlZDNHh1a2RKclNpdm1PTlV1L3ZTVUNtajBw?=
 =?gb2312?B?aGNUR2E0eDIycEErVGxMZU9vcTlqRXBqd1FUZ2IwTVpEZi9DZEovQnMrVmtL?=
 =?gb2312?B?d3pSSnZsb1RMTnhuVDRLUUQzMHJlTWxDUTVIWmNSVWx5MXBJbUczVzZLSmNF?=
 =?gb2312?B?RXh2TFV6YWdmc0REMTdpRkNMUFN1MENSaWNJdmRTd1ZCUTdGM3dualIvNlZq?=
 =?gb2312?B?Umk4YjhuMXVUalZjTmZ2UUV2bTJrMGJmZytyNVNjSEhjNGJRVzdvOHY0VC8r?=
 =?gb2312?B?cUhNK2ZDOFBTQXlzcWpvd0FaUzcvK3ExK3VCTXdIUitYVy9nVTA4aElIa3ha?=
 =?gb2312?B?VWtPM2xQdlY2c1dKYlZoUkR3eTFXOXE4M1JOVjI1ZjJBQmxpb0tpQ3FSakx1?=
 =?gb2312?B?ejE3SHN4Z3RwSkJuL3RGZU0waUZmdzc5YTBGaFB6em0zK3VTNlNPTnM2cktH?=
 =?gb2312?B?YXl5bmtjNGEwZmk2TXlXWHg3MkZOVjNjbEp2MSsyMGRDeG11emc1dTdRd200?=
 =?gb2312?B?QXVEWGZmbSt2azgwQkhvMDViZ0pzYUdrWGl0Y0VUakFIeFJ0aUt4TUNEeUlQ?=
 =?gb2312?B?SXJ6YzZlRys1b0JBUnZZSlVYdWRoZzNWRjV0UE5xeTR0eWhZYzhSNWRWZTV4?=
 =?gb2312?B?NkFacVJNYUxGbGlhRVl6VENadEtSWnllM0I4b0VIdC83TUZrT0kwbWJNTzZo?=
 =?gb2312?B?V0V6OTdEMUpCRWNySHNEaHV4RG5tSm0wZDA3Vy85VXlTSUhCeW5ybFVCaEdy?=
 =?gb2312?B?TGRreHV4Y00yS25NQmpqQjFDTWRwZ1R4OS8rWTNoYktKMnVyeURxTlFuSjRt?=
 =?gb2312?B?d1NqSkVzRGhmQlZneWRCVFgwNy8ybnJBNm9oWFZkTU5mTS9BbzY5Q0NQMjA3?=
 =?gb2312?B?NnRyVUNZMW0reEdPM2lSU09YMmlpbHYvd1NLNHdrWUZ0TS9MKzhFaVpxM2pE?=
 =?gb2312?B?Q1dqVzNkbXNXTWtOdVlmcHllVGlzWHhGbzRLT3phdXBhZ3pxaEZPVzVESE9L?=
 =?gb2312?B?WFdnV0Y2RzNSRmNzR2p1TGxuVWdJSFVTWHZKOCtjS0w1WW1SMis1L25kajY0?=
 =?gb2312?B?YzEyUWN4Q3dnUEFueTNNUFAxbnFWdHA2bjBZQ3RmVzQ5KzFsWDg5UkpQZzM5?=
 =?gb2312?B?bEpCU1NxZXNsRDY1b1dJeVNGM1lFbW44aG1rNzBROTViQ1FmUEsyUHMzcmts?=
 =?gb2312?B?Z2xaWTI1VGsrcW9rd1gzY05STUdBY0N2WjlkOVFzdkx1WTZGbUJySXk2U0N2?=
 =?gb2312?B?cVhmNUk1VnZadm9zdU5ZSEdtQWtUWGdTc0NnL1JnRGRUTm9IemZUbmJZRW8r?=
 =?gb2312?B?S1V0VWR2cW5OTDdwT1Y0Ty84a0lmOVBqTzFhem45T2ZlQ2M0bldtRE9wdDlu?=
 =?gb2312?B?ZGxPWDB5VUYwc1NEeWFKZ2dEMDdBZ1lYYXljMWR4Sm5PWmF2MW56elNBVE9L?=
 =?gb2312?B?UTQrYXlaSjlxT09mbmFqUT09?=
Content-ID: <7E93710BCEF9EB4FA793A61FCE7EB8D7@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06185f9e-7689-4eea-563f-08d9798a276b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2021 03:20:52.2842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bD3QOGuDjI1ThgAH2UbJ8sabJx1+yjhoSHBG16SO4L86qViMfpwcSmZvFLOj6/tMn6W1hWN5SkTg54/6szpIB0uh591yccuFpPc6CBZ8xtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6930
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 5/5] syscalls/dup2: rename dup205 to dup204
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
Cc: "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210917032052.LS7HBGM3jMeTh3-Ng7bJTSdcawgmuSpTUROsseoClhM@z>

Hi Qi

> From: QI Fuli<qi.fuli@fujitsu.com>
>
> Signed-off-by: QI Fuli<qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/dup2/{dup205.c =>  dup204.c} | 0
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   rename testcases/kernel/syscalls/dup2/{dup205.c =>  dup204.c} (100%)
You miss .gitnore and runtest/syscalls. We also need to remove dup205 
tag in them.

No need v4. Maintainer Will remove them when merging this patchset.

Other than some nits(useless comments, empty line, whitespace), this 
patchset looks good to me.

Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu

>
> diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup204.c
> similarity index 100%
> rename from testcases/kernel/syscalls/dup2/dup205.c
> rename to testcases/kernel/syscalls/dup2/dup204.c

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
