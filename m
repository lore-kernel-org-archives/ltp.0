Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50CCF364D1
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 22:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775775351; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=B3mCy6SY6xzUj85AS9uZbkahRwqswTmZqodz+LCsuUY=;
 b=daWI0x3ju4kqJyaiUC/7+VKQ82ZULALMLMyYUIYVsRmYLmZugZ2bSqdKWlOOjhbOT6z9T
 MLRceTSHM0hWWOGjjhrdsXQoipXrtjkgQEubPq9NP/ZEDXAX0ddRdOUzgxAVx84rRVhAHF8
 P+IyUpnZAUeAU/+d8DV9DHdu2Az/zwY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C75F3E60A6
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 00:55:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B3633E1A21
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 00:55:26 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F0282600486
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 00:55:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Si24HgFKmk1MHMu4MWmwN0NLyTCkRdf+yh6GHqLNGgo//r3Ov0hHGY3i6U2txC1qMOKU85lHkxI5OwkKnYIHs/B/rabR5sE9nl6NELJANWVTFWUmwIk5/cnGvfz2VQdealfTGp+0eByCh2T9/h+pu1spC/ozUGntqHRYDTwAKc5/iJfZB2rC4FFtmh8qZrl4H3JdhxueuCDLXAJ8pJvtzfw+3or7bmN91Cw1L1fBPBH08dj7its5a9bOpjIJ0bY+D2i5WgEoGmuxNIZlN9ORS7lGXalDsdWhpW5y4C5ZvyEzkAlEFXpQ0IJMisOqeWUqjylirwH349CySDhit1kbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c88pcVBHlrXY6JemcbMCZBmswhEYiWelXU+jI25B1IM=;
 b=fVYqho1x3B/qE3qlVlE0/YX5oD6pwJRfHmzB3ja9zlgUx6sul/VuIj2gz1PUCuiFjrX1xUxltka2aoJgPzjWU8Jk1azvKuhjuQAk8okf+RNqicjpUVkbcZq1rBpXrkm907MmW7qZvCJAXqv7hvE72DxoJVo31wBaN4zOB++qK3whiIPiIm811EkXcpNybNxk/hujwH9+gtwTs5cDCjJWlGaXYNzxVQol4wr8vkXYKuYvgI0WlQoZq/t+aY9nKthNkskHm/Sfp7tQDQK3oQ1uU42+nSacWzJqSH8zI5h24Cp3tGH+Py3+Zp18x2ldVWYO3soK47yK2+FKCHR7wvK6YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c88pcVBHlrXY6JemcbMCZBmswhEYiWelXU+jI25B1IM=;
 b=HFTFkqiw16A4ljcyHhTPKQ88doNF7RzCrZLVCbtJHoY5DxQLEOMen6yHCK/Yv/6BPyNXkSZ47IauylAZ61vvRlYEo5gcV59N5hEbqFWuIr1NcpbqwJ8SqYmqN/ZZWg9zuunq9zT7+4baaVhu7Rr4mYUnd11NM904dbAapjtBtjvMU4DL2W1tdNm/XCcx7tQJ+n0YbIXP8Nu6UAFxrtMgtXbowniTbwtZGNdvH8HFqW4kblk1ZIp97pgeav7pF2fyI0xpPPr+91u1hoN7bzmV67qEnF7UAx3CVwhH8qd83Ww0AfLa+KrAkGT28hIe2BIpae4KlJGMC4oJP+bp6YnN+A==
Received: from DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Thu, 9 Apr
 2026 22:55:21 +0000
Received: from DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591]) by DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591%6]) with mapi id 15.20.9791.032; Thu, 9 Apr 2026
 22:55:20 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls: file_attr05: skip ntfs filesystem
Thread-Index: AQHcx39M5lxVQj5BUk6C0HklgVevaLXWXPyAgAD72gA=
Date: Thu, 9 Apr 2026 22:55:20 +0000
Message-ID: <79CF2D7E-5987-4321-BDE7-D5FF34EBF952@nvidia.com>
References: <20260408174406.1572520-1-mochs@nvidia.com>
 <20260409075345.GC64002@pevik>
In-Reply-To: <20260409075345.GC64002@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8442:EE_|DM6PR12MB4122:EE_
x-ms-office365-filtering-correlation-id: ae43da7e-f8b0-46ec-c138-08de968b13af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: wccl48Fay6LruMpaFLINY2g6CYgZo7VhNit6BAkzvIiqfxTy26AuX4HbNJK3vhn3i5OZ1krIBoMxIzh6sUR/np9dcX0O82yyjx6yIXyHxPLtxEkdHh34abdcVlO/EZPGASlMpeqou+iXeGPuMqUb4pvSjsXruNH+Zv5KwHxU3JZ30K0ZiRLf8y7KjzTXKdKtvFBOAewv2DxXL8pZR2bQzkwKR48/cpnhkpWzf27cvrCy7cWpx8uH0FQFMhgJgBS/nQ52310v/Mk8iRZWoBZFDNMNfK7O+WB3OX4gjBhxJKED0nZCL8d77KuCa73/JKtg7HVdXaUZ8APcd6OYkoCrPXaZ7hvKlImPuoJTlQODWaro4oa/aZMPAcg2tnmVwj0l2nfZpF2sRofu6avW6pYuNVsrgOHo+KyOcNGmxy28y3pMs9pUpu6k/LidF99+MYMicmrfiotSW3CLNTVBQnNbacx4ya2OGCkK3xU2X4lHmcP8zru1xCEQefpXa4HXbzVBOYpzyj1TotGPQJxVU0MRCuKxoYcqsvXlL2Vd2eyRoa2NwNPZDvc/yx9AQ9ud9qe5Goc3G0LqpYKr6ppxGYB0lWa9kHYEA6lB9lkb5q6wiufg3tVrQSA/IelyJ5nCyQwDPbxLbEYH2O0195Id38Ff354CZe4mG4FxjwB++HPM4qusGmCxgldr1f1K4SrGMu7RkPdeUqnTga9BQe3bmUVGJQ/OJ8cmzr/xnMj+IbRw2Geu1guAZebAaMjz6pktUw0mUfav9oxLOkDlUOyDfJb21Nwve0uLWdv/TOb1EWQ4u1g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0plNGU5dEM1ekIyYklNODBWTXZkaEZPdzRKekU2eWcybGRmdkdRRjFEZzBz?=
 =?utf-8?B?d1pkOE1paFk3M0dIT3MxNjhhVEZDM01jQ3R0b2V6eWcvaFFSSWNUcVlBMWdy?=
 =?utf-8?B?ZUhKaGVCNDBUNFNHTzFlNnVYUmxPT05lc1A4U1p1dEcwR0V2YVQ2c2NnTFhU?=
 =?utf-8?B?VzZqdzd6VExwY2lyTFk2ayt5NjcwZmVpc2hoNWJkU3hSOWFuREdBMlFRQVM4?=
 =?utf-8?B?UUVNWG4ySjNFb1lRanpqSzU2Z3JndWlLaFVrUkROL1RJbXNrZ0NJS1JDMExL?=
 =?utf-8?B?bFR0QXhuZmU5SzZ4YWljUXM3NktiNjhHRWxSWWYreDhQc3kxNFk3Y05XdmRm?=
 =?utf-8?B?a05RK1FWSS9GQ2RjUDNydnJUN3krR3RyeVV0b1FNWmxBeXJhL0N2bXpGS2Vm?=
 =?utf-8?B?aVV3SHVWZWt5ZC9VaGNSMzRudmdvdTRjUFlaTWFOaHJqTk00NGR5S0tkSmtx?=
 =?utf-8?B?Z2RDUlF5TlJSSUlvenA1czNueVd3TXpUaTRMS1VGZ2tBL1JlVHBlUzB0MG1G?=
 =?utf-8?B?ZnUrT0lFTHY1TGgvMVdVZTA2QldOZ3lCUzh4UWNweVpiRjF5VXpja2RWN1lB?=
 =?utf-8?B?YzRJVjM2SVQ4SGhydmRTZTZ5L3JoR2prMmMrZmNnbk9ZTkhVQWxZdjdlYnor?=
 =?utf-8?B?TXJJb09WL2ViYjJMaFhPNmp1SHVBV1BJamV0cFBiNm04azVlUkI2ek41b0xm?=
 =?utf-8?B?dmNPRnRiUlp4T1dRUzVxNTNkMHBudFBDd3JBYVpiam0xbitNWk50YThRd3dH?=
 =?utf-8?B?bFRqOGVORTZRSWJ3VnZMTHhVUDFzanhFQzJseVRjOXRMcXdMMFlaOGlHSnhN?=
 =?utf-8?B?WjZjTUYwSmpJM25ya05LZkg3Ui92M1NnamVod09DVlZGWGxHM1o2by9Zc1la?=
 =?utf-8?B?c25FTDBKdWV6ZjBZdkgxNytDMmNBTzFGcXl6aytqc3pTVkNsNFZUaVoybmF3?=
 =?utf-8?B?NkF1NVZsNjM2aE5VOGtITmtZdXlKS3ZmQk5sWFdqbE81V1J6YWQ4T2kxT1Qv?=
 =?utf-8?B?VDNrOVRvbGpFT0V4d3dRSGJSZUZtWERmbHpQRHd6SFV2SkZGVDJyR2lqNW1O?=
 =?utf-8?B?eEVlWXV6bm9QaGwyS3Q5dEZINDk3dnExblBlYUVRcWtJYVV0Umd1SlFBUnM2?=
 =?utf-8?B?dDlCK2ZGbVN5VzJZcmRKSWlpZGdWTEh2SEhnbFk5RDRXbXA5S2dIZFBISmVt?=
 =?utf-8?B?NHh5RHFBNENJcVQ5NmFJRFp4Umk4WW0zTDN4Wk9rUVRPUFRnRjNPdlhKdjA2?=
 =?utf-8?B?ay9keGZUQ3ZpUFkzaG53UU9ZbmVFQ1dLbm9WeGVEYzczNUd0MjlGek1YWDNN?=
 =?utf-8?B?TXUrOC9hT0I3RTRYYkxmdktqeC9tVEZzLzh5cklMMkpDMjlPb3FWWlN1SzN6?=
 =?utf-8?B?WHlnL1NpalhIZ0JOeDYxOHdoanZteHdKN3lBSzFnVmJZN0Q3V1o3REdBSjBW?=
 =?utf-8?B?dUpEUGs3NEo4eXBCd3ZNckw2OGxUN1RmK0wzaStLV0twMEVXWktaYmJWayt0?=
 =?utf-8?B?b1VTeHZSL01aR050c095RTVGb1Z6d0d6SG1TajBjalJrSTF4eEhicDFod2pq?=
 =?utf-8?B?ZmhFdU80eW40U2tqTEFuTDhmbVdzK3FsbDAzbzlLTFFZQUFkNE5yZ0xuWnMy?=
 =?utf-8?B?ZDNhMXR3QnAvaE1pV1BGRWp5NlZrYWJCK2FpK1BEMC9vdDduUW1Balhxd3U1?=
 =?utf-8?B?WExJWjdrVi9KS1Mxak5QUDBSU2NNWGk1R1hRZEEzM2k1aktpaDlzN3dNMzQ0?=
 =?utf-8?B?VDltQ0VFa1RzM2pLcVBtUWtmeU1wS2hMc3Q1ZFhqMGhMYWlVaE53Mm9ML0FY?=
 =?utf-8?B?UXB0R0JTdXk2VGV0SS94OHJ3ZVhJbmFxby8yZ01kQng1SlduZWpibGVlb0RK?=
 =?utf-8?B?VlpZanBJMWdQUThmeTkyNDM3L29tWnNMSXFjRzRwVzYzS2ZKdkQ3YjdZbnk0?=
 =?utf-8?B?SnZSajhXaGdZdUk5R2hkN0t1b05TWXRyRGRuUmk1SUE3eFNZT2QwQnowLzlv?=
 =?utf-8?B?Z1ZrN3Q0c3dOYk9sbi9HZ1pRWFNyVUZjUnk4eU9Sb28rMWphUDN1WU43K0h1?=
 =?utf-8?B?YStpMGlYNGxiWVYwVXEzUWtNOHdwbFhRMnhVWm5XL25XVU5aRDlneXZDRlRi?=
 =?utf-8?B?UExkMUtTTlRtM0g0Z1MwTEppbThxUEMyM0Zja1JCQTd4S2ZPNTh1U0ZUL0pK?=
 =?utf-8?B?V1RDOC9uUmpybTRjODBpYW9pMWQzUE0zQTFDUCtnbUJoSi8zb1NhMGx6Z24w?=
 =?utf-8?B?Kzl4NWdaQzVQa2VCMG9wc28yMldRbVJ3S2hGODcrQ3R1bnFyTzRyV2E3Wk1p?=
 =?utf-8?B?c1pCbzVFSmkyYkhaZ3BMbERmaEJhU3pYM3NPT2RJSmVmb2IzSklEZz09?=
Content-ID: <A303B019B54BDD4BA39725883C7E2CD2@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae43da7e-f8b0-46ec-c138-08de968b13af
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 22:55:20.7862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cqwY3Kb0glhi6EGZIBgaH4yEiOy040as5ZileT23jYJBIRpTVXbysZmriDr/rfsKN1LyDdry4I3Ri9wGCjN5ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: file_attr05: skip ntfs filesystem
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
From: Matt Ochs via ltp <ltp@lists.linux.it>
Reply-To: Matt Ochs <mochs@nvidia.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwNCg0KPiBPbiBBcHIgOSwgMjAyNiwgYXQgMDI6NTMsIFBldHIgVm9yZWwgPHB2b3Jl
bEBzdXNlLmN6PiB3cm90ZToNCj4gDQo+IEhpIE1hdHRoZXcsDQo+IA0KPj4gTFRQIG1vdW50cyBu
dGZzIHZpYSBudGZzLTNnIChGVVNFKSByYXRoZXIgdGhhbiB0aGUga2VybmVsIG50ZnMzDQo+PiBk
cml2ZXIuIG50ZnMtM2cncyBudGZzX2lvY3RsKCkgcmV0dXJucyBFSU5WQUwgZm9yIGFueSB1bmhh
bmRsZWQNCj4+IGlvY3RsLCBpbmNsdWRpbmcgRlNfSU9DX0ZTU0VUWEFUVFIsIHNvIGZpbGVfc2V0
YXR0cigpIHJldHVybnMNCj4+IEVJTlZBTCBpbnN0ZWFkIG9mIHRoZSBleHBlY3RlZCBFT1BOT1RT
VVBQLg0KPiANCj4+IEFkZCAibnRmcyIgdG8gc2tpcF9maWxlc3lzdGVtcyBmb3IgdGhlIHNhbWUg
cmVhc29uICJmdXNlIiBpcw0KPj4gYWxyZWFkeSBza2lwcGVkLg0KPiANCj4gUmV2aWV3ZWQtYnk6
IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pg0KPiBHb29kIGNhdGNoLCB0aGFua3MhDQoNCkkg
YXBwcmVjaWF0ZSB0aGUgcmV2aWV3IQ0KDQo+IA0KPiBXZSBkaWQgbm90IG5vdGljZSwgYmVjYXVz
ZSB3ZSBoYXZlIG50ZnMzIGJsYWNrbGlzdGVkIGluIG9wZW5TVVNFIFR1bWJsZXdlZWQ6DQo+IA0K
PiBjYXQgL2V0Yy9tb2Rwcm9iZS5kLzYwLWJsYWNrbGlzdF9mcy1udGZzMy5jb25mDQo+ICMgVGhl
IG50ZnMzIGZpbGUgc3lzdGVtIGlzIGJsYWNrbGlzdGVkIGJ5IGRlZmF1bHQgYmVjYXVzZSBpdCBp
c24ndCBhY3RpdmVseQ0KPiAjIHN1cHBvcnRlZCBieSBTVVNFLg0KPiBibGFja2xpc3QgbnRmczMN
Cj4gIyBUaGUgZmlsZXN5c3RlbSBjYW4gYmUgdW4tYmxhY2tsaXN0ZWQgYnkgcnVubmluZyAibW9k
cHJvYmUgbnRmczMiLg0KPiAjIFNlZSBSRUFETUUubWQgaW4gdGhlIHN1c2UtbW9kdWxlLXRvb2xz
IHBhY2thZ2UgZm9yIGRldGFpbHMuDQo+IGluc3RhbGwgbnRmczMgL3Vzci9saWIvbW9kdWxlLWlu
aXQtdG9vbHMvdW5ibGFja2xpc3QgbnRmczM7IC9zYmluL21vZHByb2JlIC0taWdub3JlLWluc3Rh
bGwgbnRmczMNCj4gDQo+IFRoZXJlZm9yZSBpdCB3b3JrczoNCj4gIyAuL2ZpbGVfYXR0cjA1DQo+
IC4uLg0KPiB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6OTg6IFRJTkZPOiBLZXJuZWwgc3VwcG9y
dHMgZXh0Mg0KPiB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6NjM6IFRJTkZPOiBta2ZzLmV4dDIg
ZG9lcyBleGlzdA0KPiB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6OTg6IFRJTkZPOiBLZXJuZWwg
c3VwcG9ydHMgZXh0Mw0KPiB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6NjM6IFRJTkZPOiBta2Zz
LmV4dDMgZG9lcyBleGlzdA0KPiB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6OTg6IFRJTkZPOiBL
ZXJuZWwgc3VwcG9ydHMgZXh0NA0KPiB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6NjM6IFRJTkZP
OiBta2ZzLmV4dDQgZG9lcyBleGlzdA0KPiB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6MTU3OiBU
SU5GTzogU2tpcHBpbmcgeGZzIGFzIHJlcXVlc3RlZCBieSB0aGUgdGVzdA0KPiB0c3Rfc3VwcG9y
dGVkX2ZzX3R5cGVzLmM6OTg6IFRJTkZPOiBLZXJuZWwgc3VwcG9ydHMgYnRyZnMNCj4gdHN0X3N1
cHBvcnRlZF9mc190eXBlcy5jOjYzOiBUSU5GTzogbWtmcy5idHJmcyBkb2VzIGV4aXN0DQo+IHRz
dF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzoxMDY6IFRJTkZPOiBTa2lwcGluZyBiY2FjaGVmcyBiZWNh
dXNlIG9mIEZVU0UgYmxhY2tsaXN0DQo+IHRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzoxNTc6IFRJ
TkZPOiBTa2lwcGluZyB2ZmF0IGFzIHJlcXVlc3RlZCBieSB0aGUgdGVzdA0KPiB0c3Rfc3VwcG9y
dGVkX2ZzX3R5cGVzLmM6OTg6IFRJTkZPOiBLZXJuZWwgc3VwcG9ydHMgZXhmYXQNCj4gdHN0X3N1
cHBvcnRlZF9mc190eXBlcy5jOjYzOiBUSU5GTzogbWtmcy5leGZhdCBkb2VzIGV4aXN0DQo+IHRz
dF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzoxMzM6IFRJTkZPOiBGVVNFIGRvZXMgc3VwcG9ydCBudGZz
DQo+IHRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzo2MzogVElORk86IG1rZnMubnRmcyBkb2VzIGV4
aXN0DQo+IHRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzoxNjU6IFRJTkZPOiBTa2lwcGluZyBGVVNF
IGJhc2VkIG50ZnMgYXMgcmVxdWVzdGVkIGJ5IHRoZSB0ZXN0DQo+IC4uLg0KPiANCj4gQnV0IGlm
IEkgZm9yY2UgbnRmcywgaXQgcmVhbGx5IGZhaWxzIGR1ZSB1c2luZyBudGZzMzoNCj4gIyBMVFBf
Rk9SQ0VfU0lOR0xFX0ZTX1RZUEU9bnRmcyAuL2ZpbGVfYXR0cjA1DQo+IC4uLg0KPiB0c3Rfc3Vw
cG9ydGVkX2ZzX3R5cGVzLmM6MTk5OiBUSU5GTzogV0FSTklORzogZm9yY2UgdGVzdGluZyBvbmx5
IG50ZnMNCj4gdHN0X3Rlc3QuYzoxOTk3OiBUSU5GTzogPT09IFRlc3Rpbmcgb24gbnRmcyA9PT0N
Cj4gdHN0X3Rlc3QuYzoxMjk1OiBUSU5GTzogRm9ybWF0dGluZyAvZGV2L2xvb3AwIHdpdGggbnRm
cyBvcHRzPScnIGV4dHJhIG9wdHM9JycNCj4gVGhlIHBhcnRpdGlvbiBzdGFydCBzZWN0b3Igd2Fz
IG5vdCBzcGVjaWZpZWQgZm9yIC9kZXYvbG9vcDAgYW5kIGl0IGNvdWxkIG5vdCBiZSBvYnRhaW5l
ZCBhdXRvbWF0aWNhbGx5LiAgSXQgaGFzIGJlZW4gc2V0IHRvIDAuDQo+IFRoZSBudW1iZXIgb2Yg
c2VjdG9ycyBwZXIgdHJhY2sgd2FzIG5vdCBzcGVjaWZpZWQgZm9yIC9kZXYvbG9vcDAgYW5kIGl0
IGNvdWxkIG5vdCBiZSBvYnRhaW5lZCBhdXRvbWF0aWNhbGx5LiAgSXQgaGFzIGJlZW4gc2V0IHRv
IDAuDQo+IFRoZSBudW1iZXIgb2YgaGVhZHMgd2FzIG5vdCBzcGVjaWZpZWQgZm9yIC9kZXYvbG9v
cDAgYW5kIGl0IGNvdWxkIG5vdCBiZSBvYnRhaW5lZCBhdXRvbWF0aWNhbGx5LiAgSXQgaGFzIGJl
ZW4gc2V0IHRvIDAuDQo+IFRvIGJvb3QgZnJvbSBhIGRldmljZSwgV2luZG93cyBuZWVkcyB0aGUg
J3BhcnRpdGlvbiBzdGFydCBzZWN0b3InLCB0aGUgJ3NlY3RvcnMgcGVyIHRyYWNrJyBhbmQgdGhl
ICdudW1iZXIgb2YgaGVhZHMnIHRvIGJlIHNldC4NCj4gV2luZG93cyB3aWxsIG5vdCBiZSBhYmxl
IHRvIGJvb3QgZnJvbSB0aGlzIGRldmljZS4NCj4gdHN0X3Rlc3QuYzoxMzA3OiBUSU5GTzogTW91
bnRpbmcgL2Rldi9sb29wMCB0byAvdG1wL0xUUF9maWxXZWdNZDIvbW50cG9pbnQgZnN0eXA9bnRm
cyBmbGFncz0wDQo+IHRzdF90ZXN0LmM6MTMwNzogVElORk86IFRyeWluZyBGVVNFLi4uDQo+IGZp
bGVfYXR0cjA1LmM6MjM6IFRGQUlMOiBmaWxlX3NldGF0dHIoQVRfRkRDV0QsIEZJTEVQQVRILCBh
dHRyX3NldCwgRklMRV9BVFRSX1NJWkVfTEFURVNULCAwKSBleHBlY3RlZCBFT1BOT1RTVVBQOiBF
SU5WQUwgKDIyKQ0KPiANCj4gT3RoZXIgd2F5IGlzIGlmIEkgcmVtb3ZlIGJsYWNrbGlzdCBhbmQg
bWFudWFsbHkgcnVuICdtb2Rwcm9iZSBudGZzMycuDQo+IA0KPj4gU2lnbmVkLW9mZi1ieTogTWF0
dGhldyBSLiBPY2hzIDxtb2Noc0BudmlkaWEuY29tPg0KPj4gLS0tDQo+PiB0ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2ZpbGVfYXR0ci9maWxlX2F0dHIwNS5jIHwgMSArDQo+PiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9maWxlX2F0dHIvZmlsZV9hdHRyMDUuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvZmlsZV9hdHRyL2ZpbGVfYXR0cjA1LmMNCj4+IGluZGV4IDZjMTQ3MWRhMzNlNy4uODVi
NmNhZmM1ZjE3IDEwMDY0NA0KPj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9maWxl
X2F0dHIvZmlsZV9hdHRyMDUuYw0KPj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
aWxlX2F0dHIvZmlsZV9hdHRyMDUuYw0KPj4gQEAgLTQ5LDYgKzQ5LDcgQEAgc3RhdGljIHN0cnVj
dCB0c3RfdGVzdCB0ZXN0ID0gew0KPj4gLnNraXBfZmlsZXN5c3RlbXMgPSAoY29uc3QgY2hhciAq
Y29uc3QgW10pIHsNCj4+ICJ4ZnMiLA0KPj4gImZ1c2UiLCAvKiBFSU5WQUwgaXMgcmFpc2VkIGJl
Zm9yZSBFT1BOT1RTVVBQICovDQo+PiArICJudGZzIiwgLyogbW91bnRlZCB2aWEgbnRmcy0zZyAo
RlVTRSksIHJldHVybnMgRUlOVkFMICovDQo+IEZvciBtZSBpdCdkIHdvcmsgdG8gcmVwbGFjZSAi
ZnVzZSIgd2l0aCAibnRmcyIgKGkuZS4gcmVtb3ZlICJmdXNlIikuDQo+IERvZXMgaXQgd29yayBm
b3IgeW91IGFzIHdlbGwsIG9yIHlvdSBuZWVkIHRvIGhhdmUgYmxhY2tsaXN0ZWQgYm90aD8NCg0K
UmVnYXJkaW5nIHJlcGxhY2luZyAiZnVzZSIgd2l0aCAibnRmcyI6IG9uIFVidW50dSwgbnRmczMg
aXMgYXZhaWxhYmxlDQphcyBhIGtlcm5lbCBtb2R1bGUsIHNvIHRoZSBkZXRlY3Rpb24gcmVwb3J0
cyAiS2VybmVsIHN1cHBvcnRzIG50ZnPigJ0NCmFuZCB0aGUgRlVTRSBza2lwIHBhdGggbmV2ZXIg
ZmlyZXMg4oCUIG1lYW5pbmcgImZ1c2UiIGFsb25lIGRvZXNu4oCZdA0KY2F0Y2ggaXQuIFJlbW92
aW5nICJmdXNlIiB3b3VsZCBhbHNvIGRyb3AgY292ZXJhZ2Ugb2Ygb3RoZXINCkZVU0UtYmFzZWQg
ZmlsZXN5c3RlbXMsIHNvIEknZCBwcmVmZXIgdG8ga2VlcCBib3RoIGVudHJpZXMuDQoNCi1tYXR0
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
