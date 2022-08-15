Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82F7C00140
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 09:57:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B97C33C9669
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 11:57:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D77A13C01CC
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 11:57:23 +0200 (CEST)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EEF81680E48
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 11:57:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660557442; x=1692093442;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=EKUWmOJvc/JRMausq7OqGhGyWq0Sunf0b8Y6IhENdQA=;
 b=HgJNsDJJmLiYUhsue2/x37sI8GWD5wFm3+vlzX6QycfZt0YZQbSq+bhu
 xztTwhpckWigbF2/BIMj/g9vIjbhxlYLO9kXGbYpgAG3HNqJGjBM3Z37l
 /lH4pht5y9HtJuFAZVK3p9FcoY7Epyu9l3oWLY7vBz+gmDhwmA7H2j+MA
 s1NZudpr+eDvEKdLqSpF40HnAQOZXWT3/bBcSPDhBHwJaJNAzYy8l+iC0
 gqcD6neAEe1AN23N8Kk7jXY7pwnrb3AORzpp8ScI8HA+JbzrbSfVdLCom
 TsMLC1beLXyOhCHgQFO3BgPvRqrgy4ojpIdqFFNNV3pVA3+kAsIYHMBHd A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="62842334"
X-IronPort-AV: E=Sophos;i="5.93,238,1654527600"; d="scan'208";a="62842334"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2022 18:57:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJby/RjwoexMddl/tg5QsABFVYLsGFcq8/TliMM+3Q3G1g4f8+a1y9l0RiUGgHfE7khD4IRKol1IOfZradJ7jV51fngqQ+ag/M6+wyOc6xf1NYjsu2sLoFCf6IT2VGvi6Fy4mimTCu4AO5asf1rUjy9TMaofDVleBvjf3J1PYhJE3j/uOjblCssseP7+DHuTSlz2/TBHg7XTrvwPu6Wlb/VuOMhuc7Mcl5BMgmo7Ie4G4aFeaMUllkbXnM2l0YtfoJJvg5kb3wnp4fkr73FqhxY09Q5oiCYHtU3oSNzTx1Am4nnoRpnfDclDYCvRMMVq+UYWNhurnSZze7LV4cKQiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKUWmOJvc/JRMausq7OqGhGyWq0Sunf0b8Y6IhENdQA=;
 b=f5gArPO1nrtwQgbpvVD0cgpuwzpOJ40hsf9nK69KQAx7U+WhvsRmUsu9BlnM9QAqIvCWPeS/or3Rz5YcY6Ww5TagwK+j35HZOWYX9A+x4m7XPHuowlUV0WFuqfK9lranYBh9NueRujZSpj841HWwuuCl5WQzkt/PQiESZo3x1mIHQKZKUzFX7Tl5tMpRFGOOfCO3rK435KtpvmVqamEvBJx6DHCKb8oDeAksLod/y6sUbt9o2E5L8TEQkcipDDCcY7lPukS1QWTvUd7Urh3/YiweBDKvOObrZfOO3ZZmdkFGloQLXAtqDFFS5QSsa5x+FgLNjME+WwcctDzo7k8QxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB6194.jpnprd01.prod.outlook.com (2603:1096:604:e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.22; Mon, 15 Aug
 2022 09:57:17 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 09:57:17 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v3 0/2] mount03: Convert to new API
Thread-Index: AQHYrYpdivkAy4rXlU+UH1tz7IrvUK2vgeuAgAAG24CAABXngIAACF8AgAApqAA=
Date: Mon, 15 Aug 2022 09:57:17 +0000
Message-ID: <f11fc30d-d875-0d60-6807-7bfa9998f21b@fujitsu.com>
References: <20220811135731.2228-1-pvorel@suse.cz>
 <765b4f35-2cd0-04e1-e405-04261b5ef645@fujitsu.com> <YvnqZfyByO42kAX9@pevik>
 <1e791bd1-2661-95b0-1f0b-e3ca82b6524f@fujitsu.com> <YvoDyrIGa3/BsqI3@pevik>
In-Reply-To: <YvoDyrIGa3/BsqI3@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de493cfa-6163-44df-6b6a-08da7ea48998
x-ms-traffictypediagnostic: OS3PR01MB6194:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i4yvZxY9Ap5b3dvIytXUQfS4O6pt25KPMJ2KyqPiEeJRV1BL0mGZE1HxIRvM6Ie7ukUjK2A8tHjv4Pw9pYG/oSbFgmUeVcb85IBoP/pI2ot8ZBXPpy8jCGRBEiqI8lyYbBG9K856dD9O1OCWo7BGiLRfbSUZ1LOnPR1C9E4qIiga7xMQ5mz6BSYYZSdUsRsF1pKyBhCqn5rKjnRniKqxsArYetlXD4pgXsSqA29K64F06Rn9XLOTH8uwFmCnexYcBLmWGEhO5FDnVpnWBaC4syoFIHkoLyuGbQejEo1zwxUtPJJZ/wXwdO/B2gk3g8ccaUqXfpng87UII77ew5KpmanMbeKwzAsDiP6XSf7mug4D9VI3BSIt1zhCJ+4021bukmyhu0qB45UK6LMHWJaHv53NPCt3gxEVLcWBzMc7S1e8GJe48nFN/y2A57cvZC5R2dmiM5PAGO0RkvFns2F8AVU+5C7etzgpWdwDRXLK53Uz9kN4KFmWTkffz+byEZXFu6Mume1LtThHP6i32GuOrC2gYpE/IJRNOYknApF7Z/QOCX52xSG2hmxB8c9BWVuJq8PO4Tl6LbAKBhOloLRtqvyP11UIJGLkJ4YUBO3wlZzioOkxBxK4/HuUe4Qntps6HQBh44W6XYXtDY8W690011wzReksVv+MFK0hjiafZvHSHnghfpI3fz6CwL1hJ+0ooOcGV1z5qbfDQvauzDZGSqRxRsPlLA1KfiDY/DwdQs6wg7p8zrJhZdkmSL3k/DGGp9ZEsTkcRsD6U/TJ9sZrpOTzlxkkGLejvBB/hHDMbQzvH1E9NTiQvkGLC4xGIa1ssvnvUYGZQ4p75hshuN1MTfzAvkn3WOsC5N+2x5IjA42OUYyzxUeRM+NUryq4ilk3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(85182001)(36756003)(2906002)(1580799003)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(31686004)(8936002)(66946007)(91956017)(76116006)(6916009)(6506007)(316002)(478600001)(71200400001)(6486002)(6512007)(41300700001)(26005)(82960400001)(38070700005)(86362001)(2616005)(186003)(122000001)(31696002)(83380400001)(38100700002)(5660300002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1ZkVlpPSnE0ZGk4eGtyMHdWZWJQQmJDbHlpNENKelE0NG5Uay9ick1WOWFW?=
 =?utf-8?B?THlkRUxCSVYwOUQzMlJLditESnRwMTZYekQ2Y1B6cEVoVXFPekgrbTdUbld0?=
 =?utf-8?B?YUEvQ1ZpNk9uVFJlYlp3VWVZQm9nVGhpK2FMYTRzdlQyb2g1R2hJdUtGWGU2?=
 =?utf-8?B?dTNHcWRvNUttY2pLUmc2UGxvN1BYNDhLSnZXeEhLVlZWSFhsRml0L053T0Nu?=
 =?utf-8?B?SGp1R3UvempJbGwveXFDcGd4bmI0bW00SnVLUisrTkhUK0RGVnZPU3FmVWtM?=
 =?utf-8?B?cUU0S1ZjdUZ3NDNyQVQ5R3Q4TE5NZDRTa2Q3bHFraENPV29CVHhaV1FYNndx?=
 =?utf-8?B?N1FLbmpnd1RCQTVwWEpCRWpxYUk5V3UxUzNNNWlGYTRKK3oxOGtOUWNYQk9p?=
 =?utf-8?B?NmhPL2xzNzNOU21pMnVORU9xd1lad3VoMkJtbFM5Tk5ZOTJWTTFsa3VHaWx6?=
 =?utf-8?B?Ui9lTC9UTEFVVlBaYU5naFY2QTluOEppcjBWTzlnRGJ5ZVpJV1lrcXh3djdW?=
 =?utf-8?B?aU5KZFhQeVkxNjgxWGs4cS8zN0RRckVBOUZCcENVOU50ckR0ekYybGhva0hJ?=
 =?utf-8?B?S0hkSk9KN2kzcDRyN050WkdqQWFYdmhtT0hXNmlUTFJLa2tMK3dxZDZjUU1U?=
 =?utf-8?B?OC9GYU1aK2xVUzYxQ0E5dW1ybzdibG14UHpFenFPeGVoU1NBZTRGQW9NSWd2?=
 =?utf-8?B?ZGZOd0QwYmhtclltQitFQndaRFJGWGhOVlk0Sms5dW9iOHhoY1A5bHJHaEk3?=
 =?utf-8?B?a01tVnBYVHM3UXczazNEV1grWktEbnZ4ajZDeXpJTFVhSEVLZDREWWtVcWFI?=
 =?utf-8?B?RkhMZEsrandmOVI1dXJTM2E2UXFWcFFXcDdESFhUd0hMRnFiTGYwcWZrVGN6?=
 =?utf-8?B?d2hMWm15SjhjQnlEMk82bHpPQjNDUFAxNkZCakhGVTIwdDlkNURsQjVXUU5u?=
 =?utf-8?B?RnpvRzd0T2JzZHNvY1ppUFVBZ0NiSUN0MVdpdUtyQXB2MFBURmtHZzEvWHd1?=
 =?utf-8?B?czVTTkZhZlhYTWhKQXFkdDlJSGYyU3JTNHIvNzlpa3A1ZnVxNVFETm0wUExG?=
 =?utf-8?B?ZkNGSU5iaVBFVThRRjFLZHlJRm5jUnVrMUpLc0hzREgzSmJPQTVuZ3FvSXNU?=
 =?utf-8?B?TjE5VFBLbGVRY2pJWTFMQjdtSjZuTlMySXZkdnZUZHBDbFM3TjVoNmtTanR2?=
 =?utf-8?B?SS9KTTJEdVNiWXIrL0szTlE1cjdzZitLMFJJdFJKY0hvanBTMEdwdzNVMkNC?=
 =?utf-8?B?d0trK3hTc0JXQ1ZlZTJ3NTlUbFMrd2J4Tll5bXBrRDlKZThweHBwbjlEMmZY?=
 =?utf-8?B?WU5oNDNpeUpJbXgwbjBMMzRMRE82Y0UvRUpoNjBpbjJlWVFQSmhBa1h1djZ2?=
 =?utf-8?B?cTZwdWdtUXE1UWxhMWo0T2tKaG5wdjdkMjRMSXRiWEpkUjR5b1hkb3hyc0NY?=
 =?utf-8?B?ZlE4VmJmNzJuK3FNU2xTZ3RlM3JMWTRrM0VKcFIrMlZOdE9zQXNpekhjY1RZ?=
 =?utf-8?B?NGFjREhFblNJdjZHUG96MElWU01TMy8rUUhTTWhvMlI3M01OaUJwVEtQdkdq?=
 =?utf-8?B?d3loOXlrNEZHVGJXUmcrUk9zbVl4Sy9YQkw4SXlwY2x3YzVDQjl5cnRsR1Mv?=
 =?utf-8?B?S1U3MllvYisxMEJkcmNER2tKTE9pakVybElBTWdOTE0zMW0zYUVDdHJkNlcz?=
 =?utf-8?B?L0Y0WjFoaGFlcDVGdlFJN0tTbE1FUG9DcVEvN3dIdGxlem54Z1RCem5mdXla?=
 =?utf-8?B?K2lhKy80Z1FLYUY5MTJFM2dicFdyNHpwOHZxMm1DcGNBVGllendXQjNldW53?=
 =?utf-8?B?TWhQeXgyUExPc1hrcThEL210eGpEL1JYdGZOcENiQWE0V3cwVENWcnd6bHhV?=
 =?utf-8?B?S3dnV0RIY3lpQ0pFNURkTENUWS9Wc1g5blVXQXBZcjJ5S0RhQU5VN2JaSFhC?=
 =?utf-8?B?Z1pnUzY1TWdFTDRMUmFCR3Z4dTFCOHAxdnJ3SmdtamF5d0dFVzhCOHFaUGl6?=
 =?utf-8?B?bEkxZjRzRlppRWxLeHQ5b240QnoyWGFTUEZ4WERaa3p0T2dGSHlCOXM2TWdM?=
 =?utf-8?B?U21oYmVVZENMd3NOU0VLaUNCVmRtTmorT1hOMmN3SWRlV3hQK3BIdnFOM1Bm?=
 =?utf-8?B?L1lVK0NyZXpaM3ZFS2hiUlVycm54cW5Hc3NPOW5lS21vZHlrL3dzOG1QdVNl?=
 =?utf-8?B?QXc9PQ==?=
Content-ID: <0F6D0C6431268546922E06862B016F3F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EPf5/P34JJ47kYNncibj0cK+w6nQhk1DqIp4VtaDBCEY71ZuVw3kAZMWipkRayob8tXqRSifvmyPDu1bXky7Pft5bLQwT7mDrwwjZahel6prs8bZrktHmSK1prpUjNFtCkqAMRRsa6gOQN3ujKSLv9bS1jAqKA1C5MJENDYyNIvRSqspZ2ZUA0wk5ngMANochYJmwGCs9+Rp6rsQxIg1mmIvc9H5ae8dRR4m6yBgWkB/pjnzvwr106spGVJwHBPEfSdhhOG8rQ5Hc64uyYNrAzHKx0cG5o65Rs1pKrAgyTgBvE6A8hjF1a//3vqMedeQZrFny0zvoKRjJhv0w0vStMpDKKnksqw09DxnrwxJlzGNXoXT2cKwt6JbHUxdPHZ9j+zxJkIJgdvbQOiLYoaVV095Y7NvBqt9qXpPSzJAlQsVu9947Ieey7m78hsJbNoVIeaq3O/kScBW5s66dp52rMrjaLsf6mHWLxQf3rMh3YQ+9j7m7lSMBOr5oV57D2ApHTR+QBXQQiaYiDG00Lmb0Mzv8dVCmXJAHhp/2B3fUSXzZCAl6sCb743r86C7OLh989Kmj03Ur5n8JPf/uZngru1R6HNxCtbP9OM/1aduNngzdqEXQeTcFbSLDgJ3Y9OrSOoruxeSmyBNb9cTsd1428XQbX4MBWCtw+Q/f7Jysq+61VsOtDOwI9CxU1YjjkPgxO7nMYaFVlGYbuIarRR58j4VOt+zAiy+Xwpvwz7NirXEXaR9auYgxHIaVPdBDSLS
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de493cfa-6163-44df-6b6a-08da7ea48998
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 09:57:17.4394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xJoHYfa3FTaVG3R3Nnp1VvlJvs6H45OpO447LUbRtA5qAjTij5P0wkx+glmfBLWF40+zV+vrePBe4otEKu5eM8jvMyNotOjWFX+mBMcx+Fs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6194
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] mount03: Convert to new API
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0cg0KDQo+IEhpIFh1LA0KPiANCj4gLi4uDQo+Pj4+PiAtCVNBRkVfUkVBRCgwLCBvdGZk
LCByZWFkYnVmLCBzaXplb2YocmVhZGJ1ZikpOw0KPj4+Pj4gKwlub2JvZHlfdWlkID0gbHRwdXNl
ci0+cHdfdWlkOw0KPj4+Pj4gKwlub2JvZHlfZ2lkID0gbHRwdXNlci0+cHdfZ2lkOw0KPiANCj4+
Pj4+IC0JU0FGRV9GU1RBVChvdGZkLCAmZmlsZV9zdGF0KTsNCj4+Pj4+ICsJc25wcmludGYoZmls
ZSwgUEFUSF9NQVgsICIlcy8lcyIsIE1OVFBPSU5ULCBURVNUQklOKTsNCj4+Pj4+ICsJVFNUX1JF
U09VUkNFX0NPUFkoTlVMTCwgVEVTVEJJTiwgZmlsZSk7DQo+IA0KPj4+PiBJbiBmYWN0LCBvbGQg
dGVzdCBjYXNlIGNvcHkgcmVzb3VyY2UgZmlsZSB3aGVuIG1vdW50IGZpbGV5c3RlbSwgYnV0IG5v
dywNCj4+Pj4geW91IGNoYW5nZSB0aGlzLiAgU28gaW4gdGVzdF9ub3N1aWQgZnVuY3Rpb24sIHlv
dSB0ZXN0IG5vc3VpZCBiZWhhdmlvdXINCj4+Pj4gaW4gdG1wZGlyIGluc3RlYWQgb2YgZGlmZmVy
ZW50IGZpbGVzeXN0ZW1zLg0KPiANCj4+PiBvbGQgY29kZSBpbiBzZXR1cDoNCj4+PiAgICAgICBm
c190eXBlID0gdHN0X2Rldl9mc190eXBlKCk7DQo+Pj4gICAgICAgZGV2aWNlID0gdHN0X2FjcXVp
cmVfZGV2aWNlKGNsZWFudXApOw0KPiANCj4+PiAgICAgICBpZiAoIWRldmljZSkNCj4+PiAgICAg
ICAgICAgdHN0X2Jya20oVENPTkYsIGNsZWFudXAsICJGYWlsZWQgdG8gb2J0YWluIGJsb2NrIGRl
dmljZSIpOw0KPiANCj4+PiAgICAgICB0c3RfbWtmcyhjbGVhbnVwLCBkZXZpY2UsIGZzX3R5cGUs
IE5VTEwsIE5VTEwpOw0KPiANCj4+PiAgICAgICBTQUZFX01LRElSKGNsZWFudXAsIG1udHBvaW50
LCBESVJfTU9ERSk7DQo+IA0KPj4+ICAgICAgIFNBRkVfTU9VTlQoY2xlYW51cCwgZGV2aWNlLCBt
bnRwb2ludCwgZnNfdHlwZSwgMCwgTlVMTCk7DQo+Pj4gICAgICAgVFNUX1JFU09VUkNFX0NPUFko
Y2xlYW51cCwgIm1vdW50MDNfc2V0dWlkX3Rlc3QiLCBwYXRoX25hbWUpOw0KPiANCj4+PiBuZXcg
Y29kZToNCj4+PiAgICAgICBzbnByaW50ZihmaWxlLCBQQVRIX01BWCwgIiVzLyVzIiwgTU5UUE9J
TlQsIFRFU1RCSU4pOw0KPj4+ICAgICAgIFNBRkVfQ1AoVEVTVEJJTiwgZmlsZSk7DQo+IA0KPj4+
IFdlbGwsIExpIGluIGhpcyB2MiByZW1vdmVkIHRoZSBjb2RlIGJlY2F1c2UgdGhlcmUgaXMgLm1u
dHBvaW50ID0gTU5UUE9JTlQsIGluDQo+Pj4gc3RydWN0IHRzdF90ZXN0LCB0aGVyZWZvcmUgTU5U
UE9JTlQgaXMgbW91bnRlZCBpbiB0aGUgZmlsZXN5c3RlbSwgcmlnaHQ/DQo+IA0KPj4+IEJ1dCBo
ZSBhbHNvIGRpZCBTQUZFX1NUQVQgYW5kIFNBRkVfQ0hNT0Qgb24gTU5UUE9JTlQsIHdoaWNoIGlz
IElNSE8gd3JvbmcNCj4+PiAob3IgYXQgbGVhc3QgZGlmZmVyZW50IGZyb20gdGhlIG9sZCBjb2Rl
KS4NCj4gDQo+PiBZZXMsIGl0IGlzIHdyb25nLiBJIGd1ZXNzIENoZW4gbWlzdW5kZXJ0YW5kIG1u
dHBvaW50IHVzYWdlKGl0IGp1c3QNCj4+IGNyZWF0ZSBtbnRwb2ludCBpbnN0ZWFkIG1vdW50IGRl
diB0byBhIG1vdXRwb2ludCkuDQo+IA0KPj4gU28gZG8geW91IHdpbGwgZml4IHRoaXPvvJ8NCj4g
DQo+IFllcywgc2VlIHRoZSBkaWZmIGJlbG93LiBJJ20gd2FpdGluZyBsaXR0bGUgbG9uZ2VyIGlm
IGFueWJvZHkgZWxzZSBoYXMgc29tZQ0KPiBjb21tZW50cyBiZWZvcmUgbWVyZ2luZyBpdC4NCj4g
DQo+IFRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQo+IA0KPj4gQmVzdCBSZWdhcmRzDQo+PiBZYW5n
IFh1DQo+IA0KPiBkaWZmIC0tZ2l0IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW91bnQvbW91
bnQwMy5jIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW91bnQvbW91bnQwMy5jDQo+IGluZGV4
IDc0YjAxOGQ3OC4uOWM1ODc4M2Q3IDEwMDY0NA0KPiAtLS0gdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9tb3VudC9tb3VudDAzLmMNCj4gKysrIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW91
bnQvbW91bnQwMy5jDQo+IEBAIC0xNSw3ICsxNSw2IEBADQo+ICAgI2luY2x1ZGUgPHN5cy90eXBl
cy5oPg0KPiAgICNpbmNsdWRlIDxzeXMvd2FpdC5oPg0KPiAgICNpbmNsdWRlIDxwd2QuaD4NCj4g
LSNpbmNsdWRlICJvbGRfcmVzb3VyY2UuaCINCj4gICAjaW5jbHVkZSAidHN0X3Rlc3QuaCINCj4g
ICAjaW5jbHVkZSAibGFwaS9tb3VudC5oIg0KPiAgIA0KPiBAQCAtMTQ1LDcgKzE0NCw3IEBAIHN0
YXRpYyB2b2lkIHNldHVwKHZvaWQpDQo+ICAgCW5vYm9keV9naWQgPSBsdHB1c2VyLT5wd19naWQ7
DQo+ICAgDQo+ICAgCXNucHJpbnRmKGZpbGUsIFBBVEhfTUFYLCAiJXMvJXMiLCBNTlRQT0lOVCwg
VEVTVEJJTik7DQo+IC0JVFNUX1JFU09VUkNFX0NPUFkoTlVMTCwgVEVTVEJJTiwgZmlsZSk7DQo+
ICsJU0FGRV9DUChURVNUQklOLCBmaWxlKTsNCg0KSSBzdGlsbCB0aGluayB3ZSBzaG91bGQgdGVz
dCBub3N1aWQgYmVoYXZpb3VyIG9uIGRpZmZlcmVudCBmaWxlc3lzdGVtIA0KbGlrZSBvdGhlciB0
ZXN0IGZ1bmN0aW9uIGJlY2F1c2Ugd2UgaGF2ZSBleHBhbmQgaXQgdG8gYWxsIGZpbGVzeXN0ZW1z
Lg0KDQpBbHNvIGluY2x1ZGUgdG1wZnMsIHNvIFNBRkVfQ1Agc2hvdWxkIGJlIGluIHRlc3Rfbm9z
dWlkIGZ1bmN0aW9uIA0Kb3RoZXJ3aXNlIG1heSBoaXQgRU5PRU5UIHByb2JsZW0uDQoNCmRpZmZl
cmVudCBjb2RlIGFzIGJlbG93Og0KDQpbcm9vdEBsb2NhbGhvc3QgbW91bnRdIyBnaXQgZGlmZiAu
DQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb3VudC9tb3VudDAzLmMg
DQpiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW91bnQvbW91bnQwMy5jDQppbmRleCA3NGIw
MThkNzguLmIwNTgyYzc2YiAxMDA2NDQNCi0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
bW91bnQvbW91bnQwMy5jDQorKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdW50L21v
dW50MDMuYw0KQEAgLTIxLDYgKzIxLDcgQEANCg0KICAjZGVmaW5lIE1OVFBPSU5UICAgICAgICAi
bW50cG9pbnQiDQogICNkZWZpbmUgVEVTVEJJTiAgICAgICAgIm1vdW50MDNfc2V0dWlkX3Rlc3Qi
DQorI2RlZmluZSBCSU5fUEFUSCAgICAgICAgICAgTU5UUE9JTlQiLyJURVNUQklODQogICNkZWZp
bmUgVEVTVF9TVFIgImFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6Ig0KICAjZGVmaW5lIEZJTEVf
TU9ERSAgICAgIDA2NDQNCiAgI2RlZmluZSBTVUlEX01PREUgICAgICAwNTExDQpAQCAtNzUsMTIg
Kzc2LDE5IEBAIHN0YXRpYyB2b2lkIHRlc3Rfbm9zdWlkKHZvaWQpDQogIHsNCiAgICAgICAgIHBp
ZF90IHBpZDsNCiAgICAgICAgIGludCBzdGF0dXM7DQorICAgICAgIHN0cnVjdCBzdGF0IHN0Ow0K
Kw0KKyAgICAgICBzbnByaW50ZihmaWxlLCBQQVRIX01BWCwgIiVzLyVzIiwgTU5UUE9JTlQsIFRF
U1RCSU4pOw0KKyAgICAgICBTQUZFX0NQKFRFU1RCSU4sIGZpbGUpOw0KKyAgICAgICBTQUZFX1NU
QVQoZmlsZSwgJnN0KTsNCisgICAgICAgaWYgKHN0LnN0X21vZGUgIT0gU1VJRF9NT0RFKQ0KKyAg
ICAgICAgICAgICAgIFNBRkVfQ0hNT0QoZmlsZSwgU1VJRF9NT0RFKTsNCg0KICAgICAgICAgcGlk
ID0gU0FGRV9GT1JLKCk7DQogICAgICAgICBpZiAoIXBpZCkgew0KICAgICAgICAgICAgICAgICBT
QUZFX1NFVEdJRChub2JvZHlfZ2lkKTsNCiAgICAgICAgICAgICAgICAgU0FGRV9TRVRSRVVJRCgt
MSwgbm9ib2R5X3VpZCk7DQotICAgICAgICAgICAgICAgU0FGRV9FWEVDTFAoVEVTVEJJTiwgVEVT
VEJJTiwgTlVMTCk7DQorICAgICAgICAgICAgICAgU0FGRV9FWEVDTFAoQklOX1BBVEgsIFRFU1RC
SU4sIE5VTEwpOw0KICAgICAgICAgfQ0KDQogICAgICAgICBTQUZFX1dBSVRQSUQocGlkLCAmc3Rh
dHVzLCAwKTsNCkBAIC0xMzgsMTggKzE0NiwxMCBAQCBzdGF0aWMgc3RydWN0IHRjYXNlIHsNCg0K
ICBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQ0KICB7DQotICAgICAgIHN0cnVjdCBzdGF0IHN0Ow0K
ICAgICAgICAgc3RydWN0IHBhc3N3ZCAqbHRwdXNlciA9IFNBRkVfR0VUUFdOQU0oIm5vYm9keSIp
Ow0KDQogICAgICAgICBub2JvZHlfdWlkID0gbHRwdXNlci0+cHdfdWlkOw0KICAgICAgICAgbm9i
b2R5X2dpZCA9IGx0cHVzZXItPnB3X2dpZDsNCi0NCi0gICAgICAgc25wcmludGYoZmlsZSwgUEFU
SF9NQVgsICIlcy8lcyIsIE1OVFBPSU5ULCBURVNUQklOKTsNCi0gICAgICAgVFNUX1JFU09VUkNF
X0NPUFkoTlVMTCwgVEVTVEJJTiwgZmlsZSk7DQotDQotICAgICAgIFNBRkVfU1RBVChmaWxlLCAm
c3QpOw0KLSAgICAgICBpZiAoc3Quc3RfbW9kZSAhPSBTVUlEX01PREUpDQotICAgICAgICAgICBT
QUZFX0NITU9EKGZpbGUsIFNVSURfTU9ERSk7DQogIH0NCg0KICBzdGF0aWMgdm9pZCBjbGVhbnVw
KHZvaWQpDQpbcm9vdEBsb2NhbGhvc3QgbW91bnRdIw0KDQoNCkJlc3QgUmVnYXJkcw0KWWFuZyBY
dQ0KDQo+ICAgDQo+ICAgCVNBRkVfU1RBVChmaWxlLCAmc3QpOw0KPiAgIAlpZiAoc3Quc3RfbW9k
ZSAhPSBTVUlEX01PREUpCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
