Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2019CD4F54
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 07:29:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3DCA53CAE6D
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 09:29:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D23563C58CC
 for <ltp@lists.linux.it>; Wed, 27 May 2026 09:28:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5DA9760071C
 for <ltp@lists.linux.it>; Wed, 27 May 2026 09:28:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779866924; x=1811402924;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=30DKjszcCon7Xp66lV3UzG0iKObk6HMmt50QBMVigSc=;
 b=W78vDwnF6NSaz4N9mxJZ2gYZzG6FwiMymT5KBWB0p+K+d1NnHo7pKVly
 WBTTGhBDLt+ZJ0q3C3WL772m3L4P1ts0AdJaxAUnjlQV+6PjiAMCsxKQ7
 ck8qrlcvK6sCDx+cSdBSZwp7X/xHHFnr0Q9ZqT8YqGlpP/AmP/WXHSIZP
 3mf1BvFKVcKqMzoP6jvLGqDcmM6vNK0Pjb2TAOUGf1zgk1mitPm/UKY4z
 yyjJ+pB8aratWJR3v5Dc4ke9UKIt82ElutBSKRqx9qQJzLp3Du7eRzyul
 nnvYmz9MR+KhPcYuy2o2BNWSTj4IpkCuPCZiiubc1UeaOKdyyRUlu9hip Q==;
X-CSE-ConnectionGUID: /nMXjTWPStS2AqGV++Mhyw==
X-CSE-MsgGUID: lCtmMJZ2Tk2weq/GIF86JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="84544976"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="84544976"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 00:28:41 -0700
X-CSE-ConnectionGUID: mFFKj6S1TWOn+OnC6M55Rg==
X-CSE-MsgGUID: XNDYiZidTfeyh1phA6H1oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="247106183"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 00:28:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 00:28:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 00:28:40 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 00:28:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yX7SVCDWgoH3jO+t7y5wsew0DwqOt+kNO5WshC8qnsu1RwpGgvyvfo5pJ9W6XKSg++ASVqqeW80L1q91LUNIbluzZv6aHsW3QI2CzOhc6C+vGsI3E7XpLvOy2GKjaZsHeCv5dinKW31/bL3/MKSuPAcK4oOX6we0MrcZ9drfg3RTzLIiGmShbGmXLmSEmsnKqZJiu+pCHhKvX4r6NiJjXKPGsv/tAhl36+raCg+7F5Rf4zd7uVHxM7DVQBmG7INXtZpNdBsL0TYOlZvWKUhwMpyeYiT83LB+IWWROqcZzBdv+WHMMWkWkeuixSsY8Dmh68ZMXpBXfkldbDUCM38PXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9j5VkRsc3GiywJfuVOei8d3NkCM6l1QlPzjrPsRpXxs=;
 b=jdo2wEOL7cSeBrksajtgDAN3XA35+lRuF9FJbGT/RzujfzxifrOr1M4HuhEnXLqbJuaRK1+8y0r+4DOZcig7i8asIrNbrjFjiWoA1r1eqiXn6R3ioFMt51RR5WtqR6GuKsUkEZt8wdsbVSHqR6SX+NR2lMRBA1H/aKIvcvuczrIVtukKzxnCT1IGEkjgBZKwVMsXdG6TqjNKjm0dkwtz8jRwo0GoP2BUGTgF5Qbbl4d41slSO7AeU4bCQG9ZLhYXJGFS0yU7vxqgqJ/lcidPs2iMwZnmVtgyiAv2giMmvrVnBTLprAmV9CejhUjJFNiFihlEwvSCGrKxuTfIYwLISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by SAVPR11MB9576.namprd11.prod.outlook.com (2603:10b6:806:4e6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 07:28:32 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%3]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 07:28:32 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "linuxtestproject.agent@gmail.com" <linuxtestproject.agent@gmail.com>,
 "pvorel@suse.cz" <pvorel@suse.cz>
Thread-Topic: [LTP] thermal: add new test group
Thread-Index: AQHc46yvXeKfCE06bke+L7mzmc0z47YPKtEAgARJwwCADhjogA==
Date: Wed, 27 May 2026 07:28:32 +0000
Message-ID: <21a5a4cec4cbb9a7084b8b5374fa06865a0d74d8.camel@intel.com>
References: <20260514133446.144550-2-piotr.kubaj@intel.com>
 <20260514141912.4030-1-linuxtestproject.agent@gmail.com>
 <20260515144242.GB40164@pevik>
 <d1e90d8d94fd4cb58f34cbff4a07b49257195129.camel@intel.com>
In-Reply-To: <d1e90d8d94fd4cb58f34cbff4a07b49257195129.camel@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|SAVPR11MB9576:EE_
x-ms-office365-filtering-correlation-id: 304f7f99-2494-499d-5fc6-08debbc18e38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: mQWhxYzA0kz8PqLkFycXYfLgc1OoZF46zPrHwZ3BGG5fArbB0zKV45Cl+cnn1yj7qB3Uo7IxOtKxn7GYyRBOECeAscy461YQhlfXsQ+JcChfYUeC+CbzTkMV2N9tFpHxxM0gp6hIyuAbzytO76Nm/SYXsrv1O6Zi3GY18uHhExiQ3InqL00bW7c2gLCT2SpxTz/zlrhMYTElpqRBBupe/QL5xXhvOkxYlmgnh0h1brRtj2CyZTOwJ9xgQvGsTGKQPOmvE7ZrUKn203egh2/kof/uHWm8W9I3vMfHQA2K3ergYYL4dEWDPdp1cahD+l9+rybD93WgktvLFtIWyXOyPIKvfa4qgy3NfCsk6nngxb9te76hmA8XkLWO8weIU1IxN0zKX/51mbczOIF5YtuKlzUGjUUfVey2cwfUAglnsjJeBczoIoIiarb8ubDucfl/H/kGIMhIfEGRQOPoD/KMnqvtjMiFLTAJ4Dd8anayIlrSM4ZzChngIQVf3BwI0nzDqRs2Ufk1YOfOzcF4WtA5PaEaKb7JaFKwCzqfq4r6jpeOIQnpjZp1QrnwCW8LxdYSm77zPy8yoqwTxhJbWldKPknMkdRlHQ0MDJoUZMkr/VfPupwjhQ2BFgQUCVMiX+pxpd0x+MQJHCQjO9dFEhdfEQm7L5U9KRfpyWCKbyHoKvYcBApem5dPdh07eVdi4a1l4nGMLmJjoUqqr6ZFP16cAzYOeg6BLV7Xf/RF3xFWqDwnJOaXVQJqMoYBTTUqyodK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2l0OUVjV0IrMkV4aFNHWDlXSlptTzlLZTdxYVh5VkMvMlJRVzMxR2Z5bnVr?=
 =?utf-8?B?UTN3MTU4eGxjZW9aUTVYbzE5WmVZUHhiWm9hQlZqQjRRNk5FcW5SZ1N5enZX?=
 =?utf-8?B?RmNIbkR2OXY3L0FJSnNsemgvcGRselBNNzlHUGp1clJoUFRwVndVd0s2UWRF?=
 =?utf-8?B?dGw1OVliRGhiNnFmcXY3cU1nQXBFdVdzZTNPUWNHVUJNT1JyV0h2QUhxNUdQ?=
 =?utf-8?B?NlpTRXVxTWI3VGpKNkRua29GRGppZnVCclJWWnc3ZDZQcTVYcUR3eVlXcWpT?=
 =?utf-8?B?Ni9pY0o4SHRYclIxNGhxWmhnMTJ0TjlYbUU1QnlhRTdvdnJicmNFMEprT0FI?=
 =?utf-8?B?czlXdUMzMXFoL1d2QWhoK294VWF1aXBGY1lScUF4eGd5RUxBZU91SzBtbkpP?=
 =?utf-8?B?UVZYUEFwek95STIrWXhZK0tHbE13U2Q4MURzeUFwRFEvamYvT0JNaU5DVEFr?=
 =?utf-8?B?OFJnUENLeXF4ZTZSUHhleFJHK3VvSXl0dit4MHlnZzdxK3Eydk91UXhoaXNz?=
 =?utf-8?B?Yk9tSFIvcWpiUWlVc1hCemVSZjBCQzR2N0RBbms5NFZ3RHNjM2V6cDRqMGlX?=
 =?utf-8?B?STR0akU1NGVVMitTNGxZUm41TWhHRzFEL0VISE11b0Fqc1RZRlUwMUpNSElN?=
 =?utf-8?B?WFkvalhPUDgrTjJsSVVSZmt6Sk9vMnMxQXFsb1VZUGhjbXFjRUxKaEhxVWRu?=
 =?utf-8?B?Tlpic2pOSXU0TmhjUndtbVg3NVBuK2w1TmU0Z0w4M2NmWGZiNitOZ0drc0hS?=
 =?utf-8?B?QU1vR0FkN3lzM21HR2s2cWlzZEFFRjMwaGg1dlNxTGdwQ2d3NTJuUVAxNGFH?=
 =?utf-8?B?bUs0eUVlTnRMRVkwR1JqQmpXbEtTUmxETitOU2VLR2ZyQlRjNEc0V1lnd0hF?=
 =?utf-8?B?MGtrWGJKS05pZXk4TVR6SXZUMDc0Q2MwNEJVb1pBS1dWYVk0dGNtVUNmbkdw?=
 =?utf-8?B?TUR3T1hqZWVPL0N0Z0xKdkI5RGpFYUZVWXQzVDFhMjRBdW9WVGlSTCtDRFZy?=
 =?utf-8?B?c25YRnFkellaT1p5ZUdMc2lnUTRzK08xV2QzWnRjRENHZFVsNkNCT0JBNWxv?=
 =?utf-8?B?d3FObm41azhPUDQzVEwwNzZTbTZ3NXIwMDdXWkNvblJXdVNnY2E4aXROMFMz?=
 =?utf-8?B?VEgrQ3NMTDU5WUhWeFB4YWFrc1NUbUtSTy93WExaazgwSHZrMWorcThNV2lV?=
 =?utf-8?B?V2hYcVI3SE8zQVVmV2cxcENqQ3FBUERZNjBuQU8xY1pJSjVDMDdBaWcxTHFp?=
 =?utf-8?B?SDRxUktWSlhoRE5RTUJUem41ZzVHYUxMa3djaWI0NWhrVWVxU3grSllTMzQ5?=
 =?utf-8?B?cEFFUDRXUkE2am1KcEowa0g0VzltOEc2UExyZzdrQmptTUdZSmtaNmtGL2VV?=
 =?utf-8?B?Q3U4emtacHVoYVFwUEZnQStCMGZwNkZlbTU2VzBMNU5IclJFYUZUc2k2cEpT?=
 =?utf-8?B?ZjMyK2k2ckl3UXdYeWQ3MzZIRCtzcDE4RVQ3WDlUS01UWGQ5TWpWYXBMb3Qy?=
 =?utf-8?B?WmdQL3pWUTdjdnFnWmc1dm9rSEdydDk5R0xlTzNDdW9vU2tjcFU1SGRDcHJs?=
 =?utf-8?B?bnpVazVxL3VaWlhuVVl1bG1XTVlqOHlYc0lNT1FMYTFMeXJFamlvVkYrOTc4?=
 =?utf-8?B?TThQQmx2bjZLaUYrQkpQTWUybThpWTVSSDBaMVJGKyt2RWo3NlRpZngxSTVW?=
 =?utf-8?B?ZDJ0Y3Nnd1B1ZjJEbHRVSkRhUCtiWlZ5YTVpbHF4cW5nZkNUdFpTVVZaUGFM?=
 =?utf-8?B?bDZEa3BtMEF3YUZsQnVTVVZQZ0Z0bWNxMGZjSTIwaVVudVFMVHJKWW80dDY0?=
 =?utf-8?B?bWVqMVUvemJqZTdzaUpPMFdVQmsvWDJMWVg3NmlLM0dUL1RabzlUdnlPNWtF?=
 =?utf-8?B?WE1aWjBWb3QrSmRvQ0lHVnZpcVBacnN1Nm9yYjJWaGV4TWx5QTl1WmpxU1lP?=
 =?utf-8?B?V1VjUC9POE9aRlBxb3NSeTc2UVQ1bkYyeUNSNjd4dmZaUlplbG1yR3Z3bnVI?=
 =?utf-8?B?Q2dYQUVLR3JrdFZwN1NsQ0kyNzNVUjg3SnM5TWZQTzFyWlhJR1NvQ0NjdVht?=
 =?utf-8?B?VkRVaHhSZTByVWpUZnJpdk5FRlVDWDBIdjZLdm9VZ3NvTW02bzJNUlduOGJ4?=
 =?utf-8?B?S1RQcjFIck5hb3R0Rm45WGE3dGdnS2RlaWtIdWRuOXBUZnE3aTAvS040eWtQ?=
 =?utf-8?B?QjVVcEVVUWZHZkZ2dmlZeGlQbUducGl3Z2hmQi9VVUM4b29uZElMSXpFd0Jv?=
 =?utf-8?B?d25nQi9pL3dudzBzTWNEMmRjZ2NEVG96MHRxYzBaVzZKRjRjTnZXNUw0OUxv?=
 =?utf-8?B?U2Z1WTdvcXBwQjlUSTc2c216NndEWnZTeVdVcC9QK2cyV1JoYjFORk41d1ly?=
 =?utf-8?Q?UmMOVzZ2+UjCXfog=3D?=
Content-ID: <44E4266E2551954084CB3AFFEA422179@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eOs2HyHAUKYItZnI0bYU4WxwCztM5mlQ2v2fSGBiGz0+FMZpjyj5yQwlOL4pbj/2TP/JgyPZ481dsPUzEVBREx4v6PcjTAnyEEJe3Lw+S/Cr/SzS3jt4H9uMTIw5towQaMHdr2Q8YSKO5eiNiv5+EtQh4DeiyAmP6o09EJcDCMs8zgMS9d141DZgbHMXDaY1PmiwXfjrsbpxHd+gHQ70ENhiP/t7FY8qFua1UCH7ZspIT1JBJPMy0jSex7EYsJUSztXUyVFt+s2qpbL7NZILKl+uLiPsQ6kZr/zMuil1RCRegcK/C5FH4fMhjjJATFRsnvUmUGaZ8ulDX63/dP774A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 304f7f99-2494-499d-5fc6-08debbc18e38
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 07:28:32.1801 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyLzlOvm0PKiHCrHJtN4EG1vKQMQCugZ2ldfXfAX4S4sccHg99OEfuPR6jf7c09KGQ7x19oWkGVdsZhmYsIeJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR11MB9576
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
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

U2luY2UgdGhlcmUncyBubyBvdGhlciByZXZpZXcsIGlzIHYyMCByZWFkeSB0byBtZXJnZT8NCg0K
MjAyNi0wNS0xOCAo5pyIKSDjga4gMDg6MTEgKzAwMDAg44GrIEt1YmFqLCBQaW90ciDjgZXjgpPj
ga/mm7jjgY3jgb7jgZfjgZ86DQo+IEkgc2V0IGl0IHRvIDMwMHMsIGFzIHJlcXVlc3RlZCwgYmVj
YXVzZSBhdHRlbXB0cyB0byBzZXQgaXQgdG8gNjBzIGFuZA0KPiAxMjBzIGdhdmUgc29tZSBmYWls
dXJlcyB3aGVuIHJ1bm5pbmcgd2l0aCAtaSAxMC4NCj4gDQo+IDIwMjYtMDUtMTUgKOmHkSkg44Gu
IDE2OjQyICswMjAwIOOBqyBQZXRyIFZvcmVsIOOBleOCk+OBr+abuOOBjeOBvuOBl+OBnzoNCj4g
PiBIaSBhbGwsDQo+ID4gDQo+ID4gYWN0dWFsbHkgdjIwIGlzIGJldHRlciB0aGFuIHRoaXMgdjIx
ID0+IHNldHRpbmcgaXQgY2hhbmdlcw0KPiA+IHJlcXVlc3RlZC4NCj4gPiBJJ2QgcHJlZmVyIHRv
IG1lcmdlIHYyMC4NCj4gPiANCj4gPiA+IEhpIFBpb3RyLA0KPiA+IA0KPiA+ID4gT24gVGh1LCAx
NCBNYXkgMjAyNiAxNTozNDo0NyArMDIwMCwgUGlvdHIgS3ViYWogd3JvdGU6DQo+ID4gPiA+IHRo
ZXJtYWw6IGFkZCBuZXcgdGVzdCBncm91cA0KPiA+IA0KPiA+ID4gPiArCXdoaWxlIChzbGVlcF90
aW1lID4gMCkgew0KPiA+ID4gPiArCQkuLi4NCj4gPiA+ID4gKwkJaWYgKHRlbXAgPiB0ZW1wX2hp
Z2gpDQo+ID4gPiA+ICsJCQlicmVhazsNCj4gPiA+ID4gKwkJc2xlZXAoc2xlZXBfdGltZS0tKTsN
Cj4gPiANCj4gPiA+IEcyOiBzbGVlcCgpIHVzZWQgZm9yIHN5bmNocm9uaXphdGlvbi4gVGhpcyBp
cyBub3QgYSB0aW1lciBBUEkNCj4gPiA+IHRlc3QNCj4gPiA+IHNvDQo+ID4gPiB0aGUgRzIgZXhl
bXB0aW9uIGRvZXMgbm90IGFwcGx5LiBDb25zaWRlciBwb2xsaW5nIHdpdGgNCj4gPiA+IHRzdF90
aW1lcl9leHBpcmVkX21zKCkgb3IgZGlzY3VzcyB3aXRoIG1haW50YWluZXJzIGlmIGEgdGhlcm1h
bC0NCj4gPiA+IHNwZWNpZmljDQo+ID4gPiBleGNlcHRpb24gaXMgYXBwcm9wcmlhdGUuDQo+ID4g
DQo+ID4gPiA+ICsJCQl0c3RfcmVzKFRJTkZPLCAiQ29vbGluZyBkb3duIGZvciAlZA0KPiA+ID4g
PiBzZWNvbmRzIiwgQ09PTERPV04pOw0KPiA+ID4gPiArCQkJc2xlZXAoQ09PTERPV04pOw0KPiA+
IA0KPiA+ID4gRzI6IFNhbWUgaXNzdWUg4oCUIHNsZWVwKCkgdXNlZCBhcyBhIHN5bmNocm9uaXph
dGlvbiBiYXJyaWVyIGZvcg0KPiA+ID4gQ1BVDQo+ID4gPiBjb29sZG93biBiZXR3ZWVuIHpvbmUg
dGVzdHMuIElmIGEgbm9uLXNsZWVwIGFsdGVybmF0aXZlIGlzDQo+ID4gPiBnZW51aW5lbHkNCj4g
PiA+IGluZmVhc2libGUgZm9yIHRoZXJtYWwgdGVzdGluZywgdGhpcyBuZWVkcyBleHBsaWNpdCBq
dXN0aWZpY2F0aW9uDQo+ID4gPiBpbiB0aGUNCj4gPiA+IGNvbW1pdCBtZXNzYWdlLg0KPiA+IA0K
PiA+IFllcywgY29vbGRvd24gY291bGQgaGF2ZSBiZWVuIG1lbnRpb25lZCBpbiB0aGUgY29tbWl0
IG1lc3NhZ2UsIEknbGwNCj4gPiBhZGQgaXQgZm9yDQo+ID4gdjIwLg0KPiA+IA0KPiA+IEtpbmQg
cmVnYXJkcywNCj4gPiBQZXRyDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBJbnRlbCBUZWNobm9sb2d5IFBv
bGFuZCBzcC4geiBvLm8uDQo+IHVsLiBTbG93YWNraWVnbyAxNzMgfCA4MC0yOTggR2RhbnNrIHwg
U2FkIFJlam9ub3d5IEdkYW5zayBQb2xub2MgfA0KPiBWSUkgV3lkemlhbCBHb3Nwb2RhcmN6eSBL
cmFqb3dlZ28gUmVqZXN0cnUgU2Fkb3dlZ28gLSBLUlMgMTAxODgyIHwNCj4gTklQIDk1Ny0wNy01
Mi0zMTYgfCBLYXBpdGFsIHpha2xhZG93eSAyMDAuMDAwIFBMTi4NCj4gU3BvbGthIG9zd2lhZGN6
YSwgemUgcG9zaWFkYSBzdGF0dXMgZHV6ZWdvIHByemVkc2llYmlvcmN5IHcNCj4gcm96dW1pZW5p
dSB1c3Rhd3kgeiBkbmlhIDggbWFyY2EgMjAxMyByLiBvIHByemVjaXdkemlhbGFuaXUNCj4gbmFk
bWllcm55bSBvcG96bmllbmlvbSB3IHRyYW5zYWtjamFjaCBoYW5kbG93eWNoLg0KPiANCj4gVGEg
d2lhZG9tb3NjIHdyYXogeiB6YWxhY3puaWthbWkgamVzdCBwcnplem5hY3pvbmEgZGxhIG9rcmVz
bG9uZWdvDQo+IGFkcmVzYXRhIGkgbW96ZSB6YXdpZXJhYyBpbmZvcm1hY2plIHBvdWZuZS4gVyBy
YXppZSBwcnp5cGFka293ZWdvDQo+IG90cnp5bWFuaWEgdGVqIHdpYWRvbW9zY2ksIHByb3NpbXkg
byBwb3dpYWRvbWllbmllIG5hZGF3Y3kgb3Jheg0KPiB0cndhbGUgamVqIHVzdW5pZWNpZTsgamFr
aWVrb2x3aWVrIHByemVnbGFkYW5pZSBsdWIgcm96cG93c3plY2huaWFuaWUNCj4gamVzdCB6YWJy
b25pb25lLg0KPiBUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIG1heSBjb250YWluIGNv
bmZpZGVudGlhbCBtYXRlcmlhbCBmb3INCj4gdGhlIHNvbGUgdXNlIG9mIHRoZSBpbnRlbmRlZCBy
ZWNpcGllbnQocykuIElmIHlvdSBhcmUgbm90IHRoZQ0KPiBpbnRlbmRlZCByZWNpcGllbnQsIHBs
ZWFzZSBjb250YWN0IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSBhbGwgY29waWVzOw0KPiBhbnkgcmV2
aWV3IG9yIGRpc3RyaWJ1dGlvbiBieSBvdGhlcnMgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4NCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQpJbnRlbCBUZWNobm9sb2d5IFBvbGFuZCBzcC4geiBvLm8uCnVsLiBTbG93YWNr
aWVnbyAxNzMgfCA4MC0yOTggR2RhbnNrIHwgU2FkIFJlam9ub3d5IEdkYW5zayBQb2xub2MgfCBW
SUkgV3lkemlhbCBHb3Nwb2RhcmN6eSBLcmFqb3dlZ28gUmVqZXN0cnUgU2Fkb3dlZ28gLSBLUlMg
MTAxODgyIHwgTklQIDk1Ny0wNy01Mi0zMTYgfCBLYXBpdGFsIHpha2xhZG93eSAyMDAuMDAwIFBM
Ti4KU3BvbGthIG9zd2lhZGN6YSwgemUgcG9zaWFkYSBzdGF0dXMgZHV6ZWdvIHByemVkc2llYmlv
cmN5IHcgcm96dW1pZW5pdSB1c3Rhd3kgeiBkbmlhIDggbWFyY2EgMjAxMyByLiBvIHByemVjaXdk
emlhbGFuaXUgbmFkbWllcm55bSBvcG96bmllbmlvbSB3IHRyYW5zYWtjamFjaCBoYW5kbG93eWNo
LgoKVGEgd2lhZG9tb3NjIHdyYXogeiB6YWxhY3puaWthbWkgamVzdCBwcnplem5hY3pvbmEgZGxh
IG9rcmVzbG9uZWdvIGFkcmVzYXRhIGkgbW96ZSB6YXdpZXJhYyBpbmZvcm1hY2plIHBvdWZuZS4g
VyByYXppZSBwcnp5cGFka293ZWdvIG90cnp5bWFuaWEgdGVqIHdpYWRvbW9zY2ksIHByb3NpbXkg
byBwb3dpYWRvbWllbmllIG5hZGF3Y3kgb3JheiB0cndhbGUgamVqIHVzdW5pZWNpZTsgamFraWVr
b2x3aWVrIHByemVnbGFkYW5pZSBsdWIgcm96cG93c3plY2huaWFuaWUgamVzdCB6YWJyb25pb25l
LgpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIG1heSBjb250YWluIGNvbmZpZGVudGlh
bCBtYXRlcmlhbCBmb3IgdGhlIHNvbGUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocyku
IElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBjb250YWN0IHRo
ZSBzZW5kZXIgYW5kIGRlbGV0ZSBhbGwgY29waWVzOyBhbnkgcmV2aWV3IG9yIGRpc3RyaWJ1dGlv
biBieSBvdGhlcnMgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4KCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
