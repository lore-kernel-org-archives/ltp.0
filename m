Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C2CC433EF
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 03:31:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 513063C1DB8
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 04:31:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BC1F3C0938
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 04:30:57 +0100 (CET)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B165C600825
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 04:30:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1638761457; x=1670297457;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=tH4RbyYAxRn+zgl+LO2u9F9Pkdafn9FgOObXzMBUROw=;
 b=njQUZmH/vSWT70S9JDHenxcfvH6TiVU38x+HCvL5vYqdrNeelnJR6ILb
 K6+FzCskyZQl3ZrmpbXdxRIzj9MTp/Y4O0nlQ3sFK+p1rEM4PWjj8Enx7
 +65lKNEJjKCjN9BLqBADaODlH5fvOX2ShJNYEaA6Z5dQRbEFMSyNf1l2k
 1zEsmAGBKGtnaVu8VlosSO0KAs/spFroFIF5LEPBfroUIVpJfON5Uih/L
 NxVt8Dh1c2kL2Gpvy6Cip7zFsxP3nlF7nr6Ib4994ar36I17p+s3MZfAc
 BB2vP7FMYg7SfIEwM08eVdn6gP+DcWmNXSHB/9cI39cyQXyGFRngzvTOC w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="44924564"
X-IronPort-AV: E=Sophos;i="5.87,290,1631545200"; d="scan'208";a="44924564"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2021 12:30:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtGxB8UvJH6n4rZ3ACo4nc/oagpdeqg3glQ0UdbYdnymnyQpaSbTrIC4M0gQzdxR9YqfexiVl37yCLGlxZGjeDt5CQMelM3unThctdWus/u1s2SXOp2ZIC3VEI4L7TGJLox0HUMb0gkhY5sGhVDOiH4H9u21JfDWsYMUQ2NlD/hOSS0j5nboh5ufhBLywV9lt36vYFwi0XWfe7D1ly7TwVVBRBc1X8NNBBOgvNY80tq1vhiEkPyKllJ8bHqJ4X+cbcYSz1TjG8/rRgi1o5n2vuDcVG+tg2QT9WPbOX8RlNgTkslUST9vaHXrpSan9EVp1+dnNBsXaCzON1z6U8D2tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tH4RbyYAxRn+zgl+LO2u9F9Pkdafn9FgOObXzMBUROw=;
 b=SxaZbIZtxpKeEHym0sqL6JxsI6p4EXgdb+2Kd8tNb+m5f1xfL23Atc8ky7M/UUx0nzWGaiWHnT9mjD76IMFKEeh/QO90lQ1ZhNE9Qd/gt1QnJZltbd+7/W8NdxstK+yOV52+Kam8Bwncue2+NYmCz9OQIfcsWTcT+U43G9xPKK6ebdVR4CcCwdfGNmB/0Lgv9P+JFotu74YZvIHliGBgKyIRrTLGOARkwzeVmt3D2dNcHwhtJe3Xj1VZWpLEkZmDFIomU6sqstl/NLxvDG68lyTcxOG1Lwch5BfSnJ+AjODIv0pPWn81wlqZAcbY4hPBdjkXmUklVlNNipMeuoFZdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH4RbyYAxRn+zgl+LO2u9F9Pkdafn9FgOObXzMBUROw=;
 b=D9CdFWfrgwJlSOVXE0xSCfJ7DX9Wv5lqXJQ/Sw/vgxlkiUrqWpqR1+ex2A3AHiSakNP9oqiXWhTcmas2SVvw9/xu7SJJ2fBNFenmRNUASYNbpNmJZnig8gCODIXYPhbKdYoWJ30wEFVmF5UFtJbm+WhEBJckOzs+YIB0s/zO6+4=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Mon, 6 Dec
 2021 03:30:50 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 03:30:50 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: wenyehai <wenyehai@huawei.com>
Thread-Topic: [LTP][PATCH v3] remove duplicate header files fcntl.h
Thread-Index: AQHX6k7AQP/jImtPpEqvTH/A6al4qKwkztoA
Date: Mon, 6 Dec 2021 03:30:49 +0000
Message-ID: <61AD8408.7080500@fujitsu.com>
References: <1638760256-150779-1-git-send-email-wenyehai@huawei.com>
In-Reply-To: <1638760256-150779-1-git-send-email-wenyehai@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95a094c5-c012-4a5c-1e5c-08d9b868ccb5
x-ms-traffictypediagnostic: TYCPR01MB6544:
x-microsoft-antispam-prvs: <TYCPR01MB65448316605235AF1922621BFD6D9@TYCPR01MB6544.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 42sDI+WuuavRThp5mvn8qCpbUQodaAbj82WkwIphHPkcRHjbKnKudpHZ3ddQx3iD1yVAw5VKy+8g09aMOlxCDGeff5MXI52ShTgCrWwc9DkFXq3zNhMJnb5Lt/HfojqQ7AhO/katQYyDYB+gkm9YvsPnE2f62HqvHU+m2WbWLMwRieRe0JyYKy+wBfEgdPkW2nVQyKeH03DiOG1Y3lvx8fnULlhdA5pk0lUkqyqIRkgIx79A/efa+bvPG4fi+LZBJ2fKDgOnTNtVPWjRNwA2iT6cAv/46urI2HsUyn74C2mjqWN0faCeBjAXV4FAk3d5f11K4rnskt0VmU1DVeWcvuB+fXxl5RU6vOqPI4vTeKWcZYnFzmknU3J5VN21+2PbVdcV/Acoqvi+Ah0gLGMoCAR6aJBfLZU/QfqKK7mgyip09DeIBwfFm7p67A4zgnWzkwmmz03teEzQJYZNmjvh6UFqGwXhEZ1hZ0fWDrIEf2Y2nZz3L1y1ZDZs1cODOwBiWSzJ2uhTQyE6ZwMJTm3vgK6/Eq18unmJk8E28BYBXOV0yMrGtZ1Q9a95VQ5jr83BE6fkN9ln+iAKKssvvyZf7LSRIskaEaROV0bTBjPalo1bIMTHD1QesL1xwGar7t8waHfXFHyQKIjB1CVHmlb9NpbrDhWQBdzjASTc6U8YmSGvdEhloJkcyLKSmBWxPQ4WBZEQhm4BSijeFdb951JfDA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(316002)(508600001)(5660300002)(87266011)(38070700005)(8936002)(4326008)(86362001)(6916009)(82960400001)(38100700002)(122000001)(71200400001)(30864003)(33656002)(6486002)(66476007)(66446008)(2616005)(64756008)(85182001)(8676002)(6506007)(26005)(2906002)(36756003)(186003)(66556008)(91956017)(76116006)(66946007)(6512007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dVZBWE00ZGFyS2JmUTIwYXdJZmRCQ0tvSEp2V0FUdXVuNGhVcWpJV1UxTi9w?=
 =?gb2312?B?UVE0UXBkMDVBaVlxdG5JWHRXQ3B6V0xZZHhqZnk1S0s2d3RsOWVlNk5yMkhN?=
 =?gb2312?B?UC9PSVFndzlRQzVyRGkzZHcyQzVsTkpmRndpL0k1M1pHOE9zL2p5am9DTC82?=
 =?gb2312?B?RlNJN096VE5SMm1LeDV0ajROdFpKbmpIRlJqclN3dXo3b2RJNzlpSUVjZEs4?=
 =?gb2312?B?ZGhjV1JYYmFaVFNaa1VCZDJzT1Z0MDltSFVteWlNL3ZEZnRza28zT0ZwSStB?=
 =?gb2312?B?UXFYMTltZGRLdmRiZFgxak82ODR2RjM0cm9hWXg5dDJtajdmOTE4R3p0V3Fu?=
 =?gb2312?B?YlpXck9CajNxdWMraGtEdUtGR2haT2owWkxzTC9Talo0d2ZXVCt6QUFVNUZj?=
 =?gb2312?B?WnNWQk9IK0FCK2FkYTVaTEsrOXVjbWYvU1FxVDdwR0dJSzBaSHRpbnZ5UmJy?=
 =?gb2312?B?cTFwM1lOVFZxMlJjNTFWQXFnekRZZVRyRWZuclpSSHdMaFQ1VitHRFRPeGJ4?=
 =?gb2312?B?OStkd1ErQWlmL3VuM2FMNXcwaVAxYjkyQ2Q3eSs3NHp4RytTeVArYS9VcjRx?=
 =?gb2312?B?NHBqQW5BY1JYWmRsSjA4WlV3ZDFyU08rTzU1blJmeFMzWWVCczRVMDd4Y3FI?=
 =?gb2312?B?UzlrM1M0TFhxMGtSa0RtT0E1LzJGMEJ2cmEvMngxK0FmenhpdGUvcC9JRmUw?=
 =?gb2312?B?OTh5TE16QkYvWlRsd1lQbVRxeTFaYVRrbElMSzBpcHpTZXAzSStBMGhWNUtN?=
 =?gb2312?B?R1JmVHN4TVVYNWZaazR4ZUtoTHNHRERkemM3YW5TSjVYaWJsMVo1MFhLVHJy?=
 =?gb2312?B?K2U4TXJrOWFFR0k3UUJhbmZOR0JnOWRnWEx2Wld6ZWRWbndKa3A1dmhxVzFI?=
 =?gb2312?B?UUVSdGFuOHpmWmhoV3hvYWU0NDRGYVMzdXNFR0hBa29OMUZoWFIrVEpjanl0?=
 =?gb2312?B?NVBBQUh0ZFdjaEpaZkpSUUtMdENiQ21JdVZPdmpUSmVEaXJuTkFZTVl1TzhO?=
 =?gb2312?B?TnZOeTROU0NXbHFldC8ybDJwb0NLMTdIRnZIVjVqZnEzdXErcVl5RUNDNGVO?=
 =?gb2312?B?cTRTZDRscUFsT1FJSERaZWVqUy9BbzRlejdKVVhFRk9Rcy9lNFFXL2ZjNXdQ?=
 =?gb2312?B?YUhuc0ZaV0wrc28rRWxuLzhVQ0FoWDB5QTcvekRoRHY3RnU3V0h2WEFZYmhP?=
 =?gb2312?B?Q09hRnlRRVZzUVUydFF2UzhqcVozT29NTFNKdXBERDRMeDN4L28zRHVFMlg1?=
 =?gb2312?B?YlVFSzFrZS95VE5LRm51VjB1V3FBWElEcmlYdEFIS1JsR1VnTTltaHl2Qy9T?=
 =?gb2312?B?V25lSkMyOXJJeTM0amhsREJ3Z2JSTm56d3JrN04wU09QVU03UFFiOHFyY1U5?=
 =?gb2312?B?UEs5S3B5V1NPUEsvUFVhMldSZGppaXNVL3RHNjRucTR2SVBTY2orVzIySTVN?=
 =?gb2312?B?SmNjSkhmSFc4SVVTL0NzMUs1M0JVQ0kvMG5XL2k3bHk3WjBuYmZJbWxkUlNa?=
 =?gb2312?B?OHI4L0JMVDlZL0w4NDBEUFVqUWpVMHF1YTdtTW5PZU11b1l5UTlLUFV5YURv?=
 =?gb2312?B?eE1nZXkvSUh3emZibXU1bHltMkJDMmVPUWdLTlRQZVFJaGZvTU0rdXlISUdV?=
 =?gb2312?B?TWFtY2JnUnlXVXF0clBRSjA4b2wzZjczOUI0ekg5RndveFdLaExVaTN5V3c0?=
 =?gb2312?B?M3JIZFZSZENxQ0sraG5BZlBINllMYlZoWVV1eU1SNk96d1ZjVytmRmkrR2s0?=
 =?gb2312?B?eVh2WFovZlh2N3lNaEdQdXpScDdQUWF3RFk4ZngrZVhSdVRLNWFaNGNRQ25l?=
 =?gb2312?B?d2lBVmIrWGpZVXdkVzFMUmdIdVdyUmVhWldNM29kR1RVKzBJRzUwUWNoSis3?=
 =?gb2312?B?Rkd5azJsTUJLUFlWclRPQ3hVRlU3VjdVNUlqMElWYWxaTk05dzRIN2NSWEM2?=
 =?gb2312?B?eTVmcGlqMFRaTktyb2FmREZjR1BheW5hYkRldVIrLzEyeVdXeXlZRGp3Kzhj?=
 =?gb2312?B?UERqZGdaRmVNWmRMMGZkeGIvRTE2Uy8rZ0Vtc3dNZjRITkVmUEx6L1hydWNH?=
 =?gb2312?B?N2NNcU1nNWJ2REQvdFRzQTZtVnQ0dTM3ZXA5N1dkM0RWbjBDVC9uQXNDNlBw?=
 =?gb2312?B?VitCTVJ6N1lpVnB0ZURTa2NVWitiMytyZTd5cjNPZW1aaEF2TW1SRjVqQk5s?=
 =?gb2312?B?ZnZEN2U1K3RQajZwMnpJeFE4WVVXZEZSUWhHcU9zUndGOTVXaE9zbnV0NjNX?=
 =?gb2312?Q?P0s31/rDFYo5hv2iHbLhukay9tevZQUJ+Ur0pV+IRo=3D?=
Content-ID: <0B7A37926433644EA57FB1DBBEC4414F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a094c5-c012-4a5c-1e5c-08d9b868ccb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 03:30:49.9181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cShIYjy7Czd0KMd08lC6MAv8P01ZvF94nMvU7zdAu8XnSsRFB91Ko86je2bP7Qeyg6mtL5z4+eLbG9J8ILUGmNi9VxuNjyDN8JXMe2RS22k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6544
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] remove duplicate header files fcntl.h
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

Hi Wen

Thanks, merged!

Best Regards
Yang Xu
> testcases: remove duplicate header files fcntl.h
> 
> Signed-off-by: Yehai Wen<wenyehai@huawei.com>
> ---
> v2->v3: re-make patch to solve patching failure
>   testcases/kernel/syscalls/accept4/accept4_01.c            | 1 -
>   testcases/kernel/syscalls/eventfd2/eventfd2_01.c          | 1 -
>   testcases/kernel/syscalls/eventfd2/eventfd2_02.c          | 1 -
>   testcases/kernel/syscalls/execveat/execveat03.c           | 1 -
>   testcases/kernel/syscalls/fallocate/fallocate01.c         | 1 -
>   testcases/kernel/syscalls/fchownat/fchownat01.c           | 1 -
>   testcases/kernel/syscalls/fchownat/fchownat02.c           | 1 -
>   testcases/kernel/syscalls/fcntl/fcntl29.c                 | 1 -
>   testcases/kernel/syscalls/fcntl/fcntl30.c                 | 1 -
>   testcases/kernel/syscalls/fcntl/fcntl31.c                 | 1 -
>   testcases/kernel/syscalls/fcntl/fcntl34.c                 | 1 -
>   testcases/kernel/syscalls/fcntl/fcntl35.c                 | 1 -
>   testcases/kernel/syscalls/fcntl/fcntl36.c                 | 1 -
>   testcases/kernel/syscalls/fcntl/fcntl37.c                 | 1 -
>   testcases/kernel/syscalls/fcntl/fcntl38.c                 | 1 -
>   testcases/kernel/syscalls/inotify_init/inotify_init1_01.c | 1 -
>   testcases/kernel/syscalls/inotify_init/inotify_init1_02.c | 1 -
>   testcases/kernel/syscalls/linkat/linkat02.c               | 1 -
>   testcases/kernel/syscalls/mknodat/mknodat01.c             | 1 -
>   testcases/kernel/syscalls/mknodat/mknodat02.c             | 1 -
>   testcases/kernel/syscalls/open/open14.c                   | 1 -
>   testcases/kernel/syscalls/openat/openat01.c               | 1 -
>   testcases/kernel/syscalls/openat/openat02.c               | 1 -
>   testcases/kernel/syscalls/openat/openat03.c               | 1 -
>   testcases/kernel/syscalls/pipe/pipe12.c                   | 1 -
>   testcases/kernel/syscalls/pipe2/pipe2_04.c                | 1 -
>   testcases/kernel/syscalls/renameat/renameat01.c           | 1 -
>   testcases/kernel/syscalls/signalfd4/signalfd4_01.c        | 1 -
>   testcases/kernel/syscalls/socket/socket02.c               | 1 -
>   testcases/kernel/syscalls/socketpair/socketpair02.c       | 1 -
>   testcases/kernel/syscalls/tee/tee01.c                     | 1 -
>   testcases/kernel/syscalls/timerfd/timerfd02.c             | 1 -
>   testcases/kernel/syscalls/timerfd/timerfd03.c             | 1 -
>   testcases/kernel/syscalls/vmsplice/vmsplice01.c           | 1 -
>   testcases/kernel/syscalls/vmsplice/vmsplice02.c           | 2 --
>   35 files changed, 36 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/accept4/accept4_01.c b/testcases/kernel/syscalls/accept4/accept4_01.c
> index b3ab1b94e..58115ea43 100644
> --- a/testcases/kernel/syscalls/accept4/accept4_01.c
> +++ b/testcases/kernel/syscalls/accept4/accept4_01.c
> @@ -13,7 +13,6 @@
>   #include<sys/socket.h>
>   #include<netinet/in.h>
>   #include<stdlib.h>
> -#include<fcntl.h>
>   #include<stdio.h>
>   #include<string.h>
>   #include<errno.h>
> diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
> index a4af38858..c0c6a263c 100644
> --- a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
> +++ b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
> @@ -53,7 +53,6 @@
>   /*              Ported to LTP                                                 */
>   /*                      - Jan 08 2009 - Subrata<subrata@linux.vnet.ibm.com>   */
>   /******************************************************************************/
> -#include<fcntl.h>
>   #include<stdio.h>
>   #include<unistd.h>
>   #include<sys/syscall.h>
> diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
> index 151edb841..418c07c45 100644
> --- a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
> +++ b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
> @@ -50,7 +50,6 @@
>   /*              Ported to LTP                                                 */
>   /*                      - Jan 13 2009 - Subrata<subrata@linux.vnet.ibm.com>   */
>   /******************************************************************************/
> -#include<fcntl.h>
>   #include<stdio.h>
>   #include<unistd.h>
>   #include<sys/syscall.h>
> diff --git a/testcases/kernel/syscalls/execveat/execveat03.c b/testcases/kernel/syscalls/execveat/execveat03.c
> index 78b26ab56..1900c076b 100644
> --- a/testcases/kernel/syscalls/execveat/execveat03.c
> +++ b/testcases/kernel/syscalls/execveat/execveat03.c
> @@ -29,7 +29,6 @@
>   #include<string.h>
>   #include<sys/syscall.h>
>   #include<sys/mount.h>
> -#include<fcntl.h>
>   #include "tst_test.h"
>   #include "lapi/execveat.h"
>   #include "lapi/fcntl.h"
> diff --git a/testcases/kernel/syscalls/fallocate/fallocate01.c b/testcases/kernel/syscalls/fallocate/fallocate01.c
> index c60e160f4..383796c90 100644
> --- a/testcases/kernel/syscalls/fallocate/fallocate01.c
> +++ b/testcases/kernel/syscalls/fallocate/fallocate01.c
> @@ -93,7 +93,6 @@
>   #include<errno.h>
>   #include<sys/stat.h>
>   #include<sys/types.h>
> -#include<fcntl.h>
>   #include<sys/syscall.h>
>   #include<unistd.h>
>   #include<inttypes.h>
> diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
> index 9f4ecded7..a658f07db 100644
> --- a/testcases/kernel/syscalls/fchownat/fchownat01.c
> +++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
> @@ -26,7 +26,6 @@
> 
>   #include<sys/types.h>
>   #include<sys/stat.h>
> -#include<fcntl.h>
>   #include<unistd.h>
>   #include<stdlib.h>
>   #include<errno.h>
> diff --git a/testcases/kernel/syscalls/fchownat/fchownat02.c b/testcases/kernel/syscalls/fchownat/fchownat02.c
> index d19f3f3b8..701623dd7 100644
> --- a/testcases/kernel/syscalls/fchownat/fchownat02.c
> +++ b/testcases/kernel/syscalls/fchownat/fchownat02.c
> @@ -24,7 +24,6 @@
> 
>   #include<sys/types.h>
>   #include<sys/stat.h>
> -#include<fcntl.h>
>   #include<unistd.h>
>   #include<stdlib.h>
>   #include<errno.h>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl29.c b/testcases/kernel/syscalls/fcntl/fcntl29.c
> index ffb9fea74..587476454 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl29.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl29.c
> @@ -24,7 +24,6 @@
>   #include<stdio.h>
>   #include<errno.h>
>   #include<unistd.h>
> -#include<fcntl.h>
>   #include<string.h>
>   #include<signal.h>
>   #include<sys/types.h>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl30.c b/testcases/kernel/syscalls/fcntl/fcntl30.c
> index a7a5e136c..27f464389 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl30.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl30.c
> @@ -25,7 +25,6 @@
>   #include<stdio.h>
>   #include<errno.h>
>   #include<unistd.h>
> -#include<fcntl.h>
>   #include<string.h>
>   #include<signal.h>
>   #include<sys/types.h>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl31.c b/testcases/kernel/syscalls/fcntl/fcntl31.c
> index fd284fd7e..900308980 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl31.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl31.c
> @@ -25,7 +25,6 @@
>   #include<stdio.h>
>   #include<errno.h>
>   #include<unistd.h>
> -#include<fcntl.h>
>   #include<string.h>
>   #include<signal.h>
>   #include<sys/types.h>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl34.c b/testcases/kernel/syscalls/fcntl/fcntl34.c
> index 3a68b51c8..3442114ff 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl34.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl34.c
> @@ -7,7 +7,6 @@
>   #include<sys/types.h>
>   #include<sys/stat.h>
>   #include<unistd.h>
> -#include<fcntl.h>
>   #include<pthread.h>
>   #include<sched.h>
> 
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl35.c b/testcases/kernel/syscalls/fcntl/fcntl35.c
> index c5a071def..8eb71486f 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl35.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl35.c
> @@ -26,7 +26,6 @@
>   #include<sys/types.h>
>   #include<pwd.h>
>   #include<unistd.h>
> -#include<fcntl.h>
>   #include<stdlib.h>
> 
>   #include "lapi/fcntl.h"
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl36.c b/testcases/kernel/syscalls/fcntl/fcntl36.c
> index 1d187c28b..d6b07fc41 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl36.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl36.c
> @@ -34,7 +34,6 @@
>   #include<unistd.h>
>   #include<stdio.h>
>   #include<stdlib.h>
> -#include<fcntl.h>
>   #include<pthread.h>
>   #include<sched.h>
>   #include<errno.h>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl37.c b/testcases/kernel/syscalls/fcntl/fcntl37.c
> index c52af22dd..a624554c5 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl37.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl37.c
> @@ -14,7 +14,6 @@
>    */
> 
>   #include<unistd.h>
> -#include<fcntl.h>
>   #include<sys/types.h>
>   #include<limits.h>
>   #include<stdlib.h>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl38.c b/testcases/kernel/syscalls/fcntl/fcntl38.c
> index fae2ab4f7..2f1b0229e 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl38.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl38.c
> @@ -8,7 +8,6 @@
>    *     Check that dnotify event is reported to both parent and subdir
>    */
> 
> -#include<fcntl.h>
>   #include<signal.h>
>   #include<stdio.h>
>   #include<unistd.h>
> diff --git a/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c b/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
> index f1203a495..f1b50fd4e 100644
> --- a/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
> +++ b/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
> @@ -53,7 +53,6 @@
>   /*              Ported to LTP                                                 */
>   /*                      - Jan 13 2009 - Subrata<subrata@linux.vnet.ibm.com>   */
>   /******************************************************************************/
> -#include<fcntl.h>
>   #include<stdio.h>
>   #include<unistd.h>
>   #include<sys/syscall.h>
> diff --git a/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c b/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
> index b074214f7..3b0c7678e 100644
> --- a/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
> +++ b/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
> @@ -50,7 +50,6 @@
>   /*              Ported to LTP                                                 */
>   /*                      - Jan 13 2009 - Subrata<subrata@linux.vnet.ibm.com>   */
>   /******************************************************************************/
> -#include<fcntl.h>
>   #include<stdio.h>
>   #include<unistd.h>
>   #include<sys/syscall.h>
> diff --git a/testcases/kernel/syscalls/linkat/linkat02.c b/testcases/kernel/syscalls/linkat/linkat02.c
> index 84b4a3ba0..566c76b1f 100644
> --- a/testcases/kernel/syscalls/linkat/linkat02.c
> +++ b/testcases/kernel/syscalls/linkat/linkat02.c
> @@ -21,7 +21,6 @@
> 
>   #include<sys/types.h>
>   #include<sys/stat.h>
> -#include<fcntl.h>
>   #include<unistd.h>
>   #include<stdlib.h>
>   #include<errno.h>
> diff --git a/testcases/kernel/syscalls/mknodat/mknodat01.c b/testcases/kernel/syscalls/mknodat/mknodat01.c
> index 2e13c7732..bff2c6a4e 100644
> --- a/testcases/kernel/syscalls/mknodat/mknodat01.c
> +++ b/testcases/kernel/syscalls/mknodat/mknodat01.c
> @@ -27,7 +27,6 @@
>   #define _GNU_SOURCE
> 
>   #include<sys/types.h>
> -#include<fcntl.h>
>   #include<sys/stat.h>
>   #include<stdlib.h>
>   #include<errno.h>
> diff --git a/testcases/kernel/syscalls/mknodat/mknodat02.c b/testcases/kernel/syscalls/mknodat/mknodat02.c
> index 6c5054bbc..7e6afda92 100644
> --- a/testcases/kernel/syscalls/mknodat/mknodat02.c
> +++ b/testcases/kernel/syscalls/mknodat/mknodat02.c
> @@ -27,7 +27,6 @@
>   #define _GNU_SOURCE
> 
>   #include<sys/types.h>
> -#include<fcntl.h>
>   #include<sys/stat.h>
>   #include<stdlib.h>
>   #include<errno.h>
> diff --git a/testcases/kernel/syscalls/open/open14.c b/testcases/kernel/syscalls/open/open14.c
> index 0d832cb59..f78a3643c 100644
> --- a/testcases/kernel/syscalls/open/open14.c
> +++ b/testcases/kernel/syscalls/open/open14.c
> @@ -22,7 +22,6 @@
>   #include<sys/types.h>
>   #include<sys/stat.h>
>   #include<unistd.h>
> -#include<fcntl.h>
>   #include<errno.h>
> 
>   #include "test.h"
> diff --git a/testcases/kernel/syscalls/openat/openat01.c b/testcases/kernel/syscalls/openat/openat01.c
> index 0441c3add..daed419fb 100644
> --- a/testcases/kernel/syscalls/openat/openat01.c
> +++ b/testcases/kernel/syscalls/openat/openat01.c
> @@ -28,7 +28,6 @@
> 
>   #include<sys/types.h>
>   #include<sys/stat.h>
> -#include<fcntl.h>
>   #include<stdlib.h>
>   #include<errno.h>
>   #include<string.h>
> diff --git a/testcases/kernel/syscalls/openat/openat02.c b/testcases/kernel/syscalls/openat/openat02.c
> index e2eefda04..2ce119033 100644
> --- a/testcases/kernel/syscalls/openat/openat02.c
> +++ b/testcases/kernel/syscalls/openat/openat02.c
> @@ -38,7 +38,6 @@
> 
>   #include<sys/types.h>
>   #include<sys/stat.h>
> -#include<fcntl.h>
>   #include<unistd.h>
>   #include<sys/wait.h>
>   #include<stdlib.h>
> diff --git a/testcases/kernel/syscalls/openat/openat03.c b/testcases/kernel/syscalls/openat/openat03.c
> index 7e816f26b..2846fd07f 100644
> --- a/testcases/kernel/syscalls/openat/openat03.c
> +++ b/testcases/kernel/syscalls/openat/openat03.c
> @@ -22,7 +22,6 @@
>   #include<sys/types.h>
>   #include<sys/stat.h>
>   #include<unistd.h>
> -#include<fcntl.h>
>   #include<errno.h>
> 
>   #include "test.h"
> diff --git a/testcases/kernel/syscalls/pipe/pipe12.c b/testcases/kernel/syscalls/pipe/pipe12.c
> index 4c7eda2d6..f5240401a 100644
> --- a/testcases/kernel/syscalls/pipe/pipe12.c
> +++ b/testcases/kernel/syscalls/pipe/pipe12.c
> @@ -11,7 +11,6 @@
>   #define _GNU_SOURCE
>   #include<unistd.h>
>   #include<stdlib.h>
> -#include<fcntl.h>
>   #include "tst_test.h"
>   #include "lapi/fcntl.h"
> 
> diff --git a/testcases/kernel/syscalls/pipe2/pipe2_04.c b/testcases/kernel/syscalls/pipe2/pipe2_04.c
> index 432007e4d..37894351f 100644
> --- a/testcases/kernel/syscalls/pipe2/pipe2_04.c
> +++ b/testcases/kernel/syscalls/pipe2/pipe2_04.c
> @@ -11,7 +11,6 @@
>   #define _GNU_SOURCE
>   #include<stdlib.h>
>   #include<features.h>
> -#include<fcntl.h>
>   #include<unistd.h>
>   #include<stdio.h>
>   #include "lapi/fcntl.h"
> diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
> index 817e21729..9df4b7086 100644
> --- a/testcases/kernel/syscalls/renameat/renameat01.c
> +++ b/testcases/kernel/syscalls/renameat/renameat01.c
> @@ -41,7 +41,6 @@
>   #include<sys/types.h>
>   #include<sys/stat.h>
>   #include<sys/time.h>
> -#include<fcntl.h>
>   #include<stdlib.h>
>   #include<errno.h>
>   #include<string.h>
> diff --git a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
> index 9f859735f..960c7ce98 100644
> --- a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
> +++ b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
> @@ -54,7 +54,6 @@
>   /*              Ported to LTP                                                 */
>   /*                      - Jan 08 2009 - Subrata<subrata@linux.vnet.ibm.com>   */
>   /******************************************************************************/
> -#include<fcntl.h>
>   #include<signal.h>
>   #include<stdio.h>
>   #include<unistd.h>
> diff --git a/testcases/kernel/syscalls/socket/socket02.c b/testcases/kernel/syscalls/socket/socket02.c
> index afe9dc129..59fd942d5 100644
> --- a/testcases/kernel/syscalls/socket/socket02.c
> +++ b/testcases/kernel/syscalls/socket/socket02.c
> @@ -12,7 +12,6 @@
>   * in socket() in kernel 2.6.27.
>   */
> 
> -#include<fcntl.h>
>   #include<stdio.h>
>   #include<unistd.h>
>   #include<netinet/in.h>
> diff --git a/testcases/kernel/syscalls/socketpair/socketpair02.c b/testcases/kernel/syscalls/socketpair/socketpair02.c
> index 72ca0e816..e23945c53 100644
> --- a/testcases/kernel/syscalls/socketpair/socketpair02.c
> +++ b/testcases/kernel/syscalls/socketpair/socketpair02.c
> @@ -13,7 +13,6 @@
>   */
> 
>   #include<errno.h>
> -#include<fcntl.h>
>   #include<pthread.h>
>   #include<stdio.h>
>   #include<unistd.h>
> diff --git a/testcases/kernel/syscalls/tee/tee01.c b/testcases/kernel/syscalls/tee/tee01.c
> index db2ac1e0c..cee6ed7d9 100644
> --- a/testcases/kernel/syscalls/tee/tee01.c
> +++ b/testcases/kernel/syscalls/tee/tee01.c
> @@ -11,7 +11,6 @@
>   #include<string.h>
>   #include<signal.h>
>   #include<sys/types.h>
> -#include<fcntl.h>
> 
>   #include "tst_test.h"
>   #include "lapi/fcntl.h"
> diff --git a/testcases/kernel/syscalls/timerfd/timerfd02.c b/testcases/kernel/syscalls/timerfd/timerfd02.c
> index c54440660..88742b806 100644
> --- a/testcases/kernel/syscalls/timerfd/timerfd02.c
> +++ b/testcases/kernel/syscalls/timerfd/timerfd02.c
> @@ -54,7 +54,6 @@
>   /*                      - Jan 08 2009 - Subrata<subrata@linux.vnet.ibm.com>   */
>   /******************************************************************************/
> 
> -#include<fcntl.h>
>   #include<stdio.h>
>   #include<time.h>
>   #include<unistd.h>
> diff --git a/testcases/kernel/syscalls/timerfd/timerfd03.c b/testcases/kernel/syscalls/timerfd/timerfd03.c
> index e288251b3..41aa94636 100644
> --- a/testcases/kernel/syscalls/timerfd/timerfd03.c
> +++ b/testcases/kernel/syscalls/timerfd/timerfd03.c
> @@ -50,7 +50,6 @@
>   /*              Ported to LTP                                                 */
>   /*                      - Jan 13 2009 - Subrata<subrata@linux.vnet.ibm.com>   */
>   /******************************************************************************/
> -#include<fcntl.h>
>   #include<stdio.h>
>   #include<time.h>
>   #include<unistd.h>
> diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice01.c b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
> index 1d1b66d12..36ecc08ef 100644
> --- a/testcases/kernel/syscalls/vmsplice/vmsplice01.c
> +++ b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
> @@ -11,7 +11,6 @@
>   #include<string.h>
>   #include<signal.h>
>   #include<sys/types.h>
> -#include<fcntl.h>
>   #include<sys/poll.h>
> 
>   #include "tst_test.h"
> diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice02.c b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
> index 39c407cb8..0135b6f7e 100644
> --- a/testcases/kernel/syscalls/vmsplice/vmsplice02.c
> +++ b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
> @@ -18,9 +18,7 @@
> 
>   #include<sys/types.h>
>   #include<sys/stat.h>
> -#include<fcntl.h>
>   #include<unistd.h>
> -#include<fcntl.h>
>   #include<sys/uio.h>
>   #include<limits.h>
> 
> --
> 2.17.1
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
