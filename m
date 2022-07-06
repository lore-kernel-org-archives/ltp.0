Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C6BCCA47C
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 08:56:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A8053CA1BD
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 10:56:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4094B3C9A5D
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 10:55:53 +0200 (CEST)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A3F602009A0
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 10:55:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1657097752; x=1688633752;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=mBZ5MrRSc/+dkKf2VaoAM4eoxXgT2iYOD3Qa4qGER34=;
 b=tsw9lXzUgpf/Uvo8jy7xQDiMb3R5BvcvcsVlF4LyYEH5uplyA6v64DIf
 GzYOmWsPQTMZptGkR70DCprMYymAYaYJiaV/IIPcGGWoBsOo5hFDv8bfI
 h0o7Y2iIQn0qaxIkMxSH4aM6OEBxWiBRx9+OBY0utrCPn54sdnaRlVK94
 jOkeynIP1+C2/f8pof3Q+5r4HH7cMUpeYNWd6ZV5IiifYu1bgAlDlvEIV
 hDa1CAJLEqFC6dvGyU1tzNwJRPRNfljLuTgzhl+itiA81Ky5BQMdFZNF9
 bqpKjTtFcsA1d0MqqZhHqGrRWy4gEgoFvp/Pc0vLOiqVBp8CAyusLAg8j w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="67839484"
X-IronPort-AV: E=Sophos;i="5.92,249,1650898800"; d="scan'208";a="67839484"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2022 17:55:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3ZNSzLqs9/2ftngOKfhB7YgtKX1YPDsC+W+ydxpjCgOQYruCXy9J/DL7FMGOb3QkLQllrlNcpebXpzELqZk4OiTwcUdIsQZXmxghQkX9RC+sQZlarmrW2sduUfY1StDHkJpP/pe/QfpsaVz25Z6GykdLpJ8mhk3/BZpcDYO9S8BXVCR9Ggoh2A4cTz8jcr8J3gpI1XIzUhaWJA+Srzto2dQgwAZMG3BasOb/6wjsxdOTa0x1EVtuRkZyD/q4QeONcWZRnrbjFkWmEx3uZw+pUxA1x8+xjXYTz9Bodhyc1sZPBxVYF7fzOp8ZWvyGb2xYapDIl1VjmMi5OSd9v8J/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBZ5MrRSc/+dkKf2VaoAM4eoxXgT2iYOD3Qa4qGER34=;
 b=fUXrc3P0wwXvLk0VxA5I390r1aD1Ey0k4dmF7i9/g4bjBkYDkDyzQHxZDfswUYZq2OPbYpQ2S6RJTOPWlif0O0/aAEu/aAledjSjXDQeklMR7KqOldIkd7rxfTwe/987te7aablU7CwQy09/B0/24t8sQO0VbpVyVaRhKy8YmXJxRIWcfNe/4v33NP87+YCQrMUowYHPBhT6Bn5uF/AENoYR3HZArky6ktCZyzX3eHJ1VUVpRHWaGMOtXCtuORYFepvv73ii6FMMUD7srlqdwpaeWy2LQ3HezUUQ8owuZzZGv2mBgGE3mnTGmTVDG6aCuH/P3UyRReIg8F6ouqufRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBZ5MrRSc/+dkKf2VaoAM4eoxXgT2iYOD3Qa4qGER34=;
 b=SXiENeAwIoJjBjkJj7zAz1feWrMiKz1TFCpDqN/5iszgFwdYV/pamiz7RCxkSnY2VK3SK6qXMfSUwCy26sLJqFeInIEDUcpPP/0R+/ouZY3gNkveWA3EZQMsD1vz/U625XSeYPEw6RXUlErp8HZtI0oPtVci7dxVxb+DYICuvUw=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB4588.jpnprd01.prod.outlook.com (2603:1096:404:115::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Wed, 6 Jul
 2022 08:55:48 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 08:55:48 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "chenhx.fnst@fujitsu.com" <chenhx.fnst@fujitsu.com>
Thread-Topic: [LTP] [PATCH] docparse/Makefile: fix a typo
Thread-Index: AQHYj41BtbtkvaFeFk6heV6ccodsfK1xHkoA
Date: Wed, 6 Jul 2022 08:55:48 +0000
Message-ID: <62C55C5C.5060601@fujitsu.com>
References: <20220704100243.844-1-chenhx.fnst@fujitsu.com>
In-Reply-To: <20220704100243.844-1-chenhx.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9423f815-bfb6-4400-c50a-08da5f2d5246
x-ms-traffictypediagnostic: TY2PR01MB4588:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GC1jSmOAvQ+iWVYfKjKsFgdnOVyS9/nVh3U+DFRrPbXAocAGdPlKtNQgTevjbuzqcUR8IRTiWEFzw07Rid3yc4ldmAPMxB/j4umTr+o6KO4U+9m9styfpfOb/1ShADkiDGEAoiM/8A3CnIP8wa4ffdhrFjnlu91tUsFILRtEjc8HHa+4r9LCP2UF/GTiz1d1zSMWRacytc6nJ+F7m1+nW9Mxl+gtDEGnoIE0kkGpfPizN+IFYU5xcr8fJF5OnUIv6NjMcSS83ULaPPJ6ZOe9DClHpjkFd0WRVDniAl8efW2mo9yvxTTXN4DLGkqajdBTDFlKnt4wa6sK1ytCcr+MzK43h2cDsyPVIirwD4Z056bNK5RmBY7C3u2GecpLBxm+rY8XycSlwKWtedN/+ckqYF/Li+zSPzIydrPxAyAhpFNzyWuD5kiV2l0LIH61NcYgg4UyoJ8olf3cIEy+YmNohVekhCZjukFMixLQ/VgfvRML2zHV+2SqwsLNu15EDWS0bThZZvMmw5ZG0P8Nr9ltSgN1ATJ0wI16NT4zQzLSQhpO+KREPvOcCQVUHajAkwEfxDNTWpBx211AJUn4bAGjS6AMMBKTHUzHcMniOhUcG2Ig8Vs/XXHgj70YiM9J5JR0GMvz2Wbub6lrXy7nXpVwXhMxzZ0+ZnyoXGadpaRCh+6udaeNv11HL/PGaICj6pPOTz6oiMmt8Sdp8ffWG+mzwRlMZIk2LOdVTutfrB2BcUfmxgeWytiJ+zyH+YtD7gujol7c5o+/Ylzwf1CKGsxLc/br1xolBGg5nwbvAqn432f1HpcDrmdZuxJT6XbPtVUS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(38100700002)(41300700001)(2906002)(8936002)(6862004)(5660300002)(71200400001)(86362001)(6486002)(38070700005)(122000001)(33656002)(478600001)(82960400001)(4744005)(4326008)(8676002)(66446008)(66556008)(64756008)(66946007)(76116006)(66476007)(91956017)(6506007)(85182001)(186003)(2616005)(316002)(6512007)(6636002)(26005)(83380400001)(37006003)(36756003)(87266011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?M0dPampTM1g3bFJVdjN2WjlMNjNUK1Nybmk4eTRmdFVOQXYxR09TZDFnenQ4?=
 =?gb2312?B?ZWFJa1c4NmtNOHNXM3dhdUpIVGFZdFdobWNaK0JFTUtqb2lsRjhDV3ZGYnFl?=
 =?gb2312?B?TkoyTlpIdGdFNjQ1cW8xMkVEWmQzWlpYQUQvTm8yUXE0M1FqL01uRWV3bjVp?=
 =?gb2312?B?RDNBRlcxTDloR0thRml1OEZhakhiTlNOTWI3YTgvcXhRN0tNZmlyTVFWbG4v?=
 =?gb2312?B?R2o2ai9hQ2dzSXlFd21XeG4xS3gvUUM2b0hXdkZTaDF2bVJFNkZuQWNuQ0lx?=
 =?gb2312?B?bHdSS1VHZ1FXUnljVnoyQmlpc3FWQkM4bm9ZL0U3eUc0b0VBSjRPcjJGZ2Vw?=
 =?gb2312?B?YVVTNGh5Wk5CYVBTS3d4OFBiaVUrZDlvNUxSYjNYOTMxSlA1OGk5aVBWZUEr?=
 =?gb2312?B?MXB4bU05L2gyNGZQazNmMnIxbkN2Z2tlT1hpb3BnUjk4YmVmZTZRRGV6ZW1t?=
 =?gb2312?B?eHZmNW80ZjBOUDN3MlliV2IyaThxdDgwMnltVDVYT3hFdnh2RlBVU0sxY25u?=
 =?gb2312?B?U21BUkJIUENoMXZSN2YvQ1M2OUpWY24wRUNnWU13MEs1WTh6ZkNrMjVPaGNC?=
 =?gb2312?B?VFA5NzdNNXc5N1FUd2pLOVl4RTNkTHZpVDEwa0VmZThEQzdxN3BuZEpwdXlI?=
 =?gb2312?B?dXoyNEpJUHU2VFpxWXdqVmFueHNRYlNpOVIrdWkyckFjc3d6T01NdW0zV08x?=
 =?gb2312?B?bURhdVZVbll6MzkxUEFIWFNtR0YxcU1iMUJZdjFyUHhhWk5HZ09VTUQrTk9H?=
 =?gb2312?B?c3FFaGxaSEh3cWZUaEd5cWh6VEd1aEhaWHdOYnc4Q1Z0QWFlSkx0Nno1L2hw?=
 =?gb2312?B?MXlMYi9HVDluK24yQXVSL2ZpN3pMMU4zd2xwTDlqbkNXWUpoaHZDZFdSTFJu?=
 =?gb2312?B?NHVqR3pZeEE3eVozY3Y5VElLS09yOFc1ZEFJb3pnUXA1WGNKRUthUEwraFFt?=
 =?gb2312?B?Ylp6eHBPazU0ZlpFTlVCMXAvNHdSaWtaRkFyL2NSKzZNcUFJNVQrTXVadzla?=
 =?gb2312?B?SzI2OE1HMGFVbWg3YjR2a2JSeVdWS0U0TW5VSCtzNVB3azZ4WnJwYzU3OWxq?=
 =?gb2312?B?REdoOGtod0xzQ3pVVnZsQ0N5cFd3OUhiQ201OVpwUnYwbnJNSlBVZkxoSHk4?=
 =?gb2312?B?djFYOWlrMytmcURtaVRURjU0SFB3eStvOFJyUDlueFdSRjhMQitJbzZQZFBM?=
 =?gb2312?B?ME9ILzVqNi9DZGMxd2hBWnc0VEtDZWRRamQ3YnJkb2MraVhoMkRaam4zcWc3?=
 =?gb2312?B?bTU5NUVlWjIyZWE0MEhvWXhoeWg5OVBKOGZzWVJZZEpxY05PTUpzL1ZsMkFW?=
 =?gb2312?B?WDNLaHBRTHNzcDBFMm1kOHNRS0tUcU0yRHNGd0pqWk9hK0xPMno0ek9vRUdJ?=
 =?gb2312?B?QVlSZlQxRUVjS200amErVDAvdU4yWUMvWS8yS3RNZ0N5cS9oc3EyT1RZUHU1?=
 =?gb2312?B?cmZUZzJTd0FDY0ZCcWozeTZON3h6b1paemxuTlZON0dzemRDbW0rYlNZeVps?=
 =?gb2312?B?VktYWVNmQVFNSThTSnhqZkxINFlSYlRzMzY0SXFtWjVuQzcrak1qbG9KZ3R6?=
 =?gb2312?B?cm1sakthOEszbnV6MlQwOWRIOEh2UytadHJUek1VQ0RiWGRGY2ZVZ3R2S0J6?=
 =?gb2312?B?bU9WYnpmV2w0ZWtYVkdUeTlIUExEc1FEVTNUWUVqc0xxTWJtdHZTUXdtT0g0?=
 =?gb2312?B?TlRjcGIwelpvSEZwenpwY1VXd2xLbXc1Um4vY2JZNktZWTBIRWdTa0cwZTBl?=
 =?gb2312?B?SElTeStjY3JUVGxDMEJ1bTNxMXFnT0VVckVRTGZrTVh4MUpNWEdaL21xOXhL?=
 =?gb2312?B?WDV0UFVKNXVpeVY5VmRvTG4rZWp1Mlluenh5REV1TithZ3o0MlB5YjlTWGti?=
 =?gb2312?B?UHg5L3h2R2tWUXZ6VnVGbVVHNWtSWnkxTzFjZjNLVG9YZU03YVVCOERBSG81?=
 =?gb2312?B?TTFRQnAvWUdReEwrUmxUOXVFTDNoVnhnNU8xYnptQlZxRFBYWEttME1oOVhV?=
 =?gb2312?B?NDRQN1NlOURQUTBvM1Z5M2hHRTBjVk1ISU8xdWpjaldtOGRpVkl6RnRQM2d1?=
 =?gb2312?B?WW52UE1MUXBUa2NZdldwRHNsMm1tRjFMeTkzUE9TVVZEQ3YvakFnamcyRGo1?=
 =?gb2312?B?R1Zkb05BTlE2SFJLOStvTTNENERXQXJKWXFWZ2pwMk15azlac28wV3d2bmVP?=
 =?gb2312?B?Y1E9PQ==?=
Content-ID: <60A9DE9B6BBF46438A009E5BA6B97E52@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9423f815-bfb6-4400-c50a-08da5f2d5246
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 08:55:48.4258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 59Ok7ixmSR1R9vOCJybROb4viqr0rn2yQfcY8CEX+c6TOAmkX2Ls2M0Kmci5HK/RSOtHGtROp1CEofoiAQHUBpci/paPOQbVkr3oeGWww0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4588
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] docparse/Makefile: fix a typo
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

Hi Hanxiao

Obviously correct, merged!

Best Regards
Yang Xu
> s/not not/not
>
> Signed-off-by: Chen Hanxiao<chenhx.fnst@fujitsu.com>
> ---
>   docparse/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docparse/Makefile b/docparse/Makefile
> index e6e9f05ba..20851fba6 100644
> --- a/docparse/Makefile
> +++ b/docparse/Makefile
> @@ -19,7 +19,7 @@ METADATA_GENERATOR_PARAMS_HTML := -f xhtml
>   METADATA_GENERATOR_PARAMS_PDF := -f pdf
>   METADATA_GENERATOR_PARAMS_HTML_CHUNKED := -f chunked
>   else ifeq ($(METADATA_GENERATOR),)
> -$(error 'METADATA_GENERATOR' not not configured, run ./configure in the root directory)
> +$(error 'METADATA_GENERATOR' not configured, run ./configure in the root directory)
>   else
>   $(error '$(METADATA_GENERATOR)' not supported, only asciidoctor and asciidoc are supported)
>   endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
