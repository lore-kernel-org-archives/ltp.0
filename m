Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B92CCA5FA1
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 11:22:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C470B3E5861
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 13:22:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11C103C5936
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 13:22:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3A1481400E75
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 13:22:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790680930; x=1822216930;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=nc9UIH7DSg7O3pclYzuesfpQkZAPLXljNkyvxQl142s=;
 b=mjqeKygMW+Bbzq75MANgpQWSnn4GFja7hfgmgtquESWtzM9l6yU/GpMG
 nAZf60v8itdtCOw23YTlcL11M/B2jVoH/v8FZQT7h9ryWToWIF3/tn98j
 koJgZjXaSrtbhSwSpdop9i1xgLDfHHKBM2XAYlF6GEbglP21QHZoGhdRj
 BGFR29tLt2pKLSRTxbPIO8oAdvN8Fv6LesS9reM9AJXuCVtoaRk+iO/IW
 MLJpNoeUmJIyfmzDVcDoFFpXNCzvYaNFyKj9XgUxU1axN1xWofNQO9XL+
 KtE8/oBnAKFw8Zh8uaHldTfUGeNNbQcTltOtIJ9RpuvEM6vxI2vE/1CX9 A==;
X-CSE-ConnectionGUID: j4sazL0nRNSkP37SxwQ1Ww==
X-CSE-MsgGUID: t/evpDUVRTWa+Mz7kZHbYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="78962891"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="78962891"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 04:22:04 -0700
X-CSE-ConnectionGUID: Albw5jtcRpaGxj2IlqSZRA==
X-CSE-MsgGUID: nCd/6WuHRO+iuejVY0LFCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="304839656"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 04:22:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 04:22:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 04:22:03 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 04:22:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBtF3BVVPEL+cAfznUhQbcC2TwkDys8VD4LbDiHxHTacMx5gAOsZipXqohTgHz8tNXuapX6vIofbuTyg9SYK5VTxZp+mfW8bc3PU2xQFQxpx5vWGTOt8wtFavP7lAhezLWbsOuKo6JhgMmnKi6PNxbe0o5kvI7TPoSuiQGuOC8JbyQcDHy5zs6HvaSR/6LSE8QkluzT36P1gxbbXSypOaPxAmkhBdO0Zv67aTMELIDJOIShoiB/5+Wivax6h+DInyY8n825LbqBq9b+0Q7OeRq4JYge9IB1h80HHG8KumBZIvej4QUk/V+H977eSFBN85VkOrPdq2R/C5ZRtjg6tBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0Sr6Fn1m3rUVOQOI6veu1bzguW2TIw7Vq20FllLgcM=;
 b=s/QeGMySTmBTaTAoeH4PcfFvEVq1Zx4VM0si0KQU2+DF6SISt+jHVOG/+ghqDrsbKv/P9cIq4V3+BbekBHzg7wlxMCPZrZV2L6A8FY1A9sV3i7w5pfgYpdqMt6cOCSsLf1e5V5X3H5LkN9uVrQNPLr3ZdEBR7R68tPIoVnKHMXkSXULw4sth+8rIBSQjPy1yjoJZqIauN3oQ3lFA0bWAa2Lq7bEFINF1j2ZnDAw4955Mp1RJ2dFRj9THLSsb8nO05NIMgpnMzuiderftn1zqmGqJKgxovwQVGosF5ETHOIYSnOPimaoafiM1COjroFwzcihCg8Pnxxi3MZarP0+okQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by LV1PR11MB8841.namprd11.prod.outlook.com (2603:10b6:408:2b2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 11:22:00 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 11:22:00 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH 0/3] pmc_core: cover the PkgC LTR blocker counters
Thread-Index: AQHdPGqmDJGjoTkHdEuBncM82wSWZLblkKaA
Date: Tue, 29 Sep 2026 11:22:00 +0000
Message-ID: <281763bcdff18b7512ee8f851979d015e482e987.camel@intel.com>
References: <20260904124042.212065-1-piotr.kubaj@intel.com>
In-Reply-To: <20260904124042.212065-1-piotr.kubaj@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|LV1PR11MB8841:EE_
x-ms-office365-filtering-correlation-id: 2a2863f7-638b-4d78-c895-08df1e1be15f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|5023799004|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 3UD6uUR1eN93aMs4E/YtLZMRVY8Lk0Udcm8GGVts1NO6h9wI2tBuwWY48RwWDyeoBRYnNrwSHPQXeQO3iIwdgk/esT/MsHJJPcDoGoQ4p62ZUu/ajjn2XHEV6BBKBMYHwFDUaoq65tO9+nSNn/5nP4xT6VAAa8K0ACObhgGJBAaZ9PqDxEgz2eAyYMl78ZQD/2NLVpSN/BI21PV6vojnBGAUwjLR++2IKQskc08ttX4Xda0dJAzpSgWO5qEKamFO/v7yP6Vt9O3j9rks1REVacMzjtU90YQdeJ6sJRirQ0LFnHI6XQqTljosSBE0P9ekJASsiXGlejOsQeaHL+p7va2YoaD7L49naO6MFPZz4IRAmVkkcOfYYCbTG6A+51CjF0gdDAPUMAB75mZPnoLL7LNlECj/ofFlN8kw8AjQmlEhNQIu1f6VgLvmKAdsWKpGiNcMfGKvKWvY4ifD03XgSh+xtqEMzD8kn0j+0wEaueOzD04jfdloR7UHKX6KEryPNWGPN6/gZ3E6UjNqQBSDZwKgc4gHkRB44cTbnls1XfZThL45Gv1GaV3m9cuTPlZAZjNR7V3AwF82KNqlr4bvfEE7T52YAVgWxCUcdvhzqpkEZpNB4oC/Lx34qG76BklaBODkYkPbZ2OA2GG3KStTFlbvL/kqE3N61wz+WnlM4dvCvHVTa9N7PBVeQ1JHsAZYm38tWgCFGML/4v3Z8Jb73ytMITWh6wvYB7gFfjAzYkk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(5023799004)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cENGK3ZnOEtiOXZIcDJBZkRiZEtrVDFFZnE3OG11WjNPN3pjZUZmVFJZc1M5?=
 =?utf-8?B?MUF3OEZ5d1R5WGxtMXNxcWlHOE5zNVBzbkZJSjU1aW1XeFc5VFFGTzFUeUQr?=
 =?utf-8?B?amFFZWdnOWR6RHhXWjRuNFlYREY1cndvN3ZrejZrczc2aVptdlNlOVovZnQ1?=
 =?utf-8?B?RlNXVklOdWtkeUNlS2VENU5YMUMxT3NBNHVDOVh1Sk5vZ2ozUXZsWEtpN3Bq?=
 =?utf-8?B?a2NCRFV5QTU4VUdPcTJQSDJTV2tveFBMd0hNSGxaWEY5cjRMRkZ5RFd0OUd1?=
 =?utf-8?B?dTZpNitCODhrOWtkcHZ4VVN4NzV0OCtPa2RWZnBYMThEakNrNEdWYmtXV01N?=
 =?utf-8?B?akxldUFHSU80a2NZdDZLTDhTVWNpeDJlTytFb1h5dmhFdTdMN1FHN3hsbXh1?=
 =?utf-8?B?Wm55MFA1eHJQTVU2eHJiQitqc1ZrVmZyNXFoOFZ1Vlp1cmpJU0pUcWpxOHA0?=
 =?utf-8?B?aUgvY0k5cnh3YjV6akJqUWxLRmdZRGRvSGEySU51cmRMNy83UUxDMkFJNTJZ?=
 =?utf-8?B?Wk5SRnRYZ0M1ejNKRTROa0V3RDB5M0Iya1RkZHBISXhnNFF0bHlQZnZuZ1NQ?=
 =?utf-8?B?N3dJRmVWTE5zbld3Uml2dkhDdUtIVVh3RURTa21WYzgvVWQ0VkVQVkwyMElV?=
 =?utf-8?B?dTdobXh6MUVRdmxhZWdWZ0NJUUdNV2F4NVpIRnBNbUgxSkN1SnlKazVRRlZi?=
 =?utf-8?B?Y25RYnJtci8yRUtieEtMc1plMTdrdkU5bnVIQ3ZTMDRwbHBSVHc3SEVYTVBw?=
 =?utf-8?B?Wm1PYlg0K0Q0SXVGQm1OSUtZazNuMFdGR2NYQit0TkdBU3Zpcm1jVlFpc2pO?=
 =?utf-8?B?V2JRbDNmc1NuaXU4NHZuUGV1QkJ6aVovdGxVaUR4QXJpWVRRcnJPcTMxWGZG?=
 =?utf-8?B?dzFkUTJoSUJrWmF3ZW5FVTZRRUJoQW5ZU05wTWgwZXJmeXVMZEZzK1F5aUNi?=
 =?utf-8?B?VFgwSVRyZWJrUGRmUU9QU2FYQ0ZHclV4Q1Q3OWRZaG9xVXJEcUxFencycnR1?=
 =?utf-8?B?a1dVSUEyalpTajl3Q1UxamxHSVphOWh3TFEvTkRuWjcxMlZLUnFlVk4raVhK?=
 =?utf-8?B?MWpmZG9vdXp3WnRYYjJTbWdUdlpnNDVJWnkzaVFkQjdOcnQyaFBvTkFlS1Zw?=
 =?utf-8?B?SlF5TGJodmY0b2puMEwxSnFVa2orT085bldUTFh6cjFaUE9ZYzJKeUxTY3pX?=
 =?utf-8?B?bkNYbWZmbTNreElLbzRPVno2bmNJQkVEdE11VnBhbC94TGRiM2Y4OEJtUW1i?=
 =?utf-8?B?em9tK2pzUndGQWJIUzhDQitCQjd3bEV1TkRvN2Ntekl3bEZLZmFSQWNSVGU2?=
 =?utf-8?B?M1p2VHBzSlJKUlhLUGZFODBrQUk5R2Z4bzV6TUtzMHFPdjZjbkJRV0Z5U0R2?=
 =?utf-8?B?L01MR2JqSitiNUNtTHVlZGNjZldsbmd5Y1dHQTRaTGhvbUxUakNuZStZWjNH?=
 =?utf-8?B?cXJhdWkzQnZTZHVuZExwaW9nRG5oM2lseXQxdEhlL0RCeEh0TVZvWlJWSnJK?=
 =?utf-8?B?emNXNExrUEJDeUlOUzVZeTBwbVJQREttalJXeUhBc3h0b0llVXI5bkFVNFZa?=
 =?utf-8?B?ejJXRk9kS3BQNFBRRldFZnN4NEc3VEFXM3JMRUdrbmdlaGhiUjBVdGZnRER5?=
 =?utf-8?B?WnJXY2t3TVpyYnk4aDhZTElIb0lUaDdNOVlOQ3ZobFpSd2hYVXhkV0xZbHZz?=
 =?utf-8?B?KzZVaThaT1VQNXJlUGMyZ2NxMDFNMDZzMmN3aW9ENEtqVFRCalV2S0RlVWor?=
 =?utf-8?B?OWJnbjhObzFxaFR6T1VFNnVPdnNNWnh3T004UHhBVFdjc1BXQzlpa000T0J3?=
 =?utf-8?B?eHE2Znk0d3lJOExwSDNQVFJHWmd3NTlpQ3dnN3RmRjFOQm95dXkxVU5LamFh?=
 =?utf-8?B?ZC80VUxETFBTTkVxU1JPTlhEN1BlSEEwOTN5UGJXamRxU05kYXBnbzZKTkxV?=
 =?utf-8?B?YjZSRStVdUpxd2pIR2FBQ0FFMkNBYlZtbEcreVpoQ2NTbXgwazQ5a2ludjA4?=
 =?utf-8?B?MHQyTFFVS1NtU2haakNPQ0NaWjB5eW1rcHpyQzBDcndNNTJJNkthQ01kZTVh?=
 =?utf-8?B?bWxEekhDRkRXbGxzbDlIWWtZK05ONFJPZC91QmRYYlZpOHMwVHI2T09zcy9t?=
 =?utf-8?B?MHluN2FhM2c5NkpMTlJJcEUwM0VoUGcrTzFnZ25CUHVYMGFFeEhvMXMvV3U4?=
 =?utf-8?B?dUlTeFZjb25LenROQXV5MFRiMFh5R0FrVDlqN05zYlNCZ1hmUGhjYkEzb1gr?=
 =?utf-8?B?TGl4eVNnc2M3TkZJR2RYYWhTWUVUNXBiQUNMb0U3NUNrU21hL1RmUVExa0g0?=
 =?utf-8?B?L2JEQTYyTTZlZ0FidTZJVWh6UFdaSkZoZXBic1BGclQrNFptM0V5KzI4NkNX?=
 =?utf-8?Q?C3IGN5rwVxUqzaVI=3D?=
Content-ID: <ECD48CCC0CBE414FAD41265E0C5299E3@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kUEregC+/8CEI0xSClslCQ+EFNP256LPwjNK9ha50Ys0vL0xEyfpm8dRFERvUTmfagaU13UwAy1pYvC1Kh/N5TRTu/iYjgecC6UPiciJL4zSiEe4ep+sljcQKoc9Ffi8ITOQnHvZdgJIcO1NIGa4xDiVBbMTCcgZXyqx9Gmr8QsK+k2f3LsHdgtCrjwOjCIDhnvNUhn0hf4Y0VYGRbqHZumJscE+0YqyB8xkYV97ZJOPVW0aCBYjCM1qcwoq9QTWcnXB6a/GrraxR79wBR93v+tVqlvu6nFBjpNT+rrUt5Y6ZWv5yaBaEAEWJTNQusSFNojDM5dKGAbIWIbXZOHrXA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2863f7-638b-4d78-c895-08df1e1be15f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 11:22:00.3840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZJyc8XD1+TIhjlYWK4F7a5aYxVpOy/PaXqTCJu9CoXLwNB+5NubRpo9fvaiGpTZSEBiE3tvN9zSyCTlISZRXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8841
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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
Cc: "Dubel, Helena Anna" <helena.anna.dubel@intel.com>, "Ossowski,
 Tomasz" <tomasz.ossowski@intel.com>, "Wysocki,
 Rafael J" <rafael.j.wysocki@intel.com>, "Niestepski,
 Daniel" <daniel.niestepski@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

V8KgZG5pdSBwacSFLCAwNC4wOS4yMDI2IG/CoGdvZHppbmllIDE04oi2NDDigIkrMDIwMCwgdcW8
eXRrb3duaWsgUGlvdHIgS3ViYWoNCm5hcGlzYcWCOg0KPiBUaGUgaW50ZWxfcG1jX2NvcmUgZHJp
dmVyIGdhaW5lZCBhIHBrZ2NfbHRyX2Jsb2NrZXJfc2hvdyBkZWJ1Z2ZzIGZpbGUNCj4gaW4NCj4g
a2VybmVsIGNvbW1pdCAzOGM3OWRkNjNiNzIgKCJwbGF0Zm9ybS94ODYvaW50ZWwvcG1jOiBFbmFi
bGUgUGtnQyBMVFINCj4gYmxvY2tpbmcgY291bnRlciIpLCBmaXJzdCByZWxlYXNlZCBpbiB2Ny4y
LCBhbmQgbm90aGluZyBjb3ZlcnMgaXQNCj4geWV0Lg0KPiBJdCByZXBvcnRzLCBwZXIgc291cmNl
LCBob3cgbWFueSB0aW1lcyBhbiBMVFIgcG9zdGVkIGJ5IHRoYXQgc291cmNlDQo+IGJsb2NrZWQg
YSBwYWNrYWdlIEMtc3RhdGUgZW50cnkuDQo+IA0KPiBCb3RoIHRlc3RzIGFkZGVkIGhlcmUgbmVl
ZCBkZWJ1Z2ZzIG1vdW50ZWQsIHNvIHRoZSBmaXJzdCBwYXRjaCBtb3Zlcw0KPiB0aGUNCj4gbW91
bnQgaGFuZGxpbmcgaW50byB0aGUgdGVzdCBsaWJyYXJ5IGluc3RlYWQgb2Ygb3BlbiBjb2Rpbmcg
aXQgdHdpY2UuDQo+IA0KPiAxLzMgYWRkcyB0c3RfdGVzdC5uZWVkc19kZWJ1Z2ZzOiB0aGUgbGli
cmFyeSBtb3VudHMgZGVidWdmcyBhdA0KPiDCoMKgwqAgL3N5cy9rZXJuZWwvZGVidWcgZHVyaW5n
IHNldHVwIHVubGVzcyBpdCBpcyBtb3VudGVkIHRoZXJlDQo+IGFscmVhZHksDQo+IMKgwqDCoCBy
ZXBvcnRzIFRDT05GIGlmIGl0IGNhbm5vdCwgYW5kIHVubW91bnRzIGl0IGFmdGVyd2FyZHMgb25s
eSBpZiBpdA0KPiBkaWQNCj4gwqDCoMKgIHRoZSBtb3VudC4gQSBsaWIvbmV3bGliX3Rlc3RzIHNl
bGYtdGVzdCBjb3ZlcnMgYm90aCBjYXNlcy4gVGVzdHMNCj4gwqDCoMKgIHJlYWRpbmcgYW55IG90
aGVyIGRlYnVnZnMgZmlsZSBjYW4gdXNlIGl0IGFzIHdlbGwuDQo+IA0KPiAyLzMgY2hlY2tzIHdo
YXQgdGhlIGZpbGUgc2F5czogZXZlcnkgbGluZSBpcyBhDQo+IFBLR0NfUFJFVkVOVF9MVFJfPFNP
VVJDRT4NCj4gwqDCoMKgIHRva2VuIGZvbGxvd2VkIGJ5IG9uZSB1MzIgdmFsdWUsIHRoZSBmaWxl
IHJlYWRzIHRvIEVPRiByYXRoZXINCj4gdGhhbg0KPiDCoMKgwqAgZXJyb3Jpbmcgb3V0IG1pZC13
YXksIHRoZSBjb3VudGVyIHNldCBpcyBzdGFibGUgYWNyb3NzIHR3byByZWFkcywNCj4gYW5kDQo+
IMKgwqDCoCBubyBjb3VudGVyIGFkdmFuY2VzIGJ5IG1vcmUgZW50cmllcyB0aGFuIHRoZSBwYWNr
YWdlIGNvdWxkIGhhdmUNCj4gwqDCoMKgIGF0dGVtcHRlZCBvdmVyIHRoZSBpbnRlcnZhbC4NCj4g
DQo+IDMvMyBjaGVja3MgdGhlIGludmFyaWFudCBiZWhpbmQgdGhlIGNvdW50ZXJzOiBhIHBhY2th
Z2UgQy1zdGF0ZSBlbnRyeQ0KPiBpcw0KPiDCoMKgwqAgb25seSBhdHRlbXB0ZWQgb25jZSBldmVy
eSBDUFUgaW4gdGhlIHBhY2thZ2UgaXMgaWRsZSwgc28gY291bnRlcnMNCj4gwqDCoMKgIHRoYXQg
a2VlcCBhZHZhbmNpbmcgd2l0aCBldmVyeSBDUFUgYnVzeSBhcmUgbm90IGNvdW50aW5nIGJsb2Nr
ZWQNCj4gwqDCoMKgIGVudHJpZXMuIFRoZSB0ZXN0IHByb3ZlcyB0aGUgY291bnRlcnMgYXJlIGFs
aXZlIHdoaWxlIGlkbGluZw0KPiBmaXJzdCwNCj4gwqDCoMKgIHNvIHRoYXQgYSBjb3VudGVyIHN0
dWNrIGF0IGEgY29uc3RhbnQgdmFsdWUgY2Fubm90IHBhc3MgZm9yIGZyZWUuDQo+IA0KPiBCb3Ro
IHRlc3RzIGJvdW5kIHdoYXQgdGhleSBhY2NlcHQgaW4gdGltZSByYXRoZXIgdGhhbiBhZ2FpbnN0
IGENCj4gaGFyZGNvZGVkDQo+IGNvdW50ZXIgbGlzdCwgYmVjYXVzZSB0aGUgY291bnRlciBzZXQg
aXMgcGxhdGZvcm0gc3BlY2lmaWMuIFRoYXQgaXMNCj4gd2hhdA0KPiBjYXRjaGVzIGEgdGVsZW1l
dHJ5IHJlZ2lvbiByZWFkIGF0IHRoZSB3cm9uZyBvZmZzZXQsIHdoaWNoIG92ZXJzaG9vdHMNCj4g
dGhlDQo+IGJvdW5kcyBieSBvcmRlcnMgb2YgbWFnbml0dWRlLg0KPiANCj4gVGVzdGVkIG9uIE5v
dmEgTGFrZSBydW5uaW5nIDcuMy4wLXJjMSwgd2l0aCBkZWJ1Z2ZzIGJvdGggbW91bnRlZCBhbmQN
Cj4gdW5tb3VudGVkIGJlZm9yZWhhbmQsIGFuZCBpbiB0aGUgbGF0dGVyIGNhc2UgdGhlIG1vdW50
IHN0YXRlIGlzDQo+IHJlc3RvcmVkDQo+IGFmdGVyIHRoZSBydW4uIFRoZSBURkFJTCBhbmQgVENP
TkYgcGF0aHMgd2VyZSBleGVyY2lzZWQgYWdhaW5zdCBmYWtlDQo+IGNvdW50ZXIgZmlsZXMuDQo+
IA0KPiBQaW90ciBLdWJhaiAoMyk6DQo+IMKgIGxpYjogYWRkIHRzdF90ZXN0Lm5lZWRzX2RlYnVn
ZnMgZmxhZw0KPiDCoCBwbWNfY29yZTogYWRkIHRlc3QgZm9yIHBrZ2NfbHRyX2Jsb2NrZXJfc2hv
dw0KPiDCoCBwbWNfY29yZTogYWRkIGx0cl9jb3VudGVyIHRlc3QNCj4gDQo+IMKgZG9jL2RldmVs
b3BlcnMvd3JpdGluZ190ZXN0cy5yc3TCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAz
ICsNCj4gwqBpbmNsdWRlL3RzdF9mcy5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA0ICsNCj4gwqBpbmNsdWRlL3RzdF90ZXN0
LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgwqAgOCArDQo+IMKgbGliL25ld2xpYl90ZXN0cy8uZ2l0aWdub3JlwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKw0KPiDCoGxpYi9uZXdsaWJfdGVzdHMvcnVu
dGVzdC5zaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsNCj4g
wqBsaWIvbmV3bGliX3Rlc3RzL3RzdF9uZWVkc19kZWJ1Z2ZzLmPCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDM3ICsrDQo+IMKgbGliL3RzdF90ZXN0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMzUgKysNCj4gwqBtZXRhZGF0
YS9tZXRhcGFyc2UuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoMKgIDEgKw0KPiDCoHJ1bnRlc3QvcG93ZXJfbWFuYWdlbWVudF90ZXN0c8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICsNCj4gwqB0ZXN0Y2FzZXMva2VybmVs
L3Bvd2VyX21hbmFnZW1lbnQvLmdpdGlnbm9yZcKgIHzCoMKgIDIgKw0KPiDCoC4uLi9rZXJuZWwv
cG93ZXJfbWFuYWdlbWVudC9sdHJfY291bnRlci5jwqDCoMKgwqAgfCAzNTUNCj4gKysrKysrKysr
KysrKysrKysrDQo+IMKgLi4uL3Bvd2VyX21hbmFnZW1lbnQvcGtnY19sdHJfYmxvY2tlcl9zaG93
LmPCoCB8IDI5NCArKysrKysrKysrKysrKysNCj4gwqAxMiBmaWxlcyBjaGFuZ2VkLCA3NDMgaW5z
ZXJ0aW9ucygrKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBsaWIvbmV3bGliX3Rlc3RzL3RzdF9u
ZWVkc19kZWJ1Z2ZzLmMNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9w
b3dlcl9tYW5hZ2VtZW50L2x0cl9jb3VudGVyLmMNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQNCj4g
dGVzdGNhc2VzL2tlcm5lbC9wb3dlcl9tYW5hZ2VtZW50L3BrZ2NfbHRyX2Jsb2NrZXJfc2hvdy5j
DQo+IA0KPiANCj4gYmFzZS1jb21taXQ6IDgyNTY4YmE4ZmFkMDEyMGE5MzA1ZjdhMjYzZGRiNmQ5
ZDc0YzRmNjENCg0KSGVsbG8sDQoNCmZvciBzb21lIHJlYXNvbiBJIGhhdmVuJ3QgZ290IGFueSBy
ZXBseSBlaXRoZXIgZnJvbSB0aGUgZGV2ZWxvcGVycyBvcg0KdGhlIEFJIGJvdC4gSG93ZXZlciwg
YWxsIHRoZSBDSSB0ZXN0cyBhdA0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0
L2x0cC9saXN0Lz9zZXJpZXM9MTE2NDM1NyBzZWVtIHRvDQpwYXNzLiBJcyB0aGVyZSBhbnkgcmVt
YWluaW5nIGlzc3VlPw0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkludGVsIFRlY2hub2xvZ3kgUG9sYW5kIHNwLiB6
IG8uby4KdWwuIFNsb3dhY2tpZWdvIDE3MyB8IDgwLTI5OCBHZGFuc2sgfCBTYWQgUmVqb25vd3kg
R2RhbnNrIFBvbG5vYyB8IFZJSSBXeWR6aWFsIEdvc3BvZGFyY3p5IEtyYWpvd2VnbyBSZWplc3Ry
dSBTYWRvd2VnbyAtIEtSUyAxMDE4ODIgfCBOSVAgOTU3LTA3LTUyLTMxNiB8IEthcGl0YWwgemFr
bGFkb3d5IDIwMC4wMDAgUExOLgpTcG9sa2Egb3N3aWFkY3phLCB6ZSBwb3NpYWRhIHN0YXR1cyBk
dXplZ28gcHJ6ZWRzaWViaW9yY3kgdyByb3p1bWllbml1IHVzdGF3eSB6IGRuaWEgOCBtYXJjYSAy
MDEzIHIuIG8gcHJ6ZWNpd2R6aWFsYW5pdSBuYWRtaWVybnltIG9wb3puaWVuaW9tIHcgdHJhbnNh
a2NqYWNoIGhhbmRsb3d5Y2guCgpUYSB3aWFkb21vc2Mgd3JheiB6IHphbGFjem5pa2FtaSBqZXN0
IHByemV6bmFjem9uYSBkbGEgb2tyZXNsb25lZ28gYWRyZXNhdGEgaSBtb3plIHphd2llcmFjIGlu
Zm9ybWFjamUgcG91Zm5lLiBXIHJhemllIHByenlwYWRrb3dlZ28gb3RyenltYW5pYSB0ZWogd2lh
ZG9tb3NjaSwgcHJvc2lteSBvIHBvd2lhZG9taWVuaWUgbmFkYXdjeSBvcmF6IHRyd2FsZSBqZWog
dXN1bmllY2llOyBqYWtpZWtvbHdpZWsgcHJ6ZWdsYWRhbmllIGx1YiByb3pwb3dzemVjaG5pYW5p
ZSBqZXN0IHphYnJvbmlvbmUuClRoaXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGNv
bnRhaW4gY29uZmlkZW50aWFsIG1hdGVyaWFsIGZvciB0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVu
ZGVkIHJlY2lwaWVudChzKS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwg
cGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRlciBhbmQgZGVsZXRlIGFsbCBjb3BpZXM7IGFueSByZXZp
ZXcgb3IgZGlzdHJpYnV0aW9uIGJ5IG90aGVycyBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
