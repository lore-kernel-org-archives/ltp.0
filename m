Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59755C433EF
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 06:24:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B982E3C8DDE
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 07:24:38 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B4B23C2BBF
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 07:24:28 +0100 (CET)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 635D41401636
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 07:24:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639549467; x=1671085467;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=8u0ncxengnCHWczWSwggC38K+8FAiAugLSYy/4IeTsI=;
 b=mQeyTnsXQ9t2xyuUiMoUpkOSyDjqvEz4d6wDhf1tNy/FjCPotMTI71gS
 +PM4jSsi3px7ucirFwezrq5AiSzWXjWvgDMOYo3FlfPEHihPnMpirAtg1
 Z0/IyY0ltuAWyXyUtRt3gwIAOwVPy+kPyVZ9/l1G9+nZHJP7WEyspi8aE
 f431G2BBTsXoKLYxStkdXhgn2IG2hWbIVQ1hITxTASIs3zTZ5xT3XQULo
 7tUsj+LoviMnpCCzOVQhTf1GPJ1Z15ntFZz79MB7ZbswbiITSnnjVoFoW
 QdF/ISvbYKNI21TW4vuic18G7OZcKHPCdwiVWAn8oVTZ+m1H9WLYFcE3t A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="46806277"
X-IronPort-AV: E=Sophos;i="5.88,207,1635174000"; d="scan'208";a="46806277"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2021 15:24:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaxdpeKsRC1XV2kpgV/qsTKd0OaY3JwgY2Z7relM4Nr8mF60KwwDQSTP/rz2K3OnkdpRY6QROjst/U/KV2s8EbGWbpiYkdI5K2J5cl59oTIeA0YPj1SkJQSlSzxUV35O9Nk/v8VU6p2lqD/iynpkdV3ELAR9CmW+tWLKbJOKl6wo+rzCTR1djWz8w0RxgaWdR4RSvcmqn8xSQ8qrvrL/XIvVoKeLF6snMy5UF5ioA/ymi1O1S+1kGL7xcCKlr6+vZymgGSb41DSK/9wimVbX1vZVJklSUntLeDBc7m6b7hVFDp1S+2h0Mm5cEjP4VhFQDUONlL7HyHakiTML3EXPag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8u0ncxengnCHWczWSwggC38K+8FAiAugLSYy/4IeTsI=;
 b=XQ5q0tUPc1O/wcXygsYoyiyAvhhZZ9kDD1+YPJxT0lJUHP3qLgdTSSllXFJuVWKFr9lcSWbtW28J0J7hz386ymOOF6UUXqKLZ0ofDejxjwKULxmEleqP3DwsGuqEEHi9a6R311TLkIE2scG5JVjJQzCVOD4vZE3HsDegLHsQWP5hycEDpEFSIgahVsCEKQySPICtKlqqTWo49tI1xVuuuwvdrcAYaeYt7rKCNuOXnFVc8BO6RfJXLHgTMeSwuqpGh11I090x0gz91PmjnDWRJKd02XXv1NHDy0RFdK9wQEbNBJ1Dr86U7i4/rA9pGvcImgYOiPLzWuyERBBKagOePQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8u0ncxengnCHWczWSwggC38K+8FAiAugLSYy/4IeTsI=;
 b=LAan1rcmcVl/38y8Je3PTeySN5MvPN/aGKGUvCaHl5VLitfWWo9y5KUdOX2uDS16ydAAsieeaFcXo2sL8iJtOpgyauKqcO2bz+XB518is8oRQLlI0jiUEM3t6iqIR63d2JIx/Kh4pgbJD2bKds3oxrdrgKRdPVN3bu0SHoiNX7w=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB6282.jpnprd01.prod.outlook.com (2603:1096:402:3f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 06:24:21 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 06:24:21 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v3 2/3] zram/zram_lib.sh: Skip test if zram module can
 not be removed
Thread-Index: AQHX7+SDBhMECVKGQkyHvaz+eo/YSKwzGTwA
Date: Wed, 15 Dec 2021 06:24:21 +0000
Message-ID: <61B98A46.9030207@fujitsu.com>
References: <YbNH1J8E3nzH15Cu@yuki>
 <1639374260-22887-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639374260-22887-2-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1639374260-22887-2-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2930830e-3740-4dd1-e4a0-08d9bf9387f1
x-ms-traffictypediagnostic: TYAPR01MB6282:EE_
x-microsoft-antispam-prvs: <TYAPR01MB6282C8ACB2A310DBA0C8F01CFD769@TYAPR01MB6282.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KUnIPz49ic+MP+fsTgdgs4z93GygBxzWwfD4P9y7sURDJvK5gZa67cxKx0SGgEiUCsBNtNKoj3ypBgr7f41z7LevVlOG03D4Y3enxgGY0VNr9WdrRduFTYOpZZZBClYNPF6Y3ichF9N9R/eVKhwWhBNZ3XdlNqRncJq9EYVIfhmN0EiagzUw6gaG8bB+1rnfaNIAm4R/rWnBUQnwPwUZmzC8lbiixC6JW6SDGgQ3M99T+fqO2EwPsp7YwSoh9plEA2fR72F/L41crxSYDN1/je+VGMekA+g1qYLPd0GJavVxpb/9nMzMSGEv5sv3JU4Ci2ujJqPnbRvLAdLpM5ZPD7MJ1mo7fuz0A1EBk3h55LY0YKfXANroQqfQOL2qg1v1j1jYPm63RHs/QvXz/EjdD49lvIpmwAuvjna4V6ne2VjZLV3Ou+w6QdjUA4QiCEg32xWXSxhCLfRTJCQZ8o8DN1SXHHGyxpgCjnR854fy6hgH0T4d5IdgoRR1c42Jqka2BxMbLofDupSXXa1SdJtm+TsNzKDx9t87H8VWomMXCE2VdfcUX0jWnpoq7UAstZS5sgAMw9Xm1g6dnSX+PXJ45p22IygcBwcw8jMoXkbOYVX0BhdOaGsuzHaKbloOQJkmSC+K8NvDthnhczzOdXRl2FoAFulPt+8NO5oN7CynZVkV8vshoP1ea32998wKsRGVQ12Y/+eybkSqF7RDA4dnEA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(87266011)(122000001)(64756008)(6916009)(8676002)(6512007)(38100700002)(66446008)(66946007)(508600001)(36756003)(76116006)(66476007)(71200400001)(38070700005)(8936002)(316002)(66556008)(91956017)(6506007)(186003)(6486002)(33656002)(82960400001)(26005)(83380400001)(85182001)(2616005)(2906002)(5660300002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NmRVRm5iNEREN281dVcwVi9wLzdGeEFTcldUZEczY2ZUQjN5WG81ODZTSjZo?=
 =?gb2312?B?SmZuU0VqQnBuczlhWWNRcGp1b3VzVGl2QmQ0Y01WOTB3ekFPaFBNWjQvb2d0?=
 =?gb2312?B?L29YaWFLdFlFdzFCZmJRRDI5ZVVvVEZQUHhvM0hoRVRmZWVtWkdzbHpyV1BF?=
 =?gb2312?B?UG5mOXpQZnp1NlNqVFYwY2ZYSkNFZkowK3ZDSVVlZWlPbGlUMTE0N05yTEZr?=
 =?gb2312?B?UHI4dXB3ZDVJWVo1dmZsOWx6K1NoRW1lS0NqWCs0L0R0MEk4blRkUWNuVnV3?=
 =?gb2312?B?dDRYSmJLNlJndEphbVdCMytlOGxHQmQxOUZLK1ZzMmlCdVFXRUNHL05LV0Vr?=
 =?gb2312?B?OXUzMy9Cb0Zsd1ZlWkZCRzdPN2VkS0JTdVZLbllkUXFPYTlia0hORVhGekph?=
 =?gb2312?B?K0xQWnp5REJ4UDFxRGZSNkpYLzliUE9IYTFNRGg4TDI1VEtVR1NsaHdvRGZm?=
 =?gb2312?B?YTJmWWR1WHVFUTQwdkh5Y1ZZUEpMdHNTT1UraVlnb2EvUVU0SDIwV3hLRTA4?=
 =?gb2312?B?YTF6YmlZQUtGdHVBM3FBbGlrS2toQm5tSGplQUlCcy82V1Zob3A4b2VOY2Iw?=
 =?gb2312?B?Wm4vT3d0T2sxY1kzTEhJak4rNm14TlFtZGZFTmFuN2NmSDF6WThyZ1NMNGZo?=
 =?gb2312?B?OVpWU2syODNIT0dDNVAzTVFHSjlpQ1k1Wmhhd1NHL0pRU0RkSlVtNE5DNWN2?=
 =?gb2312?B?TVczR1BQd0ZKUy93dHVHc3d5ZXBJT1AyRWRjeXBqMEMzQjZZN3RaYlRrd1FH?=
 =?gb2312?B?UmtmaElYLzJlWE9zTk4vRlZSR3AraUxoRmtBK01aTUFrT0puZDFkcTNPZXlr?=
 =?gb2312?B?UmtSbklSa3VWM0pkUExWWUtneGFBZjhZcDdGSEpMWnIxb3k3TGhITi9XNjJ2?=
 =?gb2312?B?WUEyZWJtV1daL0JFdTBQcVdETytwTHZGcEZoSmx1bjFFclJWbXdyRzM2dHpl?=
 =?gb2312?B?bG5ld3ZNbDF6VzBHUWJOcU1GeFYzMWZjMEptWk10a2hlV1RSd3ZrMjcvNW9P?=
 =?gb2312?B?NkJlWW4zU1I5bjRPNUdMcnhnajlkRVlTbWMxMnI1NnJWV1U3TTFCemlIV2pq?=
 =?gb2312?B?VmQ4bHk2QjcyN3IvOGR5T09NYVgrYXhDT1M3R1JIeTBmN2tmNmdKMkdvaWJB?=
 =?gb2312?B?emNlWFFQc2Izc0NTQkRvOHZMQ2ZRTVdTb2wvRWExNjFEZUVDMW1pbnMvVlkz?=
 =?gb2312?B?TmltS2cvR3VONTFvWlpPTHJPV1JvRWlJY1BpaDk2aDlhQlV2aE9ETlZCQ2lz?=
 =?gb2312?B?MzJOcFhnQjQ2OXlmVEVIZGpXcFNkYWhxMW5kN2R0NnhHbUJTa1lwS2ZkTDhp?=
 =?gb2312?B?SEovWndmdGdISkNIMnlrK2JJR1hDK1VMM1RLVU1pc3lsZURvenY2V0phTjF0?=
 =?gb2312?B?eVFjYklVZ0twWDROVG5LOEJ1UXdVRlF4K2I0czd5Ym1xZlVIdi9DcDdsWmFK?=
 =?gb2312?B?L25MZnU4cnVTSHAwb3ZOc3BzcUJjV0trTWI3SGNtN2lGOFR3U1VNK2pacGtG?=
 =?gb2312?B?Y2lsMEpRclRJYTc2K25wbTR0SEMwalVvVVdvdWFlY04vd296V2dRU256NW1i?=
 =?gb2312?B?L0RycUx5UnJoZmwzcVIzamo2T2NvYVU4d2ljaEVZNWRiRmhMNXdZNTVJTnRy?=
 =?gb2312?B?N2I5cHN2NVQybXdtZENqeHJTbUM0S3NnQitNcEh6NnBmUGEvZ2ZOQU9yTmNq?=
 =?gb2312?B?VWxjUTB4VGlzd0ptK0FONHZqbVdlWWJIMjA3L0ZoZWtXRGpFWGx3QmpGOURR?=
 =?gb2312?B?VSt2TGJaYWVBZ1k2M2dhNUZaMXR6c0RtNkRwZTFRVzgzamo3MTh6ajJqNngr?=
 =?gb2312?B?cmh4eUkveGVYK0U2TExrS3hHVFJiQ0pUZG10cURhK01hd25nTWFkV2RGQ3VP?=
 =?gb2312?B?YU1pT1pDTkloRkZJb3ZhczJKOWZjcXAwNU1ORWw1U2FzL1lxaXZMMmp3UzEw?=
 =?gb2312?B?NUVOL0xmMTJHNUl5cG90TUoydmw3UlBFdnJ4RDRYZG1CalV4RHhkazFPTDhq?=
 =?gb2312?B?Q0lVUnNjLzI5dlQ0azJLUkpXMGR2UDNvRlBFU2xWZnJhNkdMcW55dXIwTEdT?=
 =?gb2312?B?ZlRaQm8rU0k0WnB2dW9uSitVb21xQk8vRVN4ZkdhQThCdU1McFIrcEwwZk52?=
 =?gb2312?B?czlBUW9qMEFCd3NnN3pRV01OWUl1bHRrWFN1aTlEdnlSTFpyYitiSDJJY1dL?=
 =?gb2312?B?d05HeXg0NkZMSzZLMUpKRWFaSE1CcitJOHd4NzIwdlBuaFFpT0krUk9SL1Az?=
 =?gb2312?Q?RuNPxbszMMrweW34y5YbfRSyyOYB3MYueVvUgovs0k=3D?=
Content-ID: <807DA2AC3220914E8B210997D557A222@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2930830e-3740-4dd1-e4a0-08d9bf9387f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 06:24:21.0873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P7p2/pujCgUWsEA492NCk0EqDHll66iS5G98Pgt6TVaNPMvCpKgOskCZ+NNm9ya6rYDwG74sy/L5NRkvq43PvA9tPSEOOsSrUrRPrOaX+5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6282
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] zram/zram_lib.sh: Skip test if zram module
 can not be removed
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All

I will send a v4 patch today by using hot_add/hot_remove interface
instead of skipping case.

Best Regards
Yang Xu
> If zram-generator package is installed and works, then we can not
> remove zram module because zram swap is being used. We can also use zramstart
> command or similar shell script(use zramctl,mkswap,swapon) to do this.
> 
> Since zram01.sh and zram02.sh needs to rmmod and modprobe, they can't work well
> if zram module can't be removed. So skip it.
> 
> Fixes: #888
> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> ---
>   testcases/kernel/device-drivers/zram/zram_lib.sh | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
> index fe9c915c3..26f19ec02 100755
> --- a/testcases/kernel/device-drivers/zram/zram_lib.sh
> +++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
> @@ -5,6 +5,7 @@
> 
>   dev_makeswap=-1
>   dev_mounted=-1
> +dev_zram_load=-1
> 
>   TST_NEEDS_TMPDIR=1
>   TST_NEEDS_ROOT=1
> @@ -17,6 +18,10 @@ zram_cleanup()
>   {
>   	local i
> 
> +	if [ $dev_zram_load -le 0 ]; then
> +		return
> +	fi
> +
>   	for i in $(seq 0 $dev_makeswap); do
>   		swapoff /dev/zram$i
>   	done
> @@ -47,6 +52,10 @@ zram_load()
>   		tst_brk TBROK "dev_num must be>  0"
>   	fi
> 
> +	if grep -q '^zram' /proc/modules; then
> +		 rmmod zram>  /dev/null 2>&1 || tst_brk TCONF "zram module is being used"
> +	fi
> +
>   	tst_set_timeout $((dev_num*450))
> 
>   	tst_res TINFO "create '$dev_num' zram device(s)"
> @@ -54,10 +63,12 @@ zram_load()
>   	modprobe zram num_devices=$dev_num || \
>   		tst_brk TBROK "failed to insert zram module"
> 
> +	dev_zram_load=1
>   	dev_num_created=$(ls /dev/zram* | wc -w)
> 
>   	if [ "$dev_num_created" -ne "$dev_num" ]; then
> -		tst_brk TFAIL "unexpected num of devices: $dev_num_created"
> +		tst_brk TFAIL "expected num of devices $dev_num, but created"\
> +				"$dev_num_created"
>   	fi
> 
>   	tst_res TPASS "all zram devices successfully created"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
