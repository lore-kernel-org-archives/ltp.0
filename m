Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7572C433FE
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 10:00:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6978B3CA360
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 11:00:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 850D53C9600
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 11:00:40 +0100 (CET)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 71C49200778
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 11:00:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646388040; x=1677924040;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Am8dhaM1PthkxoMe3eMYTbi0cYSaXcIurMixz3F44oc=;
 b=RxU0pwXj1q5DpwL6RV+65fUM98wXwMPb7o8pBOydODIZJXGxQUwNMWJN
 4q+WoM2xK29uGhs2cvv6dBeUBvp/8DxpXRsX5JZrqLF/A4EGaLKTefz17
 Wv8aU/7av6cce2EharM+IfIxrUoELU2vanYhwk9p1VYaKh8ph+1uK5lp7
 O3tFFy3bWlOuUpa+DS4lA57E6SZtks3+jVLmSpWOjvwynYvjfgeGsYofM
 3ynCznfpkSBfvtCa34664gQNZqZXHKcjCr/8VKaOV7748BQ4bRzLLxPDL
 OUmv+uPHuthVNmhq9o8t+AjKdSHYd0hg3J5o66kzup38mPnLH2q3xjk6d g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="51112382"
X-IronPort-AV: E=Sophos;i="5.90,154,1643641200"; d="scan'208";a="51112382"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2022 19:00:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnYCGO9s8CeTCoqTNYrLDWFvSQubHVRNvsg/goHyF25T4TLwVJ7DGWMKN1jk1qrkmyQijac0PfcenOCALV117185fQB5TRPwMY/ii9sMHnLLK3qyso24qfbZtVRiIWxqvT//cM71yf9YgkjvObzDC3MptQg1kvFH4GZpbqS+VWSuYfy5y3KGyeWLqNU47oqwL1N+KfeFVHToOmxJkM20Z4Rw2bIwti+I2dnrXq0uC420+IEvE6YyjOpt8mYYTnsTjhWS982tzF+OhFvef36XLcK2BhGJmSlNgMA+wT6hli9JPsxK1Mo05VbHM5r2ddqHDdOZirZkZOEXUaLNfwDnwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Am8dhaM1PthkxoMe3eMYTbi0cYSaXcIurMixz3F44oc=;
 b=GJPQ66EvxMKF1tyMte6A1ZTvPwqZQzREQv2pNVAnt2NxWoerJz3JRbkIAKc7ChbdVl7eD5hQJqbzj896IX89gKrlVMkufXfUSACfXx78vu4Ojsr0j2XfkhorTtbw34zUGA8KkGZj1PUiciaVOm74nfOqvfbwR7RjqPj70dZQH9OmSZ2EJ74KektkcEqdPC3UU0sU3uj6r5nuwWZDXjViuecMG4tzH74f9y6apnx6TaDitmzbSUFvkICjvEqiTOz6Cz0ulcir80hv/j3ynnrJoL9yPn+arW9DpRFKBcYb6KrZ4j/LXp+SS8v7GO75UWp2VBS80l4RdbNv53fCjIH0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Am8dhaM1PthkxoMe3eMYTbi0cYSaXcIurMixz3F44oc=;
 b=HNgT6J+NQviAje08RR0dNchAuU48tld5bkgbUmETtU21UudpugIUYBGma/JO9OBhdFZG1C3H/4woBCPQS8fsfQ0SyqZSJsY2iGN6/HP7orTPPtAIhwhpXnm4v5CHqezw7auBnGI46aFRRsKDy0P2q8xuwNeF3yrXNhA8nnw4WxM=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYWPR01MB7425.jpnprd01.prod.outlook.com (2603:1096:400:c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 10:00:33 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%5]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 10:00:33 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Martin Doucha <mdoucha@suse.cz>
Thread-Topic: [PATCH 3/3] quotactl06: Fix TESTDIR1 cleanup if setup() exits
 early
Thread-Index: AQHYLxPGiBnZiWFgCk2Lm2SCIUr1tqyucxkAgACCKICAAAojAA==
Date: Fri, 4 Mar 2022 10:00:33 +0000
Message-ID: <6221E366.8000304@fujitsu.com>
References: <20220303153131.3372-1-mdoucha@suse.cz>
 <20220303153131.3372-3-mdoucha@suse.cz> <62216DB6.8040202@fujitsu.com>
 <7b039478-a14a-809f-7499-4f760a611093@suse.cz>
In-Reply-To: <7b039478-a14a-809f-7499-4f760a611093@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84ed0159-1305-4919-a9d9-08d9fdc5d278
x-ms-traffictypediagnostic: TYWPR01MB7425:EE_
x-microsoft-antispam-prvs: <TYWPR01MB7425DD85A2941ABEB7A58852FD059@TYWPR01MB7425.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w6FgjdWyg5LKBerc/N1fPn3Ws1/LbVmINEa7r9/HPRSy7reVlXWe3Jauy3dQPDQHSZExO5dDQGKWfoUrQ1GvpWr6y0FMyavCMyw134ryj/rWPL2MrOqXP3d5IGmHP6tl92s46n96/VQkD0c0br/xN/uZfoHOZd6pV9NGC2tYyOCCIarSt++Mop2JV8UQAt9XnFuDtrVcAEaHDmVuQWUxHKRsJ2AAcDOx1XlfLI7LEjQygKptWbfO42Sjt2vLLz4PM1sU1v2TvOizjQSZVKm0BdW7IMMZwM4tGYDyzZ9WLpTDE8iWbs+UjHN4xlIdBTiMOE7bMMtYpBSg+mV8GbdylmlHKaOE1sfLGKFqYO77lnbkHzXseyuUeRUEo7qwqPwsvg0poqSNjkwioRDHgNfUuqX9WQrK3PrFwA5NDSssNBsz6Pmibm08u2PpX9hwYY5DAW5zDEmcETlSp8ROpe61vK4EKGlxWtbXYJqmvfsMaXXqUFmLTrscJLBVAtVMMigRpmOK1En8fCq12iGFnbBsnM8HBu0Xln8Xz6CEHppC5YQzM+QT1vGwEUhkxaH+c3dEqFgp82y26yueJAPMGn44xPfB2+NyXMB/5HuZyHGS6StsiJEanJyJ4Sigg5sSDXZofxG1/cMbnxYhAQX4r8U+Mman+7yTVzmdJVhHGVxNF2T0R8pyPl1i0xixpcLw1g6FsrQIjeM4e5gmft/hNGxMuQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(15650500001)(5660300002)(36756003)(38100700002)(186003)(8676002)(82960400001)(4326008)(122000001)(2906002)(91956017)(66476007)(76116006)(66946007)(66556008)(85182001)(66446008)(64756008)(26005)(6486002)(87266011)(6506007)(83380400001)(6916009)(86362001)(38070700005)(316002)(71200400001)(33656002)(6512007)(2616005)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWp6UlhHaFVxdXdoWGY0WUErd2JValBHWmpMdXpXV0hYOWJMTFdSVFRaWWVK?=
 =?utf-8?B?SXZKMWdraFcxcU5laStiQ2plNFI0YUI4cnJDV09hOU9TdzN0Sy9pa0FSWUxk?=
 =?utf-8?B?dHM5T1RVd0NuaFc5bW9sSzhsdm40dmI3bk0wbHZ6VUZCU05PcmE2Z1dSNHNS?=
 =?utf-8?B?MDhsR2RTRkt4UzlEejl4NFg1VVZpcTZCbGxjei9pMzhYcHNrYkVkWnhadU05?=
 =?utf-8?B?T0huR1JRcDZieXhLNzVjMVo0UWRsVkdWNDJUam02dGkzQzZVdDYrQy90eGpW?=
 =?utf-8?B?S24vVWc1cGRvZ2NvMnFteGk2ODh4VE1FTDdKL24wT1IvdHpFVGxmVmZJMVR2?=
 =?utf-8?B?am9lbHlHYnhJa05YU0JPVTJObFl3NUFPT1MzUWYwTVpvUitqSlVkSkdZd1pp?=
 =?utf-8?B?YklrRStlb29hOU1CUW43TFRyV1VjVXF2VFBxVytVa3FkR01lcmF1MXpmVjZC?=
 =?utf-8?B?MSszNlFYT3N0VnNUNnAxU2g5eDdLNDFoN2tpTWU2ZnMzYjB5ODZJQnJWcDVQ?=
 =?utf-8?B?TnRMb1EwaHVZeUtQSnJLMGZrdmhSS2ZRbHdLakM2em5TbE8yOUlqekF5RG9j?=
 =?utf-8?B?UG5GTVdUdEhMUFF6TWsxNW5oWlFTSkVvMDlVckJqeXV6QnlXK2lheFNmcnYz?=
 =?utf-8?B?Vzh1YTlSOXgvMzdoY0dZYTBkdkVkZ2xiL0YwcWkyZ0NYbWE5NTBGQVJTOHRC?=
 =?utf-8?B?bWMvYklXVXoyQk5Fdzk0dGJodTBydm0zMjQ5d0hkcjJRM084Y0h5TnpIM2Er?=
 =?utf-8?B?bEFQOFNuelhRRzA5TUdQVlhsTVduYmxMdm9ReU9GMXlNTnFxaElvcGx1a011?=
 =?utf-8?B?OWRNa011bUcvc1FOcWMrMFpUOWZNTGdOTFlETWgzSnN3UjZZd0ZHYnYrT1dH?=
 =?utf-8?B?eUJhcXVhcGVvb2w1WHhyRVZDQzBtTGJnejAzUEt6cXo3c2U1dmJGYWVVZVRM?=
 =?utf-8?B?czRvcHl1YktFczZWMXNzSGRIYUF2d0RKK0hDUmw1SW5helg5NVpMUVVqOFdr?=
 =?utf-8?B?WU83eVNiYlVmbEcyZjRPbEd5QmsrTEVSQWRoZjU3Vkdod2VseWVPaDAzSmtP?=
 =?utf-8?B?RnhzaDRPaUhpdVUwWW9saFNWNzRrSEtVYms4cXVyQ3NveU1LNlovYnVHbHFp?=
 =?utf-8?B?Wnhucm9YbENzMUtEVm12Q1dDaTFONnc4TkZlUHZvRVZuNHhpOVpyVFR6TENX?=
 =?utf-8?B?cExBQk93S3JSejI0N3g4L2NsbzZKOE5Memx2UjNXS3NTam5YdEppTlFTYjlR?=
 =?utf-8?B?YnJIZVg5L0x3eC9xYVMrenhISTJRZ1hsV3RZcU13c25KRndWckFQeG1GL011?=
 =?utf-8?B?WURRTnQ4aGo3bnRCNFpSdzVwRU4xcnBaQzl2SkpaRUJYcEpLZGpaMSs4bk5k?=
 =?utf-8?B?eWRocXZVTCt4eHdpbUk3T1IraS96TTB0YUpjQ2FzQVZjTlpGSnZ1WUVHMlVM?=
 =?utf-8?B?RVRvNUhaYjU3Ry80SWpOcFJBQVc3R2RzMStFdCt4OXhSV29neHprN2dmTkRw?=
 =?utf-8?B?UEtHNnp5enZiRXppODZVcXA0RnVqV01TQk9GMXV3TW5Wb3B5Z1llYnB3UEgz?=
 =?utf-8?B?VG9oL1VKU2hWT0l4WFJ3NmNRMENhOTQrclNTcEluaGVkVTlYREhxL3VXVWdB?=
 =?utf-8?B?RmU0OWIzdEtnZmZnai80ZmZpZzZVdVhtUWZRQzd3bWszd1FhM2VFMUpjTjBk?=
 =?utf-8?B?M21hVlJtb0l2eENjbE4vaVhHMkNRSG5OVkh2ZkUrRVNJN3VmNWMxYXpFcWZ4?=
 =?utf-8?B?b2ZqdEttRzAxRFQ5QlhOamxHK3ErZ054RGNvbG45RVJ5RldYU2ZpYklhWjJq?=
 =?utf-8?B?TUtjQXE5Z3RUdm03cUttNEVyTGRHWkpYbmdwbnBPbUs1Tk1iOFJJRVIwQ0R4?=
 =?utf-8?B?S0JUYzVmUHZIdjF3bVRvSXFkbzdSRHJ2TVpTOTlNZUVOdjhiWUM3Y2RlNDhZ?=
 =?utf-8?B?NlNQQ1FTaHd5b2hTYTM0Q3JVdEVxaXZiQ3VjeU9BVTRtMFZ6VGk5aXBTYm1P?=
 =?utf-8?B?MlBndGkvODFGNkRZNWQ1NVhqTldRU0duNDV3cHhaRkhZVFdSN2ZCUVhwZFJ4?=
 =?utf-8?B?UjZaa01xNGppYjhLckM5QjFyY1VkMk5hVEZISzNXSDBxeEFTc0lSTk9xdnZL?=
 =?utf-8?B?RW8ycGFaRUUxM3lHK1BiK2k0OGowL1BuNkdsR2JGRk9CcXdCQi8vTjY2VCsx?=
 =?utf-8?B?Y01HYjEydkptTjNTUnZYYzhjdTYweVJ4czZvYS84S2R0SUVtaHZ6S2M2b011?=
 =?utf-8?Q?Qm6HTB0cvcfZ4jB4i6VH199ddB26nie8dFVOWEfMGw=3D?=
Content-ID: <231C9CCA66C80A40867CDBFFB814803F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ed0159-1305-4919-a9d9-08d9fdc5d278
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 10:00:33.0362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: syXwpFti0xiVoZ7wY3acYqL6HC80dKtJyRVIEIW/wlZLz/vE2bv3dcan/nFVtLDyw7Ib0OM1D046M5udwAkXGl09a44meP1R374ZGj+2FWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7425
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] quotactl06: Fix TESTDIR1 cleanup if setup()
 exits early
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

Hi Martin
> On 04. 03. 22 2:38, xuyang2018.jy@fujitsu.com wrote:
>> Hi Martin
>>> When setup() exits with TCONF before TESTDIR1 gets created, cleanup() will
>>> trigger TWARN when it tries to delete it. Check whether the directory exists
>>> before calling SAFE_RMDIR().
>>>
>>> Signed-off-by: Martin Doucha<mdoucha@suse.cz>
>>> ---
>>>    testcases/kernel/syscalls/quotactl/quotactl06.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
>>> index 8e9a17393..d470486d5 100644
>>> --- a/testcases/kernel/syscalls/quotactl/quotactl06.c
>>> +++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
>>> @@ -207,7 +207,9 @@ static void setup(void)
>>>    static void cleanup(void)
>>>    {
>>>    	SAFE_UNLINK(USRPATH);
>> It seems we also should check USRPATH whether existed.
>
> If I understand correctly, the file will be created by mount(), even
> before setup() gets executed. So if the file doesn't exist during
> cleanup(), the error will be valid.
The USRPATH file is generated by quotacheck command.

Best Regards
Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
