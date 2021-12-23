Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43538C433EF
	for <ltp@archiver.kernel.org>; Thu, 23 Dec 2021 01:42:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA6B03C9289
	for <ltp@archiver.kernel.org>; Thu, 23 Dec 2021 02:42:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 310AF3C0B99
 for <ltp@lists.linux.it>; Thu, 23 Dec 2021 02:42:33 +0100 (CET)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8D4A2201181
 for <ltp@lists.linux.it>; Thu, 23 Dec 2021 02:42:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1640223753; x=1671759753;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=hX4qW1IIXsjEVRZ3cX+bjo9QUo60NgC+z4Ij11EGuTQ=;
 b=dZyH9J8fvbHLVvCrMB/rN81fTq8Zlm3v6WvEjXTOd3micBSTXo+YkU+0
 3p/Wv3hlvgpf0+bC7rFv9jQB9nCG6Qk3FRLg9ad1jHmzVObejlefQG3Wy
 Qc7tDUFmQD3RYFIyAOAzk4hZ2z2jhCJEv8OK/sB26GcmJaBZOOZ2KQ2ZS
 EjsA593JxwzDuF8HRjxNTQZuLpfrT3IizcysXiinzmzrRTvPbLnM4MjU8
 TBUyyeUV0SrmtfbYsCKZ3R+W6naKyds3Y40QWHHgoaZwb3+P1gFViWzMa
 bfYPjywGGpXjZIYdZ54S12ZE9q037PzncgoZyqmt/8qraAX56uHfKy0qh Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="46151902"
X-IronPort-AV: E=Sophos;i="5.88,228,1635174000"; d="scan'208";a="46151902"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Dec 2021 10:42:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NK8L1To3vs0FSjENl8sEwINnZUsQ7wp2WqD5YMJRU8qme9W8EqnEKLbqA4rS/CxQ1puO6qiXzr2ppmQ9VpbwMv8k4DJ1ezPp+d9jHupwdfaPcdheIfsC635wZRAp8Mc+/OaTvL6adgMwMX0kyMY69yAaVYy4mp3QkqbRA1kevsM1MVOyx9CN3qpeEj5cj2htT0pBAxMBBdLwrKKw4XnHoEdgXXK3zbKe0P5gWCjFX6+ufC+b/GRbDT+FyTjTz7WV9MsmJSKepD+/Av1A4wJEL9872PTDur+K8MBbGExRtbwzHR/c+GNxbcRuFW5bgAmRXA3vstQZc6JI+8p+fL+qkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hX4qW1IIXsjEVRZ3cX+bjo9QUo60NgC+z4Ij11EGuTQ=;
 b=PtUkV478S48PMtEUQUtYJ/Sij+bM9jLN80clTG/hkUbYnc3HxUT0EPWNo04xWp+anrKEUAkIhrDb/NB67tqzo/dm4ifTnPmzMEOYdk+1EufBZ6947dNMwnOmN04SkYQ5pV9o79OMwL3Usc8dmdZgZxD7+GtbHzXbbsf5lRe0ls8skAPejnC0snoH21fIzKx/WSBVxVYDX6L4shuv0014YbFhd4dIYmFo84sJmBOXEgGAPvpolYjYV/urBnsG+ifP7UiN884MkduVJtoah2BIOMeda7MX8Vujc7sUVWTZ4Vyhc0ZRYguK/4Lb2VHvja53nQ+g4MYFP7HOipf/mNMwdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hX4qW1IIXsjEVRZ3cX+bjo9QUo60NgC+z4Ij11EGuTQ=;
 b=UNVUSZ3u5Dk867Eo6HSHxRtP72tO9Vw2kenIT5BCkK2Rp5HwAj/461K6zhXT0mkic0+cKwABqHpKx2qMZgaH9u65vnpQ/6bJNyyayLTfR+LrNKO017s15YQO+Z4e6VehhZAm7sri5EKPS+kk6pNOM16zJUB6gXdLLw7TTKdWCTs=
Received: from OS3PR01MB6535.jpnprd01.prod.outlook.com (2603:1096:604:100::7)
 by OS0PR01MB6500.jpnprd01.prod.outlook.com (2603:1096:604:105::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Thu, 23 Dec
 2021 01:42:26 +0000
Received: from OS3PR01MB6535.jpnprd01.prod.outlook.com
 ([fe80::bc41:b2e4:2c49:8be3]) by OS3PR01MB6535.jpnprd01.prod.outlook.com
 ([fe80::bc41:b2e4:2c49:8be3%8]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 01:42:25 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "daisl.fnst@fujitsu.com" <daisl.fnst@fujitsu.com>
Thread-Topic: [LTP] [PATCH v3] syscalls/write06: Add new test
Thread-Index: AQHX9jjWo1M6DIiPM06HtD0zNENjCKw/UE2A
Date: Thu, 23 Dec 2021 01:42:25 +0000
Message-ID: <61C3D411.8070906@fujitsu.com>
References: <YcBSmpdWBnx/L/XY@pevik>
 <1640117003-627-1-git-send-email-daisl.fnst@fujitsu.com>
In-Reply-To: <1640117003-627-1-git-send-email-daisl.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a244f0cb-c17c-4029-e2c1-08d9c5b57885
x-ms-traffictypediagnostic: OS0PR01MB6500:EE_
x-microsoft-antispam-prvs: <OS0PR01MB650083E17D2F2458C344E270FD7E9@OS0PR01MB6500.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yG9+yOD2mvWlM5Y91MMzK4O+Tcr5b8gFrmr2BXwvmZXZvTFYYT8FR30Jy985KMC9SwKfwTagD90Aks4W61dlWnmjwJywdRrJ5P5oPe//s74dCskmYiyXcFVWXoYG/Ex7dhIG7aiLw5SYcBGfpvKEaKXx13G4WrFWb2gfZ4DQWdt/rJapTPGYNoz5lIDoeLGvjVtE5dSynZsb/pjOsPaddbR+8HdOLi5g+X9GhMo9wSjPaM0tTlpdgyFeSQsK9r9mkTU4LkBUUzd+AJ9J9BEN/DmKfFunkNPImOZflUA288Yf90Ynutal5GjnG+557maElL70JFZA4t28hVKMs4jSpYUP/U7Nyga9QuVU684HzALX8i/3k101//c8nTeg/y4vKEk6LBieHM6AuwrCvVfGidozIX+2VPkh2r5fA3ihRHjBojwStfOQhkt+C2pJclR2M/9sV1qo8EdMKVNWJM0gn8XczXZHx1wPnswAYva/0TZ313V2CsxUEMmx9/ybpwX3omDMHatNG2TmdgdTKKcIzC2MU5517Yq47aVP2XmZ+frn1f0MET1BwC6ZH88RH9gooFx7T2OcbwQ4qCMNT7axSxKuQqutnXburbf/QdNCURw8Q9cozIwPiFZGBLaK56/+9ysIBGCn+4kIQ9AjQTqgxBtJJOFkRMVGymuyqOhODpweuXVNeFhA/3jTS1Plp8APUk2Zg6o+U/Y+QjbCURTKWw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6535.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(6636002)(2906002)(83380400001)(508600001)(4326008)(37006003)(54906003)(91956017)(6486002)(38100700002)(186003)(26005)(316002)(8936002)(122000001)(82960400001)(87266011)(6512007)(71200400001)(38070700005)(85182001)(33656002)(6862004)(5660300002)(6506007)(2616005)(66476007)(66556008)(64756008)(66446008)(66946007)(36756003)(76116006)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bkdoMVdtNSt5VFZyeS8yK08vWUtUL1dhdFJadTF5U05tMnBBWHpCN01sUTRj?=
 =?gb2312?B?RS9CeTB3NWdXcFJKcmFRYUtNcDIwUHAvWjFxZC9wOUNhN0tpb3dnNzlXdDE4?=
 =?gb2312?B?US9nM2VRZmNvL2VkYkFUSk5leTF5UlpMU2xZRGVBWnZuZDZxZy9PMDNmTGN0?=
 =?gb2312?B?Tk5mQXBsSi9Zc3NJbk9wYzVjYTE1Q3BlU1FESjRwby9nenBxSDRtbkFjVFFT?=
 =?gb2312?B?UkYzc21sNk9hTVYwZmJ1NVJOeFR1N1VwNi82ZVpYTmdTSy8vQmJaRnoxS2lW?=
 =?gb2312?B?TldKKy8vczJpUUJCdTRhL09aU2RKaTZ0ZnZUZk5Cd1dWemdPTUJFMHUwUWhS?=
 =?gb2312?B?S09NOXdSMUNyUmgzU0lEazMvQnk0QWVlWXl5eHJHMHlvTE0xWDNYdWRqOFFC?=
 =?gb2312?B?cFdWRno2YXU2L3BXZG1FVXY0WnUyc2hONTNGZkY3SS9QU0VibkQxMVc0dXov?=
 =?gb2312?B?RTB5akNiSlpTMHVLZzJuL3dCNnNXR0ZWeGdDUWlxWi9LSS90d3BxbFkrN0g1?=
 =?gb2312?B?TDFzb1ltZjluNXk4dmExWGFoVENLK0xnR2pMMElUUFBudk52ZUhwRDcyYUd6?=
 =?gb2312?B?SWRXOXRCa0Zoa1JWSUJYdXhrOHZrVytwQmJuK1V2M0Ftb2lpRkkzYXJsSmtY?=
 =?gb2312?B?VUFMOVVXRjZzMnJBOXZ1SjVlRnVPM3FmQ0xIMVlLZmM5aEpYcllCMUZTWlcr?=
 =?gb2312?B?T3ZKN1VoRjZGUjhrYmhUbGJPMUJ6TERkM2pDUU1KdHlkQzVWMTJ4MW9GcFpt?=
 =?gb2312?B?djFhTlhSNHl5ckd0L2p5MmdpWUJFeVFJWEVtRnlVQjE0NUZ2RUpBTCtTamh0?=
 =?gb2312?B?TktFcXFDbzV5L3hBdkdkeXNweGJ6UDBVQjc5akdPTXdJN2ZkU01KYzhFTDho?=
 =?gb2312?B?ZStOWG1ZcE9SSmtOdjRlY1VoY0tHZVZObEVJeGZQeDg1elBZYmhCZDlibkti?=
 =?gb2312?B?TzFBSHdqeEdOUXNzT0ZFTHl3OVdsL09tQ01Relh5Q1dhMjlHWCtlQnVHQ0Rr?=
 =?gb2312?B?NjFWZVhrUnRWd2srMUJlYVVoNFF3NWF3ZC9EbnhKTExTSmxaTlZEUDUvWndU?=
 =?gb2312?B?N1RLQXE1WGtWN0VXZ0xzaGwwMm42SDhHV1QzL1QyQ0JKQ245blNpYmlZUlZt?=
 =?gb2312?B?dWxDaEFKOElQUnJnTVgzdmJ4U2hhSGtqcThvT2RTakZVTFVzTkZGQ1pxUklB?=
 =?gb2312?B?ZlVQeFAxWDFjN0ZjdC9yNGJ0RlJsWmVWWDF0UFJNN0xPbTVkZzBuOXRaQnli?=
 =?gb2312?B?Ni84UXIwM0RMMVJETmxQZUE0Nkxabnc5bDVicXM4YXF5K1Y3VlZDTHV0aE1u?=
 =?gb2312?B?ZjAzTFh6TWZBMzJCZGRuKzVDK3NCVzdzRDRxYW5aQ2JCV0N2WHlnZy9OUUdq?=
 =?gb2312?B?L3lQS21MMDF6alQ5MVgveGNObUxsSWtTU0hGSXBNTDhrWld0MnludUJpUzl3?=
 =?gb2312?B?YWJkTE1ITXk2aURkLzNSS09GK2prbm40OFBPdktYcU53MFBjKy9kRlJtNDd1?=
 =?gb2312?B?UVlZV3IvZ21SMkF1NGJpbWhxWE5ocTNlZXdTMEZYTFU3TjRHV0NycFJVL1B0?=
 =?gb2312?B?NGF3QUZnVUxPZjRoL0w3OU83Rm9TdTVPOUx1Ti81b3hGUlF2SklYZjRWMlpF?=
 =?gb2312?B?WlJBNjVMcmNTRkpuZkloRk1SakltZjNmUEJ3MXphVlZVUFE4UEVORjExWXRD?=
 =?gb2312?B?NTl4UmdlL1VwVWs2c0pFeXFyOFZrbDRIUVVFUGRZRjFxR3RpZ1RCV2FaTzI1?=
 =?gb2312?B?WlJQeGdpRnl6OGdyZit1dFUvSnJqQzJZd0lzNGwrRTVqWFo5RWgzaVdyN2RK?=
 =?gb2312?B?YWlkQVZhTzZRZ3U0SzdvUjVtOUdHaDRTOG5CN2lhbmJYSEtta2hkS2ZJWlRR?=
 =?gb2312?B?RW5JRC9RWjZDUlZNZFp5YnAvZjNxYTZlVE54MWFOb3RXb09scHc3T1FMNitE?=
 =?gb2312?B?a0owVTkwY1BGOGZ5U09reWJSTkp3SUF5VVVBaEp2TXk1dDZGZCtna1NZTFhY?=
 =?gb2312?B?MXVWdzJFeUlBZEswMFZIaFdWdWlwK09tc0N5cGtFU1B4S1I0ZHVWTU1aWkdG?=
 =?gb2312?B?bEJnQ0oyeW43R3pQUW9nWGlvTUkwMlEwQkgzbU9oeVVtc1M1c1VidmpxazNk?=
 =?gb2312?B?Q29wZDFLQ2VOMmNyMFA5QXdKcU1la2gvZ0Z0WnloNVBXamliSE14ano5aUZo?=
 =?gb2312?B?WC9lYmtJcEdvUTFEMk1jbUlLR1dFS0IrMXB1TVZWOE5WL21CUFFBSmlFYXU3?=
 =?gb2312?Q?xpIkH9pxJC9Fq0Qcig+SDHBJ9XpmwueFpaliwaUiMg=3D?=
Content-ID: <959D2EB0F03DF045B34BC120ED88B48B@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6535.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a244f0cb-c17c-4029-e2c1-08d9c5b57885
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2021 01:42:25.0647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pw0Xxwy3t5VTWd+QU2eqEIKFwXekstemNum9QKDJX0ZRw1vZjh0GpgAJnWHwVyZ/BQRP6hScyHyjfw6EmJfiNpM+VObsXCOquNmSmsHaCRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6500
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/write06: Add new test
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
LGTM, merged!

Best Regards
Yang Xu
> Like pwrite04.c, test the write() system call with O_APPEND.
>
> Signed-off-by: Dai Shili<daisl.fnst@fujitsu.com>
> ---
>   runtest/syscalls                           |  1 +
>   testcases/kernel/syscalls/write/.gitignore |  1 +
>   testcases/kernel/syscalls/write/write06.c  | 94 ++++++++++++++++++++++++++++++
>   3 files changed, 96 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/write/write06.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index bcf3d56..32fcda4 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1699,6 +1699,7 @@ write02 write02
>   write03 write03
>   write04 write04
>   write05 write05
> +write06 write06
>
>   writev01 writev01
>   writev02 writev02
> diff --git a/testcases/kernel/syscalls/write/.gitignore b/testcases/kernel/syscalls/write/.gitignore
> index 7f36194..8529aae 100644
> --- a/testcases/kernel/syscalls/write/.gitignore
> +++ b/testcases/kernel/syscalls/write/.gitignore
> @@ -3,3 +3,4 @@
>   /write03
>   /write04
>   /write05
> +/write06
> diff --git a/testcases/kernel/syscalls/write/write06.c b/testcases/kernel/syscalls/write/write06.c
> new file mode 100644
> index 0000000..c175548
> --- /dev/null
> +++ b/testcases/kernel/syscalls/write/write06.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
> + * Author: Dai Shili<daisl.fnst@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test the write() system call with O_APPEND.
> + *
> + * The full description of O_APPEND is in open(2) man-pages:
> + * The file is opened in append mode.  Before each write(2), the
> + * file offset is positioned at the end of the file, as if with lseek(2).
> + * The modification of the file offset and the write operation are
> + * performed as a single atomic step.
> + *
> + * Writing 2k data to the file, close it and reopen it with O_APPEND.
> + * Verify that the file size is 3k and offset is moved to the end of the file.
> + */
> +
> +#include<stdlib.h>
> +#include<inttypes.h>
> +#include "tst_test.h"
> +#include "tst_safe_prw.h"
> +
> +#define K1              1024
> +#define K2              (K1 * 2)
> +#define K3              (K1 * 3)
> +#define DATA_FILE       "write06_file"
> +
> +static int fd = -1;
> +static char *write_buf[2];
> +
> +static void verify_write(void)
> +{
> +	off_t off;
> +	struct stat statbuf;
> +
> +	fd = SAFE_OPEN(DATA_FILE, O_RDWR | O_CREAT | O_TRUNC, 0666);
> +	SAFE_WRITE(1, fd, write_buf[0], K2);
> +	SAFE_CLOSE(fd);
> +
> +	fd = SAFE_OPEN(DATA_FILE, O_RDWR | O_APPEND);
> +	SAFE_FSTAT(fd,&statbuf);
> +	if (statbuf.st_size != K2)
> +		tst_res(TFAIL, "file size is %ld != K2", statbuf.st_size);
> +
> +	off = SAFE_LSEEK(fd, K1, SEEK_SET);
> +	if (off != K1)
> +		tst_brk(TBROK, "Failed to seek to K1");
> +
> +	SAFE_WRITE(1, fd, write_buf[1], K1);
> +
> +	off = SAFE_LSEEK(fd, 0, SEEK_CUR);
> +	if (off != K3)
> +		tst_res(TFAIL, "Wrong offset after write %zu expected %u", off, K3);
> +	else
> +		tst_res(TPASS, "Offset is correct after write %zu", off);
> +
> +	SAFE_FSTAT(fd,&statbuf);
> +	if (statbuf.st_size != K3)
> +		tst_res(TFAIL, "Wrong file size after append %zu expected %u", statbuf.st_size, K3);
> +	else
> +		tst_res(TPASS, "Correct file size after append %u", K3);
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void setup(void)
> +{
> +	memset(write_buf[0], 0, K2);
> +	memset(write_buf[1], 1, K1);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd != -1)
> +		SAFE_CLOSE(fd);
> +
> +	SAFE_UNLINK(DATA_FILE);
> +}
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = verify_write,
> +	.bufs = (struct tst_buffers[]) {
> +		{&write_buf[0], .size = K2},
> +		{&write_buf[1], .size = K1},
> +		{}
> +	}
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
