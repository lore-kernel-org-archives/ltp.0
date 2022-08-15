Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28955C00140
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 08:28:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 290C83C9669
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 10:28:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D94803C010A
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 10:28:41 +0200 (CEST)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D2E85200906
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 10:28:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660552121; x=1692088121;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=jZme9K8ZXI+ekAY2DJSuLsLkSBP9AsE4eNw7fSTUYO0=;
 b=npNx4YPIbG5eyaOrXKllCrd7NhQEmuXkN/AOWv72r66++NKRgGxCEpwX
 Cru1OvoxBClakaCCc0+4wZaNV2kfhpQav3J1S7PekU1IofzA+rsBQFC5q
 5Q2jKpSW7RN39sd4Qhg/5Wdh9cqof4MuDViC/gKOpSVydhwfyXpSrB8S6
 tU7vROadvKP003mLHT1l0Ctr4zhk0JkVpz11ehy7tAfWAyrte/IBPpDX+
 tQDw4wjUJOMVrGvoxa4+VTqcC13fgI8pQipiGUOcmJDd1V1v78Fu4u6ys
 U7ws9NQh5AE3JKxurRxG6GYiqvZvukp53XoN6wKGLwy+9dtkQvep8gK2U g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="62660964"
X-IronPort-AV: E=Sophos;i="5.93,237,1654527600"; d="scan'208";a="62660964"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2022 17:28:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsY/jNll0z7kaKk3cXE95BAcn4KG99Me6bwiR3mQ2sHO6jRaZ4Nn4e1aTotU9QqXhxArh7UQTtAH2vGNh19NUYvwB3f42ymsu3ZF9e/HwCIa/lNJDMoYPxCGhI0aNxl4KbZ3Hmg894gl4zfPpxucfO1FFPAyCheAnWQFHYL40mDSy5tA1rw+/eFILQ5Iqnt7g9rdMMPto2gk5x1rICArMfIJhhx1Jbgs9TnM4KOh89+o4ojLN5YR/pmMMk4MUGjUQkLwNKoEvaYXhGusV1QY9pfv3XWDvF+x8X4fHzWMj1leeAmWhvxTwlaCbV3uUxnrx02yNkyvqKv7ujaXpISvSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZme9K8ZXI+ekAY2DJSuLsLkSBP9AsE4eNw7fSTUYO0=;
 b=is4BNbi0bpCNFlIgfPs+Vp0p2SbA09+lpVpTp/qKgQ7UAxEHD5NwlN0+xq8wVDSybOVpWmJmQ58KkJDFXzY4yOixrfCTEscXFeLoFSB018G0sjD1fiY2JAPlRyq4mI4SutNk+6gVJL8dNyxVseMteQW/NT+YnV7Yy0xnngxoC0G0DnEw163yxQQUtZ50138pNT8fcXxMdna26grY/g00SAc289ktQN5vwuZN7YyMkVu6U6VxrWIlsvCYbMNSEgo0l3vmSuG7XwMSPt6whhqvbYcDXvohii7TncS6oiR5UN5w/06QoHyuJ7+PiXi9GhahOo6lRMJBdeWqynvHa5cNBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYYPR01MB8119.jpnprd01.prod.outlook.com (2603:1096:400:111::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 08:28:35 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 08:28:35 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH] syscalls/prctl10: Add basic test for PR_SET/GET_TSC
Thread-Index: AQHYkSFX6b5AG7zxKEubkxpqtADr562v8L4A
Date: Mon, 15 Aug 2022 08:28:35 +0000
Message-ID: <42ff1e30-71c9-ee71-2333-48c8cce74f0f@fujitsu.com>
References: <1657106160-2126-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1657106160-2126-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ee7f7e5-07f3-47c3-5ff3-08da7e9825a6
x-ms-traffictypediagnostic: TYYPR01MB8119:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VLt94I7eyJuEvy42KDKlNXVz4el5TxkZQKpvVCnosyVkvVJEZzbJ7pkl/jhyULaa/sHWq18dn0lBnJ09Jv+nOsXRO29uR1VqfJaDym1ib12MO7Ag39TwZlzhxfjlq1PlcEFWvz92lNLHnFrFHS3t54zvftTBNg7zTvpGjtAt+J17HCEApdatSzGsDdJbAYvn4t2UO9NHaU/E9uti0oqllCOUeZXwj1W3BOPMscWsremhS777S0IH03FtcMqEeUA7VE0x32ytFFQPJGvaxLAOlGJSRTK8eAKKj3r2wHbWcSSNJ7OmqwP2Dc6R1s3b3VmjJBkSTerNrkHWHw3gN94hG9ajGx4ftHYhF3Hwq/iwcPi2avXoGjXlG1mjvkBdooupMJ4HKgL2i6BJAj/8df4USQIpyLjc6rR4LTBbEdrkj2E81OLYmB/Yiyvlh+3m0VOnkWGol9y/I87Eg9ruu/ARJ6C76BbhyZDEaGGEDx87xuzxK/Tcgx6Nek/982N/DvR2Bo9wtE4gh9+kEzAQy9aL7gEBgMsHZuSDh4INqdiWMXYmOrNTWPkIgp5eJrPuJ5gWuSxZf0o4qYXx5Yj3N5EIUAfJI7y1qSJvrpoB4OIkbDt0tbYNU73CF0xIrD0PZNLV2pFcg3M24S5MyEoQWvYQCA+I9ScWggADUmvJAgK8nL3uiK5XokwwVuFyTRb7E0V2uCujF5xcy9nNHNaGhKKNOtcrQAzlH+AnUNpxTl6Uubnk+QE1I3WxKSIjN9yMEU8mnUe70pPls/v0Y1q7IrEQcTSdz2m17Ihw5Dor8c2mL95T2HO8XJWdGc5wvZsO0QwoAap5lmoTVJ0i2SciWNFx8Uq8JGJXU+8gFboQ+qgHOP8SHnZ5VWUb9a7W9KJU6ona
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(186003)(478600001)(31696002)(31686004)(64756008)(5660300002)(36756003)(6506007)(2616005)(6486002)(83380400001)(8936002)(6916009)(86362001)(85182001)(316002)(41300700001)(71200400001)(38070700005)(82960400001)(8676002)(91956017)(122000001)(76116006)(1580799003)(38100700002)(6512007)(66446008)(2906002)(66946007)(66556008)(66476007)(26005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1h3VW1zS3FzS1dFWW1lRXUrL2dNNzc5WGtkeldoSlFrZGlFRm1oWGJnU1VP?=
 =?utf-8?B?cjhiMFJRMWxiOEthRFRkL0JKbFRvYStFOU5PamU0WThsT0ZaQjNlN3VsdTVY?=
 =?utf-8?B?MVI4WFJQYWRGKy9xb3RTYTMzZlI2RGZMVytVRFlMUzZaNnMydXdvc01UZ3Rx?=
 =?utf-8?B?ZDBFREJBMEx6MmUvN21sRHNURWdaeWY5dGxWOFc4TVlFaGZXbDFVd01lTDVv?=
 =?utf-8?B?d2xZaUdHWFlLU24yeXZmb0JqU29oOUpPSkVYNTFJUFFJeE9vc3ArMjRzWUFq?=
 =?utf-8?B?MFdOSGhLcVhHNGg3VStrV0pFL1NpbzdrVXN4REpkMXN6elJOa3VmRkQ0RFVu?=
 =?utf-8?B?amR0Uytzb0g3eWcrL2dSRkpNdlF5ekJFZDc4cjQ5MkhrQ003S0N0YWhCZ3pP?=
 =?utf-8?B?bnc4cWFWZWNtNEVkZ2o2U1phd0ZsMUV4T1piOFlPM1ZPMEtQZEJQRXdUU0N6?=
 =?utf-8?B?djlibFZTVWhyNi9CL0ZFWGlRT2FIeHJYUjV4ZyttVDZKVG5PS3N0ZmUza0gz?=
 =?utf-8?B?NUZKNkE1TitVQ2RNa3U2ZndJSzAzUE52UE43RXpKb1JIY0luYlZrbHR2aGxE?=
 =?utf-8?B?enRzVTNkVTFvczMyTW83ZE1Uek53Vy83T0N3bE9LK2g5QXI5a01LRm9weFg2?=
 =?utf-8?B?d2VvTG9YQXhER1pyTlo1YXVHSTFRQWJLZHFNODVwbmcrNm1RSnc4bmpJQjhB?=
 =?utf-8?B?MHN0UzJnZ2M5TGo1Q3A1cjVycDlJSkhOMnBvclV0S2dGbE1kWk1wRGx4V3dy?=
 =?utf-8?B?TW5NSWpjeXozNXpUM1I3TXBJRFVlc2ZCMGFHSmdDOWVRcEI4em4zaFYzZXk3?=
 =?utf-8?B?cHN5UGl2R1ZTRTJ6dERHOWtzc2UxNDZxTmQxOTBRTWtXemlOcFhrbC8vVTZo?=
 =?utf-8?B?dm1lRlBQYmJpS0w3NjJnbnJWSVA1dlBueVFuK2lSdjgwNS9uNGVVTWFFSENB?=
 =?utf-8?B?UlhOWVZQWGd5UE44L1FIS2JJbjQvd3VoYzBCZFAvYTlhSGJ4SnUyK25BVG04?=
 =?utf-8?B?b0lhblo4cVl6M0hpWEtVUzJzV3VXN0hEaHNVbUk1U0Y2SEtBWlcwYmJvb3E2?=
 =?utf-8?B?VXBvS2lZYm5OdWNBVnM1cnlyZCtsWmMyY05OM3Buak1rd1ZTUmpsUThXVncz?=
 =?utf-8?B?K2dreGx4emRzWUtPSURSSk9xRkZXNnFOOFdaSXZUbVk0UklITk56NjM2Tktv?=
 =?utf-8?B?a1NJSC93VVZETU5zWUxia20zV2d3bFJlRllpaS9DeVhPc3FzdU1UenMwQm9y?=
 =?utf-8?B?RmVrZHF0bnVmZnZrMGxuNmxqd3pQZGJ3bUZkRUlWSjBsdG5pdXk2S2JZRkRQ?=
 =?utf-8?B?SWpGL3B3TTlkTHh2WEdFRURMY2JXckI3SStZelY2R1pnZGQzL3RTdE12dmZW?=
 =?utf-8?B?TzRZN0diaXd3emFsSm53NklBblVGZ0FVeG0xc1NXS1Q2RXZqaTNnQTh3M3dk?=
 =?utf-8?B?WkpHRjZkVFYzZkFKMlVBQ04xaUhuMnNuZ1d2cnNMUEdsUHd1R1UwNCt6Yk9D?=
 =?utf-8?B?MElmVE9xUVA4TStuNENRYXpQLzRqeitxRFlsTHpYbU8wb3I4U1owWTg1MkxV?=
 =?utf-8?B?RStJTFExRUcxckMwM1R3aEhZM1R2ZlNXeDZMNjFUdzREdnhOQy8zYXV1dURD?=
 =?utf-8?B?cVE2RDZMZXZNVkRxa0lPQ3FESmgrQzlKOTFvUS9GRUpwaUZUNEhtd0ZvREx3?=
 =?utf-8?B?T2tJVitROFhRdm5keE1ZZHgyR0NDNVl6NWI1eTdrNjMrM0x3VEdhem1kVVRP?=
 =?utf-8?B?WjkwZ1B0VFBsOUJvbjBRSWs5Wnl4eDl4U0lrQmpjWXVtYmd1SVBhL1VSWm9i?=
 =?utf-8?B?ZlAwcEdRMThjc2FBNlcvQ2RFY1pjU3FZMHlHWXd3eU4xcVBxSE5ISFQ1YTU5?=
 =?utf-8?B?YmZCN2lTNDFKZEJCc294UWw2SUw1MzloZEY5bEt6T2NYbHlDYW5TOXBtdFRs?=
 =?utf-8?B?ZjlWOTFhUWZNRFVxa25yUU9DQ0kzaTI2OGRaZk5HOTBGemJoZkxtRDUrMDdq?=
 =?utf-8?B?b0o1Q3JiUmtFOVBud1JZcVBwa1NqbSs2d2l6OFVxdzlpNWRTRXJyeWkwZENM?=
 =?utf-8?B?VVdiL2M2bmpvWXgyMnBtRFN2RVBtV2ZTWjNIcUJXbmR5emY1YkpBN0ZGWjhN?=
 =?utf-8?B?N3BUOU9PZHk4MUdWaksyQ2s4cThEVC9qVGhuaEZ4UEZBRUJ3WHJaak4wTkNn?=
 =?utf-8?B?M2c9PQ==?=
Content-ID: <6E6A5936FA65D24788ED7F88113601C1@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ca/3iswJG+TFOniaHbhhwrmUD3LQ1DAmbHzzn3L+tedApMHiumZl51eef3FCHDDCVjpHHQ7HWqR8CQ/oZ7IPe87H4r7K/C+/C3l7/dj+4J8CWkBP8oJf99ZaOXECStCWRuEYcwM7WrHUCdO8eoH0liU5GqNbrqoOGc5R5Ifc4mJZaa564XEvDfElnW3M7QsCWUXMi/ZtFOWYoMi9WZnRWSO7PpcOAQg0+e0fHlf5ZCUEEan1Rf2bvfa7tfizCE3a7JuiQEkLebLfNReB2zpR4NwEvH7Qq+IjcuRRn08oK3gzjMhJZmY2EPCiWMk6BB1n881d/qYTJJe+TVPp+8C/36Qe4i2KWbuYorxY4QgKR6r4gmirpc5SQRnCLZByq+TwD5Kh+orXEjbcL1K5VSOGQLp7xWA4FLBYI3bEaKJaVRwsEHTt8kPscri9hVGKcndfNcfcs7KFUd45DR2lTx5pY0gBLGWukWhymosi6KBUstW9ApHCiJGSwx4sdJOa/2WvOqdtazhOzTOsvQPyV6RRBnHP7o7FdU0A2nptIJx4Ftb8rSh0Y1Ts2CFdmEy1H971+UZ0XffagUrUXh0VGCik8zZldh9dJLY09xIZAMUTdfKKnD8FQqccY4AYes1JkrA0WcSxxj83Rm095wvgv+uOfxppwFVdsRnugzKVirwatWlf7TUfqVIbtKRjhY32fptB/xI3b9mvsEB9mERZJPF5iQ==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee7f7e5-07f3-47c3-5ff3-08da7e9825a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 08:28:35.7823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3XMHGfDv6r9TSgxro5SblZD+7kXM0+K2j/IhaCJqh/diMaWowzTNAMCQvIJlLdMxNuFaazz2LJHNea++NoSviELn+Dh8cwVqZrP35/O6DPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8119
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/prctl10: Add basic test for
 PR_SET/GET_TSC
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

Any comment?

Best Regards
Yang Xu
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   include/lapi/prctl.h                       |   7 ++
>   runtest/syscalls                           |   1 +
>   testcases/kernel/syscalls/prctl/.gitignore |   1 +
>   testcases/kernel/syscalls/prctl/prctl10.c  | 112 +++++++++++++++++++++
>   4 files changed, 121 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/prctl/prctl10.c
> 
> diff --git a/include/lapi/prctl.h b/include/lapi/prctl.h
> index fa5922231..8d3ef5c32 100644
> --- a/include/lapi/prctl.h
> +++ b/include/lapi/prctl.h
> @@ -19,6 +19,13 @@
>   # define PR_SET_SECCOMP  22
>   #endif
>   
> +#ifndef PR_SET_TSC
> +# define PR_GET_TSC 25
> +# define PR_SET_TSC 26
> +# define PR_TSC_ENABLE  1
> +# define PR_TSC_SIGSEGV 2
> +#endif
> +
>   #ifndef PR_SET_TIMERSLACK
>   # define PR_SET_TIMERSLACK 29
>   # define PR_GET_TIMERSLACK 30
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 36fc50aeb..a0935821a 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1004,6 +1004,7 @@ prctl06 prctl06
>   prctl07 prctl07
>   prctl08 prctl08
>   prctl09 prctl09
> +prctl10 prctl10
>   
>   pread01 pread01
>   pread01_64 pread01_64
> diff --git a/testcases/kernel/syscalls/prctl/.gitignore b/testcases/kernel/syscalls/prctl/.gitignore
> index 0f2c9b194..50ee4bf60 100644
> --- a/testcases/kernel/syscalls/prctl/.gitignore
> +++ b/testcases/kernel/syscalls/prctl/.gitignore
> @@ -8,3 +8,4 @@
>   /prctl07
>   /prctl08
>   /prctl09
> +/prctl10
> diff --git a/testcases/kernel/syscalls/prctl/prctl10.c b/testcases/kernel/syscalls/prctl/prctl10.c
> new file mode 100644
> index 000000000..1b6791679
> --- /dev/null
> +++ b/testcases/kernel/syscalls/prctl/prctl10.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Basic test to test behaviour of PR_GET_TSC and PR_SET_TSC.
> + *
> + * Set the state of the flag determining whether the timestamp counter can
> + * be read by the process.
> + *
> + * - Pass PR_TSC_ENABLE to arg2 to allow it to be read.
> + * - Pass PR_TSC_SIGSEGV to arg2 to generate a SIGSEGV when reading TSC.
> + */
> +
> +#include <sys/prctl.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <setjmp.h>
> +#include "tst_test.h"
> +#include "lapi/prctl.h"
> +
> +#define TCASE_ENTRY(tsc_read_stat) { .name = #tsc_read_stat, .read_stat = tsc_read_stat}
> +
> +static int pass;
> +static sigjmp_buf env;
> +
> +static const char *tsc_read_stat_names[] = {
> +	[0] = "[not set]",
> +	[PR_TSC_ENABLE] = "PR_TSC_ENABLE",
> +	[PR_TSC_SIGSEGV] = "PR_TSC_SIGSEGV",
> +};
> +
> +static struct tcase {
> +	char *name;
> +	int read_stat;
> +} tcases[] = {
> +	TCASE_ENTRY(PR_TSC_ENABLE),
> +	TCASE_ENTRY(PR_TSC_SIGSEGV)
> +};
> +
> +static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
> +{
> +	pass = 1;
> +	TST_EXP_PASS_SILENT(prctl(PR_SET_TSC, PR_TSC_ENABLE));
> +	siglongjmp(env, 1);
> +}
> +
> +static uint64_t rdtsc(void)
> +{
> +	uint32_t lo, hi;
> +	/* We cannot use "=A", since this would use %rax on x86_64 */
> +	__asm__ __volatile__ ("rdtsc" : "=a" (lo), "=d" (hi));
> +	return (uint64_t)hi << 32 | lo;
> +}
> +
> +static void verify_prctl(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	unsigned long long time1, time2;
> +	int tsc_val = 0;
> +
> +	TST_EXP_PASS_SILENT(prctl(PR_SET_TSC, tc->read_stat));
> +	TST_EXP_PASS_SILENT(prctl(PR_GET_TSC, &tsc_val));
> +	if (tsc_val == tc->read_stat)
> +		tst_res(TPASS, "current state is %s(%d)",
> +				tc->name, tc->read_stat);
> +	else
> +		tst_res(TFAIL, "current state is %s(%d), expect %s(%d)",
> +				tsc_read_stat_names[tsc_val], tsc_val, tc->name, tc->read_stat);
> +
> +	if (tc->read_stat == PR_TSC_SIGSEGV) {
> +		if (sigsetjmp(env, 1) == 0)
> +			rdtsc();
> +
> +		if (pass)
> +			tst_res(TPASS,
> +				"get SIGSEGV signal under PR_TSC_SIGSEGV situation");
> +		else
> +			tst_res(TFAIL,
> +				"don't get SIGSEGV signal under PR_TSC_SIGSEGV situation");
> +		pass = 0;
> +	}
> +
> +	time1 = rdtsc();
> +	time2 = rdtsc();
> +	if (time2 > time1)
> +		tst_res(TPASS, "rdtsc works correctly, %lld ->%lld",
> +			time1, time2);
> +	else
> +		tst_res(TFAIL, "rdtsc works incorrectly, %lld ->%lld",
> +			time1, time2);
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_SIGNAL(SIGSEGV, sighandler);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test = verify_prctl,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.supported_archs = (const char *const []) {
> +		"x86",
> +		"x86_64",
> +		NULL
> +	},
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
