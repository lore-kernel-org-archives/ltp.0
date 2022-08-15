Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24545C25B0E
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 06:58:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D025B3C95EE
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 08:58:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CBAE3C1FED
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 08:58:21 +0200 (CEST)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 591D120074D
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 08:58:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660546700; x=1692082700;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=VGjfIG6ZVwSaBFuJlTzRHhUtjUKD++ev4f7+yb7yZCw=;
 b=G0Id1uoEQi8ONlH7AhtI86bhcKpzYc3qhyCiqBZSIbPaYbuSJ8wb+W9k
 SRGaMdZnCqWhiYE6lqYWDJTW3RNgn+/G2+wok/561Enc0PlkXF7ITTzLy
 auFaaLRqjgIf0yyD30q9A4yMOyAzgX2IhXtspQJ1vkHlu8CrGSmrsN026
 Ee2uZ6M6oFsdaMm0AUnyj3QOwyUZj8B8PDjy2UecNNW81FDZMKGPEIwAN
 PvzxTxf/O85UG9WpOg+e7SOaar4leSgpmINxlFSebeQu0Fh5tSCCoXLPF
 4kpDPway5HiV8TtjnuPI9uOq+p2l/yunjGU+xSC7PDtKkiNCpDP4gmgDP Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="62520201"
X-IronPort-AV: E=Sophos;i="5.93,237,1654527600"; d="scan'208";a="62520201"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2022 15:58:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLlRHYC4EbUCPF7D4jwIG4hwUgOuNGG2KvVrFhXJfH4ZMAqMgwY8S0SpjXKP68tU6y8XrJ7LJvI6G7TJwDFFqrm6qyWukI3cukgUM7CUFs8nAYdnJE95vk3Biu6IZpMpstTUwS3CdeCc2MBiKuVW2GPI10nVYbxQSldSyxq95aQF196GYQlhj9dZ1pEmYFmFrMr4fqUummxCclfmm1D0V3CjyHq7itPeSVOKYwu4cMx+vjpTm/AVabxu3svmD9X18jLAzn0gmGSQjH+anA4oslxbBBNAaVVI9WUEd4il1C3yvir2sKrnD9KoiITy7Uu3vl/LC4OPwdCDie6D9iWwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGjfIG6ZVwSaBFuJlTzRHhUtjUKD++ev4f7+yb7yZCw=;
 b=SL2c9IVHAZHAAOKkYgz43ChS6hQ77wL1mdT2+ieDc6mG7vJ22G4eiImwRJjdTuBq3PaymSc5TtnYn0klQu4Hq9cN3Hyiyw96UZcsmteuKsBl3w8zCuFmovtJFl5tRtJ6GEFrpEgrv7rw1lrPEFuk/7foEGUzz4gk1BrT9+Y31MjDyCM15YTKziy2xJsHsCmuME/mrr06WVgkJb095ce2ErSqiFUMUAfGhzVXwULxWLiTB+QjoVJvRY9s4GzqwhB558ARi4L6Gf+oLGifb3M/zFoburw8OUapwqgJy0eT9DUb0OBDtnF5VvhOBhjABrhB9aW65Z9aa0LOOH/vcz0YsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB2489.jpnprd01.prod.outlook.com (2603:1096:404:6f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Mon, 15 Aug
 2022 06:58:15 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 06:58:14 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v3 0/2] mount03: Convert to new API
Thread-Index: AQHYrYpdivkAy4rXlU+UH1tz7IrvUK2vgeuAgAAG24CAABXngA==
Date: Mon, 15 Aug 2022 06:58:14 +0000
Message-ID: <1e791bd1-2661-95b0-1f0b-e3ca82b6524f@fujitsu.com>
References: <20220811135731.2228-1-pvorel@suse.cz>
 <765b4f35-2cd0-04e1-e405-04261b5ef645@fujitsu.com> <YvnqZfyByO42kAX9@pevik>
In-Reply-To: <YvnqZfyByO42kAX9@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65616f26-f630-405e-3385-08da7e8b8688
x-ms-traffictypediagnostic: TY2PR01MB2489:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 62G9pf4ZaHd8yzDJVMAuNmfHPVGWr91V00ji+GtpmnSFuzbnf3/kQnO2GdBiHgvge4wg0gj2FNdeWnkzgz58uNPfhWOo2JKrKfdelEdAvzEOi1fU7FI2ojDEFP85AefkB2VS/oHEdUZfr5I6hNmQUG2Re3vWIMT/M2RTcmtDrZj1KW4OhbxMo6CckDeSSFvHDagMwELgWxY5S/pD785+wnPp8BX0Fm7SR7hAA43xDZe7gk7fr46sVj5r/Xa07FA1vEBIhzxD/w9wEm3HwjcwCZhMvO0v4ZzhW+x6k9GcJvn9hONGES50lT/rfBph5JvwMgQb+BZr23P4+/Vg4TlTMXNqPHkM9Ygja8F8/oWhU2LHW1r8ZJo3VNfnTTU9z6tGQadBNVOT35f0IMj3Y6vFs53TdDTZZg1oZUtdGBNTB1huwet6uWXy6PAE3DJE43JKqAeBAOn0fqWxI1HGQ06iiBNKr41/rBoov8tDagtoDjyrHiRQNHDyhU0dL3idHqYBCHk5xbRAsOdSHdxNUl9/F3a/dEJ+3gTTJ/kF3AioXWjgfNkw5JDv5cWVL79s+7q5lSZHjs9pt07t7aTiSzPZ+0FgJTtvnnBFtXr9/Se03G2mtgM7d75hjDwbko21WjuzbH8r63xaY79tHf3d0gXN2LYI5Bek8Ucf51tm4bVJf80gEMBPaO6SgwbcBPZyEDRJNwNLJorFvXCdlsEgkhyFHer3S97UUHuCVd+6UnV9MxUGDa57ErTjkM5DWvpe2kyf9r5GJQqWk/ajyeL83FkdjlCdPQJNM5MAZHEu0/SBex4SXI0GmNxltOg0ehfxGFkdwJIssV/RE7vpp9JTqCUCBObAxdgK3LBrOXmoxOtX77xULardNBVL9X0so+P+R7Xh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(6916009)(316002)(8936002)(82960400001)(31686004)(2616005)(1580799003)(36756003)(186003)(85182001)(71200400001)(31696002)(86362001)(26005)(6512007)(6486002)(83380400001)(478600001)(6506007)(38100700002)(8676002)(4326008)(2906002)(5660300002)(66556008)(66476007)(91956017)(64756008)(66946007)(66446008)(38070700005)(41300700001)(76116006)(122000001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmNURGw2MU9XNTlleE5ueTQrWm5Qd0krL3ZYQkM3cjFhS2xUZFlGOVM4UENZ?=
 =?utf-8?B?R1JOV0hCSllvc1QvK0tWOTQ4SFBOWXkwYlhMdFJXekh4UnhqcVoxaWZvVzRJ?=
 =?utf-8?B?emowRndLRGlrMkZGcHZDaTNjUTFPaVNJV0o4dXlCMHBTM0hFZ01vV0ZIVFZG?=
 =?utf-8?B?UDl5QkJqNWoyY1FLWi8wSG1MczQ5K1lPNC9TUWF1T0k3YSttaHFzVWRBZEMw?=
 =?utf-8?B?QlVQbUVkUUlzVCtKWTZkRTYzM2RJWE1xeXVzZytQYk4yZGRSUEczaHgvV3dK?=
 =?utf-8?B?aEovL2Q1dkFPcTZVRnJTY1FOTzkzUEsvNGpyM1gxYVdDNE1sQVpRbVN3dURh?=
 =?utf-8?B?c1lUWW5IRkF2OVBBbUMxNmpNc3ljVll4WC96WDJSK2p0ZXlwSU03QTR1blpK?=
 =?utf-8?B?dDk3OHF4QlZ5enJZek5YWjB0SWMwdHM4M1c4U1FyK1pVNW42Y2dGKzF6UGQr?=
 =?utf-8?B?dTIxWHRMbVVoWmtmV2Qrb3locVQrMElUdk0zd01RNmVnck01SUxXRzVyWnY2?=
 =?utf-8?B?dUNnQkttdGdSWWdieUNhSFFKaGtZVW9wWTJTVi9CODdwdTJJZ3RwWXB2d2xi?=
 =?utf-8?B?a09OTW0xRjAvTmJmYzlReWJuVDdtaTZYTTNVK1Y5TXZTQVhwRnJiTnduL3h1?=
 =?utf-8?B?RWhxVHRkeTlYUCtYYjVhUVN0UDdaTEFXSFYxTjgxTC94NnpZM1k0Lzg1bGNk?=
 =?utf-8?B?STZHZk1pVzQ5eTRVKzJ5a29uOFpwVkZjTjlDQndCK1NCSzFadUFKRDlEV1Zp?=
 =?utf-8?B?NkxpaytPSWdaNThjOG52ZG1xc3dVc3ZiRjd5UWFFSzdMVG5STXdXM05iU1N2?=
 =?utf-8?B?Z09sdmcyNEF0UXRaaVRTT1Zjb001VDljTmpxQkNMQTdaa0dvNUdiUG1mU21E?=
 =?utf-8?B?K0hRN2xmaW43S1daRnZsMHd1SjFVSjBUTy9uWjl1WmxuRkJlRThhSFNUdms1?=
 =?utf-8?B?ZHVaci9DYmNCb3kzT0s2bEI5d3ZlSDJSWis0ZWpPVjhJY1lqbTN5T1l3dm0r?=
 =?utf-8?B?YlNZTHFHUmU2Zy9DOEpoNGgzY05HK3dzc3hyamhPUzN5ZkVjMzU3dUtDSlhn?=
 =?utf-8?B?cUdUMEE2Mk9HRjNJTm9FRWZsT21naFdML2k3cW4yZ3NZak9jS0ozdHIxOUV6?=
 =?utf-8?B?RkNQekN1UkREYldVbFl2dEdWVU5ncWVSQWFObTVJN0xCeHdMUkVPREowZERk?=
 =?utf-8?B?SVU2M1lHdkpSckhoVUcwOUoySzk1bzE3OUEraDRWRGVGTmQ2NzZ0V2U1YWxs?=
 =?utf-8?B?MG9UTVB5WitVN1dxN0Y1cldGZWFMZWlzcXJwdE5SSS9HalQvTnlXWERFNUJY?=
 =?utf-8?B?SW52dkppUEpuMzJiczd0MDE0UHFycmZ3MFpiZ0U5d2RlcmtZd1A1ckFYdEhy?=
 =?utf-8?B?YXpma2FDWW1WS1hmNVJFdTNOY2oyS3k5ek5PUW5OOTZGa0M5RnBuL1cvM2hq?=
 =?utf-8?B?T1dJa01ZM0x6Z1JDM0R2Zy9YdmtScWN5UHlrQnZrVkNYZmk4V0p5VHR6eDYz?=
 =?utf-8?B?a0lUTm04Mzl2MVJlNWlMdENZazVPYjdTWWs0WHNwR01qYzhWbjNXYnVOSjFX?=
 =?utf-8?B?TDZMMlYvU2hmbk16WWJVRnZOLzV1NGxDL2dFWnNhYlE1NlNUMWw1a25UUTdl?=
 =?utf-8?B?UWNWOHZiSEdPZmZhTHVoMEM1aDlVSU5KcGl4TFRteGRwK2M3elRpdTNRcjVw?=
 =?utf-8?B?cFZaU0x3b3ArU2c0K2RJcWJ5NnV1Y2xGektIbjI3Sjd0RVdQVlFPazNZSmYz?=
 =?utf-8?B?K3BZQVJQK3FWMWkwZVJiVTBZVFZEMVJyQWE1N2IwWTY0Nm54Zi9OSnRuVXpG?=
 =?utf-8?B?NlR5ZWF2VWhPVnRTdUFJVnJYMml3dS9xeldMVlJFNEhlY1pUU2tuV0E5WlJy?=
 =?utf-8?B?LzNYM0luV0k1Mk1LbC9Ld1g2RVQ1Z21jcUtQUXplaXNiRHlqRlh6emNwU2pz?=
 =?utf-8?B?aHVoV1JlY2lUSXRxSVF5MlBuSEdBVTlyUTZGR3lHZGtMY1NSbHE4YVBqMmNz?=
 =?utf-8?B?RXJDZGxyUVhpV3VhTWtrQTRiRDZvQVdocm9sL2pVYzV3MmpWTWp2czZRWno1?=
 =?utf-8?B?QndOamdPZWlwb1Q4YTBkVTdFcmxBeGtvdWJuZ1psWTlEZWFzZ0xxbDlEcC9M?=
 =?utf-8?B?YmY2TEFHbzBUaXdsS0pibUc2dmZueVAyNXdSRGxncUdIN0c2dCt2eUkxWndC?=
 =?utf-8?B?NlE9PQ==?=
Content-ID: <7D90CC8B69885A46982CA37CF0D546AA@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gjody2k7s6oxIstBGfnDqBharnvE1o6vZbl9jbwmTeU1IcYPV+R2mUi9f8PbcmGtrT4JwyznFBeS3Ahu+hv6WJIByhTRgCmnXnbXuZ0asWVnzi/iIhZjKMAjR99liclblCulA+/aO5/w630uZLmEjft1QPkDYaoQ6xTxFlrh1NeD5ptp8L47OzYhffz/kQTpNRzeiwu2ejAEHPT7Tk/YYKXOMLYJYzPbTmBJDadb6DPWiGh9WtX1QBlIPc+5P7+Zwbtq0VMZtalj4I/5xuV9+zsQBsEa8PRlBKIEDlpiZ/BLJJSPrUG/OBKv0tsPz5H4LnX/A8Do1MEQijSwhjDhqY4guuse8Ncnf0T++dFT94qYA0wQZPSpxxbjXWu7DJ7IzzrHzMcSe2r4aCnSaOuQ4XGoBaL5ZhUySriLgzZIkKHWGPWx6pdM3ff1uBvqGSoCOI4sIDHmA7h6yrPzvBHFyxtUuDkByKpIjM+zkjviyHE0+Q2W9O8RFFAt40MT+YgT/7QBc/8pnCQZ8VHQ3gcS5QfgkcQTDv68wK7xlTH6ZaG3g/Bty2zN17ECWYtVE6oXRdFzPqN8+Ed49EyWDiCMaIkFJ3weHvHfWR0nodChCNn8D3n2/T+gKdQahq6i2WcOYwSyjMBDcD0LxpRBqyhzUGGtKnfTwg2up0B4/OogjMDCHopgf84gHpIHwQbESom6WmChwytmKYQWQnDHnFms8D5zPdnTJ9sAQ6FFXdUNWgzkHiT/6XlkK6SilJrctgwz
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65616f26-f630-405e-3385-08da7e8b8688
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 06:58:14.8348 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNIyo9vwV0LsAiP6mJzmwncDmALRCkPoMMl4dkGdz3CznVm7PvjFMwj3KDL/ZGy+aF0OWqoSl314zRimQbn9h0+3BmIhx7dObCk2rTiEubY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2489
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] mount03: Convert to new API
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

DQpIaSBQZXRyDQoNCj4gSGkgWHUsDQo+IA0KPj4gSGkgUGV0cg0KPiANCj4+PiBIaSwNCj4gDQo+
Pj4gSSB3YW50ZWQgdG8gc3BlZWR1cCBtb3VudDAzIHJld3JpdGUgWzFdLCB0aHVzIEkgZmluaXNo
ZWQgdGhlIHdvcmsuDQo+IA0KPj4+IENoYW5nZXMgaW5jbHVkZToNCj4+PiAqIHNpbXBsaWZ5IGNv
ZGUgYnkgdXNpbmc6DQo+Pj4gICAgIC0gU0FGRSBtYWNyb3MNCj4+PiAgICAgLSBUU1RfRVhQX0ZB
SUwoKSBpbnN0ZWFkIG9mIFRTVF9FWFBfRkFJTDIoKQ0KPj4+ICAgICAtIHJlbW92ZSBpZiAoKSBj
aGVjayBmcm9tIFNBRkUgbWFjcm9zICh0aGF0J3MgdGhlIHBvaW50IG9mIHNhZmUgbWFjcm9zDQo+
Pj4gCXRvIG5vdCBoYXZpbmcgdG8gdXNlIGlmICgpIGNoZWNrDQo+IA0KPj4+ICogZml4IG1vdW50
MDNfc2V0dWlkX3Rlc3QgY2FsbCwgc28gaXQgY2FuIGV4cGVjdCAwIGV4aXQgY29kZQ0KPj4+IEkg
d29uZGVyIG15c2VsZiB3aHkgdGhpcyBmaXhlcyBpdDoNCj4+PiAtCQlTQUZFX1NFVFJFVUlEKG5v
Ym9keV91aWQsIG5vYm9keV9naWQpOw0KPiANCj4+IFdoeSBoZXJlIGlzIG5vYm9keV9naWQ/DQo+
IA0KPj4+ICsJCVNBRkVfU0VUR0lEKG5vYm9keV9naWQpOw0KPj4+ICsJCVNBRkVfU0VUUkVVSUQo
LTEsIG5vYm9keV91aWQpOw0KPiANCj4+IFdoYXQgcHJvYmxlbSBkbyB5b3UgbWVldD8NCj4gDQo+
IFVzaW5nIG9yaWdpbmFsIGNvZGUgU0FGRV9TRVRSRVVJRChub2JvZHlfdWlkLCBub2JvZHlfZ2lk
KTsNCj4gY2F1c2VzIG1vdW50MDNfc2V0dWlkX3Rlc3QgdG8gZmFpbCAoZXhpdCAxKS4NCj4gVGhl
IHNhbWUgY29kZSBpcyBpbiBjcmVhdDA4LmMsIGNyZWF0MDkuYywgb3BlbjEwLmMuDQo+IERpZCBJ
IGFuc3dlciB5b3VyIHF1ZXN0aW9uPw0KDQpZZXMuDQo+IA0KPj4+ICogYWRkIG1pc3NpbmcgVFNU
X1JFU09VUkNFX0NPUFkoKQ0KPj4+IEBDeXJpbDogaXMgaXQgcmVhbGx5IG5lZWRlZD8NCj4gDQo+
PiBJTU8sIGlmIHdlIHVzZSByZXNvdXJjZWluIHRlc3Qgc3RydWN0LCB3ZSBkb24ndCBuZWVkIGl0
IGJlY2F1c2UgbHRwIGxpYg0KPj4gaGFzIG1vdmUgaXQgdG8gdG1wZGlyLCB3ZSAgY2FuIGp1c3Qg
dXNlIFNBRkVfQ09QWSBpZSBwcmN0bDA2LmMuDQo+IA0KPiBBaCwgdGhhbmtzIQ0KPiBTQUZFX0NQ
KFRFU1RCSU4sIGZpbGUpOw0KPiANCj4gLi4uDQo+Pj4gKyNkZWZpbmUgRkxBR19ERVNDKHgpIC5m
bGFnID0geCwgLmRlc2MgPSAjeA0KPj4+ICtzdGF0aWMgc3RydWN0IHRjYXNlIHsNCj4+PiArCXVu
c2lnbmVkIGludCBmbGFnOw0KPj4+ICsJY2hhciAqZGVzYzsNCj4+PiArCXZvaWQgKCp0ZXN0KSh2
b2lkKTsNCj4+PiArfSB0Y2FzZXNbXSA9IHsNCj4+PiArCXtGTEFHX0RFU0MoTVNfUkRPTkxZKSwg
dGVzdF9yZG9ubHl9LA0KPj4+ICsJe0ZMQUdfREVTQyhNU19OT0RFViksIHRlc3Rfbm9kZXZ9LA0K
Pj4+ICsJe0ZMQUdfREVTQyhNU19OT0VYRUMpLCB0ZXN0X25vZXhlY30sDQo+Pj4gKwl7RkxBR19E
RVNDKE1TX1NZTkNIUk9OT1VTKSwgdGVzdF9zeW5jaHJvbm91c30sDQo+Pj4gKwl7RkxBR19ERVND
KE1TX1JET05MWSksIHRlc3RfcmVtb3VudH0sDQo+Pj4gKwl7RkxBR19ERVNDKE1TX05PU1VJRCks
IHRlc3Rfbm9zdWlkfSwNCj4+PiArCXtGTEFHX0RFU0MoTVNfTk9BVElNRSksIHRlc3Rfbm9hdGlt
ZX0sDQo+Pj4gK307DQo+IA0KPj4+IC0Jc2xlZXAoMSk7DQo+Pj4gK3N0YXRpYyB2b2lkIHNldHVw
KHZvaWQpDQo+Pj4gK3sNCj4+PiArCXN0cnVjdCBzdGF0IHN0Ow0KPj4+ICsJc3RydWN0IHBhc3N3
ZCAqbHRwdXNlciA9IFNBRkVfR0VUUFdOQU0oIm5vYm9keSIpOw0KPiANCj4+PiAtCVNBRkVfUkVB
RCgwLCBvdGZkLCByZWFkYnVmLCBzaXplb2YocmVhZGJ1ZikpOw0KPj4+ICsJbm9ib2R5X3VpZCA9
IGx0cHVzZXItPnB3X3VpZDsNCj4+PiArCW5vYm9keV9naWQgPSBsdHB1c2VyLT5wd19naWQ7DQo+
IA0KPj4+IC0JU0FGRV9GU1RBVChvdGZkLCAmZmlsZV9zdGF0KTsNCj4+PiArCXNucHJpbnRmKGZp
bGUsIFBBVEhfTUFYLCAiJXMvJXMiLCBNTlRQT0lOVCwgVEVTVEJJTik7DQo+Pj4gKwlUU1RfUkVT
T1VSQ0VfQ09QWShOVUxMLCBURVNUQklOLCBmaWxlKTsNCj4gDQo+PiBJbiBmYWN0LCBvbGQgdGVz
dCBjYXNlIGNvcHkgcmVzb3VyY2UgZmlsZSB3aGVuIG1vdW50IGZpbGV5c3RlbSwgYnV0IG5vdywN
Cj4+IHlvdSBjaGFuZ2UgdGhpcy4gIFNvIGluIHRlc3Rfbm9zdWlkIGZ1bmN0aW9uLCB5b3UgdGVz
dCBub3N1aWQgYmVoYXZpb3VyDQo+PiBpbiB0bXBkaXIgaW5zdGVhZCBvZiBkaWZmZXJlbnQgZmls
ZXN5c3RlbXMuDQo+IA0KPiBvbGQgY29kZSBpbiBzZXR1cDoNCj4gICAgICBmc190eXBlID0gdHN0
X2Rldl9mc190eXBlKCk7DQo+ICAgICAgZGV2aWNlID0gdHN0X2FjcXVpcmVfZGV2aWNlKGNsZWFu
dXApOw0KPiANCj4gICAgICBpZiAoIWRldmljZSkNCj4gICAgICAgICAgdHN0X2Jya20oVENPTkYs
IGNsZWFudXAsICJGYWlsZWQgdG8gb2J0YWluIGJsb2NrIGRldmljZSIpOw0KPiANCj4gICAgICB0
c3RfbWtmcyhjbGVhbnVwLCBkZXZpY2UsIGZzX3R5cGUsIE5VTEwsIE5VTEwpOw0KPiANCj4gICAg
ICBTQUZFX01LRElSKGNsZWFudXAsIG1udHBvaW50LCBESVJfTU9ERSk7DQo+IA0KPiAgICAgIFNB
RkVfTU9VTlQoY2xlYW51cCwgZGV2aWNlLCBtbnRwb2ludCwgZnNfdHlwZSwgMCwgTlVMTCk7DQo+
ICAgICAgVFNUX1JFU09VUkNFX0NPUFkoY2xlYW51cCwgIm1vdW50MDNfc2V0dWlkX3Rlc3QiLCBw
YXRoX25hbWUpOw0KPiANCj4gbmV3IGNvZGU6DQo+ICAgICAgc25wcmludGYoZmlsZSwgUEFUSF9N
QVgsICIlcy8lcyIsIE1OVFBPSU5ULCBURVNUQklOKTsNCj4gICAgICBTQUZFX0NQKFRFU1RCSU4s
IGZpbGUpOw0KPiANCj4gV2VsbCwgTGkgaW4gaGlzIHYyIHJlbW92ZWQgdGhlIGNvZGUgYmVjYXVz
ZSB0aGVyZSBpcyAubW50cG9pbnQgPSBNTlRQT0lOVCwgaW4NCj4gc3RydWN0IHRzdF90ZXN0LCB0
aGVyZWZvcmUgTU5UUE9JTlQgaXMgbW91bnRlZCBpbiB0aGUgZmlsZXN5c3RlbSwgcmlnaHQ/DQo+
IA0KPiBCdXQgaGUgYWxzbyBkaWQgU0FGRV9TVEFUIGFuZCBTQUZFX0NITU9EIG9uIE1OVFBPSU5U
LCB3aGljaCBpcyBJTUhPIHdyb25nDQo+IChvciBhdCBsZWFzdCBkaWZmZXJlbnQgZnJvbSB0aGUg
b2xkIGNvZGUpLg0KDQpZZXMsIGl0IGlzIHdyb25nLiBJIGd1ZXNzIENoZW4gbWlzdW5kZXJ0YW5k
IG1udHBvaW50IHVzYWdlKGl0IGp1c3QgDQpjcmVhdGUgbW50cG9pbnQgaW5zdGVhZCBtb3VudCBk
ZXYgdG8gYSBtb3V0cG9pbnQpLg0KDQpTbyBkbyB5b3Ugd2lsbCBmaXggdGhpc++8nw0KDQpCZXN0
IFJlZ2FyZHMNCllhbmcgWHUNCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gUGV0cg0KPiANCj4+IEJl
c3QgUmVnYXJkcw0KPj4gWWFuZyBYdQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
