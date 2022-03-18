Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F632C433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 10:37:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A486A3C94DB
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 11:37:20 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9B6C3C9435
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 11:37:10 +0100 (CET)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9B96D200D2E
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 11:37:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1647599830; x=1679135830;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=L6LQmH044WOe1oqM6kdcVDzZISeE4+XhX+iqSoIxPa4=;
 b=DrwvLfgzUrTuC7qFJedP7ug2Xs9G4aoURnACUxnJhfy+2uqXqLLS2xIy
 GuQp/s4h+bprRLnpcNKNR7QrLvh2/y1O9fwZqcsyXtq6f+yKXRIBmlRxw
 5f02mZvwEpYhomNc3msToEfNxvRvol24QlND3EpXZG7PHsX+fOfzq2jv0
 tzvdChej6WN4+VNWdbJAwx9jzFS1CIm2oDKqAedl59O7alxfFd+rtg/O9
 p57MKa6dQ1kig8EzSibVqZjjCLs0pB1lVnnp3jrggvBXBUtZcCWWJzg14
 YHObohfb7KFPBDRGIA51tDQ41jd/pUAsFykiewPbrZzEr2terxFC8dKlZ A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="52024357"
X-IronPort-AV: E=Sophos;i="5.90,192,1643641200"; d="scan'208";a="52024357"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 19:37:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpS3sySXuIuxsCM+hc+uCbYiMkz1s2ROkIlxWxu9tg5wR0GC5OQQ6HHlDZuD8/J3Ayz5xGem78TCjFyLikSiYn4AauFWlXLKokHiXDqTcHWB+WEZDEvGDGE6LmZKxM2sAXnPBXWpxoAdIgbFUnUTeUv5XnvMvIx6JB/NXxCrsMQJ0OXI9JSijjcgk2zKEkOxB7QLGcWa7v6bQFCgJzMQE92nTsqhNRHEACBIval9Q1Qbe59yeDanmm0atzQ7kURQr4if2yRwTX1VR5FZgCDK9tRbEJjBPM+BHHZ+bQdMBmcxJoMg/dvCllzFhdnJV4oRkF6ZC4nJirBpfpdrp9foXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6LQmH044WOe1oqM6kdcVDzZISeE4+XhX+iqSoIxPa4=;
 b=Y2tjK/a8tIXIEtbKBIntae1SA/7iFJMre/bZYgrMsOBqWMVHjL2RJuEjALKsHumkzH5TsuRbzMS5F7f7EoQTorSgZyWF9vkD2Rah+ygLe9YllMJaJWfP8DLGqEhUwvmDnzmTf35uMh9XqVu8oluhwoGB//Axp87ZWxFlQ7pIYfrti+eGicxbp6LR6JJIJ5yVrwInDRtO4ndIqJ6x8R7XSEa9dI2oeItMF+JArAGAn2CqwqYZz79HrAzi12s4hBHcF3PkGhQKhmaHOlvVsDKcU62PyuZRKEQAYx8PR1VQxhXpOdLhV0YeuadTC4rgXHtAEk125XXwJAZIM0edS83bjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6LQmH044WOe1oqM6kdcVDzZISeE4+XhX+iqSoIxPa4=;
 b=XUlXpYZEnupPpNx9azwA1K769eq6IoAh4Z1t0T9n7QZlzxoe88pURQTQ/C0jQltFGUGuEF9+KTWeMpkyn+5RkXPdyhNru01qOKV833aySx+eZV6uLO4P/0MItKJcX0GCNgNqkLNo8DJHaJUucN90iK6i2pR4GAYGgCpv0kJ3/Uw=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB10166.jpnprd01.prod.outlook.com (2603:1096:400:1ee::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Fri, 18 Mar
 2022 10:37:04 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 10:37:04 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>, Jan Kara <jack@suse.cz>,
 "Darrick J. Wong" <djwong@kernel.org>
Thread-Topic: [LTP] [RFC PATCH 1/1] creat09: Fix on more restrictive umask
Thread-Index: AQHYN9eJWCFPwI5fE0G2efRMRz6TPazEzJUAgAAsKIA=
Date: Fri, 18 Mar 2022 10:37:03 +0000
Message-ID: <623460FD.8070500@fujitsu.com>
References: <20220314191234.12382-1-pvorel@suse.cz>
 <62343BF2.1020006@fujitsu.com>
In-Reply-To: <62343BF2.1020006@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19bceb14-9b0e-457b-f50e-08da08cb3e22
x-ms-traffictypediagnostic: TYCPR01MB10166:EE_
x-microsoft-antispam-prvs: <TYCPR01MB10166E6F497620B00115A95C3FD139@TYCPR01MB10166.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 36sj9l7DTYGlPNhOf8daiRlAtWEaBJA+vvaqTDEKTrusLabwBxukEF/GltWJ1iw4ESJAypZ5pHL+Pe65CwwikKaLGdicrKkxeVTARurLFpOqj/udjXUdzr3iT6nahj7NkCMyOo9c5iTrd8Dc0MXsHFUwqD14NmyaFGWOLORBUF+Zev46X9Hc/JIXp3GeT+CC0VXRNOaAo6AXlS78gxeO5HX/fUOq9Nvuc10Y3at5Gxjhj3KKNVHS9BWTpl91YjfB4u1WkkG1rYVcqdkZHgLIyszbv/+PUGmDktDeQhE2wJgtPdcGo9yY4j0Gkj5fo64gLeGo5on/q2Ld8ZUhaMddl0dRO8j5kA71ERNxBR+Z3Qw0ysaPG7YyCkr3ayFD3XBEOd9tBph7uu2PXzQWUCGd6I5okPYHS9gd3pXRzL4lii/ri2wAcEywnSlIocFipZgnDQEsDYWHqcMH3s0IxWFxI4JX3iZRMFsnGkU0KqXyunR3QTC8T8/6HsqR2BDv/QrIOHGxuqHg5rp75kMiMR+nmjpbUFRWoaPwbaks/ZpOCJhMp30Bm/PXQVTzcoJMBtofGcnwAZmL/NuEwWQ+tP1YX3xIc8ZI7+OhaYuyQkGbFQ63LzY7sblQaKNZPkEMD6Mh8LpDHOJjo6RgonpUkQIveVzS4VCkBwg+cRog8n+jfcLGFzMoenMB00Y8xKIzKqONbB11UuCNyDCMMhVinevfz6bV4hRvtQQZ8lOJkzQr3h49fIeKrPwoErvAI5uUy6p6I4kZvbDfJTkVOt/uTd82M2twL2YgRKuQdN2k7CJOqi8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(38070700005)(38100700002)(33656002)(86362001)(82960400001)(508600001)(5660300002)(966005)(8936002)(87266011)(6506007)(6512007)(316002)(54906003)(110136005)(6486002)(4326008)(8676002)(71200400001)(91956017)(64756008)(66476007)(76116006)(66446008)(66556008)(66946007)(83380400001)(85182001)(186003)(26005)(36756003)(2616005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dkhWc1l2MTBhNDNVaURIQ2VyRSsvK2I4STA4MmhnblVQeWUzMTRlUnZwUGpE?=
 =?gb2312?B?TkQ3bGxLK3kwbEZyR1dvd1lOT2RZMUJmSG85cTBZQnZOUFlJb21TcmM3bkJK?=
 =?gb2312?B?Q2dtSWZldDdUaDRFTDJEb0Y2Q0RCY2dRcEVEdzA1Yms2R0JhTXZRNDZpUlVZ?=
 =?gb2312?B?VDJnS0pIemRnbGRBRHNLYnRNZnI5MGlROGczcnF3S0lUS1BxVkpXcTFSVUNx?=
 =?gb2312?B?MDBhOXd4R1A0WXB0dUFXeEo4VFhFWWdERWIrUGkyL00zRXhaUitDYjAzbVl1?=
 =?gb2312?B?WFI5a0QrbllHR2o3cm5neWR5T3Y4UFFQUVd2OG9wVnJBY21md1ZaYXdDQnZt?=
 =?gb2312?B?T0xwQ3Frd3VzcTQrdWh1bzhaY2FlZnd4cHVheVFjL0t5b1F6enJNazAzUS9h?=
 =?gb2312?B?bDliUVJLTStsOWxublJqVUd4TTlRam9haFV4d09ZN0dtR1F0dmJwdUpwYzFH?=
 =?gb2312?B?WXZGVWw4dE1YUC85eEpnQkR3cCsvc0M3WWpLR2cyTUt6bC9pc2NjOHIrU2xo?=
 =?gb2312?B?Wk15RWRqaWU5NVIvOGxDYnYyd2FBanIrTjVNeWNLUGJOblBpMzhka0J2cWlG?=
 =?gb2312?B?aHZQVVJJRGxmSE5MS3pnTFU1eG9hYk1sRHRTSkxSeDB3L1FlVlZ6ZG9RbDA5?=
 =?gb2312?B?b1czeDdmdjFTRlFRK2RmcTVNaFBNdWN5R1I1WjlwWDVpSXF6RkRCcTBJY0lX?=
 =?gb2312?B?dzlyaTBacFo4VGNQamZ5SWJ3Z3VyYWZIL3JmbWVKVThFQmlkdW5VcU1QUndL?=
 =?gb2312?B?aXVyejZzaHZpM3lRclNuZ1h6TWNUa3pyaSs3d0pnUExWQlpWazVXUXh2Ly9D?=
 =?gb2312?B?aVk2MXBVeTJkOGVhdmZDQk81N0dqNjV0TlhZNVNCaDVOZ0l1UUZVbmVQNVE5?=
 =?gb2312?B?WE9URktablBKMjZpWS9yYUQ4Q1ZzYlViSVBiNzRFR1p0cHFuRk1uMGg1cHA0?=
 =?gb2312?B?eFo1SkJBdHQvWlluT3ZZRkw0V2MrZ2lOdG1yTVhUcEVNa0lrRHM3WWpkOWZh?=
 =?gb2312?B?bE9LMXRha3ZSQk93ZHNEN0dvTHRhWVFmMkZwQ1FiUWk5SFg1Rk81V2dQSWVV?=
 =?gb2312?B?dUxQVEVCektuanlweGQvVEJUTDVoTGdKWFpHYThhazZtOHliSGdjNmtBR2w1?=
 =?gb2312?B?Qys0TTFKYWpPSUZ4WG93a1lrd0VqVkNvK2Q0clZMTis3MHVCbUFoemwrOVA0?=
 =?gb2312?B?TWZpNzFvbi9rMVVSOGFSSFlTOU1yYUtISVBXVFRqc0Y5bUt2NmhOdmFPS1pX?=
 =?gb2312?B?R1hpTFBlTEdXaDBrNDNKa2ZKRmhkZmI5MnpYMU9lZFlRN3dycndOWllDSFl4?=
 =?gb2312?B?OGNGM1RQNGJoWkFyNFNMZGRLanZ5Y1ZMT2VLSW5OVldJRGRiYW93Z3lPNU5m?=
 =?gb2312?B?N2pzK0xlMUtTdUIydHIxUTZ5MXk0VFJQRnJRbzVsRnpRMW9UUWFwN01XU3NE?=
 =?gb2312?B?VlQwWGZCSUNReUpyTytFdUZmVmR3ZWVscXlKbTlvWmpsWWpTZlBITzR2dUpR?=
 =?gb2312?B?eXdSNzlIUU4vbHZPcnNCTHFBeFZVdkRLcGZxL1RPVnVOeHcySVRVQnJxWkNr?=
 =?gb2312?B?VzV1Q2RaWDlERHRVT290OUc1ckNaaWdIUTJ6dWxWSDRJR0Z0Uk11bEJQZE9B?=
 =?gb2312?B?UERXRUIwQkJML2F5TEQ0clcwUlZSejd2WUxiL0dkaDg2YlJqOE91SnRmaDl3?=
 =?gb2312?B?a1RoUXZDN0FpdjBVTjhBd0wxRktJMzkwMUNQZW15M0xmbUhzZWFxLzQvYnhD?=
 =?gb2312?B?R2hibWp1Q1VYSlFzV2dHUDNGcm5zWmtLN09lYzQ4V2twYUpreUU5OHlsYXdB?=
 =?gb2312?B?R09WZkVZeG90bXY5WVc3VWtXMk53ZUdNNFczTlpVZmd4NXg1M3FQdTdqaDJx?=
 =?gb2312?B?eWZ0QWtrM1dqTUZqa0hmbi9DTVFGMzlnWWx2cUVBZnQ4WnVCNGRpbFZ0SDRS?=
 =?gb2312?B?cVh1SEZaNDJzZDJwU2VsajAyUHdoc3llbnQwTlNJR2xLTVFOVEl5STJBQnl2?=
 =?gb2312?Q?QjU6/xZEGnyCzfgIMZJoBmMKCbuxg8=3D?=
Content-ID: <B3BE903025EC9E409AE06B6DA09B92B4@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bceb14-9b0e-457b-f50e-08da08cb3e22
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 10:37:03.8802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V4I5BBohRWqM6iMFrE/xczRLZd2fRC0Mjzyme1cUsBKSykw82YAbcYGM4v8D47DbLXx8jZHiY4ADDc3NUB4t9pzLLZ1Wx8aaaH4cKUR9KQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10166
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Darrick, Jack

Petr meet a problem when running creat09 on xfs, ext4 doesn't have problem.

It seems xfs will still use umask when enable default acl, but ext4 will 
not.

As umask2 manpage , it said
"Alternatively, if the parent directory has a default ACL (see acl(5)), 
the umask is ignored, the default ACL is inherited, the permission bits 
are set based on the inherited ACL, and permission bits absent
        in the mode argument are turned off.
"

It seem xfs doesn't obey this rule.

the xfs calltrace as below:

   will use  inode_init_owner(struct user_namespace *mnt_userns, 
structinode *inode)

  296.760675]  xfs_init_new_inode+0x10e/0x6c0
[  296.760678]  xfs_create+0x401/0x610
   will use posix_acl_create(dir, &mode, &default_acl, &acl);
[  296.760681]  xfs_generic_create+0x123/0x2e0
[  296.760684]  ? _raw_spin_unlock+0x16/0x30
[  296.760687]  path_openat+0xfb8/0x1210
[  296.760689]  do_filp_open+0xb4/0x120
[  296.760691]  ? file_tty_write.isra.31+0x203/0x340
[  296.760697]  ? __check_object_size+0x150/0x170
[  296.760699]  do_sys_openat2+0x242/0x310
[  296.760702]  do_sys_open+0x4b/0x80
[  296.760704]  do_syscall_64+0x3a/0x80


the ext4 calltrace as below:
[  296.460999]  __ext4_new_inode+0xe07/0x1780 [ext4]
posix_acl_create(dir, &inode->i_mode, &default_acl, &acl);
[  296.461035]  ext4_create+0x106/0x1c0 [ext4]
[  296.461059]  path_openat+0xfb8/0x1210
[  296.461062]  do_filp_open+0xb4/0x120
[  296.461065]  ? __check_object_size+0x150/0x170
[  296.461068]  do_sys_openat2+0x242/0x310
[  296.461070]  do_sys_open+0x4b/0x80
[  296.461073]  do_syscall_64+0x3a/0x80
[  296.461077]  entry_SYSCALL_64_after_hwframe+0x44/0xae

I guess xfs modify its mode value instead of inode->i_mode in 
posix_acl_create by using current->umask value, so inode_init_owner 
doesn't clear no-sgid bits on created file because of missing S_IXGRP.

Is it a kernel bug?

Best Regards
Yang Xu

> Hi Petr
>
> It fails because the create file without S_IXGRP mode, then we miss
> remove S_ISGID[1] bit.
>
> But I don't known why other filesystem doesn't have this problem.
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/inode.c#n2249
>
> Best Regards
> Yang Xu
>> XFS fails on umask 0077:
>>
>> tst_test.c:1528: TINFO: Testing on xfs
>> tst_test.c:997: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
>> tst_test.c:1458: TINFO: Timeout per run is 0h 05m 00s
>> creat09.c:61: TINFO: User nobody: uid = 65534, gid = 65534
>> creat09.c:62: TINFO: Found unused GID 3: SUCCESS (0)
>> creat09.c:93: TPASS: mntpoint/testdir/creat.tmp: Owned by correct group
>> creat09.c:97: TFAIL: mntpoint/testdir/creat.tmp: Setgid bit is set
>> creat09.c:93: TPASS: mntpoint/testdir/open.tmp: Owned by correct group
>> creat09.c:97: TFAIL: mntpoint/testdir/open.tmp: Setgid bit is set
>>
>> Thus clear the default umask.
>>
>> Signed-off-by: Petr Vorel<pvorel@suse.cz>
>> ---
>>    testcases/kernel/syscalls/creat/creat09.c | 2 ++
>>    1 file changed, 2 insertions(+)
>>
>> diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
>> index bed7bddb0e..70da7d2fc7 100644
>> --- a/testcases/kernel/syscalls/creat/creat09.c
>> +++ b/testcases/kernel/syscalls/creat/creat09.c
>> @@ -56,6 +56,8 @@ static void setup(void)
>>    		(int)ltpuser->pw_gid);
>>    	free_gid = tst_get_free_gid(ltpuser->pw_gid);
>>
>> +	umask(0);
>> +
>>    	/* Create directories and set permissions */
>>    	SAFE_MKDIR(WORKDIR, MODE_RWX);
>>    	SAFE_CHOWN(WORKDIR, ltpuser->pw_uid, free_gid);
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
