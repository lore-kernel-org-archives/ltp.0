Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E687CC433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 02:13:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 939BB3CA0B5
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 03:13:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D96423C0F5D
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 03:13:38 +0100 (CET)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1042E1401705
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 03:13:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1645150419; x=1676686419;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=UBZp5DO/dNy4dhmu30+6e0V3M6kphXiwJLtVWg2Ct3w=;
 b=ffwDCwsNv21siI2OOdomMdprxWzQPaVu7CIfb80F3a4di/foYq5J3iF+
 gmNiOWO5ROUpjpZGa2dNg4YSMe8kLRt9I2/aBAIghZc4Mw80HqQAXSG7b
 B00l2Tbo9auVTPsjHqlo5HzDPCAJBmYmftQDWjBQsx8UO618UdsBjIhS/
 TnElQZW0UXbor6lLmXXitPkg2X+ZiC7H4h5iBe+aVjAftrAKb3KvGEuBh
 xarjbGwEVH4DNVgwWc4vsy1MqbH5LeVJswTe6sE5y3tnBiflLX6fpiXFl
 wJ8vqKHeZH+7Y13zaZYJiRTGUiu77v8aGwT5EzOgZ9z8K2ighVOJa+v6G w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="49938394"
X-IronPort-AV: E=Sophos;i="5.88,377,1635174000"; d="scan'208";a="49938394"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2022 11:13:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSea7cGFKzLUG48nRPgnwLwPTewNXkQJBqYIqEFC4rf+KCm4Pul8SWqOE6+4P7UHT0FIZBWXIMJwjNAuIf+K5rpOXO8vDyGnWrqeG1xHC7jdLh3yfdiBt33gHdIvLAr8Jb8z+nX4UDfZWdFhcVu/QHQJaHELpIVA+nxwrh1fVo8y1G2OMtJE5er9MWLU3MxzFcZeDMGSOdNUcSQBDTItxZoLrDZYu7oWaDVvmbEBEovCmMzDyMcQI+HVLj/mN/uaUrJPAlG/RofwMBOI3ELD6FaoxqHZftmu2h1ct6xi+u1GSbk7Pbcs/haLL53fIfQgK/roKhWOgzh59qFzUrwWyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBZp5DO/dNy4dhmu30+6e0V3M6kphXiwJLtVWg2Ct3w=;
 b=DY4PhzDoLpRBM2pgJtUiQQ7rg0Vbk3a/0Z8wg/7Yf7g9/mSwztIkSGVnrVxMTyZCAwoXy0U+3U1thJiW6/8HF2pkLlMCQV4/iT1VEPxTcwRQMmmEJ67Lou1w/erNRDZeWywqS9RNkROkP1V+RvaD8FLQHI+yoda1euOgbomrocF0+8X3Cfqk58Huz3gGBvwDP0Jo/T+HcFcgaePcifVpnUQtIfAcnL2lUHfsmGkqmXM1diroosMiOL0nwurRLdCfYgRbxKH1FwrQv1VVW7SBqlHsYwo90VJFZEvL0VpS/CLdOxjPxxWMPnXbQ9C0qzpo1Hc2PBqJLgsN4xpSYZtfYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBZp5DO/dNy4dhmu30+6e0V3M6kphXiwJLtVWg2Ct3w=;
 b=HQVbtV7VGadH3KF14sfNszna1dlc/0S57HmQblXJukkGoxkg0GYoNXdQmj5w7IeVGcBhqSK/YPzb9s0pfYHF/Nm6DA1WgvOa2Ya3i5aeIS/y8CUIbQRto1JYdJi7sk0fjl/wXgQiEKLqLx1wfSPYkk46B2NMpb1DZni8dbMhDYg=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSZPR01MB6862.jpnprd01.prod.outlook.com (2603:1096:604:13d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 02:13:33 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 02:13:33 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 2/5] lapi/kcmp.h: Replace GPL with
 SPDX-License-Identifier
Thread-Index: AQHYIxyhoBgYskLO7UqcWl1UJyOVjqyYGOeAgAB7UgA=
Date: Fri, 18 Feb 2022 02:13:33 +0000
Message-ID: <620F00F6.9000108@fujitsu.com>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645005868-2373-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <Yg6ZgyD3R2PgL+HN@pevik>
In-Reply-To: <Yg6ZgyD3R2PgL+HN@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3153bbc0-6080-41d2-a1a1-08d9f2844394
x-ms-traffictypediagnostic: OSZPR01MB6862:EE_
x-microsoft-antispam-prvs: <OSZPR01MB6862C7336E99C196923BAF3BFD379@OSZPR01MB6862.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: azH0DbF5objzNSXgIT8EJNymIQMVYxp+0y8hZeSTyk6T1SJdN6pOYR2PCSyuv5OJP3fBT25/9aHRBwJGvPpriEp3zGvYBhQuJBX1pEdV29DrKHqB5r6UEmSSWqdDvDK5ahWcjvEMEuaHxSPz6ODKWxqW2Ox5vIwdmk+zfhbhCNw7hu4aPW3KnA41jhIwdqMhZEVKDjZZ91CtzK2W479xuH8h0ONmB7i33nG4k4uFLzo2Kn8ZOtaJqSQY89UtxHpnZIY123pVfc73BqE1FcJTetz7k/7KqpYPU25Vi54lKjKOyjF110F/l6yvwwd4Xi64Iu7rAjL4OWBy8R50Z38h3rHCgrCMnYIJn/M4tkBEKJAN2PVd4fUpUWtoA4IkZ/aeLRAWEov/7s0m+T6Xbhe6B8JlxX3LDufKPRkiksMvR8l6Q4Nhsr0MxNfHcYM5od9cMPtweoBaaZ75GQZmSjojBa9bbO53CeCeUVC3dP1zLsyIAZNLwQmUKyTLOIjSlE7WYF212o43g5mtl+zwgbJbEyvBpunYhhvFR85JjbNPcnTxW3Fyp4Snwfu411Sg/QvGnf198Y9Pl22fiVGJQ9IZnL7K0quU1HIPYarMn9vZaaUnwN2tBx5VXEUQgafxEBYnArYuOx0bGX7sTRr+8Yf626AVbMTx1M2RGPCtuIZsYBCVGXCYksXzI5Jo6iqC4sTRJlXJJWdSLaDUSsCSnFdZzGox5fThNtPt9Vz3nq7s+Cs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(71200400001)(6916009)(36756003)(82960400001)(83380400001)(85182001)(508600001)(6486002)(87266011)(316002)(122000001)(6506007)(2616005)(38100700002)(4326008)(66556008)(86362001)(8936002)(33656002)(186003)(66946007)(5660300002)(26005)(91956017)(76116006)(2906002)(66476007)(38070700005)(8676002)(66446008)(64756008)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SzRNemVJY2xrZTdMdFVrU0hvbGRQajM5ZEhzRmpTdGcvUkdXeU9jM29UM2Nh?=
 =?gb2312?B?RVBSeGt6WlRhZUJ0NThZYUs4RGx4eE9ycGsvZXVTOVFaOGYwQnNVMlNSNW9s?=
 =?gb2312?B?SUFQUHQ4Qnd2bnFVOG11NW9JbVlZWmxVeE80c2NkQS84eXBwbVpsNVhpWTNC?=
 =?gb2312?B?bFR0Y1phMmxRNGN0MEhwZytvRTFFTTdVdEZhY1pPc1oxQ2Y5dmZROXhiYlpw?=
 =?gb2312?B?SjQ4Ym91ZklFNWdZVlNFRVBiV0NEczZQNVBJT21iMFpVOTM2ZFdHclptVlp0?=
 =?gb2312?B?WFVJek44VnlScEZtODd1UXBTdjQrWms2UDFxSmF2QjkydzBMQ1Y1K1VCaENr?=
 =?gb2312?B?VmZLQkJlUHJpM3pMVG5PQmFpLytUekVCYmJ4cW9tQmIyb3ZKV1cra2hHYTdO?=
 =?gb2312?B?dUorL1F1NGs2Z2ZIR3p0UkRrUXgvc3o4ZktjZVdDSXc3NEZqS0tJSTl5RTBH?=
 =?gb2312?B?bGhPbjV3RGJKU2RaS1ZoRFFOTlAvTnZOT2dKOVJYZVVXV1IzdUVjYnhCYmhX?=
 =?gb2312?B?YlZJT2JNclgyNlFTUDZaNEJzb3N2aFJnZGRSV2JqemxaME1KVVF1TW5kTDhq?=
 =?gb2312?B?MWhNQWNBMXNTSEN2dERDNFRlZkwyc2NJdWVST09XaU80S0VLaFFseFZORUpJ?=
 =?gb2312?B?Y085NjRUUjB4aGM4SWdQL20renc3UStGTVJXcWNMMC9QeGJhSVFWdkN1cU5z?=
 =?gb2312?B?alhyTFBBK0puN0NKM05HaEF3anUwclpYQzZmK1QzcW84UVd5QVRmdmRFNUts?=
 =?gb2312?B?RHE4WElwT2RVcFlNeGwvdmNiU21mQ0dOM3o1Mk1TUDBHeFI1bnhUMDRkRCtp?=
 =?gb2312?B?bmJHRldlR1lKcW1Ucll2MERTRHJLaUxXSGM4ZC9lc3dtRDRwL0NSM2hSd1B3?=
 =?gb2312?B?K085Zkp4NHB6SjhiQTIrUnFaVzVOTzNmVi9kODg5aDdValFtckFiejcrRU5X?=
 =?gb2312?B?c1N0dG5teXEzRDVVUElKdnF0SnBibHlpdkpYYUJQQTQzdTBhdk5oU2tCVFRU?=
 =?gb2312?B?MktONk1ZeVdqaHF1YXp1RlU5dzQ5QlJPY202ZmlnT3prakJ2M2pwZFRtcjlF?=
 =?gb2312?B?SUNjMTFOSEZBTGkrYU1CeDdjUXVlNFVuanorU3IxckNhNDZyOWZUQWZuOTA2?=
 =?gb2312?B?ZjFJSTNXeXRPWW9XTEJaamRNRWtxNHBpM05SSnFqZ3BmMEZHbHJhOCsra0po?=
 =?gb2312?B?OUJOZDJTYU1WbXNET2d3NlJwcGJaWHNRVzdES21vNzRXWFExMStDTm41UUQx?=
 =?gb2312?B?QzZXL282QnJCZFlWRlQ5bEc5Umw1bysreVhiZUJsZ0VxZzBIb0VDU1oycS91?=
 =?gb2312?B?bHN1TUFXYmFFeHFRSkxocTBrVG1NVHliODkzZXo3V1A0dGFSdjB6NS9oRWZn?=
 =?gb2312?B?Vkt6emhINlptTS85WmFyYmVTWlVCNy93VWxET3dQTUpKalkrOElKNzlUN2Fw?=
 =?gb2312?B?amhUb1BPZVZFVzVxN3FKdHljeWtyTWV3LzNtUndhUjh3Z2ZER3F0VGt1aXNV?=
 =?gb2312?B?QWEwdVg0dTM1dWhadEY5a0RDbnBzM0N0YWJiRGtNcjltTjFrejdvUjI1WWdB?=
 =?gb2312?B?cnNoaE9HTWRDRGhiV2h1UG5PNGVPeHFhSGw5VVB5S2JONzBsTVVlR0dOVEgx?=
 =?gb2312?B?cDdnanZLUENNMzU2OEZQeHFVdHBxSndhQ1d2ZHpQeG92UVRuL2NaUGthTit0?=
 =?gb2312?B?K0g5ZlY3YWpzWkZqNkp6anAvbms2TG85TjUzOWFCamZKcWlnOXF3SVlrVXdj?=
 =?gb2312?B?YXBmQjhHek5JRm11Tno2WFF2M0tKcFF0MTBYZmpSWWJvUmJPYWlSQUpNS0pk?=
 =?gb2312?B?Nktuc0M1c2s5V3kzNFR3aDJ4dVNIRDNsMnY5VWd2NVBGVmV2VDNBbDc4b2t4?=
 =?gb2312?B?U1ZXZWRZWW51RnFVUENlSkNtaUZwaVRrZnlJMkQwYXFFRmVrbmtIcE9RNnFp?=
 =?gb2312?B?eXNZZHVhRzdFU3RjTVRKb2lxSHVEMFlCRm9PcFFHWkN6aTBlcFZETlUvazg0?=
 =?gb2312?B?TU1XSmUvNU1WK21pU0NFVlN2aUxSa2xHaDB4QjJ6UVFIenI4Zm5LSzRHRDd2?=
 =?gb2312?B?NEFldkFEUWhwL0FROFBJWjR0YlV0dU5yeVA4clRCMWVvdFRFbklzNUZvWkVi?=
 =?gb2312?B?NEdrWmhldFN4a0xGOUxvNVRCbzJmUnkzUUgxWkg1VFRLa2lQTWIvZU1CTnZ4?=
 =?gb2312?B?REJoSldMV05KODNTSU9MczJ3YUR0R2IrZllocW40MkozckJnSkhmME5WM0JD?=
 =?gb2312?Q?D7VP92eUeEvDZjm6gGaVw2Bdsux6QQll8Bl3s6q+j8=3D?=
Content-ID: <CE66929CEEFFC546B3663839013C7CA8@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3153bbc0-6080-41d2-a1a1-08d9f2844394
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 02:13:33.2586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7h+mwBfUaT+9ig5ugL//ij/C+Fblf0BGtqQH9WBnC/boRFvFF+m3qZz9KjDZXSkF0QaMvIxhwIwGyG+wbHmvKJ2J5Ij1PzQLurTue6Im6WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6862
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/5] lapi/kcmp.h: Replace GPL with
 SPDX-License-Identifier
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

Hi Petr
> Hi Xu,
>
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>> ---
>>   include/lapi/kcmp.h | 25 ++++++-------------------
>>   1 file changed, 6 insertions(+), 19 deletions(-)
>
>> diff --git a/include/lapi/kcmp.h b/include/lapi/kcmp.h
>> index 59371fc07..77086191f 100644
>> --- a/include/lapi/kcmp.h
>> +++ b/include/lapi/kcmp.h
>> @@ -1,29 +1,16 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>>    * Copyright (c) 2015 Cedric Hnyda<chnyda@suse.com>
>> - *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License as
>> - * published by the Free Software Foundation; either version 2 of
>> - * the License, or (at your option) any later version.
>> - *
>> - * This program is distributed in the hope that it would be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, write the Free Software Foundation,
>> - * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>>    */
>
>> -#ifndef KCMP_H
>> -#define KCMP_H
>> +#ifndef LAPI_KCMP_H__
>> +#define LAPI_KCMP_H__
>
>>   #include<sys/types.h>
>>   #include "config.h"
>>   #include "lapi/syscalls.h"
>
>> -#if !defined(HAVE_ENUM_KCMP_TYPE)
>> +#ifndef HAVE_ENUM_KCMP_TYPE
>
>>   enum kcmp_type {
>>   	KCMP_FILE,
>> @@ -42,7 +29,7 @@ enum kcmp_type {
>
>>   #endif
>
>> -#if !defined(HAVE_KCMP)
>> +#ifndef HAVE_KCMP
>
>>   int kcmp(int pid1, int pid2, int type, int fd1, int fd2)
> $ make check-pidfd_getfd01
> ../../../../include/lapi/kcmp.h:34:5: warning: Symbol 'kcmp' has no prototype or library ('tst_') prefix. Should it be static?
>
> Could you please mark this as static inline?
Of course, in fact, I have changed, but forgot to add it into the final 
version.
>
> Not sure if this should be with the same commit as SPDX.
IMO, I will add it into the same commit and mention that we also replace 
GPL with SPDX. Title maybe changed into "lapi/kcmp.h: Simplify code ".

Best Regards
Yang Xu
> When doing cleanup it'd be worth to fix it.
>
> Kind regards,
> Petr
>
>>   {
>> @@ -51,4 +38,4 @@ int kcmp(int pid1, int pid2, int type, int fd1, int fd2)
>
>>   #endif
>
>> -#endif /* KCMP_H */
>> +#endif /* LAPI_KCMP_H__ */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
