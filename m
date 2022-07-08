Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97DFC43334
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 01:19:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 638533C9F7C
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 03:19:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 061953C95D1
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 03:19:44 +0200 (CEST)
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com
 [216.71.158.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 050471A00A28
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 03:19:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1657243183; x=1688779183;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=wva2T5dGMUcZv9LBVz9l689NwVbb9J3awVeIgizY4Qs=;
 b=Dv4w/pFnUqXJm/9ZnVhIeDydBgE4DFVa75Ovhz2e48IQ6gyVfuNhHxZY
 FB1aPcteVloCQbClpw9W+RSPR153xdTQT7vNF3OftH3yDN0+vq8Ps3wYu
 LLuj9H5gkjc/kcDs55yO9eCFfNEm2wGrln4rtUH3EeVoUpRHYOuBKzzes
 R2xenvhr5Q6Jx4jzPqMuwSdZsIWxtvjZb0vksnfi1nPPC9WgBxqAT+5vR
 tz3osCDJC81YpgnTPWnCcmVzVrUe3s/gtnSMvp5MrYtiIQ0WPPCHIhZY6
 CVODEur2F8Cr+Zr4lPet3C4lSCdApm+gYs3D2oNn0ZkoZGYGyKUqGGYxb w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="59823108"
X-IronPort-AV: E=Sophos;i="5.92,254,1650898800"; d="scan'208";a="59823108"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2022 10:19:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SW7XWocIOc7+AK9zhlOIKgv7ZXSY5HiikzUJNeLU5Ty0095SPRBGf5tykfBX0F6ActPyy4uENNWDFt1XroWQssfqAjyDPNYHdFHsrunIFahxBxqO7WyI2sHpA+dVdXORuHO2w73deu/HpkhfVzGPLOfo6hgvi4p5iJzyq/cb8/OUEIwFV+BLYrkogmWn8wK5YTVVJ07vx4/IbV9N3HWk5bk6DkC6Bz4h9tjJ8Z/lakZHL8Yj0W6FgL7dCtpy6a+OGUhttPD1+wlcVFmHh85PYKf7AWANcwqIKFnsm9vHc1dN0WD4z07jC/jVLGcWtV4yf03nJQjolNze8yo95nm0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wva2T5dGMUcZv9LBVz9l689NwVbb9J3awVeIgizY4Qs=;
 b=jsr0fiXuiVWQC4r7rbVfZtuDYGA4py0tTA2k4rTZNnlxVPYNHfLQg3O978MOXEpY0X3oQl6jsJJSgc/MORF0+AWsNvZru0qf4y9pdi/cesonugN+eNuXGdZkBiu4zX+Snd0FyjU3/iFsGXDcWIRLyJuXCJJKLm1q2cyRswIv4T9EOnSX2GiofErAq13+tUznjgSIjakyDnz4KUDHoCh2t7xfvMMqFoPuIyHfgfK8RBPPzM6mBTWH2cr3Ozs0AfXo4aMTjM7oWSAYxbqLPB0+Y8byZCnFlpJ238Tij5eGqluz/TPfltHZaAvxv3QgFjs3g0EG9Wpalpo9SQUIGnR5Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wva2T5dGMUcZv9LBVz9l689NwVbb9J3awVeIgizY4Qs=;
 b=MWWsw3oQ029wjowfx8UEqYjxkBy2kCb+45UJLV8jx8/dkaVjpqaWX10p3dqUGp8LAyMqacfqzKwm3Jzv2wUKzslzY4EnZcJb5Ib/6PuJ1UMsttaP6NCzBXuxbz/jlzoOI7mTxgH14ufFXJyOZNWwnJEz48Bbbt7sWbuNtVMoRe8=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSBPR01MB1479.jpnprd01.prod.outlook.com (2603:1096:603:5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Fri, 8 Jul
 2022 01:19:38 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160%5]) with mapi id 15.20.5417.017; Fri, 8 Jul 2022
 01:19:38 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Thread-Topic: [LTP] [PATCH] syscalls/creat09: Add umask(0) to setup
Thread-Index: AQHYkmYH80j9RfRGdESNGBciVqI2ha1zvc6A
Date: Fri, 8 Jul 2022 01:19:37 +0000
Message-ID: <62C79471.1090700@fujitsu.com>
References: <20220708005657.108858-1-zhaogongyi@huawei.com>
In-Reply-To: <20220708005657.108858-1-zhaogongyi@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ac99d11-95c1-46cf-7c45-08da607fed03
x-ms-traffictypediagnostic: OSBPR01MB1479:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5f7uSDvoEfY3HKX7m0trFRXVMiT/ssZijcUUazatFy6NG7xzeEfVhrK95i6mtswH9fwNftJSPDpEqngv963xsK7mWsy24dtifDvfxMQcFDLMqKtvLUSATVnm2B4mdPASJY1SqB7T7bW67qgLNV3vemPY9OPSGWd8TeGGwZNxHYyt0Rt/pFrGjvyZTGIkFjOCSjTI1qqSBmJnNGoae4skfWNVtrylZb85vhFe6uH80gGkVRMCIRhsLnmd0fY0Jdc5/oMq9gDacy4QxtjABVP2d5btQX/RwzpEd9a01DVA2vxrZGaL+A0Eiz7dIN/BuqVG3QwEWhi86GQyWFe1dz0tLGf9BgH75hgWnv4UucfIBJkJrVcdRc4tn7KhI9SC0p8aNsJaPpXyGPDAWY/7LwCPCQ3pRUZBKIkBe3L5ztiq5GNGIe20wSaIpquwiW9IsIfriXEINHZjYUt7W+dem1FfchPOcxEpVy3NUdnXS2crrqp1HoUJxLWlwCbIg47I0Bh/4aGQdBG7q1mLbAvzZ6IPgOsEiNMGAxLrEwI7NVtL9wYWm3e7jrvNo+dZYpGDXwLgPC/Bd2u47n6p7lZizOcba0bPXaehLTourAgYILceYfDpdzHVljihq2WJsaeZ1nJbRh8rYalOgpnONLfuzYYulAUdPurzQS7kYJsIJPa0SxGIikkmzFMuf6p7MsVc7izrQAFSnyYeh+ePSHIPvzXNUr7sO8Xq2HFbYY0j2nZPomWRQjQZFdMH+cq2yCoVYlN3grrrcMtPXlGpZ0DVjGYTIfHwNWrInXK3UiXmK1IPRCAwcV+hs6EAt2/YU3K7cBPdUxOTPdwzHab8SQMc7r51HNFrSE8RHQ4DBq5Cv2nBiiE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(64756008)(4326008)(26005)(82960400001)(2906002)(8936002)(87266011)(41300700001)(33656002)(5660300002)(71200400001)(478600001)(85182001)(122000001)(6486002)(6506007)(66446008)(36756003)(66946007)(91956017)(76116006)(66476007)(38100700002)(66556008)(8676002)(6512007)(38070700005)(83380400001)(2616005)(186003)(6916009)(316002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZFgyQWZFS0hackpqQmpYYWNueUhRRC84VlZ4LzFRYlJBYTJqdzNsVnBNKzFk?=
 =?gb2312?B?aXRuZ05sMzFoM2N3Nis5bmp3ZUhRc25LS0tSRjBUM0VhSFBVRTRhd0d3cHcz?=
 =?gb2312?B?ZFlIYVEyTkdHaUIyVENKcWNOcUllQzdtaXk4bjJFQ1Rqc3JNdUVlK2JlQXZU?=
 =?gb2312?B?Mm1ONHdqdHhlUy9FalJBV1duS29mY3NlLzgwaWtNaFFXbitQNWJESFZzcGt2?=
 =?gb2312?B?TEJ0R2NNWmtGQkh6TWpIZmVjbkhYenZYdWI3dXhwY2ZGUS8xNyt1SmVDcmFx?=
 =?gb2312?B?eGhyNkRrcGc3THBtOVg4SW5sdVBkeFI4YzVkaDdYbHpxMUx0cVB5Sjd3SHJm?=
 =?gb2312?B?bVFiaDVRL2doQk9BMmpqU1ZyVTBoc0ppb0k0d0xwVVlXVnBGNlNISGp3TEJ3?=
 =?gb2312?B?WVVJTnZkTTFOMUtOMGdyWGNBakwwWSt1Q1l1VDZBekQxNk15ZUJNUGNhTy9y?=
 =?gb2312?B?THdkejJnUGp6TnRucjk0RzZMcVFUYi9pZnlLTTZ1bXN5eTNKYkVENHpmS0FB?=
 =?gb2312?B?SDF0U0lUMW1VMGtXdlQvSzFDcjR2aVVOVFFQYWxMeGwvazBMa3dsZ1JmQTBi?=
 =?gb2312?B?M1dUeDg1N1pXRFZWRXB0dmx0M3dyaXFWd244Z0c4SmxOcWlhajdNK2VTM0JU?=
 =?gb2312?B?MUdNR2Nyc1lIYTd1ckxDamd5cWxXdklUOG9CZkU4MDNyZk51WUtyb2NUci91?=
 =?gb2312?B?dzJLNk5oUUdhZUpXaVB5c0Y2UUo0MDBxUW9DWEhPUXdmR09rVHh6ZllYK2VV?=
 =?gb2312?B?UnppNUNHZFIrTlFScW5hUVNqVUhyUzhZRDNuaEo5N1hRKzhwY01rSHh6bVQ5?=
 =?gb2312?B?WFJMdkdScU1Mc1FNWFFKS3Zia2g1S0QzNm4zalhDQ2FGTkh1bGE2aEFLbVJ0?=
 =?gb2312?B?TFJyTk1EeGZGaFd5YmsrQi9LcDBKc0tleW95SnNheC9UWFhxOEs2WnkwWXA5?=
 =?gb2312?B?Vyt6Q2xKM0FiNDVjZ2hqaW9sQmlCSlFuVC9sQjFrOXEvSkE3dFRSMEFwTGhO?=
 =?gb2312?B?MkozTWxDaWN4YStoMHdUckdycElEVUJjcjdKL096QnF6aXB6MEMvRzNFeGZ5?=
 =?gb2312?B?THNaMm93RzI3L1YvUVdodUk2T0V4VUZFaXRMVWxyeVQ0N2J6SXZOUE9qZTVa?=
 =?gb2312?B?Z2gyN0lENDd4UVppdVgrQXFETkhpRW4vRnU1VzF6Z01OOWV2eXVMN1pXN3J3?=
 =?gb2312?B?dDlhS1preldIMWRoU0RuKzhjbjJ1WGo0U3ZRYUNuYVh2ejVmK3hQZVpqTDFh?=
 =?gb2312?B?L3dzVjB2K1BjdjZ3VU1sZUhxWW1DUnRPbzY5QzRNSnd5Z2xFdHJHRjh0NVV6?=
 =?gb2312?B?ek1LYmMyTUhJVGlGYkRtdFRjN0pNWFJES0d5djdIMk40dzZIUlR1TThMbTZR?=
 =?gb2312?B?TXRPQ2orZnk0c0h2QklrT0lkSVk3aFZsVnhzcW0weDFKL2NuRzNidUZxMFp5?=
 =?gb2312?B?VWg3NFJEdU1GeG1hRk0rV28yTld0QS8rZEY2NTAxQ25GVzE1S1BsMnZqRi8v?=
 =?gb2312?B?ZlFzTmh4VWZDRDlTcmk2VzhFSGpEMVFoT0tqTGdYL09ubkhTZHlJWDFRbW02?=
 =?gb2312?B?N251VXY1R2VHeEZJbmQxTkpTbGZEWndSZlV4eDdwaUVYeURwOG5xRzEvR1pr?=
 =?gb2312?B?OWFlbVFlcHozM0tBeENHUnE2Z2JwZmpwd3pPeE85RmF1cnV2NTYyc0VlNGUx?=
 =?gb2312?B?cjZ4VjlnalNPQjh3TmxmTjRuWnpKYUVJV0prb0kzZDNaMFhJVE1KNkJ6eG9T?=
 =?gb2312?B?MnFRT2pGOWtxenJKVXlRcEllODFhZjV4SmhPSzhsYXNXcncwMDFnSHV3VDEv?=
 =?gb2312?B?OXMrZHJFNEo3Y2Fjd1dGS0YwbFE5WFphVkNTWEJybFFCamVvTGIvZEwrVmpx?=
 =?gb2312?B?c2JqSVk2a3M4N1lORjhlS1BDUWZ5aCtCUU0wTkxhV3FOMDlSTXB6RVF0dnpS?=
 =?gb2312?B?SHNpRTAxUk1lbTE0N2FlUndvRkxSZXdJaGNXcUhmTEpzeUpPdld5Y0JDY1U0?=
 =?gb2312?B?U1czMHNYczRiR3g3SlZiSkwwNVA4RlBwRUFlV3dUL0tGUUVleWhJeUxiOEtP?=
 =?gb2312?B?YlpiSWtuSms5TEpoYmFsNDFQM0JHdzV0TEhSOUNQSFRJMGV4Z0lIL2pHM2Jw?=
 =?gb2312?B?WHBOeCtKNFcwRVd1ZWVheWlSaXlYNVg4WURQb0lVZWFjTnhIendSZE5jNDNY?=
 =?gb2312?B?NXc9PQ==?=
Content-ID: <0D5F52D482A0094DA62F6E7CC1E968D0@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac99d11-95c1-46cf-7c45-08da607fed03
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 01:19:37.9731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EgImbMye0240fjtzPgGVA0UjPhhsnC52i+3xOawhcbQHU4aKbZXhyWkL4uS6eKTEPX7SxHpJuAcV5u19TR1j5Rq8Dc16vmTBBo4G+XtCUR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1479
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/creat09: Add umask(0) to setup
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
Cc: Zhao Gongyi via ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Zhao

I don't this fix is meaningful because it only for "fix" this failure

so do you look into why umask(0077) lead this case fail?

I have rejected a similar patch[1] from petr yesterday because it has 
bug exists on kernel fs sgid strip logic.

[1]https://lists.linux.it/pipermail/ltp/2022-July/029495.html

Best Regards
Yang Xu
> The bit S_ISGID of st_mode is also affected by umask, if umask is 0077,
> the test will fail.
>
> Signed-off-by: Zhao Gongyi<zhaogongyi@huawei.com>
> ---
>   testcases/kernel/syscalls/creat/creat09.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
> index bed7bddb0..6edd5dbb9 100644
> --- a/testcases/kernel/syscalls/creat/creat09.c
> +++ b/testcases/kernel/syscalls/creat/creat09.c
> @@ -52,6 +52,8 @@ static void setup(void)
>   	struct stat buf;
>   	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
>
> +	umask(0);
> +
>   	tst_res(TINFO, "User nobody: uid = %d, gid = %d", (int)ltpuser->pw_uid,
>   		(int)ltpuser->pw_gid);
>   	free_gid = tst_get_free_gid(ltpuser->pw_gid);
> --
> 2.17.1
>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
