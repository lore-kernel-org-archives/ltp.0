Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF5EC433F5
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 02:03:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55E773C5AA4
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 03:03:23 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF53F3C1BC0
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 03:03:11 +0100 (CET)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4B50D200C11
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 03:03:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646791390; x=1678327390;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=hs6zC/ErA3Y32HAAc1tcauIlqoBijaBNo4XpZ4sXmz4=;
 b=hTnN0DughNAFJVfPWDrNwg8P6dDtQQdvZkipET0XRIhFktc8GXyXpPLC
 EMT3f6+QueITfZ/r5RVtr+mUpcs/AnlrI5IbOH8fsw759fcy2zOPllyd6
 ined2U13utT64PGgXgC1tOt0jsNazC16X59oKvPnumPwh3vpU0jeOPeXd
 k0OWCS0IwAmWPwlJqTqqxfap272h0vKXG5FsRaNTMJDP58IHWBYDYV9uU
 dlmOjqhUKgtVgBvcJqPrCdJX1f93DwgRHXfKaLgBIz4rnm6Jg97C2sqP+
 Ag9fbWhsQ+X4YwDRKGMcjUPa4Ym2EIQVmOqSsQ86Wr3iKpiBLu5HW0oqw w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="51334949"
X-IronPort-AV: E=Sophos;i="5.90,166,1643641200"; d="scan'208";a="51334949"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2022 11:03:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWe2j++vnPG7PmoaXGOiz5zyzY2jVMgp15uY2W/16hZRp5NAzCtWVdHB5fjcYxl5TJdaxEeHGncnBe0Iwa9RntSaSbftH2JGzgx5ybNy24hI8KRqX1u7dvgfhZ63mBZL1CExZa1il2bjWZ+LUA/P9143JzGl6PtGDbDk5SH4CSZaIMVNVgGa3PDkxI3jBXNp+AzDnW3jiOc65lfB5htEUdmjRq3LfvqnMdfAESHMzTL8GuTmcejldZySJazN1/Aru6iVovVodpalp2P62BV8hRWrzBfqV8rHfrWprpiEbFB0wvI3SbxrOgHFkFg7t7LRpTWwrTAwUW2Gb5K6faEQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hs6zC/ErA3Y32HAAc1tcauIlqoBijaBNo4XpZ4sXmz4=;
 b=hik3tHCr2r+ecmrE/NAlUEYL3fehJ8cz3eh+Rv6+pyrI2bYub1XIcV78CcVkwAR5ZEY9vjpENDw7t5w4bn27OoMZ3BP+WKMc/cIij1nkyJFqh0kFj6jruyFOjVkWqwPLJHuvTQ8XLRyf+26ZkoUL3n9YTHj8LA50gKeg+Ub5bLYX4/Q3ZYuabjR13o74kk4EEBCybSAJZStSHogmi0S1lPIBokEYEiac8PcVQDB03WQdadvi21Ui+Mj2SeLw/5F762OaVt4fgViOF0fIzAqzsv0HJJc7PL3vwXroR2HJZYY482tFwHgRsZ6Ezc/5y9sNVRKkj3HUVi/dCopeuhkLuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hs6zC/ErA3Y32HAAc1tcauIlqoBijaBNo4XpZ4sXmz4=;
 b=VZvTpKrmg3BNpxG9yTxrcLOm0BJP47myV2LMwUrTT8NR+uFs5r6JM+IvMan9W/E7EDyQwnZs34YbEBi0t3lut2d2h17P/l0JK5qJp6m0wI8x/amYqPIX+E/FGvhLrwQkV7pIn8MCTo0Bfr9nl0ypYQjZFsFGFnx0vyw7kAeBLVk=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY1PR01MB1642.jpnprd01.prod.outlook.com (2603:1096:403:8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 02:03:04 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 02:03:04 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Martin Doucha <mdoucha@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls/setsockopt09: Add another linux git
Thread-Index: AQHYLtx4CjNbvmY4GEm3jKnRYeFwH6ytsXoAgADfuQCABsQqgIABAMMA
Date: Wed, 9 Mar 2022 02:03:04 +0000
Message-ID: <62280B08.3010502@fujitsu.com>
References: <1646297678-2141-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YiDK7g1pwLj2aXBD@pevik> <6221869A.9040109@fujitsu.com>
 <3c946010-2f96-e8bb-e7ee-0d48d482d729@suse.cz>
In-Reply-To: <3c946010-2f96-e8bb-e7ee-0d48d482d729@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85c9e46e-57af-4cc6-3838-08da0170f2b0
x-ms-traffictypediagnostic: TY1PR01MB1642:EE_
x-microsoft-antispam-prvs: <TY1PR01MB164208806C6B31B789735337FD0A9@TY1PR01MB1642.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O273gzGrreFh7biDFOVXh3IZl61dNABgCbA5ctWagIUTPn014DQHE7agyG3aKJYVlldrfxerFnk/XTxGc+kUwPQhllRwdPKuOpAy3WuRUxcoBBRGuyoOo90F5ZhbntGJ1Upi/f5ngGWsQ6yIf/0j37pt/REoSawAy6Nkx+B1OSHY25ue0lBQUCcOBE8kmp/EphjAZRzxIFmy1fFaCrRuuMSotG4m4dydSX5apgfVUIfnSaPCyA81BeOJJRioqZmxGbI3yhkwvkUS+6BBS38xdNvFLsoUKE7kDS+kruWovThJ+Mnsz5Z45WRxD3BzQkYCZuafHYuIeF2Lh89vbswaezF+dMTAk6rhONjkSlsxxDpozVeL72qnEYfwpNlnfME7dobkRCmOyql+sStdfVlm+A03REz1ET1Ye+aCzSsFwAnKiNIFLT4Eo2ohAqSDq0/cbYKqqH7kg2EdmIZhfbMupNw0qnUl2HoLU4dKr8ogotleKXT9cYnEeT/+VTxt45hKDaWnzk/i4UFQwSsFgNSkUDYNDwwgeu9s7AaC2Vnxg9VoZ7VvuhECIbEKaEE0Ew57xXn1Q0PMweukGULyYgNM/3yV3Tr6NElERAr+YApCbmi4LtLDlP3mhYTU3kr1gZ5J6FD4aFOg9dWbJBi/yDGbuVAicypdtH9mGN7S5QPBiDIEy0kQTCOsPWG8rpYA3iKLWkF6wQdEjLSryNnSlKibmA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(83380400001)(71200400001)(91956017)(36756003)(316002)(85182001)(6506007)(82960400001)(8936002)(6486002)(4326008)(76116006)(8676002)(66946007)(66446008)(64756008)(66556008)(6916009)(54906003)(5660300002)(86362001)(38100700002)(66476007)(2906002)(6512007)(508600001)(26005)(186003)(33656002)(87266011)(4744005)(2616005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dm5ndXc5THdOdjBqcCtnTitYNEtnVEVFOWlxNEJjb1NiVzZVUTRQeVdHRW9U?=
 =?utf-8?B?U2hWS1NwNnNrTlhFRUNUVnNIdy9mUk9VMTFNWmJUcUlwSGtIQXdpQkdlaHJC?=
 =?utf-8?B?NnZsN1FERERoenVtbFdpTVlUNEl6ckpKVlVKMVUrZHJQd3ZiWnp1dVlMZUZH?=
 =?utf-8?B?QnJKblR1R2lqYVBEL3U0VEtqS3BucW5hYmdkVUtDM25GNVpNNStxa3drTENl?=
 =?utf-8?B?amtaSzVpMStFVEt0QnhReEhWM29PY0ZBMk8yQll0UHptWGRJQWNkanRmYXJD?=
 =?utf-8?B?dExzaEZNeTMzVTdSVzZQdzJsREcxY0JUbVo5dlFwamxPU3ZlL1RLcmpMcmtN?=
 =?utf-8?B?dUZXZTA3cFhWZnN0NFF4VFRzYk10L0czVnh2cytnWDMyMGdnTEZWWERRc1JG?=
 =?utf-8?B?OEdiQ2NXVGNmUUJ2UERWUDNGRndEWTZVTzVaR2loSzc4Z1BwMjJNTkl2anlp?=
 =?utf-8?B?djNCZ1ZpUzVwMFZWdDl4cWhXaUpLV3Znd1A3Q1JyTmgyV2ZrNVZ0d2R0Qmpy?=
 =?utf-8?B?L3BiNjJCcUxtaUNobVMwK2F1eUlBdEpKN2pPUkR2M2h6aXIxblBKd1VINU5h?=
 =?utf-8?B?TXdSNEYzaHlja25ZRVZ4R2g3VnpnRU5RaHk1akhuNWtacEdwdGZWRjZDVHdr?=
 =?utf-8?B?Zk1mUUhDRWZIQ1NOenNieEFkTThveE5qY3BJajlTTXFTUEw3b1FLVkJVdGt0?=
 =?utf-8?B?K2hEdk1RTEtQc0Ivbm9QZ3dxYW1DeXZGUTlobHVpRHpwMUpjSW1tSDFURE1Y?=
 =?utf-8?B?bEtlL0VQTGJCMXBZOTNvc2EvOHBYQ2FhUmFtSG8xcjBkQ0orSkFsTTh2NXc2?=
 =?utf-8?B?WUdwRTAreld3RkdGQzdITzJIcFEzdllPeklLSWlFVTRha2FrUHdhZXBoUi9v?=
 =?utf-8?B?MXJ2QlFwenBvR04yZzhnTG55L3RqMlZRVjh6em9sV2NBRUhDMU5NZ3ZZOWxw?=
 =?utf-8?B?TlRPM3oyc1kzUGZjTHZIYXBDbkpWeTNQc1JJbGMzRlh0QzNNVWtSVkcxSnFT?=
 =?utf-8?B?ZnJaOWVCSjhYaEQreEVrdk1Ka3hJNWhwVWhGWnFYTHkwb3FPT1BxRHR5Vlky?=
 =?utf-8?B?bTlsaXhMMjlWd3FXRS9mRm5YSE5CSFo5SFgyUmFhY3JxWmprZDhUOEpuTHRk?=
 =?utf-8?B?TTIvZnlrYzRTUlBDUVkyek9kb3h4SFVYQitLUTVRTGtwbE0rMlFWRVNCeHZz?=
 =?utf-8?B?VzdOZzBDNzc3N3gzbkFoaFMxZkt0VnZvNm1MbDFxY0VWeHdsL2w1WEVMcDli?=
 =?utf-8?B?TXJjQmxiWlVMQlo1dXF5YmVqMGp2dFY1YnZqL3ZCNGFjd2RHSjFYRWpoL3ZO?=
 =?utf-8?B?ZHdPWThYWWF6a2ZDZGoyZ205dGxhbGg5anRIbHp0eWJKU2xWelNQVk9pam5r?=
 =?utf-8?B?U0sxZ0lGclNFVzRYcnYxNlR1clZxTVlBY3NGcnlJcEVaMkhWQ2x6U0JNS1Y5?=
 =?utf-8?B?aTE4d2pzMnhmMXIzSXI5VXdXeHFlZTN0UmQxaWExN01MbGpZS1JLTUdKN3N5?=
 =?utf-8?B?bkpsTHgyWXRWaUNKd3ZLclltOCtwc3hHd2htV0w2Rlg3SmgzSmgvUFFJN2NJ?=
 =?utf-8?B?b0NVQ0hUNXZTKzVOUFI2cUlNZ0M3cVlQcU43bGJuYUZTSkpUb3JTUnA1c1Rn?=
 =?utf-8?B?eERBZ2FCYWlyQ0hsbkppcThOZnRBMEZpQ05ZMkhIbTczQis2RjZVaEFhZmlJ?=
 =?utf-8?B?ZVh1SXN4NWMxS2VuWHcvSlRXQ1FIVUdjVUR4cU4zRWRUcFBBK0t0b0pKeEx6?=
 =?utf-8?B?UUlNenY0OTUvREJETHFSRThoQ0s2VEpiRS8xNlVXZFdJZGt6UExGZXl5WEln?=
 =?utf-8?B?RFRtOGE4d25JMDAxVEgzNm4yMlRyRGg1bmE4YTNkUjNQd0xFUHMvWHdCdmdj?=
 =?utf-8?B?d1pVZTdMcExhb0tORGlVZXRTc05NSHBCODkyTVJST3F2Q3I3SWE0ak5rd3Vn?=
 =?utf-8?B?empPWXdQVkdnM1ZiNU1BcnJxY0ZDRGViNGFtSkF5UnlaNSs0VDJOeVZQekY4?=
 =?utf-8?B?Q251QnhsK1BhQzNkZkc2MndlUjdtdnUxcVNuajIxRXUvVjVPaVpZYXZ1WG9v?=
 =?utf-8?B?cGU4NkQ1czFmNmM0SW9LYUlCOUoxSkpCMGN2M0F0ZUJDa0J3SGVXRXhrUzc0?=
 =?utf-8?B?Ny9uRXgyeWxhTk9adUR5eXZHSUFoZksrM0RQaXpuUFBSSmRTUTVnVlZEV3lK?=
 =?utf-8?B?RUFucjgwa2RQZDZvT1c2bGRaNE00WjdiWG0ycU5WWmx3QXJ3SHE1akhpRGdx?=
 =?utf-8?Q?XwMeZ4YboP6LHinit6nHBPKSntPjsWg/wYLNMRIBZM=3D?=
Content-ID: <26232B7DD6ED394A8AB0ACB4262B904D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c9e46e-57af-4cc6-3838-08da0170f2b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 02:03:04.5009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QW3PJQaECCUNamIn71kdraRf1zBRf/Z+KwaBnjEo1hPvVqbkjeI4BOv4EP9AmwiGVhIIKW72VbchUpnKGTOfM80Hg9dBSsGhbkWnDMgE7VM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1642
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/setsockopt09: Add another linux git
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
> On 04. 03. 22 4:24, xuyang2018.jy@fujitsu.com wrote:
>> Hi Petr
>>> Hi Xu,
>>>
>>>> On centos7.9ga, I still hit another crash problem because of use-after-free in
>>>> prb_retire_rx_blk_timer_expired(). Since we free it when timer expired, so this
>>>> case will crash after we print TPASS info.
>>>
>>> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>>>
>>> LGTM.
>>> I tested two old kernels, the one with patch survives, the other got reboot.
>>>
>>> BTW funny enough the affected system manages to print "TPASS: Nothing bad
>>> happened, probably" before reboot :).
>> Yes, it crash when timer expired, so it will print TPASS before reboot.
>> Also, I try sleep 10ms, but it still print TPASS and reboot after serval
>> seconds.
>
> The timeout is controlled by req.tp_retire_blk_tov and the value is in
> milliseconds. So usleep(req.tp_retire_blk_tov * 3000) should be enough.
I tested this on my vm, it still can't ensure hit the old crash before 
print PASS log.

Best Regards
Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
