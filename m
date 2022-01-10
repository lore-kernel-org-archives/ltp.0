Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40295C433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 09:03:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DC9C3C9378
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 10:03:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1AA93C92BD
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 10:03:31 +0100 (CET)
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com
 [216.71.158.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 190D92009DE
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 10:03:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641805411; x=1673341411;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=OFMiNjn/8a9J55c6s1Wen750mMO6yvYQiXH9bUfpBEw=;
 b=EJVdBnbHxP3Ug9Dowyja3dPSQLYnvfnkJoljHghQIGXZeSl4m9BDMeY5
 +G6mubJ2GBaTCw57sqZT2+2ZIQD/mvJWONBg/GvEmjxtw2MgmEZFdTQUt
 hrL/lhIGu/4qNxy3tdCIbWdDUHv+0Yqa9Ve0wHM/xs2UctijXQQI18+/M
 j9zlHOYMLtq26SdxGS0PGh8bgVUltI4UMmyaBRzO0l/3VsIYHFe85CU10
 +TLhTAoEpO7m1/Kbr6WmdoDW+r6wiW+9BLrTp24drW6xB4bgOoE0WmDMf
 FtQfx6RaOtJgf9HuRv4koMtg8TVeaz+MCFfqR0uUvixzvLoU2EsEa+f3V Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="47269103"
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000"; d="scan'208";a="47269103"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2022 18:03:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6dRo6U6AKwRyb6RpJWIwKpYHnwQentjSWJDF8B+p3grF2iO1djV8fvELAm+J980HYbyCgF9zRT6KlU6OaflHM7D8MkfKmzcfY2aJh4LTCMGPa6JRe0H8q7Dp/GvzbFE/F/eAaa6ppTdH+ODe5WBvXMA0hdYLL59ANczUffNtDP9LmJA3HdkK6PMk7a+B0eRxIis3D0DsoXB/UqXa6udh/Uahrhsk+nP/XxLUBjewBqvvY0RjUWvABiBRP9eN4P/WKa/VJbOt+BbFZHyaTaZ6OyrhKNvn353eIO+iKCWTpCqynbm6S55xtmlfpvzbIRHVbm9f1jYl+86iVDPjzxr/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFMiNjn/8a9J55c6s1Wen750mMO6yvYQiXH9bUfpBEw=;
 b=YclAf2cO3e4zR/u2lbqbKqmSUS10XDRxllU+gMTZUFX4gfDmDAHIJdDPqFl2g3CDpR5EP0osLyDBUjqBnjQcE8bHANKstIg3cGraWBF0D7xSh20xFvjsR7tn5XFZxV4uhfj5CB1rd21+6tIqAdkmodABFLaBHS7t2tZZDQTH6KdB9UyGojrAFXXaCXcMT+daEOwvR1+M8K154PNF0Fzu0itgajOqqCB4OM9Cz1yqpoLjVtE9VmOS9qKuG9u3E6gEnyYu2EDGUjKx6ydpEff3ZSh3yOVplAXfUun90IxWVIkcEOFD9EkNryGiTPjG8BmhrzpopT6qaXnu0zuH3MG9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFMiNjn/8a9J55c6s1Wen750mMO6yvYQiXH9bUfpBEw=;
 b=inexAsMntj4bgpVk8OZ5ki2CdG0qf4lZRmdd63Iy31KMgTtRx2OT3h/AyaTf8jZyS/l1iwes0c86PmTzgAXaRZ/lExKRxgnKvA69b1poiyvLA7UPROIp+jNJHSyk1buNtrhWSetsFBsfHBu/7WY+bn8O1V6XhS0wBWBwHNUY/2c=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB6298.jpnprd01.prod.outlook.com (2603:1096:402:3f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 09:03:26 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 09:03:26 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v4 6/6] syscalls/quotactl07: Add quotactl_fd test
 variant
Thread-Index: AQHX7/L6fnteZrZUjUiayx7mV1TCiaxX4EMAgARB6wA=
Date: Mon, 10 Jan 2022 09:03:26 +0000
Message-ID: <61DBF68E.7070902@fujitsu.com>
References: <YY0o7jAxgIHvmczq@yuki>
 <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639380414-24390-6-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdhkRDQ9uD3goDpV@yuki>
In-Reply-To: <YdhkRDQ9uD3goDpV@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f2c2e9d-b9bc-4b7e-de73-08d9d4180fe6
x-ms-traffictypediagnostic: TYAPR01MB6298:EE_
x-microsoft-antispam-prvs: <TYAPR01MB62988D3E6B97C720C2E71D41FD509@TYAPR01MB6298.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BnyaaYIHL1xHRpcLBOQhRLDz4wP3fLVq6KXMlwQOIY4GuFWPRKE3dUw5UO1WtGOOzW1Ew61eYZ0Xq2MF6elDHzjHXe6tnn6IlgPLWyO3FxDfKYKXXfaKWpRwckELa723fZ6x0bojVdB3Yn6V5ogj8MmhROxb5ya1fgWLZEcXqgdjEhNSnMt5qs+LSfAFh+I1PR1W5N0f9em+p+lFsuFsVsH8DkTfQeQ5W8RIHUCJa4TT2WAp+HhAuQsOmSX4qMn6jPbtC7P6nyepGTxnerQREJS8/9BTw4L3z60eEOsj6+hKKf/i6slr0u7pvEDYfISRrtwmZvX99dS83dMDr+NTQwH52ZWB4V/qsUm/2y33cOiLxbA6/8QaII2/VOcJvnH4IKWP1RylqRjGLfNvrHtlvYHNrSB+R0Sx6QXSDDJamW6u9PVCuF1D3N8F88EufMkbU5vHuTuuS902g3BKSDAPib7tCGGR0YLcDiy6oqmvpsBcoQM/nFIkQtCrdOzuwiPeZxW0tP3Y9SX1q2KHw66tijM+TSBsov6m8L/RCdiBQ1wKE+f6ovgWAlEU6phLulWWy9bnO/VgZvC1o/QyLuU2R/HE2unoZibpCleldzELYIf2MAr6G5N5R14qmKsRuGfl6cIgv+q4Hn686zZe8LproWsOutZnnFISuc3cGX873rA2XLaMExBGYGCBCGEVyKFf6gMzwH5Ov4bZ2tTURElYx+k1zpbeBerPm2UFDMth8iU7H358qTbaMmg9HtUArmafYQlAhltCT3SfyHptMnIcKV38bOGlO/nKKwtJZ/tHAVqR81Uxz2JjjBJ9j6c/x8DOu6KSJ4BWcucVIPe+hle+wA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(91956017)(508600001)(966005)(76116006)(2616005)(66476007)(36756003)(15650500001)(6512007)(5660300002)(83380400001)(6486002)(186003)(82960400001)(4326008)(6916009)(71200400001)(64756008)(8676002)(86362001)(2906002)(38070700005)(26005)(85182001)(6506007)(66446008)(66946007)(8936002)(87266011)(38100700002)(316002)(122000001)(66556008)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZlcxR2NpWkUxdXNnY3lLZmsxQi80aFpYWE9NWllJNkNtaXJVR2pqZk13c1dL?=
 =?gb2312?B?RU0xQTRqREdUSGhTeDh4K0RTOFZHZmxjV2JwQjBQQ2Nmb1VFV0RuQWgxWlcx?=
 =?gb2312?B?bUk1aXBqVEhRZU1pWVBOYkRyZ1lsL2hJbFVpNFNoRlZwTXJJRUVKMWFsQmVt?=
 =?gb2312?B?QmkyV1dmRDNrRnRoMjFGMzRIbzNpd2xLUkhIa2F3NFI0SkpXZlE1RkdGVjVK?=
 =?gb2312?B?eXFoSEJ1N3hNUTVVWExMVE5EaUhlUUgySDZQcXRsb29JWk1yOUNwU3hnWG1u?=
 =?gb2312?B?VXFieUhGTkZTNDlTdXVQY0xSSmttMVRWaWYyREc3dWFCWFN4cjlZbUNwTG54?=
 =?gb2312?B?cjArRVRMSmgvWUlRT1JyT09ZbHk3NUdlZTZ1dXZaak1tcjlBaDR0SmsyQ0dr?=
 =?gb2312?B?ZXQ5Smlua0xQMTFDaHhkbUF2clJTT0R4bUVTRDJ4NVhnRWV2NzBuNnlIYlZt?=
 =?gb2312?B?R0Zmai9URmhzaFZpQlhnNUozaUppNUNVVDJoKzA2eXFQWDE3bkpYdW9uQVRr?=
 =?gb2312?B?VzQ5czNtUElhM0RCMlNlTDVuUklPTmYzYlVvQWZvbDZEaE8vVURubC9yWk1D?=
 =?gb2312?B?MnBqZnZCUlgveWM0OXl0N3kxZGRxejRzekRHeGg0SnltK3F3elkyN3YzbHhq?=
 =?gb2312?B?WGJtQlE1WnE1a3RKWmlQMlVkVWJHWlZiSHhPOEltYlJGMFdEKzNndWVXaHUy?=
 =?gb2312?B?bUF0WU9EbFphMG9TWUxEUkNJSVRFL3dXR0Uwc2RJcFVNL3VJaTdKQ0ZiOVBl?=
 =?gb2312?B?TlhPSGdVaXVFWGNSSWJldVpRRmJTRjBsU3VmZS9hbW1ZSjBUeHV4S1NLR1Bm?=
 =?gb2312?B?VFNDMklHK2QxbnkzWmlJa1pBeUVBRTlabnpaOGh2U0JwL21xc1dGRmwyb0JP?=
 =?gb2312?B?SFBCZTdDNEJNNUNzY2JJRzJKeEMweCtibzd0LzRGRysrdURtR1VoV1o0bFUv?=
 =?gb2312?B?M0JLeTk0V2hIcGxMWWF5c3ZhNzdXak1yYkFjSGhqYjJaYm9DbnQzTTFoRDlr?=
 =?gb2312?B?ZGpXZmo1VExiNUpEUG1YaDcwekw1M1oyMEgwSEtvOHp0MkV5eUY1dUd1Vkht?=
 =?gb2312?B?a1pJUWNpZ2dNd1VIN2VBaTl4aVNpZWZMOHQraFUvVS9YVFI4TUtWenFNT0Zr?=
 =?gb2312?B?Z2RLRmd2Y3NrSGNMbWJhQzEyWHdYRTBFaFRicXBkN0NKaG51QlcxdUZaU1FX?=
 =?gb2312?B?eHJwTkQ3NHBXcWlRODNxa2d0NHpKTmVpbFNoY09FdzdjRThlNmhCeFJabFkr?=
 =?gb2312?B?c3hyNmU0Szh4ajJCaE9GNjlaZTlSRFVhNzFKRlBFTWp5Q0ZhSUJaY1lqWTQ1?=
 =?gb2312?B?anpTZXRvMUR0S1B5RGNscFY2eW1XMmlwS25vUGtoM0t4S1dIMGhvYWQwY0R6?=
 =?gb2312?B?V2VmYzdQbnhxUGx5aDhDSitrLzFiOUVqMmk5Vms1ZnRkRWxnNnQ4a2lDZWVw?=
 =?gb2312?B?eXU5MWM1by9ITWxQVGs4bWhTR1NRM1JzUWwra2dBSFhoUTZQL3l6bVE4NElB?=
 =?gb2312?B?c01LZGtXOVJBblRpamJJTXh1UGtrVHMrR3ArQXlEakhQZVUwdlVtTHB2ck1u?=
 =?gb2312?B?SmVVb1hpbURpdUcvUm1YL1pEbUErd2wxSWh2MUhxcDdId3AxR2c3bFpINFFl?=
 =?gb2312?B?dGxCNlB0MC9NZFVraUgwaHZmcm9IWm8xdkV4VlVDd0lnaWNOa0tFdkVHckIx?=
 =?gb2312?B?SldjdW1vbEtnOHJWNGFQbXhmZlg3UzB5NGFudnl2VkwrNzRReFpDbjdxYk9X?=
 =?gb2312?B?OEM2MGNPWForR0JzcXVYeUpkaVJaeWluK3pyVGovZ3FzN2I3YVpFZllyTVly?=
 =?gb2312?B?MlVTNElCczBvSzZ6NE91bkx5WDNWUGZ5YTEwWS9mYitocnV2eS9UVUdIbWhi?=
 =?gb2312?B?MjdVMDRFdm90d3hpRG1qNW43RG1QRW96K1owZlIvemxGVjUxdzRkS2dRdlEy?=
 =?gb2312?B?eXM3b0h0by9KQldxblVWUTBSWEY1RTFFWE5qbllCVFZhZHczcTRZNGZOOHlL?=
 =?gb2312?B?Ujk4c1FYMW5jN2RoSEpNL093VFRnOWJxYUROQlBLbU1FWmtoT25BdmFnN0dy?=
 =?gb2312?B?bzQ0clpieXpIWW9kWFpjR1lHUStSeUJWVXJjaFJ2NnA1QTA3aHp3ZXU0QWpT?=
 =?gb2312?B?U2Z4bngvbU03RVlVUE9ZTjgvN3p0cWQwVFJza3k5UVQ3TUhmNzB0U25lUnBo?=
 =?gb2312?B?SDVTUXpuN1k3RjA3NGFlQ2huaXZYM0tqQi9xQlZoVVF4QXRxdGcyZXZhdlcv?=
 =?gb2312?Q?QaROstzoIVj39OdqHvMagupuym1woEzVKEl0S5NlHU=3D?=
Content-ID: <08E62A7920EA2242BA84245E74FD214A@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2c2e9d-b9bc-4b7e-de73-08d9d4180fe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 09:03:26.0415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHBQ739EDEC8+X7FG+xteMxF8oizrx7dH+aIiCkWevWZ/Ad8l6eVQFeka1uiMxRmlu/910bUcw8PW4zYtQuujmbglVIuRlJ7jaTkLuYwL38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6298
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 6/6] syscalls/quotactl07: Add quotactl_fd test
 variant
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
>> Also man-pages has error that Q_XQUOTARM was not introduced by kernel
>> 3.16. So use invalid type directly
>
> Have you send a patch to man-pages to get this fixed?
Yes, but offical  man-pages[1] hasn't updated for serval months.
The updates is on alejandro-colomar(man-pages new co-maintainer) main 
branch[2][3].

This patch will get unexpect EINVAL error when kernel commit 40b52225e 
("xfs: remove support for disabling quota accounting on a mounted file 
system")[4] was introduced.

the unexpected EINVAL error position: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/xfs/xfs_qm_syscalls.c#n108

if we want to disable quota account feature before Q_XQUOTARM, we must 
need to remount with noquota like xfs maintainer does in xfstests 
xfs/220 [5].


So , I will modify this case as below:

/* Include a valid quota type to avoid other EINVAL error */
static unsigned int invalid_type = XFS_GROUP_QUOTA << 1 | XFS_USER_QUOTA;
static int mount_flag;

static void verify_quota(void)
{
         TEST(do_quotactl(fd, QCMD(Q_XQUOTARM, USRQUOTA), 
tst_device->dev, 0, (void *)&invalid_type));
         if (TST_ERR == EINVAL)
                 tst_res(TPASS, "Q_XQUOTARM has quota type check");
         else
                 tst_res(TFAIL, "Q_XQUOTARM doesn't have quota type check");
}

static void setup(void)
{
         quotactl_info();

         /* ensure superblock has quota data, but not running */
         SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 
"usrquota");
         mount_flag = 1;
         SAFE_UMOUNT(MNTPOINT);
         mount_flag = 0;
         SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 
"noquota");
         mount_flag = 1;

         fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
}

static void cleanup(void)
{
         if (fd > -1)
                 SAFE_CLOSE(fd);
         if (mount_flag && tst_umount(MNTPOINT))
                 tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
}

static struct tst_test test = {
         .setup = setup,
         .cleanup = cleanup,
         .needs_root = 1,
         .needs_kconfigs = (const char *[]) {
                 "CONFIG_XFS_QUOTA",
                 NULL
         },
         .test_all = verify_quota,
         .format_device = 1,
         .dev_fs_type = "xfs",
         .mntpoint = MNTPOINT,


[1]https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/
[2]https://github.com/alejandro-colomar/man-pages/commit/38bccbcf4f51c5370a1060e6a80b90d68b0dcdc8
[3]https://github.com/alejandro-colomar/man-pages/commit/26f3978f04a1aeeb5397a5facebaef40a341afb6
[4]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=40b52225e58cd3adf9358146b4b39dccfbfe5892
[5]https://patchwork.kernel.org/project/fstests/patch/20220105195352.GM656707@magnolia/

I will send a v5 for this patchset and add TST_EXP* usage.

Best Regards
Yang Xu
>
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
