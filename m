Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41609C4321E
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 11:13:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49D543CC207
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 12:13:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE9363CC450
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 09:41:50 +0100 (CET)
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feae::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0B5AC1401248
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 09:41:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aas/H9wEFCynmS7gIDYoOCSWz0Naz3OfQKvQV0tCNiq03xgE2Z36Mc6vg0vcMSIekV43ZhRhCBVRXALdbzQGYsy2JZQygtTat41SOmNfFl4xzNBrJnbQBsPhCCwbVhb/m76ShEMFR02ZdpOifXw1BtPlFGAUAovnp4ZaYQfRvIPEDdlGx1KtLIEhbpxJ09SE+dtaR7KpCz0psOX3FONnaDrnOhhesl5TBwMs6snb0Che4HjA7r4vJlINdPxo0yiWQ6BjGdHUJmpvO+hrjfzG+U8jetTf0/m4poCHqzasN1UmURLAppmNcaD+KvuzO67WEjKONABPPH9nzqnrbQ8tSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+gJtb0ZtPyuOtCGIQv21fM1HJN4VLxgRX9mPOEkZZc=;
 b=d/4GB18r9xICclovOH/VPkS2gsOhDk9Qbw6YWH3uzP7ko+/Jasw9XIxr8i9T1NgbuvYTY88BLPQaqF2xPPkTk/NitMrqW0ejPX1/+4k6lvZQuPVRUUNSKvD9sA7t4+RfXp2L5avlJ0AWrPsXgqEWoTHBqa+O/M6SCbHC8F5CeMNR/3PEUdrLKjNM7MYFBUmCrnnVBG/ZbfPzrfhlwtD9+m0EJrlfng2enUd4ApRQZHyRfFjAaEcnDlGMKKaSfsiB9VIJxHkkR/CEwgUCsU+cAf1PuUFFWYsZH9vg5cnw29G5MWufbiJtNNBzbwPTxciQGKUEqMn80Vtp+tHsEQtOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+gJtb0ZtPyuOtCGIQv21fM1HJN4VLxgRX9mPOEkZZc=;
 b=t5znspBzcLC6cc+UxROf9vKoWv5r0tTLzDBRRKbfHiudoYHbOKoDcAelxWWb9gENLb/jtZXNhcxiitoa1IEa/x4FCnweXAcc6YlA+/mjvsGG0mB13uxrZvNoonzNCmXpX3ue1majkenWk/tinLq3edq2st884ZFVyAjT7fwHrpU=
Received: from SEZPR02MB5760.apcprd02.prod.outlook.com (2603:1096:101:49::10)
 by PSAPR02MB4965.apcprd02.prod.outlook.com (2603:1096:301:8b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Thu, 1 Dec
 2022 08:41:40 +0000
Received: from SEZPR02MB5760.apcprd02.prod.outlook.com
 ([fe80::e873:4a75:45bf:bbb0]) by SEZPR02MB5760.apcprd02.prod.outlook.com
 ([fe80::e873:4a75:45bf:bbb0%3]) with mapi id 15.20.5857.021; Thu, 1 Dec 2022
 08:41:40 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: About the diotest4 failure on linux kernel 5.15
Thread-Index: AdkFXlv7VD4oSepSQyCb2tRzSF3xMA==
Date: Thu, 1 Dec 2022 08:41:40 +0000
Message-ID: <SEZPR02MB5760561E4DE60AB5BE743B6EB3149@SEZPR02MB5760.apcprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR02MB5760:EE_|PSAPR02MB4965:EE_
x-ms-office365-filtering-correlation-id: 66d7546e-4754-470c-1f92-08dad377ddd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0vX8oT2jjdM5qatAwvnKW754i+ukDsfToJK6qeWRznBJsHgYMD05KQG0ITIZOkCddTQaw9A1ETiFT1HSZYNcS02hOrPCxeFwsADaFKcLvCWQK9PrDmIb4j30KFmAyo+l2sHMLZIG084KWPC3UGmFaaQLrcrByavMLfqvCaCAbwKB+YtZQgM/HNTi0HdqBPj9gQ4asTGYQ4XlNBOqvXkaHvjAhz+e7a69H1fsC5Nj58zGOPNN7BksLsKBnkT3CFrXTQylyHgaGxO1vcCfppRwDRNZmquaEu9x+rk6hd5CmRUNfnnRExaraUrsRJGLMzBJbXkt2drT1lE93I03f1NeqF7+4/s0B30Pn16KrJbqCqxQv+6HqTP55x0u2K6W/n1IENjAgNrBd53GZOw6uMxStjzgAKkNGMKH7LQgb10AnA1lqhJOEQ7Kpg3shMqIYgT8oponeLiu97aPVJ/bde8jJ4c5GjG7ZLLM3MSlEL7vWezmHhlCnihJ/3G20lDpWt++5qz0SaOi7BFVRVK7/rBhtsDVFoxyI6wIpF4R/Edk1Nb4lOWGL1WRo6gjX/wpICLSXlsaXBlvOCuCyml3Hjc20vXYa+rwJ0nkrL600yC9g5VArZ57MuBqhUaEwu4ISwYlfVsCL3xVhY66IKsDFeR/Q5E5YfftHy07yzQOB6MysAnuTCbbN5Y7cD+QwV344mMo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR02MB5760.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199015)(6916009)(9686003)(8936002)(85182001)(316002)(186003)(26005)(478600001)(71200400001)(38100700002)(122000001)(99936003)(38070700005)(55016003)(86362001)(33656002)(5660300002)(83380400001)(6506007)(7696005)(66446008)(76116006)(64756008)(66946007)(8676002)(52536014)(66556008)(2906002)(66476007)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cXIzeVY4ektBd2Y1SzRFUkhKczNGblp2SFB4djdMRE41V1VKYlpZeTYyN0xh?=
 =?gb2312?B?aks1QS82VXdNZm1aU2ZtNkFEOFlFRjUyUTlsWWFVaFlPSCt2eHJaa1p0V0dt?=
 =?gb2312?B?blVWYVFzamQxV1QzN3VDODM3SFR0enl3VGtJVG5BeHo3TFJxQlhDSkU5SVNN?=
 =?gb2312?B?VkZXL0VRTGJyK2t1eWpxQWxlcnpUeTZVOUlGaHVnMkxwSGpHa0phcmF4S0hC?=
 =?gb2312?B?WkR1SjVkNWN5TFdxMjZ0NDVJZXVjbEx3ejVOL1M2RDJqYjZsbDllVHMrZm5Z?=
 =?gb2312?B?TUl3L1E1ckIwVEFuNHdoZG1nK1BRZHRBZ1lZL0F2Vy82clh1VTdIdmkvdVgv?=
 =?gb2312?B?ZmdXRE5ReDIraUMxVDRlN2l5cU90WEFra1M1ck5UQmZ4SmVrQXFTMll5N2tG?=
 =?gb2312?B?aENzL3pHd3NZL3A3K2F1YVpka1diRTQ0dmxHWllUb0xLMVBIbVIvQWNxWTRo?=
 =?gb2312?B?S25rOUllaGs5a1hpRHMzaEI5aU1Od0h1eXdNbmtBckJjOE9YcFFBRmI0VHRs?=
 =?gb2312?B?dTMxd3pQVlRiZHNnSWpxU3NzZmlqVHBKYjRBNUROZ2ZyOEhnR2lhcDFNQTN1?=
 =?gb2312?B?OCsrYTNpKytTWEJweDJzUDlWQ1NkMVhiY1NhdzFldkpjb3M5U0hwZ2ljdGpl?=
 =?gb2312?B?MkxxcldtOTlNcHNZNzJhY3VFUDFMbGdVQ2plYlVMZVJ2bWN4emp1aEVBVHd3?=
 =?gb2312?B?Y0J6TlhEUzFVbHBmc2RTYXN5MnFXRFByZy9WUjFrY0hTN2RsSDJDUHg4eWJL?=
 =?gb2312?B?cW1EdWhOWUEwM2diYnFFcWd1TXl1cmcybkpOaVZOUzMvSU8rV0dQWWROcllT?=
 =?gb2312?B?dWx1b3VQb0wyeFBBYmRockJmbG9iY1hjYys4bUpYYWpSdnd3L1F1VXhIeUpk?=
 =?gb2312?B?YkNkMXl3TDFyU01IZ1NpWGJWWnBLS1VFamJ2L0hGc2tmaFA5Y3N0cUM5Z2t6?=
 =?gb2312?B?YWhRUGlRY0JrWFRrOHZEZm9XcGtBZnl3UDM5eW5aTEJEQm03YnBQYVdNa1E5?=
 =?gb2312?B?SVdOOFlCelJTWVViUnFpdWk1L0ZZMVFxVXZjQWc4QjhMTUp1WG1Gbm8ra0lJ?=
 =?gb2312?B?QkFsZE9tTXJZNk1VdlllZGhoK3pza3ZKUnlUcTA4bm8welZaVHpuaXZnL3Rv?=
 =?gb2312?B?dGRqVi9KQ2plZm0raXBKMDFwSndmSWNSd2lPaGhiT2lsdjFnOHpvUUlXU1A1?=
 =?gb2312?B?TnBkaG5kcG4wNlpqQmhMUCtqaTNkcnJsdzhTVktrQTR2TTBmYU5kMW10Q2ov?=
 =?gb2312?B?OWYyajhpL0JPT2Y3bFJ6VGkwY3dJalBKRC9pVUZ2azNDUVcvYlJSUjkxajJj?=
 =?gb2312?B?M1dHQ0NJcDFDRm1ZREl4WG4waWxIZkViZVMxd200ZEdrbFdxclNOU2U4MHpF?=
 =?gb2312?B?Q1R6K0JseXN5Nmt3ejE2aUlHRjc5aTBxVFNPMkl6ZzNDRnJ0eC9ZU1hxZVVR?=
 =?gb2312?B?QlVLWUpRZFpoQjdyQngwbW14bzR0ZVcwNjM4UXp0dG1JUjBvdkpwbzB2Mjc0?=
 =?gb2312?B?cVYrai9JbFBEWXdqZ3p2dExFNU1jWXgvelRKRnhXenkwcUdURTZrVDJ1dzUw?=
 =?gb2312?B?U0F6KzkwYlFNNzNMWjdFN25jcWRZekVZUkJodDc0ZStWa3RNVzN4UE5pV2hX?=
 =?gb2312?B?R2x6UFFLQUxIWDdOdVdEdzZZdHA5R3F3UUhCRk42NDBQalE3ME1LbmhBT25Y?=
 =?gb2312?B?cHdKUDhOaFV6YUR1K05QVGxuNHRYUlBzSnAxakF2SEdhdEZXZlV2MW1pZ1F3?=
 =?gb2312?B?czFiUXRBTzI0QmJmMGdPNEp2NFVPdzZSN0YyQWZmZDAxSUpYZXpySHozRVB0?=
 =?gb2312?B?OUJTYlVmVGJFRmtwWXBGbFRYTmRHZzZEM0Fta3pBaVZOYmRrK3lwRXFra3Fx?=
 =?gb2312?B?M1Uwd0tCV3VQd0FHM3FFbHJNZmhGajRnUUdWSTRmTmx1Y1A4UHU4YnZVRXhT?=
 =?gb2312?B?aHFpVW9NV2pxTllmMlF5OVVZZFJGS2ZTd0tNVS8yUS9ybGJBaGhHZGxXL3Fv?=
 =?gb2312?B?S2hiQWt5cFpkUFY2UmJ4clhOVlJ5QW1OK3BWVGw5VXgrL2c5M0paZDc3VHdE?=
 =?gb2312?B?ME5sUW5lY3NuZUlsdzF4MTYyK0FvYWJBOGkvaFdSQmxXaHpVak41bVpLZmJE?=
 =?gb2312?Q?9wes=3D?=
Content-Type: multipart/mixed;
 boundary="_004_SEZPR02MB5760561E4DE60AB5BE743B6EB3149SEZPR02MB5760apcp_"
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB5760.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d7546e-4754-470c-1f92-08dad377ddd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 08:41:40.1982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VEWvRIz5HtMUbHoS38MIc01jmGMOSugw9dKNQAaRtzgPGyOpI7/2tnxfINLpBJIq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR02MB4965
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 05 Dec 2022 12:13:38 +0100
Subject: [LTP] About the diotest4 failure on linux kernel 5.15
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
From: =?utf-8?b?57Kf6IiqKEJyeWNlKSB2aWEgbHRw?= <ltp@lists.linux.it>
Reply-To: =?gb2312?B?y9q6vShCcnljZSk=?= <suhang@oppo.com>
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--_004_SEZPR02MB5760561E4DE60AB5BE743B6EB3149SEZPR02MB5760apcp_
Content-Type: multipart/alternative;
	boundary="_000_SEZPR02MB5760561E4DE60AB5BE743B6EB3149SEZPR02MB5760apcp_"

--_000_SEZPR02MB5760561E4DE60AB5BE743B6EB3149SEZPR02MB5760apcp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGVsbG8sSSBwb3J0ZWQgbHRwIHRvIEFuZHJvaWQgZm9yIHRlc3RpbmcuIFRoZSBkaW90ZXN0NCB0
ZXN0IG9uIHRoZSBMaW51eCBrZXJuZWwgNS4xNSBkZXZpY2UgZmFpbGVkLiBUaGUgZmlsZSBzeXN0
ZW0gd2FzIGNvcnJlY3RlZCB3aGVuIHRoZSB0ZXN0IHdhcyBydW4gdG8gdGVzdDMuIFRoZSBjb3Jy
ZWN0IHZhbHVlcyB3ZXJlIHBhc3NlZCB0byB0aGUgbmV4dCBsYXllci4gSG93IGNhbiBJIHNvbHZl
IHRoaXMgcHJvYmxlbT8gVGhlIHNhbWUgcHJvYmxlbSBkb2VzIG5vdCBvY2N1ciBpbiBvdGhlciBs
aW51eCBrZXJuZWwgdmVyc2lvbnMuDQpUaGUgZm9sbG93aW5nIGFyZSBsb2dzLCBhbmQgdGhlIHJl
bGF0ZWQgdHJhY2VzIGluIGV4dHJhIGZpbGUuDQpUZXN0Y2FzZSBSZXN1bHQgRXhpdCBWYWx1ZQ0K
ZGlvMDEgUEFTUyAwDQpkaW8wMiBQQVNTIDANCmRpbzAzIFBBU1MgMA0KZGlvMDQgRkFJTCAzMw0K
ZGlvMDUgUEFTUyAwDQpkaW8wNiBQQVNTIDANCmRpbzA3IFBBU1MgMA0KZGlvMDggUEFTUyAwDQpk
aW8wOSBQQVNTIDANCmRpbzEwIEZBSUwgMzMNCmRpbzExIFBBU1MgMA0KZGlvMTIgUEFTUyAwDQpk
aW8xMyBQQVNTIDANCmRpbzE0IFBBU1MgMA0KZGlvMTUgUEFTUyAwDQpkaW8xNiBQQVNTIDANCmRp
bzE3IFBBU1MgMA0KZGlvMTggUEFTUyAwDQpkaW8xOSBQQVNTIDANCmRpbzIwIFBBU1MgMA0KZGlv
MjEgUEFTUyAwDQpkaW8yMiBQQVNTIDANCmRpbzIzIFBBU1MgMA0KZGlvMjQgUEFTUyAwDQpkaW8y
NSBQQVNTIDANCmRpbzI2IFBBU1MgMA0KZGlvMjcgUEFTUyAwDQpkaW8yOCBQQVNTIDANCmRpbzI5
IFBBU1MgMA0KZGlvMzAgUEFTUyAwDQpUb3RhbCBUZXN0czogMzANClRvdGFsIFNraXBwZWQgVGVz
dHM6IDANClRvdGFsIEZhaWx1cmVzOiAyDQpLZXJuZWwgVmVyc2lvbjogNS4xNS40MS1hbmRyb2lk
MTMtOC1vLWc5ZTg1YjRiNDNjNzYNCk1hY2hpbmUgQXJjaGl0ZWN0dXJlOiBhYXJjaDY0DQpIb3N0
bmFtZTogbG9jYWxob3N0DQo8PDx0ZXN0X3N0YXJ0Pj4+DQp0YWc9ZGlvMDQgc3RpbWU9MTY0MDk2
Njg1NQ0KY21kbGluZT0iZGlvdGVzdDQiDQpjb250YWN0cz0iIg0KYW5hbHlzaXM9ZXhpdA0KPDw8
dGVzdF9vdXRwdXQ+Pj4NCmRpb3Rlc3Q0IDEgVFBBU1MgOiBOZWdhdGl2ZSBPZmZzZXQNCmRpb3Rl
c3Q0IDIgVFBBU1MgOiByZW1vdmVkDQpkaW90ZXN0NCAzIFRGQUlMIDogZGlvdGVzdDQuYzoxMTQ6
IHJlYWQgYWxsb3dzIG9kZCBjb3VudC4gcmV0dXJucyAxOiBTdWNjZXNzDQpkaW90ZXN0NCA0IFRG
QUlMIDogZGlvdGVzdDQuYzoxMjk6IHdyaXRlIGFsbG93cyBvZGQgY291bnQucmV0dXJucyAxOiBT
dWNjZXNzDQpkaW90ZXN0NCA1IFRGQUlMIDogZGlvdGVzdDQuYzoxODA6IE9kZCBjb3VudCBvZiBy
ZWFkIGFuZCB3cml0ZQ0KZGlvdGVzdDQgNiBUUEFTUyA6IFJlYWQgYmV5b25kIHRoZSBmaWxlIHNp
emUNCmRpb3Rlc3Q0IDcgVFBBU1MgOiBJbnZhbGlkIGZpbGUgZGVzY3JpcHRvcg0KZGlvdGVzdDQg
OCBUUEFTUyA6IE91dCBvZiByYW5nZSBmaWxlIGRlc2NyaXB0b3INCmRpb3Rlc3Q0IDkgVFBBU1Mg
OiBDbG9zZWQgZmlsZSBkZXNjcmlwdG9yDQpkaW90ZXN0NCAxMCBUUEFTUyA6IHJlbW92ZWQNCmRp
b3Rlc3Q0IDExIFRDT05GIDogZGlvdGVzdDQuYzozNDY6IERpcmVjdCBJL08gb24gL2Rldi9udWxs
IGlzIG5vdCBzdXBwb3J0ZWQNCmRpb3Rlc3Q0IDEyIFRQQVNTIDogcmVhZCwgd3JpdGUgdG8gYSBt
bWFwZWQgZmlsZQ0KZGlvdGVzdDQgMTMgVFBBU1MgOiByZWFkLCB3cml0ZSB0byBhbiB1bm1hcHBl
ZCBmaWxlDQpkaW90ZXN0NCAxNCBUUEFTUyA6IHJlYWQgZnJvbSBmaWxlIG5vdCBvcGVuIGZvciBy
ZWFkaW5nDQpkaW90ZXN0NCAxNSBUUEFTUyA6IHdyaXRlIHRvIGZpbGUgbm90IG9wZW4gZm9yIHdy
aXRpbmcNCmRpb3Rlc3Q0IDE2IFRGQUlMIDogZGlvdGVzdDQuYzoxMTQ6IHJlYWQgYWxsb3dzIG5v
bmFsaWduZWQgYnVmLiByZXR1cm5zIDQwOTY6IFN1Y2Nlc3MNCmRpb3Rlc3Q0IDE3IFRGQUlMIDog
ZGlvdGVzdDQuYzoxMjk6IHdyaXRlIGFsbG93cyBub25hbGlnbmVkIGJ1Zi5yZXR1cm5zIDQwOTY6
IFN1Y2Nlc3MNCmRpb3Rlc3Q0IDE4IFRGQUlMIDogZGlvdGVzdDQuYzoxODA6IHJlYWQsIHdyaXRl
IHdpdGggbm9uLWFsaWduZWQgYnVmZmVyDQpkaW90ZXN0NCAxOSBUUEFTUyA6IHJlYWQsIHdyaXRl
IGJ1ZmZlciBpbiByZWFkLW9ubHkgc3BhY2UNCmRpb3Rlc3Q0IDIwIFRQQVNTIDogcmVhZCwgd3Jp
dGUgaW4gbm9uLWV4aXN0YW50IHNwYWNlDQpkaW90ZXN0NCAyMSBUUEFTUyA6IHJlYWQsIHdyaXRl
IGZvciBmaWxlIHdpdGggT19TWU5DDQpkaW90ZXN0NCAwIFRJTkZPIDogMi8xNSB0ZXN0IGJsb2Nr
cyBmYWlsZWQNCjw8PGV4ZWN1dGlvbl9zdGF0dXM+Pj4NCmluaXRpYXRpb25fc3RhdHVzPSJvayIN
CmR1cmF0aW9uPTAgdGVybWluYXRpb25fdHlwZT1leGl0ZWQgdGVybWluYXRpb25faWQ9MzMgY29y
ZWZpbGU9bm8NCmN1dGltZT0xIGNzdGltZT0wDQo8PDx0ZXN0X2VuZD4+Pg0KPDw8dGVzdF9zdGFy
dD4+Pg0KdGFnPWRpbzEwIHN0aW1lPTE2NDA5NjY4NTkNCmNtZGxpbmU9ImRpb3Rlc3Q0IC1iIDY1
NTM2Ig0KY29udGFjdHM9IiINCmFuYWx5c2lzPWV4aXQNCjw8PHRlc3Rfb3V0cHV0Pj4+DQpkaW90
ZXN0NCAxIFRQQVNTIDogTmVnYXRpdmUgT2Zmc2V0DQpkaW90ZXN0NCAyIFRQQVNTIDogcmVtb3Zl
ZA0KZGlvdGVzdDQgMyBURkFJTCA6IGRpb3Rlc3Q0LmM6MTE0OiByZWFkIGFsbG93cyBvZGQgY291
bnQuIHJldHVybnMgMTogU3VjY2Vzcw0KZGlvdGVzdDQgNCBURkFJTCA6IGRpb3Rlc3Q0LmM6MTI5
OiB3cml0ZSBhbGxvd3Mgb2RkIGNvdW50LnJldHVybnMgMTogU3VjY2Vzcw0KZGlvdGVzdDQgNSBU
RkFJTCA6IGRpb3Rlc3Q0LmM6MTgwOiBPZGQgY291bnQgb2YgcmVhZCBhbmQgd3JpdGUNCmRpb3Rl
c3Q0IDYgVFBBU1MgOiBSZWFkIGJleW9uZCB0aGUgZmlsZSBzaXplDQpkaW90ZXN0NCA3IFRQQVNT
IDogSW52YWxpZCBmaWxlIGRlc2NyaXB0b3INCmRpb3Rlc3Q0IDggVFBBU1MgOiBPdXQgb2YgcmFu
Z2UgZmlsZSBkZXNjcmlwdG9yDQpkaW90ZXN0NCA5IFRQQVNTIDogQ2xvc2VkIGZpbGUgZGVzY3Jp
cHRvcg0KZGlvdGVzdDQgMTAgVFBBU1MgOiByZW1vdmVkDQpkaW90ZXN0NCAxMSBUQ09ORiA6IGRp
b3Rlc3Q0LmM6MzQ2OiBEaXJlY3QgSS9PIG9uIC9kZXYvbnVsbCBpcyBub3Qgc3VwcG9ydGVkDQpk
aW90ZXN0NCAxMiBUUEFTUyA6IHJlYWQsIHdyaXRlIHRvIGEgbW1hcGVkIGZpbGUNCmRpb3Rlc3Q0
IDEzIFRQQVNTIDogcmVhZCwgd3JpdGUgdG8gYW4gdW5tYXBwZWQgZmlsZQ0KZGlvdGVzdDQgMTQg
VFBBU1MgOiByZWFkIGZyb20gZmlsZSBub3Qgb3BlbiBmb3IgcmVhZGluZw0KZGlvdGVzdDQgMTUg
VFBBU1MgOiB3cml0ZSB0byBmaWxlIG5vdCBvcGVuIGZvciB3cml0aW5nDQpkaW90ZXN0NCAxNiBU
RkFJTCA6IGRpb3Rlc3Q0LmM6MTE0OiByZWFkIGFsbG93cyBub25hbGlnbmVkIGJ1Zi4gcmV0dXJu
cyA0MDk2OiBTdWNjZXNzDQpkaW90ZXN0NCAxNyBURkFJTCA6IGRpb3Rlc3Q0LmM6MTI5OiB3cml0
ZSBhbGxvd3Mgbm9uYWxpZ25lZCBidWYucmV0dXJucyA0MDk2OiBTdWNjZXNzDQpkaW90ZXN0NCAx
OCBURkFJTCA6IGRpb3Rlc3Q0LmM6MTgwOiByZWFkLCB3cml0ZSB3aXRoIG5vbi1hbGlnbmVkIGJ1
ZmZlcg0KZGlvdGVzdDQgMTkgVFBBU1MgOiByZWFkLCB3cml0ZSBidWZmZXIgaW4gcmVhZC1vbmx5
IHNwYWNlDQpkaW90ZXN0NCAyMCBUUEFTUyA6IHJlYWQsIHdyaXRlIGluIG5vbi1leGlzdGFudCBz
cGFjZQ0KZGlvdGVzdDQgMjEgVFBBU1MgOiByZWFkLCB3cml0ZSBmb3IgZmlsZSB3aXRoIE9fU1lO
Qw0KZGlvdGVzdDQgMCBUSU5GTyA6IDIvMTUgdGVzdCBibG9ja3MgZmFpbGVkDQo8PDxleGVjdXRp
b25fc3RhdHVzPj4+DQppbml0aWF0aW9uX3N0YXR1cz0ib2siDQpkdXJhdGlvbj0yMCB0ZXJtaW5h
dGlvbl90eXBlPWV4aXRlZCB0ZXJtaW5hdGlvbl9pZD0zMyBjb3JlZmlsZT1ubw0KY3V0aW1lPTYy
MyBjc3RpbWU9OTM3DQo8PDx0ZXN0X2VuZD4+Pg0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQpPUFBPDQoNCrG+tefX09PKvP68sMbkuL28/rqs09BPUFBPuavLvrXEsaPD3NDF
z6KjrL32z97T2tPKvP7WuMP3tcTK1bz+yMujqLD8uqy49sjLvLDIutfpo6nKudPDoaO9+9a5yM66
zsjL1NrOtL6tytrIqLXEx+m/9s/C0tTIzrrO0M7Kvcq508Oho8jnufvE+rTtytXBy7G+08q8/qOs
x9DO8LSrsqWhorfWt6Khori01sahotOhy6K78sq508OxvtPKvP7WrsjOus6yv7fWu/LG5Mv51NjW
rsjOus7E2sjdo6yyosfrwaK8tNLUtefX09PKvP7NqNaqt6K8/sjLsqLJvrP9sb7Tyrz+vLDG5Li9
vP6how0KzfjC582o0ba5zNPQyLHP3b/JxNy1vNbC08q8/rG7vdjB9KGi0N64xKGitqrKp6Gixsa7
tbvysPy6rLzGy+O7+rKhtr61yLK7sLLIq8fpv/ajrE9QUE+21LTLwOC07c7zu/LSxcKptvjS/dbC
1q7IzrrOy/DKp7jFsruz0LWj1PDIzrKisaPB9NPrsb7Tyrz+z+C52Nau0rvH0MiowPuhow0Ks/23
x8P3yLfLtcP3o6yxvtPKvP68sMbkuL28/s7e0uLX986q1NrIzrrOufq80rvytdjH+Nau0qrUvKGi
1dDAv7vys9DFtaOs0uDO3tLi1/fOqsjOus69u9LXu/K6z82s1q7V/cq9yLfIz6GjILeivP7Iy6Gi
xuTL+cr0u/q5ubvyy/nK9Lv6ubnWrrnYwaq7+rm5u/LIzrrOyc/K9rv6ubnWrrnJtquhoratysKh
orjfvLa53MDtyMvUsaGi1LG5pLvyxuTL+8jOus7Iy6Oo0tTPwrPGobC3orz+yMuhsbvyobBPUFBP
obGjqbK70vKxvtPKvP7Wrs7zy822+LfFxvrG5Mv5z+3WrsjOus7IqMD7o6zS4LK7ttTS8rnK0uK7
8rn9yqfKudPDuMO1yNDFz6K2+NL9t6K78r/JxNzS/beitcTL8Mqns9C1o8jOus7U8MjOoaMNCs7E
u6+y7tLsxfvCtqO60vLIq8fyzsS7r7Lu0uzTsM/so6y1pbS/0tRZRVNcT0u78sbky/u88rWltMq7
47XEu9i4tLKisru5ubPJt6K8/sjLttTIzrrOvbvS17vyus/NrNau1f3Kvci3yM+78r3TytyjrMfr
0+u3orz+yMvU2bTOyLfIz9LUu/G1w8P3yLfK6cPm0uK8+6Gjt6K8/sjLsru21MjOus7K3M7Eu6+y
7tLs07DP7Lb4tbzWwrnK0uK78rTtzvPKudPDuMO1yNDFz6LL+dTss8m1xMjOus7Wsb3Tu/K85L3T
y/C6prPQtaPU8MjOoaMNClRoaXMgZS1tYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBj
b25maWRlbnRpYWwgaW5mb3JtYXRpb24gZnJvbSBPUFBPLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5
IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4g
QW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5IChp
bmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJl
LCByZXByb2R1Y3Rpb24sIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0
aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSBhcmUgbm90IHRo
ZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBkbyBub3QgcmVhZCwgY29weSwgZGlzdHJpYnV0
ZSwgb3IgdXNlIHRoaXMgaW5mb3JtYXRpb24uIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgdHJh
bnNtaXNzaW9uIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkg
YnkgcmVwbHkgZS1tYWlsIGFuZCB0aGVuIGRlbGV0ZSB0aGlzIG1lc3NhZ2UuDQpFbGVjdHJvbmlj
IGNvbW11bmljYXRpb25zIG1heSBjb250YWluIGNvbXB1dGVyIHZpcnVzZXMgb3Igb3RoZXIgZGVm
ZWN0cyBpbmhlcmVudGx5LCBtYXkgbm90IGJlIGFjY3VyYXRlbHkgYW5kL29yIHRpbWVseSB0cmFu
c21pdHRlZCB0byBvdGhlciBzeXN0ZW1zLCBvciBtYXkgYmUgaW50ZXJjZXB0ZWQsIG1vZGlmaWVk
ICxkZWxheWVkLCBkZWxldGVkIG9yIGludGVyZmVyZWQuIE9QUE8gc2hhbGwgbm90IGJlIGxpYWJs
ZSBmb3IgYW55IGRhbWFnZXMgdGhhdCBhcmlzZSBvciBtYXkgYXJpc2UgZnJvbSBzdWNoIG1hdHRl
ciBhbmQgcmVzZXJ2ZXMgYWxsIHJpZ2h0cyBpbiBjb25uZWN0aW9uIHdpdGggdGhlIGVtYWlsLg0K
VW5sZXNzIGV4cHJlc3NseSBzdGF0ZWQsIHRoaXMgZS1tYWlsIGFuZCBpdHMgYXR0YWNobWVudHMg
YXJlIHByb3ZpZGVkIHdpdGhvdXQgYW55IHdhcnJhbnR5LCBhY2NlcHRhbmNlIG9yIHByb21pc2Ug
b2YgYW55IGtpbmQgaW4gYW55IGNvdW50cnkgb3IgcmVnaW9uLCBub3IgY29uc3RpdHV0ZSBhIGZv
cm1hbCBjb25maXJtYXRpb24gb3IgYWNjZXB0YW5jZSBvZiBhbnkgdHJhbnNhY3Rpb24gb3IgY29u
dHJhY3QuIFRoZSBzZW5kZXIsIHRvZ2V0aGVyIHdpdGggaXRzIGFmZmlsaWF0ZXMgb3IgYW55IHNo
YXJlaG9sZGVyLCBkaXJlY3Rvciwgb2ZmaWNlciwgZW1wbG95ZWUgb3IgYW55IG90aGVyIHBlcnNv
biBvZiBhbnkgc3VjaCBpbnN0aXR1dGlvbiAoaGVyZWluYWZ0ZXIgcmVmZXJyZWQgdG8gYXMgInNl
bmRlciIgb3IgIk9QUE8iKSBkb2VzIG5vdCB3YWl2ZSBhbnkgcmlnaHRzIGFuZCBzaGFsbCBub3Qg
YmUgbGlhYmxlIGZvciBhbnkgZGFtYWdlcyB0aGF0IGFyaXNlIG9yIG1heSBhcmlzZSBmcm9tIHRo
ZSBpbnRlbnRpb25hbCBvciBuZWdsaWdlbnQgdXNlIG9mIHN1Y2ggaW5mb3JtYXRpb24uDQpDdWx0
dXJhbCBEaWZmZXJlbmNlcyBEaXNjbG9zdXJlOiBEdWUgdG8gZ2xvYmFsIGN1bHR1cmFsIGRpZmZl
cmVuY2VzLCBhbnkgcmVwbHkgd2l0aCBvbmx5IFlFU1xPSyBvciBvdGhlciBzaW1wbGUgd29yZHMg
ZG9lcyBub3QgY29uc3RpdHV0ZSBhbnkgY29uZmlybWF0aW9uIG9yIGFjY2VwdGFuY2Ugb2YgYW55
IHRyYW5zYWN0aW9uIG9yIGNvbnRyYWN0LCBwbGVhc2UgY29uZmlybSB3aXRoIHRoZSBzZW5kZXIg
YWdhaW4gdG8gZW5zdXJlIGNsZWFyIG9waW5pb24gaW4gd3JpdHRlbiBmb3JtLiBUaGUgc2VuZGVy
IHNoYWxsIG5vdCBiZSByZXNwb25zaWJsZSBmb3IgYW55IGRpcmVjdCBvciBpbmRpcmVjdCBkYW1h
Z2VzIHJlc3VsdGluZyBmcm9tIHRoZSBpbnRlbnRpb25hbCBvciBtaXN1c2Ugb2Ygc3VjaCBpbmZv
cm1hdGlvbi4NCg==

--_000_SEZPR02MB5760561E4DE60AB5BE743B6EB3149SEZPR02MB5760apcp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:=B5=C8=CF=DF;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:=B5=C8=CF=DF;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:=B5=C8=CF=DF;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:=B5=C8=CF=DF;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"text-justi=
fy-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal" align=3D"left" style=3D"mso-margin-top-alt:auto;marg=
in-bottom:12.0pt;text-align:left;background:white">
<span lang=3D"EN-US" style=3D"font-family:&quot;Segoe UI&quot;,sans-serif;c=
olor:#24292F">Hello,I ported ltp to Android for testing. The diotest4 test =
on the Linux kernel 5.15 device failed. The file system was corrected when =
the test was run to test3. The correct values
 were passed to the next layer. How can I solve this problem? The same prob=
lem does not occur in other linux kernel versions.<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"mso-margin-top-alt:auto;marg=
in-bottom:12.0pt;text-align:left;background:white">
<span lang=3D"EN-US" style=3D"font-family:&quot;Segoe UI&quot;,sans-serif;c=
olor:#24292F">The following are logs, and the related traces in extra file.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"margin-bottom:12.0pt;text-al=
ign:left;background:white">
<span lang=3D"EN-US" style=3D"font-family:&quot;Segoe UI&quot;,sans-serif;c=
olor:#24292F">Testcase Result Exit Value<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"margin-bottom:12.0pt;text-al=
ign:left;background:white">
<span lang=3D"EN-US" style=3D"font-family:&quot;Segoe UI&quot;,sans-serif;c=
olor:#24292F">dio01 PASS 0<br>
dio02 PASS 0<br>
dio03 PASS 0<br>
dio04 FAIL 33<br>
dio05 PASS 0<br>
dio06 PASS 0<br>
dio07 PASS 0<br>
dio08 PASS 0<br>
dio09 PASS 0<br>
dio10 FAIL 33<br>
dio11 PASS 0<br>
dio12 PASS 0<br>
dio13 PASS 0<br>
dio14 PASS 0<br>
dio15 PASS 0<br>
dio16 PASS 0<br>
dio17 PASS 0<br>
dio18 PASS 0<br>
dio19 PASS 0<br>
dio20 PASS 0<br>
dio21 PASS 0<br>
dio22 PASS 0<br>
dio23 PASS 0<br>
dio24 PASS 0<br>
dio25 PASS 0<br>
dio26 PASS 0<br>
dio27 PASS 0<br>
dio28 PASS 0<br>
dio29 PASS 0<br>
dio30 PASS 0<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"margin-bottom:12.0pt;text-al=
ign:left;background:white">
<span lang=3D"EN-US" style=3D"font-family:&quot;Segoe UI&quot;,sans-serif;c=
olor:#24292F">Total Tests: 30<br>
Total Skipped Tests: 0<br>
Total Failures: 2<br>
Kernel Version: 5.15.41-android13-8-o-g9e85b4b43c76<br>
Machine Architecture: aarch64<br>
Hostname: localhost<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"mso-margin-bottom-alt:auto;t=
ext-align:left;background:white">
<span lang=3D"EN-US" style=3D"font-family:&quot;Segoe UI&quot;,sans-serif;c=
olor:#24292F">&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>
tag=3Ddio04 stime=3D1640966855<br>
cmdline=3D&quot;diotest4&quot;<br>
contacts=3D&quot;&quot;<br>
analysis=3Dexit<br>
&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>
diotest4 1 TPASS : Negative Offset<br>
diotest4 2 TPASS : removed<br>
diotest4 3 TFAIL : diotest4.c:114: read allows odd count. returns 1: Succes=
s<br>
diotest4 4 TFAIL : diotest4.c:129: write allows odd count.returns 1: Succes=
s<br>
diotest4 5 TFAIL : diotest4.c:180: Odd count of read and write<br>
diotest4 6 TPASS : Read beyond the file size<br>
diotest4 7 TPASS : Invalid file descriptor<br>
diotest4 8 TPASS : Out of range file descriptor<br>
diotest4 9 TPASS : Closed file descriptor<br>
diotest4 10 TPASS : removed<br>
diotest4 11 TCONF : diotest4.c:346: Direct I/O on /dev/null is not supporte=
d<br>
diotest4 12 TPASS : read, write to a mmaped file<br>
diotest4 13 TPASS : read, write to an unmapped file<br>
diotest4 14 TPASS : read from file not open for reading<br>
diotest4 15 TPASS : write to file not open for writing<br>
diotest4 16 TFAIL : diotest4.c:114: read allows nonaligned buf. returns 409=
6: Success<br>
diotest4 17 TFAIL : diotest4.c:129: write allows nonaligned buf.returns 409=
6: Success<br>
diotest4 18 TFAIL : diotest4.c:180: read, write with non-aligned buffer<br>
diotest4 19 TPASS : read, write buffer in read-only space<br>
diotest4 20 TPASS : read, write in non-existant space<br>
diotest4 21 TPASS : read, write for file with O_SYNC<br>
diotest4 0 TINFO : 2/15 test blocks failed<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>
initiation_status=3D&quot;ok&quot;<br>
duration=3D0 termination_type=3Dexited termination_id=3D33 corefile=3Dno<br=
>
cutime=3D1 cstime=3D0<br>
&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>
&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>
tag=3Ddio10 stime=3D1640966859<br>
cmdline=3D&quot;diotest4 -b 65536&quot;<br>
contacts=3D&quot;&quot;<br>
analysis=3Dexit<br>
&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>
diotest4 1 TPASS : Negative Offset<br>
diotest4 2 TPASS : removed<br>
diotest4 3 TFAIL : diotest4.c:114: read allows odd count. returns 1: Succes=
s<br>
diotest4 4 TFAIL : diotest4.c:129: write allows odd count.returns 1: Succes=
s<br>
diotest4 5 TFAIL : diotest4.c:180: Odd count of read and write<br>
diotest4 6 TPASS : Read beyond the file size<br>
diotest4 7 TPASS : Invalid file descriptor<br>
diotest4 8 TPASS : Out of range file descriptor<br>
diotest4 9 TPASS : Closed file descriptor<br>
diotest4 10 TPASS : removed<br>
diotest4 11 TCONF : diotest4.c:346: Direct I/O on /dev/null is not supporte=
d<br>
diotest4 12 TPASS : read, write to a mmaped file<br>
diotest4 13 TPASS : read, write to an unmapped file<br>
diotest4 14 TPASS : read from file not open for reading<br>
diotest4 15 TPASS : write to file not open for writing<br>
diotest4 16 TFAIL : diotest4.c:114: read allows nonaligned buf. returns 409=
6: Success<br>
diotest4 17 TFAIL : diotest4.c:129: write allows nonaligned buf.returns 409=
6: Success<br>
diotest4 18 TFAIL : diotest4.c:180: read, write with non-aligned buffer<br>
diotest4 19 TPASS : read, write buffer in read-only space<br>
diotest4 20 TPASS : read, write in non-existant space<br>
diotest4 21 TPASS : read, write for file with O_SYNC<br>
diotest4 0 TINFO : 2/15 test blocks failed<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>
initiation_status=3D&quot;ok&quot;<br>
duration=3D20 termination_type=3Dexited termination_id=3D33 corefile=3Dno<b=
r>
cutime=3D623 cstime=3D937<br>
&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>
<br>
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
<hr>
<div style=3D"font-size: 12px;"><strong style=3D"color: rgb(32, 31, 28); fo=
nt-family: Arial;">OPPO
</strong></div>
<div style=3D"margin:0cm;text-align:justify;font-size:9px;font-family:&quot=
;=CE=A2=C8=ED=D1=C5=BA=DA&quot;,sans-serif;margin-bottom:15.6pt;">
<span style=3D"font-size:9pt;font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=DA&quo=
t;,serif;color:#cacac8;"><br>
=B1=BE=B5=E7=D7=D3=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=BA=AC=D3=D0OPPO=B9=
=AB=CB=BE=B5=C4=B1=A3=C3=DC=D0=C5=CF=A2=A3=AC=BD=F6=CF=DE=D3=DA=D3=CA=BC=FE=
=D6=B8=C3=F7=B5=C4=CA=D5=BC=FE=C8=CB=A3=A8=B0=FC=BA=AC=B8=F6=C8=CB=BC=B0=C8=
=BA=D7=E9=A3=A9=CA=B9=D3=C3=A1=A3=BD=FB=D6=B9=C8=CE=BA=CE=C8=CB=D4=DA=CE=B4=
=BE=AD=CA=DA=C8=A8=B5=C4=C7=E9=BF=F6=CF=C2=D2=D4=C8=CE=BA=CE=D0=CE=CA=BD=CA=
=B9=D3=C3=A1=A3=C8=E7=B9=FB=C4=FA=B4=ED=CA=D5=C1=CB=B1=BE=D3=CA=BC=FE=A3=AC=
=C7=D0=CE=F0=B4=AB=B2=A5=A1=A2=B7=D6=B7=A2=A1=A2=B8=B4=D6=C6=A1=A2=D3=A1=CB=
=A2=BB=F2=CA=B9=D3=C3=B1=BE=D3=CA=BC=FE=D6=AE=C8=CE=BA=CE=B2=BF=B7=D6=BB=F2=
=C6=E4=CB=F9=D4=D8=D6=AE=C8=CE=BA=CE=C4=DA=C8=DD=A3=AC=B2=A2=C7=EB=C1=A2=BC=
=B4=D2=D4=B5=E7=D7=D3=D3=CA=BC=FE=CD=A8=D6=AA=B7=A2=BC=FE=C8=CB=B2=A2=C9=BE=
=B3=FD=B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=A1=A3
<br>
=CD=F8=C2=E7=CD=A8=D1=B6=B9=CC=D3=D0=C8=B1=CF=DD=BF=C9=C4=DC=B5=BC=D6=C2=D3=
=CA=BC=FE=B1=BB=BD=D8=C1=F4=A1=A2=D0=DE=B8=C4=A1=A2=B6=AA=CA=A7=A1=A2=C6=C6=
=BB=B5=BB=F2=B0=FC=BA=AC=BC=C6=CB=E3=BB=FA=B2=A1=B6=BE=B5=C8=B2=BB=B0=B2=C8=
=AB=C7=E9=BF=F6=A3=ACOPPO=B6=D4=B4=CB=C0=E0=B4=ED=CE=F3=BB=F2=D2=C5=C2=A9=
=B6=F8=D2=FD=D6=C2=D6=AE=C8=CE=BA=CE=CB=F0=CA=A7=B8=C5=B2=BB=B3=D0=B5=A3=D4=
=F0=C8=CE=B2=A2=B1=A3=C1=F4=D3=EB=B1=BE=D3=CA=BC=FE=CF=E0=B9=D8=D6=AE=D2=BB=
=C7=D0=C8=A8=C0=FB=A1=A3
</span><span style=3D"font-size:9pt;font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=
=DA&quot;,serif;color:#cacac8;"><strong><br>
=B3=FD=B7=C7=C3=F7=C8=B7=CB=B5=C3=F7=A3=AC=B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=
=BD=BC=FE=CE=DE=D2=E2=D7=F7=CE=AA=D4=DA=C8=CE=BA=CE=B9=FA=BC=D2=BB=F2=B5=D8=
=C7=F8=D6=AE=D2=AA=D4=BC=A1=A2=D5=D0=C0=BF=BB=F2=B3=D0=C5=B5=A3=AC=D2=E0=CE=
=DE=D2=E2=D7=F7=CE=AA=C8=CE=BA=CE=BD=BB=D2=D7=BB=F2=BA=CF=CD=AC=D6=AE=D5=FD=
=CA=BD=C8=B7=C8=CF=A1=A3 </span></strong><span style=3D"font-size:9pt;font-=
family:&quot;=CE=A2=C8=ED=D1=C5=BA=DA&quot;,serif;color:#cacac8;">=B7=A2=BC=
=FE=C8=CB=A1=A2=C6=E4=CB=F9=CA=F4=BB=FA=B9=B9=BB=F2=CB=F9=CA=F4=BB=FA=B9=B9=
=D6=AE=B9=D8=C1=AA=BB=FA=B9=B9=BB=F2=C8=CE=BA=CE=C9=CF=CA=F6=BB=FA=B9=B9=D6=
=AE=B9=C9=B6=AB=A1=A2=B6=AD=CA=C2=A1=A2=B8=DF=BC=B6=B9=DC=C0=ED=C8=CB=D4=B1=
=A1=A2=D4=B1=B9=A4=BB=F2=C6=E4=CB=FB=C8=CE=BA=CE=C8=CB=A3=A8=D2=D4=CF=C2=B3=
=C6=A1=B0=B7=A2=BC=FE=C8=CB=A1=B1=BB=F2=A1=B0OPPO=A1=B1=A3=A9=B2=BB=D2=F2=
=B1=BE=D3=CA=BC=FE=D6=AE=CE=F3=CB=CD=B6=F8=B7=C5=C6=FA=C6=E4=CB=F9=CF=ED=D6=
=AE=C8=CE=BA=CE=C8=A8=C0=FB=A3=AC=D2=E0=B2=BB=B6=D4=D2=F2=B9=CA=D2=E2=BB=F2=
=B9=FD=CA=A7=CA=B9=D3=C3=B8=C3=B5=C8=D0=C5=CF=A2=B6=F8=D2=FD=B7=A2=BB=F2=BF=
=C9=C4=DC=D2=FD=B7=A2=B5=C4=CB=F0=CA=A7=B3=D0=B5=A3=C8=CE=BA=CE=D4=F0=C8=CE=
=A1=A3
</span><span style=3D"font-size:9pt;font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=
=DA&quot;,serif;color:#cacac8;"><strong><br>
=CE=C4=BB=AF=B2=EE=D2=EC=C5=FB=C2=B6=A3=BA=D2=F2=C8=AB=C7=F2=CE=C4=BB=AF=B2=
=EE=D2=EC=D3=B0=CF=EC=A3=AC=B5=A5=B4=BF=D2=D4YES\OK=BB=F2=C6=E4=CB=FB=BC=F2=
=B5=A5=B4=CA=BB=E3=B5=C4=BB=D8=B8=B4=B2=A2=B2=BB=B9=B9=B3=C9=B7=A2=BC=FE=C8=
=CB=B6=D4=C8=CE=BA=CE=BD=BB=D2=D7=BB=F2=BA=CF=CD=AC=D6=AE=D5=FD=CA=BD=C8=B7=
=C8=CF=BB=F2=BD=D3=CA=DC=A3=AC=C7=EB=D3=EB=B7=A2=BC=FE=C8=CB=D4=D9=B4=CE=C8=
=B7=C8=CF=D2=D4=BB=F1=B5=C3=C3=F7=C8=B7=CA=E9=C3=E6=D2=E2=BC=FB=A1=A3=B7=A2=
=BC=FE=C8=CB=B2=BB=B6=D4=C8=CE=BA=CE=CA=DC=CE=C4=BB=AF=B2=EE=D2=EC=D3=B0=CF=
=EC=B6=F8=B5=BC=D6=C2=B9=CA=D2=E2=BB=F2=B4=ED=CE=F3=CA=B9=D3=C3=B8=C3=B5=C8=
=D0=C5=CF=A2=CB=F9=D4=EC=B3=C9=B5=C4=C8=CE=BA=CE=D6=B1=BD=D3=BB=F2=BC=E4=BD=
=D3=CB=F0=BA=A6=B3=D0=B5=A3=D4=F0=C8=CE=A1=A3
</span></strong><span style=3D"font-size:12px;font-family:&quot;Arial&quot;=
,serif;color:#cacac8;"><br>
This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial
 disclosure, reproduction, or dissemination) by persons other than the inte=
nded recipient(s) is prohibited. If you are not the intended recipient, ple=
ase do not read, copy, distribute, or use this information. If you have rec=
eived this transmission in error,
 please notify the sender immediately by reply e-mail and then delete this =
message.
</span><span style=3D"font-size:12px;font-family:&quot;Arial&quot;,serif;co=
lor:#cacac8;"><br>
Electronic communications may contain computer viruses or other defects inh=
erently, may not be accurately and/or timely transmitted to other systems, =
or may be intercepted, modified ,delayed, deleted or interfered. OPPO shall=
 not be liable for any damages that
 arise or may arise from such matter and reserves all rights in connection =
with the email.
</span><span style=3D"font-size:12px;font-family:&quot;Arial&quot;,serif;co=
lor:#cacac8;"><strong><br>
Unless expressly stated, this e-mail and its attachments are provided witho=
ut any warranty, acceptance or promise of any kind in any country or region=
, nor constitute a formal confirmation or acceptance of any transaction or =
contract.
</span></strong><span style=3D"font-size:12px;font-family:&quot;Arial&quot;=
,serif;color:#cacac8;">The sender, together with its affiliates or any shar=
eholder, director, officer, employee or any other person of any such instit=
ution (hereinafter referred to as &quot;sender&quot; or
 &quot;OPPO&quot;) does not waive any rights and shall not be liable for an=
y damages that arise or may arise from the intentional or negligent use of =
such information.
</span><span style=3D"font-size:12px;font-family:&quot;Arial&quot;,serif;co=
lor:#cacac8;"><strong><br>
Cultural Differences Disclosure: Due to global cultural differences, any re=
ply with only YES\OK or other simple words does not constitute any confirma=
tion or acceptance of any transaction or contract, please confirm with the =
sender again to ensure clear opinion
 in written form. The sender shall not be responsible for any direct or ind=
irect damages resulting from the intentional or misuse of such information.
</span></strong></div>
</body>
</html>

--_000_SEZPR02MB5760561E4DE60AB5BE743B6EB3149SEZPR02MB5760apcp_--

--_004_SEZPR02MB5760561E4DE60AB5BE743B6EB3149SEZPR02MB5760apcp_
Content-Type: text/plain; name="ltpftrace.txt"
Content-Description: ltpftrace.txt
Content-Disposition: attachment; filename="ltpftrace.txt"; size=4534;
	creation-date="Thu, 01 Dec 2022 08:27:16 GMT";
	modification-date="Thu, 01 Dec 2022 08:41:39 GMT"
Content-Transfer-Encoding: base64

IyB0cmFjZXI6IG5vcAojCiMgZW50cmllcy1pbi1idWZmZXIvZW50cmllcy13cml0dGVuOiAyNC8y
NCAgICNQOjgKIyBlbmFibGVkIGV2ZW50czogZjJmczpmMmZzX2RpcmVjdF9JT19lbnRlciBmMmZz
OmYyZnNfZGlyZWN0X0lPX2V4aXQjCiMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF8t
LS0tLT0+IGlycXMtb2ZmCiMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyBfLS0tLT0+
IG5lZWQtcmVzY2hlZAojICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAvIF8tLS09PiBo
YXJkaXJxL3NvZnRpcnEKIyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHx8IC8gXy0tPT4g
cHJlZW1wdC1kZXB0aAojICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfHx8IC8gXy09PiBt
aWdyYXRlLWRpc2FibGUKIyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHx8fHwgLyAgICAg
ZGVsYXkKIyAgICAgICAgICAgVEFTSy1QSUQgICAgIENQVSMgIHx8fHx8ICBUSU1FU1RBTVAgIEZV
TkNUSU9OCiMgICAgICAgICAgICAgIHwgfCAgICAgICAgIHwgICB8fHx8fCAgICAgfCAgICAgICAg
IHwKICAgICAgICBkaW90ZXN0NC0xMzMyNCAgIFswMDZdIC4uLi4uICAxMDQ2LjEwOTcwNDogZjJm
c19kaXJlY3RfSU9fZW50ZXI6IGRldiA9ICgyNTQsNTMpLCBpbm8gPSAxODg5OCBwb3MgPSAtMjcz
OTMwNjMzODcyIGxlbiA9IDQwOTYga2lfZmxhZ3MgPSBjNDlmNmMwMCBraV9oaW50ID0gZmY4MSBr
aV9pb3ByaW8gPSBmM2ZmIHJ3ID0gMQogICAgICAgIGRpb3Rlc3Q0LTEzMzI0ICAgWzAwNl0gLi4u
Li4gIDEwNDYuMTE1MDU1OiBmMmZzX2RpcmVjdF9JT19leGl0OiBkZXYgPSAoMjU0LDUzKSwgaW5v
ID0gMTg4OTggcG9zID0gMCBsZW4gPSA0MDk2IHJ3ID0gMSByZXQgPSA0MDk2CiAgICAgICAgZGlv
dGVzdDQtMTMzMjQgICBbMDA2XSAuLi4uLiAgMTA0Ni4xMTUzMTI6IGYyZnNfZGlyZWN0X0lPX2Vu
dGVyOiBkZXYgPSAoMjU0LDUzKSwgaW5vID0gMTg4OTggcG9zID0gLTI3MzkzMDYzMzg3MiBsZW4g
PSA0MDk2IGtpX2ZsYWdzID0gYzQ5ZjZjMDAga2lfaGludCA9IGZmODEga2lfaW9wcmlvID0gZjNm
ZiBydyA9IDAKICAgICAgICBkaW90ZXN0NC0xMzMyNCAgIFswMDZdIC4uLi4uICAxMDQ2LjExNTMx
NDogZjJmc19kaXJlY3RfSU9fZXhpdDogZGV2ID0gKDI1NCw1MyksIGlubyA9IDE4ODk4IHBvcyA9
IDQ1MDU2IGxlbiA9IDQwOTYgcncgPSAwIHJldCA9IDAKICAgICAgICBkaW90ZXN0NC0xMzMyNCAg
IFswMDZdIC4uLi4uICAxMDQ2LjExNTQ0OTogZjJmc19kaXJlY3RfSU9fZW50ZXI6IGRldiA9ICgy
NTQsNTMpLCBpbm8gPSAxODg5OCBwb3MgPSAtMjczOTMwNjMzODcyIGxlbiA9IDQwOTYga2lfZmxh
Z3MgPSBjNDlmNmMwMCBraV9oaW50ID0gZmY4MSBraV9pb3ByaW8gPSBmM2ZmIHJ3ID0gMAogICAg
ICAgIGRpb3Rlc3Q0LTEzMzI0ICAgWzAwNl0gLi4uLi4gIDEwNDYuMTE1NDUwOiBmMmZzX2RpcmVj
dF9JT19leGl0OiBkZXYgPSAoMjU0LDUzKSwgaW5vID0gMTg4OTggcG9zID0gNDA5NiBsZW4gPSA0
MDk2IHJ3ID0gMCByZXQgPSAwCiAgICAgICAgZGlvdGVzdDQtMTMzMjQgICBbMDA2XSAuLi4uLiAg
MTA0Ni4xMTU0NjQ6IGYyZnNfZGlyZWN0X0lPX2VudGVyOiBkZXYgPSAoMjU0LDUzKSwgaW5vID0g
MTg4OTggcG9zID0gLTI3MzkzMDYzMzg3MiBsZW4gPSA0MDk2IGtpX2ZsYWdzID0gYzQ5ZjZjMDAg
a2lfaGludCA9IGZmODEga2lfaW9wcmlvID0gZjNmZiBydyA9IDEKICAgICAgICBkaW90ZXN0NC0x
MzMyNCAgIFswMDZdIC4uLi4uICAxMDQ2LjExNTYwODogZjJmc19kaXJlY3RfSU9fZXhpdDogZGV2
ID0gKDI1NCw1MyksIGlubyA9IDE4ODk4IHBvcyA9IDQwOTYgbGVuID0gNDA5NiBydyA9IDEgcmV0
ID0gNDA5NgogICAgICAgIGRpb3Rlc3Q0LTEzMzI0ICAgWzAwNl0gLi4uLi4gIDEwNDYuMTE1NjM3
OiBmMmZzX2RpcmVjdF9JT19lbnRlcjogZGV2ID0gKDI1NCw1MyksIGlubyA9IDE4ODk4IHBvcyA9
IC0yNzM5MzA2MzM4NzIgbGVuID0gNDA5NiBraV9mbGFncyA9IGM0OWY2YzAwIGtpX2hpbnQgPSBm
ZjgxIGtpX2lvcHJpbyA9IGYzZmYgcncgPSAwCiAgICAgICAgZGlvdGVzdDQtMTMzMjQgICBbMDA2
XSAuLi4uLiAgMTA0Ni4xMTU3MTM6IGYyZnNfZGlyZWN0X0lPX2V4aXQ6IGRldiA9ICgyNTQsNTMp
LCBpbm8gPSAxODg5OCBwb3MgPSA0MDk2IGxlbiA9IDQwOTYgcncgPSAwIHJldCA9IDQwOTYKICAg
ICAgICBkaW90ZXN0NC0xMzMyNCAgIFswMDZdIC4uLi4uICAxMDQ2LjExNTcxODogZjJmc19kaXJl
Y3RfSU9fZW50ZXI6IGRldiA9ICgyNTQsNTMpLCBpbm8gPSAxODg5OCBwb3MgPSAtMjczOTMwNjMz
ODcyIGxlbiA9IDQwOTYga2lfZmxhZ3MgPSBjNDlmNmMwMCBraV9oaW50ID0gZmY4MSBraV9pb3By
aW8gPSBmM2ZmIHJ3ID0gMQogICAgICAgIGRpb3Rlc3Q0LTEzMzI0ICAgWzAwNl0gLi4uLi4gIDEw
NDYuMTE1ODQ0OiBmMmZzX2RpcmVjdF9JT19leGl0OiBkZXYgPSAoMjU0LDUzKSwgaW5vID0gMTg4
OTggcG9zID0gNDA5NiBsZW4gPSA0MDk2IHJ3ID0gMSByZXQgPSA0MDk2CiAgICAgICAgZGlvdGVz
dDQtMTMzMjQgICBbMDA2XSAuLi4uLiAgMTA0Ni4xMTYwMTg6IGYyZnNfZGlyZWN0X0lPX2VudGVy
OiBkZXYgPSAoMjU0LDUzKSwgaW5vID0gMTg4OTggcG9zID0gLTI3MzkzMDYzMzg3MiBsZW4gPSA0
MDk2IGtpX2ZsYWdzID0gYzQ5ZjZjMDAga2lfaGludCA9IGZmODEga2lfaW9wcmlvID0gZjNmZiBy
dyA9IDAKICAgICAgICBkaW90ZXN0NC0xMzMyNCAgIFswMDZdIC4uLi4uICAxMDQ2LjExNjEyMDog
ZjJmc19kaXJlY3RfSU9fZXhpdDogZGV2ID0gKDI1NCw1MyksIGlubyA9IDE4ODk4IHBvcyA9IDQw
OTYgbGVuID0gNDA5NiBydyA9IDAgcmV0ID0gLTE0CiAgICAgICAgZGlvdGVzdDQtMTMzMjQgICBb
MDA2XSAuLi4uLiAgMTA0Ni4xMTYxMjU6IGYyZnNfZGlyZWN0X0lPX2VudGVyOiBkZXYgPSAoMjU0
LDUzKSwgaW5vID0gMTg4OTggcG9zID0gLTI3MzkzMDYzMzg3MiBsZW4gPSA0MDk2IGtpX2ZsYWdz
ID0gYzQ5ZjZjMDAga2lfaGludCA9IGZmODEga2lfaW9wcmlvID0gZjNmZiBydyA9IDEKICAgICAg
ICBkaW90ZXN0NC0xMzMyNCAgIFswMDZdIC4uLi4uICAxMDQ2LjExNjIxOTogZjJmc19kaXJlY3Rf
SU9fZXhpdDogZGV2ID0gKDI1NCw1MyksIGlubyA9IDE4ODk4IHBvcyA9IDQwOTYgbGVuID0gNDA5
NiBydyA9IDEgcmV0ID0gNDA5NgogICAgICAgIGRpb3Rlc3Q0LTEzMzI0ICAgWzAwNl0gLi4uLi4g
IDEwNDYuMTE2MjQ0OiBmMmZzX2RpcmVjdF9JT19lbnRlcjogZGV2ID0gKDI1NCw1MyksIGlubyA9
IDE4ODk4IHBvcyA9IC0yNzM5MzA2MzM4NzIgbGVuID0gNDA5NiBraV9mbGFncyA9IGM0OWY2YzAw
IGtpX2hpbnQgPSBmZjgxIGtpX2lvcHJpbyA9IGYzZmYgcncgPSAwCiAgICAgICAgZGlvdGVzdDQt
MTMzMjQgICBbMDA2XSAuLi4uLiAgMTA0Ni4xMTYyNDg6IGYyZnNfZGlyZWN0X0lPX2V4aXQ6IGRl
diA9ICgyNTQsNTMpLCBpbm8gPSAxODg5OCBwb3MgPSA0MDk2IGxlbiA9IDQwOTYgcncgPSAwIHJl
dCA9IC0xNAogICAgICAgIGRpb3Rlc3Q0LTEzMzI0ICAgWzAwNl0gLi4uLi4gIDEwNDYuMTE2MjUx
OiBmMmZzX2RpcmVjdF9JT19lbnRlcjogZGV2ID0gKDI1NCw1MyksIGlubyA9IDE4ODk4IHBvcyA9
IC0yNzM5MzA2MzM4NzIgbGVuID0gNDA5NiBraV9mbGFncyA9IGM0OWY2YzAwIGtpX2hpbnQgPSBm
ZjgxIGtpX2lvcHJpbyA9IGYzZmYgcncgPSAxCiAgICAgICAgZGlvdGVzdDQtMTMzMjQgICBbMDA2
XSAuLi4uLiAgMTA0Ni4xMTYyNTQ6IGYyZnNfZGlyZWN0X0lPX2V4aXQ6IGRldiA9ICgyNTQsNTMp
LCBpbm8gPSAxODg5OCBwb3MgPSA0MDk2IGxlbiA9IDQwOTYgcncgPSAxIHJldCA9IC0xNAogICAg
ICAgIGRpb3Rlc3Q0LTEzMzI0ICAgWzAwNl0gLi4uLi4gIDEwNDYuMTE2MjY3OiBmMmZzX2RpcmVj
dF9JT19lbnRlcjogZGV2ID0gKDI1NCw1MyksIGlubyA9IDE4ODk4IHBvcyA9IC0yNzM5MzA2MzM4
NzIgbGVuID0gNDA5NiBraV9mbGFncyA9IGM0OWY2YzAwIGtpX2hpbnQgPSBmZjgxIGtpX2lvcHJp
byA9IGYzZmYgcncgPSAwCiAgICAgICAgZGlvdGVzdDQtMTMzMjQgICBbMDA2XSAuLi4uLiAgMTA0
Ni4xMTYzMzQ6IGYyZnNfZGlyZWN0X0lPX2V4aXQ6IGRldiA9ICgyNTQsNTMpLCBpbm8gPSAxODg5
OCBwb3MgPSA0MDk2IGxlbiA9IDQwOTYgcncgPSAwIHJldCA9IDQwOTYKICAgICAgICBkaW90ZXN0
NC0xMzMyNCAgIFswMDZdIC4uLi4uICAxMDQ2LjExNjMzNzogZjJmc19kaXJlY3RfSU9fZW50ZXI6
IGRldiA9ICgyNTQsNTMpLCBpbm8gPSAxODg5OCBwb3MgPSAtMjczOTMwNjMzODcyIGxlbiA9IDQw
OTYga2lfZmxhZ3MgPSBjNDlmNmMwMCBraV9oaW50ID0gZmY4MSBraV9pb3ByaW8gPSBmM2ZmIHJ3
ID0gMQogICAgICAgIGRpb3Rlc3Q0LTEzMzI0ICAgWzAwNF0gLi4uLi4gIDEwNDYuMTE4NTIwOiBm
MmZzX2RpcmVjdF9JT19leGl0OiBkZXYgPSAoMjU0LDUzKSwgaW5vID0gMTg4OTggcG9zID0gNDA5
NiBsZW4gPSA0MDk2IHJ3ID0gMSByZXQgPSA0MDk2Cg==

--_004_SEZPR02MB5760561E4DE60AB5BE743B6EB3149SEZPR02MB5760apcp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--_004_SEZPR02MB5760561E4DE60AB5BE743B6EB3149SEZPR02MB5760apcp_--
