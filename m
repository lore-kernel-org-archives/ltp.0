Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A384AC4332F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 04:01:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A03C3CB14E
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 06:01:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B91A3CAC43
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 06:01:32 +0200 (CEST)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DC7DA1000D07
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 06:01:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1666238493; x=1697774493;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=agpfyxTFISMQ4gyJu1ELiq1VtFecRv239LOmR5O7XFU=;
 b=iLi3k8xMkLsErpW9L2wA5WRzOMU9ZdjJb2NefMNZ4gXCVmVYrd3GcNBl
 zcGGCbVWIDZ1xmK49wwIJmegJwSQGZYf3gnQoTWEf/t0v7vRRVzbvKi2M
 4p9SThVcQ8ROBywTs3lGFcBljqFuAlNmbJyNnC6KlDiFEvbMwBG0HtjJP
 VYLvSKXy9p0zKZ8yJ9KrYZN2wlh0bwlI9RAYRqe/LKebn6IXYx/zlCz0F
 6e8PnvS1lD2a1VI/pfgd0JJBa0yGIF/jMD5ocTSdnLrwIFCOWiPuB5Bi7
 24EOZt+ccyKwSFXz2Vy5XpHuwWMNStMa6cupanayPsy7NSRPLBYX44aAV g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="68144326"
X-IronPort-AV: E=Sophos;i="5.95,196,1661785200"; d="scan'208";a="68144326"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2022 13:01:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2wn6Ezmc6xhONBea9lz2+vGfDB1NA/9d4Bdj8kP2IMYcYbc7pdRLleTW/TaJImhH2U1Vx+KFh36zsnlp/HwVwlbDp9GSg/77DTC+yRYH094lNpavnNdXnJFr8+34ScbNco2S7HBJhM1D3YJVeJtvu6etZItSvrJwBjpHp7LzqSFlXX8uKTQKXmofhhrUfvMMJsl3CgAGUBY9xYvwal6ykTxrhFBYaBeb9hlZa8YJtZp6xr+eE881wyZRBKxDnT4bDIwmJYNPl5YQHkBrQ5OLSGiZfaTzXnf6/JUdOAl5mMNrUjQ+JbwJWsJ+O/eaKBSFJUkbw4VYALLH8ugLYhjLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agpfyxTFISMQ4gyJu1ELiq1VtFecRv239LOmR5O7XFU=;
 b=jzNf+438wSeuncTEB6jxiFwc25hB4rI+a1iRgGb7gE/QeXSnQxc8Xi6mopguaVcZ7fW/jDnB60pFos0sSdTpvbS8aTncvX2mzSRlSlyo65NoT/LG4AIH36Kwfn1WtXiK58VeDkBvjgQHTdRrrgkR25YFVPt0VFdqOnhRZHgpGPhIF0ryIRmIfkhhnG3IkRRgYn0ip+CLkm7C77s48cWw1L8J+uh9oQ3FEewmGQKc1u078hfebOJ/rcQ2FFSJTG1DgPaqafyjF7RZ42EPLPB4G320dw64V7Bt+ajnF8KfQdYiz1tWRayYvgBrvbWc5ds5P8IcluYV0bvWDvwDCpk6Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS0PR01MB6145.jpnprd01.prod.outlook.com (2603:1096:604:b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Thu, 20 Oct
 2022 04:01:26 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 04:01:26 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] kconfig: adding new config path
Thread-Index: AQHY5DXu+GZkU7ehW0y7iKEUzeImfK4WuckA
Date: Thu, 20 Oct 2022 04:01:26 +0000
Message-ID: <7f283a53-2710-d721-dc11-5ca1c5d1aa06@fujitsu.com>
References: <20221020034140.3472638-1-liwang@redhat.com>
In-Reply-To: <20221020034140.3472638-1-liwang@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|OS0PR01MB6145:EE_
x-ms-office365-filtering-correlation-id: 170dd209-6926-404e-92fb-08dab24fc2a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7NRcPX9nStrdUBZoAa7+1rfu25YH0opmo5CeiEc+89k2UwXl1gAEqh5/TP3+0XEDNjP/cYjMQtD5kKmzTCF4mRmmlx1/3Jcu1q+rqVaDNM+0Yl3jDpflciaCkMabOOQymj7nSJoAS9ABUF31cpAesy1c3sZTrEV3ukbj4NaAfVO9/vtGvmRgurPz6NBB1rCp6xH1tTve+dXVZtRsf71zspxpEIdvx/pgyL4ZpIWO3J0U119hi80jXo+mnBAvo0i4SgyEoFr/pAPTNKAHrcd7sGDy4Nq1bYf5Qpe+Pf0ONcjZ/piq1tvSKxP8U9hVj/z9bWMI3o5oV2iqCkqu0nsz9VVxA+ph+CQ6OQ2L8k7GMo/ueqy5ZTP5mjmFNAG+Hx70CRVCEVwfEz74tDP7iIKpwgyJl4J+KEdQcT2HaFr6FSEsk9EiOBi//a0v7TUHQjjRULG+xfxEXEmlGZhPUVerMbsNlPj2T+Jhvt3pz9dDJ+/tvD8wee9kOakOMkhUmNA/p0547oYDWejHUc09dqLVfVTcgM7CarV+Yd3yBCCvbPsI9uXsPLRd5FDpGh5lEN1n/LczUo7qTdA/Zcy74gsZr+A8z83fhcsjSqxfwpFZDz5e91/bCjbNG1jk7lmsukXnTzNs7H/KtWRSmzqTx/4H3bsCKTC43X8PmMURB91gc67vPkg0e55IbHmpA3fiaqXldK+8zFfH50RNwCrS0nP0cJftu4EOz9X1xPVKIEZl1tb/IivodnDkqDcxYPrpdK6FDdTiP+YFyC/EFsPsTbpvnsOidblAM+Wx0M2/PencnGf0c/R+VkXM0XqWjqPaYjdoJIAPokNKuT2DPwkIxTCJVQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199015)(1590799012)(110136005)(8676002)(66946007)(66476007)(4326008)(64756008)(91956017)(76116006)(2616005)(316002)(66556008)(6506007)(186003)(66446008)(5660300002)(6486002)(2906002)(83380400001)(31696002)(86362001)(85182001)(41300700001)(26005)(36756003)(6512007)(8936002)(71200400001)(31686004)(478600001)(38070700005)(122000001)(38100700002)(82960400001)(1580799009)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tk5jWDB6cUpKdEZHNVR5cDVubVU5a1YweDFydC9HSDd4dGZtYnBocTlMalA4?=
 =?utf-8?B?aEs0M2VodUVhdkdKdVZoY0l2WUZBN2JHQlJXRTEvb1VCNDBJMWVXMXlSZDNw?=
 =?utf-8?B?bEc0eCtDV1A0RW9UakFqb3FqQmx2TkV2TFlwMURsZnpOMVd2UVVGMElMenlN?=
 =?utf-8?B?QkIza3VTWGQxNVUzbm13M2lVdm9ySWRWdWg0RlluZnlHZG5pYXFSamtnRlVV?=
 =?utf-8?B?ZmNxV0tRQ1laYTNERWswVDloWlNSSkpWZUxXMGFlVjcrbEhSUGlkYk1qdDFM?=
 =?utf-8?B?V2laWkVXSW5NUG95dUNkVzBWSDQ3eWZUT2phY2xZQVp6S1d6aHVWbHlkQmJr?=
 =?utf-8?B?QUZJK29OcXRXZTUvNDFwam4rK2RmaldjeGpFRE9Yc1lrYkxWbXdKWitCOFFo?=
 =?utf-8?B?QVV0cXVhYmpnOExJYjJlNXM4WnI5c25qWGdMa0hxbzRHNXJFUkoxc29MTmgy?=
 =?utf-8?B?eDRqenNKNjB3TmdGekE0SVBEQ1BRbmhETHVmc09yTDZIVFcrY3ZQdGwwTkJB?=
 =?utf-8?B?S1czcHNzT3lpWXNkbUw3OU9uK1hibEZmRzh4eE9JYnV0NG5JY0gzbEdzbFVE?=
 =?utf-8?B?Qk1nTjhhWFdzKythNC9DazFQVjdLRXlMUzdzbnNua29DcmVydjBqVVdlUHcv?=
 =?utf-8?B?N0JjNUdIQk02UXhEMjQrN2lva2NyK2hlSHhKV3pKSThYMmJKYk9UQ3VlZHBs?=
 =?utf-8?B?VmZHbWJQYkpORHpvN1k1eUM0b3JwY0xOSFozVzlsOElxYVAyLzFYMHZvNEZJ?=
 =?utf-8?B?b1FrUjk4Ly9RRXRFOFRSK0s2MjZZOGJTZExFR2Y5dUcwL1BCejU0T2s3VGNC?=
 =?utf-8?B?VzdnQkVCVlFjbHQydTBtYU1zVVBPQWF5TDAxd0hkN1d1eHNxMmIvQ1BJZmcw?=
 =?utf-8?B?QWpKdk5EMUZOZWpDWmlFTzhJUXpaazRjYmJTV1hDUXo2Y3BRUlgxSDhpY1Fa?=
 =?utf-8?B?cEpqZWUrZ1VGTE1QNHphMXdvS0JPTkxCQWlVWWpNMEZCU29vek5FSkREZUtx?=
 =?utf-8?B?ZDJqR3lEUkRLcnRqOGNKOVg1WEZXbmFmcG5vekprdGgvWm1rZFhURHFqbTVi?=
 =?utf-8?B?eGtEa3p2NFY1T0RmenBBNmdUWnlFYTdwUmNLanJoRnVjWTZET3A5c0ZLUFNJ?=
 =?utf-8?B?QWI3L3dMRzY2c1Nld0pBOUZ2ZUhrdUxqVWdGeTFlbWg5b2UzaDdKZnh3cE1T?=
 =?utf-8?B?S2NQN3dtQlJHUmk1cXlWSjFPczNBSzFETllIWnZjQUFvd0llcEg1NmhKaGV2?=
 =?utf-8?B?WnRNNjNwSVc4VVdzeGFwbjRtTE95YTF2K3plcDZwcnVNWmVwZ3ZTQVJIUVJa?=
 =?utf-8?B?RW1nd1hCanVMQ0JHT0VRcTBXSFd2Sk1Nd2wwb1JoN01YaStnRFZVczU4ejg2?=
 =?utf-8?B?dFlPdjBZQVZmaHhpcDdxWCt5M2Nwc2tnT0RhK0o3TlcxQkdjTFV1aW5NNFlV?=
 =?utf-8?B?Unk5LzFMWkd1ZEc2anBZZmUwU2pOb0dKSW9rc000dzVyeG1DYk1WNjdiOWNU?=
 =?utf-8?B?a0FJcjRRSHBTazV3NzhGVTcwTDcxOU1ZQzFtL0hxYm9OcFBOU2xwZURUMzBM?=
 =?utf-8?B?bk5LVmo3cFVpWW5BMzhXRnRVVWpLWUNQSXh3TjRlbFI4V0UvSWh0MFQzb2Fl?=
 =?utf-8?B?SlBlNVVSZDNCNnlGbStkT0VsU28xWDJqOGMxTUgxOEZ5TGtka0JsMm9LNitN?=
 =?utf-8?B?cHM0TWpQRFBTNmdKNmlpVVlGS28wVHJESU5rREVoVDhBMnFtZTA3Snl3SjJ4?=
 =?utf-8?B?Z2IxMUpBbHBZc1dBTUNyVnRkdHRaTlRDWUZmNTZCRXU2dWNyMEt2bFQ5cWJF?=
 =?utf-8?B?K2lYV05HQzFkWHNCMUNOdmVhREx6TVlxMUw1dkhsMC9pdW5COXQyNGRlNURs?=
 =?utf-8?B?WjVOSGx4MWRhbFBrQlNoY1ZrSjI4d2c2M3NsdG15VUNmU3h2dnA3cnZVNTBa?=
 =?utf-8?B?UGxVbU5nRUNxVmpLRWc3ZXJrd0JQV0VNOWozRnZ1V0tmRGNxUU1sTmx0N1dB?=
 =?utf-8?B?N2c0K2I4SXVFUDVSNXJIQ25SdEFXVmNHTDVlckh1YWlBZFJpTk4vcFRNdWE0?=
 =?utf-8?B?TGNsK2xDeVkxd0NzT2VpaURBUllGYnVSZlBUbjJKdE1wRUd0WjB2M21WblB6?=
 =?utf-8?B?M0xyUGV0YmMwSTIrVmlvbHFmNERwUUFNMHBXeEFLQ2hBNDZ2c1RGSk5TTHd4?=
 =?utf-8?B?blE9PQ==?=
Content-ID: <5E24549BD1CC704AAF02506D5B4DFEF7@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170dd209-6926-404e-92fb-08dab24fc2a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 04:01:26.4022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksbQF26FbpOcqlp2s25UHvUYiVKgTl9bId86syWugDQl5XfrVumIlHIOzkHKSLer+7AXYJSO1eXTIlRIxFdECUPhIKHCTiSH263v/xZCsg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6145
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kconfig: adding new config path
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
Cc: Brian Grech <bgrech@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li

> To make kconfig parsing on RHIVOS(Red Hat In-Vehicle Operating System) correctly.
> 
> Before:
>    # ./sendto03
>    tst_kconfig.c:65: TINFO: Couldn't locate kernel config!
>    tst_kconfig.c:201: TBROK: Cannot parse kernel .config
> 
> After:
>    # ./sendto03
>    tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/5.14.0-174.137.el9iv.aarch64/config'
>    tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
>    sendto03.c:91: TPASS: setsockopt(PACKET_RESERVE) value is capped: EINVAL (22)
>    sendto03.c:197: TPASS: Nothing bad happened, probably
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Brian Grech <bgrech@redhat.com>
> ---
>   lib/tst_kconfig.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> index ac13866e8..a97489564 100644
> --- a/lib/tst_kconfig.c
> +++ b/lib/tst_kconfig.c
> @@ -47,6 +47,12 @@ static const char *kconfig_path(char *path_buf, size_t path_buf_len)
>   	/* Common install module path */
>   	snprintf(path_buf, path_buf_len, "/lib/modules/%s/build/.config", un.release);
>   
> +	if (!access(path_buf, F_OK))
> +		return path_buf;
> +
> +	/* RHIVOS config path */
> +	snprintf(path_buf, path_buf_len, "/lib/modules/%s/config", un.release);
This kconfig path is also common, so
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

ps: I guess  RHIVOS doesn't have kconfig file in /boot directory, so it 
can't be parsed. Is it right?

Best Regards
Yang Xu
> +
>   	if (!access(path_buf, F_OK))
>   		return path_buf;
>   

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
