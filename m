Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66391C433F5
	for <ltp@archiver.kernel.org>; Thu, 23 Dec 2021 08:03:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F021C3C928A
	for <ltp@archiver.kernel.org>; Thu, 23 Dec 2021 09:03:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6B753C8DF8
 for <ltp@lists.linux.it>; Thu, 23 Dec 2021 09:03:44 +0100 (CET)
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com
 [68.232.152.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1C4D520119E
 for <ltp@lists.linux.it>; Thu, 23 Dec 2021 09:03:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1640246623; x=1671782623;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=8tp2dipzWTVc0uX3gN6lGzYtqEShY9aLKzPguThOSMc=;
 b=vcb2UsBQ1A5jS1WeYa2vGdDd0fN6OV9gm3tvGJ3dZiq7iYHwdbvN03RO
 zPTFP24Ui5xWssTou8oHyGpguVkS8o0yy8fFzme55IDOxt3qXsgUh/dFp
 J7BB1x8REveNQODHD/NRLCmaeWZEwuxwob8Oj+ES93XcHPV12itUpFtY4
 LbLgOKabx/Wfl0ufnydtxbFHpzsZSG177U4AHEmHXvUXnE9iJMa55bSfX
 Lcp6DJQCR52Qiam0SmWvAYwtRwt0Te3Y+UIP5P29Yaf9ZFzpv2LkTxFia
 sytYJyOvI/WGyCXvi1rN0hWXuf3Y8QbL0eZIUhk8FqObzRUwhd4qS90lJ Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="54767326"
X-IronPort-AV: E=Sophos;i="5.88,228,1635174000"; d="scan'208";a="54767326"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Dec 2021 17:03:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krkW+xN+pRasI7baMR6jrWIRZDC0DXSCpu4itKyUMITUslUxa4yoDHY3e+kS1FRwy2/4p/zGs1rWFPHieqnCIuNg5T8vgIhOk5M8YRpyWUhfsU3qsY84L4gsicbxuwB53IS+iTpKyPU+42HzEXychx7E9fX4N2ztQQaA6ttv3HGDtqjKsvcOOWmgG4xK3JOKTGgm+ogurf8Gsl5ZeV0Hx/PWdutAFjvjIZuGi4H8y0UmKOzC8qYXDye62YvEFzzYR14+2hOhNRtmpQVz5qbAO4d3cj9joPuRgy4HA1RuSkBpU7furRSQFKTSi3zCW+w3fG1EUYkkAD0p2zQQiz/CAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tp2dipzWTVc0uX3gN6lGzYtqEShY9aLKzPguThOSMc=;
 b=D1AkK+sNj19bPiS+Nungj6JlZJBxetgO4HbBxuiZC66dl7uktwYBK9sz9UEz9/yBubCQb3gJ0lzX128Tw7hruWBz9o5DNX1TW/m90tltswt3PzM4VSFPIWeFpReEGtj0ToX1iUZKJeg3VMbRTkrCQtN8jHQOh/a23w/2oD44r5mEPjmgDD/QAShai34ssSmKh9shrJqFMnKtnlAhZslYwnjSpCaQmkAzDxAYC+UeyOXALHtY/XjaC5ADn5scPwhKmGuPH1a7gWvp6yjJKKOgse6PDpvPoHHkq0ZbDVUc0aeTqFj6LMjyuhgAfYZUV9iqCjh+XuaTTinroDfJBqYlVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tp2dipzWTVc0uX3gN6lGzYtqEShY9aLKzPguThOSMc=;
 b=G7FDPCeoCNO3bqBa7pYd+96bNd9IDZu2UPuKMcMqM1q/CjQSfR0Ib2Xz7RMfoGRCU5fLY656sVuCTxHdBbIk2855VBtLIaV9VVQ53RTTB+H1uxvVGU64P/Z/4UL0O3TihwgvRquVKsNlF2FG9iHZmOa13YjS8aCXJZZgjAim478=
Received: from OS3PR01MB6535.jpnprd01.prod.outlook.com (2603:1096:604:100::7)
 by OS0PR01MB6482.jpnprd01.prod.outlook.com (2603:1096:604:e7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.17; Thu, 23 Dec
 2021 08:03:37 +0000
Received: from OS3PR01MB6535.jpnprd01.prod.outlook.com
 ([fe80::bc41:b2e4:2c49:8be3]) by OS3PR01MB6535.jpnprd01.prod.outlook.com
 ([fe80::bc41:b2e4:2c49:8be3%8]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 08:03:37 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v4 1/6] syscalls/quotactl08: Test quoatctl01 but quota
 info hidden in filesystem
Thread-Index: AQHX7/LHkAfOKvGU/ky0NkV6iB5JYKw/x1uA
Date: Thu, 23 Dec 2021 08:03:37 +0000
Message-ID: <61C42D69.4030305@fujitsu.com>
References: <YY0o7jAxgIHvmczq@yuki>
 <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96093a2b-72ff-494a-2a37-08d9c5eab9bb
x-ms-traffictypediagnostic: OS0PR01MB6482:EE_
x-microsoft-antispam-prvs: <OS0PR01MB648203E5BFA4CD6A7369DB43FD7E9@OS0PR01MB6482.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:142;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /5umB01l7uSgKhDm/BjKPpJXG88O43cIzG+qajJsNRlD3JRDuge3wgklkwpJcDeCglxg5nfXx77MoLe9VD/8khVGE9P7UAR+UFhQ0djTXs7VTUpzoHtKT7Ul+kicVzoDPX+6W8Er+f8yQMbJcOrxTzKF4guFyi5LLu86XExl+3Z1tlczA5mFnrXDOz78X85Hbpf4JnmpAA2SJjqLw0SEtnw2MVeoSmlwbjZdkrwDwdY3qejQJtAWIBxWO7bZbKVrGM9+j8oW68E8VcXXm9JIabZ5iuQ4Mizak/LNViwGRB8K8YgF6Z0UrRSjaFzzct/onDRpMHCFFq6pfXxahVMSjAG8iSCO/QE3mx9wmn0NdlRna0rRrROwnXBaOqoWbT1uE3dyKUdrCDaUG4R8+L0LfVublSJwNtYJDl/udMKY6BsWOi5D1U7wQAsTOb5T/m7HDLxFba1nqWW5eoUA6rv2X7ms/1OO6VSLmqZAm5zYgMf32WM8F8o9iTQ39zS3d65L6ui2LFTkHF1SDztkaei6JAlCQDCF4bsyH2Wx1cb/sLUpSqN+2PbsUAqw3FP0p4ulQ819qzGvGiewTPuavTZTizIT/UZAglbGi8DHzUmD0xu1L5hMU/j+CgoW/VpLV+KyPIUKQCah8UpPQ9XLQDXov/XP2fNq7Ibl6p6S9JMcBj7P9+6QMipRE4rMDoICxIR8jnnidXA3yGAB/RbwdH8YJgc/ki9vnMFUJ5aArWf9ulYvwZwnhnHORnaPq+RhgnGD5NnaJ/tIgLlF2dAER3fT4ZlksxYpl3CkS0gIDJP/xU0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6535.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(87266011)(33656002)(38070700005)(186003)(508600001)(6512007)(8676002)(82960400001)(26005)(6486002)(83380400001)(8936002)(38100700002)(316002)(6916009)(66476007)(86362001)(85182001)(76116006)(66946007)(16799955002)(30864003)(6506007)(36756003)(2906002)(5660300002)(2616005)(15650500001)(64756008)(66446008)(91956017)(66556008)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZjRPNXBDSTcxbzlqYzVORUwwT3NRN0o4Y0FaT2NHeFJBYWVOSkhEZG5JbHQ1?=
 =?gb2312?B?T0xRZ2xhRDNsaHZFVkdITU1pUHo5UnZCMVBRL3R4QTBPczhTczJOUUdpZUZt?=
 =?gb2312?B?TEhqMDRlTFJnZHNZNjNJcUhxSGt5RlJNZm91dE16cXE5RFRNNTc5VXFpcjlV?=
 =?gb2312?B?UWN6LzIrcGkxTEFBMmJuei9OZitMRFdQdnpHMXZPc2Z6UDFVb25RZXpQWk9Q?=
 =?gb2312?B?TDZ0MXBaVk5lN2NLcStjUGp4b3QwdFYvRjFxR3JBN085ZC9XMVRGUzVIVmxi?=
 =?gb2312?B?ZmVqZU1OSEtYekVOejZFWnA3VTBubDlCZ1g0STJ3S0swS1p3UzVmRDVKWDh0?=
 =?gb2312?B?UVV5WnA5RTg0UDBCTzhUOGluME85eGNUVHpjTFJ6c2Ruc3VwTjNDQVRPNGRx?=
 =?gb2312?B?UXJUczVGY0lTb1RZR0ZUYkxQeXdmcFREMXpmQ0oveTdoajJ6cEtEZmZJenJL?=
 =?gb2312?B?aU1SU1g3ZDk1UFhTVjd2SkNNVkZQU0hiNHRpelVBQjdkbjJiMEd4clJvMjNX?=
 =?gb2312?B?OWRDelNmVTdidE5xVTJqekNTOFFHZmN0YmRScGtQbUhyRzM0QktKN3IxdWlm?=
 =?gb2312?B?Z3dSVml3S2taSXVSVVN3Y3ZpSFRJekszSllTc0NtK044VGNCRVBJRnhyR2sv?=
 =?gb2312?B?R2E3eXl5V2N6MXJONG9lOXBzb1VKQW1BS2VadGNQRkh3WXpiNm14OWdEaFBx?=
 =?gb2312?B?T1JhbWdHUFBzclJjYmx0WkZsT1J5MnVaT0drUE5PWjlFc0lRVTVhbnRSb0dX?=
 =?gb2312?B?bWtjQzlmWExLWGw4TXFVWWtNUmhlczZxMzQrS29WWDJUWldMRmo1emlKZjdu?=
 =?gb2312?B?ZGRPNEVYczRqRnM5aTdWV0hwY2RyT1ZqWDhpZC91cEVFcGw3b1ZOeDBWM0Y5?=
 =?gb2312?B?OE5qRlBqdVdRSU0zQ0gzbEZ6RldldDRrT1hBWUVKRXFxMUpBa1RyYTVXb1dO?=
 =?gb2312?B?VXRBcElxOTEyWS93U1BJSm1iM1J4SUoySzRLTFpwbm42ZTFjRHZLTlVZZmlP?=
 =?gb2312?B?MWtKeEplUHA0bEJDVnBheGhCZDg5cDFRWlpvNjVoZTR5a3lka3Nac2RNRkJw?=
 =?gb2312?B?cEpVYWVnRC9yZERNdDdPa3FTbUNubDhKRkFsdFFoWWQzYjVVSEVQT2RKYVVE?=
 =?gb2312?B?TC9CTFJTcVdSZkdKUmtSOUJGWFgxdEpRTGs1Lzg4MVpmTmZkVmY5d1BiWkVP?=
 =?gb2312?B?T0pTU2kxRnpNemFyS2E0ODFEVUN2czNsV2gyREgvRklKMjBVYS9zeHJ3b2hC?=
 =?gb2312?B?UGlsSGFYajZzTWNGM0kyd21Id1JVemprbzJZL24xaStmVnJsdVdFR2FkUEx1?=
 =?gb2312?B?OENONEkzb1QzdWlQMElUdGZzUm5xOFF6WmxZdjBxbTVuOGdBdTU4KzR2dWVC?=
 =?gb2312?B?NXZsYy8xYTZXN2pGZExwN0laeXBhNzFQS091TC92WktHM210QU5iclhKQk4w?=
 =?gb2312?B?OUR3YzgzMHRRQmJuWVJmNE5HZFV3NVFuQTROUnFsMGNBZkNSa0JPWnVSSUwr?=
 =?gb2312?B?cG9IQjE1SkY0ZytpZVFwdk1ZTFloYzNVMkplcGZ6bm1XalN2cm1IbWV5bUNJ?=
 =?gb2312?B?aXA5NzcrYTBYdDlPSHpjSVVPSlRiWGxxeXExRWVIZXFvaXc2dnFVemZzdmhK?=
 =?gb2312?B?SG5SY1N2RURhcU40SkhFY3hMMmZhRGJ1QURydFpsWEoxK3dMTkJvNlBhLzVB?=
 =?gb2312?B?WnhLOVVLb0IxVWx5ZTdOVkIyeGw5T3BDWk55aXZNQUNRaHBDQlRuZEtLUjZP?=
 =?gb2312?B?K3FQSGJwc2RwbUVmd1U1WmF3ZXBqZ2N2UzNXanR2TDVobm9WbUNoWk4vZitJ?=
 =?gb2312?B?RzB3U3dVS0VOZUw3dFZyaWRBQWVPeWZRcWo1UXJ1R2o2TWVGVXkrYjBndTN3?=
 =?gb2312?B?Y0YyUjBtaVUwM2pTRGdNcVE0MGNFeitsQ0xwdzN4QnN2NTJiOEdVTmJGekYw?=
 =?gb2312?B?bVJSU1BrcWFDU2VEK3NsTVNnSEc0ZTZ0M29HMjFhMEQ2SWk2S0xKSHNtRHli?=
 =?gb2312?B?ejlzaGRnMi9sVlk3RCtoaTdZVUVsSEVqNnQzYmxjTUVoUEw0NC92YVNkVzBl?=
 =?gb2312?B?djEvZ0JLR0llV3VnZVJORGlQdDR6c0JERGVtVXBmSEEyVTFRSE40dlVORE5u?=
 =?gb2312?B?aVFOREdteDBYbjJNUEpsdnVsU1ZxdElqQ3NEQWdvZjNIUnJVQ21nTFFnNDNn?=
 =?gb2312?B?UnZubUl2ZEFraGUzeGhoV29IcGVGRTlvR0ZabWY5T3ZhT1IrMDV0T0lORXdN?=
 =?gb2312?Q?P4QhnGBNMYE0COBIsAfHD7TV1HaO4vEsKfIqwInXX4=3D?=
Content-ID: <EC8DE80EA187904591A9A6E9401C1808@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6535.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96093a2b-72ff-494a-2a37-08d9c5eab9bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2021 08:03:37.8081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Iy1HNJdWfsaAcwzZflizA7/EbxISFZVbDP9IdCY+zjjn9NIus/48RoTretoTsGibJo0qLOyuzAaLX2+A8kSAk+kkV5eb/ixdsNTl4aszS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6482
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/6] syscalls/quotactl08: Test quoatctl01 but
 quota info hidden in filesystem
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi

Ping.

Best Regards
Yang Xu

> It uses two variants(quotactl and quotactl_fd). The difference for quotactl01
> is that we don't use quotacheck command and quota info hidden in filesystem.
> 
> It also needs mkfs.ext4 supports quota feature.  This feature is disabled[1]
> before e2fsprog 1.42 when not specifying a --enable-quota option in compile-time
> and e2fsprog 1.43 remove this disable[2]. So we should limit the e2fsprog to 1.43.
> 
> [1]https://ext4.wiki.kernel.org/index.php/Quota
> [2]https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/commit/?h=v1.43&id=9e8fcd6e
> 
> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> ---
>   runtest/syscalls                              |   1 +
>   testcases/kernel/syscalls/quotactl/.gitignore |   1 +
>   .../kernel/syscalls/quotactl/quotactl08.c     | 228 ++++++++++++++++++
>   .../syscalls/quotactl/quotactl_syscall_var.h  |  32 +++
>   4 files changed, 262 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/quotactl/quotactl08.c
>   create mode 100644 testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index bcf3d56c9..c795b9101 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1071,6 +1071,7 @@ quotactl04 quotactl04
>   quotactl05 quotactl05
>   quotactl06 quotactl06
>   quotactl07 quotactl07
> +quotactl08 quotactl08
> 
>   read01 read01
>   read02 read02
> diff --git a/testcases/kernel/syscalls/quotactl/.gitignore b/testcases/kernel/syscalls/quotactl/.gitignore
> index 8d2ef94d9..dab9b3420 100644
> --- a/testcases/kernel/syscalls/quotactl/.gitignore
> +++ b/testcases/kernel/syscalls/quotactl/.gitignore
> @@ -5,3 +5,4 @@
>   /quotactl05
>   /quotactl06
>   /quotactl07
> +/quotactl08
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
> new file mode 100644
> index 000000000..1b8f1cd2b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved
> + * Author: Yang Xu<xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + * This testcases checks that quotactl(2) on ext4 filesystem succeeds to:
> + *
> + * - turn on quota with Q_QUOTAON flag for user
> + * - set disk quota limits with Q_SETQUOTA flag for user
> + * - get disk quota limits with Q_GETQUOTA flag for user
> + * - set information about quotafile with Q_SETINFO flag for user
> + * - get information about quotafile with Q_GETINFO flag for user
> + * - get quota format with Q_GETFMT flag for user
> + * - update quota usages with Q_SYNC flag for user
> + * - get disk quota limit greater than or equal to ID with Q_GETNEXTQUOTA flag for user
> + * - turn off quota with Q_QUOTAOFF flag for user
> + * - turn on quota with Q_QUOTAON flag for group
> + * - set disk quota limits with Q_SETQUOTA flag for group
> + * - get disk quota limits with Q_GETQUOTA flag for group
> + * - set information about quotafile with Q_SETINFO flag for group
> + * - get information about quotafile with Q_GETINFO flag for group
> + * - get quota format with Q_GETFMT flag for group
> + * - update quota usages with Q_SYNC flag for group
> + * - get disk quota limit greater than or equal to ID with Q_GETNEXTQUOTA flag for group
> + * - turn off quota with Q_QUOTAOFF flag for group
> + *
> + * It is similar to quotactl01.c, only two difference
> + * - use new quotactl_fd syscalls if supports
> + * - quota file hidden in filesystem
> + *
> + * Minimum e2fsprogs version required is 1.43.
> + */
> +
> +#include<errno.h>
> +#include<string.h>
> +#include<unistd.h>
> +#include "tst_test.h"
> +#include "quotactl_syscall_var.h"
> +
> +#define MNTPOINT	"mntpoint"
> +
> +static int32_t fmt_id = QFMT_VFS_V1;
> +static int test_id, mount_flag;
> +static struct dqblk set_dq = {
> +	.dqb_bsoftlimit = 100,
> +	.dqb_valid = QIF_BLIMITS
> +};
> +static struct dqblk res_dq;
> +
> +static struct dqinfo set_qf = {
> +	.dqi_bgrace = 80,
> +	.dqi_valid = IIF_BGRACE
> +};
> +static struct dqinfo res_qf;
> +static int32_t fmt_buf;
> +static int getnextquota_nsup;
> +
> +static struct if_nextdqblk res_ndq;
> +
> +static struct tcase {
> +	int cmd;
> +	int *id;
> +	void *addr;
> +	void *set_data;
> +	void *res_data;
> +	int sz;
> +	char *des;
> +	char *tname;
> +} tcases[] = {
> +	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, NULL,
> +	NULL, NULL, 0, "turn on quota for user",
> +	"QCMD(Q_QUOTAON, USRQUOTA)"},
> +
> +	{QCMD(Q_SETQUOTA, USRQUOTA),&test_id,&set_dq,
> +	NULL, NULL, 0, "set disk quota limit for user",
> +	"QCMD(Q_SETQUOTA, USRQUOTA)"},
> +
> +	{QCMD(Q_GETQUOTA, USRQUOTA),&test_id,&res_dq,
> +	&set_dq.dqb_bsoftlimit,&res_dq.dqb_bsoftlimit,
> +	sizeof(res_dq.dqb_bsoftlimit), "get disk quota limit for user",
> +	"QCMD(Q_GETQUOTA, USRQUOTA)"},
> +
> +	{QCMD(Q_SETINFO, USRQUOTA),&test_id,&set_qf,
> +	NULL, NULL, 0, "set information about quotafile for user",
> +	"QCMD(Q_SETINFO, USRQUOTA)"},
> +
> +	{QCMD(Q_GETINFO, USRQUOTA),&test_id,&res_qf,
> +	&set_qf.dqi_bgrace,&res_qf.dqi_bgrace, sizeof(res_qf.dqi_bgrace),
> +	"get information about quotafile for user",
> +	"QCMD(Q_GETINFO, USRQUOTA)"},
> +
> +	{QCMD(Q_GETFMT, USRQUOTA),&test_id,&fmt_buf,
> +	&fmt_id,&fmt_buf, sizeof(fmt_buf),
> +	"get quota format for user",
> +	"QCMD(Q_GETFMT, USRQUOTA)"},
> +
> +	{QCMD(Q_SYNC, USRQUOTA),&test_id,&res_dq,
> +	NULL, NULL, 0, "update quota usages for user",
> +	"QCMD(Q_SYNC, USRQUOTA)"},
> +
> +	{QCMD(Q_GETNEXTQUOTA, USRQUOTA),&test_id,&res_ndq,
> +	&test_id,&res_ndq.dqb_id, sizeof(res_ndq.dqb_id),
> +	"get next disk quota limit for user",
> +	"QCMD(Q_GETNEXTQUOTA, USRQUOTA)"},
> +
> +	{QCMD(Q_QUOTAOFF, USRQUOTA),&test_id, NULL,
> +	NULL, NULL, 0, "turn off quota for user",
> +	"QCMD(Q_QUOTAOFF, USRQUOTA)"},
> +
> +	{QCMD(Q_QUOTAON, GRPQUOTA),&fmt_id, NULL,
> +	NULL, NULL, 0, "turn on quota for group",
> +	"QCMD(Q_QUOTAON, GRPQUOTA)"},
> +
> +	{QCMD(Q_SETQUOTA, GRPQUOTA),&test_id,&set_dq,
> +	NULL, NULL, 0, "set disk quota limit for group",
> +	"QCMD(Q_SETQUOTA, GRPQUOTA)"},
> +
> +	{QCMD(Q_GETQUOTA, GRPQUOTA),&test_id,&res_dq,&set_dq.dqb_bsoftlimit,
> +	&res_dq.dqb_bsoftlimit, sizeof(res_dq.dqb_bsoftlimit),
> +	"set disk quota limit for group",
> +	"QCMD(Q_GETQUOTA, GRPQUOTA)"},
> +
> +	{QCMD(Q_SETINFO, GRPQUOTA),&test_id,&set_qf,
> +	NULL, NULL, 0, "set information about quotafile for group",
> +	"QCMD(Q_SETINFO, GRPQUOTA)"},
> +
> +	{QCMD(Q_GETINFO, GRPQUOTA),&test_id,&res_qf,&set_qf.dqi_bgrace,
> +	&res_qf.dqi_bgrace, sizeof(res_qf.dqi_bgrace),
> +	"get information about quotafile for group",
> +	"QCMD(Q_GETINFO, GRPQUOTA)"},
> +
> +	{QCMD(Q_GETFMT, GRPQUOTA),&test_id,&fmt_buf,
> +	&fmt_id,&fmt_buf, sizeof(fmt_buf), "get quota format for group",
> +	"QCMD(Q_GETFMT, GRPQUOTA)"},
> +
> +	{QCMD(Q_SYNC, GRPQUOTA),&test_id,&res_dq,
> +	NULL, NULL, 0, "update quota usages for group",
> +	"QCMD(Q_SYNC, GRPQUOTA)"},
> +
> +	{QCMD(Q_GETNEXTQUOTA, GRPQUOTA),&test_id,&res_ndq,
> +	&test_id,&res_ndq.dqb_id, sizeof(res_ndq.dqb_id),
> +	"get next disk quota limit for group",
> +	"QCMD(Q_GETNEXTQUOTA, GRPQUOTA)"},
> +
> +	{QCMD(Q_QUOTAOFF, GRPQUOTA),&test_id, NULL,
> +	NULL, NULL, 0, "turn off quota for group",
> +	"QCMD(Q_QUOTAOFF, GRPQUOTA)"},
> +};
> +
> +static void setup(void)
> +{
> +	const char *const fs_opts[] = { "-O quota", NULL};
> +
> +	quotactl_info();
> +
> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
> +	mount_flag = 1;
> +
> +	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
> +	TEST(do_quotactl(fd, QCMD(Q_GETNEXTQUOTA, USRQUOTA), tst_device->dev,
> +		0, (void *)&res_ndq));
> +	if (TST_ERR == EINVAL || TST_ERR == ENOSYS)
> +		getnextquota_nsup = 1;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd>  -1)
> +		SAFE_CLOSE(fd);
> +	if (mount_flag&&  tst_umount(MNTPOINT))
> +		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
> +}
> +
> +static void verify_quota(unsigned int n)
> +{
> +	struct tcase *tc =&tcases[n];
> +
> +	res_dq.dqb_bsoftlimit = 0;
> +	res_qf.dqi_igrace = 0;
> +	fmt_buf = 0;
> +	res_ndq.dqb_id = -1;
> +
> +	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
> +	if ((tc->cmd == QCMD(Q_GETNEXTQUOTA, USRQUOTA) ||
> +		tc->cmd == QCMD(Q_GETNEXTQUOTA, GRPQUOTA))&&
> +		getnextquota_nsup) {
> +		tst_res(TCONF, "current system doesn't support this cmd");
> +		return;
> +	}
> +	TEST(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "quotactl failed to %s", tc->des);
> +		return;
> +	}
> +
> +	if (memcmp(tc->res_data, tc->set_data, tc->sz)) {
> +		tst_res(TFAIL, "quotactl failed to %s", tc->des);
> +		tst_res_hexd(TINFO, tc->res_data, tc->sz, "retval:   ");
> +		tst_res_hexd(TINFO, tc->set_data, tc->sz, "expected: ");
> +		return;
> +	}
> +
> +	tst_res(TPASS, "quotactl succeeded to %s", tc->des);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_QFMT_V2",
> +		NULL
> +	},
> +	.test = verify_quota,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.mntpoint = MNTPOINT,
> +	.dev_fs_type = "ext4",
> +	.needs_device = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
> +	.needs_cmds = (const char *[]) {
> +		"mkfs.ext4>= 1.43.0",
> +		NULL
> +	}
> +};
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h b/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h
> new file mode 100644
> index 000000000..3d1a2c8f5
> --- /dev/null
> +++ b/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu<xuyang2018.jy@fujitsu.com>
> + */
> +
> +#ifndef LTP_QUOTACTL_SYSCALL_VAR_H
> +#define LTP_QUOTACTL_SYSCALL_VAR_H
> +
> +#include "lapi/quotactl.h"
> +
> +#define QUOTACTL_SYSCALL_VARIANTS 2
> +#define MNTPOINT "mntpoint"
> +
> +static int fd = -1;
> +
> +static int do_quotactl(int fd, int cmd, const char *special, int id, caddr_t addr)
> +{
> +	if (tst_variant == 0)
> +		return quotactl(cmd, special, id, addr);
> +	return quotactl_fd(fd, cmd, id, addr);
> +}
> +
> +static void quotactl_info(void)
> +{
> +	if (tst_variant == 0)
> +		tst_res(TINFO, "Test quotactl()");
> +	else
> +		tst_res(TINFO, "Test quotactl_fd()");
> +}
> +
> +#endif /* LTP_QUOTACTL_SYSCALL_VAR_H */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
