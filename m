Return-Path: <SRS0=//k7=OH=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ED5C433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 06:09:28 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A5C61056
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 06:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 86A5C61056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 969443C884E
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 08:09:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F9AB3C1D1E
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 08:09:14 +0200 (CEST)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8B69D6005CB
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 08:09:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1631858954; x=1663394954;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+60I/cBEPcC/QgAYnU1w8D+FqUUaogZ4c2Y888kDTYo=;
 b=uJxuPJ8NUgffelDp8IbbM1yREgmiJO4rH+meSdmVWV1WuE92dizu0h2o
 TTGNamC9qM4AVPvvzrkrNVZB/7LFaISf+kXezqnfaHifB4JE5vqlnYvkt
 HZjXAARiKqTG4X6qZvWEd17DDMvef0yhDhKgjzg3aKMmLw77RAtV33JYS
 N5kmGPvYb0wWAz7BHlTgp0Q/3+97ATGXSXiKJp3PT64ijceGQ0ZKlQJa+
 7ogHhvw9cwF4ynkM7eIQ93i17JF8KXTULtzwmEASGjk0qvIAakJWyMjW0
 s+71S3dXs5gzmzdR1TKdtAkRr0aqNWI2pWMZvb6X+VqdIFXsGCDymry4e A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="47314289"
X-IronPort-AV: E=Sophos;i="5.85,300,1624287600"; d="scan'208";a="47314289"
Received: from mail-os2jpn01lp2050.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.50])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2021 15:09:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuAG3sqGD5hxIzEJ2jyBOLMd8pNSeQ2IZEU6MUKonock53CkO56dBM0WAgR+5jtThCVRHn+pN+MC0bozdOTuB7h2DkcABV9NCb3yl013nIgy56TTr+4l16iKvkrK3T7aFCSx8b34+EBo6HeOTXKGQF8zdZgZVQjhYLAlHQsDwU9z5j8aDT6Tva5g7AS0TITOjoMkvJEl4JhPn25r5753W0XnNJWopZPJBFD2siNl6cKpkcNTUqasSZvfostUdhve2fd5qM+TqylS5JOWguvzIbZVkmpUtQW5wSjalrBvz4DIzJs9lJHBb2XxvPvpqDed7mde8UU74l5vdNq7CEwIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=+60I/cBEPcC/QgAYnU1w8D+FqUUaogZ4c2Y888kDTYo=;
 b=QJpfosWtupbybp1jx0tSQ6TInO43j4LaOele+lY1lIJ8NOS0fawOLnF9sbQztlrpUCVo5UUBRyM2puOo3KCKGOxvWmJ4Rt4eGwkJFKkz9rGentbo4zcph5LmZZ6Mqkmwxc/v4FY/ik/EB2h0Izi1k189tgin3XxOSzMk2qbjXSmJEhDEv6lz/OQFf3eKn8R4nu7fJW3mJbs87MjfCl6KM2h/TJ9i/IuYMxpz72Ic82yz+R8KWwxWVMjBhhGJveyV0wA7Ce0m2IYP1IWG5RZmmyB9Upv0w6xqdhNTp3Z9RoP0T8joUSHN49xpWOXfQiBKNd0wnQohDjxT68G8cLINEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+60I/cBEPcC/QgAYnU1w8D+FqUUaogZ4c2Y888kDTYo=;
 b=mDf2MXSTM0LMqfJkeXTo0ifzzn8ZjbipKF3yhnJ8YIOTHX0Rp34TJSSIlJFYNoIaXLCSmGXGt0zYl04uUQv6KeP5vRY6g4Bkh9vylFvIqVjPyfC4O5Y3wvZ+IXmcO03j0/XXBcNfwxNrBh6BWHuOlw2sbZ8VU/Zhu57Ju/eIAZE=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB4621.jpnprd01.prod.outlook.com (2603:1096:404:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 06:09:07 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791%7]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 06:09:07 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: QI Fuli <fukuri.sai@gmail.com>
Thread-Topic: [LTP] [PATCH 2/2] syscalls/dup3_02: Convert to new API
Thread-Index: AQHXqwmyU9ruYooig0mfyQkEzyrCcKunvxKA
Date: Fri, 17 Sep 2021 06:09:07 +0000
Message-ID: <61443119.1000503@fujitsu.com>
References: <20210916144605.36204-1-qi.fuli@fujitsu.com>
 <20210916144605.36204-3-qi.fuli@fujitsu.com>
In-Reply-To: <20210916144605.36204-3-qi.fuli@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 388bacf1-0959-46aa-c1fb-08d979a1a898
x-ms-traffictypediagnostic: TYAPR01MB4621:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB462108BB0F5BAC86E88220F9FDDD9@TYAPR01MB4621.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5P/07/LzMYQJM+d4FDUQGdlMu04rQR5v2laXUKftNxPws1Vp+Qt63im0nQsKJQwTUJDixtn6wKboVt3OOLWHpJgLVcInDekhfUDHbGT+qYkux3+AqESw04w3dsvxX3tR4+ukrofsm9vZGGQn+0cjjwMkW4NQKwEB4KCUr4ZwZ4DoPHtIKMRLMKi4kNe6tSytz3ekrWUsprtymDZYRCZxg5OUwPInCTZ4FftAstuV3REXuaxEuReZgg6QKmGMQ/MDOcYc//xsb65gKq+h2XzPZYQveV+VeOjtjotexzxiaoqDGar5XLZ0Jgw9sljLrOhrg4Jp8tBVnLzItUgln4g3o8I4X6lkhvr5i4yjSgiFrXi+zl3pLMg6qXOjXmZTQCNiUJlstk9+v+IOhiEit+Ab3n1l3HNi8vnjMUXz38QGFvXLXRzVACe8WpXlrCm9Y65/JqFL1uP2lQfHNF/FDTMCVlt6yH2knmdN02TfZ8IDvEbDn1PW0TDN4hCKoFtxEPjT0XVtzHhOiVjUy+6umebHckSoY6ilacXx6tenvXQf0gvKLYafAmLsrKRM70/oHTGzSZh3/f1n4VeZi/d9TsubpjzvLYNy80QAAv1+4l5uTLsD5oY4ciTIn11SAXf40yICKkbPabORCi8C5YwPCQL8M4N581pZF3YHq5JMNEUs9dxi5P6GYVy5hngwrAkdimtSyP6aL9bfIqdiCU9jnAiiJugl6pjVTojRAYYHueqRiCtjubz8RBJ6q3cCLXi/qA3m
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(54906003)(26005)(186003)(2906002)(38070700005)(316002)(86362001)(83380400001)(66946007)(76116006)(38100700002)(71200400001)(2616005)(66556008)(66476007)(64756008)(66446008)(91956017)(8936002)(122000001)(85182001)(6512007)(36756003)(8676002)(4326008)(6486002)(87266011)(6506007)(508600001)(5660300002)(107886003)(2004002)(62816006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SnZoRkthQyt6YWpWL1RJZVQvQ0R3endwZ3FWUGRnV2M1ekxpbUVjenI1ZHo0?=
 =?gb2312?B?SDVHSkRjT3Nmb1lOMFlZcE9vdmtzdjZ5SjFYRW5Eb3Z4RVBUcFRFU1UzTVRt?=
 =?gb2312?B?M0JtMmVxcFBhZE5VWTZWcDRSNCtSRGkzbUR5NEU3aUhYVTlnT2E2bUlOQTl1?=
 =?gb2312?B?Sm1lWHMxTkJGc1RDRTVGcytUS0tuZW56cWhqa25xS3JaT1hScG5vcVRXcDZQ?=
 =?gb2312?B?eEViamVkNi9mRWdJQzNLRzJ2Z0hmRzRtcEJzRmpuNXI2aTZxNGFuQytkUXh6?=
 =?gb2312?B?VGRQcDJHcHhCUEpwVUtzdEo5T3hSb3ZNRUhTbUxMakUvYmV2NmtnU1AxVU82?=
 =?gb2312?B?UXduZ0hVZm55U1NiNkpyVHkvMzBTVklpcFZSSlNUMzBPbFlWWjdRQy8xOFFY?=
 =?gb2312?B?eWp6TFhOM29QRlk5K2RGOU9saG9tbkVmbzFDeHpJSGJtVFNUQXlXMVR5VnFt?=
 =?gb2312?B?S2xXK1JyeHNPZjI1emdGbW91cnVRcS9senZtOUU2cmxsVnFSRnliM0kxaUFF?=
 =?gb2312?B?TWgyZUp1emxrM0lhWnNyUVpBNUF1MTVPZkFVUTlVUDB3d2syUEJkajl1cWEw?=
 =?gb2312?B?K3lyaTJoazFCbHFVZWRqTnhBZCt2Y2N6dnhveHgzMlhPTkh4MU41NHNkSHhU?=
 =?gb2312?B?RHBSMCtvUmkyQUNvVnB4bHBaSUxNMU9SNHZQbWYrVXg4bGtLZWU5RWsvKzlO?=
 =?gb2312?B?S1hmd1pQb1Y1V005bWFybTV6Um8xait3S1d5LzFtNHBrenBSSEw5YzFTQlht?=
 =?gb2312?B?OVF1R0ExT09NMDVvVzVkbEo4amNqQjJkOGVKMC9IRzBONGpNY2RsN2pQaDgr?=
 =?gb2312?B?Vm1jL0JZYmM4SEt1ZE5DRjh1bXJ1aVRqbkhjZVhQRjBralBQUjZGRkJrakFK?=
 =?gb2312?B?ZnRUZzRCTTRNcXI2amwyK2l3ZXhGQzFHL1JOZFk3RkhNakRtT095UmFvaS9x?=
 =?gb2312?B?dnhEMXJsUGFPcWhLZ1R6R3hncFEvSmFYcWw4UmJDaWVXWUZJWWoyTHhXTmZ3?=
 =?gb2312?B?RExpc1ZYM1lNYUloMjhURjI2MXVjV0JycUNHK0JaVUl1QytwNTNiaUpqM1Vm?=
 =?gb2312?B?RThKdE5rcGN2U2laSVIvb3g2dEIwV1lyeElOdTZvNVo1RHJJcndYb200bEV1?=
 =?gb2312?B?Tnpob2hWTG5Va2VWTXJDNHV3ZTJTZGE3ZTBVTDhJMWpXajVXZ3ZDTk5aM1hQ?=
 =?gb2312?B?R2xnMHZwdnNOK1BqRHdPd2dqYU1JUEJqUElXRG9idnF1bWl6TlZIN2tLYW13?=
 =?gb2312?B?NW1DbWV5aUNQaHRnaHUyUHB5eVoydkM2cEpHSlFNMVV2NWtoVUIwcitXZnEy?=
 =?gb2312?B?MGdGaGNEUmZCZVFaKzd6aUE5UjgzTktsM1ZqZ0lLWXJiMjcyeURKWjh3MDZv?=
 =?gb2312?B?SXRPMUxiRGVGVTRheHBRbENBTzR4eG1iZXJxbEp3Z2djekJRZ3M1N05lOFN6?=
 =?gb2312?B?TUJqWUxkWlB5c3RsMVJFaTM2d1FMMFdiTnlhWGVWZ0VUOGV2N2xsTkRXQmtP?=
 =?gb2312?B?b0VlSXZTNnFJMS9VSmhMdTBPd0R6b0VYdnFLVmcwSER6OGR4ck9kOWZzR1JR?=
 =?gb2312?B?R0tDU0VjZWpWbVo2MEpROGU3cklFUEJEOEJNOEd2dktxc2JpajR2Y0k3NHFB?=
 =?gb2312?B?bGhhd3BzWWIzV255RWZVb29QR0FhRVMwaU92T2MzVDNCd3ZGb2VuNHFXUEhH?=
 =?gb2312?B?OFV4eUdlV1F0czNFeW9GdUZCRzE1eDdRTngvQjdtcmFScnpCaUtabUVUbFBk?=
 =?gb2312?Q?KYZdQS5deMXvt6RNuzgnFmLxjPZ4I5NyDKtfBQp?=
Content-ID: <3146832B9E527342B3AEDC3035EF9C30@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388bacf1-0959-46aa-c1fb-08d979a1a898
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2021 06:09:07.4207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PpEhfwOK0vTOPHpiODXQ38vcfqHrP2b/Yu56xuMwCRFyjCzQGko7kWV/96ViewoXmHZOhofHXc8+71FyagvnjYFkEeMFVuc96RxG6y2mrFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4621
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/dup3_02: Convert to new API
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
Message-ID: <20210917060907.YAk1E9dlMcauAoyquLHfAnB8Slh-tSPmNDQfFgYAhaA@z>

Hi Qi
> From: QI Fuli<qi.fuli@fujitsu.com>
>
> Signed-off-by: QI Fuli<qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/dup3/dup3_02.c | 111 +++++------------------
>   1 file changed, 25 insertions(+), 86 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/dup3/dup3_02.c b/testcases/kernel/syscalls/dup3/dup3_02.c
> index e49ec3575..76c4e6e35 100644
> --- a/testcases/kernel/syscalls/dup3/dup3_02.c
> +++ b/testcases/kernel/syscalls/dup3/dup3_02.c
> @@ -1,118 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) 2013 Fujitsu Ltd.
>    * Author: Xiaoguang Wang<wangxg.fnst@cn.fujitsu.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>    */
>
> -/*
> - * Description:
> +/*\
> + * [Description]
>    * Verify that,
>    *  1. dup3() fails with -1 return value and sets errno to EINVAL
>    *     if flags contain an invalid value or oldfd was equal to newfd.
>    */
>
Test for various EINVAL error.

EINVAL - oldfd was equal to newfd and doesn't use O_CLOEXEC flag
EINVAL - oldfd was equal to newfd and use O_CLOEXEC flag
EINVAL - flags contain an invalid value.
> -#define _GNU_SOURCE
> -
> -#include<stdio.h>
>   #include<errno.h>
> -#include<unistd.h>
> -#include<fcntl.h>
> -#include<string.h>
> -#include<signal.h>
> -#include<sys/types.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "lapi/fcntl.h"
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
>   #include "lapi/syscalls.h"
>
> -
> -static void setup(void);
> -static void cleanup(void);
> -
> -#define INVALID_FLAG	-1
> -
>   static int old_fd;
> -static int new_fd;
> +static int new_fd = -1;
>
> -static struct test_case_t {
> +static struct tcase {
>   	int *oldfd;
>   	int *newfd;
>   	int flags;
> -	int exp_errno;
> -} test_cases[] = {
> -	{&old_fd,&old_fd, O_CLOEXEC, EINVAL},
> -	{&old_fd,&old_fd, 0, EINVAL},
> -	{&old_fd,&new_fd, INVALID_FLAG, EINVAL}
> +} tcases[] = {
> +	{&old_fd,&old_fd, O_CLOEXEC},
> +	{&old_fd,&old_fd, 0},
> +	{&old_fd,&new_fd, -1}

>   };
>
> -char *TCID = "dup3_02";
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> -
> -int main(int ac, char **av)
> +static void run(unsigned int i)
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
> +	struct tcase *tc = tcases + i;
>
> -		for (i = 0; i<  TST_TOTAL; i++) {
> -			TEST(ltp_syscall(__NR_dup3, *(test_cases[i].oldfd),
> -			     *(test_cases[i].newfd), test_cases[i].flags));
> -
> -			if (TEST_RETURN != -1) {
> -				tst_resm(TFAIL, "dup3 succeeded unexpectedly");
> -				continue;
> -			}
> -
> -			if (TEST_ERRNO == test_cases[i].exp_errno) {
> -				tst_resm(TPASS | TTERRNO,
> -					 "dup3 failed as expected");
> -			} else {
> -				tst_resm(TFAIL | TTERRNO,
> -					 "dup3 failed unexpectedly; expected:"
> -					 "%d - %s", test_cases[i].exp_errno,
> -					 strerror(test_cases[i].exp_errno));
> -			}
> -		}
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	TST_EXP_FAIL2(tst_syscall(__NR_dup3, *tc->oldfd, *tc->newfd, tc->flags),
> +				EINVAL,	"syscall(__NR_dup3, %d, %d, %d)",
> +				*tc->oldfd, *tc->newfd, tc->flags);
glibc wrapper.
>   }
>
>   static void setup(void)
>   {
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	tst_tmpdir();
> -
> -	TEST_PAUSE;
> -
> -	old_fd = SAFE_CREAT(cleanup, "testeinval.file", 0644);
> -	new_fd = -1;
> +	old_fd = SAFE_CREAT("testeinval.file", 0644);
>   }
>
>   static void cleanup(void)
>   {
>   	if (old_fd>  0)
> -		SAFE_CLOSE(NULL, old_fd);
> -
> -	tst_rmdir();
> +		SAFE_CLOSE(old_fd);
>   }
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
".needs_tmpdir = 1" miss.


Best Regards
Yang Xu
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
