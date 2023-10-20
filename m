Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8EDCDB474
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 09:49:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76E443CD0FD
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 11:49:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC4DB3CD005
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 11:49:18 +0200 (CEST)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 84797102F3F1
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 11:49:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697795358; x=1729331358;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=oe0bUESxC0ZePSNdvUitIhnhqQetACvjUCfyJt1L+TY=;
 b=IAo9HjTsSskyPl6BuvRWuAtDm9xEAiyI4jIV9FL8hnWBnC8sHyGrCDDP
 tC93QX+Urvt8jnpQOUj52nOyK0iZgenhV/rTnVHqu9tM5Vgd+4vOwwhwz
 A22cAGQ2ojk8vWKmucFjYXVuJSI0KqkSPX1y+wzrSOJYk4RSmsxunxBsV
 QHw7ve5NQoiFqq8RwgTuZru6uGO30eFsnDEeihtL+QuUd15IBeV1cmRsA
 NM9WlJnKJmStgiFiK3GvEpkcJeL2T0cftpfqsLrKhUuJO3aSo/97fhF4d
 IXoJb8G8Lwwye0kxpkxowS2CSOLtz1Gh3eG8l4b2jn/ML2x78vBf0sW5p w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="99957436"
X-IronPort-AV: E=Sophos;i="6.03,238,1694703600"; d="scan'208";a="99957436"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2023 18:49:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2+LkbaN38sdqeUhKqOYIF/6MjGoCTnxRAVjTn/Ufy0vC9hOWgUhA88FO7rXD7RiWcq1eptNe4+1PcfJltzAhNX+DIZpEfP9SVefMWWzS82ay12nNx4HJlLeBsl7XuMT0DaetvjpjIZqmo/S5pd5/8o3Az//Ine57BFoFgH+42RxYAwyhIRzBSuZYT2Zmgm459uLV2IeALYADpTe4aixxdUd3ERb6w4N9lGgCV+LSMGMSffJUXPFwFfxYduyaFFGkf1YeKkRlOyCvh2se582w7VUCZ8i/MaecPaXRoorNlJ26rAr3+MBm5Lh3Zfe3CIVXUp/yjGvL64Drjwi03CTvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oe0bUESxC0ZePSNdvUitIhnhqQetACvjUCfyJt1L+TY=;
 b=RIvpP4Nia8cu/tUAzfpcDw7FrnmSoRDopQcj5CO68cv1ZqFsgPOKDySdb6Co8o/XXfLlzyPKRmqea7d+9Kw8Hl4Y380xztk73MNSbE5lTATr57trTjH2nXjclmBtEV2fj6h1Z4cX0DcGpFNjHzQDQiqRUPSi15D9ImrbPkwBw7L7yljjkzzVHtLfhzKx46e5+yxESxsqZBEDIIPg0EnAkctjVJW8d5FqveMCzIjRossKE8xLaawM/qr2tKomDu73Sgkmqtn0VJIKs55R423P/G0cwWFR9npBqOsVOB9Qr1UK1aY0i6Uts2gTXVowItREhIxUnc0z+B71Se1Uxrctww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB11829.jpnprd01.prod.outlook.com (2603:1096:400:400::6)
 by OS3PR01MB8746.jpnprd01.prod.outlook.com (2603:1096:604:152::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 09:49:12 +0000
Received: from TYWPR01MB11829.jpnprd01.prod.outlook.com
 ([fe80::f1bd:3ecc:3788:292f]) by TYWPR01MB11829.jpnprd01.prod.outlook.com
 ([fe80::f1bd:3ecc:3788:292f%7]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 09:49:11 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH 1/3] umount01: Simplify test using TST_ macros
Thread-Index: AQHZ/Ofa46poaX/NHUiJTdnCFjZr1bBSe4iA
Date: Fri, 20 Oct 2023 09:49:11 +0000
Message-ID: <1711960e-1112-614b-aa6d-bed2a9fcdbc8@fujitsu.com>
References: <1697100058-2859-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1697100058-2859-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11829:EE_|OS3PR01MB8746:EE_
x-ms-office365-filtering-correlation-id: 4152f03c-598e-4d61-bad3-08dbd151d017
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SKO5nfTRaEJJvnZ1JrRa2wOdt2YtXngtw9Oeu4mHDwHdmeNau6X/76X4LGtw2sZDlMg9uOI7gESnsvQuB2sS8NTSqYrTBlfz4p09FJzdOq2YtAqshskIiLa+84DRiXgLYwaU85cIXEXqn959M0Xf55sn95k2FW2o6JMkdE8Bz+25r5nEDyW12kWhy/i2KOYbtNYM2SsDsWkKrX++msV0bp14BYD+QqHoB2A2qQi88XUI2at9jmzKcg2X3yTpvwQOch/aallhU2AUmye1e/y5kkCtEKilsV8CN6P5Mvelk2+GtV6OyCjWqUB8JlZ+Ql8yRRbSgIiPkDEHfeT/WQLYu6O/YGnuvB46xxRupQ5Kcae5yH4wxwg5lRJfBhCP8V/Gp59YDJ+rbiIQoQLg4A8m1D923gJnye6J5763gSrHydVc7iGMvy6B8schg9J+6FzLpxohdjnfeTb0w2+4ogEkhGGJPUute95IkfViLugXJH4SoBNQRD48j9m0RXaSNW+r+kAGuo7EHHSG4E3cy4X9qzQU1BkqpJfyKUMt9LEXy71uN4buvVU/9GINTsyvEuZUslAOW0jSMGDBgUAR79569yERg6xm+zdL3ozb+revggFJI3NrPzyE4rMeeT+skSouft7CUJq+l7iRfp6ZaYYlFkuj5mrHDoEoXuVrTei67yC6x9zppWNAKBIvQ2Wt5t0r
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB11829.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(1590799021)(186009)(64100799003)(1800799009)(451199024)(31686004)(31696002)(38070700009)(1580799018)(85182001)(38100700002)(6506007)(36756003)(2906002)(86362001)(82960400001)(6512007)(122000001)(2616005)(5660300002)(26005)(83380400001)(6486002)(41300700001)(71200400001)(8936002)(478600001)(8676002)(76116006)(66556008)(66476007)(316002)(64756008)(91956017)(66946007)(66446008)(6916009)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajc1M2M2T0VMUEpJQTBXWVJYOGt5L0dzVzdheUdMK0h1c1A0WTNCd0thdWFL?=
 =?utf-8?B?V2lmZzJBTkJZM1lzdXBBVWF3c0pJYmM3aStUZ3BKd000aEppaEM3dWIvVW5S?=
 =?utf-8?B?M24xQjlxMzE2Ym5yU3lNU080c3dGSlE2em1Pamk1RVE5QzVwYmNvUWN0SlU3?=
 =?utf-8?B?Vk5iWHEzV04vN1lVWGRaazJzRmMrNFVKYWhOOU81V3AxYjNFN0VvZGh6KzZF?=
 =?utf-8?B?TXV4R2Jva2trb3d0OWVpSVJybHBMVGxweEtaNEJMUjU4Z2hCSklzVWJMaGEy?=
 =?utf-8?B?am5nSFJUcEh1YnVaSnBGMnl6YWN0WVNmdEhLQ1VuekdaQTdaOFp0YXZJY2VO?=
 =?utf-8?B?VDU1MXpjRHNpYzZoNHNvb2FKazJoRExFY0xZV0ZFazNRSUxUaFpubXFIS2Rt?=
 =?utf-8?B?cVRmekxXMlZ0dlViRTVkS3c2UXkxTDUyUlpKRGEvZi9kWU14UkpuSmJqUHo4?=
 =?utf-8?B?TEVRL3hFRkcveWNPMWFSa2YrMCtJN1RKYWE2MW9IQ2N0Vm9kNkNCTGtDcW5m?=
 =?utf-8?B?ZGt3M0JSdDljRGx4K3FoU1BLUjdXT0JDRThuaE9rVXZaNStELzNKbnNZd0hS?=
 =?utf-8?B?YWt3a2ZXUk9XUEg1UWl0cTNleFgwVW9WMmRqdEZZWGozSmx6aks5U2JMcE00?=
 =?utf-8?B?RlY0WFVXVk9tYldEcmh4QnFrZ3VUSy8wNWlwMGxmN0dKalZ3QWw4Z0J5Tkg0?=
 =?utf-8?B?WXUwWDkzbFVwdk51U2NXemRsQ25WYzMwYWNnSitGR1kyUlpoL3V2TUxGME1V?=
 =?utf-8?B?OG1PQ1JXeldVNXprcWMzOUZWWU5uY0VUQnVyQitlUmZQbDJiTjRLdHhGSmZ3?=
 =?utf-8?B?YjlLNzhGNTlhODRJUmgweWdXNHpPYUdVYWpEVlZTRSsrblJNOERESjl1Mk8v?=
 =?utf-8?B?WUc5eGhNL04va1NoaFc4bG9UZ1pqaGRsQmdRYmZ3WTUrTkptbjlXaUd6bzdi?=
 =?utf-8?B?MUs1Mk9qYVNNN0NPUC9BR0QxNE1IV2tCdGt5clJKQ3BpT29JcjF2RHVPRnBa?=
 =?utf-8?B?cDVjK0ZXNXdPQ3NLMGZoalVHcHdJb29xZTNHS0QwTEMvcmJKU0dtOCtUUDZx?=
 =?utf-8?B?a1hvWk16TGIvT3VSblVHeWJWaUlxR1ZRTzVsbFZ3WUZ6Q1NIM0hlQW5HR2pw?=
 =?utf-8?B?NXFWa05vb2E4ZmNsVEw4MUpXVmNKTlR6VVRJK0U2MDhTMTRNOTdTQVlHWnNn?=
 =?utf-8?B?YTJCUjREeE9BUVJBTmpKVGZLdXp6RXVUQzFoVGdCRkVQRjJxd1hkSW5oQkor?=
 =?utf-8?B?UVRqWG5JdzhZc3dveXFxUVZQQmlxNk5HUWJoSXFKY3U5NDByTnVCYUljK25R?=
 =?utf-8?B?ejA0MnVYMEFxb1NGVTk1Q2g2Q3M0TnNXTUt3bUFOTENaL253MHI4RTQzbFFC?=
 =?utf-8?B?bXBEVWpTcW1VTTdSTXRPQm1CTWYreHlzQWc2eVFSWFlFTkJmakVsbWE2bkdw?=
 =?utf-8?B?b3h0L2tKM1R4Vy9HSGRyTmlmakhtSDk1M0hOZC85TEh6cHdRRGhYQ2RSSVp1?=
 =?utf-8?B?TTIrejhjdm1KRUo3QjZDbHdhSUxNNUp2cFhuNFkycDJXc1hHc0s0bmcrREdH?=
 =?utf-8?B?SjJuandJb21qMk5vekIzdjVxd3llcGUvRWszZE00bUZUdTBkU0ZaQURIYzV0?=
 =?utf-8?B?Y2N4ajR3RTAyMEZ3dU9EendwR3hUNno1VzdtdXlEdjBNZzRNUkhuUXBHR0JZ?=
 =?utf-8?B?bmowQWtQU0RJK2tPQjRzZ1NJYmhBVkpXakJMRldwK1N5VWNIalpBa1d2VEJY?=
 =?utf-8?B?VmJUckxXWlkwbkpLVnNQS1FvMTU1U0FFRUE3SUNvMkdrY2ZBeUZTVTZqSC9N?=
 =?utf-8?B?T2xkTENReGxPSG9FRlN0aW1TQ3g2RkJwbG9SRVhETHJIU0hhZXQwaHQ1QlNX?=
 =?utf-8?B?dzVwaXl1MkE3VEJRWEVpUVI0VldQOHdXbm5US28xUm03RWpSYnQ1MFlTM2xo?=
 =?utf-8?B?VEtiWlZUMnh2Y3ZJLzBMRUJ4d1hJeUduKzRCNVY2cFpWa0F0bVlmS0pXa1F5?=
 =?utf-8?B?bGJuNFBEdzZMdWw0V0t3K0ZzcWFPTUFEMmErSFk1N2hKTUg0QU5jM0VLTlhN?=
 =?utf-8?B?U1BiK3hvbkozRjQwV01NR3hId2xZU1lpR0N0OHI2ck5hVDRieG9neTMvMUxs?=
 =?utf-8?B?QVI5M04vd0hpOEdSenNOWGd0WkU5aTRtdFJQZXJXOTA1Q3VReVlzQ28xZ3lK?=
 =?utf-8?B?aWc9PQ==?=
Content-ID: <C6B4B977EBC6DB43B872353586324518@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 472PKCkYu0UpAJ7IodrCvMsHqrjf3pznFgukJyjpLxTnBTBXrvfMHZzrufUMIIqVdOFr2wOxIUFYtEnv/YVINO/godAChteBgBn8oZhgq4Kkp5nMBJOqlwNByZitmvqwqg0JTcrJEicSJUCliKUD5KdXb21OKT8PgejZQ5Z5XtHotlG/NeP6WFB58lY83YmDcmYbQFM8pHjr1+P9n9L7fQHSvmzGFKaQ2q6QIGDnIGm4GrLZdYTkPUOh3nelHuOYhYeU9Hp7WBIPgZSGFnNNeyogvr6qzg24FvpL2jTTvrTNF3r/jyGXuy9/QO9N6fkPAl/dDxu7dZQETExU65Qy0i4JsR2ZgU6dH2uKqaUhQ0No+u2z9PrBAMQ0QRIU5JSNn4ZRIHssfqAHV4XmB4a9nV5YtX0mpT2fqidstA+505np00cRSv4iQcxcDiOMu0cCks9GYE/z2rZQiI42jUt6Pv8oB2EA2kFcX1fyUQe4xJoNienIB7EroHdPZvNOd+plRtfrJ9GdBWC87mkCrOXaDqMYpGK9Ityb9gD+/PomgmyRk0wxUy2hJCYU0Kb6f9s74jivTuNn5KjXGmtbKSFUbwQN9ZuSPmWeG6GzSqNs/1L4J4cKZ71u4fU9kkFig+TXqbVLCa7ZmSRMQJ8j97FEes/5NaEaeW9Q7/O/8rJFuhOGhjX9PCF/O4NHitagzghL3RLG1svQ6DTyR+fIlLiWP03rpZ1hhi4ChkzwGl/6CDIzPYRAYXybYdh+Q6w486x4Eq64+DR4/ZbCGYnNPZuRiA==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11829.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4152f03c-598e-4d61-bad3-08dbd151d017
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 09:49:11.6697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FGUxeQCIk1i9EdjtY8dgHBeoVVAOLDEOLkVwiw1FmTFTA1BDQrIc6M14xz9i3+3ztnuAZnN6GRls/p1CCYr14KW6Vof4DpAD82xetme33Tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8746
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] umount01: Simplify test using TST_ macros
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

Ping!


Best Regards,

Yang Xu

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   testcases/kernel/syscalls/umount/umount01.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/umount/umount01.c b/testcases/kernel/syscalls/umount/umount01.c
> index d05296dce..2950300a7 100644
> --- a/testcases/kernel/syscalls/umount/umount01.c
> +++ b/testcases/kernel/syscalls/umount/umount01.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
> + * Copyright (c) Linux Test Project, 2003-2023
>    * Author: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
>    *
>    * Phase I test for the umount(2) system call.
> @@ -23,7 +24,7 @@ static void verify_umount(void)
>   		mount_flag = 1;
>   	}
>   
> -	TEST(umount(MNTPOINT));
> +	TST_EXP_PASS(umount(MNTPOINT), "umount(%s)", MNTPOINT);
>   
>   	if (TST_RET != 0 && TST_ERR == EBUSY) {
>   		tst_res(TINFO, "umount() Failed with EBUSY "
> @@ -31,12 +32,6 @@ static void verify_umount(void)
>   			"is probing newly mounted dirs");
>   	}
>   
> -	if (TST_RET != 0) {
> -		tst_res(TFAIL | TTERRNO, "umount() Failed");
> -		return;
> -	}
> -
> -	tst_res(TPASS, "umount() Passed");
>   	mount_flag = 0;
>   }
>   

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
