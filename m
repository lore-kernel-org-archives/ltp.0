Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3107FCD0C4
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 13:08:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E6DB3E58F0
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 14:08:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 046823CD52A
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 14:08:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C9ADE1A002D8
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 14:08:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773839304; x=1805375304;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=w+f1+7HHBoB2j4eZ/AgPeL3NycTQPU032F4QfjYiOGM=;
 b=lAvy16unIha+ZNX17kOI8KTLWLAgMkto6OXiquk6TPK4wTRWeEH2TgdY
 Etj5U6P0uhHwpnHNDIb/OiwdEenAKQ43sTUD0WsAOcSObAlCT37xmSY2t
 vQMi3Tk/55CpP+s8BKF1DT2nA7tk8Nuu89VqLzhWMGHVW1gsAojyMYt8A
 YRO/+NXBOGDpDLmYzT/lTJx4GfnRXyVAj+WOSfL4+yTvzFaV9xT3dp+cV
 B7KPBxtST3PTV+52jH8WBuMAkVASkM/YjI/wcb8O5tmoNMNPepWO1B8eR
 NEtUfYO+MitZbPDjWJQ7QUigp6VgDWFs1nP47AfILkEGFd10+yPXQVk7G g==;
X-CSE-ConnectionGUID: Zse9AQNxQ4CuLH1Iw5H/Cg==
X-CSE-MsgGUID: AotLOK+JTdihxpnwe1Vy0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="62454948"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="62454948"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 06:08:19 -0700
X-CSE-ConnectionGUID: u63oISJcQMevIQ1EO0FHdA==
X-CSE-MsgGUID: tbZLjUi3TKeu3Sw534mitg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="218197407"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 06:08:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 06:08:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 06:08:18 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 06:08:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJE8XXTLxWIIQ3bGWDslHiARfPntzOFHlMC6xDx+wHxGRQlgvUGsWplJpKVFxhYOgymXhfIMA3IrI01TbGbs4geYAM2k1B07xqH433DQX7cyA+zjllFBX7WVpHrUAKPZQxSphoE8StbYrvH3YHkbgPggp7O8hue5KFJjNtqkepsPsaGmfEyb/8l6jXZTkjpwLybcxxjP8ofoEi6e8G7CC5mal5Qt9Y83j/3LQ5B+ezWPm/x6OL0gPXNFjJJ4aMhHF0u9KzI+yItBv27cBA81aTZlpTafQKaTV53SzxWqy3qTvXtB+hUxFELKVJKzJHHDB+/fmNMjcxsLjEx/SUMLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2J3PhrTkQv2W5kYudl+hWgfVXfd78FObqK8cfHqvwA=;
 b=MhWVdp6IZl9TG5HHm1bbLR//G+iflU4A7iJRDUu7+RkJsos5/b+98iHc2AgHtNg6W8NefNzKH7wroGGS8yNHRpqyJvI3yD3lAQHT1RQsrjC+icfhClQJAk35lE0XV5Zraosh8QROv6CUAEf6qsUBf0+35JlYGSAHbANwHiTETBn1NcI/LCbKlDH6MAAiMM3eOUTHep5Zjf6oIlaIhtwMX3AzKLU3bDbL5tXm+AS4wIyRyJVp3F06gFipxyhrLW9tvrEz7v3FhqEuSyy5Vv4iyy3EZxyIDodxg8lPEAu1zVXtflSgfnDArgMkgSigMW34pgC8pxZIAVHN3iLGdUs7LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by DM6PR11MB4514.namprd11.prod.outlook.com (2603:10b6:5:2a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 13:08:15 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%3]) with mapi id 15.20.9723.013; Wed, 18 Mar 2026
 13:08:15 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "andrea.cervesato@suse.com" <andrea.cervesato@suse.com>
Thread-Topic: [LTP] [PATCH] high_freq_hwp_cap_cppc.c: new test
Thread-Index: AQHcsuiMzlPosDhqZUqrcO24JRcEsLWxIm8AgAMoTgA=
Date: Wed, 18 Mar 2026 13:08:15 +0000
Message-ID: <ff8ac2098ba0945cbb2edbfa618812609309a922.camel@intel.com>
References: <69b7fdb1.050a0220.48979.cc0e@mx.google.com>
In-Reply-To: <69b7fdb1.050a0220.48979.cc0e@mx.google.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|DM6PR11MB4514:EE_
x-ms-office365-filtering-correlation-id: 9a2d7c2b-c9a6-4707-42ec-08de84ef6ab0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: bnI6D3sE/CL4BFaujuahGkm6n0teVxeCPdO0rSyWIl8c8CaQoW8LBSWoDBA3KQc+McdifmyI95Nz96S1lAUgpxJRZ1C7qiyeo075gXWU8MvWtJEVw8Yl5IQV3FbFkvgirIHthXM2VsWiiJfw9kHBMJXXsKFmnt9vYh8i9+6l5lGLsbbhemR3oPTX7ocrQkv2kZ1K9PggUeIkQSIVzBPTWwLkW7fjlNtPxAFa2qKjLDGC1jaUAgHYTXMVF+3/Q17nY827tN907UgsgcIXRhlhB5Q4Ek2CgWf9ZfyRcF84kRFAiQjSzt71d0dFYqhX9ic6se75pZ5uYcSo96F3a8SOh7FkPgjS+boAh9U6JDiSYQNiV6EQ9K2NS0eg6+lB/FStIS8o1ZZlePdAuKAbclTrRNpQ3IPj1Io9Kr0q90r7BuhM0eS80apJIZW94DUtTQbaClw0o+6RoNQKzWb+ufdmfoNDjX5GxKu9A7x8lu8deAbGOd7+u+qurpniBOR8zTCLPR8Ax4ysxLe1NfhpKT+smksdAPg1owSBONEW9IjlD3tfZnmSSwx3cnf+d12gmOkc95UH5SVVhLssdihMnVr3LenPRbZcyC59LlQ/ZbjcCs/75csX+eQ8n+lxoXbC598bz+8zodv4HTxeZicfGCkyE4TSTSMirtOCaKLkHqqJqSpNeCrTcTvrvVCzRXoDzpjca/UNlBIgSflISvJy3CUf6jawPL8NC/+ytBHMq+C84238+/fJnLFaJoNCF4iyQFN3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2J0cFZmV1BlYmhnNGhLd2NtL3l3dUhGaVd4L2NvWlcrV0xXRzJDa2t4Snkz?=
 =?utf-8?B?SWRhUDFkZUNlYlJRbnNVVDkzcmlNZ2trd0VJdUppNUZnQkVvU3dQMTFQQUJ0?=
 =?utf-8?B?REw1Z0RMQ09SQVA1TURTT3Z3K1B5SDBDUHVLMUlZbWJQS1Q3bGMrSUpJeVZD?=
 =?utf-8?B?TFM2TXhBOXRUY1ZQMUROMHJwV2RFbWlPM0d2R3BFRFRkb2JXNVBvd3owZFdY?=
 =?utf-8?B?YjdHL0Q4U3dMUGlIZ2lJM2tyS1YxeEx5dzQyUDludE8ycTAydFBndXd4RFJz?=
 =?utf-8?B?NXI5ck9vd0s0WGJnYnQ5bDFPdHlxYS8xQW9VNUNpMzFFT1c1akovS1BQMUdE?=
 =?utf-8?B?dEt0aW1ORm16NVladWN0d1o2SjNtM1JDNTkyZmZkUlhVY2RQMTFLRU1BMG9E?=
 =?utf-8?B?M3diQkJFMmh6ekl6cWJxMStrSkJOV0FSVXRDYXQ3NEUzQytOeko5aFJvZnkr?=
 =?utf-8?B?Y2ovdm1PKzMxZXVxTVV6Lys2NE0xa3NzZ21Cd242VUpKemZpQUtLWnNFTUtU?=
 =?utf-8?B?VFRSMC9GUkJSUGxMd1lVT1hVL0s5VDA0THZWU2IrcjJDd003YjN3ZVI3Uktr?=
 =?utf-8?B?YUFNTnlGRjdqb3dPaXpjbGRXTmNMWTRSNnI2WmtJYUpEeTArNGtySGlWeGJD?=
 =?utf-8?B?SGdwU3RMVUNtR0VKUjVYU2NxTTdrR0hWRGdpdG5UbjVuZWNjUWtqY1ZrMndB?=
 =?utf-8?B?R213K2VPbk10c1hwOVROS2h1NkZQeEIyK3hxbCthQ3pwWUhoWTAxSTFQZFFn?=
 =?utf-8?B?R2J4QkhvVmZWTjJzK1RuMU1Yc0lLQlNhZ01Cd0tRM1p2WWJja0tyTE55UXAy?=
 =?utf-8?B?OWF6SXpLUXZuaDZGaS9kUEFOTE4xMnBudTRPTFlGUml3K3FaTGJMbW1lUVFY?=
 =?utf-8?B?RU9yTUMvZjIzSzRJa1l3YUp4WXJlV0VGWjhXMGZta2RLL3hCN3pwUXgxWTdv?=
 =?utf-8?B?SmQ1cmdDR09US1ZOQ1BOUmxpM3ZrUE1pRW8wamVuN05jZkpDVWJuRmVLT3NC?=
 =?utf-8?B?b3VIWk9OTUh4NWNISGhuYmNUVVRlc21XYzhlWURTTDh4Y3BCRGpyWnUrU0Ix?=
 =?utf-8?B?R0k4Z1pxM1VWamFvemhVVXNETjFSUTkvWWdUbVpITURqQVdOeUpPbFk2WWhw?=
 =?utf-8?B?WHduMUhiWXhkNFpiOWx4WU1kSXJTWFJ2L2pQUXN2VVNibTNnNkR2MG5zTWFZ?=
 =?utf-8?B?blVmS1hoVnh0UGVsS0tRcnlYekt3cWN5bGphWVJrKzVTS2FhVUFrZWpFcmhx?=
 =?utf-8?B?OVg4VkRNUjkyNnFtVnA0WDUwTXcrRmlUNWFUSjBsUkVCRkg2TjBWTjA1V0hi?=
 =?utf-8?B?ZU40SWN3VisrREVkSzRSRmZPMzlVbjVweFVGRlZhSXcxTGF1bEUyRERlWkVk?=
 =?utf-8?B?OUNJQmw4UEZJc1JlL3lHbjloMVk4N1JpRW96NDdIZE1mM3NQVDdNT1dkOTZk?=
 =?utf-8?B?Szhxd1drQkRBUzNqK3JqZnp0Tkhya0FUT3pyUzlPVkVHZTczUlAwZElscDNG?=
 =?utf-8?B?T29adGUyQnhieXVSMHUwSmNyeHZ0Tzk3SHJqWnp1RUF2ak9YZ2JjUTYybGdI?=
 =?utf-8?B?NmY3TUhXNmhoVE9reHBYZUd4QXBRTDZuNDM2eUVXdGVpczB2bXBRdkd1Qllz?=
 =?utf-8?B?YTVaTUxSQlQyTm1QTnNyUVBKblFNRXR2VS81KzdueExTcmJMTW5qalVRcEM4?=
 =?utf-8?B?MllMNVpGcDdjVWMzcDJpQ2dNbkdINXZleG00SXQvZXR5SDI2c2o2YjQxUzVn?=
 =?utf-8?B?WC9MK3BnWDF0TzJmUzI0ZXFDSUJhZU5Nd2dXSnYzRThITXZqY2ZIY1ZyT3Nn?=
 =?utf-8?B?YlBsUTVvWW16UE5IRTNIRThWK0Jka3BHMmRjNXNKMEZlK09va2VJa1VOaW9C?=
 =?utf-8?B?UklvVDhOVGpsM2c5d3AzQ21ZWUUyQkpncE5HMnBjRy82RTNwYjhjNklLWm05?=
 =?utf-8?B?SER1Ky9kSkNUOEhCUlhLd3EyemhtUHdpY0hLdGxxVW90Lzl2U3lER1dqVkxY?=
 =?utf-8?B?a1M5aktib1RTRUQ2T2FGWWFvaDZwQ09BYmdVMDNVYTNNdEdKZW51ZEpoMkx1?=
 =?utf-8?B?RURQL0FvVXpnTnAzNVRyajF0MVhZaU16TitwZ2dRSUhmczdiTXd6MGVJb1ZU?=
 =?utf-8?B?clBuaElPSGZGRjhkZ1F5ay9yaStKdk9LWDN2cWhSV1FkNnRBMW43aFdyQmk5?=
 =?utf-8?B?WVExWG5wdXR6NWdSNnVxUzY4dzBPM0NJZGc5YW90T2hndlFNaVVNdWM5ZTAx?=
 =?utf-8?B?OU1hYmg3YVBJdm5TUzFBcHM5b3Nua0Z4dFNqcEFjU0RFSnVLbUZRT29JbzI1?=
 =?utf-8?B?bzV0TGozOEdVSkcvMGNiYnQxVzhMeWJ6eWtHaXc0QmFZT0Nxak8wYml4Um1q?=
 =?utf-8?Q?ilT8iTn3YkXoTP24=3D?=
Content-ID: <A51B54CC81451847ADF68A1B7BD99B81@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XpkmuPprg+JuP2uZZm4KBPRM1gTO9IflYxIrchbxnFY7CFXRu9Tril1V+ylMMNB87KTxW8i/2bspgEXxU1CclBPdruKBhehx95fNztni+Jp+a9NV5bL6U8mETyKrFrnwqZ5B1Z7a8S9sqc+SJJpDXdRgS7/TOGOuT3AZ4PJBx0Y43QDNdBj5ImEo7oTVUrFrmV9mox77Y+EvDZ3KOdXohsKE8ZdemAToxoTM8RNT0+VtjMpDiOF0oeaYW0buQF9349uytOKVWdUNxJUykbKKAVgiHm5/ULUXLa/K3wtxldouARD1ER2wHw9IAsVKns9/IGd34BrIj1vOAN94Vmo1vQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2d7c2b-c9a6-4707-42ec-08de84ef6ab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 13:08:15.4656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrAq5wjEuXAD4m1PjkiSW0u3YKfS1OarZDQm6f308RhjvWDfceoqqPJRexFjhCB2X/AwIutML0PaR8K8uKzQVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4514
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] high_freq_hwp_cap_cppc.c: new test
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

MjAyNi0wMy0xNiAo5pyIKSDjga4gMTI6NTUgKzAwMDAg44GrIEFuZHJlYSBDZXJ2ZXNhdG8g44GV
44KT44Gv5pu444GN44G+44GX44GfOg0KPiBIaSENCj4gDQo+ID4gVmVyaWZ5IGZvciBhbGwgb25s
aW5lIGxvZ2ljYWwgQ1BVcyB0aGF0IHRoZWlyIGhpZ2hlc3QgcGVyZm9ybWFuY2UNCj4gPiB2YWx1
ZSBhcmUNCj4gPiB0aGUgc2FtZSBmb3IgSFdQIENhcGFiaWxpdHkgTVNSIDB4NzcxIGFuZCBDUFBD
IHN5c2ZzIGZpbGUuDQo+ID4gLS0tDQo+ID4gwqB0ZXN0Y2FzZXMva2VybmVsL3Bvd2VyX21hbmFn
ZW1lbnQvLmdpdGlnbm9yZcKgIHzCoCAxICsNCj4gPiDCoC4uLi9wb3dlcl9tYW5hZ2VtZW50L2hp
Z2hfZnJlcV9od3BfY2FwX2NwcGMuYyB8IDU3DQo+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+
IMKgMiBmaWxlcyBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspDQo+ID4gwqBjcmVhdGUgbW9kZSAx
MDA2NDQNCj4gPiB0ZXN0Y2FzZXMva2VybmVsL3Bvd2VyX21hbmFnZW1lbnQvaGlnaF9mcmVxX2h3
cF9jYXBfY3BwYy5jDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvcG93
ZXJfbWFuYWdlbWVudC8uZ2l0aWdub3JlDQo+ID4gYi90ZXN0Y2FzZXMva2VybmVsL3Bvd2VyX21h
bmFnZW1lbnQvLmdpdGlnbm9yZQ0KPiA+IGluZGV4IDBjMmEzZWQ0Yi4uYzEzYmNhMWM0IDEwMDY0
NA0KPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvcG93ZXJfbWFuYWdlbWVudC8uZ2l0aWdub3Jl
DQo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9wb3dlcl9tYW5hZ2VtZW50Ly5naXRpZ25vcmUN
Cj4gPiBAQCAtMSArMSwyIEBADQo+ID4gK2hpZ2hfZnJlcV9od3BfY2FwX2NwcGMNCj4gPiDCoHBt
X2dldF9zY2hlZF92YWx1ZXMNCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS90ZXN0Y2FzZXMva2VybmVs
L3Bvd2VyX21hbmFnZW1lbnQvaGlnaF9mcmVxX2h3cF9jYXBfY3BwYy5jDQo+ID4gYi90ZXN0Y2Fz
ZXMva2VybmVsL3Bvd2VyX21hbmFnZW1lbnQvaGlnaF9mcmVxX2h3cF9jYXBfY3BwYy5jDQo+ID4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAuLjRjYmI4MWYwYg0KPiA+
IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3Bvd2VyX21hbmFnZW1l
bnQvaGlnaF9mcmVxX2h3cF9jYXBfY3BwYy5jDQo+ID4gQEAgLTAsMCArMSw1NyBAQA0KPiA+ICsv
LyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KPiA+ICsNCj4gPiAr
LyoNCj4gPiArICogQ29weXJpZ2h0IChDKSAyMDI1LTIwMjYgSW50ZWwgLSBodHRwOi8vd3d3Lmlu
dGVsLmNvbS8NCj4gPiArICovDQo+IA0KPiBSZW1vdmUgc3BhY2UNCkRvIHlvdSBtZWFuIHRoYXQg
ZG91YmxlIHNwYWNlPyBSZW1vdmVkLiBPdGhlciB0aGFuIHRoYXQsIEkgY291bGRuJ3QNCmZpbmQg
YW55IHJlZHVuZGFudCBzcGFjZS4NCg0KPiA+ICsNCj4gPiArLypcDQo+ID4gKyAqIFZlcmlmeSBm
b3IgYWxsIG9ubGluZSBsb2dpY2FsIENQVXPCoCB0aGF0IHRoZWlyIGhpZ2hlc3QNCj4gPiBwZXJm
b3JtYW5jZSB2YWx1ZSBhcmUNCj4gDQo+IERvdWJsZSBzcGFjZSBiZWZvcmUgInRoYXQiDQo+IA0K
PiA+ICsgKiB0aGUgc2FtZSBmb3IgSFdQIENhcGFiaWxpdHkgTVNSIDB4NzcxIGFuZCBDUFBDIHN5
c2ZzIGZpbGUuDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArI2luY2x1ZGUgInRzdF90ZXN0LmgiDQo+
ID4gKw0KPiA+ICtzdGF0aWMgaW50IG5wcm9jOw0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgc2V0
dXAodm9pZCkNCj4gPiArew0KPiA+ICsJbnByb2MgPSB0c3RfbmNwdXMoKTsNCj4gPiArfQ0KPiA+
ICsNCj4gPiArc3RhdGljIHZvaWQgcnVuKHZvaWQpDQo+ID4gK3sNCj4gPiArCWZvciAoaW50IGkg
PSAwOyBpIDwgbnByb2M7IGkrKykgew0KPiA+ICsJCWNoYXIgcGF0aFtQQVRIX01BWF07DQo+ID4g
KwkJdW5zaWduZWQgbG9uZyBsb25nIG1zcl9oaWdoZXN0X3BlcmYgPSAwLA0KPiA+IHN5c2ZzX2hp
Z2hlc3RfcGVyZiA9IDA7DQo+ID4gKw0KPiA+ICsJCXNucHJpbnRmKHBhdGgsIFBBVEhfTUFYLA0K
PiA+ICIvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUlZC9hY3BpX2NwcGMvaGlnaGVzdF9wZXJm
IiwgaSk7DQo+IA0KPiBzbnByaW50ZihwYXRoLCBzaXplb2YocGF0aCksIC4uKSBpcyBiZXR0ZXIu
DQpEb25lLg0KDQo+IA0KPiA+ICsJCVNBRkVfRklMRV9TQ0FORihwYXRoLCAiJWxsdSIsDQo+ID4g
JnN5c2ZzX2hpZ2hlc3RfcGVyZik7DQo+ID4gKwkJdHN0X3JlcyhUREVCVUcsICIlczogJWxsdSIs
IHBhdGgsDQo+ID4gc3lzZnNfaGlnaGVzdF9wZXJmKTsNCj4gPiArDQo+ID4gKwkJc25wcmludGYo
cGF0aCwgUEFUSF9NQVgsICIvZGV2L2NwdS8lZC9tc3IiLCBpKTsNCj4gPiArCQlpbnQgZmQgPSBT
QUZFX09QRU4ocGF0aCwgT19SRE9OTFkpOw0KPiA+ICsNCj4gPiArCQlpZiAocHJlYWQoZmQsICZt
c3JfaGlnaGVzdF9wZXJmLA0KPiA+IHNpemVvZihtc3JfaGlnaGVzdF9wZXJmKSwgMHg3NzEpIDwg
MCkgew0KPiA+ICsJCQlTQUZFX0NMT1NFKGZkKTsNCj4gPiArCQkJdHN0X2JyayhUQlJPSyB8IFRF
UlJOTywgIk1TUiByZWFkIGVycm9yIik7DQo+ID4gKwkJfQ0KPiANCj4gU2ltcGx5IHVzZSBTQUZF
X1BSRUFEKCkuIGZkIHdpbGwgYmUgY2xvc2VkIHdoZW4gdGVzdCBlbmRzLg0KRG9uZS4NCg0KPiAN
Cj4gPiArCQlTQUZFX0NMT1NFKGZkKTsNCj4gPiArCQltc3JfaGlnaGVzdF9wZXJmICY9ICgxVUxM
IDw8IDgpIC0gMTsNCj4gPiArCQl0c3RfcmVzKFRERUJVRywgIiVzOiAlbGx1IiwgcGF0aCwNCj4g
PiBtc3JfaGlnaGVzdF9wZXJmKTsNCj4gPiArDQo+ID4gKwkJaWYgKG1zcl9oaWdoZXN0X3BlcmYg
IT0gc3lzZnNfaGlnaGVzdF9wZXJmKQ0KPiA+ICsJCQl0c3RfYnJrKFRGQUlMLCAiQ1BVICVkOiBo
aWdoZXN0DQo+ID4gcGVyZm9ybWFuY2UgdmFsdWVzIGRpZmZlciBiZXR3ZWVuIHN5c2ZzIGFuZCBN
U1IiLCBpKTsNCj4gDQo+IFdoeSB0c3RfYnJrKCkgPyBJdCdzIHN1cHBvc2VkIHRvIGJlIHRzdF9y
ZXMoVEZBSUwsIC4uKS4NCkkgYWN0dWFsbHkgZmluZCB0c3RfYnJrKCkgY2xlYW5lciwgYmVjYXVz
ZSBpdCBlbmRzIHRoZSB0ZXN0IHdoZW4NCnRoZXJlJ3MgYSBmYWlsdXJlIHdoaWNoIHJlbW92ZXMg
dGhlIG5lZWQgZm9yIGEgY2hlY2sgbGF0ZXIsIGJ1dCBJDQpjaGFuZ2VkIGl0IGFjY29yZGluZyB0
byB5b3VyIHN1Z2dlc3Rpb24uDQoNCj4gDQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJdHN0X3JlcyhU
UEFTUywgIlRlc3QgcGFzcyIpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0IHRz
dF90ZXN0IHRlc3QgPSB7DQo+ID4gKwkubmVlZHNfa2NvbmZpZ3MgPSAoY29uc3QgY2hhciAqY29u
c3QgW10pIHsNCj4gPiArCQkiQ09ORklHX1g4Nl9NU1IiLA0KPiANCj4gVGhlIENQUEMgc3lzZnMg
aW50ZXJmYWNlIGFsc28gcmVxdWlyZXMgQ09ORklHX0FDUElfQ1BQQ19MSUIgdG8gYmUNCj4gYnVp
bHQuDQpSaWdodCwgYWRkZWQuDQoNCj4gDQo+ID4gKwkJTlVMTA0KPiA+ICsJfSwNCj4gPiArCS5u
ZWVkc19yb290ID0gMSwNCj4gPiArCS5zZXR1cCA9IHNldHVwLA0KPiA+ICsJLnRlc3RfYWxsID0g
cnVuDQo+ID4gK307DQo+ID4gLS0gDQo+ID4gMi40Ny4zDQo+ID4gDQo+ID4gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiA+IC0tDQo+ID4gSW50ZWwgVGVjaG5vbG9neSBQb2xhbmQgc3AuIHogby5vLg0KPiA+IHVsLiBT
bG93YWNraWVnbyAxNzMgfCA4MC0yOTggR2RhbnNrIHwgU2FkIFJlam9ub3d5IEdkYW5zayBQb2xu
b2MgfA0KPiA+IFZJSSBXeWR6aWFsIEdvc3BvZGFyY3p5IEtyYWpvd2VnbyBSZWplc3RydSBTYWRv
d2VnbyAtIEtSUyAxMDE4ODIgfA0KPiA+IE5JUCA5NTctMDctNTItMzE2IHwgS2FwaXRhbCB6YWts
YWRvd3kgMjAwLjAwMCBQTE4uDQo+ID4gU3BvbGthIG9zd2lhZGN6YSwgemUgcG9zaWFkYSBzdGF0
dXMgZHV6ZWdvIHByemVkc2llYmlvcmN5IHcNCj4gPiByb3p1bWllbml1IHVzdGF3eSB6IGRuaWEg
OCBtYXJjYSAyMDEzIHIuIG8gcHJ6ZWNpd2R6aWFsYW5pdQ0KPiA+IG5hZG1pZXJueW0gb3Bvem5p
ZW5pb20gdyB0cmFuc2FrY2phY2ggaGFuZGxvd3ljaC4NCj4gPiANCj4gPiBUYSB3aWFkb21vc2Mg
d3JheiB6IHphbGFjem5pa2FtaSBqZXN0IHByemV6bmFjem9uYSBkbGEgb2tyZXNsb25lZ28NCj4g
PiBhZHJlc2F0YSBpIG1vemUgemF3aWVyYWMgaW5mb3JtYWNqZSBwb3VmbmUuIFcgcmF6aWUgcHJ6
eXBhZGtvd2Vnbw0KPiA+IG90cnp5bWFuaWEgdGVqIHdpYWRvbW9zY2ksIHByb3NpbXkgbyBwb3dp
YWRvbWllbmllIG5hZGF3Y3kgb3Jheg0KPiA+IHRyd2FsZSBqZWogdXN1bmllY2llOyBqYWtpZWtv
bHdpZWsgcHJ6ZWdsYWRhbmllIGx1Yg0KPiA+IHJvenBvd3N6ZWNobmlhbmllIGplc3QgemFicm9u
aW9uZS4NCj4gPiBUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIG1heSBjb250YWluIGNv
bmZpZGVudGlhbCBtYXRlcmlhbA0KPiA+IGZvciB0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVk
IHJlY2lwaWVudChzKS4gSWYgeW91IGFyZSBub3QgdGhlDQo+ID4gaW50ZW5kZWQgcmVjaXBpZW50
LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIGFuZCBkZWxldGUgYWxsDQo+ID4gY29waWVzOyBh
bnkgcmV2aWV3IG9yIGRpc3RyaWJ1dGlvbiBieSBvdGhlcnMgaXMgc3RyaWN0bHkNCj4gPiBwcm9o
aWJpdGVkLg0KPiA+IA0KPiA+IA0KPiA+IC0tIA0KPiA+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cA0KPiANCj4gVGhlcmUncyBhbHNvIG5vIHJ1
bnRlc3QgZW50cnkgZm9yIHRoaXMgdGVzdCwgc28gaXQgY2FuJ3QgYmUgcnVuIGluDQo+IHRoZSB0
ZXN0aW5nDQo+IHN1aXRlcyBieSBraXJrLg0KPiANCj4gS2luZCByZWdhcmRzLA0KPiAtLQ0KPiBB
bmRyZWEgQ2VydmVzYXRvDQo+IFNVU0UgUUUgQXV0b21hdGlvbiBFbmdpbmVlciBMaW51eA0KPiBh
bmRyZWEuY2VydmVzYXRvQHN1c2UuY29tDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KSW50ZWwgVGVjaG5vbG9neSBQ
b2xhbmQgc3AuIHogby5vLgp1bC4gU2xvd2Fja2llZ28gMTczIHwgODAtMjk4IEdkYW5zayB8IFNh
ZCBSZWpvbm93eSBHZGFuc2sgUG9sbm9jIHwgVklJIFd5ZHppYWwgR29zcG9kYXJjenkgS3Jham93
ZWdvIFJlamVzdHJ1IFNhZG93ZWdvIC0gS1JTIDEwMTg4MiB8IE5JUCA5NTctMDctNTItMzE2IHwg
S2FwaXRhbCB6YWtsYWRvd3kgMjAwLjAwMCBQTE4uClNwb2xrYSBvc3dpYWRjemEsIHplIHBvc2lh
ZGEgc3RhdHVzIGR1emVnbyBwcnplZHNpZWJpb3JjeSB3IHJvenVtaWVuaXUgdXN0YXd5IHogZG5p
YSA4IG1hcmNhIDIwMTMgci4gbyBwcnplY2l3ZHppYWxhbml1IG5hZG1pZXJueW0gb3Bvem5pZW5p
b20gdyB0cmFuc2FrY2phY2ggaGFuZGxvd3ljaC4KClRhIHdpYWRvbW9zYyB3cmF6IHogemFsYWN6
bmlrYW1pIGplc3QgcHJ6ZXpuYWN6b25hIGRsYSBva3Jlc2xvbmVnbyBhZHJlc2F0YSBpIG1vemUg
emF3aWVyYWMgaW5mb3JtYWNqZSBwb3VmbmUuIFcgcmF6aWUgcHJ6eXBhZGtvd2VnbyBvdHJ6eW1h
bmlhIHRlaiB3aWFkb21vc2NpLCBwcm9zaW15IG8gcG93aWFkb21pZW5pZSBuYWRhd2N5IG9yYXog
dHJ3YWxlIGplaiB1c3VuaWVjaWU7IGpha2lla29sd2llayBwcnplZ2xhZGFuaWUgbHViIHJvenBv
d3N6ZWNobmlhbmllIGplc3QgemFicm9uaW9uZS4KVGhpcyBlLW1haWwgYW5kIGFueSBhdHRhY2ht
ZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgbWF0ZXJpYWwgZm9yIHRoZSBzb2xlIHVzZSBv
ZiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQg
cmVjaXBpZW50LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIGFuZCBkZWxldGUgYWxsIGNvcGll
czsgYW55IHJldmlldyBvciBkaXN0cmlidXRpb24gYnkgb3RoZXJzIGlzIHN0cmljdGx5IHByb2hp
Yml0ZWQuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
