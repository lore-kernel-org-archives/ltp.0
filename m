Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4052FC54E64
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 00:24:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 15EE73D28EC
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 01:24:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A0D43CFB4D
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 01:24:25 +0100 (CET)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2019::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 89180200B37
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 01:24:24 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFVQiUsDoCsE/Of0vcrjmiyX2ocCXBsWO9/ri86+SK3L8fpoFchHijXIobS9gqrHjULR67WiiZApVRyhfuSwoIQdoTQCiHJl7dmOvh93Zm0VCP74qQUipnCKdd1fICW/oi6ZV996XvoqGeie4jGcqkhbrBKI9/RTQUlS7sSJXMQpiwEb9IxcMn8S3Vej9dO87SsFB7vIosB4s0kQVCvAs5SLk9goBNTD7eg+hH75cLb1Jj/O+2YgX6DRv71a/yLIjwJOXr8+3NLhhZ1TV9xGBXHdMmHI4n3ZZPN8TIawpZmt/ArOrAyMLiwEb8f3qNB72Bsn/KWe/ymYsBqHRSvJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlJz2Pt9vgcxz1+4CzQRHPTCkusNFQrn+hlrEir4Ia0=;
 b=eYUWs/yGCf2LZTCDHCaHnbqNgzsYXy6NNVVzgQkDg5zx3ARN7UQOhZrSnYUgmGcvJqrJwj0VP3fcxF+lJ6MZjAIM8+p2Li+vv0E0LukuR4sx6cdss9TcsLI3JqrNBmjxGeYcRLLJ5I0Bw6WhvqpS7Yd965sF7DmJbwbABWXYu/7PFuBHn5wwKVuYWNADdRva9vnDZKm2rrysHNoUvxq98854H4JoP6cmKBYYQ0SLOQ0lsSxyI6arO84UBQlwmw3rhtGpzgR391bGVwl/DDwEYKCHYUjn1zKwft8C7ZnDqy0HgLasZRdzezOtwMxgjy3rWiMrgA73/i+KBta4p9tl/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kyocera.jp; dmarc=pass action=none header.from=kyocera.jp;
 dkim=pass header.d=kyocera.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyocera.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlJz2Pt9vgcxz1+4CzQRHPTCkusNFQrn+hlrEir4Ia0=;
 b=Arc+g31dRMJa4KaF37UD58EHpEchFP1JRBhsy+G8dhdOoYOJDb2/kAtGO4iVQy6VFIMYxaAriz6SZSNOBqOBjKjsZR/vq0n6Ev6sHSLPrSvAMsenO0sB/p9boazrpigf4Hqe32//M3dO4sJcNOtV2yVUq8GDWwI6Zpr1xvuRmgc=
Received: from TYAPR01MB6044.jpnprd01.prod.outlook.com (2603:1096:402:33::12)
 by TYCPR01MB8692.jpnprd01.prod.outlook.com (2603:1096:400:188::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 00:24:20 +0000
Received: from TYAPR01MB6044.jpnprd01.prod.outlook.com
 ([fe80::d32f:5f38:2793:72fd]) by TYAPR01MB6044.jpnprd01.prod.outlook.com
 ([fe80::d32f:5f38:2793:72fd%6]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 00:24:19 +0000
From: =?utf-8?B?S29ndXJlIEFraWhpc2HjgIAoIOWwj+aaruOAgOaYjuS5hSAp?=
 <akihisa.kogure.ke@kyocera.jp>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH] input_helper: Modify the check range of the input event
 number
Thread-Index: AQHafxO5ma/8HTEuSk2Ev/pVwAh9LQ==
Date: Tue, 26 Mar 2024 00:24:19 +0000
Message-ID: <TYAPR01MB6044D2E0749663D84DE1F395D9352@TYAPR01MB6044.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6044:EE_|TYCPR01MB8692:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6o0Wz8NkYzzZbIk5VZ/SMeXDtZgBEotxmJsttvTO3qLyY1Sj3AFllvsA/SenZAgBSqQ2bD+6hs+/hsafA0TSCukTo0ZdKFGhQbTh64yMiFl+zRzUKfrbimP/jM5uTFSkLmMhWnjziHUoTmW4I3rOHY4nWmpK4gc0/q2U19voFBDsbzUES8rXKgPbOCIueq8v8JU+blk1buJRVjG4JyIlwJelsvXTpAbjNawHEm+1VCEtQYrMm1QgnnJ0AgXwu/ExMi57Dh1+Gv7FI1JBoBDl1OHUUcr6AOwL/b0P31ncI4XYUk0npWWoTfJRZ6A+Le2r60392IFDo0sidTIdwlWxSs9Wf3DMDFE29xiMt40V2n9ja2hruZmtsSV5wZ0Kr9f/rr3VDlIks/h1eXllyqn344NXDTXvglTYlDAHLu3DSn6ZUiRrp4ruXNGCOv8OQKw0d1ImnARnT7nmeYy1x1t+XeJ5TF9yzQJHAFtDh163bh7JX1j6QhvIU2Jpdq6Y0AHGmBx2ohdtrbGUKObIqIr3ipBJ2teWoFQbOyV4jWBhUpddvozI9UpgfzyTWeSQE09C8/z8GSnAy0++p5gwnDSrPoa1BVmgmcxsdVEGIMk89wfGVUJNyuJisvRPo+6/d85ICj75aYlcEMjsTeAQxtOkMAyMW/YWRTlYHNCOeJi6854=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYAPR01MB6044.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG5pNk85b3M2UnFwdzlYVmpCTlV3d1pnWTNLdlJaS0FpWFNNVTFCWTJ3eFho?=
 =?utf-8?B?OVg2WE9JVTBQSXlHRnFkRVl0cmZrbW1hViszczEzN1BUdWplTGdQTkRSUUI4?=
 =?utf-8?B?RjZLMDE0TWw4WE52bXZvWDJMSW9kUGo1LzhDUVVZdkc0RnRVN2tyVHd2c3Zj?=
 =?utf-8?B?UU1aanR0N3cwRVRqQk9PUlRjZnlYb2dhRzdhSEVPb2d4aEl0K0YwZlhhblBL?=
 =?utf-8?B?UDBDdWpOVktuY1RyVUdtMzVZa1g2WmdOem0xcUdNZ2pIem9HRm5MUm5uM2Zr?=
 =?utf-8?B?bHkvbTd6L2FadXJEVWJLZkdjdTg5WUNZU0dYbThjWkUrbyttbUFqU2kxMTFU?=
 =?utf-8?B?N0JBR0VXRDdCMFNrbGVPRUkzbnhqL2VkNHFOcnlWcGRmWUdYSk9UMitQcTkr?=
 =?utf-8?B?RTR5ZGVtVjNvaFR6ZjdhU3FodnhVYXVXK3VKSVdqcDlHcXhmTm05Nkx0UTM1?=
 =?utf-8?B?eTJOcVQ1WElGd0NXbXp4QjlKRzJhMGF6UUQzSlo3dzNvR3M3V1lscThvbVpJ?=
 =?utf-8?B?T1hGVGIvdVdBeEl5MC9TNzB2YWxsNmprQ0JMdFdOS3dHZTBxUWFJeXhuRjli?=
 =?utf-8?B?QWdPamJpVldWNVpVMGFZcFdVRGYwTGFuZkpFSnF6NmZKOS8xaURtV2h1M2w2?=
 =?utf-8?B?dCtOajVwNWZEd2J3N3RvUWdXaGZnU2x5d0tPSHYrUzNWdVBoU05TV01NOHRt?=
 =?utf-8?B?cnZ0cEsxVzBTZERLeUY5bGxTWUEvaHlhQUdvTzFOZ3NsUlJMeGMxL085WklX?=
 =?utf-8?B?ejRRSkxsd0hHZFBndTJUVlB1a25COVdleDgyUFBESWJwRVNmd3lBaDNMNVU2?=
 =?utf-8?B?YmpIYUVKSEtjZExtSThVclZDVlYxR01xekgzTTNlaFBlekRvdk41cUoxMVdo?=
 =?utf-8?B?TFpUU0hXanNqSzBvU214a1FkMXRKOHI4MVJZM1FFQ0FaNU5Jcm1OMjl5SW12?=
 =?utf-8?B?N0h3VzVhN2NQaFd6WFFOMTlMQVFweGloaTQ3VGM1Rmw1UGRZKytoYllGbTFC?=
 =?utf-8?B?NWx4QlFVczBqSjBQeTMzZWp4N1pkUi85bEdTblEreE1kNDFQZHlqV3A1amFI?=
 =?utf-8?B?Yk8yNUE4aWhmVURKa1JHN010bkhWQXdDVFdaMVdEcU1JUm9HQTBtWFc2dHA1?=
 =?utf-8?B?bTZOT0xRbVNjN0xDS2VxYk1ycXlsWVAxNStqVDFiV0RwRThSS3pac0FJSTJR?=
 =?utf-8?B?L25OMlAvVE1zcFBKeXJyRmg2N2ptQmNqSFhXYWxWQnpKR2ZQRkxSeUg1Nzd6?=
 =?utf-8?B?U2FhM1ZzWHZBZ0dpOUhIZWMvaTEwVkFkbVY5SkNLemcySTNRN2RqTEw2NmM1?=
 =?utf-8?B?UEc4bk5TdVppd3NBdkpjVUVCNXgzajFieTRFRTRlWER4aXE3WExRd3RWSEJH?=
 =?utf-8?B?VFRiRWpxNk9JNFAyeXF4K3U0QThCMEkrRkJjbGlSVlpiZ2pJWW5iQmlVWUNE?=
 =?utf-8?B?Tm5jdFhORkJSVGNFZUJET3U3SnRvM0pFYXZrVWJ4azIzc2R3b3Z5RENnQ1JU?=
 =?utf-8?B?SnNUZkJhNkNXRVViRFFSOUZUVGVyUGwxZHRNbFowWnZRenpaTWpXa1RLbzMv?=
 =?utf-8?B?Qk5iUS85czliQmFqSS9BQklDN2wxeHJFTjduRE9mRUxSYnhSeUFSRUtaOGdU?=
 =?utf-8?B?UnBrNG5nZEZDL3RIY21jb1ZMRlZHdmRVOHZJVmJmRHpQUWhmSWhERUpnN2tV?=
 =?utf-8?B?QmR0V1RjU25FUnFYK1VXNy92STE5bGo3V2VuK09qWCtHdi8xYm5iZzdtTDh2?=
 =?utf-8?B?bS9TK2tlRWdMRThaaThSTlk0ZWRRdHh6SkxIUXRwYlNGMmhoMUJEL2tDYXFj?=
 =?utf-8?B?ZHVQc0lSU3VxRmRhVHJxNEZTTjJnNkFwOUJMZHZrMkUxTmpaSzFPbzZwNTNQ?=
 =?utf-8?B?b01DRDYrZDJMUVBLZ0JQdWFEeFliaUNZdWFFei9lZUwvQjRuRUluNkprM0Zv?=
 =?utf-8?B?Skt6cVU3aXE1MFlKdCtVL2UydFBQTlRsajIveEdkdjI1L2R6Y3ZGRzVJbHFX?=
 =?utf-8?B?U0dCa0dpTlZTRGdwWk93dEtjZkhiT0k3WGFBckJnRWQ3bnJpaTFYaTRjOGdx?=
 =?utf-8?B?dVZJNFQ5T3VIN3ZZRGQvSUdXamZqSEpqMUhibDduK00xNlZkMkVqUVdqWnF5?=
 =?utf-8?B?K0MzUWhjeVNKUDFSQnNxcmVTV1o4K2t2dlVHU3czUWVuWUdPZEwxeTFDbFZo?=
 =?utf-8?B?dkE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: kyocera.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6044.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cb8f71-321b-47cd-a0c2-08dc4d2b142d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 00:24:19.6797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 82cc187e-25d5-45e4-8c34-8434bf6075fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MNgaPt3hwjWSiaRI77aVIM6Mq7w06NsQA6AXaoBtQj25sGZqaEcHFA1yJ91U7+heE7td0hfYyswLmb90mHzQikg7SbHN1HUNmyiCoWFf6Kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8692
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] [PATCH] input_helper: Modify the check range of the input
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

SWYgdGhlIGlucHV0IGV2ZW50IG51bWJlciBpcyBncmVhdGVyIHRoYW4gMzIsIHRoZSBuZXdseSBh
ZGRlZCBldmVudCBJRA0Kd2lsbCBiZSAyNTYgb3IgbGF0ZXIuDQpXaGVuIHRoZXJlIHdlcmUgYWxy
ZWFkeSAzMiBpbnB1dCBldmVudHMgaW4gdGhlIGRldmljZSwgdGhpcyB0ZXN0IHByb2dyYW0NCm9u
bHkgY2hlY2tlZCAwfjk5LCBzbyBpdCBmYWlsZWQgYmVjYXVzZSBpdCBjb3VsZCBub3QgZmluZCBh
IG5ldyBpbnB1dA0KZXZlbnQgSUQuDQoNCkluIG9yZGVyIHRvIGVsaW1pbmF0ZSB0aGlzIGZhaWx1
cmUsIHdlIGNoYW5nZWQgdGhlIGV2ZW50IElEIHJhbmdlIHRvIGJlDQpjaGVja2VkIGJ5IHRoaXMg
dGVzdCBwcm9ncmFtIHRvIDB+MzU2ICgyNTYrMTAwKS4NCg0KQnVnOiAzMzAyNjk5ODQNClRlc3Q6
IGx0cA0KQ2hhbmdlLUlkOiBJMWI1MzAwOGIxNTY0MWZjZGNjZjIxNGFmOTE4M2RlMWMyOWEzMzA5
Yw0KLS0tDQoNCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2lucHV0L2lucHV0X2hlbHBl
ci5jIGIvdGVzdGNhc2VzL2tlcm5lbC9pbnB1dC9pbnB1dF9oZWxwZXIuYw0KaW5kZXggYzkyOWRl
Ni4uZjA4NmFlNSAxMDA2NDQNCi0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvaW5wdXQvaW5wdXRfaGVs
cGVyLmMNCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvaW5wdXQvaW5wdXRfaGVscGVyLmMNCkBAIC00
MSw3ICs0MSw3IEBADQog4oCC4oCC4oCC4oCC4oCCaW50IHJldCwgZmQgPSAtMTsNCiDigILigILi
gILigILigIJ1bnNpZ25lZCBpbnQgaTsNCg0KLeKAguKAguKAguKAguKAgmZvciAoaSA9IDA7IGkg
PCAxMDA7IGkrKykgew0KK+KAguKAguKAguKAguKAgmZvciAoaSA9IDA7IGkgPCAzNTY7IGkrKykg
ew0KIOKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgnNucHJpbnRmKHBhdGgsIHNpemVv
ZihwYXRoKSwgIi9kZXYvaW5wdXQvZXZlbnQlaSIsIGkpOw0KDQog4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCCZmQgPSBvcGVuKHBhdGgsIE9fUkRPTkxZKTsNCg0KCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
