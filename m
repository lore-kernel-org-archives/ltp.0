Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AD2C7EE2A
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 06:25:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB4073CD3FB
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 08:25:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A18263CB262
 for <ltp@lists.linux.it>; Fri, 19 May 2023 08:24:56 +0200 (CEST)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E7BFB200B28
 for <ltp@lists.linux.it>; Fri, 19 May 2023 08:24:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1684477496; x=1716013496;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=OuyeSXTzCs7M5vax4n0Dno2adrMECdZ+dzUehatHdM4=;
 b=ju9Y9z35QgqhacyK/QRyHar6Cxzl/l6g1UU18Mkse4csdt2SoIV8jw8f
 3K9lft5XEdowvSFdoLTnAPaet5Du3GJOKSwG94IeUBGmvLFO2SAE7XHCi
 jrhnpco/KW2JrvK8qJIYhiN+XrQUZykexeuPZYedbQ0VnSXjhH+n9cKMa
 eA7Iy5AObYpW2Wv/HEUZ26Bbuc3SA+eJEr/8Y9ac22QVB/Egf4iMc50I7
 agynkUD97rycc/RTuU/c1lH8uaXCfWFS0o+n6jfwWpyWlbrgd3DhHlyUM
 z2bUg1URbFWTmOv31UWYmjygBzkE60q4dxNuG5n/BS4ngTc6T7CLiI1+F Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="92562434"
X-IronPort-AV: E=Sophos;i="5.98,274,1673881200"; d="scan'208";a="92562434"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2023 15:24:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2gj37MI2MJLighBThocvKpiuZI/StcNjZJMQKG17/DXMdt6W/SuxxT3usS8bqsKFLVuN1DWmMVixrk65IA8GthPJE+xkJR7B/sx5UHq5xcPUmGGAqAE81jnn6rAivdkwPSNpxVMIM6v+JapbK2Zv+lPIvJBTi0m12i/Jf/7JKhkm3K5z9InX1EvicTh9kzzjZlLS9+YpXsSHh0y05cUh1ljnWU585w2qVvV/ZGwFACbSQO2LAOK3axhCzmnAE8gsGxEZ0HDgLodxV9HwhrvIYN7RzqKV279HfsOPw+y8bGKLTCTswf23no7XnKwg+lgkLOoIgcbmH9lI+kl++rB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuyeSXTzCs7M5vax4n0Dno2adrMECdZ+dzUehatHdM4=;
 b=KlrAPcIqhnb8sj18nRD4jolsXIisgZ9NU2fRZDMFsv2An4hu5WRCHCFjmrv1VnXELXF4Dcf+1z1K0zTDR75mKmYiPkDDRSpTnT6ZDdGM+kagtNo2Db+18SNQ+cV1E8lvCNZBj9VbW1jEyebqPT6l1pvhxLgRyLfh19IMBtuV7yxt6fkSJ2KBARaIzigO9Nf+ndLHRQ1q8Jej3Jij/1gP5bkMIiZO6XG0Q/aPl25Sr4t/a4RebQYgFArMI1hJluX2Sy2g/zw92UESTpSpoP7hd8VsDkk1stmKyR7u+MPEQJ1kDJqeN5jBkI6yNreqme1ZzPpOzJYaEN4nYSouQ+Sw6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYCPR01MB5919.jpnprd01.prod.outlook.com (2603:1096:400:43::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 06:24:51 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::a883:7aee:71d:b4a1]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::a883:7aee:71d:b4a1%3]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 06:24:51 +0000
From: "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v6 6/6] syscalls/statx11: Add basic test for
 STATX_DIOALIGN on block device
Thread-Index: AQHZhvyp18Xs8bgcL0e+dr+w1JkTU69hJ0CA
Date: Fri, 19 May 2023 06:24:51 +0000
Message-ID: <c90e3176-0b2c-f5d8-5314-984123d40029@fujitsu.com>
References: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1684134680-6190-6-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1684134680-6190-6-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|TYCPR01MB5919:EE_
x-ms-office365-filtering-correlation-id: 34166ddf-8b11-4694-04bf-08db5831c0a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kHn6oe0MRgXW0MVkp7Evd+T34s0oVnBHunoSZ2pYwMW1Rza/vxLxT+plWEF99uTXMyAA06k6o9zUSAWrhQVxcmuHy1OwKx7XQzpWNPGv1uLS0t4DOjFlJLorErEzdy2eNsZ/M6vskzOzAJQ4lSVoBVGbEbvYEJGGg1zygZjGkubdmu0wWa9WLx3617cByB593lSp0SyM1XdiHUxfFnKpP1WXGpPgNFFiKC5OOtZnCMsuRp1m5XGAOjs5dtXu0Jgts5btXRQRjuTs/Uj5c94PWcgBtMmHJmk9d/qpRdS20VNjmwTkpERjMGEZ7yCcbuxvF9URARgJD2ly8QEv7+gi5lt11aE7z8rZ7+tKg5v8Qx5uq7+SkztBJy20m+roEYhKAUiGZKAEMgNUYh8TZuFVB04sJO/XM1AxMv/7FNi69rNKQMGhYSf9DIBgUjE5DuojvyhWKR2m+/nxNBdAwHsX3jnRehqR5rZX/mxZeNkj5yG0pCNUunKuFt7qQBknv/UIm2LSddXaDf+BMnc7nwZRYtBeYtQBQtOzw6D7KgZknSaF8towQ9zfUsK41nBegaf7nqbfbYbzNgwhfvNuCxxVJ02UyT+CvmrUmmrWeOJX/YWmj31CLS1ChBxh3B81Tg6RX3J7XDzSZ8xAY/p4z0wrbRPZklNc1jilSqI+61U2MaC/cmqnx7SnD3bevLXicGZ8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB9499.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199021)(1590799018)(66556008)(64756008)(66446008)(2906002)(66476007)(8676002)(31686004)(8936002)(316002)(76116006)(66946007)(91956017)(1580799015)(5660300002)(41300700001)(86362001)(2616005)(110136005)(478600001)(36756003)(6486002)(85182001)(6506007)(186003)(26005)(71200400001)(53546011)(6512007)(31696002)(83380400001)(38070700005)(122000001)(82960400001)(38100700002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXdPSkU4amxMVFZMWFF3ZWxhUVpUOGNPdWUzc2h4eVRpclEySkxRdFpLd1JO?=
 =?utf-8?B?UTJBeEJ4UUswNmVmRmZNdW1rNTR5djk2OFY4bWxKMi85em9OWll6aS9rNWd0?=
 =?utf-8?B?K3ZPK3lYekJFVm5qYXZsaTJwSWxRY2JBZy82MnZybXBIbW1leG5KcTVFVXRu?=
 =?utf-8?B?T2EvWW4rQmp2c3dVS05keEVhWUpHcTBHUkMrQ2hZSlJ0UEN4cFljOUdDSEZk?=
 =?utf-8?B?cFUrZHF2VkxGK3FOL2EyRldabDNNU1REUE9SanpZcnhDMisvL1FrMkdGNi9l?=
 =?utf-8?B?TmlRN01qY0NpNVg4UDU4aHJBQnJjSVpna2w2MUtibGtNbVR0azBCQ000TGc2?=
 =?utf-8?B?SVBPdWZ3S2xWcmhWQ2tJVDl3d1N1cmhNMUY4Zi8vdGVqY0hPeUg1L1NhdkJP?=
 =?utf-8?B?Um5mbmtUb0w5d1AxTlB0d21mamc3bkQzbFQwMEVMMnlySVQ2aFgwTDNyNCtz?=
 =?utf-8?B?eXdSQ3BKOE5pUUNERWpwdWo2QXBOazJZblcrWjk5OXhxNHh6alNOMHZWajRZ?=
 =?utf-8?B?djFJYmtwSUtScEJod1I1M0xGRWRFTTdrTnlBeVZUTXJEVmFTblorN3ErTUNx?=
 =?utf-8?B?d1hCWXQ3emhZdWNiak5EdWxIcjJIbnlCaktHZlNYOFFUNHBYTVBGS0RuNEly?=
 =?utf-8?B?MWhKR0tKWlpNVktsUlFpSmN1MmFBMERzWmZhdnUwcEZBSjVrK2xPK2oxL1pr?=
 =?utf-8?B?Z1E0bWltZzh6UlpCNnFDZGJ0N0UyN3RZSytscVp3aFI1MGNPeHdrREJEaTNm?=
 =?utf-8?B?RWY2Wk5VQXFoanJ4Z2EzOGxOSktMaUIxeEoyRjZLSm4vUEwzendCUjFMODJs?=
 =?utf-8?B?aGN0TFRZbmRkTVl4WlY5RUg1WWMvUVJiU21DQ3E3dDVBcm94Nkh4TVNjWm9Y?=
 =?utf-8?B?S1F4R3Q1T1pmZitNem5YazdkSUFLb044WUNyWmpwanN5MVZOS0ZudHBmaW9z?=
 =?utf-8?B?d2dhTjNQSENNYStNNlorQWtlUklPM0Q3SmlrYm4wZHRHdWNzbjk4TTl1OFlY?=
 =?utf-8?B?RFNEZWtUclFUR3pGS1NURis4SUgveXFuQ1V6dXhKd0E1alhVUTN3MFZodVlt?=
 =?utf-8?B?aVR3aW5LaHhyMFlSOXV2eEszUko0M3R2Vk9HTzFGVXB3Qm1rM002SGgvaGlG?=
 =?utf-8?B?Yk03a3E2NmZRdnI5YlpSdXpvcFFXbmhqcDFsRVBlNmJFTXN6dml5SFZuNUdC?=
 =?utf-8?B?VEV0UDNZU2tlT1l6ZVJGR2VuQll0N2pGOVJJR1hUaXlyMHpHQkdFanducFpI?=
 =?utf-8?B?am9KTFFHVVpVT0lGYXRHUi9BeFdOSmRhZng5Y2tUd1ZIRS8rMUQrbDVjeXE2?=
 =?utf-8?B?TzB6QUlZa0w1QkVqcVFLTFp6VzVPbGFubzIrTExpdGJiWStlVWRtRWtKbldG?=
 =?utf-8?B?YXJEWStpVFpyaVNjYXNka1lqcVNhZ3VxMEovQzNkSXZYZEswamI3bk1Uc2xn?=
 =?utf-8?B?S1dMSUpUSUdXRFdnbXQxbFBYaDliaGJOa1dFWUhqRElVSGNWRDY3ZVJZaW5W?=
 =?utf-8?B?TWs3empqT291anAyclZzUkQ4S1pDalJwZURUTDJ6ZVFSVlNqdXdxSS9Qc3Rs?=
 =?utf-8?B?RGtWSFM5eERkWUI1bUwySFhBSmdMRGFjdFF2SjZiWHVEWXdWUkZNYzl0NnJx?=
 =?utf-8?B?NEk4UU93TmNxKzBJT1p1cDhDTkIvc05ERjNqTnVMOXVDUzV3SHlrWlJTb2tE?=
 =?utf-8?B?RE9iNmtqNXprMmtJQldPOVNPeFpmcGNPNFgzTVlJOFFSQ2Vqem5JL3BxVUlx?=
 =?utf-8?B?cElNRUloNng3dms3RHZ4SEpTUWRDOEE0eVZLcTJmeEVrNlVwb3ArOXRvNUdi?=
 =?utf-8?B?UnhSSGcxdFhsd09iMmR6QmJ3VlZuL0FWMyt3bjF5NFVtNDQ0Ujl3WWRJYkY4?=
 =?utf-8?B?dGZWWkhNNVNiTmF3Y0Zjb0gxODRkb2pDN1Qva2dNTW1qdlhDMFg2QldyTHkx?=
 =?utf-8?B?NnlmMjJoM3NjbHRXMWpXRjhkcllCUDVzNnNGUjZRVHZZSVVhcmpDaTViVlJB?=
 =?utf-8?B?RDlmSjBwRXg2bjliWW1Sd0UvbjZ6T1N2VXBZUjVadXlzMGQvcHJQR01SSjlY?=
 =?utf-8?B?ZHQrdWd1bzU0YkdxNXRKSHZZQ3pNckFDdUhic3pQcEZ0b0ViMEhWaTdSZ0tt?=
 =?utf-8?B?UWxaWEduY2ZtT2cxQU9aVWFXVUdsMDRkK0Z6REdYcG91OHJyS001eElqOXQw?=
 =?utf-8?B?VEE9PQ==?=
Content-ID: <0AAE69A588FC03498EDDB0C0774C6D7C@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PYPLgnjqc7lOjQeeOo7f1GjgpVjKtOrQtbGUbD0PImnIfSmAoMfPmgiLz4vZvD6CpLWcGxaIbZMdSmuHrnJtg9PYm0n4buS7nJZTZVhV0Ijt51bilfMe+Tyu7w2jreYCgMe1Yf7ziqkcPBMF+k5gRVcxjtYctuOscJmzhx83CdwAV48W23Pec6lqQWF9aQfigPDordEOkJVfJAtJ9IPdvG85RxF5lWGiLMj+S9U9G6l5zqX3MCys8LQUGS8SRUNpj7tDg0uuSdQkJOykwrcdnpxQqupLtdLlp62W9enUvj7RFIvm89chDKQSDM6v5xdyNyjLb+Qt7asY0/ER5NrIQOEtMJ4//61h/gDp/gakX5H2VOzWJ6ub6scvM8qzaECCIw71k1Z9W8hi1rPJffNJK6ajegaSrHhWFPqMK5ySWcPXtTwgoWiKl0/6MQkmxgNeDrkwqIJO9rDsNn515th1qeTtOw/IeOJVgxWXbq3zLDeLcKWfi1H4uRYYYWdE6ZjDqBplYvyaYuLXS/x9qnsqyIDjebeAs96zh5fJ4mco5gWzAsapJesjbvaSHwHw5wGNoAGPx9q5ZD26AE4iTZvrNF+Jt2o2B6PQUVo4nsOGwB2ug00hR9NrAT452M7CPq55be9zawnES5n+7iJWbln/1aydDmT9nhVPkAQVo3jqZWBNgevj9tfl+MKniCUVSkeSQLnpcDcecDAjnf1Cu6Ji5M/RbGUc8Glt1Fpei/wo3nlBmKQ8mMiok2ibh4V29IQsN2kCo0vbpGZ1DYDlGbhUBg==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34166ddf-8b11-4694-04bf-08db5831c0a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 06:24:51.0947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmC9NySqvwrSJtaDGN3MoG5Gu25rMcdi2kZerWXhqoVB3m5ITrGpS0HEr9HghmNi32QyMDtdPeT51HJtEGJ/gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5919
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 6/6] syscalls/statx11: Add basic test for
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu

LGTM.
Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>

Best Regards,
Xiao Yang

On 2023/5/15 15:11, Yang Xu wrote:
> Since STATX_DIOLAIGN is only supported on regular file and block device,
> so this case is used to test the latter.
> 
> This test is tightly coupled to the kernel's current DIO restrictions on block
> devices.  These changed in v6.0, and they are subject to further change in the
> future.
> 
> It is fine for now because STATX_DIOALIGN is only in v6.1 and later
> anyway.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   runtest/syscalls                           |  1 +
>   testcases/kernel/syscalls/statx/.gitignore |  1 +
>   testcases/kernel/syscalls/statx/statx11.c  | 89 ++++++++++++++++++++++
>   3 files changed, 91 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/statx/statx11.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index e2548dae5..e5ad2c2f9 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1766,6 +1766,7 @@ statx07 statx07
>   statx08 statx08
>   statx09 statx09
>   statx10 statx10
> +statx11 statx11
>   
>   membarrier01 membarrier01
>   
> diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
> index 67341ff2d..48ac4078b 100644
> --- a/testcases/kernel/syscalls/statx/.gitignore
> +++ b/testcases/kernel/syscalls/statx/.gitignore
> @@ -8,3 +8,4 @@
>   /statx08
>   /statx09
>   /statx10
> +/statx11
> diff --git a/testcases/kernel/syscalls/statx/statx11.c b/testcases/kernel/syscalls/statx/statx11.c
> new file mode 100644
> index 000000000..653050855
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statx/statx11.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * It is a basic test for STATX_DIOALIGN mask on block device.
> + *
> + * - STATX_DIOALIGN   Want stx_dio_mem_align and stx_dio_offset_align value
> + *
> + * These two values are tightly coupled to the kernel's current DIO
> + * restrictions on block devices.
> + *
> + * Minimum Linux version required is v6.1.
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/types.h>
> +#include <sys/mount.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include "tst_test.h"
> +#include "lapi/stat.h"
> +
> +static char sys_bdev_dma_path[1024], sys_bdev_logical_path[1024];
> +
> +static void verify_statx(void)
> +{
> +	struct statx buf;
> +
> +	TST_EXP_PASS_SILENT(statx(AT_FDCWD, tst_device->dev, 0, STATX_DIOALIGN, &buf),
> +		"statx(AT_FDCWD, %s, 0, STATX_DIOALIGN, &buf)", tst_device->dev);
> +
> +	if (!(buf.stx_mask & STATX_DIOALIGN)) {
> +		tst_res(TCONF, "Filesystem does not support STATX_DIOALIGN");
> +		return;
> +	}
> +
> +#ifdef HAVE_STRUCT_STATX_STX_DIO_MEM_ALIGN
> +	/*
> +	 * This test is tightly coupled to the kernel's current DIO restrictions
> +	 * on block devices. The general rule of DIO needing to be aligned to the
> +	 * block device's logical block size was relaxed to allow user buffers
> +	 * (but not file offsets) aligned to the DMA alignment instead. See v6.0
> +	 * commit bf8d08532bc1 ("iomap: add support for dma aligned direct-io") and
> +	 * they are subject to further change in the future.
> +	 * Also can see commit 2d985f8c6b9 ("vfs: support STATX_DIOALIGN on block devices).
> +	 */
> +	TST_ASSERT_ULONG(sys_bdev_dma_path, buf.stx_dio_mem_align - 1);
> +	TST_ASSERT_ULONG(sys_bdev_logical_path, buf.stx_dio_offset_align);
> +#else
> +	tst_res(TCONF, "glibc statx struct miss stx_dio_mem_align field");
> +#endif
> +}
> +
> +static void setup(void)
> +{
> +	char full_name[256];
> +	char *dev_name;
> +
> +	strcpy(full_name, tst_device->dev);
> +	dev_name = SAFE_BASENAME(full_name);
> +	sprintf(sys_bdev_logical_path, "/sys/block/%s/queue/logical_block_size", dev_name);
> +
> +	/*
> +	 * Since /sys/block/%s/queue doesn't exist for partition, we need to
> +	 * use a while to search block device instead of partition.
> +	 */
> +	while (access(sys_bdev_logical_path, F_OK) != 0) {
> +		dev_name[strlen(dev_name)-1] = '\0';
> +		sprintf(sys_bdev_logical_path, "/sys/block/%s/queue/logical_block_size", dev_name);
> +	}
> +
> +	sprintf(sys_bdev_dma_path, "/sys/block/%s/queue/dma_alignment", dev_name);
> +	if (access(sys_bdev_dma_path, F_OK) != 0)
> +		tst_brk(TCONF, "dma_alignment sysfs file doesn't exist");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_statx,
> +	.setup = setup,
> +	.needs_device = 1,
> +	.needs_root = 1,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
