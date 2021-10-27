Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C89C433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 03:26:26 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB4061073
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 03:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6BB4061073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E40EE3C688C
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 05:26:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7ED843C67EA
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 05:26:13 +0200 (CEST)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B11E91A00FB5
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 05:26:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1635305172; x=1666841172;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=udzx/MJDTFMbYmL1NuG4+Lbn9GQCjxezG+Q4BQaYBzg=;
 b=WDb4fqFaMdTRuk/HDoYqi7mlrB6XRtkppaxPQx+iT4xCVRGAV94cPtOY
 gDtpm+bhKtVAcm9nI2j9Xj+v/w5WY+NY+K07MnjG1vVw99JFYDPO+MZbw
 0ISBttzoC3SyrQvVtE3c9Hg2Zsx1IMPL/a2nVqnv7tBJlYtZGp+JL4XBR
 6JZtKJUjbMUI7eAQYbOJxhUDYuT5p36SYdlZrw3JiXtWbclD5yz4tUaWB
 3LLNuCk+av2xD8TbJHsW2oDr1giIPLduVe0t4Co6atamkLapX3po3sQiQ
 ya2IVL4sUVzZS+9zffk5RHDtTkZHd8lcH8iOKzAqTcWwKngg2YEjQ6P8Z g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="41958202"
X-IronPort-AV: E=Sophos;i="5.87,184,1631545200"; d="scan'208";a="41958202"
Received: from mail-ty1jpn01lp2051.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.51])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2021 12:26:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ln3Z/zdqrbmjOBbmAzTmhqAuqCDmq+hUhSdN7vdtH+ebiMQqgrpzJVi8oxbmgaKVKBHDIdHDqDPJJ2wKXN8305ln9ILZqDHoCeis7Pz0MgpsdXvEMMVZNxVRHczDaeZZzejpJltfFdGrGNHkNoavML6xW/PYl5hYQYCfMAq5zHM6uaIM6qVklDBmXLQzVaeOHp8BBUjb8vjAh5qjl02RlF57Afdx//mXNDlKlKxFjrLqk+FH1aZhbWvWC5oH4smOdKJoQBamD9fQiOTkMll1xKP5fi3j6jadYgFLoMjkKO3woQeWHbXlWvZllMuy+Qo0EYTonGcVikD6W7gZ+KA4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udzx/MJDTFMbYmL1NuG4+Lbn9GQCjxezG+Q4BQaYBzg=;
 b=kJd1WUxpGQ3bALDUJm+hwigc/kz7y4Szg0t4yqXggba6eYVjN1phMYUQIyiq30siax8m1ei8YqlujkHlpxG4HE3rWvPVRmpvK4kPZJM8GGqgtbLYN4j6c1nF0HCdbsAl6q1klh7eTEvJCJOZJ/J8ZWOb+kyvDYYdL3RTgqsL0uJTKivdYB57Uic1+q7YahroQGWk42gqg3niYhStOzFQIJhmInXz6Y/qqZkb9Ipt0iAVi3+/teT9uQoFJ5hVue/8CcI1EvHDCdEM67/JwED+TXQZeEm4qwekQ4Yuwu4QCW6S3MdmSf2w3y2gRq3971dYG9pqpmRVdTj8KRnTt+oTwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udzx/MJDTFMbYmL1NuG4+Lbn9GQCjxezG+Q4BQaYBzg=;
 b=WgqUhhgCBcQyOWz+gTzBSb8L4YJMWYQDXp8XhFUCysMuBufH8MIuKPa5ZCZ/wgq7XbqdoX2zaU5jKQtcwxqnV29RJNnoxGt9prlrsh7j4ag6EOBOdftVV799lMpLLbCn8ZBoXidU8WK4ParBs4mQ6XM3P8o8Ah0Ha9GSfirRqgE=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB5387.jpnprd01.prod.outlook.com (2603:1096:404:803a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 27 Oct
 2021 03:26:08 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9%7]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 03:26:08 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v1 11/11] syscalls/quotactl09: Test error when
 quota info hidden in filesystem
Thread-Index: AQHXxCJqQPcQAzbal02D1casekQt7KvlZuIAgADVoQA=
Date: Wed, 27 Oct 2021 03:26:08 +0000
Message-ID: <6178C6D4.6090109@fujitsu.com>
References: <1634562996-6045-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YXgToPshvc9WiQ9q@yuki>
In-Reply-To: <YXgToPshvc9WiQ9q@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f40d950-dcd1-4152-975d-08d998f9843e
x-ms-traffictypediagnostic: TYAPR01MB5387:
x-microsoft-antispam-prvs: <TYAPR01MB53874245A8C90775435F403FFD859@TYAPR01MB5387.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AuG4ce6G2KXd3GzYHXU3ZgPoJ3WpEBfVKMk37kpwlTMYgtFczFtsURiMwAUciUc5zLOxHyv+9Y+6h6A8r4z8cBpol7GGIBMTe9KNuWbW9hbPnEmMyAKcXNQzDY8oPoQZubszGXOOMakVD58ZYy2cHfL4NVkIknP8lLcKLAuqiJKgNnMywW3hKdt27xDxumTMbJNVZmF1PfXIf957grm2P53hz1KP6HW0hs4WumtqrdJtTOeptJx7ZePxyYK/0p2QICmdhOwj7htIoBl9ULajAOraw7Xg4FD4GAA3m/YgQEvUKk4npK6+5kas3fKIvdcjPZykOVCGJTPVC25nlejrh+ojuRWfiuDEezw7lqn004MYX9vNgJWZuhMQdIC/etRUzFe69U/u4fL93t/Hu3uB6+k71FtnAsP5UHAM651EKYtG+PsibKBvPBsYCvLU50kWSR+fSL0lbLhTDhR/rbKXH1Sm8LgFDqEMwI71946KPr4fkoOaZjFCiysKuBuCwSjvt4Ob4aWILTTWA3/b8yEA+SkvxzNZmkmrF6sEwST6CGvBn1nI4mDLHERX5JFdDen4xZPhpPKwnOuroDwMIxQp0vUD8V/VmpzzGEQ9JR+4ONsW0P9vjugnGGS0DTW4NMymu9lf8/j3eUZGM1eW1eJ6+XCf7D9AymyB1G30QwpLjr9St9nZpX8NDSP6vgrdrIfVO5yGbTlkaiCa5YT3vBCAAQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(66476007)(64756008)(6486002)(66556008)(83380400001)(15650500001)(508600001)(316002)(6916009)(8936002)(82960400001)(66446008)(66946007)(91956017)(76116006)(8676002)(38100700002)(2616005)(5660300002)(71200400001)(86362001)(33656002)(2906002)(36756003)(6506007)(26005)(38070700005)(85182001)(186003)(4326008)(87266011)(6512007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ajUxZGUvMGZXdWRZMEpYS3V2V0hCRUVlLys4SHRvZmNaa0drK2JVcUFGb3Zj?=
 =?gb2312?B?TFFySWg3Smk2ODlFdGljdG1sQ3J6VGpGZTJsYlA2NHVpSzVqQ3FmMnN3QURo?=
 =?gb2312?B?Tmd2dGRQS081dzBrYlJZVndUN3VTR0FTdWxabkJwT2JERURwTWh6QnhFQjF0?=
 =?gb2312?B?dWo1OGl3YkVuQitqNUQvem9mMDNJZTZlWDdFcWQ2dzdQcFBzamJZd1hzRXJQ?=
 =?gb2312?B?N0NWU25ZcmpkcHpuWXd3Vll4RnZBS3ZEaFVFZitDMm1rdHJXVkV5SFMvV01n?=
 =?gb2312?B?eC85SEhxSzZFci9uRi9Bdk9paXhEdExIZXNVU0xnVFp5MXJvTVJIU3pWT0tG?=
 =?gb2312?B?dlNMdTBuR1JFT1pLak9RNnlieHpuNWVqRW5aNTlCSi9jM3ppcG5uRHhxVnQw?=
 =?gb2312?B?WFVUSHBCcXVQV1NvSkwvUFJpbzI0NGQyS2E4MlMyVUtxbks0SWVESHo5MDc1?=
 =?gb2312?B?aS85OWdabW96OG9UL25obUpIQWRWTS9SQjJNeGt5amQ5d0JwV2VmVmpBZE5W?=
 =?gb2312?B?V09PTHcvV01rcjkrbW15cndmYmNKSTBrQlFrcW5YbUlKYTdRa0pjbHltRXBw?=
 =?gb2312?B?VG90ckdrZ2lTOFl0bCtPcHBFOVlaWGMxL1JtejgzNWQ0OW5QRXhrMGx3ODNz?=
 =?gb2312?B?VmtGQThvdXNGeGEvRTlLL0l3RHlWemMvM3BwdnlxSC9ZTEErYllIblhIdVM2?=
 =?gb2312?B?SlV5OE5YSENqM2VSdWhCd3ZpeEhTWTE4Z0o5OXYyVVZaaTd5UXpBTFk5TkEy?=
 =?gb2312?B?R3FrNzE1SitXSnBRdm5melBZNUVmYlM2Tk40NkFoRmNmNXFDQjlMZ1JDOWpH?=
 =?gb2312?B?djJmTXZiaHBVMmo4VTE1bzh6TUpLVXZ5WjMzM2NLNHFzbFlGb0hDWVJBZWNQ?=
 =?gb2312?B?QVVJZ0puNXJIOHVzR0hUNjl3N1hHbGJBZ1QwV0t5NnYyT3hHRGYrSXZTZ0hZ?=
 =?gb2312?B?NVZPcUJ5dk54bVJ4TWhST1NIL1liTmZ5dEdtWWJnWVNQbmRNZytSZFJ4V0RG?=
 =?gb2312?B?dm90M1FiSWZYb1QxWFdsMXVHY3Q0WWNGbEdEWUFVZWpaeVdPSm9DNGRZejBQ?=
 =?gb2312?B?OHZTUDRDUElidjRBYnN6dTZ5M0pGNWthLzVDYUlIcnhpck5SQlFvZlpoRytO?=
 =?gb2312?B?NytFZTVJaTB4MTNTdW51QkZVRTk2ZU13Y25OVloxYThEWWNjRGk0c2IrRDAx?=
 =?gb2312?B?QklMbGJML204RzA2UjUyd1hRUTZyMGJMZlppOWhnUVhTT2xvOVU3Yng4RHJE?=
 =?gb2312?B?SUdPVGdmWk9UWWIxUXhrZjJXU01vTllrTG8vZEtVbEtBbjA2RFNYYWs5ZzB6?=
 =?gb2312?B?ajZUcy9xK28xVzZ5RnA0VHpTVDNRd1U0M2JBRStEUGFoenNzYUNHcGQ5SmlM?=
 =?gb2312?B?Y3d6NjJiSGgybTRCMHNrbmZ1RGNwUkE5Y0FzaFFIMVVuQWlYbUg5ZjB4b0JV?=
 =?gb2312?B?R0szMDlkanRiUzMyWTZTTUVkVVk0YWdid0E4c24zZFNjeDRETnlzT3BSNmJP?=
 =?gb2312?B?Q0ZzOHdQLzVPTG5RcVg2cUYySlJ1ck9XVWlEdmNFV1ZUQ0lxbWxGRDIwQ3Nm?=
 =?gb2312?B?OXIzTmV5L2ZwOERLMk03QnVreWZWMytJeVAwbHRUSXlsY00wOTRPUEdtclBH?=
 =?gb2312?B?ckJCVkZYY01MNDd4Q01qU3VyZ3QwekgreFMxZU13dUdYQlJwa1JPUnlxOHR3?=
 =?gb2312?B?akJXOGoyaXF4U3pVV1BmeCtnbW9NM3hRa1poSVVsS2htQlV6TmRVVzFBd25O?=
 =?gb2312?B?OEVoUkVkd3dvRjA2SGFaK3M5TXZtZm1jaGd0QTV5SmVZRVhZa1piT2VENFRL?=
 =?gb2312?B?ZWdQWjVzNUd6YWsrdUFqWmUwMzlvaWhSdmVHR3hsYmNCZGhKeUVJdC9UUDVx?=
 =?gb2312?B?dFllZGh3VUFtWFViY29kRDV3RCtuUHlmd1lyeWw4ZDdzZXJPbnJnZVlpblFo?=
 =?gb2312?B?cER5MXBvTmY1bFlvbjk4RDdyRmRheVU1ZkZXcTBpYXg1QzJPVUgvTmRjUU9h?=
 =?gb2312?B?eHB1NFhYcXBXT2lxYzR4S3FVVk5RSTZVWXZXMG5zcVlicGlIdjZKTUNpVG1i?=
 =?gb2312?B?V2lvZWJXOW5pTE51emtObXVTcTYrTjFJSUVCUHRiSVBxMVFoM2ovc3Q3QkE3?=
 =?gb2312?B?UVVyNkZDNDNiRW1JdmVoQm9FVjVSdEpQbExNbmU2dm9VK01Ha0FvRzhFWkFz?=
 =?gb2312?B?VXFoQ29xS2k4cExxWmpIY2gzQ2w4SXVVUXUvb3VQZkgvN0tMcklnQy8vaTU5?=
 =?gb2312?Q?+O6UDxZj3xfIJpqYmqyyn0pel7kTaHs3/BkkpVGx9I=3D?=
Content-ID: <E428968C6813DA498E993AF4D3A236BB@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f40d950-dcd1-4152-975d-08d998f9843e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 03:26:08.2111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +0g5hN0lFqbgmdqxjmVK840YjF3Za1twpdQDJKyQJP0w7heasyKQ0+IJOnBDb85uiOUXYa5nwoKsfav0lEL2+L0mAyWu33OUk0zLK/d+dGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5387
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 11/11] syscalls/quotactl09: Test error when
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
> Hi!
> Generally looks good, same minor comments as for the rest of the
> patchset apply here as well:
>
> - for the description comment
> - no need to include "lapi/quotactl.h"
> - there are some trailing whitespaces (have you run make check before submitting?)
Sorry, I forgot to run.
> - does geteuid() in setup return anything else than 0?
>
> Also I wonder if we should include the fmtv0 in the variant list, but as
> far as I can tell it only matters for the tests that attempt to set the
> limits, right?
>
> I guess that we can define the test variants as:
>
> static struct quotactl_variant {
> 	int use_fd;
> 	int32_t fmt_id;
> 	const char *fmt_name;
> } variants[] = {
> 	{.use_fd = 0, .fmt_id = QFMT_VFS_V1, .fmt_name = "fmtv1"},
> 	{.use_fd = 1, .fmt_id = QFMT_VFS_V1, .fmt_name = "fmtv1"},
> 	{.use_fd = 0, .fmt_id = QFMT_VFS_V0, .fmt_name = "fmtv0"},
> 	{.use_fd = 1, .fmt_id = QFMT_VFS_V0, .fmt_name = "fmtv0"},
> };
>
> And then set .variants = 2 for all the tests that does not touch the
> limits and for these tests that manipulate the limits set .variants = 4

At the begining, I also have same idea. But quota info hidden in 
filesystem  doesn't use quotacheck cmd and also doesn't use vfsv0 
foramt. Also quotactl_fd is also hidden in filesystem, so it only use 
QFMT_VFS_V1 format.

I perfer to make this patchset by the following idea

1)if quota info is visable, then test vfsv1 and vfsv0 two variants
2)if quota info is hidden in filesystem, then it only support vfsv1,
so test use_fd and not_use_fd variants.

Best Regards
Yang Xu

>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
