Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F331ECAAD3
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 06:09:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAD953CA6F6
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 08:09:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F04B3C9B48
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 08:09:28 +0200 (CEST)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com
 [68.232.152.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5B5486002BB
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 08:09:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1661926165; x=1693462165;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QoimF10/tP8ngjJs0HssbuF8HrZh9JdY/HM5LubJGWA=;
 b=cXsxaRGKxJpXAMIADuDFagio6rfLfKwG+AzLUUUhYCQg0oveWpjdiFGU
 +tS9Qykz0NM9EpH+3znTz8exSbbxeNpyFhNs87xRakYrOkzEyOFCwZp2n
 RUvFxpefE1WA57p2jqgCknQ6yxAwJtA61z3A1f/oTeAHeUaEaBmyf3Zbx
 Vcb8Lp3ns19GbYkWGatAazWc9/We+VeCk/XTN85anHLAmchI8AB1wrEKI
 kGcnpgpRVipWENCP78QuPoTwfwQ9fiW8o9B/pl1u2jYV2qEoWcNWSR9nj
 +lwBaIWZRNnA8+CvLRcZhvuZz9Q7aeVC0onLwjuhVypd+554xjKNtEatv A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="72172865"
X-IronPort-AV: E=Sophos;i="5.93,277,1654527600"; d="scan'208";a="72172865"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2022 15:09:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGFOQcti9eJ5pHEglNSkThuRftCig1INTWuxv653lJKXGKpNTajCGKCdFkJbEE3kSHJre1QOkABtT+pjbRIFVGG57WyZq3AHTrTBuYdz7clNq37rDYnuiXLnLnIoKulGINnhhUMF2p/ZkwHRYdzLojVxniRCPo9BvqfPtoEy0lLPSlA6DJyZySqrta2DmpZSeGGNXgRcyduRhN5K+xtIfPVJwKSwaVOXxWZ6gH60xL0ysZ4ejvJaAGimB6qnxnoMagm0VOZNOU85JFx7e54UDQ0igP28tNt/GQnfLoy9z+rxR0NHsOu0VKAHff/EKmCPRi8QjciY+9CmGfaFU3osag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoimF10/tP8ngjJs0HssbuF8HrZh9JdY/HM5LubJGWA=;
 b=QNUTRWemk2/l1pz5MMYd60+oeGPemm2cbQJV/YKmmyRdIMC51eQscx68JM8lZTZteunvDgljI9EBmeLHuIWjCRNifUJ4IkfTK70/PmbMsxfpoAnZ+b/2uvUtf1F8lfnwgiFtd+c+OjAHX27nneu8fZPTAnKKBKlQtQJ+UP+Nr+wFPsT3gng8TFMYf6bxkT+UDF0HXfJ1Hejz/yGMvWMG2I/6DCNqRaBW1XC/la0FfkX+3lOj1ez5KkCylSs8M4SUNR0YKA7xTrqjGcsa2A227iPmCwD3SIG+KVEYzxL1NNU4Rf4ztIyCsORXlLL+DU3yQ5u+eAmmdm+AnifmoR8veQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB4473.jpnprd01.prod.outlook.com (2603:1096:404:11b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 06:09:19 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::a9fe:6054:eadc:7ef8]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::a9fe:6054:eadc:7ef8%5]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 06:09:19 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v3 2/2] syscalls/openat: Add new regression test when
 using open(O_TMPFILE) under umask
Thread-Index: AQHYsIC9C/1bZJ6Qz0CEwNYjtTvTs63IsG6A
Date: Wed, 31 Aug 2022 06:09:19 +0000
Message-ID: <0f4d5f40-584d-4ec7-e6ac-e28925067063@fujitsu.com>
References: <c266e389-c6f4-502f-523d-6d51fbf3ed58@suse.cz>
 <1660555627-2269-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1660555627-2269-2-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1660555627-2269-2-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba352232-fa1b-4b83-324e-08da8b175759
x-ms-traffictypediagnostic: TY2PR01MB4473:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MjsbtgfaAEA3+fzVmNLsU/CQ0W2LbclpAKj6kIpT1tyuE1kKcnWkyhiefhzOC7xd1a3wbAbQ1lWgrz6eMr+gax5a1q1G8Ie1X/+Xg2FxfUNddtm7AGRfVFujHEfd55/nrQvO4RcFsyMnxfg8Y+7e9HvhtIAbaeL+TdjIVwQQz2zVP1aNkf3pzS+ofsG7jEEmqAH6GHLxSyJ4R9ZuL/srzlB3oA+kydtcGWQ8pDua60Y26Lp3ycfFdINyAPKprbVcTb3OapNU5QbGB5O6+s/iOyvuR2oE/e9ibxyr+9ZG/Z43Phmw20dXUTbmZ479JFeeJ5fIfnAe/ZWl2hedY/z14Ycvrd4kJINNYSBYzZ70D4A06cQJeFUnKZwEoSbaljTbHyi5DW26jmdgIAE5pu1jo6FU4JiuaftmkerEA2t0a1MOuRg640ogubtMCFV7gbcK1MtPUJJLChpGVpFcJOguHL7EdwS/2X0b6RHw/akyh2/ZxG9z0c+S0kUNcIz0u5F1NWLQgQTlPF2FPJfbW/Q4Za+GisOMrJLSxSbhBTay1EGOxk2BbTl47rjD4zKBzGCl+9JBgi1ulMVxt0YeKzkPqm724uqCnfBPpi0Cmfww4BrqxlETeQ9dEZequ2cK8Mbp6iP2jcJE/oiSIeqi6GM9lZeBeRgk/Mex99XyU5t4Pf4Vw+JSELFNL7ragqJD7EbWj179WKxxYNb+QtstM0eJogQ2jux/q8djtAUUtcCMyyfHDEMZtcQm2XMegE0dp8UJ6FdsK02nrwX9uLD3moQgQqBnJ8/9P4OHaZtVp/ar1qTZBBidraX4ScZvmQl5/nTDBvhB8nx+GvvC8yYviKSOqA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(1590799006)(1580799003)(5660300002)(6506007)(31686004)(83380400001)(85182001)(41300700001)(36756003)(8936002)(478600001)(71200400001)(6486002)(122000001)(66946007)(8676002)(66556008)(76116006)(66476007)(64756008)(4326008)(66446008)(31696002)(91956017)(86362001)(2906002)(38100700002)(54906003)(6916009)(26005)(6512007)(38070700005)(186003)(2616005)(82960400001)(316002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmRlZU5lUW1tUjVBK2xQVVFTTVB3ZlZtS3lqN0x5U1ZxU0FVOFJrWTVSRHhk?=
 =?utf-8?B?QUlqVWdnelIzVWpKamxlQlo3dmRJZEw2SmIyRmt4K0xyZnBPNzFqdEZOb1Vk?=
 =?utf-8?B?eE9ML2dSS1kwS0ttdXZBRlQ5NThkUzNwcTU4azFyY3puWFlDTWVUYW1oeGxX?=
 =?utf-8?B?VXJQL1pWK3ZiYktrYnZMU2pXTkVOSFM5eVc5aExDSCtXVWZ1SkVTNThFU0to?=
 =?utf-8?B?cHIvY3NzQ2RWaW55ODdtWURON3lZNUt6aWpISnRGZEdKbmZZcE9vMy84TE03?=
 =?utf-8?B?Q2FSWTN5SEFPL1IzQW5DQ09qZ0ZBeHNnUitHYytOQ3Q3aTZmOXFLZ0k5elpn?=
 =?utf-8?B?UGg5WVJqbldIOGQzWWVzZFUrUUp6bmNZUGhEbmYrblI0MnpQbVhBcHRyNk5k?=
 =?utf-8?B?WjlYeDRMcFRIY1d3UEJjSlg0Nk5VVlhhZnZRZ1l2dHpZYjIydTdXNUdFYU5V?=
 =?utf-8?B?djc3ZzNudnNmTUZDaDFZcHhqYWJkUVR1NWN5UnlFOUZrbXlpZzFaMC85Zlc1?=
 =?utf-8?B?L2hWS24wSHMvMkdCenkwYmRKTDBWTzdXYXhYMDdEcnp3NlNEczk2cmRGakUz?=
 =?utf-8?B?Q0pkQk5FT0FjU0M3ZWkxTG9kdndOT3JvdTZxRkN5R1JCYi9KaTdQUTJqWUFN?=
 =?utf-8?B?eUY3WldVYmdCeGNVWHYyVXZXOXNzQUNpK0h6S1p5Nmw1cjRTYmhNdDAvbzF2?=
 =?utf-8?B?S1VDYU52RlBXeTIrVkpSVE5tTDU4WG85S3JzL0hralNHbTk4bGN1b2o3cE5y?=
 =?utf-8?B?TTRIcVN0SjVRMHk4KzNQQVc3ZzEzRmpxL052WENxelBORkJ6ZkNXM1ptVEdB?=
 =?utf-8?B?T0M3TkxOT0R0Yk9DSWgwNUpxUWhxM3ExNTU4Z0xMc2FQWHQ1aml5MWNTdVpS?=
 =?utf-8?B?dFQxcnIxYXJyaGNHT3Y3RlU5eEh2ZFAvTWZ5dGZMNlUrbmc1NnlnbFN6OVJu?=
 =?utf-8?B?MzluRTM2ZE1BWmZMWERlLzAxOUp4eGJGQ2ZBMWtPRitoNDljRnFlTWM0QmZP?=
 =?utf-8?B?ZjJaZEhXWWtuajQveldtVUQ4N2NMa0ZvVzNYbk5mKzFicFBYdDkreU5OREtO?=
 =?utf-8?B?RDR4YUxOcnpSTlpHZktPb2dwSUJQc1hqUDhlYlNQQUoySjhLRlNtVzF5VVQr?=
 =?utf-8?B?clZ1U3pHNWY0TUdkV1U3T3dyVlRQY2t5UVdRYzhKNVVwNHRiMUJNMmNSa2wr?=
 =?utf-8?B?dGVqUTAvWWprc2h2MTVkUENabEMvZVNyNTVWZzZ6V2pUWXVUYW9kcFdyMFZu?=
 =?utf-8?B?ck9ub2xIYUFXL3BYN3QzaG9UckNqdkhkWDZZNHg3eWhuU0ZUSnA0cmxDNlUz?=
 =?utf-8?B?WDhlQ0ROVmdsMVhyQ1dRSkR0eDIyMkN4dVhCTGlkTnlNa2tNR0l3YkxFbFkv?=
 =?utf-8?B?dVB6S0VMRFFpS0dtLzJyd2xldkRDd1JNenpvZit2Tm13b0t4Q0lCUlZzemVP?=
 =?utf-8?B?WXNnd0ZhOHFYcGcrb0htYWZQSWtFSzVOZGpYQnk0UW9LL3RiNzJrTDRHenVC?=
 =?utf-8?B?U1dRVE9IYStvNTFsZUtVbmE5Q2l3S29zd3BJSnFkNVV0QW9MalRvOGpYM1Ax?=
 =?utf-8?B?UVZoYUxIZldiVEhEb2xrV3h1c1VWdTY2SzdyUS9Zek9RNTFFb2RCdDNFVFpU?=
 =?utf-8?B?UmEyaTVkT3Fsck50eU96WWhXN1Z5NkRTalE2SVRUc0N4UW1MSTBHZ25VT2gw?=
 =?utf-8?B?bUk0MGE5YlJSMGJMcElrQzhoQ2s3MGlmSmhNQjh0cnVYc3ZtaWtDTjlxWnN0?=
 =?utf-8?B?cGZ0L0w4VDdmcUIzOWlGaVEwNTM2ZVVLWHYrUERkM3ZVc0hUUzRnNDVHSXBr?=
 =?utf-8?B?eDNJYjBXcVQ4OW1HcVR6WjJPUC9yUldBc2o0ckhmaGplOHZ4RU43TERJMGZn?=
 =?utf-8?B?WTgxOWZ2aENCaFlsVHlXSk9jc1kwVXYrZXFFMFdyQ2IvUitMdU9oT1dUM1pl?=
 =?utf-8?B?ZmhJZENaNmgzUWFwTjhFa2l2cGJsWmtDTGd3azhWUFRMdy9mSlpZMURWazdG?=
 =?utf-8?B?Zzh5aXNVRzkxa1FHS05XRzJzdENVR084a1R4RGd3UUJrWnA5bVFzTU1taFQ4?=
 =?utf-8?B?c2FiMWhUTkthT2J6M1RhUjhVZjE0cmZxb3k4cFVUMG5BcERMUmU5UGVJcVJF?=
 =?utf-8?B?QXNEUTVSR1gvbkY5cWEzN05QaVVBRnBpSkJ3bGhUakVlOE5CQmxMTXE1bm9E?=
 =?utf-8?B?bkE9PQ==?=
Content-ID: <D04F53C3B0175F4FA4537E3BEF9F2798@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba352232-fa1b-4b83-324e-08da8b175759
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 06:09:19.2006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q0Rufu7mkaP2P2DwYYDlNkJRe78H8ObbscaYKaNnEgOi/RhpNSYE72aoZa6qmhJrpfUJJTqgLScJf7W7dIWXfhxZbTMJxVtUJcVLKgI0XY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4473
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] syscalls/openat: Add new regression test
 when using open(O_TMPFILE) under umask
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
Cc: "brauner@kernel.org" <brauner@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All

I want to merge this patch set together, but this patch did't get any 
comment or Reviewed-by tag. So ping!

Best Regards
Yang Xu

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   runtest/syscalls                            |   2 +-
>   testcases/kernel/syscalls/openat/.gitignore |   1 +
>   testcases/kernel/syscalls/openat/openat04.c | 188 ++++++++++++++++++++
>   3 files changed, 190 insertions(+), 1 deletion(-)
>   create mode 100644 testcases/kernel/syscalls/openat/openat04.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 9d58e0aa1..cd38a4ddf 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -919,10 +919,10 @@ open12 open12
>   open13 open13
>   open14 open14
>   
> -#openat test cases
>   openat01 openat01
>   openat02 openat02
>   openat03 openat03
> +openat04 openat04
>   
>   openat201 openat201
>   openat202 openat202
> diff --git a/testcases/kernel/syscalls/openat/.gitignore b/testcases/kernel/syscalls/openat/.gitignore
> index 2928dae22..2d15872ab 100644
> --- a/testcases/kernel/syscalls/openat/.gitignore
> +++ b/testcases/kernel/syscalls/openat/.gitignore
> @@ -2,3 +2,4 @@
>   /openat02
>   /openat02_child
>   /openat03
> +/openat04
> diff --git a/testcases/kernel/syscalls/openat/openat04.c b/testcases/kernel/syscalls/openat/openat04.c
> new file mode 100644
> index 000000000..78deaa6f0
> --- /dev/null
> +++ b/testcases/kernel/syscalls/openat/openat04.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Check setgid strip logic whether works correctly when creating tmpfile under
> + * filesystem without posix acl supported(by using noacl mount option). Test it
> + * with umask S_IXGRP and also check file mode whether has filtered S_IXGRP.
> + *
> + * Fixed in:
> + *
> + *  commit ac6800e279a22b28f4fc21439843025a0d5bf03e
> + *  Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + *  Date:   Thu July 14 14:11:26 2022 +0800
> + *
> + *  fs: Add missing umask strip in vfs_tmpfile
> + *
> + * The most code is pasted form creat09.c.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <pwd.h>
> +#include <sys/mount.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include "tst_test.h"
> +#include "tst_uid.h"
> +#include "tst_safe_file_at.h"
> +
> +#define MODE_RWX        0777
> +#define MODE_SGID       (S_ISGID|0777)
> +#define MNTPOINT	"mntpoint"
> +#define WORKDIR		MNTPOINT "/testdir"
> +#define OPEN_FILE	"open.tmp"
> +
> +static gid_t free_gid;
> +static int tmpfile_fd = -1, dir_fd = -1, mount_flag;
> +static struct passwd *ltpuser;
> +
> +static void do_mount(const char *source, const char *target,
> +	const char *filesystemtype, unsigned long mountflags,
> +	const void *data)
> +{
> +	TEST(mount(source, target, filesystemtype, mountflags, data));
> +
> +	if (TST_RET == -1 && TST_ERR == EINVAL)
> +		tst_brk(TCONF, "Kernel does not support noacl feature");
> +
> +	if (TST_RET == -1) {
> +		tst_brk(TBROK | TTERRNO, "mount(%s, %s, %s, %lu, %p) failed",
> +			source, target, filesystemtype, mountflags, data);
> +	} else if (TST_RET) {
> +		tst_brk(TBROK, "Invalid return value %ld", TST_RET);
> +	}
> +
> +	mount_flag = 1;
> +}
> +
> +static void open_tmpfile_supported(int dirfd)
> +{
> +	TEST(openat(dirfd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID));
> +
> +	if (TST_RET == -1) {
> +		if (errno == ENOTSUP)
> +			tst_brk(TCONF, "fs doesn't support O_TMPFILE");
> +		else
> +			tst_brk(TBROK | TTERRNO, "open(%d, O_TMPFILE) failed", dirfd);
> +	} else if (TST_RET < 0) {
> +		tst_brk(TBROK, "Invalid return value %ld", TST_RET);
> +	}
> +
> +	SAFE_CLOSE(TST_RET);
> +}
> +
> +static void setup(void)
> +{
> +	struct stat buf;
> +
> +	ltpuser = SAFE_GETPWNAM("nobody");
> +
> +	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "noacl");
> +
> +	tst_res(TINFO, "User nobody: uid = %d, gid = %d", (int)ltpuser->pw_uid,
> +		(int)ltpuser->pw_gid);
> +	free_gid = tst_get_free_gid(ltpuser->pw_gid);
> +
> +	/* Create directories and set permissions */
> +	SAFE_MKDIR(WORKDIR, MODE_RWX);
> +	dir_fd = SAFE_OPEN(WORKDIR, O_RDONLY, O_DIRECTORY);
> +	open_tmpfile_supported(dir_fd);
> +
> +	SAFE_CHOWN(WORKDIR, ltpuser->pw_uid, free_gid);
> +	SAFE_CHMOD(WORKDIR, MODE_SGID);
> +	SAFE_STAT(WORKDIR, &buf);
> +
> +	if (!(buf.st_mode & S_ISGID))
> +		tst_brk(TBROK, "%s: Setgid bit not set", WORKDIR);
> +
> +	if (buf.st_gid != free_gid) {
> +		tst_brk(TBROK, "%s: Incorrect group, %u != %u", WORKDIR,
> +			buf.st_gid, free_gid);
> +	}
> +
> +	/* Switch user */
> +	SAFE_SETGID(ltpuser->pw_gid);
> +	SAFE_SETREUID(-1, ltpuser->pw_uid);
> +}
> +
> +static void file_test(int dfd, const char *path, int flags)
> +{
> +	struct stat buf;
> +
> +	TST_EXP_PASS_SILENT(fstatat(dfd, path, &buf, flags));
> +	if (!TST_PASS) {
> +		tst_res(TFAIL, "fstat failed");
> +		return;
> +	}
> +
> +	if (buf.st_gid != free_gid) {
> +		tst_res(TFAIL, "%s: Incorrect group, %u != %u", path,
> +			buf.st_gid, free_gid);
> +	} else {
> +		tst_res(TPASS, "%s: Owned by correct group", path);
> +	}
> +
> +	if (buf.st_mode & S_ISGID)
> +		tst_res(TFAIL, "%s: Setgid bit is set", path);
> +	else
> +		tst_res(TPASS, "%s: Setgid bit not set", path);
> +
> +	if (buf.st_mode & S_IXGRP)
> +		tst_res(TFAIL, "%s: S_IXGRP bit is set", path);
> +	else
> +		tst_res(TPASS, "%s: S_IXGRP bit is not set", path);
> +}
> +
> +static void run(void)
> +{
> +	char path[PATH_MAX];
> +
> +	umask(S_IXGRP);
> +	tmpfile_fd = SAFE_OPENAT(dir_fd, ".", O_TMPFILE | O_RDWR, MODE_SGID);
> +	snprintf(path, PATH_MAX, "/proc/self/fd/%d", tmpfile_fd);
> +	SAFE_LINKAT(AT_FDCWD, path, dir_fd, OPEN_FILE, AT_SYMLINK_FOLLOW);
> +	file_test(dir_fd, OPEN_FILE, 0);
> +	SAFE_CLOSE(tmpfile_fd);
> +	/* Cleanup between loops */
> +	tst_purge_dir(WORKDIR);
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_SETREUID(-1, 0);
> +
> +	if (tmpfile_fd >= 0)
> +		SAFE_CLOSE(tmpfile_fd);
> +	if (dir_fd >= 0)
> +		SAFE_CLOSE(dir_fd);
> +	if (mount_flag && tst_umount(MNTPOINT))
> +		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.all_filesystems = 1,
> +	.format_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.skip_filesystems = (const char*[]) {
> +		"exfat",
> +		"ntfs",
> +		"vfat",
> +		NULL
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "ac6800e279a2"},
> +		{}
> +	},
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
