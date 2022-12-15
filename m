Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED396C4332F
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 05:46:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6742E3CBCA7
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 06:46:53 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79F713CBC7D
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 06:46:41 +0100 (CET)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E23DE1400C5E
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 06:46:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1671083199; x=1702619199;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=+nwXQRe/5PdFE0BKQQQX328zz88RSF6DupKEq81HaEA=;
 b=V5I7aKqSnBMoErY/fXYw8/NgHpO3aFlV+6+b+GH2H60zzEllziFokjWj
 dm6fFMqAjlJipnJQDy6EhHZ4xhn9UwJmiRdUS1QKQyZS+uVlEQrKhUN3Y
 cP/EwBTsDKaSPlPn5blXbbHnMsbjcZaog93Bil2YqvelaMt4rsmkxOj56
 niysS023+gDgQm6jw+p0vcbDRxTwkaoYpj3euSDfOLc80j++SotKnET6W
 X4CN/XQJ9E0IIMY1mxOOgZOc7sjM4UIE8+vyojPnaj/9n82JLQpzpe155
 yfc6yLedsX0U+H4n3TDDuG3xt/wAsA2pyARZEEF0e4CXtgfFQSXWF9WBZ g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="80586353"
X-IronPort-AV: E=Sophos;i="5.96,246,1665414000"; d="scan'208";a="80586353"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2022 14:46:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqnkJaVgEbeNdGaF5hieIb0dfL0EnY865zjzN5z6AWJcF+5uei+bZoFg9V+B5rcFQm8JXhIcQZadxNXQ71H89G1cfW7cyXBtgUI9/OV/KNdChSbukz2fjcattdIxP9v/TRzOtJjtZ66vCOXOhMQ+AWsjGUZYTPRTQDNuDLHfKsyUfJ4eSxJy+/PDd/lqs4ttTfhSV5zBJMswyz2URY4c7fpJHpgEnah2NOWF37l9IP3I6PjFe5Hm5hQ4Egw4RMxi0S3GfnDNDOE4DZlWe9cvMmB3m6kwXTmAajcsoX5sBUFoW9b70G+V0oLiAjCZ0OZy4kP70fxSOygM+/xO3GjUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nwXQRe/5PdFE0BKQQQX328zz88RSF6DupKEq81HaEA=;
 b=KjbdsiRprfg97rXoBa4jq/C85cEZoOjwenefJWNaM7dFbYo3nQqKhGUyeMgb5sNXiWpoRAWN+LESc3R815HT+fv+InjUVQIahToQPhElWiy7RbwUtpAMb4y44wjjTIGpk1Py0OvR1WF2KyI7QKKJ3pxEqFClZFKzYxrce2p/VoNmSXvdso2HAI3KN+I8DisjIAXrXmIgCDnYefrug587t2quPkc69vls1D6RKITPBRWe0BShe1NYKpIkBjS12mg2jskOLaV+qrdMcopn2sLs/+H/FR/OxoSoSFByqYmZ2V9GC93xYhb0WDStBdtATd5j2xl4MVyiTBt9dSnTyZG9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OS0PR01MB6050.jpnprd01.prod.outlook.com (2603:1096:604:cd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 05:46:34 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%7]) with mapi id 15.20.5924.011; Thu, 15 Dec 2022
 05:46:34 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v2 2/6] shell: Remove old kernel version check
Thread-Index: AQHZD6kfRH0QBaKDmUO9Ol2KKXs/wK5ugviA
Date: Thu, 15 Dec 2022 05:46:33 +0000
Message-ID: <2faccaca-7b09-629f-a818-4d78211eae5c@fujitsu.com>
References: <1671018303-2079-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1671018303-2079-2-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1671018303-2079-2-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OS0PR01MB6050:EE_
x-ms-office365-filtering-correlation-id: dec41d99-f98e-4cb0-0130-08dade5fb958
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aKWzdqn8r6Qq/4cH53YJCOraXNKIucNPoNEwvftQpNd+mUNJhxYwW46Ijtmuw4VJc7v85KdF8sjvq0jqQH4TFeGKRiz505FDrw+xibV3ZTGf3zlaoZdxbqzH8wFbEk6fmgXCHeAP7nkGtfA28ldnzHz/X1YpxqgLGcYMmc7iwbntKxgb6FT68ocMVZmaTQW/vX33X1M1MmIxEDt3RXImUKFYBjAp7vpPYgYBbZLxIw9Ws9QWI8VjX96iZZJ5u7IMapYUPvHqFtYNb23JK5Sh1qG7fz1q8YBtQbOHbkfxPYQqWVUzAdMxwx39n7KoMuZG4WzitKHU1DE69V6STSFwA9Mx8MHftd4VwzRSRgK3JUaIME5vU6b0yvoLUyfxRuKMYPiDUdCJz+ciTk3VAN+WMUEaLfPsYG0brLUwtIRQiSGeNDoB5UahG01z9bFKrNaamSUe8ZC+26LrUkcCLMIoCcTO556GUeLv4kikJc4E7Yxvv2upLmqfjnBNTnDKyuD3SW6DpTDkHORz16DBnEKI8j5wavXF0fJZ0mZmEtaXtTySOUA0fnN3o5P7HYRBx8/dTnbZ4jTcdKEXFNHgUInhllxDSsZDGkdTN3Kc+MZf7qyGEn3fN+sZhQKiMnfElUtf+K3XJBlbA2lEE/Q5yTHYSWyY4qdxM9t0BXE0GfjbEbuYukcovlrW/4PcOdGnfPgbiZ7E+vGdMINXI2r1dmTkWS6NluGp4xeitFry/Iy+3zEjZvvFD+hz6wRrkWZv/VpHGEv2/darH1zVx4W0xp85DfHJSWqGx9iAHERvGA7hEvU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(1590799012)(451199015)(186003)(71200400001)(6506007)(86362001)(38070700005)(6512007)(31686004)(31696002)(26005)(1580799009)(478600001)(6486002)(316002)(66446008)(6916009)(66556008)(2616005)(66946007)(66476007)(91956017)(8676002)(64756008)(76116006)(85182001)(8936002)(5660300002)(36756003)(41300700001)(83380400001)(2906002)(30864003)(122000001)(38100700002)(82960400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUxkZ1FlZGcwcE81Y0EyeGVWUnE5ZmRLTjRiYzBsci8wMi96aHZLUHllMzZ3?=
 =?utf-8?B?bTFBZ1ZxcWZxeFBCNjVhdFp5Ty9QcHRIbDR2bWJHa2s1MVFNSjlPSlJiTGdr?=
 =?utf-8?B?OGpwWU05TWlraGUyV0JRditHZTRldXZMRHlXMWJpcFhubk82SzRvYUpuWGhX?=
 =?utf-8?B?Z2ZmczhoMjNySmNoTkFHMVRUNVFlZHNxYnRsTmp3NzYrdThKZTN1SE15cnp5?=
 =?utf-8?B?Zy9xaGlIbnN1cDZzSjErYXNaNkpKZml4blVTRWhFTzJmQy81bkFVc09DR2tk?=
 =?utf-8?B?bHQ2QXREaHZPY3RaWDZPVmE0L21hVEMxQVNzVXcvNFYxeWE0MzMxZ1k4R3ZE?=
 =?utf-8?B?SmVtdVFBdkZSS05HVm9BQ2xqMTdCaDBqQXIvUlRyUkRqdnZmeHZKZ1JNR21G?=
 =?utf-8?B?RlV3a2hmalAxV0dlR0pZVDMySTdXQW1sSlc3cWNUZk5UbXhCKzVRWDltODlY?=
 =?utf-8?B?Tkt4ZWNBQnVtc0lseU5Gc0NqUmE4RW9GRElYYU5KbWRaYXR2R3hQaGlwMCtW?=
 =?utf-8?B?amM1VjRCdHhnV3hxSEhCSmpxa3cwUFZOdTNhWDdEL1dIaHBJWHNKLzR6RmR2?=
 =?utf-8?B?Q3VFMEtWVTM1cXh5UXdkUzc1R2xPQUIxeUNhcEJ3MEd3S0dTZ0ZWRHZ3RUZi?=
 =?utf-8?B?M2lQN3A5UFJ1NElNdHErRjJJUzZmSVJZUTRiaEdUNG1GZW43OTFNbWxxWTdP?=
 =?utf-8?B?dE10VkJjWjN2WmNwaGJNa09CbmpLTTRmOVY5MXVMSHNMTXFFc0RiQWN0QXBx?=
 =?utf-8?B?OTMxbjVDZFB0WE9QTTVaTUM2Rm5hY3QrVTh1L2ZFUlk1MVk1a0ErN1dTclFv?=
 =?utf-8?B?ZEZ3bi9JeVRuUklYTnNvM1hzUmJOZEhGVHE2K3VESG1BRll5Skk4enRRNURR?=
 =?utf-8?B?aHpYcU5WeVM0dnFUV0JMMjA1QVNBc0tsNEpYOWVtamhOY0IzbXI4VjlNYlMz?=
 =?utf-8?B?QlArRVVNdk12Q2Z0M0Y2azhiMUdMaEhJdG5KbjhDT1QycktDcTJYZFBUejBr?=
 =?utf-8?B?WVVNbzlBSjJHSE1WMXNiL1RLUEpUcXoxbXdTRSttelcyaGhoUTF3MmU2ZlFt?=
 =?utf-8?B?VTlMNGxJN21OUGxSZkR0N1o4YitrKzNzT0NjeCtSOHdNOFNrV3ovUS9nK3Vt?=
 =?utf-8?B?amt6eWloRThEV2JuV215RWNFeG50NDN3L1B0b3Zjd0NwOXY0QUJCQytYZzlO?=
 =?utf-8?B?NWZzZlBuNTB0OEd1QjBMYi9TMnNXc0d1TUdCNEVNNUlGTVJ6QkQvc0lSbmV3?=
 =?utf-8?B?NitYWTkxZk9UaXFxRklFM01wMmlvWGtYYU9WbnlvZkZVdFhYcGh1aVZ1TEJG?=
 =?utf-8?B?YWpDL08zcFNEaThuZnc4VEw3V3ljYmtGZ2NnaG5LYVp6RGU2UjUxUU5CQjZ2?=
 =?utf-8?B?SU95NE0rSDU0OWxkTWhLVzdTVGhibnJIU28yTGttNTFRMXlBN2FIQjFUQS9s?=
 =?utf-8?B?aFl0N1h5NWpwMXZjelBtQVhJaE1HV2tmV0w4WndCQU11bTV6OWFVTFBVR0g0?=
 =?utf-8?B?dDd6eGdjUWF4R09EZXQ2M0M3M0ZQUHF1RzJ2ektLbDNmcUZxR2p2d01yMnRE?=
 =?utf-8?B?RGJ2MHo5elJNLzJDRzdqWEdwcjBucmIxaG91ZU91d0M2elNZNXpNSHlNKy9w?=
 =?utf-8?B?ZE9oMlBkVWxVQ1NFWWlnSHR6RGN2bmlSaGZaVTBVK1ROMnE4ZmlleTF3Um5h?=
 =?utf-8?B?SlAwdGdTRGxIcUZjSTJvdkMvNUVSdEtWSWVENEtsUi93UDVMWmFncUdYUkQz?=
 =?utf-8?B?dS9DYm9Vamh5b2RURXNrR3NGaVZXUmFkQmlibjRBa2lNVHBmOXhYSm5sT2cz?=
 =?utf-8?B?cmVLOFFjblRiLzFUc0h1L1ovZE9oaVI4STEzMTY3MUFLbHhQQlhwOTY2Zitq?=
 =?utf-8?B?enpCOTkxMHFNdktQWjFETlJaUTR4czFTcVV4N1d3cnRBcC9uRTZSQlhnTVZr?=
 =?utf-8?B?a2ZHTSs3anBCTU1Yazg0UlRscGRPWXNENk16M3pLWFBvaFl1S0FlYWxiOW9S?=
 =?utf-8?B?ZU1scVlHMmtTc3FFRExIcEhmZ3V0ZTZxMDg5SDNtelltczF6SE11MHBzWlNM?=
 =?utf-8?B?eDJVLzNQZ3A3ZkNxbnR2RHAxQUQrNXJzMUZZNE9ycDBlOEc1ck9tTlg4ZFFD?=
 =?utf-8?B?Y3VEVDJtZUVOaU5YaEVtRWV5NENtM1VmdUdMNjhHTWx4K2xKa01zZmxqblk5?=
 =?utf-8?B?RXc9PQ==?=
Content-ID: <699457A38D479F44B72671102F9FB582@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec41d99-f98e-4cb0-0130-08dade5fb958
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 05:46:33.9002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MWsaSetNyMXrLZEhcGeM288rTlgYivHoFvJKim3gsD/LOdby9D2VQGsvlcIpXHWmGaBUZsvC/Dqn7z15EWdv1F+dLjmqe5iN/2N4tMPG67k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6050
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/6] shell: Remove old kernel version check
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

Hi ALL


> The oldest supported test distribution kernel version is 3.0[1], we don't need these checks.
> If users want to run these cases on old kernel, they can use old release tag.
> 
> [1]https://github.com/linux-test-project/ltp/wiki/Supported-kernel,-libc,-toolchain-versions
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   testcases/commands/mkswap/mkswap01.sh         |  7 +----
>   .../kernel/containers/netns/netns_sysfs.sh    |  4 ---
>   .../cgroup/cgroup_regression_test.sh          |  9 ------
>   .../kernel/controllers/cpuset/cpuset_funcs.sh |  9 ------
>   .../memcg/functional/memcg_limit_in_bytes.sh  |  4 ---
>   .../memcg_memsw_limit_in_bytes_test.sh        |  6 +---
>   .../memcg/regression/memcg_regression_test.sh |  4 ---
>   .../kernel/power_management/pm_include.sh     | 24 ++++++----------
>   .../kernel/power_management/runpwtests01.sh   |  2 +-
>   .../kernel/power_management/runpwtests02.sh   |  2 +-
>   .../kernel/power_management/runpwtests03.sh   |  2 +-
>   .../kernel/power_management/runpwtests04.sh   |  2 +-
>   .../kernel/power_management/runpwtests05.sh   | 11 ++------
>   .../kernel/power_management/runpwtests06.sh   |  8 ++----
>   .../runpwtests_exclusive01.sh                 | 11 ++------
>   .../runpwtests_exclusive02.sh                 |  8 ++----
>   .../runpwtests_exclusive03.sh                 | 11 ++------
>   .../runpwtests_exclusive04.sh                 |  2 +-
>   .../runpwtests_exclusive05.sh                 | 11 ++------
>   .../security/cap_bound/run_capbounds.sh       |  6 ----
>   .../tracing/dynamic_debug/dynamic_debug01.sh  |  4 ---
>   .../ftrace_stress/ftrace_trace_clock.sh       | 28 ++++---------------
>   .../ftrace_stress/ftrace_trace_stat.sh        |  6 ----
>   .../multicast/grp-operation/mcast-lib.sh      |  1 -
>   24 files changed, 37 insertions(+), 145 deletions(-)
> 
> diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mkswap/mkswap01.sh
> index fe1695876..e03c46c31 100755
> --- a/testcases/commands/mkswap/mkswap01.sh
> +++ b/testcases/commands/mkswap/mkswap01.sh
> @@ -51,12 +51,7 @@ mkswap_verify()
>   		local pagesize=$PAGE_SIZE
>   	fi
>   
> -	if tst_kvcmp -lt "2.6.35" && [ -n "$dev_file" ]; then
> -		tst_res TINFO "Waiting for $dev_file to appear"
> -		tst_sleep 100ms
> -	else
> -		TST_RETRY_FUNC "check_for_file $dev_file" 0
> -	fi
> +	TST_RETRY_FUNC "check_for_file $dev_file" 0
>   
>   	swapon $swapfile 2>/dev/null
>   
> diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
> index 9fc390eaf..179242721 100755
> --- a/testcases/kernel/containers/netns/netns_sysfs.sh
> +++ b/testcases/kernel/containers/netns/netns_sysfs.sh
> @@ -18,10 +18,6 @@ do_setup()
>   	DUMMYDEV_HOST="dummy_test0"
>   	DUMMYDEV="dummy_test1"
>   
> -	if tst_kvcmp -lt "2.6.35"; then
> -		tst_brk TCONF "sysfs is not mount namespace aware for kernels older than 2.6.35"
> -	fi
> -
>   	setns_check
>   	if [ $? -eq 32 ]; then
>   		tst_brk TCONF "setns not supported"
> diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> index bfa9097ec..d26456b2d 100755
> --- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> @@ -16,10 +16,6 @@ do_setup()
>   {
>   	mkdir cgroup/
>   
> -	if tst_kvcmp -lt "2.6.29"; then
> -		tst_brk TCONF ignored "test must be run with kernel 2.6.29 or newer"
> -	fi
> -
>   	if [ ! -f /proc/cgroups ]; then
>   		tst_brk TCONF ignored "Kernel does not support for control groups; skipping testcases";
>   	fi
> @@ -255,11 +251,6 @@ test5()
>   #---------------------------------------------------------------------------
>   test6()
>   {
> -	if tst_kvcmp -ge "3.0"; then
> -		tst_res TCONF "CONFIG_CGROUP_NS is NOT supported in Kernels >= 3.0"
> -		return
> -	fi
> -

Here should return directly instead of removing. IOW, the test6 is 
useless. But now it is safe because "grep -q -w "ns" /proc/cgroups" also 
return directly. So I mean to remove this test6 at a separate patch in 
the future or v3.

Best Regards
Yang Xu
>   	if ! grep -q -w "ns" /proc/cgroups; then
>   		tst_res TCONF "CONFIG_CGROUP_NS is NOT enabled"
>   		return
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> index 9939f13a3..87ba7da1f 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> @@ -79,13 +79,6 @@ cpuset_log_error()
>   	done < "$1"
>   }
>   
> -version_check()
> -{
> -	if tst_kvcmp -lt "2.6.28"; then
> -		tst_brkm TCONF "kernel is below 2.6.28"
> -	fi
> -}
> -
>   ncpus_check()
>   {
>   	if [ $NR_CPUS -lt $1 ]; then
> @@ -150,8 +143,6 @@ check()
>   
>   	cpuset_check
>   
> -	version_check
> -
>   	ncpus_check ${1:-2}
>   
>   	nnodes_check ${2:-2}
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh b/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
> index 77d293329..8ad399a97 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
> @@ -88,11 +88,7 @@ test11()
>   test12()
>   {
>   	tst_res TINFO "Test invalid memory.limit_in_bytes"
> -	if tst_kvcmp -lt "2.6.31"; then
> -		EXPECT_FAIL echo -1 \> memory.limit_in_bytes
> -	else
>   		EXPECT_PASS echo -1 \> memory.limit_in_bytes
> -	fi
>   }
>   
>   test13()
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
> index 96f5360a8..74748a528 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
> @@ -56,11 +56,7 @@ test9()
>   
>   	ROD echo 10M \> memory.limit_in_bytes
>   
> -	if tst_kvcmp -lt "2.6.31"; then
> -		EXPECT_FAIL echo -1 \> memory.memsw.limit_in_bytes
> -	else
> -		EXPECT_PASS echo -1 \> memory.memsw.limit_in_bytes
> -	fi
> +	EXPECT_PASS echo -1 \> memory.memsw.limit_in_bytes
>   }
>   
>   test10()
> diff --git a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> index 94d4e4c00..58759263e 100755
> --- a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> +++ b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> @@ -60,10 +60,6 @@ check_kernel_bug()
>   
>   setup()
>   {
> -	if tst_kvcmp -lt "2.6.30"; then
> -		tst_brk TBROK "Test should be run with kernel 2.6.30 or newer"
> -	fi
> -
>   	cgroup_require "memory"
>   	cgroup_version=$(cgroup_get_version "memory")
>   	mount_point=$(cgroup_get_mountpoint "memory")
> diff --git a/testcases/kernel/power_management/pm_include.sh b/testcases/kernel/power_management/pm_include.sh
> index f3e160445..ad72028c9 100755
> --- a/testcases/kernel/power_management/pm_include.sh
> +++ b/testcases/kernel/power_management/pm_include.sh
> @@ -15,21 +15,15 @@ cleanup() {
>   	fi
>   }
>   
> -check_kervel_arch() {
> -	# Checking required kernel version and architecture
> -	if tst_kvcmp -lt "2.6.21"; then
> -		tst_brkm TCONF "Kernel version not supported; not " \
> -			"running testcases"
> -	else
> -		case "$(uname -m)" in
> -		i[4-6]86|x86_64)
> -			;;
> -		*)
> -			tst_brkm TCONF "Arch not supported; not running " \
> -				"testcases"
> -			;;
> -		esac
> -	fi
> +check_arch() {
> +	case "$(uname -m)" in
> +	i[4-6]86|x86_64)
> +		;;
> +	*)
> +		tst_brkm TCONF "Arch not supported; not running " \
> +			"testcases"
> +		;;
> +	esac
>   }
>   
>   check_config_options() {
> diff --git a/testcases/kernel/power_management/runpwtests01.sh b/testcases/kernel/power_management/runpwtests01.sh
> index d470d112e..2caf9eab5 100755
> --- a/testcases/kernel/power_management/runpwtests01.sh
> +++ b/testcases/kernel/power_management/runpwtests01.sh
> @@ -47,7 +47,7 @@ test_sched_mc() {
>   }
>   
>   # Checking test environment
> -check_kervel_arch
> +check_arch
>   
>   # Checking sched_mc sysfs interface
>   multi_socket=$(is_multi_socket)
> diff --git a/testcases/kernel/power_management/runpwtests02.sh b/testcases/kernel/power_management/runpwtests02.sh
> index 8c7936fc4..805befb03 100755
> --- a/testcases/kernel/power_management/runpwtests02.sh
> +++ b/testcases/kernel/power_management/runpwtests02.sh
> @@ -46,7 +46,7 @@ test_sched_smt() {
>   }
>   
>   # Checking test environment
> -check_kervel_arch
> +check_arch
>   
>   # Check sched_smt_power_savings interface on HT machines
>   hyper_threaded=$(is_hyper_threaded)
> diff --git a/testcases/kernel/power_management/runpwtests03.sh b/testcases/kernel/power_management/runpwtests03.sh
> index 3fb85d273..72ad2ad68 100755
> --- a/testcases/kernel/power_management/runpwtests03.sh
> +++ b/testcases/kernel/power_management/runpwtests03.sh
> @@ -145,7 +145,7 @@ pwkm_load_unload() {
>   }
>   
>   # Checking test environment
> -check_kervel_arch
> +check_arch
>   
>   # Checking cpufreq sysfs interface files
>   if [ ! -d /sys/devices/system/cpu/cpu0/cpufreq ] ; then
> diff --git a/testcases/kernel/power_management/runpwtests04.sh b/testcases/kernel/power_management/runpwtests04.sh
> index 4b727a5bc..6565320d2 100755
> --- a/testcases/kernel/power_management/runpwtests04.sh
> +++ b/testcases/kernel/power_management/runpwtests04.sh
> @@ -46,7 +46,7 @@ check_cpuidle_sysfs_files() {
>   }
>   
>   # Checking test environment
> -check_kervel_arch
> +check_arch
>   
>   # Checking cpuidle sysfs interface files
>   if check_cpuidle_sysfs_files ; then
> diff --git a/testcases/kernel/power_management/runpwtests05.sh b/testcases/kernel/power_management/runpwtests05.sh
> index 1c87d8d0c..03b6752bf 100755
> --- a/testcases/kernel/power_management/runpwtests05.sh
> +++ b/testcases/kernel/power_management/runpwtests05.sh
> @@ -25,15 +25,10 @@ export TST_TOTAL=2
>   . pm_include.sh
>   
>   # Checking test environment
> -check_kervel_arch
> +check_arch
>   
> -if tst_kvcmp -gt "2.6.29"; then
> -	max_sched_mc=2
> -	max_sched_smt=2
> -else
> -	max_sched_mc=1
> -	max_sched_smt=1
> -fi
> +max_sched_mc=2
> +max_sched_smt=2
>   
>   tst_require_cmds python3
>   
> diff --git a/testcases/kernel/power_management/runpwtests06.sh b/testcases/kernel/power_management/runpwtests06.sh
> index 1ec193ad4..16e50a670 100755
> --- a/testcases/kernel/power_management/runpwtests06.sh
> +++ b/testcases/kernel/power_management/runpwtests06.sh
> @@ -45,13 +45,9 @@ test_timer_migration() {
>   }
>   
>   # Checking test environment
> -check_kervel_arch
> +check_arch
>   
> -if tst_kvcmp -ge "2.6.31"; then
> -	timer_migr_support_compatible=0
> -else
> -	timer_migr_support_compatible=1
> -fi
> +timer_migr_support_compatible=0
>   
>   if [ $timer_migr_support_compatible -eq 1 ]; then
>   	tst_brkm TCONF "Kernel version does not support Timer migration"
> diff --git a/testcases/kernel/power_management/runpwtests_exclusive01.sh b/testcases/kernel/power_management/runpwtests_exclusive01.sh
> index 3a824e5eb..f309d7c19 100755
> --- a/testcases/kernel/power_management/runpwtests_exclusive01.sh
> +++ b/testcases/kernel/power_management/runpwtests_exclusive01.sh
> @@ -25,15 +25,10 @@ export TST_TOTAL=2
>   . pm_include.sh
>   
>   # Checking test environment
> -check_kervel_arch
> +check_arch
>   
> -if tst_kvcmp -gt "2.6.29"; then
> -	max_sched_mc=2
> -	max_sched_smt=2
> -else
> -	max_sched_mc=1
> -	max_sched_smt=1
> -fi
> +max_sched_mc=2
> +max_sched_smt=2
>   
>   tst_require_cmds python3
>   
> diff --git a/testcases/kernel/power_management/runpwtests_exclusive02.sh b/testcases/kernel/power_management/runpwtests_exclusive02.sh
> index fa445185e..547e88fea 100755
> --- a/testcases/kernel/power_management/runpwtests_exclusive02.sh
> +++ b/testcases/kernel/power_management/runpwtests_exclusive02.sh
> @@ -25,13 +25,9 @@ export TST_TOTAL=1
>   . pm_include.sh
>   
>   # Checking test environment
> -check_kervel_arch
> +check_arch
>   
> -if tst_kvcmp -gt "2.6.29"; then
> -	max_sched_smt=2
> -else
> -	max_sched_smt=1
> -fi
> +max_sched_smt=2
>   
>   tst_require_cmds python3
>   
> diff --git a/testcases/kernel/power_management/runpwtests_exclusive03.sh b/testcases/kernel/power_management/runpwtests_exclusive03.sh
> index 0d5724825..67c7243e8 100755
> --- a/testcases/kernel/power_management/runpwtests_exclusive03.sh
> +++ b/testcases/kernel/power_management/runpwtests_exclusive03.sh
> @@ -25,15 +25,10 @@ export TST_TOTAL=2
>   . pm_include.sh
>   
>   # Checking test environment
> -check_kervel_arch
> +check_arch
>   
> -if tst_kvcmp -gt "2.6.29"; then
> -	max_sched_mc=2
> -	max_sched_smt=2
> -else
> -	max_sched_mc=1
> -	max_sched_smt=1
> -fi
> +max_sched_mc=2
> +max_sched_smt=2
>   
>   tst_require_cmds python3
>   
> diff --git a/testcases/kernel/power_management/runpwtests_exclusive04.sh b/testcases/kernel/power_management/runpwtests_exclusive04.sh
> index 15e031a43..46985b3be 100755
> --- a/testcases/kernel/power_management/runpwtests_exclusive04.sh
> +++ b/testcases/kernel/power_management/runpwtests_exclusive04.sh
> @@ -25,7 +25,7 @@ export TST_TOTAL=2
>   . pm_include.sh
>   
>   # Checking test environment
> -check_kervel_arch
> +check_arch
>   
>   tst_require_cmds python3
>   
> diff --git a/testcases/kernel/power_management/runpwtests_exclusive05.sh b/testcases/kernel/power_management/runpwtests_exclusive05.sh
> index 9d4e01683..38450d1fd 100755
> --- a/testcases/kernel/power_management/runpwtests_exclusive05.sh
> +++ b/testcases/kernel/power_management/runpwtests_exclusive05.sh
> @@ -25,15 +25,10 @@ export TST_TOTAL=2
>   . pm_include.sh
>   
>   # Checking test environment
> -check_kervel_arch
> +check_arch
>   
> -if tst_kvcmp -gt "2.6.29"; then
> -	max_sched_mc=2
> -	max_sched_smt=2
> -else
> -	max_sched_mc=1
> -	max_sched_smt=1
> -fi
> +max_sched_mc=2
> +max_sched_smt=2
>   
>   tst_require_cmds python3
>   
> diff --git a/testcases/kernel/security/cap_bound/run_capbounds.sh b/testcases/kernel/security/cap_bound/run_capbounds.sh
> index 6164f62d6..ddf186426 100755
> --- a/testcases/kernel/security/cap_bound/run_capbounds.sh
> +++ b/testcases/kernel/security/cap_bound/run_capbounds.sh
> @@ -19,12 +19,6 @@
>   ##                                                                            ##
>   ################################################################################
>   
> -if tst_kvcmp -lt "2.6.25"; then
> -	tst_resm TCONF "System kernel version is less than 2.6.25"
> -	tst_resm TCONF "Cannot execute test"
> -	exit 32
> -fi
> -
>   echo "testing bounding set reading"
>   exit_code=0
>   
> diff --git a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
> index ca6c840b1..9d0575b90 100755
> --- a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
> +++ b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
> @@ -46,10 +46,6 @@ mount_debugfs()
>   
>   setup()
>   {
> -	if tst_kvcmp -lt 2.6.30 ; then
> -		tst_brk TCONF "Dynamic debug is available since version 2.6.30"
> -	fi
> -
>   	mount_debugfs
>   	if [ ! -d "$DEBUGFS_PATH/dynamic_debug" ] ; then
>   		tst_brk TBROK "Unable to find $DEBUGFS_PATH/dynamic_debug"
> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
> index 4a3e68a72..50329c684 100755
> --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
> @@ -15,31 +15,13 @@
>   
>   LOOP=400
>   
> -# In kernel which is older than 2.6.32, we set global clock
> -# via trace_options.
> -if tst_kvcmp -lt "2.6.32"; then
> -        old_kernel=1
> -else
> -        old_kernel=0
> -fi
> -
>   while true; do
>   	i=0
> -	if [ $old_kernel -eq 1 ]; then
> -		while [ $i -lt $LOOP ]; do
> -			echo 1 > "$TRACING_PATH"/options/global-clock
> -			echo 0 > "$TRACING_PATH"/options/global-clock
> -			i=$((i + 1))
> -		done
> -	else
> -		while [ $i -lt $LOOP ]; do
> -			echo local > "$TRACING_PATH"/trace_clock
> -			echo global > "$TRACING_PATH"/trace_clock
> -			i=$((i + 1))
> -		done
> -
> -	fi
> -
> +	while [ $i -lt $LOOP ]; do
> +		echo local > "$TRACING_PATH"/trace_clock
> +		echo global > "$TRACING_PATH"/trace_clock
> +		i=$((i + 1))
> +	done
>   	sleep 1
>   done
>   
> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
> index 50aeef970..f7177c988 100755
> --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
> @@ -22,12 +22,6 @@ if [ ! -e "$TRACING_PATH"/function_profile_enabled ]; then
>           should_skip=1
>   fi
>   
> -# For kernels older than 2.6.36, this testcase can result in
> -# divide-by-zero kernel bug
> -if tst_kvcmp -lt "2.6.36"; then
> -	should_skip=1
> -fi
> -
>   while true; do
>   	if [ $should_skip -eq 1 ]; then
>   		sleep 2
> diff --git a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
> index f890deea9..30368b079 100644
> --- a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
> +++ b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
> @@ -27,7 +27,6 @@ mcast_setup4()
>   mcast_setup6()
>   {
>   	local default_mld_max_msf=64
> -	tst_kvcmp -lt '2.6.15' && default_mld_max_msf=10
>   
>   	SYSCTL_ALL_FORCE_MLD_VERSION=$(sysctl -b net.ipv6.conf.all.force_mld_version)
>   	SYSCTL_FORCE_MLD_VERSION=$(sysctl -b net.ipv6.conf.$(tst_iface).force_mld_version)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
