Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F58C433FE
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 09:35:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E3B33C903E
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 10:35:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0172A3C8E31
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 10:35:02 +0100 (CET)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E4763600A3A
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 10:35:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639733703; x=1671269703;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zV420RdU2S5CYXJHMuYEqyybxwxRzY2OXRIPbx3Zu9A=;
 b=mMLguaEsbrh6G7xg+2iRNlQOzwsU7HvOCRL3V1GWjBXJrFouf6pFWXfP
 KMaVx91BIyQ/fsOEM4KR3+au1Z/ng9uUbX5knIlaCjGmc+n/nn/XNvxAK
 SHDKGgsHJcy1cRIEveC2MdnVUQbwC23H5wzd0mnssAqMU5yQjz4S+uDKj
 ex6Xmyhw3y4PGM25tZDvp3LsZ6oHb3HlvYNltcSvJzeciCl2JUO6h1ytX
 L3aybddge6F9ygEwBy69Zqo8OniGjAonjKxtPDalcjvR0jqBjnzU4EZYb
 3prEH2K9qsgNQ5mvI1mNlJnlE8p+1/3FjUmDpQwuJEfoxPseHIXsGtMO1 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="46268301"
X-IronPort-AV: E=Sophos;i="5.88,213,1635174000"; d="scan'208";a="46268301"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2021 18:35:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCza6FReLiPawGkcsl5VlLIHdyZxTiqvQpzSTQFU+7Vp38VFDDtRllJb2LqLnNH0R4uVGT5HxucZ82Z6CBvuJJaSSr36H9OjLbu/Gb1bPvjqfGcfuhzbmBvlJ4Vcq5NLw9e0W72/IW4dFttEQzo3xpgNumwpwTZBTZOt8FYQRbJBgNy/dVFuICs8zrEcTq14860Dw5TmoRxo8zQw6yizBFl/Q6Z92oP1crSnkenx+6jjGYSKNlxhnVTYniDMblDqTWuocf5QUseFImkA3+lfY7BrfQ1m8M/LZE8QAi9C0TuGIaDeEelYclp9ujnRUhZNOGKRd2cJ75syYt6V7Gkfpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zV420RdU2S5CYXJHMuYEqyybxwxRzY2OXRIPbx3Zu9A=;
 b=e8rtwo7b8futATw892seEoPTP9ZpwpLgRM+WTm+jsAbT5NeWc0JMrui+x+Dqnp0MIQvoYxSpmHqrh8+GtYnXONx3Hsrj2RyZ2aNGlf3qknyj5McE8iFnskcW7AjTiO2amGsl29jVfsXOPVN1LLQyZrliEuE46yJ4jW/haRFvFt6pPbuKHMnkXAqOdu0dBaQf5LniF/NKc2EoRsj7m3jJ3vKRABko048ZNLYJDRlEKmYeg593+2OOyLn1U5pVFwPVP0LFh/uwrnyMqG3mpifO63Gs5rObnoBnJDidbeqOI3Rjs4LtGIP9JfYrgygwswghO3QK9FOdvYjoOwtfMxpw+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zV420RdU2S5CYXJHMuYEqyybxwxRzY2OXRIPbx3Zu9A=;
 b=QXcR77FQ7x0Ww0/ufeEBNxayfOtWfRObFIeCHonNPs+N3e2EJ1TLuXeCbPCuXeWAwdy2UFIWE9XQ8E9QIdCHLvomutOT3JRl2+UEs8TfS55FLhtLoTE6ulrjaTmq6rZBsrh02BvBSzxpxM2xkjhACF3rZqwn+SfuSNkF8VnLDUI=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB6283.jpnprd01.prod.outlook.com (2603:1096:400:84::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 09:34:57 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4778.019; Fri, 17 Dec 2021
 09:34:57 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v4 2/4] zram/zram_lib.sh: adapt the situation that
 zram device is being used
Thread-Index: AQHX8YRIrJGy4A3OoES5sELst+XBBqw2UdQAgAAd3YA=
Date: Fri, 17 Dec 2021 09:34:57 +0000
Message-ID: <61BC59C5.9090708@fujitsu.com>
References: <1639552849-2251-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639552849-2251-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbxAuBpxXtPXIwYO@pevik>
In-Reply-To: <YbxAuBpxXtPXIwYO@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57a4db33-bb68-4001-555b-08d9c1407d3d
x-ms-traffictypediagnostic: TYAPR01MB6283:EE_
x-microsoft-antispam-prvs: <TYAPR01MB62831E6A82E867F95F669580FD789@TYAPR01MB6283.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IZAmpY98FvqOfKlRd9zDm8yFkfna7K6UybV3DvxMk94M4kzNcF8PkPiVApUu/ViHrFGyydm+R2POEAC41oBpcjNgBtZh3fT2/d3GGXTmrZ4Sa05N+delwiqkWhtyZtRx9tmX7rPeo+roXlTJGwQPYNVSVgqH3FifklTuw/8DqkcHUUA7FkUOwwT2e6YXMaRnlkH/YH4nVF9R8UnbXafC7vR1tnHM6CZ2uvVrEs0iSxxHLAC4gU+VFXjhRhf7Gbfki9YtNdQHP16gVOB+R+iGQv1tsdjXcRMQMXDvQxcOxa+Hxb1bKHUerdovc/1/iyl6Ro1ivtZODAANkUc75E6rWYDSi11GbINWTJflyk6LevQYQj30qTP9m8N+yifWWCjBtbquwzpYc81uuSAv7PfymTdE/S+L2Pn8lDv90NY3HKGUE9ZS1CdpGXIlXd/m23SD+g1VWvRCCsHfyiRKuzK+80OYu2SI7sh/yMAR4qWd0X3ROfggEbvYoe5DVX04YOIAdVNn1asVKtdZqNaouMb78axRNNhZqHsIm46f6Q+lAaaWSir3bgJrZ7S9yTbpELAh358JBkbhf91a2EQJb/DTjbQNW/RVYkDfLYHC6zOcbXKObQCMNh8Imqd0A0JKMQ8jKIUzMEAEjOzOcDU7UYwGd9cgJM52r4xXlRmJmMjfr2VK4VoCj/aMJFrGNKTMw6YB0FLenwPcutL/xjrOZHSj2zIzXH02j43ePheHUAdJxqI+ZFpboQLNi0v8DgEUMihkTYuO+JAtNJUqc5ZXashOOORpvGBSKxmXh4+ZtzR3T9c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(2616005)(87266011)(5660300002)(8676002)(26005)(6512007)(33656002)(508600001)(2906002)(6486002)(82960400001)(6506007)(71200400001)(4326008)(316002)(91956017)(76116006)(122000001)(38070700005)(86362001)(38100700002)(8936002)(186003)(966005)(66476007)(66556008)(66446008)(36756003)(64756008)(85182001)(66946007)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UWZZUCtkU3ZzTllWeHRFV2hzYUFuaXoyZGl3OWZtb29rYS91RnUyYU90NWd4?=
 =?gb2312?B?ckdDMWJLWU9IUXFJMDdOYnh1RmZIVXZhazllRGJHVGdGZEt6NTUrQ3dzM0dw?=
 =?gb2312?B?bWs0K0JYa1htMHlXUXhPWC9rQ2luL1g2c2swNjRhOVZQeXUyOXI5K2hGYnFH?=
 =?gb2312?B?OTU1UlZPa01YNEd3VVJxUkZQSnN4czBlTTRyc3pMc3p2VXozdEV1SzJhQ0s1?=
 =?gb2312?B?dUFWSWMrK1RyZ2JoSGpoZ3V4T01TSitsaFR4c0o0c3hhT1hneTRtREVYRDZ6?=
 =?gb2312?B?bGNYeVJmVGtzTjBTeWgyd1FONzAxM2hhWnB3V1B0b1h2RXBNREtyZnhkaVVS?=
 =?gb2312?B?bzFSSjJUR1QzdkpMK1pTOUVJYjVUMmp4ekJXNmJJczNtb0g4SHlUT2w2QjZO?=
 =?gb2312?B?bDNscUFHQTl4bVVkLzI1WGlNSHdwQ3lmeFFmY0N5bUt6N2JtcWdLa3VocENx?=
 =?gb2312?B?S1NGMGI2RTFUMGM2M3daenRNSCtYNWNsc2JGTW1QcnVKalNsQVY1dVVwUGFm?=
 =?gb2312?B?VW9QMjNGMTF5MFlGL0JYT1RtRFFhZzFLNHlFVlRmUDFaVjFzWEZsdEswM0kv?=
 =?gb2312?B?L1ZxNFZkVlY4TDdwNHkwS0k1eGZLbnBDSHJVTGV0T3cwTWczTk9JWGdKRitm?=
 =?gb2312?B?THRvQmRjUk42Z2ZiaDNrNEI3eXFxd3B5QXUzaHpBYlpVcU1xNHZpZjFYeUFy?=
 =?gb2312?B?S0w2NWhpclo3SzY2US9lUFhHUzcwYTl6U3Ntc3Mxeks4MmdjcmxWaktCbFpp?=
 =?gb2312?B?MmM4NDhsN1gyOVJib0ZzR2V3T0o1Y3FWVXhENjNqVHRFdUg2NjlLWEdzdzZE?=
 =?gb2312?B?aTJNVnFDaWhPZ1dISzJ0ZVZXN1pUcGdWaHRXcTBwcFIvWm1XR3RBcjBVZWRZ?=
 =?gb2312?B?QXRYT3hYUUtjYXBxdSt6ODlVZU80RlFVTE5PUzNJdG1uaVArK3FZa0tHQ0Z5?=
 =?gb2312?B?c0VSQ0M0VVd5M0ZIQTZmMmFpaFpyaFpZd284a1BYWDlkUXJYWG15Q3MxSlB0?=
 =?gb2312?B?VU92UTh1T0ZWTkY4c0dlYUdCZ1A1QWRJWUc4cEtBVXBSUWhMQ1RSTGx5QkhP?=
 =?gb2312?B?aW9xVHVNdEgwZ0FTRlBBdFc5R3pYdXROWUc3TkdWNE9uaklCWG5haGJRR25j?=
 =?gb2312?B?VllIZmpiMTErQmJzamJOaldYVkkydXEvUnREclZDQVpKVnkxUXZ2dE9hb20z?=
 =?gb2312?B?TStNa0NBYnBBdUVlWUFuMG01ZzRTMnVxODZaRTJVYzllckNKd0dwc3BWcnB5?=
 =?gb2312?B?dDcyRE5aRnNIWm4yYWpnRzl6Z2pENXZBWlgyK2lsMnBWbmYremdPYjZQdDNv?=
 =?gb2312?B?RDBpdU1VQTB0M1Y0WlFtSnhUczNxRFhBejRaM3BEM3pZRlhsZXFCK2tCS1ZF?=
 =?gb2312?B?VC9mbUZqSnV3UnBzR3NlWjdhWGRhR1k1bDJOL0JwRmM3SDRjNU1ETkRTREoy?=
 =?gb2312?B?NkRWb0NHS0dVY1ZDSk5nNkp5K2pyTHNGcjFnYnVlOTEyM3VCNTV6b056K2tK?=
 =?gb2312?B?UDFuUVRkUlpJMHgzREQ4blZPcGsyRTF6R1ZCMm9mcTgwRmtYclNoZ0pkLzc5?=
 =?gb2312?B?SGdGMHVaSlhaTlEwMWtGczZVMW1EOVRHQzJ2ZGxrT2NvSTBFejlGQXo0UXdY?=
 =?gb2312?B?TXplSmVDNFdqVUVndWVkTHlTL0hPSVc3ZUdtcTRVcTRMVGdEOUlTYmY2Q2ps?=
 =?gb2312?B?dVAwZCtRK3ZWZDI4MTdFVzlrd1pnR3lQRGZZRnFnWllHMEg3QVk3c1ZsRUJE?=
 =?gb2312?B?TEdEb0w5NW1sU1A0cnpHeDFtbWc3T1hIT3U1M094cVZWODE4NXFSTDVtelZO?=
 =?gb2312?B?citWTWh5c1dwUXFnbHIzcGZyZ3pUeFY2cnZwKzZoeU5jYjNNWDRmMzZqV24w?=
 =?gb2312?B?ZEExQjRjVk40dVV3WnBjUUs5VVhVOCtmUUpmdThxa004ak9LK1ZQTHBRRUNj?=
 =?gb2312?B?ZU91V0RYQmxhNUMwaVdIK0p6eFhITHZuTXpJa1liRUo5K05Wcjl6NzBqeDJa?=
 =?gb2312?B?MW5Xb050ZzZJVzQwNjNDbGp4WFJNSHhjRHYvUVdTZHRsbUI5NkRtZElBWnp1?=
 =?gb2312?B?eS9SL016NkZhL0ZLOFBRNzhYOVJZL2V4cHNFeDczOC96M25lMHRweFRUcmpE?=
 =?gb2312?B?SlRrdEtOQU82V1Y3ODRXZEl4VEZTVVQ0cDdsU3BoWlQzMkc2Y0J4ZnRQOFMr?=
 =?gb2312?B?UE1JL1lVb0lzbEFEU2J2Nll3NFYvNFJwS2MrSkV6azVRNVBQaUlxMTVsRXNY?=
 =?gb2312?Q?AehH/IlIWUnlkOxwtnkx9fRLBS9D0QxrmzG5MsZclI=3D?=
Content-ID: <7A06917F7A4EDF4389EB081FB1303C84@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a4db33-bb68-4001-555b-08d9c1407d3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 09:34:57.2078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0HG7hTPcGnSFLbTWu6VIa8c2l/6NqvnaUrxQ9954TxrtCgbiHqyaT8BcAqTRxEl/GtSrd04FPdHLUHOQiXEh9ks88hzC3bdXbS4zVmOeAPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6283
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/4] zram/zram_lib.sh: adapt the situation that
 zram device is being used
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
>> If zram-generator package is installed and works, then we can not remove zram module
>> because zram swap is being used. This case needs a clean zram environment, change this
>> test by using hot_add/hot_remove interface[1]. So even zram device is being used, we
>> still can add zram device and remove them in cleanup.
>
> BTW this was added in v4.2-rc1 (6 years ago, 6566d1a32bf7 ("zram: add dynamic
> device add/remove functionality")). Hopefully anybody still supporting older
> kernels is using old LTP for it.
Oh, I don't realize it before. I tested it on centos7 then I think this 
control interface maybe introduced long time ago.

To be honst, I don't want to make this case more complex. How about 
adding  /sys/class/zram-control check after load zram module. If not, 
just report  case needs to use hot_add/hot_remove interface .

Old kernel can use old ltp since it is 4.2 not like 4.4 4.19(they are 
long stable branch, we should consider them).

>
>> Also, zram01,02 case are adjuested to adapt the situation that CONFIG_ZRAM=y.
> Very nice, thanks!
>
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>
>> 1]https://www.kernel.org/doc/html/latest/admin-guide/blockdev/zram.html#add-remove-zram-devices
> nit: [1] https://www.kernel.org/doc/html/latest/admin-guide/blockdev/zram.html#add-remove-zram-devices
>
> ...
>> -	modprobe zram num_devices=$dev_num || \
>> -		tst_brk TBROK "failed to insert zram module"
>> +	if [ ! -d "/sys/class/zram-control" ]; then
>> +		modprobe zram num_devices=$dev_num
>> +		module_load=1
>> +		dev_start=0
>> +		dev_end=$(($dev_num - 1))
>> +		tst_res TPASS "all zram devices(/dev/zram0~$dev_end) successfully created"
> nit: please all zram devices (/dev/zram0~$dev_end) ... (add space after devices)
OK
>> +		return
>> +	fi
>
>> -	dev_num_created=$(ls /dev/zram* | wc -w)
>> +	dev_start=$(ls /dev/zram* | wc -w)
>> +	dev_end=$(($dev_start + $dev_num - 1))
>
>> -	if [ "$dev_num_created" -ne "$dev_num" ]; then
>> -		tst_brk TFAIL "unexpected num of devices: $dev_num_created"
>> -	fi
>> +	for i in $(seq  $dev_start $dev_end); do
>> +		cat /sys/class/zram-control/hot_add>  /dev/null
>> +	done
>
>> -	tst_res TPASS "all zram devices successfully created"
>> +	tst_res TPASS "all zram devices(/dev/zram$dev_start~$dev_end) successfully created"
> and here.
OK

Best Regards
Yang Xu
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
