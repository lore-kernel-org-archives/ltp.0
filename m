Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C33CC433F5
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 06:06:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B19353C1D1D
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 07:06:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 629C73C0480
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 07:06:18 +0100 (CET)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 75DA910009EC
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 07:06:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1638770777; x=1670306777;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=lbaK7P6Lhs1wFjxLd3Z4ZdgbYGcHEWJ0ShCZGJ/HShQ=;
 b=X6NV7Y6jLPxCDhyDIZICLa86DgUA5WQWBwv78RFxShBHZsxJGz53fw80
 abHv49rL9aWcFQ/BgEC6BmtOZCQ58gcXYzeXeg9tEYTkFvGAnG76ZtI39
 gvje2gzOxvXWkhBHV3u2NdRZ01gV+w2NSINNMsN1pzMMNhzLQVxwR4GvQ
 iG/VmdGwkW7OzqVfBHXQke78sy5ReLyr2s2yEDGnuxV5lh9zj7/8TjxWe
 PauXejTWlzzAZrPcnLOXY5/3vwHyuN3M9lH6VHgNStRxIFHVWJ9LZVT2Q
 7H+N87pZgyfOckSaPjH6oR/Mw83xNSiV5sQlVcgW8216HYFILLoC9Cxal g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="45530641"
X-IronPort-AV: E=Sophos;i="5.87,290,1631545200"; d="scan'208";a="45530641"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2021 15:06:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoTgAd/EUnoF4kjdH68t3mfEwzRqnFk70MssTbTwaZ1/25NEH35gSIx4ACOMlGpsYcjF1WioH1Velj40QuNk0DYolnb+GZ8j0r0bCiqokQmFxrMCznhUNQLaQs9oYGMXtOOQovTYLe9BnDbmYz+NW8uJX5FrTfCPE2zy20KuwYaNFfApFQIz8Yz1H37EbyRLqfUiZQpedVlmz7NSY8msdxPpD7L9ooR/PcLboghQY1sYVslh+MlDJRBZk+tmCenhWWbZ/DjsWoWqZfTFi30/ym3kygr/yjeuWYm523hQW3Opk+RLhR8X1goucc66qvm79NNMd/17qZ3QQNHfIOe9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbaK7P6Lhs1wFjxLd3Z4ZdgbYGcHEWJ0ShCZGJ/HShQ=;
 b=kaunmKTsXKBgUHnIayc03I5auyT0ogMAgaKT8175UuRXDyxJSd7LoLNYabB7P+fKm4sQc4QG0RvMIwzxN6kXK4p26SrppcyEvcFOg4PsyPqo4ghI6ZtjODIwC5ElXu/iKmhJiCNRxYpcmSdTmAChlhZfcY/eoZPiJPYfB69jLmch5CXW82sZWmjUS2y8e8nsVYpqGwlztbsPJ8WNqvudJTLzGEqeHXGFnHl3WTlDyd2KNmv6NLVFoUfZeEUSoi3/YixO3PGaE8b/aE4mWQd9Vv5+zPnOvbTKLgItK+A59kaZ21FugO4dGEbqlN3LnkeFxgCVd9OyLI3ss2TICrR69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbaK7P6Lhs1wFjxLd3Z4ZdgbYGcHEWJ0ShCZGJ/HShQ=;
 b=CfXedS30S+nNi3wArx2pK4n8yvIKCV2aD8OD74d52WcVx3gF9+Q54+rvgKITrTCitxTsagPE/qTBzlx7d+MezRqBw4gBQsFd3dPN9jpE1rsmA+slE0dkWOhh6qSGGmoLSUAND6ijMKsnzzeVh8vau0qysu/raMdqISUOcCc2Cqw=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB3657.jpnprd01.prod.outlook.com (2603:1096:404:df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 06:06:11 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 06:06:11 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "daisl.fnst@fujitsu.com" <daisl.fnst@fujitsu.com>
Thread-Topic: [LTP] [PATCH 1/2] syscalls/fcntl12: Convert to new API
Thread-Index: AQHX6B4Rn7P3TA95E0On4BgB6NDcqKwk/qOA
Date: Mon, 6 Dec 2021 06:06:11 +0000
Message-ID: <61ADA871.1030007@fujitsu.com>
References: <1638566204-6212-1-git-send-email-daisl.fnst@fujitsu.com>
In-Reply-To: <1638566204-6212-1-git-send-email-daisl.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 058c3ed3-ab4b-47bf-2e37-08d9b87e80ab
x-ms-traffictypediagnostic: TY2PR01MB3657:
x-microsoft-antispam-prvs: <TY2PR01MB3657716B0B9018BE39D4FD8DFD6D9@TY2PR01MB3657.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I3OMRQOACkK4ZJBj44KlMPdjxCj4i2uLavtsErSV9RDhAW8MM8NvyyKomZS02c4vB0+zOAPbUvqq+YTfjez/Nzc93ApMGeZXQJqohkZAyRhYE24rNLR84Fy1PgbULe0w4HKRcIGkZcdYe0r7wzpcU4WieaqIlBEJcaZBFyRJ/Ro0SKy5+sLRgfgbVFEiVPWYCexV8oNyBM5hg0gADWfQpLurxjGH8fehdp8XL1Ql0Ar4onY2Mya9KqTvksXdftvLUxftX4kJ/Wanu9WXa2y2A1OnfVoMYpDDVP3RWOYytgZDpDM5dvM9mmSaP0j2Pg/Nh8JRE/wReG0kuDBR56G1n92aXQgE/t2pX9KUxipELpOVzAfVjeTwzfC5yvygwRiHaCZptFi0ieaP8YCL5IIIzPxqGW1SjGmSRdRC4rc0yD9+yOA6DRKFv+7QVBxamChIT3imOAklMSZV1H73z7J6KWnsUOQgb8OhD0IylxVlyrykgK96fNFMPS4uAqcUjFG86PjTbrvmjjCBB7kEP+S+U1H9/jltKPQcRl6ZHDfiyEd9BGFtLFf1xwknV6AJrs4VllDbLQQCUuW5liavRQJO7Qh0yL1k1DGQW5FUswQZ/4xGyUHLGiQl2dyQmndN/18LLi7ncsIfVjy1kN547XAh1LLuP5mbKaTPBXPnHwutdYh6BxWE/buAs9Eb4MwCZw/FKLRnrBIRbK660wPIAgg7WlJjZdtYF+imVxBm4USsal0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(71200400001)(6512007)(36756003)(37006003)(8676002)(8936002)(38100700002)(186003)(316002)(508600001)(87266011)(122000001)(5660300002)(83380400001)(86362001)(6862004)(66946007)(85182001)(2906002)(6636002)(76116006)(91956017)(33656002)(38070700005)(82960400001)(2616005)(4326008)(66556008)(64756008)(66476007)(66446008)(6486002)(6506007)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZGwvbTkrUnhVMmErOGRnd1J1N2hERS9GeXBIZXdYRzIwSFhjM1N3MHhLa3Nq?=
 =?gb2312?B?TCt3dXYrd3FYZGMrQ3B6a2JMQ1JkSnhIaUpQYlVEUi9kT0FXcGduR3dlRkp5?=
 =?gb2312?B?b0EzdDJETVc2OWZMT3hCeGRRbVVYYWx5VEI2RnRmUGoxTmRkWmxvbzB6NlU3?=
 =?gb2312?B?aDc5OUp2UFVrSExsSzJEUDZIZWM2SkpDOFNJblV6TThaRUFPUXZyQURmcDhK?=
 =?gb2312?B?T1J0d04xV2NZZ3RiS2doQXQ1NlVDQmh4L0dXZ3VZVjAyeGN5NlMvb3IvYjNo?=
 =?gb2312?B?aC96SUFQVUtma2ZjZzhnNElKTldjQzB6eVFlZVdUNEVWTE5waWJWQlFsdCtR?=
 =?gb2312?B?UWx3dndKZTd2aEJaUnM2S0tBYXB6WkFoOFpSSzFLVE5lWmpyVWlUQ1pnSVBC?=
 =?gb2312?B?WE56RG9zcktOWVhZbDRRTDBPc3ZqbXBvU2NYUmp2UnRPOTBoeEFEWkU3dkhx?=
 =?gb2312?B?QnZsQVo0cVp5bmMvRWRPUWt0aVErOUFJOEVzS2dsWncrVUNQcER5Y0dnTWtF?=
 =?gb2312?B?TjY4aDI1TGxpeFRQbjdRdGE1WG8zd0w1VlZwMWNoYUdvNVlsUGtBR29ZUmUz?=
 =?gb2312?B?dy9PT2JXejBtRXd5ekpMMHhaYjdpMTR0ZE1GdjE5TFhhaDd3bC9GTmQxNW1q?=
 =?gb2312?B?VkxsTlllcmFPcElYSzRhOVNLRFh5NnRqeVNNQ3dhdmdnNm9BeXFid01Gd1Vq?=
 =?gb2312?B?SlhaZDhTWXdZZDVmWmk4UktVbUNzREpubVRxc2lOdGtYMEdFRGZaS1djNmd5?=
 =?gb2312?B?YTBYb053OTV0bWI4c3FVc1hMVitSOFVTR24wSzlNNzZEQTJRLytFOURUUkQz?=
 =?gb2312?B?dWcwbGtVTVA5RHVQdXpYVlZBbVFHVkxJVnphVG45SCtISzRmYXFGeG9qQnp5?=
 =?gb2312?B?UGVITThkTm1aaDFaS1lLL2VDbE9VdUNKc044K2ZxUmhJTjlpUXJJZk1mTzlm?=
 =?gb2312?B?QlE5R3dsK2MvSFBndjJ0Q1diZnY5SHhrdm5zNll5OTQyR2M2aTVSTmt4RitY?=
 =?gb2312?B?aWlySWNxVm94MTZtbm9QbUFkZ0VCVDRnODJ0a1FjMlhseTRIUmVvZEJuQVB0?=
 =?gb2312?B?YncxdVFsME5STGExYytTZFBwc1p2ZEUyZlVLckNtblhtcTc3dStvRHFqaHdP?=
 =?gb2312?B?M1ZYRTZJdHJIRjhJYnc3RktFMnVIalltVkE3Z2FrWnEzRGVnMkZvOTdHUHUr?=
 =?gb2312?B?L1FUTlJEMURQRnNtWGNPMnBnMjIxU1dvYThvcUhkKzVGRWNVYitkenJDOHZD?=
 =?gb2312?B?VnlHVmNRYVkxS3ZaNW1YYjFjQzRNT1BRZjlzWEgyd1NmbHBybUp3LzZPSGZl?=
 =?gb2312?B?bUFFRXN1MFR1bEI3MVZuQXp3Q2o1NUhLNzdVNUJIVGRMaWhaVFZyUURsSjFN?=
 =?gb2312?B?cmZ4Sk5ZaUtKTU9TeTUzOUgvdFF1RkZDYzJvS1VsUjBxM2hTeEFlSmNJaWxl?=
 =?gb2312?B?RVMydDFXd3Nrd3dEZlAyWllDNUpla3Vjc2llaGNXVng1ejQrQmFTVkhsYi9I?=
 =?gb2312?B?NWY0M1VidFUrVzRyS2laR0wxcjd3S2QvcFVsVE5GLzF0cTlJaEdnQ0hHeWl4?=
 =?gb2312?B?VkdGNFBVSDVJVVhiNFI5L0FSMFJIWnJia21tTnJPUU1xdE9XNVhkWTBvaXY4?=
 =?gb2312?B?b3c2V1FzQnNMWjk5Z1lJckFEazZCcGVLNGdUcmRmM2FFUXppSXhPMVhnNmVz?=
 =?gb2312?B?Q3NVN1lycmFORDdIWFhoL0Z1UThCK1cyRGZkcE9HQ2tZcmxHTGtDMEdoT0Rv?=
 =?gb2312?B?d2tRbWkvb0Jha0xPckFHc2pYbHRhR1hFM2xjZTFjdG1xbEdsNWp1TU50THZn?=
 =?gb2312?B?YlA1a29VanI2QUVqWlVQSGh6WFVkQmFYNEQ5T1I1Ny9zT2syWXpJTk53WDc0?=
 =?gb2312?B?MjlLa3NIQTYwRUoyR09MZW1sSWg2bFdwWE1YbER6NUJZWWo3UkRaQUtublVF?=
 =?gb2312?B?UnpvTFQ2cndwb2xJdzdpNHFFcVNNcmZISG9SZ3dTOUU2cTgxMTVVQkhid3BO?=
 =?gb2312?B?eVVGNStKOW5kY0pESzN5ZXNQN0JHZ0x6cHNES1BhT0JMRXB1dU83NGdBVE9F?=
 =?gb2312?B?dFAxSzlreW1HRGpTTStCRGoxWktqRFVyZ2wyem1sUDFtRXMrdnA5b3plamd1?=
 =?gb2312?B?S2xIek9TUFlMUnU3MXBMVHRGSEd4Z0FyeDFuOVlIaDRBWjBzRWttcTR3eEYx?=
 =?gb2312?B?ZHF0MlRFV3pYSVBEbnlmTFpqVitPSWdaRmc0bFVWT3gvU1BhbXJ4Q24rNjBX?=
 =?gb2312?Q?sSNqmabWDYsQU5OYPdPQZLOL7SLIGwY0iSkxIz1wR8=3D?=
Content-ID: <BE7D052537119042AC7F4E1848058E22@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058c3ed3-ab4b-47bf-2e37-08d9b87e80ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 06:06:11.2742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Wue/jv2xZLQGJWxgI7+aIW2CgVdPkJUif6Mof/9/4SsiD29AvVP9Gcpr74ugULMYT6DpX8DeuVvNi5B1XHBJ4lgc+lOjCXPRh0KXJRA4iU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3657
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/fcntl12: Convert to new API
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

Hi Dai

I do some minor changes and pushed, thanks.

1) move getdtablesize into setup function and include <unistd.h> header
2) fix TST_EXP_FAIL2 usage
3) fix EMFILE description as man-pages said
4) move i,pid variable declaration to verify_fcntl funtion.

Best Regards
Yang Xu
> 1) use SAFE macro
> 2) use TST_EXP_FAIL2 macro
>
> Signed-off-by: Dai Shili<daisl.fnst@fujitsu.com>
> ---
>   testcases/kernel/syscalls/fcntl/fcntl12.c | 135 ++++++++----------------------
>   1 file changed, 36 insertions(+), 99 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl12.c b/testcases/kernel/syscalls/fcntl/fcntl12.c
> index ae382dd..e4dbe42 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl12.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl12.c
> @@ -1,120 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
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
> + * Copyright (c) Linux Test Project, 2021
> + * Copyright (c) International Business Machines  Corp., 2001
> + * 07/2001 Ported by Wayne Boyer
>    */
>
> -/*
> - * NAME
> - *	fcntl12.c
> +/*\
> + * [Description]
>    *
> - * DESCRIPTION
> - *	Testcase to test that fcntl() sets EMFILE for F_DUPFD command.
> + * Tests basic error handling of the fcntl syscall.
>    *
> - * ALGORITHM
> - *	Get the size of the descriptor table of a process, by calling the
> - *	getdtablesize() system call. Then attempt to use the F_DUPFD command
> - *	for fcntl(), which should fail with EMFILE.
> - *
> - * USAGE
> - *	fcntl12
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - * RESTRICTIONS
> - *	NONE
> + * - EMFILE when cmd refers to F_DUPFD after gets the size of the descriptor table of a process
>    */
>
>   #include<fcntl.h>
>   #include<sys/types.h>
>   #include<sys/wait.h>
> -#include<errno.h>
> -#include "test.h"
> +#include<stdlib.h>
> +#include "tst_test.h"
>
> -char *TCID = "fcntl12";
> -int TST_TOTAL = 1;
> +static pid_t pid;
> +static char fname[20] = "testfile";
> +static int fd = -1;
> +static int i, max_files;
>
> -int fail;
> -char fname[20];
> -void setup(void);
> -void cleanup(void);
> -
> -int main(int ac, char **av)
> +static void verify_fcntl(void)
>   {
> -	int lc;
> -
> -	pid_t pid;
> -	int fd, i, status, max_files;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	/* check for looping state if -i option is given */
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		tst_resm(TINFO, "Test for errno EMFILE");
> -		fail = 0;
> -
> -		pid = FORK_OR_VFORK();
> -		if (pid<  0) {
> -			tst_brkm(TBROK | TERRNO, cleanup, "Fork failed");
> -		} else if (pid == 0) {
> -			max_files = getdtablesize();
> -			for (i = 0; i<  max_files; i++) {
> -				if ((fd = open(fname, O_CREAT | O_RDONLY,
> -					       0444)) == -1) {
> -					break;
> -				}
> -			}
> -
> -			if (fcntl(1, F_DUPFD, 1) != -1) {
> -				tst_resm(TFAIL, "fcntl failed to FAIL");
> -				exit(1);
> -			} else if (errno != EMFILE) {
> -				tst_resm(TFAIL, "Expected EMFILE got %d",
> -					 errno);
> -				exit(1);
> -			}
> -			exit(0);
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		max_files = getdtablesize();
> +		for (i = 0; i<  max_files; i++) {
> +			fd = open(fname, O_CREAT | O_RDONLY, 0444);
> +			if (fd == -1)
> +				break;
>   		}
> -		waitpid(pid,&status, 0);
> -		if (WEXITSTATUS(status) == 0)
> -			tst_resm(TPASS, "block 1 PASSED");
> -		else
> -			tst_resm(TFAIL, "block 1 FAILED");
> +		TST_EXP_FAIL2(fcntl(1, F_DUPFD, 1), EMFILE,
> +		"fcntl() got EMFILE");
>   	}
> -	cleanup();
> -	tst_exit();
> +	tst_reap_children();
> +
>   }
>
> -void setup(void)
> +static void cleanup(void)
>   {
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	if (fd>  -1)
> +		SAFE_CLOSE(fd);
>
> -	sprintf(fname, "fcnlt12.%d", getpid());
> -	tst_tmpdir();
> +	SAFE_UNLINK(fname);
>   }
>
> -void cleanup(void)
> -{
> -	unlink(fname);
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.forks_child = 1,
> +	.needs_tmpdir = 1,
> +	.cleanup = cleanup,
> +	.test_all = verify_fcntl,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
