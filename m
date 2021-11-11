Return-Path: <SRS0=2GLJ=P6=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5108EC433EF
	for <ltp@archiver.kernel.org>; Thu, 11 Nov 2021 08:48:38 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8016A61267
	for <ltp@archiver.kernel.org>; Thu, 11 Nov 2021 08:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8016A61267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB1513C70EA
	for <ltp@archiver.kernel.org>; Thu, 11 Nov 2021 09:48:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42DB93C0937
 for <ltp@lists.linux.it>; Thu, 11 Nov 2021 09:48:25 +0100 (CET)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0134710008F0
 for <ltp@lists.linux.it>; Thu, 11 Nov 2021 09:48:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1636620504; x=1668156504;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=TVpgv+/ZLBcJ3G1ZDfqttQ0B9PMQVwwZt1JJGNnwPZQ=;
 b=DLwGMWWqSZEBpDyBRivKFZbf7w0I4iFeIsDsbaT0yd10d/iCUfyOZozV
 pHaY+YheBlWo0H995ENmNLTlWeMr1X8RD6JVuBpnP76hws6UFacWbF0UH
 yl9Gl3KCv3x/tOJIVlu6B5JNGM+YVCrZk/+CRbV7OvJ2Ow4hdaTQTZCDV
 6tPIkDtY+dXbXALu762uZftBWyT3sRnLb7oK434SdJaJTW401k7zR9Nhp
 EKCYn/SryIjsdN+dykg8Xo6UtqM9FNJBkZmog6sJf3TZMOSf+B8TW4SCl
 9AsO6EIp2jUv6AIGntJm3qYz6eQ05Ab3YPa9whtpbm+gsnBTSCPMNJnZ1 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="43646416"
X-IronPort-AV: E=Sophos;i="5.87,225,1631545200"; d="scan'208";a="43646416"
Received: from mail-os2jpn01lp2053.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.53])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2021 17:48:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4EzSEAVBn8Lbud4tQvBidHjnabbRBgXn8GMoS/oybEYeWNQPdnvGCdHrLb9o6hhr4HvnvqufWDMmI3JvAIGFuHME0aCeNHfoaBCQ/FJ0G62TrdDkNlnZqToEh+jN44VUxTiOMU6V1HscfXMg14TZZhLYC0VjmP01wig5zhDBBxMV7Ds/sUCiwAgGRxqaY4RZaOgEzEUJSIp9nlynVoOgouBTxlLaXWijxGy6XMA+htofHckD52wLeC5rARFZpMhXQOq2EQfmC3AY5zXDeSR5DLHXjTSWh30yNw+ZQM3AScLaC755pMmy7DvuFYpnv+wmZZFiZY+pH5DSgBZUQOjlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVpgv+/ZLBcJ3G1ZDfqttQ0B9PMQVwwZt1JJGNnwPZQ=;
 b=Y7WIKgG+dfdeQWOXKl1ceWuDEUyYuYa/HDQpU4cK8TWzza8a4ImA+veB1EISihtxAQ0ch/QGiU7V5lI8/sgofo/uWMR6unNBfZ7OfQhasXMv2axWGIZkLzKLn5xnb6yDUldB8U2dAU2sASjVcsWdAA2aTloUAfwm76dyLmXzdid9q4A0erOV1h2t8P64/nXW3cTG+8JtMSvld6UpPgJvcWpsiT16sBCo+82a75YOYE7Rj8rD1YPIQ2iGjpdywgwJD59c4mPzYB43BobCoZw8TJfTmBZ7+StfCtGGYKnZeB47eSSE+b7cccjmQ9qmUf7MClKnKGwCQSaJLzRuNZ+qBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVpgv+/ZLBcJ3G1ZDfqttQ0B9PMQVwwZt1JJGNnwPZQ=;
 b=n+hnV4mtUA8oDZB5D0MlYC1PG7KpDYS0ua3eNkNB6/AqAFd4m1hYyyQ95Ex5lS6QDsMslbFGedEWHGZOoi0Q7XcCLpGZ7RVgJl6Ha5Rl05jKD/NP8a6qpi2SIezyq9LMNpC8fodXtOS+jT6N8/6T4jOvJ3WVv6gNhOWpPjdh/ZM=
Received: from OS3PR01MB6535.jpnprd01.prod.outlook.com (2603:1096:604:100::7)
 by OSAPR01MB4243.jpnprd01.prod.outlook.com (2603:1096:604:57::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Thu, 11 Nov
 2021 08:48:19 +0000
Received: from OS3PR01MB6535.jpnprd01.prod.outlook.com
 ([fe80::5850:1d20:8712:7420]) by OS3PR01MB6535.jpnprd01.prod.outlook.com
 ([fe80::5850:1d20:8712:7420%9]) with mapi id 15.20.4690.018; Thu, 11 Nov 2021
 08:48:19 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v3 07/12] syscalls/quotactl08: Test quoatctl01 but
 quota info hidden in filesystem
Thread-Index: AQHX1Vg3dfDuHy+Qo02F3BC7tGnWIqv89noAgAEQvoA=
Date: Thu, 11 Nov 2021 08:48:19 +0000
Message-ID: <618CD8F5.4070408@fujitsu.com>
References: <1636455285-8372-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1636455285-8372-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YYv0Kn16GGGgJpIn@yuki>
In-Reply-To: <YYv0Kn16GGGgJpIn@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7e8ed98-e3f7-4544-6cbf-08d9a4f002f0
x-ms-traffictypediagnostic: OSAPR01MB4243:
x-microsoft-antispam-prvs: <OSAPR01MB424395161F63A2DC229248ECFD949@OSAPR01MB4243.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qBHgjxyL91tXPJ5s+Ww2/zPc4fh1mIDJj4SvrWdNzvfkElAF3KIVI71aDTu5/YErdjs2YqBfXPwbAzQVEamRwT+G7Ym2zxk2JOGLCQDjqfjycNAMkz0em9Slj5qSEPpocOqLMvPNk1cr7Q7Acq4mRGwWjD2yOHrP75nBOG6KOZsVVg1Zs/vHsAP271GTkDkQMWnqf/XYTawxLJ8LZwWy/UZ/fFuy3tU920ixr/2SdtDGQy6hoMaD8EUC+5jjoFJb6O2TUKTDrvwWLo8mZtjITk6gtdxHiLapOKI0gdJPK8rlvfzi20/hFEwHak0nT5AKalvsG8+BPzgShprqSL14MLtzcTESrrncTmE5Xytp8E9TflZCLwJ52zAoe6NNugb+M2N+mpGSCTCDGFK99870TQw0bgfxG+h62ITqgpeDz2tqsWVmTnx/j6lPHD3voEQvxY8LoVuruldCi2feKu5x6nJtuHiUhRkKNZTNlJ2qG42VN5CQXTz+/MXsN9DZuSe9Q87rhlF0fWN8TFBnR2sadh4Nfgl4u0nJ8kARlm+viP4aen8NPHfcD6/smSDr3aAN7riWL+rxq8hWxqAaeLvd6QWkzl7fJ7/+KwDFbZlRUt+zWtY6klXKbkQWjrC6XAe98sjCUk68fTRfx2NkYjXGx+tazNIIA+r9mQiY6w0xDPF8kqMLftTPvW2esiEaoALd0wcCi05IuhamxNFYSmO50A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6535.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(6506007)(76116006)(122000001)(2616005)(91956017)(66556008)(66476007)(26005)(36756003)(8676002)(66946007)(66446008)(64756008)(5660300002)(8936002)(85182001)(6916009)(316002)(508600001)(15650500001)(71200400001)(87266011)(82960400001)(83380400001)(2906002)(6486002)(33656002)(86362001)(4326008)(186003)(38100700002)(6512007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ak1jbzBuTHBtWkNOVDFUNm5FTEI3R1MyTWtlVXk3bkc5RkFnSzYxQ2k0VUlY?=
 =?gb2312?B?amoybDB4TXI5MUtBd3YyenVOS1JQYmZiOGljUTRYMVVESTh5ZDFrT3hNR0tv?=
 =?gb2312?B?b3JhUFMyUXgrZWNxVnU5T3VnUW1IOElBZy9zYXp2QTEyamRiMElwRVcxd2Uw?=
 =?gb2312?B?MElQRWVTcTZmUUQrNWtIcFNYU0JpaXJBaHRRbFJaODgwa0JDNW9DM0IzODlK?=
 =?gb2312?B?TFB6MkoyRHF2REpUbTRXK3kxNnV2UFd4UHVVZFF0NmR4M3dmMGVqL3hZQlB0?=
 =?gb2312?B?V2ZWQWxiejJ5bmkrelpSOUpQZzF1VWp4d1JjWkExemh6anJYMVNTblpIMWkr?=
 =?gb2312?B?MitkcjQwUFZVeThPSGV0NWZSSXlITFlKeVFpdGIvaTdpNWNMblFOOWNPVktI?=
 =?gb2312?B?RE5pbVBabWxHcjJIdFdaNWF6b2R5UUVkcWJ2NlgyejFiS291cTJYWHpRdWtD?=
 =?gb2312?B?Ym9GU0VtRmhoQnZNaG52bnBpOElaU2NSS0dwbXJlekQvQlJwUUdremVHM3BJ?=
 =?gb2312?B?VDFnYUV5NEV2NUJFVm5nNGZoTXdjNVhTOFNwSUNhcmVjTFFTWTEzYUVyNjdL?=
 =?gb2312?B?Q05lUnhLYXp1dzJIakh5anU0YjluWEtybk1xUzZUTWRZSFljdHZWa3VuZmVE?=
 =?gb2312?B?ZUNndGlZbSszNWhQSEpXSWNJU0JTT3Y1UjhHOUJ0SVFSWnQxcGs5cTFZc25X?=
 =?gb2312?B?MDlNNnVkQ0VzNGlaNnM2UWpXUlRDMnNMS0puTHdxK2Z1aXFkRzIzQjJHaW1l?=
 =?gb2312?B?bzVveEx0MVZEbU03M0FSV3J0T0hnSVVWQ3dXV1BEZG9MY0ZJZ2tqdjBDaklK?=
 =?gb2312?B?TEg1dUM2Z0xaTjY1SEozcE0rdURielhnbDJ3dnNTYUdQdnVWemNnWnV6K1M1?=
 =?gb2312?B?QUJlRkxaTStkV3NySnEreEQ2cUVydHhwN1NYbnkza0JqZmVwYjFLWUZ5RjlB?=
 =?gb2312?B?cVpYZG5Yem9hZDNzcXR3bTRSdmVJZWhqOEFuZUxFWFVGc3RtdjQvbEFPT3lu?=
 =?gb2312?B?L29DT0p3WXFwSThFUXc5STRyQUVPWmdNelVBUUVxOHJXSExJUjE4bE81ZmJi?=
 =?gb2312?B?cEorYjJIYlJCN05TRzh1VlEwZWtYSHBpMklrR29kRENmZFFRUHZMVy93eUFM?=
 =?gb2312?B?ZG1lRDFMZCtXLzZlRDd0SGJoeGE5N0lyOWFOZ1lmUDZXbG5TZy9RYklwc2hq?=
 =?gb2312?B?dmJiQlZndWc1MHJlRXJ6SEcxeUJDcVFiVXFFdXlSNDNuWGpmeCtNUnRZZE9G?=
 =?gb2312?B?NGl6bVphNUNxRlVqTXVSdkVKaDY3Z2ovQ1U1QzdMQU5JeE9vSHgzaDJQVXJr?=
 =?gb2312?B?RXNLWCt4dHlQVzMvVzRTY1Z0VHN6c1NydlU2blZRd01PSW5Kd1ZaaHFxVGs3?=
 =?gb2312?B?aEQrZ3RtOVRQenhadjRieVRXY2NES1FRb1JVVkhxR1I0L05HK3d5UzdHMUxz?=
 =?gb2312?B?TTFWTlFOVWxIUWJZRGEzbzRIWngxQ1FLd2g2NUpWSGZjWDFQVmYzc21aN25i?=
 =?gb2312?B?azBUeW1mWkEvRmJ0dnZJa2g5WTgwdkVIRXZxNEt1TFpJM0VKclhWNHNLRVZp?=
 =?gb2312?B?anJuK3R3bHVYdjVYUExpOWlOZUJXRUJwb29NWkJwWEF6QVRUVm4vVmJzR2dK?=
 =?gb2312?B?bUpBelFpdk1zZytXWW5hdlhMaDFzRXVNNElGN25qWUlCKzVQcVExYkx1UGxr?=
 =?gb2312?B?bm1zalpOQ1pIU2kvaXJFMHpjNmJ6QlM3UXhhcU9INGlCOFkxOWpBY1ZXMSty?=
 =?gb2312?B?MGZEb2dNSEtWS2JEa1p4YlBlYjZ0ZE9YZUxaUWlkN0JCYlNoL1plZVg3aENE?=
 =?gb2312?B?VW5LQUQ2L3RXU2U1U0RxdE1ZbEx2OXRhVThzUUdoSWNxQmZVd2x5MUw0U1Ay?=
 =?gb2312?B?cXNWbytJRVJxN0R5WFRMVFByZ3VwTmhScjEwcy9qLzRuNE5oTzFUU0VuMlky?=
 =?gb2312?B?dE1ncTFxNGNSODhrME5HakF5eWhrd29iOW8wS05iUklBNWFrVnZFd2UwdEFx?=
 =?gb2312?B?VDBIK0dLdC8xV3h0aHZRODZ0V3JCYU1lV2VBbHI2Z1dxQVhvbUc1Q1BHZnFk?=
 =?gb2312?B?Q0lLSExQbnl1SjRDMXk5b29mZWRYZFZETUVIQnZCaDFtM0FuNysvK3RDR0VZ?=
 =?gb2312?B?SFBIVW9VVWxob3NvdDl6QkZLZTZtQVFTUlc2N0EyRkZxMWlkcWpLWXJjbXBu?=
 =?gb2312?B?SzJ6RTZ3cDV4UTZsanY4WEt0RWszdGRKQUxiQ1p1MVQ1aTFnaE93TEcvZGpr?=
 =?gb2312?Q?ecuvJWM9CGRVmgVzUS+kNKNlEUI2e1I9Sv6WTCggv8=3D?=
Content-ID: <01336FF1616DFB47B09D7F12979F3E01@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6535.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e8ed98-e3f7-4544-6cbf-08d9a4f002f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2021 08:48:19.6768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZAMZLYPhOhDgkoVXxrKQNFau7bWlBFXLG15Wyb3W184sv3oJNlSRd8+70GAnYktotGqe3FHJtvxfYA2s6ylIO53bEwJPHfTUcOXcNTA3xag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4243
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 07/12] syscalls/quotactl08: Test quoatctl01 but
 quota info hidden in filesystem
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

Hi Cyril
> Hi!
>> +	f = SAFE_POPEN("mkfs.ext4 -V 2>&1", "r");
>> +	rc = fscanf(f, "mke2fs %d.%d.%d",&major,&minor,&patch);
>> +	if (rc != 3)
>> +		tst_res(TWARN, "Unable parse version number");
>> +	else if (major * 10000 + minor * 100 + patch<  14300)
>> +		tst_brk(TCONF, "Test needs mkfs.ext4>= 1.43 for quota option, test skipped");
>> +	pclose(f);
>
> Ideally this should be added to the .needs_cmds instead so that we get
> the minimal version in the test metadata too.
Good suggestion, I am looking your code. But As my commit log said,  add 
a lib mkfs.ext4 version check after this quotactl patchset are merged.

Then we can add this version check and make use it for not only 
quotactl04,08,09 case but also for statx05.c.

Best Regards
Yang Xu
>
> I wonder how this should be done.
>
> One possibility would be adding support for version in the needs_cmds
> strings as:
>
> "mkfs.ext4>= 1.43"
>
> Then we would have to add a table of version checks to the library as
> well so that we could lookup a function based on the command name.
>
> Something as:
>
> static long mkfs_ext4_version_parser(void)
> {
> 	f = SAFE_POPEN("mkfs.ext4 -V 2>&1", "r");
> 	rc = fscanf(f, "mke2fs %d.%d.%d",&major,&minor,&patch);
> 	pclose(f);
> 	if (rc != 3) {
> 		tst_res(TWARN, "Unable to parse mkfs.ext4 version");
> 		return -1;
> 	}
>
> 	return major * 10000 * minor * 100 + patch;
> }
>
> static struct version_parser {
> 	const char *name,
> 	long (*parser)(void);
> } version_parsers[] = {
> 	{.cmd = "mkfs.ext4", .parser = mkfs_ext4_version_parser},
> 	{},
> };
>
> Then the library would do:
>
> 	struct version_parser *p;
> 	size_t cmd_len;
> 	long version;
> 	char *str, *version;
>
> 	str = strchr(cmd, ' ');
> 	if (!str)
> 		return;
>
> 	version = strchr(str, ' ');
> 	if (!version)
> 		tst_brk(TBROK, "Missing version in %s", cmd);
>
> 	//TODO: check that the string between str and version is a
> 	//correct operator
>
> 	cmd_len = str - cmd;
>
> 	for (p = *version_parsers; *p; p++) {
> 		if (strlen(p->name) != cmd_len)
> 			continue;
>
> 		if (!strncmp(p->name, cmd, cmd_len))
> 			break;
> 	}
>
> 	if (!p->name)
> 		tst_brk(TBROK, "No version parser for %s implemented!");
>
> 	long ver = p->parser();
> 	if (ver<  0)
> 		tst_brk(TBROK, "Failed to parse %s version", p->name);
>
> 	/* now we have to parse the version from the version variable
> 	 * and compare it with the ver variable */
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
