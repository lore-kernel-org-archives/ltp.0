Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA398C79F89
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 12:12:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4EC503E86DB
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 14:12:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4DA03E86D9
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 14:12:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E50C41A00813
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 14:12:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788783136; x=1820319136;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=4OvhV7DCcUY8mBv+lCBMp5KgkphcYERXspl4ZZINJS4=;
 b=D5PK+mR5qBEOKPEdHzBQsTMf5YEio66gh9jmMTw3FaNGiFol+vb38IIi
 MPjpCOcpcK+xE7oL3YtCZSiBW7WM4vfi89lVmvAAUmx1w3SJmfCWYgGdt
 7NNroU2oTfgrnuQF2QW6jrq66Jof2ir1ve5OzAUMMI841fcJewnKuV6RA
 EiOL/cpYhfTyE4lSAdDAxUS8d0vomqHRKTzn+tiAaFesm44IMWOBVbdeo
 Ftlvn1uPwOXBkQs7vYN797KHQleBliYhCNgMjADgx6jJryhJibbtoQNJP
 LiGbdQyLJ7ootHk+IzvZXeFhzxxlxX2cq4rKdoopMfunSPyD7xL5slrJm w==;
X-CSE-ConnectionGUID: crbghg4mQR+hyQx327Gecg==
X-CSE-MsgGUID: eiunCeEGQnmXB+3vxfAUUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89029644"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="89029644"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 05:12:11 -0700
X-CSE-ConnectionGUID: U+vdxW9URvmJnArf/SBPgA==
X-CSE-MsgGUID: NT6yDYhTTGG9+dJBS/j+9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="272624135"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 05:12:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 05:12:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 05:12:11 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.20) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 05:12:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfdCYqqO1cDJ4MsDEbQAlmoAuVeiybtuBXd3Bev9j1s9+XAd8sBMn5sDFAobbmbcasbzBAdZKAPNGxu3O0fHJLQBo16It3yJh0vXN9DhEeiSQ5POekCMhI/ym7gUybHGkdoTLy20t8eWMfuhkUDPqc78FqPlhDoDFjuGRef/UoIPDgb3pqlxvSUip//FV8OLh7RuDZQqF5EoG+VRVhpbvMjJzGDsodROws3Izq9CLXiFT/xt2AXCqRGhv+XaQScve1b/nfnmIz63hZAxNs4SoJFSecfyK2/6YMsiZRkp91FJOhtc6fcnwUnprF9y4pyxXX7EqoHM5U15g1fmLF0APw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zXGvMG1e0EuL/Kl9nuT/7pW34PVkQFaGQbJAvcLqbw=;
 b=vxq5NfP3i+X/7fmF8VpLTEmTpMm+sczW9cVpGTn+VAvQI47lcllkXGUTEzCMdb3a1ueIL/bmeTaTvEes4hECECcWLjdOIVtB6Rk6KVBcnDk+NyEiWdMmYpie+7AH4Aknb4zg6itwypmFzU3Lba5697CGYFOjBDJohTNGxTutYkS/ETcxnXUcdUXvbVBCV4OXKP95he56CMo/UJVXINtWiQRLFyt5valxZvwUp3s9xpSZKY4lO6dLxIk8ieb9Y5oBV+APwy9ZmKXfUpzSi2p0B2lReoCwVwNjEFczRxjS/ySapkzFi60ovJlfCV6LcvD5STY+Ec25+3gnpOXLMtBjLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by SA3PR11MB890013.namprd11.prod.outlook.com (2603:10b6:806:592::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 12:12:09 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 12:12:08 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "andrea.cervesato@suse.com" <andrea.cervesato@suse.com>
Thread-Topic: [LTP] [PATCH 0/3] pmc_core: cover the PkgC LTR blocker counters
Thread-Index: AQHdPGqmDJGjoTkHdEuBncM82wSWZLbCq32AgABf4YA=
Date: Mon, 7 Sep 2026 12:12:08 +0000
Message-ID: <428ef70bf7ae17da9e77256329e056e96d432f40.camel@intel.com>
References: <6a9e59aa.39f355fa.13d8c8.1eed@mx.google.com>
In-Reply-To: <6a9e59aa.39f355fa.13d8c8.1eed@mx.google.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|SA3PR11MB890013:EE_
x-ms-office365-filtering-correlation-id: 889dbcba-30cf-4e8b-63c7-08df0cd93d81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|6133799003|56012099006|22082099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: osm24SuH/1JYBG/LBAh7RfIQGJ36yK2MjFrh73cqUCwhzmlS1CeOZfVIs10UoetiIZEMKvwUzu1qMkdTpK7fm59CCaLaFHShMNpPQEeTPOnd7Y6sAEe4etcbkpfiifODZHQEujJqDJBwPLkuVZxmXYloNvJSlxeG1CxaKk3Au9mt6sGtIaux1bAy/vnj4I40TVcz/39CiWjY5AtAnW91zrR2FeZxRsMqAYF8vBtvjc06SqD8XHM/3KmgGjm4247twWzhCfE/9lkgm5r1CEliQ0zLaXsglDsU/9GgrHlsNydTqV1w7Cqnfc+KUIv57CeKLv8ItTFqk99XJW55oeOOD4gmblSbjHdXWNbFrcnCdvoljklOVEjpTaF713asPKzRsbI/Cuvy5HlMDSrGCBR6LZr9xAjvi3P86qwBefc9srmAXZ2EcMHfaeDON28QKy9aBhcMs0t5h8IxWMfQikppFNHwpFfGUJ0S6hwW0GEc9otu0h6jsbLbKtLpzsJjN4Vvvj74SiOWyypi1WF664M0hUAa/VdEUP/O8BeqLSG1McIEWPMiIoD5Ae3NNC+nqC9WSq71n7ZU4Z0s5w634VE/uDQ1Qosijlt7QdTcLHCSxhmx1xe4Xc3/U3au8ZKyFnEBTnSHeFZK3g91Zgq8ModLBm8ONFOgYafBzjTVEsUsUh+5wRuBdwfnxHaeQ7J3xAQIgxRerkJzRjVPx86+4d6dpUIpUF7UfAlXLwyR1QnRli8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alZTQTNiNFFuaDlyR1NQSnFyenczcnFzc25KcHF4aTFmaDlXRWRkUFBLL2gv?=
 =?utf-8?B?RjB5czY4N295K3VYdDJROXJSbXZLYmJWb3FNVFpvZGh6TUdHc0t2bllaQUNh?=
 =?utf-8?B?L1Mzbm5JSUhvVEpYL1ZLN3dRWHZPb2c3RURwVExTNmlGaFFGVUZWVmJZVDAx?=
 =?utf-8?B?Zk1ITjY5eUxBdWgwQlhNQzRCeGN6OVZaSVR0LzIzZ3V3UTJQQVVCUitwRWUr?=
 =?utf-8?B?NU1RWnJBVUxLNzFaUjZQS3hRZ21mcVZBWXFCbG1kMmxUWjIyclNvMWFnWmU0?=
 =?utf-8?B?VWJFNXlnM3dTNG9kUXg2bWhFb1YwTHhYaHI5b0xtVmVtZVNNb3o5c212a3Jr?=
 =?utf-8?B?V3FyUys1YTFHQzhuU3QzYkx0U3dwR0Z5Q0hkSk8zNEhPOW4ySkVybE0xeElp?=
 =?utf-8?B?T0tSNkJDZVNJYS9ieWdBMUpTcmtxcHBMVVNiRC9zTmdISUJmTkpmdlRKSGQ5?=
 =?utf-8?B?UHZMV2R3cGxlcEp3THRxNHdIWWY0dVhrKzlyalBFYTMzNFhVT2lvbnhnejh2?=
 =?utf-8?B?R3o2STlhUjE1aG1RaXc5Q3dGdXhkU2pONjQ2MHBuanJBVTJZUUppNDR2UklI?=
 =?utf-8?B?YjBVM0JLT25iL0RzRDRnSGd0aG12NGtYczJITStKeEpTWStWS0RDdTcyNUZS?=
 =?utf-8?B?c3VaeDY5UVpGMnFQUEk2d0lhRDhNTXNkczZtMFA5ZERNZHZKNmYxWTluVmhT?=
 =?utf-8?B?aEU2elByMjBWZVRnQmZYaFdXQWo0UTkzbjkxcTZHUjBSNjhabGhlUVpodUpv?=
 =?utf-8?B?UUJXQ29jMXVZOXd6S2Y5dGlaU3U5dC9LU2FUMnkxd0VwL25Xa0hGRmJrZUU5?=
 =?utf-8?B?d3FIb21NZFFUVjVjcHlCRk9JbXE4T2U5Yk82VTRuc3Q4SlI4RDdySWY0ZXRj?=
 =?utf-8?B?SUswcllNUTNKZEl6VGo3aWU5T3NpSFZMUmgwaFI4LzBwNGxWTzgxL0prVUtR?=
 =?utf-8?B?R0gwV3psRXhhenFTYStsVSt2blRPR3YrVHVRdDN6WXQwMzJ3ejRDa1crdkc5?=
 =?utf-8?B?K0c4Mzd4K0tSWXpmUDFKQ2lnMXlEdnR2YUtVd3d5ci9lb2hnNWJIZUtBV053?=
 =?utf-8?B?aVd3T21ldVVBOSsrY25kR1JzNUtteXlMYWxYcHVQZGF2RXI2VUpRUnZUOVNn?=
 =?utf-8?B?M1orVm1wa25oTUNLeFpyODhKZFF5aUd1dkUwZFA5blpSUTl6WFRKTGRCVmhv?=
 =?utf-8?B?ZFh3dWRXaFlRNXlUSFBrSmMzUmw3UzNldGFVM3I2ZkcydlFqYW5vdFIybVZq?=
 =?utf-8?B?WkozQlg5dDYxVUNYRldDenZWY3p0a2lVc1FpQXF2Ung3Z3RjeXVtdml5L3JY?=
 =?utf-8?B?Z1kzT3gyK0F1TEZQK1g1ZEh2S0VNSmhySXk1Tktta1dMMkZTaXFta255YXcx?=
 =?utf-8?B?bGN3U1FvRUNyWEZhc0V1Y2ZicVVqUGNxdFR4OGJTRWY5UkUxdXJNUEI2c3Av?=
 =?utf-8?B?TFpBVW43RXNJaDB0NkNGUFN6VVNHQ005NzFWaS9jM2xNb3FOVDBZRnJyc3lX?=
 =?utf-8?B?d09Pc0ZETEZacStQa2dHaG5XV0NsSURZVlNhZnlIMzlVeFprTk5FRkFPOUU5?=
 =?utf-8?B?SmNZUDNJVDN3MHFydldISDVYaWs3K2p1VzVoblIrRWlZblB5dG5Vb24yUGdX?=
 =?utf-8?B?bm82N1V1bi9hMzN6ODluUGFWT3IxNFpvR01KMm9RVGJZRDNGNitvVUlYVHI1?=
 =?utf-8?B?alJCL1hUajZBRko5TGNEMXBkQmxYZEJYeDhmOG13SVVtSWlPYkFSMkNxbDNC?=
 =?utf-8?B?WENQODc5WEQvenk4VkR4WEMvNzV2VkJjMGcyamUveTBXc3VrL3p6SHkxQmIy?=
 =?utf-8?B?N1ZnVjRqWW5PMTV4WVVUcjFUOXBPc0p3bVJDRWhMQzRWbXE4Z00yUEprSzJa?=
 =?utf-8?B?VnV4MWRKNjVVOUl5dGNFRlZZRTliRzRHUEM3a2NhNmFnbWk0SWwrWWVITUsy?=
 =?utf-8?B?K24zREJVU3lrMEFQMjRXSlg3c2VCNW01Qm55Ums0SW9XalVtUHZ6UEczT3cw?=
 =?utf-8?B?WldzcklOTFViTFJVWDFrVkozK2FWRWRlWDJSelF2amxxb2NoNHBuNlhhd3pi?=
 =?utf-8?B?ZWZXdE8rS3VCY1RjY3BPb2dhWm1RaURJeGpsUzRCNkt6eTdVL0JETHJnMkNs?=
 =?utf-8?B?NUZ1K0w0SWg4ODJvcFY5anJzaFQ4QkxmK1pmNysxSVpSK2pyb2w0cTBGc3Fj?=
 =?utf-8?B?R1BQbmMwTGFGOC9rWXlLZWUzOWF3Zm5ySWk4WHZJV1N0Z1UvUlloVlZWRUtv?=
 =?utf-8?B?S3Zmb0FQRFNFRkZNUUhSc2I4TUJkdmJ3QTUzQUNLR0xkYlJ3dEZ3dU45SDRH?=
 =?utf-8?B?d0JuQ25jaGRaMHFMU1pYNFd1NjhpNE5NN29UcEZNKzZlbmFqZnhpYktuSlNN?=
 =?utf-8?Q?DmJLos241ZE2ZZDs=3D?=
Content-ID: <7A251102EF45534DAD2BB1E6B0AA26E8@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BfHF8jFN6s6aoIGnkG/usQUGmOhSHV4Qoe5BX59cOuOwhwKMAuOE5ZejlX+S+8HsgSYRxvJFHEmhTvtij8jsv6CVsMvOHF+Dcuq4rx6wayjrJBUBM6mk3cL9537UF4zj8k6Le8AEmxinhyZjsmZGjtQW9Miu6A0S9eQKoH3U8LHVBV2CTJyefDbPaDwGZ+KHvTG+i9F+yJrQuN7mcPx/khSulMrjJe3xGyB17tB/V7Qo7m0XGs+f4dfyzZtfk+Tj/nPlzj4GvQln9HL8ZiPZk61FmBHm12KjU4V626cOF5cM5oJT/jxrnc1TH3Wa7tIFibnIYsLHL2aWIYCFzgN+HA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889dbcba-30cf-4e8b-63c7-08df0cd93d81
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 12:12:08.9026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gj81vlzg9QuDvt8OXPBldvnzJsiJ2LZRAR6Rprqbcg+SP1AJOvKNnHQEUspQ4oUO3v0jcG/5rpNmP7++ItMCbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB890013
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] pmc_core: cover the PkgC LTR blocker counters
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

V8KgZG5pdSBwb24sIDA3LjA5LjIwMjYgb8KgZ29kemluaWUgMDbiiLYyOOKAiSswMDAwLCB1xbx5
dGtvd25payBBbmRyZWENCkNlcnZlc2F0byBuYXBpc2HFgjoNCj4gSGkgUGlvdHIsDQo+IA0KPiBj
YW4geW91IHBsZWFzZSBzZW5kIGEgcGF0Y2ggdmVyc2lvbiB0aGF0IGFwcGxpZXM/DQo+IEFsbCBD
SSBpcyBmYWlsaW5nIGF0IHRoZSBtb21lbnQ6DQo+IA0KPiBodHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL3Byb2plY3QvbHRwL3BhdGNoLzIwMjYwOTA0MTI0MDQyLjIxMjA2NS0yLXBpb3RyLmt1
YmFqQGludGVsLmNvbS8NCj4gDQo+IC0tDQo+IEFuZHJlYSBDZXJ2ZXNhdG8NCj4gU1VTRSBRRSBB
dXRvbWF0aW9uIEVuZ2luZWVyIExpbnV4DQo+IGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20NCkhp
LA0KDQpyZXN1Ym1pdHRlZCBhZnRlciByZWJhc2luZy4NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpJbnRlbCBUZWNo
bm9sb2d5IFBvbGFuZCBzcC4geiBvLm8uCnVsLiBTbG93YWNraWVnbyAxNzMgfCA4MC0yOTggR2Rh
bnNrIHwgU2FkIFJlam9ub3d5IEdkYW5zayBQb2xub2MgfCBWSUkgV3lkemlhbCBHb3Nwb2RhcmN6
eSBLcmFqb3dlZ28gUmVqZXN0cnUgU2Fkb3dlZ28gLSBLUlMgMTAxODgyIHwgTklQIDk1Ny0wNy01
Mi0zMTYgfCBLYXBpdGFsIHpha2xhZG93eSAyMDAuMDAwIFBMTi4KU3BvbGthIG9zd2lhZGN6YSwg
emUgcG9zaWFkYSBzdGF0dXMgZHV6ZWdvIHByemVkc2llYmlvcmN5IHcgcm96dW1pZW5pdSB1c3Rh
d3kgeiBkbmlhIDggbWFyY2EgMjAxMyByLiBvIHByemVjaXdkemlhbGFuaXUgbmFkbWllcm55bSBv
cG96bmllbmlvbSB3IHRyYW5zYWtjamFjaCBoYW5kbG93eWNoLgoKVGEgd2lhZG9tb3NjIHdyYXog
eiB6YWxhY3puaWthbWkgamVzdCBwcnplem5hY3pvbmEgZGxhIG9rcmVzbG9uZWdvIGFkcmVzYXRh
IGkgbW96ZSB6YXdpZXJhYyBpbmZvcm1hY2plIHBvdWZuZS4gVyByYXppZSBwcnp5cGFka293ZWdv
IG90cnp5bWFuaWEgdGVqIHdpYWRvbW9zY2ksIHByb3NpbXkgbyBwb3dpYWRvbWllbmllIG5hZGF3
Y3kgb3JheiB0cndhbGUgamVqIHVzdW5pZWNpZTsgamFraWVrb2x3aWVrIHByemVnbGFkYW5pZSBs
dWIgcm96cG93c3plY2huaWFuaWUgamVzdCB6YWJyb25pb25lLgpUaGlzIGUtbWFpbCBhbmQgYW55
IGF0dGFjaG1lbnRzIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBtYXRlcmlhbCBmb3IgdGhlIHNv
bGUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykuIElmIHlvdSBhcmUgbm90IHRoZSBp
bnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBjb250YWN0IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSBh
bGwgY29waWVzOyBhbnkgcmV2aWV3IG9yIGRpc3RyaWJ1dGlvbiBieSBvdGhlcnMgaXMgc3RyaWN0
bHkgcHJvaGliaXRlZC4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
