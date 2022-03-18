Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B66C433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 07:59:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 242733C94EA
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 08:59:21 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 651F93C93AB
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 08:59:09 +0100 (CET)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1D0DE2002B2
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 08:59:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1647590347; x=1679126347;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QxhJmV0DmJ/bBC4X68DlTMIqIUAzIwEiuKtMVaT4XWo=;
 b=rLVEABy++988E8W877G/rtZWO2i9xsQd54w8v6IgL8tkgCPg+jx+qGuj
 4edctZlg9PQrwzB5X6xQjKTHCTrlNHketVTysfCVkJjHbtGf1ob6/d5gy
 wwAPDqt0xOs89I8LIeLjyhry5v8PYjQlm+ody7gF/e3n9RlRZwzguKasL
 D7px7fJHnSBCJnSCXtjOx7cCYFWt5yNWNq8obKEyN/yTQMbm67RFLtmmG
 1q9++cEef7d4I0cVdc7hDJCKC2LadktXn6ns9JQb1EfVyqYfTc3QzX6lG
 qs9DWkK6/w9SRCai3cIuaCboSHu/PnuTmpPaRoogRs38vQM8icCNXbG6a w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="52128439"
X-IronPort-AV: E=Sophos;i="5.90,191,1643641200"; d="scan'208";a="52128439"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 16:59:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCEYKvBb0BG81Wnk3nRJSoZSndqbyQVyes8mkkHbzffZxPrUOlgHDzkadzzZH5OPvPWVmPUVQgE3Cl0A4dNHo6UqvAtmD8CMN3uVaErJnzC0KxqV5n6kNUhgc9gpdj8gC36VbKvoaGNp2LWe+zV2Hjed4s0mlIrovIj2+VkyZ901i89lCrrWAAo3/t8wF+SHD7464qSge9VLsaQ+GlYLC/qtfgeH+qiZAksPIoipcYZtEY2Z4tTnDB1aDCkHLESx4MhMUoc+yUbmtvrnqniRQxF1RoaFgkoJ2o81SdxzjsQH8yWRrw7w+qtEH8Y2qo0lEIZH2YDPMDBvFWIke9vBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxhJmV0DmJ/bBC4X68DlTMIqIUAzIwEiuKtMVaT4XWo=;
 b=UNPL3vAzOdtp84exfUguLt3jqkZiQhys4P5Vi945UzfCpiFxqfeIwViiGlOgBnmRswrYKAlIba/zM4ZrUqKiNYIeThEmrYPOZvsmou4P+v0NIIXy/foBmtyH+DXGG/iK0cGNMgtF2vbn3EIN0GT3unSD8E9uif242VUJ2kDUi80m4W19s70v6n0cLjLpWyyTfJ7lSBcH1Qfy9I5j8uitO3Toc48tyfjBK7raUU+Orp7UBO8d2suv1vF6BNtmKU9M9JD4k0OXAdhncuHYHlnAFHCtTOivykoiiOkyow1H3YwIqh8J2HfttwogPS+GTWzG5Z7F2ss0cGs8Hu0HThbV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxhJmV0DmJ/bBC4X68DlTMIqIUAzIwEiuKtMVaT4XWo=;
 b=MbE6xqi3gIWxggbvNwpAGKLUfJXvMc8cbyhDtRTJPshqi3hmMcjntNXAYwG4selSWMq+XJu0AY2j1bsutKWMBU07gOxxe86RENTADfgLWBPy82+Egm1N4ZYhSjsTERu3JzfsPv1vVt8kvckGzmwXaBOMnD2dPJUR9XHpb6yA/Xs=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB5162.jpnprd01.prod.outlook.com (2603:1096:404:11a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 07:59:01 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 07:59:01 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [RFC PATCH 1/1] creat09: Fix on more restrictive umask
Thread-Index: AQHYN9eJWCFPwI5fE0G2efRMRz6TPazEzJUA
Date: Fri, 18 Mar 2022 07:59:01 +0000
Message-ID: <62343BF2.1020006@fujitsu.com>
References: <20220314191234.12382-1-pvorel@suse.cz>
In-Reply-To: <20220314191234.12382-1-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc3abf9e-3a4e-4ab5-4ace-08da08b52a5c
x-ms-traffictypediagnostic: TY2PR01MB5162:EE_
x-microsoft-antispam-prvs: <TY2PR01MB51627ED55DC174E0B77C040FFD139@TY2PR01MB5162.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V3vDv40uSCAlWH93/RToyR4S5FqYIKlENJ7Gv/1wdTtsVAY/MWehAm42oaKBMsM0+ufqMT0VeCX0yBdkPDzeMcaxERhrfKpvib5mNkNuD1FFzKIONYxruttKz2l3zDC/Tvp6t7J/PBA8s0As5Smn66sAdr3uaijllHzUuu+rYqr8VF3kecsKB6cbrtWfhDMi7ZVvP0kkM4grxDWbrx4pIImzeTt2zTM9O6x9ZiJcPRdNOG/DFOxvqjQk5rmm4K39iZCrLGUl3vbNkKen3fuKnabHpBt7oRcT+mbrwak60V+2WD2iA0R194Tip0Vc2B3F0ONAQo/nXHs6g9O2zHBjNzU2iMlro3Xngs0gJJIZbuG+J4KMT0WtLGnlFHBD0OLExiMM39vjKWeSaH/YPQFQjaqtwSf+dOGRgKocSnbaRCEZVZEAB4maMDAr1Enp8K6m2WrE30bHBXOCnE8zpm+gZ9C80KX/NJaycfUsDRRBAL5MrUZMTrv7f1nX4vKrcWpFLF9NPzuj9wY1NnyXJ4OPXkTCJ2NZEGmr4ZNGRmvHqZo9c/EIN84L8v6dauZ13FchruvSeTgNeEPse3vGDV7ep7S/KK2LCmzbAkZE1CctP8bNNFXE/czpbHyRQg0mcFHvBgTYq3k0ig8C9UPDoEGKu2ErFFiXZnKx+yt9IrzwNZorAxb4DT6lHP6Vz4kntebWoDvb3ssJUWIIGZQdr28esJupiCIJzifIBFhbxIsQe7BTgNGzN5SnVpivxWP/0OxLbeJAz/7ZKV5SJQY0slJn6Er9JzOPv8tAq3o9sKxI3/0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(33656002)(2906002)(8936002)(86362001)(508600001)(87266011)(5660300002)(6506007)(26005)(186003)(2616005)(6916009)(316002)(71200400001)(54906003)(38100700002)(38070700005)(36756003)(122000001)(82960400001)(66946007)(4326008)(966005)(85182001)(66556008)(66446008)(8676002)(76116006)(66476007)(91956017)(64756008)(6486002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UmhHOW5LdmJMeEI2NnB1NWVwUGpjSkEya1F2M2tzTmlEaTlTZDdqUHVOVDZC?=
 =?gb2312?B?dmpaQTlabkRPMEtTbXhGS1Q3eDBJRDNYSmZEWHlmdU0vVlcrZE1lVnNSY3dj?=
 =?gb2312?B?OUVIeEUrdlgvQWxtZFhvZGdGY3dwR2hGMlovQm5YVHl1b2ZPdHdBS3NNVW9m?=
 =?gb2312?B?aG5YR2ZueXlobWlCSFYveU0vRWhNLzFKMHA2NFJvQ0hvTDBMMkJRT3FCcEho?=
 =?gb2312?B?YnlraXhTelluajFVOTFSQTVSM1pJcmp5ci9OaUs1YXdrbWl0eE81RXJCT2Jo?=
 =?gb2312?B?eXlBYkxmM3plRlNPamZqakMydEZpWnRWNXFMRWRzNmlDdFM2aDkzZ2NvanpC?=
 =?gb2312?B?L2ZlcGtpelY0dWdHNkJIRUwrUHVPMm5nWDlyMU9nd1ZETzhHWjhEYUFPU1hJ?=
 =?gb2312?B?aVk1K2Q3NWE1OFprTThJN0o5MzZZcVdvR1lkalN2SlZSNTNiOGZEaGNLWDFl?=
 =?gb2312?B?TGR4bUhKVldGd3ZRdWUzV1J4TzBqSnFtTjI3TDFKaUx1QWxBQXhJL09acUVn?=
 =?gb2312?B?TkpmQ2RpOUlUSC9JOUZyNzN6WmcyeUZZMlBkdm93dkZCK2Fzc3FNeDRKVnVy?=
 =?gb2312?B?ZEcrcjlBWWo1V0k4aGg1dG5qWnFMNGZwaWFvS2FuQmUxdXM2UnR0TkoyeDcw?=
 =?gb2312?B?blh5THJtSVdtNFlTb3JVdHRWR2h3YVk2eHVwMVpaN2pVU2dYRmU4dHlMZTdC?=
 =?gb2312?B?RmFEdkh3dFFSV2pwbm9QSkxmZ01jQ0F1RWVjVllZZVREU1ZRdTN4c1BOQzZL?=
 =?gb2312?B?SkdGcFl2TEVUMjcrK3BVMUJZUWs3MERmbGNMbzZ5MUJtMTIvVFJGd0dPdWRM?=
 =?gb2312?B?eFhQY0xqMnRZSVFHRERwYjFxNm1TRDBhOUl5QTNMU0NXeEdvWG94a2ozY0My?=
 =?gb2312?B?akQyVlpaaThGWTQzc1g2TlpiZExvdXR4S2VzQUw0dElySlJsYlFIRTZvWXZW?=
 =?gb2312?B?ZmVKWktYNkFQcE5XUVpVZHZUNHdkTDRWSjNyejlzTDVuTFZ1bmlwMXJBZ0FB?=
 =?gb2312?B?ZU5HZndBRVFRSUxZRVVXNFB0bWxxYzhWcXZnT24zOE1mKzFKNDZtaGtBejBE?=
 =?gb2312?B?TXU4a20vZUJqaTBLSjRybzBMdWZ1Y3BGZUpaSFFoSUJJUzNzSDR0UXhtbDh2?=
 =?gb2312?B?WWdaNnFVam9Ic0JGRGtsK3MyRmJnVWpKYXVYbGVEMGIzNUFsQ3RmdGJSYXR1?=
 =?gb2312?B?U2w2Qm1ncnk1T0pMQzVOckJwWGVPSXNtcFk2Y0REbGtrYnpVbWxPQlI3Ylcx?=
 =?gb2312?B?ZzIvRk1oZlR0MlV1bVdsR1ZrWnNJQkg0MVhSVWtSK09GVXFsRjByYzhvM3J2?=
 =?gb2312?B?dXN0c3ptaWIyOU9uUjhRbEZZY0hJM0tpajRlV1ZuU1ZpUldWaTFkeWR6bUhW?=
 =?gb2312?B?d3ZJV2JEOGdRRy9UemxYd1JVcjR6RTdubCt6TXlNdjRMcUZrUXFnUkNUQ2pD?=
 =?gb2312?B?b2ZhZTBzRkE3c1p0YlAreDNQSERRdDY0dU8wdjJJKzdtKzZDRE9EcGhQb2hp?=
 =?gb2312?B?K0wwUUlybldrWUdkS3lPMjR3aVlnMnQ5ZWUxenQrMU5vcStUYm05UkwrZ1Ay?=
 =?gb2312?B?OE40YlVYQjllSlZEQmN1bWdBc0VtOFFSL2J1U3FzemJPdktzdDRsV0FvZTUy?=
 =?gb2312?B?bVVhaHgzaHRycWlSNVR1RXR6clJEL05xL1ZteWhZUUVON0E4OElPRjdEby9y?=
 =?gb2312?B?ZURZdlI3VmdCdEVueTBvTzQ1MStKOW44WFpOcUZVMGN1aitVR05KWWg0WGpU?=
 =?gb2312?B?RUNBbkxHWEN0My9rUkJFMk1JNGdnSkZ2eHlxVkUwTXJEWnQ1aWZacTFMc1c5?=
 =?gb2312?B?djhBSzhsbHNTOWZIK3Ivb1VzSXoxelNlWG9CdFhaM2dWUWtjWGphb2VyZWN3?=
 =?gb2312?B?UXNMVkhvUGkrelY5YWdvVVMybWZmRXR2dXlsbzYrSVN5NFFTUXc1MW5BRWx2?=
 =?gb2312?B?QllaVFg0WGErN0t4WlNwWFhtQmYxdVZvQm5iN1EwRXFwZnBCUnB6TXNPMUZw?=
 =?gb2312?Q?H2urh8GvUcesiixJpy7NANBSgfqYeQ=3D?=
Content-ID: <399E6FED25B2FF458CB2E02186718D11@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3abf9e-3a4e-4ab5-4ace-08da08b52a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 07:59:01.8359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2oBiGpAmuD1xdYT1RUWak3Fy7lW/XLgMRUnCO2qEi7D86Rven9Xvk9v1Nb9H4WK+sK2UlFq5nkcGFMv0G0q7ofBQCOsCmRe5jcSFcNVw4qE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5162
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
Cc: Martin Doucha <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

It fails because the create file without S_IXGRP mode, then we miss 
remove S_ISGID[1] bit.

But I don't known why other filesystem doesn't have this problem.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/inode.c#n2249

Best Regards
Yang Xu
> XFS fails on umask 0077:
>
> tst_test.c:1528: TINFO: Testing on xfs
> tst_test.c:997: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> tst_test.c:1458: TINFO: Timeout per run is 0h 05m 00s
> creat09.c:61: TINFO: User nobody: uid = 65534, gid = 65534
> creat09.c:62: TINFO: Found unused GID 3: SUCCESS (0)
> creat09.c:93: TPASS: mntpoint/testdir/creat.tmp: Owned by correct group
> creat09.c:97: TFAIL: mntpoint/testdir/creat.tmp: Setgid bit is set
> creat09.c:93: TPASS: mntpoint/testdir/open.tmp: Owned by correct group
> creat09.c:97: TFAIL: mntpoint/testdir/open.tmp: Setgid bit is set
>
> Thus clear the default umask.
>
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
>   testcases/kernel/syscalls/creat/creat09.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
> index bed7bddb0e..70da7d2fc7 100644
> --- a/testcases/kernel/syscalls/creat/creat09.c
> +++ b/testcases/kernel/syscalls/creat/creat09.c
> @@ -56,6 +56,8 @@ static void setup(void)
>   		(int)ltpuser->pw_gid);
>   	free_gid = tst_get_free_gid(ltpuser->pw_gid);
>
> +	umask(0);
> +
>   	/* Create directories and set permissions */
>   	SAFE_MKDIR(WORKDIR, MODE_RWX);
>   	SAFE_CHOWN(WORKDIR, ltpuser->pw_uid, free_gid);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
