Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8A7EB64DA
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 15:48:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 443993CE985
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 17:48:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBF3B3C0222
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 17:48:02 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EADCB6010E7
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 17:48:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689868081; x=1721404081;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=t8ubDq1kqhO5Cvy9lCEvnXStSExpVmFo0DMkR0X9TZE=;
 b=C+VulvD9Je3MD0mdMkkoOfJHDzg4Pz4REwyW3W44XBDrIEFJY58TvwFe
 HE1oja5PzSpA5H+HmzrP1y+KEpd10dSE6iVqob/J1cRC39G7ugV/kTkUz
 V2zv9UMaDZ4K9JrUkEuSSCUWRMQDukRqSAduFIrXLSVHp+6Bt+7qMHLgz
 lMafARPoCztPq2xNp1gLvgYwKfyU+zYkbJdycjmYIEYt4HizIemUw6aOi
 Ixiwsa47BbMK/TCj7ZQI0eLkkQzDqfVv3d9oexb4hKF/0BsXX+eVLPDmh
 eQi5KgRu+fRaTnu/W5LrP582YPfGnSi93XcCtw8lq2bJywEO4fB1iCH50 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="370371132"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; d="scan'208";a="370371132"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2023 08:47:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="838177596"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; d="scan'208";a="838177596"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga002.fm.intel.com with ESMTP; 20 Jul 2023 08:47:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 08:47:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 08:47:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 08:47:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 08:47:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnYxjuACaxzfa2Kxs2axAj/CeCjRi/+vkCFge+ppEWSBz8Y3Mhmw6mjkTJyw0ozK/JDvcCrR2R5UE+gO9qpVYtUwoPGKBo9ZaZ6Wk6vGIXqv2/NhtijyYvQJIeYeKKeGEUo2cZZSwOWtyBAfsb0+UlpRg9In2nBn1EI4/0eTr5zJyt3dTtdxyhEfEtgfl0lQi21HxtFETtadYJ82sDlaxsBO+nA1yGEvSj7NmFtpms0DIQ+QyDannOANEFUGMLmL3fjaCDauTqmWsaqBS/ijdOXM1O/BIlxfRTaanxhHq8CEZMi45OsbgzoFti0xZugHG05fjVps1jIls9jA6EV4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8ubDq1kqhO5Cvy9lCEvnXStSExpVmFo0DMkR0X9TZE=;
 b=cOkgXoBchxdY6kklROXmv3m1nXq8uNl40zLET7PBsoiYFZYU5lwgFlLR4em/Xc3aJa9Qh0+X1FHzYmrgiojjmD/TxddSmDM/vjwLkncsH1GkgEzd2fZEfardUT5JYAks2vffxTNsRtVfLBIUSs12PoQ4GOUCYY3M4K36o+Vb11afUHIMigAN7+C1FcrgrJFQGyfGo6hVfzUc/LFP9ZHG/nXWR2erbdCTkGFHzvkqS4bCeCu/QPjOvFGLmT3+QQJ+zNWmpAc0P489nt9w+abnwQSLuhwh5BCXHE2pQq6l+7wQpKk60/bWVG3sx6ajpiFxFTjZA2UyEgtEyYw9jGTwlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CO1PR11MB5137.namprd11.prod.outlook.com (2603:10b6:303:92::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 15:47:54 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 15:47:53 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pvorel@suse.cz" <pvorel@suse.cz>
Thread-Topic: [PATCH v3] security/stack_clash: Add test for mmap() minding gap
Thread-Index: AQHZtBm8PuJWdjTRHEGsjYmHQna02q+1yDEAgAD1LgCAAJv5gIALf8UAgAABm4CAAAApAA==
Date: Thu, 20 Jul 2023 15:47:53 +0000
Message-ID: <d16505061b521ce6bc5a1ad6a35f4bc98b258a19.camel@intel.com>
References: <20230711170335.13142-1-rick.p.edgecombe@intel.com>
 <20230712080936.GA756025@pevik>
 <504874fbc8cac972153d6592815c90af14b7a618.camel@intel.com>
 <ZK-wQ5cj39LnTPp9@yuki>
 <00ee0e896d7d385ec1b7e48dfccbada1c432360a.camel@intel.com>
 <20230720154717.GA1343882@pevik>
In-Reply-To: <20230720154717.GA1343882@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CO1PR11MB5137:EE_
x-ms-office365-filtering-correlation-id: b965efcf-30b2-498e-a02f-08db8938ae2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oZksD6xyFYTr/2ZdYDY8VDTXC2Gf07gLK8KmQRx/NIhnlGo2mvw18rVTUPalhXveVpdj2A/utOUEnXssyzkfVdLXJACrAYKWLWNnF6mVgiLV+1Zc3xLPQrvu5f03meDhk2xqTpOzFBrQtylxzEAan6DGvsYJN0rQVQ3NGTbcPqyRSg0pjyDTiYl4RD+v0mFvdS8BDkG5eGeenT70de+wicGJed15/PiWLroacshPyGuZqh0SfW0iCEeO3qsW/L5Jw+3dKZ0KPhuWI0Ts2vnnvXJ+VJea+LcgftTk7aLYnboKoWHPFK6d9QB8aNcoYIy1pgubtZygmKkQ+GXxg2RUsZ9PemxowM/eDtbtwC/wrPX/9NZabvbQS2VYVd69lPT4rRqTEDxI8UpQ0F+ZFjKEoqBYGPu3vbMOFpCZCJdpIiL8UfRFSBcXldmg2G16EJKPdaW9si7c60/dGddS+hEHwxvaeJLCkrCCskohqDBzbVdWoFChkWKXgqTWKiWbxMf8vom7um4mUxEztyEAcHLUAke3PYFjhaonc1QfCfl4mrWyj+/f1fDI4SPdOvkTblu1TOGAQju39AHxnc7eDQu7mI1NdokBaJJSov7ksk5NN7aMD974x7/ZwD7k81GNnE69
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB5963.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(66556008)(66946007)(64756008)(66446008)(66476007)(91956017)(6916009)(76116006)(41300700001)(6512007)(6486002)(2906002)(8936002)(8676002)(4326008)(316002)(5660300002)(36756003)(54906003)(38070700005)(478600001)(38100700002)(26005)(4744005)(6506007)(2616005)(86362001)(186003)(82960400001)(71200400001)(83380400001)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djNKK3dCeVlNVTZ2SzB6Ri9sZmFudU9HOGtReE0weEVsNUNLR0IxdmZnc0hL?=
 =?utf-8?B?SGdKQ0RZREh6cDdVMjFmTmFGU09HV29wR25sYUFOYnU3RXhsaUJGbEQvVDZa?=
 =?utf-8?B?MFNNRmVJUGpDa2ZpWEs5Y1BVdmtqa1FBTkhSdDZPZzAzSUErTDNHbmlKL1Ey?=
 =?utf-8?B?Ti9XbER6cUlZUWltUUpQVmNGM3lBcnNJRU5UYkFoUDhLNmwwanAvdXg4dytu?=
 =?utf-8?B?cEZ3YTBTcjdZVThkL2lOdkx1RzNUQTRoSTRpZllBSG1DMUFmR2RnRGltcWQx?=
 =?utf-8?B?NEsvdEhEZEJJZ05xY2tobTl6eC9FcnNLTFJIUGR5QS9TbjVZd0dtYnloRXZX?=
 =?utf-8?B?M0lqVXpxYWVBYUNrZzFWVVhNYXlpRlZEaWUxMmxaS29lcnU0LzViZ0pnRnA1?=
 =?utf-8?B?N3JwVHJLQXA2OGppSUhxMXo3TFh3dDlDNWNwcWhsZmxUWVZNUGU0YW5MaVhN?=
 =?utf-8?B?SUMrMGRuRnVoeHlNZ1pXclNvd0piUDI0S0lLaFkzNnFRNHVTMDJqcEpJblM4?=
 =?utf-8?B?TktFY1dPN29RTVlLM3lyd2E0SWJiZDJPaXVxcWtXTGJjUUdMUTZ3VUxyNWhl?=
 =?utf-8?B?bSs3YXBxNUxoS29YYTBWOEdsWTkxTjZSL2VHWGluNks1VklDMDFQYWFoZ1VY?=
 =?utf-8?B?YmZhY1E3S1dhM2NsVmdIdFJIb1lud1B1TFhTSmxMN3pZVURBN0p5amhrZ0p3?=
 =?utf-8?B?UVRxR1V1cTRaNGhza1k4TUlvaGJUb2RRUllMVXJGajdrOU5xQ3lNYXRXUFp3?=
 =?utf-8?B?WXVZMnNiT1owOW00UWgvN0ZUaDVvWG1Nd3NvbnA3RUxvV0xRdXE2bzU2K0pU?=
 =?utf-8?B?RVhKY2duRHpSdHE3bUp0ZkhQcnd5RDlkdW43YWJDem9KWmplZnpYRnhzU2VT?=
 =?utf-8?B?VURmOVdYVGJOVzJpYlZNRXFRMU5pYWlCZjVVYlNkdDVuYS9YSjdOZW00SE1w?=
 =?utf-8?B?UEpOZ1Fpa0FQTklhMjdWZU8wM3FNUmRHRDRjRjZIQ3dZWXpDOVNuSEEwU05J?=
 =?utf-8?B?b1gxUjVXWldUT1hmRUJJYlhVeGVQYWQ5WHZ5WURSaHB5bTNzby9vVE00TXVz?=
 =?utf-8?B?cGlOeXRPVllnWDVSZ0NEcEEzbldXTzZGdWZOMFRrMzNPelZxcDU3a1JNL0dE?=
 =?utf-8?B?M0txVGFrWWZUOCtwK0hQZVJRdSt6cEg3aGd1dWxxUlB6empuQ3JPbDM5MFd5?=
 =?utf-8?B?enpySFBQWW93Z24yZzNpV091OUVzTWczSmNUVVVHOWpkcUFLVXpodzlQbXh3?=
 =?utf-8?B?SXZOZXQ1RXlaZU1pbXhnMUpOYm1nazZ3NWdZN204cE1vcTRCV3dFaDN1ZkVr?=
 =?utf-8?B?TEE3MGM1T1JaajBKMHJCQWJsWWZCbjJYSGlzamdRazJtSThKNW9UWVA1ZXhU?=
 =?utf-8?B?WUppOTlNUlJQekcyWHdoTHFRUGpQZnEzNDBIc0hoa0N2SEZQUm1OOTFQT3Yz?=
 =?utf-8?B?cHI0SzFTZzdTWVk4MXQ0U01xZldhUE9PVWpQSllOTmVJL1d1d0xocFBBWWxW?=
 =?utf-8?B?SXBOMzJRVGY0MXpQSEUzemluU2xPa1N5ZWlpcjdSbS9ZRFZHZjE4RDgxaXc1?=
 =?utf-8?B?QUhjY0kwUUdjUTdVc1dzT01weWtZUGc4cERwUzdTbWx4WGVEOUFTakRaaTJP?=
 =?utf-8?B?MHVUYlhnTHBYaVhZTmhTNVJacEpOeUp0b3paSVJVMWNWZEhWMjVPQzYxOERw?=
 =?utf-8?B?OWhHQlFoaEdYZmtzcmpJNWNEZGduNnpEUGUwVjZxMGpNYW5ZV1orcXJCNEs0?=
 =?utf-8?B?bUtOQTVlVml5eFZoTi9TdTFKL3k5YUt6NE9yRzQzTkU5L2F3V0VPMEdYUEpE?=
 =?utf-8?B?dFlLb2I0MHhOUGpkMjZiWkhzMDl0dW5wVW9LUzJLZzJqR3EvdHloT2JNdlZy?=
 =?utf-8?B?aWpuUmJxb3JLaFNVL040eWRjaGFJdFB4eWdNY1lsakFhMTZqYmU0Tk5BaXoz?=
 =?utf-8?B?TXV5Q0YraFYwY0VqcHp0QS94WDVEQTMzai9iZXUyNzRmWUJaRmJwVHhLVmdh?=
 =?utf-8?B?djlQMEdhQVgzWElKa2JTNDNMbkxNcmZwN012TkhkMnU2cXl6eWN5WjFka1NY?=
 =?utf-8?B?YmhWTW9kUDZMNnMxUllIbkpuYzdmbWlyaVU1MHhKSE1tOU1waFVXeVcwRDRu?=
 =?utf-8?B?bDJaNWtuR092YmU2MVJlUEJ1UC9WN0Y5SUhrVCtRQlZkQzZMSXBVdTNERE1Y?=
 =?utf-8?B?WUE9PQ==?=
Content-ID: <E1067ECBA258BB458F8A55300B7D3172@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b965efcf-30b2-498e-a02f-08db8938ae2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 15:47:53.5978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BNV7Xwj52ijDojlj7ZaHDJlr+UWppKZx/31Xa3Iwx6ikMYl9lyDT7fyb7913lQGsA5UKbjOyk/36Pq0qDV/3RtW6Y0egr3gE9NJFL1FoYw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5137
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
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

T24gVGh1LCAyMDIzLTA3LTIwIGF0IDE3OjQ3ICswMjAwLCBQZXRyIFZvcmVsIHdyb3RlOg0KPiBI
aSBSaWNrLA0KPiANCj4gPiBPbiBUaHUsIDIwMjMtMDctMTMgYXQgMTA6MDUgKzAyMDAsIEN5cmls
IEhydWJpcyB3cm90ZToNCj4gPiA+IEhpIQ0KPiA+ID4gPiA+ID4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLQ0KPiA+ID4gPiA+ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDgwIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+ID4gPiA+ID4gbml0OiBZb3UgbWlnaHQg
d2FudCB0byBhZGQgeW91ciBjb3B5cmlnaHQuDQo+IA0KPiA+ID4gPiBXaGF0IGRvIHlvdSBtZWFu
PyBJdCdzIG5vdCBhIG5ldyBmaWxlLi4NCj4gDQo+ID4gPiBQcm9iYWJseSBqdXN0IHRvIGFkZCAi
Q29weXJpZ2h0IChjKSAyMDIzIHlvdXIgbmFtZSIgdG8gdGhlIHRvcCBvZg0KPiA+ID4gdGhlDQo+
ID4gPiBDIGZpbGUNCj4gDQo+ID4gU2hvdWxkIEkgc2VuZCBhbm90aGVyIHZlcnNpb24gb3IgZG8g
eW91IGd1eXMgd2FudCB0byBqdXN0IGZpeHVwDQo+ID4gdGhlc2UNCj4gPiB0d28gdGhpbmdzPyAo
ZG9jcGFyc2UgYW5kIGNvcHlyaWdodCkNCj4gDQo+IEkgYWRkZWQgeW91ciBjb3B5cmlnaHQgYW5k
IG1lcmdlZC4gSSdsbCBmaXggZG9jcGFyc2UgbGF0ZXIgdG9kYXkgaW4gYQ0KPiBzZXBhcmF0ZQ0K
PiBjb21taXQuIFRoYW5rIHlvdSENCg0KVGhhbmsgeW91IQ0KCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
