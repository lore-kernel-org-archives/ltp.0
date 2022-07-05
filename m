Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848F5C433EF
	for <ltp@archiver.kernel.org>; Tue,  5 Jul 2022 11:47:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5B793CA0EE
	for <ltp@archiver.kernel.org>; Tue,  5 Jul 2022 13:47:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7ACAF3C9611
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 13:47:09 +0200 (CEST)
Received: from GCC02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3gcc02lp2102.outbound.protection.outlook.com [104.47.65.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EF061600691
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 13:47:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hM2ivcOeCv5fkY/GxiptcUi6WmDlDFv56/VuC9NLgLrqpwLTJb4KKFJwGHNOs7vE1+cu7qWZs/ErSbsijuo7g8pGniGBDAKjGnO4uEqnhIHf57albAIiwuR1j5tkTWuSEnuucOtNOkTDoBHfs0R3m4Vf4WaRrKtVDsDi4+s9tz3OkBih++V7td4KrZgCrzc10H/VOB9SYQRdgco/pS/W79LXMIy7GZjIszIDPR17MtDHdjzW9hG/1FPlSiQpD4mdNSKfcnb0W3A212n0bF783pgfYF8mS10Ad4w6ozdB8iKtKUp1grxHWUop0DZ1RHOiOgdFa4pEqzsoJbxOTafFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtLmJO4i1eKE+e+w9LnkfgHMfjlRxHmiEPeojs6TLt8=;
 b=Pr6QnRqsEVd7LzAD5aAIkXyelfrhJmQLjzTJ5lkc1x2FKIEiVGVk1DVvOWAdgeOGUSLawmX/LHaSrjXkt7vQP4lNxXJGuth8Z2EYANuaBrARAZTd52/voAF6QFuIVaMGYqoAIPlHoRw8McHFZhEg7b0b9F6ZKRhBmeTW8vJSr7R4wuNwttckEdfFn88VYoqHmy6+OOo5wqbB6UrsPH8pwV4t9nunlbwB70p/jjANCTQbG89t1vVzK8JScX23cJXKXVeJ2LUZ9yCef2CSZxmfsLGgayUvSZ9cuLZvTePH8Y38ITVRfe/So9w9HaaYqLEoUl0QB7C329vqStgm/Q9qbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nasa.gov; dmarc=pass action=none header.from=nasa.gov;
 dkim=pass header.d=nasa.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nasa.gov; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtLmJO4i1eKE+e+w9LnkfgHMfjlRxHmiEPeojs6TLt8=;
 b=djqE4N0QLcuEU8xQ6nGh9mEsRQvZv9a4gS8qxkXnokrW5WDPiOcklXV46ztWbLQlz0jeQR3Q1rxDzF55ow6kG2C0EireP3iNYdMLhlcoL5oOpPY5SN+8C3JbB0pdQ338Oh3HVh8mJVg3HBJ+iSPfV1Slm3Y+UQatvfi213+NXEU=
Received: from PH0PR09MB8537.namprd09.prod.outlook.com (2603:10b6:510:65::9)
 by SJ0PR09MB6303.namprd09.prod.outlook.com (2603:10b6:a03:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 11:47:05 +0000
Received: from PH0PR09MB8537.namprd09.prod.outlook.com
 ([fe80::240a:5d10:2cf0:804]) by PH0PR09MB8537.namprd09.prod.outlook.com
 ([fe80::240a:5d10:2cf0:804%7]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 11:47:04 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [EXTERNAL] Re: [LTP] Inquiry: Country of Origin for LCOV	Version
 1.x
Thread-Index: AdiNYB64w44Ex6n4SrOHpI3GMvnq9wCbyS4AACVqWMA=
Date: Tue, 5 Jul 2022 11:47:04 +0000
Message-ID: <PH0PR09MB85375729EB036825EC6AE043D5819@PH0PR09MB8537.namprd09.prod.outlook.com>
References: <PH0PR09MB8537C12911766525158A7828D5BD9@PH0PR09MB8537.namprd09.prod.outlook.com>
 <YsMpmLENCE42TgnA@yuki>
In-Reply-To: <YsMpmLENCE42TgnA@yuki>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nasa.gov;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe1ac30e-f194-4f29-2ce1-08da5e7c1515
x-ms-traffictypediagnostic: SJ0PR09MB6303:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0YWzxeEl8tkX3bkl0zaDFXRlMJ7hfdZPCUiM/mrQVYbQ6fieqQzGVOzfBu96pVyZYz+fcZhqud0h8bDfQzDFNPla3C37t23UuvZPK+JDmIe66Ty3mgmKOKlPY6eEvLu51iPCJjHTh3vj7N/6h1W1P+M+toBgV7c7s0061DOoRk2lV+E4bkICKIjIrDYj7yv9dQy9H3mOrh2jyGf6xqhrRyqpaweeQyrjViR5hPIF10k34i15YKLw8COMVxCJcj7seAQQsjKdfuT2pFSVKhJ9LOoov7gAUnjNJV+TOfrtucfH1og3WOkGkURJ2omIZvm0PqV3GsJwtu5XaGk5GfBEqjAnYswn1gk6/L5gIAAEnOeuklKnJ4K4FRNad0Sz+cRl4EveKZ47fVkJ4DSlYC/yIwBNMYv7PrWxtmhHTiCglVBstuZLdu46W2Se2K1ZwRI9Y5/gZyr1K2rvIHSxmZRVgjMfEBSG+gz6eOjjs5/OhdTu+zdzgseQNFskaoMsZw9yANZ0Og4zN62NkJdwb0wCpPbGOBgPLfsEqLZQVYpufwNmEIx2m1ZjG+47X5aN/5FPZa37raOq6nsSDtpIfelYUwMuvmOZVWgVOwfiUStalofoq4+7ZvUyWaT47iqeLbYjfsVSQ5B5j3Sen9lgjYJpDquRpRK3ORCDHcLMacdOta4Prrkob8sx48iy9CHNVHGMB089o5FmcDBQGCUE5kY0Kgo3ag5HTqh8nofZN8DopgIIdyQI7cF1+4tbeEI5ALCx+pMrhKLj+sVkMAdhvjWi0mze8/8jGFFn4eAWrG+WYKpTVDwScLAh+k5AZpwLwY5R
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR09MB8537.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(26005)(7696005)(6506007)(9686003)(186003)(38070700005)(83380400001)(498600001)(53546011)(38100700002)(122000001)(2906002)(33656002)(55016003)(64756008)(66446008)(66476007)(66556008)(66946007)(4326008)(54906003)(86362001)(8936002)(52536014)(76116006)(5660300002)(6916009)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3g0aHBrQXBOd2tzTDltV0hYbWtCaVJuY2Y3TnFIYVhHNU92aWRYTk5Qc3JV?=
 =?utf-8?B?YWJlNmxnc1NweW01dTY0UUdnTVZzeVZmTTMvNXNST3piOXN6UFFlblozSS9v?=
 =?utf-8?B?YmhRWGllOERIREFxdExEVUJRd2x1UU42aTJEZ0pxSnM4TTF1VEpmTE5hV3l0?=
 =?utf-8?B?S29pdDFtSW9FWmVaYWpkYnliMGYvenRuWkNoWm41dHhDU2dLaHhPS3V0UXVo?=
 =?utf-8?B?UWNtQytjb0JZb3B3c0RlblFJZzRoYVBOQ1QvbUZ1dEhhVFNmU21YL0FValQ3?=
 =?utf-8?B?Q0NEQ3BybTFoeVZmeUZWVnB1ZDlNMU1yckthS2VKb2R5WVJFVDBEV055SFBL?=
 =?utf-8?B?bzY4aTBTV3VtTll2amxMV2tFOFd0U1cxU1dGRjVnNkJhaEgrYjJpbWZzN25Y?=
 =?utf-8?B?R0NjKzlkUThrYmE1SkRHc2ZKRW9LaW1YdGRZaWdwaGlBaFJ5R0Z1ZUxqY3RU?=
 =?utf-8?B?MnlFNGFSWHNEVy85VmhIMXNWUFkrdDRwWkVucGVqanlmTldBRTBqNVdYYkln?=
 =?utf-8?B?eGF0R0xuNFlpMEN5YWJZM2c4RHIvWWxwQk1ndnJjOE1hQ0l1dlN0Smw5UWQ3?=
 =?utf-8?B?andacDB5b0F3Tm9OSEZmMEtJUy9XSllFQStDbEIzdVU1eDJ6MGx3TFpYWFdN?=
 =?utf-8?B?bENvUHFYdno5YjdZTktybTQrOVY4UDFhemxLOGVyUmM3YW1ldENrRE5pWEdW?=
 =?utf-8?B?Y2Y0UlBoZGdqZ0pHclRIbmRXY1pmbER5UGpXdHM1QzF2Vk0xMU0vYzFTa25y?=
 =?utf-8?B?KzNVeWRqSlEwVmdEcGxkdklaaFRKZC8rNnhDcGdBbnUrcENnTHdtdzNxeWVz?=
 =?utf-8?B?VjFOSXVzODZUQzJ2eExEZ3dVMis2cytpYWQwVk1Oa0lXK1lHczBKbUN6RzdQ?=
 =?utf-8?B?eGhLWDBtdlhEN29oYW1RekNvSnkwNWVSUWgwQkhSQmVUaTU1K01lSjVHT2xp?=
 =?utf-8?B?VmFOYjNXR3pPc0VyempYcEI2SW4rOXVKRHk3VmZQR1lJbjRiN0dpSkg5YkhE?=
 =?utf-8?B?QTVLUEdJSklsTEhPZnNTSkRBTFlodW15K0oybm9wMGRNK3NtT3JtTUNiMGpN?=
 =?utf-8?B?cmNEcVk3cjV2d0did1JlZVZkZDBncWdJd3R5SGNkdyt5bG4rNWRYamtpcStR?=
 =?utf-8?B?bnpuM1JlWktTckNBY0xCWDVCZklmVm5vdTcvdE1oUDZFL0Y5N3FOSTE3VHd0?=
 =?utf-8?B?bURJTUdGcVNEK2YwNzl1T0pnR2p1Y2tIU0V5WjRUV1doOFlSWGFqcXBxcXZ1?=
 =?utf-8?B?YWtZWlAyK0UxZ2lUVGh3WkFOY2g5dEV3WEtwTG95KzY5ZnpQcHU2ZjM5N2h4?=
 =?utf-8?B?a1hCRGJOdis2M2pyT0lvRkd4NzNJRU1xcFg2QTlTcHJJU2VBTEcxK0gxS0V2?=
 =?utf-8?B?RUJZbkdjYjBIZFJHS3VaL3VtU3ZvOEh3K3dINHBDYVdhUTA5bUh6QWtTMFdW?=
 =?utf-8?B?RXBRNklSSStudklmYXJpR3VYRGx6U1l6c3BMSnVRSCszTzIrQkhSOUpOMlNY?=
 =?utf-8?B?VUhQVTd6RHpvSVFKdE9zcktBWmg4b1BEMzdkNmIwOGs0UHJ2akZCMERpODgz?=
 =?utf-8?B?dlcxYzFaMXFrQzJTYjVHYUl2bHVlZnZoVVRHOEF3N3FHZEh2VlFzNUt3VGE5?=
 =?utf-8?B?OHl3YXc1LytzVUcydUpDMXFxT1dFVHpaMXhJcFlPRTNHZHRQOXg2MEUwdWhp?=
 =?utf-8?B?TDRuRFZMQzZFcmZXenhxQzM4Y2lZM0xIb3pMZkRKMlEvSkdIalMxMmJZVjJo?=
 =?utf-8?B?SVF3d3ExTjFUNVYyTW5lRy8yVlhROU9sN2hoMzFjOTduUDBJZU5FU0l6cjUv?=
 =?utf-8?B?TDZmMVlJVVRTSkhqSWdaWjdHTUNsVTh2cVpJZTZqYjZpaC94RHdFbWJLNmk3?=
 =?utf-8?B?Y2YrK2JaT2V6ekN5M255RWJpZjIzeHlHSUsvcHA1WHAwSU0vQmtWOVpKTyt5?=
 =?utf-8?B?bDB5OGdkaXB0N05YV0UveDJlQnhocHI1ZkloSFVuUWVvU3YyNkpNTytpMkFt?=
 =?utf-8?B?a1p1aVV1K3ROQmMxTjZ2Q1h6Y05Mdm5sUXNOZ3RXTWI4UnNhdWR0UUhiZ1lj?=
 =?utf-8?B?cU9BR0wyYkEvUE1tOUF1c3orR3AwcmZ5bmVGRG9TQUVPd01LV3V1TjNvWHhS?=
 =?utf-8?Q?Ct1eqH8Ggc6wlRek/5dK/4MNW?=
MIME-Version: 1.0
X-OriginatorOrg: nasa.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR09MB8537.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1ac30e-f194-4f29-2ce1-08da5e7c1515
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 11:47:04.8386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7005d458-45be-48ae-8140-d43da96dd17b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR09MB6303
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [EXTERNAL] Re: Inquiry: Country of Origin for
 LCOV	Version 1.x
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
From: "Zhang, Cynthia X. \(GSFC-710.0\)\[TELOPHASE CORP\] via ltp"
 <ltp@lists.linux.it>
Reply-To: "Zhang, Cynthia X. \(GSFC-710.0\)\[TELOPHASE CORP\]"
 <cynthia.x.zhang@nasa.gov>
Cc: "oberpar@linux.ibm.com" <oberpar@linux.ibm.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VGhhbmsgeW91IGZvciB5b3VyIGhlbHAhDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4gDQpTZW50OiBNb25kYXksIEp1bHkg
NCwgMjAyMiAxOjU2IFBNDQpUbzogWmhhbmcsIEN5bnRoaWEgWC4gKEdTRkMtNzEwLjApW1RFTE9Q
SEFTRSBDT1JQXSA8Y3ludGhpYS54LnpoYW5nQG5hc2EuZ292Pg0KQ2M6IGx0cEBsaXN0cy5saW51
eC5pdDsgb2JlcnBhckBsaW51eC5pYm0uY29tDQpTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbTFRQ
XSBJbnF1aXJ5OiBDb3VudHJ5IG9mIE9yaWdpbiBmb3IgTENPViBWZXJzaW9uIDEueA0KDQpIaSEN
Cj4gSGVsbG8sIG15IG5hbWUgaXPigK9DeW50aGlh4oCvYW5kIEkgYW0gYSBTdXBwbHkgQ2hhaW4g
UmlzayBNYW5hZ2VtZW50IA0KPiBBbmFseXN0IGF0IE5BU0EuIE5BU0EgaXMgY3VycmVudGx5IGNv
bmR1Y3RpbmcgYSBzdXBwbHkgY2hhaW4gDQo+IGFzc2Vzc21lbnQgb2YgTENPViBWZXJzaW9uIDEu
eC4gIEFzIHN0YXRlZCBpbiBTZWN0aW9ucyAyMDggYW5kIDUxNCBvZiANCj4gdGhlIENvbnNvbGlk
YXRlZCBBcHByb3ByaWF0aW9ucyBBY3QsIDIwMjIsIFB1YmxpYyBMYXcgMTE3LTEwMywgZW5hY3Rl
ZCANCj4gTWFyY2ggMTUsIDIwMjIsIGEgcmVxdWlyZWQgc3RlcCBvZiBvdXIgcHJvY2VzcyBpcyB0
byB2ZXJpZnkgdGhlIA0KPiBDb3VudHJ5IG9mIE9yaWdpbiAoQ29PKSBpbmZvcm1hdGlvbiBmb3Ig
dGhlIHByb2R1Y3QgKGkuZS4sIHRoZSBjb3VudHJ5IA0KPiB3aGVyZSB0aGUgcHJvZHVjdHMgd2Vy
ZSBkZXZlbG9wZWQsIG1hbnVmYWN0dXJlZCwgYW5kIGFzc2VtYmxlZC4pIEFzIA0KPiBMQ09WIFZl
cnNpb24gMS54IGlzIG9wZW4gc291cmNlLCB3ZSB1bmRlcnN0YW5kIHRoYXQgdGhpcyBpbnF1aXJ5
IGlzIA0KPiBub3QgZGlyZWN0bHkgYXBwbGljYWJsZSwgYXMgY29udHJpYnV0aW9ucyBtYXkgYmUg
bWFkZSBmcm9tIGluZGl2aWR1YWxzIA0KPiBmcm9tIGFyb3VuZCB0aGUgd29ybGQuIEluIHRoaXMg
Y2FzZSwgTkFTQSBpcyBpbnRlcmVzdGVkIGluIGNvbmZpcm1pbmcgDQo+IHRoZSBmb2xsb3dpbmcg
aW5mb3JtYXRpb246DQo+DQo+ICAgMS4gIElzIHRoZXJlIGFuIG9yZ2FuaXphdGlvbiB3aGljaCBz
cG9uc29ycy9wdWJsaXNoZXMgdGhlIHByb2plY3QsDQo+ICAgICAgIG9yIGEgcHJpbWFyeSBkZXZl
bG9wZXIgd2hvIGF1ZGl0cyB0aGUgY29kZSBmb3IgcG90ZW50aWFsDQo+ICAgICAgIHZ1bG5lcmFi
aWxpdGllcywgZXJyb3JzLCBvciBtYWxpY2lvdXMgY29kZT8gWS9ODQo+DQo+ICAgMi4gIERvZXMg
TENPViBWZXJzaW9uIDEueCBoYXZlIGFuIG92ZXJzZWVpbmcgb3JnYW5pemF0aW9uIG9yDQo+ICAg
ICAgIGluZGl2aWR1YWwgYWxvbmcgdGhlc2UgbGluZXM/IFkvTg0KPg0KPiAgIDEuICBJZiBzbywg
cGxlYXNlIHByb3ZpZGUgdGhlIG5hbWUgb2YgdGhlIG9yZ2FuaXphdGlvbiBhbmQgY291bnRyeQ0K
PiAgIHRoZXkgYXJlIGVzdGFibGlzaGVkIGluLiAgSWYgdGhlIGluZm9ybWF0aW9uIGFib3ZlIGlz
IHVua25vd24gb3INCj4gICBjYW5ub3QgYmUgcHJvdmlkZWQsIHdlIHJlcXVlc3QgdGhhdCB5b3Ug
cHJvdmlkZSB0aGUgY291bnRyeSBvciBsaXN0DQo+ICAgb2YgY291bnRyaWVzIHdoZXJlIHRoZSBt
YWpvcml0eSBvZiBjb250cmlidXRpb25zIG9yaWdpbmF0ZSBmcm9tIHRvDQo+ICAgc2F0aXNmeSBT
ZWN0aW9ucyAyMDggYW5kIDUxNCBvZiB0aGUgQ29uc29saWRhdGVkIEFwcHJvcHJpYXRpb25zIEFj
dCwNCj4gICAyMDIyLCBQdWJsaWMgTGF3IDExNy0xMDMsIGVuYWN0ZWQgTWFyY2ggMTUsIDIwMjIu
DQoNCkFzIGZhciBhcyBJIGNhbiB0ZWxsIExDT1YgaXMgbWFpbnRhaW5lZCBieSBQZXRlciBPYmVy
cGFybGVpdGVyIGZyb20gSUJNIChub3cgaW4gQ0MpLg0KDQotLQ0KQ3lyaWwgSHJ1YmlzDQpjaHJ1
YmlzQHN1c2UuY3oNCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
