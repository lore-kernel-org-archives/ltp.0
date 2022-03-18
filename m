Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2176C433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 09:26:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AAFD3C95C4
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 10:26:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D54B3C6355
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 10:26:20 +0100 (CET)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 408851A00E02
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 10:26:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1647595579; x=1679131579;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=iJgJK9fUbmJYkG5nzlajslK0h8fAxbDRCoMiKS3YNeU=;
 b=PYNOTkGtnOtkj48zM4hBYq0RJX1qYyBWo0vlgwJ9RcUlumEVpCbJ/OvZ
 UKQSChlwRENhE2LaiRdHp5bfwSWwB3kfpii3UyNRaSG3iCiF2QapgMINj
 d5zOTlet255c1XKbyBW470mSbMp+Ksu0naWSafQ6awuWqp67y8b7ak8w9
 /HUoelDVoracutdgUTlc9wKMPMxObmijTZ4b/c4BNN7pat/hol2hFB8G1
 Ln2aJaUvac2TJNyouS4SxNJgP33KaLZ7btMF/oEHl/NfnqV2pUYtnLQ3F
 BAf2hlu+426xOZ0aCpTqXFrRKeoV37FiOW9lYwtXU6jr7J/DAWftLHM4E A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="51724254"
X-IronPort-AV: E=Sophos;i="5.90,191,1643641200"; d="scan'208";a="51724254"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 18:26:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hwltdf54fa9XV7vq3tbUksxWlajJ3kRZ2NtbMBgCKKhLt8R95OgaLyGcdD8mJ9F5UWx2wqZjOPUStAFSb9eWiQm6eAJ8S6z6TNcFyqMd+iQGRp8d4tBIKhA//WYtP9qlJnur5x9bXyW+vNEnBhv2tM6Ox0Xv4z/zr096KGSnZ7cKUI3Du9n7HnbhQuDcgXMsWDAadFISsnbdqcU/FAAYeYI/lO1fTV8sqihBHRQcDfUgLGNnfXaMxbFCQ6NV5GiP8t86Rx4OXkZmAiUbHlmV/MyhKEyAXm9EIMAciG1Tx4Mf0OwUJST2vHiT6X+lgYNdxEdqXmKhTGF5fFj2atXzrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJgJK9fUbmJYkG5nzlajslK0h8fAxbDRCoMiKS3YNeU=;
 b=ZDSNJc4xfcHn2qV3EECdaPEJsR6QVpB/cOeOnyY7HF2YThB5g1L67is0f5VrY8Gb73+ofAUINXhgAb04yiCTMQHhiRisVqsJAEbSPCX6aFr4bqlgKx3AwWhjQmN+5nni8Rqc5vPysm6u1F9Wr4IQC5UBon4FkiPIM7dk4U9Dk6FM8c09/ccbq4qZyR/UegJRM81ZQ5HD1OWxfATCe8NSKlRmEppVpKgmwdhPNFcqURhtHI2K0ieqrkJO9+SSH5YbeTLYP370ure9CiiY+BPxuwa3HgxJ5nKl8hIrlS9Sb8ozVmiAYAr/wQP5ZGG4uvYss8rLdIvBnHP61AaW/9l77g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJgJK9fUbmJYkG5nzlajslK0h8fAxbDRCoMiKS3YNeU=;
 b=dw7BP3xvgyKNtArXCXnvtQF6wtTTk8RrpQKvCvK1NzrerI+e8EQO88OInX0Ixcqcw7dPYMYwc/rqC6Id95qbFJ4z5QS7Hjv9heOTFGziduwH+jlImZeTdM/Ox2tW0Ime8uPif6RjmQna5hHaBtRaPu740m7cRKzixPK4YT+E3uk=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY1PR01MB1834.jpnprd01.prod.outlook.com (2603:1096:403:8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 09:26:12 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 09:26:12 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: quotactl0{2,3,5,7}.c dependency problems on older kernels
Thread-Index: AQHYOi0//5NDP651TUOeP8SQ89fj5KzEeQwAgABdLgCAAAoKAA==
Date: Fri, 18 Mar 2022 09:26:12 +0000
Message-ID: <62345060.1070604@fujitsu.com>
References: <YjN+hsHidEX0ivoX@pevik> <6233F9CA.7060207@fujitsu.com>
 <YjRH9NOKME95aABF@pevik>
In-Reply-To: <YjRH9NOKME95aABF@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2acc380a-8a71-414a-ce77-08da08c15840
x-ms-traffictypediagnostic: TY1PR01MB1834:EE_
x-microsoft-antispam-prvs: <TY1PR01MB1834E1525110BC94BB1164B6FD139@TY1PR01MB1834.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VGn8QIWdB4nqVPA/oiypczdQ7qhsIk2qzGXA5Yyh6/6leQhFfZDwNpmUPgx5LH1Hzz5+I+DxL9PFeyb6RXsQ4YdKJaVy69A3uaZBIEJZ5t+jjPWKUfG8cRPTyA3ywkZzJNQ8lqXC4Q2HljQe3Iy/xDkY+4J+MgCAsXPWCiRr2vNzqzhAOvfLczF56AVPmAlxcJVd45dFnCKPHb9L6hqUtE/5QTaahX6qy0+PQZPwzAjTGFbLVDShMQchmkGlCskbeng3NqM/WLUZb8lVffLDJKBm2zBRUc91Gii7qoiJAaT73ZXwpZi6BTO7wdr0Dm4jhLuHTQAfQzE7Xe5MC40R1t8YrtY+0hAsn5LekwaGCEsr1YGHF7QC46gIduV6Fj1aothbC7gwYEMtOtjls9iTi8IniDNVkKHsxlFZ/DNVLynwaW7u1qzFsY5kN/mu5MCTJktQ0NWagfUTUN/0FNGmg726mzSJvNrT3HPT33JjDPZ0eSPV1w3mdZjc/lRSiyCFtd1rkpSM2IDr1NI1MKTikwxlbvvfwODZcB5YrkPu3g8PNN9VmbF8WPyokgOhKvBOgPAdHZdU+jt9Oy2TKEkjNZkh2i3N3Zzxbq2M490gZ8xzbmTWCcqVct8y07K+A0W6rfjeiSplBx4f6vTOPYL1Nl6JbclYCkIJUrcoW0K2OHAVg0UTlKi+rzG8GHj+fmq04gOQEdXjyDO+scAuQQPQQpM71UyB00fnugreeIp+LGQFceBhH0Zn6n9DKs6TdWdfWZ8RGxDEXJ3BVwf9Nw2GodzE32au1CEOctnQke+g5SeSl6MttzPjWfEh8sqAqj2LNzfpqauNiTY+5H22i0+pfghxB6jgUijM2rMBN22BmZs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(82960400001)(6506007)(66446008)(8936002)(26005)(186003)(122000001)(71200400001)(107886003)(6486002)(66476007)(38070700005)(66556008)(4326008)(15650500001)(6512007)(38100700002)(36756003)(85182001)(5660300002)(86362001)(8676002)(2906002)(316002)(87266011)(508600001)(83380400001)(64756008)(91956017)(76116006)(66946007)(54906003)(6916009)(62816006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UWFmS3ZzQ1l6dHBoNUc3ZWhrSDZDalgxbFZSS0xQckxyNjB2YU9OMTEyYkow?=
 =?gb2312?B?Vy9PN05ucUVyV3IwNU1Mekt6U3BZQWxHQnRHOG9ITFZmYVBMdXRzSnYyRkVh?=
 =?gb2312?B?NUZ2V280dHhhSjJzWTMySzk2UUQ0SjYva010RENieHdFSnFBWUt6RDNsVC9O?=
 =?gb2312?B?Vk8xaHRuRytqemwyUVBVeC83ckVjaUJCNlYrZ2sya25pVlhIWmZTRk4vYjBJ?=
 =?gb2312?B?QktacXFkVnFTR2NsamFDRGNWbTlKRW5vV1QrQkQwWDJzUm5id2dsaUI0eUdO?=
 =?gb2312?B?TXVCeHBGYS9UaUhIVStvakhFL2hqOHpmaGlSS2dOMUtaODJOMld5R2p0SEFk?=
 =?gb2312?B?TERvRVdpcWxnRkljTHBhcFhyd3NNT0psSVVaazc2TzFHYUZUVkJDMWtHanhH?=
 =?gb2312?B?cVRQQjNVSzd4R1VveU5pM0tNYXFBUVd1TGh0aGVzNUQxcGllTU40T1JFM3Bi?=
 =?gb2312?B?YXRsS0p1NHk1dzZpcnZVU0kwMWFXWTJTS090WHdSVWZMdzRrOXlvMVpHWE1k?=
 =?gb2312?B?amVhemlHeVhybnNQYUt3L0tRekd1eDlKampCeXpPY1FkenlCSHVibSsvK0dk?=
 =?gb2312?B?c0pQS0VLbzN2alhnczg2Z21QVmhDeEs2RW1yb21zeCtJVFdEUCthWEY3WlVy?=
 =?gb2312?B?eW81OFdNWDEyazV3YTBpc3hwZm5ob2F5NU55TndSSjNnckZwcW9YeVNwaFc5?=
 =?gb2312?B?TENMU0xqYnFNa1pqdHhPaEsySGhiQkQzcFNjaFJQRDV2TENCWnlSd1ZEb0V0?=
 =?gb2312?B?eEhITEtqRmhodnRBeGZYQmQ1VHdsS2tTQVF2clRPVFVuU3g2U1ovalE2K2xi?=
 =?gb2312?B?bEgrRGVnbklCbHMrTVR0a1luYlAxYU03OFFoSG8zdVhhZUZpTmovR1VFWG9m?=
 =?gb2312?B?Wi9yOGFJQm12K1dSVit1S0Jxc0pmZU1DYXdSZDhFcWozdnhuZTFoc2tmYzNV?=
 =?gb2312?B?UDB0RUZjMHI4RFNpYnVIUGMwL3Y3cklmS2s2azBOYkc2T2tkVTFRK2NMK05y?=
 =?gb2312?B?ZzVDaGdjam40U2dzTVVLV0NDOHc2Z0ovNFpSTFZTQndMNmRMd1dWaW1rcVBw?=
 =?gb2312?B?RWVJcmtHYlE4ZlQ0U0RtTVRHdkU4VVlmTnBYa2kyOFhYaUdxZDdCNmhRbFg2?=
 =?gb2312?B?S3luYS9WR0lJaTQ1VjRZRXNtUUNTZThIbm92UkRkdTg3d3VnMEl1cWwzOFVv?=
 =?gb2312?B?MlN1RUNYMUNqaElhYmwzeUZBMlV1N2NxdllRS1ZTS2FOTW56ZWFnOVR3Qll0?=
 =?gb2312?B?TlhTdm9Lbmp5UWgzdS90UE1oYzR5ZVN5V210NXkyUERDSXpBb2VCYVEzR2Vi?=
 =?gb2312?B?SldKWVNpN0pnME1FTGs3N0h4UjFLak9aVmVTazJZV2JMR0pvTEF1WDllanl0?=
 =?gb2312?B?dm96aXRHSmhhVUFvaG1naTR4QjlQdXYzVHNpU0FCcm5uUXlrVjQ3eGZnYm0y?=
 =?gb2312?B?YTlRSzVRaS9iNzV4akhTbjFQYmZBTjVYbFY0R3I3Mm9QSHFFQkRXcUUvN1JL?=
 =?gb2312?B?QnR1RjJ1SUhCK2dYSzMvTTcrRFQ1SmR0RDREM2o5ZDRqTzRUUStqbTZ3NzYr?=
 =?gb2312?B?OWw1YURySzBTREJSQklyeUZsd2V2V3NYWkRjMWVrQ3FERXBDeFJuMVZudEI0?=
 =?gb2312?B?bjZ4NTVVODltSFdLLy8zTjUyRi8vTXJYUHkyT1pBVUNGQ0FPYnR2azFaNWxH?=
 =?gb2312?B?Z0ZKQUNxcFVwWUNZVlJjZHUvcEtGWlMvc3hsYnlPWEF6QlBMQTBqaXV5aGZt?=
 =?gb2312?B?TEIybldUUXBNalNsNVlpSStiY1JTaDM4V1ppOGxkS0UwbitOK2gyTzAzMjlt?=
 =?gb2312?B?Nk56ZlljcnNnMmpXV2dhM3Nma0JoWitMclRmRlBvNE5FZncrTjg2aG1pZWV6?=
 =?gb2312?B?eHdad0NhWk0zcUJVRU1uSndTMVl6d05sTCs4dDZNcXlyQkthVHRicnA3QW5E?=
 =?gb2312?B?VnlDanlQVmZOdkVkbUpabUYzaUNRWVo2TnByVzgwWWNGNmF1ZUF0MElERGhO?=
 =?gb2312?Q?rccrw0vDCUVmem7fNS0tSoiB5MpNuY=3D?=
Content-ID: <6DB79F0A162F9344BC7205A362CBF68A@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acc380a-8a71-414a-ce77-08da08c15840
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 09:26:12.6824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Le9Pj9v/1zhZ4DuF1k3IgtUjfjAgw6yR2HFrgxO8TCW9iedhZ9wQMHglTgJxBwwDAQNn19VeVi81ZBs8x5c1hVRg25Fb93PBAXVHOG0BuKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1834
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
>> Hi Petr
>>> Hi Xu,
>
>>> actually quotactl0{2,3,5,7}.c and quotactl03.c fail on only on v4.5:
>
>>> tst_kconfig.c:82: TINFO: Parsing kernel config '/.config'
>>> tst_device.c:88: TINFO: Found free device 0 '/dev/loop0'
>>> tst_test.c:996: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
>>> [  271.093416] XFS (loop0): Superblock has unknown read-only compatible features (0x4) enabled.
>>> [  271.096902] XFS (loop0): Attempted to mount read-only compatible filesystem read-write.
>>> [  271.100128] XFS (loop0): Filesystem can only be safely mounted read only.
>>> [  271.101852] XFS (loop0): SB validate failed with error -22.
>>> tst_test.c:1010: TBROK: mount(/dev/loop0, mntpoint, xfs, 0, 0x41d6a0) failed: EINVAL (22)
>> That is because you use a newer xfsprogs (it provides newer mkfs.xfs and
>> enable reflink feature by default[1]). But older kernel can't regcozine
>> this feature bits[2](it supports reflink feature bits since kernel
>> 4.9-rc1), then mount failed.
>
>> [1]https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/commit/?id=ec1b42e6d58dcb7cfc5de6fc825832944997e176
>> [2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=f0ec1b8ef11df0a51954df7e3ff3ca4aadb0d34b
>
>> I don't think this is a problem, user should know its kernel version
>> and xfsprogs vesion. Linux distribution has sloved this well except you
>> used yourself compiled kernel.
>
> TL;DR: Understand and we can stop debugging to not waste time.
>
> Giving userspace tool needs to match kernel brings extra barrier when bisecting
> in the history :). I suppose there is no list to match these (actually it'd be
> better to ask on linux-xfs). I'd have to experiment with slightly older ones -
> I'm using mkfs.xfs 5.14.2 from openSUSE Tumbleweed (i.e. latest stable).
>
>>> Tested on config:
>>> grep -e QUOTA -e QFMT /.config
>>> CONFIG_XFS_QUOTA=y
>>> CONFIG_QUOTA=y
>>> CONFIG_QUOTA_NETLINK_INTERFACE=y
>>> # CONFIG_PRINT_QUOTA_WARNING is not set
>>> # CONFIG_QUOTA_DEBUG is not set
>>> CONFIG_QUOTA_TREE=y
>>> # CONFIG_QFMT_V1 is not set
>>> CONFIG_QFMT_V2=y
>>> CONFIG_QUOTACTL=y
>>> CONFIG_QUOTACTL_COMPAT=y
>
>>> But not work either on v4.10:
>>> [  299.235456] XFS (loop0): EXPERIMENTAL reflink feature enabled. Use at your own risk!
>>> [  299.239463] XFS (loop0): Mounting V5 Filesystem
>>> [  299.240950] XFS (loop0): Log size 1368 blocks too small, minimum size is 1580 blocks
>> In xfstests, we use -lsize parameter[3] or use a value then get the
>> correct value from error log[4]. reflink feature will increase log
>> size[5], so we can disable reflink feature by using mkfs.xfs -m
>> reflink=0 /dev/loop0 (it also need mkfs.xfs support, so we may need a
>> mkfs.xfs cmd version check[5], if meet this version, use mkfs.xfs -m
>> reflink=0, if less than this version, we can ignore this version and
>> don't use mkfs.xfs extra option).
>
>> Firstly, can you try mkfs.xfs -m reflink=0 way whether fix these  two
>> problems?
>
> Yes, adding .dev_fs_opts:
> @@ -84,6 +88,12 @@ static struct tst_test test = {
>          .test_all = verify_quota,
>          .format_device = 1,
>          .dev_fs_type = "xfs",
> +       .dev_fs_opts = (const char *const[]){
> +               "-m",
> +               "reflink=0",
> +               NULL,
> +       },
> +
>
> ... helps to quotactl0{2,3,5,7}.c helps to all:
>
> quotactl0{2,3,5}.c TPASS/TCONF:
> tst_test.c:996: TINFO: Formatting /dev/loop0 with xfs opts='-m reflink=0' extra opts=''
> [   55.193262] XFS (loop0): Mounting V5 Filesystem
> [   55.197574] XFS (loop0): Ending clean mount
> [   55.199560] XFS (loop0): Quotacheck needed: Please wait.
> [   55.202735] XFS (loop0): Quotacheck: Done.
> tst_test.c:1456: TINFO: Timeout per run is 0h 05m 00s
> quotactl_syscall_var.h:27: TINFO: Test quotactl()
> quotactl02.c:119: TINFO: Test #0: QCMD(Q_XGETQSTAT, USRQUOTA) off
> quotactl02.h:64: TPASS: quotactl() succeeded to turn off xfs quota and get xfs quota off status for user
> ...
> ../../../../include/lapi/quotactl.h:18: TCONF: syscall(443) __NR_quotactl_fd not supported on your arch
>
> quotactl07.c fails on Q_XQUOTARM, but that's correct (missing 3dd4d40b4208 from v5.5)
>
> tst_test.c:996: TINFO: Formatting /dev/loop0 with xfs opts='-m reflink=0' extra opts=''
> ...
> quotactl07.c:37: TPASS: do_quotactl(Q_XQUOTARM,valid_type) passed
> quotactl07.c:41: TPASS: Q_XQUOTARM to free space, delta(1)
> quotactl07.c:45: TFAIL: do_quotactl(Q_XQUOTARM, invalid_type) succeeded
> [  116.407282] XFS (loop0): Unmounting Filesystem
> tst_test.c:1456: TINFO: Timeout per run is 0h 05m 00s
> ...
> ../../../../include/lapi/quotactl.h:18: TCONF: syscall(443) __NR_quotactl_fd not supported on your arch
>
> =>  not sure if we want to add this "-m reflink=0" to these tests (into
> quotactl_syscall_var.h, which they all use).
xfsprogs supports -m reflink after 2016.10, some old distributions 
xfsprogs doesn't support it ie centos7.9ga.

So if we add this, it will TCONF on these old linux distributions.

I think we need a mkfs.xfs wrapper in quotactl_syscall_var.h, this 
wrapper does the following thing:
1. mkfs.xfs -m reflink=0 succeed then return
2. mkfs.xfs -m reflink=0 failed then use mkfs.xfs to format, then return


ps:Another way is using MKFS_OPTIONS environment like xfstests, then we 
can refer to filesytem type to get value ie xfs MKFS_OPTIONS gets from 
XFS_MKFS_OPTIONS[1]. so the style of a complete mkfs option in case is 
that XFS_MKFS_OPTIONS + dev_fs_opts. But the former way is simple and 
enough to fix.

[1]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/common/config#n420

Best Regards
Yang Xu
>
> Kind regards,
> Petr
>
>> [3]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=7e07c4bebb08414ca8228ea91bdf57828fd4d110
>> [4]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/common/xfs#n81
>> [5]https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/commit/?id=a5132d9b3634fb6436d1f06642ceda82e64ea2f5
>
>> Best Regards
>> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
