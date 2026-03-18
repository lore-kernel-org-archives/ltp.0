Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B65DFCD0C4
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 13:06:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B20023E608E
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 14:06:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 806233CD52A
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 14:05:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1F1FD200929
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 14:05:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773839149; x=1805375149;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=UBUVYx1MOXL4k1qvwisrUt432yL4NTPcHjnTxTA7ldk=;
 b=bufOXmAUJLJvapcmaLyJWWV5yAv8D/ZFYzBpH41gpbuOZCm9xvFBlQ/G
 Rj/wGc4xXjekh7cs/j1f862rPh/mDNh21uAKibDYpyo9x70giQ6NUValo
 sMAMdZm3lx6ifmQvwZVx1ZHi17aRe2nTqRUlI2zdPdaNdxVfoRAyXzJoS
 EoFqDnR8vJs9vlOe+2O5mDOp/8/avPDOSaxi5651SNnuPlGFO6jmJHjbl
 MdUOo8LXZoSDruUFOouu2q6x+KAoqfqjes1Bmj4UeSmmS78iD+W8HtNMf
 N3zA8C/aA6idtMhHKKEq6G/E5KIvLQdycJRJL7WqBb9GgTfajxiFmrGj6 g==;
X-CSE-ConnectionGUID: ouvoj/iDTw6kcJF/CB/YFw==
X-CSE-MsgGUID: dhrLNbpETueCpQ+HYeOGpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="86247387"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="86247387"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 06:05:47 -0700
X-CSE-ConnectionGUID: 2rx33eGiSAuPhrhaYEYvrg==
X-CSE-MsgGUID: 2lLmkEZdTym6bw8TfHzGcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="222677652"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 06:05:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 06:05:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 06:05:46 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 06:05:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQ3WQGsAB47+sJhqmp6TKqb22vdUWQf9Ik97wp+di7Lh+R1ra6NYRr8mdyq5P0+MK723znVyhvpXCWPRuiJsKC2WiQCfpg+vY1+OwTuZoJ0uYPAh2aLgyLGenJpzEw8dheNtg0gmZVmB8OrgI9heJNAjm6jU2D0uUeJkI0qhQZbRDDUlEsRf4bs4GZBekpADHJE3Po5dXY9axjlt0UVYLKOG77B7DkLBWEtcEknvreXj3DJR6tM0qyoezutpjZe8eyagIQ8rXPkGt8e4Kht7WgemiqmVrkMtGckpMIBiNMsb4wi+y1g+IPqyr2aDcI9JxzVq/oyXrRLlnCkfHDQZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOE8y/59zKk0C1TsjLQKPomcIPvz1NocOiFJMlKQfXs=;
 b=NPLpVEmfQGMj0twF3YMDu2XGo/Mcema/YLSc+S3fsC+EWIdNoM7hZswOJ5KHNdKqdWFVWa/cQB6+gvkaUFkmCfnEEplVanrZR/FoMj0pDeV3zbmXeuVzcMPd60H/3dFNaTdK2yg2wfiMoON9tTvOTkozUSelhlHaXxnfOPLgZUxr1rfXBMnXnRZp12RNY+eDz9Y60cqREMqrjL9rMaMYib/ub6VbULCCsd50XzieYx73nV7+8DgJ4bZDdOsJUtCX3EpTOpovG9/2Yqo3NDMai/ZzWPP9sNpwSoxl05Bp1rYJjWZctS/OQomVjaO85jA10/VUPNwx1oI/wkjFzCFrEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by CH0PR11MB5251.namprd11.prod.outlook.com (2603:10b6:610:e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 13:05:44 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%3]) with mapi id 15.20.9723.013; Wed, 18 Mar 2026
 13:05:44 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "pvorel@suse.cz" <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] high_freq_hwp_cap_cppc.c: new test
Thread-Index: AQHcsuiMzlPosDhqZUqrcO24JRcEsLWxHDyAgAMtzAA=
Date: Wed, 18 Mar 2026 13:05:44 +0000
Message-ID: <f30646a1e3d1b7bf781385a8d58bc47c52b463fd.camel@intel.com>
References: <20260313125408.480770-2-piotr.kubaj@intel.com>
 <20260316123301.GA313808@pevik>
In-Reply-To: <20260316123301.GA313808@pevik>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|CH0PR11MB5251:EE_
x-ms-office365-filtering-correlation-id: 5a728385-33f2-43ee-2d23-08de84ef10a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: lwMrdXu5Fx+kZsBAdmUaghfwtsagAV0mxmbh3TDC0SgWcWdYJf42oOYxXKD7Zg8vtpLS3Fe+qQCIbftIarT8EeupP1IjoZrr6Rlcozb3IoKg2xpkA/vDxTuP1G1+1Rs5QnsWS5ZTOW2KnOUF+2KL6dMXA3MeXHPcu1TE+tXDse6elNBw9WwMDSYgUK04b+9wzdAw//s+lMnpxZK9xO3jxuEW0GLpU9VBYaKoyBwyipIHDitGFwniOrIs7n5fHMWSJQ8sU9r9wuvaK45ynBg/hMN+gjp/6lKWafwpsmzXiQzr9dIGt7lmtzHUF/1MUxLPrO9uSigR6QA9VT4f7Y9JY5q7mWMQtzuTUScQIzwIQaFLm7ouWQatBljZl+Ek8Sr3BrE3FJL4Yly/qAuE4tUcAHtSBXdu8gamsepTWimRwCZ7Y4mrGjYuUQ8xxL4YntUDzS1TD32FM+Al8b9wL4mGEyReHLor/RIcERRSL4N9rbUu/4nMII/E7QX6dk0mjYqCr4yQ3/JPlbdcBB/SRfOzdRYI9UtbkzmmsFcvM7l++wFQpWhgNeQz4Uu2683qAK0Dc5E72gOuOSKPPx2Fh/Yh7M7thTtGASDXHCsQ7ND32CceUPLIeZ2Dgihhmv/l1vyMY8Fu1NixQqw/B6zWxpf2FMb1vtVnusnCB9II9wZBKltLlZtxIWtoGqtg11LvHKE6wWJPf3NF7BnRu4+qAzAo7rLMiTZq6FY3fHBpXSGWyIjA8fMBWoo9xks67CNe6E6w
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFhycFpWM1Y1ZWtZcVh4MlE0NU1ENDRXVUpaSEdQSTl1ZWpwTE5zTVp0OWJV?=
 =?utf-8?B?Q2VkamVSRVBHY0w4aGgyd1B1ZmlUZm0zSTJ0bFFsWWZyUjFHeGR0M0ZXYWo0?=
 =?utf-8?B?eFRxd2dmWjlqQTJNemEwR2dwckllV3dMOVphZHZyQktoaVRwWFJXbHNTYWFX?=
 =?utf-8?B?UmRITFBsWlhUa0Vsb09pSzcrUzZIOHhYOExkQnZML21oV2dMMjZwRFZMOEZt?=
 =?utf-8?B?SEtHZE1DT2g1dEJ3SkZydUQ1a3RVVE13OTNtYkV0N0RBVnB6d2k1ams2KzND?=
 =?utf-8?B?Wkp2SFlKcUh0M2drSGV6Qk95alJDaGJMMENzdlpsOXZKUHQxanVHVFlIdzdt?=
 =?utf-8?B?YktsUUp0U2gyMStoY1JLUzdWdm1MVGIrWFJsUUFUWnlpRG50WXQ3MFpYeHk2?=
 =?utf-8?B?S1JCdEJ1UTRvWCtBbGl1aytCTHg3RndjalVVY1Y4OHNyOFQrYk5YcnlkY1gy?=
 =?utf-8?B?eDAzREpaemZlSk0wMEhSbTRYdWl3NmQ4WWUrOGNlSWkyYXVlK3BFeXM3ZjR3?=
 =?utf-8?B?ZURBdmZEeFA1UHRrbGo5dVZWT1hFUWRiUEhURnVDTldTQTZDTFBETUxiM0xy?=
 =?utf-8?B?cG5JQWpmVzhlWXV6TzZST09GMHIrYTl5V2ZSTVQrQ0NsemZMNUpRZk1PK2J6?=
 =?utf-8?B?MVQ0WXQzaHp1WUFQcnlpdjcvTWR3aEtabTNoYW1VUFo1Qi9VQ2diMGp0d0s0?=
 =?utf-8?B?YmJBbEl6ckQ1SFVSRXk1WlUweC9OMnNwSmU3NEtQTzN6algyUEw1a2J6RFNn?=
 =?utf-8?B?d1NsajhxNTV0amk4QTMxV0JRVzh6ZGtMbXlnRUg3dkcxa29FY2w5b3FQQ0E3?=
 =?utf-8?B?UVBPdUFNZEs4YWJJcXA5RHRsckhRSlNOZjhyL1dkOUZPK0ZNVGNuWDdwbVQ1?=
 =?utf-8?B?MFZGK29IS3NNZmxETkh3Z1FZSWxTU3FDOHo0Z3ZqSGgxUnJ1eElOeUFkd3BU?=
 =?utf-8?B?dDR0TXdRTE1WVmNHMTJuWVhWZThxdXNSQ2xlMHhFMmJaZGd6S0hTUTlVUFBw?=
 =?utf-8?B?S3JDdW9JdmFRY2RJQ1ZpT1VmRDlDQlVjRjF2K1E0YjcxVjJ5ZkYxZUJKZXhn?=
 =?utf-8?B?Mjl1TW5rUVBWcEVITk5wQzQzYVlkWlFYV1ozcFUxb2pEWFMzNjJWTjhVMEJD?=
 =?utf-8?B?QlZwOWdwU0FPRzlvOG9rY2lKRFBnLzA2Y0U2a3VHbEM1T0s1Z3ozWEhZQnlh?=
 =?utf-8?B?b3k4b0h6WWNXL210dWswSmkzdHFzVGlvU2ZaTi8zb0p0dlZOTFpWY2V1dTRh?=
 =?utf-8?B?TEZ0VGYyZzVlaEVJNmg2c0xKMTJYekd6R1gxTk9QbmFrMUcvSW9rMnhnaDIw?=
 =?utf-8?B?SG0rZEpadWs0MzBpQ2VuY2Npb29WU0FUS1hzZzdwUXRhbE16TzIycmxmTk83?=
 =?utf-8?B?UVBmUmhGQU9EWWtFRnJQOXpkaGNXTWg3SW1jUEF2REgvRG1rZnp2RDFxYWdk?=
 =?utf-8?B?cjdoVXg5MHJNNnZEZXJoWTltd1RvblNaMXZLWHdFZnlscVo2cTlMU2ZGVWpa?=
 =?utf-8?B?bXlaTm1CRVZjem9tNEVxRGoraE4rQjQ5ZFdESEdadDEzNUkrWXdFL0Z5Q0xL?=
 =?utf-8?B?YXh2bHp5Ukd5UDRWVlpUaWVkcjQ1aTc5TE90ejErVko0UnpDTXpzamdmY0I0?=
 =?utf-8?B?S1JZVzIyWkVlQ3FWWS9vTjdTc3JNa2tRQVc0K2lhaXhmNzVCUWRkNkpVSFFx?=
 =?utf-8?B?Q0hiZmtlWXVIZWFCT0xVWmVzQmpxNnJyQnplVStubXRmT05TUlZVcUJYRU1o?=
 =?utf-8?B?Ni9DMWM5M3VhdkxpWVgxZ0dDemY5UVFEVVNUalVZOUcrTWQ4VGR3OW5GZ1hK?=
 =?utf-8?B?RXlqKzF0WTdNNG1tRTREbzRmbDJPOWorbFh0bUFvZDlNR1RLMUVTY1ZYT0ht?=
 =?utf-8?B?ZXlKMmZyaUJ5TXJQZkFKeWpVZVJKUVI2SFNxeDltYVVnc2Y3d1FIbjE0amp6?=
 =?utf-8?B?SWxGaWFPd1QyU0tZNHlNd01nQ243OEYxTGxnVzBBV1FJWEF1dmtZb3ovRmx4?=
 =?utf-8?B?aGVEWEYrb2lueEpMQ1BWdldXMzFhakVnalFCTVBVZHEvMDJBbHlvTkNQZ2tq?=
 =?utf-8?B?TDNVVFp0aSs1dkw0elVvL2l5MXFvVDJDZHI0ZmNzcGtEclF1UWZPeEE5RGQx?=
 =?utf-8?B?ajQ4NEx4WFEra0hwWldRNVRkNzBwQ2FnYm1zVTNDbGM4QWFFT09JTG9XRTk3?=
 =?utf-8?B?dERHS0pQczFpSnBTUzFVN284cEw2djNoNVVpQ2ZoUldmMDVpd2FSRXhXWUpX?=
 =?utf-8?B?RDVTcFQ3UDhIUDE1NHJsSitDWVd1Q2JOcTFXY1hmRnVEbFVJS3BncFNCS2p1?=
 =?utf-8?B?UjZvc1FaZVM1VEpFVW91RjVsYnQwRk5HalptNEdJbGROb0pzVTBPNjhjbytm?=
 =?utf-8?Q?nja3Kq+Pw2RdQ9N0=3D?=
Content-ID: <69DFBF6AF0161641ACD750B92AD7D913@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: F718PSaNwjNPVDJ/inYLHh0GKKhRF6KQi71kLHsOZZoHkC8TeKVHY8s3ZBxPeH0OdLid7VtUHQXWFT8K5Rad2OeNhW0+LnjukOV23veKyDfKd7msNnXaYbHXMKMLtSsrJBIfEhkiQzeTHrLp8QzHekuP7jmg7TSvtMUGwW1e2MW+bDIZTUubJrThd1MKeEVTV+Ujf3lhoAN5jkJopnL0JYKf9LWcQRrBqn/bfysVNP+1kgJUZfOUu1Cn/+lEwXPHAK1PN6vL8rOIpN0+diWQ976l2Nl9RGpLkhV2Yrm3XoNuvXLy97ZCCAacjToRq01GaiXnn3w9CwloBTZh8U1W1Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a728385-33f2-43ee-2d23-08de84ef10a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 13:05:44.3997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pAqvdMRm79ix5kk7KBa4IMAc/XvfEM+C9Vc3wfzP6v7hpjH4R5TJL0ktuyV8zNn6POoFipMRixeYXPbsgl0ikg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5251
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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
Cc: "Dubel, Helena Anna" <helena.anna.dubel@intel.com>, "Ossowski,
 Tomasz" <tomasz.ossowski@intel.com>, "Wysocki,
 Rafael J" <rafael.j.wysocki@intel.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>, "Niestepski,
 Daniel" <daniel.niestepski@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

MjAyNi0wMy0xNiAo5pyIKSDjga4gMTM6MzMgKzAxMDAg44GrIFBldHIgVm9yZWwg44GV44KT44Gv
5pu444GN44G+44GX44GfOg0KPiBIaSBQaW90ciwNCj4gDQo+ID4gVmVyaWZ5IGZvciBhbGwgb25s
aW5lIGxvZ2ljYWwgQ1BVcyB0aGF0IHRoZWlyIGhpZ2hlc3QgcGVyZm9ybWFuY2UNCj4gPiB2YWx1
ZSBhcmUNCj4gPiB0aGUgc2FtZSBmb3IgSFdQIENhcGFiaWxpdHkgTVNSIDB4NzcxIGFuZCBDUFBD
IHN5c2ZzIGZpbGUuDQo+IA0KPiBZb3Ugd2VyZSBzdXBwb3NlZCB0byBhZGQgeW91ciBSQlQ6DQo+
IFNpZ25lZC1vZmYtYnk6IFBpb3RyIEt1YmFqIDxwaW90ci5rdWJhakBpbnRlbC5jb20+DQo+IA0K
PiA+IC0tLQ0KPiA+IMKgdGVzdGNhc2VzL2tlcm5lbC9wb3dlcl9tYW5hZ2VtZW50Ly5naXRpZ25v
cmXCoCB8wqAgMSArDQo+ID4gwqAuLi4vcG93ZXJfbWFuYWdlbWVudC9oaWdoX2ZyZXFfaHdwX2Nh
cF9jcHBjLmMgfCA1Nw0KPiA+ICsrKysrKysrKysrKysrKysrKysNCj4gDQo+IFlvdSBkaWQgbm90
IGFkZCB0ZXN0IGludG8gcnVudGVzdC90aGVybWFsLiBPVE9IIHRlc3Qgd2lsbCBhcHBseSBhbHNv
DQo+IGFmdGVyIHdlDQo+IGZpbmFsbHkgbWVyZ2UgdGhlcm1hbF9pbnRlcnJ1cHRfZXZlbnRzLmMu
DQoNCkl0J3MgYWN0dWFsbHkgbm90IHRoZXJtYWwtcmVsYXRlZCwgYnV0IHRoZXJlIGFyZSBnb2lu
ZyB0byBiZSBtb3JlDQp0aGVybWFsIHRlc3RzIGFueXdheS4NCg0KPiANCj4gPiDCoDIgZmlsZXMg
Y2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKQ0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4g
dGVzdGNhc2VzL2tlcm5lbC9wb3dlcl9tYW5hZ2VtZW50L2hpZ2hfZnJlcV9od3BfY2FwX2NwcGMu
Yw0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9wb3dlcl9tYW5hZ2VtZW50
Ly5naXRpZ25vcmUNCj4gPiBiL3Rlc3RjYXNlcy9rZXJuZWwvcG93ZXJfbWFuYWdlbWVudC8uZ2l0
aWdub3JlDQo+ID4gaW5kZXggMGMyYTNlZDRiLi5jMTNiY2ExYzQgMTAwNjQ0DQo+ID4gLS0tIGEv
dGVzdGNhc2VzL2tlcm5lbC9wb3dlcl9tYW5hZ2VtZW50Ly5naXRpZ25vcmUNCj4gPiArKysgYi90
ZXN0Y2FzZXMva2VybmVsL3Bvd2VyX21hbmFnZW1lbnQvLmdpdGlnbm9yZQ0KPiA+IEBAIC0xICsx
LDIgQEANCj4gPiAraGlnaF9mcmVxX2h3cF9jYXBfY3BwYw0KPiA+IMKgcG1fZ2V0X3NjaGVkX3Zh
bHVlcw0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL3Rlc3RjYXNlcy9rZXJuZWwvcG93ZXJfbWFuYWdl
bWVudC9oaWdoX2ZyZXFfaHdwX2NhcF9jcHBjLmMNCj4gPiBiL3Rlc3RjYXNlcy9rZXJuZWwvcG93
ZXJfbWFuYWdlbWVudC9oaWdoX2ZyZXFfaHdwX2NhcF9jcHBjLmMNCj4gPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMC4uNGNiYjgxZjBiDQo+ID4gLS0tIC9kZXYvbnVs
bA0KPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvcG93ZXJfbWFuYWdlbWVudC9oaWdoX2ZyZXFf
aHdwX2NhcF9jcHBjLmMNCj4gPiBAQCAtMCwwICsxLDU3IEBADQo+ID4gKy8vIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+ID4gKw0KPiA+ICsvKg0KPiA+ICsgKiBD
b3B5cmlnaHQgKEMpIDIwMjUtMjAyNiBJbnRlbCAtIGh0dHA6Ly93d3cuaW50ZWwuY29tLw0KPiA+
ICsgKi8NCj4gPiArDQo+ID4gKy8qXA0KPiA+ICsgKiBWZXJpZnkgZm9yIGFsbCBvbmxpbmUgbG9n
aWNhbCBDUFVzwqAgdGhhdCB0aGVpciBoaWdoZXN0DQo+ID4gcGVyZm9ybWFuY2UgdmFsdWUgYXJl
DQo+ID4gKyAqIHRoZSBzYW1lIGZvciBIV1AgQ2FwYWJpbGl0eSBNU1IgMHg3NzEgYW5kIENQUEMg
c3lzZnMgZmlsZS4NCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSAidHN0X3Rlc3QuaCIN
Cj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgbnByb2M7DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBz
ZXR1cCh2b2lkKQ0KPiA+ICt7DQo+ID4gKwlucHJvYyA9IHRzdF9uY3B1cygpOw0KPiA+ICt9DQo+
ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBydW4odm9pZCkNCj4gPiArew0KPiA+ICsJZm9yIChpbnQg
aSA9IDA7IGkgPCBucHJvYzsgaSsrKSB7DQo+ID4gKwkJY2hhciBwYXRoW1BBVEhfTUFYXTsNCj4g
PiArCQl1bnNpZ25lZCBsb25nIGxvbmcgbXNyX2hpZ2hlc3RfcGVyZiA9IDAsDQo+ID4gc3lzZnNf
aGlnaGVzdF9wZXJmID0gMDsNCj4gPiArDQo+ID4gKwkJc25wcmludGYocGF0aCwgUEFUSF9NQVgs
DQo+ID4gIi9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdSVkL2FjcGlfY3BwYy9oaWdoZXN0X3Bl
cmYiLCBpKTsNCj4gPiArCQlTQUZFX0ZJTEVfU0NBTkYocGF0aCwgIiVsbHUiLA0KPiA+ICZzeXNm
c19oaWdoZXN0X3BlcmYpOw0KPiANCj4gSSB0cmllZCB0byBydW4gdGhlIHRlc3QsIGJ1dCBpdCBm
YWlscyBkdWUgbWlzc2luZyBzeXNmcyBmaWxlOg0KPiANCj4gJCBncmVwIENPTkZJR19YODZfTVNS
IC9ib290L2NvbmZpZy02LjE5LjAtcmMxLTEuZzI3NGFmZjUtZGVmYXVsdCANCj4gQ09ORklHX1g4
Nl9NU1I9bQ0KPiANCj4gJCBsc21vZCB8Z3JlcCBtc3INCj4gaW50ZWxfcmFwbF9tc3LCoMKgwqDC
oMKgwqDCoMKgIDIwNDgwwqAgMA0KPiBpbnRlbF9yYXBsX2NvbW1vbsKgwqDCoMKgwqAgNTMyNDjC
oCAxIGludGVsX3JhcGxfbXNyDQo+IA0KPiAjIC4vaGlnaF9mcmVxX2h3cF9jYXBfY3BwYyANCj4g
dHN0X3Rlc3QuYzoxODg3OiBUSU5GTzogT3ZlcmFsbCB0aW1lb3V0IHBlciBydW4gaXMgMGggMDJt
IDAwcw0KPiAuLi4NCj4gaGlnaF9mcmVxX2h3cF9jYXBfY3BwYy5jOjI4OiBUQlJPSzogRmFpbGVk
IHRvIG9wZW4gRklMRQ0KPiAnL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MC9hY3BpX2NwcGMv
aGlnaGVzdF9wZXJmJyBmb3IgcmVhZGluZzoNCj4gRU5PRU5UICgyKQ0KPiANCj4gIyBtb2Rwcm9i
ZSBtc3INCj4gDQo+ICQgbHNtb2QgfGdyZXAgbXNyDQo+IG1zcsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDEyMjg4wqAgMA0KPiBpbnRlbF9yYXBsX21zcsKgwqDCoMKgwqDC
oMKgwqAgMjA0ODDCoCAwDQo+IGludGVsX3JhcGxfY29tbW9uwqDCoMKgwqDCoCA1MzI0OMKgIDEg
aW50ZWxfcmFwbF9tc3INCj4gDQo+ICMgLi9oaWdoX2ZyZXFfaHdwX2NhcF9jcHBjDQo+IC4uLg0K
PiBoaWdoX2ZyZXFfaHdwX2NhcF9jcHBjLmM6Mjg6IFRCUk9LOiBGYWlsZWQgdG8gb3BlbiBGSUxF
DQo+ICcvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUwL2FjcGlfY3BwYy9oaWdoZXN0X3BlcmYn
IGZvciByZWFkaW5nOg0KPiBFTk9FTlQgKDIpDQo+IA0KPiA9PiBvYnZpb3VzbHkgY2hlY2tpbmcg
Zm9yIENPTkZJR19YODZfTVNSIGlzIG5vdCBlbm91Z2guDQpSaWdodCwgQ09ORklHX0FDUElfQ1BQ
Q19MSUIgaXMgYWxzbyBuZWNlc3NhcnkuDQoNCj4gDQo+IE9UOiBpdCdkIGJlIG5pY2UgdG8gZXh0
ZW5kICdzYXZlX3Jlc3RvcmUnIGxpYnJhcnkgZnVuY3Rpb25hbGl0eSB0bw0KPiAxKSBzdXBwb3J0
IGdsb2IgKC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdSovYWNwaV9jcHBjL2hpZ2hlc3RfcGVy
ZikNCj4gMikgcmVhZCB2YWx1ZSBpbnRvIHRoZSB2YXJpYWJsZSAoaW4gY2FzZSBvZiBnbG9iIGlu
dG8gYXJyYXkpLg0KPiANCj4gPiArCQl0c3RfcmVzKFRERUJVRywgIiVzOiAlbGx1IiwgcGF0aCwN
Cj4gPiBzeXNmc19oaWdoZXN0X3BlcmYpOw0KPiA+ICsNCj4gPiArCQlzbnByaW50ZihwYXRoLCBQ
QVRIX01BWCwgIi9kZXYvY3B1LyVkL21zciIsIGkpOw0KPiA+ICsJCWludCBmZCA9IFNBRkVfT1BF
TihwYXRoLCBPX1JET05MWSk7DQo+ID4gKw0KPiA+ICsJCWlmIChwcmVhZChmZCwgJm1zcl9oaWdo
ZXN0X3BlcmYsDQo+ID4gc2l6ZW9mKG1zcl9oaWdoZXN0X3BlcmYpLCAweDc3MSkgPCAwKSB7DQo+
ID4gKwkJCVNBRkVfQ0xPU0UoZmQpOw0KPiA+ICsJCQl0c3RfYnJrKFRCUk9LIHwgVEVSUk5PLCAi
TVNSIHJlYWQgZXJyb3IiKTsNCj4gPiArCQl9DQo+ID4gKwkJU0FGRV9DTE9TRShmZCk7DQo+ID4g
KwkJbXNyX2hpZ2hlc3RfcGVyZiAmPSAoMVVMTCA8PCA4KSAtIDE7DQo+ID4gKwkJdHN0X3JlcyhU
REVCVUcsICIlczogJWxsdSIsIHBhdGgsDQo+ID4gbXNyX2hpZ2hlc3RfcGVyZik7DQo+ID4gKw0K
PiA+ICsJCWlmIChtc3JfaGlnaGVzdF9wZXJmICE9IHN5c2ZzX2hpZ2hlc3RfcGVyZikNCj4gPiAr
CQkJdHN0X2JyayhURkFJTCwgIkNQVSAlZDogaGlnaGVzdA0KPiA+IHBlcmZvcm1hbmNlIHZhbHVl
cyBkaWZmZXIgYmV0d2VlbiBzeXNmcyBhbmQgTVNSIiwgaSk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+
ICsJdHN0X3JlcyhUUEFTUywgIlRlc3QgcGFzcyIpOw0KPiANCj4gIlRlc3QgcGFzcyIgaGFzIHpl
cm8gaW5mb3JtYXRpb24gdmFsdWUuDQo+IE1heWJlIHNvbWV0aGluZyBsaWtlOg0KPiAic3lzZnMg
YW5kIE1TUiB2YWx1ZXMgYXJlIGVxdWFsIg0KRG9uZS4NCg0KPiANCj4gPiArfQ0KPiA+ICsNCj4g
PiArc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gew0KPiA+ICsJLm5lZWRzX2tjb25maWdz
ID0gKGNvbnN0IGNoYXIgKmNvbnN0IFtdKSB7DQo+ID4gKwkJIkNPTkZJR19YODZfTVNSIiwNCj4g
PiArCQlOVUxMDQo+ID4gKwl9LA0KPiBGb3IgdGhlcm1hbF9pbnRlcnJ1cHRfZXZlbnRzLmMgd2Ug
YWxzbyBoYXZlIHVzZSAuc3VwcG9ydGVkX2FyY2hzIChmb3INCj4gdGhlIGRvY3MNCj4gcHVycG9z
ZXMpLCB3aHkgbm90IHRvIGFkZCBpdCB0byB0aGlzIHRlc3QgYXMgd2VsbD8NCkkgcmVtb3ZlZCBp
dCBmb3IgdGhlIHNhbWUgcmVhc29uIHRoYXQgd2FzIG1lbnRpb25lZCBpbiB0aGUgcmV2aWV3IGZv
cg0KdGhlcm1hbF9pbnRlcnJ1cHRfZXZlbnRzLmMuIE1TUiBpcyB4ODYtIGFuZCB4ODZfNjQtb25s
eS4gQWRkZWQgaW4gdGhlDQpuZXdlciB2ZXJzaW9uLg0KPiANCj4gKwkuc3VwcG9ydGVkX2FyY2hz
ID0gKGNvbnN0IGNoYXIgKmNvbnN0IFtdKSB7DQo+ICsJCSJ4ODYiLA0KPiArCQkieDg2XzY0IiwN
Cj4gKwkJTlVMTA0KPiArCX0sDQo+IA0KPiBLaW5kIHJlZ2FyZHMsDQo+IFBldHINCj4gDQo+ID4g
KwkubmVlZHNfcm9vdCA9IDEsDQo+ID4gKwkuc2V0dXAgPSBzZXR1cCwNCj4gPiArCS50ZXN0X2Fs
bCA9IHJ1bg0KPiA+ICt9Ow0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkludGVsIFRlY2hub2xvZ3kgUG9sYW5kIHNw
LiB6IG8uby4KdWwuIFNsb3dhY2tpZWdvIDE3MyB8IDgwLTI5OCBHZGFuc2sgfCBTYWQgUmVqb25v
d3kgR2RhbnNrIFBvbG5vYyB8IFZJSSBXeWR6aWFsIEdvc3BvZGFyY3p5IEtyYWpvd2VnbyBSZWpl
c3RydSBTYWRvd2VnbyAtIEtSUyAxMDE4ODIgfCBOSVAgOTU3LTA3LTUyLTMxNiB8IEthcGl0YWwg
emFrbGFkb3d5IDIwMC4wMDAgUExOLgpTcG9sa2Egb3N3aWFkY3phLCB6ZSBwb3NpYWRhIHN0YXR1
cyBkdXplZ28gcHJ6ZWRzaWViaW9yY3kgdyByb3p1bWllbml1IHVzdGF3eSB6IGRuaWEgOCBtYXJj
YSAyMDEzIHIuIG8gcHJ6ZWNpd2R6aWFsYW5pdSBuYWRtaWVybnltIG9wb3puaWVuaW9tIHcgdHJh
bnNha2NqYWNoIGhhbmRsb3d5Y2guCgpUYSB3aWFkb21vc2Mgd3JheiB6IHphbGFjem5pa2FtaSBq
ZXN0IHByemV6bmFjem9uYSBkbGEgb2tyZXNsb25lZ28gYWRyZXNhdGEgaSBtb3plIHphd2llcmFj
IGluZm9ybWFjamUgcG91Zm5lLiBXIHJhemllIHByenlwYWRrb3dlZ28gb3RyenltYW5pYSB0ZWog
d2lhZG9tb3NjaSwgcHJvc2lteSBvIHBvd2lhZG9taWVuaWUgbmFkYXdjeSBvcmF6IHRyd2FsZSBq
ZWogdXN1bmllY2llOyBqYWtpZWtvbHdpZWsgcHJ6ZWdsYWRhbmllIGx1YiByb3pwb3dzemVjaG5p
YW5pZSBqZXN0IHphYnJvbmlvbmUuClRoaXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5
IGNvbnRhaW4gY29uZmlkZW50aWFsIG1hdGVyaWFsIGZvciB0aGUgc29sZSB1c2Ugb2YgdGhlIGlu
dGVuZGVkIHJlY2lwaWVudChzKS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVu
dCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRlciBhbmQgZGVsZXRlIGFsbCBjb3BpZXM7IGFueSBy
ZXZpZXcgb3IgZGlzdHJpYnV0aW9uIGJ5IG90aGVycyBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
