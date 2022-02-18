Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51278C433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 07:03:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56FCF3CA0EA
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 08:03:27 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADC063C9F0B
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 08:03:17 +0100 (CET)
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com
 [216.71.158.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D35E62009B7
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 08:03:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1645167796; x=1676703796;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=KFn9jFsgcg5a9psCGU+UnTl9/9ljlYQMW5RiaoY48Sg=;
 b=Ijh3bXbG5+C2GyM5WWHgUYHgsomu9gYUi0st2MDDEdBQpx3J1DQJ1Jyq
 8RiYhsvmf8kpX8cD6ppw7CZWN+ymcq8wcZ+MC8KBljOLvworloezRu9Cb
 W3UFFPus2oprQYxKElFcefxxA/qRMPEq+yeyF5Y9I8MXdpWFxLU9yZZN4
 y0jF6ZBt9EjsL1rt1BRWVcALyaiZudGb1pkgjhWGNtgsfMpfa1f2WYBnO
 EsiDkuXjLzHkQcCy22G2l370BAhEiSitWkR1s0DdfU04+H2BmmVYN0pix
 /HaVDMAyBk6oPrarkpOnwF5jyfFQeMuJPcrNUzApgogA2jpcdcCTaaQw4 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="49972756"
X-IronPort-AV: E=Sophos;i="5.88,378,1635174000"; d="scan'208";a="49972756"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2022 16:03:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMelypxCfIgVCuRK0CmaTNtEXViKVhKtbSrhNQeLttLPX1Vgu7vbp8NmVhkb/m2t5mq3sIeiSrTQSZpQKfzaBq1sRW1kRTQlYmeXHh3cV+/coSOyJBvgENj7iJv9Lel7R3IdKQyYWqF1BjkDRjy7bqNmeCOVyD5vHHHf86gTojSxepA1byhn84EKOHd16n8XQqRnOuBXySmeyWXMHLSSGuV9frVXXN+2LtXN6qXX0eFDMUkG04NRG533fjEVEng5N14+NXg5somG6+WMlEPqDCDl+zySJSz8cu37RqSu5/r1Vb3Au1cHdYCY7cg4p2bZP8k7a6rJwpZDE6fZF9VH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFn9jFsgcg5a9psCGU+UnTl9/9ljlYQMW5RiaoY48Sg=;
 b=g7u3SyZc/lg4Z6Dvc7zKkY5yYfdSQYLkYPRUXieFJPXZft/lmr2IMVrGDJ/KFdfiwG86yueRdWbo8aEkioQ30VzRNkmub7t9YPhqAkS7i7ivHY+uMvJNSbkoIRqroor9AOdisFS1OWFoe71POMSA6DOxshIrwCIhhJ2yvlKIKck/85WFD8qd2YR+3+DZaABuFVrRmUHOBUiYEtSnZLpPihs+/YvNHitIsZUqKBvpr4QEdmrvsZmIbl8PQVAB/Fn6gEuPSyxBd0lGp0g7bhunMbS/8mzI/7FHodC9llABG4h1CUj684qTGBqP2SU7syW0+yKw9HdZ9Odyvk3O3Nyc5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFn9jFsgcg5a9psCGU+UnTl9/9ljlYQMW5RiaoY48Sg=;
 b=EUvHiLyd9QNfNRXUyBmjRuO3NwQboUZHXSaRDsxp2Z3lKopEpJVn0XmnPZLO+or3rudyX8yfJUObJxsP+4NdUc4VeLUhZIT+fAg68UHIG1ReYMt/dtc8SbXu8sqDYVd2DYf+Zv1c/9JNWv9omGjIjeUmBm1dq0nTM7H2X7wZfhA=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSBPR01MB3672.jpnprd01.prod.outlook.com (2603:1096:604:2e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 07:03:09 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 07:03:09 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 5/5] syscalls/pidfd_getfd02: add basic error test
Thread-Index: AQHYIxys4DH6OXgqL0KVaaU16gtws6yYKqMAgACEWACAADJqgIAAA74A
Date: Fri, 18 Feb 2022 07:03:09 +0000
Message-ID: <620F44D6.1070908@fujitsu.com>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645005868-2373-5-git-send-email-xuyang2018.jy@fujitsu.com>
 <Yg6oZLaYz6Dj1FY4@pevik> <620F1768.7060100@fujitsu.com>
 <Yg9Bs81ZehfgFZ38@pevik>
In-Reply-To: <Yg9Bs81ZehfgFZ38@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 367b9686-3064-473d-6b98-08d9f2acb898
x-ms-traffictypediagnostic: OSBPR01MB3672:EE_
x-microsoft-antispam-prvs: <OSBPR01MB3672FB5CC1082CD4AE668D30FD379@OSBPR01MB3672.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZJuhSUEeO63ZQ9G939Ki0iVDoYlpo2/UgNZKMY5l0dVGti1duUElp+18A1DqDiqKE7pkVOJo5tsMEF26gzM2cJaEZQOUmKB7p4lYfFAn5FRkHEL5nejhN/sZJvZR+V05ZP+2V+pkgl1k6PUFGD2REiQZZWJBjmyyXo5oZ8Z2QytCNMzoY87KUwBza+IiqbXNRps8wBxTUCmRj12voy8qOp1T/BMsmqqcqFxl6d2goCyW+R+UXzLV+qeLzl/668BYeB1dZFvTPJgkr1Wecd5bfEPKH4qiiWsylx4Ptz7T3k4beVZ86naUe4e0CzxawG8gC/Lne2/aLChAKZiO4+P+GRionYh2aKoXZxRsxKkgwvp4FCHog5mwAzNF/jhVdi2BJNbVPSSofUelkybgNyo+o2+X01Jq0gsHw3IfNg4P1WXifVjGSLWJbU/ccPiS5FQGQacKq84nAb46xG7v5qQImAiwezlDWY8Zr9DxfAussm/rItEnZIhwOIJH/Dib3ph5w5YNs6WnGzxmfZ+nUNnCEYAN/jXGqEVYHX7tGZm6DRxLbOJi+CZFGYVfR30QWnS4Z8UFhmLxHQjBONORXtCybq11aiLVEjpW/hDIW4prXPUNKvx8sYfwyZiQPIAY8P+ZZ7sdrO2EB6N4L5YIXTZOR0YH7aOk99WcVd/EswsnP0yVc9+yEtzWXa6ZuIp8sxWQ44Tr/whn035WD+tJJKphUw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(36756003)(8676002)(66446008)(186003)(316002)(33656002)(87266011)(5660300002)(6506007)(122000001)(38100700002)(6486002)(85182001)(6916009)(508600001)(82960400001)(66476007)(91956017)(6512007)(64756008)(4326008)(66556008)(83380400001)(76116006)(66946007)(26005)(71200400001)(8936002)(86362001)(4744005)(2616005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?L2ZvaFpiQy9lMEFoWEc0SG5jWjErcHZiOWUrVjB3ekdJRG9RWjNTcVh2WDg5?=
 =?gb2312?B?NUlqZ2JFNm5Dbi9iQ2licm8rT0VpRmpST1JQdEFWeEdYQ3AzMmI4Mk5VdHJz?=
 =?gb2312?B?UVZvaHB1ZFp4UUY5SjROQUg0SS9neFpMMWVVcWRCeGVSS3R6VWpxckNrNUw4?=
 =?gb2312?B?ZS96SVBROUlQRTl5QXoxUEEyRk4wcDEzM2dGOXVrTlpWUkF1d2ZGTlB5Szd6?=
 =?gb2312?B?Z3kwVWF1UmExbW9jQyt2aEQxL29hOE02K2dXeSt0b0FpZjg5MVdTMjY1ejRJ?=
 =?gb2312?B?TDRycTJjSy9RT3RQWXM4WC9QQVhJcGpUcnBmYnFFZUlKZWFERmt3YkE0SUlm?=
 =?gb2312?B?OHBxQUx5RHRGV21wMFFsT05Ma1J4aUJKZUlWVG9LdWxXcTZXL3l1RnAxZy9M?=
 =?gb2312?B?OHJQSDZLS2t0bGNJL1JOYXJ1V3VnVHVqRHBvMjJvVHRmVXZZRk40SHJuMU94?=
 =?gb2312?B?b2NJRXdrRm5Ca1VnUC9QMmoxWFVwRklzVzc1cUp3ZVkwSWdpTTFzYmhpeFRj?=
 =?gb2312?B?U2xMRmxDeVlJZmxOUC8wWVFyaGxuZnUyYVZoQmJkK0UyN3B1RDhIUmhpSVVn?=
 =?gb2312?B?YUJMYVI1OUxjckZHTWdEWWtuckJEbVF1aWowZGd5U2VpRXlXVWpnUnNLbity?=
 =?gb2312?B?bzJMUXJMNG9ic0t5Mk94WkNFYjltY0hHU0xsaVIwQjlnNDRWZVpoL0lnYkZF?=
 =?gb2312?B?ckNVbDUzcTFma2Y3VDYwL25OcmQ1TXJiQ2FqTmJucVlWSEJYeWJsVXV0ZXJr?=
 =?gb2312?B?M1BaR2FtZE0rQVhueVNQU3VGNDl4V1FLKzEyazRvbjZpbXphOE1sNExFU2tq?=
 =?gb2312?B?RzgzcTJ2M0p6ajF3NVZXWXJBVllXWTFtb0ZydUhjVS9iL1dIUlJkeFphMlVj?=
 =?gb2312?B?MTc4QjNBZlJzRVlsSGtXQUdqQXpleXRyd0pZU05iMmRGaVlXSm96N2J3dng0?=
 =?gb2312?B?cUNqeDhsZW85MXVOaE03eTVpQll5Y09SQ2tQT0NTRVAwL0IwZjNjZUpuOWRR?=
 =?gb2312?B?cmpTQ0xWdC80T0lmRU9rdXBPWlRyaXJXaUtCN2lZTDczUmdPeFhhUi9sR1JQ?=
 =?gb2312?B?Ymw0dEVRK1hVejMwcDJHdHhPamcrVE1ObHZsSVRoNmJYbHc4eTFudEpXVlRB?=
 =?gb2312?B?Y3R6MXhodFF6UjlqVENWSXErWXo2L2RhMGVKeC8xQUdhM3UvaDZKenZnKzV4?=
 =?gb2312?B?czZ4RlpUTk82QTFMK2ZWR1NwclgxVnZTdCs0RUUrck1SYlhRRUNsZnV0dlZH?=
 =?gb2312?B?LzJaK2M1T2pNazNkTDVMY1NzdTYwVVJ4VWNqeTlpMnQyK1JrMU0yYmNCOHg0?=
 =?gb2312?B?cWdsemVYU1I3eGVCbzRRZDJLSk50WS9KTlFuZVBqOVluaTd5OXFvcmZBQlMv?=
 =?gb2312?B?ZXQvQmdvbCtSOGhUUy9wWTRCMlJ4M2llcUthYXZaZEhORVIvaEJEcHQ5czQ0?=
 =?gb2312?B?d2pkdk9VbHZuVVo2S0kzUm95RWxyNUV4NUYwTTh3d2ZqN2FUd2R1TC9WeEpp?=
 =?gb2312?B?K1Z2QmQzbjdjWitxL3VWVThkWmRFT3pQdUtEMis4Nm5ZdHFDb2xyNU9raXZr?=
 =?gb2312?B?TzNGRkM0RndRZHcrZVBQQUZ5NWVDT2pKeTAzb01SblR1OVpKZFRHZ1RPTk9B?=
 =?gb2312?B?RlY2cDZzVytQak0xNTcxUDgxQ1Aya2pGKzFSN1JML1JxVlNKNnMzSTFpbmxr?=
 =?gb2312?B?b0ExbXVVRkQ4dm5HSURwMUkrWVFHb1B4cy9kV09UZDEweGZrN2U5N05tR0h3?=
 =?gb2312?B?ekU3K0kweHNMTkR1Y2tnQ0xocXR4UFBEb0JkanpTNzdCUlZYZGxOVUNZRGw4?=
 =?gb2312?B?cHhvTU1FSjVoVG5vcldWVmpmenB5TlY3cCs3NHI1eHdiTldKRThSczZDWkpa?=
 =?gb2312?B?WWhyRGZkVUhFdmM0NzZNS292N0ZtVmFBTHRjZ29ZWkx2WEtHWllxaFIzQ0M4?=
 =?gb2312?B?WmVxbnNXR0NKbHhQVzcwc0RxV05iMHh1SEpsWStyUjBTQlVraElWSlM0cHZH?=
 =?gb2312?B?bGt0bXhMMzJ1TGxBSktBSE5hYmRzQWVqZUxNYlhyckwybTVsV0RUWUwvbGR5?=
 =?gb2312?B?amxnb2RXd2xQZ3BEWWlXV096TDMreVFsS1pxQUlFN0Y3VE9DVEE5Yks5Qkhy?=
 =?gb2312?B?UG9uWnMvdDRMUzhnZGwwa0Z6aDJjcmJ2ZGM5TVYxYTdXemRqbFJWL250Tkw2?=
 =?gb2312?B?UjEycVNMQWtMWnNJV0UvZFVkb1dyTXNPT0JiNEI5NDdKbVJUV0dBaEJZblhE?=
 =?gb2312?Q?4PpDqDwu5CV2tfjZqSwz8zF8DKoTHXM/HO5tDVkvc8=3D?=
Content-ID: <2F7C4AD138E5A249A2368BCA888DBEA9@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367b9686-3064-473d-6b98-08d9f2acb898
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 07:03:09.4304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QeKJNzIwfjf+oGzzPq/BvcF2c/wM5TuxHdklY2yUEXtG7O2pPTLMiGBsAXMiJtXbNpf/tXeuMFG30O0D4NlkezTEMDpCAy5trwZv3uuOI6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3672
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] syscalls/pidfd_getfd02: add basic error test
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
>>> and get more info.
>> I will look Cyril's patch and wait.
> Thx!
The Cyril's patch seems only a single patch and doesn't affect the other 
TST_TEST macros. So how I just only use 
TST_EXP_FD_SILENT(pidfd_open(getpid(), 0));?


>
>>>> +	if (!TST_PASS)
>>>> +		tst_brk(TFAIL | TTERRNO, "pidfd_open failed");
>
>>> @Cyril: would it be possible to to allow using also tst_brk() in macros in
>>> tst_test_macros.h?
>
>> Maybe can add SAFE_PIDFD_OPEN.
> I was thinking about it. But you use TFAIL - part of testing.
> But using just SAFE_PIDFD_OPEN() even it's using TBROK might be best.
My v2 just keep this.

ps: I also remove useless static expire_pidfd because we can use TST_RET 
as pidfd when tesing ESRCH error.

Best Regards
Yang Xu
>
> Kind regards,
> Petr
>
>>> Having TST_*_BRK() (i.e. TST_EXP_FD_SILENT_BRK()) looks too complicated

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
