Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D91AC433EF
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 08:47:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F07F3C9370
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 09:47:16 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3E183C00B4
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 09:47:04 +0100 (CET)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D81711000EDA
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 09:47:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641804423; x=1673340423;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=p8m6OZmS0uveYokscPIAqnpc0CjSoCkEEagNtYZx3VI=;
 b=YirR3/+l5pseRjn7kE2yQht/RCtYhIUxL2OO5iGg4ubcsjeCP/oRmM2l
 YMvsUK18hKeAiwc+vOuJpkIxc7gNS15vU4NOPziOnM+g6T69dFl0tj+Uy
 Ek8HS4wbgdvoK0xPAuS0tBKC+uEth6AbVFVj8AzFx6qdLCNC2gigBwdIB
 5X5SkaNIo8Qt0sRinvjwKQhsOJI0AUL0t5LbbELgE+tIOqJxX4k4OuP0b
 9TaWxu87i2N6WKNl+XcxnkH5L7NHP7Qgcs7eFOfLwErY02sYQ8zM8IfZk
 ZDMLFzUz145YvKAVC1yepl3lCusTmGCkrcadYMj5RntORAhKLyk8hekso A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="47458895"
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000"; d="scan'208";a="47458895"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2022 17:47:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INGgM9HoPzqHXsVw2me9un2gxy+cNw249RNXwlDRE2n9XFrq9ospTHqguVW6Lb3R92ZIKbA0+0q43QOsekKHO0tRRcV3WbI9obSx9kMqah2h9ls5JXG7aFoTJPQqjCJMhSX5+eE88+mvZJkL9wBIjilvfCiPj3LqAQ6nGZQbfxS8ciMYbnz0c6cbhoTjaXXQv4Cnt+ULLObCL9McCKCmyWn/NEULf1jUyY32g1YZhBABlr5e6g8IN0rau9BX8JnKP1ZX0CwlF+E1RFLt25fNgEJdHezYfVJyzuKZvSL8mxeKlOp+SMJYHTcdoUURAt99OWGD82txXg4AZ4ZZGdOPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8m6OZmS0uveYokscPIAqnpc0CjSoCkEEagNtYZx3VI=;
 b=arX2TC0eNXRBBhHwtKiJCKkkNH/GqjQUNlyZADNmhirpWq7n7WLEAxISHkIwImQzl8jSxgbqV1Mbp1dGd0HvHJVq2YZan6I1GM5R7msNUtOyK1y8TWSe3dBEMeMUvT1QLTzHcflak6VqE6ShePAq/o/8hhxY2HXH0f+yCqV0zxo935xD4SD6z6zNqhyzTHdpQVpSGTjLya5hfAGtyVP/HTngmuZUMYKU7e5G0NjhVJf0inFGnyCdhvYoZOnVtC/7sCse5ckb3MSHqgC5nNFOVjb/m5zDqHc3dMzfoIe0WNidy2T1akwW5NwJR3BFSPrbHWNq3Xo2oMSGEhcdzuFSWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8m6OZmS0uveYokscPIAqnpc0CjSoCkEEagNtYZx3VI=;
 b=W+yBr8B0idMJ7M8LffaG7tQL/TLkc3Q1Hij64JygaT7HVWqhdncyQdEmrlfrSROrml+151+gKShFu8qomdM4dgfRbFdyM0dI5OL4qQIDsFtbUebpzl44/LlP21JWEk/AsedTzKFF+3fE4kLTAKksVP5gYzt0gcju192Xv0LubLQ=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB4907.jpnprd01.prod.outlook.com (2603:1096:404:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 08:46:58 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 08:46:58 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH v3 3/4] shell: add kconfig parse api
Thread-Index: AQHYBeiwVvRlvNR0WkO3kkr5h2+8+qxb688AgAAF2QA=
Date: Mon, 10 Jan 2022 08:46:58 +0000
Message-ID: <61DBF2B2.8010004@fujitsu.com>
References: <YdbQmTJK73804UYT@yuki>
 <1641779349-8424-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641779349-8424-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAEemH2cZFWCL4mVSdii0brqPiPEM2C5pyS3x4uzCJ7BB2iSrEw@mail.gmail.com>
In-Reply-To: <CAEemH2cZFWCL4mVSdii0brqPiPEM2C5pyS3x4uzCJ7BB2iSrEw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce897566-83ff-428e-caa2-08d9d415c373
x-ms-traffictypediagnostic: TY2PR01MB4907:EE_
x-microsoft-antispam-prvs: <TY2PR01MB49076244FF2B7706A8CEA2B1FD509@TY2PR01MB4907.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qlKIYvkiprSq0GpRVzX45U0IMbi3hoYpOTrgjzBfcl+BeSx+FzpScPEwTTfdEOeVDOUzG23HrxPFwrbaLr2WeVEAWA354Au6iWJiiAIkg/EvM6EPpXeGVcoK4wKHNynctUg2qai1QvRYtF6TZjmEPexgtUXS1uczNfdyi9n6yTqoywq7YOaGiGPLMITO0S0gutDM7ZGZyRhrS4zwK6GDJP7gzlpn0igtPKt8wO3AEUshad8qug2ywqmd6dhXat10nom5e0WA4qX4SY27m54tZeUAZyrjUFbTxxT3TtEn+VKqLbc8TYjQKZl0nmat54y7SlVZtHxXu+l8d4CXGaNPj6C3O8gDtu1JJg0ay2kRnn+JMzKm7W3QH+VzC6P8q4G863zCodDn5xlHx7hjYOhyc7GqTWlHBSPEXut3JPYWRau7OnCP+uOdEL1GhwhVsL/DuAPfmmMJtaWN7+Fy6UodRkaPWaeRfXea4oqtAEdwFWHASSjqNfaTKNaipGxktOEUmBSGnv68eKDVg1KcQUyiwPzCQAnzkRxzEfGxWj9ulmVdbKlg1mQ6ecl1TvBYJqZgDqRoo+6S479JcmUp9uJfW7jRycvJCOlqpSVzwSOHSmo2q1gWB33iEpyug5sn2qp87/qILIzsB+xEEpzYRWhxjG8SvTi1ZHrA6Arhf27m6NTAathnOyJyz3oyE2iKofDhgFEzAnPYMEQ+aDjZssGwOw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(66556008)(33656002)(26005)(6916009)(6506007)(66476007)(38070700005)(36756003)(87266011)(82960400001)(122000001)(6486002)(64756008)(5660300002)(66946007)(316002)(38100700002)(71200400001)(2616005)(83380400001)(8676002)(86362001)(85182001)(91956017)(76116006)(53546011)(8936002)(508600001)(66446008)(6512007)(2906002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjBDSFM4Q2lFcUEzbEx1UUFiVzd3MC9LMFA1UkdObG1uWjREK0d0VXk1Z1dy?=
 =?utf-8?B?U1YrNm1OODZrZFhJd3ROS3ByamdhK3Ezb25BK0planhjYm9ITDI2N1Z2d0FK?=
 =?utf-8?B?TllDOVg4b0FPek9scU5velQvd0xpNXplWExnYVE0YXkyQkJqOUdqeHZTWDNZ?=
 =?utf-8?B?SmdWUTEyUUtEWkphV3FWd2o1bE5qQTRONFlZckNBR2FyR0dISGRmV05sRVRi?=
 =?utf-8?B?ZHdZZkY0ODJ3OTc4aVJVbENxdnhLNVk4K0RQSDdjTFVqL1FaWTBiTFdXV0Fs?=
 =?utf-8?B?Vk5pbys2a1FzdU8wMXNnamlzZFJTb0NUZ01MRkNmTHUxNi9VMGZ0dEIyRE5W?=
 =?utf-8?B?U2hicUI4Rld2ekxJbXUxVlAvbEtSUVJ1WXVTLzhDZS9rNm45UUxWckFuZThl?=
 =?utf-8?B?ek5idTVRVXpLVkUrdnI2ZC9jaGE3aXgzMHVFMUV0RzhFbVRCMkI1NTVVZmdr?=
 =?utf-8?B?eFpha3NnZXBWVURyRTVqVXRjZzUrNUV4Qkp6SG1vQUNySWhyc3FCeU1jeXNl?=
 =?utf-8?B?aHArZ3ZwaWVLSElwNkQvMWJwTHhnM1VqSWxYUjBGZWR0WXdGVUZZTjBrU0ZU?=
 =?utf-8?B?R056eE9iNGNUbWpoT05mU1FMbFBuaExiaG5yNXZJdzBGZkZPd1A2OVJBb2w5?=
 =?utf-8?B?UWZndjFRVmtsNzVPVG1MMFB0MnhUbXd4cEw5YUpLc3ZxZjF0U2JCck9QM0Zy?=
 =?utf-8?B?M3BHcHV6M1ZXZXBkcnl4dDB2TUFsZTFjM0ZaelNKMVg1bisxVklHaEV6U3VS?=
 =?utf-8?B?REYzT2xIbUNRR012cWl2UnFHNVdudFhoYjRjb3hGYWwrNUJCUUxhUVZYbTVm?=
 =?utf-8?B?WXpNZnJQc2wyWXkwb1hTSmJ4SmUxL2NkN2kyalF0OXhlWmNpVTNONUt2a0Z5?=
 =?utf-8?B?azBXQm13T0lqNFlpMjZwYmE2dTFkQzNSa042T0NPRytKaG9xNjdPSWcyWVhw?=
 =?utf-8?B?OXZoMHU1eWZ3QitaOCtXK2o0OURqZ0pHVEQ4eGRsdFF0UFNRYWE0U0dMRTVK?=
 =?utf-8?B?S2IwQ1EzTUpBalVEd09UVkhlL3MrMkpQU3pCVFR4blBLUUtONUFyWVZaVm41?=
 =?utf-8?B?UHlJVGxqcG4zdkphbWxkb05kakx6T0EyL0hTZFhGVkRuL05OZ1B2SWRwNmE2?=
 =?utf-8?B?YVR3dDQvcDlqM1BKR1IxcG9DNE5yVzloNk4yY3JGZkVmWTVPbXdDdnRLc3pQ?=
 =?utf-8?B?M2NtN1dJWUV5K2gvUjFCVkJKZ0FadFV0YWJUZTFSc0JMWExFYU9EQ2JnSkdN?=
 =?utf-8?B?aVBBRE9SLzhlSDdFenNnNUZpTUcxaEREMDRUaDdWMWhwUUFhL28vWEdtdE9P?=
 =?utf-8?B?ZzBKK09XMURHTlFXbEpiOFYwaDdiWWJIYUpERTVXMThWeFZjRnNOUWxKTEZ2?=
 =?utf-8?B?Tnpxc0ZmNEh6NEF3ZmpVd2lmOFF4UkR6MHNka0NJSVhaSkY2YXlVOExuYkRl?=
 =?utf-8?B?bERoZ1NaanNUS1c2TzhQVjNSazBlVVJ6L1NsYm9GaExFcXNaSmZkTUlZYkpE?=
 =?utf-8?B?elV1dy9sUVBUUko5eVdMNktqOEY3TG9keW5CdGx1Q2lzNXFJaXBNWGxtZzQ5?=
 =?utf-8?B?UGNHcG1OdmpZRGM2UDZNYjFhb0MvbzJTbmR4eXZLSkd4OGNlbU5XTDJUeDRY?=
 =?utf-8?B?M1RXRm9tQkNucWEzeWdZcFZPQmVlNU9oU0p6RExod0JybVFaRTdrREd0L3Zr?=
 =?utf-8?B?Y3RLaDM0dWk3MkNjalNzNlZ5RnltN0VwSGR1NW9kZmM5eWd4NnFoQ3I2OWxn?=
 =?utf-8?B?WW1SRi9EZFVzNTEwVUY3VEZTRjRVT2pWd1hrNDkvT043NjBKNHYvd3NyV2to?=
 =?utf-8?B?czcyYnlENWg3ZkVUOHhiQXlwSU9hWE8xanNhQnRENTFHVm9QSnhkQi95dWNO?=
 =?utf-8?B?TU5hMTdLMzg1bkVEcDh3Q216Ky9VdTFYblM4ZTBsUmZ6MllyT1JaY3NJLy9k?=
 =?utf-8?B?R1doUVZycUQ5M0doVSttays3ejhoM0UrbWRnUC83N2dWbzREMFFpczZUdTU1?=
 =?utf-8?B?bFhwZFlZTFVEUDdsTnIybXpYS05uRmN2VnMxM2sxRFkxOGV4b2ZFSVB1NHdO?=
 =?utf-8?B?WFdhWGN2aTVqWVFtalNDM1ZHR1RRV3YvRm15Smc1aktIaUM4MHBIdzBFbXJT?=
 =?utf-8?B?dHd0Tml5Yyt6QUV2ZTVmK0tsOGRwTDdFRzh5dDNVKzFUei9ySDB4L2dIcUNh?=
 =?utf-8?B?eU0xWmI3NlVHaEtLZVVsUUpCYStLbGp6YXFkUTcrSml2dHZ1eXkzVXlHUUVz?=
 =?utf-8?Q?q3qHvVkci+HyoQtnfPkVfjLCdzA1WUYpOcLrp+fkJo=3D?=
Content-ID: <CE44276EE099F14B8B0D9C9471DD84B9@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce897566-83ff-428e-caa2-08d9d415c373
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 08:46:58.7715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uyNl4u8jBVjAGXcq5PmIEhmFxzto5YgHqi0MzcDCHv9f5N8WV0VwyGaYLFGGuTCSF5OGO8oKMWIZDWlR5WdpjC/Qw9rrtHl4MUXLgfcZEgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4907
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] shell: add kconfig parse api
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li
> On Mon, Jan 10, 2022 at 2:26 PM Yang Xu<xuyang2018.jy@fujitsu.com>  wrote:
>
>> +1.7 Parsing kernel .config
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +The shell library provides an implementation of the kconfig parsing interface
>> +compatible with the C version.
>
>   ^ consistent with the C version.
Yes.
>
>> +++ b/testcases/lib/tst_check_kconfigs.c
>> @@ -0,0 +1,54 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/* Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.*/
>> +
>> +#include<stdio.h>
>> +#include<string.h>
>> +#include<limits.h>
>> +#include<stdlib.h>
>> +#include "tst_kconfig.h"
>> +
>> +int main(int argc, const char *argv[])
>> +{
>> +       char delim[2];
>> +       char str[PATH_MAX];
>> +       char *result = NULL;
>> +       char *next = NULL;
>> +       int i = 0, j = 0, ret = 0;
>> +
>> +       if (argc<  3) {
>> +               fprintf(stderr, "Please provide kernel kconfig list and delims\n");
>> +               return 1;
>> +       }
>> +
>> +       if (strlen(argv[2]) != 1) {
>> +               fprintf(stderr, "The delim must be a single character\n");
>> +               return 1;
>> +       }
>> +
>> +       strcpy(str, argv[1]);
>> +       strcpy(delim, argv[2]);
>> +
>> +       result = strtok_r(str, delim,&next);
>> +       for (i = 0; result != NULL; i++)
>> +               result = strtok_r(NULL, delim,&next);
>> +
>> +       strcpy(str, argv[1]);
>> +       char **kconfigs = (char **)malloc(++i * sizeof(char *));
>> +
>> +       result = strtok_r(str, delim,&next);
>> +       for (i = 0; result != NULL; i++) {
>> +               kconfigs[i] = (char *)malloc(sizeof(char) * strlen(result));
>> +               strcpy(kconfigs[i], result);
>
> I guess there is no need to allocate additional memory to do strcpy.
> As the kconfigs[i] is just a pointer, we can assign the 'result' to it directly.
>
> i.e.
>
>         for (i = 0; result != NULL; i++) {
>                 kconfigs[i] = result;
>                 result = strtok_r(NULL, delim,&next);
>         }
>
Yes, thanks for your review.

We can modify those when maintainer merges it.

Best Regard
Yang Xu
> Otherwise looks good.
> Reviewed-by: Li Wang<liwang@redhat.com>
>
> --
> Regards,
> Li Wang
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
