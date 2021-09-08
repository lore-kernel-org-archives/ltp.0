Return-Path: <SRS0=D2qq=N6=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DDEC433F5
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 07:23:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 756C661102
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 07:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 756C661102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DED643C232B
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 09:23:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75CC43C227B
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 09:23:06 +0200 (CEST)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 655AA10007B3
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 09:23:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1631085786; x=1662621786;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=/3WHGD/OFuMmxUNcLLE4uWoiw0Kip69f0hihJjH2C5E=;
 b=k5kYZQINoooLo+frHOr6A97L+/xXQFIYoNDLnkVcOQ+0Y2ymGQKhC3Yz
 cU7Z5CrDa7SSgjC2+gWj2WnpYHY27CN4yKgWctDvpxl11/CCchoIIMHG/
 qLc6Z4MSEuDJk5MZ631ZCe39FkVCDYvN0rZdO4ymFiaW8oaO985tRNDlo
 aQa/1rPTuRoZCeuRVqtZaeAqgTkZJ4QEwHSYOXELtJN2Y0vj8E09TeCM4
 FoJiJ8OA4WABQHNtV8r+2fKejEZZV+ehFwvzZbnJNTelO7TZGf9mApmCb
 pR3Ligjb4KBsRpHU7lBOs+yztQ9fllZacOmNHnvnPECnBjDHiiKWim4SG A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10100"; a="38492411"
X-IronPort-AV: E=Sophos;i="5.85,277,1624287600"; d="scan'208";a="38492411"
Received: from mail-ty1jpn01lp2056.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.56])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2021 16:22:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVz2hMLbv/YC0HN82nCa+3ZeB1Ouu2i8OUihfoNBRCB8d3KVXQTn4rcM6ZVL0CTREaYgg01NSMipTRVtB3uSIpFrHON4nurznXaVQL00rd3QQ6TwPLY0U6uxoofz5jbXXggBfVnOS4n5HqhelVHcn65TDtzDJAZOuSAzZ8ctdz58brhqSgMT6U/PI6re+yme0GedHcpM5lWyqC58Vsi+vM+7W69lxZoH0fZRZ4ecB8wBwqRQCw47s+Xpq6c/XFo3lriJVnq267ONOWqEsWjc/vppz5rGKAG/3iX3+Hwk0QVM2FD7ay22yqyNfzBXcDHIWwrQltUUdwQ/DZvCJhU7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=/3WHGD/OFuMmxUNcLLE4uWoiw0Kip69f0hihJjH2C5E=;
 b=TJq/TY6HkpCL0QVOLzzMrjrIrgSS9RTMmtgZ2HxYQI1HDVPPu0A8hO4mMky2i4WNPhPI2GElsx8hTzAnS+uT4pZh08D6a6o1loXD26we5D5QUJgtCxk85swN7ke8rw77sQTML2so8+FDdSaIQrIycBQNBpJbyAYQ7Ga3Od3T9I+VNTlhXR+DXpz4FCK0huRqPrOyiePcjug314j5QIg31yrHvrZzUzBlFdITDsiory1Zt+h0L9aT/hJOwpqSnZsTyJiu4MdxRszvR3yITVtvALv8DQn8k2b9r34kGGpVsG/oALrSLhfAhUANSU14WArtl0svwRvyrAp+sB7yEtZuIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3WHGD/OFuMmxUNcLLE4uWoiw0Kip69f0hihJjH2C5E=;
 b=aCGyWSE+duhwiFAcl2a/06benGxY+Q8kIVEacz8yCBY/pMmwVcCGu+OGM8EBmHFD7XYlD16652C7qO22FalH2xR1EUY0RYxv1gLvJcpBYdo0gf++QhxtA939X674rsvvgRx9NFhXBVvOWm7Nm92VNMI8Fb7CLZZ/vaTBx0b1Lug=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYBPR01MB5422.jpnprd01.prod.outlook.com (2603:1096:404:802a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 07:22:50 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791%6]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 07:22:50 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>, Martin Doucha <mdoucha@suse.cz>
Thread-Topic: [COMMITTED] runtest/cve: Fix wrong cve tag
Thread-Index: AQHXos0fYf2S0r2YoU6sA5hjOGZpU6uZvxoA
Date: Wed, 8 Sep 2021 07:22:50 +0000
Message-ID: <613864D4.5030400@fujitsu.com>
References: <1630897958-2160-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1630897958-2160-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1019c46-c3d9-4482-4974-08d97299771a
x-ms-traffictypediagnostic: TYBPR01MB5422:
x-microsoft-antispam-prvs: <TYBPR01MB54226B8DDD8012722EA497D4FDD49@TYBPR01MB5422.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nd/uFUsEqTbQlHDCoiJvLUrAsIy7ioioPUcuQrOfG4Iu3FlDugtpHmpg8DTbfL4otK3HsiSMCMNzv7CR5xGArqgDbXPT5yYR8HEAtVf9nPYib/ibQ1M6uxTGIokvqqg3B1PRmXfckY7paN/LmkZDHY65x/HaUTMoBP1gbMds1GG0bRVMQgQj/M4mrSKzdk+I+UBo59OjzqLnjSGannHkowYkv/eq6JkQzsA0udV26IjawEfd5NC9Zu2YrjClPsDWYsJzRjTVHbfC6ci3YLY1cKnskWu9aBOXN6cR6fkHQACloUJrZYxYpNqFAGDXRZJk1t1dEeZ6fWm80geHWcLqyjvWA6VorXvCMYe+acGC2+ApEl1rOUSyI42E3vbZBC1lxbsI4L/RkLsfFiYZQIt09pOnArMUJ12yxaNVzSWKqyWoy9NhhV0Cpm9ZKLL9DLotYpsLRjaBwY0ct+A6TLPky1mN2a7hZL7Yqy5mHDl8Lx9GFVoBfjKsEGpUaJedAoG9hKJ7stK7vEzMgnfAWTLvXvuAp5X9G7u4+Fanb39wVzsLiPSI0nfqSSIUs7OcgZLOzr2Q6Fwfgu0pWDtlHn4Pixk2/BPUvNkzMQ0TdkGrtvnd1Bl4pbdbf9R8Ld8AF+mX416IpcjbgmZZweyXWZB+7r/RNTwk/eB161rr3EdQnOaI0zpYaBy41vmK2PlMH5tFeOTRBNbU1Pq77rXYdfL/Y+mTqxG12B0q7cqf+tLmiWBfY5Kj874kUWf5CO2Knuv++jIUx0sKv/whzj0uN9Bpz01LoZoBJDCeVrqQvhg4c5w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(86362001)(33656002)(316002)(71200400001)(122000001)(5660300002)(6506007)(8676002)(66556008)(110136005)(64756008)(66476007)(36756003)(38100700002)(4326008)(85182001)(2906002)(83380400001)(4744005)(478600001)(2616005)(6486002)(8936002)(87266011)(6512007)(76116006)(66946007)(26005)(66446008)(966005)(38070700005)(186003)(91956017);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aU41OFFRZjQwTkFJL0VISHRRR0I2K090bTI0V3B6K0FzQVB1UTdsZE50Sm5s?=
 =?gb2312?B?YnVMSXRrM1NJcHJlTWZxWnlGUkx5a2pxajdKem9jR0FTVVZuUG9OQkliYXc2?=
 =?gb2312?B?UHBvRGxNUU4vQ0JmcG5MSllnSk9EVjJ4aXpiY3p0M1BDckFYTHBMaXBIeHl0?=
 =?gb2312?B?T0FTQkd0SUlTZXVJRWZVcC9saGZRVFJoUVFjeUR5OEZLai9nT0lpTy9Ici9l?=
 =?gb2312?B?ZEdrNHlPNVJqYkdkSWR1ZHVCUXYzdi9INUpXM1ZiMWNhY0NoeXdDWElEV05P?=
 =?gb2312?B?dHlUdGNucktUekRFdDJ2WGpYK0hQRStldjBuaFhoelgvTzUzOEJqVTVYOHRk?=
 =?gb2312?B?SGFxazU0QkJ0Y3JXdVY4clh0anFaQ21KYnBTRVRPVWU0N2RzQjIwd3cyKzFP?=
 =?gb2312?B?bGRHdUdUSkFQOUdHR1M1TFVBb1BhU3NXcUk1OWtnYWFKbkg4ODVsckRsR2Ra?=
 =?gb2312?B?MHliSWhjUjlUOXZndHNEdHVjNWIxbUFEUUZQNkN6SmFrRHNHWEgzNjVvSGww?=
 =?gb2312?B?aEFseDFOOGhpN1FOcWx3MEJpUUtaSFhoL3lOZDhOcldiUkhBZ1JLQ2M2RHBV?=
 =?gb2312?B?S1lsMEc5WFY0NEZra096V1pZYjE1d2dkQU8zT3pVVnVreS81WExiWDFXSVRK?=
 =?gb2312?B?UFZMSzNPRi91K3h4QktZTkNFbmZ6MXJveVM4MnhzZDl1Qlo5ZWlkTlc5Mm5Q?=
 =?gb2312?B?c01PbHYycnRrQ1BHc3l1L2pFM1o1ZWFiUXlYV0tjMmMwVmxnTkxqYjE2ODN2?=
 =?gb2312?B?TkZ5dUdGV1ptU1p5Tlk3SzUvbDJpTFp5ME94a1pFKzNCOTd1cERCMzhJWVow?=
 =?gb2312?B?R21XTjl5YlV1a2ora3Vtc0hLTXp1VFNubEttN2w0U0NObmhVZUY2cDRrYUNt?=
 =?gb2312?B?cERXQ21FTXpBMnpTVkYwUGQxZGxTaXkvblkyb1NWNDJ4clZTRUZPbktFeTY2?=
 =?gb2312?B?bEl3SlBvdWZETzFpRHhENEx6NGE1dnBRMnRpLzBJSFY5SkVtZ2lBeVF3ODh0?=
 =?gb2312?B?MWhNWlFQNUFQNzZnTStYaWJtNkNya3BoT3g5Y2hqLy9XWlAwOXBzU0FKejdC?=
 =?gb2312?B?eEpZQmlXRFRSWXF0eERveTU2VFZnOFhSQXIva3NMdERPRGczUXFSaG5SbTJm?=
 =?gb2312?B?emxvTy9HSEVQNS9LTTZmbXRqSUxwZ0phREZacXo1RzVXZlBWa1Y0VzFkSUgz?=
 =?gb2312?B?Nk1aY1BHWmxZTGtEclFSMTRSMFlqb3JBdFZYQ2hQUFh6L3o5OUx3SWNlU2NU?=
 =?gb2312?B?TXVESTFOUE1ldk9ZUDVlaFcrOHl1NFhKVkJ2SnZmdjBzOUI3RFlFMDBYSnkv?=
 =?gb2312?B?ZlJSVGk0cWhJN0p2eXBMYkt2WGlQekVaYmwzc3I0NVUrL3ZVaExQYjJlT2xP?=
 =?gb2312?B?UVpON25vRmtmMXR2b01SRm9pTWlQNitUUHRwcjdVY0MzZGpxVjFCaHFpREx3?=
 =?gb2312?B?SVhMN0R1RklKRFpjN1VtUFBWb0VmWXpjd3lGemNXYUhMTTRkclY1VE51RHNi?=
 =?gb2312?B?SmQ3QzlEQ1V1WmJWV1NzSThNMzg4dUZsVTA2aVBRSGpQRGtvbWhHNjcrU0xn?=
 =?gb2312?B?d1pWcW54Uzl0ZHJLamFEaFBJcG5lT3lWOVlHM0FEZlBWNVhMNXpkcGdpQmFN?=
 =?gb2312?B?R3REZ2xXd2NEUTRyNUZ1ZUdVVHM5aGh5aURDQ25wd3FGSDVSck52VmRtTjhW?=
 =?gb2312?B?VUpKbU9CK1FDMTBBL3hidzVvYnNneGoxbFoyVENMUEdOWEVqVzdsZWJaWUtM?=
 =?gb2312?B?SXRKWWM2cHRQNkxxZzBYTXBEOU13ZFlTUXh5NjdHVVNMakJLYjlOaFdyZVVm?=
 =?gb2312?B?M1Npa1ZKMEVYQ2hpOXNCQT09?=
x-ms-exchange-transport-forked: True
Content-ID: <CCB65F0FA411A844B6CAF33211F0157D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1019c46-c3d9-4482-4974-08d97299771a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 07:22:50.2324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2JBxf+PUtPw78bQfoHsDjJDbxJUczLf/uIsF8W8P+33ECfeGhV9FCLCqfOKHMUMIfbqJtDAT8wQ3w88n2i+gSr7J7T7B2At4FDhHyyNPXr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5422
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED] runtest/cve: Fix wrong cve tag
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
Message-ID: <20210908072250.KtLy-PY-EmHNR1xE-kCdkR72yjLSeg8NbGZ8d8h9GTM@z>

Hi Cyril, Martin

In fact, Look the following url:
https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3609

It said nothing and seems this cve number doesn't exist.

Do you know what happen?

Best Regards
Yang Xu

> can_bcm01 is designed to test cve-2021-3609 instead of cve-2021-6309.
> 
> Fixes: 027ea6171c40 ("Add test for CVE 2021-3609")
> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> ---
>   runtest/cve | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/runtest/cve b/runtest/cve
> index 357b88feb..01211b5aa 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -67,7 +67,7 @@ cve-2020-14416 pty03
>   cve-2020-25705 icmp_rate_limit01
>   cve-2020-29373 io_uring02
>   cve-2021-3444 bpf_prog05
> -cve-2021-6309 can_bcm01
> +cve-2021-3609 can_bcm01
>   cve-2021-22555 setsockopt08 -i 100
>   cve-2021-26708 vsock01
>   # Tests below may cause kernel memory leak

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
