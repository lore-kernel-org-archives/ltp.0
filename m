Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4B8C433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 02:34:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 720053C805B
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 03:34:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCE293C1DB8
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 03:34:44 +0100 (CET)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 40496600793
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 03:34:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639103683; x=1670639683;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=W5xR4aM0cqMrYmk2hIHXfxRAvCmCLsfgpPD8+4pyIL4=;
 b=aTEd8VPar+79FF4o8jGHWGHjd7UEdPRELaegITt+VGocDI1Y34hUAaOT
 KgfxNJcbRmVlcxPXkgoDtWFkgDbyHhxKxnEDmEnW5sHSBkiwkdbPlKRhe
 4HlkeWUing9afHpsZGSchftyxMjAFL97TfBtCv1LxSTd3+SSGlhvO7HeX
 dN0XRS4mY73KeR4xZijVMy75lzyxEo/cG2lCkhnvPE7pqiVblkyL3BCtA
 9ZdWkKJmkImwBKgjHMUY60Al1L7cb4Jii3ILL21H9PrDsws/z3q4nsiZq
 8PFI2qg5sUtK842MIiM58pFoKsAcbxPSdqjkCyaQs+R0uL7iYom1VDg0K Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="45644511"
X-IronPort-AV: E=Sophos;i="5.88,194,1635174000"; d="scan'208";a="45644511"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2021 11:34:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1GidyxWspt0Pn9VGEcJogt+APz6xASGQvP/vjhW4r3Mv4lBI5N9zRn1Nw7XGa7WAowjvNLCa5MZEj8jOXeFD/R4I/r6lp59blTprzRiYFx63aAL0qyzCrrZHL/AOfvWBxSbfBxiHBQg/z4w34o98YMKcJdqbK31dXb0qnxs80Am8UJ7rb/A0pufFT3VhZhJx3sFuUbCBftPboJz/Ts1BIqL0TxoADsXVGVwHUWeTuNNqR+OgTqrjGCNSPp8ra01gCfuCkwH4JKaymVpvaz0jA+KgnaA4/i+a7UEWHmJJGSZquGGeikn5gYXtbFSwfgLfsuyzj0i1+eUp+N2ixcmpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5xR4aM0cqMrYmk2hIHXfxRAvCmCLsfgpPD8+4pyIL4=;
 b=ITaXprOzXQi5symeKAAoikVbL+TNfVa2TrkLXRwzki32kXpYxuMPRrAYWXUmI+B/TCCCEpPApSusvnWxqH8h8SRSx/7bWrBBwTdqAnNb5Wb59ikYLgJf/NZelgEFUMB7814LUHosVLNnP99KoGC6NIVutFbayvZjH+nS+CHbkqVeLDezJNyuUwp0JPdrK9aneJFl3RFugtEqqCHca5jSJp8EU3lpg1lLBCAh8wtY+OtzLWxjKkBwG91i6E1Pwjk1M4+hOdc0VJE3apztV+wIVgq3An5QZk8G04vSQ/QHUoX2BV9YmgT2ydKWVDuJrM4BNpZxhQtvKhTz69+fhYxmAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5xR4aM0cqMrYmk2hIHXfxRAvCmCLsfgpPD8+4pyIL4=;
 b=qXaEs0m7QCupwsJVuDVNXaePPuCufQ9XbWh34Zx2+Ch+YjElaAbFqWc/54VKy4GqxpG5Slnh65ro/yTPetKVLh1iMjoP4q/VJ6tX6Dz5jNeuS3AvboYKPTXXICCFp7mexJjSCJ7LFjPAqvPfGKVallkOi+SeRZgCgcJhmwTlMDA=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB4201.jpnprd01.prod.outlook.com (2603:1096:404:d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 02:34:37 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4778.014; Fri, 10 Dec 2021
 02:34:37 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v3 1/2] library: add cmd check handler in needs_cmds
Thread-Index: AQHX7KvHFutWC/U9o0y3nSSX3I9hW6wqoakAgABiIYA=
Date: Fri, 10 Dec 2021 02:34:37 +0000
Message-ID: <61B2BCE5.1080409@fujitsu.com>
References: <YbDl7YtVZvYXPxwp@pevik>
 <1639020068-2198-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbJqlKzTZS99xk48@pevik>
In-Reply-To: <YbJqlKzTZS99xk48@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1237225e-bc77-4057-635c-08d9bb859c3e
x-ms-traffictypediagnostic: TY2PR01MB4201:EE_
x-microsoft-antispam-prvs: <TY2PR01MB4201E16C5DF47C7E8F927AA2FD719@TY2PR01MB4201.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2TovQc7BaAQtbDm9CeezlO/tbpeUY2l5NXqR6VsVwWhRC3hJfUEfgMcAgcVIN3zavqID0fErFAw9tvuK72cHVx3+5zcq4VApTN3UvuJK5ZZf9iXd6orspJu288ij+T06bKIg9W3obLhhMQNkeX+zO9j+3+S9SGcsN7VMMXbTBMuBdrEBQwgKcKRt04OmDO9+vqisPy8SKF5VUD7sALdQVacoc0iW1FXNSOFo/PbtZnDOX8qUZsf6foFSb1WpdeAhn7u6c7TqrqLN8MZEF6dAe4wRXApqEmnUOIjSfJowMgJ3X5oo1ntr7UUjW7UGqgB7YcXDmDC+uzd9lQ0Jsz4KJPy9Hdtyn+uSYrmXyZ0JDLtk02evBZ6q6WQwoJEXpbxF8HjM9RnZqeEx1VC3s96ievKP9SXI3QyRpgptosqP4ZM9lz81xN2r3tkwtNQeT0hPGqcTjnsfDYIADbeom7bLAeuMwG7kjp7+VwdH7tv8R7eieMxMwPDvKJU9iDpC3yEiFcXsG3nSBWunYSIfGZs2uL9+KpIy61Uqliy+UcFdTBTdzzwMGVgBP//GC5FRijOtydFWTIcsEGMTMVUnZJT2PDDOGH9+Vs3VsnLDCHhKi7ClEgckCQEUOWGys/tJL3EiNkAfcXC1dX8bE+Dc/aBDyF6yZFH5fUM9fEpH5mHmqnQz2gdlEm95XSjVDj8hFIswZUFIiwBciizx1k/p5oZsDw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(6486002)(4326008)(8936002)(508600001)(2906002)(66556008)(66446008)(38100700002)(66476007)(8676002)(4744005)(6506007)(122000001)(71200400001)(87266011)(316002)(6916009)(66946007)(186003)(2616005)(26005)(5660300002)(85182001)(86362001)(38070700005)(76116006)(82960400001)(36756003)(91956017)(54906003)(33656002)(6512007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VXlJTDRWQTBncWRNa0twVGY3c0d3UG9Zay9kYXphVktQS1Q3N2oxSDM2cHd5?=
 =?gb2312?B?Z2Jpd21OYlRxamxvOGxhK3I3U1pwUHpsdDVGNzJqdEZEOWZJSUFmaGo4d0Rr?=
 =?gb2312?B?NFViWjFoZDBvU1g0czJhVnRoV0pjajJyYzRldUdYcUNjTnQyWVdvRTEvL0FI?=
 =?gb2312?B?ZGcwaklBalB1YlZmRGlKTFZuSUovSVc4ZCtzZXVOT0YrQS9PQzd2Qmp5YVVi?=
 =?gb2312?B?bHZSTVpxTnVVQ2NXTFZOL2dQNDA5R21keVFvRmlaR1dKSWJLMDAvL1B0dmFT?=
 =?gb2312?B?anFzQ1hzS3c0cTZsWjk0QTlocERNQmRQZ09tVllQSEFTTjlwVGVlRGJGR3Nq?=
 =?gb2312?B?TDBPNVRHZWswaDZINUdKU24yN08vUDEyWENpODAxak9meEtnUlhHdWhXRXND?=
 =?gb2312?B?bkRsQnV1ZWJlbG1TRitJWU5NYU5rRUFZRnhOaTdxc0FBQWExaU0rOU9NdGJN?=
 =?gb2312?B?Z2lialNYU3RoY3JYZGw5NjFQTUZVN29wYXZnOVJEUUhzczY3RHcxSnhVZjJF?=
 =?gb2312?B?UHM5MkxlRWM5aE1URU9MdHhFSEtPVDdNZ1ovMTh1ZVVKS1lHUUo5Z0t2V1hK?=
 =?gb2312?B?azFUUUFkRkNnWUV4RkkrMnRURGpnZVB2eW11VEpqMnA4R3pRZmIxcHE2Mmlt?=
 =?gb2312?B?SFhGVzV1Q0RjelJqRWduMFREWFQ3T0UzbGQxd3FBbmlOSVdibER6cXd0YkdQ?=
 =?gb2312?B?cjI1blN6SzdpSk1oUUFXWThYdm5aREFUQU1qVXIramh0TjRTMExFOFZ0dHRD?=
 =?gb2312?B?UTFRdEliOEZ1UjY2MXpmZGdneUZkTyt1aVJvQktWQ3N2UHc3RWtTK1lMYVJK?=
 =?gb2312?B?QjNzN3cxQzNzbDVMRmZJQ0JwNm04Qmp1SEZFa1RQMHFmSGxueHY5bU40TWgv?=
 =?gb2312?B?SUdyeERGcVRwc2E2Q3RBa0IyNkZ5SGFuQjFtdGhnMFZiOGMvb0F6N0U1WWtp?=
 =?gb2312?B?S2QydFQ3YzFMM1k4aUcwVUJXKzNoL3A3cm8wSExoTHJsVERsaldJbDc3bm9E?=
 =?gb2312?B?OG1MMUYvSmZzOHYyaVo1WW1BclU0R1NOQlM4Y01pMFROblhEdDdKMHdBTksy?=
 =?gb2312?B?cDJJV1JUbzJGa3ZWdVNSMVR6WU54Yy8zNnhtTWRjNysvN28ycUFTa2Jqb0tF?=
 =?gb2312?B?ZHdFNERsWTc3NnZicFFTVytscnRjeHhOWjJtMW9aOUxFTEE0TTlFSUF6ZUZI?=
 =?gb2312?B?QVBuV3NBMTNVTDRBTllFZVFnektZMk05RnU0N052dnU2VWpnaE45RmxaZHRG?=
 =?gb2312?B?Q2ZGbFlFaXZmbU0rYWRLZzlkSEloajcwdWFrRngyZitVSXN4OGUwQ3FIbDhn?=
 =?gb2312?B?ZjlSVDVQeFRsYzZpbFMxaHZRd01oRG83SzVjd056Y25tUDZrUEtYaDl5MUVN?=
 =?gb2312?B?TzltUzJKMGdTU1hvOWRBNlFTSDhrck9NRWVxMm05YUpFQ0FqdUwwUG1vKzFC?=
 =?gb2312?B?djVMOVpYWW83VVdZMHY2d3FoajlEL3VibVUrMlZUVE81TGJFZG9jMjVVT3Vk?=
 =?gb2312?B?Wm1VaDJ3cHV3bjBxU0srcFVjckVSYVdHOG8xR3dscTNnZHR2anV5dnkyOWxs?=
 =?gb2312?B?OVZoTHkxcGxUTnU0cUlXLzlUWDR5dHpkaGpaT0djM1VJcWRlQzNxK0dwSGFP?=
 =?gb2312?B?ay9CWVBiQkIrZ2FxOXJLdWRYbEdDUUhKekM5U2Voa0dZaGhRcEl4dktIdXFX?=
 =?gb2312?B?dG1uZzhnSjM0b294S1lCMXdnZE1EU3ppbkJTMitGUzJaN0RRVGJXRjhEZjNM?=
 =?gb2312?B?RTQxcldFbUZXeXBDN2F4UUdKT0pzS1F4S0R1NUh3N2doUmdSZ0xFbHExR2xB?=
 =?gb2312?B?U25zUlMyb3k5ZTREcDJnSktDRmFwcWVnWjRmSHBtdzhmSVpYc1JyRHNRU2FB?=
 =?gb2312?B?aFZ0dTNFV2ZtMzg2MWVETVFrWjh4N2gvKzZnZHRwT2FYK1pRaitQRklDbkZ5?=
 =?gb2312?B?d1JjWjM2ZnFUNlc1VitPeDZKZzZGaW5TVVgzenpRbCtIc0RJSHZXcW1nRWFw?=
 =?gb2312?B?dysxK204bDhkdTh3MjZYbFY2VUlLekEwbEVUYUw3bUVBL3BjQTB5eWVwUDlu?=
 =?gb2312?B?eElDVjNkQ09ZNm04RHdoaVpHTnAybEFodDVLOXl4bEdEU2tBeHY4WkM4M2kv?=
 =?gb2312?B?dUVBS0E4bkRrd0hMbHdFaHVQU3YzWEpJWDhjbEhOdnhQNDEybm1YT3hoL2Ew?=
 =?gb2312?B?WFZrdVdSQUJYaXBBemUxMHB1SjQ4U1hoc3krQmxDVHdLd1FnU3h6dk40SWtI?=
 =?gb2312?Q?3jpNvGa5RJiyVWKzMVd2Ur7sCODdQ11RZmboqLKe5U=3D?=
Content-ID: <12D454520A1B8D41813D470FDFA3B594@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1237225e-bc77-4057-635c-08d9bb859c3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 02:34:37.5258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hArlMDCho7v7wP5EJJ3Wq0aoKOilDhHPhY4m9xMlqTWZG9HCFVYRPdFdaek2yvzulWmBiXP8QLR7LKIMVZnbuJi2+xEf2G5zbFISlxYotII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4201
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] library: add cmd check handler in
 needs_cmds
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
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>
> Very nice code, nice tests, thanks!
>
>> diff --git a/lib/newlib_tests/test_needs_cmds01.c b/lib/newlib_tests/test_needs_cmds01.c
>> new file mode 100644
>> index 000000000..92305ee97
>> --- /dev/null
>> +++ b/lib/newlib_tests/test_needs_cmds01.c
>> @@ -0,0 +1,25 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2021 Yang Xu<xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +#include<stdio.h>
> All<stdio.h>  in the tests aren't needed, please remove it before merge.
I remove stdio.h for these lib test cases and add stdio.h in tst_cmd.c 
since there used popen() function.
>
> nit: I'd also call tests tst_needs_cmds*.c (tst_ prefix instead of test_) as
> most of the tests in the library takes this scheme, but that's very minor.
I have renamed to tst_needs_cmds*.c and merged.

Best Regards
Yang Xu
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
