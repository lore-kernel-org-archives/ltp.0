Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0790C77B61
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 03:50:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35C3C3CCBBF
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 05:50:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DB493C30A8
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 05:50:32 +0200 (CEST)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0810010009E7
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 05:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1682567431; x=1714103431;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=JrdpUWk+QL1GxTmYRO9YQQtoUxaTfdTRl7QEig+zF2g=;
 b=aL4hiMVaRdJLMcJVBTqKmIuVtSxhyAe+iOx9cDDT5kcUFlZdh7ZK9G6L
 KHwKg415sy/9YsF2zK85k3a6fDMuNneDfenY+fvyiXlWOg0lUgVQX6JIV
 QUHij+z74Z2j5kAeeZZy5f12aGb1rMZYkg2nuqPFoDy64hMumoAHC+nlM
 hiAz98hFbHHajl+jeXqxSuFYn3QOKePHkKLWdGekEG2ZEOYcll1w4eenF
 GM5+YMeI36GNqWM4bytTqd+8hnM5sWZOcAlfUjFlHVBMxLRYqgFJTpZOA
 bHWroQ3RfWuv+7Ftm8fl3Eax2AYHe0qpICsoJFyDUWxhknXXhTX6u3q3t A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="83599140"
X-IronPort-AV: E=Sophos;i="5.99,230,1677510000"; d="scan'208";a="83599140"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2023 12:50:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0izcP/YIs0lwQgYbCr238iUya98WAEdFEcQ47yqYY7rwoUTQ0rMI5lAUMYxW7mNq4x7NAgYbXjMwqxZaOUTuMGDFv7CDR2v+BBxpPzjY+2qsWDVAKeb0GZ9jqITt39itAEHFDixHVKQAp5Lm0fUxLFUOAh5PRX3FdqOorZLydgG5u+FpEcK2oSd9hVjSC4bnZ5F7uGb9V9SlAfGLi98NCtogzOBFEJ3hakenp+XFsuRrs0j6Ufk6yoTZ8QZDdZeEWR30ku8bTX03r168AfMPdxmfc9a7kgK8qiq7y7U493eMrgCwQcKWZ67Dw8WBOIXXElPMrVvsPX8PwtKM5ly0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrdpUWk+QL1GxTmYRO9YQQtoUxaTfdTRl7QEig+zF2g=;
 b=RhPXzo1PuhAM5QZ2BePYYULMKfhKfgBcqO+aOEGIuCO6Clz83GhWjzBJe015V0bHtSYbpdfeBnsDiLyoR3NOeNr2tNOCXjJ6Y5lPwGTjyIPTUiCm/HiVRVaAAinDmFkPbdzedrdb2kvdJa6/dD0V0/r38qLLu/xuUxdmZj3lO95pLYDTLDlPO9BbL4yKRHpnKi9r3UpbqDVOd6mq5Tl+lRqsG2Ml9GEg4Co/Ux72jIH75s4bgTeVTv241U/YmKvBravjM5fT0G5w8y+B9JMusdv4dui7JI57Wl0jhI1RPLzr92dyhknRKoQzlpidYTQsy53SbSf2baJtwmZz9swMUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYCPR01MB11912.jpnprd01.prod.outlook.com (2603:1096:400:38c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 03:50:25 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 03:50:25 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Eric Biggers <ebiggers@kernel.org>
Thread-Topic: [LTP] [PATCH v4 3/4] syscalls/statx11: Add basic test for
 STATX_DIOALIGN on block device
Thread-Index: AQHZaEpp8gRlocgl2U2Mzd7BL4X3s68+R8KAgABa2wCAAAOZAA==
Date: Thu, 27 Apr 2023 03:50:25 +0000
Message-ID: <ec7f64e2-2645-768f-85d3-63193339de38@fujitsu.com>
References: <20230404215918.GA1893@sol.localdomain>
 <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680759622-8738-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230426221221.GE58528@sol.localdomain>
 <b33d70da-c629-0c4d-3be3-87a0611e5f9d@fujitsu.com>
In-Reply-To: <b33d70da-c629-0c4d-3be3-87a0611e5f9d@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYCPR01MB11912:EE_
x-ms-office365-filtering-correlation-id: 9be58ece-9862-4b01-0559-08db46d28906
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XszlkLhsHxn82/a0a11Un+olJM/N0haPCwJAlXi12lga/8h69LqpOcX+GqjfLq5edasTuGXY4FYGPMzNPQlnAKp6JO0t8f1ZQTNPL88jcR+S/RCllYKbgDhZv2SHRfY3+k5fvQbN/GqqEXyqdRbF9N+DjQTLo7m7hpuznBGTnOMNJi5JApJEtRcABYb4xApfNNg5GJYASOm6zf0Vd8VYF4hG2MNp23ZbrCqTMoL4pWjxbcspmyP7cXjDmc4jCRGEhDVauugCKFZZvfF5Sk1S3a0j24fqKs+SS2+EOFqCDzpAqh2FD/T/W3P70CJrA1m2i5PJ3x6jMeuBMgWK//bsBw7zxgnFBFxVkIbm6M5XF4GAA+651/RO38EiH+NIS2xrNBvwR9rJ6eYbXS5oSbnUd4jk8NYdJSZ7nKVcAEqRUfiOP+f0Sx90Q1Wl+TZi+8JJZivRWKU8hxD5ZZL9tnru2hv05XQ4FNvJgjLxTxLocFrmftilYJJPZpyb2w1yQHmaVJjVht9RMnbdCozgOAKO6hnqPx09U2VgjEbcMq65HA4slf1ZQOhXnmWqF6PmNx5tb5hi7YpjbnXz+T4qK2xZLtrA4HC4E/ZlHaZXXly3/BWz1WHw0bDu/KClCYgSPoc+Ygot+KKGU1IQUyKrxEjBOj6HDFnvSnMe038//PUuhy3EjUphVBt8YrMeqgot/XG2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(1590799018)(451199021)(1580799015)(82960400001)(66946007)(66446008)(64756008)(66476007)(66556008)(76116006)(4326008)(6486002)(6916009)(91956017)(26005)(36756003)(85182001)(31696002)(478600001)(86362001)(186003)(6512007)(6506007)(83380400001)(8936002)(2616005)(122000001)(8676002)(71200400001)(41300700001)(38070700005)(2906002)(316002)(38100700002)(31686004)(5660300002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0w5eENuVHFZdkdxSmF5Mjg3OG5ROFJEMG1TQjlTRy9XdkVsV1hnVVNUQnor?=
 =?utf-8?B?UEJXNlA1RC9MZlhZUjAzQXpuZUM4QXNvOTB6a01ESGRqWDJ1MVNZUDJ5Qzgz?=
 =?utf-8?B?eGcrN3ptZklRSUswK3h3M1YwVUNzTS9hTmJvN3pucENvYkxkK0kySlpUWnAx?=
 =?utf-8?B?TVNRRGo4dzEvY2o3Z3RGUnJ4RENvTjQ3ZXJEZ1RTcHp1Vm1HdGVPNFpIcFJP?=
 =?utf-8?B?RWNMMG9CcEZUOE9iT3Rid0Z1aUlvbzNCV1FtVkYyZjc3MDMwZ0ZxQTlPY1Mx?=
 =?utf-8?B?T3RLZ241TWRndkNnK0ZlQmlmMVBBQ3B4NUs4NTc1YUtuUVB5Z1BHeHFRbkp6?=
 =?utf-8?B?eDNEQ1B0UlJRdGkyTXA2anBwYVB6aHhQY2FmZlFQeTM2SGlnalhseEFJcVVm?=
 =?utf-8?B?eGlTRE9nbDBRQ1VOeWpKaXRCVE4rQkM2R0lEWlhPdlpvMCtuSDVxMGFaYmdr?=
 =?utf-8?B?Q3YzVVdmYWhnVG9UVlErYlN1SmhqTTYyV0hnS0J3em9GcUszWFpsakYwaXdy?=
 =?utf-8?B?OS9YaVJOTHJQakRWbmtDZFhpMFR5NHFnOUpOWXl6M3YrOFZibXg5aFZudnJX?=
 =?utf-8?B?UkdtWHRzUjVxc3ZHQW8xZ2cxY3FyaTlGZVFSUUdGNmdXQmNyZWVUZ05KM1Qv?=
 =?utf-8?B?RXVBakV2S0pEWUZLR1JUR0l3d3pCWWE5NVlxZVcrdG1nNXR6TnloWitPV2ho?=
 =?utf-8?B?VXM4OHJ4UkhlRTZ2ZzhRd1B1Zyt4RC9yeHZ1M0Zxb3FyUGlKTFE5S3NJbWU3?=
 =?utf-8?B?d0RHNXdKam9HcXJoT1BSQ09MbVpJU0dIbUNYSWVvZWpGdGJOZHBLQWVNb01l?=
 =?utf-8?B?dVhRcnIzNXFTdXFVeWVHR0p0U0xuYnVSbkRWdUlMZTluT1hVMVhKeTRHUUJo?=
 =?utf-8?B?N0NkYWJaR0FWdDhpd1B4WStMb01BMUxKRTR0NVAvM3lUYVc2Rnk5dUJkc1Z1?=
 =?utf-8?B?N0NOcm5mUFlGU3RLcHFqbHpGY2hvVkVIbjMwMHVtaHhGSzhYSUlHOWM5YVlI?=
 =?utf-8?B?VWlRUHNBK0VFR2l1VStKMm11S1JkdHg1VkE3RC91alM5UC9VYUdaVXZBNFRD?=
 =?utf-8?B?SExqT1BFaUVyRGpFYndHcmNFQTF3dXoySndpdlJSeUdqeDY5RHJXN0J2MjRo?=
 =?utf-8?B?ZmRXZ3A0Y1BWM0VMTjJraEErNmZEa0dUaTFIcWhoN0wyMnUzaFM1cWMrckQ2?=
 =?utf-8?B?Zklsd3EvTmxaZUxxVFlub3JRRTI2RkE2ZVErMmxwdDlTc2FKR05BQkU4UVdX?=
 =?utf-8?B?VFFJeGxNWTNtZkNYbzhqN21GL3hla2FwVEhQVEFJbDNJRkIwbGl3WmZvTi9G?=
 =?utf-8?B?T0tORTFZRW1pMXY1ZWNIbXBYQ2lMbVBDcm1URWppQmNmUHNPR2hlL1M1WEF1?=
 =?utf-8?B?NG1LQmpIL3kzNVFqZzJyb0txSlRoQlpNaFl4MG01VWdjQisvSjVvd09xMTVt?=
 =?utf-8?B?SFdVVWVkanE5RTZmeFBWRzNzQk9TaXpTa2kzUUZoUGFaeFp5TVFVaEVINzFR?=
 =?utf-8?B?NVFCK1ArMGcwcU90RzJmV3JnWHo4M0VHU1Q4WU4yWVMvelpUbGljSzNNbld3?=
 =?utf-8?B?YVVaeVhhNzZqVU1kU1FKa2Y1ZmpzMWlEUExJQ2hSMTNFOUhZRjNlWUdFUW9Y?=
 =?utf-8?B?WSs0VHQvYnB3OFh6dnYvKzVQZy9TRDFWS1VoM0NsUjRFZFZWV0pycWx2bkF6?=
 =?utf-8?B?OWpoVTBSUFV1WDN6R0RFbndxbGRMZDhJNk5mVzlVM0lDU2c3amdVejAyYVVq?=
 =?utf-8?B?K2xaM0RjczdCVm5RUXl4K2FJT0QveG96NGFWOVAxOExNa3VHZXladElKWk5v?=
 =?utf-8?B?MmlGMXdzcllHWnhrTnd2YmlJb0owVHBnRHU0Mkw2eFo5NllqQ2pnWHA1OVR2?=
 =?utf-8?B?ZGdkNVR0V3V5S2swd3FHbnNpUWVDbHFERW5FNThJZVdIMUpkZ3VrTHRSSUJK?=
 =?utf-8?B?K3plMnVuaHFUc01YY2hlWjk0d1MzS09TOGRlbWJ0SWJOd3pTY0kyUkZRVFZq?=
 =?utf-8?B?QktRMGpsL2E5TUtzcXlGZGV5UDVsWHY3VUw4OHJ6RmFCMGJlaWhhYTBQY05P?=
 =?utf-8?B?eVJmQzE5NkVsdWhkY1ExQlBFbVUwbGNJeGtpSXV2TS9hVnRSMnIrbGFIOEll?=
 =?utf-8?B?NU4wc2x6OWlKUCtVc3FvTTNHdnFKSUIyQWFEMFNsZXkxT21OZ2tJN1FjOE5p?=
 =?utf-8?B?aVE9PQ==?=
Content-ID: <DF6F3B3C6D544748843073C8BFDFDD58@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ohpd2aEwib7fZb0ZvOjr+c2w0SAPCggv7DgDdLqjyGPk9/YUE2lbiLTuynKyixQvd2P+xZK2oVfjzhg5az5OZurLYF9T5OEWP5b6zFGvtqxxMFfehHE3WhOM6KZi3E5o6hKojPM0vrj7GwTsdnXLK/hRpD/ewVyUx0I0IzbDt5Gejey2Hz+Kuc/YBzh9NZfwdtUk8hyV7gkUkcP3qMfmVX3EI7QVujZQ5OeG3uJNdv/Ms+cR8hsPDev4bZp8KAwXdjyHLPMcwwfytDrx1zSsWPEdCqc37ge7LkwN59jyu+kQaG4uTzBMi8D903UXlr54b1IIHcM4J1AWyH+IRURsWrIm1YTMf/rRSRSKQuTSjX8yXzDydbQfjP4MvaGX82H8ugMJXC2syetYFiywyHur3H81FHBNW9/Y3uqJAkFnGeztvyV561siDNkj5YVeu+WKre1ajLUBEe2KxXIkTiWq5yMzXjamLTysRu8HkhlmShMrhUiDHoBJcCIbK9A8YYkKwvKCMYSjISTb4fZXGhPuwlecwuCV8MzZD4DiPRcofDccV1xjNipc6g+vtCT3/NQgZM5bU6TTPPfgtAek4SkM+LovlLijJbGw7qyuTK/gFdyT0pBDuVY8ty0OmjbsewEVSksqZOa/3JUVnRHKkW9Pr5yIZ2TjuE1Ah4rwCwdOmFhXpOcY4Fn4IXcph5jES+CRKQVkPZ7Fi7MjEwvjpEevFPFkO7RieK3w7GxwoERlcza1g90QLZwSDqsGbtHFJbIzcUFlspyuNdlpLoF/7+5aRyoBdqmQYfPojGU5eVtY9Ig=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be58ece-9862-4b01-0559-08db46d28906
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 03:50:25.8902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AzHoy9kjOTKEns6TFTFNztBx68QRjMiafPD+o/1aj9qO4BDHDXUEF6oiPEhgEzkieNqWjFlxFprhsNQlemQHyBmHu+8TvhHiKnmuCCtSuhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11912
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/4] syscalls/statx11: Add basic test for
 STATX_DIOALIGN on block device
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

DQoNCm9uIDIwMjMvMDQvMjcgMTE6MzcsIFlhbmcgWHUgKEZ1aml0c3UpIHdyb3RlOg0KPiANCj4g
DQo+ICAgIDIwMjMvMDQvMjcgNjoxMiwgRXJpYyBCaWdnZXJzIOWGmemBkzoNCj4+IE9uIFRodSwg
QXByIDA2LCAyMDIzIGF0IDAxOjQwOjIxUE0gKzA4MDAsIFlhbmcgWHUgd3JvdGU6DQo+Pj4gK3N0
YXRpYyB2b2lkIHZlcmlmeV9zdGF0eCh2b2lkKQ0KPj4+ICt7DQo+Pj4gKwlzdHJ1Y3Qgc3RhdHgg
YnVmOw0KPj4+ICsNCj4+PiArCW1lbXNldCgmYnVmLCAwLCBzaXplb2YoYnVmKSk7DQo+Pg0KPj4g
SXQgaXMgbm90IG5lY2Vzc2FyeSB0byBtZW1zZXQgc3RydWN0IHN0YXR4IHRvIDAgYmVmb3JlIGNh
bGxpbmcgc3RhdHgoKS4NCj4gDQo+IFdpbGwgcmVtb3ZlLg0KPj4NCj4+PiArI2lmZGVmIEhBVkVf
U1RSVUNUX1NUQVRYX1NUWF9ESU9fTUVNX0FMSUdODQo+Pg0KPj4gQWdhaW4sIHRoaXMgbG9va3Mg
d3JvbmcuICBJZiB0aGUgc3lzdGVtIGhlYWRlcnMgYXJlIG91dGRhdGVkLCB0aGVuIExUUCBzaG91
bGQNCj4+IHVzZSBpdHMgaW4tdHJlZSBoZWFkZXIgaW5zdGVhZC4NCj4gDQo+IEhhdmUgbWVudGlv
biB0aGlzIGluIHRoZSBwcmV2aW91cyBlbWFpbC4gV2UgY2FuIGRpc2N1c3Npb24gdGhpcyBpbiB0
aGF0DQo+IGVtYWlsLg0KPiANCj4+DQo+Pj4gK3N0YXRpYyB2b2lkIHNldHVwKHZvaWQpDQo+Pj4g
K3sNCj4+PiArCWNoYXIgKmRldl9uYW1lOw0KPj4+ICsNCj4+PiArCWRldl9uYW1lID0gYmFzZW5h
bWUoKGNoYXIgKil0c3RfZGV2aWNlLT5kZXYpOw0KPj4NCj4+IFRoaXMgaXMgbW9kaWZ5aW5nIGEg
Y29uc3Qgc3RyaW5nLCB3aGljaCBzZWVtcyBwcm9ibGVtYXRpYy4NCj4gDQo+IFllcywgSSBwbGFu
IHRvICBtb2RpZnkgY29kZSBhcyBiZWxvdzoNCj4gICAgICAgICAgIGNoYXIgZnVsbF9uYW1lWzI1
Nl07DQo+IA0KPiAgICAgICAgICAgc3RyY3B5KGZ1bGxfbmFtZSwgdHN0X2RldmljZS0+ZGV2KTsN
Cj4gICAgICAgICAgIGRldl9uYW1lID0gU0FGRV9CQVNFTkFNRShmdWxsX25hbWUpOw0KPiANCj4+
DQo+Pj4gKwlzcHJpbnRmKHN5c19iZGV2X2xvZ2ljYWxfcGF0aCwgIi9zeXMvYmxvY2svJXMvcXVl
dWUvbG9naWNhbF9ibG9ja19zaXplIiwgZGV2X25hbWUpOw0KPj4+ICsJd2hpbGUgKGFjY2Vzcyhz
eXNfYmRldl9sb2dpY2FsX3BhdGgsIEZfT0spICE9IDApIHsNCj4+PiArCQlkZXZfbmFtZVtzdHJs
ZW4oZGV2X25hbWUpLTFdID0gJ1wwJzsNCj4+PiArCQlzcHJpbnRmKHN5c19iZGV2X2xvZ2ljYWxf
cGF0aCwgIi9zeXMvYmxvY2svJXMvcXVldWUvbG9naWNhbF9ibG9ja19zaXplIiwgZGV2X25hbWUp
Ow0KPj4+ICsJfQ0KPj4NCj4+IFdoYXQgaXMgdGhpcyBjb2RlIGRvaW5nPyAgSXMgaXQgdHJ5aW5n
IHRvIHN0cmlwIG9mZiB0aGUgcGFydGl0aW9uIG51bWJlciBvZiB0aGUNCj4+IGJsb2NrIGRldmlj
ZSBuYW1lPw0KPiANCj4gWWVzLg0KPiANCj4+IElmIHNvLCBpdCBpcyBpbmNvcnJlY3QgYmVjYXVz
ZSBpdCBhc3N1bWVzIHRoZSBwYXJ0aXRpb24NCj4+IG51bWJlciBpcyBvbmx5IDEgZGlnaXQgbG9u
Zywgd2hpY2ggaXMgbm90IGd1YXJhbnRlZWQuDQo+IA0KPiBJIGRvbid0IGFzc3VtZSB0aGUgcGFy
dGl0aW9uIG51bWJlciBpcyBvbmx5IDEgZGlnaXQgbG9uZywgdGhpcyBjb2RlIGhhcw0KPiBhIHdo
aWxlIGNpcmN1bGF0ZS4gQWxzbywgSSB0cnkgdGhlIC9kZXYvdmRiMTEgYW5kIGl0IGFsc28gd29y
a3MuDQo+IA0KPiANCj4+DQo+PiBIb3cgYWJvdXQganVzdCB1c2luZyAvc3lzL2NsYXNzL2Jsb2Nr
LyVzL3F1ZXVlLCB3aGljaCB3b3JrcyBmb3IgcGFydGl0aW9ucz8NCg0KICAvc3lzL2NsYXNzL2Js
b2NrLyVzL3F1ZXVlIGZvciBwYXJ0aXRpb25zIGRvZXMndCBleGlzdC4NCg0KW3Jvb3RAbG9jYWxo
b3N0IHNkYTVdIyBwd2QNCi9zeXMvY2xhc3MvYmxvY2svc2RhNQ0KW3Jvb3RAbG9jYWxob3N0IHNk
YTVdIyBscw0KYWxpZ25tZW50X29mZnNldCAgZGV2ICBkaXNjYXJkX2FsaWdubWVudCAgaG9sZGVy
cyAgaW5mbGlnaHQgIHBhcnRpdGlvbiANCnBvd2VyICBybyAgc2l6ZSAgc3RhcnQgIHN0YXQgIHN1
YnN5c3RlbSAgdHJhY2UgIHVldmVudA0KW3Jvb3RAbG9jYWxob3N0IHNkYTVdIw0KDQpCZXN0IFJl
Z2FyZHMNCllhbmcgWHUNCg0KPiANCj4gSW4gZmFjdCwgL3N5cy9ibG9jayBvciAvc3lzL2NsYXNz
L2Jsb2NrLCB0aGVzZSBmaWxlcyBhcmUgYWxsIGxpbmsgZmlsZXMNCj4gdG8gL3N5cy9kZXZpY2Uv
cGNpLi4uLi4uIHNlZSBiZWxvdzoNCj4gI2NkIC9zeXMvY2xhc3MvYmxvY2sNCj4gW3Jvb3RAbG9j
YWxob3N0IGJsb2NrXSMgbHMgLWwNCj4gdG90YWwgMA0KPiBscnd4cnd4cnd4LiAxIHJvb3Qgcm9v
dCAwIEFwciAyMCAwMDowNyBsb29wMCAtPg0KPiAuLi8uLi9kZXZpY2VzL3ZpcnR1YWwvYmxvY2sv
bG9vcDANCj4gbHJ3eHJ3eHJ3eC4gMSByb290IHJvb3QgMCBBcHIgMjAgMDA6MDcgbG9vcDEgLT4N
Cj4gLi4vLi4vZGV2aWNlcy92aXJ0dWFsL2Jsb2NrL2xvb3AxDQo+IGxyd3hyd3hyd3guIDEgcm9v
dCByb290IDAgQXByIDI3IDA4OjI1IHNkYSAtPg0KPiAuLi8uLi9kZXZpY2VzL3BjaTAwMDA6MDAv
MDAwMDowMDoxZi4yL2F0YTEvaG9zdDAvdGFyZ2V0MDowOjAvMDowOjA6MC9ibG9jay9zZGENCj4g
bHJ3eHJ3eHJ3eC4gMSByb290IHJvb3QgMCBBcHIgMjcgMDg6MjUgc2RhMSAtPg0KPiAuLi8uLi9k
ZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZi4yL2F0YTEvaG9zdDAvdGFyZ2V0MDowOjAvMDow
OjA6MC9ibG9jay9zZGEvc2RhMQ0KPiBscnd4cnd4cnd4LiAxIHJvb3Qgcm9vdCAwIEFwciAyNyAw
ODoyNSBzZGEyIC0+DQo+IC4uLy4uL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFmLjIvYXRh
MS9ob3N0MC90YXJnZXQwOjA6MC8wOjA6MDowL2Jsb2NrL3NkYS9zZGEyDQo+IGxyd3hyd3hyd3gu
IDEgcm9vdCByb290IDAgQXByIDI3IDA4OjI1IHNkYTMgLT4NCj4gLi4vLi4vZGV2aWNlcy9wY2kw
MDAwOjAwLzAwMDA6MDA6MWYuMi9hdGExL2hvc3QwL3RhcmdldDA6MDowLzA6MDowOjAvYmxvY2sv
c2RhL3NkYTMNCj4gbHJ3eHJ3eHJ3eC4gMSByb290IHJvb3QgMCBBcHIgMjcgMDg6MjUgc2RhNCAt
Pg0KPiAuLi8uLi9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZi4yL2F0YTEvaG9zdDAvdGFy
Z2V0MDowOjAvMDowOjA6MC9ibG9jay9zZGEvc2RhNA0KPiBscnd4cnd4cnd4LiAxIHJvb3Qgcm9v
dCAwIEFwciAyNyAwODoyNSBzZGE1IC0+DQo+IC4uLy4uL2RldmljZXMvcGNpMDAwMDowMC8wMDAw
OjAwOjFmLjIvYXRhMS9ob3N0MC90YXJnZXQwOjA6MC8wOjA6MDowL2Jsb2NrL3NkYS9zZGE1DQo+
IGxyd3hyd3hyd3guIDEgcm9vdCByb290IDAgQXByIDI3IDA4OjI1IHNkYTYgLT4NCj4gLi4vLi4v
ZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWYuMi9hdGExL2hvc3QwL3RhcmdldDA6MDowLzA6
MDowOjAvYmxvY2svc2RhL3NkYTYNCj4gbHJ3eHJ3eHJ3eC4gMSByb290IHJvb3QgMCBBcHIgMjcg
MDg6MjUgenJhbTAgLT4NCj4gLi4vLi4vZGV2aWNlcy92aXJ0dWFsL2Jsb2NrL3pyYW0wDQo+IFty
b290QGxvY2FsaG9zdCBibG9ja10jIGNkIC9zeXMvYmxvY2svDQo+IFtyb290QGxvY2FsaG9zdCBi
bG9ja10jIGxzIC1sDQo+IHRvdGFsIDANCj4gbHJ3eHJ3eHJ3eC4gMSByb290IHJvb3QgMCBBcHIg
MjAgMDA6MDMgbG9vcDAgLT4NCj4gLi4vZGV2aWNlcy92aXJ0dWFsL2Jsb2NrL2xvb3AwDQo+IGxy
d3hyd3hyd3guIDEgcm9vdCByb290IDAgQXByIDIwIDAwOjAzIGxvb3AxIC0+DQo+IC4uL2Rldmlj
ZXMvdmlydHVhbC9ibG9jay9sb29wMQ0KPiBscnd4cnd4cnd4LiAxIHJvb3Qgcm9vdCAwIEFwciAy
MCAwMDowMyBzZGEgLT4NCj4gLi4vZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWYuMi9hdGEx
L2hvc3QwL3RhcmdldDA6MDowLzA6MDowOjAvYmxvY2svc2RhDQo+IGxyd3hyd3hyd3guIDEgcm9v
dCByb290IDAgQXByIDIwIDAwOjAzIHpyYW0wIC0+DQo+IC4uL2RldmljZXMvdmlydHVhbC9ibG9j
ay96cmFtMA0KPiBbcm9vdEBsb2NhbGhvc3QgYmxvY2tdIyBwd2QNCj4gDQo+IEJlc3QgUmVnYXJk
cw0KPiBZYW5nIFh1DQo+IA0KPj4NCj4+IC0gRXJpYw0KPiAKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
