Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921BCCFC501
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 01:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728954892; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=HRzDyKj9g3CNypbakURJ6Du1G/AI1mCLCsEthinQXlM=;
 b=AJyzKWS/IV9PIcB9rE287dSYlrAyI5tAVkUKughUWRHPU3P1fxgejtr//ypx1SQyHKpPj
 YMpzHXqh52mGILniZxvaoUunJLvLuci0IRgcTV45D9c1IBMmBbQT9hBIV9CKu58shIUkyXr
 xGXbxBJxDuNOtl43baoOrjLWA/nRQmk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CC203C66AC
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 03:14:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BAC93C015A
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 03:14:33 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.152.245;
 helo=esa1.fujitsucc.c3s2.iphmx.com; envelope-from=lizhijian@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com
 [68.232.152.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3D03C1416731
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 03:14:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1728954872; x=1760490872;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=HMYpEJTCvA/ReCB/Z6UWbLumcFfxOlZczJvd4YE2BrA=;
 b=sCZIi4pk9SijpxIXMGn85Z9JuK1l3mipi8YYC74iVsHRobt6IRjaqXaL
 kJlPHJHOM89lFG2gpBvtixIXIQqv32/6ulwOVjjOQ36Vpm60xpbL0iudG
 2E7ag8dKSXbS26vThmrlkJOCdEhw8l1jGjLnyzcnrRZRh/PrDaTtTQvUo
 mm9Yc/b9qakEVFWXwFz3Lf1WghGnaRoIlf8LTuZhSA1muT+qRNggR43wG
 o9RvM/5lz+nRIMS5Cg/Tt2vcY3oKmI66SXk7gxQybhcPrboj2W8mB6FrP
 e40yxD2ExQpcNtZTGAgLVQIa7Tv+1edWHh9ioq/5w79dT4RyNbInaeFKR g==;
X-CSE-ConnectionGUID: U0BL0jKfRHWSgDqdgJDLpg==
X-CSE-MsgGUID: 6uiAdgXOSkCb8jzytlX0Rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="44757320"
X-IronPort-AV: E=Sophos;i="6.11,204,1725289200"; d="scan'208";a="44757320"
Received: from mail-japanwestazlp17011026.outbound.protection.outlook.com
 (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.26])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2024 10:14:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRNV4kXK9rNoX1IUmy77tbUzHmOZVsF78TVlRzA+vtNOe+AQaPJ9bwJIVP5CzWEktRrqUZBxAq7pQJ+fyxjxqZUgNWKt4eQo2KdU8t8xfsVH8RhWxmpMiiSyrfni6CBzN9ytHcH2tOP05lfLsSOUH0z0Z0/V6K/YUv7pBxIav8Bg/LPPhQkNPqknUQGb1Eiehf06BnknBZ8z+j+zJ6EvnLj8R7Dt6dNNmGviKru9kJLRNmw6UW/9zLq2SxaN83UxBglsZnAgGbLNvYCZlUlAPkhJpp2RjK+I8PVXrOjJfSAJLl9yGWrEkHfGnb2+awCjQCAsyNRwFH4hvlKwQUSQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMYpEJTCvA/ReCB/Z6UWbLumcFfxOlZczJvd4YE2BrA=;
 b=aiZ9chqDhB2O8zOvYOq5lAJm8f+3UCupzLzUwmNavxFozlEV51IbkTnAErw6yu/UTOeAckJJhGj573j0v/f3QGtdbvCHA1ywb9FCuO5FFnFwzbfHRHKJM/BPoKRs96oSTcg8MmnU9jFIyV/303zGHmZaWEUZX9/ebBrv68nHZX4IQtPvJS4hQcuqwEGRmnNKkfqE62jqZrlhm4GfOxB4K+IHMdxU5a8il1QYK3TpB0OxspVCHPXswbt1O9SzVVbqDl6RKHdeRtfframIFLvZ/jODtYoSKMad2/hQZM/BF4o3wT6hzr4EoD0+u7fTauYPJGY+4goxcekXVmTckQjkeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYAPR01MB5513.jpnprd01.prod.outlook.com (2603:1096:404:803f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 01:14:25 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 01:14:24 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] configure.ac: Fix temperory directory ./confXXXXXX
 not cleanup
Thread-Index: AQHbHdOGtAVBYvRy8UG+W2stAeO85bKF+GGAgAEK04A=
Date: Tue, 15 Oct 2024 01:14:24 +0000
Message-ID: <fc82b6e6-8e50-42d6-9831-b659bb70f7e3@fujitsu.com>
References: <20241014005339.460608-1-lizhijian@fujitsu.com>
 <20241014091823.GA74659@pevik>
In-Reply-To: <20241014091823.GA74659@pevik>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYAPR01MB5513:EE_
x-ms-office365-filtering-correlation-id: c1381971-0886-4ab1-b397-08dcecb6b515
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?YVhaQTI4T1JYVzBYZ2QxblZvWFc0ZStBelRyejVuc21TeW5MMFhkRUNzZ1c2?=
 =?utf-8?B?V1JRWDdlWk1HRzF1L3U5S3U0V001dVg0bDE5S2hCUGg3UUEwWklsQWZEK1lN?=
 =?utf-8?B?Znh1eVVXWkU1bGJKS2c1bmwwaGlmQmpsS2E4VTB2elMySGRRdGtydkJTSjZE?=
 =?utf-8?B?VGxrVnBJTWhLS1h0QnJBY0dqM1hFWVlCSzMrbkdDOUphdit4eDhnc0hmUkoy?=
 =?utf-8?B?NFNmTEpPTEpnSGVadlBzQkFKTk0zd2VzYW5PZ25Dc3Rua0dmejVQRExOZERV?=
 =?utf-8?B?ZXBidGxJb1paYTZYMGFxOGhRWi9aRC9ibGpJK0g3K1FpQW5DZEQ4RzFwbDQ5?=
 =?utf-8?B?L3Z6a3YyOExZaDU5aEJ0dnhMM2h1OCs2MHFqQ0I1SEtzK2FMSVQ4R0ZSQVIy?=
 =?utf-8?B?SFhDcVU3aWtjWjdBSDlENkhHZWJzUnN2NUhDcmJGVnM5MllHbVJzVmYrMnJX?=
 =?utf-8?B?NjJYOFo0M1RxQjJKUy9FOW82YkpJUzJKcElOclpuZ2dHRGU5emhNcTJmOXpu?=
 =?utf-8?B?UWdqOU40alVCSEE5cnB4WGp4MmRWMi8rN2ZOVFpSV1NyRXdoSGprWmNIZmJ6?=
 =?utf-8?B?V0JEelBVMUNPTGIwQUFmQkxqMHFIUVloRzloWUJKaVU3dUhFWGZrVXVNMWxI?=
 =?utf-8?B?bWh3ZmJtZ3V6a1p1V2d0WThzVnFuUzkrOVUrSHpWTFk0OG1Wd1ZoTUprMlov?=
 =?utf-8?B?NVFpUDl4eWVUNjBKM1VZK2ZkMkh3aUFBQThDVGVMQjUxWFRjVGN6WGhyQUps?=
 =?utf-8?B?Ry8xY1NRelQvenRDbk5NRmEvaTBaRXIyOXJ0M2pQK1BJYU50ejBZeE43MFcr?=
 =?utf-8?B?NU9oTTZYUzJTRUhiaEdmczh2MXRKUmpyTk41c0R2OFlpUFk3QWlNNWFtTmlv?=
 =?utf-8?B?WjFhSU9oR0NsSVV0M1ZFTkEzUmRIVU56dWkxbnRYdnZCL1dubmRKM1g4dVhM?=
 =?utf-8?B?cnArMkdDMndYR1pzQzNDQ0VFM2t3WFB3WHk4QWlTNU5NbVZOT1NLNWFDaDJj?=
 =?utf-8?B?UTZkWmR5dytHQkVXZS9oTjZrTUduNGZYbWZKUklBZzF6V3k3a1IzenlhZUtF?=
 =?utf-8?B?L2RaQkxpM0dBdXJGaVc3WXJ4a3BHTFJZcCtoNG5MaWpaVTJNWWNETVI3Y2Jo?=
 =?utf-8?B?QlEyOEJyZFhvZ2JRd2V2S0hFMXZyanlkci9lRCtua2JPTDY1dDNPSDF5TFJD?=
 =?utf-8?B?RlhIR1NmTFRBQ3JRS0hiU2ZXM1NtOTYxb1E2Q093N08ydWFoVHNISlR0QVJC?=
 =?utf-8?B?Z2xHMW8vdGprR3l5OW9lS1Y0QmVHWHZRckxHL0RRd1pyQjlyQ1RVSHB4Zkpo?=
 =?utf-8?B?bHA0VmptUHVJVzRDeFNjM1ZxWVA5OHhrSkRXdkN3YitOTUNTUFdoUENyQ202?=
 =?utf-8?B?MnROVDBGdTFsYkZ0T1ZySENienFYYjAwVFBjQ0Q3bDZEQ2FFR1Nud0YwZlo2?=
 =?utf-8?B?TjYremRiQ1Y2OXFhd2dBRDVqU1U3UXBLbFoxemhrUFZHT2pVanozcFFvcGE1?=
 =?utf-8?B?bWpBMmxPUldUd1VrejkzQ3NyalVGYVVYckFzT0VzS2pSdnhpR25RczBwZlFC?=
 =?utf-8?B?ajFPQWVOQkVPMG9CNDg2SStPeVBYOHY2NC93eFdla25VOS9TQmZTZktxUThi?=
 =?utf-8?B?TUFjaXA0OHI4V1graGFsRGNVUFhTU3pnUk1ya2kvcXM4WEJrUFBuckdNQm5h?=
 =?utf-8?B?cThidFZaZjUwUzkvT09NZUlDdVNyL2piOVlnbk9uUk9xbWV2Z2xoYUdhTVFv?=
 =?utf-8?B?OG5mSEVERXR6ajI0akh5Qy9HT3VXWnYzT3JuQWhLQU5oUXJDSXpwcXU5ZXFY?=
 =?utf-8?Q?WzHbkjONGY2HKJLlRmJZTBReG2LbnXJcQTUFs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUUrdFoyenh1YUp6YS9VNmFoNjdWR1pPcmRNRzhYTDFXMkhWNlg5WGNucDZa?=
 =?utf-8?B?ci9obWtyRjVhSWxlU25tV0ZweVVnVi9IMEhnOVAxeElCRzRDcTR1WllaaWN1?=
 =?utf-8?B?a1hDZWVnQ21XREM0dVJrcXV1Ym5lVzNjTWI3QURuTmZDQUxENVlDdGp6YjR3?=
 =?utf-8?B?aWwwOW9paUtudkNiVUExcW5oWkF6ZFFJZEtQemVlMjlwQXQrZW4yZmVuUWdq?=
 =?utf-8?B?Ty9nekI0Zy9BWlNzZWVqR1czdDczY1RpQUNmbEFmdm9jMDJUVlJMR1JFWXNH?=
 =?utf-8?B?aFFZRXpERzBpR0hERGMrS0piTWxGWG54TzdPZjNmMitvbnROekxXWUVOcUkr?=
 =?utf-8?B?NytFRytaeVNFWVNQdkRMTjByZmFjMGhvVmRMZkVnZFQ5SWYxLytoOTBnVzdT?=
 =?utf-8?B?SVNNZEdFREtGVS9FVFVValRMUW5pbEhoUnB0NHE3anVYYS9ObG4wQVp2c3JF?=
 =?utf-8?B?M3JmNUszQzFiUnRmb2pjNjI1eXQwcjZyYjVuUUMxMnZ1UWFZRXpJaStUdFFM?=
 =?utf-8?B?WFR3WExqVG4wWk5zd2p4aDUzcGpvWUtkWVBvcEZzNVc3ZTVpeU9UMmh5TVpi?=
 =?utf-8?B?Si9hbUlNSkgzWURUR3plaGdZUFk2ZjBWNkNnanl6YVFzT2R3bEcvdG1rL3VK?=
 =?utf-8?B?K3lGUWhTZVorNzdWbEViZjh6REk1QUxPeUtYT2tzNFRjOG5wejE1eDY2Y25k?=
 =?utf-8?B?dFF6UlArVndFVkRsSWtCTHJjUGVqWGhMOEhQbCt5dzU4WGJacmxHRWtCdm1T?=
 =?utf-8?B?czhpVnBuVFZBYWpPYUVMdTV5amx4R2JWd1B2eDhudTJsdmVDZGs5Y1l2Rlpy?=
 =?utf-8?B?eTQyaXNySm9WeUhrQjhWT1Z2UlJNbENjQXBEOWpMUi9tMlorcGZTTmZ0NmJp?=
 =?utf-8?B?OFBMcFJ2NEJpNFRzMGN4Z0VZclkzcHVnMHIvYm5EYkhMYjJpZUpmVXdKaUhZ?=
 =?utf-8?B?amZMeTVFZk0wUkZsbys1dGErZzVvNlFwa2dISTQrTGxnQlIycElrbzlIMzhp?=
 =?utf-8?B?OGxDbDROdXY3MHlZM24xbjRxcGYxVWkxWVJWWDQxOEYvNm80bGZraTIySkx1?=
 =?utf-8?B?bnczZ3B0T0g2Ulh6dFo2cWt1VklJams3ckdJMWpTWm1CQnptZnZ5blZPUmFT?=
 =?utf-8?B?UHVpUFBQbU5hVWlGQ3hsWFZUdk9IRCtyelFaQlA1aFhZWjBxdUd2YjBqOUFa?=
 =?utf-8?B?K3RmMUFNN1Y3L3hwdHFKQ29RMjlzWkc5MG9JeTRkS0FtaHJkMGtiZW9wNG1k?=
 =?utf-8?B?OGpITGszN0pTQnlQWlJUZVgxbEdha2YyMEx4WXpFNG8zTnBXQi85UzNWdm0z?=
 =?utf-8?B?V2ljRFp5MFRCbTJaNFFKRzdERktrRFRLcjJOSjFMaXpZclVUVCtUNW5lVStT?=
 =?utf-8?B?NzZPR3pvdmhyVWtQdHpldHNpWTFITDZxd2I4VU55a3dEUWVDT29xVWNrUk5o?=
 =?utf-8?B?VzIxYUlxVUtBQmx2TWtNNitBdG5LMlFWaEpkd2JwUVFzVHFPT1A3ZWdrZ1Ev?=
 =?utf-8?B?enpCRDJuUHg3ZGtCVm53S3lsZXYzellERE81cFV3T1didXkwYmMzOXhCRHJX?=
 =?utf-8?B?VC9VT1RUSGhmYUdxMFlJaWVQNU1zN3IrYXlzN3dqc0VRKy9pbFRJZjF5VmIw?=
 =?utf-8?B?bnFXWFh3dkpyMGh6MUZYdUEwcWQzakovbGVBdkJCZncvZldlbHVzek01NnN1?=
 =?utf-8?B?TEtTODkyT1d2NmRXNHhzWnY4VlVLQllXZUZUeG1GakFJbUhHcTU3Yk9mMWha?=
 =?utf-8?B?Z3QveDRsSXAzdHl2b0pOZFp6VTV4MTNuQzI1aENGL0d5WmtNcUFJSlFxT2pr?=
 =?utf-8?B?THphbklJUDE2UXRoMGI1dXlPQ0FUVXF4S25qeCtyQmE5bXdVMDJWQml3S01Z?=
 =?utf-8?B?T2lPb2RVMGdvbzZyd2VhOXFRcGpaVlZSQjU4UTRxMEg3Z3pDV0RScWs3UUNm?=
 =?utf-8?B?c2xiTWd6bEhTbVZmYk5kbERERkdLVkI1OWRFblZXa3FYdjF1aXVkdHZROEVP?=
 =?utf-8?B?aVlrYUNGdkMxVW9NL3dCT1lHaUpsTEQzcmpFN2dpQ0lxdWhQMXNjTEE0REJ6?=
 =?utf-8?B?SjJlRUdNcjB1SlBaeWlkRzZsNU1nSzg4MlV1c3ltaUp5eDZaQnZVUGxTM3RG?=
 =?utf-8?B?UnNpUGdHcmV0VDFPWXFvSFZQalBHbHYrSlpqZlFDN2VwSkMrQUt6YnhIZFNa?=
 =?utf-8?B?YWc9PQ==?=
Content-ID: <4E029B34C08E0F4D8B441DB119E2B451@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wXUzE/f69/2LAbeCBHxDqjZXK6XaotVFE7p8m0mALy+aeiOYp6kQUTMdWhgmrAXH//n38tx7CbJkxvFRrMc1AOesckBNLB/ewlN2oMVgLjaz49MWcDBYTPpxaaqc81E36/Hfwc3XHPKpdgWBTZJ5ocC9vph7qyRmsy18Db+D9rJOk1iSNYPW03m6v9UnxPMzzwO2j7yFvEl2HupTn6Bdbivsnv+970xp6d5CMyDUFVpHM4/7Fp56VylUbjuPXlHj7MbPvuOqTg6Lc6fDpEhMa5NblJYDR1y1AA+Wse4/V4wJbMHVOnTva4ACklzS6vQOyWU11sKuIL4OCgs4llsq2YUtvlemuZhoQ4GvylrfoqpASxYeYg62ioga4RRBd/W2kjIxYJC1X5xopnWPJ0YJUGHtOEdWD4vSpHGQxc1NNhD8+41od3vnnCBBMJ6AHEsuaHlNRtFh6YLmdNm2Kyspq/CFGAoMl5RPrrQ494UrU73a7S8oiSMh85/XHWfdyMkoh5rSOoYGKJfCOwSM2Pr527auJS5LosCDJKGirTzl6W5crv4Qg1Ec95GWfNT7100Yz5wJrLdHBienRDkAUQ1chXN8gz5yecDi+OzhG1hanqBR8tlOFxMuzhxq/kY/C96H
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1381971-0886-4ab1-b397-08dcecb6b515
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 01:14:24.6042 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fswy6exU7Lthv7HlIV3ZBXMG9cN3Eqx55esjIXgPN5HZY6zv7Ll8h+d2U/f1QaigltQz3d0rkH1f+Q7kYOho5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5513
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] configure.ac: Fix temperory directory
 ./confXXXXXX not cleanup
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
From: "Zhijian Li \(Fujitsu\) via ltp" <ltp@lists.linux.it>
Reply-To: "Zhijian Li \(Fujitsu\)" <lizhijian@fujitsu.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Thanks for your review


On 14/10/2024 17:18, Petr Vorel wrote:
> Hi all,
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> nit: typos in subject: temperory => temporary

Good catch, I will collect Reviewed tags, Fixes tag and send v2


Thanks
Zhijian

> 
>> configure
>>   ->config.status
>>    -> create temperory directory ./confXXXXXX
>>    -> cd include/lapi/syscalls
>>    -> ./regen.sh
>>    -> cleanup ./confXXXXXX, registered in trap
> 
>> Where config.status changes the working directory, ./confXXXXXX is not
>> removed as a result.
> 
>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>> ---
>>   configure.ac | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
>> diff --git a/configure.ac b/configure.ac
>> index b4ab81e265..d327974efa 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -386,7 +386,7 @@ else
>>       AC_SUBST([WITH_REALTIME_TESTSUITE],["no"])
>>   fi
> 
>> -AC_CONFIG_COMMANDS([syscalls.h], [cd ${ac_top_srcdir}/include/lapi/syscalls; ./regen.sh])
>> +AC_CONFIG_COMMANDS([syscalls.h], [cd ${ac_top_srcdir}/include/lapi/syscalls; ./regen.sh; cd - >/dev/null])
> 
> 
> I was thinking whether use "cd ${ac_top_builddir}", but because cd happens
> outside of regen.sh, "cd -" will always work and it's probably the best.
> 
> Also, I suppose this happen quite long time ago:
> 
> Fixes: a07008fbec ("configure.ac: Generate linux_syscall_headers.h")
> 
> I noticed the problem later on but never invested time to fix it. Li Zhijian,
> thanks for taking care.
> 
> Kind regards,
> Petr
> 
>>   # custom functions
>>   # NOTE: don't create custom functions for simple checks, put them into this file

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
