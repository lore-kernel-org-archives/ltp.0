Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CD3C47DD9
	for <ltp@archiver.kernel.org>; Wed, 28 Feb 2024 10:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709116362; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=4I/ST2NeKO6Xt15yBrSQfpnMX4RcJ0IAFdJsU8aOUMg=;
 b=PfSuMtp6WOdsbO6n2FZnRg3NpAYZTBH5Z+aA8dfJTwcWbks95eFFwK8C4+Jw20sUnkx1+
 /gxMFPDaJEmaSgoS6kHZv1x/fLPqjt7BolPuQugi5QH+raFUr2QKnUPjUse3AOThtZ4VH7T
 sIaAfIg6aR/xiixqXump7vbuyUDntXI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB5C93CBE41
	for <ltp@archiver.kernel.org>; Wed, 28 Feb 2024 11:32:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 113393CBE41
 for <ltp@lists.linux.it>; Wed, 28 Feb 2024 11:32:19 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=216.71.156.125;
 helo=esa12.fujitsucc.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5011F14088F3
 for <ltp@lists.linux.it>; Wed, 28 Feb 2024 11:32:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1709116339; x=1740652339;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ltuqX2XbSwZgnP3AeiKOSOx3bLnrLlMhGysKo9fhlLM=;
 b=qklCpWHTDZReVrAyeKsSyQBWbM7nj68T57LgnPs+r5VnDkObBjGMGcsE
 Nr1ym92lSIirbooIghV0SuNkplBBL5URo9iP/N+ktASpqw/PrQSQXoigT
 OUFMZiB5ryZRqP1Bk1z1F3eq45fXNsw9CTg7U68po0AMyOoADqZh4XC9d
 05b7kaFYW2+5oqTuUxMUJqydvXSczCLptX5uf9Ko6Ihpxmr1y9vMheUHz
 93lL0fL3OgO//go3DA9m5qexQsU6Iim4sR2ak0K1rIdsAPHzeZXfNhfjn
 PcgPZEpFI7QE74iMdq09bVvOjqHLUNQcGJfEdmOo6gccA63gPDOLNRpzR Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="112663060"
X-IronPort-AV: E=Sophos;i="6.06,190,1705330800"; d="scan'208";a="112663060"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 19:32:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DC73DqcmFEDqvL8b01IJ8x3rwQPZdF4vLfY720uKyqyBKi3tL67zicdQ3swnRXKMxu+we2EAw3iIYDJk3GTCwq0SJPAoRrMAik27V6GsVJsMEkeWHAFLZhrtQIscUTiOMvYf81Mb49RaJPHFpRzJPCJM4fuyjPo+NpC3WyZGVgLkrc3Ppzg/DiBft5Nj/DkZBi2ETX7UKrfd/CipFyKJU2DBO+9SzCFbkXN+ejvBM8gD2Kd4WL2X9Gs1xGK/af7iNj+D5bgekxXA4H6vc2PRo2o4f5XKRWJgAoQ+XKctnRBXts8xsoWbppcfOuFQldgkP+E4UFI5Fp8GyB6udqpzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltuqX2XbSwZgnP3AeiKOSOx3bLnrLlMhGysKo9fhlLM=;
 b=aRauzeAgMy6h6RyA9XkTV9MlJVZ4U9flAKbxIdu1zdGh2qm5t3edfvACtqxvQDtL9lReEtCPuHgYVownUPqxUDH7YVcczOJIO3bULDChSuR5QpvFO8gFVuDXs5kbh/47JhOpZ/p7OnfIfljIaiTTaNPBJsO+gv2D97imwkj2n/0YxvVJBNLJKbUlXyiSBFN8pqh/4TIA2B1m3/OdV04lqhS0F+cxfGKuPzUxmXIdY5Nb0f0tXOBpuam9f/+zK85Ek/GvTXwf77arni6mes+8mpV5bRi2qOk//MmxsCkrSMNeUgYDvdqAd7LWWhu/8DuM3Z0pf4lMmjud1fnXhNAvPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (2603:1096:403:2::22)
 by TYCPR01MB8125.jpnprd01.prod.outlook.com (2603:1096:400:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 10:32:13 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::4e0f:c728:1baa:591e]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::4e0f:c728:1baa:591e%3]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 10:32:12 +0000
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH v5 1/7] libltpswap: Add tst_max_swapfiles API
Thread-Index: AQHaaLs9gGNouIcO5kO5iFtn+QOcFrEd6OcAgAGoZwA=
Date: Wed, 28 Feb 2024 10:32:12 +0000
Message-ID: <41952c7f-9b92-4382-8f79-dcfaf7397e39@fujitsu.com>
References: <20240226135336.19733-1-xuyang2018.jy@fujitsu.com>
 <CAEemH2cpcrPw321Jwe49U=UNGmvVmQ7OKOKzB2LnjPrdT5Qakg@mail.gmail.com>
In-Reply-To: <CAEemH2cpcrPw321Jwe49U=UNGmvVmQ7OKOKzB2LnjPrdT5Qakg@mail.gmail.com>
Accept-Language: ja-JP, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1578:EE_|TYCPR01MB8125:EE_
x-ms-office365-filtering-correlation-id: 14db755a-2e9f-4f06-38f8-08dc38488688
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5bXdSKsJtzyKjQ36AmRQTosq0hL9zQ0jrHimcE96CecTQBH57eruu1Zy6Cwvk51haa4y8DdqjZOf2MmKzwRaSgc1VSeSg6y4E49BmfFFJPcE+UthxsH8JoDOHSsAEjLnkeMrgLNIdUhvJPDhixrIjWumvWEsb4bGkZ/OGcapNgBjCyoZnBjL9Zsxn3tfvgh7+dUE3HctvN71lDKOJFKIG+7TnSKVo13G4McP+08iS44kovL7mkttHaQe3ea0GYz0S17BLMC3cwSHPykaZhA4+UhdxqZfM98srZnO8u2l0HX324/iQWrAiQgLnxgiJ5t/x4/PfgXESC+0nCL1GHkKdFoUM7c6eQCm9GOBrKKYGujq4Qu7w+19DGysXgKivBroZ8EeLxTDf0DdZa741Jc3pnsBDFfVXUBZJifqvIXHv2aPXYYx8t/M3DTd3VWndSgmI+GTauLbFuNd/Yo0Jdx9APufZd6kHMep2J2lBstKcidpk4J9xH+VkiZ6iVUmOI56ok6XefTo6wCaAHxLVaHxRAHCMlhoVdAW+cqOSn4vLg7DgtCNJHXFqLmnCSts1P5FGKgOmQ1uvIT108kqHzn86fwsb1+xJestQQIpJNkfpPBjYpUyVCuVhV+4JWLrG3usYohbNkbOPyyRRyQt0T5pUGev3p8WzLXiZLTCRFnFpDvLwf84xSiD4iHfS/hPYcxj04+OTfoS3cueqSjMPq/szlH0Vb2uLyhl5/glUO9LW6l5e73nKDJxCzfOq5+N4X+M
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1578.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009)(1580799018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU9mQjc2Si9wWFAzaFNQN2JZbHVSQllCRnRmL0FPNHREVXhMMGcyS1U0UXFN?=
 =?utf-8?B?MiswM05YNGxQQTZzRnRzVkpLVEkydlljN2FpT1JzU0l3ME5WcmlGbWJZcEVv?=
 =?utf-8?B?STMwM3pwVjlLR3VWYUdJVUtNMmI0a1RpMndxNDNSeGh5aUFqM0M5QnJ4cGRq?=
 =?utf-8?B?TTBhUyttcFFmejdQVWRHdTFKSmlSd0JKaWx2TUw5VURXWGZqUkxleEZhNmd5?=
 =?utf-8?B?aXIwQ3BkbnFZbXZVVWxCOTlWMzVXODl2M09oYmNHZWs3L0lldGJuZ3pQcmlu?=
 =?utf-8?B?Zk5IbW5vbmtwTWtITmcyYlFtR2FJeFQxZE1ET3p2S0hDQTBId0dzanVUVzd1?=
 =?utf-8?B?dEV4Q01kcjBTMG5ON0tkaDJycktCdWF1ZFVVSWpjRHZNek9QYXRrekJHMkto?=
 =?utf-8?B?NFdacXBHQ3lyVThZNUZaNUw2YmUwZ2E0ZExyTGtHYlViaHNJMUpqQmJPTVpH?=
 =?utf-8?B?ZkFpa0xUcDNvWjhIdEpIR3BKOHB3RGdON1R1bjB3eksxU1p4TzRIR3llV1Z0?=
 =?utf-8?B?bUVxY25BZW1HNmRUaFNVS1lrQzVHREh4RlMwamR6dTNiVVVGSk0rdmZ2Q3RC?=
 =?utf-8?B?Q05WSk0xRG1GdVZzdXBrUHBmZ0R1QXBzeFAzcWRLSUtVMHVrcXJxWHVNVGJm?=
 =?utf-8?B?eFpKZGNDcEd2UHppUk5KUW8vaDdHbnhuaXl0NG1tYk1Fd3RobXNCZXdQNHYy?=
 =?utf-8?B?WlF0dGgyZWpmbk9GMFd0WWcvbzQxdnNOREZKcUFQb1VYYW00SFZwV2UyL1lF?=
 =?utf-8?B?NHZyUzJ2RmsyK3lGd1A4emxLaW1VQXhBaFAvOFNwR2tuYUtnSnllMm04RGtk?=
 =?utf-8?B?WnZTQzU2MU8rcmwwU3RmN3pXU1gvRytqaXhvQloyeFh0eE0yRjVtOVhXVlJE?=
 =?utf-8?B?azlubnk1MGZTSlovSmNWOVJVQnNlaXkwSHlURnNYK0pDVS9CdXJpNzFOU0xv?=
 =?utf-8?B?Vnd5VEV4OWZQVmx2Qk4zMzUwZGJIQmtTaUN5OVRtM3VJNllpckxqL3ZmYnVX?=
 =?utf-8?B?OEIzUTJmQkdKdkFWalNMb1ZMYjdQSGwzazQ5aEJIMGNXdWRhVVFJeHA4cWhV?=
 =?utf-8?B?SjN3WXNha2FJdzR3MVQ1bHk4YnVmQUxreVJpRXJqSlRlVFRpaXJrNWVFZ0M3?=
 =?utf-8?B?OVQvckFaT3RINEhzQm9pczdCT0pGZmhMQU1MdWdhSS9JMWwvYXY3SFRyUzZi?=
 =?utf-8?B?U2phWDQ1cVVaUzdDVndoMDZndXF4ZFZER3hSK3ZrdmJTRmx1c2Nqbmsxbmxk?=
 =?utf-8?B?Q0hvYWZUVUlEbDRIcHFiZXRjOWJkOUpLTFFWN0FkQ2FDVkIzZk8rWW5IN25s?=
 =?utf-8?B?OE5mb0ZUWks0eE1vUDh1enR2TG1zYzhPN3ZSRFZHeE1oVkxOMm4vMTlCNXg1?=
 =?utf-8?B?WnJXOGlaQ0ExVUg0TXhCbE5tNE42bFhZWExDOUxmb0JUWTBsNkUvZU9KNlBq?=
 =?utf-8?B?K0R0Ui9mV3RTcnJCdDcyQjNRWjlJNkdHU1lTUGxhN1F4Tk40Q2JDUkhkeWdQ?=
 =?utf-8?B?TzFCR1VTTys0OGhmZWdHN0VyckhNMkN1Mm9IYTVFd3NGYXF5OHE4emwrdGY4?=
 =?utf-8?B?a3RPTkRuTlpnSWhObkplVFdWVUJvR0lyYkxMZkZQYzRNNlNCRUZkc2pOTzRB?=
 =?utf-8?B?Nmx2WThwZmtTYmM5dUZQTW9rb0VUWm9VOWpXMTJsR25TMVVUTzMrbmdtUVQz?=
 =?utf-8?B?dGY5UVJmOEE2aXh0VklsYnBNVjZOMitlNFlSbGZuV29KRUxJY3hSWFJuZjlM?=
 =?utf-8?B?ZFNhWTZTaTJBNWU4bmJKZ2I3QmJIckhoUHNOS2FDc3pxZVZJVnFSbVJpem9w?=
 =?utf-8?B?M0U2aVZtUUsyZVpGWG1VcjRkWFFSWHlGZC9qeGtPR1ZxN0trMGE3YitjYjl5?=
 =?utf-8?B?SDhFVWlmUE9DMFd4Zk5jVm55aHVHRE1TK3V1TzRmaFpPR1VqSHllNDZFQzNK?=
 =?utf-8?B?TzJLS0kwdHNDSGZ1Sm45cThiNXlaZkhPeE80SzQrdUlISW9UTXJJTnRtZ29Z?=
 =?utf-8?B?OGdORDBXYXVuYk1oRUFPc2dTRVdPVjAyQWlCVmc1RFJvdVhtajhwOVFBNXNh?=
 =?utf-8?B?SDg2V0E2eTlydnl1SHZXSzhvSDZ0eVVMc2NJKytrTUFYS093K0ZBbUhIOG9Q?=
 =?utf-8?B?dmUxUzJVTE03VnZ4Y2preHd4aU9IYnpjcUlMcVcrc2daMGF6bnowdTZmTXpM?=
 =?utf-8?B?MVE9PQ==?=
Content-ID: <4DE7E47EF45E584AAC9E4C16544EC92E@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lYGQhZCuHph8Ezqbtfm1u2YHMW0PzZ8jjaOj7MaHQmV8VBfl5oMOG3Wu5UV0xbryLDJuf24EfcdXOxPuH907Ai+2bzEqWFdvS4khabeeGa4Iczw5rcn1xaIIpmFzT+LoUyM5L0ul9cgJ3W3ZQ/FVpbedXumpI04d1CnTy8VzVW8guqstDBLMBiU5EpGNptMyvH/YFZ/ZIq/bf8kgi0Ji8+eVyT2aHXVx1UNu4VWW/elAvkXJbfkb5e9+MN1kaz/wPIQKq1Nksbw17KAKRGh+ZiqkIgH7Bu2FjVXwuvttFx7pnK29FUUgeahrgwPUOemNy97ulm3mVtYhf+19OA+yziUoTFXbZdlV4UlTaHTkQ1lg4r9Pnhx3EI5k9233Ni2jtx+NGb3jW6LwjtZdkuVEdDMVicg4mgQnssBO+Dou6zSztpkx3eMKS07+87B1PQiXP10DwkuOjVldccqSAGnruQEyg2MXkJdb6MfhezlidKx8IHA2E4KLxVUArFLjWwV+xvxsgN9oqupQ0IZv79CVHDu/1hjLtph/dAEQiCR1E4fgT+bdr6MYyE+kke8VP5z7wVWHS8wqjB0miFw+wgpNeNg6LfpC2fDOyveCzBndsw8PyDErZ0KWYUO8gQTm9cyy
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1578.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14db755a-2e9f-4f06-38f8-08dc38488688
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 10:32:12.5186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fVEfEdJlh2MnQPreeqY2ssMchbVpxQILYnk/0O2feCKg4/cF3OD+zQvLvznAaB7rq9OFeR2um5gRq0W66FOgHsljCu7RgBeE6a6VUHQmGbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8125
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/7] libltpswap: Add tst_max_swapfiles API
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
From: "Yang Xu \(Fujitsu\) via ltp" <ltp@lists.linux.it>
Reply-To: "Yang Xu \(Fujitsu\)" <xuyang2018.jy@fujitsu.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Petr

> Hi Xu, Petr,
> 
> The patch set generally looks good to me.
> 
> Reviewed-by: Li Wang <liwang@redhat.com <mailto:liwang@redhat.com>>

Thanks for your review, merged!

Best Regars
Yang Xu
> 
> 
> -- 
> Regards,
> Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
