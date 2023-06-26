Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639F1EB64DD
	for <ltp@archiver.kernel.org>; Mon, 26 Jun 2023 02:37:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFB783CD8A2
	for <ltp@archiver.kernel.org>; Mon, 26 Jun 2023 04:37:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1DF53C9A09
 for <ltp@lists.linux.it>; Mon, 26 Jun 2023 04:36:50 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 98FBB60066E
 for <ltp@lists.linux.it>; Mon, 26 Jun 2023 04:36:47 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS33.andestech.com [10.0.1.100])
 by Atcsqr.andestech.com with ESMTP id 35Q2aaWC057846;
 Mon, 26 Jun 2023 10:36:36 +0800 (+08)
 (envelope-from dylan@andestech.com)
Received: from ATCPCS33.andestech.com (10.0.1.100) by ATCPCS33.andestech.com
 (10.0.1.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 26 Jun
 2023 10:36:37 +0800
Received: from ATCPCS31.andestech.com (10.0.1.89) by ATCPCS33.andestech.com
 (10.0.1.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7 via Frontend
 Transport; Mon, 26 Jun 2023 10:36:37 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (104.47.26.108)
 by mail.andestech.com (10.0.1.89) with Microsoft SMTP Server (TLS) id
 14.3.498.0; Mon, 26 Jun 2023 10:36:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHqAcU1DgbmLa7wvtPKTwybJQZ3N2yjpiFL+n68ooAmBB9ZJRjUyOUyGZU+L9dOYM05NQgkQ83ptvhTqmYpprZOA1P9W163qD2gPN3FOOC1YQuPjd68y5Lac596yeF+chTqn3LzkWtpE712hzHEoJDEAi5MU14jgvgVWbo4J112bHf2QU4QY0xo52h/HrHvOGt1rz6SheeD2laQm+hJ6K4oCVhy+2ZVv+xZsW9tYvKJuHt6WCfgCQMXYF7i2W8+vXiGcWM5TiBr1PF4LsYRo5y1B5k2PkU2ttwSjiGJUEuJy6hDst4dMv+qfGOpESNQFoTRHEd388jcYjUu8xUfFsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBZ2IzP1CPT93nS98l5F+LouJyD1oeebkbeqmT1FYRQ=;
 b=DBv+gorOaxaPo6/A13VGv7TXFcDPGOLTrZjGkrjK6CXhWLc1GRDKalA8t2ey2zkbU5OEhASr+aArj3Q5V6gAxcmz/gu4tn/PitrApzLzxUCOaAfCFQjlpWpYLKMVGbxzC5uHfGtDo9m7RHzLX0gp4krdO3AsRQnwg6ngmNc6bd5n7v7C2y3zEtr6uvON1FcyRd7Po2BUJTQ3xahiNtt9zG3qqjWYCyTuuceQuKajWzrd8FdYyoNGSKRWAl64KmC+tAtQ6FU9h0Et6k3QWXoYKJUUIUT0gyZzzd/+FNYf5XdOxsq3xEe0ULTa1g+p6BqM7kU5IFxm2eWnqYBFW5VxjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
Received: from SEZPR03MB6619.apcprd03.prod.outlook.com (2603:1096:101:7a::6)
 by KL1PR03MB6971.apcprd03.prod.outlook.com (2603:1096:820:b7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 02:36:29 +0000
Received: from SEZPR03MB6619.apcprd03.prod.outlook.com
 ([fe80::c31:ed2d:6d62:4819]) by SEZPR03MB6619.apcprd03.prod.outlook.com
 ([fe80::c31:ed2d:6d62:4819%7]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 02:36:29 +0000
From: =?big5?B?RHlsYW4gRGFpLVJvbmcgSmhvbmcowempp7/EKQ==?= <dylan@andestech.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] hugeshmctl02: Skipped EFAULT tests for libc variant
Thread-Index: AQHZn21QOxrsesyk1Ea83vN6QBN5mK+cbu3A
Date: Mon, 26 Jun 2023 02:36:28 +0000
Message-ID: <SEZPR03MB6619D282CFB8A96C252C75BAAC26A@SEZPR03MB6619.apcprd03.prod.outlook.com>
References: <20230615093933.3185297-1-dylan@andestech.com>
In-Reply-To: <20230615093933.3185297-1-dylan@andestech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6619:EE_|KL1PR03MB6971:EE_
x-ms-office365-filtering-correlation-id: 782baa18-f2d8-429b-8eb7-08db75ee2516
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FB9DFkhLHxRB8JS5YGM9RpEkDKxQM+WHZNPEcrA3TLj7CY3UyUlkk4ApLwZETxChpcZgbtddSevYcERAaEKa3tiT23ThbHlYWEC37nGOzAC8I1mwABKe1pBiG6rgLItPcy8nk8S0sld7YtMGcnhY6YqcpDWpSmdXk8gYh82eYUv56RqhsAEXQv+jUBi9Rbk6JwqgRhSDQEgNnQLZZ9CX0u93LLkBd1HOrvxYX4DUuBSI4DlMpfA2aV4PEBp0NgbXO567cyuh30N9TSe80kJ7vd9vSiS3fiCubnC5y/DgtwftnqlP2D87jUIcViVzYP4Zfx5uCgZ8cQoNrqOEnv5fXLehBIl0jqcbDl2LeIgvmmFBiiHVMMJBYW3cVowXWb+h5UI5o6OUWPB1Bb+8tvlVbumQN7GySk1plMj3tzxlQJx/zDFCI7jWOQraKgYzqDlT5v7l5xK4uYj56dALGAvnyvGk1llB4lMuZWpxmUQ8c9F4bf783Bp8/qBdJsWqPpu6d8snsZPihcTHyccx646ACpe1IJNkN+qjEybW+TCKjqfmUAI8SU3Ix4OklcsI8jx4/bkZRyf3C6eKTrqMVt/An55wh9RQcWtPy7n2mHZM609cApVFwRVtHizf3Z4JWM0Hn55KPvs4OpFgQf89ya/TYyctDlMiN//K8XJySSH51XYdB4Ucknpzt3UBwlmJ+G6U
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB6619.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(39840400004)(376002)(366004)(451199021)(7696005)(966005)(54906003)(478600001)(83380400001)(55016003)(38070700005)(86362001)(66476007)(66446008)(64756008)(33656002)(107886003)(53546011)(186003)(26005)(6506007)(2906002)(71200400001)(9686003)(6916009)(122000001)(85182001)(76116006)(4326008)(316002)(66556008)(66946007)(5660300002)(38100700002)(8936002)(52536014)(8676002)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?RWtsaXZBVGFndzhkNjIzaUxONmRlTFN3Y2ljUUFKS1pEUDN0V0pWMUF2K24rc2lE?=
 =?big5?B?bE9YM0p5cHFiNFNtMVpyZTRERnFxZ0xyYUxMYm5hU1NaOUJRdzhQOG1DYkZtZzBO?=
 =?big5?B?dlU0N29UdStjT1VPUVZaczBJVVBmUXNuNDM4Qlp3VjNlaFVtWmZOODJCdTdTdWM0?=
 =?big5?B?RGRwdmhtanpTeUhlVlBlUGhNbHF5VHY1SjY1S1NyZTk5SEl1UlZiZ2tGbldrQSs4?=
 =?big5?B?M0dObTRpTjZYL25RQnJGeWxtbUhBdGt4NmhFVnRqSXpDSWhDR0RCYWlmRGdCSEtD?=
 =?big5?B?Nk5Uc0JyWDZOMEU2bjhEMnp1RHgxSkJ3b3F3SSs1V1A0cE5mM1ZHeDIvUzd5MlRv?=
 =?big5?B?bGlqdVprUzh1M3h3V0dpTnh3cStFbmk3RGJDR2l0OGFXcHlxdGlrVWJaQzQwRERz?=
 =?big5?B?R1BPWmpIZi9TNXFSWjRuVW9Fdk5BelE2UzVwdDVMTzFvRzZQbGlCRUYvWWRueEN0?=
 =?big5?B?b21xd3RaOE02VGFHbTg2YXpWRDJuMFV1ZE5sM25lVzF3SVRka2VneVBqZzFFUm9R?=
 =?big5?B?b3J3MTFjSG1SaHBKT1hyRmNEcE84U2FudjljRElQb1lsUFpESVo0Nm5YWXZ1ZndF?=
 =?big5?B?WGVLL24vK0xEdk9TNVVDUU9WRkl3M1hEVW5iQ3llN21lSjFhdEdna1JoRzBsMXlQ?=
 =?big5?B?a0xVd0M2cSt5RHJYSWJXNnBwMEpiY3lnbVZMdDlNdHZBZllTcnp3a1J1MXBrdWJI?=
 =?big5?B?VUlzWi93U1ZYUWdsRFNRZU9GbDlYb1ZRNHhpVWg2c0tJOUpUaWV3Sm84dEV6VVFG?=
 =?big5?B?eG84SlczT0doYjBYaVVoWXp1OWEwcUhkNmp4U0ZwSm10VWdoSXNQUGp3Vjl6TzRC?=
 =?big5?B?b3o4Z0dCMHJOcEpXU1RRbTdvd2dEZ0FkSDc4YXV3dHJ5UUdwRDVRUytZZTRwZ2gy?=
 =?big5?B?OVdkM3JlYWJVU0JmSkJEUUQ2Rkh1ekpYS2phd2dtTCtCd2p3ak04YTB5T1NnTTdm?=
 =?big5?B?TWJxUXAvdVcxOVgzeDhnUEVmNUR0ZmllS3czbWowZnAxbEFFTzdiWEI5aFZDVEdk?=
 =?big5?B?czYreDAvZVROUmJCdzZXTDdPZmhYTzZzYU9LMmZ6SllIUXVlYUdUU3VvUVBLTHd3?=
 =?big5?B?ejhLZWVJbzJnZTFlVkVuemRka0pLc0lMZWM3TWErZzRJVk5RUVRCRjd6aGp4UVJ4?=
 =?big5?B?eWdkNFB3SWVjRjBzalNxVU9KdjFORzZ6Z2NaRFNJWk9mNnBvY3RpUE9JbzM1bXV4?=
 =?big5?B?aFlmRStKTjJaWFRjbzNWeFZoLytscUVLN3JzUjU2cU9sdXA5VmlhTXNzNGM3WjYx?=
 =?big5?B?em1rNU4zVWxxdUlXdURDWElpc3RTUlJKQ3Y3N1N6VGYrNmg2bHNHbk1EYTFrRUJt?=
 =?big5?B?U1JoREgycWU4THozVmE0QWxFTmYzYlhhV3dkZnd0UWxUK0VydjBxMEw2RUZRdGRj?=
 =?big5?B?M2UzSlhHWkd3bVRlMjFMQ1ZNMklZUytGQWhwZjZDWWVmT2JLZ1UxWVpaaFZEWThh?=
 =?big5?B?TG15N1pvVHVWbTFCc3dLdkdMQ2Iwdi9TbGNjazk5MDBwZExRQmQ4a2NGZ2FUTTgw?=
 =?big5?B?akt3VnIyZFloWmg5dGpDNGh0VzRZbGZHQUtXWEM4YXVUeGxJdlJ2bkw4eS9NK2Jz?=
 =?big5?B?YjZ5MmRTRit5ckRDOVlrOUhEWW13QTM3QUp3OGNFMURZOC9aNERzMndMSEdjQzhH?=
 =?big5?B?dTc3b2FzZ1U3Tm1OcS92NmQ3RUV6SFltbXBYemFsb2ptQmZNOFBRbVFPOVloRWhj?=
 =?big5?B?a21CL1VqSWx3bEdTVlIxaWducFR4WWJsWTh4dGpGdlU3TEV3NkxoUS9GOTdVMm5z?=
 =?big5?B?dEVkV0V4Sk5UYndqMUJJYy82aFlhMWoxeVN1UnFhQjY0L1UxeVNzSEgwNk5xd0Va?=
 =?big5?B?cHAxNzMreTRoUGlDZ3puQXMraml1VW5lRWN1NldzVnlDZHFmalRaQk4yd3pnSkFx?=
 =?big5?B?YXQ0SnoxZjZSMUl3eFpNRTlnYVY4dzhXZ0orQzJWK0lWeXpZQUVMM2VMS3VJYjA1?=
 =?big5?Q?tag6KnrbHes0/KWVb4UnhJ4hi6CJuw4mr8FnNXeep18=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6619.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782baa18-f2d8-429b-8eb7-08db75ee2516
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 02:36:28.7349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: veYwTw23mZbJ4D94lNu+AEYdP0b5DZSahM1E44v1BVTx64C9lbnh1zjMnEtAJCUEOi9e3Ngsq0rcHWW1oMEePw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6971
X-OriginatorOrg: andestech.com
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 35Q2aaWC057846
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugeshmctl02: Skipped EFAULT tests for libc
 variant
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
Cc: =?big5?B?TWluYSBIdWktTWluIENob3UoqVC8erHTKQ==?= <minachou@andestech.com>,
 =?big5?B?VGltIFNoaWgtVGluZyBPdVlhbmcovNq2p6Rorngp?= <tim609@andestech.com>,
 "x5710999x@gmail.com" <x5710999x@gmail.com>
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQWxsLA0KDQpQaW5nLiBBbnkgY29tbWVudHMgb24gdGhpcyBwYXRjaD8NCg0KVGhhbmtzLA0K
RHlsYW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IER5bGFuIERhaS1Sb25n
IEpob25nKMHpqae/xCkgPGR5bGFuQGFuZGVzdGVjaC5jb20+DQpTZW50OiBUaHVyc2RheSwgSnVu
ZSAxNSwgMjAyMyA1OjQwIFBNDQpUbzogbHRwQGxpc3RzLmxpbnV4Lml0DQpDYzogUmFuZG9scGgg
U2hlbmctS2FpIExpbiiqTLh0s80pIDxyYW5kb2xwaEBhbmRlc3RlY2guY29tPjsgeDU3MTA5OTl4
QGdtYWlsLmNvbTsgVGltIFNoaWgtVGluZyBPdVlhbmcovNq2p6RorngpIDx0aW02MDlAYW5kZXN0
ZWNoLmNvbT47IE1pbmEgSHVpLU1pbiBDaG91KKlQvHqx0ykgPG1pbmFjaG91QGFuZGVzdGVjaC5j
b20+OyBEeWxhbiBEYWktUm9uZyBKaG9uZyjB6amnv8QpIDxkeWxhbkBhbmRlc3RlY2guY29tPg0K
U3ViamVjdDogW0xUUF0gW1BBVENIXSBodWdlc2htY3RsMDI6IFNraXBwZWQgRUZBVUxUIHRlc3Rz
IGZvciBsaWJjIHZhcmlhbnQNCg0KV2hlbiB0ZXN0aW5nIGh1Z2VzaG1jdGwwMiB1bmRlciB0aGUg
MzJiaXQgYXJjaGl0ZWN0dXJlLCBhIHNlZ21lbnRhdGlvbiBmYXVsdCB3aWxsIG9jY3VyLiBUaGlz
IHBhdGNoIHdpbGwgc2tpcCBFRkFVTFQgdGVzdHMgZm9yIGxpYmMgdmFyaWFudC4NCg0KSHVnZXNo
bWN0bDAyIHdpbGwgaW50ZW50aW9uYWxseSBwYXNzICIoc3RydWN0IHNobWlkX2RzICopLTEiIHRv
IHNobWN0bCgpLCBidXQgZ2xpYmMgd2lsbCBwZXJmb3JtIGFuIGFkZGl0aW9uYWwgY29udmVyc2lv
biBmdW5jdGlvbiB3aGVuIHRoZSBhcmNoaXRlY3R1cmUgaXMgMzJiaXQsIHdoaWNoIHdpbGwgdHJ5
IHRvIGNvcHkgYWxsIGl0ZW1zIGluIChzdHJ1Y3Qgc2htaWRfZHMgKikgdG8gYW5vdGhlciBzdHJ1
Y3R1cmVbKjFdLiBJbiB0aGUgcHJvY2VzcyBvZiBjb3B5aW5nLCBpdCBpcyBuZWNlc3NhcnkgdG8g
ZGVyZWZlcmVuY2UgIihzdHJ1Y3Qgc2htaWRfZHMgKiktMSIsIHJlc3VsdGluZyBpbiBzZWdtZW50
YXRpb24gZmF1bHQuDQoNClRoZSBMVFAgYWxzbyBoYXMgc2ltaWxhciBwcm9ibGVtcyBiZWZvcmUs
IHRoaXMgcGF0Y2ggaXMgcmVmZXJlbmNlIGZyb20gdGhlDQpzaG1jdGwwMyBwYXRjaFsqMl0uDQoN
ClsqMV06IGh0dHBzOi8vZ2l0aHViLmNvbS9ibWlub3IvZ2xpYmMvYmxvYi9tYXN0ZXIvc3lzZGVw
cy91bml4L3N5c3YvbGludXgvc2htY3RsLmMjTDM3DQpbKjJdOiBodHRwczovL2dpdGh1Yi5jb20v
bGludXgtdGVzdC1wcm9qZWN0L2x0cC9jb21taXQvYTVhODBhYTg0ODVhN2NiMDE3Zjk2YWJhOGQ3
YjVlYTc5ZjFiYTRkNA0KDQpTaWduZWQtb2ZmLWJ5OiBEeWxhbiBKaG9uZyA8ZHlsYW5AYW5kZXN0
ZWNoLmNvbT4NCi0tLQ0KIC4uLi9tZW0vaHVnZXRsYi9odWdlc2htY3RsL2h1Z2VzaG1jdGwwMi5j
ICAgICB8IDM1ICsrKysrKysrKysrKysrKysrKy0NCiAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vaHVnZXRsYi9odWdlc2htY3RsL2h1Z2VzaG1jdGwwMi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vaHVnZXRsYi9odWdlc2htY3RsL2h1Z2VzaG1jdGwwMi5jDQppbmRleCAwYmM5ZmZkNzQuLmU5
YzJlOWZjOCAxMDA2NDQNCi0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNo
bWN0bC9odWdlc2htY3RsMDIuYw0KKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9o
dWdlc2htY3RsL2h1Z2VzaG1jdGwwMi5jDQpAQCAtMjcsNiArMjcsNyBAQA0KICNpbmNsdWRlIDxw
d2QuaD4NCiAjaW5jbHVkZSA8bGltaXRzLmg+DQogI2luY2x1ZGUgImh1Z2V0bGIuaCINCisjaW5j
bHVkZSAibGFwaS9zeXNjYWxscy5oIg0KDQogc3RhdGljIHNpemVfdCBzaG1fc2l6ZTsNCiBzdGF0
aWMgaW50IHNobV9pZF8xID0gLTE7DQpAQCAtNTAsOSArNTEsMzcgQEAgc3RydWN0IHRjYXNlIHsN
CiAgICAgICAgeyZzaG1faWRfMiwgLTEsICZidWYsIEVJTlZBTH0sDQogfTsNCg0KK3N0YXRpYyBp
bnQgbGliY19zaG1jdGwoaW50IHNobWlkLCBpbnQgY21kLCB2b2lkICpidWYpIHsNCisgICAgICAg
cmV0dXJuIHNobWN0bChzaG1pZCwgY21kLCBidWYpOw0KK30NCisNCitzdGF0aWMgaW50IHN5c19z
aG1jdGwoaW50IHNobWlkLCBpbnQgY21kLCB2b2lkICpidWYpIHsNCisgICAgICAgcmV0dXJuIHRz
dF9zeXNjYWxsKF9fTlJfc2htY3RsLCBzaG1pZCwgY21kLCBidWYpOyB9DQorDQorc3RhdGljIHN0
cnVjdCB0ZXN0X3ZhcmlhbnRzDQorew0KKyAgICAgICBpbnQgKCpzaG1jdGwpKGludCBzaG1pZCwg
aW50IGNtZCwgdm9pZCAqYnVmKTsNCisgICAgICAgY2hhciAqZGVzYzsNCit9IHZhcmlhbnRzW10g
PSB7DQorICAgICAgIHsgLnNobWN0bCA9IGxpYmNfc2htY3RsLCAuZGVzYyA9ICJsaWJjIHNobWN0
bCgpIn0sICNpZiAoX19OUl9zaG1jdGwgIT0NCitfX0xUUF9fTlJfSU5WQUxJRF9TWVNDQUxMKQ0K
KyAgICAgICB7IC5zaG1jdGwgPSBzeXNfc2htY3RsLCAgLmRlc2MgPSAiX19OUl9zaG1jdGwgc3lz
Y2FsbCJ9LCAjZW5kaWYgfTsNCisNCiBzdGF0aWMgdm9pZCB0ZXN0X2h1Z2VzaG1jdGwodW5zaWdu
ZWQgaW50IGkpICB7DQotICAgICAgIFRFU1Qoc2htY3RsKCoodGNhc2VzW2ldLnNobWlkKSwgdGNh
c2VzW2ldLmNtZCwgdGNhc2VzW2ldLnNidWYpKTsNCisgICAgICAgc3RydWN0IHRlc3RfdmFyaWFu
dHMgKnR2ID0gJnZhcmlhbnRzW3RzdF92YXJpYW50XTsNCisNCisgICAgICAgaWYgKHRjYXNlc1tp
XS5lcnJvciA9PSBFRkFVTFQgJiYgdHYtPnNobWN0bCA9PSBsaWJjX3NobWN0bCkgew0KKyAgICAg
ICAgICAgICAgIHRzdF9yZXMoVENPTkYsICJFRkFVTFQgaXMgc2tpcHBlZCBmb3IgbGliYyB2YXJp
YW50Iik7DQorICAgICAgICAgICAgICAgcmV0dXJuOw0KKyAgICAgICB9DQorDQorICAgICAgIFRF
U1QodHYtPnNobWN0bCgqKHRjYXNlc1tpXS5zaG1pZCksIHRjYXNlc1tpXS5jbWQsIHRjYXNlc1tp
XS5zYnVmKSk7DQogICAgICAgIGlmIChUU1RfUkVUICE9IC0xKSB7DQogICAgICAgICAgICAgICAg
dHN0X3JlcyhURkFJTCwgInNobWN0bCBzdWNjZWVkZWQgdW5leHBlY3RlZGx5Iik7DQogICAgICAg
ICAgICAgICAgcmV0dXJuOw0KQEAgLTcwLDggKzk5LDExIEBAIHN0YXRpYyB2b2lkIHRlc3RfaHVn
ZXNobWN0bCh1bnNpZ25lZCBpbnQgaSkNCg0KIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpDQogew0K
KyAgICAgICBzdHJ1Y3QgdGVzdF92YXJpYW50cyAqdHYgPSAmdmFyaWFudHNbdHN0X3ZhcmlhbnRd
Ow0KICAgICAgICBsb25nIGhwYWdlX3NpemU7DQoNCisgICAgICAgdHN0X3JlcyhUSU5GTywgIlRl
c3RpbmcgdmFyaWFudDogJXMiLCB0di0+ZGVzYyk7DQorDQogICAgICAgIGlmICh0c3RfaHVnZXBh
Z2VzID09IDApDQogICAgICAgICAgICAgICAgdHN0X2JyayhUQ09ORiwgIk5vIGVub3VnaCBodWdl
cGFnZXMgZm9yIHRlc3RpbmcuIik7DQoNCkBAIC0xMDEsNiArMTMzLDcgQEAgc3RhdGljIHZvaWQg
Y2xlYW51cCh2b2lkKQ0KDQogc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gew0KICAgICAg
ICAudGVzdCA9IHRlc3RfaHVnZXNobWN0bCwNCisgICAgICAgLnRlc3RfdmFyaWFudHMgPSBBUlJB
WV9TSVpFKHZhcmlhbnRzKSwNCiAgICAgICAgLnRjbnQgPSBBUlJBWV9TSVpFKHRjYXNlcyksDQog
ICAgICAgIC5uZWVkc19yb290ID0gMSwNCiAgICAgICAgLm5lZWRzX3RtcGRpciA9IDEsDQotLQ0K
Mi4zNC4xDQoNCkNPTkZJREVOVElBTElUWSBOT1RJQ0U6DQoNClRoaXMgZS1tYWlsIChhbmQgaXRz
IGF0dGFjaG1lbnRzKSBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgYW5kIGxlZ2FsbHkgcHJpdmls
ZWdlZCBpbmZvcm1hdGlvbiBvciBpbmZvcm1hdGlvbiBwcm90ZWN0ZWQgZnJvbSBkaXNjbG9zdXJl
LiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCB5b3UgYXJlIGhlcmVieSBu
b3RpZmllZCB0aGF0IGFueSBkaXNjbG9zdXJlLCBjb3B5aW5nLCBkaXN0cmlidXRpb24sIG9yIHVz
ZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpcyBzdHJpY3RseSBwcm9oaWJp
dGVkLiBJbiB0aGlzIGNhc2UsIHBsZWFzZSBpbW1lZGlhdGVseSBub3RpZnkgdGhlIHNlbmRlciBi
eSByZXR1cm4gZS1tYWlsLCBkZWxldGUgdGhlIG1lc3NhZ2UgKGFuZCBhbnkgYWNjb21wYW55aW5n
IGRvY3VtZW50cykgYW5kIGRlc3Ryb3kgYWxsIHByaW50ZWQgaGFyZCBjb3BpZXMuIFRoYW5rIHlv
dSBmb3IgeW91ciBjb29wZXJhdGlvbi4NCg0KQ29weXJpZ2h0IEFOREVTIFRFQ0hOT0xPR1kgQ09S
UE9SQVRJT04gLSBBbGwgUmlnaHRzIFJlc2VydmVkLg0KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
