Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03D5C433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 02:47:15 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96FA610A1
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 02:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A96FA610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 311003C697C
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 04:47:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73BD83C6730
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 04:47:00 +0200 (CEST)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CE4B11000972
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 04:46:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1635302819; x=1666838819;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=3sKQDPljcSdJ5KzWj4gXNoLSbR3rxy7MKldUOm2BFoU=;
 b=TsHeuBe7km3oyASF0fkquVFsTxENxkAkeolHb05QR3QnTQESmIE0cFrr
 2PYP1tckUvqgoWyH3ETAaMyafzpu1xW9g24KWWk0u3h0SQ3eccbqqAuF7
 nje772vy5mSBU5TE8JK8d514nT7IXQnDPxqQVo503SUK0Ti4UAMqvSn80
 1jdo8Z0FYgy3zZCzm90JfUnza1R3dFlJES886D7qwyGjFxK3be1nHc0hT
 xFwuCDD359EilGdcvZj1m03yHPZ9voWfYLwSokk7/GJyMMGChjRFIRooF
 f35XUpVjnS1iy/kHrgoqZg4z3THxI9WupBIO1cTjXC/0k6kF7Ny5pRJUR Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="41955244"
X-IronPort-AV: E=Sophos;i="5.87,184,1631545200"; d="scan'208";a="41955244"
Received: from mail-ty1jpn01lp2052.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.52])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2021 11:46:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hirqtAfph+RBnnzFixMXiabBexmHLEh+gy5yQJHK5hNKUEExcABXB7ZiP83O334KZz+vpUyrKxyPa9fARVs7HNBOaZefSwC/zxDwSj+gapkbq+MlvBd+DckJRCEm60UtuWAoqnczkojDAmWBpq7qZL4QUyWKa5pDhu9k0sSHYkDIBkAV4dwmNlwX/eWDXBn8SkV0psJ0gVGFY3805MwrtaQaYJst+8nGP9Y+T8MpuJP10yVoBP7FePKzlzLhm7GnMe4EHtVdgd/rWAiGWlLbb1R4IWCiY7eSns3hOj985Hsin5XcIlEt8yoZaMOnPqyjzKCSyZtOSs9otru6j82yDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sKQDPljcSdJ5KzWj4gXNoLSbR3rxy7MKldUOm2BFoU=;
 b=nu+4Q0VXnsybDsSM7ncbDX4yduCwLQ9upJ4ckoa/7hEVOd1skdU5L1d+iGzgCK+GMAo2OT+3eF7CISlx9+GRwa9Xzzbek6QLWZtl6h4JhL27UcliqDRRzHtWTT98cSG2OP/6CBesrbaUNAyePIU6fcyHzp7aO9nyVBHjrNoUxmIBC4K61yt6YwFljUF0O2PPU9UYf5ROokhLbt1KqW3TKxwbUvEQuegvm0IYefD4lKZyhs+2JBy8ySuzK4lPe/Pa/DJwmoF/5+8o6VBg7Jzg6nQ6YN5pC1F6tE+Kz97OX/MgcJ/cbf/5U5kMOZQmdRUxPWKBwM1EonxDztq62Q7gaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sKQDPljcSdJ5KzWj4gXNoLSbR3rxy7MKldUOm2BFoU=;
 b=a5PF9afAJt3BMaqVbnr3DbYCuF/XNnOuDc8yK7M7gEx+CCIdAM//Dtg8+Zxq35JQdnVYUDIW/FttydqYs5viND3JrcsO8AiWuApcXPFsoPEr35eG/sI6l5DQYn7dxe6TNePsQxw68rLZN65BJQ5Tea0hjKJx+4hQoEpU4JPXlYA=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB3466.jpnprd01.prod.outlook.com (2603:1096:404:dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Wed, 27 Oct
 2021 02:46:51 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9%7]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 02:46:51 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v1 01/11] syscalls/quotactl01: Also test with vfsv1
 format
Thread-Index: AQHXxCGF1MPw5guTZ0O9O0ERuHDmgqvlVJwAgADc7gA=
Date: Wed, 27 Oct 2021 02:46:51 +0000
Message-ID: <6178BD9E.1020206@fujitsu.com>
References: <1634562591-5830-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YXgESh8jbi+l1KNk@yuki>
In-Reply-To: <YXgESh8jbi+l1KNk@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1581ebd4-f64c-4e9f-a97d-08d998f40753
x-ms-traffictypediagnostic: TY2PR01MB3466:
x-microsoft-antispam-prvs: <TY2PR01MB34664EE25A3E39A3BC42E216FD859@TY2PR01MB3466.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CE+0pZEoW0LvOGkznSm8X4GgDIFdCEd9MwdNLxF+saHVv2zinnUrALfxpAkqMEq62T1jwywKUMqFOmoRUjA8lBLxLwToH9yU0fWNGSsSDJnETdZ6NCakdrQWSkoAvgKUogxHtNwJQi/9Hrx7AXrASDSZYY8oyG/2vnvykWgU/Gi7xv+NTtBn4cD0vkSZVstVS34KfGc7JWW8IQQFJMPQw9zGC9qWen//GV9XyUmpwafH7kI9vtjdml5/8fyj6Nc0rsg07gE6HF+5HxGmTbt8iz3Ao8wcjIsLjFD5cFRPVtRHEGojNRqggoE6DRklpHEXzwHvF17OX6vM5K2usHd9yfCmGmDyneNsjf/43+AwEJvdoA0EaoeHc1QNpI2wuxGO09enKqjGByNLuKuY04EDHOKa8EhyeX4V4TcKo6N9ThlG7YB44ppg+D5MlHzZGz/YfInLlNsW5E5s/cqjam2dVyk41Yf5GlDXIinYA0qJxM02eoQgeKiL7URUrPRtbl4uGeanB1VaZxzvu7v4hU8f2g364ANvymwGlWphDuR3XTuSYMP30SFCbJXlpSTPMi6xENNP4eMZFzpoAPIE8JP/i4yMzGYJEkSqKl170W5JXg3baE/KqP2GKQBEd+5irMWs2rFuPocgzkuHoyC47Dn6dtwGSFDSWwyOtS0PhM/ZHcCWdkg2RgsEWkPpURrnOoQYgIADAgRhLWkYhYaYO5tFNMtn4GR3QTItxE9JuY2h2tapHSbBKOwsZu4XSvSFlUJN+KqAwL19G0LxdYqqKEganc3uEORVDgIPSXoJIgcstS0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(86362001)(85182001)(122000001)(966005)(6506007)(66446008)(76116006)(38100700002)(6512007)(8936002)(38070700005)(2906002)(5660300002)(91956017)(71200400001)(87266011)(2616005)(186003)(508600001)(4326008)(316002)(64756008)(66946007)(66556008)(82960400001)(66476007)(83380400001)(6916009)(34290500002)(8676002)(15650500001)(36756003)(6486002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZWtJME9KSE9NSVZIZlFaZlFkMU1rT05ncThFQXQxUDYvNkhjMXFBRFJQT1Ew?=
 =?gb2312?B?c3JJLzFyRGd6M0dJekNkYWg1NTg0N2lrNUhXeDlZdUNxUWVxVmNROFZMcjRu?=
 =?gb2312?B?MnE1ZUtlQjlOczVPK2VDYUg4cmVVYmpmY2p2RHZEbnZGbWQ1TXB3MFVNTzdl?=
 =?gb2312?B?TDJiM1E2YWQzakZPU0hnUU00MDd3Z25YbXdXRmV4cG9udWl4SXFQSDJuTG9a?=
 =?gb2312?B?eVJWUHgwUk5NNFFYKzcwOENLbERDMnU4aTRma1ppSEF4dmgvTlhEeDAzVWd4?=
 =?gb2312?B?RU5XTjlTKzN4WTArdEpoeW5NY0poaVRxb2tsTzRxd1JBdzRBZlM2a3FyTHU2?=
 =?gb2312?B?OWszUzN2OHgrVGF0anhPWVdkL2ZaYTd1VkNRLysyaVpEODV0L3huRmNQN1Bu?=
 =?gb2312?B?UDNuSUZERkcrK25WdzRsZGZydUdJQ1l0ZTZoeHJaSzRUVXUvR05IVnBySDB2?=
 =?gb2312?B?ZVF2bzZSKzF2Mk1aR3ZxRld3c1ZhZXNUK2tiYU93MytEUzR3UTZtbUJMY1RC?=
 =?gb2312?B?QlB3eEs1dGUyNmFsU1ZiQVRIWTRpZ3FiUFRWOFFySVM2V0NNQjJyQXhxYXRT?=
 =?gb2312?B?YjNvRGVhMW1EUUIzR0VwMkVaSm4wRlROLytxb2tVaHkvYTZpMWpDc0dXQ09B?=
 =?gb2312?B?NnlmajZERkpTTnZNaVpSMGtjQ0tOcGlZbmlqVmY3ZTB3NGl1WU9pU05RYWtZ?=
 =?gb2312?B?UmExVXhMdU5na3RMcmgrT3NGYTBEeGtrcTRnQjNNdkVKMnRDLzE2Q3ZvWXla?=
 =?gb2312?B?R0RYVTZqV29GN3VOc0FicUpkRTM2THE1aUl3Zjh0Tm5haVB0eldubURXOVJJ?=
 =?gb2312?B?NytaRkFybUFJajQxSjI4UVhUNFVNdW5mOGhaMUlqWEtqSXZiWlJUU2dienNa?=
 =?gb2312?B?bEE3WGZNMU5IMFdPSkZwSmlyQXBkdzdaVUtVd2hiRjQ4R2xFMjBUZ2FyejJH?=
 =?gb2312?B?VzJkYzdTeXZhbStFKy84akJyZ3pXZXprL0NWRmp5ZE1vaTJoc21MTVh5cGVM?=
 =?gb2312?B?eEFWejcyQ0drUlU1a2JEUmhJUmVuU3JXZk5maXQrR3N0UWMrNlpxNHVVa3By?=
 =?gb2312?B?WXlQZnp1S0dRTFFTLzZ2dXpuRXJWUUZXdXdxVjZSTTlEc3REUUk3QldFQU9X?=
 =?gb2312?B?cG1zNjBSbE42REhXZVAycHc4Qm9oVi9pdS9QRVlQQXBuSUtnYStpL3FBRUFx?=
 =?gb2312?B?WVl6VGdZNFlPQ2ZRM2tPOEM4TkR3d1hFSFZpOEh5MCs1N3g4aTUzdnl5ZFRJ?=
 =?gb2312?B?YVc3bUhuS0NuOWltV3Q0V0gxVWlFY3c2ZlRmb0tJOGpsNUlpb3cvYVE3ZG9l?=
 =?gb2312?B?a2NSTTlmdGV0ZVNhR1pFanNrSGRUYVlpelQyL0gza1VLMGxCSW04THBKbWQ0?=
 =?gb2312?B?S053TkpJU3dFcStTSmkzUU5Sa29ucFZ2ZXFZVWxYTG13MVp3RGxCam83Sm53?=
 =?gb2312?B?c29rS1JzbzdGajROSGNqaWFJOEpMdUsvMk4xN3JCaGl1VFZuT2hoaW9DazlY?=
 =?gb2312?B?aXJIYnZEMGI0VS80V0RLT2lUNVVMUlg1c1NmcyttQ2RpNU43V1l4bmpOVTI4?=
 =?gb2312?B?NndWb2pnZW5sZFFseGgzcSs5bWE0UktyaDlqNTNrOFpSb3lzSWU4WWo2RGkv?=
 =?gb2312?B?eHB4Z1ZUU2xkM3l1QTB2TktobnRYdWJ3N1pTQ0xhR0MzdGF5SnpQblNrR0lp?=
 =?gb2312?B?MUJoQjMrZkpneS9raGRvS1p6Q2V4czJKOFBhRHBGOUpqREZSaHVHcHRmNTZY?=
 =?gb2312?B?SGh2Vnc5eDA2cE90ZFZZRVFuMUJkU3dmOXB6eWlXZ3RJWExsWWEwVDBWc0ln?=
 =?gb2312?B?U0lGeXV3WlpERVhkUmdya1U5azhmSVVGbDkwcDc2S1BlZHRKODY4QjNlU3BK?=
 =?gb2312?B?Q29FMjdWMDd4c3l5TFhCQ3dpOGNOREFaU2phZUhJSmRBaDVpLzkrQXkzYXgz?=
 =?gb2312?B?eE1hLyszajdtS0YydmJ6MklnYW5FTmVOazRwZ3R1ei92Rm9oWWYyRGFoc291?=
 =?gb2312?B?RWp1RlRjYTZjRkFaaEJ0K1YxajRtMzNCQk5HMWNQTDBZUitJODJMQVozblF0?=
 =?gb2312?B?Y0laYjFWdXg0ZVUwSnJhNWxtMXk3cHdJNDhodHkraVZOT1h4Nmdka2RDVkRp?=
 =?gb2312?B?NDIrTDdsQUdhOThjdCtvSiswcFA5QmtTdFlyd2ZFUnpyU0h5ekI4SjBuR0U4?=
 =?gb2312?B?aVhRcmNYVmJaRFRoUUxHakM3eEFkL29LWWdxZjlsU0UwcTBNZ2xBQkMwN25u?=
 =?gb2312?Q?HqN7UmVnnwgZwyQvpmb8kKoNXOWkmY4IBG2UUthCU8=3D?=
Content-ID: <FD6E79F90AB8BD4EB23E07D1D1E0A001@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1581ebd4-f64c-4e9f-a97d-08d998f40753
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 02:46:51.1204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i3YlqL/k+FkHCVc4XcH7bT7dlCeicS84IMZS9ZHPXW6m4w5wpddTVQG9K74xZy8vTFWAeZVIlEmtIDQ78BnsKmM0LskokI/J2fy2hqwgzGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3466
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 01/11] syscalls/quotactl01: Also test with
 vfsv1 format
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

HI Cyril
>> +/*\
>> + * [Description]
>> + * This testcase checks the basic flag of quotactl(2) for non-XFS filesystems
>                                                                 ^
> 							       ext4?
>
> It seems that the test is using ext4 only, are there any other
> filesystems that should be tested here?
Yes, Good catch. I will test other filesystem.
>
>> + * with visible quota files(cover two formats, vfsv0 and vfsv1):
>>    *
>> - * This testcase checks the basic flag of quotactl(2) for non-XFS filesystems:
>>    * 1) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for user.
>> - * 2) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
>> + *
>> + * 2 quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
>>    *    for user.
>> + *
>>    * 3) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
>>    *    for user.
>> + *
>>    * 4) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
>>    *    flag for user.
>> + *
>>    * 5) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
>>    *    flag for user.
>> + *
>>    * 6) quotactl(2) succeeds to get quota format with Q_GETFMT flag for user.
>> + *
>>    * 7) quotactl(2) succeeds to update quota usages with Q_SYNC flag for user.
>> + *
>>    * 8) quotactl(2) succeeds to get disk quota limit greater than or equal to
>>    *    ID with Q_GETNEXTQUOTA flag for user.
>> + *
>>    * 9) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for user.
>> + *
>>    * 10) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for group.
>> + *
>>    * 11) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
>>    *     for group.
>> + *
>>    * 12) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
>>    *     for group.
>> + *
>>    * 13) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
>>    *     flag for group.
>> + *
>>    * 14) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
>>    *     flag for group.
>> + *
>>    * 15) quotactl(2) succeeds to get quota format with Q_GETFMT flag for group.
>> + *
>>    * 16) quotactl(2) succeeds to update quota usages with Q_SYNC flag for group.
>> + *
>>    * 17) quotactl(2) succeeds to get disk quota limit greater than or equal to
>>    *     ID with Q_GETNEXTQUOTA flag for group.
>> + *
>>    * 18) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for group.
>>    */
>
> This does not render as a list in asciidoc once the documentation is
> rendered. I would have converted it to a bulleted style lists, i.e. the
> list items would start with - instead of 1).
>
> Also it's a bit poinless to repeat the quotactl(2) succeeds on each
> line. It would make much more sense to put that part to the sentence
> that describes the list as:
>
>   * This testcases checks that quotactl(2) succeeds to:
>   *
>   *  - turn on quota with Q_QUOTAON flag
>   *  - ...
Ok, got it.
>
>> @@ -43,16 +66,12 @@
>>   #include "lapi/quotactl.h"
>>   #include "tst_test.h"
>>
>> -#ifndef QFMT_VFS_V0
>> -# define QFMT_VFS_V0	2
>> -#endif
>>   #define USRPATH MNTPOINT "/aquota.user"
>>   #define GRPPATH MNTPOINT "/aquota.group"
>> -#define FMTID	QFMT_VFS_V0
>>   #define MNTPOINT	"mntpoint"
>>
>> -static int32_t fmt_id = FMTID;
>> -static int test_id;
>> +static int32_t fmt_id;
>> +static int test_id, mount_flag;
>>   static char usrpath[] = USRPATH;
>>   static char grppath[] = GRPPATH;
>>   static struct dqblk set_dq = {
>> @@ -163,9 +182,22 @@ static struct tcase {
>>
>>   static void setup(void)
>>   {
>> -	const char *const cmd[] = {"quotacheck", "-ugF", "vfsv0", MNTPOINT, NULL};
>> -
>> -	SAFE_CMD(cmd, NULL, NULL);
>> +	const char *const vfsv0_cmd[] = {"quotacheck", "-ugF", "vfsv0", MNTPOINT, NULL};
>> +	const char *const vfsv1_cmd[] = {"quotacheck", "-ugF", "vfsv1", MNTPOINT, NULL};
>> +
>> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
>> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "usrquota,grpquota");
>> +	mount_flag = 1;
>
> Why are you moving the mount from the tst_test structure here?
>
> Do we have to remount the device to change the quota format?
I think we don't need to remount the device and we can remove quota file 
directly to change the quota format. Thanks.

Best Regards
Yang Xu
>
>> +	if (tst_variant) {
>> +		tst_res(TINFO, "quotactl() with vfsv1 format");
>> +		SAFE_CMD(vfsv1_cmd, NULL, NULL);
>> +		fmt_id = QFMT_VFS_V1;
>> +	} else {
>> +		tst_res(TINFO, "quotactl() with vfsv0 format");
>> +		SAFE_CMD(vfsv0_cmd, NULL, NULL);
>> +		fmt_id = QFMT_VFS_V0;
>> +	}
>>
>>   	test_id = geteuid();
>>   	if (access(USRPATH, F_OK) == -1)
>> @@ -182,6 +214,12 @@ static void setup(void)
>>   		getnextquota_nsup = 1;
>>   }
>>
>> +static void cleanup(void)
>> +{
>> +	if (mount_flag&&  tst_umount(MNTPOINT))
>> +		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
>> +}
>> +
>>   static void verify_quota(unsigned int n)
>>   {
>>   	struct tcase *tc =&tcases[n];
>> @@ -222,13 +260,14 @@ static struct tst_test test = {
>>   	},
>>   	.test = verify_quota,
>>   	.tcnt = ARRAY_SIZE(tcases),
>> -	.mount_device = 1,
>> +	.needs_device = 1,
>>   	.dev_fs_type = "ext4",
>>   	.mntpoint = MNTPOINT,
>> -	.mnt_data = "usrquota,grpquota",
>>   	.needs_cmds = (const char *const []) {
>>   		"quotacheck",
>>   		NULL
>>   	},
>>   	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test_variants = 2,
>>   };
>> --
>> 2.23.0
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
