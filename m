Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBA3F364CD
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 22:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775775111; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=bITukdjsExvRjSD9FjUuCNYfrnQU9lQM2H2S2mI9nKs=;
 b=YawKZ3yRzG17yhPvVEb12mbccPJTuFrxg2y6dueaCCR8Ij2nShgNSxhf4Jt+n9netr+Vg
 Fv5F75bC10owdyW9BEL0irbdREkGC23rbE8xNR+tCXuMYUrlTfBdfoDRkgzj+TkshOO4qJV
 fqu4Q+bldnmrgsBwimnZDCVqUOpKFUg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DDB63E602F
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 00:51:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC6253E1A21
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 00:51:27 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5A3161000416
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 00:51:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIO2c/ukJ7+5ab8EwdzoLk6ydMDADXE5yIBYKhIK/CAGoEU3ZNMah9tONsmH+dwMAbGn/ZCS3mx14bdqufLvhhK22Kf7cf2T4B9UfErYE55h500MyZ9GxoQ64F9c3Wtj/oNAvh5+Mq0CPuN0DPOQnpAlZ3io8dn8pTUcCX1B2hZkEgo7rJ+a3LvdxumWgpMR9xBVItX4JJ/ZA8K3Yw8QE9BZthnxc8d/1jg4kjQdwBH1HugIBLMVuf6t+zibKlF+crDuIJbubj6XmA+k+nMdB6tAZfDV2M1CsdAiZFCwWXAe536kwTHXhMC7P4u2M8+k9L45MgwgfD/6ofoCIr29bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBgCOVgk6Hy7TgR+ICaeVXVV6vWCxNdZTQwchk+A2/c=;
 b=RRbquE4lBGBxwPIgsMvOrx5eRHMzCyem+dicWyMEYpJ84PHHrOLXB0ZwSi4rBWrD4NoT9btYUutKahNZBjDnowdcs8ly05k+TMzyJ6k9/HCWmiCxF0Ga7HVMqbnIHzwzL26DF41Ea2KFjfYGQo5S6c1i6lW1tKGlAjTtakmvmrH/tG61mXwooVZX7v8/aPVOyYDPet2bZ3L0MXVcN7k8hkX1GgVdOzsWYEqD+6381kikuJAvD8cqKdqRRt13bPZ2S9jkb86PYPc6hBSTDPk6extfMOgTEPWHH0zAphRWFOAfyx3b0nq39FmbHU+NRBJ5b4/epbvIErhFH6RSmIj7sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBgCOVgk6Hy7TgR+ICaeVXVV6vWCxNdZTQwchk+A2/c=;
 b=Xw916UI2sXDYUy8QZxeMTZDaMxay850LvFTSphzderXOD344yxzFkBuqVNLbPi68PqJ0E0tHBnBb82QDhTbB/LIQCXbLP/GJAYIzscFko+6dhflg3N/nIG9VUnwT1aaoJu8yEHhXesBAbrKo25cZb+GZAkqaf2aAtnt1cUcouiz5ISBqVi5NdfC2+GbzfkAq1oxiy+hTMd9mygtdZN4vcP/iHIT58t010kbE/EX+agjWHyHXVQ7CXVVJztp2DyrQ2OzABueCbccpwJl1pWp/xKpM8TNBjSP5qBx66pKBasPNpD6px6TUjvlAyG8YLR+N/q89kDI5G191R8VoWcqvkg==
Received: from DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12)
 by DM4PR12MB6157.namprd12.prod.outlook.com (2603:10b6:8:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 9 Apr
 2026 22:51:20 +0000
Received: from DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591]) by DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591%6]) with mapi id 15.20.9791.032; Thu, 9 Apr 2026
 22:51:20 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls: file_attr05: skip ntfs filesystem
Thread-Index: AQHcx39M5lxVQj5BUk6C0HklgVevaLXWZoqAgADxLgA=
Date: Thu, 9 Apr 2026 22:51:20 +0000
Message-ID: <30B73CA1-6AD3-4926-9E73-3FF5423F34A0@nvidia.com>
References: <20260408174406.1572520-1-mochs@nvidia.com>
 <addjDV_wbPgD0y8e@yuki.lan>
In-Reply-To: <addjDV_wbPgD0y8e@yuki.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8442:EE_|DM4PR12MB6157:EE_
x-ms-office365-filtering-correlation-id: f8160346-ea96-4474-a542-08de968a8470
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 64AQdibteZm/JBmcAfrfnlxVrn/tAZ13OCyj02q94xuc1NYbbEqaf9gVrmfEQ/tM+qSwAIfuHWozPwWGWTbx10mVh0y9Xy+E/qOi/OCV9HAKbDBMRI6e1EPzLfYrKDWGV0vNDZgl5LbxMv4VlWMDZVm9R15eoBALi+MZ65h5EayOpcEl/ZSydXUcxqw47SOk6l/5a8Pjk8ZrEeZ9zBXwoyTO16clhxHqYHOwDyVZO3ojPfpqTia8B7S603llmHqyw5flD9kaiqbh2KqnbEQ8yDHC5/iN86DmyS4o78ktM6xJPofDFBXeU9EaU86HYwfTxMMYZ5u9Y5EjKo19QJvFbrQHwxsf+IpmOIGXhYK8Hiscj/QSx1NqCKuzGCBngot6Jm1QycAKme5NmKRBNemmwcZs5IXrLSWYIdOvQOZ39QGmQC6wzPsZq1+ccaRL2IijxB5poXW9is+vfDebmbmYp2IIs53kTHPQsKdoYuWH6Zm7zsU/hvkFDJhnisBH4dopEgJ3RjpIhD6j8Uq7J0dDaOQT/rMvffvetBNvnf2JZ/wUyRwkWASTFAU6TTMbr3f607VFKIm4L19ODCF+pIKKQxGT+QdtXZ5HmgNHptmGvbShaw6m0Z6hUS4RARvZ95t1ChcQIqcS+WrDQS3WTV8ne6BxXj48r7/9dcgV57AYBRwdlSJYT4QoZWMRqK7VIdvaeR5i5hu7FclRPBccKA6i2sTv39Su4oQy1GhlURRnCVonl8F3lBc1h/pwBuhwPjBDG64ySne/HqEbaO8gjopg2Cf72xcMWA93OcKtSXYduxc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3ZENzVLMnVxWmtYVEFGQ1Q5NGxEWDlUNmxCa2o0UzJ3Q2tjYU4yNUF6RnUv?=
 =?utf-8?B?N0ZsYlNZYjZ6TGFyZjRCdkh0WWZZdG9TdkpDVE8yNzNXUGZNZzlxL3RWMVl2?=
 =?utf-8?B?RTRObE05UHE5SGQwVVNFNUNXT2pvMXRiRXlCdUNMcDUzV2lXUnU5cmN3Y2lP?=
 =?utf-8?B?aHlvTEptM1o0Z0JDQTRpSGNEUm9zV3EzZi95TnFVdmZ6eUJyTDIzcjFaMm5s?=
 =?utf-8?B?bUlCVVZSUzZxeW02T3BYY2ZtdFY5QVl5WGtSYW9OWVYxSnA4WnU2NDJiaUJr?=
 =?utf-8?B?bk9zWFo1cGNadXg2c2tweUcwV0I2RU0vbUxPMkRPdnd0cmwzOFppSWkvblpX?=
 =?utf-8?B?TUlNbVV0NjZlYWpVdElTZEEzYmRIclV5cjl3VTBMU3gyN1NUYTR1ZzFIUFNQ?=
 =?utf-8?B?L3B1NjlGZ3kyektuNHBRQ3BPeDZxempjRVloS09CTTVmcGJZelN2aUNmTlVV?=
 =?utf-8?B?SXlvelJtWVFSZjMxeTluYktnRDhDaGpiQzlmUVpWVnZZSTdYNmsvM0M3NEtG?=
 =?utf-8?B?emdVbHZRekg0S1l0Z1dDSi9HTFNReUcycXQxL3dOSzNYUlRKREtCc0tFelJL?=
 =?utf-8?B?OENpcXpJSVRZUE5OY3ozcFhVbjJPY3NDSzhEamxETitSRE1JV2FTUHpNemRh?=
 =?utf-8?B?NC9nTUh0SGdYQ2gvcGlWKytCVEJqY3pFWWV5Q3Vub3FVandDOThqekIrUGFR?=
 =?utf-8?B?cmNlZjE5QUJTWmUySzdLdmdlRzBBZUU3ZzdENG1uaE8zaUVKRCt5eEZIUGQ4?=
 =?utf-8?B?SXdyNHUwRnFhTG9UaW5QV092MGF1ekJzMGZOZ0k2M00rMXdWS2poSnU2cU1z?=
 =?utf-8?B?RFlVZjhmZTJqclprLzkvVVJZWi9wRWJvbGRJMERlUDB6bjJMc0NRZUlOOGts?=
 =?utf-8?B?dC9tMVV1Njhoc0pyRkgrRjdRT1pQYXRIY3VMdytvaTRWMTNvaWV5Y0RZdExJ?=
 =?utf-8?B?ZGJlRGNobGV2M0pWNnBaZkFaZnhwWXNLRlg0MjlOYzJFUWlOWTB0Y2ZINUVG?=
 =?utf-8?B?VmtmWmtMNTNFNXNpbVZTVW5zY0hyZXl3NFRyZWpMZkZEdzdHSXpLeGF2NDFP?=
 =?utf-8?B?NHFYclJCc3VFbFVkYWZyeHNTU3FUemNNMWxlemN0VW5qb05JYU1qSjFCdW1Q?=
 =?utf-8?B?S3FwUlI5ZDBHcUR3V28yVUZ2QjZleThkbk1VRG1ENmM5Tm1uemVjY2YxWlQ4?=
 =?utf-8?B?WDNVUXVDSFhWbm9TSTlObE9Zc1ptcWZseG9GczMzam9jYlg3THhaeGtabEls?=
 =?utf-8?B?YjRiWDN2KzZDaE5IMzgwazNveFJtV1pYd2lpczNZaXk4TXl5SE5pNWZqdzFF?=
 =?utf-8?B?QVMwYUtsenh2KzNRZm1mSHFqTVAxOWd5Slc3clhybkFBbFFSek84V1dHUWs3?=
 =?utf-8?B?c3lMbHNla0YwMjlFNUZqUHZTQ3dOZkIzVXQxRnZCTU9yUmtGd28yVTBPVGtK?=
 =?utf-8?B?M0NKMndaMGlQdmY5bm9jQVpKbTJXSFUyNGEwUTJCVXZaZFNxUU5HcEZLNllW?=
 =?utf-8?B?Z09KTXI4MUtYWlNPQXlJclE5Ym4wME5KeENoK2ZRTUtycVVmR05Zbk5YWm85?=
 =?utf-8?B?R3ZybTRPSmtvbHk0dlVWTzkzdzhFQ1lGZnNQZ0pyWnZPTHA1SGd1aGZQbGto?=
 =?utf-8?B?NWJLZ3dvOTdBTmJpMXd3OWliRjRPTDZCS3FIT1FybWRVTXJYemhSWWVlY3pD?=
 =?utf-8?B?YVpUV28xVklCTFZzaXFpK1pkQk1Ib1I1Ylp2VWI3a0dKSlMzajJDUzRNQkRi?=
 =?utf-8?B?VDVHN3MyQTRtQzlkUkt1Njh2Zkx2cHlhbUtTdFVWUC9WVUhpSzRQWlFLaWt2?=
 =?utf-8?B?bzFVQWNqcUxoREhXM0k1Um1sVlFlK1YxV1hDb3N4KzAvajZxbkp5Y0hld3J4?=
 =?utf-8?B?WGhjS1FVWmlQSkVpbzZlZFhwWER1RzRoQ1hIN3pIbXJXQkp6WDZCNmQ2dDhQ?=
 =?utf-8?B?ZjgvUi91ZWc1SUtvZjJ3aVkvU1M4OE16SDFEUXNNL2wxMHBhUG1PbFBpMkd3?=
 =?utf-8?B?NFNwYzRheDB3VXZYQVJoMVI0R2wyOFkyMDRkcVhQRlE2NSsxV1VVZzUyRXpR?=
 =?utf-8?B?M09RdUlVZUlQazhBUnlFN2dJOXN2bkVRR1NGVmNtaUFheVNjeVcxNnFQc3Ru?=
 =?utf-8?B?K3R4Nk1TU2FMQjJJN3pPM2pBeThPWWtlS2VaaXNhNlZaYlVUOHUwSVpDUnda?=
 =?utf-8?B?WmtIV1ljMXNGZnRGNjNuV1lCSEV6Y3ZYYTljaFZqUk91aUZDMjJYSHpDUStJ?=
 =?utf-8?B?bGpZMTFNdm9mWjBJc0JRUVF0Y3hKcDBKVWExdTVuYWlBeWlKcjNoblpXckF4?=
 =?utf-8?B?dlBoOUw0T0N6emlDRUZvQWVBQS9rak9YY1VLZTVseUlPN2o5eDhHZz09?=
Content-ID: <163E04F3A73BC24FB8ADA4560943AF2B@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8160346-ea96-4474-a542-08de968a8470
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 22:51:20.4735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGmFSOlGJVhqB9S6t8o/mfQ8Wxx96EnB7xih2zldXJhRjluqiCkT4S8cvysZlcOd1xaBX7luehoHRNU8wlpdQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6157
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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

SGkgQ3lyaWwsIA0KDQo+IE9uIEFwciA5LCAyMDI2LCBhdCAwMzoyNywgQ3lyaWwgSHJ1YmlzIDxj
aHJ1YmlzQHN1c2UuY3o+IHdyb3RlOg0KPiANCj4gSGkhDQo+PiBMVFAgbW91bnRzIG50ZnMgdmlh
IG50ZnMtM2cgKEZVU0UpIHJhdGhlciB0aGFuIHRoZSBrZXJuZWwgbnRmczMNCj4+IGRyaXZlci4g
bnRmcy0zZydzIG50ZnNfaW9jdGwoKSByZXR1cm5zIEVJTlZBTCBmb3IgYW55IHVuaGFuZGxlZA0K
Pj4gaW9jdGwsIGluY2x1ZGluZyBGU19JT0NfRlNTRVRYQVRUUiwgc28gZmlsZV9zZXRhdHRyKCkg
cmV0dXJucw0KPj4gRUlOVkFMIGluc3RlYWQgb2YgdGhlIGV4cGVjdGVkIEVPUE5PVFNVUFAuDQo+
PiANCj4+IEFkZCAibnRmcyIgdG8gc2tpcF9maWxlc3lzdGVtcyBmb3IgdGhlIHNhbWUgcmVhc29u
ICJmdXNlIiBpcw0KPj4gYWxyZWFkeSBza2lwcGVkLg0KPiANCj4gVGhlICJmdXNlIiBpbiBza2lw
bGlzdCBzaG91bGQgbWF0Y2ggYWxsIGZ1c2UgYmFzZWQgZmlsZXN5c3RlbXMuIFdlIHBhc3MNCj4g
dGhlIHNraXBfZmlsZXN5c3RlbXMgcG9pbnRlciB0byB0c3RfZ2V0X3N1cHBvcnRlZF9mc190eXBl
cygpIGluDQo+IGxpYi90c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmMuIElmICJmdXNlIiBpcyBwcmVz
ZW50IHRoZXJlIHdlIGVuYWJsZQ0KPiBza2lwX2Z1c2UgZmxhZyBuYWQgcGFzcyBpdCB0byBmc19j
b3VsZF9iZV91c2VkKCkgZnVuY3Rpb24uIEluIHRoZQ0KPiBmc19jb3VsZF9iZV91c2VkKCkgd2Ug
Y2hlY2sgaWYgZmlsZXN5c3RlbSBpcyBpbXBsZW1lbnRlZCBieSBmdXNlIGFuZA0KPiB0aGVuIHNr
aXAgaXQgYWNjb3JkaW5nbHkuDQo+IA0KPiBXaGVuIEkgcnVuIHRoZSB0ZXN0IEkgc2VlOg0KPiAN
Cj4gLi4uDQo+IHRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzoxNjU6IFRJTkZPOiBTa2lwcGluZyBG
VVNFIGJhc2VkIG50ZnMgYXMgcmVxdWVzdGVkIGJ5IHRoZSB0ZXN0DQo+IC4uLg0KPiANCj4gU28g
bGlrZWx5IHNvbWV0aGluZyBlbHNlIGlzIGF0IHBsYXkgaGVyZS4gQXJlIHlvdSBzdXJlIHlvdSBh
cmUgZGVhbGluZw0KPiB3aXRoIGEgZnVzZSBiYXNlZCBudGZzIG9yIHdpdGggdGhlIGtlcm5lbCBi
YXNlZCBpbXBsZW1lbnRhdGlvbj8NCj4gDQoNCk9uIFVidW50dSwgbnRmczMgaXMgYXZhaWxhYmxl
IGFzIGEga2VybmVsIG1vZHVsZSwgc28gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCmhhc19rZXJuZWxfc3VwcG9ydCgpIGlu
IHRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYyBwcm9iZXMgdGhlIGtlcm5lbA0KbW91bnQsIHN1Y2Nl
ZWRzLCBhbmQgcmV0dXJucyBUU1RfRlNfS0VSTkVMIGltbWVkaWF0ZWx5IOKAlCBuZXZlciAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQpyZWFj
aGluZyB0aGUgRlVTRSBkZXRlY3Rpb24gcGF0aC4gQXMgYSByZXN1bHQsIHRoZSBleGlzdGluZyAi
ZnVzZSINCnNraXAgZG9lc24ndCBmaXJlIGV2ZW4gdGhvdWdoIHNhZmVfbWFjcm9zIGFsd2F5cyBt
b3VudHMgbnRmcyB2aWENCkZVU0UgYW55d2F5LiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICANCiAgIA0KSSBpbnZlc3RpZ2F0ZWQgZml4aW5nIHRoaXMgaW4g
dGhlIGxpYnJhcnkgYnkgY29uc3VsdGluZyBwb3NzaWJseV9mdXNlKCkgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KaW4gaGFzX2tlcm5lbF9zdXBwb3J0KCkg
dG8gZmFsbCB0aHJvdWdoIHRvIEZVU0UgZGV0ZWN0aW9uIHdoZW4NCnNhZmVfbWFjcm9zIHdvdWxk
IHVzZSBGVVNFIHJlZ2FyZGxlc3MuIEhvd2V2ZXIsIHBvc3NpYmx5X2Z1c2UoKSBjb3ZlcnMNCmJv
dGggIm50ZnMiIGFuZCAiZXhmYXQiLCBidXQgc2FmZV9tYWNyb3MgdHJlYXRzIHRoZW0gZGlmZmVy
ZW50bHkg4oCUICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIA0KbnRmcyBhbHdheXMgdXNlcyBGVVNFLCB3aGlsZSBleGZhdCB0cmllcyB0aGUga2VybmVs
IGRyaXZlciBmaXJzdCBhbmQNCmZhbGxzIGJhY2sgdG8gRlVTRSBvbmx5IG9uIGZhaWx1cmUuIFRo
ZSBmaXggd291bGQgaW5jb3JyZWN0bHkgbWFyayAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICANCmV4ZmF0IGFzIEZVU0UtYmFzZWQgb24gc3lzdGVtcyB3
aXRoIGtlcm5lbCBleGZhdCBzdXBwb3J0LCBjYXVzaW5nICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCnNwdXJpb3VzIHNraXBzIGluIHRlc3RzIHRo
YXQgc2tpcCAiZnVzZSIuDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICANCkdpdmVuIHRoYXQsIEkgdGhpbmsgdGhlIHRlc3QtbGV2
ZWwgZml4IGlzIGFwcHJvcHJpYXRlIGhlcmUuIG50ZnMtM2cgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCnJldHVybnMgRUlOVkFMIGZvciBhbnkgdW5o
YW5kbGVkIGlvY3RsLCBzbyBza2lwcGluZyBudGZzIGluIGZpbGVfYXR0cjA1DQppcyBjb3JyZWN0
IGFuZCBjb25zaXN0ZW50IHdpdGggaG93ICJmdXNlIiBpcyBhbHJlYWR5IGhhbmRsZWQgaW4gdGhl
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQpzYW1l
IHNraXAgbGlzdC4NCg0KDQotbWF0dAoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
