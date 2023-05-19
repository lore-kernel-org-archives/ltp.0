Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E8FC77B75
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 06:24:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 860FE3CD417
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 08:24:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B39AB3CB260
 for <ltp@lists.linux.it>; Fri, 19 May 2023 08:24:29 +0200 (CEST)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 33530601232
 for <ltp@lists.linux.it>; Fri, 19 May 2023 08:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1684477468; x=1716013468;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=ZGnhBUsZ2OfMX90WDO/Ipz2WQxpgsvnJzK9PlhWyTAQ=;
 b=fLcAW4WjOJT7+sllDtHsjYlLkMjWa+HUNVyis1XMTgfBJiE7tsdiCwd/
 V6k2WCK/yFRUvkuC2S2zF/m8u6xk4QmzssKwV+CxdV/jJ+5SMxnRJh3M+
 +fpxL73ju7qUUWhJR2RgHS5ReJpabi9IupS0TJ2cpbbS3ZONsSQEeYV3e
 xh0lP+e4CtKVtncNNd40Ouv2hdkRk/7fzkUapPQVkeeVUlP4B9jEJq/cL
 rtRKbjXBvRTsp1qMoY+G2vdTmpW+iULGVf+nPv7X8pTHbvbwi+eDuxMFt
 NeTEsclQQz81LcPaT6ePJS4Mq0bFudkFLZkoLAKiA3EV3FcOAnEaxKWbz Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="92562393"
X-IronPort-AV: E=Sophos;i="5.98,274,1673881200"; d="scan'208";a="92562393"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2023 15:24:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4ikHvfhfuKEB58S21uOHgm+L+TQHy3SCHLjGKUcZtKjzcHMaYSQ/FAWyYfkxS147zSHZ/i65MPsIeZrA9QCLzMj4PvEh7N0G1tUhUCOPLwuCwonfl4qn+yIPC64rFyUGpDQ3OyAPmSgV+fKNE7kYw7kgI36K+1FBBz2TZ2HgVljJEIEM3NBtO56A9593Bw8tz0tDepFvuhaWMvqjFCM6yutBKR74QqbXGzPpfsSZGQDRkob3tzNkQmzdMOJq84aJlfU4L0qkplMk6NRZhdTu3r2TDSLP3w8UTPDN5Y+IgMT4RDmxzefjf4v69XDFOWBjBjEXA7cr92bs5OYcYqHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGnhBUsZ2OfMX90WDO/Ipz2WQxpgsvnJzK9PlhWyTAQ=;
 b=KbKq29OfydHJuRDxgpZd/Lvfsjm2gzqtUFaphv6kkEMEDK7IkLSMbscVncJCAcY8ZGujR1841ljXk0Ywyj2DQakDZi5M9wF392k21Oh1zYHLLQRBUNcfGYX1lv00mlsJHwYCrTmqPPE0OOsra5IJawgodeLr1fovU41e9EggftXmZrlyuQYEb6mNq/GK0ZYbN6tKoIT9b8HsH4V98KLSnwdZQdXf6LiIJrnlfquvz0YhWrC6cmdnyKU739nsQ5bW58Q4W4efR5gESUP+d2p0+8RG0Oi+FAlTlmQKhbz/I8CK+Z1Eu2P2cKdlyYl4Iiodch3g2IXOLic0+WhjtsTkaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYCPR01MB5919.jpnprd01.prod.outlook.com (2603:1096:400:43::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 06:24:23 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::a883:7aee:71d:b4a1]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::a883:7aee:71d:b4a1%3]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 06:24:23 +0000
From: "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v6 5/6] syscalls/statx10: Add basic test for
 STATX_DIOALIGN on regular file
Thread-Index: AQHZhvyoWFjUnuIOO0anxp+HCv9Pwq9hJx0A
Date: Fri, 19 May 2023 06:24:22 +0000
Message-ID: <1cb91734-ae60-dd3e-d99d-d8dceb91a583@fujitsu.com>
References: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1684134680-6190-5-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1684134680-6190-5-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|TYCPR01MB5919:EE_
x-ms-office365-filtering-correlation-id: 87c72ef6-eecd-4ae8-c527-08db5831afd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cr+oz6nPIdZ06VC4cSrl7RzIFsdDH4WvPElpC8Gja1srU/vcwhjKJD/C726pzCrXEq8049cqaDIVSGNuJSksRg+Wv4pdBXDQCvlaV03EdkbK1G3ov+fFC+UL0czNHTO1HhX53AhgLnM3UT7ZLAndhXkKdQ7edNn42dLaEc5JyyBdO7zMkAj+7Py3Ni0pYhuw31gY+1AWj7GieDYKluuWEefxGNgQmHkGhgRHThT7cFLQIwWJ+As/fADxSuzWydXNCP3GSFdcaprE6ROinxzVTBKaejBQGfesZ4iMmLFEH+O8HCXHoT9IvibxuP1xrDbKLKBgDnr1tRFCA0nvnkKDhutWcDPEk84n++fiao8+IQU5V3LrDIXE/CDNs58zg1bDdPykseO4qWsR3P/9DkK4EUQBs64SVXmhW6PGLKfG+Duezy2gn9N+lc9dVkPx0ohcytJz5fYwEzu50pll9r4H7oR920Ed0WgWTrOpguFcRDBmFa2vO7yGYTZOt6x3BBOQocUfpEihvlnDNpPjRUpYX2ydkgewnMJyeKt3W5sz1RHSydeY9DZvwfcyq4yaeAw1GIKaUtRnsU5YfpXWBRlXbI5B3Oyp3MwK//hBP9xe085I3n0LPEKx7DK5BykjEtaYlkWhYWfmyDWpNtNPAqoDRkKEvBstECqJ1ojT+KfLHgVKK80m7kKa9FnNlzinBjIy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB9499.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199021)(1590799018)(66556008)(64756008)(66446008)(2906002)(66476007)(8676002)(31686004)(8936002)(316002)(76116006)(66946007)(91956017)(1580799015)(5660300002)(41300700001)(86362001)(2616005)(110136005)(478600001)(36756003)(6486002)(85182001)(6506007)(186003)(26005)(71200400001)(53546011)(6512007)(31696002)(83380400001)(38070700005)(122000001)(82960400001)(38100700002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0Q4aVVEaU8yUmFKVGtaVzc5NFJjZkZLUHlsdEgvMnRrK1U5aTU4NGpPOTFq?=
 =?utf-8?B?MDg1QkNPRHpnM3RkaFMxL0wwY0NIeEtFQm03SzlzT0hja3Ivb3FQcVRzZWVq?=
 =?utf-8?B?SloyRUNNT2ROblVqWStyT3NRTTFkZkFRNzhQZXFHdlVHVkNmRE9QelZPM2hO?=
 =?utf-8?B?eDNHQ2NQa0ZheXdtL08yOXJRT21xSTkvV3NENy9WSmlDNWJjdEFBV2J0SFBF?=
 =?utf-8?B?WGt6RUVOMXE3bzhTMzNXWmt0ei9qNEN1Sk9aZDZ1a3Jvd3M4ZFhpdTczU1pS?=
 =?utf-8?B?ZkQ5WENHOHlkSzgxTFdZTFJISzdPMEpKY1kzVFZBK0ZOWVdvME5wTE1KV00v?=
 =?utf-8?B?WDBmVEtUeGVxVzlXRWVHbmVQOUJ5Z2VvbGxEVFJPMUVpWTN6Ym54R3RDRkVi?=
 =?utf-8?B?VUxVZUJKYjBvc3E4UDNmY2ViakZUUjl4UitJQnA5OXBpeGdLUTk1NGQ3UDZX?=
 =?utf-8?B?MEsxSGVLditET0o0V1MwTEZzMVExVXQxeHQ2Y2N0QXZzZHhIbkRsaEpCbVhq?=
 =?utf-8?B?YXhYTkxnODRaZGlHQ1BEc014MnBZL1I4YjVUK1ZBYmt5SjRYQWdkYitGWnkr?=
 =?utf-8?B?c3J1dW5yK0Ivb01hUEFXRVlmTWpuWVQvL3JoSlJ5aDQwZDRVajQrdWV6d0RF?=
 =?utf-8?B?djh4NGQrUjZtZTRUS1BKN3pkeHY1MjY0WS9oSjZSRGY1eGhjdFJzNmo0TG9P?=
 =?utf-8?B?NnVVK0pEZHBEY2hHbFo5MzdESFZZaWVvbFU3ZVQ2TFNMSXhvUUtrK0t4OWxZ?=
 =?utf-8?B?emtGbEMwUDVOSkZuY3lLSWtLNk16SS8rNXpGN3FlS0t2dVV1VEpMZGRKY1Vj?=
 =?utf-8?B?SWhtN1ZGVFF4V0RtMDBjdm9acjdRSEhHWVZIU1BHK0pCekloNlZBMGJvTmR1?=
 =?utf-8?B?Zm5rUVpyUGVUNHhhck5ROHIyQnFMZzZpWHhHWW0xbmdybkpjR3dRRUJUZjVp?=
 =?utf-8?B?M080VnVtT0oxaUltYjRDUENYVmZ3aEVlTWhJYkdaeUpQU1NvWmhwQ2grQXJk?=
 =?utf-8?B?WTB6WFNqMjlrY0ltSUdRR0dadWZyN0c0NE5WNzhpaFI0UzFVZmRsYTN3dTNF?=
 =?utf-8?B?b041UmErTVVUaC9LMEZBRXY4WERHeTJPdWl1QlYxd3lSbkNzS0tYUUlKTnMx?=
 =?utf-8?B?RkZ2V2lqUklVOFprZlh6Yy85dEJTSHZ4aW5xK3pvWUJXck9XSFI1ZjRQck40?=
 =?utf-8?B?NDRHU0gxVzlJUEFrRSt3NjE3dE1LQzZHR1BhNTk5YXpXbVFiVmVoODU0NDFX?=
 =?utf-8?B?VGxFZ3ovbHZxT20yS3cwd3NUdmlxR0tKbXBjUG5kTmpob09PNjUxNWV6WFZs?=
 =?utf-8?B?Y0phWkRRTmkvZFJoZ0hacXRPYmRFYUtQblRia1I3R0lyMU4vNVVWZTV1bjN1?=
 =?utf-8?B?UFBzbmlxZzdncTVyODdGNnVTcmJ6NEh3MGhTRjBSVmtSZzBXdzBkNmVlRmpk?=
 =?utf-8?B?OFBpanQ3c1BpVzZJMGppWkIyTFNya1BkK0VOZk5hT0Q3ZFBRRjRjTWE4TDhu?=
 =?utf-8?B?QXloSXRvQ0hSTlZtQytEY3BHWm5YKzFXRy93Z1RnZFgyQ1k4Tjd2SUMxYmI1?=
 =?utf-8?B?b0V6MFY2SVZydGU4Y2VEeWJ6cVllRWFIcVdtaG80bmVVSHdSTmtQQ0d6Q2hD?=
 =?utf-8?B?dHF3bjdqRzR4NklLazFZZlpFUVJFVlprTDlQV0xZSVVVb3F0bDduRUJVanVr?=
 =?utf-8?B?d1NDQ0dLdFJ4MGczTlNRNkJuYngyQlY4TUxOS3JnRzJ3K0FoUnRYZGgxYmNO?=
 =?utf-8?B?SHk5QjdDb2syV0VPSXk5M3BQYmRlc29SMlUrckxSVk5kUWVtcThuZ3phOWlQ?=
 =?utf-8?B?RGI0WENNeGc1K0wvalM4b3ozUlVBTXNrWjJadkJjdzdpd0VrQ3dvRGFSQkpk?=
 =?utf-8?B?UjVhOXFha09HSUtPbGdUcmFwY2Z3YUNGcDhDYjY1SWZyWnhDdDhNNEFqOWZo?=
 =?utf-8?B?UTdBVldybmt4MFhBcVJMZUkrN05kS0lXTzNrbW13UXcrSy8zRWpSQXhGTlFv?=
 =?utf-8?B?cTZyMGRnSXpJalVNQ2Fxa3U1NGZaNURhZ2NDM01MaFRZRHpMMVd3clI5ZmlB?=
 =?utf-8?B?SzhoQk5NUlJMTVFDblp5Ym9LanFLTFNBWE9FNXMraHdCcmFOUDhZYlJmNFFh?=
 =?utf-8?B?aDMrRFRqMFNHc3AyMUtQRHd6YTdndit6VnVnTHMrVzdoelo3ZlV3NjBhRW9Z?=
 =?utf-8?B?RUE9PQ==?=
Content-ID: <9BAEDEFA563A9A42855876491245AC40@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: n132UA/Z70f+UqWFB2NBkjoWY4ISTftf+ZGy5x8qcyceTLJDazqPb1q40bh2pdhp6g8NilWNRI5sHV16aO4ayMzraDT9ZJCFR4728yZ3Di8Xa+X1QcZ9L8ze0SF/NWakto0XSONEfht0QGEW0FGC5LooLpSOMrkVlk30Ewn03TApOyfP4FIEx4kp2El6SmmiLyj0T4QEL3HuOGVYFNeaswbQTmHdNuirloY1p0dl4nFGcyirhgY1kfjaQ7a/S1ToEMRvY2GkR5sRmofFSiduTxYCuARQsUMOCY9ktLZkoTQK18bN2YUiYOzZXmFw033fTA7Runq+L29VoIoWJSIeucPGTUDr/zGaaj0LeZpF2N5DdTNzzC/kXHvmYZQR/aORfAExG+xEEaIcQFBU8Y4EXVMtjA7qIVfT/j+/9qUUiFJuLya5w0FBnlpryI+91GvE5ZnvSkLW25WzTQmwGrHiW80VTWjcKNpKfdB2mfJ/e9KwEHp5x2jcrFbxOwN+nPp9/Cyt4z260pg5LmA+uLFKLWm6P0PvrcsX06ROYIsk3FCM3eInwKUssiXJx4rwqS8XZ+KCaObQpvRgXQMfWZ6UCqFSRPho0Bi5mFkfjip0MzTTwCgHOTka5Qv9KLv3cT5Z1zUce/1kNzZWnFagM8UpSXGYFlnq/gHU5rdnYrGekcAyXFrrVe5E7I5IiwtZf4Sxt7sPbIHWGlDU++KsqItAlc4CZx4DTAj77xQG7J3Oj2xrqNn91xrIuZGtR4fSrs7WEWX6FNNxEXcmoRu9BetM9w==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c72ef6-eecd-4ae8-c527-08db5831afd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 06:24:22.9255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MxJ4lFjdLlifdfQY2dlIY5GBxCpOh8+uCYtfulwczcMZN+RSmT5HXC3u+HeQdKHMMnoKmTIazVSgj7fMiPgdWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5919
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 5/6] syscalls/statx10: Add basic test for
 STATX_DIOALIGN on regular file
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

On 2023/5/15 15:11, Yang Xu wrote:
> STATX_DIOALIGN is used to get stx_dio_mem_align and stx_dio_offset_align
> for files on fs that support direct io. We just check whether these
> value are nonzero on ext4 and xfs.
> 
> On ext4, files that use certain filesystem features (data journalling,
> encryption, and verity) fall back to buffered I/O. But ltp creates own
> filesystem by enabling mount_device in tst_test struct. If we set block
> device to LTP_DEV environment, we use this block device to mount by using
> default mount option. Otherwise, use loop device to simuate it. So it can
> avoid these above situations and don't fall back to buffered I/O.
> 
> For struct statx member check, we only check stx_dio_mem_align because
> these two member is introduced together in separate commit in kernel, so it
> is safe.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   configure.ac                               |  2 +-
>   runtest/syscalls                           |  1 +
>   testcases/kernel/syscalls/statx/.gitignore |  1 +
>   testcases/kernel/syscalls/statx/statx10.c  | 93 ++++++++++++++++++++++
>   4 files changed, 96 insertions(+), 1 deletion(-)
>   create mode 100644 testcases/kernel/syscalls/statx/statx10.c
> 
> diff --git a/configure.ac b/configure.ac
> index 4c8763376..548288310 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -158,7 +158,7 @@ AC_CHECK_FUNCS(mkdtemp,[],AC_MSG_ERROR(mkdtemp() not found!))
>   AC_CHECK_MEMBERS([struct fanotify_event_info_fid.fsid.__val],,,[#include <sys/fanotify.h>])
>   AC_CHECK_MEMBERS([struct perf_event_mmap_page.aux_head],,,[#include <linux/perf_event.h>])
>   AC_CHECK_MEMBERS([struct sigaction.sa_sigaction],[],[],[#include <signal.h>])
> -AC_CHECK_MEMBERS([struct statx.stx_mnt_id],,,[
> +AC_CHECK_MEMBERS([struct statx.stx_mnt_id, struct statx.stx_dio_mem_align],,,[
>   #define _GNU_SOURCE
>   #include <sys/stat.h>
>   ])
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 9c23a4248..e2548dae5 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1765,6 +1765,7 @@ statx06 statx06
>   statx07 statx07
>   statx08 statx08
>   statx09 statx09
> +statx10 statx10
>   
>   membarrier01 membarrier01
>   
> diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
> index 1cea43c0d..67341ff2d 100644
> --- a/testcases/kernel/syscalls/statx/.gitignore
> +++ b/testcases/kernel/syscalls/statx/.gitignore
> @@ -7,3 +7,4 @@
>   /statx07
>   /statx08
>   /statx09
> +/statx10
> diff --git a/testcases/kernel/syscalls/statx/statx10.c b/testcases/kernel/syscalls/statx/statx10.c
> new file mode 100644
> index 000000000..513a8c262
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statx/statx10.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * It is a basic test for STATX_DIOALIGN mask on ext4 and xfs filesystem.
> + *
> + * - STATX_DIOALIGN   Want stx_dio_mem_align and stx_dio_offset_align value
> + *
> + * Check these two values are nonzero under dio situation when STATX_DIOALIGN
> + * in the request mask.
> + *
> + * On ext4, files that use certain filesystem features (data journaling,
> + * encryption, and verity) fall back to buffered I/O. But ltp creates own
> + * filesystem by enabling mount_device in tst_test struct. If we set block
> + * device to LTP_DEV environment, we use this block device to mount by using
> + * default mount option. Otherwise, use loop device to simuate it. So it can
> + * avoid these above situations and don't fall back to buffered I/O.
> + *
> + * Minimum Linux version required is v6.1.
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include "tst_test.h"
> +#include "lapi/stat.h"
> +#include "lapi/fcntl.h"
> +
> +#define MNTPOINT "mnt_point"
> +#define TESTFILE "testfile"
Hi Xu,

I think you should use #define TESTFILE MNTPOINT"/testfile" instead.

> +
> +static void verify_statx(void)
> +{
> +	struct statx buf;
> +
> +	TST_EXP_PASS_SILENT(statx(AT_FDCWD, TESTFILE, 0, STATX_DIOALIGN, &buf),
> +		"statx(AT_FDCWD, %s, 0, STATX_DIOALIGN, &buf)", TESTFILE);
> +
> +	if (!(buf.stx_mask & STATX_DIOALIGN)) {
> +		tst_res(TCONF, "Filesystem does not support STATX_DIOALIGN");
> +		return;
> +	}
> +
> +#ifdef HAVE_STRUCT_STATX_STX_DIO_MEM_ALIGN
> +	if (buf.stx_dio_mem_align != 0)
> +		tst_res(TPASS, "stx_dio_mem_align:%u", buf.stx_dio_mem_align);
> +	else
> +		tst_res(TFAIL, "stx_dio_mem_align was 0, but DIO should be supported");
> +
> +	if (buf.stx_dio_offset_align != 0)
> +		tst_res(TPASS, "stx_dio_offset_align:%u", buf.stx_dio_offset_align);
> +	else
> +		tst_res(TFAIL, "stx_dio_offset_align was 0, but DIO should be supported");
> +#else
> +	tst_res(TCONF, "glibc statx struct miss stx_dio_mem_align field");
> +#endif
> +}
> +
> +static void setup(void)
> +{
> +	int fd = -1;
> +
> +	if (strcmp(tst_device->fs_type, "xfs") && strcmp(tst_device->fs_type, "ext4"))
> +		tst_brk(TCONF, "This test only supports ext4 and xfs");
> +
> +	SAFE_FILE_PRINTF(TESTFILE, "AAAA");
> +	fd = open(TESTFILE, O_RDWR | O_DIRECT);
> +	if (fd == -1) {
> +		if (errno == EINVAL)
> +			tst_brk(TCONF,
> +				"The regular file is not on a filesystem that support DIO");
> +		else
> +			tst_brk(TBROK | TERRNO,
> +				"The regular file is open with O_RDWR | O_DIRECT failed");
> +	}
> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_statx,
> +	.setup = setup,
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.mount_device = 1,
> +	.all_filesystems = 1,
> +};
Is it necessary to use all_filesystems? because this test can be run on 
only ext4 and xfs filesystem. It's OK for me if we don't have any better 
way.

Other than that looks good to me.
Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>

Best Regards,
Xiao Yang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
