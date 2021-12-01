Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE6EC433F5
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 01:07:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FC6D3C8E03
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 02:07:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71BF63C1810
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 02:07:34 +0100 (CET)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D5D73140015B
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 02:07:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1638320854; x=1669856854;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=iteIZjO08YdSt9YMdV1DbNh9IqyTJ270a6fln84CyNk=;
 b=VkppmClYMnmYjK/COBmRhRXZC82ylRUSUxIXBLZCJLvM6TaJb2zaZ5+K
 lcwHtX0sm5hXmRe4/2N8FuH9ev3j6q6DxMNfRNRy0KhF/V5LtqeOGaLEm
 lQXaW5G/OyQrvf0hkRQoLG56QrUcJjTRPNhFz29rxMWp47p8kkq/8REsA
 QX4sFAEAGExfIKT4spFUIlSd4+sNK+hT8hDMT+4HgfcehuV9sd9l6Wedh
 lNxXez13UqHdW6RP6eKRKvOroGZF+ueK7/hPu/9tv7zJxSR7+iAXED9Eq
 +QILKPRxqbHaORPOETQ2FuLrgSxHFg5/uZolaH/L6IaoRGm6wE5RR/Al9 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="44886791"
X-IronPort-AV: E=Sophos;i="5.87,277,1631545200"; d="scan'208";a="44886791"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2021 10:07:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3McvlhHitPk39y/+fmQA2zrbiiKZ3n7oRZz3gRoi8sR17E98hoeWiLWmn46xytUyFZSSAAlWxL2bRRkWZJftE+X86GXFFDKvWE/6XYmoChWERjpDLIHDKhW/zY1bi27G+STr56F6TMHLRN7gbT1v5fMsccjBpBTHX4kaFDtrQuM3Ej2nCFncgft2OWEWsQ7mZvTV73TV+fXFMvlKm+l4rBZ/RqI7dWuyD5uga+F20d6iqDuMnGzjGKzvcyAczxhkz/bjnnvps4Swm5fgVzViXlpwOZ70S8tawwOHdmhss1GxDf5mhbXkrUyO9mZxjXRrC3n5rFGdl5xRiI/Upr70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iteIZjO08YdSt9YMdV1DbNh9IqyTJ270a6fln84CyNk=;
 b=nOTiuphvnxPEK7+MolkLRSxwOaQGXK3S1dl8sSYUsKGwYTsVeSb6J4MgNk6DdUGKZXYYfN/7mF7TuiflGJbqmmOEa9VtXTlBua4PisY+wFlqQpSedsVvP3U938jCJwyvm1tDE5j2RML38fO6cHEcoxCzNjLjMceGNRikN9OqmUg5GMoKouUluY1v7t5fPyIEoHHoQBz1bhN+6Sp/iR2yuqoTK0lq1W12vlhfCFfmOmuynpgzgS4kPXI17Yq9tT+Ur/6rF0jxAvb4eXHc4+SxId9NZBQRNcrROMoS/N6pca82RjnSCKqSNY+dzBJm4RyJj4K+GrunpJeBRqTrlosB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iteIZjO08YdSt9YMdV1DbNh9IqyTJ270a6fln84CyNk=;
 b=XQWcvJKeK+DcuFEklxmNKCcDpRQb+0RK5TAHRz8k60O5lVRxo0Txrqk03xC/th5X/yPowDhRXKmeuNixO80muawZbvs31s+iBFGIKfMRBJOfkBLGRPLrNPggIxOU1YQMxmsxhLCWUfuu1w5ok8VaOB52EiljSJmJMo36dYarKac=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYYPR01MB6841.jpnprd01.prod.outlook.com (2603:1096:400:d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 01:07:27 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 01:07:27 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: wenyehai <wenyehai@huawei.com>
Thread-Topic: [LTP] [PATCH] bugfix for vmsplice/vmsplice02.c
Thread-Index: AQHX5gMwYctPX6ZNekGcabS+j7HBJqwc06KA
Date: Wed, 1 Dec 2021 01:07:26 +0000
Message-ID: <61A6CAD9.8030102@fujitsu.com>
References: <1637972238-105160-1-git-send-email-wenyehai@huawei.com>
In-Reply-To: <1637972238-105160-1-git-send-email-wenyehai@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1724b47e-2323-4b32-f3fb-08d9b466f0e3
x-ms-traffictypediagnostic: TYYPR01MB6841:
x-microsoft-antispam-prvs: <TYYPR01MB68414C4CC32EB49AA58BF7ABFD689@TYYPR01MB6841.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: da+IUC8YsKJ+3Lb+NjBsFZCBdSwtQ0ijGnLaf9R50sAQnvGu8Wd++HfSvY8goUU85QvB2PHqwG/ZDs2gGUCBdnmR+Zo5CBmjCqN5/pzeKRh/k0BLR041iTlT0DO+yoziqv57CpJTiURlprRzyx899zmJwuqIcAM8w1DHIxPYIM4vZWsLSvj03ETHsy7f22BIPK2wKKBW10NN8KilGXGyJPDTrArqZP3zGmPaYVEYIzXue3NidYBDfvj7O+C9RG17xfCeisj1yfI/F9pLhN7fO83uBaJfdXFpnzH0ay61Lr3ZYNVK9R1cHLeS4SqCey/sgLD0G+t3N1bwAyLj0ZIs9oAtR6KsrB7clj5YPFQjsdZ77LtKKeBNNj/KNLVI1vN76k7AU7Q4EriLli0dXbDJW6vHwBa6wyAujPNHjD6VnaPN5cLyYod7zU977BC/OCUlQtUergStmnqBor02FAuUbezNT7JCVrgVhFBZyHvN/cC6jN171kRdXvumb24ZnGGKvlGT/tam8AN5Vt6V0r0GT8AkxkHnc1gat5QcRYrsYfoAwM9S3yPjiw7MhZOTiyUheVUM9BqhmChV8159ev+RpwrGW9Y7G38D9jwm/xBqXUpIiZnK79Eu423yZ6sjzFHnxkGkIpFPNhs1KYEWXjXXxj/skLFYHM2jc3XWXmgypZXOBb14cYMxz+OF1GvIewyi+jb3DeTlnmXbWxoGA6pGfg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(85182001)(186003)(83380400001)(8936002)(87266011)(82960400001)(26005)(2616005)(4744005)(2906002)(316002)(6506007)(36756003)(38070700005)(5660300002)(86362001)(38100700002)(122000001)(91956017)(6486002)(76116006)(71200400001)(8676002)(6916009)(508600001)(6512007)(66946007)(66556008)(64756008)(66446008)(66476007)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VTlXZStTM2c0NWI0WThxeGs1d0N3Um9HL2xRMVRwKzlpcTRPMytoeTJIcWUr?=
 =?gb2312?B?amRONGIrT3RBQkdzNy9DSzdISnBZdG93ZlpYR3dsV0ZvWS9peXlNMjdNd2Jn?=
 =?gb2312?B?RlovN3Y4eHRGU1hKOXFkUG1JQm5oeE5EU0RZd2lWV1loWGFRQXNPRk10ZEI5?=
 =?gb2312?B?d05sK3FDWGMrdGhVQkhkd2p0ODZuOGJCYjFrWkRKcnNPaHdUa2w5aGNINi9m?=
 =?gb2312?B?VlVSdjRuNmtLMFBHNkZtNTBqakNsTXFzUS90bEpzdUgzWmtCVW11dk5SUjBy?=
 =?gb2312?B?aUh4QmR3OWlrTWxGU2t3U2RiYzg4SStHRFdpdkd0TEFpS1VsYk1mcjZkdXNO?=
 =?gb2312?B?R1lSVnZMUFpxTzBhRDRXaElIcXRDYVlCQStxVytwNUlxSzQ3MWEyYktSOUtr?=
 =?gb2312?B?U3Bkd1IxSHMvOHhXd3pVWUFqNEdkbFNGQkFsN09YdlY1MjR4TVhNd0JCc3Rp?=
 =?gb2312?B?QU9yVDBwVlJjdVRybjdoYU82aGloanVqNkNjdVNURi8wbGZMMWJlUTJVYXdi?=
 =?gb2312?B?OXZlemdFaDlXeW1wQXk0VzFmcVNiY2trTDBaSmY4WVZxVzFVWllkWjM5K2lU?=
 =?gb2312?B?NlhrK01uaVBxaUJUVldFWFhlOUYvT0hYTVQ1dDMwV2JtNjV5WTZRdkNBV2My?=
 =?gb2312?B?eStRSnFvM0YxbGR2bmN3T2NFWFVEWDljN3NSV1p4SjRLR0EzMmZraDQ1Tndp?=
 =?gb2312?B?T0g0Z0ZiNFhZUklLNzBRTFN0RGIxWGZWYTd5S015N3dLeFEwdU1LcVZvUGlF?=
 =?gb2312?B?TkRKWkxhWVlJTElRWnVlTEwxZWJHbmlLYnNrVVNLdmZzQkxFUlprVVJHOHZo?=
 =?gb2312?B?ZGIxV3FnUmgrNEFRQlNwdlNHMUxDQlpqdHMvbDVpTjhHck9TT1NJaGF3VnVz?=
 =?gb2312?B?QmJQQUFRbzhVYWhqUTlteFpVMG1kdW1LQnVDaHk3aXNtWnVMY2J6S1VrWWlG?=
 =?gb2312?B?QjZjK0xhYU4wd1k2b1FYeEhkcXRBUGp4Y3lYeGF1K1lFMjE0T0VGS3FLQmRM?=
 =?gb2312?B?enhzdFVhWEY2dXdrUHEzL0NlSGVHSnc0bHJ3VVI0WEFOenVtL28yRnFWcWtH?=
 =?gb2312?B?SmZiejVoRzNLM1FMSmN3empRbnc0WVE5TUpLT0pYdEdYS3dqb0g2QytvVWhn?=
 =?gb2312?B?eHJPSFl2Q2QyT2JlOGxVaFhNU2FSelBrazhQK1lOZldlbHdDVDFKUUZEdXZs?=
 =?gb2312?B?a0RmQXB4WUd2aDJSS3ZiWDI2aUhkSHFPS3dXUzZJUUtncGJHRjBSRXIxQ1Zy?=
 =?gb2312?B?UjArNEhGeVZ4TnVsejBjQXBoWUNnNUJYRXY2UWdKSXNpL0J0VkV2cjJDV2VV?=
 =?gb2312?B?RytFWFY2aEZDN0pNS3FNdHRrbTFVcG93cUhYbXJxS1ZmNWNtYytXNWRFVmpO?=
 =?gb2312?B?RUQ4N21wYWZOMWJGdzNOWnBKd0lacXdDeHFtZFA5Y2ZiSUVqVjZTVk42TTh5?=
 =?gb2312?B?K1pJVmV4SndGL2dtWkFwS3I2N3orcENlcTY4RDdnNVRFQW5jK3hLcEZzSjBp?=
 =?gb2312?B?OHVZc0poK0t3TnpWY1FNNk16aVZxTFQ5czBxeDJ5MWF3VUhDM1ltNXdpQnRJ?=
 =?gb2312?B?U0ZWd3p5QWgzWEFKa2lwZEhvcTAwV3ZvbzhISFBVOFRISHJ6ejFXTmhYUGFq?=
 =?gb2312?B?SVM0ZjErdktWaUxoYlJaRCt4RlNVNWQ5MHVtK0hOTFJXY0VscnNOSXR4VTA5?=
 =?gb2312?B?VnRQZ09tSkw1MmZ1VWsxQ2lWaG1RUmthQlBMN0trSEVvUHlRNEVDNTA5NzNr?=
 =?gb2312?B?YnE3WkxQODZqZWFJUnlQVHJQV2l6bDliQ2x0QVVvbDBldXFkTGErTnRkYTQ0?=
 =?gb2312?B?cTAwdzJXR3lnMnpMbFBjaGZ5WUVsU0ZYSGNYNmRFSml5UDhscEJuRlJkV1hP?=
 =?gb2312?B?UkVQR3B5NEkxWTVVZWpZVWN2VVNHT3hXTVJBK0thUGhhUXM0YTZpZTlxT24r?=
 =?gb2312?B?d1ltRFNSV1NwTmhYYnJzV0cyckxaUXRZZ3BtbEc1QWs3dHNpbHZKcjJFQm0x?=
 =?gb2312?B?MDhxai8zSC8wR1JZTDFqV3gvWFNuQ2gzcktEYUlzbWx3M0VVREVlTWhWdmdM?=
 =?gb2312?B?NVNhYVNjdlRQU0FOVE05RHIySDFyald0dmtZNngyOVhwQk9IOGlEeE9jRDVj?=
 =?gb2312?B?M1hRc3BvT2xPekQrQ2Q4ZHNOWFNzbWhsL1hGdExERlloVEFRS2Q2Q3JNeSt5?=
 =?gb2312?B?Y3VkMnN1eVRvcnZ3U0IxR0pTWG5zUE1PWEJrckU4Vy91NERwbUpxOW5mMlEy?=
 =?gb2312?Q?Dw96aLpYEEWYI2rnej1TVWeoolmH2sMtZ4mAbr2luQ=3D?=
Content-ID: <CD587E5AE0B6414B94F4187CEAD37505@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1724b47e-2323-4b32-f3fb-08d9b466f0e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 01:07:27.0073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BHNiZ0yQ2HAUQV1VvWhGqMOj7DzPbYmjMGfhfNONQR2UQ22BTXiLxKu49PhD9FIL8cv3itPwHN5s9ON9x9l+C2LwOanBqeEoV7B+Es+tsjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6841
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] bugfix for vmsplice/vmsplice02.c
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
Cc: wenyehai via ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi wen
> vmsplice/vmsplice02: Remove duplicate header files fcntl.h.
>
> Signed-off-by: Yehai Wen<wenyehai@huawei.com>
> ---
>   testcases/kernel/syscalls/vmsplice/vmsplice02.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice02.c b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
> index 39c407c..3dc623f 100644
> --- a/testcases/kernel/syscalls/vmsplice/vmsplice02.c
> +++ b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
> @@ -20,7 +20,6 @@
>   #include<sys/stat.h>
>   #include<fcntl.h>
>   #include<unistd.h>
> -#include<fcntl.h>
>   #include<sys/uio.h>
>   #include<limits.h>
Actually, lapi/fcntl.h has included fcntl.h, so the latter fcnlt.h also 
can be removed.

It looks ltp other places also exist this duplicate header files fcntl.h 
because of lapi/fcntl.h. I think we should remove fcntl.h for these 
cases when them use lapi/fcntl.h.

You can use "git grep "fcntl.h" " cmd to search them.


Best Regards
Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
