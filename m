Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0941CC00140
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 08:21:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E60283C94DB
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 10:21:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF90B3C1BDC
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 10:17:14 +0200 (CEST)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20060.outbound.protection.outlook.com [40.107.2.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 836031A003F1
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 10:17:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ub9SYnn8Nj6jeW1d+LyC/P/yRRK+/ZtDyBPsmx32X4hYw607lexdALmFsPNz+6Nn0bKk/kgN+KAupHRxS6EtcRo5tROfKaw9QPSEFKp0ssSIq+CvmH6r9Cdq5Q+HOtcejyj6k49SSgM/RWiuXGgY+LqQYN80YWYlCyRhXddoiILyh6May0Mb8suLjtnTFFO629mWPURhYVSQ/JFjw9DgmV0Etbp1Kcj8wPWjiu8+vwycLNcqhqN/iCCLKUWc3K/MNPvKwO7CaW4PNJAa6/B7F+CHzAvGA2ApOh+Z3Q/XHNUWONLRALe30qDoC5CQjRFJeou1YhTbBJF7PAqfJGn/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIhb1Hxuo0KJ/0Tr+ge4a3BTQWa3qLEPzqrRH5r36Yk=;
 b=m8kYNzsPYojfY7+89Jv/6Bu2baOOEfqzheghXkw9z74xTJvE3xQhy4DEz1wxkQkBpGVuJUxSwIm2abW4BrCgZ+wWG8ts25/iZ8Baa/kYJupA10wtB+9T2skxHmV8/e0vTmjzrKoJ8iyI7kG/4YKZZuzNtCDOMmE4ob6XLuGNpsJn9shLIyHYtvBWdU+hv6ZQALeVLMKccnTIQcnt5btAl851bxviXQ1JOWzwSo++l5Y4w+GyBQ5wfszApO1zMUPYBapYGIPe5SXk6yI44hqUjWm5MH0T8qRRQ9SXlNSFBK8RW6USg4N8zO11jpdX41wyoc2ImW8Q+43ShM9Sz/2qaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIhb1Hxuo0KJ/0Tr+ge4a3BTQWa3qLEPzqrRH5r36Yk=;
 b=lMCjahsuIKBRxUvSMNtel9AVXJOnJOeoGkthyDkN/9X5OnZ4NpIsYtvb0SkibfjHyiWRff6JJjQsPytJUxH17c+WZuV3Hw+huJmaUwvZQ1aD6K3z58ZfG/yqAsch1Zaa4vIwRIHO2gkwryvgZL9tZ8AgTaYngJ9XFkunG/KwpWAxpN1gWLpEZ0KnkfDQJURyIj+wV9BLp4Mj0lTLSg+Tr0H0X5xXgq8tv4Mu+dm5c5TBermqEa4CikaXTS6zLif4r+Hoq0uALRZ6+G/agslscjqQIEezoZZQ/rGPfmnEaakT72SuiFc35doA49VDoDzT+mxTrJqOqqoJUB6PttaCow==
Received: from VI1PR02MB6189.eurprd02.prod.outlook.com (2603:10a6:800:18f::17)
 by DB3PR0202MB3290.eurprd02.prod.outlook.com (2603:10a6:8:c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.19; Mon, 8 Aug
 2022 08:17:11 +0000
Received: from VI1PR02MB6189.eurprd02.prod.outlook.com
 ([fe80::b867:dd69:7f2:22da]) by VI1PR02MB6189.eurprd02.prod.outlook.com
 ([fe80::b867:dd69:7f2:22da%8]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 08:17:10 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: Duration run time of each benchmark 
Thread-Index: Adiq/rkDZuFOG0DLQ12YkIUA9VM42w==
Date: Mon, 8 Aug 2022 08:17:10 +0000
Message-ID: <VI1PR02MB61896EFAC4D92D36C0723295EA639@VI1PR02MB6189.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-processedbytemplafy: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca1f0b4a-ae8c-401f-df6d-08da79166446
x-ms-traffictypediagnostic: DB3PR0202MB3290:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RBWmABPaosQY3IvmTsbOV5VysywjWebomIvts5X9hna7LGs9IGaNwy1IXCiuxRdFBcRbaaW3lCZ/vwDAc3syI+ZkSkRFO7yLjmnQuTkDkfYcK0ZdeYzksqu8SkXuuoZTFZL3o2h0pLk0U9JHNXFdf3cV+eujVhAfDgsslJ+bSVFKzKXiP4NhG0Zu8wNcvXGABluUeR4J4WEyarW7tLg3OnKzKyoy7KalYmbvZmY9/NkELp4GWhqk1xvu5uXE9cYDlNcxQHNzjSzMfgQ5BrQB1vi/c6Zwn6/cNFfsQTp0m6bBm9fA7fUs94xqB4q03DWSFVkTEHAW3Sl9PpzLkSUiYf01XKHmjSrA6eFwbPi5qJ6EhKQjQp+3fC7gtgkoF2qUkTmKykRWgxVZIKbflufRfkn1rM/ik4j5qVvyK5TajxpzOvuO6rhu+rBywQOrG6Q21gMV7/Q5iICUTHOAy1HZeZ/Anw1eviUNuiIMX+swHRiD5vxSKVuYmHrZ6BwNWJ4ErGgnYITMNnG8TiaQe3lFrwAcWXEW7/NyExtYWAbJX8F/8+u8bJSt+JDoWVY/H6vtQm/2s9BuRSzHFITHnikMpeiN7ClR8d4ehhdnOOrojlRBD+ddMEeuSDHboGYcf8ZlfcBJ1DmG/o25lFjUrG33vov/qZN/yCt4DgwYzPptBq7YFdXXdfRjry06jGEh/ixvZtmWT+2j08LZ/n5WVsUTIRqH8Smd5wKldzKvyeqX6rxAOuKTSa8cGA5x/coKVl8fYR/LLnx68ikqPpilbeb5yxBTtPkci6f8ZOmVpuzqb/zD15OQjd5AAlyzdiiFe+K0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR02MB6189.eurprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(8676002)(186003)(66446008)(38070700005)(122000001)(38100700002)(76116006)(66556008)(66476007)(6916009)(66946007)(64756008)(316002)(86362001)(7696005)(5660300002)(4743002)(9686003)(26005)(8936002)(71200400001)(52536014)(558084003)(41300700001)(6506007)(55016003)(2906002)(478600001)(82960400001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vzh6Z2dsUmNBZzV5QjZNOTh4S210TkJZNTF0T0ZoRGc5eEM0bFJra2RWdzlF?=
 =?utf-8?B?RXhXaTFHeEg3a2YwMU4vRDd4YzdsTzNVYnllNnYzUy9FMjFTL0t5d0g1VTJL?=
 =?utf-8?B?VnM2UXc5RTkwbllUNG9tVjE2MmhDSllHRW1VMG1jZGoxNXFwV09GamhCd0Ns?=
 =?utf-8?B?V0xNL1RBQTRGQkwyMXRhemgreDVzUmQwQUZkamxLTWlKQy9ySGNzM29LeTlh?=
 =?utf-8?B?V2txemxyVFV2eGkvQ3FucnlZaFdrZU5jUzYxbXh3cjNPWnN1QmJKYjdvRmZm?=
 =?utf-8?B?RWJwZW5TcWNSV0JFNnBjRkdHWkRzN1Y5cGxESm1xcHJ5S2Q4a2RrYXFoVU5Y?=
 =?utf-8?B?Y3lBUEtJcER5NXdsV3duTWI3QWZRbFI0RDZRaDFBKzQzS0paTjFQUGlYZ29k?=
 =?utf-8?B?Y1BaNzFDVE15TjJGZ045L2pBUUdpYlJ6RXhmd0dHSStQc3RoeGIvcDFQdW0z?=
 =?utf-8?B?bW45eW1ybEhmeHFlZGdadDAxVmFvcGoyMWkwUU5odGE1aDl5bnhZdlNrcVRl?=
 =?utf-8?B?MHdVWkZwaVdtMzB5RHVyTnY1cDViM1Zqcm1uR0o3UnByTUo4bUZmdG9Dejkv?=
 =?utf-8?B?WnkyMlMyRmNMZFR0ZEV5WkFSS09ZMEE3ZUF2aVJNQTgvdEhqaTNpRDh6Sk1O?=
 =?utf-8?B?ZDE5QjBCTHB2ZVpIWStSMEZWOXNkdXl1UmpRYmZMY2JNME1CQStKWDRkdURz?=
 =?utf-8?B?aHZiSk9CbTNVbFgzR1B4d3ZickRxM2pqRlI0a0JBcXVZbk44Qk9LY01PMnQ4?=
 =?utf-8?B?L0h2Ty9reWdCaW9TUzF5QUFOUDhxdjB3MVpIcXFFRUp4bzlqclNxbDQ4QjlR?=
 =?utf-8?B?M3plbTJKS1RuaE9yTEduRXJRakh0amRpYlpKWnRpK3czNCtwSXVZVlJIL2Fm?=
 =?utf-8?B?c1pCOS9meFpPalhOclhPY3hzUEZrSklWMWVMaDVCWmVQMWp3WWJoQ1p4TUh0?=
 =?utf-8?B?aElwdHY2VUFCUVBGZTJXcHhMN0h4SDlQV0YvV2x2bVZZUE5VVHJUS0QwdXFR?=
 =?utf-8?B?Z0grbi80cjNxcjY5OWdkMkdKSW95MHBRVVFWTFNmZUticWVLSnlOQVltSUhX?=
 =?utf-8?B?VTNrRzFnSy9WRStIQ3BmYUpabDlSTnlyaFV5aXltU3ZPZ1VDQ2JrU2NKYjBD?=
 =?utf-8?B?Q3lLZnYvckhjV0krbjluRVN6eElEOG10VUdXaVYwQ1dvcVplb2xZWjhHazNL?=
 =?utf-8?B?aXE5MHRNZFY4ZHN4RHIyaXQrUExGOFdqZC9Ra0pyN2VKUFBGSnVOYjVpM3NZ?=
 =?utf-8?B?Y2dmMkM5R25MenVka0VlYnVLdDBINUlGSVZIWEszRXgrL0VPWTJOdW5HU3J2?=
 =?utf-8?B?SUFqTW1ZeEpuL25WZlZiVGVRZ0hEbWNTY01nY2ozZHJNRU5QS2lJemhqV1ZV?=
 =?utf-8?B?Y0VEc0JyQ1FDcGZ2RktrWTdpRFB3d0Vjci8xRm9UTnc2KzlVY1AxS1dvanpx?=
 =?utf-8?B?L0FLTEVLK1diL0R3ZnFrWDJFd0NBdUF1OW9uQ2l3MTNuNlRwR3ZFcENNRlJG?=
 =?utf-8?B?TzEzR1FFUlRyR0xkRWVDY05PWDAzTnhFL0tVR09uaWh3N044Z2FqeGFNb0J6?=
 =?utf-8?B?VFhOODg4T2xudk1OQkhzbEdMNitBdXZkenRGUVN0cGxQWGllaU9FeXltQ3VO?=
 =?utf-8?B?WFF5V0pXdElqNWQxdXBVOGlINmd5SWhGY3QyQXRJeGpoVTRaQmJkVndaK0w3?=
 =?utf-8?B?ZEJGNDhVT21kQ0NTWDFkcXAzT2U2bkhuMmFPT2pPWmk5SGhTOTVuTGZyY0p2?=
 =?utf-8?B?Wm1vaWJUK2VMMmtGYU15dE1QQmp3Z1ZNT3dHZzQwVFUzSGUwU1Y1MUJ6QmV2?=
 =?utf-8?B?QkJ1U2JMdEcwVlhVaWtYWWg5VFAwKzNKNVA1Y0czSGRMQ28rTkpvazlZUGti?=
 =?utf-8?B?eXBESHhmaHpiODdRc3FCdU1wTExNY2szWCtpenJibC8zazd5SlV1V29YTkZi?=
 =?utf-8?B?SXNDMEJTMkloaUUrM3A2cmV2RFdGVm5oMEpNcUtsSGJoYlpYUWhlT3ErTll4?=
 =?utf-8?B?T3FzNlY3U0FiSFo0RzRkZ0JxTmdXelNZR002YnJIbGE5a1pZK0gxNENnUUhu?=
 =?utf-8?B?cXFOcTMwNnZOUjVFemNNWWlBWWMwRE5Nakx0RWRjRjR4ZnlMM2xPTDRCdnY5?=
 =?utf-8?Q?sPo9nter26qHFjCUlxIGN3NrY?=
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB6189.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1f0b4a-ae8c-401f-df6d-08da79166446
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 08:17:10.4329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X+vaIC4Sn5wraGfPSkOfrnWNXFLsLpxOg8bb5YMhm6Z97y5y7S/0+Am/u3cv5g/lt0ttClPHd/SyD72p+k80Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3290
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 08 Aug 2022 10:21:02 +0200
Subject: [LTP] Duration run time of each benchmark
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
From: "Chen, Zion via ltp" <ltp@lists.linux.it>
Reply-To: "Chen, Zion" <zion.chen01@sap.com>
Content-Type: multipart/mixed; boundary="===============1789129367=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1789129367==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_VI1PR02MB61896EFAC4D92D36C0723295EA639VI1PR02MB6189eurp_"

--_000_VI1PR02MB61896EFAC4D92D36C0723295EA639VI1PR02MB6189eurp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8gTGludXggVGVzdCBQcm9qZWN0DQoNCldlIGFyZSBpbiBTQVAgdXNpbmcgeW91ciBsdHAg
YmVuY2htYXJrIGluIG91ciBsaW51eCBtYWNoaW5lLiBXZSBhcmUgbG9va2luZyBpbiB0aGUgcmVz
dWx0cyBmaWxlIGFmdGVyIHRoZSBydW4gaXMgZmluaXNoIGFuZCB3ZSB3YW50IHRvIGtub3cgdGhl
IGR1cmF0aW9uIHRpbWUgb2YgZWFjaCBzdWItdGVzdC4NCkNhbiB5b3UgcG9pbnQgbWUgaG93IHRv
IGRvIGl0PyBIb3cgdG8gZmluZCB0aGUgZHVyYXRpb24gdGltZSBvZiBlYWNoIHN1Yi10ZXN0Pw0K
DQpSZWdhcmRzLA0KWmlvbg0K

--_000_VI1PR02MB61896EFAC4D92D36C0723295EA639VI1PR02MB6189eurp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6eD0idXJuOnNjaGVtYXMtbWljcm9z
b2Z0LWNvbTpvZmZpY2U6ZXhjZWwiIHhtbG5zOm09Imh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5j
b20vb2ZmaWNlLzIwMDQvMTIvb21tbCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnL1RSL1JFQy1o
dG1sNDAiPg0KPGhlYWQ+DQo8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9
InRleHQvaHRtbDsgY2hhcnNldD11dGYtOCI+DQo8bWV0YSBuYW1lPSJHZW5lcmF0b3IiIGNvbnRl
bnQ9Ik1pY3Jvc29mdCBXb3JkIDE1IChmaWx0ZXJlZCBtZWRpdW0pIj4NCjxzdHlsZT48IS0tDQov
KiBGb250IERlZmluaXRpb25zICovDQpAZm9udC1mYWNlDQoJe2ZvbnQtZmFtaWx5OiJDYW1icmlh
IE1hdGgiOw0KCXBhbm9zZS0xOjIgNCA1IDMgNSA0IDYgMyAyIDQ7fQ0KQGZvbnQtZmFjZQ0KCXtm
b250LWZhbWlseTpDYWxpYnJpOw0KCXBhbm9zZS0xOjIgMTUgNSAyIDIgMiA0IDMgMiA0O30NCi8q
IFN0eWxlIERlZmluaXRpb25zICovDQpwLk1zb05vcm1hbCwgbGkuTXNvTm9ybWFsLCBkaXYuTXNv
Tm9ybWFsDQoJe21hcmdpbjowY207DQoJZm9udC1zaXplOjExLjBwdDsNCglmb250LWZhbWlseToi
Q2FsaWJyaSIsc2Fucy1zZXJpZjsNCgltc28tZmFyZWFzdC1sYW5ndWFnZTpFTi1VUzt9DQpzcGFu
LkVtYWlsU3R5bGUxNw0KCXttc28tc3R5bGUtdHlwZTpwZXJzb25hbC1jb21wb3NlOw0KCWZvbnQt
ZmFtaWx5OiJDYWxpYnJpIixzYW5zLXNlcmlmOw0KCWNvbG9yOndpbmRvd3RleHQ7fQ0KLk1zb0No
cERlZmF1bHQNCgl7bXNvLXN0eWxlLXR5cGU6ZXhwb3J0LW9ubHk7DQoJZm9udC1mYW1pbHk6IkNh
bGlicmkiLHNhbnMtc2VyaWY7DQoJbXNvLWZhcmVhc3QtbGFuZ3VhZ2U6RU4tVVM7fQ0KQHBhZ2Ug
V29yZFNlY3Rpb24xDQoJe3NpemU6NjEyLjBwdCA3OTIuMHB0Ow0KCW1hcmdpbjo3Mi4wcHQgNzIu
MHB0IDcyLjBwdCA3Mi4wcHQ7fQ0KZGl2LldvcmRTZWN0aW9uMQ0KCXtwYWdlOldvcmRTZWN0aW9u
MTt9DQotLT48L3N0eWxlPjwhLS1baWYgZ3RlIG1zbyA5XT48eG1sPg0KPG86c2hhcGVkZWZhdWx0
cyB2OmV4dD0iZWRpdCIgc3BpZG1heD0iMTAyNiIgLz4NCjwveG1sPjwhW2VuZGlmXS0tPjwhLS1b
aWYgZ3RlIG1zbyA5XT48eG1sPg0KPG86c2hhcGVsYXlvdXQgdjpleHQ9ImVkaXQiPg0KPG86aWRt
YXAgdjpleHQ9ImVkaXQiIGRhdGE9IjEiIC8+DQo8L286c2hhcGVsYXlvdXQ+PC94bWw+PCFbZW5k
aWZdLS0+DQo8L2hlYWQ+DQo8Ym9keSBsYW5nPSJlbi1JTCIgbGluaz0iIzA1NjNDMSIgdmxpbms9
IiM5NTRGNzIiIHN0eWxlPSJ3b3JkLXdyYXA6YnJlYWstd29yZCI+DQo8ZGl2IGNsYXNzPSJXb3Jk
U2VjdGlvbjEiPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPkhlbGxv
IExpbnV4IFRlc3QgUHJvamVjdDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiPjxzcGFuIGxhbmc9IkVOLVVTIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+DQo8
cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+V2UgYXJlIGluIFNBUCB1c2lu
ZyB5b3VyIGx0cCBiZW5jaG1hcmsgaW4gb3VyIGxpbnV4IG1hY2hpbmUuIFdlIGFyZSBsb29raW5n
IGluIHRoZSByZXN1bHRzIGZpbGUgYWZ0ZXIgdGhlIHJ1biBpcyBmaW5pc2ggYW5kIHdlIHdhbnQg
dG8ga25vdyB0aGUgZHVyYXRpb24gdGltZSBvZiBlYWNoIHN1Yi10ZXN0LjxvOnA+PC9vOnA+PC9z
cGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIGxhbmc9IkVOLVVTIj5DYW4geW91
IHBvaW50IG1lIGhvdyB0byBkbyBpdD8gSG93IHRvIGZpbmQgdGhlIGR1cmF0aW9uIHRpbWUgb2Yg
ZWFjaCBzdWItdGVzdD88bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij48c3BhbiBsYW5nPSJFTi1VUyI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPlJlZ2FyZHMsPG86cD48L286cD48L3Nw
YW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPlppb24gPG86
cD48L286cD48L3NwYW4+PC9wPg0KPC9kaXY+DQo8L2JvZHk+DQo8L2h0bWw+DQo=

--_000_VI1PR02MB61896EFAC4D92D36C0723295EA639VI1PR02MB6189eurp_--

--===============1789129367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1789129367==--
