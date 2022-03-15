Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BEFC433F5
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 01:31:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D22C3CA816
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 02:31:24 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B966B3C4EDD
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 02:31:12 +0100 (CET)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EA9D41A0079C
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 02:31:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1647307871; x=1678843871;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=08lnOjXeREt2wJJKzMHFys+ofEh/fZxXnmxzd2noYys=;
 b=KFrqSsFKF3on1NZTQP8Ng4eIWuivjqtqvJxy+vv/M+XDZXjzI8Xsvojt
 tNAm1bQV4o9flhAB0tVEVWvpCF8+57EC3+OP6tz1eldT+uRK3B98AmNZr
 DMH9k3refm97XiA5ZLJvJ7IwSyWDRxwuFwGGBqRkfJGXmg3lhoTBYKfUm
 97XmxgH4PyiaK1F7xseOMD8PDWEL3kXCCCFmD5md4EPhT+TqAfJP7ezk8
 LXlom8hb7TDgl5D83mcN9PaN1kFFYutQyzPDmnJL2VeURjwVKBAJJTpGo
 Iy8EJhZcNsIi8VwBI4Nco9qS2mPihLbGljy1unyX2+lN+oHf6svCA1eWd g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="52021615"
X-IronPort-AV: E=Sophos;i="5.90,182,1643641200"; d="scan'208";a="52021615"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 10:31:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ojb8Zv6xLwKY2pu6Kf7JgvMQVMur0dCuHhiCu09rRnQmVrQzySxUlKtllqOFnJIFZJCRenqJOox31fOmGf4dC4JvDSeQIwnBwdrvAyWfDhQg7L9VM6/igP+NcXZFciolfUcwZX8nWkpmimE0gaAu1CwgVFnkvQW0HL3+WUZ98jU3gKcAf6Lf5ytw5iJvnGS1X4TkUaThSXtEYAxKX/Vc0eyYYJMh9u8nNs6Crog4QV6wSGxXUE8MIsO1keTCDGxoSt/HRXzE9XIEVsaar2CVveCQu/ym474doFvSxZVCDu5CFmO2MSDfGLBps4PwwxnoEB5gQqpT0IpNPX792C2EYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08lnOjXeREt2wJJKzMHFys+ofEh/fZxXnmxzd2noYys=;
 b=bJ9UM7lH7SqrFrWAdqUb77FJTlcdEz4cKHPKlDtwx3KZKM0EwHJ59MpHzoESaStRUWi8ubHYCrymLSvaTcw7MBnNUEllPz/JGdKNUMzqLXn7dS5fWZH23+7ToojPCsAsEawb+Ctbif8dpPt48+BCZtzuygxO4Dn2+uHYRWPVpLS6jP/TWweY2BGN0pUmzfUZfgUpjv+/KICzeYAu5cN9LTSyxuHPplfI76/dayjHnpf2cejdbL8BWxga1DYEsnN8zUWAIR5fEe04NFybKtz7InfRclACurjiZP+YLKpNG7DNbBuVQHOzOkIqdD8VQI1yZTreR5CkUnj0Gi6UXauzzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08lnOjXeREt2wJJKzMHFys+ofEh/fZxXnmxzd2noYys=;
 b=gLe0H/GksNWzgcFmStOt8zbFgNoIsuFGOMjdRZ83ZkfN8bKJT3EP9hcNOUBQXZhSXqHees5xnjdC/5VL7YcCn0Bbj9nkUccpRqNWaPM+T1W6JG9VJ6q2NO4wJDo+7Q4OBY0IMEaFcxRcij8zL16islLVDrR3otKxf4+azujRFXM=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYYPR01MB6841.jpnprd01.prod.outlook.com (2603:1096:400:d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Tue, 15 Mar
 2022 01:31:06 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 01:31:06 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH 1/1] quotactl: Check for missing quota_v2 module
Thread-Index: AQHYN6PUsntQNXYrD0ugd2TDll9RDKy/qZ0A
Date: Tue, 15 Mar 2022 01:31:06 +0000
Message-ID: <622FEC88.1040502@fujitsu.com>
References: <20220314130248.22869-1-pvorel@suse.cz>
In-Reply-To: <20220314130248.22869-1-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 786de90e-fdb0-450e-9426-08da06237a16
x-ms-traffictypediagnostic: TYYPR01MB6841:EE_
x-microsoft-antispam-prvs: <TYYPR01MB684101948465167419F36EC6FD109@TYYPR01MB6841.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kr7Bi3PVdTopXH7PUyaQLD0Pj0VAcm1mp5EGQKYcvpbCj3rlfKf4w6fH/tvjCat0QvCjht2NHMeb/PmKdANX2hGov4I75166q8lI5+pZt1MWQpaY3atc1cf1Ti3Y5gRfPNuo3PbKSXEyaPbwziRjKDjT9qGwRMPxcArYqgQsqnM+bAjaRm+5h+t/yJo1uLKjydRV3unI38PDospc9iPINYLQnkyJ4/JhazBzQSGmKGKr2+vtZnp5kqu1sQPAtn+54tIQnQwk0QuEHTgHT7HdkzgIID5NQQ7Mox8Wo2QJkFJwIUWQ8LXhMEYRfY1ex0yAXUievfg0DBMYRCPiYhzcf3DHtVW8XupDG4DQSOKaqywUW1EODgonqLqKAS+5trFFNRGUSUAqEAiXSPNhpB06dvhUNaeTAgRRqLqhlBJ+EmBBBAWA4iGL+93LT4w2+O1W+c26XP6su1Y3YjQWZYmqawINlVSizdksIQHkMg/F7NmDx5J453UtknZQM6CuuUjOdh8SEHqhYP84Rzya/A8EIpMWrHsDvIQJyfN24KcCkNJ3FMdZwbEktkR/aj4Cy2IRvl7bdUT8dR97ItPEZz05sCVVw7VaQveXBMJbA2sXJ9rC7FaedW56vwwgdumRnnDgf5GHJvulsmMVjDfKpgxZS6BxFRfPqX1rjXHvTgmNrZYnwd7HCCFg907YgL7fOw1ATLv7b7SIczwp5CoZTqheA7ymsnJiCpjU7hCx4JsCu83D3yAcCWvuJBRsGcb9sTBkY0OUMsU4qb+5GyGk1Gz34oK3E9bRlf4sOGDZj31h/0s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(5660300002)(66476007)(91956017)(66446008)(508600001)(6916009)(87266011)(2616005)(186003)(54906003)(8676002)(64756008)(76116006)(66556008)(66946007)(83380400001)(6486002)(966005)(2906002)(71200400001)(122000001)(38070700005)(33656002)(82960400001)(85182001)(6506007)(6512007)(26005)(38100700002)(86362001)(15650500001)(8936002)(316002)(36756003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?T2Z3ay9VaDgvZFcyeDc0cG1QUEJITVI5N0c4TUpZeHJYVXZsV0d2cXN3dUM5?=
 =?gb2312?B?NFNvZVVkdVl4eC9WZVVFSXorYWo0ZWZFdmpKc1hJa2FBTm54cWNndXM2clFL?=
 =?gb2312?B?K2FUUVd1NmJxRzVnU2tvMU02K2dsYWpPTmpKZ2lwa1E4STI1bGFvWDAyanBo?=
 =?gb2312?B?THdjMm5QZjJTdGNRT2FmakMvQXBVSnhYNjR0UEUyL2ZyZzJja0VGditUZk15?=
 =?gb2312?B?aHRpNy9UcWwyOFFqaXpsVzZBZVo1ZGJCTWxhVG5LN25ubXZqcnNCb0R2eUxU?=
 =?gb2312?B?ZHhRMTBNaWRzMFdCVi9hQld6UjRCd3Q4QlhSOG5hTFl5UkVyL2licGNrcHRQ?=
 =?gb2312?B?SHA1OE9ISldwOXpmRStPUVZJRzFZRHNVNks5UWpXdEY0ak43T3lWZFE4cGpW?=
 =?gb2312?B?VFVOUGdCTWpPR2V3UXVSRFB5aHF0ZWZibVhzSmxmNUQzR09NT25WU0djSmdv?=
 =?gb2312?B?Y1U3VGl5TmUxZHJHam1kRHo5MzBLMVBPLzMwWWE4V2kyYmFnRnBaeXFqaWN4?=
 =?gb2312?B?YURzbUZxdHJCckJPejBIUzZ0UTcwQ3U2S0ZFU0VIY2gzdjcwbGg4RFhHUHFv?=
 =?gb2312?B?RUZkQzlHWTRHZnpTc0haemtXeFpvWDFkTUdwL2IrbjNZVktmWmpqTk4yNkwv?=
 =?gb2312?B?VWFUZXFadFljYnU2bG1ubU1kNWVqakx4VG9KWmlmd1J2NlRUcDIyWWZtMkZi?=
 =?gb2312?B?MldVQXAxajgzbUx2Zk5aMldCNTBCVis1MlptR1kxTjl3RTE4ZVczeEh5UG9t?=
 =?gb2312?B?WGJ5enE3UHA3cjZ4OFFNYTlBOTFiMXNXNG9jdENTU1JjLzE5amRSWUYrNWNJ?=
 =?gb2312?B?Q1pTRXhnY1NXOERPWnRYT0NJSUt1aktFRDdnai83b3lob1FRVnZnZGJRNisz?=
 =?gb2312?B?Z2hWNEFJU05ZVHBkbm9kSTRHVks0VWVzNllyd29TemdpMjV4NEZhUGNkSU13?=
 =?gb2312?B?UzRsNkRXeGwwU3JadG9EY0doNThUYkZjYWZmWGN1M3FpeGJyOEEyL0ZiS01s?=
 =?gb2312?B?ODlja1hqOGRhWTRJeTFMQVo0NGRHL3h0S2xudDF5REYvZlRocGpNRGlYT1FI?=
 =?gb2312?B?T241WTByTk5nVUhBVThFTzNkSDNOZUFuNzc5Z0ZNOFFpUUFPbmZva21uUWQ3?=
 =?gb2312?B?a0wrSXNuVVlGQXZpT2RnczZMMENJMmdLM1hpNHFJc2J1K09iL1YwZDEwLzJI?=
 =?gb2312?B?aUxqKzVaRVZQRkNQZUhSbUw2ZlJjTUNwYmxnYUhFcVhhWUwxUk9RbzZSd1BV?=
 =?gb2312?B?Q3lQWEl6Uzh3a01qQ1BNSWJZeFAzUkhnTUxnUnpmRjFSWmJWSDhuOFhEbVlp?=
 =?gb2312?B?L3laYzNMbzRoa2RzWU9QVVRFSTdLN0FSYUl1NXljVlk3UitKN0VzTElyQ3hV?=
 =?gb2312?B?N2hJM3RqaFlCcERncWdmNUxKaFlGUVluL3V6UmVYVTdqZTBJUXlERnNwYjRs?=
 =?gb2312?B?TXhIR053V0IvSHZRTjR1cGxRSVBKREFOVHQvK2I0Nkh3cDRsQ3J4U1NuMTlC?=
 =?gb2312?B?RzZHRzdZcEl1VjVDc2ZLRnFJczNkdUJkem5xRTZXL2FkaERpRzloWlRjVFBS?=
 =?gb2312?B?MXhZQkU2L0NyOTNRRXprQ2V3cFBjZlhkLzVlTEdWQkdBY2xOK0xHUmFVSW5R?=
 =?gb2312?B?ZVlFakJXNDNZdWxteU9nTHFnOW9wTTRBNnBpQ1JYa2NqNmZ6WnBCOEJ3L0tX?=
 =?gb2312?B?YXlQODhyUEk5Zi9GZWxjanlXZGdvYlhmaXNtRFE2WDNSNjRvMTIwK1owWEUw?=
 =?gb2312?B?a2xDNUR4VlYrTFp0NW04V2lEdWdTcVhlWVlvUXprNXdibHNjWHRDNTNrTkN0?=
 =?gb2312?B?d0JMUHo2SU1KRUNPRUEwNHVBUlIvaE9uOUp2TDBWU05yb0duSVh5TDVSL3F0?=
 =?gb2312?B?MFprcWdDK0JPclBUOElTS1lFN1ZRZm8wU0FlaHVta0ZmcG5pMWZlMkhXZDg0?=
 =?gb2312?B?ZWg3TndxMGxBZ29hcWxNeitOeEhYODNXdHExZ0tFOHRrVkszckxDcFkyV0Zw?=
 =?gb2312?Q?io3zpils36VaTEM6oQBShSK9DEyJlQ=3D?=
Content-ID: <0A8C9170953F7D40A5CF2A17C56ADE6E@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786de90e-fdb0-450e-9426-08da06237a16
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 01:31:06.7956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FS31S0Lv1Qx5kRQmG43yZ68d5bJ9I6sRH3uNFtOGsIU3e4BsAOrNbhZK7Hh5WLdvJyRW0lvM0r/ccDlWtJcIFVlZMkd75JkNNmx1PtOmASE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6841
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] quotactl: Check for missing quota_v2 module
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
Cc: Martin Doucha <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

If so, why not remove kconfig check for these cases?

Best Regards
Yang Xu
> openSUSE JeOS allowed installation without quota_v2 (they were in
> kernel-default, but by default kernel-default-base with smaller subset
> of kernel modules is installed).
> 
> Therefore check for the module for all tests which require CONFIG_QFMT_V2
> config.
> 
> Fixes: https://bugzilla.opensuse.org/show_bug.cgi?id=1196585
> 
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
>   testcases/kernel/syscalls/quotactl/quotactl01.c | 4 ++++
>   testcases/kernel/syscalls/quotactl/quotactl04.c | 4 ++++
>   testcases/kernel/syscalls/quotactl/quotactl06.c | 4 ++++
>   testcases/kernel/syscalls/quotactl/quotactl08.c | 4 ++++
>   testcases/kernel/syscalls/quotactl/quotactl09.c | 4 ++++
>   5 files changed, 20 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
> index 561e5030fe..f06e18edca 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl01.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
> @@ -217,6 +217,10 @@ static struct tst_test test = {
>   		"CONFIG_QFMT_V2",
>   		NULL
>   	},
> +	.needs_drivers = (const char *const []) {
> +		"quota_v2",
> +		NULL
> +	},
>   	.test = verify_quota,
>   	.tcnt = ARRAY_SIZE(tcases),
>   	.mount_device = 1,
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
> index 55da282705..bb2d899f0e 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl04.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
> @@ -166,6 +166,10 @@ static struct tst_test test = {
>   		"CONFIG_QFMT_V2",
>   		NULL
>   	},
> +	.needs_drivers = (const char *const []) {
> +		"quota_v2",
> +		NULL
> +	},
>   	.min_kver = "4.10", /* commit 689c958cbe6b (ext4: add project quota support) */
>   	.test = verify_quota,
>   	.tcnt = ARRAY_SIZE(tcases),
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
> index 87715237f5..8c75c87b06 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl06.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
> @@ -220,6 +220,10 @@ static struct tst_test test = {
>   		"CONFIG_QFMT_V2",
>   		NULL
>   	},
> +	.needs_drivers = (const char *const []) {
> +		"quota_v2",
> +		NULL
> +	},
>   	.tcnt = ARRAY_SIZE(tcases),
>   	.test = verify_quotactl,
>   	.dev_fs_type = "ext4",
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
> index 3793867f23..ae6e582be0 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl08.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
> @@ -212,6 +212,10 @@ static struct tst_test test = {
>   		"CONFIG_QFMT_V2",
>   		NULL
>   	},
> +	.needs_drivers = (const char *const []) {
> +		"quota_v2",
> +		NULL
> +	},
>   	.test = verify_quota,
>   	.tcnt = ARRAY_SIZE(tcases),
>   	.mntpoint = MNTPOINT,
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl09.c b/testcases/kernel/syscalls/quotactl/quotactl09.c
> index 8b959909ca..12d331b1a0 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl09.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl09.c
> @@ -174,6 +174,10 @@ static struct tst_test test = {
>   		"CONFIG_QFMT_V2",
>   		NULL
>   	},
> +	.needs_drivers = (const char *const []) {
> +		"quota_v2",
> +		NULL
> +	},
>   	.tcnt = ARRAY_SIZE(tcases),
>   	.test = verify_quotactl,
>   	.dev_fs_opts = (const char *const[]){"-O quota", NULL},

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
