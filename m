Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE325C021B2
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 09:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740044407; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=sYUE4th8PGTcn1M7Mc3Pi9A3OV7GALEwzPFNuZal+qQ=;
 b=QcA1uu2wUbDHzL8cbjfdHsAVLBnm84TCfuVfQHArH/mlZr5GM9WF5NQph3mO4hYqK7Jl5
 6FdQTXzLcKjRvpdgRexXY1aS5mqDhiD4JTsOqvzKudzW4y8ETkpN6XAMCiL1A/mcXkm/WPr
 qjCn9er9kwLKj/T/rkYLypXvISV2El0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 480813C65B9
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 10:40:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9499C3C050F
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 10:39:44 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=216.71.158.65;
 helo=esa20.fujitsucc.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9040B14057D8
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 10:39:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1740044383; x=1771580383;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=Np+om1sWaJsT//VPMMCr0beE6yxuqKvJKxA1pVXkSUU=;
 b=Du/mf+GHDqKg4U08G4BUIHEWMpk1p0Rz34Qhzcy6rbWd+rYcz1r+KiXe
 BzG4RNP+3ERjGwrbgkA1j6kxmyu3aMDTZh80tjoEQtTODCNz5FrwCRTkB
 cskvEK0FI5uLSRTt28JbQjZrnM5z6nxZeACAuVhp+fYMmYJjs4ZQbFkPz
 3Lo9ZKtPg7UXPvJZqDbS93ka6SgfZctXOwv/4tdGHI3CpEu0WNjOSeFEZ
 5UiJMIyZUPz7yuZJ6dAnHYSK3ra27GZERRhxYgHqELPHwDI5PyZnX3Dpf
 DcbUuquOWK7n6Das+NyJyZs811xw44C7OLMSE9M9H+03uh5GTNDmekKMn g==;
X-CSE-ConnectionGUID: RzhoYaJdTWGB+rHqGLxSGg==
X-CSE-MsgGUID: 6Z18SgqQRkGd9McOJGGNzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="146842073"
X-IronPort-AV: E=Sophos;i="6.13,301,1732546800"; 
 d="scan'208,217";a="146842073"
Received: from mail-japanwestazlp17010001.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.1])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 18:39:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPV8narKl7uYlkbMY5PpmQAToItHIi0vsscGpbsnMbWqKUpz5NBygWyY9RcbEhgmnANkH2PQv+vYaicH3HP/eOZiH8P30vMxrdMw1/9Q23TATbwz7rJpdGynLCeh2DlAfo9o+sTK4Rro/yC3xFRGHkaL+k1SmpAGkm4lQxg1/xtLPlKXD7hr+klOxa+w+QY576KNLgWe2mxlIl4krShpQubW77fAAvRjoSTexn2KzWpVjzdy27sWnDKMv5jrubQFVC171LtNPZiYSl7maiJRxaLNzuIizQWMkqTMvKAGT3YgeZXaBgrK8mEjVZSTyBYueknN+I+CtLW1MZYk3zV4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Np+om1sWaJsT//VPMMCr0beE6yxuqKvJKxA1pVXkSUU=;
 b=XLLtG72GwVZIA6eW0QYTxXItGDQCBaP0cduyG/zPYAko5gyJx72xWm5VhB3m4u7j+zlZUfsTP+6Ykiykpt/tzR7L1MlaFyYYguDZC/E2vo01XjLUpqlRWUpJg+EgRGlojWOZaFKhv7IxiegHVgo2nXbz3b6Sj9sQTi7FeFMR4gYK+1af4cMLg50D5tnq/Ex/WQYv5KhiBAxGWH1jTHDdPcql4UwiDb7NsBp8zr4xVEZahOFFzSwlnhM9E0whUpajHaBcyFmXpM1ytTtoLgdGCywYpsLPErMRo1nTzpNcXJtZQ+yihFeVWwWygixT4lr5S1IwXCQNJt/r1t6KTKgicQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 (2603:1096:400:3cc::12) by OSOPR01MB12393.jpnprd01.prod.outlook.com
 (2603:1096:604:2db::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 09:39:34 +0000
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9]) by TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9%7]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 09:39:34 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] ioctl08: Fix comment indentation to fit RST format
Thread-Index: AQHbgrUgw+AUzzrZ7E6m7B6JwfSiV7NOcFOAgAEZufCAAEsygIAAHAeA
Date: Thu, 20 Feb 2025 09:39:34 +0000
Message-ID: <TY3PR01MB12071554D05FFE6ADC60A5C75E8C42@TY3PR01MB12071.jpnprd01.prod.outlook.com>
References: <20250219100027.1049238-1-maxj.fnst@fujitsu.com>
 <1d1bed1c-0537-47a8-ac68-1b108453e8c2@suse.com>
 <TY3PR01MB120711C04E10541E612CFFA55E8C42@TY3PR01MB12071.jpnprd01.prod.outlook.com>
 <2827355b-0e34-4db2-968e-cae1aa54ae0f@suse.com>
In-Reply-To: <2827355b-0e34-4db2-968e-cae1aa54ae0f@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9MjFlMTI4ODktNGY0MC00YTk0LThiOTgtNTdlYzQ2NTdk?=
 =?utf-8?B?YjI4O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTAyLTIwVDA5OjM1OjQxWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?B?ODFlMS00ODU4LWE5ZDgtNzM2ZTI2N2ZkNGM3O01TSVBfTGFiZWxfMWU5MmVm?=
 =?utf-8?B?NzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX1RhZz0xMCwgMCwgMSwg?=
 =?utf-8?Q?1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB12071:EE_|OSOPR01MB12393:EE_
x-ms-office365-filtering-correlation-id: 445508d5-866a-4231-0c1a-08dd51927be2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|1580799027|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SjhURm9CR1NGSDhUUFh5MTJTSGtwSlJpWUdDNDMzQmRDWkU3aVhZV0J0aFZ0?=
 =?utf-8?B?emUvNklWMjBSSEs0QmtJOExDbElaVzVMWEU5K0czUUtJc3VpMlFUQmtib3Nw?=
 =?utf-8?B?dVp3YmduNTlSQVZGZ25Sa2VsRWVRWjg3N2lDUVNaTTVRTnFWd1l4TU1wV3FG?=
 =?utf-8?B?ZUQ2a2NvMXAvNDcwV25ZZVVNQUJVTUxuZytXZGlFUE1ETWJ4Y1pzSGVVanpT?=
 =?utf-8?B?ZFl0Y0ZlenF4aU4wdnA4YjArdlltYWkvQVAzRVVnZ3U1cGxDU1RYbFp3dVZp?=
 =?utf-8?B?cGNQcFhOejZ0WGc0VW5pZzQ2R0hTdndxZFdGZ0ZSZ3A3ZUdzbE9QbWp5cTY5?=
 =?utf-8?B?aFM5YmNTRGFVWi9XTytseWQ1K2RmRXlDYjJXdVlZcS9wRlV3WVVRb09zaG1z?=
 =?utf-8?B?SjN4aEMyc2VjZTJQLzUyR0F1TVczbjdhRFRTS241YTgrTXRUR3V1ajV5N3F3?=
 =?utf-8?B?aG9RcFhNbDFVdmRuNHRPYjhpdjlHdDRXSXlld24rejUyZE5kZVZUdjZuREVZ?=
 =?utf-8?B?U3JGQjBlRGZaVXFTQ281WHN1OTE4UEdodWNFY1pqaml5aVJqdWNoM253Yld2?=
 =?utf-8?B?TktEVDUwdmNzcWFjWjJaU2lIQ01UL2ZHQ0ZFZ1licFRMZ1d0Y0hjNUpVTElW?=
 =?utf-8?B?MitvdjQxREhYZUF0RHQ4VFRnK2o1VEpyTVpGdTN0VzhrbWtGcnNGcTcwajVr?=
 =?utf-8?B?V0NkU1JwQi9YQnFPbUJTZW9GaFBDakxHNEJxdTJ3cURaRUltL0JBaU1DcDJu?=
 =?utf-8?B?KzZtbTlIeDVSU3VaeStkVlIyaUgyUVVkZUoxbE90RmFGWGpNcTZab2dvUDRj?=
 =?utf-8?B?aHdZemk1L0ltNzlHNmc1bndlSk9ZN3NhYVpvSGVVQmwxTVNpSzEzUHhySnZX?=
 =?utf-8?B?ZGt2L0pjVDhXZC9yQk9haU5SMGo2dXA3cFVWQ0hDclBpSEkvMkxvRzBMdWxv?=
 =?utf-8?B?UEp2UWhYZTZrMlFXNW9RUkdBRW1IVGJJdnR1Y1lVdmhSOVYzaHlPRUxoWGZF?=
 =?utf-8?B?ZU9YRU9qSlIrTzk0Y2RGaHIyYU9SLzhrWWZ3Ty80ZmJxWXg4MzRyQnhacTUr?=
 =?utf-8?B?RjdJZUk1cXh1OUFhbmVTVHMvZ3pEY2g1K3VMREtuMDRTQ1BuU1lUakdnV0dv?=
 =?utf-8?B?Lzl4QXZybElwWFRtcUFTcUVnd2ZKNDN6ODdWdW96eUtyTm13ZWtHVmJWVzVU?=
 =?utf-8?B?OHFRZ0R6TDRudDVPZXhHZ2VUelVJQUdmdlpjQ01qeThvaUNuaElOdE4yMW1z?=
 =?utf-8?B?MEVxSHFrQlZNdVNqU0RseDQ1RjZ4bWZ5N2xEbUVhWHo0SENrMU1BOHJNWFUr?=
 =?utf-8?B?QSt6Q0tKRnZyV0xxbUpwcVBhSHBGUDllY2psV0Z0b2w2SzdhLzRMNjBPQzhC?=
 =?utf-8?B?bXhVcXBwWXpOQ2JZMjEzS2todHZJUVJOQ1VvcEpyN1dsODNyenZuM0dvVWZp?=
 =?utf-8?B?OHh1SFVUd1g3elJuQ3BvSS9JRWh3QkMyR1dEYmM2N1JqVTJQL3ZDNnpLMU11?=
 =?utf-8?B?dnRCaHJCL3RwWlR4dytwc1N6citGQ0NQTEJROHdmMkxVUEhMZXlHRkdrMFQ5?=
 =?utf-8?B?dExRTXZ5amdtWGZiYmEzYklyZkZCYjFCTzlzenRscjhxb2Rlb2JETDF2U3Fm?=
 =?utf-8?B?Z0xMNGs2aG1SSXVzT0wrTGxvL05SSmtabVdIb1ZKa3AxWlVEeGw1dFdWWEVM?=
 =?utf-8?B?RE0raGVPSk9MOXI5TXlsenBqZW1LWWM0TCtOYmpROGlFR3ZDNU1KdWdKWVlC?=
 =?utf-8?B?UjhEcGtBVkc3UVRrZDB2aWN6d0tWSnBUVFg1OTN0QWZzYytJZVN0cVdvZUg4?=
 =?utf-8?B?MExYcjBTRHZ2Nldqb0ltY2Q4ZGFYeFRVWmNkc0U3TmIvenNtRVdPYW8zY3BO?=
 =?utf-8?B?R1hOTzMzU2xISXhBcW5NS3JJcGpFNWx4UWlCaU1TMUhkUmpQZENpY2hycWlW?=
 =?utf-8?B?YXVSWmpyZ29jeFNHUzFsZEUyN2hiU2RaLzJFRThBUjB2U25vMkx6WGMya1F1?=
 =?utf-8?B?TDRjRTNCT3hRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TY3PR01MB12071.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnU3VTRTcFVRQi9UR3ZrQ201WHJHbVVLSGFUZXJFcjZiNlhHUHY5Mk1Oc3Iy?=
 =?utf-8?B?blh4L0YxMVl2ckFrNTZqWVlDVFZnRThEV1VwS09ib0JORlhDcFVwakNUU2Fm?=
 =?utf-8?B?bGxyUUlCVjF2cHppVkFSc2F3end3dHBUQktNV2ZTb0N3ZUI2NDNyWHhpaUNu?=
 =?utf-8?B?ay9UMG9YMm15VUVJNUM0aHVhNi8vZEo5WFh0MHkzeTNXMVArdWpvVjYxSjBX?=
 =?utf-8?B?a1YrNXBialZLYWthZTB4RklHVTN6QzZWZmQyRXhId1NTN3YyRkdGUXBWcnFP?=
 =?utf-8?B?N01Va2VmTmM4cHprdnNRZmNhY3ZtQXFPVnBjbjNFQWFiNUhRZEJsRFoyTEdp?=
 =?utf-8?B?cFpZV0hpay9oYUJuWDlnZEw1R3ZMajN2SHppQ1FOUG1uOGQ2bDYxd3FidEJJ?=
 =?utf-8?B?eUgyVHJ6bGNYVE8vN0pMOWUyNW1OWHhRRkFhM3hPOVpQdmt6NUk3bWdGUVBP?=
 =?utf-8?B?WVRYV0o2UWV3dE9lb1BmUmZPSEtCOWdpRTlWVmxNK1NaWU5BZjNYSVo2Nncv?=
 =?utf-8?B?SzFTVTdGSDBDWEhSZXhZckYwTEtlRXdDSnRoSmNXV2p3U0NTOXRQczZIcUVU?=
 =?utf-8?B?TTYwbVVNMDdCdS93cmRqUllJWjg3T1psNmxTMHU4bzZub1lyWTNxcjN2OWVU?=
 =?utf-8?B?dVZ5RVpYNGNQdTE1UDBpeCtvMFhXakNjZ0dzcXBTdWIwM0szWVY2NUtPVjc1?=
 =?utf-8?B?UktQK1hlVUFIZm9GN0lhSEduMmtid042UnJMcExvN3NRY0EzSm1sYkNEcTda?=
 =?utf-8?B?aFpvcGtSZUx2d0JzdVNIaVM3TmNlUGlpZy9HY2VlTWxRa2IwRitkakNoT1V3?=
 =?utf-8?B?Q2REWmF0bGUrQWtmSmRxVkJZUy9qaFZ2cGJYSzh5NTIwSkNFcUxCWWZsMGg1?=
 =?utf-8?B?b25ueXgrZkhqSjlsNWozRDhWZGhmTFF1dHk2ZXJ4MkFHbEpTM0o4MDdHWXQ4?=
 =?utf-8?B?eHp5TEdUYWhadWNQT2FaMDlncmJGWXY5UEswckZzb0FncldIY2VlNnNQK082?=
 =?utf-8?B?OTBMSldwYjYyWkR2SENnT2dtbzVPc2RKUHVRSnAxUjdidUgrWm9VMUlJYzhM?=
 =?utf-8?B?U05mdEI5WTNtZ1QyeG1YRjVvUU9pZ0VLam9WYUhPa00rUStZYmZ2YXcvZEp0?=
 =?utf-8?B?bFNRZ1JTbGNlTldaYUNqQWY1dUxTcC9GVEtsV2w4dEtGWHNtYy9IVFZmZ2lI?=
 =?utf-8?B?NnVsUVlLUGVGZ1Fpcnc2OSsvR1F4cUZSREJ3YUpHeEM2RlBvVys4d1daWVd6?=
 =?utf-8?B?N05sR2JhY0dDN1ZYUG1rZjA2b0hPQ2JIcndkelBuZFZBSGVCUEZmQ2xEanFZ?=
 =?utf-8?B?TkxpUVkzM1dtcTl5V3h5ZElDUW8xeWJmWXJNaTRrZTVvL1pMU1A4OE9tNkNF?=
 =?utf-8?B?VTZ6SXJoRVptckJabnY5U2huQ21RQWNBSGczVHJ4Zk90dFYyamlPeTgweHkx?=
 =?utf-8?B?SlFhU3FCc1BxTmJ3SmhrVGRlQ2MwRTBYVmg5Uzc0aUJKUnUxUGtSRTdOL0Zt?=
 =?utf-8?B?S0cwSmJ1eTVtUU9GdFFTSnNHOW1ncVJRNEQ3c25JN1VUbG9aUy93Tld5TlFm?=
 =?utf-8?B?Qnc1bEMyTXFFUm5rZzcrMDErd2UrM0kyQittRlhhbFM5NHMxVG1XMFZPTXl0?=
 =?utf-8?B?bVBoWkxVK1hGODhKQTJ6Sk4zYkFhS3VqdmJ1OXBBNWNEeFlWM3M3U0I3SGd5?=
 =?utf-8?B?dDlkYlhSOU9lRHhPeFljYWJKNVYrR2lhUURQMEdVamF4QUI2a1BuTm44RHcw?=
 =?utf-8?B?VUFuY3c5cXpzd2k1c3F2UkNFekcwbjJIenREMVRzZnhSdUxzbjRHYytsS2Zi?=
 =?utf-8?B?WkFEejU4Vnk2OHBqNmhtVFVuODZ4MGd1L1JiM0VnaXhvY0NVWnI2U3kvOGNR?=
 =?utf-8?B?THhrRG9WbG42SVZycG01N1JmWjA2MXJMaHo1TW9nTmd2dzVpR1hrVmxOcHk0?=
 =?utf-8?B?U2pKVWdMVGhPMTBKK0lvSWhMeVdrSGsxT1M2TEVIOFJ6TzYrNWN0SG05S1pE?=
 =?utf-8?B?cmowWlJaOCtWNkNIYW5Fd3hVL3dWZzFKaFk2UGtLdUcvSDE4czcrZm1YdUdU?=
 =?utf-8?B?WnFtSTJiMnNla2gvMytwNkt3Y0xkaTVqbkNFdnlEa0pWQ0JMMHJwUEtabFdH?=
 =?utf-8?Q?Dxzdwdif4DjyXdNi68/TtQ7a+?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AyzuPlwAs/xB7xy6M7jUCRpAyDjC8UtP+g3Rd2Ag0PkFsCIuNgjZXKfSDF1tAI4Mp2rm2XVBh7RWfnN+jyyQqvJ1qZ0kO6gDsxhlP+MmpeHYDHfCv1bbTMW7GwECBWUAiujdbWlyds6AqgnTkLnEIGmuhWxx+eThC7797xU4HfK2BfD9ZNvoFFoJAAcITK6FpGjg38F94rLoofCUMipkJjE5+ywBSC01taG8OEO7XCil3RhkYQE2ZtgmpBASeuQOgBUpatZQqg+oLbSBSCjC3pHs7ZgkB+8uwRxeC481ry265s5HcgpSpSH0yqwK5keSN2uLeDWitKOl4Yz7SGV3/4UjGhK2biLTxSYX5NKAcEZknzLHxz5i4PRhzdMMENoZtmw3DJGLI08kHz/S09fTe5Z3EzL9sQIFSVDCgbOeA0PfXLmEKjup+i1nX3viaJXn11iW8z1o53JiVCIVqCdVXXAltl7d5p8jcgcCHxn932tNOsbAbJIxu+TcC2MeoYjefX5egl4Yu1a9nawpxBuoRF1BXBtq7f0r7vsY3HKZylyIqWsAb5qPk6A++jcpdxgMlkmVJmeZDsDZNOiP/znmlbrvbErDRKRA+StDC6t1DWAI7dmo5OynfCmK9YwWu9n5
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB12071.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445508d5-866a-4231-0c1a-08dd51927be2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 09:39:34.1707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZuVzhgmUHB/ny0gp43yDhn+dBDYCdbi9A0AMCIg1cxvaemxCpj0smYjOGkv42GQWgwjUI0v1bTOkZOjz5k8+PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12393
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] ioctl08: Fix comment indentation to fit RST format
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea


  *   Bullet points are enough, since ordered ones are a sequence of steps, typical of algorithms.

I have re-sent related patches and used bullet point lists for them. PTAL.

Best regards
Ma

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
