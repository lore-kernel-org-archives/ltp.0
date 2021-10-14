Return-Path: <SRS0=+Yfp=PC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAE2C433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 00:56:33 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7CC610E8
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 00:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC7CC610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87E753C04B8
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 02:56:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E6463C04B8
 for <ltp@lists.linux.it>; Thu, 14 Oct 2021 02:56:20 +0200 (CEST)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 37145600C56
 for <ltp@lists.linux.it>; Thu, 14 Oct 2021 02:56:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1634172980; x=1665708980;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zRrHl3oSM9LmThW3/Lc4O0+0Kix3TiIi8vdQlrpC5mI=;
 b=wFVnGAGrnkvjPXNuP9bp/p/oQt2GhTvg4/fRyBqUWQskA4XdLX2JfYZJ
 Yw7H5S2VkghHBU7fiwFgBDNGYYBraBY8eLmAmLbw5bPzHvp74AsyN9aSO
 /mg4ZgdCkydU1zOICpn0kuSezUuoUrO6SH1M1ZVXwK9Zq3hO2mP8eiYBo
 Gb+SnpnSQOEtVnTXItIuZwxrphNrA1XYhg5LItSYeDW4HNaFd/nVhncVS
 qTOIMMNbTebmRA3W46KBZ2+Rj71a9Ao/5+7KhRZoTRCuaZsLpB3Z8Ez/U
 4yN0I2/Of0eHOOc1kJC0tRKmyYuZsgSyjlJdCqEsB9LIwR+7n1BH9ZtL3 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="41305646"
X-IronPort-AV: E=Sophos;i="5.85,371,1624287600"; d="scan'208";a="41305646"
Received: from mail-ty1jpn01lp2059.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.59])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2021 09:56:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gixU+b0YSw4ifrtAm4FH9cFxxr0wd1nAJNzOH1UCxNnbp92aIZiWG6+A3iYcg358K8Zre5QW8paop1AKBlWQjw/HByO9cpfrczCvQwbs8iy2mNfLsXxI/J6mdc7BYsoWhR80NPpDV6DUVg/1jbnFcG10xIYjGHi7ZN7tpd0NEUXHdIfheddqTeorSlHNWmnHNoHD5HbssQZbAKOyj68wttyoCstXh2L/gtcSvSRTZjyxfeEsgq2MCFVEU873SJGAwhlXwP7rteNwRSjWM+sKGIN4VG/ehAI59H2fqNYkXyKpQ59jnDjkcv6nTZadZgGGgF/YPcTyv1MH97DovE5+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRrHl3oSM9LmThW3/Lc4O0+0Kix3TiIi8vdQlrpC5mI=;
 b=nYO0etHjomRbM7EJ08+bnZgu+r3KOCmHCufvOQCdFEbAY9PGW/MQcwAhvNXPC6GTUBNco0EJ17LfPcx+zKF+f0ZCkesEXq8H3Va0pIe/B5HnYIT6Y9f2ZxdE5TQLs+guUCfsxJAUHxPEKaXKRSKLJLhyiUdTX6qwFLhgaOsf6a9ikQoVMUsguJO4XeHzisbwe+MD6gQ3XeddWygaXXhuVowAwavuHX9EOXJJMNzCMPkIwycg1v0coMqeLfVOufT8COFtegIUtl4XfMlnkQ3TxwMl9L84t+yXPGO5SsWYBzRRAGHy8dmnaEX+1Fk1DKBfsyypfR3e+uA+u349BhIA6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRrHl3oSM9LmThW3/Lc4O0+0Kix3TiIi8vdQlrpC5mI=;
 b=ZpjaVy8YsQAS6GFqZ1q/EjRYCCjnuYbdFR4gFJgw2c0xdDCMRefD2MNiQK/vMeafVJSoqqEdFNtQv5CJPdPS/8pYpK1G46zNvzzlUxYBcXId0QPz/yO24Y9oh4Sebdehg/l6r3B2i3FxR6uuWa9RAqyD8e5xHoTVdDnIu/xUQS0=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB6283.jpnprd01.prod.outlook.com (2603:1096:400:84::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Thu, 14 Oct
 2021 00:56:13 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9%7]) with mapi id 15.20.4587.026; Thu, 14 Oct 2021
 00:56:13 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH 2/2] scenario_groups/default: Add irq into default
 run
Thread-Index: AQHXv8+XbxXxUPx0dkCHZIKXrRy0PqvQfrMAgAAWl4CAACBAgIAA92qA
Date: Thu, 14 Oct 2021 00:56:13 +0000
Message-ID: <6167802F.1040007@fujitsu.com>
References: <1634087649-2137-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1634087649-2137-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <87bl3t9zr3.fsf@suse.de> <61669595.3000900@fujitsu.com>
 <YWawowTWzUhxGZPi@yuki>
In-Reply-To: <YWawowTWzUhxGZPi@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 074dc5f5-a94c-45e3-b32e-08d98ead6baa
x-ms-traffictypediagnostic: TYAPR01MB6283:
x-microsoft-antispam-prvs: <TYAPR01MB6283E606795A787C465BF402FDB89@TYAPR01MB6283.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ouewvSKc/AA9Q4LrqSuVS1uu+h1M5scXMUOwGHQZSM0od8syIVGSCjt/ClJOemfXY+CASk7RgObTOPwGd84aS+eI5IbOqSMUe5Y5XLii4PVjKvqvD7Hh/ZFwOVl9by4YGDj+iZjIPW0EnFakBucEtR0v4iNVR7oeqw9+QFsQxOFi42zcVxb4M4N6EIM6UwgBXo+PZqMJHsZyKkFcuVBkQaPxV3s80Wb1WkMgHOjXNpIvpxQ2M33PnREGgieb/06oWBoroNThjN68sYsEULpnQqJAGGU5WDuA2tStgbePzoOcNxH4GpSZQUJxGqGRX1AVdtvPqmuZlw2MZ0EKELahx6tqAMTBecWsCd7gQK49T5Lzh4JMNhpL7LMKzseGxDsx8quSIM9Nz8OURMNedp8T8fm7Hv/PVpePX0TzIzcqfnLBQi4rbitkO5q34ujWsN0hXVu7M81PEQCWHnFf50Vv5GfQusUSlfMZ40bSd5KXDE8CBFlLIL9I2ZuIxpNYkkb2KBEocfaLpQ8Yo8mndwjdTH5Ua2djf46Xe3P1hZHtM/X1Yp6hANQQCk29GinIVv8O9ueTkf+zjYwOHWKo7iY8BfsGzpSBGcDdK6KK9JytsHBmTylSibJIcvT1/cMy1sXzTl//6r3s8vaz/391G/3MFae6K+x9Sb5aVFOPo7fHIImOxEazVsTU7CJDkRGq8A5jQY1WUIDuENuKnnGyMPdLRQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(87266011)(8676002)(82960400001)(66446008)(508600001)(66556008)(85182001)(186003)(316002)(6512007)(6916009)(83380400001)(66946007)(2906002)(36756003)(33656002)(6486002)(86362001)(64756008)(66476007)(38070700005)(76116006)(54906003)(91956017)(122000001)(38100700002)(5660300002)(4326008)(6506007)(8936002)(26005)(2616005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?THQrWFBkNGlhV00yMUVjdlA2Um9tYzBxNnNwZDF1dFNxdTNsQnhtZjQrelEv?=
 =?gb2312?B?cWw4Q3NGL0ZKc043V25Ca0hoMjhDQjNxZ0Erb1RtcHhuWGZKVjdKSnZMWUpq?=
 =?gb2312?B?NjhzY3g4OHRyTCtiYlZBMUZRemI0T2RlMkcwN242TkREQWJJOWN3Z0ZhemJl?=
 =?gb2312?B?eVhWbWo5dEhDUElpVnRvN2hBQ0FBbHc0T0gvMU03ek9oY2wycThHWWxZNGdB?=
 =?gb2312?B?YnBSNi9FcWFQMjQ4WXpEZHNlLzViNWtjQ256dVE1SHBXWkpiVHN6M0ljQVZw?=
 =?gb2312?B?SVpNNWZrYXAxOVRNQ3ZNcTZTZ04xV3lmUXB1bEM5b28xTjNkOGorWng1a3U0?=
 =?gb2312?B?d2JtbVlvaWwzZU8weTlyUXpvZ3ZwTEtKcHpWZkc3ejRNZ3RmQ2FlOVhGd1ha?=
 =?gb2312?B?bmN4c3RiVXFqMWhLRFJ3aVE0cy9jZy9kWVZMOEZFTG1HejdNNTk5bkZIMDJz?=
 =?gb2312?B?T1d5cmZLSnJ2V0p3VHFFT2ZEdEd5b3NOV1ZlZHkrOGVUWjBaL2ppSEVsQUNG?=
 =?gb2312?B?dmIyR3psbjZUSDRMY1B0Z1VJWWkrQzM2MXpvUWw2RmN2QzdsdjZONFdZWVpY?=
 =?gb2312?B?b3ZsbXZYdlFCOWdpSHFycjJiQ2hxWVcwcDBUT3I5dnpsT3d6YmhxR05aNEt5?=
 =?gb2312?B?NlBmRjFjZzhhNW1PREV4M0VRQjdpTCsvOXVTTWEyWFB5d1hMeDNRZUxqaCtU?=
 =?gb2312?B?cjBJbTVlaWZWQlFQVjJLc2JheHZWWDZPMzEyanhCdDIyQmNVaGhxRUR0UVg5?=
 =?gb2312?B?cTBpMk1rREhacFh3OGw0VjFxRU9uOUZpRlpkQlhkYkZlcTJ6T2duUGVqNVhQ?=
 =?gb2312?B?bGVZaW9LTUxObDZieXlnOGdaSURRWXk1VlJ0T1g5UkRueXJUMFdjNGNNVmdz?=
 =?gb2312?B?UzNlMzlnTldOQkQ3L2ZpeEZjSFNjcU1yTm13MHM5NFdtemNHUUdLQTUxOElB?=
 =?gb2312?B?Z0NiMUFrVkdsRElKam01Ty9EQjFRalU4TWV4VWQ4eVVZT2UycWhNSDVSck11?=
 =?gb2312?B?RG0zcG15VUFYZkdYNjZmN0pXOGlVSU1yeEpaZ1dLUGw2V2l1TXVlMVlzN0Zj?=
 =?gb2312?B?aTRmcVJuOGdPNmhPR3lqQTVOUG03UloycEp0QU03UkUzSUJ6TVpDa2Rjc2pJ?=
 =?gb2312?B?ZnN2QlB3WFhycFZuMjAxNThpRCtBZjZ3aFRHZVh5Ump4aDdndGFWeXF5Q003?=
 =?gb2312?B?WmcyTzQwUEZ1SW1MRUVoVXFJVC9JcFZxY2ZnL2JEYVlBRXFLNEdUVzd3b3pL?=
 =?gb2312?B?bnRjUXBJU003SzB2cG5VUzlkbWZndVh6RlNidW5ldHdGL21RaENlRlVJQmZ2?=
 =?gb2312?B?NllBakdxN3c0ZmtDSEh0bTR6SE8vSThYdk1Lak0wN1NzUTc5bEZtVzVBTUd1?=
 =?gb2312?B?RW5aN2Y2ZzRNS0xyVzkySG1zUlh1MGdzZjJmVWRjUDdwTHNGcG4vSmdreDhL?=
 =?gb2312?B?aERZOXNjNnJ0eHRrVUFRNEozRlhIN2lGZENDa3VHSmlrc0FIajZQN1Z5SXkx?=
 =?gb2312?B?dEg5SVBuMk80KzlMLzZCOFVWaTJKeDJUWWtOQm9qdmNYZTYvcFBUTXZuWE1J?=
 =?gb2312?B?OG5uME1UYitnV25TcU41Um4vVkJKd2c0MU1RMXhEdU5zald6Uld2ei9xWDcy?=
 =?gb2312?B?M2tNenpLd1ZhUEZremxydS9SK3lHaWZEdHpSSSs1c25ic3ZLMXQ2ZGdJOFhR?=
 =?gb2312?B?WElDVG1kNGpESEErenBFV0VSMHVhOHEzR2w5YUp1ZzR4Mk9wU0VJSDh3U0xM?=
 =?gb2312?B?OWh2cnJoTFNwekRUMGxQR1g0Ry9YQ0Y3a25QM1kvNEp2UGtWRFVIQXdVZDBI?=
 =?gb2312?B?Qk1Yc1h1WmhrYXdYUnQ0dz09?=
x-ms-exchange-transport-forked: True
Content-ID: <81D83B7F6362774FA1CDDB427D616DAD@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074dc5f5-a94c-45e3-b32e-08d98ead6baa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 00:56:13.5764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sTPYRBaOvY5awtq9Xikbu5+c9GUXybJSEU4ehcHyfrs3VWgzVbLxNb46KcftE3ZOSPgg1AgvQdd5GJ5xHW+bVHGpdJwRfHYNKKaIYOuTx94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6283
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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

Hi Cyril
> Hi!
>>>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>>>> ---
>>>>    scenario_groups/default | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/scenario_groups/default b/scenario_groups/default
>>>> index 439783dac..1dc2987d5 100644
>>>> --- a/scenario_groups/default
>>>> +++ b/scenario_groups/default
>>>> @@ -6,6 +6,7 @@ dio
>>>>    io
>>>>    mm
>>>>    ipc
>>>> +irq
>>>>    sched
>>>>    math
>>>>    nptl
>>>> --
>>>> 2.23.0
>>>
>>> I'm not sure this should go in the default group at this time. The only
>>> test in irq (irqbalance), only works on some configurations. As
>>> discussed in the test review, the user must figure out if they should
>>> run it or not.
>>
>> It is hard to say moving this case into default run at this time is good
>> or bad.
>>
>> With an optimistic attitude, I want to add it into default run(add some
>> comment in irqbalance01.c that irqbalance01 may fail because it needs
>> some configuration in service or hardware)and then listen whether many
>> users complain about this failure.
>>
>> ps: Many people still use runltp to test ltp instead of runltp-ng and
>> they usually only run default group. That is a important reason that I
>> want to add this case into default group.
>
> Well there are two wrong choices.
>
> If we add it to the default scenario people will complain that the test
> fails for no good reason.
>
> If we do not, the test will be largerly unused and probably bitrot over
> the time.
>
> However if majority here things that we should enable it by default, we
> can try that and revert it if we got too many complaints.
Yes, that's what I was thinking too.

Best Regards
Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
