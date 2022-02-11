Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C69C433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 05:17:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DB9E3C9EDD
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 06:17:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B14703C93EA
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 06:17:22 +0100 (CET)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8E2E5600E4D
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 06:17:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1644556641; x=1676092641;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=vuAD8Yiey0bvKg9EQqSJa5QQUicGhxiBz1bKsJj1fHc=;
 b=LtJPSfGbF/1c55lcFqsPIt2Pi+Wz14UxfW/HhIjuSP5ix7O3CDn8aqKq
 mV3pGyOqeC5l150gP606sIP8OqMlvqo6YPkiNanprRHn+pI8QIJlKKVT5
 jK8o6CfEr8BdPe012e11SEIkXeVThey9DHaqDRt7uAbQn6s2/0a+NSy0e
 Q5fqcTg9m58VDCv5lJOWS35aakNfy/vYV6FR/+fvWJZ9gIEOL7T/MJ8mu
 /UBe0Ye650ZWqfvNqQIUnummvo5prVj/dmIIJa5vlKjqBUu1MN31Ed8k8
 MfH4wu5N9ePfeEDe75N8m/Lvkk0CAgiYZX2Mj4PmekS9fKZIlRIZ31gzq w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="49378458"
X-IronPort-AV: E=Sophos;i="5.88,359,1635174000"; d="scan'208";a="49378458"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2022 14:17:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNe0YSoFtAaJ+9CG8gxaX5LNVJAPHQJb6cuxrm2nZctzK/QqZa+AQ8m5ORjUW3iPGembtlUPM4Z9r5TGCo5EfvdTBb8uoozFkxvZd08O9wext96AGbx0hzX+nf6DeutnqarD3H8U1aff1mJLl/11kNNTW5U59la9TX6VObfxHhekeUtIQaHRSaEWerXSGn+MYMBArib1lMUGVYJ5lpAJfamumFORO7j0iRxZp3xB/XH90GDbGPROzSH1XVDeI0u1BiSKIjjJhJTtB86T+QKhCJ9rKefj6KttXcQ5uVZjNYiS7O64K+iXin7Y7dFdKDtSMUti+bsHSn7ZzY6gxKcU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuAD8Yiey0bvKg9EQqSJa5QQUicGhxiBz1bKsJj1fHc=;
 b=Jv0VlKRkF1gypN53URwg88VVDAG2D82Zq1I7JyWCWR1uXdu9Gj411Rpt+0/WCxBA+Az1yYb6PbwMf8CEAIfh9rR22lx4pfC8Ar74CRJFS2NOA1wNER+rSyaXeSxNU/8KPblQxLNr/5GSn6aa/FwRcbjzr6pv7hH/dUMQmznJcNzQ6QpY3E1JFpP2wHTEc7Hi1MvtpqkzrnyrGhsez1XSRFaGn8oqMb90V3SLk4HB1MTOmQYk6X/QecvK9oj5w+3G9zSDZfp4DgsU4jwML0/nvJcLwCw4MBfvjXtYFHSO2bTl4WBLxIrdHz5sQbE0xiLzDsi28JA/E/VtyX/+Q1EbYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuAD8Yiey0bvKg9EQqSJa5QQUicGhxiBz1bKsJj1fHc=;
 b=KzgRlg/OESXNUki1tVarBwSS5yWMXAYrmzA7hP67vP4NuQWxwZTrIBK8gSjW5OXJv3hU74rMJZnCmFCFys/a5rfA4vBNqHz3b8tzOQpDAWao66xliZ1TzKn5fn/rvL5NSkdKQCm+Tk+aJZL8gQEZwm57aPXCYAS9ElE9ngALcCk=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSBPR01MB2501.jpnprd01.prod.outlook.com (2603:1096:604:1a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 05:17:15 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 05:17:15 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH v2 5/6] shell: Add test for TST_FORMAT_DEVICE=1
Thread-Index: AQHYHpslW3RI1js1eEWNbSGRaq1QC6yN0D+A
Date: Fri, 11 Feb 2022 05:17:15 +0000
Message-ID: <6205F185.5080603@fujitsu.com>
References: <20220210162739.30159-1-pvorel@suse.cz>
 <20220210162739.30159-6-pvorel@suse.cz>
In-Reply-To: <20220210162739.30159-6-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0af1b4d7-f267-48cf-5a38-08d9ed1dc43d
x-ms-traffictypediagnostic: OSBPR01MB2501:EE_
x-microsoft-antispam-prvs: <OSBPR01MB25010089F54A9112B11892D1FD309@OSBPR01MB2501.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4LwoMH/zsurrWdvu64G3iVoH/VNNGHU1IRTtjd6u/8mbY9D1llr8gonSf1Ijkm1eModbxxfTwtE137tBGnPeJQxJv9Nfyr1WRnKsy+BymDH4cupCXnT3nE784Jmd03nyOCkQ0JLMKP9nvodwLq3XOWv05yrCXzlnnW3Zye9x4bEsuoI9GIs/nuw3tJYRBhPty/WVCr4SQTwoaTDrNUb8bnuW8Hs8WcF5dMf8Jq6AOYMj7m0ZNUOZ4V3r2+E6HVu5bH7c2tQtChs4TNNTMd2ZELiyCGcRrHZj1+RkQwzoV4uUkODYM2Gzdie+s0Dk6gmFcYRaviICn7+eqFgD4wl10173NSbr3oKqn3hJCN7ZnJwGYURjgVJqyvc1l0hc34jPl1kAFOR6bCVANyckQnErqTDlMQ6IL5GVPXsOLLEawdlLNKwNw2W9P0b4yrd1iKFZKp6seDRVPGYZp0nBBy1ppTD5GlP8GKFOsNiGPdWZkkxuZdya1Wu92z0qeseAjbqGzoMwXEaKyIvAF+EjEtw50dNJRUYuc9nVvoDHD7DqwoqI+bDte/+OwDmu2i6TaiAfo0CEixiqGQQ77j/meS8mjxfh6eGKlk0UQ7wtwqTNBLdGG/zk6L0VOjibhGBE1bSYIHplwqE0eWIaCPeqNJx3B3MWkQUJmJGZAPN/iTZ0goQL5L/+wImV1EqQ0JbC/Fm+MsvEM56U8liHPoxEvfQ/Xg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(186003)(26005)(2616005)(6486002)(33656002)(87266011)(6916009)(316002)(54906003)(6512007)(6506007)(508600001)(82960400001)(38070700005)(122000001)(38100700002)(86362001)(83380400001)(66446008)(85182001)(5660300002)(66556008)(66476007)(8936002)(4326008)(64756008)(8676002)(91956017)(2906002)(36756003)(66946007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eW95dEJxNTBiU2UwVGxHNjV0TlpaQUh0b3h4KzErQWllK2dUUnI0c0hQajIw?=
 =?gb2312?B?MWNoMzRWYnduSDFtYkNheE85eUhQRXVJZ3lBR2wwRktrMVMzTWM2MGgyMmRF?=
 =?gb2312?B?cDdVelZCVHFEeCtUcnhsamJiMFBIVlJyaW5BdmFNbGNlSzlMYXI5WGs2ZGNt?=
 =?gb2312?B?aDJKTnM4VlQvYkhyK21mL1A3QTNHT1ZjVDR1RjZ2TDRoci9jQkxkcGROTzd4?=
 =?gb2312?B?dFRYZFRQOXFxY3lsVU5kWis2MmZ2bGpzZ2srSC9xT0NTSzNLenRGaFE0cmw5?=
 =?gb2312?B?UHVJbUJUU0kvZFQ1NHdEUTl6MUlzbDhnNGJ1cENDRHpDbHBHaWhTRWNVQkNS?=
 =?gb2312?B?MG1NVXo3N3JjVkdHT3RaWW45UGIyekxFcU1CTFZKRjc0RGt6YnlxS1NqSUcy?=
 =?gb2312?B?c3d1clZmRXdOMzZwZmhxbkIrMmEzaHpBT2NKbEJvNkJkWk8wNGNRM0plTnha?=
 =?gb2312?B?VFg1VVZ6QlZIRjBMM0hIdXB0TEs0M3k2ckJjTGdqU1ZDWUxxRUlyaHY4U1RC?=
 =?gb2312?B?aTdORldHbzNSNUg0K1FGRHpKVU0yWjhzTGExcjlzUzFtK094cUNzeEN2MXNQ?=
 =?gb2312?B?THFwdDBoMTdodHFFditGcWFjQzhpS2laNTdGOEhyMmRpZVk3R3htNVRHZCta?=
 =?gb2312?B?VTJvSzBaSWxvaXZkc09idjhWMTRqZk05WTFWU0M4ZzNpdm9xbjNFYXVNZUtY?=
 =?gb2312?B?T1pGSjdFY1BLT010SGVHcFljdzB1Umx1TGREYWNYR1pPeU9VUUZoS3k4U3Nu?=
 =?gb2312?B?cDlJSXdVS3B4U2Y0MGp3SHJvb3JkOXdMNkd5ZXg2Tkt2d2RKRVBJK2s0bEZN?=
 =?gb2312?B?N1Fkei8vVnFXOFllMlg5Ykh0Yk82eCt1RW9MVHpJM1ZneEkzblhLSVdUT2Z0?=
 =?gb2312?B?TzFoc0FhSEx0KzNoaTN1czVzK0hqa21mcTYvRlBYQnRiOVVCRHlURUkxMWFZ?=
 =?gb2312?B?NGdLSFBVUk1rck8zaFdsejVJUFhCK1BEN3BENVd5VkRLNVB0R2U5TG56eFcw?=
 =?gb2312?B?V0FpcGVnVjlVV01UMUFxK21zSldKQmk1SXRuOUpNT0lEeXYveitPWUZBV0tZ?=
 =?gb2312?B?ZW9aVEJva0Jkdy9vQWlIaGQ4MnFjZ25qSzdxalVaUVFtSm4yaGNUa3Y2c2Jv?=
 =?gb2312?B?cVdsOWlac0NGRTM3UVFPVVhFYTVka3JNWGxJbXVScVVtQWdYU0dWZitpZFpK?=
 =?gb2312?B?dHlPdWQraVZKWDhUVGpDTSs2QlJRblNaRC9Wbmx4c2QwbmhnS2xMblRRcTJP?=
 =?gb2312?B?SUhyRmE3OVJQWitJSS9rUlhGbWZFTTdXS0YyT2JXazB1Ylh3azA5K3lWeCth?=
 =?gb2312?B?V0lTbExjVEs2OTZWUzFCeloycksxQ1duQTM2RWJaOGdudmpVcnViMy9zQW9V?=
 =?gb2312?B?Z3g3QzNYRlBPQTQ2b2NIcnE4bWtDWU90MlJPWFIxcEVvRlplVUZJdkRuT3NY?=
 =?gb2312?B?WitobWpiOUMwNUdOeWJFak5mekRuQ1B0bmU3bFVvRW9ROVFveEtsdGNuTngv?=
 =?gb2312?B?RXY0aC9GS3VBak9OTUFXNG4vcXhxNVBZQlY5UDg3dmZIY0xrZUYvQzdtYTlp?=
 =?gb2312?B?V3BYQXp0WitYY0l5TThzeklvR2NvaWRpZ0Q3OEdDNUJHZCtOUldwd2N4SmFn?=
 =?gb2312?B?Y3NmSXN2NDV3N2oxNGgvUUtURDNOWktmTHZBWTFRRWppL0RiU1lZUHBCQnk2?=
 =?gb2312?B?a2RML1hleEZzYUhkRDE0MVVYODRXRGUxNkVtbEREYVdYL1ZoMXpBangwNkVZ?=
 =?gb2312?B?WWdJU0VIaHRkTnRMSDArR1BxRUV0aWRUM0Y3ZGx1UTNTTVNRYnBBNEpxaWFs?=
 =?gb2312?B?WWtuUGd0ZEYxb0p2Q3E3dG8yWmxjZ2c5cTY4U1JFQmNrZTA2Z0l0NUtjNVdw?=
 =?gb2312?B?NlorTWdSVFV0WHRiNnFzdXBhME9MWUpvZmFKdFlQTnUzaURMdWRJempPVEZ6?=
 =?gb2312?B?dVFMQ25DTC9ZaTRFRjMrQlNCaTVLYmZjQ1dFUWVMTHNRZGhMQlRvRDFKUTZN?=
 =?gb2312?B?UzBUdXdSUitGMGVNV01ybkgyazExQ3dNSXR4YTltSmliUExsL2xlNVRQK296?=
 =?gb2312?B?aEo1SVBUZnFwdWRUSUJDSVdJWWJUVnBNNENZVFkyd1RsZkE5YWlsTWtCeVBu?=
 =?gb2312?B?Zmh5VSttSDYwYmFzT0F1akR1aG0zUm02TzB2dWxiQkwyZi9xQW1obmxGSGtT?=
 =?gb2312?B?NXl0Qm8raDdleXI5WVJSNldsalFrby9LSGNoczhTL3ArK2p0dGJNUVV1NWZ3?=
 =?gb2312?Q?lRtwqpVgbhA49mBZGn2unADUe94CLEKEXFPHDT7XZg=3D?=
Content-ID: <A7D21DD7399A8342801C40B07B041FE3@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af1b4d7-f267-48cf-5a38-08d9ed1dc43d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 05:17:15.1044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tc5h2AXD6usZ+dOE7LsOQjKafcIhC525tmBLqFHJK6h58ctoqbPaRVOTPsEpUWy8ITENu+jfu4uPtw4Ti9LVflNN3Y0AtREYCxAOV5sLjUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2501
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/6] shell: Add test for TST_FORMAT_DEVICE=1
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

Hi Petr
> Unfortunately GitHub Actions don't have loop devices, thus cannot be run
> in CI:
> 
> tst_format_device 1 TINFO: timeout per run is 0h 5m 0s
> /__w/ltp/ltp/lib/tst_device.c:139: TINFO: No free devices found
> 
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
> Same as in v1
> 
>   lib/newlib_tests/shell/tst_format_device.sh | 24 +++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>   create mode 100755 lib/newlib_tests/shell/tst_format_device.sh
> 
> diff --git a/lib/newlib_tests/shell/tst_format_device.sh b/lib/newlib_tests/shell/tst_format_device.sh
> new file mode 100755
> index 0000000000..b02f8b122b
> --- /dev/null
> +++ b/lib/newlib_tests/shell/tst_format_device.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2022 Petr Vorel<pvorel@suse.cz>
> +
> +TST_FORMAT_DEVICE=1
> +TST_TESTFUNC=test
> +TST_CNT=2
> +TST_DEV_FS_OPTS="-b 1024 -O quota"
> +TST_DEV_EXTRA_OPTS="5m"
> +TST_NEEDS_CMDS="df lsblk"
> +. tst_test.sh
> +
> +test1()
> +{
> +	tst_res TPASS "device formatted"
> +}
> +
> +test2()
> +{
> +	tst_check_cmds df || return
We have checked df command in TST_NEEDS_CMDS, why still check it again
in here?

Best Regards
Yang Xu
> +	EXPECT_PASS "df $TST_DEVICE | grep -q /dev"
> +}
> +
> +tst_run

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
