Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BC9C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 08:05:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C43B03C88B9
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 09:05:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BBE13C1841
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 09:05:15 +0100 (CET)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B80701400540
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 09:05:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639382714; x=1670918714;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=3jaZhlBPly6/c8TbE5XdgWcdOgFvGJcV0AlLoCRqawY=;
 b=qMiPlwH6BC+HCBtvEsgF/HRwY/4OknwTeQY0Mvty7S1fJv3a7eezNKq2
 aicxsM/xwI7oXvX3epGFdD44LDihEC7yeI2SAgnifeBVBn0ptfLPi4qfX
 6Y1n+5mdHHXxvahMs1vSZiOVYIux6To/eW/y/c/q0+QIoN+tLH/aLWOub
 w4oYcYlmlZNuzMLI6F1RcjWbJAwUbQaXVyMqTq0QToMbmPfpH4p5C7kul
 np+QiaYUkmgDkh062nPNsoYum9wIX4/w+NengxQLpyo8jYtG1ocZDl8+U
 D7gsgf7nCZszmYl7Ig8zGM/KX+AradL0grRveX7/POvDyf0eTPy5k0Tjm w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="53810664"
X-IronPort-AV: E=Sophos;i="5.88,202,1635174000"; d="scan'208";a="53810664"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2021 17:05:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeXF6b65fWiwYuAQGrQY/0zWKeooBBknSnIJKeDekRSKmz+TX9cmg0SEVdZZ23oxjqedNj/6ecAHKJMROvxpXx5upoX6y5djQr544NvsBD4iBMieFsaD5margaU0GVGKVpKsVTuVJxpVmtAzPrFsoXXnBB67hQdfb/rYrlXs+IzXZzDYKS7RgAj0hyyLnEdtpSjZtPWnOWfFhl5f+2cYBFZ90tdf4AjmBNviJV5hb+6sOrUPDEyUsEHsQ0DLKh0iUi9L0t+NRtIDHvHErDnaA0gv+TRkzyw4Hqz8bmZa+hAYqjee6XfeW71hMacajv9zB7Hej0hMIXUlVaNYU/d1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jaZhlBPly6/c8TbE5XdgWcdOgFvGJcV0AlLoCRqawY=;
 b=NlUBPjmOXTLSKeyvjTgmOYxpJDYWaftRdyEOBtFHQ6PoSOKKTTh95koEU0osxwqCIgvnu2ESW8N92WkNJinv6iAv5vAY/nGJh42Euply84ejrC71rcrQ3rpCO+qPZ6bGi8wGUDEu6GejeiYajw3HjCd432W/z2jJEpcRqGnDUp/aXroBxdmPh0V3Xwma5q5QVMAbJyDADwgp8gEoXOCe+ocXg0iOPVrde3p6Qitaw/w4i99Qenqal7RVHpjIID/wGTBS36Z8hFJzc4AcVy7VVUnUjAxrZ8T12VgP3kNuXOc2GPFiK8WdCW6mHKceoJggyNZIuTmCxOC4g+spwvni0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jaZhlBPly6/c8TbE5XdgWcdOgFvGJcV0AlLoCRqawY=;
 b=ad3zKpCKLZdJIaa4eZQBrLYrOncp1RPwJw2ZDvNl686Kvu9maGuR3PkxavN5fy/aLoCWa3i7O77mAP/1CEGwai1przqCb/1ypZOrANsKDLWZf0IlLa/HuQS0f42yO+IbnSuK8kkHtFOmBgMQRc08Si0JDdJXPmzC769lVmSR6z0=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB2446.jpnprd01.prod.outlook.com (2603:1096:404:8b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 08:05:09 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 08:05:09 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 2/3] zram/zram_lib.sh: Skip test if zram module can
 not be removed
Thread-Index: AQHX7NB/n7TKiBds6Em2B+wWj+FTuKwqRi4AgABivQCAAMU3gIAAAeGAgAAH/wCABJengIAABzYA
Date: Mon, 13 Dec 2021 08:05:09 +0000
Message-ID: <61B6FEE2.3010402@fujitsu.com>
References: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639035823-5786-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbIeFLfVb36DaVq8@yuki> <YbJw6IfUFhVDgQLS@pevik>
 <61B31657.9020008@fujitsu.com> <YbMX66Oeu1byuMiR@pevik>
 <61B31EA0.9020104@fujitsu.com> <Ybb41TwZ1vSiCAzO@pevik>
In-Reply-To: <Ybb41TwZ1vSiCAzO@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcfb605a-1bec-49aa-69cd-08d9be0f485f
x-ms-traffictypediagnostic: TYAPR01MB2446:EE_
x-microsoft-antispam-prvs: <TYAPR01MB244691879ED826D2F2DC689DFD749@TYAPR01MB2446.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KQ+lQrhkM/xWr3AA58DLehmn07LfpPMn9sifTV5Lk6MantoI5oG2hTIbTjLrt1B1/rztX7T/L7BSdeMmqaDtICaJyB3odid+06+up+YXsAHl2ipxKhKoM71NH6/mpFBZckRoWkE3hQzUtVXGL0l1rE+siRBV0Bp8hKcFFU0rfq/ibxd+KLOCctPVJhEeeohmPh7FfqwKHmiaJk68npHIqW1XPv4PJNXrB+LfN3QDOfQDdNew7DjqBGoRCTsytF/vH1qbKkOXP5m6j6HJuZYSKXwnuMJVQ9gPzGvtSKhmVlFjfSXwBNsw9KBbwFqajiVwb5Z5xQ0omoE0EdUXA8kzc1Kv/D/rzdb9uFkQxl+UkAGHaU99nXgdmJYnekzCTsqALp3CgK9r5E6VyYg4G3c92VRb50A3HaDyLbOCvOPE4O5M6ppsVZ56OdB/xVl486FpyqNEKebJHqRH2vJlnB1yEaw4MYdrlKAe6/KgBidtiMadoR+JGpxzq6+YfSU3V4Lsc+uJ36qOGuNDxjvO6cyBPZXBWAyAGowOgNMM837r12LhsqYF/rbfLw41Ikc9c9ivzM+uJGXmv3nZiHWRM64jto2OgbxHhof505uDshWy3rA+AUaAhpyYWqhRWbO9NbPF8C2suxUP4VBQ7D9xNHl3/Av/WHHPPpGjifMAP2wCd20jGKtznzai10QfHGE0yrrcXKdy8U9pfmgdxFDZ6YtSKQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(122000001)(36756003)(5660300002)(316002)(4326008)(71200400001)(8936002)(87266011)(38070700005)(6506007)(6486002)(86362001)(82960400001)(66446008)(91956017)(76116006)(64756008)(66946007)(6512007)(8676002)(33656002)(186003)(66476007)(85182001)(66556008)(54906003)(508600001)(84970400001)(26005)(2616005)(2906002)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WGNybzAwOXBuNlk3cklBWmp5MHA2WTJ3cDluTndWb0ZYL0dKaFJ0WUxpTHgy?=
 =?gb2312?B?RWhKbjdqcXoxQkpwaGkwanZEQWp0STB2c0JMd3hXbXpoL0JJRVdYNTN0L2tR?=
 =?gb2312?B?SXFxdXllczd6djUrWkdML1ZHdWdvUWxlZGNMeDZQN0F1WEZKZXd0OEUvY2Ez?=
 =?gb2312?B?a3FPYlpqaHpidHVZdGFwY1JzaENuTHZCZVFNLytMbVQ1SUZpdlZxMlVsdlR3?=
 =?gb2312?B?UGJCN24xN1ZveTdPMmtmam0rVW11VFljT3NLYlZnTDlvbEhIOUd6QVlHWXVP?=
 =?gb2312?B?VThjbkhYYUVPTXN6cmQ5UWprZDJyalRaUUlWTGF5OS8yVEdzQWdMUkpNdEhO?=
 =?gb2312?B?cldPRWY0K2d5NDQ4NjdUaHJmOTNtRVhNMDIvWHhMV0xZSlpJU3lTSkpKYVBZ?=
 =?gb2312?B?TE5sdDB0L0JCbXI2Y3JTODViazV2SDVHa1FUSlZMZzZLQmgzejhhZnZSVDNz?=
 =?gb2312?B?MWo5MUdsait5S0xaMHpYMDI5ckNuWG82QW1sNFhweUk5anpveWdNR1ZtMHRi?=
 =?gb2312?B?TDI3d0g0ZHlIdnFLSU11ZmxBM1BrT0NwbnVMR3EwSHYyYVNDaTh6Tnl6K2p5?=
 =?gb2312?B?QmhCcnlaSnNKRnR2NGlFRFRCalZ1S3JhTFVXVGhJMmt1dzE4ak1jMlBiSFVG?=
 =?gb2312?B?dFgvcFZwM3BRVFkrdnprcEVJc3lOL3JCS2RpZE1BbUVjYm0zcHNXYTE2aGw5?=
 =?gb2312?B?QVIxU1hBTFlyc0dITTNUOGVLY1ZUdUt2VTFaKzVNbmdDZGJBU0Q0QTVGdHdu?=
 =?gb2312?B?UFRuMlNLeTlJUDNrYnI4ZXlYaS9hci9XZUc2NlhZNmIvS0lHWTJ4RzI5R29u?=
 =?gb2312?B?UWFSUVEraW9OZ3hkT0lHNFQ4dVMwNldKNjZPYVlVZDRUWDBlb1oxMk41UWZD?=
 =?gb2312?B?SEZOQklOeTVIVXdmMEhUYjJiTU1JL2lCOEd3cVpkWktTQTRBWUhjZUNCSjZY?=
 =?gb2312?B?bW1kc0xwQnBRdW9POTQrcnY3bURvejZNQWVhdmlRbG9HM3BETTJZRU9UNHBj?=
 =?gb2312?B?OWFBVnhqTHd1azBNNWFySzlyNStVWkNqSDl2LzVwek1OZUJaWWFYSHhPZSts?=
 =?gb2312?B?aDJyb0N5dVBHMm5HZitJaEl5N0pRSjlkMVNKVzJpaTBwNWk2QUJsd3VpR2N1?=
 =?gb2312?B?VXhxM1JMTUFaSFJYbWhCQXJ1b3Qvc0lzT241QVoyV0hWVUtaR1g4ZGJHWmE5?=
 =?gb2312?B?b1A3dis4V0hxd0FRcit5N3FoSzA4eDN6UmVtQlBuKzBFRkUzNDNtYTBUMk8y?=
 =?gb2312?B?aDFnWnR3WnJDYVh3OEJZd3VQYzlUaWZaQlM4bW1vRWcvdXRvZXhXU1luUEIz?=
 =?gb2312?B?U1ZBcWFVZ0FjcU91dU5IQXcyTVJpWXFtOEJzY2ZNZy9FKzl0SDlYSjRGVDlL?=
 =?gb2312?B?UzY2NVhHa1krSFp2T05ZRDJpM08rRWVLMEVVVTJUS042MnVrQnQvSHhIWlky?=
 =?gb2312?B?RDVZRzlOcEh5eUxpbzZIWHZ6YXlzWlVrUmdJVjhQRUhScVZTV1M5YzVFODJx?=
 =?gb2312?B?V2xwV0N6Wk5zMjdzVnBXc2h0OVNidEhabEJtK2p3MnJac0dJYVZ1SlQxNkd5?=
 =?gb2312?B?ak5lMmpNMSs4MjNNcjhmcU9hSVRyMCt0OXlZbThCdHNuMG52OEdyL0Q5UzZt?=
 =?gb2312?B?T3Ztc01LdWtBTEZESG12QmRHMSs4NnFxSVR3bG5NVGEzbHV3RGd6VnUzOUZG?=
 =?gb2312?B?M09PdFJ6aitaUGgzOU5GM1c4R0V0RWx6ckpIeit3Vk1tUVhqQnhKMldrRXBv?=
 =?gb2312?B?VVdMZWhwYmFEaXFkU1g0MXBhSjdoaENVKy9yd29OazdheStaUG5KekNGV2JS?=
 =?gb2312?B?TS9FRzVPVWVXTEtkTzFTT0owMC9wOWpkejRCK2hTMGl1U2RCeVo5OSs1dFdD?=
 =?gb2312?B?UzRmaWpLQjFUYVFBOEZjYmJ2OEdIcE9YblNsR3djcTlYTHUrQ0hqZmRFNzN0?=
 =?gb2312?B?OGw5YUI2a0YweTNzQ3ZzR1VhNTcvY0oveHc2ajgvcTdFbTBkeFBkT3NRSXJn?=
 =?gb2312?B?cjh0U1FOSTQ1N2tHd3ZxK3FlRng0TDlFVTA1OHc0RkR0Um9aL3czVzc5N3R2?=
 =?gb2312?B?M2NpSVZ4eG11eWdEakZCVDZvbXRBZlBXaVNEMllRbklqdVFnMFYza0ZjeTRQ?=
 =?gb2312?B?d2Z1NW9Kc0NaTVZ3b2lJNzBya3RKdG5SaUx5NlBJTjVxQXZIMWNzazViblJw?=
 =?gb2312?B?NGRGcXZnb0ZjY0M5TVB6cXREUzdwc1FIaDlGZTRoN2o3eDJTMk8vTjdja24w?=
 =?gb2312?Q?PmSWhCgNDL2sOSVHkcE0MoaFJrceb9Hf1wilYikliY=3D?=
Content-ID: <58D7E12EDB4AD8439FA539751B1C89ED@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfb605a-1bec-49aa-69cd-08d9be0f485f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 08:05:09.6540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Seiek1P7gXMlZtAww03kyUyGY6WtX//ybcar615VoRDDymD6X+LaIJoD7sAguoY/6xEzWxwLUMXkQHGUPdPZdspNIoYzeiGi00MO0dCbZRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2446
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] zram/zram_lib.sh: Skip test if zram module
 can not be removed
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

Hi Petr
> Hi Xu,
>
> ...
>>>> ps: zram01 need to rmmod and modprobe zram. So if kernel built with
>>>> CONFIG_ZRAM=y, we also need to TCONF. But it is another story.
>>> +1
>
> We already have v3, but I got confused here in v1, thus asking.
>
>> Since zram_lib.sh uses tst_needs_driver to search module in
>> modules.dep/modules.builtin. Maybe we can introduce a new macro
>> TST_NEEDS_MODULES (like TST_NEEDS_DIRVERS)?
> I got lost here, did you suggest zram_lib.sh to switch to use $TST_NEEDS_MODULE?
Sorry, I don't know ltp shell api already have this TST_NEEDS_MODULE 
macro and so suggest to add a new macro wrongly.

Yes, I want to use TST_NEEDS_MODULE instead of TST_NEEDS_DIRVERS because 
the former is more accurate.

But it seems  our TST_NEEDS_MODULE only can check custom kernel module 
but can't check system kernel module(like ext4.ko.xz, xfs.ext4.ko.xz).

ps: kconfig shell api can also do the thing by using "config_zram=m". So 
I may use kconfig shell api in here in the feature.

Best Regards
Yang Xu
>
>> The difference between TST_NEEDS_MODULES and TST_NEEDS_DIRVERS is that
>> the former needs module, but the latter needs module or builtin.
> Yes, and TST_NEEDS_DRIVERS is already used in zram_lib.sh.
>
> Kind regards,
> Petr
>
>> But I am not sure whether have many shell case needs this(Like network.)
>> Of course, kconfig shell api also can do this.
>
>> Ok, I am back to this case and write my v2 patch.
>
>> Best Regards
>> Yang Xu
>>> Kind regards,
>>> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
