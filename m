Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292ADC433F5
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 02:15:44 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 477BC611C5
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 02:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 477BC611C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F36F3C898C
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 03:15:41 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1254D3C0480
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 03:15:30 +0100 (CET)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 948CF1A01776
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 03:15:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1637288130; x=1668824130;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=w7P4UnKu6jed5kP9lOgnu5GAQOdwQVnr8YSNW+oau2s=;
 b=vK2bh6V2OvfkPtFnnbXEoid4RmXsPe2q8vWUDQP+jCcSlsHHzHd1iPyz
 GQEIdU9gP0d0nWry1a5x+4VfmdfAPg7f1YXk6441DBoIAA/ai53bay1JW
 6iVz47q+gNplGMnU4nigaQjGIoufAx8nQY9It0UxgffHbK8HfYuyXG/2N
 2bfgfjrsdUuU22iclBodA9PwzVcPCKNxVY8LlfZFcBrQQQCWTAHopsfoK
 nDSMLqCvfUEgj0pfUHbz5OOW2WDNP619RG70TYSWc3v8c4+HO7daj1bZD
 vglr0eyJp/YaKDZfLsawBVu3wv5dqFuklJJmiUr2XuEyKe4hhVwH4yhUc w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="44076386"
X-IronPort-AV: E=Sophos;i="5.87,246,1631545200"; d="scan'208";a="44076386"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2021 11:15:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2z5XyPSjyR21BhE2/hGWagYf2Uy0VfiCXwKR+k3g565sdTDxYo+9rcSdGIzS70oigs0dcMo8GQURUDfwkN19uTGDBhEHbLmdFBnkMaFtzk5YuhWZcc0nhdPctL9XZe+ZVMqQb7pOSU8cllquDxd03DaHv8OhJi5iBHABFzu4ukOF2V/yBtnmLAYqXeJSK/zQdRrP8Kt6o4Keuwjfh1m92jsjdjlYGTbx/qR70fQ2TOVOuDYJozDmHvXndis6vvr4G4DBoSsLlAe33Y0HFCw4HCUoEWaV3khQ3wtLU2vsh6e+LmZEajwx2uyHtYhnv/KOsl4/aBma0/ksIUpjfvF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7P4UnKu6jed5kP9lOgnu5GAQOdwQVnr8YSNW+oau2s=;
 b=R3wzVOL3HyadINMJ5h/Nsv9Xv1mySC7/76ZBOHcUJE2/ZkPw655pYltwN9GsBqWG6uOC1VSr/epTv08cR0aicyoLg4czyT+otP3y4lF2Fw+aOXpqQZ7MeaZxHCDDav348SBYhRl/aTev/5QfIxbybmEg/vTAbZxeVeLHQNK7/UIG1QoDViZnnQ20yb3ZIbWWFhLW3ggDWp+Oc6dap+t8MXtMB8YMF/H/XuSDeof2KWQna244o2lhyFzGXQY3lJgo4CH3COsn8EYW6b6jpeOjUzLSEkSaVommM7uDsyoAWV0+ijrStob/AQnLIcDRmcwAlaZyROKO+/55znxNwe0M6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7P4UnKu6jed5kP9lOgnu5GAQOdwQVnr8YSNW+oau2s=;
 b=lx2S+atfH8BTi8YU5iu5xqUfq9FltuKo05BBYuwYWlOQiGKNcS+Gr0ff/g9CHYO7z8LpJua9DA9expcS9iVwh1k05v9JleIzLa4XkVGr35nLdRJHUSeJrWfFqePILvN5Y2RyELRkXhhjYalWx3ncOSGDJXIhB43tVea3gtBV+8c=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB6043.jpnprd01.prod.outlook.com (2603:1096:402:35::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 02:15:24 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%7]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 02:15:24 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Thread-Topic: [PATCH] statx04: Re-add BTRFS version check
Thread-Index: AQHX3G+Ihz1oY4HCgU6zdx0PPLA7lKwKHfkA
Date: Fri, 19 Nov 2021 02:15:24 +0000
Message-ID: <619708EC.6090305@fujitsu.com>
References: <20211118112900.15757-1-rpalethorpe@suse.com>
In-Reply-To: <20211118112900.15757-1-rpalethorpe@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64edae38-9880-4a9f-08d8-08d9ab027233
x-ms-traffictypediagnostic: TYAPR01MB6043:
x-microsoft-antispam-prvs: <TYAPR01MB6043ACF6EE0B5D2CD934701FFD9C9@TYAPR01MB6043.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tSmuibHVdYH4fV38t4im1ytX/9S3x/XKGeaJQue6LTwLW/jHKVtXY2c2LvISAm9/yGeejP2fZcsp/XpQDnW6dgaoUPC3oMFu8/mwF8ITRxtB9C6t//7uZBHScPZ0PecYuj/5f2HM6sP8Fbpm4I+WLzT5/EFi3CSSREw4mNoi99NBWyuD4q5uD5FFjNccqqlpNksJCWMWdbvUHfzCmkbMax/wNs1Z5jais08q+HEItZH89L3K4L+ZGnw9+I6bGNqQo8kKtZ0Wbbe3T+OtWyuyXQnKHPXhXHY1dGU4ERfQLzqBA7ZcSzYeplqbGSrmOdyFfLdVi+ZNEQIxCbebLyl3z3qPz9chbBtLBDch/pcTerRsh/dM4f7f00ImxNUsJTETe2V+oLMFuvDYH8JrX6lIUBubZOZWKumGot0+dXyuqMvLVG4YJAiqKDOcf4RVz1DvGPR5ttxH0Tl9G0xGjrHtoj+A+Z8CuWDrscNaEAr8PxMjZhvGv2ppG8eG23/6hNC2/g7llD1EU6mP9UR3rPGghRZM7DwLRrIrlf+srPW+7xWhXpsY5YaI/VPbp+NRQbB7yj3r1mTyF68IikAcpXh1Tc7J8whQo4ckvK3qhmr9k4r1pcHlk3Ufxcg1f7YjLeFAk9DxE5oLfnCyDLUWlQHtHrvEjYpmc/TCIZis60cJBo5po5AQt69YWXuSa7PaLEJ+V/YDFPSRwniIEHOQk95fzA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(316002)(38070700005)(83380400001)(66946007)(6506007)(2906002)(66556008)(6916009)(66476007)(91956017)(8936002)(508600001)(64756008)(6512007)(76116006)(36756003)(186003)(86362001)(4326008)(82960400001)(26005)(38100700002)(85182001)(87266011)(33656002)(122000001)(8676002)(2616005)(5660300002)(6486002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?R2Z6SHViNmk2azVXSlhZMmw4UEplbmVwcGd6dWpmVEFROTRxNGxtNEwvdDdC?=
 =?gb2312?B?cFlLS3dTT0R0WktvZlM3SDg5VXBzK1Z0Uks2WG1IRFh5cElOSnorV3o3bnI2?=
 =?gb2312?B?eTlkS2pSemZDR1lpQWJQSzJtSmhYUTU4aDRVa283NURlRVIyZytqK20wL0pY?=
 =?gb2312?B?Z1JjbzNLUHJrWGhSQmdhVmloN0haTXBraHRMZmlzMlJ2YmJFM2pMK296UmNF?=
 =?gb2312?B?b1FZcG90N1pNNHhESWNpMjFqL2YyZVFrWkpCTnFMYXdmbWdnM1p6djVleUE1?=
 =?gb2312?B?ZmI5N2NOazl2amMzSEVlT3ZmOTNZTGU2RHl3eXZMSVh6aVJlYlJKbU1qeHlN?=
 =?gb2312?B?QU1LN0ZrNk1KRUZWQU9FWTcyMG9wUkwvd0xkMmQvQUtNNkJ1MmlsNUxmYVVn?=
 =?gb2312?B?cHlPc1NHL2VUMWNaR2hDMmhXS1d3ZTR1WGthRjZ3STdjSXBGOTBnRmlZY09z?=
 =?gb2312?B?S2NNM0JTeGEwbi8wVUI2ak02WGkydmhzK21yNEdZZWRydXRRNkFEQTd1d05T?=
 =?gb2312?B?ZVE4N2t2TXA5Q2tmYjYybGZMZG5Lc290emVkL29pRUNURm5EUUREa0ZVN0xi?=
 =?gb2312?B?SmxzQlpPOTdiYUlBRC9HRGJKV01yY2l5RUwwelZHejFuK1U1cGZETVp4eUNV?=
 =?gb2312?B?bnZ3TEpxSzFEdElteHRWTjZnUFlyM1Rtb2U2MGkzaEJQUG9Ub3piMWFFbEZz?=
 =?gb2312?B?dVAvRFM2VkVpdldaVGF4OWpBY3ZOSHRWbW1ZSFBXMlJFVFpBZEFYMG4vYkJJ?=
 =?gb2312?B?eXJjWjJieHpHTEtrdHJHUW1CamUvQysxcWttYmg0Q09kV3gvVXhxN3RjN0NE?=
 =?gb2312?B?b2lBaTE0cmNWcngvZTgrN1lsTXZKL1BIR2JSd2I4SS9uVWt6eWdia0t6WGpN?=
 =?gb2312?B?VVRsRnE3RE5iWklxZkNjemY4OE45Z1hvTU1qQTJuNGVTM0ZUL0ZBWTA1N1l6?=
 =?gb2312?B?Z3I5YkVTK1pTbU9aT0hQL1ZSc2hSRllxUkZCM3VWQzZNdGVlNk9DNXJTYzJ5?=
 =?gb2312?B?Y1NkTUxMaTg3WVQrdU5kdHE4NHpvUkVVLzhmWW1ZSlIrV0lqQUhvb2pBQ2Z1?=
 =?gb2312?B?eCtKNm1sTk5CbzNnT2IzSFhmMDlqZERYQW1RdEZFMWNqL1hYaTVpNnUwek1v?=
 =?gb2312?B?OUd1eGlSNjNZdEhtL0FDWTBNbGVraW1UUUQ4MUxPMkw1T1IxbmNDd1VROHpv?=
 =?gb2312?B?MStxU1RlN3RSNXJvWnVjUUdEN2ROS0lWRXp0b2VnUklKeXZlT1VtcS9QKzR3?=
 =?gb2312?B?RGZ3L0kwblhzYk10N2NBcXVJbDRRWk0xYlI4NFI0ZFdHdGhXRHJINkhCTmh2?=
 =?gb2312?B?SVFOLzMyVFk5RFZveTBTM3FsWEhRN2wvSytvbE56Zlo5SHc0RU8zQ3RuZGRW?=
 =?gb2312?B?K0Uxc2NmZTdZY1o4VDk1ZS9UTDlSZlFac0lhUmkrWFVIbnNtdEwvcHVRaFJ4?=
 =?gb2312?B?eDVMckgwZmJpYW9TOXJRcE9iOGxTZXBkNldUaGwwYVU2Nm1ENlRRM1VyZS83?=
 =?gb2312?B?UkJkcUwwK3ltK1VEV08rVHdrZ2pnQmhJWUN3V1p6VkZmU1hQMlRocTFJNlZL?=
 =?gb2312?B?MGJXeE04eXd2djZlUTNpMktuaEdZV1VTelRWTzR2WWovQVZ1a0d0SHpGYTdS?=
 =?gb2312?B?L2hRRThvd1V5U3ltU2xUNlp6THNMSXZVVWp1dzZNencrM1FBVTlKbDVNci9z?=
 =?gb2312?B?ekMvN1dIazhvblhXaTlDVFM3RzVaL0t1aXZuTk1yMWxvcVFOdVB3dlEyazN2?=
 =?gb2312?B?SzZxOENVM0Y3SlNxSW9jdkxMYWFiZU1QLzc2eFBOZnVIUE8va1IxNklJZ3VG?=
 =?gb2312?B?VUR1NHVZNFNiMzk1RGhSQWJ5dnRwa1prUGw4NnlJRzlOUkg2M2x0ZDBqc2dZ?=
 =?gb2312?B?ZmY1Mm80UGVGRGE4NDB2U0FqUmlDb1lWbEtnV2ZEV3llZG0xRUhCcElGL3dj?=
 =?gb2312?B?OHhHcFdVOE1rL0NObGhma3FvZWg5RktkL0lrcW1Xd1lCQ0U4T0FDZ3NRcWV3?=
 =?gb2312?B?SEU2OEZqTWNoRVVvQVQ5SUVGZDVwT0pkMEhlY2hjT1RiUkVVMUtZQVEvcmJm?=
 =?gb2312?B?SXdlVW9GWTJYRm9uQ2IrTjF4UWJ1WVg5S29QN1FnRStzN3hvQmNOU2ZLTEZK?=
 =?gb2312?B?aWF5ZHVNNmhnM3NOSWdEUUthMnNFYjlZeDBOYlpTNVY1OXFuK2U5eTN2aW5y?=
 =?gb2312?B?T2xaMnRoT284QVFUZUhqVVpVSGJjOW9DblErbHBVTEV6SVNQc1hRdmdKVU9y?=
 =?gb2312?Q?EjRo/mvhQXMJ12d1w0DTo3jGoO3kf4A/h1d9Ni9AXM=3D?=
Content-ID: <38BE8BCE5439D84D8D5FB1DA0345CA73@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64edae38-9880-4a9f-08d8-08d9ab027233
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2021 02:15:24.2961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Enk/JartXCdTzeKtkAP2/ft/juK+vOE0ad2BTKzrOp3f134WYyLgVWmiyXlJwCutQet9yy9kR9Y5F4GKE9JGwAROCKnFRwA28LQL5HqmxUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6043
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] statx04: Re-add BTRFS version check
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

Hi Richard
> Removing this was a step too far. This causes regressions on products
> where there is now no chance of a backport.

Do you mean that your distribution based on older kernel ie 4.11
supports statx syscall but btrfs missed the btrfs patch? Also this
distribution doesn't update and so have no choice to backport.
> This is different from the
> other version checks which are for much newer kernels. 
IMO, distribution based on older kernel 4.11 still can make ext2 ext4
xfs supports statx because the backport looks not diffcult. So, I don't
think this is a difference. It depends on kernel users worked on this
distirbution whether have this requirement.
Also there could be differences in the difficulty of a backport.
I see xfs/btrfs code, it only fills the attributes field of stat
struture by parsing inode flags.

If you must add this check on suse distribution, I guess you just add
this version check for suse distribution. For centos7,8, neither of them
supports btrfs, but I don't know other distribution situation ie unbuntu.

Maybe you can just add suse detection in lib/tst_kvercmp.c.

Just my personal thought.

Best Regards
Yang Xu

> 
> Signed-off-by: Richard Palethorpe<rpalethorpe@suse.com>
> Cc: Yang Xu<xuyang2018.jy@fujitsu.com>
> ---
> 
> Note that I am still very much against new version checks if there is
> a high chance of backports. We should leave long established checks
> alone however.
> 
>   testcases/kernel/syscalls/statx/statx04.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
> index 180c61bf9..b5ca0586a 100644
> --- a/testcases/kernel/syscalls/statx/statx04.c
> +++ b/testcases/kernel/syscalls/statx/statx04.c
> @@ -182,6 +182,9 @@ static void caid_flags_setup(void)
> 
>   static void setup(void)
>   {
> +	if (!strcmp(tst_device->fs_type, "btrfs")&&  tst_kvercmp(4, 13, 0)<  0)
> +		tst_brk(TCONF, "Btrfs statx() supported since 4.13");
> +
>   	SAFE_MKDIR(TESTDIR_FLAGGED, 0777);
>   	SAFE_MKDIR(TESTDIR_UNFLAGGED, 0777);
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
