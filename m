Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89369C433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 08:28:55 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BDE060F45
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 08:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9BDE060F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2B6B3C24BE
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 10:28:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 703CE3C1AF2
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 10:28:41 +0200 (CEST)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C0F88601256
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 10:28:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1631003319; x=1662539319;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=o5ltptKY2U54dMU0XwxQ9mLMc1ifHKjLSxhMB3Pey6c=;
 b=TazAWPTM4j5kXbG9dAMWGZkbHE5UMffA5xRfHUXDF1nvDSGUbEcbLa7H
 yQy7UvCTYnVrOaiuJzCAdwTLsvKfvMPnDNKCQmOMKiJZYj0AUwlY32/U/
 xgykcPa0pjb8iFp2OZLt/Stfs5ZDL44CqIJM3+Zq1zLLxGjM4Z8Y2oUQ9
 5KsfHjJNTgmSKgHGhr1v4augKf5t/J9Z8kOZsLql5lDB1dKjPIhUEHqKW
 oGl8DRdlTD34EXglgF5PQHW9+GwVyyFChP12rC1dUxAuQucSJgDi4nK/q
 DN1kKdKBI0Pnctc75tThDcFkcAKQRixVtn88NZF0RRXdz0WF7K4iqgofu Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="38881539"
X-IronPort-AV: E=Sophos;i="5.85,274,1624287600"; d="scan'208";a="38881539"
Received: from mail-hk2apc01lp2058.outbound.protection.outlook.com (HELO
 APC01-HK2-obe.outbound.protection.outlook.com) ([104.47.124.58])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2021 17:28:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5yTYszZ6eK/o2JI5KJ9U930y6NoFbFPNdmH6b4xH3wKHmFF0BmtvjiTinz1Iy1NA3+tMgS2gAJy1Y/100hbxY4tKfqvXDevnSUtirkwvAQflSUqaeh1eADSNuy6asKQVeuGaH9e2a98u+jW6MLKC7W9d/l3TemZXHphJLTojwyh5vB/Hl3qsaBJtO4c/5hK58r6lBqGnNv/uQbn/a7lRj9FXguJan/q9TAuXn2IbFTSM/XJEAGWCYNnU3FMGdZp79UsvmfR38viPPQHDJZUi2mrqn/0C2vRcXMOcLtial47dz0LwM3ZopOmLnwOmeKrgfNhFIF3eR68A3bLxcqGPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=o5ltptKY2U54dMU0XwxQ9mLMc1ifHKjLSxhMB3Pey6c=;
 b=QFJeYtRinGHVE21krbqEDXZivrH3Lef3poH6Irn/oNeGmu/SGddG9JLYLiuLF4hOgJflJnR9qVk7yB4cjKxd7KpfVczYaYpPU8U0VnLOvW8WO4gGw/5p+f3ceyxIpJ5IZle7oAGHXf/UjxZ7m6YHvzEEi7LYm3ccELM6HW6ft1wCwqoMPEVgo01qYdKAbY1+7f0knt0Qw1PObV6IgbZoyLCxPAzJeA4gO8UA2iiuBIsjjGpxp1XQ/uAGJHE/jAB1yBy+eYqiBtq005AElTY3qaVg8rV1B3vovW1Ryp0KAutvUwVFRVyHd2SX41V8CnwWCajPxwj4R4qOPaX+pD5M8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5ltptKY2U54dMU0XwxQ9mLMc1ifHKjLSxhMB3Pey6c=;
 b=Hwt4Sr7SH5Yl+/NnyYj2G60T0YSEAV/GouJmLzvhqkDUkB7D+vuDVsQXHi9v+ZRYKdozQ/IKFA9r1pQCw5SXLT6G+HLLdiwN0AcSXZ32BJ5ER33DydqulJMQu0+M6pDmIhWQ7M0JFiNSaY6bTmLI/2I8FxXozAusTbSfdpp/koo=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB5193.jpnprd01.prod.outlook.com (2603:1096:404:11b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.23; Tue, 7 Sep
 2021 08:28:33 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791%6]) with mapi id 15.20.4478.026; Tue, 7 Sep 2021
 08:28:33 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: QI Fuli <fukuri.sai@gmail.com>
Thread-Topic: [LTP] [PATCH 1/5] syscalls/dup2/dup201: Convert dup201 to the
 new API
Thread-Index: AQHXn/H8cjkmVSgGmEGgLIZpBLsLPauYRNaA
Date: Tue, 7 Sep 2021 08:28:33 +0000
Message-ID: <613722B9.7090608@fujitsu.com>
References: <20210902115849.72382-1-qi.fuli@fujitsu.com>
 <20210902115849.72382-2-qi.fuli@fujitsu.com>
In-Reply-To: <20210902115849.72382-2-qi.fuli@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0d2a630-c67a-487f-e5d3-08d971d97ace
x-ms-traffictypediagnostic: TY2PR01MB5193:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB51933D948EC02B3B6729F09BFDD39@TY2PR01MB5193.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xmcRmQeBOjFZKpej0e3okFOlZkXf09TdbQPRAflv8KVWEwfmXAlQjwFbsuQtuSvf1/lBfTBMyXhF/Iy1XITeCA6OFy8d7eUx371yGe/wfQoFSaFBLgWP2Ho4ldwD6FhOgEADKSj5AzmbCdiQG1WsQCOz8oJDiNxm6tK1eeOFigE6HHUcc6u9d4ghk+SfBNUPEKiJUL0dQeUC/y5xuvLQLRm+ssGUAqtF0t7QSvvC6cBXGmXtn1Ph0wquPg2f0dj67OJWlbncDlHpgQn++mIZs49EDbXzS09WD7MVlMlIBv5OMSrY5eCunX07xLcClV2svjXdPFibV9BCcFRYVbTC4FSIGORJIKRMjwHqISFALcJj1xZVcouXmUJYYwhhGT+eAXxzv7iT4lAkIg/ca14IrBdWJnNTgPpXjWMH2qVPexu+TYg/RFMrxkS35R9s1uhfDze/QHG5aR/F7tU0il/oUgmWceS5xTtt71K0277LOSWZ/NnurfLA1iELTrsVy1btHPj2J9UNIafXEv1RZ7ZztLqLgl+FwRat1qvRucHhvd9lfY52b4ZhSXxKjYLkxwVeG4bZdsG0RVEa1Hnselmvy3ta9XG1gb40bLeRSRysvl9r2MwyJcsk2MeA86nXmPVKvI+hg9ZjgcndY43nvKxmlxSI7iDSixRR5P6PHCskX8NfbdI19mom8ITrHYWQST9UTuFBnP9yrsJsGKLbcrjg+dQ4nuVDnYNZp8mSUxuJRzo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(66476007)(66556008)(64756008)(66446008)(478600001)(66946007)(76116006)(38070700005)(71200400001)(33656002)(54906003)(83380400001)(5660300002)(8936002)(316002)(6486002)(86362001)(122000001)(6506007)(6916009)(91956017)(85182001)(107886003)(4326008)(8676002)(6512007)(2616005)(26005)(186003)(87266011)(38100700002)(36756003)(2906002)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MUVERi95TWd5S3hpNnp5MWVIWU96bWFDb0NmTmcyQmp0d3ZITE1ndEIxOW9j?=
 =?gb2312?B?NnVJRVg4YlFiUmF3bGZPZE12R3c2WGtzdFBsbWlWN1M2RU9hRjdWeTh4c1My?=
 =?gb2312?B?QTlTd0EzckZSM1ZFdW5GZG9ZU1ZZb2dDR0UwLzdlb3dPQzNrSTZ4YkFqc1Zx?=
 =?gb2312?B?YldYeUhBMyt1bU5aYzZVWDdsRFVxdFJxeUMvVStqaEtaeDRGSHM5KzVtVWgy?=
 =?gb2312?B?RCtJcktiVks1SGtuSXRXTjdEUlBlL1o1L1ByYThpT3A2akVJa1dVY0hsTjdE?=
 =?gb2312?B?bFlQNTAyTHhIL2licHNIRktPOElhb2h3SnNlL0czZERidkdtU2hiaTJmcXFZ?=
 =?gb2312?B?VEduUWZ4eTdXQ3RIZVZNWDU0UDdFbFlDZ3pSMHBWWkcyRkdRSVBMOEo4RmNW?=
 =?gb2312?B?MHp2VkMrYm13MGdLMGcvUGZJY0VIM2c0WXFMY1p5SktUbWJRSjBmQWJwQStS?=
 =?gb2312?B?ME9aZjhYWFZia2Ewc3VVaDNQa1BzamVaSld2V2hjYi8vZVhZR1UybnFUaXdG?=
 =?gb2312?B?aFpmMElSakFmajNRRlFyUlF0TTZUR0VaaWtPanNCbFI3OTdJZ1Y3c004SHZw?=
 =?gb2312?B?dEJqVWJSdFFEdWxCWUV4Mi9IVTVXb1JIU2txMXpoMGFzaUNxUGNxMWNoWVRn?=
 =?gb2312?B?dW94YnpWOUFLSlFZUzVsZTloWU9wVHhEdHNFcUhSMVFJWUd6Wmw0Umd0clRZ?=
 =?gb2312?B?bWJTYUZaQUR0cEFQYUdhNDhmRHFxNk96Y2xvZkgwZlIwc1Y0T216K3hQZXhQ?=
 =?gb2312?B?MURqZXE0alMzbTdGWGh3bWdGa1FQQ3BQL3E2T0I0RmJCUXlTQnBRQjJZbzZF?=
 =?gb2312?B?Sm1ib0FMVldkcFJEU2ZqcGc4c2VXQTZTZnRjYVhYYlN4STVudTlHUmxsdjhW?=
 =?gb2312?B?OWJJSUNvVUNtVDIwaFNwMjJBQjROZDlxVHZ4QUNhOUUyT1ZLcWpqUWw0UjZP?=
 =?gb2312?B?cU1KNTc5R242NjdOclpzb2lpbm9nZ0lXK0ZpcDZpL0Y2VWZuaURjS05BNjhs?=
 =?gb2312?B?eFAwT1JyV3JjMFdVUUhwN0l5YncwSmtVUFlyc0JvQ2M4cEpWSFQ4R2p6Ni9L?=
 =?gb2312?B?ZkE5WURnbEp6bUF4VFBCOHh5VUNHNG55bDNtOU1QUHR1ZWJZTVVPS0kzbXhm?=
 =?gb2312?B?SXFTRmZ2VmQ5cWJtRkFhejAwamhXWmRua0Uvbmk3c3J6Y2FpSW9qZmdhcklM?=
 =?gb2312?B?REhoZzlyV3RXNUVJOVp2Mlo1eFpWN0o2YWI1MC9VekFXKzQvaG9yTFRKZzRS?=
 =?gb2312?B?NjlTMGtoTlpEeElLYXR1YlBBWEpha29BeW5vRSt0WjdCRDVYNmNvbWZhQzRH?=
 =?gb2312?B?a1RBeTNPZGFLY2xXRVFwdk1TZnQ0UVZjNmpvMEdTOFhrcWFUVlI3Vzdka2lY?=
 =?gb2312?B?by92TmFGV1NjK29aRFh2YjUrWTdESWdIc2sreU1qTzlCeU1NbUhCWmpKdFBn?=
 =?gb2312?B?ZEtrZ0huaXVSa2F4Nit2Rmd0Y1JqVmFzR1Z2c2JhZHhFRGdpci96SkNETzZ1?=
 =?gb2312?B?UUZZdGw3K01iSGd0N1o4ajdON21HYS9PckpWUDJXV29JUCtmdnpkbDFmRFkr?=
 =?gb2312?B?alIvUDJMSVFCSXJEQ2xSdDh5LzM4UzR0cXk2UG5MSWI0NCtkcklqTnc0NTZQ?=
 =?gb2312?B?MkRJZTNSRmg5bUtQelBTRTRXT1llOUsyeTBIYlVRV1ZmTEIwWWFWVVpzU3d4?=
 =?gb2312?B?RDdNTUJVODFrSjdaL2FXVlc4L1hQam9lRERvRjAvam5LdmdqdzFRbzJqbXlZ?=
 =?gb2312?B?Y2w1RHpERDkvLzY4SWpaOVVPaEtwdnpEYW9GQUJlZEk0N2pMaElHWUlzbmhi?=
 =?gb2312?B?VU9mdjRvbnV6MDZxQVFYdz09?=
Content-ID: <5FEE1B8CC88DA743ADC861A269D017F2@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d2a630-c67a-487f-e5d3-08d971d97ace
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 08:28:33.0314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Sk980RVn7C6sL/Y2IMu0wqmfYiIiQj+z3+Ff2PhiJH0nMNgFkWgmQpScT/5tXuCg+fVQh61zSGILOzlFh+LuGXurIGxdhV3C4gzq9siDSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5193
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] syscalls/dup2/dup201: Convert dup201 to the
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
Message-ID: <20210907082833.qBOjub_kk2vgNUwgqu2Ycc0dauLBi91niRjtP2pwizQ@z>

Hi Qi
> From: QI Fuli<qi.fuli@fujitsu.com>
>
> Signed-off-by: QI Fuli<qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/dup2/dup201.c | 161 +++++-------------------
>   1 file changed, 34 insertions(+), 127 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/dup2/dup201.c b/testcases/kernel/syscalls/dup2/dup201.c
> index 4fa34466a..231c262bf 100644
> --- a/testcases/kernel/syscalls/dup2/dup201.c
> +++ b/testcases/kernel/syscalls/dup2/dup201.c
> @@ -1,87 +1,30 @@
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
> - *	dup201.c
> + * Copyright (c) International Business Machines  Corp., 2001
>    *
> - * DESCRIPTION
> + * DESCRIPTION:
>    *	Negative tests for dup2() with bad fd (EBADF)
>    *
> - * ALGORITHM
> - * 	Setup:
> - *	a.	Setup signal handling.
> - *	b.	Pause for SIGUSR1 if option specified.
> - *
> - * 	Test:
> - *	a.	Loop if the proper options are given.
> - *	b.	Loop through the test cases
> - * 	c.	Execute dup2() system call
> - *	d.	Check return code, if system call failed (return=-1), test
> - *		for EBADF.
> - *
> - * 	Cleanup:
> - * 	a.	Print errno log and/or timing stats if options given
> - *
> - * USAGE:<for command-line>
> - *  dup201 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -e   : Turn on errno logging.
> - *             -i n : Execute test n times.
> - *             -I x : Execute test for x seconds.
> - *             -P x : Pause for x seconds between iterations.
> - *             -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *	01/2002 Removed EMFILE test - Paul Larson
> - *
> - * RESTRICTIONS
> - * 	NONE
> + * HISTORY:
> + * 	07/2001 Ported by Wayne Boyer
> + * 	01/2002 Removed EMFILE test - Paul Larson
>    */
>
> -#include<sys/types.h>
> -#include<fcntl.h>
>   #include<errno.h>
> -#include<sys/time.h>
> -#include<sys/resource.h>
> -#include<unistd.h>
> -#include<signal.h>
> -#include "test.h"
> -
> -void setup(void);
> -void cleanup(void);
> -
> -char *TCID = "dup201";
> -int TST_TOTAL = 4;
> +#include "tst_test.h"
>
>   int maxfd;
>   int goodfd = 5;
>   int badfd = -1;
>   int mystdout = 0;
>
> -struct test_case_t {
> +static struct tcase {
>   	int *ofd;
>   	int *nfd;
>   	int error;
>   	void (*setupfunc) ();
> -} TC[] = {
> +} tcases[] = {
>   	/* First fd argument is less than 0 - EBADF */
I prefer to put these messages in the top commet, so we can see more 
useful information by using doc parse. Maybe as below:

/*\
  * [Description]
  *
  * Test for EBADF error.
  *
  * EBADF -  First fd argument is less than 0.
  * EBADF -  First fd argument is getdtablesize().
  * EBADF -  Second fd argument is less than 0.
  * EBADF -  Second fd argument is getdtablesize().
  */
>   	{&badfd,&goodfd, EBADF, NULL},
>   	    /* First fd argument is getdtablesize() - EBADF */
> @@ -92,72 +35,36 @@ struct test_case_t {
>   	{&mystdout,&maxfd, EBADF, NULL},
>   };
>
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		/* loop through the test cases */
> -
> -		for (i = 0; i<  TST_TOTAL; i++) {
> -
> -			/* call the test case setup routine if necessary */
> -			if (TC[i].setupfunc != NULL)
> -				(*TC[i].setupfunc) ();
> -
> -			TEST(dup2(*TC[i].ofd, *TC[i].nfd));
> -
> -			if (TEST_RETURN != -1) {
> -				tst_resm(TFAIL, "call succeeded unexpectedly");
> -				continue;
> -			}
> -
> -			if (TEST_ERRNO == TC[i].error) {
> -				tst_resm(TPASS,
> -					 "failed as expected - errno = %d : %s",
> -					 TEST_ERRNO, strerror(TEST_ERRNO));
> -			} else {
> -				tst_resm(TFAIL | TTERRNO,
> -					 "failed unexpectedly; "
> -					 "expected %d: %s", TC[i].error,
> -					 strerror(TC[i].error));
> -			}
> -		}
> -	}
> -	cleanup();
> -
> -	tst_exit();
> -}
> -
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - */
>   void setup(void)
>   {
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
>   	/* get some test specific values */
>   	maxfd = getdtablesize();
>   }
>
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *	       completion or premature exit.
> - */
> -void cleanup(void)
> +static void run(unsigned int i)
>   {
> -	tst_rmdir();
> +	struct tcase *tc = tcases + i;
> +
> +	if (tc->setupfunc)
> +		tc->setupfunc();
> +
> +	TEST(dup2(*tc->ofd, *tc->nfd));
> +
> +	if (TST_RET == -1) {
> +		if (TST_ERR == tc->error)
If dup201 only tests EBADF error, I think we can use EBADF directly 
instead of tc->error.

Best Regards
Yang Xu
> +			tst_res(TPASS, "failed as expected - errno = %d : %s",
> +				TST_ERR, strerror(TST_ERR));
> +		else
> +			tst_res(TFAIL | TTERRNO, "failed unexpectedly; "
> +				"expected %d: %s", tc->error,
> +				strerror(tc->error));
> +	} else
> +		tst_res(TFAIL, "call succeeded unexpectedly");
>   }
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run,
> +	.setup = setup,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
