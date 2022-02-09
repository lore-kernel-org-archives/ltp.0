Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF51C433F5
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 10:00:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2E433C9B8E
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 11:00:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECF803C24D6
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 11:00:40 +0100 (CET)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D5C516011E5
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 11:00:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1644400840; x=1675936840;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=/Y4vWRWr7BZQ63Lvq+b3GQMB2BXKHs81859MKfopm+4=;
 b=YTe4Jz7iAgnwtsTsZWeyXCBodnFaPG1mJNWvOi0z21chfR1G+7Mfq8Yd
 kM7WmjiUdyc+pLmQWZ6gsiP1a4QTwRRrrf35ezNdCKxKsjZVVEBGBvNlo
 aonwKNB3ltWNac3Qfx71fEp43b5UQwzaCCC6QksSVZcAYSXfquAHWA5uP
 E4XVEAPh8+Bz4EeeA3F+Xt8JV/SbTDITfWCWeyhkHNZ0KCcZNRZJ1XqTh
 tXCkLs/fs+sYt2Vk7asAZO0GDr+XLfhpRvVs6YLtWThXiRa408om1BGrb
 Vt+fyfh21OEJ5Ro6vuLG1pn984rb0GRAvegkpRHQfoFZhF00WowPF96Uy A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="49371373"
X-IronPort-AV: E=Sophos;i="5.88,355,1635174000"; d="scan'208";a="49371373"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2022 19:00:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieBMm4Z7bIOExjqkQ/053qLMXQ0379JPa+wf7rW9he9oUz3k91fFQZN7GDEk1d46WcEk7kqjED8GZGB8LHlmfunlhHQfFtlKG69bVp1le8eRvZr+TWkSXPBpPzl0C4RTjTZDgALLP5fefICRIpZMvIrS9znG+yW1/msCAALbslp3tstV0vQb6OeQjoV4knLCuIzezG/IzlcRVYQlbtl49N2Yq0+4HA+6nI+I5kl36ZzPTxf/0R+903LxvFNwomcaZU3yONJUVaXE7Q/A3TC+eon1t2sZH+s27Hn20i/8Hpl4ZzO3Yy4knFPD6q0zZdHGYPsnh++ZRSeZRp16gZEGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Y4vWRWr7BZQ63Lvq+b3GQMB2BXKHs81859MKfopm+4=;
 b=ImMYaQNVBzUHcOgvlr+2GCn1AoYwaHKF/FbzDbaGOVWfyr2d2CrBh0fDzqJwyW7SNNcsf1DxAsliUKLSzVjpSgRjIWZ5gcPNVCSKJFyWP2c7w7i1l/JQqbANGLESpMpobTAEAzPP/T5Ndlt8OSrwUFtfVz91RYBwP9non77w78HXmv7rw8CoRTlGYUp9ifGhxBGqbMchr27PWCL8oYDX8i9k76A1YhvBS97D2qMfNK94rtzCGSzxm5Ojl+lKktvJfhDF3tFqgbhx4k/0XyNO3utk94jfXkBNcIy9i4tjlsJnHbdZfB50Kt4qEc2oWRvX0kmSSvlD69uD9RYzuLF/uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Y4vWRWr7BZQ63Lvq+b3GQMB2BXKHs81859MKfopm+4=;
 b=MCEl8VM1VF0bGLTc3k989xhODxbhF8P6JP2AywuRzCmJefZ3VsuhGueHHSY52Zsel1BPU12eXCxYjre+XHdykdvROpcEMSF3o0BS6IoOF0lEqKrbZNZEy4bIMRfRNwwK9l1d5m1EZIXFNosjczoKY3viWPy0lcS1MBcg43DZlew=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSBPR01MB1527.jpnprd01.prod.outlook.com (2603:1096:603:3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 10:00:35 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 10:00:35 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH 1/2] syscalls/pidfd_open: Simplify code
Thread-Index: AQHYHZlRfU2P3yMF7k2B22YjBeyn7ayK/L8A
Date: Wed, 9 Feb 2022 10:00:35 +0000
Message-ID: <620390EA.7060900@fujitsu.com>
References: <1644399738-2155-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1644399738-2155-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1700f05-cccf-40de-7133-08d9ebb3043f
x-ms-traffictypediagnostic: OSBPR01MB1527:EE_
x-microsoft-antispam-prvs: <OSBPR01MB15279E63FBF5F2140BDCB98AFD2E9@OSBPR01MB1527.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:411;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wDHhYgtZdfnkEitYSgykmxrf0VLDN4WGLYg6JUZlWZLE0kzcQuWYLTSDWHrkp4ZbpdCkGHWQ9Grb6qV3YCdzaIVkfMcoGMbRfLOmxDewqiion9tNmdto7nD2NSRkDmkW5CUk2C9qbqEzRsH41s1G2b743OkKFvhunsNknGDJhyn8LF6g5ApEfqVRtsQfrFC27xZPA1WgMu4gC2XAkG9OE0z8fzfOAPMEbyKVGGdBNys9EGl4Z+ZFIj1zapPFPci/6cRvK2IENfFBCn4YcaRnCb9wl5DXrP7fAitEbwGSNXpNFVgp7ZAmODlyRdjL1o6YZhOzweJQfxvLLhMdKZF4iwkZPlvuQTLt9MUfMrgsb0pbaYwZQDwCR6dP+EK/oF7LdytmgAbm1JDzHusQIMj2YMiqRUPk5ARR+wrNa88JmvEwfkJCdHB0bbXajDGxDa4VHIhZAwdaNXDpKKxGHE/aduG9PHHnfKUvNENHLvKS+jRI8F1fOGtOFXCbeH9HLc+eTbwbete3k9gt75oC1zxUgNRrh490uXTB/1AHGOyNQxr5u1Eg6h6aX6IQ9X7AOaCQrRc3Dgr5V0zF0NeLdADf1zpNdwcxnXURjCqeLZS1oVh8Gaqzfog0kEoqftsMcTLAHDS1AWYWfVnjpRbarknAFT7BVXUiC9qA5gbI/3xzFV5TZ0xQZml2k5yuCq/goy+k4mLz8UIcywdkfiHedMvovQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(76116006)(38100700002)(66446008)(8676002)(66946007)(316002)(2616005)(6506007)(91956017)(66476007)(66556008)(6512007)(8936002)(508600001)(71200400001)(87266011)(64756008)(36756003)(86362001)(85182001)(83380400001)(5660300002)(186003)(82960400001)(6486002)(26005)(6916009)(38070700005)(2906002)(33656002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Y0h5bzd6aUVsQy9JQVU3Wk1uK1VjT2VqOVkzNGV4aWJSZEpQWFpFZ3NJaW54?=
 =?gb2312?B?Y3VTSnJmUk9XbnNSdjE2MWR0M3JzdzFiUEphOWQwcm1GTFArSG8wUHJlaXNp?=
 =?gb2312?B?VjVLM1RYeExORDNXWXBlSlh3anhDZGV3TTgrTlRSaTRCYithdGN0c1A0Z1BV?=
 =?gb2312?B?ZGJYUFIydXdsVXBLSTlTZjZGZVI1YWpBRGdmMUoxdVZuQjI2UC9YMXhEWnA5?=
 =?gb2312?B?WEFXcDJsenBSdkpFakt1NndZNGFpMHZHRFVCZUxGQ1NBWGxqaEx2ZnpPYkhU?=
 =?gb2312?B?RWdUcWwyekdBcFQ3bFY2OWxlZlMvVzk5MTU0SERvUXc0aSszUDd4aFdLbkNN?=
 =?gb2312?B?K2JpaW16KzlDUGIzLzVvUi9xWG1yNk1oTDFyVEpXRUtSZmFlS0s3ckpKMWJj?=
 =?gb2312?B?b0hJbWlzZUd4eEhRQWdvS1NtSjBKOERndzBoaDVUQk5FWWRnSFFsNk1rdjZk?=
 =?gb2312?B?eHJUaXgySU1CdnczNTFTSXJ4S3BmcENaY0dNNWgrMFA3UkFGWUVMaDljQksy?=
 =?gb2312?B?YzVpTVVHRjRnaUM1cndBelIyWFhGQ3BZWFByNzFmWHJrRzZOamhmS3VpMjB2?=
 =?gb2312?B?WFd5L2M2di9XOVdOSzdybDRrVHh6ZXpnNVJURWRLQWFOWTByR3JMaTEyUERQ?=
 =?gb2312?B?ZHc2V1A5cVQ1bkVmeEtaUTE3S1NUVGRNUzIrN0l3bktrRjd4WW42MFljdGda?=
 =?gb2312?B?YWQvTnd0cW15SnQxR3dlZnA2alJacE1xcks3bENtOUJGMktvQVNMSU5kdC9m?=
 =?gb2312?B?a3Y4QWpvcVZkaUdKKzJWTncrMndxdjR3dWVWbm82UFpKNkhKR1llOTluVDNN?=
 =?gb2312?B?OElBZUZBMVpSY0ZrMjdZWWFINXhHS0IvVnFhQndySmdaUSs1VmpLQUo3WnpP?=
 =?gb2312?B?MG81Nm9LOCt4eGduM0xvL1VQZUM1dE9BSHd1ZW9CZ1l0eXFKTzFVVFBIQzhW?=
 =?gb2312?B?SUxpaGwrT1hCVnVxSXhXUCtpODRhWjB5SGhaTmJrWXdSRTBBaUUzczhUWUhJ?=
 =?gb2312?B?YXdpcDhPK3hLTHZ2ZWFPQ05MK2s3c2RsZFdtSG1RNGhBN0JpcW4vczR5eFFX?=
 =?gb2312?B?aTZNMnlVUEFhNmpIYzNzVEcxVEY5Rkg2cWg3R0R6ODlmakcxR2J6NVVtTkdI?=
 =?gb2312?B?a1dKZzZCS3VOajIvc3VKWUJvV2RwaURaVFY0L2lvYnhiRU1ZbTRRcllqeW9I?=
 =?gb2312?B?b3FNT0xMeWVaZWtyQkd5bk5aQUp4dEtnK0pQZVRJcDA1K2F1TFpDQloreGVi?=
 =?gb2312?B?ek4rZnNEWmZtNW9QSjRsTTdOOVZhQmpvRWsrak5CUDEvWkNKaWQ5WkxycnQy?=
 =?gb2312?B?TDFNNzBjMmo2VmFMMnl3TnkySzBSSU5uSG44QVNpbkg0MWhqNE5pWHhwdmJB?=
 =?gb2312?B?OVZCRVFDMlFPRHpLdzFrdzV6SjJEL2dXRVdXMjdPK2tTcC9FU3BSMy9zN0do?=
 =?gb2312?B?Q0k0YkRxL2QrN0JDNTVlV2tJS3ZEMWYwQ2M2WTIzMHRFNDMrbGREZ01Cdlk4?=
 =?gb2312?B?WVB6VThiV3RZaGtIZUVWRHJmemJ1TmlyK1NkVDdzaVA0ZGgremhkVUk2R3RG?=
 =?gb2312?B?WVBkOCtMd1JHTHB1emdlTDlaWU9JMDNRZi9kUjNjeTJLYUJMaVRLczdLZ2xC?=
 =?gb2312?B?S25JMm9SOE9NR2pzY1Y3aFhBb1BDclU4eURqajJnS1VLZ3diekMzaitmYjVY?=
 =?gb2312?B?ZDRpUWIvWXVYUG0wR2NQc1BQVHZCWGFjYXhrYzlscXZJNzhBTmNRLzVjaFl1?=
 =?gb2312?B?L3RaVjFqRyszQS9GdlhhMlRlSlIvU3hBUUYrekgzRFpEcCtubDF2RU5RUGpV?=
 =?gb2312?B?TE5CTmI2NDVHQzVZTnk2NWlnMkdOZUc4ZnZVd3ZSQitwc1FhK3BHa1NjbDlW?=
 =?gb2312?B?bW45dUlhY3p1MmdFQlRoN2s4TkFpQTZaQUZ4UEhNbnoxdjAvK2dldSt5STI3?=
 =?gb2312?B?b3VNaTVGMjNUWm1aajV1VVJyNStLYmRPblhyQ3grTWMwaVpadWtPTVhoQjNq?=
 =?gb2312?B?azQ2ZVJLMit1VWtNQW1VSkxrbklKSUJ3VE05RkFrTVNTR0t5d2lraWNkc3Z0?=
 =?gb2312?B?S0xjejNqaUgzRmxrcTBGNHp4dUl5Q0pDOGdPRm1jaTJQSkR3c2NoRU5XZlFZ?=
 =?gb2312?B?Yjk2M0RKS0tSZk96TWkzSTN4QXF6dVgxdUplODN6Wm9McnV2aUl4YlBQNHRr?=
 =?gb2312?B?OG1QUzNUN0FuMGUrQi81Q0hLUmZLRTB6VEdwVDlYdW1RSHNkS2N0c2tET29y?=
 =?gb2312?Q?mZGe6pNAQYtCStKvIXSJOblQ776UU6wuxhSYdd5ado=3D?=
Content-ID: <8204DE53E480D346B6B61DC094B86530@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1700f05-cccf-40de-7133-08d9ebb3043f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 10:00:35.1794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erA2MnMdFfGS6Nda59yKpqwposs2BCBZO3nII+6LfMnQqcHBV7pPFnnlVJdZEOpnqWH7t/JxKIkzQw93FZvkim6UCGDFqcQGDKHpiwRZJyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1527
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/pidfd_open: Simplify code
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

Hi All

It seems I should use TST_EXP_FD_SILENT instead of TST_EXP_PID_SILENT.

Best Regards
Yang Xu
> 1) make use of TST_EXP_FAIL2 or TST_EXP_PID_SILENT macros
> 2) remove min_kver check and use pidfd_open_supported()
> 3) Add docparse formatting
> 
> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> ---
>   include/lapi/pidfd_open.h                     |  8 +++--
>   .../kernel/syscalls/pidfd_open/pidfd_open01.c | 22 +++++++-----
>   .../kernel/syscalls/pidfd_open/pidfd_open02.c | 34 +++++++------------
>   .../kernel/syscalls/pidfd_open/pidfd_open03.c | 16 ++++++---
>   4 files changed, 44 insertions(+), 36 deletions(-)
> 
> diff --git a/include/lapi/pidfd_open.h b/include/lapi/pidfd_open.h
> index 9806c73d4..5cf10933e 100644
> --- a/include/lapi/pidfd_open.h
> +++ b/include/lapi/pidfd_open.h
> @@ -9,11 +9,15 @@
> 
>   #include<sys/syscall.h>
>   #include<sys/types.h>
> -
>   #include "lapi/syscalls.h"
> -
>   #include "config.h"
> 
> +static inline void pidfd_open_supported(void)
> +{
> +	/* allow the tests to fail early */
> +	tst_syscall(__NR_pidfd_open);
> +}
> +
>   #ifndef HAVE_PIDFD_OPEN
>   static inline int pidfd_open(pid_t pid, unsigned int flags)
>   {
> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
> index f40e9b624..ed9b82637 100644
> --- a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
> @@ -1,11 +1,15 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) 2020 Viresh Kumar<viresh.kumar@linaro.org>
> + */
> +
> +/*\
> + * [Description]
>    *
> - * Description:
>    * Basic pidfd_open() test:
> - * 1) Fetch the PID of the current process and try to get its file descriptor.
> - * 2) Check that the close-on-exec flag is set on the file descriptor.
> + *
> + * - Fetch the PID of the current process and try to get its file descriptor.
> + * - Check that the close-on-exec flag is set on the file descriptor.
>    */
> 
>   #include<unistd.h>
> @@ -17,10 +21,7 @@ static void run(void)
>   {
>   	int flag;
> 
> -	TEST(pidfd_open(getpid(), 0));
> -
> -	if (TST_RET == -1)
> -		tst_brk(TFAIL | TTERRNO, "pidfd_open(getpid(), 0) failed");
> +	TST_EXP_PID_SILENT(pidfd_open(getpid(), 0), "pidfd_open(getpid(), 0)");
> 
>   	flag = fcntl(TST_RET, F_GETFD);
> 
> @@ -35,7 +36,12 @@ static void run(void)
>   	tst_res(TPASS, "pidfd_open(getpid(), 0) passed");
>   }
> 
> +static void setup(void)
> +{
> +	pidfd_open_supported();
> +}
> +
>   static struct tst_test test = {
> -	.min_kver = "5.3",
> +	.setup = setup,
>   	.test_all = run,
>   };
> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
> index dc86cae7a..93a61a51d 100644
> --- a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
> @@ -1,14 +1,21 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) 2020 Viresh Kumar<viresh.kumar@linaro.org>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Tests basic error handling of the pidfd_open syscall.
>    *
> - * Description:
> - * Basic pidfd_open() test to test invalid arguments.
> + * - ESRCH the process specified by pid does not exist
> + * - EINVAL pid is not valid
> + * - EINVAL flags is not valid
>    */
>   #include "tst_test.h"
>   #include "lapi/pidfd_open.h"
> 
> -pid_t expired_pid, my_pid, invalid_pid = -1;
> +static pid_t expired_pid, my_pid, invalid_pid = -1;
> 
>   static struct tcase {
>   	char *name;
> @@ -23,6 +30,7 @@ static struct tcase {
> 
>   static void setup(void)
>   {
> +	pidfd_open_supported();
>   	expired_pid = tst_get_unused_pid();
>   	my_pid = getpid();
>   }
> @@ -31,27 +39,11 @@ static void run(unsigned int n)
>   {
>   	struct tcase *tc =&tcases[n];
> 
> -	TEST(pidfd_open(*tc->pid, tc->flags));
> -
> -	if (TST_RET != -1) {
> -		SAFE_CLOSE(TST_RET);
> -		tst_res(TFAIL, "%s: pidfd_open succeeded unexpectedly (index: %d)",
> -			tc->name, n);
> -		return;
> -	}
> -
> -	if (tc->exp_errno != TST_ERR) {
> -		tst_res(TFAIL | TTERRNO, "%s: pidfd_open() should fail with %s",
> -			tc->name, tst_strerrno(tc->exp_errno));
> -		return;
> -	}
> -
> -	tst_res(TPASS | TTERRNO, "%s: pidfd_open() failed as expected",
> -		tc->name);
> +	TST_EXP_FAIL2(pidfd_open(*tc->pid, tc->flags), tc->exp_errno,
> +			"pidfd_open with %s", tc->name);
>   }
> 
>   static struct tst_test test = {
> -	.min_kver = "5.3",
>   	.tcnt = ARRAY_SIZE(tcases),
>   	.test = run,
>   	.setup = setup,
> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
> index 48470e5e1..f41afa2fc 100644
> --- a/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
> @@ -1,8 +1,11 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) 2020 Viresh Kumar<viresh.kumar@linaro.org>
> + */
> +
> +/*\
> + * [Description]
>    *
> - * Description:
>    * This program opens the PID file descriptor of the child process created with
>    * fork(). It then uses poll to monitor the file descriptor for process exit, as
>    * indicated by an EPOLLIN event.
> @@ -27,11 +30,9 @@ static void run(void)
>   		exit(EXIT_SUCCESS);
>   	}
> 
> -	TEST(pidfd_open(pid, 0));
> +	TST_EXP_PID_SILENT(pidfd_open(pid, 0), "pidfd_open(%d, 0)", pid);
> 
>   	fd = TST_RET;
> -	if (fd == -1)
> -		tst_brk(TFAIL | TTERRNO, "pidfd_open() failed");
> 
>   	TST_CHECKPOINT_WAKE(0);
> 
> @@ -49,8 +50,13 @@ static void run(void)
>   		tst_res(TPASS, "pidfd_open() passed");
>   }
> 
> +static void setup(void)
> +{
> +	pidfd_open_supported();
> +}
> +
>   static struct tst_test test = {
> -	.min_kver = "5.3",
> +	.setup = setup,
>   	.test_all = run,
>   	.forks_child = 1,
>   	.needs_checkpoints = 1,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
