Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0CFC433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 06:29:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D5633C87C8
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 07:29:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C64843C72F7
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 07:28:53 +0100 (CET)
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com
 [216.71.158.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4A01B1400B78
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 07:28:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1647930533; x=1679466533;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=PvRsyrkrdlsYemtxK4ArcAAEN1WiVATJdcveuh11R6E=;
 b=HUkNJizLl3QnfUAbcsqwBbAJuAEtIRljk2BU62jpanj9WB2ZCXqcWOQh
 tQY1UAEnhRBaYTGxaJJ2IRwQBXrZeRu51g/v/6555QIFOjwj59Pe/vlO/
 YqYL4ROvQkASd1+3Vw/ov8/X4XNsl9ei7BCRX7BCvQNNm3CMvq1HdOIA9
 PHmHMoQ8Mh2ELGIxgL0zGqakjOVxjetFN6jysyQLwEJJEVtfiFMNWxvU+
 yW7eQNOjmcqZE/rRbTqc8W39DgSblapVGS/wiL6zX7z7AfOhcRgn0wNMv
 OawOV1qDNJPMVm32ty3C0zTdvznexQbn5YV+L5km5UjlFhODoJk2XhIlq w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="52167769"
X-IronPort-AV: E=Sophos;i="5.90,200,1643641200"; d="scan'208";a="52167769"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2022 15:28:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMBYAX5h12d47NIA7uakhWyhqDqkIU4+87qvHyissDk+OyKWe/EVBtG2t6M6Z41h2TNvGLLeg8PWmDdZphtbcdL0fYa/RxOSRwVHgxYR2HJex/1epiWCOjr+mWUcb3pumx3hPB3F6soiuKIU2bnAgkl6W5PZqO1xq9MBopHEInE1OYiiDT2NLuqD0Md40bB1IiQgEaDD5sLQnyR180/RcSD1KzxY/KUrPwEWcshelZNEi3EAN8HrFTmyF3fOJYdMM/6Fnad2Zu3d8YWVgJ9lo4RYvtuC+Hv9bv0440t5q6AQcTvcgQS1+r3AzEbfYXaAqDWhJChOFBfKx4aB9HXutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvRsyrkrdlsYemtxK4ArcAAEN1WiVATJdcveuh11R6E=;
 b=MrPJkYiXLs8NG3L8pz93y6z+sQUqQgzZLVafpJKl2sQSjGna2Eranv5InJBkAEHpvvgpWelpLGOtkjvGSRWTHp0RiycxqH+700d4zwd/0lBl2oTxqRk0lg8HcpSgCvc/i6AVPbIxkLOL2RClGz7AFPjSan/gNamSGnuFbQnzrppSJMQj6vgrLaPaTruEI/SXAtmyxGby6Or6E85OQ6fBTDPToKLoca12K4z7FvsFa6INTUdYJhuogQ9DldwJZIFv1XDZaZ9Qp778FM+vAqPLvLdyK3R1UFt1nj6zkUIvHY5QpLWdVlJRL2dl24n1RoynV1Liujyw0TGfBz9UuAeF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvRsyrkrdlsYemtxK4ArcAAEN1WiVATJdcveuh11R6E=;
 b=AHmD88OyXOuqALQaOmztS4rNHajxxaSUPvpTlCwkhPW5PLWDTd8Hf+O5N4DDUOGsalZd0bfZvm3scEQWVbmipO9lIhZmUOrlaNHWdKhzXYIRGl0U/DIsZFDciZqh8yR/gGnc8MMG9erzVBdkLrcIVzNrDEx8d5+UOQkAdGIxix4=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB2315.jpnprd01.prod.outlook.com (2603:1096:404:c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Tue, 22 Mar
 2022 06:28:45 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 06:28:45 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Thread-Topic: [LTP] [RFC PATCH 1/1] creat09: Fix on more restrictive umask
Thread-Index: AQHYN9eJWCFPwI5fE0G2efRMRz6TPazEzJUAgAAsKICAAMI5AIAFQcSA
Date: Tue, 22 Mar 2022 06:28:45 +0000
Message-ID: <62396CD3.708@fujitsu.com>
References: <20220314191234.12382-1-pvorel@suse.cz>
 <62343BF2.1020006@fujitsu.com> <623460FD.8070500@fujitsu.com>
 <20220318221258.GK8241@magnolia>
In-Reply-To: <20220318221258.GK8241@magnolia>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29e04076-deda-4ee9-c46e-08da0bcd37af
x-ms-traffictypediagnostic: TY2PR01MB2315:EE_
x-microsoft-antispam-prvs: <TY2PR01MB2315FA890EBF33EA6782BFB9FD179@TY2PR01MB2315.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z1aAU10enfrO8thFGHhwKbYG6NgTptjHO6jgSKgyMSqMOW0PQ6V0l5Gmy5zFDrQghZer0hnUnYSu/7PZKsAEo2CLpX+cUH/LUvTUy44ESCw2fWGVNFivLhOojjRKkNk91/e1KelF4kjyAplZhOYnCQCA6rKyfmu09DN9UjkWOHXW5K3naU3w0Kv+gnax4pq8TVkVu6d5aUQzwAHCZS74rTQvZ0vhPgLUa2/wtYEKi8P108thJ32vpI/0s/MpKqp5FHVvLWJZzcxIv35Fq5o1lOZ9dYmNkVw2utPqV8980WkFY9cyaEg76PLNMj+EFaXsA7jmyO4TKKAvB8caNGUlXr0+3WRHBAnTOW9OIJitdd/2YCKEOi23VKGER4P/1wdPnsM9otOa+wFXE+FwwjZ33nP/+gGUfEiI//O3KvmQhswNuWzOZ0T+PxHtz40NlFohwAPJQ/A5Ly6AP+Qm6YMcKcQFbF+SlW3rTCHGd2hjg5pJXOnt4TCFLWFbhI9q2afr0Ppf4dVQOVnZJbBPuAPtuTy9eGtIiKCDKPlUFcyJUPbbIy+DMgL1rh+Z+p3VQgtzXLfE2U4+M7RF5wEyTN91UuO611km9DRe9TEecYEVqa41aHtBQnXBHEQtc1wh38URFLCGpQH9vEjjiy0Hrp5xpyWIoeL9o9xuHDPaPuWVq5HWTyyqUbYDunbLKmXENRSaI8SwPyvVNX8iD6e8pHpe6LNerWWWSEYe/MO7+q/fHiNh/8esI/cLx3rkkgVLNAi39xb9NOFAJuslH/+SWfceOEAF0SPY0V3bNYn7zv+CT7U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(66476007)(4326008)(76116006)(8676002)(508600001)(66946007)(71200400001)(86362001)(91956017)(316002)(66556008)(8936002)(38070700005)(64756008)(2906002)(38100700002)(33656002)(66446008)(5660300002)(122000001)(82960400001)(6916009)(6512007)(966005)(54906003)(6486002)(2616005)(85182001)(186003)(26005)(36756003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Tkl2dkxpQWJNQWFXUnl5N2NYOUsvQWEvbVJxdkhvanluL0h4cnpWOXFnQ3Zt?=
 =?gb2312?B?WHJvdXh1UGw5UzhzMTkxOG53bkZQWjI3OWdPai9jVGdpbmRwSllsdUVwbWpk?=
 =?gb2312?B?Q0Y3ZXhDUEpReDVzTDNBMk9YVWJUaVdkQUViRko3eDBSUWNQeUpuUVhuU0Ju?=
 =?gb2312?B?ajV5SGtnaUlPSVhqeVNRRGowNDUxRWx2VmhoaGJnQ0FMZUMxbGd1NmFVNUFC?=
 =?gb2312?B?aURJeEJ1V0U1OWxjMTBveENpKzFOSWZrK1pJRmRrWnRsR2lJbEo1eXgzTExS?=
 =?gb2312?B?cUt3NGxJYnM2a3ZaVE1Dbi9UY1FSbDBsVldUZzEyRFVxTWN5Y0FmMkpxemZE?=
 =?gb2312?B?MnMzZS80MmdvYU1aQzhiYlZHS01jSHN2aWtXRVJEYk9aZVRGY0hTTW9vSEcx?=
 =?gb2312?B?a2hKNzREdzlNNjBhV2x1a2YyRTBLR1JoM2VVOHA3Q0pXM3pHZkhHcytSckov?=
 =?gb2312?B?ZWlQR21nbCtvRmdhNVBncmtPYThUbXUxWXJyVHBkQjl1QjJab2V6QytSejZI?=
 =?gb2312?B?TTV1blgzQTVncHZOQWtEeWluRDhFeWVXbGpCTXpoekFhUlh3ZXZvdDdJRlNC?=
 =?gb2312?B?VVRWcTRXWGZSMkxCZkpxaG5FaWlNdHpYT0dpTDYweXNBNnNmRkZ1K1VRTy9R?=
 =?gb2312?B?MkIzVXF5cks4eDhzOE12bVVJQ0dSL3FvR2lreiszNml3aUtienZLb0FFNmIw?=
 =?gb2312?B?VlpDeHVFTDQ2ZUdocW55ZGFzVjNQR3pkRjg1eWFEVllmdXIrc1diUEkyNU1a?=
 =?gb2312?B?TXZYTUhXRkVnUUNFVGZhemlBaXVTdmxHUlZaVUhJVWk0Z1pmajJ2MWNQamFJ?=
 =?gb2312?B?WkpOV0ZqcEFMems3ZEFLbkJYdDJCdGdsOGNCYStKQjZadzNNQ1dTcXhlMDhH?=
 =?gb2312?B?NUo3Z2FMdzl6Uk8vcElRTlA0UHpTL1lJQlkwVDhPYVV0TC9keDkwNEJIZHg2?=
 =?gb2312?B?WlNINVBaeWJpNzZOemwzUVZ2WWFPdXg3THNjaEFNdlE4Mml6L1hzYVR0RUxY?=
 =?gb2312?B?R0QvSWdKWTYvQkVYU2ZuS0pmU0JNZTg4b2w2d3NBWUhkTy82T0hlYWJldDNM?=
 =?gb2312?B?a3hnN3dRRzJKVW54S0NvQkdZUEEwb3QweEVSY21qZkFkY2hESDBvS2dwQWxa?=
 =?gb2312?B?WHI5dXNNV2pUbFU0TGJSSzJCMk1sVytzT21qMis4dTdMY2k2V1NjeVdybHE4?=
 =?gb2312?B?UG5BRDhQN01QQld1NUxGQUQrVXRsam01VDZMcjRoQjRid05LblhMS1pIaVUz?=
 =?gb2312?B?RzhmcWRLdXpYRzdTMnB3WUR0NGFiR3B6dWx6WXltVXdWSXFINlY1cVFhVzJC?=
 =?gb2312?B?aHNaZmdxTGtiTDFteHFUcm1MOC95a3Mwd29DZjlVbXFhVTVZUXRNWTNCTlNF?=
 =?gb2312?B?a2s1a3hXME9rSmIrUXBITXFlNVpHT0k4cllqWVNkZk5Wc0tkMS9WQ0UyU3FJ?=
 =?gb2312?B?QlB2NDBzTWNKQ2xDRG5xTU5zNG9ncTgwd1A5ZDU4cHhobzA4dk1ub3F0ZFZq?=
 =?gb2312?B?VEFxeE5EcjY3bjdFTkt6OHdyWktRQzBYUXAwVUZRSVFnQ2pPUWREUFlZRGRs?=
 =?gb2312?B?cS9nNlJDNGJXVUZZQldLbW5Uc1NxQ3BTRWVaL2tmeTZiZE1NTEE3SHpzZVdk?=
 =?gb2312?B?bVFiUmR5YXh0dmtDenhaNHYwYmNVSWRQcGIxMEN1T3NtSmxSNWlWN2FZK3Vx?=
 =?gb2312?B?dkFXRnRXV0xSbTlwYk5YTFlTWUVWdGdpejM5bVNSd0EvV0VrZCsxejl0YW9X?=
 =?gb2312?B?ZDI0bVRDTmRJZEt0cW5iNndkSWhxdDBJc0R1Vlh3SUdFeGN4Y0h0blFHVkQ5?=
 =?gb2312?B?NENPMU9hdzQvWkN5SEx2cWNONERxbzZaQnJxSGxlRWxjOG5PbGowY08vSFl0?=
 =?gb2312?B?bnRJYXllUVRjMGg2UzQydjZZV0FGVUVaVjZNeFB1ak5EWks0bDZMVnJQSzZN?=
 =?gb2312?B?M3Y5bnFyVFowUVhjM09NU1hTYXp6US93b1dYNGM0ZFE3a05RSmIvY1RvRVYv?=
 =?gb2312?Q?mnu7jaE1zZo4fzE4vnmdlLCgtiREGE=3D?=
Content-ID: <C5F5509EA344574991AB31DEDE94ED83@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e04076-deda-4ee9-c46e-08da0bcd37af
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 06:28:45.6344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udydmWFYUASJhOXHfJqjWO616iEyJSrtAh4ZdzrXmtQ/JUNDwB9oxVm5MaseqrNPxcagCWniwc4RkNA69pqXajo5NM12XErWN2YLTywPefA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2315
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] creat09: Fix on more restrictive umask
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
Cc: xfs <linux-xfs@vger.kernel.org>, Jan Kara <jack@suse.cz>,
 Martin Doucha <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

on 2022/3/19 6:12, Darrick J. Wong wrote:
> You really ought to cc the xfs list for questions about longstanding
> behaviors of XFS...
>
> [cc linux-xfs]
Oh, yes, sorry for this. I have sent a RFC patch to linux-xfs and we can 
move discussion on that mail.

Best Regards
Yang Xu
>
> --D
>
> On Fri, Mar 18, 2022 at 10:37:03AM +0000, xuyang2018.jy@fujitsu.com wrote:
>> Hi Darrick, Jack
>>
>> Petr meet a problem when running creat09 on xfs, ext4 doesn't have problem.
>>
>> It seems xfs will still use umask when enable default acl, but ext4 will
>> not.
>>
>> As umask2 manpage , it said
>> "Alternatively, if the parent directory has a default ACL (see acl(5)),
>> the umask is ignored, the default ACL is inherited, the permission bits
>> are set based on the inherited ACL, and permission bits absent
>>          in the mode argument are turned off.
>> "
>>
>> It seem xfs doesn't obey this rule.
>>
>> the xfs calltrace as below:
>>
>>     will use  inode_init_owner(struct user_namespace *mnt_userns,
>> structinode *inode)
>>
>>    296.760675]  xfs_init_new_inode+0x10e/0x6c0
>> [  296.760678]  xfs_create+0x401/0x610
>>     will use posix_acl_create(dir,&mode,&default_acl,&acl);
>> [  296.760681]  xfs_generic_create+0x123/0x2e0
>> [  296.760684]  ? _raw_spin_unlock+0x16/0x30
>> [  296.760687]  path_openat+0xfb8/0x1210
>> [  296.760689]  do_filp_open+0xb4/0x120
>> [  296.760691]  ? file_tty_write.isra.31+0x203/0x340
>> [  296.760697]  ? __check_object_size+0x150/0x170
>> [  296.760699]  do_sys_openat2+0x242/0x310
>> [  296.760702]  do_sys_open+0x4b/0x80
>> [  296.760704]  do_syscall_64+0x3a/0x80
>>
>>
>> the ext4 calltrace as below:
>> [  296.460999]  __ext4_new_inode+0xe07/0x1780 [ext4]
>> posix_acl_create(dir,&inode->i_mode,&default_acl,&acl);
>> [  296.461035]  ext4_create+0x106/0x1c0 [ext4]
>> [  296.461059]  path_openat+0xfb8/0x1210
>> [  296.461062]  do_filp_open+0xb4/0x120
>> [  296.461065]  ? __check_object_size+0x150/0x170
>> [  296.461068]  do_sys_openat2+0x242/0x310
>> [  296.461070]  do_sys_open+0x4b/0x80
>> [  296.461073]  do_syscall_64+0x3a/0x80
>> [  296.461077]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> I guess xfs modify its mode value instead of inode->i_mode in
>> posix_acl_create by using current->umask value, so inode_init_owner
>> doesn't clear no-sgid bits on created file because of missing S_IXGRP.
>>
>> Is it a kernel bug?
>>
>> Best Regards
>> Yang Xu
>>
>>> Hi Petr
>>>
>>> It fails because the create file without S_IXGRP mode, then we miss
>>> remove S_ISGID[1] bit.
>>>
>>> But I don't known why other filesystem doesn't have this problem.
>>>
>>> [1]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/inode.c#n2249
>>>
>>> Best Regards
>>> Yang Xu
>>>> XFS fails on umask 0077:
>>>>
>>>> tst_test.c:1528: TINFO: Testing on xfs
>>>> tst_test.c:997: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
>>>> tst_test.c:1458: TINFO: Timeout per run is 0h 05m 00s
>>>> creat09.c:61: TINFO: User nobody: uid = 65534, gid = 65534
>>>> creat09.c:62: TINFO: Found unused GID 3: SUCCESS (0)
>>>> creat09.c:93: TPASS: mntpoint/testdir/creat.tmp: Owned by correct group
>>>> creat09.c:97: TFAIL: mntpoint/testdir/creat.tmp: Setgid bit is set
>>>> creat09.c:93: TPASS: mntpoint/testdir/open.tmp: Owned by correct group
>>>> creat09.c:97: TFAIL: mntpoint/testdir/open.tmp: Setgid bit is set
>>>>
>>>> Thus clear the default umask.
>>>>
>>>> Signed-off-by: Petr Vorel<pvorel@suse.cz>
>>>> ---
>>>>     testcases/kernel/syscalls/creat/creat09.c | 2 ++
>>>>     1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
>>>> index bed7bddb0e..70da7d2fc7 100644
>>>> --- a/testcases/kernel/syscalls/creat/creat09.c
>>>> +++ b/testcases/kernel/syscalls/creat/creat09.c
>>>> @@ -56,6 +56,8 @@ static void setup(void)
>>>>     		(int)ltpuser->pw_gid);
>>>>     	free_gid = tst_get_free_gid(ltpuser->pw_gid);
>>>>
>>>> +	umask(0);
>>>> +
>>>>     	/* Create directories and set permissions */
>>>>     	SAFE_MKDIR(WORKDIR, MODE_RWX);
>>>>     	SAFE_CHOWN(WORKDIR, ltpuser->pw_uid, free_gid);
>>>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
