Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E5CC6FA82
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 10:03:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C36033CAD4E
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 12:03:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB6DA3C1B85
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 12:03:00 +0200 (CEST)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5FE9B14011BC
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 12:02:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1663840979; x=1695376979;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kfU2Iq9hey3kuJXAgEnx3JH5PJfa0WQi86NHisaQles=;
 b=Wx9w0HlN0K2iD2xAA2+2NBYt0hcodoytfR6GSz5cx74Le9G768U7Cegl
 8jx/xEIOo56vT2z4WvbWOV1y7jH7DPp70EehIMlLWcY38vpyO7i1B8c0K
 DUW6oeNybdrYDWyfSLpXCnDBMxCWbUVhwyNs+3axgak0bLqSmDVPIqhRb
 FNHNJvR8ZvQSW0gRvL/4zidtTvelJ2OqiTMbj4YCZ/TwWvDxGjYU/ioX3
 4uvck56TU/zo/SatWjJaxQ+FOEya8fJdx3qDhSzsBDrc77jvtmw0nJJDC
 nO3jHEC7NQ1F9sQWtgUehg+al2s+sWW842bMnqXjIScYYn8Mqj6gfOrAc Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="65568904"
X-IronPort-AV: E=Sophos;i="5.93,335,1654527600"; d="scan'208";a="65568904"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2022 19:02:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipY8l+nSnDgtzJVy9qHrGgSFyi9HRLECWjdaBtBvdfN52tN6hgf/O4LO1cn7yfsFlErVRLR/WccsKJfk6J2dUKY1h+mx7c7/TgfCCHPGOryw5BJX7gHhCDxl9t8eXQi/HNKf1rnEmhw7y6nDb2lcn+5DzH7okqFXPR+m2eiqXP3Jqj3tgbjmuYeoivhiFcnYn/NAbCfoD/wXNBOiwti+6zfhsFJa9RjvD1o6x0TZVqYbCdupQyXJ37TNqc2RPiiZcIbfGppg4e4TsecZiz6fAkoz/pC4Vph4lK3r2f//CO3mFMRPhueo442jbc22++CPzf0yH63OFpOD2MQdHM+F8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfU2Iq9hey3kuJXAgEnx3JH5PJfa0WQi86NHisaQles=;
 b=HXZKStqq+zQ+c/mp20vAHthSBrNaTs1FZp9cusW37VEvEti5dHC4jUja9PGJ3O7eZP2u4f+cvnJ6sd0yejLLxpbJyH8bMp2avCaqANVoy/wbWDp5JhyILYANlw2i2GbqLtxNlxXG8APGvqiYmNAx6qa8Mt+YnMToEdeGqUM0wiF+DeT9FdKmFhD8MZKomfbwnXU5msuYHWKZdtdwdXamDWb9alGcmTwUT8hWRshuK7HMqpIhhLFdhutx+sNSjhXIbF04K1feSCxlRszFGjK6xRSFDW84TnjSU5TFqq6iqhD4Yi6+HiEbrghXare/OHnQUsz7BRf+bD5DnbOyhkZ3Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY3PR01MB10517.jpnprd01.prod.outlook.com (2603:1096:400:315::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 10:02:54 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5654.017; Thu, 22 Sep 2022
 10:02:54 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>, "brauner@kernel.org" <brauner@kernel.org>
Thread-Topic: [PATCH v4 3/3] syscalls/openat: Add new regression test when
 using open(O_TMPFILE) under umask
Thread-Index: AQHYyAlViPga5eQsB0uSM8Tbg4syU63rMVSAgAAUR/D///V0gIAAFm1Q
Date: Thu, 22 Sep 2022 10:02:54 +0000
Message-ID: <TY2PR01MB4427C3E253A3BDACFE094BBDFD4E9@TY2PR01MB4427.jpnprd01.prod.outlook.com>
References: <1663143142-2283-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1663143142-2283-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YywiZckfyJIk1/Pf@yuki>
 <TY2PR01MB442734C41B2B574CF05B8AE1FD4E9@TY2PR01MB4427.jpnprd01.prod.outlook.com>
 <Yywqj0orkajkDZt5@rei>
In-Reply-To: <Yywqj0orkajkDZt5@rei>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9MGMzNWQxZTUtNWJhZi00MTQ4LTk0MWMtNDYxMGRjMzA4?=
 =?utf-8?B?ZWVhO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0wOS0yMlQxMDo0Nzo1OFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|TY3PR01MB10517:EE_
x-ms-office365-filtering-correlation-id: a62fba03-222d-4be5-0561-08da9c819e3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rx5PCWUIRVCav+Qy2lUHtfGR8RJrcMIxK/Tl4UA9ibRgDFA4QnzlZ8ZcHDQHkewQDuYdEW08FQpbdRj8ueYpdwVZBPGSrTPXtK81I+bDQOq/gYP6QycHP4I+VFegjbVuaVvE5vloC+wOHnYSYrfy11ldTDNQTlGvakWM/oHiS5nmm8A16jv6lPR+kl3BdrzThGGeIoS35qL5da6sB/rDGJwOtGj8e2Yu0K2XfAUFiR5PEJfijjUI5vRhXapIEhlUeDeFt70wJgacKwxen5cvYpYOvxd39NBEyMkqGJykFDF7lmXhN0EdiHzNDBxVAT0xserWCFLNvL2O5hzz0oj64vgtPQ8rQQOIT2YSVDvQOHzEIFKebH1B4/F4u0GVW1Na2psFlWIutU1neIP+Rhoizab0LZIs2OsPJiHLoF/7RSFMmk3WQnkeQHvnnfa5bm79DyN5LBVcjP9pxrgiY3Rw6WqvDyHOzT9eOn2yOFTOMqEMK0YSkBLdovN1tpJNNFUPkiCCZAZzbmoIU3aqxtSRmYZBsiV/9jw+zG4ga8+b2m7Z5bEqVnFDYMqH2Jd5d991zBSeiv5z+CI/pCgXUPfDXyrRfHCAzUdNjPK2pyoZXZpdLd5xg4givG70C+Bvs7gjCuQZRiYzcEgBmNkw4ZsKtaZBgHT4a5HnRv6Ta56FIeawumGkBvVW0qX4oXegrbe0rTYaCsBI7TfG6JtezsXxxVJQleFp/RYZpuxx2UwDUBuD9zldZlXh2CHyiMnO8CJDGC5mOJcXTbI064t3aJbdwWB02DBJ0zla2eQiXWIRKrU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(84040400005)(451199015)(1590799012)(38100700002)(186003)(6506007)(26005)(41300700001)(7696005)(9686003)(52536014)(2906002)(4744005)(8936002)(316002)(55016003)(110136005)(71200400001)(4326008)(66556008)(64756008)(478600001)(66476007)(76116006)(66946007)(5660300002)(8676002)(66446008)(1580799009)(38070700005)(86362001)(122000001)(82960400001)(85182001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEYzR1MzR1JVbTBrY0F3dEloOU9mSnpLb1A0SXBSQ3NaaTYvK2xjdHhqSlha?=
 =?utf-8?B?bjdXMUVqR1FrL1o4NEM2Y1RBQkRUMzZqbUJ5RWNrb1QyMndpVDd4ek1NRVFI?=
 =?utf-8?B?OEZ5Unc5a2w3MUlsWnlpMUNGR21nWnNBa2kyTXc0SkFkby9qRllTMWx2MFg3?=
 =?utf-8?B?UXN1dnRWanc3OWs2WEE5YXhXTEpEb09YYlkrd3A2OHRtdSs0Mm16NUxrU1VD?=
 =?utf-8?B?ODBSREo3TDNKNjRZcUI1STNpNlMrdHQxWEdZUDQzcGZrL1RtdjJvWlRiUlZK?=
 =?utf-8?B?VWk2ZFExZFIxdWRQOC9DUHJpS2Z6eUo4eHhmcVBkQ0dYeGZWTGI0QXZuUGFL?=
 =?utf-8?B?Z2RaTENsR1V2MFVQRmphUjUyTTlCTWxRdHorN2Q5RHFmbnA2QmJZMmtYZEdq?=
 =?utf-8?B?dXpWRERtTHdpTVZSQklZQmhXYWg0NE13dWlzWXV3Z3ZHM1F0V0pQL3BzQ1c0?=
 =?utf-8?B?bkZsdnJaQzA5SUN0OWNuSENCS0w5N0ZGYlVkZVF0MlgvTjVXU3VjZEVqODc5?=
 =?utf-8?B?SDVjUTR1N3N2Njl4bVA4K0VmMmlzVWZpVDNiSGVwSDlsTFliakltUlp5WkFp?=
 =?utf-8?B?UDIyVjgwUVdhd3VSSEtSZllZZytnb1dXN1U4d1NBR1Z5dnZCVWFleWFja2dr?=
 =?utf-8?B?bStGZkJpOGlGS3gwNVB2Q3dmMFRnUTZySkFzOVpKZ0RKdmozdVVkY1BnOEFT?=
 =?utf-8?B?VkE4S0JKa09taytOODgzWVNYOThReElJTGVwZ3lYTDdPenZMVU02dm5SaVhW?=
 =?utf-8?B?bVd1cjNPb0hTR0RGSWNYS245NVJ1YWdCaGNKbENVZDJsYllYZ1p2cGpkblM4?=
 =?utf-8?B?V0xUNlVLamxQc2hWZVpSanpyRlZpMkl3dWhlYXBpT2wxZENwdFM2M09YZW8v?=
 =?utf-8?B?WGZYZUF5RWtINXVZM05idXgzaXhTTklSS2V4RmdGTWR0d0w3OStlemUwUGVO?=
 =?utf-8?B?QnpHYTBUYStwbDRYZGdCak9LeUlwRHdzcUpTQVlTMUcyd0VPeThyWkI1NXo0?=
 =?utf-8?B?NHN0R3ZvTHBma0N2a1hHK3ZGaVNuQTI5MmlST3RYU0hZS3ZwTm5UdUJkKzZS?=
 =?utf-8?B?WXlkS01wR29rQ255VGJ6SDM1azJ6ZGdVTWZxbHBPbHRwQnNqUG9GWHRYK25q?=
 =?utf-8?B?eXNIa2FyU2ZYTndySkwyRGgyMHNIcE1HcEJlVFJ6TTM2c0FZaFV4am0wMHdw?=
 =?utf-8?B?WmJsa2h5Ym5MRG1zOThtMXkwZ1RQS2pWN0JPZnhqK3VrdUNaMXVLUXZpaTVh?=
 =?utf-8?B?dzFuS3VsbmRFQXZnUzNBWHFjS25kQkZiWittcjJtT1Q3MzQvc3VJcVNSUlkw?=
 =?utf-8?B?NjRRUkYwbjFLOTVjK3lHL2lucmV2NC9XNTQyOHE3T3p6bVFRckkwQWk4KzZH?=
 =?utf-8?B?WXVvQkdJbi9uYy9yOTlNY1Z5d2tHSUhvUmM3N20xRWJpaGNTT3RLcU5tNjV1?=
 =?utf-8?B?QUFiN08xeDRMSnZiemtMV0dTb2tldFJmRW1TU0oxeWl3eXViaGZBUldXRnN5?=
 =?utf-8?B?dWNmWlpPNnRLVEp6ZjJrTWExK3RyUmJsd2d1YXZuelQzelM1N0hSSFZHTkpv?=
 =?utf-8?B?NGJlbDdCeUx6WU9IUmRQaWRvV2crbkZHdGVGeGlqVlVaQStMZ3hUak0vMyt0?=
 =?utf-8?B?UVkrc0l5V1preWFBVkVFMXFpQlUxazNwWVFJR1Zpbk9DMXhIS1RHdnJQWW85?=
 =?utf-8?B?NXRLNXNpYjNDL1ZMcVN4eWFxd215bVViTnJGc2gwTkhOQzE2L1hOc1ZSZXhu?=
 =?utf-8?B?QUZxMDIxQVM1UlY4VzBNbWh2VGpOSFBRU1dtQVZYQll1UkgybUlxMTdySlhF?=
 =?utf-8?B?MzBOWUJlL1E1WjAvcnpzdDBMeHVKSlN4R0cvaG1jRjI4LzRMSGUxN1dlV0R3?=
 =?utf-8?B?YmRaYlpka3U2MG8yR1g5alZBTitLWkc5Rkd2K3RON2Uya21hRnB0OTNSWDRp?=
 =?utf-8?B?Y1RlTHVxbS9UY3N2NnRlNFVWSll0bXFVWXQ2K1dkbHZNTm55Sit1eTZpcThW?=
 =?utf-8?B?djZKa3oweHM1VzBIZjJGTkg5RFd3NTg4WU4ybFptL0VvRHBtNmE5R0drWFRV?=
 =?utf-8?B?R0ZOb01HUysvWGRRdjQrNGd2bys4akRtYjJWd0Zxc2FERkNVd2k1SlZLM3Np?=
 =?utf-8?B?V1hCbDRMRGdvT2pVL3o3Q3hvV2JkdFU4NUl2VEtHa2tNUEpxK2ZVOW1RMWRB?=
 =?utf-8?B?Ync9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62fba03-222d-4be5-0561-08da9c819e3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 10:02:54.5522 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYkq69V6zyJ5psGUIKZ3L+X1m04FomMeDEjEBwdUiqlkd5gfPYm4IugNpIVkLMTkD9Kh3dy3ISiMhAqyAX81+XJbJAAHXoSMYCifxQgDyaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10517
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/3] syscalls/openat: Add new regression test
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi  Cyril

>> > And this one is probably missing some kernel commit tags too, since the only that that is attached is supposedly in 5.19 but the test still fails.
>>> 
>> > I supposed that we should add the 426b4ca2d6a5 to the test tags here as well, right?
>>>
>> Yes, BTW,  I usually use git tag --contains command, so I know this kernel fix is belong to 6.0.
>> 
>> git tag --contains ac6800e27
>> v6.0-rc1
>> v6.0-rc2

>Now I'm confused, if I do git describe ac6800e27 it says that it's a second commit on the top of 5.19-rc7. So shouldn't the the git tag --contains report 5.19-rc8 and newer? What do I miss?

I don't know about this. It is a detail in kernel community collaborative work .
But kernel subsystem maintainer should be aware of this. @ Christian Brauner  Can you help Cyril settle this confuse ?

Best Regards
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
