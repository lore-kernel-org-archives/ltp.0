Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643EACDB47E
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 05:49:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32BEA3CD3E9
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 07:49:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 118983C8872
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 07:49:17 +0200 (CEST)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 14863601911
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 07:49:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697176156; x=1728712156;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=kyV/ZKEwq9S4DFIPCrCtcu8Cyp0SPUjSbnkCLRqR+a0=;
 b=ilzKnhwZP47kk51PKtDWpRDOCv/AmiOKla+kfHugOgBfBRYl8NinTfQ1
 WPQe9vl5Vw1u/37w3w7NsV1Y7nCJVZbBoBnACbm4oBhGG9kv6OrviTLdM
 aO0p3t2Z4g6lwYyYTiuaAA5pqO7qhAjS9PgJ9d8bzij4gldKhhWMJ4A9g
 7FIYxu+pTDiJx8cgbVcj3umpsEwbkq8xRA/s3OZhYDkUP1dwhMc+UdK6b
 96Nz4TjUWEb9zVlgFaBsv8/afySHj+shsJrlfx2Zi9ZE8KFIK8WkD44V0
 fU9/mYv3MTgVp+LfZtEs59Aay06gUmly1X3jLFjMZS2Gvq7/fbAxXLJne g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="10181273"
X-IronPort-AV: E=Sophos;i="6.03,221,1694703600"; d="scan'208,217";a="10181273"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 14:49:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKszjmRWzE1OSfys0RTcsUQFYMdhqIMne7b+RFpPXRfXuTxfFMd6ZbEFXaOhcZxLyU5I/YKX+/+wVVZP0BHFlF+bF8LycbktjWxq49yTKHaNSaMqd8eAxAyIw2LHVHrPF1Bzr9+4QY1rRueXx0t/IlraqCXz8Bd7fj7dFPylK5cBz/sFzhXRmUJFC212bkUnyxpHQ8HAD/VBCjTCV4+NTYnnnkh8SJJRUtvk4xOb2ojotmkAbMW1wGdyhBGQEGtPDu9a0ACsc1aS/nzs+EW9szsykdXiWo5Lk06TG4OMn8Wwt9yewj+cdH50VbSFb2CuMgzn4szfdZSVrPAIGnWyCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyV/ZKEwq9S4DFIPCrCtcu8Cyp0SPUjSbnkCLRqR+a0=;
 b=l1XgEH47GTNJ0Gs3orTgoeLpdfF7CRwBojzlMcfAw00kClupbv+plCsHvii4WfefTu8uzaJWEzHlFyHpJBWKICtnQ3TRv+QNKwLo6jInzHaMQgJHunwCR3QyrsgmRTxN86/W6XFZsEZsGOhpHEAN3RZotBNMK9iXmlhS2qt1PMfDfF2TjtOPzb11DIii9NYJeNHnuG9MMXe5hrLw/lHkheUEgDwcP2tKq5fJwm6W5+BgRB+ZDrZPVfHBUiWmd/3Q+g5kn40TGn0bU3LomjARhZsvRd6d/2EsA7QSIrYoH5siZE7DZ+j8q0/827PP2BELDj0hZBY0BDlfKzGI8PJbxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYWPR01MB10032.jpnprd01.prod.outlook.com (2603:1096:400:1e0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 05:49:10 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::a5d2:bd3a:8420:bd3a]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::a5d2:bd3a:8420:bd3a%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 05:49:10 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 3/3] link08: Convert docs to docparse
Thread-Index: AQHZ/DFtSJQZ+1Ud6ky5Ax5BqHP78bBF7OOAgAFMsoA=
Date: Fri, 13 Oct 2023 05:49:10 +0000
Message-ID: <1ad9d44c-51a5-dca1-6992-cbfce1d2b987@fujitsu.com>
References: <1697021709-22916-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1697021709-22916-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <20231012095823.GB618148@pevik>
In-Reply-To: <20231012095823.GB618148@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYWPR01MB10032:EE_
x-ms-office365-filtering-correlation-id: 3d713bd9-e0c1-4501-22c1-08dbcbb01f69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: trTfvpulqWOdhNnrwd41uvezGrLl0/DxtkARoXE/lK4I+3DPJb0Lh9lum1yNK9Lmvnyl4W9DE+E0hAFuMJ253NOsPgkTHvfUTEVJCGGdUvBM0Rc5awdhV9Y5unaVPrJ4mXJLbEYQn+6zOwTnzaejKXnRs2b47iM+hFRvRgHPKvUlWxjSX+BWii5a/UvtmRnqWGuwF9KHaHTTE2LvY5V2tOw/fgisr2/9MPx9FXTwcrcBlQsjotSilftJ8T7YC8DOSRucK7QLg+NJjnxCjBIh7ZbhbLJaYQydgqupoKqI/L05dNF+QziyHl1cKaVVjg4eBL7GDFaCagrDQcY4oEUevmZ0M8MGRu9SNqfLZfmGkiy17XOpPLEPFhoQw09hompuBRxzMsKv5cS/kYFqGIG042i3mt+3gwigj0Z66GGcO46UPrChuFk8Zsq3NkvievbBch7eBcw5iNZfqPy0AnRGGIMI2X7WiJxgfto7WioJlCJL3Ouqmvi45UWRQekf/lCogJaUb94hSrAUskyADYNlHIwZ3cMIEXJgzdHakNeb7M6EKuH5Mzk7Gin3c+i7Gh0lHiNdeOuiZZkmjep8RO85KIOMfWr/NnJx7HGAWTvRHV3jiX29aLizr7wQawGk+RGZCQMEDSjxa3L1I3HCOzS+sHWQa5rVRmHErmBkSyHjTUE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(1590799021)(1800799009)(186009)(64100799003)(451199024)(6506007)(83380400001)(31686004)(26005)(38070700005)(38100700002)(122000001)(6512007)(1580799018)(2906002)(31696002)(86362001)(5660300002)(4326008)(8936002)(71200400001)(8676002)(85182001)(316002)(66476007)(66446008)(6486002)(76116006)(91956017)(66556008)(6916009)(64756008)(66946007)(41300700001)(36756003)(2616005)(82960400001)(478600001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnQ3Nm9GVkRRanJyY0RYY3hpNzNxcTNtdzFiSzR6SXRYcTNGMlYyUFZCY2VR?=
 =?utf-8?B?aVQ0eTFhRmh1dnhGVXJPbXJaR2JzWnlSRXhnOTd1Ti9hcit0enZ3WmhlQjZv?=
 =?utf-8?B?eFZ3UE9TTkFoVXA3NURlUGpkZ0ZDLzdVQ3dhTE9pL1F0NWRYMkp2eGZTWWNh?=
 =?utf-8?B?R1FkTHJVbkFELy84dnhKUlVNNFVZTEpMTHMwKy94NElEZUN4anpYMWt0SmJh?=
 =?utf-8?B?cWl5ekJ4Y1hST2hEL0V3OS90cVMrTlA0TzVldnkvMXUvUEZLaWs4MkZYS21R?=
 =?utf-8?B?S1VadjhXcmswdnpUaDVwd0l3MEdpWklRSDFYRVRXcFNmTVR4L1FJanYvWjZ1?=
 =?utf-8?B?SEI5dEZveTBTQk9uWnVVd05od0lSSDF6dXJ3V3RPakJTdWQ3K2Z0UjJGdlBi?=
 =?utf-8?B?MzA3TXMxVFVOU24zTlV3WmRxRVBwaGVFeDM5QUdXQ1Q4SlBualVsZTVVc1Jv?=
 =?utf-8?B?SjdmUUJzbGlDN3poUXYrcDdzQ2I5NVQ0MUMwSGwxaFQ5SWZOd1F3d0tmSFdF?=
 =?utf-8?B?d3NUOTNYVjVSZmY3TERMVzFZWXdaRVZPcFMzYlRKSE1qdHFIczBoT0UycExh?=
 =?utf-8?B?T1ZTZmRGWGdzWmFuV2gvZ3ZpTytBK0JFNTU4SjBrZUVFYXBnK29NTUQybzBG?=
 =?utf-8?B?MkhDZXFXTFpYSlh2dlFsT1AzSnlsQ2ovVUxDdE5CUDNIQ1FvMHpxOTc4YVI3?=
 =?utf-8?B?a2lzdVBxemJRUWtWRlhiTDZMdFFhUnpWc1JJTkNPeFExNHc2WkJ3cEpWOHFH?=
 =?utf-8?B?NVBtV1hWUDY0QStDekdLMUFZQ0xrYnNrOUNoaWcwL1ZaQ0RCbTVYQ1ZnODNv?=
 =?utf-8?B?TjFSRTE4eThBb1pMSHIxNHFJMmtsQURWZnhrVFo3eDQybkM3Q3pGekZIUU1M?=
 =?utf-8?B?ZEo0bmZzNUhzd05oWVpPU0ZRVjNCdWV5em56UTRWVHFOdlZtOTI3Yi9oeVpa?=
 =?utf-8?B?K0tERWNFQmVVbStvbTBKT3FiS3lUMW92U3RsckNmcVZLTS9jSEdORjB2QU5y?=
 =?utf-8?B?d0JSNmo4UThVbTgxWERwUGVuL0MwNnVFRlhYNWdaV3V1RzBpb0pwWTc1VFFM?=
 =?utf-8?B?Z0VqY0s5aTJWYVhlOEg0Z1FydzQxcVNvVCt2dE1MY25zaGs4QU1xaWpkRjls?=
 =?utf-8?B?NjRXTW4zcG9WMDVQTmt5Qk1jR3hlVW4wWHpXMDQwWnN2c0RCZklpYkc2TXl2?=
 =?utf-8?B?YjFWNFRtMGsyWVl3azZ6K3IyZDRpZS9xbVBodnhjTXFtV1Y2YzY3bmtyekVM?=
 =?utf-8?B?MlJodDM0VmplZkZvL2svVHV6YVRrcHVqb0NCbHhMcWVEOUx0bG5KTkkvRmpq?=
 =?utf-8?B?cDVpa2RaakxNMUlRci90MTdRT0tMVUl1SU9mdzB1eDhBb3BiOEtSMExOM1VY?=
 =?utf-8?B?QnF1S3FEdUF3WjB1b3FqeHdXc0xiWWRaWDFBcVU1NlUvYWx5T013ZTZNS3F2?=
 =?utf-8?B?bm5CZ1U0aUZPSEZoS1RyYXVnWSt6b3ZoMU1sVUhwMGNibVpqMk1tVmdOSHVa?=
 =?utf-8?B?ZElzL1Z2WnNYTFBVbnFEeTZ6QXFiSTcwejcwWWlia0hRYWhSUjNWZWw2elNq?=
 =?utf-8?B?dWtpRFNlUE1UOXZsUU9MM21LNy9lbEdHemdGeWFlMXlKZ3hNd0N4ajZ5RzRp?=
 =?utf-8?B?TEdCZjByVXNwNWplTDMrQUFEWjVuK2JYaEUvSzJuUk1qMFl1VXpMSExLR0s2?=
 =?utf-8?B?d0t0anJ3RXYzUERDMVZrTWgyeFJkT2N0YVhvbkhUVUZ4Z2x0Q2FTZitMcXZ0?=
 =?utf-8?B?bVJ0SW00UER3aTRUWFhSVUFFRzZldVdYZWU1Wm1CK1QrVHVqWWgzSStta1Rk?=
 =?utf-8?B?R0o1TzlGOWJnV1VtdEJGc2ovRmdZOGlma0hXbHAwVXlWbXNpRFFpTCtwU040?=
 =?utf-8?B?Y2p6eVFjMmZocU9YeVhjSk1idjlHTjNhVm41cUw4QjdYREt6TXFXbHNwMUpC?=
 =?utf-8?B?bC80SkI1bDJ2b0wxTjYyMEtZVkVZOVBvSjVTMS9KOTUwR3owTWtzTXRRdk5o?=
 =?utf-8?B?dXVGa2RaNUdwQ3E5OFB2a042b3J1ZzhDeHVyZEw1VWlKRVBEaXBCa0ppKzhv?=
 =?utf-8?B?ZmplRFkrcEh3NXIvcG1VWlBTeTJaakduWTdGYTBpc2pxdC9vOTFJZGZ0T3JQ?=
 =?utf-8?B?N0FJc01lc1Yra3JZQW5WNXU4S3BKR0lCT1QrUzlYczRpZ3RnblpuRzh5Ui9z?=
 =?utf-8?B?QUE9PQ==?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J9tCg9/LNttsubOOKGEndN6d1Ly6M8T8qLrPUmz0lfFVT2xDevanaqM3BKvRhu5UIKZysp0Zie58pyMc2BHvF39R5cWj3+lddtPwDB2wSXEivpeU51OwnGrfbb7DZ5N9SOsNpwwH3DGtqTWHgpWHgvBxiAskxxQoxjD5TRDKlDuMr6eosY39rKry7RNbyVa/VpnH2QVOc7yQ1wM3RSud0IegM+1wjH9VPDgYbDDyjsIGMd/2C+m2smbpdVXFxpFqMe9CM7c+6AhLeT7ht6dxTQb6QVzJ+SpcYtGLe8EUp1ejzkS/DlPu17wT+FjDkvsYLFSEtael1cA14pz6FDWCVlzTCM+4W26awNsVzyNqj/Hg8ke55FokmkML0cOXvPyp8l0GdjkmK+F7yt1Vpll2nc1cBTkKnB8Zh2KbR4rVihK8c5Wv6Vkw89pc4hsvDbSby2IpbaGQG46pqHFy8aiC/DjwRSnDmi8GDdrQD5YeS3Zpec5ECZ82947U7LhHwLuKcjuja4YTKUJQQNey5YpJ/CM2x1jbpAotZiJKhUirXaGeFd+7yzsiKTC5ALC8gMigiLNA0JmBC+K5vXCtX4iANHGbzlodGxJpGa9mZPfX6exZF8L2t1GbYHyX3MyrBgKX/d7chGWECMND7IRGIAObAZ3dlTZYmdZ9McTlkTPQ2L9ccjkCbaMVe9TY8gq39NHoTHfAKIK6WOMc56Lvun4hNcdFOdPFsuHXV0Oja+IE7nnuty885cZZdzxCIww9QQQpT+llteWWQG7k9CUwys4ZtFcGPFviIyyTyQ3vSvXa1Kw=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d713bd9-e0c1-4501-22c1-08dbcbb01f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 05:49:10.4718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QCey9zyDimq50mpnrvYGDrZ8fKMbcWGftnzivuJVdNxKv6xA11lsP3MfdTDPb1NrHHrYbVwpYwGPjUci6od75HHMkZVEN9MoVtG5rUt+cGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10032
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 3/3] link08: Convert docs to docparse
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


Hi Petr,

Hi Xu,

...


+++ b/testcases/kernel/syscalls/link/link08.c
@@ -3,21 +3,23 @@
  * Copyright (c) 2014 Fujitsu Ltd.


While you're in it, maybe update the copyright?

* Copyright (c) Linux Test Project, 2014-2022


ok.I will update it.




  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com><mailto:zenglg.jy@cn.fujitsu.com>
  */
-/*
- * Test Description:
- *  Verify that,
- *   1. link() fails with -1 return value and sets errno to EPERM
- *      if oldpath is a directory.
- *   2. link() fails with -1 return value and sets errno to EXDEV
- *      if oldpath and newpath are not on the same mounted file system( Linux
- *      permits a file system to be mounted at multiple points, but link()
- *      does not work across different mount points, even if the same
- *      file system is mounted on both. ).
- *   3. link() fails with -1 return value and sets errno to EROFS
- *      if the file is on a read-only file system.
- *   4. link() fails with -1 return value and sets errno to ELOOP
- *      if too many symbolic links were encountered in resolving path.
+
+/*\
+ * [Description]


I would keep the sentence:
"Verify that"" or "Test that:"

Beware, there must be a blank line before the list, otherwise list will not be
formatted as list, but inline.

With this change:
Reviewed-by: Petr Vorel <pvorel@suse.cz><mailto:pvorel@suse.cz>

Kind regards,
Petr


ok. I will correct it.




+ *
+ * - link() fails with -1 return value and sets errno to EPERM
+ *   if oldpath is a directory.
+ * - link() fails with -1 return value and sets errno to EXDEV
+ *   if oldpath and newpath are not on the same mounted file system( Linux
+ *   permits a file system to be mounted at multiple points, but link()
+ *   does not work across different mount points, even if the same
+ *   file system is mounted on both. ).
+ * - link() fails with -1 return value and sets errno to EROFS
+ *   if the file is on a read-only file system.
+ * - link() fails with -1 return value and sets errno to ELOOP
+ *   if too many symbolic links were encountered in resolving path.
  */
+

Best Regards

Yang Xu


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
