Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F4ECD1288
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 23:59:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51D3E3C2D44
	for <ltp@archiver.kernel.org>; Fri, 29 Mar 2024 00:59:24 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3DB33C04FB
 for <ltp@lists.linux.it>; Fri, 29 Mar 2024 00:59:08 +0100 (CET)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c406::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EBCC71A0064E
 for <ltp@lists.linux.it>; Fri, 29 Mar 2024 00:59:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKwm2rOVtqzkLt3mWoUCqWTKmsbXxHXVJxieTvjt1tTQ39Rm73L037S7j2HOaFnPgV+uZD3dei70c56H4n+bddmw91J3BWbmxVLyMxVxlld0Rub407S5h0JrSoPtlXVveM9InIeev0H7CfjqHLIMsvl6cV4JsN1jEPyL5AFQaLvFe63t3eFfUakfA7A4sb5PVypocHXpusbMK7ed+JdWfXuw/tWXrHkGcUN2E6vRzFoM2Krtg2CqFyELREvZWjDaFKOjOUhem1HgDwUBCGnUZix6taV3ZnQHYv3J5PR62rbQoh8GLuTj6ENpsVKSz66YkJ8CW/WHZ+9ZZ/cvu55U9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVmXjUw9S3C0kKmgZ28RkbKz87c7OKhYUj5P63FrISY=;
 b=R2GQjVsMnKDXQWgaD1PfG40oAzXTF60CBGjN0Givjw2PM/STCLSHIz63u7tXCSZ69MIi141pspPTmSelx54RxF2x5u+p/rVcGSfQQCc6x+Uee+qDdBz3Y2OKyaOYr4f1vqta0Z9seo/q4KCRNmzM0+JZsMhuDgbpkloRTrvk7rqZwX972TzIOT4Exdu1DPbUKDpfkeNYu7HGGhHaWxyIBDGbU/hva/dFetgQak2nRc1A/80IaFNis4fYOjEE7EuaTtftHBxCVb4HVRBs5xLbEykMi+lKqws/O+XMXL7/4vgCiK9NbD4ztG5n/9y066hEVunlydOfiflHcs3cKsDm7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kyocera.jp; dmarc=pass action=none header.from=kyocera.jp;
 dkim=pass header.d=kyocera.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyocera.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVmXjUw9S3C0kKmgZ28RkbKz87c7OKhYUj5P63FrISY=;
 b=FrooczzEfKnIs+sJGqzGKyFvqAbt2yLsHqGeHnBviK14nVc65q5UHvtHif55Dy9sHRTPf/k6r99QpB92R5UfS013fXcbbYdqfFT7h5mX5tHOdutLSYX9MkRneijB7K8tUGcq8XtdloYes9kWPmUWlFtLlVdcFn8sNiuFB5UBr4c=
Received: from TYAPR01MB6044.jpnprd01.prod.outlook.com (2603:1096:402:33::12)
 by OS0PR01MB5588.jpnprd01.prod.outlook.com (2603:1096:604:be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 23:59:01 +0000
Received: from TYAPR01MB6044.jpnprd01.prod.outlook.com
 ([fe80::d32f:5f38:2793:72fd]) by TYAPR01MB6044.jpnprd01.prod.outlook.com
 ([fe80::d32f:5f38:2793:72fd%6]) with mapi id 15.20.7409.039; Thu, 28 Mar 2024
 23:59:01 +0000
From: =?utf-8?B?S29ndXJlIEFraWhpc2HjgIAoIOWwj+aaruOAgOaYjuS5hSAp?=
 <akihisa.kogure.ke@kyocera.jp>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v2] input_helper: Modify the check range of the
 input event number
Thread-Index: AQHagWraWSXDQVLU0EWXYoRkjMrrHg==
Date: Thu, 28 Mar 2024 23:59:01 +0000
Message-ID: <TYAPR01MB6044F6C94C3BEFC65801A849D93B2@TYAPR01MB6044.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6044:EE_|OS0PR01MB5588:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qKSU7ewYb/Hi/4wnOqjWqOI6m3ScYlXZ9lbamREblBcgLpaBBghBazAYduKGNNygGI1gTHWHbK2V7p38mr6RmH4RSK8KZHSHNx61JoCdHhZ2FIwEfkRuNNjkpQoZcCg9pZfgczfs2AhZhog9XHu35ISCTH+vLGKV+MKYcjYx1de0U2BnzbX3reiaYAZTGVFdoG6abhCxGAYKohj0sLJXngIgqFluu3wCKP4WLLdiVPOu+zcUqI1BrFOpYYMguLNuCE3xYx6N+wFI7gmbgVuKgE45wUHBlK8+honTpzoc3NF+kKtIarTbdel7mkGFRv9LA0nkv9L9tCaDGeP3kabW2IOON71qd/T3LRosHIovsofmmqj3p0J2Hu0wkETSoAmZ9hBi3IOnWtV/SsH6PH1y+uy+xdD49g4/Ly9YfOAKqAY1DdlQJRKdDksiqbpF9/wQM6OdlE4ZN71mTgfBI9DeV3moMHnu0O/xS5az6WaPzmwtfZFBGeFctHksq4YuWfL0HHfmpUaQV6PGKY5McVo7eexbCtvo9n1UuJHOOPrrEgXYiPLgxULuqM/uubcsB1UODRtCoJp0BJ9qyNKqXgGu1BHqxyqDXA/WzGa2OMi8S4Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYAPR01MB6044.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmVCZ3dRd0xRMFhPQ2tQNUhCSTB3L0tUMXl6aE9PVk5vT0FrblZib2RHS0dL?=
 =?utf-8?B?bnp2cXdjQXFXb0UyV1hXU0U3TnlJRXlqK0xpWnozaUxZM1MwU0tDaGV1OG9a?=
 =?utf-8?B?SnBad0I5TWM4b3BuQWlwSzdoVGlCMUxHRy9xN25ZUmMzUmVrQWhpN1VsNjV0?=
 =?utf-8?B?czdzdXFxMmlrS2hFNUFBR2I2ZmZCZnZqRFltWnJVS1VDQjFWMS82VGVLalcy?=
 =?utf-8?B?RFQxRytEbTF3WEI4SDVGaUZNcWtJQXB5c3hPSkZtNHZ1MWIreFdNanBWc3Bx?=
 =?utf-8?B?bVYzVmJkd3V4QkR0akhhdElNQkg4T0laNURST3hwK0Uzc0hNMlJaemVDeTJN?=
 =?utf-8?B?YThCQloxQm4xTTVXNkpVbm1hcExZSGQ5R0QvLzlPMkNjRzBPTzl2Q3QyclpJ?=
 =?utf-8?B?bXNiVnN1R0lVc3owaTV2RngwVXUzdVM1cjNTVkM2ZENUNlBOeEkrbnlQMFFq?=
 =?utf-8?B?Skh3cGxwMi9weTM4MFdiamVzbWVETjZOWXlEUUlRb2d1RzFXT2NQT05lY3pQ?=
 =?utf-8?B?dEgyVldKaDRvNzRJL2E4bFVjZGw5Yzd4Tmw3TmpYcmsvRUFLVm1lYjJoMWxn?=
 =?utf-8?B?Zk02M3l4WlAyU0hxZjlZMk05Q2hGcXRyNnMvbmpNMmliUTBwVmt5b2kwRmc0?=
 =?utf-8?B?by9vWkNBK3JicDdqWHhhb1p6ZlIxL0NUcVE4b1VQbnJxOG1ZZGYrVFdPVGU1?=
 =?utf-8?B?ZXpzZm1ZQ1ZCZWd2dm5TVVRJRFpVZWlXVjdPNmdVRnM0WitwdHFHRGpYWVhz?=
 =?utf-8?B?NkVyWU1pKzVnM2U3dkEzRVFIaW1pWWYrdEhNQzJ3djRPKzhkS1VPU1F4TDZI?=
 =?utf-8?B?bk1xbFRrRjQrRnJ6K3RVQWJ2ZHhtVTBNd1pWdmhVVk82ZmhkQ213SWVIK2hv?=
 =?utf-8?B?YkhtUUhvVVpNQytLQzJDd1h3L2paUklEOXJmOHdHRU1BbDBnVEhLMm5jWjMy?=
 =?utf-8?B?cHQxQ1Q4aVBldTZDQ0FIeU5KRE5xaVJYNkJVMFhSaGNQSFZCbzVhb0ZiaUpi?=
 =?utf-8?B?SDZlSU1tM3Rtc01mK3pjR3VQVDJkbjNMWHA0aTNXRUZhK2I5T0hicTdMczdW?=
 =?utf-8?B?ZFFvN1NPWU8wVXNRVWRJQWdTT0lrSEtQYUNRRlB3VWE4cWFrRzMxMjBtVXhl?=
 =?utf-8?B?UmF4a1JDZUdCcURGdWxzcEtrSTdJUnlmbzFKSDQyeTZyV2xqMkVVMFpaTlc3?=
 =?utf-8?B?U2V4bkNkdlZDRTJIOXhMZ0ttcnJuNmpKd1B3bG9oUDBmWmhmVWxlMXJKSnJk?=
 =?utf-8?B?MFZ6clUrMFhxTU84S1FueVNKSXJJcWFETHFwd1pINXBuam9JYkJUSWtuZ2Zm?=
 =?utf-8?B?OWp0TEg5VFVqNHZ6TUhpVEFNVmxqRHBXa1htQzFKd3lCamdKWFJDZTBublIy?=
 =?utf-8?B?WS81UjZmTUhhMHJpT2Exa1R2UXNrL2Q5cGVjaTU2UUtFVEpGTkRiOW9CM2w5?=
 =?utf-8?B?THVRYjVyZmhVZFRIalBNUzdZTmk4T1d0Z3pra2Y4MjNJLzJwUWlEOVI0MHhr?=
 =?utf-8?B?c0M2cXJlTzU3N05KTVB3UEZpRDF5YlhndEgycDlCRXlIN3M5cUZDbHczeTRj?=
 =?utf-8?B?WmhVYzM4QVZYM28zc2V2WDk5eE1ucER2WXpHTjVjTXV0VFArNEtnU3Z2Q3k3?=
 =?utf-8?B?Y2I0TGp2dWtiSFRBYjRvd3lpSFF2YWgrczk5NjNvRVg0dlJ4S3BWMk9rVWNG?=
 =?utf-8?B?ODJzUGRVSFZPZDgreWNZeUN6SWFzcUFGRGxjbUxDRC9jZVAyVkpSQjNRY3NY?=
 =?utf-8?B?a2hNK1NnTktGZGl3czZORDBVcEVtbDMrZHhHL3k0Mm9jUkRhZkhicmhqUTBo?=
 =?utf-8?B?YnBpU3NBMGJXZE5NRHlxa3pyR3grUGpIcDZCWkRpYWdlUzI2eDZwNWZHWGla?=
 =?utf-8?B?dzQ5NlZ0a1ZYQ05GV0p2Wmx1MGlIa2k3ZnRrNEFzMkdrcUcwNG5pWjFFdjdW?=
 =?utf-8?B?ZGdhN1ppb25kZFZGQzkyeWdpQ01KZjVEUXpYVXdKWDlDOTBDTUREQllxamhr?=
 =?utf-8?B?VU5RRHFacVN1Sk92WGtocXl3V1lCcTZVUlhCY0tlSmsxcy8vMGZQWVlYaE10?=
 =?utf-8?B?RzFLR08wcmZ1V2hjbWg1NmdzNGNOZVVycmlab1FMVFoxMzhZRjU3VjQxUERh?=
 =?utf-8?B?THFHbTJ4WHFzZ1E1cEhNc3E4WTZXbjVTUUd0bm40TW5xQm5RYjBDL2RpdGc0?=
 =?utf-8?B?K0E9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: kyocera.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6044.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c069c82-4207-4348-025e-08dc4f830a42
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 23:59:01.0586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 82cc187e-25d5-45e4-8c34-8434bf6075fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V1Uttg43ltsUbhd8jwUK3a8q49+/GuGfv/4sm7lUD3nqQHVi7HT6XfUB9AKi2zlwduoiBbH17l1f4MRAKmBFrpY9951r2CNMuQmbdckrhss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5588
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] [PATCH v2] input_helper: Modify the check range of the input
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VGhlIGZvbGxvd2luZyBjb21taXQgd2FzIHNldCB0byAxMDIzIGZvciB0aGUgdXBwZXIgbGltaXQg
b2YgZXZlbnQgSURzLCBzbyB3ZSBjaGFuZ2VkIGl0IHRvIGNoZWNrIHVwIHRvIDAtMTAyMy4NCmh0
dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9jb21taXQvN2Y4ZDRjYWQxZTRlMTFhNDVk
MDJiZDZlMDI0Y2MyODEyOTYzYzM4YQ0KDQotLS0NCkNoYW5nZXMgaW4gdjI6DQotIENoYW5nZWQg
aXQgdG8gY2hlY2sgdXAgdG8gMC0xMDIzLg0KLS0tDQotLS0NCg0KSWYgdGhlIGlucHV0IGV2ZW50
IG51bWJlciBpcyBncmVhdGVyIHRoYW4gMzIsIHRoZSBuZXdseSBhZGRlZCBldmVudCBJRA0Kd2ls
bCBiZSAyNTYgb3IgbGF0ZXIuDQpXaGVuIHRoZXJlIHdlcmUgYWxyZWFkeSAzMiBpbnB1dCBldmVu
dHMgaW4gdGhlIGRldmljZSwgdGhpcyB0ZXN0IHByb2dyYW0NCm9ubHkgY2hlY2tlZCAwfjk5LCBz
byBpdCBmYWlsZWQgYmVjYXVzZSBpdCBjb3VsZCBub3QgZmluZCBhIG5ldyBpbnB1dA0KZXZlbnQg
SUQuDQoNCkluIG9yZGVyIHRvIGVsaW1pbmF0ZSB0aGlzIGZhaWx1cmUsIHdlIGNoYW5nZWQgdGhl
IGV2ZW50IElEIHJhbmdlIHRvIGJlDQpjaGVja2VkIGJ5IHRoaXMgdGVzdCBwcm9ncmFtIHRvIDB+
MTAyMy4NCg0KLS0tDQoNCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2lucHV0L2lucHV0
X2hlbHBlci5jIGIvdGVzdGNhc2VzL2tlcm5lbC9pbnB1dC9pbnB1dF9oZWxwZXIuYw0KaW5kZXgg
MDk1MzBmYi4uNmI2MGQxNyAxMDA2NDQNCi0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvaW5wdXQvaW5w
dXRfaGVscGVyLmMNCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvaW5wdXQvaW5wdXRfaGVscGVyLmMN
CkBAIC00MCw3ICs0MCw3IEBADQog4oCC4oCC4oCC4oCC4oCCaW50IHJldCwgZmQgPSAtMTsNCiDi
gILigILigILigILigIJ1bnNpZ25lZCBpbnQgaTsNCg0KLeKAguKAguKAguKAguKAgmZvciAoaSA9
IDA7IGkgPCAxMDA7IGkrKykgew0KK+KAguKAguKAguKAguKAgmZvciAoaSA9IDA7IGkgPCAxMDI0
OyBpKyspIHsNCiDigILigILigILigILigILigILigILigILigILigILigIJzbnByaW50ZihwYXRo
LCBzaXplb2YocGF0aCksICIvZGV2L2lucHV0L2V2ZW50JWkiLCBpKTsNCg0KIOKAguKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAgmZkID0gb3BlbihwYXRoLCBPX1JET05MWSk7DQoNCg0KDQot
LS0NCkFraWhpc2EgS29ndXJlDQpha2loaXNhLmtvZ3VyZS5rZUBreW9jZXJhLmpwDQoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
