Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF04C43334
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 01:29:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71AC73C94FD
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 03:29:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 425FC3C81F1
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 03:29:17 +0200 (CEST)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0EDDA600D31
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 03:29:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1657157355; x=1688693355;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=MyZnpUjT2Q5Cfawxy1EjPb1SL6E0yshZ3UpyKtEsI9E=;
 b=NaOpoVX01uVDWWmzcuclulREbmMqBaM8rYyQbRQy4F6ywH5969OPeRrH
 +NqUVinujG4rf64n29Z/r16bfRfY5H9G3jwTcMl+c4le+BWchgJ1Gn1aS
 RHjDEJJNIfWJNIpXyJnPzFC4vWn9djP851dwi7npAAuvUMT275WFHrtQx
 XtYZ5R0pJfcCEFCj+TyGszmMglKcserkE8yogXVgtUpHAZOpjVDkZMCJ0
 +08PyEtu/0MhFIfsb7mMqbfCenJHQou5xdoQlPQiPPoPbguGfm/T/gph4
 mZC0j1iyXCndDzIiAZNDN1Hbpf/5ck3+3YgkuRgs019S53Qpp42N0qivC A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="67889526"
X-IronPort-AV: E=Sophos;i="5.92,251,1650898800"; d="scan'208";a="67889526"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2022 10:29:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIRTMefasqTaRw3wBxOXYT0dnczWLWisW8O3nxaFQSfr8IMb5vv+fTVXxLjooVS+rmfXqEcHPKrBmfeSbDZ7CkBgkXn6rkaBOwBj8vYYY9d57J0IulybpshNRB9SoqbOcOZ1wOYdGj3ezUovYxoHwiJQAsitFwq7YmzQxGZIKuQrf1pMo8o8ZSYC6cn3Zjkn5K8LW5GCoj7rt+V6L0mTw9/yOJ6d/M6QDaDJZZUpuIDr5MdGc2SWGY1KCvO1CJC06YxQESD+REw6i/F609900n0NgStSj9JBu8wWWHRwV8p1m3a7lJCKhE7e8KI2XwK6HGDvtV5sV0SVoTbU8UFb6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyZnpUjT2Q5Cfawxy1EjPb1SL6E0yshZ3UpyKtEsI9E=;
 b=lZzL5pLrTVZqgDEkVByvTxVcW32S6ReRXXyBx3/Q/5eOZmFVJOr1EKnutnuTjowHpuCh+i62rf45ytMvFpR5sQrjVxz5kFLBymYAwmEwoBwM2SDQ6prB2mz4X50h2od0qYY+Agv/ISjeB2D/1tlwmlhrRZWINfz3xfL6P5KrrfDFMJb9aWPhvC1MlmC7hziKHutPbdlRKpID+1HtBKGNaIn0XIuqBNIIKpS8WvExHT9X/UDNlvm/6uihankrT1y0TXVBiK7/3pdxsnMuHJTCrkQEiQ71tzSWKVS6N7LVjvdUXcw+b0JaAKg/y/A8TxIahc38NrZgdIYYArMQO0uJsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyZnpUjT2Q5Cfawxy1EjPb1SL6E0yshZ3UpyKtEsI9E=;
 b=C7UN3ZlcfQGUFIB0lWhiml1zLvf54jzFYzttj1rAN7ln5GZB2UV6Ghml+xPfvUVVLQrr6cQa7ssUKz13KIlSeSoXad5mvgVjEzglwazkN6YxniqamL/KE6fdMzufOH7E9fhSotnViRiPVrNL1v2Qbw42UTYcdArkqm2T2ABsjbQ=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB3615.jpnprd01.prod.outlook.com (2603:1096:404:c0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Thu, 7 Jul
 2022 01:29:10 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160%5]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 01:29:10 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Avinesh Kumar <akumar@suse.de>
Thread-Topic: [LTP] [PATCH] dup07.c: Rewrite using new LTP API
Thread-Index: AQHYkVFBP8crJI0m40uvffiPrPUZPa1yME+A
Date: Thu, 7 Jul 2022 01:29:10 +0000
Message-ID: <62C6452F.907@fujitsu.com>
References: <20220706155817.28340-1-akumar@suse.de>
In-Reply-To: <20220706155817.28340-1-akumar@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc11771a-5502-4811-8112-08da5fb817e1
x-ms-traffictypediagnostic: TYAPR01MB3615:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h7AkFNWTYmWwAwht5zsIsQgfx5DdfR8Yxhp5ViBKc66OdiDwCx+9DEneJtZIgsYmNDccC8NZ57TEB1QrQrvnf0wzucIhAPeJ0zgvZ6FuXrVIIWd6UZUk4AugDs22XrPF2LaGB/Ixcoz5mNfG23PlFVlUNinB7SA0aoaI6f+N5SNErssLuan8ZLYp1vtMGFUoBS6w4kBeAXiGt4qTUvc6AtIBuNKGF8LNuIT7LPtZ8vqZqEAfyaR24r7Fzto722ohwFj/slY7nLeU0labzCA6qLVPfHyb+QNoVdesueAB7r4oL83JFjNYADFmM8Dibk0+RkTso3ULzp/nB5gaioY2uuqf87vnh9shOGsE/GGafrgad0CA7r4XVqDEZ6dBJc6Bf9Mo+/qAPC+eX/oMFz4PvqoYr9fOkiO2vEjcTJ7MFBOt7VkqEBU37j92cMJBbcPYKnwRMrn2xhuEuc4akoel43mkM1yZpsemf6bn0oJl2y9GtiSTwkSniBvi4UfnGuDq/p3R+3noNfvIDcehMkUDpSz43nTZ426WGZWF3Al0fKEA1aYCJWeXnEgsmxk8NRcyxqCsg/KDQb1v5at7vRxmpnmGPZ7FduvcImn9bqAoN38EHx9OwnUsZSzhZRGaf9+vQqNu2GBkwimWNmN7klep4+3hgVtPL7xQC9maI08HM3FvGAIaZpT5rorNATttSJwXiBmXs7IJfiAWFvQJIRZQ9H9mCQXxO6TZ0Z26ZsWRCfEaxZDwaEaJUNqwFEn9HLPTmLl97AI/qlRG8KCnjQCKuHCLPgS7ehAzyNBcFxNZx3uCxuoG2nILcgxB/f6SnCEYK7qFu8RMxz3SeF4K0oLzOw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(41300700001)(122000001)(478600001)(26005)(2906002)(82960400001)(8936002)(33656002)(5660300002)(85182001)(71200400001)(6486002)(66446008)(4326008)(38100700002)(64756008)(76116006)(66556008)(91956017)(66946007)(66476007)(6506007)(36756003)(86362001)(8676002)(6512007)(83380400001)(38070700005)(186003)(6916009)(316002)(2616005)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZnZvNzZ6WSszZEdTYXpyUDgxdEVwdktuNHpwaDlvSk9yZWFSWU1ZQ2tYWE5q?=
 =?gb2312?B?VGc0QVZRM3UrMmZZR24vcVIwNVNZTTRlODM2d2o5L2ttaGVTdDFld2xDUUZo?=
 =?gb2312?B?QlZNU1BrOW0rK0lnd1VpM0h0MXRvSDFuZEJBeldUUW44T1V3MzdIenA5eHo3?=
 =?gb2312?B?dDRuSFZINTdlejQwZWVMY2FTQkhOT29NYTlOYzFrZjFSWGhURDJQL3VKcGRz?=
 =?gb2312?B?SmNtanlobTNOTmIrazh5RHk1OG4yS0xQSjJyZW8rcmp1dk1OWnlqVm9FUlhF?=
 =?gb2312?B?L0l3NGNjRVBCejdaU2YvYjlheTFnQVZaRGU2VURNN2FmN1BZd1pDSGc2SXJi?=
 =?gb2312?B?Q2picHhvZmFLRW1KWlBVTjhyc0F2YitHNFR0RGxyeWI4MUxxYlB3bE80YStr?=
 =?gb2312?B?SUZHWUJmRG9PWjE5ZjNQN0dBK0Nna2FkM0ExWmJwZG8vb3BXdVJoR2VKVE5i?=
 =?gb2312?B?U3hsODVodGlIOWhVcjRrOUZBdVQ0L0NNQ1pyT1N4aUFTWS81MERJdmVxdDdS?=
 =?gb2312?B?cFdwZHVyUzVMTVZKbHp1Z1hWOUFJVXRyM1NERnB3dXViejlSOGk1eEVSK0FV?=
 =?gb2312?B?ekV5dUdzd0xTUmFSbDZOWmZ0MTYwbzNtSEZhOC9BV3RwK0trYzhrSmpweXBV?=
 =?gb2312?B?c1dMSTg3eFVxdkVxL0ovWW1GQTFBNUN4NytEY3d5R005TmNMb2w2ZFZUZzNU?=
 =?gb2312?B?UmU5Q2Q3RnJWQlRNbzlmeGkzS3hvaDhJTENXZTdMeDhNSm5XcWlST2RsRDJm?=
 =?gb2312?B?VVZJZExISndjVGRQK282cTdDWjdaN3RmbjM5eDcvVnY4ZkY4N0lnRmptZzZW?=
 =?gb2312?B?SndwWW9kNysycnUrT2xNQ3RzRTRkMUxOakhoNEhhcVJTZUxjNDRxUzA2Mlly?=
 =?gb2312?B?bHlqTDZRQ0R3SldtcmpFNWVEZVhsWDcvWW1GV0dYWEZKcGJoRnRtOXZrZm04?=
 =?gb2312?B?UEtMcjNhcHUzQ3d2VHJpMjk4K093UHlGbTdhc1NweUYzLzdhZ1o2dnNOOEY3?=
 =?gb2312?B?dDJLUVV0WC90Yjk0ajN4VlRTU3dBK3RyN0dDTmlraEY5eHdiTVBxeGZidlAv?=
 =?gb2312?B?N05EQWd5SjFxNEZMckpFWng1YndKWmN0U1g1d1l6ZHFoekZXdGNvL3krK2FL?=
 =?gb2312?B?TEZhV0RsQkdSclJMTnpOSUlmbWtKWnNMMjFENXA1MEdRd2tLUUNXTjNCWTFu?=
 =?gb2312?B?am93K0ZEb3lyRnB2VS9XcEJFUTNUVklNV1BDQXRFUGZVZDBjT1hlOS9aL2My?=
 =?gb2312?B?K1lTNDJUcG9MNVVYZGVnQnJBQ3AzMWFXT3IrRmJ1N1VKc28vSkpxblBWUnI5?=
 =?gb2312?B?c0xhQUtsSGJ0SnZPTGlkSEZQTjE4WWhFUkc0bUhqT2ZCT2hkeXY1a01pRmRi?=
 =?gb2312?B?TURCZWxiRDNyYit5MlY5ek1jUlRib0Q0eSsvUTM2T1d5VGF0R0ZQNVFFU09w?=
 =?gb2312?B?MjR4cFcwR0hURHNobE0yWlUwK1FTOGZneFNrZEI3eVJ1RnhCbUV1YWhTRFZD?=
 =?gb2312?B?NFZnVUxZdWVpMWZTTnREQ3Q0OEJKaU1RektURlY5bTN4OUt3MjdKa3QyQkww?=
 =?gb2312?B?UHlmVDRPYjA5WWNvWS9naWRzQXdRL2k5NVg3dzdzZTBLWE9id0dabmlnWDZi?=
 =?gb2312?B?REtKZEhFbWV3dytQbktzQmNOUWRXNVNJcnBuRmswNmRvbGNyMzVOdDlVeUpX?=
 =?gb2312?B?cndOTmI1ODE1Z0JmR0M2WW5zVXNOUzc1aTF3MlRaME54RG1IYzRUQXpwTjNS?=
 =?gb2312?B?ZHc5bEpWSUdjeGViVkxUREU3eHk0Zll0OXZDNTBJUUNmNGVhMWFacDV4eFFa?=
 =?gb2312?B?YVhObFMvdVN0YndhSjc1OGV0WjVLb2UrNjBtL2haa1YvRXpUK3NUYjMxcFhX?=
 =?gb2312?B?d2VGS0R1TmR6ckU0YVFxeHBPZnI4NTkvWVlkNkV3VlpOS0k4UFpWaStLVit5?=
 =?gb2312?B?VDhraTdXaW5aMGw4TUV6YU9jZ0VjR2JJajdSOEZ6Tm9kOG9UMEg3aStiK1Br?=
 =?gb2312?B?MDloKyt4eVRpTWJUdURwTFllNXN4OUxWV0VMS05WNVFNRFcwVlZLNE52c21P?=
 =?gb2312?B?S0xYbWUvaUpCZ1ltR2ZjT3pPRHNEZnlnbGFLOFJHdTNKWFlQaVdCc05xZ2o1?=
 =?gb2312?B?amdNc2IwdUtyRjRnTzdOMCs1aVUrQ0hUWUNHYkpRTUZObXEyTTFFTnZLS1ZE?=
 =?gb2312?B?d0E9PQ==?=
Content-ID: <315EE15BFFE1E244AA4DE460E32C8D3C@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc11771a-5502-4811-8112-08da5fb817e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 01:29:10.5153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ytwgHLjNijZ0VyRzVNnaCPvTHF8Md4YKqUPmjcXq1CVHPLUxqyL+Z1PHvaSvqu+V+51tErtK7cjZ7AtRspJBBv5+O1B09n7nX6fJeo8tYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3615
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] dup07.c: Rewrite using new LTP API
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

Hi Avinesh

I did't look this cleanup patch, but I see the old code is same as 
dup202.c(This case covers more situation, ie using chmod). Maybe we can 
just add a test_variant to use dup  syscall in dup202.c?

Then remove this case directly.

Best Regards
Yang Xu
> Signed-off-by: Avinesh Kumar<akumar@suse.de>
> ---
>   testcases/kernel/syscalls/dup/dup07.c | 180 +++++++++-----------------
>   1 file changed, 59 insertions(+), 121 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/dup/dup07.c b/testcases/kernel/syscalls/dup/dup07.c
> index a100f5d58..b696d54e0 100644
> --- a/testcases/kernel/syscalls/dup/dup07.c
> +++ b/testcases/kernel/syscalls/dup/dup07.c
> @@ -1,142 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - *
>    *   Copyright (c) International Business Machines  Corp., 2002
>    *    ported from SPIE, section2/iosuite/dup3.c, by Airong Zhang
>    *   Copyright (c) 2013 Cyril Hrubis<chrubis@suse.cz>
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
> + *   Copyright (c) 2022SUSE LLC Avinesh Kumar<avinesh.kumar@suse.com>
>    */
>
> -/*
> -  WHAT:  Is the access mode the same for both file descriptors?
> -          0: read only?
> -          1: write only?
> -          2: read/write?
> -  HOW:   Creat a file with each access mode; dup each file descriptor;
> -         stat each file descriptor and compare mode of each pair
> -*/
> -
> -#include<stdio.h>
> -#include<fcntl.h>
> -#include<sys/types.h>
> -#include<sys/stat.h>
> -#include<sys/types.h>
> -#include<sys/stat.h>
> -#include "test.h"
> +/*\
> + * [Description]
> + *
> + * Verify that new file descriptor allocated by dup() has the same
> + * permissions mode as oldfd.
> + */
>
> -char *TCID = "dup07";
> -int TST_TOTAL = 3;
> +#include "tst_test.h"
>
> -static const char *testfile = "dup07";
> +static const char *temp_file1 = "tmpfile1";
> +static const char *temp_file2 = "tmpfile2";
> +static const char *temp_file3 = "tmpfile3";
>
> -static void setup(void);
> -static void cleanup(void);
> +static int rdo_fd, wro_fd, rdwr_fd;
> +static struct stat rdo_st_buf, wro_st_buf, rdwr_st_buf;
>
> -int main(int ac, char **av)
> +static void setup(void)
>   {
> -	struct stat retbuf;
> -	struct stat dupbuf;
> -	int rdoret, wroret, rdwret;
> -	int duprdo, dupwro, duprdwr;
> -
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> +	rdo_fd = SAFE_CREAT(temp_file1, 0444);
> +	wro_fd = SAFE_CREAT(temp_file2, 0222);
> +	rdwr_fd = SAFE_CREAT(temp_file3, 0666);
>
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		if ((rdoret = creat(testfile, 0444)) == -1) {
> -			tst_resm(TFAIL, "Unable to creat file '%s'", testfile);
> -		} else {
> -			if ((duprdo = dup(rdoret)) == -1) {
> -				tst_resm(TFAIL, "Unable to dup '%s'", testfile);
> -			} else {
> -				fstat(rdoret,&retbuf);
> -				fstat(duprdo,&dupbuf);
> -				if (retbuf.st_mode != dupbuf.st_mode) {
> -					tst_resm(TFAIL,
> -						 "rdonly and dup do not match");
> -				} else {
> -					tst_resm(TPASS,
> -					         "Passed in read mode.");
> -				}
> -				close(duprdo);
> -			}
> -			close(rdoret);
> -		}
> -
> -		unlink(testfile);
> -		
> -		if ((wroret = creat(testfile, 0222)) == -1) {
> -			tst_resm(TFAIL, "Unable to creat file '%s'", testfile);
> -		} else {
> -			if ((dupwro = dup(wroret)) == -1) {
> -				tst_resm(TFAIL, "Unable to dup '%s'", testfile);
> -			} else {
> -				fstat(wroret,&retbuf);
> -				fstat(dupwro,&dupbuf);
> -				if (retbuf.st_mode != dupbuf.st_mode) {
> -					tst_resm(TFAIL,
> -						 "wronly and dup do not match");
> -				} else {
> -					tst_resm(TPASS,
> -					         "Passed in write mode.");
> -				}
> -				close(dupwro);
> -			}
> -			close(wroret);
> -
> -		}
> -
> -		unlink(testfile);
> +	SAFE_FSTAT(rdo_fd,&rdo_st_buf);
> +	SAFE_FSTAT(wro_fd,&wro_st_buf);
> +	SAFE_FSTAT(rdwr_fd,&rdwr_st_buf);
> +}
>
> -		if ((rdwret = creat(testfile, 0666)) == -1) {
> -			tst_resm(TFAIL, "Unable to creat file '%s'", testfile);
> -		} else {
> -			if ((duprdwr = dup(rdwret)) == -1) {
> -				tst_resm(TFAIL, "Unable to dup '%s'", testfile);
> -			} else {
> -				fstat(rdwret,&retbuf);
> -				fstat(duprdwr,&dupbuf);
> -				if (retbuf.st_mode != dupbuf.st_mode) {
> -					tst_resm(TFAIL,
> -						 "rdwr and dup do not match");
> -				} else {
> -					tst_resm(TPASS,
> -					         "Passed in read/write mode.");
> -				}
> -				close(duprdwr);
> -			}
> -			close(rdwret);
> -		}
> -		
> -		unlink(testfile);
> +static void run(void)
> +{
> +	struct stat dup_st_buf;
> +
> +	TEST(dup(rdo_fd));
> +	if (TST_RET == -1)
> +		tst_res(TFAIL | TERRNO, "Unable to dup '%s'", temp_file1);
> +	else {
> +		SAFE_FSTAT(TST_RET,&dup_st_buf);
> +		TST_EXP_EQ_LI(rdo_st_buf.st_mode, dup_st_buf.st_mode);
> +		SAFE_CLOSE(TST_RET);
>   	}
>
> -	cleanup();
> -	tst_exit();
> -}
> +	TEST(dup(wro_fd));
> +	if (TST_RET == -1)
> +		tst_res(TFAIL | TERRNO, "Unable to dup '%s'", temp_file2);
> +	else {
> +		SAFE_FSTAT(TST_RET,&dup_st_buf);
> +		TST_EXP_EQ_LI(wro_st_buf.st_mode, dup_st_buf.st_mode);
> +		SAFE_CLOSE(TST_RET);
> +	}
>
> -static void setup(void)
> -{
> -	tst_tmpdir();
> +	TEST(dup(rdwr_fd));
> +	if (TST_RET == -1)
> +		tst_res(TFAIL | TERRNO, "Unable to dup '%s'", temp_file3);
> +	else {
> +		SAFE_FSTAT(TST_RET,&dup_st_buf);
> +		TST_EXP_EQ_LI(rdwr_st_buf.st_mode, dup_st_buf.st_mode);
> +		SAFE_CLOSE(TST_RET);
> +	}
>   }
>
>   static void cleanup(void)
>   {
> -	tst_rmdir();
> +	SAFE_CLOSE(rdo_fd);
> +	SAFE_CLOSE(wro_fd);
> +	SAFE_CLOSE(rdwr_fd);
>   }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
