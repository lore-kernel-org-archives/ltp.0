Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44182C433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 09:27:45 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52183610F8
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 09:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 52183610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4185B3C773D
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 11:27:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18A683C222D
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 11:27:30 +0200 (CEST)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C3C4960117B
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 11:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1631006851; x=1662542851;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9BGRrIAlP4nn+vbd+rjk3o4ODPTGS14TW6T9aECRjo0=;
 b=GZvQDYF8LZk87Tyw6sO8XFt/uJp6kciBzxV3+WErnsEgVfpmflQiLujM
 +OFi9RB1Gu7t4ez75fksxGc4x8s7GSTX/5wNiMwnGeIqQ3hGTLNiHROWN
 7N41hP4+1mmOMlFxh9Jz1wQCJsNZC1JMsvVfkjDhG1Mt0Y3MsV+mWrccR
 zefRBalxoBovExtkgq1402j4S2790UAl9g+jpE2sP6u0MoSB6WffsAMCo
 P4qxKHILvXUqblxT55fKcdhXB3Bn2F0IF2gHTcVRQDP8Sc/yRZ9P7l3wq
 2iGvIBQHEa7mgw8iqwB0tIpwqLwFyc39AgMALQW7ZWC16BnkLh1wm8Tm/ g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="38584614"
X-IronPort-AV: E=Sophos;i="5.85,274,1624287600"; d="scan'208";a="38584614"
Received: from mail-hk2apc01lp2058.outbound.protection.outlook.com (HELO
 APC01-HK2-obe.outbound.protection.outlook.com) ([104.47.124.58])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2021 18:27:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3j1+RvgVv+MwJ3AZbeFT2sOmPVQD2rVEsqaoj1LpyK2ZDPB/M/PN3uyhgvu74nzEnKrcW3qACk9Nd32rdBBHTOdcsca4swgBuEbZpShUy7YbIv7weeqEIitmutn4YrNcomR4aQN1xl7cSB+bESEgEqkx8C0CiHUl57312NvbmC+Hv2EAJfvO3M6U0vxxbp3I0rR8mcpyjNCMSLzB89OCjPLdriBKDXf0DZkO7pcWdaxE8S6vPNdkmXPBTXRBqmbuE6ObUncN6noWvNhgmeVrY1gHH1r8PeyC232FSHwpE5ZsCatnOLR2UErK2RE9ib3c4372qUXrslQNHUQd5apCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=9BGRrIAlP4nn+vbd+rjk3o4ODPTGS14TW6T9aECRjo0=;
 b=Zwn9fnIFNCi5mjHt5IP+5ouIJGscKTHjl2I/S/vIW4GOJ1hlEB73ilqEysd0aN606Aj9lyoPnte6Tq9DtVGwZH3RrPBZQvPPySNqzgpt3KX3kb2W+gDlYN56F//yKHRXcZtg+XXUM9A2ZX6xxr0GmjHUtIo6MWFc2q8Bpdzlw+Ztf7/8WrNxMj4X8SNSJkzb+jq0V5h8Dml5kE7JDHgtF29imxyeGKZXYweKZx+MBgnlYeX042+8lkFiz5R8eXTfP4wlIEH92EQAsVMxnL4k78p/g6uQmA8/BMthuab4+5xyZx3pLYLfZau+R8iOwoq/Y4sshfOTc192z+TVr/ZljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BGRrIAlP4nn+vbd+rjk3o4ODPTGS14TW6T9aECRjo0=;
 b=Rqk/9AbKUgUdCPilBtyae0oCz05xK9i8J6DjoMLrl7jCKSN8wG6JL1oaXpA3lAUq4xVLfT5SEA5jW7ifiXp8Sa/seDZfdzpoEQtTvXba+0bAxhal0emmQ9BG1C0RvRtd0cglqDQvAprhPqI4JfTxLh1reDct2oYeIuA0sPJ9u8c=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB4204.jpnprd01.prod.outlook.com (2603:1096:404:e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.23; Tue, 7 Sep
 2021 09:27:24 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791%6]) with mapi id 15.20.4478.026; Tue, 7 Sep 2021
 09:27:24 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: QI Fuli <fukuri.sai@gmail.com>
Thread-Topic: [LTP] [PATCH 3/5] syscalls/dup2/dup203: Convert dup203 to the
 new API
Thread-Index: AQHXn/IKANfZeI79rk6nOKViv0Tb5auYVUcA
Date: Tue, 7 Sep 2021 09:27:24 +0000
Message-ID: <61373084.4070104@fujitsu.com>
References: <20210902115849.72382-1-qi.fuli@fujitsu.com>
 <20210902115849.72382-4-qi.fuli@fujitsu.com>
In-Reply-To: <20210902115849.72382-4-qi.fuli@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3983527-80e2-4ffd-0f22-08d971e1b391
x-ms-traffictypediagnostic: TY2PR01MB4204:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB42041FF9997D2B47E6AB1C7AFDD39@TY2PR01MB4204.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B84HOA4I0cVNQGMiyOUMWzcpucUk1TxYQwgRjU2iyAP6irT09rPcV9kQWuv/sDJglq/fcmRbmKqQLuhzOdevTQhmlxWDaAGOaUGKv0Vk11PJ0e3EHzWcOcxi5cnUJ9600nHVddYRTD03qTik90dHcq9VLN/WwQck/vVkpkIlxxbkl3+rDQZvkfBhaQnUQ51Z5PPkWCkcZgbY/ibhFOrwefHkv4yxXjxmInCX7gs26MaImWi9v97d7fY8EcSqbbZhTtrtzwgH0QhYDZ3dpF009yQ9fi+3Qrp+1w/j8jMlf/d8n1TPLg2B2Ua2wl+VvFCd0NbE3UOYJxb9M2mNn4yFgsayOpN7yHh29UEz1vGmdzt0e0+j5hgxSiDLB9UzceymtiujpxWy3JPDzPc7B/nOlKUQ9EFs4675cCy/fSPoupBkkvQ3D0EV5dkRW0MvPV6OMHZU46+av/L4KslhYmdCiSstY25areCZmNrkPPUPT6EA8mysSh35xTznE9uhTluSctg2GQAzv0ULl0toBcL89F6JphIIaojsji0l3n2mG+AHtdvu4eLcLafpjLgWRijsQGa7pYPcJZgyOTYyDhnjnFKODoxBaSfydo775r50WTputZVXNTqhEqURrp4Kwpt/k+MWLJl4s1efbDusBOMaH+HLL9uCyKNJvzQOBUifUqHJfaEt1KFIuoScbRArARy8vWPjZpYvHCHMKiNalNDIkqD/6C1G0dXsuGWchNBGT37dfUis+ylawcnAKTULws09
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(5660300002)(83380400001)(8936002)(2906002)(66476007)(6916009)(71200400001)(54906003)(6512007)(122000001)(2616005)(316002)(85182001)(8676002)(66946007)(6486002)(478600001)(38100700002)(4326008)(36756003)(6506007)(91956017)(38070700005)(64756008)(76116006)(66446008)(186003)(86362001)(87266011)(26005)(107886003)(66556008)(2004002)(62816006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eGNkUVNKQVJWN1ZHYUdHSCswNFFDemNvK01jcVhTZzlvR1FYMlRmUFVIM2d4?=
 =?gb2312?B?azF3V2Z3ODNGTGFoa1FPdVF5ZWFabDRoZHdPOER6bHhxbUtRQXQrR3N4b1pO?=
 =?gb2312?B?aUFRbGhBaEd6T21qSEpYMTR4c3ExWi9ONEc0QW8yTEpSQ2hNbFAzb2h6Qkhy?=
 =?gb2312?B?Y2tQNkpIREJDR0pFaCtabTl1VFUzVmc3d1ZKcUZXam83SU96R3V4MGlvV1JB?=
 =?gb2312?B?NXFEb3luTGVaeGdGRTAwSmdtSGFPK1ZzTnNicytDMGcvZ25aSTNpWkN1TDRj?=
 =?gb2312?B?SWorM3JLK2ZhWXV2SEJKajJjeTA2TFRBeWJReEo1cjVBQjZ4ZXc1WXdLTmJx?=
 =?gb2312?B?TWJDTGhUdk1KUE1pMm9zWWs3R3VYSHRnOCtTMUljRHRwaGRlclB1UXllU2Yx?=
 =?gb2312?B?YXFFNlVmckdzMjNkRHNLNDAxVDdRVUtzUVJTU0lZbjJIMWdERXFzd1FBZFBo?=
 =?gb2312?B?UmkxUDVOb0hGQnRnYXhCT2trS29PWUF2SHJGZVhWMTdnZDFzMjJBK2pwMTlq?=
 =?gb2312?B?clRrLzhqdDBuSThQaEgrTG1uSTdRSHMzTnpjdGx3M3NuTG13bUZNTlhLbE12?=
 =?gb2312?B?d3M3bk0wYjltcm5ZNml5U25EY3ZtWGlwVUgxemRyWTFyeTNheHB1ZHhaTXB4?=
 =?gb2312?B?b0tlN2Nhc1hQNXVyWUwzVnZzTG9JQkpFOFRtQU1FTldmTk80aVVrcWk5Vzhh?=
 =?gb2312?B?Nm1DaTViOHZmajNjU0ZtR2lLYXp6Z1pyeTZYZE4zemVudWRnVy9vMGJBRDV0?=
 =?gb2312?B?K0ZWd01yYTNyT3VmcTJVRFZXMFRyY1hDWGJ4MG56TEsvZ3dwRDREYmtaZ1dq?=
 =?gb2312?B?VlV5UFJBUWVBWm5UbUFUMk1HalNRSTZ1YlMralVsMGJSTk5FRVVUWDBKeXlO?=
 =?gb2312?B?SlpRQ1NTRnpVbnhDcis2WkJoYmttVXBFR3h3dFhKMkU1QkJOM2tscWVWaE5j?=
 =?gb2312?B?QXJJUktRK1o3aHVaMlJ3T29Sc1NWb3RwZU8wSXdSRmRuazZWN0xJelorRFhp?=
 =?gb2312?B?dHJUWllKcHBoOVhBbGhpdVJscmRrRkszWkRDQmk2cEVsY3NPeVJjV3VEa0Zo?=
 =?gb2312?B?NUQxSFAyQzQrdEQySEE5Z3F3ZFl2ejZnMkhZMmV0STg5bWNJRUpjd3cyNTFL?=
 =?gb2312?B?bG9CdUp6M0Z6ZWp3ZDZISk8wcU1XMS9hZThsT3pTWmlkSGlXUnlrUEszQnda?=
 =?gb2312?B?aGFlN3hmeU5UYUFqMnZMdHMvZmpFUTA0WGZuYlBzbFVZTkNnazU0YU1sOTVz?=
 =?gb2312?B?VmNCTEVESVcwNkQ5WU5PQnVxNHVWckxPWnRHT0t6VC9UaUd1cHFvYm1lN0pk?=
 =?gb2312?B?L0ltb2F5UFBTNzZQejA2S2pCUWdqazYreURHcTY3S1g2aWw3VEg2T1B2dElZ?=
 =?gb2312?B?ME55QWhPK0o3elhLZCt5Y2sxaWZaSmFYWVZGT25rT0VTa3pDZEh3QVdJdHdt?=
 =?gb2312?B?VWJRbldxY2loaW9LcnZFNFZzbTcyRnhRL1pHQ3QwdVlKbmh5Qkl3Zi80OTc2?=
 =?gb2312?B?VEZqbXVLL0F3UjY1UU9ubkdGUkR3QWhwbTF4R1lBc2dLMDZhaHI2ZmRkMmph?=
 =?gb2312?B?WDlJS1RIQjJxd0hWVW5pMlZuVTZ3YU56YjFGSmFreFN6T0VFSll3cmZXQUtQ?=
 =?gb2312?B?TkRTNitIc25JaUZ5bzdva0dJSE15L2tybHRWQ21Dd0FqV2JibmFvME1qem4v?=
 =?gb2312?B?Nzh6VS9BUDVLeUhqd24vbThoVVYwU1MvVDh2eEEwdnBMcWl5N3c3MU12blhV?=
 =?gb2312?B?RDJETlpOUGFjRkV1WUVMeTlkZW5WOWxZWkx6RjBaNzc3dEZsL2hYdzFabHZv?=
 =?gb2312?B?VU1yMW1JUGg0YWdkU0VjUT09?=
Content-ID: <49D1702829390D4D8C7D5FE9466A51E6@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3983527-80e2-4ffd-0f22-08d971e1b391
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 09:27:24.3306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KttGzxT+mN4b+0j1SNITROdkxX0uDyIMelm6pWj+02ll7XAqidHPK4a4T9mqUrBl8/s+RXrY25BKE7KiDhrn1n+97pjwKJqvP8yZGwZ8SrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4204
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] syscalls/dup2/dup203: Convert dup203 to the
 new API
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
Message-ID: <20210907092724.CmadYcRTNwaJcsFlSmIx7wwk2Ep6Qqnd9scwAoAMUWE@z>

Hi Qi

Please use some safe macros.
And the run function is too long and I think we can divide it into two 
function(may be in a verify function with differnt arguments like dup202.c).

Best Regards
Yang Xu
> From: QI Fuli<qi.fuli@fujitsu.com>
>
> Signed-off-by: QI Fuli<qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/dup2/dup203.c | 291 +++++++++---------------
>   1 file changed, 112 insertions(+), 179 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/dup2/dup203.c b/testcases/kernel/syscalls/dup2/dup203.c
> index e6f281adf..a2cbcc8f9 100644
> --- a/testcases/kernel/syscalls/dup2/dup203.c
> +++ b/testcases/kernel/syscalls/dup2/dup203.c
> @@ -1,208 +1,141 @@
> -/*
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
> - */
> +// SPDX-License-Identifier: GPL-2.0-or-later
>
>   /*
> - * NAME
> - *	dup203.c
> + * Copyright (c) International Business Machines  Corp., 2001
>    *
> - * DESCRIPTION
> + * DESCRIPTION:
>    *	Testcase to check the basic functionality of dup2().
> + *	1. Attempt to dup2() on an open file descriptor.
> + *	2. Attempt to dup2() on a close file descriptor.
>    *
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
> + * HISTORY:
>    *	07/2001 Ported by Wayne Boyer
> - *
> - * RESTRICTIONS
> - *	NONE
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
>
> -void setup(void);
> -void cleanup(void);
> -
> -char *TCID = "dup203";
> -int TST_TOTAL = 1;
> -
> -int main(int ac, char **av)
> +static void run(void)
>   {
>   	int fd0, fd1, fd2, rval;
>   	char filename0[40], filename1[40];
>   	char buf[40];
>
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
>   //block1:
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
> +	tst_res(TINFO, "Enter block 1");
> +	tst_res(TINFO, "Test duping over an open fd");
> +
> +	sprintf(filename0, "dup202.file0.%d\n", getpid());
> +	sprintf(filename1, "dup202.file1.%d\n", getpid());
> +	unlink(filename0);
> +	unlink(filename1);
> +
> +	fd0 = creat(filename0, 0666);
> +	if (fd0 == -1)
> +		tst_brk(TBROK, "cannot create first file");
> +	if (write(fd0, filename0, strlen(filename0)) == -1)
> +		tst_brk(TBROK, "filename0: write(2) failed");
> +
> +	fd1 = creat(filename1, 0666);
> +	if (fd1 == -1)
> +		tst_brk(TBROK, "Cannot create second file");
> +	if (write(fd1, filename1, strlen(filename1)) == -1)
> +		tst_brk(TBROK, "filename1: write(2) failed");
> +
> +	SAFE_CLOSE(fd0);
> +	fd0 = open(filename0, O_RDONLY);
> +	if (fd0 == -1)
> +		tst_brk(TBROK, "open(2) on filename0 failed");
> +
> +	SAFE_CLOSE(fd1);
> +	fd1 = open(filename1, O_RDONLY);
> +	if (fd1 == -1)
> +		tst_brk(TBROK, "open(2) on filename1 failed");
> +
> +	TEST(dup2(fd0, fd1));
> +
> +	fd2 = TST_RET;
> +	if (fd2 == -1)
> +		tst_res(TFAIL, "call failed unexpectedly");
> +	else {
> +		if (fd1 != fd2) {
> +			tst_res(TFAIL, "file descriptors don't match");
> +			return;
>   		}
>
> -		close(fd0);
> -		close(fd1);
> -		close(fd2);
> -		unlink(filename0);
> -		unlink(filename1);
> -
> -		tst_resm(TINFO, "Exit block 1");
> -
> -//block2:
> -		tst_resm(TINFO, "Enter block 2");
> -		tst_resm(TINFO, "Test close on exec flag");
> +		memset(buf, 0, sizeof(buf));
> +		if (read(fd2, buf, sizeof(buf)) == -1)
> +			tst_brk(TBROK, "read(2) failed");
> +		if (strcmp(buf, filename0) != 0)
> +			tst_res(TFAIL, "read from file got bad data");
> +		tst_res(TPASS, "dup2 test 1 functionality is correct");
> +	}
>
> -		sprintf(filename0, "dup02.%d\n", getpid());
> -		unlink(filename0);
> +	close(fd0);
> +	close(fd1);
> +	close(fd2);
> +	unlink(filename0);
> +	unlink(filename1);
>
> -		if ((fd0 = creat(filename0, 0666)) == -1) {
> -			tst_brkm(TBROK, cleanup, "Cannot create first file");
> -		}
> -		if (fcntl(fd0, F_SETFD, 1) == -1) {
> -			tst_brkm(TBROK, cleanup, "setting close on exec flag "
> -				 "on fd0 failed");
> -		}
> +	tst_res(TINFO, "Exit block 1");
>
> -		if ((fd2 = creat(filename1, 0666)) == -1) {
> -			tst_brkm(TBROK, cleanup, "Cannot create second file");
> +//block2:
> +	tst_res(TINFO, "Enter block 2");
> +	tst_res(TINFO, "Test close on exec flag");
> +
> +	sprintf(filename0, "dup02.%d\n", getpid());
> +	unlink(filename0);
> +
> +	fd0 = creat(filename0, 0666);
> +	if (fd0 == -1)
> +		tst_brk(TBROK, "Cannot create first file");
> +	if (fcntl(fd0, F_SETFD, 1) == -1)
> +		tst_brk(TBROK, "setting close on exec flag on fd0 failed");
> +
> +	fd2 = creat(filename1, 0666);
> +	if (fd2 == -1)
> +		tst_brk(TBROK, "Cannot create second file");
> +
> +	/* SAFE_CLOSE() sets the fd to -1 avoid it here */
> +	rval = fd2;
> +	SAFE_CLOSE(rval);
> +
> +	TEST(dup2(fd0, fd2));
> +
> +	fd1 = TST_RET;
> +	if (fd1 == -1)
> +		tst_res(TFAIL, "call failed unexpectedly");
> +	else {
> +		if (fd1 != fd2) {
> +			tst_res(TFAIL, "bad dup2 descriptor %d", fd1);
> +			return;
>   		}
>
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
> +		rval = fcntl(fd1, F_GETFD, 0);
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
> +		rval = fcntl(fd0, F_GETFL, 0);
> +		if ((rval&  O_ACCMODE) != O_WRONLY)
> +			tst_res(TFAIL, "fctnl F_GETFL bad rval on fd0 "
> +				"Expected %#x got %#x", O_WRONLY, rval);
> +		tst_res(TPASS, "dup2 test 2 functionality is correct");
>   	}
>
> -	cleanup();
> -	tst_exit();
> -}
> +	close(fd0);
> +	close(fd1);
>
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - */
> -void setup(void)
> -{
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> +	unlink(filename0);
> +	unlink(filename1);
> +	tst_res(TINFO, "Exit block 2");
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
> +	.needs_tmpdir = 1,
> +	.test_all = run,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
