Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD729CD11DD
	for <ltp@archiver.kernel.org>; Wed, 27 Mar 2024 01:26:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C05A03D17FE
	for <ltp@archiver.kernel.org>; Wed, 27 Mar 2024 02:26:37 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 451F93CFB9A
 for <ltp@lists.linux.it>; Wed, 27 Mar 2024 02:26:15 +0100 (CET)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazlp170110000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c407::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5ADE11A0036B
 for <ltp@lists.linux.it>; Wed, 27 Mar 2024 02:26:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmRWcxME6nKC5Jl2avn4aBwTkUOPOgA/MtbWjLEnUkxurty8hDcAVHClH7LhGxkbYxQS4OUBjHt/m6MK7taVe6oS3Lm7sEU6Yy+OqGWj51yPwlml6zpnYpXepu0ZVZVkn6zR+MIrQXzoS3NZgOgnjHbajSZqh+Tch27G2w4ZZlo0kwztoY9BY9BcLiUl/l6ltlhJnwQ6NxfiUDvrO+M9qCTWdpbcaeTsCrBCgWpNecB99dPDAiZFucVY03/t/jrumvGckIDJ1+zGTcB8u1dB38OFBxUGsrZ61aCEi5jobZP/bDRD6SYfUjCZcnQQCTlP8mVEeFTFQd7fwN6NNIaEGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3c50g+1AtVxlT5TIERg7BUvqE3SswwIS7Krs4v0POc=;
 b=HH7D00ZnwOeBq78QLQCsfHAf7pGNril0Hxp3AXXsaOTrpIpE3Xndsfc++DzuxUPCybxQ2vsFRJ1cbcqrApwDUw8WsOLazGYEVOQWxrfKVI1q95wj/j4anfhBNiDUzca0Apf/xxCug4txTdlheIHHWL54iFuPl3C/1iSvdALfhbcWLZvlXIpAYi83QPN617wXbU7iKx5/4uVggZvTUNJuVV7PuXWGCWom5UJmeXOEGIw+BgT1jRUcrgkjXgq3YPGnToEaVGHt41g1czWm27XpqvY9aa3X7+Th5tRbQzK7cBnA22wibUzmCraCLM5WYA1chPscHp6VKPfj89h9hOpNiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kyocera.jp; dmarc=pass action=none header.from=kyocera.jp;
 dkim=pass header.d=kyocera.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyocera.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3c50g+1AtVxlT5TIERg7BUvqE3SswwIS7Krs4v0POc=;
 b=EGXvBrNPTn5tdDDhQ/+J3dDGMM71R7zKWCjDrfyim18UFjWnjN08eKWivUMZWezG2JOShvTeoKKjtlFvpqwVZzLgWamIOAw0DiWF6WTlfiU90xoGpE7N6N5lxelhOQ26LZ/dU5rFXaJqrvIRKjndoC6J7OQllv8UVxRe9yTMnjQ=
Received: from OS0PR01MB6033.jpnprd01.prod.outlook.com (2603:1096:604:cc::13)
 by TYCPR01MB7161.jpnprd01.prod.outlook.com (2603:1096:400:f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 01:26:08 +0000
Received: from OS0PR01MB6033.jpnprd01.prod.outlook.com
 ([fe80::7d0b:f7df:2176:4b94]) by OS0PR01MB6033.jpnprd01.prod.outlook.com
 ([fe80::7d0b:f7df:2176:4b94%6]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 01:26:08 +0000
From: =?utf-8?B?S29ndXJlIEFraWhpc2HjgIAoIOWwj+aaruOAgOaYjuS5hSAp?=
 <akihisa.kogure.ke@kyocera.jp>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] input_helper: Modify the check range of the input
 event number
Thread-Index: AQHafxO5ma/8HTEuSk2Ev/pVwAh9LbFKFEiAgAADwACAALFqvg==
Date: Wed, 27 Mar 2024 01:26:08 +0000
Message-ID: <OS0PR01MB6033D024FBB112A98DC3104AD9342@OS0PR01MB6033.jpnprd01.prod.outlook.com>
References: <TYAPR01MB6044D2E0749663D84DE1F395D9352@TYAPR01MB6044.jpnprd01.prod.outlook.com>
 <ZgLaddvHSGVBhnU1@rei> <ZgLdmj2fx0PQzHgO@rei>
In-Reply-To: <ZgLdmj2fx0PQzHgO@rei>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6033:EE_|TYCPR01MB7161:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k+RW6I6l5Wh85tHA20DZHkU4PoWSxlb7KJL8c5nmBfB8GQDOsWAgOm/ZT1SdHL99AhQZRw7E8sT+XCYxSZYnYfJ+tzmaYU2XcBQ5wLlCR6BumVz/WrMNScsVlc0eUt4jWnU7RbBxy/BWgQv9+qGrHtgVY2hLJw0UXKX+ENnZdgQU/UGADCqSEmdyYZQVCXAbXZGmp3IxJ9FsMPY64g/aiAYxDnnwm3BmXBxNkL7AJKXWak50VpZ6QCBvvA0arE1sOJzGL/ibAthie+Jdakm25rGt6V9+amSyAxWAupx5+1X7Rc3HzrLQwD9wa+xRFJdNeznMS25roqsNUhUV5udIpK11WNW1tboEad6Cbmr4EHt6FdPOs34NqzAabWIwZ+kE4tbNTEfcXGpUPT5+7lh38W//1Bs08aWkw8YpbKxb1f4QFxBh1NgjCBy9SaF7eAsuOo8IUfyYU9LbkP6ZjALgGaG/hGp6TxvKfHDT4Ue22fclmcgzmfxF9WdY8K507vTOUDtUB1xIY1zC/l6yWzyRQYD4U3GW1hAOQhMPOMzAYGSR9n9fMdpc8K27wDI2uILeHvx0nrRg4Fm40f1bFh7k4bmiUdRQpQTiaAWc9vbkM8w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB6033.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmdLZG55WmtRaFY5QXp6aEhEN3JqZTkwK2lPbk5WTVhvaklFdWVtWDZObDdH?=
 =?utf-8?B?SmtIaC9DdXJGWDhZRUgvTzFROGRRUlFSNU0zWEdOazhZOENXTVRNMXdrWGtm?=
 =?utf-8?B?NDF5K2pjSU5LSEdVeUtJUEhvVE12TXhPcDRMYjdvdkkzYjJ2dnMyNjYyQ2xk?=
 =?utf-8?B?NFdEenVEZ0d4c2RMOU9GNEdhbHN3YXhITU1nOGd2SVhzSzFoN2NBTEdEMlhw?=
 =?utf-8?B?eGkvNS9ZRHNFMlVudnIyVTkvQkwzWXpBcnZQM3lSZG9iOVE4T0d0d2NCVnR2?=
 =?utf-8?B?Z0hHMTlyOHVpSmpHb2ltWENpUktpU29SR0UrS3JwUFdOUWlOR1lTUXBnbWMx?=
 =?utf-8?B?bmgzMWFmZTZTbGNHYUhXNW9MdGpZMnpxK295MGxXZnV4YUJjNHpaL25hOHpR?=
 =?utf-8?B?b2tDYURQajNYTy9HdU1aUUxBR1Q0QkJSRzhFM1FZMHNaa3FPbGQ5NEJnd0FO?=
 =?utf-8?B?VjgvTlVEY3ZkNW5TZGJPSENMalVhZmlVMzdzV1p1akhIZWg4aVBjMGk5alhP?=
 =?utf-8?B?TVdncEdwWFFuajVYall2eWhDcXNhZ0VDcmFlUTVFQzVKV1ZBV1NqTEdld0JY?=
 =?utf-8?B?UVEzd0RHQzNPbDh6SEJHOUVCZnJmdkt0WFZHUTUvREZlREZreFJNM3U4aU5X?=
 =?utf-8?B?bGxJbGJKR3VremdwMkpuK3BnS2VzY0prWnJrVC96V044QjIwRCthWGJ5bHpw?=
 =?utf-8?B?MVdqcUt0SmR4bzE1Yk9lQi9XYTZqT0Z6a3NoKy9HQnlnaG5RYTZTUFhHY2JQ?=
 =?utf-8?B?WmdIUUMwMGlTZGluR24za3pLT1g5dmRhbXZheEJmU0FmZ0E2cUhzalArTFFX?=
 =?utf-8?B?NUVFd2hrd1hpUDVPeCtjaGxYSWxEaHhhNkZvbXdGSUcvSUhwSVVqQUhnTXMv?=
 =?utf-8?B?MG1oTFphdHZnYUpwandVakFpakNSbFBVVS94VkZMU2g4dEMzemJUb0hKVWlG?=
 =?utf-8?B?ZCtyeFpHWllXNHphdUM0VTFjK1JRR3Z4alBNTWhRK001dy81U29IMlRmczdH?=
 =?utf-8?B?MWxVNkZYbVk3cmU3dW1EQUhhQjVKTjlmRHBURTNCZG9ySWlsMDVqTkV0NU9O?=
 =?utf-8?B?dUVlUEhOK084UXY1R1ppWTNIWThIbjBpbHl4MVFOYVdqK1NYRDZ0TVRhZ0N1?=
 =?utf-8?B?TEE3Q0JHdDBtZDFiTzdUcVpTaklwQ1EzS0NQazNFNFF5NkJnVC8yLythNGE0?=
 =?utf-8?B?ZTc0ZUlzVDJtVHkreWFIK3R2TWFxWExRVDgzZmxsNERnQkluQTUwdHZScTNh?=
 =?utf-8?B?ZmxRMVMwcUxKM21Mbk5pSjFTRUl4MnBwNThQY0pYa3hUKzZaZTRLbEtlK3B0?=
 =?utf-8?B?d3BDY2tIRWJ6NlpCVDBEVDZDa1p5SHdzUUJGWi9zMXpvc0ZGMkhmbllhTG5B?=
 =?utf-8?B?TjdBRzFHdWZSN3JrbXBBL3VsZ1JISkw4VXp4UHRlWlQvdlhoTFBtdXE4Tm0z?=
 =?utf-8?B?amQ2cUo1M1oxaHIyamdIdFl3NWM0ZjVubFQyUTVQQWkrU204Qmlyc2lFZDlq?=
 =?utf-8?B?dnpoY0o1QTUyWkdEUGxEZy9jdnR0UW5McEdqRXV6eTNNdTBwNmhWM3BLSnR5?=
 =?utf-8?B?NUhGYnV1eEpJbWdmbDhqZlJPUS91VUFXa2N6WTRKMzhOdFp5VHMwR1FLZmwr?=
 =?utf-8?B?ZGVFV2dROThtaGNxa09NMGhlTHlqVXkwd0tSN0pJbkNDbXR2R3hZcXBDcHln?=
 =?utf-8?B?ODI1c0dkT3RWMEs4YnpIZ1Zxb1lOczUwQkFJN1FZOGVVRW1hYXg3UmxUQ2VP?=
 =?utf-8?B?UnB1Y2JRYmhGS2x0Ym93QysvbFNUNnlud3lBM2piREJaMW12RmNETzdTN2NQ?=
 =?utf-8?B?NENlUlA4V05kOG1IcXMzdUM0cVVDbXdObHU5enYxSnFZRlBzTSt3ZEFoYSs3?=
 =?utf-8?B?ZWM4ZVhPYThmRHFQSmFYakVWRjBwcHFiNjYwVXY4aSsyZmkyNk4xMmQvOEVH?=
 =?utf-8?B?bHJkV3Q4K2dKQVdaa2k5ekdNUkRHdHUrUVNRMFgwWXJUa2RmamFEb3ZoWnlh?=
 =?utf-8?B?bE5vbWt0c3B5MW5qRHQzalhsTVlhOGdheXZJblc4NVEweUNncU9tS0FaaDQ4?=
 =?utf-8?B?d0RzQU9BYlU0QlNuKzZkY0tlOTl3OW1DZVZ3aGFoeGY2VVY4d1pxTkE5SHZS?=
 =?utf-8?B?ckxrMVlMdk1LRXVqcDhvV2M5S2h5R0ZjVEtwN3hTOExzUkFKSWtGYWVsZHFw?=
 =?utf-8?B?RXc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: kyocera.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6033.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56612fd2-5726-4f87-3745-08dc4dfce0f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 01:26:08.0969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 82cc187e-25d5-45e4-8c34-8434bf6075fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZsQp8iRVmmBwDDlDPBJO8Ohn3ki7+ArmXU553vdvL0i0i/Q6IPbAKviKEdLTIGF20ifx+W8y9jn2yPLgZu8injBfC242sLEw7EobWpoiVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7161
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] input_helper: Modify the check range of the input
 event number
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

SGkgIQ0KDQo+IEkgZ3Vlc3MgdGhhdCBzaW5jZSB3ZSBhcmUgY2hhbmdpbmcgdGhlIGNvZGUgd2Ug
Y2FuIGFzIHdlbGwgYWRkIGEgYmlnZ2VyDQo+IHZhbHVlIHRoZXJlLiBMZXQncyBidW1wIGl0IGF0
IGxlYXN0IHRlbiB0aW1lcyBzbyB0aGF0IHdlIGRvbid0IGhhdmUgdG8NCj4gY2hhbmdlIGl0IGFn
YWluIGxhdGVyIG9uLg0KDQpUaGUgZm9sbG93aW5nIGNvbW1pdCB3YXMgc2V0IHRvIDEwMjMgZm9y
IHRoZSB1cHBlciBsaW1pdCBvZiBldmVudCBJRHMsIHNvIHdlIGNoYW5nZWQgaXQgdG8gY2hlY2sg
dXAgdG8gMC0xMDIzLg0KaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2NvbW1pdC83
ZjhkNGNhZDFlNGUxMWE0NWQwMmJkNmUwMjRjYzI4MTI5NjNjMzhhDQoNCi0tLQ0KDQpJZiB0aGUg
aW5wdXQgZXZlbnQgbnVtYmVyIGlzIGdyZWF0ZXIgdGhhbiAzMiwgdGhlIG5ld2x5IGFkZGVkIGV2
ZW50IElEDQp3aWxsIGJlIDI1NiBvciBsYXRlci4NCldoZW4gdGhlcmUgd2VyZSBhbHJlYWR5IDMy
IGlucHV0IGV2ZW50cyBpbiB0aGUgZGV2aWNlLCB0aGlzIHRlc3QgcHJvZ3JhbQ0Kb25seSBjaGVj
a2VkIDB+OTksIHNvIGl0IGZhaWxlZCBiZWNhdXNlIGl0IGNvdWxkIG5vdCBmaW5kIGEgbmV3IGlu
cHV0DQpldmVudCBJRC4NCg0KSW4gb3JkZXIgdG8gZWxpbWluYXRlIHRoaXMgZmFpbHVyZSwgd2Ug
Y2hhbmdlZCB0aGUgZXZlbnQgSUQgcmFuZ2UgdG8gYmUNCmNoZWNrZWQgYnkgdGhpcyB0ZXN0IHBy
b2dyYW0gdG8gMH4xMDIzLg0KKGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9jb21t
aXQvN2Y4ZDRjYWQxZTRlMTFhNDVkMDJiZDZlMDI0Y2MyODEyOTYzYzM4YSwgaXQgbG9va3MgbGlr
ZSB0aGUgdXBwZXIgbGltaXQgc2hvdWxkIGJlIDEwMjMuKQ0KDQotLS0NCg0KZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9rZXJuZWwvaW5wdXQvaW5wdXRfaGVscGVyLmMgYi90ZXN0Y2FzZXMva2VybmVs
L2lucHV0L2lucHV0X2hlbHBlci5jDQppbmRleCAwOTUzMGZiLi42YjYwZDE3IDEwMDY0NA0KLS0t
IGEvdGVzdGNhc2VzL2tlcm5lbC9pbnB1dC9pbnB1dF9oZWxwZXIuYw0KKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9pbnB1dC9pbnB1dF9oZWxwZXIuYw0KQEAgLTQwLDcgKzQwLDcgQEANCiDigILigILi
gILigILigIJpbnQgcmV0LCBmZCA9IC0xOw0KIOKAguKAguKAguKAguKAgnVuc2lnbmVkIGludCBp
Ow0KDQot4oCC4oCC4oCC4oCC4oCCZm9yIChpID0gMDsgaSA8IDEwMDsgaSsrKSB7DQor4oCC4oCC
4oCC4oCC4oCCZm9yIChpID0gMDsgaSA8IDEwMjQ7IGkrKykgew0KIOKAguKAguKAguKAguKAguKA
guKAguKAguKAguKAguKAgnNucHJpbnRmKHBhdGgsIHNpemVvZihwYXRoKSwgIi9kZXYvaW5wdXQv
ZXZlbnQlaSIsIGkpOw0KDQog4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCZmQgPSBv
cGVuKHBhdGgsIE9fUkRPTkxZKTsNCg0KDQoNCi0tLQ0KQWtpaGlzYSBLb2d1cmUNCmFraWhpc2Eu
a29ndXJlLmtlQGt5b2NlcmEuanANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
CuW3ruWHuuS6ujogQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+DQrpgIHkv6Hml6XmmYI6
IDIwMjTlubQz5pyIMjbml6UgMjM6MzcNCuWum+WFiDogS29ndXJlIEFraWhpc2HjgIAoIOWwj+aa
ruOAgOaYjuS5hSApIDxha2loaXNhLmtvZ3VyZS5rZUBreW9jZXJhLmpwPg0KQ0M6IGx0cEBsaXN0
cy5saW51eC5pdCA8bHRwQGxpc3RzLmxpbnV4Lml0Pg0K5Lu25ZCNOiBSZTogW0xUUF0gW1BBVENI
XSBpbnB1dF9oZWxwZXI6IE1vZGlmeSB0aGUgY2hlY2sgcmFuZ2Ugb2YgdGhlIGlucHV0IGV2ZW50
IG51bWJlcg0KDQpIaSENCj4gPiBJZiB0aGUgaW5wdXQgZXZlbnQgbnVtYmVyIGlzIGdyZWF0ZXIg
dGhhbiAzMiwgdGhlIG5ld2x5IGFkZGVkIGV2ZW50IElEDQo+ID4gd2lsbCBiZSAyNTYgb3IgbGF0
ZXIuDQo+DQo+IEkndmUgdHJpZWQgaXQgYW5kIGl0IHNlZW1zIHRvIHdvcmsgdGhhdCB3YXksIGJ1
dCBpdCBzdHJhbmdlIHdoeSB0aGVzZQ0KPiBhcmUgbnVtYmVyZWQgZGlzY29udGlub3VzbHkuIE1h
eSBiZSBldmVuIGEgYnVnLg0KDQpBbmQgYXBwYXJlbnRseSB0aGlzIGlzIGludGVudGlvbmFsOg0K
DQpjb21taXQgN2Y4ZDRjYWQxZTRlMTFhNDVkMDJiZDZlMDI0Y2MyODEyOTYzYzM4YQ0KQXV0aG9y
OiBEbWl0cnkgVG9yb2tob3YgPGRtaXRyeS50b3Jva2hvdkBnbWFpbC5jb20+DQpEYXRlOiAgIE1v
biBPY3QgOCAwOTowNzoyNCAyMDEyIC0wNzAwDQoNCiAgICBJbnB1dDogZXh0ZW5kIHRoZSBudW1i
ZXIgb2YgZXZlbnQgKGFuZCBvdGhlcikgZGV2aWNlcw0KDQoNCi0tDQpDeXJpbCBIcnViaXMNCmNo
cnViaXNAc3VzZS5jeg0KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
