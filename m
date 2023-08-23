Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22642EE49A0
	for <ltp@archiver.kernel.org>; Wed, 23 Aug 2023 03:52:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA7543CC765
	for <ltp@archiver.kernel.org>; Wed, 23 Aug 2023 05:52:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 373693C8948
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 05:52:12 +0200 (CEST)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ED302600C3A
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 05:52:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1692762731; x=1724298731;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=hvU43fHBK5yNxIk14EZvvJeZCgQ7TGNEmHoMxDkd9sU=;
 b=V+ufI8LyrYB/hdCkGcAG2A3BQda4vS3V0E5jJHE+Lobtymkh4Npurrcp
 r40eFKs7RX454PjFHfoVIENCK1QskRPaI9fotNlE+otmTHI1QAQPV1vpu
 zxNi13rTUy7s7jsOKa8rEe5c7qS3Ry47bn4jf4tQbHtT5iKZUI1+TsWt2
 PMPbIJIBf3rao5tKI71+yYfDNH/RGcKa+xbu8fSmhWQGPmBbOHTdWEds+
 g66b+L6o/DAY/S5m0+hwgbyuF81L05G1ahzwDYkSMhWfBoTE/enS5Ue7b
 av4xkW65mTJWsIWE1/7zA2Hz5tAA1XAgMDzi5oYAl7J8uTFugtkojvVix A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="92460704"
X-IronPort-AV: E=Sophos;i="6.01,194,1684767600"; d="scan'208";a="92460704"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2023 12:52:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMuI0VPLfy/6fBzK7wLSxnDk/N+74XuVJiia2DQkeC+bSPVrmM+4pvXtsncZU6cqrzlS6/cGtgzvUtzMaSwza+lKjWXxUOLTNQI3f7QFC9z9feWljP6SVpUIQDeBQmWLTw83UTwOHqw0eEzWC8Fl71m9byOziTlaIY4ULdvN+pcldtgFGSd71ygtw9e+jA41hDET5Q9zAS+gi1+XRZYR4RbiStskDcLdIvFJ9VQ7l8ISdDt8x2qE3GIbnEXH9pl2NrCIXhDVUsdhM/qZ54j+9uCNOroBdQVCPiv2jfYjjgbyuge0MFkL7dcm2R3SaDvge8HEEmW3a5P/wUkz++7OVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvU43fHBK5yNxIk14EZvvJeZCgQ7TGNEmHoMxDkd9sU=;
 b=iNHIHahMfo75IuaODvwO0xSSJABs0fBzQ6ZDFrbVyBcVrUBcFGfrgJ6iAARO0nQDPQwzQhEyDdjU/DbsSW9ci90HhnIJcUwgT9/Io4Zw8tcYUiLh+IBsuT4e22tOnYPY4mob4Z5r0hWP4a0LGgqLLpYfJz4SNRGJsMN7JDmLNHOkT7HpI0XHR/ZJyWRZb/cW6d2U/2F1icDAyqPrDOOtcJuEf/4ZJ0MDVIej4Q6gKs4OMrvefFaeEkKFM0pk5gSLZ5t744G5KYa13UE5uiXXPi7hXzFvivDPDdVHp+0XdiYGIJMfPfP+th8t5l+rZd9hroVeFq6I4Qh1kyEr2koIyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com (2603:1096:400:294::9)
 by TYWPR01MB8362.jpnprd01.prod.outlook.com (2603:1096:400:161::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 03:52:03 +0000
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::3776:b0fb:c837:7c84]) by TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::3776:b0fb:c837:7c84%3]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 03:52:03 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v2 2/2] syscalls/faccessat202: Add new testcase
Thread-Index: AQHZ1OVOG4PhieMT80CjNzjtc+7Oba/2aK0AgADX4QA=
Date: Wed, 23 Aug 2023 03:52:03 +0000
Message-ID: <c9ec804c-d100-f678-a0bf-9634f2d17b67@fujitsu.com>
References: <1692700900-13521-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1692700900-13521-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <ZOTNSlPaoSaxU493@yuki>
In-Reply-To: <ZOTNSlPaoSaxU493@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10712:EE_|TYWPR01MB8362:EE_
x-ms-office365-filtering-correlation-id: 51b64ed3-a1c4-428d-9846-08dba38c4fed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yc6/qTynwUL/UW/eY1SMA3yZi+O2WUP3howmQzjV1YKdWFaAT/ckN/vVJyrPZp2jlZ5NEXzWb/5iupcvzByELIOaqvDcqWMQFfc6N9SjMJttQ+l+nFWClYlc1FuN/+mkuycrB/jnVn1SbqxYEWuUw442F4coBMEAJJdNPOH90GNWGK8EzYmpF5+ilF7HEQJuYAdqhT94izL31QOpXzcPoGIvyY6Db3VXpuBCCQQ4S7I8WH+fF7faOE3QHuYT+VpzBudOyjJPdNxPPyzT3xhJ3MzZsQe5TaJB57dZT5SnHaNV9SUqdczIIs3M0aI0VTBq7MRAylx4Lj5LGgr87wzLjAkE7N8ctAVfDN9yHCe6MTaIa0v3N4AC5mLhDbiKlrbDBVHT55R52ZjTwEN00Uj9Hm3713GvcoThnRcSnvTIh8A0ts0Zvs90poUrpp1jZtXvjM3Cv1xSvsq6q49HLse7fC/lR/0/B+YHM4E+vREXk8+0L+0S01sRaRiw6HvprXQh/llRd/wifs4VZFmN8aMkK1hi8nDNsek5FAYMw0y2i6gKcRE6eEv4KM903M7/4us+htjHjLnzlzmtvoUSHPknYVcbZTb4MvcZsk4gpNbb/IxsjJ1iDHUfvzazfVVsSGHYZHKpsXYVklp3bTqmPhE5nHkIZydUSBiQROSC3ZnJTYs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB10712.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(186009)(451199024)(1590799021)(1800799009)(36756003)(31696002)(478600001)(85182001)(966005)(86362001)(31686004)(6486002)(66476007)(66446008)(6506007)(64756008)(66556008)(316002)(71200400001)(6916009)(76116006)(91956017)(66946007)(6512007)(41300700001)(82960400001)(8676002)(38100700002)(38070700005)(8936002)(4326008)(122000001)(2616005)(5660300002)(26005)(83380400001)(2906002)(1580799018)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVl1WnFwai9kTmFUaEFTWE9qUERrRXhQbUR2MGIxWlZtWlJWVjRQRVcraVZZ?=
 =?utf-8?B?VFJNTWNGcmhoMGlxRmxuL3N0eFRTc1YrTWYxeFp3eThCbmc5L0NUZ1lzRHFs?=
 =?utf-8?B?emQwRC9DcUo3c3FWSzFnbXJjS1BsT1Z0MzNjSVJtdis0ZmFMYWZhVVNJTlJi?=
 =?utf-8?B?VlFwSEZaL1pEQjZ5TDgySUp4TWVxcFJwNDc5T2h5SS8vV1ZyY2JMRHFaNlM0?=
 =?utf-8?B?b3dQcGM5SXI5S0xtV05RVDhnU3lNTE1WWDBnVHFwNmhEcWF5c3JPY1Y1SjBp?=
 =?utf-8?B?QnRQSTY4MTNMU0xWQkZwcmFRYUVQbFpWUGFvNXM0QzZZK0NHaWM4amZoa0U0?=
 =?utf-8?B?Z2dwRU1IV1ozbVFTQk9uK0ZUOG1QbWVvY0J5N2UzL0NYdW5PcTBjbHl5U29X?=
 =?utf-8?B?MGV5ZHZ4ZnBDUkZmSEU5ZGsvZWtzRlFGaVlhNjVNVU1TQWh1RmNJNmRBWm52?=
 =?utf-8?B?ZFFSS1QwblVQNi9GNUFZMVhNRlF2eFc1Q3NJdE8rQXZwR1JDTEdsYnRRUjhi?=
 =?utf-8?B?cFh4bnhxclJTUWdSQlUzRjBMNm1yN2RaaHlKQUZ3VmdrZ080TVplY3VMMm45?=
 =?utf-8?B?MUVkL2xXZDdsVndFMlVHRDVxbEtlRDZtZ0VLL1I4M2ZYZkdFTmlhVjdCbFhQ?=
 =?utf-8?B?Y0t4dEdpOFBwTlljZENueUFTbHhJY055d0kxMStGRjJRTFNjckd2dXIrbFQ1?=
 =?utf-8?B?WHhxNTVPVFBnS0piMmp2cGNXQVUwa0txa3hBMkc3eHVSNE5RNm1kVVlZWGVl?=
 =?utf-8?B?MEtYU2VWeURPZ3JOdEd6ejFMNks4R2tLeGNLZkEwY3h0N1hGTmpHanRsZHZN?=
 =?utf-8?B?MVZNOW9tbXVTdDZhRE9lcStKRStwOEtjOVdaTnQ4QmJFYjJLaFlwYjdvWnM2?=
 =?utf-8?B?OXkvWWF3NXFzNCtFaWhKZ1VoNzdDazZmcUVkUS9yVW9OR2RkdWNkSVg3eHJx?=
 =?utf-8?B?RVhrZE0rcTBIMUZzUXBBK3FqcHdpYmgvdWI1eVE3QnlObGhhTC9LZkZTVUxx?=
 =?utf-8?B?S2JvQUVPUHZaNDF0b0dUZVZISm1RNEo3T3JBekVRT05nS1BoQ2pjZUZRdkM1?=
 =?utf-8?B?emhhY3c3VHZROTl5TW1kcERLT0N3WjV6VGFZemFURVl2N1hRUXpnMUdyWHF4?=
 =?utf-8?B?MzdpbEVjbjZYMGFDRlRab2RwbUtGaHF1QnJnSnpPZ2RMY1FvL2RYT0diVmVp?=
 =?utf-8?B?WGJKQWFsTDc1M0tFNkY5ay9QNDVSTGxFZk1yUDVmeStDUGgzVjBDMjhVSjY2?=
 =?utf-8?B?T2MzbmlZYWp4bTV4elRGV0k0QjVSUXBTTkhLZ0M0VHl2SlZpMTU3UGE1SGpQ?=
 =?utf-8?B?LzJzZnB3YmVrK2s5Z0NFNlNsb1VIWVh5WDM4ajlsN3ViaWdtS2NReVc0NjEz?=
 =?utf-8?B?KzVCK1VleDE3WE1ydURSOFAzWjQ5RC9zRWpxckFLK2dOcFExdFZGSFZ5eDB5?=
 =?utf-8?B?NHZkazBtd00zNFZ4dVdJNUxhMTZXUFVlMjFXVGhKNXgyVXozVUxSVUxScGp3?=
 =?utf-8?B?QnpNYUJTUnk4S0NXbHJCRy9JQ3Bza3psV3J1UTVBMEZQbmZtWjNCWEtNQ24x?=
 =?utf-8?B?bzFjY2gzMklHSmR3N2pSUlJzdUQrbUltaExBQXNUQW5KdmJMUmVlZFBpZk90?=
 =?utf-8?B?VVpVZzNuRk9oZGM4bnhmZmVkU2JjaDN1M0ROR2NHczk5OWVEdTlPVVlNN0Nj?=
 =?utf-8?B?dXRCbDdhSGkyVmlkbVcySEh2eGhrbGhjSGtUUWloVEQ2WGVtUnEybEJkdXVa?=
 =?utf-8?B?elBYdmExTWkwYWhDVzNabjRDalZCVlV2bzJtaW8yV1U1NlU0ZDRRRWlLRkhH?=
 =?utf-8?B?TkwrQUxYdis0ZDk5dUl3emhHVDJlazkvL24yTExWTFFZeVJDMTZza3QwUFBn?=
 =?utf-8?B?QXU3VW1HdWd3TVJFN25VV1haV0lOOTFYeTRid0ZXSzVkZ0lySEEyak5FTmNh?=
 =?utf-8?B?UVh1V2wwaXAwejNqTi9LTndEYzdabkplendLOXVMN29FUjVDcmx2VGVIK1V6?=
 =?utf-8?B?Z1g0T1N5a0hMa1VIUW9ScEovQUwzRUc1S0lweGRDNEo0SW9xOXpIZGtFRFBH?=
 =?utf-8?B?T3dOdkZaRXpwU1hFK2tGU29qcWFONTJlYVRPcGhJb3Q2YkhYY09pOWtxNHFn?=
 =?utf-8?B?MC9RdUsybDdKMnpiN3RQczUvMi9sa3VRMXNmUUFHWjhoS2RZM1I2NlZmYUgw?=
 =?utf-8?B?K1E9PQ==?=
Content-ID: <4383BA18CA283141AA6711E18F9C4F81@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s1Ayu/Ctw33XAUbwKIaqpn8bFz6Pa1BeYcsqUYK0OpH5eRzsHQaLuoq+xEMVDqNxO/UCFWJJHPqH827pNXDF08AfJxEamezRUWtGp7gV+iqQzDpDh7iisb1C/DF1itrNEO75+bpDb/6wKwW2yvd0cmsem1qG3wh1F+t6q/y0YNokxOl7RRxM3PKQUB5huOhgT5Tt7rIcvu2drJldsgV+fLmicX6ZvSRy0+a0sPnME/xJ8Hqv3AelN9A8+DyLgATZhUUK9UDTpdKz0sAib1oHACN0yX9SdkADBOpS1+Qioosv/mIKXywutYI1tL2fYB0XQBtjeokwpAsD/UX4a9I4ZYiNegM2i+AUh6WRCFII/OY99iUcClPabso8toVR82BywP2BrUYoN3/ow7O1vzrbaGllQoWB/ssITGXaGR1j3RTUPwahhCdzwouus4npKQlv7eD7W5OMYOY3A3M4OW68fEISsOQFE48NumD34ErOPC151NxRvUYMpDPr8MmC/iDY6KB3ee/E2b/FEwi+igPgCvo8odh1K4trxH0MsrhyHyUsMsdbv8febZUGnD8hwMiX9v2/pyWNDppdflHRHm6ZPFZuP2X/wYMSWmcplrIal/X/3pCrsegT4PeP5SFnZ+oiTFoGkqAif4jBjmRA8lZvi0k7I59ex20oJKYBk0P9uoD5mwfpF2tX+O71gJlqU97gCbPBrCdxFpSn8/LiFLc6EdblsKmF8WlGbYeVkvbgLf1p9wbxyJAZGGI2dpMxBFfkQcNh/uZIUPU5jpXaC+K9W2hi7BqsL/epS9wDvu9rcjg=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10712.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b64ed3-a1c4-428d-9846-08dba38c4fed
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 03:52:03.4512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbWvbwG0kWueXpPWOT4DBmCgkkeaiNy3AmPtRXnw059kH/m58Xm4eCsnareCt+ZENUOCK8oNNAvHaRIS3/gWVMHCXkYwUWBtckOChSPhaJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8362
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/faccessat202: Add new testcase
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

DQpIaSBDeXJpbA0KPiBIaSENCj4+ICtzdGF0aWMgc3RydWN0IHBhc3N3ZCAqbHRwdXNlcjsNCj4+
ICsNCj4+ICtzdGF0aWMgc3RydWN0IHRjYXNlIHsNCj4+ICsJaW50ICpmZDsNCj4+ICsJY2hhciAq
KmZpbGVuYW1lOw0KPj4gKwlpbnQgbW9kZTsNCj4+ICsJaW50IGZsYWdzOw0KPj4gKwlpbnQgZXhw
X2Vycm5vOw0KPj4gK30gdGNhc2VzW10gPSB7DQo+PiArCXsmYXRjd2RfZmQsICZiYWRfcGF0aCwg
Ul9PSywgMCwgRUZBVUxUfSwNCj4+ICsJeyZhdGN3ZF9mZCwgJnJlbF9wYXRoLCBSX09LLCAtMSwg
RUlOVkFMfSwNCj4+ICsJeyZhdGN3ZF9mZCwgJnJlbF9wYXRoLCAtMSwgMCwgRUlOVkFMfSwNCj4+
ICsJeyZiYWRfZmQsICZyZWxfcGF0aCwgUl9PSywgMCwgRUJBREZ9LA0KPj4gKwl7JmZkLCAmcmVs
X3BhdGgsIFJfT0ssIDAsIEVOT1RESVJ9LA0KPj4gKwl7JmF0Y3dkX2ZkLCAmcmVsX3BhdGgsIFJf
T0ssIEFUX0VBQ0NFU1MsIEVBQ0NFU30sDQo+PiArfTsNCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCB2
ZXJpZnlfZmFjY2Vzc2F0Mih1bnNpZ25lZCBpbnQgaSkNCj4+ICt7DQo+PiArCXN0cnVjdCB0Y2Fz
ZSAqdGMgPSAmdGNhc2VzW2ldOw0KPj4gKw0KPj4gKwlpZiAodGMtPmV4cF9lcnJubyA9PSBFQUND
RVMpIHsNCj4+ICsJCWlmIChTQUZFX0ZPUksoKSA9PSAwKSB7DQo+PiArCQkJU0FGRV9TRVRVSUQo
bHRwdXNlci0+cHdfdWlkKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+IAkJ
CSAgICBTaG91bGQgYmUgU0FGRV9TRVRFVUlEKCkgcmlnaHQ/DQo+DQo+IEJlY2F1c2UgdGhlIEFU
X0VBQ0VTUyBjYXVzZXMgdGhlIGNhbGwgdG8gdXNlIEVVSUQgaW5zdGVhZCBvZiBVSUQgc28gd2UN
Cj4gaGF2ZSB0byBjaGFuZ2Ugb25seSB0aGUgRVVJRCBhbmQga2VlcCB0aGUgVUlEIHRvIHJvb3Qg
VUlELg0KPg0KPiBBbmQgd2l0aCB0aGF0IHdlIGNhbiBkcm9wIHRoZSBTQUZFX0ZPUksoKSBzaW5j
ZSB3ZSBjYW4gY2hhbmdlIEVVSUQgYmFjaw0KPiBhcyBsb25nIGFzIFVJRCBpcyBwcml2aWxlZGdl
ZCwgc28gdGhlIGNvZGUgc2hvdWxkIGJlOg0KPg0KPg0KPiAJaWYgKHRjLT5leHBfZXJybm8gPT0g
RUFDRVNTKQ0KPiAJCVNBRkVfU0VURVVJRChsdHB1c2VyLT5wd191aWQpOw0KPg0KPiAJVFNUX0VY
UF9GQUlMKC4uLik7DQo+DQo+IAlpZiAodGMtPmV4cF9lcnJubyA9PSBFQUNFU1MpDQo+IAkJU0FG
RV9TRVRFVUlEKGx0cHVzZXItPnB3X3VpZCk7DQoNClRoYW5rIHlvdSBmb3IgeW91ciBzdWdnZXN0
aW9uLCBidXQgaSB0aGluayAiIFNBRkVfU0VURVVJRChsdHB1c2VyLT5wd191aWQpIg0KDQpzaG91
bGQgYmUgY2hhbmdlZCB0byAiU0FGRV9TRVRFVUlEKDApIiB0byBjaGFuZ2UgRVVJRCBiYWNrLg0K
DQo+PiArCQkJVFNUX0VYUF9GQUlMKGZhY2Nlc3NhdDIoKnRjLT5mZCwgKnRjLT5maWxlbmFtZSwN
Cj4+ICsJCQkJICAgICB0Yy0+bW9kZSwgdGMtPmZsYWdzKSwgdGMtPmV4cF9lcnJubyk7DQo+PiAr
CQl9DQo+PiArDQo+PiArCQl0c3RfcmVhcF9jaGlsZHJlbigpOw0KPj4gKwl9IGVsc2Ugew0KPj4g
KwkJVFNUX0VYUF9GQUlMKGZhY2Nlc3NhdDIoKnRjLT5mZCwgKnRjLT5maWxlbmFtZSwNCj4+ICsJ
CQkgICAgIHRjLT5tb2RlLCB0Yy0+ZmxhZ3MpLCB0Yy0+ZXhwX2Vycm5vKTsNCj4gQ2FuIHdlIGdl
dCBhIGJldHRlciBtZXNzYWdlIGhlcmU/IEFzIGl0IGlzIGl0IHByaW50cw0KPiAiZmFjY2Vzc2F0
MigqdGMtPmZkLCAqdGMtPmZpbGVuYW1lLCB0Yy0+bW9kZSwgdGMtPmZsYWdzKSAuLi4iDQo+DQo+
IFdoaWNoIGlzIGEgYml0IHVnbHkuDQoNCkJlY2F1c2UgaSB1c2VkIHRzdF9nZXRfYmFkX2FkZHIg
dG8gdGVzdCBhIGJhZCBwYXRobmFtZSBwb2ludCAsDQoNCnNvIGlmIGkgb3V0cHV0IHJlbGV2YW50
IGluZm9ybWF0aW9uLCB0aGUgdGVzdCB3aWxsIGJlIGtpbGxlZCBieSBTSUdTRUdWLg0KDQpJbiB0
aGUgdjMgdmVyc2lvbiwgSSB3aWxsIGNoYW5nZSBpdCB0byB0aGlzOg0KDQoiVFNUX0VYUF9GQUlM
KGZhY2Nlc3NhdDIoKnRjLT5mZCwgKnRjLT5maWxlbmFtZSwgdGMtPm1vZGUsIHRjLT5mbGFncyks
DQoNCiDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCB0Yy0+ZXhwX2Vy
cm5vLCAiZmFjY2Vzc2F0MigpIikiDQoNCkhvdyBhYm91dCB0aGlzPw0KDQo+PiArCX0NCj4+ICt9
DQo+PiArDQo+PiArc3RhdGljIHZvaWQgc2V0dXAodm9pZCkNCj4+ICt7DQo+PiArCVNBRkVfTUtE
SVIoVEVTVERJUiwgMDY2Nik7DQo+PiArCVNBRkVfVE9VQ0goUkVMUEFUSCwgMDQ0NCwgTlVMTCk7
DQo+PiArDQo+PiArCWZkID0gU0FGRV9PUEVOKFJFTFBBVEgsIE9fUkRPTkxZKTsNCj4+ICsJYmFk
X3BhdGggPSB0c3RfZ2V0X2JhZF9hZGRyKE5VTEwpOw0KPj4gKw0KPj4gKwlsdHB1c2VyID0gU0FG
RV9HRVRQV05BTShURVNUVVNFUik7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyB2b2lkIGNsZWFu
dXAodm9pZCkNCj4+ICt7DQo+PiArCWlmIChmZCA+IC0xKQ0KPj4gKwkJU0FGRV9DTE9TRShmZCk7
DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsNCj4+ICsJ
LnRlc3QgPSB2ZXJpZnlfZmFjY2Vzc2F0MiwNCj4+ICsJLnRjbnQgPSBBUlJBWV9TSVpFKHRjYXNl
cyksDQo+PiArCS5zZXR1cCA9IHNldHVwLA0KPj4gKwkuY2xlYW51cCA9IGNsZWFudXAsDQo+PiAr
CS5idWZzID0gKHN0cnVjdCB0c3RfYnVmZmVycyBbXSkgew0KPj4gKwkJeyZyZWxfcGF0aCwgLnN0
ciA9IFJFTFBBVEh9LA0KPj4gKwkJe30sDQo+PiArCX0sDQo+PiArCS5uZWVkc190bXBkaXIgPSAx
LA0KPj4gKwkubmVlZHNfcm9vdCA9IDEsDQo+PiArCS5mb3Jrc19jaGlsZCA9IDEsDQo+PiArfTsN
Cj4+IC0tIA0KPj4gMi4zOS4xDQo+Pg0KPj4NCj4+IC0tIA0KPj4gTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwDQoNClRoYW5rcyBmb3IgeW91ciBy
ZXZpZXcuDQoNCkJlc3QgUmVnYXJkcw0KDQpZYW5nIFh1DQoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
