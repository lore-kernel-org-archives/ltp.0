Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731CA103A9A7
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 10:55:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E7723E2AD5
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 11:55:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6AA183E2AD0
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 11:55:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D955260208B
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 11:55:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774436127; x=1805972127;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=OBhzuIPtk1cijaFBKIHxqRNPx1w8jlbxWJDBABWW4m4=;
 b=HRUvRVkTmsqvi2MR23yiC7VjwtfeqgypD51YunC2HBKDPAIlIHl83+RI
 sXZR/c48OrTwxHd9bDeS2/nW3i0ugUs6yHy7rEiNdLtHgLWrohJMWkN+U
 d3W/Xq9DY+ZFMN/xa/+/SK8vkFCU4AvMHqgC524gA69L09iClmt4/huhG
 Da3P0GwFSTQwr/KgVdxQ0Se0UBmUZkVXzuZX1Wr6ZDW/+poyPDxSJWZUd
 Z9evB5q2t0LP0DYV070BQjAvuwzXlHITFc8XWtovlCPCoFSmgj56gBj+x
 UAAAsLOfdTONQivDJvxWcRu2icXsVTePEiVdq4VjIzvO5cDrYNMziVfNs g==;
X-CSE-ConnectionGUID: j1g4KlSYTF2wjkisPN4klw==
X-CSE-MsgGUID: oCHvnK1CQ8azauIrXnqPlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="93046433"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="93046433"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 03:55:24 -0700
X-CSE-ConnectionGUID: Qci7rgK3TxSFWYURTCv8xQ==
X-CSE-MsgGUID: tLPlKJMCQWiy2GMzGwYwnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="219793628"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 03:55:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 03:55:24 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 03:55:24 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 03:55:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cv9leExbqzfR1fo9up8XKAk2alhyKN1S30WF7jqN1VPm6CQZISqioT9aKGPkvT1eSPajJAynWmHJovW7B4j6y7RM8eTr69yXSOLLGDHoBa8PV5NYLqAs2eM6SfN7zxU8ap7cVjicNRbVPlvxHI1V6Ar16pLFm80CP3BxJr6khAOcOqUUgSMMp9otr2FFxk3K4Qc8lvA4IUDM3KekUplgy5BC3XONANh+wSMYYUmGTEfJ/GhAZYgc7+HeFVQLH2RPjgwJ2vv4Gk+dTpQs6KU/mhogAnSckK3PYepmdhbQ29CYi9jSDcJXshink/89tm0Lw2KZSZdEI753lpxoWc/nLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ss6DqLklcdXnFpsJ22CPRHdqohOKXJv+VsmSkuOPs4=;
 b=UiPmuYbscQtGedy2UydYcme74RGhwY7aHZKWDnIihgeSy+7q2OvM6FUt8+nrBoD+ufaL0RPxitoPgRbsrzf5MQOoK8vEeFMHfuNP74wNCD9Jbw/QcNqSBp8KZejNDF/WPyjJ3J7ytdCVXnFLU2Q+AlTgGelKK94rKNSp94pGf68kUGKwUxVl86/p52BVYuvBzy43OxuejMh14yXbg7V/WUUvNWGHnaimvrR7zveP2kIk0H5C7Rb1pKJvkeSVqbI0f4Sjhp+8XwhJE3bz/ITzmtTZkYmRJOrmVnGWO6S8HTFqRnWCgSEIUFqbeawlMD6rsgrmugHqWFNzWpQPypKgCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 10:55:14 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%3]) with mapi id 15.20.9723.013; Wed, 25 Mar 2026
 10:55:14 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "andrea.cervesato@suse.com" <andrea.cervesato@suse.com>
Thread-Topic: [LTP] [PATCH v13] thermal: add new test group
Thread-Index: AQHcus6nrhvbo3xzYEOwPLjZAqUDH7W9qDkAgAFt4IA=
Date: Wed, 25 Mar 2026 10:55:14 +0000
Message-ID: <f4b5329a6f61943a3ec260de5e51f61c5f7a4816.camel@intel.com>
References: <69c28c27.050a0220.1f29e8.ce4b@mx.google.com>
In-Reply-To: <69c28c27.050a0220.1f29e8.ce4b@mx.google.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|BL3PR11MB6529:EE_
x-ms-office365-filtering-correlation-id: 2abb92c4-8f3a-41dd-01c0-08de8a5cfe5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: bGGY2bw1Q3bki8H7r2LN0/PdGTMPWn+MDOsGDjkf3vm3L4gtlC/1JsQfhaXz8/+SD7HN/InmCvSqLuAdXEzXoaPUu8skvE4Mc21TwU97sEesGBlXD7OByazENmhi6CJYrRPRxNLBx4ZhIB1sXm0jVmDYjyDIwEe9J5zHXPi+0m4edU4B7faQ9pEmQyV/QqsFvW6Sj1KZx/8UML33to0ARi6rytTXNXKoymz4ME2kJvL2JRG/y3q+qn0lSKxsbVWt5QN4xQMVPZpILYxGMlgNLwKSDSLq8yNzo3wfvCoLqT1Ej0GoFsOpGfpSa1MZJRhUwx3oyPoOVCO9b0KgvQJgq1u4Hzw9R5cvX1xbQp7uZm8eVJ1jgVq5C6NKqlHlqORHIaM388piiZ5IurFaMEa/5CaJl7EoLNLKzbUmsPT/EeC1xVybnq+gJZ7Y3BOdu1q+HL/hNPsnF/xLw9CjtAXwxGXSWna+Q+IWhLjhwn50Yen8kFVplnY/SUcBFjPKxhtFGsj5WWXjRQJ+/XbuH3v2An7JDCz/+qJrR1lxv2jG+dcrlpkr3h3F6fQVYdJ6LDcvb2xn8zfca0rQj6/ML4mmgyobmGNh1c3iOKJqK0Mls3K8rmEaX4NWk5STDDqbIPStR2hhb4ewO9KwSPV3FH6jHISYlqL1ALU83pIB49T23okxW14K1b4AapJn2xLBzOIBGSeybeMlORn6fhPWo6gDnEhk1Da5KzPTxAV/oTfeL5HkR6LZQHL/PS7WtR6w31pnRzvTBHAncuQFF0SKE0Gghx1IjXma/Xjtxid40GmGVMk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGczZG0wbnc0VU9zTDM5QlhlUnkvQXN4MUVVU0ErcmcwbFl6N2Zwc1BURzRC?=
 =?utf-8?B?VEtUTHp0RWxZV0o1YWVHcXp3Tjk2bm4vOHVvZy9uV3JPdlZBbUp3aUh2Ylk5?=
 =?utf-8?B?ZG5ROXl6amdIRzBqZVB4K2Z5KzVGWjlDcXA0OUJwNVd1WXo4dGFLTFVkWHBu?=
 =?utf-8?B?UEhyM3RQbUlUMG5hTXZEZFQ3WHFEa01kZWwyTEw0NWYxWmdiVmlxSlpuem9X?=
 =?utf-8?B?NXNKZDA4aFhXU3VtNExmSjBWMTlRUmpIQ2tQcXdBY3ArN0J3VnpYbDdxM3VN?=
 =?utf-8?B?RC96cWd0RXoyak1RV1hSV1dQVDR0OUVNc2F4MnBLd2ZiUlVxZ0NXZHovK2I1?=
 =?utf-8?B?SnZOSHJmRFN4bjNIdU9CNjBIUEsrNVh1cHZ2UVM3cXNQc1hCUitoNVZQMWJJ?=
 =?utf-8?B?eW5qa3FVRWY1THhJbElKQmNyMFRjR0Q1VUJMVGZoQ1lYYUY3cUU2UTcrdGZM?=
 =?utf-8?B?U2ZrbC9sSzBzYmRuQjdySVIxQllrTVdGVjlWdHBjWFR1N2R2WGduaGNvOHY2?=
 =?utf-8?B?SmROS0dOWmRvbHFaemphdXVJTmQ2SjI3QnRieHBXUnFmbWdjVTM5dUxyVjNF?=
 =?utf-8?B?aDZ3Y0ppd3daRnR2ZXdJTlpYVU82SUtHZDFpcjVqVFZVb1NuOFVMV0pWcUNI?=
 =?utf-8?B?Sm16WWx5dCtyY0pFRnRScUt2VHpiRDZjeHNxenBCamtjVDdXeWliamVDUDJl?=
 =?utf-8?B?dWlLaFhvSWlnYlVjMkoydUh5Sk9DQmRiWWJxWTdZeGFSVlZXZW9aL1VlbWlR?=
 =?utf-8?B?eFRKOVFPK0swbktiUmwrb1Zmb3VqbTdhd1lkOFVGN2FiS0lvaCtVeE44NVUr?=
 =?utf-8?B?cjhzaVBJWFlwZE1GZ3NTaW8xL3FxbnZBaFcxUzZqMi9ueVRlRW1BYjZJSm1L?=
 =?utf-8?B?NGVDWFRNWUpsdFJ3bDdXekk0VElOVnl6S2VNSHlyV2tnVmMxY1pCcllsdVZl?=
 =?utf-8?B?MFpRK2dOcVJzanNpUXZWOXdUeTBFczFGSCs4eGg2L25PZTNaZExTMHJyb1hy?=
 =?utf-8?B?dmpHUWNlUEhuSTB1MWZaa1ZySGxzdWNTL1lObWJubkVuL3YzVWpSSFJmYkxG?=
 =?utf-8?B?bG5yb3kyK0NISm1CNlFhaktSeGpEOFgzcm5HL0RqRWIzUkk2a3E3eThwdUJI?=
 =?utf-8?B?N200SHlScnFiNWpmTEZtZFNuL3dsdm9MVUNkajV4U2FkVUxZamNidWMzdU9L?=
 =?utf-8?B?MmFKY29zWktaNU9TRWRzWERWYmdSNkxYbkhxSXVxdEpJV3ByS2ZmdmxKQ3BY?=
 =?utf-8?B?WFN6bGhQZ2l1VFI2eHZnSWx6a2x4bG96cEx5MG44cElnVWRHWUx0b281c2Ft?=
 =?utf-8?B?Z3JBRmVKTVFjRFl1MDRldERRQ0EzWHNuTTNZZ1JFZzUzTVM5ZnVYZ1VJRlNr?=
 =?utf-8?B?VmdpVkIydDBTb1N3Qi90Nm9PWVIzTFVCL0FHdHJVaktkR0htakpwK3VWTC9k?=
 =?utf-8?B?Njhjc3NGQU4rUmNFOE9jV1NURnhHek0yYmxhN2VtZHFsTXdVMmZ3V29CWFVp?=
 =?utf-8?B?N05BekFsMzlQMmNXOEJhYk4vcTVUVDRiQTFEU1hMV1R4NWNYQmVLQ3V1N1hn?=
 =?utf-8?B?eWlOUWVGUzJhQTd5Mml0Ym5XWFZaVW9JL3RaVERPdXNYU3hJV1BWMnNXTnhz?=
 =?utf-8?B?NnU4UHdtRGRMbktJOUl3UGhXVGhxT2tFOERLKzB4d1lzK3Ywc3BOYk41MmlP?=
 =?utf-8?B?eXI2b3RMVTJaMFRZZllEejlzUGJsUmxCMUFaemcrZzRvM2VhM3pSRis3K2M0?=
 =?utf-8?B?THV1TW0ybEVOZnFrWm9XbTVLMURCbnNESWtrODRjbi9YUG5sRy9xNTBhMC9q?=
 =?utf-8?B?R0svL093UGp0aGxMRC9IKzJoR21nMWFSdW03bEErVlQ5Uk1lTk1UNnJpaklD?=
 =?utf-8?B?Q25ZcmlRbFBkYXRDL0pxNi82SmgxUE9TM0dVWWh1RWZEc1h5VExsMnZQTnNQ?=
 =?utf-8?B?QUlXa3NXTTJwa0ZMaGF5aGRSR2pzdlFkeGpjRzd4dG9Jbkx4Yzg4Skp2WXhH?=
 =?utf-8?B?eFpIVy91T3Z0Q1FPRXNGMUpFQ3B3TXJ4QzZMelB4ZjFHekUvSmpmZ2w0NFZl?=
 =?utf-8?B?MGpwRmxFQVZSMzBwZU5CanpFY05STjFZdXphMWVrODhrOVlxc3RPdzY0c3E1?=
 =?utf-8?B?TjNaSUlqZnR1eDVRVVQzUFNXdXBzMHo0WWNzTTZWSkdyRi8zeVArMTNNZ3hW?=
 =?utf-8?B?eHVFVGdsM0t5ZEtmWFhIM3BvQ29ZanNUbi9oYUxiVG9nZzRBU2gxMWxOL0lw?=
 =?utf-8?B?azdyVFlWcFFlaFRwTUsxeDY4ZzAreE1DQmt0dGdMQ3Bpd0kxUG9nNzg1b1JG?=
 =?utf-8?B?Q0JEY1pxSlYyMGtyVjI3Um8welVjbFJ1Z0ljZXpMNjNSMnRHZWpzTm9PQmJx?=
 =?utf-8?Q?vHbUJon+ki8N07VU=3D?=
Content-ID: <16DB7FFB5C41374FB6612DEC991B0AA8@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Imm+pb0UiiVElfzn0XwTVOLhDXINuvMDLiUR6WcChD5nEEJrbLpLBHBwfkJkXiWWvemo256SZ24wOmtmS9BXvhLRDujcxS3C/9KBex4Dgex8kRvxPAIVIXtCxMCQVhC7U1a6zCCguTbN3GEl904lGvRVMwQcADPdjjRw+JjiM6BnXIpHV9TH/NarOCwvKTmtGF4K6At/6NniRW89vBSaeq4klfdm66CApaEutkGnbJuFfqa+6NmRTdxDZkqXKw1RE3mxEcpvhQ0GQQzP8Sj1Eq02npMGlCHOY2nycnAgKX2FGZ88531iTLGmzmhAITeHOVtFfY8Pbd2c1goz5eN9vA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abb92c4-8f3a-41dd-01c0-08de8a5cfe5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 10:55:14.2218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mwm3MystzIjMY3vQc0uC3CQtQgGks1pKmCDk8CW8TOCap6zrkXpV0TPL0XeDEY0caswvnajGeuosxs5nhZZPrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v13] thermal: add new test group
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

MjAyNi0wMy0yNCAo54GrKSDjga4gMTM6MDUgKzAwMDAg44GrIEFuZHJlYSBDZXJ2ZXNhdG8g44GV
44KT44Gv5pu444GN44G+44GX44GfOg0KPiBIaSBQaW90ciwNCj4gDQo+ID4gKwkJCQlwdHIgPSBl
bmRwdHI7DQo+ID4gKwkJCQl0c3RfcmVzKFRERUJVRywgImludGVycnVwdHNbJWRdOg0KPiA+ICVs
ZCIsIGksIGludGVycnVwdHNbaV0pOw0KPiANCj4gYGludGVycnVwdHNgIGlzIHVpbnQ2NF90Kiwg
c28gd2Ugc2hvdWxkIHVzZSAldWwgaW5zdGVhZC4NClRoYXQgY2F1c2VzOg0KSW4gZmlsZSBpbmNs
dWRlZCBmcm9tIHRoZXJtYWxfaW50ZXJydXB0X2V2ZW50cy5jOjE5Og0KdGhlcm1hbF9pbnRlcnJ1
cHRfZXZlbnRzLmM6IEluIGZ1bmN0aW9uIOKAmHJlYWRfaW50ZXJydXB0c+KAmToNCi4uLy4uLy4u
L2luY2x1ZGUvdHN0X3Rlc3QuaDo3NDo1NTogd2FybmluZzogZm9ybWF0IOKAmCV14oCZIGV4cGVj
dHMNCmFyZ3VtZW50IG9mIHR5cGUg4oCYdW5zaWduZWQgaW504oCZLCBidXQgYXJndW1lbnQgNiBo
YXMgdHlwZSDigJh1aW50NjRfdOKAmQ0Ke2FrYSDigJhsb25nIHVuc2lnbmVkIGludOKAmX0gWy1X
Zm9ybWF0PV0NCiAgIDc0IHwgICAgICAgICAgICAgICAgIHRzdF9yZXNfKF9fRklMRV9fLCBfX0xJ
TkVfXywgKHR0eXBlKSwNCihhcmdfZm10KSwgIyNfX1ZBX0FSR1NfXyk7XA0KICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+
fn4NCnRoZXJtYWxfaW50ZXJydXB0X2V2ZW50cy5jOjU4OjMzOiBub3RlOiBpbiBleHBhbnNpb24g
b2YgbWFjcm8g4oCYdHN0X3Jlc+KAmQ0KICAgNTggfCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHRzdF9yZXMoVERFQlVHLA0KImludGVycnVwdHNbJWRdOiAldWwiLCBpLCBpbnRlcnJ1
cHRzW2ldKTsNCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+
DQoNCj4gDQo+ID4gK3N0YXRpYyB2b2lkIHJ1bih2b2lkKQ0KPiA+ICt7DQo+ID4gKwlmb3IgKGlu
dCBpID0gMDsgaSA8IHR6X2NvdW50ZXI7IGkrKykgew0KPiA+ICsJCWlmICh4ODZfcGtnX3RlbXBf
dHpbaV0pDQo+ID4gKwkJCXRlc3Rfem9uZShpKTsNCj4gPiArCX0NCj4gPiArCXJlYWRfaW50ZXJy
dXB0cyhpbnRlcnJ1cHRfbGF0ZXIsIG5wcm9jKTsNCj4gPiArDQo+ID4gKwlmb3IgKGludCBpID0g
MDsgaSA8IG5wcm9jOyBpKyspIHsNCj4gPiArCQlpZiAoaW50ZXJydXB0X2xhdGVyW2ldIDwgaW50
ZXJydXB0X2luaXRbaV0pDQo+ID4gKwkJCXRzdF9yZXMoVEZBSUwsICJDUFUgJWQgaW50ZXJydXB0
IGNvdW50ZXI6DQo+ID4gJWxkIChwcmV2aW91czogJWxkKSIsDQo+ID4gKwkJCQlpLCBpbnRlcnJ1
cHRfbGF0ZXJbaV0sDQo+ID4gaW50ZXJydXB0X2luaXRbaV0pOw0KPiANCj4gV2UgYWx3YXlzIGNv
bnNpZGVyIFRGQUlMIHdoZW4gY291bnRlciBkZWNyZWFzZXMsIGJ1dCB3ZSBuZXZlcg0KPiBjb25z
aWRlciB3aGVuDQo+IGl0IGluY3JlYXNlcy4gSXMgdGhlcmUgYSByZWFzb24gZm9yIHRoYXQ/DQpZ
ZXMsIGluY3JlYXNpbmcgaXMgZXhwZWN0ZWQuDQoNCj4gDQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJ
aWYgKHRlbXAgPD0gdGVtcF9oaWdoKQ0KPiA+ICsJCXRzdF9yZXMoVEZBSUwsICJab25lIHRlbXBl
cmF0dXJlIGlzIG5vdCByaXNpbmcgYXMNCj4gPiBleHBlY3RlZCIpOw0KPiA+ICsJZWxzZQ0KPiA+
ICsJCXRzdF9yZXMoVFBBU1MsICJ4ODYgcGFja2FnZSB0aGVybWFsIGludGVycnVwdA0KPiA+IHRy
aWdnZXJlZCIpOw0KPiA+ICt9DQo+IA0KPiBJIGFsc28gaGF2ZSBvdGhlciBxdWVzdGlvbnMgaW4g
aGVyZS4gV2h5IGFyZSB3ZSBjb25zaWRlcmluZyBvbmx5IHRoZQ0KPiBsYXN0IHpvbmUgdGVtcGVy
YXR1cmU/IElzIHRoZXJlIGEgcmVhc29uIGZvciBpdCwgb3Igd2Ugc2hvdWxkIHNhdmUNCj4gYWxs
DQo+IHRlbXBlcmF0dXJlIGZvciBhbGwgem9uZXMgYW5kIGV2ZW50dWFsbHkgdmVyaWZ5IHRlbXBl
cmF0dXJlIGluY3JlYXNlZA0KPiBzcGVjaWZpY2FsbHkgZm9yIGVhY2ggb25lIG9mIHRoZW0/DQo+
IA0KPiBCZWNhdXNlIGluIGEgc2luZ2xlIHNvY2tldCBzeXN0ZW0gKEkgZ3Vlc3MpIHdlIGhhdmUg
b25lIHNpbmdsZQ0KPiB0ZW1wZXJhdHVyZSBmb3IgYWxsIHRoZSB6b25lcywgYnV0IG9uIGkuZS4g
ZHVhbCBzb2NrZXQgc2VydmVyLCB0aGlzDQo+IHRlc3Qgd291bGQgdmVyaWZ5IHRoYXQgb25seSB0
aGUgbGFzdCB6b25lIGhhcyBpbmNyZWFzZWQgdGVtcGVyYXR1cmUNCj4gYWJvdmUgdGhlIGhpZ2hl
ciBsZXZlbC4gQW5kIHRoaXMgaXMgd3JvbmcsIGFjY29yZGluZyB0byB0aGUgZ29hbCBvZg0KPiB0
aGlzIHRlc3QuIFdlIHdhbnQgdG8gdmVyaWZ5IHRoYXQga2VybmVsIGlzIGNvcnJlY3RseSB3b3Jr
aW5nIGZvciBhbGwNCj4gc3lzdGVtcywgY29ycmVjdGx5IGluY3JlYXNpbmcgdGhlIHRoZXJtYWwg
Y291bnRlciBmb3IgZWFjaCB0aGVybWFsDQo+IHpvbmUuIElmIHRoaXMgaXMgY29ycmVjdCwgYHRl
bXBgIGFuZCBgdGVtcF9oaWdoYCBzaG91bGQgYmUgYW4gYXJyYXksDQo+IHdoZXJlIGVhY2ggaXRl
bSBpcyBhc3NvY2lhdGVkIHRvIGEgem9uZSwgYW5kIGl0IHNob3VsZCBiZSBwcm9jZXNzZWQNCj4g
b25seSBhdCB0aGUgZW5kIGZvciBUUEFTUy9URkFJTC4NCllvdSdyZSByaWdodCwgYWxsIHRoZSB6
b25lcyBzaG91bGQgYmUgY2hlY2tlZC4gSSBvcHRlZCBmb3IgYSBzaW1wbGVyDQpzb2x1dGlvbiwg
Y2hlY2tpbmcgYWZ0ZXIgdGVzdGluZyBlYWNoIHpvbmUgd2hldGhlciB0ZW1wZXJhdHVyZSByb3Nl
DQpzaW5jZSBpdCdzIHBvc3NpYmxlIHRoYXQgb25seSBvbmUgb2YgdGhlIHpvbmVzIGhhcyBhbiBp
c3N1ZS4gQmVjYXVzZQ0KaW50ZXJydXB0cyBhbHNvIG5lZWQgdG8gYmUgY2hlY2tlZCBhZnRlciBl
YWNoIHpvbmUgdGVzdCwgSSBtb3ZlZA0KcmVhZGluZyBpbml0aWFsIGludGVycnVwdHMgYXJyYXkg
dG8gdGhlIHJ1bigpIGZ1bmN0aW9uIGFzIHdlbGwuDQpjbGVhbnVwKCkgYWxzbyBuZWVkZWQgYSBm
aXggdG8gcmVzdG9yZSBwcmV2aW91cyB2YWx1ZXMgZm9yIGFsbCB0aGUNCnRlc3RlZCB6b25lcy4N
Cj4gDQo+IA0KPiBLaW5kIFJlZ2FyZHMsDQo+IC0tDQo+IEFuZHJlYSBDZXJ2ZXNhdG8NCj4gU1VT
RSBRRSBBdXRvbWF0aW9uIEVuZ2luZWVyIExpbnV4DQo+IGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5j
b20NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
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
