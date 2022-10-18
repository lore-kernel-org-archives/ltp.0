Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616B1C433FE
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 02:26:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAD283CB01E
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 04:26:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D249A3C4CCC
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 04:25:49 +0200 (CEST)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6733B1000938
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 04:25:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1666059949; x=1697595949;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=fVv7vpvXwv8KsMQpeXW83mKx8ikM19W23hgf7PJwjng=;
 b=ETHvO24Gur06+x+Oc0UskQ12W8HpaXqlnn1LaL6PUQVMKE3V9jb3SleD
 lopFEeANMyrJx3ZY2Sr5y7jNXAcJnPFj1tuRyBvuri8MdeNxU1/4pSRjV
 B2Igdqx7hGmmi5NWkCtL1cSDhcOvdbnsDCQaVTuoEXaDFWo9Lddqjai4w
 HrI8Vycxm1MvRiB6Chbi8uejDbCnawtLxvgPha3iz/2JsFcRKDtUs0TQ3
 Ls9jiRTUbKrYNAntP6cMJU9PRHkxQNwCljbcJYmPiNEuqbEwT1Vygz5pm
 PcpqCozBiAJqqkfCoPREoOM9doCzGsx71jCqVagvu72P3dZJ3sABArffV Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="75572532"
X-IronPort-AV: E=Sophos;i="5.95,192,1661785200"; d="scan'208";a="75572532"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2022 11:25:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITjfR9ZvUOQ/Jw6rn8mU/YvZ93KU2oI86V4/x0LhVcmVBs33LhTPJjGNN0xdYVItIfrlyQ7uzAJ03HLB4dtk52Lg4Ek3qhh7BbrtSplfFXSEu2P4oO+mxfZKz8C3hhGARW2AtxBPcGK8Kb7LNLEuG7pqVXxfVtbanVgz9Gu0nvXJLVefKJ56XKFVasBWhdJgMl/fCFxCmgYJVEutyp7OWM3k6LBWfV2YXnc0cPybo9cbragxSP+CmSS4kybwPbwJrZHYvKXwm7jS/usy937bDv1v/Yy1ETpBHeN4PenbnPx6XCawUA/6t3HGGR9vm2jrsGzKBmJ/kIFHU0v2TQRWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVv7vpvXwv8KsMQpeXW83mKx8ikM19W23hgf7PJwjng=;
 b=hZ9Q4nYs24XFUWKjKuLPV74EqiTKtZBy3X7Wzv4/6Au/snT3bd/1Z2eJ+Yc+Ci/9lpWqJVGcNPBseL4SFkTLOfaYL35sLeHrd2j0j/dDy4Cg5d6GJ/UEI9sp4a9YpMucY5GNhP0EqItLZlAnR28ZNpX4Kivb68zitoNxLEc/zuSpXdalVH+RN3a9ZSeV3WGVz2fgOH68/1SIG/bpTKQ9ASS9JO8dOV+RXwdYI4eXpwcDqZ9PGdBBUVNrJ0TA6LPJnqHqEu507ESrNTQq9Rx+7qdfLuGoJFbe/L2TWlJ8GynbHpPBLqY7ILEhcTfFVOoPA6s5U6lzWUVzQOky//ncRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB8600.jpnprd01.prod.outlook.com (2603:1096:400:159::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.25; Tue, 18 Oct
 2022 02:25:41 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 02:25:41 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>, zhaogongyi
 <zhaogongyi@huawei.com>
Thread-Topic: [LTP] [PATCH v4] syscalls/nice05: Add testcase for nice() syscall
Thread-Index: Adi3n57+Qn05nXVIYU+YkZQt897ETQqaI/IAACZNaoA=
Date: Tue, 18 Oct 2022 02:25:41 +0000
Message-ID: <3c646f65-3f04-39a5-baf0-9185e609471f@fujitsu.com>
References: <eecac802efe34cd3a95582feb1fc4fbd@huawei.com>
 <871qr6q0fx.fsf@suse.de>
In-Reply-To: <871qr6q0fx.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|TYCPR01MB8600:EE_
x-ms-office365-filtering-correlation-id: 3eedb3c5-cac9-47e6-1ccb-08dab0b00dcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: baL39GCaQj/l+Iwrzwg6NncU9oxK7gwCU6rj3B3kLPQ6L/F0e0USz5kMZ3oz2peS/zQSmP2uh0yvx3mBwmK3Fsv8y5hgrRby2aZi/g+XYFbEsdhbZMbQd6P5wnsZhK0J02cNoRWTPUzbekg7qhPY/0OVzQIpjswnvdrMahdiWfeBptrR3zG3hZ2Ro7x+683zIy4/nVXIR1NjUi9ZmP+g11a4sY29eI6lvlwBC16MAHE1KZ0/gsNylA33e1SFMFUZsfSAgr0HPBDis6cs7z07LZUHP93vav+lKZz39dTUmTwqkZGWT427wHF0BbVwVFhdLEpmAQfVx1qBX0pP6EN1WlyM2pN0smJMORYAMia/0S77eNevAllcE79UekAhmMgInTIms/Fa4mIWZjDBjsb8sBCwI82nT3D1vkybQnfBSD90ujeerz94t7RPRt4jrdExyV2950wC1TjNluYbcsekhdGxXKXr45pMIZ/OkGrCxyzWfRP51KxwX2jy/kSl3VKdTQAdj4ZA3EwX8vHSODKVaKk233wdh5NMSmfYvUp93dtuVAqPzvwZ/XFUpP3WYddr80nkOQaIY/eo7IMRwiEIJSqX1aKRQqz3JwjtHgvb2IFYa1v8pd5xZ3MHm1BWHOV8ttUOumHH9PVx7jdIjQ9LwdVGpL9rPExXEE6O/Q2oXc5nAQcQ19hlKf1gNLC49KacdScpfekvIPf+paKldpnQMWYRrK0HD/75Qz+k6NnogrSTeFMb1t81GJqKqMNmKttIvPZ9wPn2PYNC/XUP5FJcI9oFDt533uAHP65zi3Eveyb+nXzGZ+f8ys2DK9Qba7tnG00R+svNzD9diSjxIr1Qo7XKGOjJ0JM+EDxAiWnn4Lw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199015)(1590799012)(38070700005)(122000001)(31686004)(6486002)(478600001)(71200400001)(1580799009)(82960400001)(966005)(38100700002)(316002)(2616005)(186003)(66556008)(66476007)(64756008)(8676002)(66946007)(66446008)(110136005)(76116006)(91956017)(4326008)(6506007)(36756003)(85182001)(26005)(41300700001)(6512007)(8936002)(86362001)(2906002)(5660300002)(31696002)(83380400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1pEYVA5MTkyOGxzRjZ3d2xNY0dpT1M2TVZaVnh1YUFRUFJpQS9sMkRDa012?=
 =?utf-8?B?N1AvQ291QUFqdnJqQlcra2poaXpJbEtUaU1XdjFrR1F6TFdwc1FxVjY4dUhK?=
 =?utf-8?B?MXc5VkFhcnRINFhGMkNMd2JHY0E1NUxjenJyL3ZldDhGMTNKNkNvZzZXSjZL?=
 =?utf-8?B?SkhNZDFZb2ZzeFFaTGh3N2dFMmdlL0hTU1N6c0VsWWxpU25jdzFKVldQVE9E?=
 =?utf-8?B?V1h0K3BrZUdPeC9Kc1dDZGlCQXFSS2p3STlOc3F6R3V5K2ZnQTdHR0ZOcGlJ?=
 =?utf-8?B?aE5xNXNOTEZ3aTVpMU5URHZvbVo3RTlmT1J2SW1ZR0pXdjdaMk1RemRuNFV0?=
 =?utf-8?B?eWNvSWpaN0dnNGo2dC9zdUR4SjlqQ2tUaitGQ2NEVWY1SXM2TDkxNmZXeG5N?=
 =?utf-8?B?WFlETzkvbkRReUZBcnV2eGhIVG1QMlplVWxNT1BvbXhTMnNDOVZhL3B2U0s5?=
 =?utf-8?B?dEJtQVlteFVPbHcvR2t5bFA3V0s3QmdtNjM2R1Jac2QrOGJUTkk5RG55amY1?=
 =?utf-8?B?dXJVd01qMEo2dW44dUFwRldWd05tQlZhb2QrU1hSdXpRY2ZhQkp0dzJGb2pu?=
 =?utf-8?B?WWpoYzRybCs1SHVEOG1YbTh2MGpXRmtwc2l3ZVpUTkc2RGVoZFYybnFBOHZ1?=
 =?utf-8?B?SndlQ3p5REliVFNEbnZ0R1ZrSTFnRS8vMHNjY01mSlZnWHFsRGNjRWFtOVA2?=
 =?utf-8?B?MG5HQ0xOZ3BDTy8xZGlMU1BEd05EakQvS005TWNxd1ovczdWRGpPbHhvbk9F?=
 =?utf-8?B?T25UeHd0RDBYSktPQ0VLQ0x3VDJJWXNHYW1RaFBhcERxaGpLSEJDWGxFNXlR?=
 =?utf-8?B?ZWZzcnpIU1crdno3WFlPdkFvQkZWQ0lQUSs5MThVSHhkbTJjSzI0aUN0OHg4?=
 =?utf-8?B?aGVCVTZ2SE9xc1NvYVFoS1BLc3Q1ZXo3dW53WXMrd1Q0UzgvL2J0MUwvcDN5?=
 =?utf-8?B?Z0xZeHgzNzlHT2F1V0UrVS8wSHJwSHI4N00vdGZYdnhQd25mbnc3emc1Zk5N?=
 =?utf-8?B?anI2cnhLM2hZc2FFdUFOa3RYMzRsWURFdDlWbGtRWGd4N2NqRndUb1dKcUcx?=
 =?utf-8?B?WjlDNVpPeTU3d3BRV2thOFUvQkIyVVFmZmF2QUp6cDg3RUxVNFl0cWc2Y2xW?=
 =?utf-8?B?T3I2dXJHcmJPQ2RodnM0UEVXTEF2R3RQbWxwRFY1d21FVGVzVEF4WU9IK0di?=
 =?utf-8?B?clhtckdidUNYaDkyVjNhREtjbHJxNk9iRjRtZDhYUHkydytMTGpDa3J3bytX?=
 =?utf-8?B?V0VUSDNyK2tYeGlJN0Q2K0VwL0QrZTFVdGptM0F6SEx5ek1PZGRtNnhQQUE0?=
 =?utf-8?B?dytPYm5aR3FpNkNiZmpETjgybHNaZDQ2TllOcHJid29PK2FtZUNUaDl4RHU5?=
 =?utf-8?B?U25yTUpKUlBkVmhJSGJMN3VtMnZYbExmOTk2SndTbG9TUTZtMTdWcDFiU0M2?=
 =?utf-8?B?Nm03ZDhIVFppdUdrKzVwUFJmRVc2Q1IzU3Jic01RSXpHWUh2dEZwYzYvaXVU?=
 =?utf-8?B?VzExcTg2cUVzSjJNd0ZmOTc4eGpDWTU4K3kwTWFtVEZxNXJ1OEdWdkdiV0dE?=
 =?utf-8?B?Uml2TzE0Z3BNK05oOFU5d25zVXgxc3F1OVM4c1RDZkd4L01aa3ZSb3FWSjVR?=
 =?utf-8?B?U253ZDBadTdkTm9xRm1wdE5sMnhiaXpkbkRqMmliNWh2c2x0YW1PcDB3aS9r?=
 =?utf-8?B?dFl3UGtkRURYRlZpSFMwVUtlYkw3RmVqSWtyNG9KTXZ4akJadXQ0SVM2WENV?=
 =?utf-8?B?a0YwalBUN2JHVGZwZ0xoNjVQZGdPalZrY2hJWFF3OVVVanV6Z0xIK1hkOUdk?=
 =?utf-8?B?TkVEZnlEL2FNQnlxWDZVUzB4Z1M3THhQMFlUV3NhcEtXdDI0VUp2MjlFT0hk?=
 =?utf-8?B?QkFvS3dxcG1YRHdteTBUcjFDeXE5UTI2SzV0MEticE9raWRoWC9ocjVHNTNQ?=
 =?utf-8?B?cUZYYVpSWjJERC9XcFhBZ3J6MlNTT0FzL2k0L3d0R2ppcDBpOW9Bc05qdlR5?=
 =?utf-8?B?NlduVStLajFtSmc1eTBPMy9MbDBiREZNMVU2TWxOcG1rSDVFVTIzQ3Y1WHQ3?=
 =?utf-8?B?dzZkSEZWb0FyelV2ckxySHZTYjdQQ0Q1aC9tUWI2UUZmaDV0bDAxKzEvakN4?=
 =?utf-8?B?dW9GRmdwQUxFNFJteENNMnFJeDRhUFU3amdSaEtwbTA3UXc0WHpVTFJQZitJ?=
 =?utf-8?B?dlE9PQ==?=
Content-ID: <9FA7C6235B31F340A4E5777C8942A215@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eedb3c5-cac9-47e6-1ccb-08dab0b00dcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 02:25:41.8337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ue3ePzwm8lobyjGW7J7zGKOqK/YUpT8RAWONEpMv+u+qxhI8PpVPzOV0ASUsCYyWC9GD99/BFCQm6e+nxa02QWnQ2e8DIcXLBVJwmygLYJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8600
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/nice05: Add testcase for nice()
 syscall
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

SGkgUmljaGFyZCxaaGFvDQoNClRoaXMgY2FzZSBjb21waWxlIGZhaWxlZCBvbiBjZW50b3M3IGFz
IGJlbG93DQpzYWZlX3B0aHJlYWQuYzo5MzozODogZXJyb3I6IGV4cGVjdGVkIOKAmDvigJksIOKA
mCzigJkgb3Ig4oCYKeKAmSBiZWZvcmUg4oCYYmFycmllcuKAmQ0KICAgICAgICAgICBwdGhyZWFk
X2JhcnJpZXJfdCAqcmVzdHJpY3QgYmFycmllciwNCg0KQnV0IEkgZG9uJ3Qga25vdyB3aHkgLi4u
Lg0KDQpwczogSSBndWVzcyBhIG9sZCBnY2MgYnVnIG9yIHB0aHJlYWQgbGliIGJ1Zy4NCg0KQmVz
dCBSZWdhcmRzDQpZYW5nIFh1DQo+IEhlbGxvLA0KPiANCj4gemhhb2dvbmd5aSB2aWEgbHRwIDxs
dHBAbGlzdHMubGludXguaXQ+IHdyaXRlczoNCj4gDQo+PiBIaSBDeXJpbCwNCj4+DQo+PiBUaGFu
a3MgZm9yIHlvdXIgcmV2aWV3ISBJIGhhdmUgcmVzdWJtaXQgYSBwYXRjaCBhY2NvcmRpbmcgdG8g
eW91cg0KPj4gc3VnZ2VzdGlvbi4gUGxlYXNlIHNlZToNCj4+IGh0dHBzOi8vcGF0Y2h3b3JrLm96
bGFicy5vcmcvcHJvamVjdC9sdHAvcGF0Y2gvMjAyMjA4MjQwOTUxNDQuMjU5ODcxLTEtemhhb2dv
bmd5aUBodWF3ZWkuY29tLw0KPiANCj4gTWVyZ2VkIG5vdyB0aGFua3MhDQo+IA0KPiBJZiB0aGUg
dGVzdCBmYWlscyByYW5kb21seSB0aGVuIGluY3JlYXNpbmcgbWF4X3J1bnRpbWUgd2lsbCBwcm9i
YWJseSBoZWxwLg0KPiANCj4+DQo+PiBCZXN0IFdpc2hlcywNCj4+IEdvbmd5aQ0KPj4NCj4+Pg0K
Pj4+IEhpIQ0KPj4+PiBBZGQgdGVzdCB2ZXJpZmllcyB0aGF0IHRoZSBsb3cgbmljZSB0aHJlYWQg
ZXhlY3V0ZXMgbW9yZSB0aW1lIHRoYW4gdGhlDQo+Pj4+IGhpZ2ggbmljZSB0aHJlYWQgc2luY2Ug
dGhlIHR3byB0aHJlYWQgYmluZGVkIG9uIHRoZSBzYW1lIGNwdS4NCj4+Pg0KPj4+IExvb2tzIHZl
cnkgZ29vZCBub3csIHRoZXJlIGFyZSBmZXcgdmVyeSBtaW5vciBwb2ludHMgc2VlIGJlbG93Lg0K
Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoYW8gR29uZ3lpIDx6aGFvZ29uZ3lpQGh1YXdlaS5j
b20+DQo+Pj4+IC0tLQ0KPj4+PiB2My0+djQ6IFJlcGxhY2UgZ2V0dGluZyBleGVjIHRpbWUgZnJv
bSBzdW1fZXhlY19ydW50aW1lIHdpdGgNCj4+PiBwdGhyZWFkX2dldGNwdWNsb2NraWQoKS4NCj4+
Pj4NCj4+Pj4gICBydW50ZXN0L3N5c2NhbGxzICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
MSArDQo+Pj4+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9uaWNlLy5naXRpZ25vcmUgfCAg
IDEgKw0KPj4+PiAgIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbmljZS9NYWtlZmlsZSAgIHwg
ICAyICsNCj4+Pj4gICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL25pY2UvbmljZTA1LmMgICB8
IDE4OA0KPj4+ICsrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4gICA0IGZpbGVzIGNoYW5nZWQs
IDE5MiBpbnNlcnRpb25zKCspDQo+Pj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvbmljZS9uaWNlMDUuYw0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvcnVu
dGVzdC9zeXNjYWxscyBiL3J1bnRlc3Qvc3lzY2FsbHMgaW5kZXgNCj4+Pj4gOWQ1OGUwYWExLi45
OGZjYmJlMWUgMTAwNjQ0DQo+Pj4+IC0tLSBhL3J1bnRlc3Qvc3lzY2FsbHMNCj4+Pj4gKysrIGIv
cnVudGVzdC9zeXNjYWxscw0KPj4+PiBAQCAtOTAzLDYgKzkwMyw3IEBAIG5pY2UwMSBuaWNlMDEN
Cj4+Pj4gICBuaWNlMDIgbmljZTAyDQo+Pj4+ICAgbmljZTAzIG5pY2UwMw0KPj4+PiAgIG5pY2Uw
NCBuaWNlMDQNCj4+Pj4gK25pY2UwNSBuaWNlMDUNCj4+Pj4NCj4+Pj4gICBvcGVuMDEgb3BlbjAx
DQo+Pj4+ICAgb3BlbjAxQSBzeW1saW5rMDEgLVQgb3BlbjAxDQo+Pj4+IGRpZmYgLS1naXQgYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL25pY2UvLmdpdGlnbm9yZQ0KPj4+PiBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvbmljZS8uZ2l0aWdub3JlDQo+Pj4+IGluZGV4IDlkN2ExYmI0My4u
NThkNjQ3NzllIDEwMDY0NA0KPj4+PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL25p
Y2UvLmdpdGlnbm9yZQ0KPj4+PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL25pY2Uv
LmdpdGlnbm9yZQ0KPj4+PiBAQCAtMiwzICsyLDQgQEANCj4+Pj4gICAvbmljZTAyDQo+Pj4+ICAg
L25pY2UwMw0KPj4+PiAgIC9uaWNlMDQNCj4+Pj4gKy9uaWNlMDUNCj4+Pj4gZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbmljZS9NYWtlZmlsZQ0KPj4+PiBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvbmljZS9NYWtlZmlsZQ0KPj4+PiBpbmRleCAwNDQ2MTlmYjguLjAy
ZTc4YTI5NSAxMDA2NDQNCj4+Pj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9uaWNl
L01ha2VmaWxlDQo+Pj4+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbmljZS9NYWtl
ZmlsZQ0KPj4+PiBAQCAtMyw2ICszLDggQEANCj4+Pj4NCj4+Pj4gICB0b3Bfc3JjZGlyCQk/PSAu
Li8uLi8uLi8uLg0KPj4+Pg0KPj4+PiArbmljZTA1OiBDRkxBR1MgKz0gLXB0aHJlYWQNCj4+Pj4g
Kw0KPj4+PiAgIGluY2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21rL3Rlc3RjYXNlcy5taw0K
Pj4+Pg0KPj4+PiAgIGluY2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21rL2dlbmVyaWNfbGVh
Zl90YXJnZXQubWsNCj4+Pj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
bmljZS9uaWNlMDUuYw0KPj4+PiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbmljZS9uaWNl
MDUuYw0KPj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+PiBpbmRleCAwMDAwMDAwMDAuLjhl
ZjMzZjkzMg0KPj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvbmljZS9uaWNlMDUuYw0KPj4+PiBAQCAtMCwwICsxLDE4OCBAQA0KPj4+PiArLy8g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4+Pj4gKy8qDQo+Pj4+
ICsgKiBDb3B5cmlnaHQoYykgMjAyMiBIdWF3ZWkgVGVjaG5vbG9naWVzIENvLiwgTHRkDQo+Pj4+
ICsgKiBBdXRob3I6IExpIE1lbmdmZWkgPGxpbWVuZ2ZlaTRAaHVhd2VpLmNvbT4NCj4+Pj4gKyAq
ICAgICAgICAgWmhhbyBHb25neWkgPHpoYW9nb25neWlAaHVhd2VpLmNvbT4NCj4+Pj4gKyAqLw0K
Pj4+PiArDQo+Pj4+ICsvKlwNCj4+Pj4gKyAqIFtEZXNjcmlwdGlvbl0NCj4+Pj4gKyAqDQo+Pj4+
ICsgKiAxLiBDcmVhdGUgYSBoaWdoIG5pY2UgdGhyZWFkIGFuZCBhIGxvdyBuaWNlIHRocmVhZCwg
dGhlIG1haW4NCj4+Pj4gKyAqICAgIHRocmVhZCB3YWtlIHRoZW0gYXQgdGhlIHNhbWUgdGltZQ0K
Pj4+PiArICogMi4gQm90aCB0aHJlYWRzIHJ1biBvbiB0aGUgc2FtZSBDUFUNCj4+Pj4gKyAqIDMu
IFZlcmlmeSB0aGF0IHRoZSBsb3cgbmljZSB0aHJlYWQgZXhlY3V0ZXMgbW9yZSB0aW1lIHRoYW4N
Cj4+Pj4gKyAqICAgIHRoZSBoaWdoIG5pY2UgdGhyZWFkDQo+Pj4+ICsgKi8NCj4+Pj4gKw0KPj4+
PiArI2RlZmluZSBfR05VX1NPVVJDRQ0KPj4+PiArI2luY2x1ZGUgPHB0aHJlYWQuaD4NCj4+Pj4g
KyNpbmNsdWRlIDxzeXMvdHlwZXMuaD4NCj4+Pj4gKyNpbmNsdWRlIDxzdGRpby5oPg0KPj4+PiAr
I2luY2x1ZGUgInRzdF90ZXN0LmgiDQo+Pj4+ICsjaW5jbHVkZSAidHN0X3NhZmVfcHRocmVhZC5o
Ig0KPj4+PiArI2luY2x1ZGUgImxhcGkvc3lzY2FsbHMuaCINCj4+Pj4gKw0KPj4+PiArI2RlZmlu
ZSBTRUMyTlMoc2VjKSAgKChzZWMpICogMTAwMDAwMDAwMExMKQ0KPj4+PiArDQo+Pj4+ICtzdGF0
aWMgcHRocmVhZF9iYXJyaWVyX3QgYmFycmllcjsNCj4+Pj4gK3N0YXRpYyBpbnQgc29tZV9jcHU7
DQo+Pj4+ICtzdGF0aWMgY3B1X3NldF90ICpzZXQ7DQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyB2b2lk
IHNldF9uaWNlKGludCBuaWNlX2luYykNCj4+Pj4gK3sNCj4+Pj4gKwlpbnQgb3JpZ19uaWNlOw0K
Pj4+PiArDQo+Pj4+ICsJb3JpZ19uaWNlID0gU0FGRV9HRVRQUklPUklUWShQUklPX1BST0NFU1Ms
IDApOw0KPj4+PiArDQo+Pj4+ICsJVEVTVChuaWNlKG5pY2VfaW5jKSk7DQo+Pj4+ICsNCj4+Pj4g
KwlpZiAoVFNUX1JFVCAhPSAob3JpZ19uaWNlICsgbmljZV9pbmMpKSB7DQo+Pj4+ICsJCXRzdF9i
cmsoVEJST0sgfCBUVEVSUk5PLCAibmljZSglZCkgcmV0dXJuZWQgJWxpLCBleHBlY3RlZCAlaSIs
DQo+Pj4+ICsJCQluaWNlX2luYywgVFNUX1JFVCwgb3JpZ19uaWNlICsgbmljZV9pbmMpOw0KPj4+
PiArCX0NCj4+Pj4gKw0KPj4+PiArCWlmIChUU1RfRVJSKQ0KPj4+PiArCQl0c3RfYnJrKFRCUk9L
IHwgVFRFUlJOTywgIm5pY2UoJWQpIGZhaWxlZCIsIG5pY2VfaW5jKTsgfQ0KPj4+PiArDQo+Pj4+
ICtzdGF0aWMgdm9pZCAqbmljZV9sb3dfdGhyZWFkKHZvaWQgKmFyZykgew0KPj4+PiArCXZvbGF0
aWxlIGludCBudW1iZXIgPSAwOw0KPj4+PiArDQo+Pj4+ICsJc2V0X25pY2UoKGludHB0cl90KWFy
Zyk7DQo+Pj4+ICsJVEVTVChwdGhyZWFkX2JhcnJpZXJfd2FpdCgmYmFycmllcikpOw0KPj4+PiAr
CWlmIChUU1RfUkVUICE9IDAgJiYgVFNUX1JFVCAhPSBQVEhSRUFEX0JBUlJJRVJfU0VSSUFMX1RI
UkVBRCkNCj4+Pj4gKwkJdHN0X2JyayhUQlJPSyB8IFRSRVJSTk8sICJwdGhyZWFkX2JhcnJpZXJf
d2FpdCgpIGZhaWxlZCIpOw0KPj4+PiArDQo+Pj4+ICsJd2hpbGUgKDEpDQo+Pj4+ICsJCW51bWJl
cisrOw0KPj4+PiArDQo+Pj4+ICsJcmV0dXJuIE5VTEw7DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4g
K3N0YXRpYyB2b2lkICpuaWNlX2hpZ2hfdGhyZWFkKHZvaWQgKmFyZykgew0KPj4+PiArCXZvbGF0
aWxlIGludCBudW1iZXIgPSAwOw0KPj4+PiArDQo+Pj4+ICsJc2V0X25pY2UoKGludHB0cl90KWFy
Zyk7DQo+Pj4+ICsJVEVTVChwdGhyZWFkX2JhcnJpZXJfd2FpdCgmYmFycmllcikpOw0KPj4+PiAr
CWlmIChUU1RfUkVUICE9IDAgJiYgVFNUX1JFVCAhPSBQVEhSRUFEX0JBUlJJRVJfU0VSSUFMX1RI
UkVBRCkNCj4+Pj4gKwkJdHN0X2JyayhUQlJPSyB8IFRSRVJSTk8sICJwdGhyZWFkX2JhcnJpZXJf
d2FpdCgpIGZhaWxlZCIpOw0KPj4+DQo+Pj4gSXQgbWF5IGJlIHdvcnRoIHRvIGFkZCBTQUZFX1BU
SFJFQURfQkFSUklFUl9XQUlUKCkgdG8gdGhlDQo+Pj4gdHN0X3NhZmVfcHRocmVhZF9oIHRvIG1h
a2UgdGhlIGNvZGUgbmljZXIuDQo+Pj4NCj4+Pj4gKwl3aGlsZSAoMSkNCj4+Pj4gKwkJbnVtYmVy
Kys7DQo+Pj4+ICsNCj4+Pj4gKwlyZXR1cm4gTlVMTDsNCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiAr
c3RhdGljIHZvaWQgc2V0dXAodm9pZCkNCj4+Pj4gK3sNCj4+Pj4gKwlzaXplX3Qgc2l6ZTsNCj4+
Pj4gKwlzaXplX3QgaTsNCj4+Pj4gKwlpbnQgbnJjcHVzID0gMTAyNDsNCj4+Pj4gKw0KPj4+PiAr
CXNldCA9IENQVV9BTExPQyhucmNwdXMpOw0KPj4+PiArCWlmICghc2V0KQ0KPj4+PiArCQl0c3Rf
YnJrKFRCUk9LIHwgVEVSUk5PLCAiQ1BVX0FMTE9DKCkiKTsNCj4+Pj4gKw0KPj4+PiArCXNpemUg
PSBDUFVfQUxMT0NfU0laRShucmNwdXMpOw0KPj4+PiArCUNQVV9aRVJPX1Moc2l6ZSwgc2V0KTsN
Cj4+Pj4gKwlpZiAoc2NoZWRfZ2V0YWZmaW5pdHkoMCwgc2l6ZSwgc2V0KSA8IDApDQo+Pj4+ICsJ
CXRzdF9icmsoVEJST0sgfCBURVJSTk8sICJzY2hlZF9nZXRhZmZpbml0eSgpIik7DQo+Pj4+ICsN
Cj4+Pj4gKwlmb3IgKGkgPSAwOyBpIDwgc2l6ZSAqIDg7IGkrKykNCj4+Pj4gKwkJaWYgKENQVV9J
U1NFVF9TKGksIHNpemUsIHNldCkpDQo+Pj4+ICsJCQlzb21lX2NwdSA9IGk7DQo+Pj4+ICsNCj4+
Pj4gKwlDUFVfWkVST19TKHNpemUsIHNldCk7DQo+Pj4+ICsJQ1BVX1NFVF9TKHNvbWVfY3B1LCBz
aXplLCBzZXQpOw0KPj4+PiArCWlmIChzY2hlZF9zZXRhZmZpbml0eSgwLCBzaXplLCBzZXQpIDwg
MCkNCj4+Pj4gKwkJdHN0X2JyayhUQlJPSyB8IFRFUlJOTywgInNjaGVkX3NldGFmZmluaXR5KCki
KTsgfQ0KPj4+PiArDQo+Pj4+ICtzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpDQo+Pj4+ICt7DQo+
Pj4+ICsJaWYgKHNldCkNCj4+Pj4gKwkJQ1BVX0ZSRUUoc2V0KTsNCj4+Pg0KPj4+IFRoaXMgaXMg
dmVyeSBtaW5vciBob3dldmVyIHdlIGRvIG5vdCBzZWVtIHRvIHVzZSBzZXQgYW55d2hlcmUgb3V0
c2lkZQ0KPj4+IHRoZSBzZXR1cCBzbyB3ZSBtYXkgYXMgd2VsbCBmcmVlIGl0IHRoZXJlLg0KPj4+
DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyB2b2lkIHZlcmlmeV9uaWNlKHZvaWQpDQo+
Pj4+ICt7DQo+Pj4+ICsJaW50cHRyX3QgbmljZV9pbmNfaGlnaCA9IC0xOw0KPj4+PiArCWludHB0
cl90IG5pY2VfaW5jX2xvdyA9IC0yOw0KPj4+PiArCWNsb2NraWRfdCBuaWNlX2xvd19jbG9ja2lk
LCBuaWNlX2hpZ2hfY2xvY2tpZDsNCj4+Pj4gKwlzdHJ1Y3QgdGltZXNwZWMgbmljZV9oaWdoX3Rz
LCBuaWNlX2xvd190czsNCj4+Pj4gKwlsb25nIGxvbmcgZGVsdGE7DQo+Pj4+ICsJcGlkX3QgcGlk
Ow0KPj4+PiArCXB0aHJlYWRfdCB0aHJlYWRbMl07DQo+Pj4+ICsNCj4+Pj4gKwlwaWQgPSBTQUZF
X0ZPUksoKTsNCj4+Pj4gKwlpZiAoIXBpZCkgew0KPj4+DQo+Pj4gSXMgdGhlcmUgYSByZWFzb24g
d2h5IHdlIHJ1biB0aGUgYWN0dWFsIHRlc3QgaW4gdGhlIGNoaWxkPw0KPj4+DQo+Pj4+ICsJCVRF
U1QocHRocmVhZF9iYXJyaWVyX2luaXQoJmJhcnJpZXIsIE5VTEwsIDMpKTsNCj4+Pj4gKwkJaWYg
KFRTVF9SRVQgIT0gMCkgew0KPj4+PiArCQkJdHN0X2JyayhUQlJPSyB8IFRURVJSTk8sDQo+Pj4+
ICsJCQkJCSJwdGhyZWFkX2JhcnJpZXJfaW5pdCgpIGZhaWxlZCIpOw0KPj4+PiArCQl9DQo+Pj4+
ICsNCj4+Pj4gKwkJU0FGRV9QVEhSRUFEX0NSRUFURSgmdGhyZWFkWzBdLCBOVUxMLCBuaWNlX2hp
Z2hfdGhyZWFkLA0KPj4+PiArCQkJCSh2b2lkICopbmljZV9pbmNfaGlnaCk7DQo+Pj4+ICsJCVNB
RkVfUFRIUkVBRF9DUkVBVEUoJnRocmVhZFsxXSwgTlVMTCwgbmljZV9sb3dfdGhyZWFkLA0KPj4+
PiArCQkJCSh2b2lkICopbmljZV9pbmNfbG93KTsNCj4+Pj4gKw0KPj4+PiArCQlURVNUKHB0aHJl
YWRfYmFycmllcl93YWl0KCZiYXJyaWVyKSk7DQo+Pj4+ICsJCWlmIChUU1RfUkVUICE9IDAgJiYg
VFNUX1JFVCAhPQ0KPj4+IFBUSFJFQURfQkFSUklFUl9TRVJJQUxfVEhSRUFEKSB7DQo+Pj4+ICsJ
CQl0c3RfYnJrKFRCUk9LIHwgVFRFUlJOTywNCj4+Pj4gKwkJCQkJInB0aHJlYWRfYmFycmllcl93
YWl0KCkgZmFpbGVkIik7DQo+Pj4+ICsJCX0NCj4+Pj4gKw0KPj4+PiArCQlzbGVlcCh0c3RfcmVt
YWluaW5nX3J1bnRpbWUoKSk7DQo+Pj4+ICsNCj4+Pj4gKwkJaWYgKHB0aHJlYWRfZ2V0Y3B1Y2xv
Y2tpZCh0aHJlYWRbMV0sICZuaWNlX2xvd19jbG9ja2lkKSAhPSAwKSB7DQo+Pj4+ICsJCQlwZXJy
b3IoImNsb2NrX2dldGNwdWNsb2NraWQiKTsNCj4+Pj4gKwkJCXRzdF9icmsoVEJST0sgfCBURVJS
Tk8sDQo+Pj4+ICsJCQkJCSJjbG9ja19nZXRjcHVjbG9ja2lkKCkgZmFpbGVkIik7DQo+Pj4+ICsJ
CX0NCj4+Pj4gKwkJaWYgKHB0aHJlYWRfZ2V0Y3B1Y2xvY2tpZCh0aHJlYWRbMF0sICZuaWNlX2hp
Z2hfY2xvY2tpZCkgIT0gMCkgew0KPj4+PiArCQkJcGVycm9yKCJjbG9ja19nZXRjcHVjbG9ja2lk
Iik7DQo+Pj4+ICsJCQl0c3RfYnJrKFRCUk9LIHwgVEVSUk5PLA0KPj4+PiArCQkJCQkiY2xvY2tf
Z2V0Y3B1Y2xvY2tpZCgpIGZhaWxlZCIpOw0KPj4+PiArCQl9DQo+Pj4+ICsNCj4+Pj4gKwkJaWYg
KGNsb2NrX2dldHRpbWUobmljZV9sb3dfY2xvY2tpZCwgJm5pY2VfbG93X3RzKSA9PSAtMSkgew0K
Pj4+PiArCQkJdHN0X2JyayhUQlJPSyB8IFRFUlJOTywNCj4+Pj4gKwkJCQkJImNsb2NrX2dldGNw
dWNsb2NraWQoKSBmYWlsZWQiKTsNCj4+Pj4gKwkJfQ0KPj4+PiArDQo+Pj4+ICsJCWlmIChjbG9j
a19nZXR0aW1lKG5pY2VfaGlnaF9jbG9ja2lkLCAmbmljZV9oaWdoX3RzKSA9PSAtMSkgew0KPj4+
PiArCQkJdHN0X2JyayhUQlJPSyB8IFRFUlJOTywNCj4+Pj4gKwkJCQkJImNsb2NrX2dldGNwdWNs
b2NraWQoKSBmYWlsZWQiKTsNCj4+Pj4gKwkJfQ0KPj4+DQo+Pj4gV2UgZG8gaGF2ZSBTQUZFX0NM
T0NLX0dFVFRJTUUoKSBwbGVhc2UgdXNlIHRoZW0uDQo+Pj4NCj4+Pj4gKwkJdHN0X3JlcyhUSU5G
TywgIk5pY2UgbG93IHRocmVhZCBDUFUgdGltZTogJWxkLiUwOWxkIHMiLA0KPj4+PiArCQkJbmlj
ZV9sb3dfdHMudHZfc2VjLCBuaWNlX2xvd190cy50dl9uc2VjKTsNCj4+Pj4gKwkJdHN0X3JlcyhU
SU5GTywgIk5pY2UgaGlnaCB0aHJlYWQgQ1BVIHRpbWU6ICVsZC4lMDlsZCBzIiwNCj4+Pj4gKwkJ
CW5pY2VfaGlnaF90cy50dl9zZWMsIG5pY2VfaGlnaF90cy50dl9uc2VjKTsNCj4+Pj4gKw0KPj4+
PiArCQlkZWx0YSA9IFNFQzJOUyhuaWNlX2xvd190cy50dl9zZWMgLSBuaWNlX2hpZ2hfdHMudHZf
c2VjKSArDQo+Pj4+ICsJCQkobmljZV9sb3dfdHMudHZfbnNlYyAtIG5pY2VfaGlnaF90cy50dl9u
c2VjKTsNCj4+Pg0KPj4+IFdlIGRvIGhhdmUgYSB0c3RfdGltZXNwZWNfZGlmZl97dXMsbnMsbXN9
IGZ1bmN0aW9ucyBpbiB0aGUgdHN0X3RpbWVyLmggc28NCj4+PiB3ZSBtYXkgYXMgd2VsbCB1c2Ug
dGhlbS4NCj4+Pg0KPj4+PiArCQlpZiAoZGVsdGEgPCAwKSB7DQo+Pj4+ICsJCQl0c3RfcmVzKFRG
QUlMLCAiZXhlY3V0ZXMgbGVzcyBjeWNsZXMgdGhhbiAiDQo+Pj4+ICsJCQkJInRoZSBoaWdoIG5p
Y2UgdGhyZWFkLCBkZWx0YTogJWxsZCBucyIsIGRlbHRhKTsNCj4+Pj4gKwkJfSBlbHNlIHsNCj4+
Pj4gKwkJCXRzdF9yZXMoVFBBU1MsICJleGVjdXRlcyBtb3JlIGN5Y2xlcyB0aGFuICINCj4+Pj4g
KwkJCQkidGhlIGhpZ2ggbmljZSB0aHJlYWQsIGRlbHRhOiAlbGxkIG5zIiwgZGVsdGEpOw0KPj4+
PiArCQl9DQo+Pj4+ICsJCXJldHVybjsNCj4+Pj4gKwl9DQo+Pj4+ICsJU0FGRV9XQUlUKE5VTEwp
Ow0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICtzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7
DQo+Pj4+ICsJLnNldHVwID0gc2V0dXAsDQo+Pj4+ICsJLmNsZWFudXAgPSBjbGVhbnVwLA0KPj4+
PiArCS50ZXN0X2FsbCA9IHZlcmlmeV9uaWNlLA0KPj4+PiArCS5uZWVkc19yb290ID0gMSwNCj4+
Pj4gKwkuZm9ya3NfY2hpbGQgPSAxLA0KPj4+PiArCS5tYXhfcnVudGltZSA9IDMsDQo+Pj4+ICt9
Ow0KPj4+PiAtLQ0KPj4+PiAyLjE3LjENCj4+Pj4NCj4+Pg0KPj4+IC0tDQo+Pj4gQ3lyaWwgSHJ1
YmlzDQo+Pj4gY2hydWJpc0BzdXNlLmN6DQo+IA0KPiAKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
