Return-Path: <SRS0=jFKu=PB=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97F4C433EF
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 08:15:38 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE48260FDA
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 08:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE48260FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9F133C100D
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 10:15:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D08A3C0E8A
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 10:15:23 +0200 (CEST)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 139B21A01494
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 10:15:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1634112922; x=1665648922;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=GDwZEqmQAjeVfAXEZ15dCKMS61sY1nccpk+sJlpS22Y=;
 b=LIdOYDfLd2vnfSKybY2cNS2gwag6t+BXbWF0I/jEXPbu+p3HIWSXSPuv
 VZ4frxKAkh8YcE8j1Oc/d3Iwo0w8uj3wJAaze6z+Qe9ezKnGa0XUAtCCC
 tQCXayAjfJdFC0u4ceiCWmKd2Ep//9w639HhZ4M35MT3G5HRedvJFWbUU
 HRwvxQqeq7qXrBHO4sBMuWm6ZH4Q6QB7V+apSQ2HC/d+Ip5j5b+S0bEGZ
 v8GIsFOdgDILOeed/DTytpvnLTEi/rXkPerCc3/9Jse19eChBq30i/Ea7
 nvF4skvUDyq80Ru5wEReMe687AI+YKbbQzpODMqoisfmV5S43QuWibLIn g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="41393368"
X-IronPort-AV: E=Sophos;i="5.85,370,1624287600"; d="scan'208";a="41393368"
Received: from mail-ty1jpn01lp2059.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.59])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2021 17:15:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoDhWARsTpmL9SzPgcqzfsbnE8XYCX4I/86o5II8gbF9v9O+W0FLKMT9U8FzRpZG+9AltGu2x3XmWLYSD0OxcdC8iiNMJnBcmv5lVh20go6tl5yobpp0afgWM4Gi5jpb7/eWzsq+9Fdhjb1xEmPOleZXSYcrDCKNmLt+TTZ0dNENletf4a+DPBi3dQ8mf1LhMzXs2/EjBDmBMicF72Si3nImd9LpcrHLnHKg6q49yzfLySy1/FbO/EVZQghSijq/X+rCGU5EtXucXadfLS0F/0CCKUK//rvSDT298U0uk08VSZNWqFrlAbUmvFgV/wiGvdmBbH4ZapXgQUkc/iMF6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDwZEqmQAjeVfAXEZ15dCKMS61sY1nccpk+sJlpS22Y=;
 b=d+Kf3HDv6wEmNvaphOjpATyb2yIi70GkKDAO1ZqbSQanyUNgh+v+kOiVS3BGAP8xyQKBwzzRnQBNLsOncG/FQ+2fW/8GE/9L9WK0+f7/aZbJ+OU5m5v5iSNT8snwt7y1tsLONYNRg52jZuBw4nLgJ6d+3TF9mqILGUFArYjYyh6WiJoD55z3Ovw/njXxV8VCQC2Bn8NOgc0IRSSm4uN4w7lEyO7zuB4g/Hi9KeFgiTyM9Mg0T8FTPGT3CIrsvRxDW1erFTRvcF/BbBXwZCJ8GAw/kpmXwiDDtspJTG1okOjWH8E7MSySH0FUuXI4dhrfz7nHM4XcSmJKMsBQg+gSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDwZEqmQAjeVfAXEZ15dCKMS61sY1nccpk+sJlpS22Y=;
 b=I2cWiUyrig/hpD3BcT99jRvNaRQmnMpVmGXbjlBPtSb/AH3YWcZPmYpEQgyElP6PX+uwkBdizawD1OKOJ727F4yynVYUtM9PjlfrQTuLZqoLd9uy5k6x2kwtGYzUf9gtxNnZlXvpDe/TBBC8Ly1J7/bcswWApFMK0ROMCZAikRA=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB3658.jpnprd01.prod.outlook.com (2603:1096:404:d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Wed, 13 Oct
 2021 08:15:17 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 08:15:17 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH 2/2] scenario_groups/default: Add irq into default
 run
Thread-Index: AQHXv8+XbxXxUPx0dkCHZIKXrRy0PqvQfrMAgAAWl4A=
Date: Wed, 13 Oct 2021 08:15:17 +0000
Message-ID: <61669595.3000900@fujitsu.com>
References: <1634087649-2137-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1634087649-2137-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <87bl3t9zr3.fsf@suse.de>
In-Reply-To: <87bl3t9zr3.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 989887fe-eaef-445f-555e-08d98e219745
x-ms-traffictypediagnostic: TY2PR01MB3658:
x-microsoft-antispam-prvs: <TY2PR01MB3658B21CC0C61729F7DB8BD5FDB79@TY2PR01MB3658.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hXL8CErEdPUatG210N6PJRVWqibmV7m1YfnYDG/Y9cbt2jcA5ccta4PXQIQUVd5DOaSPk0ASrVXEya8pFKBZxi17cpAHoNcY+at7+giutPLfabjWZ7SuFkPzjlPUaEOxlZDDcxp30m1qfnuTmdI5SjqWjhi28VkCPOo+V0X3zcrgciAza14ke0KOx9vU1MwNz4MHprQCiW+1X+nCK5TBDJ3xGe4y039BmEUH4e2LDE6mWbaPYWFjDSn0zwAjJ9Xqw73oViA6Kg3/YUS4QCmDcVX3xmgn0hOu5IBZFSLe/Hu6c1zRwiojeWqTqgtsMx0fqxTYfoXg5pV+KNdcaJkgDIITzUOs/laJQDDbhvmLBtwLfRph9qzj5zY5h6tvL0bVZCRbQywXRBj/9dRc55rrqGhYgr77lw1UpPJkGFwDSgVzwbuvHxtVQeHcHTrdaiOWwo/38kc/DdEQIQcaVzGogP/7KGYNk+n0XApruNEcg3zt7cNd/xomTw1Y3qGS13k3heDC6uKrgIBa0Cp9EuTUoOmr4IhuKllHWXQgDXE02lIUx4aeHkhvZ5P5l3Bgt72F2VGomVXxtWWoKorhnNtuicg7QBZ8aNDRu9MS8XZNpnNm4RGTqTqPx+SOuLZ2679oHwV5DTX/O7eG1B91jzMx3JfhUK9CuNrpgQB/c8n0CJ5F6Xm75ilXA/N2d7Sr9optJZCntJ57ViiuhuUb0ZqH6K4R1yaiTEB2aO0aiGgY56w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(71200400001)(91956017)(82960400001)(6916009)(66476007)(76116006)(64756008)(85182001)(66446008)(5660300002)(66946007)(6506007)(2906002)(26005)(6512007)(8936002)(66556008)(122000001)(2616005)(8676002)(186003)(38100700002)(316002)(86362001)(36756003)(87266011)(508600001)(6486002)(38070700005)(83380400001)(62816006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RVdPQ2t6b2ExREIxMmZzUjd5L3U4L29DNnRKdDArYzM3THk4Q1lVS29NeWRm?=
 =?gb2312?B?ZmpGaWNEQjdERUh2M0p6QlIyYzQxVVkwZUtOdXA0U1FDbUdyZ0dOM1pVVmlP?=
 =?gb2312?B?NDhPcjZOS3dOZW1RdVh3a0x3RmtpKysvRkNWVUgvaXg5Q0tvcFhxd0xLUGFV?=
 =?gb2312?B?bytRaHlhbnkzQXI1ekhQMXV4QjZPbExmL05FS0FyTW9GcnN3RlRDK25RSnZI?=
 =?gb2312?B?eGh5YzBBbDdkK1ZyYnkrREQ0RnN2dDZMZmQ1dVllRkR3UDNXNGRZT0sxeW1T?=
 =?gb2312?B?czBWa1F4NmtzTDNxMzFHa2FOM2dTQm8xMzNMYUNpNjF5NFNJS01uUW9QUExE?=
 =?gb2312?B?QUJDc2dPZms0V0NUZGZyUUxzOVk1aDhORXFyaStSaGJwZjZqNTFSL0cvNmhT?=
 =?gb2312?B?SGZ4NnlnRUVTS0QwbkZXT1FnZVAvVDdkOVpyMnNXQytkNldhbDZrdWFzOW9Z?=
 =?gb2312?B?bFRqbHQ4VUJyN3g0dG1yTitTY1JlcFphYzhKSHlYWnQzM3NwYmljUVBtUGtS?=
 =?gb2312?B?dERjWDk2MC8xVEU1bEhvd3ZSY1JSVHhvcjJ4N2NnSjRSR05HVTQrbVVjUGlM?=
 =?gb2312?B?RzEyb21DY3FOdXNDNzdlcE5OeUpiempoMUdzL0tYbjhaRGRHeGl5bmx3NjdC?=
 =?gb2312?B?RUptYyt3c0h2L1Q5MlFUUE94Q3dCSkFwRWNxeHZsYk8yZXF0cVNJeFJsL3hZ?=
 =?gb2312?B?NWFNOEpOaEN1d29mdFRiaVFSMXg2UHRJSFVrbUx3UVJmK2lqcW5kZ2tBaStX?=
 =?gb2312?B?a2p1c2pNQXFWWVJEZVNOa3loWmtndVFYbXU1cEdJVFc5NkxFLzlGbTlnYm5F?=
 =?gb2312?B?d1RjUHlMY0k5bi9YQVN0TWFpdW1RSEtNaHBsTUVVSGlnbXdSVnZjVEp3YzJk?=
 =?gb2312?B?UlhCdnR4Y3p0L1B1VVhxMmoyc3lKMlV5OUViSXJ6SzNaM3JaMXBUNDkwQzh6?=
 =?gb2312?B?OHh5ZUNvVjV4ZTMybEtORVZHa3pPeFBJVEh0Skp1SnQySk01d2lWeEF2a2lZ?=
 =?gb2312?B?bHU4czhZRm5rSUFMbGRZUzFrOGRDTHRBZjY0VHVtL3BhVXhidTZlSndCZld6?=
 =?gb2312?B?L0M1TUlmYmlmVXc4Y09BZlZqSXF5bFBFZTQ1cDJtaGtVRWp3YUViZEpieGhm?=
 =?gb2312?B?aHBFYlhraEU3ckJGL3Zwb0FHelZPTmplU0dTOWZpWGFtTjRDaHJOeDliZTl5?=
 =?gb2312?B?RnFoQ1VOa2k5U0t5WkVuMjlPR2VhZlVYU2ZTdjhHMVVDZ2JEK05TVEtYdS9X?=
 =?gb2312?B?Q0FTNjlwVU1ibW04MFYxcGdnQ0tvS053S3Yxak5uL3o1ajgzazNwRG5hUkgr?=
 =?gb2312?B?ZE02ZklOQXJKSUMxVlBRMXQ1UHdZNnI4VnFRRUhJQ3pYVkdNbjFOWDBTdVVB?=
 =?gb2312?B?QVJqM0Z0UjhqSExKTWZabFFjbjNCTklKK1A4cVh3cFh3VFJMaXRQczRsSCth?=
 =?gb2312?B?MHFsS1F5c3JrankxdkZ1QWpPM2xyNDRmOWZkamVYT3c3R1VvbkwwOTlrVCs4?=
 =?gb2312?B?eXdadS9ocmI2SEZUZndXWlVrUHZteklBbCswUjQzT05BTFZ1d04wVkFEUGxB?=
 =?gb2312?B?SExQVmNJSzNWSlJqT3ZxNVc2NEtkNnVIY1M0Ti9BL2R2RWdhQUI4cFpzQlAw?=
 =?gb2312?B?MmhlQlRaU2luL1VsRmo4TlhBU0prNFVybXVkMkRiYlNUeUZpNjFPOVlvaHpD?=
 =?gb2312?B?Z1FSeHBaTG1NN3RXWVlnb2ZpY2U0SURWSkt1ekNFVnN3Q1E3b0RIVVlnaGE4?=
 =?gb2312?B?emttZVE0bjlQY2t3KzQ1RmEveHNMTTBjREpNRjVNOTg3SHF3dWY5eVhCWG91?=
 =?gb2312?B?SHBUTW43bFZYdGRXOGdaQT09?=
x-ms-exchange-transport-forked: True
Content-ID: <83DA405810E9ED479423A118286BA739@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989887fe-eaef-445f-555e-08d98e219745
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 08:15:17.1409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9R/Mj/wgW5CX6E5oUcSNXR0TeiB4LJGKnxkGZugh336eVZOJSFPjDXHklQcJMb4/33KWf0k41RggjhTufQaouWWqTLuu9vV42Lp5WNBQBic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3658
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] scenario_groups/default: Add irq into default
 run
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

Hi Richard
> Hello,
> 
> Yang Xu<xuyang2018.jy@fujitsu.com>  writes:
> 
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>> ---
>>   scenario_groups/default | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/scenario_groups/default b/scenario_groups/default
>> index 439783dac..1dc2987d5 100644
>> --- a/scenario_groups/default
>> +++ b/scenario_groups/default
>> @@ -6,6 +6,7 @@ dio
>>   io
>>   mm
>>   ipc
>> +irq
>>   sched
>>   math
>>   nptl
>> -- 
>> 2.23.0
> 
> I'm not sure this should go in the default group at this time. The only
> test in irq (irqbalance), only works on some configurations. As
> discussed in the test review, the user must figure out if they should
> run it or not.

It is hard to say moving this case into default run at this time is good
or bad.

With an optimistic attitude, I want to add it into default run(add some
comment in irqbalance01.c that irqbalance01 may fail because it needs
some configuration in service or hardware)and then listen whether many
users complain about this failure.

ps: Many people still use runltp to test ltp instead of runltp-ng and
they usually only run default group. That is a important reason that I
want to add this case into default group.
> 
> Perhaps we need a new scenario group?
I don't have objection. So do you want to cover what scenario(advanced
or experimental scenario group)?

Best Regards
Yang Xu
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
