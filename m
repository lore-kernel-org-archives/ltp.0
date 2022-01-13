Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3194FC433EF
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 09:16:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E4BA3C9508
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 10:16:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EC2E3C1810
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 10:16:03 +0100 (CET)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3DAEF600A1C
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 10:16:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1642065362; x=1673601362;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=wd4IQiQzpKFHs2Cb5V2VL+bT4dAFN+oBbA2gyK2zZiY=;
 b=Z+407he5v1OMvO9WaDxu2713MklHt+whp4xQo4WM8N2KN0H4m9dVpZfI
 b8qxkJsxwuFk6ElB2yYIU1L7G51KZXFEF1xWlhEyGHPmfHYD0nf9sbBex
 VOVDI0kNHPhixnL7dwpPemKOquQz+aQDUIccq8ifc8MCX1EO62Y9g2L+B
 zgGEBTzYDOVpnVDa6iC8h2g6HPkzPYdnNuN/MiEOIt9w5TuOzVPrvJd8z
 sLjgRVD/NzfNjpSgT3JObUO+NParRF+opqJWDr3/5hdLTkV8bKX/6LqTR
 /uuiNfi8PmKXqZTRaiQRFfy2Vx+KD0ZQYPMUzAnsChhnUqy4EkX3L7Mcj A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="47855008"
X-IronPort-AV: E=Sophos;i="5.88,284,1635174000"; d="scan'208";a="47855008"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2022 18:15:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eh99uYM/zRdOynfJszKw0mO7vRHOz1+QO9bDbupaWfBtDv9bkh+7cvB8Hrp2p5Np6XrX7s0EK2QF+tJ30FnPLtyP9aXIrup4UzMJ1gud01NgkdFdsw3yjgJb8UaQbHEkvYwdK9ddYzTwVQ/FuCR1Vyph1wU/ZNn2QmjikY0p8zN+aJ9javUiCBoRx0kJ+0lAC+NBhUwj6SJdy3nThdA2vmhInQ+QRoaW+wnep/Qz3r8jIEDNe0nOkC3weqkPYU4PoVhTwVmg6UoV252+3kiTXgyOQ3cSQB/ovHvEQemV/Xlt8AT8dMzKN7/7pOgBaZdaqFDnZU/12j0Eu2euDCvstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wd4IQiQzpKFHs2Cb5V2VL+bT4dAFN+oBbA2gyK2zZiY=;
 b=RUDD9NJFgNq4Q4CjtfclrTEhE1j1Mj1/2pix7z9b2+T/m5K0OHX4awPZhAIH9+m2ndj7M4i4eBMIeLypvFwvre4RARAxrmunSYzLMRIIt2oFJqGm9TSFy9T3l+7f6OrAUoSm2spp9reC3VI2eAvfGdQSlaaIJm+flAlnXSe/0okmSJ+WOn1M73PFuNUnAdDG+OnkElGrwrjTMalmxDZVxhLx8NZd+bb6Nlt48Rk7AlGpdcM8FVuJahidFJZQDpY9ZYiSKrqtCb+KunAnRo3at4Zuf8wZukJeAWE5oR2jQxuJsXkmURLXzWbmU7TZew6vSz26wckjFWrm1FWlAgAA7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wd4IQiQzpKFHs2Cb5V2VL+bT4dAFN+oBbA2gyK2zZiY=;
 b=RiNoJD7PqBxMBQE/Yr9KPhA/Iwe5Y94I6r+ObquwV+2On9uAyJCswGq7Oe9DaWRaRDBPzDYfMhP2e2Upd2SQs04hWhZTaDXSLpvbRQdsU2C0lBzRf5hvA5y/KgaQdNJwbCvOZgHITUXp7k6HdKPWmeKm9HsTd39IHNOUrhzVBtk=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB4334.jpnprd01.prod.outlook.com (2603:1096:404:11f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 09:15:57 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%4]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 09:15:57 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>, Petr Vorel
 <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v4 3/5] shell: add kconfig parse api
Thread-Index: AQHYBrHpl9iAQbrPq0SVOQssuxdnMqxdcxkAgAAMzYCAAy9NAA==
Date: Thu, 13 Jan 2022 09:15:57 +0000
Message-ID: <61DFEE02.5020204@fujitsu.com>
References: <Ydw4BXF2ramqahuh@yuki>
 <1641881435-2351-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641881435-2351-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAEemH2eZJ7U1+Bdsb5xCB6-KYa1mQQ=GriaDtyFSJ_6zprT7yw@mail.gmail.com>
 <61DD4215.2050104@fujitsu.com>
In-Reply-To: <61DD4215.2050104@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3953bd46-8439-4d11-2400-08d9d6754ed1
x-ms-traffictypediagnostic: TYAPR01MB4334:EE_
x-microsoft-antispam-prvs: <TYAPR01MB4334863BB6128B29A604668AFD539@TYAPR01MB4334.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ntkpM4Ko0efUbxtiAt9jJCBpm0Ur09Uf/XGHiQx04TrrzfIxuOOT4aWXPy0nqRYniviyGomCSxPAKuedCNcuZsIzbsMe/trnmtdarKqdaoWTT13ULQo9Pk8tHl1alWVxNfKC6CE7SxhQzgZFvSABy4bI+dMsRPwD/DzpeJl+A85IvY8pyRjpW/8iUJwlvLzL2HoLLT8TW+cFYfRC/Y3M/UuJp00jEegAHtrau06gJUdb0CldsUKH5q86Y40c1+vqob6h0W/TFfIHculq6cg4rkombug1hqbwxwUm/s8HvMWIK/dIXmTRqtfZv26ZvKHNTWwJ9za0ysQ4JiwMBEwOy1MkT3f9F++0kstCGWtGv+U6ronYC/5UQZ9BlvJSNi/YuN8beB59joTo7rvZp4kzg9/xf+0H8W4xg4o/7PO31wq/W605ClrT4AvJvCXA+k2MBhcawXkYBgO/9SPw8j5rGGf/vvwJ4jKAP43CskXw1SX/Uiy9+NBx/EIoRlMEVL9hxgfMNJfBo4WNIb8nVtV5VD4jJKsjHW0AWY6vX61dwNbDJP2va85mQQDy4CKUg0mXRzZjTljfnjv+ddTS+/n9mb97gAM2yCOrS7IXhU7eAooZp7yvPzD4cDeN+AMRPDdc4vsvrsCZ2EYaz4n0SYTfARGyqDL9P7CUk1+kw7J1HLNMjFIwLSIFO6SLPpFDsQiacAi6Yhef61Rl0U5H7l/8Cw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(66476007)(66556008)(33656002)(8936002)(86362001)(53546011)(5660300002)(4326008)(316002)(38100700002)(110136005)(2906002)(64756008)(66446008)(6512007)(91956017)(76116006)(66946007)(8676002)(85182001)(82960400001)(122000001)(38070700005)(508600001)(186003)(36756003)(26005)(6486002)(71200400001)(2616005)(87266011)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Q2lIeW9BVElTMEFWUXkwdUx0YzRBTlVnZ0MwdkxMb1h5dCtnRUs3cUdxOHdj?=
 =?gb2312?B?K1pPcVRkd0ttY1Z2U2ZKR3N5NGN5Qy9VeGNuOUl0TkhJTXZCQlgvaHRURm93?=
 =?gb2312?B?WElKdTFOOTQzbk1IOS85YVBMbi9PcmJocGtTY2FscjFSRHk0WU12aTBDZjU2?=
 =?gb2312?B?LzdkRksyYmluMXpRZUNrN3VaZWJhZ0k5bGV2L3ZNS0FFM3NtWjNiRkpocDNO?=
 =?gb2312?B?Y3VKUmRRdnNDNU1DS1N1eUVGdS9OYWUwTWt5ekEzMEIvRWZXeERudW5tKzR3?=
 =?gb2312?B?MEZlcVA4d0xzcnAvbGpJRUEvVmhFeko3US8xcUdNajZxdmZyRE96azdPdzFG?=
 =?gb2312?B?MVd6ZlVDZURzMTFIc0tKekd1c3BDSzF0aGgxVVVCUFFkek1uRDdFblYyME5x?=
 =?gb2312?B?Nks5RTZDcFd6ZGNxTU55OTNwYWhvMGNUWkVnVThTSFk4ZjAySHhQSmdJency?=
 =?gb2312?B?VDRwZjNJQXJEejlsUXE4UDFEVklWVTJYZEp1MGI1ZjRKUkliM0RkTGE0WGxs?=
 =?gb2312?B?YTVpcEZWOFJ4QTk4WEtLdnVNdUQ1OTNZbTFYRFBRcVNIRWxXZkI2Wk04YzFn?=
 =?gb2312?B?NWJhTHU1R0pIaExoVVBpS1h3ZTNOMlBvUmhOTVN4Qy9uY1huUW9xM04zZDhs?=
 =?gb2312?B?UWhsTUptMVlOcmJ5YlBTY2xieHBOZW95Q3RBU09tWVYxL2o3Q0JxR2VtOFpk?=
 =?gb2312?B?UC9kb0g0T2J1U2hSei9EdWtOeE9XWitBdEpEVFMzVGF3UTJTMktYTFAyYTY4?=
 =?gb2312?B?WjlxY3ZVNEtnSGNjS2VWR3pzUjFiK3I0Rmg4WFkrcUk4K0hhQy96NHhVbDJZ?=
 =?gb2312?B?SndoVFNnc3duZzFTS0MrWVhJblErU3A4NDgvMExNZ1Q5TjdpbWVtc2krUFpZ?=
 =?gb2312?B?RnVaVmdiYnBJRjVVUGY4TlJNTDdndW0wenM2MVhDNFRSQVROZHhNZVlVNnpz?=
 =?gb2312?B?ZjB5cjZvNjVLZXBMSWlMcU95bUk2RDNxQW02bjBHbDhWejVqdnFseFNhOFVQ?=
 =?gb2312?B?ZGJyRGNCVElyVllZelM3N1cyQU5KcG5keHRQOUhTRkNDRU5nWDBwdFlZTCtk?=
 =?gb2312?B?SVdHblRPL01lTTBSblRlQlJONUdZMmxCUnJoUGdvOVJROXNCb1VjakJIOFEy?=
 =?gb2312?B?clAwUXZpWlJkd3dISmlyZHpqV2RDRGtoUXY4NWx5WFE4YWdEL3cvK1N2MXdt?=
 =?gb2312?B?dFlxS1FqTGE0Wlc0SEJHcjI5KzduczNaUmNRUi8rcU5KbTlvVDQvbkgwMFVj?=
 =?gb2312?B?QlFtRkQzZE5tck5OZ3htdEhvZE1Nem1DMlZTenNXT29FVUkwV3VsVm90dzc4?=
 =?gb2312?B?RUNsTGwxMm41ekprNVVDRU95a3JrUjRpSSsvOE81TGh2UXA2dFFPWXYzR2du?=
 =?gb2312?B?eTg4dDRVbG9hd0ViKzBMMTZZYUVyY2hPVmRBdEg3RHlOYnBKT0phTFdzTHU4?=
 =?gb2312?B?R2ZQWExHN0F2V0s5UjltSzkrdHcrOG41bFFoRW1McHJ4ZmR5NjlLcU5Hb09w?=
 =?gb2312?B?YzZUMHQyZjNOYm5RNHV2aVAwMHpzYkZxejNTeStaWjVlakJIdVo3cWk1UytX?=
 =?gb2312?B?VGRKemJtLzdYQ0tGdi9MTmYydnJRRGtGRUh3aFUyWm94TStUaXlvMlFUSU9z?=
 =?gb2312?B?Z2VRZEV3cE55cFpCcGxuUE9oRCtwSlk0MVZoeUVMMWZBMm5aQUJuT3JDRUNp?=
 =?gb2312?B?OFRpWkVXOTJ1LzlXZjZFbk5weDZlQzUyYURQZzVFRFJ4Ri91Qis0ZjY2eVhl?=
 =?gb2312?B?cFYwRDBmSFBHVC9GRHdMam5makc0ZkRNRmd4ZzVGWm0vTlA3Mm5xa3RXK3lH?=
 =?gb2312?B?U3k4bnZYam5FdlRMbUdNNWI0aDJKVXBnRHVBNFFNclJkZ0ViMHJjSUJDaGVZ?=
 =?gb2312?B?cTgxZjJhWGxUT3dVeGNBSndJSXczWWRMdHNVY1kxRk5UbDNaYXpXdXNIbXA4?=
 =?gb2312?B?U1hzTFRFQ0RwMWVHelVzY3JlRkJ0aUdvOHFKNGNkS3lGbGZtYURqRFRlb0xz?=
 =?gb2312?B?SWNlN1BpUzl2cmZVZlh3N3EwTFdaN1JmTE1Wb3hXL0RnVG5vaW1rT3kraTN1?=
 =?gb2312?B?VTJ0MG9XQ25CTFoyM3NHem1jMmdZUGxDSnAvaHlNdXpxMDBQemxLZGNGVG4r?=
 =?gb2312?B?NUFGSktWMG5nelcxczR0OWgvYzZVVlFURk5QbCtEM3ZnblVrQ2ROUU5jbnJ4?=
 =?gb2312?B?dFc5eXlJRWdIeGVtd1Nld21mS0FnbXlKdFEvdjhXVU1rdlpIdDNtQ2xneHho?=
 =?gb2312?Q?PUGccbgnko0KNw7zvpAV7+Bm4BwzmEDMwm7B2XLu1E=3D?=
Content-ID: <5F9F3D5386D4E848B44FD8E7EC5F30DE@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3953bd46-8439-4d11-2400-08d9d6754ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 09:15:57.1170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2xJY4yPANxA24DQi4IFyX8BVeiuyFx0Vuw/9lv80hcLMV8VeUGOJij17CP/iU3VNRga2z8pdmQtolYvPVi0yF7kOjGnHXkFuTdNR5IKYEDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4334
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

Hi Li, Cyril, Petr

Any comment for this patchset?

Best Regards
Yang Xu
> Hi Li
>> On Tue, Jan 11, 2022 at 2:10 PM Yang Xu<xuyang2018.jy@fujitsu.com>   wrote:
>>
>>> +++ b/testcases/lib/tst_check_kconfigs.c
>>> @@ -0,0 +1,46 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/* Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.*/
>>> +
>>> +#include<stdio.h>
>>> +#include<string.h>
>>> +#include<stdlib.h>
>>> +#include "tst_kconfig.h"
>>> +
>>> +int main(int argc, char *argv[])
>>> +{
>>> +       char *str = argv[1];
>>> +       char *delim = argv[2];
>>> +       unsigned int i, cnt = 1;
>>> +       int ret = 0;
>>> +
>>> +       if (argc == 2 || strlen(delim) == 0) {
>>
>> I doubt that this syntax really works here.
>>
>> How can we get the strlen(delim) equal to 0? if the argc is
>> not 2, why the length of delimi is zero? but if we change ||
>> to&&, then get a segment fault. I don't understand this.
>
> Sorry, this is ugly code. please see the lastest code.
>>
>>> +               delim = ",";
>>> +       } else if (argc == 3) {
>>> +               if (strlen(delim)>   1) {
>>> +                       fprintf(stderr, "The delim must be a single character\n");
>>> +                       return 1;
>>> +               }
>>> +       } else {
>>> +               fprintf(stderr, "Please provide kernel kconfig list and delim "
>>> +                               "(optinal, default value is ',')\n");
>>> +               return 1;
>>> +       }
>>> +
>>> +       for (i = 0; str[i]; i++) {
>>> +               if (str[i] == delim[0])
>>> +                       cnt++;
>>> +       }
>>> +
>>> +       char **kconfigs = malloc(++i * sizeof(char *));
>>
>> Shouldn't this be malloc(++cnt * sizeof(char*)) ?
> Oh, yes. Sorry for this typo.
>>
>>> +
>>> +       for (i = j0; i<   cnt; i++)
>>> +               kconfigs[i] = strtok_r(str, delim,&str);
>>> +
>>> +       kconfigs[i] = NULL;
> This is also useless.
>
> The lastest code should be as below:
>
> int main(int argc, char *argv[])
> {
>           char *str = argv[1];
>           char *delim = argv[2];
>           unsigned int i, cnt = 1;
>           int ret = 0;
>
>           if (argc == 2) {
>                   delim = ",";
>           } else if (argc == 3) {
>                   if (strlen(delim)>  1) {
>                           fprintf(stderr, "The delim must be a single
> character\n");
>                           return 1;
>                   }
>           } else {
>                   fprintf(stderr, "Please provide kernel kconfig list and
> delim "
>                                   "(optinal, default value is ',')\n");
>                   return 1;
>           }
>
>           for (i = 0; str[i]; i++) {
>                   if (str[i] == delim[0])
>                           cnt++;
>           }
>
>           char **kconfigs = malloc(++cnt * sizeof(char *));
>
>           for (i = 0; i<  cnt; i++)
>                   kconfigs[i] = strtok_r(str, delim,&str);
>
>           if (tst_kconfig_check((const char * const*)kconfigs))
>                   ret = 1;
>
>           free(kconfigs);
>           return ret;
> }
>
>
> Best Regards
> Yang Xu
>>> +
>>> +       if (tst_kconfig_check((const char * const*)kconfigs))
>>> +               ret = 1;
>>> +
>>> +       free(kconfigs);
>>> +       return ret;
>>> +}
>>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
