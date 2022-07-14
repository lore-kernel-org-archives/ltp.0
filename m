Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9ADC433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 06:01:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F53C3CA718
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 08:01:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 503053CA718
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 08:00:56 +0200 (CEST)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 21C86200C2F
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 08:00:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1657778455; x=1689314455;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=K+NYwkv/92g3IE3xceX9KFW19UWdrOn+SXHH7RMg3YM=;
 b=LAmJyQ35FNNsBSUo63P0MYDtrzPaTNGyitfyuwAD+NA36pnrIVu2DsGu
 VKjukPf/GM8mRsoUjZvMjWc6k5Hs6iyo34vtIph74y/tMYziyphLs+bwI
 xj6zHIwVk5meyT8BbK1OQQmC2Rp6PzZ+PAsJOidOROxzTnGs4vZNptsKd
 R4L4CgSCXXVIbB2St3H2RtbrAnLx+orrtgXZN9lEeX2gu/Taipsf5zwue
 xdflR9kBZFS3uIQcRHRi8ihEJ4uyxQhrui4j3P01RizT876tXlYudcUwy
 j79Rehrz2jcKx7DZoKOv1bas/uGktaOtjTheTRFFTl5IfyRTep4rthsMq g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="60511871"
X-IronPort-AV: E=Sophos;i="5.92,269,1650898800"; d="scan'208";a="60511871"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2022 15:00:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+vdpNiWtCWWN04O3hc7mIKAaSVkLktpePYpgBh5t04szrTZJxLQIYpkj+oC5hjdGOFMAxr50k6tgba/gGUyLKFwXNfJ+hoSU097qg9xkpQq0MGOnwB/7CBEWzchyeRUrFwuVRl8RSfUMqKhZ+1TGpOszU2morgFsn7EGrmuCkgmH31Uf5H+Ujgn9ISyzeMv1Zylps/hq0q3k2vxJ43mn4+ygIGBKF+OkeU5vI3WywRCqaxRRCG/MzbChXHx2ZlxAHMuj/FT0+AxfLk9LGBkObP5htFAFJDTy0QO7jg9cey7KJHUy7xJl4zQkM6E16kDW11mAUiZQFysTLImK8x/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+NYwkv/92g3IE3xceX9KFW19UWdrOn+SXHH7RMg3YM=;
 b=K7vvpLS2EcF4rkKFU8BWhu2mSI8oLZ13S8F1uItbS22NPQO+P1tUNQLnk4mMUzwkyhuuz97LezkwT0jD7Et2mdk16ItnluQHjfauLx2tcjL31saajEKC9ocbAyYwZKt0658zohvM40zBJGbW37M5twRbAUgsmKFT0DNzD/N0Xr5tAxhkmPhMiLEhckf5uqMX6acxfestJnGzS+Rrd5EabAyYyiR7M8y9QBjygusddC/RfqHy38X9ZneAGstxZdWfFFLxUa6QYgQAXDuAp/YhBvVgLSa8ugFBBUHZixfiyv/UKXRxNiz1al5fnrkPyUbENSxHw6aumkoV92mzAB8F4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+NYwkv/92g3IE3xceX9KFW19UWdrOn+SXHH7RMg3YM=;
 b=GZD3mse4gmombVk16HSTSD8ilMR0GmVNyejUw2yfYjAeuxsIqeKYYv/FAAs1vDrwxq9vnVt/IvWpR5niN0a+zX/D2WmUl5JEaOPwnsZ1lGfpVkVIFc/O3w/AdCsxCdkZqXw+fHmXZG2AR0/UxUbLf2Q8hCv0EDiMhj6yIhc0WTQ=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB4491.jpnprd01.prod.outlook.com (2603:1096:404:113::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 14 Jul
 2022 06:00:49 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160%5]) with mapi id 15.20.5417.027; Thu, 14 Jul 2022
 06:00:49 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Richard Palethorpe <rpalethorpe@suse.de>, Li Wang <liwang@redhat.com>
Thread-Topic: Do we have some simple way to get the current cgroup.procs path?
Thread-Index: AdiXT1u4fxhXw+J5TcO+wfpeq4Xq6Q==
Date: Thu, 14 Jul 2022 06:00:49 +0000
Message-ID: <TY2PR01MB442719179C60B4DB6D275B5CFD889@TY2PR01MB4427.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ZDFkYWZiZDYtNWRiYS00Y2E1LTgzOWUtMGRjYTdjZWQ3?=
 =?utf-8?B?ZmEwO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0wNy0xNFQwNjo1OTozNlo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e557d73b-3fa3-47f8-cabf-08da655e33c5
x-ms-traffictypediagnostic: TY2PR01MB4491:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qyYkkjNOVLAMWpCGr/A9UFmCHl5b91GShno2PTqRoITuMn2TKpyOrUa23nUo9RqhcBz9BpyJgiKld3DQ71EoOkmtXiSvO11U48KDmyqXcDLDrOjFkdQfZ6yNkxrPad5zoWW8x06ehg4eiiBOdfMA9Ds2DUDdnHBOQ96amVwes8wOmk9xL6Q/yzi16rwtoe+3sGAdxChj4hks0B2ybH6+g44ymFtzHE2pFDFy5APGLNF6HHIvqcuw5F+Nvxi6ZxpXVaO9Y0SGJ5tGJIZ6L0m5HzCPACM66Jk8ZxkKGhzIRmwTESUzGeOmvkyQPAMPMojgQyIN0rAYmNy6yI2tlbWAikVXiSY1fHdDn/geNMhP4PaXzyY1F+H5tZhHNd1lM+MiZWyQ9KMuh61o4wmUQKDJbWJh3WSpadKb7+ajd8IM/p8gfhWj8GYkEY/OAr2Ca5N+cH9ateXeSdiJXs/z+WPE9XL1R91T8yloB8LDn0D2nQXyQ3/JwtMYOPES/eC+VlQPp3dyzXxatXI/cGtZgP1F4ABtchah8WtfF37117WcVgGaBD6mvnGLTZ5DuWppqIa14r4Cn7dTIRIbQ6T+xrnDAhhqV9bS6ALNVj0c/4CrhFAH2Sn5dK5kSEwygE0BKiX61xrku0yWLC+2gGb9F2EC1N+efCmm6vq9FnElq/RUBBIYKvIiftB67k5x/sJngnhZ/zR7ajq529DhSANGEyJyBpaE6UrIxF/61tzCIoUNy4dd87OWdgLhpDaJZAvHL5E6n/iOiGI6qUEtNokVOGTDqFwQ/BCMqXNACDJSKKUwE8/G+zmyQpQ6YLXS2pN5Pj3dV6imUc4jFv58Tg1UAnrgI1d36zGJzsBPhuCt00xT3LSeoo4+xnBO6nc+cB3k+U4/3mqeUHmghUp239b+F/ECx88nHxoRRy9j8U9RLFnzhesriKfrAOSoC8YAzzQrbQZD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(5660300002)(86362001)(33656002)(8936002)(4326008)(478600001)(52536014)(2906002)(9686003)(26005)(6506007)(64756008)(7696005)(41300700001)(122000001)(38100700002)(76116006)(82960400001)(186003)(66476007)(71200400001)(55016003)(38070700005)(66556008)(66446008)(8676002)(66946007)(110136005)(316002)(85182001)(43043002)(15583001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2xQOGx1aExoODBNbXBKMUhWRTh6VFlVekRYdkZCbDFXQlBCUFpCaG1oZXdm?=
 =?utf-8?B?RHdUVldxTUt1SjNlaC92YSszNkFzODUvb25OU2RJS0pzcDhMVjladzl5THpF?=
 =?utf-8?B?YVBsU1ZrbGY3NGRad05NVmR6cUdnM2lmUU56cVgyblhNcnhhQ01jTkNnU3ZB?=
 =?utf-8?B?bnNka0VpOEt4dE1IWGhpbDdxQ1JGSUhNc1FhWlA0bmxvanFaL1FMUHVEQ1kr?=
 =?utf-8?B?Zm5lMlIyV0YyNzVCdS9rTEk0UjdmQ1R6TW9DOWtuZGJpM3hlSlhJQ1VYcW1n?=
 =?utf-8?B?dlpKbFFZMmVJSHRzZFZQKzdvWVhSQ0M0d3QvRGhWQ2lzcUxpVXd2WmhWbHUz?=
 =?utf-8?B?TXRVL0wzTWFiUmRwZlRrNFozeVFQOE96QVU3SEVpZW1UQTVWUzV4d2R5T3hQ?=
 =?utf-8?B?QnR5S2d0Ymxyd0ZrMXJ5MjBiUHI1aXNjcyt4TzZyNGlKKzYwV1ZYa0Y4cEpP?=
 =?utf-8?B?ejdNTWhnbTVCOWdzRDBNRU55dHVNUTlNR1BsMEZ0QkFiaVd2cGQvcE5sZW81?=
 =?utf-8?B?Q01OalFwWHJ3R2hTQmZUcUFPTFJ6eDU5SUE2VkcwQUNxY1ZxUnVObm1rMlEy?=
 =?utf-8?B?WmFFbVh1U2dQdWkyMDN6aFhZaE5WWE1ES21ySWZzNi9lK21sSWpwUkJOODBN?=
 =?utf-8?B?SXFydTZrOE5CREJVb3lvY3c3cnROYzczUjF4WXVjMk14dzdxVVRPaWtydi9a?=
 =?utf-8?B?dWtCYXo1aUQ2bkwxLzBBQllRa251LzBNZTArWnRBK1F3VzVHNGx2MUU4aFp1?=
 =?utf-8?B?blRoWFFNMzFvZWltYTRnd2w2a0dkTDZiQm5VbkRuZVpOV3lMZHlmUExyOHdx?=
 =?utf-8?B?bmhBeW5hSDh2Q1RCQXRXK2g2c3VZWE5oZ1JSaDRIeko2VXFCZExQUnVmYzdl?=
 =?utf-8?B?Y2NSVXVvbWdEVEI0QzBMektCSWFod1NZeE8yOXRVY0VYTjJHWXJCTjM2c1ly?=
 =?utf-8?B?MWpDaUkyaWZGOVVzZUhJeWF2d211TkppS1pNSGlTeXVaRnFDNkgydU9oMXpu?=
 =?utf-8?B?OC91Q1NPZG94czhSQW1pZHNSakp2cnpwSGRkODMvMHpEK2RLV0lTb3NuNjND?=
 =?utf-8?B?MXNxSWVtQkNtWVFoMm5iaDk5RmFjeE9QejZMbjRxdUh1MkVmMElnMEVIdFB4?=
 =?utf-8?B?dFBSb1R0T053U0ZWdDJWZUFDMzMzMmloMDVlbWdCVURTaTU4c0NVbnZPQ2Jt?=
 =?utf-8?B?NXU5cmRUaWcybDFoQWFkelhBVWZaMU12d2d2ck53NzNYb2tsbklmbitEcksw?=
 =?utf-8?B?bHlRMjhrR0ZSd29aT0p5SWRTSVBkRGhFNWRvOURQckVKV25YU1BzdlhjdEhS?=
 =?utf-8?B?OXc1UzhRMnZ1NGUraE9UN3ZlT1IyYkh5RUg2T1E3Uk1nY0RPbHg0LzZoSzJU?=
 =?utf-8?B?M1ZDWStlNURCOVJMY3ZEUFRHUWY2aHNQZkw0Qm10eC9LWFRmUk5FR3J2Zktn?=
 =?utf-8?B?VjhSRDdxdHlvdzdXSnpWL0Z6MWdlbldYZnVTRElPZ05WUGUwdDBlWkJsQnU3?=
 =?utf-8?B?ZW5GMEZJVkFUZ1FVUE1YYnRIdU9kMHdaK0RxeWRsU3l5RVhqSWxMZjh4UGJi?=
 =?utf-8?B?ZHQybDR1alZySDU4bmxwSGttZDJqWm83NmJGUUNSNzdMaU5rREVFaks5dVNn?=
 =?utf-8?B?cFJJMXN2VGNiRk4xbEc5bU1lZzRaZ0ZKQmh4bCtyREVuQW5jU0Jpa3ozRW4y?=
 =?utf-8?B?aFQ2ZEJDcSsrUTFMV3dWK3QxS2lPb0lJV2g2c21vaGhUdTFaRVVlNHNRY3ky?=
 =?utf-8?B?cENIRTFINlpaNk51ajg1dEE0L0JHbUwrNDkrZTVrb1FUV21iL0kxTWRyTzE5?=
 =?utf-8?B?dnJ3SDJHaDBmTXFjckNrVkt1aTRoSjNBUUM3bVQ3OFV2c1pUcTl6dkhlUVlY?=
 =?utf-8?B?TWZjZjA2NWNyazVPcnVVcVFPRFhvajBWWDQybGFFTHQ3MkZ4UlR6RUlqVXY4?=
 =?utf-8?B?bHFCVk9iOU1RcXJMZHhUeWFCVlRMK1NpOHppN3RSRzA4cjFMRExMTlZ6UW1v?=
 =?utf-8?B?VGxrMDlOSEc2RmZyYUphK2dleDYzNzZpNmVyLzkvb3VQcjZBQTArbytmQm5j?=
 =?utf-8?B?SzZ0SzQ3S0dkS0xDZWc0WEJOczZ5dlY1OEU3bldhWTB6WW9RMVM1RmZiczBj?=
 =?utf-8?B?VzBmdERPc0ZsQzlRT0NiaFVGeFpLQnF4Q09jSGpNeVJlWHphZ2JNNDc0elRx?=
 =?utf-8?B?S0E9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e557d73b-3fa3-47f8-cabf-08da655e33c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 06:00:49.5809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNpCgdBC6BwApLAtyihqw27VlqC1euBgJdouk8TNmYZ4RZrSkxoQtFJdTpxakLMoQPXurmHlpMXRsfdpG0khGG7b7HozcoL1yjU9aSHO79Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4491
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Do we have some simple way to get the current cgroup.procs
 path?
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richard, LI

I am writting a simple regression test[1]that refer to kernel selftest cgroup test_core[2]. I may name it as memcontrol05.c.

It tests cgroup migration permission check should be performed based on the credentials at the time of open instead of write.

I have used ltp cgroup framework, but ltp cgroup only use SAFE_CGROUP_PRINTF to write value.

How can get the cgroup root_dir ltp_dir path? So I can open this fd
and change/save effective uid between open and write?

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1756d7994a
[2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/cgroup/test_core.c#n684

ps: my draft code as below:
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <pwd.h>

#include "tst_test.h"

static struct tst_cg_group *cg_child;
static uid_t nobody_uid, save_uid;

static void test_lesser_euid_open(void)
{
        cg_child = tst_cg_group_mk(tst_cg, "child");
        SAFE_CG_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
        if (!SAFE_FORK()) {
                seteuid(nobody_uid);
                SAFE_CG_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
                seteuid(save_uid);
                exit(0);
        }

        tst_reap_children();
        SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
        cg_child = tst_cg_group_rm(cg_child);
}

static void setup(void)
{
        struct passwd *pw;

        pw = SAFE_GETPWNAM("nobody");
        nobody_uid = pw->pw_uid;
        save_uid = geteuid();
}

static void cleanup(void)
{
         if (cg_child) {
                SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
                cg_child = tst_cg_group_rm(cg_child);
        }
}

static struct tst_test test = {
        .setup = setup,
        .cleanup = cleanup,
        .test_all = test_lesser_euid_open,
        .forks_child = 1,
        .needs_root = 1,
        .needs_cgroup_ctrls = (const char *const[]){ "memory", NULL },
};

I have think about it yesterday and read ltp cgroup framework code, but don't have good idea.

Best Regards
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
