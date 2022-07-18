Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B02C43334
	for <ltp@archiver.kernel.org>; Mon, 18 Jul 2022 07:35:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DAC23C959A
	for <ltp@archiver.kernel.org>; Mon, 18 Jul 2022 09:35:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB7DB3C913B
 for <ltp@lists.linux.it>; Mon, 18 Jul 2022 09:35:46 +0200 (CEST)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3A066600697
 for <ltp@lists.linux.it>; Mon, 18 Jul 2022 09:35:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1658129746; x=1689665746;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=TiE3I7bck9Io+SedBi0BYpItJblHua2/wfddzFEoVgw=;
 b=tSWNXf15EaM6kP/XSfFMICA95DBP8Xb8AfosCZdV4blb+FjPylCtMxC3
 SPKXxAqF3RTP+F8eVj2cHMkge8cJ7ar1M7XLp0UcvgDN0ntFbhe3sV9XJ
 sQeuSlfkLyoTJLy2GbYaeCBbDdjH6JL0/HpYKRK523lR3Y64EwCRgm6ew
 +K15dVMTb0l2wN909tFXUyOjpQ9EA9cgMn4Wy8bxVGX2l1sCJ5gW6TVGw
 dze1TbWMPaXBaKGqrO5MfKOP6Ta6ul56sfmdfjuyJE1253LEULQFAbuOE
 79qwfAVDRW8kc2CoW4xs2SPqFo1eH7GXl0if2X8z49DqgoxMlU5R2CfoR g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="60609963"
X-IronPort-AV: E=Sophos;i="5.92,280,1650898800"; d="scan'208";a="60609963"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2022 16:35:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcUbmWARO3QDn2zgjr6H5k5YwIpvk6DYRxrvV5tTl+2sH3fxVbe195pXj6KhsUFp1EcxqAPUd61dpbymVUGg2hNpDBQrahVMkeoaZd0usmshEr0O4n1+rdwUzNoSfAq24E7B2nZal37MwFppMz8/qGBXFT6ZsI21+m/dhNnDcvGCQ0Og8jk/aTVrs8ENMa4hoLLiLzUFuAasAnc/2Ejg8eiFJRD14W6SFmUYsmpknM7MB2AHZ8wUrACvwz4Qnd/mEV5xUvnbTmnMKLHejn1bxpkCr/3s5tvT4AnfOit5D7nzofJ3XzG3pl7w+bnRiOrXIMDo8rtmAQ2zw1XJ7fWuBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiE3I7bck9Io+SedBi0BYpItJblHua2/wfddzFEoVgw=;
 b=DEKOVeqqXLGNms/Yfi7B9J+VmiUMhAx3Pox84DPbLRa6CiYcPGACBey2ZYcP5EKchw58zEcBVenPw7goewitkLq15RA4MaDs5iVth8fCYfXeeBIkecqLji+C7L6vhqBHc4uTWubpX7RZJB2rU2wfG5pf/Qx7Nk6tvQovqEGKm4PbfT7ZKJAXTNljZ5fEroc7LfOB07Mfl9PHxRLJWtPvkjLYTW2fJsqqss2/fXwbcdK4iVFTiezFJ048eCTn3d6WPKmva7GahKgU85rk+rfM0Qg94Qr3SdLI+43ZRtgZzENxOXwEnR+RtSlaTnNZQ01u/TFMcBcyaIklIBjjmPMitw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiE3I7bck9Io+SedBi0BYpItJblHua2/wfddzFEoVgw=;
 b=oX1ybMNDcl73FNEBfhE78AeCWPaVO6LKEJwdUaNvyMZxy7Kvnfvng85WQwkGFRlaClZAUJ/FV1XQNIYs/ljr0YQLnt0kn4lTthBcXUdyMT+vpKLWFqntesZkKrM0sKVq9roz2KBXUKQKHDUh+nQ/8o8L+MNtyv1fWthXWzi4hEs=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSBPR01MB2199.jpnprd01.prod.outlook.com (2603:1096:603:20::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Mon, 18 Jul
 2022 07:35:39 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5092:a34:8a79:5e78]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5092:a34:8a79:5e78%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 07:35:39 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: Do we have some simple way to get the current cgroup.procs path?
Thread-Index: AdiXT1u4fxhXw+J5TcO+wfpeq4Xq6QAHJHSAAMVgfwA=
Date: Mon, 18 Jul 2022 07:35:38 +0000
Message-ID: <8e16d91c-8307-8ea4-bde7-28ef093c1205@fujitsu.com>
References: <TY2PR01MB442719179C60B4DB6D275B5CFD889@TY2PR01MB4427.jpnprd01.prod.outlook.com>
 <CAEemH2fMfQYhfaV5_LeZCxfkCY=FKCqXc+SrZzQLVjzTf4yf8g@mail.gmail.com>
In-Reply-To: <CAEemH2fMfQYhfaV5_LeZCxfkCY=FKCqXc+SrZzQLVjzTf4yf8g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de743cee-8bef-493a-166f-08da68901c0f
x-ms-traffictypediagnostic: OSBPR01MB2199:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ciBc0luFY9OwOQFIjL0njfnjpnc9BfCMsDMzbwCQJKY1AdytQQOCQyq30z4wbfY8Mc1wnBhauAXI1DO8uY5qxzLj7JYyH6CaJvg9nBoIV9+ZiuwgHfte5VayPzrk70nV7QZYxym2DRElCx8oWi9XYqOiO/5AVaSMw3HfTV8xfhTMjp28p2nwfh6Ka7bvnfjEFFPcq52sCJAGzXOgnfOnim38riGb40nUTzNJUbMoyH1XK5f7ZWYburBLXv5+xLHDMNxOrwTBHKWEo2vxMjxv5DgcjnySlI7RoxXKrFpGd67SqRAnwdCrI36MTVL/scdH7VYH6GMaJsl+kUeZ3OlVxRunAE5QRGLgMuYpn7/IDd20lq0bzdyXXPqvOAWBuf8mLvN0PMVboeYGql/8waU6FWwYOQdvX/9zf56HBGcYy9Z3TDT09sDN56SkTjHJV+Bv0I2loKGMGsyeqM0k27Rrerdkx5cPAVb5tz43IfyofTRr1bjlne5L2ak2x/k4W3+M/C+yWYhyhqJYxnXiHZgBMWisipu+bllnkrHuaTGYMeUPOcDL+ve1XbNdJTpYIbwdPxTRLX1Jr3/eF1tU9zPawOAUXhNEiq1g5Bi1FxAYWFCvV0u1KqjSXuAbMMCVaIeA2ZspN/q4eMiZYLF+8Htbq12ijdzDsUzTnd30cQ/MZJ6ZlF1HvjfnW35pKU+bsQnRNRDCVxwD7en+xDpa5S1lSh+SMZBZIUkSANiu2NE7qyfx2bDnYF1X3v3en7NhFw9lXQQjqD1u67uxnnwUK4su/k+xHglGPhm3MkCchc7qltU5y/6He7c6CG/mHFu7V9TpNzQ51jczXSpNqd81ciCuJrXDpTiM8FJTaj6m1vwymE/fdihoCo/aG1srXROt3UFTGdnqg+jxuEAGVKhQPtOUAryBmBjgoBqhGvWxMzMwAEI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(82960400001)(6916009)(122000001)(38100700002)(316002)(36756003)(66556008)(91956017)(66946007)(76116006)(38070700005)(31686004)(54906003)(66446008)(66476007)(4326008)(8676002)(64756008)(71200400001)(85182001)(26005)(2906002)(41300700001)(6512007)(186003)(5660300002)(2616005)(6486002)(966005)(86362001)(8936002)(31696002)(6506007)(53546011)(478600001)(43043002)(15583001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWNXMVRlRFlVSkd2STQ0R0s0bEZMZXhCOXRNR1R6WFlXeHgzQ2FiY0NzRjl3?=
 =?utf-8?B?QmRyWDR6cSt0WGVUK0JDSWROV0xnY0Q5SGFCOUJqVkVSSTE0STFXZXpxN3lZ?=
 =?utf-8?B?cTNHUTd1SnBIUlNpM2xpNTRIOHBSNzlXb1R3TjFlaDlBcnlCSE5IZ0xySkIx?=
 =?utf-8?B?V25raWxKMmh4YzhoWkdWY25Md085UkxnT29jMnA0bG5UdzRMVXBXT3JZVE9i?=
 =?utf-8?B?dkd4WmtQS1paZDl6ZnBNRFFrWS9zYXBZUlFFaTJZQThqaldTSzRTdHI0ejU0?=
 =?utf-8?B?bFVxWloyQkhvandPY25yN3BMR09SdUViRmM2U3hUTzJOV0xqZnRQbmtGTmZW?=
 =?utf-8?B?MXhZVUFaZUtGRWZ6WVRXeis1S0I5L1F6RTJqTU92OTRacW9IdUdZSTNCZDc3?=
 =?utf-8?B?bUlXMUorN24xbUVuWnBVZFFPUE5KSFhBbTBvR3luSnUydGRFRFFyOW9sdlhy?=
 =?utf-8?B?YTRybnBGN0FhUnpDNXN1M3JiSVFPZEdSL1h6cGYxaTlMTEpLU0VHdUVlNks4?=
 =?utf-8?B?dGZibW01Q1FsVTJCaXUwbjlMWXFjY2xqTCtqWEhjbGJVQ3ZPTzh1UUpoTFo5?=
 =?utf-8?B?aFh3QTVvaXVic1hwa3Q1VUt2b0VsL3huOFgrcVhxTzJ4TFJ4N09pWnJNK1dE?=
 =?utf-8?B?ekkrRWlTZ0V5T0p4QXpFZzl2aUdMZTBYVTQ1NVR1T1ZEK2Y4czdCdFVzdlJI?=
 =?utf-8?B?emlnSW9tam1wdHZXOFNRbkFpRDl4dVhlUVFFNTRyQ3pQWFdSMXl2dHI2UVBK?=
 =?utf-8?B?NThVMmZrUGNpVXg4RUFHMzZsVlk3SE55YUV5dVNscVFGb0ZSZzAyOG9ZVGZH?=
 =?utf-8?B?OFF3My9LR0lSMUNrRU45NmNWbktjbko4R09YRnFwNFd6YlVNREJyS1RYRWJz?=
 =?utf-8?B?bVVHM3NqKytPTXplRmlCL0lMSi9oYlh0dEUvcXk0cmYzSHgvd2hLcHVXaUl6?=
 =?utf-8?B?UnRUZEErTmN4d3kvY2QyeU95cUlEYlBMc1JnWlo3eGRKQndIaFhlNTRkTUF0?=
 =?utf-8?B?R3VMbVhRQVRWQU9pVHdOcy9LMlZIemNhbTFqWnR4bUNxL1Z3aUZaQzB2eWx4?=
 =?utf-8?B?NFpZcDVTZkY1eUVTVHcwRnAxRGJIeTdObWhUQyt6a25BcUhHY2RwNU9MS3FL?=
 =?utf-8?B?b3o3Nzk5UW1TOGFRMzZ0SkZlOGh2NDNiUmt6M1lCMDZRWis4WDNuQjRBMUk0?=
 =?utf-8?B?Mkl6cXlDeGtwUngyWk5qT3VxT0M1dDE2K3FFN0M4TW5zeFovTFRhZHFJbmZq?=
 =?utf-8?B?WjhNdkVxQ1V5RURnc0k3WlN5T0k1Z3V3cTZJdTlZMlExcHVLUTZKR25oL0lW?=
 =?utf-8?B?RW9YNEJ4bkV0Qk5NSldpdEhCRWZYOExqME1wVEJ4TlY3Q1pKV2lubEROY2dC?=
 =?utf-8?B?VGJ1Qmo5U1JxTENsTzg1YzFwR0kveFFsYmxIa0U5bHVKd0RLZHZUZUhPaUFx?=
 =?utf-8?B?QVgyejBpaGdkOXJOMXorWEhoWGdRenlNMm93L04rQ0R4bHJBeGxTQ095YjdX?=
 =?utf-8?B?ZWt3UXRFSlh1R1JsRGFkam9qVjU4M01RcG8xNk0zNWFseFpkdWhBNUpVUjBn?=
 =?utf-8?B?amxQUThoTTNVMmc3dGREK3ZWUEY2czRBTGRzZVZzdmMwdHJvNTZTTGR1SXF5?=
 =?utf-8?B?ZnYyYnlEa293VjVXT1lMY24xUVdyRm9HTnZocnBxSWt2NHdRdUxzNXdoN3RO?=
 =?utf-8?B?b1NDQ0NUNk5LUlJ5NU1PR2lIcGRKdW1TV3RVeHg2WWNCMnVNd0VOVUZtcUNM?=
 =?utf-8?B?NzRELzNDRlRzUy9NSU5XViszaEVFNEEwdVlrTWJ3dm1NcTRxR2pqQUMvNTEv?=
 =?utf-8?B?NmlHckU0V0dyNVBZTjZFeFRuYTlzdVVaUDI1S1JRV2hFOENUYVpYWDR0cHQz?=
 =?utf-8?B?cm1JWEpUaklYMkI3WUZRWU1lcE85T2x6cElKRXlNZUNsV0poZktGWUdRTXR5?=
 =?utf-8?B?TXl6bHk0aVEwb2J2cFFXdmZ2cXd0SDdTOTZZR0loU1RSWmRBeldLM0J3M3JB?=
 =?utf-8?B?RDBKZTF1dUZUWkVKc0JsRnVSVzBtZDA4dWhTQTZIOGg0SHRoZlFUZFEwZEdX?=
 =?utf-8?B?ZGdqbjFJUTdLTTZ0QkFjeTljQzZUUnVlYmFUbUE3b3lSZW1CNlR1RWhRT3pE?=
 =?utf-8?B?dFpEejAxUnAxNGp2aFRoWEphWC93eHZndzhXYUYwcnUwK3ZScHgzRHpld0lT?=
 =?utf-8?B?c0E9PQ==?=
Content-ID: <99D3755E1833B6448CCA1558E63D30EB@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de743cee-8bef-493a-166f-08da68901c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 07:35:38.1207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WPgpqFtLUzjsTk7Xcf1QcgFoztijUHkb0NwcfQuVCaYNHuFREHRF2hyyAyMBlxb30mUWbDO095fux5QUgiiJNMHfLpHtOwQo/t1NHvtRBFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2199
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Do we have some simple way to get the current
 cgroup.procs path?
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGkNCj4gSGkgWHUsDQo+IA0KPiBPbiBUaHUsIEp1bCAxNCwgMjAyMiBhdCAyOjAyIFBNIHh1
eWFuZzIwMTguanlAZnVqaXRzdS5jb20gDQo+IDxtYWlsdG86eHV5YW5nMjAxOC5qeUBmdWppdHN1
LmNvbT4gPHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20gDQo+IDxtYWlsdG86eHV5YW5nMjAxOC5q
eUBmdWppdHN1LmNvbT4+IHdyb3RlOg0KPiANCj4gICAgIEhpIFJpY2hhcmQsIExJDQo+IA0KPiAg
ICAgSSBhbSB3cml0dGluZyBhIHNpbXBsZSByZWdyZXNzaW9uIHRlc3RbMV10aGF0IHJlZmVyIHRv
IGtlcm5lbA0KPiAgICAgc2VsZnRlc3QgY2dyb3VwIHRlc3RfY29yZVsyXS4gSSBtYXkgbmFtZSBp
dCBhcyBtZW1jb250cm9sMDUuYy4NCj4gDQo+ICAgICBJdCB0ZXN0cyBjZ3JvdXAgbWlncmF0aW9u
IHBlcm1pc3Npb24gY2hlY2sgc2hvdWxkIGJlIHBlcmZvcm1lZCBiYXNlZA0KPiAgICAgb24gdGhl
IGNyZWRlbnRpYWxzIGF0IHRoZSB0aW1lIG9mIG9wZW4gaW5zdGVhZCBvZiB3cml0ZS4NCj4gDQo+
ICAgICBJIGhhdmUgdXNlZCBsdHAgY2dyb3VwIGZyYW1ld29yaywgYnV0IGx0cCBjZ3JvdXAgb25s
eSB1c2UNCj4gICAgIFNBRkVfQ0dST1VQX1BSSU5URiB0byB3cml0ZSB2YWx1ZS4NCj4gDQo+ICAg
ICBIb3cgY2FuIGdldCB0aGUgY2dyb3VwIHJvb3RfZGlyIGx0cF9kaXIgcGF0aD8gU28gSSBjYW4g
b3BlbiB0aGlzIGZkDQo+ICAgICBhbmQgY2hhbmdlL3NhdmUgZWZmZWN0aXZlIHVpZCBiZXR3ZWVu
IG9wZW4gYW5kIHdyaXRlPw0KPiANCj4gTm90IHN1cmUgaWYgSSBmdWxseSB1bmRlcnN0YW5kIHlv
dXIgcmVxdWlyZW1lbnRzLg0KPiBDYW4gd2UgYWNoaWV2ZcKgdGhpcyB0ZXN0IGJ5IGNyZWF0aW5n
IGEgdHdvLWxheWVywqBzdWJkaXJlY3Rvcnk/DQoNCkkgdGhpbmsgeWVzLg0KDQo+IA0KPiBEb2Vz
IG9ubHkgdGhlIHJvb3QvbHRwX2RpciBtYW5kYXRvcnkgZm9yIGNvbXBsZXRpbmfCoHlvdXIgdGVz
dD8NCg0KSXQgYWxzbyBuZWVkIGdldHRpZCBzdWJkaXJlY3RvcnkgYW5kIGNncm91cCBuYW1lLg0K
PiBJZiB5ZXMsIEkgdGhpbmsgdHN0X2NnX3ByaW50X2NvbmZpZygpIG1heWJlIGZpdHMgeW91ciBw
dXJwb3NlLA0KPiBidXQgdGhhdCB3b3VsZCBuZWVkIGFkZGl0aW9uYWwgZnVuY3Rpb24gaGVscCBl
eHRyYWN0aW5nIHRoYXQuDQo+IA0KPiBUYWtlIGEgcmVmZXJlbmNlIHRvIHNlZSBob3cgTHVrZSBn
ZXRzIHRoZSByb290IHBhdGggKGluIHNoZWxsKToNCj4gaHR0cHM6Ly9saXN0cy5saW51eC5pdC9w
aXBlcm1haWwvbHRwLzIwMjItQXByaWwvMDI4NzcyLmh0bWwNCj4gPGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvcGlwZXJtYWlsL2x0cC8yMDIyLUFwcmlsLzAyODc3Mi5odG1sPg0KDQpUaGFua3MsIEkg
cHJlZmVyIHRvIHVzZSBjIGFwaSBhbmQgd2lsbCB0aGluayBhYm91dCBpdCBjb250aW51ZWx5Lg0K
DQpCZXN0IFJlZ2FyZHMNCllhbmcgWHUNCj4gDQo+IA0KPiAtLSANCj4gUmVnYXJkcywNCj4gTGkg
V2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
