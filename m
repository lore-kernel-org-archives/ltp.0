Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B200C433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 08:38:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D69213C93C4
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 09:38:11 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC7703C93BE
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 09:38:00 +0100 (CET)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E60716002D4
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 09:37:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641890280; x=1673426280;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=rLAbfJKiBQTVntjBhmisoqPQWES8uyTi3cWHoTvRZNc=;
 b=W5i4+CEvVv5Wd4xu0X87VpksRarD8GC3KDil64j9HCTuLY+Zwi3E2qno
 /FL/qyHCuhY11MWUXM5ZXqr0xSfrBrYUuT6VnR9to1URPfEpWa+4FSxot
 t3aQozSQSiWaHAcNFtI3m9ua+7Xz8+liSHAOad04xFvlKSPAhnoHbYid4
 VCzL3Vbfv5S1qsHCY40dmt1R0pppcPprNQL3apIZ34Pih9KC2EzxZ653h
 kR9ZIskFvfPLhRQe3vkjIUDJwJlbstnNmj4E2BFMF6U1VYEHKNUUloQIh
 chSLBJx9KomYpzn9XAqiICL8XuHZZFrbXrlfYIefR26xtJFVC74PwqIhI w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="47343478"
X-IronPort-AV: E=Sophos;i="5.88,279,1635174000"; d="scan'208";a="47343478"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2022 17:37:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWdCgqlbYW5KBJIy4OtBbmxzcbzNaQnGsq7Cj7fl5JCCQSGVfDe/s6PBzLlxD+8ETyhFZabigVRZYi5Cz71Y6WuJklbZCuM6HvWSYOO3DpoGLzdAF88YalK1IXgUmGRrifBWpdNDY3eCaZVCYr272MWIVP48qRnxXSwwLD9EN1t9KNmOXzRuILIObpFrWuYOFAS9b8S1DVr71h9UufH5WWBG9ZBYghRPixXtPMXpANvbM9CL3hU7GwZN9LK0kArjqndzK2XD8P2rhDqie+I3ddcfwjZBiP6ZA1Ggh1ww7CznF+eT9XdBGkcKoRVO7O0QsmJWWieW8Bu5uKIhuNvtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLAbfJKiBQTVntjBhmisoqPQWES8uyTi3cWHoTvRZNc=;
 b=KNKW75KM4/BMizOoFquRUeed1r8mJj7Dt67vde1UmDS/ynuf/Brtzbg1mRgYVcra2Am1nclHTDavwkqTOUVoI2RZRiLVE3vvIoFr7ADWoEGX9p2yGBoJ/y8hscvFfRTtlZH+vGe2Ihv/CJdH1eGS7Uho0Qsix49nDstQpkxuNoUzexGLJKOshvRTHaR79N5w4H6iguQ8gEvkYyg53j25tvDG96GW10tT6FOjIb4n2bmfLe7gC/bwzJeyWzHDiI/16Zt1JfgImb09GxTIEWDWagbiRtWHk60WCzwa2RApp8x5BBEZ8atxmoJ+6zpWEuk27LQUaZUTCT9CvO1+tNiGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLAbfJKiBQTVntjBhmisoqPQWES8uyTi3cWHoTvRZNc=;
 b=aE3pO0whSoX7FXoItvnyuXf6IIic3hKplIrgjcO42mYGLtrIPjKPv7+oX7jeMbFmALsIQTmSVWnX4ob+geJc5/Zs561aYJVTxMAiIyG9oZ/9G1xyMJAGyQgkEabuZg/dlcQzuEIVIgV9Q0f0+k8/8bCSX6SJ6Zk9wwthIBApyc4=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYCPR01MB7011.jpnprd01.prod.outlook.com (2603:1096:400:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 08:37:54 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 08:37:54 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH v4 3/5] shell: add kconfig parse api
Thread-Index: AQHYBrHpl9iAQbrPq0SVOQssuxdnMqxdcxkAgAAMzYA=
Date: Tue, 11 Jan 2022 08:37:54 +0000
Message-ID: <61DD4215.2050104@fujitsu.com>
References: <Ydw4BXF2ramqahuh@yuki>
 <1641881435-2351-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641881435-2351-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAEemH2eZJ7U1+Bdsb5xCB6-KYa1mQQ=GriaDtyFSJ_6zprT7yw@mail.gmail.com>
In-Reply-To: <CAEemH2eZJ7U1+Bdsb5xCB6-KYa1mQQ=GriaDtyFSJ_6zprT7yw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e79f223-188b-46ba-01ce-08d9d4dda9ab
x-ms-traffictypediagnostic: TYCPR01MB7011:EE_
x-microsoft-antispam-prvs: <TYCPR01MB701142DA0C8B73AD9BCCFFF0FD519@TYCPR01MB7011.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3TCpGF1lHPn8qMAllJWq6ciCFZIAmbNNdiGSUnEnAruzxvXDsDIC+uthKsrniVqBQGSNM+ZPWVyFN0Q3UEz+K74Xi/iJaeXneKUXekhT6TxQwtGe05gm9U/76QBTQxvEAc5F3Tn14F8LN6pPBd/TRR4dv/4T0VbJAd9AYa+nZKtK/R6IKeRERiZ8DItfDxjW7I2MEOtSK7X2eWLRzB4rs4Q/TFacEdM9bBC7H+ccafeoBif00TLZAF4BMgX35FCxDlLYZgJ5LzYgcsEHKx8u7q5DaC2JJ78pj1lasvnBAmg+KBCitRvObnKgYDXyVIy24tZ9FoZYYFm3MO4PDu0mrZVY4aSxlKQ7/WhdbZPzqReudhBAxTu392ntqICFBgVnJ2hYZTC9ZhHVvisP5aKNBXHhx2toAQmZigVPYhUo7x1hab+UG8Di+r0IqlE8lUqV5pfbGJ38itYUa2ls0KD5YP6sTCuzrmPw9Ab7du7P9drcrV4yrOShKrB/VYi5m7rsrrlA9Wa0Sekx/nQQDIU9vyXD4UScgynWzFRkN7FBVRBKZ4zVYq1hUFne9twGu1Vs5kXj1VJ+7HqLx2tY19shGiz7n14LI9SMd5PaxtWB9RNfQmbPluXpEvMMTZluvEsl9I3MYAcntc0LuyIygJXOrlAFys2Hg18FoGDOe35BLQIuIWsIN4+Cyoe0v4A+0/Arj4USgIBUdckxN9+zkOz1pg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(86362001)(83380400001)(38070700005)(6506007)(26005)(36756003)(4326008)(82960400001)(5660300002)(85182001)(2906002)(6512007)(6486002)(66556008)(122000001)(508600001)(8676002)(71200400001)(2616005)(33656002)(316002)(66946007)(87266011)(8936002)(66476007)(64756008)(6916009)(38100700002)(66446008)(91956017)(76116006)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VThsbUh1K2FWMmZMUmlMZE9EQlZPZlNLMlZZVi9kOVdQdzdtZEZTeXkxV05n?=
 =?utf-8?B?dmxLUHFFUm43UTgrSks1c2lmTjAybkFJeS9wSjUvSEd4TkV1VTJrZ0dXSU1y?=
 =?utf-8?B?TS9vUmVTU2pIdVNTVkh2Vmw0R2JhNUsvellOSEJCSTlOWEpta3h6RUI2aVQw?=
 =?utf-8?B?WjNnbkgzTmFLWkE5RnprMVY2THdZaGltMmU2cXZ6b28vcmdSU3hDbHczWC9E?=
 =?utf-8?B?THVaM0JpZExjNHdPYW1CYzZzMDdCWjhGSDVwMHhadmFqcWFaUGwxSVQ2d01K?=
 =?utf-8?B?eU5oTWhzVENJK1dQQjZqWU96VlByQ0g1dDNqQTM0dUVGNCtMZ1FyQmtyVUtY?=
 =?utf-8?B?ZmM0THNtbFllV3M0UmE0WmIyT2tCUTZoTlczK1Fib0RqM3lwQXZIKzB2TytK?=
 =?utf-8?B?MjNZemxibVZsdUtzR2g0RGg2R3ZiendDQWVqeG10TVN4a2xVTmhjTzNuM0Ux?=
 =?utf-8?B?N2ZEUzF3bkpaeStJQnpjQWx1Q2M4RFlEME1WaUI1K1hINTJQaHFjRDdWaGNy?=
 =?utf-8?B?aFppS2ZkMzBZMG81V1dQOGM1Ymh5c0FzcFh4YTdCa0Y4TUVzeE92K3pIRkJR?=
 =?utf-8?B?eU5VQi9JZ3QvbUNMSDlIaklMZE5uWUpjZk5yMWozZlArMnRWT2cyaFRTb0lL?=
 =?utf-8?B?SnFMSkFOU1U1b1k5VWJaaE83OFBINTNYbXdGaEJwMG5NVDQ1V3N4SzdDSEsv?=
 =?utf-8?B?clBWTFErWHZMZlVib01uMHBSUyswZzZFZzcyKzhUVGFhSDRrTG01Zm4rZU5I?=
 =?utf-8?B?WnV2NktsUmhaUEt3eG5ZQmJUdk12ME5NSk4zSk5hc3lPUVhGbGZQTVlBZDdh?=
 =?utf-8?B?MjZWSFFKUjd3a2ZWTk1ieXdkY1JXMlUzNCtmTmx6UmJCVWVvRGxSUlc0VUxu?=
 =?utf-8?B?cnhUY2E2WkZ0REErSHQvMWtiVjB1YktSY2ZHV3N2dDdBeXNXWkpNdGhhd2Ex?=
 =?utf-8?B?bGdOYnpwRkpwTW5MajU4b2xQV1BnUHpNQ1NOVitTRndod3hUcm9Lc25DUFJT?=
 =?utf-8?B?VEkwM09sb0s1bFovNnltMHM1UVlmalNBbTdRL3lXQzk2eVNmZGl0QXljRTNQ?=
 =?utf-8?B?RTgvUm12dFEza1h3bjBWMng0cFVtT0VueXE2RVp6cTFSWGIyUWpXMkNWS2N0?=
 =?utf-8?B?cUs5MllSeTVYNGRyUytwaHlZTE5ISm90YjNiUi9nTlRJMXhndmp6Yy9hWmpk?=
 =?utf-8?B?RThoczFxdktkNXhZR3BYM3UxdDQyaW5DNklmY1lDaWlQY1oyNWpvTlVKRkIx?=
 =?utf-8?B?TGE4SjQxaStkRHFiTWMyeVRPMjVNZmtYSDYxVUdNTU1oVzI1M3FlWVBiQWk5?=
 =?utf-8?B?bXpSdG5uR1NIZUJ4TGMxVy8za1F2NmVsaTh6WUtvWVUwVWkvU3A0UFFLZDJn?=
 =?utf-8?B?QXJ5SjM2N051QXAzNW1zQVdKcHJEZkkzdGF2WTFQeXlveGdSTTVDRW9QLy9n?=
 =?utf-8?B?UFVjMjFub3BWWGM4SHhpdUZZdTZ6RnRqVzNXV0JFVDFIVCs4Zlc1RTIxVzhy?=
 =?utf-8?B?c0hjQkpGVzlyRzR6L1ZOSHloSTBZVXorOG93ZjR5b2dEaEVrNXB0TVVBck9r?=
 =?utf-8?B?Nk1LY1l0emV5aTBWNXA4alVSS2xtRVRDR09yUEpCcHBLUHV5cG9wTmJYbFF5?=
 =?utf-8?B?OThrWjZLREtMY1Q2MlBFYWw5YkNaZTVRL3ZIM2J1VFVhM1MrdzQvTXdwaFRi?=
 =?utf-8?B?NjcvdmxZcFZjSzVabVhNMTRlVU1kOExUa05WMlpmZHpXakZHSWxQNGFtd2ly?=
 =?utf-8?B?RzB3MEMyUmxOOWxQK3pnK0hoeXhLM3I3c0RIUTVRTXBENGVJSkx1RisrcjAr?=
 =?utf-8?B?K0JTTmFkMG1JYy9RWU9SYlRWVGluVFVkbmJSQWJxc1A4M1hYdnFoOUo3Ri82?=
 =?utf-8?B?WTM5N0N0dDRLVnhXRDNlbFVqbEJ4SGd1RiszQktCOWY3dFNoUC9WTXljekFm?=
 =?utf-8?B?Y0Z6ME9HcUlqZ0Z3VEdkK1BpOXhxSnE3dXNDZHA0WGhSMGx1YXNKakJvWDJk?=
 =?utf-8?B?RTVTZktLa2pvbEpaUzZkTGtvNlRSWFh6OG5oaUZTQUs1QUxFdFR4RjZwa3o4?=
 =?utf-8?B?Z1BGcU9lb1JKVkkxMUMrUjYrb0QwTzdpdlh0SDRNNHErall5VGtmWFNYTHkz?=
 =?utf-8?B?dVp3R21tSThwTmtadXVqRVBmS2FMSk1DdjVXYU52ZUVZZXhPRmNJNE5WQnV6?=
 =?utf-8?B?UTJnYnJYU0JwTkxkem9SWHpzcnFCS2dWQk50Wk1wUmxlc1lMemtOZUR3ZEc5?=
 =?utf-8?Q?e6edga+sC5TRjZysT4r3RK/PeSJjvI9OaD2suPyGAM=3D?=
Content-ID: <EAB539DDB64CD04D9ACFCDAA788D96A9@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e79f223-188b-46ba-01ce-08d9d4dda9ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 08:37:54.8740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yz83Z0bNKNlMdmRDaSncWBRoavU6Av1oU4gO4zcdLVes7WDQj3A1geK4BHNN1jliBY6eoUAUB/bv7pWixHzXvbqgQMz8lTtt+pIEpK+ROqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7011
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/5] shell: add kconfig parse api
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

Hi Li
> On Tue, Jan 11, 2022 at 2:10 PM Yang Xu<xuyang2018.jy@fujitsu.com>  wrote:
>
>> +++ b/testcases/lib/tst_check_kconfigs.c
>> @@ -0,0 +1,46 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/* Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.*/
>> +
>> +#include<stdio.h>
>> +#include<string.h>
>> +#include<stdlib.h>
>> +#include "tst_kconfig.h"
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +       char *str = argv[1];
>> +       char *delim = argv[2];
>> +       unsigned int i, cnt = 1;
>> +       int ret = 0;
>> +
>> +       if (argc == 2 || strlen(delim) == 0) {
>
> I doubt that this syntax really works here.
>
> How can we get the strlen(delim) equal to 0? if the argc is
> not 2, why the length of delimi is zero? but if we change ||
> to&&, then get a segment fault. I don't understand this.

Sorry, this is ugly code. please see the lastest code.
>
>> +               delim = ",";
>> +       } else if (argc == 3) {
>> +               if (strlen(delim)>  1) {
>> +                       fprintf(stderr, "The delim must be a single character\n");
>> +                       return 1;
>> +               }
>> +       } else {
>> +               fprintf(stderr, "Please provide kernel kconfig list and delim "
>> +                               "(optinal, default value is ',')\n");
>> +               return 1;
>> +       }
>> +
>> +       for (i = 0; str[i]; i++) {
>> +               if (str[i] == delim[0])
>> +                       cnt++;
>> +       }
>> +
>> +       char **kconfigs = malloc(++i * sizeof(char *));
>
> Shouldn't this be malloc(++cnt * sizeof(char*)) ?
Oh, yes. Sorry for this typo.
>
>> +
>> +       for (i = j0; i<  cnt; i++)
>> +               kconfigs[i] = strtok_r(str, delim,&str);
>> +
>> +       kconfigs[i] = NULL;
This is also useless.

The lastest code should be as below:

int main(int argc, char *argv[])
{
         char *str = argv[1];
         char *delim = argv[2];
         unsigned int i, cnt = 1;
         int ret = 0;

         if (argc == 2) {
                 delim = ",";
         } else if (argc == 3) {
                 if (strlen(delim) > 1) {
                         fprintf(stderr, "The delim must be a single 
character\n");
                         return 1;
                 }
         } else {
                 fprintf(stderr, "Please provide kernel kconfig list and 
delim "
                                 "(optinal, default value is ',')\n");
                 return 1;
         }

         for (i = 0; str[i]; i++) {
                 if (str[i] == delim[0])
                         cnt++;
         }

         char **kconfigs = malloc(++cnt * sizeof(char *));

         for (i = 0; i < cnt; i++)
                 kconfigs[i] = strtok_r(str, delim, &str);

         if (tst_kconfig_check((const char * const*)kconfigs))
                 ret = 1;

         free(kconfigs);
         return ret;
}


Best Regards
Yang Xu
>> +
>> +       if (tst_kconfig_check((const char * const*)kconfigs))
>> +               ret = 1;
>> +
>> +       free(kconfigs);
>> +       return ret;
>> +}
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
