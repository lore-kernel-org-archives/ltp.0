Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2024BCDB47E
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 10:16:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 914583CE040
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 12:16:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A26293CD3A5
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 12:16:07 +0200 (CEST)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3FFAE6012CB
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 12:16:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697192166; x=1728728166;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=WzhP1yQZx6VKSHdRvnb3ZlG6+imbcIy0p2I7iwTbwww=;
 b=tSfmtaKsua0j1oIvhiS+IRg3suB0jUW9SLQSbZ3K2Ws4xdfvROG9wYf3
 Hs+H5IcjUW3Smv0juHEb2nTk9nXAmuxmfrkptVomuEbmw7T6uJD9z9165
 rkNitqC7obfxPOjqn60kqRY08APOcpt6Zy76lnnk+FLlBUN/qmMWKn6U+
 bjBTyDtnakOSR4yIMRauxRa2/dRF4zt0QDd2H+9FgIVncJyeD7vQO9Owe
 oeVOQOwujsBlhLZv4uWRZPdjebUm16qM5+dG4xGO+S9MBrdLVqk7nhFVn
 xS546Yhl15NExjCkODBiGx3vKrCv0t02BnhVO+gAMOphJlXzRlO2uPfvO Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="12125644"
X-IronPort-AV: E=Sophos;i="6.03,221,1694703600"; d="scan'208,217";a="12125644"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 19:16:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5yQFcJwCOQLl/2s8HJs/hXBweTrLTuqoUjdZHfaOEvX98em5YfIzOIxRJyiW+4XoSc77NybIzgOiglUTv1QjV9e1Frr5qMAZAlVHPUs3u6wLTL0uO6+YCTlsLUaYSIdJUwuSfLdBZdsliApzO5EXHeH5viOfMatvkYF+UoNBUKE/xRDSWAn8zLyxjSzvEiZfwM2CKd1C12gJHPrIL2CluuvWdKnD5mFihKyZC37HUR9PxDnkbEHeNVEYpqIqfu0u8XhnXk+Nejn+NS2CUnlIuzuaKuDXathvMOeHKgmSbKx2aZSQ8z9artLK+njKjt2Prq7IVGYQuCr7qySiQ03rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzhP1yQZx6VKSHdRvnb3ZlG6+imbcIy0p2I7iwTbwww=;
 b=AktXmLt0c7rOb/8BOAdZlLxDt01rERDy/6gj/8e6c1SjB9whzHnd9upb1c+XQjnQqCpVQwK2xv76r/HwFRNKr3kBDcg5Atyz6a2lpvLNHyQHSsd77EUUr2l2eK/jzxAfN+d6S1nb/I+NCOWCIzGMXaqODDv5rEtOd7/RNZ2dxk/cDm4v4Gbdeydz4zNpKScsNOLBRDfZYP5GQvq4Qs7zJvFqKG3UM7CDYZOq/OoxHHv2HtabLFN8xBiSnko/9FP46pBcb5pAT1QJH6qx0frhZOj67YGWhRvSV23RnOAUUwJhz3t/F9SbX8io4UfYkmqvBBmVu1+nJIi5VuJegxc3dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYCPR01MB6046.jpnprd01.prod.outlook.com (2603:1096:400:49::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 10:15:58 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::a5d2:bd3a:8420:bd3a]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::a5d2:bd3a:8420:bd3a%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 10:15:58 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH 1/2] syscalls/fchmodat01: Convert to new API
Thread-Index: AQHZ7Eug9Be/6P4hYkOuIbSsVyDmYrBHo+oA
Date: Fri, 13 Oct 2023 10:15:58 +0000
Message-ID: <ae8d819d-238e-daee-4b1b-3806237b153d@fujitsu.com>
References: <1695273748-4607-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1695273748-4607-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYCPR01MB6046:EE_
x-ms-office365-filtering-correlation-id: 7f99e77a-7de5-4aba-5e63-08dbcbd564f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v3ZTy3PL77qqNhFlHdBVgIjDoE0NASPT3YR/0V+pEwx7uBIIan01ZovKcKACVzj98uJxRHdIWPcu8Z93PDD/xnvCEu/l1pPwSU/oYHUxuHCoC0z+UWiEC9QQKdiXtW5l02VaBT9OS1EqV4Syu0Bd/QxXWgmx8QFXU69hUt9yUfNM0CEz4iBG3PCUzOlTcg1lVVX7JkqsxWiLERYLPKfPenMmLd5cuPdul9xmf+ONVDXqUB/l10usGUzHLmm0ytYk9n9RwHZS3Akh0yoHPTIcUkLvmon2crS5utda4xPdxNBImgIOrJhXq+nAn5kQ7lTDRODLC6/j6Y7eOfQTGnInLdQjPt3X084fUjCPICAXPPAQzpDUcofIhRuhqyefWAssDyIMl5PjmS3SEsF/LyOtfrNsw8OFIHEh3bHBKJsEKT4JrrCDk4PAh/5OyNGS2g80FPDi1dzFVcCB2PHqwJkF90tTgznok9PF8rEy+Fnz77PsQQ1Df39dIVALN6v9IgU3xV2Tdo/Mj2xZayoehfene9cIm0LJ8sSz/Rgn9kKAPBkGTxs+8QLCzPzwhskcj4Ryrd177xsLEIDjCMn0/SYZGVzZivITw8j1erj0RhlP1N8QJSyY1N+OupX6iyBO4VNOfxgrh4w8LJiMQwK0WmueSgiH+zyvetFZHfiRw1K4qBH3Nn8CTrf/6K53Dglfwe83
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(1590799021)(186009)(1800799009)(64100799003)(451199024)(316002)(6486002)(478600001)(76116006)(66446008)(64756008)(66476007)(66556008)(66946007)(6916009)(2616005)(91956017)(71200400001)(26005)(6506007)(6512007)(8936002)(8676002)(5660300002)(41300700001)(2906002)(86362001)(31696002)(122000001)(38100700002)(82960400001)(38070700005)(85182001)(36756003)(83380400001)(1580799018)(31686004)(45980500001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWxjM2xNcEdmVkNidW9Ib21PS2ZON1JrUEdLWWoxRkVUSS84T1E0YWtMdzhQ?=
 =?utf-8?B?MDVtQ1NhZkI3R1puME5ERCtSajhrRFF3RG9XOXoxelhxakFVV01Ud0dQaXZj?=
 =?utf-8?B?NGhRajhoU1JFYzI2NU81UERmVGtzUDRYV3NYbnlzaHNOYXB4V1FSWWppN283?=
 =?utf-8?B?YVVOV0tjdG5lVDN0NW41TEYrWFI2Y3RXbzl5eTgwTmd1ZC81Z3ArZS8wK0sv?=
 =?utf-8?B?QXVkeUN5SmJNaEV6QVVWRUU0Z1RTc0d3b2VrOCtWWGp4L2ZTTXBzaytuZDN0?=
 =?utf-8?B?WGN6MTkwRWE3bG1uSHBaQSswYW96dS9JRXlpOXVFcjlMVzdFQnRyem9TR2xW?=
 =?utf-8?B?Z0o0NTAxZ0VPdDhJcjZFKy93bExZVFR2MkVQRFpZTlM0SFZFZFpiN000TytV?=
 =?utf-8?B?cTRpU0ljQkRWYWMxMzcxeGhqUmRwZE9LeTlmWHlLcStrTk9jR0tKVGRCNTZr?=
 =?utf-8?B?UW16TXJhRUUxUkIyNEhYNUs4OE5mN0w2NzF5T0UwQXp1TEhScFd1cWp2SlpI?=
 =?utf-8?B?bVkzbk54ODZuY2pUcUNBblF5UW5xUkZaZUwyQmNEZ2Zuay9uV25ZbVJhZzg2?=
 =?utf-8?B?S1lpb096Y2FnVzRVMlp1dFNuS2UzZVM3bnVOL3h4cFprSHFKMUF4YU9zUUZ6?=
 =?utf-8?B?NXZWdVBNUmc2QnVxQlRydldSTUd5MTRnTVUyTjB1d3lUNk1SZzk2TWhSV0xR?=
 =?utf-8?B?VDJta3dTYTdNMHpya1R1QjlvNDBlb09BWnNvWkY1a0FKY0hud253ZWtRREdD?=
 =?utf-8?B?aU9KRGMrN0dXTU5RRHROOG9IRkE5dlB6bVRDSnFHMkQvZDRobjliV0JXQ3cw?=
 =?utf-8?B?QzNxQWRPOVczbnpLbXdJTE81eFMzYW9TZ2ViTThhV05TaktqUmJnNVIwNjNH?=
 =?utf-8?B?Y1crY1EzOHA3N3RNNmI2b09nZ1FZOVg1NzRXUDN1UWZrcUZjRTc4VnUvZnNZ?=
 =?utf-8?B?VnNrL2YrR2I3citjdEpUSHd1dnpZeGhNeTVxdkEycnZrejgvNHpiWlZ4V21N?=
 =?utf-8?B?ZlphZVZrdTJtL21oNzMrY0dleVI0dUZrQ0RyN0NBSzloeExaOVpPSDRSaEZN?=
 =?utf-8?B?cVRsRXl2UndwZ2NaUUsyZzhXOUJCRXR0NzFaalhMcGdveVphQnpZdHpwajl5?=
 =?utf-8?B?T2NqQ2IwQWpjM0Y1UGpXQ2NrUUwwMlZOMjJHWVBHTEx4dHZjOTlybEd2N1NU?=
 =?utf-8?B?MHV0MkZOQWQ4ZWd2SEs2QW42cVFMU3FMZzQ2d2dUVEcxUVpvNml0R2gyVFAz?=
 =?utf-8?B?NHpxbklJTVJrRW05Y0RVcFdSdUYyVGZyd0N2RzhqbVBhamZUZ2h6bGRRNDZJ?=
 =?utf-8?B?bTF2S0t4cnk2ekNZQUV6TTV6MnNJMjVUcmc0Uk4rZ3pPdHRoYkFNY2w2MWRW?=
 =?utf-8?B?eEJlVUVtVjFkYWlSNExTLzRmR0dyT29mMEdWS0d1bEo1T2pxRVhRaWdZaXd6?=
 =?utf-8?B?ODNBT3NJYVMva1pEL3Q5YlVvL2VjY3hzMUxuMFhFTTM4WW5mRGJBRkF3dWFl?=
 =?utf-8?B?SWhHdllOOWR2TmZBbDNuTUxtK0pXTjBNajgwWjJvMDMvNS9Ubm1tWEl3b3pO?=
 =?utf-8?B?QWsyMitiUGltNUczTUFNc3JIS2lYNzY3RFBLN0Ftb0FqS2hEbFYyalJVdnpp?=
 =?utf-8?B?TnlQbVlFZlZVYmwxSE16ZEJ5UWtSVC8rZU9RNFBSRDR1UlBlSDhOQVlZVzRw?=
 =?utf-8?B?SmF6UHM4dS9aUHoyUlVuU1JBMHJ3ZHVGQ0daMmlRL3JoWVBNNmFrazBzWnRJ?=
 =?utf-8?B?K0FTQjllei82VStsZi9DeHNvZzFWdERsS1kyQ3EvU1FHN1hXVE5waGZZNjk3?=
 =?utf-8?B?OEgxenpKTWJEZXhTUWIycWhXM095TUE3VnZSYXdNcU5ESnlFV29NMHIzVXp4?=
 =?utf-8?B?Y2ErSUNGTk1vSFlJQyttVDVmSXBVci8xb28rblZTRDRVL1ZiSWM4NHU0bXRE?=
 =?utf-8?B?RHRNUGJndzFkcjRhclhEN2o4WXIrMHJ2MGs2REtQdXV0Z0RsVS9JTll1bmRS?=
 =?utf-8?B?TU5vTldIN05uYWZhZFprdGN2UmpFQTFsaFNlejNDYkk2Y2dxNWxYSzNaS2dm?=
 =?utf-8?B?K2FUeGdjeGg0Z1FNLzJELytFNEJMaFR6SzlTUGJ2ZVQ4c0pIRkI1S0lybzE5?=
 =?utf-8?B?ZExLWXFiMXVXWUhacnB0dm1MVlpXQytoVmxLeGl4U20xdkFwVkRtMU5weWhh?=
 =?utf-8?B?UVE9PQ==?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6B1cwr+XDCSjbOi10rF/QOv091TSq0O8jSNAt+cDukSTwXUMONvB/T/S36pJHe6wjEfxslr0rhOXm8Bfq3vuX7ZtqWEWTnRcwharUslnFTlV1kwdllAWB4C325ack/X6/VeM13MkXT16TtO6xB9jl91+zd5W8Wu6iO5ODjUopd2gIKoh3E70ZDAvPQu63DzLJZixVC6+4i4PsPAhXA2zKefZOGZ3chf6b860DMvdh5ExqmglA6vsyeKKF/JCabsAvPRwNCidOPOCn1VyoURiCNxJXLhzhHTde5jNuPhysbkaXY+bZ52/FFoI8nRds28/vvsavVUlcky08m195+KPA0Iirez3CrnCIEnUxrWIYtCgas3NwfxQpN4yamqwyXnpJ+a2bZuuizUG/3mGLzRWYohMpf8p+mt5KRXR/h82tBmZ1y+NNafpH3cJZJ1yn7RU0tDCi9oI9pE4c7KPT3cv3XjYuqw+6bgxcAbtL3zBH0+9Ov90PvIx2v6mXf2cyjHkmdxT8farTIU85a2KEkUvtG/l+55dPSHTshtolxinQRfn3bc7on9kh3S1bd2q0z0iYkSf5M52Trwz3YODM2qd9PiYekgqGp2e2fG/8+ygXePjRUvghmz/ND5crFrWLhKxKLbvQGisZIEIRV3GnQQT/Qj6juPYyG/PTKbUy2/OE7CQWRzAscP8fJ1p0yH0+5tiud55jL4ROgqsNF8JcJsWSzsehvGDkXQN0KDvHSLC8m8aGk4QrKViv7IqF2dUZ7xYiOSiPJLQq7X0pbVZ7WGR7Q==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f99e77a-7de5-4aba-5e63-08dbcbd564f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 10:15:58.4919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iqvc3wDxJPZHEDZtuFUTft5J2AZE4qdlUrvYxGJeaRLw1I5n/5hxeHafg+mJMg1KmFhQA+7xFS72ty6BIEwIwLFxgOEncNmOjfTwYqOUCoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6046
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] syscalls/fchmodat01: Convert to new API
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

HI



Ping.



Best Regards

Yang Xu


Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com><mailto:xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/fchmodat/fchmodat01.c     | 103 +++++++-----------
 1 file changed, 42 insertions(+), 61 deletions(-)

diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat01.c b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
index 3deff0ebe..d9db4ec10 100644
--- a/testcases/kernel/syscalls/fchmodat/fchmodat01.c
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
@@ -1,99 +1,75 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2006
- *
+ * Copyright (c) Linux Test Project, 2003-2023
  * 08/28/2006 AUTHOR: Yi Yang <yyangcdl@cn.ibm.com><mailto:yyangcdl@cn.ibm.com>
  */

 /*\
  * [Description]
  *
- * This test case will verify basic function of fchmodat.
+ * Check the basic functionality of the faccessat() system call.
+ *
+ * - fchmodat() passes if dir_fd is file descriptor to the directory
+ *   where the file is located and pathname is relative path of the file.
+ *
+ * - fchmodat() passes if dir_fd is a bad file descriptor and pathname is
+ *   absolute path of the file.
+ *
+ * - fchmodat() passes if dir_fd is AT_FDCWD and pathname is interpreted
+ *   relative to the current working directory of the calling process.
  */

-#define _GNU_SOURCE
-
-#include <unistd.h>
-#include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include "tst_test.h"
-#include "lapi/syscalls.h"

-#ifndef AT_FDCWD
-#define AT_FDCWD -100
-#endif
+#define TESTDIR         "fchmodatdir"
+#define TESTFILE        "fchmodatfile"
+#define FILEPATH        "fchmodatdir/fchmodatfile"

-static char pathname[256];
-static char testfile[256];
-static char testfile2[256];
-static char testfile3[256];
+static int dir_fd, file_fd;
+static int atcwd_fd = AT_FDCWD;
+static char *abs_path;
+static char *test_file;
+static char *file_path;

 static struct tcase {
-       int exp_errno;
-       char *exp_errval;
+       int *fd;
+       char **filenames;
 } tcases[] = {
-       { 0, NULL},
-       { 0, NULL},
-       { ENOTDIR, "ENOTDIR"},
-       { EBADF, "EBADF"},
-       { 0, NULL},
-       { 0, NULL},
+       {&dir_fd, &test_file},
+       {&dir_fd, &abs_path},
+       {&atcwd_fd, &file_path},
 };
-static int fds[ARRAY_SIZE(tcases)];
-static char *filenames[ARRAY_SIZE(tcases)];

 static void verify_fchmodat(unsigned int i)
 {
        struct tcase *tc = &tcases[i];

-       if (tc->exp_errno == 0)
-               TST_EXP_PASS(tst_syscall(__NR_fchmodat, fds[i], filenames[i], 0600),
-                            "fchmodat() returned the expected errno %d: %s",
-                            TST_ERR, strerror(TST_ERR));
-       else
-               TST_EXP_FAIL(tst_syscall(__NR_fchmodat, fds[i], filenames[i], 0600),
-                            tc->exp_errno,
-                            "fchmodat() returned the expected errno %d: %s",
-                            TST_ERR, strerror(TST_ERR));
+       TST_EXP_PASS(fchmodat(*tc->fd, *tc->filenames, 0600, 0),
+                    "fchmodat(%d, %s, 0600, 0)",
+                    *tc->fd, *tc->filenames);
 }

 static void setup(void)
 {
-       /* Initialize test dir and file names */
-       char *abs_path = tst_get_tmpdir();
-       int p = getpid();
-
-       sprintf(pathname, "fchmodattestdir%d", p);
-       sprintf(testfile, "fchmodattest%d.txt", p);
-       sprintf(testfile2, "%s/fchmodattest%d.txt", abs_path, p);
-       sprintf(testfile3, "fchmodattestdir%d/fchmodattest%d.txt", p, p);
-
-       free(abs_path);
-
-       SAFE_MKDIR(pathname, 0700);
-
-       fds[0] = SAFE_OPEN(pathname, O_DIRECTORY);
-       fds[1] = fds[4] = fds[0];
-
-       SAFE_FILE_PRINTF(testfile, "%s", testfile);
-       SAFE_FILE_PRINTF(testfile2, "%s", testfile2);
+       char *tmpdir_path = tst_get_tmpdir();

-       fds[2] = SAFE_OPEN(testfile3, O_CREAT | O_RDWR, 0600);
-       fds[3] = 100;
-       fds[5] = AT_FDCWD;
+       abs_path = tst_aprintf("%s/%s", tmpdir_path, FILEPATH);
+       free(tmpdir_path);

-       filenames[0] = filenames[2] = filenames[3] = filenames[4] = testfile;
-       filenames[1] = testfile2;
-       filenames[5] = testfile3;
+       SAFE_MKDIR(TESTDIR, 0700);
+       dir_fd = SAFE_OPEN(TESTDIR, O_DIRECTORY);
+       file_fd = SAFE_OPEN(FILEPATH, O_CREAT | O_RDWR, 0600);
 }

 static void cleanup(void)
 {
-       if (fds[0] > 0)
-               close(fds[0]);
-       if (fds[2] > 0)
-               close(fds[2]);
+       if (dir_fd > -1)
+               close(dir_fd);
+       if (file_fd > -1)
+               close(file_fd);
 }

 static struct tst_test test = {
@@ -101,5 +77,10 @@ static struct tst_test test = {
        .test = verify_fchmodat,
        .setup = setup,
        .cleanup = cleanup,
+       .bufs = (struct tst_buffers []) {
+               {&test_file, .str = TESTFILE},
+               {&file_path, .str = FILEPATH},
+               {},
+       },
        .needs_tmpdir = 1,
 };


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
