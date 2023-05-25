Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E369C77B7E
	for <ltp@archiver.kernel.org>; Thu, 25 May 2023 16:53:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D72D03CD1CC
	for <ltp@archiver.kernel.org>; Thu, 25 May 2023 18:52:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 626BE3C2C74
 for <ltp@lists.linux.it>; Thu, 25 May 2023 18:52:47 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6A3B1600BB8
 for <ltp@lists.linux.it>; Thu, 25 May 2023 18:52:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685033565; x=1716569565;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=bMQqVwL+qLxYsPpx8W+tNYX0vCGDKBxyv0k+J6ZpwCM=;
 b=luZuAORRV/wlCN98evj3AhpCNKxm26Dktqxnhb7PSvIdSzn9JDJ3qQM/
 W+SR6n3HnCrowcej9h0FhmUxfj7h9ghiM3d1d51/rhriHGGw0Pxzb+DPJ
 RvTkOKoydpKSbkgZNahoEUK2Tik+w0BdUN8Q2/gTvsvApddHW8UeLIyr2
 hgHCCch49EKGYlnGggkw5f+UkCeQQEwTrd6+y49Fvz2h/frbDNbttPqYZ
 8gcpevsA83UGMlbDhcNxTLcmcMYr5qPaamnUw+gV70ykyzSBgK3UKadFm
 XApBPQ4LXjfsrcz1BaVA4Xh191jmBKzdJo+VZbhhmwFVV5MyKY9RPIqyJ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="440307198"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; d="scan'208";a="440307198"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2023 09:52:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="817179616"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; d="scan'208";a="817179616"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga002.fm.intel.com with ESMTP; 25 May 2023 09:52:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 09:52:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 09:52:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 25 May 2023 09:52:40 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 25 May 2023 09:52:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0S3LVjoDjDBJrkCg527zdKfs9q0dm+JNp0wzrIyHCoapFqUjcDshWlV9exgPbZO59v1/rj/h1sH0zBoi/skL2/vp+BdUcK71N1RjH/oZ8I5HNwDK2yqArdXH+wDBtX6E9GUCnkPv68cgKKfwTrmemjaZgyuZql/f7VBLmwZZeEmBeRLD46gnkknClsNFqx03u4WuROLwj6It8XsrLhFOpKH8f+M1BA+esIVAly6dFUJGZzkBEwmYGnFRopxQdrivOtYpwqn7OqA2RapH9lfXDzxVymr2FDE+CE3MPZH1lzEfhGDU40u7pTPtmWxQIWhTlJn5OtMBmUanJewjfXIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMQqVwL+qLxYsPpx8W+tNYX0vCGDKBxyv0k+J6ZpwCM=;
 b=lYDu6gYp3xbVxanX7cXdc8AVxt8KDpzKx7adg3W3PXIiPZCu3CCUo68gQFS41HRBKdvF28CSKLcgMUB5HGswXob8hpTbWmaKQkl2pNbLY4H/nC8dNPcRquJpp2OA/qzQzDSWyR+HD8ZSgTMuhZMxJpP0jl1VmbGNXNd9b9N7L9Bx3FMogGftYzgfHTjVtFaL6RKBT0a02C5XdJ3kia8k3VeLHmZ6r4sj/w8JYnvWpsDHKi9kHlxYzoEWRGOQ/xbEDcmNmaQsgDjlw61qK9eXpkhqkC2UxfDrdWMcjke82/qljDoFADiDtive4Fj+M8kP6SMWsdi14aqeMYrA6fknLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB4887.namprd11.prod.outlook.com (2603:10b6:510:30::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 16:52:38 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%6]) with mapi id 15.20.6433.016; Thu, 25 May 2023
 16:52:38 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "chrubis@suse.cz" <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] security/stack_clash: Add test for mmap() minding
 gap
Thread-Index: AQHZjn33lHEI2fAe402PR98X3N1MX69qr6sAgACF94A=
Date: Thu, 25 May 2023 16:52:38 +0000
Message-ID: <ec91a6a561ddfc416ba2bcff4538eeea69126ee8.camel@intel.com>
References: <20230524202516.2190903-1-rick.p.edgecombe@intel.com>
 <ZG8h9NyFKVfn92qY@yuki>
In-Reply-To: <ZG8h9NyFKVfn92qY@yuki>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB4887:EE_
x-ms-office365-filtering-correlation-id: d94e9b50-240b-47ca-52da-08db5d4072ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nIqqul4mfldbKuTP/5daD4l9/WWJn0m2ycdMEVpzUC6KJh/IoUpnQDniGSamr+r52kmO3LqGQyCvyyoHdzBKvtzdHcryhg6aH8++dUuIr/B13M0xCqsmUSVYQa1oQCVaZWlfCLzEXiz20yLNGhLSPiLDSq0W9a6c9pP7aRISs2MXZTK7JE3C1fL1Lgu0tmFX06WjEkz/Bp/Kc04Red430yLHhaTLr/iX3uod/qy2XfwHPeb5WB6iWfAkEeJiVYq16eFl5mRwd0AJ/Yzr+zvgqZoocg/Xz9Cs0f9doiiEifpaPg6NwE+qXTowE8NE4xZhUAGg9ABvRfKIHKOCVJPlNXY3vzXD480gxSQO+fG8600thcKnN1ruZlm7nN2rs6B34NfJ0RpcSX7/eGBeJyR0vAhNm0CbJmf1ETs4T0qU6PLSJs4d4qVjUek2rXDWV9WqaLqQbA2QbUTYobyVIA2jfT1EENyoVshIdNBhlW8fjJ3+pA4Z/ywpGeVFkG15hKOjdXtOBY3pffnrtdhU/KFfrWza7fqfsoOL8nBwJUHHKIwH8Sd/dS2D/bCiKoODVnXr8tUT/SPyYfRg9ZRVfqujC8fwbDwDiMMtRyGze5eilr8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB5963.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(122000001)(83380400001)(38070700005)(966005)(54906003)(71200400001)(66946007)(91956017)(316002)(6486002)(66476007)(4326008)(66446008)(41300700001)(66556008)(76116006)(6916009)(64756008)(5660300002)(478600001)(6506007)(26005)(2616005)(6512007)(86362001)(8936002)(186003)(15650500001)(8676002)(82960400001)(36756003)(38100700002)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVY2ZW1TalNNMXJnclEyZzFwRzdMdTJ2dU95WWVJRVFkaXl1UmtSR0F1T2ZM?=
 =?utf-8?B?dkJqam9rcjdSL3lwMGpMMXdoMndkZTY2M2VOSW9qaHFTV0huNlY2Z3lJazdE?=
 =?utf-8?B?OEszWkhURTIxVU1uS1pVMTZvdldia2pPVTU0UlBnQWZwU1pQZWJIS0kzWDhB?=
 =?utf-8?B?VXUvS0JDWUp6RkozY1NQRGsvUmZwYjU2eHMwelJ5eVhsbFlGTnJmUWZ1WXI4?=
 =?utf-8?B?dG5aeW4weDBFa2lRei9RL2xveGNmRW10TTlaS3Q2a3ozdFJBdGYxbU5weXBV?=
 =?utf-8?B?ZEhrRFhPM1krUDBpUVNtZ3NKSEFZa1ZISC9Xanl2UUdPNVR1SjFKaE9qOFho?=
 =?utf-8?B?MGdtVXhPZUdQNkx0MS9zSGlqK1lyT2JwRU04V1d5YTB3QUl0d0QzTGwvMlVj?=
 =?utf-8?B?eEsva1V0WmliN3g3WFZrSW5MbStVanpKLzhGZW9vN1RzYk5vSXYvdFRxVUU5?=
 =?utf-8?B?WDhFcWJTUTk4RzUxd1VVQ1VwMldNM0Y2dlBSRDlOQXltN1g3ZFdsa2ZIeXlC?=
 =?utf-8?B?MVZJS05Wek96Um01aTdpYjVidS80TDQ5amxYeWFkejBtVUVrL0F6TkRtQm5j?=
 =?utf-8?B?S0lqRkpCeFFZTlEwdzFLckgvWUU4czFRNklKSmVHRXZDUEVXVzRiRHlFdHND?=
 =?utf-8?B?K3hEYW00REc1aVhXTnp2eE5MdmhvVm9LQzdSeGVwTkhHeXc5eHMwMlVwaVBs?=
 =?utf-8?B?MjMwL3ZMTWZBSzErbURVZ0xSd0tOL0dmR2FFQ25PWklYRmY5TElQZy9GdS9T?=
 =?utf-8?B?MFNKMVllQ3hYc0VFcmJnZTZVVUZPdnJpckh2ejAwZnNCR2RRT1kwUFhaT1Bz?=
 =?utf-8?B?MlEwU3ZJaG1nOTJObEp1b3pwK0MxeFc4b3E1QkFmbG4ra2JVbi91QnBDcFlQ?=
 =?utf-8?B?dUp4cGV1enB2U015N1RDdllodExNNnR1eFJTZExOelBoRUtkTjllWThyUm5n?=
 =?utf-8?B?MWxrWlhPb2pvNXlCK09SRHlUR1FTQ2FXK0hFc1M1TEduM3d1eXBJZzdxRy8z?=
 =?utf-8?B?VVpmcytGZjNKZWpQYkhqUUpWeHkveXY0WGdWZERqenB0djNYd1g5UGNhaEVN?=
 =?utf-8?B?ald6NlVnQnh1dHJDWDh5NURpT2ZmYXpzUlE0aEhCSnB6cjBabUhiYTJSUDRN?=
 =?utf-8?B?NktlTklJRmE2R0dWNXliQWtoMWR3YkZxRXRNcit0bXRwdjFxeS9DUC9ZVHA4?=
 =?utf-8?B?akhXOGRnNWo5YU5la1ZsMm5hYzNqQlBHZ3FRVjROTGdoZ0JUa0Q5V2hhbXVT?=
 =?utf-8?B?VFl2SE9TOVdxK29aM3ZIaGlZamt3YVZ3N1hMcEZkcm1kVEtoZ2ZOZ00vK1A0?=
 =?utf-8?B?b1NXcDhkRGQ1b2FHbjBISmVJSkd1ZEFlc2NwOWtZQ3NPWVZWRjNvK1QyTzc0?=
 =?utf-8?B?WjJFY1I5NWhmck9JandwcWZyV2JIL0hlamx5QjJ0THJ6K2NtMHVRVUNEZWxJ?=
 =?utf-8?B?MDc0bTlKN3N3UlJzaGlrZnV4M2VZRmVoblhzOUdkWDBRdFdaZnZkNit4UlI0?=
 =?utf-8?B?M2lKdFVzYnY0d3hrbEVjNkVVc3UxV2RkaXJlUGhwcmdsUDBVdGhSOU5WWXgz?=
 =?utf-8?B?S1BoREIvK0xzUWRvY0R6MEVKVXpGM0JQSEZrbUR3SjNLb1p2VlBSc3pYVWVD?=
 =?utf-8?B?bHZKeE4yNFMyOVE2OUpMRyttVG1pNHVtM2RBVDR6WHY1TTVYSkV2cUtsL3I5?=
 =?utf-8?B?dnZXS2pic1RIRTR1OFE0RjBxVDVzeUZWMmxvam14UmRjVzVhYnhYZG51UFYr?=
 =?utf-8?B?QVhCZEJkK3VJVFlub0lzcWp5aDdJWnNXVFY2ZVM5bGhtWW1VRGVMV0R0SDZ6?=
 =?utf-8?B?OUd2SVZma3BaRGlndFpiNUZiUEZRWDlHRUtWR1lydmxpaEJlQmU4ZCtvN1RO?=
 =?utf-8?B?YVVQZGZ1Zlp0RUR6MnpzUjNlK1h5TUU2NnVlQStPZ1diZHF3UnpHYUhxRVhC?=
 =?utf-8?B?N0ZOKzZxNDN5UVIvTTNpZE9xZ3JLY3ByQ3Z6c0d4ZkZJZ29xSHBGNGdESjU4?=
 =?utf-8?B?QVp5M0QzZjR6ZjBrUW1mMTJTTjIyTXgzdUt0SVp6NXM4ZCtIMXliZHFjMEQw?=
 =?utf-8?B?dlBNa29xUExZSDlFZi9yUi8wZFBZck90UGtFOEx6K1MwN0FJeGhFZlp1N2M0?=
 =?utf-8?B?TmtBNmJESEJDbnpUdGpSME1sWjlVQThiSTFMVERNZlNzTjBVOXgvSWJzS3Fk?=
 =?utf-8?Q?bBp+1VFtB4VPk7oc110EN+Y=3D?=
Content-ID: <B3A0B4C7BF4B374B9D2D3CF68197B743@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94e9b50-240b-47ca-52da-08db5d4072ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 16:52:38.6692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrWnNpPsvOjCfRgRhKWZ9vlhZ+B4wOa7yvyvtg4R1OHjPoqFftO45Kw8V+2v4HjJdbTSGYqsFGDMXQxmpnd0KJLGcwc6tCkmB4MH7EvS+lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4887
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] security/stack_clash: Add test for mmap() minding
 gap
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

T24gVGh1LCAyMDIzLTA1LTI1IGF0IDEwOjUzICswMjAwLCBDeXJpbCBIcnViaXMgd3JvdGU6Cj4g
SGkhCj4gPiBUaGUgZXhpc3Rpbmcgc3RhY2tfY2xhc2ggdGVzdCBvbmx5IHZlcmlmaWVzIGlmIHRo
ZSBzdGFjayBjYW4gZ3Jvdwo+ID4gdG9vIGNsb3NlCj4gPiB0byBhbiBleGlzdGluZyBtYXBwaW5n
LiBJdCBkb2Vzbid0IHRlc3QgaWYgbW1hcCgpIHdpbGwgcGxhY2UgbmV3Cj4gPiBtYXBwaW5ncwo+
ID4gaW4gdGhlIGdhcC4KPiA+IAo+ID4gQWRkIGEgdGVzdCBmb3IgdGhpcy4gSGF2ZSBpdCBmaWxs
IGFsbCB0aGUgZW1wdHkgcmVnaW9ucyBiZWxvdyB0aGUKPiA+IHN0YWNrCj4gPiB3aXRoIFBST1Rf
Tk9ORSBtYXBwaW5ncy4gRG8gdGhpcyBieSBzZWFyY2hpbmcgL3Byb2MvcGlkL21hcHMgZm9yCj4g
PiB0aGUKPiA+IGdhcHMuIFRoZSBjb2RlIGZvciBwYXJzaW5nIHRoaXMgaXMgYmFzZWQgb24gdGhl
IGV4aXN0aW5nCj4gPiByZWFkX3N0YWNrX2FkZHJfZnJvbV9wcm9jKCkgaW4gdGhlIGZpbGUuCj4g
PiAKPiA+IFdpdGggYWxsIGxvd2VyIHNwYWNlcyB0YWtlbiBieSB0aGUgUFJPVF9OT05FIG1hcHBp
bmdzLCB0aGUgc2VhcmNoCj4gPiBkb3duCj4gPiBwYXRoIHdpbGwgdGhlbiBmYWlsIGZvciBuZXcg
bW1hcCgpcy4gU28gbW1hcCgpIHdpbGwgc2VhcmNoIHVwIGFuZAo+ID4gZmluZCB0aGUKPiA+IGdh
cCBqdXN0IGJlZm9yZSB0aGUgc3RhY2suIElmIGl0IHBpY2tzIGl0IHRoZW4gdGhlIG1hcHBpbmcg
aXMgaW4KPiA+IHRoZSBndWFyZAo+ID4gcmVnaW9uLCBzbyBmYWlsIHRoZSB0ZXN0Lgo+ID4gCj4g
PiBUaGlzIGxvZ2ljIGlzIHNvbWV3aGF0IHg4Nl82NCBzcGVjaWZpYywgYnV0IG1heSB3b3JrIGZv
ciBvdGhlcgo+ID4gYXJjaGl0ZWN0dXJlcy4gTWFrZSBpdCBiZSB4ODZfNjQgZm9yIG5vdywgYnV0
IGRvY3VtZW50IHRoZQo+ID4gYXNzdW1wdGlvbnMgc28KPiA+IHRoYXQgb3RoZXJzIGNhbiBiZSBh
ZGRlZCBhZnRlciBtb3JlIHZlcmlmaWNhdGlvbi4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogUmlj
ayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPgo+ID4gLS0tCj4gPiAKPiA+
IEhpLAo+ID4gCj4gPiBUaGVyZSB3YXMgcmVjZW50bHkgYSByZWdyZXNzaW9uIGFyb3VuZCBtbWFw
IHBsYWNlbWVudCBhbmQgbW1hcAo+ID4gZ3VhcmQKPiA+IGdhcHMuIFRvZGF5IHRoZSBzdGFjayBj
bGFzaCB0ZXN0IG9ubHkgdGVzdHMgaWYgdGhlIGdhcCBjYW4gZXhwYW5kCj4gPiB0b28KPiA+IGNs
b3NlIHRvIGFuIGFkamFjZW50IG1hcHBpbmcsIGJ1dCBub3QgaWYgaXQgbWFwcGluZ3MgY2FuIGJl
IHBsYWNlZAo+ID4gaW4gdGhlCj4gPiBnYXAuIENhbiB3ZSBlbmhhbmNlIHRoZSB0ZXN0IHRvIGFs
c28gdmVyaWZpeSB0aGUgbGF0dGVyPwo+IAo+IElzIHRoZXJlIGFuIHVwc3RyZWFtIGNvbW1pdCBm
aXg/IElmIHNvIGl0IHNob3VsZCBiZSBwdXQgaW50byB0aGUgdGFncwo+IGFycmF5LgoKT2gsIEkg
c2VlLiBZZXMgSSBjYW4gYWRkIGl0LgoKPiAKPiA+IMKgIHRlc3RjYXNlcy9jdmUvc3RhY2tfY2xh
c2guYyB8IDk1Cj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiDC
oCAxIGZpbGUgY2hhbmdlZCwgOTUgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL2N2ZS9zdGFja19jbGFzaC5jCj4gPiBiL3Rlc3RjYXNlcy9jdmUvc3RhY2tfY2xh
c2guYwo+ID4gaW5kZXggY2Q3ZjE0OGMyLi5iYmQyOGI0ZjEgMTAwNjQ0Cj4gPiAtLS0gYS90ZXN0
Y2FzZXMvY3ZlL3N0YWNrX2NsYXNoLmMKPiA+ICsrKyBiL3Rlc3RjYXNlcy9jdmUvc3RhY2tfY2xh
c2guYwo+ID4gQEAgLTE4LDYgKzE4LDEwIEBACj4gPiDCoMKgICogdG8gaW5maW5pdHkgYW5kIHBy
ZWFsbG9jYXRlIFJFUV9TVEFDS19TSVpFIGJ5dGVzIG9mIHN0YWNrIHNvCj4gPiB0aGF0IG5vIGNh
bGxzCj4gPiDCoMKgICogYWZ0ZXIgYG1tYXBgIGFyZSBtb3Zpbmcgc3RhY2sgZnVydGhlci4KPiA+
IMKgwqAgKgo+ID4gKyAqIElmIHRoZSBhcmNoaXRlY3R1cmUgbWVldHMgY2VydGFpbiByZXF1aXJl
bWVudHMgKFNlZSBub3QgYWJvdmUKPiA+ICsgKiBDQU5fRE9fUExBQ0VNRU5UX1RFU1QpLCB0aGVu
IHRoZSB0ZXN0IGFsc28gdmVyaWZpZXMgdGhhdCBuZXcKPiA+IG1tYXAoKXMgY2FuJ3QKPiA+ICsg
KiBiZSBwbGFjZWQgaW4gdGhlIHN0YWNrJ3MgZ3VhcmQgZ2FwLgo+ID4gKyAqCj4gPiDCoMKgICog
WzFdCj4gPiBodHRwczovL2Jsb2cucXVhbHlzLmNvbS9zZWN1cml0eWxhYnMvMjAxNy8wNi8xOS90
aGUtc3RhY2stY2xhc2gKPiA+IMKgwqAgKiBbMl0KPiA+IGh0dHBzOi8vYnVnemlsbGEubm92ZWxs
LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9Q1ZFLTIwMTctMTAwMDM2NAo+ID4gwqDCoCAqLwo+ID4gQEAg
LTQ1LDYgKzQ5LDIyIEBAIHN0YXRpYyBpbnQgU1RBQ0tfR1JPV1NET1dOOwo+ID4gwqAgCj4gPiDC
oCAjZGVmaW5lIEVYSVRfVEVTVEJST0tFwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBU
QlJPSwo+ID4gwqAgCj4gPiArLyoKPiA+ICsgKiBUaGUgbW1hcCBwbGFjZW1lbnQgcGFydCBvZiB0
aGUgdGVzdCB3b3JrcyBieSBmb3JjaW5nIGEgYm90dG9tCj4gPiB1cCBzZWFyY2guCj4gPiArICog
VGhlIGFzc3VtcHRpb25zIGFyZSB0aGF0IHRoZSBzdGFjayBncm93cyBkb3duIChzdGFydCBnYXAp
IGFuZAo+ID4gZWl0aGVyOgo+ID4gKyAqwqDCoCAxLiBUaGUgZGVmYXVsdCBzZWFyY2ggaXMgdG9w
IGRvd24sIGFuZCB3aWxsIHN3aXRjaCB0byBib3R0b20KPiA+IHVwIGlmCj4gPiArICrCoMKgwqDC
oMKgIHNwYWNlIGlzIGV4aGF1c3RlZC4KPiA+ICsgKsKgwqAgMi4gVGhlIGRlZmF1bHQgc2VhcmNo
IGlzIGJvdHRvbSB1cCBhbmQgdGhlIHN0YWNrIGlzIGFib3ZlCj4gPiBtbWFwIGJhc2UKPiA+ICsg
Kgo+ID4gKyAqIENhc2UgMSBoYXMgYmVlbiB2ZXJpZmllZCBvbiB4ODZfNjQsIHNvIG9ubHkgZG8g
dGhlIHRlc3Qgb24gdGhpcwo+ID4gKyAqIGFyY2hpdGVjdHVyZSB1bnRpbCBtb3JlIGhhdmUgYmVl
biB2ZXJpZmllZC4KPiA+ICsgKi8KPiA+ICsjaWZkZWYgX194ODZfNjRfXwo+ID4gKyNkZWZpbmUg
Q0FOX0RPX1BMQUNFTUVOVF9URVNUwqDCoDEKPiA+ICsjZWxzZQo+ID4gKyNkZWZpbmUgQ0FOX0RP
X1BMQUNFTUVOVF9URVNUwqDCoDAKPiA+ICsjZW5kaWYKPiA+ICsKPiA+IMKgIHZvaWQgZXhoYXVz
dF9zdGFja19pbnRvX3NpZ3NlZ3Yodm9pZCkKPiA+IMKgIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqB2
b2xhdGlsZSBjaGFyICogcHRyID0gYWxsb2NhKEZSQU1FX1NJWkUgLSBzaXplb2YobG9uZykpOwo+
ID4gQEAgLTc4LDYgKzk4LDU3IEBAIHZvaWQgc2Vndl9oYW5kbGVyKGludCBzaWcsIHNpZ2luZm9f
dCAqaW5mbywgdm9pZAo+ID4gKmRhdGEgTFRQX0FUVFJJQlVURV9VTlVTRUQpCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9leGl0KEVYSVRfU1VDQ0VTUyk7Cj4gPiDCoCB9Cj4g
PiDCoCAKPiA+ICtzdGF0aWMgdm9pZCBmb3JjZV9ib3R0b21fdXAodm9pZCkKPiA+ICt7Cj4gPiAr
wqDCoMKgwqDCoMKgwqBGSUxFICpmaDsKPiA+ICvCoMKgwqDCoMKgwqDCoGNoYXIgYnVmWzEwMjRd
Owo+ID4gK8KgwqDCoMKgwqDCoMKgdW5zaWduZWQgbG9uZyBzdGFydCwgZW5kLCBzaXplLCBsYXN0
ZW5kID0gMDsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoGZoID0gU0FGRV9GT1BFTigiL3Byb2Mv
c3lzL3ZtL21tYXBfbWluX2FkZHIiLCAiciIpOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgLyog
c3RhcnQgZmlsbGluZyBmcm9tIG1tYXBfbWluX2FkZHIgKi8KPiA+ICvCoMKgwqDCoMKgwqDCoGlm
IChmc2NhbmYoZmgsICIlbHUiLCAmbGFzdGVuZCkgIT0gMSkgewo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoFNBRkVfRkNMT1NFKGZoKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB0c3RfYnJrKFRCUk9LIHwgVEVSUk5PLCAiZnNjYW5mIik7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuOwo+ID4gK8KgwqDCoMKgwqDCoMKgfQo+ID4g
Kwo+ID4gK8KgwqDCoMKgwqDCoMKgU0FGRV9GQ0xPU0UoZmgpOwo+IAo+IFdlIGRvIGhhdmUgU0FG
RV9GSUxFX1NDQU5GKCkgYXMgd2VsbC4KCk9oLCBuZWF0LiBJJ2xsIGNoYW5nZSBpdC4KCj4gCj4g
PiArwqDCoMKgwqDCoMKgwqBmaCA9IFNBRkVfRk9QRU4oIi9wcm9jL3NlbGYvbWFwcyIsICJyIik7
Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqB3aGlsZSAoIWZlb2YoZmgpKSB7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGZnZXRzKGJ1Ziwgc2l6ZW9mKGJ1ZiksIGZoKSA9
PSBOVUxMKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBnb3RvIG91dDsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAo
c3NjYW5mKGJ1ZiwgIiVseC0lbHgiLCAmc3RhcnQsICZlbmQpICE9IDIpIHsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdHN0X2JyayhUQlJPSyB8IFRF
UlJOTywgInNzY2FuZiIpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBnb3RvIG91dDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9
Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2l6ZSA9IHN0YXJ0IC0g
bGFzdGVuZDsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBTa2lw
IHRoZSBQUk9UX05PTkUgdGhhdCB3YXMganVzdCBhZGRlZCAoIXNpemUpLgo+ID4gKi8KPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIXNpemUpIHsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbGFzdGVuZCA9IGVuZDsKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29udGludWU7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gKwo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoC8qIElmIHRoZSBuZXh0IGFyZWEgaXMgdGhlIHN0YWNrLCBxdWl0
LiAqLwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghIXN0cnN0cihidWYs
ICJbc3RhY2tdIikpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGJyZWFrOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8q
IFRoaXMgaXMgbm90IGNsZWFuZWQgdXAuICovCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgU0FGRV9NTUFQKCh2b2lkICopbGFzdGVuZCwgc2l6ZSwgUFJPVF9OT05FLAo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBNQVBfQU5PTnxN
QVBfUFJJVkFURXxNQVBfRklYRURfTk9SRVBMQUNFLAo+ID4gLTEsIDApOwo+ID4gKwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxhc3RlbmQgPSBlbmQ7Cj4gPiArwqDCoMKgwqDC
oMKgwqB9Cj4gPiArCj4gPiArb3V0Ogo+ID4gK8KgwqDCoMKgwqDCoMKgU0FGRV9GQ0xPU0UoZmgp
Owo+ID4gK30KPiA+IAo+ID4gwqAgdW5zaWduZWQgbG9uZyByZWFkX3N0YWNrX2FkZHJfZnJvbV9w
cm9jKHVuc2lnbmVkIGxvbmcKPiA+ICpzdGFja19zaXplKQo+ID4gwqAgewo+ID4gwqDCoMKgwqDC
oMKgwqDCoEZJTEUgKmZoOwo+ID4gQEAgLTEzMCw2ICsyMDEsMjYgQEAgdm9pZCBfX2F0dHJpYnV0
ZV9fKChub2lubGluZSkpCj4gPiBwcmVhbGxvY2F0ZV9zdGFjayh1bnNpZ25lZCBsb25nIHJlcXVp
cmVkKQo+ID4gwqDCoMKgwqDCoMKgwqDCoGdhcmJhZ2VbMF0gPSBnYXJiYWdlW3JlcXVpcmVkIC0g
MV0gPSAnXDAnOwo+ID4gwqAgfQo+ID4gwqAgCj4gPiArc3RhdGljIHZvaWQgZG9fbW1hcF9wbGFj
ZW1lbnRfdGVzdCh1bnNpZ25lZCBsb25nIHN0YWNrX2FkZHIsCj4gPiB1bnNpZ25lZCBsb25nIGdh
cCkKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKgwqB2b2lkICptYXBfdGVzdF9nYXA7Cj4gPiArCj4g
PiArwqDCoMKgwqDCoMKgwqBmb3JjZV9ib3R0b21fdXAoKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKg
wqDCoC8qCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBmaWxsX2dhcHNfd2l0aF9wcm90X25vbmUoKSB1
c2VkIHVwIGFsbCB0aGUgc3BhY2VzIGJlbG93Cj4gPiB0aGUgc3RhY2suIFRoZQo+ID4gK8KgwqDC
oMKgwqDCoMKgICogc2VhcmNoIGRvd24gcGF0aCBzaG91bGQgZmFpbCwgYW5kIHNlYXJjaCB1cCBt
aWdodCB0YWtlIGEKPiA+IGxvb2sgYXQgdGhlIGd1YXJkCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBn
YXAgcmVnaW9uLiBJZiBpdCBhdm9pZHMgaXQsIHRoZSBhbGxvY2F0aW9uIHdpbGwgYmUKPiA+IGFi
b3ZlIHRoZSBzdGFjay4gSWYKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIGl0IHVzZXMgaXQsIHRoZSBh
bGxvY2F0aW9uIHdpbGwgYmUgaW4gdGhlIGdhcCBhbmQgdGhlCj4gPiB0ZXN0IHNob3VsZCBmYWls
Lgo+ID4gK8KgwqDCoMKgwqDCoMKgICovCj4gPiArwqDCoMKgwqDCoMKgwqBtYXBfdGVzdF9nYXAg
PSBTQUZFX01NQVAoMCwgTUFQUEVEX0xFTiwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBQUk9UX1JFQUR8UFJPVF9XUklU
RSwKPiA+IE1BUF9BTk9OfE1BUF9QUklWQVRFLCAwLCAwKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKg
wqDCoGlmIChzdGFja19hZGRyIC0gZ2FwIDw9ICh1bnNpZ25lZCBsb25nKW1hcF90ZXN0X2dhcCAm
Jgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCh1bnNpZ25lZCBsb25nKW1hcF90
ZXN0X2dhcCA8PSBzdGFja19hZGRyKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oF9leGl0KEVYSVRfRkFJTFVSRSk7Cj4gCj4gSXQgd291bGQgYmUgYmV0dGVyIGlmIHdlIHJlcG9y
dGVkIHRoaXMgYXMgYSBzZXBhcmF0ZSByZXN1bHQsIHNpbmNlCj4gb3RoZXJ3aXNlIGl0IHdvdWxk
bid0IGJlIGNsZWFyIGlmIHRoaXMgcGFydCBmYWlsZWQgb3IgaWYgd2UgZ290IHRoZQo+IEVYSVRf
RkFJTFVSRSBmcm9tIHRoZSBTSUdTRUdWIHNpZ25hbCBoYW5kbGVyLgo+IAo+IEFzIGEgbWF0dGVy
IG9mIGZhY3Qgd2UgY2FuIGp1c3QgZG8gdHN0X3JlcyhURkFJTCwgIi4uLiIpOiBoZXJlCj4gaW5z
dGVhZAo+IG9mIGV4aXQsIHdoaWNoIHdpbGwgcHJpbnQgYSBtZXNzYWdlLCBpbmNyZW1lbnQgZmFp
bHVyZSBjb3VudGVyLCBhbmQKPiBwcm9jY2VkZCB3aXRoIHRoZSByZXN0IG9mIHRoZSB0ZXN0LgoK
U291bmRzIGVhc3kgZW5vdWdoLgoKPiAgSSBzdXBwb3NlIHRoYXQgd2Ugd2FudCB0byB1bm1hcCB0
aGlzCj4gbWFwcGluZyBqdXN0IGluIGNhc2UgaWYgd2UgZG8gc28uCgpSaWdodC4gVGhlIGdyb3dp
bmcgdGVzdCBhY3R1YWxseSB3aWxsIHdvcmsgd2l0aCBzb21ldGhpbmcgaW4gdGhlIGdhcCwKYnV0
IGl0J3MgbW9yZSBjb25zaXN0ZW50IHRvIHVubWFwIGl0LgoKPiAKPiA+ICt9Cj4gPiArCj4gPiDC
oCB2b2lkIGRvX2NoaWxkKHZvaWQpCj4gPiDCoCB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgdW5zaWdu
ZWQgbG9uZyBzdGFja19hZGRyLCBzdGFja19zaXplOwo+ID4gQEAgLTE3OSw2ICsyNzAsMTAgQEAg
dm9pZCBkb19jaGlsZCh2b2lkKQo+ID4gwqDCoMKgwqDCoMKgwqDCoGR1bXBfcHJvY19zZWxmX21h
cHMoKTsKPiA+IMKgICNlbmRpZgo+ID4gwqAgCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoQ0FOX0RP
X1BMQUNFTUVOVF9URVNUKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRvX21t
YXBfcGxhY2VtZW50X3Rlc3Qoc3RhY2tfYWRkciwgZ2FwKTsKPiAKPiBJIGRvIG5vdCB0aGluayB0
aGF0IHRoZSBtYWNybyBpbmRpcmVjdGlvbiBkb2VzIGFkZCBhbnkgdmFsdWUsIGNhbiB3ZQo+IGp1
c3QgZG8gdGhlICNpZmRlZiBmb3IgeDg2IGhlcmU/CgpEaWQgeW91IGNhdGNoIHRoYXTCoHRoaXMg
dGVzdCBsaWtlbHkgd2lsbCB3b3JrIGZvciBvdGhlciBhcmNoaXRlY3R1cmVzLApidXQgaXQganVz
dCBoYXNuJ3QgYmVlbiB2ZXJpZmllZD8gSSB3YXMgaW1hZ2luaW5nIGhhdmluZyBpdCB0aGlzIHdh
eQptaWdodCBlbnRpY2UgcGVvcGxlIHRvIGFkZCB0aGVtLiBWZXJzdXMgbG9va2luZyBsaWtlIHNv
bWUgaG9wZWxlc3NseQp4ODYgc3BlY2lmaWMgdGhpbmcuLi4KCj4gCj4gPiArwqDCoMKgwqDCoMKg
wqAvKiBOb3cgc2VlIGlmIGl0IGNhbiBncm93IHRvbyBjbG9zZSB0byBhbiBhZGphY2VudCByZWdp
b24uCj4gPiAqLwo+ID4gwqDCoMKgwqDCoMKgwqDCoGV4aGF1c3Rfc3RhY2tfaW50b19zaWdzZWd2
KCk7Cj4gPiDCoCB9Cj4gCj4gT3RoZXJ3aXNlIGl0IGxvb2tzIGZpbmUuCgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
