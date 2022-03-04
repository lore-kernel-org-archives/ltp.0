Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EB3C433EF
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 01:36:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6749F3CA34E
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 02:36:39 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 511B63C9600
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 02:36:29 +0100 (CET)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 70776601259
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 02:36:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646357788; x=1677893788;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=dUjxSmUIIVV7eqbyeErJuvWnpI1i6FL+9KUsxfeYscg=;
 b=UJmF1RfxNGasmnUL0G0zaWsDJZkJHwb+RJ6FGSsKCl8g+yMthQy5Djp4
 ne10IOvRbJVxmPIX7a9eK+qW8Fp6Mz/a/aP9AjDZ2xq/Z+OsLHbIvzO+d
 0L/ZZn/+nO6F/qhHP1i/z2EM06pIaLC1zkI9w2GJ00D8gsAoMtt8CihoB
 8euaiU5l5Qgo4G2mYUljvJbRYOfutOf+L3Hw9JQySFWcCBETFkQm+A7k+
 Mhk9TntbJim/GLsuGjpInrA/HX+nAr04xgGdkmK+ALdypQcMiVeXvXyN5
 o/6IT4anDDuEOgmybFXGc5zVO0FgmyJewWIKlOvpt6dVAVS6ZqBHkzXKE A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="50957896"
X-IronPort-AV: E=Sophos;i="5.90,153,1643641200"; d="scan'208";a="50957896"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2022 10:36:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4DkCuPYQX4avaDAwra6smIamfYbrEK+X/zsTnWH32RA4LeoEhg4cpS1alWLRA3nplGkjCwWSUv2S/gaRhNdA+HK4Yn7OZ3uyP3pXziDbtxsyo3IrMP2gZeDciQaN0nQeUtxw2qR03sYckt49A9T62hDpsRwjbasg41nPj3Yto9uwalUAIeFlGhPRXN7QeThJ37HHkctXkks1i32y5r4GuG62BXeaXOjw3vUHTrOvz07TcP5WcOae2tl4Ywo/ooE8uq1hv7rtrYZd9jDlmx88MovJdyqISUrdMPjKdh7dpk4Trw0Ymy84wAxMpptovNeXeIAs4KDIRgCdqGgMeEd1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUjxSmUIIVV7eqbyeErJuvWnpI1i6FL+9KUsxfeYscg=;
 b=CDKrwUM/GcQiHABKYs7OSrbkugkgrjay5l9TnLbvYF6y3pR1hC3LPXBzvOeYkDJBXeGX4xR7tUJetDiif7ZT7yeH/Pq2rFpiK0t6kSoACAmICgD+s8Cv9LMKHJGYKUqF74Uez+JlhM80r/KzMvNlp9WwoNjoox6Dm+AD+t2cZ8TAM0Bmyuz1agj2Khh+ZnLBysiMfcNK3RTsiznoPAUVYp7OF7/b+t0IL8+fjORnM/monQV8NHdI57udPF4SR9lpK+aiRLXTfMGVpjxrZ30A7qAYshXVdfKvHtE20E6KtBqrQB4oCYZ/Zcknfujs6HhSTeuhunmQnjrM9fyVc+2KAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUjxSmUIIVV7eqbyeErJuvWnpI1i6FL+9KUsxfeYscg=;
 b=A94B8R656dQpQFSDKVZZ4QQNWUHniM8uRMk6R7vOV8ut77c+Mg6JNklovDgcTnrZu05t/mSLR6M1DjJ3QOmB49jSYmpITZyvvIHzJh0eQfZCR+kMi6ynlHrgNSRvsXPkVLz3YDxW1I0XzBwkd8hWFWhCoY6xuJqy6qs1rXBd3lk=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB5292.jpnprd01.prod.outlook.com (2603:1096:404:7c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Fri, 4 Mar
 2022 01:36:22 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%5]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 01:36:22 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Martin Doucha <mdoucha@suse.cz>
Thread-Topic: [PATCH 2/3] quotactl06: Code style fixes
Thread-Index: AQHYLxPF4gv/zTFt4EeuGpkwHHwlfqyucpuA
Date: Fri, 4 Mar 2022 01:36:22 +0000
Message-ID: <62216D4D.9050806@fujitsu.com>
References: <20220303153131.3372-1-mdoucha@suse.cz>
 <20220303153131.3372-2-mdoucha@suse.cz>
In-Reply-To: <20220303153131.3372-2-mdoucha@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8b68cbd-82ef-4eff-5282-08d9fd7f63d0
x-ms-traffictypediagnostic: TY2PR01MB5292:EE_
x-microsoft-antispam-prvs: <TY2PR01MB5292DFE8A48966FD62956CB3FD059@TY2PR01MB5292.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YKIuiiZ5INiEtgKnG1OWXIpf4LQTMOxh5ncsVZFgIseALrqxe2oDPcrdNqjq0szeSc6mF0xbGjt5DMLZF9vfD4TfxpKhWfJez10PPiSdvQXWubc+krCamkV2rgtdsDf50tfYfOejQTX+el+6MtzHkgJYpbBlDNmEaIYsMw8Qb17da9D7Zlsih9HQ35bvXf8oGrUYz+BXOPKcTnPewUNarzMGtDG1ghax1BcN2awfXjY1s1f5yGkqZ1nlcmT7Kf6JVu541Ik9Dwlub06pxTWr3bAQt2hfVxhmOh9dclP5o4tZHjd+f6XvKg3+kgEj724U8bpAyjBHVQwaUD37mJNdKTfiNW39cQtcNoJROJPmQtW+3ZXt75I2Zr21Z4mV0J0yi7JAWOuMySlpkwBig4eRTbjijrfsnblIb1UbW51zF/r7XO8E5t1a4stC8diIM5OOJJyrQRGywGDhQC+iC1skxQUllGaJy6ubGaatqFgXd4t+vIha2/LC/b2RZ721S03sKzMxeytTnh1hgUlwl4yR0Pc5w7xH1d1tHtEeFjFO14J4N5BPljBrDhW+7rTnXbVfjIrZoi+LYvc8UqbuEedmTfHgpIbjC6MoerEeJ5cWKoDmqkNFPqwoP2r9PhaChXDYaoG6NKHoI3D9zKPFJahykgNf+K71cK7TM/Xy9IsjKzIKpFNY+AHzGrqPw/KLmo/+mkaVgGD3LnRnqCDtIMNE0Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(2906002)(36756003)(5660300002)(34290500002)(83380400001)(122000001)(71200400001)(508600001)(8936002)(15650500001)(82960400001)(85182001)(6916009)(33656002)(6506007)(76116006)(2616005)(6512007)(316002)(66946007)(91956017)(38100700002)(4326008)(8676002)(66446008)(66556008)(64756008)(66476007)(86362001)(26005)(87266011)(186003)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?YXlkRUZ4TERzdXRyb0VndjhCQU4xWXh5RFhxaVNWaVlNRjZyU1dlRFF0UWFq?=
 =?gb2312?B?cG1PUFRMRjN3dENRejVhL1I0SWI0dUx2SUltZlA5SHErckx4endSbi8rRWNn?=
 =?gb2312?B?L1c0UUdMUzNhWjIwdGxaTVYzcjBpV0ljeG11VVYzOGwvT0JTZnVrMnZjd3k5?=
 =?gb2312?B?TzQvR1oxeDgvSUwzTXVzNFlNR1dkcnBSQTZaTHBLQ0w5STlQRTNJdllHSlMx?=
 =?gb2312?B?NDFwOEVQYXhNTXZFMUJNRDhMYlFHTGxZVFRlRHZkU2NaWXY3Q0pmVVN3VFlK?=
 =?gb2312?B?eVo2YkF3VHdSenR2V2d3TWlCdVg2TUhXd3JVeDQ2N2k5ZkRzNlQya3h3dlM5?=
 =?gb2312?B?KzBPV2JieWZaeCsrUU9jWGFSdlZCM0ZPdi9ITnNFejVYelBLYnVGbmhGZE5B?=
 =?gb2312?B?WFdhYVZSZXluWWEyTFBOdVFBODhNNHFJMXFnU3V2S0EwZDl3NlY1ZGppd0lB?=
 =?gb2312?B?Y0IxTnBQUTNnTUpVYTVkVTk4QU9YQ291a09xZ1RwbjlXWnVXWmQyNnNCNnAw?=
 =?gb2312?B?ay9YbC9rTUtVM0E4cmlFVEhpYjBuelEwSG42Tm9KenB0b2JLN3QyODFEVHV2?=
 =?gb2312?B?a1daYzQvQUM2dDVpMDlhT1ppQ1ovUzNrYXAzMFVTbjBJY1luM1NKM0hqbFFj?=
 =?gb2312?B?QmJjQTlsSm9PTm1wOVdER0RHN1VIY1dqendnbzhsOXpWaWhtQUhEU0ZkUHU2?=
 =?gb2312?B?aTNuN3dpOHlhOWNONkRZd3hzd1BZRGZ2RDJBeHhUZ1JCa2lKVm9UU0UrUmdv?=
 =?gb2312?B?dGlGVzhUNnVVaVJjWjRidGdVdlJ2bFd1Y0hJUnlMK3c4Um5qa3NhSGx5ck9X?=
 =?gb2312?B?UFJVR2o2R0VxRVBNT0pFdVQwS2g0YlJ6c2lKNGE2YytGZFVNaytzUDdlbFFN?=
 =?gb2312?B?Sm9BdzZoOEhkZGhMSnVpZEhpUUk4V0dOeHVSUERMV1B4YU9ieUFyenE4bkxk?=
 =?gb2312?B?UjNCaXNXaUZESjB6MWJwZDZxQ1I4eFBLWGd5MU5SQTNFdEtkTGtZUlJ6a2ZZ?=
 =?gb2312?B?bUpYZHl1SWE1NjE3dnZxSThDcUJldzh6N3RyMzdKUGZLRC8xL2RLekU2K1pq?=
 =?gb2312?B?eFp2Si9KNTRpZ0hseVRGalJQTldtRlhSVUFQaXJjKzF3eG9ubkhQbUIrZFh1?=
 =?gb2312?B?SnNMdkVESXFYVnkzZ05iQnc1RE8xWEwyN1hKNHJtL1NCc21zVmpBUmtrS2tk?=
 =?gb2312?B?cEE5bDlaUE9mL3h6bndqb1dleklycm9Bc3h3THJFbjBKWUxDSEFXZUN0S1I4?=
 =?gb2312?B?czJjbEZYSndsVHFCZVJTL2dNY01uQ2lOdjhNYWxuYkV3MGZIbWNLZjFGaTBw?=
 =?gb2312?B?c3RaeWxvM2prN2ZISVdpSm1RQm1RZTc4dG9LWUF2ZXZVelBqNVJzc2Q0M2lU?=
 =?gb2312?B?Y1RWbENjUXdJNXlYNlZOd3lDcG12RzJKN3dzZ3BSSDl0dDBwNERYUlJuV3R3?=
 =?gb2312?B?ZTk2V2crRklWQW8wUnR0MlZkTHlaRnRJUVd6elFDMTlCRmZXaE9ibEFPOGJx?=
 =?gb2312?B?Sm1KVWkvRWthK3FUa2NmZXdpZDE1MTlKaG9UaElIbU9uOGh1dWZzNlRQbUFB?=
 =?gb2312?B?a00xT21XOFRYL1Q4VkkzMUZzcnEwUmVPc3Jtd3E2blZXclZMUlhsdENGRWNt?=
 =?gb2312?B?cmxGUDVlMTBkcjlyazRPdTZ3OGlrOHJYTlptYVpOZnk1VmlBZVVHTnNlMXcw?=
 =?gb2312?B?TjZSMmxQeTI0VE1nd0p5cElBUWh4QnRsdktNcTlON0hEdnp2dVJ2dEREVGc5?=
 =?gb2312?B?STIydHg0U2dTRWVoQzhScFdZVk5XMkFseGxVaTNweWxmR2JBQkxLcXN4Szgr?=
 =?gb2312?B?dDROdk5qSHVHUGJFU1pFbDZhdUI3NldRcmMyZnRGOTdBUUN0cUUxMUdSU1N6?=
 =?gb2312?B?UmxsS2tmZS9oY3VqT2tEL0taYUJ1OE5haytGV3c0MEVFTUFzS09aOXpYN0lT?=
 =?gb2312?B?b0NUV2J3aTlXTDYvN0wxSlhmQmFkOXVXRkVqbDVNazFKY1dCdVg5dFk4Qnl4?=
 =?gb2312?B?NGdNc04rcWZvdVcwQzBHdldvZG1FV0FPV1FDcVhSWnVkakl1NlpCTEQwUGJV?=
 =?gb2312?B?WE1UVEtwWW15Z0ZXYU1KQnlNL2ppU1ZpK256WWpGM1FHUm1zWEZmZUNuRXFk?=
 =?gb2312?B?UC91TkU4VTFvYzRFdHRWYVFQK2U1Rk1wMzlKTWYrakk4ckJMM1ZEUjIySC81?=
 =?gb2312?B?ZTYvV2xtNThNZTRJM3VkVCt0RUV4L0czT0VKV0M4WVZxTmtsaGh2OXIzdFhS?=
 =?gb2312?Q?TjQtrIkd33TkOg75eBwHzZpj6OBgg9avzgKoJYk6ks=3D?=
Content-ID: <D9643B73ACBFED449C800B6892ECB6C2@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b68cbd-82ef-4eff-5282-08d9fd7f63d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 01:36:22.6438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r6glUaeY7KpXXhVQ5kU7Rkld8AVhBkXPD6meWF1LpAKCT9CGGNh+DTUrYVvy1DO8oBs10xn9Wk10zLM20Nk883Hs1y5n8IkGCLqX3DCFeoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5292
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] quotactl06: Code style fixes
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

Looks good to me,
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu
> Signed-off-by: Martin Doucha<mdoucha@suse.cz>
> ---
>   .../kernel/syscalls/quotactl/quotactl06.c     | 49 +++++++++++--------
>   1 file changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
> index ca81a742f..8e9a17393 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl06.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
> @@ -12,22 +12,23 @@
>    *
>    * - EACCES when cmd is Q_QUOTAON and addr existed but not a regular file
>    * - ENOENT when the file specified by special or addr does not exist
> - * - EBUSY when cmd is Q_QUOTAON and another Q_QUOTAON had already been performed
> + * - EBUSY when cmd is Q_QUOTAON and another Q_QUOTAON had already been
> + *   performed
>    * - EFAULT when addr or special is invalid
>    * - EINVAL when cmd or type is invalid
>    * - ENOTBLK when special is not a block device
> - * - ESRCH when no disk quota is found for the indicated user and quotas have not been
> - *   turned on for this fs
> + * - ESRCH when no disk quota is found for the indicated user and quotas have
> + *   not been turned on for this fs
>    * - ESRCH when cmd is Q_QUOTAON, but the quota format was not found
> - * - ESRCH when cmd is Q_GETNEXTQUOTA, but there is no ID greater than or equal to id that
> - *   has an active quota
> - * - ERANGE when cmd is Q_SETQUOTA, but the specified limits are out of the range allowed
> - *   by the quota format
> - * - EPERM when the caller lacked the required privilege (CAP_SYS_ADMIN) for the specified
> - *   operation
> + * - ESRCH when cmd is Q_GETNEXTQUOTA, but there is no ID greater than or
> + *   equal to id that has an active quota
> + * - ERANGE when cmd is Q_SETQUOTA, but the specified limits are out of the
> + *   range allowed by the quota format
> + * - EPERM when the caller lacked the required privilege (CAP_SYS_ADMIN) for
> + *   the specified operation
>    *
> - * For ERANGE error, the vfsv0 and vfsv1 format's maximum quota limit setting have been
> - * fixed since the following kernel patch:
> + * For ERANGE error, the vfsv0 and vfsv1 format's maximum quota limit setting
> + * have been fixed since the following kernel patch:
>    *
>    *  commit 7e08da50cf706151f324349f9235ebd311226997
>    *  Author: Jan Kara<jack@suse.cz>
> @@ -135,10 +136,13 @@ static void verify_quotactl(unsigned int n)
>   	}
> 
>   	if (tc->on_flag) {
> -		TST_EXP_PASS_SILENT(quotactl(QCMD(Q_QUOTAON, USRQUOTA), tst_device->dev,
> -					fmt_id, usrpath), "quotactl with Q_QUOTAON");
> +		TST_EXP_PASS_SILENT(quotactl(QCMD(Q_QUOTAON, USRQUOTA),
> +			tst_device->dev, fmt_id, usrpath),
> +			"quotactl with Q_QUOTAON");
> +
>   		if (!TST_PASS)
>   			return;
> +
>   		quota_on = 1;
>   	}
> 
> @@ -147,16 +151,19 @@ static void verify_quotactl(unsigned int n)
>   		drop_flag = 1;
>   	}
> 
> -	if (tc->exp_err == ENOTBLK)
> +	if (tc->exp_err == ENOTBLK) {
>   		TST_EXP_FAIL(quotactl(tc->cmd, "/dev/null", *tc->id, tc->addr),
>   			ENOTBLK, "quotactl()");
> -	else
> -		TST_EXP_FAIL(quotactl(tc->cmd, tst_device->dev, *tc->id, tc->addr),
> -			tc->exp_err, "quotactl()");
> +	} else {
> +		TST_EXP_FAIL(quotactl(tc->cmd, tst_device->dev, *tc->id,
> +			tc->addr), tc->exp_err, "quotactl()");
> +	}
> 
>   	if (quota_on) {
> -		TST_EXP_PASS_SILENT(quotactl(QCMD(Q_QUOTAOFF, USRQUOTA), tst_device->dev,
> -					fmt_id, usrpath), "quotactl with Q_QUOTAOFF");
> +		TST_EXP_PASS_SILENT(quotactl(QCMD(Q_QUOTAOFF, USRQUOTA),
> +			tst_device->dev, fmt_id, usrpath),
> +			"quotactl with Q_QUOTAOFF");
> +
>   		if (!TST_PASS)
>   			return;
>   	}
> @@ -169,7 +176,9 @@ static void setup(void)
>   {
>   	unsigned int i;
>   	const struct quotactl_fmt_variant *var =&fmt_variants[tst_variant];
> -	const char *const cmd[] = {"quotacheck", "-ugF", var->fmt_name, MNTPOINT, NULL};
> +	const char *const cmd[] = {
> +		"quotacheck", "-ugF", var->fmt_name, MNTPOINT, NULL
> +	};
> 
>   	tst_res(TINFO, "quotactl() with %s format", var->fmt_name);
>   	SAFE_CMD(cmd, NULL, NULL);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
