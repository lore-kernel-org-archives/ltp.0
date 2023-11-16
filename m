Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46D8C072A2
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 02:02:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E7C83CE493
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 03:02:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C94853C20C4
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 03:02:16 +0100 (CET)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E14941A00997
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 03:02:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1700100135; x=1731636135;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=aWINrNezvJgrz0ZZg5HGVrNT8qOilrTVVrrt7Y1mD7I=;
 b=NevyH1QtjcHxiAqWgbFMba+uZ1uECB6kZy2VsoL8ObIt/4nPOxnc/BZc
 b+u6DgrAdcbQwgLH6H650QjWhtNIoPBZQ0g9Uc4Nns+W7JmjekdmfU9o6
 v7ZzTEHIXvykRO1x6wDkqS0os/6evldpbgHU4qTXHGg2HNAAoRZu9YbEH
 4Rs7b+cIK9P4lV34/zFBcm+RsEEGkB5a74fHB1G8FMX69sIBKUF248myF
 WFmNmBVjEUNLgHGKB7cae8au6EKocgfzcsJFDKQAJOC2SffgMHrz3Bahg
 qy5JneluEiTaQv7N76f/0Gz7AM5dhd86e+lfQEabPqP+F+8V2NS/ZJjW1 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="102502495"
X-IronPort-AV: E=Sophos;i="6.03,306,1694703600"; 
 d="scan'208,217";a="102502495"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2023 11:02:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCimSeW9xbjH+RBj+uFkf8nOz2BMkM35XjB6xqS8vrcSMVEcSrE/BwlVg70ICLSpmbmzuRKDO263YHatj0r3AosDFYzhBbGoGItysd6NeGX9YNfIqzHVS3pVtzphu98smPMkV7K04ssTegluzguil+x44ftMVQbrrYuBBw93YE0xETqOAE37rJpJnV/VzUMLN0F9zWftGSJ8FTKmP3oCA+WFPJoUduztgcWvC2+hZD2ZZBfGkaL9try5KDyhefFI8PR1aJkfwhI4ZNpng3CN2Pb4Hai4J2Q6/ENv+X4xYU7h112lmLMHPB4rRhrb032PnNVAjKulN2aIl/6vflsHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWINrNezvJgrz0ZZg5HGVrNT8qOilrTVVrrt7Y1mD7I=;
 b=a1AKS0kmxo3N8yKzSTReSIz4KGeZY5+yQIFAjmXtCcHLkloliQtwNjSL81b/A/xi2lY9QQGdd3feT4713XI83tG+4R+crrospvEXxuGKkY4VJo0qyqt5E+MrUHSjcS8Odkd1jnnJJQvhR8YUGqE59SMH6pbJJC3mRflrB8GdeQwb9xA1Tljscnz7703/wq3HsHoqZXT/HJAjAiwGNhZGVxefa6AOqajHh1BmpneyCUFrwySV6x0VapQ+yYUfl/wh9RplpARjDN9JRQuEm/EHh/UznEUfiN6qpP6JOOzUli7FJVuPj5/byONlv3EOAXQiILmQQRh2jYLdJRVjB3tvSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYWPR01MB11145.jpnprd01.prod.outlook.com (2603:1096:400:3f1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 02:02:09 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::6cc3:e6ca:7c96:ba7d]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::6cc3:e6ca:7c96:ba7d%5]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 02:02:09 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH] vma05.sh: Fix check for core file presence
Thread-Index: AQHaE4rpSEKfCq9zKk2aVlkje8yv37B8OQfQ
Date: Thu, 16 Nov 2023 02:02:09 +0000
Message-ID: <OS7PR01MB11839E7C11C5B7DF037A3DF2DFDB0A@OS7PR01MB11839.jpnprd01.prod.outlook.com>
References: <20231110035648.167600-1-xuyang2018.jy@fujitsu.com>
In-Reply-To: <20231110035648.167600-1-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-11-16T02:02:07.599Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYWPR01MB11145:EE_
x-ms-office365-filtering-correlation-id: 29bee9c8-697c-46c6-7617-08dbe6480a8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nOuaBNkvkJBK1NpF564tZ9YnhFG9vgYRjjktiFG2hBKyIGAJ7zQrczhGjQKqpe0NXm1qDiRH7kj5mEvAlV8dcsQzXMcXZX/HdCJhXv1kOOH8mVp2kJvzWb37EslnxolDk7phqYqCZi3QpTZECpIJ06GMpDws0xZTuCZgM+b2hcKt3E8/AaT/JcfC6xMAWeS9oKTiZHVigUqObIJumuDEBQFF+6OuImBZZBuviIlU5OdVPg9oL91F1If3FYLxlWTlIYrBR+6vXO6Pj8YYVze7xZbI6HCrNu/vRiOpmm0Y87Mq2M8pBt6A/IMg/W1jeF9iMl6NqloXdIWdnJPgimDUbp4sWcBo1k24mLAqxk4Kf7/ARibsKvn7D+t3eiOB4WirxKTakw8lJNf3DzV7i8WEKzMeWkSPnZddEZAD+Jo0WqeR9uf8aukjVXgcPfrRRavgTKFK99Rb8mMuwT67XNw3UI1yu0R/kb6nuXbOSXFwpas3Ohfa5cgxSOkri4CwT3rCdlxFTcjhtWoCGXwJkc+tmWnat4oCTOh7SYUaxPvv20M54KKpSubgCLUP9ZMJoRcQEL9rqR2cxwtoTHWpmBoJDasEX8qyC1hdw5PK3vmZcgddkZciJa5tDSe9bBjsRmWvhleZkrl+N96TuLj5k8cNOw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1590799021)(1800799009)(1580799018)(66556008)(66476007)(66446008)(64756008)(76116006)(91956017)(66946007)(316002)(6916009)(85182001)(7696005)(9686003)(71200400001)(6506007)(26005)(478600001)(38070700009)(38100700002)(82960400001)(122000001)(83380400001)(33656002)(86362001)(52536014)(55016003)(19627405001)(2906002)(5660300002)(8936002)(41300700001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?b0dRTVhDMWxjWHFia2FhZzlCSUhOR0NxVWptem83ZVl0OXZ2ZGswdEtWUVBS?=
 =?gb2312?B?U0ttdDZyaEd5N2xrR0ZnOStZTk9GeTZkUC9pYlMyTjFWZTJJRmQzelZQSDVW?=
 =?gb2312?B?SEorQ3VHdmFobWpvdk5KWFdSM3NmUHAzMW5tT05PRGY4WndDTVVtNXh3Umw2?=
 =?gb2312?B?SmxFOG94Qm5CS1pJM2lET290TDcxNWdaL016czZWQmRjenVZbmthOTNobXJk?=
 =?gb2312?B?Sm1sTzJCdEZmTTJaUURHRHdwMWVkQS9nNnJSU0NJWk9iQkJuMkVTMnpVUlFo?=
 =?gb2312?B?dU9rbTlQRTVrSjdWaE5YZkZ4THY1SVVoU1hWSlA2ellORml5VkhmMWNWZ3pt?=
 =?gb2312?B?MWJ0LzhneWdQa0RiSDVHNjFIUkNJUUNOMVVOZjN3OTQ4VW9US2ZkbFJ5OCth?=
 =?gb2312?B?WUVYMVFuYkZmM0hlYXpPaFNUYWE0Tyt3Rno3NEE1WDZoSVZpbndoeFZHWktC?=
 =?gb2312?B?enRMZC9xcnIrM0tPSjNJY0lab2grNm9RejNZQlphdkVvSjVOQjJCYkN2bWFr?=
 =?gb2312?B?YWlNTUkzV2M5Q3ZyWkcwLzJuM0NGUjhpdURYQzlzdEVHYTNOaUNIZ01TUWxa?=
 =?gb2312?B?NUhRUjlWdUk3eVB6UFgzR3ZNaGFxUFJzelI4K29zSFppQUtnTzhBS1pRNVdm?=
 =?gb2312?B?Nlk1amk3OGRsa3MwM2FlUEkrOHBDbEptRTdxS2I1aXN5TDZSMkZRMHNnM0xw?=
 =?gb2312?B?Q09IMXBKeExLVFZodFB1bmE1MC91WjNhWUFYUlFYdWFGdjV3eUlSTFBaWWow?=
 =?gb2312?B?dzdLN0lkbmRFWkZVbnB2Q1dOQ0YxWkNWMFg1bmhUdi9MRW9jdFlLK2N1c3Q4?=
 =?gb2312?B?Q0J5aHBNUldMUVEzeTlZaUFIRlN2UEZFdFpMNC9IME5IbWoveUpIS2JOV1JG?=
 =?gb2312?B?dDAxSFYxNSs0Q3dVaDcrZm10eWUvbFc4MnFGT3pqL2hodzBDSFhYNGVlZExE?=
 =?gb2312?B?Rzk3cTVUcjZiVlFGMXFaL0pXbWVicHJRQnU3dko5WDZEcHk0Q1VtK2x1dFNL?=
 =?gb2312?B?V1pTRWoza2RWNlFhdHpQcWNqdmtFK0lXTVhEeWx3UWo2U2YvOEJvZ0d3d2Vx?=
 =?gb2312?B?b3FJYUFmYTA4VXJUVFpIK1FjZWpVUGt0TFhBVEl4QlV6dCtxY1NBcGkxcHU3?=
 =?gb2312?B?SXd1ZkdrV0VFTmh2cU5jZ2E3WlhnLzVlNkVRTzhwUDQ3aW1TY0E4VzkxTC8z?=
 =?gb2312?B?UE5GSFNhSTRRZ0R5cU9CUmZzWnJDQWUwd0FGaE05QWVWMjdFdFN3bWd5UTFv?=
 =?gb2312?B?R1RjVm5HT3dKSFdhbVhhRHA4QXYxTkVxdmxnRFhDNmtkWkxTc0NZQ1BNZjha?=
 =?gb2312?B?R3ZxL0VMekJVclF5L2Qxc2M5QlJ0bDI5UlZHS2xUUVQwakN1cnljRm5aWGNn?=
 =?gb2312?B?bzM5Q1FuZDVrRTh6NUN6dFRjQ0hwd2ttVVdqRVZXRkVoMDRLcmRZRE9nWjBk?=
 =?gb2312?B?eGRJS2xJdVA0SFJldjYrVjVITjJoVDAzeVErYm5mbXNmdTJGblU1VzhOdEht?=
 =?gb2312?B?ODQ3bm1ER0Z0eHRxejZvMk1FZjZYTUpOL1JNamUvL0J3cmdaMUxmcHVlM0hh?=
 =?gb2312?B?WXB0cjFjVUlENEFFODY0S0pmL2F5Qzl5bGQyM21hMkVqcjc2WmNGTFo5ZW16?=
 =?gb2312?B?Skl1RldFVmJYZldkMkRaa1VxVVZadXVuVGNpZ3R1cW9RRHAvK2psbm5oTjlp?=
 =?gb2312?B?cTNlbFRyS2dTYmN1RktGYnRLL2g2aHlnRXAzNkFmc2VxS1V0RklISm5TU3lQ?=
 =?gb2312?B?dVh1UVZ3ZWphUDZpNDVVenMvRnZtVVRVeHE0SFlJZlkwWTY0QlVCOXBGd0U0?=
 =?gb2312?B?cDNGWG1kazBGZlRQQ0ovNGhyRDJDT3VOWXpGdTRKa3czNmNXQnRTNDNXcTdw?=
 =?gb2312?B?c3RySHRkS3VnMFdJVFR3WjZ0WnNpRTVjRGFCdFk5UlpCSjBJUE1rT3hnKzIw?=
 =?gb2312?B?bDdsQk04aEE1azNSOWtMQVBpZVNvRGZ6VWhULzB3U1JXc3E0emcxUlBhZDZ3?=
 =?gb2312?B?Rkd6cXZyWEFyQ1ExWlNlN01RZFVONnZ3ZkxTbDhHdnNEZUZ3eHUySUQ4andD?=
 =?gb2312?B?R0dzY29wTE9tKy9FL3VFTVNReFovVERTTmtzY3JIMkowWEZvOTJFSVdQMmM0?=
 =?gb2312?Q?LaoxqJHb70etLH0hEKll7arI3?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8b/gP63B9KhXYsZnp1nQBcLkEHdGBRVc8Ci5h1jECiBoVPRZUUFHk/0ti3GhaYmYZ36HAzPkHh2ippaV2i3/xv5Efk9wnBpyhbkP0buDBgBugyajjRmuhSDuAFNPCP/k/hMoQ9uIpZFYBYSvoMU1r20yukORXZDoOBVoNQ6UyA536WW6mJ0mPkYWxbA7SC3VemNB1ISRl/uJx7UlIyA3VdFTCda52gIl608XfrtEo7VPLlal/OGB4L7Wi8/v83qHJugrgDIfVk42BAK2Bu8gt+pzBhrLkt2cKYCgfZ3UhaRxi17NhSsUo7pVR9CaangWFO1imhkLvR+g+phgWDt1hRTYLgcaHOJcEIDdIssSfp9NUBpro9XstEhQ7Itza33BqIhJEdrT2uf1IifH001NLBYmf5eCgxYbqrfB5Osi96uDUeybIFTZiVWrjMoNv498j/1lmAvsVJ+rMXG9S0zJzGtTDjgfw0E+8hYLvY6hvloB94moKCqTCR+O7piW+n8PpmIYNDfQqRvX0VXVdVC2+Ip3CarqcquAwO3YNbQxcTLk1L6s/CMC0miDsnlp6IoxFZKbnitQCMd9RgfulFOSiquchoXh5NualRXxPJHqRA1AY9nj9j+AI8RV9p1ogoSPLGjy2jVS22n706U7N6SoLWmHbJsBqUHlcw05LHDNOsAtwN+HD/5HHRfoUmBrub1rr7f55pFx1RogcpO/tlIXFmYvH/RHvFBAHRYeuWiG+CbXO4CUBBJgMXsNGj+CY9mbsa+xC0/QJxg5CSsd7BTHSQ==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bee9c8-697c-46c6-7617-08dbe6480a8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 02:02:09.2096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /N3V5SgFMCVm/xdx07CxgFRsn168rdhvSFzfBmEEfV7i3ZyaMa3flffMuNynIgoXCGgExW/p/mhJeEsYs0/TbuoFDtrHiMGFxzAORZFos0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11145
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] vma05.sh: Fix check for core file presence
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

Hi all,

Ping

Best Regards
Yang Xu

>When I tested it, I found that the test produced the error:
>vma05 1 TBROK: missing core file

>I try to get the generated core file
>  rm -rf core*
>  { vma05_vdso; } > /dev/null 2>&1
>+ ls -l *core*
>  [ -f core ] || tst_brk TCONF "missing core file"

><<<test_output>>>
>incrementing stop
>vma05 1 TINFO: timeout per run is 0h 5m 0s
>vma05 1 TPASS: [vsyscall] reported correctly
>-rw------- 1 root root 458752 Nov 10 02:16 core.931905
>vma05 1 TBROK: missing core file

>The test actually generates not core but in the form of core.n
>So may be '[ -f core ]' should be changed to '[ -f core* ]'

>Fixes: 63529eef ("vma05.sh: Add check for core file presence")
>Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>---
 >testcases/kernel/mem/vma/vma05.sh | 2 +-
 >1 file changed, 1 insertion(+), 1 deletion(-)

>diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
>index a09951462..6f5459308 100755
>--- a/testcases/kernel/mem/vma/vma05.sh
>+++ b/testcases/kernel/mem/vma/vma05.sh
>@@ -54,7 +54,7 @@ vma_report_check()

>         rm -rf core*
>         { vma05_vdso; } > /dev/null 2>&1
>-       [ -f core ] || tst_brk TBROK "missing core file"
>+       [ -f core* ] || tst_brk TBROK "missing core file"

 >        TRACE=$(gdb -silent -ex="thread apply all backtrace" -ex="quit"\
 >                vma05_vdso ./core* 2> /dev/null)
--
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
