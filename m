Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37841C19F2D
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 03:40:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5B193C9886
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 05:40:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 247163C96B7
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 05:40:45 +0200 (CEST)
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com
 [68.232.152.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E19BE10005C3
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 05:40:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660621245; x=1692157245;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=rzx+6MLYnTvbmy/qVnRSB9T/wkkBOHMEDT0L+cvVhNw=;
 b=ZJt4yinO4rTKHx5MqGtHmU80Q8+vtn9BAhaUit926qD4m6HjRlgF6CqN
 j0dOUMxPg4f10n7ekHstv/IFpCe/8frtSIWgAltu9pmAKLQx8SftcUl+A
 Y1ySbBp8eyrPImKhG137EfuTsrEqpKojT0XA05LvtT2uZoGcApMatXlxK
 0QgLnMrCZ9lw/lYvyfbVDke75sMpeKeWOFpPduez+KH342IVpCFPX2flq
 2+aIXzDUYcWzgfh6KMzZe32KR4Pfb4fxUneSkyYfbs2t5Ef+1dkASiIN0
 804G7jCzr8yy5sqg9ZtwPwXBG5YQP3Z5C1Rc1HrDyeweZKTJuk/pMElEX w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="71044828"
X-IronPort-AV: E=Sophos;i="5.93,240,1654527600"; d="scan'208";a="71044828"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2022 12:40:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTj2QsUiOod0njCAVRiXnA3/0zsGCSgnLwa3CluPyoKXA8IqE02eXeC7Zare+lkfPQQl3e6AEc5k4DDwqJKgt7HuoBMdPXcJa2BYd7z+QP4bJGuNMhH7ZZcl0JTeDoUbfEkHFDymVVKiXoXc/363h/lvgEFyprL364cOsRODl271F7COVUlkpojXGUEliWttDwAPNhDujf0+6woDPP5pBnDSP9NXr6rnOxEec7dc8O4pLTSvPIepHVgz3Iq4ND02259ipgPURZ1ypeJyZ+jxRp3p2WAqBi89FaPjc4TSo46RH9z5K8dJTie7qd0f8FI2XTYgHpAQ4hUtj5k3DdH50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzx+6MLYnTvbmy/qVnRSB9T/wkkBOHMEDT0L+cvVhNw=;
 b=FO3+5MsE6aeT8ij6/PjtIOvpsVL2omIq0ZSi0w7ZDrsmQ8SWmGHzm6J3ruvKEKHxJQBoeObXIKL0Ci0sAHVixFx1Ki+SkB0Ubf5/e3/Er52KXUuOEJ/yjOaqw8LM4T4Z0wMA/xrB1Wi0wROBhaQqaLhUSztKZ5/oEgHyt7cu/CX9OSjDBYkqlzm0lOPKxt5LMsZnZGiUERc5hSlM1/vfp8O8D8oOiDuTWldpooKXSa4zJKJu8UNZq7TB/4oqjANF1FyP0z5bGY5PGfXLODoFJxAuUix4uEB0ySMyouMPXPGHNjih0XCnJY08GUKo7i7avViC8rkw3Ah6Fr3a3+0lHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB7358.jpnprd01.prod.outlook.com (2603:1096:604:148::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 03:40:39 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 03:40:39 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v3 0/2] mount03: Convert to new API
Thread-Index: AQHYrYpdivkAy4rXlU+UH1tz7IrvUK2vgeuAgAAG24CAABXngIAACF8AgAApqACAADhFAIAA8NUA
Date: Tue, 16 Aug 2022 03:40:39 +0000
Message-ID: <f7c6df02-3c39-ead8-2bbd-8cc26d36ff7f@fujitsu.com>
References: <20220811135731.2228-1-pvorel@suse.cz>
 <765b4f35-2cd0-04e1-e405-04261b5ef645@fujitsu.com> <YvnqZfyByO42kAX9@pevik>
 <1e791bd1-2661-95b0-1f0b-e3ca82b6524f@fujitsu.com> <YvoDyrIGa3/BsqI3@pevik>
 <f11fc30d-d875-0d60-6807-7bfa9998f21b@fujitsu.com> <YvpV8Iz+zVAhwvRv@pevik>
In-Reply-To: <YvpV8Iz+zVAhwvRv@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7fcbd3f4-0478-4d32-d7d8-08da7f39166b
x-ms-traffictypediagnostic: OS3PR01MB7358:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZrObZI4w9nc7Sqol7euf+1pLv96ZscztTCYGwSWEfZQn8z+DaA4FRMfl3+nlZYPBojcdJxkSfhfTPgALzwhKCVTyJONuieNJdyn801fdgsjw7YmDcuWJTlbkDdG60Ln60AsbmW2xsUxyGo7qje6uesgSFj1OP2RxfB2ZGRDKa7QLo6Ukb2aw6+Dj0T2Tb+S1gfU2nEhvm8DgaeWE3AiVBX/rIDaassDLcn3Dz3pkGD99156UcoSwqNkczCIXyt9svqrUdqwDD/5pFf77v/y+L7L31iF/majRcPbpaBMv9+ny+7dQYE74UXKazZUKLg7c/3dTHD/PdNj2r5SpXz3d8ti8cgqWZxl8Nr5KhUwWuiAXgNUcrxV40whEHV6okZGVNAYRadL97+L16KKmrlGQN9yfZOVLbo2haIgIkbiixPFpWvaCT2t99PoR09LNuwKwRcdNIdN5f6e0yO6eeCG83lwO7Ed5X2wcxgu5Rz5suKU+dD7SnZ9CZ5JTmttnzazitsZOobmHvHijjLfcxMchWd3IZrY/TEfDpIbsrMQzEoVThH6h2euMmMv8RTfsW9Qzg+VQXsP9p6k1uUfwfGdHw2L6a9Xz0rr+bgVMw/lRtEtpd6orN+OSqGGJLGjckdxoRLXSgscHS7num3Sh2ODwumdNu/z5lnh9+A79d6jG2gV/kxKTCxhj5LK2LbyjAwDIUgawLZ6uKSzOacO6D/dfw1MkQTxhqbRMcQpFTnnugF7Yta4zkMTQqwjMDtOpCnV9RDfQW7krvN219PMc5QKx+iTtYDu0spVs93GttEdW1OMImMccUlhAUJnX46QILxELhf1hW6ssiu5McxNN8YcmD6s8WzJtjw/H4C39J0MEctuXx1/4s4R/KTVPJprrl+s4/k82VkhS5jUN//Mq4Kfjmg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(38070700005)(83380400001)(82960400001)(76116006)(2906002)(66556008)(4326008)(8676002)(66476007)(8936002)(85182001)(5660300002)(66946007)(36756003)(64756008)(6512007)(41300700001)(71200400001)(2616005)(186003)(31686004)(66446008)(6506007)(38100700002)(1580799003)(122000001)(316002)(6916009)(91956017)(86362001)(31696002)(26005)(478600001)(6486002)(966005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjM5R203cDgrUXQvY1A4MmtsTHlZdGFiVVZ6UHN2Tmd2VXZTTDRsMDdKNUV3?=
 =?utf-8?B?SVVPNkhpMHNQWVVJYTFVQTB0OHpaZWEyeTJxRjZObWRuSDk5Nnk5UlEwSVVJ?=
 =?utf-8?B?bTNxY3RqTk9kNTBTQXA1ell6eVZXbXNsQmJ6Ry9rNjA5aFdWWE5RMGdIckdO?=
 =?utf-8?B?M2lSdDk5bm5FSVoyamdwaTQ4TGlBMFY4c2c2b1VGWXRoQ3BhMzRDTU1TVWNJ?=
 =?utf-8?B?bmZMTEtCb3RvQXRhZy9xYnF6TFlJM2kwcFR6VFFTWlVZNTJjRGVOY1hxVGNq?=
 =?utf-8?B?MlpLeksxUStNWmtRRVRvVHArd2FEaC9pdzNFQkhmNkRmeGJvaXltVTkrLzFM?=
 =?utf-8?B?aGRVU3p2emUyVUdGRytDcGgxL3ZOQ3hRRHFGdFFlN0ExcFIybm04VTFqUW5O?=
 =?utf-8?B?TWtRSFhKKzllRlJ5ejRqN1ZjQzRLQ3YxWGMrcVFwcVM0b0F1VmhuK09zZnBa?=
 =?utf-8?B?d1E1UkdiYUZJYWZxYkJydkpCUlpSVjVRR0VxOGN4V2NWcVdJcktXbmZ5YUMv?=
 =?utf-8?B?SVp5TkxEeXNrcWNUSnlnU0pMa1B0MFhKUFNVR0xZWTluM3RXbVFodzRLSmZ4?=
 =?utf-8?B?UHdvTWtyWkdIK3kyekdUYUlvR25lZUdsWmlVOUZHNFJLZWo5ajNYb3VYRE41?=
 =?utf-8?B?cVd2UTBKVllVdnpTQnh0T0ZvU3dKbVNRSG9rZ0d2SjJ2Vmxwbk9aNnNLcUx1?=
 =?utf-8?B?OUhRaUpZRmU2cjRtQzA2LzUrWkhNNmR0ZjdjeWlEOHVmNnA0K1Y5bC9yOFMw?=
 =?utf-8?B?ZXZBemdac0ZBOWlNdFMySGpnbEhLNENNT1NINkVSY29yeHQzRnpCbUtBMU1P?=
 =?utf-8?B?Q1NNU25zbDNCWlV2dHN4UGg3dGdJK2xxWnU0WlgwWjlWV0JRcmVPZlFRK1Jr?=
 =?utf-8?B?a2p2TC9QUzFYWndsdXBod1RlandFTEVFaTVvYURmcHQzL1dKQVl5aWNXMUdz?=
 =?utf-8?B?YVNsUHRzSVFoOGFUOG1kazhqNUIvQ1djNFo1RFU0Ylg0QXM0bVZjQVVnOVNt?=
 =?utf-8?B?Q2VLRmRoV2ZyTGFsYTdDOFlyQnQwMzZiVkRWbWhCaXIrVWV3a21LS2ZpYmdi?=
 =?utf-8?B?MFlReVdjTEpRUElQdjIyTjlNaS90eDZTa2VNem5TZGY0bEFoMGMvNjVya1dX?=
 =?utf-8?B?czJ6Z0JSY3pzNjNyY00yMGhub1B5RmNWZUlCTndIbjZGcWhhQXRDUFZTT1Z5?=
 =?utf-8?B?QlBuSzlLNTNkS1JEUDUzSlJGMUNPVXlQeXJzMUhtNTZuaWwvSFp0WVhweVg3?=
 =?utf-8?B?bnd3NEVMNjFrdG9NV01MNjhWUG1UWkRJRDhjaVBpZ21hblNOSHcwaXRmTEwy?=
 =?utf-8?B?VWJLbWNkTitPSnBuUmdlSDlKV0RPTDBubkJ1QnZFVmp3UjluR1pXWUZZRjVJ?=
 =?utf-8?B?ajk1U2NFbGVSZGp3SmdRVkk2d1h1RFY2N1U1WTdLdElwZ2wxclZ4dkZxekx5?=
 =?utf-8?B?QjBkbUJzVDRRZ0I3Yi84SCtvc3NnVmUwdUtZT2prWTFUc00za2ZVZDAxdFpQ?=
 =?utf-8?B?YnA2dWJCUG50WDRKYlN5Zjd0UXZ5cnJJSndMZU8vK0hvTXdzbUdodiszQ1cx?=
 =?utf-8?B?UjJlcDFVNmxlR3dkVVU3L2huL3V1REtwaCtuS0xzMGNYZHRINmg4ck1LSVJT?=
 =?utf-8?B?WjZMSUVkbnZQSGFsYkxuTFIxRjRDci81YXl0Q2c0VncxaStsakM0d3drcnZq?=
 =?utf-8?B?aXMwVHMxTzN4VEVURWJDSlZTUkJrTFhaaWpndlpzZ1dlZzJIeDJlNGxSbjF1?=
 =?utf-8?B?clpXZnpLK0pBWWVSM256dTBZOHViUzl4ZXpRMVkrWGF1bDk4VlFHUHd2OWhv?=
 =?utf-8?B?aFIza1RQTW5GRjgvMitqUW9ubk5ZWEpGWkllZVFtalZEK3R4bU9iUDBmUnd1?=
 =?utf-8?B?MzhWeWM0c0h5ZHZPeGt4Q1V6aEtpNEx0Y2RNK1d4MUIraHZaZE9YQ0pMeFN5?=
 =?utf-8?B?VnR0SFYrZTRtZEVqVmF4bE5jQmNSV1JCdVVuMWx2ODJBRjdaVVM5dWIrKzdy?=
 =?utf-8?B?MEJlSk0vcVczRDBGbGhxOGZJK2MrcitubE1uL1ZHTUEvbVFaM2pYdTR3VXhE?=
 =?utf-8?B?QitxQ1gxZGJrbE9uc1lFVUVGY1Bua1lYSktVVVpsU0lsclhxOCtuL0EyK01Q?=
 =?utf-8?B?em5RcWJqOHVsb1gzR1lKQ0MrdlJwK1ZWVW85UTYySmJGcGhwS2kzQ2NDelVG?=
 =?utf-8?B?VFE9PQ==?=
Content-ID: <81E105048C19E249922CCF3F1BB7177B@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pucgo+gfX9TTrxfQ0nlhPhTRzS3KObWs7iYlyfy5+oFI7adUyId/uwrzQQfx3ISVTxEOZ83boTwxUAQfmVOvjA5c/dbxEHp7Rbro9ouHYGK7KFMWMqNE77yRwcrvsVJ67wR+yoCKJ3tI9ZBTFjssbs5utJR4XEx8DyiqCmMsWuhwxrBRII4+4S1VbK4qlR7LR5LdRIq92BDO7n8coZfjarFcBenbXoyPdht87iwUKcIXRToi5dLQ81MzLQEpUdQfEnZ+mJJmVcmmN4vgVXHZn1ZSAgX4yxVdsJttYhW8TRJ2sDm9LNBEWFgrEfO34400ixn9p84ltpKdvdJ98LQNDEpj6k26a7+kmi6wY3+AAKIzK7rS9SLlioDgD1LHPyeiYbkCR7QK8mdLU6S/u7HVASwpR8s3oBzvc2r5B5VhdFPKhuIe9YR1aw7fwtHF51q5VCCo1xlmHruaWY6G9rNBbZnxNCZ4S9JeFRMJYS839UI9llZSCL/Xvh2i4oCbHOlqXxIOCYq9lHdt/UEGvIiqy45417RUddvc8KMeJGof1zmMgi1rS+Zs1StwSNrJ44Xu3JcPkcoGzTjUYvkWtKPy0mXSvQhiRbZFZEjVBZWA/+yMbn5GtDjjqUQI0jVa1dMruMqEGxdaDNkIQdsMZp9tZj5/5UCa4E/2Fo36aPrWTzqGznRDLzPq0FBI85WvmvIsB/Dd8F/Iac8aGfAhlQjhHIZTvGDPlnDGPw7vIw56R/4Dq/FJLoctEJ56Lr8kjy+X
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcbd3f4-0478-4d32-d7d8-08da7f39166b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 03:40:39.1907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xXLtERAbhc/XVsDTQBxwNFmierVLRvZJKHQZy9iDVJ0Cuu80h2sEYwq2BHh6foSLjP52ojCtRSyZm7mOHrkjVJwi9C4FulvA6Sec3bViaAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7358
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] mount03: Convert to new API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

> Hi Xu,
> 
> ...
>>> diff --git testcases/kernel/syscalls/mount/mount03.c testcases/kernel/syscalls/mount/mount03.c
>>> index 74b018d78..9c58783d7 100644
>>> --- testcases/kernel/syscalls/mount/mount03.c
>>> +++ testcases/kernel/syscalls/mount/mount03.c
>>> @@ -15,7 +15,6 @@
>>>    #include <sys/types.h>
>>>    #include <sys/wait.h>
>>>    #include <pwd.h>
>>> -#include "old_resource.h"
>>>    #include "tst_test.h"
>>>    #include "lapi/mount.h"
> 
>>> @@ -145,7 +144,7 @@ static void setup(void)
>>>    	nobody_gid = ltpuser->pw_gid;
> 
>>>    	snprintf(file, PATH_MAX, "%s/%s", MNTPOINT, TESTBIN);
>>> -	TST_RESOURCE_COPY(NULL, TESTBIN, file);
>>> +	SAFE_CP(TESTBIN, file);
> 
>> I still think we should test nosuid behaviour on different filesystem
>> like other test function because we have expand it to all filesystems.
> 
>> Also include tmpfs, so SAFE_CP should be in test_nosuid function
>> otherwise may hit ENOENT problem.
> 
> Ah thx, good idea. I guess the point of the setup was to run copy only once, but
> your points are obviously valid.
> 
> I didn't notice it before because I overlooked SAFE_EXECLP() in test_nosuid() it
> had parameter TESTBIN, thus not being run from mountpoint.
> 
> nit: I suggest to move to SAFE_EXECL() as it expect path, not filename as it's
> not using PATH. Similarly we could change execlp() to execl() in test_noexec(),
> but I'd prefer to keep execlp(), so that we test two different libc wrappers.

Sound reasonable.
> 
>> different code as below:
> 
>> [root@localhost mount]# git diff .
>> diff --git a/testcases/kernel/syscalls/mount/mount03.c
>> b/testcases/kernel/syscalls/mount/mount03.c
>> index 74b018d78..b0582c76b 100644
>> --- a/testcases/kernel/syscalls/mount/mount03.c
>> +++ b/testcases/kernel/syscalls/mount/mount03.c
>> @@ -21,6 +21,7 @@
> 
>>    #define MNTPOINT        "mntpoint"
>>    #define TESTBIN        "mount03_setuid_test"
>> +#define BIN_PATH           MNTPOINT"/"TESTBIN
> +1 for avoid the need of snprintf when there are 2 constants.
> NOTE: we can separate 3 items with spaces:
> #define BIN_PATH	MNTPOINT "/" TESTBIN
> But I'd rename it to TESTBIN_PATH.
> Or maybe even better to use just "TEST":
> #define TEST        "mount03_setuid_test"
> #define TEST_PATH	MNTPOINT "/" TEST

Looks well.
> 
>>    #define TEST_STR "abcdefghijklmnopqrstuvwxyz"
>>    #define FILE_MODE      0644
>>    #define SUID_MODE      0511
>> @@ -75,12 +76,19 @@ static void test_nosuid(void)
>>    {
>>           pid_t pid;
>>           int status;
>> +       struct stat st;
>> +
>> +       snprintf(file, PATH_MAX, "%s/%s", MNTPOINT, TESTBIN);
> this is not needed when we have BIN_PATH
Yes.
>> +       SAFE_CP(TESTBIN, file);
> SAFE_CP(TESTBIN, BIN_PATH);
>> +       SAFE_STAT(file, &st);
>> +       if (st.st_mode != SUID_MODE)
>> +               SAFE_CHMOD(file, SUID_MODE);
> 	SAFE_CHMOD(BIN_PATH, SUID_MODE);
> 
>>           pid = SAFE_FORK();
>>           if (!pid) {
>>                   SAFE_SETGID(nobody_gid);
>>                   SAFE_SETREUID(-1, nobody_uid);
>> -               SAFE_EXECLP(TESTBIN, TESTBIN, NULL);
>> +               SAFE_EXECLP(BIN_PATH, TESTBIN, NULL);
>>           }
> 
>>           SAFE_WAITPID(pid, &status, 0);
>> @@ -138,18 +146,10 @@ static struct tcase {
> 
>>    static void setup(void)
>>    {
>> -       struct stat st;
>>           struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
> 
>>           nobody_uid = ltpuser->pw_uid;
>>           nobody_gid = ltpuser->pw_gid;
>> -
>> -       snprintf(file, PATH_MAX, "%s/%s", MNTPOINT, TESTBIN);
>> -       TST_RESOURCE_COPY(NULL, TESTBIN, file);
>> -
>> -       SAFE_STAT(file, &st);
>> -       if (st.st_mode != SUID_MODE)
>> -           SAFE_CHMOD(file, SUID_MODE);
>>    }
> 
>>    static void cleanup(void)
> 
> Final diff is below, but for readability it's temporarily also on my fork:
> https://github.com/pevik/ltp/blob/57ba1ba47987a201c39764b4259a15aa39db9d2e/testcases/kernel/syscalls/mount/mount03.c

OK.
> 
> Kind regards,
> Petr
> 
>> Best Regards
>> Yang Xu
> 
> diff --git testcases/kernel/syscalls/mount/mount03.c testcases/kernel/syscalls/mount/mount03.c
> index 9c58783d7..eef2a65c6 100644
> --- testcases/kernel/syscalls/mount/mount03.c
> +++ testcases/kernel/syscalls/mount/mount03.c
> @@ -18,8 +18,9 @@
>   #include "tst_test.h"
>   #include "lapi/mount.h"
>   
> -#define MNTPOINT        "mntpoint"
> +#define MNTPOINT	"mntpoint"
>   #define TESTBIN	"mount03_setuid_test"
> +#define BIN_PATH	MNTPOINT "/" TESTBIN
>   #define TEST_STR "abcdefghijklmnopqrstuvwxyz"
>   #define FILE_MODE	0644
>   #define SUID_MODE	0511

Here SUID_MODE miss S_ISUID, that is why this case also pass if we 
excute a program on filesystem that not mounted with nosuid option.

Also, it seems make check code has problem when detecting S_ISUID

Symbolic permissions 'S_IRUSR|S_IXUSR|S_IXGRP|S_IXOTH' are not 
preferred. Consider using octal permissions '0511'.

Since we have converted mount03 into new api, mount03_setuid_test.c 
should also be converted into new spdx.

Best Regards
Yang Xu

> @@ -74,12 +75,18 @@ static void test_nosuid(void)
>   {
>   	pid_t pid;
>   	int status;
> +	struct stat st;
> +
> +	SAFE_CP(TESTBIN, BIN_PATH);
> +	SAFE_STAT(BIN_PATH, &st);
> +	if (st.st_mode != SUID_MODE)
> +		SAFE_CHMOD(BIN_PATH, SUID_MODE);
>   
>   	pid = SAFE_FORK();
>   	if (!pid) {
>   		SAFE_SETGID(nobody_gid);
>   		SAFE_SETREUID(-1, nobody_uid);
> -		SAFE_EXECLP(TESTBIN, TESTBIN, NULL);
> +		SAFE_EXECL(BIN_PATH, TESTBIN, NULL);
>   	}
>   
>   	SAFE_WAITPID(pid, &status, 0);
> @@ -137,18 +144,10 @@ static struct tcase {
>   
>   static void setup(void)
>   {
> -	struct stat st;
>   	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
>   
>   	nobody_uid = ltpuser->pw_uid;
>   	nobody_gid = ltpuser->pw_gid;
> -
> -	snprintf(file, PATH_MAX, "%s/%s", MNTPOINT, TESTBIN);
> -	SAFE_CP(TESTBIN, file);
> -
> -	SAFE_STAT(file, &st);
> -	if (st.st_mode != SUID_MODE)
> -	    SAFE_CHMOD(file, SUID_MODE);
>   }
>   
>   static void cleanup(void)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
