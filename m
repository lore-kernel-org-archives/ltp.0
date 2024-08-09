Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED47C52D71
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 07:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1723188989; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=6/CGWEzF1Nv4Z9Dah+KGk10QatDZY/wP29t8eHmdDTc=;
 b=b16S//UiPG8B+6pYQeUNKQtd1yj7WQ8vgE6VNJx9e5chIqGcTfDD/6uzoAxPcySn6Xx29
 6bG+2l1U3XGWi+bq0m/zM6I0F8/khrEdzqOjYyUdMRrJNdz4vunQ1/cZ3lnVC6a95bat/9/
 oAX0GMve2XKt+oiXkXNNi7QCjnMkp44=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFA223D20B6
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 09:36:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DE4B3D0F30
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 09:36:05 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.151.212;
 helo=esa3.fujitsucc.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B1D571A0092F
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 09:36:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1723188964; x=1754724964;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FzH96yylC7DIIpb7BKG6eH+b6+/z3d5mCas57ggEMyE=;
 b=ueGrV+lK7KOuN82PYSCAKUTL7V/BV+WB+LPf+QORMq6nSxPDXxGA6aHv
 xOXW4HhHuISLMCtgsouLpA9TbrVJAXzN01743hBtFA3haE2MbIhaQVswF
 JEbPCg7VtyOgx9ILuDKxabgxOUvL/II1zHqYPN/2GynQXy7xSV47o2vyI
 l8P90/07PuiRrROx+Cd3TCxBI1asIXSKMAUnu763Ul1gKH3neJ4nwfp9t
 1y8g4YhQ4oM0vqOjWHmA69HzUMm/bMInOKmRrPegGgnHU5hM+zBLbFc1h
 nKGa6auv3P8AT2cHQyun02xLBLRSnXkkGwPkr0/+w4xEpj5NuE4px5jb3 A==;
X-CSE-ConnectionGUID: dFcnSoCkQ+KTZ4HPq614YQ==
X-CSE-MsgGUID: 9+R3h98CSQ6hJkWCHjwUyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38905426"
X-IronPort-AV: E=Sophos;i="6.09,275,1716217200"; d="scan'208";a="38905426"
Received: from mail-japanwestazlp17010005.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.5])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2024 16:36:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=il22EEm2T4VpG5D0cEZnPZUuG90t5A/H55B6alH4Hb2DflcNigsMFEp3Fqwq5H10gYxm4ZdwPV2K2j+yqWhIBRPPO0jszMM2p/sz/SBgU4usrkxON9HdivDsUEUIneWupI5nIZjZDSlPhDoYCI6fnEMG53UlN9w+zeV9+Glbelt3kQSeGMI2TiSqJxipzI5ZrlZJ5tIfm73aNbV+xJDzyGDuOWR27eSZLIl3VY3DBUMigfRlWnuiSjyw9EkPpz2Puw22jOUUIpiRVOfKx4PkRp9s7koq5vjJTCLWO/e+NLflW8lMBggyes9Sxvt9AxYswk5ICSAOiPr9bPbbsxuxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzH96yylC7DIIpb7BKG6eH+b6+/z3d5mCas57ggEMyE=;
 b=qbV1VJoHlqarJ8uAkxC0ovOA7Sk2MJpJeNgU2wG84SFKL/SS9NYb2L1Qc0axAc9yzQjxB1xvrQ97URP+6ymonj+qBk5Hd8BsIf9JS2BRz7lRcupiPNgMY4VO++ngZLeZ76rtU45PlFQMSBrvylpfo8dHJXVlTwn4BeuTa8685kGiK+to4wOWHJ60HDqedvxtj0btQYyawZ4QhKuTCwgvyq8xZbN3/U0zq8ayOjnTZelFCkdEyP0TjiF+D8Bpc23kuguKK1Qjja9Lyq0CEZJvnsGeJqA6gtYucXa68Kuz3TrfoGoMs/L5n4t3EkXaPgVvWCwJKYbRNyjlyaqxXdEqKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 (2603:1096:400:3cc::12) by TYYPR01MB12545.jpnprd01.prod.outlook.com
 (2603:1096:405:199::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 07:35:59 +0000
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9]) by TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9%5]) with mapi id 15.20.7849.013; Fri, 9 Aug 2024
 07:35:59 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] cgroup_fj_common.sh: Do not disable systemd
 related cgroup subsystems
Thread-Index: AQHa5LTRpgvxU0LONke7lTqqZn6hi7IdIleAgAFwntA=
Date: Fri, 9 Aug 2024 07:35:59 +0000
Message-ID: <TY3PR01MB120710C5B03042917795A3936E8BA2@TY3PR01MB12071.jpnprd01.prod.outlook.com>
References: <20240802082220.890830-1-maxj.fnst@fujitsu.com>
 <20240808093225.GA325801@pevik>
In-Reply-To: <20240808093225.GA325801@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZTc4ZDZiZWMtNTdkMS00ZjcxLWFjMjYtNjZkNTgxOTU2?=
 =?utf-8?B?Y2I5O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA4LTA5VDA3OjMyOjUyWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB12071:EE_|TYYPR01MB12545:EE_
x-ms-office365-filtering-correlation-id: 524fb140-bb20-4a74-dc3b-08dcb845e9e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?VlRwZ2s0WkJKRDl5T1hlVGZMTGVHVHZjQWZIcFFiUVc5WGEycGt0YlNLY0NW?=
 =?utf-8?B?WjYzLzZrb1pzdmdZQ2EvRWd0cHQrWmNqWXZoc3lITzRHalp1eXRTU1RrNzhP?=
 =?utf-8?B?QjNQdjBYbVFSZVdkWUhnRlI3VkRMV3BqTG42WDY3MWxvV04vdENCRklZc0xB?=
 =?utf-8?B?cWpweWg1WWNPM3FuVGF0bGNFQUdwYnoycDlCUjlVTG5XQ0pPYXVXcHZycGVa?=
 =?utf-8?B?S3czNVhlK0IwSUdid2lIUUk1c1pnc01oV3R2MXZHN3phRGFKckhvbWNJaTZq?=
 =?utf-8?B?cnFZSkZYUGMzcW5sNjkzMUh3OHZkVUVIVFJ1TDMvWWZ2T3JZK2R6VnZSUkRx?=
 =?utf-8?B?aWRhcDhHalByWWowTDQ3bmRFWWZ4UndnSzJ0d0NCRmhSWlc1a1E1WlpIeU5h?=
 =?utf-8?B?eTJTblNuMEFnWlpSZmo2ZFhLaXhmMlZqNnJLcG95SmZQT3VyTnpFeGhlMHJQ?=
 =?utf-8?B?RDVYWlh6WlExTU5HaXhoMVJKMFhkZmpVNmRhajdpbVJNcFdhVCtsZW5MbjV2?=
 =?utf-8?B?NUlXU00veGltaWhNeVhFejl6QXpnWTl0c2NkdXF2Yzg1dlB4c2wyZEhuK3ZR?=
 =?utf-8?B?M1FTR2JtczlWc3FQTHJ3QXVUZG9rUlZHUzJBSWdGbGZFaUcyc20vaDMrZXZS?=
 =?utf-8?B?N3lUakVDbDZrRk8renlWQzR3QW1ja0pwRy9xL1ZYNXJXK2xFV1ViOHkvZTVQ?=
 =?utf-8?B?M3BacVVndXdJSE5UczRvS0VZWDJtczFaWUUvQlJWdm5GK3VlVnVTTC9jY3g5?=
 =?utf-8?B?WVBzUGFZMjJRK1NrZ0llYWR1eFN3TVZRT0h0ZmtQK3Mva2hGOStlSHN0aUww?=
 =?utf-8?B?ZlllbWhpWnNNc0x2VDdMczI5MzBKbTNRUUh3WlhSQW4yR1JHdGdpRElORTZq?=
 =?utf-8?B?TzZrLzkvYkRNOWliSllHNlVBMWMzeWpEbVMrajMxaVJhMDV6QXFiS1M2S2Vi?=
 =?utf-8?B?NERocjdvc2lVZ3hVSWJLVHZRQzhhc3NEMzVHNmV2Yno1dmVtR3dMNm1mMWt2?=
 =?utf-8?B?eDJ1SCt6c3gxbXVOejVvR3NtdlFsRXFmRy81TUNoSkxyOUpUbjNkeEJKakhE?=
 =?utf-8?B?Y1k2aWhVaFMvSERFQUR2bUM3Z0RHcUFpd2w0UDJRc2JIMm5vb1dsQVhtT2JK?=
 =?utf-8?B?b2Y2OE9sZEJBZDZxU0ZCbWlYeHQ2aEJBZFBPd3g1WFhGZXA2bG42UGE3QkpB?=
 =?utf-8?B?bytBOHEzRGdTSkdLTHB3UmM5cUNxUkN1eEorYUFUMUd1ZU1Gd3ZMeU42c3FG?=
 =?utf-8?B?Q2d2SXc3WDl6anp4eWloWSsxTHJTR3FrcHhreU1aSWhDd3YvaTk0cy9JTzZN?=
 =?utf-8?B?UW15c2JVU0VZV2RJTzQ5UFdmZGlDM1RvOFV1WUQ1ckE5YUoyNmpEQnAvQmN3?=
 =?utf-8?B?bW4zRk01VVFpK0hGVVMraFdPWElCaTB3MTRJTkdUK2FmNDZvL2c3S3hhV1dL?=
 =?utf-8?B?OW9nTTIvMzZZSDhGeHoxQUg0NDJUQkRwSDZkQjcvSXJpWnV5WmV4MFFPQjZh?=
 =?utf-8?B?ckZUcUNBTjJMblVLYk1zSlBsZU8za0JUYVoxWldPZktYV3hmQno3NEl6S1J6?=
 =?utf-8?B?Ym9DRU1mYW8rNTJNa3R1NXJCZjJKem9od2RzN2JSRmpQRk9Gb2U5bTNLbWQ0?=
 =?utf-8?B?emtnTGx0UHluYW8xUWJ1R2dia1VYYkVrZUZkeStHaTNXVi9hbDdPcUJSMmJo?=
 =?utf-8?B?WVUxL2QzWGdLZnRmWmcrQ2ZiV1NvSm00VmtDZEpSblZ0M2xKNW5VZnJlWlV5?=
 =?utf-8?B?MnoyWW9kdDRoTHhhRFovVmEyNG1QWUpHMGE1citINEtZc3FmRHFQRG85enNn?=
 =?utf-8?B?WDhWRml4Rk56U1dreVNvcmcrZVA1QlJkcExNK2NuNGxYWTdKNnJFU0laZDlO?=
 =?utf-8?B?eGJ0TnhnYlFtb0xZSExKK3VTSThJanowdmJxbGNxak9meXVNWm9uMm8vL2Ry?=
 =?utf-8?Q?wV2RD0qbSM8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB12071.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M25CMm40QzdoOXNXWW1oRDZ4TTlXYVRibzE5dTZtU0lmalR2UTRNNVNQK05i?=
 =?utf-8?B?ZVFJNWpRNXYrV2JUYytURTl3SnpGTEd3cS9vb1lVZEI0SGtFT3BaN0pYa0Y2?=
 =?utf-8?B?VHFiUi9BMExXOTVpT21DTnRhTWg2WlRTUE92QUhtZnZjVDFUQ0FtTGlMVWg4?=
 =?utf-8?B?MEJON21XRkJHUEZVT0Y1d0hCckJzaHpEMzNuNjJZcUhRTmIxMnRDSjhrNEdE?=
 =?utf-8?B?NkVocU5EdTZPdkY2VDN4UnFoL2hkbU9BakxRZzExYXRoZ3dFWVc4TVV1aDFG?=
 =?utf-8?B?ei91UEw5V3lqYkcwYkl4a1BpdWlUTWpsQTkzL0pUWXl1UmJ6bCt3NmZ2d2l5?=
 =?utf-8?B?NHNYRHNVWWNjYjB2Vy9ETlFtVEZBS3pWZzYyL2JZN1gyK3dubjMvZk8raUw1?=
 =?utf-8?B?eDRrSlFPZC9VMGZkNnpSb2lFMk5qRXJWT09DSDVjVkdpMXUwa3pjR25INjF2?=
 =?utf-8?B?dFZpb0pCU0lkMFdTTnJBVjljTFU3UmJSUDFpemd1NDZOeVBCZldRMXgwZjVt?=
 =?utf-8?B?WlFYdUo4a1VVb09aakpza0NJUmJjMDZObEZubjVEU1JjSktBcDlrVzI4NUl5?=
 =?utf-8?B?c2FrNkF1Y0ZSaGR6WDBodDVuQzN3eHZIUktBc2Z4VFVUazhEMThjMlROQlFE?=
 =?utf-8?B?YndFbmhYOFRRMVlQVGQ4UHBjS01PcmxFL09KVHliL0tvYlpOcUxGWHRKello?=
 =?utf-8?B?c3E1S2x0eTRIbGhTUEpyLzBGQ3BRZkhiVWxUTmZaTXVFMUlsenhHUWVCZ3BM?=
 =?utf-8?B?YVIraTZYbCtaMnkwaWdJak5OMDI5QUFxUUl3OVduTmN0TU16S3RxQ2Vaam5U?=
 =?utf-8?B?SjRTSmVWWnFIcFNUOVNDNUdENytSd1BrMWJhVTZ6NWtqUGc1UG9jSDkrNXVU?=
 =?utf-8?B?OWthcU1KcUp4cCtZWUROUEc5T2k4Sm1SSUpFSjRGSmMxSjBiZGNnZ3Fia3Z5?=
 =?utf-8?B?aUl6aVJMQ2RTYVBZcTEzTXk5ZHZOSGRnLys4ZDUvK2hjWDV5VWUwQ0JEUzg2?=
 =?utf-8?B?WnZ6emFPSXBaVnlpK2lFdFVSeitjVFdSVlRGdXdIdzRJV1FNUDYrY3FGVm1k?=
 =?utf-8?B?Q0xNQS9VTEduMWd6T3RDR25FZG1sUGZCd0xCRlhzYWdyOUF6QXdWUThyd3V2?=
 =?utf-8?B?NFRDcUliejA3aEdzZGJNdHNYYjNZbEdacXVvZk1QZGRiK214Y056MWhITExD?=
 =?utf-8?B?SGFIeXNTNkpvZmxOaFc4WVZtaGFldTNLY3diYkVWbDdjRC9JSFdRd1l1U1Vz?=
 =?utf-8?B?MTc4N0hqVS9XUnVwSGE4ZUVsVnVoaVJaWFY2a2ZXYnBhUDd1dm0wRFJNVWJP?=
 =?utf-8?B?S0x2OG02MTZWTXZiZVgrNkUyMUpZSTN1VXl2cU9STnpQZHFLR1k0b2I4Qk1W?=
 =?utf-8?B?Rnp1bUJXRWFtbkRQOXg5K0IzOXBiVkRNay9tSkUwUjJtN3lkV0o5dFNJSnBV?=
 =?utf-8?B?VUJjdFFFM1lBbkswa0JqM2c2UEhrb1gzcG40ZzNvZmV3dklLUzgwWkxBdFBH?=
 =?utf-8?B?VU1PVCtGbWlBenZnNm1WZTlWUExpcHJiZW9EZjFsTmJUL0UrbmZHTzV4WURh?=
 =?utf-8?B?cjBwRnM2LzhqZTljTmxhZHFqZkMzU1NyQ2ljUEg0THVUcU1NUnplOURiU1RH?=
 =?utf-8?B?cy80SGlYT0tPVW42V3ZUWU5ncjhOK0c1TDNGUVhJZVh5ZzNVc3JESE5FdG1S?=
 =?utf-8?B?SzhESnZKb3dIcEpyZm94WGV6VHFPbE1samozMmxrRTdxOWlCL1krb3NaV0dL?=
 =?utf-8?B?Z3lvVlFyZUZxMnpnQXRIMTV3WFl0eXVYQWt1N1IrTkdsMmtHaGtreGJmSHVs?=
 =?utf-8?B?SEowQjA0ZU9TWVpzaFV1dFNqczZObjM5bjc0eTNucWQ2dFlFYUNlb1AvNjhH?=
 =?utf-8?B?bXYzK3lIUm4zdlhiakErSXpER3hsc0crWUVyak1YMFR1VVM1WWt0T2xyMFJD?=
 =?utf-8?B?ays5czZ3UWd6cTNTYzhyTVA0UW1pUmljVFZ4K3JvR3E4dksvQ2Y5a2VKaVlp?=
 =?utf-8?B?TjlpZVd6OGxHUUhkdWtCR0RMQWhlU3Y0N0RBWlVHc2JlZmdxb21QVDVTTWN6?=
 =?utf-8?B?cXJLVE1EKzZGRGkxV3ZkT1hMTGVQcW9JbWU3WEtvNmN4M0FvN3UwYkpzTWpN?=
 =?utf-8?Q?xSDnFyU9+aME+E48VuV067OUT?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ICSiIW7dzeY7XXZqoFuDCsI8uAOClIVf7yJrWjXIN1cOuOoAI/YhAn3FoPQSTG59OwkiHYRYdSARwZZpnkhNMzPcbaSe0x0JUriWuSMR8N22w6rd9yCyZ3u5pLUVvTrGxqHkXYuWl+06zD1ENGPYXODL1uuP2B3GiuS7jgqWYn3jd0NhJRhx0Vs2P8iL9K+DGZgy5YJsidkbuVRAtqtv6WG0LAwPfNPVSP9hhf0fWeNqMYG6B0q+OTRFnL7/cJjoE3uv2MprxEZqrq7SXhzXRqNe9geHo4NHO8DkfoLJtP8yz7QOOcvPbfkOoBTvILSP12ZASmzVPEVe7z4Xl37zPlDXKi2qwe4f4CuCLFTrWNWmKBAQO4tIqEJl1Wsdup9WuMxdLThNjG0P04R3yrNEhUbyX6fSgRVo2VADgClZY+zkHDP1i/6B5wb3FAy3QI5wp9i02US7W/Lx3RdvvxkJ9jCK0Xre0DmS1hlnexWUh4+zhM2sCTf+TMwSGXiFjDKBagJyoC7FTSof5dxzG3v1mN4dM3zQuqJrkp1VAA+HMm6zGBp/fQUKdKSBnkGF5l1sH4OHK5zVq27grxZ8GRSih0gAwCjTnI4gWF6yxLtrRS3xYK+GYhOQ2lTHTCXSFn/H
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB12071.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524fb140-bb20-4a74-dc3b-08dcb845e9e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 07:35:59.6022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQ8cr8oda/UHrfufUN+1rdEHWjTcwb8ifjnfFl54s3eMAHmEdf8e/D3dvETt+RWw6B4V9oeK799G7kPorihoRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12545
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup_fj_common.sh: Do not disable systemd
 related cgroup subsystems
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
From: "Xinjian Ma \(Fujitsu\) via ltp" <ltp@lists.linux.it>
Reply-To: "Xinjian Ma \(Fujitsu\)" <maxj.fnst@fujitsu.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Ma,
> 
> > The cpu, io, memory, and pids subsystems under the root cgroup cannot
> > be disabled because they are used for systemd. Currently, the test of
> > cpu and memory subsystems in cgroup_fj_function.sh and
> > cgroup_fj_stress.sh will report the error
> > "echo: write error: device or resource busy".
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> > -    [ "$cgroup_version" = "2" ] && ROD echo "-$subsystem" \>
> "/sys/fs/cgroup/cgroup.subtree_control"
> > +    if [ "$cgroup_version" = "2" ] && [ "$subsystem" != "cpu" ] &&
> [ "$subsystem" != "io" ] \
> > +            && [ "$subsystem" != "memory" ] && [ "$subsystem" !=
> "pids" ]; then
> > +            ROD echo "-$subsystem" \>
> "/sys/fs/cgroup/cgroup.subtree_control"
> > +    fi
> 
> I would personally wrote it as:
> 
>     if [ "$cgroup_version" = "2" ]; then
> 		case "$subsystem" in
> 			cpu|io|memory|pid)
> 				:;;
> 			*) ROD echo "-$subsystem" \>
> "/sys/fs/cgroup/cgroup.subtree_control";;
> 		esac
>     fi
Hi Petr

Thanks for the code optimization. It looks much simpler.
I have submitted [PATCH v2], PTAL.

Best regards,
Ma
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
