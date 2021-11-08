Return-Path: <SRS0=tV2W=P3=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B59C433EF
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 03:28:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 539AE61350
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 03:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 539AE61350
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27A733C7027
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 04:28:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E91883C2435
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 04:28:07 +0100 (CET)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3FA771000610
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 04:28:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1636342087; x=1667878087;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=PyX0TwSQIzp4OkvsH/GONRi4GNBj25Iqv1MtK1PYsvw=;
 b=MDaGvxeobAB073d1A1ApU4BuzmkKePsg4KzKHkGq3nFqFBPf7WazP7p2
 +xluu1ZgHoIeXQ9+PyHtl2h7XclW+4zMAUOWHT76A/1yCG0/WBb5lHuZJ
 1eqW8PkLEyTM7V7p/nEAlr79+uWLSrV+j6a+ZQMEwZNl/nwTrk2RRYkvd
 jwbr6bmQlwjWrYVbD8NuEh0tT67MXaJksip6Jwetpaf37C8xd6CEOajLN
 2o0uyx+WZNx2ST8cuBAMUSXzXccXb1WV3OsQIsyf5zkAI7qQ00xScrXlV
 KSiPl6r3mMgEu0EqAQqsKGqgO7Chikj4pNse006ynNYpJrYQCt5E9tNna Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="42878976"
X-IronPort-AV: E=Sophos;i="5.87,217,1631545200"; d="scan'208";a="42878976"
Received: from mail-os2jpn01lp2051.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.51])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2021 12:28:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCfgTvkVU3sBbRc8jaBXMnmDbn1NCTwgNHHK/iNDboSAP11LZOCurJSz3C6BHQbbTKwHN3QJ32Yt/GQ5I47B7RY2cLcwFY204BxzhwRkxWJWI/jxwsWceIPCcY6xY7uFo0/FBLWbKjZ3HTMKugbDARl7F+YSQ9P8ATsF+O7+vNuHHveZ1XW646VdOiE3hU1Uzjjq+3VmWRAWxEiaXYlspfCFISAyQEDbRSqkDoCbGUIuJ8adA0egRmeGj96ZpQx9GMIHdIFuOBYiD6wVKrDi1m4Pr4Rq64VXBnBioM+oBQpyoyWA0WYISikXSN9obrHqGkZnwWNndGw05O7Z+C35Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyX0TwSQIzp4OkvsH/GONRi4GNBj25Iqv1MtK1PYsvw=;
 b=cLV9dxaub1PQPHfUpEcn2kgCZr8oP4MaJTDPEQJYvYkTYSaJc+BHLh26wxyZA8Ho4BAy8czdXsX1CtiVeZaVnBJhpWiePFv79w96FRTHVqZp+Rzuck/QuiCsCymvhE3x3CmRwnARrcYVARCAFZ6fReFtGoYPnsCIU9d2U4wZzR9g0EujbEai40OWCvWXE4xlVMDSLbha4BEAnbn1FnLhbNxnOnSGTJDHriQGF1prCFWQaCD7Gh0asWocUUzd937ooXL+23yoqPppqpdBnS5E4Wo4g/X1xjoooo+Sl+gIAlh1VOrNKc9N83zdMIWeG0y/NY3nHAHXuQ40qOhtVwy5mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyX0TwSQIzp4OkvsH/GONRi4GNBj25Iqv1MtK1PYsvw=;
 b=ZtKhjUBflYjqbHEyTJbYhdv1jugnWb93AdyhgdNz9xrD5G9pkyZcW48vgIsRm9H6GAAsKfEiV0AhCoI9gk1SIXq2YP3v2yOQY4z7u2Qpaeo5U/5bydoBNs1ib71OqR+1fV62F0SL+ixLvjyuzgaI4zQSHfiy+rW3kATKV/15Pws=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB2861.jpnprd01.prod.outlook.com (2603:1096:404:88::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Mon, 8 Nov
 2021 03:27:59 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9%8]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 03:27:59 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v2 01/13] syscalls/quotactl01: Also test with vfsv1 format
Thread-Index: AQHXyy3cej5rSt2kGEqp+8CwKfMnfKv5CweA
Date: Mon, 8 Nov 2021 03:27:59 +0000
Message-ID: <6188995B.6060200@fujitsu.com>
References: <1635337569-4634-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1635337569-4634-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.linux.it; dkim=none (message not signed)
 header.d=none; lists.linux.it; dmarc=none action=none header.from=fujitsu.com; 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4475d6b-d158-4b01-dd11-08d9a267c3b1
x-ms-traffictypediagnostic: TYAPR01MB2861:
x-microsoft-antispam-prvs: <TYAPR01MB2861F4E19D649BEE06FB3F0BFD919@TYAPR01MB2861.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c2PUpTRsvv+LqP4eWQ74TJiCTn7x83y4BoqoBWI1cleV5FiKItM9wzEsdMMoIXs+oqeflDEVvdf1VsC36MrhGL0qGDjqf+run1WZyT35CHYh225y9WUbNyxMGU2iGFK8C4dYglKL+ZSmdHr9A7/FOsAm8aBzqyUgKzKRGxCtnNyq/kpli2xm+y5plQqJJIGR/LQASS4PipQ4GnhDd87SlpkYl0++AbBHU4Z+74DNqtyCmDXKXE0nSVwnq9WQKow6fGZQT6b7FelVG4QGzmyb8iNX8dmrkf3ik9E4kANGqbGwM/EvH20WzotER1e5WWvG298HHtdJ53i3n42ZEhBV/nYEcPcUZEBu+SF2sePUSS9/+k1NWZlM4WhiKNuOxuY9fRALVq8GNudQ3+7/fqLEmJroTbmLIJwW5kfO0jsLLeqDo5T0iU2l0PpY0u//m7bwajTF/nhwQmQ6GbAuuzlm8uaDosmTEn8PCX+7UPPFq5rwgehzLPxidv+9nKt4s+2+Ejn8Ft2HyCSaYF/oOztfW7vxhrUXdt1BO8ArvBKoVjtbsBVLC1h/a/N3Q0eNUom/53JDhnH/j579hmWKTVdv1unFLWe+tnn7FUcUzVuWyCf1p6Nd44hjwnwKZlC7gS4PlHyr7dxLq8qYAU2Q4KlBViVVUmUOYKPfLOYvIUD+2sf5q7ctmkl6W6peufwJbuffFwdnM0M2tMNLxb87cZk5eX/QXxw3I7ziaYu0xUx5dsd0rui+AIEYj+Fv5bQiYuYit6fVOm6tOe1o3uXPcuCaLH5ocCcLX11u5jJ1vkQWSUc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(87266011)(82960400001)(86362001)(8676002)(6486002)(38070700005)(33656002)(71200400001)(2616005)(83380400001)(26005)(66446008)(66556008)(38100700002)(186003)(6512007)(91956017)(64756008)(76116006)(66946007)(66476007)(122000001)(36756003)(6506007)(85182001)(316002)(508600001)(966005)(6916009)(5660300002)(15650500001)(8936002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RFRTVnFGTGpkZFFoRm5WVCtpM0sxOXEyTVlFQmpvb0pmdEJYeEo3alJ3SGs4?=
 =?gb2312?B?Y2FUZnp6MW1iS1BkcW1vWWQzRHpyRDhnekh0RmdCbXR1Rm9jdmVNdnhXd3dZ?=
 =?gb2312?B?SnpUR25TQVJQMVNqSGRLN1BqK2tyRzc4Yk9vdi92UkFRUDJnb1hqWmRLT2o4?=
 =?gb2312?B?cWRXL0svUTQ5MW1GZlpxRHNxMk5WaEpVRmtiaHZqci9ESXR5dThyUFora01S?=
 =?gb2312?B?Nk1vNjc2aWRYMnVxc3dLeDZYYjBJMGY1ZnhHbk1lUnc1V3V1ZzZkZ1RmUWZm?=
 =?gb2312?B?Z3MzTXJ1cmsxbzM3dUJxdVRINmtyRmx5SDIwNjUwZ29TazhUaDl6L0dDMDJr?=
 =?gb2312?B?Yko2WHJUTGRhbnNuM3pVWmVOQnlEMDNFQ3RtYWkvR0hka3lzRmt2WXBwR2ln?=
 =?gb2312?B?OWpVb29adHk5RzVwRXZxZXdPWUprT29seFdvOG1YbkRpR3dqMWhNTE5MZ1BM?=
 =?gb2312?B?KzVQTUxCOFZSRThwNDYxYU9MYUs1WWVmVWM2REZ5U29TWTRmdEdBWFd1Njh2?=
 =?gb2312?B?Z0YyZERGclczajVwcnNnMDNzQk1wUjNvSFFqNVpVZytVamY1MXVDekowQXdy?=
 =?gb2312?B?ZmNpNlZ2b3J4LzdqSmxHbGFqM0hDTm9MYkhhdk84TU9XR2JtUlVsN2JZZzQ3?=
 =?gb2312?B?OWU3dGFGQ2VFakFyRGduSVd5Zll5S2xqdnBXRlM3eUpBWE9sY1ZqWURTQTVC?=
 =?gb2312?B?UTNTZENiT1NoaGhlZDdtTDQzRTVaQVJTbk9DTFNQVVpPemdTdWtaNTJNUEtn?=
 =?gb2312?B?cTFxNFpqSTdmczFicm4vSi91cmRPZHdYUWhqQTB1ZGw2Vm41S29kVnBPQTlx?=
 =?gb2312?B?bC8zbkQ2SGZJYy91SkI0RGNmSWJRNFI0a1Rqbk5DQXB3U0x6K3lNN0pqQUs5?=
 =?gb2312?B?Y3lObGFXZmVkcXJ1YjlKVkFTWGYrRFhjMUppQ2F3ekkzdTUxa0U4N1VmZTV0?=
 =?gb2312?B?NVJKRzk5MFZ6Z3huYlNpSjhZMGF4M3JYT3dGVGNwZllGM2dyeDR2TGZnUDZr?=
 =?gb2312?B?RjQ3Y1FZdXYxMnJKTUZyQkZMbzI0V2VLeS9UK2YxSEZ6QWViZlU2YlFTOHVR?=
 =?gb2312?B?bmlqZGl6TWlBL1p1U3JyRXpGaktYT09GYVgvYXRVdUg5MnFHWkhXek9ldWNP?=
 =?gb2312?B?V1dmNFJKVG1HbmNzTFFpc2VLRlg1b3BQQnJTKzgxVWFneTZRZWFQREl2SUVN?=
 =?gb2312?B?ZmsxRFhqOEcvVHQrK1pjTEVJRDNXQm9acnlUQnVNZmRJL2dGc09PNlFSNGNR?=
 =?gb2312?B?dnhBNENHbSt6aGplSGlITmdKL0JLREQ2U0FSbXQzdUIxQXUwcWh2dkZVNk1Z?=
 =?gb2312?B?dExvMUFXaW50K2t2OWhTSlZnS1dCYnVTV0xRL1dSVjQzUExTMS9acXo1dDAw?=
 =?gb2312?B?dWpycUZmc2FxYlFsN2V5VlF3RzlJTm40SFpmdlRMNzNBeVZnU0QxQ1FxU21J?=
 =?gb2312?B?WjR3TE5TYXFldmRETXB1QWRqNCsyY2ZRbCtaNkM5aG5lY3BDbTJ3bzQzanB4?=
 =?gb2312?B?MXBTdlEzVTlLd0RIVzlHbE1JUkFWbDdBejdrMlFrYnNaTm5KWVFSZnFadjk3?=
 =?gb2312?B?UHFsWjBUZURNSGtib0FaOU9JcEVFQURsa3RXUE9Cdi9qSlpvRHBPNHg0S1c2?=
 =?gb2312?B?M1hhTDVLZm1rZG5NVlExT1BjUlpSOVd6RnFSNzU4UmoxZ0RtS3llOXJjZUt2?=
 =?gb2312?B?NmlTRFExMzVGTkJNVHhNdENGSFBXSHRCRlcwRjJoTDd6WVVxZ2U4TlArMm1y?=
 =?gb2312?B?Q1MxMXpVenE3dlluVzlDY1ArVGZ5Q1VCWi84STNKelRYNnlmM291czd3UXdW?=
 =?gb2312?B?MVFxSURpV2JhSG9tQUtINk8vQTd3K1NzWUZ1a010MEVHK2hQdlRueVk5aFds?=
 =?gb2312?B?UU5VeEZNc1I3UFl6RHdONGlaWmR4VHJmUTd3am5nQU5acnlzQnE2YnJxaUFo?=
 =?gb2312?B?RWl2NDlEZm5FRmw3NEtlU1llR05UQ0M4ODgxRGcxWVlNcFp2bS9sVitudEtJ?=
 =?gb2312?B?dHFBc0NPUEx4bGJzWEJzM2tHaitsZTYyLy9VRUJkRUxzaGpJb2xGaWt6dGlN?=
 =?gb2312?B?dm8vSysyY1pCVktnV1N2a3o5bkxFYmFyWm4xdXl0RlpEOWdYN0ZKdGl3WDdw?=
 =?gb2312?B?WDIvWDZKZFdnS3dvYlBQYWJtemJaZFg1dXpZeWxoUTZjVVlMYW5BOTY4bTJk?=
 =?gb2312?B?NnlBUm5saWU5N296N1Zwck5ObFF6bDB4MVVRVFQvc3hieWFYSVRSMUJtekdD?=
 =?gb2312?Q?HI0FiYflrQ/okmRplnErYFqW4M+e12ctuq469oUsXI=3D?=
Content-ID: <645E1C0B003E7C4DAEC885C1C29301B1@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4475d6b-d158-4b01-dd11-08d9a267c3b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 03:27:59.7842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T0K7ltwJ45gXTIkeWTvkXlbK0wv/U+/1CMAA1ccq1rDA3ZQprX/PGYmqhz08dkU5CfYN80hS5lgKiYtWPtNZuz17Zzl/3L9aYtkh7C2Dbw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2861
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 01/13] syscalls/quotactl01: Also test with
 vfsv1 format
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

Hi All

ping.

There is no problem with the first six patches and other patches need to
be modified v3(needs mkfs.ext4 supports quota feature when quota info
hidden in filesystem and open mntpoint instead of testfile when using
quotactl_fd).

I guess we can review the first six patches and merged, then I will send
a v3 for others.

ps: Remove testfile for quotactl_fd and use mntpoint directly. See the
discussion in the following url:
https://lore.kernel.org/linux-man/20211105112045.GA26497@quack2.suse.cz/T/#m41a9666d01d43a29973a5a6a61b02b0c4e9f0df1

Best Regards
Yang Xu
> Since usrquota and groupquota supports visible quota files
> with two formats(vfsv0 and vfsv1) on ext4, so add a test variants to
> test it.
> 
> Also fix docparse formatting and move some code to lapi/quotactl.h or
> quotactl_var.h for reuse.
> 
> Remove useless geteuid.
> 
> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> ---
>   include/lapi/quotactl.h                       |  9 +++
>   .../kernel/syscalls/quotactl/quotactl01.c     | 79 +++++++++----------
>   .../syscalls/quotactl/quotactl_fmt_var.h      | 22 ++++++
>   3 files changed, 70 insertions(+), 40 deletions(-)
>   create mode 100644 testcases/kernel/syscalls/quotactl/quotactl_fmt_var.h
> 
> diff --git a/include/lapi/quotactl.h b/include/lapi/quotactl.h
> index c1ec9d6e1..8e0315d03 100644
> --- a/include/lapi/quotactl.h
> +++ b/include/lapi/quotactl.h
> @@ -8,6 +8,7 @@
>   #ifndef LAPI_QUOTACTL_H__
>   #define LAPI_QUOTACTL_H__
> 
> +#include "config.h"
>   #include<sys/quota.h>
> 
>   #ifdef HAVE_STRUCT_IF_NEXTDQBLK
> @@ -75,4 +76,12 @@ struct fs_quota_statv {
>   # define Q_GETNEXTQUOTA 0x800009 /* get disk limits and usage>= ID */
>   #endif
> 
> +#ifndef QFMT_VFS_V0
> +# define QFMT_VFS_V0 2
> +#endif
> +
> +#ifndef QFMT_VFS_V1
> +# define QFMT_VFS_V1 4
> +#endif
> +
>   #endif /* LAPI_QUOTACTL_H__ */
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
> index 56146b595..7a71dd5fc 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl01.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
> @@ -1,57 +1,47 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) Crackerjack Project., 2007
> - * Copyright (c) 2016-2019 FUJITSU LIMITED. All rights reserved
> + * Copyright (c) 2016-2021 FUJITSU LIMITED. All rights reserved
>    * Author: Xiao Yang<yangx.jy@cn.fujitsu.com>
> + * Author: Yang Xu<xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + * This testcases checks that quotactl(2) on ext4 filesystem succeeds to:
>    *
> - * This testcase checks the basic flag of quotactl(2) for non-XFS filesystems:
> - * 1) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for user.
> - * 2) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
> - *    for user.
> - * 3) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
> - *    for user.
> - * 4) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
> - *    flag for user.
> - * 5) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
> - *    flag for user.
> - * 6) quotactl(2) succeeds to get quota format with Q_GETFMT flag for user.
> - * 7) quotactl(2) succeeds to update quota usages with Q_SYNC flag for user.
> - * 8) quotactl(2) succeeds to get disk quota limit greater than or equal to
> - *    ID with Q_GETNEXTQUOTA flag for user.
> - * 9) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for user.
> - * 10) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for group.
> - * 11) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
> - *     for group.
> - * 12) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
> - *     for group.
> - * 13) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
> - *     flag for group.
> - * 14) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
> - *     flag for group.
> - * 15) quotactl(2) succeeds to get quota format with Q_GETFMT flag for group.
> - * 16) quotactl(2) succeeds to update quota usages with Q_SYNC flag for group.
> - * 17) quotactl(2) succeeds to get disk quota limit greater than or equal to
> - *     ID with Q_GETNEXTQUOTA flag for group.
> - * 18) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for group.
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
>    */
> 
> -#include "config.h"
>   #include<errno.h>
>   #include<string.h>
>   #include<unistd.h>
>   #include<stdio.h>
> -#include "lapi/quotactl.h"
>   #include "tst_test.h"
> +#include "quotactl_fmt_var.h"
> 
> -#ifndef QFMT_VFS_V0
> -# define QFMT_VFS_V0	2
> -#endif
>   #define USRPATH MNTPOINT "/aquota.user"
>   #define GRPPATH MNTPOINT "/aquota.group"
> -#define FMTID	QFMT_VFS_V0
>   #define MNTPOINT	"mntpoint"
> 
> -static int32_t fmt_id = FMTID;
> +static int32_t fmt_id;
>   static int test_id;
>   static char usrpath[] = USRPATH;
>   static char grppath[] = GRPPATH;
> @@ -163,11 +153,12 @@ static struct tcase {
> 
>   static void setup(void)
>   {
> -	const char *const cmd[] = {"quotacheck", "-ugF", "vfsv0", MNTPOINT, NULL};
> +	const char *const cmd[] = {"quotacheck", "-ugF", fmt_variants[tst_variant].fmt_name, MNTPOINT, NULL};
> 
> +	tst_res(TINFO, "quotactl() with %s format", fmt_variants[tst_variant].fmt_name);
>   	SAFE_CMD(cmd, NULL, NULL);
> +	fmt_id = fmt_variants[tst_variant].fmt_id;
> 
> -	test_id = geteuid();
>   	if (access(USRPATH, F_OK) == -1)
>   		tst_brk(TFAIL | TERRNO, "user quotafile didn't exist");
> 
> @@ -182,6 +173,12 @@ static void setup(void)
>   		getnextquota_nsup = 1;
>   }
> 
> +static void cleanup(void)
> +{
> +	SAFE_UNLINK(USRPATH);
> +	SAFE_UNLINK(GRPPATH);
> +}
> +
>   static void verify_quota(unsigned int n)
>   {
>   	struct tcase *tc =&tcases[n];
> @@ -223,12 +220,14 @@ static struct tst_test test = {
>   	.test = verify_quota,
>   	.tcnt = ARRAY_SIZE(tcases),
>   	.mount_device = 1,
> -	.dev_fs_type = "ext4",
>   	.mntpoint = MNTPOINT,
> +	.dev_fs_type = "ext4",
>   	.mnt_data = "usrquota,grpquota",
>   	.needs_cmds = (const char *const []) {
>   		"quotacheck",
>   		NULL
>   	},
>   	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_variants = QUOTACTL_FMT_VARIANTS,
>   };
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl_fmt_var.h b/testcases/kernel/syscalls/quotactl/quotactl_fmt_var.h
> new file mode 100644
> index 000000000..cb9fa4625
> --- /dev/null
> +++ b/testcases/kernel/syscalls/quotactl/quotactl_fmt_var.h
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu<xuyang2018.jy@fujitsu.com>
> + */
> +
> +#ifndef LTP_QUOTACTL_FMT_VAR_H
> +#define LTP_QUOTACTL_FMT_VAR_H
> +
> +#include "lapi/quotactl.h"
> +
> +#define QUOTACTL_FMT_VARIANTS 2
> +
> +static struct quotactl_fmt_variant {
> +	int32_t fmt_id;
> +	const char *fmt_name;
> +} fmt_variants[] = {
> +	{.fmt_id = QFMT_VFS_V0, .fmt_name = "vfsv0"},
> +	{.fmt_id = QFMT_VFS_V1, .fmt_name = "vfsv1"}
> +};
> +
> +#endif /* LAPI_QUOTACTL_FMT_VAR_H__ */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
