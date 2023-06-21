Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB62DEB64DC
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 14:22:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D83983C6335
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 16:22:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B8213C6335
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 16:22:46 +0200 (CEST)
Received: from CO1PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3B2552009FB
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 16:22:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmmWRUrkM4cXj1BJMrppSs8IgIqXvQFaGOXaPQNnFaZ6X968efO5pd6MCRiwbfpPIOOCrIM2xBWGWKtTek5XrB4m0nWfQBiKZ7/vrMY1P+EQhFmvFMWz315oIwB6iCa0A+ZI+4cUH7mIrqVlllk4+TcCPfTE5sbt6DOMQmsCr57vnipU9kbP5sGvleuYS9A7A8Z/IEgxPXAtphx3++/dV8PPYMcc+c8gzD0C6ysP/05Cp8UmSuvzfkIT/6e0MHB585+SXo8MKvhh/LhjAsACX+JHqfIdadhSvL8CWHM0SLBhYp2sg5JpjUlE4GoCBCQ1+in7YUOIyJSPtIMtsyFYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JF8wxWQXGIHyLdXiXaauN2C3K4aV9OfVW9A0wD2K9SE=;
 b=bBRVDjcPD/6Y+AT//gOC+S04SqJDLtkJsZAmBq1ruljMyFF1ptPPpUodkisWp2JY28WVP81Kiu5JlyEuVaybtzChsKmTE8OlXTFRb+Y9lCLoDcujIDvfkTUzeqbFKNuZn3joSaqcIHux2cIERccKq0MrI4OM0s4FTj9jt8Lc2fJ0WqZjmM8Z+hN18YEY15HscpsVwVV5mAlxsqzyqQcBS7+WVAyLwnzWKb69B6NzlUBCUB1Wz5XLzc1t9SC71DFKsMOtDi7w9tUX8edKiusPRoryPkg/sEP7kT6+HCp0PKGtyzaz3KAgyxQw4qSdK8cEd3PFNiq4/0Ifk4LFm5eEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF8wxWQXGIHyLdXiXaauN2C3K4aV9OfVW9A0wD2K9SE=;
 b=v7JhioF3i5v8qm7Y/LVyH8xSKnQtRh/q4ebGP4D2en/S1pFWm9/aukX8xLttqrzfQ428FcZUdc3LhMHXdwTss1wCBN+EvM82sTzbxkDogDEiW1Pqt1sGeAqSH8i8JmgcdPPbtVcjcevkW6x9s9zSrGHsuV/pwtiICQ+HjWgSqRw=
Received: from BL0PR05MB5409.namprd05.prod.outlook.com (2603:10b6:208:6e::17)
 by CH0PR05MB10229.namprd05.prod.outlook.com (2603:10b6:610:18d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 14:22:41 +0000
Received: from BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::68a4:3da6:4981:4793]) by BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::68a4:3da6:4981:4793%7]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 14:22:41 +0000
To: Petr Vorel <pvorel@suse.cz>, Ashwin Dayanand Kamat
 <kashwindayan@vmware.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] sctp_big_chunk: Do not use md5 hmac algo if fips
 is enabled
Thread-Index: AQHZo5k3Qi3mcEdQ1EqnVWVWOBu/C6+URTKAgAB89YCAACg0gIAAS8IAgAAY24CAAF0lAIAAAI6A
Date: Wed, 21 Jun 2023 14:22:41 +0000
Message-ID: <7CB6AC61-0289-41B3-BA50-A1753456EB6C@vmware.com>
References: <1687280634-5906-1-git-send-email-kashwindayan@vmware.com>
 <20230620222603.GB340710@pevik>
 <01C96D39-2B2E-44EB-A5D7-41BF26D2C2AC@vmware.com>
 <20230621081711.GA361973@pevik> <20230621124820.GA464557@pevik>
 <442F1FEF-AA44-4CC8-9809-6D99912CD063@vmware.com>
 <B4BE4EDF-B94F-49F0-A624-CF2810A4E112@vmware.com>
In-Reply-To: <B4BE4EDF-B94F-49F0-A624-CF2810A4E112@vmware.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.72.23043001
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5409:EE_|CH0PR05MB10229:EE_
x-ms-office365-filtering-correlation-id: c080428c-3d57-4772-e2dd-08db7262f8ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HUKVkdWdPd+hehXk9xXHODMN2AMBSIvs+9vZonxRr/Rr6tZKjX5lJMs3PukRLddIPVb6ljFs3848Qqlsv2ZuW8gogmzPH5X+TZUO/YtDtm/Qcxj+Ps7YUwyTHPWAuDSo/rS2ncFQwJngaEoxPD2jQ1JMgmHeB56jtvBuSrwWFwixckQg3NnPviYIxgED87ua+Mzj3jKvqAdWMJ5sHTVqVsMJC60XT9xuNU5pDAfwahDJ8dsxLqZyYH2W6pyrCm4+vqCmE8ZUqOBL4u1B5VcnpCu799xO4TcWxeXf1V/fsMioeOSmp7b5e4emFrwmebX7XATc+TPALlEln9AsIzHUgSvvNLxFsaxLcdDpXrX3STBi7m9Pc6Fz0mi8tkUVz/U6e2Wbife3snjTgPr5lKu419ZpNFyQtmg8ue93enGeMpUMuR7w7OgR82UKJLpApTJartAyXbxn6IJDkaFanGVFygvYZNFztef+CUZ8ryycjzRLPn0m4aYYmdoNZLrAtKI/GhbfqnYtr8utINf00tQvPoo26LkV8lDACGGMXaISjiJwvBSzQ9eiGNYQUQtQSvWvgsVJweDb4lgUvQkk0F/bFbmkte0Rfm1UTYVnAJbwCoHd2yiIySVls/Wo3Ohrb7ye1uPlTiOQ7ViJ1cUV/7t0mYIz2evkEiHEpo6d06JLsXzI5cMDWJuYlSFMULJp71+4lIj0uub7ODh1ktErV9SNYAMejH1SSaEit6IryEJw3NzPrmZBmHtqXBChle6SWiAW63Q4TTLrfA/K/Xwys+M1LA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR05MB5409.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199021)(6486002)(966005)(38100700002)(83380400001)(53546011)(107886003)(186003)(6512007)(6506007)(71200400001)(2616005)(33656002)(122000001)(36756003)(91956017)(76116006)(316002)(4326008)(66556008)(66476007)(66446008)(64756008)(38070700005)(66946007)(2906002)(8936002)(8676002)(86362001)(5660300002)(41300700001)(54906003)(110136005)(478600001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGxjQXhkK1ZUTU5veXJOL0pTcTVialdvUFBUdFNXRTAzTTIyN1NJd3IyWkxJ?=
 =?utf-8?B?QzJGRnVoQXZQbC9ta0gyb1dlZjFKWTJ0RUVIWjJ2VFNSYjB1MGRvckFncXB2?=
 =?utf-8?B?RWlGcEJmRXFqcEFycHRzMFQrNzd1SGIvOERjN2RjM3NsNDVOWHlzVEQzSDVR?=
 =?utf-8?B?S29uZUtTYmhCSTBkUi9FaFpISTJHVkdXS3Uxc2N3SlpTaTNXZ1p6ZFh1TWJa?=
 =?utf-8?B?YUpzYmE4cmNzRWx2OFNkSW96UEswclpucnpsQzAxK1hGZXBaL21PYjlFUSt6?=
 =?utf-8?B?aUc5S0JVQytGTkNTZTdnUmdsOTZiYzkzUlpXemxvbkI3bE11RkpXYU9PcGF5?=
 =?utf-8?B?KzhlbkZ3TnErVzZmVm5vdFZieUJPSGZhbHNhYnZFdmh4WE5RcmZGaFdEdk1Z?=
 =?utf-8?B?T2V6ZC9oalNhVElpT1plMnlVSXZwTVo2ME4vRmpHUWljK1dNRVh6YjBOYUVL?=
 =?utf-8?B?bE51d0F4ZFh1SldLOGx6L0ZZM2hyd3ZaVktOVG9QbUgrenk2QlNscTlrbzM0?=
 =?utf-8?B?QkUyTUs3ZFNWWHdXaWJWMWIyZ3BXN0QrQkRENmJlNzNETDZCNGVhMEFFUGpW?=
 =?utf-8?B?blluTTljK0NxcTUwMjh2U1BrYVNVb05HUlNqNldkTzV5K0FvUzg3T0tUOWJF?=
 =?utf-8?B?VzRrQytjRWxVUzJydXV2ei82SnlQZXR1UVU1V0RWamRnU2xSM2JqRW5HanFy?=
 =?utf-8?B?eUhtS1Z4bHRtTWVlWmNnUHMyMDNiK1hFajh6MWhLSVpjTnZwNlV3YWE0bGNG?=
 =?utf-8?B?N0VKRUx4U3AzLzhoOW94S25vS01SWktnVW84SjFXQ1NTUDNmT0prQ1NReWdw?=
 =?utf-8?B?VStMZ2NwMjVHdEZnM0cyYVdwaFN4ZG8vQXd6MDEvWnEyKzlGb3dabEdob2JS?=
 =?utf-8?B?YVdCS1VQK3QrZkZ5TWdLdTBya3ZmK3Zob2ZVMlVabW4vY3BNYjlmNzltdTli?=
 =?utf-8?B?YWdMRXdkOHFpMENvRkNGUjVHUlZZeDNtSnRmeFpuMmdDZXJlMEZtUko3VWxC?=
 =?utf-8?B?bVdUY2VrenlSUFRjUjk0TDBDSGUybWlEanRKZWhEREJQeVBpT2gxNjZRTFIz?=
 =?utf-8?B?RHNLaXhHZHFkbnI0TlNVZ3BVbGpCK2VpVkdvazNwdHBKVmNhbS92aklPeUdq?=
 =?utf-8?B?WE5aTmpiOXNqN1R6RlVLTWliSHBlUmNnL2w2WkVkdm5iUU1QM2NNdjl3WUpr?=
 =?utf-8?B?enZkSEFXS3JxTG5saGNGaGlDazBVRkg0SUsvSk4vQjlteU4vTTVUcG9GWmxl?=
 =?utf-8?B?dEJnTUpLRmNvSHEzN1oyc2hENE1QdlAyZ1pIZTlpSHNpT1J0SjlsS1pjQndm?=
 =?utf-8?B?bGxkUDBaT3llUVdqcUZ1aFJjNThpUjUrVi9XSXJkMUMwMTRtTVF6engzakZH?=
 =?utf-8?B?anJKcDVucVREMFkxa3NGbzNKUU5JelB0elNEQXVxVkl5SDREU2ZSMDR4YXl2?=
 =?utf-8?B?UGlrNzdFajlOazZxVm1tS2ZrUlBDSHZZMnA5VUxTbWhaN0hoWXRkTE9zeFN4?=
 =?utf-8?B?Sm1mOElKUXpLZTA2UmMxQ216akxmSWhOMlhNckhrOHZ3ZlM4VFd0RFJlT1BV?=
 =?utf-8?B?d3hYb0xpRzJ0UXkybFlaUGc5YTloTUtWT0NGU0JSejNzOWRFME5lOG9McVRp?=
 =?utf-8?B?a0loeUVwa20yVTVwTEpaaGl5TGRVN0lpZDlkQTFGV09icnJQZVRTMGNaVXZN?=
 =?utf-8?B?b3ZNVkVyK0Uxc1dGTWVDbFY4WW1DZkhRV2NUUVFPQ01oUEp6WDF6ei9FNm13?=
 =?utf-8?B?WFJpNW5mRjQ3WWpmM3pORkEvWEcweTgrd3pWRkZTNzlBdGRoYUtybFM1UnBU?=
 =?utf-8?B?cEZjNlRMTVhMblNGd1Q5VUo4SEx2WHo5dE11K0hVUXRPbE8ydERlWWhlc0Yy?=
 =?utf-8?B?VzNVOEVRbFQxSUM4K01FNlFlZkd4U0wwOVhGYUtMaWNJdDhrSjdyVXJ3cUF0?=
 =?utf-8?B?SFE2RjA2TmJsU1dzN0MyaUNZK3p4VlFxWXIyK3BNdDlnT0NMY1gwSnZ5M1dk?=
 =?utf-8?B?NFc4ZEpNUWdQUGcraHlsSDEzbkNncEg4QjZQMFRFbDdFdzVIaHRCSlNLVCtC?=
 =?utf-8?B?bVpoK3JBOWZ5T3RUQW9kVlVpZ1B4a1daNU9WdE1wTFpsVTc2cjRQeHBCN2py?=
 =?utf-8?B?eVZiYmw0OU1NUjNRMjNBYmg4aTdOYmszTjlTZ2VOL3lsSDBLc2lYVGhUakNV?=
 =?utf-8?B?RHh0amp5aHY3aFE0Z3Fkay9GZDFySk9tZ0Fkem40T1pQY3dSWHhkd05LWS8x?=
 =?utf-8?B?S255bGVKMU9oQ0gxMmwrWkxGMEx3PT0=?=
Content-ID: <4CCBB7D935C5C044BB059DEB19DDD8EC@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c080428c-3d57-4772-e2dd-08db7262f8ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 14:22:41.1151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aaw/lrMaOkZRP8EhMOqeaQI7NMi9JLU6CRgxDG6nlYw6O3RWbVcV3NKEEcnewLqKszTb8XPHZY/nBAmXaxXJQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR05MB10229
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sctp_big_chunk: Do not use md5 hmac algo if fips
 is enabled
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
From: Ashwin Dayanand Kamat via ltp <ltp@lists.linux.it>
Reply-To: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
Cc: Tapas Kundu <tkundu@vmware.com>, Ajay Kaher <akaher@vmware.com>,
 Vasavi Sirnapalli <vsirnapalli@vmware.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

DQo+IE9uIDIxLUp1bi0yMDIzLCBhdCA2OjE4IFBNLCBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5j
ej4gd3JvdGU6DQo+DQo+ICEhIEV4dGVybmFsIEVtYWlsDQo+DQo+PiBIaSBBc2h3aW4sDQo+DQo+
Pj4+IE91dCBvZiBjdXJpb3NpdHksIHdoaWNoIGVycm5vIGlzIHJlcG9ydGVkIG9uIGxpc3Rlbj8N
Cj4NCj4+Pj4gSW4gb3VyIGNhc2UgaW4gRklQUyBFTk9TWVMgaXMgcmV0dXJuZWQsIHRodXMgaGFu
ZGxlZCBhcyBUQ09ORi4NCj4NCj4+PiBJIGFtIHNlZWluZyB0aGUgRU5PU1lTICgzOCkgZXJyb3Ig
YW5kIGl04oCZcyB0cnVlIHRoYXQgaXQgaXMgaGFuZGxlZCBhcyBUQ09ORi4gVGhlIGludGVudGlv
biBvZiB0aGUgcGF0Y2ggaXMgdG8gZml4IHRoZSBzYW1lLg0KPg0KPj4gVENPTkYgbWVhbnMgc2tp
cHBlZCwgaS5lLiBPSy4gSSBzdXBwb3NlIHlvdXIgcGF0Y2ggYWxsb3dzIHRvIGRvIHRlc3Rpbmcs
IHdoaWNoDQo+PiBpcyBhbiBlbmhhbmNlbWVudC4gQnV0LCBhdCBsZWFzdCBvbiBvbmUgRklQUyBz
eXN0ZW0gSSBnZXQgZmFpbHVyZSBkdWUgbWlzc2luZw0KPj4gcHJvYyBmaWxlOg0KPg0KPj4gdHN0
X2ZpcHMuYzoyMjogVElORk86IEZJUFM6IG9uDQo+PiBzY3RwX2JpZ19jaHVuay5jOjE1MzogVEJS
T0s6IEZhaWxlZCB0byBvcGVuIEZJTEUgJy9wcm9jL3N5cy9uZXQvc2N0cC9jb29raWVfaG1hY19h
bGcnIGZvciByZWFkaW5nOiBFTk9FTlQgKDIpDQo+DQo+IE9LLCB0aGlzIHByb2JsZW0gaXMgb24g
YWxsIHN5c3RlbXMgd2hpY2ggaGF2ZW4ndCB1c2VkIHNjdHAgc28gZmFyLiBXZSByZWFsbHkNCj4g
bmVlZCB0byBzb21laG93IG1vZHByb2JlIHNjdHAgYmVmb3JlIHJlYWRpbmcgL3Byb2Mvc3lzL25l
dC9zY3RwL2Nvb2tpZV9obWFjX2FsZy4NCj4gTWF5YmUgdXNpbmcgLm5lZWRzX2RyaXZlcnM/DQo+
DQo+IEtpbmQgcmVnYXJkcywNCj4gUGV0cg0KPg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgdmFsdWFi
bGUgaW5wdXQuIEkgd2lsbCBsb29rIGludG8gdGhlc2UgYW5kIGhhbmRsZSBhY2NvcmRpbmdseSBp
biBuZXh0IHBhdGNoc2V0Lg0KDQpSZWdhcmRzLA0KQXNod2luDQoNCj4+IFRoZSBzeXN0ZW0gaGFz
IENPTkZJR19JUF9TQ1RQPW0sIEkgZG9uJ3Qga25vdyB3aHkgbW9kdWxlIGlzIG5vdCBsb2FkZWQu
DQo+PiBNYXliZSBpdCdzIG5vdCBpbnN0YWxsZWQgb24gdGhlIHN5c3RlbSAod291bGQgcmVxdWly
ZSBwYWNrYWdlIHdpdGggZXh0cmENCj4+IG1vZHVsZXMpLCBidXQgc3RpbGwgdGhpcyB3b3VsZCBi
ZSBhIHJlZ3Jlc3Npb24sIHdlIHNob3VsZCBjaGVjayBmb3IgcHJlc2VuY2Ugb2YNCj4+IHRoZSBm
aWxlLg0KPg0KPj4gTk9URSBXZSBoYXZlIC5zYXZlX3Jlc3RvcmUgWzFdIGhlbHBlciwgZ2VuZXJh
bGx5IHdlJ2QgdXNlIGl0IHdpdGgNCj4+IFRTVF9TUl9UQ09ORl9NSVNTSU5HLCBidXQgaW4gdGhp
cyBjYXNlIEknZCB1c2UgYWNjZXNzKCkgdG8gY2hlY2ssDQo+PiBiZWNhdXNlIHdob2xlIFNBRkVf
RklMRV9TQ0FORigpIHNob3VsZCBiZSBhcHBsaWVkIG9ubHkgd2hlbiBuZWVkZWQNCj4+IChpbiB0
c3RfZmlwc19lbmFibGVkKCkpLg0KPg0KPj4gS2luZCByZWdhcmRzLA0KPj4gUGV0cg0KPg0KPj4g
WzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL3dpa2kvQy1UZXN0
LUFQSSMxMjctc2F2aW5nLS1yZXN0b3JpbmctcHJvY3N5cy12YWx1ZXMgPGh0dHBzOi8vZ2l0aHVi
LmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL3dpa2kvQy1UZXN0LUFQSSMxMjctc2F2aW5nLS1y
ZXN0b3JpbmctcHJvY3N5cy12YWx1ZXM+IDxodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1w
cm9qZWN0L2x0cC93aWtpL0MtVGVzdC1BUEkjMTI3LXNhdmluZy0tcmVzdG9yaW5nLXByb2NzeXMt
dmFsdWVzPiA8aHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvd2lraS9D
LVRlc3QtQVBJIzEyNy1zYXZpbmctLXJlc3RvcmluZy1wcm9jc3lzLXZhbHVlcyZndDs+DQo+DQo+
Pj4gVGhhbmtzLA0KPj4+IEFzaHdpbg0KPg0KPiAhISBFeHRlcm5hbCBFbWFpbDogVGhpcyBlbWFp
bCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2Vu
ZGVyLg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
