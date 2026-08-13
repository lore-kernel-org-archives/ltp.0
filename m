Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351B8C5CFDB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 10:46:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96D7E3E6BEF
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 12:46:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FA983E249C
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 12:46:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F41E06001E0
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 12:46:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786617967; x=1818153967;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=txynWIu5S8QpyDWWpXijS/UHvi4VKmXsYuoPXaDXPQ8=;
 b=D9TguWn1c0G+VXzUZDZXv0N4zihsN2zW7V6n6pVRGeMSQtUggiil+xfI
 9ejokr3cRx+6JGGZ1YEo5XxVpR3FrfuLISEWzGiRNvSQgWtnsw6Mjm2xR
 vlzO4DpVWFVZtN86zZmALJGB9xt6DHbIzSlvZdBJHxDSZsfDxUAYXffK3
 pci4Lx5R0Zl7uHKuvFTgqpo3aIq3jBmWocW3qtVIPEi8AhS66HSrvHyFs
 TuLoqUx+CJkLrED9XmcQ1QpF0ek4BjyesdPG5if6zvGRsZmNsxhX6T1YD
 zkjScDt5GeXoIMOQALWJa2XZtAug0/RuP+S/mW9bIzY+HlZt9lbG19B5u A==;
X-CSE-ConnectionGUID: t+gSoP/DTgK9qpvpPo5slQ==
X-CSE-MsgGUID: 91umA2BSQHmTiNgL8oQYwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87405139"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="87405139"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 03:46:05 -0700
X-CSE-ConnectionGUID: xzoJrjgjQ/6uVYLpvzjf5Q==
X-CSE-MsgGUID: +C/KXf7ES5Gfp0VaPMqf8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="263934732"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 03:46:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 03:46:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 03:46:04 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 03:46:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJEYiwZwt/GhBgatWcvuHmvix0A2IMQj5WbQVTYpgWpEK42hlwdrFRQWjRf6rPa/MxsXY2NCm4eCWvF6P3/iFbi4XXsiSZaAoHUKtxUsgRbSMkw1ZK4aaaNOxIqLbWl8S9wj+RgBw9Wufj6hWe7B/dMrWhl63uM91o+xhRgllI4pSf/J/G7P2euMq4DvY29viPVLCOCtGjKlpyWhzA1Rhs/qlIZ2UAOaKmE2B3M9LYUCNI6VrraFMN4lHTmyJtg1tD1OakOqGLMoUhuqhVEGPlFj5sr91OIRfEig9TR4vM6Xpd8D6ppH/8kWGVS4rTjdPGKXpI7+urdOIaG46JXxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oy8dtcrIsKISGFJ6vDIPVgQB3nfyPobkJ6SnMXgGnWE=;
 b=KYciGqq4u0jci/gEj/XZX78lYu8kXzCxU4j086H2qM9UzQ0Xk7gh48g7eBgQEL/keUMZTIFBGHFEP+OLymYdYsq2gCIePNnclgs0YsM+7cgOa+GEgWX8tCruk/bfL1hRYIoT3iegV9y7uoxk2e9IhRyJgA0YiEPOb+sAT50wN7Njx6orJzjF7oo62DBVVddKmI4wlUNekLUhV9RJWaeSvmLFDqDxVZ8HZLN8yIKbLeruvF62AE09hLIo2WkhVtGub7m4Qwcvzyiw9ankaGyj7CDlKq1XQzS2EBNx9c7fXDgJ+zxtBBpDIdrXZcNmmyG8XBS5FoULCjG6RXxJp6IdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by IA3PR11MB9375.namprd11.prod.outlook.com (2603:10b6:208:575::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 10:46:01 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%6]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 10:46:01 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "andrea.cervesato@suse.com" <andrea.cervesato@suse.com>
Thread-Topic: [LTP] [PATCH v2] pmc_core: add test for
 pkgc_blocker_residency_show
Thread-Index: AQHdKwiVvudNFHqF7kGa4yczy+3gT7abu9yAgAAP7gA=
Date: Thu, 13 Aug 2026 10:46:01 +0000
Message-ID: <3d34858317be0dca281e4aec24ac3cfbf473df61.camel@intel.com>
References: <6a7d930c.fe7f0a4c.7cd5f.b2de@mx.google.com>
In-Reply-To: <6a7d930c.fe7f0a4c.7cd5f.b2de@mx.google.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|IA3PR11MB9375:EE_
x-ms-office365-filtering-correlation-id: de3b78d2-97e7-4aba-7709-08def9281125
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|18002099003|22082099003|38070700021|10067099003|11063799006|6133799003;
x-microsoft-antispam-message-info: o3AVDsCceCiSUAXBCba4ASoq9l4dF9mlipuVykOk4fkjTm70giLlHGyryosdnWg564oFLLH3Fog7uFL80Upctll2cynmSmKvZZ90reTAIL7eP5w/GqG3aUq5YJb2TGjecZInhfSt82VZyQQtPIcvxx1W0o/u4pWwWy41EmDjTTuO+SbuB+UtTzem/q8zo4DkZZIL6TovDWgSHvwTsACpYGjARimry6HwDUn6c7rOVCToZ8LCrMdN7vai6IJ4QydO72I/a65qhJMGH4zFAqRlNG5+tJZW4AF0isg7dsERT07oN4L4CUHH1wHMhUoHVLRm3RrD0LBKLeOGNB7xmBsbevrvZaW0kHEzmhZnwjEP9hiulPLeNPkbGhdnH7TxxEae4XnB+Vo3WtEg3wpChJvIKqvCcFReci+NBmOnGHUXEb7fQNt5Er3HsoinsQpSRbYdPlJw317WnbH35SlZC1uszogddectlZeaG8wkvco8q66iszLxgynRasjGZazu36AYlQHJNtTPpqIsxaM76rBWI9M6UjvTFVQiR3SiMKyvj13cyHC+WgzNb65v4rwO2og9a7cTRpcrRy1le4tcEyIKel1AxJROj9Iv0eT50a77o3I1/9U/NTJyZKFGwOY9K52RxKii1HfQcc5HYMs1CXFhBl0XJZM22j0FuFD9PWtVICg93JDRwYSSFqsQgBqIFvhginYe8HsXb05AMevtbIWqNwt/Cd0CKw/wJkhTiizICFU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(18002099003)(22082099003)(38070700021)(10067099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2w2djZmcWFVbXFxUERCT3QrYzhWQ1RvV3lQR1dsRisxc3pxMFRaYVptV29w?=
 =?utf-8?B?ejM0TlJ0VjRsaU5ISFpKMmN2anh5VkRTTk1pZmtpUmtPdDhCYmw4ZjVMY0ZX?=
 =?utf-8?B?aEswcVJRaFdqM3A2REo5SVJSekcxdmJ2SXUvUTQ3ZkhoOXVxYlZVZVBzeHdq?=
 =?utf-8?B?dEtTUFBqUkFPekJQbEJ6VWlIaEgzNWh6UjZFOXNTa1hiYTZiaGtwNC9qanht?=
 =?utf-8?B?QkdYQ2tFWHFUSk1tRnJuRlArdW11eE9WeXo1L3I0am0vZW9EY0VvN0tFSVVi?=
 =?utf-8?B?SVBzdjliemJ4LzJHNzBDSUV3bXdRM2FPUE52UFF1VWgvbzNlTnlXS1Z2ZlR0?=
 =?utf-8?B?cmNmSTVFbEo0RDUzbEhhcWkrMGUreDVUTkdocUx3Y3c4ZkpxRVI4QVVOWC9i?=
 =?utf-8?B?M0pBNGxuMHpjS3pPeXdVeGE0K0J3cG52RmY0T05qbmhsK3NOeEt2dENjNXla?=
 =?utf-8?B?QlBzUXlKeS81eTd2cWsrMGRQU3U0VnAzN3Q3SXhZaGE5NFNiT1JzT0JTWnZW?=
 =?utf-8?B?ZE10NDN2aHlXcVVIOHhlMnhXdkdoejYwMjIzbXI1bnBUVHY3RHpFMVZsVVIz?=
 =?utf-8?B?ckR6dzdNcnZFZ2piT2JlQzlqWkM2UytQc0l1NE9YejluOGdlSTQ3L2o0QXJt?=
 =?utf-8?B?c0NJd3E3eHBUcVp6VWVadjIvR0hMRTErSUR5bDUra3ZDRGNJaUFmeGNXMHlO?=
 =?utf-8?B?UE14c25kRUpNOW9iTCswZ2EvcFV3dGpYNFU0cFB3SEo2K1dKTllKV3J1SEpQ?=
 =?utf-8?B?ZkRTc0NaQWIyS2c5V3ZhekJiS014SnFFaGYxWGs2bGxuV1FreTB0UDhSZ28r?=
 =?utf-8?B?dmE2SlVML1FrVVRDU2NJZHRmRm13K2pKZ2hYVGZaZUQrZTYxcFRKUk9mTk5E?=
 =?utf-8?B?RzNVU1dxYk1FdzFWTXEraVp2NHlCTHFPT2Fid0VjUTRaWkxnclA0aERhdWlY?=
 =?utf-8?B?SGhCaHREQXlVNWxMeUMySEhEcnNJUW15bWtKM21OTG9vcHVnQWgzWDRFVFlO?=
 =?utf-8?B?V0lNSTloZXl6MGdyKy9BTHluSDA4SmE1bUVWSnJmOWtjNjZYZGdWdUNuYXBt?=
 =?utf-8?B?TklEbEloSTQrTFJtT1hKSk9QVlordUdrcExFUEo1RnRVTHNHTDErMkRHRkov?=
 =?utf-8?B?ZTB0UHFKY3hVdC9FSk9HbTlYV2g5by9pMmZWNk9mTnlqWTdZL1U1Slh1MGp5?=
 =?utf-8?B?bVZoV0I2RXYxUldwWGlsVXB5dEg0MkpLMDRwT0EzWjNEeHRyTmRGdzZtYkNu?=
 =?utf-8?B?ZE9sWnl0M3VFUUd1cmsvUXNKRWNVMURBcTdyUDRnSVRNODhTWllLa1YzSWdJ?=
 =?utf-8?B?MU01QTMrREQrMWtBNUJrMkRTcnNmSkYwTGZBcFJtWmVsMTJqSEp3ck5jdzBN?=
 =?utf-8?B?ZXdhbGZJdlpUZ2FGMHNIc3hZYnlDT3IyME9uaGR5Z3ppR3k0bDAvcllpcTdE?=
 =?utf-8?B?WXplQkpva3ozSGRpNWFJYzd0QVErNHBkREVQRVdUeUVYZmU1M0w3WkZVSU9H?=
 =?utf-8?B?dXJmd3pVT0VWNUcyQklQSkRxWWlYWS84ZnhGZzJuc1pML0o3ZjZJazVUdWNr?=
 =?utf-8?B?MTl1REVxZkR4YjFTaHZ2U05ITmU3N3owaHJESytrRTU5WUZoSFBkaTIyZGVB?=
 =?utf-8?B?b0tESWxLblp6YlhlVmNRaWppUmdTUGVOUTRmR0VPRHkvaUF6YlNTV3FHV1B2?=
 =?utf-8?B?RXZxQ3djcmlRRGU4MHg5YnZCdkRzYXlJNjJYOTU4SndRZFNaNzRiMFNJbERu?=
 =?utf-8?B?eWZrTTRucHcxKzNVbmF4UmRYVE40OFN4ZWw2TStxb0NEUnZqTCtWYTF2TldQ?=
 =?utf-8?B?VmlZK1NLY3VkRk1vQkZkRkJiZ01xd0sxQkhPQWJrMmhOWU1lbmFrWEd3L2Ey?=
 =?utf-8?B?dFVqZlFTbEpWMmNtSlkwNkNXRmxIMXVVMWFZaC9PRFZ0OWNydmFHZXJUMXIr?=
 =?utf-8?B?dDNVeHVYQVdYLyt6dUF5aTVjL09iVGZ5QXkydE05UUZVaytnYXRCQUVqSEYy?=
 =?utf-8?B?by9TM1ZWTk9Hb0NpMVhNUVVKN3NobUNsNDZMTCtsL1ZUWDA3b1NkY0lhK2RD?=
 =?utf-8?B?ZkFMSitwZjJ2WjBpcHFlVmtwakxTVzd0SmhtNHZmb3hQbWJMQ2w5NGdUWHZu?=
 =?utf-8?B?VUJReWhXN2k0VFM1RCtNUzYrcGZ1VkNudzlaMHZVcUcrMW85cThIa2dBQnpi?=
 =?utf-8?B?ZE42L3ZjeFR5YW5HWXR5cmE1cDRvRjBTSXZhUzdCdEkxRHNGUWxvMWdGeFBL?=
 =?utf-8?B?aW1iQ3loMkFzeFBQL3NzQ2tac1BLVVNoQUpHakdBQyt5TnNocmc2ZTNVN1pz?=
 =?utf-8?B?OVZQTGVadEFnd2tYSjRpUll6WitHK29ZZHdJQlJES0NqNDN2TnRLamhUS0ZY?=
 =?utf-8?Q?WEOoBCi8frVsrmHk=3D?=
Content-ID: <0DBE44DEA3BF7542B7490DA3025CD22A@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rmDzDgNGlcVRH/fNpn2Cxgp4QNP88VLp7Pco6pHZI4cRtOsd4GQnv7ov7WTIMtNcenLxqKrlVREKR3i5zRZQpt+381hzZKJmzK5m1TFuLlDKIxW1YYqtYhYBD7jn0ShBWwoYAcx9quSmhDZEzbD+vKsbUuxHhG6GxKmN9+g372nQvMswOX8rgWTVjGh6SLxgH9hf0jzB86+VoualPlbPDIow0EiG3B2tPmXSWLKd1OQPwxZNuQuTJDAgVrIE1wVghsV96bbqZThSAbNzXoKH6GhGca61eTm1IZQNkbPzz6R/oERDHSJ5p6uoFeDin3l+IUhLdIlILRaznTW45N/sGQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3b78d2-97e7-4aba-7709-08def9281125
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 10:46:01.4485 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZVImvE5ralUDuiM2i2D64TZbzStHGnsRWd+YQEx4O6xzYER0PJ6aoBZ3/cyBZoB9x/B/bL6rxTFOUAZcJ7hg3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9375
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] pmc_core: add test for
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

V8KgZG5pdSBjencsIDEzLjA4LjIwMjYgb8KgZ29kemluaWUgMDniiLY0OOKAiSswMDAwLCB1xbx5
dGtvd25payBBbmRyZWENCkNlcnZlc2F0byBuYXBpc2HFgjoNCj4gSGkgUGlvdHIsDQo+IA0KPiB0
aGUgY29tbWl0IG1lc3NhZ2UgaXMgc3RpbGwgbm90IGZvbGxvd2luZyB0aGUgcmVxdWVzdCBJIG1h
ZGUNCj4gaW4gdGhlIHByZXZpb3VzIHZlcnNpb24uIFBsZWFzZSBzZW5kIGEgcHJvcGVyIHZlcnNp
b24sIHRoaXMgb25lDQo+IGlzIHJlamVjdGVkLg0KPiANCj4gUmVnYXJkcywNCj4gLS0NCj4gQW5k
cmVhIENlcnZlc2F0bw0KPiBTVVNFIFFFIEF1dG9tYXRpb24gRW5naW5lZXIgTGludXgNCj4gYW5k
cmVhLmNlcnZlc2F0b0BzdXNlLmNvbQ0KDQpTb3JyeSwgSSBzdGFydGVkIHJld3JpdGluZyB0aGUg
dGVzdCBjYXNlIHllc3RlcmRheSBhY2NvcmRpbmcgdG8gdGhlDQpyZXZpZXcgYW5kIHNlbnQgaXQg
dG9kYXksIGJ1dCBvbmx5IGp1c3Qgbm93IGhhdmUgbm90aWNlZCB5b3VyIHJlcGx5Lg0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCkludGVsIFRlY2hub2xvZ3kgUG9sYW5kIHNwLiB6IG8uby4KdWwuIFNsb3dhY2tpZWdv
IDE3MyB8IDgwLTI5OCBHZGFuc2sgfCBTYWQgUmVqb25vd3kgR2RhbnNrIFBvbG5vYyB8IFZJSSBX
eWR6aWFsIEdvc3BvZGFyY3p5IEtyYWpvd2VnbyBSZWplc3RydSBTYWRvd2VnbyAtIEtSUyAxMDE4
ODIgfCBOSVAgOTU3LTA3LTUyLTMxNiB8IEthcGl0YWwgemFrbGFkb3d5IDIwMC4wMDAgUExOLgpT
cG9sa2Egb3N3aWFkY3phLCB6ZSBwb3NpYWRhIHN0YXR1cyBkdXplZ28gcHJ6ZWRzaWViaW9yY3kg
dyByb3p1bWllbml1IHVzdGF3eSB6IGRuaWEgOCBtYXJjYSAyMDEzIHIuIG8gcHJ6ZWNpd2R6aWFs
YW5pdSBuYWRtaWVybnltIG9wb3puaWVuaW9tIHcgdHJhbnNha2NqYWNoIGhhbmRsb3d5Y2guCgpU
YSB3aWFkb21vc2Mgd3JheiB6IHphbGFjem5pa2FtaSBqZXN0IHByemV6bmFjem9uYSBkbGEgb2ty
ZXNsb25lZ28gYWRyZXNhdGEgaSBtb3plIHphd2llcmFjIGluZm9ybWFjamUgcG91Zm5lLiBXIHJh
emllIHByenlwYWRrb3dlZ28gb3RyenltYW5pYSB0ZWogd2lhZG9tb3NjaSwgcHJvc2lteSBvIHBv
d2lhZG9taWVuaWUgbmFkYXdjeSBvcmF6IHRyd2FsZSBqZWogdXN1bmllY2llOyBqYWtpZWtvbHdp
ZWsgcHJ6ZWdsYWRhbmllIGx1YiByb3pwb3dzemVjaG5pYW5pZSBqZXN0IHphYnJvbmlvbmUuClRo
aXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG1h
dGVyaWFsIGZvciB0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gSWYg
eW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNl
bmRlciBhbmQgZGVsZXRlIGFsbCBjb3BpZXM7IGFueSByZXZpZXcgb3IgZGlzdHJpYnV0aW9uIGJ5
IG90aGVycyBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
