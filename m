Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB77CD98CC
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 14:21:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6BFC3C701F
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 16:21:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2792A3C55F5
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 16:20:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C065E600857
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 16:20:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781187647; x=1812723647;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=hWtx46zkgZJolFba2wWqnpu9UsgivnxfQ180FZ7PUjQ=;
 b=TXTjcd7tqCiNG397fV4Sw9hS66ibkKkSflq0RikS/g7tiKulON407apu
 b2wX8iX5Gl5xy11/CGJx5UKYc6BBCxYv2sBNooHomTkUdTS3eSWvWRVJC
 WmgSoKgAo4A1KZSpafagmn+/jRXGq2yeUFXBSW/Wm2Z1F9+TKg5TbbQQ9
 I6eCI6+JTFc2H2Wj+Tofx4MiCGkALNwB9g4f+jJb+GTj6g8KK2/fWTkq6
 QVT8wJIJ/6Vw0qbMJL5bxvz9fVPs7+DFGrLS2CMvaCzsRL6mewT6/46oW
 OybLxRwXMXbDUUXycRO8cwXlOIk+CJtpBCQ0ZHeikOClAb0eN/Pu+b6ug A==;
X-CSE-ConnectionGUID: 4NvsGScqQ1qm9HmU2mxoOw==
X-CSE-MsgGUID: g3mMcSabT8OvpnEBwN6Uhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82006770"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="82006770"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 07:20:44 -0700
X-CSE-ConnectionGUID: G5PyQTviShGAmYSHDI7T2Q==
X-CSE-MsgGUID: 8AVxhObDR660/OHwpbII6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="242353044"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 07:20:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 07:20:43 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 07:20:43 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 07:20:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDXh/5E6O4MNl/w/d2TCm+QXVsyTGTwQP6Mz8nlmByQUCdgaP2Wvtv3r7EYqtV0htbE0RWKwrwdA8PLCjeTYrpDUSzK2VHkPRKVf07vOt0SyWPOLUgFKwCPoc9YKp+2vymMtaz95xLHXkjGpsZ5w2SuV2lNGdB0JaRQTfltnDCRg+VmldOodJcTOYf+K1U5GxmqzxXE6mWhOizocSwAPgFuJ1YWPKN57fPAnVMSM7IaibZgHm6gogvLzwScPqDuFq/oZP/+2pzdJF6hgA/Q/3n8YxfP7ph6TNvL5TI2xGU960QxYUdpHLxbo1HhHMfXV+L2wEoXO7Nn/R1bjathLbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMq6sFm8/PEHlNaczy06CUplnQHQ/3jSpdl43k6FnSI=;
 b=R/6b3C8yY5pW2QKAC5vwvmAaQRDjqzyxDN8pY5MgmKWTJHu0oUcMpS2ZZyZ6z1J3Vd34/Nx4PlxCD5Ek/iU8lrsYSm8At9uS1FWw/epH9qArbBrXqq9OaNqf57/EFpaEDV9nyfHGS9+Gykazxo3lBvyv65UNhTFnkbdBkY2nTKWc4uVWpYwIgWa4IjipyHPPb8E62SfYuHkasO67jGmmtiIm4lC5zhZm8mJvw5v0Xa438wHKJpQJMgjGfJOFdRNdyrQeCvOXtcmGt4lYqoSdawQrmxSz8fIF2+VDyY7qBnQBjgaAhZDuUpX2XcrUzSaSOk7jB9jLeccS+LHhhbT0yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by PH8PR11MB7966.namprd11.prod.outlook.com (2603:10b6:510:25d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 14:20:38 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%3]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 14:20:38 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "chrubis@suse.cz" <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v16] high_freq_hwp_cap_cppc.c: new test for testing
 acpi_cppc/highest_perf
Thread-Index: AQHc+N18aHLVNKkgQEeRo4sHoExHXrY5aGgAgAAAz4A=
Date: Thu, 11 Jun 2026 14:20:38 +0000
Message-ID: <afc5209a57b7b3db804275d41f2121e6cd6e20dc.camel@intel.com>
References: <20260610133048.115931-2-piotr.kubaj@intel.com>
 <airDiOvy7Ojw9hRF@yuki.lan>
In-Reply-To: <airDiOvy7Ojw9hRF@yuki.lan>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|PH8PR11MB7966:EE_
x-ms-office365-filtering-correlation-id: 17adf8ea-2b61-4f72-fae8-08dec7c49c8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|22082099003|18002099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: q7st/fOi1qFTKnNFsZHE9mguGfJpLdarIunDdw22VIMEmNLGcRRRfVRiHFDwA8jowZPVAXMLKRm3vbn3nhbqlEfQlHfKyy56/m5yDSyumssMX3WHTuySaz+eTbVVfi8g9KNtxNxDgoCOGsCLnk/3KnaTITHeg4sAk9Zz9DDs7Durpn4PKIwkO7+xEZyqyDyHFmH/yVLGwKZsJk1xh3pn2n9iEs6NqLWoY4y6mXef/8nYJRz36kQsSKVzxvbG9YDTTd4YRTQl+EHhpMv4E/dpfLae6g3MVZkio84F6nJc+b9pSEb2o92Ps8a+khbeVOtkqDD7DQDSNdi/HDZPxt6uK8inT2tCp8S1jktuXGt0t7wzchIxikuL4ItpzfWFIgsDWSDYfqJYqx4QwOfqWFrjIo8LTiKvnzQJJc7bgM/RfIWtoe+hDjourHhAxiIaE7nGAIzjGDG+v9o1neIOZOiOdIIFRBLtJtQeK+z3V4o4KUPFouzsQcUB3qGGeO1JNM8lMHfU/WsRsGS5tNThESglIAV/pPE3kJsQzcweHGH/bZbG1ncHZ3MKNTUuoc/CY58SnUQZA9yOZX7kU8lU0rZ4Hq6HiH9PSD0XOT+VmfXBe6r1I5cND6ZO24QohK5QA6IyIgYDtRSfx8r1UnCe+rIuPHahTPxs3hckRHRsaDcnaOpq4GVjytcAbAqC/SCkZsGkYU0QDbZl+C5FR5YyLG3V+fs75jlrJqNO0mFI/thH179l/jz/NY0sD2kYEnD0PUc2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VThUd1BwMFpSQTNhYmdzN1kwNHRGQlNSMno3V2llZHdsS0ZRTDZmYWk0Q2FJ?=
 =?utf-8?B?Umgvbk9wbStJMElhQjhYd0JkazlIL1JJQTdrRWE5Y25HVWhFc3hpcVV6MU0v?=
 =?utf-8?B?N0N1dzd0dDd0Q3V4SHBKdjBQd1VZOG9XbWFLMDlmYmpCMyt2KzZEVmthc3V1?=
 =?utf-8?B?K3JUTFNWbmhOZm9pMlZmY1BkSTNWaTdvcWVKUmI3QTI0b04zVjdGTmJwWGlu?=
 =?utf-8?B?VVlYZ1ZkOFg5N3RYVzA4cHM5SjFRZExkOHVYclhwT2VzTUl5aWhZRldMUFA2?=
 =?utf-8?B?cjJOMjJsS2VMbTNpV25udGhHMTFHaUIxb3pvQUd3NWZkZXB5SXBXMFhtM2pR?=
 =?utf-8?B?TXExdlBZOTBoVU1hbGxGVkplSk9MQWMrSEt3S01RSENhdWo5QUNwbjU2WjJ6?=
 =?utf-8?B?blFHZWlxV2k4SzVkajdpT2tveXM3TjdxTGYxNjZQdXJFckptR0xFZUMrclhr?=
 =?utf-8?B?YldBbEZKWm9mZG40VWhrcFJqdURYRytqU2NWMmx4L25Gd1Y2QjkwZHQ5OEE3?=
 =?utf-8?B?QTZvMnpsR2hKU0ZKMFVoOFpqK2VNV1JlOGpUd010RzJwQmtIdVhlcGlZWFFV?=
 =?utf-8?B?Q0taekN0eHdQQVNMdVU2K1hjVUlyVmNHSWpTNGNRYTZYRXAzUkszNmJ1VUNB?=
 =?utf-8?B?TU1ldi9yV2tHYlVGL2lnYjdLWG5RT01Cb255Z2tOdk43Tm9wZi9WQWFmd1hX?=
 =?utf-8?B?ZFBMaTdkYkJKT3ErVExPMDdVdVdiVWhoWDhjM0pKM2E0Sy85UTlKbXZ6VXJK?=
 =?utf-8?B?aFhuU21JMDBhYkNSUTlhM0NYZXYxME51eGQwQ2sydTZQY1ByRHdrR2pJSlM4?=
 =?utf-8?B?c05ONlZRb1JINHlaekFkYmlvR09mNnlMZTNZV2ZTMEhKbmoyb0dsYXY3Z1hK?=
 =?utf-8?B?ZTlsL3A0VDdRZzlUNU5LUktrOWFGeXc3VWhqM1lqdy8xdVJsM0xJcGVpTFoz?=
 =?utf-8?B?YWdGSXNIQUtYOFpoWnZHZ2p1WEVUVUFYL3lNRHRIWkJpcTBSVzJ0bEEvZVkz?=
 =?utf-8?B?R1MxZmx1OTRqck5oRFVLQWU2VXRxdysyMFdsemZHR2JwNTkzcDBUN0Z4SFdq?=
 =?utf-8?B?dnpmMDlVQnJGcy9OakRYR3NULzBIKzdyT2pyY2JTK3Q4QW9ua3I1WDRRQk54?=
 =?utf-8?B?Y1QvSlgzRnpKdUtDQThvcFUraTFnN2RlMlRIekgvdVI4a20vRHRZOHJXaDJn?=
 =?utf-8?B?VmZIc3VSSXA1TTY0TURsTVpJZzN2L0FZMEVCWmcyZ1BCclo4Q3VNZUlBeUF4?=
 =?utf-8?B?RHI3clNsakVMSDJ6eFJsQ3RMTkUyc1RkSUp6d0JMcmp3V0lId0k4S0t2UXZt?=
 =?utf-8?B?TFhObWwrSFNBRCt3bUJtd3NZb1ZSY29aZWVPVjVGUkhYSDJsRWUyd0xXS0J4?=
 =?utf-8?B?NGhoYjRUUmtRRC9VbHMyK0JZQkt5NnFlUHRYbEIwMGdiOEprVUIwU013MmMw?=
 =?utf-8?B?QjJCS1Y3RWdBZ1hPSWxZOEJUNFBPRU1ReHhJYWxEeFdCVHg2VnIwMlFuWFFB?=
 =?utf-8?B?YjlQSVlrZGpXL1VUSmxlU2h5RVhuaUIxNkdtNHNDUzVlMjdvbVlUUG1vcCts?=
 =?utf-8?B?T3B2ZGdpUWxObTVYcFBPSW05NXBHZmp0bTgvUlM3NjFubDVna3BmT0k4Q2tF?=
 =?utf-8?B?Y1B6WTBQNEZ1TnpwVlFwaGo3MGNDTUR2KzBsZTFqWmFjbyswQ2Z0WU91eFJB?=
 =?utf-8?B?ZkZmYXptM1dCNmgrZ0VBREZHbHJtYU05SjkxdWVNd0hIemhSZUk1bmkyTmQ4?=
 =?utf-8?B?T1VTck4xT0RRZ0NOY21qN0ZVd0dzQzRJQzkzYVkzVTNmVFhva3JieUpFZXV1?=
 =?utf-8?B?OWZGVUI2NzJjeGFYb045V3ZZd3FFZDNEY01RYVJXbGZ0bHdMajJmYktONUla?=
 =?utf-8?B?UC8vYjRSeW1aSVhHSm03K1ZPeUt0alNSRG1VdVhRbncrejVEZzNlUkpkVndj?=
 =?utf-8?B?U2xsTkpScFdjVWppR3UrTVdRYkpzbWcxU3locEJPbE5vdGVPMGZoL3dlc3Yw?=
 =?utf-8?B?RmlKcXBZMXAwNCsxQ0l2SVkvUUphbWcxVUY5NGxHM1ZQNmc5Vkc1Mmh5cEh3?=
 =?utf-8?B?Vk4wY3FnamkwZlExcWlGdGlMK1k1OE1QUjJRY2psODlXaFBFTDdzbHQrcVJB?=
 =?utf-8?B?d0IzSFdIWUtBbWdoOG53Zm1WQ1JUUEdpRDF4cVlKOHl5L2pTbDlMSUI1RXlZ?=
 =?utf-8?B?VUMrWHZIY0pYdm5MTkVRa2t5NEcvVVEzZmQ1dmcrY2w1QU0vY0FkMEZVMXUv?=
 =?utf-8?B?Q0tYQUJiZUxQSzVpdXo3MEVMRFlhZFAxUXgwbE5WME1oMS92Q1hCT01CVkgx?=
 =?utf-8?B?eXd1bnhhNkoza1NWOHgxU2lGMXRyV0l5RStzcG5taWFUYzd1TmJwUStFeWV4?=
 =?utf-8?Q?LXMqtz9muzYlcLXA=3D?=
Content-ID: <D835809076923C498DB93F80DD740C69@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OPqUIn0bWipsReASLC0FHHFw6ZGG9dF5EUUveoWGh5SD/d4XJozM0PE7aDXIOf6wtA4BwLT5XMXuaoTRPC0bB9jDhw43ySPddcYanOxvzF40utyevac6TGRZFjafxXyeVXMJqk3QDw3hhlvkWLtBUyle/nSzR/rP/FQa9QDXDck9pc2MdVsX36qq8sx//NfggifP949bGbedj+EluKtOu8djjyk/OWSymX+6QwJJGo++D7C7lhvXUFpllDW9DRI2QbuTfbyUKHizYNZhIx9o2LUtjsx2rm13/BgbBE/jKISVUJ0RNnXjlLl7XbABQ2V8Vr7kmB+gJXctWOFAx1hw5Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17adf8ea-2b61-4f72-fae8-08dec7c49c8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 14:20:38.6617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BpeumD5AtqUk7eMFr97LZ27nAmVxV4mvFT2IUUngKYPlC/kVtwc2f2lLYQcwsYvpQToWppxqNidSHfMw5m+W8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7966
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v16] high_freq_hwp_cap_cppc.c: new test for
 testing acpi_cppc/highest_perf
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

T2gsIEkgd2FzIHVuZGVyIGltcHJlc3Npb24gdGhhdCB0aGUgd2hvbGUgdGVzdCBzaG91bGQgYmUg
aWZkZWZlZC4gQWZ0ZXINCmFsbCwgdGhlcmUncyBqdXN0IG5vIHBvc3NpYmlsaXR5IGl0IHdpbGwg
ZXZlciBydW4gb24gYW5vdGhlcg0KYXJjaGl0ZWN0dXJlLg0KDQoyMDI2LTA2LTExICjmnKgpIOOB
riAxNjoxNyArMDIwMCDjgasgQ3lyaWwgSHJ1YmlzIOOBleOCk+OBr+abuOOBjeOBvuOBl+OBnzoN
Cj4gSGkhDQo+ID4gKyNpbmNsdWRlICJ0c3RfdGVzdC5oIg0KPiA+ICsjaW5jbHVkZSAidHN0X3Nh
ZmVfcHJ3LmgiDQo+ID4gKw0KPiA+ICsjaWYgZGVmaW5lZChfX2kzODZfXykgfHwgZGVmaW5lZChf
X3g4Nl82NF9fKQ0KPiANCj4gSSd2ZSBhZGp1c3RlZCB0aGUgdGVzdCBzbyB0aGF0IHRoZSBpZmRl
ZnMgYXJlIG9ubHkgYXJvdW5kIHRoZSB4ODYNCj4gc3BlY2lmaWMgYml0cywgd2l0aCB0aGF0IHdl
IGdldCB0aGUgcHJvcGVyIG1lc3NhZ2UgZnJvbSB0aGUgdGVzdA0KPiBsaWJyYXJ5DQo+IGFib3V0
IHN1cHBvcnRlZCBhcmNoaXRlY3R1cmUgYW5kIHB1c2hlZCwgdGhhbmtzLg0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CkludGVsIFRlY2hub2xvZ3kgUG9sYW5kIHNwLiB6IG8uby4KdWwuIFNsb3dhY2tpZWdvIDE3MyB8
IDgwLTI5OCBHZGFuc2sgfCBTYWQgUmVqb25vd3kgR2RhbnNrIFBvbG5vYyB8IFZJSSBXeWR6aWFs
IEdvc3BvZGFyY3p5IEtyYWpvd2VnbyBSZWplc3RydSBTYWRvd2VnbyAtIEtSUyAxMDE4ODIgfCBO
SVAgOTU3LTA3LTUyLTMxNiB8IEthcGl0YWwgemFrbGFkb3d5IDIwMC4wMDAgUExOLgpTcG9sa2Eg
b3N3aWFkY3phLCB6ZSBwb3NpYWRhIHN0YXR1cyBkdXplZ28gcHJ6ZWRzaWViaW9yY3kgdyByb3p1
bWllbml1IHVzdGF3eSB6IGRuaWEgOCBtYXJjYSAyMDEzIHIuIG8gcHJ6ZWNpd2R6aWFsYW5pdSBu
YWRtaWVybnltIG9wb3puaWVuaW9tIHcgdHJhbnNha2NqYWNoIGhhbmRsb3d5Y2guCgpUYSB3aWFk
b21vc2Mgd3JheiB6IHphbGFjem5pa2FtaSBqZXN0IHByemV6bmFjem9uYSBkbGEgb2tyZXNsb25l
Z28gYWRyZXNhdGEgaSBtb3plIHphd2llcmFjIGluZm9ybWFjamUgcG91Zm5lLiBXIHJhemllIHBy
enlwYWRrb3dlZ28gb3RyenltYW5pYSB0ZWogd2lhZG9tb3NjaSwgcHJvc2lteSBvIHBvd2lhZG9t
aWVuaWUgbmFkYXdjeSBvcmF6IHRyd2FsZSBqZWogdXN1bmllY2llOyBqYWtpZWtvbHdpZWsgcHJ6
ZWdsYWRhbmllIGx1YiByb3pwb3dzemVjaG5pYW5pZSBqZXN0IHphYnJvbmlvbmUuClRoaXMgZS1t
YWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG1hdGVyaWFs
IGZvciB0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gSWYgeW91IGFy
ZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRlciBh
bmQgZGVsZXRlIGFsbCBjb3BpZXM7IGFueSByZXZpZXcgb3IgZGlzdHJpYnV0aW9uIGJ5IG90aGVy
cyBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
