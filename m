Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE41ECAAD8
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 07:49:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3C3F3CAC07
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 09:49:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 403503C958F
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 09:49:45 +0200 (CEST)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 347011A004A4
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 09:49:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1663141784; x=1694677784;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ui1ZzXz74fCoTY8dg3GGoscUNK3HI/zoBc+41Wvlc2Y=;
 b=VfNBnh1K5yLSHRYez78zN1R3KF43o15MNpu/ca+rBwj4RJZ4Qhe0Xuse
 C/XqxOwjCTRuhil0WRaGNLo9CX2JTsLrbqZ0scDX4YZhnBLN7O0Q2vfpE
 fY5BzeFPYHQb4k/eu0FJMjyboBXjsnpC0g7eZh4VDy1UbbBAlPVxb1Lzh
 tC7oZGlb6pu3ucB9VtFVsQ9wU6WpeOhC641V781ftknsYLZLn0nhnCT8p
 gIjBouPE22q3b2cIv5e7xQ7IgrZXlojCM5MdV7NDwMVTmQT3NCMZDmPQi
 zwRMr6d6OrUiBwYx4ywbBgLUDHCwu85PXp5Lf1wdVua7+4LWJ4rS63cxB A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="65076428"
X-IronPort-AV: E=Sophos;i="5.93,313,1654527600"; d="scan'208";a="65076428"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2022 16:49:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTJJg61cMZoPIPe75Rs6ZVsJToQm5IdqEa8xQip2X/Xgctogwh9IQYWdtnr36LGf3nRl/HfsfMadC6CPbgej9txp6hajUDZ/E5YM0Dnu8eTiA6RqF9PI2MCMa/Fbkdh1HGNyMpBVT+Hc9b6+jDli0OrAqRM2Af0VrmBzZ80WsGink5RTITZ+iRZd4Fij+wVEB7oHQ81Y/BVqxSCTHvxO97Q4mM5ThI2bccvERiVXmJAmEEBqRnjEUXSXtExqWldEUqsINfv05alqJarZwqbNGy70UGiXDowxMjBQcIKP+VO98FUpJ+MC7UMYRT9jBAwkYRHjIBRmAW4tsPTOuDAwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ui1ZzXz74fCoTY8dg3GGoscUNK3HI/zoBc+41Wvlc2Y=;
 b=M2H9WFUQ1TcQSjV257lAuvx+Cr34P/gJBoHLI7O4JRi0k8A99/aebNZGzRyKNJhmp18d6AO4Udk6Sa+vNw3oVJzVao5B9RKoXRnZDowtmq4t1qm+FUcmoK2O9YR2hAV5y7c5uclaTrYKtDRYR+fZFTbxnYU7W0BzyhK0JnC1wDOzZraBVkKRkQi/GU6Mdse0r8xnG/bpbbLuqXgMiYUHu2yR3s1epC1DEUiJ3Inrtm1FaM61AtSH93FzVcLd8c7JC9oIu9X1qDHpu/zi0sj0eWg87Cf4ekXXMoXDkTCqGL5p8gZtPH8Q2UiF9cQ9kJDUNHtsku3RAombUbU5HDocHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSYPR01MB5526.jpnprd01.prod.outlook.com (2603:1096:604:90::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 07:49:38 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::a9fe:6054:eadc:7ef8]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::a9fe:6054:eadc:7ef8%5]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 07:49:38 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v4 1/3] syscalls/creat09: Add umask test condition
Thread-Index: AQHYyAlTrUVCU8c+IUqnRmjYm3bjvK3enf4A
Date: Wed, 14 Sep 2022 07:49:38 +0000
Message-ID: <e045de45-d68b-4bc0-6ee4-ba476adc5c85@fujitsu.com>
References: <1663143142-2283-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1663143142-2283-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|OSYPR01MB5526:EE_
x-ms-office365-filtering-correlation-id: d79ccb7c-9b75-48e1-b0c0-08da9625acd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GVumj4jE1QqGxJNqfiiqiNBjlGBIJRT0wrf7OhRNV+R0TE5wznE2DQJW8b4WWC5+yroYLWT6c8T9ojm0lMxYY6ULBWAYb+jqiVvLevg6l5iat/taCQfRnJXRi1DKUSgiYly9YDox//77WULB98BbC89/z2YIzWgZ+RUUhu39CI2y25q7brOMwX1s0UgPsRpy9oYUKVdjnCGM9DA7i/AuPlmbN3Rzs4nilEWbSAzBuHctT4LGgTlQeBYr3U87cpbKQ66gAskyH1vUWl17sZmkhe5MbVNnikKT26btzFv6W07mwaNcEp494wnZ5SXoJwccL5wc/ECH0NIXhDFjmxhD60OlPhvxCO00Is7Gj5VOW3E4+1uoQlU1ScumlWyFPCwyMhScEruHm5egwfusSget05Kb4tY/G2lq3Oe+Uq3GJ5nhfomY8x0gYGkfiwj4qmormV3Bkvl6FkjcJUjo8un0J7P8QoN34LotjPQpgbo8VdNmtDcfbUEtgLaTo8P1xX5d4ukjvrMFlrSfqcHo2Xcrl8ZErvdJ3P2jDBnWO9d1ZzigcUai8beAJQNOOfktLa3hZW2XjodX2NEFSKaR/rhGWo80L6lU3xeLfzLYMJgKMG1SAOCvNFvBhPfPg4tvYuRmE2IrUfVkq0M9QEZnz1OFpXskZks1mtw0rNjKA+C2AQD+Aw2v+1nlweDj/F8FGfCEiFtB6E0SEX8IYpc+0tf4uNuk12PAvKBAqkO9Nlbfc9zxsNGdTrfhfj2WwttUxrQIYIDkS0yzCTW0gik09vw5+dbioyd2Y14VAw6ivLxAjGXmA1x8WLsnBtc6H0FRpgvPVZkLh9kDw17eqtkgBkvzL8Zz+ttQgcIpDYCYwtzYX5U+zQshaHTOXILEKVUjvDumS5lDa5kqE5DlXBTwDZcyPg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199015)(1590799012)(8936002)(2616005)(86362001)(1580799009)(316002)(66946007)(122000001)(8676002)(5660300002)(478600001)(64756008)(4326008)(82960400001)(26005)(38070700005)(186003)(6916009)(85182001)(2906002)(66446008)(6506007)(6486002)(45080400002)(71200400001)(31696002)(31686004)(41300700001)(54906003)(38100700002)(66556008)(36756003)(6512007)(66476007)(91956017)(83380400001)(76116006)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWZHdmYzc2o5TUVZaEEvTlZsNVF4N1IxdE5CY1c1NmxNZlRKOVgwV2Q0ZFdu?=
 =?utf-8?B?bnQ3U1BRMGk4ZDM4bGtkT2ZEREVqT0RNWnZUdEJEVUIxQ3A3OElONjhUdHhM?=
 =?utf-8?B?VnQyVm1yZnJYTnNWbXVnYXlnR1Q1bjFMODZud2h6VHlDeUpSdUt1QnVYNkZI?=
 =?utf-8?B?QzgwM01xSDdUSFFReVRuRlJZSHNhSEJjLys5UXJCWkhnSWVIdmxMNWxXTndW?=
 =?utf-8?B?SGxTUXZ3TFdBSDNEVFV5SmlDUmEyQ1lONU9ueXhiVkc0WU11YkdrRlNFaUFX?=
 =?utf-8?B?SEZIY1hVMFlIMTBPdE5wM3ZweGJ4UVNmSXpwaWZValROOUxhSXE2ZTRRWVBS?=
 =?utf-8?B?aXNGT2I4UWhXNDdIMHMxdldIYmFkRVJ1MHFzUGRBZ1IvV2FxUEVnaExLYmZB?=
 =?utf-8?B?VWdkSzRnR2xpOVVhY3YwN0ZWeUlybXhIdFFqRGxPWVlxL1IyWVY5bVBxNXEr?=
 =?utf-8?B?UVRrR3llNDRDc082VUx4N3plMW9YRncrdnZEMFFIdjZCUDg5eHJLYk9tMjdj?=
 =?utf-8?B?VTJwMHFlMmRIVGhBZ2NKVHJ4UlpyMUF1RCtPbVJtT2JoUzlBSUhhRkgxVFlY?=
 =?utf-8?B?ZEhDazR6RTVUKzh1WEVDWm1Qc1MvWG9vdGxEcUV3TUxIL3BBUUdCRStaUUlL?=
 =?utf-8?B?bE9KRDZaWFQ4aFc4VGk0M3c2b0U5NEpVWGxmUmoxNzJzMVlLU1gwMnJOcWNI?=
 =?utf-8?B?bDZDTms0d3V3dWsxOGdhaFBxOEtRdHcxUTFheVhWS2JRMXR2SitSTy80WHdp?=
 =?utf-8?B?d201RFFscTJRb3FsU1RUWGxrdFpXZXlkZ2tpd2JVZExwQzE4bExKbDRMM0Y0?=
 =?utf-8?B?dlRTZEhLcStBUk5VUGtXODNOOEhmSEJTcnN1VnNvZTY0REF0by9zSzBETFZp?=
 =?utf-8?B?a0dUVFNURWdra1RKc2FpQjEyTHp6dHZxK1JHcEhVM3ZyUXFQZndHQTI0NjdL?=
 =?utf-8?B?cEtMc0VtdlBCc2ZxY3c2NUNVQ3ZmYUV1Q0R6SUpCZjZMaFZVL0pYV1VzbTJC?=
 =?utf-8?B?ZFdWMjhDMDlncmlGVFBxOU44S29HOG1iNTZ2R0FlTFN3MTJaRXM1MTlzbHBq?=
 =?utf-8?B?akhyN0tjYko3ajRzRXNWM0xKVmV1eVRtUXlhNUowWTE3amFSUnVGMXpiVmI3?=
 =?utf-8?B?WmtMWXlkZG1WdHNoZjk2dmp4SHZnT2FCUUJ3OGxXRjNNN3ByM0c0aEcxWEll?=
 =?utf-8?B?aFpZd2RLa2hiTjdvL2psUUswV0c1bElCWjFpaWUrYWZFaHZQUTFtVjA3Q3BK?=
 =?utf-8?B?TENrSW9ZcmcxRlA5S1hnY01pRHkrWUFXVDVuc0VKSGlhdVpHcW1CaGo2ZmhE?=
 =?utf-8?B?UXptRzlZMlk5TFVkNDVZR3ZZc3FkUGwvdTArd0tGeGt4QktsWm5mK2FKQ1di?=
 =?utf-8?B?YTIvbkQvUnRIUkQ1cXdseXdXMTNGV2pXQlgvNlpTeWtrT0RxSDBoQUYrREsy?=
 =?utf-8?B?eU1Gak1XTzhZMVhkTW4vbVFMSEdpbnpqeGd0WnRVTDRVOEwrNm8rbTBiRDlQ?=
 =?utf-8?B?YVpHdGFzbGNXNzI4L0ovRmZ2eGh3NW1yaTJTUnNTSTVkMExGR0FpRTRKdVI1?=
 =?utf-8?B?QzVrRFNjMHNXaExuWnp3dFVLREdYV0JoMFAvdFdwUmdsQ1VOL0M4QWFoY2Rw?=
 =?utf-8?B?OERHUGNtVlhSNjRqNDhPdFdjVThwZ042ZnUvNHdZTSt1QzdKYjllbEwzM2l6?=
 =?utf-8?B?Z2JWR2JiMXg3VC9oRW8vWG1BQmxyTGhJYnV2OGl3eHM4ci9ycWJmRFFqVkdX?=
 =?utf-8?B?TjJVRjNqSFF6SnRVQVNEK3pLcEpScmo4MTFUSUNvYzVTM0tJTlJMbWNoNkR4?=
 =?utf-8?B?NEVGK3dkcEppMG1LZWdZOG9VQlFhay9RUzBaN1I4WFRMZGt2V21CK1FkMmV1?=
 =?utf-8?B?Ykh3emhzNWhuajFDQk9jMUU0WG01eXIwd1B3S3o2b2VydmZ5MFZISmFDOTZP?=
 =?utf-8?B?NzFhZzZYQmlFVEE0bURsOEpWRTFYWmptbkpValpsUEN2ZjNaSVpPZ2FkQW9m?=
 =?utf-8?B?cGNrOUNLQm9LY3NDWTYrb05BTm9zc0s1SkRKcDBQb09pOG1HdWVKRkNGTW82?=
 =?utf-8?B?MUhVTnc2TUhlK3ZHa2ExTFNVYU9LYkFXdThzT1Q0VVdWeC9zTWU5M1dNYnM3?=
 =?utf-8?B?d05zREZFQ0tuQ000cjNCYk00Rlh0VmltNENOVUd3KzlPOWNQcEZVNmZkakhR?=
 =?utf-8?B?QkE9PQ==?=
Content-ID: <1A121531E63AFB46A12927D55C1614D5@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79ccb7c-9b75-48e1-b0c0-08da9625acd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 07:49:38.3494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: selJX6K/XWpH7zuNp/jGIgKkVkROtbhKaZRCbryPUw8Eqw0S9+g2IW5/mU/vvablRiOwnBTMsXonYsJH/sDwqx2+9gbbXyjuxcTHwgb7tp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5526
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] syscalls/creat09: Add umask test condition
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
Cc: "brauner@kernel.org" <brauner@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Hi All

> A kernel patch set that fix setgid strip logic under umask(S_IXGRP) found by
> this case has been merged into 6.0-rc1 kernel[1].
> 
> I will add acl and umask test[2] in xfstests because there is more suitable
> to do this.
> 
> Here I just only add umask test condition simply.
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1639a49c
> [2]https://patchwork.kernel.org/project/fstests/list/?series=662984

I Should update the [2] url because the corresponding patch is in 
xfstest for-next branch.

[2]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=for-next&id=c875434286737e792d200cda2eb679e2a8441837

Also miss Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org> tag.

Best Regards
Yang Xu
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   testcases/kernel/syscalls/creat/creat09.c | 30 +++++++++++++++++++++--
>   1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
> index bed7bddb0..d583cceca 100644
> --- a/testcases/kernel/syscalls/creat/creat09.c
> +++ b/testcases/kernel/syscalls/creat/creat09.c
> @@ -28,6 +28,16 @@
>    *  Date:   Fri Jan 22 16:48:18 2021 -0800
>    *
>    *  xfs: fix up non-directory creation in SGID directories
> + *
> + * When use acl or umask, it still has bug.
> + *
> + * Fixed in:
> + *
> + *  commit 1639a49ccdce58ea248841ed9b23babcce6dbb0b
> + *  Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + *  Date:   Thu July 14 14:11:27 2022 +0800
> + *
> + *  fs: move S_ISGID stripping into the vfs_*() helpers
>    */
>   
>   #include <stdlib.h>
> @@ -47,6 +57,14 @@
>   static gid_t free_gid;
>   static int fd = -1;
>   
> +static struct tcase {
> +	const char *msg;
> +	int mask;
> +} tcases[] = {
> +	{"under umask(0) situation", 0},
> +	{"under umask(S_IXGRP) situation", S_IXGRP}
> +};
> +
>   static void setup(void)
>   {
>   	struct stat buf;
> @@ -94,8 +112,14 @@ static void file_test(const char *name)
>   		tst_res(TPASS, "%s: Setgid bit not set", name);
>   }
>   
> -static void run(void)
> +static void run(unsigned int n)
>   {
> +	struct tcase *tc = &tcases[n];
> +
> +	umask(tc->mask);
> +	tst_res(TINFO, "Testing setgid behaviour when creating file %s",
> +			tc->msg);
> +
>   	fd = SAFE_CREAT(CREAT_FILE, MODE_SGID);
>   	SAFE_CLOSE(fd);
>   	file_test(CREAT_FILE);
> @@ -115,13 +139,14 @@ static void cleanup(void)
>   }
>   
>   static struct tst_test test = {
> -	.test_all = run,
> +	.test = run,
>   	.setup = setup,
>   	.cleanup = cleanup,
>   	.needs_root = 1,
>   	.all_filesystems = 1,
>   	.mount_device = 1,
>   	.mntpoint = MNTPOINT,
> +	.tcnt = ARRAY_SIZE(tcases),
>   	.skip_filesystems = (const char*[]) {
>   		"exfat",
>   		"ntfs",
> @@ -132,6 +157,7 @@ static struct tst_test test = {
>   		{"linux-git", "0fa3ecd87848"},
>   		{"CVE", "2018-13405"},
>   		{"linux-git", "01ea173e103e"},
> +		{"linux-git", "1639a49ccdce"},
>   		{}
>   	},
>   };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
