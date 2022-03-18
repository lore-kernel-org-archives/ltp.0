Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBEFC433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 03:44:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D4463C94B1
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 04:44:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C69E03C1FF1
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 04:44:38 +0100 (CET)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B5FF46014F5
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 04:44:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1647575078; x=1679111078;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Wy4kUEArbKfUJ2qP9ne4v5o1YhWteF7mQAxlwjUeEPQ=;
 b=adLd0BFUBREXXx1vzGhsM6EWBybcO43euIuuDvjqOULpepbzv1lMn7ba
 QmMxnlBwhzQmYTQk8kv4TIpG2d1kB/TFhEWWLZqmaMgOIzw/0Zu3WtLbr
 04WpT5/pI/95fpukDHMGQhEuMfAn4kvJHtJpY5QTdzCz3Q8caSJB8X73H
 5GUaiAl7qYtMglymStpBXhr4VUKQDjyL3KxYdPGmZLnjuERbN/Be//xEY
 +bZ7gK7AehByfC4j4XapKuwx5othSNMesOW7neOIs5YFPhMSUPfawxp84
 qpwfVB+jgHxVA/moXZdfY/OI+3kL3dJYd+quIDO4/aM9UL4b1kSgMgWLk A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="51823050"
X-IronPort-AV: E=Sophos;i="5.90,191,1643641200"; d="scan'208";a="51823050"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 12:44:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YO7N0lc2VyQYOsCrUQZRQhAwP2UO/yAOKysK0lb6r/Iz4d12Pt72z7ncwkyx/eO+Re+SB/GEvmDJVjfgx4cjUMdTmTO6zJL8xmkQTMrAqjOF6JhG+X3dI+WLtdLP5Hw0tV8YiZFp3z1bvEe8tVq10Y0NTAQmGnvpf2cm/CGVMAFKw5OvgJOdUo+/U1EfhPZ9UsRWr79OrUuEusmYqNncLvF+JcpyIbaxO0WL4ACIn1HvLcxEEusHuwE4Tf9PI5Y0Cj+PSoWRQmy5js7dQH/g8VN7iAWRlJqKkJoiTiKRFr7p+ek+Z1k4Xpy6lHtKhwYExfJ/oCMu8KB4m4ssTkSsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wy4kUEArbKfUJ2qP9ne4v5o1YhWteF7mQAxlwjUeEPQ=;
 b=PPeHsdwnyuw+nhJHRENohnTDtMF6nfgqPIe53Nnwfpux+IwtV+aIC8v0n/zcqwPF6zZo9CdnXsfXHnyybToMGU0JK+FGoqLwE+Bk+7rG9a3JjgHCrVfC2CyMpG954XKD7vVw692npeuCQwCCakQ2X05lq/wlwlmEIEJSqJDX+NQQvLu1bIAUUy40PGtQXWqn6Q2EBPXZyO/QM+tVSlPCnuMK5CHhnIQemByODpYs/963Egl5eJJU3bwMKh97zeMeS/uEd+PusKKsdc0VibO5lhYAQRdcgYdIwbMtFOyWz+dTUlwlZOEp/5ywz8FcShh7DPWPRxmZxASTfq2q2pGweg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wy4kUEArbKfUJ2qP9ne4v5o1YhWteF7mQAxlwjUeEPQ=;
 b=W3oJMkzJwljUJkxQ/d3rRf7YMz9cWB3HXfCdODR93by+JpkJa7ScuR+LRGcQESJwagwBeDiXcRa9D83eb/y85QgQ2avW0PWZ4nNl59MyLYVZHFzLmK/hoyRqRN/pl3U+9qjNpURJVJpOSZAi46NJJltmQpzl+QlenIxCw6CYNg4=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYWPR01MB8854.jpnprd01.prod.outlook.com (2603:1096:400:16a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 03:44:32 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 03:44:32 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] quotactl0{2, 3, 5, 7}.c dependency problems on older
 kernels
Thread-Index: AQHYOnp6Rdqki5o5aEmNI3c9ituwXA==
Date: Fri, 18 Mar 2022 03:44:32 +0000
Message-ID: <6234004C.4030804@fujitsu.com>
References: <YjN+hsHidEX0ivoX@pevik> <6233F9CA.7060207@fujitsu.com>
In-Reply-To: <6233F9CA.7060207@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30e7c695-9bf4-4d03-1be5-08da08919d2e
x-ms-traffictypediagnostic: TYWPR01MB8854:EE_
x-microsoft-antispam-prvs: <TYWPR01MB885488F9ED906B067B796FE6FD139@TYWPR01MB8854.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ARnlBOz0pDSJAZzjiC9XurrkZByLmFIreKu+H+sHh1+sSij1Id+xnEKPbNfD31UeX9aGTs9T5fwmJvoW5F0ioGd6IjrIKPakVTZz6dLNaoDEa4WXd+XFZBxEn1cJR/9vQVNHQDGj84Vq+INQAuLQkmEJr7TAmHPAR0iW4/Sc8exQM0oIF9GWNWCml2ihwY6n8LiVHeORP8lHHOZ2t4nGS76rjX6NJrInrAso3JB288i3xuVKUQXyySJKM5Uo4G69hOyXvbeqHVVX9EP5r7in5H4jox/pY+6BTdRnNmc0cdkVlgXjh+kJumYGMx5fALuog7n1He/xKQHsg9EHGNGuWamCRdit2DLyOH6SOpOiqZaOuXGef2Pd0bZVuqt6wy5HWkvtV8J5dJk7539xbltu9f2xvy68vuNxhYACu0AIeI1hbGax+QbHNNSORRmG2b1pAxPed0r1pvDWx9d3N4SHNMJF7+qVaOmOR0wK2Jput3MgRWSYH7sgZ3NyrAyUGd8hnxGN0tSvVfjhcISai60OOyf0ysybYyUK1npCE8PGf7RdMuTB4m7d3sOYQUX5pGyuZYKelDCkWatsvD97zbuWU+tsAe/Cm8PCe/d6YqAfp5oVZO+shsYlnhS3RdlCXkxjhUtona8NVlBr3DzYPEAiJITtciVqVmEdUJFxK7dEJzVscN+5zAR21pBuyIlVnJONSZJmf1wbk2btmzWjCfhE0mpMGw7/9PrznhmQ+Cavw52pVNmN3v5B63KGZu0anWHpvkRv4DWn1Qq+yCTKnSs3DeS71d+O5Ja4rNa0Ze7vwdZiVv18pN5rwL3kSTviQxXPWwbkOMAoJvXy4z+HOCTvwA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(87266011)(6916009)(86362001)(6506007)(6512007)(316002)(83380400001)(508600001)(122000001)(54906003)(6486002)(85182001)(71200400001)(36756003)(186003)(26005)(5660300002)(38070700005)(33656002)(2616005)(15650500001)(82960400001)(8936002)(2906002)(4326008)(76116006)(66946007)(91956017)(66556008)(8676002)(66446008)(66476007)(64756008)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?anVqT3hNM2RjTXd0WmppdXZuRVFURWIySTM1aWVNVmF6OWFQYUdyN1JGT1RT?=
 =?gb2312?B?Zi96K2VCemdVWS9iR3dMWWx3Tm1OOGxaQThhVGZRV0JpbUJvd0tUeVJUckk0?=
 =?gb2312?B?dFF6ZzR0SlpRWnUzalF6MmovVXBXNjNUNU9yd1U2dDdFTGpzQVdDUUZYVFhm?=
 =?gb2312?B?NXlFMlhOR3U0T09IQ3pOMHdOSW9LTXZ3aDFhM1A1VEhuVUl6MTdqcTBHV1Z1?=
 =?gb2312?B?OU9DQXBTTDFoR01GYng4L0hFNHJsbGlSallKRlhvZW8rM0Z1QXAvenRPei9O?=
 =?gb2312?B?Zm9JYTdaUkRxNjVtYTNKQXYxaG9ROG5LS242cXRWKzVBRHFsK1ZOMVEralRU?=
 =?gb2312?B?Q0NrTzM3TC9qVUNpSjVwdkJoU0lGL2dtNi9vLzhVbGtnUVd2MmZGNkV4U2hB?=
 =?gb2312?B?cHBwSDlDVDR2UENZN3Q1ajg5enNsTXJQZGYrNGl6aHpCUG1CQk41MEVScURt?=
 =?gb2312?B?Uno2R0RhekRiWHl3M0w4YmIzOERJeTRDM2doc2FSK3YxeEpPMzRKUmxOZWt3?=
 =?gb2312?B?RXQ1NjNYZU05RU8yTldRQlVPT0NXWmg2UGJuRWFvUG4rdzBENnJRcWc0NGZt?=
 =?gb2312?B?OENJQU5GM1lQRDB5YlJCbXBwdndmOGk5UVJndG5zeEJxR250ampjbEM4RFVJ?=
 =?gb2312?B?UUYvUE5mUU9EblduenkwRUIxRWsxVitzcmNiRHFNam1nM3pYVDVzRUN6cWNz?=
 =?gb2312?B?WXF1QkNiUkJjWENDQituOW45dGlaR2pUMjNFaTVaZVpWNitzUjRvUTJDUEUy?=
 =?gb2312?B?bVJZeUhQMkdiRDM4dXNmRG1OSjFvY2hLWHljemp3TjZZL2V5T0JZQTFhYm0w?=
 =?gb2312?B?QVlaMFBYaDZHaXlVaGYzTmhON1A2bmlhcUFJVVVSQ2tBbFY2dE44WnVZQlB1?=
 =?gb2312?B?U3creGlESHRNcENLaUpkYk95cTNaNnA2YmJ6alFIdFlTL1JMU2pXM0pDMm9Z?=
 =?gb2312?B?YmJDWjJhREcybFozNzZ0aGpMKzh1cTRmSmFsaVFtN3J0eGQxdU5XVWJvNVJK?=
 =?gb2312?B?citTb0ZUZGtEeVdFUG5yRi9SeHhORGFsZW90aHo1aHdvc09YK29vRmJzOXhF?=
 =?gb2312?B?K3Q5NFV2WSt6enZUdmJ1OG54eGpsRkV1YjlnY0MwTGc0dVo0bTc1U0FtSzkx?=
 =?gb2312?B?M2l6NWwxNTBoQUpPTDZNdkdUOW9pdXlJdWhabGRuV2g2ZjZpbGtoSmNtSWg4?=
 =?gb2312?B?TlZ4SFhWT2VNSkxMZkVnNzJEaTNuMHpTbEdEREVaWDFWalZUd2hMWS9MM1l2?=
 =?gb2312?B?ZWFOd1pWRDVRckRUUm1kR0RWTzlZNGlLMUh5Mncrc1FnUS9FU3l1MUtQdnlU?=
 =?gb2312?B?SXhHdGJQSjZua0c0bjU2Y1hwZVRtSlFCOU5vcGRiSzdOUEdPR0h3aDU1Y1Ax?=
 =?gb2312?B?Z1VzRWd3NTRtYnozTWRxNnUvQzV2UzJEcEhUa3hnZm0xL214WGJ2Tk9EU09P?=
 =?gb2312?B?cjM2VytCM3dOeHNCODJWUXJwei93c25vc3dweUh1aldhMEpPcDZnclRvY01D?=
 =?gb2312?B?alhPM3doa3BEeG5mQld2L2JmSWYwVnh5YXV1bG41dVZxYWUvT2NYeTlzM3hz?=
 =?gb2312?B?UlByRHI4bGp4Mkx4ZUFROEVxalA5T1lVcEU4TE1UeDZWUHFTSmVudkFPQ3lS?=
 =?gb2312?B?ZFJQNDh4OXNMdzZCaytxbGpySndlK3R2VjRxdUpENFhLUDRZaWJBVkVuSUlG?=
 =?gb2312?B?d016d01lU2VYRm1aeEJoUjZ0NU1KeHVrbXh3MUZXeWhFd1NsTnc4cTRIY3A3?=
 =?gb2312?B?WXZyenIyVWJSejc1SzhKQUxXZTNreFZla3Y3RGpYME5UQ3RWZWlWakFKelYr?=
 =?gb2312?B?dk9LUG1EbTh0bFpFY2d6bXdOemVjRE0zK3dQSnZrbEVkTlMvVjJFa2FLSkZI?=
 =?gb2312?B?MFhYUFAzZjRDQWFaV1YxZExHWWNBdkVNSFIxaFR5QzdhL01zYVRrVWpLbGlm?=
 =?gb2312?B?blUxN0NTWkZJRVdLd3ZsUVlHRmJRNkt3ZENIbnhMWk1OM3ZnZmtaam8xMUph?=
 =?gb2312?Q?e0sgASgBeyOYBHxH67/7sApXhooqEA=3D?=
Content-ID: <3A379129E6D38842A27B7D903C1F4766@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e7c695-9bf4-4d03-1be5-08da08919d2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 03:44:32.6046 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Qwjs5pmnUkXX7XeCcAfbzL0G8E1Un7zZhLVUgpds7himKuSeUaTXJSxvgz0Ov5vuTylPe4XlbXCFwEcsvsf9JAQ0XDga+cF2da46j2ArvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8854
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] quotactl0{2, 3, 5,
 7}.c dependency problems on older kernels
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
Cc: "martin.doucha@suse.com" <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr
> Hi Petr
>> Hi Xu,
>>
>> actually quotactl0{2,3,5,7}.c and quotactl03.c fail on only on v4.5:
>>
>> tst_kconfig.c:82: TINFO: Parsing kernel config '/.config'
>> tst_device.c:88: TINFO: Found free device 0 '/dev/loop0'
>> tst_test.c:996: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
>> [  271.093416] XFS (loop0): Superblock has unknown read-only compatible features (0x4) enabled.
>> [  271.096902] XFS (loop0): Attempted to mount read-only compatible filesystem read-write.
>> [  271.100128] XFS (loop0): Filesystem can only be safely mounted read only.
>> [  271.101852] XFS (loop0): SB validate failed with error -22.
>> tst_test.c:1010: TBROK: mount(/dev/loop0, mntpoint, xfs, 0, 0x41d6a0) failed: EINVAL (22)
> That is because you use a newer xfsprogs (it provides newer mkfs.xfs and
> enable reflink feature by default[1]). But older kernel can't regcozine
> this feature bits[2](it supports reflink feature bits since kernel
> 4.9-rc1), then mount failed.
>
> [1]https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/commit/?id=ec1b42e6d58dcb7cfc5de6fc825832944997e176
> [2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=f0ec1b8ef11df0a51954df7e3ff3ca4aadb0d34b
>
> I don't think this is a problem, user should know its kernel version
> and xfsprogs vesion. Linux distribution has sloved this well except you
> used yourself compiled kernel.
>
>>
>> Tested on config:
>> grep -e QUOTA -e QFMT /.config
>> CONFIG_XFS_QUOTA=y
>> CONFIG_QUOTA=y
>> CONFIG_QUOTA_NETLINK_INTERFACE=y
>> # CONFIG_PRINT_QUOTA_WARNING is not set
>> # CONFIG_QUOTA_DEBUG is not set
>> CONFIG_QUOTA_TREE=y
>> # CONFIG_QFMT_V1 is not set
>> CONFIG_QFMT_V2=y
>> CONFIG_QUOTACTL=y
>> CONFIG_QUOTACTL_COMPAT=y
>>
>> But not work either on v4.10:
>> [  299.235456] XFS (loop0): EXPERIMENTAL reflink feature enabled. Use at your own risk!
>> [  299.239463] XFS (loop0): Mounting V5 Filesystem
>> [  299.240950] XFS (loop0): Log size 1368 blocks too small, minimum size is 1580 blocks
> In xfstests, we use -lsize parameter[3] or use a value then get the
> correct value from error log[4]. reflink feature will increase log
> size[5], so we can disable reflink feature by using mkfs.xfs -m
> reflink=0 /dev/loop0 (it also need mkfs.xfs support, so we may need a
> mkfs.xfs cmd version check[5], if meet this version, use mkfs.xfs -m
> reflink=0, if less than this version, we can ignore this version and
> don't use mkfs.xfs extra option).
>
> Firstly, can you try mkfs.xfs -m reflink=0 way whether fix these  two
> problems?
>
You can also just increase dev_min_size to 512 to check whether fix this 
logsize problem.

Best Regards
Yang Xu
>
> [3]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=7e07c4bebb08414ca8228ea91bdf57828fd4d110
> [4]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/common/xfs#n81
> [5]https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/commit/?id=a5132d9b3634fb6436d1f06642ceda82e64ea2f5
>
> Best Regards
> Yang Xu
>> [  299.243357] XFS (loop0): AAIEEE! Log failed size checks. Abort!
>> [  299.245183] XFS (loop0): log mount failed
>> quotactl07.c:58: TBROK: mount(/dev/loop0, mntpoint, xfs, 0, 0x41d054) failed: EINVAL (22)
>>
>> (the same config)
>>
>> Tests use:
>>
>> all:
>> .mntpoint = MNTPOINT,
>>
>> quotactl02.c
>> .mnt_data = "usrquota,grpquota",
>>
>> quotactl03.c
>> .mnt_data = "usrquota",
>>
>> quotactl05.c
>> .mnt_data = "prjquota"
>>
>> quotactl07.c does no specific .mnt_data.
>> but had .mnt_data = "usrquota" till recently - removed in
>> eb1cd3e922 ("syscalls/quotactl07: Refactor this case")
>>
>> I guess newer kernel is needed.
>> But checking usrquota for XFS it has "always" been there - added in
>> a67d7c5f5d25 ("[XFS] Move platform specific mount option parse out of core XFS code")
>> in v2.6.25-rc1
>>
>> Kind regards,
>> Petr
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
