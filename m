Return-Path: <SRS0=5Ww9=PQ=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438CEC433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Oct 2021 02:19:22 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A1F60C4B
	for <ltp@archiver.kernel.org>; Thu, 28 Oct 2021 02:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30A1F60C4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60BCE3C6AAC
	for <ltp@archiver.kernel.org>; Thu, 28 Oct 2021 04:11:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33C013C5991
 for <ltp@lists.linux.it>; Thu, 28 Oct 2021 04:11:17 +0200 (CEST)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4F8D82064F1
 for <ltp@lists.linux.it>; Thu, 28 Oct 2021 04:11:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1635387077; x=1666923077;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=vEkVZB0ZI6dU/oZHAUG4gR5hTKn6LqfBrmPzfiTCRWQ=;
 b=J+vQJTO7U6GJj8aWpF6KDzA/Vs8j9PTMn/NagJgIX/kFrruW4ihs+BJB
 Hswcb5Psb7IzLPoGDDwpq8YcEpkUdkYeJdOFu28E0CRXMXVa2zVju+BdX
 muB63NrMUsp4rjMwYF7/KOpGNge5dJN4Sj5pL7g87WJLgKpBQU/AV33oe
 AttdIf0t+LbQCbsNxtv9WeiI7Sm+cWROSrVHMVc74tr7ygYJ6kzZMioTA
 JRXTvDRbJQjcZe/hWvPB6g63VgETdH9fmvm/MMkBxbveB/SUTkJ6p6w0X
 EsnZXVo1pCuiYSyJN5Ga88mqn0dbd3OtKOWk3WQx1TvRJLN0MWM+EvtYC g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="42319957"
X-IronPort-AV: E=Sophos;i="5.87,188,1631545200"; d="scan'208";a="42319957"
Received: from mail-os2jpn01lp2059.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.59])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2021 11:11:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLYD7WmZ9U1o2LfDQPpWcV4Jc8pvMQxqvbhjAQIDfEfnMAsOAjtrGzHoZ2skXpeXsQh6abUSVO92nq0NTwfXntKaKx27UlW/I3Q8OpHKUsrhK7RLGrbttIcxOrsOujtc8O5+BYreN2//dXibPe+ttQn2ecspL6yiccis9LQRzCRTkB+BRPmZvXKtaDlg/1sFDTc7j++xSYK9DhouHXDTi+Swn6bXTJ2OJiEIzLO3ETxY3k4DgL1h/smRTfiESo/XUjNKWG+dGMaCKi/B5KE6946nn4XXAOqXLKxhkR0sqJfG0HNEgdUREf2yIV9xcjVeycP/gYgemaBAp67Ygsyg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEkVZB0ZI6dU/oZHAUG4gR5hTKn6LqfBrmPzfiTCRWQ=;
 b=fTxfpeyCgGezMkXlqry3/C5mRW2/qkpaKCjrrjBdy4J2w8PuF2tqTTYPAAYj1aDBGp0nEMbpEg7zMim+cYAmd82P7tlD3FTnRLopM0FTyVgp8cfDSytKs5WaWBUJWYDTGBpUcfsToyK4ExDqa84PHOFj5Qz+S8cs9eaCIpr5dz4/5dZsqc/6+Qn1s2XlbToXymn9O7AAwRrpM4FJpS+PFRFopz6gW10efy08FrfaYPmSniZKTtPH32o4No6zzgWDP/a4Yu2F+1682BHSxOWesABtkILhgf53E6KQCl2XFqkUEOTh/PEEDRglcgm8FnX/mHZfA6foNJ6sztW6h/mQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEkVZB0ZI6dU/oZHAUG4gR5hTKn6LqfBrmPzfiTCRWQ=;
 b=oPc9I92UofbEBvXxsiLy2HY6fURQPt04ASS+Z45gejnJboyKx0Wth0OjyeHr13lEBsHk65FQX28UZWtOmM3U6iNPpf4kU5icRnzUFiUIMg6f0v7AqnN4MQadPSSD/NvgLGGCl/1fJF03JrfWn4JUFiMKV+U+iQTCRmkFM5yBokY=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB2938.jpnprd01.prod.outlook.com (2603:1096:404:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 02:11:10 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9%7]) with mapi id 15.20.4649.014; Thu, 28 Oct 2021
 02:11:10 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [PATCH v2 07/13] syscalls/quotactl08: Test quoatctl01 but quota
 info hidden in filesystem
Thread-Index: AQHXyy4zZEpMR6eboUS+T1P5riBDv6vnq9AA
Date: Thu, 28 Oct 2021 02:11:10 +0000
Message-ID: <617A06C4.5000001@fujitsu.com>
References: <1635337706-4788-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1635337706-4788-2-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1635337706-4788-2-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a65f2c73-538a-4400-ee5d-08d999b835ed
x-ms-traffictypediagnostic: TY2PR01MB2938:
x-microsoft-antispam-prvs: <TY2PR01MB2938FB7454CC58ED0623F554FD869@TY2PR01MB2938.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:127;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uMtW1d87hC+L4HKNYwCnKjalRhCyxbNwzn1bt+SgvPWFWBjJpleSLSyb4+MSWMMYgxcG8zYrg2nGrB6ndI7whTxzwWNf5R0UrPDwIBeil6Va+/Zos/wCjMqrq/ynPbUHfUsa3v26oFosSWVF8Ym0lla21XUUF99pPr5OspOA2qrzFYB9eAIQNbB7rDqZIHoNBRSiWVYhn1cUk4QmH+YkmHI2paw9njhCY5RedwsqeaH0M1BA+z9kX0ZkbcLoHtTku2vC5dH9RRkKcw2IcIqpCzLOKIl/bhnVSWUOAaH6GAc9ugJfMe5K/UZImUPuUqtgCAV0qjGPMmyse1XxEnGvieNRHEkDfqSUG+AmxB57iTJvZkYhxbn80a1IQ51PvfH0hNTMpJHaKgYfwY3JdH6xy9zOAHa6UVRZglGeGiIDcUcAUSbM84FrgdwgmQBOZPS/wwQOK/mqnl8kLsCUP9XOOc8QWGfDkaAYrDs5TljqivZ4N+u3hXqcvDi0rrOufopkIJqMl8RM2RpchzU3d4VlgPl7xy4TPRS5DD9FKZtzyv33vcYETfOoLckj0s1E5TzyJr1+jGBAdULUehGpMcKwSFbMCv9Lzv/rZxO1QoOCQR4cXQb9l5OdexitVQtl3PpsHH8GCFY1jfAndN/y9Onnegkuow0qIjQD9KoM+Mr4qEdLYF+y+SQDuf6lPwGDc53gZOuVecKGCOWNuyjIawtMhT2+8z2BAq4q/IvDLvA++H8r3GdCezj0iy8sgCCh90UkXCZWqwdTCXmDwknFsO20feFNpN8GB1EfH7x1MzOuYfI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(26005)(15650500001)(66476007)(66946007)(38070700005)(66556008)(66446008)(186003)(76116006)(4326008)(82960400001)(5660300002)(91956017)(30864003)(508600001)(2616005)(6512007)(86362001)(33656002)(16799955002)(316002)(6486002)(36756003)(83380400001)(8676002)(8936002)(38100700002)(6916009)(2906002)(122000001)(71200400001)(85182001)(6506007)(87266011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?azY0cGdLRFJ1Vld0ZmNCOG44S0RiaThVbFdiUkZqZnc3TVVqTXBJU05UbW43?=
 =?gb2312?B?V3RKamgvVWM4RWNROVdlb1FGdk54SWNiUUM5U3lvVldXOTJ6UlV3S3FvM1kr?=
 =?gb2312?B?bExvVk5SQm5NUnByYjgxQlhPTVIvNHp6NnNBRnVXRXhIdnorZ284R1AwcjIz?=
 =?gb2312?B?Ykk0UVkyN1NvTzFnalZONXFzYW9SNHBLSDNjWWFmUG83cDI5WkNhNVZlUkJ4?=
 =?gb2312?B?SFZ1UnpIdGp3RUUvVmRVRVp6R2gzRWt1QTdSWDdrdjZoMzNoQUZtZU03b1Bs?=
 =?gb2312?B?blFLL3NiUUxYaGxubmlRVE5oL3E4MFBHekJPcUlQQmk2cW5SdTl3cmdjTmF3?=
 =?gb2312?B?bjN5VTZ0Nyt2OU1iRTRwY2htajhFK1U5bllpTmtWdFkvbm9XOFZIMUZXSTY2?=
 =?gb2312?B?U0ZTdlRqWWo2M0RWdnZDcWIxTWV3dXd2VmUyRDZiUm1Cdnd1SmIzbUUzRFlB?=
 =?gb2312?B?SmlqaXN2bk5YTi9KK2dZamNPZTlrN05SWTN4WXFSUitZL282SmdFZGoxOTFV?=
 =?gb2312?B?bEZzM285VlhwVG44SlpIeEhVRUdaZlZSaFhFSlp3eUVOQ2ljbDNiSTk3aXhT?=
 =?gb2312?B?YUxsczNQcGFoSGNnVlVvaXlmYmVBdnVUQTFTd2xvSlhneThWdC8rcjZTSi9n?=
 =?gb2312?B?VCtGN3hlem9YeFpjYkhWb3FPbXdJUDZmaWtRbytBSEY4NVAra3Z4TTVHcEI1?=
 =?gb2312?B?UDc5T2k4Zy9kUC9yalpJMi9jTGNXeCtIS0NtUkN3ZG1VaVhBUUFoTEJSM200?=
 =?gb2312?B?QlFBd0J1TUpGSGZ3Sy9CRlIyd2IxYWJ3VGNQcWRhejBtcFRBbmdGSXZocXA5?=
 =?gb2312?B?ejFvN1ExeStTcHZTMlh0eEg2VnlEM0kxNVAvSkdVQ20xTXRmZDk1RWZ1SGw0?=
 =?gb2312?B?Ykg4L1oyaUxGUHQxNThjMlAwck1TQVdpR2FVSFlLdlFiQzl1ajI0V3dZQjdL?=
 =?gb2312?B?NHRUd2g0UHJuaDdMdWw3VlRCdzZHMGlrbkVYK1dUVWQrOVR4YjBpVTl1YlA5?=
 =?gb2312?B?Z010QUZCZ0hJK3dwWkpmQ21ITTBHekg1aDZxTzZTVEFVais5OGphOWRZbE9O?=
 =?gb2312?B?bisrdmNWT1J0Y0ZKeEhsNzF6eG5aaHNaYkJmYmZGWVZFRGtiVTBmd2ZQNTFk?=
 =?gb2312?B?RTBRdTJLanpvRWVKL1lqM1NzSmIrVzFHUHJwdmpqand6NzlxNU8xWWdGWGtz?=
 =?gb2312?B?N2lwc0RnQWRZcDM4SjBGczF0bmt2bEZDb1g1TEp1eWtwY1lTZC9hS1RVdTRO?=
 =?gb2312?B?UVRMY2cyOXRmeWtlQjJ3RnlOdnYrRDJDeVBYbUJKbTlsYlQyd092V2NmbWli?=
 =?gb2312?B?SDNIM0kvaG4rcVhFa0RQMHVJZXNWdDNTWFdFYnBkdk5aRE1GdTZMSlNWSmJ4?=
 =?gb2312?B?SXlWbFFRNXd6U3FpNGVucHBYUlVuTm9CcmFjMjhFa2Z4UzNKOFdRUld5dXRa?=
 =?gb2312?B?eW9pSDZHczlmSUsxY1JyV1RVVWxwenR4cVhVREFHdnBaYXBlL3YzRy9LVnV2?=
 =?gb2312?B?NDIvOUh2M3pBVVoyK0VCd1BIT05XeFFiVFdWa25aTGdvbkdSZXJVbFZ0YlF2?=
 =?gb2312?B?dGN5SGpWZlNnUVRQdGxjYW5jdUxqek0vdk1VV3lLbDFTNmtjVjRrdmU3VHJZ?=
 =?gb2312?B?c2crOXhKUE0wNTFOOHhIOWY2UVYzTFZRUGhSUWJTVHAyNC94NkdiMXp5Q21C?=
 =?gb2312?B?TFhqZGNsNWcxQTV6Yk1EdkQwQ0ZFRlNxK0h5Z1lBUy9QODI0bEYrVXRVUmp0?=
 =?gb2312?B?dzZ5dTliVVBzS2xZVHVNL0VhSGtadk1EUHpHN21BM3ExK1lmUjJ3azAyUTFi?=
 =?gb2312?B?TU9UbXdKNWFHL3RtMHdKdlVzUDRxZ0twMjNpZ0p5WktBdExLTDJzUmxsc2VB?=
 =?gb2312?B?dFVnR296dzZkakJNaUg5VjZKY3FaejJPMVFwS2hWcEhPYmRaWEZJNHdpNDFs?=
 =?gb2312?B?ZnVIWG9PVWFkTDcrMjNYRlJzbnhtSk1kenZrQlVrdVNkWFdnMGE5SktjaW9n?=
 =?gb2312?B?WHpKV1VYdkM5ZFhHL0t4dC9sUWg0NkJSVldHeWk1bXpzYWtMV2x4dkp6K292?=
 =?gb2312?B?bHZMWnJOb2ZRZnJjS2V4MnBQODVVeVlPUTQwQ1g3MnBzRno4YUpnSEJkbm1k?=
 =?gb2312?B?OHFGbW05MTh0RHRnSFRXTmMvTmNYSlVSL3FsejJRMWpxaUhlNFdXWnNsVGpp?=
 =?gb2312?B?ajl5Wk14VHBiaExSYXJnWTVkNitCRTlzd3J2dFRYYmRGWjM0VmE3anlyZUo4?=
 =?gb2312?Q?yJB9GEj9ZHr8edlG50iZ2pMxBhgJPQNAkkSw0Qp9N8=3D?=
Content-ID: <15FE66D603EA2244B32B0DC032E0A82D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65f2c73-538a-4400-ee5d-08d999b835ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2021 02:11:10.6945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0o+ow/+2pJ3UIYCjwLcQmgKGFA75ekNusL2eLpA70XikD/kfpIEh+M3+eKSB54woJGKhWaSYOM9CVdS+LSf9OBCxduGKPGa6Y3JR/8VJkT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2938
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 07/13] syscalls/quotactl08: Test quoatctl01 but
 quota info hidden in filesystem
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
> It uses two variants(quotactl and quotactl_fd). The difference for quotactl01
> is that we don't use quotacheck command and quota info hidden in filesystem.
> 
> It also needs mkfs.ext4 supports quota feature.
It seems this feature is disabled[1] before e2fsprog 1.42 when not
specifying a  --enable-quota option in compile-time and e2fsprog 1.43
remove this disable[2].

ps: I will add this check like quotactl04.c when the previous patches
are merged. So it doesn't make much noise instead of sending a v3 now.

[1]https://ext4.wiki.kernel.org/index.php/Quota
[2]https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/commit/?h=v1.43&id=9e8fcd6e

Best Regards
Yang Xu
> 
> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> ---
>   runtest/syscalls                              |   1 +
>   testcases/kernel/syscalls/quotactl/.gitignore |   1 +
>   .../kernel/syscalls/quotactl/quotactl08.c     | 217 ++++++++++++++++++
>   .../syscalls/quotactl/quotactl_syscall_var.h  |  29 +++
>   4 files changed, 248 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/quotactl/quotactl08.c
>   create mode 100644 testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index b19316805..cdeb3e142 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1073,6 +1073,7 @@ quotactl04 quotactl04
>   quotactl05 quotactl05
>   quotactl06 quotactl06
>   quotactl07 quotactl07
> +quotactl08 quotactl08
> 
>   read01 read01
>   read02 read02
> diff --git a/testcases/kernel/syscalls/quotactl/.gitignore b/testcases/kernel/syscalls/quotactl/.gitignore
> index 8d2ef94d9..dab9b3420 100644
> --- a/testcases/kernel/syscalls/quotactl/.gitignore
> +++ b/testcases/kernel/syscalls/quotactl/.gitignore
> @@ -5,3 +5,4 @@
>   /quotactl05
>   /quotactl06
>   /quotactl07
> +/quotactl08
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
> new file mode 100644
> index 000000000..6912378f1
> --- /dev/null
> +++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved
> + * Author: Yang Xu<xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + * This testcases checks that quotactl(2) on ext4 filesystem succeeds to:
> + *
> + * - turn on quota with Q_QUOTAON flag for user
> + * - set disk quota limits with Q_SETQUOTA flag for user
> + * - get disk quota limits with Q_GETQUOTA flag for user
> + * - set information about quotafile with Q_SETINFO flag for user
> + * - get information about quotafile with Q_GETINFO flag for user
> + * - get quota format with Q_GETFMT flag for user
> + * - update quota usages with Q_SYNC flag for user
> + * - get disk quota limit greater than or equal to ID with Q_GETNEXTQUOTA flag for user
> + * - turn off quota with Q_QUOTAOFF flag for user
> + * - turn on quota with Q_QUOTAON flag for group
> + * - set disk quota limits with Q_SETQUOTA flag for group
> + * - get disk quota limits with Q_GETQUOTA flag for group
> + * - set information about quotafile with Q_SETINFO flag for group
> + * - get information about quotafile with Q_GETINFO flag for group
> + * - get quota format with Q_GETFMT flag for group
> + * - update quota usages with Q_SYNC flag for group
> + * - get disk quota limit greater than or equal to ID with Q_GETNEXTQUOTA flag for group
> + * - turn off quota with Q_QUOTAOFF flag for group
> + *
> + * It is similar to quotactl01.c, only two difference
> + * - use new quotactl_fd syscalls if supports
> + * - quota file hidden in filesystem
> + */
> +
> +#include<errno.h>
> +#include<string.h>
> +#include<unistd.h>
> +#include<stdio.h>
> +#include "tst_test.h"
> +#include "quotactl_syscall_var.h"
> +#include "tst_safe_stdio.h"
> +
> +#define MNTPOINT	"mntpoint"
> +#define TESTFILE	MNTPOINT "/testfile"
> +
> +static int32_t fmt_id = QFMT_VFS_V1;
> +static int test_id, fd = -1;
> +static struct dqblk set_dq = {
> +	.dqb_bsoftlimit = 100,
> +	.dqb_valid = QIF_BLIMITS
> +};
> +static struct dqblk res_dq;
> +
> +static struct dqinfo set_qf = {
> +	.dqi_bgrace = 80,
> +	.dqi_valid = IIF_BGRACE
> +};
> +static struct dqinfo res_qf;
> +static int32_t fmt_buf;
> +static int getnextquota_nsup;
> +
> +static struct if_nextdqblk res_ndq;
> +
> +static struct tcase {
> +	int cmd;
> +	int *id;
> +	void *addr;
> +	void *set_data;
> +	void *res_data;
> +	int sz;
> +	char *des;
> +	char *tname;
> +} tcases[] = {
> +	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, NULL,
> +	NULL, NULL, 0, "turn on quota for user",
> +	"QCMD(Q_QUOTAON, USRQUOTA)"},
> +
> +	{QCMD(Q_SETQUOTA, USRQUOTA),&test_id,&set_dq,
> +	NULL, NULL, 0, "set disk quota limit for user",
> +	"QCMD(Q_SETQUOTA, USRQUOTA)"},
> +
> +	{QCMD(Q_GETQUOTA, USRQUOTA),&test_id,&res_dq,
> +	&set_dq.dqb_bsoftlimit,&res_dq.dqb_bsoftlimit,
> +	sizeof(res_dq.dqb_bsoftlimit), "get disk quota limit for user",
> +	"QCMD(Q_GETQUOTA, USRQUOTA)"},
> +
> +	{QCMD(Q_SETINFO, USRQUOTA),&test_id,&set_qf,
> +	NULL, NULL, 0, "set information about quotafile for user",
> +	"QCMD(Q_SETINFO, USRQUOTA)"},
> +
> +	{QCMD(Q_GETINFO, USRQUOTA),&test_id,&res_qf,
> +	&set_qf.dqi_bgrace,&res_qf.dqi_bgrace, sizeof(res_qf.dqi_bgrace),
> +	"get information about quotafile for user",
> +	"QCMD(Q_GETINFO, USRQUOTA)"},
> +
> +	{QCMD(Q_GETFMT, USRQUOTA),&test_id,&fmt_buf,
> +	&fmt_id,&fmt_buf, sizeof(fmt_buf),
> +	"get quota format for user",
> +	"QCMD(Q_GETFMT, USRQUOTA)"},
> +
> +	{QCMD(Q_SYNC, USRQUOTA),&test_id,&res_dq,
> +	NULL, NULL, 0, "update quota usages for user",
> +	"QCMD(Q_SYNC, USRQUOTA)"},
> +
> +	{QCMD(Q_GETNEXTQUOTA, USRQUOTA),&test_id,&res_ndq,
> +	&test_id,&res_ndq.dqb_id, sizeof(res_ndq.dqb_id),
> +	"get next disk quota limit for user",
> +	"QCMD(Q_GETNEXTQUOTA, USRQUOTA)"},
> +
> +	{QCMD(Q_QUOTAOFF, USRQUOTA),&test_id, NULL,
> +	NULL, NULL, 0, "turn off quota for user",
> +	"QCMD(Q_QUOTAOFF, USRQUOTA)"},
> +
> +	{QCMD(Q_QUOTAON, GRPQUOTA),&fmt_id, NULL,
> +	NULL, NULL, 0, "turn on quota for group",
> +	"QCMD(Q_QUOTAON, GRPQUOTA)"},
> +
> +	{QCMD(Q_SETQUOTA, GRPQUOTA),&test_id,&set_dq,
> +	NULL, NULL, 0, "set disk quota limit for group",
> +	"QCMD(Q_SETQUOTA, GRPQUOTA)"},
> +
> +	{QCMD(Q_GETQUOTA, GRPQUOTA),&test_id,&res_dq,&set_dq.dqb_bsoftlimit,
> +	&res_dq.dqb_bsoftlimit, sizeof(res_dq.dqb_bsoftlimit),
> +	"set disk quota limit for group",
> +	"QCMD(Q_GETQUOTA, GRPQUOTA)"},
> +
> +	{QCMD(Q_SETINFO, GRPQUOTA),&test_id,&set_qf,
> +	NULL, NULL, 0, "set information about quotafile for group",
> +	"QCMD(Q_SETINFO, GRPQUOTA)"},
> +
> +	{QCMD(Q_GETINFO, GRPQUOTA),&test_id,&res_qf,&set_qf.dqi_bgrace,
> +	&res_qf.dqi_bgrace, sizeof(res_qf.dqi_bgrace),
> +	"get information about quotafile for group",
> +	"QCMD(Q_GETINFO, GRPQUOTA)"},
> +
> +	{QCMD(Q_GETFMT, GRPQUOTA),&test_id,&fmt_buf,
> +	&fmt_id,&fmt_buf, sizeof(fmt_buf), "get quota format for group",
> +	"QCMD(Q_GETFMT, GRPQUOTA)"},
> +
> +	{QCMD(Q_SYNC, GRPQUOTA),&test_id,&res_dq,
> +	NULL, NULL, 0, "update quota usages for group",
> +	"QCMD(Q_SYNC, GRPQUOTA)"},
> +
> +	{QCMD(Q_GETNEXTQUOTA, GRPQUOTA),&test_id,&res_ndq,
> +	&test_id,&res_ndq.dqb_id, sizeof(res_ndq.dqb_id),
> +	"get next disk quota limit for group",
> +	"QCMD(Q_GETNEXTQUOTA, GRPQUOTA)"},
> +
> +	{QCMD(Q_QUOTAOFF, GRPQUOTA),&test_id, NULL,
> +	NULL, NULL, 0, "turn off quota for group",
> +	"QCMD(Q_QUOTAOFF, GRPQUOTA)"},
> +};
> +
> +static void setup(void)
> +{
> +	quotactl_info();
> +	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0666);
> +	TEST(do_quotactl(fd, QCMD(Q_GETNEXTQUOTA, USRQUOTA), tst_device->dev,
> +		0, (void *)&res_ndq));
> +	if (TST_ERR == EINVAL || TST_ERR == ENOSYS)
> +		getnextquota_nsup = 1;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd>  -1)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static void verify_quota(unsigned int n)
> +{
> +	struct tcase *tc =&tcases[n];
> +
> +	res_dq.dqb_bsoftlimit = 0;
> +	res_qf.dqi_igrace = 0;
> +	fmt_buf = 0;
> +	res_ndq.dqb_id = -1;
> +
> +	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
> +	if ((tc->cmd == QCMD(Q_GETNEXTQUOTA, USRQUOTA) ||
> +		tc->cmd == QCMD(Q_GETNEXTQUOTA, GRPQUOTA))&&
> +		getnextquota_nsup) {
> +		tst_res(TCONF, "current system doesn't support this cmd");
> +		return;
> +	}
> +	TEST(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "quotactl failed to %s", tc->des);
> +		return;
> +	}
> +
> +	if (memcmp(tc->res_data, tc->set_data, tc->sz)) {
> +		tst_res(TFAIL, "quotactl failed to %s", tc->des);
> +		tst_res_hexd(TINFO, tc->res_data, tc->sz, "retval:   ");
> +		tst_res_hexd(TINFO, tc->set_data, tc->sz, "expected: ");
> +		return;
> +	}
> +
> +	tst_res(TPASS, "quotactl succeeded to %s", tc->des);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_QFMT_V2",
> +		NULL
> +	},
> +	.test = verify_quota,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.mntpoint = MNTPOINT,
> +	.dev_fs_type = "ext4",
> +	.dev_fs_opts = (const char *const []){"-O", "quota", NULL},
> +	.mount_device = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
> +};
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h b/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h
> new file mode 100644
> index 000000000..92a7c45db
> --- /dev/null
> +++ b/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu<xuyang2018.jy@fujitsu.com>
> + */
> +
> +#ifndef LTP_QUOTACTL_SYSCALL_VAR_H
> +#define LTP_QUOTACTL_SYSCALL_VAR_H
> +
> +#include "lapi/quotactl.h"
> +
> +#define QUOTACTL_SYSCALL_VARIANTS 2
> +
> +static int do_quotactl(int fd, int cmd, const char *special, int id, caddr_t addr)
> +{
> +	if (tst_variant == 0)
> +		return quotactl(cmd, special, id, addr);
> +	return quotactl_fd(fd, cmd, id, addr);
> +}
> +
> +static void quotactl_info(void)
> +{
> +	if (tst_variant == 0)
> +		tst_res(TINFO, "Test quotactl()");
> +	else
> +		tst_res(TINFO, "Test quotactl_fd()");
> +}
> +
> +#endif /* LTP_QUOTACTL_SYSCALL_VAR_H */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
