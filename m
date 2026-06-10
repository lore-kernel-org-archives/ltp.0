Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8AECD8C90
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 18:20:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E9D53E6EA7
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 20:20:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13F7E3E24B6
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 20:20:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C8C53600756
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 20:20:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781115623; x=1812651623;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=NAFHOS9qJ4HYzxNENhA4eDpxxtWZoiZDWaZKv9hsQIs=;
 b=bANOfKb4bPWq2mrHm48fDXXRKCfXNu/d47U7x+SU3+S3Pyhc7lPjQXN7
 VRTEJF7n22bZmARTTCs7tp1ZLZ7/5sOdv8OGdPTNEqnofRrfBl/I3d1dF
 MWFhjCdhGWSfI+1ZQTXC4IJlAV0Er8gxoRpue8uiZgR/MkKgfUusOz2YY
 YFu+J7yOZAUAz5X/wnmkqEKjaLMacrhKA5usKmK2NZ3PoOr/elx10Q3gm
 l3+4EyTwOGTAMWTvEXmsHzciC6BTep2TWbNMmaXOGjvoXhu7RdZseSYrp
 3Hswn1FZy8aiD+5pQIAohh0jrgGAoZ4SGEP+vdCbbigPmoaw+ZiyKT8b0 Q==;
X-CSE-ConnectionGUID: gZ3+f+WgSjyaGP4H72Tmpw==
X-CSE-MsgGUID: KhZ0RsRNRjCLE/UbHq29og==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85811901"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="85811901"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 11:20:15 -0700
X-CSE-ConnectionGUID: RU180fAQQhu+7VrMDqOHMg==
X-CSE-MsgGUID: 1s601yzGRPqtH4tD5irNlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="251165796"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 11:20:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 11:20:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 11:20:15 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.26) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 11:20:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfINxvNDIOvDYzrE5iVKjjHL2i5uSGarKqyB4VHSmQd1iANQs4abPDlnUYNRa4oBiykcomfhkWHkrWGVLf9KzaZ/HpURDYBkcvZYhczVBvbO0+YbFi3xFbLwzPJsbMndVcsRiC+QydAMB2AQRpNw5on/wB/ehkkFt2RbmFBWoR2UPSHdZ+Tr0/JeCO1P1S1RNB4PM4GtQUqKQvpPXOiwi7MaYyKECSb9OPVOpoUes6Vs4bkDh2l5X6AGF/GRUAAyn/FrwpXEMX2GExzIlb1GtDivIs2WtljzYpdu0AnGIb1lkTYPWeXP8IahuIpaue6KXFGG0Vw7U56RnCI8DGu3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sUUemDa00VM7LKhPmzyYalb4TngSMSJKAxCUwA7LEA=;
 b=F8RGT9NkFH/7Fh60noRt8JAZSn6OmIvoSu/JDGO3v286lZKGRYVTywnleFPXVMHKqPI+QcWB7pUHm+9BpzIuVR4LUxZKBsbcFTgwMWXhlC4YeQqx7DR+qAxrpXLaDiEHc5w1JdWCf3NbkPyYCpPZq/F8Ugjk4UpYdy9HzC35xzMENDcJPAT7K3irproAhu7Pqjav9SrPomSCHpI5IxsivB85HUWZFPU1qljZTu4VkK7dYdPffjaYjl5/GP6v1lrYs5ZsGjYV3rMnOiJlk3wLy3z2jOyd8/bJ6ISu172mbwdg7Br0n/eJgq4+lJgfdwTSW0UtW4oRx7+3EkwLFg5qwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by SA3PR11MB7487.namprd11.prod.outlook.com (2603:10b6:806:317::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 18:20:10 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%3]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 18:20:10 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "linuxtestproject.agent@gmail.com" <linuxtestproject.agent@gmail.com>
Thread-Topic: high_freq_hwp_cap_cppc.c: new test for testing
 acpi_cppc/highest_perf
Thread-Index: AQHc+N8ZF4df2KeulkS3xRgp/NiDl7Y4GcoA
Date: Wed, 10 Jun 2026 18:20:10 +0000
Message-ID: <eaef86a1cfea813ec00b6a6173548dfeb896ea7c.camel@intel.com>
References: <20260610133048.115931-2-piotr.kubaj@intel.com>
 <20260610134300.4057-1-linuxtestproject.agent@gmail.com>
In-Reply-To: <20260610134300.4057-1-linuxtestproject.agent@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|SA3PR11MB7487:EE_
x-ms-office365-filtering-correlation-id: 4ff12d1d-a7dd-4a0a-d1ff-08dec71ce856
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|18002099003|22082099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: ofhr2eLyNiBc0mL744MSxpfkfAIg+ojWgY5qEvQX1jMSNZkuBIypJ7g8uGli6TuvtluDjWCqTEwJLqUZV+ArJuoi9/81fFIxOPNcSg5dbaGhuAYsS+PucT8J0TsZnRq/BY836TUeYQQDstoiz9y79fAVQN/4UQMyVciEFaPuEB6u4IeYe4PB1u3i/fa2W2a2cbI3RP+KldePwhu6a9KC2OTIFmg43OCuexqJRiScZDqs+o7ZUHX2d43WifsBu2rkfF5PllnDp++exr0azzHOnsVN8sTncmfKGVMBgKmTt/zN0Byc2wxyymqt5DsiLMFNOJCh8mK6JPvJbl1WoTF4AvKAg6jnZLTzYYvO69qGMXc+05OdGZnWjouoO21VzrBN057EvNVExZ/gxFXoidOOtzdjqK9BycK3C2DcDlmW9NTCDW3GDhjl0zDSoIM1mUureRzj3jaLawAsno1tH0z5N+ZGZIItvGtyIHGIxJHlb1iCLtlfEzi0nM8O0RYkiHovQtFLaMUMN/AkPPRYXdNLzSw0CdaEgYXj6VAuStbNYpNKDQwAtJeKKIcNHPETbL3amMykfivY0m4nOWxl9VyR1XDROSq+EcsH/uhcyT+uHYaZsRzYo0VIvM5aJCpCoHX/O0UGCxl92oiDYJE3y/iJTQmw0ssSAz6O9nnJ5wFHX3k8cK51ETb40srbVaLcARx70g7theUa11wQulAiT5CM0qsOG3kbgQrO4i3f94wpajJZNbsEHj7i+KK60XKXK76q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckNYaklvclBYaklPM21XbENDWHM5cDhUQzFUNXdhZ3BZSlpOSHNNQW9ra1hK?=
 =?utf-8?B?MW9LY3dBZ2tuOE82OU9aTDRrQ25Ea2FEOCtPSTU3cS9VMm5tczZkRS9tbkVE?=
 =?utf-8?B?NUcxV1doNmFYaVBpd3Z1eTBQSnhvMUlrdUorVXh6bnY2bUo2VS9mMkNXZTdq?=
 =?utf-8?B?S3l5c2dTTEE1VVhTbEkxaWZPLzB3YU5OanRSZEFHTTdTdU9JVTFVSUFyckhr?=
 =?utf-8?B?R0NuZmUvM0k5bm41b01lbjd4ZnJ6NjVNbVVDQ1RLL01OdmJMeWI2OFFuZHAw?=
 =?utf-8?B?MnJma1VvWndxVUVDYUlCT3FZUXpWb3lFWFNqVVRlVkc5dkdSZWJmamRBYUho?=
 =?utf-8?B?NkI5ZEhrS0lRWFZCeEJrSzIxcnE3c28zOEI0YUgwV2lsS1JMQlRSTXpCNnFy?=
 =?utf-8?B?aUVXU3dDR3VReTF4aDRlUWlCenRreml3OGdEeHFyQXBQbGJ4YTM5ZXRwSHVj?=
 =?utf-8?B?dUlFN1l5SlZ3enVkWmVNalBqc2s0b2F3QXIydGhlTTBoSi9sTUpCaEFqeVIw?=
 =?utf-8?B?WDA0d2dtK1dJcUM5aHRlbEhqZEtkajZaekpYMGNucFJTeUQ1RjloWDJ0RTVZ?=
 =?utf-8?B?c2JuVmtyU2MxZ014SFdQbEVINW1vNEVITzZwRmVtUTRUV2NsVm9vcFJwZUZx?=
 =?utf-8?B?ZnJXOTdwcnV6N1Y0ZXdqQ1YzVWJObFNtem5zZngrSTBrWEF3WWpOelEwV2My?=
 =?utf-8?B?MkZkeWJUQlJDSldiMnJQcndjVGJBWC91aUlPaS9lOFpFSTJHNjk5WGh2MlRq?=
 =?utf-8?B?RFpPZW9aZWg4ZUNEOGJpNllYcTY5UGxoeTdrNUdJTlhKKzVOMldPUUFwY0Nj?=
 =?utf-8?B?YUplTVNUZTNxRmQrYUVrUHJkSlpYUWVYS2hGbXdnWmpHQjVKcnhpTEJuRHFz?=
 =?utf-8?B?Wjl4V3c2azNiRkFZN1RGSG5CUFJTcHRBV1JKdjRpZXVWWC9DUFFDVnJoRWVK?=
 =?utf-8?B?S2dCNkxaU3FMN29CVEZ6cDBoaG54ZnJlOG1YWnEzQkNTRFJ1YVFraHVsT3Ja?=
 =?utf-8?B?OVZaRS9FU3M1czN3ZUprQk9YWWFYaHpKVnVtUmtiZDNuSUs4SG5yMGU3Qno4?=
 =?utf-8?B?eUZDa2MxSW54bmpDSW42YkN0Y0JSeXJ3d3hFdm03UDZzdmVZY2FDYW02TzBK?=
 =?utf-8?B?QVRYMkhwRW1VanZsMWNsYjUxSWc3Q3h0TWRQcWszbWd3WHBrZlMvU1ZkcklV?=
 =?utf-8?B?NWRIM3FWelZsems5WWpNNEhtY1pmc0lpTnIwTEpCVms4RmRUS29nUUY3MU9O?=
 =?utf-8?B?ZzUxWFEzSTM3VWFCWWJWOTNPM0dmeW00Q2VJN0RNb1EwcDhhTjc2UklhUmg3?=
 =?utf-8?B?Y1kvOUM2bG14S3BuUFQySlRPcFNiWjgxcTczVFI2WXFPR3orTThOWk5jcjY3?=
 =?utf-8?B?aWFhRDNBL1JpZlNHa2I5cDQ0YnJuR2NUckFlSFQrOXM2NVIvL0paYVZKZnRv?=
 =?utf-8?B?eWpLRW8wVDN0blo5R3hlcDJIZVVXcXFJZXBtT3pVRVp4eEsrOGNPbGJ6SlE2?=
 =?utf-8?B?eVlyeGFxUklmMWlCTi9hWUd4VmVTQWpjR1lvOXpaQWxhdVhoVVhONWVadmlY?=
 =?utf-8?B?YzNpT3NjTmVmN3pCWCtPd2VrMkpCK2puVE00UGNRekkyZGxIK2lZVDBLdFFk?=
 =?utf-8?B?aTk1YkYyb002RFRXOU9nV3hPSUFEZWdaV2pEM3ZqcTh0T2l0RzM1NEZ2cTFO?=
 =?utf-8?B?VU4zNEtjTm1JYTRUOCs4anRiV2RVT04rb2Z3enFvdzFQbjF0NUp6Y2IreklH?=
 =?utf-8?B?TUhNdzJPdURaOEwzenlQL1VFRnZCTElpcUVPT0tWZW9yNzMza1lPQzZpZHJr?=
 =?utf-8?B?dWI1cVFUZnBGWmpmazRmMk9nWXFoQTFQZTcydGIzRUVOdzdzVzE2K0pOdU9C?=
 =?utf-8?B?VTM5cHZhNXIwbDFJc1hrRm1PUU95YXNSdFZUc05MZDN3NVEySXptdFAyRlRD?=
 =?utf-8?B?WVhDcUJVMVFPNWJnV2tUUmliZ0R4bmtscU02TlVaUWFLU2REUlBaQllFamk1?=
 =?utf-8?B?OE9NTHBwMmpucHJFSlcxY3BLVmVrbTdGNUtFZ0V2blF1cnZCRWFodHRpUHE3?=
 =?utf-8?B?UTFvcGkxSjlFN0ZUc1J4cm5haUxhWmxNeTE0eUlFZ1B3T3B3bGxDcFB6anpx?=
 =?utf-8?B?VHFHQmN2cDNtYjBwV2ZHZG1WaXRTZmJJZUdSOGkzQzBtV3grS3FHcm5DYmxz?=
 =?utf-8?B?UStnSUEyZVRhU3N4NmREaVU3NGFQRzUzd3ZJd2dSdnk1Q21PRGg2RFJxQnJG?=
 =?utf-8?B?dHdNZmlrMm9tNHlpUVRSZHZxVG5SSElhQ20wV1hrMkJXMEVVM2x6VzdUYlNW?=
 =?utf-8?B?bFp6U0g0UjJOWE5KSjA3S3JNakJZNGUza2crL0haRkFvWHYrVEhySGRhaU04?=
 =?utf-8?Q?sxhRQbQhPT+IwgXs=3D?=
Content-ID: <0133246F6A41B34A960BB91C772084B1@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XATGljIc6s8IQzldyaqV2+cfx6xQXCaoUP8DflGF4QH1qxxqCGuR9Fq4GdUm1Ts/JaRKUBWzFYnE6E40fggpnQKQ8FDNL69cvloXbPoSQjGPwC2aYIRjaHkYaR8cb7Pc1AN3IkJZP4+DiMId8v242/CGbox1jh5AMVoTBKr69Vo0/NXftpW2LqyRkrGsd9ksjDCpiFrirokSy55cafLEMMLqY7s5yLZFZjhpsijf6rPwpsH/uVfRInY2h/H/VBa+9mxsdSjC3gcdLRKrxA/OMUuNJUtjWlX2uMd6862bzmgkN1tCXjF5T+M+M1gp9gJov6RAsGtfC/ljFuUzNDFXrQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff12d1d-a7dd-4a0a-d1ff-08dec71ce856
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 18:20:10.2981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cuAfEuEcFcmir0qncKFbFoTJ3OnyKuMEiOUqloSCDXKZhIZNxLXzJ0eo88QrlzqhhuGT+II4fNAEnAhtvGZYlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7487
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] high_freq_hwp_cap_cppc.c: new test for testing
 acpi_cppc/highest_perf
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

MjAyNi0wNi0xMCAo5rC0KSDjga4gMTM6NDMgKzAwMDAg44GrIGxpbnV4dGVzdHByb2plY3QuYWdl
bnRAZ21haWwuY29tDQrjgZXjgpPjga/mm7jjgY3jgb7jgZfjgZ86DQo+IEhpIFBpb3RyLA0KPiAN
Cj4gT24gV2VkLCBKdW4gMTAsIDIwMjYgYXQgMDM6MzA6NDlQTSArMDIwMCwgUGlvdHIgS3ViYWog
d3JvdGU6DQo+ID4gaGlnaF9mcmVxX2h3cF9jYXBfY3BwYy5jOiBuZXcgdGVzdCBmb3IgdGVzdGlu
Zw0KPiA+IGFjcGlfY3BwYy9oaWdoZXN0X3BlcmYNCj4gDQo+ID4gKy8vCS5uZWVkc19jcHVfdmVu
ZG9yID0gIkdlbnVpbmVJbnRlbCIsDQo+IA0KPiBUaGlzIGZpZWxkIGRvZXMgbm90IGV4aXN0IGlu
IHRoZSBMVFAgZnJhbWV3b3JrLiBJcyB0aGlzIGxlZnRvdmVyIGZyb20NCj4gYW4gZWFybGllciBw
cm90b3R5cGU/IENvbW1lbnRlZC1vdXQgY29kZSBzaG91bGQgbm90IGJlIGNvbW1pdHRlZC4NCj4g
DQo+IElmIHRoZSBpbnRlbnQgaXMgdG8gcmVzdHJpY3QgdG8gSW50ZWwsIHRoZSBleGlzdGluZyBD
UFVJRCBIV1AgY2hlY2sNCj4gaW4gc2V0dXAoKSBhbHJlYWR5IHNlcnZlcyB0aGF0IHB1cnBvc2Ug
c2luY2UgSFdQIGlzIEludGVsLXNwZWNpZmljLg0KDQpUaGUgZmllbGQgaXMgdG8gYmUgdW5jb21t
ZW50ZWQgb25jZSB0aGUgcGF0Y2ggZm9yIGl0cyBhZGRpdGlvbiBpcw0KcHVzaGVkLg0KPiANCj4g
PiArc3RhdGljIHZvaWQgcnVuKHZvaWQpDQo+ID4gK3sNCj4gPiArCWJvb2wgc3RhdHVzID0gdHJ1
ZTsNCj4gDQo+ID4gKwkJYm9vbCBtYXRjaCA9IG1zcl9oaWdoZXN0X3BlcmYgPT0NCj4gPiBzeXNm
c19oaWdoZXN0X3BlcmY7DQo+ID4gKw0KPiA+ICsJCWlmICghbWF0Y2gpIHsNCj4gPiArCQkJdHN0
X3JlcyhUSU5GTywgImNwdSVkOiBzeXNmcz0lbGx1DQo+ID4gTVNSPSVsbHUiLA0KPiA+ICsJCQkJ
aSwgc3lzZnNfaGlnaGVzdF9wZXJmLA0KPiA+IG1zcl9oaWdoZXN0X3BlcmYpOw0KPiA+ICsJCQlz
dGF0dXMgPSBmYWxzZTsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCXRzdF9yZXMoVElORk8sICJj
cHUlZDogJXMiLCBpLCBtYXRjaCA/ICJPSyIgOg0KPiA+ICJNSVNNQVRDSCIpOw0KPiA+ICsJfQ0K
PiA+ICsNCj4gPiArCWlmIChzdGF0dXMpDQo+ID4gKwkJdHN0X3JlcyhUUEFTUywgIlN5c2ZzIGFu
ZCBNU1IgdmFsdWVzIGFyZSBlcXVhbCIpOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCXRzdF9yZXMoVEZB
SUwsICJIaWdoZXN0IHBlcmZvcm1hbmNlIHZhbHVlcyBkaWZmZXINCj4gPiBiZXR3ZWVuIHN5c2Zz
IGFuZCBNU1IiKTsNCj4gDQo+IFJlc3VsdHMgc2hvdWxkIGJlIHJlcG9ydGVkIGRpcmVjdGx5IHdo
ZXJlIHRoZSBvdXRjb21lIGlzIGRldGVybWluZWQsDQo+IG5vdCBhY2N1bXVsYXRlZCBpbiBhIGZs
YWcgYW5kIHJlcG9ydGVkIGF0IHRoZSBlbmQuIFBlci1DUFUgbWlzbWF0Y2hlcw0KPiBhcmUgbG9n
Z2VkIGFzIFRJTkZPLCBtZWFuaW5nIHRoZXkgd29uJ3QgYXBwZWFyIGFzIHRlc3QgZmFpbHVyZXMg
aW4NCj4gcmVzdWx0IHN1bW1hcmllcy4NCj4gDQo+IENvdWxkIHRoaXMgcmVwb3J0IFRGQUlMIGRp
cmVjdGx5IGZvciBlYWNoIG1pc21hdGNoZWQgQ1BVIGFuZCBUUEFTUw0KPiBvbmNlIGF0IHRoZSBl
bmQgaWYgYWxsIG1hdGNoZWQ/IFNvbWV0aGluZyBsaWtlOg0KPiANCj4gwqDCoMKgIGlmIChtc3Jf
aGlnaGVzdF9wZXJmICE9IHN5c2ZzX2hpZ2hlc3RfcGVyZikgew0KPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHRzdF9yZXMoVEZBSUwsICJjcHUlZDogc3lzZnM9JWxsdSBNU1I9JWxsdSIsDQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGksIHN5c2ZzX2hpZ2hlc3RfcGVy
ZiwgbXNyX2hpZ2hlc3RfcGVyZik7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhdHVzID0g
ZmFsc2U7DQo+IMKgwqDCoCB9DQo+IA0KPiDCoMKgwqAgLi4uDQo+IA0KPiDCoMKgwqAgaWYgKHN0
YXR1cykNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0c3RfcmVzKFRQQVNTLCAiLi4uIik7DQo+
IA0KPiBUaGF0IHdheSBlYWNoIGZhaWxpbmcgQ1BVIGlzIGEgcHJvcGVyIFRGQUlMLCBhbmQgdGhl
IHJlZHVuZGFudA0KPiBzZWNvbmQgVElORk8gb24gbGluZSA5OSBjYW4gYmUgZHJvcHBlZCBhcyB3
ZWxsLg0KDQpUaGF0IHdheSBvZiByZXBvcnRpbmcgd2FzIHN1Z2dlc3RlZCBiZWZvcmUuDQoNCj4g
DQo+IFZlcmRpY3Q6IE5lZWRzIHJldmlzaW9uDQo+IA0KPiAtLS0NCj4gTm90ZToNCj4gDQo+IFRo
ZSBhZ2VudCBjYW4gc29tZXRpbWVzIHByb2R1Y2UgZmFsc2UgcG9zaXRpdmVzIGFsdGhvdWdoIG9m
dGVuIGl0cw0KPiBmaW5kaW5ncyBhcmUgZ2VudWluZS4gSWYgeW91IGZpbmQgaXNzdWVzIHdpdGgg
dGhlIHJldmlldywgcGxlYXNlDQo+IGNvbW1lbnQgdGhpcyBlbWFpbCBvciBpZ25vcmUgdGhlIHN1
Z2dlc3Rpb25zLg0KPiANCj4gUmVnYXJkcywNCj4gTFRQIEFJIFJldmlld2VyDQotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KSW50ZWwgVGVjaG5vbG9neSBQb2xhbmQgc3AuIHogby5vLgp1bC4gU2xvd2Fja2llZ28gMTcz
IHwgODAtMjk4IEdkYW5zayB8IFNhZCBSZWpvbm93eSBHZGFuc2sgUG9sbm9jIHwgVklJIFd5ZHpp
YWwgR29zcG9kYXJjenkgS3Jham93ZWdvIFJlamVzdHJ1IFNhZG93ZWdvIC0gS1JTIDEwMTg4MiB8
IE5JUCA5NTctMDctNTItMzE2IHwgS2FwaXRhbCB6YWtsYWRvd3kgMjAwLjAwMCBQTE4uClNwb2xr
YSBvc3dpYWRjemEsIHplIHBvc2lhZGEgc3RhdHVzIGR1emVnbyBwcnplZHNpZWJpb3JjeSB3IHJv
enVtaWVuaXUgdXN0YXd5IHogZG5pYSA4IG1hcmNhIDIwMTMgci4gbyBwcnplY2l3ZHppYWxhbml1
IG5hZG1pZXJueW0gb3Bvem5pZW5pb20gdyB0cmFuc2FrY2phY2ggaGFuZGxvd3ljaC4KClRhIHdp
YWRvbW9zYyB3cmF6IHogemFsYWN6bmlrYW1pIGplc3QgcHJ6ZXpuYWN6b25hIGRsYSBva3Jlc2xv
bmVnbyBhZHJlc2F0YSBpIG1vemUgemF3aWVyYWMgaW5mb3JtYWNqZSBwb3VmbmUuIFcgcmF6aWUg
cHJ6eXBhZGtvd2VnbyBvdHJ6eW1hbmlhIHRlaiB3aWFkb21vc2NpLCBwcm9zaW15IG8gcG93aWFk
b21pZW5pZSBuYWRhd2N5IG9yYXogdHJ3YWxlIGplaiB1c3VuaWVjaWU7IGpha2lla29sd2llayBw
cnplZ2xhZGFuaWUgbHViIHJvenBvd3N6ZWNobmlhbmllIGplc3QgemFicm9uaW9uZS4KVGhpcyBl
LW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgbWF0ZXJp
YWwgZm9yIHRoZSBzb2xlIHVzZSBvZiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpLiBJZiB5b3Ug
YXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVy
IGFuZCBkZWxldGUgYWxsIGNvcGllczsgYW55IHJldmlldyBvciBkaXN0cmlidXRpb24gYnkgb3Ro
ZXJzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
