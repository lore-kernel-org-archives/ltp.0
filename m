Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E44C5DF71
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 09:07:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46A463E4B61
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 11:07:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F80D3E30AB
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 11:07:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 64200208D41
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 11:06:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780391220; x=1811927220;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=VhZJmF9I37uvZ62/Fe6WmbEf9NhrSPtqdBDZ5VFs6CE=;
 b=J9f2dMvuwbt/k07v5XRSn6kU6eF5kdr+A9lc6+KXkC2GfkwkJs4C7GAf
 MZDV8BJze7CoTlHr+w5I21MHNPlY4d/1hJQ7J7Fs50V7b9kot6iJxQ5yF
 SIvDeHUB9+Ho7KBeIygKFeF6KdCd7nNLFb6MujEnsyEyb7CeipwkRI44X
 EnAr6TikPwfms+TPCFik4/ViHaC37ydTknbKisJnZqAp5IQTlwOiBLLEk
 qEpWDbvP71a6z+jv7H54V51EdIiT7fjaRk8MYNNxo3hS9Qe5gaQIVhuFS
 FiQFZvgz2yOUFie8tL+8+A9fnVIlNVhoAcmkNhYgA+2iIGEddMsrhKitk g==;
X-CSE-ConnectionGUID: j+rNNvUwQSWsZQL1or9ftA==
X-CSE-MsgGUID: dXTIleIMS0alCGj4UxBVkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="83754104"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="83754104"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 02:06:58 -0700
X-CSE-ConnectionGUID: 1INwTiw2T2eiWkj+cp6CWA==
X-CSE-MsgGUID: z9z8TfhpTEunHRFcI9WeOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="242826037"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 02:06:57 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 02:06:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 02:06:57 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 02:06:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gk96h3m0fza2BAoV1dIG+L9QPvqADCSL8uPOyRLipNne2qmi0v5IzYVR+CQihG5ec00D/sMuReSg+B3BWkmgMyJb5WrDQruM6RcApIlM1053rROp+bBm44uV40ORhrqiraEZjyH/ILzVgencwViS+DTfgzGQq03SY5uMlncIGkMU9A6FvCjpBzTezmFULXMl3FeTRgZfvvZXn71LNggAHILcFPmXtRd+LNTI2ZIuQ1dBFLGlktDziQKDnFA5iB1+pHzV+1+J2ZBUftju7y56dnUu76ehnl/o4WLc5HNiRAtCqkIQYhOuEvyh9rHktpGK7V8beZgbttTrui7uNUtd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGwhmYk26xO2Kau5PeDawhzCjq8kk2/Xl8EVGmjQn1E=;
 b=hX3Tr8hvA+qjX5XtqFeIgo01jfVuj5IhsQpnnyRtXcIEEGe178+onMNCNRvgiFTPNHMogI7pbiOkGF7V/mW/vcstf5LH+rMEmGLAavMZ/hBcbKcrvo7b279K1A58dK0ez3lCCoK2Q4LWB1v78Zi0RMd55WLRh6nrzhNkfQhlHFMQX/qMScFEBUf4M313rpTgtB4xxbkab7KEOe73x8I/4FX8vLMEkeLGAMJ0/HHoOiKgl8SR7XfLpUBUDQI4kIuUfE5hsGDHiTlSCoBB7JC8qGiEIb7xdQAj8137vd8wlkWwsBgayk2gkiSnXNkCUXl/cxNwXWq2qzFkZRmH1cIUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by PH7PR11MB6860.namprd11.prod.outlook.com (2603:10b6:510:200::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 09:06:53 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%3]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 09:06:52 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v13] high_freq_hwp_cap_cppc.c: new test
Thread-Index: AQHc44UqUs6ikVYClEuQwXsj9W6RF7YrF0KA
Date: Tue, 2 Jun 2026 09:06:52 +0000
Message-ID: <2ccd884ba7aa272345e6682ccafec43b94453d2b.camel@intel.com>
References: <20260514093559.125070-2-piotr.kubaj@intel.com>
In-Reply-To: <20260514093559.125070-2-piotr.kubaj@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|PH7PR11MB6860:EE_
x-ms-office365-filtering-correlation-id: bd64bd6b-17c1-4de6-9736-08dec08649c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|6133799003|22082099003|18002099003|56012099006|11063799006|5023799004;
x-microsoft-antispam-message-info: +2aOOzd1xCV1hsnAomOnUO84BkS5ZTz/MNRAgDjjoXavw2F3tnUA+u76q4ByJySQaZJXMscLBYK0WDhL5qlH/Liv36ubU35KmHFieKSN7uoOU3SYoLYhabl1g1hP7biENtwhB2NJvbMYfSCBc/aUCAJtH/3CFdq9/2JHOiHEq0uvSbLkh73HA5RuO5YngDoGSO3wcIPaYuV9Ipz8DHwPSwo/SjD651ttWIY/Ae7rVz3pwi4zBXQdbA/ZoZASCoah4Yk+ZMx3g/mIcz1cYABUWM8MWpWynMT9hI8Rj7Vkl9asHV0H0Qip4u8N9fDq54N/V4uhcjV9kgXgyIsKSsSwoptwlIfGjjxf/TiEcsGpw7ilqhaPM5qDT0qTZ7vnAJ6nX8j5qvCtdTG+n2qqhNK8W2mtn56RGVr6tigjA3HVU5oi73ZzKHFdVM73xGKP7W0QhK7g9YlfVrV0di85DnOIpSHFV2pdC81owtCMa0vzE5ppX839/iQUdksXkq8cwG6r7sRaS1d+a98AZFMO3xLQ74YlhLsNzAJ48efOCAhrpIMU3D3vuhVYNl1z0Vs2Z5LfZQ9/m6FH1dpUyHonl76Xhq7l1Vj8Wa9MgvHTHmNRlyg1CQi1PqnNN8YVGO3C58SZny+Tr8ho/aRrwE5nYEQYjEjwy95eYmQsYhfIK6q+gTxYcQbmKNNp3L3DcGeVj1IDMv3D71UaqBHi9zU51FL8GLuzWQX/G5KopgfrzsmVYEw2BHWwdNd2AH6C9qHLDoIS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ulo0RThQLzRia2VrQ0VCdWdoWVJZalEzWGlvRnVjM01OUzU3VElzczhReDZy?=
 =?utf-8?B?ckl6OVU4UWdxRGNFRWVWQ0N4YURaMStPLzkvOEVMLzVHeEtPZWdwN3JxR3ll?=
 =?utf-8?B?TXREcUlSbHBJNHpFRWVtM0xRS1ppaU9aUzYvV01jMWxaQTFVcm4rZ0R3YmVC?=
 =?utf-8?B?aWtWMmRnQ2xMczJlSzVYbXZrRXk3YTRrajR3dXBhRmJFOFdzbXFnRjhzbXk3?=
 =?utf-8?B?T2pSYWV5VjFudkV2bE9lR2JJcnhaM1lZdlVjRFFLWDczMzVzV3M1UGxib29P?=
 =?utf-8?B?eDlOWHplWXE2dXhRUkJjbVdqaHp0OTJtVm9UeFlDU1cwWXRwZW0vbHpLT2lP?=
 =?utf-8?B?czR2cHVxMVhRYndwUEtvajcxZkNoTXl5MVdWSHVNOVFPdG1wZHNyeU5WOXkx?=
 =?utf-8?B?OEprcHloanVvRmszTGpCRStDUzBUL0dld3Z3enhNWlFaYWVoQ2N2eE95N3Z6?=
 =?utf-8?B?VGc4UjBzYVhvZi9kOXhVRUF0R0RidFcvSHBsNEFrNXBqdUNzL3dCMllDSUFo?=
 =?utf-8?B?RUoxU0VBVlp2OGV4ZGZuRXVjU0E5OWNHWGFINDZ2NnhvR0Z1U3MxdzRWSXpz?=
 =?utf-8?B?SDI2MUVWQlFQVHFBcTlRRlF3aFcyTm80MkpRMGtuQTJYVVhZSHpHTUYrQTgy?=
 =?utf-8?B?M1lZYUlYUUVDWElHRXpPZ3crZkJmSE9FU3ZHYXFYMVl0ZFMzdGNuNU0xMS8x?=
 =?utf-8?B?TTBvVHRFQmZ3UHZaRHp5eG9IVW0wTkR3UnZaaExmN3VGeWE5RG5rR0lCWC83?=
 =?utf-8?B?cEIyV2FmaVlqQlpNWWRLSUNieloydFJZb25HY0YrVVNTK0ViZ1VFYlZDdVcz?=
 =?utf-8?B?Y3NFY3NLVXNkZG95ZlRGK1Y1M05UMktBM1VLMXZ6aThnZUZ3RHRmZ2FMZDZV?=
 =?utf-8?B?eXV0RXBlaDZobUV6MUtyNndabmF3QjFFZ3J1RTFhNXl4dnA1RlhsQXNDbVhS?=
 =?utf-8?B?d0RhTmFwQnVDL1RjSENZMWhOQ2ZNNzNIYzdSeHRpdm1wa3NhVm13L2NMbjJQ?=
 =?utf-8?B?VVpMckZpeUVwU0ZEdXdGQlZiUjVjSGJoeVloT1dJTEtGcUwzWHNaYXhBV2tM?=
 =?utf-8?B?eU9wampBY21zSm9Obm12SHhzV3V1WXNvZDR3TmtjT0N0VHBVNE5EeXBaVDhW?=
 =?utf-8?B?QkphWWU5VHBhT1pOWFpWb01HcHN4dGh5ajJlUHNjaUtQdFVWZTE2V013K1JZ?=
 =?utf-8?B?c1RPNXAwelZ1a2hXNC8zSG5RN3cvd1NZS2srSFVYdlFjNjh0M1M5aUZ4R21v?=
 =?utf-8?B?R2tSMGJRY3JvaUE0Um51Zzg4N2p5L3JoUEttQWVMOWlaNzBFWlFHMWRqbjZX?=
 =?utf-8?B?NUIyamlYa1BGYmZuT3NoUlo4clpkSG9odHZSdUJ1RDlIejJ0bFhMZ0g3QVBm?=
 =?utf-8?B?bnhjTFJ2RXNnV1hVM09nbnBiWGxPMUxZek4rbkdKbkhrMjhGL3RrUVNEWEZW?=
 =?utf-8?B?Y0NXSFNsMmh0WFNPTW5lSG9OQWZrcnJRVk9IZHZoYVpBYmhMUmY1cmpvVTZE?=
 =?utf-8?B?eE1ZVGZRMWJRODI2QlQzcFp1bGZMY25WRXBXS1NQYnRNQTd6VEprL0lNWkpw?=
 =?utf-8?B?RkE1Vzh5RU9jOEd3WlJxMjM0WVB6RVJLYTdxRjZBekVMTWprWkVGbGlQWTV4?=
 =?utf-8?B?V2hjNUUxbWNJV2w3WGVwMnBXQyt1bnR6bE04WFE0eFljZmw3NGlTSWc3dzNP?=
 =?utf-8?B?RDdRNmxxd0I1ck5ONEt0RnFIbEVBSktvRDRiVkI5OStTYXg4dTlqZGtqeG9h?=
 =?utf-8?B?c00zQ2RFSEFYaXlHTTFzR1EzaC83YmJucUxMTEc3MC9YNk9BTlAxeEl5bktR?=
 =?utf-8?B?aUdOMlFMOWFIdDBidnBObnRrbldDeUFhaVRhY3VlY2REOUZmejZsUk9RWDU5?=
 =?utf-8?B?QUo3WjVKUVhVNk9HUngwWXpvVy9CaWlUN21Pd2pPV0Nld1FRZVlxUmMrSEdY?=
 =?utf-8?B?Wnd6dWVjcVlBRFpoMGp1TmphQUhpZ0tlelFlR3o1Q1pYRVNGeVZEYjJ6K1Fo?=
 =?utf-8?B?Vk5sSit6UlFVb29iQWJUQTlyVkxDaDJuQVVlR21Iczh6ajVTbVBra0Q5ekFB?=
 =?utf-8?B?cVJ4RFVXSE8xM0E3Y01DbVFKVzhrdldJY1d1anZmUUh4WXVDQ2JzNzVPdjN6?=
 =?utf-8?B?RU9JWUtJT1hHZkF2SUc0Q1hFYVdleG1kdmtUZnQvbXlYWjFHMExGQmFjd1Q2?=
 =?utf-8?B?N0NTOTNkcGxOVUhyNk95ZTJvTHFFdWovQ3Ixc05ydnNQdFo4UDVQaXBKOFBX?=
 =?utf-8?B?aEppUkd6Y1RBV0NPMVFDYmpJaERjM29lSHhIbVVBdzhQK3plUjdVSm8wRlpS?=
 =?utf-8?B?UFIxaE4wdnUwRy9EUWJ0MVMwTTRIVy92Znh5Nm9FQzRJRHhnUUpWd2ZYQjgx?=
 =?utf-8?Q?S7nd0lVMMFX64lHE=3D?=
Content-ID: <6B3924D232079141AE0C61FAD2D86C5A@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ezJR3R4XtZNfGouGHzLcewKUHMPJce9rbQH6c+iqnTJMwYVwxwG32rMyuzyPuAIXDzVUoFiNm+a9afQSfoSrr8PMxWYF/sjiZmw8P3nDmtV87ugofw3Zkwewt15+Eh2kh7JA0emvPjBwMwUJ+QeQsAr4po/NDgaBVxsJFL43pCDTMZrd6SS3cUzSHvCpDU4sRF27l0XK2zFowafD6prZPlLZlrGuCZ5yPZFQE3E3gPn7zuh4fo9cJsG20PSHCEq6+6vsGVewZlmFTY4bn8l45LN8fh4/WwWyinmiGlcEC0elSRvsEjj/ltM9K2I+0bS3m2LywZqdIV3HoDmEzDFu6g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd64bd6b-17c1-4de6-9736-08dec08649c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 09:06:52.8324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lN7eaSJCsQOAt8NxZiqdWhQvvPIMcokzowQuTOH4jG7KzczEqVMhCRz6WMDl1CyTl1K5Ode8t6lEoi/vkYgLxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6860
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v13] high_freq_hwp_cap_cppc.c: new test
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
Cc: "Dubel, Helena Anna" <helena.anna.dubel@intel.com>, "Ossowski,
 Tomasz" <tomasz.ossowski@intel.com>, "Wysocki,
 Rafael J" <rafael.j.wysocki@intel.com>, "Niestepski,
 Daniel" <daniel.niestepski@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

UGluZy4gQUkgYWdlbnQgYXBwYXJlbnRseSBhZ3JlZXMgdGhpcyB0ZXN0IGlzIGZpbmUsIGlzIHRo
ZXJlIGFueXRoaW5nDQplbHNlIEkgc2hvdWxkIGRvPw0KDQoyMDI2LTA1LTE0ICjmnKgpIOOBriAx
MTozNSArMDIwMCDjgasgUGlvdHIgS3ViYWog44GV44KT44Gv5pu444GN44G+44GX44GfOg0KPiBW
ZXJpZnkgZm9yIGFsbCBvbmxpbmUgbG9naWNhbCBDUFVzIHRoYXQgdGhlaXIgaGlnaGVzdCBwZXJm
b3JtYW5jZQ0KPiB2YWx1ZSBhcmUNCj4gdGhlIHNhbWUgZm9yIEhXUCBDYXBhYmlsaXR5IE1TUiAw
eDc3MSBhbmQgQ1BQQyBzeXNmcyBmaWxlLg0KPiANCj4gT24gSFdQLWNhcGFibGUgeDg2IHBsYXRm
b3JtcyB0aGUgYWNwaV9jcHBjL2hpZ2hlc3RfcGVyZiBzeXNmcw0KPiBhdHRyaWJ1dGUgaXMNCj4g
ZXhwZWN0ZWQgdG8gcmVmbGVjdCB0aGUgc2FtZSBoaWdoZXN0LXBlcmZvcm1hbmNlIHZhbHVlIHRo
YXQgZmlybXdhcmUNCj4gcHJvZ3JhbXMgaW50byB0aGUgSFdQIENhcGFiaWxpdGllcyBNU1IgKDB4
NzcxLCBiaXRzIDc6MCkuIEEgbWlzbWF0Y2gNCj4gYmV0d2VlbiB0aGUgdHdvIGludGVyZmFjZXMg
aW5kaWNhdGVzIGEga2VybmVsIHJlZ3Jlc3Npb24gaW4gaG93IENQUEMNCj4gdmFsdWVzIGFyZSBl
eHBvc2VkIHRvIHVzZXJzcGFjZSwgYW5kIHdvdWxkIGJyZWFrIHRvb2xzIChlLmcuDQo+IGNwdXBv
d2VyLA0KPiBpbnRlbF9wc3RhdGUgdHVuaW5nIHNjcmlwdHMpIHRoYXQgcmVseSBvbiB0aGUgc3lz
ZnMgaW50ZXJmYWNlIHRvIG1ha2UNCj4gZnJlcXVlbmN5LXNjYWxpbmcgZGVjaXNpb25zLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogUGlvdHIgS3ViYWogPHBpb3RyLmt1YmFqQGludGVsLmNvbT4NCj4g
LS0tDQo+IEZpeCBjb21waWxhdGlvbiBlcnJvci4NCj4gwqBydW50ZXN0L3Bvd2VyX21hbmFnZW1l
bnRfdGVzdHPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+IMKgdGVz
dGNhc2VzL2tlcm5lbC9wb3dlcl9tYW5hZ2VtZW50Ly5naXRpZ25vcmXCoCB8wqDCoCAxICsNCj4g
wqAuLi4vcG93ZXJfbWFuYWdlbWVudC9oaWdoX2ZyZXFfaHdwX2NhcF9jcHBjLmMgfCAxMTQNCj4g
KysrKysrKysrKysrKysrKysrDQo+IMKgMyBmaWxlcyBjaGFuZ2VkLCAxMTYgaW5zZXJ0aW9ucygr
KQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMva2VybmVsL3Bvd2VyX21hbmFnZW1l
bnQvLmdpdGlnbm9yZQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiB0ZXN0Y2FzZXMva2VybmVs
L3Bvd2VyX21hbmFnZW1lbnQvaGlnaF9mcmVxX2h3cF9jYXBfY3BwYy5jDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvcnVudGVzdC9wb3dlcl9tYW5hZ2VtZW50X3Rlc3RzDQo+IGIvcnVudGVzdC9wb3dlcl9t
YW5hZ2VtZW50X3Rlc3RzDQo+IGluZGV4IGI2NzBkYTZlYy4uNGRhNTdlZTcyIDEwMDY0NA0KPiAt
LS0gYS9ydW50ZXN0L3Bvd2VyX21hbmFnZW1lbnRfdGVzdHMNCj4gKysrIGIvcnVudGVzdC9wb3dl
cl9tYW5hZ2VtZW50X3Rlc3RzDQo+IEBAIC0xLDQgKzEsNSBAQA0KPiDCoCNQT1dFUl9NQU5BR0VN
RU5UDQo+ICtoaWdoX2ZyZXFfaHdwX2NhcF9jcHBjIGhpZ2hfZnJlcV9od3BfY2FwX2NwcGMNCj4g
wqBydW5wd3Rlc3RzMDMgcnVucHd0ZXN0czAzLnNoDQo+IMKgcnVucHd0ZXN0czA0IHJ1bnB3dGVz
dHMwNC5zaA0KPiDCoHJ1bnB3dGVzdHMwNiBydW5wd3Rlc3RzMDYuc2gNCj4gZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9rZXJuZWwvcG93ZXJfbWFuYWdlbWVudC8uZ2l0aWdub3JlDQo+IGIvdGVzdGNh
c2VzL2tlcm5lbC9wb3dlcl9tYW5hZ2VtZW50Ly5naXRpZ25vcmUNCj4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwLi4wM2YwYzgzZTQNCj4gLS0tIC9kZXYvbnVsbA0KPiAr
KysgYi90ZXN0Y2FzZXMva2VybmVsL3Bvd2VyX21hbmFnZW1lbnQvLmdpdGlnbm9yZQ0KPiBAQCAt
MCwwICsxIEBADQo+ICtoaWdoX2ZyZXFfaHdwX2NhcF9jcHBjDQo+IGRpZmYgLS1naXQNCj4gYS90
ZXN0Y2FzZXMva2VybmVsL3Bvd2VyX21hbmFnZW1lbnQvaGlnaF9mcmVxX2h3cF9jYXBfY3BwYy5j
DQo+IGIvdGVzdGNhc2VzL2tlcm5lbC9wb3dlcl9tYW5hZ2VtZW50L2hpZ2hfZnJlcV9od3BfY2Fw
X2NwcGMuYw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAuLmE0ZjRk
NDE5Nw0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvcG93ZXJfbWFu
YWdlbWVudC9oaWdoX2ZyZXFfaHdwX2NhcF9jcHBjLmMNCj4gQEAgLTAsMCArMSwxMTQgQEANCj4g
Ky8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+ICsvKg0KPiAr
ICogQ29weXJpZ2h0IChDKSAyMDI2IFBpb3RyIEt1YmFqIDxwaW90ci5rdWJhakBpbnRlbC5jb20+
DQo+ICsgKi8NCj4gKw0KPiArLypcDQo+ICsgKiBWZXJpZnkgZm9yIGFsbCBvbmxpbmUgbG9naWNh
bCBDUFVzIHRoYXQgdGhlaXIgaGlnaGVzdCBwZXJmb3JtYW5jZQ0KPiB2YWx1ZSBhcmUNCj4gKyAq
IHRoZSBzYW1lIGZvciBIV1AgQ2FwYWJpbGl0eSBNU1IgMHg3NzEgYW5kIENQUEMgc3lzZnMgZmls
ZS4NCj4gKyAqDQo+ICsgKiBPbiBIV1AtY2FwYWJsZSB4ODYgcGxhdGZvcm1zIHRoZSBhY3BpX2Nw
cGMvaGlnaGVzdF9wZXJmIHN5c2ZzDQo+IGF0dHJpYnV0ZSBpcw0KPiArICogZXhwZWN0ZWQgdG8g
cmVmbGVjdCB0aGUgc2FtZSBoaWdoZXN0LXBlcmZvcm1hbmNlIHZhbHVlIHRoYXQNCj4gZmlybXdh
cmUNCj4gKyAqIHByb2dyYW1zIGludG8gdGhlIEhXUCBDYXBhYmlsaXRpZXMgTVNSICgweDc3MSwg
Yml0cyA3OjApLiBBDQo+IG1pc21hdGNoDQo+ICsgKiBiZXR3ZWVuIHRoZSB0d28gaW50ZXJmYWNl
cyBpbmRpY2F0ZXMgYSBrZXJuZWwgcmVncmVzc2lvbiBpbiBob3cNCj4gQ1BQQw0KPiArICogdmFs
dWVzIGFyZSBleHBvc2VkIHRvIHVzZXJzcGFjZSwgYW5kIHdvdWxkIGJyZWFrIHRvb2xzIChlLmcu
DQo+IGNwdXBvd2VyLA0KPiArICogaW50ZWxfcHN0YXRlIHR1bmluZyBzY3JpcHRzKSB0aGF0IHJl
bHkgb24gdGhlIHN5c2ZzIGludGVyZmFjZSB0bw0KPiBtYWtlDQo+ICsgKiBmcmVxdWVuY3ktc2Nh
bGluZyBkZWNpc2lvbnMuDQo+ICsgKi8NCj4gKw0KPiArI2luY2x1ZGUgInRzdF90ZXN0LmgiDQo+
ICsjaW5jbHVkZSAidHN0X3NhZmVfcHJ3LmgiDQo+ICsNCj4gKyNkZWZpbmUgTVNSX0hXUF9DQVBB
QklMSVRJRVMJMHg3NzENCj4gKyNkZWZpbmUgSElHSEVTVF9QRVJGX01BU0sJMHhGRg0KPiArDQo+
ICtzdGF0aWMgaW50IG5wcm9jOw0KPiArc3RhdGljIGludCBmZCA9IC0xOw0KPiArc3RhdGljIGlu
dCAqbWlzbWF0Y2g7DQo+ICsNCj4gK3N0YXRpYyB2b2lkIHNldHVwKHZvaWQpDQo+ICt7DQo+ICsJ
aWYgKGFjY2VzcygiL2Rldi9jcHUvMC9tc3IiLCBGX09LKSA9PSAtMSkNCj4gKwkJdHN0X2JyayhU
Q09ORiB8IFRFUlJOTywgIm1zciBkcml2ZXIgbm90IGxvYWRlZCIpOw0KPiArDQo+ICsJaWYNCj4g
KGFjY2VzcygiL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MC9hY3BpX2NwcGMvaGlnaGVzdF9w
ZXJmIiwgRl9PSykNCj4gPT0gLTEpDQo+ICsJCXRzdF9icmsoVENPTkYgfCBURVJSTk8sICJDUFBD
IHN5c2ZzIG5vdCBhdmFpbGFibGUiKTsNCj4gKw0KPiArCW5wcm9jID0gdHN0X25jcHVzX2NvbmYo
KTsNCj4gKwltaXNtYXRjaCA9IFNBRkVfTUFMTE9DKG5wcm9jICogc2l6ZW9mKGludCkpOw0KPiAr
fQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpDQo+ICt7DQo+ICsJaWYgKGZkICE9
IC0xKQ0KPiArCQlTQUZFX0NMT1NFKGZkKTsNCj4gKw0KPiArCWZyZWUobWlzbWF0Y2gpOw0KPiAr
fQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBydW4odm9pZCkNCj4gK3sNCj4gKwlib29sIHN0YXR1cyA9
IHRydWU7DQo+ICsJY2hhciBwYXRoW1BBVEhfTUFYXTsNCj4gKw0KPiArCW1lbXNldChtaXNtYXRj
aCwgMCwgbnByb2MgKiBzaXplb2YoKm1pc21hdGNoKSk7DQo+ICsNCj4gKwlmb3IgKGludCBpID0g
MDsgaSA8IG5wcm9jOyBpKyspIHsNCj4gKwkJaW50IG9ubGluZSA9IDE7DQo+ICsJCXVuc2lnbmVk
IGxvbmcgbG9uZyBtc3JfaGlnaGVzdF9wZXJmID0gMCwNCj4gc3lzZnNfaGlnaGVzdF9wZXJmID0g
MDsNCj4gKw0KPiArCQlpZiAoaSkgew0KPiArCQkJc25wcmludGYocGF0aCwgc2l6ZW9mKHBhdGgp
LA0KPiAiL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1JWQvb25saW5lIiwgaSk7DQo+ICsJCQlT
QUZFX0ZJTEVfU0NBTkYocGF0aCwgIiVkIiwgJm9ubGluZSk7DQo+ICsJCX0NCj4gKw0KPiArCQlp
ZiAoIW9ubGluZSkgew0KPiArCQkJdHN0X3JlcyhUSU5GTywgIkNQVSVkIG9mZmxpbmUsIHNraXBw
aW5nIiwNCj4gaSk7DQo+ICsJCQljb250aW51ZTsNCj4gKwkJfQ0KPiArDQo+ICsJCXNucHJpbnRm
KHBhdGgsIHNpemVvZihwYXRoKSwNCj4gIi9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdSVkL2Fj
cGlfY3BwYy9oaWdoZXN0X3BlcmYiLCBpKTsNCj4gKwkJU0FGRV9GSUxFX1NDQU5GKHBhdGgsICIl
bGx1IiwgJnN5c2ZzX2hpZ2hlc3RfcGVyZik7DQo+ICsJCXRzdF9yZXMoVERFQlVHLCAiJXM6ICVs
bHUiLCBwYXRoLA0KPiBzeXNmc19oaWdoZXN0X3BlcmYpOw0KPiArDQo+ICsJCXNucHJpbnRmKHBh
dGgsIHNpemVvZihwYXRoKSwgIi9kZXYvY3B1LyVkL21zciIsIGkpOw0KPiArCQlmZCA9IFNBRkVf
T1BFTihwYXRoLCBPX1JET05MWSk7DQo+ICsNCj4gKwkJU0FGRV9QUkVBRCgxLCBmZCwgJm1zcl9o
aWdoZXN0X3BlcmYsDQo+IHNpemVvZihtc3JfaGlnaGVzdF9wZXJmKSwgTVNSX0hXUF9DQVBBQklM
SVRJRVMpOw0KPiArCQlTQUZFX0NMT1NFKGZkKTsNCj4gKwkJbXNyX2hpZ2hlc3RfcGVyZiAmPSBI
SUdIRVNUX1BFUkZfTUFTSzsNCj4gKwkJdHN0X3JlcyhUREVCVUcsICIlczogJWxsdSIsIHBhdGgs
IG1zcl9oaWdoZXN0X3BlcmYpOw0KPiArDQo+ICsJCWlmIChtc3JfaGlnaGVzdF9wZXJmICE9IHN5
c2ZzX2hpZ2hlc3RfcGVyZikgew0KPiArCQkJdHN0X3JlcyhUSU5GTywgImNwdSVkOiBzeXNmcz0l
bGx1IE1TUj0lbGx1IiwNCj4gKwkJCQlpLCBzeXNmc19oaWdoZXN0X3BlcmYsDQo+IG1zcl9oaWdo
ZXN0X3BlcmYpOw0KPiArCQkJbWlzbWF0Y2hbaV0gPSAxOw0KPiArCQkJc3RhdHVzID0gZmFsc2U7
DQo+ICsJCX0NCj4gKwl9DQo+ICsNCj4gKwlmb3IgKGludCBpID0gMDsgaSA8IG5wcm9jOyBpKysp
DQo+ICsJCXRzdF9yZXMoVElORk8sICJjcHUlZDogJXMiLCBpLCBtaXNtYXRjaFtpXSA/DQo+ICJN
SVNNQVRDSCIgOiAiT0siKTsNCj4gKw0KPiArCWlmIChzdGF0dXMpDQo+ICsJCXRzdF9yZXMoVFBB
U1MsICJTeXNmcyBhbmQgTVNSIHZhbHVlcyBhcmUgZXF1YWwiKTsNCj4gKwllbHNlDQo+ICsJCXRz
dF9yZXMoVEZBSUwsICJIaWdoZXN0IHBlcmZvcm1hbmNlIHZhbHVlcyBkaWZmZXINCj4gYmV0d2Vl
biBzeXNmcyBhbmQgTVNSIik7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3Qg
dGVzdCA9IHsNCj4gKwkubmVlZHNfa2NvbmZpZ3MgPSAoY29uc3QgY2hhciAqY29uc3QgW10pIHsN
Cj4gKwkJIkNPTkZJR19BQ1BJX0NQUENfTElCIiwNCj4gKwkJIkNPTkZJR19YODZfTVNSIiwNCj4g
KwkJTlVMTA0KPiArCX0sDQo+ICsJLm5lZWRzX3Jvb3QgPSAxLA0KPiArCS5zZXR1cCA9IHNldHVw
LA0KPiArCS5jbGVhbnVwID0gY2xlYW51cCwNCj4gKwkuc3VwcG9ydGVkX2FyY2hzID0gKGNvbnN0
IGNoYXIgKmNvbnN0IFtdKSB7DQo+ICsJCSJ4ODYiLA0KPiArCQkieDg2XzY0IiwNCj4gKwkJTlVM
TA0KPiArCX0sDQo+ICsJLnRlc3RfYWxsID0gcnVuDQo+ICt9Ow0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkludGVs
IFRlY2hub2xvZ3kgUG9sYW5kIHNwLiB6IG8uby4KdWwuIFNsb3dhY2tpZWdvIDE3MyB8IDgwLTI5
OCBHZGFuc2sgfCBTYWQgUmVqb25vd3kgR2RhbnNrIFBvbG5vYyB8IFZJSSBXeWR6aWFsIEdvc3Bv
ZGFyY3p5IEtyYWpvd2VnbyBSZWplc3RydSBTYWRvd2VnbyAtIEtSUyAxMDE4ODIgfCBOSVAgOTU3
LTA3LTUyLTMxNiB8IEthcGl0YWwgemFrbGFkb3d5IDIwMC4wMDAgUExOLgpTcG9sa2Egb3N3aWFk
Y3phLCB6ZSBwb3NpYWRhIHN0YXR1cyBkdXplZ28gcHJ6ZWRzaWViaW9yY3kgdyByb3p1bWllbml1
IHVzdGF3eSB6IGRuaWEgOCBtYXJjYSAyMDEzIHIuIG8gcHJ6ZWNpd2R6aWFsYW5pdSBuYWRtaWVy
bnltIG9wb3puaWVuaW9tIHcgdHJhbnNha2NqYWNoIGhhbmRsb3d5Y2guCgpUYSB3aWFkb21vc2Mg
d3JheiB6IHphbGFjem5pa2FtaSBqZXN0IHByemV6bmFjem9uYSBkbGEgb2tyZXNsb25lZ28gYWRy
ZXNhdGEgaSBtb3plIHphd2llcmFjIGluZm9ybWFjamUgcG91Zm5lLiBXIHJhemllIHByenlwYWRr
b3dlZ28gb3RyenltYW5pYSB0ZWogd2lhZG9tb3NjaSwgcHJvc2lteSBvIHBvd2lhZG9taWVuaWUg
bmFkYXdjeSBvcmF6IHRyd2FsZSBqZWogdXN1bmllY2llOyBqYWtpZWtvbHdpZWsgcHJ6ZWdsYWRh
bmllIGx1YiByb3pwb3dzemVjaG5pYW5pZSBqZXN0IHphYnJvbmlvbmUuClRoaXMgZS1tYWlsIGFu
ZCBhbnkgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG1hdGVyaWFsIGZvciB0
aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gSWYgeW91IGFyZSBub3Qg
dGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRlciBhbmQgZGVs
ZXRlIGFsbCBjb3BpZXM7IGFueSByZXZpZXcgb3IgZGlzdHJpYnV0aW9uIGJ5IG90aGVycyBpcyBz
dHJpY3RseSBwcm9oaWJpdGVkLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
