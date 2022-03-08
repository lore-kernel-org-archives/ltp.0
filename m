Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535E7C433EF
	for <ltp@archiver.kernel.org>; Tue,  8 Mar 2022 10:05:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D4693C1C5C
	for <ltp@archiver.kernel.org>; Tue,  8 Mar 2022 11:05:05 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7795C3C1BD5
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 11:04:53 +0100 (CET)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4E1F7200B37
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 11:04:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646733892; x=1678269892;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Ebw3u9bt7o8IiWVxtQ4HGBe8U/yL8sNH0RpN3pqtJeg=;
 b=flwBr8mo7d3yoBsz5tTMIaWZHfDKAmNyDwq8JSK9vVqlIHvs/O+varWD
 4a3GrJx3HREj3wKO8P7fP3oWRtz9uLz2jQNj5tJtw22Wbei86YWYr68tB
 RMP3rHJcLvjcUvCUTBKy3VY0qi5EeaE5enw+Cbztzu3/NYR3462vtYMJd
 45RIptxG9G68Kg3U6wHMGMoEg/Bjgh9P+Jv6I/pU9v4WTF+iG9TVn03Gf
 AIPuvUA5okAClgaR8bHeCLxMB7zBQgUZljBpbSBJb6lE04unaO/54DGgW
 N1rzlQK+X3vgBec450wtEFdH0TRSWwneKPhMiT5B6nuWA9iJ/m5FFAcTc g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="51390506"
X-IronPort-AV: E=Sophos;i="5.90,164,1643641200"; d="scan'208";a="51390506"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 19:04:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OldkWan1Lj8LShHfVRTledaHGGIN69b0SvzThLQKEoCe/OY3QpQYy3a2TeKUJu6GyTJP86R+YZ9iUAqGQoA6+RezqqmWv1AwlEd+Rblpd/g21+TDF0sRmd32ybyx6vv4Nx0YLiA7dA23rIGwW6MufiRCKPIKfoHaBYGwGPwD0JHD5V1K1XQQfsZn1YXBqrKJdKVJzD8a9hlAgYKhL+kqyZC/nUP0Y0SuZRkROIvup58PUcYAGzuopfAVw0gTtcIcCxpRmcTCT2Emo4ftlsH9vUk67D5t1KVz+69Qzu9QPQ4BfkP2jgA9MMGAApiQmLV8B7/isXBS8bo9vKccXfxCmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ebw3u9bt7o8IiWVxtQ4HGBe8U/yL8sNH0RpN3pqtJeg=;
 b=gBUJM1suoZh4jLHa2sg8wGjCMrCd/DAeBCDPZ93zGgZa6+BCcWVCy6xrwUF1FyQtpGal0khPX722u2c+FRtGYtILXRUKpHj2r/lFRvpzaT/18xWX8AmyL9RUE0nDTmuwaTTyK4XUlQAp7aEhEaW+mwVrqJNeHKQm5r399YR64qxc6jCSKVxGV7U9R2g9ek91wuDRKojMb5dAc3g4uvQ5Fhd/UhrFilxPOI4i3ylz3Q+WpPB5zPamdM06/Qm/k7JmYnVM1wilOK2yfgxmc6F5ZqQVf+t7iPg4JY4u0xiXq3rMXOzazrbI2LVhpH/YebaKNUF/sDr3bplM4Er2BJPFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ebw3u9bt7o8IiWVxtQ4HGBe8U/yL8sNH0RpN3pqtJeg=;
 b=ET//Ds2v2u08sPlEunK/RCfhQQjO/Q44DR6H2OkkR4wL5sojQebmjJ8h1wKrDIGbPIIrnABEK2fGLcOmg+jNaLmQ7N97GGDSwU/e+rnN3nEDGBp5lMZ1hNxTIU+uPYwlbeC8umXt3HQ761tyHxPvcV9Fpoavw7z0/7MKnk3M+ig=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB8250.jpnprd01.prod.outlook.com (2603:1096:400:103::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Tue, 8 Mar
 2022 10:04:47 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 10:04:47 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls/setsockopt09: Add another linux git
Thread-Index: AQHYLtx4CjNbvmY4GEm3jKnRYeFwH6ytsXoAgADfuQCAAE1FgIAGa+eA
Date: Tue, 8 Mar 2022 10:04:47 +0000
Message-ID: <62272A6D.4090204@fujitsu.com>
References: <1646297678-2141-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YiDK7g1pwLj2aXBD@pevik> <6221869A.9040109@fujitsu.com>
 <YiHHa51Lekmkpp6u@pevik>
In-Reply-To: <YiHHa51Lekmkpp6u@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d63728c-30f9-4ade-e687-08da00eb13a7
x-ms-traffictypediagnostic: TYCPR01MB8250:EE_
x-microsoft-antispam-prvs: <TYCPR01MB82501E2EE396A4032946D01DFD099@TYCPR01MB8250.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LJtrAI92+vMO9UGOLMrL/tHwqQIUBszsFSnBjTYBKAHmLAks3W9f1R3TsIMyseFpk2KBDELPeTnPZEJupPDjrnTmVJeHpsaXBOZAIGiNtazF+FQAqWTr9K2Y4LwTRCKK3ZHniXbb0S65cget6iP3eVm7MqiVn2skGvbQ1D8cmBL7n+SRT1fV0eMf6Ks96VBHZ7CdNEAHDcf3vajPMFRIuA8qTgugt7/ieHbast+VBUcs7+qfAU2WCtmtmrc3pKfmCgBTgGoY7vb7hA9ZnnX4kPpa4FQK8d7JtEP4+dXkON7NNqTtIDLcJyizlHs3wfwTD+grt+zOw18t1F0DcbhDDaPTHGOmsoD8IuyiP24sx6JQT/2IFg1PuQikmpQL6Pur2oHrn781u1ZZpH1aaEp+DlZvCLBE/eQonjg0yr2x4d1Fpf5cidtj7o+l/ljph0SHs3Ctu22eKo+kT7TZJoEg1nqRDoe17grRdCijNHGGgVtjRTBzqVe59Iso4A2LhIqbvMrKxD/Imu1ZaXCRCm0TClA/+Oj+1TNEWO1Scrr6upCtFCjuD8vG0XHSF4OiuSXS08DHT7C892u3JQq9/LSXUzUCQ8GxCcE/jysBnD4bJ15/PyO0RjetJmRrO/DaarEpJRUjmYXgundb1yEaFqrH/DvYw4iKT9jJz3azxLJW4137dFgMhs5cPVbwlkeXMN56pZos7c5axcFsPqbGDcZSKg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(508600001)(86362001)(6486002)(2616005)(26005)(83380400001)(87266011)(71200400001)(82960400001)(6506007)(6512007)(186003)(4326008)(5660300002)(2906002)(76116006)(91956017)(33656002)(8676002)(66946007)(64756008)(66446008)(66476007)(66556008)(38100700002)(122000001)(316002)(36756003)(85182001)(8936002)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bGEweFFQb2svTVcwVHAzOXAyaStrVmluVmlTRVYvem9KeGlkeTJPTThWWGt1?=
 =?gb2312?B?OEoxNmhFczN6b2MrNmJsVjgyTUVuakQ5OWdtOUF5ZFFuNWRtSjVMRmhrVmo1?=
 =?gb2312?B?Z1loWkZMbThBdkFJQWd0TnFJMVFuZEZpTTEzMHJYa0VLUVVhNVZ0bzl5Vm5T?=
 =?gb2312?B?WS9tWkNweWxTbElMNmtsZk9YMjBFa2RNZTd3WEs3WlFmWllnQ3RxaDkvaE9X?=
 =?gb2312?B?UXUvcEUyZE1HVGVqT091Vm9DenRUVmlzSVIwVUl2RklkUFh2UG1yd1IzNHc1?=
 =?gb2312?B?c2V1VUtreDVWU2VGa0ZZUHVaQjliYi9aWlg3MXVEcC85MXZHNVJkbW5ncklq?=
 =?gb2312?B?d3ZsUHNiUEc3NmVTWkNEaGNLVHc1YnRTM0dhTkkzdkFKUS8rZmV2WVNYZUZE?=
 =?gb2312?B?S0pIVkVHRTEvaWxOQ0pRcVBwQ3h1dlgvYlpXRkhwZlhJZzVUWkdTb1lzQllP?=
 =?gb2312?B?RkpYWFIxZmtpby9UUU9sRloxa3JuTjZUMjk0Uko5VVlZQkZ0aWtuVWlzSmlj?=
 =?gb2312?B?ZGV4L0E2aUcrb2UvVzBQekVNNHV0T3ZpWndhRFpqUFZwc3UxaWNsdlN6M0gy?=
 =?gb2312?B?WW8wSkYvZHlWZmFuN3ByWGtYTG1aakdhd1llZE50Y0VzMHF4UEFudXoxOHd0?=
 =?gb2312?B?YWpPeFFlYmRKejRwVWJMY0k0TlREV2IxUy9MVDJiQkQ5K01xMFhvanF3TjM4?=
 =?gb2312?B?aDJZMWIyOElJZ2JlMVF6dXpFeVJBWUR0ZStDMUI1QXdvRnRKSHE1UDRiWEc3?=
 =?gb2312?B?UnYrcU1lbGVpYkpHWnJOZ3hKVy95OUJvL1ljTWJybjJ3azRUYk4zTlpaNVcy?=
 =?gb2312?B?NWE4eDFoaERqTjhKaCtjdExtbDZWUVZqY1ZkR05keHlLWWlLakhTanBYQkpl?=
 =?gb2312?B?b1hrT1pGZ0pZRi9CN3V0L0l4SldJOUFORC9LVlJTWFo4QkJWblNZamlGRVUz?=
 =?gb2312?B?NGNHc0lXRGV2bTVLMk9JUkJ5azEvUDUrZVQxODlPS25RUTEwczI2ZjMva0lN?=
 =?gb2312?B?QzZIN0VXVlZMWFNwSXdtSTlTempIMWVLTDUwdEU3eWRwa2R2eFpZcGRyaUVn?=
 =?gb2312?B?WDVPVDdLQk0wYlJpVUZXTW9jM0RYb2FCTkJZa2FXZktQZUxPN0tPRVV0eUgz?=
 =?gb2312?B?cXNlUUtlUkVQU2ZpZ0JwQlVoSWtoMVZ4N2RzTXB4ZWVTeXozUXVXMm5FWVpV?=
 =?gb2312?B?ZUNmbGJaK0NBd0I2b0ZkR3gxWFBydDJGTmlkaUtDOC96UzFlSGd2SjRZSzl6?=
 =?gb2312?B?NEVtT0U3OTdZbHNOOUF0MTg0SVhTWDYvNnNlQWlYdEVYaGRIa0ZHU3VFd05J?=
 =?gb2312?B?Sm1HY2ZhWSszTGw2c3BLa1BrbWJwNE1wdmRoNzZJZlVtU283c3BvdGVmRnc2?=
 =?gb2312?B?M0Viam1KdzBUc2o1UVkxUjV4NTZkbkNMT2hCa0NUWk51d2dNb3ZsVENDTkRr?=
 =?gb2312?B?ai8yaFMreFlvdjVMVno0ei93TnBwVWV3S1RrRy91dVpSRy9KK2lHMXh1Sjdo?=
 =?gb2312?B?dWZBTy94bFBkUEdYMXplWDErc2ZQdWp5UTFxbHBSNE5QMWF5bHFucnoyRXR3?=
 =?gb2312?B?cHI5YkxZTmEvdXlMMndENlFTUXpVMTFZcVNNazI3M3hJdmNJdnYrVDVCRXZs?=
 =?gb2312?B?WnZ3S1orSWRuc2t5NjUvZkM1Nlh1d3BzNWNwdStYTVpISWZ2T0s4N0ROd2Zs?=
 =?gb2312?B?d0U0QWJlc21pcklWQkRKdGwrRTFKRzlpK1NqT3BRalNmWnF0M3l5MEd2Mm1I?=
 =?gb2312?B?cE5RdVRPRHQ5K2hTdHVabWdWbUZMTXhnWmdqdDlHTFlWdHAzemhiL2NHemFZ?=
 =?gb2312?B?RWR1clRkWld0YmRScHdoM0hLa1RXcGxlcS9FRzZqc1QrUy9nYldGaGZqcXh1?=
 =?gb2312?B?clcwcWt6WkpWNXBjdGphSmJBelUrcnp4RlF0blZKRHBvTXZmVHNlUW8wWGM2?=
 =?gb2312?B?ZVVrQlVvYjI3bllrMlB4MDZOTGRBV3dMNEUvcDQ4TDczQ0JGYjVJTi9za0VP?=
 =?gb2312?B?eFRUdTNpcTNJdyt1RGJ1aU45Q3p2ZkcwbXE2UVlYeXdRc2xBWW1leERZNGd2?=
 =?gb2312?B?NkVIWmdLamU0Rk1YZEQwb1J4bTVQUjFvK2hoaUo5L2xyYlNCSmZmYkQ2cVVv?=
 =?gb2312?B?TVFQZ1cwOE9DNEpVRWlDM2lIZFFDbjNmOWVuSmdLaVl4MEJqTVk3R2ZySHcx?=
 =?gb2312?B?bnNyUlB4VVZyY1RXNEp5T1dJWUVjNFFwc1JCVGk2VWloS25GekNtVGZGZFlk?=
 =?gb2312?Q?zKq1E3hZ3zXSWhcS6M7AC3fGS3r4Yr+QwCCHyyYmT8=3D?=
Content-ID: <18934B3F7B42A648B4BE395730F880A6@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d63728c-30f9-4ade-e687-08da00eb13a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 10:04:47.2806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uy2VWNdTlhrGtmkni9cx+ODAV0JaS2SOFSZLh/sbpU+xdkpFudjvzRVGvACF+nkACV1sSuCdkmkc2eQWF/g638/zMSy68W8PjOmGM6iJPZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8250
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/setsockopt09: Add another linux git
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
>> Hi Petr
>>> Hi Xu,
>
>>>> On centos7.9ga, I still hit another crash problem because of use-after-free in
>>>> prb_retire_rx_blk_timer_expired(). Since we free it when timer expired, so this
>>>> case will crash after we print TPASS info.
>
>>> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>
>>> LGTM.
>>> I tested two old kernels, the one with patch survives, the other got reboot.
>
>>> BTW funny enough the affected system manages to print "TPASS: Nothing bad
>>> happened, probably" before reboot :).
>> Yes, it crash when timer expired, so it will print TPASS before reboot.
>> Also, I try sleep 10ms, but it still print TPASS and reboot after serval
>> seconds.
>
>> I have wrote it in my commit message, so this should  be friendly for
>> user to know this situation.
>
> Sure, I didn't expect we would be able to fix this (I'm *not* voting for sleep
> 10+ s). It can just be a bit confusing when you read test logs if the framework
> does not clearly show that system got rebooted (I saw reset in dmesg but didn't
> believe it's caused by this test output due TPASS. Lesson learned :)).
Yes, it looks confused.

So, how about testing 100 times in runtest/syscall and runtest/cve like 
"cve-2021-22555 setsockopt08 -i 100" does.

ps: I tested it on old kernel and it works well.

Best Regards
Yang Xu
>
> Kind regards,
> Petr
>
>> Best Regards
>> Yang Xu
>
>>> Kind regards,
>>> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
