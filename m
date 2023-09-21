Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D321DCD495F
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 07:02:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26DF63CDE7C
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 09:02:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EBB13CA21C
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 09:02:20 +0200 (CEST)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C6BDF10011B1
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 09:02:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695279739; x=1726815739;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TSgpQd8hVpIfyj5tb++66wOq4peu2ucwlAGqPMopzw8=;
 b=pdLel8n9GKZ/ATxmt02GVz+n6JIydk9vCIK+7onygdcnwv6BGI1RrN+M
 idQP8+kwN0jNpOmXFKvaJ7IfibpR94ekXVpNhUppYC1uFOzSfosvGe/xT
 ZeNzj6v5LZ9rtl8w1OJVgXxX8Kx2Gf74mbLMNmwE4eZeT5QAn/wjVEiH2
 2daXQ/5CrktWe56A3Z4OkdYqTi4Eu1fpR7ekHchfhDT/V+vRly5kujl06
 Uz1IkxxKp+DhFQvnkoMccQ/4wb8nc/zZ1TKrCWRplnkgyMuXFVu8fhUm3
 Iwk1E3gNy7G7WhbGrf7CBpE7tHX3Xc5tEcPQA25BDhzxAqSmyh0SISGl2 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="96216778"
X-IronPort-AV: E=Sophos;i="6.03,164,1694703600"; d="scan'208";a="96216778"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 16:02:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoIZ/ayZfQ/roSjcPqRvWNLFvi1vlN/MJafdiXUeb6ez+rf10wSFPsTf1Wk817uHnV3UaOdIPIQF2AlbTJ0H9aGC9OnCBHk8bQBo8NBUTy1xHRzrl+tKnhl7xif3Jj7zW1IF4i5fHEqp8P9UX+b4e0kJiAb8kOFc2ck9P11GjFxXLqU6b+kr8EYXa9FGUjyfpEAWKuarfGr/Z7Nxkvd/AM6ClrD7jybeEAkl4uxwPAW/hrQRfUmnYpBg0hCxUhRp7wgOxG4g3CGPfwkst1WIne72tqfnAuLvM3ZkSFGQrXnyn8b595CKFwYDSj1po6e7rnvPB41RtqU4rY7M82z1jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSgpQd8hVpIfyj5tb++66wOq4peu2ucwlAGqPMopzw8=;
 b=A25Nqi7yH0Wj0iBOG4ebl+0OS3/eJkYOiVrVGA0hodOaaqXmE+MBZtDEyMIkzc0eNVagKe7G9JBpzUPrzSdxNVIo4p8iLpRwtom/tQnfqVDdm6xlTW4oHfzzKtfTdbcVvcwdyUek4XfqN6Xu/Kf1BHJXMqGyX/OzTT8aVcJrzDeyL4Roj8YSanJgDMuE6Kco7dN0oBc3neZc8EOW8NeiJ8Wy6C8dq/8He9qXOhac1mVuG/tWLRutF3sTwn5jvUgJctzVf5EuXPef10gbiYcA3DcGVNkgYQSsmK0pnO+mgtes2Ih/ctWQIU/64DLcRmG4S6xtdzou3k6mdMn2DD1N8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB10221.jpnprd01.prod.outlook.com
 (2603:1096:400:1da::12) by OS7PR01MB11453.jpnprd01.prod.outlook.com
 (2603:1096:604:241::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 07:02:09 +0000
Received: from TY3PR01MB10221.jpnprd01.prod.outlook.com
 ([fe80::ae4e:28a5:4b4b:18ce]) by TY3PR01MB10221.jpnprd01.prod.outlook.com
 ([fe80::ae4e:28a5:4b4b:18ce%4]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 07:02:09 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v2] syscalls/renameat: Remove renameat fallback
 definition
Thread-Index: AQHZ57gmN9gSFG1DwkKasxuMqoh3P7Ak1KaAgAALdIA=
Date: Thu, 21 Sep 2023 07:02:09 +0000
Message-ID: <TY3PR01MB10221A2B558AC0198EAB701E2FDF8A@TY3PR01MB10221.jpnprd01.prod.outlook.com>
References: <1694770587-9502-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230921060831.GA393601@pevik>
In-Reply-To: <20230921060831.GA393601@pevik>
Accept-Language: zh-CN, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9YzU0OWExYzYtOTRhMS00M2Q5LWI1MzUtNTFlZDI4ODll?=
 =?utf-8?B?ZWVjO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0wOS0yMVQwNjo0OTozMFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB10221:EE_|OS7PR01MB11453:EE_
x-ms-office365-filtering-correlation-id: 445e0eb5-cbe1-4fb7-acf4-08dbba70ac9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 92Fh7Y7WsRZLdtvcgAo9R0IUrqb6OcPwgGHaa2bFyCD3hi8wKZx9ko/bJLwTLKbHuFbQ8vnnGklxu+7m9LMEvIby0IAWpKQC+V256vIzETuyLqsZyuZKRYeZXnabXOAtm30XfeBiFMK7uZFFtmDnS+1H/3s/w4IE7MHhwyg4WhP+fbABrMOnFc39GjwqaFp3EYS6KqNONld2p4QJ2u1I2YSOGmDdW02R80GuTYVneemvTTuttzKWBe/dz7Y6jKGtUahIxy55fDIlpcoEc5Kg+kIS51sa6GIVuNR7FJidRcuz3IINY7hGDcL2eIZIRnUuWVJW5+Db6Hz/JJmD/3YggDBCCd1L5dQArXQGlI7R04w3399wgfEODFkCg8n//Ly6Nb6q61qvXQYYxe4MdSecxJop2oO1fgOdwsaTuojIitSE/ZPETaLG+vdx9z/YjSkZAtQT0BOq+9uQWJaTXdAvjbXNFkabCRzu/moMn9WK+idhMqDxxBpftIZY2O7q6qjuptDgOENUahqwGjKMA1R+p8HyGWoKq9Byiqa2JmvsSBeeNycz0A7uUOPwObxqDOVSYQGRAXODMySmwcCti35U9WucrBmzuMR0s/mXc81fOqJAl5UWZEAjOdo8YTxuVOaDUKeda4DReelXJSLi53n6bQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB10221.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(1590799021)(186009)(451199024)(1800799009)(52536014)(5660300002)(4744005)(2906002)(4326008)(38100700002)(38070700005)(41300700001)(8676002)(8936002)(82960400001)(316002)(66446008)(66476007)(66556008)(66946007)(76116006)(6916009)(54906003)(64756008)(33656002)(86362001)(85182001)(55016003)(26005)(107886003)(1580799018)(7696005)(6506007)(71200400001)(478600001)(9686003)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zzk0NlpybDdlSGcvWGFnUDV0amhWdmlZS2RDNnlDSXliQnRzV0FqZVAwWHcw?=
 =?utf-8?B?Q245T0UvWU15cXdGZXRhbjBiZzRVR1Rma3lRSThEeFNHMmV5TTRWTEtuVXN5?=
 =?utf-8?B?N3VzQWloaDQrU0JseGQxcTFmZytSM2lDUGZuQUZ4ODdvMm1McnMzRjUyaU8v?=
 =?utf-8?B?cnRyMzlGOVNNNHpsdi9ZNnlWQUZhdmRNWGFIS0hTb0p0cS9oRUZtRzViT3VV?=
 =?utf-8?B?T3JRVUZiZlk0c2ZNL25uS3VUdkJhaHZtU3pnOG55V2ZZOUhHTDNLVVlWeW5a?=
 =?utf-8?B?blRRZUE1L1ZoT1l1VEV0WklFYjJWblpmU1drQVd4ZUlzR3JIMitwcElJNk9S?=
 =?utf-8?B?VDJLdGs2N0F6bS9La2YyaVg3VXY1b2RnTEFFWGlJZjhzRGNZbFpoL3JaK3pX?=
 =?utf-8?B?NWxnU0xUYTZGa1FyNEM1amVFQ2dHbHpJcEYxMUt4aGpGbWZHNW9DOGkvNnJ6?=
 =?utf-8?B?dk1samtMa0RBeWR3ZnNDVkFwVTFvNEpJcTlwcU1xdzdTbW5OWDRXbkpxWEl6?=
 =?utf-8?B?ZWFDSlJSaGh5S0JaMUJvc0hGa2hrTzRZVlhxR1hpUHJzd2dvaStlZmFxTTBy?=
 =?utf-8?B?N2xMeVVhcmlIc0NFbStuRlkwUWtFQ0VnMWpJWWU0ME5raU5zd29qOHYvZGxB?=
 =?utf-8?B?SkxBWSsyU2UzWmdxRkk2NzJTdTkrdjNqenZtSXBDRE01VURSUTZMUWoxYW9Y?=
 =?utf-8?B?T3BiRldJbVovQnBoeWlyajBxUTVGdGVjMEhzMVlZckJ4ZWpwSVFJemlJMy9u?=
 =?utf-8?B?SGU1dVNvWnZRT2QzdHJta0ZLZTZNV3JWR2M0RmJ2eFpnYm40dnJGOVQyK0tS?=
 =?utf-8?B?U1VzK0xsOVZqTzBSR2RXbzd0Z2czOWxKMCtTcHZ2QW9LbzM4YTJTUmFUZ09F?=
 =?utf-8?B?dEVDR3Q1UlJreEpmU3BVRnFaMGV5MFZNVWszOVF4eDlLeXBsSUVsNmNWWUZn?=
 =?utf-8?B?MVI2Qkc4ZUtPS1lDQjVPS2h2M0RTc29TalQ1dEgzbGk5QlVpTmRScWlod0tk?=
 =?utf-8?B?QTUwWkpTaW9ZMjR1UEhrS1hYZ0FldVh1QTVHQ1NNaE5sNVpvQjZsNE5xaEhk?=
 =?utf-8?B?eG04MzNWUEkwM29qMlc3VmVKT0xlWWtkTjJCV0Y5MlpVcDJ5WENNQ25oYjRn?=
 =?utf-8?B?MXQ5MmM2R3RZNlNQUDh6K1hqL2RYSnR2UHVpY1M3aDRtN3FBaDZ3TGwwSkQ0?=
 =?utf-8?B?eTNKSDVMZ21KMW1aUmFpZDJSVXY4NEREUHBzUk1WQ2wyRHYybmdFNzZFUFFq?=
 =?utf-8?B?ck5Zc25odUxjQjh0L1hqT0RpalRSVDhVbU9Ib0l3ZWRIcFA5Rk9aUVpoQnI1?=
 =?utf-8?B?WWxxV08vMFcwc2VmMTQ3OTEwblN3bnlQUnpabmVaam84SGhGT0JmV2JyUmgv?=
 =?utf-8?B?WlBQS1l6VjFRc1pmeW90SlhrVXVkM3ltYmVUaVBhdmFvbmp0QUFCY3dEVWJD?=
 =?utf-8?B?ajl6VGluWCtpR0VsdklrcTgzNlk5cTU5bXBHU04xcmhHb0pBZUZTZERpS3N0?=
 =?utf-8?B?ZURVWlNlVlFSZEYwL3JyeHJpcy9TbDZ0QkNyZXBuSGZLS1M3d2p0SjU3RElX?=
 =?utf-8?B?Z3E4bWZlWHkzcWJtSHRJVlBndDRyL1VYYTY5am1VMlRHT1lROEd6UkFMUmFM?=
 =?utf-8?B?bk41NW5uTFVEaHFCVEVVUlhlWms4K1RPSHpJY1VoMW9qYVdOT3pYdGNUSDZu?=
 =?utf-8?B?VTVXaDBMc3ZJeTR1WkRJalpXT25UUGNNOVVqRVRROE9MYmVaN1YvVUZHYS84?=
 =?utf-8?B?QWhLNHNpc05TSXMyazRoTVRTcmhEZFp3VlNwN2FVcisrQXB4aDBCWHViSGFX?=
 =?utf-8?B?bkJYNzdBOXFEYlIycjUxVGsva0lwRnJFUkFKRDh6UVF2dU1vTmE5bDVzVk1O?=
 =?utf-8?B?d2NiZnpxT0VPVDF3VEZzM1JmTVBlS3M2bzdZb2tCYWVxdlpyVWdMOFNTTFl3?=
 =?utf-8?B?bmwzaTZGWW1HZlNKblQ3MHhuV0gvNW1hWENsdXF4N3lnTjRVNGI4ZW1IbG1r?=
 =?utf-8?B?MjFlS0E0UkVxVmtTODc2ZG9vVFR2OXZQa2ExeGFCK3FyYUxPdU8vdDErTTcw?=
 =?utf-8?B?UHVCOTBhK0dqMXdUYUZadzNka1F2b0ZFTnYxRjd0YVNUbk5IcHdCZVZCNWpX?=
 =?utf-8?Q?zTAIGQ7EJKzEXuulUsiZBKcWH?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aq3pF2KaDTwGk6VVjEUtRhlClNYrxgMW65KUOFe2myRjQKr6O8NAUrsg4iBOo8DI9orhdktz+s06Qf+buSmgN/6QTiJdNNNnC4ChbEEnZ63kPPUddPI9lVtibAQCuI+nCwqLda6JrHD59cVbU+ArbJE2ZjZUB9/odt0A5rbYYmY/BhDC/HR9OcpmRzvO43CNuuTriN7tiCCvVu++zWLcMgsx6ohzalOXbkiMhyipJWNkOUlmGgZ96WbuGHvih1pCBGrDKwxKnYxvTjNhNemdy0mnvFQ63HXKyHHR1FW8cQ980fbHS3sd9bFS7/atMod27RzkssW6P/y4CliTwwKH7KPbyVT8GDblwCxayugHIJKn1ZnzHDIjmngjfp5+hWteSnTSWP0nDgrKtmOEuZLaR8oIIAl3/1hEXTHhvdSm2S/i+kMBLIuQqbURY+/gjcd6+CFAdXHbuNc1cRT6NidaVb76umd+dpnOfgI7lUMvfv2GixX4w32Nyjvn5NYCO/V7kFj2CdcdCdgDL3ysHUutd2fSsBX/24C8cMlWupRw175Qah6hgCghchJhVnMvOocRK6tCFm+C/KBCk0lazYiLOGyBoXYsJm63fPb+CJmzryiuoHyTmmB5YUM8nBTNV0yAWY8Inh2QgxCD+2ycGbZCKqcDwwXmrfaAYAQ45bOy6ynDPEOsE+ADqgscUUw7t8lGeuHPv3kjrugO1ChzUvaTukWRNG0NL25vgsoMalS/3HB9hCdXM+JKTZ8oo9ATYEeFBA6IMmVyfcOiQxzMvKqN5oNpPhLKSxFkUDWCUBvfhoMKdAT+u1y57gaVwfw4JAJV
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10221.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445e0eb5-cbe1-4fb7-acf4-08dbba70ac9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 07:02:09.7572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fz+zcq3tc0yJ5LXe3UXW+jF0bit5DLRCfv7MdchNA+4JBayBiqJOzRl2OYZlJv+05UhV3iU8SaDniEcjFfcpGkx5wY/+LsMrAMRECH3yJP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11453
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/renameat: Remove renameat fallback
 definition
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

Thanks for your review.

>Yang asked [1] also for removing entry in include/lapi/syscalls/aarch64.in and others, but I think we should keep it there.

Of course, we should ensure user still can use different variants to test function ie use glibc call or syscall(syscall_number) when they have
special aims , so I only remove these old fallback and not remove syscall number in ltp lapi/syscalls/*.in file.

Especially, these syscalls/*in files should be consistent with these libc header in file as far as possible IMO.

>I'd definitely keep this till the release, but then it should be safe to remove this old fallback.
This sounds great.

Best Regards
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
