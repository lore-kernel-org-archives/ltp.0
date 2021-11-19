Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F70C433EF
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 02:53:30 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA8461AFD
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 02:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8EA8461AFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3835A3C7B03
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 03:53:27 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2A463C1824
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 03:53:16 +0100 (CET)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4086010013B5
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 03:53:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1637290396; x=1668826396;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=OwMub5MZImb5ekpAo6iXqUXiJ8GzkaFZFE9DHyIcS4M=;
 b=oVIBB/36JvU/a3b8d6Va0xuSuPBQeZC3cg5CM3DTcGdodsONlEhdjuae
 8WNC1oxvOgV3+mPV9mk8zJQSJt7OFTJ8z1eJdE1hFeLv5FmOqOy/nUkag
 TZv0syo+GWRUosJhxfjrscgU41T31OcxZkPMev45tzI8qJ1Q1OpZCTLfE
 YLvaEXCry8ztkTjI6bfy8xOBi0aTMUkokiOlWUMe4qt8YvG7DTBpjnDvZ
 RBf7Cp+1xKmN0iqYDT9KokLn/EQrUQtcYKl+6QTfYVnVdFYhS01EZNw/k
 hCU/H3P6GfZ48aVMtctOf6kidRDeKZN3rNdsmNAdTLvNzqkeivBziS0I7 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="43911271"
X-IronPort-AV: E=Sophos;i="5.87,246,1631545200"; d="scan'208";a="43911271"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2021 11:53:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYRMTcOI6n2XwRy43iNWHGWLsQoBCB4PdnI8E7Na83NbGsYuo8DkmK6svOiYnJYFRLqjM0kcUPli0bZ+AiI9d9KzFEQvjz1CrzFVSzKvyrsw/77ffMLCSD/R4cTfIerD8iS2VBiJMDaW3Fr6N5I6ks/Vl0Y9J4s5k2peLYm3908lSnDiUWvxEIyWDq7uk0T5l0HnUqo23305nv+iV2IqZE6st/mVi+p2HqtmvkLZ0s2UNOMwONpZ6VCo0XcZGcnlheIRVywvSS7ksdkwIBvYIgBYBjptRriIlCNAGU+RM7KdnDic5qedKsk62BrFP1cpAx0NPF10ALJEZS3hG8vXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwMub5MZImb5ekpAo6iXqUXiJ8GzkaFZFE9DHyIcS4M=;
 b=mq0zEMUq1ICwAq016IUC+G6z8W9GfuO0Ir/SGNp7Mjek1vbvkAG3IqDRvYDvPe1ATIT6BxOwga0+jyIZ7V3cc3xNjNj03C9IG66yU54jTpWJEaTgedpq0xSfwo+n3X/1SlvK4rqQH9wKArdKbe9pOfXoIkwWBkQZBbLpeAUP7p+dkl2wuTLybGn53AqHrU/dEvQ/9u+UOotste4Zg/lhEh+Kz5OJ2gM3UhIilmi3PgmgN7w8VE0bk9FS0BSjCHtCtK35u2JMcH7BLX24FjcLVYLBR5GMyyn45Varxtk+f5ZrMXn93pSN1WIRaatgKPWjSPOb8HQp97lmYHUXiIecnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwMub5MZImb5ekpAo6iXqUXiJ8GzkaFZFE9DHyIcS4M=;
 b=ewWgYpjZnb55xP4NQNvD1rDXBeJyEfLbJCJ1OTOmH9i3pAjAlqWHh99jA9LtaNiE9VKq7IDQlqAN72msOQIGtn3xVKGNVLtnNg1C2uwBbA3cmhmHU4tNIIfnC38lpCqp6INmsX6b0RRPiuPqqqTFbsKPQS9knj0gwLGtdUYFM18=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB3563.jpnprd01.prod.outlook.com (2603:1096:404:d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 02:53:09 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%7]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 02:53:09 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH] syscalls/finit_module02: Add ETXTBSY error for
 read-write fd
Thread-Index: AQHX24yCThkJOuJMHEaRfw7eIZraQqwJFgKAgAEUS4A=
Date: Fri, 19 Nov 2021 02:53:09 +0000
Message-ID: <619711C7.90700@fujitsu.com>
References: <1637137469-13184-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <87ee7dagfp.fsf@suse.de>
In-Reply-To: <87ee7dagfp.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fe0cae0-5adb-4696-52ed-08d9ab07b892
x-ms-traffictypediagnostic: TY2PR01MB3563:
x-microsoft-antispam-prvs: <TY2PR01MB3563384F0C5193AE9D5667E3FD9C9@TY2PR01MB3563.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7vtuoCLzQ7WT1duvzAO81EOkSnwgvtO8bsqzZbdeEv4Y8IbC45D5R8h40s2Yj29qZjaFlsTSotFDJ52S/wZTgd+ztKpqxcAqhIzEeG7I7IIBcfOhkkU/kzlvI1Da7SoSzjm2aOidseLL3tvY8pPDxhuo6VmQj6G2IIjVeTBpt8PIs+ACj2BI8jTjYCqkHLO6k7ixyDFAETq/fz8vL+IMKSRzyzEdd4iACBo/9tpoHIb5eLqrK5XHrI0IhF0nVQIxZvtMnrOkK8eLdYFLOHXyymj/s1iFE8wqQ/FY7a0zIZu3HOOkwbotZhwhFApVdIv9CXoHJ9NooP60Zo14CS47poxs2OaFccDmQyQtWwi/yj3Hcb9yhqOJWWcGurSvKt1YG3kPekMCKToVk5g2TuUQcOk1DfiGh5HPgJrdZUlsMYeYaOxumB+iGUdVHbSew9pSOcwLSoF6VGjD2WyLGZ1yqCCxPTxuT3oDWoS0U74G36u+Wn0G7GeuFLkL3w0cpNPu87r5kR0Tfm+Nabe0KOXtiq8nTIY2hfpCVc9zGHHjSydLwHDF18XK5BOo5mk6UerjUVyR9ZNrbUQpJ6tFbIxlcgsxUbRH30tUKEYHtmd+5F2EqkTHYuDInCM6KFEcSVdEHlUIYQqonUqsv9Geaw9F6Cmb8XSydzRkv+w80txGt2BIGzbpnlkxzsUY8GC7I1vqpenTLXJvyrC3pSY8UFX9cA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(86362001)(6916009)(85182001)(4326008)(26005)(186003)(8676002)(6506007)(38100700002)(8936002)(316002)(66476007)(508600001)(6512007)(66946007)(33656002)(66556008)(38070700005)(36756003)(76116006)(91956017)(6486002)(5660300002)(64756008)(66446008)(2616005)(82960400001)(2906002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?L09JenEzdVFUc1BrOTZVZ2xKYlJLN2dLQW5RNitEdk5UbW0xWE5oelRUWUVl?=
 =?gb2312?B?NUZ6OG1RZEt4bjFId0x0c1k1Z0FvbzBjbDRodWFodG9PSWpUbTFYVnRnNFJ1?=
 =?gb2312?B?YkNzQ2dPdkpDOXFQNjNUMlNDaHlVa1J2citWZmoyRjRVN3BvMUZJOHFBRnlZ?=
 =?gb2312?B?MnJ2QTZEUzZLVWdtcnYxeWpPbWJYaHhNTVZMQnl3N3BIMTF0TE5TSTc2NVpB?=
 =?gb2312?B?TGd0UW5vV2RxaHNoRU5nbmFudmpKRzBFUFp0cmplQTZiakd5ZUNsdGtmNFhQ?=
 =?gb2312?B?RUhEd0VlaHprVWZTWnJwb0tEd09Mem9KU0RJVFdCQlBvUVQ5bjl3YlpibWxP?=
 =?gb2312?B?VFcwQUZPM2IrODR1N3kxWXFjQWYzV2w2QW9SYzk1WGZFbHQvRkhYRlZmMVRo?=
 =?gb2312?B?bmZXeFlWRmNyUHgvUVBkcVJKcjJpajIrbndCNVVOL01uU1JwVi92aUdJNmpO?=
 =?gb2312?B?eTRDNEVXc0JTdEFxdDdsY1lWeXhMcmdIOHJaSHptcXprcXRKM1FUTExSN1Fk?=
 =?gb2312?B?cGdCNUhIZy9OYlY2ejBKME1JSG1VL1E5WTQ4ckFkWUVncThMb1UzL3RBWGlx?=
 =?gb2312?B?ek9INEc2a2tYQlVkL2JXWDNCc2cvaWYwVUFCdStDNmxlaUlNRTRNdUxxUTdV?=
 =?gb2312?B?Um9yTGRGMTZxY1ZFOVVMaEZtamZwcVY4bEExUVJSOEdiZUZ5MVZLcDkrakJW?=
 =?gb2312?B?WHUzcTJQYUNxd29nWjN0L3NxcWROdWZqNFdlaFFrVml1Z3NFUE81bUJLbCtr?=
 =?gb2312?B?eVQrLzJHWFdsb0crS0VpNkNGeEVtb3VMVGhpNnZ0VWtTaGFvOXBWUVpMMHFE?=
 =?gb2312?B?UGgvWG9FNWZXV1A4R2pQdEhxdExjZmJDakpTa1pmT1A0ZWNQQ285ZHZhN0gw?=
 =?gb2312?B?QXNmakJIbHlBbW9hZ3Mvb3FsVWhxNDN6cS9XblhWVEZLcGlORWt3aFNYQ1E0?=
 =?gb2312?B?RnhFK1QwdFNhTVR4MTFaNDh1MTNRVEZMYStYd0FBZGFkc3VnTU5IYlVrdWF2?=
 =?gb2312?B?SEN1cHRzcm1SaXY2YUptOHExRkJLQ1BXM2QvM20vNUp4OVoxMkV2Q05NM25X?=
 =?gb2312?B?QWRyWXdhUEpZYlB3LzhIamJHOGhDeWRJQW9TTk5YTEx3QzFMQVczRHV6Sm1I?=
 =?gb2312?B?Q3dmK1ZTV2RDQS9pTjhNQzdjMC81STdaeG1FTDAyNFdXU1dwcWdQZWloY2VT?=
 =?gb2312?B?bzRVOUJ4L2VsaVp1Umd3bm5ZeEkraEg5Uy9oU1BQckF3bzkrd2xnOExrc3Nm?=
 =?gb2312?B?L29LcXpwSFdrT0dVU0FVRVg1TzZ2cSsrdFFQS1JQWjdaTFBMWDJobVRsZmxT?=
 =?gb2312?B?dHAzb1dZNGd4TTdJa2VOZ2dGZXhaVldPSVZlQWk0UWcveVlNWmRxTmU1WXdk?=
 =?gb2312?B?ZFRsd0ZyNTFYNGF0Sm85ZnZsdWp1c1hPUEFoVFJEQTdaVW9ESE9DL1FrM0JE?=
 =?gb2312?B?STFhU003dm5KaG5XcWk2MGRwMCtFeEhPWDBPcUlmZXZjSFlqS3VaQjVYWnh3?=
 =?gb2312?B?ZVRpelNZNkU3bTZaR1lEcjIzQkxOaXhqZlpsSHRiUWJ2TXdEeDR1cWFiZzNE?=
 =?gb2312?B?dHM1czE0RWJsdEtBbjkxZ0NWK2ZaU0I5VFZ3OTR1UVRpUkhBRU9VYzZaNXhn?=
 =?gb2312?B?QkhhWFdsQTRGSlJoVE5QYUlKL3RkKzF4THNxZi9nR3lLTzI4OXV6emx2S3VT?=
 =?gb2312?B?TzRyNTVEMU5kcXRLSUErZkVlVFBWcDRYcGJhcHF1TWpzN2tmR3RnKzRtbHRv?=
 =?gb2312?B?MVpuQmxxbkhOa2k4NkRQRlFFRkVOTzVqOUJqeCsrQm9ZM254TFJUUUI0NDFj?=
 =?gb2312?B?Z05tTEU4ZmNJWlBscm5jejRDMStQeTRXZUtvY3Q0a3h5Uy9YNmlmTWYvNkN5?=
 =?gb2312?B?bGtQSDRyOW5zdWVTbURYUlFFZkNRYjlTZkthUm1FNmJnWmhkN0pNc3JOOXFI?=
 =?gb2312?B?eXk0TEY4WnUzTWlYN21ibnN2ekxJdURwd29PdEl0TXEvaGpucDJxRmpjSFNt?=
 =?gb2312?B?KzJHaGJnQUxRbkFPWVM2Y3dNbTdITzMwSjQ3SGZTNDBaOUxDeVczTWVCYUVm?=
 =?gb2312?B?NzJIdHJGQks4VTkvbmRVRml5TTVTWERNM3lGY0dFZ0lVek4vaS9tRzNJdlc0?=
 =?gb2312?B?OGJ3R25jMWJNc3ZBRmpkQUFnS3htNXZjd29uOXV1aTJWVms2QWU1SEl1Uytt?=
 =?gb2312?B?cFBBYnhvVzNVSnk4d2IwVmJsUkkzRCttV3FSOENLTzRLWjFjZ3A4VjFrbjhY?=
 =?gb2312?Q?h+J2T49tyI6LvpObqC+XazbXMSSagPL0LgFT8eLaAI=3D?=
Content-ID: <ABA5D328FC7B9049B5F5256C2B90399A@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe0cae0-5adb-4696-52ed-08d9ab07b892
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2021 02:53:09.8308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZrHHFQ8vyCsOSxl1N0kPNK2IL7flqk+jr5A81D8U/hKyp0C6XKwZi/nmohIIhbZ2kvvHyNuM44WJrMWCfG3VzjnRFwoU0stsxbZjaRyTOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3563
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/finit_module02: Add ETXTBSY error for
 read-write fd
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

H Richard
> Hello Yang,
> 
> Yang Xu<xuyang2018.jy@fujitsu.com>  writes:
> 
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> 
> Reviewed-by: Richard Palethorpe<rpalethorpe@suse.com>
> 
Thanks for your review, merged.

ps: I also record this error by sending a patch to man-pages community.

Best Regards
Yang Xu
>> ---
>>   testcases/kernel/syscalls/finit_module/finit_module02.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
>> index 47b5edbfb..b3437b5d0 100644
>> --- a/testcases/kernel/syscalls/finit_module/finit_module02.c
>> +++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
>> @@ -72,6 +72,8 @@ static struct tcase tcases[] = {
>>   		NULL},
>>   	{"file-not-readable",&fd, "", O_WRONLY | O_CLOEXEC, 0, 0, EBADF, 0,
>>   		NULL},
>> +	{"file-readwrite",&fd, "", O_RDWR | O_CLOEXEC, 0, 0, ETXTBSY, 0,
>> +		NULL},
>>   	{"directory",&fd_dir, "", O_RDONLY | O_CLOEXEC, 0, 0, 0, 0, dir_setup},
>>   };
>>
>> @@ -134,6 +136,7 @@ static void run(unsigned int n)
>>   static struct tst_test test = {
>>   	.tags = (const struct tst_tag[]) {
>>   		{"linux-git", "032146cda855"},
>> +		{"linux-git", "39d637af5aa7"},
>>   		{}
>>   	},
>>   	.test = run,
>> -- 
>> 2.23.0
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
