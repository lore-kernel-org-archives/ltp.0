Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EDAC433F5
	for <ltp@archiver.kernel.org>; Fri, 22 Apr 2022 11:06:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C4AB3CA708
	for <ltp@archiver.kernel.org>; Fri, 22 Apr 2022 13:06:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84E783C5DC4
 for <ltp@lists.linux.it>; Fri, 22 Apr 2022 13:05:56 +0200 (CEST)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CBAE41A003CB
 for <ltp@lists.linux.it>; Fri, 22 Apr 2022 13:05:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1650625556; x=1682161556;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hkH4fpWmyJZi4GVH6L/aKp1YtcABHAyk888VuOwnkMM=;
 b=jx+j+4af+lCpicn/7UseJuPbSrqcbJ6P+Z6EV9/KHSYOIS/QXK2iNHf8
 yd9c6QUTnVr46NjD7wqT6JOVeSq9zmPHQTYyEhb126h/hE3K9Xm/EPc0n
 LRDmIWejhpM7ji97wFXX0+Wewdhw3hHHgDBEycEnQfOpRWN9/Yp2X2jQ7
 S+dKtaQETWLHBX96FWcoTsPh5ebpV2Ci4ZX1iiG3c3QOkNYIBFlTtLj8N
 PPj7ZPElh30X4WrAUpL3VY6cWPS4nRSgtmMQX39j9IViNAS8yikVLZD3h
 wnwNdKxZ7aySCUYupWMXtWKxTsFW7QZoGMEIcvS4hPbtNd50D/xy/6nt3 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="54512897"
X-IronPort-AV: E=Sophos;i="5.90,281,1643641200"; d="scan'208";a="54512897"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2022 20:05:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ef+GqV6inWRrPytPGneWthPoZPpOrKHUP2xTACQzynK4v04RpDo0AZjaok841MRTZPqvHoUP3cx/R9TEa29Uixna0t/3jLUf0jo1Tgs6L97X5eq1LenG/mBNajPaVAHYCxgsK4HK/A4DvVFaR3uEnhFMc19vjrURcMKWa6wIPHUBlKv9RN4wxxzxi4TeNXIluW5JnRGGrFMB3b801kB7cd7/qYZNlpiOOyXiPOFu5mew8fEZMc5ZaSGHIFhwWh8OMzGOYfWyfgDN3AhZMIITt0/t9QLG2nYc3DnFGcsqdN/DykW7lCWoF8ZKYtVvuVxhEqA4IVy16GUvYMcL6FRFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkH4fpWmyJZi4GVH6L/aKp1YtcABHAyk888VuOwnkMM=;
 b=PfqAqPkq2xyTYih99Ksmw6E2qM66slynkrcb4Pcy4L14cbujvHdF4UT/qkvoQ7rRKtBGQrFmo7wJknUG5iRrPqlcan1Cixzn97jAFnf/LQe4ra9YbU9vOboZMyyO0GSxSz7Tst8PtARK72Gvi148jeJqDhxQD21O4G8ASVCAbbWuaizC/XSa3Dpw3afr9OMM4fjGAPCPgVQBs4ocHSadRT7y1AOBTwMeAcHV+zSnzl2mxeJAiXGzPOJGJTozvAfT6SVnyD8oTIa71WIENSdyyr+PWqofH035PEGy6Hnhun/a/R+s+OlJxTzdDtLPZenWA7g669vb8Jn9IIzsSsTZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkH4fpWmyJZi4GVH6L/aKp1YtcABHAyk888VuOwnkMM=;
 b=iZ18A0ePwLUHO8YT9yKp3VlRwDZ9FMnvWZUWTcgRl9GNp2TZ4JT6ylDtLftkcZMUwkkqLNUCKaBI+zbd7hx/Yn0yLn/dtByLnWJ9Gs7E2wdclbsq5mqyzxxTh3JFfrLZ6Wo4IeLAaYnPht/6++lY6E5qI/6MXwJswxp7u2CR/0E=
Received: from OS3PR01MB6449.jpnprd01.prod.outlook.com (2603:1096:604:f5::13)
 by TY2PR01MB2634.jpnprd01.prod.outlook.com (2603:1096:404:76::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 22 Apr
 2022 11:05:49 +0000
Received: from OS3PR01MB6449.jpnprd01.prod.outlook.com
 ([fe80::dc84:7b2a:da69:3142]) by OS3PR01MB6449.jpnprd01.prod.outlook.com
 ([fe80::dc84:7b2a:da69:3142%7]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 11:05:49 +0000
From: "chenhx.fnst@fujitsu.com" <chenhx.fnst@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v2] syscalls/mount_setattr01: Add basic functional
 test
Thread-Index: AQHYVKGE4oGeM3XMkki5ArHGXbY18az5RTYAgAKBFQA=
Date: Fri, 22 Apr 2022 11:05:48 +0000
Message-ID: <OS3PR01MB644958457FD5DD0B37BF2A83E6F79@OS3PR01MB6449.jpnprd01.prod.outlook.com>
References: <20220420102926.866-1-chenhx.fnst@cn.fujitsu.com>
 <YmBwWqS0GEuwnb/d@pevik>
In-Reply-To: <YmBwWqS0GEuwnb/d@pevik>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4b37835-8a99-40f9-1cf2-08da24500ec6
x-ms-traffictypediagnostic: TY2PR01MB2634:EE_
x-microsoft-antispam-prvs: <TY2PR01MB2634797232F11535DF77F851E6F79@TY2PR01MB2634.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4eEK1hcH1Ly4KRg9PThYeRytJJWOGD2AfOtckakmuCaNksg9SxXtv4XtXo32EVkpjg7RTBaUds8ojbLViqpjzZhZyoq4gg2i+1t2HozaK9fz/YloAN+hAtoCNlE9zGSMIRffGsFxHs3ZOij/uW+FsKDLYMr/9aMpLxBpjbEgx/u15l1yoWNVCDl4WrvPcDpLUjHq0gqXHzCrSlRydKnzAa+vELYPRzzg3oCsAvE/XxPncBKZuatHr3J0aSybxPsozcxL0oZhNksK7/2H0HjTqiPsW4LBw4LuG1l30HW29+bXmQPDZRqGixBAEYkuxlkAXCQ5Euif5rWmUDujQPCxCCn/szBaF/Q75I2saFNy/aCE0dMOOuHWBc3sfokXCrDlv/ixrkbtxiloGP//0z/DNvlDdUJADqw8HxKt3MXf8ys+oEUcI2xHGtcmP0sOyvKwzH1Lakxxqvhmle0QBvuyl2co1D3q9Peiscy6CbH9cEtLZNBlHin8YMUww1qWtARk0VVZQQYR42jTM+HwPAPs1MdgCmwqwscdUzZCVkv6Hpe2UP1G0KvK+kOfUsB2H8ieHv/fc2sS2Suf1BfBTT3Tj+BD+bf3n2DyyqgjgbaafNcgi7bMTPtHa0QmYQp+kdXfFXPIFnfVpv54wSV8WwoIFmcOfLWBAyjwWVyiEJo5x+ZPt3q6h3GQmbUwLjrthEN5TN5nagvitNtyUaERlgz+tA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6449.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(508600001)(8936002)(122000001)(26005)(54906003)(38100700002)(52536014)(2906002)(7696005)(76116006)(33656002)(82960400001)(66946007)(85182001)(9686003)(38070700005)(224303003)(55016003)(71200400001)(64756008)(186003)(66446008)(86362001)(6916009)(5660300002)(4326008)(83380400001)(66556008)(316002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TFoycExCSjVDVmRuTVpnY1lUY1N4emxxUnJFMUJwVGVDZCtHSFdFMXhkaUUx?=
 =?gb2312?B?amhiRmZrQmRHcHMxaGxwZzh4RG5iZmk2Mnk5OTNjS0tLcnpzdHVCY05VdHRu?=
 =?gb2312?B?K2FBdTFVc29veFlKNTlsTUc3d1EyUEV6QUFSY1E3Rk1zLzFxdUJCSFM3cXFo?=
 =?gb2312?B?cXZlR25iOUNHaGNQdVlFZEV2MUdFYXJ0UVF2MnZZZFM2SHZOUmlZTzNLTy9u?=
 =?gb2312?B?a1JvczZVMGs1Z3hoWnpOckNMY2tKY1hMVDdhUXkxemVvYjlUMjlJR0xTaEkz?=
 =?gb2312?B?a3IrM0wrLzRRK1ZrMmo5VjU2azdQNGRKdldjVUZFYkRYbkVTQnV2d2d5NmZv?=
 =?gb2312?B?VlRVRnRBa1NXR0ZMTFBlV1h4bXZXMHVkT3h0MEdiR0tIR1cyS0pFOVZsb1FQ?=
 =?gb2312?B?d2h3OU1OVGZjMHBIc2E2aSs3dkpJWXBVeEc1dnlqQmJRRVppK3dEdDhpa3NR?=
 =?gb2312?B?S0lTQWtEbkZUSHo4NTdFaFRDRGdRU3dybXV0VmQzdFNoK0RZT0dmMVNMNHpk?=
 =?gb2312?B?SFkrcFRUVkdNWWQvdHBrRUp0NUQ3WUJDcDVmM1d6cGNOak8vSlRxREF4MGdC?=
 =?gb2312?B?WW9UNnFpT0xDMDBqMkMwVWJUTEZXa1JFakFQVC92ak9Mb0VpSEFicDNuaG8v?=
 =?gb2312?B?VnNIMEJCMEU1ZFVoU0ZYcWVMNFNFWEl2YnlYZVI0WmtOM3FqNGpmMVFZYmhP?=
 =?gb2312?B?aDErcFZDa21zSmcrWGJGd0hsUHQ3Q000VVlOZy9OREhYc3BDSllpZ3A4SmZI?=
 =?gb2312?B?QkFNaHM5Qjk4MlM5QStCQytSVnFlSVFsMEo2U3hWQmNKRmZodWNSNHI4N1J4?=
 =?gb2312?B?Z1JRb2l0OEVaMU9xMHlHdDA3WGxSdGVaa3ZzTDYyK0NSZks2c201VUNSU3Fs?=
 =?gb2312?B?dmZmeFV0MWo1cXhDNlFrRm9jUHBqQkJIakRFRGhRbVYycG5OSERjSlMvM09r?=
 =?gb2312?B?MlI1MW14RWdDMWZaV2xLbVRZNENYSlZnQ1pJZC9YdmRYMllCT1ZUdGlCSTQy?=
 =?gb2312?B?UDIzMy9WOUlQZFRLOEVlYVc0cCsySXduK2lHRWFvM1BnYU9lR1FxQVZvRE1u?=
 =?gb2312?B?QitmckpKUFBjMFBtVktXMm9VTzNhUDhHQjR1RXAyUDUrNW53UndKRERIWmw1?=
 =?gb2312?B?Vkw0Nkx4K0l3Y080aW9nc1F0aFd5Q0hiaEduQVUyMGJURGlPSm12Q1lPR3FX?=
 =?gb2312?B?a0tXdkFTNU9uNk1jTWlzU2lkV0ZZOVJENkppY2xtRGszazgwMlZvOFVFNFJ5?=
 =?gb2312?B?SlRVamplQXdSVWZZdjVKRnJlOUhCN1N1bk1kNVFCdkcxQVp6SWV1YzRIZkgw?=
 =?gb2312?B?OGJhRUV2eVZYWG16QnE3ODFueDF1bVV6c05jbStDbmI4Zm51aDVDMTVjL3BO?=
 =?gb2312?B?T052a2ZYa0xwbmVCMDhPRlhXUGxPc0pOUXFQNDFnNWgzK2VJQVBZSTJNTms5?=
 =?gb2312?B?MUZiUmRWZHBtdG4zekV4ODcwTEszRllPSWFlYXkwRE42V3pXQ25CcG9XQ0Iv?=
 =?gb2312?B?bmMzYkV2cFZsbGFYS3lXVDhqZERRZ1JkUVZVWFlyNmhwOERIOUZzK3Y0VmN2?=
 =?gb2312?B?OWxoRHpnd1ovbUt4YkxqV1dROEZNeTM1K1pIUlZVRHVnczJWKzEyV29QZzRz?=
 =?gb2312?B?eHBtbWx6NDkrWXA2QnF5NzZlUnFLaEhFcE84SnRsSkdXVWdKWnZPdFMzRDIy?=
 =?gb2312?B?bDk5RUpDbmo2UU8zN3c0MGxTeFVkaDFDSm4rQVhjR0xEbmQ5M1doMytYM1Ey?=
 =?gb2312?B?ZzFOVmMvTmIrLzI3N0JKMkQreEtyL0V4cHVRUTFKMElRdXJSRnJpTUtYYm03?=
 =?gb2312?B?VlhiWVB4M0owK2lqK3BJaEVGb0JVZnVKeUhtS0dtdGVwMTkwMFR0d3FoSWlX?=
 =?gb2312?B?eHZaMm5leVpTVjBYTC9lVXNPSWVWdzI0YVhOSWdUMUdhbkRra0pGOWwwRWg4?=
 =?gb2312?B?a2lJTWtTbytxUVdReHBLTTdadjl5blV0RkdCbTJIYjJwYVVsMjRtNVhVS2U0?=
 =?gb2312?B?RVJGREJnOWNhcGF0NTA4T3krSU16ZHpQK2pZWGNtc1Fta25CWG83YTFpdVAz?=
 =?gb2312?B?akJLUkx3L0IrbHg3Q09EYytrTmxNUWR4QlBkRFZjL2lhR1p5c3FjNmhNSURG?=
 =?gb2312?B?cjFOdllBSjNqYVVjZWtyY0ppMUdCWjJVbFJRU3lJMmZpNWhwYy9nVmdFbXNB?=
 =?gb2312?B?ODM5dFpyekQzK0xCQkVURThqZjRTT29qZ0IwNy9odVNmK3g3YytFMjNXYjNC?=
 =?gb2312?B?dSs1V01JWXcwcnRzS09XQWlDTDZSSTVUVGEwN3piY05NZTNCcW9CeVlTQTk5?=
 =?gb2312?B?dXlDTGxycDh0MGdsNzc2bm04QTQ0UWlwVFE1REtKN1J5QVBzK0VVZz09?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6449.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b37835-8a99-40f9-1cf2-08da24500ec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 11:05:48.9726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AgivW2i/wrfCQhWWSEpBfXW/bCKqhnH3d9VY/E2eZAPUBURT8w3C/nWcuS1UKHPTm9jKvymS/IUYFRO985A6yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2634
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] =?gb2312?b?u9i4tDogIFtQQVRDSCB2Ml0gc3lzY2FsbHMvbW91bnRf?=
 =?gb2312?b?c2V0YXR0cjAxOiBBZGQgYmFzaWMgZnVuY3Rpb25hbCB0ZXN0?=
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksDQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogUGV0ciBWb3JlbCA8cHZvcmVs
QHN1c2UuY3o+DQo+ILeiy83KsbzkOiAyMDIyxOo01MIyMcjVIDQ6NDMNCj4gPGNocnViaXNAc3Vz
ZS5jej4NCj4g1vfM4jogUmU6IFtMVFBdIFtQQVRDSCB2Ml0gc3lzY2FsbHMvbW91bnRfc2V0YXR0
cjAxOiBBZGQgYmFzaWMgZnVuY3Rpb25hbCB0ZXN0DQo+IA0KPiBIaSBDaGVuLCBEYWksDQo+IA0K
PiA+IEZyb206IENoZW4gSGFueGlhbyA8Y2hlbmh4LmZuc3RAZnVqaXRzdS5jb20+DQo+IA0KPiA+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xhcGkvZnNtb3VudC5oIGIvaW5jbHVkZS9sYXBpL2ZzbW91
bnQuaA0KPiAuLi4NCj4gPiArLyoNCj4gPiArICogbW91bnRfc2V0YXR0cigpDQo+ID4gKyAqLw0K
PiA+ICtzdHJ1Y3QgbW91bnRfYXR0ciB7DQo+ID4gKwl1aW50NjRfdCBhdHRyX3NldDsNCj4gPiAr
CXVpbnQ2NF90IGF0dHJfY2xyOw0KPiA+ICsJdWludDY0X3QgcHJvcGFnYXRpb247DQo+ID4gKwl1
aW50NjRfdCB1c2VybnNfZmQ7DQo+ID4gK307DQo+IEludGVyZXN0aW5nIGVub3VnaDogaW4ga2Vy
bmVsDQo+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21vdW50X3NldGF0dHIvbW91bnRfc2V0YXR0
cl90ZXN0LmMNCj4gZGVmaW5lcyBpdCBhcyBfX3U2NCAoSU1ITyBzaG91bGQgYmUgcmVhbGx5IHVp
bnQ2NF90IGFzIHRoYXQgdGVzdCBpcyB1c2Vyc3BhY2UgYXMNCj4gQ3lyaWwgcG9pbnRlZCBvdXQp
IGJ1dCByZWFsIGtlcm5lbCBjb2RlIGluIGZzL25hbWVzcGFjZS5jIGhhcHBpbHkgdXNlcyAidW5z
aWduZWQNCj4gaW50IiA6KS4NCj4gDQo+IC4uLg0KPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL21vdW50X3NldGF0dHIvbW91bnRfc2V0YXR0cjAxLmMNCj4gPiBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW91bnRfc2V0YXR0ci9tb3VudF9zZXRhdHRyMDEuYw0K
PiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwLi5kNjNkYjQ2ZmEN
Cj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9t
b3VudF9zZXRhdHRyL21vdW50X3NldGF0dHIwMS5jDQo+ID4gQEAgLTAsMCArMSwxMTggQEANCj4g
PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4gPiArLyoN
Cj4gPiArICogQ29weXJpZ2h0IChjKSAyMDIyIEZVSklUU1UgTElNSVRFRC4gQWxsIHJpZ2h0cyBy
ZXNlcnZlZC4NCj4gPiArICogQXV0aG9yOiBEYWkgU2hpbGkgPGRhaXNsLmZuc3RAZnVqaXRzdS5j
b20+DQo+ID4gKyAqIEF1dGhvcjogQ2hlbiBIYW54aWFvIDxjaGVuaHguZm5zdEBmdWppdHN1LmNv
bT4gICovDQo+ID4gKw0KPiA+ICsvKlwNCj4gPiArICogW0Rlc2NyaXB0aW9uXQ0KPiA+ICsgKg0K
PiA+ICsgKiBCYXNpYyBtb3VudF9zZXRhdHRyKCkgdGVzdC4NCj4gPiArICogVGVzdCB3aGV0aGVy
IHRoZSBiYXNpYyBtb3VudCBhdHRyaWJ1dGVzIGFyZSBzZXQgY29ycmVjdGx5Lg0KPiA+ICsgKg0K
PiA+ICsgKiBWZXJpZnkgc29tZSBNT1VOVF9TRVRBVFRSKDIpIGF0dHJpYnV0ZXM6DQo+ID4gKyAq
IDEpIE1PVU5UX0FUVFJfUkRPTkxZIC0gbWFrZXMgdGhlIG1vdW50IHJlYWQtb25seQ0KPiA+ICsg
KiAyKSBNT1VOVF9BVFRSX05PU1VJRCAtIGNhdXNlcyB0aGUgbW91bnQgbm90IHRvIGhvbm9yIHRo
ZQ0KPiA+ICsgKiAgICBzZXQtdXNlci1JRCBhbmQgc2V0LWdyb3VwLUlEIG1vZGUgYml0cyBhbmQg
ZmlsZSBjYXBhYmlsaXRpZXMNCj4gPiArICogICAgd2hlbiBleGVjdXRpbmcgcHJvZ3JhbXMuDQo+
ID4gKyAqIDMpIE1PVU5UX0FUVFJfTk9ERVYgLSBwcmV2ZW50cyBhY2Nlc3MgdG8gZGV2aWNlcyBv
biB0aGlzIG1vdW50DQo+ID4gKyAqIDQpIE1PVU5UX0FUVFJfTk9FWEVDIC0gcHJldmVudHMgZXhl
Y3V0aW5nIHByb2dyYW1zIG9uIHRoaXMgbW91bnQNCj4gPiArICogNSkgTU9VTlRfQVRUUl9OT1NZ
TUZPTExPVyAtIHByZXZlbnRzIGZvbGxvd2luZyBzeW1ib2xpYyBsaW5rcw0KPiA+ICsgKiAgICBv
biB0aGlzIG1vdW50DQo+ID4gKyAqIDYpIE1PVU5UX0FUVFJfTk9ESVJBVElNRSAtIHByZXZlbnRz
IHVwZGF0aW5nIGFjY2VzcyB0aW1lIGZvcg0KPiA+ICsgKiAgICBkaXJlY3RvcmllcyBvbiB0aGlz
IG1vdW50DQo+ID4gKyAqIE1pbmltdW0gTGludXggdmVyc2lvbiByZXF1aXJlZCBpcyB2NS4xMi4N
Cj4gU2luY2Ugd2UgZG9uJ3QgY2hlY2sgZm9yIHY1LjEyLCBpdCBtaWdodCBiZSBiZXR0ZXIgdG8g
c3RhdGUgIlRoZSBmdW5jdGlvbmFsaXR5IHdhcw0KPiBhZGRlZCBpbiB2NS4xMi4iIChhbHRob3Vn
aCBvbmx5IGVudGVycHJpc2Uga2VybmVscyB3b3VsZCBiYWNrcG9ydCBuZXcNCj4gZnVuY3Rpb25h
bGl0eSwgbWFpbmxpbmUgc3RhYmxlIGtlcm5lbHMgd2lsbCBub3QpLg0KDQpGaW5lLg0KPiA+ICsg
Ki8NCj4gDQo+IFRoaXMgbmVlZHMgc29tZSBjaGFuZ2VzIGluIG9yZGVyIHRvIGJlIGZvcm1hdHRl
ZCBwcm9wZXJseSBhcyBsaXN0IGFuZCBoYXZlDQo+IHBhcmFncmFwaHMuIFNpZ2gsIG5vYm9keSBy
ZWFsbHkgcnVuczoNCj4gDQo+IGNkIG1ldGFkYXRhLyAmJiBtYWtlICYmIGNocm9taXVtIC4uL2Rv
Y3BhcnNlL21ldGFkYXRhLmh0bWwNCj4gDQo+IHRvIGhhdmUgbG9vayB3aGF0IG91dHB1dCBoaXMg
ZG9jcyBoYXMgOiggKGNhbiBiZSBmaXhlZCBiZWZvcmUgbWVyZ2UpDQo+IA0KV2lsbCBiZSBmaXhl
ZCBhbmQgSSdsbCBiZSBtb3JlIGNhcmVmdWwgbmV4dCB0aW1lLg0KDQo+IC8qXA0KLi4uDQo+IE9Q
RU5fVFJFRV9DTE9ORSkpOw0KPiBBbHRob3VnaCBDeXJpbCBtZW50aW9uZWQgb25seSBUU1RfRVhQ
X0ZEX1NJTEVOVCgpLCBJTUhPIGl0IHNob3VsZCBiZQ0KPiBmb2xsb3dlZCB3aXRoOg0KPiAJaWYg
KCFUU1RfUEFTUykNCj4gCQlyZXR1cm47DQo+IA0KPiBPciBkb2VzIGl0IG1ha2Ugc2Vuc2UgdG8g
Y29udGludWUgdGVzdGluZyB3aGVuIG9wZW5fdHJlZSgpIGZhaWxzPw0KPiANCj4gPiArCW90ZmQg
PSAoaW50KVRTVF9SRVQ7DQo+ID4gKw0KPiA+ICsJVFNUX0VYUF9QQVNTX1NJTEVOVChtb3VudF9z
ZXRhdHRyKG90ZmQsICIiLCBBVF9FTVBUWV9QQVRILCAmYXR0ciwNCj4gc2l6ZW9mKGF0dHIpKSwN
Cj4gPiArCQkiJXMgc2V0IiwgdGMtPm5hbWUpOw0KPiANCj4gU2hvdWxkbid0IGJlIGhlcmUgYWxz
byA6DQo+IAlpZiAoIVRTVF9QQVNTKQ0KPiAJCXJldHVybjsNCj4gDQo+IGNoZWNrPyBJIGd1ZXNz
IHdlIG5lZWQgU0FGRV8gdmFyaWFudHMgZm9yIG5vdCBoYXZpbmcgdG8gY2hlY2sgaXQgYWxsIHRo
ZSB0aW1lLg0KDQpJdCdzIGhhcmQgZm9yIGEgU0FGRV9NT1VOVF9TRVRBVFRSOg0KbW91bnRfc2V0
YXR0cigyKSBuZWVkOg0KI2luY2x1ZGUgPGxpbnV4L21vdW50Lmg+IC8qIERlZmluaXRpb24gb2Yg
TU9VTlRfQVRUUl8qIGNvbnN0YW50cyAqLw0KDQpCdXQgbGludXgvbW91bnQuaCBoYXZlIHNvbWUg
Y29uZmxpY3RzIHdpdGggc3lzL21vdW50LmgsIHdoaWNoIGlzIHdpZGVseSB1c2VkIGluIExUUC4N
CklmIHdlIHJlYWxseSB3YW50IFNBRkVfTU9VTlRfU0VUQVRUUiwgd2UgbWF5IG5lZWQgYSBiaWcg
cmVmYWN0b3IuDQoNCj4gDQo+IE9yIGRvZXMgaXQgbWFrZSBzZW5zZSB0byBjb250aW51ZSB0ZXN0
aW5nIHdoZW4gbW91bnRfc2V0YXR0cigpIGZhaWxzPw0KPiANCj4gPiArCVRFU1QobW92ZV9tb3Vu
dChvdGZkLCAiIiwgQVRfRkRDV0QsIE9UX01OVFBPSU5ULA0KPiA+ICtNT1ZFX01PVU5UX0ZfRU1Q
VFlfUEFUSCkpOw0KPiA+ICsNCj4gPiArCWlmIChUU1RfUkVUID09IC0xKSB7DQo+ID4gKwkJdHN0
X3JlcyhURkFJTCB8IFRURVJSTk8sICJtb3ZlX21vdW50KCkgZmFpbGVkIik7DQo+ID4gKwkJcmV0
dXJuOw0KPiA+ICsJfQ0KPiANCj4gTWF5YmUgaW5zdGVhZCBvZiBURVNUKCkgYW5kIGlmIHVzZSB0
aGlzPw0KPiANCj4gCVRTVF9FWFBfUEFTU19TSUxFTlQobW92ZV9tb3VudChvdGZkLCAiIiwgQVRf
RkRDV0QsIE9UX01OVFBPSU5ULA0KPiBNT1ZFX01PVU5UX0ZfRU1QVFlfUEFUSCkpOw0KPiANCj4g
CWlmICghVFNUX1BBU1MpDQo+IAkJcmV0dXJuOw0KPiANCg0KU3VyZSwgSSdsbCBwb3N0IHYzIHNv
b24uDQoNClJlZ2FyZHMsDQotIENoZW4NCg0KPiA+ICsNCj4gPiArCVNBRkVfQ0xPU0Uob3RmZCk7
DQo+ID4gKw0KPiA+ICsJVFNUX0VYUF9QQVNTX1NJTEVOVChzdGF0dmZzKE9UX01OVFBPSU5ULCAm
YnVmKSwgInN0YXR2ZnMgc3VjZXNzIik7DQo+IEFuZCBoZXJlIGFzIHdlbGwuDQo+ID4gKw0KPiA+
ICsJaWYgKChidWYuZl9mbGFnICYgdGMtPmV4cGVjdF9hdHRycykgPT0gMCkNCj4gPiArCQl0c3Rf
cmVzKFRGQUlMLCAiJXMgaXMgbm90IGFjdHVhbGx5IHNldCBhcyBleHBlY3RlZCIsIHRjLT5uYW1l
KTsNCj4gPiArCWVsc2UNCj4gPiArCQl0c3RfcmVzKFRQQVNTLCAiJXMgaXMgYWN0dWFsbHkgc2V0
IGFzIGV4cGVjdGVkIiwgdGMtPm5hbWUpOw0KPiA+ICsNCj4gPiArCWlmICh0c3RfaXNfbW91bnRl
ZF9hdF90bXBkaXIoT1RfTU5UUE9JTlQpKQ0KPiA+ICsJCVNBRkVfVU1PVU5UKE9UX01OVFBPSU5U
KTsNCj4gPiArfQ0KPiANCj4gVGhlIHJlc3QgTEdUTS4NCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4g
UGV0cg0KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
