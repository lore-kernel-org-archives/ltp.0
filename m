Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9369EB64DC
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 15:41:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E849E3C01A5
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 17:41:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45CE93C01A5
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 17:41:42 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9B1A11A00E19
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 17:41:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689867699; x=1721403699;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=03Gug2tQE1nQRWQICgv5pAWiVaEQ1fhvovMkXvsQZfs=;
 b=ht6aSvY/LGnf6rO5vUdDYr097gYah6Lu6f/ZHzWjpgPah+9X9OXvZopB
 oEuYk4Wd1Tv9NRNUiGTyPEHYyXLJOXwmPQmvjQGwAMNBrk+Vj8yVZoxDL
 1LdPS6EJIF5OClcG7giTxHs1lGApgGHm86sEjaEhnDyNjg16Y6m8/t8oJ
 WKezp/gz2WMbBCJwmNuZ5a2cZDF3sGNP0Yjn0HkEguNg2gVJtub3NU1mN
 luqOHKebxO8+4ItBgf76yGi26aH4QvIfGWU3d6zKu5zxAXJdhA1AYAGsl
 c2YeW2M1ZYheCG+IKQ+pEdTOD5gOHpODH+h6PRnwxjkk6xEtDY+ZMnP0r g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="397660168"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; d="scan'208";a="397660168"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2023 08:41:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="759605199"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; d="scan'208";a="759605199"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga001.jf.intel.com with ESMTP; 20 Jul 2023 08:41:35 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 08:41:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 08:41:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 08:41:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1+13ueBUQU2p7d4FLfZEOGgHEfB9gdJIhxLzBpR7cBOIcyg1WLiWOu5CKxFVhXa6Qtga4riBX/ztVs98tU+jbpq+ptgJ+l4alw3SrwXMwMSo2Ww5Psl6HO01jLP5DmP3m9gJIeP1bfoPAsgeYmrahyWviTSabq5R4eHk39KgrhMvMZf9aSWZamdR+JnBqk+ZQ1EmNvN8UtXBKwmTFwzQjtJG0ghdzFEyO9nVm07P6hkvTDdOXzaeMrT0939zN71t9umqBauSLJwIbcfJ4c5ojdwhks5aUN5MK+TdliL2spQxYYMExb0MkJBtBDKcZ6giGwuwyphG6BVHaMFnmw3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03Gug2tQE1nQRWQICgv5pAWiVaEQ1fhvovMkXvsQZfs=;
 b=Ueob+aBuADUZurJYirBIG4tv02upfVcVIjcb4N8TLKKgwgW0nE+YDlmunH8z3SjXXBuxumjcB2OYT038AO2nUbVvlxkOnebJrekX5K5R/b/GvDwLxtnhbYy6rcagQ478dvQam8myezqEY/TPs/r9y94z+aHjxZHDv5lLTsseq1xI/eR7/PQNQAcZ+DeaOr31/0JjGR7oiyhZ4w7p8o/kIdy5OHwKg3dKFLYTqvkHzNnw2KRyy1h/QpM5+iJ/5zozc576hSTaV9can/Kria5UWNGXGHjqm6Hp+jiJZ43Ua1H8IAw0NQulZeteUFea1q02axAjBT5sBnYDpldmqW3mnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA2PR11MB5003.namprd11.prod.outlook.com (2603:10b6:806:11e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Thu, 20 Jul
 2023 15:41:33 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 15:41:33 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "chrubis@suse.cz" <chrubis@suse.cz>
Thread-Topic: [PATCH v3] security/stack_clash: Add test for mmap() minding gap
Thread-Index: AQHZtBm8PuJWdjTRHEGsjYmHQna02q+1yDEAgAD1LgCAAJv5gIALf8UA
Date: Thu, 20 Jul 2023 15:41:33 +0000
Message-ID: <00ee0e896d7d385ec1b7e48dfccbada1c432360a.camel@intel.com>
References: <20230711170335.13142-1-rick.p.edgecombe@intel.com>
 <20230712080936.GA756025@pevik>
 <504874fbc8cac972153d6592815c90af14b7a618.camel@intel.com>
 <ZK-wQ5cj39LnTPp9@yuki>
In-Reply-To: <ZK-wQ5cj39LnTPp9@yuki>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA2PR11MB5003:EE_
x-ms-office365-filtering-correlation-id: a44260aa-a2a3-48af-12b9-08db8937cb63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7aP3jBWJ9i5WDsRwTBsKo236thpqDee3bbE3nDo/uGxVbFR4jJCZJqWV8mGFDAaDo2fFAdaIjKRrlMoj2jqtGgCLtOVQEyfPgmkfweRxbHL43/oSGoXjThU7mt69rgZXfv+n1X/YtCK4cLyJT5CU5Q6nprezoAxeca+J9L5stoACK6okc9vh32EcpPIoHV6IjE4a8eD6+jv/RRWwx1EVj3w0zPKuHitzTjdYdvW5kqtYOLM+fuSTao04ZJZps064Y2Jtfk6m8H0X8TuCtuCrOxIoHbkabVFsAVUrUQpqdsRLX3wCyAvXDoFhZoU6bNgmFc4Kiel/zv5BYRdlN9n6z99WwGdOtnOAFPnR92B/THYPgBhpwA7SL3eSU8gWK33fDoUGktGZCHpQaWeWldOROo209JsAFekyrN0kLDgTsDvLSg+HShFTi4yfwJ9rN/Skk0lVJUD0qgjKNDul7/h6xknvWLe/vrq4PtqCSe9A5sSDq9SP1Pb7DW7skNGfWY0E4P7NikpHL33DednjyZl7Nptv2Ni0+ymLJ59V/+GADQz+GwgpMZDSWRGWqHe7dlHyofFT6YV0s8uc8PO50et+pStfKTmJyZ8zWGjjt036U554B6w4PFGgp4RZcOgrsaCB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB5963.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199021)(6512007)(6486002)(478600001)(122000001)(82960400001)(38100700002)(186003)(5660300002)(4744005)(6506007)(2616005)(71200400001)(83380400001)(26005)(316002)(8936002)(41300700001)(8676002)(2906002)(86362001)(38070700005)(36756003)(54906003)(66556008)(66476007)(66446008)(6916009)(64756008)(4326008)(66946007)(91956017)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3pIelYvQnIwcmg1ZTVXMjhuRFY4RWFlM3JWdEFPUW9KdWpQaUdLcU1mZjdD?=
 =?utf-8?B?WXpNTEQwSndlNEFPLzl5ZGJXTElHWi9RRHFJTGMxU1RoejExQ0pObTZaVXM1?=
 =?utf-8?B?TUdQWk5EZDFWa0dPdDh6cS8xMlVtN1BRU1g3bE5QK0JrVlFGUmFTTzB0TkMw?=
 =?utf-8?B?RVRqSWZXZVlzVjQxc29kYURXYldDRlljTDdZRlo5M1A0dnR2K3hINEtJMU5t?=
 =?utf-8?B?L25DZWoxRkNuZUpSUE9lMzVKM2NmYUI5cTlPV1VBbkQ2S2xZeWRuK1k1Rytz?=
 =?utf-8?B?MmR5VVdEMFBEN2VKSlY0M09BdENjZ1dodW9MV1dTR281eTR2NmovTFY2Q2FB?=
 =?utf-8?B?Nmt0UnRIckM4enNtcFlPYmZGbW5WUTM2NHc2anJ0WUEzRGN0Q1BXZG1RRG9Z?=
 =?utf-8?B?K1pKa25VbGQ0UXMvUThLWE9FZUo3ZDQrNDBncisrcEZ1UnZZSDM3M0lXbTV5?=
 =?utf-8?B?VkhSenpWTXJFckltdkxXVHZ1UnFIbTV4VkJ4S1pjTERoa0ZkeldxMnpqV3Ay?=
 =?utf-8?B?UUNvekRzZnhsSElyRld4QnBQbklvL09QSjJCTTRnSCtkYkhiVW05ekZCVU5m?=
 =?utf-8?B?ODlWemVFMUNxRC9LaUpSc2RJYmY1YXl2L3AvTHROZ3Y3aDRCOFk5ekQ2Wmt6?=
 =?utf-8?B?cXFhc1RkT01Iam5VekN5UzdjU3JUSUxMZWpOck1hTy8yMXREdUd4L2dYS0dx?=
 =?utf-8?B?K3lMYUNOeVVWdmpXa0ZiQlA4SDZ3S0V3WVRMMFZXQXNHcUk1dVlSdWlwd1Yz?=
 =?utf-8?B?akMrTlNhN0JoZEdJOGp5aFc4eHFkdUx4eThCaEZ4eTBlcFhQSVA0b2MxYzNY?=
 =?utf-8?B?dXNzTkFETC9lNGFrd2hXR2xNeHBhY241ZG84dHJiekNWbzhKa3Z4OGR2Wm1S?=
 =?utf-8?B?OXRIZkNYNWtPMmljcEZBUkdValJTdC9vTG9OZkF2S1NGQzRsOHB1WDZCVmU1?=
 =?utf-8?B?TTNwMUFRWXJ3VW5oN1NjNW8xU1BpY2Z6d3RRSHZsbjJwMkdRaVREQ093Qmp6?=
 =?utf-8?B?QlQ2N1JwcGZtLzlrS2MzRGxvMXY0VkJYTzk2WXdEdHpmNlVlV2toMXhSZ2Ji?=
 =?utf-8?B?ZXlsMGtjeUYyTm51ZGsxRU5HQ3dvOXNIQ09SRzFreFRadlBtMEJOa2gwdGVP?=
 =?utf-8?B?Zi9wZ242Znppd3dVL2RuV1g5OGZJNkdmaHhpakFYSHZTZ0Fzdzgzdm5KWWxB?=
 =?utf-8?B?TFYyNEx2clczNTRzT0VYczBFT21wN3dJYTF5SVgwN3l1UzJBbTQ5TWMvdnlG?=
 =?utf-8?B?QkMxZ1JEemNxMUVibjlWcDBaYmlMR2xhUGM4T213R281RW40L1FqZTBTNzM1?=
 =?utf-8?B?Skovdm1HMy93UlNxcG5VdWtHclRCWmJIRHVYZUoyZDV3cUZ1VWNjbEpISVky?=
 =?utf-8?B?bjI2Qzd6dWdCbjZEcXF5S0wrODZlcjhnZnhSQWg1MU16dXUxdDFIWmx5eVV5?=
 =?utf-8?B?ZkthbnBCb2lYajRrM3BVYVVESCtjd0dydTN0RDl0RnNDSzBpMlNENmk0OGpw?=
 =?utf-8?B?MFVxd2c5Y2RRWGhxODhmd0g0N2NZSERTaGo4eDZhSDJqQlBUMHM5WHVabytx?=
 =?utf-8?B?TjZqOGFZME41b2Y1Smd6MjRFNUNWZjltYTZkWDNpcUNlbzl5ZVBVa0RwMHFv?=
 =?utf-8?B?TjJTK0tYOEVwcElVWEMyam5IaG10clREaUpJUCtER2xCcFR2bmdBNUs5aWtl?=
 =?utf-8?B?VG9IeVV6QnZUNWt3N1Zzbms3V3NudEdhRURCTnI0N043RWpKZGJneWorcFVP?=
 =?utf-8?B?cUZibkR4WGZ0Z1ZlSk84SmkrMkZkY3JzOEFDVTFGNEZ3VDFwUG5nT2VjZzZ2?=
 =?utf-8?B?TWJqYmtwZ2JmNVZkTUlXd0kxSDBNQ0VvWkRScVdZcGJiaEo4NEpXR0tFeTNF?=
 =?utf-8?B?eSswZXZlRjFvSWJ3S01nWCtCS2NSa1NxSVFXOUpObjZrNDREMHR2RGU1Zjhx?=
 =?utf-8?B?dStPZVVpMDU1VXNaM1daLzJPMFJvYzhhTS9iYzlkemFyTDdaRGx6UTB4Qm5l?=
 =?utf-8?B?aGNDbHZLbDRkOUk5b0doMXNPUWN1anUxRW8vOTZZaTRzUVRscWMrQjNPaWIy?=
 =?utf-8?B?ckxKeGhkRHlpZWM4SHpXYkZPNEhHejdOQzZ2OEdkYVZpUGVXZ0o4MStsM0pM?=
 =?utf-8?B?UUxuVHNXUFhjQ09PRXNGRWUyRHhwc2FjVGVKT2ZldzdPcGR4VXN4Z3hBN1lu?=
 =?utf-8?B?R1E9PQ==?=
Content-ID: <D1D0FB38A64954429D807301F1527A49@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44260aa-a2a3-48af-12b9-08db8937cb63
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 15:41:33.1366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uoZZe9JAHT+yC5ptgsS26m/1F5QTV0A6jl2im+5OzH3VH0MY1Z97X3OVxFS0UL2CfFmQMpPUrBAJZxAP3S/N/Ol6GtV9plhl80VQMra3GLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5003
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] security/stack_clash: Add test for mmap()
 minding gap
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCAyMDIzLTA3LTEzIGF0IDEwOjA1ICswMjAwLCBDeXJpbCBIcnViaXMgd3JvdGU6DQo+
IEhpIQ0KPiA+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4g
PiA+IMKgIDEgZmlsZSBjaGFuZ2VkLCA4MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4gPiANCj4gPiA+IG5pdDogWW91IG1pZ2h0IHdhbnQgdG8gYWRkIHlvdXIgY29weXJpZ2h0Lg0K
PiA+IA0KPiA+IFdoYXQgZG8geW91IG1lYW4/IEl0J3Mgbm90IGEgbmV3IGZpbGUuLg0KPiANCj4g
UHJvYmFibHkganVzdCB0byBhZGQgIkNvcHlyaWdodCAoYykgMjAyMyB5b3VyIG5hbWUiIHRvIHRo
ZSB0b3Agb2YgdGhlDQo+IEMgZmlsZQ0KDQpTaG91bGQgSSBzZW5kIGFub3RoZXIgdmVyc2lvbiBv
ciBkbyB5b3UgZ3V5cyB3YW50IHRvIGp1c3QgZml4dXAgdGhlc2UNCnR3byB0aGluZ3M/IChkb2Nw
YXJzZSBhbmQgY29weXJpZ2h0KQ0KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
