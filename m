Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A067DC433F5
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 09:26:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96D413C9AC2
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 11:26:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EAB03C0325
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 11:26:16 +0200 (CEST)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 36D2D1A00707
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 11:26:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1648459574; x=1679995574;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ODpLtYczGRJUM8v3YA1CUVWD95lb4btFm4ufjsKue9A=;
 b=oWIht6aGBklQvuz49mKVz55D1X+GVSjKt5NeH177Fo7dH22ARhq2mfJq
 t5kY4Max01WxqAkVKzKmxKjc9Xwn1n1ez09YE+Jt9gE1q/miWXpsBDX9R
 vXEELRHhe+WqaHRcoZGIRr/TLqI55t8969W7s+qL7fi+eeDf7YfhQ2y3M
 XahdAhwLLekEWro9b607F6Ata0NXzBNL9tSLdqq9kArcO2O79etuZAZSU
 r+9eQ5iSm3/re/zSf1PMA6UFMqBm+9Kjt1UmF3bWEz4gM7fADBX8H0MwL
 yyB6zKT52yNrWglGgugogmO5lUYj4wfEZOJaHDp9nvcC+cIQ/BlZ0lQvq w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="52753249"
X-IronPort-AV: E=Sophos;i="5.90,217,1643641200"; d="scan'208";a="52753249"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2022 18:26:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRfw2ntEilmSMWaBJTxcdw8ArXiqpedmKUgSZhztv6tQpGaOwIR2KfNZgGP34FdemmMIUnzs+9QI/AmDa3xurScFuBfa/mtA0iDhGnoDfz6MeaPHS0UwNRClPUslJgew66lysLfgv47BuK/3EWZOBHQcZBTAdtKvmswKeLRNnUGfuRfgrEMDZGtpMLmh95ADE5YvblWJeRhboTWJgg64Ws0Mf9anwWHueDwIYRNfcNBWhElOWsAuyar3MvCGMN6h4dg3GKGUddndGoOUAjabBX/ZlANqGeC02yz0IE+HdD/PTviOTq7CPX7n22h5g6RUKPaUWNz8ZoQJNJT0kU9UNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODpLtYczGRJUM8v3YA1CUVWD95lb4btFm4ufjsKue9A=;
 b=JJHQ/jZlo8hDCbjmlKaVTpx1nCsKIidri7nnLtwXznRftwzf5JlQU2TZ9gR5VZW2R2uQMGtyXP36hnT/HCDdPFRRiC6cGf7Cqu0FJBv6bcFVdZQc6X+RApGYzjjyE5RGtpKKQRsK4lvxo4QQpcLMWvIp89LdWLLYwMJwNcA+5HJfHNbJvqv1NKfmXM/sDx6lCj8Zm3Pg+l/rqzz10APjJ5sI5FT1QA72ZMtX1XlziTph8Z5xiCg/Ra84MHtxJDZG54/O6Wa3QZt/0UqsyNPuCSDoUTUcTSn7IQMU6ALH9mdqr9EGaOqdxhCtadBClD0ddAJdI93hFzjRMoVwy9OTSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODpLtYczGRJUM8v3YA1CUVWD95lb4btFm4ufjsKue9A=;
 b=hKimJeaB5/hQud0K1lu8Yv0PNJfBKSPQMeXwVepUo3pZHnLp66E35De9Bp94z1qFqu9lFCd0IiwqgurliTVaSTrbzSGss105I8IqLhy1+gsbJfDulRVc8aTh5mxenndUG0etSimC7eI/BtNYZkmcSNHFtnTnel9gs8iz5Nfoh/g=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSZPR01MB8895.jpnprd01.prod.outlook.com (2603:1096:604:15a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 09:26:08 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 09:26:08 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "daisl.fnst@fujitsu.com" <daisl.fnst@fujitsu.com>
Thread-Topic: [PATCH] syscalls/umount2_02: use umount2 directly instead of
 TEST macro
Thread-Index: AQHYQnlqbRn9COXIGkeYSA7y9B7i+KzUhvcA
Date: Mon, 28 Mar 2022 09:26:08 +0000
Message-ID: <62417F5C.7000604@fujitsu.com>
References: <62414819.2010802@fujitsu.com>
 <1648497372-9371-1-git-send-email-daisl.fnst@fujitsu.com>
In-Reply-To: <1648497372-9371-1-git-send-email-daisl.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 306151a9-be58-4f80-24fc-08da109cfdae
x-ms-traffictypediagnostic: OSZPR01MB8895:EE_
x-microsoft-antispam-prvs: <OSZPR01MB8895D891600CFBA397732337FD1D9@OSZPR01MB8895.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZZA6s93AMpKRUl+al2qjXxibKMZMdoz+aB6/1PCO9BJ6JBsRFPmQUDZqHgyNcdBH6a4SrtNAoA9M5zznAeXGOyqAIx0d7FhxgZgNT0MOWhE2kaTWhO+eKV3CHi/FkxB4tBv8Cg9V9Kt5OdxDEJSKq8BqdJaspCPxL64CuhTUKyfClJ2QTaj4qwQVLYH90WIE0iVHlIFWmNy1/6Yy08FyVVTmUV7hgXjXB37qZqPCawB/SPCWzPfFAWrKD28cg6gSmI/t+tlajwjhq6yL6W3g/37MHnLgu1jr61Mh6zV7vzUP7+EG6hZUSz9tI5dnUxWNxn34wowCIHq7YFS19a+QY8VFK0yjLoVQ2MhSEyjNlX9BPpFiqNlWQNEZyRqwid4lz8Z+QqeBTfP1jLarMZaRPB56gwOjlTNcAy7ExMMh3LwgDXMGCVnb9XZQW1VvgqmkbsPIjtrdRkEu7MGXzSo7vD+gS+qRn4VD85s7LDJgb8MHEmh02uyQlQ4XQmEMNrxfoVmSfaCFqyBdg9CfZK5DMbAJ5zVCgFUUjdrSnl4jmJF0/o7mNHmSn6EOEAQDLnWDjqT1sLyV+Ixvzblqlcj4ObnHuBSfJfnEXmiKi8H0lJ1N8hrXtyz4GihGHocxdNDMNxwFIKNSZRfXvScmGafBgfW51oNF+j+8mqF9DIaAf4ZPqcrvqdiaksC8O6i2FUoOmH/dtDb/3Z7+AwRzey/Lew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(87266011)(5660300002)(122000001)(38070700005)(86362001)(38100700002)(6512007)(508600001)(33656002)(36756003)(6636002)(2906002)(316002)(8936002)(6862004)(82960400001)(8676002)(64756008)(6486002)(91956017)(186003)(37006003)(83380400001)(71200400001)(66946007)(85182001)(4326008)(54906003)(26005)(2616005)(66476007)(66556008)(66446008)(6506007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Y0hqa3BweFoyWGdLYm5KeHJKd3lPUUhtMTczZHdHMGwwcm1lZEZ5eFZ1Z0VC?=
 =?gb2312?B?aFlmK1RraVByNG1TNTljcnl2VDRYdzNlckNHV25odWxqSWJCY0xpK1pQTUdJ?=
 =?gb2312?B?R1cycFQ4WkdvSkVmRExuY3N6V3V0S1FIVjl4b3MwN0dBdUFyaFBiMlg2UE04?=
 =?gb2312?B?UVU1TFB1Sko0ZUdKdndncHRJVW1wQzlVdWNsMVZLMk1jMmYwT3gxYkhONWpH?=
 =?gb2312?B?eTZwbGtwRkFIcnZvTFpGSk9CZzhMRXF4ZkhFU2U0WnBQTFB3aFJXNVFZbGRT?=
 =?gb2312?B?Qi9tbXVBVWV6NitaOURtQyt0Z293U05jc2xmVzVERGtRcVhjR0gxTFJRWklp?=
 =?gb2312?B?aTEyQVdkeUxRK3RMRXRNRWRRMlByY0VQQnZQbmFINCt6VzlleTMzaHRwMVVC?=
 =?gb2312?B?S29GdXk1aDB5NWwxYnR4YWpKQStGc0Y4ZHpqTHdOSDIwNFdCRlpQTDRmQzlJ?=
 =?gb2312?B?MmhRNFoxaG9xbE9LYnh1WmhhSm1JSnlPMXZoR3BXKzgyRC81dW9MT2JCN0Nu?=
 =?gb2312?B?QWkxS0ZudWlVNUtPYUpJWHNRR3hXaGtFVm82UXZJNkNtRXJoZHQ5RTQ2dzNp?=
 =?gb2312?B?UnJlanNraTVBVjVHZmtVMzhNRTJCWDVyTXVFVkNuUUtzSktwQ1V6cGVnVHZx?=
 =?gb2312?B?bDI2OEMxbndWVjhYeFpKQi83djF3dkFkamprMDBxZHhaS0pHam0zZzBuUmFT?=
 =?gb2312?B?dlJBbGtSTlEzNVQvcExWQmRJL2krbStLWjNQekZORjRrMHFaRGhDQjRMdGIw?=
 =?gb2312?B?a0Y1MnZjUGZwWkdDeDVFNGV2M3JkQWhmZ0hWQmpaT2M4ekRpZzd2eFZRT211?=
 =?gb2312?B?cTdRZ2xTK3M3UGVwbENrdStrSTJydGs1TTRNYkIzaGxFbWlSWUh0dzBHK2Zx?=
 =?gb2312?B?eTNSRWV0MHk3M04yZmpyVGxUNExUeW9FYjNzQjdsbWYwYWxuZDJ4TmNYNzJj?=
 =?gb2312?B?UkRFamlnZlBvQVRpUmtCcVBNZkZFbDhCcHRHMjVxUlFVc1RQNlo4OEV3bzh0?=
 =?gb2312?B?bFNxS2V4M2pIeUpJc2lyWUdsMllYRVlwd2hqeTdpaGhHZUhBcXN4NmNoN1dq?=
 =?gb2312?B?b2NhVU9qOWl4U3FOQTlaWlJFT2lTV1o4K3RHTkNoOHBoOWwxZU1BVjAzdW1W?=
 =?gb2312?B?dlFLWVg1eEhnVmJNeTkxZ1dlV1BTRkxlSUVHYzFpYXd5OEFZTnJab3BYSUto?=
 =?gb2312?B?bHlPTlc3SFMxUTV5SVBoVGFUR2JPRFZkRSs0QkNqSTBUOUl2MStxRUhISzRU?=
 =?gb2312?B?QjEySTQwUUlNTkJUSjdndmlqRHFWa1RZK2x4NHlUVjBtY0RmOHJyNDVYRW1o?=
 =?gb2312?B?N3ZGVkRINzBTNm1tWVN6cU1STmRlbWsrNGdpY1MzRWVzemVlV2NoK0NaTEQ3?=
 =?gb2312?B?QXFkeXJ0U3BJZHVYaThidENKWmtmaURMZ0pxMm9nbW01TXhxZXNvOGQrczBX?=
 =?gb2312?B?c2pPT1ExczBQZWFNdzU4WGM4NHZwd0t6TVpNMHNVSWVrZTNmK3hxWTZyb2Y1?=
 =?gb2312?B?eWtEWUhzM0tkSkdMdEw5WXYvWHBGa2lHdWNFbFVEZ3JPSUdSdW5zdjJrWi9W?=
 =?gb2312?B?UGdqREJIcWNTSXEzaGIwTk1lRkliU3Mwa1JVbGNNdTlBSWloWXdQcG55dkFU?=
 =?gb2312?B?M2FYTmtZRi95WUdqQkdQeTRxenYvRzE4U0JmZlBWd2lKcEE4YUZHeUtGVFI2?=
 =?gb2312?B?MnlCMmZnVTh4L2szWlp3SEpaNVcza1FFRHJhb2d3RkFpeE9Ld3BXeEtLViti?=
 =?gb2312?B?NmNjRGw2WVRXb3VQSzllSVNJZktQOSsyeVlyWncxU0lXTUhzTTR1cDluSmtD?=
 =?gb2312?B?eXdMZU1NVTN1Q1VIWG83eGZQNU1FdU9TZUhrUzNhQlZsZURnNlNoZkRCTHFh?=
 =?gb2312?B?MHJPdTNTc3FPNFN2Tlo0V1luTERMK2dscUFMb0tCUkg0MjRsOUxzLzlNN0ZY?=
 =?gb2312?B?UTc4cjlWWGZFN0tUa2tIQlRSUjRxN1Q3MmZBeFNtVzBuZHdRVTlDWXhkMXJF?=
 =?gb2312?B?RXVMamM0UU43MmV2eG1WQ0NtRGdLVmtOdFR2dmZidC83QklveVptWWsyb1ll?=
 =?gb2312?B?Y3pIbWUxaU00cm1ZRGl3emRadmdKeTJ3NlpJUCtPemJkaWRnLzFXV0dydU5Q?=
 =?gb2312?B?YW5OZHFrTzNNelZ0YnZ5TU1vQWVtc2FhWHBiVlBFYjBQVy8vczlFVXpHbWxT?=
 =?gb2312?B?N2ZNRG9IMFlCVmNNeGR2OWxPUDYzdklNam52RGpFNTRZMVpydmd3V2thcDZh?=
 =?gb2312?B?cEpMZDFZZjBXRkVzSzVIYkFON0s4M0IzaU1sYVJtc2dsUnBxb0xvNU9LRmpU?=
 =?gb2312?B?OXhEa2tXTm9VZnh3REtGeThoa3hkZldzNmh4Ui9ZR0pwdmRjNCttWVFGd0Fa?=
 =?gb2312?Q?1bUUpjha5nxu05QQ32Ane7aieTyRfWl62Xw96?=
Content-ID: <82966487A9680A47BD6A97DB0EFD0437@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306151a9-be58-4f80-24fc-08da109cfdae
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 09:26:08.0837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: doKwMgAxZvWWePDjcXJ4qv8szV2Rupbu8laQZypbNYbSLh9lW/NBH025LPOPhPsYBaU7NTbFAATaVWVgHnOfspVx3JG1HlN0iA3le1FBirs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8895
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/umount2_02: use umount2 directly instead
 of TEST macro
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

Looks good to me,
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu
> There is no need to use TEST macro in umount2_retry(),
> because we have used it in TST_EXP_FAIL and TST_EXP_PASS macro.
> 
> Signed-off-by: Dai Shili<daisl.fnst@fujitsu.com>
> ---
>   testcases/kernel/syscalls/umount2/umount2_02.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/umount2/umount2_02.c b/testcases/kernel/syscalls/umount2/umount2_02.c
> index 4c3b30e..b23f37b 100644
> --- a/testcases/kernel/syscalls/umount2/umount2_02.c
> +++ b/testcases/kernel/syscalls/umount2/umount2_02.c
> @@ -53,12 +53,12 @@ static struct tcase {
> 
>   static int umount2_retry(const char *target, int flags)
>   {
> -	int i;
> +	int i, ret;
> 
>   	for (i = 0; i<  50; i++) {
> -		TEST(umount2(target, flags));
> -		if (TST_RET == 0 || TST_ERR != EBUSY)
> -			return TST_RET;
> +		ret = umount2(target, flags);
> +		if (ret == 0 || errno != EBUSY)
> +			return ret;
> 
>   		tst_res(TINFO, "umount('%s', %i) failed with EBUSY, try %2i...",
>   			target, flags, i);
> @@ -69,7 +69,7 @@ static int umount2_retry(const char *target, int flags)
>   	tst_res(TWARN, "Failed to umount('%s', %i) after 50 retries",
>   		target, flags);
> 
> -	TST_ERR = EBUSY;
> +	errno = EBUSY;
>   	return -1;
>   }
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
