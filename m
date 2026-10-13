Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B02CA9ED2
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 12:07:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 638483EA822
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 14:07:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0AA33CA180
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:06:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 63463600566
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:06:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791893192; x=1823429192;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=hJwC1D5H3RPsqU6rvhsfiklW3nSE67/qVEnsKnv2/DU=;
 b=SsjdPT5f5vHZ2gwfMU26pxeGoKigjX2UQfS8GG3nBZFDzAH3qtomb2OZ
 OWePYHKNDpPkcP1Rx5oqDchXUIrb/pn9nOJ42UcSLo0QJRZ8SI3yoC1lF
 InZojlLfuxxW9iyJ5q/6ySRuv4MKMgufVw9B/bYlAqDrm5Nrns2Jt1S02
 hg2Dpw3prNw0GxlNGvozV/YjZITyIAzWuuu6iP0yzQ5gt/4JFPBrK2Iya
 xOPVuHcvx5taPXrM3gp4zIU4/3N93NJwcBZMqjpng3j9MlD8tVv9VzGBq
 NZFXTCANgecfu7s9zm6vTlXbZS+DS89xAkIiNNIkHU2kZhfwuo+4pLEOP w==;
X-CSE-ConnectionGUID: izKrh7m7Q16qL+KSx2Kogw==
X-CSE-MsgGUID: 88gI2XQmSnWR/8pYPVNvng==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="608704"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="608704"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 05:06:29 -0700
X-CSE-ConnectionGUID: ONmzM/tnQ26xWfGrJKdTZQ==
X-CSE-MsgGUID: wrgXFYUORC+vr4qYgQJrdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1118900"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 05:06:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 05:06:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 05:06:28 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 05:06:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHlO6jGVX2BzISb8rHatBQNseZIEztFXywHM7oUgpmTYGKsZx/QQ60P3bvjpXO1bDeUmf7JN8ATGWnZmI2AKarfMJspsx+VCTSvr2/G2/KepLINmuJKBukolHymkwkNCJfbylFXnmTI1UMEO+L0jljEnjP/BKEDI0UgUb28Pt4PFHmkBv++QFZn1qv3gEvTYWPjMz0aY4k5AJ15kktQRm0CwDmki7bknnhdmB2Z28tJFQi3r90KuWrkk7A3xUU7yK0MeGeEOBmhqAvheA/uRPxUjVtdZqFFAmaal374BRB5GeeE6itYJA0AllVc/7xrnNWC2LM0NNuoiw+3mPiidDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTCTW970lpuFnvoRg4CYTprCgyTXAx8GXLHrYttPH10=;
 b=dBtpSaj2CyRsec1gOi65QHoRVnyeZCUkGXCGrMqe7l5aMybL6NxwErx/3MtGTL/IKfCL6EZ2cvHC6TGlB5SE686g1LTwFmmJMcq8v8pMTJMiFE52XLi4q6xAbSqflxEw0aM5gJYjVV2MdhvNnwZK2imxVbrKOe+YyA56963O9CCyh5yKNUh+Tvs/uZCBG6w5b9/+gR9M5fGlRqZTv8q/kTm0b7x6TyAoihCG3N5/MpIUNOStC5E+qWdkCSCF9qRWQhWEVeBfyU2LjOWcj4NvPfiP4kweiPk8PriUM8H3058y/ME64OTMrzucIqmT4Xd5NF0xQkQkzhIy35t6WQuQhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by SJ5PPFA058327E4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::849) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 12:06:26 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 12:06:26 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "pvorel@suse.cz" <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 0/3] pmc_core: cover the PkgC LTR blocker counters
Thread-Index: AQHdPGqmDJGjoTkHdEuBncM82wSWZLblkKaAgAA4xQCAFdRIAA==
Date: Tue, 13 Oct 2026 12:06:26 +0000
Message-ID: <a154869fec3cfb77f724c3c8c0172275cde77866.camel@intel.com>
References: <20260904124042.212065-1-piotr.kubaj@intel.com>
 <281763bcdff18b7512ee8f851979d015e482e987.camel@intel.com>
 <20260929144510.GC2462033@pevik>
In-Reply-To: <20260929144510.GC2462033@pevik>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|SJ5PPFA058327E4:EE_
x-ms-office365-filtering-correlation-id: ced13aec-a964-412f-4fd1-08df2922682d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|56012099006|11063799006|4143699003|261009223027099003|261009221227099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: C0nAy0vIE5GCfLzeInxd3rNFaKvcf+RRbh/VaWPuCU5pB4Bm/SNMIEQIKs+rb7WH88JVc6FYhXJld+MDPFN7t40VFPxKm/MmFN+tsfLL3k4He/r8Oa6QIdK7GS2sh2tH0+MGJ1ulYtSIyE1nmap8/LD6jFz3Fm0qa+ZQciLEj+hnAMshkCnyc5u5TroxOqMQ9qw2AnfU1LPJrwLXKUG16MeESrDLYGfDOxX8W5319o4Sq8gwUkixxpbJDrs/FGwOZSOk0r7Y8I9VgL68GSZE4adeapJAE+vlbqfeNdlPexpR3vPYX0aL9eBOOKBwThqiOIWgI3b2OIfAk4urxfaiRG2nLDk1k30XmvXy+7FAxH1ZrC1GbHbmnb31rHTdM9cwSQPUcjjGhZElptd+z6sP6+wKFBJFtWyt6Tak2vwmr7WvDGO54kS54L7dE/m40VsOB8OfbdQfoQgS/u58YEEMHAhev2uFs4avr2w8f+gKib2Uf1Zbw4aUpMuH8C54pZ72C/OJgUdvSyFQqphqY5VvtnS/lheswJ1i+6LdN5Wm1yULO29kKrEUfWADX7sShQtHAtFrYKj9zGodxioSATMYOIo5+dBQu1wUy+i9gndA/nd+M+ki5Ho55pCONEZbn70Qa/QTWXDwjGh5BmMv2xUzT5e1CdV5wDwvURnvoRBJHp4kYggtelYuzaGnPs76AQUe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(261009223027099003)(261009221227099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3YwYTBQbkRiQ0xaK1dVM0ViQkdlSHBLdUdIOXZ3ODhrUmd4L0hjZ3ZpTHRF?=
 =?utf-8?B?Nk1jR05vZ1gwYStsTE5FZUhwNDFpYllCSmo1UEU0OWtSQ0pGQWc0dnZyWDd3?=
 =?utf-8?B?VHZmeXEzSkJSUzNOVnBwOTFHcjdxdUhIU3p3QXFHSzI3VkFOcVRBdU1mQXJF?=
 =?utf-8?B?RkMzaXRHTkE0QzROZ1RPUEtZODc1SDdmVmovOHFub3JEeHI4WjVPWlBhR3JP?=
 =?utf-8?B?ZEhrNzlyNUJISEVMK2crOSsxWlEwSmN0V0FaTmhyVjY1TDFuYzZvQTlIUDdv?=
 =?utf-8?B?aldqdUZ1eFB6ajFGRVgzQjB3MFRHOXk5bWZ2UUdMeGw1Rmx4SjV2dnM0OHB5?=
 =?utf-8?B?bGJaYTh0VVpTMEt0T21VUkV0MXVRek9kSHpPMHlvZ25rOHdyTXFmbGl4WWps?=
 =?utf-8?B?anlhb2RnM0doSUtKQjF4dE42R3J6Qmk2U0Z1VGhBOUQvdnBROVExNXVqNzJp?=
 =?utf-8?B?Ykk3ZDhDOGZVSHlNOVp4TVh2VmFKQW9FdDJYbXROUzVKb2ppSDJUc0FJcXVR?=
 =?utf-8?B?UTRmRFBPKzNpdFJPYVVXSjkzTTZYSzUraVN5RWxCb3hjYnF6c2MzaEZFcmRx?=
 =?utf-8?B?VmJkem92amRlSG1UaE5WZGxSdFNOQ3hibXpJNlM1Y0xsems3QjJkODFMQ1Bh?=
 =?utf-8?B?R1ZkZXdQUlkreWFCMVA4dWRQN2t0d0hGVk0yRnI5eDVSYk9tbzhNcmdTK2R2?=
 =?utf-8?B?NU9weUMvVTFtWWtEbUVZTjNweWRPOURmMXJsR2t5MVNGSzNEYk5hQzZOUzJo?=
 =?utf-8?B?VGpvNEk1SDF1NW5xZCtTZE5YWk9VeEFIL3dPMisvbGlTUGVRKzRoTzBFV0kv?=
 =?utf-8?B?U0Nobk5vemZPZ0JVRXN5cXhRd1ZvOXZnZWk4NDgvUDlIZGFBVVFCVWlQZEFP?=
 =?utf-8?B?RXBpcmk4OUZ2RlRlRGJCellFT1UvYUZlYmQxclZ2WGh3TDJYNHhZa3JEVXM3?=
 =?utf-8?B?emIybnZWNHJCTlBCQjdWMWt3Qk1KVmE0U0FFYytaQ09PMlNhazBtbDV3bDZ5?=
 =?utf-8?B?L09tWldsaEtNSDZMdjRNMjczRGh0YTdsZDM5L2FnZWZ2eFhHRW52dnl0d2xU?=
 =?utf-8?B?bGx0MkU0cEJEZHQ0TFh3T0VmK2VvcGVZUXpwcklrMUJqVnVtY09nZUVKRHpE?=
 =?utf-8?B?OUpqVlhmNEJwNTI0eGh5M0FJZ2xhNlNVQmhjKzJhQW5HMVNNdDdNaTMwRWd5?=
 =?utf-8?B?amZDRzltOUt3Yk5HaDZaTkUwWE42VU52NVRYTjY1OVNaZll4akg5ZEMrR0J5?=
 =?utf-8?B?NGNWYVZ1cTZuNlorMUg4SkZwNHMxR0hjZ2c0OXVycEdZT1hHdlEvRmNTSDBM?=
 =?utf-8?B?N3JxS1FNclF6QUhQZ29TeDNZc29mNElNWDRsN21qSS9CUU93KzlHZE1kTDdM?=
 =?utf-8?B?R2ZLazlZVDkvKzJSVWZNQzJiRGhXeFdheW1aWDdibUpodGlQRkl5dWNVWmxF?=
 =?utf-8?B?MGc1cWVIZGt3cTU5eDQ5dm9waWpKTW9QTnEwMi9nVzJRV3NPYlRmZ3NzeE01?=
 =?utf-8?B?TGU4UG9NNFdtUkZTak00cTlkZnJRWS9LSUttdzZnNTdWT25HUHdQS0U2dEZy?=
 =?utf-8?B?SHpTWHhjUmcrdVo1S011ek1hM2h1NnVGcUhKM2pKZ3NnVmlMMU9WZGQzRjdE?=
 =?utf-8?B?YWlqOUdmbmVrUTVwa2NvYnpBazZ3eTlqK2k4eGN6VnRXZzFldWUwbGdXNFcz?=
 =?utf-8?B?S2JzZUIwMjZLcE1nTUlxampHTGtQMFl0L2pkOExnVko0R0E5OEc3Y094dlJu?=
 =?utf-8?B?R0tqTmw5UlF3Q3pCVXJlclBMUVREOHV0N0RkVVIrRzk1YmN0c01QaHBpM011?=
 =?utf-8?B?VWhkRjlqZ3ZqdHFVVHJKSkdTRldOT1RaUHFTY0xKU1M3VWF5eGNodDVHZVJS?=
 =?utf-8?B?RE4xNjgrQXdBOXV6dHZqZVh1QldvOVJZK0dib1l0TjNNenNYK0YrN0ZQUzNS?=
 =?utf-8?B?a0M0VDlkc1B1NllXWE9KUmdGQjBTcFlaWmFlNDE5Z0ROMllwVHlTWEc3QStR?=
 =?utf-8?B?dy9kVXc2elpESGVIZjVaWDhYMVBGV0ZaeXVPUGlaS25JZ0lXRytPOCtCNlkx?=
 =?utf-8?B?WnhEZHJWb3Rscis3V3ltcVBWcFF2QTJOdzY0SlQxRXBWQlV2RHpxdWlZbW5x?=
 =?utf-8?B?dFpybWF1c3NQR3lrWHBsZUlDU2w0Rnd3WjlteHlaNjVCdEJjbGxkUmtURUc4?=
 =?utf-8?B?VzhBb2RhZGk3ejIrUnh3cmRFNitlTXY4b2drOW5ENjRZSnRzVnE5M1ZPcExv?=
 =?utf-8?B?Nzc5d1RlWm4wTDhCSEN4VmM0d0NHTjgrRk1Gd01DWVFQbWtqWTdXclNKMm1o?=
 =?utf-8?B?Y0JyOWFXUUdkTnp4Tmt5cys2Y0ZYY2p0TEd5MkM5QVpqOHNQbUJhK1FXdlh3?=
 =?utf-8?Q?iZAQsEVHwe3PLLiI=3D?=
Content-ID: <51E7EFDCC532694FABE71B0EBD44BF6F@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pYO0pwz6ULVPwWgROAgoeAzhR1WO53FVJH4m8pWseDwP/aiRHvC0KizjHL/+XFIcce7BsJHdWRq9ozqylu0ppsQ6HRMZmFZfbRaYLMNjPgAftU+usCQbxqfnY2k/R0qv8U+0QamVFf7S6rem3uf5+yi3muR31l91ONKRQTIB3fw3XSt4yfSeB5qb9Aj2nJwIHwz7st6mrdpBwPYjf6VrUqRmwt/kNzMD8AZPpewGphIJou4d9Z2J1fTsHQOsjH9IxqGWPua2DLv+NDNjp/kSUhOLyo4I+x9DntUf8RxazT+uDNMFbORB41g3bt4cvF5KHU8IFXIcZlQFUiBbLRI1RQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced13aec-a964-412f-4fd1-08df2922682d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 12:06:26.3120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOFonyX5XW3LfCTVk5UbbZbBsCBiAIYfAqF7Q22VM0PYtjlgglhR2j5DieoVyosHjvHmCjOkTBsUvIeVrOOH7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA058327E4
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] pmc_core: cover the PkgC LTR blocker counters
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
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Ossowski,
 Tomasz" <tomasz.ossowski@intel.com>, "Dubel,
 Helena Anna" <helena.anna.dubel@intel.com>, "Niestepski,
 Daniel" <daniel.niestepski@intel.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

V8KgZG5pdSB3dG8sIDI5LjA5LjIwMjYgb8KgZ29kemluaWUgMTbiiLY0NeKAiSswMjAwLCB1xbx5
dGtvd25payBQZXRyIFZvcmVsDQpuYXBpc2HFgjoNCj4gSGkgUGlvdHIsDQo+IA0KPiA8c25pcD4N
Cj4gDQo+ID4gSGVsbG8sDQo+IA0KPiA+IGZvciBzb21lIHJlYXNvbiBJIGhhdmVuJ3QgZ290IGFu
eSByZXBseSBlaXRoZXIgZnJvbSB0aGUgZGV2ZWxvcGVycw0KPiA+IG9yDQo+ID4gdGhlIEFJIGJv
dC4gSG93ZXZlciwgYWxsIHRoZSBDSSB0ZXN0cyBhdA0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcHJvamVjdC9sdHAvbGlzdC8/c2VyaWVzPTExNjQzNTfCoHNlZW0NCj4gPiB0bw0K
PiA+IHBhc3MuIElzIHRoZXJlIGFueSByZW1haW5pbmcgaXNzdWU/DQo+IA0KPiBXZSBzdHJpdmUg
dG8gZG8gTFRQIHJlbGVhc2UsIG5vIG1vcmUgdGltZSBmb3IgY29tcGxldGVseSBuZXcgdGVzdHMu
DQo+IFBsZWFzZSBiZQ0KPiBwYXRpZW50Lg0KPiANCj4gUXVpZXQgYWdlbnQ6IGVuZCBvZiB0aGUg
bW9udGgsIGxpa2VseSBvdXQgb2YgdG9rZW5zLg0KPiANCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gLS0N
Cj4gPiBJbnRlbCBUZWNobm9sb2d5IFBvbGFuZCBzcC4geiBvLm8uDQo+ID4gdWwuIFNsb3dhY2tp
ZWdvIDE3MyB8IDgwLTI5OCBHZGFuc2sgfCBTYWQgUmVqb25vd3kgR2RhbnNrIFBvbG5vYyB8DQo+
ID4gVklJIFd5ZHppYWwgR29zcG9kYXJjenkgS3Jham93ZWdvIFJlamVzdHJ1IFNhZG93ZWdvIC0g
S1JTIDEwMTg4MiB8DQo+ID4gTklQIDk1Ny0wNy01Mi0zMTYgfCBLYXBpdGFsIHpha2xhZG93eSAy
MDAuMDAwIFBMTi4NCj4gPiBTcG9sa2Egb3N3aWFkY3phLCB6ZSBwb3NpYWRhIHN0YXR1cyBkdXpl
Z28gcHJ6ZWRzaWViaW9yY3kgdw0KPiA+IHJvenVtaWVuaXUgdXN0YXd5IHogZG5pYSA4IG1hcmNh
IDIwMTMgci4gbyBwcnplY2l3ZHppYWxhbml1DQo+ID4gbmFkbWllcm55bSBvcG96bmllbmlvbSB3
IHRyYW5zYWtjamFjaCBoYW5kbG93eWNoLg0KPiANCj4gPiBUYSB3aWFkb21vc2Mgd3JheiB6IHph
bGFjem5pa2FtaSBqZXN0IHByemV6bmFjem9uYSBkbGEgb2tyZXNsb25lZ28NCj4gPiBhZHJlc2F0
YSBpIG1vemUgemF3aWVyYWMgaW5mb3JtYWNqZSBwb3VmbmUuIFcgcmF6aWUgcHJ6eXBhZGtvd2Vn
bw0KPiA+IG90cnp5bWFuaWEgdGVqIHdpYWRvbW9zY2ksIHByb3NpbXkgbyBwb3dpYWRvbWllbmll
IG5hZGF3Y3kgb3Jheg0KPiA+IHRyd2FsZSBqZWogdXN1bmllY2llOyBqYWtpZWtvbHdpZWsgcHJ6
ZWdsYWRhbmllIGx1Yg0KPiA+IHJvenBvd3N6ZWNobmlhbmllIGplc3QgemFicm9uaW9uZS4NCj4g
PiBUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIG1heSBjb250YWluIGNvbmZpZGVudGlh
bCBtYXRlcmlhbA0KPiA+IGZvciB0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVu
dChzKS4gSWYgeW91IGFyZSBub3QgdGhlDQo+ID4gaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ug
Y29udGFjdCB0aGUgc2VuZGVyIGFuZCBkZWxldGUgYWxsDQo+ID4gY29waWVzOyBhbnkgcmV2aWV3
IG9yIGRpc3RyaWJ1dGlvbiBieSBvdGhlcnMgaXMgc3RyaWN0bHkNCj4gPiBwcm9oaWJpdGVkLg0K
PiANCj4gUGxlYXNlIHJlY29uc2lkZXIgZHJvcHBpbmcgdGhpcyB3aGVuIHBvc3RpbmcgdG8gTUwN
Cj4gaHR0cHM6Ly9zdWJzcGFjZS5rZXJuZWwub3JnL2V0aXF1ZXR0ZS5odG1sI2RvLW5vdC1pbmNs
dWRlLWNvbmZpZGVudGlhbGl0eS1kaXNjbGFpbWVycw0KPiANCj4gS2luZCByZWdhcmRzLA0KPiBQ
ZXRyDQpUaGFua3MsIHJlc2VudCwgaG9wZSB0aGlzIHRpbWUgdGhlcmUgYXJlIHNwYXJlIHRva2Vu
cy4NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQpJbnRlbCBUZWNobm9sb2d5IFBvbGFuZCBzcC4geiBvLm8uCnVsLiBT
bG93YWNraWVnbyAxNzMgfCA4MC0yOTggR2RhbnNrIHwgU2FkIFJlam9ub3d5IEdkYW5zayBQb2xu
b2MgfCBWSUkgV3lkemlhbCBHb3Nwb2RhcmN6eSBLcmFqb3dlZ28gUmVqZXN0cnUgU2Fkb3dlZ28g
LSBLUlMgMTAxODgyIHwgTklQIDk1Ny0wNy01Mi0zMTYgfCBLYXBpdGFsIHpha2xhZG93eSAyMDAu
MDAwIFBMTi4KU3BvbGthIG9zd2lhZGN6YSwgemUgcG9zaWFkYSBzdGF0dXMgZHV6ZWdvIHByemVk
c2llYmlvcmN5IHcgcm96dW1pZW5pdSB1c3Rhd3kgeiBkbmlhIDggbWFyY2EgMjAxMyByLiBvIHBy
emVjaXdkemlhbGFuaXUgbmFkbWllcm55bSBvcG96bmllbmlvbSB3IHRyYW5zYWtjamFjaCBoYW5k
bG93eWNoLgoKVGEgd2lhZG9tb3NjIHdyYXogeiB6YWxhY3puaWthbWkgamVzdCBwcnplem5hY3pv
bmEgZGxhIG9rcmVzbG9uZWdvIGFkcmVzYXRhIGkgbW96ZSB6YXdpZXJhYyBpbmZvcm1hY2plIHBv
dWZuZS4gVyByYXppZSBwcnp5cGFka293ZWdvIG90cnp5bWFuaWEgdGVqIHdpYWRvbW9zY2ksIHBy
b3NpbXkgbyBwb3dpYWRvbWllbmllIG5hZGF3Y3kgb3JheiB0cndhbGUgamVqIHVzdW5pZWNpZTsg
amFraWVrb2x3aWVrIHByemVnbGFkYW5pZSBsdWIgcm96cG93c3plY2huaWFuaWUgamVzdCB6YWJy
b25pb25lLgpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIG1heSBjb250YWluIGNvbmZp
ZGVudGlhbCBtYXRlcmlhbCBmb3IgdGhlIHNvbGUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGll
bnQocykuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBjb250
YWN0IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSBhbGwgY29waWVzOyBhbnkgcmV2aWV3IG9yIGRpc3Ry
aWJ1dGlvbiBieSBvdGhlcnMgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4KCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
