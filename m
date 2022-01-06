Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAAFC433F5
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 02:21:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 715E63C928A
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 03:21:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C2223C0FF4
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 03:20:54 +0100 (CET)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C0DCD14010CE
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 03:20:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641435652; x=1672971652;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=vGePCpK6qF+2zgx9J4A/i3pc5Yl7MOR7mmAZMyYZSo8=;
 b=RMoZ/nLbyAmGNm/EsI0DLXozJGfxfp/IQCguCl5rNVw/RbtFumEHZWyO
 dh8/sOpDm68SfPgKwZ/h5OWb+UupcEdOFhRTnMpJIvBi3UxieSe1w9XTs
 obQKNXk/ampjiX64wTQm4aUlfFh144bodQ2mP2Ca1/5YttIUGIWIT5ROg
 6FGJVTwAqOYz1AQnu7eo/T0wwTItsirL9EIuxvec9EpJDm7yn3Y3mzVY8
 /SlZuXOvDohVeoEsLNV0yIEWI2hCn+O6iaRtCOkGToU5LfjRbGdWPzGzM
 nExbZM/ULGFdHeX+wbt3Ish59v69Q+i/5gHsVphgkw3/icusBIn1frzVj Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="47115842"
X-IronPort-AV: E=Sophos;i="5.88,265,1635174000"; d="scan'208";a="47115842"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2022 11:20:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaU22PjjzbSSJmQfyPfZEnWEVZgffGnTU47XVMs9ckEIZzPIBSPDQDDNJtee4diGX1YmJqcgJWPrehoDLoQ126CR5fcoTbq1gcPXbxaNQiprFH940QjhGgnoZqRY+mFYygZqGvp8XYZrb/4q/joYGUc5RvGgifvyGWqPO3c/SQ3wG95i7/42leZJVlrd6T0YnU2EWkCyPuB9mF/iVPjqGY0eBTyJNllur8BXs01SOVOKGllHg1T0QW/8k/iXALQZor0Z8CizPvnDCh04vUUmFyfOaMz3mkhpOK7rR+CB3YVeYrLKSXWJAqwpE7uBzxLvHcJUgdw8sp8uUHukg6hJDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGePCpK6qF+2zgx9J4A/i3pc5Yl7MOR7mmAZMyYZSo8=;
 b=msbeK/7+hOKI/t8RvuA4e7MCA5Vg4hjSYx0wi/D/mQGN22xsl1Vt3Bt98N+Lp0Uu7LrOkZjtCIMEa8udLlwn0Peic4F8p38Vvfd/fGaXLDRqdZIj/Lu7ZlKBL1mbtCXoKGSxGrEBFbCSdYhSlxOknDVK9t3Kr0AlYGkPhRMjaMogg+G15FVYT0knuz7mJWzebY6Lwori4RGIXAQPY8DNwmOj79Q374BMmMJDU341Tv2I+6VpIAuAs4AFd+b5NmNkbUWtwqE/ROr3J2fo/8nkS6zdfjsasO1LrhezpXeLDFPkmSUZCTiXsGvA7odDDLoX3D2FwsofAA1e8zHnsdNa3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGePCpK6qF+2zgx9J4A/i3pc5Yl7MOR7mmAZMyYZSo8=;
 b=K9N+57BHXCjaZXFP4S6sdYeR9D0oHWIWWgWyGBy6ERuLE/SxtSpMFUkCLMt/+8VwyfZoTS3pxM4xt4DJGKDilL6NipZQui7ntrhNf7IQzZLWqz5IlYyqebM3mGtV0cgKnCh140s3dZAV/eZa4b+pxssO/MwW6w/BRaveBZQgsWc=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB2318.jpnprd01.prod.outlook.com (2603:1096:404:1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 02:20:46 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 02:20:46 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] lib/tst_test.c: adjust the tst_kconfig_check
 position
Thread-Index: AQHYAhXetolD40qAw0qKLg/g2i71IaxURGyAgAD/ngA=
Date: Thu, 6 Jan 2022 02:20:46 +0000
Message-ID: <61D65226.8060408@fujitsu.com>
References: <1641374609-2143-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdV7uSO7tE1rAWPO@yuki>
In-Reply-To: <YdV7uSO7tE1rAWPO@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e27725da-14fd-425e-28a6-08d9d0bb25f3
x-ms-traffictypediagnostic: TYAPR01MB2318:EE_
x-microsoft-antispam-prvs: <TYAPR01MB231889D9286D87796E11EA8CFD4C9@TYAPR01MB2318.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eaPTT+zdTlVeXJbh/YYcUoGj3LYbLTO4yHeIq2hei4tvamsC4tGz0A633qOrJDhiHBD+auPgEdjXzBtdIOoJ7HzcyREJaCgWzgLVyrIyq92bW2a+KQPXMsBIILTrWEnt9AAEN+KPx7ucenwMZNmxbhC3Nf3mr8cjCBELxOXf7gnyupcMIGdTVArKFINAepa2cgWarD4Co6kjxcd1hk3bAcRoGwNUOOqzAkweCCWYPRzsEnUoGQ9ogJt0SdXankIRcfvfBdWX4rskiHU/RN1jBMxTY/2+aWFXuCYUJPOZ4ZQL6+ffgJxsTOo6hhso1o5qlIqfHQFwOEriHQNxLUxdrSw3GaRT1pnp5wPAG6+jSbDjXSP1evfm61AcSxuerOJ2c2rh7wtpyOcB8haYpPHU9pLvm7+Ti/MkdV1kgmHP0qAAIgEKdYZ1Q838x0LwisBZD4orAaM14rj2aYYzRNFJEZKJiHfYiWCq+v28HIGStEbLRbMWdMw2zOKfLXqu8cybng+c6uOTi46MCuvcjNpiZgydUDyYhtWnj0cQEbqv4BpV2RRxPe5onqL9qN+rhQyqxQwBM1jZ/gITrcU5CfP0SitqoChpcr67K4seAbAF56Wb/IAL6zBSnF4Wjmz4YN0wmGMR7sPx/5JA5LOuFr/HnCGg20V8v7B0G7H6nP3iZHu10RVOSHbtMiXYMl/RRWkFnKhZaGrChH6rjbyE9iBDyQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(8676002)(2616005)(316002)(186003)(5660300002)(36756003)(33656002)(6512007)(38100700002)(87266011)(6486002)(2906002)(66946007)(4326008)(64756008)(508600001)(71200400001)(8936002)(6506007)(76116006)(91956017)(122000001)(66556008)(38070700005)(66446008)(82960400001)(6916009)(558084003)(26005)(85182001)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UE1PTkdFa3VmbDdKZWMwc3UxTXRQRWJ4emI0ejNWOEFCaVpCeGYzSi9vSHg0?=
 =?gb2312?B?SlJid1hKQ2srNjVNTzFjY3Q0QjdkSFRXNGNlcnBiWEV6LzVldDFTMnpvQU1D?=
 =?gb2312?B?akFnQzN4aWlCZWJhRmNXUmhIdGlwb2Qvc0YyczAzbVhsYjBSbUJ6RXQ3cDRJ?=
 =?gb2312?B?bC9QNGF6TkdpaGNyNzRxQXlVcll0UDNxQVN6WDNDbTZMenEvaTF0dzJqR1c4?=
 =?gb2312?B?K1dIeVJPSldMc1ZxbjJaTERmYktLWS9UTmFlWHlpbkd0RW4yZTVkbkhuNmI0?=
 =?gb2312?B?WUFTQ1lob2JhWlZEWkoranhVeVhmaWcxbXVwU1UzaVU2enl6UmxQeC9nOUxl?=
 =?gb2312?B?TENGcHpJZGszdWJqTGxpKzRoV2dNNWNOU08vRmcvUWlURTVVU2pGb3VKR3VH?=
 =?gb2312?B?dTNQenFWRnRYRW1oVDZuVW43NG1BUG5CWXlNaFhjYy9QcTF2RDdJTWxCeFpv?=
 =?gb2312?B?VEk5M1d1TUt5RVVTcHlCYk9EUTN3bkphZWViaUtsZ1phU0I0TlZrNXh3ZGR6?=
 =?gb2312?B?VjMyekFRV0JIeHlTcHAySDVvTVRLclpLNDZzR3BYTVN2aFE1YlhnU2tRbndo?=
 =?gb2312?B?Skx6TThZaXh4SjFyLzYyRlJwUi9TcURTejdIdnFvdXVURHVRRXJPa2RPbVpl?=
 =?gb2312?B?K0prYVdWOW51Z1pSZ1BkYmlTYUd2d1JTMDdPby9GVy9zNDhiczYrbi9DakVV?=
 =?gb2312?B?b3kwS2k4eGtoUVpYU2Yxd2N2WlNDeXl1ZllUYUxWUjRBYU1zNk5xRVBVSlY1?=
 =?gb2312?B?cFAzVjJJeWJhQ1pVSFoyT2tBeVVrQ3d6MFFWNGlxS2V6TkV1MzBLMmhBeitz?=
 =?gb2312?B?OGs5eWVLbWl2WVQzZ0hieEtPY0NlQ3dRY2NNQmNZMlJTS25pYVlnRmhEWHEr?=
 =?gb2312?B?eWdvMkxVQ0xJbDVsZmpDYmdoZHBvWHRKc3B2QW1DaDdOaUxzUEZRdDRvWVQ3?=
 =?gb2312?B?cE9pdm9NQXBTS2VORzZRYVBCQ3NqaHN4TU1rK09zek1JaHZOeWl1Z0xUSDRJ?=
 =?gb2312?B?bHYyOXVTQWxvZXRvZGkzTUQwYWlRc3NYYWc1TytMY1I0NTN5TEwzdXU2L1dV?=
 =?gb2312?B?d3BXMGNZOWhUK3NvbHlaTG02UDd2eTZ4d2JlY2wzbm1BUGlJVEtuOVh5VTBF?=
 =?gb2312?B?OGs1MG0xRVpPQW5mRnAxV1BwQnZWbCtQRnFMNHlsbnpxUElJWHZSSnQ5Ry9q?=
 =?gb2312?B?ZkgzTllncEtMMEExNTE2emhPaFZ4MEhnbXBNbk9mNDE4T3REakt4dGtlcVJr?=
 =?gb2312?B?UW10NDErWDRBdG5nOWZiMEZnQ0pnMGhxQUl5eGNybmVaWVN3R0tmdGpNakla?=
 =?gb2312?B?UGVCOFAreEErN05MdXlHTnpQVlp1Z1FHNHpxWlNFdkxYa1Flamg0cGZ6ek43?=
 =?gb2312?B?RXlwbUlNblBYYkJ5aUg5UDB3ODY1c0JFZmd3V2ltcDF0a2ZNdDJHNk5PaHNB?=
 =?gb2312?B?Y1dSWE04MHozdmszVzU5dllFQmR1MVZsY2ppV0J3OFZOVXRqMFlJbkIyRGJl?=
 =?gb2312?B?MDhxZkJhNXgxTnpBQkJJbThXYVBLSXRZN2tYVVZ5Z1AvZ2JSVWY4eEJnM3h5?=
 =?gb2312?B?SWIwL3FLU3EyZDEyTXh1K1lYZVVJejlla3BKQW1mb2ZVZ2FlSE5XN3F5QnJR?=
 =?gb2312?B?VDNQMjc3SzQ3QXU4UWRaOUZJd21HWUt4LzRWRFlUdVJQeGI0MVhNWTFES0lw?=
 =?gb2312?B?bEhkR3JWcDd5a1dXSk1yWFNPdzZGL2xINHV1bGVtblM1N3lUbGlDem9PaGNt?=
 =?gb2312?B?dGFTUURtelQrZENqWUxWZnJSVituSlFiRlRKZjcxTEdFa2dHbVNHV2R2RmN3?=
 =?gb2312?B?RlI1M2NGc1c0WGpiK2llQ0RzVjA4RWtuTEorUFNBRHV3UUptOS9pLytSUlBu?=
 =?gb2312?B?NWFqSFRzR0FzK1FkMzRFbEdqOGozVHR0dWdYYWhxSzArTWFVZnZxM2w3UEpX?=
 =?gb2312?B?aVpEKytnZzVPTnN0TERtdkNOaDVsS0xXZ2o0RGRsd3BPZllCRG5Xc3cyVWJ6?=
 =?gb2312?B?QU50TU5MN1J0VXZsTmgwNVRRZklHN2FIMHkxc0hQTzVGQmt2cE9RUEJUSXFj?=
 =?gb2312?B?dkQxVUFhWVlwNUxxeFlVN3FhbVZ0NkREVnZTYXJXV3NKY29vOUNJWE9PdUpT?=
 =?gb2312?B?UlVjMURIaVAzMERCNUdMSndHTERqU3N0RmE1SW40MG1GMzJnNEtNb3JEa3U1?=
 =?gb2312?B?ejEweTRSZUZmNlpxTExKdlpJRys2QjJUM3F1clJEbDFpQ1piOU9yRExsS1NC?=
 =?gb2312?Q?HegkAlD1sjfQD5YuX/DU+f5Mr3vTwyg2dyxGFfyMQQ=3D?=
Content-ID: <FE66029A66B4B14BB5BFC1D9DD499E70@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27725da-14fd-425e-28a6-08d9d0bb25f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 02:20:46.3321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fiC1ZL+9rCn2ZCNSbTBq0X4tHU7fcxqc/IX+c/EccxHn9nyUs0/wia3OJ2ET0GEhYsrUbeDOKYW0QcQwsoBysjV28Deoh3XIoKOLBABgIbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2318
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tst_test.c: adjust the tst_kconfig_check
 position
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril
> Hi!
> Good catch.
>
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
Thanks for your review, merged.

Best Regards
Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
