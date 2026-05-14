Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147B8CD4851
	for <ltp@archiver.kernel.org>; Thu, 14 May 2026 09:26:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 236F33DEF5A
	for <ltp@archiver.kernel.org>; Thu, 14 May 2026 11:26:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89C3C3C7AB3
 for <ltp@lists.linux.it>; Thu, 14 May 2026 11:25:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1DBCB2005DB
 for <ltp@lists.linux.it>; Thu, 14 May 2026 11:25:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778750749; x=1810286749;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=V7NO8fDQPW3DSOWy1O6xSzsXYecVSb23Z1yF8hT0pSU=;
 b=X0YAzth7r9vOiJE7WV5z1K8iQcRlIKvDSBT4uqoodD7Qy5xk4lhV6fSo
 oUI8xxHIi7azmZ//7ElE9vzM2Uxzn4aUEyoZzpWQVuFc+JZY/Y6lIaIUh
 9KRvI+QLt8lnCpDMQN012ehkb2FYU3FgG5bwLEIFXI9YTf5tYlnBXA5xM
 3+dSUBB5RgvUcaDFkxQF9jUT/Yoy8TdUtmcLuVm69cYJzYvdvU62dlGa5
 gWypHy5bqGBjKEi7Mp62MTgamPDmWrdqxboOjsjrE3HcVgIYHqgrma0KD
 hSH0+tPRTrBmyCmat7R5BeRQv1MlrwfOCdGb6KC0snuMcfHAKLkhnRXZl g==;
X-CSE-ConnectionGUID: 9325S8c9ScSU5GTZc8zhYQ==
X-CSE-MsgGUID: 98BuOGj4SQesOvmS0fKIrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90793028"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="90793028"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 02:25:45 -0700
X-CSE-ConnectionGUID: eUUBWFNXS0+3vlEW73Zx7Q==
X-CSE-MsgGUID: /pFVIbVER1Gll0ils0EzaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="243320560"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 02:25:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 02:25:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 02:25:44 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.21) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 02:25:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTxM5cjUGgeDgicgqp3+zWNbKg8Dhkvvr+QkTQtz2xYYd3Ym2RxiC8t8pZ8OREsl++d272tJuq+/T8DKmZk1IerigsCUfLKgP9wiyaBA4j3WuX472X9Oj7Qfsb/VoY2WESzhoLC3E7wxjNASnR4sAe1WOWlO24dBgQbT3+szpIPc6nVbbqoF8lIHEoVAbfUKBIPB2On9LmREFQ7In0GRscZqsjr6dV52zOP/JD1z2Hma5w6+0/Mlv95/B6a7jNu0O+eT6J3n6oMKreWKCsPa/y2YtorJV07OpZVW1JsLsAbcdhvjl+TYBOrNH4Pyw7EP7tK3bQRZS5zz+7iTlZ67/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRZtwwMNaef4FilczD6F/IhRGpk8AWI4kB+7yB4cts4=;
 b=HqEnQUA5OpGNN2w7TtE10SLyKo145WufIITd6iD8lPdTgtL+fcK+lVRsEL5ew7viQMEyBQOWrVMfWf5lU63etIymrxodKSo9XXCEAajAsnwEz7fFWOUCqtHZpT2C39SvwJ2nr9fmFIRb4wH9nY2L7uV5MqS20w6yK1/2AvixZ8x+opGJxFUxCVXJAh4GE9f18Hh1ml77DNfvn2IMZ+RbMuWrnlrfjrRHNj/tvLnqivmAIRIeNVP3S5MfuAPUTT6uP9Lt49faoE2lK0e4QU88LPC7rvd43A7j00c8T+atsac1GD90Ft/fBdSU63VeLIKjNDAzcaJirMeL9RRH9heA2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by DSSPR11MB9643.namprd11.prod.outlook.com (2603:10b6:8:374::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:25:41 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%3]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 09:25:40 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "andrea.cervesato@suse.com" <andrea.cervesato@suse.com>
Thread-Topic: [LTP] [PATCH v12] high_freq_hwp_cap_cppc.c: new test
Thread-Index: AQHc3fJx5yEeaze46UW09OPAxBgzprYCKrMAgAsgqYA=
Date: Thu, 14 May 2026 09:25:40 +0000
Message-ID: <974787c79712206963e5c6228bc79348dac65eb4.camel@intel.com>
References: <69fc3f73.050a0220.3c8a7b.8474@mx.google.com>
In-Reply-To: <69fc3f73.050a0220.3c8a7b.8474@mx.google.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|DSSPR11MB9643:EE_
x-ms-office365-filtering-correlation-id: 073c45e6-2819-4d34-674c-08deb19ac43d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|11063799003|22082099003|18002099003;
x-microsoft-antispam-message-info: 1Yysi05OrcQil5OdHT9sv9w48xaFxWOv9orVMTKL6wFEuvQgQFqYT/Bo3Z5zsNyVTgv4tLxRwVWRf55DAyEb3i4zwdEiqJZIlgVs6Clzyuf/bO2XfO3r4vnj0xv64iyMM872ZYax7TsJUAWZ3CTMLiKVFnQu8cwLMXkyYRepFGn+JAkVSHbaczT7cZV9Z18L6TP4dF76INlJRjGgJkmopVvvDsBgWy2LKv/yQLZ35jFSWQoo7LapJ6HbT/ysliK0dlk5D8oXqnkHc6gu1l5sTxV6gPBfBpjdcihSP+gD7353O+J/y0GByv3u6dnsoa9SBXpF2ToIWOWZPEiY98Fye9Sqr2JVLsCbOWP+UDvl344PwAoRmY6SdtFkogMLOXTYuP7BEt47wxQNmsStKMQ4BDDrGUGpDQZRD0semYifHXOdesB+NZj/B7UBHjWn9FRz9GPr7Rxl05BJvMwil7fuoAvmF2DKcJnLaLCssprDlVu12fvl+EsQ0AHrG6IAq6CHP02lvESJQHKh+SZHO5WKdFBgTHmr033vEmJdAALGP/MOujOmNbinuMTKVl0zeTLSf0Ifu4ZgL6I5OCjuyK7UVXrSRUYAT+D0SPnK04ZtwNHZh+u7bQrBSsS0bPuuDeVPbMBPF9fiL+wr2QCGUkBtKVp5ESk1v6sKWoWaIG5FrlEatPSf5kSMupCuBlcROcS6Th2vuw2QOAudnLVPpBQdTgujFAoFw2HuYTV397wX5+XOqWhQyGnUwz54Ea3KaEDv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(11063799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDBBVDk0MmtJcnh6SU1tZVM5bWN2NmdmcU93ZTBrbCs3d0FhdHRBY3JoQ2po?=
 =?utf-8?B?cVBsckZNRnYzSitWUCtwTVQxNEFreTNmRW5leDhtMnJMK2pLN1lIbzJsa0FQ?=
 =?utf-8?B?N01kaUwrRkhLTTBsYWZ0U0IvdmYyQndwSHk5ajVvYnhIQnJLaXI5Rk5tOWdy?=
 =?utf-8?B?M1BCT3pwYk40UktKTko2TE8rU1E0eWE3Zis1Nzc1OFk2NTlka2t1b21WUkMx?=
 =?utf-8?B?RWgxcC9UR1ZGTTZYY2h1Y0hIcjJjUDU1S2RBV0d6bG9DSVRTWUVlN25mMisv?=
 =?utf-8?B?THp2M1o4NFFLMUNRWHZ2Sjc2enp1cUdqaXN2ckRxRW5kTjE2NEpoZElmR25k?=
 =?utf-8?B?amhpdDNnenRXTmZEVkV5V3dsREhnTTVoc3NKU05SNnhrYTJBTUpSeU1mNkV3?=
 =?utf-8?B?Z200cHNzQzlSQzE1a0owajdzUlJSU2QxZkNOOVdSbnBjdy9nTkVxTXJyQUtB?=
 =?utf-8?B?MHl5Zjk0eDlqUjRuaHFNNFVIUFlTMVh4UzVaTUJOV2l4a1UvbE9oZWlzMTNT?=
 =?utf-8?B?MThleUVBUEw3OG1ZN0g3SEpteENUMVI0a0NmbXZiem9ScnYxdjM0WW1lUFBZ?=
 =?utf-8?B?K1NtdHhyMzc0WGo4YzBmVU9ZS2wvM200M0wvV2NPT2dGQndNblBnVW5acVBl?=
 =?utf-8?B?Q3Q0OTNqbE1qMW4yUTNBQU50TDRnODFOdERKZG85MXpyT1F2NmF0QUVVeXFx?=
 =?utf-8?B?YStzUnBUNjdNZ2t6MzlxYjBNZndVKzRZalY3UCtvVFMvT3BFN2tXZFdyN09i?=
 =?utf-8?B?K3JPK3plR0VHUFllNnRCNGlNSmZ1TXFtKzhGejdMa2tGUGthYUVVZTF4VDQx?=
 =?utf-8?B?ajZVZWl5OXJSTmlQby9IZFdqbGVValBMZDFwcExLdlI5cE1rK0x3dnMxQlQ4?=
 =?utf-8?B?Z1N6RVdvYUx3VEhNU2Q0bUgxcnRlNGhnVDZSM2diU2lhOE1uS3ZUTE9rN2t6?=
 =?utf-8?B?MlkzSTQrMlZlZ3dTMnEvTytlZllTcjRidDJOUGV0UHdDOFB0ejdkRXlybEkw?=
 =?utf-8?B?anRTMDIrbmVzVDk5VXNFb1dmaDBubkdzVEowMFZzQTROTy9vdnJwdWkreGxi?=
 =?utf-8?B?aFprcDYvSlZyVUY1c21EUXdZV0ZEQ2hlbHNKNWFGVFFnYklqa2FzRzRidkVY?=
 =?utf-8?B?NGlUM0RSSjdRNHAvcmNuSFJHZzVJN3hGUDNHc3U5dUE5SEZ3TW4zSlFYeEYw?=
 =?utf-8?B?bGhKZGprU2VkUnZScFpRWXRnRllCMlNwZXBxV0pXcVdKRG5mNFhESE5RdWxm?=
 =?utf-8?B?NDY2UG9Zc1dCN1p4U1VtcE9mMklhR0FYYllUK05xU0NMTVZhY3pmRzdOSFc0?=
 =?utf-8?B?MjRUWWZKWnFzOE9RakRBa0RTNjJRSUJRZ1NOa2F1cWJ6NHdsZUtUOVBTNzNF?=
 =?utf-8?B?QUdLMmd1UkIyU0RhcGZWelg1ZzNEenhQMURUUG1McUE4ek1FRnFsVUc5Z2Nm?=
 =?utf-8?B?bXNwMDMvbGRXYklZTGtrRDVYM3Q0Z1ZrUkpoM2Qza1lFc3lnQ29BWVdjVlZx?=
 =?utf-8?B?dENRWDhPeXBkZisxTVdEODZ6QmNGYXhXNTJGMVBkbEUyWHdzUVlsNlNVemFO?=
 =?utf-8?B?SzFTYkNicHRnYUx4aTNsYS9TM0xaRS9UMklvWW8rVExQSHp1QlZPK1VFWCsr?=
 =?utf-8?B?K1Z6OWkzdEM3V0MvbkcrRFlLZWVFV2R5UGRZeDNJWFE4S3VmRHEyZ1BTRGEv?=
 =?utf-8?B?TVRkZmJ3NHdRWEt6a2VBQUxENWh4OGNtU2pHR1JJVWFBVEE2SHd0ak8xSUM5?=
 =?utf-8?B?ajYvQlZHL29nUytDcGR3NHYzWXZmeFk0QU0vMTBrSzRCR0FRaS80MFFpTUJa?=
 =?utf-8?B?TFlpWVczWXJxbkQ1MFVvam5Jak5EbitTbW5yWkFEUG1MaEtzVlFlbWZjU2d2?=
 =?utf-8?B?WGN4ODhCRFV3Z0VBYkhYcFEreEtCeElkaWNBMGp2cFBiTXphRWRtcFBIYWRQ?=
 =?utf-8?B?Y2xBb0lCT013Skt6Vk4rMGpxUkpmVFBWb0hRdytveElTeXg4MHlrVVNUMUVT?=
 =?utf-8?B?SDRGSXVUM3djNUsxNDRmVDhBY0tidWlxb2VHMEl5TmRvaWN0Nk9oZGpRbjN2?=
 =?utf-8?B?bmtYdlU1WlpDMTZCcGxRTHFSZDZuVW5zL2wrcVlMcDE3ME1BVXl1YkxZdWlX?=
 =?utf-8?B?M2x4cW5sa3ZPQ1Y1dXFUWXhnL3RwdUdhVWRrRlp4STJWcjFnYkhoVHQrdUVl?=
 =?utf-8?B?TTB5ZXYwMGdZcEU0b3dZWkIrV0xuaTBtazd1S2haY2ErazNlUkQ3RXBoRHBC?=
 =?utf-8?B?OTgwV2R1L1A0cVQvR1RSL3VBRWl3UVMvYlRUVmgwZWNwUnRFOWx5S25HcThY?=
 =?utf-8?B?NGFNTFVYcHhzZUlOdk5vbUd4aVI5bGVpeUZUOHpuSGpWa3p5VEZKOEE4a3Zs?=
 =?utf-8?Q?QJoHjQMdhXcDMRFo=3D?=
Content-ID: <98BD4131D72D59448708783EAA32849F@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nZJI70L2z4+/ncFJZtV9KCiHz3C5wUXAFdQZA11ugFL91c+CuTn30DMXoZWx7ghjORdfzo1dxEp2puQh8Akdw7RxV/duLxTnv3XFq4/pFu2xjLh2d7MXUvgE2me/fffEbVrDHYs3v0+8efYt4h2VT2TTsDsxPKTE4mbCjx+ukOY8KqBhTiFq/NIrvN1UKrZXcEouhhl7exOZysY9GJWuuEgHu9qW08h0o/CZgKzrL1MM2AQfNhtOIxESRIdCkLm7XNqukOVEeJVDQ9uWZFzUNhb1yxHCkVkdN0LJREnJSggyxvI+OLWnhv4HC6zpEZ0OIQhvLpY65/Qjsz4dNQPb7A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073c45e6-2819-4d34-674c-08deb19ac43d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 09:25:40.8275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zza8JgEEGN+yQ7AuoLV3qaYAzOvyTeEHPdF4UwpCFJzpz4TibFTy9rA8ynt0IpfP8nTdaRkolUVileJUI2XemA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR11MB9643
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v12] high_freq_hwp_cap_cppc.c: new test
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

SGksDQoNCnlvdSBoYWQgc3VnZ2VzdGVkIGRyb3BwaW5nIGZkID0gLTEgYW5kIHN0YXR1cyB2YXJp
YWJsZS4NCg0KZmQgPSAtMSB3YXMgZHJvcHBlZCwgdGhlIHN0YXR1cyB2YXJpYWJsZSBzdGF5ZWQg
YmVjYXVzZSB0aGUgdGVzdCB0cmFja3MNCmFsbCB0aGUgY29yZXMsIHdoaWNoIHlvdSBtZW50aW9u
ZWQgaXMgYSB2YWxpZCByZWFzb24gZm9yIGl0IHRvIHN0YXkuDQoNCg0KMjAyNi0wNS0wNyAo5pyo
KSDjga4gMDc6MjkgKzAwMDAg44GrIEFuZHJlYSBDZXJ2ZXNhdG8g44GV44KT44Gv5pu444GN44G+
44GX44GfOg0KPiBIaSBQaW90ciwNCj4gDQo+IGRpZCB5b3UgcmVhZCB2MTA/IE5vbmUgb2YgdGhl
IHJlcXVlc3RzIHdhcyBhY2hpZXZlZCBieSB0aGUNCj4gbmV4dCB2ZXJzaW9ucy4NCj4gDQo+IEtp
bmQgcmVnYXJkcywNCj4gLS0NCj4gQW5kcmVhIENlcnZlc2F0bw0KPiBTVVNFIFFFIEF1dG9tYXRp
b24gRW5naW5lZXIgTGludXgNCj4gYW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbQ0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCkludGVsIFRlY2hub2xvZ3kgUG9sYW5kIHNwLiB6IG8uby4KdWwuIFNsb3dhY2tpZWdvIDE3
MyB8IDgwLTI5OCBHZGFuc2sgfCBTYWQgUmVqb25vd3kgR2RhbnNrIFBvbG5vYyB8IFZJSSBXeWR6
aWFsIEdvc3BvZGFyY3p5IEtyYWpvd2VnbyBSZWplc3RydSBTYWRvd2VnbyAtIEtSUyAxMDE4ODIg
fCBOSVAgOTU3LTA3LTUyLTMxNiB8IEthcGl0YWwgemFrbGFkb3d5IDIwMC4wMDAgUExOLgpTcG9s
a2Egb3N3aWFkY3phLCB6ZSBwb3NpYWRhIHN0YXR1cyBkdXplZ28gcHJ6ZWRzaWViaW9yY3kgdyBy
b3p1bWllbml1IHVzdGF3eSB6IGRuaWEgOCBtYXJjYSAyMDEzIHIuIG8gcHJ6ZWNpd2R6aWFsYW5p
dSBuYWRtaWVybnltIG9wb3puaWVuaW9tIHcgdHJhbnNha2NqYWNoIGhhbmRsb3d5Y2guCgpUYSB3
aWFkb21vc2Mgd3JheiB6IHphbGFjem5pa2FtaSBqZXN0IHByemV6bmFjem9uYSBkbGEgb2tyZXNs
b25lZ28gYWRyZXNhdGEgaSBtb3plIHphd2llcmFjIGluZm9ybWFjamUgcG91Zm5lLiBXIHJhemll
IHByenlwYWRrb3dlZ28gb3RyenltYW5pYSB0ZWogd2lhZG9tb3NjaSwgcHJvc2lteSBvIHBvd2lh
ZG9taWVuaWUgbmFkYXdjeSBvcmF6IHRyd2FsZSBqZWogdXN1bmllY2llOyBqYWtpZWtvbHdpZWsg
cHJ6ZWdsYWRhbmllIGx1YiByb3pwb3dzemVjaG5pYW5pZSBqZXN0IHphYnJvbmlvbmUuClRoaXMg
ZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG1hdGVy
aWFsIGZvciB0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gSWYgeW91
IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRl
ciBhbmQgZGVsZXRlIGFsbCBjb3BpZXM7IGFueSByZXZpZXcgb3IgZGlzdHJpYnV0aW9uIGJ5IG90
aGVycyBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
