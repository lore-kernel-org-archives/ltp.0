Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BB8C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:42:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDFCC3E939B
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:42:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C627B3C6603
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:42:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C3897600136
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:42:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788525738; x=1820061738;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=KjHBqTUY+NxhBuBWHg+zmKVGLMhCq7t1zLY7f7q/nsg=;
 b=EZGPEsGlWgsdbPXwD05NDZMMhDmxMpDb4H7i/oFcsFqEJ6UaehfKc64k
 HZB2p/MkOjknppWTFQrkQMLcEX73/74sWqCG4p/FGZoyT9Yx2vnplfBwU
 KDOtCF/PuSD6t8XTuFjSvrS6UbYIGq7k3L+TsNhuKjsCA3hfBgPFsvzPQ
 o6Jba/EImUuA3/yj/1rWpnFL3WPF3CBtpv6xgX4wpDXcVyqcq834U8Xx0
 FUDPbqJ4cXsxoALaRoBy4myn77yPOluk9288wAZqvxIW03CWDb4eTKOni
 WILdrVlbxafQnlVPu/Hz6GrwGBqPS3wr+ddrQ1F4DrJ3A4DoPY9FTxMHw Q==;
X-CSE-ConnectionGUID: CNfYlSvrTCmsW/gkbEg/Ug==
X-CSE-MsgGUID: 1dxSdqswSOaHWJxgekF3Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="100187236"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="100187236"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 05:42:15 -0700
X-CSE-ConnectionGUID: U/anXfbjSZGhcX3zdNt2MA==
X-CSE-MsgGUID: mDs46fKiQ3eyviqY09IPPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="268297502"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 05:42:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 05:42:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 05:42:14 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.20)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 05:42:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rl8YA++W3kRRLrmIyC0UU3OB4n1mNZUxlQSaLHPTPHTQb7ditdNw7VxTZyJM0eWEPdE3hSTKayR9ht80jJMIdCntvB8aQl1i4t3LZQRt8RxL57nkz+obQlWze3v2DrC4YILHoM4Kit/DIBbNCnIm1ynfl0Zg4Xy/U6CGtyZsn/67X/aLjIJGIytv0oZ6RlVLRrBNwz9sU3XS8sfgOa/1cuRCFNJ8IR1wNWBB/zgkXZaqhsdmc1576MrlLG1HmYwl2VAz4y2x63IsPt/hK2BlB/RUtMXoGrzJV9mh8sMdDJSeZOj1j7Z0Yj9yJLc171VZtVvscUOHmPlegf06If+bAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdJElKkk7yzQjQlmiSYkGzJ+CEobcfUhX+USiwA/FBU=;
 b=dlVm3V4GlUlnYQ/RLe1dG/N9H4KVY1Oc/sq9ob9EYCGPKAcuS6KVfJmFZN5ODuNYhVt73kghLm6QHTr4uxPMnQV9MVCkLf/rfeQK3k3YWAyHGaZSMT1CcY8pK4e2mW6XrzAkPgKx9qYvhDInSa93naiZsQp9INL9VvbuQBcoQ86bS9nUi5n8RzaBgREZHFzL7dyarIJDo+ezLAtVvl7qIJ6ODLn4R2jZQPVZjrtaqG8ThyFbQ1fzAIIQVDe301mU9tAE2mQYL/Wg+r58HGwa3GeA/FJXFZgIuvEWuVuw/rY9Huyp2sDduYQgR+8gT2Yim2GFqGEtU8+8gfaS1ObldQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by SJ2PR11MB7574.namprd11.prod.outlook.com (2603:10b6:a03:4ca::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 12:42:04 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 12:42:04 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "chrubis@suse.cz" <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v3] pmc_core: add test for
 pkgc_blocker_residency_show
Thread-Index: AQHdLhN8m0f6UgyxcEGZmmYFepcvlbajd1AAgA//2ACACwJDgA==
Date: Fri, 4 Sep 2026 12:42:04 +0000
Message-ID: <41a0da4371dea1aa8d2a37936ecd6d799a055f4e.camel@intel.com>
References: <20260817064052.304786-2-piotr.kubaj@intel.com>
 <2ae1b4ad5c5212d346387aa6b61b2e97c9d69b1c.camel@intel.com>
 <apGAei1EG3ioALnL@yuki.lan>
In-Reply-To: <apGAei1EG3ioALnL@yuki.lan>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|SJ2PR11MB7574:EE_
x-ms-office365-filtering-correlation-id: cb785e77-6359-43ec-eebe-08df0a81ec7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|10067099003|22082099003|4143699003|56012099006|11063799006|18002099003;
x-microsoft-antispam-message-info: E8PKednaVm9XwSSnoR0KHKtRVT4gYA6v4Qaw7O0XFMK3Wyd5uLdGezwVguPypzU9/Od43gaUXIbOW1aqy7zvMz59T3UgYmJrPgxt7LGFGVX1my/wySQNd1y0Uw57lwhy9YeHKIxRMxgKbSkBLJm4L68Tc3wTj2pQwh5cwwgP8N1BdKeKxXg2K20jc6zNym6YL9EL5alszb+VOnyEI46LjeeDIrVq+uQyuGXTTzeaV3+DEoW5H0xFZ1j698+vv28bRR6NUN4mvTOa8CHen22YWI7eYV0At2fzoUi2p45jJfoGXKxG53KIMEI9+Rv80153MaCyqFgyz//mynEQfl/9pcyGIX7GKi5aOck+Wk7rKMgG4sqGvNpLKxtkL9jqozGYKUX7DILbYE0j3SsihE5wOaPKjT1CPFinw5mPHCCaMHcwoUBEUdG1+WJR9uRwnP3Zuxl45qxvS9sb/c8QPqygMJY0zVV9evb+KasUNVJGvJV4DUsf4xhuHWjvKJVTTy8CUHOL9XdyMJRq0SI1Hi2YuorLtSOnJxjfAmbZt3mMKNJc2HRjhPHcHr6L7hdG8/C433QEneDWXEHnTTzedU5CRIVLFqx79Uci3GNX26Boznj1wJi0rm1PphXSSacigz5UGssfQ3LvIh+OG13+THvtXdDsij++cH1oKv4C/pg1dARx7ciLGOoiURzoo3csL5NR24dtAc92LhDUoF/VNADiuj7SwMVosB9o4Cy/C7aJ/Ko=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(22082099003)(4143699003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWZIUnpaMmcwejlxbmdaTDZmQUhqRFl6Ky8rTGZ6akIwOFNabnNPRWVRTC9J?=
 =?utf-8?B?cnlJY1YydGpXdHJBaC9pSUNxSHg2OHRNeFZTZ1paaDVwQ0J0WGQvUFB0UmtI?=
 =?utf-8?B?eVJiRm50K0xROHNsc2dKVnpINDNvY0U2QVBaaUNvL1Nna05lcFpFanhsaXZm?=
 =?utf-8?B?aXhxSHJIcGpWUFBtT25maXFPQ3I4QVllUTZRWlNCQW5Bc1JSQjdFNHROeC9t?=
 =?utf-8?B?YTRCejArS052WjhKMDNFOTNqZHp6dG9pUEVRSTMwZFR5RjV1bkRQK1I5cnBk?=
 =?utf-8?B?QzRBVHR2aEUxQlhlTEttM1NnMThjeTdZbDVBVUI1UDZxbWVzZmlZNkNiejY1?=
 =?utf-8?B?aVR2TGNFTGR2U3FNRDZmZnQ5U1FwdmdhenY0VXdaY21zay9UUS9UWVh1RUt2?=
 =?utf-8?B?RGxzRnZ5SkZnaDJKOTFLVlZmQ1FoVm1yb1hpbzJpSEVFWWRvV1BTVjRuMHNE?=
 =?utf-8?B?aTAwNk5DcytUaGRRclRpQ3h4dTlIcUt1N1R3YWdHUFQ5ZlI0R3F3Zkw5bVpL?=
 =?utf-8?B?YUVJdmJSYTNsM2pOcXNaamluYldhUGVCTHo5NVVLMFFvS3FXYXU0eU16UE5O?=
 =?utf-8?B?ZTVKNGFKUFh6L0JoV2FaTFlKVGk3OTEvODVYUmVweldpcSs0RjhiVytyNWJi?=
 =?utf-8?B?QUJqM1ZLdzhnaEswZytpMXdVb2FsMytwTHZvT0lJMWVTUU5PTVM0YVpuVVQ0?=
 =?utf-8?B?QzYvTUNCRlBkSFdZdVZ1SDJmc1FoWEtPNDVJL01JeGpBRzJUbVlBRkdRaWNy?=
 =?utf-8?B?MzlLenNQTHZZZjErbVJtcFIyTlEzdnhhM0QrQzFTQzhXK1BkeTdYSmp0YXdU?=
 =?utf-8?B?VkEyY3gxTkdHZjZya3pLQzM4SUdxN05WUDVRbTJKenZGTEMzVVNKRE92Yis4?=
 =?utf-8?B?YjBiQ2I4blhQYzAwUWdLc0w1Unp2Ni84bmxxZDZFc3ExMGlPcHZueCsrdDlw?=
 =?utf-8?B?clRtWWZYSy9ZS3BqUktsempEOFN3c2hXNHpzZlhVaUwyZFlGelpiL0NNZjly?=
 =?utf-8?B?VTg4U3dWYkpIMmFKejVXOG85RUc5Y1FUbzlyNnRrYXJ3bUpwZDh3NmtTZVB6?=
 =?utf-8?B?OTVSa1ZhU1JPZlBXeWhlNkQvUno2ZkIrck1BSkRUQ0lyakRtdGZ2dWNxSk44?=
 =?utf-8?B?aVJLd0Q4U0JKaGdjZHlXOXdQZ2o4YlEzS2dMWWNJMG5aNUhuTDRSNE1xcTZ0?=
 =?utf-8?B?azVvZUJWREh6WTJzZWtxYkhTTEVOQWdpZUdFMmh1cDNlZWFHTEVHNGo3VGFR?=
 =?utf-8?B?VVYvNVJsNDBzcTFZQkdUMy9pcURZY0VzcUNpMDZrWTJ4ckhOcStJNUQya0lj?=
 =?utf-8?B?Q3IyakVOY201aCtxYmIrdmZRRjJJZVlwRHNKTDVhcWFSd2FBU0t4Q3hoSXcy?=
 =?utf-8?B?eEY3U2ZLOWlkbXg0VkJHRDFtdU5DYWpPY3BYblM3a2NLWlFTdEhVQmNSV3I0?=
 =?utf-8?B?VytpTmkzU0JBSUU4K1phY3l3cE9YRmVabFZZYjFSSzlNVGlhQXBUcFV4am1J?=
 =?utf-8?B?THI2dFZ5ZXNZSzBrLzJoY1NOdmhGa2p0UVRNbkFXVzRoUEN4dkpBSHlFOVRT?=
 =?utf-8?B?QWwxWjEwK1o2Z3Y1dG5zelQ2cnF2OFFVNlY0aWZnWFROQVRvL28vYW5Jd2Vy?=
 =?utf-8?B?bXZsRUdLSmt2LzRNV2prVFU4ZGFXWFVFbncxK2pSeHEzYkxCcXBNZFBzYjZG?=
 =?utf-8?B?d3ZTUmMrb2EyajVRZlZsUHlJV3NFMU1xaU42bVpJTzZaYjd5dGtNUHo3OUtS?=
 =?utf-8?B?UEZ3L3Z2R1NsdG1ONE1TaEVObnZuUXoxODRNQjlSTEdCQlRDeVNWQVpaeU5V?=
 =?utf-8?B?MEFOY2hHdXBuS1V5MDF4QmhTQWdGMmMxbDNYQ3Y0ZGx0dTNWaFFHalhPQU01?=
 =?utf-8?B?ek9wTVhiMG9IR0RHOG5tcklNWEFYYjU5WlZ0ZUtvbVV1M2NSd0d0amlhWVFY?=
 =?utf-8?B?V2Jja2F4bEs0M0VOTHlGZFJ4dXoxa3BJTFJpaVMyTHN3bGIyN1pLN2V6UWxL?=
 =?utf-8?B?Y1VMbUlJQ0xtenVxV01EdlpYeW11NUM3M2RBQ0xLS1ZsVnI0Nk8wb2F0OU82?=
 =?utf-8?B?WXRpbTVhZ09qN2pIVnF6S3lFWEF2TWMxNEN4bm42WVFiWkNQRDcyWnd3WEk3?=
 =?utf-8?B?Ulg4YkE4YXBTSEFTMWs4U256R1dsVnBWY1k4L2xsRW1kWkFLYzFvVXZuUXhu?=
 =?utf-8?B?NjV1bmZlM0tCRnk0SDl2OGtHdmtjNWJiM2hxNVlWb1NtL2pOdjBDdzdsc1V4?=
 =?utf-8?B?dldwc1VTeVpPZHh0Y3BZcWJkV3JyVTNOQkR2bFQ0Q0FoR29XV1J6RzJLcUFF?=
 =?utf-8?B?QjZWR2t4ZEFGYU5KM0U1cHpYZmY0TXNna01jV1dzNWlTbWxILzkraFlGRlJu?=
 =?utf-8?Q?PZ9OlnbM2MDFuokc=3D?=
Content-ID: <455C33F9706DAE4F895AA6B6CC52B8F8@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2xYfYGJOf47vXZaH9bHZ3lHHQmRuGhDnGlzNkyGbBGjGXH79lO+RQ84o4DgICvt2sJppI42MCaXexnLKcrEuoD6HpbGbwwKfaQCEITO0cQ75Xxogv1zw90F/bLYD5ZAqHUz9wzkMisqDdr+7qF5qqUQ+HvqhCYY69xpAS9l/3RDembwZhsXZA3IZdDHnSmPn9m+jpk+xkKnUw4iY37Fahgh9wCZe4wm1kU7gGgmvUYXnwBSEDxv4Lr1N13OhcQNA1Roir7/ObZYDbyHi95NH8OYBI6HnRufjXvDm4ap3Z0UPR1oi5bxaRKh8+sA0lmHciVqlumiUPewrMv0q4B3IoA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb785e77-6359-43ec-eebe-08df0a81ec7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 12:42:04.4664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9WfzeBOYwuzwNeG6Z0W9/LqINPQu/LNXruACDW4S8q4WFvyWYlAaFZohQ2pY7J9xfPHaWipuWzIcqYLCDoqEhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7574
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] pmc_core: add test for
 pkgc_blocker_residency_show
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

MjAyNi0wOC0yOCAo6YeRKSDjga4gMTQ6MzUgKzAyMDAg44GrIEN5cmlsIEhydWJpcyDjgZXjgpPj
ga/mm7jjgY3jgb7jgZfjgZ86DQo+IEhpIQ0KPiA+IE9uZSBxdWVzdGlvbjogdGhlcmUgZG9lc24n
dCBzZWVtIHRvIGJlIGEgd2F5IHRvIGNoZWNrIHdoZXRoZXINCj4gPiBkZWJ1Z2ZzDQo+ID4gaXMg
bW91bnRlZCwgYXBhcnQgZnJvbSBpbXBsZW1lbnRpbmcgaXQgbXlzZWxmLiBJIGhhdmUgYW5vdGhl
ciB0ZXN0DQo+ID4gaW4NCj4gPiB0aGUgcXVldWUgZm9yIExUUiBjb3VudGVycyB0aGF0IGFsc28g
dXNlcyBkZWJ1Z2ZzLiBEb2VzIGl0IG1ha2UNCj4gPiBzZW5zZQ0KPiA+IHRvIHB1dCB0aGF0IGRl
YnVnZnMgY2hlY2sgc29tZXdoZXJlIGluIHRoZSBmcmFtZXdvcmssIG9yIGRvIHlvdQ0KPiA+IHBy
ZWZlcg0KPiA+IGl0IHRvIGJlIHB1dCBkaXJlY3RseSBpbiB0aGUgdGVzdHM/IEl0J3MgYWJvdXQg
MjUgTE9DLg0KPiANCj4gSWYgbW9yZSB0aGFuIG9uZSB0ZXN0IHdvdWxkIHVzZSBpdCBtYWtlcyBz
ZW5zZSB0byBhZGQgYSBsaWJyYXJ5DQo+IHN1cHBvcnQNCj4gZm9yIG1vdW50aW5nIGRlYnVnZnMu
DQo+IA0KPiBBbHNvIGdlbmVyYWxseSBkaXN0cmlidXRpb25zIGFyZSBtb3ZpbmcgaW50byBub3Qg
bW91bnRpbmcgZGVidWdmcyBieQ0KPiBkZWZhdWx0LCBzaW5jZSB0aGVyZSBoYXZlIGJlZW4gc2Vj
dXJpdHkgaW1wbGljYXRpb25zIG9mIGV4cG9ydGluZw0KPiBpbnRlcm5hbCBrZXJuZWwgc3RhdGUg
YnkgZGVmYXVsdC4gU28gaXQgd291bGQgbWFrZSBzZW5zZSB0byBhZGQNCj4gLm5lZWRzX2RlYnVn
ZnMgZmxhZyB0byB0aGUgdHN0X3Rlc3Qgc3RydWN0IHRoYXQgd291bGQgY2F1c2UgdGhlDQo+IGxp
YnJhcnkNCj4gbW91bnQgKGFuZCBsYXRlciB1bW91bnQpIGRlYnVnZnMgYXQgLm1udHBvaW50IHVu
Y29uZGl0aW9uYWxseS4NCk9LLCBwYXRjaCBzdWNjZWVkZWQgYnkgYSBuZXcgc2VyaWVzIGFkZGlu
ZyB0aG9zZSB0d28gdGVzdHMgdGhhdCBuZWVkDQpkZWJ1Z2ZzIGFuZCB0aGUgY29tbWl0IGFkZGlu
ZyBkZWJ1Z2ZzIGhhbmRsaW5nIHRvIHRoZSBmcmFtZXdvcmsuDQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KSW50ZWwg
VGVjaG5vbG9neSBQb2xhbmQgc3AuIHogby5vLgp1bC4gU2xvd2Fja2llZ28gMTczIHwgODAtMjk4
IEdkYW5zayB8IFNhZCBSZWpvbm93eSBHZGFuc2sgUG9sbm9jIHwgVklJIFd5ZHppYWwgR29zcG9k
YXJjenkgS3Jham93ZWdvIFJlamVzdHJ1IFNhZG93ZWdvIC0gS1JTIDEwMTg4MiB8IE5JUCA5NTct
MDctNTItMzE2IHwgS2FwaXRhbCB6YWtsYWRvd3kgMjAwLjAwMCBQTE4uClNwb2xrYSBvc3dpYWRj
emEsIHplIHBvc2lhZGEgc3RhdHVzIGR1emVnbyBwcnplZHNpZWJpb3JjeSB3IHJvenVtaWVuaXUg
dXN0YXd5IHogZG5pYSA4IG1hcmNhIDIwMTMgci4gbyBwcnplY2l3ZHppYWxhbml1IG5hZG1pZXJu
eW0gb3Bvem5pZW5pb20gdyB0cmFuc2FrY2phY2ggaGFuZGxvd3ljaC4KClRhIHdpYWRvbW9zYyB3
cmF6IHogemFsYWN6bmlrYW1pIGplc3QgcHJ6ZXpuYWN6b25hIGRsYSBva3Jlc2xvbmVnbyBhZHJl
c2F0YSBpIG1vemUgemF3aWVyYWMgaW5mb3JtYWNqZSBwb3VmbmUuIFcgcmF6aWUgcHJ6eXBhZGtv
d2VnbyBvdHJ6eW1hbmlhIHRlaiB3aWFkb21vc2NpLCBwcm9zaW15IG8gcG93aWFkb21pZW5pZSBu
YWRhd2N5IG9yYXogdHJ3YWxlIGplaiB1c3VuaWVjaWU7IGpha2lla29sd2llayBwcnplZ2xhZGFu
aWUgbHViIHJvenBvd3N6ZWNobmlhbmllIGplc3QgemFicm9uaW9uZS4KVGhpcyBlLW1haWwgYW5k
IGFueSBhdHRhY2htZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgbWF0ZXJpYWwgZm9yIHRo
ZSBzb2xlIHVzZSBvZiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpLiBJZiB5b3UgYXJlIG5vdCB0
aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIGFuZCBkZWxl
dGUgYWxsIGNvcGllczsgYW55IHJldmlldyBvciBkaXN0cmlidXRpb24gYnkgb3RoZXJzIGlzIHN0
cmljdGx5IHByb2hpYml0ZWQuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
