Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8ACCD8CB2
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 08:03:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B94E83E5E99
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 10:03:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0034C3E183A
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 10:02:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 50BBE1A00F77
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 10:02:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781078573; x=1812614573;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=yNzhUr0i20a7HZMCz/Xhfe6bVAnw+CkipuxDNLd+2Bs=;
 b=dKwep9UUpXPivwSB2uQgrVHH5pNlTbbA9h8U+DKVGBgh+QTMMLxmqd/p
 stCyiy2LNzBGUaCjYb20zvSZhcVKrN3qU5OZcCS4n/ZUA0qgloReYjMdx
 25jf62YQvqn6lzMEpzu6DliEwoEKQb8XLRhV4o/pc+CVybr7iaa7qDyg9
 VnLV2D/sz6jwrKos8QSGAvraXnRqlr+LGK7UO9ORwzQSy6YyDaZBdI+cQ
 pcaPUClKHV0PtX+6W/hZYRdX0Te/bq6l3copK+0YJT0c2BS7yduhFx1va
 fHRjq/kqL7t+t1hncIVej4VXZQO6Yl9/pj8cMqzi8fnXT0JVokG3vndMJ g==;
X-CSE-ConnectionGUID: eITMuNNeQpugpDKhVqQn7w==
X-CSE-MsgGUID: s/bnkfSfQOKvqlPCtMYZHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="99442414"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="99442414"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 01:02:48 -0700
X-CSE-ConnectionGUID: 4U9AJTmrTk+1ANxdOTpnig==
X-CSE-MsgGUID: PoLYLCd4RFuoqA61JZL/sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="250035609"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 01:02:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 01:02:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 01:02:47 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.18) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 01:02:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7m91N9JTAaRV62vzlbHTWF73igU47UrDzehKS74aKQt17kP8NxdQC1mxc6+IMqI0S21nnC7Fkq1FWJk9H/BdpFHhc3cFORoMeLGZ+RcSIbq/jgeKuXSJmMJ6QKJ666zTSTIlOIex9XsMqvNyXoKpvfyQMaBczYBA48a8TpPAPNhBJcWgXuwUpEGkiTpuMR9eE/Z9PU2TJ5aH9PkJjTQE0Zlon9kmEyhNCGkgWcthXyXx79kKYL6BJvv2NHHR55GJzO69ffx+YvWZ3ZuBRj2WM+5zFcBNxdYBbDFKdRYdm9rSXpr3XkEN69eJVtDNOFeRRJsiHrGX+iCLBH2Yu2JbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndBRcROlVQ781p/eMmgFQy5o8jHQLMUQPlJXrj/Gp5o=;
 b=ygEArkRJwAL2y0bupS+LDpV86xtJo8zngGpjnBAu8TR614b692T7Iv5IDOw65rlhgyST2wwTwyGhwhJdrB+vMAWYdOCtZ6tvGnPeVrMrbhVVtu3HjEG+fLqsu5Xcksoj64KXhCv+g/zNc8V+5FMALqeyE3XufiQkFwENRlX9N4Xkimx5lmdYbUvypVCqYdqCFL1wdBiHV6uH+S8rXkY3Q4P93WepbNP5x2UHn+uiWdsLFHRCyH88F2dGv+2d7GPgzJkfWDA1/9+HpT8QPwSopb/tsZn9gMiWniA9EG1KSR3D6Jc5nPAozRgfu9pnBhk3FWT2E0ofpTC/wJA+BdT28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by PHXPR11MB9662.namprd11.prod.outlook.com (2603:10b6:510:3cd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 08:02:44 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%3]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 08:02:44 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "chrubis@suse.cz" <chrubis@suse.cz>
Thread-Topic: [LTP] thermal: add new test group
Thread-Index: AQHc46yvXeKfCE06bke+L7mzmc0z47YPKtEAgARJwwCADhjogIAUwPeAgAFJO4A=
Date: Wed, 10 Jun 2026 08:02:44 +0000
Message-ID: <4ba236b8e3c815ba2a6ce3ced8a3cef73e0aad51.camel@intel.com>
References: <20260514133446.144550-2-piotr.kubaj@intel.com>
 <20260514141912.4030-1-linuxtestproject.agent@gmail.com>
 <20260515144242.GB40164@pevik>
 <d1e90d8d94fd4cb58f34cbff4a07b49257195129.camel@intel.com>
 <21a5a4cec4cbb9a7084b8b5374fa06865a0d74d8.camel@intel.com>
 <aigF9StEMr3oNPFD@yuki.lan>
In-Reply-To: <aigF9StEMr3oNPFD@yuki.lan>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|PHXPR11MB9662:EE_
x-ms-office365-filtering-correlation-id: 6d985f57-f7f8-4c98-0bca-08dec6c6a750
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|4143699003|6133799003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: aglxtM4FHnMzEvwS4vBZt56su3XsH41VB2+wikr1Xn1l/vBFJ5+8iwn7B9vLdkJ6zJY7I9yFOwP/bud+N9bXcM+fDnifUCpgdx6EWC/kZjTaZiET32P8/WC+bpy1AGo5ImKc216fbPQtE0Ab5r4wlAzjYBiUzq0NaxLwwzVCW3cpe3MdMcM8ZmPaBRY+Xuk/97k6Y4yj+65XgmH2nVpToxBLb+cOxJTTMLmZBvVIlwO4c6jOd4NG3Nz9UXpYaCQLE7gEnUdfhw1rTJIjrtwrUttZp2sldpenHYP1CB+TF69SdPAYTQSN5a6mcf3Ju68fMeUi480n0hva9n5MjmQzYNgGTr/8magbVY3OiojsKEZOEeQjbkFlfP8wb6kQKvWQIYVKEsQl/Cc3MapVEuVDgkTSpBRaKWhCH+hTTaYApHOL4UbgYLPUWa0RIAZC1c61YfvrP1HCQ6s/CQuAGlstVsDQUSBbs9yu6KVwo1sbKvjlDn60xxUUXqaxiO3OuMsRjg7J9YFDvC4xEVO7nKtekuN5DbpVMGXC+m6XxaMwc8us2fguMxsXYy2ZfycL2gFUDMEbEd7snEPwPeDWebv9fNNQDBaSQEwOcXC2oWyd5V0OxaVASII4UHVK/CMoUKfJ/6Doz5UL14srB9IbtLsF0LmXo7hGKOILkvuV0GB/Xc7wlvsyw9U2t5DQkjhka+1MwC8BDN479XODtyhqbH5M/xF3EnEgvGed20249ZTWWXB9AkBNoyAo90NJQ4Ns5RAN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(4143699003)(6133799003)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0F5TmJwcXJzbDlDc0pnQnpPZVN4bUEyYlZQVExLcVBzRThSQ0tVQTFvVy9O?=
 =?utf-8?B?MklyN1Q0eXJXNFo1d3dFVTg1Zk8xOEkwU1VaYnNLNkJFaTNPNmQ1OXB4bEZs?=
 =?utf-8?B?UXNLWkFWOCtHaUdvN1AxelZBdHpKRlFYSUlJTENsOHI5Wis4VHpMK1NVelBl?=
 =?utf-8?B?b1UxanAzQ3phcFNpWERlUHFJdmVqMGNTRWhydUw5OC9qNHJXd1U5TGpHa1Q0?=
 =?utf-8?B?b1MzaEdlWnlWRFg1NWs4UDN6T1RrYTZnYWc1TWtMNHV2K29sZzU5QXZXQWUx?=
 =?utf-8?B?L1FGUk9oUWk3NTVENUN6TmZYSWRqTDAvVHBQS3FqdFpPRDU3SFRrZVNnMmh4?=
 =?utf-8?B?eEFXRmN4ZGZ5dVVoQW44RlJvRHBWWkFNUTJmL0pzUlMwQjFtaGFLN3NkRFNB?=
 =?utf-8?B?Y0N5bEVkWmRpbXhib0VnSmd6WVA5TUFQcndPN3VpMWxJWlZ3Ri9BTkxrOGVn?=
 =?utf-8?B?bDhVUCtzcW0rRGk5U2Y4eGVQYmFURVdsV2ptY0ZOWVNpZ3pvVU80UkNhblNt?=
 =?utf-8?B?endFTzVaKzFQOXpZcjVKL3lESC9FZHkwVlRZVkdqa3RDa2dFMnY1MllFRlI4?=
 =?utf-8?B?QVB3c3BwTnNXS2xUbDRyRnpqYUcxbzlWdUc2ME82aEhhcmpJbk5sM0RsVUMr?=
 =?utf-8?B?bnRIVTNUWFVjUFk5b2xUdnpOV0RTU3JXbUMzK2svQXN3UDJrNGYzR25kTHdz?=
 =?utf-8?B?TzJRRVREOXNjRUVvd1MzVkIrb3dJczhaN1NIcENmM3EyZ2FFL0tHWmMrcVJD?=
 =?utf-8?B?QnpXQ1Q1K0dJVVJENnpsVzZocks3N0JPTmNKd3pIeGpQNE9nUVpucmdQeklY?=
 =?utf-8?B?UGNNcVNocnh1MmhxclQwazRCRFFjK2RUU1lwT3BkblJwVm52dy91MXZDc0ZL?=
 =?utf-8?B?REhJTWdqRmkyQXpMbDU2dGxsNjVybUlMaFBBV3M3SkJZbFRpM3JhTVozU0Nv?=
 =?utf-8?B?V1ZkRHgzbk9WeW95ay9RTTR5dUUxVFpnVFV1dUpuYjBmdzRCcDhLanZUd2NV?=
 =?utf-8?B?MjJpU2RPYythTXR6V3hvdTYraHM2a3Vrd2RoVDhzQVlPSzhiWWtHMllCemlO?=
 =?utf-8?B?UFJPOHBlWHh1dzcvVDBSVFp2ZlVPK1h0cVFPZ2xjTFptWjVwM3J5UHNDa1hK?=
 =?utf-8?B?SXVFS3ZLaVZ5c0NzUHNZQWFYZFJkWnJ1NSs2WTFENEJTbGVYR2tDRTlTbDFu?=
 =?utf-8?B?K1RJeWpGMWxwNU0xQUp4WW5UeVhkUCs4L0ZNQWpuOVdWdWhKWkdHcDVIKy9v?=
 =?utf-8?B?YW1oK002T2xyeUJxTWQ0WFJxYmwzSVY4YVk3aGM1cnFNVFhQc0oxUjQ4NzN0?=
 =?utf-8?B?L2REazM5Nk9VZjdJZFpuamExMENUczNGVERBWktmWTB4a3RuUkU4eC9aQ1Rm?=
 =?utf-8?B?ZEZEdU5YRUp5c1NRT1BmZThvU2N0bXd6U1RCbVIxTnkxQUw5bkFwQ2s0Y281?=
 =?utf-8?B?OXBlT3dyNGdhMjRGVk1paGtUYVljZ01LYmt3M3BMUFlhMWdzdDUvekR1RExo?=
 =?utf-8?B?R2hUbnJuZit5NVA3MkhjbXlOdXdHM2s3NkhqVnZoTVZjRkFPNitNK3NrR09P?=
 =?utf-8?B?ZXdEU2sxdnRzendCTkN5OU9sTkFXbmhNOWY5NmdyUnlwV2Q0UE9UZDlxSytk?=
 =?utf-8?B?czU4VTllR3R4OTRHKzR6bjRqQlZQa0JQVUsrN0h2NW9FTFFIQVVxSWw2dnQv?=
 =?utf-8?B?TkE1SXI1NnJ5V1dXZkd2eitVNmZaTGExa1YyOElENFpSVk91SHNVdlN4WERa?=
 =?utf-8?B?OHY3NUlOTVBnWW5CMXd0NmlYVWtscDlmVjN2V1dMNjhFZWFxZFhUUDRpa3Bh?=
 =?utf-8?B?TUFETk5jZVUwUnYzMVdYNUFTK1dqOWZxWGRQdk11b1FsbFlTRnlVeFFSbURy?=
 =?utf-8?B?ZUN6U2k4QVZHVHRpdDZRWjQvR0lWa08vVlZxbTdtaE5RWHptU2ZablVKaW85?=
 =?utf-8?B?eDhDaW9QRGxEdFBJVFVOY0N6akEzV2NHdXl4cXYwS0NJTzBJbDhLNFVFK2Rt?=
 =?utf-8?B?NHNZWmZ1cGpNS0M3b2drQXYrT0NXR21WaitueTc2UXFkN1E0aWs0czJWM05F?=
 =?utf-8?B?a0syai9xSWMzWjJRZjFpUlhaOFdGWDZ1cmx3S1hkRHlsQUhQeE5BeFY1ZzBW?=
 =?utf-8?B?R3N3YWxjOWgzTURoY3pPL1lDdGtxUmlYNDVmRHB6YXl4UVJaZ0F5VUJQa2V1?=
 =?utf-8?B?K2dvd2tKWER5R1BvUUhBdHJYT09lQ2FUU2hrNVUvM05GZVlpbTB0ZUxva1E1?=
 =?utf-8?B?REMwWXhpSHNtaWYzY0RFdk5nTklJSnhxdHp6eEZDWml0eFY3aGNpVXFEQWtC?=
 =?utf-8?B?REVhOUFodFowMTJDS0ZsdUI4RHJZT2F1SGF0Z2w4WWpWbnpYdmNEV0szQ1Q3?=
 =?utf-8?Q?hN6C3Y0AuhECI4fw=3D?=
Content-ID: <3BD663B3A56D834EAE6EF5C89029C682@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N3tm9xIqcjN1p3kO+pJtAvXDjPAABROK9BMpUzW4bTfj8XsHW0ozYK5yX9XIxp4SdLhdVLryfc5csJUAkjw8Wnaf4EH806VGTdMABjmwxuG20Axz+QjMQ70+pF+ckeqk00BLCUQtU4+sM7ux8NVsNHKLLm0pZsrFu1sOBUQqTX6pe9uZhJGs2vsVebIYxv4cdDRQGCmhmIFw11esrolziB16DLBppP+F9GYqJ0xPcmrHWSDkBQsIrugiZkTwUSHyszq4ghFWgswvummd83OoZEpXZEe7IuNK7MRh3veThqJs6or8UKMPc3V2qsq8VLWrLifeOj02lfOOm5YTIVtT7Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d985f57-f7f8-4c98-0bca-08dec6c6a750
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 08:02:44.5036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dJzv3fmIlf3B/MT4Fe0OmwxCdBjssJ0kjPyVB2Y9qIy7NmSrg/kBUa3/82gL22S9cItpzx13RuOHjMcXNsmbfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR11MB9662
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "linuxtestproject.agent@gmail.com" <linuxtestproject.agent@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SSB0aGluayB5b3VyIGNoYW5nZXMgbG9vayBnb29kLCBwbGVhc2UgcHVzaCEKCjIwMjYtMDYtMDkg
KOeBqykg44GuIDE0OjI0ICswMjAwIOOBqyBDeXJpbCBIcnViaXMg44GV44KT44Gv5pu444GN44G+
44GX44GfOgo+IEhpIQo+IEkndmUgYmVlbiBkZWJ1Z2dpbmcgdGhlIHRlc3QgcmFuZG9tIGZhaWx1
cmVzIGFuZCBpdCBhbGwgYm9pbHMgZG93biB0bwo+IHR3byB0aGluZ3M6Cj4gCj4gLSB0aGUgc3lz
ZnMgdGVtcGVyYXR1cmUgdmFsdWVzIGFyZSBpbiBtQyB0aGUgaW5jcmVtZW50IHdlIGhhdmUgaXMg
d2F5Cj4gwqAgdG9vIHNtYWxsCj4gCj4gLSB3ZSBuZWVkIHRvIHNldCB0aGUgdHJpZ2dlciB2YWx1
ZSBpbiB0aGUgd2hpbGUoc2xlZXBfdGltZSA+IDApIGxvb3AKPiDCoCBvdGhlcndpc2Ugd2UgY2Fu
IGVuZCB1cCBydW5uaW5nIGFsbCB0aGUgaXRlcmF0aW9ucyB3aXRoIGEgdmFsdWUKPiB0aGF0Cj4g
wqAgaXMgdG9vIGhpZ2ggKGlmIHdlIGVudGVyIHRoZSBmdW5jdGlvbiB3aGVuIHRoZSBDUFUgdGVt
cGVyYXR1cmUgd2FzCj4gwqAgaGlnaCkKPiAKPiBUaGUgdGVzdCBydW5zIHJlbGlhYmx5IGZvciBt
ZSB3aXRoIC1pIDEwMCB3aXRoIHRoZXNlIGNoYW5nZXMsIEkgY2FuCj4gcHVzaAo+IHRoZSB0ZXN0
IHdpdGggdGhlc2UgY2hhbmdlcyBhZGRlZCBpZiB5b3UgYWdyZWU6Cj4gCj4gZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9rZXJuZWwvdGhlcm1hbC90aGVybWFsX2ludGVycnVwdF9ldmVudHMuYwo+IGIv
dGVzdGNhc2VzL2tlcm5lbC90aGVybWFsL3RoZXJtYWxfaW50ZXJydXB0X2V2ZW50cy5jCj4gaW5k
ZXggNDJlMTUzMmY2Li5lZDU1NjMyZGMgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC90
aGVybWFsL3RoZXJtYWxfaW50ZXJydXB0X2V2ZW50cy5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC90aGVybWFsL3RoZXJtYWxfaW50ZXJydXB0X2V2ZW50cy5jCj4gQEAgLTIwLDEwICsyMCwxMCBA
QAo+IMKgI2luY2x1ZGUgInRzdF90aW1lcl90ZXN0LmgiCj4gCj4gwqAjZGVmaW5lwqDCoMKgwqDC
oMKgwqAgVEVTVF9SVU5USU1FwqDCoMKgICgoUlVOVElNRSArIFNMRUVQVElNRSkgKiAoU0xFRVBU
SU1FIC8KPiAyKSArIENPT0xET1dOKQo+IC0jZGVmaW5lwqDCoMKgwqDCoMKgwqAgUlVOVElNRcKg
wqDCoMKgwqDCoMKgwqAgMzAKPiArI2RlZmluZcKgwqDCoMKgwqDCoMKgIFJVTlRJTUXCoMKgwqDC
oMKgwqDCoMKgIDEwCj4gwqAjZGVmaW5lwqDCoMKgwqDCoMKgwqAgU0xFRVBUSU1FwqDCoMKgwqDC
oMKgIDEwCj4gwqAjZGVmaW5lwqDCoMKgwqDCoMKgwqAgQ09PTERPV07CoMKgwqDCoMKgwqDCoCAz
MDAKPiAtI2RlZmluZcKgwqDCoMKgwqDCoMKgIFRFTVBfSU5DUkVNRU5UwqAgMTAKPiArI2RlZmlu
ZcKgwqDCoMKgwqDCoMKgIFRFTVBfSU5DUkVNRU5UwqAgNTAwMAo+IAo+IMKgc3RhdGljIGJvb2wg
Kng4Nl9wa2dfdGVtcF90ejsKPiDCoHN0YXRpYyBjaGFyIHRlbXBfcGF0aFtQQVRIX01BWF0sIHRy
aXBfcGF0aFtQQVRIX01BWF07Cj4gQEAgLTEzNSwxMyArMTM1LDggQEAgc3RhdGljIHZvaWQgY3B1
X3dvcmtsb2FkKGRvdWJsZSBydW5fdGltZSkKPiDCoMKgwqDCoMKgwqDCoCB9Cj4gwqB9Cj4gCj4g
LXN0YXRpYyB2b2lkIHRlc3Rfem9uZShpbnQgaSkKPiArc3RhdGljIHZvaWQgc2V0X3RyaXBwb2lu
dCh2b2lkKQo+IMKgewo+IC3CoMKgwqDCoMKgwqAgaW50IHNsZWVwX3RpbWUgPSBTTEVFUFRJTUU7
Cj4gLcKgwqDCoMKgwqDCoCBkb3VibGUgcnVuX3RpbWUgPSBSVU5USU1FOwo+IC0KPiAtwqDCoMKg
wqDCoMKgIHNucHJpbnRmKHRlbXBfcGF0aCwgUEFUSF9NQVgsCj4gIi9zeXMvY2xhc3MvdGhlcm1h
bC90aGVybWFsX3pvbmUlZC90ZW1wIiwgaSk7Cj4gLcKgwqDCoMKgwqDCoCB0c3RfcmVzKFRJTkZP
LCAiVGVzdGluZyAlcyIsIHRlbXBfcGF0aCk7Cj4gwqDCoMKgwqDCoMKgwqAgU0FGRV9GSUxFX1ND
QU5GKHRlbXBfcGF0aCwgIiVkIiwgJnRlbXApOwo+IMKgwqDCoMKgwqDCoMKgIGlmICh0ZW1wIDwg
MCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHN0X2JyayhUQlJPSywgIlVuZXhw
ZWN0ZWQgem9uZSB0ZW1wZXJhdHVyZSB2YWx1ZQo+ICVkIiwgdGVtcCk7Cj4gQEAgLTE1MCwxMCAr
MTQ1LDIxIEBAIHN0YXRpYyB2b2lkIHRlc3Rfem9uZShpbnQgaSkKPiAKPiDCoMKgwqDCoMKgwqDC
oCB0ZW1wX2hpZ2ggPSB0ZW1wICsgVEVNUF9JTkNSRU1FTlQ7Cj4gCj4gLcKgwqDCoMKgwqDCoCBz
bnByaW50Zih0cmlwX3BhdGgsIFBBVEhfTUFYLAo+ICIvc3lzL2NsYXNzL3RoZXJtYWwvdGhlcm1h
bF96b25lJWQvdHJpcF9wb2ludF8xX3RlbXAiLCBpKTsKPiAtCj4gwqDCoMKgwqDCoMKgwqAgdHN0
X3JlcyhUREVCVUcsICJTZXR0aW5nIG5ldyB0cmlwX3BvaW50XzFfdGVtcCB2YWx1ZTogJWQiLAo+
IHRlbXBfaGlnaCk7Cj4gwqDCoMKgwqDCoMKgwqAgU0FGRV9GSUxFX1BSSU5URih0cmlwX3BhdGgs
ICIlZCIsIHRlbXBfaGlnaCk7Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIHRlc3Rfem9uZShpbnQg
aSkKPiArewo+ICvCoMKgwqDCoMKgwqAgaW50IHNsZWVwX3RpbWUgPSBTTEVFUFRJTUU7Cj4gK8Kg
wqDCoMKgwqDCoCBkb3VibGUgcnVuX3RpbWUgPSBSVU5USU1FOwo+ICsKPiArwqDCoMKgwqDCoMKg
IHNucHJpbnRmKHRlbXBfcGF0aCwgUEFUSF9NQVgsCj4gIi9zeXMvY2xhc3MvdGhlcm1hbC90aGVy
bWFsX3pvbmUlZC90ZW1wIiwgaSk7Cj4gK8KgwqDCoMKgwqDCoCBzbnByaW50Zih0cmlwX3BhdGgs
IFBBVEhfTUFYLAo+ICIvc3lzL2NsYXNzL3RoZXJtYWwvdGhlcm1hbF96b25lJWQvdHJpcF9wb2lu
dF8xX3RlbXAiLCBpKTsKPiArCj4gK8KgwqDCoMKgwqDCoCB0c3RfcmVzKFRJTkZPLCAiVGVzdGlu
ZyAlcyIsIHRlbXBfcGF0aCk7Cj4gKwo+ICvCoMKgwqDCoMKgwqAgc2V0X3RyaXBwb2ludCgpOwo+
IAo+IMKgwqDCoMKgwqDCoMKgIHdoaWxlIChzbGVlcF90aW1lID4gMCkgewo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB0c3RfcmVzKFRERUJVRywgIlJ1bm5pbmcgZm9yICVmIHNlY29u
ZHMsIHRoZW4KPiBzbGVlcGluZyBmb3IgJWQgc2Vjb25kcyIsIHJ1bl90aW1lLCBzbGVlcF90aW1l
KTsKPiBAQCAtMTczLDcgKzE3OSw5IEBAIHN0YXRpYyB2b2lkIHRlc3Rfem9uZShpbnQgaSkKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHRlbXAgPiB0ZW1wX2hpZ2gpCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2xlZXAoc2xlZXBfdGltZS0tKTsKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBydW5fdGltZSAtPSAzOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJ1bl90aW1lLS07Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNldF90cmlwcG9pbnQoKTsKPiDCoMKgwqDCoMKgwqDCoCB9Cj4gwqB9Cj4gCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQpJbnRlbCBUZWNobm9sb2d5IFBvbGFuZCBzcC4geiBvLm8uCnVsLiBTbG93YWNraWVnbyAx
NzMgfCA4MC0yOTggR2RhbnNrIHwgU2FkIFJlam9ub3d5IEdkYW5zayBQb2xub2MgfCBWSUkgV3lk
emlhbCBHb3Nwb2RhcmN6eSBLcmFqb3dlZ28gUmVqZXN0cnUgU2Fkb3dlZ28gLSBLUlMgMTAxODgy
IHwgTklQIDk1Ny0wNy01Mi0zMTYgfCBLYXBpdGFsIHpha2xhZG93eSAyMDAuMDAwIFBMTi4KU3Bv
bGthIG9zd2lhZGN6YSwgemUgcG9zaWFkYSBzdGF0dXMgZHV6ZWdvIHByemVkc2llYmlvcmN5IHcg
cm96dW1pZW5pdSB1c3Rhd3kgeiBkbmlhIDggbWFyY2EgMjAxMyByLiBvIHByemVjaXdkemlhbGFu
aXUgbmFkbWllcm55bSBvcG96bmllbmlvbSB3IHRyYW5zYWtjamFjaCBoYW5kbG93eWNoLgoKVGEg
d2lhZG9tb3NjIHdyYXogeiB6YWxhY3puaWthbWkgamVzdCBwcnplem5hY3pvbmEgZGxhIG9rcmVz
bG9uZWdvIGFkcmVzYXRhIGkgbW96ZSB6YXdpZXJhYyBpbmZvcm1hY2plIHBvdWZuZS4gVyByYXpp
ZSBwcnp5cGFka293ZWdvIG90cnp5bWFuaWEgdGVqIHdpYWRvbW9zY2ksIHByb3NpbXkgbyBwb3dp
YWRvbWllbmllIG5hZGF3Y3kgb3JheiB0cndhbGUgamVqIHVzdW5pZWNpZTsgamFraWVrb2x3aWVr
IHByemVnbGFkYW5pZSBsdWIgcm96cG93c3plY2huaWFuaWUgamVzdCB6YWJyb25pb25lLgpUaGlz
IGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBtYXRl
cmlhbCBmb3IgdGhlIHNvbGUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykuIElmIHlv
dSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBjb250YWN0IHRoZSBzZW5k
ZXIgYW5kIGRlbGV0ZSBhbGwgY29waWVzOyBhbnkgcmV2aWV3IG9yIGRpc3RyaWJ1dGlvbiBieSBv
dGhlcnMgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
