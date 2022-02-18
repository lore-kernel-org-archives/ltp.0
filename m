Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99942C433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 02:03:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9A9E3C9F0B
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 03:03:21 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DFF23C9564
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 03:03:12 +0100 (CET)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CC5D7100098A
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 03:03:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1645149791; x=1676685791;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=uGhfUU2xwMtO0AHQ5brpqDPprfrFFkZ6FuXSbcz+7M8=;
 b=FOiyCVbJuVTc3Qncms0agBVU/EX9vf3vFghETz3GLVT9IlFFaooMVUaf
 zuyYatFeuKH7WquEJI9g7n002F8XzhZHJ09LXzFUWwHKzfjcO1b1RPb/z
 cSm0RLW4KhR6Lp6ojR2ZqtnClh8aAPREzaQP4GgzAeCdSV5FuuRS3H6bM
 0kvn/2PWsyWn1CUh6mzBFuaN4nju113J/b611fuQgMhOiY25p2bbw2ouw
 nMzDJqkdSJRzxSUb5byDsii7HH/h2Uit9iTifduqSTa8VuF6dpLt7oHWt
 JKbRu2hbs2bPCgj5bOSEoKJ6AXe+zic5hTgQs0VV8YJfjnwWLNgScjt9P w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="49821526"
X-IronPort-AV: E=Sophos;i="5.88,377,1635174000"; d="scan'208";a="49821526"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2022 11:03:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzO5eC0XOvWPzUUC9insQMNEhOb0/S7z1nhMEs1djfhjGVnfnpo3h8lK/wD9KFo3uJXuVRLyaxQGpOhHe+SjRZfSJ9Jtd3uHVru92bXKUGxROjjqJlBbw9pflAMeF1CYaEcgGAAzpz9wlq4yi1jaj7rYU3w4qVwTqjdtpjNSYCDvlZYZuDX4y2lwiAaVDHwTEFHpcbyGiXFMRsLDWSdnJO7814/ilzO8/DkDMeRZSif+I88wDmeXYQ3sLO/AwEVNa9rr/wwIFx5GBye5U/BDGvnzP9DDc2aDP66K2KEoDkpRtztzW/j33m4LLl1x1rsVbzV037pr8kPiuLuKAV0n6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGhfUU2xwMtO0AHQ5brpqDPprfrFFkZ6FuXSbcz+7M8=;
 b=GQHo6rMKdqi2WzezV5kIbZe7cFb2JEXa+YktIwmHcv7+gcAMlE75qVUy7XuMamjnfSZWl87mIwG04CUkGu2W1t0phFgPq/aA3M+lFvr3nC3hTCwKbfYhaw6rzPyNEpzd+kkdlowISiARO1g3vuz2AfoXot5nccR0AZkCODFBO7HIEtnInEbJbAqPxskeiIvimku7zG4fTUDnx0toWjXKMzkunWOoYR1DDwNH1kPGzH7WkDBEezfMwOhU+O4uku53+6erRaiXXw9z9pPATzLbTeXYhfd7BS75rCfStt0AglWWqZIiVTORd6qB60T8p8mf2tGzWBhIN1X9dUtivmPrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGhfUU2xwMtO0AHQ5brpqDPprfrFFkZ6FuXSbcz+7M8=;
 b=X5GzpGGlocy8xIlOp6tNJyRcp0zjlWBdBaUIZ2MgWZSzi78e8oMWaFoUo6N4Br6Lmrsuy9pd/iEZs1R0g6L8WCDVjhq/Fo77uW25icy25WashsMgjVyy3hs6yWJSC8S80Kxvre7mM9y6cLMiFjUus5ADStaxZTztsS9J/y+Sm/U=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSZPR01MB9459.jpnprd01.prod.outlook.com (2603:1096:604:1d6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 02:03:04 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 02:03:04 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 1/1] regen.sh: tst_syscall(): Print again syscall
 number as string
Thread-Index: AQHYJC6izY/Ch3+KhEGBO2xnwbsM4ayYjxuA
Date: Fri, 18 Feb 2022 02:03:04 +0000
Message-ID: <620EFE77.60304@fujitsu.com>
References: <20220217184554.26915-1-pvorel@suse.cz>
In-Reply-To: <20220217184554.26915-1-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4855d4f-ae34-4537-ccdf-08d9f282ccd7
x-ms-traffictypediagnostic: OSZPR01MB9459:EE_
x-microsoft-antispam-prvs: <OSZPR01MB9459F8B4940B4F8E7911657DFD379@OSZPR01MB9459.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o3xcmB6gxEjZSLZPW97KGN+UGfFw1yszDghSvai+74foAz+rT2f0+VXwckxc/yVp9FG+VJKZzDYbp+K/3GUi5VzfxcqsAAFVwZ0QB1878lGOV3JsiY55yJejDxAWvnDGILGmpOo+es3w7j52vkV2Z+16HWxqIDbEE1nf+tNvmQOxb0EYRnSITREQr2zTtIz325qaEvtpTQlQjHwzJ3F8EVnIC2m4GhUZVAdyAknoOsSXP2H3GsTjcoo5n0+B4FoQKGrKwwar90dZ26k3/YMeOfZ5Rg+u4TOs3xR5Pf/XO+mJai2ECL8v6c06FPRT2DawFNzQiDnfkNzS2lqlXuqQ0mt4nhA/IuSLggdXcimHObSZl28Oy2U3H6BNC0eaS5mXFKOKZFi5KyhdebTyGxhE6r4FWsGcI6uo0yMoZtVwTjYaHwP/n2kZtjvUdTCSxSQn1gj6KvegVG4B7rYJW9APiXE/1mUwfdcKyt0ikAE0td83f5ELJyKgDEX6KL5B/zotksggaSyk05bZuIv/23MqIjioBhJv/x+iD5arnqfYPajtEZLk5RMNA9ZcCbrpTwXJazSqJjpfpzF3TWSZ24JVgiHGaHxlGX24hNHGtTApdJS8YvKt3lhRMoY8RpTzvxt/H68drJZ7ewpt0v+n7REcGPvb/roVdnwCYt5/yOV/PETST7/gGTlJPzDtfAnHY+3D1Na8ykztW+fMRiorh29EFQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(8936002)(6916009)(86362001)(122000001)(38100700002)(91956017)(6486002)(5660300002)(6506007)(36756003)(4326008)(66446008)(8676002)(64756008)(66556008)(82960400001)(316002)(85182001)(66946007)(83380400001)(66476007)(76116006)(6512007)(508600001)(71200400001)(2616005)(186003)(26005)(33656002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?S09YSjJGNnlvMld1THgxdUV4RVhwdEw4TittZExJeDdaRUNXL0NVMlNsb05o?=
 =?gb2312?B?UEdlbHhiRU40OFRCeVR6enVTNlJmR3MzblA0MnlZczRMWFR5RjZxeFNiTzFH?=
 =?gb2312?B?WDF2eWFZbXFNbXJGMFFIczRwZm5kaTNOL3E0WjhsbEF2ZzZvdlBMT3lEVzBz?=
 =?gb2312?B?bEVVcG9tc3JDOWJ5NkhRNFBnOW14WStxU3VuTDRlTE8raUpCaXdYa0lVSWdt?=
 =?gb2312?B?NEhQV3YxcVZjbTNXaUdUWUt0aGVnY2NpZXNRR2gyd2VaRERFOGtzRnpjUVU1?=
 =?gb2312?B?YUljaUJjNFg0Z3ZjQU1yaWpNOTBhTGNPNlVwY1Fod2dCSTREVzl4TFlaMlFF?=
 =?gb2312?B?OHN4L0wxUnk4Nm9OOUtIaHdFV3dtblZRSlR1L0NITUJmNUpCYVVKODhwc3k4?=
 =?gb2312?B?Q0JVaXl4UExlTmxLYS8vZHlBQjZ5cUFzRmdzMVl0a08ySUlyS3JjT3NmMi94?=
 =?gb2312?B?cDNmaGFMVE9pc2dnblJYeTFURnFhYWkzT24wdTBkL1BweUhaRHptN0RvRFA1?=
 =?gb2312?B?dm82TjVmYWJ3eTBwaUNVTFFoQlNGdTVRVmJIUUt1T3NGMVhGUlI0dm1vSGxO?=
 =?gb2312?B?V2YvK05JQXFVVDB6RzBSSXd3TFB5UENVVlVtRVR1S01vYjNNZloyUjJTQVdH?=
 =?gb2312?B?ZzhjZEZwOEQyL0Y1cjN6Y3NlZ0dYd2ZvcXZZc293SFpGV1NTQVRxdWdROVNF?=
 =?gb2312?B?RFNiVWN5YTd3NlA4SkpQZ1lVMFZnTEdibTROeHNUc2hBZDBibmtrTnFUdmJH?=
 =?gb2312?B?TXh2c1k4R3FkeXptczVCOERpMTdzM2MrRVB6bEhGY01uYzVFQjE5WUYrUmVn?=
 =?gb2312?B?WHIrN2FXdUZlZ0MxVDgyK0R0YllnNVBvRTlpa1QwbVhpdmIyMkI3NVh1b0h2?=
 =?gb2312?B?WkNzajRHeTRIaEVQRzBHMjNsZzlFbnliS1h1Y0RZNzFRSEpyY093TzRLbXha?=
 =?gb2312?B?aFhsUTVCcnUxUWdpY2VXUlhnL1M0dDUzdzJYOG9EallyQ2p0eHJBcWExUzJR?=
 =?gb2312?B?Y2FVN3BKT1V3b1pGTFpwMHdmbGpKZDhTRzQrSUZteEZpZmRIZUl3a1A5QURR?=
 =?gb2312?B?b3ZFanBUSlg4MVF5OWsvRVExQXI3SE5oekJac3BsczRBMjI5UGsyOTViVUFr?=
 =?gb2312?B?TUpDd0NpZjFjTFhnVzFXd2dNWS9qMVJMS1JIRzVhZFRJS2lLY2c5R3hxVXU5?=
 =?gb2312?B?ai9VNHVlQ0IvSEFOKy9xQ2lRUHREeWU2RktKQXI5b3FWVFlUNHJHRVJMbEJs?=
 =?gb2312?B?akdoSks0SS9tSmVDNTJuZGl6d2hNNVk4K29vcThZMkl6ZHlUUFZKYkx5SWJj?=
 =?gb2312?B?N2hnenhBRHltZ2xxQW5GUDh2U2hwdWo3ZmxLQmRUV2hTUHFyTk55ZWc3RHVN?=
 =?gb2312?B?R0hGWW0yeVVPWU9jaDFydDRXeEFkTVRwTEpUR1VWS3pmaURhU3dtM2E4T1JK?=
 =?gb2312?B?aEhZS3Bua2hxS2tRS2xzRXQxUU1zMTFXMDZUb1d3SmVYVVdockJMSHdFMVFK?=
 =?gb2312?B?Uks5eUJvdEgxZWtFaHRuT25POURFY2E4USsyaVozSHNNZmx2bDI1L2pRWGFH?=
 =?gb2312?B?TzNGRlRESVlWUk4ralJhT0ZtQ2RDb3AzZWttamZ6cndyOHdoNnNPcE5PSDhC?=
 =?gb2312?B?cmVyMnNPWDVydlNEcnlGRHRnWG9SWnVWd2txeTFNeTk3ZUM2R3hsRFBpYnN6?=
 =?gb2312?B?ZnpJa21lR1VWWTZUQ3E5aEFrUUdodzNUcVk2cEJZMXZIQ210azE1S0szZzdG?=
 =?gb2312?B?RXo1RnVNdU4xMlZwMmdpMCtKOVpRQXFBUGowM2dFMW1zWWJNcitwNG12WGpD?=
 =?gb2312?B?MkU3bVdnTEh4Tkh6WlB3aStsaUtDd0pZTE1sUTBEMkxGUEZ3NDJUdVZ1bWxx?=
 =?gb2312?B?QWMweVZBWERvS2lWdTJGeC9MaUtHVzJwYVk5VUVQMW1QQnlJMWlVWHRFR09V?=
 =?gb2312?B?eVZxNzdTVHVYRklWajAwOG9ZUC9aZmQyS1lEclZ4b0VyZUFLVnFaRjVFcFdO?=
 =?gb2312?B?enFuS2RVLzQ4SHJTbENYcEh3eEVUemlnM0g4S3g2bDRzM0hVNi80cmFZeTlY?=
 =?gb2312?B?NEJqeW5PdkNHTjR5WHJCQlo0VEZlS2d3Tzc0Y200R1ZvTFZuVCs2azRKZVpt?=
 =?gb2312?B?SDRCejlneXZUTGp1L01YTmszMnR4SzdtdHo5QjJYNk1pMHVNMnIyUkJLbWxG?=
 =?gb2312?B?QkFhWnU0N1J1WnprWVI2RitCZjJkNkt1SlJkb0dkZ0REMzZYL0JuWm8vVDhC?=
 =?gb2312?Q?MZwgYbqbm41IYs7OANG0QG6nI3vIrVAxozci2MDJJE=3D?=
Content-ID: <98F4B975A84A2B44AB26C87DAACFCA9C@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4855d4f-ae34-4537-ccdf-08d9f282ccd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 02:03:04.5532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2xFBh/rVwjaS5uPyp3g4xqSpxJJ192yaXvleLN/KUZx9pdg/956k6z0WLcKVvi4NIDUGkB4F5+4QVGeZOwZ+HFPGICM13Ygy444kLbVKTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9459
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] regen.sh: tst_syscall(): Print again syscall
 number as string
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

Obviously correct, pushed.

Best Regards
Yang Xu
> Before 4913b0b298 tst_syscall() printed:
> TCONF: syscall(434) __NR_pidfd_open not supported
>
> After 4913b0b298 tst_syscall() printed only numbers:
> TCONF: syscall(434) 434 not supported on your arch
>
> Constant was passed to TST_SYSCALL_BRK__() as a number thus
> stringification didn't work as expected.
>
> Fixes: 4913b0b298 ("lapi,kernel: Replace ltp_syscall with tst_syscall")
>
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
>   include/lapi/syscalls/regen.sh | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/lapi/syscalls/regen.sh b/include/lapi/syscalls/regen.sh
> index 0b412ef6d9..3bf38fd034 100755
> --- a/include/lapi/syscalls/regen.sh
> +++ b/include/lapi/syscalls/regen.sh
> @@ -36,14 +36,14 @@ cat<<  EOF>  "${output_pid}"
>   #include "cleanup.c"
>
>   #ifdef TST_TEST_H__
> -#define TST_SYSCALL_BRK__(NR) ({ \\
> +#define TST_SYSCALL_BRK__(NR, SNR) ({ \\
>   	tst_brk(TCONF, \\
> -		"syscall(%d) " #NR " not supported on your arch", NR); \\
> +		"syscall(%d) " SNR " not supported on your arch", NR); \\
>   })
>   #else
> -#define TST_SYSCALL_BRK__(NR) ({ \\
> +#define TST_SYSCALL_BRK__(NR, SNR) ({ \\
>   	tst_brkm(TCONF, CLEANUP, \\
> -		"syscall(%d) " #NR " not supported on your arch", NR); \\
> +		"syscall(%d) " SNR " not supported on your arch", NR); \\
>   })
>   #endif
>
> @@ -56,7 +56,7 @@ cat<<  EOF>  "${output_pid}"
>   		tst_ret = syscall(NR, ##__VA_ARGS__); \\
>   	} \\
>   	if (tst_ret == -1&&  errno == ENOSYS) { \\
> -		TST_SYSCALL_BRK__(NR); \\
> +		TST_SYSCALL_BRK__(NR, #NR); \\
>   	} \\
>   	tst_ret; \\
>   })

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
