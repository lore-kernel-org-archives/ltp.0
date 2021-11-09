Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7903C433F5
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 07:00:19 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC8F6115B
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 07:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CAC8F6115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D71193C0794
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 08:00:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EE033C052F
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 08:00:05 +0100 (CET)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 41BB220E77A
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 08:00:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1636441204; x=1667977204;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=BOOjUhnKJEVfxaXx3lBlM7KOXQDPg/+Fuw/gMh+NHgw=;
 b=H3ux2fwyBuC8bGQdTbpOZVewgrEwVZ82djybKM7+uaTMi3QZexDX8D6c
 EXd56PXSHjuRT+lBc8Ab8wmpqmw8uiod5XLT8Vmj2VhvVG7i11Y9KWPEb
 rSOb7eFqUeAx9RQjpgitNzqcGuIDzF6W5eHB0h+SpV5IwsqvaPoaBlFhV
 DQ/iM4ZfC3IcbHhUADwqpbia2e0s2H3PrzsR10tFJ/X4uGx8RDAP9LwSl
 ucYDXXfTKE8dRmNeBLUeZdn1QNku7QhqjybnFvZwNZH1i5sSGKadNc9a3
 VYnA4K224CKLHv76pw9mrSRckdZ9yVePGXRhLjGO5argyKFQd6OhQ4KlC g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="43238060"
X-IronPort-AV: E=Sophos;i="5.87,219,1631545200"; d="scan'208";a="43238060"
Received: from mail-os2jpn01lp2055.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.55])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2021 16:00:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvgTccrNlM08yo0R9DXfZmluQffmKMCIEN2RvWEJfGifQfypFazAzVf00q88n/AsOP3p9XsFijo+nim919vPTBFm61BMU7mIIal9WWwjXYTvIRkDcEklc22aKKfD2PWhaCZMYrbcr7wzAvur+vGhJ1e9n9Mkorbf8BMZ3biU5n7JBtWlEWDAvwZadN5q34clZsjfM+MsEgF9uKepIs4YdwJlbPJsZW5k3w7suSoOZWXzAhZ076/EdOtiuPnLPrWpAZFhuNqslRX+gnOIBOEhRtNOwhN4YJtooMRyXePTReXpwkCFCFQwQu0iLJTyVvrbxH7pSB0gHENV9eGc40nWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOOjUhnKJEVfxaXx3lBlM7KOXQDPg/+Fuw/gMh+NHgw=;
 b=Xr9Y10lpzYlWKrW4n509BGrQG3b5OYMHHewAGZMso4eEk9QL6GoYvNFTY0+L5XqjgxYYVjBSGxoir5muMCnMLHgvK/4otG7x/0imbWVXfB90IxLEfrZ3g4Cjz3cG4fvxHml/H5HlbwVt7DC1BKsVqziq8rJAiRypo7coY2mLvSxenT1rtSaJCaDh8qmETKzrFTnv2NmBiGwIFVf2zxx/H9Y0jEiDLTm7KLce1uOB2IQMKB7exb9ZfkllUQ8GU1w5UxVJDtIgQVcfllQxaue3KrSox9gXmI8etphkFJGWEoUjMDPBiIFxj4J/JYShAUtHRgODntdxlkmpgQ7/NV2FLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOOjUhnKJEVfxaXx3lBlM7KOXQDPg/+Fuw/gMh+NHgw=;
 b=c0RCZ8zq5T8Go/s7x8y+RI5SwWVnEodLpxn5iHr1ewPZpMcYVALVnqQHriCFyQoz+xybPPrX7CnsiIq84G/bAneoSMS+lVcCUjOfocmzqecukRnLENSj3W16DRwLeO9CNofoUu1Grvsy/UCjS/t+xTknqcU1HwXlXlBiEF8dUJc=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYCPR01MB7011.jpnprd01.prod.outlook.com (2603:1096:400:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 06:59:56 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9%8]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 06:59:56 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v2 02/13] syscalls/quotactl06: Also test with vfsv1
 format
Thread-Index: AQHXyy3duXARibgktUiDQt+T22V8Oqv51HUAgAEECIA=
Date: Tue, 9 Nov 2021 06:59:56 +0000
Message-ID: <618A1C75.4050501@fujitsu.com>
References: <1635337569-4634-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1635337569-4634-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YYlCVBY4z4Q0MNHw@yuki>
In-Reply-To: <YYlCVBY4z4Q0MNHw@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d182eb81-9043-4e62-bdeb-08d9a34e89e3
x-ms-traffictypediagnostic: TYCPR01MB7011:
x-microsoft-antispam-prvs: <TYCPR01MB7011C3B813A72DD6141CBC4AFD929@TYCPR01MB7011.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ufrpmk3p+Pi7vEGfz2O3i54C8u0ABTtrZxVw70oXsrctCGhCozzSqLrrtxV5hnCm4mxPUAfEpPOLO4mb9hArtxghNBl2t/HzO+p7xEDlJ6fcV9d1aCksFPrSr2PXccOw5uNTTqMo0dgo3MxbriWHJcWAOU/HqFUICG48E60mCXyNZY49O89l5+JydADG/7QSt0E/FTmCJrZpvT1g7Rn3wPpmdt2U0r2MNNP7rCjHapmgCMNl0ZHFFJuhXs9Pyx7b5QYjIgQm6cHpvazU/IQgx3dOYdV61GQZAFHy6OOM0e7cMuEJEmnv1o9czqMerCg7sWI1BP9ZBqWTXl7rO8poMMTeR483sLU9qscy4CFskYOttI7UUBzZbPUNVZAYppKytDqV/LDWk35qzNXDQVRzfX2jrGcBx6QyiAm6d/PaKSk3Yrc02a6Nuuj19UOyM/8faj/W+2a/j4m1N573Lc1AUT77SnBzVM0Gj71yGYVhr0eG8XnyxxQwdJo04p0bN90ONFPUWz0RK+A693k9bxj9ARIVP6HDhtlTmkC1msecQWBBDKlalq1OBnPkRbJhTWdIW+YPtP2AKb/cMNTbwJiI5K5aHlUAW7vUZyEVC2ztJlzYR4fsss3wSqV+3FxnrcvyJCS6DJQNsaKnhYtZblAGMHQXyMSu/MJz3xFkHiQoxZM+zitEHRaJ5jHIgboyQw8zzaTMvbJoHlOvAlDaHNi8qA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(85182001)(33656002)(66476007)(2906002)(38100700002)(64756008)(66946007)(66556008)(38070700005)(316002)(2616005)(15650500001)(5660300002)(36756003)(4326008)(6486002)(91956017)(71200400001)(76116006)(122000001)(8676002)(83380400001)(6506007)(26005)(86362001)(82960400001)(6916009)(186003)(8936002)(87266011)(66446008)(508600001)(6512007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?S1pmWHNST0VsNkNtU04yeDUwNVovV0loRmI1eC9KNnNDQ3RqWUUyN1A3S0FU?=
 =?gb2312?B?NXhZNGVZcXNrODN2SmFqeEE2MXRXUWhyamdKWWZVT0cxb3VLcWFrVVJwZ1M3?=
 =?gb2312?B?T0gyZEtvWTFrb3I5QVVNWUJ5aE43T2NXa2ZSR2tYNkFQSk9EampBWXdSZkg3?=
 =?gb2312?B?dU16NW0rM0p3K09UVEhZNlBNMWxxTXhuY1ZBdm5wMnZhL0h6TnR4S3VuQjJ3?=
 =?gb2312?B?bzJqQlNmb1ZOcDNjTU5EV01UQ1pyczVPRUQvVm03SzlydnJyYytyaEZrZEw3?=
 =?gb2312?B?RTAxUWRQS0hvU2trUnpUTXR1aCtiU2ZPQmFudTNZL29CeU4reTFCTmxKc05K?=
 =?gb2312?B?YmhYLzJCVDRhalV5bWcveC9OTHd3Wlp3R1BrOHF1ejFPUkZpLzRoSVlKSE9y?=
 =?gb2312?B?MTM4dGNJTmIrN0ZOcWxrUG9pYjZWWDh6VG1PN3BzK1VzZnVvb1ZVN3NwdjND?=
 =?gb2312?B?bHQ4NFV6WkZ6cXpCUkZUeXBOSGFaTEMyeWR0dHVUVXBkOVdBNk91cXRrb3lx?=
 =?gb2312?B?MjN5Tjl5SnVvR3BlMG9xcnRkSndoc0hxdDVRVE9ia3IvWFhNOFhUeUtZWWVw?=
 =?gb2312?B?WTVob3oyMEFZci9DUjJERzBKMHo5dDVjbElaaWwzN3Q0aDBWbVRJZG0xdW5u?=
 =?gb2312?B?TjNGUC9GME5uVisvQ2xENUNQZloxck9qMTgyRXE3dk5KMkRLWEhVdU9hbStS?=
 =?gb2312?B?NlRPSnJJQUNNUlc1bFdJRFBwbVFQYmhPbW80MWt3aWNQWDFKNHFEZW41NzZZ?=
 =?gb2312?B?YXVoSDlmWXkrZWtHVFpicWM2VVNJSUs0N3dRdXVob2RYNjJGQmVGV0JscVdv?=
 =?gb2312?B?eVlwWi81MEJZc3Z3NkVrQ0V0Q21sSGkzOVpvMkJSeWZ1NEVydEExRUJtUHEz?=
 =?gb2312?B?TEdIVmhxcVFMcGs1MXZPR21SZks5ZXczekJqL28xQVBvT1kzSTIxd3EzSlVL?=
 =?gb2312?B?U0FnazlkaDhjV29HYjdKWXYrdjdoY05jeWN2MU9JVSttaUpUT0dKVkF6bTlo?=
 =?gb2312?B?VERSaVJyR2gwV1RaUGZGUndleDluQzRKTitjM1hkK2hSWDk2WGJkSjk2RlZo?=
 =?gb2312?B?RWhtbkVlclpJZnpSbzY4TklOeENLY1dPRHZhR1pWeCtBR2RCbFo0bXp5Snc0?=
 =?gb2312?B?Z2d1ZDE2WEdjMC84Y2tSVG9IOFppM01rbGl4elhCa2k5L3NKbUl5S2RkR05P?=
 =?gb2312?B?dXF6RHhWK3NBMXVxRTV5bXJiZEJnd1lLWko2ZDAvRnRkbUhEcStEeHB5ZGtJ?=
 =?gb2312?B?N2VBYjBhWnZQR0tEdjRYMW5OdVFFcElVU2NaWEdHRjlDWWVsTit4SkpOTnV6?=
 =?gb2312?B?QjhGZkNIQnVySVBnTk5FZTUrNE9RK1VhUEF4aDA3dnV2MkZKb1RvMmZ6ano4?=
 =?gb2312?B?dUNQdUU3a1Uva1o4aGU0WWhra05DNU5nNFJRM1pLb204eklqbm8rdnRsQ0h0?=
 =?gb2312?B?Y0hxMUpWOC9ZVlJSTThLKys2NXZhNTlDZVFJVFZla2pFQlp1ZGZWeE5KNmN1?=
 =?gb2312?B?TFRNZzVOa2RvV1ptRkdEYmkrajlxeitoVXo2U0d6UUVRMC96U2oxWEZNN0hy?=
 =?gb2312?B?dVh3czZJV2Z3K1dheVBEVmdkN2M5U0NicHV6YlFtTmh0OUFmTnk4NnM4SEFR?=
 =?gb2312?B?dVlKRnZvQ1hlVThKQ3dFZUppUy9BYk4yLzR5ZS9rdnBMaW1BeFZqK2wxR1FC?=
 =?gb2312?B?bldoZTFlU0x6SEdaSXBwK3V0bk1YTFk3N2FLaUlpWmR5d1ZlenA1bFFmU0Zx?=
 =?gb2312?B?T01OeWNnOHU4cUxsZkVLdzRyeTYzTWRoTDBXU0l1Q3JqckdlTlQxc1FqODZI?=
 =?gb2312?B?bmsrY0lUM0d2WjhkQ1AvRzJCcUwzYTQySGpVeUtFVGtQWjZzbDBiVC9CdDR3?=
 =?gb2312?B?WEpiQS9BODRLeHM2Y2dOMFpRdVBwbVdvRXRTYXYyODBXQWloU2c4dk9SYStP?=
 =?gb2312?B?cnpMaU01VUFhTWJXU2NRVkt2UjV0SzJzUHkxQ0p3T1k5OS9SRXpPUzRSQWlV?=
 =?gb2312?B?UXJSV1JRZVhDQ05WVHdMMXFhM2NrSld6RGZYTUFOQXYyS2FUY29oaEU0WTJP?=
 =?gb2312?B?cTEreXNqMnpTbndVckhkWjY5dWtNbHJlNkh5OUZzMzVkdk5nQUxWWUtkMERu?=
 =?gb2312?B?SElXemgyL0lUYlF0OWpuWlRsZ0ZEdks4dEhpN3k0Vng2NlErTjFuVDdMV1pJ?=
 =?gb2312?B?dnlEa3RLMHhYdGx6bFdwNU1NQTRBY2Z4U1ltZjNtbDlWK1lOUzgvdE5QYUhy?=
 =?gb2312?Q?4JIPqU3UEh34HxZZhPCsYBtAYuBfNxD7yE5TKhvsVw=3D?=
Content-ID: <5967C3D09FB03644A1355C43C3CBB6D9@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d182eb81-9043-4e62-bdeb-08d9a34e89e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 06:59:56.4910 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NoJAJjJGRD1gA96OFz6/zC2S9mHvN/Q5UfFM9Q+3wEhRFQYgk1fF1CDugvLpJRF+NyChdhEOmJ/IgAEWd5+G26tz3jJzvHBbZVeSrj0ydgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7011
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 02/13] syscalls/quotactl06: Also test with
 vfsv1 format
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
>> Add a linux tag and fix docparse formatting.
>
> I guess that the 'remove useless geteuid()' should be in the description
> for this patch and not in the previous one.
This patch should add 'remove useless geteuid()' and the previous patch 
also has removed useless geteuid().
>
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>> ---
>>   .../kernel/syscalls/quotactl/quotactl06.c     | 90 ++++++++++++-------
>>   1 file changed, 56 insertions(+), 34 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
>> index a10d1ca07..76343adf9 100644
>> --- a/testcases/kernel/syscalls/quotactl/quotactl06.c
>> +++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
>> @@ -1,41 +1,49 @@
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
>> + *
>> + * Tests basic error handling of the quotactl syscall with visible quota files
>> + * (cover two formats, vfsv0 and vfsv1):
>> + *
>> + * - EACCES when cmd is Q_QUOTAON and addr existed but not a regular file
>> + * - ENOENT when the file specified by special or addr does not exist
>> + * - EBUSTY when cmd is Q_QUOTAON and another Q_QUOTAON had already been performed
>> + * - EFAULT when addr or special is invalid
>> + * - EINVAL when cmd or type is invalid
>> + * - ENOTBLK when special is not a block device
>> + * - ESRCH when no disk quota is found for the indicated user and quotas have not been
>> + *   turned on for this fs
>> + * - ESRCH when cmd is Q_QUOTAON, but the quota format was not found
>> + * - ESRCH when cmd is Q_GETNEXTQUOTA, but there is no ID greater than or equal to id that
>> + *   has an active quota
>> + * - ERANGE when cmd is Q_SETQUOTA, but the specified limits are out of the range allowed
>> + *   by the quota format
>> + * - EPERM when the caller lacked the required privilege (CAP_SYS_ADMIN) for the specified
>> + *   operation
>> + *
>> + * For ERANGE error, the vfsv0 and vfsv1 format's maximum quota limit setting have been
>> + * fixed since the following kernel patch:
>> + *
>> + *  commit 7e08da50cf706151f324349f9235ebd311226997
>> + *  Author: Jan Kara<jack@suse.cz>
>> + *  Date:   Wed Mar 4 14:42:02 2015 +0100
>>    *
>> - * Tests basic error handling of the quotactl syscall.
>> - * 1) quotactl fails with EACCES when cmd is Q_QUOTAON and addr
>> - * existed but not a regular file.
>> - * 2) quotaclt fails with ENOENT when the file specified by special
>> - * or addr does not exist.
>> - * 3) quotactl fails with EBUSTY when  cmd is Q_QUOTAON and another
>> - * Q_QUOTAON had already been performed.
>> - * 4) quotactl fails with EFAULT when addr or special is invalid.
>> - * 5) quotactl fails with EINVAL when cmd or type is invalid.
>> - * 6) quotactl fails with ENOTBLK when special is not a block device.
>> - * 7) quotactl fails with ESRCH when no disk quota is found for the
>> - * indicated user and quotas have not been turned on for this fs.
>> - * 8) quotactl fails with ESRCH when cmd is Q_QUOTAON, but the quota
>> - * format was not found.
>> - * 9) quotactl fails with ESRCH when cmd is Q_GETNEXTQUOTA, but there
>> - * is no ID greater than or equal to id that has an active quota.
>> - * 10) quotactl fails with ERANGE when cmd is Q_SETQUOTA, but the
>> - * specified limits are out of the range allowed by the quota format.
>> - * 11) quotactl fails with EPERM when the caller lacked the required
>> - * privilege (CAP_SYS_ADMIN) for the specified operation.
>> + *  quota: Fix maximum quota limit settings
>>    */
>>
>>   #include<errno.h>
>>   #include<sys/quota.h>
>>   #include "tst_test.h"
>> -#include "lapi/quotactl.h"
>> +#include "quotactl_fmt_var.h"
>>   #include "tst_capability.h"
>>
>>   #define OPTION_INVALID 999
>> -#define QFMT_VFS_V0     2
>>   #define USRPATH MNTPOINT "/aquota.user"
>> -#define FMTID QFMT_VFS_V0
>> -
>>   #define MNTPOINT "mntpoint"
>>   #define TESTDIR1 MNTPOINT "/testdir1"
>>   #define TESTDIR2 MNTPOINT "/testdir2"
>> @@ -43,9 +51,9 @@
>>   static char usrpath[] = USRPATH;
>>   static char testdir1[] = TESTDIR1;
>>   static char testdir2[] = TESTDIR2;
>> -static int32_t fmt_id = FMTID;
>> +static int32_t fmt_id;
>>   static int32_t fmt_invalid = 999;
>> -static int test_invalid;
>> +static int test_invalid = 1;
>>   static int test_id;
>>   static int getnextquota_nsup;
>>
>> @@ -105,7 +113,7 @@ static void verify_quotactl(unsigned int n)
>>
>>   	if (tc->on_flag) {
>>   		TEST(quotactl(QCMD(Q_QUOTAON, USRQUOTA), tst_device->dev,
>> -			FMTID, usrpath));
>> +			fmt_id, usrpath));
>>   		if (TST_RET == -1)
>>   			tst_brk(TBROK,
>>   				"quotactl with Q_QUOTAON returned %ld", TST_RET);
>> @@ -135,7 +143,7 @@ static void verify_quotactl(unsigned int n)
>>
>>   	if (quota_on) {
>>   		TEST(quotactl(QCMD(Q_QUOTAOFF, USRQUOTA), tst_device->dev,
>> -			FMTID, usrpath));
>> +			fmt_id, usrpath));
>>   		if (TST_RET == -1)
>>   			tst_brk(TBROK,
>>   				"quotactl with Q_QUOTAOFF returned %ld", TST_RET);
>> @@ -150,19 +158,22 @@ static void verify_quotactl(unsigned int n)
>>
>>   static void setup(void)
>>   {
>> -	const char *const cmd[] = {"quotacheck", "-uF", "vfsv0", MNTPOINT, NULL};
>>   	unsigned int i;
>> +	const char *const cmd[] = {"quotacheck", "-ugF", fmt_variants[tst_variant].fmt_name, MNTPOINT, NULL};
>
> Here as well, I would consider storing the variants pointer.
Will do.
>
>> +	tst_res(TINFO, "quotactl() with %s format", fmt_variants[tst_variant].fmt_name);
>>   	SAFE_CMD(cmd, NULL, NULL);
>> +	fmt_id = fmt_variants[tst_variant].fmt_id;
>> +	/* vfsv0 block limit 2^42, vfsv1 block limit 2^63 - 1 */
>> +	set_dqmax.dqb_bsoftlimit = tst_variant ? 0x20000000000000 : 0x100000000;
>>
>>   	if (access(USRPATH, F_OK) == -1)
>>   		tst_brk(TFAIL | TERRNO, "user quotafile didn't exist");
>>
>>   	tst_require_quota_support(tst_device->dev, fmt_id, usrpath);
>>
>> -	SAFE_MKDIR(TESTDIR1, 0666);
>> -	test_id = geteuid();
>> -	test_invalid = test_id + 1;
>> +	if (access(TESTDIR1, F_OK) == -1&&  errno == ENOENT)
>> +		SAFE_MKDIR(TESTDIR1, 0666);
>
> Why don't we SAFE_RMDIR() in the test cleanup and create the directory
> here unconditionally?
Yes, Will mkdir in setup and rmdir in cleanup.
>
> Other than this:
>
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
