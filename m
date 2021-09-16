Return-Path: <SRS0=QfDu=OG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0220C433F5
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 08:24:01 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3B460F93
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 08:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9C3B460F93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFA423C8977
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 10:23:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D8CC3C19F3
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 10:23:48 +0200 (CEST)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C76E81A016C4
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 10:23:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1631780626; x=1663316626;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9jSKjVy4Vfewoe3RPXKEM1vYwLIX2Qg9z3sTNz+Shwk=;
 b=INZ0mnnqXx4Ff6GqXPSXEqsyHg3+3vbPv3sLf49sRI/lJGp3kPg3LHh6
 6I5FFld49XTk79GUyyO07NSFweqTJIh7k3nhkcfDxG8ushWD5HWTiLE1P
 mxUbJSwW0xh3DwOX8p6B7WEQpyfMS/aBTgd20KFh2tauHW0LPrdrh+tml
 uJv0cLopWen8kaEoT5iCZjo3dGfJgapszheJ6PyUpVqBm492M7jjz3dc/
 IVmwpOB2qTI64lXQm3jxReDJOieLk+tRr35v1nI3Joy2DDY2RwL//OLh/
 wSpXnPxG+1XaqZ28Uso/DWU0F0hOswl7tNR+TlB5C9SIAGZTm1Ah5eA9s Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="39504643"
X-IronPort-AV: E=Sophos;i="5.85,297,1624287600"; d="scan'208";a="39504643"
Received: from mail-ty1jpn01lp2056.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.56])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2021 17:23:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRX08XZ/gw6a2Qm6T85zOfm0ooVv6Lg/4iEd55tB7vsbGgbdmSlRU1JtHPULJR+fYwwpB56ZtyvMKCvMkxjD6aVDcWXxA2YxJSAJERgNb83bdwts+V6RdodWzAX/jHG4PgZvRuS+mjhQhVABD525lF43zstuEbMqJXoCELchA4ZbYGFzyQ8tNKN13+xVB840m2v0Bwy13WwXFTzit1Dlc4Mh819vNNHNqUVKqdEiDmWh33AZTic2GYTe5iIJBcOwsYqyb2zcX933trcm3QzfDfID4Ga47T6utpJDLMyW2/RjRBXwRdifCFPJb5Ps/Fz40Zuwc2DlsLmTDeDV5HleHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=9jSKjVy4Vfewoe3RPXKEM1vYwLIX2Qg9z3sTNz+Shwk=;
 b=nO8HiASBZIuyd2qfbCkWWezMZWvwqn43T4h1yEolvFwl2jbAOUScNG2drFQLXJQ0/mvIqioDXXPLEnPgBJvfDTtrf6K7WEZWsnPVWOBpIdXAV8sEVr/iUsU/v+HYxZ7KzMQEGjvxPzS/HOb9qySBGCx8kcAwoLVxFdzcRtDqyBApJFpwP1jnjft7QMKiRhx3K0da1fDWaCdXaaAs+i3EqS4soGtpZhJzh4VxqzUx4ee7JtKfnOiL2v/AGwRfWEZwInqqQF6VDPycwwUJQipPkgQKpQXGrtApv9PQrwt6hmNzlo88Ch7GS8fwOov3cPCCwrbK6kUDOamRyNJTfobigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jSKjVy4Vfewoe3RPXKEM1vYwLIX2Qg9z3sTNz+Shwk=;
 b=EDqfMHAcUbaWqkZjKTHCbz6ZLVE7dKsgPWPChvM1Bpafh4B/chyxNNYfQ9aD+TDJ1w1QzIaWQ9GX/k4qSjtu1h+qwaKTxx9YtgtsRCoqY3FgxZk6EtOx0ma0SC+7g/2yoFSWBUdXoRQ4+H1859kbezylpNN0YE+URn2nnjso/zU=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB5818.jpnprd01.prod.outlook.com (2603:1096:404:8059::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 08:23:41 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791%7]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 08:23:41 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: QI Fuli <fukuri.sai@gmail.com>
Thread-Topic: [LTP] [PATCH v2 3/4] syscalls/dup2/dup203: Convert to new API
Thread-Index: AQHXqknAHktHkPNaakWADC5btZ+GVKumU8sA
Date: Thu, 16 Sep 2021 08:23:41 +0000
Message-ID: <6142FF1A.7060908@fujitsu.com>
References: <20210915155152.8515-1-qi.fuli@fujitsu.com>
 <20210915155152.8515-4-qi.fuli@fujitsu.com>
In-Reply-To: <20210915155152.8515-4-qi.fuli@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb735000-91ae-442e-c1ec-08d978eb4ac4
x-ms-traffictypediagnostic: TYAPR01MB5818:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB581831FB0CB1473BF2B2022EFDDC9@TYAPR01MB5818.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cx/EsIosWK1+S++tA810knbT0wXqQMLpdBUHeni9d1S2TjsJZ8KCay2MvKF7PTeE2H3BUtLijC/F6RuxHyp9GOqmJ9wc36xCFyATos/wWslC9Vaj4S0XsWo2JLI1550augOnnFCm+B8cRmjPVXyK6KU9Hm2dYNGGnJgpPmqH/o31oH1X93vucUDhH/6LwpfmduyFzn6JL+eOwRLDqIKS7RFJUtToniCSyaj73vjm5NhKj+4DSZ7TZnhAR19bY165cXOdHkIg30YfPu+954agQO1dUAcqrfILmVHIMe6hIQ9XLJkV2t9ZTkyAEr1cK/Lqg90+M+dDa21qXmD0GY+zSNEL43Kec/vcI3xWlDGrW8mSr4AZ7oJ93C7+rGI7uQ4vwbwfTAK8JGkc9PbvBmhjj9FMhXfocv6w//bCQBs2V2NnDkh5ff8cWoVLiqc1RxrniRnRB9m/29mHBwAA9WGChOER9mn+tzz21b+YjJjqGolWzod8Kn7hc1Qk0lPv/qNQYY0AqEANnM5ZlzSqDCkfzQZ691FMo9cosltosxI+Bs5orgqFJLm4MkMdiwEcPQn77atoaQdCNyTsGa/4EZMlDxFcOfZJUXClnYSS47SgxgSIajri8qZEOiv5CShcYhngnjWlrBE4c2nLEb7Ay8IilgjgxTF2jhlTgiEEIv4rqcpTvX3wpN1+UglZFvyrTSgnkb51LAS0Uq8gc1IAh6ppueZTYvUBHJstsSZVCPwG4z8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(54906003)(5660300002)(38070700005)(508600001)(76116006)(91956017)(316002)(122000001)(186003)(4326008)(8676002)(38100700002)(6486002)(86362001)(36756003)(85182001)(2616005)(30864003)(6512007)(33656002)(107886003)(66556008)(6506007)(71200400001)(64756008)(2906002)(66446008)(66946007)(6916009)(87266011)(66476007)(83380400001)(26005)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?T1NwdEJ1RVpXenplVy9WZm8veTRSRVFuZ0I2d1lOOVk1cGVMSWdObXJXRGM5?=
 =?gb2312?B?Wi9nTTNERG51UVZVRWs4eVhhZmVrS0dDM2dvZkpVOGxNd21lTDdCN3gwQVhW?=
 =?gb2312?B?RjdCaUF5SElnYTh3cWh2bVZqSzhBcG9IZGhmekJZY0w2dm9CWGVLbXlkdi93?=
 =?gb2312?B?Tm52YkJ0ZlJTRGZSYWdhRjRSOWtZbXhtS0RKRXlhbXUwd3gwNXJJZEJVbmhZ?=
 =?gb2312?B?T3JoSVY4eHZKbXQ4WUFvN1hSRUZQMjhxNlhXZHE2dTUxK2FTTU9nSFlmVmhq?=
 =?gb2312?B?WjNnV1VJN3lCUnFkSlkyamJzdjV1QTRKQ1kvTEtJN1F1WkhlK2RvcWY2NDdX?=
 =?gb2312?B?Qks1SldDRHhUMkFNYWp5K1lVVEVHWStXc1VzM3ZyajVsKzJ0cUFRU1poWXhL?=
 =?gb2312?B?UTlqbW83NTJNNlJPMUlxcmpqT2xoWVNhQjh2ZjdId0xyWmFKVXpLRWZWVTJL?=
 =?gb2312?B?NHlQM2dybmorVkdTanVqcDFOMEwxSWRJbkkzdWc3M3lRRXI5TnVwbW1WL1Jp?=
 =?gb2312?B?Mk04MW95ZFBqVC9yVE9FNEtWNjh6bG85V0ZEcHNQdlFWVzJ0TDJSaEZXY295?=
 =?gb2312?B?VWJ1UEtNazh4Z0pFaGxGVHlGclcwTUx4YzZvREpZK2N5VmFIczBSdkl6NXFn?=
 =?gb2312?B?ek1VMWZOZndxU21NWlh5dFVJSGNjclVpVzVKenhEQk1kTEViOHZsZ3ZvQjhY?=
 =?gb2312?B?bnc2QkpCeS9HcVZiZGlJM1JLODNWMWtoM1cvcXZWa2xDeUhnbEM4QWdBYjVJ?=
 =?gb2312?B?bDhDeThPMjZCblJGazkxN3pDbHVGdlRYREg3TkVuNkM5LytoRWVaRlR1cXV6?=
 =?gb2312?B?aG1QS2JnZWJmQlRTbkp6bnZCTlZGVzRaeHE3dTg4WFR6ZDZqNjNPQkliUmFD?=
 =?gb2312?B?S0t2d3VhNTFZMGVOdjdOR1dQc0dBbUd4eUdudHg4WU1SZ2tsUXErQjN1UzAy?=
 =?gb2312?B?ZTZ4dXd5RHBFenNiVURMS1drem1nSlNtaXRGdTZwL1JtN0pVRktUOFQ2ZDhy?=
 =?gb2312?B?QlRYUkZzQ2orTFQraVlyckNOdWVOU0gweFpsa1BZSmRPaVpBb0FXc1B2Smh4?=
 =?gb2312?B?bzdtbGNWT2FkVExSc2VPbWhZS3hhdzJlbkFiOWVtTS9hNUE3MkROMVJzakJS?=
 =?gb2312?B?MWR0dWI2b0Q0Z0FCeXN6WlRjeXhsTE80MGp4Mzk2RHgyUHArSzhkNmRWVWc2?=
 =?gb2312?B?a1dXWlNWc3BKRGhZSUtyMGNmeG40M0NwbkJzTGVwSjljNEhjN0d4NVJtTHVa?=
 =?gb2312?B?cDRXMGZxczRRMGZIOFlOSFJiYXo4Wk5HNTlIdS9WWVlGc3hXQm5pU3BPdWNW?=
 =?gb2312?B?YVBpampLa3dnaDArK0JGUElTaDg1UDJmNlFJVTQ0aUJ4dTh4NWRpVXh1UDcz?=
 =?gb2312?B?cnNPbDhFNC9GdVRITGZ2QjVPSXR0cjY1SzRFTTM0blpoeStJR3RrT1ZiNDhJ?=
 =?gb2312?B?VXZDT0hNWVdjd2xOVXE4SVpsUFluUFJMNWVNc0dNUmUrWnlpR051TzNXM1Fl?=
 =?gb2312?B?ZjhHQ1dLdGs5by9qVzI3bTdGQnZxdHhhbHNtbmFZamI4VXh6OU1RSHUzSWpY?=
 =?gb2312?B?MTYvY3hOZ0lleDRUNG42Z1dJRStCdTZCWXNRSmxrcjVvS2pkUEpCNkRkRExt?=
 =?gb2312?B?cVkzUUdaZ1dlLzhnWnRzazV2cUpTRUptVjFjenY3RlRSaWExcTRiRE9LeWUz?=
 =?gb2312?B?bWpkaE4yMFRKSUNxZkhxN1Fia290ZUZEdTc3TzcrYm43UXFpMTBjY1VQZStn?=
 =?gb2312?B?ejBwUTdzeDQwUFdEU25FVGRSemVrcFRXczNsTG5hK0F4akdFSmpDUlFxcXA0?=
 =?gb2312?B?bmpkUXdWMUM2NGRtL3UxUT09?=
Content-ID: <CA1558DC074B8F41A1EE1980BC5D3F8F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb735000-91ae-442e-c1ec-08d978eb4ac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 08:23:41.5278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sxXe+8RCF2GU/kZxuTFj5oHVM0GJIiyds/tl4Waplvf3IseOrdBZtWeNdUPeKhtEDURUYPqDU/H+AHGGdWWVKC9bvnqEjnR5ORcoiLIXARs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5818
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] syscalls/dup2/dup203: Convert to new API
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
Message-ID: <20210916082341.6nPr_qQRfzgKpEskTJVohBm9P2OK8nXl4EcGaosK_Oo@z>

Hi Qi
> From: QI Fuli<qi.fuli@fujitsu.com>
>
> Signed-off-by: QI Fuli<qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/dup2/dup203.c | 282 +++++++++---------------
>   1 file changed, 101 insertions(+), 181 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/dup2/dup203.c b/testcases/kernel/syscalls/dup2/dup203.c
> index e6f281adf..a840f4638 100644
> --- a/testcases/kernel/syscalls/dup2/dup203.c
> +++ b/testcases/kernel/syscalls/dup2/dup203.c
> @@ -1,208 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
>   /*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * Copyright (c) International Business Machines  Corp., 2001
>    */
>
> -/*
> - * NAME
> - *	dup203.c
> - *
> - * DESCRIPTION
> +/*\
> + * [Description]
>    *	Testcase to check the basic functionality of dup2().
> - *
> - * ALGORITHM
> - *	1.	Attempt to dup2() on an open file descriptor.
> - *	2.	Attempt to dup2() on a close file descriptor.
> - *
> - * USAGE:<for command-line>
> - *  dup203 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -f   : Turn off functionality Testing.
> - *             -i n : Execute test n times.
> - *             -I x : Execute test for x seconds.
> - *             -P x : Pause for x seconds between iterations.
> - *             -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - * RESTRICTIONS
> - *	NONE
> + *	1. Attempt to dup2() on an open file descriptor.
> + *	2. Attempt to dup2() on a close file descriptor.
>    */
>
> -#include<fcntl.h>
> -#include<sys/param.h>
>   #include<errno.h>
> -#include<string.h>
> -#include "test.h"
> -#include "safe_macros.h"
> +#include<stdio.h>
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +
> +static int fd0, fd1, fd2, rval;
rval is only used in verfiy_close, so it doesn't need to declare as static.
> +static char filename0[40], filename1[40];
> +static char buf[40];
> +
> +static void verify_open(void);
> +static void verify_close(void);
> +
> +static struct tcase {
> +	char *desc;
> +	void (*verify)();
> +} tcases [] = {
> +	{"Test duping over an open fd", verify_open},
> +	{"Test close on exec flag", verify_close},
> +};
> +
> +static void verify_open(void)
> +{
> +	sprintf(filename0, "dup203.file0.%d\n", getpid());
> +	sprintf(filename1, "dup203.file1.%d\n", getpid());
This can been moved into setup function instead of here, so we don't 
call it repeatly when using -i parameters.
> +	unlink(filename0);
> +	unlink(filename1);
> +
> +	fd0 = SAFE_CREAT(filename0, 0666);
> +	SAFE_WRITE(1, fd0, filename0, strlen(filename0));
> +	SAFE_CLOSE(fd0);
> +
> +	fd1 = SAFE_CREAT(filename1, 0666);
> +	SAFE_WRITE(1, fd1, filename1, strlen(filename1));
> +	SAFE_CLOSE(fd1);
> +
> +	fd0 = SAFE_OPEN(filename0, O_RDONLY);
> +	fd1 = SAFE_OPEN(filename1, O_RDONLY);
> +
> +	TEST(dup2(fd0, fd1));
> +
> +	if ((fd2 = TST_RET) == -1)
I prefer to use two lines to replace this
fd2 = TST_RET;
if (TST_RET == -1)
> +		tst_res(TFAIL, "call failed unexpectedly");
> +	else {
> +		if (fd1 != fd2) {
> +			tst_res(TFAIL, "file descriptors don't match");
> +			return;
> +		}
>
> -void setup(void);
> -void cleanup(void);
> +		memset(buf, 0, sizeof(buf));
> +		SAFE_READ(0, fd2, buf, sizeof(buf));
> +		if (strcmp(buf, filename0) != 0)
> +			tst_res(TFAIL, "read from file got bad data");
> +		tst_res(TPASS, "dup2 test 1 functionality is correct");
IMO, we don't use the big else branch.  I will list my code in last.
> +	}
>
> -char *TCID = "dup203";
> -int TST_TOTAL = 1;
> +	SAFE_CLOSE(fd0);
> +	SAFE_CLOSE(fd1);
> +	close(fd2);
In actually, fd2 close failed, I think we should remove newfd close.


diff with your patch:
--- a/testcases/kernel/syscalls/dup2/dup203.c
+++ b/testcases/kernel/syscalls/dup2/dup203.c
@@ -16,7 +16,7 @@
  #include "tst_test.h"
  #include "tst_safe_macros.h"

-static int fd0, fd1, fd2, rval;
+static int fd0, fd1, fd2;
  static char filename0[40], filename1[40];
  static char buf[40];

@@ -33,11 +33,6 @@ static struct tcase {

  static void verify_open(void)
  {
-       sprintf(filename0, "dup203.file0.%d\n", getpid());
-       sprintf(filename1, "dup203.file1.%d\n", getpid());
-       unlink(filename0);
-       unlink(filename1);
-
         fd0 = SAFE_CREAT(filename0, 0666);
         SAFE_WRITE(1, fd0, filename0, strlen(filename0));
         SAFE_CLOSE(fd0);
@@ -51,30 +46,33 @@ static void verify_open(void)

         TEST(dup2(fd0, fd1));

-       if ((fd2 = TST_RET) == -1)
+       fd2 = TST_RET;
+       if (TST_RET == -1) {
                 tst_res(TFAIL, "call failed unexpectedly");
-       else {
-               if (fd1 != fd2) {
-                       tst_res(TFAIL, "file descriptors don't match");
-                       return;
-               }
-
-               memset(buf, 0, sizeof(buf));
-               SAFE_READ(0, fd2, buf, sizeof(buf));
-               if (strcmp(buf, filename0) != 0)
-                       tst_res(TFAIL, "read from file got bad data");
-               tst_res(TPASS, "dup2 test 1 functionality is correct");
+               goto free;
+       }
+       if (fd1 != fd2) {
+               tst_res(TFAIL, "file descriptors don't match");
+               goto free;
         }

+       memset(buf, 0, sizeof(buf));
+       SAFE_READ(0, fd2, buf, sizeof(buf));
+       if (strcmp(buf, filename0) != 0)
+               tst_res(TFAIL, "read from file got bad data");
+       else
+               tst_res(TPASS, "dup2 test 1 functionality is correct");
+
+free:
         SAFE_CLOSE(fd0);
         SAFE_CLOSE(fd1);
-       close(fd2);
+       SAFE_UNLINK(filename0);
+       SAFE_UNLINK(filename1);
  }

  static void verify_close(void)
  {
-       sprintf(filename0, "dup203.%d\n", getpid());
-       unlink(filename0);
+       int rval, rc=0;

         fd0 = SAFE_CREAT(filename0, 0666);
         SAFE_FCNTL(fd0, F_SETFD, 1);
@@ -87,29 +85,36 @@ static void verify_close(void)

         TEST(dup2(fd0, fd2));

-       if ((fd1 = TST_RET) == -1)
+       fd1 = TST_RET;
+       if (TST_RET == -1) {
                 tst_res(TFAIL, "call failed unexpectedly");
-       else {
-               if (fd1 != fd2) {
-                       tst_res(TFAIL, "bad dup2 descriptor %d", fd1);
-                       return;
-               }
-               rval = SAFE_FCNTL(fd1, F_GETFD, 0);
-               if (rval != 0) {
-                       tst_res(TFAIL | TERRNO,
-                               "fcntl F_GETFD on fd1 failed; expected a "
-                               "return value of 0x0, got %#x", rval);
-                       return;
-               }
-               rval = SAFE_FCNTL(fd0, F_GETFD, 0);
-               if ((rval & O_ACCMODE) != O_WRONLY)
-                       tst_res(TFAIL, "fctnl F_GETFL bad rval on fd0 "
-                               "Expected %#x got %#x", O_WRONLY, rval);
-               tst_res(TPASS, "dup2 test 2 functionality is correct");
+               goto free;
+       }
+       if (fd1 != fd2) {
+               tst_res(TFAIL, "bad dup2 descriptor %d", fd1);
+               goto free;
         }
+       rval = SAFE_FCNTL(fd1, F_GETFD, 0);
+       if (rval != 0) {
+               tst_res(TFAIL, "fcntl F_GETFD on fd1 failed; expected a "
+                       "return value of 0x0, got %#x", rval);
+               rc++;
+       }
+
+       rval = SAFE_FCNTL(fd0, F_GETFD, 0);
+       if ((rval & O_ACCMODE) != O_WRONLY) {
+               tst_res(TFAIL, "fctnl F_GETFL bad rval on fd0 "
+                       "Expected %#x got %#x", O_WRONLY, rval);
+               rc++;
+       }
+       if (!rc)
+               tst_res(TPASS, "dup2 test 2 functionality is correct");

+free:
         SAFE_CLOSE(fd0);
         SAFE_CLOSE(fd1);
+       SAFE_UNLINK(filename0);
+       SAFE_UNLINK(filename1);
  }

  static void run(unsigned int i)
@@ -118,10 +123,19 @@ static void run(unsigned int i)

         tst_res(TINFO, tc->desc);
         tc->verify();
+}
+
+static void setup(void)
+{
+       int pid;

+       pid = getpid();
+       sprintf(filename0, "dup203.file0.%d\n", pid);
+       sprintf(filename1, "dup203.file1.%d\n", pid);
  }

  static struct tst_test test = {
+       .setup = setup,
         .tcnt = ARRAY_SIZE(tcases),
         .needs_tmpdir = 1,
         .test = run,


Best Regards
Yang Xu

> +}
>
> -int main(int ac, char **av)
> +static void verify_close(void)
>   {
> -	int fd0, fd1, fd2, rval;
> -	char filename0[40], filename1[40];
> -	char buf[40];
> -
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -//block1:
> -		tst_resm(TINFO, "Enter block 1");
> -		tst_resm(TINFO, "Test duping over an open fd");
> -
> -		sprintf(filename0, "dup202.file0.%d\n", getpid());
> -		sprintf(filename1, "dup202.file1.%d\n", getpid());
> -		unlink(filename0);
> -		unlink(filename1);
> -
> -		if ((fd0 = creat(filename0, 0666)) == -1)
> -			tst_brkm(TBROK, cleanup, "cannot create first file");
> -		if (write(fd0, filename0, strlen(filename0)) == -1)
> -			tst_brkm(TBROK, cleanup, "filename0: write(2) failed");
> -
> -		if ((fd1 = creat(filename1, 0666)) == -1)
> -			tst_brkm(TBROK, cleanup, "Cannot create second file");
> -		if (write(fd1, filename1, strlen(filename1)) == -1)
> -			tst_brkm(TBROK, cleanup, "filename1: write(2) failed");
> -
> -		SAFE_CLOSE(cleanup, fd0);
> -		if ((fd0 = open(filename0, O_RDONLY)) == -1)
> -			tst_brkm(TBROK, cleanup, "open(2) on filename0 failed");
> -
> -		SAFE_CLOSE(cleanup, fd1);
> -		if ((fd1 = open(filename1, O_RDONLY)) == -1)
> -			tst_brkm(TBROK, cleanup, "open(2) on filename1 failed");
> -
> -		TEST(dup2(fd0, fd1));
> -
> -		if ((fd2 = TEST_RETURN) == -1) {
> -			tst_resm(TFAIL, "call failed unexpectedly");
> -		} else {
> -			if (fd1 != fd2) {
> -				tst_resm(TFAIL, "file descriptors don't match");
> -				break;
> -			}
> -
> -			memset(buf, 0, sizeof(buf));
> -			if (read(fd2, buf, sizeof(buf)) == -1)
> -				tst_brkm(TBROK, cleanup, "read(2) failed");
> -			if (strcmp(buf, filename0) != 0)
> -				tst_resm(TFAIL, "read from file got bad data");
> -			tst_resm(TPASS, "dup2 test 1 functionality is correct");
> -		}
> -
> -		close(fd0);
> -		close(fd1);
> -		close(fd2);
> -		unlink(filename0);
> -		unlink(filename1);
> +	sprintf(filename0, "dup203.%d\n", getpid());
> +	unlink(filename0);
>
> -		tst_resm(TINFO, "Exit block 1");
> +	fd0 = SAFE_CREAT(filename0, 0666);
> +	SAFE_FCNTL(fd0, F_SETFD, 1);
>
> -//block2:
> -		tst_resm(TINFO, "Enter block 2");
> -		tst_resm(TINFO, "Test close on exec flag");
> +	fd2 = SAFE_CREAT(filename1, 0666);
>
> -		sprintf(filename0, "dup02.%d\n", getpid());
> -		unlink(filename0);
> +	/* SAFE_CLOSE() sets the fd to -1 avoid it here */
> +	rval = fd2;
> +	SAFE_CLOSE(rval);
>
> -		if ((fd0 = creat(filename0, 0666)) == -1) {
> -			tst_brkm(TBROK, cleanup, "Cannot create first file");
> -		}
> -		if (fcntl(fd0, F_SETFD, 1) == -1) {
> -			tst_brkm(TBROK, cleanup, "setting close on exec flag "
> -				 "on fd0 failed");
> -		}
> +	TEST(dup2(fd0, fd2));
>
> -		if ((fd2 = creat(filename1, 0666)) == -1) {
> -			tst_brkm(TBROK, cleanup, "Cannot create second file");
> +	if ((fd1 = TST_RET) == -1)
> +		tst_res(TFAIL, "call failed unexpectedly");
> +	else {
> +		if (fd1 != fd2) {
> +			tst_res(TFAIL, "bad dup2 descriptor %d", fd1);
> +			return;
>   		}
> -
> -		/* SAFE_CLOSE() sets the fd to -1 avoid it here */
> -		rval = fd2;
> -		SAFE_CLOSE(cleanup, rval);
> -
> -		TEST(dup2(fd0, fd2));
> -
> -		if ((fd1 = TEST_RETURN) == -1) {
> -			tst_resm(TFAIL, "call failed unexpectedly");
> -		} else {
> -			if (fd1 != fd2) {
> -				tst_resm(TFAIL, "bad dup2 descriptor %d", fd1);
> -				break;
> -			}
> -
> -			if ((rval = fcntl(fd1, F_GETFD, 0)) != 0) {
> -				tst_resm(TBROK | TERRNO,
> -					 "fcntl F_GETFD on fd1 failed; expected a "
> -					 "return value of 0x0, got %#x", rval);
> -				break;
> -			}
> -			if ((rval = (fcntl(fd0, F_GETFL, 0)&  O_ACCMODE)) !=
> -			    O_WRONLY) {
> -				tst_resm(TFAIL, "fctnl F_GETFL bad rval on fd0 "
> -					 "Expected %#x got %#x", O_WRONLY,
> -					 rval);
> -			}
> -			tst_resm(TPASS, "dup2 test 2 functionality is correct");
> +		rval = SAFE_FCNTL(fd1, F_GETFD, 0);
> +		if (rval != 0) {
> +			tst_res(TFAIL | TERRNO,
> +				"fcntl F_GETFD on fd1 failed; expected a "
> +				"return value of 0x0, got %#x", rval);
> +			return;
>   		}
> -
> -		close(fd0);
> -		close(fd1);
> -
> -		unlink(filename0);
> -		unlink(filename1);
> -		tst_resm(TINFO, "Exit block 2");
> +		rval = SAFE_FCNTL(fd0, F_GETFD, 0);
> +		if ((rval&  O_ACCMODE) != O_WRONLY)
> +			tst_res(TFAIL, "fctnl F_GETFL bad rval on fd0 "
> +				"Expected %#x got %#x", O_WRONLY, rval);
> +		tst_res(TPASS, "dup2 test 2 functionality is correct");
>   	}
>
> -	cleanup();
> -	tst_exit();
> +	SAFE_CLOSE(fd0);
> +	SAFE_CLOSE(fd1);
>   }
>
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - */
> -void setup(void)
> +static void run(unsigned int i)
>   {
> +	struct tcase *tc = tcases + i;
>
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +	tst_res(TINFO, tc->desc);
> +	tc->verify();
>
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
>   }
>
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *	       completion or premature exit.
> - */
> -void cleanup(void)
> -{
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.needs_tmpdir = 1,
> +	.test = run,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
