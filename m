Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049A9C79F89
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 08:33:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19F2F3E5397
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 10:33:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 173F33C56F4
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 10:32:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BA16B1400973
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 10:32:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788769978; x=1820305978;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=+DjSDAMiF4mNdXmsI28RNjS+28CdG/t/cG4b/9qvKoE=;
 b=VPlP6KOqxC9uIllqZol9HkVYwJ7445wBILa45nMY2CxMZv5Mg1o44/Bi
 CbwrNF7VS9VFsraR/SOTErYsJk86LCrc/ZAK934CFTN6J4T8jSPd2HnT1
 DV9kIF4W4u0K+p8mDkfz2eq432kH2/yte1QCCTPNMJAzxdHPceI39oaUk
 imWeYEuUcJYHLsIrULzLObR8bdtmm/gfLGuV+/3Ww9vGq4kvQ7DmvnS5A
 YJwyR4Hu6pYCZHVua2vjQ/p0eEHa4ciMNJqN//q8Sj+wY4SyLOH7UvxP9
 vIcArjZyUn9DAQfwKsmqrKq++dqq/LX+puqAm7qlB6l+l9W13qpyNUwkM A==;
X-CSE-ConnectionGUID: 58JlcdF8TcavfENEo6TRJw==
X-CSE-MsgGUID: Bt/roH5/Sm2N8mNBfQtkFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="91681204"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="91681204"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 01:32:53 -0700
X-CSE-ConnectionGUID: Dw74oW6FQJKzKR9Jn8liQw==
X-CSE-MsgGUID: uPiB9vAZQwiib1OrM8rhIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="268918846"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 01:32:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 01:32:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 01:32:52 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 01:32:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGuMC7/R9qhRTa1YAxy2z+87hoat/Pl5ULmrAxq+FS+6qE15s6sNTFUTp7+8qfK5JrDhdrYdER6k0rJOaEcRq3yRr7xiyxrdjD0rZH0e4f3+K2oN2QuD4+yHtKcv+0vyujkQCDIQ/grtEFo0z+Q3sCjHQQKTqhpPTnm+dTqlO8ZiFDKSSuOszB1EOdYCxM8Tzi0hAf4AYEYxZjIkNaBPrHfNnrR6F8z/G7S1m+Gtm5An2iHAMNh1d1s6AgyXhxKtftibHKgi2NxuZK/LaJlv9LsHzIHev0/KDCXjAQde5PjL/Jv9PXF6i2B43z0CRS0zyww+IgP77frPub5xus2RNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzFmau1RXsrdHe7WHFBYrLr9/ErIhnHxy4dOtw+ZGms=;
 b=FNa/i1kxpIDo5HhQTJMcWCHNzuHojF1GLbLniREvMJ+2sNFvDSKeDNvuBydmY7grh33aS5rYvOsNyoNaDygLVpSKhHWfD/G3x+9pwjUr65bnRL3lc8I5yNZNC+mkepxK6IJ5G1poDNW+Aoipa48q/hnmgMNJ4n+VfuUEhmc2yJhWsmQWKqCMpD8fbAePiI+ImHzqwQ0R++LsbmyOUPzkLXtI2i0A+ID6XHjU/Slp6/KWM+fCRmIOEohdrdQ2ou0UgB522q5pm/0WUEH+R6ZQeT8Hut/K9+r/jdOip0rFqIzmI9YJx9xnoghrtzX0w2jZcTdNDGvghZtSrp6Wfoa37w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by IA1PR11MB6170.namprd11.prod.outlook.com (2603:10b6:208:3ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 08:32:49 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 08:32:49 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "andrea.cervesato@suse.de" <andrea.cervesato@suse.de>, "chrubis@suse.cz"
 <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] lib: Check minimal supported kernel version
Thread-Index: AQHdPESXQqkbetoZqEWjwDFaKiDByba+JM+AgASplAA=
Date: Mon, 7 Sep 2026 08:32:49 +0000
Message-ID: <1c65ce3e51948f19ff8eae28671d0961c0fcb0dd.camel@intel.com>
References: <20260904-min_kernel-v1-1-47b556550780@suse.com>
 <apqNcb103ZVuzpIf@yuki.lan>
In-Reply-To: <apqNcb103ZVuzpIf@yuki.lan>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|IA1PR11MB6170:EE_
x-ms-office365-filtering-correlation-id: 5d6e2c52-a086-4942-8e30-08df0cba9a15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|56012099006|4143699003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: m8doJTqzutgjYq3s92sK03r9UROseLluWOk0CW8cccNn/ans74ZWas2N12FKo7fsA0BNsGKpdXMt3iwWs2ol40HOIh9qEYhwft9TER1L0Nq3FthedxH6zIZpG/ePLpPI1friyzU77ts8CRXibBZaU4E5JtYO+CcROHe5pzMXNjUj1MthmtDxlaDVYHLOypRYTs9SRx+zuIEOvU5nlbuwqyQgVppH1SIRNKimmfl91iLzenZtkChvYePd3jAkagnKa8mp+v9IpoCXl1LlOQq3GPSqvvHJ5C/kr3AY5/pjVvh59LldRrde+GyO2JZpyJNVpcRB+sGuBprkmnIm7vI7phiXWY9bYtR/LCO/4Tj904cjiAxlSPof3nM704pcFyi+mdURIQu/0qLj/cigo0HcjKT6EsJenIEgChu0+yWT22ZO5EJWs76lVrl6eMQKC3ZwzfMcRDggsfsAH+s7tR0YPJrqLghWb16q8+aSXga6854nM0tEXEQasqSsgF8Z7RbZOL09SYysTGakNVZ2wDBxf6qD1WkP8AoHLnG9eh1AMz1Dbi4WnDWqCyjbPwb6wZpQuVMYwb6K9Xx6V3YYEPw240dNxCcSEmyoDq7AYqLKOp6s7oRPaWvhehDoS1SYcZ9pkypG2pqSM86q2KTNZypIwpmW8Ti1cecYwAQCnxcJLT1bKngD7/4QoCYvtkCwcg0d7s8URUPJgHzMO9oWOVRcgyEYoRAl30S/g0LPbwL1uf4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTBwZ213NXV2V1hZd1lZS3oxelROaWxHa0wzNnVyV1dFMStFbjJYS0hraGFW?=
 =?utf-8?B?eGJ2WFN4aTdIWmRDTlpJeEh1Z1h0VUExVVVIRWh2OXhPQUpBSHhqZjZhOGcv?=
 =?utf-8?B?ZGkyWWM4NkhpQm1VdjhHQlJqd3NuS25jMFQzTXJMbWlaZHR6U2tTWlI0d2s0?=
 =?utf-8?B?V3dqUi9udDE4QXA4aUh1MzNPeGJvcHBrTE9JWlp4M1AyUitWMURtL2lqUWtz?=
 =?utf-8?B?T09OeGt4QWhlT0hJSUw2dGs2NDlobXNHY3oySWxlTmlBSm1PZzVmZEZQYnFi?=
 =?utf-8?B?SG1Hdk5WNzFkaWlUT3BjV29qYjQyc1c3K3JocXJJR0E4ejRrVFRsa2FRVyt3?=
 =?utf-8?B?S1BKSmhJTzNtV3U2SjFNdm43anppZm1BZFZTREZBb1YyZmlQSXk3RFFzbDBX?=
 =?utf-8?B?bWY2WHRTb3BTQ0VCVzNyMDJGVVdac2RJOEd0U09mTXJxek5meFNubG1XaG9E?=
 =?utf-8?B?MzNkenh0RWpNQ3FRZXNrOWNkM2dSVTh1c0VmeUFnTU9rdW14NzZYSnhKaUsy?=
 =?utf-8?B?UHptamhxLzczYkEzZkhvcmdBUHlTTUtObFN2RkQ4NTFyNnNxc0RmamFqbzVY?=
 =?utf-8?B?cWhqUnJLYVloZ243UklheW5lbTZWZUxKa3d3VWpXRFFoNXNWOGJYNitRSHhx?=
 =?utf-8?B?SnhpU0o5YjZZeWJsc1lNM1EzV0VSRS9xbUJwY2p0em9FZ3krMTlINGRJWS9k?=
 =?utf-8?B?KytRSllidkJTMzBieUFvZWo5N3NLcjF6bWxhWllPNkhEMU1xK0RsUXJKdkNZ?=
 =?utf-8?B?NVJiQmdIdkVUT3B0aXBTcEVoRWp2SEdmOXViam1UVG1lL0RrOWtOU1VSa1lv?=
 =?utf-8?B?Z3lxUkY5TGhpNzVVU3poczEwcHIxS1hEYktyd0xiV2p4amxZdmkzd05hUGZG?=
 =?utf-8?B?WktsVDdiWU5WMWFyS3Nqbi92cDlXVDM0ZHlLeW5SVmNhbjEyd2VuMitGTHA4?=
 =?utf-8?B?c0tYaXNiSWRhYzdKSERucFpOR0VkMjc0cEMrVlB2QXlReXROTHNkem5JUUN3?=
 =?utf-8?B?WFMxYTJpWDhMdEFUcUFsUUU0ZUtocTk3S2hCcmR1S3BlRnh6ZEM5THlrbXQ5?=
 =?utf-8?B?TUlhMU5ZQ2cyOFRVZi9Gc1BTek9qYWYvN3Z2ZDRUM3NybTJMR0lxWTlyTnVX?=
 =?utf-8?B?L1k3ZmlzMUlCK3BLVFBJak1YRWFKWHBPbUw0Q0dPS08zaTBBdmZQQXVDSWVQ?=
 =?utf-8?B?a2FyZzc0WHdiMDFwL2w3VFE5VG83NDkrZzc1a2VTa0M4UGhUd2IzQ1p3dmpm?=
 =?utf-8?B?S2JwMW9BT2VJVnh4RlI4eC82OXJzVUp2bGxsUmRRUkNHTndlNC80YlZNcXpZ?=
 =?utf-8?B?dTZSU0RKdmEzbkVsNWNmWDcxMm5IWU9UR1dMMmliRDRqM3R5MW80Y0haSXh5?=
 =?utf-8?B?TUFkRTBVajhZY0ZzNFAxVEFabnFXL2VTWWJ2R1QrZk51a3NPUFVYVHFaaXdu?=
 =?utf-8?B?RUJZWGRyWWdjeTNycDV3MWlKK25JMjlrcHdQek1hWEVFNzJrWXpzZ2JKekJ1?=
 =?utf-8?B?UVpXZVpCS2tOUXA0T00wQytFVGFZRzJHZ09XMGZRRGxCeFRZOW1wdGV5NUFG?=
 =?utf-8?B?cXZMREUvV3hzRWpjcjBSWlI0emQwZ1ZlajFEeXhhZWpnRkZRS0FpSTI4b29M?=
 =?utf-8?B?UW44TlVoSm5PQ1RwNFEvSzNzZS94cURadUZ4bUkxMEZwaTZRWklCQkJyeWZ1?=
 =?utf-8?B?RFJrWkx1T2FPV2FjclZJYlFwQUFJazd6eHhmR2RySk1iVjB2dng1OUQwZmlW?=
 =?utf-8?B?MlFsdWpyRjlmWjhmRUdTcXZubzJ4djAwQzJXUjdnUzFTOHJXZUdFYzJ2Zk1N?=
 =?utf-8?B?Vm4ybHJaYmM0UWlwVXhLMCtla0RsTTkwMVZCUEU4VzhNVDEwSlRIQTVpSzJl?=
 =?utf-8?B?bk9TRktSSDMrTEFHbUJiVUEweXZ0TXY4eXdtalNxeWg4N3BmU3lxcFYyMkZJ?=
 =?utf-8?B?a2lEdVpKbG8rWmxjbFdRQzVwayttRG1iMzlPcHlLU3pHVmQzRWNnbXBHdFZM?=
 =?utf-8?B?Nkp3OStxb1pqUEFTd2ZidkhnWVBWclE5YkZXQ25HWTJSR2dscWRUMHFveWxl?=
 =?utf-8?B?bGpxUGhQWDhCV1Evdng2Z2dEZFBRYWZPaUZWbzExbkZjMWhmTGJHSmJJWWZw?=
 =?utf-8?B?anhKc25nbThOT0JUWjV0OWFNQWdycUQ0YXR0NkNxQndmQ2NhOGZXSE1MYjRU?=
 =?utf-8?B?STEwZWRGdzNjazFXVktFMnV6Y04vRmNlSmhEMkQ2TU5NSmdvaWk2ZkQ3ejJo?=
 =?utf-8?B?bFZzYkZnZjN1WWdWVWJ0L0pKeFNWVlVhdkdUV3N4SFcrQUpuazZqa3Fwc1Nz?=
 =?utf-8?B?M0pxSzNQNnJDTUZXYWRENDQ0WmRMRWQwTjRSUytlVE9RaDNRZisyRkpPZlBi?=
 =?utf-8?Q?VDitwnTBTG93MGdg=3D?=
Content-ID: <8B33ED552E432647A8950ACD7D994E33@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: V1jMiGvDhzIX1SSIds0bV1wkSDcCCEmwA0YXoWyNGbp7JPNBVTR9KU9vohw3+PwHAHRmGMXmxnUq7VTr6JU9eHPybSPInLuSu8zAEiILIUhWj8ffLgld+UGccLLwiLLbndGp9ODduhQr/N06HvT26/vGBFjqzQRQPqOU5Ewb2vcB8WozPblKhHPwG/wWadi5hNaDdc56vpafo0AbdNvecwJUBkwnLZoI11OosFMntTD22fHGLTp0znSLXDbMbFYNej/+Qjao3yOpcCAbPbnfcFzrp01dIAmtkgg82C3k/tkW0v574uNg/LMqB8xlPB4ULpaY4ITCt1rn3gwNYqCYyQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6e2c52-a086-4942-8e30-08df0cba9a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 08:32:49.8265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n8T7CvFfPje7QEVonZnklb2BNfdUCXD+Sadt0Z63SFsgOq8jXalyMPy7EtttzMpbU9sRmYd3hgQeXxxdxUaXOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6170
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: Check minimal supported kernel version
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

V8KgZG5pdSBwacSFLCAwNC4wOS4yMDI2IG/CoGdvZHppbmllIDEx4oi2MjDigIkrMDIwMCwgdcW8
eXRrb3duaWsgQ3lyaWwgSHJ1YmlzDQpuYXBpc2HFgjoNCj4gSGkhDQo+ID4gTFRQIGRvZXMgbm90
IHN1cHBvcnQga2VybmVscyBvbGRlciB0aGFuIDQuNCwgYnV0IHRoaXMgcmVxdWlyZW1lbnQNCj4g
PiB3YXMNCj4gPiBvbmx5IGRvY3VtZW50ZWQgaW4gc3RhdGljIHRleHQgd2l0aG91dCBhdXRvbWF0
ZWQgcnVudGltZQ0KPiA+IHZhbGlkYXRpb24uDQo+ID4gDQo+ID4gRGVmaW5lIHRoZSBtaW5pbWFs
IHN1cHBvcnRlZCBrZXJuZWwgdmVyc2lvbiBpbiB0c3Rfa3ZlcmNtcC5oIHNvDQo+ID4gdGhhdA0K
PiA+IHRoZSBkb2N1bWVudGF0aW9uIGZldGNoZXMgaXQgZHluYW1pY2FsbHkgYW5kIHRoZSBjb3Jl
IGxpYnJhcnkNCj4gPiBhYm9ydHMNCj4gPiB1bnN1cHBvcnRlZCBrZXJuZWxzIHdpdGggVENPTkYg
ZHVyaW5nIHRlc3Qgc2V0dXAuDQo+IA0KPiBHcmVhdCBpZGVhLCBidXQgSSB3b3VsZG4ndCB0c3Rf
YnJrKCkgb24gb2xkZXIga2VybmVscywgSSB3b3VsZCBqdXN0DQo+IHByaW50IGEgbWVzc2FnZSB0
aGF0IHRoZXJlIG1heSBiZSBmYWlsdXJlcyBiZWN1YXNlIG9sZGVyIGtlcm5lbHMgYXJlDQo+IG5v
dA0KPiBzdXBwb3J0ZWQgb3IgdGVzdGVkLg0KPiANCj4gTFRQIGhhcyBiZWVuIGhpc3RvcmljYWxs
eSB1c2VkIGZvciBtYW55IGRpZmZlcmVudCBwdXJwb3NlcywgZS5nLiBmb3INCj4gdGVzdGluZyBC
U0QgY29tcGF0aWJpbGl0eSBsYXlvdXQgZm9yIHJ1bm5pbmcgTGludXggYmluYXJpZXMgYW5kIEkN
Cj4gZmVhcg0KPiB0aGF0IGhhcmQgc3RvcCBvbiBvbGRlciBrZXJuZWwgdmVyc2lvbnMgd291bGQg
YnJlYWsgdGhlc2UgdXNlY2FzZXMuDQo+IA0KPiAtLSANCj4gQ3lyaWwgSHJ1YmlzDQo+IGNocnVi
aXNAc3VzZS5jeg0KSGksDQoNCnNwZWFraW5nIHdpdGggbXkgcGt1YmFqQEZyZWVCU0Qub3JnIGhh
dCBvbiwgc2VlDQpodHRwczovL2NnaXQuZnJlZWJzZC5vcmcvc3JjL3RyZWUvc3lzL2NvbXBhdC9s
aW51eC9saW51eF9taWIuaA0KDQpUaGUgY3VycmVudCBjbGFpbWVkIGNvbXBhdGliaWxpdHkgbGV2
ZWwgaXMgTGludXggNS4xNS4wLiBFdmVuIGlmIHlvdQ0KbG9vayBhdA0KaHR0cHM6Ly9jZ2l0LmZy
ZWVic2Qub3JnL3NyYy90cmVlL3N5cy9jb21wYXQvbGludXgvbGludXhfbWliLmg/aD1yZWxlbmcl
MkYxNC40DQood2hpY2ggaXMgdGhlIG9sZGVzdCBzdGlsbC1zdXBwb3J0ZWQgdmVyc2lvbiksIGl0
J3MgYWxzbyA1LjE1LjAuDQoNCkkgdGhpbmsgTmV0QlNEIGFsc28gaGFzIGEgTGludXggY29tcGF0
aWJpbGl0eSBsYXllciwgYnV0IEknbSBub3Qgc3VyZQ0KaG93IHVwLXRvLWRhdGUgaXQgaXMuDQot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KSW50ZWwgVGVjaG5vbG9neSBQb2xhbmQgc3AuIHogby5vLgp1bC4gU2xvd2Fj
a2llZ28gMTczIHwgODAtMjk4IEdkYW5zayB8IFNhZCBSZWpvbm93eSBHZGFuc2sgUG9sbm9jIHwg
VklJIFd5ZHppYWwgR29zcG9kYXJjenkgS3Jham93ZWdvIFJlamVzdHJ1IFNhZG93ZWdvIC0gS1JT
IDEwMTg4MiB8IE5JUCA5NTctMDctNTItMzE2IHwgS2FwaXRhbCB6YWtsYWRvd3kgMjAwLjAwMCBQ
TE4uClNwb2xrYSBvc3dpYWRjemEsIHplIHBvc2lhZGEgc3RhdHVzIGR1emVnbyBwcnplZHNpZWJp
b3JjeSB3IHJvenVtaWVuaXUgdXN0YXd5IHogZG5pYSA4IG1hcmNhIDIwMTMgci4gbyBwcnplY2l3
ZHppYWxhbml1IG5hZG1pZXJueW0gb3Bvem5pZW5pb20gdyB0cmFuc2FrY2phY2ggaGFuZGxvd3lj
aC4KClRhIHdpYWRvbW9zYyB3cmF6IHogemFsYWN6bmlrYW1pIGplc3QgcHJ6ZXpuYWN6b25hIGRs
YSBva3Jlc2xvbmVnbyBhZHJlc2F0YSBpIG1vemUgemF3aWVyYWMgaW5mb3JtYWNqZSBwb3VmbmUu
IFcgcmF6aWUgcHJ6eXBhZGtvd2VnbyBvdHJ6eW1hbmlhIHRlaiB3aWFkb21vc2NpLCBwcm9zaW15
IG8gcG93aWFkb21pZW5pZSBuYWRhd2N5IG9yYXogdHJ3YWxlIGplaiB1c3VuaWVjaWU7IGpha2ll
a29sd2llayBwcnplZ2xhZGFuaWUgbHViIHJvenBvd3N6ZWNobmlhbmllIGplc3QgemFicm9uaW9u
ZS4KVGhpcyBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRp
YWwgbWF0ZXJpYWwgZm9yIHRoZSBzb2xlIHVzZSBvZiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMp
LiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2UgY29udGFjdCB0
aGUgc2VuZGVyIGFuZCBkZWxldGUgYWxsIGNvcGllczsgYW55IHJldmlldyBvciBkaXN0cmlidXRp
b24gYnkgb3RoZXJzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
