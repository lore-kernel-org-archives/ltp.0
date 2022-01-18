Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D37DC433F5
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 01:11:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6CF23C9638
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 02:11:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C94D3C6F6F
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 02:11:11 +0100 (CET)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D0E496006EE
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 02:11:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1642468271; x=1674004271;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=34Xm48I02T41wRFgqKRyXV9ahELYUvXdf1kg/GXQEVI=;
 b=SiP+p6gJhY2IqgfmRjG1t95q0y5V3WiEdbkE19lYNbPJ3GRGyq0DkXPS
 NZO9aicnli4igSLQsBjtHbrbCAsXhdRVaB82MtYdS1kbZRkoSVb2BPTte
 sxulpnYkUb9knw41WBwnMhHUAQVqKVSuXDLFhffGPaCQhSDS6vDPQVXc9
 plM3cMQzaQGZxUTcHWNN9lMGrrkldafrIiuENVyBXqy0BMXqtRxvi1uF2
 4q5SRodjOY26nLu+S5VMDT6GlJHYDVhVtMXAuSGh94WiShBIoYhcXNuuc
 Nl/OLT7Jl4GjQXCdu5sCMqZMReGLDtOkhp2HHtTryuM0qGgpzelLz3Q4A g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="47487845"
X-IronPort-AV: E=Sophos;i="5.88,296,1635174000"; d="scan'208";a="47487845"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2022 10:11:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjDQZkfG1b1Lm1h4qbzwau0no9VXMXdej7K+J62f+zFh81Wx+N/JEMUXwOO66q2y3KceCj+1LodvOGKmObE+yZir7SuZU7pqxhdJUVG79aTjn9USS6iuCXJHkylnIQ46URaU0CfQmgzs6lXK9eo1nvrZcelmQkicJL99tAiPsHE7fOW9Gj5V8c1BOdCutUv9Pb+tPeGVy/+FYpz6pAbbaXSm/Vz5z0qY/079pKwbxNV6RcGziF4vsYScku0PQGviqcg8C6CHMjWNkc7/S5JhG43ttSUDVb0up9haDZy7M/CJvoTF/QYzb94JtSbgJPXS1Isz2FwVsTcTLoxMmmeECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34Xm48I02T41wRFgqKRyXV9ahELYUvXdf1kg/GXQEVI=;
 b=dGMfQdMATXCWkgtkKvfoyS+cIy0DyWE06frj9Laf/5c981hx2QBv/mpvyDUNLvy53lTKLpl+fWF+1EI0EU5TmFT7PHlzIVq9/IMG/MHJnazYTGBaSNebrnMrEstejmjis486Z859C+4gYtaCq2rAvNeeYEzlexZ40nMEV4ZTlz0MasqyHx47PQUA7d2N843yFPDOGFxlTSC/9BAkfl6DHbMdws0ZSlrHMgPXTpCXqmwysLy7TxcPqHYh3Po5GDEi2FBbz5g7xpY5PwK9IJ0X9ARai+cPZEZe6tOKUXGfDaDot3KhEG8oNDxt7pXHfp4aNQ+aqZ1WMj/WTe01mY14VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34Xm48I02T41wRFgqKRyXV9ahELYUvXdf1kg/GXQEVI=;
 b=iWbX/S5AoNYwc0vwVaXDbUwnV+sScjv0o982lohjBAOeLWwW8QsMHpaLxYZB94c0Pzh1/gWo6GM5ALoW81t5Jq37Qg/KBi2jTAePao+vVbH0M3SVZYgOhhwUrf3Mq6RcdWlaS5zoUBjcgorydtIJtru38bP5/OYaQz3Vg/tcYqw=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB8812.jpnprd01.prod.outlook.com (2603:1096:604:17d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 18 Jan
 2022 01:11:03 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 01:11:03 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [COMMITTED][PATCH] ci/wiki-mirror: Fix triggering CI
Thread-Index: AQHYC4G1tma/DnqG50282b381PJzT6xm79CAgAAO/ICAAPsAgA==
Date: Tue, 18 Jan 2022 01:11:02 +0000
Message-ID: <61E613E5.4040106@fujitsu.com>
References: <20220117090744.30354-1-pvorel@suse.cz>
 <61E534C5.6060005@fujitsu.com> <YeVBV8D3jNtGAxYa@pevik>
In-Reply-To: <YeVBV8D3jNtGAxYa@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1f7d792-7f39-4072-e728-08d9da1f6573
x-ms-traffictypediagnostic: OS3PR01MB8812:EE_
x-microsoft-antispam-prvs: <OS3PR01MB88126BD8729D64E0FA3F8EDEFD589@OS3PR01MB8812.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7POis2SNNLfv5pTs9WMtFcK8UhCieU26oIJdTlxuNkmUYnuKdaNVwBKv+sBd0o++s8JuRVuVJeivoP3FyoPG4282gLbnDPdP2mk+PND1VZqF65+FJh/xJVzRzRnvPAfKmInrkrPsbMyoYRgiP//iMPwOroBgNkVgust7v76ZGBsWPiyxftaHfcaQkLw3YckEyuaxxiT0ag21FmC5OgWJK+buj52cAQHvyuG5n0WHVDTolgAkC+gskDnAd9JbloBdOZ18gM/7bp51X6AvwuEf1vynaj24ftj+4OZVwepwLGVqSzVFi92C25cfJFwGknwAH0I+4wPCtyAmhaBP+SNW2f2vBHIgyUEhzG7f1Z7IGtlE33wE7e44nTFgPGu28rPpl39fPFhvHLmUHhrKCuGKJZjh9NaqbK+EC8zlRXC2I/nnGCBuCNCTHJDFQ4fYR64Bp7vQiD+HwBnOjhZQspZKJYKf95PeZ1C0GD/7yIa0FmoCRImZ0rn7RcuC9VwhN2BHmVpx+CQznOlbuIkkiUCgCVM1l2Q0ugwq37wkHu6gc54XBq6dTtK3xm6JsQiaWWGC0pEdfEBWOFsJSiMkT1RJXi9FjPlG9oNWmoAIF9wn25+340HANiJgxVzBQtYrFYYxdM4jL3gKlO87nO8I5EgR9KhcA78chQ+ZdMSlVq7cHVcgq7WdLVFAbZ4Y82/5a0fKXwQM845fuxL96ZAOMhH0/AwQZE9hr5FM1aZKsYWAgZg0QdRgT2kWhQ177KiNSpDAFewVhKVf3TRWZfOqtPpaLE01IEdt94iHzkcJmmBbo8UknBn3FJ6jIfFcPFhwYmD8nuFba7IpvwS5f5s9p7x4vA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(87266011)(6486002)(2616005)(66476007)(66946007)(508600001)(66446008)(64756008)(2906002)(76116006)(966005)(38070700005)(71200400001)(6916009)(66556008)(85182001)(91956017)(6506007)(83380400001)(82960400001)(4326008)(8936002)(122000001)(5660300002)(186003)(26005)(33656002)(316002)(8676002)(38100700002)(36756003)(86362001)(6512007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWZGTklRby9GV21GOXpNZzRQYmNnMnVJYjFFUmgrRGlZdGwycVdLL2NTSnRD?=
 =?utf-8?B?K1FpOE9nOHBPNUE0UlkrS1NBL2lRcTdGRG15Tm0ybG5aNklpM2FpQWNMeUh5?=
 =?utf-8?B?SmVaZkJzTy9aQml5TU5xcnlUYmhMMEJ1NnNHSmNJMzRXMTlMbnBVSGFIM3pN?=
 =?utf-8?B?aHY2aTduazVxV1ZyTWpZRXhNNkNobnYwMXBBTkh4UlFBb1dRNTRGQzVLajFm?=
 =?utf-8?B?eVhtQ3B5Qjk1ZC84ZEZvN3g4YVBjb2dLaXFJb1lLWjBPdVllWm54bGxCRzlm?=
 =?utf-8?B?V0I2eDFSUWJ1QVZXUVJUQm5JdVo1dU41WFJrRmdnMVBYaTA2WDZxYmVKdE5h?=
 =?utf-8?B?SkZCYmRwZUprbkNXeFNJQWo5QkdhTDBRT1Y4YXNzMk90UDIrYnB3RHVqckJw?=
 =?utf-8?B?WkpSVEhiMDNUNEcxZkdHdHVuMmhIOUxiaVk3bDhXSWxJZUg1M3RKdVR2dGxi?=
 =?utf-8?B?OUhMbmIwT3NGaWRzdklJTDNhSUJaWVN2L0NJd3lXQ3JWYUdsdXVla0NLdXBN?=
 =?utf-8?B?UkF2T2Z4VmV3MnZtdWdYRW95YzJRM3JJejQ1ZlRiOUFOM1hibzJWUmtvNjRq?=
 =?utf-8?B?dGJLM1FRZmlOVnlFeG9MTysvUy9oQnFveis1M1dma2lydVIrQ2hKNWxhdFdG?=
 =?utf-8?B?RjYzZHVPVlBKQ0JmczFQYjZqQUlTVWFuOWFHYndZTFdKZzZ1NWo4MFhOTTFi?=
 =?utf-8?B?em1aQXY5S0N4MDBad3U5enlIaWlnWTRDdzJtcHhFY1lzM1ZRSEU4dWV3SHk1?=
 =?utf-8?B?dUh4MUxLRUZTQThtQXdmalJhSlN1eXNndkxBeTF0WFVoNUM5amdNSWJMM2xl?=
 =?utf-8?B?azJ0RXJrckNhSE0vYTZFd2V0R1R4WEJzdXZ0UW1LYjdja051Sk9tMjE1OXVi?=
 =?utf-8?B?djR6VWhUTi9DODdDV01WeGpQUjhlSHdIa01jVXFmYjV3Y2s3UlArS1FQR3kv?=
 =?utf-8?B?MmtZV2dJMFBrdk1GWUFUbHo5d1c0cHd3UDZUK3VZRXFXQ1BscjlLTVZCNlda?=
 =?utf-8?B?aE9JOUptcy93SnFOWjFUT0JPQlJPV2YzbjU4aHhSSityTUtXVjNSNTFUTE5w?=
 =?utf-8?B?UnpYTTJZM3A3anE3UVYzMzNhSWd2UlpuTlliM2FOekRsRDE3NHBoYklubTFx?=
 =?utf-8?B?dEIvdU9mK2lsbWU0eXN6R3UzREt0MVpJZVpab0NLelNJNWF6cFMzaGFFdEll?=
 =?utf-8?B?ZXdOaGFBWS8xWE9ORFREb0F0VHFkWEtRV2FJQzhyQ0gwQmZmUVM1eVBKd04w?=
 =?utf-8?B?ZTdZSjBhSi8xK0tpMk0wMDBvTmpDSEFTTDM3d3htK0pSNlVmT2w5bnM4endu?=
 =?utf-8?B?bnpvUE1vOCszMmF0MFF5QkRwenk1UWhsQXcxOHBFUUlJMVZ0RkFzL3FJWjY5?=
 =?utf-8?B?aHlXMXdFMU9NSUxPOTQ4ckNsSmpsMlJvOFZmcEFVRWo3RzNOZXI4VjZHamw0?=
 =?utf-8?B?eFhFOUQrT3dFNWxTRXB0NWhTWThpek9GUE8vRzArdnVaSXMremp0VGtFUjNT?=
 =?utf-8?B?Q3RDcjVpWDVneDZ3Smk5L1BwZGJsZGxCMTB0OE1LQVhxaDhGSExZVUp5RE1p?=
 =?utf-8?B?TlFkTjNSaG43dklweE9KRFFVbDhJS09HTnhzb1JKV1hWVDR0N3R0UjZTQmFH?=
 =?utf-8?B?TklWb1RVUE5WMS92cllRL0hMOWN2VHJHYUwxMThWazJMZDlDeVU4Ullmbmtk?=
 =?utf-8?B?aktUa3dmYmk4OWozR0Y5Z0xGbG5LTFV0YlgyZXhPcndrdm56elk4QU1GRWNj?=
 =?utf-8?B?Uk1GRkhueGlNQkxQeU5kTWM1TnNjSWhpL1NFMStJNVBKKythTUZ1ZmltREJy?=
 =?utf-8?B?cXZuc01hSG9weUZvR013NXlRaUFTZ2tHRFBGZWN4L1Q4cCtiREx6MXRDeFdH?=
 =?utf-8?B?bDFyMDNLTnFiajAwcWRVcG01Q1NyNkJRdXhEdFNTc3V2U2NDWTRGSEtWbkxZ?=
 =?utf-8?B?Q09XNktxNzJSUFp6bGhzS1gwMlpNSXpPcEo2MWFSRlM4NElrUmwrT3JEMkRv?=
 =?utf-8?B?T3h2QjMwN2RMeURmZ09SVUFxZVBDWVRVZDRCQ21zbHFaajRzUzd1SkxxR3ox?=
 =?utf-8?B?YUxydERjRlV2MGcwMlkwdk9lMllrNTlFZTR3UWxXRDYvWmdWL0V4bzBDSEUv?=
 =?utf-8?B?WmZJTm92OEg5T0lMSXl4Q3ZnbVNPNE9NR3pYVzFKOUNETUgva2ZHdU9TeWQ1?=
 =?utf-8?B?R29CQ1g0VUdDMlZzL0lWMWJyTFR6Tk5KbUhXQlVvSVFHZk9zNE1YNm0wSEI2?=
 =?utf-8?Q?xGIBJm0JacuTyunPogBDi++ea5lVFCIACGrOcxT83U=3D?=
Content-ID: <3A011FD02A348C4988DE930D5DEEB30C@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f7d792-7f39-4072-e728-08d9da1f6573
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 01:11:02.9634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VVqkFDiwFy9sEc46rX0Ox2zOo9zRx2kqFhyPsGtLZ4ZFmykRw/JDyDzoVkEFrWen6w4+7nSlr2KAd6LyIhCSkVqNi1F3zohWR1DK3AGakQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8812
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED][PATCH] ci/wiki-mirror: Fix triggering CI
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

SGkgUGV0cg0KDQpOb3csIEkgdW5kZXJzdGFuZCwgdGhhbmtzIGZvciB5b3VyIGtpbmRseSBleHBs
YW5hdGlvbi4NCg0KQmVzdCBSZWdhcmRzDQpZYW5nIFh1DQo+IEhpIFh1LA0KPg0KPj4+IEZZSSBi
YTk5YjgxNzA4ICgiZG9jOiBGaXggdHlwbyBtaXNzaW5nIHMgaW4gLmFsbF9maWxlc3lzdGVtcyIp
DQo+Pj4gdmVyaWZpZWQgaXQncyB3b3JraW5nOg0KPg0KPj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9s
aW51eC10ZXN0LXByb2plY3QvbHRwL2FjdGlvbnMvcnVucy8xNzA3MDkwMzY2DQo+DQo+PiBJIGZv
dW5kIHRoaXMgcHJvYmxlbSB3aGVuIGRvYy8qIHBhdGNoIGlzbid0IHRoZSBsYXN0IHBhdGNoIG9m
IGENCj4+IHBhdGNoc2V0LiAgQnV0IGhlcmUgaXQgaXMgYSBzaW5nbGUgcGF0Y2guDQo+IFBhdGgg
Y2hlY2sgd2FzIHJlbW92ZWQgaW4gODIwY2ZlNTM5YiAoImNpL3dpa2ktbWlycm9yOiBEb24ndCBj
aGVjayBwYXRoIikuDQo+DQo+IFBhdGhzIHNob3VsZCBiZSB3b3JraW5nIG5vdCBvbmx5IG9uIGxh
c3QgY29tbWl0LCBJTUhPIGl0IGV2YWx1YXRlcyBhbGwgZmlsZXMgaW4NCj4gcHVzaA0KPiBodHRw
czovL2RvY3MuZ2l0aHViLmNvbS9lbi9hY3Rpb25zL3VzaW5nLXdvcmtmbG93cy93b3JrZmxvdy1z
eW50YXgtZm9yLWdpdGh1Yi1hY3Rpb25zI29ucHVzaHB1bGxfcmVxdWVzdHB1bGxfcmVxdWVzdF90
YXJnZXRwYXRoc3BhdGhzLWlnbm9yZQ0KPiAiV2hlbiB1c2luZyB0aGUgcHVzaCBhbmQgcHVsbF9y
ZXF1ZXN0IGV2ZW50cywgeW91IGNhbiBjb25maWd1cmUgYSB3b3JrZmxvdyB0bw0KPiBydW4gYmFz
ZWQgb24gd2hhdCBmaWxlIHBhdGhzIGFyZSBjaGFuZ2VkLiBQYXRoIGZpbHRlcnMgYXJlIG5vdCBl
dmFsdWF0ZWQgZm9yDQo+IHB1c2hlcyBvZiB0YWdzLiINCj4NCj4gPT4gIGl0IHNob3VsZCBiZSB3
b3JraW5nIGV2ZW4gSWYgSSByZXZlcnQgODIwY2ZlNTM5YiwgYmVjYXVzZSBydW5uaW5nIHRoYXQN
Cj4gd29ya2Zsb3cgZG9lcyBub3QgdGFrZSBsb25nLg0KPg0KPg0KPiBWZXJpZmljYXRpb24gaXQn
cyB3b3JraW5nIG9uIG15IGxvY2FsIHJlcG86DQo+DQo+IEkgcHVzaGVkIGZldyBjb21taXRzIGlu
IG15IGxvY2FsIGJyYW5jaDoNCj4gaHR0cHM6Ly9naXRodWIuY29tL3BldmlrL2x0cC9jb21taXRz
L3RtcA0KPiB0aGUgbGFzdCBjb21taXQgd2FzIG9uIC5naXRodWIvd29ya2Zsb3dzL3dpa2ktbWly
cm9yLnltbCBhZGRpbmc6DQo+ICsgICAgcGF0aHM6DQo+ICvvv7wgICAgICAtICdkb2MvKionDQo+
DQo+IGNvbW1pdCBvbmx5IGluIHRoYXQgYnJhbmNoIChub3QgaW4gdXBzdHJlYW0pOg0KPiBhYTdl
YzA2ZDIyICgiUmV2ZXJ0ICJjaS93aWtpLW1pcnJvcjogRG9uJ3QgY2hlY2sgcGF0aCIiKQ0KPg0K
PiBPdGhlciBjb21taXQgd2FzIG1vZGlmeWluZyByZXBvIHRvICdwZXZpay9sdHAnDQo+DQo+IGh0
dHBzOi8vZ2l0aHViLmNvbS9wZXZpay9sdHAvYWN0aW9ucy9ydW5zLzE2OTkyMzgyNTkvd29ya2Zs
b3cNCj4gLi4uDQo+IG9uOg0KPiAgICBwdXNoOg0KPiAgICAgIGJyYW5jaGVzOg0KPiAgICAgICAg
LSBtYXN0ZXINCj4gICAgICAgIC0gdG1wDQo+ICAgICAgcGF0aHM6DQo+ICAgICAgICAtICdkb2Mv
KionDQo+DQo+IGpvYnM6DQo+ICAgIG1pcnJvcjoNCj4gICAgICBydW5zLW9uOiB1YnVudHUtbGF0
ZXN0DQo+ICAgICAgaWY6ICR7eyBnaXRodWIucmVwb3NpdG9yeSA9PSAncGV2aWsvbHRwJyB9fQ0K
PiAuLi4NCj4NCj4gYW5kIHRoYXQgcHVzaCB0cmlnZ2VyZWQgQ0k6DQo+IGh0dHBzOi8vZ2l0aHVi
LmNvbS9wZXZpay9sdHAvYWN0aW9ucy9ydW5zLzE2OTkyMjg5ODUNCj4gKGZhaWxlZCBiZWNhdXNl
IG15IGxvY2FsIHJlcG8gZG9lcyBub3QgaGF2ZSByaWdodHMpDQo+DQo+IEtpbmQgcmVnYXJkcywN
Cj4gUGV0cg0KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
