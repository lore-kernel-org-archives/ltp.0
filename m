Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A594EB64D7
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 05:53:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F7A43C9D07
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 07:53:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDDDD3C9D07
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 07:53:38 +0200 (CEST)
Received: from CO1PR02CU002.outbound.protection.outlook.com
 (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 770DA2009FD
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 07:53:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeaPJsXELECBWafoGaR4gsW6WT0I+tlyeWqXBu5sUfvFOE8tuRIONy9nC3kmHq2Er15EK0CHGo3aaLu+M0nMrdOX/hiMGUuhgkR2pheRk6gamxrpq0SBeDH4YCEhCo5PWMvfovoYP7wjk0pQqszQclrJg9B4wbDcUFEEWQ8J/ka/6TOOCiO9qzkceEB3mk9fqf/7gu/oOmi/nSzm1Ak1vIHmYyLTYRfhoy7VhnTZcZm28AnPDAm6505dUbAGCXHJai5e7Wox4MwvWVlOPbinXRWdR+mXInxJxWMUjmsg9csXBGIP4j2g/HrHZoLzY8fS8gaiVtNzAgNj8wW2/iEhaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwt0ZXNdFLG6giqyum1eQpFQnrsCk1UlneMeBbEdfKU=;
 b=IkQ7XB6nBzsctMfTIJq/1Z95GgTQSjU7zmBgokqyBVMFkmBwNCRnAckdiMb35iqmTPhEqbtD6np7kcT1aidkvvTGPMITFZ4u3DvZeS2F6cnGUNsKMAtQ15yCBGRmEz/1i1nRx7117aPcClhCvQlpI3HebbRsQSoQqFg7PrEosxj6n31XQs+UxjdugdfF0FF5D4ag7zaOtoCcuKp6v53r162l3t2vNZQWSFoTGQqtb62m5FENXXpuU6zBbbLZ6RTPMGm4Gmg7PyFmRv2ZwLaYrZ4dsHrepqFxUBcFgf63Cab1hyhWADQxhOMSfcoJovm0fPc946MmBaX/muDnOBOwWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwt0ZXNdFLG6giqyum1eQpFQnrsCk1UlneMeBbEdfKU=;
 b=j4tNDb1ZiiPdt6Mzd20aZBP7VZOvOtere0fyTTgbJb7mwrWUyP7hfoA36Try7DAKRnwTyaUXTouu6gBRV9usxGfaOabWwWLO1z3GI5LtfKRSkyiMZb9Gor73NYzRSod0dAP/48u7ew7Mdvn897JulPAMtRqdAvzW671tCQ8N9fc=
Received: from BL0PR05MB5409.namprd05.prod.outlook.com (2603:10b6:208:6e::17)
 by SJ2PR05MB9926.namprd05.prod.outlook.com (2603:10b6:a03:4af::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 05:53:19 +0000
Received: from BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::68a4:3da6:4981:4793]) by BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::68a4:3da6:4981:4793%7]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 05:53:18 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] sctp_big_chunk: Do not use md5 hmac algo if fips
 is enabled
Thread-Index: AQHZo5k3Qi3mcEdQ1EqnVWVWOBu/C6+URTKAgAB89YA=
Date: Wed, 21 Jun 2023 05:53:18 +0000
Message-ID: <01C96D39-2B2E-44EB-A5D7-41BF26D2C2AC@vmware.com>
References: <1687280634-5906-1-git-send-email-kashwindayan@vmware.com>
 <20230620222603.GB340710@pevik>
In-Reply-To: <20230620222603.GB340710@pevik>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5409:EE_|SJ2PR05MB9926:EE_
x-ms-office365-filtering-correlation-id: b84fbc67-bd98-4b8e-6604-08db721bcff6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kQeZ1Apezg/TDTyXw7b/2N4Ea27Lb6un7fZHZ9hysgf5/MB5SGBDyRbQNBzAz/t9H71BkF9acdxXGlTAy52Hh5ejCV1YGQTeyvc+cVc4JWF3J+eIOFkQBcvxqk+3Ueb1rT1JvXDlzhk7zqPJ8Jbf2OGENoo8rntZuvcYxZZtjO7t8ngJuukRK0RFEvZ/EOXwlvHeyoBTF/2BgWIxw37hTcmOlTvYeRJJIgbkRv2AqOQtrf3hEPg1UhxVDGxW/KZqtm0wZvvK3eE4RqdphyYAf4jqo5sdODMT+penxdk5PYYCQBC9jkrmZCJKNuU0qjGyAwcEp1xi+khomyQ9oIBGrF23X7K5DRc88SxldbOmr9SHVcNPXHN225t17EGCVI+96qiwRYgC1nCyQxvXKs9L9Sa6PEJQQSnDVhCN1lc60RD889EUuggBx1SetSQUYRyKfPC/sQxdsp6vIPdS0m6yqNc9teaqhPGpB/8jN3mQnBn78J0N9fpMzIHby+Xk6P68Wf26jM+g1+rF4VgvZugPjzO7gmtjXdXnlTAwxkKXrm1zHnu7KJPbFbtx/8i2UMIUJrtiQ0iHYmt2oh7ONFEl6ltHnPUNR/I4bQbK8mrhRDPW5bMFh28YDSSNWfPXWl20vI3xCpuxzk6nYyG6qoJRGwf0Yr5YAJ4kMK2+OAZ5/hsMof3ZdntPnyLDlXB3KsVO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR05MB5409.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199021)(5660300002)(8936002)(8676002)(6916009)(4326008)(66476007)(66946007)(64756008)(66556008)(66446008)(91956017)(76116006)(316002)(2906002)(4744005)(54906003)(41300700001)(6486002)(71200400001)(478600001)(107886003)(6512007)(53546011)(186003)(36756003)(33656002)(2616005)(38100700002)(122000001)(6506007)(86362001)(38070700005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QndGbUVNRFFXc1pvbjdHNXRaYWVPa3Vxc3FobnBlelgwcFQwY21QdUorN3lv?=
 =?utf-8?B?cEo2c2FWc3VPMmxXcVhQcndRZHQ1STIrV21razBsd01YRnZsUFd4SEVZYmpY?=
 =?utf-8?B?WUY5c3dTS25ZazM3c2NocSszRzNXZVNibmZ5cHZoSFZqN2k3T0dIT3BWVjNG?=
 =?utf-8?B?b1lVd2lvQ1JLY0FvMDZNYWt6VDhHd2h6MmpqOXRmVHQyaklROEttWXlwNWU3?=
 =?utf-8?B?UGYzVGdlZ3VtK2ZzMDg2b1R6UkVMMVJJbThzQURyL1pldGJSbkdwZEJHV0ox?=
 =?utf-8?B?VzQ5emlDemxzWUNPY21NRlBGcEk0ZW5FL0kvVUZDQUgrOXkyejBoaGhZcVpq?=
 =?utf-8?B?YmNCVHJJcVN6aTZSTFp1QWxNWkM2eUlaUTNqNHV2aUR5NFNNMHpOa01udFYy?=
 =?utf-8?B?dy9wdDZIL2FRZSszV0E2bzcvMENaalRydmc5VkNGMTFGNllTVGNnOVVLdVN1?=
 =?utf-8?B?cTdBNkRsQTFibk4xdWtlb1lKb1p1SC9QWnVkenhHRDZNcUZNd0RJR2pZK0RW?=
 =?utf-8?B?UmdVWWNZYTNBS0VyS0VmRlo0UDhibDE5VzFxbjF5eEprRWlWOVBIZVBBMDF2?=
 =?utf-8?B?K0tVRE9JZzBPR3N1eHZDaHNKUkRzQk10VUVUWWJvdEpuZGhxQk9YaFNrWnB2?=
 =?utf-8?B?VkNKQ0ZJclQ5Wk5aNFRQaU4rNUxpbWRBY1lzd2hoRCt4cnZIQUxrSitkZ29p?=
 =?utf-8?B?MGV0d1lEcVJmaktOUStsV2pybE4xL05CNUhPK1I0b0Y1SUhvNXI5eU5YUHNa?=
 =?utf-8?B?SXB6ckl3TmNQSHdOQ3NPZytDQzYvSCtxWVJ3bVJ2RmwyWTk3bllIRVlyOTgv?=
 =?utf-8?B?UjhuV3NVWkVmMmcydGJ1SFVrOVVTb0dJSHF3MW41R0Fwc01qazZaRjVnMXF6?=
 =?utf-8?B?RW1RTVAzWDNFTHFqMklQRnI3TGVlT2xTOTNDNHl4cWxCUHhDU0Y2dUExSDVN?=
 =?utf-8?B?dkRPOTJqOFJRZFZuSVYvNFl4VzNQRGpqK2VhOWJCOFJnSmxaN0ZzTFdhZ0hj?=
 =?utf-8?B?K3VYbFl5a1dkTGpBam9CYzk4UFV1ZGowMkF1QzhPSGU3bVVKcFgrQXlmUnUr?=
 =?utf-8?B?S0cxVlVzeHZua0JZTWV1WUFXdFg1cWdlcUpoRGpPUzIrWlJLZ01IbElFMjI2?=
 =?utf-8?B?S3AzMjRlR0xuN0pBM3dzYm1CKzNyUnhScFRtaHJBaFV6bHRMclFIWi91SzZU?=
 =?utf-8?B?WndaMExwOTdoc3MxL1pKbUhaWU5tWjJnMTNTc1gwNXAyaXJyUkF3YjJHMFd0?=
 =?utf-8?B?T1Rac3VKRHAvc1dCRld4NnVtZGMzM051cmdud3I3QU8rc2E4QWU2NlpZQ2w5?=
 =?utf-8?B?VmFuMjZ4UXREWTJrKzljaEp4aGpXczRKR05WcFpTRE4zM0U3SllhT0Q3a3RB?=
 =?utf-8?B?T1RhN0RiSnozVEFrU1p3UzRJM1F4RktGbUxqRHB6SHhRYkt4aEhHNFhJUi9v?=
 =?utf-8?B?MFFNdlYvTUpBL1VhUWVhRnZOalZGd0swMUM5R1BLdkRWVmpOS0JoOU1ORWNR?=
 =?utf-8?B?NTZ5K25jR0d5a3ZKcGpuMFRtc3ZmWE1MUlNhbE00cmlqTlVPYXNMVXBIWUNz?=
 =?utf-8?B?Tm5RckZsbTFlbzdVY2VJT1RvcmxlRHRtM2tLdmhQdU9hSVhkMm5LaW15OXVx?=
 =?utf-8?B?T0V6eVNSb0dxNjVOWUhiTVpoNGxoaS81cUJDUTV1MXBxUjlBSFU3Yk5jRTcz?=
 =?utf-8?B?T216VnllRGtIZXFTeVZjdlgweEdsQ1hmRzBiYzF4NTM3eGdoMldsbnkrd05P?=
 =?utf-8?B?WkJzVks3ME9scjJQaGwrZ1k0dDJuT2NLUzJsUlc1SzJibWZRbTZLVUQ1M2ZF?=
 =?utf-8?B?LzMwREdzc0t1T2QwejgyKzExU0Y3ZUZEeG94RXpFU043ZFU3QzVZL2dkUmxQ?=
 =?utf-8?B?ZE1JN2xaZ0kzK1RROFlWWEZqZ1NiTzVLWktWZE9La2NFSzJUMVEzY252cVFK?=
 =?utf-8?B?ZWRtbnRDKzlDOEkwbGhzRURzY1RSVFZQVzAzd2lJaHJNOThNT1UyajNjTjVr?=
 =?utf-8?B?NmhiVW9uZnVydHg5dXp6U25EZGhzN2R5WEsyMHFSOEx4NDZqazdvV1ZzNXNT?=
 =?utf-8?B?c1I4ek42TEFsK0wxclRLMFlxZ0lRSDhtNi9mMjFpUmkxZWtzcmJBV3kraEtM?=
 =?utf-8?B?REw2WFV3eWcwNGU5TmozTk45MXNTc25ubjFEUkFmQWJubCtJRkI0UUozSjNv?=
 =?utf-8?B?R1k5SXJ3aVlXTHRtekRSaGlHZ2FCdE9yMFl0VXU5UDBUQi9tcFYyWm5IUFlM?=
 =?utf-8?B?ZmFDRittRzYyRStmc2hYMkdLK2JRPT0=?=
Content-ID: <51A0B7E56E5BF94992848BEE2E9D58C4@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84fbc67-bd98-4b8e-6604-08db721bcff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 05:53:18.1728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4zPnWpCI7GH2NhK9ypPCE0Xw2So17yIe4Ds7wkRUyFW5xPuonJ/Qe0Ger/RnaSBm40kElCY/QTbe+Vv5sp/hiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR05MB9926
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
 Vasavi Sirnapalli <vsirnapalli@vmware.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

DQoNCj4gT24gMjEtSnVuLTIwMjMsIGF0IDM6NTYgQU0sIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToNCj4gDQo+ICEhIEV4dGVybmFsIEVtYWlsDQo+IA0KPj4gTUQ1IGlzIG5vdCBG
SVBTIGNvbXBsaWFudC4gQnV0IHN0aWxsIG1kNSBpcyB1c2VkIGFzIHRoZSBkZWZhdWx0IGFsZ29y
aXRobSBmb3Igc2N0cA0KPj4gZXZlbiB3aGVuIGZpcHMgaXMgZW5hYmxlZC4gRHVlIHRvIHRoaXMs
IHNjdHBfYmlnX2NodW5rIHRlc3RjYXNlIGlzIGZhaWxpbmcgYmVjYXVzZSBsaXN0ZW4oKQ0KPj4g
c3lzdGVtIGNhbGwgaW4gc2V0dXBfc2VydmVyKCkgaXMgZmFpbGluZyBpbiBmaXBzIGVudmlyb25t
ZW50Lg0KPiANCj4gT3V0IG9mIGN1cmlvc2l0eSwgd2hpY2ggZXJybm8gaXMgcmVwb3J0ZWQgb24g
bGlzdGVuPw0KPiANCj4gSW4gb3VyIGNhc2UgaW4gRklQUyBFTk9TWVMgaXMgcmV0dXJuZWQsIHRo
dXMgaGFuZGxlZCBhcyBUQ09ORi4NCj4gDQpJIGFtIHNlZWluZyB0aGUgRU5PU1lTICgzOCkgZXJy
b3IgYW5kIGl04oCZcyB0cnVlIHRoYXQgaXQgaXMgaGFuZGxlZCBhcyBUQ09ORi4gVGhlIGludGVu
dGlvbiBvZiB0aGUgcGF0Y2ggaXMgdG8gZml4IHRoZSBzYW1lLg0KDQpUaGFua3MsDQpBc2h3aW4g
DQoNCj4gS2luZCByZWdhcmRzLA0KPiBQZXRyDQo+IA0KPiAhISBFeHRlcm5hbCBFbWFpbDogVGhp
cyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBu
b3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0
aGUgc2VuZGVyLg0KDQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
