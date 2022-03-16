Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0909AC433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 06:35:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA29D3C934A
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 07:35:04 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DA833C627E
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 07:34:52 +0100 (CET)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 65DCD60117B
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 07:34:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1647412492; x=1678948492;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xf3Dc6lBuwZ8/7j+JjQzyzIkDPASy3ZzioDtL5qPDuU=;
 b=SyIjDnxJka4nEVVlnLmMQilwM1FKW1rvjSaXmyYfev+TTTVU1HYIRyrs
 WXKXW+1M2Rk3lqgEcxCNmTylkNtuwmwDAteOJIqqcTZoZUKetxsQdSmK3
 JmwEL6426gArXNe5uMbx9m+vNT0gsG48wp0GV9zkyYg3lijHXQFBQVDXV
 HJM2knx5K0PfsKvDY8ZK0b0pW6CNxl3i0pAkCrZxRbXzhJ9ZXnDcW49Ih
 Y04MnTX5OH6Q08VmdqWxvgQD7xU1LwP9TQekNul5E8xDl+xIu76z/ktLy
 TAHBCwzi4xoxnyb56Og3uPO5Dqn0kCh0fGSYBToPZnV+PkS1dZCNA3b/0 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="51809425"
X-IronPort-AV: E=Sophos;i="5.90,185,1643641200"; d="scan'208";a="51809425"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 15:34:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMVT9uj7X6Aw+W/V8lmDVRk4aPsPVBE+U7CZmJrCuPKmr+Ts/FpJsj+4tz85Rqq9jHWlBonYQDhv5tb5TX79GPjf88W7boBx4O6U+jH4Mij7kGlStqfHNlnHIDx/JGQrgh7CaTt258uNaAwQzhuW9i1E2WXhzlwaxhpQREhr4b3l2MHmtZ+GvU4Q7X7Dh6Dsz2aQcLG4nvp+AfXpv/Ya+2x40jzIEapOOQbbwulEEItUjESOnMbU34xcZagf5WUza2Jkko3AiiSVErRfHhJ9JpXzyAZtsh4EAt5i5gLAAoXWlntZb1/pYY+m7o/7JegGFvpdtNQ5vODt4ldDfjmiJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xf3Dc6lBuwZ8/7j+JjQzyzIkDPASy3ZzioDtL5qPDuU=;
 b=XLvud/WptuufhfCh/KpUNJiuHZsKxJKqvSxbyiZJXFlGVlPaTJVF+UaHOmpop2cZOAPzJSyPiXjNaiZtVmD40SdIZj9i/pj/+BMEvxRtOfoq9Ml8NDyQiqZ5E9Ml3FDJFyJSIqvCCjLdbXpTz4kfwFtUAq874ek4zFzSMSpxJZ+CZ/yRxbcrvYLsqrKFf1WA/+busaoq0ot+QQHjT2RTU20+tIPGV/dDuLgccBASN0JL+cLPUhWYSQRSNTX3QDIsdtgfYTJbhKUDpSKuOUGUl0ZVUwmUogjx7LmxCfTS3+NTiYGoktQO4BZ8orw7b8KeRHQ3dg07caySc0p6RVBgYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xf3Dc6lBuwZ8/7j+JjQzyzIkDPASy3ZzioDtL5qPDuU=;
 b=J43dvQESlzpDWKTUfVXdZmZ0CSxJZMvOwq2ToOc1x5HhyLOBrVNTN26HicKcSTg5080gXn5JYbJEJ40xaY7g2O49R02VWfzqYARg/61pgDuEQNZUoxuszKWCHe+HopC1YmjC299XeKkNGFb84vmPkj/p16V/AbdyY0oWDF8++dw=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB4393.jpnprd01.prod.outlook.com (2603:1096:404:115::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Wed, 16 Mar
 2022 06:34:46 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5061.028; Wed, 16 Mar 2022
 06:34:45 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 1/2] tst_kernel: Fix search for foo-x86-64 module
Thread-Index: AQHYOGfOK+Mfj5w7AUmKhPNSGFY7kazBjzgA
Date: Wed, 16 Mar 2022 06:34:45 +0000
Message-ID: <6231852C.5020506@fujitsu.com>
References: <20220315122516.3864-1-pvorel@suse.cz>
 <20220315122516.3864-2-pvorel@suse.cz>
In-Reply-To: <20220315122516.3864-2-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db402bd4-fd3d-467a-2556-08da07170fca
x-ms-traffictypediagnostic: TY2PR01MB4393:EE_
x-microsoft-antispam-prvs: <TY2PR01MB43932354C71D3468A53D7BB8FD119@TY2PR01MB4393.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lIsQeg7hA490x2LigK4VjQ9KVe/4DL42aSVJhCQiHY6C9YI9NBoJRheq7aBCiflkuz3CeSKt3+X1ypwcjxFTSIDz3pqHXyXGpPtJIGvodkXh9zcHT9JwaF3gYgtOHGpKu0V8Rm0NIVtSrSWU+QSUE3HywOoWhw5wkW/u27T7DA8a8PYCt26OMCkCnNg0uaBh+C6zynNW+g7O4ZMMaq+PPVutlgkho6V7N0y5jkVZHGDzWy9GnboUJgBDWcEf4K+KntNx+LB8CH/xAQJsIFjYyuzDLJUWA/3zsW+a8oQUCM+PQg9r1PGShzqDTuz6350lJpKV//i/EFkBmqVKU9N05wOgjq6GMDvrsr+vHO1bl4s06iKWhqUBQ+/aTqbwSwgB5w5ZJJ0RQ9uH8UAtcesv7zlzstQC4GiECa+1TkGGYtKCMy/OZl1bGC1S3ZN6ej2Poh7Jv5KOc2xUuHz8Lfiq7VyY4yNpor84BCvX3vng/q4fKoEbQqu+fdgd0V8J3m+KrHXDZ+b+fAoUxkp28Lw7Gsxrj4dshrNA8xq8iJ5EuFVdSGi0ynMUEzhpfXxsdwL6EaNWo5aMPc2TcsXuI3dimsrBKBlScNjPerDRHmSbt5NEn4BPaG/YSzOqJQzqGxnBkQQRGLbnUEklrXsQK9TorxSLLrz0/DEXQewMS/wfY/bOpysjm0Lm9YBJkDrj31G45+936Y/42l53hLJab8ztug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(87266011)(38070700005)(82960400001)(6506007)(122000001)(186003)(26005)(2906002)(2616005)(6512007)(38100700002)(91956017)(36756003)(66946007)(6486002)(71200400001)(4326008)(66556008)(64756008)(66476007)(33656002)(66446008)(6916009)(76116006)(86362001)(5660300002)(316002)(8936002)(508600001)(85182001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TTZmMEpTY2x4YlJxM3JTL3U2S3gzWGhLYk1IVzhiYUtLQWhxUzR3Y285S2pR?=
 =?gb2312?B?K053VFk2aEk1Yi9HUjhhSXNxcmtHSFFsLzlqS1Nva0Y5Z2pFNG5XOHBLVmZs?=
 =?gb2312?B?dXgxeDNMWUJQdSs2aTRoUU14S1liK3ZqM3hrTVlmOFdhSlJXQVFiSjcvT3Q4?=
 =?gb2312?B?UnN3ejNBM3pDRWpQNk80RU5ZRlpMQ2plK3FJSG1ZTkdMVGo2UjgxU2hQTHlI?=
 =?gb2312?B?dVFlQ09qT011aGxMKytZTWRQSzY5bmpLTG5SVFBOanN6eVFzSGh1SjFVTnhT?=
 =?gb2312?B?SzhmMWRKQXJtZ2lFa21kYk4xRjVCSzEvVmRvMUo2OURnZ1hCS3diMnFyREhV?=
 =?gb2312?B?RWxZeDNUS21DZVBydDhPYTZMMGROWU9nV2xUK0lud0Vwa0ZCcGF4VUZ0aEN3?=
 =?gb2312?B?YTZPTnN3SVJVR29YWmdVOVBndVRENENhenhFc0xNSndSYlJRNjVEWjI5Uk5E?=
 =?gb2312?B?QmhRblBTSWJ5Y2xmZ0Iwc1pkcGh1dUZLRW1rditybVJzV1gwdFFsaGlVR0l5?=
 =?gb2312?B?YnFOL1poT0gxTlpXUVNBL0tIcEpHNnJ4TFNoRlNDT1ROYW1qTUxoaXlMK3J2?=
 =?gb2312?B?cGJuenQrdjlqdFNVL2lqVk03dUVobFE0bWZSWjJJRlZqWXJsd1prMmNKUlFR?=
 =?gb2312?B?UjA2cnlxQzN1N3NuakMzcnZyZEF0TXMrM0VQckFDcTJISklETjBnU2U3aCs2?=
 =?gb2312?B?azNldTk1RnFIN2psbDZHV20vQ01JUFpxbVV6TkNLWlJOeG9tZ3RabUhXRkY4?=
 =?gb2312?B?TkVST1BwYUVSQ04xVWlsSGdJakk2d0FwcWRNaU9QK205TDRFbmw3b3V6bzU0?=
 =?gb2312?B?VGZZdU1tR00zMVNCbW1IVDBSbmZ2TFZhL0lhZkxzQlBFSzVsVjV4WkJjcFdX?=
 =?gb2312?B?a1hYR1pxcnZsaXFEeUczS25yeW4yeWF4V1d3bWN0NjN4RDNPc3R2R1NPUW5G?=
 =?gb2312?B?OGowdlVGSDBLaTVHS0pDcXVPb2Z5T2ZPRkV2Y095a0pjaS9URUsyam9hb0Fi?=
 =?gb2312?B?MUZqckEzTG5uTFpxb2orZlFaTjFkZnZ2dldpOFRnaUl0Q05pcGRKM0VkWjZ5?=
 =?gb2312?B?cFBGdlZlN0lURm9FMmNPQ0NCZXhYamlzb0hLNGtzcGtjVm1LcG1PZDdkN1lt?=
 =?gb2312?B?L3pGOWFHYzBrSy9LZnpVQUZnMlc0c3BGaVp1b205V1NsWUpOdHN5SE5TVFgx?=
 =?gb2312?B?NmFQRTVEYk8vQkRmR2w2dHZpL3FFWW5OcW83V3BGYnd1VGwrT1N1bm5xdFRN?=
 =?gb2312?B?RW1LWUhuazdrTjRLaXNYVmZGQWM0RUs3WkV1NXdhUGdFSG14Z3lCanliUmx3?=
 =?gb2312?B?Q2JBOXVSOFc1dEJURHNnK0xtYS9ETStpNUVqQlN4Vk9vVjFVbUcwMng0YTg3?=
 =?gb2312?B?RWIzVG1uZlBqQ3JNa0gxOHIwSTUyQTY5TTlmTlRIYnJnZlE0ZTRENjBYMDd1?=
 =?gb2312?B?S1o0aDhLS0RQemNML1ljVzMzZ25HRzFqdEE4VEpVWjg5Z2w3YUpCL0d2L0R5?=
 =?gb2312?B?NzA4QklyaWpvZk40azBoMzZ3eVI5clovMFdja1MwYko1Yk83MncrcnowYmI4?=
 =?gb2312?B?WWpPWmx1UjIwbWxoSXpmbUdSVXZCdWExamYvSGVQeWFhSkFtdWxmK252YVJ6?=
 =?gb2312?B?eU11Y1FyM2ZCd0xhaFEvNFlHWmpHUlhteW1YcE54ZDJlNS9hZ1F3SjFtTmNy?=
 =?gb2312?B?MHlYTFlDWGFlR25VNmNEczA3TGxvazBoTUM3cXp5aU5raTNkbDRtNjFWT1d5?=
 =?gb2312?B?eFJMcTdza0JZTlFBRHVhQ0lFV0trSllJY3ozd3RvUE5IelU3OStmcU1qNFhJ?=
 =?gb2312?B?SVdMNnd1OFlsMmRCS3h1akxPNWhBdXlPZTBkYTlmY1hWaFpVVFhLbDNPYUEz?=
 =?gb2312?B?WG95MHZMaHg1YUQ5MXpoSGZSMjljVXBPMVFJNlpMcHhEcmFVZHRKZXRQVDcx?=
 =?gb2312?B?OW9mWjVCUEptaDdPanFuWWc5dnRiY2kxbmlKV2lFRDV0RlRwc2ptd2h1ZCtY?=
 =?gb2312?Q?4S+ypNfrO3xXLLgqI+jO04e9xxzuE8=3D?=
Content-ID: <3C3AB1F6141BF143B6FAB892583D52B4@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db402bd4-fd3d-467a-2556-08da07170fca
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 06:34:45.2832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MORVqjwY2U2+n1yMvxf6K8DXvCfNQ0MhZLczsGh5a7wK1WmMoctnc3TCoGLTHOP/GooP8N0QOzTY5kJOJrKl23emJijgpiXT6SggUAi/3cI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4393
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_kernel: Fix search for foo-x86-64 module
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
I don't understand why we must serach foo-x86-64 module, so what problem 
do you meet?

I used 5.17-rc8,  it still use foo-x86_64 named rule for 
kernel/arch/x86/crypto/libblake2s-x86_64.ko.

If kernel has libblake2s-x86_64 module, then tst_check_driver will use 
libblake2s_x86_64 to find, it should succeed.

If kernel doesn't have libblake2s-x86_64 module, then tst_ckeck_driver 
will search twice ,the first time use libblake2s-x86_64  and the second
time use libblake2s_x86_64, then search failed.

Best Regards
Yang Xu
> Although modules.{builtin,dep} contain modules with both dashes and
> underscores and use this consistently, there the only exception: modules
> for x86_64 arch are always named x86_64 no matter whether they use
> dashes or underscore for the rest. E.g. libblake2s-x86-64.
>
> modinfo works with all 4 combinations of libblake2s[-_]x86[-_]64,
> thus fix tst_search_driver() to allow the same.
>
> before:
> tst_check_driver 3 TPASS: tst_check_drivers libblake2s-x86_64 2>/dev/null passed as expected
> libblake2s-x86-64tst_check_driver 3 TFAIL: tst_check_drivers libblake2s-x86-64 failed unexpectedly
>
> after fix:
> tst_check_driver 3 TPASS: tst_check_drivers libblake2s-x86_64 2>/dev/null passed as expected
> tst_check_driver 3 TPASS: tst_check_drivers libblake2s-x86-64 2>/dev/null passed as expected
>
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
>   lib/tst_kernel.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
> index 6db85bff0e..ecf4b917e7 100644
> --- a/lib/tst_kernel.c
> +++ b/lib/tst_kernel.c
> @@ -116,6 +116,11 @@ static int tst_search_driver(const char *driver, const char *file)
>   		return -1;
>   	}
>
> +	/* always search for x86_64 */
> +	char *fix = strstr(driver, "x86-64");
> +	if (fix)
> +		fix[3] = '_';
> +
>   	SAFE_ASPRINTF(NULL,&search, "/%s.ko", driver);
>
>   	f = SAFE_FOPEN(NULL, path, "r");

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
