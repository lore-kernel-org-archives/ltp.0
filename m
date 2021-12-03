Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C91C433EF
	for <ltp@archiver.kernel.org>; Fri,  3 Dec 2021 03:18:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 988DD3C902E
	for <ltp@archiver.kernel.org>; Fri,  3 Dec 2021 04:18:00 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 274913C8137
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 04:17:48 +0100 (CET)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C4CBE1A00667
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 04:17:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1638501466; x=1670037466;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=PtBO/YcDADvrFYEdQvmvyT03P42Lu75q0i1n4+txy8A=;
 b=Y0Zh5om2gjnEzWx50gFhDFivd5/tK3BdoGbuQSwwhq57w7Qkh8HNrPeM
 Mdkmh6J1FVnzaCVLYmlliWx6W8qGmtq2aQ7TGRN4hw5MwziPiAcoSFOvO
 SJoVZXGBj5/umsX12zbl9ZWbbNFqFZdMCVyNlkGgMpBNutOjfrhYebLNl
 ZDH6WLChDpf4Ex/lkA9AQ45lohSiFXM2iqPb+5gwi83BA32zHpRwJSEse
 x/Aid/fpnCLh224PNgbjJ21Z8E+nqMe5NCLSPfyyK2hNELPBIojYpFkzx
 8B2m/JsL+CeJfiXAFEdNlHI7GFaSxW2ts7nwuyCIFbSP2b0HAHv/Gu0yD g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="45083371"
X-IronPort-AV: E=Sophos;i="5.87,283,1631545200"; d="scan'208";a="45083371"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2021 12:17:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHaUzWpDBpnQwoI4xmYJ4u0YMCtXTCmf5hefAazmJ15HGX4dF0M9vcHBpV1NpE9sOh2L3B3DbslErLMUa9VaPZ+f+nVhmf4Z0mqlP7Bte8cFU1LvIRhQaEor8OFzDUBRQ97gVe0Eo+hzgfmeTggTz40udgWR+6GW9IwVioe2ipMKn15WxRUnWRFlbQ1zqeqArgDLWfLAyygdRd4OSU1F+RoKhkVEi/q4UIoOccgHS680eqOdF8hAWzHHLEnQ+LoCXULsOiuLCOcry50nFltFtwQkZOPVOjLbi6Hsp2B7A8lFlsYxHVVHQPsXVDiZxsU8wesV+VB5TVPiaELRuWSlQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtBO/YcDADvrFYEdQvmvyT03P42Lu75q0i1n4+txy8A=;
 b=OwACFaUIArd6LVBz59qDgB2kBvkZOIyPiC27spwIiaw4Lq2nzYJHbOB/8XZ3NHhPTIAmbfJ5suPIWFI2xNZgrdy1qe66aSgRbRLHbfiRvYl0OhJQJor2WCGLS+amFPgfhk8b60sVXoJlgWkw+iWrjhQZkyf5HEuVrT9aAk8pRtdeoJ2N63usPW77YoJBKI/jUur72jBAwpOmJkSsNF71+CwYT1IZ1KSffbYrmIcBL5tt4eedM2wjwv/Wz4NwoBi9M/gCg9onjdiJ5B97iJJ327AkKa7cnEpjgV+g0Pcy3WC/hzNRzDtptaWdxbSPzUhLnDmuHQdgsmdcCnug9UK6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtBO/YcDADvrFYEdQvmvyT03P42Lu75q0i1n4+txy8A=;
 b=JY7Pzh4WA7vqH0lKcllG12JAEtgWFsG7rX+jFlEzGdcRtYfFB4dMdJtYYMABNxBmzqCf6FkS2qIAKaLxTLuEOSwx3K6xntXDBv+4jmziY9roWpTomgfi/hv03D8xXzyT+vrtOs/cdzOb1LO0fCmAx/PBZcHO0Pu+JWR13cIRJ0c=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB4364.jpnprd01.prod.outlook.com (2603:1096:404:10c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 3 Dec
 2021 03:17:41 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4755.016; Fri, 3 Dec 2021
 03:17:41 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "daisl.fnst@fujitsu.com" <daisl.fnst@fujitsu.com>
Thread-Topic: [LTP] [PATCH] syscalls/pwrite04: Convert to new API
Thread-Index: AQHX519N0zA0fs5cgUSnKSmxNBiS46wgGgeA
Date: Fri, 3 Dec 2021 03:17:41 +0000
Message-ID: <61A98C6D.7090208@fujitsu.com>
References: <1636762161-26777-1-git-send-email-daisl.fnst@fujitsu.com>
In-Reply-To: <1636762161-26777-1-git-send-email-daisl.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07ad65c6-b341-401c-847a-08d9b60b775b
x-ms-traffictypediagnostic: TY2PR01MB4364:
x-microsoft-antispam-prvs: <TY2PR01MB43645BBFC2FF6305BECE8E1AFD6A9@TY2PR01MB4364.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p94B+Ts4fn74NOF7aEtjMpNlLUY66CIORIZMv6gNwG1/SVA+Nw+Ha50jOqz0/u67r+XZJJh1wJu2Qme2N+TLepQMo44+zd3HxphsKVu2KJbUTkoVV1bZPWru+gTynv8PMScFGtfRQKnkd4QiIrajvLr6Ux8GLtP7ANJOpczLnpW4wm9eDaqXYfYIzIRay0tGv6+IgMhc5jVGa1NeFtWQEznou2+Oxj1gfzQ7uUbMrtV9PlvxyQxXKbPAj+s/O59MzUojYEPp3RZYLvfQFgqZttfsMwIuxKGZnk2ASZ7k5bk866iPjjiJYCN9iv/GRFEET+RNJEfvcvhWtHEd/UPGFX4SHUcQah7mj01BRPhsEgBwsUD5dclDyXqoI7BxUf5cjATXfNjKmPzvdKamd/9gbbWWYHt0p0oK/IYombk5POW7+w0jSkSVJhmA8ZYKK2fxReYCzhblnrFW+MAVJAh6y8x6D62GrD25KGdclwH7d082RKA06D1vZv38b+y7b0tHLXAXCrKKSozu1IhvPgcwctctDSOSwPhG1yuU8WeiRNzQGp9SqER84SQsv0SxAHpIJjw9PV/Ojz/5b9GluIcrH5pgZqBN98XYagjSTDYtVkApjzNQXOjqN+5g+cWsQ3tSd30PwfrIiVnDN7aXn4hNv+xMIwLKj1qKqaGCd2Cbf0DqbZYjGWdrEe+uwJHjV5Rzye673ti4xhK6IzVd5ulHo4HaK2wL0dPE1Fckt7y+FxE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(66446008)(66556008)(66476007)(64756008)(91956017)(38070700005)(186003)(76116006)(6506007)(8676002)(8936002)(83380400001)(6512007)(26005)(36756003)(85182001)(2616005)(508600001)(33656002)(87266011)(38100700002)(37006003)(5660300002)(71200400001)(6636002)(82960400001)(6486002)(2906002)(122000001)(4326008)(316002)(86362001)(6862004)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VG5HYlNRWmU0S1U1d2pLWGhLUENCYTZpaVFmTWd2bGI0S2xKMEdOdEN3Skw1?=
 =?gb2312?B?amNCUkZ4MmMxeUdqRHNTQmRtcGhQSU5KOEpoV1NHSjg3Rmd5L3dMelk2SlJ1?=
 =?gb2312?B?WHFlY2c1dXdIVWRNNDlBOTdDemYwOStJcFZOSk5ZQ2luMFViQm1IZHUwaFFa?=
 =?gb2312?B?UzRKZlNMQ0xTZmVjRGhpN3N3eHhTUFp4bTdRTUZjWDArVFNvWGxXbnYvVHl4?=
 =?gb2312?B?ajVDTkEyNGY1eUIzR0tlL1p4WXhtUTUzak1ueHJEVzdzWHJ6VmpEaDJOemlE?=
 =?gb2312?B?WnliNWljMGRHVFdSZnVJK3J5SUhXaXlIVnp1U1l4RUt3cU9SVmdCd0dZUk5D?=
 =?gb2312?B?b0VzQkt4Z0F5T0NZaXB5VU0vbC9GY3NPd1I2MTA0T3U4bldyZG9wTTAyblNW?=
 =?gb2312?B?WXBBS1E2SWlnRmtYSnJjN05FOGNiOERjL1d4SnE2NUtmQk9qVGd5OE50MmJY?=
 =?gb2312?B?SUcrZmh2eFViMVFpRmVzT1U5OEpzdDV0aHRQblphbGpZVlZVcjdBV3F0OFQ5?=
 =?gb2312?B?K29aKzVINE5KMko0czk3cVlxNGVTVDd0YzRIcStHVlFYT1dCRHNpeHBjT2RT?=
 =?gb2312?B?SmFDSkxQR1c1eEkvSS95eTYvMGFUU2J4N0t1WDczSjQrTWl3Qkphb1k1d3hi?=
 =?gb2312?B?eHBLc0NnTTR5ZW54OGQ3VjlCdDh2ajh1cWdCdUhzcEFVMnE0LzFTUFRCV3hw?=
 =?gb2312?B?MGd1Z082TnN0dkYxaHNlclllVDBLaVpMdnMyZGh3ZGRaSFVQSmE5MG1OL3h0?=
 =?gb2312?B?VFlHbE02Tkx6Y0NGSDdEVzF1NEtTQnhLRm90VUhObGVGckhncVZEbW1GWm9L?=
 =?gb2312?B?azNpMGhGNThEZk9jTENSeUVBZkZMSFhDNmpaaDhEK0YxeVJuZmU3VzQ5c3dj?=
 =?gb2312?B?c1NoM2UrTXcvTFNBcnpTOVV0dzFkL0FvK3ZRUmErK1ZheGRZYjFhbmIrT0pZ?=
 =?gb2312?B?YlJGQVhnejdUZ2VMdkVnbmlwRDhDTTA1aExKNVJrY2NJcVU1QThyTWNHTVJU?=
 =?gb2312?B?OFArTCtNMjhNRFc2cC8wN09xMTM0RXY3OGt4akFKRlhuQWxiODBFL05aTE5a?=
 =?gb2312?B?U2F1YmxmaThHV3ZuM2NkbTNsT2s5N3l5cXZabElBcXRIN2VDNnhFTFQxcXVa?=
 =?gb2312?B?SGFtQ0R0N0FKMm5OK1JCYzBEQ21jTDR6Ylg2Rm9wMG1MdDhzWU9lKy9WVWZY?=
 =?gb2312?B?U1ExdW5QUHNCaVlZUEpLUCtnV2xUb2NBVjBhNk03QzRacStIVDdJdll2TmQy?=
 =?gb2312?B?blI2WFZyMnNBZWUyNzZMbTFPL3JqVnhzUE45ZkhIbVo2UFl4UmJBYk9uNzZw?=
 =?gb2312?B?ajlVM2dUdUZ2Qld4Y3FBZUI2N2xVeVg1YVoxSEN0bjZhZ1VENVM3T3VPY2RY?=
 =?gb2312?B?T3pKNTNVQzM0dzB0bnlML0M2dUU4OTQwc1Y2RURRblIrREc3Rno5RFVJR2Rp?=
 =?gb2312?B?QWJ3aW45c1FJeW45K0duVUFEQVFYWHlhVm5iMjd1eDJCaVJZSmE2bDFqaDg0?=
 =?gb2312?B?Q2U1cmRGUmRSd1BBWk9zQWRqblRLRnZQdVFEVHRKQXNzOVJSbjJvdjRaTTVH?=
 =?gb2312?B?dE4wbnZLajUwNm9Uc0hlTlNSUlFZQ1Q2OTJRUzN3b1l6VkVJekpXTXpYelpl?=
 =?gb2312?B?U2hTWUZkNUFYWGdhNkdmRUgvay9vU2Znc0NOTzR1aVNPZmZYd1dUQXY2NVhC?=
 =?gb2312?B?ZnlzRnd4ZEdRVWhLVktKRmMrS3pUYUVVdjZhOE02L1BxOGYxRUp2dTVIWFZJ?=
 =?gb2312?B?cThybFN1MTNocU45dE04US9nbjFGZkdzd3RXUGVCUG1kMXZlbTVsQVJuNkZG?=
 =?gb2312?B?T0dMNWxaOWRsYmlKQTd4VHd2S2xMK3JoSzBpdGJpa2ZybWxJZ3RuZkh1c0NR?=
 =?gb2312?B?UWxSVTVaa1JIWGZTQ0M2TTh1VFhwaENxMjVHT0xHUi9kM3l3VnRBMmM1bk9t?=
 =?gb2312?B?cWl5d1NkM1FTemUrdStMVFNsbUFjMHNjc0kxNkFyKzNJa1FXTWsrWUZURzFC?=
 =?gb2312?B?LzYwM0NaSEtoZGhXWUlGM2tEUG1zdVZMWDFYbjUrallKTG9jak5sYk9aTGl6?=
 =?gb2312?B?emp0L29pVjFOY3ppMlhZeDRWMlFodjRBdWJ5UHd0QVpzZ0h2aVpnRWlZSTJq?=
 =?gb2312?B?SEY5a3pwejM3aHhpRHhxMDBxWlBRdFdYQ0dWbVB2L1hhcFl4Y3ptUUpaSlhK?=
 =?gb2312?B?MVREZFVjYkRoWTlxZ1NjNXZTcFJFZit3b0NBQU84cTc3V1lEeWpmVXYyNk8r?=
 =?gb2312?Q?53x8FoF3R0SnCXcGfDLC3e5Uq8qxQYhCRVNcf7bFXQ=3D?=
Content-ID: <231B01FC40045A468FE2B00D2CA22563@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ad65c6-b341-401c-847a-08d9b60b775b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 03:17:41.1663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e+uiyCJ1aKmyhdAE1naq5p+1JRNZkEEVmrUpgHNegAUb+fXmA1ueyElZa4Wh1R92ob1i8Il8FsR6rHQ+Sxr6KBC0A+K059x2NidAyjFcmrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4364
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/pwrite04: Convert to new API
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
> 1) use SAFE macro
> 2) remove useless write() operations
> 3) simplify pwrite() operations before using O_APPEND
Thanks for your patch, merged with some minor changes.
1)use PRId64 instead of %ld in l_seek
2)use TFAIL instead of TBROK

Best Regards
Yang Xu
>
> Signed-off-by: Dai Shili<daisl.fnst@fujitsu.com>
> ---
>   testcases/kernel/syscalls/pwrite/pwrite04.c | 307 ++++++----------------------
>   1 file changed, 66 insertions(+), 241 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/pwrite/pwrite04.c b/testcases/kernel/syscalls/pwrite/pwrite04.c
> index 4a2825b..2b5ab35 100644
> --- a/testcases/kernel/syscalls/pwrite/pwrite04.c
> +++ b/testcases/kernel/syscalls/pwrite/pwrite04.c
> @@ -1,267 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2002
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
> + * Copyright (c) International Business Machines  Corp., 2002
> + * ported from SPIE, section2/filesuite/pread_pwrite.c, by Airong Zhang
>    */
>
> -/*
> - * NAME
> - *      pwrite04.c (ported from SPIE, section2/filesuite/pread_pwrite.c,
> - *      	        by Airong Zhang)
> +/*\
> + * [Description]
>    *
> - * TEST SUMMARY
> - *	Test the pwrite() system call with O_APPEND.
> + * Test the pwrite() system call with O_APPEND.
>    *
> - * USAGE
> - *  	pwrite04
> + * Writing 2k data to the file, close it and reopen it with O_APPEND.
>    *
> + * POSIX requires that opening a file with the O_APPEND flag should have no effect on the
> + * location at which pwrite() writes data. However, on Linux, if a file is opened with
> + * O_APPEND, pwrite() appends data to the end of the file, regardless of the value of offset.
>    */
>
> -#define _XOPEN_SOURCE 500
> -#include<stdio.h>
> -#include<sys/types.h>
> -#include<sys/stat.h>
> -#include<unistd.h>
> -#include<fcntl.h>
> -#include<memory.h>
> -#include<errno.h>
> -#include "test.h"
> -
> -char *TCID = "pwrite04";
> -int TST_TOTAL = 1;
> -int local_flag;
> +#include<stdlib.h>
> +#include "tst_test.h"
> +#include "tst_safe_prw.h"
>
> -#define PASSED 1
> -#define FAILED 0
> +#define K1              1024
> +#define K2              (K1 * 2)
> +#define K3              (K1 * 3)
> +#define DATA_FILE       "pwrite04_file"
>
> -int block_cnt = 0;
> +static int fd = -1;
> +static char *write_buf[2];
>
> -#define K1    		1024
> -#define K2    		(K1 * 2)
> -#define K3    		(K1 * 3)
> -#define K4    		(K1 * 4)
> -#define K5    		(K1 * 5)
> -#define	NBUFS 		4
> -#define DATA_FILE	"pwrite04_file"
> -
> -char name[256], fname[256];
> -
> -void init_buffers(char *[]);
> -void l_seek(int, off_t, int, off_t);
> -static void cleanup(void);
> -
> -int main(int ac, char *av[])
> +static void l_seek(int fdesc, off_t offset, int whence, off_t checkoff)
>   {
> -	int fd;
> -	int nbytes;
> -	char *wbuf[NBUFS];
> -	struct stat statbuf;
> -	int lc;
> -
> -	strcpy(name, DATA_FILE);
> -	sprintf(fname, "%s.%d", name, getpid());
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	tst_tmpdir();
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		init_buffers(wbuf);
> -		local_flag = PASSED;
> -
> -		if ((fd = open(fname, O_RDWR | O_CREAT, 0666))<  0) {
> -			tst_resm(TBROK, "open failed: fname = %s, errno = %d",
> -				 fname, errno);
> -			cleanup();
> -		}
> -		/*
> -		 * pwrite() K1 of data (0's) at offset 0.
> -		 */
> -		if ((nbytes = pwrite(fd, wbuf[0], K1, 0)) != K1) {
> -			tst_resm(TFAIL,
> -				 "pwrite at 0 failed: nbytes=%d, errno=%d",
> -				 nbytes, errno);
> -			cleanup();
> -		}
> -
> -		/*
> -		 * We should still be at offset 0.
> -		 */
> -		l_seek(fd, 0, SEEK_CUR, 0);
> -
> -		/*
> -		 * lseek() to a non K boundary, just to be different.
> -		 */
> -		l_seek(fd, K1 / 2, SEEK_SET, K1 / 2);
> -
> -		/*
> -		 * pwrite() K1 of data (2's) at offset K2.
> -		 */
> -		if ((nbytes = pwrite(fd, wbuf[2], K1, K2)) != K1) {
> -			tst_resm(TFAIL,
> -				 "pwrite at K2 failed: nbytes=%d, errno=%d",
> -				 nbytes, errno);
> -			cleanup();
> -		}
> -
> -		/*
> -		 * We should still be at our non K boundary.
> -		 */
> -		l_seek(fd, 0, SEEK_CUR, K1 / 2);
> -
> -		/*
> -		 * lseek() to an offset of K3.
> -		 */
> -		l_seek(fd, K3, SEEK_SET, K3);
> -
> -		/*
> -		 * This time use a normal write() of K1 of data (3's) which should
> -		 * take place at an offset of K3, moving the file pointer to K4.
> -		 */
> -		if ((nbytes = write(fd, wbuf[3], K1)) != K1) {
> -			tst_resm(TFAIL, "write failed: nbytes=%d, errno=%d",
> -				 nbytes, errno);
> -			cleanup();
> -		}
> -
> -		/*
> -		 * We should be at offset K4.
> -		 */
> -		l_seek(fd, 0, SEEK_CUR, K4);
> -
> -		/*
> -		 * pwrite() K1 of data (1's) at offset K1.
> -		 */
> -		if ((nbytes = pwrite(fd, wbuf[1], K1, K1)) != K1) {
> -			tst_resm(TFAIL, "pwrite failed: nbytes=%d, errno=%d",
> -				 nbytes, errno);
> -			cleanup();
> -		}
> -
> -	/*--------------------------------------------------------------*/
> -
> -		/*
> -		 * Now test that O_APPEND takes precedence over any
> -		 * offset specified by pwrite(), but that the file
> -		 * pointer remains unchanged.  First, close then reopen
> -		 * the file and ensure it is already K4 in length and
> -		 * set the file pointer to it's midpoint, K2.
> -		 */
> -		close(fd);
> -		if ((fd = open(fname, O_RDWR | O_APPEND, 0666))<  0) {
> -			tst_resm(TBROK, "open failed: fname = %s, errno = %d",
> -				 fname, errno);
> -			cleanup();
> -		}
> -		if (fstat(fd,&statbuf) == -1) {
> -			tst_resm(TFAIL, "fstat failed: errno = %d", errno);
> -			cleanup();
> -		}
> -		if (statbuf.st_size != K4) {
> -			tst_resm(TFAIL, "file size is %ld != K4",
> -				 statbuf.st_size);
> -			cleanup();
> -		}
> -		l_seek(fd, K2, SEEK_SET, K2);
> -
> -		/*
> -		 * Finally, pwrite() some K1 of data at offset 0.
> -		 * What we should end up with is:
> -		 *      -The file pointer should still be at K2.
> -		 *      -The data should have been written to the end
> -		 *       of the file (O_APPEND) and should be K5 in size.
> -		 */
> -		if ((nbytes = pwrite(fd, wbuf[0], K1, 0)) != K1) {
> -			tst_resm(TFAIL,
> -				 "pwrite at 0 failed: nbytes=%d, errno=%d",
> -				 nbytes, errno);
> -
> -		}
> -		l_seek(fd, 0, SEEK_CUR, K2);
> -		if (fstat(fd,&statbuf) == -1) {
> -			tst_resm(TFAIL, "fstat failed: errno = %d", errno);
> -
> -		}
> -		if (statbuf.st_size != K5) {
> -			tst_resm(TFAIL, "file size is %ld != K4",
> -				 statbuf.st_size);
> -
> -		}
> -		tst_resm(TPASS, "O_APPEND test passed.");
> -
> -	/*------------------------------------------------------------------------*/
> -
> -		close(fd);
> -		unlink(fname);
> -	}			/* end for */
> -	cleanup();
> -	tst_exit();
> +	off_t offloc;
>
> +	offloc = SAFE_LSEEK(fdesc, offset, whence);
> +	if (offloc != checkoff) {
> +		tst_brk(TFAIL, "%ld = lseek(%d, %ld, %d) != %ld",
> +			offloc, fdesc, offset, whence, checkoff);
> +	}
>   }
>
> -/*------------------------------------------------------------------------*/
> -
> -/*
> - * init_buffers() allocates wbuf[] array
> - * as follows:
> - * wbuf[0] has 0's, wbuf[1] has 1's, wbuf[2] has 2's, and wbuf[3] has 3's.
> - */
> -void init_buffers(char *wbuf[])
> +static void verify_pwrite(void)
>   {
> -	int i;
> +	struct stat statbuf;
>
> -	for (i = 0; i<  NBUFS; i++) {
> -		wbuf[i] = malloc(K1);
> -		if (wbuf[i] == NULL) {
> -			tst_brkm(TBROK, NULL, "ib: malloc failed: errno=%d",
> -				 errno);
> -		}
> -		memset(wbuf[i], i, K1);
> -	}
> +	fd = SAFE_OPEN(DATA_FILE, O_RDWR | O_CREAT | O_TRUNC, 0666);
> +	SAFE_PWRITE(1, fd, write_buf[0], K2, 0);
> +	SAFE_CLOSE(fd);
> +
> +	fd = SAFE_OPEN(DATA_FILE, O_RDWR | O_APPEND, 0666);
> +	SAFE_FSTAT(fd,&statbuf);
> +	if (statbuf.st_size != K2)
> +		tst_res(TFAIL, "file size is %ld != K2", statbuf.st_size);
> +
> +	/* Appends data to the end of the file regardless of offset. */
> +	l_seek(fd, K1, SEEK_SET, K1);
> +	SAFE_PWRITE(1, fd, write_buf[1], K1, 0);
> +	l_seek(fd, 0, SEEK_CUR, K1);
> +	SAFE_FSTAT(fd,&statbuf);
> +	if (statbuf.st_size != K3)
> +		tst_res(TFAIL, "file size is %ld != K3", statbuf.st_size);
> +
> +	tst_res(TPASS, "O_APPEND test passed.");
> +	SAFE_CLOSE(fd);
>   }
>
> -/*
> - * l_seek() is a local front end to lseek().
> - * "checkoff" is the offset at which we believe we should be at.
> - * Used to validate pwrite doesn't move the offset.
> - */
> -void l_seek(int fdesc, off_t offset, int whence, off_t checkoff)
> +static void setup(void)
>   {
> -	off_t offloc;
> -
> -	if ((offloc = lseek(fdesc, offset, whence)) != checkoff) {
> -		tst_brkm(TFAIL, NULL,
> -			 "(%ld = lseek(%d, %ld, %d)) != %ld) errno = %d",
> -			 offloc, fdesc, offset, whence, checkoff, errno);
> -	}
> +	write_buf[0] = SAFE_MALLOC(K2);
> +	memset(write_buf[0], 0, K2);
> +	write_buf[1] = SAFE_MALLOC(K1);
> +	memset(write_buf[0], 1, K1);
>   }
>
> -/*
> - * cleanup() - Performs all ONE TIME cleanup for this test at
> - *             completion or premature exit.
> - *
> - *	Print test timing stats and errno log if test executed with options.
> - *	Close the testfile if still opened.
> - *	Remove temporary directory and sub-directories/files under it
> - *	created during setup().
> - *	Exit the test program with normal exit code.
> - */
> -void cleanup(void)
> +static void cleanup(void)
>   {
> +	free(write_buf[0]);
> +	free(write_buf[1]);
>
> -	tst_rmdir();
> +	if (fd>  -1)
> +		SAFE_CLOSE(fd);
>
> +	SAFE_UNLINK(DATA_FILE);
>   }
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = verify_pwrite,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
