Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CABCDB47E
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 02:45:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9AF03CEF1D
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 04:45:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2EC33C88A4
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 04:45:17 +0200 (CEST)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9403960078F
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 04:45:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697683516; x=1729219516;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=vCiuiZ5fHb2mtZcfbEtnpLzUJkdAGdW4i9Fm+3C5tJQ=;
 b=OBAETxbZIjB6E7CkgyQKpPmczEwHPXuVS88EEnguut+cnz585ZPNJko8
 R97fYyxEWYtA0RP1+rH5P10m2evtaj9NNQ6iZkf6ClhMPFRLCP46O4HgX
 vSSmSI+wkVHdOcdpmyPALBZ2OLr/MQfNJ+tpS4fhH3f6fzgb2OO24gFaQ
 Q+S9hAkwmn8DCaD1ezdCazueI5woma25PvuTnjBHSQIwA9HND1AL5BlIH
 vqbPtEMP9RiSkDJxXNaU/Dge5+Ph7TO56m834gcBfSqi5PsHck1A1t0Kq
 +eurEiPrLfqQ6tAHH2dm18tU0uayJTPsenlL6zM1xUBQrNTUqAOpK8df7 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="99778726"
X-IronPort-AV: E=Sophos;i="6.03,236,1694703600"; d="scan'208,217";a="99778726"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2023 11:45:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXkZH+lkQ6Huhlrc8LAnotMUTSlxXqLSYL26Zakop0k7lZhbCTrq0MjZi3Y+SqvWiNs/YOMCV/wCP7ORieXVbriLVxo3S7T/Wu/E2B8JCmoEmZz5w8mYfB4OGAqJutZYSLeEhimGx/elUjyaEpIf8dedbE6l8YRMtO8G+pDs+qyqQKXsbuvsnsLmeFb26GvYKpfmc+MQWDd+px7IN3M82ES3smMGN5OMD4NTviS0HbiR5qd/1o3H6Nav2+W9W1+oHk4rixVdjhBb5dT+5BLY9eB24H0Y9OXCIlqNkyc9EnXMIkWscPsO6Vp4yCFZtHdZ4V4Dte4m6gnLOp8ktv/q4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCiuiZ5fHb2mtZcfbEtnpLzUJkdAGdW4i9Fm+3C5tJQ=;
 b=AoxxSJsQYX0XVscq9QnNlKJeYhy0zZ+AzktSLeW5vc+85nX18OeMQmPijFAW08X6RASVLdfhGOshiJwXyBQ3OBqFULEAZEZ75E/Xlkve5+eGa6UDChi6fpPmSsN5r6rs7bGcCGcgiBarvlblC3FoKmyLzxjOIKUG41JSsIAmOf1XDqi18D2EWOipGaM8paNNFOg5kOz1mV9KH+9ZOhYvQoMsKMDwfrh9cuHdY+KeBlNRsCZLUv0PFk62USoqMi7nJtLd29A7FXniqfsyfMvpe3uf4ovxyuybCIzVJRVrzKaGy4fpbY3BclHx6ohJjAJCzabJEBLgrWAUYgNnRs8bFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by OS3PR01MB7921.jpnprd01.prod.outlook.com (2603:1096:604:160::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 02:45:11 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::a5d2:bd3a:8420:bd3a]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::a5d2:bd3a:8420:bd3a%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 02:45:11 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH 2/2] syscalls/fchmodat02: Move errnos check to
 fchmodat02
Thread-Index: AQHZ7EugEY+lWgjv30yWBwjd/r/tW7BOFYwAgAJ+agA=
Date: Thu, 19 Oct 2023 02:45:11 +0000
Message-ID: <2ef8cd9f-1470-a302-fdf1-ef41f4172db8@fujitsu.com>
References: <1695273748-4607-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1695273748-4607-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAEemH2feYps41z2v_-4RqTdrYC6VXW3E0a8zEPjQSw6xQrjoCg@mail.gmail.com>
In-Reply-To: <CAEemH2feYps41z2v_-4RqTdrYC6VXW3E0a8zEPjQSw6xQrjoCg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|OS3PR01MB7921:EE_
x-ms-office365-filtering-correlation-id: d56a89b2-8a39-472c-b6ee-08dbd04d6a4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Tw4qB84nmASRGqkKY0IqeKfqj8Q832xKddbhJqeQ+Ny1YMudyELa8CRs2sh0petw/tNPOelYcKpOJpsHLyODYUe4EnL1Fu1TK0k2iHy+ToR0tdPyJIczWVlW00yG3qqdT9od0Ya4qwY7CKPNGP6UNKWAwTu42PJQmvhCFheNIlB9cRlbHGt1vwvHKZSIFr5wYDrcut7yHxuuyQh5lwholZQR8uJu0SYHtOzKwRrBExOW05Im3Vvu4M0YCfX8JrKLDUgtoMJQmg2OsbYOOnL2LBWGsfQFpYRhzAweMR8+R6CbxkQGNf3nn47IDhcZUmIBxfJWtxrcS/Fw06qkfm+5cNUulqFpRsKBKmYGCQaS74GjIch2F7CV3AQ38lQExJoiUmpABuXn+TFsXLhZcXy91Jg/h+wObJkHUDYvm+NMeGSxLzrP/6M+grFRwT4IGJ3x3kWTq6F2L6UoDMruYsVbMwjZxfuvC7JmCukvA3cLivU34jh0ADDFZnGh2zRqtqwY6ztR/lYMtqUddsCmrGnoIGFwPc0DgcFZe6X/Mf75XKsMAj7zK2MOP8lY09C1dVFWaMGlXCRTEGunN7McCPE8EVZ5s1WJEUVn97q60oPCTIEZJJaf4ryFozk1Uc/+5pDHd89JyTR+D1Kyy4lcQw80J7cQ8JiKYBv7mwrM+sly/I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(230922051799003)(1590799021)(1800799009)(64100799003)(186009)(451199024)(31686004)(1580799018)(36756003)(5660300002)(4326008)(8676002)(83380400001)(8936002)(26005)(85182001)(6512007)(166002)(71200400001)(53546011)(2616005)(6506007)(31696002)(2906002)(82960400001)(38070700005)(38100700002)(86362001)(66946007)(66446008)(41300700001)(64756008)(91956017)(76116006)(66476007)(66556008)(122000001)(478600001)(966005)(6486002)(6916009)(316002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bndld29FdnoxV3orK28zMGNaWWgyT1RFN1JGZFpEcm9jS3RMN1lza2Q3VDNP?=
 =?utf-8?B?Szh4NUR4MG9Pa2MxdnRKWjNLWlFRNU9IR1dUN3FPQXJWTUpKM005RHg5SVlh?=
 =?utf-8?B?SE43RmVSV0VLcHp5UHhYekcrQ2grSzZYSHRYOThIeEZDMjBkWm1HOTFqUFo0?=
 =?utf-8?B?RmFQWlJJdHpleXkxMU9ndDl2U3BVWlNmd2FuaE9Fc3cyeWJvdzU2c1lXb0w5?=
 =?utf-8?B?NE44ejREQ29nTVVPQUpaZzdyQ1BWTEliQXlFVnBzQnpXYnZLSklkWWdIb0tv?=
 =?utf-8?B?dk1hMk1UeWtGdzhQcG9Qa0FJZzgxZzIwSFdjTElyaFJuVDVSa3JuaXI1M0gy?=
 =?utf-8?B?THFqajIrWTdCZjFzR29lTGNrcmdYS3hhMis4VFFnMEt2RkF3ZjlaMjd3UE8w?=
 =?utf-8?B?ZysvZE90ZTBsZVdwUDRHWVRibGk1N1M3UitWMng5NXNCWEtGeHVXanZqSzhv?=
 =?utf-8?B?VCsxRmlMbkZOczN6Y1BHYlViTmFhZzhZZ1FjbFFSajFLMU9OVFNwdkhBSU96?=
 =?utf-8?B?T2FyKys5VHQvelBNYkpHVTk1K3lXT3BYVlR0QmFvbFBFNytHUmNPczhzZjY5?=
 =?utf-8?B?Z1dDTTE4akJPbWtPZERraTJnT2doQXY1YWpVZjJwejl6V0d3NktvYy9rWVBZ?=
 =?utf-8?B?WWNmRDRBaUZ3RmhVUG5QQ2M2YVd2RG9zalc1NlF3cno1V1hhM3FxUi9jaU9w?=
 =?utf-8?B?ZkpPSXdCSkd3ejZlUytOTyttUFRKQmJldG80UElVdUtCNUJtaXhnVGVYWnZk?=
 =?utf-8?B?Q3hZcHFmeXBZVVo0SzdhbTdxNVZKTVNMNzh6dWpldW5uQkNhYUVPMVRZanJP?=
 =?utf-8?B?Z2xoemhZd0JRd2tsUDNwb2pZSkpuVHhzSUhTZ2JURHlsUXo2WG5HR201b1pM?=
 =?utf-8?B?Z0JYK1dFb0VvbFpwNDBvWURyblBsMzVBZmUvVG91UTRZUmsvdU16aXl0aWJ0?=
 =?utf-8?B?aVo5VjkwT3BEdUFRdnpkUklOMUtjMndoaUZIcnEwYUVqSzFwRWVLckJHNjNB?=
 =?utf-8?B?MkVteGc3OEtRVC9zZDdPY1B2azdLRHRJaWlGYm1GM0pWREJmQmwzOEpjR1Zu?=
 =?utf-8?B?c3I4dkp5N3locEV3OWNueUJvc0VCSi9lZU1mQldyUzc1RlFUbW9yS0J5NVBN?=
 =?utf-8?B?MFdGWlpadnE1a05oNHhFZ3VJVERHSnBnR2MvaWZtN3JqTGNDdkxOQkQvZmVD?=
 =?utf-8?B?Q0dOd2N4b01OVWNEeStKSWF6SXR0MmN6YVZpbjlPekdWY0FrMkJQV3ZsYXZw?=
 =?utf-8?B?R3BVazZDVWVzRnlRRzhMbnZyc1RreU42MGNyMmpPT29scmluVzdoVzdqQXJj?=
 =?utf-8?B?dWFoOFdSZG5XNUhRSExBVThGTndHMDhTWUVLeUlzTDZ3eUJ3YUF0RUNlM3dZ?=
 =?utf-8?B?Ly9iNmtacXNqNVhkZmRva1d2Qkk2bUxIbGd2NEpOczFLaUdNVWp0ZFdtN0pD?=
 =?utf-8?B?ZXlSMVNMdjZ5VCtSc0hWVTV4MlBjV3ZSa3JWNit3L080UkV6TThEZzRWTS9P?=
 =?utf-8?B?b0V6VW5uakpQMWdxSmxWU08rK0FMWWNIVUxJQVdCR21IL21BK0g5TklJQnRM?=
 =?utf-8?B?VklrVFhnNFl0ZHoyV2szemNmUGxpWlJQQVlzUnRKa1U5QUdxVTdQRitWOFgy?=
 =?utf-8?B?SmZ6Z1o0bHN3R2RJRWVDSEJxTnR3WkhSZ2hTUWJTUk1ReVZuVjRXeit2TXpi?=
 =?utf-8?B?TWlnVEVsTE9xTFZEREZxbEpFSVAwaTBzN3BPOHIyeVduVG4yb0cvWi9temRJ?=
 =?utf-8?B?K1dWQXdpc0RMcTkrbGlQK2ltSUU4eGN3dEpQTGRLeWZKalZPNzVWN1lhczl4?=
 =?utf-8?B?UzdxMGgwL3djU0hWU2hKSWozajlFdjYrWFoxOFVDQStlK2hGcTd1aVZJMzIx?=
 =?utf-8?B?Z0hWaDNWUlp5T2NSYlRJbkhQYTB2QlZLQUtFRkVGR1pWaFJ5U2hQZWdRN1Zl?=
 =?utf-8?B?N1hNQjBrSElkZXZ1ODJVQkNuUUoxcFFIRXFUaWtNOGphZ0xrTVRuVHQyNndO?=
 =?utf-8?B?cDRvQi9oTFVKUkd2b2FvRFZFSE5NTjVBN2xDS3B4MWRLdkFrMVhET0JiUnBr?=
 =?utf-8?B?VUtkUnd2VG4xUkliUmdIcGZRaVM3VURZTG9ES2dPbkFsN1NhNUR1emxSMk9z?=
 =?utf-8?B?TDJRR1RRNmRBSUw3Ym9JMEdsb1hJanN4ajBUK3lOUHl0RG1JSHA1SDhOZDhh?=
 =?utf-8?B?NGc9PQ==?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Z/xEjcYDplarcxLyFOt5CBz7LYCXFFMS83knipkCuSsBQRhWrh3liMhsHJ5u3GeyLqfbjSYjTB2OD7+FU3KZvzNtew2h34JZRD4qU6qTJnw806k59mNt+aPhk1hsAh2BcIVhlq4EFG02Mc6QgwR3rBqbzkx0j4fY/m/qfE2HqfLs1IRETm24zkRLA+LXJLjthQ7jxezRFQW5BFMsnwkQX9oV41nJqj3rarISRzUbkZeiYJjfg/zCY3C4uqXD2q05s45d2ea1MFb07KYjWMxDjtqrkcAGgEV5XcKIOi+2dViS+qQT5DZBTKpzIvl96Z4tka4km4u9lKVZEvQK7mj+h2Abb7odXz5ZYYTU7mhapVSPOFHloLuL5Y2n3DcSn/wpSX7d6akFZgehCzVIS586Uphc3B0Toa4W3xa7njpfC47ATI/GW0iEN55WpqunMEkisiZwlY2YEBaVItSR0wkgcyxgZkz3uuoYhMuCchEfMKli1lRQtd26CE0bEnFTKDS69AHNpuO8UpDEhM61/IK4yyRcApR3iMJ0X9mLxIXQxFXKE4BTIIc6CGCNm6SBE4cQc8Y+2WKDmB8c2k1n9mOiyBEZWQANSsIeX7czFPK/oCb/Stovi1wrAw2vtIm+bfV3YT5s2y6d4f6/zzJBtIC1LJYbCTssjy3HKG8XQDRH2QYTN3dNs5yURDuov2v8G6Loxz4QNeImPGzI7Tpg6UJ5TW/m3pmhspNEmvAiGqqhFVVS5i4qnVkxX0SV/DPvynfBEW6fY4fF2f8GTzKbF1Z7vKmtRr4v2XUUJr/uPXilAAw=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56a89b2-8a39-472c-b6ee-08dbd04d6a4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 02:45:11.7090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FOeZ/mzLIDSkGpgVgiG4dHTtlAE+DnTJxT6Qrj/tnaDN2lKInRLNarWVtO0gskhTO70ZlbdEyLfPIfVFQiSPLQYpesrg9kh3/c9usN8itQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7921
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] syscalls/fchmodat02: Move errnos check to
 fchmodat02
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

SGkgTGksDQoNCg0KT24gVGh1LCBTZXAgMjEsIDIwMjMgYXQgMToyM+KAr1BNIFlhbmcgWHUgPHh1
eWFuZzIwMTguanlAZnVqaXRzdS5jb208bWFpbHRvOnh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+
PiB3cm90ZToNCkNoZWNrIGVycm5vcyBmb3IgZmNobW9kYXQoKS4NCg0KU2lnbmVkLW9mZi1ieTog
WWFuZyBYdSA8eHV5YW5nMjAxOC5qeUBmdWppdHN1LmNvbTxtYWlsdG86eHV5YW5nMjAxOC5qeUBm
dWppdHN1LmNvbT4+DQotLS0NCiBydW50ZXN0L3N5c2NhbGxzICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgMSArDQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mY2htb2RhdC8uZ2l0
aWdub3JlIHwgIDEgKw0KIC4uLi9rZXJuZWwvc3lzY2FsbHMvZmNobW9kYXQvZmNobW9kYXQwMi5j
ICAgICB8IDY2ICsrKysrKysrKysrKysrKysrKysNCiAzIGZpbGVzIGNoYW5nZWQsIDY4IGluc2Vy
dGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
Y2htb2RhdC9mY2htb2RhdDAyLmMNCg0KZGlmZiAtLWdpdCBhL3J1bnRlc3Qvc3lzY2FsbHMgYi9y
dW50ZXN0L3N5c2NhbGxzDQppbmRleCA0ZjFlZTFmMzQuLjVhNmI0YTY0ZCAxMDA2NDQNCi0tLSBh
L3J1bnRlc3Qvc3lzY2FsbHMNCisrKyBiL3J1bnRlc3Qvc3lzY2FsbHMNCkBAIC0yNTksNiArMjU5
LDcgQEAgZmNobW9kMDYgZmNobW9kMDYNCg0KICNmY2htb2RhdCB0ZXN0IGNhc2VzDQogZmNobW9k
YXQwMSBmY2htb2RhdDAxDQorZmNobW9kYXQwMiBmY2htb2RhdDAyDQoNCiBmY2hvd24wMSBmY2hv
d24wMQ0KIGZjaG93bjAxXzE2IGZjaG93bjAxXzE2DQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9mY2htb2RhdC8uZ2l0aWdub3JlIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9mY2htb2RhdC8uZ2l0aWdub3JlDQppbmRleCBhOTUwOGJjNWEuLjA5ZDVjNDdkNSAxMDA2
NDQNCi0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmNobW9kYXQvLmdpdGlnbm9yZQ0K
KysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mY2htb2RhdC8uZ2l0aWdub3JlDQpAQCAt
MSArMSwyIEBADQogL2ZjaG1vZGF0MDENCisvZmNobW9kYXQwMg0KZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvZmNobW9kYXQvZmNobW9kYXQwMi5jIGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9mY2htb2RhdC9mY2htb2RhdDAyLmMNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQppbmRleCAwMDAwMDAwMDAuLmFkOGUyYWFmNw0KLS0tIC9kZXYvbnVsbA0KKysrIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9mY2htb2RhdC9mY2htb2RhdDAyLmMNCkBAIC0wLDAgKzEsNjYg
QEANCisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KKy8qDQor
ICogQ29weXJpZ2h0IChjKSBJbnRlcm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hpbmVzICBDb3JwLiwg
MjAwNg0KKyAqIENvcHlyaWdodCAoYykgTGludXggVGVzdCBQcm9qZWN0LCAyMDAzLTIwMjMNCisg
KiBBdXRob3I6IFlpIFlhbmcgPHl5YW5nY2RsQGNuLmlibS5jb208bWFpbHRvOnl5YW5nY2RsQGNu
LmlibS5jb20+Pg0KKyAqLw0KKw0KKy8qXA0KKyAqIFtEZXNjcmlwdGlvbl0NCisgKg0KKyAqIC0g
ZmNobW9kYXQoKSBmYWlscyB3aXRoIEVOT1RESVIgaWYgZGlyX2ZkIGlzIGZpbGUgZGVzY3JpcHRv
ciB0byB0aGUgZmlsZQ0KKyAqICAgYW5kIHBhdGhuYW1lIGlzIHJlbGF0aXZlIHBhdGggb2YgdGhl
IGZpbGUuDQorICoNCisgKiAtIGZjaG1vZGF0KCkgZmFpbHMgd2l0aCBFQkFERiBpZiBkaXJfZmQg
aXMgaW52YWxpZC4NCg0KR2VuZXJhbGx5LCB0aGlzIHRlc3QgbG9va3MgZ29vZCwgYnV0IEkgd291
bGQgc3RpbGwgc3VnZ2VzdCBjb3ZlcmluZyBtb3JlDQpFUlJPUyBjaGVjayBmb3IgY2htb2RhdCA6
LSkuDQoNCk9LLiBJIHdpbGwgdXBkYXRlIGl0Lg0KDQorICovDQorDQorI2luY2x1ZGUgPHN0ZGxp
Yi5oPg0KKyNpbmNsdWRlIDxzdGRpby5oPg0KKyNpbmNsdWRlICJ0c3RfdGVzdC5oIg0KKw0KKyNk
ZWZpbmUgVEVTVERJUiAgICAgICAgICJmY2htb2RhdGRpciINCisjZGVmaW5lIFRFU1RGSUxFICAg
ICAgICAiZmNobW9kYXRmaWxlIg0KKyNkZWZpbmUgRklMRVBBVEggICAgICAgICJmY2htb2RhdGRp
ci9mY2htb2RhdGZpbGUiDQorDQorc3RhdGljIGludCBkaXJfZmQsIGZpbGVfZmQ7DQorc3RhdGlj
IGludCBiYWRfZmQgPSAtMTsNCisNCitzdGF0aWMgc3RydWN0IHRjYXNlIHsNCisgICAgICAgaW50
ICpmZDsNCisgICAgICAgaW50IGV4cF9lcnJubzsNCit9IHRjYXNlc1tdID0gew0KKyAgICAgICB7
JmZpbGVfZmQsIEVOT1RESVJ9LA0KKyAgICAgICB7JmJhZF9mZCwgRUJBREZ9LA0KK307DQorDQor
c3RhdGljIHZvaWQgdmVyaWZ5X2ZjaG1vZGF0KHVuc2lnbmVkIGludCBpKQ0KK3sNCisgICAgICAg
c3RydWN0IHRjYXNlICp0YyA9ICZ0Y2FzZXNbaV07DQorDQorICAgICAgIFRTVF9FWFBfRkFJTChm
Y2htb2RhdCgqdGMtPmZkLCBURVNURklMRSwgMDYwMCwgMCksDQorICAgICAgICAgICAgICAgICAg
ICB0Yy0+ZXhwX2Vycm5vLCAiZmNobW9kYXQoJWQsICVzLCAwNjAwLCAwKSIsICp0Yy0+ZmQsIFRF
U1RGSUxFKTsNCit9DQorDQorc3RhdGljIHZvaWQgc2V0dXAodm9pZCkNCit7DQorICAgICAgIFNB
RkVfTUtESVIoVEVTVERJUiwgMDcwMCk7DQorICAgICAgIGRpcl9mZCA9IFNBRkVfT1BFTihURVNU
RElSLCBPX0RJUkVDVE9SWSk7DQoNCkkgZGlkbid0IHNlZSB3aHkgd2UgbmVlZCBkaXJfZmQgaW4g
dGhpcyB0ZXN0Y2FzZSwgd2UgZG9uJ3QNCmV2ZW4gbmVlZCB0byBjcmVhdGUgdGhlIFRFU1RESVIs
IHJpZ2h0Pw0KDQpZZXMuDQoNCisgICAgICAgZmlsZV9mZCA9IFNBRkVfT1BFTihGSUxFUEFUSCwg
T19DUkVBVCB8IE9fUkRXUiwgMDYwMCk7DQorfQ0KKw0KK3N0YXRpYyB2b2lkIGNsZWFudXAodm9p
ZCkNCit7DQorICAgICAgIGlmIChkaXJfZmQgPiAtMSkNCisgICAgICAgICAgICAgICBTQUZFX0NM
T1NFKGRpcl9mZCk7DQoNCm5vIG5lZWRlZC4NCg0KT0suDQorDQorICAgICAgIGlmIChmaWxlX2Zk
ID4gLTEpDQorICAgICAgICAgICAgICAgU0FGRV9DTE9TRShmaWxlX2ZkKTsNCit9DQorDQorc3Rh
dGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gew0KKyAgICAgICAudGVzdCA9IHZlcmlmeV9mY2ht
b2RhdCwNCisgICAgICAgLnRjbnQgPSBBUlJBWV9TSVpFKHRjYXNlcyksDQorICAgICAgIC5zZXR1
cCA9IHNldHVwLA0KKyAgICAgICAuY2xlYW51cCA9IGNsZWFudXAsDQorICAgICAgIC5uZWVkc190
bXBkaXIgPSAxLA0KK307DQotLQ0KMi4zOS4xDQoNCg0KLS0NCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cA0KDQoNCg0KVGhhbmtzIGZvciB5b3Vy
IHBhdGllbnQgcmV2aWV3Lg0KDQpCZXN0IFJlZ2FyZHMNCg0KWWFuZyBYdQ0KDQotLQ0KUmVnYXJk
cywNCkxpIFdhbmcNCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
