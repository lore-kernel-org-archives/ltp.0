Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72E2C433F5
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 02:37:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 032D53C809F
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 03:37:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C1F53C1DB8
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 03:37:18 +0100 (CET)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 341B81400432
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 03:37:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639103838; x=1670639838;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+RXwDcQRdoMfBd6Upcz17nx/Lq3QPhyKLmoxcrBhLxA=;
 b=yrbPRnJdrZGO6qs7+JHgDb4dHEWNooZqVQyW8Vxkswg0s+QHIftwYz9l
 hNPa5plsK2xZIuLPEuFBHRq5WsANlEgnGjehhyRNQQkXvOKSbK/E8QQIj
 0NDbRUh3pOv3KTzdMuStzYEEGxNvGGaomMT7Qw9k7S6UVTqONJ/gMm8yk
 hys0VTzBu14JFkgubAn4Yn/mLuA/N4SEJFuHNoaSeq1OqDMIv5buvUhMT
 NzEuvHcuVfa+90OQnFiJstM1NAx0AT/qk59SuAE7ZDkGqH5+8YonRJiCo
 OomLnVT4jVflBGFCsTLhibdY4uneUar2WHJkoYTKo5epNqsiniwhsClwJ Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="45446007"
X-IronPort-AV: E=Sophos;i="5.88,194,1635174000"; d="scan'208";a="45446007"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2021 11:37:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdpMeI64PaUmdlJnqI3KGiFrEkXGl5THlO/wx+pz0Gz0UroXke3zyvn4J2ytuG35PwsDbH3Psj1j0aPkCneoM9gPVGiDbUUeCAcCqLb7dG9ZZmpM5vlYBwWQGwa7exQJleb+RcPWsI/Oj9/CW7cs1XGn0nJDmnX3y8aoPl+RSjZVchofW2aqj1brgjh/x63JrlCZM65uCdvjob0uQMUV/L4Jm4MnVHYIoce57862uvNalRIZMTUqpSqZ7mXfvHIZKHeZvpZTc5BhH5lqK8WLMNpUOy7yKjDXuCBWIs7ni6n1VXuWw8B4Ye5ykyn3yblYXYPFHx2J2LjpEQ57UYr7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RXwDcQRdoMfBd6Upcz17nx/Lq3QPhyKLmoxcrBhLxA=;
 b=j+7uJjhhO0mTuk9PMjg5BrldsrrJApP0wkcKHjnZ1b1b/7vTckFh9foNsFxnvRuhLBVV0M58PHPu0uwyAxhq1tUfWgBA0DqKhICF5o37bAMiPk0ZsufWpoQ7F8OCr5IjNTF1J37eKDmNtR51abu5Qu3M7WpfZOA6lleJhwOGrSN0sNX0JDccu7oIrlEFkMWNwIwx9lICc9QlzMrnJiLgRaqfjPtRYF+EYVLzEpDM1II/MVLHZ8o9JLVf0KimzZWXlwZMofgHV36cJYM/NP/7SlMsZPIff+JRVa4ZaeJBDEq7wr8pwU/6bl0WDOop4xHnzwjuoczGatFmus0xjzfAkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RXwDcQRdoMfBd6Upcz17nx/Lq3QPhyKLmoxcrBhLxA=;
 b=o7LThPpiNgjoLFQcKBxhiND2ZoSxsDcYYc3pLRLEwMdzDGaLEAjxtVYlbS1Gs9uuFVWeSJFU1HG1esOyB2wTdtxC7erru4OX+EdIIz15UhDBrWJiipPBbKxrgcc+7OUy1pYKpjT9C5/a2Hg5hFbn4OvCozhJESraEd/1Yi2afUQ=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB4621.jpnprd01.prod.outlook.com (2603:1096:404:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Fri, 10 Dec
 2021 02:37:13 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4778.014; Fri, 10 Dec 2021
 02:37:12 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v3 2/2] testcase: make use of needs_cmd version
 check
Thread-Index: AQHX7KvSoTWWwwR+a02WIMI/e6UuZawqoxOAgABhb4A=
Date: Fri, 10 Dec 2021 02:37:12 +0000
Message-ID: <61B2BD7F.6000508@fujitsu.com>
References: <YbDl7YtVZvYXPxwp@pevik>
 <1639020068-2198-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639020068-2198-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbJrw5aYVCNK+hTJ@pevik>
In-Reply-To: <YbJrw5aYVCNK+hTJ@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20d1f17e-ea63-41bb-8107-08d9bb85f8dd
x-ms-traffictypediagnostic: TYAPR01MB4621:EE_
x-microsoft-antispam-prvs: <TYAPR01MB4621ECF62B78EE3CF6D3E842FD719@TYAPR01MB4621.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 08DbzgU+ohU1EJip02hWBGGiObf+L2kLpnqnWsWjWDS3iwIT3kI413uVvUxX/yIS8NrUKM1XVnTgTsP5nhipdyDj3+emjEUlqgbWhejmkFinN4jbFr+tnZRZPQz1AueHEqIkdLrJ39OfJrvOPpK0C1o0fWeMGpKs32FAP18XFdma5hmhEobqXDzb/S0f+aAde4L/IMqXZww3wvzXtYz9wf6NIkoyR63U0jL67LMtAXkDErmOwjMX+GvxDKi9QL4Bfy85FMQFVwbLQaWAYyPtc3VZ3rcJzPExVqzBO3hsud1psWGuMlwnsQ1q2mzXUidtuUC13UozitDPlUkApGrVM3Z0Ou6x7cUYgXYn+BcFXt6+YgjwKpbwb0JGBw/RlzTjnYREhRChgNCs5xgt499PXK0l1dEOCFNZLZjwycg+0ZXKSISJU63w7z+C0Io4K73prwQryLxMTjEzgU19qqoIp+1T1363PRavA6DHeIhAsKq1ueLFxVW/Fi3FxOekMri6rNbwoFfHpZDiTrS8jr0+upSyhoQ9cKyeVUCgaxnXz9I/+pTHDykv5EdnxT7NSFt9YP0bYSKTQuMg1NrEIQjwDXgJCFttYRmMHVfhqz3iFe8qD02hIT9QE6OoyhSpksLziC0J/UBJj8jTWDp9yodaCYFzen7MHQynVM1QofLrqiTvXFsfWXjU8DHpymaU1HWU2EPp6zAJgPOqGLPU15Cifg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(82960400001)(4744005)(6506007)(87266011)(6512007)(2616005)(4326008)(6486002)(2906002)(86362001)(5660300002)(33656002)(316002)(508600001)(71200400001)(38100700002)(186003)(66446008)(38070700005)(66946007)(66476007)(26005)(64756008)(66556008)(85182001)(122000001)(76116006)(91956017)(83380400001)(8676002)(36756003)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SVpncHNnaDhNcHdlV04wRVZHSCtvd050cVZ6V01Ka0d4ZG9CWmVmcmt1Nnds?=
 =?gb2312?B?VFcrQ0dUQjB4RTVRSkRDSEp6N2h6Q2pHcDQ4czl2UkZrdDJMQ2k4YkVScTZ1?=
 =?gb2312?B?dzd6ZTJVd2lpbGVRTGJLajdXM1llRHhOb28wa2pLbjFqZjdiMXVtQ1pabWFy?=
 =?gb2312?B?MGNsY3U0OXNHdVNZQVZYQlp6V2FZcExiOTlLZGZQTVF5R0JDOGh3ckJxSmxw?=
 =?gb2312?B?YU03bzNSanVwVFNOckFnK0tyM1QrZkdGazNkU1Y2ZjY4aFB2eGdtVGxGNSsy?=
 =?gb2312?B?cWZjY1NjSUpoY3JqRkNFSzZrb0grVWZwcTJMcmtlZVluMDFWN1JHVHdsUDZI?=
 =?gb2312?B?alppakhZNWMyZVhJZCtwb0dKZU04YWV0VVNUc1FXY282alR6MkhBZWVsVnRW?=
 =?gb2312?B?bGZtMUN4QXZGM3FCUEx2QjNBMkhHQjcxeldOU2FjZGR6aFJ6aDV6SFJCVDBL?=
 =?gb2312?B?RWV4WHRXNG0wVUhQT1pndmp5N0Z4WWl4d2YzQ0lybTA1alpVUS9tSE9vbjRs?=
 =?gb2312?B?bmI1YUdKejhSc2tTOWpDdU5uMURQcGU2Z2M4UkpEWm9PVTVpeUpNaWtBNXg4?=
 =?gb2312?B?MkZmR2tQS0Y2cmxsNDhxMU1jRDhxSlk4QlN4dDhGbW9uQUM3Q2NOVURvaXg2?=
 =?gb2312?B?V21aWUxXMEZVTjJzWE8xRm0vOU5KNTRVSS8waGhnUXNWZi9jOEtjY0MyeHFz?=
 =?gb2312?B?QmJSV0tJbk9CSDE0RmhRMUFFNE5RVzJUbXNveTRzQndZUHBNTTF3ckFhMmc2?=
 =?gb2312?B?aEg1VVZlVGJZaTdIT2U0K0FBNjRQLzY2Q2x4TDViTktwSHBFckdpdzUvU0Mx?=
 =?gb2312?B?M0dvUzN3ZmdhMVB1K1FObk1CR01vNHppS0I0QVpGME1xcTNRWGpWRXNsQnQz?=
 =?gb2312?B?K1JqSkdzTG55d2dYWEtSd2IrMFh1c0NIWWVFZDkzUHI4YWZHcEVjU0Vhb0l6?=
 =?gb2312?B?NDNOMlFKditIdlB4b2gxeXJHcmlJRW45YTdwalI4R0JkdkZyK0VoVnNYTG5U?=
 =?gb2312?B?YmpocHZVWjdLYzJPRDJXaDlPRHBVVWJPQ0pIYURPbDBVY1E0UTRXOElxUFFM?=
 =?gb2312?B?TkZMWGIzLzFJM2tKVDNQTnJhRTJ4RmRqTjYrREgzNjJYTFYxSytCcC9mL254?=
 =?gb2312?B?SlRrdDBVL0VkaHl2S1ZLdDhpMU1CZUM5S3VXY0xBMHRER2tNbkE0MVU4Y2xB?=
 =?gb2312?B?V3AvdVhPZGpLMkd0bEJjR2NacDNSUmRlanorT2V5MWhnTjZIME1lMmtkbEZT?=
 =?gb2312?B?cy9qdlp0TXl1b3R0c1Z1Wi94dWdpVVloT1dseWNERVREd2c2SE5sTk43eEVr?=
 =?gb2312?B?b3k0SjYyWHlhT0s5SWhldDlFYlNLVis3cnBlKzdqcFZiTlUrVmpWV3hBTUJJ?=
 =?gb2312?B?N0NPY0R5djh6VERtalB0ZUp1dmQwVitBYmFxdllPZ3loTEdHOGNmUG9ZeHVk?=
 =?gb2312?B?d3laZjdnQ2RVRGd3a0Q2TzBocmtkTXAvak9JSXFYQjEzdlZjMDNUZlFzOEpN?=
 =?gb2312?B?bmJlQ3ZSYnhUUXZhb2MyZ3R3dzJiQnBkUFNSdTdHaHhCSTdJS09lcGoySGxH?=
 =?gb2312?B?MUZZSGNDMmNuaXliOWdZY2xubDZZeExZV0hqVUNIeG4raEEwQkxLSnEvZWh1?=
 =?gb2312?B?bDN5RjdnQXQzejlQOWtNbXVwWklCNVJhZXFrb3JJd3BkZGZhZXZpbitFTjl4?=
 =?gb2312?B?OFV2dVZPV3lUTUg5Qnpxb1djYUszZThzVEk2L1lKWlBCK04wWUREaHJ1RERo?=
 =?gb2312?B?bTRrc1lQZ1JhVXRBelZFempUU1dGcjNhcWJmTSsyTG5URjFSMGExd0loYWdS?=
 =?gb2312?B?MGlGTGl4ZU9ON3Z6V3lKbWJJMUJHbkYzUHhSNzNzM2tDZ1BVSWpRVk9rTFJI?=
 =?gb2312?B?QjEvYndHcWxrRmVKMmlkZ3Q1MDAza1JVcG00TkZPVDFkTmhCa3VDYXgyNDdZ?=
 =?gb2312?B?aEQ3V0JES2QzZDlaaDVZMnRRSnphUXVBV0xnRS9PR29tWUp6YllxbEdkNy9k?=
 =?gb2312?B?bXJmbE5kOHhISWxFbHRvbVhncEEwN3A3czF5SThVT0JLcG1wdXE4eGFtU01a?=
 =?gb2312?B?VU5VOVNUdzdmem5MNDlFc0VLS0FBbHRsWlZEU2dFdkZTOFpkRlh4ekNGZU8v?=
 =?gb2312?B?MUJVMjhrUjdGY0d4djJlQmx5YktGQ3dhOG0yM3ZPSndPWEw3WEIwOFh3TVVp?=
 =?gb2312?B?OVpOREFGcC9rUGRvUGpRY1BiSW5UTEtYU2VNMWhYcm5ESFdzNTdNcWIvdVQz?=
 =?gb2312?Q?K2970wvgyfzPAVzRca9XdbnFO2NthKq2x98eAx6Eyo=3D?=
Content-ID: <925F64E33D043842B2D7EA7987CD1C60@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d1f17e-ea63-41bb-8107-08d9bb85f8dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 02:37:12.9448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZT65vhcdNSqCrHzPXwX3izxJli1BjnIKpvlKidMdxbiWBtPr96hZXrfj9g/RuiG/YItcW9UPyx63otFgqlzp6sTQm8C55c/kaGui7brL93k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4621
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] testcase: make use of needs_cmd version
 check
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
> Hi Xu,
>
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>
>>   testcases/kernel/syscalls/quotactl/quotactl04.c | 11 +----------
>>   testcases/kernel/syscalls/statx/statx05.c       | 13 ++-----------
>>   2 files changed, 3 insertions(+), 21 deletions(-)
>
> NOTE: you could also remove #include<stdio.h>  from both files,
> it was needed only for popen() pclose() and fscanf()
Good catch, I also remove useless tst_safe_stdio.h since we remove 
version check code. But statx05.c still use snprintf so I keep stdio.h 
in there.

I merged this patch, thanks for you and cyril's reivew.

Best Regards
Yang Xu
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
