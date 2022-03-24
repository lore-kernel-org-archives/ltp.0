Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B0CC433F5
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 02:22:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 140503C97E9
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 03:22:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7C533C9447
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 03:22:26 +0100 (CET)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com
 [68.232.152.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CED52600A2D
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 03:22:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1648088544; x=1679624544;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=s0bYBo3l6oAlxPDtoP5jJh2RNdYn68mt7zEIMLjSq8E=;
 b=y4r3qu9e1E5J4kbVQsVZVEddjHxdTLSfOMpJ8CgWKKo0W+JY0JM8xkbx
 MoqkhJPOV8xulgjAoF0+rdVUj02b1v4JrarwJl+qsUVvmFic74Ampi1XL
 6dz1XEhwagSbOEMGqSmj0XaBo4opn6d8NKGyIAVdXQP2HjibMnQ0FKPMv
 AzGT2v4wTLgHZNLJNzIXFnBctjyynrEIpkCGh4aj/r7MY9/0vKe/TdneD
 reV90AN40mrG3jov9SKursxcWbpQ5JE5q0SqdjmoF3i2o9kRHQWmEV4ry
 mp8u0F/g4/yGdJWaVmel3EsJeQEgkysiBfJp1+I4UYHNxAbV0Py4/T/k9 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="60590808"
X-IronPort-AV: E=Sophos;i="5.90,206,1643641200"; d="scan'208";a="60590808"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2022 11:22:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iH+BW4P98Ow4FN6J3xjSGe2w+FI8RJGxMIWhzD4AhGBMRUZGFgMKIrlDVL5oM/ObJnFDUHxfGxpBrqL/V9ILVM435y6jNAzOtxSXdWGgg1V+L++Fn/Q86lzuvx/cX/V1/i944mqPQa/pqrQctGwHEXgxrrZ7hTmnQxm/NnopJc8KsVN3wuz53CKhUtpDq0t5z3JzgzewQ8lefQ6LofWYGvkS+MN24jWsp71wDvfQCwazDClgGFoKG5qOHlfcHjd3ZrXAOFnlQpflUqeegxsVUBcPC3SK4cPxJNYOVUg0S3TAeUgSn1i8HNdGKbesgeonTP5TQpqNyz6ONH6awKBpGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0bYBo3l6oAlxPDtoP5jJh2RNdYn68mt7zEIMLjSq8E=;
 b=DvCn2oYIFiLx6HhxtQzJ1wSruNdMgHjL4rVDuBkz2WFx9NJn/86ofU7GMzU+t91TyNwpXsgyRqSxyYTXnkF92XHKNfGo5WRYPuOrlvDGm7ZA0TY0zsvpjZYcI/pSY0rFB/6hsBdaMh5QzlilsX43rl6E0sySmjuUQQt1Apt9r9qnrFfdhmAgduAd4yizJx1Ads8+8RDUX1OhoxcND6EJi1QYuMj9qUi46KM2pGccBxoMbypFLAlskSWP7sPx1e+MW36kG8Ut9+i6GeSQ5RGp4qhQME3qMGGdndew/8bl4Pga8dy3oNlBhFrp4xQi0XVXfHDjbndSUt7I4vdBDcqDKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0bYBo3l6oAlxPDtoP5jJh2RNdYn68mt7zEIMLjSq8E=;
 b=LPukVkIoepbaMy5VBukNZfaclw/KaeLLFBaW27duN29aLlYWbYkGqJyJ6woxVDAkXKrRN4c9BTUG5rQS+MwKKMXrgTN+WX6ux++uBJZiKBgr2f5sigQOM2yj9NXNXiONU7Bp+FMi+4+/zrdZXhoJMgUq53mt70PH1qf8wNU35Do=
Received: from OS3PR01MB6134.jpnprd01.prod.outlook.com (2603:1096:604:d0::7)
 by TYCPR01MB9384.jpnprd01.prod.outlook.com (2603:1096:400:194::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 24 Mar
 2022 02:22:20 +0000
Received: from OS3PR01MB6134.jpnprd01.prod.outlook.com
 ([fe80::21f0:c3a3:717c:3ce5]) by OS3PR01MB6134.jpnprd01.prod.outlook.com
 ([fe80::21f0:c3a3:717c:3ce5%3]) with mapi id 15.20.5081.023; Thu, 24 Mar 2022
 02:22:20 +0000
From: "daisl.fnst@fujitsu.com" <daisl.fnst@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v3 1/3] Add SAFE_ACCESS macro
Thread-Index: AQHYOpVKJz6Vgs/JAEuKABpA5L5Zy6zNYiQAgAB0qQA=
Date: Thu, 24 Mar 2022 02:22:20 +0000
Message-ID: <fb43d0ed-ca9e-e777-a6f0-06c4d898a19d@fujitsu.com>
References: <623414B7.6060004@fujitsu.com>
 <1647629747-13405-1-git-send-email-daisl.fnst@fujitsu.com>
 <Yjtz/oUOMBarvd8t@pevik>
In-Reply-To: <Yjtz/oUOMBarvd8t@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0c557fe-6b24-44ca-fcd8-08da0d3d1fc7
x-ms-traffictypediagnostic: TYCPR01MB9384:EE_
x-microsoft-antispam-prvs: <TYCPR01MB93846FAE8205D1BA6710957C85199@TYCPR01MB9384.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V4/r/xQXAvBWWNAnmJGN6tqr5qa0ywYZRJq+X0y6zseGE/YV/awHAVd+kD129k/9TJdv4eZMeIa2HisJcQPhQHPXDa3QAMaACuk28gJ+VZg1qI4bUP3py+E7WHLpgLIeGAnruRY9fIg7bexczFI/NLtRXtdga5WbvhxqXcygSqdv3LY6C+lELxRc6ZvXB7Yn5g32Jg0/oRWlnKgaCtua0ei0Koq0Mi1hBKhJteH0CDnpFCm6Kg95ZlUrvmO/0e10Yb6E4dO+6BrDmKaH2E9CgobvZzf3T0aCnpiQxbfm+gBAQCb+o6D7eyblDGO5oNHechHZ/eLD8gh5WhlBugU1aP5Tcd/k1SYtCNUcywIE/LyLAf0WXILUPi/lHCM5meHlfCE1ld+iBunvAFDbJzDNFUuIklJMZZtB7e2VQDKuyJeqM4hG1Be6p8DI4Ie5GdZIbTYpdew42T7eB9n55zCwXfAa75JzhohF6V094yjnlbbka91ZcX1lVTJKA5gxd19Me0f0fhgh+sxAmyMmCorxjKSzCCsWri2xqTTp5+Yic4ufgHfrqJaWNKKfJZRpBWOYaVxDhRBQ6gAZO+YxtLmc25akm1X+fhT8XdZj2YGTxe1jb9C5yfAZZ+mUrZuAnCxl3J8WGk0RNM86/OZAElQDyTAN1ruJRe7ssokQBCCqL/kaisAR7c8tfJUX2ksx/VpFh6RUmOl05slsZeXNQeKciH+ncSm1YuQHKZ/eegvi33CiwvjrKURE+0j9ko5pos/ts0fYPMcpWKKeMWTpaCDChZ3BJTXPRfWeT1+Gi1r7BUxnwIhYqvJIEtEgwWGWMoyx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6134.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(82960400001)(122000001)(38070700005)(31696002)(26005)(86362001)(38100700002)(6486002)(4744005)(966005)(5660300002)(6506007)(66946007)(66556008)(4326008)(2906002)(316002)(66446008)(66476007)(91956017)(64756008)(76116006)(8676002)(508600001)(8936002)(36756003)(71200400001)(85182001)(2616005)(186003)(6916009)(31686004)(6512007)(54906003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TXh6S2E2Q2w0SmdTVSt0QVp0dHd6ZFJKdFBlS3RzNjV4SmNmNXJkK2tTSlk2?=
 =?gb2312?B?ZUdVVkhKRzl0KzlZZjEzUzMrMUxMZmIveWh0RE9nT0dNQ21OaWd3NkMxWHJo?=
 =?gb2312?B?OW9DQUowR00xRk41VWNCNUpEeDFCd1M5T0hGWktaNEFDWm5sdnVBTFJiejZZ?=
 =?gb2312?B?L3NTeTNVY3owZUtmd1dEUVJDdkVzejZBUDlSSTZSc3FPNzM2ODZNWlJzbU94?=
 =?gb2312?B?RG45QWVPRzhHVVRxSkx0bWVCeHYrdkNsc3dnMXpydVpheGJsdDBUdXh2OGhM?=
 =?gb2312?B?dXh2dU1IV3grcVVNSXZwcVpDaUlXV21tWFAzMHc1VG1YN0ROY04rellLTE9Q?=
 =?gb2312?B?L2lPeHN6YlFNUjhwMXFnaWkxV3pKdUpISjlwNGFZdmFHQ3ZLS0pERFRUQWJ4?=
 =?gb2312?B?cEw0VkZjYWhnNVNhWVFoemhQNkFFVVFyeG1EYllOcVF3QjNpVDk0eHIreWsv?=
 =?gb2312?B?ZVNWYkhtVVNsL0VSVnFTR2huNkNJUFNZaHc5eFpIamxzU2g3MVR4U21VSXlT?=
 =?gb2312?B?MFQ1elFlM1lsbzM0VlQ3V2U4N2l3SEpac3V4NHNTd0QxSFh1U1d0WnhyT2h6?=
 =?gb2312?B?ZEkyOG5scmpuWXUvMjZFOU9FcE5wWm10UVU5QzJ6UWxMeENnQnpmQ0o2V2xo?=
 =?gb2312?B?MW9YY2VWekV2VHltOXFMckVEQmtIVDdtVDRyL3o1T2FDSUxqR0kwQ1FNbXIw?=
 =?gb2312?B?WGt2S1lHbEtyenNjM2dYZHhuenVSYVhsNVpES1V2VVp1blU2aDY5T0RMODVF?=
 =?gb2312?B?QTdscWNOSkFkcjFveHc5SjVpRDl4eTNLVVp3Yk9JN1hsYVVtTW9lTzlvWncv?=
 =?gb2312?B?VXloVU50azI5MU9EM3lGd1BiaXB1K241TDQyYTVOY3dsM3FFN1U2TGVqanp3?=
 =?gb2312?B?c1RBMGFNTG11MGVUS2x1NjBGL0ptcUY3MGRyZFdhZ2VrdXIyY0dlSm9uT1Qw?=
 =?gb2312?B?R2xKRHRZbWU1Vm80UGFhNjlZRm84bHdGTVZvWFNJV1RJNnA4VlNiNkFmMkY0?=
 =?gb2312?B?OUFrbUp3MGROV0REc3pTUzNYb3ZmNGdsMGU5ODlTV20vdXQ2Ny93di82bm11?=
 =?gb2312?B?OUl2YUdSVmZHem5zdmZZSWR4OEgxWW9DcHVLUUo5cTVUakNLazlGTmxVRldu?=
 =?gb2312?B?TURCVHBuSWtUREVUSmhCQ0pHdEVZRVVYZFpITTZsblFUVUtGVVlLTmZyRnlB?=
 =?gb2312?B?dXNBTW9qWjkram9wTjRoR3dqUFdsZTJaVVFMenRKU0JsU2R1WEZKYzNpZjMz?=
 =?gb2312?B?MWlPZzRpUzRBZ2JmK0VJR3pwTDdabUk0LzQySDNHWUpwallhYitZcnB2WkN6?=
 =?gb2312?B?Q2NyeFVZK2NkaXBKL0FjUW4rVURZcHBmV3Nob3d0NnFtKzU2WUxCNmY3bVZ3?=
 =?gb2312?B?eXU4RzhjTU83SVAyTGJrWGFNR3F1eVErMnl0OWdKcm9WeTc3TFZ1TjRKVTBa?=
 =?gb2312?B?Y05zWW9WRFRMNlkyVDlwV1lXdW5zM0dUdlkrZGdJbkUxWkRIVnYyNmFXVjVI?=
 =?gb2312?B?L01RWVB4a2k5UjM0dVVqanlta3ZGeFlIelVVa3BjcDdWWWRiYmdnZlN0TmVm?=
 =?gb2312?B?TXNlQklCck0yaVdjeHZrZkFvcHdLNnk2Z1pCUURCL0puVVFVNXgyQlBoWU45?=
 =?gb2312?B?OVp2ZFhqV011TXZjdGZRK3E0cVdPdjZXa2djRUtjUk9va2o3citVVnBLY1Vn?=
 =?gb2312?B?MFk5VXRNZjkxUW9rY1pENUNZOElGM25Nd3Z5UDNoWk1uczM0WFppYWVFQ1hW?=
 =?gb2312?B?Z1RzYTFSUUErd1NDNGljWUNYeUJMV2p4T250R0dCOHRRang3NHhLS2gxOTdF?=
 =?gb2312?B?dUpCeVNybGtDNVRBcHR0cDFPdDBoWGFBUERuRFhNMjRJRjFtMVgvdUd4RWNU?=
 =?gb2312?B?eis0ajRvbTREK2VSMEZ2aVFxd1hiZnlHL2JadUdreDNJZzdDSTRVMXJpbzU2?=
 =?gb2312?B?eFA4VmUwUUN1eWRFaXJITnpMWjN1allJVzhUbTh2REtCdXQ2Sk9MS05oUkFy?=
 =?gb2312?B?Q3Y3VXR2eUJ3PT0=?=
Content-ID: <A561E7299FC62649B37B2C1A074DF6C1@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6134.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c557fe-6b24-44ca-fcd8-08da0d3d1fc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 02:22:20.3087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ehZr6T5YlMK19DWzAnwtiPWkLUXeft/Edt8BAmPufOA4t5zN+GZ+S0R6qlw3TPk1rFp7yhrUhncSVZ8I1EUPCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9384
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] Add SAFE_ACCESS macro
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
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwNCg0K1NogMjAyMi8zLzI0IDM6MjQsIFBldHIgVm9yZWwg0LS1wDoNCj4gSGkgRGFp
LA0KPg0KPiBSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+DQo+DQo+IEFs
c28gYWRkaW5nIFh1IHRhZyBmcm9tIHByZXZpb3VzIHZlcnNpb24gKERhaSB5b3UgY2FuIGRhcmUg
dG8gYWRkIGl0IGZvciBuZXh0DQo+IHZlcnNpb24gaWYgdGhlIHBhdGNoIGRvZXMgbm90IGNoYW5n
ZSk6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC82MjM0MDMwNC4xMDAwNTAwQGZ1aml0
c3UuY29tLw0KPiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbHRwL3BhdGNo
LzE2NDc1NTA4MTMtMTk1OC0xLWdpdC1zZW5kLWVtYWlsLWRhaXNsLmZuc3RAZnVqaXRzdS5jb20v
DQo+DQo+IFJldmlld2VkLWJ5OiBZYW5nIFh1IDx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPg0K
R290IGl0LiBJJ2xsIHBheSBhdHRlbnRpb24gbmV4dCB0aW1lLg0KPiBLaW5kIHJlZ2FyZHMsDQo+
IFBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
