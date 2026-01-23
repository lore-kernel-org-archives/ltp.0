Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC07BD6CFA7
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 12:37:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 629EA3CB6CA
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 13:37:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20B723C3095
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 13:37:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F3A75200ADE
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 13:37:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769171849; x=1800707849;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=PtGGVRSUlpYjtxY2Rio3dSR+qwHOaQNZzrH+uEBMQzg=;
 b=iTCBn/KOk9TBGADvDYq6377/6H855D6fcQPdmrjM+pGCs9TXtDX4WHQ8
 KVFudkHsCJxoyAvUtFazE6iTS++xIliAH/FLZ6m2y4pRhwefkGNYbrZYw
 b21cKhPSx5YBEZ3knmHYMLw0JXU7jXzinbgzLYtiwMIiW9xunnSSfG+3N
 mH0mwF0IT/xw0EPW/CMkUtvqchMr9P9Vzm+gyJBNYmlhy6FfIs66yFLU5
 bPhu2Q5wXyv3qGXM2KNJ0VcO0jUOPo3+6E9MukNFO4jGMMSmVO9D1t8g0
 8mVhNQb8siM1I96Qj6z2wCmQj7h/TSoElQrHrTm6Pz98bRRdBVfoRkB7V g==;
X-CSE-ConnectionGUID: An4p7cfNSlKzhiX2NKrouw==
X-CSE-MsgGUID: S51e4Q4wQY6RrEMLODGTpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="57995581"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="57995581"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 04:37:26 -0800
X-CSE-ConnectionGUID: 4qMxKzCJTHObszrru1d/Sw==
X-CSE-MsgGUID: iUakkX1VSvOSdFhbR5WDeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="238271838"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 04:37:26 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 04:37:25 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 23 Jan 2026 04:37:25 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 04:37:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKQ2q1DSnaGQTcn3DkefXtRMHzTQ+2YBwTppP34gwhPA6EV/jdw/akWV7Xg9+PaykjdPukShj2tIf8BJqclZ6TEzlkUVpO5eo6pK5lduF+MTcZICclELgWA7LL1boaaS20ffAiB/sNuuke104mY/g0uWtRzbjnXSYlUMIo1o43jCdmzKgjF1zuCIaoRUSU3V+PCHh0X0F/sLMD5VeaNwL694C0b6GjREOSS4rRqhtKftlZuQU74PxTkfZcFrXget2KYGdpqahljV5Xk0II799TZfsiDhpLpaWxaOzt5pdBju0SIrE5YzU1oYjtIfTTF00e9u0VO0sg/Z7UeQ3uT40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40ybChjLtSOL9kZyxEe+Q1ZNWxhD8AL+NuD0/QPD1hA=;
 b=OzrhQiW2dCduLc52QmYg943FLEKfEh8OrJtk/VP/JlFDEUTGFipIQaWHi3gT5AcAj2jzhiBhLLJgC04x2Ihyyt67VA3+C6rnYEksY4Ynl2qkar6nk27IDsHmNSnLFZ9Ido0en+2tqucHO2vRqpWe29KCG/Y7iSimtIdVDKtO4pdold2kQM7HvarA47UpqFKY0iuzVm1VAeKLQSV23FcBVFj8ep6xdtmjzzYVtswYxE4H3fuEODs0ZZOpDoPEEmh95W3HRn6mJDfzxjFq+n2oAsarTnpaV+q1EpCk8BvdzLTT00/c8aNcb7nQIFQBzbfhY7wpZBppyGcViKY04aPXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by SA3PR11MB7583.namprd11.prod.outlook.com (2603:10b6:806:306::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 12:37:21 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%3]) with mapi id 15.20.9542.009; Fri, 23 Jan 2026
 12:37:21 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "pvorel@suse.cz" <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v2] thermal: add new test group
Thread-Index: AQHcihu5xVeWrzQAwUOKqrpjpDCQ/LVbdJeAgAEQ2gCAAbyvgIABc6+A
Date: Fri, 23 Jan 2026 12:37:21 +0000
Message-ID: <4366caa2f3055b446e421278d314265c1c3b32ad.camel@intel.com>
References: <20260120144626.231614-2-piotr.kubaj@intel.com>
 <20260120193851.GB65442@pevik>
 <4dd67d8bf040715bf5a6456bb4270f08dba3986b.camel@intel.com>
 <20260122142701.GA78350@pevik>
In-Reply-To: <20260122142701.GA78350@pevik>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|SA3PR11MB7583:EE_
x-ms-office365-filtering-correlation-id: ad6a2f2e-b58d-425e-a9fb-08de5a7c2716
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TWNzQ3hOcXBlRTJPNG9YalBwY0ZJVEl6WllyaUhDL2hLY2JST2x0OGo3QXhm?=
 =?utf-8?B?VGxHbXR4RUZtUlU4Qi9NWlJVYTR5cFc5aVYrOE93cjlLdng0S1M3eEhvbmdo?=
 =?utf-8?B?elFrbW9lTkFYbzhaWitvWnNKT1Jtdi82SWNrZ2VOb01QQXRGRSs3QkJJTFRs?=
 =?utf-8?B?cFNOdE1nSXlOY3lmK1A4d0MwK2FxN2NXd2FXVElHcVdlSHRHMXVWNTkwNlY4?=
 =?utf-8?B?cElhWk11bmJ6bUw0WXFlSXRwVHFaOUoxaXRkNTR5dnZJcmFWcU03dWpkYkZC?=
 =?utf-8?B?TUNPa2ZsbWpNSkFVY2VkdmJwek9JK1ZpM1NiNVcvdEViUGQybVhGWFpjUkVN?=
 =?utf-8?B?MGk5NFpRT3JnVnEwQjdmamhwR1JYVktpT3YydTBoOVpOQXdoN0Y5Y0QrdURq?=
 =?utf-8?B?NnNFeWZkL0hvaUFnRmpYK0xLc2M4N1l2YUdQQkp0L3NNc1o1dlZKQUs1Yk9J?=
 =?utf-8?B?UGszdDZ2Nlpyc1R1MkNXVnNHS2tPUHJhbkFMOFVaSC9kRWpYZ1Y1eTArNnV5?=
 =?utf-8?B?SFNLbmFBTmwwcXpuMnVWQ1Y2K25ucnlDeitlNEt6RURzQmNnaXF0UjBRdGI3?=
 =?utf-8?B?VUFSdjBZb0NDY2RyaEZTYytFNG9rcjBtWC90RlpROUhwdG95a1FlaHZGSElD?=
 =?utf-8?B?MmdramJxVWJZSWwxMGxLUTljZkpUVndlcDcvSFFWc0drRy9mYU1jRlp5OGFK?=
 =?utf-8?B?L2NOcFN6ZmY4N080eWRtUC9sUFZZcFNHSjVtdkhlbzMvaFQ3TWVtUnA4bnlP?=
 =?utf-8?B?MU5TZjZjd1MyQnVrNzVLR3lwWmsya1JIR0tIaW9DVEdBOHJ1T2dXTXFKMzRy?=
 =?utf-8?B?ZHhzVU9OZk1wUG1ObFk2M2VRNVg1MjJIYVE2S0xIbElBWEV3M3dxT3pCUEg0?=
 =?utf-8?B?VmwxRTIwNGl4TUx3RzV4QkJ3YUUvS3BnejdTREU5V0hyT0Z4VUpjU3psM1Rx?=
 =?utf-8?B?dWxWZHdxWWV3QVRodkpYaUdNNE5iZ0NpbEVWMVlHSFdZSkZJVmlSekpSWW5K?=
 =?utf-8?B?V3l6N0g5S0RIbW5nUndZVlJpUHVzMXY0a3BjVThpditiQ1FDT0F0NVgyNnBq?=
 =?utf-8?B?b3htWU1CM3Zja1FGK1ZYKzVOc2V1TzlFa3g2ajJxMW1iczZ1K1djYlJxSk1O?=
 =?utf-8?B?VGhQdW9mYzBTbFJDQ0NHcVQxM0Q3V29tMlZZd0pmL1NhSkttMHhlYmhMdlRq?=
 =?utf-8?B?UmEvZTdVQ3YwOEZyc3h6bFlyZko4QS9qRTdTY3kwQXpoWDJpekVmVzFTT2do?=
 =?utf-8?B?QkhHdXZ3dFJLLzRINkhCM0dUb0tvTWRmakR3dlVVSHNiRitrb3lDTnhCWm5a?=
 =?utf-8?B?WVFGczNzbXlkTVo0ZEJPUld2NElvWXJOSTJRTFJMMVJTMC9WV3ZlNFpzS3cr?=
 =?utf-8?B?Q1I4QjB4K2dKc3ZWbkVLWFNIS2JRMzZmVURNREh1WVhkTlFUSlJray9DOGZF?=
 =?utf-8?B?NHByekhDN3VWSTRrVnhzRVVCa1Z0L3NURWFSSGNYM3FPU3pXWHpQamwrc2tt?=
 =?utf-8?B?MDNKTG02Ly9JLzdqd283U1dxbFVPU3oySlFQdXMza04vYk0vYUxsQTRGSnJn?=
 =?utf-8?B?Zm9wZlZzV3ZvVlBweXdXazZJNEJScTdmRUlVVGF5WUVaWXBoWHlaNTQrSEVj?=
 =?utf-8?B?a1FiYzJieEl6UGxMMW16djRCd3VQYXpkZEpyOVF1VHB4VTZpZ1lxcnc1bGQx?=
 =?utf-8?B?c1g4RHRESGdmdjMvZnpPck9rRmxsZFc0eTZhWkRJd2ticzZmK2pCdTJMZXpM?=
 =?utf-8?B?N2JPVGUrM010ZlVaYktqQ1BWUXliekVLNEVpMmp1ZVRnMFN4Rk5HeG4wMXI1?=
 =?utf-8?B?cE5aR3haUk1DaFdlT1BMeXZjcUw4bVlaTUl5NzlqdzJQbGRVZVhzY1FlT091?=
 =?utf-8?B?NFlOcUpWUFM4ZFIxeDRwYkROa0JJVW5BTDR5L25jK3NQTXVkdmF1SS9vN2Fl?=
 =?utf-8?B?S3ZHQ0ZuV1NDSkRzMjh0RVpKcXVBTEtDK1VBREhiTnVIYVIvZW9nOVh6a1dx?=
 =?utf-8?B?SjBhelBIWWJsWHlMM05JZFpOamozRy8zeGVSenFmWUhnSG9rNUVXRW9Rd21i?=
 =?utf-8?B?SEkxMTZOd2lkcHpYaHM1TThjS2VIdXpQazB6eGtQVWpOMVdMVnRTbDZOVTVz?=
 =?utf-8?B?a3dRQngrMlg1NVBQRzB5NmVydGJQbDYzK2RuamRONEl1c1JxWU1ReVpKbEdN?=
 =?utf-8?Q?hLC5mJWiFPqtugn/7L5lolg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0RNcHNLaDUxdENZcEttM0JwU2hGQnJRaVlJb25RbGpMdzkvY3l4MTNHNTdn?=
 =?utf-8?B?YlFXOXhva2hKb2RMaUdpUC9uU2FjaG5veUdxcFNWWkZ1N2F1My9OTkswNXRO?=
 =?utf-8?B?bGFNNUNPY0d2T1dWc3F6NXVzVkxUZHk1WVRHa0ZFaHltREw3bUJDMWU0SWkv?=
 =?utf-8?B?V2RBcys1ZDFKcmlCUTE3aGRVbS9hbWxxVCtGOHUwdW56Vnh3ZERtQzI1enpz?=
 =?utf-8?B?RGdDVDFjZU1zc3JnVHV2T2pTS1dERmtIK1Z3bGp2ZFBDcCtMVWtRY1JaRkNQ?=
 =?utf-8?B?UFI0VXQ5bnAvUTBqaTFYei9WbnhRelU1c2ZSU3QyeUdNdVF2b3RKZWtBZmRD?=
 =?utf-8?B?K1BiOXY2VFkyZkVMVlFtakZoLzVuV3p4emc1WEpkdk9DUHB5dm5WMDRHVjlV?=
 =?utf-8?B?Z0ZQci9ZUFRBUWpIS004d2tHQ0pyQlAyYnYzakVISksyWlZ0aXdJcitsTXFN?=
 =?utf-8?B?WXR6RVQ0YjY0YWVDRFUyUk80bEx0UUlTbGM5Wm41WmI5c1JONWppMC9TbHpS?=
 =?utf-8?B?aFBjM290YmhsSHZDR0JrOVJka0VCVnZjbVo5eFJKYk4wNjkzM0JaOFhXYW5W?=
 =?utf-8?B?UzR5TDZwS2tiMUZlRyszUnk5akgzeHQ5cm5CZ2VKWWNENlhhQ2gwakRBRnY3?=
 =?utf-8?B?dUVZczErNHdCbEc3a21qYS85SC84YnRKejFDZnpvVm5hM2RKRER2WjU1UGNF?=
 =?utf-8?B?UVdmTWdLQktNOUt2dGorSHVCbVNaM2x4SHBVY3lyandDQzJmYmc2V3Z1TVoz?=
 =?utf-8?B?RjE5V2xtUzVwSldzUmRNRmJ2OW5kSks3WWV6NU9kK005K1RzQnljWm1aeVN6?=
 =?utf-8?B?UGxtY095RXBLNDRyN2Z2UWtaN1M1REJqSE1sZ3NLVjJZRzRjMG9PbEFWQ2ZN?=
 =?utf-8?B?UzRJeWdYK2pJdmJkWUdlTWIyL1BUdmNOanM4bUtHbytWdFExTDRCbW5UVUFr?=
 =?utf-8?B?dG9jcGJkWVhwOGQxUnpkVGptTGtHTGozRVdxay9hM0kxdklHbUJlcXBMcG5Y?=
 =?utf-8?B?UnFuMDZuSHhUNEdLUmJJUkppTmlJUUVmQnV1ek1oVmlyUFRYUHpIL1VNODFz?=
 =?utf-8?B?bjRwSHJsa3BMUHRkcUdNUDlOUU9jV1hDSFk2M2NVeWwxaXZTa1pYV1IyNXJX?=
 =?utf-8?B?dVNLaE1vSmxaNU5LUEVDYnN0ZmFZUjhIbmtkaVZWYjJCNGFpK1NVcU9xdGcx?=
 =?utf-8?B?aThBYmZrbExQc0lLMFBXNkJ6TXVaYjRwdFlKRlhrOU9hNzhLdHg5L05HWUtk?=
 =?utf-8?B?L1dkdTBrNXVzTkx2RFZYbmZLZHlsdGljdG5lYytFVjFkbnNiaHgxYWJiR1RQ?=
 =?utf-8?B?WlVLVmExM0NXMnZ4Qk4rL1N0ZDF6T1Y0YmJkSTNqbmNQaGhzN1ZOc1BPeFhq?=
 =?utf-8?B?NjBRV1pUNWtqLzVtcEVvVFg3cUpWcU9Zc05uTlpuYVRneWh4WWlHcXZCUi9V?=
 =?utf-8?B?RnJJd010UnhFYm1SUUR1Ty93ZnNEb05xbXdldjlycUxsR0s5bi9mTWRHRXNW?=
 =?utf-8?B?a3FQQUdESitnQy90bnNlTnB1WmtLQU1pZ0FKZ3Rtd1Urdk5vVytXbEl2UFBK?=
 =?utf-8?B?MHdMTnVjZmIxUGRMbmRNM3FCUks5anVRa01QVTVOeTUzamxQRUl6c3NQTkgz?=
 =?utf-8?B?d0xwekpwaTh1Mkw1eWx5R1FIYjFPMWd5U21UWmpWaVRFdE5IMmc2MnBKSHA4?=
 =?utf-8?B?b3dVRTNPbWR0YmlmY2hDS21DQjQwdG9tWmo3QUtwa01JbldnT1lQS0U5cFMx?=
 =?utf-8?B?M05nR25sdVdoanpIV0FFNGx3U2xTVkRSMDdCUEFDSWxqKzBYb1IrbVJBQkpR?=
 =?utf-8?B?NEJoVzRCZWFCcHkvZ2x6QTFnOUdLdEVkV2liMXFpZTUxczA5SmlxZ0xtbW1k?=
 =?utf-8?B?WjRJSVN4c0Znd2ZoczBCck5RVFhhK3VXbWNxZ2czc3NJblViUk90QjQ4QnVk?=
 =?utf-8?B?TEVManV6eWpmVUVQYkJRaTlEOS9QU2pBVzkwOTF2SnlOTm80UEtHVVdkSEN3?=
 =?utf-8?B?VHplS1Zpb2dDcThnTm5RV2ZySHpQMzJ5Yzk3a1dqYjZjWk9LcXpVTGZGc1BE?=
 =?utf-8?B?akg4UjQyKy9pN0d4c0cwYUlYOWVXVERQM1lEM0RMdVZXaUxwZWZhOXJLenRw?=
 =?utf-8?B?dVVsb2xXVFcwYlJMYUtmaGFaK2p1em5JU1RuMzJhVUx6cnJpdU9peVZnMGQv?=
 =?utf-8?B?UmdDNUtub1BBNnVqRG14a2xESHEwVHZTLzZLcHNWVU9LL2NWb3I0T2t2KzQv?=
 =?utf-8?B?VGduVnU1R2NtTkZQQS9xc0ZGSWcxVHVZeGNIa012OXlIdU9kRUpUOXJDTnAy?=
 =?utf-8?B?Q2J4RlZJWUN4RHRCZ3NjdU5yZ0U4NlZYSTFpaWl6R0VueWhEN05LMnkxWTFE?=
 =?utf-8?Q?qWZUWMF7E6zhuX1I=3D?=
Content-ID: <0D8576B43338DC4FA44FEEDC80F86086@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6a2f2e-b58d-425e-a9fb-08de5a7c2716
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 12:37:21.0813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNrc16KkW5r29KYatrkR3R7dJNEF9NEaXosUl7i6tgkwyXYLowDo7Gonl7OR9IS8/WNcvuhW1jnM/y5PySgcXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7583
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] thermal: add new test group
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

MjAyNi0wMS0yMiAo5pyoKSDjga4gMTU6MjcgKzAxMDAg44GrIFBldHIgVm9yZWwg44GV44KT44Gv
5pu444GN44G+44GX44GfOg0KPiBIaSBQaW90ciwNCj4gLi4uDQo+ID4gPiA+ICsJYm9vbCBpbnRl
cnJ1cHRzX2ZvdW5kID0gMDsNCj4gPiA+ID4gKwljaGFyIGxpbmVbODE5Ml07DQo+ID4gPiB2ZXJ5
IG5pdDogSU1ITyAxMDI0IHdvdWxkIGJlIG1vcmUgdGhhbiBlbm91Z2gsIGJ1dCB3aGF0ZXZlci4N
Cj4gPiBBbmQgSSB3YXNuJ3QgZXZlbiBzdXJlIDgxOTIgd291bGQgYmUgZW5vdWdoLiBUaGUgcmVh
c29uIGlzIHRoYXQsDQo+ID4gc2luY2UNCj4gPiBpdCdzIGEgc3RyaW5nLCBldmVyeSBkaWdpdCBp
cyBhIHNpbmdsZSBhcnJheSBlbGVtZW50LiBXaXRoIG5ldyAyUw0KPiA+IG9yIDRTDQo+ID4gc3lz
dGVtcyB3aXRoIGh1bmRyZWRzIG9mIGNvcmVzIGFuZCBlYWNoIGludGVycnVwdCBiZWluZyB1cCB0
byAyXjY0LA0KPiA+IGV2ZW4gODE5MiBtaWdodCBub3QgYmUgZW5vdWdoLg0KPiANCj4gT0suDQo+
IA0KPiA+ID4gPiArDQo+ID4gPiA+ICsJbWVtc2V0KGludGVycnVwdF9hcnJheSwgMCwgbnByb2Mg
Kg0KPiA+ID4gPiBzaXplb2YoKmludGVycnVwdF9hcnJheSkpOw0KPiA+ID4gPiArCUZJTEUgKmZw
ID0gU0FGRV9GT1BFTigiL3Byb2MvaW50ZXJydXB0cyIsICJyIik7DQo+ID4gPiA+ICsNCj4gPiA+
ID4gKwl3aGlsZSAoZmdldHMobGluZSwgc2l6ZW9mKGxpbmUpLCBmcCkpIHsNCj4gPiA+ID4gKwkJ
aWYgKHN0cnN0cihsaW5lLCAiVGhlcm1hbCBldmVudCBpbnRlcnJ1cHRzIikpDQo+ID4gPiA+IHsN
Cj4gPiA+IENhbid0IHdlIHVzZSBGSUxFX0xJTkVTX1NDQU5GKCkgb3IgU0FGRV9GSUxFX0xJTkVT
X1NDQU5GKCkgdG8NCj4gPiA+IGluc3RlYWQNCj4gPiA+IG9mIHdob2xlDQo+ID4gPiB3aGlsZSgp
IGJsb2NrIHRvIHNpbXBsaWZ5Pw0KPiANCj4gPiA+IFNlZSBleGFtcGxlIGNvZGUNCj4gPiA+IGh0
dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL3RyZWUvbWFzdGVyL2xpYi9u
ZXdsaWJfdGVzdHMvdHN0X3NhZmVfZmlsZW9wcy5jDQo+ID4gSXQncyBxdWl0ZSB1bmNsZWFyIHRv
IG1lLiBTQUZFX0ZJTEVfTElORVNfU0NBTkYoKSBzZWVtcyBmaW5lIGZvcg0KPiA+IHJlYWRpbmcg
YSBzaW5nbGUgaW50ZXJydXB0IG51bWJlciBvciBldmVuIG11bHRpcGxlLCBidXQgb25seSB3aGVu
DQo+ID4gd2VsbA0KPiA+IGtub3duIGhvdyBtYW55IGNvcmVzIHdlIGhhdmUuIEhlcmUgdGhlIG51
bWJlciBvZiBlbGVtZW50cyBpbiB0aGUNCj4gPiBhcnJheQ0KPiA+IGlzIGVxdWFsIHRvIHRoZSBu
dW1iZXIgb2YgbG9naWNhbCBjb3JlcyB0aGUgc3lzdGVtIGhhcywgaW4gbXkgY2FzZQ0KPiA+IGl0
J3M6DQo+ID4gwqBUUk06wqDCoMKgwqDCoMKgIDc3OTXCoMKgwqDCoMKgwqAgNzc5NcKgwqDCoMKg
wqDCoCA3Nzk1wqDCoMKgwqDCoMKgIDc3OTXCoMKgwqDCoMKgwqAgNzgwMMKgwqDCoMKgwqDCoA0K
PiA+IDc4MDANCj4gPiA3Nzk3wqDCoMKgwqDCoMKgIDc3OTfCoMKgwqDCoMKgwqAgNzc5NcKgwqDC
oMKgwqDCoCA3Nzk1wqDCoMKgwqDCoMKgIDc4ODbCoMKgwqDCoMKgwqAgNzg4NsKgwqDCoMKgwqDC
oA0KPiA+IDc4NjANCj4gPiA3ODYwwqDCoMKgwqDCoMKgIDc4NjPCoMKgwqDCoMKgwqAgNzg2M8Kg
wqDCoMKgwqDCoCA3Nzk1wqDCoMKgwqDCoMKgIDc3OTXCoMKgwqDCoMKgwqAgNzc5NcKgwqDCoMKg
wqDCoA0KPiA+IDc3OTUNCj4gPiA3Nzk1wqDCoMKgwqDCoMKgIDc3OTXCoMKgwqDCoMKgwqAgNzc5
NcKgwqDCoMKgwqDCoCA3Nzk1wqDCoCBUaGVybWFsIGV2ZW50IGludGVycnVwdHMNCj4gDQo+ID4g
SSB0cmllZDoNCj4gPiBTQUZFX0ZJTEVfTElORVNfU0NBTkYoIi9wcm9jL2ludGVycnVwdHMiLCAi
IFRSTTolc1RoZXJtYWwgZXZlbnQNCj4gPiBpbnRlcnJ1cHRzIiwgbGluZSk7DQo+IA0KPiA+IHRv
IGZpdCBhbGwgdGhlIG51bWJlcnMgaW4gImxpbmUiIHN0cmluZyBhbmQgdGhlbiBsYXRlciBwYXJz
ZSB0aGVtLA0KPiA+IGJ1dA0KPiA+IG9ubHkgdGhlIDFzdCBudW1iZXIgaXMgcmVhZC4gSGVyZSB3
ZSBuZWVkIHRvIGhhdmUgYWxsIG9mIHRoZW0uDQo+IA0KPiBJJ20gc29ycnksIEkgd2FzIHdyb25n
IGhlcmUuIFllcywgeW91IHJpZ2h0IFNBRkVfRklMRV9MSU5FU19TQ0FORigpDQo+IHNjYW5zIHdo
b2xlDQo+IGZpbGUgYXQgb25jZS4gV2l0aCBnZW5lcmljIHBhdHRlcm4gaXQgY2FuIGN1bXVsYXRl
IHRoZSByZXN1bHRzDQo+IChvdGhlcndpc2Ugd2l0aA0KPiBzcGVjaWZpYyBlbm91Z2ggaXQgZmlu
ZHMgb25seSBzaW5nbGUgcGxhY2UpLiBBbnl3YXksIG5vdCBzdWl0YWJsZSBmb3INCj4geW91Lg0K
PiANCj4gQnV0IHlvdSBjb3VsZCBwcm9jZXNzIGVhY2ggbGluZSB3aXRoIFNBRkVfU1NDQU5GKCks
IHRoYXQgd291bGQgaGVscA0KPiB0byBhdm9pZA0KPiBzdHJ0b2soKSAoc2ltcGxpZnkgY29kZSBh
IGxvdCkuDQo+IA0KPiBLaW5kIHJlZ2FyZHMsDQo+IFBldHINCg0KDQpIaSwNCg0KSSB0cmllZDoN
ClNBRkVfU1NDQU5GKGxpbmUsICIgVFJNOiVzVGhlcm1hbCBldmVudCBpbnRlcnJ1cHRzIiwgYnVm
ZmVyKTsNCg0KQnV0IGl0J3MgdGhlIHNhbWUgYXMgYmVmb3JlLCBvbmx5IHRoZSBmaXJzdCBudW1i
ZXIgZW5kcyB1cCBpbiB0aGUNCmJ1ZmZlci4gU3RpbGwsIGV2ZW4gaWYgSSBtYW5hZ2VkIHRvIHB1
dCB0aGVtIGFsbCBpbnRvIGJ1ZmZlciwgSSB3b3VsZA0Kc3RpbGwgbmVlZCB0byBsYXRlciBkaXZp
ZGUgdGhlbSBpbnRvIGluZGl2aWR1YWwgZWxlbWVudHMgb2YNCmludGVycnVwdF9hcnJheSBhbmQg
c3RydG9rIHNlZW1zIGZpdCBmb3IgdGhhdC4NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpJbnRlbCBUZWNobm9sb2d5
IFBvbGFuZCBzcC4geiBvLm8uCnVsLiBTbG93YWNraWVnbyAxNzMgfCA4MC0yOTggR2RhbnNrIHwg
U2FkIFJlam9ub3d5IEdkYW5zayBQb2xub2MgfCBWSUkgV3lkemlhbCBHb3Nwb2RhcmN6eSBLcmFq
b3dlZ28gUmVqZXN0cnUgU2Fkb3dlZ28gLSBLUlMgMTAxODgyIHwgTklQIDk1Ny0wNy01Mi0zMTYg
fCBLYXBpdGFsIHpha2xhZG93eSAyMDAuMDAwIFBMTi4KU3BvbGthIG9zd2lhZGN6YSwgemUgcG9z
aWFkYSBzdGF0dXMgZHV6ZWdvIHByemVkc2llYmlvcmN5IHcgcm96dW1pZW5pdSB1c3Rhd3kgeiBk
bmlhIDggbWFyY2EgMjAxMyByLiBvIHByemVjaXdkemlhbGFuaXUgbmFkbWllcm55bSBvcG96bmll
bmlvbSB3IHRyYW5zYWtjamFjaCBoYW5kbG93eWNoLgoKVGEgd2lhZG9tb3NjIHdyYXogeiB6YWxh
Y3puaWthbWkgamVzdCBwcnplem5hY3pvbmEgZGxhIG9rcmVzbG9uZWdvIGFkcmVzYXRhIGkgbW96
ZSB6YXdpZXJhYyBpbmZvcm1hY2plIHBvdWZuZS4gVyByYXppZSBwcnp5cGFka293ZWdvIG90cnp5
bWFuaWEgdGVqIHdpYWRvbW9zY2ksIHByb3NpbXkgbyBwb3dpYWRvbWllbmllIG5hZGF3Y3kgb3Jh
eiB0cndhbGUgamVqIHVzdW5pZWNpZTsgamFraWVrb2x3aWVrIHByemVnbGFkYW5pZSBsdWIgcm96
cG93c3plY2huaWFuaWUgamVzdCB6YWJyb25pb25lLgpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFj
aG1lbnRzIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBtYXRlcmlhbCBmb3IgdGhlIHNvbGUgdXNl
IG9mIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRl
ZCByZWNpcGllbnQsIHBsZWFzZSBjb250YWN0IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSBhbGwgY29w
aWVzOyBhbnkgcmV2aWV3IG9yIGRpc3RyaWJ1dGlvbiBieSBvdGhlcnMgaXMgc3RyaWN0bHkgcHJv
aGliaXRlZC4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
