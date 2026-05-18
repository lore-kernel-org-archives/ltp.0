Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976CFCD4F3C
	for <ltp@archiver.kernel.org>; Mon, 18 May 2026 08:12:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB70F3C5973
	for <ltp@archiver.kernel.org>; Mon, 18 May 2026 10:12:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F6DA3C0848
 for <ltp@lists.linux.it>; Mon, 18 May 2026 10:11:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CF8B71A004E4
 for <ltp@lists.linux.it>; Mon, 18 May 2026 10:11:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779091914; x=1810627914;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=yKCZ/Um0Y4liSYl5yNJvxWcaCwzlfkYiF2xrukSQHGA=;
 b=ac8osB8ga0NKSOnB6gKUxJc+I+00hd7zjHyQkvIWJsAIOA2jj9uV5gO8
 3J+uRvXYyx2Hb2b8bhpuQ35OSC70qM58eViH/mH8Bju+Kqf2Rb+6kw1yq
 a4g9BllsKUEYbzUsWrVpsJ4BoDRvwoU8YzewIdALlShP/8zm4GdlWPNXw
 zohmvuCu1ljkgNpc993kUqJ+Anla2sii2wLlYRBcX9sbI++u8sPeSg/ol
 4VdItY915Jv1z5j1tV31RsXSjt6Fvt7OVMDw5gIvpAb/kTHC49+fS21+m
 1Y9Jb/HvBTDU25Hs8nPgCq5kNFEMMMrn4xUNH1PF5InXRFqe2RkiGjg9t A==;
X-CSE-ConnectionGUID: 1HCIDL4MRX6eDzWnpKpw0g==
X-CSE-MsgGUID: rUtPDcypTr2NyYBJu5bpCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="90520896"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; d="scan'208";a="90520896"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 01:11:48 -0700
X-CSE-ConnectionGUID: l2BewdVLSNy+3IWDyhoneA==
X-CSE-MsgGUID: sqiAseBKSlOIMi8RAF0naA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; d="scan'208";a="239226400"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 01:11:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 01:11:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 01:11:47 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 01:11:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaEsKNnCKrxH6NB3joU1N4IcYccl20X4M26Mk4d7Rv1lmZgJMGGL0x1OLwGqlDBCmmkjRLtiV0RZj/egmdBanPvkptf3a8hFYUzp0ShKMKbvfxbX+VrwwTJUWtMffgsVFPc8fiRMpcHoY0iWL9lJ9gUGBp4Ylzma6U6qXRCJq4mUTPLceCnJVrIac0dlmspsNJTCkyyVukwOm36/fqe9BSCB/fLPio2w4N6r6bWTL9hYNy4J92FX12NcDlPSA4B+JGbCGsksOPmo+XujTpmxhBK0rel9c71RAYNM79hffraY2Td0AVOGb122Sn292BnTUkTLbqE0L3egtkDbvn4nrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+8Rmfzqjr67rNOTejqYqW/GISDcOSUaBlymh5NQ9iM=;
 b=VTkpV0zTJdAZSgW211Pr0aWUuDneThS7b5bHwA8pocfYD167UcM/mb4P1nPfDj4Mu5Ctw++QQxz0b2/0mLAxhIqYkTp2pj99HYUdtR6b8BiQav9TvB3ktyRFnUiffMleyZQDrPI7DG/Q8myIyKswmi04AHU2dzKzWNc05s0iMpmUjZERsohEkiWsaTQh4L57zSBHRUhImiAYNGesWaliNE/VydEotGE432rati8jIa1IUaIppBlJh0JIS8QPDQsOdrdpQWyJYdadxe+EhpmnyxQ73WSRERfpVRsLewtb81j5FkICj/ALFRXQx3OcKcXfz17VVvrgQaBfTz1SWX7+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6)
 by DS7PR11MB9475.namprd11.prod.outlook.com (2603:10b6:8:26b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 08:11:45 +0000
Received: from CY8PR11MB7012.namprd11.prod.outlook.com
 ([fe80::9643:8816:882f:3c73]) by CY8PR11MB7012.namprd11.prod.outlook.com
 ([fe80::9643:8816:882f:3c73%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 08:11:45 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "linuxtestproject.agent@gmail.com" <linuxtestproject.agent@gmail.com>,
 "pvorel@suse.cz" <pvorel@suse.cz>
Thread-Topic: [LTP] thermal: add new test group
Thread-Index: AQHc46yvXeKfCE06bke+L7mzmc0z47YPKtEAgARJwwA=
Date: Mon, 18 May 2026 08:11:45 +0000
Message-ID: <d1e90d8d94fd4cb58f34cbff4a07b49257195129.camel@intel.com>
References: <20260514133446.144550-2-piotr.kubaj@intel.com>
 <20260514141912.4030-1-linuxtestproject.agent@gmail.com>
 <20260515144242.GB40164@pevik>
In-Reply-To: <20260515144242.GB40164@pevik>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7012:EE_|DS7PR11MB9475:EE_
x-ms-office365-filtering-correlation-id: f35a4141-a825-40e7-fd83-08deb4b51a25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|11063799003|18002099003|56012099003|4143699003;
x-microsoft-antispam-message-info: rGQrTwVmkOFM5fC9nNFo64CfZtzIK1NKEeAKAYNNlh2O/R1BbNYHL0tiJHH3lrh/oyFw8eC1VX7P+ZlX3ukGN7XojctLmgV8N3zzmOCYyNW23ZyQR9dZr0AlRsAFycmgdZHRkh101D6ji28WmZK/MH3ViI65MzmMW76y89WXklVAKKiMI1oF6mn2uhJOui70q1w2Sym5HRPzwDta4Md3AvDVp03zhY83hNCmG5dLndRQmrr7wgl6GuorxqGYMe7MX8bC+fmwbFp1FAR3XhEGVeLhwxZI37NqjkhJxR1dSwMwl5ThYHZm2BKiaq36GSblMuTeImFwiy7u7jC7WSHF+G1aaWdcsdtHfiddGf7etgXw3CI0jhtvDGPWCVpyLcKSxllUf+gB93iuxhPC8P8d0KKq6HeD+q28JR9QWKeVivibbwZZpa+4H9HmZYOlSn471uyDJCtGsAjaoa1/PY0anO0itRmHVnB3G+8ZBzeBsZH5l1vVJXpdYZT3OjxZnSRjyojKQkaGM4KssafMkJ1ror1SHla8doMASgYGFXDtg9ds423D+dwoDC/CowSjufjQFSQXYQVC0RzXhK2IZtTAUoXjaicC7nqseZ6qpOKhQQB4YL+CSO7uRfP1K5XxEBzsXedc9187LJYSnc0fs95Xpj7hi8NiyEphcYkn62N9/UaOv0UXwp8UnkvYnSIQAPNFUOzlZ1DQ1CqqyStpBl5YNF5xAshSwq4g0HzfylGwC8tNZEygJa63FaNK9y9U5EeS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7012.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(11063799003)(18002099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0d6UUtXYjRoM2xXUFhvR3o3Zml6UmNMME5yc25SN1JRMzljMEQzdnp0T3hk?=
 =?utf-8?B?dU1rMmVMNEZPZ2tpQ2dFaEorWktIdFpCWDJjdmIyR3NHbHhCMDJmNE05cnZj?=
 =?utf-8?B?WU9ya2RXMGhQSnhlbCtidzMvVm9ScFRLNUltOUNjdFJtN2gyenRoL29EUGUv?=
 =?utf-8?B?ZmI1S0wyRCtBZS9CeEt0UzVyWCtsR1cyc3N1S0tjMUFReTF1Ui9xb1VVZGRx?=
 =?utf-8?B?T3JLK1Y5V1dxL05kTnE0cnVEaW9OU2lVM25VTk1VSURkd09vMEUzdzlkV2lw?=
 =?utf-8?B?dE0wandjSU1Ua0lSNm9pZUhoYVlmcGdKSnoyR3o5SEYxVDEyQndtcDBGRDZF?=
 =?utf-8?B?TjVEOEFoaDhCU1NnYzdNUnczYWVuajJKNmk3OW05WDRXTkNGSCtKa3ptdkxN?=
 =?utf-8?B?VGFQREk5eFdSemx2dGlIYzJ1U1VZK3doVjFPMFVKdHlQNkxYY2R3T1dhelo3?=
 =?utf-8?B?cUZGUVlxdUFPUzRmWlJnQ1h1cWJsTFJlcUZzS1krYzlBeHR0ZjlraERaOFI2?=
 =?utf-8?B?SjFpcmF3NXV6ZnNWVGhLaE1JZVgrVFFNNThqQWJxOEp0UVd0aXkvcDhHRnd2?=
 =?utf-8?B?anZYMWIvZytING9MRWYzYjVtT1pzc3lkeFByVEJDZHRLSm5hQ0FIanduVFVD?=
 =?utf-8?B?WTJMSlFNQnZaUzJIVHZON3pzTFFCYWhrRXFTNGk3VzdrbCtkYmNXTjd0UnVt?=
 =?utf-8?B?djdwcEE5OFFmdmtZU0V6ZngzcWdIUGx1NGxDMnlFR1JBbndQRkRRcFJhSThK?=
 =?utf-8?B?UVpmNUJRdHFBZ0ZTRUdHRlhpVjJScTgxZDcxclcyOUV1QklYSFNmRkFKc0p2?=
 =?utf-8?B?WmJKR295TXVPN0xyOTVDcXFpNC9CL294Uk9ELzZrV05rSnNpV1JMaUhFWk1o?=
 =?utf-8?B?TlVQMGF1cnNwRDRURDd4ZjREV2tZWkZLMXZnTmVteEMzd3pOZEp5MjhLNEJE?=
 =?utf-8?B?Q08ydEoxODR0WjE0b3d3TGp1WDdoZjdXVFhQMDhKT2haVDJMeUFYY1MzWHh1?=
 =?utf-8?B?aEg2Z055RzBnUkE3Qnl4OEVPR1c0Q0g3T2owdjZsaVNiaEdqSlgzSHBScWJF?=
 =?utf-8?B?enNkUGxUTTlyNlQwK3VhTU8rdkU0bVZTT2s5Tk9ydCtWUVlaTFphS01JRzRG?=
 =?utf-8?B?c0tSRVUxbE9vREk0VGVkMGdPMjg0ZGdHdWdIOWZyelExOXEyVXlnNzEyOHN5?=
 =?utf-8?B?bWJuMGF3RjZxVmRuUTh6MUgwVU9oakZ5VjZScERFRUlEM2k4OG04dCs4NndH?=
 =?utf-8?B?ZHkxV2tmSmJiSzVnWTV1NlF6ZEFLcHUzcU1ZWlFxcmN6YXg1Tmh1ZkVTbWtF?=
 =?utf-8?B?Z3RxZWpnYlNPQWRianM0MkdwRTNFcDZ6aU5ON1htS2N3eUl5cDlXMVU1Z2pW?=
 =?utf-8?B?ei8wUzUrZE9QYW5kN09adEdGY3JUb2lDUm9INnJKb1dEL0RKcXB4bjNZMlRK?=
 =?utf-8?B?NGJPNGdGNUIvUkkvZHQwVlIzTm1nYnFwODkxRGtLUW5MSk1OMi9lL0F3eXpT?=
 =?utf-8?B?aklBdE1hbGM5YzR6N0lnQ2xXSzB5UXBGUE1QQkNmWnQ0R29WbkNVb0QrY2Ro?=
 =?utf-8?B?L0ZBeDBnUDZlbXJqME1zaFEvWVN4dGt3ZDR0Y1NKNWI2aUtyZFYyY3U5WW13?=
 =?utf-8?B?bWZTTWZwWWZMOFdybkU4b0pHU1lYT0FvYkRwdGJGampUK2xpU2x4MDVIbzcw?=
 =?utf-8?B?cUduWGZ4T2s0TUVod3dSd0JNUmJSQzYzV2taZlVJcU4vVkl1ODIyUkNYaXlB?=
 =?utf-8?B?RGtrUk54Vm16Q0EyNHZOdERmUUVqcmlHL3RRSlZtOTdRM3J3VHVDWVJiemR1?=
 =?utf-8?B?VEo3K0hCVkxSUGVRNTYrNUlVSnhCZ3BzYTBOMXlKbTh4dTRjZXEvQXl2UTJq?=
 =?utf-8?B?SHp1R1h2dWlXbllMbjdMSldaUUFyeElFK2ttQy9Td2lGTzhhaDUxcG5UQ1pS?=
 =?utf-8?B?Ym80MlJ2ZEtLN3hKZUZXWG1EOWdMMHV1MktBS3hFbm52T0lYTGZ5bDZUVE1X?=
 =?utf-8?B?c3JUclg0VXA0cnVDU25iRnNOTEl1S1BTMm9yTU1PSWF5djJmKys0NTR2czlt?=
 =?utf-8?B?MzEzQ3lLTE51N3RBWlBONFVsRU9wcHh3Q2VBZTh3SEVBS1FRUlVnazVzRnox?=
 =?utf-8?B?ZG95aVNnRk1ZRUh2NldKQ2c2M3hBL0FkdG1rb1VrYkRJUzNMbEdwMklWV3po?=
 =?utf-8?B?eW5BNUVyck8rZ2FJaUhsTUF1TG1yMWIwWlFVOTFJck1LWHRMaVBLQytZY0R3?=
 =?utf-8?B?WUppVkIrNkRTc29FdSthS0xsOCs1ZnNsOU5TcDdUVTNFTzNBMHVucWpMNnRk?=
 =?utf-8?B?K2cxcStyUk1HWmFmYk9IQ0JLWjdWREs0emo2UGJKZXNJUGpndjRnei9ZaEho?=
 =?utf-8?Q?St8m2b3k5fc+AUTk=3D?=
Content-ID: <76F046082BB39D4AA4641CAE0D92CD11@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W3ACaZIY/DChgGklmTgMRFXqCNVFbMmHomkJxXq9rt958bjGiWxTCRDT4IdvaJWGntJzqlHDqaJZ4ZbM/ppeRmotBHoFzdk+ygQ3r0XKgfL/I3xabblpohhhgtVkn/a5yO0M1KTZcFhW9RsGlf+YnxUDx+1ZzggyBTIWVU23U7gFnkE6qlbueUkIJE4E7yEy6bQw6BtCTQ2j8eyZM4/GUDGtjjzoEJL+G7gsJHi+nuqeBC8Ufl6HJAZKDKhVe6Fdm1R7mYw0YxItiOOt0Exos1Hg7CaJBl6evN3J7Uo8GMpjP13WbblOSf9y6CF2VuJgAZdJnN9tUN06X9AuHLX9yQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7012.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35a4141-a825-40e7-fd83-08deb4b51a25
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 08:11:45.3671 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RHZ+UuWr64V+BOo1GZ333TU3sM3amkhd3sTyvPIwTrkvvxUtqw+gVln+GYFczTJiL5LpClS+4dc4+7nERmTp9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9475
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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

SSBzZXQgaXQgdG8gMzAwcywgYXMgcmVxdWVzdGVkLCBiZWNhdXNlIGF0dGVtcHRzIHRvIHNldCBp
dCB0byA2MHMgYW5kDQoxMjBzIGdhdmUgc29tZSBmYWlsdXJlcyB3aGVuIHJ1bm5pbmcgd2l0aCAt
aSAxMC4NCg0KMjAyNi0wNS0xNSAo6YeRKSDjga4gMTY6NDIgKzAyMDAg44GrIFBldHIgVm9yZWwg
44GV44KT44Gv5pu444GN44G+44GX44GfOg0KPiBIaSBhbGwsDQo+IA0KPiBhY3R1YWxseSB2MjAg
aXMgYmV0dGVyIHRoYW4gdGhpcyB2MjEgPT4gc2V0dGluZyBpdCBjaGFuZ2VzIHJlcXVlc3RlZC4N
Cj4gSSdkIHByZWZlciB0byBtZXJnZSB2MjAuDQo+IA0KPiA+IEhpIFBpb3RyLA0KPiANCj4gPiBP
biBUaHUsIDE0IE1heSAyMDI2IDE1OjM0OjQ3ICswMjAwLCBQaW90ciBLdWJhaiB3cm90ZToNCj4g
PiA+IHRoZXJtYWw6IGFkZCBuZXcgdGVzdCBncm91cA0KPiANCj4gPiA+ICsJd2hpbGUgKHNsZWVw
X3RpbWUgPiAwKSB7DQo+ID4gPiArCQkuLi4NCj4gPiA+ICsJCWlmICh0ZW1wID4gdGVtcF9oaWdo
KQ0KPiA+ID4gKwkJCWJyZWFrOw0KPiA+ID4gKwkJc2xlZXAoc2xlZXBfdGltZS0tKTsNCj4gDQo+
ID4gRzI6IHNsZWVwKCkgdXNlZCBmb3Igc3luY2hyb25pemF0aW9uLiBUaGlzIGlzIG5vdCBhIHRp
bWVyIEFQSSB0ZXN0DQo+ID4gc28NCj4gPiB0aGUgRzIgZXhlbXB0aW9uIGRvZXMgbm90IGFwcGx5
LiBDb25zaWRlciBwb2xsaW5nIHdpdGgNCj4gPiB0c3RfdGltZXJfZXhwaXJlZF9tcygpIG9yIGRp
c2N1c3Mgd2l0aCBtYWludGFpbmVycyBpZiBhIHRoZXJtYWwtDQo+ID4gc3BlY2lmaWMNCj4gPiBl
eGNlcHRpb24gaXMgYXBwcm9wcmlhdGUuDQo+IA0KPiA+ID4gKwkJCXRzdF9yZXMoVElORk8sICJD
b29saW5nIGRvd24gZm9yICVkDQo+ID4gPiBzZWNvbmRzIiwgQ09PTERPV04pOw0KPiA+ID4gKwkJ
CXNsZWVwKENPT0xET1dOKTsNCj4gDQo+ID4gRzI6IFNhbWUgaXNzdWUg4oCUIHNsZWVwKCkgdXNl
ZCBhcyBhIHN5bmNocm9uaXphdGlvbiBiYXJyaWVyIGZvciBDUFUNCj4gPiBjb29sZG93biBiZXR3
ZWVuIHpvbmUgdGVzdHMuIElmIGEgbm9uLXNsZWVwIGFsdGVybmF0aXZlIGlzDQo+ID4gZ2VudWlu
ZWx5DQo+ID4gaW5mZWFzaWJsZSBmb3IgdGhlcm1hbCB0ZXN0aW5nLCB0aGlzIG5lZWRzIGV4cGxp
Y2l0IGp1c3RpZmljYXRpb24NCj4gPiBpbiB0aGUNCj4gPiBjb21taXQgbWVzc2FnZS4NCj4gDQo+
IFllcywgY29vbGRvd24gY291bGQgaGF2ZSBiZWVuIG1lbnRpb25lZCBpbiB0aGUgY29tbWl0IG1l
c3NhZ2UsIEknbGwNCj4gYWRkIGl0IGZvcg0KPiB2MjAuDQo+IA0KPiBLaW5kIHJlZ2FyZHMsDQo+
IFBldHINCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQpJbnRlbCBUZWNobm9sb2d5IFBvbGFuZCBzcC4geiBvLm8uCnVs
LiBTbG93YWNraWVnbyAxNzMgfCA4MC0yOTggR2RhbnNrIHwgU2FkIFJlam9ub3d5IEdkYW5zayBQ
b2xub2MgfCBWSUkgV3lkemlhbCBHb3Nwb2RhcmN6eSBLcmFqb3dlZ28gUmVqZXN0cnUgU2Fkb3dl
Z28gLSBLUlMgMTAxODgyIHwgTklQIDk1Ny0wNy01Mi0zMTYgfCBLYXBpdGFsIHpha2xhZG93eSAy
MDAuMDAwIFBMTi4KU3BvbGthIG9zd2lhZGN6YSwgemUgcG9zaWFkYSBzdGF0dXMgZHV6ZWdvIHBy
emVkc2llYmlvcmN5IHcgcm96dW1pZW5pdSB1c3Rhd3kgeiBkbmlhIDggbWFyY2EgMjAxMyByLiBv
IHByemVjaXdkemlhbGFuaXUgbmFkbWllcm55bSBvcG96bmllbmlvbSB3IHRyYW5zYWtjamFjaCBo
YW5kbG93eWNoLgoKVGEgd2lhZG9tb3NjIHdyYXogeiB6YWxhY3puaWthbWkgamVzdCBwcnplem5h
Y3pvbmEgZGxhIG9rcmVzbG9uZWdvIGFkcmVzYXRhIGkgbW96ZSB6YXdpZXJhYyBpbmZvcm1hY2pl
IHBvdWZuZS4gVyByYXppZSBwcnp5cGFka293ZWdvIG90cnp5bWFuaWEgdGVqIHdpYWRvbW9zY2ks
IHByb3NpbXkgbyBwb3dpYWRvbWllbmllIG5hZGF3Y3kgb3JheiB0cndhbGUgamVqIHVzdW5pZWNp
ZTsgamFraWVrb2x3aWVrIHByemVnbGFkYW5pZSBsdWIgcm96cG93c3plY2huaWFuaWUgamVzdCB6
YWJyb25pb25lLgpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIG1heSBjb250YWluIGNv
bmZpZGVudGlhbCBtYXRlcmlhbCBmb3IgdGhlIHNvbGUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNp
cGllbnQocykuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBj
b250YWN0IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSBhbGwgY29waWVzOyBhbnkgcmV2aWV3IG9yIGRp
c3RyaWJ1dGlvbiBieSBvdGhlcnMgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4KCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
