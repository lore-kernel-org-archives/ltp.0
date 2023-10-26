Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0806C25B6B
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 06:05:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AB123CCD87
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 08:05:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B2FE3CB4BD
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 08:05:18 +0200 (CEST)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7DAE26008E5
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 08:05:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1698300315; x=1729836315;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=SY0MjTxyICLgsf4KhmGs5i2B9DesvzMQ+lPVIDIOQWU=;
 b=b7rJoJ7QDTSToq8+/ZMJfG66MxJYp3b5TMtk7Yqraun/Ms88HFAbsQIK
 y/wob7ABFHCHedsQjSxi/9BZ01+0N/HXtcaJkMVftTJP9UOxYpPIycfr2
 MVjMI243UL/c7l+ZZPnGZ3aGo1r6qTC7H0OEP66ZXo5JXzSIzsfP6/RhE
 APNr4cD8gZuI+99aDo0ZntgMCR4hrKoiQWkM8PCijtAMYz/lt8tYccYcU
 15Z76N7vt/CI3kFQNj3cR8IVfdWGABcq4r8jAyyPnWo9uPjIi6fRNHS8N
 IPcSXm0SF5dpltn9E7tOydB6QQX/ZVrdHRpeTlJzJDv75lh8aAghkp0ZT w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="100709805"
X-IronPort-AV: E=Sophos;i="6.03,253,1694703600"; 
 d="scan'208,217";a="100709805"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 15:05:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYR7zwaCg2Iw4hkJYYlDGrW0OJzIJWYCwAAv6wwvMS9ljHvNJMTvIV23OaM1AKxAA50hKPnoiibFMLZRJOf19v0FIb7LGyPHpkHGX2jfIuPvlwW/G7CBQzWyJpl8ltkaMcZOatDvkYO+LWxjx4EsEuaWDVMmF4PxRKD8J/cjj6mzw4qtvlKyw+PFLBmt2ZGmbkuo5er/G2VzDPTYlWKEsb1IAFSElHaKiAhtoQvWLdVT2Z7/aQcrFK1zcbIkvGDzgU8XXogiBDqqiyRLbc+EwyyI/iDvYrysVS0v7D2zgzPx9YUE08JypLduSMDucpzJrION8fal/fnftOC+9xqJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SY0MjTxyICLgsf4KhmGs5i2B9DesvzMQ+lPVIDIOQWU=;
 b=PYUvO0reXvfvcMaAuZpHSTg1JHrSWELSYuOOLL+M3t9C/p1WR9Fd0z8/Cmxg1+ToG96f4fIJ1dNDZhAfTO1XROaAxxQLvQtagsXikbHUIBG/0Fr6ys35mVe8OZi/vqnUrboBAZhLMd67eP7+pf6ktoHoi/JTAGsgtGTYVpd/hu/j4YDh1YI0fhMutnq0EgXRMdntIhR1wpcIHY1qhQFQrzizwNpxrSP2xG97Pf3jNmIAvhdcSYlQSImn8PHrLYP/Lihwo8DKH6hmBl1qJA2IB0vtLkjHGEHL1gEVdHJoafhVmjzla/cudSrZHIJ/EfRgycEN+QBJaMy0C5mdGhMfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by OS3PR01MB9866.jpnprd01.prod.outlook.com (2603:1096:604:1ed::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 26 Oct
 2023 06:05:09 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::251a:519c:5239:ba4f]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::251a:519c:5239:ba4f%4]) with mapi id 15.20.6907.030; Thu, 26 Oct 2023
 06:05:08 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 3/3] umount03: Simplify test using TST_ macros
Thread-Index: AQHZ/OfbbpxMVdXaQ0KfDgMMtNQZRrBbRn6AgABelrc=
Date: Thu, 26 Oct 2023 06:05:08 +0000
Message-ID: <OS7PR01MB11839F510190BCD78E5B32355FDDDA@OS7PR01MB11839.jpnprd01.prod.outlook.com>
References: <1697100058-2859-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1697100058-2859-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <20231026000539.GB540370@pevik>
In-Reply-To: <20231026000539.GB540370@pevik>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-10-26T06:05:06.485Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|OS3PR01MB9866:EE_
x-ms-office365-filtering-correlation-id: 79dec61b-619e-4c5a-ecaa-08dbd5e981e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z6M2vSyu2q6KTEXb95JBSP7+NqOzUrLxmjRrb2pDfuWQ6l5staC1atPQGMzDMDhqCSg6m5ar0pIEM8YxXiGaU6F80W2SuwuPPmwep3Qbt7JKLww49ZzBiWc6x0tWknKzYt/vuz1ncXtQxf8kaMGeGlHFOxvsCRkBxbadxR+sWZNK0xlLp7y6xdzJJ+HbL+BZLYUM714JRb8tBhtApBnvDojxynYPrMdmM1URba/MARBat9b+TlWcgnhzANeffwyNK2xSr65VGp10LjKhsBy5y9BSMfMbuMkI9e49JvgIjhMSz9vqKMIQhe8WfK1vuGb1c6yc+K3OxbQ0RMsuViT+Yo26i+zecrzGBT5pPMNiH12F0cJ56i5ZH8AztxikV31zsXhNaQUz12nNSSF7pBy6BLes9u6RfTjtB+655TDMGCDjOaiQzjqjRMl9ada1hgz3Y3yJy9+cn1NFvYDsQhlwHTESs3srWblQdetJw5g75ijU2diTFBDHgXO274twoTVAGJwbGsXf0nQ+0xoE6y4dkJmrKpo0lBxSc+dVRgvNCroSn5mHmxAhkkA1PyYs6yc8GuY4JNDstNceqsqnnPdh/t0wNMGTr90wCpe0zWiTx47D77QSbtFWp2zIM5Q+Z9Cf/xtVOCreYZcALvPsvBdpYg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(1590799021)(82960400001)(9686003)(41300700001)(122000001)(1580799018)(5660300002)(55016003)(26005)(4326008)(8936002)(478600001)(6916009)(85182001)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(224303003)(91956017)(1015004)(38070700009)(6506007)(7696005)(52536014)(71200400001)(86362001)(33656002)(38100700002)(2906002)(166002)(19627405001)(83380400001)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WDlmS2dMOExvN25wbk0wR0tYcHpoSFd5clFjN0xHdGYxZk8wUVJmQUZRRXFG?=
 =?gb2312?B?bjdWRSt2YmcyRmZjcmJrNWZGTXhScUZlcVN6R1l1Ylpib0QyRGV1TEs5Mm80?=
 =?gb2312?B?MWF2cHFxL1Z2RFBnMlpsTVROaHZLV3dqZWdVTHkrYlBiNEltc2ExOUl3aC8z?=
 =?gb2312?B?OWk4NkNGMFRvQVhZYXA4b0NVUlpOZnRWTGJrNGdReWFCMCtISGhpV0hveDcy?=
 =?gb2312?B?clg4T2JWd25WdXFLNjdEa0MvNnpQNmxiNTRJSFoxV0RIYUMvN293N29ZWDQ1?=
 =?gb2312?B?YUc0QUd1bWl5Y1BMNXEzODJZbVVkeTdhbXU4b0E4TTNVME1mU0lZSVNFbDdJ?=
 =?gb2312?B?QmlTVHYwdTF2MC8yZTdmaXJhY0lrQThJdkdHamNySzFxclFHWDZMeVRlZ2o1?=
 =?gb2312?B?b05XUWxNRjI1R1hsUzlRWmZYVS82ejcxOEU3b1BPRTdKT2JJVDZIWGt2dHc2?=
 =?gb2312?B?aElnTGs3OUk3K0xYR0FwbE9JTk4xSTMzaHhJRzBSK0FvTmNzYzhudlZ1SlNN?=
 =?gb2312?B?UVd5TGhFa2diZHV1SnByMis0WkZOYjNIYnpDS3FsZVlzcDFZWi9xNFpTZ0xz?=
 =?gb2312?B?dS91WVpQZVBXM3BQQ3h5R2FId0NaazRzcEtPZlh6enNSaTBWSG5MQnlMOFFV?=
 =?gb2312?B?K1RlMzJqdENzWmpyWHhSRXZtUE91Z21DVmxBUW9UMm1NL1l6cm1EdVBnYzd0?=
 =?gb2312?B?bFNuU0V0N1V1aEVRVitFcTJkOXpiNkpGT0VsTXZkWkwvT0RWamgyUUpzdEZx?=
 =?gb2312?B?UnZFNFVLbmVGcVpwNDVwVVdkd1U2eEduU0s1N3F0dkREbVBpa2I5SkJNejlS?=
 =?gb2312?B?ZWlWNHBmZysxZDR2M29FRkx6UkdxSmJQN3huQzBkcDdqVS9KOW9IYTNSejhv?=
 =?gb2312?B?T0JseGlRamFqbmxSeG5jZTQ1WUZtQnkza2dKU2dQbklDOThhZWtnMHI2YXln?=
 =?gb2312?B?cjZOejJGQ2pJVGljT1Vvb3dsQitsUVg5bVpRNnFBNW1Pb0s5QUFNWTkySmFh?=
 =?gb2312?B?S1A2WnE3N3ZBS0h2NThpdGVLc2w2ZHR3SXBtRGJkZFZwTTZ1akFxNVdlcnc1?=
 =?gb2312?B?MlVvbXFGWTFEeTBwNUNkcUJTVnJFMGJTdFZPN2E3akhIMmVMb0VPdnY2SXgw?=
 =?gb2312?B?WnRjM0hzTloyeGRwQnpTZXJuSGNUUy9pOUliOElLYXdJUThOSGhCZS9MaTNl?=
 =?gb2312?B?L2gvYTZBSk9QTlZnR1lpU2xmYWdMREFmY05ndVhyUEl3bFBJemFZb2thclNT?=
 =?gb2312?B?cnBQVVlwQytyMmFuWmlmdWI1dkNVNWY4REF1d1pMTnk3a0dpUzlqUHZwR1hv?=
 =?gb2312?B?MmRNVm9JZ3Q4WjBTT05OalpDaE01LzZYekhCMWwwWG9IVjYwTmM3SmZvd0pj?=
 =?gb2312?B?eUIvZ2N4L21VdmJRbDRqS0srNm1FeXBIQ1gvU1ZPYXIwaDk3ZHFpSlRZeThz?=
 =?gb2312?B?bDV0bHdzR3grdE5pbnNQMHk0MkZMcVlNckNYTjBYaVpoQ0lZWUxTN3pRWHpv?=
 =?gb2312?B?YUZ3bkdBaitTOTJEQkRKeTFCdG9kQ01uQ2xzclFYcEVhQzh4WVF3SjdKVUNK?=
 =?gb2312?B?SFVHZE9FUG1nTGthbnhFNWhjYnFrTWNDNFp3OHI3ck44N3RoaStQNzM0Ynhk?=
 =?gb2312?B?SXFxdGxLWEhwcWQ0VDVSVW5aQndEU0pNQldXK1NNWnBYUkRPS0x0U0t0NnNy?=
 =?gb2312?B?Q1NEL1FLSkZRSFZzNStmbk5DT3BLeXFxTGRKa3liMW5RREN3Z3NkUDFJSU40?=
 =?gb2312?B?aTR2d0pNd1I2QmlsbUd3QXlWb0F5c0s2KzFSbzN2UnVZRWlWcHB0eko1eHFT?=
 =?gb2312?B?ZStDREFaQWxvZUlOVzlKMnQvMW1IeXkxS2ozNXVSSXUzamx4L3JsRW9hNFRZ?=
 =?gb2312?B?NU1HTWRHclhBdkZhRHc1aDlQWHUybjhNUnFzZXh3V0hHVEZXNHZFWDRJRy83?=
 =?gb2312?B?eVpPMnJqQjFZTFNISTJGbmhBeklUSXNXMkxaVFgyYlJENmxsVGhZVkNaNEVI?=
 =?gb2312?B?OXFUaGY4Vmp6dkhsTTdoSEoxNno2Q2ljZFZJSDI4OHl4TnFBdnFWc3U1NEYz?=
 =?gb2312?B?K202S1U1enFMTjV0K2NXRmpTSVZoR1RPUUI3Wm9pTnhMOXUzTjNLR0JqdmdW?=
 =?gb2312?Q?fjXteD6FyW1djc4yq6gyOvL/a?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qvpiRERcMqzahelk7MgOtVXpQKWmVupZelMlzKci0cHBaEXDfypOmd0AwlxsbXwyy2hBIvzu249Bw5XgZ3DkQoxFTn2qte3eKNjveUiVH0ViVh7XI3Rr9vrB9nE5hyw5wixmF5s+A0JhmA0B+vzMu7rOZgA8LR4qLn50KShO8xLSUEwvkv4uGp4o19d+kun6MYRNBVT+HWqTGdSULFQosJ01oefMyE6cZxwQ2UwkHt5WhOHmCuaDhCGb+HVCo7qSf5OARbL7t1zx7A9IIAHhx3lDDEMaM/lXZvWuLw6K0+foayjnBewIsuTe7OEgvQ2mwyXBTa8L7lgzoPyr693A//MXcrMgnYzR4GS5lZjMqHPsAzxexcUKOdB5EHG9dgsKNPrWkDwemhz04iev071zVN4/W0ZTLd1XMsYQzeiwIBoonWzXkBcJV6jMiaYy9eg2G3070N255c/0yYFgh5RXRWdCiRDnvhEBg3gt5WCq++7ynjd0HfXnWyv+nKJMn7yjetzWHwedUK8za3YgXNblHWGD+YFZ79uzdKVRPjrDyNDOX9xtwOxTmZqtJA7pRKlXvhgkDVWAMNbsc/DJKWwvePMiR0jUzRFaKjZ5Sf0qRhiKquSEVkPsZF029IKQrWm8+Y37BhSF7+e2wvKWAU6SPSmF/AyQVLv8X3jCRtrlx9dnN1/UUl7gIAoUjVvvPtxjeNdlYcAFgoHQS4tBYek02dmIcen+0o848cCmnGTmvO+HN6DRNGCjNl4IZg9mzdFtwTC4yRirdbwLmMUv0rHzC6A6WnOnGpGRsR83hnICRYg=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79dec61b-619e-4c5a-ecaa-08dbd5e981e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 06:05:08.5837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPS6Dx8raVSMjruylSluAVdwauEATmGyVKZbntGg0e1GS7nohQQXycXKzyPnresbl1qTCE60HAyXmN/jE4oXLYrRgy/PhejKy7GU79gGtgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9866
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] =?gb2312?b?u9i4tDogIFtQQVRDSCAzLzNdIHVtb3VudDAzOiBTaW1w?=
 =?gb2312?b?bGlmeSB0ZXN0IHVzaW5nIFRTVF8gbWFjcm9z?=
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

SGkgUGV0ciwNCg0KPkhpIFh1LA0KDQo+PiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFh1IDx4dXlhbmcy
MDE4Lmp5QGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+PiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy91bW91bnQvdW1vdW50MDMuYyB8IDEwICsrLS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQo+dGhpcyBpcyBub3QgbmVlZGVkOg0K
PiNpbmNsdWRlIDxlcnJuby5oPg0KDQo+VGhpcyBpcyBmb3IgYWxsIDMgcGF0Y2hlcy4NCg0KWWVz
Lg0KDQo+PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bW91bnQvdW1v
dW50MDMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW1vdW50L3Vtb3VudDAzLmMNCj4+
IGluZGV4IDFjZWYwNmZhMS4uZTZiYjUyM2I0IDEwMDY0NA0KPj4gLS0tIGEvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy91bW91bnQvdW1vdW50MDMuYw0KPj4gKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy91bW91bnQvdW1vdW50MDMuYw0KPj4gQEAgLTEsNiArMSw3IEBADQo+PiAgLy8g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4+ICAvKg0KPj4gICAq
IENvcHlyaWdodCAoYykgV2lwcm8gVGVjaG5vbG9naWVzIEx0ZCwgMjAwMi4gIEFsbCBSaWdodHMg
UmVzZXJ2ZWQuDQo+PiArICogQ29weXJpZ2h0IChjKSBMaW51eCBUZXN0IFByb2plY3QsIDIwMDMt
MjAyMw0KPj4gICAqIEF1dGhvcjogTmlybWFsYSBEZXZpIERoYW5hc2VrYXIgPG5pcm1hbGEuZGV2
aUB3aXByby5jb20+DQo+PiAgICoNCj4+ICAgKiBWZXJpZnkgdGhhdCB1bW91bnQoMikgcmV0dXJu
cyAtMSBhbmQgc2V0cyBlcnJubyB0byAgRVBFUk0gaWYgdGhlIHVzZXINCj4+IEBAIC0yMCwxOSAr
MjEsMTIgQEAgc3RhdGljIGludCBtb3VudF9mbGFnOw0KDQo+PiAgc3RhdGljIHZvaWQgdmVyaWZ5
X3Vtb3VudCh2b2lkKQ0KPj4gIHsNCj4+IC0gICAgIFRFU1QodW1vdW50KE1OVFBPSU5UKSk7DQo+
PiAtDQo+PiAtICAgICBpZiAoVFNUX1JFVCAhPSAtMSkgew0KPj4gLSAgICAgICAgICAgICB0c3Rf
cmVzKFRGQUlMLCAidW1vdW50KCkgc3VjY2VlZHMgdW5leHBlY3RlZGx5Iik7DQo+PiAtICAgICAg
ICAgICAgIHJldHVybjsNCj4+IC0gICAgIH0NCj4+ICsgICAgIFRTVF9FWFBfRkFJTCh1bW91bnQo
TU5UUE9JTlQpLCBFUEVSTSwgInVtb3VudCglcykgRmFpbGVkIiwgTU5UUE9JTlQpOw0KPm5pdDog
SSB3b3VsZCBwcmVmZXIganVzdDoNCg0KPiAgICAgICAgVFNUX0VYUF9GQUlMKHVtb3VudChNTlRQ
T0lOVCksIEVQRVJNKTsNCg0KT0suDQoNCj4+ICAgICAgICBpZiAoVFNUX0VSUiAhPSBFUEVSTSkg
ew0KPj4gICAgICAgICAgICAgICAgdHN0X3JlcyhURkFJTCB8IFRURVJSTk8sICJ1bW91bnQoKSBz
aG91bGQgZmFpbCB3aXRoIEVQRVJNIik7DQo+PiAgICAgICAgICAgICAgICByZXR1cm47DQo+PiAg
ICAgICAgfQ0KPlRoaXMgc2hvdWxkIGhhdmUgYmVlbiByZW1vdmVkLCBpdCdzIHJlZHVuZGFudCB3
aGVuIFRTVF9FWFBfRkFJTCgpIGlzIGRvbmUuDQoNClllcy4NCg0KPj4gLQ0KPj4gLSAgICAgdHN0
X3JlcyhUUEFTUyB8IFRURVJSTk8sICJ1bW91bnQoKSBmYWlscyBhcyBleHBlY3RlZCIpOw0KPj4g
IH0NCg0KPj4gIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpDQoNCj5XaXRoIDxlcnJuby5oPiBhbmQg
aWYgKFRTVF9FUlIgIT0gRVBFUk0pIHJlbW92ZWQgeW91IGNhbiBhZGQ6DQo+UmV2aWV3ZWQtYnk6
IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pg0KDQo+SXQgd291bGQgYmUgZ29vZCAoYXMgYSBz
ZXBhcmF0ZSBjb21taXQpIHRvIHJld29yZCB0aGUgZG9jdW1lbnRhdGlvbiBhbmQgY29udmVydA0K
Pml0IHRvIGRvY3BhcnNlLiBGZWVsIGZyZWUgdG8gZG8gaXQsIG9yIHBsZWFzZSBsZXQgbWUga25v
dyBpZiBJIHNob3VsZCBkbyBpdC4NCg0KVGhhbmtzIGZvciBhbGwgeW91ciBzdWdnZXN0aW9ucywg
SSB3aWxsIGNvcnJlY3QgaXQgaW4gdjIgdmVyc2lvbi4NCg0KSSBzZWUgeW91IGhhdmUgYWxyZWFk
eSBtZXJnZSB0aGlzIDU4NGI4N2E8aHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVj
dC9sdHAvY29tbWl0LzU4NGI4N2FlOTRkNjFkNWEzY2ZjNDdjOTE0NmFmN2I3NzhlMmM5YmE+LiBJ
IHdpbGwgYWxzbyByZXdyaXRlIHRoZSBkb2N1bWVudGF0aW9uIGZvciB1bW91bnQwMS8wMw0KYXMg
YSBzZXBhcmF0ZSBjb21taXQuDQoNCkJlc3QgUmVnYXJkcw0KWWFuZyBYdQ0KDQo+S2luZCByZWdh
cmRzLA0KPlBldHINCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IFBl
dHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pg0Kt6LLzcqxvOQ6IDIwMjPE6jEw1MIyNsjVIDg6MDUN
CsrVvP7IyzogWHUsIFlhbmcv0Owg0e4gPHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQqzrcvN
OiBsdHBAbGlzdHMubGludXguaXQgPGx0cEBsaXN0cy5saW51eC5pdD4NCtb3zOI6IFJlOiBbTFRQ
XSBbUEFUQ0ggMy8zXSB1bW91bnQwMzogU2ltcGxpZnkgdGVzdCB1c2luZyBUU1RfIG1hY3Jvcw0K
DQpIaSBYdSwNCg0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFh1IDx4dXlhbmcyMDE4Lmp5QGZ1aml0
c3UuY29tPg0KPiAtLS0NCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW1vdW50L3Vtb3Vu
dDAzLmMgfCAxMCArKy0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCA4IGRlbGV0aW9ucygtKQ0KDQp0aGlzIGlzIG5vdCBuZWVkZWQ6DQojaW5jbHVkZSA8ZXJybm8u
aD4NCg0KVGhpcyBpcyBmb3IgYWxsIDMgcGF0Y2hlcy4NCg0KPiBkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy91bW91bnQvdW1vdW50MDMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvdW1vdW50L3Vtb3VudDAzLmMNCj4gaW5kZXggMWNlZjA2ZmExLi5lNmJiNTIzYjQg
MTAwNjQ0DQo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW1vdW50L3Vtb3VudDAz
LmMNCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bW91bnQvdW1vdW50MDMuYw0K
PiBAQCAtMSw2ICsxLDcgQEANCj4gIC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
LW9yLWxhdGVyDQo+ICAvKg0KPiAgICogQ29weXJpZ2h0IChjKSBXaXBybyBUZWNobm9sb2dpZXMg
THRkLCAyMDAyLiAgQWxsIFJpZ2h0cyBSZXNlcnZlZC4NCj4gKyAqIENvcHlyaWdodCAoYykgTGlu
dXggVGVzdCBQcm9qZWN0LCAyMDAzLTIwMjMNCj4gICAqIEF1dGhvcjogTmlybWFsYSBEZXZpIERo
YW5hc2VrYXIgPG5pcm1hbGEuZGV2aUB3aXByby5jb20+DQo+ICAgKg0KPiAgICogVmVyaWZ5IHRo
YXQgdW1vdW50KDIpIHJldHVybnMgLTEgYW5kIHNldHMgZXJybm8gdG8gIEVQRVJNIGlmIHRoZSB1
c2VyDQo+IEBAIC0yMCwxOSArMjEsMTIgQEAgc3RhdGljIGludCBtb3VudF9mbGFnOw0KDQo+ICBz
dGF0aWMgdm9pZCB2ZXJpZnlfdW1vdW50KHZvaWQpDQo+ICB7DQo+IC0gICAgIFRFU1QodW1vdW50
KE1OVFBPSU5UKSk7DQo+IC0NCj4gLSAgICAgaWYgKFRTVF9SRVQgIT0gLTEpIHsNCj4gLSAgICAg
ICAgICAgICB0c3RfcmVzKFRGQUlMLCAidW1vdW50KCkgc3VjY2VlZHMgdW5leHBlY3RlZGx5Iik7
DQo+IC0gICAgICAgICAgICAgcmV0dXJuOw0KPiAtICAgICB9DQo+ICsgICAgIFRTVF9FWFBfRkFJ
TCh1bW91bnQoTU5UUE9JTlQpLCBFUEVSTSwgInVtb3VudCglcykgRmFpbGVkIiwgTU5UUE9JTlQp
Ow0Kbml0OiBJIHdvdWxkIHByZWZlciBqdXN0Og0KDQogICAgICAgIFRTVF9FWFBfRkFJTCh1bW91
bnQoTU5UUE9JTlQpLCBFUEVSTSk7DQoNCg0KPiAgICAgICAgaWYgKFRTVF9FUlIgIT0gRVBFUk0p
IHsNCj4gICAgICAgICAgICAgICAgdHN0X3JlcyhURkFJTCB8IFRURVJSTk8sICJ1bW91bnQoKSBz
aG91bGQgZmFpbCB3aXRoIEVQRVJNIik7DQo+ICAgICAgICAgICAgICAgIHJldHVybjsNCj4gICAg
ICAgIH0NClRoaXMgc2hvdWxkIGhhdmUgYmVlbiByZW1vdmVkLCBpdCdzIHJlZHVuZGFudCB3aGVu
IFRTVF9FWFBfRkFJTCgpIGlzIGRvbmUuDQo+IC0NCj4gLSAgICAgdHN0X3JlcyhUUEFTUyB8IFRU
RVJSTk8sICJ1bW91bnQoKSBmYWlscyBhcyBleHBlY3RlZCIpOw0KPiAgfQ0KDQo+ICBzdGF0aWMg
dm9pZCBzZXR1cCh2b2lkKQ0KDQpXaXRoIDxlcnJuby5oPiBhbmQgaWYgKFRTVF9FUlIgIT0gRVBF
Uk0pIHJlbW92ZWQgeW91IGNhbiBhZGQ6DQpSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVs
QHN1c2UuY3o+DQoNCkl0IHdvdWxkIGJlIGdvb2QgKGFzIGEgc2VwYXJhdGUgY29tbWl0KSB0byBy
ZXdvcmQgdGhlIGRvY3VtZW50YXRpb24gYW5kIGNvbnZlcnQNCml0IHRvIGRvY3BhcnNlLiBGZWVs
IGZyZWUgdG8gZG8gaXQsIG9yIHBsZWFzZSBsZXQgbWUga25vdyBpZiBJIHNob3VsZCBkbyBpdC4N
Cg0KS2luZCByZWdhcmRzLA0KUGV0cg0KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
