Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BB0C433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 03:56:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CA483C9203
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 05:56:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04BB93C0596
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 05:56:01 +0200 (CEST)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D6E1D1400427
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 05:55:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1655697360; x=1687233360;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=7dElxcVbXRTuwHa851sUPGLl3k0xdmrx3+8wzPtr4XA=;
 b=iSvAonOyOVo43My6VXERBHlP9HaVbTvGNSam4F3pl0MZzCS/l+ZsGdN1
 hXGGTpI1fO5PlH2WiW3qby/0u+ajKhYLU3mNJQ3d+b9A0OxLupAQoeSSU
 Im3pTHnXPBuf9etoTKb5TcbHfH0gBJPdo8h9ROhswNSEeJBVsfrPw/Qhj
 H+S59eHRvvKLZfVkcfwpapMqysxHVEdR+ywA9VBmXy2KDwqzISdSuYvNL
 yiQb7uV8Wu9WqxjxZ2SxTWqoqpQbw7/MCsFQeVb7nZkQLdD46vKgyTIuY
 RHE8DT/rhNQmIdBjWAZ02eJHIPC2S4Bb0GElXUBXDuBqEs62+1ViZYNub A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="58405338"
X-IronPort-AV: E=Sophos;i="5.92,306,1650898800"; d="scan'208";a="58405338"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2022 12:55:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huY68e0OfQCZK3IOWjSpSzI1k5rspNVk4IsbPgDCcxTkUStiYZBvPTeozLcedwjSJAUupoQmd5ZtLminpXJpKoZcTOGRBHyp75s6kE3s4T4CvnCzzqk74tCdpDGizT6rqkQGcBLDIYuAjmqb1TtA9JxVtOoLpjrXqK9YZFDW9w3/DXDKSlAtGb1QnVvaKEpkfjoMDN2sofhoAvGN84gt5RBsdISjVOMtF+0PJ59jh4LrEkmuAeoL9Iofxzocu/iwTeHZuHw/OhGUl7jHBaWbruGa0IcIOuM10F/uyrK6aQpsqaVmu5A7ERULkqfrrNQSdrvxLd+rS4wzZaSxwO+WAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dElxcVbXRTuwHa851sUPGLl3k0xdmrx3+8wzPtr4XA=;
 b=Y7ohOdC0EoOEBK7dgO+yUFMNwaJfU4iWmJ1yPOmhtHLB9nV7tyV6/VLBHQYGxvPpYsiXnR/+sDp9qpsTImYNsTHSCmD//Nd+J5R81jm9yJbuVMp0+ksNtyMF7+zcBaKOimZYQHEhc0iOCNKHTzWj2M1mK5x2XKZaUEnUco904WKz855zxghJ9guatPmpW96CDcTd8KiQRLvfxXjlLf1miCqr/JKHaiS5Kbfcy0ZJVdJHJ5bHcCkJ9AA8pQ953Va1ZOg4qfjPuXt4dpThd8Iufv7avTbyl53FUxI9DbNZ2czx9cM04KDgNOl4eRnPhsDsS4oVKLQKzv7pVidRb/P/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dElxcVbXRTuwHa851sUPGLl3k0xdmrx3+8wzPtr4XA=;
 b=TyBw6pJVcssoHyJ/f86QXVVhes7vp6Tweavp+Bm2cI2TMF1mFVeTybstkbt6OgrTQiaXE+2dsGmFYwH+/1XhGi+7L0AdCovMFUCpcUuofvDUCTh4j7igexNgHmF6pAGe+Lbo8mwR/6Iu2IkOiTlyf7k67MUYZtGJBbcUFeYv7S4=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB7047.jpnprd01.prod.outlook.com (2603:1096:604:124::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Mon, 20 Jun
 2022 03:55:53 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::6c47:f921:5fe2:6939]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::6c47:f921:5fe2:6939%2]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 03:55:53 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Thread-Topic: [LTP] [PATCH] Fix mountns01/02/03/04 removing unneeded final
 umounts
Thread-Index: AQHYgm91GZbPAIreqEazuuLdMLt//a1Xv38A
Date: Mon, 20 Jun 2022 03:55:53 +0000
Message-ID: <62AFFE20.1080106@fujitsu.com>
References: <20220617172641.122296-1-cristian.marussi@arm.com>
In-Reply-To: <20220617172641.122296-1-cristian.marussi@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4d79472-5f00-47e1-a44c-08da5270c5cd
x-ms-traffictypediagnostic: OS3PR01MB7047:EE_
x-microsoft-antispam-prvs: <OS3PR01MB70473A13F6BB0D55F236AA6BFDB09@OS3PR01MB7047.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z6cWih57oyav7Mo21AOXEaCsq/4JVNumIhB1AUBem+0NaQqQW9AZowJqfOpPxh/1XMYK/VlB1OU3tZeqVs/zFGeDAlCZHy0FwDAegT7R8dh/bjfurTI/3gcE4KA5oLPlzAzRDbMmyEdLI1IlTER/d1tjdiG/C/C4lO8+VtkkxZFienlYnDRz3aRqinOvJWwTtHQDylaDHB6sC3/BTOLNz9PpWufQSxLwKrYw5uIbfNXOYif3GHWRs3ouU1byqW37wBb1Nyx0BdQgfsJcX1EEgDFECozK4pP0XqFNidi9IFbsPOz+azUdeYersC1+aneRbySLj5rbraXFpm079GW4vlHEQYevw2tX8+GwNfRU1TuxFP4Rn1NZ68pu5R09uxYWG5wE7V/XhQFVv+omxnn59LZ5I1uP2zhIuzmHU+PixpYFrO3VVD7RWfMEcwomqUb69z1bFJCkamQjwxT/C9B5O9l5zwcjr9AOIDt7IDyXT0qEH6yiXgjQmLU4TRd21PnLXjbukiL/mz4nndMqmxKSQqPagxgGXOWhveixaLli2H39s6DtnMq8lmw0P7zATg9XSvoJ1CtaY3fYyGHUyvibktWRDPYCbD7gchcatXFwTCnCAtjoL7aIGDQ00aZVC3C4gDaho7TkomB/aqVTrGOZ5+pOe4kJUBfSbGxIaC3iwvsjo14G7pmGJXg25h3sCkCGLqISzATyqXHdfAdX52jsxg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(71200400001)(2616005)(5660300002)(6512007)(33656002)(8676002)(8936002)(38100700002)(85182001)(86362001)(122000001)(26005)(82960400001)(38070700005)(6486002)(316002)(6506007)(87266011)(186003)(91956017)(36756003)(76116006)(66476007)(498600001)(66446008)(4326008)(66946007)(2906002)(64756008)(6916009)(83380400001)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?L0h1clJ3UFF6bW9LRWZtSEtPZHc4bGdtN2wyQnYrUXlCTFhVQTZGOWlmRmhF?=
 =?gb2312?B?YVBkcVhyd0JIWjgzbnRrWDgyTlg0K2tnclNiOGk0ZDh6Q2hqTWpsWk8ycFBw?=
 =?gb2312?B?MUNvaEwrWG5NaFZiY0RZL053WXlnbnBzLzVNUmVLbWg5dE81NGFSejYyZ2pX?=
 =?gb2312?B?Nm9lWEh6TWVXUjFubXU4OVdxRGh0K2xoQ3VwOGxscWRpdTUxNlZjb1pPNysz?=
 =?gb2312?B?ckVVR29BRHF6aTBTSkcxQi9FK0ZPYWFpbW9FTEs4M0U4ODA4WU1oWFRramJT?=
 =?gb2312?B?K0xDaGtjK3l0RTMzNWhUMVpRU3JsaWd3QTVabDh2Z3B4TnNLbUJlNVJKbjk0?=
 =?gb2312?B?RGpSblZxd0YzRmpUT3VMWHlKb0kwN2d6U2txTURHWkdrSDN0TlNpUU9XeXor?=
 =?gb2312?B?b0F5WHp6WGlwQTR1TTRCZi9yM2w1YUdqZENYbEZpa0hrRkFJc0RuaDMyQXJG?=
 =?gb2312?B?WVlvMlVJK252Y1dIdVNuL2Flc3JCdWt1K1BCVHFmOWlGVXBxck01YmM2bVoy?=
 =?gb2312?B?UE1uLzBmRU9YM3plUHlCOTBLSVI4YzdIN1psWWtJdlh5ZU1xa1gwUDQ4TEVn?=
 =?gb2312?B?SVBjY1BuUUdreng3YjZOTGdQZXVwdXNldy9IekJmL2F2VEtYT2grSlhYMmpn?=
 =?gb2312?B?QjdYbXVGLzFwZFRudXlrNWZqR2FSYlJxcE5uRWFTNEdsTnBuV3NWbVVQSlMv?=
 =?gb2312?B?MCs0UTRSUTIvbXRsek40RXRGa3d4c2xuRmpaRDVrTDRhVGNhMnFwaENNOWlx?=
 =?gb2312?B?cVpjMUxLUFp0aElVRWJQbUlzN2t5cG4rVWE3cm5hNGR3eFlNTGhGeWpJZzNa?=
 =?gb2312?B?ZmViZnlYM3Bza2hrNk9wUFVBclp5bHVWeFNRWjJHZGt0Sm5hUG9DYnhCMWR2?=
 =?gb2312?B?a0QrUFpiRUY4NVJYVUw3d3p0VFEvaGt4dGFnaHpPUGg0cG1DNnFGa2JBUlE1?=
 =?gb2312?B?NWx6Q1hvWDZKa1pLb0lTR0I5N2NRZUJrMXZmcWhQRUhOb1h1VEtJMGY3bGFI?=
 =?gb2312?B?SW80M2YvMGNSS252OXFxWmtWbTdRRC9NWDRZay80WTFWL0tNRkhXcE9STUo1?=
 =?gb2312?B?ZytiV0VSWlRsK1JjQWdta0RlK2RpSkhnTDMvWTYwZG1QandwbldCT3ZFSFFJ?=
 =?gb2312?B?eHpUa3lvcDZjaXN0Y0RwVDBPaU9OZllhREY1Qnh0My9MVFE1UEFVQTNuNzM2?=
 =?gb2312?B?bFFzeVRNT2hRZi9jb2FOMFRoRndrR3NxcWFqUFg1QXJoeDVmUUxiaWd1SkZ4?=
 =?gb2312?B?NnQ1NnR5K3luc012dEkrTGlJUzN1VkhtanJFd2Z3eFc5ZUE4d1FFUVg2a3Vv?=
 =?gb2312?B?TUFVMGFXMHBSeDNPSDdhRS9RanR0cFp1QjBoa1U0bjdyRTR5cWp3VmRIeTZN?=
 =?gb2312?B?UnRMSzNhQStBcUY2dVJPeVNmdUtIYUNkemcyN2I4Q1RFMXRNUlY2SWszUWZp?=
 =?gb2312?B?STI1cDE4b0JlNWlaSW5zdXFGTklqenZvNFhLaUpuT3FWZ1FWNmJEV1J2eFBm?=
 =?gb2312?B?Tm91Qk9PdGFNakFMR1FSeXBDUXQ2STEveTdzYk53b1BQMS9PN1FYVVloNjRx?=
 =?gb2312?B?RkdSM3N5MFpLSjJOZjNtSmN2UXVGaGhXcnQxUTZZa2drY3VueGhRSFhxenRx?=
 =?gb2312?B?TnBFRGx1cDUzTzNpNmhWN05hUHl0RHprdXlhY3d0cUV5dE1tVkVTaWhuNUFR?=
 =?gb2312?B?alF0M2JxempNTzY2YlYvMU5VMlJPd0JOb3FMdDh1Tm5BM2RvTFpXbWJ1RXdK?=
 =?gb2312?B?MFVFSnI1eXB6UzQxOHJ6WUFhNVo2Smt2Y3VqaDlaRk80cS95cW43a3djQm1S?=
 =?gb2312?B?dERmRVMrSjNWZk5oakJmQ2p3UDZvYjlUek9QRTAySnQwQ25zUkVzdFBIdnBU?=
 =?gb2312?B?amRDdkFUdGFrVFVXK2FOZ29NNSs2TUZJYWVJTUpKRG1wT0hMR0NydCt1WXpU?=
 =?gb2312?B?VVZZVXI5OW02MXcyb29lVmlRUDB3UFhiMzY5MktVQnJVbWNjVHdGZTRSN3V3?=
 =?gb2312?B?Yk14N0ZIL3o0Z0F5NURDcUcxRjJ5MjF1VnlHVTJXdGx3bXJmTmJGYWZMRy8w?=
 =?gb2312?B?dFNEdS9UT1Awa0FyQ1ZuVlBYNEJ3em56Rk94YnpMOFY5MnkwSGtQZktCaWkr?=
 =?gb2312?B?REdrV3g0Qk5GakYxNGJ6TXlIWVR0cHpWZ0FVV3lOcmNiWVgzYzBGTjlRRFVH?=
 =?gb2312?B?TTZKVlV2N2JnTmZkM1hrOWV5U1k5Q2xzQUpnOTdOUTl0RkxBMlVjWGgrR2hm?=
 =?gb2312?B?ZENyejRtYlFvcm9uRVNraWoweFB6VGY0K0xwK2czaVo0d0pQMlpjZkhvUWRz?=
 =?gb2312?B?V1JNd3p1bC8wMndKeEdFc3VGdzlPUjdnSnBqaXM2TlpEM3Q1OFpQd1NtYks3?=
 =?gb2312?Q?WC45cGSDGwirsIiY=3D?=
Content-ID: <396A9E03EB347F409F602830D79E1EF8@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d79472-5f00-47e1-a44c-08da5270c5cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 03:55:53.4281 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FEhrD0yopM8HGkQ1bmiVTsAGsdzNFoScGQ9vuccLYcmsb0scJCD2SQipDSuNHxk5WGIJwf/JGf5J1J5r0Vaqsncjk9UQzzC1W4v2KYwwNGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7047
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix mountns01/02/03/04 removing unneeded final
 umounts
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

Hi  Cristian

> Running LTP20220527 release it appears that the recently re-written tests
> mountns02/03/04 now throw a warning on their final umount attempt:
>
> <<<test_output>>>
> tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> mountns04.c:38: TPASS: unbindable mount passed
> tst_device.c:395: TWARN: umount('A') failed with EINVAL
> mountns.h:36: TWARN: umount(A) failed: EINVAL (22)
> tst_device.c:434: TINFO: No device is mounted at B

I guess this failure because /proc/mounts still has "A", so 
tst_is_mounted returns true and umount failed.

we can reproduce it by using a /mnt/A mntpoint in /proc/mounts.
>
> Moreover, the underlying safe_umount() then upgrades the TWARN emitted
> from tst_umount to a TBROK, so causing the test to completely fail:
>
> Summary:
> passed   1
> failed   0
> broken   0
> skipped  0
> warnings 2
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=4 corefile=no
>
> In fact, the final umounts on DIRA seem not needed in mountns02/03/04
> looking at the previous chain of umounts calls and the tests logic and,
> in any case, the .cleanup functions of all these tests take care to
> finally unmount both DIRA/DIRB after having checked if they were still
> mounted at all.
>
> Remove all the final SAFE_UMOUNT calls (even for mountns01) since all the
> possibly needed umounts are already eventually performed by .cleanup.

Yes, it can fix this problem but these case still will fail when 
/proc/mounts has a B mntpoint,

ie
  mount /dev/sda11 /mnt/B
./mountns04
tst_test.c:1528: TINFO: Timeout per run is 0h 00m 30s
mountns04.c:38: TPASS: unbindable mount passed
tst_device.c:395: TWARN: umount('B') failed with EINVAL
mountns.h:39: TWARN: umount(B) failed: EINVAL (22)

So I think a right fix should fix the tst_is_mounted function or 
umount_folders instead of removing final SAFE_UMOUNT.


Best Regards
Yang Xu

>
> Cc: Andrea Cervesato<andrea.cervesato@suse.de>
> Cc: Cyril Hrubis<chrubis@suse.cz>
> Signed-off-by: Cristian Marussi<cristian.marussi@arm.com>
> ---
>   testcases/kernel/containers/mountns/mountns01.c | 2 --
>   testcases/kernel/containers/mountns/mountns02.c | 2 --
>   testcases/kernel/containers/mountns/mountns03.c | 2 --
>   testcases/kernel/containers/mountns/mountns04.c | 2 --
>   4 files changed, 8 deletions(-)
>
> diff --git a/testcases/kernel/containers/mountns/mountns01.c b/testcases/kernel/containers/mountns/mountns01.c
> index 452fe1d10..7c9461e4d 100644
> --- a/testcases/kernel/containers/mountns/mountns01.c
> +++ b/testcases/kernel/containers/mountns/mountns01.c
> @@ -85,8 +85,6 @@ static void run(void)
>   		tst_res(TFAIL, "shared mount in child failed");
>
>   	TST_CHECKPOINT_WAKE(0);
> -
> -	SAFE_UMOUNT(DIRA);
>   }
>
>   static void setup(void)
> diff --git a/testcases/kernel/containers/mountns/mountns02.c b/testcases/kernel/containers/mountns/mountns02.c
> index cbd435958..0693bb9f6 100644
> --- a/testcases/kernel/containers/mountns/mountns02.c
> +++ b/testcases/kernel/containers/mountns/mountns02.c
> @@ -86,8 +86,6 @@ static void run(void)
>   		tst_res(TPASS, "private mount in child passed");
>
>   	TST_CHECKPOINT_WAKE(0);
> -
> -	SAFE_UMOUNT(DIRA);
>   }
>
>   static void setup(void)
> diff --git a/testcases/kernel/containers/mountns/mountns03.c b/testcases/kernel/containers/mountns/mountns03.c
> index 5c19a96a9..aceab32ae 100644
> --- a/testcases/kernel/containers/mountns/mountns03.c
> +++ b/testcases/kernel/containers/mountns/mountns03.c
> @@ -96,8 +96,6 @@ static void run(void)
>   		tst_res(TFAIL, "propagation form slave mount failed");
>
>   	TST_CHECKPOINT_WAKE(0);
> -
> -	SAFE_UMOUNT(DIRA);
>   }
>
>   static void setup(void)
> diff --git a/testcases/kernel/containers/mountns/mountns04.c b/testcases/kernel/containers/mountns/mountns04.c
> index cc63a03d9..d0ecf7667 100644
> --- a/testcases/kernel/containers/mountns/mountns04.c
> +++ b/testcases/kernel/containers/mountns/mountns04.c
> @@ -40,8 +40,6 @@ static void run(void)
>   		SAFE_UMOUNT(DIRB);
>   		tst_res(TFAIL, "unbindable mount faled");
>   	}
> -
> -	SAFE_UMOUNT(DIRA);
>   }
>
>   static void setup(void)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
