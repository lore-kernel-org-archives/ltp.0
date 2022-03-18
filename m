Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2152C433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 04:02:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08F5F3C94A8
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 05:02:43 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 299823C0711
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 05:02:32 +0100 (CET)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 851EB10007AB
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 05:02:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1647576152; x=1679112152;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=4qx3uc1kooDzd7eRoFk5Q2mE1DUPAGZrBpHs/nwuzBw=;
 b=AowuB0z133vmYxZBvojd2D264eF2BOjUpFiqKtU9tk+hVn9qG9twWYgY
 auGV9V5YsFdldF6gNzc5NTtKqI4CEQfJfmvNUCNybIzsOxUKpjzjoFq/E
 U9j4QPvoVy3dc9XKeVo1Ah9piINe3WdSYAxkPns865eadTUWU2LBh8/Ag
 6z+rweBc01mAtZWPjVzxnpEjwopAJLHWt9L5Yg1I4s0YvmyYmmYJyDdoA
 peUN0QjecjmolXDvb2GVSV0ymWl5DJQdKKrz0KKXkKjox8ZvoI9Pr8WH0
 QdMomGVNbFeCU4gW68INw938h1PfSp/utLZKxScA0hkbIbQkRp4PI3o0u w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="51823982"
X-IronPort-AV: E=Sophos;i="5.90,191,1643641200"; d="scan'208";a="51823982"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 13:02:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frPr3vPf3rBGFy2dBRv3Hfx6w3m1kKwrtYsO4rJI/o4c4w0gOMEN9tJcCkuydti9qmlJPxXFGp8q+3LRt9NYIKc71QrE9N+28lb0CLCuXkPXBEj1ti9vWSNcf/1eQFLr1BN6GpI6TiKXn+l3UX770o92LlHa5o+xZ5RRaw0oO5R2Ho7uKY5LowUTp6b6bWZeAPLcSadEu5gcCN4S8UUJZuq3BKKW3eq6R9X+zm1IJlqG+aViZk4q8/vGUKcvnYbiC9LI0VqKNqRd2PL8zDvrYJYXGUFjilRCPlhMLe7+kFLHiRX8hRcFg7dCvg9m0/0mi0gMw9b4nWN9XvF5nENE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qx3uc1kooDzd7eRoFk5Q2mE1DUPAGZrBpHs/nwuzBw=;
 b=GfNNhVBN+Y5Oi4Qdkrcytw1+/DzaCOWXQek2lyhkufoD+kjHZlCihawn9v6tWkXAFYtqYWOJzCmUGgqtwCQKRSqrkrOM9ZDZyZtpye4kuSNUGOjp9YbMmTEu+W2YUqCeCOD0DldJ9TMdP5F0yKndL6iPaM+hYqEQ9CuFXXlY76MwGGShYuNEwrvgxD1Uov6rrhoac316LrC8YI+IKHD6C23zLWquZgW1vb2T/fjEO19/VZiqGOC599PmYoiOROrP9r95DW/zTpRCQ85E5SQcTg4meQKO4lBsxZEjE71rV8UBJs+VL7a0eixkhnTsrsztqqDv2iLGbAZz8x3ORTDvCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qx3uc1kooDzd7eRoFk5Q2mE1DUPAGZrBpHs/nwuzBw=;
 b=VUPd2of78/Cu9CPRBcOIyhdCnkaKg8vkz0neoWpuMSGx0ppJ1/Ga9xaXYBpnv51mdD5lTFhNAsoLffzrQAdSBXQTQXIpck05ckNnXBO0wE5gFUChhEOUTQCfezXSnih0+73bxoWGnl5kmAoP1DZnthjXeSgGNSGNodI4wN7qEGI=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSBPR01MB3943.jpnprd01.prod.outlook.com (2603:1096:604:49::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 04:02:26 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 04:02:26 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "daisl.fnst@fujitsu.com" <daisl.fnst@fujitsu.com>
Thread-Topic: [PATCH v2 2/3] Make use of SAFE_ACCESS
Thread-Index: AQHYOd2OTcIUpNpGCEKxUTGpq/FF7KzEhm+A
Date: Fri, 18 Mar 2022 04:02:26 +0000
Message-ID: <6234047F.70901@fujitsu.com>
References: <622EE434.4000400@fujitsu.com>
 <1647550813-1958-1-git-send-email-daisl.fnst@fujitsu.com>
 <1647550813-1958-2-git-send-email-daisl.fnst@fujitsu.com>
In-Reply-To: <1647550813-1958-2-git-send-email-daisl.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bac5e66e-4a8a-4888-f46d-08da08941d68
x-ms-traffictypediagnostic: OSBPR01MB3943:EE_
x-microsoft-antispam-prvs: <OSBPR01MB394317E80EEA449DFCFC441FFD139@OSBPR01MB3943.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bTVkjIrTsoqdSzaUB527WXZwHdHz3YJ3vm9uYNeacIL8NMuLQna7I074ug5WipcIhQKKmKIFsQY6h15aEy9wzwZHZEoTsoPhaoEknRkj2ouY1btwoFs5vsJ8TMDU2oN+V/ggN69gR0yMl0rhx5zNyDjnl1tKLG/n6bpsn6KG+HPV1JZ2YzpyFpR8dfDXE+KzkgmhjR2DpRLVVpGwCi2NPxUR5bHzktDOZh8jTLnFRjyrfAGyYwHHR7IqdqP2Q4tXKO6FgqpAgyz3wwpy/rLvv2DLeU+VELPBorZDWiAypa9MLQqJauRHNQk3U8OHT2ShE7Hjz2ifQejopz7FxPsEcEopUYYuE2trZwRbJEomsX90ik0J58/ntf8YZSRG1QJmCoJ/sj8WlPhou8Ed/aM+YBWR8mD4IRNQyJjo5pVADdW9oQK5zh7Y35dKwHJy93tzl7nVyt5nNrykYvCUySpbTUao4YppzwgVmFh58a9Cg84Z904WVGxdjf1+nVRMZ2iGCYn5Z7lJgXw/X3JL5C68FUg4cgqQ2XApwGC2hO5MbX9NwhoJh7s/Uo5Ld+r1wP76vzY36w3oaVzh3SFLy8UxnItKfX30e6bCWhfMHaPbjxtOsXTA4vh+KTqBooxTaVZtYHROIvwjl4Sx1eQxpu8b9J4ctah6wyCW1suxZJEjuK+59CUV2KblOQu6U2gzwTHzGc2WV6ecUiNhP1DsvDWuNA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(36756003)(83380400001)(33656002)(2906002)(2616005)(85182001)(6486002)(6636002)(508600001)(82960400001)(76116006)(66556008)(66476007)(66446008)(66946007)(91956017)(64756008)(6862004)(38070700005)(8676002)(4326008)(8936002)(316002)(71200400001)(6506007)(122000001)(6512007)(86362001)(38100700002)(5660300002)(37006003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?S1E5U0tlU3V3NGZNMi9YVzFxNzRjL2lUVUVSVlJaM2hXQW9wODFGQ2lyYkI0?=
 =?gb2312?B?d2R5M21tL0pWYWg0Q3NnU0xueE5jczFrTDUvVmJ5TFVZdVBZU2Zwbnl4cThG?=
 =?gb2312?B?VGFtY3IyU3pSR2U4RksyNDVGR2dsVkt0enRpNU9tWWRnT0RzbDRhSklTblVh?=
 =?gb2312?B?ckFMQWloVE56bFlDS1lEMW44UUViaXpxQlFmWUg3UjduZUZJWmJwOXJNNXBB?=
 =?gb2312?B?VHVBSWZUdU9zSGtBUWlzNmdaMndyaTVpc2VMN0YySkMxUVFFbE1SdnowWVJO?=
 =?gb2312?B?ZDcvT0FFRWswbnFEMFh0RXNiVkZhY3pFUTNYSkw3SUxWeUxQM2tIOHBncjll?=
 =?gb2312?B?MlNUT3hsUHAvdkV4QTdTSDJpR1g0cmFVS0JMdElyWitHY1hCVkpXNm9aZ2Fr?=
 =?gb2312?B?ZDBmNy9GcEUrK25CRkFVM2lnSHZQRituMXVEcVBUWllxc0l6a3ZNM3NnaDJY?=
 =?gb2312?B?Vk5YT3FTK2l0UUVoeTNTUTd5REQyTUl0S0dZZXNFNVFvYmY0SitjcE43a3dw?=
 =?gb2312?B?aFljOHhtT2tXMW5vUUp5NXlBZkxUbjZpS2NXMVlFUXY0MS9ZQlJWMEFDU2RT?=
 =?gb2312?B?MmkvZVc5U2k4Qm80ajFEY2lsRUh6cnN6KzZ5MW41MUxORk5NYWFoNTFabFFn?=
 =?gb2312?B?NVdGYjhDNHV1NEYyQkI4SU1CN21QSVpVaEpCS3BjZ2JkdHp6VGdCdVNHakxz?=
 =?gb2312?B?clRoZGIrVFh1V09yRDJSMHFYWHQ2YjV6WTVkUWVGNFhmVnVpWGtjbHF4c280?=
 =?gb2312?B?QW1ZLy9LMDJZcWNXZzNMaTMyTTdRV0xodmkwMXdaY3hwRW1PMmE3aUdzNE5D?=
 =?gb2312?B?VXhhOHl3N2h4MkV3aU1EUngyY1BoWW1zdE1TQUM1Ym1kbFJMQ09KM2F2aVo0?=
 =?gb2312?B?WTVielN4L3J3TVNFdVlqckZmNjA3bVF1ekhRUVR1V3MwS3FnWkNsWEErRmV4?=
 =?gb2312?B?SVNsRXE4M3JpWjlUUlY1enpodUJEbk1DRGpnamNNaGhyWkZkVC9OQ2g4VG12?=
 =?gb2312?B?Vkgva2hOWi9Bd3QrdzhZN2lXTkMxMzBiMTZIMjZ6VUtTSUFOOGZDd0w1RzVi?=
 =?gb2312?B?OEg5aGRwcnFYNyt0QkR6MVpJY3ErN28rYXhXWDRQZDVJbmEvSG9ybDVDajZa?=
 =?gb2312?B?S2JuTUUzcmd3VFFFRXhVcXp1Ymx3akhmVkhodnY2ZzNrOC9nVWloTzcveVB1?=
 =?gb2312?B?R1BVVWZxSXZCeDN1U1g2L05aQjFUY0htbnFISkFxMmZGSDAvV3ZOdU5xbGds?=
 =?gb2312?B?dDBnYS9vU2ljRWJhMzNDaytGTlFaNERWenpCeURENG84b2FhWkxqT1c0cWkw?=
 =?gb2312?B?eWxwMWJ1b2RBcE9BK2tvWE9qaE1rR0ttamdHbkNEejBHNDY0RWhkdXRKUllz?=
 =?gb2312?B?Q0FVbzdHQkpySzlyRXdLOFZpcktqYy9yRXNQUWhQa2RUTHRVNnZ0ZzVCWjd0?=
 =?gb2312?B?UHZQNWV3VUtxdUNRWjZvNzNjVERUb2xFRWZjVVcwNWN4ZWd5VmxTUUJkbVNu?=
 =?gb2312?B?eExQb0VqcVo3NVBwcVVhRWtVU1Rtc2ROTEVxNzJnNzQ3OUZuY04zV2NIYktE?=
 =?gb2312?B?S0ZDTHJIdE5SSW40enVFa3BCVnlwQmNkUGxlVjRNZm4zTjhmeWJCRnFwQjB1?=
 =?gb2312?B?NWR1c1FRSW1kWXQ1blpnNTBsQlFMY3pkKzY5a2dGbHN3ZHdKclFHYWRHYTBM?=
 =?gb2312?B?Y2hwcW9ZSTM3bm1yUFVsdEdhL3JPSzJ2R1BucVhaYmg2L1FDblE3VUpjeUVu?=
 =?gb2312?B?dzdueEUwNnVaRGVPcFQxYmtWRHZPSFFiNjlORk4yV0RSVFVCREJqR1lCbjZv?=
 =?gb2312?B?bTVTa29jeFEvc2VEKytwRGRSQjluNy9WY0c1dE54RUpxckxnd3J0ZW9vWnBv?=
 =?gb2312?B?T01CUlBabzlWL3Rsay80Skx6Zk92eW4veGtmYzVkdFgrSktRN2M5Zk05a21B?=
 =?gb2312?B?bXFlWkhBK1ZEZXZNbFhKTmFPK0xCaVNMVmFFSHJaZGVyU2Y5dkFQMUMxSFNB?=
 =?gb2312?Q?iXTYAwHjfzne4pABA+Pdf40XngW7tY=3D?=
Content-ID: <68EDEB733B77904792BBD5DB818550B1@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac5e66e-4a8a-4888-f46d-08da08941d68
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 04:02:26.7164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h11EYRmZmsXCBicvK+oxS08GGHJNZzSvNSrmrd++tcn/F8VvPuQlOUGNKw337pF8CVlbeXKJx+h6fEUl+U9vkeoNme8s8kInHRmOIKW9dNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3943
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] Make use of SAFE_ACCESS
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

Hi Dai

Looks good to me,
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

just some small nits:
Since quotactl01 use tst_brk(TFAIL | TERRNO), we should also
mention it ie commit 706d412a quotactl06: Replace tst_brk(TFAIL) with
TBROK does.

Also this patch need rebase since commit 26d117f8 ("syscalls/quotactl:
Remove tst_require_quota_support") break this source code.


Best Regards
Yang Xu
> Signed-off-by: Dai Shili<daisl.fnst@fujitsu.com>
> ---
>   testcases/kernel/mem/tunable/max_map_count.c    | 4 +---
>   testcases/kernel/syscalls/fanotify/fanotify17.c | 3 +--
>   testcases/kernel/syscalls/getxattr/getxattr05.c | 3 +--
>   testcases/kernel/syscalls/madvise/madvise08.c   | 3 +--
>   testcases/kernel/syscalls/quotactl/quotactl01.c | 6 ++----
>   testcases/kernel/syscalls/quotactl/quotactl06.c | 3 +--
>   6 files changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
> index a4c3dbf..caf8972 100644
> --- a/testcases/kernel/mem/tunable/max_map_count.c
> +++ b/testcases/kernel/mem/tunable/max_map_count.c
> @@ -58,9 +58,7 @@ static long old_overcommit = -1;
> 
>   static void setup(void)
>   {
> -	if (access(PATH_SYSVM "max_map_count", F_OK) != 0)
> -		tst_brk(TBROK | TERRNO,
> -			 "Can't support to test max_map_count");
> +	SAFE_ACCESS(PATH_SYSVM "max_map_count", F_OK);
> 
>   	old_max_map_count = get_sys_tune("max_map_count");
>   	old_overcommit = get_sys_tune("overcommit_memory");
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify17.c b/testcases/kernel/syscalls/fanotify/fanotify17.c
> index 35beb53..7d74b25 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify17.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify17.c
> @@ -159,8 +159,7 @@ static void do_unshare(int map_root)
>   		 * uid_map file should exist since Linux 3.8 because
>   		 * it is available on Linux 3.5
>   		 */
> -		if (access(UID_MAP, F_OK))
> -			tst_brk(TBROK, "file %s didn't exist", UID_MAP);
> +		SAFE_ACCESS(UID_MAP, F_OK);
> 
>   		SAFE_FILE_PRINTF(UID_MAP, "%d %d %d", 0, 0, 1);
>   	}
> diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c b/testcases/kernel/syscalls/getxattr/getxattr05.c
> index c0d339f..3e73cc5 100644
> --- a/testcases/kernel/syscalls/getxattr/getxattr05.c
> +++ b/testcases/kernel/syscalls/getxattr/getxattr05.c
> @@ -100,8 +100,7 @@ static void do_unshare(int map_root)
>   		/* uid_map file should exist since Linux 3.8 because
>   		 * it is available on Linux 3.5
>   		 */
> -		if (access(UID_MAP, F_OK))
> -			tst_brk(TBROK, "file %s didn't exist", UID_MAP);
> +		SAFE_ACCESS(UID_MAP, F_OK);
> 
>   		SAFE_FILE_PRINTF(UID_MAP, "%d %d %d", 0, 0, 1);
>   	}
> diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kernel/syscalls/madvise/madvise08.c
> index 30f3604..10549f4 100644
> --- a/testcases/kernel/syscalls/madvise/madvise08.c
> +++ b/testcases/kernel/syscalls/madvise/madvise08.c
> @@ -110,8 +110,7 @@ static int find_sequence(int pid)
> 
>   	snprintf(dumpname, 256, "dump-%d", pid);
>   	tst_res(TINFO, "Dump file should be %s", dumpname);
> -	if (access(dumpname, F_OK))
> -		tst_brk(TBROK | TERRNO, "Dump file was not found.");
> +	SAFE_ACCESS(dumpname, F_OK);
> 
>   	dfd = SAFE_OPEN(dumpname, O_RDONLY);
> 
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
> index 63f6e91..56c4f2f 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl01.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
> @@ -160,11 +160,9 @@ static void setup(void)
>   	SAFE_CMD(cmd, NULL, NULL);
>   	fmt_id = var->fmt_id;
> 
> -	if (access(USRPATH, F_OK) == -1)
> -		tst_brk(TFAIL | TERRNO, "user quotafile didn't exist");
> +	SAFE_ACCESS(USRPATH, F_OK);
> 
> -	if (access(GRPPATH, F_OK) == -1)
> -		tst_brk(TFAIL | TERRNO, "group quotafile didn't exist");
> +	SAFE_ACCESS(GRPPATH, F_OK);
> 
>   	tst_require_quota_support(tst_device->dev, fmt_id, usrpath);
> 
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
> index feb4750..0ac099b 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl06.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
> @@ -186,8 +186,7 @@ static void setup(void)
>   	/* vfsv0 block limit 2^42, vfsv1 block limit 2^63 - 1 */
>   	set_dqmax.dqb_bsoftlimit = tst_variant ? 0x20000000000000 : 0x100000000;
> 
> -	if (access(USRPATH, F_OK) == -1)
> -		tst_brk(TBROK | TERRNO, "user quotafile didn't exist");
> +	SAFE_ACCESS(USRPATH, F_OK);
> 
>   	tst_require_quota_support(tst_device->dev, fmt_id, usrpath);
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
