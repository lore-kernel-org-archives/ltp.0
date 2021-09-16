Return-Path: <SRS0=QfDu=OG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25248C433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 08:42:24 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488796008E
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 08:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 488796008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 919633C898A
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 10:42:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FC4F3C1D25
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 10:42:11 +0200 (CEST)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C426C601E39
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 10:42:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1631781731; x=1663317731;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=TsBmn8uT2h5ptRnCo0kyV2AM7xASdx6U3+PEglAC8ZY=;
 b=K8hblLpAtQpX8OHd5g+zconzVRGjTIwynLJAfahaS2o+wE6EYW8Xofd/
 oo/7e1LTEIgqmEf/kxiWTh/Hs4cwmEGR8BZhEZSyhQu1tNAu9DCxiuk+C
 T79C76DQeRHnTe2vQ6DGFov2Dra0nS8OyZAxWcAsph8gDPPYM6I05RNzE
 WufcgYxUXeXHHAAQl36HpQJJHrxfCn8E91m3kh+zWdpElyOku69gwVVWL
 eaT3Gh9r42wopByGduDa2qQc+xEhBpqkk9uhHBvX88nUEAaBEYEid8UVk
 M9N64Qb9flR6L8wpkM0wSWbDP/ADctYqv60zoY7PxVEpEV30zIUiln1a1 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="39358061"
X-IronPort-AV: E=Sophos;i="5.85,297,1624287600"; d="scan'208";a="39358061"
Received: from mail-ty1jpn01lp2055.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.55])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2021 17:42:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gi8HgqP3UO/GnY6OuHTt6xg636W82ATgsTzAE2/VpUoBp6dBNBmJ86gocOgnpERSlw12DlzgGofwKilEWr508RW06c176U2U7dKStEdgMZtUhO5lG5/yEO+aeSvXiKEbiFpgQU7+FbIcLxDuWX0tRcPAnvWTMfA818LAOslQg1SR6Nnv/eohPBx6SCVPsk00ge18Hw4eOeBYZh8vhQt0Mj1we5fnqohNuTtakG3/MjpEPzvnrczn+wWXZR6DbjSjgiK9CDt/SppZpNSfhLDPgHGa7Sx/beZYmyXge0yiZbCPtB6lBLHi5hOWnTjAuaOEqsnD6CbwWDda0kuO1qTvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=TsBmn8uT2h5ptRnCo0kyV2AM7xASdx6U3+PEglAC8ZY=;
 b=aBKq1ayQpOHMbfx9lxJSFAtRU7EN7rcaA79lKqLRONOy8to3PDBEanHlPZcB4XgELivWPprEL9UOMtMqT3nu24GmSVKN3c6W+8nl3aMy64LUyFJBV9/D1wdZPx0HQAHr1CNFyZCTh+2MAlABypG3pPIX9fWdQSWpgO32gEwdGFf4gYN9JrjwGACsJt2NzUvR/jRbZWV/k7RCzXMs3Bv5fZta15KfE7YSXfmZPY0lSFQFEsKefnmTb7jwwStKLdHLe+5Dil+kakfKWhruy3/RVMXt2R2Hfhnfx47UZN1YTRqrw5lZ0o9S9S4V3mKLWn1lCn+i/mOw+plYZ3EQ3h95YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsBmn8uT2h5ptRnCo0kyV2AM7xASdx6U3+PEglAC8ZY=;
 b=Vnigx0YwoixItYZYqTHrf1yzzT0vYL8VRvGnDSu2SKxm2qpK5DsIsZI9xwpsJFzjBKM1mQNokj4eQXadTaemwpJdxfSi8i4mu2MrjL7+XSees7cXeg3H8Zb1vhLcsVUZ+ozDxxPeNmVVhzvdAID24l01jXBjMEVQr9oKShM1u0c=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB4494.jpnprd01.prod.outlook.com (2603:1096:404:120::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 08:42:05 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791%7]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 08:42:05 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: QI Fuli <fukuri.sai@gmail.com>
Thread-Topic: [LTP] [PATCH v2 4/4] syscalls/dup2/dup205: Convert to new API
Thread-Index: AQHXqknGeyY3KOyyWka9Fe6acJch4qumWPiA
Date: Thu, 16 Sep 2021 08:42:05 +0000
Message-ID: <61430371.4010209@fujitsu.com>
References: <20210915155152.8515-1-qi.fuli@fujitsu.com>
 <20210915155152.8515-5-qi.fuli@fujitsu.com>
In-Reply-To: <20210915155152.8515-5-qi.fuli@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9053db81-f456-41c8-efa4-08d978eddcce
x-ms-traffictypediagnostic: TYAPR01MB4494:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB4494441D1C1404A027EB98D9FDDC9@TYAPR01MB4494.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nZpLUKRv3b2VBcXNsf/BSnZmDpS9VKTDlF+hAWDdLdi52mPmNN0YnBpTmjIhP2LCI86K7aIf2fip9iOjeGOL/wjzyQyLdKxe2ogCAaBIk8XFj5MJG1F60Q4e423NQ2ekgI3aUSCGbNBu5zttAJgMqLR/44y3kdSZMHHAnHF1QZRb3GWDjo7bQk15GJpXdVNpfORz1Y38J0uA/nbcTdNb5pd5X71nkDM+pxFveRnsDthxao9Tl3Tp0d3Mt6F3Piv1c2WKXEVfnMPGA/1HlULFENKNZ6HEF1DB1nJwlvHbhxGvLpE+LlHK56YNl8rLhaFSgqBHO8XipMZIN0Lq1BG4WXjYNCYM5hKCUCub5/Q7AbrAYxQVA/EXdTrbkeBMyLAbIRu5gUm3Uiewag1/Ir1BKtBFbu+BOfc3ZfG57MzQ6lpIvB3DqwPiZFah33VCIqn7qNu9jdj5rSF9fRQb7LztizZkamAkkeNh7yspgqkJffZcrKksM+MHVfajiux89aIkQvM6HBhunV6GjdSHPBBA+Rfilq0P9K6TyW7n11+h8/A2CwZieeMWnF4cyzfdzhmP6HGHEimHCVob39Qx9xanM384gVIzYPq6mkKnd/5kfHLXibss30UrPwCY6233G9uV1kqhzE15S3NNZq19VC1NhtgCeTZ56qWKJuy26minPAVg0AylLnT2aKl9rK1rE/OmdASoP6YtefUCg/5Gu9Ah2Vn6lYdQzH+8dgZhun/go6JL8BwBm1BYM8uWNdQBVkUO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6512007)(107886003)(26005)(186003)(6486002)(66446008)(38070700005)(66556008)(64756008)(87266011)(66946007)(4326008)(66476007)(91956017)(36756003)(5660300002)(71200400001)(76116006)(2616005)(6916009)(316002)(85182001)(86362001)(2906002)(8676002)(122000001)(6506007)(38100700002)(8936002)(83380400001)(508600001)(54906003)(2004002)(62816006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?U2t6OUI4ZVFwbDc3eU81WWRyRlFYMzFKaWN0Umpod3dnNjBnZkJYdHJxaUI1?=
 =?gb2312?B?MmZHT3p1NTRDQUVkMTcrcEFtUzlGT2ptdjNRSWtCVkwxczhtNVorUlJ1b0lp?=
 =?gb2312?B?NUkvbFI4VHJwOFBvQXNKV0JKMm9VRkFKd3E5b2F6VXZ5QlMrYnpHa1Rkb1lz?=
 =?gb2312?B?bzR1cElmK3VBdkxaS01YeG9CZ0J6N01zQjQyQjMrYWN2dU5tTjhmQzZ2YVEr?=
 =?gb2312?B?bURLQlE2YkIyUmNhb0oxZkxvMFRmQW9JdzFSemZjOURRZjIxOExDNzZTcUZr?=
 =?gb2312?B?NGxLQ21aZ0M5aHAzVTZpclZsbldGejQ2MU1VWEkraWZ5RlJEdzJOMkFzTHFL?=
 =?gb2312?B?NElkaUxPZk9qS0E0S0hhVDhjMWtUZEl4eWVleVZ1U0VqQWIxSDk1Y2lhT2dF?=
 =?gb2312?B?QStnVnViNTFuaUhzUnkvNy8yZFNqalcwVWxGczV6WlNZY3l5RW4raEFKSzB1?=
 =?gb2312?B?RkxycEdyTU1NVEUrTWFNYTd6dTV5NXZZSlhKYXBFWmpoTjFKSXVvbndYaTZM?=
 =?gb2312?B?K3FlNVJGZXJJaVJGeU16QlZ2dzdKdGpKTDFOOUxIU1hCRERpMjd6dzlseEJR?=
 =?gb2312?B?VjBJUlJwZWFGcTZmTExvcjF4ODk0Vmc3Rnh6cTA5QjJORDVWbTlSZDdWTTd4?=
 =?gb2312?B?Wjh3NUwycVJwVWN2a0xzR011YTJvdGdMN0I5cWhVLy9mQUhGbXl4WWtSQ0xD?=
 =?gb2312?B?MjRpdHVFakplb1B3Y2MyQ0M5ZG1WRjV4citXN2pFVnZRVGV2YUdwNkM3Rzhm?=
 =?gb2312?B?ZENrMExBME03b0h5VGt0R0JmL0dXVFdGVmRiM2x3cjhwbVVMMldUeVRUZkF6?=
 =?gb2312?B?Y2VaZHZFTXVzWVVXU1Bub1dCZW9sVGZ4T3ZyenNwWlVldzR2WGhlRFh3dWtM?=
 =?gb2312?B?VVI1c2lxUGRVenVybnUxMFBmWnNoZk1GdW44Njg2MFBWTXBYdEI4RmsxNG51?=
 =?gb2312?B?c2c2elJvZmdpY3FyUWk1dEorTk54Z2dPSEZnK3FaYnNkYUlkeW1GbGtmWk43?=
 =?gb2312?B?bW1QcXBybmcvQWszM3RQZUVpc1VBVjRuVnBoYUMxQnB4MVZQejZ0RWEwaGp3?=
 =?gb2312?B?c2JxQ3ZFenF0by81TVR3S0podGQrRk9aeXQxVDdTTGw4TUIwZjRyay8yU2Fz?=
 =?gb2312?B?dDU0RnlWbk01UjFobVQ4LzhMa01NVmJ3QUI1YUoxYk5DUWNGenlXSUhDQUFk?=
 =?gb2312?B?V1NLUFR1VzB2NVAzbE1MbCtCYk5xdmR5Z01xM05SOFdVN3orVnBKb0hTTUl1?=
 =?gb2312?B?SmZsblZjeCsybTRyZ2FUK2h1UFkvOTY0M2xhMXNkQTlrbWFIaHV5NDBuZnkr?=
 =?gb2312?B?REkvOXBFc2NialIrWlZib1dRSHpXWlZwWVhUN2VwMGdLOEVBUUZrSWtRU1FR?=
 =?gb2312?B?Y3lFd1VselRocVZETHNQUnpXVjhGMXJzVTUreTJ5c3IxVVRSTWx5Rm9MYVp6?=
 =?gb2312?B?aEljcXhSekVUYkswZjRjeHkwNkkrMXNCUzcxOGE3VmRGenNKejZzQWgxcDZl?=
 =?gb2312?B?RjNVb1RrVE9mdjg3d3VIUnlFNTN5SHlFOG0yVDE2TkQwQWNkSzVwbEFyNWVy?=
 =?gb2312?B?OXZxbVMrWjl4MU1pRnprLy9Xa0FIVTk2eUZ1U2tkZnRRNkJqeWVPWGxJQ01q?=
 =?gb2312?B?UjE4TlZ4aE5TclE0VmUySGwvWWtQbmcvYThraUlJREJSc2tTS3dEWG9CQWRM?=
 =?gb2312?B?NnZ4M21mU29yU3lTY1lJNkZ3UlVPS3d2SkJyQWtPR3dHMTVpYUVvL3lpaW5a?=
 =?gb2312?B?K05vellyQkwzUGtkTEZ4Y0tsTFZFV2gvblVGSGpTQ3h2QTFTM1psaHBQcTZ2?=
 =?gb2312?B?RGVpSTdWK0oxelh6RzZ4QT09?=
Content-ID: <4C670D483360AA4AAEF094CA01B12621@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9053db81-f456-41c8-efa4-08d978eddcce
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 08:42:05.5249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2E/ESQwMqVXXNt3fvDGj3bc8qM5Lx1NDIabs7xSC5Pt4CDRiRvnZCifY1VcDgBAj8YF3My39nfiDtn0iiWjb/Q1R7WMhROrN80TB9EcFf84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4494
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/4] syscalls/dup2/dup205: Convert to new API
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
Message-ID: <20210916084205.MuWzn411dHKmwlr25aZTGftE4l99cYuCyEKr8CIpCIA@z>

Hi Qi
> From: QI Fuli<qi.fuli@fujitsu.com>
>
> Signed-off-by: QI Fuli<qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/dup2/dup205.c | 167 ++++++++----------------
>   1 file changed, 57 insertions(+), 110 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup205.c
> index 0b324531f..1f4796659 100644
> --- a/testcases/kernel/syscalls/dup2/dup205.c
> +++ b/testcases/kernel/syscalls/dup2/dup205.c
> @@ -1,134 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
>   /*
> + * Copyright (c) International Business Machines  Corp., 2002
>    *
> - *   Copyright (c) International Business Machines  Corp., 2002
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> + */
> +
> +/*\
> + * [Description]
>    *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> + * Negative test for dup2() with max open file descriptors.
>    *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>    */
>
>   /* Ported from SPIE, section2/iosuite/dup6.c, by Airong Zhang */
>
> -/*======================================================================
> -	=================== TESTPLAN SEGMENT ===================
> ->KEYS:<  dup2()
> ->WHAT:<  Does dup return -1 on the 21st file?
> ->HOW:<  Create up to _NFILE files and check for -1 return on the
> -	<  next attempt
> -	<  Should check NOFILE as well as _NFILE.  19-Jun-84 Dale.
> ->BUGS:<
> -======================================================================*/
> -
> -#include<sys/param.h>
> -#include<sys/types.h>
> -#include<sys/stat.h>
> -#include<errno.h>
> -#include<fcntl.h>
> +#include<stdlib.h>
>   #include<stdio.h>
>   #include<unistd.h>
> -#include "test.h"
> -
> -char *TCID = "dup205";
> -int TST_TOTAL = 1;
> -int *fildes;
> -int min;
> -int local_flag;
> -
> -#define PASSED 1
> -#define FAILED 0
> -
> -static void setup(void);
> -static void cleanup(void);
> -
> -int main(int ac, char *av[])
> -{
> -	int ifile;
> -	char pfilname[40];
> -	int serrno;
> -
> -	int lc;
> -
> -	ifile = -1;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
>
> -	local_flag = PASSED;
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		sprintf(pfilname, "./dup205.%d\n", getpid());
> -		unlink(pfilname);
> -		serrno = 0;
> -		if ((fildes[0] = creat(pfilname, 0666)) == -1)
> -			tst_brkm(TBROK | TERRNO, cleanup, "creat failed");
> -		else {
> -			fildes[fildes[0]] = fildes[0];
> -			for (ifile = fildes[0] + 1; ifile<  min + 10; ifile++) {
> -				if ((fildes[ifile] = dup2(fildes[ifile - 1],
> -							  ifile)) == -1) {
> -					serrno = errno;
> -					break;
> -				} else {
> -					if (fildes[ifile] != ifile) {
> -						tst_brkm(TFAIL, cleanup,
> -							 "got wrong descriptor "
> -							 "number back (%d != %d)",
> -							 fildes[ifile], ifile);
> -					}
> -				}
> -			}	/* end for */
> -			if (ifile<  min) {
> -				tst_resm(TFAIL, "Not enough files duped");
> -				local_flag = FAILED;
> -			} else if (ifile>  min) {
> -				tst_resm(TFAIL, "Too many files duped");
> -				local_flag = FAILED;
> -			}
> -			if (serrno != EBADF&&  serrno != EMFILE&&
> -			    serrno != EINVAL) {
> -				tst_resm(TFAIL, "bad errno on dup2 failure");
> -				local_flag = FAILED;
> -			}
> -		}
> -		unlink(pfilname);
> -		for (ifile = fildes[0]; ifile<  min + 10; ifile++)
> -			close(fildes[ifile]);
> -		if (local_flag == PASSED) {
> -			tst_resm(TPASS, "Test passed.");
> -		} else {
> -			tst_resm(TFAIL, "Test failed.");
> -		}
> -
> -	}
> -	cleanup();
> -	tst_exit();
> -}
> +static int *fildes;
> +static int min;
>
>   static void setup(void)
>   {
> -	tst_tmpdir();
> -
>   	min = getdtablesize();	/* get number of files allowed open */
>   	fildes = malloc((min + 10) * sizeof(int));
>   	if (fildes == NULL)
> -		tst_brkm(TBROK | TERRNO, cleanup, "malloc error");
> +		tst_brk(TBROK | TERRNO, "malloc error");
We have SAFE_MALLOC marco.
>   }
>
>   static void cleanup(void)
>   {
>   	if (fildes != NULL)
>   		free(fildes);
> -	tst_rmdir();
>   }
> +
> +static void run(void)
> +{
> +	int ifile;
> +	char pfilname[40];
> +
> +	ifile = -1;
> +
> +	sprintf(pfilname, "./dup205.%d\n", getpid());
we can move it into setup function.

Best Regards
Yang Xu
> +	unlink(pfilname);
> +
> +	fildes[0] = SAFE_CREAT(pfilname, 0666);
> +	fildes[fildes[0]] = fildes[0];
> +	for (ifile = fildes[0] + 1; ifile<  min + 10; ifile++) {
> +		TEST(dup2(fildes[ifile - 1], ifile));
> +		if ((fildes[ifile] = TST_RET) == -1)
> +			break;
> +		if (fildes[ifile] != ifile)
> +			tst_brk(TFAIL, "got wrong descriptor number back "
> +				"(%d != %d)", fildes[ifile], ifile);
> +	}	/* end for */
> +
> +	if (TST_ERR != EBADF)
> +		tst_res(TFAIL, "bad errno on dup2 failure");
> +
> +	if (ifile<  min)
> +		tst_res(TFAIL, "Not enough files duped");
> +	else if (ifile>  min)
> +		tst_res(TFAIL, "Too many files duped");
> +	else
> +		tst_res(TPASS, "Test passed.");
> +
> +	unlink(pfilname);
> +	for (ifile = fildes[0]; ifile<  min + 10; ifile++)
> +		close(fildes[ifile]);
> +}
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
