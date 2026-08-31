Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BFDC61DD3
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 09:58:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DBD13E96B3
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 11:58:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5464B3C98E4
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 11:58:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 14EC760086B
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 11:58:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788170306; x=1819706306;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=kmIAYTcB6nWYiYnoxYAmVF/fJnGCDWc9KAVl80SdsTw=;
 b=hior+OrfrWyed4eCelTx+zeMZBJ/tIHsnxlqhEi/fbpZqbah81DmdZNX
 yfyN48CSGwn9ZJD9kHaJMrAandofmq6TIp5P0TeClnoT4GNF5W6fNrGgF
 Q2ezifvtVaIph5kPBJI9bTMpnJI/uahGaBJY9sgAuVyXEamDUPbEkZkIx
 9fpch4qDa5JC0oHBZ+ztKRjZpHoN6SnuY2fDUftadJvK+qTajSN953q8F
 4Bq14mbEcWDqCESWBqxmlhf4ZaElBIvYp4PP82chie85WXM6TppAmaTqU
 4HYM7qIVecGWar3CLxCaco3JLpC7gjLRHVbzfkSEgLNvMGbsF1zLmoVVC A==;
X-CSE-ConnectionGUID: 4YdmkjbJTOaCXM1tmn3shA==
X-CSE-MsgGUID: vALFFrkDRxOuWlWzXngaIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="92260504"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="92260504"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 02:58:24 -0700
X-CSE-ConnectionGUID: rKAC563UQlqiG2kh+U5wxg==
X-CSE-MsgGUID: jRhFCgA/Qke9d0eAT8Qh0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="306991342"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 02:58:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 02:58:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 02:58:22 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 02:58:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wE9PbPUxUyGrB+f9gOauFyF4zxq/i0TOaVtjggNG2dgs3FclVgZ/H275LY/SACnvWokWbdhRRQyX3BOtnI/6OorgwWxJRxDKVt6G/33096ERVGqbUvx0nfwud/90OKKoTOt5uoU/Xkp8wZCRjIE8Lhc6Tqa6S2VhJIUjH1gzwkM+PxlAjmC0HOuFdTd9wAxSvHSh/8wxbQ0jfG8OFiBNEAtoi7rcx3fSjL6FWcRkinYYUOS9fqo9GgBUVMUnU6zNvHEtGcAyg44p2MdhDYR3a+8uMbXB53uQgL6dOYaU6Av9WcxX5kcfFaW/sdAsrrWnEjdcIqNy0kmYo8NKI4NYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83DiRL/zbqJrVWjppIo/XAdyv4LTBGuwlhdTh+vQVfM=;
 b=Ruh8fGyBGvfNC8/UtjiJlSNXltogqVmx9rrn7I2Qko9grAONxjW1FLCtDGOF4DXOtOOIPhc9qT3DJSpPXb7laamjK3gla4se15GTOQPOiZEO7qcHBd9YrLQ5W9uwo3UaU+eMaDIMGLu3ZjoCf32ERsV9zBkBjPJ0jqLBBuJ2UG6dCGcoqr4x3IErw9Jz5BEfpp3avgm/30678ERbmVNfdbwQN7hiw8TCQImxxBtwQHC7g3NuomKkRd7KAlt7nyu9NvusgV9gIfmqQyRhxOCmY7U/RN3hmQW80GdG5yFsJmUkJRs5moEnCO7pMUqjvMvuskE9oTPdPmORsJMugNJhjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by CH3PR11MB7297.namprd11.prod.outlook.com (2603:10b6:610:140::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 09:58:19 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 09:58:19 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>, "wakel@google.com"
 <wakel@google.com>
Thread-Topic: [PATCH] cpufreq_intel: Check for per-CPU online file presence
 before reading
Thread-Index: AQHdN0JQ8fFoL8BoyE2GSaB0jmDyxba37/wA
Date: Mon, 31 Aug 2026 09:58:19 +0000
Message-ID: <10c5f31ac4d87bc1ba50c0e688056928a8b410f1.camel@intel.com>
References: <20260828230924.2635548-1-wakel@google.com>
In-Reply-To: <20260828230924.2635548-1-wakel@google.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|CH3PR11MB7297:EE_
x-ms-office365-filtering-correlation-id: 10359b14-f420-4087-0597-08df0746629b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|38070700021|11063799006|6133799003|10067099003;
x-microsoft-antispam-message-info: OdC2sQYqR/3VqHqRJ2V9NZG9QkG+DhLVNPjRX/7YIWoLbHS8V/XPtJbkIw3TxR/yScNs6/mh26dtzmg0yPg4CAicD9uR5/TtvRYq/Brs1mLIPsSFRlEWyy6QBO8U6HSacj8sK7bqT84L6dm7prvsNinwV7SeVeCZ3CihekxrzsZRutFXbvuv3EiTLBBrXCXxtzIx0Y55EjvHKnh/Nld7jkYLDR2jaKA9ExWCznIRfbIFoyhhEYD0gWjM9V/kGXztppG9Q8E5O2dmgCre/MZPJqfFymWtMjAIPfDM9STDV00qYV++wWV1/ToT8lqcwm9UdNp08iA+yurodo4q1VSbFx8DL8Ux6eOLiO8ZUbmA5s831rWXoQe38pAYyOre/m3BbJ1mb/Ivt/77kHD5G/ZiIyEDLcD1StPAxuAYGdYkja2rwQgay5QbQtFVe7djncAhnGaXml9SGVZF8SAMmsBPqBZeSCMTFhC/yKoH09LhHicw1GzE2frabYzlco6C9t2zFHNRa1SCjhowgJ0w3Cp/IppUTjkM9uCeysttYP1Iuxyk2wU/lmqU392aBt1VFLBUnwrX+/jRywb+gpUvqij+5etFCrb+vmoGNabDxvGgRMZ2/8vS3KCqitt6gOFA+fCdjwng2OlV5AyV+IRtvAP6KCBWKLHDuVrbdFTvPsoPCvU84vjkAcKFswcsR0g1vdUa1Ti997toby/Zsj6AEkJCF4KS4tUusfQAYpbIRU4j8b4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(38070700021)(11063799006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0dDd3VlcEdlcGVBeXJEZHNjZXFCM1ZCNHN3VmVlK003V3dZeVYya2RiVUNP?=
 =?utf-8?B?a2x6T2RxNkJHcmJCQ2s3ck83WUNLWTNNSTFJUVRLdG04K09Nbks5RzduZ1ZL?=
 =?utf-8?B?NmVvWDZFWWhJVFJIblZWbGt0dGdncHBNTWdzU09BNEtzbDNabFo2M0pzWlZQ?=
 =?utf-8?B?NHRXcHhwUjRpRzU3NUlZMXRJQmZ6blVQZGlySXhZbjBCYklDdm10NWlRMllq?=
 =?utf-8?B?UFA0TlBzQzdiVWpWcDAya09Yam1XZDQvZ1BNNGpDZmNrL2UzVEpsOHpiNGd0?=
 =?utf-8?B?c05pcVFEbWQ0S2ZDcWpwb3Bid2ZpWEJKTnBPQUx3NDY4Z09uZEw1OHBHZFhR?=
 =?utf-8?B?WEpwWHFXWmJHVTljMHlhbFRrcEJqUzFNYVptYWVVbWJtOXJjMzBYeXM4cVk4?=
 =?utf-8?B?WTNGTjhrM2dnY1U4SVJUNkFYU2JPVGtnWGkwSlgzSVY2Z3BzcjhHNWEweHVO?=
 =?utf-8?B?OUp3Mm1yVVFvNk01aXp1SkQ0czUyejNGMmVGZHEwVHZUZHl4OXFLQnFCeFRH?=
 =?utf-8?B?aUVjMDRMT2dDak5BN0d0MXdNRTdJR3YvZ21FVlU5L0hURG9NTUtJQmFOWHM3?=
 =?utf-8?B?cU5yYmtJSkY5OW1vMkNUdHRDSlZQeDZZbE8wWkJveWR4dnppcWUvWWJzUmpr?=
 =?utf-8?B?aXUxamtYUjQwWWxMSkFqMGtUaXBRQjRXUUNiVGc5SWF6UFFEQXIvUjM4bTRX?=
 =?utf-8?B?R1EyYmNVM1JLdXlaQzJ2d1VLQXVhSjdRbE91dm01ZFpORHR1OHB5V1lwdWZj?=
 =?utf-8?B?L1d1LzVUc1JhYkd2SHVvS1VYY292QjR2K2hac3JiY2NnUFg0QklETnNNVkFo?=
 =?utf-8?B?K3JMYWt3MU11WDhCeTVVeEx6L3JyN2E2RTk3SEl6VENXY0pQTERVbFUzcVg1?=
 =?utf-8?B?QlFTN2ZnZFhQRGpmVkZnUklhVEdOTGFkOHAyUVhJc2xOekhJQ2VWaHV0Wklv?=
 =?utf-8?B?UUl5VGYxZlliVDlzRmJGck9VM2ZPcHkwcUFCOUJBYjM5Z1cxVjBkMXBaVWY2?=
 =?utf-8?B?eEsvMjhUcTJxaDJTZUdqb0JQL3JETTNTbWN0Tnc3QnhtdVE5U1E5N3p3U29o?=
 =?utf-8?B?Ui81TVFNSng2T0pmcit1MVNXc1RBOXZkQkc0VFJoSkdyWmhML0lqVWdMM3dB?=
 =?utf-8?B?RmV4bi80eHBVT1EyVkNBeFhPTk1rY2xMM2ljZXIweFFkd2ppbkZLZ2ZOd2tB?=
 =?utf-8?B?UWJwREcrTFlWYjhheVlwZjFMNVB5cUhmUWNZY2xLNnkwcVd0SUV6WTd4RUs4?=
 =?utf-8?B?WVJLTlJLdno1WmNSZCtrODlwVlFDbHJOREM1YzNhaFNkK0N1ZDVtYjhUREJp?=
 =?utf-8?B?eHRuR0xYYm1lNDBOYnV0ZEZaQ2VLWHo3ekpRMUZzMElxY0sxanJHNHBXTXZz?=
 =?utf-8?B?cTBiM210TVNxYWhLMTk0OXVTekQ0c2tQOEZMSHZPTjg4U3NrOHZxWmJCOHJ0?=
 =?utf-8?B?NlM0eDRyNkpyblN5aTByK2w2K0RheWxJUzZDV20vc09PUUcyaW9vR01xcGRi?=
 =?utf-8?B?aksvajQ0elVVY0YxMWFkSnVzZ3VOM1lkcjM5ZVhSVWZlYVdrNFlMS3E4eVUx?=
 =?utf-8?B?SnNrbjBYRHV1elZnNFp3RDE3YnFMekV4WHdyZjhWbFZoRUhrU2tnVXRiOXA5?=
 =?utf-8?B?NWx6RUJzblBkNnI1UzA4T2VsQ3dHaEo4Qk80UUxmV2hoZjlCazVBVmlPUVhm?=
 =?utf-8?B?MEZuSDhRem1od0Y5RlZweTZ5MUd0eVNMODduaGFZNTZrK3l1MzU2anlzWDRz?=
 =?utf-8?B?Sk0wUVFyT0VDcFhDT3dWV3NMbENiQ0dsaEhkbTYxTDBJTXFHbU5ONkhVTGlI?=
 =?utf-8?B?VXdYS04yV1ZEWU9CTkhHbzJ3djRWUVRMQ3QvSHYxRFcxdHJlakFKQ0RuWkFt?=
 =?utf-8?B?NE52bE9vRFhyNFdsWEgwbm04SlhZYUNPNEdES3A2VW1zTkhFZHpkM2tFbWRH?=
 =?utf-8?B?NnlZb2hCeDNxVzhFZHYzMVRLZ2grQjd2bkR5ZjNuUHBzd0hNZ1ZZVmNqTXg5?=
 =?utf-8?B?LzdVa0J5bkVnQURySy8ralZGNHYwRUREd3N0MXNBbnJoK2FhNmlzelJGakxl?=
 =?utf-8?B?ZXNvOFFZREl1OGxSeStxR1YrNC9mRlhmcG9QMDBweExMaCsvNFZSTDduNVpk?=
 =?utf-8?B?NEZkZVNIMUtGUjJoWjhmMG1VTXp6NzZQeVBzTWpWZHNIcWE1ZWc5SXRPMEkv?=
 =?utf-8?B?ZERUc3F5bWtVdG5razAxWW5CbzRpYVlaYnIwQXdpWjd6TWZYZUtKM3JyeWxX?=
 =?utf-8?B?TkNTYXpnWnZObVArc2xZeTZtbzdacVozcVMzaTZYWThNV3R4KzhDUk9Jc1E5?=
 =?utf-8?B?VlZhV1lRS0wwVjFEOHlrTkVUNGdrUlN0My9kV0RvZk9OeVlvZ0NwWkwrdGlG?=
 =?utf-8?Q?s+Yl4r0PywcCV/6c=3D?=
Content-ID: <B0997A272FF8F1419DABB9A83DF76884@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IDeb0JwyCEbkpAlSfL9/8tNX1eeObtvMATckD+v3xreQO3Ts2qup3P8SVpRqQf+ZmRPRM5V/sCWGOXCQtYyNtQtzGwhg8bdd+ESqWrwCtPuQ33bzNJZP9x9cAP63MaXyCstTcgvO1DtL/RMmSWtlU3Px7H/TJ4wYsqjsoZDSs+kbqBsIxogDEnGEMY97cYZWn807it4JtNauMrE7MwRiaEB3rehue10mksNabLyn8cJQje8g3aDWx5p/LLnAferxeiOxAccPwXiZtwdrb9A0qPetPiFTeq0fVx1UDX+OcZ2hCObouavWTRmcLqqjnoT/BXIS69B+KFDKxWq6hsfr6Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10359b14-f420-4087-0597-08df0746629b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 09:58:19.3291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JW9MKJa8kzXOozGDa420GVM3y3uQgMhU8cHaazuixLm7vAt3HaW6O9BfVg1/2P5+DIIQjXeXqdT0zAoi9DXfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7297
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cpufreq_intel: Check for per-CPU online file
 presence before reading
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
Cc: "jaszczyk@google.com" <jaszczyk@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

V8KgZG5pdSBwacSFLCAyOC4wOC4yMDI2IG/CoGdvZHppbmllIDIz4oi2MDnigIkrMDAwMCwgdcW8
eXRrb3duaWsgV2FrZSBMaXUNCm5hcGlzYcWCOg0KPiBGcm9tOiBHcnplZ29yeiBKYXN6Y3p5ayA8
amFzemN6eWtAZ29vZ2xlLmNvbT4NCj4gDQo+IEluIHNldHVwKCksIHRoZSB0ZXN0IGFzc3VtZXMg
dGhhdCBhbGwgc2Vjb25kYXJ5IENQVXMgKGNwdTEuLmNwdU4tMSkNCj4gZXhwb3NlICcvc3lzL2Rl
dmljZXMvc3lzdGVtL2NwdS9jcHU8Tj4vb25saW5lJyBhbmQgYXR0ZW1wdHMgdG8gcmVhZA0KPiB0
aGVpciBzdGF0dXMgdXNpbmcgU0FGRV9GSUxFX1NDQU5GKCkuDQo+IA0KPiBIb3dldmVyLCBvbiBz
eXN0ZW1zIHdoZXJlIENQVSBob3RwbHVnZ2luZyBpcyBkaXNhYmxlZCAoZS5nLiBrZXJuZWxzDQo+
IGJ1aWx0IHdpdGhvdXQgQ09ORklHX0hPVFBMVUdfQ1BVIG9yIHBsYXRmb3JtcyB3aGVyZSBDUFVz
IGFyZSBub3QNCj4gaG90cGx1Z2dhYmxlKSwgdGhlIHBlci1DUFUgJ29ubGluZScgc3lzZnMgYXR0
cmlidXRlcyBhcmUgbm90IGNyZWF0ZWQuDQo+IENhbGxpbmcgU0FGRV9GSUxFX1NDQU5GKCkgb24g
YSBub24tZXhpc3RlbnQgZmlsZSByZXN1bHRzIGluIEVOT0VOVA0KPiBhbmQgYnJlYWtzIHRlc3Qg
c2V0dXAgd2l0aCBUQlJPSy4NCj4gDQo+IENoZWNrIGZvciB0aGUgZXhpc3RlbmNlIG9mIHRoZSBw
ZXItQ1BVICdvbmxpbmUnIGZpbGUgd2l0aCBhY2Nlc3MoKQ0KPiBmaXJzdC4gSWYgdGhlIGZpbGUg
ZXhpc3RzLCByZWFkIHRoZSBzdGF0dXMgdmlhIFNBRkVfRklMRV9TQ0FORigpOyBpZg0KPiBpdCBk
b2VzIG5vdCBleGlzdCwgYXNzdW1lIHRoZSBDUFUgaXMgbm90IGhvdHBsdWdnYWJsZSBhbmQgaXMN
Cj4gcGVybWFuZW50bHkgb25saW5lLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3J6ZWdvcnogSmFz
emN6eWsgPGphc3pjenlrQGdvb2dsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFdha2UgTGl1IDx3
YWtlbEBnb29nbGUuY29tPg0KPiAtLS0NCj4gwqB0ZXN0Y2FzZXMva2VybmVsL3Bvd2VyX21hbmFn
ZW1lbnQvY3B1ZnJlcV9pbnRlbC5jIHwgMTIgKysrKysrKysrKy0tDQo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL2tlcm5lbC9wb3dlcl9tYW5hZ2VtZW50L2NwdWZyZXFfaW50ZWwuYw0KPiBiL3Rl
c3RjYXNlcy9rZXJuZWwvcG93ZXJfbWFuYWdlbWVudC9jcHVmcmVxX2ludGVsLmMNCj4gaW5kZXgg
MTE4OTYyNThlLi5hMmEzZjM0NzUgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvcG93
ZXJfbWFuYWdlbWVudC9jcHVmcmVxX2ludGVsLmMNCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9w
b3dlcl9tYW5hZ2VtZW50L2NwdWZyZXFfaW50ZWwuYw0KPiBAQCAtOTQsOCArOTQsMTYgQEAgc3Rh
dGljIHZvaWQgc2V0dXAodm9pZCkNCj4gwqAJCWludCB0bXA7DQo+IMKgDQo+IMKgCQlzbnByaW50
ZihwYXRoLCBzaXplb2YocGF0aCksDQo+ICIvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUlZC9v
bmxpbmUiLCBpKTsNCj4gLQkJU0FGRV9GSUxFX1NDQU5GKHBhdGgsICIlZCIsICZ0bXApOw0KPiAt
CQlvbmxpbmVbaV0gPSAoYm9vbCl0bXA7DQo+ICsJCWlmIChhY2Nlc3MocGF0aCwgRl9PSykgPT0g
MCkgew0KPiArCQkJU0FGRV9GSUxFX1NDQU5GKHBhdGgsICIlZCIsICZ0bXApOw0KPiArCQkJb25s
aW5lW2ldID0gKGJvb2wpdG1wOw0KPiArCQl9IGVsc2Ugew0KPiArCQkJLyoNCj4gKwkJCSAqIElm
IHRoZSAnb25saW5lJyBmaWxlIGlzIG1pc3NpbmcsIHRoZSBDUFUNCj4gaXMgbm90DQo+ICsJCQkg
KiBob3RwbHVnZ2FibGUgYW5kIGlzIHBlcm1hbmVudGx5IG9ubGluZS4NCj4gKwkJCSAqLw0KPiAr
CQkJb25saW5lW2ldID0gdHJ1ZTsNCj4gKwkJfQ0KPiDCoAl9DQo+IMKgDQo+IMKgCVNBRkVfRklM
RV9QUklOVEYoIi9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2ludGVsX3BzdGF0ZS9zdGF0dQ0KPiBz
IiwgImFjdGl2ZSIpOw0KDQpMR1RNLg0KUmV2aWV3ZWQtYnk6IFBpb3RyIEt1YmFqIDxwaW90ci5r
dWJhakBpbnRlbC5jb20+DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KSW50ZWwgVGVjaG5vbG9neSBQb2xhbmQgc3Au
IHogby5vLgp1bC4gU2xvd2Fja2llZ28gMTczIHwgODAtMjk4IEdkYW5zayB8IFNhZCBSZWpvbm93
eSBHZGFuc2sgUG9sbm9jIHwgVklJIFd5ZHppYWwgR29zcG9kYXJjenkgS3Jham93ZWdvIFJlamVz
dHJ1IFNhZG93ZWdvIC0gS1JTIDEwMTg4MiB8IE5JUCA5NTctMDctNTItMzE2IHwgS2FwaXRhbCB6
YWtsYWRvd3kgMjAwLjAwMCBQTE4uClNwb2xrYSBvc3dpYWRjemEsIHplIHBvc2lhZGEgc3RhdHVz
IGR1emVnbyBwcnplZHNpZWJpb3JjeSB3IHJvenVtaWVuaXUgdXN0YXd5IHogZG5pYSA4IG1hcmNh
IDIwMTMgci4gbyBwcnplY2l3ZHppYWxhbml1IG5hZG1pZXJueW0gb3Bvem5pZW5pb20gdyB0cmFu
c2FrY2phY2ggaGFuZGxvd3ljaC4KClRhIHdpYWRvbW9zYyB3cmF6IHogemFsYWN6bmlrYW1pIGpl
c3QgcHJ6ZXpuYWN6b25hIGRsYSBva3Jlc2xvbmVnbyBhZHJlc2F0YSBpIG1vemUgemF3aWVyYWMg
aW5mb3JtYWNqZSBwb3VmbmUuIFcgcmF6aWUgcHJ6eXBhZGtvd2VnbyBvdHJ6eW1hbmlhIHRlaiB3
aWFkb21vc2NpLCBwcm9zaW15IG8gcG93aWFkb21pZW5pZSBuYWRhd2N5IG9yYXogdHJ3YWxlIGpl
aiB1c3VuaWVjaWU7IGpha2lla29sd2llayBwcnplZ2xhZGFuaWUgbHViIHJvenBvd3N6ZWNobmlh
bmllIGplc3QgemFicm9uaW9uZS4KVGhpcyBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBtYXkg
Y29udGFpbiBjb25maWRlbnRpYWwgbWF0ZXJpYWwgZm9yIHRoZSBzb2xlIHVzZSBvZiB0aGUgaW50
ZW5kZWQgcmVjaXBpZW50KHMpLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50
LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIGFuZCBkZWxldGUgYWxsIGNvcGllczsgYW55IHJl
dmlldyBvciBkaXN0cmlidXRpb24gYnkgb3RoZXJzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
