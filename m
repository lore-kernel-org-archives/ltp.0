Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63429EB64DA
	for <ltp@archiver.kernel.org>; Wed, 12 Jul 2023 22:47:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70B873CECF8
	for <ltp@archiver.kernel.org>; Thu, 13 Jul 2023 00:47:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7ACFD3CB713
 for <ltp@lists.linux.it>; Thu, 13 Jul 2023 00:47:31 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EA0D41400104
 for <ltp@lists.linux.it>; Thu, 13 Jul 2023 00:47:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689202049; x=1720738049;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=UTtZO6l4dH2E8giJbmmRsLEcNkR/saFV9uUmQF+2yjQ=;
 b=KgDo2COay7DKM23YCgV7uFuHC5QNkhAThGBKdRncvXiUG8hLcTf8d0E1
 TA/Z8ru7OgwKlMBHsQhis9kmeKRpnrc4xrSUS41DkbwvsLW04S5qeXnnM
 ehjYlryoq8zCJd/eG+5eUbNYqXq+ewPYVUqmdVBv3ZhV9WisnBdCurQCn
 AOzciilV7d1Rv3b3469ZWv+CDCsaTPP6EkdGemfKgm2t+FUxxq+Nuvl20
 N4grTKJtUpbo5TUKHJBVzhbZK7e5A/fU3K3Abk0+wn2GhkDM/5Qu+uZ04
 SAQkwnmnpclAk0iVbJhy9Ovl59rKNYkNjdoSrfiirOAcwnTHuH5el2EPP Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="344622321"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; d="scan'208";a="344622321"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 15:47:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="751345591"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; d="scan'208";a="751345591"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga008.jf.intel.com with ESMTP; 12 Jul 2023 15:47:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 15:47:11 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 15:47:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 15:47:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 15:47:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOXVOTXadKPbOvud92OyaqPdPCAvdHWHT9dBqOLMlNzHVFKfKcvOdAqcsxe1UlPb1Yamyb7zfJbsc+8jtj8xAJXDI2nUrVNUTvZWX/YbbUoINsSMKqMQwnXv5NdrNewh8PCmhRDEODJufLD/8EiFT/x8i+ja4fLuOsPjfALfFwhS5q4Cr580inlOZQtGZvjjyD5xpJF+A33DexJ9BqWHMtesjLSRr4FDm/S3uxstnXrQKv0iqeYC5zL4oIe2vbWbRsKE2RqAaLJho5ZXgbHNHvRZJMBMUPq6zjDbnyHOED4oej9KYqLRvItsq1SAXtpuXTYQchqj7soxOto468WQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTtZO6l4dH2E8giJbmmRsLEcNkR/saFV9uUmQF+2yjQ=;
 b=UI45AJfWQkrF8XAUY5dthhlLMHjKUjjoFPjb1EjDURVRNZDMk35XTJDjbxWWCYcpuec/OsxfEo9/9Nv81NZoNs7mqY5YQ7v0uM0BJDG9D1NwI36MYElP3ZWmfdWexK/CMWGe1HZxc8p6AkBjJ7+LUwCCJYVNcidyXM1Eod6JVbkSD1KIxX870W62SAcOUi2xyEXYFVhVFmuq+dkp8Gd5st9lQm3353fdmoMiQtW2MLo/+eJmA4nMRMakFm4vaxsMkd+jHYExUms0wUo2XpUXHn0W62s62G4xci7heZ1GYe7DB9//UksQqjO78gEl3fchcSMLVGQ9tfvSskYYEOMAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM4PR11MB7205.namprd11.prod.outlook.com (2603:10b6:8:113::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 22:47:09 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::ac6b:a101:ff02:a1bb]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::ac6b:a101:ff02:a1bb%3]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 22:47:09 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pvorel@suse.cz" <pvorel@suse.cz>
Thread-Topic: [PATCH v3] security/stack_clash: Add test for mmap() minding gap
Thread-Index: AQHZtBm8PuJWdjTRHEGsjYmHQna02q+1yDEAgAD1LgA=
Date: Wed, 12 Jul 2023 22:47:09 +0000
Message-ID: <504874fbc8cac972153d6592815c90af14b7a618.camel@intel.com>
References: <20230711170335.13142-1-rick.p.edgecombe@intel.com>
 <20230712080936.GA756025@pevik>
In-Reply-To: <20230712080936.GA756025@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM4PR11MB7205:EE_
x-ms-office365-filtering-correlation-id: 9532d42d-728c-40cd-3ea1-08db8329ecb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AQ/SskAO0fLzXGrchxLu8/TTbnMhzqUfS9tU0bo6hKCWR0SS8n4VmraZEEuWvoXXhBfh3Jwyh8gq3iHcyFScBmkHjcIvatbMiaH8Z8f89PhRtTQzAldU6cV2FlOQnJN9TcE26gki4a8NTIBYnwVnI74kAIYf9AzfCU8TwMEATf/a2XZkeHqpDSHOhiRcIReYQswS3waKT3qM3aG8RZV0zKBAtmMUwU6Zr9ac/4gSvswrBbg+UZppYqF+0CafRFnGpWecvoXddKhZNYQpepdWrIXQes4rov4olRDp9lsxeJViEcBDxE4PDqiHpQoDjnEoQBeMgKlIE41+zXttlchU+jzJKOrIIU/qde1Yl76HqgoMg1PH3MLXjMmtNC+MtdTGoQo3Jiqafc2e076sI4JMnRhnHcBqQS87pCtSyzakYuszo9zJQgaxAda1xQFJIXiBl1DS14RFbUcIhGccYSfhE+lex227EyuxpPeSia5EXeom8WkcqfiYFmm0HAg7BBursWspzA7UggwuXZSHjThxObl/T4YULafZUiZg3uE/I2EGWDMVpI7VqL0x2m6y2yeQFVcFHN6EHcaZ52GQrs3VDIKoAws8o+juis0D3qivCNY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB5963.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(83380400001)(86362001)(8676002)(8936002)(186003)(2616005)(2906002)(36756003)(15650500001)(5660300002)(26005)(6506007)(82960400001)(122000001)(71200400001)(54906003)(38100700002)(76116006)(66946007)(64756008)(66446008)(66556008)(91956017)(6486002)(4326008)(6916009)(66476007)(478600001)(38070700005)(41300700001)(316002)(966005)(6512007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3JtL2dBb3BjSCtVTEVXamFjQXp1OStvaytudEQ3eGxJMWpyVEtRM1l0Vzhp?=
 =?utf-8?B?eUdzWitCRXhMYy9ZNTdVRGpOalg0Z2pORWtxd2FkNHd0aUdjMmdPMVRkZ3ll?=
 =?utf-8?B?Nm5mVnpPb2tPZk14aS93UlpDdUlBaVRUZVRQQTJoeEpnVjd0alRpazZpVEdm?=
 =?utf-8?B?NEUzeXNMZmNMOGg4YThybDhWMEtMaC9BVlhNdlMwT2ZNamtMWXNBQ0lmWFh5?=
 =?utf-8?B?RzN4dUlVUlM1RnRKTXVFbGhocCtwZmZGTmtQSG10ejdGd0FoWHVKbTBYVjVC?=
 =?utf-8?B?aVg5NE1ZbnJJUUVxMjJvQ3pLRGZJbVpiaTM4eUFuUldZYUJYMjVzYVF5YWRJ?=
 =?utf-8?B?TlNTeSt0U1Frdnd2WWhXdHNQenZ2ZFRXVHcrZGVSZXBXY3Facm1zYU1lMGhk?=
 =?utf-8?B?OHZTVDBncnNkVWxadkhWaEsyQ0JNZnRyczlUSGRuUk1EcTgzT3pRb3RqWXpI?=
 =?utf-8?B?NThneHY3VkkzbHFBQzRsTjJCL0ZHWUpGanlNcEVIdUpTMVh6Mk5xbURkSlUw?=
 =?utf-8?B?M2prdHhNV0FVYjhrS2RJd0FsNlNLZG01VzE5V2d6bkFqbWh1Vjdjd2x0NUdI?=
 =?utf-8?B?YnpsYWVqZmVHSmZ5Mno2ckxud0swbTVhbXFxa0ExNzIvZUdad3JsV3BZYTJZ?=
 =?utf-8?B?ZUdJNHRKNjNNbTkzcVhkZ3BSTjhjclBQY0hYNEVsRlRNZGcrWFVPOWNxRWhu?=
 =?utf-8?B?QVd2M0NzR0VOOHRnb0pjdWVxaXpQSzdrdWFMVFBuWkZCTC9yWmVISUVsazdW?=
 =?utf-8?B?bS9NNWhLT2ZmTVdCcGtrSVBqcnBFRytkNXExY0tGUEh2TmV6ZTBkc0xyWnB4?=
 =?utf-8?B?RWxCZFpJV1N2eVdVelJ2bHBGajVsVWdWUTlpR0xYTzlvcUtKNmRzWWJ6bmlN?=
 =?utf-8?B?Sm1mMWltVHo1bEN5SGdobmdKYnRhNlY4UGZ5anZKcEFiUXlSVzF3cWNhZjQz?=
 =?utf-8?B?VTFnSXNCZEFnU1dsWVJCMXhvM3Y5UVlidVZtbFcxSSsxc21XQzZISld0THQv?=
 =?utf-8?B?UnZNZGwxa01JRmxaNUJ6WTJKQVA0ZEtKQmFjOHV0TzV1aGVLOStIY1JPeG9y?=
 =?utf-8?B?QUpnL1d5QXU4bzd6eU9KZGlya2Y3bGlRUVhFaytQdVNneFdPdWJFNCtUOXpt?=
 =?utf-8?B?MFo4YTM0MGFMV1JxZFh6eEpFQy81c1UzaXVmVm5QOEJjU25UNUxIYjN5anBQ?=
 =?utf-8?B?RWtLWDNjSnhXdDc0Z2dZZ3ZkRFB5QTllaHBFT2U3VVF0VjdMWVZaVkFYQ2dS?=
 =?utf-8?B?RUNSZ3JBdjlLeUE4N2YvNW9zcmY5OExsUFNBVDBKNDhhUVZlSks4eDEzV2Q1?=
 =?utf-8?B?Zk9JNDNYNDhoaFlZY2U1Y29URFNxUFROSkJoOEh6VlZ4aHUvM0xkL3dsUG4y?=
 =?utf-8?B?RENwdEk3Y0RubGliSDJnTDRkeENyaDZGc25Ya0hteUpIN2syc1RObnJGcnIy?=
 =?utf-8?B?anRwQXhjaHdaUWR2bDdSeFFNaHkwYzJ0RUdNRmw4bXQ5WFhBNFNrek9yNnRK?=
 =?utf-8?B?SnF6eEJQMzRTRStBN09vQWpRbHBUQ1pCZ1ovbFd1TVJGYlU4amxNUjFTZ1lk?=
 =?utf-8?B?TzJkMTcxYzViWGFHV2taRi85d0pkcEFvZGEyaGVzZTkvQ3Nqc2lyNWpBK1BU?=
 =?utf-8?B?ZXhiTDFkTVBYOXlMMC9nVWtURFdDZjhIcTdmZWpQSkdXTVdiTm9DdWdIU0s5?=
 =?utf-8?B?d2xVbXQwMkJFR08rT01XTTJLVkVhSXBRRU1JMlJzY0MwUEZaVjdPRzZvM04w?=
 =?utf-8?B?eENCWFdteThzelFGbTZ4WGZwYkRLV21rL0UzZ0dlTW5oQ25nYVM0YWg1Nnha?=
 =?utf-8?B?bUx4WjhNYnZrTUMzVHQyNXZaRGtrOE4zRXMyK1pjclQxL1k5MWZtVUZIdE5l?=
 =?utf-8?B?MW04b0laV2ltZzl1SERLQ0ZCd2NhQWRZai9ZMVNlS3ZrMy9QampudVN0a1ZR?=
 =?utf-8?B?Q2dscEJlZ3N2WkRHS25lYmNxTFozNW9qalZTQ0tzWklTWmdUcmFrajllN0Fh?=
 =?utf-8?B?VXJFNzhvWlNOQTNMckhmelNxK2JPQ2NFY2J6MHBEQVZvWjQrUjM2NWFGY1Aw?=
 =?utf-8?B?ZUtaNDNvUlAvMHlIL0JCbUk2cWM2QkJwWGFubTE4LzJWaDdYMmZQZEJNUWpU?=
 =?utf-8?B?dGlrV2FDeVlWQmVhR05iUWZpdFlLcW15MHU5M3JaWlBTTFowcDIzNU9wOG41?=
 =?utf-8?B?c2c9PQ==?=
Content-ID: <18B9B5535B433949B0690595A9EBEF72@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9532d42d-728c-40cd-3ea1-08db8329ecb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 22:47:09.1275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXcsdUoJX0yMtu7W6uTGPC6PSUI3Ar0ahp+BTPcssxCIAj61ru1KHJbtmeBXnX84O70vCDX2bqyQqWap8mQTKXQtjucqVql3yllPl8U62AM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7205
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
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

T24gV2VkLCAyMDIzLTA3LTEyIGF0IDEwOjA5ICswMjAwLCBQZXRyIFZvcmVsIHdyb3RlOg0KPiBI
aSBSaWNrLA0KPiANCj4gUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pg0K
DQpUaGFua3MhDQoNCj4gDQo+IC4uLg0KPiA+IFRoaXMgbG9naWMgaXMgc29tZXdoYXQgeDg2XzY0
IHNwZWNpZmljLCBidXQgbWF5IHdvcmsgZm9yIG90aGVyDQo+ID4gYXJjaGl0ZWN0dXJlcy4gTWFr
ZSB0aGUgdGVzdCBvbmx5IHJ1biBvbiB4ODZfNjQgZm9yIG5vdy4NCj4gLi4uDQo+ID4gdjM6DQo+
ID4gwqAgLSBVc2UgbGFwaS9tbWFwLmggKFBldHIgVm9yZWwpDQo+IA0KPiA+IHYyOg0KPiA+IMKg
IC0gQWRkIGZpeGVzIGNvbW1pdCAoQ3lyaWwgSHJ1YmlzKQ0KPiA+IMKgIC0gUmVwb3J0IHBsYWNl
bWVudCB0ZXN0IGZhaWx1cmUgc2VwYXJhdGVseSAoQ3lyaWwgSHJ1YmlzKQ0KPiA+IMKgIC0gVXNl
IFNBRkVfRklMRV9TQ0FORiAoQ3lyaWwgSHJ1YmlzKQ0KPiA+IMKgIC0gRG9uJ3QgcXVpdCBhZnRl
ciBmYWlsaW5nIHBsYWNlbWVudCB0ZXN0LCBzbyB1bm1hcCB0aGUgbWFwcGluZw0KPiA+IHRoYXQN
Cj4gPiDCoMKgwqAgY2F1c2VkIHRoZSBmYWlsdXJlLiAoQ3lyaWwgSHJ1YmlzKQ0KPiA+IMKgIC0g
RHJvcCBDQU5fRE9fUExBQ0VNRU5UX1RFU1QgKEN5cmlsIEhydWJpcykNCj4gPiAtLS0NCj4gPiDC
oCB0ZXN0Y2FzZXMvY3ZlL3N0YWNrX2NsYXNoLmMgfCA4MQ0KPiA+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0NCj4gPiDCoCAxIGZpbGUgY2hhbmdlZCwgODAgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gbml0OiBZb3UgbWlnaHQgd2FudCB0byBhZGQgeW91
ciBjb3B5cmlnaHQuDQoNCldoYXQgZG8geW91IG1lYW4/IEl0J3Mgbm90IGEgbmV3IGZpbGUuLg0K
DQo+IA0KPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMvY3ZlL3N0YWNrX2NsYXNoLmMNCj4gPiBi
L3Rlc3RjYXNlcy9jdmUvc3RhY2tfY2xhc2guYw0KPiA+IGluZGV4IGNkN2YxNDhjMi4uNTBhNDAx
ZTk2IDEwMDY0NA0KPiA+IC0tLSBhL3Rlc3RjYXNlcy9jdmUvc3RhY2tfY2xhc2guYw0KPiA+ICsr
KyBiL3Rlc3RjYXNlcy9jdmUvc3RhY2tfY2xhc2guYw0KPiA+IEBAIC0xOCwxMSArMTgsMTggQEAN
Cj4gPiDCoMKgICogdG8gaW5maW5pdHkgYW5kIHByZWFsbG9jYXRlIFJFUV9TVEFDS19TSVpFIGJ5
dGVzIG9mIHN0YWNrIHNvDQo+ID4gdGhhdCBubyBjYWxscw0KPiA+IMKgwqAgKiBhZnRlciBgbW1h
cGAgYXJlIG1vdmluZyBzdGFjayBmdXJ0aGVyLg0KPiA+IMKgwqAgKg0KPiA+ICsgKiBJZiB0aGUg
YXJjaGl0ZWN0dXJlIG1lZXRzIGNlcnRhaW4gcmVxdWlyZW1lbnRzIChvbmx5IHg4Nl82NCBpcw0K
PiA+IHZlcmlmaWVkKQ0KPiA+ICsgKiB0aGVuIHRoZSB0ZXN0IGFsc28gdGVzdHMgdGhhdCBuZXcg
bW1hcCgpcyBjYW4ndCBiZSBwbGFjZWQgaW4NCj4gPiB0aGUgc3RhY2sncw0KPiA+ICsgKiBndWFy
ZCBnYXAuIFRoaXMgcGFydCBvZiB0aGUgdGVzdCB3b3JrcyBieSBmb3JjaW5nIGEgYm90dG9tIHVw
DQo+ID4gc2VhcmNoLiBUaGUNCj4gPiArICogYXNzdW1wdGlvbnMgYXJlIHRoYXQgdGhlIHN0YWNr
IGdyb3dzIGRvd24gKHN0YXJ0IGdhcCkgYW5kDQo+ID4gZWl0aGVyOg0KPiA+ICsgKsKgwqAgMS4g
VGhlIGRlZmF1bHQgc2VhcmNoIGlzIHRvcCBkb3duLCBhbmQgd2lsbCBzd2l0Y2ggdG8gYm90dG9t
DQo+ID4gdXAgaWYNCj4gPiArICrCoMKgwqDCoMKgIHNwYWNlIGlzIGV4aGF1c3RlZC4NCj4gPiAr
ICrCoMKgIDIuIFRoZSBkZWZhdWx0IHNlYXJjaCBpcyBib3R0b20gdXAgYW5kIHRoZSBzdGFjayBp
cyBhYm92ZQ0KPiA+IG1tYXAgYmFzZQ0KPiA+ICsgKg0KPiA+IMKgwqAgKiBbMV0NCj4gPiBodHRw
czovL2Jsb2cucXVhbHlzLmNvbS9zZWN1cml0eWxhYnMvMjAxNy8wNi8xOS90aGUtc3RhY2stY2xh
c2gNCj4gPiDCoMKgICogWzJdDQo+ID4gaHR0cHM6Ly9idWd6aWxsYS5ub3ZlbGwuY29tL3Nob3df
YnVnLmNnaT9pZD1DVkUtMjAxNy0xMDAwMzY0DQo+ID4gwqDCoCAqLw0KPiANCj4gRG9jIGNvdWxk
IGJlIHR1cm5lZCBpbnRvIG91ciBkb2NwYXJzZSBmb3JtYXQgKHRvIHBsYWNlIHRleHQgaW4gb3Vy
DQo+IGF1dG9tYXRpY2FsbHkNCj4gZ2VuZXJhdGVkIGRvY3VtZW50YXRpb24pLCBidXQgSSBjYW4g
ZG8gaXQgYWZ0ZXJ3YXJkcy4NCg0KT2gsIHNvcnJ5LiBJIGRpZG4ndCBrbm93IGFib3V0IGl0Lg0K
DQo+IA0KPiAuLi4NCj4gDQo+ID4gK3N0YXRpYyB2b2lkIGRvX21tYXBfcGxhY2VtZW50X3Rlc3Qo
dW5zaWduZWQgbG9uZyBzdGFja19hZGRyLA0KPiA+IHVuc2lnbmVkIGxvbmcgZ2FwKQ0KPiA+ICt7
DQo+ID4gK8KgwqDCoMKgwqDCoMKgdm9pZCAqbWFwX3Rlc3RfZ2FwOw0KPiA+ICsNCj4gPiArwqDC
oMKgwqDCoMKgwqBmb3JjZV9ib3R0b21fdXAoKTsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKg
LyoNCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBmb3JjZV9ib3R0b21fdXAoKSB1c2VkIHVwIGFsbCB0
aGUgc3BhY2VzIGJlbG93IHRoZQ0KPiA+IHN0YWNrLiBUaGUgc2VhcmNoIGRvd24NCj4gPiArwqDC
oMKgwqDCoMKgwqAgKiBwYXRoIHNob3VsZCBmYWlsLCBhbmQgc2VhcmNoIHVwIG1pZ2h0IHRha2Ug
YSBsb29rIGF0IHRoZQ0KPiA+IGd1YXJkIGdhcA0KPiA+ICvCoMKgwqDCoMKgwqDCoCAqIHJlZ2lv
bi4gSWYgaXQgYXZvaWRzIGl0LCB0aGUgYWxsb2NhdGlvbiB3aWxsIGJlIGFib3ZlDQo+ID4gdGhl
IHN0YWNrLiBJZiBpdA0KPiA+ICvCoMKgwqDCoMKgwqDCoCAqIHVzZXMgaXQsIHRoZSBhbGxvY2F0
aW9uIHdpbGwgYmUgaW4gdGhlIGdhcCBhbmQgdGhlIHRlc3QNCj4gPiBzaG91bGQgZmFpbC4NCj4g
PiArwqDCoMKgwqDCoMKgwqAgKi8NCj4gPiArwqDCoMKgwqDCoMKgwqBtYXBfdGVzdF9nYXAgPSBT
QUZFX01NQVAoMCwgTUFQUEVEX0xFTiwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUFJPVF9SRUFEfFBST1RfV1JJVEUs
DQo+ID4gTUFQX0FOT058TUFQX1BSSVZBVEUsIDAsIDApOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDC
oMKgwqBpZiAoc3RhY2tfYWRkciAtIGdhcCA8PSAodW5zaWduZWQgbG9uZyltYXBfdGVzdF9nYXAg
JiYNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKHVuc2lnbmVkIGxvbmcpbWFw
X3Rlc3RfZ2FwIDw9IHN0YWNrX2FkZHIpIHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgdHN0X3JlcyhURkFJTCwgIk5ldyBtbWFwIHdhcyBwbGFjZWQgaW4gdGhlIGd1YXJkDQo+
ID4gZ2FwLiIpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBTQUZFX01VTk1B
UChtYXBfdGVzdF9nYXAsIE1BUFBFRF9MRU4pOw0KPiA+ICvCoMKgwqDCoMKgwqDCoH0NCj4gPiAr
fQ0KPiA+ICsNCj4gPiDCoCB2b2lkIGRvX2NoaWxkKHZvaWQpDQo+ID4gwqAgew0KPiA+IMKgwqDC
oMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIHN0YWNrX2FkZHIsIHN0YWNrX3NpemU7DQo+ID4gQEAg
LTE3OSw2ICsyNTIsMTEgQEAgdm9pZCBkb19jaGlsZCh2b2lkKQ0KPiA+IMKgwqDCoMKgwqDCoMKg
wqBkdW1wX3Byb2Nfc2VsZl9tYXBzKCk7DQo+ID4gwqAgI2VuZGlmDQo+IA0KPiA+ICsjaWZkZWYg
X194ODZfNjRfXw0KPiBJIHdvbmRlciB3aGV0aGVyIHdlIHNob3VsZCBjb25zaWRlciAzMiBiaXQg
YXMgd2VsbDoNCj4gDQo+ICNpZiBkZWZpbmVkKF9feDg2XzY0X18pIHx8IGRlZmluZWQoX19pMzg2
X18pDQo+IA0KPiBPciBpcyBpdCByZWFsbHkganVzdCBmb3IgNjQgYml0Pw0KDQpJdCBpcyBwcm9i
YWJseSBmb3IgKm1vc3QqIGFyY2hpdGVjdHVyZXMgdGhhdCBpbXBsZW1lbnQgdG9wIGRvd24gbW1h
cA0KYmVoYXZpb3IuIEkgdGhpbmsgMzIgYml0IHg4NiBpcyBub3Qgb25lIG9mIHRoZW0uIEkgaGFk
IHRob3VnaHQgb3RoZXINCmFyY2hpdGVjdHVyZXMgbWlnaHQgZW5hYmxlIHRoaXMgdGVzdCwgYnV0
IEkgZG9uJ3QgaGF2ZSBhbiBlYXN5IHdheSB0bw0KdGVzdCB0aGVtIGFsbC4gdjEgYWN0dWFsbHkg
aGFkIHRoZSBlbmFibGluZyBjb25maWd1cmF0aW9uIHNlcGFyYXRlZCBvdXQNCmEgbGl0dGxlIGJp
dCB0byB0cnkgdG8gZW50aWNlIHBlb3BsZSB0byBlbmFibGUgb3RoZXIgYXJjaGl0ZWN0dXJlcy4N
Cg0KPiANCj4gPiArwqDCoMKgwqDCoMKgwqBkb19tbWFwX3BsYWNlbWVudF90ZXN0KHN0YWNrX2Fk
ZHIsIGdhcCk7DQo+ID4gKyNlbmRpZg0KPiAuLi4NCg0KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
