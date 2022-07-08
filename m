Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1666CCCA479
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 01:40:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55B933CA35F
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 03:40:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5B033CA29C
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 03:40:34 +0200 (CEST)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 245EA1400E52
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 03:40:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1657244433; x=1688780433;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=eMlCLWg8rovH8FIHfVRWpbXydvQ+vED9g7XOfiQ0u2I=;
 b=vCHVIxQdHcl67MW++yQ7wmI/0EtgAGJjZ8csKWDYptCeTecWNRyT8gwq
 nHQztY26+TPjlBCGwCe2PiEi/LQz2t9DJzrk1lVAM/HdHWTR6EDOa7jBY
 kFooYeOZEAwRnQzjZUgfG8Zt122/6Us+GTSJkuGooGmS2tIGfNFP/LkAx
 w0CBMNOF7ksYvDgpV4Bxo/0zIsOxCkT7m4Nk5ynTZSaUnpc6BYfy6oJHd
 h4thuJY5nuP0E4KAJKl2osf+vud6u3uWj2ZLGTOAtbiKBySze2YO0fm8h
 5FkVb1doyglGBbJanK8oUFiEPrZ2jPOOC+mWzlzx4zMiKxoZzalMl1tx3 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="67759423"
X-IronPort-AV: E=Sophos;i="5.92,254,1650898800"; d="scan'208";a="67759423"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2022 10:40:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhRDi9GNtwiB0XQSO5zrhWVbsgXVZnBpQzQ1Pme4EKdPM4Wpktd9YQKbNZjR55Sm3rJbeom0tEc+2+tfoty83ChwGzpKyOo9PmrqAz3wG+fQElayorzGysYRD1fAFFxhX1lIJYdMxAP9ij3GF2EbQIiEpkx/uhwm3nIXjyok1HYVMVPk9545+9KcXoMcnp2sZERETM+JFASafREoATZ0FZ+X31XvXn8tedyodqwZgLF0frmK2W+hJhncKsRXiHjptvsPORBNtc/hzUrRRR05FOltRKRyqjWK2z+dlFCT+bUkQto0TnG4jMp0jtfoBekvSuBE3+/LULd0NmPt3zuM/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMlCLWg8rovH8FIHfVRWpbXydvQ+vED9g7XOfiQ0u2I=;
 b=C69F3Iawt661SCvJwoBqSEMmxUiPpbEZVqt5CNB4kRWPS6mSZfBouKUfxdsBJTCVhXA/KGuEX6l9Ylc+i+TZH5DxXpyQXMGWvHQfLJKGb9Kbsz5ay1Ps9HGdsRDRZmBK4BpwnKokvVTRwVePAsVBzVZvjgAG3fuS4k+QFWuX3L9HxjWwIeN/rvs7WUsu3qeu4EaJhIFpqegiaGwbnSkGTc69pdUJAj9C+28rXpvxl6RzShdPpXzU/xUTLyamUNv3OTtGrpknd9QvrIV6Wvzj57DJcMfC0wcxf1lPRNmPfa1Skigc3Pg83//fibaVjnfaaALNCJ1wLRercUlsUyBHGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMlCLWg8rovH8FIHfVRWpbXydvQ+vED9g7XOfiQ0u2I=;
 b=dt0HSSs2vIMqVeYkISowWpMnfAgLRpCWuIi/nIF1MFl9t3OyauMT75uS0pyETuTG2aTNEdZyYEPOGXZJ0BCtM/tC3PjdWv0RkTcMfriZk/nTLh2D20mCn9ILbONHunwa+iIeFUwK7c2W3xC+z1C3jV25/b/KGtdq+TJfRgfOgUA=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB1778.jpnprd01.prod.outlook.com (2603:1096:603:2f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Fri, 8 Jul
 2022 01:40:27 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160%5]) with mapi id 15.20.5417.017; Fri, 8 Jul 2022
 01:40:27 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH] mountns01: wait for umount completed in thread_b
Thread-Index: AQHYkeVvpj1To9Ct0UKVzebBFftbFq1zxKUA
Date: Fri, 8 Jul 2022 01:40:27 +0000
Message-ID: <62C79956.6090709@fujitsu.com>
References: <20220707093845.946230-1-liwang@redhat.com>
In-Reply-To: <20220707093845.946230-1-liwang@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79440d44-08f1-4cf2-137b-08da6082d5af
x-ms-traffictypediagnostic: OSAPR01MB1778:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DmCRukyCkpP5w+CqNhi/n0FINMGkRSiQElkJF4o9egj9o6nKstL9Xnezn1fVPm3GT13qOqjQKc+g3auAz/BM73K2g6r5ZnNch5jy9luOH2UtgdrfEljhGCUiUjt3VwYUIcFWflKEs7YPYV3hePooLctTlaw8bdjvV4yzYZisWYhUHov86vTGTwpr1qOoEz1lz2YbKnrZHy8mjUcKIzpmBFejuTR+Ox45VihWUStI0movz6nF6mh1z/bNLCGXji8XnMPPaIxp4/NV0Havet1mm5TSR6f9r3IR9dG4Sha1Vuz1Np1lmbOW8+4vGWE4nRtiuMATRR0/7RPGDqUFx06DB18LBRg/eTGknp8TeWwKLZen3vDDxjkPSGfBJSLreG0eRumzF8bNfoU0WZ8ODSOTHl8nynlLbu4CR+8xxdZF2lPSCB4CMjeS+8iF1j5UR0hWxfEO4PPBmSCO5XovPOHpYrSnzn7qwhAcuODOxJVAWuJDrLXi5Oj1gp0BzuvvrrRZ1xGIl9yt1SyHUpGwDY9aFAFr/GFpx5f+3bnGV1xJgNB2hX0vO3cSiU+BuP3YjVq0VCP4BEyiHhEUxArME1AwWq7sKXsIEf8guYMT5EjyfVNL7pQizg82CzUY+IGMLRIdeqpJ7D9eghsNK09rh3fv5faeRf/PVHD+Iivs7oU9SIXk5hy+Z2Q9bDQWPg+LMdprPuCwAg7S77jEW05U9rk4Q7FX+DBdDwCCaMFVz+DW5TwcywadZUbzTZBDj193dDhlsGEfQM9dRVX+MTY+xXlurdKrRGHmZqJbgNDkZVPD9+iks9LvVoYDvw6k1YVsVEg5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(2906002)(2616005)(8936002)(41300700001)(6506007)(316002)(38100700002)(6512007)(36756003)(85182001)(87266011)(6916009)(33656002)(91956017)(66476007)(478600001)(82960400001)(64756008)(186003)(8676002)(4326008)(26005)(66946007)(122000001)(38070700005)(6486002)(86362001)(5660300002)(66556008)(71200400001)(66446008)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Z3ZzQlFKY0MveFZ2WHRGL0owR3N1b3NVMkxDeXN2bGVwSDdZdExjSE9VK1Ar?=
 =?gb2312?B?VmV3MXRHMEMxelduT3lnamdsbzAvbVdpQkM3Ry9tZnpsQ01uNGVPcG5RcTFv?=
 =?gb2312?B?bFBnZlRhVkJIcFB5VDJhbDBiaWtvOFdNcXFwK2VmeWJ4bDNjQzJNY3NjdEp1?=
 =?gb2312?B?LytiU1daNEhXaGhVUkp6cEI4ZFM2UjZ1S2F4VXhEcmFySi9QRzJJTml0aDU3?=
 =?gb2312?B?L3Y2V2QvdlU2dTZjWmFZdGtFM2tWL0lhb0pVZCtYTjc4RURTcGEvM0M0c21x?=
 =?gb2312?B?aUk4ZTQvY1NRTjh4YUQwY2NnNXlMN1ZXSCt3TkYxekJCWG1Pa0czUzIycHVu?=
 =?gb2312?B?OGtJV1h4UWFDZy8vbnlwanNjTVlWMXJ1Yms1NDZUdno4TkMvVXBFRExDbitD?=
 =?gb2312?B?NXdNUkxxWVNBK3NQczNrZEFjVmZOZFkwbXhXN0NNT045WFFSUEU4L2QvRlpw?=
 =?gb2312?B?ZmZpaDI1ZVl5ODlhaXpVSmRlOFJ0YUR0OWQyWVQyd1FkemxNTDl5ald1eWsw?=
 =?gb2312?B?TkRINVRndXlNQnhEeTBrZGhreTl5SUl5NmJXVTZxbmZxcnFaeUhyL283aXdS?=
 =?gb2312?B?YzBvK2hSV2EvV1l6ejFmVmlzeU1qbjRVZkhGcC92Z01SbGJtQUw3R1JZMnox?=
 =?gb2312?B?eVBxTms2blI2clYwMm8vNGhBUWJ5RGZodnkyMjJ5dU9IaHQ1QXI3UWEyMDlO?=
 =?gb2312?B?NmJQRGc5U0Y3UWk5MDRuT1EzSjVYRUx2QURRb1BoYTloa0JhR1U3OFMrZnpT?=
 =?gb2312?B?N1k2SHMrQzhFMWFId3diTHlHNFlqZGI3RW45b1dqK082enNoNlpaQzNBRFBJ?=
 =?gb2312?B?T3F6Ylo5TFhSajd2a0k3VGtJL1pma1hmNXdacWwxL2U5TThVY1gxdzcwaGRN?=
 =?gb2312?B?T3doek9DT3ErMFZveklSWHI1MHMxeFBrZW5GUVFLS1Q2aUlsdjVMVkc1aEpi?=
 =?gb2312?B?K285Z3I2RXMxejhqNGZ3VHpINDI2OE1tSVhSSkFORHNkTnYzc0Q5L29aTVVI?=
 =?gb2312?B?VVkvM3hkNnlLUW5vNzFQVmxRNUJmN0ZzVHJlemlzWFBmMks0eThqay9EMXpT?=
 =?gb2312?B?ckZFTG9FNHNCZ3Q4bVhrajEva3V0d0ovR0pnd1hVZE10NXQ0eGxrRCtNVEFy?=
 =?gb2312?B?U0xPR1dPeDFITG51ZWN2R2prZ0xFR1doSWJVZGY2U0w3K2VsNm14NXo2bHhC?=
 =?gb2312?B?aDQ4aGdtQ3FXSm1saGw1ZGVyT2ZVdkdCNkNQSkhtaDRKMWI5ZkJ3ekovemRo?=
 =?gb2312?B?aFYzTEdsWjUvS2N6RFAzRENFQWxRS3RTN3Y3aElaektDMmM2Q1hFSDBUVzBv?=
 =?gb2312?B?T0x3ZU1EVnVzaGFZbjZMOGFBdWo4V2RPYWlNWkNMelJ1cll0UWs5K2RFam5W?=
 =?gb2312?B?Y2s1YmhQR28yK21kNVpmcWRaUk41Z1MzOG1OU0xFcStZY21QbWVXM255ZHN6?=
 =?gb2312?B?ekRKM0tuMWxsOC84bmxYWGs3WnE2cGRURnJQR3RzR0w3TlE1WjBESmNqcTZp?=
 =?gb2312?B?K082SDhmcnRwZThZSVNnekFsY1dTUmpobERISU9DSGNNOEtvSE5kZ1VkLzFj?=
 =?gb2312?B?dW1sUGMrTys5bmdTWGk1NzQ0SCtJTVY4YVJ2RDNnUFJTWUd2VEZQZ0ppTGs4?=
 =?gb2312?B?UGlOMGhGQkFjUmx6VHhTSHZEckt0SHVqWG1pSFBGd2VzU21mYUNZRUdzWkU2?=
 =?gb2312?B?SExacGQ4dU5oY0NLc3cvblVnZEFKcVNVd083clZHakIybXB0TUZEdDk5cURF?=
 =?gb2312?B?TGNJczhxdHZLNmFFOEcvMktuVWw1dDRxMkIrdzZWK010MFRoZjh1Z2dIWjJQ?=
 =?gb2312?B?ektaYWxHWTdjRHJrRGJDNVdId2hOdi8xUExMM09EL3U3MnAvK2g4SDZxMWxW?=
 =?gb2312?B?UW04TGptZEtRcU9OR0Q5djJpS21vS0h6bGFBb0pWSVFGaWVWa1VxZGdtQTdt?=
 =?gb2312?B?elRLNFlXVHgrdmVnbW81QzJTVlR3QUdWaFZ4MGlIdnhUcWs4Z09iS0NWREww?=
 =?gb2312?B?cStUaldiV1I5clRBR1E4bklBNDIvbTB0QlJCSnJEUlRWVVFnUnhxcFg0QWJq?=
 =?gb2312?B?dGFTOGQ2SjdQOHBrbENtZFRTOVRNUGNySXRLSWEzUGNXL2xZYXdnbTYzbzFz?=
 =?gb2312?B?emVacDJvaWVOYnpaQ0dVdk5PejExVzA3RnVudjBYT3hBRnBtd0J2Nk55NjZn?=
 =?gb2312?B?MGc9PQ==?=
Content-ID: <D32D00612EC7E6499354067AFE33E774@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79440d44-08f1-4cf2-137b-08da6082d5af
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 01:40:27.2913 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: biRNcvma4Rd1/uB3vjO3S7BoBrfRCQOgcZ3a1frWfbQMsoV63wptQOpugZ0VPSQumx/ooA9OKUCfP3TpPNrmJt9srIj2nXr3TDI+Qlwh77g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1778
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mountns01: wait for umount completed in thread_b
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

Hi Li

I have merged this patch by modifying patch title
mountns01->mountns0[1-3]

Best Regards
Yang Xu
> To get rid of race condition (occurs with umount_folders):
>
>      mountns01.c:42: TPASS: shared mount in parent passed
>      mountns01.c:83: TPASS: shared mount in child passed
>      tst_device.c:394: TWARN: umount('B') failed with EINVAL
>      mountns.h:39: TWARN: umount(B) failed: EINVAL (22)
>
> Signed-off-by: Li Wang<liwang@redhat.com>
> ---
>   testcases/kernel/containers/mountns/mountns01.c | 2 ++
>   testcases/kernel/containers/mountns/mountns02.c | 2 ++
>   testcases/kernel/containers/mountns/mountns03.c | 2 ++
>   3 files changed, 6 insertions(+)
>
> diff --git a/testcases/kernel/containers/mountns/mountns01.c b/testcases/kernel/containers/mountns/mountns01.c
> index 452fe1d10..3e9c22ce3 100644
> --- a/testcases/kernel/containers/mountns/mountns01.c
> +++ b/testcases/kernel/containers/mountns/mountns01.c
> @@ -86,6 +86,8 @@ static void run(void)
>
>   	TST_CHECKPOINT_WAKE(0);
>
> +	SAFE_WAIT(NULL);
> +
>   	SAFE_UMOUNT(DIRA);
>   }
>
> diff --git a/testcases/kernel/containers/mountns/mountns02.c b/testcases/kernel/containers/mountns/mountns02.c
> index cbd435958..4ef1a61b8 100644
> --- a/testcases/kernel/containers/mountns/mountns02.c
> +++ b/testcases/kernel/containers/mountns/mountns02.c
> @@ -87,6 +87,8 @@ static void run(void)
>
>   	TST_CHECKPOINT_WAKE(0);
>
> +	SAFE_WAIT(NULL);
> +
>   	SAFE_UMOUNT(DIRA);
>   }
>
> diff --git a/testcases/kernel/containers/mountns/mountns03.c b/testcases/kernel/containers/mountns/mountns03.c
> index 5c19a96a9..0d8b86f9d 100644
> --- a/testcases/kernel/containers/mountns/mountns03.c
> +++ b/testcases/kernel/containers/mountns/mountns03.c
> @@ -97,6 +97,8 @@ static void run(void)
>
>   	TST_CHECKPOINT_WAKE(0);
>
> +	SAFE_WAIT(NULL);
> +
>   	SAFE_UMOUNT(DIRA);
>   }
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
