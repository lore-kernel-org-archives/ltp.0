Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC642C433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 04:03:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27EA93C9447
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 05:03:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 015913C0711
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 05:03:34 +0100 (CET)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 070D51A008AB
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 05:03:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1647576213; x=1679112213;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=VIVimmLvdLESiVjOttwBRfjSp8E5hWRIaYA8NNtP0TM=;
 b=mOvyGy6jRu9O0ZuUBoTgayMmPROhS3i9XSIWAox6Te6DO6FaPmT0Vklc
 Tutnim7745Ft/gDV2ji5xNaypWWGDK1CaO8VFRfnrU0A1477K16izSnMx
 c0xwXGtvOs1UTrYucYJ/dmhMgpCtCcTtTGWgyRvS7q7pQBOQEnkiXjWGA
 RWIY+8b6a4eLaaOlvdwhUHefw4jLOfGcWCPzvC6ABp3sn0t6umVS19JVQ
 iT/Zx50s9zLFAVtnTVi3F3Bug4sf6Z/oMrMge0o2tkh8NJNgDH+3hN063
 Tw6YG7BKxcN2QPDf0Jf83ANnipQnVipsc84Z5zNWPqub9by1MDVr8OwG8 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="51986696"
X-IronPort-AV: E=Sophos;i="5.90,191,1643641200"; d="scan'208";a="51986696"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 13:03:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ib80fHMEDSp6h7+tCKyE7+f4iEcP/3lBIK4sRunncrTrSLA3k77tF1cZJ1wdWCPvT99dk/2RXasugvI1dIBm2VLB1Eui1PSe2TyJnSaL4eLcvZ8Vv7nCmy6RfeZEZ8L5sZMWQXhzjIKNY9NtDW/60sjhXaJi5dSAA0TfAM9AKZaP8ZsyIyr0vzMQ1D/tppFgsaFAhH1pbOp/7pjP0hhh9Tw6V1qf43CMuTOklbg7hLW6qM4kVoDzLORpUzgfTazt4Tvjb+FaMAHzn9PojqTdlGG5uFHyD5zVR16OQkA1nRHs+MBRuF8JGCghdIuw93c1DrKF0uzt60F0jTFNl2N88w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIVimmLvdLESiVjOttwBRfjSp8E5hWRIaYA8NNtP0TM=;
 b=lD2pmBd6XmyGa2KgHqHSRTjxc0D2NeFR+VrbzGuvikB/PortTvyzOXro9UOIzcAxDXgjjCPQftUPuU5QcjslHGGUcyn7EiAA/3AX7tTLrVGpRNNFR83nkjCZKHw7/4txdsleL2Zw+aYja9sBE8rpSQFwt8QsmZrNmTDKQT+DZxYB/ZIR1Yryaaj1MRW+FnIP+fetnZOQzTA1hibjv9FknmYvOzEmHcM7Is/OeSXG15dw5QQgnLhOwYDTndNl4uSODxpXKzNJiDN+gihUUF3jJJud9PkRxIk465zC0IPuUA/ddInLqidZZGM4+4Zx73z3xldL5Y/llfjFTbMidxVB+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIVimmLvdLESiVjOttwBRfjSp8E5hWRIaYA8NNtP0TM=;
 b=N2DbSrxjOBsif/Tv6jr4l8VOLvsEbOvsydixjNyXT9e3TmV+ufiKUi1CLlIq3O/E9T6VEZ6n6SNhzemsZaLyhrfbfp2zHvCG30Q58YwOM0Q8v6rxDbNajcfd47/8gDR7pmzSWioDI/vt86P5Z8fV1bO8VTsgzC1yfu3xe/3f6/o=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSBPR01MB3943.jpnprd01.prod.outlook.com (2603:1096:604:49::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 04:03:28 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 04:03:28 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "daisl.fnst@fujitsu.com" <daisl.fnst@fujitsu.com>
Thread-Topic: [PATCH v2 3/3] syscalls/umount2: Convert to new API and use
 SAFE_ACCESS
Thread-Index: AQHYOd2QlmtC+uab6Ey66DlhPzspCKzEhrgA
Date: Fri, 18 Mar 2022 04:03:28 +0000
Message-ID: <623404BC.90906@fujitsu.com>
References: <622EE434.4000400@fujitsu.com>
 <1647550813-1958-1-git-send-email-daisl.fnst@fujitsu.com>
 <1647550813-1958-3-git-send-email-daisl.fnst@fujitsu.com>
In-Reply-To: <1647550813-1958-3-git-send-email-daisl.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99064de7-30b0-485a-371f-08da08944215
x-ms-traffictypediagnostic: OSBPR01MB3943:EE_
x-microsoft-antispam-prvs: <OSBPR01MB3943A481FE62577D27ED0ECEFD139@OSBPR01MB3943.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aDtKvHCEED0NrSusGQ2t3Y+JEXuF3tfEchc7TDL0OP6K8oL3PzjV4Wh+B2upTZa5VEpTiCESXoDX1ukP70cU62HMJCtSOrwW2iKJWrqrVnupMRtqGw0Z1HDvGg4kSnsx+EiPjVLFB68mjSWPLM8qhA+TvszWz0icUq02VtYKgwyFfqmolIdONFwMHgKlIsTzogf4rBuK6jU0Urinjg59ohObq3iBm2yuI3ndlUkg9/2uI54rQqjVdxStuDdaHCZKRY5A74BTCdUUBf15GLPWPTRuumPOrVnBPotdb3GWVLB8/+9WfP9AEPFbZ4wOtXRAvvnI3pKuiVQE9Ghi2ClhXuCVrpo1vM9G5h6oxhB4Kqq3So9G9lsb2Lrx60VwlNBW181aW/Ow/3iELT9E3Dd5yVN542KAUeqbnOa8HB8AVAm8zXoFn4WnZTnCojtWDwRiIXed7qJ7+CzZmClMl19o90nlUU235S0bS0ueaVk3vCQjfU1r2TNCvwqck7EZi+HZFlRZrvzLGiy8A5z8ckjeaYubw+PcupNAhk9qEbWJRdm/Q4+rBEqTQreG8QIOeIRYLeR8cp4PJjzFyiXTKVpFHLYovVYm+nsMv97EGFpk832OPZHWeDKY9uR0Ue/uLBWL3rflRi1MwgGj8ewX1X0MS1KwqEJOu3WTzzpnNqS8g7TxpUJlzOHdafoaaeqq5xZ49S/acFAkcQRQTQMqiKEWJxoPXnYWuoe94cSs8MsbWC4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(36756003)(83380400001)(33656002)(2906002)(2616005)(85182001)(6486002)(6636002)(508600001)(82960400001)(30864003)(76116006)(66556008)(66476007)(66446008)(66946007)(91956017)(64756008)(6862004)(38070700005)(8676002)(4326008)(8936002)(316002)(71200400001)(6506007)(122000001)(6512007)(86362001)(38100700002)(5660300002)(37006003)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UDhBS2NyNW1uWkM0dGx2alVZZ1BkNTZjSVdyOGkxUUJUMmRvNTBLVFpSVExx?=
 =?gb2312?B?d0pWMDJ0OUNFNXE5d0hGeFFwRWthc3FmVmlKZWxlSjR0aUFWcDRiYTdUY3Nm?=
 =?gb2312?B?bkE1TG9USU9GaVM2czNoZWcyNllmY2Y1OCtNU2xhMytsYldQSEozKzlzK0I5?=
 =?gb2312?B?Y3pLLzJlbktSZk1ua29iSHdWdklWQWdSSlRtdkdIeGhzS0dHL2YxSTZ2Lzd5?=
 =?gb2312?B?WTYvb3QxcGNOSHViNVJCTGI1TUxidkJsaWRHb2l3NzlzeTk4bFBpV0dobUt0?=
 =?gb2312?B?dVA5TllxOTF2VzltTVlCNEt4SnFTYjRZRUEwTEIzWHRrQnNUZUVyNU5zVk13?=
 =?gb2312?B?dlMxdXFXTTJobTQ3aEM4UVFSeUI5cm5XT2dmYU1XQmNjTVFHRTNoQVo3VmVT?=
 =?gb2312?B?Y2VyYjMrK3B3c0pZU2hIV2JtVVJxMUtFUm5SS3RXOXEwcnlQR2hyV0FrMjF4?=
 =?gb2312?B?VlJ3RUhJaUk5bU55QWliUnd0UDNIcTRLVXl6QWtXcWJvYmhua0J3YzJyMjU2?=
 =?gb2312?B?Um9zMExDOVBKcmJNcXFOS2ZJK2ZINkZ3U05Iems0VWF3ZzFPVDB2T1VhWmpl?=
 =?gb2312?B?UHFEWHZPZ1d5S3QrcVVLbjF4ck4zU0pXVGkremh0eXhuRDNMbDlYdnVOOU41?=
 =?gb2312?B?cUJVVUpRZ2FvZW8rYXZnMEc2SnA4QnR1Vmk0bFBPTlpLUUpqMlJlUktEZlI5?=
 =?gb2312?B?NzdsZkxqeVJXV2xRU01uOUtHb2ZXNXdUNmtydlpNVW94M0JmZTNqeVB5akxw?=
 =?gb2312?B?S2QvMkx6aWtsQy9aVWNTelczeCtYRzRkaXBQazhCYmVaYmpsZlFrMmYyTGtB?=
 =?gb2312?B?SXhZdGJDK29ISHQ4Zm9LcHg5RnhPRHV5TVNwQ1Nrd2N1dm5YZFB2eHhMMElM?=
 =?gb2312?B?c09Ib0I3RzhIYk9EMVl6Yzl1a0Q2NlEyY2Vud3YrV3lDb3BKTFlud0o3RFJK?=
 =?gb2312?B?VFZYOEF3a0dWTVRZZ3gyZE1kOTc4cjlLWjdvRnFFelJtS3Rmb0VsakI3U1Fv?=
 =?gb2312?B?ZmVScERkMGZPRFZNMy9zWGVFdU9WZmZ4MTUySXNRZVY1VzBmbjQxeWh0Qzcw?=
 =?gb2312?B?WGtOT2FBZnMxc3dncGdjMGNJQndYeXF6RXZEV3cwUkZJRnhpcXpqSzh5SnlB?=
 =?gb2312?B?R2NmZGNoczZRSHJjVG5Vck5rRmNXT1dOV0ZnV1F5TjBoMU9iMVJOT3dzeUNw?=
 =?gb2312?B?dzRWT1RFQTFRTXNMZEpHSFU3QThMemQ2VHJQa01tblkrSEpzNm11OUZ5cWlE?=
 =?gb2312?B?ZHp4VXpPdjRpcFRhWkxPZ21pbFpNTERaUFF1a3Z6S0pucEpwcFoyYjBSK2Ir?=
 =?gb2312?B?WnZqdU4yeW12MnB5Y09NSWxQS3krZW1HQ29FTFRWYTRnTHBndHlKRGpwS2U4?=
 =?gb2312?B?eUNWU2FYdnhCaFRPOFhUb3RUYnBtSzJ0VjNUNHRsQW1JdWR5OVVWK2R3bWxE?=
 =?gb2312?B?LzNzQ3N3dmN2WHBQd09RdHV2RlZBcHpucXhRbW1ES3k3Y3NuK0k3b01TN3hZ?=
 =?gb2312?B?ZE5teE9GaS9Vcm9rZkd0bkVMb3cvUVpwRGw3VTNNYVcwbjdZQmZONmJFUFJW?=
 =?gb2312?B?TGZ2bEVWM1VFd1psS3l5R2JETHZZWFZodlBhQ2s3TlBJY0tFRkdJcDY1czBV?=
 =?gb2312?B?cnk2bUtzVGY1SzluWWFHdFJHbGl0NkR2RG8vSlh3ZDFETmJEdlMvZ1NWbGZ5?=
 =?gb2312?B?RDd3UDkreGR6M0JmbHdhK0RZc0pLM2dCVUtoN09FYmF2MXNpaUh6KzNpenFF?=
 =?gb2312?B?MWtWOHBMak12MGpTcStzRjQvbkpXVlgybGd1YzBLSEJoWXJhbWxCUHVYdnJK?=
 =?gb2312?B?cjJ5ZTdxR3Bxd1VCQUlXZlRCcU5vUlJZdTg2eXdYRlZOYVVHYVhDclFic01r?=
 =?gb2312?B?RVVEMFA1b1VGQU9NcWM5T3VxQ0ZFemxEN05IeEN0NitWeWVzS3BmKy85VXJ1?=
 =?gb2312?B?cWdKT0pJSDFxZVdxUEpydnhrbW1nTjhON1RjcHFWRmZSMzRJL1ErVFlqSDhN?=
 =?gb2312?Q?S9w8kT95m+pItAHC+YO7pXrScTGJts=3D?=
Content-ID: <6BB11CAF9620F84290AD82596B612D05@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99064de7-30b0-485a-371f-08da08944215
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 04:03:28.2121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FIoyBb4W+hYY47I9g8/P72b9cEevuJ7hS3DfHC9+sFM6DfVNpSATjf+0i4q3cnzTcdkMoThyYsd4zPtG3KhnGicELCjlLwk5hTPUIpwC3+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3943
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] syscalls/umount2: Convert to new API and
 use SAFE_ACCESS
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

Since umount2_02 and umount2_03 is similar, can we merge them into a
single case?

Best Regards
Yang Xu
> 1. use TST_EXP_FAIL and TST_EXP_PASS macro
> 2. use SAFE macro
> 3. simplify verify operations
> 
> Signed-off-by: Dai Shili<daisl.fnst@fujitsu.com>
> ---
>   testcases/kernel/syscalls/umount2/umount2.h    |   5 +-
>   testcases/kernel/syscalls/umount2/umount2_02.c | 194 +++++++------------------
>   testcases/kernel/syscalls/umount2/umount2_03.c | 167 +++++----------------
>   3 files changed, 94 insertions(+), 272 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/umount2/umount2.h b/testcases/kernel/syscalls/umount2/umount2.h
> index 65e4c24..d1e486e 100644
> --- a/testcases/kernel/syscalls/umount2/umount2.h
> +++ b/testcases/kernel/syscalls/umount2/umount2.h
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) 2016 Cyril Hrubis<chrubis@suse.cz>
>    *
> @@ -28,13 +29,13 @@ static inline int umount2_retry(const char *target, int flags)
>   		if (ret == 0 || errno != EBUSY)
>   			return ret;
> 
> -		tst_resm(TINFO, "umount('%s', %i) failed with EBUSY, try %2i...",
> +		tst_res(TINFO, "umount('%s', %i) failed with EBUSY, try %2i...",
>   			 target, flags, i);
> 
>   		usleep(100000);
>   	}
> 
> -	tst_resm(TWARN, "Failed to umount('%s', %i) after 50 retries",
> +	tst_res(TWARN, "Failed to umount('%s', %i) after 50 retries",
>   	         target, flags);
> 
>   	errno = EBUSY;
> diff --git a/testcases/kernel/syscalls/umount2/umount2_02.c b/testcases/kernel/syscalls/umount2/umount2_02.c
> index 7d558fa..39f1608 100644
> --- a/testcases/kernel/syscalls/umount2/umount2_02.c
> +++ b/testcases/kernel/syscalls/umount2/umount2_02.c
> @@ -1,182 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - * Copyright (c) 2015 Fujitsu Ltd.
> + * Copyright (c) 2015-2022 FUJITSU LIMITED. All rights reserved
>    * Author: Guangwen Feng<fenggw-fnst@cn.fujitsu.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * You should have received a copy of the GNU General Public License
> - * alone with this program.
>    */
> 
>   /*
> - * DESCRIPTION
> + * [Description]
> + *
>    *  Test for feature MNT_EXPIRE of umount2().
> - *  "Mark the mount point as expired.If a mount point is not currently
> - *   in use, then an initial call to umount2() with this flag fails with
> - *   the error EAGAIN, but marks the mount point as expired. The mount
> - *   point remains expired as long as it isn't accessed by any process.
> - *   A second umount2() call specifying MNT_EXPIRE unmounts an expired
> - *   mount point. This flag cannot be specified with either MNT_FORCE or
> - *   MNT_DETACH. (fails with the error EINVAL)"
> + *
> + * - EINVAL when flag is specified with either MNT_FORCE or MNT_DETACH
> + * - EAGAIN when initial call to umount2(2) with MNT_EXPIRE
> + * - EAGAIN when umount2(2) with MNT_EXPIRE after access(2)
> + * - succeed when second call to umount2(2) with MNT_EXPIRE
>    */
> 
> -#include<errno.h>
>   #include<sys/mount.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
>   #include "lapi/mount.h"
> -
> +#include "tst_test.h"
>   #include "umount2.h"
> 
> -#define DIR_MODE	(S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH)
> -#define MNTPOINT	"mntpoint"
> -
> -static void setup(void);
> -static void test_umount2(int i);
> -static void verify_failure(int i);
> -static void verify_success(int i);
> -static void cleanup(void);
> -
> -static const char *device;
> -static const char *fs_type;
> +#define MNTPOINT        "mntpoint"
> 
>   static int mount_flag;
> 
> -static struct test_case_t {
> +static struct tcase {
>   	int flag;
>   	int exp_errno;
>   	int do_access;
>   	const char *desc;
> -} test_cases[] = {
> +} tcases[] = {
>   	{MNT_EXPIRE | MNT_FORCE, EINVAL, 0,
> -		"umount2(2) with MNT_EXPIRE | MNT_FORCE expected EINVAL"},
> +		"umount2() with MNT_EXPIRE | MNT_FORCE expected EINVAL"},
> +
>   	{MNT_EXPIRE | MNT_DETACH, EINVAL, 0,
> -		"umount2(2) with MNT_EXPIRE | MNT_DETACH expected EINVAL"},
> +		"umount2() with MNT_EXPIRE | MNT_DETACH expected EINVAL"},
> +
>   	{MNT_EXPIRE, EAGAIN, 0,
> -		"initial call to umount2(2) with MNT_EXPIRE expected EAGAIN"},
> +		"initial call to umount2() with MNT_EXPIRE expected EAGAIN"},
> +
>   	{MNT_EXPIRE, EAGAIN, 1,
> -		"umount2(2) with MNT_EXPIRE after access(2) expected EAGAIN"},
> +		"umount2() with MNT_EXPIRE after access() expected EAGAIN"},
> +
>   	{MNT_EXPIRE, 0, 0,
> -		"second call to umount2(2) with MNT_EXPIRE expected success"},
> +		"second call to umount2() with MNT_EXPIRE expected success"},
>   };
> 
> -char *TCID = "umount2_02";
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> -
> -int main(int ac, char **av)
> +static void test_umount2(unsigned int n)
>   {
> -	int lc;
> -	int tc;
> +	struct tcase *tc =&tcases[n];
> 
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
> +	if (!mount_flag) {
> +		SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
>   		mount_flag = 1;
> -
> -		for (tc = 0; tc<  TST_TOTAL; tc++)
> -			test_umount2(tc);
> -
> -		if (mount_flag) {
> -			if (tst_umount(MNTPOINT))
> -				tst_brkm(TBROK, cleanup, "umount() failed");
> -			mount_flag = 0;
> -		}
>   	}
> 
> -	cleanup();
> -	tst_exit();
> -}
> -
> -static void setup(void)
> -{
> -	tst_require_root();
> -
> -	if ((tst_kvercmp(2, 6, 8))<  0) {
> -		tst_brkm(TCONF, NULL, "This test can only run on kernels "
> -			 "that are 2.6.8 or higher");
> -	}
> -
> -	tst_sig(NOFORK, DEF_HANDLER, NULL);
> -
> -	tst_tmpdir();
> +	tst_res(TINFO, "Testing %s", tc->desc);
> 
> -	fs_type = tst_dev_fs_type();
> -	device = tst_acquire_device(cleanup);
> +	if (tc->do_access)
> +		SAFE_ACCESS(MNTPOINT, F_OK);
> 
> -	if (!device)
> -		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
> -
> -	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
> -
> -	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
> -
> -	TEST_PAUSE;
> -}
> -
> -static void test_umount2(int i)
> -{
> -	/* a new access removes the expired mark of the mount point */
> -	if (test_cases[i].do_access) {
> -		if (access(MNTPOINT, F_OK) == -1)
> -			tst_brkm(TBROK | TERRNO, cleanup, "access(2) failed");
> -	}
> -
> -	TEST(umount2_retry(MNTPOINT, test_cases[i].flag));
> -
> -	if (test_cases[i].exp_errno != 0)
> -		verify_failure(i);
> -	else
> -		verify_success(i);
> -}
> -
> -static void verify_failure(int i)
> -{
> -	if (TEST_RETURN == 0) {
> -		tst_resm(TFAIL, "%s passed unexpectedly", test_cases[i].desc);
> -		mount_flag = 0;
> -		return;
> -	}
> -
> -	if (TEST_ERRNO != test_cases[i].exp_errno) {
> -		tst_resm(TFAIL | TTERRNO, "%s failed unexpectedly",
> -			 test_cases[i].desc);
> -		return;
> -	}
> -
> -	tst_resm(TPASS | TTERRNO, "umount2(2) failed as expected");
> -}
> -
> -static void verify_success(int i)
> -{
> -	if (TEST_RETURN != 0) {
> -		tst_resm(TFAIL | TTERRNO, "%s failed unexpectedly",
> -			 test_cases[i].desc);
> -		return;
> +	if (tc->exp_errno) {
> +		TST_EXP_FAIL(umount2_retry(MNTPOINT, tc->flag), tc->exp_errno,
> +			"umount2_retry(%s, %d)", MNTPOINT, tc->flag);
> +		if (!TST_PASS)
> +			mount_flag = 0;
> +	} else {
> +		TST_EXP_PASS(umount2_retry(MNTPOINT, tc->flag),
> +			"umount2_retry(%s, %d)", MNTPOINT, tc->flag);
> +		if (TST_PASS)
> +			mount_flag = 0;
>   	}
> -
> -	tst_resm(TPASS, "umount2(2) succeeded as expected");
> -	mount_flag = 0;
>   }
> 
>   static void cleanup(void)
>   {
> -	if (mount_flag&&  tst_umount(MNTPOINT))
> -		tst_resm(TWARN | TERRNO, "Failed to unmount");
> -
> -	if (device)
> -		tst_release_device(device);
> -
> -	tst_rmdir();
> +	if (mount_flag)
> +		SAFE_UMOUNT(MNTPOINT);
>   }
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.needs_device = 1,
> +	.format_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.test = test_umount2,
> +};
> diff --git a/testcases/kernel/syscalls/umount2/umount2_03.c b/testcases/kernel/syscalls/umount2/umount2_03.c
> index a8fddf6..f44ff79 100644
> --- a/testcases/kernel/syscalls/umount2/umount2_03.c
> +++ b/testcases/kernel/syscalls/umount2/umount2_03.c
> @@ -1,167 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - * Copyright (c) 2015 Fujitsu Ltd.
> + * Copyright (c) 2015-2022 FUJITSU LIMITED. All rights reserved
>    * Author: Guangwen Feng<fenggw-fnst@cn.fujitsu.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * You should have received a copy of the GNU General Public License
> - * alone with this program.
>    */
> 
>   /*
> - * DESCRIPTION
> + * [Description]
> + *
>    *  Test for feature UMOUNT_NOFOLLOW of umount2().
> - *  "Don't dereference target if it is a symbolic link,
> - *   and fails with the error EINVAL."
> + *
> + * - EINVAL when target is a symbolic link
> + * - succeed when target is a mount point
>    */
> 
> -#include<errno.h>
>   #include<sys/mount.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> +#include "tst_test.h"
>   #include "lapi/mount.h"
> -
>   #include "umount2.h"
> 
> -#define DIR_MODE	(S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH)
>   #define MNTPOINT	"mntpoint"
>   #define SYMLINK	"symlink"
> 
> -static void setup(void);
> -static void test_umount2(int i);
> -static void verify_failure(int i);
> -static void verify_success(int i);
> -static void cleanup(void);
> -
> -static const char *device;
> -static const char *fs_type;
> -
>   static int mount_flag;
> 
>   static struct test_case_t {
>   	const char *mntpoint;
>   	int exp_errno;
>   	const char *desc;
> -} test_cases[] = {
> +} tcase[] = {
>   	{SYMLINK, EINVAL,
>   		"umount2('symlink', UMOUNT_NOFOLLOW) expected EINVAL"},
>   	{MNTPOINT, 0,
>   		"umount2('mntpoint', UMOUNT_NOFOLLOW) expected success"},
>   };
> 
> -char *TCID = "umount2_03";
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> -
> -int main(int ac, char **av)
> +static void test_umount2(unsigned int n)
>   {
> -	int lc;
> -	int tc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> +	struct test_case_t *tc =&tcase[n];
> 
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		for (tc = 0; tc<  TST_TOTAL; tc++)
> -			test_umount2(tc);
> +	if (!mount_flag) {
> +		SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
> +		mount_flag = 1;
>   	}
> 
> -	cleanup();
> -	tst_exit();
> -}
> -
> -static void setup(void)
> -{
> -	tst_require_root();
> -
> -	if ((tst_kvercmp(2, 6, 34))<  0) {
> -		tst_brkm(TCONF, NULL, "This test can only run on kernels "
> -			 "that are 2.6.34 or higher");
> -	}
> -
> -	tst_sig(NOFORK, DEF_HANDLER, NULL);
> -
> -	tst_tmpdir();
> -
> -	fs_type = tst_dev_fs_type();
> -	device = tst_acquire_device(cleanup);
> -
> -	if (!device)
> -		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
> -
> -	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
> -
> -	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
> -
> -	SAFE_SYMLINK(cleanup, MNTPOINT, SYMLINK);
> -
> -	TEST_PAUSE;
> -}
> -
> -static void test_umount2(int i)
> -{
> -	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
> -	mount_flag = 1;
> -
> -	TEST(umount2_retry(test_cases[i].mntpoint, UMOUNT_NOFOLLOW));
> -
> -	if (test_cases[i].exp_errno != 0)
> -		verify_failure(i);
> -	else
> -		verify_success(i);
> -
> -	if (mount_flag) {
> -		if (tst_umount(MNTPOINT))
> -			tst_brkm(TBROK, cleanup, "umount() failed");
> -		mount_flag = 0;
> +	tst_res(TINFO, "Testing %s", tc->desc);
> +
> +	if (tc->exp_errno) {
> +		TST_EXP_FAIL(umount2_retry(tc->mntpoint, UMOUNT_NOFOLLOW), tc->exp_errno,
> +			"umount2_retry(%s, %d)", tc->mntpoint, UMOUNT_NOFOLLOW);
> +		if (!TST_PASS)
> +			mount_flag = 0;
> +	} else {
> +		TST_EXP_PASS(umount2_retry(tc->mntpoint, UMOUNT_NOFOLLOW),
> +			"umount2_retry(%s, %d)", tc->mntpoint, UMOUNT_NOFOLLOW);
> +		if (TST_PASS)
> +			mount_flag = 0;
>   	}
>   }
> 
> -static void verify_failure(int i)
> -{
> -	if (TEST_RETURN == 0) {
> -		tst_resm(TFAIL, "%s passed unexpectedly", test_cases[i].desc);
> -		mount_flag = 0;
> -		return;
> -	}
> -
> -	if (TEST_ERRNO != test_cases[i].exp_errno) {
> -		tst_resm(TFAIL | TTERRNO, "%s failed unexpectedly",
> -			 test_cases[i].desc);
> -		return;
> -	}
> -
> -	tst_resm(TPASS | TTERRNO, "umount2(2) failed as expected");
> -}
> -
> -static void verify_success(int i)
> +static void setup(void)
>   {
> -	if (TEST_RETURN != 0) {
> -		tst_resm(TFAIL | TTERRNO, "%s failed unexpectedly",
> -			 test_cases[i].desc);
> -		return;
> -	}
> -
> -	tst_resm(TPASS, "umount2(2) succeeded as expected");
> -	mount_flag = 0;
> +	SAFE_SYMLINK(MNTPOINT, SYMLINK);
>   }
> 
>   static void cleanup(void)
>   {
> -	if (mount_flag&&  tst_umount(MNTPOINT))
> -		tst_resm(TWARN | TERRNO, "Failed to unmount");
> -
> -	if (device)
> -		tst_release_device(device);
> -
> -	tst_rmdir();
> +	if (mount_flag)
> +		SAFE_UMOUNT(MNTPOINT);
>   }
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcase),
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.format_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.test = test_umount2,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
