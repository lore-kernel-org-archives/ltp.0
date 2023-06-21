Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334ADC0015E
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 14:16:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D9E43CDAD0
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 16:16:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9F233C6335
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 16:15:59 +0200 (CEST)
Received: from MW2PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 24EC5600801
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 16:15:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/mJtmeya5uVlkLJM1Zo9sckr2l24g9q0WDGE+HJERZ42VBtsy2YG/cs4H6cxJyQ7McAQR/O4iXQWR0ZVMybX1v42Jx46HxU/Icp4qro0ZGr6po24HLwqzHpeKN1ddEbc2Y9xwF23D7pnr0ne49qEnkQoVQFKyH45xN7KLdHsSxMIeoAF1U5qq0GcOUYOVds/UZWsIIC0Ljt1EzOY8hIztYSky49iixlhxjDug/1vc+cDhFNgf3bSCUDJ43wjLl9Jc85vzkX36rATjYQmxMNuMgdtnWNP12vAmpWI5eyThnaxYYX72o07a71dkHZpB0LMYUeJZJMEUIIg8RApyXQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ofPH4uobVTtgM79paiCxi0wEiCuLHExUoV+j/ETlEU=;
 b=OPLlj4Hf/vY1DODY3heHfhzxdvj22IO4oQHneM4jl9qdiWM2yaUs+bKUWFZWNpnQhS4sQcRWoAHwkimI+Cr2zRxsCCeO25n53GfBylWhf9Aru2GOSu0O7GIz+e695095wU8+tSod4zTzKXfhqAgfBpdqviJiIiGtRE2JZsJ5D1b/uzkClTFlnM9AJ13cCJN0c+mLE3AL4IgYiDGT7D+hn4uv7JLhuohDIdwrjhi+r+90d8v+zOxuDTUUitOjIsMbTtgAVds50+2X2Ss5k0xzQ9MOlzFeZVBWDrEdCD1KxiEZK7qQToR8DS4Cisgeq/AgzhBmz0rtcks9Q1Ed5tQ9tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ofPH4uobVTtgM79paiCxi0wEiCuLHExUoV+j/ETlEU=;
 b=0oR+E0oKgaFGEpXw/6Ket+JxnlQ1qFNEmFv+3eb1s/D+ZTcXGSQp0ehJdBmXATu+oLYaBwAMgZbYKK85+UXRwlMhPOocxg2tOR36xDkph5NhMwHkM2tcBeoFMgXg4mZdv2JI/LYqiRX53X7AlYWp/gbKCH9ICk8TqXC740sh5EE=
Received: from BL0PR05MB5409.namprd05.prod.outlook.com (2603:10b6:208:6e::17)
 by PH0PR05MB9598.namprd05.prod.outlook.com (2603:10b6:510:287::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 21 Jun
 2023 14:15:38 +0000
Received: from BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::68a4:3da6:4981:4793]) by BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::68a4:3da6:4981:4793%7]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 14:15:37 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] sctp_big_chunk: Do not use md5 hmac algo if fips
 is enabled
Thread-Index: AQHZo5k3Qi3mcEdQ1EqnVWVWOBu/C6+URTKAgAB89YCAACg0gIAAS8IAgAAYY4A=
Date: Wed, 21 Jun 2023 14:15:37 +0000
Message-ID: <6E401126-E414-4CE9-87E5-FE18A798F4E7@vmware.com>
References: <1687280634-5906-1-git-send-email-kashwindayan@vmware.com>
 <20230620222603.GB340710@pevik>
 <01C96D39-2B2E-44EB-A5D7-41BF26D2C2AC@vmware.com>
 <20230621081711.GA361973@pevik> <20230621124820.GA464557@pevik>
In-Reply-To: <20230621124820.GA464557@pevik>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5409:EE_|PH0PR05MB9598:EE_
x-ms-office365-filtering-correlation-id: a30263f4-1da1-4f51-2a79-08db7261fc98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vurd/M6unRv6Wewq8y3fasMhtvPNe8RD+ltkv5iVYzvxY1KLnGD41ehl7l+R4B97Ge80p1//SCro6dEOh9/g99zXhA9j51I5yNtucZia5vGwl74KdcGiB3s7SV38muqcrSn+8F77jeGp9qk0b5jAAS6xK2w/9LdLMTDsr8UsLsH5nHFy7LtQZa0Nbs8pU4/n4a473YfBOz6hXQjfA8dHGned1FP2S2IvK4zCurHduR6hGpq3IcVyAhxVSXKbjC2Q+XWbL9z+nMGXluG0DEsxZQVbAsD+szZi5pjTokDCDgMoXWTstmFiK4ocb6FUNBeT32313nLPurieYoCERYgjKvUk8V20Fgm8ROSvNTpqPby32lI44Ehd+9AIX6/Kedj8+8jonXtD/WGWKlFTWzDKLczogiRJeyNgyfwQtbsDwQWFwsRub8dWe2dKOPJLAGw12aOFfUjQTKkp17bWQZhCdYBB12bCxXTuUu39UfrDm8FpoPJaCYgS/R6qd3EYUkh83mS6Lj9at+1wBOzbwnDShcKyAmCB5DuOMjV1L9NCusz5BaArr3FLVPCDj4MUpqNtLvg1lKJSV242bNh6AxcUlBqq2WsFwMRAVYenzpFhkoUOCwDSbr2TLKsArTKUA7Zeg5Ej/UR2CgivaZSwcjWKz/vQut02KPJCMjngJVqrpQeWc4cvYpXeSw7Iu6Q3Beit6s3WloPw7lMT6OEVbA1ImziliMCBaNPefxeZMrThk64=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR05MB5409.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199021)(36756003)(166002)(2906002)(38070700005)(33656002)(86362001)(2616005)(53546011)(6486002)(186003)(6506007)(83380400001)(6512007)(107886003)(966005)(91956017)(5660300002)(478600001)(66946007)(71200400001)(4326008)(122000001)(64756008)(66446008)(66476007)(6916009)(76116006)(316002)(45080400002)(66556008)(38100700002)(54906003)(41300700001)(8676002)(8936002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXJiY3N2SDdjdW5RYWFSK1FMNVFjci9IVVlmU3IxdGlBV3hMMmZITU13L3hq?=
 =?utf-8?B?cUNVY3duUVdRSllCZk5iS0lJamdDL0doeURFSUM4TlVnaCsvS2V1RWpRdFRZ?=
 =?utf-8?B?dStIZmliV1ZWMndnKzNCcUtCSEgySlU2Vks4b3pKYjJhck5weVNTYmdNVnYr?=
 =?utf-8?B?RDRqVVBhZnVZdWFYZnR4eGdUQUlxZnVoZFJXYVQ0SFVmZDdzb2hRS3c0MVdN?=
 =?utf-8?B?LzQ5SVFUamg5U0xJS2FsL3ZMakRFY1NUZUxrbG5PVkNpZ2NrYVlMNzVrbXRG?=
 =?utf-8?B?UUtXUUVQY0E1YUFGYjdIVVVYNzY2WlhJVHlYRlBjME10cG5BbkVKYjZSNTBq?=
 =?utf-8?B?ZWFhZDdnZ2wxN3VKWElqWE9VeWxST05JL3RhYys4ZGw3WU15L1lCVWQ3YWU4?=
 =?utf-8?B?MlNUOFlPMFQ1TTdWd3oxbW85Qy85YnpPR2pjakp6WElWRkIxbk9CYldsTTY0?=
 =?utf-8?B?ZU1RS2t1NXV2Wm8wSGkvVE0rNVZYaTRrRnQxTTlaYzZPZ2ZvNUpOUDdQVFk1?=
 =?utf-8?B?L1puVzhrL2lrZGhzcUJZanBWRUVaTFhkNzVqS2JwSkh3bTMyWWp3bHRnV1Iw?=
 =?utf-8?B?aUU4QksxamF5Vm9RaUFRNTRzL2h6akRzWTdaeVJvWE44SitCb25mL3VyYXNw?=
 =?utf-8?B?OVVEYXZ5V2VlSE5nZ0l6Njl6NlJIWmhSQkY0Qzg2UFEyRXFWa09KVk1VbGsx?=
 =?utf-8?B?Z0RDTU1KajZTQzIweFVETXBqcGt3L3prZWNRcEw2NHpSR29TOENlUit5MjZm?=
 =?utf-8?B?SzM5dnZtS1FMbWRSZGNOaXE0UmJlRWk0bFQ5NTF5UzV3K3QwWVlueVd3R0cw?=
 =?utf-8?B?bDY2NW1YcndwZC90Um0vamNVdEQrd0NMWG42enFZNFkxRHZMOEs4a0RnMXZM?=
 =?utf-8?B?VzQ1cU9ESHh1ZVQ1VENlZ2dsdXB4UEp0RHJCMXZ1Z1ltNDh5K0RHS2c4Qi81?=
 =?utf-8?B?Skpkb2JDeGpCUm9WcWNlUHo0Z29rMFR6N0ZDM0ltQ29hYkRMMEk5VUhBbUYr?=
 =?utf-8?B?Q2NXMG1kQ29US2RqRjd5aHBVNWcxS0xkNWNqOTZoOEZoWTgvUE1LVDZWNm9a?=
 =?utf-8?B?SGkxOFdoTmduZTg3b2tpcmExSmlocm51UUI4SGVyazZiNGNGQ3B2cXRBaEV2?=
 =?utf-8?B?b0JOaEYxM21SWFUyeDB4Q05VSHY0MVJEL1lwY240dU9OSWZ2WElkTk5FcW9n?=
 =?utf-8?B?cCtmUzdtWFdtNXVOUVg2d3R2Vi96dGVVaFlWOGtuK0lLcDZsckZaZW42N3pS?=
 =?utf-8?B?Nk15ZzdOcjM2d1dXaVphNnZWdGlkbVNCTm5OQ2hhSDBCTE5rWEU0YkhTUVJW?=
 =?utf-8?B?UDVCanZtZWx0anUzYlNhQmxqYUo4clZXK0x2NVU1YnZ6N1NtQXcvcFFITGFM?=
 =?utf-8?B?UGZtSHFkakR6c1lONFZFV25uYXI3UWFUa09FWldUU2QrcmVCYVpTc3NuODZu?=
 =?utf-8?B?MnpLSldLQ0JtUnMya2NZdU1mQy9WQnpoM1RRVGwzMUFWbmRtbTNTR05TZVda?=
 =?utf-8?B?RzdJazJTYmR6QVIyczR3LzZYeEVScXEyaHhWMkN0OUFkRit5c01ablp1by92?=
 =?utf-8?B?elZOMHpYOWV1T3h6NTYveC9FSjRxcG1Va1pZUTJpbm1MR3RzMUVQRWsraEFV?=
 =?utf-8?B?NGl5Q01wWExMQkttZlpEaTdHaG5XZFJveGpUbzdYcWxwL0I1ZlZhaUlJdHR1?=
 =?utf-8?B?azF5cTg0eE1jaGNDRzFDZGUyaFhEUGNWcXpNdDNvUVhRRWcrM2p4dHhpMlE3?=
 =?utf-8?B?VnlhR3FnQ1pwcjJ0MWVvWGZGdTVENkRxUTc2RXNFaFprQkVvTlo3bFNlRE1V?=
 =?utf-8?B?OWdQeTB1QkJ4Szd0M2ErdEVmQitMVmF6VVkvaTh2c1F0MVkrQS9kdXNYL2Iw?=
 =?utf-8?B?UmNRUWZFNlNKZncvT3FncnAxVVdKV0U2TEs2MForbGdTQlc1SDA4bVE1bTdW?=
 =?utf-8?B?aDlDSllKSmdqMkwzRXc1RkE4V3R3V2t5NTdsRHZvNGRUVlFoaCtBOGE4MmY1?=
 =?utf-8?B?YXE0NmN5U1djMVdrUUhuY3lhR05QOTlwbmd2emo1YUIxWklvQjlnZHFla2Ri?=
 =?utf-8?B?SE9RUlg4TzZuLzFMcXFDaWM0WUpUMEFOSWFNVDlTaUVFaHB0YlpOT3JIamNo?=
 =?utf-8?B?WEM5QnY0SlladzRjaFdYRE5mS3dxaG9WenNlcm12akhTME51RlJPQndON3Nt?=
 =?utf-8?B?N0ZSbUt3Qi9CUnRTdm1mS2tlTXhHRWN4YzA2NS82YmREZVlCM3RKNzhKTGVD?=
 =?utf-8?B?UldTWC9hUnk5TndvamYrbkU3RlRBPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30263f4-1da1-4f51-2a79-08db7261fc98
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 14:15:37.7884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WqaPAV+XTx/N34hdEdSGTThbYMxIFSn/kPNP7p1jL02Byf808fy256smJ3FOO+pd2kcMzNNe4fR10aK0nbJBeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB9598
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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
 Ashwin Dayanand Kamat <kashwindayan@vmware.com>,
 Vasavi Sirnapalli <vsirnapalli@vmware.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

DQoNCk9uIDIxLUp1bi0yMDIzLCBhdCA2OjE4IFBNLCBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5j
ejxtYWlsdG86cHZvcmVsQHN1c2UuY3o+PiB3cm90ZToNCg0KISEgRXh0ZXJuYWwgRW1haWwNCg0K
SGkgQXNod2luLA0KDQpPdXQgb2YgY3VyaW9zaXR5LCB3aGljaCBlcnJubyBpcyByZXBvcnRlZCBv
biBsaXN0ZW4/DQoNCkluIG91ciBjYXNlIGluIEZJUFMgRU5PU1lTIGlzIHJldHVybmVkLCB0aHVz
IGhhbmRsZWQgYXMgVENPTkYuDQoNCkkgYW0gc2VlaW5nIHRoZSBFTk9TWVMgKDM4KSBlcnJvciBh
bmQgaXTigJlzIHRydWUgdGhhdCBpdCBpcyBoYW5kbGVkIGFzIFRDT05GLiBUaGUgaW50ZW50aW9u
IG9mIHRoZSBwYXRjaCBpcyB0byBmaXggdGhlIHNhbWUuDQoNClRDT05GIG1lYW5zIHNraXBwZWQs
IGkuZS4gT0suIEkgc3VwcG9zZSB5b3VyIHBhdGNoIGFsbG93cyB0byBkbyB0ZXN0aW5nLCB3aGlj
aA0KaXMgYW4gZW5oYW5jZW1lbnQuIEJ1dCwgYXQgbGVhc3Qgb24gb25lIEZJUFMgc3lzdGVtIEkg
Z2V0IGZhaWx1cmUgZHVlIG1pc3NpbmcNCnByb2MgZmlsZToNCg0KdHN0X2ZpcHMuYzoyMjogVElO
Rk86IEZJUFM6IG9uDQpzY3RwX2JpZ19jaHVuay5jOjE1MzogVEJST0s6IEZhaWxlZCB0byBvcGVu
IEZJTEUgJy9wcm9jL3N5cy9uZXQvc2N0cC9jb29raWVfaG1hY19hbGcnIGZvciByZWFkaW5nOiBF
Tk9FTlQgKDIpDQoNCk9LLCB0aGlzIHByb2JsZW0gaXMgb24gYWxsIHN5c3RlbXMgd2hpY2ggaGF2
ZW4ndCB1c2VkIHNjdHAgc28gZmFyLiBXZSByZWFsbHkNCm5lZWQgdG8gc29tZWhvdyBtb2Rwcm9i
ZSBzY3RwIGJlZm9yZSByZWFkaW5nIC9wcm9jL3N5cy9uZXQvc2N0cC9jb29raWVfaG1hY19hbGcu
DQpNYXliZSB1c2luZyAubmVlZHNfZHJpdmVycz8NCg0KVGhhbmsgeW91IGZvciB5b3VyIHZhbHVh
YmxlIGlucHV0LiBJIHdpbGwgbG9vayBpbnRvIHRoZXNlIGFuZCBoYW5kbGUgaXQNCmFjY29yZGlu
Z2x5IGluIHRoZSBuZXh0IHBhdGNoLg0KDQpLaW5kIHJlZ2FyZHMsDQpBc2h3aW4gS2FtYXQNCktp
bmQgcmVnYXJkcywNClBldHINCg0KVGhlIHN5c3RlbSBoYXMgQ09ORklHX0lQX1NDVFA9bSwgSSBk
b24ndCBrbm93IHdoeSBtb2R1bGUgaXMgbm90IGxvYWRlZC4NCk1heWJlIGl0J3Mgbm90IGluc3Rh
bGxlZCBvbiB0aGUgc3lzdGVtICh3b3VsZCByZXF1aXJlIHBhY2thZ2Ugd2l0aCBleHRyYQ0KbW9k
dWxlcyksIGJ1dCBzdGlsbCB0aGlzIHdvdWxkIGJlIGEgcmVncmVzc2lvbiwgd2Ugc2hvdWxkIGNo
ZWNrIGZvciBwcmVzZW5jZSBvZg0KdGhlIGZpbGUuDQoNCk5PVEUgV2UgaGF2ZSAuc2F2ZV9yZXN0
b3JlIFsxXSBoZWxwZXIsIGdlbmVyYWxseSB3ZSdkIHVzZSBpdCB3aXRoDQpUU1RfU1JfVENPTkZf
TUlTU0lORywgYnV0IGluIHRoaXMgY2FzZSBJJ2QgdXNlIGFjY2VzcygpIHRvIGNoZWNrLA0KYmVj
YXVzZSB3aG9sZSBTQUZFX0ZJTEVfU0NBTkYoKSBzaG91bGQgYmUgYXBwbGllZCBvbmx5IHdoZW4g
bmVlZGVkDQooaW4gdHN0X2ZpcHNfZW5hYmxlZCgpKS4NCg0KS2luZCByZWdhcmRzLA0KUGV0cg0K
DQpbMV0gaHR0cHM6Ly9uYW0wNC5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJs
PWh0dHBzJTNBJTJGJTJGZ2l0aHViLmNvbSUyRmxpbnV4LXRlc3QtcHJvamVjdCUyRmx0cCUyRndp
a2klMkZDLVRlc3QtQVBJJTIzMTI3LXNhdmluZy0tcmVzdG9yaW5nLXByb2NzeXMtdmFsdWVzJmRh
dGE9MDUlN0MwMSU3Q2thc2h3aW5kYXlhbiU0MHZtd2FyZS5jb20lN0MyZGI2NjExNjNkOWE0N2E0
NzIwMzA4ZGI3MjU1Y2NiNSU3Q2IzOTEzOGNhM2NlZTRiNGFhNGQ2Y2Q4M2Q5ZGQ2MmYwJTdDMCU3
QzAlN0M2MzgyMjk0ODUwODAwNjE1NTglN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lN
QzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNE
JTdDMzAwMCU3QyU3QyU3QyZzZGF0YT1LZllQd1VkJTJGeUV5ZkhDMEFOJTJCSHYzMnFXVUdhM0kz
ViUyQlRuUTBLdUdRb0xRJTNEJnJlc2VydmVkPTA8aHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRl
c3QtcHJvamVjdC9sdHAvd2lraS9DLVRlc3QtQVBJIzEyNy1zYXZpbmctLXJlc3RvcmluZy1wcm9j
c3lzLXZhbHVlcz4NCg0KVGhhbmtzLA0KQXNod2luDQoNCiEhIEV4dGVybmFsIEVtYWlsOiBUaGlz
IGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uIERvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRo
ZSBzZW5kZXIuDQoNCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
