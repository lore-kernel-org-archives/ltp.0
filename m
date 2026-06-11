Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39981CD98CE
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 13:06:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9004C3E2FB6
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 15:06:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79A893CB67D
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 15:06:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5415A1000403
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 15:06:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781183167; x=1812719167;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=WVkV6sYUHBUoQMjbbuzptdeYkoMPnz2/g9Awv7XKgto=;
 b=XwZFtVuAth/tavw0mvEROqEjfVumSQtB9NwTNQSD5oq6SOjNdqTsMOc2
 60emkjZ7k5W3g1nK4iFzYv24QE2lWwuZbqOUtVdwZsjc6/UboWnv0CEQA
 s9ZtPoUkCvg14KnalXDoNvxEU4y0X2u0kKms4ctnK/lenMuzvjc5++OKx
 y5i9yxKZcElwVtO+GguRTT4+rFFec1BMU082ZxwrZfxQ/HOWIrQD23bP0
 6zwx4RhD3NwVrn8js67XMmk1OgE3G9AXmAKZ/dh+sMl1SHz8Fj8uxDpvs
 xncqPuZ+BZQo+ZqOQmZw7hW8Bi03PYqW208s1dvrKLb4EJe+cT4/2ho1L A==;
X-CSE-ConnectionGUID: XFvwP6S6QxKkWoO5MhELGw==
X-CSE-MsgGUID: xzZLaPDjSamURHcOA9Qt5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93384446"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="93384446"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 06:06:04 -0700
X-CSE-ConnectionGUID: 4hhXSNZkSTOScwg/mmlUQQ==
X-CSE-MsgGUID: 78lCjRu1T4eJ/waW5IyUNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="250761369"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 06:06:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 06:06:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 06:06:03 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 06:06:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mob/s+/A/9VkLYm+kRABhE9P8cVxqK2KmblDGTelZ01+keVdAG4M7yNZW9v7UgMMA34Sp/v2nQ0O0h6FIu24O4Fr2GswzJ/9E698+nLf/4FJyTVw/2qPA5tlYhEF1HGv/SupzuFxMRuYwl/BKgFoZe5at+zjcfnYRj5lcgUFlsRNqSquOZVfivD7O0nTje13BAHBHF48Ki5/NYMlVWlO2Bf1p55cmXghl4qVZ4ovq1oN0+IRAo1raIgNUhpx0CsiWbyCope1xlA1m8r/EMVZwd1JZS47TEXiN2dm0drb7pFyhDhn/bU5USHuFp8BliMxGnGBKdxsUFe/kG/Gt0225g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfzkBn1E9kw2QabMyuxEmZ/hGUn+6bdJGo4zIeD+oX4=;
 b=OtOqwuIeGoZc4y4w8blZEyx11HOL5sVw24kSn7+X87sjyGnffrFl3wYSpIQrQ/C7q5CfZeX5CjqLlK2srwya9Kixu+NsJnB6G4o6OPvEU0VF2t1RDc9Fm5FBDV2I45u0JF5kVe+vzx8V9oalyzPX6FP+1pTBqDloCGk4wleTdVVJyiWITUEZHWKEVyNREw70NrO89ak85mbTy0+cSLOzQXQezGkR51UaXk9ZXZC5gIkDcxBJuJsgfjpCmygeaxhrYvV8XSf6w5SOlNOdPsQ01Z7yJnhabfpDtul6aoZir+txdbfYw5pKOF466HpvNVyMnoVC4LVlkgCy5kQdZEAGRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by BL1PR11MB5955.namprd11.prod.outlook.com (2603:10b6:208:386::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 13:05:58 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%3]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 13:05:58 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "linuxtestproject.agent@gmail.com" <linuxtestproject.agent@gmail.com>
Thread-Topic: cpufreq.c: add new test for cpufreq sysfs interface validation
Thread-Index: AQHc+Z59f8IlDbOWL0GWGiYzyN37m7Y5UtiA
Date: Thu, 11 Jun 2026 13:05:58 +0000
Message-ID: <1b449538e0328e5020d7c2529419ecfc349e8fdb.camel@intel.com>
References: <20260611114219.146444-2-piotr.kubaj@intel.com>
 <20260611123247.4081-1-linuxtestproject.agent@gmail.com>
In-Reply-To: <20260611123247.4081-1-linuxtestproject.agent@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|BL1PR11MB5955:EE_
x-ms-office365-filtering-correlation-id: 41a17c51-55f7-43ab-dfa6-08dec7ba2e26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|4143699003|6133799003|18002099003|22082099003|56012099006|38070700021;
x-microsoft-antispam-message-info: OOWj/l5Y466I0UKV4rMakugkDdzKMjiyU3NmcW2a/uM5YAAJQwWoaFpUFUi2pO/0sALplBppZ1clsXInyw41M/c7UpO2D4SMBKhH8nZgFaCXKMuMBscnKNBC/WlvIMoxRtDQj2nxCEL4YA5aah1GXTE0b6t8iYSQX0qk2KrT3OjaaEjw9LnjJn6Cc0vGH2UkPRKTpv/Chn15j4gYAWSOXiLRnUpXH+bVDtvWV6TDg5BhbxQ4A9zPEi69WP3wTTqzfyuz3CEG0Kty37iDT5+NImh1LjfVe+pI6WV0flIBru5bWKlzR+cYMHjFzxT+nZ1taQckWU5xWnq42v60DZ2xWw0VZRTxGjcPiv0QGyFKgFGbEC4pqjVVGow0g83MYOFmMOh+gRI4sMmIaou0t1qaPB0sSB0o2JhASLV5PCEmrYNWMcsMeka4cyA+Aua0tDHIL303SoUtliglfCnOJMKBlRUPQYmhVtnalLSflffr0R0CDwTFJQLQXQf89Xc/xndbptZPhtGjLc+3dTtw3IIjl8zX7hcLMl97K66Is2ELqbAHkn1i3K0Mg6ZtyEPkCXUrNibIEuFOd5LGAlFZ6vGRyuFm9cJO7KIfQTzcu82iXZaA+i0ZY6OSImwzZusiIrh7fDFsJsGltH9vYhuXmFMbZ5mbgP798UqiwbaDVHcXaPIh7uobWWhCqvMfusOefPpXVmDn9w/e5CbfjRzOXvk5L10I69I52IiUZk+Zy3CEUCTmBBYlazS6Ea4VbiytA8kc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0hab2tCblI1YUk4YzJQd3FTSGlVU3NLd25PRWptZFl3VkJLc0xjcFMycm1i?=
 =?utf-8?B?ZUlqbklha2dXKzN0bndUZVZDcVQra2V6dlNwYnNmZXNxMnVKSHp4anpmYy9L?=
 =?utf-8?B?R3hOYTJOVW1RaktybVltWWhsbUdLN201QW1BLzQ5OGRqZmF0cjArdlJ0M1Ji?=
 =?utf-8?B?TE8xekp0WWptd2dhK1JZWEcvdUZ1enBzWVp3em5uRDlPdDN1Z1FkL3RyWUtU?=
 =?utf-8?B?TnZQZEQ2eVBlRzhwRnhnMVJIUlFFSGdGOFpuSTVNeTJNQkZNWUt3YWorWWM3?=
 =?utf-8?B?aFFLdC8yNHAvanBXRFpNczEvcWxEL21TbzdZa1pma2xQRTNPbkR4S2JhTkww?=
 =?utf-8?B?cWQ3MWtCVmE1NVFFdnN4WDg0eVNmVyt6TUFQZVpNNk04Y1ltb0hOUi9NcFp4?=
 =?utf-8?B?MnIvdXpxM1hEZ05yc3ZyUlBmMGFTOTFDMy9zckkyOHR4anh6c1UzMDUxVTR2?=
 =?utf-8?B?MG5FMkFxa05sZHlFRE03MkZTNTdwL3MyUVl3MGtLa0V6RlNqRTBRZXc4T2sw?=
 =?utf-8?B?NmdpdG9CK2d3YjQ4OFFyVTNjbzFPNTkwejFrd0tCSjZMRC9Gci82dzNOTUg2?=
 =?utf-8?B?RFNadTVqWmwyNEpLbTF1aEg1Tm54UTcramdtWW9ic0ZYRjhlWE4xYnpoRXcz?=
 =?utf-8?B?UnpMMllucWFrQW0rcVIzVXVsSFpQZGRGQ1l1THlrZ3NWY2R2ZkQremJrcUx4?=
 =?utf-8?B?dUdLUzAvWXRubXFMbndEazBtWHVBeTZLbEU3bFRrbWdMZlQxbzRGTjFUNkho?=
 =?utf-8?B?TmFMMmJydXRnRUpEOUN6UTAybjdnQzNTWXBFSnU3dVY0ejJPSW41U1IwQjNk?=
 =?utf-8?B?M0hlaC93WnRZTEd5S1pjcVBHeFY2S3dVRU8ybThuZlQwNGpjclhNVEFZeUFL?=
 =?utf-8?B?dlppcTJYOEY3OWl5Ym5rR0VUVnA3b0xQMUQ4aXlYTGJIU2ltODJhY3haT1Bv?=
 =?utf-8?B?UGRoa0pnWXJaTjMvUUdlamlZb3RtVk9oZXN6enNxRVl1K2lQTS9FUG9JaWND?=
 =?utf-8?B?VXlKdW1NNjEzN2t0TzRtSVl5dldLOXp6YzFFSFRCOE13eEF4YUFSQlhIcmdF?=
 =?utf-8?B?d2F6MHhVQU9WcDc0VzFSbVZBOW0xSlNWQ3JoZXR1bGc3YU5hQ3lPdjYzSHRl?=
 =?utf-8?B?M1BFSHRKTTdHd0hyS0Rsc05MUnpkN1JJZEt0ejNxZjdiQlJYelN2U1kyNlc1?=
 =?utf-8?B?MlNHSEloekRQTXh5UXhKdHFhQVhMa2FaYU8rMk9GeVg2VUdUNHBiaWMzYnBK?=
 =?utf-8?B?M2E3eE4yTmdJdEMrcEFKTlo0WTlwNUpPZlFEWnhZZXNlQlBFejBTN3kzdnVY?=
 =?utf-8?B?SS80NW93MHEzQlF4Rkh1Tys2eldEUVBHcldzYU43Tml1eTY5bmNwQ3pzdktz?=
 =?utf-8?B?NWJiT3pVUmFQbVg1dk10R0NKV2xwNGNYeitrYnRIeEU4dHNlR1lqUjlDTHFB?=
 =?utf-8?B?Rk1TenBJL0FJWTBXWDNmNFhqTUVHa1VUQTZWTDFhajlPYkZma3owaFFQN0Ra?=
 =?utf-8?B?Nlgxd3QwT1RUNmtnUzlkbFc5T0FIWVdQL1NiZG5KT0JwZTNEeDYyandTck9I?=
 =?utf-8?B?Q05KYlZ6Z3VWVlN4dnVkMFA2UHJoR2dFS1FIUFcwSG5iamprUzg5NWlNbnJC?=
 =?utf-8?B?UUJSdjhlN3huMUJYRGUyV3JFdVlBM1NtREVTVEJKVnp3UmZKOFYwSVNZSFda?=
 =?utf-8?B?SS9xSlpiSU0zSHZWdlBhN2Qzb0dEVk5TZnEwSUtRVnRxbXZYYUkxY1l4VmZ0?=
 =?utf-8?B?Tk41Zmw5b09vbXFZb1F0ZXFtemFIbVAxaWlydURVVjMzdWRESWI5eTJwdEMz?=
 =?utf-8?B?R3dFWktoT0FLN2lnWEgwMHVOeFZDVlVFalU4WWF6WElGUHVnNkljU1J5WG1Y?=
 =?utf-8?B?M1VQb2ZKeGF2TngyaXlUUTZlWTJ3RXQ4cTIyV3krSGw1NHhzUUQ5NC8rK2Nx?=
 =?utf-8?B?UDc4ZGFxbWFFYnJZTkNLUzFDVWVmd0lrT2tqVi9HdlRsR1pHc0tNYjVjVFJs?=
 =?utf-8?B?dVBmL2M0NHJ3c1hMM3Z2RmZ5K2k2UWRaZVk4aXp2cStXK091VnVna1pXOE16?=
 =?utf-8?B?enowVC9pYmJXYVBoeUplVkxWYk1GV3ZVR1BvL0JUMVFBZTJTSGFRQml3TmZY?=
 =?utf-8?B?amkvMEc4MlFrdzh4OVdNcmZSbHIrUC8yZHR0TlFXbFBDUlBrRmw2MkczZmFj?=
 =?utf-8?B?RzBUbVZnSVh5djVMd2RoNEJrcm10MjdnbzZldXorQnhBM1A4czdtSmJyL0pt?=
 =?utf-8?B?SUZYSHN6K2FFNGFaNnJLOVdUaEliaUJnSGlwSlliTVMwR1RiNXRlKzdwWi9Y?=
 =?utf-8?B?Q3JTRGVuQzZBdTMzSE5YdDBmR0lGclBzR0hJcDNSMFF5VFFwOGNLSm1sVkVX?=
 =?utf-8?Q?hBfomJL2WePCloJM=3D?=
Content-ID: <BFC83864659A734784050A33FCEC979A@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UTIO6rPO/5l3zoTbn/mhUThwi16FLDrfi1yzDcWIBTL9vCaXG/F0tfrcWWhmHvMP2u3+Y8xrP/HeG0H1hY8LBQKDXfat1EOmg3xbwioSunJO+Uf4bkzBwNlkhKcMQjwCKU2V4BBL6LT6KwGYMBxTu8uXa7v/FgSeCXT2IJarOs+vhbQBEEJyGJ0xMX5QJsW+8W9ccJMUbKVJ1yISkX2UKiadPYng+hbbO2ffpgztYDruBA1P0nYgLb4KJph4MlO4AYBj6LqE3XyPaWfr2WkPBfly5QJtY9uPLOWrJs7iQ4gPDdYCt18D5FfXYmkOUwOTxk1hbQRUKxsKH29n5KEmsQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a17c51-55f7-43ab-dfa6-08dec7ba2e26
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 13:05:58.4903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iVGKFrDGVL38BDkJbScU68Ynah0rOnzeF3rrr9MwG9Le9GGZtn5E6BbwnytDHVXTJohpT+sh3TVd4dnUkJoC0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5955
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cpufreq.c: add new test for cpufreq sysfs interface
 validation
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

VGhlIGN1cnJlbnQgY2hlY2sgaXMgY29ycmVjdC4gVGhpcyBpcyBleGFjdGx5IHRoZSB3YXkgb3Vy
IGFyY2hpdGVjdA0Kc3VnZ2VzdGVkLiBUaGlzIGlzIGJlY2F1c2UgdGhlIHZhbHVlcyB3cml0dGVu
IGJ5IHRoZSB1c2VyIGFyZSBub3QNCndyaXR0ZW4gcmF3LCBidXQga2VybmVsIHVzZXMgdGhlbSBv
bmx5IGFzIGEgc3VnZ2VzdGlvbiBhbmQgY2FuIGJlIGxvd2VyDQpvciBoaWdoZXIgdGhhbiBzcGVj
aWZpZWQsIGJ1dCBuZWVkIHRvIGFsd2F5cyBhYmlkZSB0aGUgdmFsdWVzIG9mDQpzY2FsaW5nX21p
bl9mcmVxIGFuZCBzY2FsaW5nX21heF9mcmVxIC0gd2hpY2ggaXMgZXhhY3RseSB3aGF0IHRoaXMg
dGVzdA0KY2hlY2tzLg0KDQoyMDI2LTA2LTExICjmnKgpIOOBriAxMjozMiArMDAwMCDjgasgbGlu
dXh0ZXN0cHJvamVjdC5hZ2VudEBnbWFpbC5jb20NCuOBleOCk+OBr+abuOOBjeOBvuOBl+OBnzoN
Cj4gSGkgUGlvdHIsDQo+IA0KPiBPbiBUaHUsIDExIEp1biAyMDI2IDEzOjQyOjIwICswMjAwLCBQ
aW90ciBLdWJhaiB3cm90ZToNCj4gPiBjcHVmcmVxLmM6IGFkZCBuZXcgdGVzdCBmb3IgY3B1ZnJl
cSBzeXNmcyBpbnRlcmZhY2UgdmFsaWRhdGlvbg0KPiANCj4gPiArCQlpZiAoY3B1aW5mb19tYXhf
ZnJlcSA8IHNjYWxpbmdfbWF4X2ZyZXEpIHsNCj4gPiArCQkJdHN0X3JlcyhUSU5GTywgImNwdWlu
Zm9fbWF4X2ZyZXE6ICVsZCIsDQo+ID4gY3B1aW5mb19tYXhfZnJlcSk7DQo+ID4gKwkJCXRzdF9y
ZXMoVElORk8sICJzY2FsaW5nX21heF9mcmVxOiAlbGQiLA0KPiA+IHNjYWxpbmdfbWF4X2ZyZXEp
Ow0KPiA+ICsJCQl0c3RfcmVzKFRGQUlMLCAiRmFpbHVyZSBzZXR0aW5nICVzIiwNCj4gPiBwYXRo
KTsNCj4gPiArCQl9IGVsc2Ugew0KPiA+ICsJCQl0c3RfcmVzKFRQQVNTLCAiU3VjY2Vzc2Z1bGx5
IHNldCB1cCAlcyIsDQo+ID4gcGF0aCk7DQo+ID4gKwkJfQ0KPiANCj4gVGhlIGZyZXF1ZW5jeSB3
cml0ZS1iYWNrIGNoZWNrcyB0aHJvdWdob3V0IHJ1bigpIHVzZSBvbmUtZGlyZWN0aW9uYWwNCj4g
Y29tcGFyaXNvbnMuIEhlcmUgdGhlIHRlc3Qgd3JpdGVzIGNwdWluZm9fbWF4X2ZyZXEgdG8NCj4g
c2NhbGluZ19tYXhfZnJlcQ0KPiBhbmQgcmVhZHMgaXQgYmFjaywgYnV0IG9ubHkgZmFpbHMgd2hl
biB0aGUgcmVhZCB2YWx1ZSBpcyAqaGlnaGVyKg0KPiB0aGFuIHdoYXQgd2FzIHdyaXR0ZW4uIElm
IHRoZSBrZXJuZWwgcm91bmRlZCB0aGUgdmFsdWUgKmRvd24qIChvciB0aGUNCj4gd3JpdGUgc2ls
ZW50bHkgZmFpbGVkIHRvIGEgbG93ZXIgdmFsdWUpLCB0aGUgdGVzdCB3b3VsZCBzdGlsbCByZXBv
cnQNCj4gVFBBU1Mgd2l0aCAiU3VjY2Vzc2Z1bGx5IHNldCB1cCIuDQo+IA0KPiBUaGUgc2FtZSBw
YXR0ZXJuIGFwcGxpZXMgdG8gdGhlIHNjYWxpbmdfbWluX2ZyZXEgY2hlY2tzIGZ1cnRoZXIgZG93
biwNCj4gd2hpY2ggb25seSBmYWlsIHdoZW4gdGhlIHJlYWQgdmFsdWUgaXMgKmxvd2VyKiB0aGFu
IHdoYXQgd2FzIHdyaXR0ZW4uDQo+IA0KPiBTaW5jZSB0aGUgcHVycG9zZSBvZiB0aGVzZSBjaGVj
a3MgaXMgdG8gdmFsaWRhdGUgdGhhdCBleGFjdCBib3VuZGFyeQ0KPiB2YWx1ZXMgY2FuIGJlIHdy
aXR0ZW4sIHdvdWxkIGl0IG5vdCBiZSBtb3JlIGNvcnJlY3QgdG8gdXNlICE9IGluc3RlYWQNCj4g
b2YgPCAvID4gaGVyZT8NCj4gDQo+ID4gKwkJaWYgKGNwdWluZm9fbWF4X2ZyZXEgPCBzY2FsaW5n
X21pbl9mcmVxKSB7DQo+IA0KPiBTYW1lIGlzc3VlOiBvbmx5IGNhdGNoZXMgdXB3YXJkIGRldmlh
dGlvbnMuDQo+IA0KPiA+ICsJCWlmIChjcHVpbmZvX21pbl9mcmVxID4gc2NhbGluZ19taW5fZnJl
cSkgew0KPiANCj4gU2FtZSBpc3N1ZTogb25seSBjYXRjaGVzIGRvd253YXJkIGRldmlhdGlvbnMu
DQo+IA0KPiA+ICsJCWlmIChjcHVpbmZvX21pbl9mcmVxID4gc2NhbGluZ19tYXhfZnJlcSkgew0K
PiANCj4gU2FtZSBpc3N1ZTogb25seSBjYXRjaGVzIGRvd253YXJkIGRldmlhdGlvbnMuDQo+IA0K
PiBWZXJkaWN0OiBOZWVkcyByZXZpc2lvbg0KPiANCj4gLS0tDQo+IE5vdGU6DQo+IA0KPiBUaGUg
YWdlbnQgY2FuIHNvbWV0aW1lcyBwcm9kdWNlIGZhbHNlIHBvc2l0aXZlcyBhbHRob3VnaCBvZnRl
biBpdHMNCj4gZmluZGluZ3MgYXJlIGdlbnVpbmUuIElmIHlvdSBmaW5kIGlzc3VlcyB3aXRoIHRo
ZSByZXZpZXcsIHBsZWFzZQ0KPiBjb21tZW50IHRoaXMgZW1haWwgb3IgaWdub3JlIHRoZSBzdWdn
ZXN0aW9ucy4NCj4gDQo+IFJlZ2FyZHMsDQo+IExUUCBBSSBSZXZpZXdlcg0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CkludGVsIFRlY2hub2xvZ3kgUG9sYW5kIHNwLiB6IG8uby4KdWwuIFNsb3dhY2tpZWdvIDE3MyB8
IDgwLTI5OCBHZGFuc2sgfCBTYWQgUmVqb25vd3kgR2RhbnNrIFBvbG5vYyB8IFZJSSBXeWR6aWFs
IEdvc3BvZGFyY3p5IEtyYWpvd2VnbyBSZWplc3RydSBTYWRvd2VnbyAtIEtSUyAxMDE4ODIgfCBO
SVAgOTU3LTA3LTUyLTMxNiB8IEthcGl0YWwgemFrbGFkb3d5IDIwMC4wMDAgUExOLgpTcG9sa2Eg
b3N3aWFkY3phLCB6ZSBwb3NpYWRhIHN0YXR1cyBkdXplZ28gcHJ6ZWRzaWViaW9yY3kgdyByb3p1
bWllbml1IHVzdGF3eSB6IGRuaWEgOCBtYXJjYSAyMDEzIHIuIG8gcHJ6ZWNpd2R6aWFsYW5pdSBu
YWRtaWVybnltIG9wb3puaWVuaW9tIHcgdHJhbnNha2NqYWNoIGhhbmRsb3d5Y2guCgpUYSB3aWFk
b21vc2Mgd3JheiB6IHphbGFjem5pa2FtaSBqZXN0IHByemV6bmFjem9uYSBkbGEgb2tyZXNsb25l
Z28gYWRyZXNhdGEgaSBtb3plIHphd2llcmFjIGluZm9ybWFjamUgcG91Zm5lLiBXIHJhemllIHBy
enlwYWRrb3dlZ28gb3RyenltYW5pYSB0ZWogd2lhZG9tb3NjaSwgcHJvc2lteSBvIHBvd2lhZG9t
aWVuaWUgbmFkYXdjeSBvcmF6IHRyd2FsZSBqZWogdXN1bmllY2llOyBqYWtpZWtvbHdpZWsgcHJ6
ZWdsYWRhbmllIGx1YiByb3pwb3dzemVjaG5pYW5pZSBqZXN0IHphYnJvbmlvbmUuClRoaXMgZS1t
YWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG1hdGVyaWFs
IGZvciB0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gSWYgeW91IGFy
ZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRlciBh
bmQgZGVsZXRlIGFsbCBjb3BpZXM7IGFueSByZXZpZXcgb3IgZGlzdHJpYnV0aW9uIGJ5IG90aGVy
cyBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
