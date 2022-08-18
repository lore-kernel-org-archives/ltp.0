Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719D9C00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 08:05:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A03433CA1FD
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 10:05:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 252E23C144C
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 10:05:40 +0200 (CEST)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BD90B60072B
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 10:05:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660809939; x=1692345939;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=7nb9f9sftwZDaZ2WI6GCcTeuGUYUd2d40/qe9bVuk4U=;
 b=iBcUCoigDvjYjjYeoatAwxdFLLPBUwrb9cKtJ9KP2oAWIKonK9SZSkdv
 2Myv/V8YNZ8GmvSjda+T0xKXsiWM/LaM6yf9aHXcBVtY6l6ePWnXInnlp
 hMlyxX2JByfiENzlNZomRyd+KKuZgb3qCIhSieeC5UzMtpmaR8Ra1EvTL
 HtKH/TwSqruZFuDER6Ki4DBUmWhhDmEBct3zZWsmVsseICtz6JT+Dk+su
 hgg2Ygi1mo8iL9pbNehs5AMvn0Ts9N73r0uZAGMfjjQ0fVimuggGtQ1Du
 sadmHo9+i2WDgZsK9hBZCTO2biUGlsSax5ObMlHbqbllb0Y+a1AXoVvVk Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="62979169"
X-IronPort-AV: E=Sophos;i="5.93,245,1654527600"; d="scan'208";a="62979169"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2022 17:05:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hy040HU6t61Z3zEeOcztSmnYgHURtf0n3pMEgUHoUfUaGNHp3XnH9aNr4CsOyYVqhiy+33IIDR5OLZzm4gzGIGnUFuJySjTbuDXORPqJ+vgm/vJmUQjts5feygrTKqfdcoEfye3NsyYQdR48R3m9/h0X9Hfq0E1juhKX03EsPa9on/cd7GdM8h6f/K3zhd8DfUPBJSlN0KedP0P9F5nzl/zC1niwDzY65wtY870sQQxXSQqxpLlPIqmV0N6XPFx5fy+SNQr0Bcfin1MA5s9CMXS9FnGg7XnYNQ3IKZUPg3ClaupOUtYR0yqe74xrGCXzKPBXsm1heUy7S6KcjLthdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nb9f9sftwZDaZ2WI6GCcTeuGUYUd2d40/qe9bVuk4U=;
 b=UiZO0buYkKfAUE/EhvJ5iCA7wlQ+hA57k3igXvgKRsq5LnUJrtsUVhm3bje0wGcd0nSb+Rn+EU+z0elEHpJRCwGyqZSm2ISoFIO+gKz/yKCfU+RQel6asezeBq/epqCzYrWoR7ULfZAa4ZFFsjWBZ9MtSDX5poJmBEZJ9N1gFShYknQH80QOhIYOl+GGH+ZXm7zX5Tm6estMFX6tXLXx2P3Z/Zv1Hqe3gTWiDYhkJYj324bLHtNyhNT2vL47g+Mg4vmT9cz81W7CrZABg9grNnFr0yNDf9oDXd720nmAYUW0nYxBvn4TKhjQeim24bCIGgYbUw+10Js8OJA3UKMdzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB1915.jpnprd01.prod.outlook.com (2603:1096:404:e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Thu, 18 Aug
 2022 08:05:34 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.028; Thu, 18 Aug 2022
 08:05:33 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [PATCH v1 2/3] tst_cgroup: Add safe_cg_open and safe_cg_fchown
 functions
Thread-Index: AQHYpxonL8L7qQ3YBUegaqa46E0RxK2einQAgBKoWYCAABCKAIADMgqA
Date: Thu, 18 Aug 2022 08:05:33 +0000
Message-ID: <dd62e1fa-0b53-e45a-83fc-21a7a2105419@fujitsu.com>
References: <1659521981-2241-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1659521981-2241-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <87zggks3pe.fsf@suse.de> <031f32b2-70fd-8b6d-e2ec-f1d3d1bdcaa5@fujitsu.com>
 <87fshwlh5t.fsf@suse.de>
In-Reply-To: <87fshwlh5t.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0431ade-5a86-45c7-c703-08da80f06d3b
x-ms-traffictypediagnostic: TY2PR01MB1915:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EpZa/JMHvPxgj04LB6xYcOT63wyRcvafwyPB/lQ1JXD38ortiOqvWimezjnmEh4uM+btBE3WzuFS6UVcLupmQfhpFE7HdqYre9RQBsBh5mXh4VMFJCPevl/m3GdxLyBA+3+WgpVIaX0nNJZ2JxaEgL/6hWpttthzZROuRYJpiYSqFPqk1ZV/z65iAzqBgix18OfYBRTjaqzq6XdzQ+kFKOTmu8cJMHPcYAWrg4CRMBWYcV/JYTlrG2l0uTCDSPtGrstbaIStHEA2VNWLQoBp7bxNViOKEoK7FzUL5YHJkVrzErB0nNx9YfINuXVjMdRue9xqTZJBPFtNfnqRb8iarh7kT8ZY1NmrgDYWKKqC0GAGIU/GA4xPJ3cXnLtx8XiuyqTM/Aye2IA0yXkz+6Yb4xqFlTdZ2yTLLf2ZOqUOXbxmmMc9cuNtksa7yVA3uB397lpbptEa1spOHCIWauvQGOP+2Is/84+SELoLeVkLJm35iVC+7Ags/fI9TbVdGqKz5EXQJzXFTqnKJKF7NBp5pTidq+u902BM5fysBBJRmhw23xkhr9UkhJJlSPpIsu1JOoY8fo2f0pOsMDkT8Ov6gYVJ46LB00Q845kxYFy7pKQU09LTv2Bzpz2chNt3tPrtsL+0VAMTkriFK0Jk1KRdv3dJIVVi7jw3Ks7jyVGIuXIY/5FwtkXnIshtQIJA2vAEH17sF2WLNKvk5w32SlsLUOkg8trsebmv7zkeq95hKkw/o3uaW5+pQ5mNGdtToVHmDEPFPpiNcSUrdv6ZV6iNZLa8NBIegKP9njcPHolrItwSsCbvhX19JjHDvcNAYfikB0llfev1fkZXRs4t+39kdA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(6486002)(6512007)(478600001)(122000001)(38100700002)(6506007)(41300700001)(8676002)(6916009)(71200400001)(316002)(26005)(76116006)(54906003)(4326008)(91956017)(66476007)(66946007)(66556008)(66446008)(64756008)(38070700005)(86362001)(85182001)(36756003)(186003)(2906002)(83380400001)(31686004)(1580799003)(31696002)(82960400001)(5660300002)(8936002)(2616005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ynh2M2Y2RURoeGZKUGd5a1VxMm1TL3RuRll1TVQ2NmhDNkh0QUVVRndtanV2?=
 =?utf-8?B?a29NdnhvSjFYeDdpRlNpenVXbXd6Qzh6QU41cTBMRlNQUUZLVzJvTDlLd3NO?=
 =?utf-8?B?TGZrQ0R5cERPSGFvZWJTbTNwaUtkRncyRFFjd1duSjI0TngwMEwwSG92cVc1?=
 =?utf-8?B?cmpGMjJ0QmRHMGhUZ1ZsWWJoeHdMV09PRXc3bG5iVTkyZmFKcXl3RlZYL3d4?=
 =?utf-8?B?YW5DSzIyYjd4Uzc4ejlMa2YrWnNHL3Z6bzlMYU1RUXpVSElQdUYvWUJodXNn?=
 =?utf-8?B?aG5oYWc4V2U1RXQ4akR2MWVwVEFZTkZ0Ylh1L1QzTEp6ekkrckZZbXI2RS9J?=
 =?utf-8?B?Qlg5bEFUb1hBcm94ZDl0UThNYVVVTDFSaFY3di9SNUE4UmtqRWtQNWMrYm1m?=
 =?utf-8?B?WDJrTkFBR0psSEYwb053RkxoMHlTOW8vekFLaGZ2bVNic09RbE9EYzE0ckJR?=
 =?utf-8?B?cWdDRE1sSGo3aVd3Sm0zdnlReGtuQ3lHS3MyOHVwekJpeXJCZEFpN2hoZnpt?=
 =?utf-8?B?Yk04dEl6TXhUZGdPMjZudHkvajFhaVp5R1Nqb2kxNUM2SHo1UlhCRU14dWdS?=
 =?utf-8?B?YXdoN05kNzNiYXNNSGRVWUFPSnBFOG1DT1RLaitKZEF6L2ErUjRSZ05TQ3or?=
 =?utf-8?B?Um5wNnhQUjdCT3ozeXdRSmM5WExTTjF3S3NjTVVWd1NGMzhnL2V0cmh0d0NR?=
 =?utf-8?B?SmF3REVoSHM2bFBtQW5IK3htZlJOVHRMSUdyOHprVm1SK2EzcEJra2FRc3Vj?=
 =?utf-8?B?WDlKaW50QWJrbHQvYUxBNW9tckxWZVlqUHc2ekVHS1lLOXBnb0x4dGN5OVZG?=
 =?utf-8?B?U0dKNnFYcGlsc0NONkVrc2NFZ1hJWTU5L1hLWDllSWJBSmpxOW9nVjhaNVBu?=
 =?utf-8?B?bzlsS1haNEZiL2dsM25pMUwreDhSTy9wUi9PNnhwL1E2TUdHZWRzdFJaNXdE?=
 =?utf-8?B?Q0pIWkRSMitnVFNONy9JTWVCZXMxdVVxNkpXaHFPb09VanFmdlRrYjl4MUZm?=
 =?utf-8?B?UjJoSEZXUmRhWHBqZGlHQTcyemMyOG9NRFovVGNyUCtlL1REZ0d4b0Z1T3Ji?=
 =?utf-8?B?dGlZNXU3S1RCWUQzK0NOekc0ZVdiby9ZYVVXMFZ5eHpxcWJXSXFJWEtBbHd6?=
 =?utf-8?B?UlZZaG0yTHRCcEV6UzNYbk1jZjkxNVZqN1NDbllFbDhlMDhCdlU1THhnSDgr?=
 =?utf-8?B?N1BTeC9ITzdCN0J0RmdpMlpmVWdPQnM3R0RHQTR5dlR4NGl6dGtiWnNSVWU2?=
 =?utf-8?B?cG5sMmpsVFRmMDYwTjZ5MGkzN3QvTzRyV1N5RFJNQkhwN3lrdHZtSzFiUEcv?=
 =?utf-8?B?a015Ym1NYkl4Y2lyRjY2UVZkWGl3aFJnTUFjVG1lMTgwT0xFV2RHTkM1a3lN?=
 =?utf-8?B?TWNhcU5GdzBXQzNoZGF3eGpvdHU1YTV3aENhTkdtajAxL1YwMGtDdk16Qnhw?=
 =?utf-8?B?Y1J3VmZxSjdEWTVMcnJzWW5VZHQyRWxhUUI1d21Wc1V1N3pNQktWRHVUMUFY?=
 =?utf-8?B?WTNUSVhkbytzNlJOMFRleGc3dzg4UjNuTk9uYlJsUHhGeCt4bVZ5RFAvSFB0?=
 =?utf-8?B?U3llRzdQWHRWSDhhT040cFZ2aTNNNTZjYmN5cW12ZHA3NzdOK0xrc2RtK0Ev?=
 =?utf-8?B?N1lNRWRralJ2ZzhDSjg2aExVY2VQaC9VMDVtcW9OTmZzYjN0WWx3RTRDaEky?=
 =?utf-8?B?eko2V01oMnk4SEVEeEs0MFlKMEp2SG5paVRUUmM3c0ZKRjJOUkxoeHF4N001?=
 =?utf-8?B?WmJ3Yjd2Rm9GZ251RXQ3emtZU0FHWllMU0JQK3lNWEZFOC9SdEdKdGgva01h?=
 =?utf-8?B?RWFjdjVQRmhaRjQ5VUVqNjlIUUwraVRoRmdZUHlzUnQ5ZXRyV0Q0WEZNeUlT?=
 =?utf-8?B?V0pqVzFaUUNoa245bE1MSy9uaXozVGgvZm9VOFFoN1hNMFRKNnhQNUE3eTdX?=
 =?utf-8?B?eVp2N0xRQ21PaDVXUjNadEk3b3h5VHcvL2FLNG1WUWdBVjJubllvTjMxbWlH?=
 =?utf-8?B?TjNZcml6QnV6ejdSa2ZDZHdwNjJ1V3d6QTlPZnVpYkZ0UFYwbVJSampMc0ZP?=
 =?utf-8?B?RFpSdEM0TE91czVpYjZoS245dzVpaEowcHoya2p5MndUMXVnZlkwV1NVK01Z?=
 =?utf-8?B?dWZtTVZEOU9YYmNSS0N6RXpqUU1qS1pwWm5ydXYzYTJpS2xLRmtoc1pqdkJL?=
 =?utf-8?B?R0E9PQ==?=
Content-ID: <4FB503D83CE782409599165B1C937D4A@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LH9RPtbGQ2n8UmFmjpC+IF+qf3frh6Vb3vis63uB5hkUGAfrpHS0m1EDS3ay6sLx3Tq/J3Pdwp5ce/8kQe5Ib0oiMZ5G20VN1H/Q6Oryf3UD969/Klhfl9Zt0BvmYPw+ms0506Sg5H9XWVlnhyA9rz8MuGW6iVTr1wYhCcFD3KppVuE25AftWI7vfjXjfXf88htRjpVlvP4tvA8goPNtLM0+1qSt9GYXjuOWhfEjNRoPK71fFghbHebniO2rrou0eJSvx5Ey8ePpVrL0RpV02NUlqoISrLhWZeMRFR69ItQ0uGnz58bn+SGZvEHO1EMntAFa+ipPol8WYKUkWVJN5Sby/RyFdexYyEfDT82eTMvJ2YkFpp3LX53Q+Zq2lwE9uQvnjz5ygUb9e5lt+pEOR8nq1Dli7842BYSrmvmcPTjNcTvqBfnvxMslDne0IIEkpGNzi75L/fxVR7xJ42Z1lIEJZfLJ9kxvVPH1+d4cWSzJHUrjhizXg/zYOjirZP0S9LyPS+rdkhXsQyugFDDcdRiKNEGMvbZ3zoCSdfA2iqBCi93ODw2ULZtlDifLCEoJxcZkkRFKju0GWREZ7MIVOQNjRpu+FNxouD9IoeMZ082qjkpLSZJocO4MZk3/qnzXNflpRhKK0k2p5Fq5Yl2S14SlsYQTJpqQZx05wXvzLDyC1YA02Q2CMY/qmMFVtvK3iEOUaEoJGs8D2pgkBNMA8WGdIJlcfjBTHjqrHczibXxeuaabKrNhK0ipTeaRgYw/VMU87J6ydYBv2a+OoYAPPu6ih5J/VDySXO1NGajqyjp24TjlmBQ+4tH5mDQw42XX
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0431ade-5a86-45c7-c703-08da80f06d3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 08:05:33.8862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCGHzWzcbx0oaN8N30k6xsIhxv3gv0r5EGon+RcdYknEODd5HSIl6wmQzAhBcgxAYE73GPe/3W82ofyWJiWTeNMq4Qzn+rRndC0ZrxmggJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB1915
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/3] tst_cgroup: Add safe_cg_open and
 safe_cg_fchown functions
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

Hi Richard

> Hello,
> 
> "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com> writes:
> 
>> Hi Richard
>>> Hello,
>>>
>>> Yang Xu <xuyang2018.jy@fujitsu.com> writes:
>>>
>>>> safe_cg_open is used to open the sub control's file ie cgroup.procs
>>>> and returns the fd.
>>>>
>>>> safe_cg_fchown is used to use fchownat to change file's uid and gid.
>>>>
>>>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>>>> ---
>>>>    include/tst_cgroup.h | 15 +++++++++++++++
>>>>    lib/tst_cgroup.c     | 39 +++++++++++++++++++++++++++++++++++++++
>>>>    2 files changed, 54 insertions(+)
>>>>
>>>> diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
>>>> index d06847cc6..292c9baa4 100644
>>>> --- a/include/tst_cgroup.h
>>>> +++ b/include/tst_cgroup.h
>>>> @@ -188,6 +188,21 @@ ssize_t safe_cg_read(const char *const file, const int lineno,
>>>>    			 char *const out, const size_t len)
>>>>    			 __attribute__ ((nonnull));
>>>>    
>>>> +#define SAFE_CG_OPEN(cg, file_name, flags)			\
>>>> +	safe_cg_open(__FILE__, __LINE__, (cg), (file_name), (flags))
>>>> +
>>>> +int safe_cg_open(const char *const file, const int lineno,
>>>> +		 const struct tst_cg_group *const cg,
>>>> +		 const char *const file_name, int flags);
>>>> +
>>>> +#define SAFE_CG_FCHOWN(cg, file_name, owner, group)		\
>>>> +	safe_cg_fchown(__FILE__, __LINE__,			\
>>>> +			   (cg), (file_name), (owner), (group))
>>>> +
>>>> +void safe_cg_fchown(const char *const file, const int lineno,
>>>> +		    const struct tst_cg_group *const cg,
>>>> +		    const char *const file_name, uid_t owner, gid_t group);
>>>> +
>>>>    #define SAFE_CG_PRINTF(cg, file_name, fmt, ...)			\
>>>>    	safe_cg_printf(__FILE__, __LINE__,				\
>>>>    			   (cg), (file_name), (fmt), __VA_ARGS__)
>>>> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
>>>> index 1cfd79243..dedc0f65b 100644
>>>> --- a/lib/tst_cgroup.c
>>>> +++ b/lib/tst_cgroup.c
>>>> @@ -1297,6 +1297,45 @@ ssize_t safe_cg_read(const char *const file, const int lineno,
>>>>    	return read_ret;
>>>>    }
>>>>    
>>>> +int safe_cg_open(const char *const file, const int lineno,
>>>> +			const struct tst_cg_group *cg,
>>>> +			const char *const file_name, int flags)
>>>> +{
>>>> +	const struct cgroup_file *const cfile =
>>>> +		cgroup_file_find(file, lineno, file_name);
>>>> +	struct cgroup_dir *const *dir;
>>>> +	const char *alias;
>>>> +	int fd;
>>>> +
>>>> +	for_each_dir(cg, cfile->ctrl_indx, dir) {
>>>> +		alias = cgroup_file_alias(cfile, *dir);
>>>> +		if (!alias)
>>>> +			continue;
>>>> +
>>>> +		fd = safe_openat(file, lineno, (*dir)->dir_fd, alias,
>>>> flags);
>>>
>>> This will only return the last fd that gets opened. That's OK if the
>>> file only exists on a single V1 controller, but if it exists on multiple
>>> controllers (e.g. any cgroup.* file) then we will open multiple files
>>> and only return the fd for the last of them.
>>
>> Sorry for the late reply. I just copy these code from safe_cg_printf.
>> So safe_cg_printf have the same situation that write value to muliple
>> files under the created cgroup directory.
>>
>> So what should we do? Add a fd arrat member in  cgroup_file  struct?
> 
> I'm not sure what you mean, but I can see a few options.
> 
> 1. Pass a pointer to a function which takes the fd, for e.g.
> 
> safe_cg_open(..., void (*const on_open)(int fd))
> {
>          ...
>          for_each_dir(...) {
>              ...
>              fd = safe_openat(...);
>              on_open(fd);
>              close(fd);
>          }
>          ...
> }
> 
> 2. Allocate and return an array of open fd's

This way is also in my mind. But we can also filter them by cgroup 
version and detect the root ctrl name. I have sent a RFC v2 patch.

Best Regards
Yang Xu
> 3. Pass an array as large as the maximum number controllers which is
>     populated with open fd's.
> 
> Which option to pick I think depends on what results in the simplest
> test code.
> 
>>
>> Best Regards
>> Yang Xu
>>
>>>
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
