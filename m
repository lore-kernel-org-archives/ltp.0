Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67743C433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 08:53:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BA7C3C6D07
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 09:53:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3F233C012E
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 09:53:22 +0100 (CET)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 85ABE1400765
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 09:53:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646902402; x=1678438402;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=eoNHtA0RUS76wJV3FxVJNXHia4jb+rbPmvABHZwQIZw=;
 b=oZ13oyFcCYdQ2Con3RV8gTsK12F+x6agMgv0syBwTqDbzl/A3PqexWME
 I7QwLN0psIRIWxyuOMXm8FjiM0mmaheCK9rpPTovng5f9+mweZgSIOgGO
 4TMah9Dwd8kCL4DLYG1dB86v4gKVwraK9ZBJAx+/IYYlrSODqkEI8/9bK
 LMvtKBqRg3USBYBlC9LiJ1JcSMoOPswgFxBCOW5Z/7wvLhqdaiZqNWc/d
 8KF8h+wXTMG4BUweZuLo3ll8wU7S4Q6nk9iruQbu0roRV8uF67tYxfcy1
 rm/wIoraOVVoWgdz8C7cyI/8Vn8urZqLO+qRBnnGf+3KdFBO+if1j9l+X g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="51389859"
X-IronPort-AV: E=Sophos;i="5.90,169,1643641200"; d="scan'208";a="51389859"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2022 17:53:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSqu7IRVeJ6nQfJQ5D7zo827uYEUS0BfLCvtzK0hyLqBXZj7YIZRhGEyQQLyBGkGi8CDk1mzwOBZIYW8nO2p6M90EGIclV/tYhRY/XLc58CeFSDFlwBU+7nfxScXddBKdOdfQNGhOxYXiBjLmlDrm8fx7/Qn/tbiv8YG+tWJBqf2S+bX1M/QtcJfty8BwDupxzDk01/TOiulfiemYAmsa1j2r+idD/XzByJ+ZnxKkKoGQKRH+ER+3luaRrXXPkWiJI/xyUDbnIWdyLN8tew6KyZy2aVgAOjBEH5AZwy0JbL2hg5ysEUSSQWKLfQD9ec4hZElNFaoiL5usZJunJJqHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoNHtA0RUS76wJV3FxVJNXHia4jb+rbPmvABHZwQIZw=;
 b=YrU7I1wlJ/mf3l5S18tXbh+kpfF43QBYlqeJpZ86V0ZrKeXPcOCdE6j5mna5Y6820CbILmAhd5VkHJ1BU/ban6d7UAMiXI9y66J1fzoIw9wVrpI0weyRvGPZ7In/m8cnvJsEEFhLZf5xeFEnErdd4E/310FPGuyvwMW/VaN0ALHQftg5HjV75daGumoMlAIZN5hK786MWQtwXtFdDTnEGmFWzoPMb8WNsMPpWNm7SSqX7OoOFHWZTdUPKDBD2K6q4Ca3AVl99Og4rzOpXsQEY+eQ7UTsxRjLx7LAZXmqIs7D+r3QcBlTKcOkP2DqKri5KOskOhzfvTIrVOk9Vn6FHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoNHtA0RUS76wJV3FxVJNXHia4jb+rbPmvABHZwQIZw=;
 b=EotPIBdpd6oFWySWbcQ98dTypmd3CHDSQqzqbqQYLiIGBW1kr+i5DtylaGICwPIOFtna9glK4i8iDxXDhpgklQgpyTlG6KyDJGuFG7mcEwT90fYEvOdkS40f9mowkAyLucanMu0TdSwk7rD/8DXLrGCrUtiyZ/sC7NUuKP1ZOis=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYYPR01MB7879.jpnprd01.prod.outlook.com (2603:1096:400:113::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 08:53:16 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 08:53:16 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [COMMITTED] save_restore: remove the duplicate 'const'
 declaration
Thread-Index: AQHYNFgSYIbYXI+N5kWF9T931P877ay4S/YAgAABrgCAAAJ5gA==
Date: Thu, 10 Mar 2022 08:53:16 +0000
Message-ID: <6229BCAF.1020502@fujitsu.com>
References: <20220310082251.13173-1-liwang@redhat.com>
 <6229B934.9040606@fujitsu.com>
 <CAEemH2dwawam7iK+E7KnY8Qi0vwz9NWXEf4Bzo3o_9tz-75kjg@mail.gmail.com>
In-Reply-To: <CAEemH2dwawam7iK+E7KnY8Qi0vwz9NWXEf4Bzo3o_9tz-75kjg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8effcd8-8c93-428e-4ee3-08da02736afb
x-ms-traffictypediagnostic: TYYPR01MB7879:EE_
x-microsoft-antispam-prvs: <TYYPR01MB7879D851BB53DBEBA0AC1308FD0B9@TYYPR01MB7879.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ythEoU0fpR4fNkMENuR/WlFVi2BApse5u74PR5D5a81a1r6+a3U+tZXoA946MD5vkFovj5FZ3qIXYAyu2J+SjQfCN95N53pA/2NxihOrt/2udHDRwOPrNsdwSeZjp6t+o9x5FLgkwQotJaXyhzKMB3xUuL70U+PyN2B7ZsOwUc/Ggk2RXClQYMrlFpcAokJkmjYguhQg4pWBBI9G+MWrItGPY0KkG7WMa01h7aeRGZ9qkPnEBdrzQXsNEQG5LhZGsCwjt0etfhp+Qppfc992gEfnwMC5EozEws1Tfrk1ZzB/Tl5FTDorte4ZDLXrMh04/0mRa9bVAnOXXBKwh9ih1YOskSRd//sjuIJ8/grhOV+DbF6SGZj69+rz3322nbbc6xHAxkmrFSftpPzt0DkV83FmqkpNaBJ+Xa6pJit48cgnR+ciGQJh32pfglyUIwVZEKmiMhZXIezgqJnL+32P5OfWkieVYr+Ggr/DpDBMt5ooAvAV7RT94Xc9ChemK9Ruf1pe1ORsoPv9KMsNYI4yiuEzhWyp68CXXjRhEvVGdcXO2vOu8vvClYvbre596rhEuhZVyYf0sAZbDSl6b/p7XWKQSwSlrfSAk/DE325Xh8IksyYr2NRPDjEpVKHVi9gTQYl+nQb/yxQBTNsQ9zqw61ga3IXvE/lp47ZuQBSaDvbxf2XgEW+gmVCknUGD0WaObJOGaJDRdbRaX+c8kxg+uQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(2906002)(6512007)(508600001)(66476007)(66446008)(8676002)(122000001)(5660300002)(2616005)(186003)(33656002)(53546011)(87266011)(26005)(6916009)(83380400001)(6506007)(8936002)(82960400001)(316002)(71200400001)(36756003)(86362001)(85182001)(38070700005)(91956017)(76116006)(6486002)(4326008)(66946007)(64756008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjFTUjN5Vnp5cnZETW10SHBiNEkvWWU2clgvS2hrdEZ4cnhoZlc5UTdueEFH?=
 =?utf-8?B?N2ZyZWdUTjZNQTQ5WTBUM1lqaS9uWGc4WkJWOS9mQkpiZHRENWZVY0h4Q2pB?=
 =?utf-8?B?OVVjbSszM0JwTndlQWdmT3F2YVl0VzRiOWNLMVRvbm00eXg5NTJuaXNkUWdK?=
 =?utf-8?B?b3BkNTBGWmgxTWlzZE1UK0t6WXdkN0xwODFZOTY4S2RzRDk2VW40R3A5Nzlm?=
 =?utf-8?B?YlBid0JtdHZzM2QzWndUZ01lbzQxR3lPUmZ0N28wdmNyNkszOTB0cXQwaDQw?=
 =?utf-8?B?aGh0eUcvNVVTd3grUXMxVDhNem9jRnd6V3d2aVhTdUx5RDdKVzMxZy9iZ1FE?=
 =?utf-8?B?b2k4aU9iN2Y4OHltaTBaU1dtOVduTThKd0dGbCtIUWFWMjJwblZzc2tBdnNr?=
 =?utf-8?B?NVdNU0xOMVc1L25pQUc2d0tCWWdUaDFLcFJORUpDYWtSaldPRFhoRVE3OXhQ?=
 =?utf-8?B?ekJCV21KNURiQVUwMVg2Z3FjUklvWHJIU0J4VXBQbXpVYUdldEZna1NLa0x3?=
 =?utf-8?B?bGlVMEZQSnBCUlRzZmk3S1FsYVkvNU51aExTSmJwa2lKS2lYMExnRnd5WmlV?=
 =?utf-8?B?N0YrZ0NoelpKazZ1Rm5OcmpqTUhmNURPTUtwTDlET3RFbXFvMjc4WXFMdXB0?=
 =?utf-8?B?Z3RkQi9CRGV1OEpwVjJmb01wS2NvVGtoaXJIZy9tTkVIbkNPSGV2QUthOHZo?=
 =?utf-8?B?QzZkT21qWllwOU5ZdS8wdTFSU1VJdndWQVJGS3IrWHBOdzVHVXIxbHlVNTFI?=
 =?utf-8?B?WE1FRWVlWFN3YUFtMUExcG9Ud0xHN29zY2xjd01ZNG5hbFFxMk9jWEdZL0dv?=
 =?utf-8?B?M2hqWVIvRko0QnBKTWFUNGhtVnN6WlU4RlVMaVFiKzVwaWY5T0JWMzYrVlJO?=
 =?utf-8?B?czdtejI2VjBlY3laZjY2M0t5eXNPT1hxNVB3WkpLbTlvejdsWGNmZ0Q4a1Jp?=
 =?utf-8?B?UnVnWjRqVENDNEJXQXk3WWl2azB3WGRpbnFyaEZDWjB5bmhjMmN0QnhuMHBD?=
 =?utf-8?B?NFFRRkJJRmw5MFJINVRpQ1VNY3B5MnVIbWpXSWJDOGI2ZHRKVnB5TndNZW1n?=
 =?utf-8?B?ZllVM2FhbkVZc0tDaysyK21odHR1N3gxeHduSEEzZkQwREdjVWdsbVprdW1r?=
 =?utf-8?B?L2pDY2VYb25IZGtNempXN1Irc1g2UUluMkZIUi9lUkRkWC9HR29IUFMrUDl3?=
 =?utf-8?B?cWRzMDAvSmFyYml5a0d1SlYrTmJjeVYwalRXWlpyR1gwSGtkSnNFR2xKWkRI?=
 =?utf-8?B?WUx2a3VsL3B6STBLT2FTdDAxOHNCV050RVhzSlhvZVYwc1RZYlRwWmRHNVdJ?=
 =?utf-8?B?ZlhTY1lsNUo2dFFpTnhQSVY4SmJxcEJlY0I1MDUrYjloVUZ6UnZxUDZrcnJo?=
 =?utf-8?B?eTRGS0dQVUxiRFFYQ1VZdVhGVFN1NHpDZEQvVGxyN1l6UFAzdTNsa3JxYXNT?=
 =?utf-8?B?cHlib3FSajRNM21Fb3crcXFQbTZuNEsyWWZnM0xVY1JGZFMzeE5NZEVXNDkz?=
 =?utf-8?B?UjJrS3VTeThBZi9JVW80eUhRMWwwV1NQa3N5WTFZRGRBM2hhZW9lcW1ENk8v?=
 =?utf-8?B?cjRiR0hrb1JjcDJqNFA5MVBGQ2FKc09HVE9LSy9peXAxRE9KRktQQUcramFZ?=
 =?utf-8?B?L2xJc0hxMHFoWTRLczBwUkI3UW5vOU1KZHJGbjdBeWhEWFFjcUpvOXduQ3kx?=
 =?utf-8?B?d0VFMXloRlR5ejVwRWd5UUtLbThaZG9HUVVaRFFpWFZycUtmMGhaK2JWcTJE?=
 =?utf-8?B?aGxSdDdNbDFJWWFkQTJRWEk0aEk3eitONUZXTGNweFViQ3FUS3FobzRtNjdW?=
 =?utf-8?B?YW5OTk1GS3lvOEN0enJGSm1BVVlXRmxXSUorOEJqNVZ5Y3FaamNZOUY2c0Zv?=
 =?utf-8?B?bjVyN1ZJcTNGRmdWY0dHSllIQXJnUCtDUE5DT2RxRkV3Sno3d3VHS1FONm1I?=
 =?utf-8?B?VklvMUFzSlpFR3Zraml1aXNDTkQxS0xuWmlkS0RNL3RZeWRHZ1BHbXZyUFNK?=
 =?utf-8?B?TFRwQUxyNjF6ZUR6ajR4aHNOK2UvWVFNTzY5djN3ODY0NVhPalpUSXNMS2xQ?=
 =?utf-8?B?UGVaNUFIMTFhTzJCUUJHSVRXdU9vK1B2WjErRVpnUlBzb0JSWjIxcGgwS3dr?=
 =?utf-8?B?QmlVYngwcVRzbkJQMXNFOTFBZ2JnSXVzVWc0VUVMNFpsQTNUNUgyejVDaXlQ?=
 =?utf-8?B?SE9ZWURSN0ZoR0tlZG9Xb2ZQbTQwcXNzaXY5V1VvVTQ3VFk0amEvZktHODRJ?=
 =?utf-8?Q?d1hrLmf0QXEZVH+YJutnpE1evWVJAlIGDCxtsixPow=3D?=
Content-ID: <287077944974AA41AF935441C1C3E15D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8effcd8-8c93-428e-4ee3-08da02736afb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 08:53:16.5227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V3QEskVRtZ/3A2QfBtCfxugsK7dEvm5uZpFae1MsvtZGKYa42fWWC8TjLumiwk5vrqRg75U4m8Fo9z/kpatF8p7efcWDtK2xbRlmxyP3Dj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7879
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED] save_restore: remove the duplicate 'const'
 declaration
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

Hi Li
>
>
> On Thu, Mar 10, 2022 at 4:38 PM xuyang2018.jy@fujitsu.com
> <mailto:xuyang2018.jy@fujitsu.com> <xuyang2018.jy@fujitsu.com
> <mailto:xuyang2018.jy@fujitsu.com>> wrote:
>
>     Hi Li
>      > --- a/lib/newlib_tests/test19.c
>      > +++ b/lib/newlib_tests/test19.c
>      > @@ -23,7 +23,7 @@ static struct tst_test test = {
>      > .needs_root = 1,
>      > .test_all = run,
>      > .setup = setup,
>      > - .save_restore = (const struct tst_path_val const[]) {
>      > + .save_restore = (const struct tst_path_val[]) {
>      > {"?/proc/nonexistent", NULL},
>      > {"!/proc/sys/kernel/numa_balancing", NULL},
>      > {"/proc/sys/kernel/core_pattern", NULL},
>
>     Since tst_path_val is a struct array, we should use {NULL, NULL} or {}
>     terminated instead of NULL terminated , otherwise it will report
>     missing
>     braces warning.
>
> Ah, right. Sorry!!!
Never mind.
>
> Seems I was in so hurry to fix the const issue but overlook this.
I also think you can add a separate patch to fix this comment in doc or 
in  tst_test.h for other struct pointers.

         /*
          * NULL-terminated array to be allocated buffers.
          */
         struct tst_buffers *bufs;

         /*
          * NULL-terminated array of capability settings
          */
         struct tst_cap *caps;

Best Regards
Yang Xu
>
> --
> Regards,
> Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
