Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F222C433F5
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 08:56:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED2863C8095
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 09:56:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC6833C0B96
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 09:56:21 +0100 (CET)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C44291000F70
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 09:56:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639126581; x=1670662581;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=qgLqK3SgY0xFn+vAgdo1Wch/orNiRUApAh67fy5FIVs=;
 b=WQuK0qKKyx7z+1yO6nnCEGtI6F9Z21blZ+5FFB9C0Gw/Efxap4cCwmKS
 2p44dvEwszW7XDxaYAS5ujCXQeQbgt6W4t9sG5Lu2+Q/5jVKObcx78blM
 bN6NXHgvsAv198XmiJBfJA/CWvmoEg0MZ8fxafF/NQO+n0pnGjRdonWx9
 u2rJuE2wWHuHUDpH5Lx0WZtn76HCVFrUz1gMnqcFqz6oLQh2nzJSM2MjC
 2y+0ipB/elbNi1W/J+gJZkDZYvvewgc8Pjdrf3SkE32DQQqGxlV2C62if
 ZiwwoSx/4tPkD5Zlm8haK+tBzs5olAeVOBU8KkyzLTEHD0x9HI44VlHgN g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="45594820"
X-IronPort-AV: E=Sophos;i="5.88,195,1635174000"; d="scan'208";a="45594820"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2021 17:56:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahZXuebuf0Zb5TXC6IRmtb8SNK/fqik0d7+eRW5zf8qDSMYB9AAOaQZeud0coZ6Zi5tikpSM7yAWYWGTyU3kodxBgSCInCK/oA9vQdOmVhMIugz8NpFqrXjxTUECoPzKMqA+jwmZMMD/qtI4lVt5d8JVNwrs50dbUlnX3dYwyRZO7aEMaacphLr+BnDMmJ20FfJujdR0aFwFwdMc9vpbONfpgGTDmeb55OvtBWQ4eyiNJ56+rAsFk4MsWI2Y67YJ9PUo6cTZW85Vc5yg6Dk65nj3lfrtJy5iZlfYVk+vPVOl879zQftwldm8ee3zHpB6TP/kyWYnjrQtghGIhS74OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgLqK3SgY0xFn+vAgdo1Wch/orNiRUApAh67fy5FIVs=;
 b=McFiV0dpPQ/lG831jyyFPKLNENhtIBH9NVObIxDM4wwWsXxz0RyDtywmBdQfuTwpW1ql0szjsGv/DymJOuJGdA7nN/Xpv5eLfFsKfWrBIV+TaBPGo2jLGBcaMCddTOOLPfmCigxWbPjg3Z5nvKD3ebTNKThdOvbz/OcEmNZmJyz4zz6ORWmLCePv2m4zBXmQRuuxSEO3L2SkgQs9QeGN3K5VdOmT8UNVnlkFUxATkb8Ii5BwlG9g8YmD2KHtrG7bCNb0WVMFK4/UVLOiNDxOHUnbrvIkoFS2pu80MeyAX7haTg1kKToJOmL5h+7HFLDbQpExPPEazjwqG5mwHWsohA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgLqK3SgY0xFn+vAgdo1Wch/orNiRUApAh67fy5FIVs=;
 b=IUZ9koXw6WVsX+2JXZx5ZJ7RNJb/ZnRlHzQCcd479d7suHi+pTuKbD+M0I3/FetYeeJsxtX+NX0CLJpGvjgI/S4iapTC6XReRIHtRTjjkeqWPVyUWYGnZSCEIAYACNTrEBsTKNdsXO11T1mwmfLogW0hHEEXNwzkrQxORYiW9hg=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB3275.jpnprd01.prod.outlook.com (2603:1096:404:7c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Fri, 10 Dec
 2021 08:56:15 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4778.014; Fri, 10 Dec 2021
 08:56:15 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 2/3] zram/zram_lib.sh: Skip test if zram module can
 not be removed
Thread-Index: AQHX7NB/n7TKiBds6Em2B+wWj+FTuKwqRi4AgABivQCAAMU3gA==
Date: Fri, 10 Dec 2021 08:56:15 +0000
Message-ID: <61B31657.9020008@fujitsu.com>
References: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639035823-5786-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbIeFLfVb36DaVq8@yuki> <YbJw6IfUFhVDgQLS@pevik>
In-Reply-To: <YbJw6IfUFhVDgQLS@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5da8d519-729f-4e58-cd57-08d9bbbaec62
x-ms-traffictypediagnostic: TY2PR01MB3275:EE_
x-microsoft-antispam-prvs: <TY2PR01MB327559468F50DBB215D521D9FD719@TY2PR01MB3275.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v2zqeB52nl17t77+pCI5oaMXCZ3esIOrh5Tl/XyT7p+yLHRm7EXy83ytd/jhES8MJ+mhKO9BJ4tloPiy5PCs0KKuwdQPDunrS1EQ7DIgOFEFUavXY55VcLUGmUWHCA9Qvs2DUzmHMogbIpB417zo2dcBPyzbIHRyo1SxPkXEx2cLfo8k3e0beKtwsadTKTsIPHGhn3dMH0wgNLu6uwNWOgdwNKqSvuVA4ZvisK2YfsTHFZSyRh61bVYNt1W647AuNF4+XG3eu5EO5xLDcm1zdcJWH45rNjLzk1nyNnWE89J8J6nb3x7uQJn56ppbaAQsXJ0WcYHcYip9Czjdrk6RLFGwOVVwupKDHUMKF3Y02zukGdXLT9AqS4L6v5isZfZLgl3r5Bv25SViNj/pHX3nQK4LetUPwt+ivyL6lfupEkNOTJkFgqSgeN+6B7pGo5WaU6wYi6b6aiivDnRxtc5mFb/RrdU76y7ge7JEqglCoCjfHT4jqPG3yOiX6olRJfxP5fR+4tyVWeRkDKw6OcAu3yqBXR6fJb5SU9vK8t8z5cc8fsThameTLU2dG81qWC8R/7aaabTOmo4WxLygOSNCI//fsIP717V9OIDaFju/8uW+lbKXsm9u+kotE6C1QHISzYanT7mAuoWE9i5qH0D1N9ITLY8w7Ehjje3K+zYOGZ2b/4/2dYLdxrQPowNgMfQ+x5E6H9IkkfGX09krFW+epA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(4326008)(66556008)(66446008)(85182001)(5660300002)(6486002)(8936002)(86362001)(6512007)(91956017)(316002)(36756003)(508600001)(122000001)(66476007)(54906003)(76116006)(8676002)(71200400001)(66946007)(64756008)(2906002)(87266011)(38100700002)(2616005)(26005)(6506007)(82960400001)(38070700005)(83380400001)(6916009)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TGVNcTdjZEtCQW1xdmF5ZGJSUWJ1TzJYWjVwbS83OUcxQzh5RElYTGVleWpo?=
 =?gb2312?B?aW5zUzYvSWc1Mk1RYzBpOTFiSGlxbEl2ZXVjYTVxaDN1V0FLSDBqRmV4T25j?=
 =?gb2312?B?TytYdEh5THlqWHhObDRybXo1SlRKNjd5WUw2a1lGa2JMRlpsYzM3ZVF5SHlp?=
 =?gb2312?B?YWFuQ2Fham5BRHBHNlNKUzdrOHFaaHBTUHcwL2t2U28vdTgzeVlkaHcwSkpQ?=
 =?gb2312?B?UStaSEwxRUszU2YyYkdIMytYYklVcTAvaU50QmJ0dVV2LzV4NmZHbnNkZG9r?=
 =?gb2312?B?OTQ2WWpxdjhBV0JrZVRNVmEwTmN5Um03eTNLcVZydlR5MGtzZ1JOb2pqUzQw?=
 =?gb2312?B?VldEWkxRK1dOR001OFk1UmpIWmpEZVRpSi9Dd0Exd2R2ZFZHM3VIcStvWkNK?=
 =?gb2312?B?TTQwblZnUnE3QnBHYkc1QU1aVGRQV3Jhb0pkRkNHdStmcm5EVGR0T2lwblZl?=
 =?gb2312?B?cFp1b0NaVE5INktWdmdhOHRpMWJTd1NHb095Z084VXlVS2Y4akFGWm5jenlP?=
 =?gb2312?B?QWhjenVBdTQrd2RXRmwwaUNXTkdjeGNBWmtPNXNLREExVktzbktsSHQ0eUgw?=
 =?gb2312?B?YTVTVS9LY3pKN3ZaU2FvNzZnMTNXajg2bEJLNTBxUG5EMXRwbFpyMUlPWnVh?=
 =?gb2312?B?dmtYdnhmTE9DWS9oNDVJSmE5bDh5L3o4ZHpRU2FDOXlFMlU3MFBuYjFLNHFO?=
 =?gb2312?B?N3d3b1I2THRqak9mRGg2YndZVVl2TWNYYlVVVlJSMm9BK2M0NGtUN0hleU5N?=
 =?gb2312?B?VjdiVWZ1NjBVVElqTW55OHhodENFMkdnRjJxVFBWQ3JEK1d0a0pPeWE5b0tk?=
 =?gb2312?B?aWpmZWZnTUFuaGtNdnQzcWVLeHFMTTlVYm5CdGkvb3U2RktLK3c4aGpOL0xX?=
 =?gb2312?B?K2dlQ1JVdnpDd1hKUm5kLzlVNWxCaHduWm1mMTlxd1AvNTN0LytmQmlLaVF1?=
 =?gb2312?B?Vm9ka1FyNFp3WjFPbVpHVnlmdFMwcmlDTWVjb1dEaHZyclArK1FBTk9QZlZ5?=
 =?gb2312?B?M1VSb3c4cWd1WHpPRVhIY00zWWpiVVk4VVM5ZVpZVHp1bjA5alVvbXpwRldP?=
 =?gb2312?B?KytTaVh3V1FzekR0TFEySjVPNTNJS0p3UThzKzRhYW4vaE9QY1BkdkhIczM0?=
 =?gb2312?B?YXJnTXhWWjhLZmpWM2NKZHB3d3RrczA4UVQzQitpUFB2anZvS3VkRHloSWY5?=
 =?gb2312?B?R1J2eHRaUjZXdFF2Tit0d2xNR1owY3hhT2dnUkl1UmkraldvODRjbFQzZU5W?=
 =?gb2312?B?TU1KZzgrRWdFaFU5VHdYSEV3b25Qa1hGaXlOaFFOWi9aaTRMdTJHQnd5aTdG?=
 =?gb2312?B?NGh4WERjNm0xYkRXbFVKUHR5QVFSUWJwMkh6ZHA3cktIYkovTXMrWkFZUXlQ?=
 =?gb2312?B?TGpNbERoTEhxSFpKNlBaSVJxZks0Vm5Gb2ZQa3dpR0NYR2hwYlRzMklDVmxr?=
 =?gb2312?B?akMzZ3lWaGpWOTlHRlY4SDRJUlZIemR3Y3VNeWJIVzlnTERHWnB5RlM5V2Zw?=
 =?gb2312?B?aDRJT0RjcnhCcmwxMER4bWduNzhsZW96UVV4clhDY3d4VEl6QlpkTUpqTEFG?=
 =?gb2312?B?ZDE1WHNIdzBTbGw3Rkp6SkhnRW83ODdOT2lZZFh5M01EWnRkL1h2RjEzUFZo?=
 =?gb2312?B?b2Q4d052eFR0THVtL1Fha0Z0TDB0TTZ0aUJKWnpIbGxlelZMTnJCcHRCN0ZP?=
 =?gb2312?B?UmxwMk1EQlhWMlVvWkNFNXNlSytneXhKaVZwUHpnL05WaFRUMERmWWJkbWFx?=
 =?gb2312?B?MDViZUlnRmFjMXRGT0QwRTBpQ29xNXNzZzF3eW1pRDV0bGQ4UjRpWFFzK0I0?=
 =?gb2312?B?NFlMRGFsWXZCc3hhNDFkemdKVG1aRGFuL2xIVzBZZGlpaHJVR2F1YnNXczIr?=
 =?gb2312?B?OExCUWJiREx2eHJ1RUxOa21YL0lkb3A5MUdNaFBDdVdsVmxzSWQzOURPdnBp?=
 =?gb2312?B?bHJLSDl1N20wSVQvTS96Z0xZQkdrVGxOUVhQcnZsYzRYbndBZm5UUFo3ZmN0?=
 =?gb2312?B?Q1NMNjlMRzhGelRNV0plQ3BlR0RkUGRKWkdwYmE4SjFNYXdwQzE3YVlrT0ln?=
 =?gb2312?B?RWZlR2kwZ24rOWdqUHRuRVV1dGJaM04xUHZISXJhRFlHZkRLdDlKWjJlTlVR?=
 =?gb2312?B?SkgzazBaakgxWnFNSWljWkhJanVIRHZ4S1gzQ1dOYklGS3VITjh6VzRsZVlJ?=
 =?gb2312?B?bWNiYytnVlc3WkZscWRXNTdLZkVPMXNtQmh2eks4dHFBczdXeHZORVIyTG42?=
 =?gb2312?Q?GCuL12ky1SU/0vPnn6Q4abNo/Fmi0NZTxLKezufs48=3D?=
Content-ID: <1A6CBFE714A7324BBACA2665E5B81FAB@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da8d519-729f-4e58-cd57-08d9bbbaec62
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 08:56:15.3566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 29V8TeEumftN67fVBDwUeW2IY/g11xV+zgdnsRe+2coYOUCc3x/0bVt7DgM5y4aiWNarbBcUliA92EpQTKNryAwb+ahI4D4h+30bRfKIm9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3275
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
> Hi Xu, Cyril,
>
>> Hi!
>>>   	tst_set_timeout $((dev_num*450))
>
>>> +	rmmod zram>  /dev/null 2>&1 || tst_brk TCONF "zram module is being used"
> This is wrong:
>
> $ lsmod | grep zram
> # rmmod zram; echo $?
> rmmod: ERROR: Module zram is not currently loaded
> 1
>
> Why not detect with lsmod? i.e.:
>
> 	if lsmod | grep zram; then
> 		rmmod zram>  /dev/null 2>&1 || tst_brk TCONF "zram module is being used"
> 	fi
>
Yes
> Although I'm not sure if we should attempt to rmmod, maybe quit when lsmod
> detects zram would be better.
If zram module was loaded but not used, then we can rmmod and do 
modprobe(case needs a clean zram envrionment). IMO, it doesn't affect 
any things.
If zram module was loaded but used, then rmmod failed and case skips.

ps: zram01 need to rmmod and modprobe zram. So if kernel built with 
CONFIG_ZRAM=y, we also need to TCONF. But it is another story.
>
> Also it wouldn't harm to add at least rmmod into TST_NEEDS_CMDS (in the
> zram_lib.sh + take into account TST_NEEDS_CMDS from tests), but that's another
> story.
Agree.

Best Regards
Yang Xu
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
