Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4D7C433EF
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 07:10:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B0113C8C62
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 08:10:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC58D3C06B9
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 08:10:00 +0100 (CET)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 64BD81400994
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 08:09:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1637564999; x=1669100999;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=nkfwPdO0m+j0DEAiLNYwBOG/Q5neOIM9nYplwcMFy3s=;
 b=nmsHcVoXZC4hC4OcAvvabojw6dtUIlhs4wEdvHv4ybFNLgBekbnopZuO
 T6cRA4kOAGal95i9ZpW8bWlt5lTZ49kGshD4n1pd8lY9VduQOu+IQWYqv
 BldV6SxRES8KK4YQroI3G1Xq0pF4nFKXNIkq9tUlSy16d9FWejN3JmzUu
 2mg5MEeM/Y8lGPslPcZDH6W/TpJuKV9Qthxq1AmauMSGbseuGf5WCtFMn
 dRwa+5IZ4Km425BQHDWc0oBY/B5BmKouFgc9S0P/Akdgtvdjs8z19DSS1
 lsk90cdj2Db6inndeNu9meAv5zB+lbYf2d4+MVi3iuFPFF/ReLSTXbNnr Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="44280348"
X-IronPort-AV: E=Sophos;i="5.87,254,1631545200"; d="scan'208";a="44280348"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2021 16:09:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hsf7vB9InWoyWR9RMTkT7kiS3LQRVjZE+TiYYiH5dQWGebXUygjrJBPxDW/x1lN1vXapktLO4f8qxpbIAR8gF85/IRhwGclgAyZx/C1hXD8p7SC2MP26EcgJPd3o7BxZ0OIOuAsvbS9Rqzr08fuB8WXyhPJ4SCZeXZeuAPzS4jE9eQ7hWE/wqzm4wEwM/GrfvihjR02q8BDNHbuls1YxPpH70qkZJKF5XVtFD9F0yrirSj1JT3RQSpgFd2t9o/XIz67/002ZZYieZkuKArnNZVTsqx1XR75Ub9hCkSnXyicgQ9noApIsOZ0/lkJ72PsbzwJDFIw03/diJGTwgiHxPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkfwPdO0m+j0DEAiLNYwBOG/Q5neOIM9nYplwcMFy3s=;
 b=OJJLzU8Ik+ufcEMWzDykKQmoTEsH9HE3uoglzkAIqCmjihPveScC1ioQZzJydjr+gtavoD7lNv3vyKf527jJKm0CxRX/y5wPztpB16AB8D/baGZ/SOAnvTBXRZqGVtsAjXn1LVVgdtFOzgtpdN2AMWqEj06boWlLP+olThfsW4OM4cNHKl09VrshSfrTCbhx/x0oNV7Bu1yGKi9D3SkmZP2RE7mkeuDJpV8WeWjNE9cMhjrCORFpjP8RbCDx7UX0tYKj7EK5JtzLIWDhsbOw4JAP8/fA87eWzuAP65ppbOwVKd2M7SCmaWF8bfYgq33Q6v+D7JxU4wZYt0T47/39gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkfwPdO0m+j0DEAiLNYwBOG/Q5neOIM9nYplwcMFy3s=;
 b=M24zArUEB5ZUgOiroEbrKCyR9lRv+ZkUIejCOXL3CZsH9ylX8SG9mQEXcfhkacDpA5QHbpGX0l9o1d7tnOSVO+fhMgtzxeLreKCGxbgtTmMJS2GHU80VYofjZhkqx1kJBf0sb+eUz8ON7nUidGq/55h7Wh4RNB+lSa/J2o2TYsI=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY1PR01MB1563.jpnprd01.prod.outlook.com (2603:1096:403:1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Mon, 22 Nov
 2021 07:09:54 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%7]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 07:09:54 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Jan Stancek <jstancek@redhat.com>
Thread-Topic: [LTP] [PATCH] finit_module02: fix exp. errno for O_WRONLY
 testcase
Thread-Index: AQHXyaPvQYfk9SBELEWpwUTdeDR4/6wHfa2AgAfHK4CAAAfIAA==
Date: Mon, 22 Nov 2021 07:09:54 +0000
Message-ID: <619B4244.9050601@fujitsu.com>
References: <04692b4000ee415add41128173e395f830ea3e56.1635168255.git.jstancek@redhat.com>
 <6194B56D.9070100@fujitsu.com>
 <CAASaF6yzyUmwLWQrNy8QR6rLC=y6xrbPZMuyqHHjFBtPR1XjUQ@mail.gmail.com>
In-Reply-To: <CAASaF6yzyUmwLWQrNy8QR6rLC=y6xrbPZMuyqHHjFBtPR1XjUQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9078cc2-6e1f-4f3c-08c9-08d9ad871581
x-ms-traffictypediagnostic: TY1PR01MB1563:
x-microsoft-antispam-prvs: <TY1PR01MB15635702BD07835515975C20FD9F9@TY1PR01MB1563.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:534;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hOz2Y2E0DvqtCCyhXErf51F56gFBGTX9QwUvR9BT/j7vFj940jb+Saqq7I2ZjVFVHI8DCWfkHo/lXoE/vgtg0cBa1eNnrPi1FUgOogAGqF/CTb5YH4lLxDRiYKVytM6FkNrsV3/wvb9Yig/b+ZCeoO+ALrq3zsCcI13OErfv0olHHT1KH7Q2HVz5M1ohwxfEB3fExzO1mSOl4aNjoojgiWQUe7vkGPFPoyhNa6DoD2vHEN6gdbBzYBpUnm7vcEKqwsDgvMu9GpuwWhzeJmVo5UAylTpkYlZnQMbbHtjx8a8TdVOPZOTLwsv6hC1rhF0dqF2ffzKhZxZnNDzQy2TKA4CmiHhA4YHH/wDmBvDWDBmhqJsERlw4rApBDQt7U317+lnE5ACA4LDjqpSHPOEIk/PqyCmE2HRs7g9qVV8/0l+rVUwh2MmTdxyqV52HCwTHi0isontugL/NvtVwh/3dzbOUtHdDmcdpFB6V1He39qqdDuHH4KyredjXfVAntTx65CJJntQSfjSzlo41kZ9XajG0/NF+1smUFNVKTkSLP0ygULWKYroKk/w+96/V+SreE1Y1UUdVB4V43c4Wbq8m8vh95G+O1ftBMJ64nR0dg7It/phE+cV0Lr7MgQNkJ16cwXnK9C4cF9t1EUA/e3unCJsY/09gZueZosmqILhN1g1Ty4fZfHPTefd5Yzg6mcVVSxXRyU6Ihhr5RFX4X/4GPRVSyfpANmgECGGr+wHRr8hMbpKIx+aNkbc2I+Wp9egpPSGGhpFe8vJv9YVrtZk0H9yPPLWwpvP3M0xTdGyQhbw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(5660300002)(8676002)(71200400001)(64756008)(66946007)(66556008)(66476007)(122000001)(4326008)(6916009)(66446008)(8936002)(508600001)(86362001)(2616005)(186003)(83380400001)(87266011)(316002)(6486002)(53546011)(76116006)(38070700005)(85182001)(6506007)(2906002)(82960400001)(91956017)(33656002)(6512007)(38100700002)(36756003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWkxcFBWekRuZTIvUUE1blNiMU94b3ZqTUNzWGJEMnIzQkVReStNWlN6TkVn?=
 =?utf-8?B?Wmc4RzUxbkg3WjVXWFQ1Kys5WDNnMTFXZUp2VEtpYTk4MDk3VkVKSVNUS2VJ?=
 =?utf-8?B?MUR5SzR0eXdlakRiSWNab290Vm1SbVFTaUxjWUFydGZESVlSTkpSWTBlZExW?=
 =?utf-8?B?a2RmMFdETzJrYVd0dFdvV1NTR2tQN0RzRHBjUzBiV2Q2UE5DaDhwZ21TRnFM?=
 =?utf-8?B?SlpvUEJqN0prNzMzeTFWWk5uQko4SkVGTng3WFRWNTlTdUxGNlhaZkYxNmRO?=
 =?utf-8?B?TWs5dVNwbTZ5eEJ4OWQwczdHM3pscVFXdTIwQmpiVEJoNUJkK0s2RGRzWGVi?=
 =?utf-8?B?V2I3d2s5VW8rRFNKejYzZjlLeE9rSXlLd3Z4TktUQWx1VU5PT2FZWlgxTG5z?=
 =?utf-8?B?QTVsa295RnhXZ1hnTjZIaEZyTlhNTS8rNHUyNXhNOUJiRDlaLyt2Vm9NQm5o?=
 =?utf-8?B?VVdVM1N3cG44V295Z1hwZW44WkJGY1NxZXR5cUJNRVQ1eXFOdWU3RmpCZDRZ?=
 =?utf-8?B?M1JHb3VhdU4zenNQeUNTZk0yZDBpNFprOEszYkUzeUI1cWVxSXVlTzRkMGZp?=
 =?utf-8?B?RjlQUW1FbS81THNJOE9IUm8vNlRwTDFBWGt4R0pCeU9FWkgzNUxJKzVYckMy?=
 =?utf-8?B?bGpVREpMcWl5V1lhbHhLWFlnWVp6bHBTb24zU2VFc3JLSUZaY0tYeGN0WnN1?=
 =?utf-8?B?UFF5bUs1TG5KbFRLeVcyOVJnVzlsUEZGSkJvNGp1Lzh4QS8xT0JJNVMzVjdt?=
 =?utf-8?B?ZllFaUhadlRKQW0xcjFXL3pxT09Ld0c1T0NKdUVkelNaY0RFdXB0NE5nQ2VJ?=
 =?utf-8?B?TUd5TlZCcFExY3NTbG5aYkpEbEhIWW5GMGhEWGFMbEFaZkhUUnQ1dFUvbEc2?=
 =?utf-8?B?aGdtS2l6dlYzZTNxYUhUK1lDazRESE41UCtZUW5Eb0NtZVA3R0dQSUZ2dENX?=
 =?utf-8?B?VS9zSDNOZWE1eng3am5hbElIUDFGZnZCVHEzVTRKMUh0bWx4Q0ZuZURuMGtU?=
 =?utf-8?B?TWlZRnFDMjVzcUo1ZENiSVJHSjVqTVM3cENqK0kwN29ReEJRVldjMzRHUStt?=
 =?utf-8?B?V0taZlplRjhHZXNNYnNPVXAwWHVoNGczaEJmRWVxTSsrTVloRG0razJKK3N4?=
 =?utf-8?B?clNTbkRnNzI2QlVUbTBMRDJKMkJqeXFUVXF4UkRVcWVTU3RUWWxZZjF2TGQz?=
 =?utf-8?B?TDk3R3BVelo5NE0yUmFEVDRJU2ZYcDFqb0pwS01SUlFHYk1Ma1lLandxUmZV?=
 =?utf-8?B?bCtGUmdGcTVYTmlBVVBNNE5iam0xL2o0VGFxeGlsMWw5c3FadEFFNEQrRmMz?=
 =?utf-8?B?MkdtM2VWcERFbmxnZ0ZiMHdxa1A5dXJ2OTVuSFJKblhrNVVRMDBia09ZZWw1?=
 =?utf-8?B?R1p4Tm9ubHVzL2VxUnlrQUZZVVdHUWxkOXVubmpLYWdmV0NYa21hODJqbjls?=
 =?utf-8?B?WS80UFFLZzRhRUR4RisrYlVpTmJiSzBvOHVWSnQ5UEt1ZUcrc1ZyWGlpZ1lC?=
 =?utf-8?B?NmlKOENYT0ZlMUlsVzFtaWlEb1RIcEFycnpvS04vMmg4dnA4UWlaQm5sMjA0?=
 =?utf-8?B?eEdLZWo1L1Z5bWRYV2VNN0MycjNoUnBRd1RwUU9VRmN2aytLM212L2Jaekxi?=
 =?utf-8?B?bmg1SDVNeE1kdjI0VElyeGlEdnB0WWJLZ0dzNUpqMERXVDVPblErcWw2ZjdB?=
 =?utf-8?B?TFRSOXRrWHJrRE9VRmZ3ZkFGK29sNzNhU3lXOUZBUzhDSDFVQ2hldTgyb0pv?=
 =?utf-8?B?NjhRYk0vaVhOWEE1T25TTzQvRExDZjJkeTFTRVNHQzNoV1g2ZndGQktDVHpp?=
 =?utf-8?B?RmcvYXNPdDRjU1I5cTFDM3ZuY1gzaDRtVEhpVm51OUNhQno2OTFWOHlHVlVw?=
 =?utf-8?B?Vmx1emZhaDdJdDVlWmVIYVRKSEV1aUpDbWtJYlRCWHE1ZXV2T2c2aHY1eUQ3?=
 =?utf-8?B?VnFxc3JmcThhTlhOQkdvTlFhUnRHV3VsSERJWDhyeFR6Y1IyeTh4TXhicnNv?=
 =?utf-8?B?eFlKYS94cTd1RHBNU3UrTWhLOGRmVGt2bnplb2J6U0VsWm1UZVErSFozTWRP?=
 =?utf-8?B?a3JSdnE1c09IV01GNmtVb0dXTndvVk55NXhPMXpOc2JPQmFOdnRpMS9MRUhs?=
 =?utf-8?B?ampsUnNid1F5N1ppYlBWeUlsWXhFdER4YUpQSVZmcDRDV3BYa0JHZkhQcnJ5?=
 =?utf-8?B?Q05rcVpCRkRXVkp3OVNZdnZvVEVhN1dRa2RtQ3c1dmFJZzZMWTFuUVNMVGIz?=
 =?utf-8?Q?DRgIY7mE776Y42jiwRm/5hmVjSn39morDGPE3LhNgg=3D?=
Content-ID: <5F7723CC6B99814AB255E1538856DEB7@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9078cc2-6e1f-4f3c-08c9-08d9ad871581
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 07:09:54.1439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01BqIdB6/7kXUPBOqJgcrplkd7J9gM+BMkDH6oWIyz7bMrEA5o9ah6/wYQnFFWIRQ/Q0oe0bqct75Ant4tgwh5A3HcewwAio5RxaB1Npiv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1563
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] finit_module02: fix exp. errno for O_WRONLY
 testcase
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

Hi Jan
> On Wed, Nov 17, 2021 at 8:54 AM xuyang2018.jy@fujitsu.com
> <xuyang2018.jy@fujitsu.com>  wrote:
>>
>> Hi Jan
>>> commit 032146cda855 ("vfs: check fd has read access in
>>> kernel_read_file_from_fd()") changed errno back to EBADF,
>>> which is correct value according to man page, so tweak
>>> the test to expect it for kernels>= 5.15.
>> It seems we still can hit ETXTBSY error if we  use RDWR fd on kernels>=
>> 5.15.
>>
>> This error existed since the following commit because of
>> deny_write_access api
>> commit 39d637af5aa7577f655c58b9e55587566c63a0af
>> Author: Dmitry Kasatkin<dmitry.kasatkin@huawei.com>
>> Date:   Sun Oct 26 12:42:07 2014 +0200
>>
>>       vfs: forbid write access when reading a file into memory
>>
>> I suggest add a RDWR test and send a patch to record a ETXTBSY error(
>> Since linux 4.7).
>>
>> What do you think about this?
>
> (Sorry for delay, I'm catching up with email after holidays)
> Since it's also not documented, I'd wait for Cyril's patch first. But
> we can always change it later (I see patch was already merged).
Yes, I have merged my patch with Richard's review.
Also, I  have documented this error by sending a patch[1](still in 
review) to man-pages community.
[1]https://lore.kernel.org/linux-man/1637136967-13028-1-git-send-email-xuyang2018.jy@fujitsu.com/T/#u

Best Regards
Yang Xu
>
>
>>
>> Best Regards
>> Yang Xu
>>>
>>> Signed-off-by: Jan Stancek<jstancek@redhat.com>
>>> ---
>>>    testcases/kernel/syscalls/finit_module/finit_module02.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
>>> index 0d2bf917ea64..9b5d3563b74e 100644
>>> --- a/testcases/kernel/syscalls/finit_module/finit_module02.c
>>> +++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
>>> @@ -52,7 +52,7 @@ static void bad_fd_setup(struct tcase *tc)
>>>
>>>    static void wo_file_setup(struct tcase *tc)
>>>    {
>>> -     if (tst_kvercmp(4, 6, 0)<   0)
>>> +     if (tst_kvercmp(4, 6, 0)<   0 || tst_kvercmp(5, 15, 0)>= 0)
>>>                tc->exp_errno = EBADF;
>>>        else
>>>                tc->exp_errno = ETXTBSY;
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
