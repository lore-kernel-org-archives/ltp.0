Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D259CCFA13
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 11:29:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C47E43E6C86
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 13:29:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B66D33E2DB1
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 13:29:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 589BE6012D2
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 13:28:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777548541; x=1809084541;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=LMa+vxlXD3B6VqV9IXcQpYVSDs5CuEVjK39sQjELZhU=;
 b=H4ksgbILCzbfsMN2Lb03vYkAOLtHQNW5LiExEBKabQNa2qwiXjp6xUTz
 AmgJEeqGLnpZNHCc8PcsA78lHe/3eXKccgtzMtEekDVW+klGqLhZvWr1g
 stfew4cY6vQK+RxghcjlhdjL+Y4g6T0exQryfG8Y36IFTqgJ6pV2Gap3Z
 tjcjFehCrB611bJrCtr+Lz4AekwqkQwgm2oUIgyhVPDGHW2428DmUm8QF
 V89+8TVVqk1MT0TS/yA74ZNnst+gGw+a3J/wgz3O3GCgtHwASgmIQjjZn
 rH+ugO/9ZigeKVwICbSZA5nb/K5eTHaue7+tL0+xfbkk85D0uplP/+tFP Q==;
X-CSE-ConnectionGUID: AQignJm0ScKmd0tbJhxxzA==
X-CSE-MsgGUID: llYbm8WdReCpfq4XBHK28Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="96062586"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="96062586"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:28:58 -0700
X-CSE-ConnectionGUID: o9ZpXJZRRK2Jc97eZbzn2w==
X-CSE-MsgGUID: aV8YRF4BTcOBiJLrTHwCpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="234831458"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:28:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 04:28:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 04:28:57 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 04:28:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrHInwbXijewgBo33UgTgVNmufltMCaA++0jf6OxTDuI1SJ2iBPxKhyWPSQrhM/AP3MFWyaHDfn+Sq8kS7in58odL6NJh5Y6Tq8EdmsiLSOcV/9vhpbFTVwtQu9Cs7UK0gGZeREoh0GaH0PTUTeFNzFyDlOOFetGETq3v2MA996FdWFZ3+dKWozIUFONpRZrE96B/Cekc0Lzb5m14t2caLOWovlEb14X4cyZSPkSUzRDJhfE8zGVHUg8jSjYS29ItqBjn03b1E6YmoZsQYLhoI8PvMfEhQ/61qrMod+LL9/LUtKhjw5Y/e3lbu2/8xQlG/832xzu0aaSxq0USAgOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wh4QtRboPdstFwG84gy/wuSBzUsHRj13cGUIUxpA18=;
 b=LwXe5Xhwr8kL4oWBVbCgt+5zLiJNegzeHNu4Bchq+NuvlfxRZdSCRODYm/HuJKYaA2F2YZSXNcvomuGvm1P9CpXmSXgN7y+MV+omLR5sGOyUFEOUFhmgWopcWpiIhrOsE/d3I9tfpKxKojEpcxPs7P/aLILg61mBIwQpN2OoMSu5T3jP3z8/VUeoTByU14byi0vf7ga/9VObwL0D8LzaRaJGREOqD4oGhOEbuFXOG4FdyyoXTMW25tZyHTKyDhrdN3gZpMxHD+TC91zEdDyN6wUFLZbjdA6vvZfhyedtbFer4cHEDeFjhnJvxG8kfxR7GfIYOZsslXNrTUnE3nTsgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Thu, 30 Apr
 2026 11:28:49 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%3]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 11:28:49 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "linuxtestproject.agent@gmail.com" <linuxtestproject.agent@gmail.com>
Thread-Topic: thermal: add new test group
Thread-Index: AQHc2IJYnQFzu+adP06AQeStKlk5+7X3eACA
Date: Thu, 30 Apr 2026 11:28:48 +0000
Message-ID: <c106fc95d03153ed28a4f3ab9c27b3328de2133f.camel@intel.com>
References: <20260430084239.320182-2-piotr.kubaj@intel.com>
 <20260430091832.3987-1-linuxtestproject.agent@gmail.com>
In-Reply-To: <20260430091832.3987-1-linuxtestproject.agent@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|SA0PR11MB4527:EE_
x-ms-office365-filtering-correlation-id: a9d476e1-91aa-4bbe-b4da-08dea6aba61d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: +f/9pYEYnTrvExfErbabf1d1h+ar7a+kDagYq4+fUGF5RW1IotNk9RpADQNPMwLWXVHfubgmECUvB59wgCp/JdMajNlRS3Vwsh+yzl2r+upKw8Ap3Y6NB8q47s3Vb9TN0/gD7wTg53nPHUlG1tYmHlM7RB1IbNgbIuTJNN5B9qQ3t8c6cJoI9retrDNT5NdkYhyIVxgqb5lkuU2Z5Lb45f9Fqkh0zw/NSlJlINMKqsIbi8YuzbgSFaPoS7tOCrYC08vk3mGRxNRs+Dl/4C8xfQo3Yoe+1c4198RaFt6924rXZTYofRfNMehw1umPkHvq00LJfy/55yNoT7htgvX4iDOgmdyqvnUxe9Z7MwQuWMbHNLuefUaxH1A4aO5ytAR/14McXZWgI2sVud8aaiVhbTRJYNZrnuYRZH72H2igdgS9kHp2Dbd2zhuK+po0zLLpWDxlEQvifRwAhM7axF+rsfyyHNq5t6A5tia/8eulAPbQjbllHwYBRoIAxnENHDpc98dvDuH12DsXePOl/SLooZV/miwD37yYaCAHSwFm+Qabx3b4lboedhWRRqjxuMx2vxPfQNC0TlYF3tu6ro+2M9QZAzxIJs7ZisZrxTntmuQy3/8kd8ysuy6JH//F957u2skBBAWSNmrK7Q9BNyON2yvKdNHJWValZjt9YCcQuX7US2w0gz1QJH7rgqL4MqP5aYyQ/WcQjuGwwuR7pIYkgkjC+w2bR5OwgIe25reG2SLbEmZ5lPMyypVfk6qVEta4sHcxgLrEzjXLlCFu1VS7Rb1UJSFiLmXiYqAZrk8iqlk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L013emc0WFBKbzBvQm9ueUJrZ0h4MEVqR0VESjh2SnZ2MkppVUwrRXNsNTB3?=
 =?utf-8?B?R3Axd0pSM3VHcVlDUFBvaWRvcGxhS1czV2ZWNzNPQzErUlNROGgwRlNKM0lR?=
 =?utf-8?B?dlhaaVIxeWVGTWVpZ0RGalhxZUdPaUtwb0NnMWcyVktWRm5EVzN0ZE5yNExI?=
 =?utf-8?B?NlhQV2FDSzhrdnpycThnTC9oQTk3TVlmZmMyT3NtZmlXb0ZkMlJHZENUb1pR?=
 =?utf-8?B?YkVscjROMkVaOWRzNnlpTllUMTBkN1lKUWJqdE5KSnkxWUlRa1AyRTBEM2x2?=
 =?utf-8?B?N3RBSWpucElLdEdwNGRzUTJLUEtDbEM1TVVrL2pBZnZUZnF5eWMxa1hxNFlZ?=
 =?utf-8?B?OVN2Q3d5cDBWNzA0QmZUSUdwUTZQVzl1KzBaYmMxenZIQnRoNHJONStHTTdi?=
 =?utf-8?B?amx5cHJjaTAwcVNpYmpYVTVyNHVIN1Fsc0wvL2cxNkNHYnNFRkFYenI0NmJX?=
 =?utf-8?B?ekxkRXdYSVNLaXNPd1hZRGlZZTFDUWlWU0x2dUpNclFLcmpwWjhFOVVtekJr?=
 =?utf-8?B?SnpWUTB5UTI5dW5iQkwwQVNyNGJlamN5NUVyZ1RsMEpQakxqZm1GaUlMYTV5?=
 =?utf-8?B?b01CQi9MdVl3Z3dXL0xQbVFmMjBneGdmNkJKazhpZjJTOU5zc1Z3S1RneWk1?=
 =?utf-8?B?dU5jS1dOejZKQW5BSlNRMHdOY1BlYThYblFzYmtGY2FNUnhrd1NOT3o3VWVP?=
 =?utf-8?B?UG92a2ovN2dUcDlIU2YydFhJTVNXeTQrR0o3UG5jL0FqekVQSk1lR3A3bk84?=
 =?utf-8?B?N25JcEhjVGF2NDVWSWN5RG55NDliK3RQUHdVSVRXZTVWdzhxdXRONXlpQURG?=
 =?utf-8?B?V0E3Z0VBVlFnTVRPN0E2SWF0YnM0THdIZFhiVWJiYkNjY3I1eG4vazBZUXhU?=
 =?utf-8?B?dDd5ZlBvK1NqOTB0R2ZnUkZkNmR1M0ZhOTNQZi9QU3ZBRDVIWENNOS9xVHBD?=
 =?utf-8?B?T0dtQjZpQmgzcW1mc3RpRTc2dEdYd2FMZzZXcmZDNUtwVXlWcEJ3RHhhMDk3?=
 =?utf-8?B?eEp0eC9QQllMcnVGZ0lnK2ZQaFdPNGFNSDgxSkpKZDFweGFqV1pibTNoUFhO?=
 =?utf-8?B?NGQwbHYreTFTNWJuNWc1WFY2T0YxOHR1ODRwb0Q5bVFQMGF5TkV5YkI0TFNR?=
 =?utf-8?B?YjJta1JGU21tL1hTRzl5TEZBRDZGQ0x6cDE2OVgyODNxS3FWWUt5dW5YOFEy?=
 =?utf-8?B?YjBZU0wvOVJwVnpqREdJS2s3QmNqWU43Wkd0MFY4Vkx3ZlZtRE1KdzZQUTVS?=
 =?utf-8?B?WncwVm9hdzU4TFpZaHFadldJdXFPYWtxd1FYQkNIZmEyNDNkeDA1ZEM5SHZt?=
 =?utf-8?B?YStJb1J4akd4U1diTUNNRkZiM2lieWRBRXRHa0ZCU244ZVZaRTZQeit1aHFq?=
 =?utf-8?B?K2U2eUJub0hXNnZ0bUgxRFFVcFBqODJzRG05WHJzZWY2dTVqN0FkSmpRaHZR?=
 =?utf-8?B?OEZwZUE2NzZtank2UnB6YTdhOGdxQTlFYnc2eDJCdkFSL2NLYTZYalBlN2xE?=
 =?utf-8?B?dk9KVUF6TjdXNnVLcUNMejZOUFpoa3BZOW45OEJsNU53ZzdlbGJPVzJRYUpm?=
 =?utf-8?B?bXkydEdGV09KQmFWRytGRngzOCtaaVVCTENvZnRSOEdrTmFNVE9XTC9YODFt?=
 =?utf-8?B?M0ZvK2c2MVM1T0hpdkhERFNVRG9FUWErVTVJRloxMGxiSUNWeGFhWjhiTEF2?=
 =?utf-8?B?ZSt6Y3pSRTVBczVWazR3MXgrbUp0Y2E2NGlQWkxrMUVBOWRGNWdrM1p1SHpa?=
 =?utf-8?B?b1FRcXh4a0FXUDEzVUYvTWNlVHdpOHlEK1h4cEVKMStUUVpoRGFVampHZXBk?=
 =?utf-8?B?WVo5UW52WlgvaEJFdW0wT0tGSVNkNXRXMnZNdjdNbmRVaUxpNDM5UHVKUG9k?=
 =?utf-8?B?cmdWN1U3bURZWGROV3hLVStjQUt4QU8yZEhucXJMVkdyUVhSVXBZTlhxcEVU?=
 =?utf-8?B?ZTBYR0lSdFY4ZDlNK0VONE82VU5TUWtTTS85N1ptWFluSUlzMW5oWlVwYWxF?=
 =?utf-8?B?ek1PcmljV2I0YUNDcXNHQUNrc0QzVzBKMzd1ZmphNnJFZDhKOVRPRGFFT0xI?=
 =?utf-8?B?UzJ0TnVqTnBtTVY4WE5GRUdOdEhrNjMyd2x6UEFSM1c4amxaRVpFWXJENWVI?=
 =?utf-8?B?NHc0MjNPekNUSTBNcEhLbUx6MFNxR1ZkZFpVZG83cGxMU3JLdUZtOFZtckMz?=
 =?utf-8?B?M2RQd1FEclNiVEI3WFRZc1Y1NHQ5a1BlL1E1SVlhSzlZenJBVHpScmlOYmZC?=
 =?utf-8?B?UEJobGZ5RTE4d3JvRjcwL1lpN3JXT3FCbkQ2U1Rpd2pYdy9sTG1hU2ROYysz?=
 =?utf-8?B?R0ZWZ3FBSUE4TzJva2NMWEpEMGJkdzFQQ20yOVh3Z0Y3dWJkUnNxQlgrWmV3?=
 =?utf-8?Q?gg8zmQzK/EHJYtQU=3D?=
Content-ID: <FA028706CBFDC84A9F9E34354A7DDE8E@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iHUY/uW9N+5umZtosCd0eXTY8k3eHc74mVFHbnP3bcubxtBlR60E5DmyYz8k7MFeV6+dkMaGlgkBrSfp5iaf/pMvxop5Xy6K3pw9R3soDbFDtPSXWgeLjY7DNdwc8LQuMSGMl1YZs10zqh2GBBapfDmCNtWItwPZjIw3oxucsdCES+JM+HQZBbkXFfrzSwiMGqR2RD2fJ0i5JUr5lgxqIFbTOJnAcbtjVr5F7HtZrlSTE5Vg0yG+iNU8JPEMl3B4rwTzyqE98rb+I7eMrie0B0LUt3V2Rk/Fxo1odQFV+NxJzJq1oT8tZrO9viDgls9wfQLRg2aYIHiJzdxNpGEKTw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d476e1-91aa-4bbe-b4da-08dea6aba61d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 11:28:48.9327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U30FaJ+5DtcwkudjBF3QPtjy01YRLZh57c+4mnwVpDRunRY9YZbUfTGSqcgdDcmuztlAvOtzx2EIr8/dUfdG9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4527
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thermal: add new test group
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

MjAyNi0wNC0zMCAo5pyoKSDjga4gMDk6MTggKzAwMDAg44GrIGxpbnV4dGVzdHByb2plY3QuYWdl
bnRAZ21haWwuY29tDQrjgZXjgpPjga/mm7jjgY3jgb7jgZfjgZ86DQo+IEhpIFBpb3RyLA0KPiAN
Cj4gT24gVGh1LCAzMCBBcHIgMjAyNiAxMDo0Mjo0MCArMDIwMCwgUGlvdHIgS3ViYWogd3JvdGU6
DQo+ID4gW1BBVENIXSB0aGVybWFsOiBhZGQgbmV3IHRlc3QgZ3JvdXANCj4gDQo+ID4gKyMgQ29w
eXJpZ2h0IChjKSAyMDI1LCBJbnRlbCBDb3Jwb3JhdGlvbi4gQWxsIHJpZ2h0cyByZXNlcnZlZC4N
Cj4gDQo+IFdyb25nIHllYXIgaW4gdGhlIG5ldyBNYWtlZmlsZSAtLSBzaG91bGQgYmUgMjAyNi4N
Cj4gDQo+ID4gKwl3aGlsZSAoc2xlZXBfdGltZSA+IDApIHsNCj4gPiArCQlbLi4uXQ0KPiA+ICsJ
CXRzdF9yZWFwX2NoaWxkcmVuKCk7DQo+ID4gKwkJWy4uLl0NCj4gPiArCQlzbGVlcChzbGVlcF90
aW1lLS0pOw0KPiANCj4gc2xlZXAoKSBtdXN0IG5vdCBiZSB1c2VkIGZvciBzeW5jaHJvbml6YXRp
b24gKEcyKS4gVGhlIGNoaWxkcmVuIGFyZQ0KPiBhbHJlYWR5IHJlYXBlZCB3aXRoIHRzdF9yZWFw
X2NoaWxkcmVuKCk7IHRoaXMgc2xlZXAgaXMgd2FpdGluZyBmb3IgYQ0KPiBoYXJkd2FyZSB0aGVy
bWFsIHN0YXRlIGNoYW5nZS4gVXNlIGEgcG9sbGluZyBsb29wIHdpdGgNCj4gdHN0X3RpbWVyX3N0
YXJ0KCkvdHN0X3RpbWVyX2V4cGlyZWRfbXMoKSBpbnN0ZWFkLCB3aGljaCB5b3UgYWxyZWFkeQ0K
PiB1c2UgaW4gY3B1X3dvcmtsb2FkKCkuDQpUaGlzIHNsZWVwIGlzIG5vdCB1c2VkIGZvciBzeW5j
aHJvbml6YXRpb24sIGJ1dCB0byB3YWl0IHVudGlsIHRoZSBDUFUNCmNvb2xzIGRvd24uIFRoZXJl
IGFyZSBzb21lIHByZXByb2R1Y3Rpb24gQ1BVJ3MgdGhhdCBoYXZlIG5vbi0NCmZ1bmN0aW9uaW5n
IHRoZXJtYWwgc2Vuc29ycyBhbmQgbWF5IGJlIGRhbWFnZWQgaWYgdGhpcyBzbGVlcCBpcw0Kb21p
dHRlZC4NCg0KV2hpbGUgSSBjb3VsZCB1c2UgdHN0X3RpbWVyX3N0YXJ0KCkvdHN0X3RpbWVyX2V4
cGlyZWRfbXMoKSBpbnN0ZWFkLCBJDQpmaW5kIGl0IHF1aXRlIHBvaW50bGVzcy4gY3B1X3dvcmts
b2FkKCkgdXNlcyBpdCwgYmVjYXVzZSB0aGVyZSBJIHdhbnQNCnRoZSB3aG9sZSBsb29wIHRvIHRh
a2Ugbm8gbW9yZSB0aGFuIHJ1bl90aW1lLiBIZXJlLCBJIGp1c3Qgd2FudCB0byB3YWl0DQpzbGVl
cF90aW1lLg0KDQo+IA0KPiAtLS0NCj4gTm90ZToNCj4gDQo+IE91ciBhZ2VudCBjb21wbGV0ZWQg
dGhlIHJldmlldyBvZiB0aGUgcGF0Y2guDQo+IA0KPiBUaGUgYWdlbnQgY2FuIHNvbWV0aW1lcyBw
cm9kdWNlIGZhbHNlIHBvc2l0aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMNCj4gZmluZGluZ3MgYXJl
IGdlbnVpbmUuIElmIHlvdSBmaW5kIGlzc3VlcyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZQ0KPiBj
b21tZW50IHRoaXMgZW1haWwgb3IgaWdub3JlIHRoZSBzdWdnZXN0aW9ucy4NCj4gDQo+IFJlZ2Fy
ZHMsDQo+IExUUCBBSSBSZXZpZXdlcg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkludGVsIFRlY2hub2xvZ3kgUG9s
YW5kIHNwLiB6IG8uby4KdWwuIFNsb3dhY2tpZWdvIDE3MyB8IDgwLTI5OCBHZGFuc2sgfCBTYWQg
UmVqb25vd3kgR2RhbnNrIFBvbG5vYyB8IFZJSSBXeWR6aWFsIEdvc3BvZGFyY3p5IEtyYWpvd2Vn
byBSZWplc3RydSBTYWRvd2VnbyAtIEtSUyAxMDE4ODIgfCBOSVAgOTU3LTA3LTUyLTMxNiB8IEth
cGl0YWwgemFrbGFkb3d5IDIwMC4wMDAgUExOLgpTcG9sa2Egb3N3aWFkY3phLCB6ZSBwb3NpYWRh
IHN0YXR1cyBkdXplZ28gcHJ6ZWRzaWViaW9yY3kgdyByb3p1bWllbml1IHVzdGF3eSB6IGRuaWEg
OCBtYXJjYSAyMDEzIHIuIG8gcHJ6ZWNpd2R6aWFsYW5pdSBuYWRtaWVybnltIG9wb3puaWVuaW9t
IHcgdHJhbnNha2NqYWNoIGhhbmRsb3d5Y2guCgpUYSB3aWFkb21vc2Mgd3JheiB6IHphbGFjem5p
a2FtaSBqZXN0IHByemV6bmFjem9uYSBkbGEgb2tyZXNsb25lZ28gYWRyZXNhdGEgaSBtb3plIHph
d2llcmFjIGluZm9ybWFjamUgcG91Zm5lLiBXIHJhemllIHByenlwYWRrb3dlZ28gb3RyenltYW5p
YSB0ZWogd2lhZG9tb3NjaSwgcHJvc2lteSBvIHBvd2lhZG9taWVuaWUgbmFkYXdjeSBvcmF6IHRy
d2FsZSBqZWogdXN1bmllY2llOyBqYWtpZWtvbHdpZWsgcHJ6ZWdsYWRhbmllIGx1YiByb3pwb3dz
emVjaG5pYW5pZSBqZXN0IHphYnJvbmlvbmUuClRoaXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVu
dHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG1hdGVyaWFsIGZvciB0aGUgc29sZSB1c2Ugb2Yg
dGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJl
Y2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRlciBhbmQgZGVsZXRlIGFsbCBjb3BpZXM7
IGFueSByZXZpZXcgb3IgZGlzdHJpYnV0aW9uIGJ5IG90aGVycyBpcyBzdHJpY3RseSBwcm9oaWJp
dGVkLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
