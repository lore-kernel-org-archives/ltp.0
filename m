Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D77C433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 03:17:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FDE43C94CC
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 04:17:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7B413C1FF1
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 04:16:52 +0100 (CET)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D4E6A1401150
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 04:16:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1647573410; x=1679109410;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=8Idy2YgtUOw0bEPfBcXYTOlTJPlSAY6W2QUOMnWw8MU=;
 b=NllUhaEL3R3lC3xoQuRgrnJOles2h43mUp9OMnLgqZVLms99/gc8cF1V
 081XSY1v9xef9Y8R8ORdJPAP7xLiK+obvIOPHmjk4uFs2hgtngkc8gq1R
 n3+OLBY9RsecKAfDW9DC+28zH2zgf6RYJA4ie3LU/9j+Kcj+5c+ATEtIA
 jrDfkLPNXTe5Pg2bhIen8rIJ62aMIlOUQZsLeyazVIXX/ysT7mH8M1xP+
 zY3bNGfeu0hpWqda+NSaWwpHK2w0MsRPIFQWmjRHz8KGxBal2bu217FsY
 zBrCal5YVs19j8n327XocpwyD8unCVindPDWkUzk6iMNR6cu+M7NPb/jP w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="52328267"
X-IronPort-AV: E=Sophos;i="5.90,191,1643641200"; d="scan'208";a="52328267"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 12:16:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gL/xinH4n2IHCE+bhm2aSusPsxMFSSNpiIXAFDxB4wjhEo7cjyf67RHua45iamYMtMKioHHx7yrUcnzPgiAQjpWIKbTU0bNOyZTtvLUEvfvRqrT+05vVPJMWm8/eEmDm5qAqpsDEZDbt49LENFSIIIJtQR4Mt30omrMwsM+b68ZJO2QF3jea0ABBGvMdkgIxNHxi9fJtb2qbSEsmjh+797VU6oH87AKCI9PUuGYcyQR2GLWgDd+Kz/YA4A8J7+oZijYPnM0+WH33EW+xIVbdmjQM8FcluZ2wC9A8PtCuAiTBZFAe8V4NN9/0dnHfE5lkIwEIsGdUZ6EgUF1twxCrgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Idy2YgtUOw0bEPfBcXYTOlTJPlSAY6W2QUOMnWw8MU=;
 b=TfK9zV7+sKI7C/9z4gisfZ6nsD9yLCCH975uiDTvh0AHYNX3fiFOuHuthtWl3iGbvdDbAusGaZh/Ujv6R6KtBON9qfBi2TtyD7JwgxzEhVCBgfgD5CmPSz66GS5IplDBCg+oyuZqI/tSK5o7Gpk6zKMYwvZp8lNb1vmA5bsEe3oGpWO1d0+szCftMLZKu5s1U3a8iuLdTwGw+sbCNLf9qiqiX+E8HLURxP4LG2Xnp7Gg6NJP5WeFRjFO3uRXmMkeSneS1bc02tLML7yD++Er1cu/FCAtkygrdj2fgxy+6rTLGFiB5/pqR7Mtj7buUCHxDiPVQLDoH6N/mnMcZjC3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Idy2YgtUOw0bEPfBcXYTOlTJPlSAY6W2QUOMnWw8MU=;
 b=JllKBQK5hh5pFf2PUkVBUBFy36y4iIZ3GojCXaKsQkKPs52reRVxJghFSR/uMplGBaOrlSbuTsVTW4PSGaGC0ExOFrg47zivia/RWg6iWEhpvZTdjt0gQiUWK/zDanimJgn+9bW7vQZJvZBXVXv7hc4MrsWPOK+P+lXrFgMwVts=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSZPR01MB8187.jpnprd01.prod.outlook.com (2603:1096:604:1a6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.16; Fri, 18 Mar
 2022 03:16:46 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 03:16:45 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: quotactl0{2,3,5,7}.c dependency problems on older kernels
Thread-Index: AQHYOi0//5NDP651TUOeP8SQ89fj5KzEeQwA
Date: Fri, 18 Mar 2022 03:16:45 +0000
Message-ID: <6233F9CA.7060207@fujitsu.com>
References: <YjN+hsHidEX0ivoX@pevik>
In-Reply-To: <YjN+hsHidEX0ivoX@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe3454c3-dfb1-4a3d-c44e-08da088dbbbb
x-ms-traffictypediagnostic: OSZPR01MB8187:EE_
x-microsoft-antispam-prvs: <OSZPR01MB8187B0D35FAF068BC2919AFBFD139@OSZPR01MB8187.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yoMANkUv8qV037/+ef63uzyl2PEJMtZjz57oFRI01zewhdkwkwkiZOLA3kIbVwdrZnMAnSQSdqiGtx907WLptLI0l6AHUIZ1Ia7QNcydCIHLlzXeKELnMQzF5eIWsKnBsMF/ne6CDYpb27grtekhG4lV2kOKRhuncHmHi9PDgeBC8trwfziGFm6hrn5Sxvj960sWX53ZXSXld1sSAaeJkTcgIaUtDV0liUkDS+YWhTPr2+bxDeOz+TN9K3B5VQ988lw8b43+rzPg3nLk6m3Hru1iFLLCbIFc7AvErLCl7GX169hQq2mjvWqivQQZhhjSTngLfG2kfED7gPoQg2wAYbv4HNLCMK5wsmpWoeYmPlAuWO5+eshW9XGm/fJTKC38VJgqam5qGBNZpbp9RkbQC1BFyH4A25C1d9Xys5/FShNZJ82g/BiO35KHlu4fBQ5RW0T+vuBiJAPCvbflee/GhMF+BSAAeLTfAvAZTFhjPKmsFWDBb9NNyHbE8oOOBvdcJIeD4rtWIwysp85muyunbxPzRP2+KETY/uIeCeF+usRTZxaEEvMGmRpskThzYxaGb5CDJdpNvf+WD+7/npSXg9aIG8JM2yTE4X3ECMDLH8kDdw2/ZhzP3ApxlT8sTAWb2X2cMwONmdS7RSnOQjnwNRwLXWEhEw+QB/KB7AO8gbYTBnvJMut5KakWC4Row6UqE9WQCf8fiVLIdFbVxhwle+6/HfztD71ZOgv71hS49JSR7kTF+NqszddDOeWqQhB7xcoBLsIgJdxzDUfdRT8vrBlgAX2ycRl2vWBo2SKQhRe577Sqp1FswLJlJ1BTKhoMcpgWGQlRjWpGdv71UAUmJg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(76116006)(2906002)(15650500001)(508600001)(66946007)(8676002)(66556008)(6916009)(54906003)(6486002)(71200400001)(36756003)(66446008)(66476007)(64756008)(86362001)(6506007)(85182001)(33656002)(87266011)(2616005)(6512007)(316002)(91956017)(26005)(186003)(83380400001)(4326008)(122000001)(38100700002)(82960400001)(107886003)(38070700005)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MVM5aTFBYmVVRGJGN3gxbFFicXNJblZQenhnMkZQNlNBWFhWRDVzdWx1QVla?=
 =?gb2312?B?UWRJbit4SVl5M285c0NvWlc2MWJKOHM2eHVYZU1XZlozbm9hNUNkSlM0L3Z4?=
 =?gb2312?B?dndJVUVxRGpWWlM3UzVqcUZsa3YxNDBiNGxwLzJzc3BjcmZtK2FNaW9NRVdk?=
 =?gb2312?B?WHF4RG9ZZnVuSkNXejRXbm04QTFWVzhTLytZZ3BWUkNBUHc4ZURVQ0FrTGdx?=
 =?gb2312?B?cTdQdXpUVzdyenJkdmQ0TWZ4M3dWTW1jS3BQODhwWHBlODFhYW0zbmFzZmJ0?=
 =?gb2312?B?L2NNNjNDVGFOOUtLSnpabHBQWUpBN21TWXpKY2ZqTGYycnpLdGVib1NndWpt?=
 =?gb2312?B?SDZ4L1dyNnBld1NhZkxseDF2cGpnNnBtc3JoL0ZUWHBUeFp3ODkzRVkraE9C?=
 =?gb2312?B?Z29TR3l0UzkvSVZoRHVZa2QvWGxLcitBaTFHeXNkK0ZXNG5iOEV0Y2ZxbnRr?=
 =?gb2312?B?L1BLODhOY0xZdkJhOHhKUGtYTjN6UUtra2FvbFpPeVZTVEVscit1NlZNcEpP?=
 =?gb2312?B?eXZCYWxNaWxNMkpNWld3TlJEOXFLNjdqLytvd0JacHNqRWpkNFFvbHdndFVn?=
 =?gb2312?B?SjB1d2ozNFF1WG9RUjV1UElTOWwzSE5GU2FDNXdCUVVueG14dEdLTFhrc2Y1?=
 =?gb2312?B?b1R0YjAzNDVLTWRSeGs3UlVvTzJyUjNwQkJIQUliQ0I0VTY3NE1Iems1Skty?=
 =?gb2312?B?R0svcy9qOVNRTnVSMFRrcjZReGxMSVFTUERSYmpkZlZ4SzBTdTlQaGhWaTF3?=
 =?gb2312?B?Y2RRRTh4Tnpnd1NxNkNLQTlyN1h5ZWxGRVBxdDBla1VjeG5YWUxRcVlOelR2?=
 =?gb2312?B?QlUyZTgxUm00NnRhQ1ZoYzdaeXg1MlJFVExRNWZNSUhFVS9wbEt3SUlycUh6?=
 =?gb2312?B?eG1qOXZnbzl4ZWl2MjlGTU93MzZpdmE4TVpUWlNEUnFvYm44WnhNSGR5Qk5M?=
 =?gb2312?B?ZDE1VzlKUVd6UzRTbktJaGRGMUlEMkNMdTJWQXo2b0U4TFl5SFRiQVBVRnRC?=
 =?gb2312?B?RmxBeCtjclMrR1Z3SlJOQVduMFRIcEhwZm1DWDV5VWxOTFhrWFJ3UkYway96?=
 =?gb2312?B?VDExYm1PckhDUkhLeDVOeXZnV1NCbWdKUXRYSi9uNDQxY29nNzlzUFpKcVB3?=
 =?gb2312?B?cXJFbDgyYmJ3dE5BUENMREc5aFlQWFZaYmF6QTZtMkN2Vzk1UVdIYUN4SEtl?=
 =?gb2312?B?VWxOZnMrUzFpcklveHJZQUVGblg0ZC8zR3dhenh5ZVQ2Yk42WG0rZjczMVMy?=
 =?gb2312?B?clFFRTlwRE5ZVDhBQTQrUk1vMWh1V3IzTHZYMlMxUi9IWCtKS3NZT1VBVHhW?=
 =?gb2312?B?U01EQldSbUZjNlFnd1M5bEhCUXpNb1c3R25zOHFhNzBiWTBxdEZRcytvUTUz?=
 =?gb2312?B?TXB3RytvbndnZGt1NGdyOE5JclhNTzVLVUVUQjAyMlBSUGV5WVU3RFRyL2xh?=
 =?gb2312?B?ODZtT290c0JBZWlpN00vV1VVcFU5dWt0dG5FRDZmdGppcUhkR1A2SEh3TWRD?=
 =?gb2312?B?NWZrV1dUZG5rNnFOYTFka1paOS96REJtNWVjVTh1WDVXc0JxRXBJcU9yWWZM?=
 =?gb2312?B?L2ZQNXR3STdJemI0Sk9XcUhQV2lGNEpUNTUrYVg1dmpsbkZFV1RSZnIzN1ZM?=
 =?gb2312?B?U0NYc2JUbFcrcTBhU2NtNnpSOTJxUmc5RzdLcXdodURGYnF0TXQ1SjNYQldt?=
 =?gb2312?B?MDYwaHNpd3ZGTnVaWktMb2k3OGdUa0ZCVHJBUlNSNDBEV2pXQWxWazVtK3pC?=
 =?gb2312?B?YmU5UzNPcUhVelRzMVhFdWJ0RjN5OGpsaU9icXhBQWhsV0N5bW11QnUzQlUx?=
 =?gb2312?B?SW0vQjgyUXJxRitUSnJXcHZRV0hHU28yZjJiMlNpVEZORTVsQnFVTnFFRU9r?=
 =?gb2312?B?MmpiVThhYlYzS3hDVXNOdk1Ea01sOVN3RFp5RzF3STRxODUycmFRL3M1RjIz?=
 =?gb2312?B?eWpINEZXL0RPWFJJblZscmg3NHZYdVlBa240Q0lqa3YwVEY4U05ZMFBQZklG?=
 =?gb2312?Q?HIVXSS2mhSyWEd3pNUlN2v4+OhJ82U=3D?=
Content-ID: <4E9EDB777E91E140809E7985465204E7@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3454c3-dfb1-4a3d-c44e-08da088dbbbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 03:16:45.8777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1xmD3CxpjnRzkRrizXExheCRxVWT6ambay72/M8yMuk2wt1k1Ls+i0hba+RY/JXgZkcD4zzRKtlrDp1yBX5AB4ac/AOr29poZdHSz2j71qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8187
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "martin.doucha@suse.com" <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr
> Hi Xu,
>
> actually quotactl0{2,3,5,7}.c and quotactl03.c fail on only on v4.5:
>
> tst_kconfig.c:82: TINFO: Parsing kernel config '/.config'
> tst_device.c:88: TINFO: Found free device 0 '/dev/loop0'
> tst_test.c:996: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> [  271.093416] XFS (loop0): Superblock has unknown read-only compatible features (0x4) enabled.
> [  271.096902] XFS (loop0): Attempted to mount read-only compatible filesystem read-write.
> [  271.100128] XFS (loop0): Filesystem can only be safely mounted read only.
> [  271.101852] XFS (loop0): SB validate failed with error -22.
> tst_test.c:1010: TBROK: mount(/dev/loop0, mntpoint, xfs, 0, 0x41d6a0) failed: EINVAL (22)
That is because you use a newer xfsprogs (it provides newer mkfs.xfs and 
enable reflink feature by default[1]). But older kernel can't regcozine 
this feature bits[2](it supports reflink feature bits since kernel 
4.9-rc1), then mount failed.

[1]https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/commit/?id=ec1b42e6d58dcb7cfc5de6fc825832944997e176
[2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=f0ec1b8ef11df0a51954df7e3ff3ca4aadb0d34b

I don't think this is a problem, user should know its kernel version
and xfsprogs vesion. Linux distribution has sloved this well except you 
used yourself compiled kernel.

>
> Tested on config:
> grep -e QUOTA -e QFMT /.config
> CONFIG_XFS_QUOTA=y
> CONFIG_QUOTA=y
> CONFIG_QUOTA_NETLINK_INTERFACE=y
> # CONFIG_PRINT_QUOTA_WARNING is not set
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QUOTA_TREE=y
> # CONFIG_QFMT_V1 is not set
> CONFIG_QFMT_V2=y
> CONFIG_QUOTACTL=y
> CONFIG_QUOTACTL_COMPAT=y
>
> But not work either on v4.10:
> [  299.235456] XFS (loop0): EXPERIMENTAL reflink feature enabled. Use at your own risk!
> [  299.239463] XFS (loop0): Mounting V5 Filesystem
> [  299.240950] XFS (loop0): Log size 1368 blocks too small, minimum size is 1580 blocks
In xfstests, we use -lsize parameter[3] or use a value then get the 
correct value from error log[4]. reflink feature will increase log 
size[5], so we can disable reflink feature by using mkfs.xfs -m 
reflink=0 /dev/loop0 (it also need mkfs.xfs support, so we may need a 
mkfs.xfs cmd version check[5], if meet this version, use mkfs.xfs -m 
reflink=0, if less than this version, we can ignore this version and 
don't use mkfs.xfs extra option).

Firstly, can you try mkfs.xfs -m reflink=0 way whether fix these  two 
problems?


[3]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=7e07c4bebb08414ca8228ea91bdf57828fd4d110
[4]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/common/xfs#n81
[5]https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/commit/?id=a5132d9b3634fb6436d1f06642ceda82e64ea2f5

Best Regards
Yang Xu
> [  299.243357] XFS (loop0): AAIEEE! Log failed size checks. Abort!
> [  299.245183] XFS (loop0): log mount failed
> quotactl07.c:58: TBROK: mount(/dev/loop0, mntpoint, xfs, 0, 0x41d054) failed: EINVAL (22)
>
> (the same config)
>
> Tests use:
>
> all:
> .mntpoint = MNTPOINT,
>
> quotactl02.c
> .mnt_data = "usrquota,grpquota",
>
> quotactl03.c
> .mnt_data = "usrquota",
>
> quotactl05.c
> .mnt_data = "prjquota"
>
> quotactl07.c does no specific .mnt_data.
> but had .mnt_data = "usrquota" till recently - removed in
> eb1cd3e922 ("syscalls/quotactl07: Refactor this case")
>
> I guess newer kernel is needed.
> But checking usrquota for XFS it has "always" been there - added in
> a67d7c5f5d25 ("[XFS] Move platform specific mount option parse out of core XFS code")
> in v2.6.25-rc1
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
