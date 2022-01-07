Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D0AC433F5
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 04:09:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A50C3C73DA
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 05:09:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98FAB3C1301
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 05:09:07 +0100 (CET)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 65CDD1401132
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 05:09:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641528546; x=1673064546;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=nrrwiByZ9qTnp89I3mZuv+qCBAHYehFd+2E8A93VtCc=;
 b=Mp5gpKNnVLyrcL48ExSAMUNB/ZDOysgavb7QF8layCy7aKBd1DVF2ELg
 82tzQ0RzKQ15ssdNUyBN6ud5wDeRzvqz9Ux7JqPlagyHM28b26Jh+/CIW
 XPYG100o2+BwSqFCuhxhEMVBVFdtc9HDulqPwipF8rdoyUHfE/3D/my2d
 ROxmRtkSTcHbDeE/XgLaNITFe/Mgo8WFM2tUkixRppmqC9IhKtgQwL4BD
 AglQMdIUlz6aDZ5zBd/E49cWzFOnIpwJ9JCiDpXKDGq/m9Rr0NhV+GUL8
 dRlgSSJEHu2g8/bLnvGUQ/VIdgULzPQjDKc76/zLhHBwhMXTLT+jrR6wz g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="47148533"
X-IronPort-AV: E=Sophos;i="5.88,268,1635174000"; d="scan'208";a="47148533"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2022 13:09:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOCv78GiG6Q6adNNKt8j3b0gp1KOgpnG3FZ/TI5s9TwEql3QT34lYYNEr1BO9HyybTgD9sGCtBrBV5w+7XPSrrXrodnyEab8OL3M2hXI/wXAe9DARegc9nF7S6ZEJe/a823sr1D6pzNup0lCeOcYA+bhmsf9EnYEgx71/YDvnoVjLh+0Af2V6edwd2fTd6iGXgLwnqv7An/1/FCk6TJmDM/BleDnpWa3fjyyOUuCdGQaPnvXZSijt8B5OMxojzTWDq7hWz3PKULDs7lFIaO7ejusE+dTXz2IWvjGm187ElYuSwCxIO+fpyJhinSug193/8z4+Ab8cHsZ93f9Og+SMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrrwiByZ9qTnp89I3mZuv+qCBAHYehFd+2E8A93VtCc=;
 b=kxL/Vr88D+C7oA/STQbo8DdRay3n8IhlnI7jQzlMr/FuhHiOqjpudffXkY/fJgYZLwfB8pbChg5dnu/CNvAiWOVPPZRpR4c+LGSKo39UKuiNAAzKquMKz5uLCpYt/SyflGtBvSvxS8V2LkXZ5hbge6s00+CRzYyUeTY9wjfFGhHoTpdgavDKsJk3X7Fl8ItBu7QyouGUUBBjU7f0Pru5j8zwX1EWouhQY90+VnP50G97g8/Z1vXIv4L+RDRXDI0O/dK5l30C3eF7l2VPorK6rKuAu/6lpJxukp+HliwZ/RtaT6ampVwHH7S1OFfYtrh/GVCQHqyVaOloEbpSX19/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrrwiByZ9qTnp89I3mZuv+qCBAHYehFd+2E8A93VtCc=;
 b=QS0YF5MwcHACFjReaP7JxVWRaDC/vkigLkxHCr8nDg6cxeTnD/QJd5dRGmGSrEZH16WA1BBw+h8Nrnv9dyD27uSx93F8ZhF5Oxqnyq/Hwo3rmhsR9jIW9Ry3nL2D7aYYzjjoWYXnji6YmL4Cf1OFe2HC74uvb83k1beb/5FFaIc=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB2447.jpnprd01.prod.outlook.com (2603:1096:404:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 04:08:58 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.010; Fri, 7 Jan 2022
 04:08:58 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>, Petr Vorel
 <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v2 3/4] shell: add kconfig parse api
Thread-Index: AQHYAt9Ym4q3iJDhlUyEGKaxT+lELKxV2LUAgAEWM4CAAAQggA==
Date: Fri, 7 Jan 2022 04:08:58 +0000
Message-ID: <61D7BD03.4040200@fujitsu.com>
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641461121-2212-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdbQLuuSAiN+d+Cs@yuki>
 <CAEemH2ddfS3v-v62vWjMGzr34-NfT=OBt1s-x6+dCSQD4p0YEg@mail.gmail.com>
In-Reply-To: <CAEemH2ddfS3v-v62vWjMGzr34-NfT=OBt1s-x6+dCSQD4p0YEg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 872f8e19-c44a-4ba1-e3a0-08d9d1936de7
x-ms-traffictypediagnostic: TYAPR01MB2447:EE_
x-microsoft-antispam-prvs: <TYAPR01MB244736665A45BEF739BC0825FD4D9@TYAPR01MB2447.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8WIpPVtb7YgnYQZlNOtT0wuH6KiSmWQ6BV6Qvg57g3E1yaUW/Ymjx7xQGgn/lFtvtz25k0yFDjaYoDboov5u6bqGdYac2smd1+KUhZ71d29Zz97YJAIlbrkIhYt+33DYJxN1S7aSYFg7GmYPEVZC7kFNlGvdp2Ip+JB9FGfW0v/D6Ae9iv/6YP+K3JHqWHUgxbh8iLtUShmMGyYiV2/AHI0FNQHfeYPbAVxJswrBPdzab0WtdJy2kt668qWfsErD7SzIJtrhDNN+Qr61Cbli5LNmWAF49XTwJisWdB0hU07o42cz4EzedBtQkLcYK41eezTSwd3q9vL5tEYvD85HW2rByK0EdVTg77wLWNSS1ao2OestvmfOWOLRV8mnQhFnga+mcraNDrIz5etIHSPi9+qePhXJ4TMl0WSv8IWjr+WJlxxkab4VWPq0gpwrJyNcR/YDGJTFPuVXrq2NZFhwf16blGiF02Ezeig0urXib1acwvBzX6h3aNYtFju8tahgT4K7AUOX3jwDeuUaKrTuXEvVBs9IjqZ3UkJ6Vq+NTUezz18vBTuEvpIX2xKSFILBHtktnMRG6ZDD+aeJ7LWU8BsJiGtXP+M0vUJmqea7/n8DB0SJbMYTDLQWmkQjbFXHtLQqLdYMms6X8HRmqaHKhGy2K1do4+d146vHiU45uG080kTpYPmUtI+0fqiKbfXjup/KtpAot/LU+Ncyz1zlSg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(91956017)(82960400001)(76116006)(8676002)(186003)(5660300002)(2906002)(66946007)(85182001)(87266011)(4326008)(64756008)(6486002)(8936002)(6506007)(508600001)(53546011)(2616005)(71200400001)(36756003)(66446008)(66556008)(83380400001)(316002)(110136005)(122000001)(33656002)(66476007)(6512007)(26005)(86362001)(38100700002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dzdUNW5pRmxzekQ1R1FFbE9SdHkyY2x1RVMyWkJyQ0xaRThEcGwveFhTYVR1?=
 =?gb2312?B?U1BINEtua0M1ajVBL3ZxOWk1dy9vVndqejBBSEZseVNCb2ZRQk8ybDdxVGhL?=
 =?gb2312?B?WHhZdzd0TEYxM2NjRVhpaEV1dy9XOFpSU05FQXlPRE9WSTN6Zm1LbzZzajlF?=
 =?gb2312?B?ZWJ5QnZ4NkQ5emsrME11S3V6MEdTS1M0bHRJOFJOeVpaSjBvdHptQjhPbUh5?=
 =?gb2312?B?NWZtZFM3U2lQZS9ocFF0TnU0WlE4TjJJc3lxQXpXajB3SUJRRUhmSUJUYXRy?=
 =?gb2312?B?L3J2VnI0MXZ3Z2RlbEcxNVFrRzhGdS9TT0RmTTAvWkRVYjd1dSszRWtFaExz?=
 =?gb2312?B?ZXNHZ2M1bUZITStHMFRxMkp5ZFZtRmNsUkgxMEFmT2tubWJ3NDBKSFhMSDVB?=
 =?gb2312?B?RXVEcURRYlFqWUw2Q2kyUkp5T1M5SGZVRkllOGQ4dm1mTmVrbHBqTjBYbUlq?=
 =?gb2312?B?OVAyUkkvK2wxQlJVc3RIZ0EzVUJCaGZaSFVJeWZNK0JQWEJyNGZxb3BjUnYr?=
 =?gb2312?B?NlRsOVVZMVJSSEc5OGVyRDZkeXdUMnRrZWU3RHFSMzJMZWlTRmhpcjIrTytr?=
 =?gb2312?B?TmptZms2QXpNdFpYNEdVY3BtdEZlamRTV3lFZERGOG5GVDRSRmh4OFdWNHFj?=
 =?gb2312?B?ZU9yVmxTOVMraWlxclhSWVVydFJiOG40U0x2akg3bk5JNEFiZVNCS0d2OFdX?=
 =?gb2312?B?Q3VJY0MwY25MZFhzTHF3TFpwOVV5dFFLSk81UG82cDUzQXIzaGphRE84ZmRq?=
 =?gb2312?B?b1dURzdlZUhBcVNjanY5U1krRWlQZkxzWXNlSTk5NDlUeTdrNjNvVWtrK0RR?=
 =?gb2312?B?RUlJanBSUnVBN0dibWxxc0lTcUlZUVEvUGNvb0d6NXpuZjViaUFqVG15UnVW?=
 =?gb2312?B?anRmU25NaVVWWjNWNFNpYVhCR1ZQczNXT015SlplazJWNDhFWUNvYS9RSzNh?=
 =?gb2312?B?UVpiUXlmMnBWNUVNNmNMQzNVNm9ONDdwZjlBRmlLYVRnSGQxNDdUYkd4MUd2?=
 =?gb2312?B?Y2J1TDV2TGtwaWdYb2psanFheGZsSEErZkNTKzRKODUxVUdsOHE1OWo0Nk5y?=
 =?gb2312?B?Z1BhT1VBWUVzdisxT2hoRSsyZWRuV3ZLVzc3bVdJemQ1MWNERDIvRzcxc25y?=
 =?gb2312?B?Umcwd3M0N21ETG42TG5qakt4cmpBNldTcEFUaERYdENYSmhZZi9CUGhVdmZp?=
 =?gb2312?B?VStVcHYyeEt2dzVDUHZaWnhOUnVIOHBQdG5BQmpFNGlFdVlvcHVTWUFCTzAz?=
 =?gb2312?B?aXgyNmp2bzRDRlBUOTc4elNSMkVvOHN3bHlCaDNRNG1sL3FpbmIyOXFwcmQ3?=
 =?gb2312?B?YnRzbWNCc2hvZHZ1SFZzUDNhTHIyN2kwM1kzSFdEc0RCaThyZVZKNnN3VTJH?=
 =?gb2312?B?dG9qRzRhTndvYU9QS2d5N0NBdkhQdzJReHIrT05IWE55Ri9xamc3aHpuQmZt?=
 =?gb2312?B?L1p0c2JNaDFXbXhsazh4UmtMdkljOU01aVdnTjhLTUZDSGE0SlhWTUdoaXFk?=
 =?gb2312?B?UHhMNTNGR3dNTlNkdDRsUFoya1pwalc5VVMxRHdvQ3JNNzBqazJOdFVwTE13?=
 =?gb2312?B?SzltRnFSY25iVk9MZXRaZ2MxcWhyTVlYZnFNMFE1MXFua0FJVmNvRStFajly?=
 =?gb2312?B?OW55d0pMdFVzZVlqRGpuU2N1bzNlMTlabGs3Rmh2bWZiakVBN0ViQjd1ZW85?=
 =?gb2312?B?NFEzYzFtYWtldktBaWxFUXNjcFRRWStqZVFHN0NkOE0yNktDclVwajlKWXF3?=
 =?gb2312?B?Uy9LK3FPQU43VG5tUWVZK0svbnBLZkh6bWh6NzZaR09vZTZNN2M2ZThTa28z?=
 =?gb2312?B?WVpiMjdJeEZWME85YVpJbllRMTllejBiaUhucytTY2RUbUhUN2s2TWIxME5p?=
 =?gb2312?B?M254ZVpFLzFyTUI2SmVhVjdtY25wdGJMNHFaZDRoNkljZU1zWUtrOTRuMjFH?=
 =?gb2312?B?MlFvcS9xc0lZdWJTRVk3ckxyaklqTFZoQTNHZ2NyWS9BOXg0dVpWL1RsQVhw?=
 =?gb2312?B?Tzk4c1lXckJDUmZMZjQ3cWdMZEtmRko0MFpTWUw1ekV1clJvN3N5S3NQZHI1?=
 =?gb2312?B?cVM2OCs1ZVF6bjRqa3VYUmg4NjRjVExmbkxwU0I0V0dPMzF3ZUxWZGpWOEQw?=
 =?gb2312?B?MVR2VUdGenB4dmFveElKd09zUzVOTktscVdVcFBBeEh6VXVYMWxJVDNkQjlB?=
 =?gb2312?B?TmptRHRueHJ2QWZ4aEphTjgvT3lLZXR4QnhKMDdmQkY3TkFqclNTbUo2U2ll?=
 =?gb2312?Q?V8Q3/vBUYi3FY7E57ArKwlugQ6KpTQXKegSa0s8DPY=3D?=
Content-ID: <C0F60491A483994AB82D73E5D3F033F8@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872f8e19-c44a-4ba1-e3a0-08d9d1936de7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 04:08:58.3152 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gdQW99Sva9+nDQO7Mu8q6YpKO6t0VDMTJbXnJJs34JGtrOJ9wVU2DotU+ITOIXZBBJak+pNcn+0OeOUmD9/j6SczPzMHF8e2KiZ8CYR80YI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2447
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] shell: add kconfig parse api
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Cyril, Petr
> Hi all,
>
> On Thu, Jan 6, 2022 at 7:17 PM Cyril Hrubis<chrubis@suse.cz>  wrote:
>
>>> +| 'TST_NEEDS_KCONFIGS'     | Checks kernel kconfigs support for the test (see below).
>
>>> +| 'TST_NEEDS_KCONFIGS_IFS' | Used for splitting '$TST_NEEDS_KCONFIGS' variable,
>>> +                             default value is comma.
>
>
>>> +     for kconfig_i in $(seq $kconfig_max); do
>>> +             eval "local kconfig$kconfig_i"
>>> +             eval "kconfig$kconfig_i='$(echo "$kconfigs" | cut -d"$TST_NEEDS_KCONFIGS_IFS" -f$kconfig_i)'"
>>> +     done
>>
>> This part is a bit ugly, I guess that it may as well be easier to
>> process in C. A long as we pass it as:
>>
>> tst_check_kconfigs "$TST_NEEDS_KCONFIGS_IFS" "$TST_NEEDS_KCONFIGS"
>>
>> We can easily split the TST_NEEDS_KCONFIGS with strchr() and single
>> loop.
>
> +1
>
In fact, I used the c code(use strtok_r) in the beginning when I wrote 
this patch
code as below:

// SPDX-License-Identifier: GPL-2.0-or-later
/* Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.*/

#include <stdio.h>
#include <string.h>
#include "tst_kconfig.h"


int main(int argc, const char *argv[])
{
         char delims[] = ",";
         char kconfig[PATH_MAX];
         char str[PATH_MAX];
         char *result = NULL;
         char *next = NULL;
         int i = 0;

         if (argc < 2) {
                 fprintf(stderr, "Please provide kernel kconfig list\n");
                 return 1;
         }

         strcpy(str, argv[1]);
         result = strtok_r(str, delims, &next);

         while (result != NULL) {
                 strcpy(kconfig, result);
                 printf("%s %s %d\n", kconfig,result, i);
                 const char *const kconfigs[] = {
                         kconfig,
                         NULL
                 };
                 if (tst_kconfig_check(kconfigs)) {
                          fprintf(stderr, "Kernel config doesn't meet 
test's requirement!\n");
                          return 1;
                 }

                 i++;
                 result = strtok_r(NULL, delims, &next);
         }

         return 0;
}

But it must call tst_kconfig_check for every kconfig expression and 
print many info "Parsing kernel config ..." because we need to create a 
NULL terminated array for  tst_kconfig_check.

It seems also increase calculated complexity...

That is why I switch to filter them in shell.

If you want to use C, I will swich to use C for filter strings.
> I even don't think we need that 'TST_NEEDS_KCONFIGS_IFS'
> variable for users. More flexible means more complicated to some
> degree, if achieve a C process,  we can handle that by accepting
> whatever the delimiter.
>
> But strictly usage with a comma is enough for current kernel configs
> parsing I guess.
+1

Best Regards
Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
