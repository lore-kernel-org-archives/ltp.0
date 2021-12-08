Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A83C433EF
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 08:38:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7E763C6BE4
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 09:38:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34CDC3C21F9
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 09:38:34 +0100 (CET)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D6A7420035C
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 09:38:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1638952712; x=1670488712;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=s9mz4zoTyKKqtzRDBEQ2Mk8RF0pzVF6OTOG4r1yL9JQ=;
 b=bfvDKoFQNWoU3W9+YRiENRSJroWGidgwfcQIcp38lo7ipe3B8YJw2mEL
 GpiwzOSd2fm13BDFbUvm26FKJR8ma0TsgCTou0FAFmF78Cr5UeS5CvJUO
 jSaAoO77ucHvxWhaixaJnrLJ3ZEbu8g54o6kWNGcW4IIkFtVarlT2B0io
 67WYlCJO/yaMsMUdtLrRz1eydd9u7iMfEUu0w5z7cSe2XRwfejqAyRv9T
 cWB9iLWdtj4VCiVUnguORUVrAv38ZCYJb1HuGXqnR2SVkH7hMFCKB4QbR
 HJDUeexzDQOjTNaU/QQPCoZ13GfXa/UuHgDxM1X5O10eqFiLoAywsm/O/ Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="53519586"
X-IronPort-AV: E=Sophos;i="5.87,297,1631545200"; d="scan'208";a="53519586"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2021 17:38:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m45c50Whj9JJ6J1cl23wNGrgGDT6p/ZPbx2XmNABN9Q5oqLwR+kClTcUzmRs5cGnvKe8i8er8Gw3Ayuf01Fo1HaB9GS07NHhkIQzPyyJyXxlaG5REovtM7YZV1NRcoqKwo2axZNVSUYhrkFI+A6ca9WKWMRAZf77L4w6I2zQfUoOgarqGMESY1iSsz+HNLr0LJUqXwrtT1cFTh+O3e2dvmoL3CoVgEE3mZ5kp9ibHVxS3++HzXp4zaqsCFfBElNBI375FCVX1rtU1ljQPTElT+57RiV7VsZQTzbBfnQFvm4J+iHv1Ie8JtkUCVENMoBYIVIAPy4BsJCwATZP9SQgYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9mz4zoTyKKqtzRDBEQ2Mk8RF0pzVF6OTOG4r1yL9JQ=;
 b=iBy7vkN23d0vcZnoIQOLv4cPINg49bAw6EQPj2T3AdPqXCCCGdOvsqLxTWVtqySdG64UV0IGpJ7qgf+vjrJcV1IVl909IKAmiPHUEARZe43jujI/yYSr4rhnXIWeHhGefA6DjDT77Vfo8xiPn+AEkFQklNJ3EVFUFB4R6bbc8nIZwQeqalOV6WiqFBLZHiZHk7ejSA1CQ0gp8XbsU6Sf47ecZLwSJd8OrhANxpk6Zz5pph75j2+Fb6ziWI4mjyVh9gWssoMFa7K6UEuvP0ICumXJOb5xyf37onmAetcNA6tLvkyFlA4WwzGPOFneMjpsZyuEo7X2/6BP4lDudumWtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9mz4zoTyKKqtzRDBEQ2Mk8RF0pzVF6OTOG4r1yL9JQ=;
 b=OxcDD3Qh74o7MLrewWU8nCL3VMc3XAI5YVu986lbI5vIp3uQZD4xlPrWNL+Za6rhd8Vo1CARymK+baHPW7D/1zTZwCQNtad2ytcWaZkuqPyNvhWupGmu3kxnB4DiabByd5Xdo7Jv3vi501AmhIuQA/tFOMcUNoKYZnxu6Z6jvk0=
Received: from OS3PR01MB6134.jpnprd01.prod.outlook.com (2603:1096:604:d0::7)
 by OSAPR01MB3794.jpnprd01.prod.outlook.com (2603:1096:604:5c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Wed, 8 Dec
 2021 08:38:27 +0000
Received: from OS3PR01MB6134.jpnprd01.prod.outlook.com
 ([fe80::bd1f:db6e:8a4c:8c09]) by OS3PR01MB6134.jpnprd01.prod.outlook.com
 ([fe80::bd1f:db6e:8a4c:8c09%3]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 08:38:27 +0000
From: "daisl.fnst@fujitsu.com" <daisl.fnst@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls/write06: Add new test
Thread-Index: AQHX6nmjaZCk6VYl0U+hS+4wh84FnqwnDgSAgAE6+AA=
Date: Wed, 8 Dec 2021 08:38:27 +0000
Message-ID: <338aba97-dd1d-9a9e-e6a0-dcd60cf8ebc9@fujitsu.com>
References: <1638825434-10768-1-git-send-email-daisl.fnst@fujitsu.com>
 <Ya9my0FdHXLqvkJr@yuki>
In-Reply-To: <Ya9my0FdHXLqvkJr@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a9b4112-fe73-4544-7e6c-08d9ba261b28
x-ms-traffictypediagnostic: OSAPR01MB3794:EE_
x-microsoft-antispam-prvs: <OSAPR01MB3794C85BA74C74F23686B0FF856F9@OSAPR01MB3794.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gOUAtGJK3nTxX+J804RfV9klfbBmuH5oWay2cGXsTUdp58dQUFfERHGcenvbT3LWymHRufoy+ZURJuXGCKWnAZbPdMcXesHdkjtEnj5UFlZGIJasoNLl/hxeptINqOaB/7uWsE64giyQwndW2nyhtfvJGuGyBS2xTeNf/eJERpNbaTxjjvvNDo84Bf37oYLkAvM9fYtBrueYZtyNZ9+tojI95JBi6UV+kGOgS62o7q25JQ0YBpNdveg7oUJ2OavsA6wALFezDRYL8wb0HmEDnE9l7ORiXXJACL/nql9l7hhQPyp8ry419j1+k3GAIk27Ojmxef7P4pNQQLGD/UD1VHPuWC4BPxNFOAdYtfxD5/745s+1MADHxeMyE5jnHmkU/oswcT3CyFrq47vFmpGc1wVf4Fgp4KqSbQ3CO1Twl8UnrqF7Zm4DS5F9dt4g1D1q1xusIF5iuSzleE2EMZuB3zGcrgOwKF4m/eOb58iQQGFBoxZA5YDJPAldxoSt8ClWNQ51IgbHB5o996QDON+gx4hrP3TqzSrkfRxrIJImXE3565+mZFwTmvggJHG0sakLySiqaX9ZWCnS4tm0ocDeqK4PNyT2l8vWuA44Bw7QM0AI/JvFMaJDbK4BSfnuISPzIr7xNmqiRyYbcSHPN6Ow9Sk3V+KEImSJ2chNUhIggVMXqrVX7IXr62UMHLhKiXAhKTZCg7H8/IVTWvSd0x9KEoEI72kqhZDh1BkmOP544PMmiC6gPzq2p3AUU1xG7mTFmf0U55ifyRdeKsWOrj2Z5dfaADEAp23rrlBNBihUUVpnPnc8B11baI1UCfTnMv6PrqwSu68Myw1MAY3VVPVqh/23ofhqjPcV0O8WWjz+2as=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6134.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(83380400001)(186003)(6506007)(36756003)(26005)(91956017)(4326008)(38100700002)(66476007)(66446008)(6486002)(64756008)(82960400001)(8936002)(5660300002)(66556008)(76116006)(71200400001)(966005)(66946007)(508600001)(6512007)(8676002)(2616005)(38070700005)(6916009)(85182001)(86362001)(31696002)(316002)(122000001)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnhZRVFFU01iSjBXSUVxQVdjVjBETXd4VE9hSWVVVkZqTW9yRXJHRWZ1cmth?=
 =?utf-8?B?NzkzVFJySkxwSjBTQ1U2UXV3VGNZcDJUcEx5UjkxbEV1YXdNNzBHVXQwZjJh?=
 =?utf-8?B?RktiSzU0RjFWdGRtbW43RTIvL0NHbzlHdHJSYnk1a3V4ODFDY2lRNDcwbE9T?=
 =?utf-8?B?OEhuMUJiNTcrZDJnY3BFb2VPVHBrN29TakZlT2JtME5LOFRJME81SUpwN2py?=
 =?utf-8?B?WGRhUWZUN083OHpqNVIvMUFBcXhxZUI3d2xkTG1vYXpIMUthc3BhWnhkd282?=
 =?utf-8?B?aENVaElEK0JGZ1ZzK0s0U2h0V3ZCWFNaWi9BN1V1T2thbFZVSzM3M2c4OHE2?=
 =?utf-8?B?K1pkVW45UlBBaXUySnY2azRVbUY1cEtaZnM2d2JJZ0JpSVYySEYvRkgyc2Fn?=
 =?utf-8?B?T0l5ZVRHWUtxM2RLYUluL0lOYnVYWHdaM0tZb0dhRXI4RW94TUprUVpZa1lJ?=
 =?utf-8?B?NUJMVkk4OHlOYmN5d1FDNi9xK2YzUU9IUldoaGJsYTR2Zjh5S05RMDlEbWVD?=
 =?utf-8?B?L3NsRVRlTEg5L2J4Q2cxT3RzdENWMTZiN3ZEUlJmWG91NzlZYnFtdmFxamZy?=
 =?utf-8?B?bGVIQlVZZEx0anYzMmJkV2dxbkZJZk1IMmNTMkVMcE9OLzlQT3JBRFZtYTNE?=
 =?utf-8?B?bDJSVHlUTE0rMjZVcFA4V0ZBWVQ2Tm40ekIrZ0EzemxwN2IxM1RnUGYyUlln?=
 =?utf-8?B?ZXpCVlZBeXdqR3FGRlE3VHZsUnJKWWFST3BVSnBJT0FPdllCcmpOZDAweThG?=
 =?utf-8?B?N21TSUhNRW5BMzhkRFNkYjJIUkRqYnphN0l2QjhjV1ZWaTBNSE9sMGd2cTY1?=
 =?utf-8?B?VFlKZWwrSU91RjhHMHQ5Z1VqU041cVhHUVJObzBwMFY0Qll0bFFRbEFTRHZU?=
 =?utf-8?B?OTd3bzRjY2ZZL2Z2Y0FsaWpISzNoaFVtYzJoU1hvQWxKNm8yM1dzWUsxRXlG?=
 =?utf-8?B?d1dMRW0ydG1ZdlJvWGM3SVZrbHJDN1l3OEc1WVEyNzJ1dlRxZGRHVXQ3cjNW?=
 =?utf-8?B?K0JzSEJoVzlxVmE1QzY2RExYTjJZOU9rQ0VjTVNIZG1FdmRZRXkxQWptWndZ?=
 =?utf-8?B?QlZZYUdqN3JPaWhCMmFnTWZCdXBZcndkYXpMOUFod3QrUjNEL3NyQXN4bzFJ?=
 =?utf-8?B?OEhxMUJZTWhFN0JRZGloejIrYUpJeXN6K09yM3F4eEl2Qmx1d2N1MStONmZ1?=
 =?utf-8?B?cHBxZDNoQ1ZPMVFwcVhxKy85YTJsUGtzRjZvbUxHekZZWjcxWGtQQ1VPanla?=
 =?utf-8?B?MUd2d3dtbmxDRGZ0dW9YQ2ZzZzNpOUU3MGRHUHVxRVJnUUVFTEFxVE8yTFZD?=
 =?utf-8?B?Rm8xMmN3UXJOM0RUY04zejMyQzNWNUpIRngyZ2I2S1c1cFE0SHl6ZXlKYkc2?=
 =?utf-8?B?bEJUQytvNHlKOWFzUzhKLzN2VjFMcEJXVENEZ3BMWTJVNHgxT05wVWxRVy9k?=
 =?utf-8?B?YzAzMUpIaDU2UWtadTlnZG9xaVoyTlN6aWpWem5PaHdxVGozM3BnVVlDWnRZ?=
 =?utf-8?B?Z3RNelpCUHhmMXoyVC9SRS83Z2JYUjVRejV5VFZCQ1Z4ZWVuODZINnk3MFJK?=
 =?utf-8?B?Y0gvNzFlUWpoemtYbzdoVkNPUXlDd1dkcGhGalI0LyttOGJ3UnFZNEoxeFp4?=
 =?utf-8?B?MDQ1SCt1anpVLzVNbUxJUURZVGltbVpEdnFwOGpjTXBUdlQ3cFFZeVhKM0do?=
 =?utf-8?B?UEJjYzRQSXFJQmZhSzNrcmVNMWdCejRBTEcvU0JDUUZyUmFQdmd2UUZ1VWlo?=
 =?utf-8?B?VzI0Vm94ZDY3eEZ6dHRaS3FuNStNTVRzNzZSYTNpVWFVMUk0Vm9EOUljbHhT?=
 =?utf-8?B?L1I2L1hJeU16Qzh0aThOb0s3VW1kOXpZbFlMYXBMaXhhdWNEdzVLTzJVMVNO?=
 =?utf-8?B?ZTA0Y3A2NDBiVXpZQmwxcmE1cHdvaEJ2T3NZYTZnYU9DZFcrbFlNV2p1RmE2?=
 =?utf-8?B?TWJXQTdTTnQ4dXFGOWJZT0FwTURkZXAzWlFwQXZsSGNaL2JMeUx4R0tNUW9w?=
 =?utf-8?B?RkRBTWM5blowdUhiaGhJU2NkeXRnK0pobkZnWFNOV0JkS1hmQnh3b3A3TW8x?=
 =?utf-8?B?cmVGMjIyZlUrUnVNSjBnL3NlU2I5UzMzMlZIQWludG9MR0hJeGJjcWJmSUdV?=
 =?utf-8?B?NU1xNlJWajBPd1cvNjRuTWZqZEpTaytnUUtZaG1TMmdBNjAxL1BoWFRJQ3R2?=
 =?utf-8?Q?Dw/i1+LaL3Ipe4GtSqQh5qs=3D?=
Content-ID: <C7D6188E39470B419E72DDFDFF2E5728@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6134.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9b4112-fe73-4544-7e6c-08d9ba261b28
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 08:38:27.6210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJW1ISTDRnz4eTMObraXQ8nJeY1hUmBN5/wbi3R0FDxrSN9o/U6wrZ8kX7uSns2EjushbIYjqWC9q+7p1SN0tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3794
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/write06: Add new test
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

SGkgQ3lyaWwNCg0K5ZyoIDIwMjEvMTIvNyAyMTo1MSwgQ3lyaWwgSHJ1YmlzIOWGmemBkzoNCj4g
SGkhDQo+PiBTaWduZWQtb2ZmLWJ5OiBEYWkgU2hpbGkgPGRhaXNsLmZuc3RAZnVqaXRzdS5jb20+
DQo+PiAtLS0NCj4+ICAgcnVudGVzdC9zeXNjYWxscyAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDEgKw0KPj4gICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3dyaXRlLy5naXRpZ25vcmUg
fCAgMSArDQo+PiAgIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvd3JpdGUvd3JpdGUwNi5jICB8
IDk0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAzIGZpbGVzIGNoYW5nZWQs
IDk2IGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvd3JpdGUvd3JpdGUwNi5jDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3J1bnRlc3Qv
c3lzY2FsbHMgYi9ydW50ZXN0L3N5c2NhbGxzDQo+PiBpbmRleCBiY2YzZDU2Li4zMmZjZGE0IDEw
MDY0NA0KPj4gLS0tIGEvcnVudGVzdC9zeXNjYWxscw0KPj4gKysrIGIvcnVudGVzdC9zeXNjYWxs
cw0KPj4gQEAgLTE2OTksNiArMTY5OSw3IEBAIHdyaXRlMDIgd3JpdGUwMg0KPj4gICB3cml0ZTAz
IHdyaXRlMDMNCj4+ICAgd3JpdGUwNCB3cml0ZTA0DQo+PiAgIHdyaXRlMDUgd3JpdGUwNQ0KPj4g
K3dyaXRlMDYgd3JpdGUwNg0KPj4gICANCj4+ICAgd3JpdGV2MDEgd3JpdGV2MDENCj4+ICAgd3Jp
dGV2MDIgd3JpdGV2MDINCj4+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3dyaXRlLy5naXRpZ25vcmUgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3dyaXRlLy5naXRp
Z25vcmUNCj4+IGluZGV4IDdmMzYxOTQuLjg1MjlhYWUgMTAwNjQ0DQo+PiAtLS0gYS90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL3dyaXRlLy5naXRpZ25vcmUNCj4+ICsrKyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvd3JpdGUvLmdpdGlnbm9yZQ0KPj4gQEAgLTMsMyArMyw0IEBADQo+PiAg
IC93cml0ZTAzDQo+PiAgIC93cml0ZTA0DQo+PiAgIC93cml0ZTA1DQo+PiArL3dyaXRlMDYNCj4+
IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3dyaXRlL3dyaXRlMDYuYyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvd3JpdGUvd3JpdGUwNi5jDQo+PiBuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMC4uYzYyYTI2Ng0KPj4gLS0tIC9kZXYvbnVsbA0K
Pj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy93cml0ZS93cml0ZTA2LmMNCj4+IEBA
IC0wLDAgKzEsOTQgQEANCj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1v
ci1sYXRlcg0KPj4gKy8qDQo+PiArICogQ29weXJpZ2h0IChjKSAyMDIxIEZVSklUU1UgTElNSVRF
RC4gQWxsIHJpZ2h0cyByZXNlcnZlZC4NCj4+ICsgKiBBdXRob3I6IERhaSBTaGlsaSA8ZGFpc2wu
Zm5zdEBmdWppdHN1LmNvbT4NCj4+ICsgKi8NCj4+ICsNCj4+ICsvKlwNCj4+ICsgKiBbRGVzY3Jp
cHRpb25dDQo+PiArICoNCj4+ICsgKiBUZXN0IHRoZSB3cml0ZSgpIHN5c3RlbSBjYWxsIHdpdGgg
T19BUFBFTkQuDQo+PiArICoNCj4+ICsgKiBXcml0aW5nIDJrIGRhdGEgdG8gdGhlIGZpbGUsIGNs
b3NlIGl0IGFuZCByZW9wZW4gaXQgd2l0aCBPX0FQUEVORC4NCj4+ICsgKiBWZXJpZnkgdGhhdCB0
aGUgZmlsZSBzaXplIGlzIDNrIGFuZCBvZmZzZXQgaXMgbW92ZWQgdG8gdGhlIGVuZCBvZiB0aGUg
ZmlsZS4NCj4+ICsgKi8NCj4+ICsNCj4+ICsjaW5jbHVkZSA8c3RkbGliLmg+DQo+PiArI2luY2x1
ZGUgPGludHR5cGVzLmg+DQo+PiArI2luY2x1ZGUgInRzdF90ZXN0LmgiDQo+PiArI2luY2x1ZGUg
InRzdF9zYWZlX3Bydy5oIg0KPj4gKw0KPj4gKyNkZWZpbmUgSzEgICAgICAgICAgICAgIDEwMjQN
Cj4+ICsjZGVmaW5lIEsyICAgICAgICAgICAgICAoSzEgKiAyKQ0KPj4gKyNkZWZpbmUgSzMgICAg
ICAgICAgICAgIChLMSAqIDMpDQo+PiArI2RlZmluZSBEQVRBX0ZJTEUgICAgICAgIndyaXRlMDZf
ZmlsZSINCj4+ICsNCj4+ICtzdGF0aWMgaW50IGZkID0gLTE7DQo+PiArc3RhdGljIGNoYXIgKndy
aXRlX2J1ZlsyXTsNCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBsX3NlZWsoaW50IGZkZXNjLCBvZmZf
dCBvZmZzZXQsIGludCB3aGVuY2UsIG9mZl90IGNoZWNrb2ZmKQ0KPj4gK3sNCj4+ICsJb2ZmX3Qg
b2ZmbG9jOw0KPj4gKw0KPj4gKwlvZmZsb2MgPSBTQUZFX0xTRUVLKGZkZXNjLCBvZmZzZXQsIHdo
ZW5jZSk7DQo+PiArCWlmIChvZmZsb2MgIT0gY2hlY2tvZmYpIHsNCj4+ICsJCXRzdF9yZXMoVEZB
SUwsICIlIiBQUklkNjQgIiA9IGxzZWVrKCVkLCAlIiBQUklkNjQgIiwgJWQpICE9ICUiIFBSSWQ2
NCwNCj4+ICsJCQkoaW50NjRfdClvZmZsb2MsIGZkZXNjLCAoaW50NjRfdClvZmZzZXQsIHdoZW5j
ZSwgKGludDY0X3QpY2hlY2tvZmYpOw0KPj4gKwl9DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyB2
b2lkIHZlcmlmeV93cml0ZSh2b2lkKQ0KPj4gK3sNCj4+ICsJaW50IGZhaWwgPSAwOw0KPj4gKwlz
dHJ1Y3Qgc3RhdCBzdGF0YnVmOw0KPj4gKw0KPj4gKwlmZCA9IFNBRkVfT1BFTihEQVRBX0ZJTEUs
IE9fUkRXUiB8IE9fQ1JFQVQgfCBPX1RSVU5DLCAwNjY2KTsNCj4+ICsJU0FGRV9XUklURSgxLCBm
ZCwgd3JpdGVfYnVmWzBdLCBLMik7DQo+PiArCVNBRkVfQ0xPU0UoZmQpOw0KPj4gKw0KPj4gKwlm
ZCA9IFNBRkVfT1BFTihEQVRBX0ZJTEUsIE9fUkRXUiB8IE9fQVBQRU5ELCAwNjY2KTsNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiAJ
CQkJCQkgICAgIE5vIG5lZWQgdG8gcGFzcw0KPiAJCQkJCQkgICAgIG1vZGUgd2l0aG91dA0KPiAJ
CQkJCQkgICAgIE9fQ1JFQVQNCkdvdCBpdC4NCj4+ICsJU0FGRV9GU1RBVChmZCwgJnN0YXRidWYp
Ow0KPj4gKwlpZiAoc3RhdGJ1Zi5zdF9zaXplICE9IEsyKSB7DQo+PiArCQlmYWlsKys7DQo+PiAr
CQl0c3RfcmVzKFRGQUlMLCAiZmlsZSBzaXplIGlzICVsZCAhPSBLMiIsIHN0YXRidWYuc3Rfc2l6
ZSk7DQo+PiArCX0NCj4+ICsNCj4+ICsJbF9zZWVrKGZkLCBLMSwgU0VFS19TRVQsIEsxKTsNCj4g
V2h5IGRvIHdlIGRvIHRoZSBzZWVrIGhlcmU/DQo+DQo+IFdvdWxkbid0IGl0IG1ha2UgbXVjaCBt
b3JlIHNlbnNlIGp1c3QgdG8gd3JpdGUgdGhlIHdyaXRlX2J1ZlsxXSB0aGVuDQo+IGNoZWNrIHRo
YXQgdGhlIHN0X3NpemUgaXMgSzM/DQo+DQo+IFRoYXQgd2F5IHdlIHdvdWxkIGNoZWNrIHRoYXQg
T19BUFBFTkQgb3BlbmVkIGZpbGUgaGFzIGNvcnJlY3QgcG9zaXRpb24NCj4gYXNzb2NpYXRlZCB3
aXRoIHRoZSBmaWxlIGRlc2NyaXB0b3IuDQoNCkkgd2FudCB0byB2ZXJpZnkgdGhhdCB0aGUgb2Zm
c2V0IHdpbGwgbW92ZSB0byB0aGUgZW5kIG9mIHRoZSBmaWxlLg0KDQpTbyBJIHB1dCB0aGUgb2Zm
c2V0IGluIHRoZSBtaWRkbGUgb2YgdGhlIGZpbGUgYmVmb3JlIHdyaXRlLg0KDQo+PiArCVNBRkVf
V1JJVEUoMSwgZmQsIHdyaXRlX2J1ZlsxXSwgSzEpOw0KPj4gKwlsX3NlZWsoZmQsIDAsIFNFRUtf
Q1VSLCBLMyk7DQo+IEFuZCBoZXJlIGFzIHdlbGwsIHdoeSB0aGUgc2Vlaz8gVGhpcyBpcyBhY3R1
YWxseSB0aGUgcGxhY2UgdGhhdA0KPiBpbmNyZWFzZXMgdGhlIHNpemUgbm90IHRoZSB3cml0ZSgp
IGFzIGl0IHNob3VsZCBoYXZlIGJlZW4uDQpEbyBzZWVrIHRvIGNoZWNrIHRoZSBvZmZzZXQgaXMg
bW92ZWQgdG8gdGhlIGVuZCBvZiB0aGUgZmlsZS4NCj4+ICsJU0FGRV9GU1RBVChmZCwgJnN0YXRi
dWYpOw0KPj4gKwlpZiAoc3RhdGJ1Zi5zdF9zaXplICE9IEszKSB7DQo+PiArCQlmYWlsKys7DQo+
PiArCQl0c3RfcmVzKFRGQUlMLCAiZmlsZSBzaXplIGlzICVsZCAhPSBLMyIsIHN0YXRidWYuc3Rf
c2l6ZSk7DQo+PiArCX0NCj4gUmVhbGx5IHRoZSB3aG9sZSB0ZXN0IHNob3VsZCBkbzoNCj4NCj4g
CW9wZW4oRklMRSwgT19SRFdSIHwgT19DUkVBVCB8IE9fVFJVTkMsIDA2NjYpDQo+IAl3cml0ZSgp
DQo+IAljbG9zZSgpDQo+DQo+IAlvcGVuKEZJTEUsIE9fUkRXUiB8IE9fQVBQRU5EKQ0KPiAJY2hl
Y2sgc2l6ZQ0KPiAJd3JpdGUoKQ0KPiAJY2hlY2sgc2l6ZQ0KPiAJY2xvc2UoKQ0KPg0KPiAJb3Bl
bihGSUxFLCBPX1JET05MWSk7DQo+IAlyZWFkKCkNCj4gCXZlcmlmeSBkYXRhDQo+IAljbG9zZSgp
DQo+DQpJJ20gc28gc29ycnksIG15IGNvbW1pdCBtc2cgaXMgbm90IGNsZWFyLg0KDQpXaGF0IEkg
d2FudCB0byB0ZXN0IGlzIHRoZSBmb2xsb3dpbmcgZGVzY3JpcHRpb24gb2Ygb3BlbigyKSBtYW4t
cGFnZXM6DQoNCk9fQVBQRU5EDQogwqDCoMKgIMKgIFRoZSBmaWxlIGlzIG9wZW5lZCBpbiBhcHBl
bmQgbW9kZS7CoCBCZWZvcmUgZWFjaCB3cml0ZSgyKSwgdGhlIA0KZmlsZSBvZmZzZXQgaXMgcG9z
aXRpb25lZCBhdCB0aGUgZW5kIG9mIHRoZSBmaWxlLCBhcyBpZiB3aXRoIGxzZWVrKDIpLsKgIA0K
VGhlIG1vZGlmaWNhdGlvbiBvZiB0aGUgZmlsZSBvZmZzZXQgYW5kIHRoZSB3cml0ZSBvcGVyYXRp
b24gYXJlIA0KcGVyZm9ybWVkIGFzIGEgc2luZ2xlIGF0b21pYyBzdGVwLg0KPj4gKwlpZiAoIWZh
aWwpDQo+PiArCQl0c3RfcmVzKFRQQVNTLCAiT19BUFBFTkQgdGVzdCBwYXNzZWQuIik7DQo+PiAr
CVNBRkVfQ0xPU0UoZmQpOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBzZXR1cCh2b2lk
KQ0KPj4gK3sNCj4+ICsJd3JpdGVfYnVmWzBdID0gU0FGRV9NQUxMT0MoSzIpOw0KPj4gKwltZW1z
ZXQod3JpdGVfYnVmWzBdLCAwLCBLMik7DQo+PiArCXdyaXRlX2J1ZlsxXSA9IFNBRkVfTUFMTE9D
KEsxKTsNCj4+ICsJbWVtc2V0KHdyaXRlX2J1ZlswXSwgMSwgSzEpOw0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF4NCj4gCQkJIDENCj4NCj4gQWxzbyBjYW4geW91IHBsZWFzZSBzd2l0Y2gg
dGhlc2UgdHdvIGJ1ZmZlcnMgdG8gYSBndWFyZGVkIGJ1ZmZlcnM/DQo+DQo+IFNlZToNCj4NCj4g
aHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvd2lraS9DLVRlc3QtQVBJ
IzEzMS1ndWFyZGVkLWJ1ZmZlcnMNCk9LLiBJIHdpbGwgc3dpdGNoIHRvIGd1YXJkZWQgYnVmZmVy
cy4NCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQ0KPj4gK3sNCj4+
ICsJZnJlZSh3cml0ZV9idWZbMF0pOw0KPj4gKwlmcmVlKHdyaXRlX2J1ZlsxXSk7DQo+PiArDQo+
PiArCWlmIChmZCA+IC0xKQ0KPiBQcm9iYWJseSBmZCAhPSAtMSB3b3VsZCBiZSBhIGJpdCBjbGVh
cmVyLg0KR290IGl0Lg0KPj4gKwkJU0FGRV9DTE9TRShmZCk7DQo+PiArDQo+PiArCVNBRkVfVU5M
SU5LKERBVEFfRklMRSk7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3Qg
dGVzdCA9IHsNCj4+ICsJLm5lZWRzX3RtcGRpciA9IDEsDQo+PiArCS5zZXR1cCA9IHNldHVwLA0K
Pj4gKwkuY2xlYW51cCA9IGNsZWFudXAsDQo+PiArCS50ZXN0X2FsbCA9IHZlcmlmeV93cml0ZSwN
Cj4+ICt9Ow0KPj4gLS0gDQo+PiAxLjguMy4xDQo+Pg0KPj4NCj4+IC0tIA0KPj4gTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
