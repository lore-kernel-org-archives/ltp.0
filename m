Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF066CDB47E
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 09:51:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C12D3CD444
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 11:51:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 427043C62E0
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 11:51:31 +0200 (CEST)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4B4D6610210
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 11:51:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697795491; x=1729331491;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=ZZYDCQ41YpjlEnROJG89X6pEv4sQNs03o4yOzxj53As=;
 b=LXwa69bZ68jOdWGqXWQslpRi1I4EMNf7A9Rrw9ADL/td8hceMBX7U6ng
 hMd1GI88rez44BdP7g2P8Ae6fb9qJSafro0Itu97u4jOFeGR37xa03/p0
 yAJ7T2IGxqllWu6ktssOoLnMOgt+fBM0F9B1qkelf0lu1MNoHQE+shtiY
 w4/2FjwXP71UpKGVD+Yi5tlzSgPxSiVy+ZfvS3oJ1wI3UXLf2Rr53RTvu
 PMydzPj/Xa/PFrWPYyVpNKVGTBB+CHTEYjjbB4CIVybzeA5xd4NXvaOgP
 9o8m+haUuzl5kRxJb6qLz3BPDTM7oE0i5kXoMGZaIp2NPOagn39Fm2K1S w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="100123385"
X-IronPort-AV: E=Sophos;i="6.03,238,1694703600"; d="scan'208";a="100123385"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2023 18:51:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEAoRgCBrXak5SHuEy3I/Xjx3W416oX58dSj6ytXog6SS+BaNLGQCfW8H3lXZyNj1YTXEbGzFE8S7I1lMwOfHi+3P8AliBitWwkSzoDcib/kVRrAjNanDOv0+KSuIlu0sZMageSB72MulCeI43fLFjmpFZXnO/DH0d5VoUGzDYH+ziammnUFgEJEXXoQtzNhXh6W6MoaT3m1Lj7DAjLAe+lCvVUz+EZ+/sjR5aZPgo6TDFlTDsfy7L0D4PB/HZRawIChc+YoiJH1X+MmPSMzZIzNvOl8harku+OMokv8nEC5RNGp4gQb1goQm6vov/FgXwz+wNsryYQJVZIqMQ5o0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZYDCQ41YpjlEnROJG89X6pEv4sQNs03o4yOzxj53As=;
 b=Gl9BFPhrRgYIEVZJZiMeI+F4+90hkCdmEaWxpl57SSQ0QyWA2WWcsZDuQ+Z+POq0t2NPQA7Fk1/TyCxvE2KdvsIc8ytdCheM5HgOf88GlXC2iP7HmjGl6BGg/wt2ROX4X2d88789ygiV6lFkWoFUjrm4yF2kDl6DI0Y1McVZR3+fT/Ix0gtBPfrY844XekDahDuRizxz03UjLJzqPzZUizQ6XA5Hcmaqbu9jh//KAUZhslaKviPsZ7zTLy3RGr3t+bu/vVMe4PMxBC1IzQ00jga6Y05kKbFuzOLO6azwphKncl8q0NwKntVCO1RScclB9ftXNMri1N8xAArcOMxqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB11829.jpnprd01.prod.outlook.com (2603:1096:400:400::6)
 by TYBPR01MB5550.jpnprd01.prod.outlook.com (2603:1096:404:8024::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 09:51:24 +0000
Received: from TYWPR01MB11829.jpnprd01.prod.outlook.com
 ([fe80::f1bd:3ecc:3788:292f]) by TYWPR01MB11829.jpnprd01.prod.outlook.com
 ([fe80::f1bd:3ecc:3788:292f%7]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 09:51:24 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH 1/3] syscalls/fchownat01: Convert to new API
Thread-Index: AQHZ+zqjwRv3r5TiikKNjIWkGVHkTLBSf3uA
Date: Fri, 20 Oct 2023 09:51:24 +0000
Message-ID: <5c1e4a92-4d7f-ea58-1382-67e8b8ff32bb@fujitsu.com>
References: <1696915709-6304-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1696915709-6304-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11829:EE_|TYBPR01MB5550:EE_
x-ms-office365-filtering-correlation-id: 67625b25-08d0-43b2-f601-08dbd1521f15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 56WN1Me9fqnCiHuENoSDHmRcIPNDiTRQVJKSK3ja5OwoN0kjEGkzG4IY4wFmrIhdEC59+BgYBnJfP1xeEOBf9LM6jDa+JObLkm+17JngXjDqm4RHgOhBBLv5Iuyu9vcE1Lxftt9pJ7vvXQp7TGKGeR0l/NmduWngN3dsxIc5DBL19sjgA0m2L28ExdgmSxbKbc01OHGS7FvZjOSa6SpY0TeQwpdMbEyYRHb7StBRRZaCzCZI5w7nAun1RBj6iQm/ixVlBGjDcu+Xr2dM8JoSpwP3glzz15aMmB/rWQ5MhuaDq8ISam3ArsBFQ2lBod2QlMPGq6ravemIafVDbiIclDy5bOJc3lJgNaUgCGnJpkqwIfQEyYG9Q68qLzZSdAqsk6q7IatpZWqxX0UIaybMbq6lXvmVEfaSaSsBvGAgunO/y8bqd3le21s7kQZXtf+X28qBdsUY8Y7sKwhBAkg4yqt6H2vocGufdN11GId5djljQPIATewzEkMbAmujmWFNZdG/qQGQ86sU71dMl/j868L2BDBw6ZknlDKI6XgJ47vtHZJrtQuLrEUJ+mAQ1fC2SMWmH9cSPG1mnYcrHY4THQJRyCNDjNqENbQTX+5gQTbtRIo1yD3Eqzo2fMzNv29B6hwdISusIOcz0SdllnRPqU7RrDu1wtjaeVCh/1SyhnszrMUNS5f9IXJWkwkoBI9TkW9wOF9X6fY5rJ4IBr2qKA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB11829.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(186009)(451199024)(1800799009)(1590799021)(64100799003)(1580799018)(86362001)(316002)(6916009)(91956017)(66946007)(76116006)(8936002)(66446008)(64756008)(66556008)(6486002)(71200400001)(66476007)(478600001)(41300700001)(8676002)(5660300002)(31696002)(36756003)(38100700002)(2906002)(83380400001)(2616005)(82960400001)(6512007)(6506007)(122000001)(85182001)(26005)(38070700009)(31686004)(2004002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djd5YzUrYmFGS2dlVkxISzgzMWttY3lPRnZUODNLSnFTSWdkWkgzaGRvQnJx?=
 =?utf-8?B?Y1N4a01DVzhZcnpNMzZNRkduRThWRXZxWWlnZmg1dSsxOUFtTHdkQnhMMUtE?=
 =?utf-8?B?eHFlTllJb1ZscDVmNTdaY0dCSWlVYitmeE5MUjIvanM0bGIvYmNaKzVGTW52?=
 =?utf-8?B?ZUtTYnFsQmpYT3RkNHo0dk13bEZ2YjFzQXFqYXUzMWgyOGJHcjhac3ZRbFJo?=
 =?utf-8?B?RlFJY0tLS2VrK2ZaMDVKRlRIYWlBT0p4TUlCK0xKUFZhZzVCN1YwY1A2RjAy?=
 =?utf-8?B?cHp1b3QwbVFObFNuM2hQTmdVODAyR05yWStWc2orUXJ3U2g4Q2wwMEdkZHV0?=
 =?utf-8?B?Ry8wSjZURmt4S2dJUE9LckE4amVYM0UyWkUzSlNSWDQ0NjNYWHhOQmhMelZl?=
 =?utf-8?B?OEp6d0RjMXg2UytMK3hXN0g1VHNNUHIzN2VTVkJYaWJsOEVEZG95eEx1WmN4?=
 =?utf-8?B?dUZWaXdteTYrYTdiSUNBTUpnbzk4YmtjSHpmb202czN1R1dPMFBSVlh4M2pE?=
 =?utf-8?B?ajVKTW5XUVBmT0h5c1RVUHhxWm5obmRTbVFWUFV5VFpjZzc2M2VRK1h5NklS?=
 =?utf-8?B?enpPMFFYakZDNzZ3N0RkYkdqZ3VMR2x0MXZsTVlHUkRHMnIzSGhrVjdMRW16?=
 =?utf-8?B?ZFQ0VDNRUnFmVGZKWjFTMlM5M1UyaTNyOHo1cFhXU3NmV0VNZ0IvM1c2M21k?=
 =?utf-8?B?YXI1cHJ5K2dvTG0zRWkxcFdyNG9CZTd2Q1c5VVllaTI1T3dVVzhhUTBRcTQr?=
 =?utf-8?B?em5SLzFPSFBZOUkrWmNTY0s5OGRhb3JOY0RxMzRWRmV1R0JIUjhZMDZEbjVz?=
 =?utf-8?B?LytGVVRZcitXNkwzcTRVV2JNeE9uSzFNM3R2b3lCUFlGTEJOaFBSTHhwT3JM?=
 =?utf-8?B?MFlycjVTSnhybGxBWTducXNrNjFqZmxZcXBGd0V1VVZId2VMbVhkamhDUEtn?=
 =?utf-8?B?d25rSUk4RUtpYVdlMUxHT1NmNUI2SnAyMFhCam1TN1lvMXJ0a1N3bVFyc29S?=
 =?utf-8?B?dkh1N1hTMWJhOW1IUFFPL1RkVXRRTUtzRlJuaDYyTUEraUs0WnJ2c3psTHlo?=
 =?utf-8?B?QzJKQkZtZnYrRi9wMy9TVjhuOHNLODRhZnF0MVpKcm5UMXU5alNUS24rUGtu?=
 =?utf-8?B?M3FOOTNtbnFXVzUzUFdxaVZZUm95dG1jMXJGVlNxakNpSWowNm1PKzVYczBs?=
 =?utf-8?B?VVAvZ1htUmQvSFVjVVhQKzhYZk9LR2Y4UDgvUFFGMDV1eEJQcVR3eVg3aHBw?=
 =?utf-8?B?cTBCVCtRdENIUDdmd2ZmM1ZjbmtoZHlSV1JOYnM5UXN3VDFyamhUNXBzeEpY?=
 =?utf-8?B?dHVXaG9VbWp4Ti94eTEwTm1IT3ZJd0RyU2diSThEemJvcmh2cjh0Ukl5N1NF?=
 =?utf-8?B?UnljYWVjdXZqaHFZekYrTCt4ZTE3cmR4dUFBbm5SV2ZiRkxnc1p1OUw2TDFn?=
 =?utf-8?B?WEZQeHQ2QXRXUGcwSXZjSEV4M042OFFvSFJ2SzJIdlRueTQrOHloQUlWUytD?=
 =?utf-8?B?OXo5MGUzYzE1SDZ6eVM1QmFNSmlENnJNZU1wajBvcTcvN3BYMk1XR2ZWYW4x?=
 =?utf-8?B?UTlleWhzaVlvemsrSVdBaXJwbFZOaThvYnhZM2RjUlR0cVVmT0NoOGVCTlps?=
 =?utf-8?B?RjlOUjc1WXB4dnNFajBSY1pPb2lYa1dXZXBKaEFhcWZoYWVmMURKOEk3VHNj?=
 =?utf-8?B?TzFkUnlFWXB2dGp5U2ZqUGpGVjgxUzY0VFcyS01MajlEVjJUN0RVU3JEWU5L?=
 =?utf-8?B?M0hLY0RRcWJxcG5wb3ZsOGJxeTZ6TW5hcFg5YUtNZ2RaTkM1TEdkZjk5djNr?=
 =?utf-8?B?ZDY3U0NJWllxb2tDUDRReXVpUmRsZEZNM2R3d0EvSjhIRjRzOGVUTXlLVG1K?=
 =?utf-8?B?UG9IdmswVGF6Vk1qbEptMmlBT2xUSlRBZFpPNEdSTU9yTGd1MmovdXQ1aWYy?=
 =?utf-8?B?eDlYMzRVU3BSbUdOQkRkNDFUZlNydHNGc0xhTTJ2Mk1vT3I1RTZvckdkb2hE?=
 =?utf-8?B?dnI5eWJ6ZlIzWHFFdGt5ZUxncDJOamp2MEFtZVkzY2NMY25PeFAveENpZzlS?=
 =?utf-8?B?VTdvWFZmUFdpRzIxbzFpcm5rc3Z3N2tYUFd2MGtyR2krcVFIU2J2Z3lZNE8y?=
 =?utf-8?B?RFNlckEwQlk2djhBSGJROC9tNStVa2RnY1l4Q2xjZEVrRzhiK1RRV0dZeS9o?=
 =?utf-8?B?bnc9PQ==?=
Content-ID: <40B314798F77E94D90017AD2B59FD0E1@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gLkCvCjym9bytuP8uOxCCt5W0UR/yTR5aRWQI50wf9nwCoPncyzmJkeTLgKgGEV+00LR1PXK82QwQP3eTYuNSNwgsILYPgNIsTT0rGa0fZTpfSCIxY5QZfd2rIEpz9+16YeMirbokFCKq2J9cJEpiX3HUbv3PIKFMMX1lz8/7+hba29OPrVSXmKQaHynfrtLbYg3yFvPqHQDRitWf+pP7NlEa7XmIlYkpMURIFbL2AFdSoYvYU43UTcosaC6CgYR/8EB/0e+f5rR7mTqjmSE2gEGF4tkjeANuEoOQwkQhtt9J2bKdyJ5l//6Nmlxi/FuSlvatDa809h6CPnQnXqmRsA/Fi2F8CfvarZrJYJpUtiBb1xuaXAZcCnCl1et8DeZuXgTbQ5GQTiGWRvVLkmOmf+ttSQJm1uOuNetZVtxSsYFUXHHi/YR2CtfO68jixuVxpILBhdfpnA9cevDyFngbIXU5ngcLnf0Vm8MVqddXHp+LQuqFDA7x8HuJA4+SBzt5HvnLOA5PEJjV9XeqpYMWC9Yvz+QYItiX3dP4u+MTGB1fBYFEJDnwonM04CrjBWW+to6XJBiSBcbN5TO/4HJUr2KLsyKyfyL50Ii9G1+cBJ1QWrG7E/3kNGpX6R9PkQZI5esYT3KXcaFbqkp1EmvAWKk8QMr2e8ZAnB/8uXZlIycx/9NQwXX8QpzYdkt/ck0kJHzNohfw4JANtDCutxg7JS0X/EllDWatx+WtErPwS4Q8gzcp7VgFnOZFunbbBKuvIbxLO4T5307VJxKIYzEAA==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11829.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67625b25-08d0-43b2-f601-08dbd1521f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 09:51:24.2094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XLIn/Xgcsnk4zxR0IuYLgZ1XPnP9BFs8LEoSDuWSD2P6s3uZlBsyR7n2qx991ED/GcOa8MWePU3uQK9gHf36xZMJtcCQ6gnWrcsiTuqFhvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5550
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] syscalls/fchownat01: Convert to new API
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

Hi

Ping


Best Regards,
Yang Xu
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   .../kernel/syscalls/fchownat/fchownat01.c     | 155 ++++++------------
>   1 file changed, 54 insertions(+), 101 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
> index 3b29f1e75..7bed555e7 100644
> --- a/testcases/kernel/syscalls/fchownat/fchownat01.c
> +++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
> @@ -1,134 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - *   Copyright (c) International Business Machines  Corp., 2006
> - *   AUTHOR: Yi Yang <yyangcdl@cn.ibm.com>
> + * Copyright (c) International Business Machines  Corp., 2006
> + * Copyright (c) Linux Test Project, 2003-2023
> + * Author: Yi Yang <yyangcdl@cn.ibm.com>
> + */
> +
> +/*\
> + * [Description]
>    *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> + * Check the basic functionality of the faccessat() system call.
>    *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> + * - fchownat() passes if dir_fd is file descriptor to the directory
> + *   where the file is located and pathname is relative path of the file.
>    *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software Foundation,
> - *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - */
> -/*
> - * DESCRIPTION
> - *	This test case will verify basic function of fchownat
> - *	added by kernel 2.6.16 or up.
> + * - fchownat() passes if pathname is absolute, then dirfd is ignored.
> + *
> + * - fchownat() passes if pathname is relative and dirfd is the special
> + *   value AT_FDCWD.
> + *
> + * - fchownat() passes if pathname is an empty string, operate on the file
> + *   referred to by dirfd.
>    */
>   
>   #define _GNU_SOURCE
>   
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <unistd.h>
>   #include <stdlib.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "fchownat.h"
> -#include "lapi/fcntl.h"
> +#include "tst_test.h"
>   
>   #define TESTFILE	"testfile"
>   
> -static void setup(void);
> -static void cleanup(void);
> -
>   static int dir_fd;
> -static int fd;
> -static int no_fd = -1;
>   static int cu_fd = AT_FDCWD;
> +static char *testfile;
> +static char *abspath;
> +static char *empty = "";
>   
> -static struct test_case_t {
> -	int exp_ret;
> -	int exp_errno;
> -	int flag;
> +static struct tcase {
>   	int *fds;
> -	char *filenames;
> -} test_cases[] = {
> -	{0, 0, 0, &dir_fd, TESTFILE},
> -	{-1, ENOTDIR, 0, &fd, TESTFILE},
> -	{-1, EBADF, 0, &no_fd, TESTFILE},
> -	{-1, EINVAL, 9999, &dir_fd, TESTFILE},
> -	{0, 0, 0, &cu_fd, TESTFILE},
> +	char **filenames;
> +	int flag;
> +} tcases[] = {
> +	{&dir_fd, &testfile, 0},
> +	{&dir_fd, &abspath, 0},
> +	{&cu_fd, &testfile, 0},
> +	{&cu_fd, &empty, AT_EMPTY_PATH}
>   };
>   
> -char *TCID = "fchownat01";
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> -static void fchownat_verify(const struct test_case_t *);
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -		for (i = 0; i < TST_TOTAL; i++)
> -			fchownat_verify(&test_cases[i]);
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -}
> -
>   static void setup(void)
>   {
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	dir_fd = SAFE_OPEN("./", O_DIRECTORY);
>   
> -	tst_tmpdir();
> +	SAFE_TOUCH(TESTFILE, 0600, NULL);
>   
> -	dir_fd = SAFE_OPEN(cleanup, "./", O_DIRECTORY);
> +	char *tmpdir = tst_get_tmpdir();
>   
> -	SAFE_TOUCH(cleanup, TESTFILE, 0600, NULL);
> -
> -	fd = SAFE_OPEN(cleanup, "testfile2", O_CREAT | O_RDWR, 0600);
> +	abspath = tst_aprintf("%s/" TESTFILE, tmpdir);
> +	free(tmpdir);
>   }
>   
> -static void fchownat_verify(const struct test_case_t *test)
> +static void fchownat_verify(unsigned int i)
>   {
> -	TEST(fchownat(*(test->fds), test->filenames, geteuid(),
> -		      getegid(), test->flag));
> -
> -	if (TEST_RETURN != test->exp_ret) {
> -		tst_resm(TFAIL | TTERRNO,
> -			 "fchownat() returned %ld, expected %d, errno=%d",
> -			 TEST_RETURN, test->exp_ret, test->exp_errno);
> -		return;
> -	}
> +	struct tcase *tc = &tcases[i];
>   
> -	if (TEST_ERRNO == test->exp_errno) {
> -		tst_resm(TPASS | TTERRNO,
> -			 "fchownat() returned the expected errno %d: %s",
> -			 test->exp_ret, strerror(test->exp_errno));
> -	} else {
> -		tst_resm(TFAIL | TTERRNO,
> -			 "fchownat() failed unexpectedly; expected: %d - %s",
> -			 test->exp_errno, strerror(test->exp_errno));
> -	}
> +	TST_EXP_PASS(fchownat(*tc->fds, *tc->filenames, geteuid(), getegid(),
> +		     tc->flag), "fchownat(%d, %s, %d, %d, %d)",
> +		     *tc->fds, *tc->filenames, geteuid(), getegid(), tc->flag);
>   }
>   
>   static void cleanup(void)
>   {
> -	if (fd > 0)
> -		close(fd);
> -
> -	if (dir_fd > 0)
> +	if (dir_fd > -1)
>   		close(dir_fd);
> -
> -	tst_rmdir();
>   }
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = fchownat_verify,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.bufs = (struct tst_buffers []) {
> +		{&testfile, .str = TESTFILE},
> +		{&empty, .str = ""},
> +		{},
> +	},
> +	.needs_tmpdir = 1,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
