Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAED6C433EF
	for <ltp@archiver.kernel.org>; Thu, 24 Feb 2022 07:23:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 716743C9C5F
	for <ltp@archiver.kernel.org>; Thu, 24 Feb 2022 08:23:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 143D63C966F
 for <ltp@lists.linux.it>; Thu, 24 Feb 2022 08:23:27 +0100 (CET)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 852B96022C0
 for <ltp@lists.linux.it>; Thu, 24 Feb 2022 08:23:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1645687406; x=1677223406;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=LP6h0fmXzqYNM7TJM0UnudQEFiOZi8x5syNx4NzVM6w=;
 b=sdIDaVGrAF947B2Mmnn8RlOGsJB3+7boANhussjYEVD9VX0CoAPdT7lL
 ln/ZtFp8LTTH7KZur4pYKojgjXqvc0u0TWMGG5k5wkbhe5Q2a5w4Qlp+h
 9YVMlk3LzFVrM7J+HrNa1iPulQTYuTZ8vaCSRdyJENZL4RK+GDzODmtcQ
 WTqhXM2sqz3gQBOPDzmrXnn2y7Mpu/NJ9q2QFENiWSUuDl2IXzjGleVE6
 c2rmoYMB7DmqP4xDNbMIg5f1BavGsQnfJy1I0oP+D6hD9UkL6Fq31coHf
 SgXC1RWQyFopLzXYcGiU7C4AJAMbh6PqswcrO0JRxFtAAF2mqq4wEfYzp Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="50366138"
X-IronPort-AV: E=Sophos;i="5.88,393,1635174000"; d="scan'208";a="50366138"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2022 16:23:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEn2ojy5OTHTPcy7UbnTWNVMgYlcSdmmxksM9ADDoWdGNIgMLmGWDJroAghQRh+zPA5sEZNiXN7xAx5nDxmTLFmD2PTUBQ2eGHAXCZQ2eEt3mjf1witKweHtASC694UI6RtwDARLEJDeFVjKa7vUA2fMfAQuK1i8tnJ6tBF+jRVkrdZVpdJI74ZElTxkQ04c4TPc2gqksTlzsmvxqnVmoGmANLRx0Sd5sS+3e9w7bCzJdTsMbYpGnGwonvQ5lR2um9mzBQ2bEGlhznH/IcVv6vA04yY8kwZFYvEpDU3r9CF0tlQ7Oe12OW7zUhw2uivSt0jQyV1AyARDFeLde3Vp+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LP6h0fmXzqYNM7TJM0UnudQEFiOZi8x5syNx4NzVM6w=;
 b=jKhp5+49b2j7+aPBogZWpaYX09DCsoLqtw6mZvXUK1papbfLFrxis86XRDMm8+WyNCMhjAzP5MkbaE4S6ZvH/7Y1JvpU4tP6yqmzyoTYQR3QfrEoKuG1cxad1I3kjsTKy//uxC15M8OkV6B1dX14cafiMnH8Q9orC/zyxoFXOFcAYCn9ndZDhtZozOC2x65RfdwKIKzXPj7ZxPT6lts1+QziTaQipkiIB8h+M6Y3mtoeIl839K0g0a4wLRqaDvuDM5gK9WQH6dCUw5FGkL3wppDYmw56mC8/1WKF2Rf3PyNl3YQsh/4PcLKMV/frGsU9NwIfCMf5IkRMNBR0J/i5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP6h0fmXzqYNM7TJM0UnudQEFiOZi8x5syNx4NzVM6w=;
 b=lcXulI9SfxFBS8YS5S/ZybOcYRRcZxrHsSiyeeee/6K01+CePqSnKt46JH8en8Nit1umkbRanjk+veQvtOxNJYftBWfkdT5hooqfEL36k9CcjJIOqoB/3ZlYF0zIQ56M/4VE9+QcwO6CRLmrb/TJJwMZy9J/kUNp8gyzWaze//c=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSBPR01MB5031.jpnprd01.prod.outlook.com (2603:1096:604:7e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Thu, 24 Feb
 2022 07:23:21 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::29ed:c2:4190:cf13]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::29ed:c2:4190:cf13%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 07:23:21 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v3 3/7] lib/tst_safe_pidfd: Add SAFE_PIDFD_OPEN
 macro
Thread-Index: AQHYJ8f9VyVJC3ucM0Wh+P9Sj/iB7KyhIu2AgAEsgIA=
Date: Thu, 24 Feb 2022 07:23:21 +0000
Message-ID: <62173291.3040704@fujitsu.com>
References: <1645519272-2733-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645519272-2733-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YhY2fZlfhv++XkMh@yuki>
In-Reply-To: <YhY2fZlfhv++XkMh@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0e751e3-d5fb-4082-1005-08d9f766896b
x-ms-traffictypediagnostic: OSBPR01MB5031:EE_
x-microsoft-antispam-prvs: <OSBPR01MB503186364A152D9A950F8861FD3D9@OSBPR01MB5031.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RIs2fdzaGzcnE10gIYcaPfFKGTAr8bWW6Z3DKDkNzFhXppnCw5WeHyzk93Ta6GAVBYzYVxCtVaSkU0+Tn3+Q99wtXX4+G52Gihz09jlE7F/ooXyG5do6ex8Li9p5DZFOy8GIZR8ja4hrR37zLS7SkwwlJYe9sm6VHFoajNl4o4+LRHyaLiPr1na1OWQAr1Ma2ByakHfoShMRDqDry+ZvqPMfz5ZM3ndr7RA213PahsBh/H3jjVlwsU4AUTiKnkaiLCmpQUCxKCCPpZdKyxrpFxHApqA0bnsinzrWntBrTPqRUYN0iOUR05wWUC4pLP2jK+VZuvbaWggrzsdCE/t75ysMvAWBxGIuLyH+ImPy8lFle8SQgDgTxl8hsZSmv/Rg/ryGL9zlZCKRy3K0O/ohy4L9p81Qtyple3hKn3kRClX70ZBMKkMgXirQLZqd9vzGQdT6Tpr8YNzSamdA+1jYMjdHD1f88RD3UbnVrOdFigMrUXuPaBbpljnuWvwMHuflGuHASUnn+AV+y94CMARUF+lGZCrODdEQnhQEP+VTog2Vt8PLHhOVxR6EBG6jytAzUFb15B13ElLFYmWLZavZd7fipDb0uVisVnn36c1ralrkRsPtBgfbFFnSE+logN1IvgN4N359PVEuRsB5UmB14mOOfUGWmKdM20terBgwc4hh5mi4lvJ9NdJhgcxg/AEolqzSoTcJsTtUDCfkVEjxJ75bKvAH8VzYfo2FSr5agFU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(66556008)(85182001)(36756003)(186003)(64756008)(66946007)(2906002)(66446008)(122000001)(4744005)(66476007)(83380400001)(8936002)(5660300002)(71200400001)(86362001)(6512007)(38070700005)(6506007)(6486002)(38100700002)(6916009)(82960400001)(8676002)(4326008)(87266011)(76116006)(508600001)(2616005)(91956017)(316002)(62816006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QjNDY2QrWGh5TkpzdE5ZUHhjU0RzVUMycGFVcDMxbzhNUXBDaFBnZGlvMENE?=
 =?gb2312?B?b0wxV0JQSFg2Q3pyczdqQ3luNDRsVUVSbjgrMnZzOTBoT3Z4Q1VKYnpTVE4r?=
 =?gb2312?B?SnEzSFFRUW02ZGRpdUQwRnUzSEVacE5FL1piL0xBcnUrWENXNlo2dlBvTFBh?=
 =?gb2312?B?ckdKVWptQXRxYXFOSUpick5raDhXOWF6T1R2eG1CU05KKzBGQ3VQc3N3UjRB?=
 =?gb2312?B?bldseElMbzBZQ09yb0N6SEY0YjFmRVNaWTJiMGRkSHNXT2ZwN0g4SG1Fd1Qv?=
 =?gb2312?B?YW9TS2xRbmlETk5jRDRZclZqVmFXcjdVcGx3K3FuSjV5WDdBNXRYbEkvZ1Fj?=
 =?gb2312?B?U0NDR3FWaTk3N1k4ZVkza3p2elIzK1poN2VxbzZjTER0UERJVlMzUmNQMFJl?=
 =?gb2312?B?NmptMnhhK21qd2ZqbjBuS2pjaytGMllHUFdXbUZRc1FmNlR6NXdLT0xYZ3hI?=
 =?gb2312?B?YzVnQXF3QkYxb2VIdGJVMW8xbmhvSDduUm1IQnF0SDF6eWFOSGVaU3o2N2ZD?=
 =?gb2312?B?RmhtTHdzRWRpS1JqK0VPOVBKM3BDTUUzUDJseFBQRU00aDRtMDgybytCRTVI?=
 =?gb2312?B?ZFc4cWVMWHgzS0pRaERLUUtqQnR0ZjltNXNrUlZzaWhvZGVmNFM0czB6aWd2?=
 =?gb2312?B?alNDN0hacUl4bEtVY29vT2ZCenV3ODF3V01qcTVqaS9lZVR5ZG9wYkxmcVRO?=
 =?gb2312?B?eGNSRmJyT3FBVnBCdEpDb1lHbW5PbTUrcW9Iemd5YmNIMVZNcGhQS3hBODV3?=
 =?gb2312?B?ejVxN0NYb2w2cjZWbzViZ3REVm5nTkZTTEdKSFNadC9TN3hKbG1yNk9HQXFk?=
 =?gb2312?B?YWpUaWlNektneXg4Ui9jNFpvYTNRcEsyN2NsTU1nNWloWXYrcDZ5U2dNdFVF?=
 =?gb2312?B?bGM4QmlEbXpUQnFxL2hDak1PTkpMTGJ3cjRudjVqbmZjQnRaaG43dmxPcGhW?=
 =?gb2312?B?ckNuUHNNUk84REVwazYwcS9HTSthblI5Y01FamphWFhVR2JoL3FBeVdGRk52?=
 =?gb2312?B?QkZ5ckVFTXRoUGpJN1pacElrYzg0bS9YMVF5ZStETEdRQTVnT2kzenFQR0pw?=
 =?gb2312?B?dFlGb3YxQkNxcGJLUWhGUVdBM2d3MHA0ck5raXlPc04reDRPM3R0djd4UWtp?=
 =?gb2312?B?WXBVelhBWEVvQXdEQXI4QzRud01LZlZjL1VxNEJuOXE1SVlwdFVVYnlpM1B5?=
 =?gb2312?B?Zk52SWdmZmN5bHhKS05KaW5ORTlyQUVMeUUvOEZNc0NuTXQ1L3BnZk01d042?=
 =?gb2312?B?bmFlSHAzSm9OSFZramQvTWw2R3Nnend3SFBnZm9VQW14REd4VXdzZTh6SGdl?=
 =?gb2312?B?ekpYN3c4cU9CMnVaWndSZEx1WVZNeGwweEY0eitEenpYeXdRclVPcVo3WG1O?=
 =?gb2312?B?WTVmTXkzdCsxZEU4SmZOeDVBRkRKYlJveXNybk5pSzh1Y1phdnR2blphdmRE?=
 =?gb2312?B?U0RHZ3Z4bjAzRWFldUFRUUlUdVpDemExN2huMXBTVUxyd0ovSW5OWExnckZF?=
 =?gb2312?B?MUYvaDNFS0l1RjJuVW1VbmtuTnAyKzE5ZzhBc01FSXEwRUplYnh3OVZuS25Z?=
 =?gb2312?B?eUdPV093emE1ditnU3BmczlNRnN1VXVuMkc1VWpUekZGNHU0MDZ4K0o2a213?=
 =?gb2312?B?eU9EVE9ZQ1RLZ1J0bS9wVFpKVTdaOVJVRlNkbDVDbnJYbG5jK20wSHd1emV3?=
 =?gb2312?B?TmhGc2lLR1hONExrZFpZS1dKUWM0WDJKUmpTU0JqRGYxdEFPUVZyQzVOd2dn?=
 =?gb2312?B?dUFYd0NDaEYyemJ6RFM2aWRneTZKNkZZdklQOEE0SmcxdlFOc29OYnpoRGUv?=
 =?gb2312?B?Q1FCUGhhMElvL3cwMkhHQ1NMWlFxZGNPWnJuMGhaOE04YlpoeC9aSFg0bGRQ?=
 =?gb2312?B?V2dmTVI5ZStPWkNsS1FYcUhsMGhaQ1NUTG93dWtRK3BGUy9JQUMvZFFhczIy?=
 =?gb2312?B?ZDdBenZMSUorVmZ3Vi9RSzh6UThlcFg0K3VVR2VJK1hCU1ByZWUyV0wrWUo2?=
 =?gb2312?B?eWRuc1pjV1BrYXZKdnJEeDlDbWZ5ODFJSXo0bnRvbWRUV05yVHd5RUZsV3Ny?=
 =?gb2312?B?QzlVSVpVTktwU3g5TXNYTnNkam1Oclp2WXMvSWx5Vk1FRlgwOW5CVGVaVXJ0?=
 =?gb2312?B?L1dyU3ZhUzVNcDF3MlZYRzlWTlc0aWhJWGgrMkhZcXJyeWNqd1FEbU1jYTB2?=
 =?gb2312?B?VjllMHYxdzVOaEpzeUViemtsOUl1VGxlTVYvSDErU2FFWmplWmZpVWVaVjU5?=
 =?gb2312?Q?Me0l8yCencSCchvFPXtq4M3TAXO/r7vSGoDYyA63Ik=3D?=
Content-ID: <ECCBBAA2435F7548BD6834135B623CBB@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e751e3-d5fb-4082-1005-08d9f766896b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 07:23:21.3387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7zTOUBmFXoF0ZGWJeYBsD1/IaGVpZmcUvn5iFn9kqLSchjm0LLBOG35RWzJ8ICZeSblmHcxLMoVPOBDiIVfoxKxT4sZoljtXn8rWShLWGMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5031
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/7] lib/tst_safe_pidfd: Add SAFE_PIDFD_OPEN
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril
> Hi!
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu<xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +#ifndef TST_SAFE_PIDFD_H__
>> +#define TST_SAFE_PIDFD_H__
>> +
>> +#include<unistd.h>
>> +#include "lapi/pidfd.h"
>> +
>> +int safe_pidfd_open(const char *file, const int lineno, pid_t pid,
>> +		    unsigned int flags);
>> +
>> +#define SAFE_PIDFD_OPEN(pid, flags) \
>> +	safe_pidfd_open(__FILE__, __LINE__, (pid), (flags))
>
> Is there a reason why we start a new header instead of adding this into
> the tst_safe_macros.h?
Just avoid a big tst_safe_macros.h like tst_safe_sysv_ipc.h does.
Also the pidfd related syscalls seems no libc wrapper.

Based on the above two points, I started a new header. Also if you want 
to merge it into tst_safe_macros.h, I will do(I don't have objection to 
add this into tst_safe_macros.h ).

Best Regards
Yang Xu
>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
